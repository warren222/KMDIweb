using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KMDIweb.KMDIweb.SessionVariables
{
    public class MyQueryString : IMyQueryString
    {
        public string Search
        {
            get
            {
                return HttpContext.Current.Request.QueryString["search"];
            }
        }
        public string Page_Index
        {
            get
            {
                return HttpContext.Current.Request.QueryString["page_index"];
            }
        }
        public string AE
        {
            get
            {
                return HttpContext.Current.Request.QueryString["ae"];
            }
        }
        public string JO_Parent
        {
            get
            {
                return HttpContext.Current.Request.QueryString["jo_parent"];
            }
        }
    }
}