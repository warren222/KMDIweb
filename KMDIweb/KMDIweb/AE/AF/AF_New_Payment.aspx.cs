using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using KMDIweb.SCREENfab;

namespace KMDIweb.KMDIweb.AE.AF
{
    public partial class AF_New_Payment : System.Web.UI.Page
    {
        string _identifier = "", _account_Exec_Incharge = "", _request = ""
            , _particular = "", _payType = "", _payment_Id = "", _parentjono = ""
            , _payment = "", _af_releasing = "", _payment_date = "";

        protected void gvAF_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAF.PageIndex = e.NewPageIndex;
            Loaddata();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["KMDI_userid"] != null)
                {
                    if (!IsPostBack)
                    {
                        if (Session["KMDI_fullname"].ToString() == "Genalyn Garcia")
                        {
                            Response.Redirect("~/KMDIweb/AE/AF/AF_For_Approval.aspx");
                        }
                        else if (Session["KMDI_fullname"].ToString() == "Jayvey Manalili")
                        {
                            Response.Redirect("~/KMDIweb/AE/AF/AF_For_Checking.aspx");
                        }
                        if (Session["KMDI_user_code"].ToString() == "AE")
                        {
                            lblAE.Visible = false;
                            ddlAE.Visible = false;
                        }
                        else
                        {
                            lblAE.Visible = true;
                            ddlAE.Visible = true;
                        }

                        Loadae();
                        Loaddata();
                    }
                }
                else
                {
                    Response.Redirect("~/KMDIweb/Global/Login.aspx");
                }
            }
        }
        private string Sqlconstr
        {
            get
            {
                return ConnectionString.sqlconstr();
            }
        }
        private void Errorrmessage(string message)
        {
            CustomValidator err = new CustomValidator();
            err.ValidationGroup = "errorval";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        private void Loadae()
        {
            using (SqlConnection sqlcon = new SqlConnection(Sqlconstr))
            {
                using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                {
                    try
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "AF_New_Payment_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "AE_List");
                        ddlAE.DataSource = sqlcmd.ExecuteReader();
                        ddlAE.DataTextField = "fullname";
                        ddlAE.DataValueField = "fullname";
                        ddlAE.DataBind();
                    }
                    catch (Exception e)
                    {
                        Errorrmessage(e.Message);
                    }
                }
            }
        }
        private string Ae()
        {
            string fullname = Session["KMDI_fullname"].ToString();
            string user_code = Session["KMDI_user_code"].ToString();
            if (user_code == "AE")
            {
                return fullname;
            }
            else
            {
                return ddlAE.Text;
            }
        }
        private void Loaddata()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(Sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        DataTable tb = new DataTable();
                        tb.Clear();
                        sqlcon.Open();
                        sqlcmd.CommandText = "AF_New_Payment_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Get");
                        sqlcmd.Parameters.AddWithValue("@Search", tboxSearch.Text);
                        sqlcmd.Parameters.AddWithValue("@AE", Ae());
                        using (SqlDataAdapter da = new SqlDataAdapter())
                        {
                            da.SelectCommand = sqlcmd;
                            da.Fill(tb);
                            gvAF.DataSource = tb;
                            gvAF.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Errorrmessage(ex.ToString());
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Loaddata();
        }

        private void Send_Request()
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(Sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "AF_New_Payment_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Insert");
                        sqlcmd.Parameters.AddWithValue("@Parentjono", _parentjono);
                        sqlcmd.Parameters.AddWithValue("@Identifier", _identifier);
                        sqlcmd.Parameters.AddWithValue("@Account_Exec_Incharge", _account_Exec_Incharge);
                        sqlcmd.Parameters.AddWithValue("@Request", _request);
                        sqlcmd.Parameters.AddWithValue("@Particular", _particular);
                        sqlcmd.Parameters.AddWithValue("@Payment_Id", _payment_Id);
                        sqlcmd.Parameters.AddWithValue("@Paytype", _payType);
                        sqlcmd.Parameters.AddWithValue("@Payment_Amount", _payment);
                        sqlcmd.Parameters.AddWithValue("@Payment_Date", _payment_date);
                        sqlcmd.Parameters.AddWithValue("@AF_Releasing", _af_releasing);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Errorrmessage(ex.ToString());
            }
            finally
            {
                Loaddata();
            }
        }

        protected void gvAF_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "send_request")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = gvAF.Rows[rowindex];
                _identifier = ((Label)row.FindControl("lblIdentifier")).Text;
                _request = ((DropDownList)row.FindControl("ddlRequest")).Text;
                _particular = ((TextBox)row.FindControl("tboxParticular")).Text;
                _payType = ((Label)row.FindControl("lblPayType")).Text;
                _payment_Id = ((Label)row.FindControl("lblPayment_Id")).Text;
                _parentjono = ((Label)row.FindControl("lblParentjono")).Text;
                _payment = ((Label)row.FindControl("lblPayment")).Text;
                _payment_date = ((Label)row.FindControl("lblPaymentDate")).Text;
                _af_releasing = ((Label)row.FindControl("lblAFReleasing")).Text;
                _account_Exec_Incharge = Session["KMDI_fullname"].ToString();
                Send_Request();
            }
        }
    }
}