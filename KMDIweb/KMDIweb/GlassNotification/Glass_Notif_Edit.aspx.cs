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
        private void Get_PO_Items()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Glass_PO_Notification_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_PO_Items");
                        sqlcmd.Parameters.AddWithValue("@PO", Request.QueryString["PO"].ToString());
                        sqlcmd.Parameters.AddWithValue("@Job_Order_No", Request.QueryString["JO"].ToString());
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvPO_Items.DataSource = tb;
                            gvPO_Items.DataBind();
                        }
                       
                    }
                    catch (Exception ex)
                    {
                        errorrmessage(ex.ToString());
                    }
                }
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
        private void InsertSelectedItems(string glass_po_notification_id)
        {
            for (int i = 0; i <= gvPO_Items.Rows.Count - 1; i++)
            {
                GridViewRow row = gvPO_Items.Rows[i];
                CheckBox cbk = (CheckBox)row.FindControl("cboxSelect");
                if (cbk.Checked)
                {
                    string kno, gno, glass_specs, width, height, qty, due_date, delivery_schedule, reason;
                    kno = ((Label)row.FindControl("lblK_No")).Text.ToString();
                    gno = ((Label)row.FindControl("lblG_No")).Text.ToString();
                    glass_specs = ((Label)row.FindControl("lblGlass_Specs")).Text.ToString();
                    width = ((Label)row.FindControl("lblWidth")).Text.ToString();
                    height = ((Label)row.FindControl("lblHeight")).Text.ToString();
                    qty = ((Label)row.FindControl("lblQty")).Text.ToString();
                    due_date = ((Label)row.FindControl("lblDue_Date")).Text.ToString();
                    delivery_schedule = ((Label)row.FindControl("lblDelivery_Schedule")).Text.ToString();
                    reason = ((TextBox)row.FindControl("tboxReason")).Text.ToString();
                    using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                    {
                        using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                        {
                            try
                            {
                                sqlcon.Open();
                                sqlcmd.CommandText = "Glass_PO_Notification_Item_Stp";
                                sqlcmd.CommandType = CommandType.StoredProcedure;
                                sqlcmd.Parameters.AddWithValue("@Command", "Insert");
                                sqlcmd.Parameters.AddWithValue("@Glass_PO_Notification_Id", glass_po_notification_id);
                                sqlcmd.Parameters.AddWithValue("@K_No", kno);
                                sqlcmd.Parameters.AddWithValue("@G_No", gno);
                                sqlcmd.Parameters.AddWithValue("@Glass_Specs", glass_specs);
                                sqlcmd.Parameters.AddWithValue("@Width", width);
                                sqlcmd.Parameters.AddWithValue("@Height", height);
                                sqlcmd.Parameters.AddWithValue("@Qty", qty);
                                sqlcmd.Parameters.AddWithValue("@Due_Date", due_date);
                                sqlcmd.Parameters.AddWithValue("@Delivery_Schedule", delivery_schedule);
                                sqlcmd.Parameters.AddWithValue("@Reason", reason);

                                sqlcmd.ExecuteNonQuery();
                            }
                            catch (Exception ex)
                            {
                                errorrmessage(ex.ToString());
                            }
                        }
                    }
                }
            }
        }

        protected void btnProceed_Click1(object sender, EventArgs e)
        {
            try
            {
                InsertSelectedItems(Request.QueryString["Id"].ToString());
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            finally
            {
                btnGet_PO_Items.Text = "Show PO";
                pnlPO_Items.Visible = false;
                LoadItem();
            }

        }

        protected void btnGet_PO_Items_Click(object sender, EventArgs e)
        {
            if (pnlPO_Items.Visible ==  true)
            {
                btnGet_PO_Items.Text = "Show PO";
                pnlPO_Items.Visible = false;
            }
            else
            {
                btnGet_PO_Items.Text = "Hide PO";
                pnlPO_Items.Visible = true;
            }
          
            Get_PO_Items();
        }
    }
}