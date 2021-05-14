using KMDIweb.SCREENfab;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.Production.FrameSchedule
{
    public partial class SectionDailyOutputReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    getReport();
                    getparameters();
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
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
        private void getReport()
        {
            SqlDataSource1.ConnectionString = sqlconstr;
            SqlDataSource1.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;
            SqlDataSource1.SelectCommand = "[dbo].[section_daily_output_stp]";
            SqlDataSource1.SelectParameters.Add("command", TypeCode.String, "summary");
            SqlDataSource1.SelectParameters.Add("section", TypeCode.String, Session["SDOsection"].ToString());
            SqlDataSource1.SelectParameters.Add("year", TypeCode.String, Session["SDOyear"].ToString());
            SqlDataSource1.SelectParameters.Add("month", TypeCode.String, Session["SDOmonth"].ToString());
        }
        private void getparameters()
        {
            ReportViewer1.LocalReport.EnableExternalImages = true;
            ReportParameter repparam = new ReportParameter();
            repparam = new ReportParameter("section", Session["SDOsection"].ToString());
            ReportViewer1.LocalReport.SetParameters(repparam);
            ReportViewer1.LocalReport.Refresh();
        }
    }
}