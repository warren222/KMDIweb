using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.EngrItinerary
{
    public partial class Engr_Itinerary_Selected_Date : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    lblDate.Text = Convert.ToDateTime(SelectedDate).ToString("MMMM dd, yyyy");
                    GetDailyReport();
                    GetInstItinerary();
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/EngrItinerary/Engr_Itinerary.aspx" + AddQuerystring);
        }
        private string AddQuerystring
        {
            get
            {
                return "?Engr=" + Request.QueryString["Engr"].ToString() +
                "&HasReport=" + Request.QueryString["HasReport"].ToString() +
                "&Month=" + Request.QueryString["Month"].ToString() +
                "&Year=" + Request.QueryString["Year"].ToString();
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
        private string SelectedDate
        {
            get
            {
                return Convert.ToDateTime(Request.QueryString["SelectedDate"].ToString()).ToString("yyyy-MM-dd");
            }
        }
        private void GetInstItinerary()
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
                        sqlcmd.Parameters.AddWithValue("@Command", "Inst_Itinerary_ByDate");
                        sqlcmd.Parameters.AddWithValue("@SelectedDate", SelectedDate);
                        sqlcmd.Parameters.AddWithValue("@Engr", nickname);
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvInstItinerary.DataSource = tb;
                            gvInstItinerary.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
        private void GetDailyReport()
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
                        sqlcmd.Parameters.AddWithValue("@Command", "Daily_Report_ByDate");
                        sqlcmd.Parameters.AddWithValue("@SelectedDate", SelectedDate);
                        sqlcmd.Parameters.AddWithValue("@Engr", nickname);
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvDailyReport.DataSource = tb;
                            gvDailyReport.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
        private void ExecuteQuery_II(string command,
                                     string autonum,
                                     string engr,
                                     string idate,
                                     string project,
                                     string appttime,
                                     string concern)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "INSTITINERARY_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@COMMAND", command);
                        sqlcmd.Parameters.AddWithValue("@AUTONUM", autonum);
                        sqlcmd.Parameters.AddWithValue("@ENGR", engr);
                        sqlcmd.Parameters.AddWithValue("@IDATE", idate);
                        sqlcmd.Parameters.AddWithValue("@PROJECT", project);
                        sqlcmd.Parameters.AddWithValue("@APPTTIME", appttime);
                        sqlcmd.Parameters.AddWithValue("@CONCERN", concern);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            finally
            {
                GetInstItinerary();
            }
        }
        private void ExecuteQuery_DR(string command,
                                     string autonum,
                                     string engr,
                                     string edate,
                                     string project,
                                     string address,
                                     string arrival,
                                     string depart,
                                     string remarks)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "ENGRDAILYREPORT_STP";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", command);
                        sqlcmd.Parameters.AddWithValue("@AUTONUM", autonum);
                        sqlcmd.Parameters.AddWithValue("@ENGR", engr);
                        sqlcmd.Parameters.AddWithValue("@EDATE", edate);
                        sqlcmd.Parameters.AddWithValue("@PROJECT", project);
                        sqlcmd.Parameters.AddWithValue("@ADDRESS", address);
                        sqlcmd.Parameters.AddWithValue("@ARRIVAL", arrival);
                        sqlcmd.Parameters.AddWithValue("@DEPART", depart);
                        sqlcmd.Parameters.AddWithValue("@REMARKS", remarks);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            finally
            {
                GetDailyReport();
            }
        }
        private string nickname
        {
            get
            {
                return Session["KMDI_nickname"].ToString();
            }
        }
        protected void btnIIAdd_Click(object sender, EventArgs e)
        {
            ExecuteQuery_II("Insert",
                            "",
                            nickname,
                            SelectedDate,
                            tboxIIProject.Text,
                            tboxIIApptTime.Text,
                            tboxIIConcern.Text);
        }

        protected void btnDRAdd_Click(object sender, EventArgs e)
        {
            ExecuteQuery_DR("Insert",
                            "",
                            nickname,
                            SelectedDate,
                            tboxDRProject.Text,
                            tboxDRAddress.Text,
                            tboxDRArrival.Text,
                            tboxDRDepart.Text,
                            tboxDRRemarks.Text);
        }

        protected void gvDailyReport_RowCommand(object sender, GridViewCommandEventArgs e)
        {
           
            if (e.CommandName == "execDelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvDailyReport.Rows[rowindex];
                string autonum = ((Label)row.FindControl("lblDRId")).Text;
                ExecuteQuery_DR("Delete", autonum, "", "", "", "", "", "", "");
            }
        }

        protected void gvInstItinerary_RowCommand(object sender, GridViewCommandEventArgs e)
        {
          
            if (e.CommandName == "execDelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvInstItinerary.Rows[rowindex];
                string autonum = ((Label)row.FindControl("lblIIId")).Text;
                ExecuteQuery_II("Delete", autonum, "", "", "", "", "");
            }
        }

        protected void btnIISearch_Click(object sender, EventArgs e)
        {
            GetProject(gvIIProject,tboxSearchProjectII.Text);
        }
        private void GetProject(GridView gv, string search)
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
                        sqlcmd.Parameters.AddWithValue("@Command", "Select_Project");
                        sqlcmd.Parameters.AddWithValue("@Engr", nickname);
                        sqlcmd.Parameters.AddWithValue("@Search", search);
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da= new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gv.DataSource = tb;
                            gv.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }

        protected void gvIIProject_RowCommand(object sender, GridViewCommandEventArgs e)
        {
          
            if (e.CommandName == "execSelect")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvIIProject.Rows[rowindex];
                tboxIIProject.Text = ((Label)row.FindControl("lblProjectII")).Text;
                row.RowState = DataControlRowState.Selected;
            }
        }

        protected void gvIIProject_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvIIProject.PageIndex = e.NewPageIndex;
            GetProject(gvIIProject, tboxSearchProjectII.Text);
        }
    }
}