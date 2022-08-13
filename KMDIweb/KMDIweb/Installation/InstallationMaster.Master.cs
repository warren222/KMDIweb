using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.Installation
{
    public partial class InstallationMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                username.Text = Session["KMDI_nickname"].ToString() + " ";
                access();
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private string usercode
        {
            get
            {
                return Session["KMDI_user_code"].ToString();
            }
        }
        private void access()
        {
            if (Session["KMDI_clg_acct"].ToString() == "Admin")
            {
                BTNaccount.Visible = true;
            }
            else
            {
                BTNaccount.Visible = false;
            }
            if((usercode == "Installation Staff") || (usercode == "Management") || (usercode == "Programmer"))
            {
                HyperLink1.Visible = true;
                HyperLink3.Visible = true;
            }
            else
            {
                if ((usercode == "Installer")||(usercode == "Engineer"))
                {
                    HyperLink1.Visible = true;
                }
                else
                {
                    HyperLink1.Visible = false;
                }
                HyperLink3.Visible = false;
            }      
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/KMDIweb/Global/login.aspx");
        }
    }
}