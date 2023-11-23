<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Panelsites.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="WebApplication12._Default" %>



<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

 

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
           <div style="height: 4px;    width: 27%">
             
 
           <br />
             <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Caption="Top 10 Players" CaptionAlign="Top" ForeColor="Black" Height="100px" Width="580px" CssClass="GridPager" style="margin-top: 0px; margin-left: 1247px; margin-right: 64; margin-bottom: 0px;" BorderColor="Black" BorderStyle="Solid" BorderWidth="2px" CellPadding="1" CellSpacing="2" Font-Bold="False" Font-Names="felix titling,large" ShowFooter="True" ShowHeaderWhenEmpty="True" BackColor="#00356A" GridLines="Horizontal" HorizontalAlign="Center" AllowPaging="True">
                          <AlternatingRowStyle Font-Names="Verdana" ForeColor="#0099CC" HorizontalAlign="Center" VerticalAlign="Middle" CssClass=" " />
                          <Columns>
                              <asp:BoundField DataField="Level" HeaderText="Level" SortExpression="Level" FooterText="Most XP" NullDisplayText="nobody ranked 3" >
                              <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                              <HeaderStyle BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" VerticalAlign="Middle" />
                              <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                              </asp:BoundField>
                              <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" FooterText="The Best" NullDisplayText="nobody ranked 3" >
                              <HeaderStyle BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
                              <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                              </asp:BoundField>
                              <asp:BoundField DataField="KillCount" HeaderText="KillCount" SortExpression="KillCount" FooterText="Slayers" NullDisplayText="nobody ranked 3" >
                              <HeaderStyle BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
                              <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                              </asp:BoundField>
                              <asp:HyperLinkField HeaderText="Ranked Profiles" NavigateUrl="~/Pages/Register.aspx" Text="Profile" FooterText="dont miss it." Target="_search" >
                              <HeaderStyle BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" CssClass=" GridPager" />
                              <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                              </asp:HyperLinkField>
                          </Columns>
                          <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="#3366CC" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" CssClass=" GridPager" Font-Bold="True" Font-Names="Verdana" Font-Size="Smaller" ForeColor="Red" />
                          <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" ForeColor="#FF9900" Font-Names="Verdana" Height="15px" BorderColor="Black" BorderStyle="Solid" BorderWidth="2px" CssClass=" " Font-Bold="True" Font-Size="Smaller" Width="500px" BackColor="#003366" />
        <PagerSettings FirstPageText="First" LastPageText="Last" NextPageText="&gt;&gt;" PageButtonCount="5" PreviousPageText="&lt;&lt;" Mode="NextPrevious"></PagerSettings>
             
<PagerStyle CssClass="GridPager" HorizontalAlign="Center" VerticalAlign="Middle" ForeColor="#333333" Height="22px" Wrap="True" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Names="Verdana"></PagerStyle>
                   
                          <PagerTemplate>
                              POWERED BY c# HTML/CSS 2023&nbsp; - GunzCMS OPEN SOURCE
                          </PagerTemplate>
                   
                          <RowStyle Font-Names="Verdana" ForeColor="#0066CC" HorizontalAlign="Center" VerticalAlign="Middle" CssClass=" " Wrap="True" Font-Bold="True" Font-Size="Smaller" BackColor="#3366CC" BorderColor="#3366CC" BorderStyle="Solid" BorderWidth="1px" Width="100%" />
                          </asp:GridView>     
             
          </div>
        
         <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:localset %>" SelectCommand="SELECT [Level], [Name], [XP], [BP], [KillCount] FROM [Character] ORDER BY [XP] DESC, [KillCount] DESC"></asp:SqlDataSource>
      
     
      
              
                         
      
     <link href="~/site.css" rel="stylesheet" />

       
        <asp:SqlDataSource ID="SqlDataSource0" runat="server" ConnectionString="<%$ ConnectionStrings:localset %>" SelectCommand="SELECT [CurrPlayer], [MaxPlayer], [ServerName] FROM [ServerStatus]"></asp:SqlDataSource>
      
     <div style="height: 4px; width: 454px; margin-top: 0px;">
       <p style="color: #FFFFFF; height: 4px; margin-top: 0;"> &nbsp;&nbsp;&nbsp;&nbsp;<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:localset %>" SelectCommand="SELECT [Level], [Name], [XP], [BP], [KillCount] FROM [Character] ORDER BY [XP] DESC, [KillCount] DESC"></asp:SqlDataSource>
      </p>
         </div>
        
           
              
                         
      
      
  

  
         
 <asp:GridView ID="GridView3" runat="server"  HorizontalAlign="Left" AutoGenerateColumns="False" DataSourceID="SqlDataSource0" Caption="Server Status" CaptionAlign="Top" ForeColor="White" style="margin-left: 10px; margin-right: 0px; margin-top: 0px;" Width="369px" Height="16px" CssClass="GridPager" PageSize="1" BorderColor="White" BorderStyle="Solid" BorderWidth="2px" BackColor="#003366">
                          <AlternatingRowStyle Font-Names="Verdana" ForeColor="#FF9900" HorizontalAlign="Center" VerticalAlign="Middle" />
                          <Columns>
                              <asp:BoundField DataField="CurrPlayer" HeaderText="CurrPlayer" SortExpression="CurrPlayer" />
                              <asp:BoundField DataField="MaxPlayer" HeaderText="MaxPlayer" SortExpression="MaxPlayer" />
                              <asp:BoundField DataField="ServerName" HeaderText="ServerName" SortExpression="ServerName" />
                          </Columns>
                          <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                          <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" ForeColor="White" BackColor="#003366" />
        <PagerSettings FirstPageText="First" LastPageText="Last" NextPageText="&gt;&gt;" PageButtonCount="5" PreviousPageText="&lt;&lt;"></PagerSettings>

<PagerStyle CssClass="GridPager" HorizontalAlign="Center" VerticalAlign="Middle" BackColor=" "></PagerStyle>
                         
                          <RowStyle Font-Names="Verdana" ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle" Height="12px" Font-Bold="True" />
                          </asp:GridView>
      
      
          

     <asp:SqlDataSource ID="web" runat="server" ConnectionString="<%$ ConnectionStrings:asdswww %>" SelectCommand="SELECT [Download] FROM [webcontent]" ProviderName="<%$ ConnectionStrings:asdswww.ProviderName %>"></asp:SqlDataSource>

       
              

       
             <center class="offset-sm-0" style="margin-left: 210px; width: 982px; height: 125px; margin-right: 48; margin-top: 0;">   
           
      
          

     
 <div class="offset-sm-0" style="width: 620px; height: 909px;">
                 <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="web54" CaptionAlign="Top" ForeColor="Black" Width="820px" PageSize="3" CssClass="GridPager" CellPadding="1" ShowFooter="True" style="margin-left: 0px; margin-top: 36px; bottom: 200; margin-bottom: 42;" CellSpacing="2" BorderColor="Black" BorderStyle="Solid" BorderWidth="2px" HorizontalAlign="Center" BackColor="White" Font-Names="Verdana" Font-Bold="False" EnableSortingAndPagingCallbacks="True" Font-Size="Smaller" GridLines="Horizontal" RowHeaderColumn="News">
                          <AlternatingRowStyle Font-Names="arial, smaller" ForeColor="Black" Font-Bold="False" CssClass="GridPager" BackColor="White" BorderStyle="Inset" BorderWidth="2px" BorderColor="Black" Font-Size="Smaller" Width="1222px" />
                          <Columns>
                              <asp:BoundField DataField="News" HeaderText="announcements" SortExpression="News" FooterText="Powered By Neena" NullDisplayText="Its empty but its not just null">
                              <ControlStyle Width="5%" />
                              <HeaderStyle Font-Bold="True" Font-Names="Verdana" BorderColor="Black" BorderStyle="Solid" BorderWidth="2px" />
                              <ItemStyle Font-Bold="True" Font-Names="Verdana" HorizontalAlign="Center" VerticalAlign="Middle" ForeColor="Black" CssClass="GridPager" />
                              </asp:BoundField>
                          </Columns>
                          <EmptyDataRowStyle CssClass=" GridPager" HorizontalAlign="Center" VerticalAlign="Middle" />
                          <FooterStyle Font-Bold="False" ForeColor="White" Font-Names="Verdana" Font-Overline="False" Font-Size="Smaller" BackColor="#333333" Height="10px" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" />
                          <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" ForeColor="#FF9900" BackColor="#003366" Font-Bold="True" Font-Names="Arial" Height="15px" BorderColor="Black" BorderStyle="Solid" BorderWidth="2px" Font-Size="Smaller" Font-Italic="False" Width="100%" Wrap="True" />
        <PagerSettings FirstPageText="First" LastPageText="Last" NextPageText="&gt;&gt;" PageButtonCount="5" PreviousPageText="&lt;&lt;"></PagerSettings>

<PagerStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" ForeColor="Black" Height="20px"></PagerStyle>
                
                          <PagerTemplate>
                              &nbsp;Pager Footage Message
                          </PagerTemplate>
                
                          <RowStyle HorizontalAlign="Center" Font-Bold="False" Font-Italic="False" Font-Names="arial, smaller" ForeColor="Black" Height="40px" CssClass=" GridPager" BorderColor="White" BorderStyle="Inset" BorderWidth="1px" Font-Size="Smaller" Width="788px" />
                          <SelectedRowStyle HorizontalAlign="Left" VerticalAlign="Middle" BackColor="#FF9900" Font-Bold="True" ForeColor="White" />
            
                          </asp:GridView>
                 <asp:SqlDataSource ID="web54" runat="server" ConnectionString="<%$ ConnectionStrings:gunzweb %>" SelectCommand="SELECT [News] FROM [webcontent]"></asp:SqlDataSource>
           <br />
                 <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="sqldatawebupdate" AllowPaging="True" CaptionAlign="Top" ForeColor="Black" Height="15px" Width="820px" PageSize="1" CssClass="GridPager" BorderColor="Black" BorderStyle="Solid" BorderWidth="2px" CellPadding="1" BackColor="White" CellSpacing="2" EnableSortingAndPagingCallbacks="True" GridLines="Horizontal" HorizontalAlign="Center" RowHeaderColumn="Updates" ShowFooter="True">
                          <AlternatingRowStyle Font-Names="Verdana" ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle" Font-Bold="True" CssClass="GridPager" BackColor="#FF9900" />
                          <Columns>
                              <asp:BoundField DataField="Updates" HeaderText="Updates + patches" SortExpression="Updates" FooterText="links to latest updates">
                              <FooterStyle Font-Bold="True" />
                              <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                              <ItemStyle Font-Bold="True" Font-Names="Verdana" HorizontalAlign="Center" VerticalAlign="Middle" BackColor="White" />
                              </asp:BoundField>
                          </Columns>
                          <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Bold="True" ForeColor="White" BorderStyle="Solid" BackColor="#333333" BorderColor="White" BorderWidth="1px" Height="10px" Font-Names="Verdana" Font-Size="XX-Small" />
                          <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" ForeColor="#FF9900" BackColor="#003366" Font-Bold="True" Height="25px" Font-Names="Verdana" CssClass=" " Font-Italic="False" Font-Size="Smaller" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
        <PagerSettings FirstPageText="First" LastPageText="Last" NextPageText="&gt;&gt;" PageButtonCount="5" PreviousPageText="&lt;&lt;"></PagerSettings>

<PagerStyle CssClass="GridPager" HorizontalAlign="Center" VerticalAlign="Middle" BackColor="#666666" ForeColor="#999999"></PagerStyle>
                
                          <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Bold="True" Font-Italic="True" Font-Names="Verdana" ForeColor="Black" CssClass=" GridPager" />
                          <SelectedRowStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            
                          <SortedAscendingCellStyle BackColor="#FDF5AC" />
                          <SortedAscendingHeaderStyle BackColor="#4D0000" />
                          <SortedDescendingCellStyle BackColor="#FCF6C0" />
                          <SortedDescendingHeaderStyle BackColor="#820000" />
            
                          </asp:GridView>
                 <asp:SqlDataSource ID="sqldatawebupdate" runat="server" ConnectionString="<%$ ConnectionStrings:webupdates %>" ProviderName="<%$ ConnectionStrings:webupdates.ProviderName %>" SelectCommand="SELECT [Updates] FROM [webcontent]"></asp:SqlDataSource>
           
                 <br />
           
                 <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" DataSourceID="web" CaptionAlign="Top" Height="15px" Width="820px" PageSize="1" CssClass="GridPager" BorderStyle="Solid" CellPadding="1" CellSpacing="2" style="margin-top: 0" BackColor="White" EnableSortingAndPagingCallbacks="True" GridLines="Horizontal" HorizontalAlign="Center" RowHeaderColumn="Download" ShowFooter="True" BorderColor="Black" BorderWidth="2px" ForeColor="Black">
                          <AlternatingRowStyle Font-Names="Verdana" HorizontalAlign="Center" VerticalAlign="Middle" ForeColor="White" Wrap="False" />
                          <Columns>
                              <asp:BoundField DataField="Download" HeaderText="Download version client 1.X" SortExpression="Download" FooterText="Client Mirrors">
                              <HeaderStyle BorderColor="Black" HorizontalAlign="Left" />
                              <ItemStyle Font-Bold="True" Font-Names="Verdana" ForeColor="#FF9900" HorizontalAlign="Center" />
                              </asp:BoundField>
                          </Columns>
                          <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="#333333" ForeColor="White" Height="10px" Font-Bold="True" Font-Names="Verdana" Font-Size="X-Small" />
                          <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" ForeColor="#FF9900" BackColor="#003366" Font-Bold="False" Height="15px" Font-Names="Verdana" Font-Underline="False" BorderStyle="Solid" CssClass=" " Font-Size="Smaller" BorderColor="Black" BorderWidth="2px" />
        <PagerSettings FirstPageText="First" LastPageText="Last" NextPageText="&gt;&gt;" PageButtonCount="5" PreviousPageText="&lt;&lt;"></PagerSettings>

<PagerStyle CssClass="GridPager" HorizontalAlign="Center" VerticalAlign="Middle" ForeColor="#999999" BackColor="#666666"></PagerStyle>
                
                          <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Bold="True" Font-Italic="True" Font-Names="Verdana" ForeColor="White" CssClass="GridPager" />
                          <SelectedRowStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
            
                          <SortedAscendingCellStyle BackColor="#F1F1F1" />
                          <SortedAscendingHeaderStyle BackColor="#594B9C" />
                          <SortedDescendingCellStyle BackColor="#CAC9C9" />
                          <SortedDescendingHeaderStyle BackColor="#33276A" />
                    <PagerSettings FirstPageText="First" LastPageText="Last" NextPageText="&gt;&gt;" PageButtonCount="5" PreviousPageText="&lt;&lt;"></PagerSettings>

<PagerStyle CssClass="GridPager" HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" ForeColor="Black"></PagerStyle>
                          </asp:GridView>
    
     </center>
        <div style="height: 17px; width: 371px; margin-left: 10px; margin-top: 0px">
        <PagerStyle CssClass="GridPager" HorizontalAlign="Center" VerticalAlign="Middle" BackColor="whitesmoke">
        
             
           spacefree letters in teststand.<br />
        
             
            </div>
     <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:gunzwebConnectioncustom %>" SelectCommand="SELECT [Custom] FROM [webcontent]"></asp:SqlDataSource>
                              <div>           
            
     <asp:Panel ID="Panel2" runat="server" Height="100%" Width="100%">
         <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="White" BorderStyle="Solid" BorderWidth="2px" Caption="Custom" CaptionAlign="Top" CellPadding="0" CellSpacing="3" CssClass="GridPager" DataSourceID="SqlDataSource3" GridLines="Vertical" Height="135px" HorizontalAlign="Left" PageSize="5" style="margin-left: 9px; margin-top: 0px;" Width="369px">
             <AlternatingRowStyle BorderColor="White" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Height="31px" HorizontalAlign="Center" VerticalAlign="Middle" />
             <Columns>
                 <asp:BoundField DataField="Custom" HeaderText="Custom" NullDisplayText="this db is yet empty" SortExpression="Custom" />
             </Columns>
             <FooterStyle BackColor="White" ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle" />
             <HeaderStyle BackColor="#003366" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Italic="False" Font-Names="Verdana" ForeColor="#E7E7FF" Height="31px" HorizontalAlign="Center" VerticalAlign="Middle" />
             <PagerSettings FirstPageText="First" LastPageText="Last" NextPageText="&gt;&gt;" PageButtonCount="5" PreviousPageText="&lt;&lt;" />
             <PagerStyle BackColor="White" CssClass="GridPager" ForeColor="Black" Height="0px" HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" />
             <RowStyle BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Italic="True" Font-Names="Verdana" ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle" />
             <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
             <SortedAscendingCellStyle BackColor="#F1F1F1" />
             <SortedAscendingHeaderStyle BackColor="#594B9C" />
             <SortedDescendingCellStyle BackColor="#CAC9C9" />
             <SortedDescendingHeaderStyle BackColor="#33276A" />
         </asp:GridView>
                        <br />
         <br />
                        </asp:Panel>  </div>  
                

     <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:gunzwebConnectionString2 %>" SelectCommand="SELECT [Custom1] FROM [webcontent]" ProviderName="<%$ ConnectionStrings:gunzwebConnectionString2.ProviderName %>"></asp:SqlDataSource>
</div>
     </asp:Content>
