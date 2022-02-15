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

namespace KMDIweb.KMDIweb.Installation
{
    public partial class InstallationSchedule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (!IsPostBack)
                {

                    tboxSdate.Text = DateTime.Today.ToString("yyyy-MM-dd");
                    tboxEdate.Text = DateTime.Today.ToString("yyyy-MM-dd");
                    tboxDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
                    loaddata();
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private string myName
        {
            get
            {
                return Session["KMDI_fullname"].ToString();
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
                        DataTable tb = new DataTable();
                        sqlcon.Open();
                        sqlcmd.CommandText = "installation_schedule_stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "load");
                        sqlcmd.Parameters.AddWithValue("@Sdate", tboxSdate.Text);
                        sqlcmd.Parameters.AddWithValue("@Edate", tboxEdate.Text);
                        sqlcmd.Parameters.AddWithValue("@Search", tboxSearch.Text);
                        sqlcmd.Parameters.AddWithValue("@fullname", Session["KMDI_fullname"].ToString());
                        sqlcmd.Parameters.AddWithValue("@user_code", Session["KMDI_user_code"].ToString());

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
                errorrmessage(ex.Message.ToString());
            }
        }
        private void loadkno(string parentjono)
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        DataTable tb = new DataTable();
                        sqlcon.Open();
                        sqlcmd.CommandText = "installation_schedule_stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "kno");
                        sqlcmd.Parameters.AddWithValue("@parentjono", parentjono);
                        sqlcmd.Parameters.AddWithValue("@kmdi_no", ddlkno.Text);
                        sqlcmd.Parameters.AddWithValue("@location", ddllocation.Text);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView2.DataSource = tb;
                        GridView2.DataBind();
                        ViewState["tb"] = tb;
                        cboxFrame.Checked = false;
                        cboxSash.Checked = false;
                        cboxGlass.Checked = false;
                        cboxFoam.Checked = false;
                        cboxSealant.Checked = false;
                        cboxPlastic.Checked = false;
                        cboxScreen.Checked = false;
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
        private void distinctknolocation(string parentjono)
        {
            tboxDate.Text = Convert.ToDateTime(ViewState["lblStart"].ToString()).ToString("yyyy-MM-dd");
            distinctkno(parentjono);
            distinctlocation(parentjono);
        }
        private void distinctkno(string parentjono)
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        DataTable tb = new DataTable();
                        sqlcmd.CommandText = "installation_schedule_stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "distinct_kno");
                        sqlcmd.Parameters.AddWithValue("@parentjono", parentjono);
                        ddlkno.DataSource = sqlcmd.ExecuteReader();
                        ddlkno.DataValueField = "kmdi_no";
                        ddlkno.DataTextField = "kmdi_no";
                        ddlkno.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
        private void distinctlocation(string parentjono)
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    sqlcon.Open();
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        DataTable tb = new DataTable();
                        sqlcmd.CommandText = "installation_schedule_stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "distinct_location");
                        sqlcmd.Parameters.AddWithValue("@parentjono", parentjono);
                        ddllocation.DataSource = sqlcmd.ExecuteReader();
                        ddllocation.DataValueField = "location";
                        ddllocation.DataTextField = "location";
                        ddllocation.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
        private void loadNonproductiveActivity(string parentjono)
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        DataTable tb = new DataTable();
                        sqlcon.Open();
                        sqlcmd.CommandText = "Nonproductive_Activity_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Load");
                        sqlcmd.Parameters.AddWithValue("@parentjono", parentjono);
                        SqlDataAdapter da = new SqlDataAdapter();
                        da.SelectCommand = sqlcmd;
                        da.Fill(tb);
                        GridView3.DataSource = tb;
                        GridView3.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            loaddata();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            loaddata();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            PNLschedule.Visible = true;
            PNLkno.Visible = false;
            Panel4.Visible = true;
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "loadkno")
            {

                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                loadkno(((Label)row.FindControl("lblparentjono")).Text);
                loadNonproductiveActivity(((Label)row.FindControl("lblparentjono")).Text);
                ViewState["parentjono"] = ((Label)row.FindControl("lblparentjono")).Text;
                ViewState["installers"] = ((Label)row.FindControl("lblinstallershidden")).Text.Replace("\n", ", ");
                ViewState["lblStart"] = ((Label)row.FindControl("lblStart")).Text;
                lblProjectS2.Text = ((LinkButton)row.FindControl("BTNkno")).Text;
                lblAddressS2.Text = ((Label)row.FindControl("lblAddress")).Text;
                lblInstructions.Text = ((Label)row.FindControl("lblinstruction")).Text;
                if (((Label)row.FindControl("lblinstruction")).Text != "")
                {
                    lblWarning.Text = "Attention!";
                }
                else
                {
                    lblWarning.Text = "";
                }
                PNLschedule.Visible = false;
                PNLkno.Visible = true;
                Panel4.Visible = false;
                distinctknolocation(((Label)row.FindControl("lblparentjono")).Text);
            }
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            List<int> l = new List<int>();
            if ((List<int>)ViewState["listid"] == null)
            {
                l.Add(0);
            }
            else
            {
                l = ViewState["listid"] as List<int>;
            }
            foreach (GridViewRow row in GridView2.Rows)
            {
                CheckBox cbk = (CheckBox)row.FindControl("cboxselect");
                if (cbk.Checked == true)
                {
                    int x = int.Parse(((Label)row.FindControl("lblid")).Text.ToString());
                    if (!l.Contains(x))
                    {
                        l.Add(x);
                    }
                }
                else
                {
                    int x = int.Parse(((Label)row.FindControl("lblid")).Text.ToString());
                    if (l.Contains(x))
                    {
                        l.Remove(x);
                    }
                }
            }
            Session["listKno"] = listKno(l);

            List<kmdino> li = new List<kmdino>();
            li = (List<kmdino>)Session["listKno"];

            foreach (var data in li)
            {
                updateKno(data.jo, data.kmdi_no);
            }
            loadkno(ViewState["parentjono"].ToString());
        }
        //private string updateSetter()
        //{
        //    string frame = "";
        //    string sash = "";
        //    string glass = "";
        //    string foam = "";
        //    string setter = "";
        //    string sealant = "";
        //    string plastic = "";
        //    string handle = "";
        //    string screen = "";


        //    string mydate = "";
        //    string instl = "";


        //    mydate = "format(getdate(),'MMMM dd, yyyy')";
        //    instl = installers;


        //    frame = cboxFrame.Checked == true ? ", Frame =" + mydate + ", FRAME_INSTALLER = '" + instl + "'" : "";
        //    sash = cboxSash.Checked == true ? ", Sash =" + mydate + ", SASH_INSTALLER = '" + instl + "'" : "";
        //    glass = cboxGlass.Checked == true ? ", Glass =" + mydate + ", GLASS_INSTALLER = '" + instl + "'" : "";
        //    foam = cboxFoam.Checked == true ? ", Foam =" + mydate + ", FOAM_INSTALLER = '" + instl + "'" : "";
        //    sealant = cboxSealant.Checked == true ? ", Sealant =" + mydate + ", SEALANT_INSTALLER = '" + instl + "'" : "";
        //    handle = cboxHandle.Checked == true ? ", I_Handle =" + mydate + ", I_HANDLE_INSTALLER = '" + instl + "'" : "";
        //    plastic = cboxPlastic.Checked == true ? ", Plastic =" + mydate + ", PLASTIC_INSTALLER = '" + instl + "'" : "";
        //    screen = cboxScreen.Checked == true ? ", Screens =" + mydate + ", SCREENS_INSTALLER = '" + instl + "'" : "";

        //    setter = (frame + sash + glass + foam + sealant + handle + plastic + screen).Trim();
        //    if (setter.Length > 2)
        //    {
        //        setter = setter.Remove(0, 2);
        //    }
        //    return setter;
        //}
        private void updateKno(string jo, string kno)
        {

            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    string mydate = "format(getdate(),'MMMM dd, yyyy')";
                    string instl = installers;
                    string conditions = "  where job_order_no = '" + jo + "' and kmdi_no = '" + kno + "' ";

                    string frame = cboxFrame.Checked == true ? " update KMDI_INSTALLATION_TB set Frame =" + mydate + ", FRAME_INSTALLER = '" + instl + "' " + conditions + " and Frame='' " : "";
                    string sash = cboxSash.Checked == true ? "  update KMDI_INSTALLATION_TB set Sash =" + mydate + ", SASH_INSTALLER = '" + instl + "' " + conditions + " and Sash = '' " : "";
                    string glass = cboxGlass.Checked == true ? "  update KMDI_INSTALLATION_TB set Glass =" + mydate + ", GLASS_INSTALLER = '" + instl + "' " + conditions + " and Glass = '' " : "";
                    string foam = cboxFoam.Checked == true ? "  update KMDI_INSTALLATION_TB set Foam =" + mydate + ", FOAM_INSTALLER = '" + instl + "' " + conditions + " and FOAM = '' " : "";
                    string sealant = cboxSealant.Checked == true ? "  update KMDI_INSTALLATION_TB set Sealant =" + mydate + ", SEALANT_INSTALLER = '" + instl + "' " + conditions + " and SEALANT = '' " : "";
                    string plastic = cboxPlastic.Checked == true ? "  update KMDI_INSTALLATION_TB set Plastic =" + mydate + ", PLASTIC_INSTALLER = '" + instl + "' " + conditions + " and PLASTIC = '' " : "";
                    string handle = cboxHandle.Checked == true ? "  update KMDI_INSTALLATION_TB set I_Handle =" + mydate + ", I_HANDLE_INSTALLER = '" + instl + "' " + conditions + " and I_HANDLE = '' " : "";
                    string screen = cboxScreen.Checked == true ? "  update KMDI_INSTALLATION_TB set Screens =" + mydate + ", SCREENS_INSTALLER = '" + instl + "' " + conditions + " and SCREENS = '' " : "";


                    string setter = frame + sash + glass + foam + sealant + handle + plastic + screen;
                    if (setter.Trim() == "")
                    {

                    }
                    else
                    {
                        string str = " update KMDI_INSTALLATION_TB set UPDATED_BY = '" + myName + " '+format(getdate(),'MMMM dd, yyyy hh:mm:ss tt') " + conditions + "";
                        using (SqlCommand sqlcmd = new SqlCommand(setter + str, sqlcon))
                        {
                            sqlcon.Open();
                            sqlcmd.ExecuteNonQuery();
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
        }
        private void updateSingle(string column, string installerStr, string jo, string kno)
        {
            DateTime d;
            d = Convert.ToDateTime(tboxDate.Text);
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {

                    string str = " update KMDI_INSTALLATION_TB set " + column + "='" + d.ToString("MMMM dd, yyyy") + "', " + installerStr + " = '" + installers + "', UPDATED_BY = '" + myName + " '+format(getdate(),'MMMM dd, yyyy hh:mm:ss tt') where job_order_no = '" + jo + "' and kmdi_no = '" + kno + "' ";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                InsertLog(column, jo, kno, "Check", d.ToString("MMMM dd, yyyy"));
                loadkno(ViewState["parentjono"].ToString());
            }
        }
        private void clearUpdate(string column, string jo, string kno, string section)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    string str = "update KMDI_INSTALLATION_TB set " + column + ", UPDATED_BY = '" + myName + " '+format(getdate(),'MMMM dd, yyyy hh:mm:ss tt') where job_order_no = '" + jo + "' and kmdi_no = '" + kno + "'";
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                InsertLog(section, jo, kno, "Uncheck", "");
                loadkno(ViewState["parentjono"].ToString());
            }
        }
        private void InsertLog(string column, string jo, string kno, string action_made, string value)
        {
            try
            {
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        sqlcon.Open();
                        sqlcmd.CommandText = "Installation_Update_Log_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Insert");
                        sqlcmd.Parameters.AddWithValue("@JO_No", jo);
                        sqlcmd.Parameters.AddWithValue("@K_No", kno);
                        sqlcmd.Parameters.AddWithValue("@Station", column);
                        sqlcmd.Parameters.AddWithValue("@Updated_By", myName);
                        sqlcmd.Parameters.AddWithValue("@Action_Made", action_made);
                        sqlcmd.Parameters.AddWithValue("@Value", value);
                        sqlcmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }

        }
        private string installers
        {
            get
            {
                return ViewState["installers"].ToString();
            }
        }
        private DataTable mytb
        {
            get
            {
                return (DataTable)ViewState["tb"];
            }
        }
        private List<kmdino> listKno(List<int> l)
        {
            List<kmdino> knoList = new List<kmdino>();
            try
            {
                for (int i = 0; i <= mytb.Rows.Count - 1; i++)
                {
                    int id = Convert.ToInt32(mytb.Rows[i]["id"].ToString());
                    if (l.Contains(id))
                    {

                        kmdino k = new kmdino();
                        k.kmdi_no = mytb.Rows[i]["kmdi_no"].ToString();
                        k.jo = mytb.Rows[i]["job_order_no"].ToString();
                        knoList.Add(k);
                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            return knoList;
        }

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
            GridViewRow row = GridView2.Rows[rowindex];
            string kno = ((Label)row.FindControl("lblkmdi")).Text;
            string jo = ((Label)row.FindControl("lbljoborderno")).Text;

            lblmodalKno.Text = ((Label)row.FindControl("lblkmdi")).Text;
            lblmodalLocation.Text = ((Label)row.FindControl("lbllocation")).Text;

            if (e.CommandName == "Frame")
            {
                lblmodalHeader.Text = "Frame Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblframeInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }


            else if (e.CommandName == "Sash")
            {
                lblmodalHeader.Text = "Sash Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblsashInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "Glass")
            {
                lblmodalHeader.Text = "Glass Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblglassInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "Foam")
            {
                lblmodalHeader.Text = "Foam Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblfoamInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "GlassUSeal")
            {
                lblmodalHeader.Text = "Glass U Seal Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblglassUSealInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "AddlReinf")
            {
                lblmodalHeader.Text = "Addl Reinf Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lbladdlReinfInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "Striker")
            {
                lblmodalHeader.Text = "Striker Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblstrikerInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "SealingBlock")
            {
                lblmodalHeader.Text = "Sealing Block Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblsealingBlockInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "Acc1646")
            {
                lblmodalHeader.Text = "1646 Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblacc1646Installer")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "AntiLiftDevice")
            {
                lblmodalHeader.Text = "Anti-Lift Device Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblantiLiftDeviceInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "Acc6059")
            {
                lblmodalHeader.Text = "6059 Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblacc16059Installer")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "BufferStopper")
            {
                lblmodalHeader.Text = "Buffer Stopper Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblbufferStopperInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "PVCMilledWReinf")
            {
                lblmodalHeader.Text = "PVC Milled with Reinf Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblpVCMilledWReinfInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "MilledSnapper")
            {
                lblmodalHeader.Text = "Milled Snapper Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblmilledSnapperInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "Sealant")
            {
                lblmodalHeader.Text = "Sealant Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblsealantInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "SealantOut")
            {
                lblmodalHeader.Text = "Sealant Out Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblsealantOutInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "Plastic")
            {
                lblmodalHeader.Text = "Plastic Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblplasticInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "Cleaning")
            {
                lblmodalHeader.Text = "Cleaning Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblcleaningInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "Handle")
            {
                lblmodalHeader.Text = "Handle Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblihandleInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "Screen")
            {
                lblmodalHeader.Text = "Screen Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblscreenInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "XBars")
            {
                lblmodalHeader.Text = "X Bars Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblxBarsInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }
            else if (e.CommandName == "FinalCleaning")
            {
                lblmodalHeader.Text = "Final Cleaning Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblfinalCleaningInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }
            else if (e.CommandName == "FinalQC")
            {
                lblmodalHeader.Text = "Final QC Installers";
                lblmodalInstallers.Text = ((Label)row.FindControl("lblfinalQCInstaller")).Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "$('#myModal').modal()", true);
            }

            else if (e.CommandName == "ClearFrame")
            {
                clearUpdate("Frame='',Frame_Installer=''", jo, kno, "Frame");
            }
            else if (e.CommandName == "ClearSash")
            {
                clearUpdate("Sash='',Sash_Installer=''", jo, kno, "Sash");
            }
            else if (e.CommandName == "ClearGlass")
            {
                clearUpdate("Glass='',Glass_Installer=''", jo, kno, "Glass");
            }
            else if (e.CommandName == "ClearGlassUSeal")
            {
                clearUpdate("Glass_U_Seal='',Glass_U_Seal_Installer=''", jo, kno, "Glass_U_Seal");
            }
            else if (e.CommandName == "ClearAddlReinf")
            {
                clearUpdate("Addl_Reinf='',Addl_Reinf_Installer=''", jo, kno, "Addl_Reinf");
            }
            else if (e.CommandName == "ClearStriker")
            {
                clearUpdate("Striker='',Striker_Installer=''", jo, kno, "Striker");
            }
            else if (e.CommandName == "ClearSealingBlock")
            {
                clearUpdate("Sealing_Block='',Sealing_Block_Installer=''", jo, kno, "Sealing_Block");
            }
            else if (e.CommandName == "ClearAcc1646")
            {
                clearUpdate("Acc_1646='',Acc_1646_Installer=''", jo, kno, "Acc_1646");
            }
            else if (e.CommandName == "ClearAntiLiftDevice")
            {
                clearUpdate("Anti_Lift_Device='',Anti_Lift_Device_Installer=''", jo, kno, "Anti_Lift_Device");
            }
            else if (e.CommandName == "ClearAcc6059")
            {
                clearUpdate("Acc_6059='',Acc_6059_Installer=''", jo, kno, "Acc_6059");
            }
            else if (e.CommandName == "ClearBufferStopper")
            {
                clearUpdate("Buffer_Stopper='',Buffer_Stopper_Installer=''", jo, kno, "Buffer_Stopper");
            }
            else if (e.CommandName == "ClearPVCMilledWReinf")
            {
                clearUpdate("PVC_Milled_W_Reinf='',PVC_Milled_W_Reinf_Installer=''", jo, kno, "PVC_Milled_W_Reinf");
            }
            else if (e.CommandName == "ClearMilledSnapper")
            {
                clearUpdate("Milled_Snapper='',Milled_Snapper_Installer=''", jo, kno, "Milled_Snapper");
            }
            else if (e.CommandName == "ClearFoam")
            {
                clearUpdate("Foam='',Foam_Installer=''", jo, kno, "Foam");
            }
            else if (e.CommandName == "ClearSealant")
            {
                clearUpdate("Sealant='',Sealant_Installer=''", jo, kno, "Sealant");
            }
            else if (e.CommandName == "ClearSealantOut")
            {
                clearUpdate("Sealant_Out='',Sealant_Out_Installer=''", jo, kno, "Sealant_Out");
            }
            else if (e.CommandName == "ClearPlastic")
            {
                clearUpdate("Plastic='',Plastic_Installer=''", jo, kno, "Plastic");
            }
            else if (e.CommandName == "ClearCleaning")
            {
                clearUpdate("Cleaning='',Cleaning_Installer=''", jo, kno, "Cleaning");
            }
            else if (e.CommandName == "ClearHandle")
            {
                clearUpdate("I_Handle='',I_Handle_Installer=''", jo, kno, "I_Handle");
            }
            else if (e.CommandName == "ClearScreens")
            {
                clearUpdate("Screens='',Screens_Installer=''", jo, kno, "Screens");
            }
            else if (e.CommandName == "ClearXBars")
            {
                clearUpdate("X_Bars='',X_Bars_Installer=''", jo, kno, "X_Bars");
            }
            else if (e.CommandName == "ClearFinalCleaning")
            {
                clearUpdate("Final_Cleaning='',Final_Cleaning_Installer=''", jo, kno, "Final_Cleaning");
            }
            else if (e.CommandName == "ClearFinalQC")
            {
                clearUpdate("Final_QC='',Final_QC_Installer=''", jo, kno, "Final_QC");
            }



            else if (e.CommandName == "UpdateFrame")
            {
                updateSingle("Frame", "Frame_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateSash")
            {
                updateSingle("Sash", "Sash_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateGlass")
            {
                updateSingle("Glass", "Glass_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateGlassUSeal")
            {
                updateSingle("Glass_U_Seal", "Glass_U_Seal_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateAddlReinf")
            {
                updateSingle("Addl_Reinf", "Addl_Reinf_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateStriker")
            {
                updateSingle("Striker", "Striker_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateSealingBlock")
            {
                updateSingle("Sealing_Block", "Sealing_Block_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateAcc1646")
            {
                updateSingle("Acc_1646", "Acc_1646_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateAntiLiftDevice")
            {
                updateSingle("Anti_Lift_Device", "Anti_Lift_Device_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateAcc6059")
            {
                updateSingle("Acc_6059", "Acc_6059_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateBufferStopper")
            {
                updateSingle("Buffer_Stopper", "Buffer_Stopper_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdatePVCMilledWReinf")
            {
                updateSingle("PVC_Milled_W_Reinf", "PVC_Milled_W_Reinf_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateMilledSnapper")
            {
                updateSingle("Milled_Snapper", "Milled_Snapper_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateFoam")
            {
                updateSingle("Foam", "Foam_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateSealant")
            {
                updateSingle("Sealant", "Sealant_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateSealantOut")
            {
                updateSingle("Sealant_Out", "Sealant_Out_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdatePlastic")
            {
                updateSingle("Plastic", "Plastic_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateCleaning")
            {
                updateSingle("Cleaning", "Cleaning_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateHandle")
            {
                updateSingle("I_Handle", "I_Handle_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateScreen")
            {
                updateSingle("Screens", "Screens_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateXBars")
            {
                updateSingle("X_Bars", "X_Bars_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateFinalCleaning")
            {
                updateSingle("Final_Cleaning", "Final_Cleaning_Installer", jo, kno);
            }
            else if (e.CommandName == "UpdateFinalQC")
            {
                updateSingle("Final_QC", "Final_QC_Installer", jo, kno);
            }
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            addActivity(ddlActivity.Text);
        }
        private void addActivity(string activity)
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {
                        DataTable tb = new DataTable();
                        sqlcon.Open();
                        sqlcmd.CommandText = "Nonproductive_Activity_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Create");
                        sqlcmd.Parameters.AddWithValue("@Activity", activity);
                        sqlcmd.Parameters.AddWithValue("@ParentJono", ViewState["parentjono"].ToString());
                        sqlcmd.Parameters.AddWithValue("@Installers", ViewState["installers"].ToString());
                        sqlcmd.Parameters.AddWithValue("@Date", tboxDate.Text);
                        sqlcmd.ExecuteNonQuery();

                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                loadNonproductiveActivity(ViewState["parentjono"].ToString());
            }
        }
        protected void GridView3_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
            GridViewRow row = GridView3.Rows[rowindex];
            string id = ((Label)row.FindControl("lblId")).Text;

            if (e.CommandName == "myDelete")
            {
                deleteActivity(id);
            }
        }
        private void deleteActivity(string id)
        {
            try
            {

                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = sqlcon.CreateCommand())
                    {

                        sqlcon.Open();
                        sqlcmd.CommandText = "Nonproductive_Activity_Stp";
                        sqlcmd.CommandType = CommandType.StoredProcedure;
                        sqlcmd.Parameters.AddWithValue("@Command", "Delete");
                        sqlcmd.Parameters.AddWithValue("@Id", id);
                        sqlcmd.ExecuteNonQuery();

                    }
                }
            }
            catch (Exception ex)
            {
                errorrmessage(ex.Message.ToString());
            }
            finally
            {
                loadNonproductiveActivity(ViewState["parentjono"].ToString());
            }
        }

        protected void LinkButton5_Click(object sender, EventArgs e)
        {
            addActivity(tboxActivity.Text);
        }

        protected void LinkButton6_Click(object sender, EventArgs e)
        {
            loadkno(ViewState["parentjono"].ToString());
        }
    }
}