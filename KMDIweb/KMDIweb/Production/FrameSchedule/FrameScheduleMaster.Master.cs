using KMDIweb.SCREENfab;
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
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
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
                        SqlDataReader rd = sqlcmd.ExecuteReader();
                        while (rd.Read())
                        {
                            HyperLink19.Text = "<span class='badge'  style='font-size:smaller;background-color:red;'>" + rd[0].ToString() + "</span>" + " Notice For Incomplete Items";
                        }
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        private void Notifcounter()
        {
            if ((usercode == "Delivery Head") || (usercode == "Engineer Manager"))
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
        }
    }
}