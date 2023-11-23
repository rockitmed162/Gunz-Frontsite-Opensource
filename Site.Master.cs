using Intuit.Ipp.Core.Configuration;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Data.Entity.Infrastructure.Design.Executor;
using Nest;
using Microsoft.Graph.Ediscovery;
using System.Diagnostics;
using System.Windows;
using System.Windows.Forms;

namespace WebApplication12
{
	public partial class SiteMaster : MasterPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			//hide login box after moved this to panel page control

			string userId = Session["UserMember"] as string; // Retrieve the session value

			if (!string.IsNullOrEmpty(userId))
			{
				// Update the navigation menu link to use the "userId" value
				string navMenuLink = $"/Pages/Panel/YourPage.aspx?id={userId}";
				// Add "navMenuLink" to your menu item or navigation structure
			}

		}

		protected void Preinit(object sender, EventArgs e)
		{
		}
		protected void ButtonLogout_Click(object sender, EventArgs e)
		{
			Session.Abandon();
			Session.Clear();
			Response.Cookies.Clear();
			Response.Redirect("https://localhost:44396/Pages/Home.aspx");
		}


		protected void ButtonLogin_Click(object sender, EventArgs e)
		{
			// Set up the SQL connection
			using (SqlConnection con = new SqlConnection("Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Persist Security Info=True;User ID=sa;Password=Asdasd12!"))
			{
				// Open the SQL connection
				con.Open();

				// Set up the SqlCommand for the Account query
				using (SqlCommand Cmd = new SqlCommand("SELECT * FROM Account WHERE userid=@UserID AND password=@Password", con))
				{
					Cmd.Parameters.AddWithValue("@UserID", TextBox3.Text);
					Cmd.Parameters.AddWithValue("@Password", TextBox4.Text);

					// Execute the Account query
					using (SqlDataReader accountReader = Cmd.ExecuteReader())

					{
						SqlDataAdapter da = new SqlDataAdapter(Cmd);
						DataSet ds = new DataSet();
						con.Close();
						da.Fill(ds, "Account");
				
						if (ds.Tables["Account"].Rows[0]["UGradeID"].ToString() == "0")
						{
					
							Session["UserMember"] = TextBox3.Text;
							Session["UGradeID"] = (ds.Tables["Account"].Rows[0]["UGradeID"].ToString() == "0");
							string newUrl = "Members.aspx?id=" + Session["UserMember"];
							Response.Redirect("https://localhost:44396/Pages/Panel/" + newUrl);
						}
						else if (ds.Tables["Account"].Rows[0]["UGradeID"].ToString() == "255")
						{
							Session["UserAdmin"] = TextBox3.Text;
							Session["UGradeID"] = (ds.Tables["Account"].Rows[0]["UGradeID"].ToString() == "255");
						}
						con.Open();
						// Set up the SqlCommand for the Character query
						using (SqlCommand characterCmd = new SqlCommand("SELECT * FROM Character WHERE AID=@AID AND Name=@Name OR CID=@CID", con))
						{
							characterCmd.Parameters.AddWithValue("@AID", Session["AID"]);
							characterCmd.Parameters.AddWithValue("@CID", Session["CID"]);
							characterCmd.Parameters.AddWithValue("@Name", Session["Name"]);

							// Execute the Character query
							using (SqlDataReader characterReader = characterCmd.ExecuteReader())
							{
								SqlDataAdapter da2 = new SqlDataAdapter(characterCmd);


								DataSet dss = new DataSet();
								con.Close();
								da2.Fill(dss, "Character");
								if (ds.Tables["Character"].Rows[0]["CID"] != DBNull.Value)
								{
									Session["UserMember"] = TextBox3.Text;

									Session["AID"] = ds.Tables["Character"].Rows[0]["AID"];

									Session["CID"] = ds.Tables["Character"].Rows[0]["CID"];
									Session["BP"] = ds.Tables["Character"].Rows[0]["BP"];
									Session["CharNum"] = ds.Tables["Character"].Rows[0]["CharNum"];

									Session["CharName"] = ds.Tables["Character"].Rows[0]["Name"];

									string newUrl = "Members.aspx?id=" + Session["UserMember"];
									Response.Redirect("https://localhost:44396/Pages/Panel/" + newUrl);
									return;
								}
								else
								{
									Session["UserAdmin"] = TextBox3.Text;
									Response.Redirect("https://localhost:44396/Pages/Panel/Panel.Aspx");
									return;
								}
							}
						}
					}
				}
			}
		}
	}
}