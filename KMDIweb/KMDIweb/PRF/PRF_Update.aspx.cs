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
    public partial class PRF_Update : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    GetControlNumber(controlId);
                    GetItem();
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        string controlId
        {
            get
            {
                return Request.QueryString["Id"].ToString();
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
        private void GetControlNumber(string controlNumber)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
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
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "PRF_Item_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Insert");
                        sqlcmd.Parameters.AddWithValue("@PRF_Id", controlId);
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
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "PRF_Item_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get");
                        sqlcmd.Parameters.AddWithValue("@PRF_Id", controlId);
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
            if (e.CommandName == "execEdit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvItems.Rows[rowindex];
                ((LinkButton)row.FindControl("btnDelete")).Visible = false;
                ((LinkButton)row.FindControl("btnEdit")).Visible = false;
                ((LinkButton)row.FindControl("btnSave")).Visible = true;
                ((LinkButton)row.FindControl("btnCancel")).Visible = true;

                ((TextBox)row.FindControl("tboxItemDescriptionEdit")).Visible = true;
                ((TextBox)row.FindControl("tboxQuantityEdit")).Visible = true;
                ((TextBox)row.FindControl("tboxAccountEdit")).Visible = true;
                ((TextBox)row.FindControl("tboxRemarksEdit")).Visible = true;
                ((Label)row.FindControl("lblItemDescription")).Visible = false;
                ((Label)row.FindControl("lblQuantity")).Visible = false;
                ((Label)row.FindControl("lblAccount")).Visible = false;
                ((Label)row.FindControl("lblRemarks")).Visible = false;
            }
            if (e.CommandName == "execCancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvItems.Rows[rowindex];
                ((LinkButton)row.FindControl("btnDelete")).Visible = true;
                ((LinkButton)row.FindControl("btnEdit")).Visible = true;
                ((LinkButton)row.FindControl("btnSave")).Visible = false;
                ((LinkButton)row.FindControl("btnCancel")).Visible = false;

                ((TextBox)row.FindControl("tboxItemDescriptionEdit")).Visible = false;
                ((TextBox)row.FindControl("tboxQuantityEdit")).Visible = false;
                ((TextBox)row.FindControl("tboxAccountEdit")).Visible = false;
                ((TextBox)row.FindControl("tboxRemarksEdit")).Visible = false;
                ((Label)row.FindControl("lblItemDescription")).Visible = true;
                ((Label)row.FindControl("lblQuantity")).Visible = true;
                ((Label)row.FindControl("lblAccount")).Visible = true;
                ((Label)row.FindControl("lblRemarks")).Visible = true;
            }
            if (e.CommandName == "execSave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvItems.Rows[rowindex];
                string id = ((Label)row.FindControl("lblItemId")).Text;
                string itemDescription = ((TextBox)row.FindControl("tboxItemDescriptionEdit")).Text;
                string quantity = ((TextBox)row.FindControl("tboxQuantityEdit")).Text;
                string account = ((TextBox)row.FindControl("tboxAccountEdit")).Text;
                string remarks = ((TextBox)row.FindControl("tboxRemarksEdit")).Text;
                UpdateItem(id, itemDescription, quantity, account, remarks);
            }
        }
        private void DeleteItem(string id)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
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
        private void UpdateItem(string id, string itemDescription, string quantity, string account, string remarks)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "PRF_Item_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Update");
                        sqlcmd.Parameters.AddWithValue("@Id", id);
                        sqlcmd.Parameters.AddWithValue("@PRF_Id", controlId);
                        sqlcmd.Parameters.AddWithValue("@Item_Description", itemDescription);
                        sqlcmd.Parameters.AddWithValue("@Qty", quantity);
                        sqlcmd.Parameters.AddWithValue("@Account", account);
                        sqlcmd.Parameters.AddWithValue("@Remarks", remarks);
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
        protected void btnProceed_Click(object sender, EventArgs e)
        {
            InserItem();
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Get_Inventory_Items();
        }
        private void Get_Inventory_Items()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
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