using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.PRF
{
    public partial class PRF_Sign : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {


                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private string sqlconstrInventory
        {
            get
            {
                return ConnectionString.sqlconstrInventory();
            }
        }
        private string PRF_Sign_Field
        {
            get
            {
                return Request.QueryString["PRF_Sign_Field"].ToString();
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

                string filepath = "~/KMDI_FILES/WMS/PRF/" + Request.QueryString["Id"].ToString() + "/Signatures/";
                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath));
                }
                UploadImage(Request.Form["myurl"].ToString().Replace("data:image/png;base64,", ""), Server.MapPath(filepath + PRF_Sign_Field + ".jpg"));
                updatetb();

            }
        }
        private void updatetb()
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstrInventory))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "PRF_Stp";
                        sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Sign");
                        sqlcmd.Parameters.AddWithValue("@Id", Request.QueryString["Id"].ToString());
                        sqlcmd.Parameters.AddWithValue("@PRF_Sign_Field", PRF_Sign_Field);
                        sqlcmd.Parameters.AddWithValue("@Addressed", Request.QueryString["Addressed"].ToString());
                        sqlcmd.Parameters.AddWithValue("@Fullname", Session["KMDI_fullname"].ToString());
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
                Response.Redirect("~/KMDIweb/PRF/PRF_Report.aspx" + AddQuerystring);
            }

        }
        private string AddQuerystring
        {
            get
            {
                return "?Find=" + Request.QueryString["Find"].ToString() +
                    "&DateFilter=" + Request.QueryString["DateFilter"].ToString() +
                    "&Date=" + Request.QueryString["Date"].ToString() +
                    "&ForSignature=" + Request.QueryString["ForSignature"].ToString() +
                    "&PageIndex=" + Request.QueryString["PageIndex"].ToString() +
                    "&Id=" + Request.QueryString["Id"].ToString();
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PRF/PRF_Report.aspx" + AddQuerystring);
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {

                string filepath = "~/KMDI_FILES/WMS/PRF/" + Request.QueryString["Id"].ToString() + "/Signatures/";
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
                    File.Copy(Server.MapPath(sourcepath + fileinfo.Name), Server.MapPath(filepath + PRF_Sign_Field + ".jpg"), true);
                }

                 updatetb();

            }
        }
    }
}