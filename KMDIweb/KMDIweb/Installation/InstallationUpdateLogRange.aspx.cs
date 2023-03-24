using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.Installation
{
    public partial class InstallationUpdateLogRange : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    loadinstl();
                    tboxSdate.Text = DateTime.Today.ToString("yyyy-MM-dd");
                    tboxEdate.Text = DateTime.Today.ToString("yyyy-MM-dd");
                    loaddata();
                   
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
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
        private void loaddata()
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        DataTable tb = new DataTable();
                        sqlcon.Open();
                        sqlcmd.CommandText = "Installation_Update_Log_Range_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "load");
                        sqlcmd.Parameters.AddWithValue("@Sdate", tboxSdate.Text);
                        sqlcmd.Parameters.AddWithValue("@Edate", tboxEdate.Text);
                        sqlcmd.Parameters.AddWithValue("@Installer", ddlInstl.Text);
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
                errorrmessage(ex.Message.ToString());
            }
        }
        private void loadinstl()
        {

            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Installation_Update_Log_Range_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "loadInstl");
                        ddlInstl.DataSource = sqlcmd.ExecuteReader();
                        ddlInstl.DataTextField = "installer";
                        ddlInstl.DataValueField = "installer";
                        ddlInstl.DataBind();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            loaddata();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            loaddata();
        }
    }
}