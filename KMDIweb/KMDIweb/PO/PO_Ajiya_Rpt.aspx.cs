﻿using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.PO
{
    public partial class PO_Ajiya_Rpt : System.Web.UI.Page
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
                btnNotedby.Visible = true;
                btnApprovedby.Visible = true;
            }
            else if (poa == "PO")
            {
                btnPreparedby.Visible = true;
                btnNotedby.Visible = false;
                btnApprovedby.Visible = false;
            }
            else if (poa == "Noter")
            {
                btnPreparedby.Visible = false;
                btnNotedby.Visible = true;
                btnApprovedby.Visible = false;
            }
            else if (poa == "Approver")
            {
                btnPreparedby.Visible = false;
                btnNotedby.Visible = false;
                btnApprovedby.Visible = true;
            }
            else
            {
                btnPreparedby.Visible = false;
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
        protected void SqlDataSource3_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 32000;
        }
        protected void btnPreparedby_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PO/PO_Sign.aspx" + AddQuerystring + "&PO_Sender=PO_Ajiya_Rpt&PO_Sign_Field=Web_Prepared_By");
        }
        protected void btnNotedby_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PO/PO_Sign.aspx" + AddQuerystring + "&PO_Sender=PO_Ajiya_Rpt&PO_Sign_Field=Web_Noted_By");
        }
        protected void btnApprovedby_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PO/PO_Sign.aspx" + AddQuerystring + "&PO_Sender=PO_Ajiya_Rpt&PO_Sign_Field=Web_Approved_By");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PO/PO_ForApproval.aspx" + AddQuerystring);
        }
        private string AddQuerystring
        {
            get
            {
                return "?PO_Search=" + Request.QueryString["PO_Search"].ToString() + "&PO_For_Signature=" + Request.QueryString["PO_For_Signature"].ToString() +
                       "&PO_PageIndex=" + Request.QueryString["PO_PageIndex"].ToString() + "&Requested_By=" + Request.QueryString["Requested_By"].ToString() +
                       "&Date_Filter=" + Request.QueryString["Date_Filter"].ToString() + "&Date=" + Request.QueryString["Date"].ToString();
            }
        }
        private void getparameters()
        {
            ReportViewer1.LocalReport.EnableExternalImages = true;
            string _prepared = new Uri(Server.MapPath("~/KMDI_FILES/WMS/PO/" + Session["POPO_No"].ToString() + "/Signatures/Web_Prepared_By.jpg")).AbsoluteUri;
            string _noted = new Uri(Server.MapPath("~/KMDI_FILES/WMS/PO/" + Session["POPO_No"].ToString() + "/Signatures/Web_Noted_By.jpg")).AbsoluteUri;
            string _approved = new Uri(Server.MapPath("~/KMDI_FILES/WMS/PO/" + Session["POPO_No"].ToString() + "/Signatures/Web_Approved_By.jpg")).AbsoluteUri;
            ReportParameter[] repparam = new ReportParameter[5];
            repparam[0] = new ReportParameter("ImgPreparedBy", _prepared);
            repparam[1] = new ReportParameter("ImgNotedBy", _noted);
            repparam[2] = new ReportParameter("ImgApprovedBy", _approved);
            repparam[3] = new ReportParameter("forigu", cboxForIGU.Checked.ToString());
            repparam[4] = new ReportParameter("fornewglasslogo", cboxNewLogo.Checked.ToString());
            for (int i = 0; i < 5; i++)
            {
                ReportViewer1.LocalReport.SetParameters(repparam[i]);
            }
            ReportViewer1.LocalReport.DisplayName = Session["POPO_No"].ToString();
            ReportViewer1.LocalReport.Refresh();
        }
        protected void ReportViewer1_ReportRefresh(object sender, System.ComponentModel.CancelEventArgs e)
        {
            getparameters();
        }
    }
}