﻿using KMDIweb.KMDIweb.Global.FileBL;
using KMDIweb.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.AE.CollectionLedger
{
    public partial class CollectionLedgerFiles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblProject_Name.Text = Request.QueryString["Project_Name"].ToString();
                lblAmount.Text = "PHP " + Request.QueryString["Amount"].ToString();
                LoadFolderFileData();
            }
        }
        private string folder_path
        {
            get
            {
                return "~/KMDI_FILES/WMS/CollectionLedger/" + Request.QueryString["Collection_Id"].ToString() + "/";
            }
        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            File_Upload_BusinessLogic x = new File_Upload_BusinessLogic();
            lblError.Text = x.Upload_File(FileUpload1, folder_path);
            LoadFolderFileData();
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
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "errorval";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "myDelete")
            {
                int index = e.Item.ItemIndex;
                ExecuteDelete(((Label)DataList1.Items[index].FindControl("lblFile_Path")).Text.ToString());
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
        }
    }
}