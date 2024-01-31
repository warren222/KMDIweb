using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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
        private string poa
        {
            get
            {
                return Session["KMDI_poa_acct"].ToString();
            }
        }
        private string usercode
        {
            get
            {
                return Session["KMDI_user_code"].ToString();
            }
        }
        private string fullname
        {
            get
            {
                return Session["KMDI_fullname"].ToString();
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
            if ((usercode == "Installer") || (usercode == "Installation Staff") || (usercode == "Management") || (usercode == "Programmer") || (usercode == "Engineer") || (usercode == "Engineer Manager"))
            {

                Panel5.Visible = true;
            }
            else
            {
                Panel5.Visible = false;
            }
            if ((usercode == "Installer") || (usercode == "Installation Staff"))
            {
                Panel3.Visible = false;
                Panel4.Visible = false;
            }

            //if ((usercode == "AE") || 
            //    (usercode == "Accounting") ||
            //    ((fullname == "Leo Candelaria" && usercode == "Operations")) ||
            //    (usercode == "Programmer") ||
            //    (fullname == "Genalyn Garcia"))
            //{
            //    pnlAC.Visible = true;
            //}
            //if ((usercode == "AE") ||
            //((fullname == "Jayvey Manalili" && usercode == "Operations")) ||
            //(usercode == "Programmer") ||
            //(fullname == "Genalyn Garcia"))
            //{
            //    pnlAF.Visible = true;
            //}
            if(poa != "")
            {
                pnlPO.Visible = true;
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

        protected void LinkButton6_Click(object sender, EventArgs e)
        {

            Response.Redirect("~/KMDIweb/Installation/InstallationSchedule.aspx");

        }

        protected void LinkButton9_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/AE/AF/AF_Project_List.aspx");
        }
        protected void LinkButton10_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/AE/AccountingClearance/AC_ProjectList.aspx");
        }
        protected void LinkButton11_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PO/PO_ForApproval.aspx");
        }
    }
}