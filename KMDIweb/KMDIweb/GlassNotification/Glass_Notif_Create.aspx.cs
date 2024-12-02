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
    public partial class Glass_Notif_Create : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
        private void Get_PO()
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
                        sqlcmd.Parameters.AddWithValue("@Command", "Find_PO");
                        sqlcmd.Parameters.AddWithValue("@Search", tboxFind.Text);
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvFind.DataSource = tb;
                            gvFind.DataBind();
                        }
                        string row_count = tb.Rows.Count.ToString("N0");
                        //lblResult.Text = row_count;
                    }
                    catch (Exception ex)
                    {
                        errorrmessage(ex.ToString());
                    }
                }
            }
        }
        protected void btnFind_Click(object sender, EventArgs e)
        {
            Get_PO();
        }

        protected void gvFind_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvFind.PageIndex = e.NewPageIndex;
            Get_PO();
        }

        protected void gvFind_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "view_po")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvFind.Rows[rowindex];
                row.RowState = DataControlRowState.Selected;
                string po = ((Label)row.FindControl("lblPO")).Text;
                string jono = ((Label)row.FindControl("lblJO")).Text;
                ViewState["PO"] = po;
                ViewState["SUPPLIER"] = ((Label)row.FindControl("lblSupplier")).Text;
                ViewState["PROJECT_NAME"] = ((Label)row.FindControl("lblProject_Name")).Text;
                ViewState["ADDRESS"] = ((Label)row.FindControl("lblAddress")).Text;
                Get_PO_Items(po, jono);
            }
        }
        private void Get_PO_Items(string po, string jono)
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
                        sqlcmd.Parameters.AddWithValue("@PO", po);
                        sqlcmd.Parameters.AddWithValue("@Job_Order_No", jono);
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvPO_Items.DataSource = tb;
                            gvPO_Items.DataBind();
                        }
                        string row_count = tb.Rows.Count.ToString("N0");
                        //lblResult.Text = row_count;
                    }
                    catch (Exception ex)
                    {
                        errorrmessage(ex.ToString());
                    }
                }
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
                InsertSelectedItems(Add_Notification());
            }
            catch(Exception ex)
            {
                if (ex == null)
                {
                    Response.Redirect("~/KMDIweb/GlassNotification/Glass_Notif_List.aspx");
                }
                else
                {
                    errorrmessage(ex.ToString());
                }
            }
           
        }

        private string Add_Notification()
        {
            string id = "";
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Glass_PO_Notification_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Insert");
                        sqlcmd.Parameters.AddWithValue("@PO", ViewState["PO"].ToString());
                        sqlcmd.Parameters.AddWithValue("@Supplier", ViewState["SUPPLIER"].ToString());
                        sqlcmd.Parameters.AddWithValue("@Project_Name", ViewState["PROJECT_NAME"].ToString());
                        sqlcmd.Parameters.AddWithValue("@Full_Address", ViewState["ADDRESS"].ToString());
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                id = rd[0].ToString();
                            }

                        }

                    }
                    catch (Exception ex)
                    {
                        errorrmessage(ex.ToString());
                    }
                }
            }
            return id;
        }
        private void Add_Notification_Item(string glass_po_notification_id)
        {


        }
    }
}