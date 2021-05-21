using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.Production.FrameSchedule
{
    public partial class CalendarFrame : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    loaddata();
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private void loaddata()
        {
            DateTime D = Convert.ToDateTime(ddlmonth.SelectedValue.ToString() + "-01-" + tboxyear.Text);
            DateTime sdate = GetMonday(D);
            loadCalendarData(sdate.ToString());
        }
        public static DateTime GetMonday(DateTime time)
        {
            if (time.DayOfWeek != DayOfWeek.Monday)
                return time.Subtract(new TimeSpan((int)time.DayOfWeek - 1, 0, 0, 0));

            return time;
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
        private void loadCalendarData(string d)
        {
            DataTable tb = new DataTable();
            getdata(d, tb);
            getdata(Convert.ToDateTime(d).AddDays(7).ToString(), tb);
            getdata(Convert.ToDateTime(d).AddDays(14).ToString(), tb);
            getdata(Convert.ToDateTime(d).AddDays(21).ToString(), tb);
            getdata(Convert.ToDateTime(d).AddDays(27).ToString(), tb);
            getdata(Convert.ToDateTime(d).AddDays(35).ToString(), tb);
            GridView1.DataSource = tb;
            GridView1.DataBind();
        }
        private void getdata(string d, DataTable tb)
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {

                        sqlcon.Open();
                        sqlcmd.CommandText = "Framewebcalendar";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "calendar");
                        sqlcmd.Parameters.AddWithValue("@d", d);
                        sqlcmd.Parameters.AddWithValue("@calfab", CheckBox1.Checked.ToString());
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
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
            loaddata();
        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
            Label lbl1date = (Label)GridView1.Rows[0].Cells[0].FindControl("lbl1date");
            Label lbl2date = (Label)GridView1.Rows[0].Cells[0].FindControl("lbl2date");
            Label lbl3date = (Label)GridView1.Rows[0].Cells[0].FindControl("lbl3date");
            Label lbl4date = (Label)GridView1.Rows[0].Cells[0].FindControl("lbl4date");
            Label lbl5date = (Label)GridView1.Rows[0].Cells[0].FindControl("lbl5date");
            Label lbl6date = (Label)GridView1.Rows[0].Cells[0].FindControl("lbl6date");
            Label lbl7date = (Label)GridView1.Rows[0].Cells[0].FindControl("lbl7date");
            if (!lbl1date.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[0].Cells[0].BackColor = Color.WhiteSmoke;
                GridView1.Rows[1].Cells[0].BackColor = Color.WhiteSmoke;
                GridView1.Rows[2].Cells[0].BackColor = Color.WhiteSmoke;
                //(Label)GridView1.Rows[0].Cells[0].FindControl("lbl7date");
            }
            if (!lbl2date.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[0].Cells[1].BackColor = Color.WhiteSmoke;
                GridView1.Rows[1].Cells[1].BackColor = Color.WhiteSmoke;
                GridView1.Rows[2].Cells[1].BackColor = Color.WhiteSmoke;
            }
            if (!lbl3date.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[0].Cells[2].BackColor = Color.WhiteSmoke;
                GridView1.Rows[1].Cells[2].BackColor = Color.WhiteSmoke;
                GridView1.Rows[2].Cells[2].BackColor = Color.WhiteSmoke;
            }
            if (!lbl4date.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[0].Cells[3].BackColor = Color.WhiteSmoke;
                GridView1.Rows[1].Cells[3].BackColor = Color.WhiteSmoke;
                GridView1.Rows[2].Cells[3].BackColor = Color.WhiteSmoke;
            }
            if (!lbl5date.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[0].Cells[4].BackColor = Color.WhiteSmoke;
                GridView1.Rows[1].Cells[4].BackColor = Color.WhiteSmoke;
                GridView1.Rows[2].Cells[4].BackColor = Color.WhiteSmoke;
            }
            if (!lbl6date.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[0].Cells[5].BackColor = Color.WhiteSmoke;
                GridView1.Rows[1].Cells[5].BackColor = Color.WhiteSmoke;
                GridView1.Rows[2].Cells[5].BackColor = Color.WhiteSmoke;
            }
            if (!lbl7date.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[0].Cells[6].BackColor = Color.WhiteSmoke;
                GridView1.Rows[1].Cells[6].BackColor = Color.WhiteSmoke;
                GridView1.Rows[2].Cells[6].BackColor = Color.WhiteSmoke;
            }


            Label lbl1date2LastRow = (Label)GridView1.Rows[12].Cells[0].FindControl("lbl1date");
            Label lbl2date2LastRow = (Label)GridView1.Rows[12].Cells[0].FindControl("lbl2date");
            Label lbl3date2LastRow = (Label)GridView1.Rows[12].Cells[0].FindControl("lbl3date");
            Label lbl4date2LastRow = (Label)GridView1.Rows[12].Cells[0].FindControl("lbl4date");
            Label lbl5date2LastRow = (Label)GridView1.Rows[12].Cells[0].FindControl("lbl5date");
            Label lbl6date2LastRow = (Label)GridView1.Rows[12].Cells[0].FindControl("lbl6date");
            Label lbl7date2LastRow = (Label)GridView1.Rows[12].Cells[0].FindControl("lbl7date");
            if (!lbl1date2LastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[12].Cells[0].BackColor = Color.WhiteSmoke;
                GridView1.Rows[13].Cells[0].BackColor = Color.WhiteSmoke;
                GridView1.Rows[14].Cells[0].BackColor = Color.WhiteSmoke;
            }
            if (!lbl2date2LastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[12].Cells[1].BackColor = Color.WhiteSmoke;
                GridView1.Rows[13].Cells[1].BackColor = Color.WhiteSmoke;
                GridView1.Rows[14].Cells[1].BackColor = Color.WhiteSmoke;
            }
            if (!lbl3date2LastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[12].Cells[2].BackColor = Color.WhiteSmoke;
                GridView1.Rows[13].Cells[2].BackColor = Color.WhiteSmoke;
                GridView1.Rows[14].Cells[2].BackColor = Color.WhiteSmoke;
            }
            if (!lbl4date2LastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[12].Cells[3].BackColor = Color.WhiteSmoke;
                GridView1.Rows[13].Cells[3].BackColor = Color.WhiteSmoke;
                GridView1.Rows[14].Cells[3].BackColor = Color.WhiteSmoke;
            }
            if (!lbl5date2LastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[12].Cells[4].BackColor = Color.WhiteSmoke;
                GridView1.Rows[13].Cells[4].BackColor = Color.WhiteSmoke;
                GridView1.Rows[14].Cells[4].BackColor = Color.WhiteSmoke;
            }
            if (!lbl6date2LastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[12].Cells[5].BackColor = Color.WhiteSmoke;
                GridView1.Rows[13].Cells[5].BackColor = Color.WhiteSmoke;
                GridView1.Rows[14].Cells[5].BackColor = Color.WhiteSmoke;
            }
            if (!lbl7date2LastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[12].Cells[6].BackColor = Color.WhiteSmoke;
                GridView1.Rows[13].Cells[6].BackColor = Color.WhiteSmoke;
                GridView1.Rows[14].Cells[6].BackColor = Color.WhiteSmoke;
            }


            Label lbl1dateLastRow = (Label)GridView1.Rows[15].Cells[0].FindControl("lbl1date");
            Label lbl2dateLastRow = (Label)GridView1.Rows[15].Cells[0].FindControl("lbl2date");
            Label lbl3dateLastRow = (Label)GridView1.Rows[15].Cells[0].FindControl("lbl3date");
            Label lbl4dateLastRow = (Label)GridView1.Rows[15].Cells[0].FindControl("lbl4date");
            Label lbl5dateLastRow = (Label)GridView1.Rows[15].Cells[0].FindControl("lbl5date");
            Label lbl6dateLastRow = (Label)GridView1.Rows[15].Cells[0].FindControl("lbl6date");
            Label lbl7dateLastRow = (Label)GridView1.Rows[15].Cells[0].FindControl("lbl7date");
            if (!lbl1dateLastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[15].Cells[0].BackColor = Color.WhiteSmoke;
                GridView1.Rows[16].Cells[0].BackColor = Color.WhiteSmoke;
                GridView1.Rows[17].Cells[0].BackColor = Color.WhiteSmoke;
            }
            if (!lbl2dateLastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[15].Cells[1].BackColor = Color.WhiteSmoke;
                GridView1.Rows[16].Cells[1].BackColor = Color.WhiteSmoke;
                GridView1.Rows[17].Cells[1].BackColor = Color.WhiteSmoke;
            }
            if (!lbl3dateLastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[15].Cells[2].BackColor = Color.WhiteSmoke;
                GridView1.Rows[16].Cells[2].BackColor = Color.WhiteSmoke;
                GridView1.Rows[17].Cells[2].BackColor = Color.WhiteSmoke;
            }
            if (!lbl4dateLastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[15].Cells[3].BackColor = Color.WhiteSmoke;
                GridView1.Rows[16].Cells[3].BackColor = Color.WhiteSmoke;
                GridView1.Rows[17].Cells[3].BackColor = Color.WhiteSmoke;
            }
            if (!lbl5dateLastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[15].Cells[4].BackColor = Color.WhiteSmoke;
                GridView1.Rows[16].Cells[4].BackColor = Color.WhiteSmoke;
                GridView1.Rows[17].Cells[4].BackColor = Color.WhiteSmoke;
            }
            if (!lbl6dateLastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[15].Cells[5].BackColor = Color.WhiteSmoke;
                GridView1.Rows[16].Cells[5].BackColor = Color.WhiteSmoke;
                GridView1.Rows[17].Cells[5].BackColor = Color.WhiteSmoke;
            }
            if (!lbl7dateLastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[15].Cells[6].BackColor = Color.WhiteSmoke;
                GridView1.Rows[16].Cells[6].BackColor = Color.WhiteSmoke;
                GridView1.Rows[17].Cells[6].BackColor = Color.WhiteSmoke;
            }
            //for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
            //{


            //}
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "viewlistMonday")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                getlist(((Label)row.FindControl("lbl1date")).Text);
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }
        }
        private void getlist(string caldate)
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {

                        sqlcon.Open();
                        sqlcmd.CommandText = "Framewebcalendar";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "items");
                        sqlcmd.Parameters.AddWithValue("@calfab", CheckBox1.Checked.ToString());
                        sqlcmd.Parameters.AddWithValue("@date", caldate);
                        GridView2.DataSource = sqlcmd.ExecuteReader();
                        GridView2.DataBind();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
    }
}