﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.Global
{
    public partial class registerSign : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public static void UploadImage(string imageData, string fileNameWitPath)
        {
            using (FileStream fs = new FileStream(fileNameWitPath, FileMode.Create))
            {
                using (BinaryWriter bw = new BinaryWriter(fs))

                {
                    byte[] data = Convert.FromBase64String(imageData);
                    bw.Write(data);
                    bw.Close();
                }
            }
        }
        protected void Button2_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {

                string filepath = "~/KMDIweb/Uploads/UserSignature/" + Session["KMDI_userid"].ToString() + "/";
                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath));
                }
                System.IO.DirectoryInfo folderInfo = new DirectoryInfo(Server.MapPath(filepath));
                foreach (FileInfo file in folderInfo.GetFiles())
                {
                    file.Delete();
                }
                UploadImage(Request.Form["myurl"].ToString().Replace("data:image/png;base64,", ""), Server.MapPath(filepath + "mysign" + DateTime.Now.ToString("HH:mm:ss").Replace(":", "") + ".jpg"));

                Response.Redirect("~/KMDIweb/Global/changesecurity.aspx");

            }
        }
    }
}