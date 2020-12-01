using KMDIweb.SCREENfab;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.Delivery.ScannedDR
{
    public partial class Fileupload : System.Web.UI.Page
    {
        string filepath = "~/KMDIweb/Uploads/DRscannedFiles/";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (Session["KMDI_sdr_acct"].ToString() == "Admin")
                {
                    PNLupload.Visible = true;
                }
                else
                {
                    PNLupload.Visible = false;
                }
                TBOXdate.Text = DateTime.Today.ToString("yyyy-MM-dd");
                LBLproject.Text = Session["DRscannedHome_projectlabel"].ToString();
                LBLaddress.Text = Session["DRscannedHome_fulladd"].ToString();
                LBLjo.Text = Session["DRscannedHome_parentjono"].ToString();
                LBLspecification.Text = Session["DRscannedHome_specification"].ToString();
                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath + parentjono + "/" + specification + "/"));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath + parentjono + "/" + specification + "/"));
                }
                if (!IsPostBack)
                {
                    loaddata();
                    if (Session["ErrorMessage"] != null)
                    {
                        errorlbl.Text = Session["ErrorMessage"].ToString();
                        Panel2.Visible = true;
                    }
                    else
                    {
                        Panel2.Visible = false;
                    }
                }
            }
            else
            {
                Response.Redirect("~/KMDIweb/Global/Login.aspx");
            }
        }
        private string parentjono
        {
            get
            {
                return Session["DRscannedHome_parentjono"].ToString();
            }
        }
        private string specification
        {
            get
            {
                return Session["DRscannedHome_specification"].ToString();
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
            err.ValidationGroup = "val1";
            err.IsValid = false;
            err.ErrorMessage = message;
            Page.Validators.Add(err);
        }
        protected void Button1_Click(object sender, EventArgs e)
        {

            if (FileUpload1.HasFile)
            {

                foreach (HttpPostedFile thefile in FileUpload1.PostedFiles)
                {
                    string fileExtension = System.IO.Path.GetExtension(thefile.FileName).ToString().ToLower();

                    if (fileExtension == ".pdf" || fileExtension == ".png" || fileExtension == ".jpeg" || fileExtension == ".jpg")
                    {
                        double filesize = thefile.ContentLength;
                        if (filesize < 29360128)
                        {
                            thefile.SaveAs(Server.MapPath(filepath + parentjono + "/" + specification + "/" + thefile.FileName));
                            Session["ErrorMessage"] = null;
                            string path = filepath + parentjono + "/" + specification + "/";
                            insertnew(thefile.FileName.ToString(), fileExtension, path);

                        }
                        else
                        {
                            CustomValidator err = new CustomValidator();
                            Session["ErrorMessage"] = "You can only upload files of size lesser than 28 MB, but you are uploading a file of " + Math.Round((filesize / 1048576.00), 2) + " MB";
                        }
                    }
                    else
                    {
                        Session["ErrorMessage"] = "invalid file type";
                    }
                }
            }
            else
            {
                Session["ErrorMessage"] = "select pdf or image file first!";
            }
            Response.Redirect("~/KMDIweb/Delivery/ScannedDR/Fileupload.aspx");

        }
        private void insertnew(string filename, string filetype, string path)
        {
            try
            {
                bool has;

                string str = " declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from DR_SCANNED_IMG) " +
                    "insert into DR_SCANNED_IMG (id,parentjono,filename,filetype,path,specification,projectname,udate) values(@id,@parentjono,@filename,@filetype,@path,@specification,@projectname,@udate)";

                string find = "select * from DR_SCANNED_IMG where parentjono  = @parentjono and filename  = @filename and filetype=@filetype and specification=@specification";
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(find, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@parentjono", parentjono);
                        sqlcmd.Parameters.AddWithValue("@filename", filename);
                        sqlcmd.Parameters.AddWithValue("@filetype", filetype);
                        sqlcmd.Parameters.AddWithValue("@specification", specification);
                        using (SqlDataReader rd = sqlcmd.ExecuteReader())
                        {
                            if (rd.HasRows)
                            {
                                has = true;
                            }
                            else
                            {
                                has = false;
                            }
                        }
                    }
                }

                if (has == false)
                {
                    using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                    {
                        using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                        {
                            sqlcon.Open();
                            sqlcmd.Parameters.AddWithValue("@parentjono", parentjono);
                            sqlcmd.Parameters.AddWithValue("@filename", filename);
                            sqlcmd.Parameters.AddWithValue("@filetype", filetype);
                            sqlcmd.Parameters.AddWithValue("@path", path);
                            sqlcmd.Parameters.AddWithValue("@specification", specification);
                            sqlcmd.Parameters.AddWithValue("@projectname", Session["DRscannedHome_projectlabel"].ToString());
                            sqlcmd.Parameters.AddWithValue("@udate", TBOXdate.Text);
                            sqlcmd.ExecuteNonQuery();
                        }
                    }
                }
                else
                {

                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
            finally
            {
                loaddata();
            }
        }

        private void loaddata()
        {
            try
            {

                string str = "select  [id],[parentjono],[filename],[filetype],[path],[specification],[projectname],format(cast([udate] as date),'MMM-dd-yyyy') as udate from DR_SCANNED_IMG where parentjono = @parentjono and specification = @specification";
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@parentjono", parentjono);
                        sqlcmd.Parameters.AddWithValue("@specification", specification);
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
                errorrmessage(ex.Message.ToString());
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "viewfile")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                Response.Redirect(((Label)row.FindControl("lblfilepath")).Text + ((LinkButton)row.FindControl("lbtnfilename")).Text);
            }
            else if (e.CommandName == "mydelete")
            {
                int rowindex = ((GridViewRow)((LinkButton)e.CommandSource).NamingContainer).RowIndex;
                GridViewRow row = GridView1.Rows[rowindex];
                try
                {

                    string str = "delete from DR_SCANNED_IMG where parentjono = @parentjono and filename = @filename and specification = @specification";
                    using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                    {
                        using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                        {
                            sqlcon.Open();
                            sqlcmd.Parameters.AddWithValue("@parentjono", parentjono);
                            sqlcmd.Parameters.AddWithValue("@specification", specification);
                            sqlcmd.Parameters.AddWithValue("@filename", ((LinkButton)row.FindControl("lbtnfilename")).Text);
                            sqlcmd.ExecuteNonQuery();

                            string[] Files = Directory.GetFiles(Server.MapPath(((Label)row.FindControl("lblfilepath")).Text));
                            foreach (string file in Files)
                            {
                                FileInfo fileinfo = new FileInfo(file);
                                if (fileinfo.Name == ((LinkButton)row.FindControl("lbtnfilename")).Text)
                                {
                                    File.Delete(file);
                                }
                            }

                        }
                    }
                }
                catch (Exception ex)
                {
                    errorrmessage(ex.Message.ToString());
                }
                finally
                {

                    loaddata();
                }

            }
        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
            for (int i = 0; i <= GridView1.Rows.Count - 1; i++)
            {
                LinkButton btn = (LinkButton)GridView1.Rows[i].FindControl("BTNdelete");
                if (Session["KMDI_sdr_acct"].ToString() == "Admin")
                {
                    btn.Visible = true;
                }
                else
                {
                    btn.Visible = false;
                }

            }
        }
    }
}
