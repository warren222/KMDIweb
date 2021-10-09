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
                    access();
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
        private string usercode
        {
            get
            {
                return Session["KMDI_user_code"].ToString();
            }
        }
        private void access()
        {
            if ((usercode == "Delivery") ||
                     (usercode == "Operations") ||
                       (usercode == "Programmer") ||
                     (usercode == "Management"))

            {
                Panel1.Visible = true;
            }
            else
            {
                Panel1.Visible = false;
            }

            if ((usercode == "Accounting"))
            {
                Panel3.Visible = false;
                Panel4.Visible = false;

                Panel2.Visible = true;
                Panel1.Visible = true;
            }

            if ((usercode == "Accounting") || (usercode == "Operations") || (usercode == "Programmer") || (usercode == "Management") || (usercode == "AE") || (usercode == "Aftersales"))
            {
                Panel2.Visible = true;
            }
        }

        protected void LinkButton5_Click(object sender, EventArgs e)
        {
            if (Session["KMDI_clg_acct"].ToString() == "None")
            {
                errorrmessage("invalid access!");

            }
            else
            {
                if (IsValid)
                {
                    Response.Redirect("~/KMDIweb/AE/CollectionLedger/CollectionLedgerFrm.aspx");
                }

            }
        }
    }
}