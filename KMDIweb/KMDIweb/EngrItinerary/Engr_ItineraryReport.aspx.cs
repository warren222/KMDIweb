using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.EngrItinerary
{
    public partial class Engr_ItineraryReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    lblDate.Text = Convert.ToDateTime(SelectedDate).ToString("MMMM dd, yyyy");
                    getparameters();
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/EngrItinerary/Engr_Itinerary_Selected_Date.aspx" + AddQuerystring);
        }
        private string nickname
        {
            get
            {
                return Session["KMDI_nickname"].ToString();
            }
        }
        private string AddQuerystring
        {
            get
            {
                return "?Engr=" + Request.QueryString["Engr"].ToString() +
                "&HasReport=" + Request.QueryString["HasReport"].ToString() +
                "&Month=" + Request.QueryString["Month"].ToString() +
                "&Year=" + Request.QueryString["Year"].ToString() +
                "&SelectedDate=" + Request.QueryString["SelectedDate"].ToString();
            }
        }
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "errorval";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private string SelectedDate
        {
            get
            {
                return Request.QueryString["SelectedDate"].ToString();
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
        private void getparameters()
        {
            ReportViewer1.LocalReport.DisplayName = nickname + " " + SelectedDate;
            ReportViewer1.LocalReport.Refresh();
        }
    }
}