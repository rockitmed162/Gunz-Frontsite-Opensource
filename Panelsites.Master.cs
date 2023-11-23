using System;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Nest.MachineLearningUsage;
using Xamarin.Forms;
using Microsoft.Ajax.Utilities;
using static System.Net.Mime.MediaTypeNames;
using System.Linq;
using System.Data.Linq.Mapping;
using Newtonsoft.Json.Linq;
using static Microsoft.Azure.Amqp.Serialization.SerializableType;
using Label = System.Web.UI.WebControls.Label;
using Page = System.Web.UI.Page;
using System.Windows.Forms;
namespace WebApplication12
{
	public partial class Panelsites : MasterPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
		if (Session["UserMember"] == null)
			{
				Session["UserMember"] = "guest";
			 
				//sessions with useful value. these shouldn't be enabled without pre-configure else web may not load up in 
				//installation
				//if you have them loaded and user without basic cookie sessions
				//cannot load the content of page, as they require the minimal Value from gunz account table to approve load them.
				 /*if nothing else works comment these loaders out*/	
				LoadCharacterData();
				LoadCharacterItem();
				LoadclanData();
			}
		}
		protected void LoadCharacterData()
		{
			using (SqlConnection con = new SqlConnection("Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Persist Security Info=True;User ID=sa;Password=Asdasd12!"))
			{
				con.Open();

				SqlCommand Sess = new SqlCommand("SELECT * FROM Character WHERE AID = @AID", con);
				Sess.Parameters.AddWithValue("@AID", Session["AID"] ?? "1");
				using (SqlDataAdapter d = new SqlDataAdapter(Sess))
				{
					DataTable dt = new DataTable();
					string Combiner = "adsf";
					DataSet dss = new DataSet();
					dss.DataSetName = Combiner;
					d.Fill(dss, "Character");
					if (dt.Rows.Count > 0)				 
						{
						Session["AID"] = dss.Tables["Character"].Rows[0]["AID"];
						Session["UserID"] = dss.Tables["Character"].Rows[0]["UserID"];
						Session["CID"] = dss.Tables["Character"].Rows[0]["CID"];
						Session["UGRAD"] = dss.Tables["Character"].Rows[0]["UGradeID"];
						Session["Charn"] = dss.Tables["Character"].Rows[0]["CharNum"];
					}
					else
					{
				//conditions			 
					}
					// If GridView1 is the ID of your GridView control
					GridView1.DataBind();
				}
			}
		}
		protected void LoadclanData()
		{
			using (SqlConnection con = new SqlConnection("Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Persist Security Info=True;User ID=sa;Password=Asdasd12!"))
			{
				con.Open();

				using (SqlCommand cmd = new SqlCommand("SELECT * FROM Clan WITH (NOLOCK) WHERE MasterCID = @MasterCID AND NAME = @CNAME ORDER BY MasterCID ASC", con))
				{
					cmd.Parameters.AddWithValue("@MasterCID", Session["MasterCID"] ?? "1");
					cmd.Parameters.AddWithValue("@CNAME", Session["CNAME"] ?? "1");

					using (SqlDataAdapter d = new SqlDataAdapter(cmd))
					{
						DataTable clanrs = new DataTable();
						string Combiner = "656";
						DataSet dss = new DataSet();
						dss.DataSetName = Combiner;

						d.Fill(clanrs); // Use "clanrs" directly

						if (clanrs.Rows.Count > 0)
						{
							Session["MasterCID"] = clanrs.Rows[0]["MasterCID"];
							Session["CNAME"] = clanrs.Rows[0]["NAME"];
							}
						else
						{
							// Handle the case when no data is retrieved from the query.
							// You may want to set default values or handle the error accordingly.
								}
							}
						} 
					}
				}
				protected void LoadCharacterItem()
				{
					using (SqlConnection con = new SqlConnection("Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Persist Security Info=True;User ID=sa;Password=Asdasd12!"))
					{
						con.Open();

						SqlCommand Sess = new SqlCommand("SELECT * FROM CharacterItem WHERE @CID = @CID", con);
						Sess.Parameters.AddWithValue("@CID", Session["CID2"] ?? "1");

						using (SqlDataAdapter d = new SqlDataAdapter(Sess))
						{
							DataTable dt = new DataTable();
							string Combiner = "adsf";
							DataSet dss = new DataSet();
							dss.DataSetName = Combiner;

							d.Fill(dss, "CharacterItem");

							if (dt.Rows.Count > 0)
								{
								Session["RentHourPeriod"] = dss.Tables["CharacterItem"].Rows[0]["RentHourPeriod"];
								Session["RentDate"] = dss.Tables["CharacterItem"].Rows[0]["RentDate"];
								Session["CID2"] = dss.Tables["CharacterItem"].Rows[0]["CID"];
								Session["CIID"] = dss.Tables["CharacterItem"].Rows[0]["CIID"];
								Session["ITEMID"] = dss.Tables["CharacterItem"].Rows[0]["ITEMID"];
								}
							else
						{
						Session["CID2"] = dss.Tables["CharacterItem"].Rows[0]["CID"];
						Session["CIID"] = dss.Tables["CharacterItem"].Rows[0]["CIID"];
						Session["ITEMID"] = dss.Tables["CharacterItem"].Rows[0]["ITEMID"];
						// Handle the case when no data is retrieved from the query.
						// You may want to set default values or handle the error accordingly.
							}
							// Assuming GridView1 is the ID of your GridView control
							GridView5.DataBind();
						}
					}
				}
	//Logout Global
		protected void ButtonLogout_Click(object sender, EventArgs e)
		{
			Session.Abandon();
			Session.Clear();
			Response.Cookies.Clear();
			Response.Redirect("https://localhost:44396/Pages/Home.aspx");
		}
		//Login Panel Frontpage/ panelsites.master in fact is the page what is before you login into panel sites. 
		protected void ButtonLogin_Click(object sender, EventArgs e)
		{
			using (SqlConnection con = new SqlConnection("Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Persist Security Info=True;User ID=sa;Password=Asdasd12!"))
			{
				con.Open();

				using (SqlCommand loginCmd = new SqlCommand("SELECT * FROM Login WHERE userid=@UserID AND password=@Password", con))
				{
					loginCmd.Parameters.AddWithValue("@UserID", TextBox3.Text);
					loginCmd.Parameters.AddWithValue("@Password", TextBox4.Text);
					using (SqlCommand clan = new SqlCommand("SELECT * FROM Clan MasterCID=@MasterCID", con))
					{
						clan.Parameters.AddWithValue("@MasterCID", Session["MasterCID"] ?? "1");
						clan.Parameters.AddWithValue("@UserID", TextBox3.Text);
						clan.Parameters.AddWithValue("@Password", TextBox4.Text);
						using (SqlDataReader loginReader = loginCmd.ExecuteReader())
						{
							if (loginReader.Read()) // Check if the login query returns any rows
							{
								int uGradeID = Convert.ToInt32(loginReader["UGradeID"]);
								if (uGradeID == 0) //0 = Normal User
								{

									// Member login
									Session["UserMember"] = TextBox3.Text;
									Session["AID"] = loginReader["AID"];
									Session["UserID"] = loginReader["UserID"];
									Session["UGRAD"] = uGradeID;
									string newUrl = "Members.aspx?id=" + loginReader["UserID"];
									Response.Redirect("https://localhost:44396/Pages/Panel/" + newUrl);
                                    return;
                                }
								else if (uGradeID == 255) 
								{
									// Admin login
									Session["UserAdmin"] = TextBox3.Text;
									Response.Redirect("https://localhost:44396/Pages/Panel/Panel.aspx"); 
									return;
								}
								else
								{
									MessageBox.Show("UserID or Password Was Wrong Create Account if you don't yet have a account");
									Response.Redirect("https://localhost:44396/Pages/Register.aspx");
									// Handle the case when login credentials are incorrect
									// You can display an error message or redirect to an error page.

								}
								
								using (SqlDataReader clanReader = clan.ExecuteReader())
								{
									if (clanReader.Read())
									{// Check if the clanReader query returns any rows
										int MasterCID = Convert.ToInt32(clanReader["MasterCID"]);


										if (MasterCID == 0)
										{
											// ClanMember Session

											Session["MasterCID"] = clanReader["MasterCID"];
											Session["CLID"] = clanReader["CLID"];
											Session["CNAME"] = clanReader["NAME"];
											Session["CCID"] = MasterCID;
											Session["UserMember"] = TextBox3.Text;
											string newUrl = "Members.aspx?id=" + Session["UserMember"];
											Response.Redirect("https://localhost:44396/Pages/Panel/" + newUrl);
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
	}
}
