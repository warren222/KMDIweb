using KMDIweb.KMDIweb.Global.objects;
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
                    ddlmonth.SelectedValue = DateTime.Now.ToString("MM");
                    loadae();
                    loaddata();
                    if (Session["KMDI_ffm_acct"].ToString() == "Guest")
                    {
                        Panel3.Visible = false;
                    }
                    else
                    {
                        Panel3.Visible = true;
                    }
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
            lblMonth.Text = D.ToString("MMMM");
            lblMonth2.Text = D.ToString("MMMM");
            loadCalendarData(sdate.ToString());
        }
        public static DateTime GetMonday(DateTime time)
        {
            if (time.DayOfWeek != DayOfWeek.Monday)
                return time.Subtract(new TimeSpan((int)time.DayOfWeek - 1, 0, 0, 0));

            return time;
        }

        private List<string> loadholidays()
        {
            List<string> holidays = new List<string>();
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Framewebcalendar";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "holidays");
                        sqlcmd.Parameters.AddWithValue("@yr", tboxyear.Text);
                        sqlcmd.Parameters.AddWithValue("@month", ddlmonth.SelectedValue.ToString());
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                holidays.Add(rd[0].ToString());
                            }
                        }
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
            return holidays;
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
            getdata(Convert.ToDateTime(d).AddDays(28).ToString(), tb);
            getdata(Convert.ToDateTime(d).AddDays(35).ToString(), tb);
            GridView1.DataSource = tb;
            GridView1.DataBind();
            projectsummary();
            getMonthCapacity(d);
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
                        sqlcmd.Parameters.AddWithValue("@ae", ddlae.Text);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                    finally
                    {

                    }
                }
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
                        sqlcmd.CommandText = "Framewebcalendar";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "loadae");
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
        private void getMonthCapacity(string d)
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "FramewebcalendarStatistics";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "ProductionRate");
                        sqlcmd.Parameters.AddWithValue("@d", d);
                        GridView6.DataSource = sqlcmd.ExecuteReader();
                        GridView6.DataBind();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
      
        private void projectsummary()
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
                        sqlcmd.Parameters.AddWithValue("@command", "project");
                        sqlcmd.Parameters.AddWithValue("@calfab", CheckBox1.Checked.ToString());
                        sqlcmd.Parameters.AddWithValue("@yr", tboxyear.Text);
                        sqlcmd.Parameters.AddWithValue("@month", ddlmonth.SelectedValue.ToString());
                        sqlcmd.Parameters.AddWithValue("@ae", ddlae.Text);
                        GridView3.DataSource = sqlcmd.ExecuteReader();
                        GridView3.DataBind();
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
            FirstRowDynamicBackColor();
            FifthRowDynamicBackColor();
            SixthRowDynamicBackColor();
            formatLink();
            showHoliday();
            pointsMaximum();
            if (Session["KMDI_ffm_acct"].ToString() == "Guest")
            {
                for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
                {
                    GridViewRow row = GridView1.Rows[i];
                    ((Label)row.FindControl("lbl1points")).Visible = false;
                    ((Label)row.FindControl("lbl2points")).Visible = false;
                    ((Label)row.FindControl("lbl3points")).Visible = false;
                    ((Label)row.FindControl("lbl4points")).Visible = false;
                    ((Label)row.FindControl("lbl5points")).Visible = false;
                    ((Label)row.FindControl("lbl6points")).Visible = false;
                    ((Label)row.FindControl("lbl7points")).Visible = false;
                    ((Label)row.FindControl("lbl8points")).Visible = false;

                    ((Label)row.FindControl("lbl1specialpoints")).Visible = false;
                    ((Label)row.FindControl("lbl2specialpoints")).Visible = false;
                    ((Label)row.FindControl("lbl3specialpoints")).Visible = false;
                    ((Label)row.FindControl("lbl4specialpoints")).Visible = false;
                    ((Label)row.FindControl("lbl5specialpoints")).Visible = false;
                    ((Label)row.FindControl("lbl6specialpoints")).Visible = false;
                    ((Label)row.FindControl("lbl7specialpoints")).Visible = false;
                    ((Label)row.FindControl("lbl8specialpoints")).Visible = false;
                }
            }

        }
        private void FirstRowDynamicBackColor()
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
                GridView1.Rows[3].Cells[0].BackColor = Color.WhiteSmoke;
                //(Label)GridView1.Rows[0].Cells[0].FindControl("lbl7date");
            }
            if (!lbl2date.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[0].Cells[1].BackColor = Color.WhiteSmoke;
                GridView1.Rows[1].Cells[1].BackColor = Color.WhiteSmoke;
                GridView1.Rows[2].Cells[1].BackColor = Color.WhiteSmoke;
                GridView1.Rows[3].Cells[1].BackColor = Color.WhiteSmoke;
            }
            if (!lbl3date.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[0].Cells[2].BackColor = Color.WhiteSmoke;
                GridView1.Rows[1].Cells[2].BackColor = Color.WhiteSmoke;
                GridView1.Rows[2].Cells[2].BackColor = Color.WhiteSmoke;
                GridView1.Rows[3].Cells[2].BackColor = Color.WhiteSmoke;
            }
            if (!lbl4date.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[0].Cells[3].BackColor = Color.WhiteSmoke;
                GridView1.Rows[1].Cells[3].BackColor = Color.WhiteSmoke;
                GridView1.Rows[2].Cells[3].BackColor = Color.WhiteSmoke;
                GridView1.Rows[3].Cells[3].BackColor = Color.WhiteSmoke;
            }
            if (!lbl5date.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[0].Cells[4].BackColor = Color.WhiteSmoke;
                GridView1.Rows[1].Cells[4].BackColor = Color.WhiteSmoke;
                GridView1.Rows[2].Cells[4].BackColor = Color.WhiteSmoke;
                GridView1.Rows[4].Cells[4].BackColor = Color.WhiteSmoke;
            }
            if (!lbl6date.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[0].Cells[5].BackColor = Color.WhiteSmoke;
                GridView1.Rows[1].Cells[5].BackColor = Color.WhiteSmoke;
                GridView1.Rows[2].Cells[5].BackColor = Color.WhiteSmoke;
                GridView1.Rows[3].Cells[5].BackColor = Color.WhiteSmoke;
            }
            if (!lbl7date.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[0].Cells[6].BackColor = Color.WhiteSmoke;
                GridView1.Rows[1].Cells[6].BackColor = Color.WhiteSmoke;
                GridView1.Rows[2].Cells[6].BackColor = Color.WhiteSmoke;
                GridView1.Rows[3].Cells[6].BackColor = Color.WhiteSmoke;
            }
        }
        private void FifthRowDynamicBackColor()
        {
            Label lbl1date2LastRow = (Label)GridView1.Rows[16].Cells[0].FindControl("lbl1date");
            Label lbl2date2LastRow = (Label)GridView1.Rows[16].Cells[0].FindControl("lbl2date");
            Label lbl3date2LastRow = (Label)GridView1.Rows[16].Cells[0].FindControl("lbl3date");
            Label lbl4date2LastRow = (Label)GridView1.Rows[16].Cells[0].FindControl("lbl4date");
            Label lbl5date2LastRow = (Label)GridView1.Rows[16].Cells[0].FindControl("lbl5date");
            Label lbl6date2LastRow = (Label)GridView1.Rows[16].Cells[0].FindControl("lbl6date");
            Label lbl7date2LastRow = (Label)GridView1.Rows[16].Cells[0].FindControl("lbl7date");
            if (!lbl1date2LastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[16].Cells[0].BackColor = Color.WhiteSmoke;
                GridView1.Rows[17].Cells[0].BackColor = Color.WhiteSmoke;
                GridView1.Rows[18].Cells[0].BackColor = Color.WhiteSmoke;
                GridView1.Rows[19].Cells[0].BackColor = Color.WhiteSmoke;
            }
            if (!lbl2date2LastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[16].Cells[1].BackColor = Color.WhiteSmoke;
                GridView1.Rows[17].Cells[1].BackColor = Color.WhiteSmoke;
                GridView1.Rows[18].Cells[1].BackColor = Color.WhiteSmoke;
                GridView1.Rows[19].Cells[1].BackColor = Color.WhiteSmoke;
            }
            if (!lbl3date2LastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[16].Cells[2].BackColor = Color.WhiteSmoke;
                GridView1.Rows[17].Cells[2].BackColor = Color.WhiteSmoke;
                GridView1.Rows[18].Cells[2].BackColor = Color.WhiteSmoke;
                GridView1.Rows[19].Cells[2].BackColor = Color.WhiteSmoke;
            }
            if (!lbl4date2LastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[16].Cells[3].BackColor = Color.WhiteSmoke;
                GridView1.Rows[17].Cells[3].BackColor = Color.WhiteSmoke;
                GridView1.Rows[18].Cells[3].BackColor = Color.WhiteSmoke;
                GridView1.Rows[19].Cells[3].BackColor = Color.WhiteSmoke;
            }
            if (!lbl5date2LastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[16].Cells[4].BackColor = Color.WhiteSmoke;
                GridView1.Rows[17].Cells[4].BackColor = Color.WhiteSmoke;
                GridView1.Rows[18].Cells[4].BackColor = Color.WhiteSmoke;
                GridView1.Rows[19].Cells[4].BackColor = Color.WhiteSmoke;
            }
            if (!lbl6date2LastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[16].Cells[5].BackColor = Color.WhiteSmoke;
                GridView1.Rows[17].Cells[5].BackColor = Color.WhiteSmoke;
                GridView1.Rows[18].Cells[5].BackColor = Color.WhiteSmoke;
                GridView1.Rows[19].Cells[5].BackColor = Color.WhiteSmoke;
            }
            if (!lbl7date2LastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[16].Cells[6].BackColor = Color.WhiteSmoke;
                GridView1.Rows[17].Cells[6].BackColor = Color.WhiteSmoke;
                GridView1.Rows[18].Cells[6].BackColor = Color.WhiteSmoke;
                GridView1.Rows[19].Cells[6].BackColor = Color.WhiteSmoke;
            }
        }
        private void SixthRowDynamicBackColor()
        {
            Label lbl1dateLastRow = (Label)GridView1.Rows[20].Cells[0].FindControl("lbl1date");
            Label lbl2dateLastRow = (Label)GridView1.Rows[20].Cells[0].FindControl("lbl2date");
            Label lbl3dateLastRow = (Label)GridView1.Rows[20].Cells[0].FindControl("lbl3date");
            Label lbl4dateLastRow = (Label)GridView1.Rows[20].Cells[0].FindControl("lbl4date");
            Label lbl5dateLastRow = (Label)GridView1.Rows[20].Cells[0].FindControl("lbl5date");
            Label lbl6dateLastRow = (Label)GridView1.Rows[20].Cells[0].FindControl("lbl6date");
            Label lbl7dateLastRow = (Label)GridView1.Rows[20].Cells[0].FindControl("lbl7date");
            if (!lbl1dateLastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[20].Cells[0].BackColor = Color.WhiteSmoke;
                GridView1.Rows[21].Cells[0].BackColor = Color.WhiteSmoke;
                GridView1.Rows[22].Cells[0].BackColor = Color.WhiteSmoke;
                GridView1.Rows[23].Cells[0].BackColor = Color.WhiteSmoke;
            }
            if (!lbl2dateLastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[20].Cells[1].BackColor = Color.WhiteSmoke;
                GridView1.Rows[21].Cells[1].BackColor = Color.WhiteSmoke;
                GridView1.Rows[22].Cells[1].BackColor = Color.WhiteSmoke;
                GridView1.Rows[23].Cells[1].BackColor = Color.WhiteSmoke;
            }
            if (!lbl3dateLastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[20].Cells[2].BackColor = Color.WhiteSmoke;
                GridView1.Rows[21].Cells[2].BackColor = Color.WhiteSmoke;
                GridView1.Rows[22].Cells[2].BackColor = Color.WhiteSmoke;
                GridView1.Rows[23].Cells[2].BackColor = Color.WhiteSmoke;
            }
            if (!lbl4dateLastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[20].Cells[3].BackColor = Color.WhiteSmoke;
                GridView1.Rows[21].Cells[3].BackColor = Color.WhiteSmoke;
                GridView1.Rows[22].Cells[3].BackColor = Color.WhiteSmoke;
                GridView1.Rows[23].Cells[3].BackColor = Color.WhiteSmoke;
            }
            if (!lbl5dateLastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[20].Cells[4].BackColor = Color.WhiteSmoke;
                GridView1.Rows[21].Cells[4].BackColor = Color.WhiteSmoke;
                GridView1.Rows[22].Cells[4].BackColor = Color.WhiteSmoke;
                GridView1.Rows[23].Cells[4].BackColor = Color.WhiteSmoke;
            }
            if (!lbl6dateLastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[20].Cells[5].BackColor = Color.WhiteSmoke;
                GridView1.Rows[21].Cells[5].BackColor = Color.WhiteSmoke;
                GridView1.Rows[22].Cells[5].BackColor = Color.WhiteSmoke;
                GridView1.Rows[23].Cells[5].BackColor = Color.WhiteSmoke;
            }
            if (!lbl7dateLastRow.Text.Contains(ddlmonth.SelectedItem.ToString()))
            {
                GridView1.Rows[20].Cells[6].BackColor = Color.WhiteSmoke;
                GridView1.Rows[21].Cells[6].BackColor = Color.WhiteSmoke;
                GridView1.Rows[22].Cells[6].BackColor = Color.WhiteSmoke;
                GridView1.Rows[23].Cells[6].BackColor = Color.WhiteSmoke;
            }
        }
        private void formatLink()
        {
            for (int i = 0; i <= 23; i += 4)
            {
                ((LinkButton)GridView1.Rows[i].Cells[0].FindControl("linkbtnMon")).Text = Convert.ToDateTime(((LinkButton)GridView1.Rows[i].Cells[0].FindControl("linkbtnMon")).Text).ToString("MMM-dd");
                ((LinkButton)GridView1.Rows[i].Cells[1].FindControl("linkbtnTue")).Text = Convert.ToDateTime(((LinkButton)GridView1.Rows[i].Cells[1].FindControl("linkbtnTue")).Text).ToString("MMM-dd");
                ((LinkButton)GridView1.Rows[i].Cells[2].FindControl("linkbtnWed")).Text = Convert.ToDateTime(((LinkButton)GridView1.Rows[i].Cells[2].FindControl("linkbtnWed")).Text).ToString("MMM-dd");
                ((LinkButton)GridView1.Rows[i].Cells[3].FindControl("linkbtnThu")).Text = Convert.ToDateTime(((LinkButton)GridView1.Rows[i].Cells[3].FindControl("linkbtnThu")).Text).ToString("MMM-dd");
                ((LinkButton)GridView1.Rows[i].Cells[4].FindControl("linkbtnFri")).Text = Convert.ToDateTime(((LinkButton)GridView1.Rows[i].Cells[4].FindControl("linkbtnFri")).Text).ToString("MMM-dd");
                ((LinkButton)GridView1.Rows[i].Cells[5].FindControl("linkbtnSat")).Text = Convert.ToDateTime(((LinkButton)GridView1.Rows[i].Cells[5].FindControl("linkbtnSat")).Text).ToString("MMM-dd");
                ((LinkButton)GridView1.Rows[i].Cells[6].FindControl("linkbtnSun")).Text = Convert.ToDateTime(((LinkButton)GridView1.Rows[i].Cells[6].FindControl("linkbtnSun")).Text).ToString("MMM-dd");
            }
        }
        private void showHoliday()
        {
            List<string> holidays = new List<string>();
            holidays = loadholidays();
            for (int i = 0; i <= holidays.Count - 1; i++)
            {
                for (int x = 0; x <= 23; x += 4)
                {
                    if (((LinkButton)GridView1.Rows[x].Cells[0].FindControl("linkbtnMon")).Text == holidays[i].ToString())
                    {
                        ((LinkButton)GridView1.Rows[x].Cells[0].FindControl("linkbtnMon")).ForeColor = Color.Red;
                    }
                    if (((LinkButton)GridView1.Rows[x].Cells[1].FindControl("linkbtnTue")).Text == holidays[i].ToString())
                    {
                        ((LinkButton)GridView1.Rows[x].Cells[1].FindControl("linkbtnTue")).ForeColor = Color.Red;
                    }
                    if (((LinkButton)GridView1.Rows[x].Cells[2].FindControl("linkbtnWed")).Text == holidays[i].ToString())
                    {
                        ((LinkButton)GridView1.Rows[x].Cells[2].FindControl("linkbtnWed")).ForeColor = Color.Red;
                    }
                    if (((LinkButton)GridView1.Rows[x].Cells[3].FindControl("linkbtnThu")).Text == holidays[i].ToString())
                    {
                        ((LinkButton)GridView1.Rows[x].Cells[3].FindControl("linkbtnThu")).ForeColor = Color.Red;
                    }
                    if (((LinkButton)GridView1.Rows[x].Cells[4].FindControl("linkbtnFri")).Text == holidays[i].ToString())
                    {
                        ((LinkButton)GridView1.Rows[x].Cells[4].FindControl("linkbtnFri")).ForeColor = Color.Red;
                    }
                    if (((LinkButton)GridView1.Rows[x].Cells[5].FindControl("linkbtnSat")).Text == holidays[i].ToString())
                    {
                        ((LinkButton)GridView1.Rows[x].Cells[5].FindControl("linkbtnSat")).ForeColor = Color.Red;
                    }
                    if (((LinkButton)GridView1.Rows[x].Cells[6].FindControl("linkbtnSun")).Text == holidays[i].ToString())
                    {
                        ((LinkButton)GridView1.Rows[x].Cells[6].FindControl("linkbtnSun")).ForeColor = Color.Red;
                    }
                }
            }
        }
        private void pointsMaximum()
        {
            for (int x = 1; x <= 23; x += 4)
            {
                if (Convert.ToInt32(((Label)GridView1.Rows[1].Cells[0].FindControl("lbl1points")).Text.ToString().Replace(",", "")) > 8000)
                {
                    ((Label)GridView1.Rows[1].Cells[0].FindControl("lbl1points")).ForeColor = Color.Red;
                }
                if (Convert.ToInt32(((Label)GridView1.Rows[x].Cells[1].FindControl("lbl2points")).Text.Replace(",", "")) > 8000)
                {
                    ((Label)GridView1.Rows[x].Cells[1].FindControl("lbl2points")).ForeColor = Color.Red;
                }
                if (Convert.ToInt32(((Label)GridView1.Rows[x].Cells[2].FindControl("lbl3points")).Text.Replace(",", "")) > 8000)
                {
                    ((Label)GridView1.Rows[x].Cells[2].FindControl("lbl3points")).ForeColor = Color.Red;
                }
                if (Convert.ToInt32(((Label)GridView1.Rows[x].Cells[3].FindControl("lbl4points")).Text.Replace(",", "")) > 8000)
                {
                    ((Label)GridView1.Rows[x].Cells[3].FindControl("lbl4points")).ForeColor = Color.Red;
                }
                if (Convert.ToInt32(((Label)GridView1.Rows[x].Cells[4].FindControl("lbl5points")).Text.Replace(",", "")) > 8000)
                {
                    ((Label)GridView1.Rows[x].Cells[4].FindControl("lbl5points")).ForeColor = Color.Red;
                }
                if (Convert.ToInt32(((Label)GridView1.Rows[x].Cells[5].FindControl("lbl6points")).Text.Replace(",", "")) > 8000)
                {
                    ((Label)GridView1.Rows[x].Cells[5].FindControl("lbl6points")).ForeColor = Color.Red;
                }
                if (Convert.ToInt32(((Label)GridView1.Rows[x].Cells[6].FindControl("lbl7points")).Text.Replace(",", "")) > 8000)
                {
                    ((Label)GridView1.Rows[x].Cells[6].FindControl("lbl7points")).ForeColor = Color.Red;
                }
            }
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string caldate;
            int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
            GridViewRow row = GridView1.Rows[rowindex];

            if (Session["KMDI_ffm_acct"].ToString() == "Admin")
            {
                if (e.CommandName == "viewlistMon")
                {
                    //OpenModal("lbl1date", "lbl1points", e);
                    caldate = ((Label)row.FindControl("lbl1date")).Text;
                    loadItems(caldate);
                }
                else if (e.CommandName == "viewlistTue")
                {
                    //OpenModal("lbl2date", "lbl2points", e);
                    caldate = ((Label)row.FindControl("lbl2date")).Text;
                    loadItems(caldate);
                }
                else if (e.CommandName == "viewlistWed")
                {
                    //OpenModal("lbl3date", "lbl3points", e);
                    caldate = ((Label)row.FindControl("lbl3date")).Text;
                    loadItems(caldate);
                }
                else if (e.CommandName == "viewlistThu")
                {
                    //OpenModal("lbl4date", "lbl4points", e);
                    caldate = ((Label)row.FindControl("lbl4date")).Text;
                    loadItems(caldate);
                }
                else if (e.CommandName == "viewlistFri")
                {
                    //OpenModal("lbl5date", "lbl5points", e);
                    caldate = ((Label)row.FindControl("lbl5date")).Text;
                    loadItems(caldate);
                }
                else if (e.CommandName == "viewlistSat")
                {
                    //OpenModal("lbl6date", "lbl6points", e);
                    caldate = ((Label)row.FindControl("lbl6date")).Text;
                    loadItems(caldate);
                }
                else if (e.CommandName == "viewlistSun")
                {
                    //OpenModal("lbl7date", "lbl7points", e);
                    caldate = ((Label)row.FindControl("lbl7date")).Text;
                    loadItems(caldate);
                }
            }
            else
            {
                if (e.CommandName == "viewlistMon")
                {
                    OpenModal("lbl1date", "lbl1points", e);

                }
                else if (e.CommandName == "viewlistTue")
                {
                    OpenModal("lbl2date", "lbl2points", e);

                }
                else if (e.CommandName == "viewlistWed")
                {
                    OpenModal("lbl3date", "lbl3points", e);

                }
                else if (e.CommandName == "viewlistThu")
                {
                    OpenModal("lbl4date", "lbl4points", e);

                }
                else if (e.CommandName == "viewlistFri")
                {
                    OpenModal("lbl5date", "lbl5points", e);

                }
                else if (e.CommandName == "viewlistSat")
                {
                    OpenModal("lbl6date", "lbl6points", e);

                }
                else if (e.CommandName == "viewlistSun")
                {
                    OpenModal("lbl7date", "lbl7points", e);

                }
            }

        }
        private void loadItems(string caldate)
        {
            Panel2.Visible = true;
            Panel1.Visible = false;

            ViewState["caldate"] = caldate;
            lblselecteddate.Text = caldate;
            loadCLlist(caldate);
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        DataTable tb = new DataTable();
                        sqlcon.Open();
                        sqlcmd.CommandText = "Framewebcalendar";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "items");
                        sqlcmd.Parameters.AddWithValue("@calfab", CheckBox1.Checked.ToString());
                        sqlcmd.Parameters.AddWithValue("@date", caldate);
                        sqlcmd.Parameters.AddWithValue("@ae", ddlae.Text);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView4.DataSource = tb;
                        GridView4.DataBind();
                        ViewState["tb"] = tb;
                    }
                    catch (Exception ex)
                    {
                        errorrmessage(ex.Message);
                    }
                    finally
                    {
                        loadScreenItems(caldate);
                    }
                }

            }
        }
        private void loadScreenItems(string caldate)
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        DataTable tb = new DataTable();
                        sqlcon.Open();
                        sqlcmd.CommandText = "Framewebcalendar";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "screen_items");
                        sqlcmd.Parameters.AddWithValue("@calfab", CheckBox1.Checked.ToString());
                        sqlcmd.Parameters.AddWithValue("@date", caldate);
                        sqlcmd.Parameters.AddWithValue("@ae", ddlae.Text);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView5.DataSource = tb;
                        GridView5.DataBind();

                    }
                    catch (Exception ex)
                    {
                        errorrmessage(ex.Message);
                    }
                }

            }
        }
        private void loadCLlist(string caldate)
        {

            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        DataTable tb = new DataTable();
                        sqlcon.Open();
                        sqlcmd.CommandText = "Framewebcalendar";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "cllist");
                        sqlcmd.Parameters.AddWithValue("@calfab", CheckBox1.Checked.ToString());
                        sqlcmd.Parameters.AddWithValue("@date", caldate);
                        sqlcmd.Parameters.AddWithValue("@ae", ddlae.Text);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        ddlClList.DataSource = tb;
                        ddlClList.DataValueField = "clno";
                        ddlClList.DataTextField = "clno";
                        ddlClList.DataBind();

                    }
                    catch (Exception ex)
                    {
                        errorrmessage(ex.Message);
                    }
                }

            }
        }
        private void OpenModal(string lbl, string lblpoints, GridViewCommandEventArgs e)
        {
            int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
            GridViewRow row = GridView1.Rows[rowindex];
            GridViewRow row2 = GridView1.Rows[rowindex + 1];
            getlist(((Label)row.FindControl(lbl)).Text);

            lblmodalHeader.Text = ((Label)row.FindControl(lbl)).Text;
            lblmodalTotalPoints.Text = ((Label)row2.FindControl(lblpoints)).Text;
            lblmodalTotalQty.Text = GridView2.Rows.Count.ToString();

            ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
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
                        sqlcmd.Parameters.AddWithValue("@ae", ddlae.Text);
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

        protected void GridView3_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (Session["KMDI_ffm_acct"].ToString() == "Guest")
            {
                for (int i = 0; i <= GridView3.Rows.Count - 1; i++)
                {
                    GridView3.Columns[1].Visible = false;
                }
            }
        }
        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (Session["KMDI_ffm_acct"].ToString() == "Guest")
            {
                for (int i = 0; i <= GridView2.Rows.Count - 1; i++)
                {
                    GridView2.Columns[2].Visible = false;
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                List<int> l = new List<int>();
                if ((List<int>)ViewState["listid"] == null)
                {
                    l.Add(0);
                }
                else
                {
                    l = ViewState["listid"] as List<int>;
                }
                foreach (GridViewRow row in GridView4.Rows)
                {
                    CheckBox cbk = (CheckBox)row.FindControl("cboxSelectitem");
                    if (cbk.Checked == true)
                    {
                        int x = int.Parse(((Label)row.FindControl("g4Id")).Text.ToString());
                        if (!l.Contains(x))
                        {
                            l.Add(x);
                        }
                    }
                    else
                    {
                        int x = int.Parse(((Label)row.FindControl("g4Id")).Text.ToString());
                        if (l.Contains(x))
                        {
                            l.Remove(x);
                        }
                    }
                }
                List<kmdino> knoList = new List<kmdino>();
                knoList = listKno(l);


                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {

                        try
                        {
                            sqlcon.Open();
                            foreach (var item in knoList)
                            {
                                sqlcmd.CommandText = "Framewebcalendar";
                                sqlcmd.CommandType = CommandType.StoredProcedure;
                                sqlcmd.Parameters.AddWithValue("@command", "update_by_check");
                                sqlcmd.Parameters.AddWithValue("@jo", item.jo);
                                sqlcmd.Parameters.AddWithValue("@kno", item.kmdi_no);
                                sqlcmd.Parameters.AddWithValue("@NewDueDate", tboxitemNewDueDate.Text);
                                sqlcmd.ExecuteNonQuery();
                            }
                        }
                        catch (Exception ex)
                        {
                            errorrmessage(ex.Message);
                        }
                        finally
                        {
                            loadItems(ViewState["caldate"].ToString());
                        }
                    }
                }
            }

        }
        private DataTable mytb
        {
            get
            {
                return (DataTable)ViewState["tb"];
            }
        }
        private List<kmdino> listKno(List<int> l)
        {
            List<kmdino> knoList = new List<kmdino>();
            try
            {
                for (int i = 0; i <= mytb.Rows.Count - 1; i++)
                {
                    int id = Convert.ToInt32(mytb.Rows[i]["id"].ToString());
                    if (l.Contains(id))
                    {

                        kmdino k = new kmdino();

                        k.kmdi_no = mytb.Rows[i]["kmdi_no"].ToString();
                        k.jo = mytb.Rows[i]["job_order_no"].ToString();
                        knoList.Add(k);
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            return knoList;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (IsValid)
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
                            sqlcmd.Parameters.AddWithValue("@command", "update_by_clno");
                            sqlcmd.Parameters.AddWithValue("@clno", ddlClList.Text);
                            sqlcmd.Parameters.AddWithValue("@NewDueDate", tboxitemNewDueDate2.Text);
                            sqlcmd.ExecuteNonQuery();
                        }
                        catch (Exception ex)
                        {
                            errorrmessage(ex.Message);
                        }
                        finally
                        {
                            loadItems(ViewState["caldate"].ToString());
                        }
                    }
                }
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Panel2.Visible = false;
            Panel1.Visible = true;
        }
    }
}