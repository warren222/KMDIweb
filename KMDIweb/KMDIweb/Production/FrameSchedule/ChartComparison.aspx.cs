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
    public partial class ChartComparison : System.Web.UI.Page
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
                        tboxy1.Text = DateTime.Now.Year.ToString();
                        loadChartData();
                    }
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
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
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
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
                    sqlcmd.CommandText = "frame_yearly_output_sd_due_stp";
                    sqlcmd.Parameters.AddWithValue("@year1", tboxy1.Text);

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

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            loadChartData();
        }
    }
}