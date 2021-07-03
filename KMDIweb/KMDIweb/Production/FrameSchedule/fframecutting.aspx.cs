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
    public partial class fframecutting : System.Web.UI.Page
    {
        string mon = Convert.ToDateTime(DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Monday)).ToString("yyyy-MM-dd");
        string sun = Convert.ToDateTime(DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Sunday + 7)).ToString("yyyy-MM-dd");
        DataTable gtb = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    var monday = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Monday);
                    var sunday = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Sunday + 7);
                    //tboxBdate.Text = Convert.ToString(DateTime.Now.Year.ToString() + "-" + DateTime.Now.Month.ToString() + "-01");
                    //tboxEdate.Text = Convert.ToString(DateTime.Now.Year.ToString() + "-" + DateTime.Now.Month.ToString() + "-" + System.DateTime.DaysInMonth(DateTime.Now.Year, DateTime.Now.Month).ToString());
                    tboxBdate.Text = Convert.ToDateTime(monday).ToString("yyyy-MM-dd");
                    tboxEdate.Text = Convert.ToDateTime(sunday).ToString("yyyy-MM-dd");
                    loadcutting_frameschedule("for cutting_frame schedule");

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
        private void loadcutting_frameschedule(string command)
        {
            try
            {
                DataTable tb = new DataTable();

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "[frame_cutting_frame_stp]";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", command);
                        sqlcmd.Parameters.AddWithValue("@bdate", tboxBdate.Text);
                        sqlcmd.Parameters.AddWithValue("@edate", tboxEdate.Text);
                        sqlcmd.Parameters.AddWithValue("@mon", mon);
                        sqlcmd.Parameters.AddWithValue("@sun", sun);

                        sqlcmd.Parameters.AddWithValue("@parentjono", "");
                        sqlcmd.Parameters.AddWithValue("@projectname", "");
                        sqlcmd.Parameters.AddWithValue("@color", "");
                        sqlcmd.Parameters.AddWithValue("@duedate", "");

                        sqlcmd.Parameters.AddWithValue("@finished", "");
                        sqlcmd.Parameters.AddWithValue("@remarks", "");
                        sqlcmd.Parameters.AddWithValue("@status", "");
                        sqlcmd.Parameters.AddWithValue("@clno", "");
                        sqlcmd.Parameters.AddWithValue("@cuttinglist", "");
                        sqlcmd.Parameters.AddWithValue("@searchkey", TBOXproject.Text);
                        sqlcmd.Parameters.AddWithValue("@fabricated", CheckBox1.Checked.ToString());
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();

                        ViewState["prevcommand"] = command;


                        int x = 0;

                        foreach (DataRow row in tb.Rows)
                        {
                            x += Convert.ToInt32(row["qty"].ToString());
                        }
                        totalQtyLBL.Text = x.ToString();

                        if (command == "for cutting_frame schedule")
                        {
                            LBLschedule.Text = "Frame Cutting Checklist Table";
                            BTNtoday.BackColor = Color.Red;
                            BTNthisweek.BackColor = Color.Red;
                            BTNprevweek.BackColor = Color.Red;
                        }
                        if (command == "cutting_frame output")
                        {
                            LBLschedule.Text = "Frame Cutting Output";
                            BTNtoday.BackColor = Color.Red;
                            BTNthisweek.BackColor = Color.Red;
                            BTNprevweek.BackColor = Color.Red;
                        }
                        else if (command == "this week")
                        {
                            LBLschedule.Text = "This week (in progress)";
                            BTNtoday.BackColor = Color.Red;
                            BTNthisweek.BackColor = Color.Green;
                            BTNprevweek.BackColor = Color.Red;
                        }
                        else if (command == "today")
                        {
                            LBLschedule.Text = "Due for today (in progress)";
                            BTNtoday.BackColor = Color.Green;
                            BTNthisweek.BackColor = Color.Red;
                            BTNprevweek.BackColor = Color.Red;

                        }
                        else if (command == "prev week")
                        {
                            LBLschedule.Text = "Previous weeks (in progress)";
                            BTNtoday.BackColor = Color.Red;
                            BTNthisweek.BackColor = Color.Red;
                            BTNprevweek.BackColor = Color.Green;

                        }

                        Panel2.Visible = true;
                        Panel1.Visible = false;

                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                loadbalance();
            }

        }
        private void loadbalance()
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "[frame_cutting_frame_stp]";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "balance");
                        sqlcmd.Parameters.AddWithValue("@bdate", tboxBdate.Text);
                        sqlcmd.Parameters.AddWithValue("@edate", tboxEdate.Text);
                        sqlcmd.Parameters.AddWithValue("@mon", mon);
                        sqlcmd.Parameters.AddWithValue("@sun", sun);

                        sqlcmd.Parameters.AddWithValue("@parentjono", "");
                        sqlcmd.Parameters.AddWithValue("@projectname", "");
                        sqlcmd.Parameters.AddWithValue("@color", "");
                        sqlcmd.Parameters.AddWithValue("@duedate", "");

                        sqlcmd.Parameters.AddWithValue("@finished", "");
                        sqlcmd.Parameters.AddWithValue("@remarks", "");
                        sqlcmd.Parameters.AddWithValue("@status", "");
                        sqlcmd.Parameters.AddWithValue("@clno", "");
                        sqlcmd.Parameters.AddWithValue("@cuttinglist", "");
                        sqlcmd.Parameters.AddWithValue("@searchkey", TBOXproject.Text);
                        sqlcmd.Parameters.AddWithValue("@fabricated", CheckBox1.Checked.ToString());
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                BTNthisweek.Text = rd[0].ToString();
                                BTNtoday.Text = rd[1].ToString();
                                BTNprevweek.Text = rd[2].ToString();
                            }
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }

        }
        protected void BTNsearch_Click(object sender, EventArgs e)
        {
            if (searchbyDDL.Text == "Schedule")
            {
                loadcutting_frameschedule("for cutting_frame schedule");
            }
            else if (searchbyDDL.Text == "Output")
            {
                loadcutting_frameschedule("cutting_frame output");
            }

        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            loadcutting_frameschedule(ViewState["prevcommand"].ToString());
        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {

            for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
            {

                Label lblparent = (Label)GridView1.Rows[i].FindControl("LBLday");
                Label lblcutting_frame = (Label)GridView1.Rows[i].FindControl("LBLcutting_frame");
                Label lblfinished = (Label)GridView1.Rows[i].FindControl("LBLfinished");
                if (lblparent.Text == "Monday")
                {
                    GridView1.Rows[i].Cells[0].BackColor = Color.LightBlue;
                    lblparent.ForeColor = Color.Black;
                }
                else if (lblparent.Text == "Tuesday")
                {
                    GridView1.Rows[i].Cells[0].BackColor = Color.LightGreen;
                    lblparent.ForeColor = Color.Black;
                }
                else if (lblparent.Text == "Wednesday")
                {
                    GridView1.Rows[i].Cells[0].BackColor = Color.Yellow;
                    lblparent.ForeColor = Color.Black;
                }
                else if (lblparent.Text == "Thursday")
                {
                    GridView1.Rows[i].Cells[0].BackColor = Color.Orange;
                    lblparent.ForeColor = Color.Black;
                }
                else if (lblparent.Text == "Friday")
                {
                    GridView1.Rows[i].Cells[0].BackColor = Color.Pink;
                    lblparent.ForeColor = Color.Black;
                }
                else if (lblparent.Text == "Saturday")
                {
                    GridView1.Rows[i].Cells[0].BackColor = Color.Violet;
                    lblparent.ForeColor = Color.Black;
                }
                else
                {
                    GridView1.Rows[i].Cells[0].BackColor = Color.Teal;
                    lblparent.ForeColor = Color.Black;
                }
                if (lblcutting_frame.Text != "")
                {
                    GridView1.Rows[i].Cells[8].BackColor = Color.CornflowerBlue;
                    lblcutting_frame.ForeColor = Color.White;
                }

                if (lblfinished.Text != "")
                {
                    GridView1.Rows[i].Cells[9].BackColor = Color.LightSeaGreen;
                    lblfinished.ForeColor = Color.White;
                }
            }


        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "forcutting")
            {
                if (Session["KMDI_ffm_acct"].ToString() == "Guest" || Session["KMDI_ffm_acct"].ToString() == "None")
                {
                    ScriptManager.RegisterStartupScript(this, Page.GetType(), "script", "alert('invalid access!');", true);
                }
                else
                {
                    int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                    GridViewRow row = GridView1.Rows[rowindex];
                    forcutting_frame(((Label)row.FindControl("LBLparentjono")).Text,
                     ((Label)row.FindControl("LBLprojectname")).Text,
                     ((Label)row.FindControl("LBLcolor")).Text,
                            ((Label)row.FindControl("LBLddate")).Text,
                            ((Label)row.FindControl("LBLfinished")).Text,
                            ((Label)row.FindControl("LBLschedremarks")).Text,
                         ((Label)row.FindControl("LBLstatus")).Text,
                         ((Label)row.FindControl("LBLclno")).Text,
                            ((Label)row.FindControl("LBLcuttinglist")).Text);
                    Panel1.Visible = true;
                    Panel2.Visible = false;
                    ViewState["parentjono"] = ((Label)row.FindControl("LBLparentjono")).Text;
                    ViewState["projectname"] = ((Label)row.FindControl("LBLprojectname")).Text;
                    ViewState["color"] = ((Label)row.FindControl("LBLcolor")).Text;
                    ViewState["duedate"] = ((Label)row.FindControl("LBLddate")).Text;
                    ViewState["finished"] = ((Label)row.FindControl("LBLfinished")).Text;
                    ViewState["remarks"] = ((Label)row.FindControl("LBLschedremarks")).Text;
                    ViewState["status"] = ((Label)row.FindControl("LBLstatus")).Text;
                    ViewState["clno"] = ((Label)row.FindControl("LBLclno")).Text;
                    ViewState["cuttinglist"] = ((Label)row.FindControl("LBLcuttinglist")).Text;
                }
            }
        }

        private void forcutting_frame(string parentjono, string projectname, string color, string duedate, string finished, string remarks, string status, string clno, string cuttinglist)
        {
            try
            {
                DataTable tb = new DataTable();

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "[frame_cutting_frame_stp]";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "for cutting_frame");
                        sqlcmd.Parameters.AddWithValue("@bdate", tboxBdate.Text);
                        sqlcmd.Parameters.AddWithValue("@edate", tboxEdate.Text);
                        sqlcmd.Parameters.AddWithValue("@mon", mon);
                        sqlcmd.Parameters.AddWithValue("@sun", sun);

                        sqlcmd.Parameters.AddWithValue("@parentjono", parentjono);
                        sqlcmd.Parameters.AddWithValue("@projectname", projectname);
                        sqlcmd.Parameters.AddWithValue("@color", color);
                        sqlcmd.Parameters.AddWithValue("@duedate", duedate);

                        sqlcmd.Parameters.AddWithValue("@finished", finished);
                        sqlcmd.Parameters.AddWithValue("@remarks", remarks);
                        sqlcmd.Parameters.AddWithValue("@status", status);
                        sqlcmd.Parameters.AddWithValue("@clno", clno);
                        sqlcmd.Parameters.AddWithValue("@cuttinglist", cuttinglist);
                        sqlcmd.Parameters.AddWithValue("@searchkey", TBOXproject.Text);
                        sqlcmd.Parameters.AddWithValue("@fabricated", CheckBox1.Checked.ToString());
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView2.DataSource = tb;
                        GridView2.DataBind();

                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }

        protected void GridView2_DataBound(object sender, EventArgs e)
        {
            for (int i = 0; i <= ((GridView)sender).Rows.Count - 1; i++)
            {
                Label lblparent = (Label)((GridView)sender).Rows[i].FindControl("g2LBLday");
                Label lblcutting_frame = (Label)((GridView)sender).Rows[i].FindControl("g2LBLcutting_frame");

                if (lblparent.Text == "Monday")
                {
                    ((GridView)sender).Rows[i].Cells[0].BackColor = Color.LightBlue;
                    lblparent.ForeColor = Color.Black;
                }
                else if (lblparent.Text == "Tuesday")
                {
                    ((GridView)sender).Rows[i].Cells[0].BackColor = Color.LightGreen;
                    lblparent.ForeColor = Color.Black;
                }
                else if (lblparent.Text == "Wednesday")
                {
                    ((GridView)sender).Rows[i].Cells[0].BackColor = Color.Yellow;
                    lblparent.ForeColor = Color.Black;
                }
                else if (lblparent.Text == "Thursday")
                {
                    ((GridView)sender).Rows[i].Cells[0].BackColor = Color.Orange;
                    lblparent.ForeColor = Color.Black;
                }
                else if (lblparent.Text == "Friday")
                {
                    ((GridView)sender).Rows[i].Cells[0].BackColor = Color.Pink;
                    lblparent.ForeColor = Color.Black;
                }
                else if (lblparent.Text == "Saturday")
                {
                    ((GridView)sender).Rows[i].Cells[0].BackColor = Color.Violet;
                    lblparent.ForeColor = Color.Black;
                }
                else
                {
                    ((GridView)sender).Rows[i].Cells[0].BackColor = Color.Teal;
                    lblparent.ForeColor = Color.Black;
                }

                if (lblcutting_frame.Text != "")
                {
                    ((GridView)sender).Rows[i].Cells[7].BackColor = Color.CornflowerBlue;
                    lblcutting_frame.ForeColor = Color.White;
                }

            }
        }

        protected void LINKexit_Click(object sender, EventArgs e)
        {
            GridView1.PageIndex = GridView1.PageIndex;
            loadcutting_frameschedule(ViewState["prevcommand"].ToString());
            Panel1.Visible = false;
            Panel2.Visible = true;
        }

        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.PageIndex = e.NewPageIndex;
            loadforcutting_frame();
        }
        private void loadforcutting_frame()
        {
            forcutting_frame(ViewState["parentjono"].ToString(),
            ViewState["projectname"].ToString(),
            ViewState["color"].ToString(),
            ViewState["duedate"].ToString(),
            ViewState["finished"].ToString(),
            ViewState["remarks"].ToString(),
            ViewState["status"].ToString(),
            ViewState["clno"].ToString(),
             ViewState["cuttinglist"].ToString());
        }
        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "check")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView2.Rows[rowindex];
                checkitem(((Label)row.FindControl("g2LBLjoborderno")).Text, ((Label)row.FindControl("g2LBLkno")).Text);
            }
            else if (e.CommandName == "uncheck")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView2.Rows[rowindex];
                uncheckitem(((Label)row.FindControl("g2LBLjoborderno")).Text, ((Label)row.FindControl("g2LBLkno")).Text);
            }
        }

        private void uncheckitem(string jo, string kno)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand("update kmdi_fabrication_tb set cutting_frame = '' where job_order_no = '" + jo + "' and kmdi_no  = '" + kno + "' and not cutting_frame  = ''", sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.ExecuteNonQuery();

                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                GridView2.PageIndex = GridView2.PageIndex;
                loadforcutting_frame();

            }
        }

        private void checkitem(string jo, string kno)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    string str = " update kmdi_fabrication_tb set cutting_frame = format(getdate(),'MMM dd, yyyy') where job_order_no = '" + jo + "' and kmdi_no  = '" + kno + "' and cutting_frame = ''"+ 
                                 " declare @MostRecentDate as varchar(100) = " +
                                 " (SELECT " +
                                 " CASE WHEN cast(cutting_sash as date) > cast(cutting_frame as date) THEN cutting_sash " +
                                 " ELSE cutting_frame " +
                                 " END AS MostRecentDate " +
                                 " FROM kmdi_fabrication_tb where job_order_no = '" + jo + "' and kmdi_no = '" + kno + "') " +
                                 " update kmdi_fabrication_tb set cutting = @MostRecentDate where job_order_no = '" + jo + "' and kmdi_no = '" + kno + "' and cutting_frame <> '' and cutting_sash <> ''";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.ExecuteNonQuery();

                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                GridView2.PageIndex = GridView2.PageIndex;
                loadforcutting_frame();

            }
        }

        protected void BTNprevweek_Click(object sender, EventArgs e)
        {
            loadcutting_frameschedule("prev week");
        }

        protected void BTNtoday_Click(object sender, EventArgs e)
        {
            loadcutting_frameschedule("today");
        }

        protected void BTNthisweek_Click(object sender, EventArgs e)
        {
            loadcutting_frameschedule("this week");
        }
    }
}