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
    public partial class Glass_Notif_Receiving_Update : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    SelectNotif();
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
        private void SelectNotif()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Glass_PO_Notification_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Select");
                        sqlcmd.Parameters.AddWithValue("@Id", Request.QueryString["Id"]);
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvSelectNotif.DataSource = tb;
                            gvSelectNotif.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
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

        private void ExecQuery(string command, string id, string update_reason, string update_received_qty)
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
                        sqlcmd.Parameters.AddWithValue("@Glass_PO_Notification_Id", Request.QueryString["Id"].ToString());
                        sqlcmd.Parameters.AddWithValue("@Update_Reason", update_reason);
                        sqlcmd.Parameters.AddWithValue("@Update_Received_Qty", update_received_qty);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                for (int i = 0; i <= gvtem.Rows.Count - 1; i++)
                {
                    GridViewRow row = gvtem.Rows[i];
                    string id = ((Label)row.FindControl("lblId")).Text;
                    string update_reason = ((TextBox)row.FindControl("tboxUpdateReasonEdit")).Text;
                    string update_received_qty = ((TextBox)row.FindControl("tboxUpdateReceivedQtyEdit")).Text;
                    ExecQuery("Glass_Notif_Update", id, update_reason, update_received_qty);
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