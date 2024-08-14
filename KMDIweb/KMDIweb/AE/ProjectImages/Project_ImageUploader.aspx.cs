using KMDIweb.KMDIweb.Global.FileBL;
using KMDIweb.Models;
using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.AE.ProjectImages
{
    public partial class Project_ImageUploader : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblProject_Name.Text = Request.QueryString["lblProject_Name"].ToString();
                lblAddress.Text = Request.QueryString["lblAddress"].ToString();
                lblJO.Text = Request.QueryString["lblJO"].ToString();
                LoadFolderFileData();
            }
        }
        private string folder_path
        {
            get
            {
                return "~/KMDIweb/Uploads/ProjectPhotos/" + Request.QueryString["lblJO"].ToString() + "/ProjectImage";
            }
        }
        private string Sqlconstr
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


        private void LoadFolderFileData()
        {
            try
            {
                List<FileModel> model = new List<FileModel>();
                File_Upload_BusinessLogic x = new File_Upload_BusinessLogic();
                model = x.Files_In_Model(folder_path);
                DataList1.DataSource = model;
                DataList1.DataBind();

            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                UpdatePimg();
            }
        }
        private void UpdatePimg()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(Sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        string pimg;
                        if (DataList1.Items.Count > 0)
                        {
                            pimg = "yes";
                        }
                        else
                        {
                            pimg = "";
                        }
                        sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                        sqlcmd.CommandText = "Project_Photo_Stp";
                        sqlcmd.Parameters.AddWithValue("@Command", "Update_Pimg");
                        sqlcmd.Parameters.AddWithValue("@JO_No", Request.QueryString["lblJO"].ToString());
                        sqlcmd.Parameters.AddWithValue("@Pimg", pimg);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
        protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "myDelete")
            {
                int index = e.Item.ItemIndex;
                ExecuteDelete(((Label)DataList1.Items[index].FindControl("lblFile_Path")).Text.ToString());
            }
            else if (e.CommandName == "myView")
            {
                int index = e.Item.ItemIndex;
                Response.Redirect(((Label)DataList1.Items[index].FindControl("lblFile_Path")).Text.ToString());
            }
        }
        private void ExecuteDelete(string filepath)
        {
            try
            {
                File_Upload_BusinessLogic x = new File_Upload_BusinessLogic();
                x.Remove_File_From_Server(filepath);
                LoadFolderFileData();
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                LoadFolderFileData();
            }
        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            File_Upload_BusinessLogic x = new File_Upload_BusinessLogic();
            lblError.Text = x.Upload_File(FileUpload1, folder_path);
            LoadFolderFileData();
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/AE/ProjectImages/Project_Photos.aspx" + AddQueryStrings());
        }
        private string AddQueryStrings()
        {
            return "?ddlAE=" + Request.QueryString["ddlAE"].ToString() +
                "?ddlPhotos=" + Request.QueryString["ddlPhotos"].ToString() +
                "&tboxFind=" + Request.QueryString["tboxFind"].ToString() +
                "&page_index=" + Request.QueryString["page_index"].ToString() + "";
        }
    }
}