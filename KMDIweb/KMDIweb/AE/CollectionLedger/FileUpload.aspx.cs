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

namespace KMDIweb.KMDIweb.AE.CollectionLedger
{
    public partial class FileUpload : System.Web.UI.Page
    {
        string filepath = "~/KMDIweb/Uploads/CollectionLedger/";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["KMDI_userid"] != null)
            {
                if (Session["KMDI_clg_acct"].ToString() == "User" || Session["KMDI_clg_acct"].ToString() == "Admin")
                {
                    PNLupload.Visible = true;
                }
                else
                {
                    PNLupload.Visible = false;
                }
              
            
                Boolean IsExists = System.IO.Directory.Exists(Server.MapPath(filepath + collectionId + "/"));
                if (!IsExists)
                {
                    System.IO.Directory.CreateDirectory(Server.MapPath(filepath + collectionId + "/"));
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
        private string collectionId
        {
            get
            {
                return Session["CollectionId"].ToString();
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
                            thefile.SaveAs(Server.MapPath(filepath + collectionId + "/" + thefile.FileName.Replace("#","")));
                            Session["ErrorMessage"] = null;
                            string path = filepath + collectionId + "/";
                            insertnew(thefile.FileName.Replace("#", "").ToString(), fileExtension, path);
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
            Response.Redirect("~/KMDIweb/AE/CollectionLedger/FileUpload.aspx");

        }
        private void insertnew(string filename, string filetype, string path)
        {
            try
            {
                bool has;

                string str = " declare @id as integer = (select isnull(max(isnull(id,0)),0)+1 from collection_ledger_IMG) " +
                    "insert into collection_ledger_IMG (id,collectionId,filename,filetype,path,projectname,inputted) values(@id,@collectionId,@filename,@filetype,@path,@projectname,format(getdate(),'MMM dd, yyyy'))";

                string find = "select * from collection_ledger_IMG where collectionId  = @collectionId and filename  = @filename and filetype=@filetype";
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(find, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@collectionId", collectionId);
                        sqlcmd.Parameters.AddWithValue("@filename", filename);
                        sqlcmd.Parameters.AddWithValue("@filetype", filetype);
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
                            sqlcmd.Parameters.AddWithValue("@collectionId", collectionId);
                            sqlcmd.Parameters.AddWithValue("@filename", filename);
                            sqlcmd.Parameters.AddWithValue("@filetype", filetype);
                            sqlcmd.Parameters.AddWithValue("@path", path);
                            sqlcmd.Parameters.AddWithValue("@projectname", Session["CollectionProject"].ToString());
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

                string str = "select  [id],[collectionId],[filename],[filetype],[path],[projectname],format(cast([inputted] as date),'MMM-dd-yyyy') as inputted from collection_ledger_IMG where collectionId = @collectionId";
                using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                {
                    using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                    {
                        sqlcon.Open();
                        sqlcmd.Parameters.AddWithValue("@collectionId", collectionId);
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
                    string str = "delete from collection_ledger_IMG where collectionId = @collectionId and filename = @filename";
                    using (SqlConnection sqlcon = new SqlConnection(sqlconstr))
                    {
                        using (SqlCommand sqlcmd = new SqlCommand(str, sqlcon))
                        {
                            sqlcon.Open();
                            sqlcmd.Parameters.AddWithValue("@collectionId", collectionId);
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
                if (Session["KMDI_clg_acct"].ToString() == "Admin" || Session["KMDI_clg_acct"].ToString() == "User")
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
