# Gunz-Frontsite-Opensource
Startup Project for Gunz the Duel with a Minimal desktop to read and view and register and controlpanel for users

this is just a pre-creational content, no intrustruction for installation or other information  written yet today!

The Site Will Require Currently own Gunz Database with minor adds, not alternated just with some extra information.
also frontpage/home page is supported with own Database set for content to news/update/download.

No Configure files are part of it, it is opensource so you have to have some skillset to modify the SQL server Connectionstrings to your own.

Pre-Requirement to Install to open and edit the source:
--------------------------------------------------------

Visual Studio 2022 / .Net v3.5 - v8.0 installed  with ASP.NET & C# support ideally.
-
Microsoft.EntityFrameWork.SqlServer v3.1.32 to v8.0
-
Microsoft.EntityFrameWorkCore v3.1.32
-
Microsoft.Data.SqlClient v5.1.2
-
System.Data.SqlClient v4.8.5
-
Devart.Data.SqlServer.Linq
-
EntityFramework.SqlServer
-
EntityFrameWork v.6.4.4
-
System.Data.Common
-
SQL SERVER 2022
-
MSSQL v.19
-
ODBC32-bit
-
(Drivers installed From SQL Server)
The Connection to Established with SQL And GunZ Database.
-----------------------------------------------------------
Step1:
-
Start New Project:
--
-
Select ASP.NET Web Application (.Net Framework) v 4.7.2 - v 4.8.1
--
-
this is the platform and rest is up to your skill and use of the startup files im providing for open free source..
---
-
Open member.aspx / Home.aspx / register.aspx / panelsites.master files
--
---
access them on Design View, Find and Modify the SqlDatasource Objects with your own SQLconnection settings.
-
---
-
after this you retrieve the Connectionstrings what you need to modify and add to code-behind pages.
Member.aspx.cs, home.aspx.cs , register.aspx.cs, panelsites.master.cs files are c#.
then replace the connectionstring to yours in those files.
-------------------------------------------------------------------------------

After this you the source is available and free for you to continue and use,this is the startup free open source for you to free to use.
-
--------------------

Download the Databases:
-------
GunzDB (whats different?)

-

In Account table you have a extra field "password" 

-

In Login You have extra field "UGradeID"

-----------------

in Character You hae extra fields "UGradeID" , "UserID" , "Password" , "OldName"
none of these changes are really neccessary or new or different. they already exists and are used on gunz, i just added those same values available on other tables.
thats all.

---
GunzWeb Database is Standalone its to control the Frontpage News/updates/download/custom Objects , you can easily fill them with text or what you want to add.
-
the databases have been taken directly from use as a copy added here, so they already contain the changes I mentioned that are supported by the source code of the website. but contains the server and some ready-made values, e.g. account and login account and a pre-created character and clan. take these things into account if you decide to use the GunzDB database, while the Gunzweb database is a mandatory add-on for the site's functionality.
<---
-Do not mix the Source with other coding languages, it is pure html/C# / stylesheet on windows blazer webforms. It means don't mix it with PHP, Java, python, or any   other code languages, or the source code will lose its edge.
------------------------------------------------------------------------------------------------------------
