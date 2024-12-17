using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.Production.FrameSchedule
{
    public partial class PointsExpectedInWeeks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (Session["KMDI_ffm_acct"].ToString() == "Guest" || Session["KMDI_ffm_acct"].ToString() == "None")
                {
                    ScriptManager.RegisterStartupScript(this, Page.GetType(), "script", "alert('invalid access!');", true);
                }
                else
                {
                    if (!IsPostBack)
                    {
                        tableData();
                    }
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
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

        protected void linkNotrequested_Click(object sender, EventArgs e)
        {
            gridData("NotRequested");
            highlight(pnlNotrequested);
        }

        protected void linkRequested_Click(object sender, EventArgs e)
        {
            gridData("Requested");
            highlight(pnlRequested);
        }
        private void highlight(Panel p)
        {
            pnlFabricated.Visible = false;
            pnlNotrequested.Visible = false;
            pnlOngoing.Visible = false;
            pnlRequested.Visible = false;
            pnlSDathand.Visible = false;
            pnlTotalproject.Visible = false;
            pnlDelivered.Visible = false;
            p.Visible = true;
        }
        private void gridData(string command)
        {

            DataTable tb = new DataTable();
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    DataSet ds = new DataSet();
                    sqlcon.Open();

                    sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                    sqlcmd.CommandText = "SD_TO_RECEIVE_ALU_STP";

                    sqlcmd.Parameters.AddWithValue("@Command", command);
                    sqlcmd.Parameters.AddWithValue("@Product_Classification", ddlProduct_Classification.SelectedValue.ToString());
                    using (SqlDataAdapter da = new SqlDataAdapter())
                    {
                        da.SelectCommand = sqlcmd;
                        da.Fill(ds);
                        ViewState["tb"] = ds;
                        GridView1.DataSource = ds;
                        GridView1.DataBind();
                    }
                    ViewState["command"] = command;
                }
            }
        }
        private void tableData()
        {


            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    DataSet ds = new DataSet();
                    sqlcon.Open();

                    sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                    sqlcmd.CommandText = "SD_TO_RECEIVE_ALU_STP";
                    sqlcmd.Parameters.AddWithValue("@Command", "tableData");
                    sqlcmd.Parameters.AddWithValue("@Product_Classification", ddlProduct_Classification.SelectedValue.ToString());
                    using (SqlDataReader rd = sqlcmd.ExecuteReader())
                    {
                        while (rd.Read())
                        {
                            linkNotrequested.Text = rd[0].ToString();
                            linkRequested.Text = rd[1].ToString();
                            linkSDathand.Text = rd[2].ToString();
                            linkOngoing.Text = rd[3].ToString();
                            linkTotalproject.Text = rd[4].ToString();
                            linkDelivered.Text = rd[5].ToString();
                            linkFabricated.Text = rd[6].ToString();
                            linkReceivedSD.Text = rd[7].ToString();
                            lbl1.Text = ddlProduct_Classification.SelectedItem.ToString();
                            lbl2.Text = ddlProduct_Classification.SelectedItem.ToString();
                            lbl3.Text = ddlProduct_Classification.SelectedItem.ToString();
                            lbl4.Text = ddlProduct_Classification.SelectedItem.ToString();
                            lbl5.Text = ddlProduct_Classification.SelectedItem.ToString();
                            lbl6.Text = ddlProduct_Classification.SelectedItem.ToString();
                            lbl72.Text = ddlProduct_Classification.SelectedItem.ToString();
                        }
                    }
                }
            }

        }

        protected void linkSDathand_Click(object sender, EventArgs e)
        {
            gridData("SD_at_hand");
            highlight(pnlSDathand);
        }

        protected void linkOngoing_Click(object sender, EventArgs e)
        {
            gridData("Ongoing_Fab_scheduled");
            highlight(pnlOngoing);
        }

        protected void linkFabricated_Click(object sender, EventArgs e)
        {
            gridData("Total_Points_Fabricated");
            highlight(pnlFabricated);
        }

        protected void linkDelivered_Click(object sender, EventArgs e)
        {
            gridData("Total_Points_Delivered");
            highlight(pnlDelivered);

        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            gridData(ViewState["command"].ToString());
        }

        protected void linkTotalproject_Click(object sender, EventArgs e)
        {
            gridData("Total_Contract_Points");
            highlight(pnlTotalproject);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            tableData();
        }

        protected void ddlProduct_Classification_SelectedIndexChanged(object sender, EventArgs e)
        {
            tableData();
        }
    }
}