using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows;


namespace WebApplication12 {
	public partial class _Default0 : System.Web.UI.Page {
		protected void ButtonRegister_Click(object sender, EventArgs e) {
			string userID = User.Text;
			string password = Password.Text;

			// Check if user ID and password have more than 4 characters
			if (userID.Length > 4 && password.Length > 4) {
				string connectionString = "Data Source=jop\\mssqlserver02;Initial Catalog=GunzDB;Persist Security Info=True;User ID=sa;Password=Asdasd12!";

				using (SqlConnection con = new SqlConnection(connectionString)) {
					con.Open();

				using (SqlCommand RegisterAccount = new SqlCommand("INSERT INTO Account (UserID, Name, UGradeID, PGradeID, RegDate) VALUES (@UserID, @Name, 0, 0, GETDATE())", con)) {
						RegisterAccount.Parameters.AddWithValue("@Name", userID);
						RegisterAccount.Parameters.AddWithValue("@UserID", userID);
					
						int rowsAffectedAccount = RegisterAccount.ExecuteNonQuery();

						if (rowsAffectedAccount > 0) {
							int AID = -1;

							using (SqlCommand getAIDCmd = new SqlCommand("SELECT AID FROM Account WHERE UserID = @UserID", con)) {
								getAIDCmd.Parameters.AddWithValue("@UserID", userID);

								object result = getAIDCmd.ExecuteScalar();
								if (result != null && result != DBNull.Value) {
									AID = Convert.ToInt32(result);
								}
							}
							// Check if AID retrieval was successful
							if (AID != -1) {
                                // Account creation succeeded
                                using (SqlCommand RegisterLogin = new SqlCommand("INSERT INTO Login(UserID, AID, UGradeID, Password) VALUES (@UserID, @AID, 0, @Password)", con)) {
                                    RegisterLogin.Parameters.AddWithValue("@UserID", userID);
                                    RegisterLogin.Parameters.AddWithValue("@Password", password);
                                    RegisterLogin.Parameters.AddWithValue("@AID", AID);

                                    int rowsAffectedLogin = RegisterLogin.ExecuteNonQuery();

									if (rowsAffectedLogin > 0) {
										// Login credentials creation succeeded
										MessageBox.Show(string.Format("Welcome, Your account has been created! Credentials are UserName '{0}' and Password '{1}'", userID, password));
										Response.Redirect("https://localhost:44396/Pages/Home.aspx");
									}
									else {
										MessageBox.Show("Error: Login credentials creation failed.");
									}
								}
							}
							else {
								//show a generic error message
								MessageBox.Show("Error: Account creation failed. Please try again later.");
							}
						}
					}
				}
			}
			else {
				MessageBox.Show("Error: User ID and Password must have more than 4 characters.");
			}
		}
	}
}
