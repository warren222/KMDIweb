using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.PO
{
    public partial class PO_X_Rpt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                user_access();
                getparameters();
            }

        }
        private void user_access()
        {
            if (poa == "Admin")
            {
                btnPreparedby.Visible = true;
                btnRequestedby.Visible = true;
                btnNotedby.Visible = true;
                btnApprovedby.Visible = true;
            }
            else if (poa == "PO")
            {
                btnPreparedby.Visible = true;
                btnRequestedby.Visible = false;
                btnNotedby.Visible = false;
                btnApprovedby.Visible = false;
            }
            else if (poa == "Requester")
            {
                btnPreparedby.Visible = false;
                btnRequestedby.Visible = true;
                btnNotedby.Visible = false;
                btnApprovedby.Visible = false;
            }
            else if (poa == "Take note")
            {
                btnPreparedby.Visible = false;
                btnRequestedby.Visible = false;
                btnNotedby.Visible = true;
                btnApprovedby.Visible = false;
            }
            else if (poa == "Approver")
            {
                btnPreparedby.Visible = false;
                btnRequestedby.Visible = false;
                btnNotedby.Visible = false;
                btnApprovedby.Visible = true;
            }
            else
            {
                btnPreparedby.Visible = false;
                btnRequestedby.Visible = false;
                btnNotedby.Visible = false;
                btnApprovedby.Visible = false;
            }
        }
        private string user_fullname
        {
            get
            {
                return Session["KMDI_fullname"].ToString();
            }
        }

        private string poa
        {
            get
            {
                return Session["KMDI_poa_acct"].ToString();
            }
        }
        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 32000;
        }
        protected void SqlDataSource2_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 32000;
        }
        protected void btnPreparedby_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PO/PO_Sign.aspx?PO_Sender=PO_X_Rpt&PO_Sign_Field=Web_Prepared_By&PO_Search=" + Request.QueryString["PO_Search"].ToString() + "&PO_PageIndex=" + Request.QueryString["PO_PageIndex"].ToString());
        }
        protected void btnRequestedby_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PO/PO_Sign.aspx?PO_Sender=PO_X_Rpt&PO_Sign_Field=Web_Requested_By&PO_Search=" + Request.QueryString["PO_Search"].ToString() + "&PO_PageIndex=" + Request.QueryString["PO_PageIndex"].ToString());
        }
        protected void btnNotedby_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PO/PO_Sign.aspx?PO_Sender=PO_X_Rpt&PO_Sign_Field=Web_Noted_By&PO_Search=" + Request.QueryString["PO_Search"].ToString() + "&PO_PageIndex=" + Request.QueryString["PO_PageIndex"].ToString());
        }
        protected void btnApprovedby_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PO/PO_Sign.aspx?PO_Sender=PO_X_Rpt&PO_Sign_Field=Web_Approved_By&PO_Search=" + Request.QueryString["PO_Search"].ToString() + "&PO_PageIndex=" + Request.QueryString["PO_PageIndex"].ToString());
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PO/PO_ForApproval.aspx?PO_Search=" + Request.QueryString["PO_Search"].ToString() + "&PO_PageIndex=" + Request.QueryString["PO_PageIndex"].ToString());
        }
        private void getparameters()
        {
            ReportViewer1.LocalReport.EnableExternalImages = true;
            string _prepared = new Uri(Server.MapPath("~/KMDIweb/Uploads/PO/" + Session["POPO_No"].ToString() + "/Signatures/Web_Prepared_By.jpg")).AbsoluteUri;
            string _noted = new Uri(Server.MapPath("~/KMDIweb/Uploads/PO/" + Session["POPO_No"].ToString() + "/Signatures/Web_Noted_By.jpg")).AbsoluteUri;
            string _approved = new Uri(Server.MapPath("~/KMDIweb/Uploads/PO/" + Session["POPO_No"].ToString() + "/Signatures/Web_Approved_By.jpg")).AbsoluteUri;
            string _requested = new Uri(Server.MapPath("~/KMDIweb/Uploads/PO/" + Session["POPO_No"].ToString() + "/Signatures/Web_Requested_By.jpg")).AbsoluteUri;
            ReportParameter[] repparam = new ReportParameter[4];
            repparam[0] = new ReportParameter("ImgPreparedBy", _prepared);
            repparam[1] = new ReportParameter("ImgNotedBy", _noted);
            repparam[2] = new ReportParameter("ImgApprovedBy", _approved);
            repparam[3] = new ReportParameter("ImgRequestedBy", _requested);
            for (int i = 0; i < 4; i++)
            {
                ReportViewer1.LocalReport.SetParameters(repparam[i]);
            }

            ReportViewer1.LocalReport.Refresh();
        }
    }
}