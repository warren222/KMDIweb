using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.GlassNotification
{
    public partial class Glass_Notif_Rpt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    getparameters();
                    BtnAccess();
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
           
        }
        private string user_code
        {
            get
            {
                return Session["KMDI_user_code"].ToString();
            }
        }
        private void BtnAccess()
        {
            if (user_code == "Programmer")
            {
                btnPreparedBy.Visible = true;
                btnNotedByPM.Visible = true;
                btnReceivedBy.Visible = true;
                btnNotedByIM.Visible = true;
            }
            else if (user_code == "Glass Section")
            {
                btnPreparedBy.Visible = true;
                btnNotedByPM.Visible = false;
                btnReceivedBy.Visible = false;
                btnNotedByIM.Visible = false;
            }
            else if (user_code == "Production Manager")
            {
                btnPreparedBy.Visible = false;
                btnNotedByPM.Visible = true;
                btnReceivedBy.Visible = false;
                btnNotedByIM.Visible = false;
            }
            else if (user_code == "Delivery")
            {
                btnPreparedBy.Visible = false;
                btnNotedByPM.Visible = false;
                btnReceivedBy.Visible = true;
                btnNotedByIM.Visible = false;
            }
            else if (user_code == "Engineer Manager")
            {
                btnPreparedBy.Visible = false;
                btnNotedByPM.Visible = false;
                btnReceivedBy.Visible = false;
                btnNotedByIM.Visible = true;
            }
            else
            {
                btnPreparedBy.Visible = false;
                btnNotedByPM.Visible = false;
                btnReceivedBy.Visible = false;
                btnNotedByIM.Visible = false;
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/GlassNotification/Glass_Notif_List.aspx" + AddQuerystring);
        }
        private string AddQuerystring
        {
            get
            {
                return "?Find=" + Request.QueryString["Find"].ToString() +
                    "&DateFilter=" + Request.QueryString["DateFilter"].ToString() +
                    "&Date=" + Request.QueryString["Date"].ToString() +
                    "&ForSignature=" + Request.QueryString["ForSignature"].ToString() +
                    "&PageIndex=" + Request.QueryString["PageIndex"].ToString() +
                    "&Glass_PO_Notification_Id=" + Request.QueryString["Glass_PO_Notification_Id"].ToString() + 
                    "&Control_No=" + Request.QueryString["Control_No"].ToString();
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
        protected void ReportViewer1_ReportRefresh(object sender, System.ComponentModel.CancelEventArgs e)
        {
            getparameters();
        }
        private string Control_No
        {
            get
            {
                return Request.QueryString["Control_No"].ToString();
            }
        }
        private void getparameters()
        {
            ReportViewer1.LocalReport.EnableExternalImages = true;
            string PreparedByImg = new Uri(Server.MapPath("~/KMDI_FILES/WMS/Glass_Notification/" + Control_No + "/Signatures/Prepared_By.jpg")).AbsoluteUri;
            string NotedByPMImg = new Uri(Server.MapPath("~/KMDI_FILES/WMS/Glass_Notification/" + Control_No + "/Signatures/Noted_By_PM.jpg")).AbsoluteUri;
            string ReceivedByImg = new Uri(Server.MapPath("~/KMDI_FILES/WMS/Glass_Notification/" + Control_No + "/Signatures/Received_By.jpg")).AbsoluteUri;
            string NotedByIMImg = new Uri(Server.MapPath("~/KMDI_FILES/WMS/Glass_Notification/" + Control_No + "/Signatures/Noted_By_IM.jpg")).AbsoluteUri;
            ReportParameter[] repparam = new ReportParameter[6];
            repparam[0] = new ReportParameter("PreparedByImg", PreparedByImg);
            repparam[1] = new ReportParameter("NotedByPMImg", NotedByPMImg);
            repparam[2] = new ReportParameter("ReceivedByImg", ReceivedByImg);
            repparam[3] = new ReportParameter("NotedByIMImg", NotedByIMImg);
            for (int i = 0; i < 4; i++)
            {
                ReportViewer1.LocalReport.SetParameters(repparam[i]);
            }
            ReportViewer1.LocalReport.DisplayName = Control_No;
            ReportViewer1.LocalReport.Refresh();
        }
        protected void btnPreparedBy_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/GlassNotification/GN_Sign.aspx" + AddQuerystring + "&Glass_Notif_Sign_Field=Prepared_By");
        }
        protected void btnNotedByPM_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/GlassNotification/GN_Sign.aspx" + AddQuerystring + "&Glass_Notif_Sign_Field=Noted_By_PM");
        }
        protected void btnReceivedBy_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/GlassNotification/GN_Sign.aspx" + AddQuerystring + "&Glass_Notif_Sign_Field=Received_By");
        }
        protected void btnNotedByIM_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/GlassNotification/GN_Sign.aspx" + AddQuerystring + "&Glass_Notif_Sign_Field=Noted_By_IM");
        }
    }
}