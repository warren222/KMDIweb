﻿using KMDIweb.SCREENfab;
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
    public partial class AC_For_Trun_Over : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["KMDI_userid"] != null)
                {
                    if (!IsPostBack)
                    {
                        loadae();
                        loaddata();
                    }
                }
                else
                {
                    Response.Redirect("~/KMDIweb/Global/Login.aspx");
                }
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
        private void loadae()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "AC_Turn_Over_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "AE_List");
                        ddlAE.DataSource = sqlcmd.ExecuteReader();
                        ddlAE.DataTextField = "fullname";
                        ddlAE.DataValueField = "fullname";
                        ddlAE.DataBind();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        private string fullname
        {
            get
            {
                return Session["KMDI_fullname"].ToString();
            }
        }
        private string ae()
        {
            string user_code = Session["KMDI_user_code"].ToString();
            if (user_code == "AE")
            {
                return fullname;
            }
            else
            {
                return ddlAE.Text;
            }
        }
        private void loaddata()
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
                        sqlcmd.CommandText = "AC_Turn_Over_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Project");
                        sqlcmd.Parameters.AddWithValue("@Search", tboxSearch.Text);
                        sqlcmd.Parameters.AddWithValue("@AE", ae());
                        sqlcmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue.ToString());
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvProject.DataSource = tb;
                            gvProject.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            finally
            {
                loadSummary();
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
                        DataTable tb = new DataTable();
                        tb.Clear();
                        sqlcon.Open();
                        sqlcmd.CommandText = "AC_Turn_Over_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Project");
                        sqlcmd.Parameters.AddWithValue("@SubCommand", "Summary");
                        sqlcmd.Parameters.AddWithValue("@AE", ae());
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvSummary.DataSource = tb;
                            gvSummary.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            loaddata();
        }
        protected void gvProject_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "keyrelease")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvProject.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                executeQuery("Key Release", id, "");
            }
            else if (e.CommandName == "COCreceive")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvProject.Rows[rowindex];
                string id = ((Label)row.FindControl("lblId")).Text;
                string remarks = ((TextBox)row.FindControl("tboxRemarks")).Text;
                executeQuery("COC Receive", id, remarks);
            }
        }

        protected void gvProject_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvProject.PageIndex = e.NewPageIndex;
            loaddata();
        }
        protected void gvSummary_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ForKeyPrep")
            {
                tboxSearch.Text = "";
                ddlAE.Text = "";
                ddlStatus.Text = "For Key Prep";
                loaddata();
            }
            else if (e.CommandName == "KeyReleased")
            {
                tboxSearch.Text = "";
                ddlAE.Text = "";
                ddlStatus.Text = "Key Released";
                loaddata();
            }
            else if (e.CommandName == "COCReceived")
            {
                tboxSearch.Text = "";
                ddlAE.Text = "";
                ddlStatus.Text = "COC Received";
                loaddata();
            }
        }
        private void executeQuery(string command, string id, string remarks)
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
                        sqlcmd.CommandText = "AC_Turn_Over_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", command);
                        sqlcmd.Parameters.AddWithValue("@Id", id);
                        sqlcmd.Parameters.AddWithValue("@Remarks", remarks);
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
    }
}