# Gunz-Frontsite-Opensource
Startup Project for Gunz the Duel with a Minimal desktop to read and view and register and controlpanel for users

this is just a pre-creational content, no intrustruction for installation or other information  written yet today!

The Site Will Require Currently own Gunz Database with minor adds, not alternated just with some extra information.
also frontpage/home page is supported with own Database set for content to news/update/download.

No Configure files are part of it, it is opensource so you have to have some skillset to modify the SQL server Connectionstrings to your own.

Pre-Requirement to Install to open and edit the source:
--------------------------------------------------------

Visual Studio 2022 / .Net v3.5 - v8.0 installed 
Microsoft.EntityFrameWork.SqlServer v3.1.32 to v8.0
Microsoft.EntityFrameWorkCore v3.1.32
Microsoft.Data.SqlClient v5.1.2
System.Data.SqlClient v4.8.5
Devart.Data.SqlServer.Linq
EntityFramework.SqlServer
EntityFrameWork v.6.4.4
System.Data.Common
----------------------------------------------------------
SQL SERVER 2022
MSSQL v.19
ODBC32-bit (Drivers installed From SQL Server) and The Connection to Established with SQL And GunZ Database.
-----------------------------------------------------------
Step1:
Open member.aspx / Home.aspx / register.aspx / panelsites.master files
--
access them on Design View, Find and Modify the SqlDatasource Objects with your own SQLconnection settings.

--

after this you retrieve the Connectionstrings what you need to modify and add to code-behind pages.
Member.aspx.cs, home.aspx.cs , register.aspx.cs, panelsites.master.cs files are c#.
then replace the connectionstring to yours in those files.
-------------------------------------------------------------------------------

after this you the source is available and free for you to continue and use,this is the startup free open source for you to free to use.

--------------------

Download the Databases:

GunzDB (whats different?)

In Account table you have a extra field "password" 

In Login You have extra field "UGradeID"

in Character You hae extra fields "UGradeID" , "UserID" , "Password" , "OldName"
none of these changes are really neccessary or new or different. they already exists and are used on gunz, i just added those same values available on other tables.
thats all.
---
GunzWeb Database is Standalone its to control the Frontpage News/updates/download/custom Objects , you can easily fill them with text or what you want to add.