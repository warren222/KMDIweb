using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.AE.AF
{
    public partial class AF_For_Approval : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["KMDI_userid"] != null)
                {
                    if (!IsPostBack)
                    {
                        loadae();
                        loaddata();
                    }
                }
                else
                {
                    Response.Redirect("~/KMDIweb/Global/Login.aspx");
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
        private void loadae()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "AF_Request_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "AE_List");
                        ddlAE.DataSource = sqlcmd.ExecuteReader();
                        ddlAE.DataTextField = "fullname";
                        ddlAE.DataValueField = "fullname";
                        ddlAE.DataBind();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        private string ae()
        {
            string fullname = Session["KMDI_fullname"].ToString();
            string user_code = Session["KMDI_user_code"].ToString();
            if (user_code == "AE")
            {
                return fullname;
            }
            else
            {
                return ddlAE.Text;
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
                        tb.Clear();
                        sqlcon.Open();
                        sqlcmd.CommandText = "AF_Request_Approval_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get");
                        sqlcmd.Parameters.AddWithValue("@Search", tboxSearch.Text);
                        sqlcmd.Parameters.AddWithValue("@AE", ae());
                        sqlcmd.Parameters.AddWithValue("@Req_Status", ddlStatus.Text);
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gv1.DataSource = tb;
                            gv1.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            finally
            {
                loadSummary();
            }
        }
        private void approve(string command, string comment, string id)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        DataTable tb = new DataTable();
                        tb.Clear();
                        sqlcon.Open();
                        sqlcmd.CommandText = "AF_Request_Approval_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", command);
                        sqlcmd.Parameters.AddWithValue("@Approval_Remarks", comment);
                        sqlcmd.Parameters.AddWithValue("@Id", id);
                        sqlcmd.Parameters.AddWithValue("@Approved_By", Session["KMDI_fullname"].ToString());
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
                loaddata();
            }
        }
        private void loadSummary()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        DataTable tb = new DataTable();
                        tb.Clear();
                        sqlcon.Open();
                        sqlcmd.CommandText = "AF_Request_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Summary");
                        sqlcmd.Parameters.AddWithValue("@AE", ae());
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvSummary.DataSource = tb;
                            gvSummary.DataBind();
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
            loaddata();
        }
        protected void gv1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myApprove")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gv1.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                string comment = ((TextBox)row.FindControl("tboxComment")).Text;
                approve("Approve",comment, id);
            }
            else if (e.CommandName == "myEdit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gv1.Rows[rowindex];
                if (((Panel)row.FindControl("pnlCommentEdit")).Visible == true)
                {
                    ((Panel)row.FindControl("pnlCommentEdit")).Visible = false;
                    ((Panel)row.FindControl("pnlComment")).Visible = true;
                }
                else
                {
                    ((Panel)row.FindControl("pnlCommentEdit")).Visible = true;
                    ((Panel)row.FindControl("pnlComment")).Visible = false;
                }
            }
            else if (e.CommandName == "myHold")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gv1.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                approve("Hold", "", id);
            }
            else if (e.CommandName == "myUnhold")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gv1.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                approve("Unhold", "", id);
            }
        }

        protected void gv1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gv1.PageIndex = e.NewPageIndex;
            loaddata();
        }

        protected void gvSummary_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ForApproval")
            {
                tboxSearch.Text = "";
                ddlAE.Text = "";
                ddlStatus.Text = "For Approval";
                loaddata();
            }
            else if (e.CommandName == "Approved")
            {
                tboxSearch.Text = "";
                ddlAE.Text = "";
                ddlStatus.Text = "Approved";
                loaddata();
            }
            else if (e.CommandName == "Hold")
            {
                tboxSearch.Text = "";
                ddlAE.Text = "";
                ddlStatus.Text = "Hold";
                loaddata();
            }
        }
        protected void gv1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell cell = e.Row.Cells[0];
                string status = ((Label)cell.FindControl("lblStatus")).Text;
                HoldAccess(cell, status);
            }
        }
        private void HoldAccess(TableCell cell, string status)
        {
            if (status == "Approved" || status == "For Approval")
            {
                ((LinkButton)cell.FindControl("btnHold")).Visible = true;
                ((LinkButton)cell.FindControl("btnUnhold")).Visible = false;
            }
            else if (status == "Hold")
            {
                ((LinkButton)cell.FindControl("btnUnhold")).Visible = true;
                ((LinkButton)cell.FindControl("btnHold")).Visible = false;
            }
            else
            {
                ((LinkButton)cell.FindControl("btnHold")).Visible = false;
                ((LinkButton)cell.FindControl("btnUnhold")).Visible = false;
            }
        }
    }
}