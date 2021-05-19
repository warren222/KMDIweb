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
    public partial class FrameOverDue : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    loadsummary();
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

        private void loadsummary()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        lblSection.Text = ddlSection.Text;
                        sqlcon.Open();
                        sqlcmd.CommandText = "FrameLagStp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@section", ddlSection.Text);
                        DataTable tb = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();

                        int totalpoints = 0;
                        for (int i = 0; i <= tb.Rows.Count - 1; i++)
                        {
                            totalpoints += Convert.ToInt32(tb.Rows[i]["points"].ToString());
                        }
                        lblTotalpoints.Text = totalpoints.ToString("n0");
                        lblNoItems.Text = tb.Rows.Count.ToString("n0");
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                loadsummary();
            }
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            loadsummary();
        }
    }
}