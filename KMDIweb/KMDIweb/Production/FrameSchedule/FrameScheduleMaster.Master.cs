﻿using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.Production.FrameSchedule
{
    public partial class FrameScheduleMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                username.Text = Session["KMDI_nickname"].ToString() + " ";
                Notifcounter();
                access();
                summaryAccess();
                estdaccess();
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private void access()
        {
            if (Session["KMDI_ffm_acct"].ToString() == "Admin")
            {
                BTNaccount.Visible = true;
                HyperLink16.Visible = true;
            }
            else
            {
                BTNaccount.Visible = false;
                HyperLink16.Visible = false;
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
        private string myName
        {
            get
            {
                return Session["KMDI_fullname"].ToString();
            }
        }
        private string usercode
        {
            get
            {
                return Session["KMDI_user_code"].ToString();
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
        private void countNotice(string command)
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
                        sqlcmd.Parameters.AddWithValue("@Fullname", myName);
                        SqlDataReader rd = sqlcmd.ExecuteReader();
                        while (rd.Read())
                        {
                            if (rd[0].ToString() == "0")
                            {
                                HyperLink19.Text = " Notice For Incomplete Items";
                            }
                            else
                            {
                                HyperLink19.Text = "<span class='badge'  style='font-size:smaller;background-color:red;'>" + rd[0].ToString() + "</span>" + " Notice For Incomplete Items";
                            }

                        }
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        private void summaryAccess()
        {
            if ((usercode == "Production Manager") ||
                      (usercode == "Production Engineer") ||
                       (usercode == "Supervisor") ||
                        (usercode == "Programmer") || 
                      (usercode == "Management"))

            {
                HyperLink21.Visible = true;
                HyperLink22.Visible = true;
                HyperLink23.Visible = true;
                HyperLink15.Visible = true;
                HyperLink17.Visible = true;
                HyperLink27.Visible = true;
            }
            
            else
            {
                HyperLink22.Visible = false;
                HyperLink21.Visible = false;
                HyperLink23.Visible = false;
                HyperLink15.Visible = false;
                HyperLink17.Visible = false;
                HyperLink27.Visible = false;
            }
            if (usercode == "AE" || usercode == "Engineer")
            {
                HyperLink15.Visible = true;
            }
        }
        private void estdaccess()
        {
            if ((usercode == "Production Manager") ||
                      (usercode == "Engineer Manager") ||
                        (usercode == "Programmer") ||
                      (usercode == "Management")) 

            {
                HyperLink24.Visible = true;
            }
            else
            {
                HyperLink24.Visible = false;
            }
        }
        private void Notifcounter()
        {
            if (usercode == "Delivery Head")
            {
                countNotice("CountForApprovalDeliveryHead");
            }
            else if (usercode == "Engineer Manager")
            {
                countNotice("CountForApproval");
            }
            else if (usercode == "Production Engineer")
            {
                countNotice("CountForReceive");
            }
            else if (usercode == "Production Manager")
            {
                countNotice("CountForNoted");
            }
            else if (usercode == "Delivery")
            {
                countNotice("CountForAcknowledgment");
            }
        }
    }
}