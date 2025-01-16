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

namespace KMDIweb.KMDIweb.GlassNotification
{
    public partial class GlassNotificationMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                username.Text = Session["KMDI_nickname"].ToString() + " ";
                access();
                lblGlassNotification.Text = GlassNotification();
                GlassUpdateNotification();
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private void access()
        {
            if (Session["KMDI_clg_acct"].ToString() == "Admin")
            {
                BTNaccount.Visible = true;
            }
            else
            {
                BTNaccount.Visible = false;
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
        private string user_code
        {
            get
            {
                return Session["KMDI_user_code"].ToString();
            }
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
                                    if (counter != "0")
                                    {
                                        lblGlassNotification.BackColor = Color.Aqua;
                                        lblGlassNotification.ForeColor = Color.Black;
                                    }
                                }
                                else if (user_code == "Production Manager")
                                {
                                    counter = rd[1].ToString();
                                    if (counter != "0")
                                    {
                                        lblGlassNotification.BackColor = Color.Red;
                                    }           
                                }
                                else if (user_code == "Delivery")
                                {
                                    counter = rd[2].ToString();
                                    if (counter != "0")
                                    {
                                        lblGlassNotification.BackColor = Color.Orange;
                                        lblGlassNotification.ForeColor = Color.Black;
                                    }    
                                }
                                else if (user_code == "Engineer Manager")
                                {
                                    counter = rd[3].ToString();
                                    if (counter != "0")
                                    {
                                        lblGlassNotification.BackColor = Color.Yellow;
                                        lblGlassNotification.ForeColor = Color.Black;
                                    }      
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
        private void GlassUpdateNotification()
        {
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
                                lblGlassUpdateNotification.Text = rd[0].ToString();
                                if (rd[0].ToString() != "0")
                                {
                                    lblGlassUpdateNotification.BackColor = Color.Red;
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
        }
      
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "errorval";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
    }
}