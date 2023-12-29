using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.AE.AccountingClearance
{
    public partial class AC : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {

                username.Text = Session["KMDI_nickname"].ToString() + " ";
                loadSummary();
                access();
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private void access()
        {
            if (Session["KMDI_afr_acct"].ToString() == "Admin")
            {
                BTNaccount.Visible = true;
            }
            else
            {
                BTNaccount.Visible = false;
            }

            if (Session["KMDI_user_code"].ToString() == "Programmer")
            {
                hlProject.Visible = true;
                hlForApproval.Visible = true;
                hlForReleasing.Visible = true;
            }
            else if ((Session["KMDI_user_code"].ToString() == "Operations" &&
                     Session["KMDI_fullname"].ToString() == "Leo Candelaria"))
            {
                hlProject.Visible = false;
                hlForApproval.Visible = false;
                hlForReleasing.Visible = true;
            }
            else if ((Session["KMDI_user_code"].ToString() == "AE"))
            {
                hlProject.Visible = true;
                hlForApproval.Visible = false;
                hlForReleasing.Visible = false;
            }
            else if ((Session["KMDI_user_code"].ToString() == "Accounting"))
            {
                hlProject.Visible = false;
                hlForApproval.Visible = true;
                hlForReleasing.Visible = false;
            }
            else
            {
                hlProject.Visible = false;
                hlForApproval.Visible = false;
                hlForReleasing.Visible = false;
            }
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/KMDIweb/Global/login.aspx");
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private string ae()
        {
            string fullname = Session["KMDI_fullname"].ToString();
            string user_code = Session["KMDI_user_code"].ToString();
            if (user_code == "AE")
            {
                return fullname;
            }
            else
            {
                return "";
            }
        }
        private void loadSummary()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "AC_Request_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Notification");
                        sqlcmd.Parameters.AddWithValue("@AE", ae());
                        using (SqlDataReader rdr = sqlcmd.ExecuteReader())
                        {
                            while (rdr.Read())
                            {
                                if (rdr[0].ToString() != "0")
                                {
                                    lblForApproval.BackColor = System.Drawing.Color.Red;
                                }
                                if (rdr[1].ToString() != "0")
                                {
                                    lblForReleasing.BackColor = System.Drawing.Color.Red;
                                }
                                lblForApproval.Text = rdr[0].ToString();
                                lblForReleasing.Text = rdr[1].ToString();
                            }
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
        }
    }
}