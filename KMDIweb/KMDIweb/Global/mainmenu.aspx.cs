using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIapp
{
    public partial class mainmenu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    access();
                    Notif_Counter();
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "val1";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        private void Notif_Counter()
        {
            //Glass P.O Notifcation Notif counter
            int Glass_Notif_Count = Convert.ToInt32(GlassNotification()) + Convert.ToInt32(GlassUpdateNotification());
            lblGlassNotifCounter.Text = Glass_Notif_Count.ToString();
            if (Glass_Notif_Count > 0)
            {
                lblGlassNotifCounter.BackColor = Color.Red;
            }

            //Glass P.O Notif Counter
            int Glass_PO_Count = Convert.ToInt32(Glass_PO_Notification());
            lblGlassPOCounter.Text = Glass_PO_Count.ToString();
            if (Glass_PO_Count > 0)
            {
                lblGlassPOCounter.BackColor = Color.Red;
            }

            //Online PRF Counter
            int PRF_Count = Convert.ToInt32(PRF_Notification());
            lblPRFCounter.Text = PRF_Count.ToString();
            if (PRF_Count > 0)
            {
                lblPRFCounter.BackColor = Color.Red;
            }
        }
        private string Glass_PO_Notification()
        {
            string cointer = "0";
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {

                        sqlcon.Open();
                        sqlcmd.CommandText = "Web_PO_Approval_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Notification_Counter");
                        sqlcmd.Parameters.AddWithValue("@POA_Acct", poa);
                        sqlcmd.Parameters.AddWithValue("@Fullname", user_fullname);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {

                                string Notif_Prepared_By = rd[0].ToString();
                                string Notif_Noted_By = rd[1].ToString();
                                string Notif_Approved_By = rd[2].ToString();
                                if (poa == "Admin")
                                {
                                    cointer = (Convert.ToInt32(Notif_Prepared_By) + Convert.ToInt32(Notif_Noted_By) + Convert.ToInt32(Notif_Approved_By)).ToString();
                                }
                                else if (poa == "PO")
                                {
                                    cointer = Notif_Prepared_By;
                                }
                                else if (poa == "Noter")
                                {
                                    cointer = Notif_Noted_By;
                                }
                                else if (poa == "Approver")
                                {
                                    cointer = Notif_Approved_By;
                                }
                                else
                                {
                                    cointer = "0";
                                }
                            }
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            return cointer;
        }
        private string PRF_Notification()
        {
            string cointer = "0";
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstrInventory))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {

                        sqlcon.Open();
                        sqlcmd.CommandText = "PRF_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Menu_Notification");
                        sqlcmd.Parameters.AddWithValue("@Fullname", user_fullname);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                cointer = rd[0].ToString();
                            }
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            return cointer;
        }
        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/KMDIweb/Global/login.aspx");
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            if (Session["KMDI_sfm_acct"].ToString() == "None")
            {
                errorrmessage("Invalid access!");

            }
            else
            {
                if (IsValid)
                {
                    Response.Redirect("~/KMDIweb/Production/ScreenSchedule/home.aspx");
                }

            }

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if (Session["KMDI_sdr_acct"].ToString() == "None")
            {
                errorrmessage("invalid access!");

            }
            else
            {
                if (IsValid)
                {
                    Response.Redirect("~/KMDIweb/Delivery/ScannedDR/DRscannedHome.aspx");
                }

            }

        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            if (Session["KMDI_ffm_acct"].ToString() == "None")
            {
                errorrmessage("invalid access!");

            }
            else
            {
                if (IsValid)
                {
                    Response.Redirect("~/KMDIweb/Production/FrameSchedule/FrameHome.aspx");
                }

            }
        }
        private string user_fullname
        {
            get
            {
                return Session["KMDI_fullname"].ToString();
            }
        }
        private string poa
        {
            get
            {
                return Session["KMDI_poa_acct"].ToString();
            }
        }
        private string usercode
        {
            get
            {
                return Session["KMDI_user_code"].ToString();
            }
        }
        private string fullname
        {
            get
            {
                return Session["KMDI_fullname"].ToString();
            }
        }
        private void access()
        {
            if ((usercode == "Delivery") ||
                     (usercode == "Operations") ||
                       (usercode == "Programmer") ||
                     (usercode == "Management"))

            {
                Panel1.Visible = true;
            }
            else
            {
                Panel1.Visible = false;
            }

            if ((usercode == "Accounting"))
            {
                Panel3.Visible = false;
                Panel4.Visible = false;

                Panel2.Visible = true;
                Panel1.Visible = true;
            }

            if ((usercode == "Accounting") || (usercode == "Operations") || (usercode == "Programmer") || (usercode == "Management") || (usercode == "AE") || (usercode == "Aftersales"))
            {
                Panel2.Visible = true;
            }
            if ((usercode == "Installer") || (usercode == "Installation Staff") || (usercode == "Management") || (usercode == "Programmer") || (usercode == "Engineer") || (usercode == "Engineer Manager"))
            {

                Panel5.Visible = true;
            }
            else
            {
                Panel5.Visible = false;
            }
            if ((usercode == "Installer") || (usercode == "Installation Staff"))
            {
                Panel3.Visible = false;
                Panel4.Visible = false;
            }

           
            //if ((usercode == "AE") ||
            //    (usercode == "Accounting") ||
            //    ((fullname == "Leo Candelaria" && usercode == "Operations")) ||
            //    (usercode == "Programmer") ||
            //    (fullname == "Genalyn Garcia"))
            //{
            //    pnlAC.Visible = true;
            //}
            //if ((usercode == "AE") ||
            //((fullname == "Jayvey Manalili" && usercode == "Operations")) ||
            //(usercode == "Programmer") ||
            //(fullname == "Genalyn Garcia"))
            //{
            //    pnlAF.Visible = true;
            //}
            Imported_Glass_Monitoring_Access();
            PO_Access();
            Glass_PO_Notification_Access();
            Engineering_Itinerary_Access();
        }
        private void Imported_Glass_Monitoring_Access()
        {
            if (usercode == "AE" || usercode == "Engineer" ||
              usercode == "Programmer" || usercode == "Engineer Manager" ||
              usercode == "Installation Staff")
            {
                pnlMeiheng.Visible = true;
            }
            else
            {
                pnlMeiheng.Visible = false;
            }
        } 
        private void PO_Access()
        {
            if (poa != "")
            {
                pnlPO.Visible = true;
            }
        }
        private void Glass_PO_Notification_Access()
        {
            if ((usercode == "Engineer Manager") ||
                       (usercode == "Glass Section") ||
                       (usercode == "Programmer") ||
                       (usercode == "Production Manager") ||
                       (fullname == "Delivery"))
            {
                pnlGlassPONotif.Visible = true;
            }
        }
        private void Engineering_Itinerary_Access()
        {
            if ((usercode == "Engineer Manager") ||
              (usercode == "Engineer") ||
              (fullname == "Genalyn Garcia") ||
              (usercode == "Programmer"))
            {
                pnlEngrItinerary.Visible = true;
            }
        }
        protected void LinkButton5_Click(object sender, EventArgs e)
        {
            if (Session["KMDI_clg_acct"].ToString() == "None")
            {
                errorrmessage("invalid access!");

            }
            else
            {
                if (IsValid)
                {
                    Response.Redirect("~/KMDIweb/AE/CollectionLedger/CollectionLedgerFrm.aspx");
                }

            }
        }

        protected void LinkButton6_Click(object sender, EventArgs e)
        {

            Response.Redirect("~/KMDIweb/Installation/InstallationSchedule.aspx");

        }

        protected void LinkButton9_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/AE/AF/AF_New_Payment.aspx");
        }
        protected void LinkButton10_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/AE/AccountingClearance/AC_ProjectList.aspx");
        }
        protected void LinkButton11_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PO/PO_ForApproval.aspx");
        }
        protected void LinkButton12_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/AE/ProjectImages/Project_Photos.aspx");
        }
        protected void LinkButton13_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/AE/Meiheng/Meiheng_PO_List.aspx");
        }
        protected void LinkButton14_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/GlassNotification/Glass_Notif_List.aspx");
        }
        protected void LinkButton15_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/PRF/PRF_List.aspx");
        }
        protected void LinkButton16_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/EngrItinerary/Engr_Itinerary.aspx");
        }

        private string GlassNotification()
        {
            string counter = "0";
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Glass_PO_Notification_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Notification_Counter");
                        sqlcmd.Parameters.AddWithValue("@User_Code", user_code);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                if (user_code == "Glass Section" || user_code == "Programmer")
                                {
                                    counter = rd[0].ToString();
                                }
                                else if (user_code == "Production Manager")
                                {
                                    counter = rd[1].ToString();
                                }
                                else if (user_code == "Delivery")
                                {
                                    counter = rd[2].ToString();
                                }
                                else if (user_code == "Engineer Manager")
                                {
                                    counter = rd[3].ToString();
                                }
                            }
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            return counter;
        }
        private string GlassUpdateNotification()
        {
            string counter = "0";
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        DataTable tb = new DataTable();
                        tb.Clear();
                        sqlcon.Open();
                        sqlcmd.CommandText = "Glass_PO_Notification_Updates_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Summary");
                        sqlcmd.Parameters.AddWithValue("@User_Code", user_code);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                counter = rd[0].ToString();

                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            return counter;
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private string sqlconstrInventory
        {
            get
            {
                return ConnectionString.sqlconstrInventory();
            }
        }
        private string user_code
        {
            get
            {
                return Session["KMDI_user_code"].ToString();
            }
        }
    }
}