using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KMDIweb.SCREENfab;
using System.Data;
using System.Data.SqlClient;
using KMDIweb.KMDIweb.Global.FileBL;
using System.IO;
using KMDIweb.Models;

namespace KMDIweb.KMDIweb.AE.ProjectImages
{
    public partial class Project_Photos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["KMDI_userid"] != null)
                {
                    if (!IsPostBack)
                    {
                        Retrive_QueryStrings();
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
        public void Retrive_QueryStrings()
        {
            tboxSearch.Text = Request.QueryString["tboxFind"] != null ? Request.QueryString["tboxFind"].ToString() : "";
            ddlAE.SelectedValue = Request.QueryString["ddlAE"] != null ? Request.QueryString["ddlAE"].ToString() : "All";
            ddlPhotos.SelectedValue = Request.QueryString["ddlPhotos"] != null ? Request.QueryString["ddlPhotos"].ToString() : "With";
            GridView1.PageIndex = Request.QueryString["page_index"] != null ? Convert.ToInt32(Request.QueryString["page_index"].ToString()) : 0;
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
                        sqlcmd.CommandText = "Project_Photo_Stp";
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
                        sqlcmd.CommandText = "Project_Photo_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get");
                        sqlcmd.Parameters.AddWithValue("@AE", ddlAE.Text);
                        sqlcmd.Parameters.AddWithValue("@PimgSearch", ddlPhotos.Text);
                        sqlcmd.Parameters.AddWithValue("@Search", tboxSearch.Text);
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
                string jo = ((Label)cell.FindControl("lblJOB_ORDER_NO")).Text.Replace(":","");
                string project_name = ((Label)cell.FindControl("lblProject_Name")).Text;
                string ae = ((Label)cell.FindControl("lblAE")).Text;
                string folder_path = "~/KMDI_FILES/WMS/ProjectPhotos/" + jo + "/ProjectImage";

                Boolean IsExists = Directory.Exists(HttpContext.Current.Server.MapPath(folder_path));
                if (IsExists)
                {
                    File_Upload_BusinessLogic x = new File_Upload_BusinessLogic();
                    var model = x.Files_In_Model_Virtual(folder_path);
                    foreach (FileModel m in model)
                    {
                        m.FileName = project_name + @" \ " + jo + @" \ " + m.FileName;
                    }
                    ((DataList)cell.FindControl("DataList1")).DataSource = model;
                    ((DataList)cell.FindControl("DataList1")).DataBind();

                    if (((DataList)cell.FindControl("DataList1")).Items.Count > 0)
                    {
                        ((Label)cell.FindControl("lblEmpty")).Visible = false;
                    }
                }
                if (Session["KMDI_user_code"].ToString() == "Programmer")
                {
                    ((LinkButton)cell.FindControl("btnUploadedFiles")).Visible = true;
                }
                else if (Session["KMDI_fullname"].ToString() == "Jayvey Manalili" ||
                         Session["KMDI_fullname"].ToString() == "Leo Candelaria")
                {
                    ((LinkButton)cell.FindControl("btnUploadedFiles")).Visible = true;
                }
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myUploadFile")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = ((GridView)sender).Rows[rowindex];
                string id = ((Label)row.FindControl("lblJOB_ORDER_NO")).Text;
                string project_name = ((Label)row.FindControl("lblProject_Name")).Text;
                string address = ((Label)row.FindControl("lblAddress")).Text;
                Response.Redirect("~/KMDIweb/AE/ProjectImages/Project_ImageUploader.aspx" + AddQueryStrings() + "&lblJO=" + id + "&lblProject_Name=" + project_name + "&lblAddress=" + address);
            }
        }
        private string AddQueryStrings()
        {
            return "?ddlAE=" + ddlAE.Text +
                "&ddlPhotos=" + ddlPhotos.Text +
                "&tboxFind=" + tboxSearch.Text +
                "&page_index=" + GridView1.PageIndex.ToString() + "";
        }


    }
}