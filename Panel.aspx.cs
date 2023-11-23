using System;
using System.Data.SqlClient;
using System.Data;
using Page = System.Web.UI.Page;
 
//
namespace WebApplication12
{
	public partial class _Default1 : Page
	{

		protected void Page_Load(object sender, EventArgs e)
		{

			if (Session["UserAdmin"] == null)
			{
				Response.Redirect("https://localhost:44396/Pages/Home.aspx");

			}
			else
			{

				//welcome user
				Label4.Text = Session["UserAdmin"] + Labelorder66.Text;
			}
		}
	}
}//AdminPanel NOT in build because its not important for real.