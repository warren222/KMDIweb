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
    public partial class AF_For_Checking : System.Web.UI.Page
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
                        if (Session["KMDI_user_code"].ToString() == "AE")
                        {
                            ddlAE.Enabled = false;
                        }
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
                        sqlcmd.CommandText = "AF_Request_Check_Stp";
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
        private void check(string command, string comment, string id)
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
                        sqlcmd.CommandText = "AF_Request_Check_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", command);
                        sqlcmd.Parameters.AddWithValue("@Checked_Remarks", comment);
                        sqlcmd.Parameters.AddWithValue("@Id", id);
                        sqlcmd.Parameters.AddWithValue("@Checked_By", Session["KMDI_fullname"].ToString());
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            loaddata();
        }

        protected void gv1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myCheck")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gv1.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                string comment = ((TextBox)row.FindControl("tboxComment")).Text;
                check("Check", comment, id);
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
            else if (e.CommandName == "myEditParticular")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gv1.Rows[rowindex];
                if (((Panel)row.FindControl("pnlCommentEditParticular")).Visible == true)
                {
                    ((Panel)row.FindControl("pnlCommentEditParticular")).Visible = false;
                    ((Panel)row.FindControl("pnlCommentParticular")).Visible = true;
                }
                else
                {
                    ((Panel)row.FindControl("pnlCommentEditParticular")).Visible = true;
                    ((Panel)row.FindControl("pnlCommentParticular")).Visible = false;
                }
            }
            else if (e.CommandName == "mySaveParticular")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gv1.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                string particular = ((TextBox)row.FindControl("tboxCommentParticular")).Text;
                Edit_Request(id, particular);
            }
            else if (e.CommandName == "myDone")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gv1.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                check("Done", "", id);
            }
            else if (e.CommandName == "myHold")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gv1.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                check("Hold", "", id);
            }
            else if (e.CommandName == "myUnhold")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gv1.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                check("Unhold", "", id);
            }
        }
        private void Edit_Request(string id, string particular)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "AF_Request_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Edit");
                        sqlcmd.Parameters.AddWithValue("@Id", id);
                        sqlcmd.Parameters.AddWithValue("@Particular", particular);
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
            else if (e.CommandName == "ForChecking")
            {
                tboxSearch.Text = "";
                ddlAE.Text = "";
                ddlStatus.Text = "For Checking";
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
        private void HoldAccess(TableCell cell, string status)
        {
            if (status == "For Checking" || status == "For Approval")
            {
                ((LinkButton)cell.FindControl("btnHold")).Visible = true;
                ((LinkButton)cell.FindControl("btnUnhold")).Visible = false;
            }
            else if (status == "Hold")
            {
             
                ((LinkButton)cell.FindControl("btnHold")).Visible = false;
                ((LinkButton)cell.FindControl("btnEdit")).Visible = false;
                ((LinkButton)cell.FindControl("btnEditParticular")).Visible = false;
                ((LinkButton)cell.FindControl("btnDone")).Visible = false;

                string heldby = ((Label)cell.FindControl("lblHoldBy")).Text;
                string fullname = Session["KMDI_fullname"].ToString();
                string user_code = Session["KMDI_user_code"].ToString();

                if (user_code == "Programmer")
                {
                    ((LinkButton)cell.FindControl("btnUnhold")).Visible = true;
                }
                else
                {
                    if(heldby == fullname)
                    {
                        ((LinkButton)cell.FindControl("btnUnhold")).Visible = true;
                    }
                    else
                    {
                        ((LinkButton)cell.FindControl("btnUnhold")).Visible = false;
                    }
                }
            }
            else
            {
                ((LinkButton)cell.FindControl("btnHold")).Visible = false;
                ((LinkButton)cell.FindControl("btnUnhold")).Visible = false;
            }
        }
        private void EditParticularAccess(TableCell cell, string status)
        {
            if (status == "For Checking")
            {
                ((LinkButton)cell.FindControl("btnEditParticular")).Visible = true;
            }
            else
            {
                ((LinkButton)cell.FindControl("btnEditParticular")).Visible = false;
            }
        }
        private void ForCheckingAccess(TableCell cell, string status)
        {
            if (status == "For Checking")
            {
                ((Panel)cell.FindControl("pnlCommentEdit")).Visible = true;
                ((LinkButton)cell.FindControl("btnEdit")).Visible = false;
                ((LinkButton)cell.FindControl("btnDone")).Visible = false;
            }
            else if (status == "For Approval")
            {
                ((Panel)cell.FindControl("pnlCommentEdit")).Visible = false;
                ((LinkButton)cell.FindControl("btnEdit")).Visible = true;
                ((LinkButton)cell.FindControl("btnDone")).Visible = false;
            }
            else if (status == "Approved")
            {
                ((LinkButton)cell.FindControl("btnEdit")).Visible = false;
                ((Panel)cell.FindControl("pnlCommentEdit")).Visible = false;
                ((LinkButton)cell.FindControl("btnDone")).Visible = true;
            }
            else
            {
                ((LinkButton)cell.FindControl("btnEdit")).Visible = false;
                ((Panel)cell.FindControl("pnlCommentEdit")).Visible = false;
                ((LinkButton)cell.FindControl("btnDone")).Visible = false;
            }
        }
        private void DisableCheckingAccess(TableCell cell, string status)
        {
            ((Panel)cell.FindControl("pnlCommentEdit")).Visible = false;
            ((LinkButton)cell.FindControl("btnEdit")).Visible = false;
            ((LinkButton)cell.FindControl("btnDone")).Visible = false;
        }
        protected void gv1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell cell = e.Row.Cells[0];
                string status = ((Label)cell.FindControl("lblStatus")).Text;

                if (Session["KMDI_user_code"].ToString() == "Programmer")
                {
                    ForCheckingAccess(cell, status);
                    EditParticularAccess(cell, status);
                    HoldAccess(cell, status);
                }
                else if (Session["KMDI_fullname"].ToString() == "Jayvey Manalili")
                {
                    ForCheckingAccess(cell, status);
                }

                else if (Session["KMDI_user_code"].ToString() == "AE")
                {
                    DisableCheckingAccess(cell, status);
                    EditParticularAccess(cell, status);
                    HoldAccess(cell, status);
                }
                else
                {
                    ((LinkButton)cell.FindControl("btnEditParticular")).Visible = false;
                    ((Panel)cell.FindControl("pnlCommentEdit")).Visible = false;
                    ((LinkButton)cell.FindControl("btnEdit")).Visible = false;
                    ((LinkButton)cell.FindControl("btnDone")).Visible = false;
                }
            }
        }
    }
}