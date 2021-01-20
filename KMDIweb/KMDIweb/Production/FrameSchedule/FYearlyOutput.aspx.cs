using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.Production.FrameSchedule
{
    public partial class FYearlyOutput : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["KMDI_userid"] != null)
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
                    tboxy1.Text = DateTime.Now.Year.ToString();
                    tboxy2.Text = Convert.ToString(DateTime.Now.Year - 1);
                    GetChartType();
                    ddlChartType.SelectedIndex = 8;
                    loadChartData();
                    ddlSortBy.Items.Clear();
                    ddlSortBy.Items.Add(tboxy1.Text);
                    ddlSortBy.Items.Add(tboxy2.Text);
                    loadTableData();
                    GridView1.Columns[3].HeaderText = tboxy2.Text;
                    GridView1.Columns[2].HeaderText = tboxy1.Text;
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
        private void loadChartData()
        {

            DataTable tb = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    DataSet ds = new DataSet();
                    sqlcon.Open();

                    sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                    sqlcmd.CommandText = "frame_yearly_output_stp";
                    sqlcmd.Parameters.AddWithValue("@year1", tboxy1.Text);
                    sqlcmd.Parameters.AddWithValue("@year2", tboxy2.Text);
                    sqlcmd.Parameters.AddWithValue("@searchby", ddlSearchby.Text);

                    using (SqlDataAdapter da = new SqlDataAdapter())
                    {
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        ViewState["tb"] = ds;
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

        private void loadTableData()
        {
            DataTable tb = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    DataSet ds = new DataSet();
                    sqlcon.Open();

                    sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                    sqlcmd.CommandText = "frame_yearly_output_stp";
                    sqlcmd.Parameters.AddWithValue("@year1", tboxy1.Text);
                    sqlcmd.Parameters.AddWithValue("@year2", tboxy2.Text);
                    sqlcmd.Parameters.AddWithValue("@searchby", ddlSearchby.Text);

                    using (SqlDataAdapter da = new SqlDataAdapter())
                    {
                        DataTable dt = new DataTable();
                        da.SelectCommand = sqlcmd;
                        da.Fill(dt);
                        string sortBy = null;
                        if (ddlSortBy.Text == tboxy1.Text)
                        {
                            sortBy = "qty1";
                        }
                        else if (ddlSortBy.Text == tboxy2.Text)
                        {
                            sortBy = "qty2";
                        }
                        dt.DefaultView.Sort = string.IsNullOrEmpty(sortBy) ? " M ASC" : sortBy + " " + ddlOrderBy.Text;
                        dt = dt.DefaultView.ToTable();
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    
                    }
                }
            }
        }
        private void GetChartType()
        {
            foreach (int chartType in Enum.GetValues(typeof(SeriesChartType)))
            {
                ListItem li = new ListItem(Enum.GetName(typeof(SeriesChartType), chartType), chartType.ToString());
                ddlChartType.Items.Add(li);
            }
        }

        protected void ddlChartType_SelectedIndexChanged(object sender, EventArgs e)
        {
            setChartType();
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            setChartType();
        }
        private void setChartType()
        {
            Chart1.Series.FirstOrDefault().ChartType = (SeriesChartType)Enum.Parse(typeof(SeriesChartType), ddlChartType.SelectedValue);
            Chart1.Series.LastOrDefault().ChartType = (SeriesChartType)Enum.Parse(typeof(SeriesChartType), ddlChartType.SelectedValue);
            loadChartData();
            ddlSortBy.Items.Clear();
            ddlSortBy.Items.Add(tboxy1.Text);
            ddlSortBy.Items.Add(tboxy2.Text);
            loadTableData();
            GridView1.Columns[3].HeaderText = tboxy2.Text;
            GridView1.Columns[2].HeaderText = tboxy1.Text;
        }

        protected void ddlSortDirection_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadChartData();
        }

        protected void ddlSortBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadChartData();
        }

        protected void btnSort_Click(object sender, EventArgs e)
        {
            loadTableData();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                GridView1.Columns[3].HeaderText = tboxy2.Text;
                GridView1.Columns[2].HeaderText = tboxy1.Text;
            }
        }
    }
}