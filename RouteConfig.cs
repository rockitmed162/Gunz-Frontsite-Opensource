using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using System.Web.UI;
using static WebApplication12._Default2;

namespace WebApplication12
{
 
	public static class RouteConfig
    {
		public static void RegisterRoutes(RouteCollection routes)
		{
	//		object value = "231"; 
			routes.MapPageRoute(
   "CustomRoute",      // Route name (you can choose any name)
	"id={ID}",  "~/Members.aspx"   // Physical page that will handle the request
);
		}
	}
}
//form1.Action = Request.RawUrl;