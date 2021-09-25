using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
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
                loaddata();
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
                        sqlcmd.Parameters.AddWithValue("@Command", "Load");
                        sqlcmd.Parameters.AddWithValue("@AE", fullname);
                        sqlcmd.Parameters.AddWithValue("@UserRole", userRole);
                        sqlcmd.Parameters.AddWithValue("@Search", tboxProject.Text);
                        sqlcmd.Parameters.AddWithValue("@Sdate", bdate);
                        sqlcmd.Parameters.AddWithValue("@Edate", edate);
                        DataTable tb = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();


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
            if(tboxBegin.Text == "")
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
            loaddata();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UploadFile")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["CollectionId"] = ((Label)row.FindControl("CollectionId")).Text;
                Session["CollectionProject"] = ((Label)row.FindControl("Label4")).Text;
                Response.Redirect("~/KMDIweb/AE/CollectionLedger/Fileupload.aspx");
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            loaddata();
        }
    }
}