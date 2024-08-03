using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.AE.ProjectImages
{
    public partial class Project_ImageUploader : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "errorval";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        private string folder_path
        {
            get
            {
                return "~/KMDIweb/Uploads/AF_Attachment/" + Request.QueryString["lblId"].ToString();
            }
        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                foreach (HttpPostedFile thefile in FileUpload1.PostedFiles)
                {
                    Console.WriteLine(thefile.InputStream.ToString());
                }
            }
        }
    }
}