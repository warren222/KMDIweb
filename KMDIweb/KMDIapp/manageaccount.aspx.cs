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
        string fullname, nickname, id, accttype = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (Session["KMDI_acct"].ToString() == "Admin")
                {
                    if (!IsPostBack)
                    {
                        loaddata();
                    }
                }
                else
                {
                    Response.Redirect("~/KMDIapp/invalidaccess.aspx");
                }
            }
            else
            {
                Response.Redirect("~/KMDIapp/Login.aspx");
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
                        sqlcmd.Parameters.AddWithValue("@accttype", "");
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
                ((DropDownList)row.FindControl("DDLeditaccounttype")).Visible = true;
                ((DropDownList)row.FindControl("DDLeditaccounttype")).Text = ((Label)row.FindControl("LBLaccttype")).Text;

                ((LinkButton)row.FindControl("BTNedit")).Visible = false;
                ((LinkButton)row.FindControl("BTNdelete")).Visible = false;
                ((Label)row.FindControl("LBLfullname")).Visible = false;
                ((Label)row.FindControl("LBLnickname")).Visible = false;
                ((Label)row.FindControl("LBLaccttype")).Visible = false;
            }
            else if (e.CommandName == "mycancel")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];

                ((LinkButton)row.FindControl("BTNsave")).Visible = false;
                ((LinkButton)row.FindControl("BTNcancel")).Visible = false;
                ((TextBox)row.FindControl("TBOXeditfullname")).Visible = false;
                ((TextBox)row.FindControl("TBOXeditnickname")).Visible = false;
                ((DropDownList)row.FindControl("DDLeditaccounttype")).Visible = false;

                ((LinkButton)row.FindControl("BTNedit")).Visible = true;
                ((LinkButton)row.FindControl("BTNdelete")).Visible = true;
                ((Label)row.FindControl("LBLfullname")).Visible = true;
                ((Label)row.FindControl("LBLnickname")).Visible = true;
                ((Label)row.FindControl("LBLaccttype")).Visible = true;
            }
            else if (e.CommandName == "mysave")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                id = ((Label)row.FindControl("LBLid")).Text;
                fullname = ((TextBox)row.FindControl("TBOXeditfullname")).Text;
                nickname = ((TextBox)row.FindControl("TBOXeditnickname")).Text;
                accttype = ((DropDownList)row.FindControl("DDLeditaccounttype")).Text;
                executecommands("update data");


            }
            else if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                id = ((Label)row.FindControl("LBLid")).Text;
                fullname = ((TextBox)row.FindControl("TBOXeditfullname")).Text;
                nickname = ((TextBox)row.FindControl("TBOXeditnickname")).Text;
                accttype = ((DropDownList)row.FindControl("DDLeditaccounttype")).Text;
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
                        sqlcmd.Parameters.AddWithValue("@accttype", accttype);
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
            accttype = DDLaccounttype.Text;
            executecommands("insert data");
        }

    }
}