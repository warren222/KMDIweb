using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.SCREENfab
{
    public partial class home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    tboxEdate.Text= DateTime.Now.ToString("yyyy-MM-dd");
                    loadtoday();
                    loadschedule();
                    balanceload();
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
        private void loadschedule()
        {
            try
            {
                DataTable tb = new DataTable();

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "[screen_cuttinglist_stp]";
                        sqlcmd.CommandType =CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "load schedule");
                        sqlcmd.Parameters.AddWithValue("@edate", tboxEdate.Text);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();
                        LBLrowcount.Text = tb.Rows.Count.ToString();
                    }
                }
            }
            catch(Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
        private void loadtoday()
        {
            try
            {
                DataTable tb = new DataTable();

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "[screen_cuttinglist_stp]";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "load today");
                        sqlcmd.Parameters.AddWithValue("@edate", tboxEdate.Text);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView2.DataSource = tb;
                        GridView2.DataBind();
     
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
        private void balanceload()
        {
            try
            {
             

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "[screen_cuttinglist_stp]";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "balance load");
                        sqlcmd.Parameters.AddWithValue("@edate", tboxEdate.Text);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                LBLloadpoints.Text = rd[0].ToString()+" hours";
                                LBLloadkno.Text = rd[1].ToString()+" items";
                                LBLtodaypoints.Text = rd[2].ToString() + " hours";
                                LBLtodaykno.Text = rd[3].ToString() + " items";
                            }
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
        protected void BTNsearch_Click(object sender, EventArgs e)
        {
            loadschedule();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            loadschedule();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIapp/sccutting.aspx");
        }
    }
}