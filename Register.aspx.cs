using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows;


namespace WebApplication12
{
	public partial class _Default0 : System.Web.UI.Page
	{
		protected void ButtonRegister_Click(object sender, EventArgs e)
		{
			string userID = TextBox1.Text;
			string password = TextBox2.Text;

			// Check if user ID and password have more than 4 characters
			if (userID.Length > 4 && password.Length > 4)
			{
				string connectionString = "Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Persist Security Info=True;User ID=sa;Password=Asdasd12!";

				using (SqlConnection con = new SqlConnection(connectionString))
				{
					con.Open();

					using (SqlCommand RegisterAccount = new SqlCommand("INSERT INTO Account (UserID, Name, UGradeID, PGradeID, RegDate, Password) VALUES (@UserID, @Name, 0, 0, GETDATE(), @Password)", con))
					{
						RegisterAccount.Parameters.AddWithValue("@Name", TextBox1.Text);
						RegisterAccount.Parameters.AddWithValue("@UserID", TextBox1.Text);
						RegisterAccount.Parameters.AddWithValue("@Password", TextBox2.Text);
						RegisterAccount.Parameters.AddWithValue("@AID", Session["AID"] ?? "1");

						int rowsAffectedAccount = RegisterAccount.ExecuteNonQuery();

						if (rowsAffectedAccount > 0)
						{
							// Account creation succeeded
							using (SqlCommand RegisterLogin = new SqlCommand("INSERT INTO Login(UserID, AID, UGradeID, Password) SELECT UserID, AID, UGradeID, Password FROM Account WHERE UserID = @UserID", con))
							{
								RegisterLogin.Parameters.AddWithValue("@UserID", TextBox1.Text);
								RegisterLogin.Parameters.AddWithValue("@Password", TextBox2.Text);

								int rowsAffectedLogin = RegisterLogin.ExecuteNonQuery();

								if (rowsAffectedLogin > 0)
								{
									// Login credentials creation succeeded
									MessageBox.Show(string.Format("Welcome, Your account has been created! Credentials are UserName '{0}' and Password '{1}'", TextBox1.Text, TextBox2.Text));
									Response.Redirect("https://localhost:44396/Pages/Home.aspx");
								}
								else
								{
									MessageBox.Show("Error: Login credentials creation failed.");
								}
							}
						}
						else
						{
							MessageBox.Show("Error: Account creation failed.");
						}
					}
                }
            }
 
            else
{
    MessageBox.Show("Error: User ID and Password must have more than 4 characters.");
					}
				 }
			}
		}
 