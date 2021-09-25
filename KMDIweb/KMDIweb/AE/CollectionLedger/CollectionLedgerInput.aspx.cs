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
    public partial class CollectionLedgerInput : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               
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
        private void insert()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        replaceQuote();
                        sqlcon.Open();
                        sqlcmd.CommandText = "Collection_Ledger_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Insert");
                        sqlcmd.Parameters.AddWithValue("@AMOUNT", tboxAmount.Text);
                        sqlcmd.Parameters.AddWithValue("@CHECKDETAILS", tboxCheckDetails.Text);
                        sqlcmd.Parameters.AddWithValue("@DATECOLLECTED", tboxDateColledted.Text);
                        sqlcmd.Parameters.AddWithValue("@PAYMENT_OR_CHECKDATE", tboxPaymentDate.Text);
                        sqlcmd.Parameters.AddWithValue("@AE", fullname);
                        sqlcmd.Parameters.AddWithValue("@PROJECT_NAME", tboxProject.Text);
                        sqlcmd.ExecuteNonQuery();
                    }
                }

            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                Response.Redirect("~/KMDIweb/AE/CollectionLedger/CollectionLedgerFrm.aspx");
            }
        }
        private void replaceQuote()
        {
            tboxCheckDetails.Text = tboxCheckDetails.Text.Replace("'", "`");
            tboxCheckDetails.Text = tboxCheckDetails.Text.Replace("\"", "``");
            tboxProject.Text = tboxProject.Text.Replace("'", "`");
            tboxProject.Text = tboxProject.Text.Replace("\"", "``");
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            insert();
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/AE/CollectionLedger/CollectionLedgerFrm.aspx");
        }
    }
}