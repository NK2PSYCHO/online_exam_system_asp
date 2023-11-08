using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/* Libraries Added To Help With SQl Server And Querying DataBase */
using System.Data.SqlClient;
using System.Data;

namespace ExamModuleASP.Forms
{
    public partial class MCQTest : System.Web.UI.Page
    {
        /* Global Connection String Created So It Can Be Used ThrouOut Class */
        SqlConnection Conn = new SqlConnection(@"Data Source=NK2PSYCHO;Initial Catalog=ExamModule;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            /* Checking If Session Variables Of Email-Id And Password Are Null (Helps When Someone Tries To Dierctly Access This Page Without LogIn) */
            if (Session["Email"] == null || Session["Pass"] == null)
            {
                /* If Verification Fails Redirect To LogIn Page */
                Response.Redirect("LoginPage.aspx");
            }
            /* Setting And Formatting TimeSpan Variable With Value Of Interval Of Exam As HH:mm:ss */
            TimeSpan t = TimeSpan.FromSeconds(Convert.ToInt32(Session["Interval"]));
            lbl_countdown.Text ="Time Left  " + string.Format("{0:D2}h:{1:D2}m:{2:D2}s",
                            t.Hours,
                            t.Minutes,
                            t.Seconds);
            /* Checking If The Label Displays Current Time */
            if (lbl_time.Text != DateTime.Now.ToString("HH:mm:ss"))
            {
                DateTime old = DateTime.Now;
                /* If Not Then To Make Sure Label Displays Current Time */
                if (!String.IsNullOrEmpty(lbl_time.Text))
                {
                    old = Convert.ToDateTime(lbl_time.Text);
                }
                lbl_time.Text = DateTime.Now.ToString("HH:mm:ss");
                /* Checking If The Countdown Ended */
                if (Convert.ToInt32(Session["interval"]) == 0)
                {
                    /* If So Call Submit Button's Click Event */
                    btn_sub_Click(btn_sub, null);
                }
                else
                {
                    /* If Not Reduce The Interval Time */
                    Session["Interval"] = Convert.ToInt32(Session["Interval"]) + Convert.ToInt32((old - DateTime.Now).Seconds);
                }
            }
            if(rbl_Options.SelectedIndex>-1)
            {
                Session["Curr_ans"] = Convert.ToString(rbl_Options.SelectedValue);
            }
            if (!IsPostBack)
            {
                Session["Marks"] = 0;
                /*As This Will Be The First Question Clear The TextBox And Disable As Well Hide Previous And Submit Button(Submit Button In Case More Than One Question Exists)*/
                btn_sub.Enabled = false;
                btn_sub.Visible = false;
                btn_prev.Enabled = false;
                btn_prev.Visible = false;
                /*Retrieving Schedule Id And Student Id For Querying*/
                int sch = Convert.ToInt32(Session["Schedule"]);
                int std = Convert.ToInt32(Session["StudId"]);
                /*Statements and Query To Check If any Answer Exists For The Given Student For The Given Schedule*/
                string query = "SELECT Answer FROM TBL_MCQAnswer WHERE Schedule_ID = " + sch + " AND Stud_ID = " + std + "";
                SqlDataAdapter da = new SqlDataAdapter(query, Conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                /*If more than one value return The Student Has Already Attempted*/
                if (dt.Rows.Count >= 1)
                {
                    /*If Attempted Show JavaScript Alert And Redirect To HomePage*/
                    Response.Write("<script> alert('You Already Have Attempted The Test\\r\\nAnswers Were Recorded Successfully');window.location='HomePage.aspx'; </script>");
                }
                /*Statements and Query To retrieve And Display First Question With Its Options*/
                SqlDataAdapter da1 = new SqlDataAdapter("SELECT * FROM TBL_MCQNA WHERE Schedule_ID='" + Session["Schedule"].ToString() + "'", Conn);
                DataTable dt1 = new DataTable();
                da1.Fill(dt1);
                DataRow row = dt1.Rows[0];
                Session["QID"] = row[0].ToString();
                lbl_que.Text = row[2].ToString();
                /*Statements To Populate RadioButtonList*/
                var optlist = new List<ListItem>();
                for(var i=3;i<7;i++)
                {
                    var newItem = new ListItem()
                    {
                        Value = Convert.ToString(row[i]),
                        Text = Convert.ToString(row[i])
                    };
                    optlist.Add(newItem);
                }
                Session["Answer"] = Convert.ToString(row[7]);
                rbl_Options.DataSource = optlist;
                rbl_Options.DataBind();
                /*Variable i Set to The Index Value Of First Question*/
                Session["i"] = 0;
                /*To Check If Only ONe Question Exists In Exam*/
                if (Convert.ToInt32(Session["i"]) == dt1.Rows.Count - 1)
                {
                    /*If So Show And Enable The Submit Button And Do The Vice Versa With Next Button*/
                    btn_sub.Enabled = true;
                    btn_sub.Visible = true;
                    btn_next.Enabled = false;
                    btn_next.Visible = false;
                }
            }
        }

        protected void btn_next_Click(object sender, EventArgs e)
        {
            Conn.Open();
            /* Retrieving Id Of Current Question And Schedule With The Id Of Student */
            int qid = Convert.ToInt32(Session["QID"]);
            int sch = Convert.ToInt32(Session["Schedule"]);
            int std = Convert.ToInt32(Session["StudId"]);
            /* Check If The Student Has Answered The Current Question Before */
            string query = "SELECT Answer FROM TBL_MCQAnswer WHERE Schedule_ID = " + sch + " AND Stud_ID = " + std + " AND Question_ID = " + qid + "";
            SqlDataAdapter da = new SqlDataAdapter(query, Conn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            /* If Not Answered */
            if (dt.Rows.Count == 0)
            {
                /* Insert A New Row In The Database */
                if (rbl_Options.SelectedIndex>=0)
                {
                    string insert_query = "insert into TBL_MCQAnswer (Schedule_ID,Stud_ID,Question_ID,Answer) values (" + sch + "," + std + "," + qid + ",'" + Convert.ToString(rbl_Options.SelectedValue) + "')";
                    SqlCommand cmd = new SqlCommand(insert_query, Conn);
                    cmd.ExecuteNonQuery();
                        Session["Curr_Ans"] = Convert.ToString(rbl_Options.SelectedValue);
                        if (Convert.ToString(Session["Answer"]) == Convert.ToString(rbl_Options.SelectedValue))
                        {
                            Session["Marks"] = Convert.ToInt32(Session["marks"]) + 1;
                        }
                        else
                        {
                            Session["Marks"] = Convert.ToInt32(Session["marks"]) - 1;
                        }
                }
                else
                {
                    string insert_query = "insert into TBL_MCQAnswer (Schedule_ID,Stud_ID,Question_ID,Answer) values (" + sch + "," + std + "," + qid + ",'" + "Default" + "')";
                    SqlCommand cmd = new SqlCommand(insert_query, Conn);
                    cmd.ExecuteNonQuery();
                }
            }
            /* If Answered */
            else
            {
                /* Update The Current Answer In The Database */
                if (rbl_Options.SelectedIndex >= 0)
                {
                    string update_query = "update TBL_MCQAnswer set Answer = '" + Convert.ToString(rbl_Options.SelectedValue) + "' where Schedule_ID = " + sch + " AND Stud_ID = " + std + " AND Question_ID = " + qid + "";
                    SqlCommand cmd = new SqlCommand(update_query, Conn);
                    cmd.ExecuteNonQuery();
                    if (Convert.ToString(Session["Curr_ans"]) != Convert.ToString(rbl_Options.SelectedValue))
                    {
                        if (Convert.ToString(Session["Answer"]) == Convert.ToString(rbl_Options.SelectedValue))
                        {
                            Session["Marks"] = Convert.ToInt32(Session["marks"]) + 1;
                        }
                        else
                        {
                            Session["Marks"] = Convert.ToInt32(Session["marks"]) - 1;
                        }
                    }
                }
            }
            /*Setting The Index To -1 So The Selection Does Not Carry On*/
            rbl_Options.SelectedIndex = -1;
            /*Statements and Query Required To View NExt Question */
            SqlDataAdapter da1 = new SqlDataAdapter("SELECT * FROM TBL_MCQNA WHERE Schedule_ID='" + Session["Schedule"].ToString() + "'", Conn);
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            int i = Convert.ToInt32(Session["i"]);
            i++;
            /* If More Question Exists */
            if (i < dt1.Rows.Count)
            {
                DataRow row = dt1.Rows[i];
                Session["QID"] = row[0];
                lbl_que.Text = row[2].ToString();
                /*Statements To Populate RadioButtonList*/
                var optlist = new List<ListItem>();
                for (var j = 3; j < 7; j++)
                {
                    var newItem = new ListItem()
                    {
                        Value = Convert.ToString(row[j]),
                        Text = Convert.ToString(row[j])
                    };
                    optlist.Add(newItem);
                }
                Session["Answer"] = Convert.ToString(row[7]);
                rbl_Options.DataSource = optlist;
                rbl_Options.DataBind();
            }
            /* If Last Question Exists */
            if (i == dt1.Rows.Count - 1)
            {
                /*If So Show And Enable The Submit Button And Do The Vice Versa With Next Button*/
                btn_sub.Enabled = true;
                btn_sub.Visible = true;
                btn_next.Enabled = false;
                btn_next.Visible = false;
            }
            /* If Not First Question Exists */
            if (i > 0)
            {
                btn_prev.Enabled = true;
                btn_prev.Visible = true;
            }
            /*Statements and Query Required To View The Answer Of The Next Question If One Exists In Database */
            qid = Convert.ToInt32(Session["QID"]);
            Session["i"] = i;
            query = "SELECT Answer FROM TBL_MCQAnswer WHERE Schedule_ID = " + sch + " AND Stud_ID = " + std + " AND Question_ID = " + qid + "";
            SqlCommand comm = new SqlCommand(query, Conn);
            SqlDataReader DR1 = comm.ExecuteReader();
            if (DR1.Read())
            {
                string answer = Convert.ToString(DR1.GetValue(0));
                if (answer != "Default")
                {
                    rbl_Options.SelectedValue = answer;
                }
            }
            Conn.Close();
        }

        protected void btn_prev_Click(object sender, EventArgs e)
        {
            Conn.Open();
            /* Retrieving Id Of Current Question And Schedule With The Id Of Student */
            int qid = Convert.ToInt32(Session["QID"]);
            int sch = Convert.ToInt32(Session["Schedule"]);
            int std = Convert.ToInt32(Session["StudId"]);
            /* Check If The Student Has Answered The Current Question Before */
            string query = "SELECT Answer FROM TBL_MCQAnswer WHERE Schedule_ID = " + sch + " AND Stud_ID = " + std + " AND Question_ID = " + qid + "";
            SqlDataAdapter da = new SqlDataAdapter(query, Conn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            /* If Not Answered */
            if (dt.Rows.Count == 0)
            {
                /* Insert A New Row In The Database */
                if (rbl_Options.SelectedIndex >= 0)
                {
                    Session["Curr_Ans"] = Convert.ToString(rbl_Options.SelectedValue);
                    string insert_query = "insert into TBL_MCQAnswer (Schedule_ID,Stud_ID,Question_ID,Answer) values (" + sch + "," + std + "," + qid + ",'" + Convert.ToString(rbl_Options.SelectedValue) + "')";
                    SqlCommand cmd = new SqlCommand(insert_query, Conn);
                    cmd.ExecuteNonQuery();
                    if (Convert.ToString(Session["Answer"]) == Convert.ToString(rbl_Options.SelectedValue))
                    {
                        Session["Marks"] = Convert.ToInt32(Session["marks"]) + 1;
                    }
                    else
                    {
                        Session["Marks"] = Convert.ToInt32(Session["marks"]) - 1;
                    }
                }
                else
                {
                    string insert_query = "insert into TBL_MCQAnswer (Schedule_ID,Stud_ID,Question_ID,Answer) values (" + sch + "," + std + "," + qid + ",'" + "Default" + "')";
                    SqlCommand cmd = new SqlCommand(insert_query, Conn);
                    cmd.ExecuteNonQuery();
                }
            }
            /* If Answered */
            else
            {
                /* Update The Current Answer In The Database */
                if (rbl_Options.SelectedIndex >= 0)
                {
                    string update_query = "update TBL_MCQAnswer set Answer = '" + Convert.ToString(rbl_Options.SelectedValue) + "' where Schedule_ID = " + sch + " AND Stud_ID = " + std + " AND Question_ID = " + qid + "";
                    SqlCommand cmd = new SqlCommand(update_query, Conn);
                    cmd.ExecuteNonQuery();
                    if (Convert.ToString(Session["Curr_ans"]) != Convert.ToString(rbl_Options.SelectedValue))
                    {
                        if (Convert.ToString(Session["Answer"]) == Convert.ToString(rbl_Options.SelectedValue))
                        {
                            Session["Marks"] = Convert.ToInt32(Session["marks"]) + 1;
                        }
                        else
                        {
                            Session["Marks"] = Convert.ToInt32(Session["marks"]) - 1;
                        }
                    }
                }
            }
                /*Setting The Index To -1 So The Selection Does Not Carry On*/
                rbl_Options.SelectedIndex = -1;
            /*Statements and Query Required To View NExt Question */
            SqlDataAdapter da1 = new SqlDataAdapter("SELECT * FROM TBL_MCQNA WHERE Schedule_ID='" + Session["Schedule"].ToString() + "'", Conn);
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);
            int i = Convert.ToInt32(Session["i"]);
            i--;
            /* If More Question Exists */
            if (i >= 0)
            {
                DataRow row = dt1.Rows[i];
                Session["QID"] = row[0];
                lbl_que.Text = row[2].ToString();
                /*Statements To Populate RadioButtonList*/
                var optlist = new List<ListItem>();
                for (var j = 3; j < 7; j++)
                {
                    var newItem = new ListItem()
                    {
                        Value = Convert.ToString(row[j]),
                        Text = Convert.ToString(row[j])
                    };
                    optlist.Add(newItem);
                }
                Session["Answer"] = Convert.ToString(row[7]);
                rbl_Options.DataSource = optlist;
                rbl_Options.DataBind();
            }
            /* If Last Question Exists */
            if (i == dt1.Rows.Count - 1)
            {
                /*If So Show And Enable The Submit Button And Do The Vice Versa With Next Button*/
                btn_sub.Enabled = true;
                btn_sub.Visible = true;
                btn_next.Enabled = false;
                btn_next.Visible = false;
            }
            /* If Last Question Exists */
            if (i < dt1.Rows.Count)
            {
                /*If Not Show And Enable The Next Button And Do The Vice Versa With Submit Button*/
                btn_next.Enabled = true;
                btn_next.Visible = true;
                btn_sub.Enabled = false;
                btn_sub.Visible = false;
            }
            /* If First Question Exists */
            if (i == 0)
            {
                btn_prev.Enabled = false;
                btn_prev.Visible = false;
            }
            /*Statements and Query Required To View The Answer Of The Next Question If One Exists In Database */
            qid = Convert.ToInt32(Session["QID"]);
            Session["i"] = i;
            query = "SELECT Answer FROM TBL_MCQAnswer WHERE Schedule_ID = " + sch + " AND Stud_ID = " + std + " AND Question_ID = " + qid + "";
            SqlCommand comm = new SqlCommand(query, Conn);
            SqlDataReader DR1 = comm.ExecuteReader();
            if (DR1.Read())
            {
                string answer = Convert.ToString(DR1.GetValue(0));
                if (answer != "Default")
                {
                    rbl_Options.SelectedValue = answer;
                }
            }
            Conn.Close();
        }

        protected void btn_sub_Click(object sender, EventArgs e)
        {
            Conn.Open();
            /* Retrieving Id Of Current Question And Schedule With The Id Of Student */
            int qid = Convert.ToInt32(Session["QID"]);
            int sch = Convert.ToInt32(Session["Schedule"]);
            int std = Convert.ToInt32(Session["StudId"]);
            /* Check If The Student Has Answered The Current Question Before */
            string query = "SELECT Answer FROM TBL_MCQAnswer WHERE Schedule_ID = " + sch + " AND Stud_ID = " + std + " AND Question_ID = " + qid + "";
            SqlDataAdapter da = new SqlDataAdapter(query, Conn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            /* If Not Answered */
                if (dt.Rows.Count == 0)
                {
                    /* Insert A New Row In The Database */
                    if (rbl_Options.SelectedIndex >= 0)
                    {
                    string insert_query = "insert into TBL_MCQAnswer (Schedule_ID,Stud_ID,Question_ID,Answer) values (" + sch + "," + std + "," + qid + ",'" + Convert.ToString(rbl_Options.SelectedValue) + "')";
                        SqlCommand cmd = new SqlCommand(insert_query, Conn);
                        cmd.ExecuteNonQuery();
                    if (rbl_Options.SelectedIndex > -1)
                    {
                        if (Convert.ToString(Session["Answer"]) == Convert.ToString(rbl_Options.SelectedValue))
                        {
                            Session["Marks"] = Convert.ToInt32(Session["marks"]) + 1;
                        }
                        else
                        {
                            Session["Marks"] = Convert.ToInt32(Session["marks"]) - 1;
                        }
                    }
                }
                    else
                    {
                        string insert_query = "insert into TBL_MCQAnswer (Schedule_ID,Stud_ID,Question_ID,Answer) values (" + sch + "," + std + "," + qid + ",'" + "Default" + "')";
                        SqlCommand cmd = new SqlCommand(insert_query, Conn);
                        cmd.ExecuteNonQuery();
                    }
            }
            /* If Answered */
            else
            {
                /* Update The Current Answer In The Database */
                if (rbl_Options.SelectedIndex >= 0)
                {
                    string update_query = "update TBL_MCQAnswer set Answer = '" + Convert.ToString(rbl_Options.SelectedValue) + "' where Schedule_ID = " + sch + " AND Stud_ID = " + std + " AND Question_ID = " + qid + "";
                    SqlCommand cmd = new SqlCommand(update_query, Conn);
                    cmd.ExecuteNonQuery();
                    if (Convert.ToString(Session["Curr_ans"]) != Convert.ToString(rbl_Options.SelectedValue))
                    {
                        if (Convert.ToString(Session["Answer"]) == Convert.ToString(rbl_Options.SelectedValue))
                        {
                            Session["Marks"] = Convert.ToInt32(Session["marks"]) + 1;
                        }
                        else
                        {
                            Session["Marks"] = Convert.ToInt32(Session["marks"]) - 1;
                        }
                    }
                }
            }
            string res_query = "insert into TBL_Result (Stud_ID,Sch_ID,Marks_Obtained) values (" + std + "," + sch + "," + Convert.ToInt32(Session["marks"]) + ")";
            SqlCommand cmd1 = new SqlCommand(res_query, Conn);
            cmd1.ExecuteNonQuery();
            Conn.Close();
            /* When Submit Button Is Clicked Show JavaScript Alert And Redirect To Home Page */
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Answers Were Recorded Successfully');window.location='HomePage.aspx';", true);
        }
    }
}