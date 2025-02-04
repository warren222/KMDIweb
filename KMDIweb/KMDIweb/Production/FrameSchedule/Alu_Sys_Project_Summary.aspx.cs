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
    public partial class Alu_Sys_Project_Summary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    tboxSdate.Text = DateTime.Now.ToString("yyyy") + "-01-01";
                    tboxEdate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    Get_Data();
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
        private void Get_Data()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Alu_Sys_Project_Summary_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get");
                        sqlcmd.Parameters.AddWithValue("@SubCommand", "Summary");
                        sqlcmd.Parameters.AddWithValue("@Tag", "All");
                        sqlcmd.Parameters.AddWithValue("@Sdate", tboxSdate.Text);
                        sqlcmd.Parameters.AddWithValue("@Edate", tboxEdate.Text);
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvAluSummary.DataSource = tb;
                            gvAluSummary.DataBind();
                            lblDateRange.Text = "Form " + tboxSdate.Text + " to " + tboxEdate.Text;
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
            Get_Data();
        }
        protected void gvAluSummary_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "execSelect")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvAluSummary.Rows[rowindex];
                row.RowState = DataControlRowState.Selected;
                ViewState["Sys_Tag"] = ((LinkButton)row.FindControl("btnSys_Tag")).Text;
                lblSysTag.Text = ((LinkButton)row.FindControl("btnSys_Tag")).Text;
                lblTotalUnits.Text = ((Label)row.FindControl("lblUnit")).Text;
                Get_Project_List();
            }
        }
        private void Get_Project_List()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Alu_Sys_Project_Summary_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get");
                        sqlcmd.Parameters.AddWithValue("@SubCommand", "Get_Projects");
                        sqlcmd.Parameters.AddWithValue("@Sdate", tboxSdate.Text);
                        sqlcmd.Parameters.AddWithValue("@Edate", tboxEdate.Text);
                        sqlcmd.Parameters.AddWithValue("@Tag", ViewState["Sys_Tag"].ToString());
                        DataTable tbl = new DataTable();
                        tbl.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tbl);
                            gvItems.DataSource = tbl;
                            gvItems.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }

        protected void gvItems_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvItems.PageIndex = e.NewPageIndex;
            Get_Project_List();
        }
    }
}