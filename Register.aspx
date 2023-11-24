<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Panelsites.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WebApplication12._Default0" %>



<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>




<%@ Register assembly="EO.Web" namespace="EO.Web" tagprefix="eo" %>




<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
     <p style="background-color: #000000; height: 100%; width: 102%; margin-left: 0px; margin-top: 0px; margin-bottom: 0px;">
               
                             <asp:Label ID="InfoLabel3" runat="server" Font-Names="Verdana" Font-Size="Smaller" ForeColor="White" style="z-index: 1; position: absolute; top: 400px; left: 534px; width: 408px; height: 46px;" Text="Create an &nbsp;Account now and Register,&nbsp;&nbsp;&nbsp;No Verification Required!* 5 Letters For UserID and Password Requirement!" BackColor="#333333" BorderColor="Red" BorderStyle="Groove" BorderWidth="2px"></asp:Label>

                            <asp:Label ID="UserLabel2" runat="server" Font-Names="Verdana" Font-Size="Smaller" ForeColor="#3399FF" style="z-index: 1; position: absolute; top: 340px; left: 538px; width: 183px; height: 26px;" Text="UserID" Font-Bold="True"></asp:Label>

                        <asp:Label ID="PaswordLabel1" runat="server" Font-Names="Verdana" Font-Size="Smaller" ForeColor="White" style="z-index: 1; position: absolute; top: 339px; left: 737px; width: 139px; height: 28px; margin-left: 53px;" Text="Password" Font-Bold="True"></asp:Label>

                            <asp:Label ID="TopStrapBarLabel4" runat="server" Font-Names="Verdana" Font-Size="Small" ForeColor="#FF3300" style="z-index: 1; position: absolute; top: 243px; left: 4px; width: 1853px; height: 66px;" Text="Custom-Navigation For Whatever. else remove it ." BackColor="Black" CssClass="GridPager" Font-Bold="True" Font-Italic="True"></asp:Label>

                             <asp:TextBox ID="User" runat="server" Width="165px" BackColor="#0066CC" Height="27px" style="margin-left: 535px; margin-bottom: 32; margin-right: 0; margin-top: 48;" CssClass="SlideMenu13" Font-Names="Verdana" Font-Size="Medium" ForeColor="#FF9900" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" ToolTip="Your UserID Here!">UserID</asp:TextBox>    
 
    
            <asp:TextBox ID="Password" runat="server" style="margin-left: 4px; margin-top: 64px;" Width="165px" BackColor="#0066CC" CssClass="SlideMenu13" Height="27px" ToolTip="Password Here" Font-Size="Medium" ForeColor="#FF9900" Font-Names="Arial" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" TextMode="Password"></asp:TextBox>     
 
    
                             <asp:Button ID="Button1" runat="server" OnClick="ButtonRegister_Click" CssClass="auto-style6" Text="Register" Font-Bold="True" Font-Names="Verdana" ForeColor="Black" Height="27px" style="margin-left: 4px; margin-top: 8px;" Width="103px" BackColor="#336699" BorderColor="White" BorderStyle="Groove" BorderWidth="2px" ToolTip="Login to Member Panel After Registration!" />
 
    
     <eo:SlideMenu ID="SlideMenu13" runat="server" CausesValidation="True" ClientIDMode="AutoID" ControlSkinID="Style1" CssBlock="&lt;style type=&quot;text/css&quot;&gt;
.SlideMenu14 {background-color:white;background-image:url(&quot;00000003&quot;);background-position:right 0%;background-repeat:no-repeat;color:#215DC6}
.SlideMenu15 {background-color:#d6dff7;border-bottom-color:white;border-bottom-style:solid;border-bottom-width:1px;border-left-color:white;border-left-style:solid;border-left-width:1px;border-right-color:white;border-right-style:solid;border-right-width:1px;border-top-color:white;border-top-width:1px;color:#215dc6;cursor:pointer;cursor:hand;font-family:tahoma;font-size:11px;font-weight:normal;padding-bottom:9px;padding-left:13px;padding-right:2px;padding-top:9px}
.SlideMenu16 {color:#215DC6}
.SlideMenu17 {color:#428eff;text-decoration:underline}
&lt;/style&gt;
&lt;style type=&quot;text/css&quot;&gt;
&lt;/style&gt;
&lt;style type=&quot;text/css&quot;&gt;
.SlideMenu11 {background-color:White;border-bottom-color:#dddddd;border-bottom-style:solid;border-bottom-width:1px;color:#000099}
.SlideMenu12 {background-color:#CDE6F7;color:#000099}
.SlideMenu13 {cursor:pointer;cursor:hand;font-family:arial;font-size:12px}
&lt;/style&gt;
&lt;style type=&quot;text/css&quot;&gt;
&lt;/style&gt;" DataTable="taba" MultiPageID="" SkinID="asda" SlidePaneHeight="300" style="z-index: 1; position: absolute; top: 263px; left: 0px; margin-left: 232; margin-top: 0; margin-bottom: 94;" Width="420px" DesignOptions-BackColor="Black" SubMenuIconUrl="" TopLevelItemAlign="Right" DesignOptions-Top="700" ExpandDelay="2" ScrollDownLookID="Auto" SingleExpand="False" AutoSelectSource="ItemClickAndNavigateUrl" CssFile="~/site.css" DesignOptions-Left="150" EnableKeyboardNavigation="True" EnableScrolling="True" KeepExpandedOnClick="True" RaisesServerEvent="True" RightToLeft="True" SaveStateCrossPages="True" ScrollUpLookID="Auto" ValidateRequestMode="Enabled">
                                   <LookItems>
                                       <eo:MenuItem Height="22" ItemID="_TopLevelItem" LeftIcon-ExpandedUrl="00020006" LeftIcon-Url="00020007" NormalStyle-CssClass="SlideMenu11" SelectedStyle-CssClass="SlideMenu12">
                                           <SubMenu CollapseEffect-Type="GlideTopToBottom" DefaultItemLookID="_TopGroup" ExpandEffect-Type="RadialWipeClock" ExpandDirection="TopLeft">
                                           </SubMenu>
                                       </eo:MenuItem>
                                       <eo:MenuItem ItemID="_Default" Text-NoWrap="False" Text-Padding-Left="20">
                                       </eo:MenuItem>
                                   </LookItems>
                                   <TopGroup DefaultItemLookID="_TopGroup" Style-CssClass="SlideMenu13" Style-CssText="background-color:#333333;color:white;" Orientation="Vertical">
                                       <Items>
                                           <eo:MenuItem Text-Html="Downloadbles" ExpandedStyle-CssText="font-family: Verdana, Geneva, Tahoma, sans-serif" HoverStyle-CssText="background-repeat:repeat-y;border-bottom-color:white;border-bottom-style:double;border-bottom-width:1px;border-left-color:white;border-left-style:double;border-left-width:1px;border-right-color:white;border-right-style:double;border-right-width:1px;border-top-color:white;border-top-style:double;border-top-width:1px;" Image-Url="" RightIcon-Url="" SubMenuIcon="None" Width="40" LookID="_TopLevelItem">
                                               <SubMenu CollapseEffect-Type="Fade" ExpandEffect-Type="Pixelate" Style-CssText="color:white;">
                                                   <Items>
                                                       <eo:MenuItem Text-Html="&lt;b&gt;Download&lt;/b&gt;: any &lt;font color=&quot;red&quot;&gt;Client&lt;/font&gt; here." CausesValidation="True" SubMenuIcon="None">
                                                           <SubMenu CausesValidation="True" ExpandEffect-Type="GlideBottomToTop" Style-CssText="color:white;">
                                                           </SubMenu>
                                                       </eo:MenuItem>
                                                   </Items>
                                               </SubMenu>
                                           </eo:MenuItem>
                                           <eo:MenuItem Text-Html="FAQS AND HELP" Image-Url="">
                                               <SubMenu>
                                                   <Items>
                                                       <eo:MenuItem Text-Html="&lt;b&gt;Read About Us&lt;/b&gt;: Policy and &lt;font color=&quot;red&quot;&gt;Terms&lt;/font&gt;here.">
                                                       </eo:MenuItem>
                                                   </Items>
                                               </SubMenu>
                                           </eo:MenuItem>
                                           <eo:MenuItem Text-Html="Discord Connect up">
                                               <SubMenu>
                                                   <Items>
                                                       <eo:MenuItem Text-Html="&lt;b&gt;Find and Join Us&lt;/b&gt;: at &lt;font color=&quot;red&quot;&gt;Discord&lt;/font&gt;here.">
                                                       </eo:MenuItem>
                                                   </Items>
                                               </SubMenu>
                                           </eo:MenuItem>
                                           <eo:MenuItem Text-Html="Social-Media/Affiliates">
                                               <SubMenu>
                                                   <Items>
                                                       <eo:MenuItem Text-Html="&lt;b&gt;Breaking News&lt;/b&gt;: here&lt;font color=&quot;red&quot;&gt;Find more&lt;/font&gt; here." SelectedExpandedStyle-CssText="position: absolute; right: 500px">
                                                       </eo:MenuItem>
                                                   </Items>
                                               </SubMenu>
                                           </eo:MenuItem>
                                       </Items>
                                       <Bindings>
                                           <eo:DataBinding />
                                       </Bindings>
                                   </TopGroup>
                                   <BorderImages BottomBorder="00020212" BottomLeftCorner="00020207" BottomRightCorner="00020208" LeftBorder="00020210" RightBorder="00020211" TopBorder="00020209" TopLeftCorner="00020201" TopLeftCornerBottom="00020203" TopLeftCornerRight="00020202" TopRightCorner="00020204" TopRightCornerBottom="00020206" TopRightCornerLeft="00020205" />
     </eo:SlideMenu>
                
    
                               </asp:Content>
