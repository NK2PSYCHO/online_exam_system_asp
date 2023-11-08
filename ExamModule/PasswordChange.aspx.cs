using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/* Library Added To Help With SQl Server And Querying DataBase */
using System.Data.SqlClient;

namespace ExamModuleASP.ExamModule
{
    public partial class PasswordChange : System.Web.UI.Page
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
            lbl_time.Text = DateTime.Now.ToString("HH:mm:ss");
        }

        protected void btn_back_Click(object sender, EventArgs e)
        {
            /* Redirect To HomePage When Back Button Is Clicked */
            Response.Redirect("HomePage.aspx");
        }

        /* Code Which Will Fire When Change PAssword Button Is Clicked  */
        protected void btn_change_Click(object sender, EventArgs e)
        {
            Conn.Open();
            /* To Check If The New Password TextBox Is Empty */
            if (String.IsNullOrEmpty(txt_newp.Text))
            {
                /* If Empty Show JavaScript Alert That It Cannot Be Empty */
                Response.Write("<script>alert('New Password Cannot Be Blank')</script>");
            }
            /* To Check If The Current Password Matches */
            else if (Convert.ToString(Session["pass"]).CompareTo(txt_oldp.Text)==0)
            {
                /* SQL Command and Statements To Change Password In Database Table As Well As Session Variable */
                string update_query = "update TBL_Student set Passsword = '" + Convert.ToString(txt_newp.Text) + "' where Email_ID = '" + Convert.ToString(Session["Email"]) + "' AND Stud_ID = '" + Convert.ToString(Session["StudId"]) + "' ";
                SqlCommand cmd = new SqlCommand(update_query, Conn);
                cmd.ExecuteNonQuery();
                Session["pass"] = txt_newp.Text;
                /* Show JavaScript Alert To Inform The User That the Password Is Changed Successfully */
                Response.Write("<script> alert('Password Changed Successfully');window.location='HomePage.aspx'; </script>");
            }
            else
            {
                /* If Fails Show JavaScript Alert That It Current Password Does Not Match */
                Response.Write("<script>alert('Current Password Does Not Match')</script>");
            }
            
        }
    }
}