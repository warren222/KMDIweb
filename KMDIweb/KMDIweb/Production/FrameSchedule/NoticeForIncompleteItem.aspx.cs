using KMDIweb.KMDIweb.Global.objects;
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
    public partial class NoticeForIncompleteItem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {
                    SelectedData();
                    listData();
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }

        private void listData()
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
                        sqlcmd.Parameters.AddWithValue("@Command", "Get");
                        sqlcmd.Parameters.AddWithValue("@Parentjono", Session["LBLparentjono"].ToString());
                        DataTable tb = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView2.DataSource = tb;
                        GridView2.DataBind();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        private void SelectedData()
        {

            //Session["LBLparentjono"].ToString();
            lblProject.Text = Session["LBLprojectname"].ToString();
            lblAddress.Text = Session["LBLaddress"].ToString();
            GridView1.DataSource = (List<kmdino>)Session["listKno"];
            GridView1.DataBind();

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
        private void errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "errorval";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        protected void saveBTN_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                if (saveBTN.Text == "Submit")
                {
                    if (GridView1.Rows.Count <= 0)
                    {
                        errorrmessage("no k#(s) found! please select items from the progress page.");
                    }
                    else
                    {
                        ExecuteAdd();
                        listData();
                    }
                }
                else if (saveBTN.Text == "Update")
                {
                    ExecuteUpdate();
                    ClearList();
                    SelectedData();
                    listData();
                    cancelFunction();
                }
            }
        }
        private void ClearList()
        {
            List<kmdino> li = new List<kmdino>();
            kmdino k = new kmdino();
            k.Id = "1";
            k.kmdi_no = "2";
            k.Description = "3";
            li.Add(k);
            Session["listKno"] = li;
        }
        private void ExecuteUpdate()
        {
            foreach (GridViewRow row in GridView1.Rows)
            {
                Label id = (Label)row.FindControl("lblId");
                TextBox description = (TextBox)row.FindControl("tboxDescription");
                UpdateItems(id.Text, description.Text);
            }
            UpdateNotice();
        }
        private void ExecuteAdd()
        {
            int x = InsertedID();
            if (x > 0)
            {
                foreach (GridViewRow row in GridView1.Rows)
                {
                    Label kno = (Label)row.FindControl("lblKno");
                    TextBox description = (TextBox)row.FindControl("tboxDescription");
                    InsertItems(x, kno.Text, description.Text);
                }
            }
        }
        private void UpdateNotice()
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
                        sqlcmd.Parameters.AddWithValue("@Command", "Update");
                        sqlcmd.Parameters.AddWithValue("@ID", Session["NFII_ID"].ToString());
                        sqlcmd.Parameters.AddWithValue("@Dated", tboxDate.Text);
                        sqlcmd.Parameters.AddWithValue("@Reason", tboxReason.Text);
                        sqlcmd.ExecuteNonQuery();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        private int InsertedID()
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
                        sqlcmd.Parameters.AddWithValue("@Command", "Insert");
                        sqlcmd.Parameters.AddWithValue("@Parentjono", Session["LBLparentjono"].ToString());
                        sqlcmd.Parameters.AddWithValue("@Dated", tboxDate.Text);
                        sqlcmd.Parameters.AddWithValue("@Reason", tboxReason.Text);
                        sqlcmd.Parameters.AddWithValue("@Prepared_By", myName);
                        sqlcmd.Parameters.AddWithValue("@Approved_By", "");
                        sqlcmd.Parameters.AddWithValue("@Approved_By2", "");
                        return (int)sqlcmd.ExecuteScalar();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                        return 0;
                    }
                }
            }
        }
        private void InsertItems(int NFII_ID, string _kno, string _description)
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
                        sqlcmd.Parameters.AddWithValue("@Command", "Insert");
                        sqlcmd.Parameters.AddWithValue("@NFII_ID", NFII_ID);
                        sqlcmd.Parameters.AddWithValue("@KMDI_NO", _kno);
                        sqlcmd.Parameters.AddWithValue("@_Description", _description);
                        sqlcmd.ExecuteNonQuery();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        private void UpdateItems(string id, string _description)
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
                        sqlcmd.Parameters.AddWithValue("@Command", "Update");
                        sqlcmd.Parameters.AddWithValue("@ID", id);
                        sqlcmd.Parameters.AddWithValue("@_Description", _description);
                        sqlcmd.ExecuteNonQuery();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Report")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView2.Rows[rowindex];
                Session["NFII_ID"] = ((Label)row.FindControl("lblId")).Text;
                Session["NFIIpreparedBy"] = ((Label)row.FindControl("lblg2PreparedBy")).Text;
                Session["NFIInotedBy"] = ((Label)row.FindControl("lblg2NotedBy")).Text;
                Session["AcknowledgedBy"] = ((Label)row.FindControl("lblg2AcknowledgedBy")).Text;
                Response.Redirect("~/KMDIweb/Production/FrameSchedule/NoticeForIncompleteItemsReportPaage.aspx");
            }
            else if (e.CommandName == "EditRecord")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView2.Rows[rowindex];
                Session["NFII_ID"] = ((Label)row.FindControl("lblId")).Text;
                GetDataForEdit();
                tboxDate.Text = ((Label)row.FindControl("lblg2NotFormattedDate")).Text;
                tboxReason.Text = ((Label)row.FindControl("lblg2Reason")).Text;
                if (((Label)row.FindControl("lblg2PreparedBy")).Text == myName)
                {
                    saveBTN.Text = "Update";
                    cancelBtn.Visible = true;
                    GridView2.Visible = false;
                }
                else
                {
                    errorrmessage("You're not authorized to alter this record.");
                }

            }
        }
        private void GetDataForEdit()
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
                        sqlcmd.Parameters.AddWithValue("@NFII_ID", Session["NFII_ID"].ToString());
                        DataTable tb = new DataTable();
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        ViewState["tb"] = tb;
                        Session["listKno"] = passDataToSession();
                        SelectedData();
                    }
                    catch (Exception e)
                    {
                        errorrmessage(e.Message);
                    }
                }
            }
        }
        private DataTable mytb
        {
            get
            {
                return (DataTable)ViewState["tb"];
            }
        }
        private List<kmdino> passDataToSession()
        {
            List<kmdino> li = new List<kmdino>();
            for (int i = 0; i <= mytb.Rows.Count - 1; i++)
            {
                string id, kno, description;
                id = mytb.Rows[i]["id"].ToString();
                kno = mytb.Rows[i]["kmdi_no"].ToString();
                description = mytb.Rows[i]["_Description"].ToString();
                kmdino k = new kmdino();
                k.kmdi_no = kno;
                k.Id = id;
                k.Description = description;
                li.Add(k);
            }
            return li;
        }

        protected void cancelBtn_Click(object sender, EventArgs e)
        {
            cancelFunction();
        }
        private void cancelFunction()
        {
            saveBTN.Text = "Submit";
            cancelBtn.Visible = false;
            GridView2.Visible = true;
            tboxReason.Text = "";
            tboxDate.Text = "";
        }
    }
}