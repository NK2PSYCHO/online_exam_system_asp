using System;
using System.Data.SqlClient;
using System.Data;
namespace ExamModuleASP.Forms
{
    public partial class HomePage : System.Web.UI.Page
    {
        int class_id = 0;
        int id = 0;
        int count = 0;
        SqlConnection Conn = new SqlConnection(@"Data Source=NK2PSYCHO;Initial Catalog=ExamModule;Integrated Security=True");
        protected void Page_Load(object sender, EventArgs e)
        {
            lbl_time.Text = DateTime.Now.ToString("HH:mm:ss");
            btn_start.Enabled = false;
            btn_start.Visible = false;
            if (Session["Email"]==null||Session["Pass"]==null){
                Response.Redirect("LoginPage.aspx");
            }else{
                SqlCommand Comm1 = new SqlCommand("SELECT * FROM TBL_Student WHERE Email_ID='" + Convert.ToString(Session["Email"]) + "' AND Passsword='" + Convert.ToString(Session["Pass"]) + "'", Conn);
                Conn.Open();
                SqlDataReader DR1 = Comm1.ExecuteReader();
                if (DR1.Read()){
                    Session["StudId"] = DR1.GetValue(0).ToString();
                    lbl_name.Text = DR1.GetValue(1).ToString();
                    lbl_email.Text = DR1.GetValue(2).ToString();
                    class_id = Convert.ToInt32(DR1.GetValue(4));
                    lbl_enroll.Text = DR1.GetValue(5).ToString();
                    lbl_seat.Text = DR1.GetValue(6).ToString();
                }
                DR1.Close();
                SqlCommand Comm2 = new SqlCommand("SELECT * FROM TBL_Class WHERE Class_ID='" + class_id + "'", Conn);
                DR1 = Comm2.ExecuteReader();
                if (DR1.Read()){
                    lbl_class.Text = DR1.GetValue(1).ToString();
                }
                DR1.Close();
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM TBL_Schedule WHERE Class_ID='" + class_id + "'", Conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt != null){
                    DateTime[] time = new DateTime[dt.Rows.Count];
                    DateTime[] times = new DateTime[dt.Rows.Count];
                    int[] sch = new int[dt.Rows.Count];
                    string[] exm = new string[dt.Rows.Count];
                    int strtlim = 0;
                    lbl_detail.Text = "Schedule For Today is as Follows:<br>";
                    for(int i=0;i<dt.Rows.Count;i++){
                        DataRow row = dt.Rows[i];
                        if (DateTime.Now.Date == Convert.ToDateTime(row[3]).Date){
                            count++;
                            id = Convert.ToInt32(row[2]);
                            time[i] = Convert.ToDateTime(Convert.ToString(row[4]));
                            times[i] = Convert.ToDateTime(Convert.ToString(row[5]));
                            sch[i] = Convert.ToInt32(row[0]);
                            exm[i] = Convert.ToString(row[6]);
                            strtlim = Convert.ToInt32(row[7]);
                            if (DateTime.Compare(DateTime.Now,time[i].AddMinutes(strtlim))<=0){
                                SqlCommand Comm3 = new SqlCommand("SELECT * FROM TBL_Subject WHERE Subject_ID=" + id + "", Conn);
                                DR1 = Comm3.ExecuteReader();
                                if (DR1.Read()){
                                    lbl_detail.Text += "<br>Exam for  " + DR1.GetValue(1).ToString() + "\r\nfrom  " + row[4].ToString() + " - to - " + row[5].ToString() + " of - Type " + row[6].ToString() + "<br>";
                                }
                                DR1.Close();
                            }
                        }
                    }
                    if (lbl_detail.Text.CompareTo("Schedule For Today is as Follows:<br>")==0){
                        lbl_detail.Text += "<br>Your Schedule Is Over For Today";
                    }else{
                        lbl_detail.Text += "<br>Be Ready";
                    }
                    DateTime now = DateTime.Now;
                    for(int j=0;j<dt.Rows.Count;j++)
                    {
                        if (DateTime.Compare(now,time[j])>=0){
                            DateTime t1 = time[j].AddMinutes(strtlim);
                            if (DateTime.Compare(now,t1 ) < 0 && DateTime.Compare(now,times[j]) < 0){
                                btn_start.Visible = true;
                                btn_start.Enabled = true;
                                Session["Schedule"] = sch[j];
                                Session["Type"] = exm[j];
                                DateTime startTime = DateTime.Now;
                                DateTime endTime = Convert.ToDateTime(times[j]);
                                TimeSpan span = endTime.Subtract(startTime);
                                Session["Interval"] = Convert.ToInt32(span.TotalSeconds);
                                break;
                            }
                        }
                    }
                }
                if (count==0){
                    lbl_detail.Text = "There is no schedule for you today";
                }
                Conn.Close();
       
            }
        }

        /* Code Which Will Fire When Start Button Is Clicked  */
        protected void btn_start_Click(object sender, EventArgs e)
        {
            if (string.Compare(Session["Type"].ToString(),"MCQ")==0){
                Response.Redirect("MCQTest.aspx");
            }
            if (string.Compare(Session["Type"].ToString(), "Descriptive") == 0){
                Response.Redirect("DESCTest.aspx");
            }
        }
    }
}