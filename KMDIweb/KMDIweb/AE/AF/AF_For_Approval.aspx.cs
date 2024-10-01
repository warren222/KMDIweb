using KMDIweb.KMDIweb.Global.FileBL;
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
                        sqlcmd.Parameters.AddWithValue("@Date_Filter", ddlDate_Filter.Text);
                        sqlcmd.Parameters.AddWithValue("@Date", tboxDate.Text);
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
        private void Execute_Query(string command, string comment, string id)
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
                Execute_Query("Approve", "", id);
            }
            else if (e.CommandName == "myApproval_Remarks")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gv1.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                string comment = ((TextBox)row.FindControl("tboxComment")).Text;
                Execute_Query("Approval_Remarks", comment, id);
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
            else if (e.CommandName == "myOpenHold")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gv1.Rows[rowindex];
                ((Panel)row.FindControl("pnlHold")).Visible = true;
                ((LinkButton)row.FindControl("btnOpenHold")).Visible = false;
            }
            else if (e.CommandName == "myHold")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gv1.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                Execute_Query("Hold", "", id);
            }
            else if (e.CommandName == "myHoldReason")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gv1.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                string comment = ((TextBox)row.FindControl("tboxReason")).Text;
                Execute_Query("Hold_Reason", comment, id);
            }
            else if (e.CommandName == "myUnhold")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gv1.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                Execute_Query("Unhold", "", id);
            }
            else if (e.CommandName == "myEditReason")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gv1.Rows[rowindex];
                ((Panel)row.FindControl("pnlHold")).Visible = true;
                ((Panel)row.FindControl("pnlHoldReason")).Visible = false;
                ((LinkButton)row.FindControl("btnHold")).Visible = false;
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
        protected void gvFiles_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myView")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = ((GridView)sender).Rows[rowindex];
                string file_path = ((Label)row.FindControl("lblFile_Path")).Text;
                Response.Redirect(file_path);
            }
        }
        protected void gv1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell cell = e.Row.Cells[0];
                string status = ((Label)cell.FindControl("lblStatus")).Text;
                HoldAccess(cell, status);


                string id = ((Label)cell.FindControl("lblId")).Text;
                string folder_path = "~/KMDI_FILES/WMS/AF_Attachment/" + id;
                File_Upload_BusinessLogic x = new File_Upload_BusinessLogic();
                ((GridView)cell.FindControl("gvFiles")).DataSource = x.Files_In_Model_Virtual(folder_path);
                ((GridView)cell.FindControl("gvFiles")).DataBind();
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
                ((LinkButton)cell.FindControl("btnHold")).Visible = false;


                string holdby = ((Label)cell.FindControl("lblHoldBy")).Text;
                string fullname = Session["KMDI_fullname"].ToString();
                string user_code = Session["KMDI_user_code"].ToString();

                if (user_code == "Programmer")
                {
                    ((LinkButton)cell.FindControl("btnUnhold")).Visible = true;
                }
                else
                {
                    if (holdby == fullname)
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
    }
}