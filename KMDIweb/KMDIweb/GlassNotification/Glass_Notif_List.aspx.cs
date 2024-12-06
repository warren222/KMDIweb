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
                        sqlcmd.Parameters.AddWithValue("@For_Signature", ddlForSignature.SelectedValue.ToString());
                        sqlcmd.Parameters.AddWithValue("@Date_Filter", ddlDateFilter.SelectedValue.ToString());
                        sqlcmd.Parameters.AddWithValue("@Date", tboxDate.Text);
                        sqlcmd.Parameters.AddWithValue("@User_Code", user_code);
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
            finally
            {
                LoadSummary();
            }
        }
        private void LoadSummary()
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
                        sqlcmd.CommandText = "Glass_PO_Notification_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Notification_Counter");
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

        protected void gvSummary_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "PreparedBy")
            {
                tboxFind.Text = "";
                ddlDateFilter.Text = "All";
                tboxDate.Text = "";
                ddlForSignature.Text = "Prepared By";
                Get_Data();
            }
            else if (e.CommandName == "NotedBy")
            {
                tboxFind.Text = "";
                ddlDateFilter.Text = "All";
                tboxDate.Text = "";
                ddlForSignature.Text = "Noted By (Engr. Mon)";
                ddlForSignature.SelectedValue = "Noted By PM";
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
            else if (e.CommandName == "NotedBySirCule")
            {
                tboxFind.Text = "";
                ddlDateFilter.Text = "All";
                tboxDate.Text = "";
                ddlForSignature.Text = "Noted By (Engr. Cule)";
                ddlForSignature.SelectedValue = "Noted By IM";
                Get_Data();
            }
        }
        private string user_code
        {
            get
            {
                return Session["KMDI_user_code"].ToString();
            }
        }
        protected void gvSummary_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell cell = e.Row.Cells[0];
                LinkButton btnpreparedBy = ((LinkButton)cell.FindControl("btnPreparedBy"));
                LinkButton btnnotedByPM = ((LinkButton)cell.FindControl("btnNotedByPM"));
                LinkButton btnreceiveddBy = ((LinkButton)cell.FindControl("btnReceivedBy"));
                LinkButton btnnotedByIM = ((LinkButton)cell.FindControl("btnNotedByIM"));
                if (user_code == "Programmer")
                {
                    BtnAccess(btnpreparedBy, true, btnnotedByPM, true, btnreceiveddBy, true, btnnotedByIM, true);
                }
                else if (user_code == "Production Manager")
                {
                    BtnAccess(btnpreparedBy, false, btnnotedByPM, true, btnreceiveddBy, false, btnnotedByIM, false);
                }
                else if (user_code == "Delivery")
                {
                    BtnAccess(btnpreparedBy, false, btnnotedByPM, false, btnreceiveddBy, true, btnnotedByIM, false);
                }
                else if (user_code == "Engineer Manager")
                {
                    BtnAccess(btnpreparedBy, false, btnnotedByPM, false, btnreceiveddBy, false, btnnotedByIM, true);
                }
                else
                {
                    BtnAccess(btnpreparedBy, false, btnnotedByPM, false, btnreceiveddBy, false, btnnotedByIM, false);
                }
            }
        }
        private void BtnAccess(LinkButton btnpreparedBy, bool x,
                               LinkButton btnnotedByPM, bool y,
                               LinkButton btnreceiveddBy, bool z,
                               LinkButton btnnotedByIM, bool u)
        {
            btnpreparedBy.Enabled = x;
            btnnotedByPM.Enabled = y;
            btnreceiveddBy.Enabled = z;
            btnnotedByIM.Enabled = u;
            if (x == false)
            {
                BtnDisabled(btnpreparedBy);
            }
            if (y == false)
            {
                BtnDisabled(btnnotedByPM);
            }
            if (z == false)
            {
                BtnDisabled(btnreceiveddBy);
            }
            if (u == false)
            {
                BtnDisabled(btnnotedByIM);
            }
        }
        private void BtnDisabled(LinkButton btn)
        {
            btn.ForeColor = System.Drawing.Color.Black;
            btn.Font.Bold = false;
            btn.BackColor = System.Drawing.Color.White;
            btn.Style.Add("cursur", "not-allowed");
        }
    }
}