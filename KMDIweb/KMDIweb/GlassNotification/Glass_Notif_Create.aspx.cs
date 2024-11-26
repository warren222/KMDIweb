using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.GlassNotification
{
    public partial class Glass_Notif_Create : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
        private void Get_PO()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Glass_PO_Notification_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Find_PO");
                        sqlcmd.Parameters.AddWithValue("@Search", tboxFind.Text);
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvFind.DataSource = tb;
                            gvFind.DataBind();
                        }
                        string row_count = tb.Rows.Count.ToString("N0");
                        //lblResult.Text = row_count;
                    }
                    catch (Exception ex)
                    {
                        errorrmessage(ex.ToString());
                    }
                }
            }
        }
        protected void btnFind_Click(object sender, EventArgs e)
        {
            Get_PO();
        }
    }
}