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

        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/GlassNotification/Glass_Notif_List.aspx" + AddQuerystring);
        }
        private string AddQuerystring
        {
            get
            {
                return "?Find=" + Request.QueryString["Find"].ToString() + "&PageIndex=" + Request.QueryString["PageIndex"].ToString();
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
            //getparameters();
            ReportViewer1.LocalReport.DisplayName = Request.QueryString["Glass_PO_Notification_Id"].ToString();
            ReportViewer1.LocalReport.Refresh();
        }
    }
}