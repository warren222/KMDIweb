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

namespace KMDIweb.KMDIweb.PRF
{
    public partial class PRF_Report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {

                    getparameters();
                    Get_Address();

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
        string controlId
        {
            get
            {
                return Request.QueryString["Id"].ToString();
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
        private string fullname
        {
            get
            {
                return Session["KMDI_fullname"].ToString();
            }
        }
        private void SUAccess()
        {
            GViewStateValue();
            SetPanelVisibility(pnlRequested, ViewState["requested_By"].ToString());
            SetPanelVisibility(pnlNoted, ViewState["noted_By_Addressed"].ToString());
            SetPanelVisibility(pnlReceived, ViewState["received_By_Addressed"].ToString());
            SetPanelVisibility(pnlApproved, ViewState["approved_By_Addressed"].ToString());
            if(ViewState["requested_By_Date"].ToString() != "")
            {
                pnlRecipient.Visible = false;
            }
        }
        private void SetPanelVisibility(Panel pnl, string vstate)
        {
            if (vstate == fullname)
            {
                pnl.Visible = true;
            }
            else
            {
                pnl.Visible = false;
            }
        }
        private void GViewStateValue()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "PRF_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Select");
                        sqlcmd.Parameters.AddWithValue("@Id", Request.QueryString["Id"].ToString());
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                ViewState["requested_By"] = rd[5].ToString();
                                ViewState["requested_By_Date"] = rd[6].ToString();
                                ViewState["noted_By_Addressed"] = rd[13].ToString();
                                ViewState["received_By_Addressed"] = rd[14].ToString();
                                ViewState["approved_By_Addressed"] = rd[15].ToString();
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
        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 32000;
        }
        protected void SqlDataSource2_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 32000;
        }
        protected void ReportViewer1_ReportRefresh(object sender, System.ComponentModel.CancelEventArgs e)
        {
            getparameters();
        }
        private void getparameters()
        {
            ReportViewer1.LocalReport.EnableExternalImages = true;
            string RequestedByImg = new Uri(Server.MapPath("~/KMDI_FILES/WMS/PRF/" + controlId + "/Signatures/Requested_By.jpg")).AbsoluteUri;
            string NotedByImg = new Uri(Server.MapPath("~/KMDI_FILES/WMS/PRF/" + controlId + "/Signatures/Noted_By.jpg")).AbsoluteUri;
            string ReceivedByImg = new Uri(Server.MapPath("~/KMDI_FILES/WMS/PRF/" + controlId + "/Signatures/Received_By.jpg")).AbsoluteUri;
            string ApprovedByImg = new Uri(Server.MapPath("~/KMDI_FILES/WMS/PRF/" + controlId + "/Signatures/Approved_By.jpg")).AbsoluteUri;
            ReportParameter[] repparam = new ReportParameter[6];
            repparam[0] = new ReportParameter("RequestedByImg", RequestedByImg);
            repparam[1] = new ReportParameter("NotedByImg", NotedByImg);
            repparam[2] = new ReportParameter("ReceivedByImg", ReceivedByImg);
            repparam[3] = new ReportParameter("ApprovedByImg", ApprovedByImg);
            for (int i = 0; i < 4; i++)
            {
                ReportViewer1.LocalReport.SetParameters(repparam[i]);
            }
            ReportViewer1.LocalReport.DisplayName = controlId;
            ReportViewer1.LocalReport.Refresh();
            SUAccess();
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PRF/PRF_List.aspx" + AddQuerystring);
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
                       "&Id=" + controlId;
            }
        }
        protected void btnRequestedBy_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PRF/PRF_Sign.aspx" + AddQuerystring + "&PRF_Sign_Field=Requested_By");
        }
        protected void btnNotedBy_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PRF/PRF_Sign.aspx" + AddQuerystring + "&PRF_Sign_Field=Noted_By");
        }
        protected void btnReceivedBy_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PRF/PRF_Sign.aspx" + AddQuerystring + "&PRF_Sign_Field=Received_By");
        }
        protected void btnApprovedBy_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PRF/PRF_Sign.aspx" + AddQuerystring + "&PRF_Sign_Field=Approved_By");
        }
        private void UseUserSignature(string PRF_Sign_Field, string addressed)
        {
            if (IsValid)
            {

                string filepath = "~/KMDI_FILES/WMS/PRF/" + controlId + "/Signatures/";
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

                updatetb(PRF_Sign_Field, addressed);

            }
        }
        private void updatetb(string sign_field, string addressed)
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "PRF_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Sign");
                        sqlcmd.Parameters.AddWithValue("@Id", Request.QueryString["Id"].ToString());
                        sqlcmd.Parameters.AddWithValue("@Fullname", Session["KMDI_fullname"].ToString());
                        sqlcmd.Parameters.AddWithValue("@PRF_Sign_Field", sign_field);
                        sqlcmd.Parameters.AddWithValue("@Addressed", addressed);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            finally
            {
                getparameters();
            }

        }

        protected void btnRequestedByDefault_Click(object sender, EventArgs e)
        {
            UseUserSignature("Requested_By", ddlAddressed.Text);
        }

        protected void btnNotedByDefault_Click(object sender, EventArgs e)
        {
            UseUserSignature("Noted_By", ddlAddressed.Text);
        }

        protected void btnReceivedByDefault_Click(object sender, EventArgs e)
        {
            UseUserSignature("Received_By", ddlAddressed.Text);
        }

        protected void btnApprovedByDefault_Click(object sender, EventArgs e)
        {
            UseUserSignature("Approved_By", "");
        }

        private void Get_Address()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "PRF_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Address");
                        ddlAddressed.DataSource = sqlcmd.ExecuteReader();
                        ddlAddressed.DataTextField = "fullname";
                        ddlAddressed.DataValueField = "fullname";
                        ddlAddressed.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }

        }
    }
}