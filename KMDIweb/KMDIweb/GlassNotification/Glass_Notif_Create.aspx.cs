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
                Get_PO_Items(po,jono);
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

        protected void btnProceed_Click(object sender, EventArgs e)
        {

        }
    }
}