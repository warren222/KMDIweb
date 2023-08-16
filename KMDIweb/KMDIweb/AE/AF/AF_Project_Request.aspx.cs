using KMDIweb.KMDIweb.SessionVariables;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KMDIweb.KMDIweb.AE.AF
{
    public partial class AF_Project_Request : System.Web.UI.Page
    {
        IMyQueryString _iMyQueryString;
        public AF_Project_Request(IMyQueryString iMyQueryString)
        {
            _iMyQueryString = iMyQueryString;
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/KMDIweb/AE/AF/AF_Project_List.aspx" + AddQueryStrings());
        }
        private string AddQueryStrings()
        {
            return "?page_index=" + _iMyQueryString.Page_Index +
                "&search=" + _iMyQueryString.Search +
                "&ae=" + _iMyQueryString.AE;
        }
    }
}