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
    public partial class recommendation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null && (usercode == "Production Engineer" || usercode == "Admin"))
            {
                if (!IsPostBack)
                {
                    loadReason();
                    loadKno();
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private string NFII_ID
        {
            get
            {
                return Session["NFII_ID"].ToString();
            }
        }

        private string sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
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

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                validateinput();
                update();
            }
        }
        private void validateinput()
        {
            TboxCompletionDate.Text = TboxCompletionDate.Text.Replace("'", "`");
            TboxCompletionDate.Text = TboxCompletionDate.Text.Replace("\"", "``");
            TboxRecommendation.Text = TboxRecommendation.Text.Replace("'", "`");
            TboxRecommendation.Text = TboxRecommendation.Text.Replace("\"", "``");
        }
        private void loadKno()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "NOTICE_FOR_INCOMPLETE_ITEM_LIST_STP";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "GetDataForEdit");
                        sqlcmd.Parameters.AddWithValue("@NFII_ID",NFII_ID);
                        GridView1.DataSource = sqlcmd.ExecuteReader();
                        GridView1.DataBind();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        private void loadReason()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "NOTICE_FOR_INCOMPLETE_ITEM_STP";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "forRecommendation");
                        sqlcmd.Parameters.AddWithValue("@ID", NFII_ID);
                        GridView2.DataSource = sqlcmd.ExecuteReader();
                        GridView2.DataBind();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        private void update()
        {
            using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "NOTICE_FOR_INCOMPLETE_ITEM_STP";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Recommendation");
                        sqlcmd.Parameters.AddWithValue("@ID", Session["NFII_ID"].ToString());
                        sqlcmd.Parameters.AddWithValue("@Recommendation", TboxRecommendation.Text);
                        sqlcmd.Parameters.AddWithValue("@Completion_Date",TboxCompletionDate.Text);
                        sqlcmd.ExecuteNonQuery();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                    finally
                    {
                        Response.Redirect("~/KMDIweb/Production/FrameSchedule/NoticeForIncompleteItemsReportPaage.aspx");
                    }
                }
            }
        }

      
    }
}