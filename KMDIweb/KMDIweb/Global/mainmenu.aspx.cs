using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIapp
{
    public partial class mainmenu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                 
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "val1";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/KMDIweb/Global/login.aspx");
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            if (Session["KMDI_sfm_acct"].ToString() == "None")
            {
                errorrmessage("Invalid access!");
           
            }
            else
            {
                if (IsValid)
                {
                    Response.Redirect("~/KMDIweb/Production/ScreenSchedule/home.aspx");
                }
            
            }
        
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if (Session["KMDI_sdr_acct"].ToString() == "None")
            {
                errorrmessage("invalid access!");
            
            }
            else
            {
                if (IsValid)
                {
                    Response.Redirect("~/KMDIweb/Delivery/ScannedDR/DRscannedHome.aspx");
                }
              
            }
           
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            if (Session["KMDI_ffm_acct"].ToString() == "None")
            {
                errorrmessage("invalid access!");

            }
            else
            {
                if (IsValid)
                {
                    Response.Redirect("~/KMDIweb/Production/FrameSchedule/FrameHome.aspx");
                }

            }
        }
    }
}