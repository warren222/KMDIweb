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

namespace KMDIweb.KMDIweb.EngrItinerary
{
    public partial class Engr_Itinerary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    Get_Engr();
                    Get_Year_List();
                    RetriverQS();
                    if (user_code == "Engineer")
                    {
                        ddlEngr.SelectedValue =  nickname;
                        ddlEngr.Enabled = false;
                    }
                
                    Get_Data();
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private string user_code
        {
            get
            {
                return Session["KMDI_user_code"].ToString();
            }
        }
        private string nickname
        {
            get
            {
                return Session["KMDI_nickname"].ToString();
            }
        }
        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private void RetriverQS()
        {
            ddlEngr.SelectedValue = Request.QueryString["Engr"] != null ? Request.QueryString["Engr"].ToString() : "";
            ddlHasReport.SelectedValue = Request.QueryString["HasReport"] != null ? Request.QueryString["HasReport"].ToString() : "1";
            ddlMonth.SelectedValue = Request.QueryString["Month"] != null ? Request.QueryString["Month"].ToString() : ddlMonth.SelectedValue = DateTime.Now.ToString("MM");
            ddlYear.SelectedValue = Request.QueryString["Year"] != null ? Request.QueryString["Year"].ToString() : ddlYear.SelectedValue = DateTime.Now.ToString("yyyy");
        }
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "errorval";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Get_Data();
        }
        private void Get_Year_List()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Year_List_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            ddlYear.DataSource = tb;
                            ddlYear.DataTextField = "Yr";
                            ddlYear.DataValueField = "Yr";
                            ddlYear.DataBind();
                        }

                    }
                }

            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
        private void Get_Engr()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Engr_Itinerary_Calendar_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Nicknames");
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            ddlEngr.DataSource = tb;
                            ddlEngr.DataTextField = "Nickname";
                            ddlEngr.DataValueField = "Nickname_Val";
                            ddlEngr.DataBind();
                        }

                    }
                }

            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
        private void Get_Data()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        string dt = ddlYear.SelectedValue.ToString() + "-" + ddlMonth.SelectedValue.ToString() + "-01";
                        sqlcmd.CommandText = "Engr_Itinerary_Calendar_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Calendar");
                        sqlcmd.Parameters.AddWithValue("@Date", dt);
                        sqlcmd.Parameters.AddWithValue("@Engr", ddlEngr.SelectedValue.ToString());
                        sqlcmd.Parameters.AddWithValue("@HasReport", ddlHasReport.SelectedValue.ToString());
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvCalendar.DataSource = tb;
                            gvCalendar.DataBind();
                            lblSelectedMonth.Text = Convert.ToDateTime(dt).ToString("MMMM");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }

        protected void gvCalendar_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                for (int i = 0; i <= 6; i++)
                {
                    int nameIndex = i + 1;
                    int currentRowIndex = e.Row.RowIndex;


                    string linkbtn = "linkbtn" + nameIndex.ToString();
                    string lbldate = "lbl" + nameIndex.ToString() + "date";
                    string pnl = "pnl" + nameIndex.ToString();
                    string lblcontext = "lblContext";
                    string lblcontent = "lbl" + nameIndex.ToString() + "content";
                    string lblselectedmonth = "lblSelected_Month";

                    TableCell cell = e.Row.Cells[i];
                    string date = ((Label)cell.FindControl(lbldate)).Text;
                    string context = ((Label)cell.FindControl(lblcontext)).Text;
                    string selected_month = ((Label)cell.FindControl(lblselectedmonth)).Text;

                    bool validate = false;
                    if (context == "Date")
                    {
                        string converted = Convert.ToDateTime(date).ToString("MMM");
                        validate = converted != selected_month ? true : false;
                        if (!validate)
                        {
                            cell.CssClass = "wf_calendar_date";
                        }
                    }

                    if (context == "Content")
                    {
                        string converted = Convert.ToDateTime(((Label)gvCalendar.Rows[currentRowIndex - 1].Cells[i].FindControl(lbldate)).Text).ToString("MMM");
                        validate = converted != selected_month ? true : false;
                    }
                    if (context == "Date")
                    {
                        string converted = Convert.ToDateTime(date).ToString("MM-dd-yyyy");
                        if (converted == DateTime.Now.ToString("MM-dd-yyyy"))
                        {
                            cell.BorderColor = ColorTranslator.FromHtml("#ff006e");
                            cell.BorderStyle = BorderStyle.Dashed;
                            cell.BorderWidth = 5;
                        }
                    }
                    if (validate)
                    {
                        cell.BackColor = ColorTranslator.FromHtml("#111212");
                        ((LinkButton)cell.FindControl(linkbtn)).ForeColor = ColorTranslator.FromHtml("#333131");
                        ((LinkButton)cell.FindControl(linkbtn)).Enabled = false;
                        ((Label)cell.FindControl(lblcontent)).Visible = false;
                        ((Panel)cell.FindControl(pnl)).ForeColor = ColorTranslator.FromHtml("#333131");
                        ((Panel)cell.FindControl(pnl)).BackColor = ColorTranslator.FromHtml("#111212");
                        ((Panel)cell.FindControl(pnl)).BorderColor = ColorTranslator.FromHtml("#111212");
                    }
                }

            }
        }

        protected void gvCalendar_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
            GridViewRow row = gvCalendar.Rows[rowindex];
            var sdate = "";
            if (e.CommandName == "viewlistMon")
            {
                sdate = "lbl1date";
            }
            else if (e.CommandName == "viewlistTue")
            {
                sdate = "lbl2date";
            }
            else if (e.CommandName == "viewlistWed")
            {
                sdate = "lbl3date";
            }
            else if (e.CommandName == "viewlistThu")
            {
                sdate = "lbl4date";
            }
            else if (e.CommandName == "viewlistFri")
            {
                sdate = "lbl5date";
            }
            else if (e.CommandName == "viewlistSat")
            {
                sdate = "lbl6date";
            }
            else if (e.CommandName == "viewlistSun")
            {
                sdate = "lbl7date";
            }
            if(user_code != "Engineer")
            {
                Response.Redirect("~/KMDIweb/EngrItinerary/Engr_ItineraryReportGenerator.aspx" + AddQuerystring(((Label)row.FindControl(sdate)).Text));
            }
            else
            {
                Response.Redirect("~/KMDIweb/EngrItinerary/Engr_Itinerary_Selected_Date.aspx" + AddQuerystring(((Label)row.FindControl(sdate)).Text));
            }
          
        }
        private string AddQuerystring(string sdate)
        {
            return "?Engr=" + ddlEngr.SelectedValue.ToString() +
                   "&HasReport=" + ddlHasReport.SelectedValue.ToString() +
                   "&Month=" + ddlMonth.SelectedValue.ToString() +
                   "&Year=" + ddlYear.SelectedValue.ToString() +
                   "&SelectedDate=" + Convert.ToDateTime(sdate).ToString("yyyy-MM-dd") ;
        }
    }
}