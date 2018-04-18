using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(SamlWeb.Startup))]
namespace SamlWeb
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
