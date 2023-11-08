using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace ExamModuleASP.ExamModule
{
    public partial class CheckResult : System.Web.UI.Page
    {
        /* Global Connection String Created So It Can Be Used ThrouOut Class */
        SqlConnection con = new SqlConnection(@"Data Source=NK2PSYCHO;Initial Catalog=ExamModule;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            /* Checking If Session Variables Of Email-Id And Password Are Null (Helps When Someone Tries To Dierctly Access This Page Without LogIn) */
            if (Session["Email"] == null || Session["Pass"] == null)
            {
                /* If Verification Fails Redirect To LogIn Page */
                Response.Redirect("LoginPage.aspx");
            }
            lbl_time.Text = DateTime.Now.ToString("HH:mm:ss");
            lbl_marks.Enabled = false;
            lbl_marks.Visible = false;
            if (!IsPostBack)
            {
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter("select Sch_ID from TBL_Result where Stud_ID="+Convert.ToInt32(Session["StudId"])+"", con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count <=0 )
                {
                    ddl_options.Visible = false;
                    ddl_options.Enabled = false;
                    lbl_Body.Text = "No Results Are Available Yet";
                }
                else
                {
                    String[] datalist=new string[dt.Rows.Count];
                    int[] i = new int[(dt.Rows.Count)];
                    int j = 0;
                    DataTable dtAll = new DataTable();
                    dtAll.Columns.Add("Subject_Name", typeof(string));
                    dtAll.Columns.Add("Stud_ID", typeof(int));
                    lbl_Body.Text = "Select the Exam You Want To See Results Of";
                    ddl_options.Visible = true;
                    ddl_options.Enabled = true;
                    foreach (DataRow row in dt.Rows)
                    {
                        i[j] = Convert.ToInt32(row[0]);
                        j++;
                    }
                    for(j=0;j<dt.Rows.Count;j++)
                    {
                        SqlDataAdapter sda1 = new SqlDataAdapter("select Schedule_ID,Subject_ID,Exam_Type from TBL_Schedule where Schedule_Id="+i[j]+" ", con);
                        DataTable dt1 = new DataTable();
                        sda1.Fill(dt1);
                        dtAll.Merge(dt1);
                        SqlDataAdapter sda2 = new SqlDataAdapter("select Subject_Name from TBL_Subject where Subject_ID="+ Convert.ToInt32(dt1.Rows[0]["Subject_ID"]) + " ", con);
                        DataTable dt2 = new DataTable();
                        sda2.Fill(dt2);
                        DataRow dr = dtAll.Rows[j];
                        dr["Subject_Name"] = dt2.Rows[0][0];
                        dr["Stud_ID"] = Convert.ToInt32(Session["StudId"]);
                    }
                    dtAll.Columns.Add("Exam", typeof(string), "Subject_Name + ' ' + Exam_Type");
                    ddl_options.DataSource = dtAll;
                    ddl_options.DataTextField = "Exam";
                    ddl_options.DataValueField = "Schedule_Id";
                    ddl_options.DataBind();
                    con.Close();
                }
            }
        }

        protected void btn_back_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx");
        }

        protected void ddl_options_SelectedIndexChanged(object sender, EventArgs e)
        {
            lbl_marks.Enabled = true;
            lbl_marks.Visible = true;
            lbl_marks.Text = "Marks Obtained : ";
            con.Open();
            DataTable dtgdv = new DataTable();
            SqlCommand cmd = new SqlCommand("select Exam_Type from TBL_Schedule where Schedule_Id=" + Convert.ToInt32(ddl_options.SelectedValue) + "", con);
            var id = (String)cmd.ExecuteScalar();
            if (Convert.ToString(id) == "MCQ")
            {
                SqlDataAdapter sda1 = new SqlDataAdapter("select Question,Correct_Option from TBL_MCQNA where Schedule_Id=" + Convert.ToInt32(ddl_options.SelectedValue.ToString()) + " ", con);
                DataTable dt1 = new DataTable();
                sda1.Fill(dt1);
                dtgdv.Merge(dt1);
                dtgdv.Columns.Add("Your_Answer", typeof(string));
                SqlDataAdapter sda = new SqlDataAdapter("select Answer from TBL_MCQAnswer where Schedule_Id=" + Convert.ToInt32(ddl_options.SelectedValue.ToString()) + " and Stud_ID="+ Convert.ToInt32(Session["StudId"]) + " ", con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                for(int i = 0; i < dt.Rows.Count; i++)
                {
                    DataRow dr = dtgdv.Rows[i];
                    dr["Your_Answer"] = dt.Rows[i][0];
                }
                SqlDataAdapter sda2 = new SqlDataAdapter("select Marks_Obtained from TBL_Result where Stud_ID=" + Convert.ToInt32(Session["StudId"]) + "and Sch_ID=" + Convert.ToInt32(ddl_options.SelectedValue.ToString()) + "", con);
                DataTable dt2 = new DataTable();
                sda2.Fill(dt2);
                lbl_marks.Text += Convert.ToString(dt2.Rows[0]["Marks_Obtained"]);
            }
            else
            {
                SqlDataAdapter sda1 = new SqlDataAdapter("select Question from TBL_DESQNA where Schedule_Id=" + Convert.ToInt32(ddl_options.SelectedValue.ToString()) + " ", con);
                DataTable dt1 = new DataTable();
                sda1.Fill(dt1);
                dtgdv.Merge(dt1);
                dtgdv.Columns.Add("Your_Answer", typeof(string));
                dtgdv.Columns.Add("Remarks", typeof(string));
                SqlDataAdapter sda = new SqlDataAdapter("select Answer,Remarks from TBL_DESQAnswer where Schedule_Id=" + Convert.ToInt32(ddl_options.SelectedValue.ToString()) + " and Stud_ID=" + Convert.ToInt32(Session["StudId"]) + " ", con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DataRow dr = dtgdv.Rows[i];
                    dr["Your_Answer"] = dt.Rows[i][0];
                    dr["Remarks"] = dt.Rows[i][1];
                }
                SqlDataAdapter sda2 = new SqlDataAdapter("select Marks_Obtained from TBL_Result where Stud_ID=" + Convert.ToInt32(Session["StudId"]) + "and Sch_ID=" + Convert.ToInt32(ddl_options.SelectedValue.ToString()) + "", con);
                DataTable dt2 = new DataTable();
                sda2.Fill(dt2);
                lbl_marks.Text += Convert.ToString(dt2.Rows[0]["Marks_Obtained"]);
            }
            gdv_result.DataSource = dtgdv;
            gdv_result.DataBind();
            con.Close();
        }
    }
}