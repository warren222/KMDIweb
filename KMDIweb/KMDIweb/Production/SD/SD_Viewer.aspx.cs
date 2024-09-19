using KMDIweb.KMDIweb.Global.FileBL;
using KMDIweb.Models;
using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.Production.SD
{
    public partial class SD_Viewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ListKNo();
                ProjectDetails();
                LoadFolderFileData();
            }
        }
        private string folder_path
        {
            get
            {
                return "~/KMDI_FILES/WMS/ProjectFiles/" + Request.QueryString["lblJO"].ToString() + "/Shopdrawing";
            }
        }
        private string Sqlconstr
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString;
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

        private void ProjectDetails()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(Sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcmd.CommandText = "Flow_SD_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "ProjectDetails");
                        sqlcmd.Parameters.AddWithValue("@job_order_no", Request.QueryString["lblJO"].ToString());
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                lblProject_Name.Text = rd[0].ToString();
                                lblAddress.Text = rd[1].ToString();
                                lblSubJO.Text = rd[2].ToString();
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
        private void ListKNo()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(Sqlconstr))
                {
                    sqlcon.Open();
                    DataSet ds = new DataSet();
                    ds.Clear();     
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcmd.CommandText = "Flow_SD_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "ListK_No");
                        sqlcmd.Parameters.AddWithValue("@Job_Order_No", Request.QueryString["lblJO"].ToString());
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(ds, "kmdi_engr_operations_tb");
                            ddlK_No.DataSource = ds.Tables[0];
                            ddlK_No.DataTextField = "kmdi_no";
                            ddlK_No.DataValueField = "kmdi_no";
                            ddlK_No.DataBind();
                            ddlK_No.Text = Request.QueryString["lblJKNo"].ToString();
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
                model = x.Files_In_Model_Virtual(folder_path);

                FileModel fm = new FileModel();
                fm = model.Where(m => m.FileName.ToString().Replace(m.FileExtension.ToString(), "") == ddlK_No.SelectedValue.ToString()).SingleOrDefault();

              
                List<FileModel> modelDS = new List<FileModel>();
                modelDS = x.Files_In_Model_Virtual(folder_path + "/" + ddlK_No.SelectedValue.ToString());
                if (fm == null)
                {

                }
                else
                {
                    modelDS.Add(fm);
                }

                DataList1.DataSource = modelDS;
                DataList1.DataBind();
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                Has_SD();
            }
        }
        private void Has_SD()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(Sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        int has_sd;
                        if (DataList1.Items.Count > 0)
                        {
                            has_sd = 1;
                        }
                        else
                        {
                            has_sd = 0;
                        }
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.CommandText = "Flow_SD_Stp";
                        sqlcmd.Parameters.AddWithValue("@Command", "Has_SD");
                        sqlcmd.Parameters.AddWithValue("@JO_No", Request.QueryString["lblJO"].ToString());
                        sqlcmd.Parameters.AddWithValue("@K_No", ddlK_No.SelectedValue.ToString());
                        sqlcmd.Parameters.AddWithValue("@Has_SD", has_sd);
                        sqlcmd.ExecuteNonQuery();
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
            LoadFolderFileData();
        }

        protected void ddlK_No_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadFolderFileData();
        }

    }
}