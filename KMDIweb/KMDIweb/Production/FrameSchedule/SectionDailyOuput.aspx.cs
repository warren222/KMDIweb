using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.Production.FrameSchedule
{
    public partial class SectionDailyOuput : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    ddlMonth.SelectedValue = DateTime.Now.Month.ToString();
                    tboxYear.Text = DateTime.Now.Year.ToString();
                    loadsummary();
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private void loadsummary()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        lblSection.Text = ddlSection.Text;
                        sqlcon.Open();
                        sqlcmd.CommandText = "section_daily_output_stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "summary");
                        sqlcmd.Parameters.AddWithValue("@section", ddlSection.Text);
                        sqlcmd.Parameters.AddWithValue("@year", tboxYear.Text);
                        sqlcmd.Parameters.AddWithValue("@month", ddlMonth.SelectedValue);
                        DataTable tb = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();
                        Session["TaskTable"] = tb;
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        private void loadlist(string dd, string section)
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        lblSection.Text = ddlSection.Text;
                        sqlcon.Open();
                        sqlcmd.CommandText = "section_daily_output_stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "list");
                        sqlcmd.Parameters.AddWithValue("@section", section);
                        sqlcmd.Parameters.AddWithValue("@dd", dd);
                        DataTable tb = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView2.DataSource = tb;
                        GridView2.DataBind();
                  
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                loadsummary();
            }
        }

        protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataTable dt = Session["TaskTable"] as DataTable;

            if (dt != null)
            {

                //Sort the data.
                dt.DefaultView.Sort = e.SortExpression + " " + GetSortDirection(e.SortExpression);
                GridView1.DataSource = Session["TaskTable"];
                GridView1.DataBind();
            }
        }
        private string GetSortDirection(string column)
        {

            // By default, set the sort direction to ascending.
            string sortDirection = "ASC";

            // Retrieve the last column that was sorted.
            string sortExpression = ViewState["SortExpression"] as string;

            if (sortExpression != null)
            {
                // Check if the same column is being sorted.
                // Otherwise, the default value can be returned.
                if (sortExpression == column)
                {
                    string lastDirection = ViewState["SortDirection"] as string;
                    if ((lastDirection != null) && (lastDirection == "ASC"))
                    {
                        sortDirection = "DESC";
                    }
                }
            }

            // Save new values in ViewState.
            ViewState["SortDirection"] = sortDirection;
            ViewState["SortExpression"] = column;

            return sortDirection;
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "viewlist")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                lblmodalSection.Text = lblSection.Text;
                lblmodalDate.Text = ((Label)row.FindControl("lblDateFormatted")).Text;
                loadlist(((Label)row.FindControl("lblDate")).Text,((Label)row.FindControl("lblSection")).Text);
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }
        }

        protected void viewReportBtn_Click(object sender, EventArgs e)
        {
            Session["SDOyear"] = tboxYear.Text;
            Session["SDOmonth"] = ddlMonth.SelectedValue;
            Session["SDOsection"] = ddlSection.Text;
            Response.Redirect("~/KMDIweb/Production/FrameSchedule/SectionDailyOutputReport.aspx");
        }
    }
}