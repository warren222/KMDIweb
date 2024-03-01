using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.PO
{
    public partial class PO_ForApproval : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["PO_Search"] != null)
                {
                    tboxsearchkey.Text = Request.QueryString["PO_Search"].ToString();
                }
                if (Request.QueryString["PO_For_Signature"] != null)
                {
                    ddlForSignature.Text = Request.QueryString["PO_For_Signature"].ToString();
                }
                if (Request.QueryString["Date_Filter"] != null)
                {
                    ddlDateFilter.Text = Request.QueryString["Date_Filter"].ToString();
                }
                if (Request.QueryString["Date"] != null)
                {
                    tboxDate.Text = Request.QueryString["Date"].ToString();
                }
                if (Request.QueryString["PO_PageIndex"] != null)
                {
                    GridView1.PageIndex = Request.QueryString["PO_PageIndex"] != null ? Convert.ToInt32(Request.QueryString["PO_PageIndex"].ToString()) : 0;
                }
                getdata();
            }
        }
        private string usercode
        {
            get
            {
                return Session["KMDI_user_code"].ToString();
            }
        }
        private string user_fullname
        {
            get
            {
                return Session["KMDI_fullname"].ToString();
            }
        }

        private string poa
        {
            get
            {
                return Session["KMDI_poa_acct"].ToString();
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
        private void getdata()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Web_PO_Approval_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Submitted");
                        sqlcmd.Parameters.AddWithValue("@Search", tboxsearchkey.Text);
                        sqlcmd.Parameters.AddWithValue("@For_Signature", ddlForSignature.SelectedValue.ToString());
                        sqlcmd.Parameters.AddWithValue("@Date_Filter", ddlDateFilter.SelectedValue.ToString());
                        sqlcmd.Parameters.AddWithValue("@Date", tboxDate.Text);
                        sqlcmd.Parameters.AddWithValue("@POA_Acct", poa);
                        sqlcmd.Parameters.AddWithValue("@Fullname", user_fullname);
                        DataTable tb = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            finally
            {
                loadSummary();
            }
        }
        private void loadSummary()
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
                        sqlcmd.CommandText = "Web_PO_Approval_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Notification_Counter");
                        sqlcmd.Parameters.AddWithValue("@POA_Acct", poa);
                        sqlcmd.Parameters.AddWithValue("@Fullname", user_fullname);
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
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            getdata();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "view_request")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                string pono = ((Label)row.FindControl("lblPONO")).Text;
                string jono = ((Label)row.FindControl("lblJONO")).Text;
                string requested = ((Label)row.FindControl("lblREQUESTED")).Text;
                Session["POPO_No"] = pono;
                Session["POJO_No"] = jono;

                if (get_supplier(pono) == "Ajiya Safety Glass SDN BHD" ||
                    get_supplier(pono) == "Saint Gobain India Private Limited (Vetrotech Business)")
                {
                    Response.Redirect("~/KMDIweb/PO/PO_Ajiya_Rpt.aspx" + AddQuerystring + "&Requested_By=" + requested);
                }
                else
                {
                    if (get_computation(jono, pono) == "Laminated")
                    {
                        Response.Redirect("~/KMDIweb/PO/PO_Laminated_Rpt.aspx" + AddQuerystring + "&Requested_By=" + requested);
                    }
                    else if (get_computation(jono, pono) == "X")
                    {
                        Response.Redirect("~/KMDIweb/PO/PO_X_Rpt.aspx" + AddQuerystring + "&Requested_By=" + requested);
                    }
                    else
                    {
                        Response.Redirect("~/KMDIweb/PO/PO_Rpt.aspx" + AddQuerystring + "&Requested_By=" + requested);
                    }
                }
            }
        }
        private string AddQuerystring
        {
            get
            {
                return "?PO_Search=" + tboxsearchkey.Text + "&PO_For_Signature=" + ddlForSignature.SelectedValue.ToString() +
                       "&PO_PageIndex=" + GridView1.PageIndex.ToString() + "&Date_Filter=" + ddlDateFilter.SelectedValue.ToString() +
                       "&Date=" + tboxDate.Text;
            }
        }
        private string get_computation(string jono, string pono)
        {
            string computation = "";
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Web_PO_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Computation");
                        sqlcmd.Parameters.AddWithValue("@JO_No", jono);
                        sqlcmd.Parameters.AddWithValue("@PO_No", pono);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                computation = rd[0].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            return computation;
        }
        private string get_supplier(string pono)
        {
            string supplier = "";
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Web_PO_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Supplier");
                        sqlcmd.Parameters.AddWithValue("@PO_No", pono);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                supplier = rd[0].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            return supplier;
        }
        protected void gvSummary_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "PreparedBy")
            {
                tboxsearchkey.Text = "";
                ddlForSignature.Text = "Prepared by";
                getdata();
            }
            else if (e.CommandName == "NotedBy")
            {
                tboxsearchkey.Text = "";
                ddlForSignature.Text = "Noted by";
                getdata();
            }
            else if (e.CommandName == "ApprovedBy")
            {
                tboxsearchkey.Text = "";
                ddlForSignature.Text = "Approved by";
                getdata();
            }
            else if (e.CommandName == "Done")
            {
                tboxsearchkey.Text = "";
                ddlForSignature.SelectedIndex = 4;
                getdata();
            }
        }

        protected void gvSummary_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell cell = e.Row.Cells[0];
                LinkButton btnpreparedBy = ((LinkButton)cell.FindControl("btnPreparedBy"));
                LinkButton btnnotedBy = ((LinkButton)cell.FindControl("btnNotedBy"));
                LinkButton btnapprovedBy = ((LinkButton)cell.FindControl("btnApprvoedBy"));
                if (poa == "Admin")
                {
                    BtnAccess(btnpreparedBy, true, btnnotedBy, true, btnapprovedBy, true);
                }
                else if (poa == "PO")
                {
                    BtnAccess(btnpreparedBy, true, btnnotedBy, false, btnapprovedBy, false);
                }
                else if (poa == "Noter")
                {
                    BtnAccess(btnpreparedBy, false, btnnotedBy, true, btnapprovedBy, false);
                }
                else if (poa == "Approver")
                {
                    BtnAccess(btnpreparedBy, false, btnnotedBy, false, btnapprovedBy, true);
                }
                else
                {
                    BtnAccess(btnpreparedBy, false, btnnotedBy, false, btnapprovedBy, false);
                }
            }
        }
        private void BtnAccess(LinkButton btnpreparedBy, bool x,
                               LinkButton btnnotedBy, bool y,
                               LinkButton btnapprovedBy, bool z)
        {
            btnpreparedBy.Enabled = x;
            btnnotedBy.Enabled = y;
            btnapprovedBy.Enabled = z;

            if (x == false)
            {
                BtnDisabled(btnpreparedBy);
            }
            if (y == false)
            {
                BtnDisabled(btnnotedBy);
            }
            if (z == false)
            {
                BtnDisabled(btnapprovedBy);
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