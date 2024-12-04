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
    public partial class Glass_Notif_List : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                RetriverQS();
                Get_Data();
            }
        }
        private void RetriverQS()
        {
            tboxFind.Text = Request.QueryString["Find"] != null ? Request.QueryString["Find"].ToString() : "";
            gvGlassNotifList.PageIndex = Request.QueryString["PageIndex"] != null ? Convert.ToInt32(Request.QueryString["PageIndex"].ToString()) : 0;
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
        protected void btnCreate_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/GlassNotification/Glass_Notif_Create.aspx");
        }
        private void Get_Data()
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
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Data");
                        sqlcmd.Parameters.AddWithValue("@Search", tboxFind.Text);
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvGlassNotifList.DataSource = tb;
                            gvGlassNotifList.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Get_Data();
        }

        protected void gvGlassNotifList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvGlassNotifList.PageIndex = e.NewPageIndex;
            Get_Data();
        }

        protected void gvGlassNotifList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "view_notification")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvGlassNotifList.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                string control_no = ((Label)row.FindControl("lblControl_No")).Text;
                Response.Redirect("~/KMDIweb/GlassNotification/Glass_Notif_Rpt.aspx?Glass_PO_Notification_Id=" + id + "&Control_No=" + control_no + AddQuerystring);
            }
        }
        private string AddQuerystring
        {
            get
            {
                return "&Find=" + tboxFind.Text + "&PageIndex=" + gvGlassNotifList.PageIndex.ToString();
            }
        }
        
    }
}