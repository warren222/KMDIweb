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
    public partial class AF_Project_List : System.Web.UI.Page
    {
        IMyQueryString _iMyQueryString;
        public AF_Project_List(IMyQueryString iMyQueryString)
        {
            _iMyQueryString = iMyQueryString;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["KMDI_userid"] != null)
                {
                    if (!IsPostBack)
                    {
                        Retrive_QueryStrings();
                        loadae();
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
        public void Retrive_QueryStrings()
        {
            tboxSearch.Text = _iMyQueryString.Search != null ? _iMyQueryString.Search : "";
            ddlAE.Text = _iMyQueryString.AE != null ? _iMyQueryString.AE : "";
            gvProject.PageIndex = _iMyQueryString.Page_Index != null ? Convert.ToInt32(_iMyQueryString.Page_Index) : 0;
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
                        sqlcmd.CommandText = "AF_Request_Stp";
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
                        sqlcmd.CommandText = "AF_Request_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Project");
                        sqlcmd.Parameters.AddWithValue("@Search", tboxSearch.Text);
                        sqlcmd.Parameters.AddWithValue("@AE", ddlAE.Text);
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
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            loaddata();
        }

        protected void gvProject_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "view_request")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvProject.Rows[rowindex];
                string parentjono = ((LinkButton)row.FindControl("btnParentjono")).Text;
                Response.Redirect("~/KMDIweb/AE/AF/AF_Project_Request.aspx" + AddQueryStrings(parentjono));
            }
        }
        private string AddQueryStrings(string parentjono)
        {
            return "?jo_parent=" + parentjono + "&page_index=" + gvProject.PageIndex.ToString() + "&search=" + tboxSearch.Text + "&ae=" + ddlAE.SelectedValue.ToString();
        }
        protected void gvProject_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvProject.PageIndex = e.NewPageIndex;
            loaddata();
        }
    }
}