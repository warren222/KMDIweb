﻿using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.AE.CollectionLedger
{
    public partial class CollectionLedgerFrm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (Session["CollectionLedgerSearch"] != null)
                {
                    tboxProject.Text = Session["CollectionLedgerSearch"].ToString();
                    tboxBegin.Text = Session["CollectionLedgerBdate"].ToString();
                    tboxEnd.Text = Session["CollectionLedgerEdate"].ToString();

                    if (Session["CollectionLedgerIsVerified"].ToString() == "True")
                    {
                        cboxVerified.Checked = true;
                    }
                    else
                    {
                        cboxVerified.Checked = false;
                    }
                    if (Session["CollectionLedgerIsInputted"].ToString() == "True")
                    {
                        cboxInputted.Checked = true;
                    }
                    else
                    {
                        cboxInputted.Checked = false;
                    }
                    GridView1.PageIndex = Convert.ToInt32(Session["CollectionLedgerPageindex"] == null ? 1 : Session["CollectionLedgerPageindex"]);
                    loaddata();

                }
                else
                {
                    tboxBegin.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    tboxEnd.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    GridView1.PageIndex = Convert.ToInt32(Session["CollectionLedgerPageindex"] == null ? 1 : Session["CollectionLedgerPageindex"]);
                    loaddata();

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
        private string userRole
        {
            get
            {
                return Session["KMDI_clg_acct"].ToString();
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
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {

                        validateConrolValues();
                        sqlcon.Open();
                        sqlcmd.CommandText = "Collection_Ledger_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "AE");
                        sqlcmd.Parameters.AddWithValue("@AE", fullname);
                        sqlcmd.Parameters.AddWithValue("@UserRole", userRole);
                        sqlcmd.Parameters.AddWithValue("@User_Code", Session["KMDI_user_code"].ToString());
                        sqlcmd.Parameters.AddWithValue("@Search", tboxProject.Text);
                        sqlcmd.Parameters.AddWithValue("@Sdate", bdate);
                        sqlcmd.Parameters.AddWithValue("@Edate", edate);

                        sqlcmd.Parameters.AddWithValue("@IsVerified", cboxVerified.Checked.ToString());
                        sqlcmd.Parameters.AddWithValue("@IsInputted", cboxInputted.Checked.ToString());
                        DataTable tb = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();

                        Session["CollectionLedgerSearch"] = tboxProject.Text;
                        Session["CollectionLedgerBdate"] = bdate;
                        Session["CollectionLedgerEdate"] = edate;
                        Session["CollectionLedgerIsVerified"] = cboxVerified.Checked.ToString();
                        Session["CollectionLedgerIsInputted"] = cboxInputted.Checked.ToString();
                    }
                }

            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
        string bdate, edate;
        private void validateConrolValues()
        {
            tboxProject.Text = tboxProject.Text.Replace("'", "`");
            tboxProject.Text = tboxProject.Text.Replace("\"", "``");
            if (tboxBegin.Text == "")
            {
                bdate = "1900-01-01";
            }
            else
            {
                bdate = tboxBegin.Text;
            }
            if (tboxEnd.Text == "")
            {
                edate = "2100-01-01";
            }
            else
            {
                edate = tboxEnd.Text;
            }
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/AE/CollectionLedger/CollectionLedgerInput.aspx");
        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            if (cboxInputted.Checked == true)
            {
                cboxVerified.Checked = true;
            }
            loaddata();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UploadFile")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                //Session["CollectionId"] = ((Label)row.FindControl("CollectionId")).Text;
                //Session["CollectionProject"] = ((Label)row.FindControl("Label4")).Text;
                //Response.Redirect("~/KMDIweb/AE/CollectionLedger/FileUpload.aspx");
                Response.Redirect("~/KMDIweb/AE/CollectionLedger/CollectionLedgerFiles.aspx?Collection_Id=" +
                    ((Label)row.FindControl("CollectionId")).Text + "&Project_Name=" +
                    ((Label)row.FindControl("Label4")).Text + "&Amount=" +
                    ((Label)row.FindControl("Label1")).Text);
            }
            else if (e.CommandName == "DeleteItem")
            {
                if (Session["KMDI_clg_acct"].ToString() == "Admin" && (Session["KMDI_user_code"].ToString() == "Accounting" || Session["KMDI_user_code"].ToString() == "Operations" || Session["KMDI_user_code"].ToString() == "Programmer"))
                {
                    int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                    GridViewRow row = GridView1.Rows[rowindex];
                    deleteitem(((Label)row.FindControl("CollectionId")).Text);
                    string path = "~/KMDIweb/Uploads/CollectionLedger/" + ((Label)row.FindControl("CollectionId")).Text + "/";
                    DeleteFiles(path);
                    loaddata();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, Page.GetType(), "script", "alert('invalid access!');", true);
                }
            }
        }
        private void deleteitem(string id)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {

                        validateConrolValues();
                        sqlcon.Open();
                        sqlcmd.CommandText = "Collection_Ledger_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "DeleteItem");
                        sqlcmd.Parameters.AddWithValue("@Id", id);
                        sqlcmd.ExecuteNonQuery();
                    }
                }

            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
        private void DeleteFiles(string path)
        {
            string[] Files = Directory.GetFiles(Server.MapPath(path));
            foreach (string file in Files)
            {
                FileInfo fileinfo = new FileInfo(file);
                File.Delete(file);
            }
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            Session["CollectionLedgerPageindex"] = e.NewPageIndex;
            loaddata();

        }
    }
}