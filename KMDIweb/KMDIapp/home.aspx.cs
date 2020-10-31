using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
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
                    var monday = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Monday);
                    var sunday = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Sunday + 7);
                    tboxBdate.Text = Convert.ToDateTime(monday).ToString("yyyy-MM-dd");
                    tboxEdate.Text = Convert.ToDateTime(sunday).ToString("yyyy-MM-dd");
                    //tboxBdate.Text = Convert.ToString(DateTime.Now.Year.ToString() + "-" + DateTime.Now.Month.ToString() + "-01");
                    //tboxEdate.Text = Convert.ToString(DateTime.Now.Year.ToString() + "-" + DateTime.Now.Month.ToString() + "-" + System.DateTime.DaysInMonth(DateTime.Now.Year, DateTime.Now.Month).ToString());

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
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "load schedule");
                        sqlcmd.Parameters.AddWithValue("@bdate", tboxBdate.Text);
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
            catch (Exception ex)
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
                        sqlcmd.Parameters.AddWithValue("@bdate", tboxBdate.Text);
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
                        sqlcmd.Parameters.AddWithValue("@bdate", tboxBdate.Text);
                        sqlcmd.Parameters.AddWithValue("@edate", tboxEdate.Text);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                LBLloadpoints.Text = rd[0].ToString() + " hours";
                                LBLloadkno.Text = rd[1].ToString() + " items";
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

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
            for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
            {
                Label lblparent = (Label)GridView1.Rows[i].FindControl("LBLday");
                Label lblfinished = (Label)GridView1.Rows[i].FindControl("LBLfinished");
                if (lblparent.Text == "Monday")
                {
                    GridView1.Rows[i].Cells[0].BackColor = Color.LightBlue;
                    lblparent.ForeColor = Color.Black;
                }
              else  if (lblparent.Text == "Tuesday")
                {
                    GridView1.Rows[i].Cells[0].BackColor = Color.LightGreen;
                    lblparent.ForeColor = Color.Black;
                }
                else if (lblparent.Text == "Wednesday")
                {
                    GridView1.Rows[i].Cells[0].BackColor = Color.Yellow;
                    lblparent.ForeColor = Color.Black;
                }
                else if (lblparent.Text == "Thursday")
                {
                    GridView1.Rows[i].Cells[0].BackColor = Color.Orange;
                    lblparent.ForeColor = Color.Black;
                }
                else if (lblparent.Text == "Friday")
                {
                    GridView1.Rows[i].Cells[0].BackColor = Color.Pink;
                    lblparent.ForeColor = Color.Black;
                }
                else if (lblparent.Text == "Saturday")
                {
                    GridView1.Rows[i].Cells[0].BackColor = Color.Violet;
                    lblparent.ForeColor = Color.Black;
                }
                else
                {
                    GridView1.Rows[i].Cells[0].BackColor = Color.Teal;
                    lblparent.ForeColor = Color.Black;
                }
                if (lblfinished.Text != "")
                {
                    GridView1.Rows[i].Cells[7].BackColor = Color.Brown;
                    lblfinished.ForeColor = Color.White;
                }
            }
        }

        protected void LinkButton5_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIapp/scppm.aspx");
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIapp/scasbl.aspx");
        }

        protected void LinkButton6_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIapp/scassemble.aspx");
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIapp/scaccessories.aspx");
        }

        protected void LinkButton7_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIapp/scqc.aspx");
        }
    }
}