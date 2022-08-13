using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.Installation
{
    public partial class InstallationSummaryReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    tboxSdate.Text = DateTime.Today.ToString("yyyy-MM-dd");
                    tboxEdate.Text = DateTime.Today.ToString("yyyy-MM-dd");
                    loadengr();
                    loaddata();
                    if (Session["KMDI_user_code"].ToString() == "Engineer")
                    {
                        ddlEngr.Text = Session["KMDI_fullname"].ToString();
                        Panel2.Visible = false;
                    }
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
        private void loadengr()
        {

            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "installation_schedule_report_summary_stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "loadEngr");
                        ddlEngr.DataSource = sqlcmd.ExecuteReader();
                        ddlEngr.DataTextField = "project_engr_incharge";
                        ddlEngr.DataValueField = "project_engr_incharge";
                        ddlEngr.DataBind();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        private void loaddata()
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        DataTable tb = new DataTable();
                        sqlcon.Open();
                        sqlcmd.CommandText = "installation_schedule_report_summary_stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "load");
                        sqlcmd.Parameters.AddWithValue("@Sdate", tboxSdate.Text);
                        sqlcmd.Parameters.AddWithValue("@Edate", tboxEdate.Text);
                        sqlcmd.Parameters.AddWithValue("@Search", tboxSearch.Text);
                        sqlcmd.Parameters.AddWithValue("@DataStatus", ddlDataStatus.Text);
                        sqlcmd.Parameters.AddWithValue("@fullname", Session["KMDI_fullname"].ToString());
                        sqlcmd.Parameters.AddWithValue("@user_code", Session["KMDI_user_code"].ToString());
                        sqlcmd.Parameters.AddWithValue("@engr", ddlEngr.Text);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            loaddata();
        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            loaddata();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session["PSCommand"] = "load";
            Session["PSSearch"] = tboxSearch.Text == "" ? "empty" : tboxSearch.Text;
            Session["PSSdate"] = tboxSdate.Text;
            Session["PSEdate"] = tboxEdate.Text;
            Session["PSDataStatus"] = ddlDataStatus.SelectedValue.ToString();
            Session["PSfullname"] = Session["KMDI_fullname"].ToString();
            Session["PSuser_code"] = Session["KMDI_user_code"].ToString();
            Session["PSengr"] = ddlEngr.Text;
            Response.Redirect("~/KMDIweb/Installation/InstallationSummaryReportViewer.aspx");
        }
    }
}