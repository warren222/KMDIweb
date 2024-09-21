using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIapp
{
    public partial class changesecurity : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    string filepath = "~/KMDI_FILES/WMS/UserSignature/" + Session["KMDI_userid"].ToString() + "/";
                    Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath));
                    if (!IsExists)
                    {
                        System.IO.Directory.CreateDirectory(Server.MapPath(filepath));
                    }
                    foreach (string strfilename in Directory.GetFiles(Server.MapPath(filepath)))
                    {
                        FileInfo fileinfo = new FileInfo(strfilename);
                        Image1.ImageUrl = filepath + fileinfo.Name;
                    }

                    usernametbox.Text = Session["KMDI_username"].ToString();
                    npassword.Text = "";
                    confirmpasswordtbox.Text = "";
                    oldpasswordtbox.Text = "";
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
            err.ValidationGroup = "errorval";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
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
            if (IsValid)
            {
                if (checkpassword() == false)
                {
                    CustomValidator err = new CustomValidator();
                    err.ValidationGroup = "val1";
                    err.IsValid = false;
                    err.ErrorMessage = "old password is incorrect";
                    Page.Validators.Add(err);
                }
                else
                {
                    if (checkusername() == false)
                    {
                        try
                        {

                            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                            {
                                sqlcon.Open();
                                SqlCommand sqlcmd = new SqlCommand("update kmdi_web_acct set username='" + usernametbox.Text + "', password = '" + npassword.Text + "' where id = " + Convert.ToUInt32(Session["KMDI_userid"]) + "", sqlcon);
                                sqlcmd.ExecuteNonQuery();
                            }
                        }
                        catch (Exception ex)
                        {
                            Response.Write(ex.ToString());
                        }
                        finally
                        {
                            Session.Abandon();
                            Response.Redirect("~/KMDIweb/Global/Login.aspx");
                        }
                    }
                    else
                    {
                        CustomValidator err = new CustomValidator();
                        err.ValidationGroup = "val1";
                        err.IsValid = false;
                        err.ErrorMessage = "username already taken!";
                        Page.Validators.Add(err);
                    }
                }
            }
        }
        private bool checkpassword()
        {
            bool hasrow;


            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                sqlcon.Open();
                SqlCommand sqlcmd = new SqlCommand("select * from kmdi_web_acct where username = '" + Session["KMDI_username"].ToString() + "' and password = '" + oldpasswordtbox.Text + "'", sqlcon);
                SqlDataReader dr = sqlcmd.ExecuteReader();
                if (dr.HasRows)
                {
                    hasrow = true;
                }
                else
                {
                    hasrow = false;
                }
            }
            return hasrow;
        }
        private bool checkusername()
        {
            bool hasrow;


            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                sqlcon.Open();
                SqlCommand sqlcmd = new SqlCommand("select * from kmdi_web_acct where username = '" + usernametbox.Text + "' and not id = '" + Session["KMDI_userid"].ToString() + "'", sqlcon);
                SqlDataReader dr = sqlcmd.ExecuteReader();
                if (dr.HasRows)
                {
                    hasrow = true;
                }
                else
                {
                    hasrow = false;
                }
            }
            return hasrow;
        }
    }
}