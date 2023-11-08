using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Data;
namespace ExamModuleASP.Forms
{   public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Email"] = null;
            Session["Pass"] = null;
            lbl_time.Text = DateTime.Now.ToString("HH:mm:ss");
            if (!IsPostBack){
                if (Request.Cookies["emailid"] != null && Request.Cookies["pass"] != null){
                    txt_email.Text = Request.Cookies["emailid"].Value;
                    txt_pass.Attributes["value"] = Request.Cookies["pass"].Value;
                    chk_rem.Checked = true;
                }
            }
        }
        protected void btn_log_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(@"Data Source=NK2PSYCHO;Initial Catalog=ExamModule;Integrated Security=True");  
            SqlDataAdapter sda = new SqlDataAdapter("SELECT COUNT(*) FROM TBL_Student WHERE Email_ID='" + txt_email.Text + "' AND Passsword='" + txt_pass.Text + "'", con);
            DataTable dt = new DataTable(); 
            sda.Fill(dt);
            if (dt.Rows[0][0].ToString() == "1"){
                if (chk_rem.Checked==true){
                    Response.Cookies["emailid"].Value = txt_email.Text;
                    Response.Cookies["pass"].Value = txt_pass.Text;
                    Response.Cookies["emailid"].Expires = DateTime.Now.AddDays(15);
                    Response.Cookies["pass"].Expires = DateTime.Now.AddDays(15);
                }
                else
                {
                    Response.Cookies["emailid"].Expires = DateTime.Now.AddDays(-1);
                    Response.Cookies["pass"].Expires = DateTime.Now.AddDays(-1);
                }
                Session["Email"] = txt_email.Text;
                Session["Pass"] = txt_pass.Text;
                Response.Redirect("HomePage.aspx");
            }
            else
            {
                string script = "alert(\"Invalid Email ID or Password\");";
                ScriptManager.RegisterStartupScript(this, GetType(),
                                      "ServerControlScript", script, true);
            }
               
        }
    }
}