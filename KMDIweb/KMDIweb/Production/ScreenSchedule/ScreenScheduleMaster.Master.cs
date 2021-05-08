using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.SCREENfab
{
    public partial class KMDIwebMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                username.Text = Session["KMDI_nickname"].ToString() + " ";
                access();
                summaryAccess();
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private void access()
        {
            if (Session["KMDI_sfm_acct"].ToString() == "Admin")
            {
                BTNaccount.Visible = true;
            }
            else
            {
                BTNaccount.Visible = false;
            }
        }
        private string usercode
        {
            get
            {
                return Session["KMDI_user_code"].ToString();
            }
        }
        private void summaryAccess()
        {
            if ((usercode == "Production Manager") ||
                      (usercode == "Production Engineer") ||
                       (usercode == "Supervisor") ||
                        (usercode == "Programmer") ||
                      (usercode == "Management"))

            {
                HyperLink10.Visible = true;
            }
            else
            {
                HyperLink10.Visible = false;
            }
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/KMDIweb/Global/login.aspx");
        }
    }
}