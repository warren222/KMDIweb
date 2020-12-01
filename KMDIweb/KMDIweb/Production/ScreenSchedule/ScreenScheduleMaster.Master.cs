using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.SCREENfab
{
    public partial class KMDIwebMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            username.Text = Session["KMDI_nickname"].ToString() + " ";
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/KMDIweb/Global/login.aspx");
        }
    }
}