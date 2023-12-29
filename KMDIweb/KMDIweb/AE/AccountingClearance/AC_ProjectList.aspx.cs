using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.AE.AccountingClearance
{
    public partial class AC_ProjectList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["KMDI_userid"] != null)
                {
                    if (!IsPostBack)
                    {
                        if (Session["KMDI_user_code"].ToString() == "Accounting")
                        {
                            Response.Redirect("~/KMDIweb/AE/AccountingClearance/AC_For_Approval.aspx");
                        }
                        else if (Session["KMDI_user_code"].ToString() == "Operations" && Session["KMDI_fullname"].ToString() == "Leo Candelaria")
                        {
                            Response.Redirect("~/KMDIweb/AE/AccountingClearance/AC_For_Trun_Over.aspx");
                        }
                        if (Session["KMDI_user_code"].ToString() == "AE")
                        {
                            ddlAE.Enabled = false;
                        }
                        else
                        {
                            ddlAE.Enabled = true;
                        }
                        loadae();
                        loaddata();
                    }
                }
                else
                {
                    Response.Redirect("~/KMDIweb/Global/Login.aspx");
                }
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
        private void loadae()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "AC_Request_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "AE_List");
                        ddlAE.DataSource = sqlcmd.ExecuteReader();
                        ddlAE.DataTextField = "fullname";
                        ddlAE.DataValueField = "fullname";
                        ddlAE.DataBind();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        private string fullname
        {
            get
            {
                return Session["KMDI_fullname"].ToString();
            }
        }
        private string ae()
        {
            string user_code = Session["KMDI_user_code"].ToString();
            if (user_code == "AE")
            {
                return fullname;
            }
            else
            {
                return ddlAE.Text;
            }
        }
        private void loaddata()
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
                        sqlcmd.CommandText = "AC_Request_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Project");
                        sqlcmd.Parameters.AddWithValue("@Search", tboxSearch.Text);
                        sqlcmd.Parameters.AddWithValue("@AE", ae());
                        sqlcmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue.ToString());
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvProject.DataSource = tb;
                            gvProject.DataBind();
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
                        sqlcmd.CommandText = "AC_Request_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Project");
                        sqlcmd.Parameters.AddWithValue("@SubCommand", "Summary");
                        sqlcmd.Parameters.AddWithValue("@AE", ae());
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
        private void executeQuery(string command, string parentjono, string jo)
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
                        sqlcmd.CommandText = "AC_Request_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", command);
                        sqlcmd.Parameters.AddWithValue("@JO_Parent", parentjono);
                        sqlcmd.Parameters.AddWithValue("@JO", jo);
                        sqlcmd.Parameters.AddWithValue("@Account_Exec", fullname);
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
                loaddata();
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            loaddata();
        }
        protected void gvProject_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "sendRequest")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvProject.Rows[rowindex];
                string parentjono = ((Label)row.FindControl("lblParentjono")).Text;
                string jo = ((DropDownList)row.FindControl("dlJO")).SelectedValue.ToString();
                executeQuery("Insert", parentjono, jo);
            }
            else if (e.CommandName == "cancelRequest")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvProject.Rows[rowindex];
                string parentjono = ((Label)row.FindControl("lblParentjono")).Text;
                string jo = ((Label)row.FindControl("lblJob_Order_No")).Text;
                executeQuery("Delete", parentjono, jo);
            }
        }

        protected void gvProject_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvProject.PageIndex = e.NewPageIndex;
            loaddata();
        }
        protected void gvSummary_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ForApproval")
            {
                tboxSearch.Text = "";
                ddlAE.Text = "";
                ddlStatus.Text = "For Approval";
                loaddata();
            }
            else if (e.CommandName == "Approved")
            {
                tboxSearch.Text = "";
                ddlAE.Text = "";
                ddlStatus.Text = "Approved";
                loaddata();
            }
            else if (e.CommandName == "Hold")
            {
                tboxSearch.Text = "";
                ddlAE.Text = "";
                ddlStatus.Text = "Hold";
                loaddata();
            }
        }

        protected void gvProject_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell cell = e.Row.Cells[0];
                string parentjo = ((Label)cell.FindControl("lblParentjono")).Text;
                ((DropDownList)cell.FindControl("dlJO")).DataSource = JO_List_DS(parentjo);
                ((DropDownList)cell.FindControl("dlJO")).DataValueField = "job_order_no";
                ((DropDownList)cell.FindControl("dlJO")).DataTextField = "sub_jo";
                ((DropDownList)cell.FindControl("dlJO")).DataBind();
            }
        }
        private List<JO_ListModel> JO_List_DS(string parentjono)
        {
            List<JO_ListModel> modelList = new List<JO_ListModel>();
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        DataTable tb = new DataTable();

                        tb.Clear();
                        sqlcon.Open();
                        sqlcmd.CommandText = "AC_Request_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "JO List");
                        sqlcmd.Parameters.AddWithValue("@JO_Parent", parentjono);
                        SqlDataReader rd = sqlcmd.ExecuteReader();
                        while (rd.Read())
                        {
                            JO_ListModel model = new JO_ListModel();
                            model.Job_Order_No = rd[0].ToString();
                            model.Sub_JO = rd[1].ToString();
                            modelList.Add(model);
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            return modelList;
        }
    }
}