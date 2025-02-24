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
                "&Year=" + Request.QueryString["Year"].ToString() +
                "&SelectedDate=" + Request.QueryString["SelectedDate"].ToString();
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
                return Request.QueryString["SelectedDate"].ToString();
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
                                     string address,
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
                        sqlcmd.Parameters.AddWithValue("@ADDRESS", address);
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
                UpdateCancel_Mode_II(true, false, "Input Form", Color.Black);
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
                UpdateCancel_Mode_DR(true, false, "Input Form", Color.Black);
            }
        }
        private string nickname
        {
            get
            {
                return Session["KMDI_nickname"].ToString();
            }
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
            else if (e.CommandName == "execEdit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvDailyReport.Rows[rowindex];
                ViewState["DRId"] = ((Label)row.FindControl("lblDRId")).Text;
                tboxDRProject.Text = ((Label)row.FindControl("lblDRProject")).Text;
                tboxDRAddress.Text = ((Label)row.FindControl("lblDRAddress")).Text;
                tboxDRArrival.Text = (((Label)row.FindControl("lblDRArrival")).Text == "" ? "" : Convert.ToDateTime(((Label)row.FindControl("lblDRArrival")).Text).ToString("HH:mm"));
                tboxDRDepart.Text = (((Label)row.FindControl("lblDRDepart")).Text == "" ? "" : Convert.ToDateTime(((Label)row.FindControl("lblDRDepart")).Text).ToString("HH:mm"));
                tboxDRRemarks.Text = ((Label)row.FindControl("lblDRRemarks")).Text;
                UpdateCancel_Mode_DR(false, true, "Update Form", Color.Red);
            }
        }

        protected void gvInstItinerary_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "execDelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvInstItinerary.Rows[rowindex];
                string autonum = ((Label)row.FindControl("lblIIId")).Text;
                ExecuteQuery_II("Delete", autonum, "", "", "", "", "", "");
            }
            else if (e.CommandName == "execEdit")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvInstItinerary.Rows[rowindex];
                ViewState["IIId"] = ((Label)row.FindControl("lblIIId")).Text;
                tboxIIProject.Text = ((LinkButton)row.FindControl("lblIIProject")).Text;
                tboxIIAddress.Text = ((Label)row.FindControl("lblIIAddress")).Text;
                tboxIIApptTime.Text = Convert.ToDateTime(((Label)row.FindControl("lblIIApptTime")).Text).ToString("HH:mm");
                tboxIIConcern.Text = ((Label)row.FindControl("lblIIConcern")).Text;
                UpdateCancel_Mode_II(false, true, "Update Form", Color.Red);
            }
            else if (e.CommandName == "execAddDailyReport")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvInstItinerary.Rows[rowindex];
                string project = ((LinkButton)row.FindControl("lblIIProject")).Text;
                string address = ((Label)row.FindControl("lblIIAddress")).Text;
                string concern = ((Label)row.FindControl("lblIIConcern")).Text;
                ExecuteQuery_DR("Insert", "", nickname, SelectedDate, project, address, "", "", concern);
            }
        }

        protected void btnIISearch_Click(object sender, EventArgs e)
        {
            GetProject(gvIIProject, tboxSearchProjectII.Text);
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
                        using (SqlDataAdapter da = new SqlDataAdapter())
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
                tboxIIAddress.Text = ((Label)row.FindControl("lblAddressII")).Text;
                row.RowState = DataControlRowState.Selected;
            }
        }

        protected void gvIIProject_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvIIProject.PageIndex = e.NewPageIndex;
            GetProject(gvIIProject, tboxSearchProjectII.Text);
        }


        protected void btnDRSearch_Click(object sender, EventArgs e)
        {
            GetProject(gvDRProject, tboxSearchProjectDR.Text);
        }

        protected void gvDRProject_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "execSelect")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvDRProject.Rows[rowindex];
                tboxDRProject.Text = ((Label)row.FindControl("lblProjectDR")).Text;
                tboxDRAddress.Text = ((Label)row.FindControl("lblAddressDR")).Text;
                row.RowState = DataControlRowState.Selected;
            }
        }

        protected void gvDRProject_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDRProject.PageIndex = e.NewPageIndex;
            GetProject(gvDRProject, tboxSearchProjectDR.Text);
        }

        protected void btnIIAdd_Click(object sender, EventArgs e)
        {
            ExecuteQuery_II_InitializeValues("Insert", "");
        }
        protected void btnIIUpdate_Click(object sender, EventArgs e)
        {
            ExecuteQuery_II_InitializeValues("Update", ViewState["IIId"].ToString());
        }
        private void ExecuteQuery_II_InitializeValues(string command, string autonum)
        {
            tboxIIApptTime.Text = Convert.ToDateTime(tboxIIApptTime.Text).ToString("hh:mm tt");
            ExecuteQuery_II(command,
                            autonum,
                            nickname,
                            SelectedDate,
                            tboxIIProject.Text,
                            tboxIIAddress.Text,
                            tboxIIApptTime.Text,
                            tboxIIConcern.Text);
        }
        private int IsPass()
        {
            int x = 0;
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "INSTITINERARY_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Check_Input");
                        sqlcmd.Parameters.AddWithValue("@ENGR", nickname);
                        sqlcmd.Parameters.AddWithValue("@IDATE", SelectedDate);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                x = Convert.ToInt32(rd[0].ToString());
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            return x;
        }
        protected void btnDRAdd_Click(object sender, EventArgs e)
        {
           if(IsPass() > 0)
            {
                ExecuteQuery_DR_InitializeValues("Insert", "");
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, GetType(), "warning", @"alert('WARNING: Sorry! Please add Installation Engineer`s Itinerary first :(');", true);
            }
        }
        protected void btnDRUpdate_Click(object sender, EventArgs e)
        {
            ExecuteQuery_DR_InitializeValues("Update", ViewState["DRId"].ToString());
        }
        private void ExecuteQuery_DR_InitializeValues(string command, string autonum)
        {
            tboxDRArrival.Text = Convert.ToDateTime(tboxDRArrival.Text).ToString("hh:mm tt");
            tboxDRDepart.Text = Convert.ToDateTime(tboxDRDepart.Text).ToString("hh:mm tt");
            ExecuteQuery_DR(command,
                            autonum,
                            nickname,
                            SelectedDate,
                            tboxDRProject.Text,
                            tboxDRAddress.Text,
                            tboxDRArrival.Text,
                            tboxDRDepart.Text,
                            tboxDRRemarks.Text);
        }
        protected void btnIICancel_Click(object sender, EventArgs e)
        {
            UpdateCancel_Mode_II(true, false, "Input Form", Color.Black);
        }

        protected void btnDRCancel_Click(object sender, EventArgs e)
        {
            UpdateCancel_Mode_DR(true, false, "Input Form", Color.Black);
        }
        private void UpdateCancel_Mode_DR(bool tr, bool fl, string label, Color c)
        {
            btnDRAdd.Visible = tr;
            btnDRUpdate.Visible = fl;
            btnDRCancel.Visible = fl;
            lblDRFormLabel.Text = label;
            lblDRFormLabel.ForeColor = c;

            if (tr)
            {
                tboxDRProject.Text = "";
                tboxDRAddress.Text = "";
                tboxDRArrival.Text = "";
                tboxDRDepart.Text = "";
                tboxDRRemarks.Text = "";
            }
        }
        private void UpdateCancel_Mode_II(bool tr, bool fl, string label, Color c)
        {
            btnIIAdd.Visible = tr;
            btnIIUpdate.Visible = fl;
            btnIICancel.Visible = fl;
            lblIIFormLabel.Text = label;
            lblIIFormLabel.ForeColor = c;

            if (tr)
            {
                tboxIIProject.Text = "";
                tboxIIAddress.Text = "";
                tboxIIApptTime.Text = "";
                tboxIIConcern.Text = "";
            }
        }

        protected void btnReport_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/EngrItinerary/Engr_ItineraryReport.aspx" + AddQuerystring);
        }
    }
}