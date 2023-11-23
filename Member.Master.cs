using Intuit.Ipp.Core.Configuration;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Controls;
using System.Diagnostics;
using ServiceStack;
using Microsoft.Graph;
using JqueryUIControls;
using EO.Web;
/*
*it is clean and empty because my aim is to create null field partnership with members with temporal sessions only.
*/
namespace WebApplication12 {
    public partial class MemberMaster : MasterPage {

        protected void Page_Load(object sender, EventArgs e) {

            if (Session["UserMember"] == null) {
                Response.Redirect("https://localhost:44396/Pages/Home.aspx");
            }
            else {
                string userId = Session["UserMember"] as string;
                Label3.Text = Label1.Text + userId;
            }
        }
            protected void Button88_Click(object sender, EventArgs e) {
                Session.Abandon();
                Session.Clear();
                Response.Cookies.Clear();
                Response.Redirect("https://localhost:44396/Pages/Home.aspx");

            }

        protected void Flyout_SelectedIndexChanged(object sender, EventArgs e) {
            string userId2 = Button88.Text as string;
            Button88.Text = userId2;

        }
    }
}