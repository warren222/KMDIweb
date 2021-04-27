using KMDIweb.KMDIweb.Global.objects;
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
    public partial class NoticeForIncompleteItem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            loadData();
        }
        private void loadData()
        {

            //Session["LBLparentjono"].ToString();
            lblProject.Text = Session["LBLprojectname"].ToString();
            lblAddress.Text = Session["LBLaddress"].ToString();
            GridView1.DataSource = (List<kmdino>)Session["listKno"];
            GridView1.DataBind();
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private string myName
        {
            get
            {
               return Session["KMDI_fullname"].ToString();
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
        protected void saveBTN_Click(object sender, EventArgs e)
        {
            int x = InsertedID();
            if (x > 0)
            {
                foreach (GridViewRow row in GridView1.Rows)
                {
                    Label kno = (Label)row.FindControl("lblKno");
                    TextBox description = (TextBox)row.FindControl("tboxDescription");
                    Console.WriteLine(kno.Text + " " + description.Text);
                    SaveItems(x, kno.Text, description.Text);
                }
            }
        }
        private int InsertedID()
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
                        sqlcmd.Parameters.AddWithValue("@Command", "Insert");
                        sqlcmd.Parameters.AddWithValue("@Parentjono", Session["LBLparentjono"].ToString());
                        sqlcmd.Parameters.AddWithValue("@Dated", tboxDate.Text);
                        sqlcmd.Parameters.AddWithValue("@Reason", tboxReason.Text);
                        sqlcmd.Parameters.AddWithValue("@Prepared_By", myName);
                        sqlcmd.Parameters.AddWithValue("@Approved_By", "");
                        sqlcmd.Parameters.AddWithValue("@Approved_By2", "");
                        return (int)sqlcmd.ExecuteScalar();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                        return 0;
                    }
                }
            }
        }
        private void SaveItems(int NFII_ID, string _kno, string _description)
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "NOTICE_FOR_INCOMPLETE_ITEM_LIST_STP";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Insert");
                        sqlcmd.Parameters.AddWithValue("@NFII_ID", NFII_ID);
                        sqlcmd.Parameters.AddWithValue("@KMDI_NO", _kno);
                        sqlcmd.Parameters.AddWithValue("@_Description", _description);
                        sqlcmd.ExecuteNonQuery();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
    }
}