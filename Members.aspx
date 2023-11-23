<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Member.Master" AutoEventWireup="true" CodeBehind="Members.aspx.cs" Inherits="WebApplication12._Default2" %>



<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>




<%@ Register assembly="EO.Web" namespace="EO.Web" tagprefix="eo" %>




<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div style="height: 1px; width: 1451px; margin-top: 0">         
        <panel>

            <asp:DropDownList ID="DropDownList13" runat="server" OnSelectedIndexChanged="DDL2_SelectedIndexChanged" Style="z-index: 1; position: absolute; top: 515px; left: 828px; width: 216px; height: 28px; right: 296px;" DataSourceID="dropdownlistdb1" DataTextField="Name" DataValueField="CID" BackColor="#0066CC" Font-Bold="True" Font-Size="Smaller" ForeColor="Lime" TabIndex="2" ValidateRequestMode="Enabled" ViewStateMode="Enabled" CssClass="Badge">
                <asp:ListItem>selectedItem11</asp:ListItem>
            </asp:DropDownList>
        </panel></div>
     <link href="~/site.css" rel="stylesheet" />
 
    <div class="banneranex5" style="color: #003366; font-family: Verdana, Geneva, Tahoma, sans-serif; background-color:  black; width: 102%; margin-top: 0; height: 889px;" >
                         <asp:Label ID="Label3" runat="server" style="z-index: 1; position: absolute; top: 329px; left: 1052px; height: 28px; width: 244px; right: 150px;" BackColor="White" BorderColor="White" BorderStyle="Double" BorderWidth="1px" Font-Bold="True" Font-Names="Verdana" Font-Size="Small" ForeColor="Black" ViewStateMode="Enabled" Visible="False"></asp:Label>
                                  <asp:Label ID="Label4" runat="server" style="z-index: 1; position: absolute; top: 305px; left: 1052px; height: 24px; bottom: 137px; width: 125px;" Text="Welcome Back,  " ForeColor="White" Visible="False"></asp:Label>
        <asp:Label ID="Labelorder66" runat="server" visible="False" style="z-index: 1; position: absolute; top: 306px; left: 1180px; height: 21px; width: 196px;" Font-Bold="True" Font-Names="Verdana" Font-Size="Small"> !!</asp:Label>

        <asp:SqlDataSource ID="dropdownlistdb1" runat="server" ConnectionString="<%$ ConnectionStrings:ClanCrato21 %>" SelectCommand="SELECT CID, AID, Name, Level, Sex, CharNum, Hair, Face, XP, BP, HP, AP, FR, CR, ER, WR, head_slot, chest_slot, hands_slot, legs_slot, feet_slot, fingerl_slot, fingerr_slot, melee_slot, primary_slot, secondary_slot, custom1_slot, custom2_slot, RegDate, LastTime, PlayTime, GameCount, KillCount, DeathCount, DeleteFlag, DeleteName, head_itemid, chest_itemid, hands_itemid, legs_itemid, feet_itemid, fingerl_itemid, fingerr_itemid, melee_itemid, primary_itemid, secondary_itemid, custom1_itemid, custom2_itemid, QuestItemInfo, OldName, UserID, UGradeID, Password FROM Character WITH (nolock) WHERE (AID = @AID) AND (DeleteFlag = 0) ORDER BY CharNum" OldValuesParameterFormatString="original_{0}" CancelSelectOnNullParameter="False">
            <SelectParameters>
                       <asp:SessionParameter DefaultValue="@AID" Name="AID" SessionField="AID" />
                   </SelectParameters>
  </asp:SqlDataSource>

               <br />
                        

                    <asp:SqlDataSource ID="Clancreate1" runat="server" ConnectionString="<%$ ConnectionStrings:ClanCrato21 %>" SelectCommand="SELECT [CID], [AID], [RegDate] FROM [Character]" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
   <asp:SqlDataSource ID="Clancreate" runat="server" ConnectionString="<%$ ConnectionStrings:ClanCreator %>" SelectCommand="SELECT [Name], [CLID], [MasterCID] FROM [Clan]" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
                                        <asp:SqlDataSource ID="CharTB" runat="server" ConnectionString="<%$ ConnectionStrings:CharTB %>" SelectCommand="SELECT CID AS Expr1, AID AS Expr2, Name AS Expr3, Level AS Expr4, Sex AS Expr5, CharNum AS Expr6, DeleteFlag, DeleteName FROM Character" DeleteCommand="spDeleteChar" InsertCommand="spInsertChar" UpdateCommand="UPDATE Character WITH (rowlock) SET Name = @Name, Level = @Level, Sex = @Sex, Hair = @Hair, Face = @Face, XP = @XP, BP = @BP, HP = @HP, AP = @AP, FR = @FR, CR = @CR, ER = @ER, WR = @WR WHERE (Name = @Name) AND (CharNum = @CharNum)" DeleteCommandType="StoredProcedure" InsertCommandType="StoredProcedure" ProviderName="System.Data.SqlClient">
                                            <DeleteParameters>
                                                <asp:Parameter Name="AID" />
                                                <asp:Parameter Name="CharNum" />
                                                <asp:Parameter Name="CharName" />
                                            </DeleteParameters>
                                            <InsertParameters>
                                                <asp:Parameter Name="AID" />
                                                <asp:Parameter Name="CharNum" />
                                                <asp:Parameter Name="Name" />
                                                <asp:Parameter Name="Sex" />
                                                <asp:Parameter Name="Hair" />
                                                <asp:Parameter Name="Face" />
                                                <asp:Parameter Name="Costume" Type="Int32" />
                                            </InsertParameters>
                                            <UpdateParameters>
                                                <asp:Parameter Name="Name" />
                                                <asp:Parameter Name="Level" />
                                                <asp:Parameter Name="Sex" />
                                                <asp:Parameter Name="Hair" />
                                                <asp:Parameter Name="Face" />
                                                <asp:Parameter Name="XP" />
                                                <asp:Parameter Name="BP" />
                                                <asp:Parameter Name="HP" />
                                                <asp:Parameter Name="AP" />
                                                <asp:Parameter Name="FR" />
                                                <asp:Parameter Name="CR" />
                                                <asp:Parameter Name="ER" />
                                                <asp:Parameter Name="WR" />
                                                <asp:Parameter Name="CharNum" />
                                            </UpdateParameters>
                         </asp:SqlDataSource>
         
                         <p style="border: thin ridge #003366; width: 215px; color: #FFFFFF; font-family: Verdana, Geneva, Tahoma, sans-serif; background-color: #000000; margin-left: 826px; height: 23px; font-size: smaller; font-weight: bold; font-style: normal; line-height: normal; vertical-align: middle; text-align: center; white-space: nowrap; list-style-type: circle; list-style-image: inherit; list-style-position: outside; table-layout: auto; border-collapse: collapse; border-spacing: inherit; empty-cells: inherit; caption-side: top; margin-top: 11px; right: 11287px;" class="gones">&nbsp;----theme console-----</p>
                         <p style="border: thin ridge #FFFFFF; width: 220px; color: #FFFFFF; font-family: Verdana, Geneva, Tahoma, sans-serif; background-color: #003366; margin-left: 826px; height: 629px; font-size: smaller; font-weight: bold; font-style: normal; margin-top: 1px; margin-bottom: 0px;" selectcommand="SELECT * FROM ClanMember WHERE CID = '&quot;+Session['CID']+&quot;'">   
              <asp:Button ID="Button555" runat="server" OnClick="ChangePassword_UserPanelCLicks" CssClass="auto-style6" Text="Change Password" Font-Bold="True" Font-Names="Verdana" ForeColor="White" Height="27px" style="margin-left: 0px; margin-top: 0px;" Width="218px" BackColor="#333333" BorderColor="#0066CC" BorderStyle="Solid" BorderWidth="2px" Font-Size="Smaller" />
                   <asp:TextBox ID="TextBox672" runat="server" style="margin-left: 2px; margin-right: 0; margin-top: 0px;" Width="214px" Height="23px" BackColor="#FF9900" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Verdana" Font-Size="Smaller" ForeColor="Black" CssClass="accordion-header">New Password</asp:TextBox>   
                   <asp:TextBox ID="TextBox667" runat="server" Width="214px" Height="20px" CssClass="offset-sm-0" style="margin-left: 2px; margin-top: 0px" BackColor="#FF9900" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Verdana" Font-Size="Smaller">Current Password</asp:TextBox>   
              <asp:Button ID="Button556" runat="server" OnClick="ChangeName_UserPanelCLick" CssClass="auto-style6" Text="Change Name" Font-Bold="True" Font-Names="Verdana" ForeColor="White" Height="36px" style="margin-left: 0px; margin-top: 0px;" Width="217px" BackColor="#333333" BorderColor="#0066CC" BorderStyle="Solid" BorderWidth="2px" Font-Size="Smaller" />
                   <asp:TextBox ID="TextBox679" runat="server" style="margin-left: 0px; margin-right: 0; margin-top: 0px;" Width="217px" Height="21px" BackColor="#FF9900" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Verdana" Font-Size="Smaller" ForeColor="Black" CssClass="accordion-header"></asp:TextBox>   
                   <asp:TextBox ID="TextBox675" runat="server" style="margin-left: 0px; margin-right: 0; margin-top: 2px;" Width="217px" Height="21px" BackColor="#FF9900" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Verdana" Font-Size="Smaller" ForeColor="Black" CssClass="accordion-header">New Name</asp:TextBox>   
                         
                   <asp:Button ID="Buttonitem" runat="server" OnClick="Itembutton" CssClass="auto-style6" Text="Send Item" Font-Bold="True" Font-Names="Verdana" ForeColor="White" Height="29px" style="margin-left: 0px; margin-top: 0px;" Width="217px" BackColor="#333333" BorderColor="#0066CC" BorderStyle="Solid" BorderWidth="2px" Font-Size="Smaller" />
                   <asp:TextBox ID="itemid" runat="server" style="margin-left: 0px; margin-right: 0; margin-top: 0px;" Width="217px" Height="21px" BackColor="#FF9900" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Verdana" Font-Size="Smaller" ForeColor="#0066CC" CssClass="accordion-header" ReadOnly="True" MaxLength="6" ToolTip="Select the item from Listing.">ItemID</asp:TextBox>   
                   <asp:TextBox ID="CharID" runat="server" style="margin-left: 0px; margin-right: 0; margin-top: 3px;" Width="217px" Height="19px" BackColor="#FF9900" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Verdana" Font-Size="Smaller" ForeColor="#CC00CC" CssClass="accordion-header" MaxLength="12" Rows="2" TabIndex="2" ToolTip="Type Name Who Pays The item,">Buyers Name</asp:TextBox>   
                                                               <asp:TextBox ID="price" runat="server" style="margin-left: 0px; margin-right: 0; margin-top: 3px;" Width="217px" Height="21px" BackColor="#FF9900" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Verdana" Font-Size="Smaller" ForeColor="Lime" CssClass="accordion-header" MaxLength="15" ReadOnly="True" TabIndex="2" ToolTip="The Price.">Bounty Price</asp:TextBox>   
                                                               <br />
                                      <br />
                             <asp:TextBox ID="Damage" runat="server" style="margin-left: 0px; margin-right: 0; margin-top: 78px; margin-bottom: 12px;" Width="217px" Height="21px" BackColor="#FF9900" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Verdana" Font-Size="Smaller" ForeColor="Red" CssClass="accordion-header" MaxLength="15" ReadOnly="True" TabIndex="2">Damage</asp:TextBox>   
                                                                                              <asp:TextBox ID="Delay" runat="server" style="margin-left: 0px; margin-right: 0; margin-top: 9px;" Width="217px" Height="21px" BackColor="#FF9900" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Verdana" Font-Size="Smaller" ForeColor="White" CssClass="accordion-header" MaxLength="15" ReadOnly="True" TabIndex="2">Delay</asp:TextBox>   
                             <asp:TextBox ID="Hp" runat="server" style="margin-left: 0px; margin-right: 0; margin-top: 17px;" Width="217px" Height="21px" BackColor="#FF9900" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Verdana" Font-Size="Smaller" ForeColor="#99FF33" CssClass="accordion-header" MaxLength="15" ReadOnly="True" TabIndex="2">Hp</asp:TextBox>
                             <asp:TextBox ID="Ap" runat="server" style="margin-left: 0px; margin-right: 0; margin-top: 17px;" Width="217px" Height="21px" BackColor="#FF9900" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Verdana" Font-Size="Smaller" ForeColor="#9933FF" CssClass="accordion-header" MaxLength="15" ReadOnly="True" TabIndex="2">Ap</asp:TextBox>
                
                
                   <asp:TextBox ID="ClanName" runat="server" style="margin-left: 0px; margin-right: 0; margin-top: 95px;" Width="217px" Height="21px" BackColor="#FF9900" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Verdana" Font-Size="Smaller" ForeColor="Black" CssClass="accordion-header">Clan Name</asp:TextBox>   
                   <asp:TextBox ID="ClanLeader" runat="server" style="margin-left: 0px; margin-right: 0; margin-top: 3px;" Width="217px" Height="21px" BackColor="#FF9900" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Verdana" Font-Size="Smaller" ForeColor="Black" CssClass="accordion-header">Clanmaster</asp:TextBox>  
                                                                     <asp:Button ID="Button1" OnClick="ClanCreate_Click"  runat="server" style="z-index: 1; position: absolute; top: 815px; left: 827px; width: 218px; height: 31px; margin-top: 0px" Text="Clan Creation" BackColor="#333333" BorderColor="#0066CC" BorderStyle="Solid" BorderWidth="2px" Font-Bold="True" Font-Size="Smaller" ForeColor="White" />
             
             
                             <asp:GridView ID="GridView1" runat="server" style="z-index: 1; width: 153px; height: 56px; position: absolute; top: 325px; right: 1121px;" DataSourceID="cashtable" PageSize="1" AutoGenerateColumns="False" BackColor="White" CellPadding="4" CellSpacing="2" CssClass="GridPager" BorderColor="#3366CC" BorderStyle="Ridge" Font-Bold="False" Font-Italic="False" Font-Names="Arial" Font-Overline="False" Font-Size="Medium" Font-Strikeout="False" Font-Underline="False" ForeColor="Black" BorderWidth="0.25em" Caption="Your Characterlist" CaptionAlign="Top" HorizontalAlign="Left">
                                 <AlternatingRowStyle HorizontalAlign="Center" VerticalAlign="Top" />
                                 <Columns>
                                     <asp:BoundField DataField="AID" HeaderText="AID" SortExpression="AID" Visible="False" />
                                     <asp:BoundField DataField="Level" HeaderText="Level" SortExpression="Level" />
                                     <asp:BoundField DataField="KillCount" HeaderText="KillCount" SortExpression="KillCount" />
                                     <asp:BoundField DataField="DeathCount" HeaderText="DeathCount" SortExpression="DeathCount" />
                                     <asp:BoundField DataField="DeleteFlag" HeaderText="DeleteFlag" SortExpression="DeleteFlag" Visible="False" />
                                     <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" NullDisplayText="Nameless" ReadOnly="True" >
                                     <ItemStyle BorderColor="White" BorderStyle="Solid" BorderWidth="1px" ForeColor="#FF9900" />
                                     </asp:BoundField>
                                     <asp:BoundField DataField="BP" HeaderText="Bounty" ReadOnly="True" NullDisplayText="Zero" >
                                     <HeaderStyle BorderColor="#336699" BorderStyle="Solid" BorderWidth="1px" />
                                     <ItemStyle ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle" />
                                     </asp:BoundField>
                                 </Columns>
                                 <FooterStyle Height="2px" />
                                 <HeaderStyle BackColor="#003366" ForeColor="#33CC33" HorizontalAlign="Center" BorderColor="Black" BorderStyle="Inset" BorderWidth="1px" Font-Bold="False" Font-Italic="False" Font-Names="Copperplate Gothic Light" Font-Size="Smaller" />
                                 <RowStyle HorizontalAlign="Center" BackColor="Black" BorderColor="Black" BorderStyle="Solid" BorderWidth="2px" VerticalAlign="Top" />
                          
                             </asp:GridView>

                                          <asp:GridView ID="GridView2" runat="server" style="z-index: 1; width: 254px; height: 55px; position: absolute; top: 355px; left: 1077px; right: 154px; margin-left: 0px;" DataSourceID="MyChars" PageSize="4" AutoGenerateColumns="False" CellPadding="2" CellSpacing="1" DataKeyNames="CID,CLID,CMID" OnSelectedIndexChanged="GridView2_SelectedIndexChanged" Caption="Your Clans" CaptionAlign="Top" BorderColor="#FF9900" BorderStyle="Ridge" BorderWidth="2px" HorizontalAlign="Left" ForeColor="Black" BackColor="#003366">
       <AlternatingRowStyle HorizontalAlign="Center" VerticalAlign="Middle" BorderColor="#006699" BorderWidth="1px" BorderStyle="Solid" />
       <Columns>
           <asp:BoundField DataField="CID" HeaderText="CID" SortExpression="CID" InsertVisible="False" ReadOnly="True" Visible="False" >
           </asp:BoundField>
           <asp:BoundField DataField="AID" HeaderText="AID" SortExpression="AID" Visible="False">
           </asp:BoundField>
           <asp:BoundField DataField="Name" HeaderText="Member" SortExpression="Name">
           </asp:BoundField>
           <asp:BoundField DataField="Level" HeaderText="Level" SortExpression="Level" Visible="False">
           </asp:BoundField>
           <asp:BoundField DataField="KillCount" HeaderText="KillCount" SortExpression="KillCount" Visible="False" />
           <asp:BoundField DataField="DeathCount" HeaderText="DeathCount" SortExpression="DeathCount" Visible="False" />
           <asp:BoundField DataField="DeleteFlag" HeaderText="DeleteFlag" SortExpression="DeleteFlag" Visible="False" />
           <asp:BoundField DataField="Expr1" HeaderText="Name" SortExpression="Expr1" />
           <asp:BoundField DataField="CLID" HeaderText="CLID" InsertVisible="False" ReadOnly="True" SortExpression="CLID" Visible="False" />
           <asp:BoundField DataField="MasterCID" HeaderText="MasterCID" SortExpression="MasterCID" Visible="False" />
           <asp:BoundField DataField="CMID" HeaderText="CMID" InsertVisible="False" ReadOnly="True" SortExpression="CMID" Visible="False" />
           <asp:BoundField DataField="Expr2" HeaderText="Expr2" SortExpression="Expr2" Visible="False" />
           <asp:BoundField DataField="Expr3" HeaderText="Expr3" SortExpression="Expr3" Visible="False" />
       </Columns>
       <FooterStyle Height="2px" HorizontalAlign="Center" VerticalAlign="Middle" />
       <HeaderStyle ForeColor="#FF9900" HorizontalAlign="Center" VerticalAlign="Middle" BorderColor="White" BorderStyle="Solid" BorderWidth="2px" CssClass="GridPager" Font-Names="Arial" Font-Size="Smaller" Height="10px" />
       <RowStyle ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" BackColor="Black" BorderColor="#0066CC" BorderStyle="Ridge" BorderWidth="1px" Font-Names="Arial" Font-Size="Small" Font-Bold="True" Font-Italic="False" Height="10px" />

   </asp:GridView>

                             &nbsp;<asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDL_SelectedIndexChanged" style="z-index: 1; position: absolute; top: 752px; left: 827px; width: 217px; height: 28px; right: 408px;" DataSourceID="itemlist1" DataTextField="Name" DataValueField="ItemID" BackColor="#0066CC" Font-Bold="True" Font-Size="Smaller" ForeColor="White" TabIndex="2" ToolTip="You Gotta Buy It If You Touch It!" ValidateRequestMode="Enabled" ViewStateMode="Enabled" DataTextFormatString="{0:c}" CausesValidation="True">
                                                               <asp:ListItem>Bounty</asp:ListItem>
                                                               <asp:ListItem>Damage</asp:ListItem>
                                                           </asp:DropDownList>
                             <asp:Label ID="errorlabel" runat="server" AssociatedControlID="Label3" CssClass="GridPager" Font-Bold="True" Font-Names="Verdana" Font-Size="Medium" ForeColor="#FF3300" style="z-index: 1; left: 1060px; top: 215px; position: absolute; height: 21px; width: 149px" Text="Error:" Visible="False"></asp:Label>
                             </p>
               <asp:Label ID="Label11" runat="server" style="z-index: 1; position: absolute; top: 528px; left: 1077px; height: 74px; bottom: 65px; width: 199px;" Text="-  &quot; *Steal or Spend when buying item,  input other characters name to steal other character's bounties for fun.&quot;" BorderColor="#FF9900" BorderStyle="Solid" BorderWidth="0.3em" Font-Bold="True" Font-Names="Arial" Font-Size="0.7em" ForeColor="White" ToolTip="Enter Character's Name Who Buys The Item For You!" BackColor="#003366" CssClass="Badge"></asp:Label>

              <asp:Label ID="Label10" runat="server" style="z-index: 1; position: absolute; top: 471px; left: 958px; height: 23px; bottom: 77px; width: 201px;" Text="*Steal or Spend" BorderColor="Black" BorderStyle="None" BorderWidth="1px" Font-Bold="True" Font-Names="Arial" Font-Size="0.7em" ForeColor="#3366CC" ToolTip="Enter Character's Name Who Buys The Item For You!"></asp:Label>

    <asp:Label ID="Label9" runat="server" style="z-index: 1; position: absolute; top: 495px; left: 970px; height: 23px; bottom: 53px; width: 201px;" Text="Bounty Price." BorderColor="Black" BorderStyle="None" BorderWidth="1px" Font-Bold="True" Font-Names="Arial" Font-Size="0.7em" ForeColor="#FF3300"></asp:Label>
                                                                                                                                        <center style="height: 6px; margin-top: 15px">     <asp:Label ID="Label8" runat="server" style="z-index: 1; position: absolute; top: 551px; height: 39px; bottom: 420px; width: 222px; left: 828px;" Text="*Select Your Character Inventory!" BorderColor="Black" BorderStyle="None" BorderWidth="1px" Font-Bold="True" Font-Names="Arial" Font-Size="0.9em" ForeColor="Red" ToolTip="inventory to receive the items." Font-Italic="False" Font-Underline="False"></asp:Label></center>

                                                           <center style="height: 4px; margin-top: 0px">     <asp:Label ID="Label1" runat="server" style="z-index: 1; position: absolute; top: 655px; left: 835px; height: 23px; bottom: 64px; width: 201px;" Text="Delay" BorderColor="Black" BorderStyle="None" BorderWidth="1px" Font-Bold="True" Font-Names="Arial" Font-Size="0.6em" ForeColor="White"></asp:Label>
                          </center>
                              <center style="height: 6px">     <asp:Label ID="Label2" runat="server" style="z-index: 1; position: absolute; top: 602px; left: 836px; height: 23px; bottom: 107px; width: 201px; margin-top: 10px;" Text="Damage" BorderColor="Black" BorderStyle="None" BorderWidth="1px" Font-Bold="True" Font-Names="Arial" Font-Size="0.6em" ForeColor="White"></asp:Label></center>
                                                                                        <center style="height: 2px; margin-top: 0">     <asp:Label ID="Label6" runat="server" style="z-index: 1; position: absolute; top: 690px; height: 23px; bottom: 29px; width: 201px; left: 835px;" Text="Hp" BorderColor="Black" BorderStyle="None" BorderWidth="1px" Font-Bold="True" Font-Names="Arial" Font-Size="0.6em" ForeColor="White"></asp:Label></center>
                                                                                        <center style="height: 6px">     <asp:Label ID="Label7" runat="server" style="z-index: 1; position: absolute; top: 729px; left: 836px; height: 23px; bottom: -1px; width: 201px;" Text="Ap" BorderColor="Black" BorderStyle="None" BorderWidth="1px" Font-Bold="True" Font-Names="Arial" Font-Size="0.6em" ForeColor="White"></asp:Label></center>

                              <center style="height: 1px; margin-top: 0">     <asp:Label ID="Label5" runat="server" style="z-index: 1; position: absolute; top: 781px; left: 834px; height: 23px; bottom: 206px; width: 201px;" Text="Select Item from the List." BorderColor="Black" BorderStyle="None" BorderWidth="1px" Font-Bold="True" Font-Names="Arial" Font-Size="0.6em" ForeColor="White"></asp:Label></center>
        <asp:SqlDataSource ID="itemlist1" runat="server" ConnectionString="<%$ ConnectionStrings:GunzDBConnectionString6 %>" SelectCommand="SELECT DISTINCT [Name], [ResRace], [ResLevel], [Slot], [Damage], [Delay], [BountyPrice], [MaxBullet], [ItemID] FROM [Item] WHERE ([BountyPrice] = @BountyPrice) ORDER BY [Damage], [BountyPrice], [Name] DESC" OldValuesParameterFormatString="original_{0}">
                                                                                                                                    <SelectParameters>
                                                                                                                                        <asp:Parameter DefaultValue="2500" Name="BountyPrice" Type="Int32" />
                                                                                                                                    </SelectParameters>
                                                                                                                                </asp:SqlDataSource>
                                                                 
                             <p style="border: thin solid #E65F04; width: 214px; color: #E65F04; font-family: Verdana, Geneva, Tahoma, sans-serif; background-color: #333333; margin-left: 826px; height: 23px; margin-top: 0;" class="gones"> 
      
                         <p style="border: thin groove #E65F04; width: 216px; color: #FFFFFF; font-family: Verdana, Geneva, Tahoma, sans-serif; background-color: #333333; margin-left: 825px; height: 23px; font-size: smaller; font-weight: bold; font-style: normal; margin-top: 0;" class="gones">   
                             &nbsp;</p>

                                                      

                             <asp:SqlDataSource ID="cashtable" runat="server" ConnectionString="<%$ ConnectionStrings:GunzDBConnectionString674 %>" SelectCommand="SELECT DISTINCT BP, AID, Name, Level, KillCount, DeathCount, DeleteFlag FROM Character WHERE (AID = @AID)" ProviderName="System.Data.SqlClient">
                                 <SelectParameters>
                                     <asp:SessionParameter Name="AID" SessionField="Aid" Type="Int32" />
                                 </SelectParameters>
                                     </asp:SqlDataSource>
                 <asp:SqlDataSource ID="ItemDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ItemDetails %>" SelectCommand="SELECT [Name], [ResLevel], [ResSex], [Slot], [Damage], [Delay], [HP], [AP], [Description], [MaxBullet], [ReloadTime], [Magazine] FROM [Item]" ProviderName="System.Data.SqlClient">
                 </asp:SqlDataSource>
                                 
        <asp:SqlDataSource ID="MyChars" runat="server" ConnectionString="<%$ ConnectionStrings:CharMY %>" SelectCommand="SELECT Character.CID, Character.AID, Character.Name, Character.Level, Character.Sex, Character.CharNum, Character.Hair, Character.Face, Character.XP, Character.BP, Character.HP, Character.AP, Character.FR, Character.CR, Character.ER, Character.WR, Character.head_slot, Character.chest_slot, Character.hands_slot, Character.legs_slot, Character.feet_slot, Character.fingerl_slot, Character.fingerr_slot, Character.melee_slot, Character.primary_slot, Character.secondary_slot, Character.custom1_slot, Character.custom2_slot, Character.RegDate, Character.LastTime, Character.PlayTime, Character.GameCount, Character.KillCount, Character.DeathCount, Character.DeleteFlag, Character.DeleteName, Character.head_itemid, Character.chest_itemid, Character.hands_itemid, Character.legs_itemid, Character.feet_itemid, Character.fingerl_itemid, Character.fingerr_itemid, Character.melee_itemid, Character.primary_itemid, Character.secondary_itemid, Character.custom1_itemid, Character.custom2_itemid, Character.QuestItemInfo, Character.OldName, Character.UserID, Character.UGradeID, Character.Password, Clan.Name AS Expr1, Clan.CLID, Clan.MasterCID, ClanMember.CMID, ClanMember.CLID AS Expr2, ClanMember.CID AS Expr3 FROM Character WITH (nolock) INNER JOIN Clan ON Character.CID = Clan.MasterCID INNER JOIN ClanMember ON Character.CID = ClanMember.CID AND Clan.CLID = ClanMember.CLID WHERE (Character.AID = @AID) AND (Character.DeleteFlag = 0) ORDER BY Character.CharNum">
            <FilterParameters>
                <asp:QueryStringParameter Direction="ReturnValue" Name="Select" QueryStringField="SELECT * FROM Character(nolock) WHERE AID = '&quot;+ Session['AID'] + &quot;' AND DeleteFlag = 0 ORDER BY CharNum ASC" />
                                     </FilterParameters>
                                     <SelectParameters>
                                         <asp:SessionParameter DefaultValue="@AID" Name="AID" SessionField="AID" /> 
                                     </SelectParameters>
               </asp:SqlDataSource>
                            <asp:SqlDataSource ID="itemlist" runat="server" ConnectionString="<%$ ConnectionStrings:localset %>" SelectCommand="SELECT [CIID], [CID], [ItemID], [RegDate] FROM [CharacterItem]" OldValuesParameterFormatString="original_{0}" ProviderName="System.Data.SqlClient">
                                                                     </asp:SqlDataSource>
       </div>    
    </asp:Content>
