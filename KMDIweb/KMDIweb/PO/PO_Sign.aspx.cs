using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.PO
{
    public partial class PO_Sign : System.Web.UI.Page
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
        private string PO_Sign_Field
        {
            get
            {
                return Request.QueryString["PO_Sign_Field"].ToString();
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

                string filepath = "~/KMDIweb/Uploads/PO/" + Session["POPO_No"].ToString() + "/Signatures/";
                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath));
                }
                UploadImage(Request.Form["myurl"].ToString().Replace("data:image/png;base64,", ""), Server.MapPath(filepath + PO_Sign_Field + ".jpg"));

                string str = "update KMDI_PONUM_TB set " + PO_Sign_Field + "='" + tboxName.Text + "'," + PO_Sign_Field + "_Date = format(getdate(),'yyyy-MM-dd') where [NO] = @PO_No";
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
                        sqlcmd.Parameters.AddWithValue("@PO_No", Session["POPO_No"].ToString());
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
                Redirect_To_Sender();
            }

        }
        private string PO_Sender
        {
            get
            {
                return Request.QueryString["PO_Sender"].ToString();
            }
        }
        private void Redirect_To_Sender()
        {
            if (PO_Sender == "PO_Rpt")
            {
                Response.Redirect("~/KMDIweb/PO/PO_Rpt.aspx" + AddQuerystring);
            }
            else if (PO_Sender == "PO_X_Rpt")
            {
                Response.Redirect("~/KMDIweb/PO/PO_X_Rpt.aspx" + AddQuerystring);
            }
            else if (PO_Sender == "PO_Ajiya_Rpt")
            {
                Response.Redirect("~/KMDIweb/PO/PO_Ajiya_Rpt.aspx" + AddQuerystring);
            }
            else if (PO_Sender == "PO_Laminated_Rpt")
            {
                Response.Redirect("~/KMDIweb/PO/PO_Laminated_Rpt.aspx" + AddQuerystring);
            }
        }
        private string AddQuerystring
        {
            get
            {
                return "?PO_Search=" + Request.QueryString["PO_Search"].ToString() + "&PO_For_Signature=" + Request.QueryString["PO_For_Signature"].ToString() + 
                       "&PO_PageIndex=" + Request.QueryString["PO_PageIndex"].ToString() + "&Requested_By=" + Request.QueryString["Requested_By"].ToString();
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Redirect_To_Sender();
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {

                string filepath = "~/KMDIweb/Uploads/PO/" + Session["POPO_No"].ToString() + "/Signatures/";
                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath));
                }
                string sourcepath = "~/KMDIweb/Uploads/UserSignature/" + Session["KMDI_userid"].ToString() + "/";
                Boolean IsExists1 = System.IO.Directory.Exists(Server.MapPath(sourcepath));
                if (!IsExists1)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(sourcepath));
                }

                foreach (string strfilename in Directory.GetFiles(Server.MapPath(sourcepath)))
                {
                    FileInfo fileinfo = new FileInfo(strfilename);
                    File.Copy(Server.MapPath(sourcepath + fileinfo.Name), Server.MapPath(filepath + PO_Sign_Field + ".jpg"), true);
                }

                string str = "update KMDI_PONUM_TB set " + PO_Sign_Field + "='" + Session["KMDI_fullname"].ToString() + "'," + PO_Sign_Field + "_Date = format(getdate(),'yyyy-MM-dd') where [NO] = @PO_No";
                updatetb(str);

            }
        }
    }
}