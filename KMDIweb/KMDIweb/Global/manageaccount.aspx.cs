using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIapp
{
    public partial class manageaccount : System.Web.UI.Page
    {
        string fullname, nickname, id, sfm = "", sdr = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (Session["KMDI_sfm_acct"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        loaddata();
                    }
                }
                else
                {
                    Response.Redirect("~/KMDIweb/Global/Invalidaccess.aspx");
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
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "errorval";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }

        private void loaddata()
        {
            try
            {
                DataTable tb = new DataTable();
                tb.Clear();
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcmd.CommandText = "screen_account_stp";
                        sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "load data");
                        sqlcmd.Parameters.AddWithValue("@id", "");
                        sqlcmd.Parameters.AddWithValue("@fullname", "");
                        sqlcmd.Parameters.AddWithValue("@nickname", "");
                        sqlcmd.Parameters.AddWithValue("@sfm", "");
                        sqlcmd.Parameters.AddWithValue("@sdr", "");
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            GridView1.DataSource = tb;
                            GridView1.DataBind();
                        }



                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            loaddata();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "myedit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                ((LinkButton)row.FindControl("BTNsave")).Visible = true;
                ((LinkButton)row.FindControl("BTNcancel")).Visible = true;
                ((TextBox)row.FindControl("TBOXeditfullname")).Visible = true;
                ((TextBox)row.FindControl("TBOXeditnickname")).Visible = true;
                ((DropDownList)row.FindControl("DDLeditsfm")).Visible = true;
                ((DropDownList)row.FindControl("DDLeditsdr")).Visible = true;
                ((DropDownList)row.FindControl("DDLeditsfm")).Text = ((Label)row.FindControl("LBLsfm")).Text;
                ((DropDownList)row.FindControl("DDLeditsdr")).Text = ((Label)row.FindControl("LBLsdr")).Text;

                ((LinkButton)row.FindControl("BTNedit")).Visible = false;
                ((LinkButton)row.FindControl("BTNdelete")).Visible = false;
                ((Label)row.FindControl("LBLfullname")).Visible = false;
                ((Label)row.FindControl("LBLnickname")).Visible = false;
                ((Label)row.FindControl("LBLsfm")).Visible = false;
                ((Label)row.FindControl("LBLsdr")).Visible = false;
            }
            else if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                ((LinkButton)row.FindControl("BTNsave")).Visible = false;
                ((LinkButton)row.FindControl("BTNcancel")).Visible = false;
                ((TextBox)row.FindControl("TBOXeditfullname")).Visible = false;
                ((TextBox)row.FindControl("TBOXeditnickname")).Visible = false;
                ((DropDownList)row.FindControl("DDLeditsfm")).Visible = false;
                ((DropDownList)row.FindControl("DDLeditsdr")).Visible = false;

                ((LinkButton)row.FindControl("BTNedit")).Visible = true;
                ((LinkButton)row.FindControl("BTNdelete")).Visible = true;
                ((Label)row.FindControl("LBLfullname")).Visible = true;
                ((Label)row.FindControl("LBLnickname")).Visible = true;
                ((Label)row.FindControl("LBLsfm")).Visible = true;
                ((Label)row.FindControl("LBLsdr")).Visible = true;
            }
            else if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                id = ((Label)row.FindControl("LBLid")).Text;
                fullname = ((TextBox)row.FindControl("TBOXeditfullname")).Text;
                nickname = ((TextBox)row.FindControl("TBOXeditnickname")).Text;
                sfm = ((DropDownList)row.FindControl("DDLeditsfm")).Text;
                sdr = ((DropDownList)row.FindControl("DDLeditsdr")).Text;
                executecommands("update data");


            }
            else if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                id = ((Label)row.FindControl("LBLid")).Text;
                fullname = ((TextBox)row.FindControl("TBOXeditfullname")).Text;
                nickname = ((TextBox)row.FindControl("TBOXeditnickname")).Text;
                sfm = ((DropDownList)row.FindControl("DDLeditsfm")).Text;
                sdr = ((DropDownList)row.FindControl("DDLeditsdr")).Text;
                executecommands("delete data");
            }
        }



        private void executecommands(string command)
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcmd.CommandText = "screen_account_stp";
                        sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", command);
                        sqlcmd.Parameters.AddWithValue("@id", id);
                        sqlcmd.Parameters.AddWithValue("@fullname", fullname);
                        sqlcmd.Parameters.AddWithValue("@nickname", nickname);
                        sqlcmd.Parameters.AddWithValue("@sfm", sfm);
                        sqlcmd.Parameters.AddWithValue("@sdr", sdr);
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
                loaddata();
            }
        }

        protected void BTNadd_Click(object sender, EventArgs e)
        {
            id = "";
            fullname = TBOXfullname.Text;
            nickname = TBOXnickname.Text;
            sfm = DDLsfm.Text;
            sdr = DDLsdr.Text;
            executecommands("insert data");
        }

    }
}