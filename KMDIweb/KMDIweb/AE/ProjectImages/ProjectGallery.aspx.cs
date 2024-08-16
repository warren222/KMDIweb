using System;
using KMDIweb.KMDIweb.Global.FileBL;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KMDIweb.Models;
using KMDIweb.SCREENfab;
using System.Data.SqlClient;

namespace KMDIweb.KMDIweb.AE.ProjectImages
{
    public partial class ProjectGallery : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetProjectDetatils();
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

        private void GetProjectDetatils()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(Sqlconstr))
                {
                    using (SqlCommand sqlcmd =  sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Project_Photo_Stp";
                        sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command","Select");
                        sqlcmd.Parameters.AddWithValue("@JO_No", Request.QueryString["lblJO"].ToString());
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                lblProject_Name.Text = rd[1].ToString();
                                lblAddress.Text = rd[2].ToString();
                                lblJO.Text = rd[0].ToString();
                            }
                          
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
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
          
        }
    }


}