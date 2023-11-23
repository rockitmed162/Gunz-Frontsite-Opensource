using System;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI;
using DropDownList = System.Web.UI.WebControls.DropDownList;
using System.Web.UI.WebControls;
using Page = System.Web.UI.Page;
using ServiceStack;
using Nest;
using Microsoft.Graph;
using System.Data.SqlTypes;
using static System.Net.Mime.MediaTypeNames;
using System.Web.UI.MobileControls.Adapters;
using EO.Internal;
using Intuit.Ipp.Data;
using System.Collections.Generic;
using System.Security.Cryptography;
using Microsoft.Azure.Amqp.Framing;
using System.Data.Entity.Infrastructure;
using ListItem = System.Web.UI.WebControls.ListItem;
using System.Windows;
using System.Windows.Controls;
using DTIMiniControls;
using Microsoft.Graph.TermStore;
using System.Transactions;
using System.Web.WebPages.Razor;
using System.Web.WebPages.Razor.Configuration;
using Xunit;
using System.Web.Http.Routing;
using Microsoft.AspNetCore.Http;
using ServiceStack.Text;

namespace WebApplication12
{
	public partial class _Default2 : Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["UserMember"] == null)
			{
				Response.Redirect("https://localhost:44396/Pages/Home.aspx");
			}
			else
			{
				//test delete after
				//welcome user
				Label3.Text = Label4.Text + Session["UserMember"] + Labelorder66.Text;
			}
		}
		protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			GridView1.PageIndex = e.NewPageIndex;
			BindCashData(); //  cashmethod
		}
		private void BindCashData()
		{
			string connectionString = "Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Persist Security Info=True;User ID=sa;Password=Asdasd12!";

			using (SqlConnection con = new SqlConnection(connectionString))
			{
				con.Open();

				// Fill User's Cash Bank. cash fix later
				using (SqlCommand cmd = new SqlCommand("SELECT Cash FROM Account WHERE UserID = @UserID", con))
				{
					cmd.Parameters.AddWithValue("@UserID", Session["UserMember"]);

					using (SqlDataAdapter ada = new SqlDataAdapter(cmd))
					{
						DataSet cashtable = new DataSet();
						ada.Fill(cashtable);

						// Creational ViewBlock for Profile Data View
						GridView1.DataSource = cashtable;
						GridView1.DataBind();
					}
				}
			}
		}
		protected void ChangeName_UserPanelCLick(object sender, EventArgs e)
		{
			string connectionString = "Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Persist Security Info=True;User ID=sa;Password=Asdasd12!";

			using (SqlConnection con = new SqlConnection(connectionString))
			{
				con.Open();

				// the Dataset Entry
				using (SqlCommand cmd = new SqlCommand("SELECT * FROM Character WHERE AID = @AID", con))
				{
					cmd.Parameters.AddWithValue("@AID", Session["AID"]);

					SqlDataAdapter adapter = new SqlDataAdapter(cmd);
					DataSet ds = new DataSet();
					adapter.Fill(ds, "Character");

					if (ds.Tables.Contains("Character") && ds.Tables["Character"].Rows.Count > 0)
					{
						if (ds.Tables["Character"].Rows[0]["AID"].ToString() == Session["AID"].ToString())
						{
							// Creates SQL-Command for the Update
							using (SqlCommand sql = new SqlCommand("UPDATE TOP (1) Character SET Name = @NewName WHERE (AID = @AID) AND (Name = @OldName)", con))
							{
								sql.Parameters.AddWithValue("@NewName", TextBox675.Text);
								sql.Parameters.AddWithValue("@OldName", TextBox679.Text);
								sql.Parameters.AddWithValue("@AID", Session["AID"]);

								try
								{
									int rowsAffected = sql.ExecuteNonQuery();

									if (rowsAffected > 0)
									{
										MessageBox.Show(string.Format("Name was changed successfully from '{0}' to '{1}'", TextBox679.Text, TextBox675.Text));
										string newUrl = "Members.aspx?id=" + Session["UserMember"];
										Response.Redirect("https://localhost:44396/Pages/Panel/" + newUrl);

									}
									else
									{
										MessageBox.Show("Name was not changed!");
										return;
									}
								}
								catch (Exception ex)
								{
									// Expection Handlers
									MessageBox.Show("An error occurred: " + ex.Message);

								}
							}
						}
						else
						{
							//	MessageBox.Show("This is not your character!");
						}
					}
					else
					{
						//MessageBox.Show("Character doesn't exist!");
					}
				}
			}
		}
		protected void ChangePassword_UserPanelCLicks(object sender, EventArgs e)
		{
			string connectionString = "Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Persist Security Info=True;User ID=sa;Password=Asdasd12!";

			using (SqlConnection con = new SqlConnection(connectionString))
			{
				con.Open();

				// the Dataset Entry
				using (SqlCommand cmd = new SqlCommand("SELECT * FROM Login Where (AID = @AID) AND (Password = @Password)", con))
				{

					cmd.Parameters.AddWithValue("@Password", TextBox667.Text);
					cmd.Parameters.AddWithValue("@PasswordNew", TextBox672.Text);
					cmd.Parameters.AddWithValue("@AID", Session["AID"]);

					SqlDataAdapter adapter = new SqlDataAdapter(cmd);
					DataSet ds = new DataSet();
					adapter.Fill(ds, "Login");

					if (ds.Tables.Contains("Login") && ds.Tables["Login"].Rows.Count > 0)
					{
						if (ds.Tables["Login"].Rows[0]["AID"].ToString() == Session["AID"].ToString())
						{
							using (SqlCommand Cmdpwold = new SqlCommand("UPDATE TOP (1) Login Set Password = @PasswordNew Where (AID = @AID) AND (Password = @Password)", con))
							{

								Cmdpwold.Parameters.AddWithValue("@Password", TextBox667.Text);
								Cmdpwold.Parameters.AddWithValue("@PasswordNew", TextBox672.Text);
								Cmdpwold.Parameters.AddWithValue("@AID", Session["AID"]);
								try
								{
									int rowsAffected = Cmdpwold.ExecuteNonQuery();

									if (rowsAffected > 0)
									{
										MessageBox.Show(string.Format("Password was changed successfully from '{0}' to '{1}'", TextBox667.Text, TextBox672.Text));
										string newUrl = "Members.aspx?id=" + Session["UserMember"];
										Response.Redirect("https://localhost:44396/Pages/Panel/" + newUrl);

									}
									else
									{
										MessageBox.Show("Password was not changed!");
										return;
									}
								}
								catch (Exception ex)
								{
									// Expection Handlers
									MessageBox.Show("An error occurred: " + ex.Message);
									return;
								}
							}
						}
					}
				}
			}
		}
		protected void Itembutton(object sender, EventArgs e)
		{
			string connectionString = "Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Persist Security Info=True;User ID=sa;Password=Asdasd12!";

			using (SqlConnection con = new SqlConnection(connectionString))
			{
				con.Open();

				using (SqlTransaction transaction = con.BeginTransaction())
				{
					try
					{
						// Check current Bounty Balance Before Transaction.
						int requiredBP = Convert.ToInt32(price.Text);
						int currentBP;

						using (SqlCommand currentBPCmd = new SqlCommand("SELECT BP FROM Character WHERE Name = @Username", con, transaction))
						{
							currentBPCmd.Parameters.AddWithValue("@Username", CharID.Text);
							currentBP = Convert.ToInt32(currentBPCmd.ExecuteScalar());
						}

						if (currentBP < requiredBP)
						{
							MessageBox.Show("Character does not have enough Bounty for this item.");
							return; // Cancel Operation, if Infucient amount of bounty.
						}
						using (SqlCommand Char = new SqlCommand("SELECT AID FROM Account WHERE UserID = @UserID", con, transaction))
						{


							using (SqlCommand Items = new SqlCommand("INSERT INTO CharacterItem (CID, ItemID, RentDate, RentHourPeriod, Cnt) VALUES (@CID, @ItemID, GETDATE(), @RentHourPeriod, 1)", con, transaction))
							{
								 
								Items.Parameters.AddWithValue("@RentHourPeriod", Session["RentHourPeriod"] ?? "12");
								Items.Parameters.AddWithValue("@UserID", Session["UserMember"]);
								Items.Parameters.AddWithValue("@RentDate", Session["RentDate"] ?? "1.1.1.1");
								Items.Parameters.AddWithValue("@CID", DropDownList13.Text);
								Items.Parameters.AddWithValue("@ItemID", itemid.Text);
								Items.Parameters.AddWithValue("@Username", CharID.Text);


								using (SqlCommand Bounty = new SqlCommand("UPDATE Character SET BP = BP - @BP WHERE Name = @Username", con, transaction))
								{
									Bounty.Parameters.AddWithValue("@Username", CharID.Text);
									Bounty.Parameters.AddWithValue("@BP", Convert.ToInt32(price.Text));


									int rowsAffecteds = Items.ExecuteNonQuery();
									int rowsAffectede = Bounty.ExecuteNonQuery();

									if (rowsAffecteds > 0 && rowsAffectede > 0)
									{

										transaction.Commit();  // Commit the transaction if both operations succeed
										MessageBox.Show(string.Format("Item '{0}' Sent to '{1}' Item Costed '{2}'", itemid.Text, CharID.Text, price.Text));
										string newUrl = "Members.aspx?id=" + Session["UserMember"];
										Response.Redirect("https://localhost:44396/Pages/Panel/" + newUrl);
									}
									else
									{
										transaction.Rollback();  // Rollback the transaction if any operation fails
										MessageBox.Show("Item was not Sent");
									}
								}
							}
						}
					}
					catch (Exception ex)
					{
						transaction.Rollback();  // Rollback the transaction if an exception occurs
						MessageBox.Show("An error occurred: " + ex.Message);
					}
				}
			}
		}
		protected void ClanCreate_Click(object sender, EventArgs e)
		{
			string connectionString = "Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Persist Security Info=True;User ID=sa;Password=Asdasd12!";

			using (SqlConnection con = new SqlConnection(connectionString))
			{
				con.Open();

				//find character cid value from character table and insert the value from textbox to clan tables
				int clanLeaderID;

				using (SqlCommand findCID = new SqlCommand("SELECT * FROM Character WHERE (Name = @Name) AND (AID = @AID)", con))
				{
					findCID.Parameters.AddWithValue("@AID", Session["AID"]);
					findCID.Parameters.AddWithValue("@Name", ClanLeader.Text);
					object result = findCID.ExecuteScalar();
					clanLeaderID = Convert.ToInt32(result);
					int find = findCID.ExecuteNonQuery();

					SqlDataAdapter adapter = new SqlDataAdapter(findCID);
					DataSet ds = new DataSet();
					adapter.Fill(ds, "Character");
					//Checks access range index, if you dont own the data, you dont change the data.
					if (ds.Tables.Contains("Character") && ds.Tables["Character"].Rows.Count > 0)
					{
						if (ds.Tables["Character"].Rows[0]["AID"].ToString() == Session["AID"].ToString())
						{

							// Check if a clan already exists for the CID
							string checkClanQuery = "SELECT COUNT(*) FROM Clan WHERE MasterCID = @CID";

							using (SqlCommand checkClanCmd = new SqlCommand(checkClanQuery, con))
							{
								checkClanCmd.Parameters.AddWithValue("@CID", clanLeaderID);
								int existingClanCount = Convert.ToInt32(checkClanCmd.ExecuteScalar());

								if (existingClanCount == 0) // No existing clan for the CID
								{
									string clan = "INSERT INTO Clan (Name, MasterCID, RegDate) VALUES (@CName, @CID, GETDATE())";
									SqlCommand cmd = new SqlCommand(clan, con);

									cmd.Parameters.AddWithValue("@CName", ClanName.Text);
									cmd.Parameters.AddWithValue("@CID", clanLeaderID);

									//	cmd2.Parameters.AddWithValue("@CLID2", CLID);
									int rowsAffectedClan = cmd.ExecuteNonQuery();
									if (rowsAffectedClan > 0)
									{
										// Retrieve the CID value from the Character table
										//clan tables to insert into new member and clan.
										string clanm = "INSERT INTO ClanMember (CLID, CID, Grade, RegDate) VALUES (@CLID, @CID, 1, GETDATE())";
										SqlCommand cmd1 = new SqlCommand(clanm, con);

										string selectLastInsertedCLID = "SELECT IDENT_CURRENT('Clan')";
										SqlCommand selectCmd = new SqlCommand(selectLastInsertedCLID, con);
										int CLID = Convert.ToInt32(selectCmd.ExecuteScalar());

										cmd1.Parameters.AddWithValue("@CLID", CLID);
										cmd1.Parameters.AddWithValue("@CID", clanLeaderID);


										int rowsAffectedClanMember = cmd1.ExecuteNonQuery();


										if (rowsAffectedClanMember > 0)
										{
											Session["ClanName"] = ClanName.Text;
											Session["CLANCID"] = clanLeaderID;
											Session["CLANMASTERCID"] = clanLeaderID;
											Session["CLANCLID"] = CLID;
											// Clan inserted successfully
											MessageBox.Show(string.Format("Clan '{0}' Created for Leader ID: '{1}'", ClanName.Text, ClanLeader.Text));
											string newUrl = "Members.aspx?id=" + Session["UserMember"];
											Response.Redirect("https://localhost:44396/Pages/Panel/" + newUrl);
										}
									}
								}
								else
								{
									// Clan already exists for the CID, handle accordingly
									MessageBox.Show("A clan already exists for this leader.");
									string newUrl = "Members.aspx?id=" + Session["UserMember"];
									Response.Redirect("https://localhost:44396/Pages/Panel/" + newUrl);
								}
							}
						}
					}
				}
			}
		}
		protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
		{
			string connectionString = "Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Persist Security Info=True;User ID=sa;Password=Asdasd12!";

			using (SqlConnection con = new SqlConnection(connectionString))
			{
				con.Open();

				// the Dataset Entry
				using (SqlCommand cmd = new SqlCommand("SELECT * FROM Character(nolock) WHERE AID = @AID AND DeleteFlag = 0 ORDER BY CharNum ASC", con))
				{
					cmd.Parameters.AddWithValue("@AID", Session["AID"]);

					SqlDataAdapter adapter = new SqlDataAdapter(cmd);
					DataSet ds = new DataSet();
					adapter.Fill(ds, "Character");
				}
			}
		}

		protected void DDL_SelectedIndexChanged(object sender, EventArgs e)
		{
			// Get the selected item
			var selectedItem = ((DropDownList)sender).SelectedItem;
			// Assuming the selected value is the ItemID
			string selectedID = selectedItem.Value;
			// for example if you want to create more Values into Panel Textboxes.
			//**		//**these values to work assuming the requirement to not only add it into backend of your web.
			//create more dropdownlist objects into members.aspx
			//and include them after the selection bind it to any desiresable destination of sql
			//you need to setup the object toconvert the desired column info you want to select unique paths from aspx propertities.
			//you have to change the value for each individual command string query.
			string selectedID2 = selectedItem.Value;
			string selectedID3 = selectedItem.Value;
			string selectedID4 = selectedItem.Value;
			string selectedID5 = selectedItem.Value;
			// Database connection string
			string connectionString = "Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Persist Security Info=True;User ID=sa;Password=Asdasd12!";

			// SQL query to retrieve BountyPrice for the selected ItemID
			string query1 = "SELECT BountyPrice FROM item WHERE ItemID = @ItemID";
			string query2 = "SELECT Damage FROM item WHERE ItemID = @ItemID";
			string query3 = "SELECT Delay FROM item WHERE ItemID = @ItemID";
			string query4 = "SELECT Hp FROM item WHERE ItemID = @ItemID";
			string query5 = "SELECT Ap FROM item WHERE ItemID = @ItemID";
			{
				using (SqlConnection con = new SqlConnection(connectionString))
				{
					con.Open();

					// Query 1: Get BountyPrice
					using (SqlCommand cmd1 = new SqlCommand(query1, con))
					{
						cmd1.Parameters.AddWithValue("@ItemID", selectedID);
						object result = cmd1.ExecuteScalar();
						string requestedValue = "N/A";
						// If the result is not null, set the BountyPrice to price.Text
						price.Text = result != null ? result.ToString() : requestedValue;
					}
					// Query 2: Get other details and bind to GridView
					using (SqlCommand cmd2 = new SqlCommand(query2, con))
					{
						cmd2.Parameters.AddWithValue("@ItemID", selectedID2);
						// If the result is not null, set the Damage to Damage.Text
						object result = cmd2.ExecuteScalar();
						Damage.Text = result != null ? result.ToString() : "N/A";
					}
					using (SqlCommand cmd3 = new SqlCommand(query3, con))
					{
						cmd3.Parameters.AddWithValue("@ItemID", selectedID3);
						// If the result is not null, set the Delay to Delay.Text
						object result = cmd3.ExecuteScalar();
						Delay.Text = result != null ? result.ToString() : "N/A";
					}
					using (SqlCommand cmd4 = new SqlCommand(query4, con))
					{
						cmd4.Parameters.AddWithValue("@ItemID", selectedID4);
						// If the result is not null, set the Delay to Delay.Text
						object result = cmd4.ExecuteScalar();
						Hp.Text = result != null ? result.ToString() : "N/A";
					}
					using (SqlCommand cmd5 = new SqlCommand(query5, con))
					{
						cmd5.Parameters.AddWithValue("@ItemID", selectedID5);
						// If the result is not null, set the Delay to Delay.Text
						object result = cmd5.ExecuteScalar();
						Ap.Text = result != null ? result.ToString() : "N/A";
					}
					// Execute the query
					// Set the ItemID to itemid.Text
					itemid.Text = selectedID;

				}
			}
		}
		protected void DDL2_SelectedIndexChanged(object sender, EventArgs e)
		{
			// Get the selected item
			var selectedItem11 = ((DropDownList)sender).SelectedItem;

			// Assuming the selected value is the ItemID
			string selectedID11 = selectedItem11.Value;

			string selectedID22 = selectedItem11.Value;
		
			// Database connection string
			string connectionString = "Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Persist Security Info=True;User ID=sa;Password=Asdasd12!";

			// SQL query to retrieve BountyPrice for the selected ItemID

			string query1 = "SELECT * FROM Character(nolock) WHERE AID = @AID AND DeleteFlag = 0 ORDER BY CharNum ASC";
			string query2 = "SELECT * FROM Character(nolock) WHERE Name = @Name AND DeleteFlag = 0 ORDER BY CharNum ASC";
			{
				using (SqlConnection con = new SqlConnection(connectionString))
				{
					con.Open();

					// Query 1: Get BountyPrice
					using (SqlCommand cmd1 = new SqlCommand(query1, con))
					{
						cmd1.Parameters.AddWithValue("@AID", Session["AID"]);
						object result = cmd1.ExecuteScalar();
						// If the result is not null, set the BountyPrice to price.Text
						int rowsAffecteds = cmd1.ExecuteNonQuery();
					}
					// Query 2: Get other details and bind to GridView
					using (SqlCommand cmd2 = new SqlCommand(query2, con))
					{
						cmd2.Parameters.AddWithValue("@Name", selectedID22);
						// If the result is not null, set the Damage to Damage.Text
						object result = cmd2.ExecuteScalar();
						int rowsAffecteds = cmd2.ExecuteNonQuery();					
						}		
					}
				}
			}
		}
	}