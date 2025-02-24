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
    public partial class PRF_Create : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {

                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private string sqlconstrInventory
        {
            get
            {
                return ConnectionString.sqlconstrInventory();
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
            Response.Redirect("~/KMDIweb/PRF/PRF_List.aspx" + AddQuerystring);
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

        protected void btnProceed_Click(object sender, EventArgs e)
        {
            InserItem();
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
        protected void btnCreate_Click(object sender, EventArgs e)
        {
            GetControlNumber(CreateControlNumber());
        }
        private string CreateControlNumber()
        {
            string result = "";
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstrInventory))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "PRF_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Insert");
                        sqlcmd.Parameters.AddWithValue("@Due_Date", tboxDueDate.Text);
                        sqlcmd.Parameters.AddWithValue("@Fullname", fullname);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                result = rd[0].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            return result;
        }
        private void GetControlNumber(string controlNumber)
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
                        sqlcmd.Parameters.AddWithValue("@Command", "Select");
                        sqlcmd.Parameters.AddWithValue("@Id", controlNumber);
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvControlNo.DataSource = tb;
                            gvControlNo.DataBind();
                        }
                        if (tb.Rows.Count == 1)
                        {
                            lblControlNumberHeader.Text = "Thank you! your control number is set.";
                            pnlCtrlNumberCreate.Visible = false;
                            pnlPRFInput.Visible = true;
                            GridViewRow row = gvControlNo.Rows[0];
                            ViewState["PRF_Id"] = ((Label)row.Cells[0].FindControl("lblId")).Text.ToString();
                        }
                        else
                        {
                            pnlCtrlNumberCreate.Visible = true;
                            pnlPRFInput.Visible = false;
                            pnlCtrlNumberCreate.Visible = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
        private void InserItem()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstrInventory))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "PRF_Item_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Insert");
                        sqlcmd.Parameters.AddWithValue("@PRF_Id", ViewState["PRF_Id"].ToString());
                        sqlcmd.Parameters.AddWithValue("@Item_Description", tboxItemDescription.Text);
                        sqlcmd.Parameters.AddWithValue("@Qty", tboxQuantity.Text);
                        sqlcmd.Parameters.AddWithValue("@Account", tboxAccount.Text);
                        sqlcmd.Parameters.AddWithValue("@Remarks", tboxRemarks.Text);
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
                GetItem();
            }
        }
        private void GetItem()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstrInventory))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "PRF_Item_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get");
                        sqlcmd.Parameters.AddWithValue("@PRF_Id", ViewState["PRF_Id"].ToString());
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvItems.DataSource = tb;
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

        protected void gvItems_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "execDelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvItems.Rows[rowindex];
                string id = ((Label)row.FindControl("lblItemId")).Text;
                DeleteItem(id);
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
                        sqlcmd.CommandText = "PRF_Item_Stp";
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
                GetItem();
            }   
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Get_Inventory_Items();
        }
        private void Get_Inventory_Items()
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
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Inventory_Items");
                        sqlcmd.Parameters.AddWithValue("@Search", tboxSearch.Text);
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvInventoryItem.DataSource = tb;
                            gvInventoryItem.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
        protected void gvInventoryItem_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "execSelect")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvInventoryItem.Rows[rowindex];
                tboxItemDescription.Text = ((Label)row.FindControl("lblItem_Description")).Text;
                row.RowState = DataControlRowState.Selected;
            }
        }

        protected void gvInventoryItem_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvInventoryItem.PageIndex = e.NewPageIndex;
            Get_Inventory_Items();
        }
    }
}