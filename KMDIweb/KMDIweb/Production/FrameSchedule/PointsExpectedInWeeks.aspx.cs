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
    public partial class PointsExpectedInWeeks : System.Web.UI.Page
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
                    if (!IsPostBack)
                    {
                        tableData();
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

        protected void linkNotrequested_Click(object sender, EventArgs e)
        {
            gridData("NotRequested");
            Panel1.Visible = true;
            Panel2.Visible = false;
        }

        protected void linkRequested_Click(object sender, EventArgs e)
        {
            gridData("Requested");
            Panel1.Visible = false;
            Panel2.Visible = true;
        }
        private void gridData(string command)
        {

            DataTable tb = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    DataSet ds = new DataSet();
                    sqlcon.Open();

                    sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                    sqlcmd.CommandText = "SD_TO_RECEIVE_STP";

                    sqlcmd.Parameters.AddWithValue("@Command", command);

                    using (SqlDataAdapter da = new SqlDataAdapter())
                    {
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        ViewState["tb"] = ds;
                        GridView1.DataSource = ds;
                        GridView1.DataBind();
                    }
                }
            }
        }
        private void tableData()
        {

           
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    DataSet ds = new DataSet();
                    sqlcon.Open();

                    sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                    sqlcmd.CommandText = "SD_TO_RECEIVE_STP";

                    sqlcmd.Parameters.AddWithValue("@Command", "tableData");

                    using (SqlDataReader rd = sqlcmd.ExecuteReader())
                    {
                        while (rd.Read())
                        { 
                            linkNotrequested.Text = rd[0].ToString();
                            linkRequested.Text = rd[1].ToString();
                        }
                    }
                }
            }

        }
    }
}