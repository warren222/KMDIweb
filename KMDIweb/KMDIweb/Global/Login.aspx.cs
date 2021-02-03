using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.SCREENfab
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {


                int port = HttpContext.Current.Request.Url.Port;
                switch (port)
                {
                    case 8083:
                        //server1.Checked = true;
                        DropDownList1.SelectedIndex = 0;
                        break;
                    case 8082:
                        //server2.Checked = true;
                        DropDownList1.SelectedIndex = 1;
                        break;
                    default:
                        //server1.Checked = true;
                        DropDownList1.SelectedIndex = 0;
                        break;
                }
         
                if (Request.Cookies["SFMusername"] != null && Request.Cookies["SFMpassword"] != null)
                {
                    tboxusername.Text = Request.Cookies["SFMusername"].Value;
                    tboxpassword.Attributes["value"] = Request.Cookies["SFMpassword"].Value;
                }
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                //if (server1.Checked)
                //{
                //    ConnectionString.getConnectionString("server1");
                //}
                //else
                //{
                //    ConnectionString.getConnectionString("server2");
                //}
                if (DropDownList1.SelectedIndex==0)
                {
                    ConnectionString.getConnectionString("server1");
                }
                else
                {
                    ConnectionString.getConnectionString("server2");
                }

                string cs = ConnectionString.sqlconstr();
                using (SqlConnection sqlcon = new SqlConnection(cs))
                {
                    sqlcon.Open();
                    SqlCommand sqlcmd = new SqlCommand("select ID,USERNAME,NICKNAME,FULLNAME,SFM,FFM,SDR from kmdi_web_acct where USERNAME = @username and PASSWORD = @password", sqlcon);
                    sqlcmd.Parameters.AddWithValue("@username", tboxusername.Text);
                    sqlcmd.Parameters.AddWithValue("@Password", tboxpassword.Text);
                    SqlDataReader rd = sqlcmd.ExecuteReader();
                    if (rd.HasRows)
                    {

                        while (rd.Read())
                        {
                            Session["KMDI_userid"] = rd[0].ToString();
                            Session["KMDI_username"] = rd[1].ToString();
                            Session["KMDI_nickname"] = rd[2].ToString();
                            Session["KMDI_fullname"] = rd[3].ToString();
                            Session["KMDI_sfm_acct"] = rd[4].ToString();
                            Session["KMDI_ffm_acct"] = rd[5].ToString();
                            Session["KMDI_sdr_acct"] = rd[6].ToString();
                            if (CheckBox1.Checked)
                            {
                                Response.Cookies["SFMusername"].Expires = DateTime.Now.AddDays(30);
                                Response.Cookies["SFMpassword"].Expires = DateTime.Now.AddDays(30);
                            }
                            else
                            {
                                Response.Cookies["SFMusername"].Expires = DateTime.Now.AddDays(-1);
                                Response.Cookies["SFMpassword"].Expires = DateTime.Now.AddDays(-1);

                            }
                            Response.Cookies["SFMusername"].Value = tboxusername.Text.Trim();
                            Response.Cookies["SFMpassword"].Value = tboxpassword.Text.Trim();
                            Response.Redirect("~/KMDIweb/Global/mainmenu.aspx");

                        }

                        rd.Close();
                    }
                    else
                    {
                        CustomValidator err = new CustomValidator();
                        err.ValidationGroup = "val1";
                        err.IsValid = false;
                        err.ErrorMessage = "invalid login";
                        Page.Validators.Add(err);
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
    }
    }