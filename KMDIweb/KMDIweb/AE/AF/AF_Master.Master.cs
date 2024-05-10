using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.AE.AF
{
    public partial class AF_Master : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {

                username.Text = Session["KMDI_nickname"].ToString() + " ";
                loadSummary();
                Available_AF_Notification_Counter();
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
                hlForChecking.Visible = true;
            }
            else if (Session["KMDI_user_code"].ToString() == "Management" && Session["KMDI_fullname"].ToString() == "Genalyn Garcia")
            {
                hlProject.Visible = false;
                hlForApproval.Visible = true;
                hlForChecking.Visible = false;
            }
            else if ((Session["KMDI_user_code"].ToString() == "Operations" &&
                     Session["KMDI_fullname"].ToString() == "Jayvey Manalili"))
            {
                hlProject.Visible = false;
                hlForApproval.Visible = false;
                hlForChecking.Visible = true;
            }
            else if ((Session["KMDI_user_code"].ToString() == "AE"))
            {
                hlProject.Visible = true;
                hlForApproval.Visible = false;
                hlForChecking.Visible = true;
            }
            else
            {
                hlProject.Visible = false;
                hlForApproval.Visible = false;
                hlForChecking.Visible = false;
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/KMDIweb/Global/login.aspx");
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
        private void Available_AF_Notification_Counter()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "AF_New_Payment_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get");
                        sqlcmd.Parameters.AddWithValue("@Sub_Command", "Notification");
                        sqlcmd.Parameters.AddWithValue("@AE", ae());
                        using (SqlDataReader rdr = sqlcmd.ExecuteReader())
                        {
                            while (rdr.Read())
                            {
                                int notif_available_af = Convert.ToInt32(rdr[0].ToString());
                                if (notif_available_af != 0)
                                {
                                    lblAvailable.BackColor = System.Drawing.Color.Red;
                                }
                                lblAvailable.Text = notif_available_af.ToString();
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

        private void loadSummary()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "AF_Request_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Summary");
                        sqlcmd.Parameters.AddWithValue("@JO_Parent", Request.QueryString["jo_parent"]);
                        sqlcmd.Parameters.AddWithValue("@AE", ae());
                        using (SqlDataReader rdr = sqlcmd.ExecuteReader())
                        {
                            while (rdr.Read())
                            {
                                int notif_for_checking = Convert.ToInt32(rdr[0].ToString()) + Convert.ToInt32(rdr[3].ToString());
                                int notif_for_approval = Convert.ToInt32(rdr[1].ToString()) + Convert.ToInt32(rdr[4].ToString());
                                if (notif_for_checking != 0)
                                {
                                    lblForChecking.BackColor = System.Drawing.Color.Red;
                                }
                                if (notif_for_approval != 0)
                                {
                                    lblForApproval.BackColor = System.Drawing.Color.Red;
                                }

                                lblForApproval.Text = notif_for_approval.ToString();
                                lblForChecking.Text = notif_for_checking.ToString();
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