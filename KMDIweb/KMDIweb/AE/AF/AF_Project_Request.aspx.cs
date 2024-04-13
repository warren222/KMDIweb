using KMDIweb.KMDIweb.SessionVariables;
using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.AE.AF
{
    public partial class AF_Project_Request : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["KMDI_userid"] != null)
                {
                    if (!IsPostBack)
                    {
                        Get_Project_Details();
                        Get_Arch_List();
                        Get_Requests();
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

        private void Get_Project_Details()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "AF_Request_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Project_Details");
                        sqlcmd.Parameters.AddWithValue("@JO_Parent", Request.QueryString["jo_parent"]);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                lblProject.Text = rd[0].ToString();
                                lblAddress.Text = rd[1].ToString();
                                lblJO.Text = rd[2].ToString();
                                lblContract_Price.Text = rd[3].ToString();
                            }
                        }

                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        private void Get_Requests()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        DataTable tb = new DataTable();
                        tb.Clear();
                        sqlcon.Open();
                        sqlcmd.CommandText = "AF_Request_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Project_Request");
                        sqlcmd.Parameters.AddWithValue("@JO_Parent", Request.QueryString["jo_parent"]);
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvRequestList.DataSource = tb;
                            gvRequestList.DataBind();
                        }
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                    finally
                    {
                        loadSummary();
                    }
                }
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
                        sqlcmd.CommandText = "AF_Request_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Summary_By_JO");
                        sqlcmd.Parameters.AddWithValue("@JO_Parent", Request.QueryString["jo_parent"]);
                        sqlcmd.Parameters.AddWithValue("@AE", "");
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
        private void Get_Arch_List()
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
                        sqlcmd.CommandText = "AF_Request_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Architects");
                        sqlcmd.Parameters.AddWithValue("@JO_Parent", Request.QueryString["jo_parent"]);
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvArchEmp.DataSource = tb;
                            gvArchEmp.DataBind();
                        }
                        if (gvArchEmp.Rows.Count == 0)
                        {
                            btnSubmitRequest.Visible = false;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/AE/AF/AF_Project_List.aspx" + AddQueryStrings());
        }
        private string AddQueryStrings()
        {
            return "?page_index=" + Request.QueryString["page_index"] +
                "&search=" + Request.QueryString["search"] +
                "&ae=" + Request.QueryString["ae"];
        }
        string identifier="";
        string account_exec="";
        string request="";
        string particular="";
        protected void btnSubmitRequest_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvArchEmp.Rows)
            {
                if (((CheckBox)row.FindControl("cbox")).Checked)
                {
                    identifier = ((Label)row.FindControl("lblIdentifier")).Text;
                    account_exec = Session["KMDI_fullname"].ToString();
                    request = ((DropDownList)row.FindControl("ddlRequest")).Text;
                    particular = ((TextBox)row.FindControl("tboxParticular")).Text;
                    Send_Request();
                }
            }
        }
        private void Send_Request()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "AF_Request_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Insert");
                        sqlcmd.Parameters.AddWithValue("@SubCommand", "Manual");
                        sqlcmd.Parameters.AddWithValue("@JO_Parent", Request.QueryString["jo_parent"]);
                        sqlcmd.Parameters.AddWithValue("@Arch_Id", identifier);
                        sqlcmd.Parameters.AddWithValue("@Account_Exec", account_exec);
                        sqlcmd.Parameters.AddWithValue("@Request", request);
                        sqlcmd.Parameters.AddWithValue("@Particular", particular);
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
                Get_Requests();
            }
        }

        protected void gvRequestList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "MyDelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvRequestList.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                Delete_Request(id);
            }
            else if (e.CommandName == "myEdit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvRequestList.Rows[rowindex];
                ((Panel)row.FindControl("pnlComment")).Visible = false;
                ((Panel)row.FindControl("pnlCommentEdit")).Visible = true;
            }
            else  if (e.CommandName == "mySend")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvRequestList.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                string particular = ((TextBox)row.FindControl("tboxComment")).Text;
                Edit_Request(id, particular);
            }
        }
        private void Delete_Request(string id)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "AF_Request_Stp";
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
                Get_Requests();
            }
        }
        private void Edit_Request(string id, string particular)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "AF_Request_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Edit");
                        sqlcmd.Parameters.AddWithValue("@Id", id);
                        sqlcmd.Parameters.AddWithValue("@Particular", particular);
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
                Get_Requests();
            }
        }
    }
}