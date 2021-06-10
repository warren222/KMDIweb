using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.DRscannedReports
{
    public partial class DelHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    if (Session["SDRhomeSearchkey"] != null)
                    {
                        TBOXsearchkey.Text = Session["SDRhomeSearchkey"].ToString();
                        GridView1.PageIndex =Convert.ToInt32(Session["SDRhomePageindex"]);
                    }
                    loadae();
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

        protected void BTNsearch_Click(object sender, EventArgs e)
        {
            loaddata();
        }
        private void loadae()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "dr_project_list_stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "loadae");
                        sqlcmd.Parameters.AddWithValue("@ae", ddlae.Text);
                        ddlae.DataSource = sqlcmd.ExecuteReader();
                        ddlae.DataTextField = "fullname";
                        ddlae.DataValueField = "fullname";
                        ddlae.DataBind();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        private void loaddata()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        DataTable tb = new DataTable();
                        tb.Clear();
                        sqlcon.Open();
                        sqlcmd.CommandText = "dr_project_list_stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@command", "load");
                        sqlcmd.Parameters.AddWithValue("@searchkey", TBOXsearchkey.Text);
                        sqlcmd.Parameters.AddWithValue("@ae", ddlae.Text);
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            GridView1.DataSource = tb;
                            GridView1.DataBind();
                        }
                        Session["SDRhomeSearchkey"] = TBOXsearchkey.Text;
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "btnframe")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["DRscannedHome_projectlabel"] = ((Label)row.FindControl("LBLprojectlabel")).Text;
                Session["DRscannedHome_fulladd"] = ((Label)row.FindControl("LBLfulladd")).Text;
                Session["DRscannedHome_parentjono"] = ((Label)row.FindControl("LBLparentjono")).Text;
                Session["DRscannedHome_specification"] = "Frame";
                Response.Redirect("~/KMDIweb/Delivery/ScannedDR/Fileupload.aspx");
            }
            else if (e.CommandName == "btnscreen")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["DRscannedHome_projectlabel"] = ((Label)row.FindControl("LBLprojectlabel")).Text;
                Session["DRscannedHome_fulladd"] = ((Label)row.FindControl("LBLfulladd")).Text;
                Session["DRscannedHome_parentjono"] = ((Label)row.FindControl("LBLparentjono")).Text;
                Session["DRscannedHome_specification"] = "Screen";
                Response.Redirect("~/KMDIweb/Delivery/ScannedDR/Fileupload.aspx");
            }
            else if (e.CommandName == "btnglass")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["DRscannedHome_projectlabel"] = ((Label)row.FindControl("LBLprojectlabel")).Text;
                Session["DRscannedHome_fulladd"] = ((Label)row.FindControl("LBLfulladd")).Text;
                Session["DRscannedHome_parentjono"] = ((Label)row.FindControl("LBLparentjono")).Text;
                Session["DRscannedHome_specification"] = "Glass";
                Response.Redirect("~/KMDIweb/Delivery/ScannedDR/Fileupload.aspx");
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            Session["SDRhomePageindex"] = GridView1.PageIndex;
            loaddata();
        }
    }
}