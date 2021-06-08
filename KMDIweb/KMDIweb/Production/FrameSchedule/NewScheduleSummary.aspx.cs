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
    public partial class NewScheduleSummary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    loadae();
                    loaddata();
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private void loadae()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "new_schedule_summary_stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "loadae");
                        sqlcmd.Parameters.AddWithValue("@SearchKey", tboxproject.Text);
                        sqlcmd.Parameters.AddWithValue("@date", tboxdate.Text);
                        sqlcmd.Parameters.AddWithValue("@ae", ddlae.Text);
                        ddlae.DataSource = sqlcmd.ExecuteReader();
                        ddlae.DataTextField = "fullname";
                        ddlae.DataValueField = "fullname";
                        ddlae.DataBind();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        private void loaddata()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        tboxproject.Text = tboxproject.Text.Replace("'", "`");
                        tboxproject.Text = tboxproject.Text.Replace("\"", "``");
                        sqlcon.Open();
                        sqlcmd.CommandText = "new_schedule_summary_stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "new");
                        sqlcmd.Parameters.AddWithValue("@SearchKey", tboxproject.Text);
                        sqlcmd.Parameters.AddWithValue("@date", tboxdate.Text);
                        sqlcmd.Parameters.AddWithValue("@ae", ddlae.Text);
                        DataTable tb = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
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

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            loaddata();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "viewlist")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["asof"] = ((Label)row.FindControl("lbldd")).Text;
                Response.Redirect("~/KMDIweb/Production/FrameSchedule/NewScheduleItems.aspx");

            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            loaddata();
        }
    }
}