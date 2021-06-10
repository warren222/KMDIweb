using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.Production.FrameSchedule
{
    public partial class CalendarFrameNewDueDate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    ddlmonth.SelectedValue = DateTime.Now.ToString("MM");
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
            lblMonth.Text = D.ToString("MMMM");
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
                        sqlcmd.CommandText = "FramewebcalendarNewDueDate";
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
                        sqlcmd.CommandText = "FramewebcalendarNewDueDate";
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
            FirstRowDynamicBackColor();
            FifthRowDynamicBackColor();
            SixthRowDynamicBackColor();
            formatLink();
            showHoliday();
            pointsMaximum();
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
        }
        private void FifthRowDynamicBackColor()
        {
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
        }
        private void SixthRowDynamicBackColor()
        {
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
        }
        private void formatLink()
        {
            for (int i = 0; i <= 17; i += 3)
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
                for (int x = 0; x <= 17; x += 3)
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
            for (int x = 1; x <= 17; x += 3)
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
                        sqlcmd.CommandText = "FramewebcalendarNewDueDate";
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