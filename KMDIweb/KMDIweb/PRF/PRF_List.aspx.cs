using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.PRF
{
    public partial class PRF_List : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    RetriverQS();
                    Get_Data();
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private void RetriverQS()
        {
            tboxFind.Text = Request.QueryString["Find"] != null ? Request.QueryString["Find"].ToString() : "";
            ddlDateFilter.SelectedValue = Request.QueryString["DateFilter"] != null ? Request.QueryString["DateFilter"].ToString() : "All";
            tboxDate.Text = Request.QueryString["Date"] != null ? Request.QueryString["Date"].ToString() : "";
            ddlForSignature.SelectedValue = Request.QueryString["ForSignature"] != null ? Request.QueryString["ForSignature"].ToString() : "All";
            gvList.PageIndex = Request.QueryString["PageIndex"] != null ? Convert.ToInt32(Request.QueryString["PageIndex"].ToString()) : 0;
        }
        private string user_code
        {
            get
            {
                return Session["KMDI_user_code"].ToString();
            }
        }
        private string fullname
        {
            get
            {
                return Session["KMDI_fullname"].ToString();
            }
        }
        private string sqlconstrInventory
        {
            get
            {
                return ConnectionString.sqlconstrInventory();
            }
        }
        private void Get_Data()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstrInventory))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "PRF_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Data");
                        sqlcmd.Parameters.AddWithValue("@Search", tboxFind.Text);
                        sqlcmd.Parameters.AddWithValue("@Date_Filter", ddlDateFilter.Text);
                        sqlcmd.Parameters.AddWithValue("@Date", tboxDate.Text);
                        sqlcmd.Parameters.AddWithValue("@For_Signature", ddlForSignature.Text);
                        sqlcmd.Parameters.AddWithValue("@User_Code", user_code);
                        sqlcmd.Parameters.AddWithValue("@Fullname", fullname);
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvList.DataSource = tb;
                            gvList.DataBind();
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
                LoadSummary();
            }
        }
        private void LoadSummary()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstrInventory))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        DataTable tb = new DataTable();
                        tb.Clear();
                        sqlcon.Open();
                        sqlcmd.CommandText = "PRF_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Notification_Counter");
                        sqlcmd.Parameters.AddWithValue("@Fullname", fullname);
                        //sqlcmd.Parameters.AddWithValue("@User_Code", user_code);
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
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "errorval";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Get_Data();
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PRF/PRF_Create.aspx?Id=0" + AddQuerystring);
        }
        private string AddQuerystring
        {
            get
            {
                return "&Find=" + tboxFind.Text +
                       "&DateFilter=" + ddlDateFilter.SelectedValue.ToString() +
                       "&Date=" + tboxDate.Text +
                       "&ForSignature=" + ddlForSignature.SelectedValue.ToString() +
                       "&PageIndex=" + gvList.PageIndex.ToString();
            }
        }

        protected void gvList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "execDelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvList.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                string notedby = ((Label)row.FindControl("lblNoted_By")).Text;
                string requestedby = ((Label)row.FindControl("lblRequested_By")).Text;
                if (requestedby == fullname)
                {
                    if (notedby == "")
                    {
                        DeleteItem(id);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, GetType(), "warning", "alert('WARNING: Sorry! Unable to delete signed request :(');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, GetType(), "warning", "alert('WARNING: Sorry! Unable to delete due to ownership issue :(');", true);
                }

            }
            else if (e.CommandName == "execEdit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvList.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                string notedby = ((Label)row.FindControl("lblNoted_By")).Text;
                string requestedby = ((Label)row.FindControl("lblRequested_By")).Text;
                if (requestedby == fullname)
                {
                    if (notedby == "")
                    {
                        Response.Redirect("~/KMDIweb/PRF/PRF_Update.aspx?Id=" + id + AddQuerystring);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, GetType(), "warning", "alert('WARNING: Sorry! Unable to edit signed request :(');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, GetType(), "warning", "alert('WARNING: Sorry! Unable to edit due to ownership issue :(');", true);
                }

            }
            else if (e.CommandName == "execReport")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvList.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                Response.Redirect("~/KMDIweb/PRF/PRF_Report.aspx?Id=" + id + AddQuerystring);
            }
        }
        private void DeleteItem(string id)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstrInventory))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "PRF_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Delete");
                        sqlcmd.Parameters.AddWithValue("@Id", id);
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
                Get_Data();
            }
        }

        protected void gvList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvList.PageIndex = e.NewPageIndex;
            Get_Data();
        }


        protected void gvSummary_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "RequestedBy")
            {
                tboxFind.Text = "";
                ddlDateFilter.Text = "All";
                tboxDate.Text = "";
                ddlForSignature.Text = "Requested By";
                Get_Data();
            }
            else if (e.CommandName == "NotedBy")
            {
                tboxFind.Text = "";
                ddlDateFilter.Text = "All";
                tboxDate.Text = "";
                ddlForSignature.SelectedValue = "Noted By";
                Get_Data();
            }
            else if (e.CommandName == "ReceivedBy")
            {
                tboxFind.Text = "";
                ddlDateFilter.Text = "All";
                tboxDate.Text = "";
                ddlForSignature.Text = "Received By";
                Get_Data();
            }
            else if (e.CommandName == "ApprovedBy")
            {
                tboxFind.Text = "";
                ddlDateFilter.Text = "All";
                tboxDate.Text = "";
                ddlForSignature.SelectedValue = "Approved By";
                Get_Data();
            }
            else if (e.CommandName == "SignedPRFs")
            {
                tboxFind.Text = "";
                ddlDateFilter.Text = "All";
                tboxDate.Text = "";
                ddlForSignature.SelectedValue = "Signed PRFs";
                Get_Data();
            }
        }
    }
}