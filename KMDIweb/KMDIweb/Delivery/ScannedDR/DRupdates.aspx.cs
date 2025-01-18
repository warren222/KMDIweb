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
    public partial class DRupdates : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    Get_Data();
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
        protected void btnFind_Click(object sender, EventArgs e)
        {
            Get_Data();
        }
        private void Get_Data()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "DR_Web_Updates_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Data");
                        sqlcmd.Parameters.AddWithValue("@Find", tboxFind.Text);
                        sqlcmd.Parameters.AddWithValue("@Specification", ddlSpecification.Text);
                        DataTable tb = new DataTable();
                        tb.Clear();
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvList.DataSource = tb;
                            gvList.DataBind();
                        }
                        string row_count = tb.Rows.Count.ToString("N0");
                        lblSpecification.Text = ddlSpecification.Text + (tboxFind.Text == "" ? "" : " / " + tboxFind.Text);
                    }
                    catch (Exception ex)
                    {
                        errorrmessage(ex.ToString());
                    }
                }
            }
        }

        protected void btnFind_Click1(object sender, EventArgs e)
        {
            Get_Data();
        }

        protected void gvList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvList.PageIndex = e.NewPageIndex;
            Get_Data();
        }

        protected void gvList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "viewDR")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvList.Rows[rowindex];
                string filename = ((LinkButton)row.FindControl("btnDR")).Text;
                string filepath = GetFilePath(filename) ;
                if(filepath != "")
                {
                    Response.Redirect(filepath + filename+".pdf");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, GetType(), "warning", "alert('Sorry! No file detected.');", true);
                }
              
            }
        }
        private string GetFilePath(string filename)
        {
            string result = "";
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        try
                        {
                            sqlcon.Open();
                            sqlcmd.CommandText = "DR_Web_Updates_Stp";
                            sqlcmd.CommandType = CommandType.StoredProcedure;
                            sqlcmd.Parameters.AddWithValue("@Command", "Get_Uploaded_Fle_Data");
                            sqlcmd.Parameters.AddWithValue("@FileName", filename);
                            using (SqlDataReader rd = sqlcmd.ExecuteReader())
                            {
                                while (rd.Read())
                                {
                                    result = rd[0].ToString();
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            errorrmessage(ex.ToString());
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            return result;
        }
    }
}