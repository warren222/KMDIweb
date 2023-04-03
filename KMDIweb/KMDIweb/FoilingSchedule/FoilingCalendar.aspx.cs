using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.FoilingSchedule
{
    public partial class FoilingCalendar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    ddlmonth.SelectedValue = DateTime.Now.ToString("MM");
                    tboxyear.Text = DateTime.Now.ToString("yyyy");
                    ViewState["specification"] = ddlSpecification.Text;
                    loaddata();
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
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ViewState["specification"] = ddlSpecification.Text;
            loaddata();
        }
        private void loaddata()
        {
            string d = tboxyear.Text + "-" + ddlmonth.SelectedValue.ToString() + "-01";

            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        if (ViewState["specification"].ToString() == "Screen")
                        {
                            sqlcmd.CommandText = "Foiling_Calendar_Screen_Stp";
                        }
                        else
                        {
                            sqlcmd.CommandText = "Foiling_Calendar_Stp";
                        }
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@COMMAND", "Calendar");
                        sqlcmd.Parameters.AddWithValue("@Date", d);
                        GridView1.DataSource = sqlcmd.ExecuteReader();
                        GridView1.DataBind();
                        lblMonth.Text = Convert.ToDateTime(d).ToString("MMMM");
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    for (int i = 0; i <= 6; i++)
                    {
                        int nameIndex = i + 1;
                        int currentRowIndex = e.Row.RowIndex;


                        string linkbtn = "linkbtn" + nameIndex.ToString();
                        string lbldate = "lbl" + nameIndex.ToString() + "date";
                        string lblcontext = "lblContext";
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
                            string converted = Convert.ToDateTime(((Label)GridView1.Rows[currentRowIndex - 1].Cells[i].FindControl(lbldate)).Text).ToString("MMM");
                            validate = converted != selected_month ? true : false;
                            cell.BackColor = System.Drawing.Color.White;
                            cell.BorderColor = System.Drawing.Color.Gray;
                        }
                        if (validate)
                        {
                            cell.BackColor = System.Drawing.Color.Khaki;
                            cell.ForeColor = System.Drawing.Color.White;
                            ((LinkButton)cell.FindControl(linkbtn)).ForeColor = System.Drawing.Color.White;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string caldate="";
            int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
            GridViewRow row = GridView1.Rows[rowindex];
         
                if (e.CommandName == "viewlistMon")
                {
                    //OpenModal("lbl1date", "lbl1points", e);
                    caldate = ((Label)row.FindControl("lbl1date")).Text;
                    lblmodalDate.Text = caldate;
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
                lblmodalDate.Text = Convert.ToDateTime(caldate).ToString("MMMM dd, yyyy");
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            
        }
        private void loadItems(string d)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        try
                        {
                            sqlcon.Open();
                            if (ViewState["specification"].ToString() == "Screen")
                            {
                                sqlcmd.CommandText = "Foiling_Calendar_Screen_Stp";
                            }
                            else
                            {
                                sqlcmd.CommandText = "Foiling_Calendar_Stp";
                            }
                            sqlcmd.CommandType = CommandType.StoredProcedure;
                            sqlcmd.Parameters.AddWithValue("@COMMAND", "ViewListReport");
                            sqlcmd.Parameters.AddWithValue("@Date", d);
                            GridView2.DataSource = sqlcmd.ExecuteReader();
                            GridView2.DataBind();
                        }
                        catch (Exception e)
                        {
                            errorrmessage(e.ToString());
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                errorrmessage(ex.ToString());
            }
        }
    }
}