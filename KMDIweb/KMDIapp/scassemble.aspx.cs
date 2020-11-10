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

namespace KMDIweb.KMDIapp
{
    public partial class scassemble : System.Web.UI.Page
    {
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
                    loadassembleschedule();

                }
            }
            else
            {
                Response.Redirect("~/KMDIapp/Login.aspx");
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

        protected void BTNsearch_Click(object sender, EventArgs e)
        {
            loadassembleschedule();
        }
        private void loadassembleschedule()
        {
            try
            {
                DataTable tb = new DataTable();

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "[screen_assemble_stp]";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "for assemble schedule");
                        sqlcmd.Parameters.AddWithValue("@bdate", tboxBdate.Text);
                        sqlcmd.Parameters.AddWithValue("@edate", tboxEdate.Text);

                        sqlcmd.Parameters.AddWithValue("@parentjono", "");
                        sqlcmd.Parameters.AddWithValue("@projectname", "");
                        sqlcmd.Parameters.AddWithValue("@color", "");
                        sqlcmd.Parameters.AddWithValue("@duedate", "");
                        sqlcmd.Parameters.AddWithValue("@screentype", "");
                        sqlcmd.Parameters.AddWithValue("@finished", "");
                        sqlcmd.Parameters.AddWithValue("@remarks", "");
                        sqlcmd.Parameters.AddWithValue("@status", "");
                        sqlcmd.Parameters.AddWithValue("@clno", "");

                            sqlcmd.Parameters.AddWithValue("@searchkey", TBOXproject.Text); 
                        sqlcmd.Parameters.AddWithValue("@fabricated", CheckBox1.Checked.ToString());
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();

                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }

        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
            for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
            {
                Label lblparent = (Label)GridView1.Rows[i].FindControl("LBLday");
                Label lblassemble = (Label)GridView1.Rows[i].FindControl("LBLassembled");
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
                if (lblassemble.Text != "")
                {
                    GridView1.Rows[i].Cells[8].BackColor = Color.Indigo;
                    lblassemble.ForeColor = Color.White;
                }

                if (lblfinished.Text != "")
                {
                    GridView1.Rows[i].Cells[9].BackColor = Color.Brown;
                    lblfinished.ForeColor = Color.White;
                }
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            loadassembleschedule();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "forcutting")
            {
                if (Session["KMDI_acct"].ToString() == "Guest")
                {
                    ScriptManager.RegisterStartupScript(this, Page.GetType(), "script", "alert('invalid access!');", true);
                }
                else
                {
                    int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                    GridViewRow row = GridView1.Rows[rowindex];
                    forassemble(((Label)row.FindControl("LBLparentjono")).Text,
                     ((Label)row.FindControl("LBLprojectname")).Text,
                     ((Label)row.FindControl("LBLcolor")).Text,
                            ((Label)row.FindControl("LBLddate")).Text,
                            ((Label)row.FindControl("LBLscreentype")).Text,
                            ((Label)row.FindControl("LBLfinished")).Text,
                            ((Label)row.FindControl("LBLschedremarks")).Text,
                         ((Label)row.FindControl("LBLstatus")).Text,
                         ((Label)row.FindControl("LBLclno")).Text);
                    Panel2.Visible = true;
                    Panel1.Visible = false;
                    ViewState["parentjono"] = ((Label)row.FindControl("LBLparentjono")).Text;
                    ViewState["projectname"] = ((Label)row.FindControl("LBLprojectname")).Text;
                    ViewState["color"] = ((Label)row.FindControl("LBLcolor")).Text;
                    ViewState["duedate"] = ((Label)row.FindControl("LBLddate")).Text;
                    ViewState["screentype"] = ((Label)row.FindControl("LBLscreentype")).Text;
                    ViewState["finished"] = ((Label)row.FindControl("LBLfinished")).Text;
                    ViewState["remarks"] = ((Label)row.FindControl("LBLschedremarks")).Text;
                    ViewState["status"] = ((Label)row.FindControl("LBLstatus")).Text;
                    ViewState["clno"] = ((Label)row.FindControl("LBLclno")).Text;
                }
            }
        }
        private void forassemble(string parentjono, string projectname, string color, string duedate, string screentype, string finished, string remarks, string status, string clno)
        {
            try
            {
                DataTable tb = new DataTable();

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "[screen_assemble_stp]";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "for assemble");
                        sqlcmd.Parameters.AddWithValue("@bdate", tboxBdate.Text);
                        sqlcmd.Parameters.AddWithValue("@edate", tboxEdate.Text);

                        sqlcmd.Parameters.AddWithValue("@parentjono", parentjono);
                        sqlcmd.Parameters.AddWithValue("@projectname", projectname);
                        sqlcmd.Parameters.AddWithValue("@color", color);
                        sqlcmd.Parameters.AddWithValue("@duedate", duedate);
                        sqlcmd.Parameters.AddWithValue("@screentype", screentype);
                        sqlcmd.Parameters.AddWithValue("@finished", finished);
                        sqlcmd.Parameters.AddWithValue("@remarks", remarks);
                        sqlcmd.Parameters.AddWithValue("@status", status);
                        sqlcmd.Parameters.AddWithValue("@clno", clno);
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

        protected void LINKexit_Click(object sender, EventArgs e)
        {
            GridView1.PageIndex = GridView1.PageIndex;
            loadassembleschedule();
            Panel2.Visible = false;
            Panel1.Visible = true;
        }
        protected void GridView2_DataBound(object sender, EventArgs e)
        {
            for (int i = 0; i <= ((GridView)sender).Rows.Count - 1; i++)
            {
                Label lblparent = (Label)((GridView)sender).Rows[i].FindControl("g2LBLday");
                Label lblassemble = (Label)((GridView)sender).Rows[i].FindControl("g2LBLassembled");

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

                if (lblassemble.Text != "")
                {
                    ((GridView)sender).Rows[i].Cells[7].BackColor = Color.Indigo;
                    lblassemble.ForeColor = Color.White;
                }

            }
        }
        private void loadforassemble()
        {
            forassemble(ViewState["parentjono"].ToString(),
            ViewState["projectname"].ToString(),
            ViewState["color"].ToString(),
            ViewState["duedate"].ToString(),
            ViewState["screentype"].ToString(),
            ViewState["finished"].ToString(),
            ViewState["remarks"].ToString(),
            ViewState["status"].ToString(),
            ViewState["clno"].ToString());
        }
        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.PageIndex = e.NewPageIndex;
            loadforassemble();
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
                    using (SqlCommand sqlcmd = new SqlCommand("update kmdi_screenfab_tb set assembled = '' where job_order_no = '" + jo + "' and kmdi_no  = '" + kno + "' and not assembled  = ''", sqlcon))
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
                loadforassemble();

            }
        }

        private void checkitem(string jo, string kno)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand("update kmdi_screenfab_tb set assembled = format(getdate(),'MMM dd, yyyy') where job_order_no = '" + jo + "' and kmdi_no  = '" + kno + "' and assembled = ''", sqlcon))
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
                loadforassemble();

            }
        }
    }
}