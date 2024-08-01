using KMDIweb.KMDIweb.Global.FileBL;
using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.AE.ProjectImages
{
    public partial class Project_Images : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["KMDI_userid"] != null)
                {
                    if (!IsPostBack)
                    {
                        Loadae();
                        LoadProject();
                    }
                }
                else
                {
                    Response.Redirect("~/KMDIweb/Global/Login.aspx");
                }
            }
        }
        private string Sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private void Errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "errorval";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        private void Loadae()
        {
            using (SqlConnection sqlcon = new SqlConnection(Sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "AF_New_Payment_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "AE_List");
                        ddlAE.DataSource = sqlcmd.ExecuteReader();
                        ddlAE.DataTextField = "fullname";
                        ddlAE.DataValueField = "fullname";
                        ddlAE.DataBind();
                    }
                    catch (Exception e)
                    {
                        Errorrmessage(e.Message);
                    }
                }
            }
        }
        private void LoadProject()
        {

            using (SqlConnection sqlcon = new SqlConnection(Sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Project_Image_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get");
                        sqlcmd.Parameters.AddWithValue("@AE", ddlAE.Text);
                        sqlcmd.Parameters.AddWithValue("@Search",  tboxSearch.Text);
                        DataTable dt = new DataTable();
                        dt.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(dt);
                            GridView1.DataSource = dt;
                            GridView1.DataBind();
                        }

                    }
                    catch (Exception e)
                    {
                        Errorrmessage(e.Message);
                    }
                }
            }

        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            LoadProject();
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadProject();
        }
     
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell cell = e.Row.Cells[0];
                string jono = ((Label)cell.FindControl("lblJOB_ORDER_NO")).Text;

                ((DataList)cell.FindControl("DataList1")).DataSource = LoadImages(jono);
                ((DataList)cell.FindControl("DataList1")).DataBind();
            }
        }
        private DataTable LoadImages(string jono)
        {
            DataTable dt = new DataTable();
            dt.Clear();
            using (SqlConnection sqlcon = new SqlConnection(Sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Project_Image_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Images");
                        sqlcmd.Parameters.AddWithValue("@JO_No", jono);           
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(dt);
                        }
                    }
                    catch (Exception e)
                    {
                        Errorrmessage(e.Message);
                    }
                }
            }
            return dt;
        }
    }
}