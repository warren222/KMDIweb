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
    public partial class NoticeForIncompleteItemApproval : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    LoadByUser();
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
        private string myName
        {
            get
            {
                return Session["KMDI_fullname"].ToString();
            }
        }
        private string usercode
        {
            get
            {
                return Session["KMDI_user_code"].ToString();
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
        private void LoadByUser()
        {
            if ((usercode == "Delivery Head") || (usercode == "Engineer Manager"))
            {
                loadData("ForApproval");
            }
            else if (usercode == "Production Engineer")
            {
                loadData("ForReceive");
            }
            else if (usercode == "Production Manager")
            {
                loadData("ForNoted");
            }
            else if (usercode == "Engineer" || usercode == "AE" || usercode == "Delivery")
            {
                CheckBox1.Text = "For acknowledgment";
                loadData("ProjectManager");
            }
            else
            {
                CheckBox1.Visible = false;
                loadData("ForView");
            }
        }
        private void loadData(string command)
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        string done = CheckBox1.Checked.ToString();
                        sqlcon.Open();
                        sqlcmd.CommandText = "NOTICE_FOR_INCOMPLETE_ITEM_STP";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", command);
                        sqlcmd.Parameters.AddWithValue("@SearchKey", tboxSearchkey.Text);
                        sqlcmd.Parameters.AddWithValue("@Done", done);
                        sqlcmd.Parameters.AddWithValue("@Fullname", myName);
                        DataTable tb = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView1.DataSource = tb;
                        GridView1.DataBind();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Report")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Session["NFII_ID"] = ((Label)row.FindControl("lblId")).Text;
                Session["LBLparentjono"] = ((Label)row.FindControl("lblParentjono")).Text;
                Session["NFIIpreparedBy"] = ((Label)row.FindControl("lblPreparedBy")).Text;
                Session["NFIInotedBy"] = ((Label)row.FindControl("lblNotedBy")).Text;
                Response.Redirect("~/KMDIweb/Production/FrameSchedule/NoticeForIncompleteItemsReportPaage.aspx");
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            LoadByUser();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            LoadByUser();
        }
    }
}