using System;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Page = System.Web.UI.Page;


namespace WebApplication12
{
	public partial class _Default : Page
	{

		protected void Page_Load(object sender, EventArgs e)
		{
			//hide login box after moved this to panel page control



		}

		protected void Preinit(object sender, EventArgs e)
		{
		}//logout
		protected void ButtonLogout_Click(object sender, EventArgs e)
		{
			Session.Abandon();
			Session.Clear();
			Response.Cookies.Clear();
			Response.Redirect("https://localhost:44396/Pages/Home.aspx");
		}
		protected void Page_Loads(object sender, EventArgs e)
		{

		}
		//rank list
		protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
		{
			SqlConnection con = new SqlConnection("Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Integrated Security=True");
			
			con.Open();
			ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Successfully Inserted');", true);
			LoadRecord();

			void LoadRecord()
			{

				SqlCommand comm = new SqlCommand("select * from character", con);

				SqlDataAdapter d = new SqlDataAdapter(comm);
				DataTable dt = new DataTable();

				d.Fill(dt);
				GridView1.DataSource = dt;
				GridView1.DataBind();
				con.Close();
			}
		}
		//announcements
		protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
		{
			SqlConnection con = new SqlConnection("Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Integrated Security=True!");

			con.Open();
			ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Successfully Inserted');", true);
			LoadRecord();
			LoadUpdate();
			void LoadUpdate()
			{
				SqlCommand Update = new SqlCommand("UPDATE webcontent Set news = news Where Name = Name", con);
				SqlDataAdapter da = new SqlDataAdapter(Update);
				DataTable demon = new DataTable();
				da.Fill(demon);
			}
				void LoadRecord()
			{


				 
				SqlCommand comm = new SqlCommand("select * from clan", con);
				SqlDataAdapter d = new SqlDataAdapter(comm);
				DataTable dt = new DataTable();
				comm.Parameters.AddWithValue("@MasterCID", Session["MasterCID"]);
				d.Fill(dt);
				GridView2.DataSource = dt;
				GridView2.DataBind();
				
				con.Close();
			}
		}
		
		//clones
		protected void GridView4_PageIndexChanging(object sender, DetailsViewPageEventArgs e)
		{
			SqlConnection connn = new SqlConnection("Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Integrated Security=True");

			connn.Open();
			ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Successfully Inserted');", true);
			LoadRecorddd();

			void LoadRecorddd()
			{


				SqlCommand commm = new SqlCommand("SELECT CurrPlayer FROM ServerStatus", connn);
			//	SqlCommand notused = new SqlCommand("SELECT* FROM ServerStatus(nolock) WHERE Opened != 0", connn);
				SqlDataAdapter d = new SqlDataAdapter(commm);
				DataTable dt = new DataTable();
				d.Fill(dt);

				GridView4.DataSource = dt;
				GridView4.DataBind();
				connn.Close();
			}
		}
		//server status
		protected void GridView5_PageIndexChanging(object sender, DetailsViewPageEventArgs e)
		{
			SqlConnection connn = new SqlConnection("Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Integrated Security=True");

			connn.Open();
			ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Successfully Inserted');", true);
			LoadRecorddd();

			void LoadRecorddd()
			{


				SqlCommand commm = new SqlCommand("SELECT CurrPlayer FROM ServerStatus", connn);
				//SqlCommand notused = new SqlCommand("SELECT* FROM ServerStatus(nolock) WHERE Opened != 0", connn);
				SqlDataAdapter d = new SqlDataAdapter(commm);

				DataTable dt = new DataTable();
				d.Fill(dt);

				GridView4.DataSource = dt;
				GridView4.DataBind();
				connn.Close();
			}
		}
//news of frontpage
		public class Bews
		{
			public static void Update(object sender, DetailsViewPageEventArgs e)
			{
				SqlConnection con = new SqlConnection("Data Source=jop\\mssqlserver02;Initial Catalog=Gunzweb;Integrated Security=True");
				SqlCommand Update = new SqlCommand("UPDATE webcontent Set news = news Where Name = Name", con);

			}
		}

        protected void ContextMenu1_ItemClick(object sender, EO.Web.NavigationItemEventArgs e)
        {

        }
    }
}