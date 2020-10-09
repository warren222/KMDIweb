using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(KMDIweb.Startup))]
namespace KMDIweb
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
