using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.Delivery.ScannedDR
{
    public partial class DRuploadsSummary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["DRscannedsummary_Key"] != null)
                {
                    TBOXsearchkey.Text = Session["DRscannedsummary_Key"].ToString();
                }
                if (Session["DRscannedsummary_Folder"] != null)
                {
                    DDLfolder.Text = Session["DRscannedsummary_Folder"].ToString();
                }
                if (Session["DRscannedsummary_Date"] != null)
                {
                    TBOXdate.Text = Session["DRscannedsummary_Date"].ToString();
                }
                if (Session["DRscannedsummary_Check"] != null)
                {
                    CheckBox1.Checked = Convert.ToBoolean(Session["DRscannedsummary_Check"]);
                }
                loaddata();
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
        private void loaddata()
        {
            try
            {


                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "dr_scannedfile_summary";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@searchkey", TBOXsearchkey.Text);
                        sqlcmd.Parameters.AddWithValue("@udate", TBOXdate.Text);
                        sqlcmd.Parameters.AddWithValue("@udatecheck", CheckBox1.Checked.ToString());
                        sqlcmd.Parameters.AddWithValue("@folder", DDLfolder.Text);
                        DataTable tb = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();
                        Session["DRscannedsummary_Key"] = TBOXsearchkey.Text;
                        Session["DRscannedsummary_Check"] = CheckBox1.Checked;
                        Session["DRscannedsummary_Folder"] = DDLfolder.Text;
                        Session["DRscannedsummary_Date"] = TBOXdate.Text;
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
            loaddata();
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "viewfile")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Response.Redirect(((Label)row.FindControl("lblfilepath")).Text + ((LinkButton)row.FindControl("lbtnfilename")).Text);
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            loaddata();
        }
    }
}