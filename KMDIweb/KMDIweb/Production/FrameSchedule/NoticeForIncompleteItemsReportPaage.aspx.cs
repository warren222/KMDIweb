using KMDIweb.SCREENfab;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.Production.FrameSchedule
{
    public partial class NoticeForIncompleteItemsReportPaage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    getReport();
                    getparameters();
                    validateUser();

                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private string usercode
        {
            get
            {
                return Session["KMDI_user_code"].ToString();
            }
        }
        private string myName
        {
            get
            {
                return Session["KMDI_fullname"].ToString();
            }
        }
        private string NFIIpreparedBy
        {
            get
            {
                return Session["NFIIpreparedBy"].ToString();
            }
        }
        private string NFIIapprovedBy
        {
            get
            {
                return Session["NFIIapprovedBy"].ToString();
            }
        }
        private string NFIIreceivedBy
        {
            get
            {
                return Session["NFIIreceivedBy"].ToString();
            }
        }
        private string NFIInotedBy
        {
            get
            {
                return Session["NFIInotedBy"].ToString();
            }
        }
        private string Acknowledged
        {
            get
            {
                return Session["AcknowledgedBy"].ToString();
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
        private void validateUser()
        {
            if ((usercode == "Delivery") ||
            (usercode == "Delivery Head") ||
            (usercode == "Engineer Manager") ||
            (usercode == "Production Manager") ||
            (usercode == "Production Engineer"))
            {
                preparedbyBTNaccess();
                recommendationBTNaccess();
            }
            else
            {
                preparedbyBTN.Visible = false;
            }
        }
        private void preparedbyBTNaccess()
        {
            if ((usercode == "Delivery"))
            {
                if (NFIIpreparedBy != myName)
                {
                    preparedbyBTN.Visible = false;
                }
                else
                {
                    if (NFIInotedBy != "")
                    {
                        acknowledgeBTN.Visible = true;
                    }
                    preparedbyBTN.Visible = true;
                }
            }
            else if (usercode == "Production Engineer")
            {
                if(NFIIapprovedBy == "")
                {
                    preparedbyBTN.Visible = false;
                }
                else
                {
                    preparedbyBTN.Visible = true;
                }
            }
            else if (usercode == "Production Manager")
            {
                if (NFIIreceivedBy == "")
                {
                    preparedbyBTN.Visible = false;
                }
                else
                {
                    preparedbyBTN.Visible = true;
                }
            }
            else
            {
                preparedbyBTN.Visible = true;
            }
        }
        private void recommendationBTNaccess()
        {
            if (usercode == "Production Engineer" && NFIInotedBy == "" && NFIIapprovedBy != "")
            {
                recommendationBTN.Visible = true;
            }
            else
            {
                recommendationBTN.Visible = false;
            }
        }
        private void getReport()
        {
            SqlDataSource1.ConnectionString = sqlconstr;
            SqlDataSource1.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;
            SqlDataSource1.SelectCommand = "[dbo].[NOTICE_FOR_INCOMPLETE_ITEM_STP]";
            SqlDataSource1.SelectParameters.Add("Command", TypeCode.String, "Report");
            SqlDataSource1.SelectParameters.Add("Id", TypeCode.String, Session["NFII_ID"].ToString());
            SqlDataSource1.SelectParameters.Add("Parentjono", TypeCode.String, Session["LBLparentjono"].ToString());

        }
        private void getparameters()
        {
            ReportViewer1.LocalReport.EnableExternalImages = true;
            string preparedby = new Uri(Server.MapPath("~/KMDIweb/Uploads/NFII/" + Session["LBLparentjono"].ToString() + "/" + Session["NFII_ID"].ToString() + "/" + "/signature/Prepared_By.jpg")).AbsoluteUri;
            string approvedby = new Uri(Server.MapPath("~/KMDIweb/Uploads/NFII/" + Session["LBLparentjono"].ToString() + "/" + Session["NFII_ID"].ToString() + "/" + "/signature/Approved_By.jpg")).AbsoluteUri;
            string approvedby2 = new Uri(Server.MapPath("~/KMDIweb/Uploads/NFII/" + Session["LBLparentjono"].ToString() + "/" + Session["NFII_ID"].ToString() + "/" + "/signature/Approved_By2.jpg")).AbsoluteUri;
            string receivedby = new Uri(Server.MapPath("~/KMDIweb/Uploads/NFII/" + Session["LBLparentjono"].ToString() + "/" + Session["NFII_ID"].ToString() + "/" + "/signature/Received_By.jpg")).AbsoluteUri;
            string notedby = new Uri(Server.MapPath("~/KMDIweb/Uploads/NFII/" + Session["LBLparentjono"].ToString() + "/" + Session["NFII_ID"].ToString() + "/" + "/signature/Noted_By.jpg")).AbsoluteUri;
            ReportParameter[] repparam = new ReportParameter[5];
            repparam[0] = new ReportParameter("preparedby", preparedby);
            repparam[1] = new ReportParameter("approvedby", approvedby);
            repparam[2] = new ReportParameter("approvedby2", approvedby2);
            repparam[3] = new ReportParameter("receivedby", receivedby);
            repparam[4] = new ReportParameter("notedby", notedby);
            for (int i = 0; i < 5; i++)
            {
                ReportViewer1.LocalReport.SetParameters(repparam[i]);
            }

            ReportViewer1.LocalReport.Refresh();
        }
        private void autosign(string columName)
        {
            if (IsValid)
            {

                string filepath = "~/KMDIweb/Uploads/NFII/" + Session["LBLparentjono"].ToString() + "/" + Session["NFII_ID"].ToString() + "/" + "/signature/";
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
                    File.Copy(Server.MapPath(sourcepath + fileinfo.Name), Server.MapPath(filepath + columName + ".jpg"), true);
                }
                updateRecord(columName);
            }
        }
        private void updateRecord(string command)
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "NOTICE_FOR_INCOMPLETE_ITEM_STP";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", command);
                        sqlcmd.Parameters.AddWithValue("@ID", Session["NFII_ID"].ToString());
                        sqlcmd.Parameters.AddWithValue("@Fullname", Session["KMDI_fullname"]);
                        sqlcmd.ExecuteNonQuery();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                    finally
                    {
                        ScriptManager.RegisterStartupScript(this, Page.GetType(), "Script", "savedSuccessfully();", true);
                        Response.Redirect("~/KMDIweb/Production/FrameSchedule/NoticeForIncompleteItemsReportPaage.aspx");
                    }
                }
            }
        }

        protected void preparedbyBTN_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "Script", "confimmessage();", true);
            string column = "";
            if (usercode == "Production Engineer")
            {
                column = "Received_By";
            }
            else if (usercode == "Production Manager")
            {
                column = "Noted_By";
            }
            else if (usercode == "Engineer Manager")
            {
                column = "Approved_By";
            }
            else if (usercode == "Delivery Head")
            {
                column = "Approved_By2";
            }
            else if ((usercode == "Delivery"))
            {
                if (NFIIpreparedBy != myName)
                {

                }
                column = "Prepared_By";
            }


            autosign(column);
        }

        protected void acknowledgeBTN_Click(object sender, EventArgs e)
        {
            updateRecord("Acknowledge");
        }

        protected void recommendationBTN_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/Production/FrameSchedule/recommendation.aspx");
        }
    }
}