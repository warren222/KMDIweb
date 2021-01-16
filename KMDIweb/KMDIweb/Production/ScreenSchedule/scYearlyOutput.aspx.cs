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

namespace KMDIweb.KMDIweb.Production.ScreenSchedule
{
    public partial class scYearlyOutput : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    tboxy1.Text = DateTime.Now.Year.ToString();
                    tboxy2.Text = Convert.ToString(DateTime.Now.Year-1);
                    GetChartType();
                    ddlChartType.SelectedIndex = 2;
                    getdata();
                 
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
        private void getdata()
        {
            DataTable tb = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    sqlcon.Open();
                    sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                    sqlcmd.CommandText = "screen_yearly_output_stp";
                    sqlcmd.Parameters.AddWithValue("@year1", tboxy1.Text);
                    sqlcmd.Parameters.AddWithValue("@year2", tboxy2.Text);
                    sqlcmd.Parameters.AddWithValue("@searchby", ddlSearchby.Text);
                    using (SqlDataReader rd = sqlcmd.ExecuteReader())
                    {
                        Chart1.DataSource = rd;
                        Chart1.DataBind();
                        Chart1.ChartAreas[0].AxisX.LabelStyle.Interval = 1;
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
            Chart1.Series["Year1"].ChartType = (SeriesChartType)Enum.Parse(typeof(SeriesChartType), ddlChartType.SelectedValue);
            Chart1.Series["Year2"].ChartType = (SeriesChartType)Enum.Parse(typeof(SeriesChartType), ddlChartType.SelectedValue);
            getdata();
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            Chart1.Series["Year1"].ChartType = (SeriesChartType)Enum.Parse(typeof(SeriesChartType), ddlChartType.SelectedValue);
            Chart1.Series["Year2"].ChartType = (SeriesChartType)Enum.Parse(typeof(SeriesChartType), ddlChartType.SelectedValue);
            getdata();
        }
    }
}