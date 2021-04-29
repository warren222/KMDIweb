using KMDIweb.KMDIweb.Global.objects;
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
    public partial class FrameHome : System.Web.UI.Page
    {

        string mon = Convert.ToDateTime(DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Monday)).ToString("yyyy-MM-dd");
        string sun = Convert.ToDateTime(DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Sunday + 7)).ToString("yyyy-MM-dd");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    var monday = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Monday);
                    var sunday = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Sunday + 7);
                    tboxBdate.Text = Convert.ToDateTime(monday).ToString("yyyy-MM-dd");
                    tboxEdate.Text = Convert.ToDateTime(sunday).ToString("yyyy-MM-dd");
                    //tboxBdate.Text = Convert.ToString(DateTime.Now.Year.ToString() + "-" + DateTime.Now.Month.ToString() + "-01");
                    //tboxEdate.Text = Convert.ToString(DateTime.Now.Year.ToString() + "-" + DateTime.Now.Month.ToString() + "-" + System.DateTime.DaysInMonth(DateTime.Now.Year, DateTime.Now.Month).ToString());


                    loadschedule("load schedule");
                    balanceload();

                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private DataTable mytb
        {
            get
            {
                return (DataTable)ViewState["tb"];
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
        private string usercode
        {
            get
            {
                return Session["KMDI_user_code"].ToString();
            }
        }
        private void validateUser()
        {
            if ((usercode == "Engineer") ||
            (usercode == "AE") ||
            (usercode == "Delivery") ||
            (usercode == "Delivery Head") ||
            (usercode == "Engineer Manager") ||
            (usercode == "Production Manager") ||
            (usercode == "Production Engineer"))
            {
                AddNFIIbtn.Visible = true;
            }
            else
            {
                AddNFIIbtn.Visible = false;
            }
        }
        private void loadschedule(string command)
        {
            try
            {
                DataTable tb = new DataTable();

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "[frame_schedule_stp]";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", command);
                        sqlcmd.Parameters.AddWithValue("@bdate", tboxBdate.Text);
                        sqlcmd.Parameters.AddWithValue("@edate", tboxEdate.Text);
                        sqlcmd.Parameters.AddWithValue("@mon", mon);
                        sqlcmd.Parameters.AddWithValue("@sun", sun);
                        sqlcmd.Parameters.AddWithValue("@projectname", TBOXprojectname.Text);
                        sqlcmd.Parameters.AddWithValue("@address", DDLaddress.Text.ToString());
                        sqlcmd.Parameters.AddWithValue("@progress", DDLprogress.Text.ToString());

                        sqlcmd.Parameters.AddWithValue("@pjono", "");
                        sqlcmd.Parameters.AddWithValue("@pname", "");
                        sqlcmd.Parameters.AddWithValue("@color", "");
                        sqlcmd.Parameters.AddWithValue("@rduedate", "");
                        sqlcmd.Parameters.AddWithValue("@finished", "");
                        sqlcmd.Parameters.AddWithValue("@schedremarks", "");
                        sqlcmd.Parameters.AddWithValue("@status", "");
                        sqlcmd.Parameters.AddWithValue("@cuttinglist", "");
                        sqlcmd.Parameters.AddWithValue("@clno", "");
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();

                        ViewState["prevcommand"] = command;

                        if (command == "load schedule")
                        {
                            LBLschedule.Text = "Frame Fabrication Selected Schedule";
                            BTNCurrentweektime.ForeColor = Color.CornflowerBlue;
                            BTNtodaytime.ForeColor = Color.CornflowerBlue;
                            BTNprevweektime.ForeColor = Color.CornflowerBlue;
                            BTNCurrentweektime.Font.Bold = false;
                            BTNtodaytime.Font.Bold = false;
                            BTNprevweektime.Font.Bold = false;
                        }
                        else if (command == "current week")
                        {
                            LBLschedule.Text = "This week (in progress)";
                            BTNCurrentweektime.ForeColor = Color.Green;
                            BTNtodaytime.ForeColor = Color.CornflowerBlue;
                            BTNprevweektime.ForeColor = Color.CornflowerBlue;
                            BTNCurrentweektime.Font.Bold = true;
                            BTNtodaytime.Font.Bold = false;
                            BTNprevweektime.Font.Bold = false;
                        }
                        else if (command == "today")
                        {
                            LBLschedule.Text = "Due for today (in progress)";
                            BTNCurrentweektime.ForeColor = Color.CornflowerBlue;
                            BTNtodaytime.ForeColor = Color.Green;
                            BTNprevweektime.ForeColor = Color.CornflowerBlue;
                            BTNCurrentweektime.Font.Bold = false;
                            BTNtodaytime.Font.Bold = true;
                            BTNprevweektime.Font.Bold = false;

                        }
                        else if (command == "prev week")
                        {
                            LBLschedule.Text = "Previous weeks (in progress)";
                            BTNCurrentweektime.ForeColor = Color.CornflowerBlue;
                            BTNtodaytime.ForeColor = Color.CornflowerBlue;
                            BTNprevweektime.ForeColor = Color.Green;
                            BTNCurrentweektime.Font.Bold = false;
                            BTNtodaytime.Font.Bold = false;
                            BTNprevweektime.Font.Bold = true;
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }

        private void balanceload()
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "frame_schedule_stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "balance load");
                        sqlcmd.Parameters.AddWithValue("@bdate", tboxBdate.Text);
                        sqlcmd.Parameters.AddWithValue("@edate", tboxEdate.Text);
                        sqlcmd.Parameters.AddWithValue("@mon", mon);
                        sqlcmd.Parameters.AddWithValue("@sun", sun);
                        sqlcmd.Parameters.AddWithValue("@projectname", "");
                        sqlcmd.Parameters.AddWithValue("@address", DDLaddress.Text.ToString());
                        sqlcmd.Parameters.AddWithValue("@progress", DDLprogress.Text.ToString());

                        sqlcmd.Parameters.AddWithValue("@pjono", "");
                        sqlcmd.Parameters.AddWithValue("@pname", "");
                        sqlcmd.Parameters.AddWithValue("@color", "");
                        sqlcmd.Parameters.AddWithValue("@rduedate", "");
                        sqlcmd.Parameters.AddWithValue("@finished", "");
                        sqlcmd.Parameters.AddWithValue("@schedremarks", "");
                        sqlcmd.Parameters.AddWithValue("@status", "");
                        sqlcmd.Parameters.AddWithValue("@cuttinglist", "");
                        sqlcmd.Parameters.AddWithValue("@clno", "");
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                BTNCurrentweektime.Text = rd[0].ToString();
                                LBLcurrentweekitem.Text = rd[1].ToString();
                                BTNtodaytime.Text = rd[2].ToString();
                                LBLtodayitem.Text = rd[3].ToString();
                                BTNprevweektime.Text = rd[4].ToString();
                                LBLprevweekitem.Text = rd[5].ToString();
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

            loadschedule("load schedule");
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            loadschedule(ViewState["prevcommand"].ToString());
        }

        protected void BTNCurrentweektime_Click(object sender, EventArgs e)
        {
            loadschedule("current week");
        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
            for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
            {
                Label lblparent = (Label)GridView1.Rows[i].FindControl("LBLday");
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
                if (lblfinished.Text != "")
                {
                    GridView1.Rows[i].Cells[9].BackColor = Color.LightSeaGreen;
                    lblfinished.ForeColor = Color.White;
                }
            }
        }

        protected void BTNtodaytime_Click(object sender, EventArgs e)
        {
            loadschedule("today");
        }

        protected void BTNprevweektime_Click(object sender, EventArgs e)
        {
            loadschedule("prev week");
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "loadkno")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                ViewState["parentjono"] = ((Label)row.FindControl("LBLparentjono")).Text;
                ViewState["projectname"] = ((Label)row.FindControl("LBLprojectname")).Text;
                ViewState["color"] = ((Label)row.FindControl("LBLcolor")).Text;
                ViewState["realduedate"] = ((Label)row.FindControl("LBLrealduedate")).Text;
                ViewState["finished"] = ((Label)row.FindControl("LBLfinished")).Text;
                ViewState["schedremarks"] = ((Label)row.FindControl("LBLschedremarks")).Text;
                ViewState["status"] = ((Label)row.FindControl("LBLstatus")).Text;
                ViewState["cuttinglist"] = ((Label)row.FindControl("LBLcuttinglist")).Text;
                ViewState["clno"] = ((Label)row.FindControl("LBLclno")).Text;


                Session["LBLparentjono"] = ((Label)row.FindControl("LBLparentjono")).Text;
                Session["LBLprojectname"] = ((Label)row.FindControl("LBLprojectname")).Text;
                Session["LBLaddress"] = ((Label)row.FindControl("LBLaddress")).Text;
                Panel2.Visible = true;
                Panel1.Visible = false;
                loadkno();
            }
        }
        private void loadkno()
        {
            try
            {
                DataTable tb = new DataTable();

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "frame_schedule_stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "load kno");
                        sqlcmd.Parameters.AddWithValue("@bdate", tboxBdate.Text);
                        sqlcmd.Parameters.AddWithValue("@edate", tboxEdate.Text);
                        sqlcmd.Parameters.AddWithValue("@mon", mon);
                        sqlcmd.Parameters.AddWithValue("@sun", sun);
                        sqlcmd.Parameters.AddWithValue("@projectname", "");
                        sqlcmd.Parameters.AddWithValue("@address", DDLaddress.Text.ToString());
                        sqlcmd.Parameters.AddWithValue("@progress", DDLprogress.Text.ToString());

                        sqlcmd.Parameters.AddWithValue("@pjono", ViewState["parentjono"].ToString());
                        sqlcmd.Parameters.AddWithValue("@pname", ViewState["projectname"].ToString());
                        sqlcmd.Parameters.AddWithValue("@color", ViewState["color"].ToString());
                        sqlcmd.Parameters.AddWithValue("@rduedate", ViewState["realduedate"].ToString());
                        sqlcmd.Parameters.AddWithValue("@finished", ViewState["finished"].ToString());
                        sqlcmd.Parameters.AddWithValue("@schedremarks", ViewState["schedremarks"].ToString());
                        sqlcmd.Parameters.AddWithValue("@status", ViewState["status"].ToString());
                        sqlcmd.Parameters.AddWithValue("@cuttinglist", ViewState["cuttinglist"].ToString());
                        sqlcmd.Parameters.AddWithValue("@clno", ViewState["clno"].ToString());
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView2.DataSource = tb;
                        GridView2.DataBind();
                        ViewState["tb"] = tb;

                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
        protected void LINKexit_Click(object sender, EventArgs e)
        {
            Panel2.Visible = false;
            Panel1.Visible = true;
        }

        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            loadkno();
        }
        protected void GridView2_DataBound(object sender, EventArgs e)
        {
            for (int i = 0; i <= ((GridView)sender).Rows.Count - 1; i++)
            {
                Label lblparent = (Label)((GridView)sender).Rows[i].FindControl("g2LBLday");

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
            }
        }

        protected void AddNFIIbtn_Click(object sender, EventArgs e)
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
            foreach (GridViewRow row in GridView2.Rows)
            {
                CheckBox cbk = (CheckBox)row.FindControl("cboxselect");
                if (cbk.Checked == true)
                {
                    int x = int.Parse(((Label)row.FindControl("g2LBLID")).Text.ToString());
                    if (!l.Contains(x))
                    {
                        l.Add(x);
                    }
                }
                else
                {
                    int x = int.Parse(((Label)row.FindControl("g2LBLID")).Text.ToString());
                    if (l.Contains(x))
                    {
                        l.Remove(x);
                    }
                }
            }
            Session["listKno"] = listKno(l);
            Response.Redirect("~/KMDIweb/Production/FrameSchedule/NoticeForIncompleteItem.aspx");
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
                        string kno;
                        kmdino k = new kmdino();
                        kno = mytb.Rows[i]["kmdi_no"].ToString();
                        k.kmdi_no = kno;
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
    }
}