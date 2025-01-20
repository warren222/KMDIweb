using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.Delivery.ScannedDR
{
    public partial class DRupdatesItems : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    Get_Data();
                    lblProject.Text = Request.QueryString["project"].ToString();
                    lblDRNo.Text = Request.QueryString["drno"].ToString();
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
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/Delivery/ScannedDR/DRupdates.aspx" + AddQuerystring);
        }
        private string AddQuerystring
        {
            get
            {
                return "?Find=" + Request.QueryString["Find"].ToString() +
                    "&Specification=" + Request.QueryString["Specification"].ToString() +
                    "&DateDelivered=" + Request.QueryString["DateDelivered"].ToString() +
                    "&PageIndex=" + Request.QueryString["PageIndex"].ToString();
            }
        }
        private void Get_Data()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        string jo = Request.QueryString["jo"].ToString();
                        string specs = Request.QueryString["specs"].ToString();
                        string drno = Request.QueryString["drno"].ToString();
                        sqlcmd.CommandText = "DR_Web_Updates_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_DR_Items");
                        sqlcmd.Parameters.AddWithValue("@Specs",specs );
                        sqlcmd.Parameters.AddWithValue("@Job_Order_No", jo);
                        sqlcmd.Parameters.AddWithValue("@DR_No", drno);
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvItems.DataSource = tb;
                            gvItems.DataBind();
                        }
                        string row_count = tb.Rows.Count.ToString("N0");
                        lblRowCount.Text = row_count + " item(s)";
                    }
                    catch (Exception ex)
                    {
                        errorrmessage(ex.ToString());
                    }
                }
            }
        }
    }
}