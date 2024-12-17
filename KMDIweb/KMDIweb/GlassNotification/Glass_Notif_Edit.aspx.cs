using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.GlassNotification
{
    public partial class Glass_Notif_Edit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    LoadItem();
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
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/GlassNotification/Glass_Notif_List.aspx" + AddQuerystring);
        }
        private string AddQuerystring
        {
            get
            {
                return "?Find=" + Request.QueryString["Find"].ToString() +
                    "&DateFilter=" + Request.QueryString["DateFilter"].ToString() +
                    "&Date=" + Request.QueryString["Date"].ToString() +
                    "&ForSignature=" + Request.QueryString["ForSignature"].ToString() +
                    "&PageIndex=" + Request.QueryString["PageIndex"].ToString();
            }
        }
        private void LoadItem()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Glass_PO_Notification_Item_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Select");
                        sqlcmd.Parameters.AddWithValue("@Glass_PO_Notification_Id", Request.QueryString["Id"].ToString());
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvtem.DataSource = tb;
                            gvtem.DataBind();
                        }
                    }
                }
            }
            catch (Exception e)
            {
                errorrmessage(e.ToString());
            }
        }

        protected void gvtem_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "execDelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvtem.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                ExecQuery("Delete", id, "");
            }
            else if (e.CommandName == "execEdit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvtem.Rows[rowindex];
                ((LinkButton)row.FindControl("btnSave")).Visible = true;
                ((LinkButton)row.FindControl("btnCancel")).Visible = true;
                ((TextBox)row.FindControl("tboxReasonEdit")).Visible = true;
                ((Label)row.FindControl("lblReason_Item")).Visible = false;
                ((LinkButton)row.FindControl("btnDelete")).Visible = false;
                ((LinkButton)row.FindControl("btnEdit")).Visible = false;
            }
            else if (e.CommandName == "execSave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvtem.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                string reason = ((TextBox)row.FindControl("tboxReasonEdit")).Text;
                ExecQuery("Update", id, reason);
            }
            else if (e.CommandName == "execCancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvtem.Rows[rowindex];
                ((LinkButton)row.FindControl("btnSave")).Visible = false;
                ((LinkButton)row.FindControl("btnCancel")).Visible = false;
                ((TextBox)row.FindControl("tboxReasonEdit")).Visible = false;
                ((Label)row.FindControl("lblReason_Item")).Visible = true;
                ((LinkButton)row.FindControl("btnDelete")).Visible = true;
                ((LinkButton)row.FindControl("btnEdit")).Visible = true;
            }
        }
        private void ExecQuery(string command, string id, string reason)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Glass_PO_Notification_Item_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", command);
                        sqlcmd.Parameters.AddWithValue("@Id", id);
                        sqlcmd.Parameters.AddWithValue("@Reason", reason);
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
                LoadItem();
            }
        }
    }
}