using KMDIweb.KMDIweb.SessionVariables;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
//using Microsoft.AspNet.WebFormsDependencyInjection.Unity;
using Unity;

namespace KMDIweb
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            //var container = this.AddUnity();
            //container.RegisterType<IMyQueryString, MyQueryString>();
        }
    }
}
