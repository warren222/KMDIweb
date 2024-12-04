using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.GlassNotification
{
    public partial class GN_Sign : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private string Glass_Notif_Sign_Field
        {
            get
            {
                return Request.QueryString["Glass_Notif_Sign_Field"].ToString();
            }
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
            senderbutton();
        }
        private void senderbutton()
        {
            if (IsValid)
            {

                string filepath = "~/KMDI_FILES/WMS/Glass_Notification/" + Request.QueryString["Control_No"].ToString() + "/Signatures/";
                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath));
                }
                UploadImage(Request.Form["myurl"].ToString().Replace("data:image/png;base64,", ""), Server.MapPath(filepath + Glass_Notif_Sign_Field + ".jpg"));

                string str = "update Glass_PO_Notification_Tbl set " + Glass_Notif_Sign_Field + "='" + tboxName.Text + "'," + Glass_Notif_Sign_Field + "_Date = format(getdate(),'yyyy-MM-dd') where [Control_No] = @Control_No";
                updatetb(str);

            }
        }
        private void updatetb(string qry)
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(qry, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@Control_No", Request.QueryString["Control_No"].ToString());
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
            finally
            {
                Response.Redirect("~/KMDIweb/GlassNotification/Glass_Notif_Rpt.aspx" + AddQuerystring);
            }

        }
        private string AddQuerystring
        {
            get
            {
                return "?Find=" + Request.QueryString["Find"].ToString() + "&PageIndex=" + Request.QueryString["PageIndex"].ToString() +
                    "&Glass_PO_Notification_Id=" + Request.QueryString["Glass_PO_Notification_Id"].ToString() + "&Control_No=" + Request.QueryString["Control_No"].ToString();
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/GlassNotification/Glass_Notif_Rpt.aspx" + AddQuerystring);
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {

                string filepath = "~/KMDI_FILES/WMS/Glass_Notification/" + Request.QueryString["Control_No"].ToString() + "/Signatures/";
                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath));
                }
                string sourcepath = "~/KMDI_FILES/WMS/UserSignature/" + Session["KMDI_userid"].ToString() + "/";
                Boolean IsExists1 = System.IO.Directory.Exists(Server.MapPath(sourcepath));
                if (!IsExists1)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(sourcepath));
                }

                foreach (string strfilename in Directory.GetFiles(Server.MapPath(sourcepath)))
                {
                    FileInfo fileinfo = new FileInfo(strfilename);
                    File.Copy(Server.MapPath(sourcepath + fileinfo.Name), Server.MapPath(filepath + Glass_Notif_Sign_Field + ".jpg"), true);
                }

                string str = "update Glass_PO_Notification_Tbl set " + Glass_Notif_Sign_Field + "='" + Session["KMDI_fullname"].ToString() + "'," + Glass_Notif_Sign_Field + "_Date = format(getdate(),'yyyy-MM-dd') where [Control_No] = @Control_No";
                updatetb(str);

            }
        }
    }
}