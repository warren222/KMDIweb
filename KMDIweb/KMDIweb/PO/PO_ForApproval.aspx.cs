using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.PO
{
    public partial class PO_ForApproval : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                getdata();
            }
        }
        private string usercode
        {
            get
            {
                return Session["KMDI_user_code"].ToString();
            }
        }
        private string fullname
        {
            get
            {
                return Session["KMDI_fullname"].ToString();
            }
        }
        private string userRole
        {
            get
            {
                return Session["KMDI_clg_acct"].ToString();
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
        private void getdata()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Web_PO_Approval_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Submitted");
                        sqlcmd.Parameters.AddWithValue("@Search", tboxsearchkey.Text);
                        DataTable tb = new DataTable();
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
                errorrmessage(ex.ToString());
            }
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            getdata();
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            getdata();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "view_request")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                string pono = ((LinkButton)row.FindControl("btnPONO")).Text;
                string jono = ((Label)row.FindControl("lblJONO")).Text;
                Session["POPO_No"] = pono;
                Session["POJO_No"] = jono;
            

                if (get_supplier(pono) == "Ajiya Safety Glass SDN BHD" ||
                    get_supplier(pono) == "Saint Gobain India Private Limited (Vetrotech Business)")
                {
                    Response.Redirect("~/KMDIweb/PO/PO_Ajiya_Rpt.aspx");
                }
                else
                {
                    if (get_computation(jono, pono) == "Laminated")
                    {
                        Response.Redirect("~/KMDIweb/PO/PO_Laminated_Rpt.aspx");
                    }
                    else if (get_computation(jono, pono) == "X")
                    {
                        Response.Redirect("~/KMDIweb/PO/PO_X_Rpt.aspx");
                    }
                    else
                    {
                        Response.Redirect("~/KMDIweb/PO/PO_Rpt.aspx");
                    }
                }

               
            }
        }
        private string get_computation(string jono, string pono)
        {
            string computation = "";
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Web_PO_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Computation");
                        sqlcmd.Parameters.AddWithValue("@JO_No", jono);
                        sqlcmd.Parameters.AddWithValue("@PO_No", pono);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                computation = rd[0].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            return computation;
        }
        private string get_supplier(string pono)
        {
            string supplier = "";
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Web_PO_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get_Supplier");
                        sqlcmd.Parameters.AddWithValue("@PO_No", pono);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                supplier = rd[0].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.ToString());
            }
            return supplier;
        }
    }
}