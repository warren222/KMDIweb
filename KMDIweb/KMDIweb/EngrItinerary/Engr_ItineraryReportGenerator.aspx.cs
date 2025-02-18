using KMDIweb.SCREENfab;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.EngrItinerary
{
    public partial class Engr_ItineraryReportGenerator : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    Get_Engr();
                    RetriverQS();
                    getparameters(reportDataTable("II_Report"), reportDataTable("DR_Report"));
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private void RetriverQS()
        {
            ddlEngr.SelectedValue = Request.QueryString["Engr"] != null ? Request.QueryString["Engr"].ToString() : "";
            tboxSdate.Text = SelectedDate;
            tboxEdate.Text = SelectedDate;
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/EngrItinerary/Engr_Itinerary.aspx" + AddQuerystring);
        }
        private string AddQuerystring
        {
            get
            {
                return "?Engr=" + Request.QueryString["Engr"].ToString() +
                "&HasReport=" + Request.QueryString["HasReport"].ToString() +
                "&Month=" + Request.QueryString["Month"].ToString() +
                "&Year=" + Request.QueryString["Year"].ToString();
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
        private void Get_Engr()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Engr_Itinerary_Calendar_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Nicknames");
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            ddlEngr.DataSource = tb;
                            ddlEngr.DataTextField = "Nickname";
                            ddlEngr.DataValueField = "Nickname_Val";
                            ddlEngr.DataBind();
                        }

                    }
                }

            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            getparameters(reportDataTable("II_Report"), reportDataTable("DR_Report"));
        }
        private DataTable reportDataTable(string command)
        {
            DataTable dt = new DataTable();
            dt.Clear();
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Engr_Itinerary_Calendar_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", command);
                        sqlcmd.Parameters.AddWithValue("@Engr", ddlEngr.SelectedValue.ToString());
                        sqlcmd.Parameters.AddWithValue("@Sdate", tboxSdate.Text);
                        sqlcmd.Parameters.AddWithValue("@Edate", tboxEdate.Text);
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(dt);
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            return dt;
        }
        private void getparameters(DataTable tb1, DataTable tb2)
        {
            try
            {
                ReportViewer1.ProcessingMode = ProcessingMode.Local;
                ReportViewer1.LocalReport.ReportPath = @"KMDIweb\Global\Reports\Engr_ItineraryReport.rdlc";
                ReportDataSource ds1 = new ReportDataSource("DataSet1", tb1);
                ReportDataSource ds2 = new ReportDataSource("DataSet2", tb2);
                ReportViewer1.LocalReport.DataSources.Clear();
                ReportViewer1.LocalReport.DataSources.Add(ds1);
                ReportViewer1.LocalReport.DataSources.Add(ds2);
                ReportViewer1.LocalReport.DisplayName = ddlEngr.SelectedValue.ToString() + " " + SelectedDate;
                ReportViewer1.LocalReport.Refresh();
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
        protected void ReportViewer1_ReportRefresh(object sender, System.ComponentModel.CancelEventArgs e)
        {
            getparameters(reportDataTable("II_Report"), reportDataTable("DR_Report"));
        }

       
        private void EcxecuteQuery(string fullname)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Engr_Itinerary_Calendar_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Update_Noted");
                        sqlcmd.Parameters.AddWithValue("@Fullname", fullname);
                        sqlcmd.Parameters.AddWithValue("@Engr", ddlEngr.SelectedValue.ToString());
                        sqlcmd.Parameters.AddWithValue("@Sdate", tboxSdate.Text);
                        sqlcmd.Parameters.AddWithValue("@Edate", tboxEdate.Text);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            finally
            {
                getparameters(reportDataTable("II_Report"), reportDataTable("DR_Report"));
            }
        }
    }
}