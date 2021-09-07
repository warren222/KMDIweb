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
    public partial class ProjectionChart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (Session["KMDI_ffm_acct"].ToString() == "Guest" || Session["KMDI_ffm_acct"].ToString() == "None")
                {
                    ScriptManager.RegisterStartupScript(this, Page.GetType(), "script", "alert('invalid access!');", true);
                }
                else
                {
                    if (ViewState["tb"] != null)
                    {
                        Chart1.DataSource = (DataSet)ViewState["tb"];
                        Chart1.DataBind();

                        Chart1.ChartAreas[0].AxisX.LabelStyle.Interval = 1;
                        Chart1.ChartAreas[0].AxisY.LabelStyle.Format = "N0";
                        Chart1.ChartAreas[0].AxisY2.LabelStyle.Format = "N0";
                    }
                    if (!IsPostBack)
                    {
                        tboxYear.Text = DateTime.Now.Year.ToString();
                        tboxYear2.Text = DateTime.Now.Year.ToString();
                        loadChartData();
                        loadAverage();
                        loadPointsToReceived();
                    }
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
        private void loadPointsToReceived()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "projection_chart_stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "loadPointsToReceived");
                        sqlcmd.Parameters.AddWithValue("@Searchby", ddlsearchby.SelectedValue);
                        sqlcmd.Parameters.AddWithValue("@year2", tboxYear2.Text);
                        GridView7.DataSource = sqlcmd.ExecuteReader();
                        GridView7.DataBind();
                        loadChartData();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        private void loadChartData()
        {
            try
            {
                DataTable tb = new DataTable();
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        DataSet ds = new DataSet();
                        sqlcon.Open();

                        sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                        sqlcmd.CommandText = "projection_chart_stp";
                        sqlcmd.Parameters.AddWithValue("@command", "chart");
                        sqlcmd.Parameters.AddWithValue("@year1", tboxYear.Text);

                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(ds);
                            Chart1.DataSource = ds;
                            Chart1.DataBind();

                            //DataView dv = ds.Tables[0].DefaultView;
                            //Chart1.DataBindTable(dv, "MM");
                            Chart1.ChartAreas[0].AxisX.LabelStyle.Interval = 1;
                            Chart1.ChartAreas[0].AxisY.LabelStyle.Format = "N0";
                            Chart1.ChartAreas[0].AxisY2.LabelStyle.Format = "N0";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message);
            }
        }
        private void loadAverage()
        {
            try
            {


                DataTable tb = new DataTable();
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        DataSet ds = new DataSet();
                        sqlcon.Open();

                        sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                        sqlcmd.CommandText = "projection_chart_stp";
                        sqlcmd.Parameters.AddWithValue("@command", "average");
                        sqlcmd.Parameters.AddWithValue("@year1", tboxYear.Text);

                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(ds);
                            GridView1.DataSource = ds;
                            GridView1.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message);
            }

        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            loadChartData();
            loadAverage();
        }

        protected void ddlsearchby_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlsearchby.SelectedIndex == 1)
            {
                Panel2.Visible = true;
            }
            else
            {
                Panel2.Visible = false;
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            loadPointsToReceived();
        }
    }
}