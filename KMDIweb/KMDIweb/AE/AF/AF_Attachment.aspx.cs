using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KMDIweb.KMDIweb.Global.FileBL;
using KMDIweb.Models;
using KMDIweb.SCREENfab;

namespace KMDIweb.KMDIweb.AE.AF
{
    public partial class AF_Attachment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Loaddata();
                LoadFolderFileData();
            }
        }
        private string folder_path
        {
            get
            {
                return "~/KMDI_FILES/WMS/AF_Attachment/" + Request.QueryString["lblId"].ToString();
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
        private void Loaddata()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(Sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        DataTable tb = new DataTable();
                        tb.Clear();
                        sqlcon.Open();
                        sqlcmd.CommandText = "AF_Request_Check_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get");
                        sqlcmd.Parameters.AddWithValue("@SubCommand", "Select");
                        sqlcmd.Parameters.AddWithValue("@Id", Request.QueryString["lblId"].ToString());
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvAF.DataSource = tb;
                            gvAF.DataBind();
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
                DataList1.DataSource = model;
                DataList1.DataBind();
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
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
            Response.Redirect("~/KMDIweb/AE/AF/AF_For_Checking.aspx" + AddQueryStrings());
        }
        private string AddQueryStrings()
        {
            return "?ddlStatus=" + Request.QueryString["ddlStatus"].ToString() + "&ddlDate_Filter=" + Request.QueryString["ddlDate_Filter"].ToString() + 
                "&tboxDate=" + Request.QueryString["tboxDate"].ToString() + "&ddlAE=" + Request.QueryString["ddlAE"].ToString() + 
                "&tboxFind=" + Request.QueryString["tboxFind"].ToString() + "&page_index=" + Request.QueryString["page_index"].ToString() + "";
        }
    }
}