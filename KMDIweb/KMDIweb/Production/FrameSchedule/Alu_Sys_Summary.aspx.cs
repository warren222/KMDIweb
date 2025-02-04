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
    public partial class Alu_Sys_Summary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    tboxSdate.Text = DateTime.Now.ToString("yyyy") + "-01-01";
                    tboxEdate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    GetData();
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
        private void GetData()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Alu_Sys_Summary_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "");
                        sqlcmd.Parameters.AddWithValue("@Sdate", tboxSdate.Text);
                        sqlcmd.Parameters.AddWithValue("@Edate", tboxEdate.Text);   
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvAluSys.DataSource = tb;
                            gvAluSys.DataBind();
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
            GetData();
        }

        protected void gvAluSys_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "execSelect")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvAluSys.Rows[rowindex];
                row.RowState = DataControlRowState.Selected;
                ViewState["alu_sys"] = ((LinkButton)row.FindControl("btnAlu_Sys")).Text;
                lblSysTag.Text = ((LinkButton)row.FindControl("btnAlu_Sys")).Text;
                lblTotalUnits.Text = ((Label)row.FindControl("lblUnit")).Text;
                Get_alu_sys_list();
            }
        }

        private void Get_alu_sys_list()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Alu_Sys_Summary_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Items");
                        sqlcmd.Parameters.AddWithValue("@Sdate", tboxSdate.Text);
                        sqlcmd.Parameters.AddWithValue("@Edate", tboxEdate.Text);
                        sqlcmd.Parameters.AddWithValue("@AluSys", ViewState["alu_sys"].ToString());
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
            catch(Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }

        protected void gvItems_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvItems.PageIndex = e.NewPageIndex;
            Get_alu_sys_list();
        }
    }
}