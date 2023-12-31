USE [master]
GO
/****** Object:  Database [GunzDB]    Script Date: 25.11.2023 2.19.30 ******/
CREATE DATABASE [GunzDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GunzDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER02\MSSQL\DATA\GunzDB.mdf' , SIZE = 39552KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GunzDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER02\MSSQL\DATA\GunzDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [GunzDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GunzDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GunzDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GunzDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GunzDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GunzDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GunzDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [GunzDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GunzDB] SET AUTO_SHRINK ON 
GO
ALTER DATABASE [GunzDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GunzDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GunzDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GunzDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GunzDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GunzDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GunzDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GunzDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GunzDB] SET AUTO_UPDATE_STATISTICS_ASYNC ON 
GO
ALTER DATABASE [GunzDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GunzDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GunzDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GunzDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GunzDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GunzDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GunzDB] SET RECOVERY FULL 
GO
ALTER DATABASE [GunzDB] SET  MULTI_USER 
GO
ALTER DATABASE [GunzDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GunzDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GunzDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GunzDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GunzDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GunzDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'GunzDB', N'ON'
GO
ALTER DATABASE [GunzDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [GunzDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [GunzDB]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetMax]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ÃÖ´ë°ª ±¸ÇÏ´Â ÇÔ¼ö */
CREATE FUNCTION [dbo].[fnGetMax]
	(@n1 int, 
	 @n2 int)
RETURNS int
AS
BEGIN
RETURN (CASE WHEN @n1 > @n2 THEN @n1 ELSE @n2 END)
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetMin]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ÃÖ¼Ò°ª ±¸ÇÏ´Â ÇÔ¼ö */
CREATE  FUNCTION [dbo].[fnGetMin]
	(@n1 int, 
	 @n2 int)
RETURNS int
AS
BEGIN
RETURN (CASE WHEN @n1 < @n2 THEN @n1 ELSE @n2 END)
END
GO
/****** Object:  UserDefinedFunction [dbo].[inet_aton]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  FUNCTION [dbo].[inet_aton] (@IP VARCHAR(15))
RETURNS BIGINT
AS
BEGIN
	DECLARE @A BIGINT, @B BIGINT, @C BIGINT, @D BIGINT
	DECLARE @iBegin INT, @iEnd INT
	
	SELECT @iBegin=1
	SELECT @iEnd=CHARINDEX('.', @IP)
	SELECT @A=CAST(SUBSTRING(@IP, @iBegin, @iEnd-@iBegin) AS BIGINT)
	
	SELECT @iBegin=@iEnd+1
	SELECT @iEnd=CHARINDEX('.', @IP, @iBegin)
	SELECT @B=CAST(SUBSTRING(@IP, @iBegin, @iEnd-@iBegin) AS BIGINT)
	
	SELECT @iBegin=@iEnd+1
	SELECT @iEnd=CHARINDEX('.', @IP, @iBegin)
	SELECT @C=CAST(SUBSTRING(@IP, @iBegin, @iEnd-@iBegin) AS BIGINT)
	
	SELECT @iBegin=@iEnd+1
	SELECT @iEnd=CHARINDEX('.', @IP, @iBegin)
	SELECT @D=CAST(SUBSTRING(@IP, @iBegin, 15) AS BIGINT)
	
	DECLARE @IPNumber BIGINT
	SELECT @IPNumber=@A*16777216+@B*65536+@C*256+@D
	
	RETURN @IPNumber
END
GO
/****** Object:  UserDefinedFunction [dbo].[inet_ntoa]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  FUNCTION [dbo].[inet_ntoa] (@IP bigint)
 RETURNS varchar(15)
AS
BEGIN
 DECLARE @NumIP bigint
 DECLARE @a int
 DECLARE @b int
 DECLARE @c int
 DECLARE @d int

 SET @NumIP = @IP

 SET @a = @NumIP / 16777216
 SET @NumIP = @NumIP % 16777216

 SET @b = @NumIP / 65536
 SET @NumIP = @NumIP % 65536

 SET @c = @NumIP / 256
 SET @NumIP = @NumIP % 256

 SET @d = @NumIP

 RETURN CAST(@a AS varchar(3)) + '.' + CAST(@b AS varchar(3)) + '.' +
  CAST(@c AS varchar(3)) + '.' + CAST(@d AS varchar(3))
END
GO
/****** Object:  Table [dbo].[AbuseList]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbuseList](
	[Word] [varchar](32) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Word] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[AID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](20) NOT NULL,
	[UGradeID] [int] NOT NULL,
	[PGradeID] [int] NOT NULL,
	[RegDate] [datetime] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Email] [varchar](50) NULL,
	[RegNum] [varchar](50) NULL,
	[Age] [smallint] NULL,
	[Sex] [tinyint] NULL,
	[ZipCode] [varchar](50) NULL,
	[Address] [varchar](256) NULL,
	[Country] [varchar](50) NULL,
	[LastCID] [int] NULL,
	[Cert] [tinyint] NULL,
	[Question] [smallint] NULL,
	[Answer] [varchar](30) NULL,
	[Status] [char](1) NULL,
	[EndblockDate] [smalldatetime] NULL,
	[LastLoginTime] [smalldatetime] NULL,
	[LastLogoutTime] [smalldatetime] NULL,
	[ServerID] [int] NULL,
	[BlockType] [tinyint] NULL,
	[HackingType] [tinyint] NULL,
	[HackingRegTime] [smalldatetime] NULL,
	[EndHackingBlockTime] [smalldatetime] NULL,
	[IsPowerLevelingHacker] [tinyint] NULL,
	[PowerLevelingRegDate] [datetime] NULL,
 CONSTRAINT [Account_PK] PRIMARY KEY CLUSTERED 
(
	[AID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountItem]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountItem](
	[AIID] [int] IDENTITY(1,1) NOT NULL,
	[AID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[RentDate] [datetime] NULL,
	[RentHourPeriod] [smallint] NULL,
	[Cnt] [smallint] NULL,
 CONSTRAINT [Å×ÀÌºí1_PK] PRIMARY KEY CLUSTERED 
(
	[AIID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountPenaltyCode]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountPenaltyCode](
	[PCode] [tinyint] NOT NULL,
	[Name] [varchar](24) NOT NULL,
 CONSTRAINT [AccountPenaltyCode_PK] PRIMARY KEY CLUSTERED 
(
	[PCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountPenaltyGMLog]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountPenaltyGMLog](
	[AID] [int] NOT NULL,
	[PEndDate] [datetime] NOT NULL,
	[PCode] [int] NOT NULL,
	[PLogID] [int] IDENTITY(1,1) NOT NULL,
	[Set_GM_TypeID] [tinyint] NOT NULL,
	[Set_GM_ID] [varchar](24) NOT NULL,
	[Set_Date] [datetime] NOT NULL,
	[Reset_GM_TypeID] [tinyint] NULL,
	[Reset_GM_ID] [varchar](24) NULL,
	[Reset_Date] [datetime] NULL,
 CONSTRAINT [AccountPenaltyGMLog_PK] PRIMARY KEY CLUSTERED 
(
	[AID] ASC,
	[PEndDate] ASC,
	[PCode] ASC,
	[PLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountPenaltyGMType]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountPenaltyGMType](
	[GM_TypeID] [tinyint] NOT NULL,
	[GM_TypeName] [varchar](10) NOT NULL,
 CONSTRAINT [AccountPenaltyGMType_PK] PRIMARY KEY CLUSTERED 
(
	[GM_TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountPenaltyLog]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountPenaltyLog](
	[PenaltyLogID] [int] IDENTITY(1,1) NOT NULL,
	[AID] [int] NULL,
	[UGradeID] [int] NULL,
	[DayLeft] [int] NULL,
	[RegDate] [smalldatetime] NULL,
	[GMID] [varchar](20) NULL,
PRIMARY KEY NONCLUSTERED 
(
	[PenaltyLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_AccountPenaltyLog_AID]    Script Date: 25.11.2023 2.19.30 ******/
CREATE CLUSTERED INDEX [IX_AccountPenaltyLog_AID] ON [dbo].[AccountPenaltyLog]
(
	[AID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountPenaltyPeriod]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountPenaltyPeriod](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[AID] [int] NOT NULL,
	[DayLeft] [int] NOT NULL,
 CONSTRAINT [AccountPenaltyPeriod_PK] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BattleTimeRewardDescription]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BattleTimeRewardDescription](
	[BRID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](128) NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[StartHour] [tinyint] NULL,
	[EndHour] [tinyint] NULL,
	[RewardMinutePeriod] [int] NOT NULL,
	[RewardCount] [tinyint] NOT NULL,
	[RewardKillCount] [tinyint] NOT NULL,
	[ResetCode] [char](7) NOT NULL,
	[ResetDesc] [varchar](128) NULL,
	[IsOpen] [tinyint] NULL,
 CONSTRAINT [PK_BattleTimeRewardDescription] PRIMARY KEY CLUSTERED 
(
	[BRID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BattleTimeRewardItemList]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BattleTimeRewardItemList](
	[BRIID] [int] IDENTITY(1,1) NOT NULL,
	[BRID] [int] NOT NULL,
	[ItemIDMale] [int] NOT NULL,
	[ItemIDFemale] [int] NOT NULL,
	[RentHourPeriod] [int] NULL,
	[ItemCnt] [int] NULL,
	[RatePerThousand] [int] NOT NULL,
 CONSTRAINT [PK_BattleTimeRewardItemList] PRIMARY KEY CLUSTERED 
(
	[BRIID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BattleTimeRewardTerm]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BattleTimeRewardTerm](
	[BRID] [int] NOT NULL,
	[BRTID] [int] IDENTITY(1,1) NOT NULL,
	[LastResetDate] [datetime] NOT NULL,
	[ClosedDate] [datetime] NULL,
 CONSTRAINT [PK_BattleTimeRewardTerm] PRIMARY KEY CLUSTERED 
(
	[BRID] ASC,
	[BRTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillingMethod]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillingMethod](
	[BillingMethodID] [int] NOT NULL,
	[Name] [varchar](256) NOT NULL,
 CONSTRAINT [BillingMethod_PK] PRIMARY KEY CLUSTERED 
(
	[BillingMethodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlockCountryCode]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlockCountryCode](
	[CountryCode3] [char](3) NOT NULL,
	[RoutingURL] [varchar](64) NULL,
	[IsBlock] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryCode3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BringAccountItemLog]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BringAccountItemLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[AID] [int] NULL,
	[CID] [int] NULL,
	[ItemID] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [BringAccountItemLog_PK] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CashItemPresentLog]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashItemPresentLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[SenderUserID] [varchar](20) NOT NULL,
	[ReceiverAID] [int] NOT NULL,
	[CSID] [int] NULL,
	[CSSID] [int] NULL,
	[Cash] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[RentHourPeriod] [int] NULL,
	[MobileCode] [char](16) NULL,
	[sid] [varchar](20) NULL,
 CONSTRAINT [CashItemPresentLog_PK] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CashSetItem]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashSetItem](
	[CSIID] [int] IDENTITY(1,1) NOT NULL,
	[CSSID] [int] NOT NULL,
	[CSID] [int] NOT NULL,
 CONSTRAINT [CashSetItem_PK] PRIMARY KEY CLUSTERED 
(
	[CSIID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CashSetItemDetail]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashSetItemDetail](
	[CSSID] [int] NOT NULL,
	[Name] [varchar](64) NULL,
	[Lang] [varchar](2) NULL,
	[Description] [varchar](2048) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CashSetShop]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashSetShop](
	[CSSID] [int] NOT NULL,
	[Name] [varchar](64) NULL,
	[Description] [varchar](1024) NULL,
	[CashPrice] [int] NOT NULL,
	[WebImgName] [varchar](64) NULL,
	[NewItemOrder] [tinyint] NULL,
	[ResSex] [tinyint] NULL,
	[ResLevel] [int] NULL,
	[Weight] [int] NULL,
	[Opened] [tinyint] NULL,
	[RegDate] [datetime] NULL,
	[RentType] [tinyint] NULL,
 CONSTRAINT [CashSetShop_PK] PRIMARY KEY CLUSTERED 
(
	[CSSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CashShop]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashShop](
	[CSID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[NewItemOrder] [tinyint] NULL,
	[CashPrice] [int] NOT NULL,
	[WebImgName] [varchar](64) NULL,
	[Opened] [tinyint] NULL,
	[RegDate] [datetime] NULL,
	[RentType] [tinyint] NULL,
 CONSTRAINT [CashShop_PK] PRIMARY KEY CLUSTERED 
(
	[CSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CashShopNewItem]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashShopNewItem](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Category] [varchar](32) NOT NULL,
	[NewOrder] [int] NOT NULL,
	[IsSetItem] [int] NOT NULL,
	[CSID] [int] NULL,
	[CSSID] [int] NULL,
	[Slot] [varchar](32) NOT NULL,
	[Name] [varchar](256) NOT NULL,
	[ResSex] [int] NOT NULL,
	[ResLevel] [int] NOT NULL,
	[CashPrice] [int] NOT NULL,
	[WebImgName] [varchar](64) NULL,
	[RegDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CashShopNewItemCategory]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashShopNewItemCategory](
	[CategoryID] [int] NOT NULL,
	[Description] [varchar](12) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Description] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CashShopRank]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashShopRank](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Rank] [int] NOT NULL,
	[Category] [varchar](32) NOT NULL,
	[Name] [varchar](256) NOT NULL,
	[Count] [int] NOT NULL,
	[CSID] [int] NULL,
	[CSSID] [int] NULL,
	[Slot] [varchar](32) NOT NULL,
	[ResSex] [int] NOT NULL,
	[ResLevel] [int] NOT NULL,
	[CashPrice] [int] NOT NULL,
	[RegDate] [datetime] NOT NULL,
 CONSTRAINT [pk_CashShopRank_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CB_EventItem]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CB_EventItem](
	[ItemID] [int] NOT NULL,
	[Name] [varchar](256) NOT NULL,
	[IsUsed] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CB_EventItem_X]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CB_EventItem_X](
	[ItemID] [int] NOT NULL,
	[Name] [varchar](256) NOT NULL,
	[IsUsed] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cb_gift_user]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cb_gift_user](
	[aid] [int] NULL,
	[regdate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Character]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Character](
	[CID] [int] IDENTITY(1,1) NOT NULL,
	[AID] [int] NOT NULL,
	[Name] [varchar](24) NOT NULL,
	[Level] [smallint] NOT NULL,
	[Sex] [tinyint] NOT NULL,
	[CharNum] [smallint] NOT NULL,
	[Hair] [tinyint] NULL,
	[Face] [tinyint] NULL,
	[XP] [int] NOT NULL,
	[BP] [int] NOT NULL,
	[HP] [smallint] NULL,
	[AP] [smallint] NULL,
	[FR] [int] NULL,
	[CR] [int] NULL,
	[ER] [int] NULL,
	[WR] [int] NULL,
	[head_slot] [int] NULL,
	[chest_slot] [int] NULL,
	[hands_slot] [int] NULL,
	[legs_slot] [int] NULL,
	[feet_slot] [int] NULL,
	[fingerl_slot] [int] NULL,
	[fingerr_slot] [int] NULL,
	[melee_slot] [int] NULL,
	[primary_slot] [int] NULL,
	[secondary_slot] [int] NULL,
	[custom1_slot] [int] NULL,
	[custom2_slot] [int] NULL,
	[RegDate] [datetime] NULL,
	[LastTime] [datetime] NULL,
	[PlayTime] [int] NULL,
	[GameCount] [int] NULL,
	[KillCount] [int] NULL,
	[DeathCount] [int] NULL,
	[DeleteFlag] [tinyint] NULL,
	[DeleteName] [varchar](24) NULL,
	[head_itemid] [int] NULL,
	[chest_itemid] [int] NULL,
	[hands_itemid] [int] NULL,
	[legs_itemid] [int] NULL,
	[feet_itemid] [int] NULL,
	[fingerl_itemid] [int] NULL,
	[fingerr_itemid] [int] NULL,
	[melee_itemid] [int] NULL,
	[primary_itemid] [int] NULL,
	[secondary_itemid] [int] NULL,
	[custom1_itemid] [int] NULL,
	[custom2_itemid] [int] NULL,
	[QuestItemInfo] [binary](292) NULL,
	[Oldname] [varchar](24) NULL,
	[UserID] [varchar](20) NULL,
	[Password] [varchar](20) NULL,
	[UGradeID] [int] NULL,
 CONSTRAINT [Character_PK] PRIMARY KEY CLUSTERED 
(
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CharacterBattleTimeRewardInfo]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CharacterBattleTimeRewardInfo](
	[CID] [int] NOT NULL,
	[BRID] [int] NOT NULL,
	[BRTID] [int] NOT NULL,
	[BattleTime] [int] NULL,
	[RewardCount] [int] NULL,
	[KillCount] [int] NULL,
	[LastUpdatedTime] [datetime] NULL,
 CONSTRAINT [PK_CharacterBattleTimeRewardInfo] PRIMARY KEY CLUSTERED 
(
	[CID] ASC,
	[BRID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CharacterBattleTimeRewardLog]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CharacterBattleTimeRewardLog](
	[CID] [int] NOT NULL,
	[BRID] [int] NOT NULL,
	[BRTID] [int] NOT NULL,
	[RegDate] [datetime] NULL,
	[BattleTime] [int] NOT NULL,
	[KillCount] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[ItemCnt] [int] NOT NULL,
	[RentHourPeriod] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IX_CharacterBattleTimeRewardLog_RegDate]    Script Date: 25.11.2023 2.19.30 ******/
CREATE CLUSTERED INDEX [IX_CharacterBattleTimeRewardLog_RegDate] ON [dbo].[CharacterBattleTimeRewardLog]
(
	[RegDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CharacterEquipmentSlot]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CharacterEquipmentSlot](
	[CID] [int] NOT NULL,
	[SlotID] [int] NOT NULL,
	[CIID] [int] NULL,
	[ItemID] [int] NULL,
 CONSTRAINT [PK_CharacterEquipmentSlot] PRIMARY KEY CLUSTERED 
(
	[CID] ASC,
	[SlotID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CharacterEquipmentSlotCode]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CharacterEquipmentSlotCode](
	[SlotID] [int] NOT NULL,
	[SlotType] [varchar](20) NULL,
 CONSTRAINT [PK_CharacterEquipmentSlotCode] PRIMARY KEY CLUSTERED 
(
	[SlotID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CharacterItem]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CharacterItem](
	[CIID] [int] IDENTITY(1,1) NOT NULL,
	[CID] [int] NULL,
	[ItemID] [int] NOT NULL,
	[RegDate] [datetime] NULL,
	[RentDate] [datetime] NULL,
	[RentHourPeriod] [smallint] NULL,
	[Cnt] [smallint] NULL,
 CONSTRAINT [CharacterItem_PK] PRIMARY KEY CLUSTERED 
(
	[CIID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CharacterMakingLog]    Script Date: 25.11.2023 2.19.30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CharacterMakingLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[AID] [int] NULL,
	[CharName] [varchar](32) NULL,
	[Type] [varchar](20) NULL,
	[Date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IX_CharacterMakingDete]    Script Date: 25.11.2023 2.19.30 ******/
CREATE CLUSTERED INDEX [IX_CharacterMakingDete] ON [dbo].[CharacterMakingLog]
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CharacterMgrLogByGM]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CharacterMgrLogByGM](
	[CharMgrLogID] [int] IDENTITY(1,1) NOT NULL,
	[CID] [int] NULL,
	[CharName] [varchar](24) NOT NULL,
	[CharMgrTypeID] [tinyint] NULL,
	[GMID] [varchar](20) NOT NULL,
	[NewName] [varchar](24) NULL,
	[OrgValue] [int] NULL,
	[NewValue] [int] NULL,
	[RegDate] [smalldatetime] NULL,
PRIMARY KEY NONCLUSTERED 
(
	[CharMgrLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_CharacterMgrLogByGM_CID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE CLUSTERED INDEX [IX_CharacterMgrLogByGM_CID] ON [dbo].[CharacterMgrLogByGM]
(
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CharacterMgrType]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CharacterMgrType](
	[CharMgrTypeID] [tinyint] NOT NULL,
	[Description] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[CharMgrTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clan]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clan](
	[CLID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](24) NULL,
	[Exp] [int] NOT NULL,
	[Level] [tinyint] NOT NULL,
	[Point] [int] NOT NULL,
	[MasterCID] [int] NULL,
	[Wins] [int] NOT NULL,
	[MarkWebImg] [varchar](48) NULL,
	[Introduction] [varchar](1024) NULL,
	[RegDate] [datetime] NOT NULL,
	[DeleteFlag] [tinyint] NULL,
	[DeleteName] [varchar](24) NULL,
	[Homepage] [varchar](128) NULL,
	[Losses] [int] NOT NULL,
	[Draws] [int] NOT NULL,
	[Ranking] [int] NOT NULL,
	[TotalPoint] [int] NOT NULL,
	[Cafe_Url] [varchar](20) NULL,
	[Email] [varchar](70) NULL,
	[EmblemUrl] [varchar](256) NULL,
	[RankIncrease] [int] NOT NULL,
	[EmblemChecksum] [int] NOT NULL,
	[LastDayRanking] [int] NOT NULL,
	[LastMonthRanking] [int] NOT NULL,
 CONSTRAINT [Clan_PK] PRIMARY KEY CLUSTERED 
(
	[CLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClanAdsBoard]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClanAdsBoard](
	[Seq] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](20) NOT NULL,
	[Subject] [varchar](50) NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[ReadCount] [int] NOT NULL,
	[Recommend] [int] NULL,
	[Content] [varchar](2000) NOT NULL,
	[FileName] [varchar](128) NULL,
	[Link] [varchar](255) NULL,
	[HTML] [smallint] NOT NULL,
	[CommentCount] [int] NOT NULL,
	[GR_ID] [int] NOT NULL,
	[GR_Depth] [int] NOT NULL,
	[GR_Pos] [int] NOT NULL,
	[Thread] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClanGameLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClanGameLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[WinnerCLID] [int] NOT NULL,
	[LoserCLID] [int] NOT NULL,
	[WinnerClanName] [varchar](24) NULL,
	[LoserClanName] [varchar](24) NULL,
	[WinnerMembers] [varchar](110) NULL,
	[LoserMembers] [varchar](110) NULL,
	[RoundWins] [tinyint] NOT NULL,
	[RoundLosses] [tinyint] NOT NULL,
	[MapID] [tinyint] NOT NULL,
	[GameType] [tinyint] NOT NULL,
	[RegDate] [datetime] NOT NULL,
	[WinnerPoint] [int] NULL,
	[LoserPoint] [int] NULL,
 CONSTRAINT [ClanGameLog_PK] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClanGameLog_RegDate]    Script Date: 25.11.2023 2.19.31 ******/
CREATE CLUSTERED INDEX [IX_ClanGameLog_RegDate] ON [dbo].[ClanGameLog]
(
	[RegDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClanHonorRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClanHonorRanking](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CLID] [int] NULL,
	[ClanName] [varchar](24) NOT NULL,
	[Point] [int] NULL,
	[Wins] [int] NULL,
	[Losses] [int] NULL,
	[Ranking] [int] NULL,
	[Year] [smallint] NULL,
	[Month] [tinyint] NULL,
	[RankIncrease] [int] NOT NULL,
 CONSTRAINT [PK_ClanHonorRanking_ID] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClanMember]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClanMember](
	[CMID] [int] IDENTITY(1,1) NOT NULL,
	[CLID] [int] NULL,
	[CID] [int] NULL,
	[Grade] [tinyint] NOT NULL,
	[RegDate] [datetime] NOT NULL,
	[ContPoint] [int] NOT NULL,
 CONSTRAINT [ClanMember_PK] PRIMARY KEY CLUSTERED 
(
	[CMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClanMemberGrade]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClanMemberGrade](
	[GradeID] [int] NOT NULL,
	[Grade] [varchar](24) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GradeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CountryCode]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CountryCode](
	[CountryCode3] [char](3) NOT NULL,
	[CountryName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryCode3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomIP]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomIP](
	[IPFrom] [bigint] NOT NULL,
	[IPTo] [bigint] NOT NULL,
	[IsBlock] [tinyint] NOT NULL,
	[CountryCode3] [char](3) NOT NULL,
	[Comment] [varchar](128) NULL,
	[RegDate] [smalldatetime] NULL,
UNIQUE NONCLUSTERED 
(
	[IPFrom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[IPTo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DayRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DayRanking](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](24) NOT NULL,
	[Level] [smallint] NOT NULL,
	[Point] [int] NULL,
	[Rank] [int] NULL,
 CONSTRAINT [PK_DayRanking_ID] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DTCharacterRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DTCharacterRanking](
	[TimeStamp] [char](8) NOT NULL,
	[Rank] [int] IDENTITY(1,1) NOT NULL,
	[CID] [int] NOT NULL,
	[TP] [int] NOT NULL,
	[FinalWins] [int] NOT NULL,
	[Wins] [int] NOT NULL,
	[Loses] [int] NOT NULL,
	[RankingIncrease] [int] NULL,
	[PreGrade] [tinyint] NOT NULL,
 CONSTRAINT [DTCharacterRanking_PK] PRIMARY KEY CLUSTERED 
(
	[TimeStamp] ASC,
	[Rank] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DTCharacterRankingHistory]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DTCharacterRankingHistory](
	[TimeStamp] [char](8) NOT NULL,
	[Rank] [int] NOT NULL,
	[CID] [int] NOT NULL,
	[TP] [int] NOT NULL,
	[FinalWins] [int] NOT NULL,
	[Wins] [int] NOT NULL,
	[Loses] [int] NOT NULL,
	[Grade] [int] NOT NULL,
	[Name] [varchar](24) NULL,
 CONSTRAINT [DTCharacterRankingHistory_PK] PRIMARY KEY CLUSTERED 
(
	[TimeStamp] ASC,
	[Rank] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DTGameLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DTGameLog](
	[TimeStamp] [char](8) NOT NULL,
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[TournamentType] [tinyint] NOT NULL,
	[ChampCID] [int] NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[MatchFactor] [tinyint] NULL,
	[Player1CID] [int] NULL,
	[Player2CID] [int] NULL,
	[Player3CID] [int] NULL,
	[Player4CID] [int] NULL,
	[Player5CID] [int] NULL,
	[Player6CID] [int] NULL,
	[Player7CID] [int] NULL,
	[Player8CID] [int] NULL,
 CONSTRAINT [DTGameLog_PK] PRIMARY KEY CLUSTERED 
(
	[TimeStamp] ASC,
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DTGameLogDetail]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DTGameLogDetail](
	[TimeStamp] [char](8) NOT NULL,
	[LogID] [int] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[PlayTime] [int] NOT NULL,
	[MatchType] [tinyint] NOT NULL,
	[WinnerCID] [int] NOT NULL,
	[LoserCID] [int] NOT NULL,
	[GainTP] [int] NOT NULL,
	[LoseTP] [int] NOT NULL,
 CONSTRAINT [DTGameLogDetail_PK] PRIMARY KEY CLUSTERED 
(
	[TimeStamp] ASC,
	[LogID] ASC,
	[StartTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtproperties]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtproperties](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[objectid] [int] NULL,
	[property] [varchar](64) NOT NULL,
	[value] [varchar](255) NULL,
	[uvalue] [nvarchar](255) NULL,
	[lvalue] [image] NULL,
	[version] [int] NOT NULL,
 CONSTRAINT [pk_dtproperties] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[property] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DTTimeStamp]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DTTimeStamp](
	[ID] [int] NOT NULL,
	[TimeStamp] [char](8) NOT NULL,
	[Closed] [tinyint] NOT NULL,
	[TotalUser] [int] NULL,
 CONSTRAINT [DTTimeStamp_PK] PRIMARY KEY CLUSTERED 
(
	[TimeStamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Effect]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Effect](
	[ID] [int] NOT NULL,
	[Name] [varchar](32) NOT NULL,
	[Area] [int] NULL,
	[Time] [int] NULL,
	[ModHP] [int] NULL,
	[ModAP] [int] NULL,
	[ModMaxWT] [int] NULL,
	[ModSF] [int] NULL,
	[ModFR] [int] NULL,
	[ModCR] [int] NULL,
	[ModPR] [int] NULL,
	[ModLR] [int] NULL,
	[ResAP] [int] NULL,
	[ResFR] [int] NULL,
	[ResCR] [int] NULL,
	[ResPR] [int] NULL,
	[ResLR] [int] NULL,
	[Stun] [int] NULL,
	[KnockBack] [int] NULL,
	[Smoke] [int] NULL,
	[Flash] [int] NULL,
	[Tear] [int] NULL,
	[Flame] [int] NULL,
 CONSTRAINT [Effect_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event](
	[AID] [int] NOT NULL,
	[CID] [int] NOT NULL,
	[RegDate] [smalldatetime] NOT NULL,
	[Checked] [bit] NULL,
	[EventName] [varchar](24) NULL,
	[SubDescription] [varchar](128) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[event_back2school]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[event_back2school](
	[regdate] [char](10) NULL,
	[userid] [varchar](20) NULL,
	[playtime] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event_CharacterItem_Halloween]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event_CharacterItem_Halloween](
	[UserID] [nvarchar](20) NOT NULL,
	[UpdatedDate] [datetime] NOT NULL,
	[Trick] [int] NULL,
	[Treat] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event_ClanPointRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event_ClanPointRanking](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Rank] [int] NOT NULL,
	[CLID] [int] NOT NULL,
	[Name] [varchar](24) NOT NULL,
	[Count] [int] NOT NULL,
	[Point] [int] NOT NULL,
	[RegDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event_Coliseum_Character_NHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event_Coliseum_Character_NHN](
	[CID] [int] NOT NULL,
	[RegDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Event_Coliseum_Character_NHN] PRIMARY KEY CLUSTERED 
(
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event_Coliseum_DeathsRanking_NHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event_Coliseum_DeathsRanking_NHN](
	[DateTag] [char](10) NOT NULL,
	[Rank] [int] NOT NULL,
	[CID] [int] NOT NULL,
 CONSTRAINT [PK_Event_Coliseum_DeathsRanking_NHN_NHN] PRIMARY KEY CLUSTERED 
(
	[DateTag] ASC,
	[Rank] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event_Coliseum_KillsRanking_NHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event_Coliseum_KillsRanking_NHN](
	[DateTag] [char](10) NOT NULL,
	[Rank] [int] NOT NULL,
	[CID] [int] NOT NULL,
 CONSTRAINT [PK_Event_Coliseum_KillsRanking_NHN] PRIMARY KEY CLUSTERED 
(
	[DateTag] ASC,
	[Rank] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event_Coliseum_PlayData_NHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event_Coliseum_PlayData_NHN](
	[DateTag] [char](10) NOT NULL,
	[CID] [int] NOT NULL,
	[PlayTime] [int] NOT NULL,
	[Kills] [int] NOT NULL,
	[Deaths] [int] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
	[PlayTimeRank] [int] NULL,
	[KillRank] [int] NULL,
	[DeathRank] [int] NULL,
 CONSTRAINT [PK_Event_Coliseum_PlayData_NHN] PRIMARY KEY CLUSTERED 
(
	[DateTag] ASC,
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event_Coliseum_PlayTimeRanking_NHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event_Coliseum_PlayTimeRanking_NHN](
	[DateTag] [char](10) NOT NULL,
	[Rank] [int] NOT NULL,
	[CID] [int] NOT NULL,
 CONSTRAINT [PK_Event_Coliseum_PlayTimeRanking_NHN] PRIMARY KEY CLUSTERED 
(
	[DateTag] ASC,
	[Rank] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[event_easter2011]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[event_easter2011](
	[userid] [varchar](25) NOT NULL,
	[regdate] [char](8) NOT NULL,
	[playtime] [smallint] NULL,
 CONSTRAINT [PK_event_easter2011] PRIMARY KEY CLUSTERED 
(
	[userid] ASC,
	[regdate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event_MDTCharacter]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event_MDTCharacter](
	[UserID] [varchar](20) NOT NULL,
	[CID] [int] NOT NULL,
	[Name] [varchar](24) NOT NULL,
 CONSTRAINT [Event_MDTCharacter_PK] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event_MDTCharacterRankingHistory]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event_MDTCharacterRankingHistory](
	[TimeStamp] [char](8) NOT NULL,
	[Rank] [int] NOT NULL,
	[CID] [int] NOT NULL,
	[TP] [int] NOT NULL,
	[FinalWins] [int] NOT NULL,
	[Wins] [int] NOT NULL,
	[Loses] [int] NOT NULL,
	[Grade] [int] NOT NULL,
 CONSTRAINT [Event_MDTCharacterRankingHistory_PK] PRIMARY KEY CLUSTERED 
(
	[TimeStamp] ASC,
	[Rank] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Event_Word_NHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Event_Word_NHN](
	[CID] [int] NOT NULL,
	[Have A] [smallint] NULL,
	[Happy] [smallint] NULL,
	[Halloween] [smallint] NULL,
	[From] [smallint] NULL,
	[IJJI] [smallint] NULL,
	[AND] [smallint] NULL,
	[MAIET!] [smallint] NULL,
	[Pumpkin] [smallint] NULL,
	[Ghost] [smallint] NULL,
	[Trick Or] [smallint] NULL,
	[Treat!!] [smallint] NULL,
 CONSTRAINT [Event_Word_NHN_PK] PRIMARY KEY CLUSTERED 
(
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventAccount]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventAccount](
	[AID] [int] NOT NULL,
	[UserID] [varchar](20) NOT NULL,
	[XPOrder] [int] NULL,
	[LevelOrder] [int] NULL,
	[PlayTimeOrder] [int] NULL,
	[GainXP] [int] NOT NULL,
	[GainLevel] [int] NOT NULL,
	[GainPlayTime] [int] NOT NULL,
 CONSTRAINT [PK_EventAccount_AID] PRIMARY KEY CLUSTERED 
(
	[AID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventCharacter]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventCharacter](
	[AID] [int] NOT NULL,
	[CID] [int] NOT NULL,
	[DeleteFlag] [bit] NOT NULL,
	[StartXP] [int] NOT NULL,
	[StartLevel] [int] NOT NULL,
	[PlayTime] [int] NULL,
	[LastXP] [int] NOT NULL,
	[LastLevel] [int] NOT NULL,
 CONSTRAINT [PK_EventCharacter_AID_CID] PRIMARY KEY CLUSTERED 
(
	[AID] ASC,
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Friend]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Friend](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CID] [int] NOT NULL,
	[FriendCID] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[Favorite] [tinyint] NULL,
	[DeleteFlag] [tinyint] NULL,
 CONSTRAINT [Friend_PK] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GambleItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GambleItem](
	[GIID] [int] NOT NULL,
	[Name] [varchar](128) NOT NULL,
	[Description] [varchar](256) NOT NULL,
	[Price] [int] NOT NULL,
	[RegDate] [datetime] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[LifeTimeHour] [smallint] NOT NULL,
	[IsCash] [tinyint] NOT NULL,
	[Opened] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GIID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GambleRewardItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GambleRewardItem](
	[GRIID] [int] IDENTITY(1,1) NOT NULL,
	[GIID] [int] NOT NULL,
	[ItemIDMale] [int] NOT NULL,
	[ItemIDFemale] [int] NOT NULL,
	[RentHourPeriod] [int] NOT NULL,
	[RatePerThousand] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GRIID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GameLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[GameName] [varchar](64) NULL,
	[MasterCID] [int] NULL,
	[Map] [varchar](32) NULL,
	[GameType] [varchar](24) NULL,
	[Round] [int] NULL,
	[StartTime] [datetime] NOT NULL,
	[PlayerCount] [tinyint] NULL,
	[Players] [varchar](1000) NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IX_GameLog_StartTime]    Script Date: 25.11.2023 2.19.31 ******/
CREATE CLUSTERED INDEX [IX_GameLog_StartTime] ON [dbo].[GameLog]
(
	[StartTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GameType]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameType](
	[GameTypeID] [int] NOT NULL,
	[Name] [varchar](256) NULL,
 CONSTRAINT [GameType_PK] PRIMARY KEY CLUSTERED 
(
	[GameTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ipto_back]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ipto_back](
	[IPFrom] [numeric](18, 0) NOT NULL,
	[IPTo] [numeric](18, 0) NOT NULL,
	[CountryCode2] [char](2) NOT NULL,
	[CountryCode3] [char](3) NOT NULL,
	[CountryName] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IPtoCountry]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IPtoCountry](
	[IPFrom] [numeric](18, 0) NOT NULL,
	[IPTo] [numeric](18, 0) NOT NULL,
	[CountryCode2] [char](2) NOT NULL,
	[CountryCode3] [char](3) NOT NULL,
	[CountryName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_IPtoCountry_IPRange] PRIMARY KEY CLUSTERED 
(
	[IPFrom] ASC,
	[IPTo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IPtoCountry_temp]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IPtoCountry_temp](
	[IPFrom] [numeric](18, 0) NOT NULL,
	[IPTo] [numeric](18, 0) NOT NULL,
	[CountryCode2] [char](2) NOT NULL,
	[CountryCode3] [char](3) NOT NULL,
	[CountryName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_IPtoCountry_temp_IPRange] PRIMARY KEY CLUSTERED 
(
	[IPFrom] ASC,
	[IPTo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Item]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item](
	[ItemID] [int] NOT NULL,
	[Name] [varchar](256) NOT NULL,
	[TotalPoint] [int] NULL,
	[ResSex] [tinyint] NULL,
	[ResRace] [tinyint] NULL,
	[ResLevel] [int] NULL,
	[Slot] [tinyint] NULL,
	[Weight] [int] NULL,
	[BountyPrice] [int] NULL,
	[Damage] [int] NULL,
	[Delay] [int] NULL,
	[EffectID] [int] NULL,
	[Controllability] [int] NULL,
	[Magazine] [int] NULL,
	[ReloadTime] [int] NULL,
	[SlugOutput] [tinyint] NULL,
	[Gadget] [int] NULL,
	[HP] [int] NULL,
	[AP] [int] NULL,
	[MAXWT] [int] NULL,
	[SF] [int] NULL,
	[FR] [int] NULL,
	[CR] [int] NULL,
	[PR] [int] NULL,
	[LR] [int] NULL,
	[BlendColor] [int] NULL,
	[ModelName] [varchar](64) NULL,
	[Description] [varchar](1024) NULL,
	[MaxBullet] [int] NULL,
	[LimitSpeed] [tinyint] NULL,
	[IsCashItem] [tinyint] NULL,
	[IsSpendableItem] [tinyint] NULL,
 CONSTRAINT [Item_PK] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemChangeLog_AccountItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemChangeLog_AccountItem](
	[ChangeDate] [datetime] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[AID] [int] NOT NULL,
	[AIID] [int] NOT NULL,
	[CID] [int] NULL,
	[CIID] [int] NULL,
	[ItemID] [int] NOT NULL,
	[Count] [int] NOT NULL,
 CONSTRAINT [PK_ItemChangeLog_AccountItem] PRIMARY KEY CLUSTERED 
(
	[ChangeDate] ASC,
	[ChangeType] ASC,
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemChangeLog_CharacterItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemChangeLog_CharacterItem](
	[ChangeDate] [datetime] NOT NULL,
	[ChangeType] [smallint] NOT NULL,
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[CID] [int] NOT NULL,
	[CIID] [int] NOT NULL,
	[AID] [int] NULL,
	[AIID] [int] NULL,
	[ItemID] [int] NOT NULL,
	[Count] [int] NOT NULL,
 CONSTRAINT [PK_ItemChangeLog_CharacterItem] PRIMARY KEY CLUSTERED 
(
	[ChangeDate] ASC,
	[ChangeType] ASC,
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemChangeType]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemChangeType](
	[ChangeType] [smallint] NOT NULL,
	[DESC] [varchar](max) NULL,
 CONSTRAINT [PK_ItemChangeType] PRIMARY KEY CLUSTERED 
(
	[ChangeType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemDetail]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemDetail](
	[ItemID] [int] NOT NULL,
	[Name] [varchar](256) NULL,
	[Lang] [varchar](2) NULL,
	[Description] [varchar](2048) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemPurchaseLogByBounty]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemPurchaseLogByBounty](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ItemID] [int] NOT NULL,
	[CID] [int] NULL,
	[Date] [datetime] NULL,
	[Bounty] [int] NULL,
	[CharBounty] [int] NULL,
	[Type] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IX_ItemPurchaseLogByBounty_Date]    Script Date: 25.11.2023 2.19.31 ******/
CREATE CLUSTERED INDEX [IX_ItemPurchaseLogByBounty_Date] ON [dbo].[ItemPurchaseLogByBounty]
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemPurchaseLogByCash]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemPurchaseLogByCash](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[AID] [int] NULL,
	[ItemID] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Cash] [int] NULL,
	[RentHourPeriod] [int] NULL,
	[MobileCode] [char](16) NULL,
	[sid] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IX_ItemPurchaseLogByCash_Date]    Script Date: 25.11.2023 2.19.31 ******/
CREATE CLUSTERED INDEX [IX_ItemPurchaseLogByCash_Date] ON [dbo].[ItemPurchaseLogByCash]
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemSlotType]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemSlotType](
	[SlotType] [int] NOT NULL,
	[Description] [varchar](24) NULL,
	[Category] [varchar](24) NULL,
PRIMARY KEY CLUSTERED 
(
	[SlotType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KillLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KillLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[AttackerCID] [int] NULL,
	[VictimCID] [int] NULL,
	[Time] [datetime] NULL,
 CONSTRAINT [KillLog_PK] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Level]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Level](
	[Level] [smallint] NOT NULL,
	[MinXP] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Level] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LevelUpLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LevelUpLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CID] [int] NULL,
	[Level] [smallint] NULL,
	[BP] [int] NULL,
	[KillCount] [int] NULL,
	[DeathCount] [int] NULL,
	[PlayTime] [int] NULL,
	[Date] [datetime] NULL,
 CONSTRAINT [LevelUpLog_PK_20050310] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocatorCountryStatistics]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocatorCountryStatistics](
	[LocatorID] [int] NULL,
	[CountryCode3] [char](3) NULL,
	[Count] [int] NULL,
	[RegDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LocatorStatus]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocatorStatus](
	[LocatorID] [int] NOT NULL,
	[IP] [varchar](15) NOT NULL,
	[Port] [int] NOT NULL,
	[RecvCount] [int] NULL,
	[SendCount] [int] NULL,
	[BlockCount] [int] NULL,
	[DuplicatedCount] [int] NULL,
	[UpdateElapsedTime] [int] NOT NULL,
	[LastUpdatedTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LocatorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[IP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Login]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Login](
	[UserID] [varchar](20) NOT NULL,
	[AID] [int] NOT NULL,
	[Password] [varchar](20) NULL,
	[LastConnDate] [datetime] NULL,
	[LastIP] [varchar](20) NULL,
	[UGradeID] [int] NULL,
 CONSTRAINT [Login_PK] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Map]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Map](
	[MapID] [int] NOT NULL,
	[Name] [varchar](256) NOT NULL,
	[MaxPlayer] [int] NOT NULL,
 CONSTRAINT [Map_PK] PRIMARY KEY CLUSTERED 
(
	[MapID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHNClanMark]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHNClanMark](
	[CLMARKID] [int] IDENTITY(1,1) NOT NULL,
	[CLID] [int] NOT NULL,
	[EmblemUrl] [varchar](256) NOT NULL,
	[Approved] [tinyint] NULL,
	[Created] [datetime] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[LastCount] [int] NULL,
	[LastCreated] [datetime] NULL,
 CONSTRAINT [NHNClanMark_PK] PRIMARY KEY CLUSTERED 
(
	[CLMARKID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHNItemOfTheDay]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHNItemOfTheDay](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](128) NOT NULL,
	[itemids] [varchar](256) NOT NULL,
	[isset] [tinyint] NOT NULL,
	[originalprice] [int] NOT NULL,
	[originalperiod] [int] NULL,
	[reslevel] [int] NULL,
	[price] [int] NOT NULL,
	[period] [int] NULL,
	[remaining] [int] NOT NULL,
	[imgurl] [varchar](256) NOT NULL,
	[startdate] [datetime] NOT NULL,
	[regdate] [datetime] NOT NULL,
 CONSTRAINT [PK_NHNItemOfTheDay] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHNItemOfTheDayLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHNItemOfTheDayLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](20) NOT NULL,
	[ItemID] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[RentHourPeriod] [int] NULL,
	[Cash] [int] NOT NULL,
	[SenderUserID] [varchar](20) NULL,
 CONSTRAINT [NHNItemOfTheDayLog_PK] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHNLuckyBoxCoupon]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHNLuckyBoxCoupon](
	[BoxCID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](20) NOT NULL,
	[BoxCategory] [tinyint] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[BoxID] [int] NULL,
	[sid] [varchar](20) NULL,
	[Regdate] [datetime] NOT NULL,
	[Opendate] [datetime] NULL,
	[Expiredate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHNLuckyBoxInventory]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHNLuckyBoxInventory](
	[BoxIID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](20) NOT NULL,
	[BoxID] [int] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[BoxRID] [int] NULL,
	[RefundPrice] [int] NULL,
	[sid] [varchar](20) NULL,
	[Sender] [varchar](50) NULL,
	[Regdate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHNLuckyBoxItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHNLuckyBoxItem](
	[BoxID] [int] NOT NULL,
	[Name] [varchar](128) NOT NULL,
	[Description] [varchar](256) NOT NULL,
	[Category] [tinyint] NOT NULL,
	[webimgname] [varchar](256) NOT NULL,
	[Price] [int] NOT NULL,
	[RefundPrice] [int] NOT NULL,
	[ResSex] [tinyint] NOT NULL,
	[ResLevel] [smallint] NOT NULL,
	[Opened] [tinyint] NOT NULL,
	[displayorder] [int] NOT NULL,
	[Regdate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHNLuckyBoxRewardItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHNLuckyBoxRewardItem](
	[BoxRID] [int] IDENTITY(1,1) NOT NULL,
	[BoxID] [int] NOT NULL,
	[ItemIDs] [varchar](256) NOT NULL,
	[Name] [varchar](256) NOT NULL,
	[Category] [tinyint] NOT NULL,
	[RentHourPeriod] [int] NOT NULL,
	[RatePerThousand] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHNPurchaseLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHNPurchaseLog](
	[PID] [int] IDENTITY(1,1) NOT NULL,
	[PurchasedMonth] [varchar](6) NOT NULL,
	[UserID] [varchar](20) NOT NULL,
	[PurchasedId] [varchar](20) NOT NULL,
	[Price] [int] NULL,
	[sid] [varchar](20) NULL,
	[gift] [tinyint] NULL,
	[Regdate] [datetime] NOT NULL,
 CONSTRAINT [PK_NHNPurchaseLog] PRIMARY KEY CLUSTERED 
(
	[PID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHNRareItemShop]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHNRareItemShop](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Month] [varchar](8) NOT NULL,
	[name] [varchar](128) NOT NULL,
	[itemids] [varchar](256) NOT NULL,
	[isset] [tinyint] NOT NULL,
	[Type] [varchar](20) NULL,
	[ResSex] [varchar](20) NULL,
	[ResLevel] [int] NULL,
	[price] [int] NOT NULL,
	[period] [int] NOT NULL,
	[imgurl] [varchar](256) NOT NULL,
	[regdate] [datetime] NOT NULL,
 CONSTRAINT [PK_NHNRareItemShop] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NHNRareItemShopLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHNRareItemShopLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](20) NOT NULL,
	[ItemID] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[RentHourPeriod] [int] NULL,
	[Cash] [int] NOT NULL,
	[SenderUserID] [varchar](20) NULL,
 CONSTRAINT [NHNRareItemShopLog_PK] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PenaltyLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PenaltyLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[AID] [int] NOT NULL,
	[UGradeID] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PenaltyLog_PK] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CID] [int] NULL,
	[DisTime] [datetime] NULL,
	[PlayTime] [int] NULL,
	[Kills] [int] NULL,
	[Deaths] [int] NULL,
	[XP] [int] NULL,
	[TotalXP] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PremiumGrade]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PremiumGrade](
	[PGradeID] [int] NOT NULL,
	[Name] [varchar](128) NOT NULL,
 CONSTRAINT [PremiumGrade_PK] PRIMARY KEY CLUSTERED 
(
	[PGradeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseMethod]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseMethod](
	[PurchaseMethodID] [int] NOT NULL,
	[Name] [varchar](256) NULL,
 CONSTRAINT [PurchaseMethod_PK] PRIMARY KEY CLUSTERED 
(
	[PurchaseMethodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestGameLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestGameLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[GameName] [varchar](64) NULL,
	[Master] [int] NOT NULL,
	[Player1] [int] NULL,
	[Player2] [int] NULL,
	[Player3] [int] NULL,
	[TotalQItemCount] [tinyint] NULL,
	[ScenarioID] [smallint] NOT NULL,
	[StartTime] [smalldatetime] NOT NULL,
	[EndTime] [smalldatetime] NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_QuestGameLog_StartTime]    Script Date: 25.11.2023 2.19.31 ******/
CREATE CLUSTERED INDEX [IX_QuestGameLog_StartTime] ON [dbo].[QuestGameLog]
(
	[StartTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestItem](
	[QIID] [int] NOT NULL,
	[Name] [char](32) NULL,
	[Level] [tinyint] NULL,
	[Description] [varchar](200) NULL,
	[Price] [int] NULL,
	[UniqueItem] [bit] NOT NULL,
	[Sacrifice] [bit] NOT NULL,
	[Type] [char](10) NULL,
	[Param] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[QIID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QUniqueItemLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QUniqueItemLog](
	[QUILID] [int] IDENTITY(1,1) NOT NULL,
	[QGLID] [int] NULL,
	[CID] [int] NOT NULL,
	[QIID] [int] NOT NULL,
PRIMARY KEY NONCLUSTERED 
(
	[QUILID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_QUniqueItemLog_CID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE CLUSTERED INDEX [IX_QUniqueItemLog_CID] ON [dbo].[QUniqueItemLog]
(
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RentCashSetShopPrice]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentCashSetShopPrice](
	[RCSSPID] [int] IDENTITY(1,1) NOT NULL,
	[CSSID] [int] NULL,
	[RentHourPeriod] [smallint] NULL,
	[CashPrice] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RCSSPID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RentCashShopPrice]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentCashShopPrice](
	[RCSPID] [int] IDENTITY(1,1) NOT NULL,
	[CSID] [int] NULL,
	[RentHourPeriod] [smallint] NULL,
	[CashPrice] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RCSPID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RentPeriodDay]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentPeriodDay](
	[Day] [int] NOT NULL,
	[Hour] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Hour] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RentType]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentType](
	[TypeID] [int] NOT NULL,
	[Description] [varchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServerLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServerLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ServerID] [smallint] NULL,
	[PlayerCount] [smallint] NULL,
	[GameCount] [smallint] NULL,
	[Time] [smalldatetime] NULL,
	[BlockCount] [int] NULL,
	[NonBlockCount] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IX_ServerLog_Time]    Script Date: 25.11.2023 2.19.31 ******/
CREATE CLUSTERED INDEX [IX_ServerLog_Time] ON [dbo].[ServerLog]
(
	[Time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServerLogStorage]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServerLogStorage](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ServerID] [smallint] NOT NULL,
	[PlayerCount] [int] NOT NULL,
	[GameCount] [int] NOT NULL,
	[BlockCount] [int] NOT NULL,
	[NonBlockCount] [int] NOT NULL,
	[Time] [smalldatetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServerStatus]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServerStatus](
	[ServerID] [int] NOT NULL,
	[CurrPlayer] [smallint] NULL,
	[MaxPlayer] [smallint] NULL,
	[Time] [datetime] NULL,
	[IP] [varchar](32) NULL,
	[Port] [int] NULL,
	[ServerName] [varchar](64) NULL,
	[Opened] [tinyint] NULL,
	[Type] [int] NULL,
	[AgentIP] [varchar](32) NULL,
 CONSTRAINT [ServerStatus_PK] PRIMARY KEY CLUSTERED 
(
	[ServerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServerType]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServerType](
	[TypeID] [int] NOT NULL,
	[description] [varchar](64) NULL,
PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SetItemPurchaseLogByCash]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SetItemPurchaseLogByCash](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[AID] [int] NULL,
	[CSSID] [int] NULL,
	[Date] [datetime] NOT NULL,
	[Cash] [int] NULL,
	[RentHourPeriod] [int] NULL,
	[MobileCode] [char](16) NULL,
	[sid] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Index [IX_SetItemPurchaseLogByCash_Date]    Script Date: 25.11.2023 2.19.31 ******/
CREATE CLUSTERED INDEX [IX_SetItemPurchaseLogByCash_Date] ON [dbo].[SetItemPurchaseLogByCash]
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sjr_TableSizeIncr]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sjr_TableSizeIncr](
	[name] [varchar](40) NULL,
	[rows] [int] NULL,
	[reserved] [varchar](100) NULL,
	[date] [varchar](100) NULL,
	[index_size] [varchar](100) NULL,
	[unused] [varchar](100) NULL,
	[rd] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SleepAccountNHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SleepAccountNHN](
	[AID] [int] NOT NULL,
	[UserID] [varchar](24) NOT NULL,
	[RegDt] [datetime] NOT NULL,
 CONSTRAINT [SleepAccountNHN_PK] PRIMARY KEY NONCLUSTERED 
(
	[AID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_SleepAccountNHN_RegDt]    Script Date: 25.11.2023 2.19.31 ******/
CREATE CLUSTERED INDEX [IX_SleepAccountNHN_RegDt] ON [dbo].[SleepAccountNHN]
(
	[RegDt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SleepAccountRestoredLogNHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SleepAccountRestoredLogNHN](
	[AID] [int] NOT NULL,
	[UserID] [varchar](24) NOT NULL,
	[RegDt] [datetime] NOT NULL,
	[RestoredDt] [datetime] NOT NULL,
 CONSTRAINT [SleepAccountRestoredLogNHN_PK] PRIMARY KEY NONCLUSTERED 
(
	[AID] ASC,
	[RegDt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_SleepAccountRestoredLogNHN_RestoredDt]    Script Date: 25.11.2023 2.19.31 ******/
CREATE CLUSTERED INDEX [IX_SleepAccountRestoredLogNHN_RestoredDt] ON [dbo].[SleepAccountRestoredLogNHN]
(
	[RestoredDt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SleepCharacterNHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SleepCharacterNHN](
	[AID] [int] NOT NULL,
	[CID] [int] NOT NULL,
	[Name] [varchar](24) NOT NULL,
	[RegDt] [datetime] NOT NULL,
 CONSTRAINT [SleepCharacterNHN_PK] PRIMARY KEY NONCLUSTERED 
(
	[AID] ASC,
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_SleepCharacterNHN_RegDt]    Script Date: 25.11.2023 2.19.31 ******/
CREATE CLUSTERED INDEX [IX_SleepCharacterNHN_RegDt] ON [dbo].[SleepCharacterNHN]
(
	[RegDt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SleepCharacterRestoredLogNHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SleepCharacterRestoredLogNHN](
	[CID] [int] NOT NULL,
	[OrginName] [varchar](24) NOT NULL,
	[RestoreName] [varchar](24) NOT NULL,
	[RegDt] [datetime] NOT NULL,
	[RestoredDt] [datetime] NOT NULL,
 CONSTRAINT [SleepCharacterRestoredLogNHN_PK] PRIMARY KEY NONCLUSTERED 
(
	[CID] ASC,
	[RegDt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_SleepCharacterRestoredLogNHN_RestoredDt]    Script Date: 25.11.2023 2.19.31 ******/
CREATE CLUSTERED INDEX [IX_SleepCharacterRestoredLogNHN_RestoredDt] ON [dbo].[SleepCharacterRestoredLogNHN]
(
	[RestoredDt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SurvivalCharacterInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurvivalCharacterInfo](
	[SID] [tinyint] NOT NULL,
	[CID] [int] NOT NULL,
	[RP] [int] NOT NULL,
	[RP_LatestTime] [smalldatetime] NOT NULL,
	[tmpRP] [int] NULL,
	[RankRP] [int] NULL,
 CONSTRAINT [PK_SurvivalCharacterInfo] PRIMARY KEY CLUSTERED 
(
	[SID] ASC,
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SurvivalCharacterInfoWeb]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurvivalCharacterInfoWeb](
	[RowNum] [int] IDENTITY(1,1) NOT NULL,
	[SID] [tinyint] NOT NULL,
	[CID] [int] NOT NULL,
 CONSTRAINT [PK_SurvivalCharacterInfoWeb] PRIMARY KEY CLUSTERED 
(
	[SID] ASC,
	[RowNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SurvivalGameLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurvivalGameLog](
	[StartTime] [datetime] NOT NULL,
	[FinishTime] [datetime] NOT NULL,
	[Master_Player] [int] NOT NULL,
	[GainRP1] [int] NOT NULL,
	[Player2] [int] NULL,
	[GainRP2] [int] NULL,
	[Player3] [int] NULL,
	[GainRP3] [int] NULL,
	[Player4] [int] NULL,
	[GainRP4] [int] NULL,
	[GameName] [varchar](64) NOT NULL,
	[SID] [tinyint] NOT NULL,
	[TotalRound] [smallint] NOT NULL,
 CONSTRAINT [PK_SurvivalGameLog_MPlayer_StartTime] PRIMARY KEY CLUSTERED 
(
	[StartTime] ASC,
	[Master_Player] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SurvivalRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurvivalRanking](
	[SID] [int] NOT NULL,
	[RP] [int] NOT NULL,
	[Ranking] [int] NULL,
 CONSTRAINT [PK_SurvivalRanking_SID_RP_63280500] PRIMARY KEY CLUSTERED 
(
	[SID] ASC,
	[RP] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SurvivalScenarioID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurvivalScenarioID](
	[SID] [tinyint] IDENTITY(1,1) NOT NULL,
	[SName] [varchar](20) NOT NULL,
 CONSTRAINT [PK_SurvivalScenarioID] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_stampevent]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_stampevent](
	[sdate] [char](8) NOT NULL,
	[UserID] [varchar](20) NOT NULL,
	[PlayTime] [int] NOT NULL,
	[GiftDate] [smalldatetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_summerwave_newreg_event]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_summerwave_newreg_event](
	[userid] [varchar](20) NOT NULL,
	[regdate] [datetime] NOT NULL,
	[jobdate] [datetime] NULL,
 CONSTRAINT [tmp_summerwave_newreg_event_PK] PRIMARY KEY CLUSTERED 
(
	[userid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_summerwave_raffle_event]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_summerwave_raffle_event](
	[sdate] [char](8) NOT NULL,
	[userid] [varchar](20) NOT NULL,
	[playtime] [int] NOT NULL,
	[gifttype] [int] NOT NULL,
	[giftdate] [smalldatetime] NULL,
 CONSTRAINT [tmp_summerwave_raffle_event_PK] PRIMARY KEY CLUSTERED 
(
	[userid] ASC,
	[sdate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TotalRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TotalRanking](
	[Rank] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](20) NULL,
	[Name] [varchar](24) NOT NULL,
	[Level] [smallint] NOT NULL,
	[XP] [int] NULL,
	[KillCount] [int] NULL,
	[DeathCount] [int] NULL,
 CONSTRAINT [PK_TotalRanking_Rank] PRIMARY KEY CLUSTERED 
(
	[Rank] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserGrade]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserGrade](
	[UGradeID] [int] NOT NULL,
	[Name] [varchar](128) NOT NULL,
 CONSTRAINT [UserGrade_PK] PRIMARY KEY CLUSTERED 
(
	[UGradeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UV]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UV](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Time] [smalldatetime] NOT NULL,
	[Count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_Account_LastLoginTime]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Account_LastLoginTime] ON [dbo].[Account]
(
	[LastLoginTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Account_LastLogoutTime]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Account_LastLogoutTime] ON [dbo].[Account]
(
	[LastLogoutTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Account_RegDate]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Account_RegDate] ON [dbo].[Account]
(
	[RegDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Account_UserID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Account_UserID] ON [dbo].[Account]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AccountItem_AID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_AccountItem_AID] ON [dbo].[AccountItem]
(
	[AID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AccountItem_RentDate]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_AccountItem_RentDate] ON [dbo].[AccountItem]
(
	[RentDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_BattleTimeRewardItemList_BRID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_BattleTimeRewardItemList_BRID] ON [dbo].[BattleTimeRewardItemList]
(
	[BRID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_BlockCountryCode_IsBlock]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_BlockCountryCode_IsBlock] ON [dbo].[BlockCountryCode]
(
	[IsBlock] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_BringAccoutItem_AID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_BringAccoutItem_AID] ON [dbo].[BringAccountItemLog]
(
	[AID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CashItemPresentLog_Date]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CashItemPresentLog_Date] ON [dbo].[CashItemPresentLog]
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CashItemPresentLog_ReceiverAID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CashItemPresentLog_ReceiverAID] ON [dbo].[CashItemPresentLog]
(
	[ReceiverAID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_CashItemPresentLog_SenderUserID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CashItemPresentLog_SenderUserID] ON [dbo].[CashItemPresentLog]
(
	[SenderUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CashSetShop_NewItemOrder]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CashSetShop_NewItemOrder] ON [dbo].[CashSetShop]
(
	[NewItemOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CashSetShop_Opened]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CashSetShop_Opened] ON [dbo].[CashSetShop]
(
	[Opened] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CashShop_ItemID_Opened]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CashShop_ItemID_Opened] ON [dbo].[CashShop]
(
	[ItemID] ASC,
	[Opened] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CashShop_NewItemOrder]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CashShop_NewItemOrder] ON [dbo].[CashShop]
(
	[NewItemOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CashShop_Opened]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CashShop_Opened] ON [dbo].[CashShop]
(
	[Opened] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CashShopNewItem_NewOrder]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CashShopNewItem_NewOrder] ON [dbo].[CashShopNewItem]
(
	[NewOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_CashShopRank_Category]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CashShopRank_Category] ON [dbo].[CashShopRank]
(
	[Category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CashShopRank_Rank]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CashShopRank_Rank] ON [dbo].[CashShopRank]
(
	[Rank] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Character_AID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Character_AID] ON [dbo].[Character]
(
	[AID] ASC,
	[CharNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Character_AID_DeleteFlag]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Character_AID_DeleteFlag] ON [dbo].[Character]
(
	[AID] ASC,
	[DeleteFlag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Character_DeleteFlag]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Character_DeleteFlag] ON [dbo].[Character]
(
	[DeleteFlag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Character_Name]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Character_Name] ON [dbo].[Character]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CharacterBattleTimeRewardLog_BRID_CID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CharacterBattleTimeRewardLog_BRID_CID] ON [dbo].[CharacterBattleTimeRewardLog]
(
	[BRID] ASC,
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CharacterItem_CID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CharacterItem_CID] ON [dbo].[CharacterItem]
(
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_CharacterMakingName]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CharacterMakingName] ON [dbo].[CharacterMakingLog]
(
	[CharName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CharacterMgrLogByGM_CharMgrTypeID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CharacterMgrLogByGM_CharMgrTypeID] ON [dbo].[CharacterMgrLogByGM]
(
	[CharMgrTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_CharacterMgrLogByGM_CharName]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CharacterMgrLogByGM_CharName] ON [dbo].[CharacterMgrLogByGM]
(
	[CharName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CharacterMgrLogByGM_RegDate]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CharacterMgrLogByGM_RegDate] ON [dbo].[CharacterMgrLogByGM]
(
	[RegDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Clan_DeleteFlag]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Clan_DeleteFlag] ON [dbo].[Clan]
(
	[DeleteFlag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Clan_MasterCID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Clan_MasterCID] ON [dbo].[Clan]
(
	[MasterCID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Clan_Name]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Clan_Name] ON [dbo].[Clan]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Clan_Ranking]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Clan_Ranking] ON [dbo].[Clan]
(
	[Ranking] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Clan_RegDate]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Clan_RegDate] ON [dbo].[Clan]
(
	[RegDate] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClanAdsBoard_GR_Depth]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ClanAdsBoard_GR_Depth] ON [dbo].[ClanAdsBoard]
(
	[GR_Depth] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClanAdsBoard_GR_ID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ClanAdsBoard_GR_ID] ON [dbo].[ClanAdsBoard]
(
	[GR_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClanAdsBoard_GR_Pos]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ClanAdsBoard_GR_Pos] ON [dbo].[ClanAdsBoard]
(
	[GR_Pos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ClanAdsBoard_Subject]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ClanAdsBoard_Subject] ON [dbo].[ClanAdsBoard]
(
	[Subject] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClanAdsBoard_Thread]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ClanAdsBoard_Thread] ON [dbo].[ClanAdsBoard]
(
	[Thread] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ClanAdsBoard_UserID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ClanAdsBoard_UserID] ON [dbo].[ClanAdsBoard]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClanGameLog_LoserCLID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ClanGameLog_LoserCLID] ON [dbo].[ClanGameLog]
(
	[LoserCLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClanGameLog_WinnerCLID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ClanGameLog_WinnerCLID] ON [dbo].[ClanGameLog]
(
	[WinnerCLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ClanHonorRanking_ClanName]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ClanHonorRanking_ClanName] ON [dbo].[ClanHonorRanking]
(
	[ClanName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClanHonorRanking_CLID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ClanHonorRanking_CLID] ON [dbo].[ClanHonorRanking]
(
	[CLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClanHonorRanking_Ranking]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ClanHonorRanking_Ranking] ON [dbo].[ClanHonorRanking]
(
	[Ranking] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClanHonorRanking_YearMonthRanking]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ClanHonorRanking_YearMonthRanking] ON [dbo].[ClanHonorRanking]
(
	[Year] ASC,
	[Month] ASC,
	[Ranking] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClanMember_CID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ClanMember_CID] ON [dbo].[ClanMember]
(
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClanMember_CLID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ClanMember_CLID] ON [dbo].[ClanMember]
(
	[CLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_CustomIP_CountryCode3]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CustomIP_CountryCode3] ON [dbo].[CustomIP]
(
	[CountryCode3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomIP_IPFrom]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CustomIP_IPFrom] ON [dbo].[CustomIP]
(
	[IPFrom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomIP_IPTo]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_CustomIP_IPTo] ON [dbo].[CustomIP]
(
	[IPTo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_DayRanking_Rank]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_DayRanking_Rank] ON [dbo].[DayRanking]
(
	[Rank] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Event_AID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Event_AID] ON [dbo].[Event]
(
	[AID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Event_CID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Event_CID] ON [dbo].[Event]
(
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Event_RegDate]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Event_RegDate] ON [dbo].[Event]
(
	[RegDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_event_back2school]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_event_back2school] ON [dbo].[event_back2school]
(
	[regdate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Event_ClanPointRanking_CLID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Event_ClanPointRanking_CLID] ON [dbo].[Event_ClanPointRanking]
(
	[CLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Event_ClanPointRanking_Rank]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Event_ClanPointRanking_Rank] ON [dbo].[Event_ClanPointRanking]
(
	[Rank] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Event_ClanPointRanking_RegDate]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Event_ClanPointRanking_RegDate] ON [dbo].[Event_ClanPointRanking]
(
	[RegDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Event_Coliseum_PlayData_NHN_CID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Event_Coliseum_PlayData_NHN_CID] ON [dbo].[Event_Coliseum_PlayData_NHN]
(
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_event_easter2011]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_event_easter2011] ON [dbo].[event_easter2011]
(
	[regdate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Event_MDTCharacter]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Event_MDTCharacter] ON [dbo].[Event_MDTCharacter]
(
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Event_MDTCharacterRankingHistory]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Event_MDTCharacterRankingHistory] ON [dbo].[Event_MDTCharacterRankingHistory]
(
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_EventAccount_Level_Order]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_EventAccount_Level_Order] ON [dbo].[EventAccount]
(
	[LevelOrder] ASC
)
INCLUDE([UserID],[GainLevel]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_EventAccount_PlayTime_Order]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_EventAccount_PlayTime_Order] ON [dbo].[EventAccount]
(
	[PlayTimeOrder] ASC
)
INCLUDE([UserID],[GainPlayTime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_EventAccount_UserID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_EventAccount_UserID] ON [dbo].[EventAccount]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_EventAccount_XP_Order]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_EventAccount_XP_Order] ON [dbo].[EventAccount]
(
	[XPOrder] ASC
)
INCLUDE([UserID],[GainXP]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Friend_CID_DeleteFlag_FriendCID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Friend_CID_DeleteFlag_FriendCID] ON [dbo].[Friend]
(
	[CID] ASC,
	[DeleteFlag] ASC,
	[FriendCID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_GambleItem_Name]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IDX_GambleItem_Name] ON [dbo].[GambleItem]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_GambleRewardItem_GIID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IDX_GambleRewardItem_GIID] ON [dbo].[GambleRewardItem]
(
	[GIID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_GambleRewardItem_ItemIDFemale]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IDX_GambleRewardItem_ItemIDFemale] ON [dbo].[GambleRewardItem]
(
	[ItemIDFemale] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_GambleRewardItem_ItemIDMale]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IDX_GambleRewardItem_ItemIDMale] ON [dbo].[GambleRewardItem]
(
	[ItemIDMale] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_GameLog_MasterCID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_GameLog_MasterCID] ON [dbo].[GameLog]
(
	[MasterCID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Item_Name]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Item_Name] ON [dbo].[Item]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Item_ResLevel]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Item_ResLevel] ON [dbo].[Item]
(
	[ResLevel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Item_ResSex]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Item_ResSex] ON [dbo].[Item]
(
	[ResSex] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Item_Slot]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Item_Slot] ON [dbo].[Item]
(
	[Slot] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ItemChangeLog_AccountItem_AID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ItemChangeLog_AccountItem_AID] ON [dbo].[ItemChangeLog_AccountItem]
(
	[AID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ItemChangeLog_CharacterItem_CID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ItemChangeLog_CharacterItem_CID] ON [dbo].[ItemChangeLog_CharacterItem]
(
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ItemPurchaseLogByBounty_CID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ItemPurchaseLogByBounty_CID] ON [dbo].[ItemPurchaseLogByBounty]
(
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ItemPurhcaseLogByBountry_Date]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ItemPurhcaseLogByBountry_Date] ON [dbo].[ItemPurchaseLogByBounty]
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ItemPurchaseLogByCash_AID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ItemPurchaseLogByCash_AID] ON [dbo].[ItemPurchaseLogByCash]
(
	[AID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Level_MinXP]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Level_MinXP] ON [dbo].[Level]
(
	[MinXP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_LevelUpLog_CID_Date]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_LevelUpLog_CID_Date] ON [dbo].[LevelUpLog]
(
	[CID] ASC,
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_LocatorCountryStatistics_CountryCode3]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_LocatorCountryStatistics_CountryCode3] ON [dbo].[LocatorCountryStatistics]
(
	[CountryCode3] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_LocatorCountryStatistics_RegDate]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_LocatorCountryStatistics_RegDate] ON [dbo].[LocatorCountryStatistics]
(
	[RegDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_LocatorStatus_IP]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_LocatorStatus_IP] ON [dbo].[LocatorStatus]
(
	[IP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Login_AID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_Login_AID] ON [dbo].[Login]
(
	[AID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_NHNClanMark_Approved]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_NHNClanMark_Approved] ON [dbo].[NHNClanMark]
(
	[Approved] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_NHNItemOfTheDay_StartDate]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_NHNItemOfTheDay_StartDate] ON [dbo].[NHNItemOfTheDay]
(
	[startdate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_NHNItemOfTheDayLog_UserID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_NHNItemOfTheDayLog_UserID] ON [dbo].[NHNItemOfTheDayLog]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_NHNPurchaseLog_MONTH_USERID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_NHNPurchaseLog_MONTH_USERID] ON [dbo].[NHNPurchaseLog]
(
	[PurchasedMonth] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_NHNRareItemShopLog_UserID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_NHNRareItemShopLog_UserID] ON [dbo].[NHNRareItemShopLog]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PenaltyLog_AID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_PenaltyLog_AID] ON [dbo].[PenaltyLog]
(
	[AID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PenaltyLog_Date]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_PenaltyLog_Date] ON [dbo].[PenaltyLog]
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PlayerLog_DisTime]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_PlayerLog_DisTime] ON [dbo].[PlayerLog]
(
	[DisTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PlyaerLog_CID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_PlyaerLog_CID] ON [dbo].[PlayerLog]
(
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_QuestGameLog_EndTime]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_QuestGameLog_EndTime] ON [dbo].[QuestGameLog]
(
	[EndTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_QuestGameLog_master]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_QuestGameLog_master] ON [dbo].[QuestGameLog]
(
	[Master] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_QUniqueItemLog_QGLID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_QUniqueItemLog_QGLID] ON [dbo].[QUniqueItemLog]
(
	[QGLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_QUniqueItemLog_QIID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_QUniqueItemLog_QIID] ON [dbo].[QUniqueItemLog]
(
	[QIID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RentCashSetShopPrice_CSSID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_RentCashSetShopPrice_CSSID] ON [dbo].[RentCashSetShopPrice]
(
	[CSSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RentCashShopPrice_CSID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_RentCashShopPrice_CSID] ON [dbo].[RentCashShopPrice]
(
	[CSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ServerLog_ID_Time]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ServerLog_ID_Time] ON [dbo].[ServerLog]
(
	[ServerID] ASC,
	[Time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ServerLogStorage_Time]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_ServerLogStorage_Time] ON [dbo].[ServerLogStorage]
(
	[Time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_SetItemPurchaseLogByCash_AID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_SetItemPurchaseLogByCash_AID] ON [dbo].[SetItemPurchaseLogByCash]
(
	[AID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_SleepAccountNHN_UserID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_SleepAccountNHN_UserID] ON [dbo].[SleepAccountNHN]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_SleepAccountRestoredLogNHN_UserID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_SleepAccountRestoredLogNHN_UserID] ON [dbo].[SleepAccountRestoredLogNHN]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_SleepCharacterNHN_CID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_SleepCharacterNHN_CID] ON [dbo].[SleepCharacterNHN]
(
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_SurvivalCharacterInfo_RankRP]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_SurvivalCharacterInfo_RankRP] ON [dbo].[SurvivalCharacterInfo]
(
	[RankRP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmp_stampevent]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_tmp_stampevent] ON [dbo].[tmp_stampevent]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_tmp_stampevent_1]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_tmp_stampevent_1] ON [dbo].[tmp_stampevent]
(
	[sdate] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_TotalRanking_Name]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_TotalRanking_Name] ON [dbo].[TotalRanking]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_TotalRanking_UserID]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_TotalRanking_UserID] ON [dbo].[TotalRanking]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_UV_Time]    Script Date: 25.11.2023 2.19.31 ******/
CREATE NONCLUSTERED INDEX [IX_UV_Time] ON [dbo].[UV]
(
	[Time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [IsPowerLevelingHacker]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [PowerLevelingRegDate]
GO
ALTER TABLE [dbo].[AccountItem] ADD  CONSTRAINT [DF__AccountIt__RentD__116A8EFB]  DEFAULT (NULL) FOR [RentDate]
GO
ALTER TABLE [dbo].[AccountItem] ADD  CONSTRAINT [DF__AccountIt__RentH__125EB334]  DEFAULT (NULL) FOR [RentHourPeriod]
GO
ALTER TABLE [dbo].[AccountItem] ADD  CONSTRAINT [DF_AccountItem_Cnt]  DEFAULT ((1)) FOR [Cnt]
GO
ALTER TABLE [dbo].[BattleTimeRewardDescription] ADD  DEFAULT ((0)) FOR [StartHour]
GO
ALTER TABLE [dbo].[BattleTimeRewardDescription] ADD  DEFAULT ((24)) FOR [EndHour]
GO
ALTER TABLE [dbo].[BattleTimeRewardDescription] ADD  DEFAULT ((0)) FOR [IsOpen]
GO
ALTER TABLE [dbo].[BattleTimeRewardItemList] ADD  DEFAULT ((0)) FOR [RentHourPeriod]
GO
ALTER TABLE [dbo].[BattleTimeRewardItemList] ADD  DEFAULT ((1)) FOR [ItemCnt]
GO
ALTER TABLE [dbo].[BlockCountryCode] ADD  DEFAULT ((0)) FOR [IsBlock]
GO
ALTER TABLE [dbo].[CashShopNewItem] ADD  CONSTRAINT [DF__CashShopN__RegDa__2D67AF2B]  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[CashShopRank] ADD  CONSTRAINT [DF__CashShopR__RegDa__1C3D2329]  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[CB_EventItem] ADD  DEFAULT ((0)) FOR [IsUsed]
GO
ALTER TABLE [dbo].[CB_EventItem_X] ADD  DEFAULT ((0)) FOR [IsUsed]
GO
ALTER TABLE [dbo].[CharacterBattleTimeRewardInfo] ADD  DEFAULT ((0)) FOR [BattleTime]
GO
ALTER TABLE [dbo].[CharacterBattleTimeRewardInfo] ADD  DEFAULT ((0)) FOR [RewardCount]
GO
ALTER TABLE [dbo].[CharacterBattleTimeRewardInfo] ADD  DEFAULT ((0)) FOR [KillCount]
GO
ALTER TABLE [dbo].[CharacterBattleTimeRewardInfo] ADD  DEFAULT (getdate()) FOR [LastUpdatedTime]
GO
ALTER TABLE [dbo].[CharacterBattleTimeRewardLog] ADD  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[CharacterItem] ADD  CONSTRAINT [DF__Character__RentD__0E8E2250]  DEFAULT (NULL) FOR [RentDate]
GO
ALTER TABLE [dbo].[CharacterItem] ADD  CONSTRAINT [DF__Character__RentH__0F824689]  DEFAULT (NULL) FOR [RentHourPeriod]
GO
ALTER TABLE [dbo].[CharacterItem] ADD  CONSTRAINT [DF_CharacterItem_Cnt]  DEFAULT ((1)) FOR [Cnt]
GO
ALTER TABLE [dbo].[Clan] ADD  CONSTRAINT [DF__Clan__Exp__740F363E]  DEFAULT ((0)) FOR [Exp]
GO
ALTER TABLE [dbo].[Clan] ADD  CONSTRAINT [DF__Clan__Level__75035A77]  DEFAULT ((1)) FOR [Level]
GO
ALTER TABLE [dbo].[Clan] ADD  DEFAULT ((1000)) FOR [Point]
GO
ALTER TABLE [dbo].[Clan] ADD  CONSTRAINT [DF__Clan__Wins__76EBA2E9]  DEFAULT ((0)) FOR [Wins]
GO
ALTER TABLE [dbo].[Clan] ADD  CONSTRAINT [DF__Clan__DeleteFlag__78D3EB5B]  DEFAULT ((0)) FOR [DeleteFlag]
GO
ALTER TABLE [dbo].[Clan] ADD  CONSTRAINT [DF__Clan__Losses__6774552F]  DEFAULT ((0)) FOR [Losses]
GO
ALTER TABLE [dbo].[Clan] ADD  CONSTRAINT [DF__Clan__Draws__68687968]  DEFAULT ((0)) FOR [Draws]
GO
ALTER TABLE [dbo].[Clan] ADD  CONSTRAINT [DF__Clan__Ranking__695C9DA1]  DEFAULT ((0)) FOR [Ranking]
GO
ALTER TABLE [dbo].[Clan] ADD  CONSTRAINT [DF__Clan__TotalPoint__6A50C1DA]  DEFAULT ((0)) FOR [TotalPoint]
GO
ALTER TABLE [dbo].[Clan] ADD  CONSTRAINT [DF__Clan__RankIncrea__7E57BA87]  DEFAULT ((0)) FOR [RankIncrease]
GO
ALTER TABLE [dbo].[Clan] ADD  CONSTRAINT [DF__Clan__EmblemChec__004002F9]  DEFAULT ((0)) FOR [EmblemChecksum]
GO
ALTER TABLE [dbo].[Clan] ADD  CONSTRAINT [DF__Clan__LastDayRan__031C6FA4]  DEFAULT ((0)) FOR [LastDayRanking]
GO
ALTER TABLE [dbo].[Clan] ADD  CONSTRAINT [DF__Clan__LastMonthR__041093DD]  DEFAULT ((0)) FOR [LastMonthRanking]
GO
ALTER TABLE [dbo].[ClanAdsBoard] ADD  CONSTRAINT [DF__ClanAdsBo__ReadC__7A721B0A]  DEFAULT ((0)) FOR [ReadCount]
GO
ALTER TABLE [dbo].[ClanAdsBoard] ADD  CONSTRAINT [DF__ClanAdsBo__Recom__7B663F43]  DEFAULT ((0)) FOR [Recommend]
GO
ALTER TABLE [dbo].[ClanAdsBoard] ADD  CONSTRAINT [DF__ClanAdsBoa__HTML__7C5A637C]  DEFAULT ((0)) FOR [HTML]
GO
ALTER TABLE [dbo].[ClanAdsBoard] ADD  CONSTRAINT [DF__ClanAdsBo__Comme__7D4E87B5]  DEFAULT ((0)) FOR [CommentCount]
GO
ALTER TABLE [dbo].[ClanAdsBoard] ADD  CONSTRAINT [DF__ClanAdsBo__GR_ID__7E42ABEE]  DEFAULT ((0)) FOR [GR_ID]
GO
ALTER TABLE [dbo].[ClanAdsBoard] ADD  CONSTRAINT [DF__ClanAdsBo__GR_De__7F36D027]  DEFAULT ((0)) FOR [GR_Depth]
GO
ALTER TABLE [dbo].[ClanAdsBoard] ADD  CONSTRAINT [DF__ClanAdsBo__GR_Po__002AF460]  DEFAULT ((0)) FOR [GR_Pos]
GO
ALTER TABLE [dbo].[ClanAdsBoard] ADD  CONSTRAINT [DF__ClanAdsBo__Threa__011F1899]  DEFAULT ((0)) FOR [Thread]
GO
ALTER TABLE [dbo].[ClanHonorRanking] ADD  CONSTRAINT [DF__ClanHonor__RankI__0504B816]  DEFAULT ((0)) FOR [RankIncrease]
GO
ALTER TABLE [dbo].[ClanMember] ADD  CONSTRAINT [DF__ClanMembe__ContP__6B44E613]  DEFAULT ((0)) FOR [ContPoint]
GO
ALTER TABLE [dbo].[dtproperties] ADD  CONSTRAINT [DF__dtpropert__versi__0A9D95DB]  DEFAULT ((0)) FOR [version]
GO
ALTER TABLE [dbo].[event_back2school] ADD  DEFAULT (CONVERT([char](10),dateadd(day,(-1),getdate()),(121))) FOR [regdate]
GO
ALTER TABLE [dbo].[Event_ClanPointRanking] ADD  CONSTRAINT [DF__Event_Cla__RegDa__49CEE3AF]  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[event_easter2011] ADD  CONSTRAINT [DF__event_eas__regda__7DD53016]  DEFAULT (CONVERT([char](10),dateadd(day,(-1),getdate()),(112))) FOR [regdate]
GO
ALTER TABLE [dbo].[EventAccount] ADD  DEFAULT ((0)) FOR [XPOrder]
GO
ALTER TABLE [dbo].[EventAccount] ADD  DEFAULT ((0)) FOR [LevelOrder]
GO
ALTER TABLE [dbo].[EventAccount] ADD  DEFAULT ((0)) FOR [PlayTimeOrder]
GO
ALTER TABLE [dbo].[EventAccount] ADD  DEFAULT ((0)) FOR [GainXP]
GO
ALTER TABLE [dbo].[EventAccount] ADD  DEFAULT ((0)) FOR [GainLevel]
GO
ALTER TABLE [dbo].[EventAccount] ADD  DEFAULT ((0)) FOR [GainPlayTime]
GO
ALTER TABLE [dbo].[GambleItem] ADD  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[GambleItem] ADD  DEFAULT ((0)) FOR [StartDate]
GO
ALTER TABLE [dbo].[GambleItem] ADD  DEFAULT ((0)) FOR [LifeTimeHour]
GO
ALTER TABLE [dbo].[GambleItem] ADD  DEFAULT ((0)) FOR [IsCash]
GO
ALTER TABLE [dbo].[GambleItem] ADD  DEFAULT ((0)) FOR [Opened]
GO
ALTER TABLE [dbo].[GambleRewardItem] ADD  DEFAULT ((0)) FOR [RentHourPeriod]
GO
ALTER TABLE [dbo].[Item] ADD  DEFAULT ((0)) FOR [IsSpendableItem]
GO
ALTER TABLE [dbo].[NHNClanMark] ADD  DEFAULT ((0)) FOR [Approved]
GO
ALTER TABLE [dbo].[NHNClanMark] ADD  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[NHNClanMark] ADD  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[NHNClanMark] ADD  DEFAULT ((0)) FOR [LastCount]
GO
ALTER TABLE [dbo].[NHNClanMark] ADD  DEFAULT (getdate()) FOR [LastCreated]
GO
ALTER TABLE [dbo].[sjr_TableSizeIncr] ADD  CONSTRAINT [DF__sjr_TableSiz__rd__1229A90A]  DEFAULT (getdate()) FOR [rd]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [PremiumGrade_Account_FK1] FOREIGN KEY([PGradeID])
REFERENCES [dbo].[PremiumGrade] ([PGradeID])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [PremiumGrade_Account_FK1]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [UserGrade_Account_FK1] FOREIGN KEY([UGradeID])
REFERENCES [dbo].[UserGrade] ([UGradeID])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [UserGrade_Account_FK1]
GO
ALTER TABLE [dbo].[AccountItem]  WITH CHECK ADD  CONSTRAINT [Account_Table1_FK1] FOREIGN KEY([AID])
REFERENCES [dbo].[Account] ([AID])
GO
ALTER TABLE [dbo].[AccountItem] CHECK CONSTRAINT [Account_Table1_FK1]
GO
ALTER TABLE [dbo].[AccountItem]  WITH CHECK ADD  CONSTRAINT [Item_Table1_FK1] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Item] ([ItemID])
GO
ALTER TABLE [dbo].[AccountItem] CHECK CONSTRAINT [Item_Table1_FK1]
GO
ALTER TABLE [dbo].[AccountPenaltyGMLog]  WITH CHECK ADD  CONSTRAINT [AccountPenaltyGMLog_Account_FK] FOREIGN KEY([AID])
REFERENCES [dbo].[Account] ([AID])
GO
ALTER TABLE [dbo].[AccountPenaltyGMLog] CHECK CONSTRAINT [AccountPenaltyGMLog_Account_FK]
GO
ALTER TABLE [dbo].[AccountPenaltyGMLog]  WITH CHECK ADD  CONSTRAINT [AccountPenaltyGMLog_AccountPenaltyGMType_FK] FOREIGN KEY([Set_GM_TypeID])
REFERENCES [dbo].[AccountPenaltyGMType] ([GM_TypeID])
GO
ALTER TABLE [dbo].[AccountPenaltyGMLog] CHECK CONSTRAINT [AccountPenaltyGMLog_AccountPenaltyGMType_FK]
GO
ALTER TABLE [dbo].[AccountPenaltyGMLog]  WITH CHECK ADD  CONSTRAINT [AccountPenaltyGMLog_AccountPenaltyGMType_FK2] FOREIGN KEY([Reset_GM_TypeID])
REFERENCES [dbo].[AccountPenaltyGMType] ([GM_TypeID])
GO
ALTER TABLE [dbo].[AccountPenaltyGMLog] CHECK CONSTRAINT [AccountPenaltyGMLog_AccountPenaltyGMType_FK2]
GO
ALTER TABLE [dbo].[AccountPenaltyLog]  WITH CHECK ADD  CONSTRAINT [AccountPenaltyLog_Account_FK] FOREIGN KEY([AID])
REFERENCES [dbo].[Account] ([AID])
GO
ALTER TABLE [dbo].[AccountPenaltyLog] CHECK CONSTRAINT [AccountPenaltyLog_Account_FK]
GO
ALTER TABLE [dbo].[AccountPenaltyPeriod]  WITH CHECK ADD  CONSTRAINT [AccountPenaltyPeriod_Account_FK1] FOREIGN KEY([AID])
REFERENCES [dbo].[Account] ([AID])
GO
ALTER TABLE [dbo].[AccountPenaltyPeriod] CHECK CONSTRAINT [AccountPenaltyPeriod_Account_FK1]
GO
ALTER TABLE [dbo].[BattleTimeRewardItemList]  WITH CHECK ADD  CONSTRAINT [FK_BattleTimeRewardItemList_BRID] FOREIGN KEY([BRID])
REFERENCES [dbo].[BattleTimeRewardDescription] ([BRID])
GO
ALTER TABLE [dbo].[BattleTimeRewardItemList] CHECK CONSTRAINT [FK_BattleTimeRewardItemList_BRID]
GO
ALTER TABLE [dbo].[BattleTimeRewardItemList]  WITH CHECK ADD  CONSTRAINT [FK_BattleTimeRewardItemList_ItemIDFemale] FOREIGN KEY([ItemIDFemale])
REFERENCES [dbo].[Item] ([ItemID])
GO
ALTER TABLE [dbo].[BattleTimeRewardItemList] CHECK CONSTRAINT [FK_BattleTimeRewardItemList_ItemIDFemale]
GO
ALTER TABLE [dbo].[BattleTimeRewardItemList]  WITH CHECK ADD  CONSTRAINT [FK_BattleTimeRewardItemList_ItemIDMale] FOREIGN KEY([ItemIDMale])
REFERENCES [dbo].[Item] ([ItemID])
GO
ALTER TABLE [dbo].[BattleTimeRewardItemList] CHECK CONSTRAINT [FK_BattleTimeRewardItemList_ItemIDMale]
GO
ALTER TABLE [dbo].[BattleTimeRewardTerm]  WITH CHECK ADD  CONSTRAINT [FK_BattleTimeRewardTerm_BRID] FOREIGN KEY([BRID])
REFERENCES [dbo].[BattleTimeRewardDescription] ([BRID])
GO
ALTER TABLE [dbo].[BattleTimeRewardTerm] CHECK CONSTRAINT [FK_BattleTimeRewardTerm_BRID]
GO
ALTER TABLE [dbo].[BringAccountItemLog]  WITH CHECK ADD  CONSTRAINT [Account_BringAccountItemLog_FK1] FOREIGN KEY([AID])
REFERENCES [dbo].[Account] ([AID])
GO
ALTER TABLE [dbo].[BringAccountItemLog] CHECK CONSTRAINT [Account_BringAccountItemLog_FK1]
GO
ALTER TABLE [dbo].[BringAccountItemLog]  WITH CHECK ADD  CONSTRAINT [Character_BringAccountItemLog_FK1] FOREIGN KEY([CID])
REFERENCES [dbo].[Character] ([CID])
GO
ALTER TABLE [dbo].[BringAccountItemLog] CHECK CONSTRAINT [Character_BringAccountItemLog_FK1]
GO
ALTER TABLE [dbo].[BringAccountItemLog]  WITH CHECK ADD  CONSTRAINT [Item_BringAccountItemLog_FK1] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Item] ([ItemID])
GO
ALTER TABLE [dbo].[BringAccountItemLog] CHECK CONSTRAINT [Item_BringAccountItemLog_FK1]
GO
ALTER TABLE [dbo].[CashItemPresentLog]  WITH CHECK ADD  CONSTRAINT [Account_CashItemPresentLog_FK1] FOREIGN KEY([ReceiverAID])
REFERENCES [dbo].[Account] ([AID])
GO
ALTER TABLE [dbo].[CashItemPresentLog] CHECK CONSTRAINT [Account_CashItemPresentLog_FK1]
GO
ALTER TABLE [dbo].[CashSetItem]  WITH CHECK ADD  CONSTRAINT [CashSetShop_CashSetItem_FK1] FOREIGN KEY([CSSID])
REFERENCES [dbo].[CashSetShop] ([CSSID])
GO
ALTER TABLE [dbo].[CashSetItem] CHECK CONSTRAINT [CashSetShop_CashSetItem_FK1]
GO
ALTER TABLE [dbo].[CashSetItem]  WITH CHECK ADD  CONSTRAINT [Item_CashSetItem_FK1] FOREIGN KEY([CSID])
REFERENCES [dbo].[CashShop] ([CSID])
GO
ALTER TABLE [dbo].[CashSetItem] CHECK CONSTRAINT [Item_CashSetItem_FK1]
GO
ALTER TABLE [dbo].[CashShop]  WITH CHECK ADD  CONSTRAINT [Item_CashShop_FK1] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Item] ([ItemID])
GO
ALTER TABLE [dbo].[CashShop] CHECK CONSTRAINT [Item_CashShop_FK1]
GO
ALTER TABLE [dbo].[Character]  WITH CHECK ADD  CONSTRAINT [Account_Character_FK1] FOREIGN KEY([AID])
REFERENCES [dbo].[Account] ([AID])
GO
ALTER TABLE [dbo].[Character] CHECK CONSTRAINT [Account_Character_FK1]
GO
ALTER TABLE [dbo].[CharacterBattleTimeRewardInfo]  WITH CHECK ADD  CONSTRAINT [FK_CharacterBattleTimeRewardInfo_BRID] FOREIGN KEY([BRID])
REFERENCES [dbo].[BattleTimeRewardDescription] ([BRID])
GO
ALTER TABLE [dbo].[CharacterBattleTimeRewardInfo] CHECK CONSTRAINT [FK_CharacterBattleTimeRewardInfo_BRID]
GO
ALTER TABLE [dbo].[CharacterEquipmentSlot]  WITH CHECK ADD  CONSTRAINT [FK_CharacterEquipmentSlotCode_CharacterEquipmentSlot] FOREIGN KEY([SlotID])
REFERENCES [dbo].[CharacterEquipmentSlotCode] ([SlotID])
GO
ALTER TABLE [dbo].[CharacterEquipmentSlot] CHECK CONSTRAINT [FK_CharacterEquipmentSlotCode_CharacterEquipmentSlot]
GO
ALTER TABLE [dbo].[CharacterItem]  WITH CHECK ADD  CONSTRAINT [Character_CharacterItem_FK1] FOREIGN KEY([CID])
REFERENCES [dbo].[Character] ([CID])
GO
ALTER TABLE [dbo].[CharacterItem] CHECK CONSTRAINT [Character_CharacterItem_FK1]
GO
ALTER TABLE [dbo].[CharacterItem]  WITH CHECK ADD  CONSTRAINT [Item_CharacterItem_FK1] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Item] ([ItemID])
GO
ALTER TABLE [dbo].[CharacterItem] CHECK CONSTRAINT [Item_CharacterItem_FK1]
GO
ALTER TABLE [dbo].[CharacterMgrLogByGM]  WITH CHECK ADD FOREIGN KEY([CharMgrTypeID])
REFERENCES [dbo].[CharacterMgrType] ([CharMgrTypeID])
GO
ALTER TABLE [dbo].[CharacterMgrLogByGM]  WITH CHECK ADD FOREIGN KEY([CharMgrTypeID])
REFERENCES [dbo].[CharacterMgrType] ([CharMgrTypeID])
GO
ALTER TABLE [dbo].[CharacterMgrLogByGM]  WITH CHECK ADD FOREIGN KEY([CID])
REFERENCES [dbo].[Character] ([CID])
GO
ALTER TABLE [dbo].[CharacterMgrLogByGM]  WITH CHECK ADD FOREIGN KEY([CID])
REFERENCES [dbo].[Character] ([CID])
GO
ALTER TABLE [dbo].[Clan]  WITH CHECK ADD  CONSTRAINT [Clan_Character_FK1] FOREIGN KEY([MasterCID])
REFERENCES [dbo].[Character] ([CID])
GO
ALTER TABLE [dbo].[Clan] CHECK CONSTRAINT [Clan_Character_FK1]
GO
ALTER TABLE [dbo].[ClanGameLog]  WITH CHECK ADD  CONSTRAINT [ClanGameLog_LoserCLID_FK1] FOREIGN KEY([LoserCLID])
REFERENCES [dbo].[Clan] ([CLID])
GO
ALTER TABLE [dbo].[ClanGameLog] CHECK CONSTRAINT [ClanGameLog_LoserCLID_FK1]
GO
ALTER TABLE [dbo].[ClanGameLog]  WITH CHECK ADD  CONSTRAINT [ClanGameLog_WinnerCLID_FK1] FOREIGN KEY([WinnerCLID])
REFERENCES [dbo].[Clan] ([CLID])
GO
ALTER TABLE [dbo].[ClanGameLog] CHECK CONSTRAINT [ClanGameLog_WinnerCLID_FK1]
GO
ALTER TABLE [dbo].[ClanHonorRanking]  WITH CHECK ADD  CONSTRAINT [ClanHonorRanking_CLID_FK1] FOREIGN KEY([CLID])
REFERENCES [dbo].[Clan] ([CLID])
GO
ALTER TABLE [dbo].[ClanHonorRanking] CHECK CONSTRAINT [ClanHonorRanking_CLID_FK1]
GO
ALTER TABLE [dbo].[ClanMember]  WITH CHECK ADD  CONSTRAINT [ClanMember_Clan_FK1] FOREIGN KEY([CLID])
REFERENCES [dbo].[Clan] ([CLID])
GO
ALTER TABLE [dbo].[ClanMember] CHECK CONSTRAINT [ClanMember_Clan_FK1]
GO
ALTER TABLE [dbo].[ClanMember]  WITH CHECK ADD  CONSTRAINT [ClanMember_Clan_FK2] FOREIGN KEY([CID])
REFERENCES [dbo].[Character] ([CID])
GO
ALTER TABLE [dbo].[ClanMember] CHECK CONSTRAINT [ClanMember_Clan_FK2]
GO
ALTER TABLE [dbo].[DTGameLog]  WITH CHECK ADD  CONSTRAINT [DTTimeStamp_DTGameLog_FK1] FOREIGN KEY([TimeStamp])
REFERENCES [dbo].[DTTimeStamp] ([TimeStamp])
GO
ALTER TABLE [dbo].[DTGameLog] CHECK CONSTRAINT [DTTimeStamp_DTGameLog_FK1]
GO
ALTER TABLE [dbo].[DTGameLogDetail]  WITH CHECK ADD  CONSTRAINT [DTGameLog_DTGameLogDetail_FK1] FOREIGN KEY([TimeStamp], [LogID])
REFERENCES [dbo].[DTGameLog] ([TimeStamp], [LogID])
GO
ALTER TABLE [dbo].[DTGameLogDetail] CHECK CONSTRAINT [DTGameLog_DTGameLogDetail_FK1]
GO
ALTER TABLE [dbo].[Event_Coliseum_Character_NHN]  WITH CHECK ADD  CONSTRAINT [FK_Event_Coliseum_Character_NHN_Character] FOREIGN KEY([CID])
REFERENCES [dbo].[Character] ([CID])
GO
ALTER TABLE [dbo].[Event_Coliseum_Character_NHN] CHECK CONSTRAINT [FK_Event_Coliseum_Character_NHN_Character]
GO
ALTER TABLE [dbo].[Event_Coliseum_PlayData_NHN]  WITH CHECK ADD  CONSTRAINT [FK_Event_Coliseum_PlayData_NHN_Event_Coliseum_Character_NHN] FOREIGN KEY([CID])
REFERENCES [dbo].[Event_Coliseum_Character_NHN] ([CID])
GO
ALTER TABLE [dbo].[Event_Coliseum_PlayData_NHN] CHECK CONSTRAINT [FK_Event_Coliseum_PlayData_NHN_Event_Coliseum_Character_NHN]
GO
ALTER TABLE [dbo].[EventAccount]  WITH CHECK ADD  CONSTRAINT [FK_EventAccount_AID] FOREIGN KEY([AID])
REFERENCES [dbo].[Account] ([AID])
GO
ALTER TABLE [dbo].[EventAccount] CHECK CONSTRAINT [FK_EventAccount_AID]
GO
ALTER TABLE [dbo].[EventCharacter]  WITH CHECK ADD  CONSTRAINT [FK_EventCharacter_AID] FOREIGN KEY([AID])
REFERENCES [dbo].[EventAccount] ([AID])
GO
ALTER TABLE [dbo].[EventCharacter] CHECK CONSTRAINT [FK_EventCharacter_AID]
GO
ALTER TABLE [dbo].[EventCharacter]  WITH CHECK ADD  CONSTRAINT [FK_EventCharacter_CID] FOREIGN KEY([CID])
REFERENCES [dbo].[Character] ([CID])
GO
ALTER TABLE [dbo].[EventCharacter] CHECK CONSTRAINT [FK_EventCharacter_CID]
GO
ALTER TABLE [dbo].[Friend]  WITH CHECK ADD  CONSTRAINT [Character_Friend_FK1] FOREIGN KEY([CID])
REFERENCES [dbo].[Character] ([CID])
GO
ALTER TABLE [dbo].[Friend] CHECK CONSTRAINT [Character_Friend_FK1]
GO
ALTER TABLE [dbo].[Friend]  WITH CHECK ADD  CONSTRAINT [Character_Friend_FK2] FOREIGN KEY([FriendCID])
REFERENCES [dbo].[Character] ([CID])
GO
ALTER TABLE [dbo].[Friend] CHECK CONSTRAINT [Character_Friend_FK2]
GO
ALTER TABLE [dbo].[GambleItem]  WITH CHECK ADD FOREIGN KEY([GIID])
REFERENCES [dbo].[Item] ([ItemID])
GO
ALTER TABLE [dbo].[GambleItem]  WITH CHECK ADD FOREIGN KEY([GIID])
REFERENCES [dbo].[Item] ([ItemID])
GO
ALTER TABLE [dbo].[GambleRewardItem]  WITH CHECK ADD FOREIGN KEY([ItemIDMale])
REFERENCES [dbo].[Item] ([ItemID])
GO
ALTER TABLE [dbo].[GambleRewardItem]  WITH CHECK ADD FOREIGN KEY([ItemIDFemale])
REFERENCES [dbo].[Item] ([ItemID])
GO
ALTER TABLE [dbo].[GambleRewardItem]  WITH CHECK ADD FOREIGN KEY([ItemIDMale])
REFERENCES [dbo].[Item] ([ItemID])
GO
ALTER TABLE [dbo].[GambleRewardItem]  WITH CHECK ADD FOREIGN KEY([ItemIDFemale])
REFERENCES [dbo].[Item] ([ItemID])
GO
ALTER TABLE [dbo].[GambleRewardItem]  WITH CHECK ADD FOREIGN KEY([GIID])
REFERENCES [dbo].[GambleItem] ([GIID])
GO
ALTER TABLE [dbo].[GambleRewardItem]  WITH CHECK ADD FOREIGN KEY([GIID])
REFERENCES [dbo].[GambleItem] ([GIID])
GO
ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [Effect_Item_FK1] FOREIGN KEY([EffectID])
REFERENCES [dbo].[Effect] ([ID])
GO
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [Effect_Item_FK1]
GO
ALTER TABLE [dbo].[ItemChangeLog_AccountItem]  WITH CHECK ADD  CONSTRAINT [FK_ItemChangeLog_AccountItem_ItemChangeType] FOREIGN KEY([ChangeType])
REFERENCES [dbo].[ItemChangeType] ([ChangeType])
GO
ALTER TABLE [dbo].[ItemChangeLog_AccountItem] CHECK CONSTRAINT [FK_ItemChangeLog_AccountItem_ItemChangeType]
GO
ALTER TABLE [dbo].[ItemChangeLog_CharacterItem]  WITH CHECK ADD  CONSTRAINT [FK_ItemChangeLog_CharacterItem_ItemChangeType] FOREIGN KEY([ChangeType])
REFERENCES [dbo].[ItemChangeType] ([ChangeType])
GO
ALTER TABLE [dbo].[ItemChangeLog_CharacterItem] CHECK CONSTRAINT [FK_ItemChangeLog_CharacterItem_ItemChangeType]
GO
ALTER TABLE [dbo].[ItemPurchaseLogByBounty]  WITH CHECK ADD  CONSTRAINT [Character_PurchaseItemByBountyHistory_FK20050314] FOREIGN KEY([CID])
REFERENCES [dbo].[Character] ([CID])
GO
ALTER TABLE [dbo].[ItemPurchaseLogByBounty] CHECK CONSTRAINT [Character_PurchaseItemByBountyHistory_FK20050314]
GO
ALTER TABLE [dbo].[ItemPurchaseLogByBounty]  WITH CHECK ADD  CONSTRAINT [Item_PurchaseItemByBountyHistory_FK20050314] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Item] ([ItemID])
GO
ALTER TABLE [dbo].[ItemPurchaseLogByBounty] CHECK CONSTRAINT [Item_PurchaseItemByBountyHistory_FK20050314]
GO
ALTER TABLE [dbo].[ItemPurchaseLogByCash]  WITH CHECK ADD  CONSTRAINT [Account_PurchaseLogByCash_FK1] FOREIGN KEY([AID])
REFERENCES [dbo].[Account] ([AID])
GO
ALTER TABLE [dbo].[ItemPurchaseLogByCash] CHECK CONSTRAINT [Account_PurchaseLogByCash_FK1]
GO
ALTER TABLE [dbo].[ItemPurchaseLogByCash]  WITH CHECK ADD  CONSTRAINT [Item_PurchaseLogByCash_FK1] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Item] ([ItemID])
GO
ALTER TABLE [dbo].[ItemPurchaseLogByCash] CHECK CONSTRAINT [Item_PurchaseLogByCash_FK1]
GO
ALTER TABLE [dbo].[RentCashSetShopPrice]  WITH CHECK ADD  CONSTRAINT [FK__RentCashS__CSSID__47DBAE45] FOREIGN KEY([CSSID])
REFERENCES [dbo].[CashSetShop] ([CSSID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[RentCashSetShopPrice] CHECK CONSTRAINT [FK__RentCashS__CSSID__47DBAE45]
GO
ALTER TABLE [dbo].[RentCashShopPrice]  WITH CHECK ADD  CONSTRAINT [FK__RentCashSh__CSID__4AB81AF0] FOREIGN KEY([CSID])
REFERENCES [dbo].[CashShop] ([CSID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[RentCashShopPrice] CHECK CONSTRAINT [FK__RentCashSh__CSID__4AB81AF0]
GO
ALTER TABLE [dbo].[SetItemPurchaseLogByCash]  WITH CHECK ADD  CONSTRAINT [Account_SetItemPurchaseLogByCash_FK1] FOREIGN KEY([AID])
REFERENCES [dbo].[Account] ([AID])
GO
ALTER TABLE [dbo].[SetItemPurchaseLogByCash] CHECK CONSTRAINT [Account_SetItemPurchaseLogByCash_FK1]
GO
ALTER TABLE [dbo].[SetItemPurchaseLogByCash]  WITH CHECK ADD  CONSTRAINT [CashSetShop_SetItemPurchaseLogByCash_FK1] FOREIGN KEY([CSSID])
REFERENCES [dbo].[CashSetShop] ([CSSID])
GO
ALTER TABLE [dbo].[SetItemPurchaseLogByCash] CHECK CONSTRAINT [CashSetShop_SetItemPurchaseLogByCash_FK1]
GO
ALTER TABLE [dbo].[SurvivalCharacterInfo]  WITH CHECK ADD  CONSTRAINT [FK_SurvivalCharacterInfo_SurvivalScenarioID] FOREIGN KEY([SID])
REFERENCES [dbo].[SurvivalScenarioID] ([SID])
GO
ALTER TABLE [dbo].[SurvivalCharacterInfo] CHECK CONSTRAINT [FK_SurvivalCharacterInfo_SurvivalScenarioID]
GO
ALTER TABLE [dbo].[SurvivalGameLog]  WITH CHECK ADD  CONSTRAINT [FK_SurvivalGameLog_SurvivalScenarioID] FOREIGN KEY([SID])
REFERENCES [dbo].[SurvivalScenarioID] ([SID])
GO
ALTER TABLE [dbo].[SurvivalGameLog] CHECK CONSTRAINT [FK_SurvivalGameLog_SurvivalScenarioID]
GO
ALTER TABLE [dbo].[GambleItem]  WITH CHECK ADD CHECK  (([GIID]>(1000000)))
GO
ALTER TABLE [dbo].[GambleItem]  WITH CHECK ADD CHECK  (([GIID]>(1000000)))
GO
ALTER TABLE [dbo].[GambleRewardItem]  WITH CHECK ADD CHECK  (([GIID]>(1000000)))
GO
ALTER TABLE [dbo].[GambleRewardItem]  WITH CHECK ADD CHECK  (([GIID]>(1000000)))
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spAdmWebAccountItemInfoByAID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------

CREATE PROC [dbo].[BackUp_spAdmWebAccountItemInfoByAID] 
 @AID int
AS
 SET NOCOUNT ON
 SELECT ai.AIID, ai.RentHourPeriod, i.Name, i.ItemID
  , CASE ISNULL(RentDate, 0 )
    WHEN 0 THEN '0'
    ELSE (RentHourPeriod-DATEDIFF (hh, RentDate, GetDate()))  
    END AS RentRemain
  , CASE ISNULL(ai.RentDate, 0)
    WHEN 0 THEN '0'
    ELSE CAST(ai.RentDate AS varchar(24))
    END as RentDate
 FROM   AccountItem ai(NOLOCK) JOIN Item i(NOLOCK) 
 ON ai.AID = @AID AND i.ItemID = ai.ItemID
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spAdmWebDeleteAccountItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------

-- 중앙은행 아이템 삭제.
CREATE PROC [dbo].[BackUp_spAdmWebDeleteAccountItem]
	@AID int
,	@AIID int
,	@ItemID int
,	@GMID varchar(20)
,	@Ret int OUTPUT
AS
 SET NOCOUNT ON 

 IF NOT EXISTS (SELECT AID FROM Account(NOLOCK) 
 WHERE AID = @AID) BEGIN
  SET @Ret = 0
  RETURN @Ret	
 END

 DELETE AccountItem WHERE AIID = @AIID AND AID = @AID AND ItemID = @ItemID
 IF 0 <> @@ERROR BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spAdmWebDeleteChar]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[BackUp_spAdmWebDeleteChar]  
-- ALTER PROC dbo.spAdmWebDeleteChar  
	@AID			INT
	, @CharNum		SMALLINT
	, @CharName		VARCHAR(24)  
	, @GMID			VARCHAR(20)  
	, @Ret			INT OUTPUT   
AS BEGIN

	SET NOCOUNT ON   

	DECLARE @CID		INT
	DECLARE @ErrSlot	INT
	DECLARE @ErrDelInfo INT
	DECLARE @ErrName	INT

	SELECT	@CID = CID 
	FROM	Character(NOLOCK)   
	WHERE	AID = @AID 
	AND		Name = @CharName 
	AND		CharNum = @CharNum
	
	IF (@CID IS NULL) BEGIN
		SET @Ret = 0  
		RETURN @Ret
	END  

	BEGIN TRAN ----------------			
				
		-- Ä³½¬¾ÆÀÌÅÛÀº Áß¾ÓÀºÇàÀ¸·Î µ¹·ÁÁà¾ß ÇÔ.  
		INSERT INTO AccountItem( AID, ItemID, RentDate, RentHourPeriod, Cnt )  
			SELECT	@AID AS AID, ItemID, RentDate, RentHourPeriod, Cnt  
			FROM	CharacterItem(NOLOCK)  
			WHERE	CID = @CID 
			AND		ItemID > 499999
			
		IF (0 <> @@ERROR) BEGIN
			ROLLBACK TRAN  
			SET @Ret = 0  
			RETURN @Ret
		END  


		UPDATE	CharacterItem
		SET		CID = NULL
		WHERE	CID = @CID;
		
		IF (0 <> @@ERROR) BEGIN
			ROLLBACK TRAN
			SET @Ret = 0
			RETURN @Ret
		END  


		UPDATE	CharacterEquipmentSlot
		SET		CIID = NULL, ItemID = NULL
		WHERE	CID = @CID
		
		SET @ErrSlot = @@ROWCOUNT  
		

		UPDATE	Character 
		SET		DeleteName = Name, DeleteFlag = 1 
		WHERE	CID = @CID
		
		SET @ErrDelInfo = @@ROWCOUNT  


		UPDATE	Character 
		SET		Name = '' 
		WHERE	CID = @CID
		
		SET @ErrName = @@ROWCOUNT  

		IF (0 = @ErrSlot) OR (0 = @ErrDelInfo) OR (0 = @ErrName) BEGIN  
		ROLLBACK TRAN  
		SET @Ret = 0  
		RETURN @Ret  
		END
		
	COMMIT TRAN --------------- 

	SET @Ret = 1  
	RETURN @Ret;
END
  
-------------------------------------------------------------------------------------------------------------------------
-- º¹±¸ Äõ¸®
/*
DROP PROC spWebChangeClanName_Netmarble
EXEC sp_rename 'BackUp_spWebChangeClanName_Netmarble', 'spWebChangeClanName_Netmarble';
*/
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spAdmWebDeleteCharacterItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------

-- 캐릭터 아이템 삭제.
CREATE PROC [dbo].[BackUp_spAdmWebDeleteCharacterItem]
 @CID int
, @CIID int
, @ItemID int
, @GMID varchar(20)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON

 IF NOT EXISTS (SELECT CID FROM Character(NOLOCK) WHERE CID = @CID) BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 -- 삭제하려는 아이템을 착용하고 있다면 먼저 해제시쳐야 함.
 BEGIN TRAN
 UPDATE Character SET head_slot = NULL WHERE CID = @CID AND head_slot = @CIID
 UPDATE Character SET chest_slot = NULL WHERE CID = @CID AND chest_slot = @CIID
 UPDATE Character SET hands_slot = NULL WHERE CID = @CID AND hands_slot = @CIID
 UPDATE Character SET legs_slot = NULL WHERE CID = @CID AND legs_slot = @CIID
 UPDATE Character SET feet_slot = NULL WHERE CID = @CID AND feet_slot = @CIID
 UPDATE Character SET fingerl_slot = NULL WHERE CID = @CID AND fingerl_slot = @CIID
 UPDATE Character SET fingerr_slot = NULL WHERE CID = @CID AND fingerr_slot = @CIID
 UPDATE Character SET melee_slot = NULL WHERE CID = @CID AND melee_slot = @CIID
 UPDATE Character SET primary_slot = NULL WHERE CID = @CID AND primary_slot = @CIID
 UPDATE Character SET secondary_slot = NULL WHERE CID = @CID AND secondary_slot = @CIID
 UPDATE Character SET custom1_slot = NULL WHERE CID = @CID AND custom1_slot = @CIID
 UPDATE Character SET custom2_slot = NULL WHERE CID = @CID AND custom2_slot = @CIID

 DELETE CharacterItem WHERE CIID = @CIID AND CID = @CID AND ItemID = @ItemID
 IF 0 <> @@ERROR BEGIN
  ROLLBACK TRAN
  SET @Ret = 0
  RETURN @Ret
 END
 COMMIT TRAN	

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spAdmWebInsertAccountItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------

-- 중앙은행 아이템지급  프로시져
CREATE PROC [dbo].[BackUp_spAdmWebInsertAccountItem]
 @AID int
, @ItemID int
, @Period int 
, @GMID varchar(20)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON
 IF (500001 > @ItemID) OR ((@Period IS NOT NULL) AND (0 > @Period)) BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 IF NOT EXISTS (SELECT AID FROM Account(NOLOCK) WHERE AID = @AID) BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 DECLARE @RentHourPeriod int
 DECLARE @RentDate datetime
	
 IF (0 = @Period) OR (@Period IS NULL)
  SELECT @RentHourPeriod = NULL, @RentDate = NULL
 ELSE
  SELECT @RentHourPeriod = @Period, @RentDate = GETDATE()

 INSERT INTO AccountItem( AID, ItemID, RentDate, RentHourPeriod)
 VALUES (@AID, @ItemID, @RentDate, @RentHourPeriod )
 IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spAdmWebInsertCharacterItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------

-- 캐릭터 장비창 아이템지급  프로시져, CashItem은 지급할수 없음.
CREATE PROC [dbo].[BackUp_spAdmWebInsertCharacterItem]
	@CID int
,	@ItemID int
,	@Period smallint 
,	@GMID varchar(20)
,	@Ret int OUTPUT
AS
	SET NOCOUNT ON 
	IF (500000 < @ItemID) OR ((@Period IS NOT NULL) AND (0 > @Period)) BEGIN
		SET @Ret = 0
		RETURN @Ret
	END

	IF NOT EXISTS( SELECT CID FROM Character(NOLOCK) WHERE CID = @CID) BEGIN
		SET @Ret = 0
		RETURN @Ret
	END

	DECLARE @RentHourPeriod smallint
	DECLARE @RentDate datetime
	
	IF (0 = @Period) OR (@Period IS NULL)
		SELECT @RentHourPeriod = NULL, @RentDate = NULL
	ELSE
		SELECT @RentHourPeriod = @Period, @RentDate = GETDATE()

	INSERT INTO CharacterItem( CID, ItemID, RegDate, RentDate, RentHourPeriod )
	VALUES (@CID, @ItemID, GETDATE(), @RentDate, @RentHourPeriod )
	IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN
		SET @Ret = 0
		RETURN @Ret
	END

	SET @Ret = 1
	RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spAdmWebInsertSetItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------

-- 세트 아이템 지급 추가.
CREATE PROC [dbo].[BackUp_spAdmWebInsertSetItem]
	@UserID varchar( 20 )
,	@CSSID int
,	@RentHourPeriod smallint
,	@GMID varchar(20)
,	@Ret int OUTPUT
AS 
 SET NOCOUNT ON
  
 DECLARE @AID  int  
   
 SELECT @AID = AID FROM Account WHERE UserID = @UserID  
  
 -- 존제하는 유저인지 검사.  
 IF @AID IS NULL  
 BEGIN  
  SET @Ret = 0
  RETURN @Ret
 END  
 ELSE  
 BEGIN  
  DECLARE @RentDate  datetime     
  
  -- @RentHourPeriod값을 가지고 기간제인지 검사.  
  IF @RentHourPeriod = 0 OR @RentHourPeriod IS NULL  
  BEGIN  
   -- 기간제 아이템일 경우 영구 아이템 판매 여부 검사  
   DECLARE @RentType  TINYINT  
   DECLARE @RCSSPID  INT  
  
   SELECT @RentType = RentType FROM CashSetShop WHERE CSSID=@CSSID  
   IF @RentType = 1  
   BEGIN  
    SELECT @RCSSPID = RCSSPID FROM RentCashSetShopPrice WHERE CSSID=@CSSID AND RentHourPeriod is NULL  
    IF @RCSSPID IS NULL  
    BEGIN  
     SET @Ret = 0
     RETURN @Ret
    END  
   END  
  
   -- 일반 아이템일 경우  
   SET @RentDate = NULL  
  END  
  ELSE  
  BEGIN  
   SET @RentDate = GETDATE()  
  END  
      
  BEGIN TRAN  
  
  DECLARE curBuyCashSetItem  INSENSITIVE CURSOR  
  
  FOR  
   SELECT CSID FROM CashSetItem (NOLOCK) WHERE CSSID = @CSSID  
  FOR READ ONLY  
  
  OPEN curBuyCashSetItem   
  
  DECLARE @varCSID  int  
  DECLARE @ItemID   int  
  
  FETCH FROM curBuyCashSetItem INTO @varCSID  
  
  WHILE @@FETCH_STATUS = 0  
  BEGIN  
   SELECT @ItemID = cs.ItemID  
   FROM CashShop cs (NOLOCK)   
   WHERE cs.CSID = @varCSID   
  
   IF @ItemID IS NOT NULL  
   BEGIN  
    -- 아이템 생성.  
    INSERT INTO AccountItem(AID, ItemID, RentDate, RentHourPeriod)  
    VALUES (@AID, @ItemID, @RentDate, @RentHourPeriod)  
   END  
  
   FETCH curBuyCashSetItem  INTO @varCSID  
  END  
  
  CLOSE curBuyCashSetItem   
  DEALLOCATE curBuyCashSetItem   
  
  -- GM로그 기록.
  
  COMMIT TRAN  
  SET @Ret = 1
  RETURN @Ret
 END
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spBringAccountItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Ã¢°í ¾ÆÀÌÅÛ ³» Ä³¸¯ÅÍ·Î °¡Á®¿À±â ----------
CREATE PROC [dbo].[BackUp_spBringAccountItem]
	@AID		int,
	@CID		int,
	@AIID		int
AS
SET NoCount On

DECLARE @ItemID int
DECLARE @CAID int
DECLARE @OrderCIID int

DECLARE @RentDate			DATETIME
DECLARE @RentHourPeriod		SMALLINT
DECLARE @Cnt				SMALLINT

SELECT @ItemID=ItemID, @RentDate=RentDate, @RentHourPeriod=RentHourPeriod, @Cnt=Cnt
FROM AccountItem WHERE AIID = @AIID


SELECT @CAID = AID FROM Character WHERE CID=@CID

IF @ItemID IS NOT NULL AND @CAID = @AID
BEGIN
	BEGIN TRAN ----------------
	DELETE FROM AccountItem WHERE AIID = @AIID
	IF 0 <> @@ERROR BEGIN
		ROLLBACK TRAN 
		RETURN
	END

	INSERT INTO CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt)
	VALUES (@CID, @ItemID, GETDATE(), @RentDate, @RentHourPeriod, @Cnt)
	IF 0 <> @@ERROR BEGIN 
		ROLLBACK TRAN
		RETURN 
	END

	SET @OrderCIID = @@IDENTITY

	INSERT INTO BringAccountItemLog	(ItemID, AID, CID, Date)
	VALUES (@ItemID, @AID, @CID, GETDATE())
	IF 0 <> @@ERROR BEGIN
		ROLLBACK TRAN
		RETURN
	END

	COMMIT TRAN ---------------

	SELECT @OrderCIID AS ORDERCIID, @ItemID AS ItemID, (@RentHourPeriod*60) - (DateDiff(n, @RentDate, GETDATE())) AS RentPeriodRemainder
END
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spBringBackAccountItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ³» Ä³¸¯ÅÍ Ä³½¬¾ÆÀÌÅÛÀ» Ã¢°í¿¡ ³Ö±â ---------
CREATE PROC [dbo].[BackUp_spBringBackAccountItem]
	@AID		int,
	@CID		int,
	@CIID		int
AS
SET NOCOUNT ON

DECLARE @ItemID int
DECLARE @RentDate		DATETIME
DECLARE @RentHourPeriod	SMALLINT
DECLARE @Cnt			SMALLINT

DECLARE @HeadCIID 	int
DECLARE @ChestCIID	int
DECLARE @HandsCIID	int
DECLARE @LegsCIID	int
DECLARE @FeetCIID	int
DECLARE @FingerLCIID	int
DECLARE @FingerRCIID	int
DECLARE @MeleeCIID	int
DECLARE @PrimaryCIID	int
DECLARE @SecondaryCIID	int
DECLARE @Custom1CIID	int
DECLARE @Custom2CIID	int

SELECT 
@HeadCIID=head_slot, @ChestCIID=chest_slot, @HandsCIID=hands_slot, 
@LegsCIID=legs_slot, @FeetCIID=feet_slot, @FingerLCIID=fingerl_slot, @FingerRCIID=fingerr_slot, 
@MeleeCIID=melee_slot, @PrimaryCIID=primary_slot, @SecondaryCIID=secondary_slot, 
@Custom1CIID=custom1_slot, @Custom2CIID=custom2_slot
FROM Character(nolock) WHERE cid=@CID AND aid=@AID

SELECT @ItemID=ItemID, @RentDate=RentDate, @RentHourPeriod=RentHourPeriod, @Cnt=Cnt
FROM CharacterItem WHERE CIID=@CIID AND CID=@CID

IF ((@ItemID IS NOT NULL) AND (@ItemID >= 400000) AND
   (@HeadCIID IS NULL OR @HeadCIID != @CIID) AND
   (@ChestCIID IS NULL OR @ChestCIID != @CIID) AND 
   (@HandsCIID IS NULL OR @HandsCIID != @CIID) AND
   (@LegsCIID IS NULL OR @LegsCIID != @CIID) AND 
   (@FeetCIID IS NULL OR @FeetCIID != @CIID) AND
   (@FingerLCIID IS NULL OR @FingerLCIID != @CIID) AND 
   (@FingerRCIID IS NULL OR @FingerRCIID != @CIID) AND
   (@MeleeCIID IS NULL OR @MeleeCIID != @CIID) AND 
   (@PrimaryCIID IS NULL OR @PrimaryCIID != @CIID) AND
   (@SecondaryCIID IS NULL OR @SecondaryCIID != @CIID) AND 
   (@Custom1CIID IS NULL OR @Custom1CIID != @CIID) AND
   (@Custom2CIID IS NULL OR @Custom2CIID != @CIID))
BEGIN
	BEGIN TRAN -------------
	UPDATE CharacterItem SET CID=NULL WHERE CIID=@CIID AND CID=@CID
	IF 0 = @@ROWCOUNT BEGIN
		ROLLBACK TRAN
		RETURN
	END

	INSERT INTO AccountItem (AID, ItemID, RentDate, RentHourPeriod, Cnt) 
	VALUES (@AID, @ItemID, @RentDate, @RentHourPeriod, @Cnt)
	IF 0 <> @@ERROR BEGIN
		ROLLBACK TRAN
		RETURN
	END
	COMMIT TRAN -----------
END
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spBuyBountyItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROC [dbo].[BackUp_spBuyBountyItem]   
 @CID  INT  
,  @ItemID  INT  
, @Price  INT    
, @RentHourPeriod INT   
AS    
SET NOCOUNT ON    
BEGIN    
 DECLARE @OrderCIID int    
 DECLARE @Bounty INT    
    
 BEGIN TRAN    
  -- 잔액검사    
  SELECT @Bounty=BP FROM Character(NOLOCK) WHERE CID=@CID    
  IF @Bounty IS NULL OR @Bounty < @Price    
  BEGIN    
   ROLLBACK TRAN    
   RETURN 0    
  END    
    
  -- Bounty 감소    
  UPDATE Character SET BP=BP-@Price WHERE CID=@CID    
  IF 0 = @@ROWCOUNT    
  BEGIN    
   ROLLBACK TRAN    
   RETURN (-1)    
  END    
    
  -- Item 추가    
  INSERT INTO CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod)   
  Values (@CID, @ItemID, GETDATE(), GETDATE(), @RentHourPeriod)    
  IF 0 <> @@ERROR    
  BEGIN    
   ROLLBACK TRAN    
   RETURN (-1)    
  END    
    
  SELECT @OrderCIID = @@IDENTITY    
      
  -- Item 구매로그 추가    
  INSERT INTO ItemPurchaseLogByBounty (ItemID, CID, Date, Bounty, CharBounty, Type)    
  VALUES (@ItemID, @CID, GETDATE(), @Price, @Bounty, '구입')    
  IF 0 <> @@ERROR BEGIN    
   ROLLBACK TRAN    
   RETURN (-1)    
  END    
    
  SELECT @OrderCIID as ORDERCIID    
 COMMIT TRAN    
    
 RETURN 1    
END
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spChangeGambleItemToRewardItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[BackUp_spChangeGambleItemToRewardItem]
 @CID int
, @CIID int
, @GIID int
, @RewardItemID int
AS
BEGIN
 SET NOCOUNT ON

 DECLARE @RentHourPeriod smallint

 SELECT @RentHourPeriod = RentHourPeriod
 FROM GambleRewardItem gri(NOLOCK)
 WHERE GIID = @GIID AND (ItemIDMale = @RewardItemID OR ItemIDFemale = @RewardItemID)

 IF @RentHourPeriod IS NULL BEGIN
  SELECT -1 as 'Ret'
  RETURN
 END

 BEGIN TRAN
  UPDATE CharacterItem
  SET ItemID = @RewardItemID, RentHourPeriod = @RentHourPeriod
   , RentDate = GETDATE()
  WHERE CID = @CID AND CIID = @CIID AND ItemID = @GIID
  IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN
   ROLLBACK TRAN
   SELECT -2 AS 'Ret'
   RETURN
  END

  INSERT INTO LogDB..GambleLog(CID, GIID, RewardItemID, RegDate)
  VALUES (@CID, @GIID, @RewardItemID, GETDATE())
  IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN
   ROLLBACK TRAN;
   SELECT -3 AS 'Ret'
   RETURN
  END

 COMMIT TRAN

 SELECT 1 AS 'Ret'
END
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spClearAllEquipedItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Ä³¸¯ÅÍ ¸ðµç Àåºñ ÇØÁ¦  */
CREATE PROC [dbo].[BackUp_spClearAllEquipedItem]
	@CID		int
AS
SET NOCOUNT ON

UPDATE Character WITH (rowlock)
SET head_slot=NULL, chest_slot=NULL, hands_slot=NULL, legs_slot=NULL, feet_slot=NULL,
  fingerl_slot=NULL, fingerr_slot=NULL, melee_slot=NULL, primary_slot=NULL, secondary_slot=NULL, custom1_slot=NULL, custom2_slot=NULL,
  head_itemid=NULL, chest_itemid=NULL, hands_itemid=NULL, legs_itemid=NULL, feet_itemid=NULL,
  fingerl_itemid=NULL, fingerr_itemid=NULL, melee_itemid=NULL, primary_itemid=NULL, secondary_itemid=NULL, custom1_itemid=NULL, custom2_itemid=NULL

WHERE CID=@CID
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spDeleteExpiredAccountItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Áß¾ÓÀºÇàÀÇ ±â°£¸¸·á ¾ÆÀÌÅÛ »èÁ¦ */
CREATE PROC [dbo].[BackUp_spDeleteExpiredAccountItem]
	@AIID		int
AS
SET NOCOUNT ON

DELETE FROM AccountItem WHERE AIID=@AIID AND RentDate IS NOT NULL
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spGetAccountCharInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Ä³¸¯ÅÍ¼±ÅÃ½Ã Ä³¸¯ÅÍ Á¤º¸ °¡Á®¿À±â
CREATE PROC [dbo].[BackUp_spGetAccountCharInfo]
	@AID		int
,	@CharNum	smallint
AS
SET NOCOUNT ON
DECLARE @CID		int
DECLARE @CLID		int
DECLARE @ClanName	varchar(24)
DECLARE @ClanGrade	int
DECLARE @ClanContPoint	int

SELECT @CID=CID FROM Character WITH (nolock) WHERE AID=@AID and CharNum=@CharNum

SELECT @CID AS CID, c.Name AS Name, c.CharNum AS CharNum, c.Level AS Level, c.Sex AS Sex, c.Hair AS Hair, c.Face AS Face,
       c.XP AS XP, c.BP AS BP,
       (SELECT cl.Name FROM Clan cl(nolock), ClanMember cm(nolock) WHERE cm.cid=@CID AND cm.CLID=cl.CLID) AS ClanName,
	head_itemid, chest_itemid, hands_itemid, legs_itemid, feet_itemid, fingerl_itemid, 
	fingerr_itemid, melee_itemid, primary_itemid, secondary_itemid, custom1_itemid, custom2_itemid
FROM Character AS c WITH (nolock)
WHERE c.CID = @CID
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spGetCharInfoByCharNum]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[BackUp_spGetCharInfoByCharNum]    
 @AID  int    
, @CharNum smallint    
AS    
BEGIN    
set nocount on  
  
declare @CID int  
  
SELECT @CID=CID FROM Character WITH (nolock) WHERE AID=@AID and CharNum=@CharNum    
  
SELECT c.CID, c.AID, c.Name, c.Level, c.Sex, c.CharNum, c.Hair, c.Face  
 , c.XP, c.BP, c.HP, c.AP, c.FR, c.CR, c.ER, c.WR, c.GameCount, c.KillCount, c.DeathCount, c.PlayTime  
 , c.head_slot, c.chest_slot, c.hands_slot, c.legs_slot, c.feet_slot, c.fingerl_slot, c.fingerr_slot  
 , c.melee_slot, primary_slot, c.secondary_slot, c.custom1_slot, c.custom2_slot  
 , cm.CLID, cl.Name AS 'ClanName', cm.Grade AS 'ClanGrade', cm.ContPoint AS ClanContPoint   
 , ISNULL(tr.Rank, 0) as 'rank'
FROM (Character c with (nolock) left outer join TotalRanking tr with (nolock)   
 on c.name = tr.name)   
 left outer join   
 (Clan cl with (nolock) join ClanMember cm with (nolock)  
 on cl.CLID = cm.CLID)  
 on c.CID = cm.CID  
where c.CID = @CID  
END
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spInsertChar]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---- 

CREATE PROC [dbo].[BackUp_spInsertChar]
	@AID		int,
	@CharNum	smallint,
	@Name		varchar(24),
	@Sex		tinyint,
	@Hair		int,  
	@Face		int,
	@Costume	int
AS
SET NOCOUNT ON
BEGIN TRAN
IF EXISTS (SELECT CID FROM Character where (AID=@AID AND CharNum=@CharNum) OR (Name=@Name))
BEGIN	
	ROLLBACK TRAN
	return(-1)
END

DECLARE @CharIdent 	int
DECLARE @ChestCIID	int
DECLARE @LegsCIID	int
DECLARE @MeleeCIID	int
DECLARE @PrimaryCIID	int
DECLARE @SecondaryCIID  int
DECLARE @Custom1CIID	int
DECLARE @Custom2CIID	int

DECLARE @ChestItemID	int
DECLARE @LegsItemID	int
DECLARE @MeleeItemID	int
DECLARE @PrimaryItemID	int
DECLARE @SecondaryItemID  int
DECLARE @Custom1ItemID	int
DECLARE @Custom2ItemID	int

SET @SecondaryCIID = NULL
SET @SecondaryItemID = NULL

SET @Custom1CIID = NULL
SET @Custom1ItemID = NULL

SET @Custom2CIID = NULL
SET @Custom2ItemID = NULL

INSERT INTO Character (AID, Name, CharNum, Level, Sex, Hair, Face, XP, BP, FR, CR, ER, WR, 
         		           GameCount, KillCount, DeathCount, RegDate, PlayTime, DeleteFlag)
Values (@AID, @Name, @CharNum, 1, @Sex, @Hair, @Face, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 0, 0)
IF 0 <> @@ERROR BEGIN
	ROLLBACK TRAN
	RETURN (-1)
END


SET @CharIdent = @@IDENTITY

  /* Melee */
  SET @MeleeItemID = 
    CASE @Costume
    WHEN 0 THEN 1
    WHEN 1 THEN 2
    WHEN 2 THEN 1
    WHEN 3 THEN 2
    WHEN 4 THEN 2
    WHEN 5 THEN 1
    END

  INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @MeleeItemID)
  IF 0 <> @@ERROR BEGIN
	ROLLBACK TRAN
	RETURN (-1)
  END

  SET @MeleeCIID = @@IDENTITY

  /* Primary */
  SET @PrimaryItemID = 
    CASE @Costume
    WHEN 0 THEN 5001
    WHEN 1 THEN 5002
    WHEN 2 THEN 4005
    WHEN 3 THEN 4001
    WHEN 4 THEN 4002
    WHEN 5 THEN 4006
    END

  INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @PrimaryItemID)
  IF 0 <> @@ERROR BEGIN
	ROLLBACK TRAN
	RETURN (-1)
  END

  SET @PrimaryCIID = @@IDENTITY

  /* Secondary */
IF @Costume = 0 OR @Costume = 2 BEGIN
  SET @SecondaryItemID =
    CASE @Costume
    WHEN 0 THEN 4001
    WHEN 1 THEN 0
    WHEN 2 THEN 5001
    WHEN 3 THEN 4006
    WHEN 4 THEN 0
    WHEN 5 THEN 4006
    END

  IF @SecondaryItemID <> 0 BEGIN
    INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @SecondaryItemID)
    IF 0 <> @@ERROR BEGIN
	ROLLBACK TRAN
	RETURN (-1)
    END

    SET @SecondaryCIID = @@IDENTITY
  END
END
  SET @Custom1ItemID = 
    CASE @Costume
    WHEN 0 THEN 30301
    WHEN 1 THEN 30301
    WHEN 2 THEN 30401
    WHEN 3 THEN 30401
    WHEN 4 THEN 30401
    WHEN 5 THEN 30101
    END

  /* Custom1 */
  INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @Custom1ItemID)
  IF 0 <> @@ERROR BEGIN
	ROLLBACK TRAN
	RETURN (-1)
  END

  SET @Custom1CIID = @@IDENTITY

  /* Custom2 */
IF @Costume = 4 OR @Costume = 5
BEGIN
  SET @Custom2ItemID =
    CASE @Costume
    WHEN 0 THEN 0
    WHEN 1 THEN 0
    WHEN 2 THEN 0
    WHEN 3 THEN 0
    WHEN 4 THEN 30001
    WHEN 5 THEN 30001
    END

  IF @Custom2ItemID <> 0
  BEGIN
    INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @Custom2ItemID)
    IF 0 <> @@ERROR BEGIN
	ROLLBACK TRAN
	RETURN (-1)
    END

    SET @Custom2CIID = @@IDENTITY
  END
END


IF @Sex = 0		/* 남자일 경우 */
BEGIN

  /* Chest */
  SET @ChestItemID =
    CASE @Costume
    WHEN 0 THEN 21001
    WHEN 1 THEN 21001
    WHEN 2 THEN 21001
    WHEN 3 THEN 21001
    WHEN 4 THEN 21001
    WHEN 5 THEN 21001
    END


  INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @ChestItemID)
  IF 0 <> @@ERROR BEGIN
	ROLLBACK TRAN
	RETURN (-1)
  END

  SET @ChestCIID = @@IDENTITY

  /* Legs */
  SET @LegsItemID =
    CASE @Costume
    WHEN 0 THEN 23001
    WHEN 1 THEN 23001
    WHEN 2 THEN 23001
    WHEN 3 THEN 23001
    WHEN 4 THEN 23001
    WHEN 5 THEN 23001
    END


  INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @LegsItemID)
  IF 0 <> @@ERROR BEGIN 
	ROLLBACK TRAN
	RETURN (-1)
  END

  SET @LegsCIID = @@IDENTITY

END
ELSE
BEGIN			/* 여자일 경우 */

  /* Chest */
  SET @ChestItemID =
    CASE @Costume
    WHEN 0 THEN 21501
    WHEN 1 THEN 21501
    WHEN 2 THEN 21501
    WHEN 3 THEN 21501
    WHEN 4 THEN 21501
    WHEN 5 THEN 21501
    END


  INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @ChestItemID)
  IF 0 <> @@ERROR BEGIN
	ROLLBACK TRAN
	RETURN (-1)
  END
  SET @ChestCIID = @@IDENTITY

  /* Legs */
  SET @LegsItemID =
    CASE @Costume
    WHEN 0 THEN 23501
    WHEN 1 THEN 23501
    WHEN 2 THEN 23501
    WHEN 3 THEN 23501
    WHEN 4 THEN 23501
    WHEN 5 THEN 23501
    END


  INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @LegsItemID)
  IF 0 <> @@ERROR BEGIN
	ROLLBACK TRAN
	RETURN (-1)
  END
  SET @LegsCIID = @@IDENTITY

END  

UPDATE Character
SET chest_slot = @ChestCIID, legs_slot = @LegsCIID, melee_slot = @MeleeCIID,
    primary_slot = @PrimaryCIID, secondary_slot = @SecondaryCIID, custom1_slot = @Custom1CIID,
    custom2_slot = @Custom2CIID,
    chest_itemid = @ChestItemID, legs_itemid = @LegsItemID, melee_itemid = @MeleeItemID,
    primary_itemid = @PrimaryItemID, secondary_itemid = @SecondaryItemID, custom1_itemid = @Custom1ItemID,
    custom2_itemid = @Custom2ItemID
WHERE CID=@CharIdent
IF 0 = @@ROWCOUNT BEGIN
	ROLLBACK TRAN
	RETURN (-1)
END

IF (GETDATE() < '2009-06-29T07:00:00')
BEGIN
	INSERT INTO dbo.EventCharacter(AID, CID, DeleteFlag, StartXP, StartLevel, PlayTime, LastXP, Lastlevel)
	VALUES (@AID, @CharIdent, 0, 0, 1, 0, 0, 1);
	IF (0 <> @@ERROR)
	BEGIN
		ROLLBACK TRAN;
		RETURN (-1);
	END
END
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spInsertPlayerLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ÇÃ·¹ÀÌ¾î ·Î±× */
CREATE PROC [dbo].[BackUp_spInsertPlayerLog]
	@CID          int,
	@PlayTime     int,
	@Kills        int,
	@Deaths       int,
	@XP           int,
	@TotalXP      int
AS
SET NOCOUNT ON
BEGIN TRAN
INSERT INTO PlayerLog (CID, DisTime, PlayTime, Kills, Deaths, XP, TotalXP)
VALUES	(@CID, GETDATE(), @PlayTime, @Kills, @Deaths, @XP, @TotalXP)
IF 0 <> @@ERROR BEGIN 
	ROLLBACK TRAN
	RETURN
END
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spSelectAccountItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Áß¾ÓÀºÇà ¾ÆÀÌÅÛ º¸±â */
CREATE PROC [dbo].[BackUp_spSelectAccountItem]
	@AID			int
AS
SET NOCOUNT ON

DECLARE @NowTime DATETIME
SELECT @NowTime = GETDATE()

SELECT AIID, ItemID, (RentHourPeriod*60) - (DateDiff(n, RentDate, @NowTime)) AS RentPeriodRemainder
FROM AccountItem(NOLOCK)
WHERE AID=@AID ORDER BY AIID
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spSelectCharItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Ä³¸¯ÅÍ ¾ÆÀÌÅÛ º¸±â */
CREATE PROC [dbo].[BackUp_spSelectCharItem]
	@CID		int
AS
SET NOCOUNT ON

DECLARE @NowTime DATETIME
SELECT @NowTime = GETDATE()

SELECT CIID, ItemID, (RentHourPeriod*60) - (DateDiff(n, RentDate, @NowTime)) AS RentPeriodRemainder
FROM CharacterItem (nolock)
WHERE CID=@CID ORDER BY CIID
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spSellBountyItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------------------------------------------------------------------
-- ÀÛ¾÷ÇÒ Äõ¸®
/*
EXEC sp_rename 'spSellBountyItem', 'BackUp_spSellBountyItem'
GO
*/

CREATE PROC [dbo].[BackUp_spSellBountyItem]
-- CREATE PROC dbo.spSellBountyItem
	@CID		INT,  
	@CIID		INT,
	@ItemID		INT,
	@Price		INT,  
	@CharBP		INT  
AS BEGIN

	SET NOCOUNT ON;
	
	BEGIN TRAN -------------------
	
		-- Bounty Áõ°¡  
		UPDATE dbo.Character SET BP = BP + @Price WHERE CID = @CID
		
		IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN  
			ROLLBACK
			SELECT -1 AS Ret;
			RETURN;
		END  


		UPDATE	dbo.CharacterItem
		SET		CID = NULL
		WHERE	CIID = @CIID
		AND		CID = @CID;
		
		IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN  
			ROLLBACK
			SELECT -2 AS Ret;
			RETURN;
		END		
		
		-- Item ÆÇ¸Å ·Î±× Ãß°¡  
		INSERT INTO dbo.ItemPurchaseLogByBounty(ItemID, CID, Date, Bounty, CharBounty, Type)
		VALUES (@ItemID, @CID, GETDATE(), @Price, @CharBP, 'ÆÇ¸Å')
		
		IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN  
			ROLLBACK
			SELECT -3 AS Ret;
			RETURN;
		END		
		
	COMMIT TRAN ------------------- 
			
	SELECT 0 AS Ret
END
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spUpdateCharInfoData]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Ä³¸¯ÅÍ Á¤º¸(XP, BP, KillCount, DeathCount) ¾÷µ¥ÀÌÆ® */
CREATE PROC [dbo].[BackUp_spUpdateCharInfoData]
  @XPInc        int,
  @BPInc        int,
  @KillInc      int,
  @DeathInc     int,
  @CID          int
AS
SET NOCOUNT ON
  
UPDATE Character 
SET XP=XP+(@XPInc), BP=BP+(@BPInc), KillCount=KillCount+(@KillInc), DeathCount=DeathCount+(@DeathInc)
WHERE CID=@CID
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spUpdateEquipItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ¾ÆÀÌÅÛ Àåºñ */
CREATE PROC [dbo].[BackUp_spUpdateEquipItem]
	@CID			int,
	@ItemParts		int,
	@CIID			int,
	@ItemID			int
AS

SET NoCount ON

DECLARE @Ret int
DECLARE @IF_CIID	int

SELECT @Ret = 1

-- Head
IF @ItemParts = 0
BEGIN
	IF @CIID = 0
	BEGIN
		UPDATE Character SET head_slot=NULL, head_itemid=NULL WHERE CID=@CID
	END
	ELSE
	BEGIN
		UPDATE Character SET head_slot=@CIID, head_itemid=@ItemID WHERE CID=@CID
	END
END
-- Chest
ELSE IF @ItemParts = 1
BEGIN
	IF @CIID = 0
	BEGIN
		UPDATE Character SET chest_slot=NULL, chest_itemid=NULL WHERE CID=@CID
	END
	ELSE
	BEGIN
		UPDATE Character SET chest_slot=@CIID, chest_itemid=@ItemID WHERE CID=@CID
	END
END
-- Hands
ELSE IF @ItemParts = 2
BEGIN
	IF @CIID = 0
	BEGIN
		UPDATE Character SET hands_slot=NULL, hands_itemid=NULL WHERE CID=@CID
	END
	ELSE
	BEGIN
		UPDATE Character SET hands_slot=@CIID, hands_itemid=@ItemID WHERE CID=@CID
	END
END
-- Legs
ELSE IF @ItemParts = 3
BEGIN
	IF @CIID = 0
	BEGIN
		UPDATE Character SET legs_slot=NULL, legs_itemid=NULL WHERE CID=@CID
	END
	ELSE
	BEGIN
		UPDATE Character SET legs_slot=@CIID, legs_itemid=@ItemID WHERE CID=@CID
	END
END
-- Feet
ELSE IF @ItemParts = 4
BEGIN
	IF @CIID = 0
	BEGIN
		UPDATE Character SET feet_slot=NULL, feet_itemid=NULL WHERE CID=@CID
	END
	ELSE
	BEGIN
		UPDATE Character SET feet_slot=@CIID, feet_itemid=@ItemID WHERE CID=@CID
	END
END
-- FingerL
ELSE IF @ItemParts = 5
BEGIN
	IF @CIID = 0
	BEGIN
		UPDATE Character SET fingerl_slot=NULL, fingerl_itemid=NULL WHERE CID=@CID
	END
	ELSE
	BEGIN
		SELECT @IF_CIID = fingerr_slot FROM Character(nolock) WHERE CID=@CID
		IF (@IF_CIID IS NOT NULL) AND (@IF_CIID = @CIID)
		BEGIN
			SELECT @Ret = 0
		END
		ELSE
		BEGIN
			UPDATE Character SET fingerl_slot=@CIID, fingerl_itemid=@ItemID WHERE CID=@CID
		END
	END
END
-- FingerR
ELSE IF @ItemParts = 6
BEGIN
	IF @CIID = 0
	BEGIN
		UPDATE Character SET fingerr_slot=NULL, fingerr_itemid=NULL WHERE CID=@CID
	END
	ELSE
	BEGIN
		SELECT @IF_CIID = fingerl_slot FROM Character(nolock) WHERE CID=@CID
		IF (@IF_CIID IS NOT NULL) AND (@IF_CIID = @CIID)
		BEGIN
			SELECT @Ret = 0
		END
		ELSE
		BEGIN
			UPDATE Character SET fingerr_slot=@CIID, fingerr_itemid=@ItemID WHERE CID=@CID
		END
	END
END
-- Melee
ELSE IF @ItemParts = 7
BEGIN
	IF @CIID = 0
	BEGIN
		UPDATE Character SET melee_slot=NULL, melee_itemid=NULL WHERE CID=@CID
	END
	ELSE
	BEGIN
		UPDATE Character SET melee_slot=@CIID, melee_itemid=@ItemID WHERE CID=@CID
	END
END
-- Primary
ELSE IF @ItemParts = 8
BEGIN
	IF @CIID = 0
	BEGIN
		UPDATE Character SET primary_slot=NULL, primary_itemid=NULL WHERE CID=@CID
	END
	ELSE
	BEGIN
		SELECT @IF_CIID = secondary_slot FROM Character(nolock) WHERE CID=@CID
		IF (@IF_CIID IS NOT NULL) AND (@IF_CIID = @CIID)
		BEGIN
			SELECT @Ret = 0
		END
		ELSE
		BEGIN
			UPDATE Character SET primary_slot=@CIID, primary_itemid=@ItemID WHERE CID=@CID
		END
	END
END
-- Secondary
ELSE IF @ItemParts = 9
BEGIN
	IF @CIID = 0
	BEGIN
		UPDATE Character SET secondary_slot=NULL, secondary_itemid=NULL WHERE CID=@CID
	END
	ELSE
	BEGIN
		SELECT @IF_CIID = primary_slot FROM Character(nolock) WHERE CID=@CID
		IF (@IF_CIID IS NOT NULL) AND (@IF_CIID = @CIID)
		BEGIN
			SELECT @Ret = 0
		END
		ELSE
		BEGIN
			UPDATE Character SET secondary_slot=@CIID, secondary_itemid=@ItemID WHERE CID=@CID
		END
	END
END
-- Custom1
ELSE IF @ItemParts = 10
BEGIN
	IF @CIID = 0
	BEGIN
		UPDATE Character SET custom1_slot=NULL, custom1_itemid=NULL WHERE CID=@CID
	END
	ELSE
	BEGIN
		SELECT @IF_CIID = custom2_slot FROM Character(nolock) WHERE CID=@CID
		IF (@IF_CIID IS NOT NULL) AND (@IF_CIID = @CIID)
		BEGIN
			SELECT @Ret = 0
		END
		ELSE
		BEGIN
			UPDATE Character SET custom1_slot=@CIID, custom1_itemid=@ItemID WHERE CID=@CID
		END
	END
END
-- Custom2
ELSE IF @ItemParts = 11
BEGIN
	IF @CIID = 0
	BEGIN
		UPDATE Character SET custom2_slot=NULL, custom2_itemid=NULL WHERE CID=@CID
	END
	ELSE
	BEGIN
		SELECT @IF_CIID = custom1_slot FROM Character(nolock) WHERE CID=@CID
		IF (@IF_CIID IS NOT NULL) AND (@IF_CIID = @CIID)
		BEGIN
			SELECT @Ret = 0
		END
		ELSE
		BEGIN
			UPDATE Character SET custom2_slot=@CIID, custom2_itemid=@ItemID WHERE CID=@CID
		END
	END
END



SELECT @Ret AS Ret
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spWebChangeClanName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[BackUp_spWebChangeClanName]
	@MasterName varchar(24),
	@NewClanName as varchar(24)
as
begin
	set nocount on

	declare @CID int
	declare @sex tinyint

	select @CID = CID, @sex = sex 
	from dbo.Character with(nolock) 
	where Name = @MasterName and DeleteFlag <> 1

	if (@CID is null) or ((@sex <> 0) and (@sex <> 1 ))
	begin
		return (-1)
	end

	declare @CLID	int
	declare @OldClanName	varchar(28)
 
	select @CLID = CLID, @OldClanName = Name
	from dbo.Clan with (nolock) 
	where MasterCID = @CID and DeleteFlag <> 1

	if (@CLID is null)
	begin
		return (-2)
	end

	declare @ItemID int

	if (@sex = 0)
		set @ItemID = 21011
	else if(@sex = 1)
		set @ItemID = 21511
	else
		return (-3)

	begin tran
		update dbo.Clan
		set Name = @NewClanName
		where CLID = @CLID

		if (0 <> @@ERROR) or (0 = @@ROWCOUNT) 
		begin
			rollback tran
			return (-4)
		end

		insert into dbo.CharacterItem(CID, ItemID, RegDate, RentDate, RentHourPeriod)
		values(@CID, @ItemID, getdate(), getdate(), 2160)

		if (0 <> @@ERROR) or (0 = @@ROWCOUNT)
		begin
			rollback tran
			return (-5)
		end

		insert into LogDB.dbo.ChangeClanNameLog(CLID, OldName, NewName, MasterCID, MasterName, RegDate)
		values(@CLID, @OldClanName, @NewClanName, @CID, @MasterName, getdate())

		if (0 <> @@ERROR) or (0 = @@ROWCOUNT) 
		begin
			rollback tran
			return (-6)
		end
	commit tran

	return 1

end
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spWebChangeClanName_Netmarble]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------

-- 캐릭터 삭제  프로시져
CREATE PROC [dbo].[BackUp_spWebChangeClanName_Netmarble]
 @AID  int
, @CharNum smallint
, @CharName varchar(24)
, @GMID varchar(20)
, @Ret int OUTPUT	
AS
 SET NOCOUNT ON 

 DECLARE @CID int
 DECLARE @ErrSlot int
 DECLARE @ErrDelInfo int
 DECLARE @ErrName int

 SELECT @CID = CID FROM Character(NOLOCK) 
 WHERE AID = @AID AND Name = @CharName AND CharNum = @CharNum
 IF @CID IS NULL BEGIN 
  SET @Ret = 0
  RETURN @Ret
 END

 BEGIN TRAN
 -- 캐쉬아이템은 중앙은행으로 돌려줘야 함.
 INSERT INTO AccountItem( AID, ItemID, RentDate, RentHourPeriod, Cnt )
 SELECT @AID AS AID, ItemID, RentDate, RentHourPeriod, Cnt
 FROM CharacterItem(NOLOCK)
 WHERE CID = @CID AND ItemID > 499999
 IF 0 <> @@ERROR BEGIN 
  ROLLBACK TRAN
  SET @Ret = 0
  RETURN @Ret
 END

 DELETE CharacterItem WHERE CID = @CID
 IF 0 <> @@ERROR BEGIN 
  ROLLBACK TRAN
  SET @Ret = 0
  RETURN @Ret
 END

 UPDATE Character SET head_slot = NULL, chest_slot = NULL, hands_slot = NULL,
 legs_slot = NULL, feet_slot = NULL, fingerl_slot = NULL, 
 fingerr_slot = NULL, melee_slot = NULL, primary_slot = NULL, 
 secondary_slot = NULL, custom1_slot = NULL, custom2_slot = NULL
 WHERE CID = @CID
 SET @ErrSlot = @@ROWCOUNT

 UPDATE Character SET DeleteName = Name, DeleteFlag = 1 WHERE CID = @CID
 SET @ErrDelInfo = @@ROWCOUNT

 UPDATE Character SET Name = '' WHERE CID = @CID
 SET @ErrName = @@ROWCOUNT

 IF (0 = @ErrSlot) OR (0 = @ErrDelInfo) OR (0 = @ErrName) BEGIN
  ROLLBACK TRAN
  SET @Ret = 0
  RETURN @Ret
 END
 COMMIT TRAN
	
 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[BackUp_spWebResetChar]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Ä³¸¯ÅÍ ÃÊ±âÈ­
CREATE   PROC [dbo].[BackUp_spWebResetChar]
	@CID		INT
AS
SET NOCOUNT ON

BEGIN
	-- ½ºÅÈ ÃÊ±âÈ­
	UPDATE Character SET Level=1, XP=0, BP=0, 

	head_slot=NULL, chest_slot=NULL, hands_slot=NULL, legs_slot=NULL, feet_slot=NULL,
	fingerl_slot=NULL, fingerr_slot=NULL, melee_slot=NULL, primary_slot=NULL, secondary_slot=NULL,
	custom1_slot=NULL, custom2_slot=NULL,
	GameCount=0, KillCount=0, DeathCount=0, 
	head_itemid=NULL, chest_itemid=NULL, hands_itemid=NULL, legs_itemid=NULL, feet_itemid=NULL,
	fingerl_itemid=NULL, fingerr_itemid=NULL, melee_itemid=NULL, primary_itemid=NULL, secondary_itemid=NULL,
	custom1_itemid=NULL, custom2_itemid=NULL, QuestItemInfo=NULL

	WHERE CID=@CID

	-- ¾ÆÀÌÅÛ »èÁ¦(»ó¿ë ¾ÆÀÌÅÛÀº Á¦¿Ü)
	UPDATE CharacterItem SET CID=NULL WHERE CID=@CID AND ItemID < 500000

END
GO
/****** Object:  StoredProcedure [dbo].[InsertGamePlayerLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[InsertGamePlayerLog]
-- ALTER PROC dbo.InsertGamePlayerLog
    @GameLogID      INT
    , @CID          INT
    , @PlayTime     INT
    , @Kills        INT
    , @Deaths       INT
    , @XP           INT
    , @BP           INT
AS BEGIN

    SET NOCOUNT ON;

    INSERT INTO LogDB.dbo.GamePlayerLog(ID, CID, PlayTime, Kills, Deaths, XP, BP)
    VALUES (@GameLogID, @CID, @PlayTime, @Kills, @Deaths, @XP, @BP);

END
GO
/****** Object:  StoredProcedure [dbo].[old_spWebChangeClanName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[old_spWebChangeClanName]
 @MasterName varchar(24)
, @NewClanName as varchar(28)
as
begin
 set nocount on

 declare @CID int
 declare @sex tinyint

 select @CID = c.CID, @sex = sex from dbo.Character c(nolock) where c.Name = @MasterName and c.DeleteFlag <> 1
 if (@CID is null) or ((0 <> @sex) and (1 <> @sex))
 begin
  return (-1)
 end

 declare @CLID int
 declare @OldClanName varchar(28)
 
 select @CLID = CLID, @OldClanName = Name
 from dbo.Clan cl(nolock) 
 where cl.MasterCID = @CID and 1 <> cl.DeleteFlag
 if @CLID is null 
 begin
  return (-2)
 end

 declare @ItemID int

 if (0 = @sex)
  set @ItemID = 21011
 else if(1 = @sex)
  set @ItemID = 21511
 else
  return (-3)

 begin tran

 update dbo.Clan
 set Name = @NewClanName
 where CLID = @CLID
 if (0 <> @@ERROR) or (0 = @@ROWCOUNT) 
 begin
  rollback tran
  return (-4)
 end

 insert into dbo.CharacterItem(CID, ItemID, RegDate, RentDate, RentHourPeriod)
 values(@CID, @ItemID, getdate(), getdate(), 2160)
 if (0 <> @@ERROR) or (0 = @@ROWCOUNT)
 begin
  rollback tran
  return (-5)
 end
 


 insert into LogDB.dbo.ChangeClanNameLog(CLID, OldName, NewName, MasterCID, MasterName, RegDate)
 values(@CLID, @OldClanName, @NewClanName, @CID, @MasterName, getdate())
 if (0 <> @@ERROR) or (0 = @@ROWCOUNT) 
 begin
  rollback tran
  return (-6)
 end
 
 commit tran

 return 1
end
GO
/****** Object:  StoredProcedure [dbo].[old_spWebIsValidClanName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[old_spWebIsValidClanName]
 @Name varchar(28)
as
begin
 set nocount on

 if (@Name is null) or (4 > len(@Name))return (-1)
 
 if exists(select * from dbo.AbuseList al(nolock) where @Name like al.Word)
 begin
  return -2
 end

 if exists(select * from dbo.Clan cl(nolock) where cl.Name = @Name) 
 begin
  return -3
 end

 return 1
end
GO
/****** Object:  StoredProcedure [dbo].[sp_event_back2school]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_event_back2school]
as 
	delete from event_back2school where regdate = convert(char(10),dateadd (dd,-1,getdate()),121)

	insert into event_back2school(userid,playtime)
	select c.userid , sum(a.playtime)/60
	from playerlog as a with(nolock) join character as b with(nolock)
	on a.CID = b.CID join account as c
	on b.AID = c.AID
--	where a.distime >= convert(char(10),dateadd(dd,-3,getdate()),121) and a.distime < convert(char(10),getdate(),121) 
	where a.distime >= dateadd(mi,-10,getdate()) and a.distime < getdate()
	group by c.userid
--	having sum(a.playtime)/60 >= 60
	having sum(a.playtime)/60 >= 1
GO
/****** Object:  StoredProcedure [dbo].[sp_event_easter2011]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_event_easter2011]
as 
	delete from event_easter2011 
	where regdate = convert(char(10),dateadd (dd,-1,getdate()),112)

	insert into event_easter2011 (userid,playtime)
	select c.userid , sum(a.playtime)/60
	from playerlog as a with(nolock) join character as b with(nolock)
	on a.CID = b.CID join account as c
	on b.AID = c.AID
	--where a.distime >= convert(char(10),dateadd (dd,-1,getdate()),121)
	--	and a.distime < convert(char(10),getdate(),121)
	where a.distime >= convert(char(10),getdate(),121)
	group by c.userid
	having sum(a.playtime)/60 >= 60
GO
/****** Object:  StoredProcedure [dbo].[spAddClanMember]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 멤버 추가
CREATE   PROC [dbo].[spAddClanMember]
	@CLID		int,
	@CID		int,
	@Grade		tinyint
AS
	-- 클랜에 가입되어 있는지 확인
	IF EXISTS(SELECT * FROM ClanMember(NOLOCK) WHERE CID = @CID)
	BEGIN
		SELECT 0 AS Ret
		RETURN (-1)
	END

	-- 클랜이 존재하는지 체크
	DECLARE @varClanCount		int

	SELECT @varClanCount=COUNT(*) FROM Clan(nolock) WHERE CLID=@CLID AND ((DeleteFlag IS NULL) OR (DeleteFlag=0))
	IF (@varClanCount = 0)
	BEGIN
		SELECT 0 AS Ret
		return (-1)
	END

	-- 클랜원수 체크
	DECLARE @MemberCount		int

	SELECT @MemberCount=COUNT(*) FROM ClanMember(nolock) WHERE CLID=@CLID
	IF @MemberCount >= 64	-- 최대 64명까지 가능
	BEGIN
		SELECT 0 AS Ret
		return (-1)
	END

	INSERT INTO ClanMember (CLID, CID, Grade, RegDate) VALUES (@CLID, @CID, @Grade, GETDATE())
	SELECT 1 AS Ret
GO
/****** Object:  StoredProcedure [dbo].[spAddFriend]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- sp 

-- Ä£±¸ Ãß°¡
CREATE PROC [dbo].[spAddFriend]
	@CID		int
,	@FriendCID	int
,	@Favorite	tinyint
AS
BEGIN TRAN
	SET NOCOUNT ON
	DECLARE @ID	int
	INSERT INTO Friend(CID, FriendCID, Favorite, DeleteFlag, Type) Values (@CID, @FriendCID, @Favorite, 0, 1)
	IF 0 <> @@ERROR BEGIN
		ROLLBACK TRAN
		RETURN
	END
	SET @ID = @@IDENTITY
	SELECT @ID as ID
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebAccountItemInfoByAID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAdmWebAccountItemInfoByAID]
-- ALTER PROC dbo.spAdmWebAccountItemInfoByAID
	@AID	INT
AS BEGIN

	SET NOCOUNT ON
	
	SELECT	ai.AIID, ai.RentHourPeriod, i.Name, ai.ItemID, ai.Cnt
			, CASE ISNULL(RentDate, 0)	
				WHEN 0 THEN '0'  
				ELSE (RentHourPeriod-DATEDIFF (hh, RentDate, GetDate()))    
			END AS RentRemain  
			, CASE ISNULL(ai.RentDate, 0)	
				WHEN 0 THEN '0'  
				ELSE CAST(ai.RentDate AS VARCHAR(24))  
			END as RentDate  
	FROM   AccountItem ai(NOLOCK) JOIN Item i(NOLOCK)   
			ON	ai.AID = @AID 
			AND i.ItemID = ai.ItemID  	
END

-------------------------------------------------------------------------------------------------------------------------
-- º¹±¸ Äõ¸®
/*
DROP PROC spAdmWebAccountItemInfoByAID
EXEC sp_rename 'BackUp_spAdmWebAccountItemInfoByAID', 'spAdmWebAccountItemInfoByAID';
*/
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebAddClanMember]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebAddClanMember]
 @CLID int
, @NewCID int
, @GMID varchar(20)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON 

 IF NOT EXISTS (SELECT CID FROM Character(NOLOCK)
  WHERE CID = @NewCID AND DeleteFlag <> 1) BEGIN 
  SET @Ret = 0
  RETURN @Ret
 END 

 IF NOT EXISTS (SELECT CLID FROM Clan(NOLOCK) 
  WHERE CLID = @CLID AND DeleteFlag <> 1) BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 IF EXISTS (SELECT CMID FROM ClanMember(NOLOCK)
  WHERE CID = @NewCID) BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 INSERT INTO ClanMember(CLID, CID, Grade, RegDate, ContPoint)
 VALUES (@CLID, @NewCID, 9, GETDATE(), 0)
 IF 0 <> @@ERROR BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebChangeCharDeathCount]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebChangeCharDeathCount]
 @CID int
, @DeathCount int
, @GMID varchar(20)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON

 IF (0 > @DeathCount) BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 UPDATE Character SET DeathCount = @DeathCount
 WHERE CID = @CID
 IF 0 = @@ROWCOUNT BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebChangeCharKillCount]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebChangeCharKillCount]
 @CID int
, @KillCount int
, @GMID varchar(20)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON
 IF (0 > @KillCount) BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 UPDATE Character SET KillCount = @KillCount 
 WHERE CID = @CID
 IF 0 = @@ROWCOUNT BEGIN 
  SET @Ret = 0
  RETURN @Ret
 END

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebChangeCharName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebChangeCharName]
 @CID int
, @CharName varchar(24)
, @GMID varchar(20)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON
 IF NOT EXISTS( SELECT CID FROM Character(NOLOCK) 
  WHERE (DeleteFlag <> 1) AND (Name = @CharName)) BEGIN
  UPDATE Character SET Name = @CharName WHERE CID = @CID
  IF 0 = @@ROWCOUNT BEGIN
   SET @Ret = 0
   RETURN @Ret
  END
 END
 ELSE BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebChangeClanEXP]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebChangeClanEXP]
 @CLID int
, @NewEXP int
, @GMID varchar(20)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON

 IF 0 > @NewEXP BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 UPDATE Clan SET EXP = @NewEXP 
  WHERE CLID = @CLID AND DeleteFlag <> 1
 IF 0 = @@ROWCOUNT BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebChangeClanHomepage]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebChangeClanHomepage]
 @CLID int
, @NewHomePage varchar(128)
, @GMID varchar(20)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON 

 UPDATE Clan SET Homepage = @NewHomepage 
  WHERE CLID = @CLID AND DeleteFlag <> 1
 IF 0 = @@ROWCOUNT BEGIN 
  SET @Ret = 0
  RETURN @Ret
 END

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebChangeClanIntroduction]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------
  
CREATE PROC [dbo].[spAdmWebChangeClanIntroduction]  
 @CLID int  
, @NewIntroduction varchar(1024)  
, @GMID varchar(20)
, @Ret int OUTPUT  
AS  
 SET NOCOUNT ON  
  
 UPDATE Clan SET Introduction = @NewIntroduction WHERE CLID = @CLID  
 IF 0 = @@ROWCOUNT BEGIN  
  SET @Ret = 0  
  RETURN @Ret  
 END  
  
 SET @Ret = 1  
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebChangeClanMemberGrade]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebChangeClanMemberGrade]
 @CLID int
, @CID int
, @NewGrade int
, @GMID varchar(20)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON 

 IF NOT EXISTS (SELECT GradeID FROM ClanMemberGrade(NOLOCK) 
  WHERE GradeID=@NewGrade) BEGIN
  SET @Ret=0
  RETURN @Ret
 END

 IF 1=@NewGrade BEGIN -- master duplication check.
  IF EXISTS (SELECT CID FROM ClanMember(NOLOCK) 
   WHERE CLID=@CLID AND Grade=@NewGrade) BEGIN
   SET @Ret=0
   RETURN @Ret
  END
 END

 UPDATE ClanMember SET Grade=@NewGrade WHERE CLID=@CLID AND CID=@CID
 IF 0=@@ROWCOUNT BEGIN
  SET @Ret=0
  RETURN @Ret
 END

 SET @Ret=1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebChangeClanName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebChangeClanName]
 @CLID int
, @NewClanName varchar(24)
, @GMID varchar(20)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON 

 IF EXISTS (SELECT CLID FROM Clan(NOLOCK) 
  WHERE Name = @NewClanName AND DeleteFlag <> 1) BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 UPDATE Clan SET Name = @NewClanName 
 WHERE CLID = @CLID AND DeleteFlag <> 1
 IF 0 = @@ROWCOUNT BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebChangeClanPoint]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebChangeClanPoint]
 @CLID int
, @NewClanPoint int
, @GMID varchar(20)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON

 IF 0 > @NewClanPoint BEGIN 
  SET @Ret = 0
  RETURN @Ret
 END

 UPDATE Clan SET Point = @NewClanPoint 
  WHERE CLID = @CLID AND DeleteFlag <> 1
 IF 0 = @@ROWCOUNT BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebChangeClanTotalPoint]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebChangeClanTotalPoint]
 @CLID int
, @NewClanTotalPoint int
, @GMID varchar(20)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON 

 IF 0 > @NewClanTotalPoint BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 UPDATE Clan SET TotalPoint = @NewClanTotalPoint 
 WHERE CLID = @CLID AND DeleteFlag <> 1
 IF 0 = @@ROWCOUNT BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebChangeWinsLosses]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebChangeWinsLosses]
 @CLID int
, @NewWins int
, @NewLosses int
, @GMID varchar(20)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON

 IF (0 > @NewWins) OR (0 > @NewLosses) BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 UPDATE Clan SET Wins = @NewWins, Losses = @NewLosses 
 WHERE CLID = @CLID AND DeleteFlag <> 1
 IF 0=@@ROWCOUNT BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebDeleteAccountItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAdmWebDeleteAccountItem]
-- ALTER PROC dbo.spAdmWebDeleteAccountItem
	@AID		INT
	, @AIID		INT
	, @ItemID	INT
	, @GMID		VARCHAR(20)
	, @Ret		INT OUTPUT    
AS BEGIN
	SET NOCOUNT ON;   

	IF NOT EXISTS ( SELECT AID FROM Account(NOLOCK) WHERE AID = @AID) BEGIN    
		SET @Ret = 0;
		RETURN @Ret;
	END
		
	DELETE	AccountItem 
	WHERE	AIID = @AIID 
	AND		AID = @AID 
	AND		ItemID = @ItemID
		
	IF (0 <> @@ERROR OR 0 = @@ROWCOUNT) BEGIN
		SET @Ret = 0;
		RETURN @Ret;
	END
	
	SET @Ret = 1;
	RETURN @Ret;
END
  
-------------------------------------------------------------------------------------------------------------------------
-- º¹±¸ Äõ¸®
/*
DROP PROC spAdmWebDeleteAccountItem
EXEC sp_rename 'BackUp_spAdmWebDeleteAccountItem', 'spAdmWebDeleteAccountItem';
*/
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebDeleteCashSetShopItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-----------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebDeleteCashSetShopItem]
 @CSSID int
, @Ret int OUTPUT
AS
 SET NOCOUNT ON
 DELETE CashSetShop WHERE CSSID = @CSSID
 IF 0 <> @@ERROR BEGIN
  SET @Ret = 0
  RETURN
 END

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebDeleteCashShopItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebDeleteCashShopItem]
 @CSID int
, @Ret int OUTPUT
AS
 SET NOCOUNT ON 

 BEGIN TRAN
 DELETE CashShop WHERE CSID = @CSID
 IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN
  ROLLBACK TRAN
  SET @Ret = 0
  RETURN @Ret 
 END

 DELETE RentCashShopPrice WHERE CSID = @CSID
 IF 0 <> @@ERROR BEGIN
  ROLLBACK TRAN
  SET @Ret = 0
  RETURN @Ret
 END 
 COMMIT TRAN

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebDeleteChar]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAdmWebDeleteChar]  
-- ALTER PROC dbo.spAdmWebDeleteChar  
	@AID			INT
	, @CharNum		SMALLINT
	, @CharName		VARCHAR(24)  
	, @GMID			VARCHAR(20)  
	, @Ret			INT OUTPUT   
AS BEGIN

	SET NOCOUNT ON   

	DECLARE @CID		INT
	DECLARE @ErrSlot	INT
	DECLARE @ErrDelInfo INT
	DECLARE @ErrName	INT

	SELECT	@CID = CID 
	FROM	Character(NOLOCK)   
	WHERE	AID = @AID 
	AND		Name = @CharName 
	AND		CharNum = @CharNum
	
	IF (@CID IS NULL) BEGIN
		SET @Ret = 0  
		RETURN @Ret
	END  

	BEGIN TRAN ----------------			
				
		-- 캐쉬아이템은 중앙은행으로 돌려줘야 함.  
		INSERT INTO AccountItem( AID, ItemID, RentDate, RentHourPeriod, Cnt )  
			SELECT	@AID AS AID, ItemID, RentDate, RentHourPeriod, Cnt  
			FROM	CharacterItem(NOLOCK)  
			WHERE	CID = @CID 
			AND		ItemID > 499999
			
		IF (0 <> @@ERROR) BEGIN
			ROLLBACK TRAN  
			SET @Ret = 0  
			RETURN @Ret
		END  


		UPDATE	CharacterItem
		SET		CID = NULL
		WHERE	CID = @CID;
		
		IF (0 <> @@ERROR) BEGIN
			ROLLBACK TRAN
			SET @Ret = 0
			RETURN @Ret
		END  


		UPDATE	CharacterEquipmentSlot
		SET		CIID = NULL, ItemID = NULL
		WHERE	CID = @CID
		
		SET @ErrSlot = @@ROWCOUNT  
		

		UPDATE	Character 
		SET		DeleteName = Name, DeleteFlag = 1 
		WHERE	CID = @CID
		
		SET @ErrDelInfo = @@ROWCOUNT  


		UPDATE	Character 
		SET		Name = '' 
		WHERE	CID = @CID
		
		SET @ErrName = @@ROWCOUNT  

		IF (0 = @ErrSlot) OR (0 = @ErrDelInfo) OR (0 = @ErrName) BEGIN  
		ROLLBACK TRAN  
		SET @Ret = 0  
		RETURN @Ret  
		END
		
	COMMIT TRAN --------------- 

	SET @Ret = 1  
	RETURN @Ret;
END
  
-------------------------------------------------------------------------------------------------------------------------
-- 복구 쿼리
/*
DROP PROC spWebChangeClanName_Netmarble
EXEC sp_rename 'BackUp_spWebChangeClanName_Netmarble', 'spWebChangeClanName_Netmarble';
*/
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebDeleteCharacterItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAdmWebDeleteCharacterItem]  
-- ALTER PROC dbo.spAdmWebDeleteCharacterItem
	@CID		INT
	, @CIID		INT
	, @ItemID	INT
	, @GMID		VARCHAR(20)  
	, @Ret		INT OUTPUT  
AS BEGIN

	SET NOCOUNT ON ;

	IF NOT EXISTS (SELECT CID FROM Character(NOLOCK) WHERE CID = @CID) BEGIN  
		SET @Ret = 0;
		RETURN @Ret;
	END  

	-- »èÁ¦ÇÏ·Á´Â ¾ÆÀÌÅÛÀ» Âø¿ëÇÏ°í ÀÖ´Ù¸é ¸ÕÀú ÇØÁ¦½ÃÃÄ¾ß ÇÔ.
	
	BEGIN TRAN -------------- 
		
		UPDATE	CharacterEquipmentSlot
		SET		CIID = NULL, ItemID = NULL
		WHERE	CID = @CID
		AND		CIID = @CIID;
		
		IF (0 <> @@ERROR) BEGIN
			ROLLBACK TRAN  
			SET @Ret = 0  
			RETURN @Ret
		END  
				
		UPDATE	CharacterItem 
		SET		CID = NULL
		WHERE	CIID = @CIID 
		AND		CID = @CID 
		AND		ItemID = @ItemID	
		
		IF (0 <> @@ERROR) BEGIN
			ROLLBACK TRAN  
			SET @Ret = 0  
			RETURN @Ret
		END  
		
	COMMIT TRAN -------------  

	SET @Ret = 1  
	RETURN @Ret
END  
-------------------------------------------------------------------------------------------------------------------------
-- º¹±¸ Äõ¸®
/*
DROP PROC spAdmWebDeleteCharacterItem
EXEC sp_rename 'BackUp_spAdmWebDeleteCharacterItem', 'spAdmWebDeleteCharacterItem';
*/
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebDeleteClanByCID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebDeleteClanByCID]  
 @MasterCID int /* 마스터 CID */  
AS  
 SET NOCOUNT ON
 DECLARE @CLID int  
  
 SELECT @CLID = c.CLID  
 FROM Clan c(NOLOCK)  
 WHERE c.MasterCID = @MasterCID  
  
 -- 요청 조건 검사.  
 IF (@MasterCID IS NULL) OR (@CLID IS NULL) BEGIN  
  SELECT 0 AS Ret  
  ROLLBACK TRAN  
  RETURN  
 END  

 BEGIN TRAN    
 -- Clan Member 삭제.  
 DELETE ClanMember WHERE CLID = @CLID  
 IF 0  <> @@ERROR BEGIN  
  SELECT 0 AS Ret  
  ROLLBACK TRAN  
  RETURN  
 END  
  
 -- Clan을 유효하지 않은 상태로 설정.  
 UPDATE Clan SET DeleteFlag = 1, MasterCID = NULL WHERE CLID = @CLID  
 UPDATE Clan SET DeleteName = Name WHERE CLID = @CLID  
 UPDATE Clan SET Name = NULL WHERE CLID = @CLID  
 COMMIT TRAN  
 
 SELECT 1 AS Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebDeleteCustomIP]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebDeleteCustomIP]
 @IPFrom varchar(15)
, @IPTo varchar(15)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON
 DECLARE @TmpIPFrom BIGINT
 DECLARE @TmpIPTo BIGINT
 
 SET @TmpIPFrom = GunzDB.dbo.inet_aton( @IPFrom )
 SET @TmpIPTo = GunzDB.dbo.inet_aton( @IPTo )
 IF @TmpIPFrom > @TmpIPTo BEGIN
  SET @Ret = 0
  RETURN @Ret
 END
 
 DELETE CustomIP WHERE IPFrom = @TmpIPFrom AND IPTo = @TmpIPTo
 IF 0 <> @@ERROR SET @Ret = 0
 ELSE SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebDeleteOneCashSetItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebDeleteOneCashSetItem]
 @CSSID int
, @CSID int
, @Ret int OUTPUT
AS 
 SET NOCOUNT ON
 DELETE CashSetItem WHERE CSSID = @CSSID AND CSID = @CSID
 IF (0 <> @@ERROR) BEGIN
  SET @Ret = 0
  RETURN @Ret
 END
 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebDeleteRentCashSetShopPrice]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-----------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebDeleteRentCashSetShopPrice]
 @RCSSPID int
, @CSSID int
, @Ret int OUTPUT
AS
 SET NOCOUNT ON
 DELETE RentCashSetShopPrice WHERE RCSSPID = @RCSSPID AND CSSID = @CSSID
 IF 0 <> @@ERROR BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebDeleteRentCashShopPrice]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebDeleteRentCashShopPrice]
 @RCSPID int
, @CSID int
, @Ret int OUTPUT
AS
 SET NOCOUNT ON
 DELETE RentCashShopPrice WHERE RCSPID = @RCSPID AND CSID = @CSID
 IF 0 <> @@ERROR BEGIN
  SET @Ret = 0
  RETURN @Ret
 END
 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebEditCharBP]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebEditCharBP]
 @CID int
, @BP int
, @GMID varchar(20)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON
 UPDATE Character SET BP = @BP WHERE CID = @CID
 IF 0 = @@ROWCOUNT BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebEditCharKillDeathCount]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebEditCharKillDeathCount]
 @CID int
, @KillCount int
, @DeathCount int
, @GMID varchar(20)
, @Ret int OUTPUT
AS
 IF (0 > @KillCount) OR (0 > @DeathCount) BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 UPDATE Character SET KillCount = @KillCount, DeathCount = @DeathCount
 WHERE CID = @CID
 IF 0 = @@ROWCOUNT BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebEditCharLevel]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAdmWebEditCharLevel]
 @CID int
, @Level smallint
, @GMID varchar(20)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON

 IF 1 > @Level  BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 IF EXISTS (SELECT CID FROM Character(NOLOCK) 
  WHERE CID = @CID AND Level = @Level) BEGIN
  SET @Ret = 1
  RETURN @Ret
 END

 DECLARE @XP int

 SELECT @XP = MinXP FROM Level(NOLOCK) WHERE Level = @Level
 IF @XP IS NULL BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 UPDATE Character SET Level = @Level, XP = @XP 
 WHERE CID = @CID AND DeleteFlag <> 1
 IF 0 = @@ROWCOUNT BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebEditCharPlayTime]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebEditCharPlayTime]
 @CID int
, @PlayTime int
, @GMID varchar(20)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON 
 IF (0 > @PlayTime) BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 UPDATE Character SET PlayTime = @PlayTime WHERE CID = @CID
 IF 0 = @@ROWCOUNT BEGIN 
  SET @Ret = 0
  RETURN @Ret
 END
	
 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebEditCharXP]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebEditCharXP]
 @CID int
, @XP int
, @GMID varchar(20)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON

 IF 0 > @XP BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 DECLARE @MaxMinXP int
 DECLARE @Level smallint

 SELECT TOP 1 @MaxMinXP = MinXP FROM Level(NOLOCK) 
 ORDER BY MinXP DESC

 IF @MaxMinXP > @XP BEGIN
  SELECT TOP 1 @Level = Level FROM Level(NOLOCK) 
  WHERE MinXP <= @XP ORDER BY Level DESC
 END
 ELSE BEGIN
  SELECT TOP 1 @Level = Level FROM Level(NOLOCK) 
  ORDER BY Level DESC
 END

 UPDATE Character SET Level = @Level, XP = @XP 
 WHERE CID = @CID AND DeleteFlag <> 1
 IF 0 = @@ROWCOUNT BEGIN 
  SET @Ret = 0
  RETURN @Ret
 END
 
 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetAccountInfoByAID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------

-- 계정정보 조회  프로시져
CREATE PROC [dbo].[spAdmWebGetAccountInfoByAID]  
	@AID int
AS  
 	SET NOCOUNT ON  
  
 	SELECT AID, UserID, Name, Age, Sex, UGradeID, RegDate  
 	FROM Account(NOLOCK)  
 	WHERE AID = @AID
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetAccountInfoByCharName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAdmWebGetAccountInfoByCharName]
	@CharName varchar( 24 )
AS
	SET NOCOUNT ON

	SELECT a.AID, a.UserID, a.UGradeID, a.RegDate, a.Name, a.Age, a.Sex
	FROM Character c(NOLOCK) JOIN Account a(NOLOCK)
	ON c.Name = @CharName AND a.AID = c.AID
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetAccountInfoByUserID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAdmWebGetAccountInfoByUserID]
	@UserID varchar( 20 )
AS
	SET NOCOUNT ON

	SELECT AID, UserID, Name, Age, Sex, UGradeID, RegDate
	FROM Account(NOLOCK)
	WHERE UserID = @UserID
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetAccountJoinStatistics]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-----------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetAccountJoinStatistics]
 @StartDate smalldatetime
, @EndDate smalldatetime
AS
 SET NOCOUNT ON 

 SELECT  convert(char(10), RegDate, 120) as Date ,count(AID) as Count
 FROM Account(nolock)  
 WHERE RegDate between convert(datetime, @StartDate) and convert(datetime, @EndDate)
 GROUP BY convert(char(10), RegDate, 120)
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetAllCharInfoByAID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------

-- 캐릭터 정보 조회  프로시져 (삭제된 캐릭터 포함)
CREATE PROC [dbo].[spAdmWebGetAllCharInfoByAID]  
 @AID int  
AS  
 SET NOCOUNT ON  
  
 SELECT c.Name, c.AID, c.CID, c.RegDate, c.PlayTime, c.LastTime
  , c.Sex, c.CharNum, c.Level, c.XP, c.BP, c.KillCount, c.DeathCount
  , c.DeleteFlag, c.DeleteName  
 FROM Account a(NOLOCK) JOIN Character c(NOLOCK)  
 ON a.AID = @AID AND c.AID = a.AID
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetAllCharInfoByCharName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetAllCharInfoByCharName]
 @CharName varchar( 24 )
AS
 SET NOCOUNT ON
 
 SELECT Name, AID, CID, RegDate, PlayTime, LastTime, Sex,
  CharNum, Level, XP, BP, DeleteFlag, DeleteName, 
  KillCount, DeathCount
 FROM Character(NOLOCK)
 WHERE Name = @CharName
 ORDER BY DeleteFlag, CharNum
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetAllCharInfoByOneCharName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetAllCharInfoByOneCharName]
 @CharName varchar(24)
AS
 SET NOCOUNT ON 

 SELECT c2.Name, c2.CID
 FROM (Character c1(NOLOCK) JOIN Account a(NOLOCK)
 ON c1.Name = @CharName AND a.AID = c1.AID) JOIN Character c2(NOLOCK)
 ON c2.AID = a.AID
 ORDER BY c2.DeleteFlag, c2.CharNum
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetAllCharInfoByUserID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetAllCharInfoByUserID]
 @UserID varchar( 20 )
AS
 SET NOCOUNT ON

 SELECT c.Name, c.AID, c.CID, c.RegDate, c.PlayTime, c.LastTime, 
  c.Sex, c.CharNum, c.Level, c.XP, c.BP, c.DeleteFlag, 
  c.DeleteName, c.KillCount, c.DeathCount
 FROM Account a(NOLOCK) JOIN Character c(NOLOCK)
 ON a.UserID = @UserID AND c.AID = a.AID
 ORDER BY c.DeleteFlag, c.CharNum
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetAllCharNameCIDByUserID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetAllCharNameCIDByUserID]
	@UserID varchar(20)
AS
	SET NOCOUNT ON

	SELECT c.Name, c.CID, c.DeleteFlag
	FROM Account a(NOLOCK) JOIN Character c(NOLOCK)
	ON a.UserID = @UserID AND c.AID = a.AID
	ORDER BY c.DeleteFlag, c.CharNum
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetAllSimpleCharInfoByOneCharName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetAllSimpleCharInfoByOneCharName]
 @CharName varchar( 24 )
AS
 SET NOCOUNT ON

 SELECT c2.Name, c2.CID
 FROM (Character c1(NOLOCK) JOIN Account a(NOLOCK)
 ON c1.Name = 'sunge_se' AND a.AID = c1.AID) JOIN Character c2(NOLOCK)
 ON c2.AID = a.AID
 ORDER BY c2.DeleteFlag, c2.CharNum
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetBlockCountryCodeList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetBlockCountryCodeList]
 @Code char
AS
 SET NOCOUNT ON

 SELECT bcc.CountryCode3, bcc.RoutingURL, bcc.IsBlock, cc.CountryName
 FROM BlockCountryCode bcc(NOLOCK) JOIN CountryCode cc(NOLOCK)
 ON cc.CountryCode3 = bcc.CountryCode3
 WHERE cc.CountryName LIKE @Code + '%'
 ORDER BY CountryName ASC
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetBountyItemPurchaseLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetBountyItemPurchaseLog]
 @CID int
, @ItemID int
AS
 SET NOCOUNT ON

 SELECT ipl.id AS ID, c.Name AS CharName, ipl.ItemID, i.Name, c.CID, 
  0 AS CIID, ipl.Bounty, ipl.CharBounty, i.Slot, ipl.Type, ipl.Date
 FROM (Character c(NOLOCK) JOIN ItemPurchaseLogByBounty ipl(NOLOCK)
 ON c.CID = @CID AND ipl.CID = c.CID) JOIN Item i(NOLOCK)
 ON i.ItemID = ipl.ItemID
 WHERE ipl.ItemID = @ItemID
 ORDER BY ipl.id DESC
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetBountyItemPurchaseLogByCharName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetBountyItemPurchaseLogByCharName]  
 @CharName varchar( 24 )  
AS  
 SET NOCOUNT ON  
  
 SELECT ipl.id AS ID, ipl.ItemID, i.Name, c.CID, 0 AS CIID, ipl.Bounty,    
  ipl.CharBounty, i.Slot, ipl.type, ipl.Date  
 FROM (Character c(NOLOCK) JOIN ItemPurchaseLogByBounty ipl(NOLOCK)  
 ON c.Name = @CharName AND ipl.CID = c.CID) JOIN Item i(NOLOCK)  
 ON i.ItemID = ipl.ItemID  
 ORDER BY ipl.Date DESC
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetCaracterMakingLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetCaracterMakingLog]  
 @CharName varchar(24)  
AS  
 SET NOCOUNT ON  
 SELECT a.UserID, cml.AID,  cml.CharName, cml.Type, cml.Date  
 FROM Account a(nolock), CharacterMakingLog cml(nolock)   
 WHERE cml.CharName = @CharName AND a.AID = cml.AID   
 ORDER BY cml.Date DESC
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetCashItemPresentRecvLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetCashItemPresentRecvLog]
 @AID int  
AS  
 SET NOCOUNT ON  
 SELECT cpl.id, cpl.SenderUserID, a.UserID AS ReceiverUserID
  , i.Name AS ItemName, cpl.Date, cpl.Cash  
  , CASE ISNULL(cpl.RentHourPeriod, 0)
   WHEN 0 THEN '0'
   ELSE CAST(cpl.RentHourPeriod AS varchar(10))
   END AS 'RentHourPeriod'
 FROM ((Account a(NOLOCK) JOIN CashItemPresentLog cpl(NOLOCK)  
 ON a.AID = @AID AND cpl.ReceiverAID = a.AID) JOIN CashShop cs(NOLOCK)  
 ON cs.CSID = cpl.CSID) JOIN Item i(NOLOCK)  
 ON i.ItemID = cs.ItemID  
 ORDER BY cpl.Date DESC
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetCashItemPresentSendLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetCashItemPresentSendLog]
 @AID int  
AS  
 SET NOCOUNT ON   
 SELECT cpl.id, cpl.SenderUserID, ar.UserID AS ReceiverUserID
  , i.Name AS ItemName, cpl.Date, cpl.Cash  
  , CASE ISNULL(cpl.RentHourPeriod, 0)
    WHEN 0 THEN '0'
    ELSE CAST(cpl.RentHourPeriod AS varchar(10))
   END AS 'RentHourPeriod'
 FROM (((Account a(NOLOCK) JOIN CashItemPresentLog cpl(NOLOCK)  
 ON a.AID = @AID AND cpl.SenderUserID = a.UserID) JOIN CashShop cs(NOLOCK)  
 ON cs.CSID = cpl.CSID) JOIN Item i(NOLOCK)  
 ON i.ItemID = cs.ItemID) JOIN Account ar(NOLOCK)   
 ON ar.AID = cpl.ReceiverAID  
 ORDER BY cpl.Date DESC
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetCashSetItemPresentRecvLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetCashSetItemPresentRecvLog]  
 @AID int  
AS  
 SET NOCOUNT ON  
 SELECT cpl.id, cpl.SenderUserID, a.UserID AS ReceiverUserID
  , css.Name AS ItemName, cpl.Date, cpl.Cash
  , CASE ISNULL(cpl.RentHourPeriod, 0)
    WHEN 0 THEN '0'
    ELSE CAST(cpl.RentHourPeriod AS varchar(10))
   END AS 'RentHourPeriod'
 FROM (Account a(NOLOCK) JOIN CashItemPresentLog cpl(NOLOCK)  
 ON a.AID = @AID AND cpl.ReceiverAID = a.AID) JOIN CashSetShop css(NOLOCK)  
 ON css.CSSID = cpl.CSSID  
 ORDER BY cpl.Date DESC
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetCashSetItemPresentSendLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------
CREATE PROC [dbo].[spAdmWebGetCashSetItemPresentSendLog]  
 @AID int  
AS  
 SET NOCOUNT ON   
 SELECT cpl.id, cpl.SenderUserID, a.UserID AS ReceiverUserID
  , css.Name AS SetItemName
  , cpl.Date, cpl.Cash  
  , CASE ISNULL(cpl.RentHourPeriod, 0)
    WHEN 0 THEN '0'
    ELSE CAST(cpl.RentHourPeriod AS varchar(10)) 
   END AS 'RentHourPeriod' 
 FROM (Account a(NOLOCK) JOIN CashItemPresentLog cpl(NOLOCK)  
 ON a.AID = @AID AND cpl.SenderUserID = a.UserID) JOIN CashSetShop css(NOLOCK)  
 ON css.CSSID = cpl.CSSID  
 ORDER BY cpl.Date DESC
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetCashSetShopList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetCashSetShopList]
AS
 SET NOCOUNT ON
 SELECT CSSID, Name
 FROM CashSetShop(NOLOCK)
 ORDER BY CSSID
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetCashShopList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetCashShopList]
AS
 SET NOCOUNT ON
  SELECT cs.CSID, i.Name, i.Slot, cs.Opened, cs.NewItemOrder,
  cs.CashPrice, cs.WebImgName, ISNULL(cs.RentType, 0) AS 'RentType'
 FROM CashShop cs(NOLOCK) JOIN Item i(NOLOCK)
 ON i.ItemID = cs.ItemID
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetCharInfoByUserID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetCharInfoByUserID]  
 @UserID varchar(20)  
AS  
 SET NOCOUNT ON  
  
 SELECT c.Name, c.AID, c.CID, c.RegDate, c.PlayTime, c.LastTime,c.Sex,  
  c.CharNum, c.Level, c.XP, c.BP, c.DeleteFlag, c.DeleteName,  
  c.KillCount, c.DeathCount  
 FROM Account a(NOLOCK) JOIN Character c(NOLOCK)  
 ON a.UserID = @UserID AND c.AID = a.AID  
 ORDER BY DeleteFlag, CharNum
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetCharItemByCID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetCharItemByCID]
	@CID int
AS
BEGIN
	SET NOCOUNT ON

	SELECT ci.ItemID, i.Name, ci.CIID, ci.RegDate AS RegDate,  
		CASE 
		WHEN ci.RentHourPeriod IS NOT NULL THEN (RentHourPeriod) - (DateDiff(hh, RentDate, GETDATE()))
		WHEN ci.RentHourPeriod IS NULL THEN -1
		ELSE -2 -- error.
		END AS RentPeriodRemainderHour,
		CASE ci.CIID 
		WHEN c.head_slot THEN 'Head'
		WHEN c.chest_slot THEN 'Chest'
		WHEN c.hands_slot THEN 'Hands'
		WHEN c.legs_slot THEN 'Legs'
		WHEN c.feet_slot THEN 'Feet'
		WHEN c.fingerl_slot THEN 'Left finger'
		WHEN c.fingerr_slot THEN 'Right finger'
		WHEN c.melee_slot THEN 'Melee'
		WHEN c.primary_slot THEN 'Primary'
		WHEN c.secondary_slot THEN 'Secondary'
		WHEN c.custom1_slot THEN 'Custom1'
		WHEN c.custom2_slot THEN 'Custom2'
		ELSE 'Free item'
		END AS KeepOnPosition,
		CASE ci.CIID
		WHEN c.head_slot THEN 11
		WHEN c.chest_slot THEN 12
		WHEN c.hands_slot THEN 13
		WHEN c.legs_slot THEN 14
		WHEN c.feet_slot THEN 15
		WHEN c.fingerl_slot THEN 16
		WHEN c.fingerr_slot THEN 17
		WHEN c.melee_slot THEN 18
		WHEN c.primary_slot THEN 19
		WHEN c.secondary_slot THEN 20
		WHEN c.custom1_slot THEN 21
		WHEN c.custom2_slot THEN 22
		ELSE 23
		END AS Orders
	FROM (Character c(NOLOCK) JOIN CharacterItem ci(NOLOCK)
	ON c.CID = @CID AND ci.CID = c.CID) JOIN Item i(NOLOCK)
	ON i.ItemID = ci.ItemID
	ORDER BY Orders 
END
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetCharLogByCharName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetCharLogByCharName]
 @CharName varchar(24)
AS
 SET NOCOUNT ON

 SELECT a.UserID, cml.CharName, cml.Type, cml.Date
 FROM CharacterMakingLog cml(NOLOCK) JOIN Account a(NOLOCK)
 ON cml.CharName = @CharName AND a.AID = cml.AID
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetCharQuestItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetCharQuestItem]
	@CharName varchar( 24 )
AS	
BEGIN
	SET NOCOUNT ON

	SELECT QuestItemInfo
	FROM Character( NOLOCK )
	WHERE Name = @CharName
END
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetCharQuestItemInfoByCID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetCharQuestItemInfoByCID]
	@CID int
AS
	SET NOCOUNT ON

	SELECT QuestItemInfo FROM Character(NOLOCK) WHERE CID = @CID
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetClanInfoByCharName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetClanInfoByCharName]
 @CharName varchar(24)
AS
 SET NOCOUNT ON

 DECLARE @CLID int

 SELECT @CLID = cm.CLID
 FROM Character c(NOLOCK) JOIN ClanMember cm(NOLOCK)
 ON c.Name = @CharName AND cm.CID = c.CID
 IF @CLID IS NULL RETURN

 SELECT cl.CLID, cl.Name, c.Name AS 'MastName', cl.Introduction, cl.RegDate, cl.HomePage, cl.EmblemURL, cl.DeleteFlag
 FROM Clan cl(NOLOCK) JOIN Character c(NOLOCK)
 ON cl.CLID = @CLID AND cl.MasterCID = c.CID
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetClanInfoByClanName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetClanInfoByClanName]
 @ClanName varchar(24)
AS
 SET NOCOUNT ON

 SELECT cl.CLID, cl.Name, c.Name AS 'MastName', cl.Introduction, 
  cl.RegDate, cl.HomePage, cl.EmblemURL, cl.DeleteFlag
 FROM Clan cl(NOLOCK) JOIN Character c(NOLOCK)
 ON cl.Name = @ClanName AND cl.MasterCID = c.CID
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetClanMemberInfoByCLID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetClanMemberInfoByCLID]
 @CLID int
AS
 SET NOCOUNT ON 

 SELECT cm.CLID, cm.Grade, a.AID, a.UserID, c.Name, cm.CID, c.Level, 
  cm.ContPoint, cm.RegDate
 FROM (ClanMember cm(NOLOCK) JOIN Character c(NOLOCK)
 ON cm.CLID = @CLID AND c.CID = cm.CID) JOIN Account a( NOLOCK)
 ON a.AID = c.AID
 WHERE c.DeleteFlag <> 1
 ORDER BY cm.Grade, cm.RegDate
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetClanRankInfoByCLID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetClanRankInfoByCLID]  
 @CLID int   
AS  
 SELECT Exp, Point, TotalPoint, Wins, Losses, Ranking, LastDayRanking, LastMonthRanking, RankIncrease  
 FROM Clan(NOLOCK)  
 WHERE CLID = @CLID
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetClanRanknfoByCLID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetClanRanknfoByCLID]
 @CLID int 
AS
 SET NOCOUNT ON

 SELECT Exp, Point, TotalPoint, Wins, Losses, Ranking, LastDayRanking, 
  LastMonthRanking, RankIncrease
 FROM Clan(NOLOCK)
 WHERE CLID = @CLID
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetConnectLogInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAdmWebGetConnectLogInfo]  
 @AID int  
, @IP nvarchar(16)  
, @StartDate smalldatetime  
, @EndDate smalldatetime  
AS   
 SET NOCOUNT ON  
  
 DECLARE @LogTable varchar(32)  
 DECLARE @LogTablePrev varchar(32)  
 DECLARE @SQL nvarchar(4000)  
 DECLARE @Where nvarchar(1024)  
 DECLARE @SqlPrmDef nvarchar(1024)  
 DECLARE @Order nvarchar(21)  
  
-- 시작날짜의 달과 끝날짜의 달이 다를경우 ConnLog와 ConnLog_xxxxxx테이블에서 조회후 Union  
 IF CONVERT(char(7), @StartDate, 102) <> CONVERT(char(7), @EndDate, 102) BEGIN  
    SET @LogTable = 'LogDB.dbo.ConnLog'   
    SET @LogTablePrev = 'LogDB.dbo.ConnLog_' + CAST(DATEPART(yy, @StartDate) as varchar(4))   
   + REPLACE(str(CAST(DATEPART(mm, @StartDate) as varchar(2)),2), ' ', 0)  
 END  
  
-- 시작날짜의 달과 현재날짜의 달이 다를경우 지난달 로그기록 테이블에서 조회 (ConnLog_xxxxxx)  
-- 그 외의 경우는 ConnLog 테이블에서 조회  
 ELSE  IF CONVERT(char(7), @StartDate, 102) <> CONVERT(char(7), GETDATE(), 102) BEGIN  
  SET @LogTable = 'LogDB.dbo.ConnLog_' + CAST(DATEPART(yy, @StartDate) as varchar(4))   
   + REPLACE(str(CAST(DATEPART(mm, @EndDate) as varchar(2)),2), ' ', 0)  
 END  
 ELSE BEGIN  
  SET @LogTable = 'LogDB.dbo.ConnLog'  
 END   
  
 IF NOT EXISTS (SELECT * FROM LogDB.INFORMATION_SCHEMA.TABLES   
  WHERE TABLE_NAME = SUBSTRING(@LogTable, 11, 14) AND TABLE_TYPE = 'BASE TABLE')   
  RETURN  
  
 SET @LogTable = @LogTable + ' as cl'   
  
  
IF (@LogTablePrev  IS NOT NULL) BEGIN  
   IF NOT EXISTS (SELECT * FROM LogDB.INFORMATION_SCHEMA.TABLES   
        WHERE TABLE_NAME = SUBSTRING(@LogTablePrev, 11, 14) AND TABLE_TYPE = 'BASE TABLE')   
   RETURN  
   SET @LogTablePrev = @LogTablePrev + ' as cl'   
END  
   
  
 SET @SQL = 'SELECT cl.AID, a.UserID, CAST(cl.IPPart1 as varchar(3)) + ' + '''' + '.' + ''''   
  + ' + CAST(cl.IPPart2 as varchar(3)) + ' + '''' + '.' + ''''  
  + ' + CAST(cl.IPPart3 as varchar(3)) + ' + '''' + '.' + ''''  
  + ' + CAST(cl.IPPart4 as varchar(3)) as AccessIP , cl.Time as ' + '''' + 'ConnectionTime' + ''''   
  + ' FROM ' + @LogTable + ', TestDB.dbo.Account a(NOLOCK) '   
  
 SET @Order = 'ORDER BY cl.Time DESC'  
 SET @IP = @IP + '%'  
  
 IF (@AID IS NOT NULL) AND (@IP IS NOT NULL) BEGIN  
  SELECT '1'  
  SET @Where = 'WHERE cl.AID = @AID AND a.AID = cl.AID AND CAST(cl.IPPart1 as nvarchar(3)) + ' + '''' + '.' + ''''   
  + ' + CAST(cl.IPPart2 as nvarchar(3)) + ' + '''' + '.' + ''''  
  + ' + CAST(cl.IPPart3 as nvarchar(3)) + ' + '''' + '.' + ''''  
  + ' + CAST(cl.IPPart4 as nvarchar(3)) LIKE ' + '''' + @IP + ''''   
  + ' AND cl.Time >= @StartDate AND cl.Time <= @EndDate '   
  SET @SqlPrmDef = '@AID int, @IP nvarchar(16), @StartDate smalldatetime, @EndDate smalldatetime'  
  SET @SQL = @SQL + @Where  
 END  
 ELSE IF(@AID IS NOT NULL) AND (@IP IS NULL) BEGIN  
  SELECT '2'  
  SET @Where = 'WHERE cl.AID = @AID AND a.AID = cl.AID AND  cl.Time >= @StartDate AND cl.Time <= @EndDate '  
  SET @SqlPrmDef = '@AID int, @StartDate smalldatetime, @EndDate smalldatetime'  
  SET @SQL = @SQL + @Where   
 END  
 ELSE IF(@AID IS NULL) AND (@IP IS NOT NULL) BEGIN  
  SELECT '3'  
  SET @Where = 'WHERE (CAST(cl.IPPart1 as nvarchar(3)) + ' + '''' + '.' + ''''   
  + ' + CAST(cl.IPPart2 as nvarchar(3)) + ' + '''' + '.' + ''''  
  + ' + CAST(cl.IPPart3 as nvarchar(3)) + ' + '''' + '.' + ''''  
  + ' + CAST(cl.IPPart4 as nvarchar(3))) LIKE ' + '''' + @IP + ''''   
  + ' AND a.AID = cl.AID  AND cl.Time >= @StartDate AND cl.Time <= @EndDate '   
  SET @SqlPrmDef = '@IP nvarchar(16), @StartDate smalldatetime, @EndDate smalldatetime'  
  SET @SQL = @SQL + @Where   
 END  
  
IF (@LogTablePrev IS NOT NULL) BEGIN  
   SET @SQL = @SQL + ' UNION ALL ' + REPLACE(@SQL, 'LogDB.dbo.ConnLog as cl', @LogTablePrev)  
END  
  
SET @SQL = @SQL + @Order  
  
EXEC sp_executesql @SQL, @SqlPrmDef, @IP, @StartDate, @EndDate
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetCustomIP]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetCustomIP]
 @RegDateFrom smalldatetime
, @RegDateTo smalldatetime
AS
 SET NOCOUNT ON
 DECLARE @TmpIP bigint

 SET @RegDateTo = DATEADD( dd, 1, @RegDateTo )

 SELECT GunzDB.dbo.inet_ntoa(IPFrom) AS IPFrom, GunzDB.dbo.inet_ntoa(IPTo) AS IPTo, 
  CountryCode3, Comment, IsBlock, RegDate
 FROM CustomIP(NOLOCK)
 WHERE RegDate >= @RegDateFrom AND RegDate <= @RegDateTo
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetCustomIPByIP]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetCustomIPByIP]
 @IP varchar(15)
, @RegDateFrom smalldatetime
, @RegDateTo smalldatetime
AS
 SET NOCOUNT ON
 DECLARE @TmpIP bigint

 SET @TmpIP = TestDB.dbo.inet_aton( @IP )
 SET @RegDateTo = DATEADD( dd, 1, @RegDateTo )

 SELECT GunzDB.dbo.inet_ntoa(IPFrom) AS IPFrom, GunzDB.dbo.inet_ntoa(IPTo) AS IPTo, 
  CountryCode3, Comment, IsBlock, RegDate
 FROM CustomIP(NOLOCK)
 WHERE RegDate >= @RegDateFrom AND RegDate <= @RegDateTo AND
  IPFrom <= @TmpIP AND IPTo >= @TmpIP
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetItemList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAdmWebGetItemList]
AS
 SET NOCOUNT ON
 SELECT ItemID, Name, Slot, IsCashItem
 FROM Item(NOLOCK)
 ORDER BY ItemID
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetItemPurchaseLogByCash]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetItemPurchaseLogByCash]
 @AID int  
AS  
 SET NOCOUNT ON  
 SELECT ipl.id, a.UserID AS SenderUserID, a.UserID AS ReceiverUserID, 
  i.Name AS ItemName, ipl.Date, ipl.Cash
  , CASE ISNULL(ipl.RentHourPeriod, 0) 
   WHEN 0 THEN '0'
   ELSE CAST(ipl.RentHourPeriod AS varchar(10)) 
   END AS 'RentHourPeriod'
 FROM (Account a(NOLOCK) JOIN ItemPurchaseLogByCash ipl(NOLOCK)  
 ON a.AID = @AID AND ipl.AID = a.AID) JOIN Item i(NOLOCK)  
 ON i.ItemID = ipl.ItemID  
 ORDER BY ipl.Date DESC
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetLiveCharInfoByAID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------

-- 캐릭터 정보 조회  프로시져 (삭제된 캐릭터 제외)
CREATE PROC [dbo].[spAdmWebGetLiveCharInfoByAID]
 @AID int
AS
 SET NOCOUNT ON

 SELECT c.Name, c.AID, c.CID, c.RegDate, c.PlayTime, c.LastTime, 
  c.Sex, c.CharNum, c.Level, c.XP, c.BP, c.KillCount, c.DeathCount
 FROM Account a(NOLOCK) JOIN Character c(NOLOCK)
 ON a.AID = @AID AND c.AID = a.AID 
 WHERE c.DeleteFlag <> 1
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetLiveCharInfoByCharName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetLiveCharInfoByCharName]
 @CharName varchar( 24 )
AS 
 SET NOCOUNT ON

 SELECT Name, AID, CID, RegDate, PlayTime, LastTime, Sex, 
  CharNum, Level, XP, BP, KillCount, DeathCount
 FROM Character(NOLOCK)
 WHERE Name = @CharName AND DeleteFlag <> 1
 ORDER BY CharNum
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetLiveCharInfoByOneCharName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetLiveCharInfoByOneCharName]
 @CharName varchar(24)
AS
 SET NOCOUNT ON
 
 SELECT c2.Name, c2.CID
 FROM (Character c1(NOLOCK) JOIN Account a(NOLOCK)
 ON c1.Name = @CharName AND a.AID = c1.AID) JOIN Character c2(NOLOCK)
 ON c2.AID = a.AID
 WHERE c2.DeleteFlag <> 1
 ORDER BY c2.CharNum
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetLiveCharListByUserID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetLiveCharListByUserID]
	@UserID varchar( 20 )
AS 
	SET NOCOUNT ON

	SELECT c.Name, c.AID, c.CID, c.RegDate, c.PlayTime, c.LastTime, 
		c.Sex, c.CharNum, c.Level, c.XP, c.BP, c.KillCount, c.DeathCount
	FROM Account a(NOLOCK) JOIN Character c(NOLOCK)
	ON a.UserID = @UserID AND c.AID = a.AID
	WHERE c.DeleteFlag <> 1
	ORDER BY c.CharNum
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetLiveCharNameCIDByUserID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetLiveCharNameCIDByUserID]
	@UserID varchar(20)
AS
	SET NOCOUNT ON 

	SELECT c.Name, c.CID, c.DeleteFlag
	FROM Account a(NOLOCK) JOIN Character c(NOLOCK)
	ON a.UserID = @UserID AND c.AID = a.AID
	WHERE c.DeleteFlag <> 1
	ORDER BY c.DeleteFlag, c.CharNum
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetQuestItemInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetQuestItemInfo]
 @CID int
AS
 SET NOCOUNT ON 
 SELECT CID, Name, QuestItemInfo 
 FROM Character(NOLOCK)
 WHERE CID = @CID
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetRentPeriodDayList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
----------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetRentPeriodDayList]
AS
 SET NOCOUNT ON
 SELECT  Day FROM RentPeriodDay(NOLOCK) ORDER BY Day
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetSetItemPurchaseLogByCash]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetSetItemPurchaseLogByCash]  
 @AID int  
AS  
 SET NOCOUNT ON  
 SELECT sipl.id, a.UserID AS SenderUserID, a.UserID AS ReceiverUserID
  , css.Name AS ItemName, sipl.Date, sipl.Cash  
  , CASE ISNULL(sipl.RentHourPeriod, 0)
   WHEN 0 THEN '0'
   ELSE CAST(sipl.RentHourPeriod AS varchar(10))
  END AS 'RentHourPeriod'
 FROM (Account a(NOLOCK) JOIN SetItemPurchaseLogByCash sipl(NOLOCK)  
 ON a.AID = @AID AND sipl.AID = a.AID) JOIN CashSetShop css(NOLOCK)  
 ON css.CSSID = sipl.CSSID  
 ORDER BY Date DESC
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetSimpleLiveCharInfoByOneCharName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetSimpleLiveCharInfoByOneCharName]
	@CharName varchar( 24 )
AS
	SET NOCOUNT ON

	DECLARE @AID int
	
	SELECT @AID = a.AID
	FROM Character c(NOLOCK) JOIN Account a(NOLOCK)
	ON c.Name = @CharName AND a.AID = c.AID

	IF @AID IS NULL RETURN

	SELECT Name, CID FROM Character(NOLOCK) WHERE AID = @AID AND DeleteFlag <> 1
	ORDER BY CharNum
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebGetUniqueQuestItemInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-----------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebGetUniqueQuestItemInfo]
 @CID int
AS
 SET NOCOUNT ON 

 SELECT qi.Name, qgl.StartTime, qgl.EndTime
 FROM QuestGameLog qgl(NOLOCK), QUniqueItemLog qul(NOLOCK), QuestItem qi(NOLOCK)
 WHERE qgl.ID = qul.QGLID AND qul.QIID = qi.QIID AND qul.CID = @CID
 ORDER BY qgl.StartTime DESC
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebInsertAccountItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAdmWebInsertAccountItem]
-- ALTER PROC dbo.spAdmWebInsertAccountItem
	@AID		INT
	, @ItemID	INT
	, @Period	INT
	, @GMID		VARCHAR(20)
	, @Ret		INT OUTPUT
AS BEGIN
	
	SET NOCOUNT ON;
	
	IF (500001 > @ItemID) OR ((@Period IS NOT NULL) AND (0 > @Period)) BEGIN
		SET @Ret = 0;
		RETURN @Ret;
	END  

	IF NOT EXISTS ( SELECT AID FROM Account(NOLOCK) WHERE AID = @AID ) BEGIN  
		SET @Ret = 0;
		RETURN @Ret;
	END  

	------------------------------------------------------------------------------------

	DECLARE @RentHourPeriod		INT;

	IF (0 = @Period) OR (@Period IS NULL)	SELECT @RentHourPeriod = 0;
	ELSE									SELECT @RentHourPeriod = @Period;

	INSERT INTO AccountItem( AID, ItemID, RentDate, RentHourPeriod, Cnt)  
	VALUES (@AID, @ItemID, GETDATE(), @RentHourPeriod, 1 )
	
	IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN  
		SET @Ret = 0;
		RETURN @Ret;
	END  
	
	------------------------------------------------------------------------------------
	
	SET @Ret = 1;
	RETURN @Ret;
END

-------------------------------------------------------------------------------------------------------------------------
-- º¹±¸ Äõ¸®
/*
DROP PROC spAdmWebInsertAccountItem
EXEC sp_rename 'BackUp_spAdmWebInsertAccountItem', 'spAdmWebInsertAccountItem';
*/
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebInsertBattleTimeRewardDescription]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAdmWebInsertBattleTimeRewardDescription]
-- ALTER PROC dbo.spAdmWebInsertBattleTimeRewardDescription
    @Name                   VARCHAR(128)
    , @StartDate            DATETIME
    , @EndDate              DATETIME
    , @StartHour            INT
    , @EndHour              INT
    , @RewardMinutePeriod   INT
    , @RewardCount          SMALLINT
    , @RewardKillCount      SMALLINT
    , @ResetCode            CHAR(7)
    , @ResetDesc            VARCHAR(128)
    , @IsOpen               TINYINT
AS BEGIN

    SET NOCOUNT ON;

    IF( @StartDate > @EndDate ) BEGIN
        SELECT -1 AS 'Ret';
        RETURN;
    END

    BEGIN TRAN -----------

        INSERT dbo.BattleTimeRewardDescription
            ([Name], StartDate, EndDate, StartHour, EndHour, RewardMinutePeriod, RewardCount, RewardKillCount, ResetCode, ResetDesc, IsOpen)
        VALUES(@Name, @StartDate, @EndDate, @StartHour, @EndHour, @RewardMinutePeriod, @RewardCount, @RewardKillCount, @ResetCode, @ResetDesc, @IsOpen);

        IF( @@ERROR <> 0 ) BEGIN
            ROLLBACK TRAN;
            SELECT -2 AS 'Ret';
            RETURN;
        END

        INSERT dbo.BattleTimeRewardTerm(BRID, LastResetDate)
        VALUES(@@IDENTITY, GETDATE());

        IF( @@ERROR <> 0 ) BEGIN
            ROLLBACK TRAN;
            SELECT -3 AS 'Ret';
            RETURN;
        END

    COMMIT TRAN ----------

    SELECT 0 AS 'Ret';
    
END
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebInsertBattleTimeRewardItemList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAdmWebInsertBattleTimeRewardItemList]
-- ALTER PROC dbo.spAdmWebInsertBattleTimeRewardItemList
    @BRID                   INT
    , @ItemIDMale           INT
    , @ItemIDFemale         INT
    , @RentHourPeriod       INT
    , @ItemCnt              INT
    , @RatePerThousand      INT
AS BEGIN

    SET NOCOUNT ON;

    INSERT dbo.BattleTimeRewardItemList(BRID, ItemIDMale, ItemIDFemale, RentHourPeriod, ItemCnt, RatePerThousand)
    VALUES (@BRID, @ItemIDMale, @ItemIDFemale, @RentHourPeriod, @ItemCnt, @RatePerThousand);
    
END
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebInsertCashSetShopItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAdmWebInsertCashSetShopItem]  
 @Name varchar(64)  
, @ResSex tinyint  
, @ResLevel int  
, @Weight int  
, @Description varchar(1024)  
, @Opened tinyint  
, @CashPrice int  
, @WebImgName varchar(64)  
, @RentType tinyint  
, @Ret int OUTPUT  
AS  
 SET NOCOUNT ON   
 IF (@Name IS NULL) OR (@ResSex IS NULL) OR (@ResLevel IS NULL)   
  OR (@Weight IS NULL) OR (@Description IS NULL) OR (@Opened IS NULL)  
  OR (@CashPrice IS NULL) OR (@WebImgName IS NULL) BEGIN  
  SET @Ret = 0  
  RETURN @Ret  
 END  
  
 declare @cssid int  
 select @cssid = max(cssid) + 1 from CashSetShop(nolock)  
  
 INSERT INTO CashSetShop(cssid, Name, ResSex, ResLevel, Weight, Description, Opened,  
  CashPrice, WebImgName, RentType, RegDate)  
 VALUES (@cssid, @Name, @ResSex, @ResLevel, @Weight, @Description, @Opened,  
  @CashPrice, @WebImgName, @RentType, GETDATE())  
 IF 0 <> @@ERROR BEGIN  
  SET @Ret = 0  
  RETURN @Ret  
 END  
  
 SET @Ret = @cssid  
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebInsertCashShopItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAdmWebInsertCashShopItem]    
 @ItemID int    
, @Opened tinyint    
, @CashPrice int    
, @WebImgName varchar(64)    
, @RentType tinyint    
, @Ret int OUTPUT    
AS    
 SET NOCOUNT ON    
 IF (@ItemID IS NULL) OR (500000 > @ItemID) OR (@Opened IS NULL)  
  OR (@CashPrice IS NULL) BEGIN    
  SET @Ret = 0    
  RETURN @Ret    
 END    
  
 declare @csid int  
  
 select @csid = max(csid) + 1 from CashShop(nolock)   
    
 INSERT INTO CashShop(csid,  ItemID, Opened, CashPrice, WebImgName, RegDate, RentType )    
 VALUES (@csid, @ItemID, @Opened, @CashPrice, @WebImgName, GETDATE(), @RentType)    
 IF 0 <> @@ERROR BEGIN    
  SET @Ret = 0    
  RETURN @Ret    
 END    
     
 SET @Ret = @csid  
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebInsertCharacterItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAdmWebInsertCharacterItem]  
-- ALTER PROC dbo.spAdmWebInsertCharacterItem  
	@CID		INT
	, @ItemID	INT
	, @Period	SMALLINT
	, @GMID		VARCHAR(20)  
	, @Ret		INT OUTPUT
AS BEGIN 

	-----------------------------------------------------------------------------	-----------
 
	IF (500000 < @ItemID) OR ((@Period IS NOT NULL) AND (0 > @Period)) BEGIN  
		SET @Ret = 0;
		RETURN @Ret;
	END  

	IF NOT EXISTS( SELECT CID FROM Character(NOLOCK) WHERE CID = @CID ) BEGIN  
		SET @Ret = 0;
		RETURN @Ret;
	END
	
	----------------------------------------------------------------------------------------

	DECLARE @RentHourPeriod SMALLINT;

	IF (0 = @Period) OR (@Period IS NULL) BEGIN
		SELECT @RentHourPeriod = 0;
	END
	ELSE BEGIN  
		SELECT @RentHourPeriod = @Period;
	END
	
	----------------------------------------------------------------------------------------

	INSERT INTO CharacterItem( CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt )
	VALUES (@CID, @ItemID, GETDATE(), GETDATE(), @RentHourPeriod, 1 )
	
	IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN
		SET @Ret = 0  
		RETURN @Ret
	END 

	----------------------------------------------------------------------------------------

	SET @Ret = 1  
	RETURN @Ret  
END 
-------------------------------------------------------------------------------------------------------------------------
-- º¹±¸ Äõ¸®
/*
DROP PROC spAdmWebInsertCharacterItem
EXEC sp_rename 'BackUp_spAdmWebInsertCharacterItem', 'spAdmWebInsertCharacterItem';
*/
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebInsertCustomIP]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------

/*
 * @Ret(0:Fail, 1:Success, 2:Duplicate, 3:Invers range)
 */
CREATE PROC [dbo].[spAdmWebInsertCustomIP]
 @IPFrom varchar(15)
, @IPTo varchar(15)
, @IsBlock tinyint
, @CountryCode3 char(3)
, @Comment varchar(128)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON
 DECLARE @DupRet int
 DECLARE @TmpIPFrom BIGINT
 DECLARE @TmpIPTo BIGINT

 SET @TmpIPFrom = GunzDB.dbo.inet_aton( @IPFrom )
 SET @TmpIPTo = GunzDB.dbo.inet_aton( @IPTo )
 IF @TmpIPFrom > @TmpIPTo BEGIN
  SET @Ret = 3
  RETURN @Ret
 END

 EXEC spIPFltCheckIsDuplicateRange @TmpIPFrom, @TmpIPTo, @DupRet OUTPUT
 IF 1 = @DupRet BEGIN
  SET @Ret = 2
  RETURN @Ret
 END 

 INSERT INTO CustomIP(IPFrom, IPTo, CountryCode3, IsBlock, Comment, RegDate)
 VALUES (@TmpIPFrom, @TmpIPTo, @CountryCode3, @IsBlock, @Comment, GETDATE() )
 IF 0 <> @@ERROR SET @Ret = 0
 ELSE SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebInsertOneCashSetItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
----------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebInsertOneCashSetItem]
 @CSSID int
, @CSID int
, @Ret int OUTPUT
AS
 SET NOCOUNT ON
 IF (@CSSID IS NULL) OR (@CSID IS NULL) BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 INSERT INTO CashSetItem(CSSID, CSID) VALUES (@CSSID, @CSID)
 IF 0 <> @@ERROR BEGIN
  SET @Ret = 0
  RETURN @Ret
 END
 
 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebInsertRentCashSetShopPrice]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebInsertRentCashSetShopPrice]  
 @CSSID int  
, @RentHourPeriod int  
, @CashPrice int  
, @Ret int OUTPUT  
AS  
 SET NOCOUNT ON  
 IF (@CSSID IS NULL) OR (@CashPrice IS NULL) BEGIN  
  SET @Ret = 0  
  RETURN @Ret  
 END  

 IF 0 = @RentHourPeriod SET @RentHourPeriod = NULL
  
 INSERT INTO RentCashSetShopPrice(CSSID, RentHourPeriod, CashPrice)  
 VALUES (@CSSID, @RentHourPeriod, @CashPrice)  
 IF 0 <> @@ERROR BEGIN  
  SET @Ret = 0  
  RETURN @Ret  
 END  
  
 SET @Ret = 1  
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebInsertRentCashShopPrice]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
---------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebInsertRentCashShopPrice]  
 @CSID int  
, @RentHourPeriod int  
, @CashPrice int  
, @Ret int OUTPUT  
AS  
 SET NOCOUNT ON  
  
 IF (@CSID IS NULL) OR (@CashPrice IS NULL) BEGIN  
  SET @Ret = 0  
  RETURN @Ret  
 END  

 IF 0 = @RentHourPeriod SET @RentHourPeriod = NULL
  
 INSERT INTO RentCashShopPrice(CSID, RentHourPeriod, CashPrice)  
 VALUES (@CSID, @RentHourPeriod, @CashPrice)  
 IF 0 <> @@ERROR BEGIN  
  SET @Ret = 0  
  RETURN @Ret  
 END  
 SET @Ret = 1  
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebInsertSetItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAdmWebInsertSetItem]
-- ALTER PROC dbo.spAdmWebInsertSetItem
	@UserID				VARCHAR(20)  
	, @CSSID			INT
	, @RentHourPeriod	SMALLINT
	, @GMID				VARCHAR(20)
	, @Ret				INT OUTPUT
AS BEGIN

	SET NOCOUNT ON;

	DECLARE @AID INT;
	SELECT @AID = AID FROM Account WHERE UserID = @UserID;

	-- Á¸Á¦ÇÏ´Â À¯ÀúÀÎÁö °Ë»ç.    
	IF @AID IS NULL BEGIN    
		SET @Ret = 0;
		RETURN @Ret;
	END    
	ELSE BEGIN
	
		DECLARE @RentDate  DATETIME;

		-- @RentHourPeriod°ªÀ» °¡Áö°í ±â°£Á¦ÀÎÁö °Ë»ç.    
		IF @RentHourPeriod = 0 OR @RentHourPeriod IS NULL BEGIN
		
			-- ±â°£Á¦ ¾ÆÀÌÅÛÀÏ °æ¿ì ¿µ±¸ ¾ÆÀÌÅÛ ÆÇ¸Å ¿©ºÎ °Ë»ç    
			DECLARE @RentType	TINYINT
			DECLARE @RCSSPID	INT

			SELECT @RentType = RentType FROM CashSetShop(NOLOCK) WHERE CSSID = @CSSID;
			
			IF @RentType = 1 BEGIN    
				SELECT	@RCSSPID = RCSSPID 
				FROM	RentCashSetShopPrice 
				WHERE	CSSID = @CSSID 
				AND		RentHourPeriod IS NULL
				
				IF (@RCSSPID IS NULL) BEGIN    
					SET @Ret = 0;
					RETURN @Ret;
				END    
			END    

			-- ÀÏ¹Ý ¾ÆÀÌÅÛÀÏ °æ¿ì
			SET @RentDate = NULL;
		END    
		ELSE BEGIN    
			SET @RentDate = GETDATE()    
		END


		BEGIN TRAN -------------------    

			DECLARE curBuyCashSetItem  INSENSITIVE CURSOR 
			FOR    
				SELECT	CSID 
				FROM	CashSetItem(NOLOCK) 
				WHERE	CSSID = @CSSID    
			FOR READ ONLY    


			OPEN curBuyCashSetItem     

			DECLARE @varCSID  INT
			DECLARE @ItemID   INT

			FETCH FROM curBuyCashSetItem INTO @varCSID    

			WHILE (@@FETCH_STATUS = 0) BEGIN 
			   
				SELECT	@ItemID = cs.ItemID
				FROM	CashShop cs(NOLOCK)
				WHERE	cs.CSID = @varCSID

				IF (@ItemID IS NOT NULL) BEGIN
					-- ¾ÆÀÌÅÛ »ý¼º.    
					INSERT INTO AccountItem(AID, ItemID, RentDate, RentHourPeriod, Cnt)    
					VALUES (@AID, @ItemID, @RentDate, @RentHourPeriod, 1)
				END

				FETCH curBuyCashSetItem INTO @varCSID    
			END    

			CLOSE curBuyCashSetItem     
			DEALLOCATE curBuyCashSetItem

		COMMIT TRAN ------------------   
		
		SET @Ret = 1;
		RETURN @Ret;
	END   
END

-------------------------------------------------------------------------------------------------------------------------
-- º¹±¸ Äõ¸®
/*
DROP PROC spAdmWebInsertSetItem
EXEC sp_rename 'BackUp_spAdmWebInsertSetItem', 'spAdmWebInsertSetItem';
*/
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebItemUseLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
---------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebItemUseLog]  
 @UserID  VARCHAR(32)  
AS  
BEGIN  
 SET NOCOUNT ON 
 DECLARE @TargetAID INT  
 SELECT @TargetAID = AID FROM Account(NOLOCK) WHERE UserID=@UserID  
  
 SELECT l.AID, l.CID, c.Name AS CharName, i.ItemID, i.Name AS ItemName, l.Date, c.DeleteName   
 FROM BringAccountItemLog l(NOLOCK), Item i(NOLOCK), Character c(NOLOCK)  
 WHERE l.AID=@TargetAID AND l.CID=c.CID AND l.ItemID=i.ItemID  
 ORDER BY  Date DESC  
END
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebLeaveClanByCID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebLeaveClanByCID]  
 @CID int /* 탈퇴요청 캐릭터 CID */  
, @GMID varchar(20)
, @Ret int OUTPUT
AS  
 IF (@CID IS NULL) OR (@GMID IS NULL) BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 DECLARE @CLID int  
 DECLARE @MasterCID int  
  
 -- 존재하는 아이디인가?  
 SELECT @CLID = cm.CLID, @MasterCID = cl.MasterCID  
 FROM Clan cl(NOLOCK), ClanMember cm(NOLOCK)  
 WHERE cm.CID = @CID AND cl.CLID = cm.CLID  
  
 -- 클랜마스터가 아니고 클랜에 가입되 있을 경우만.  
 IF (@CID IS NULL) OR (@MasterCID = @CID) OR (@CLID IS NULL) BEGIN  
  SET @Ret = 0
  RETURN @Ret
 END  
    
 DELETE ClanMember WHERE CID = @CID  
 IF 0 <> @@ERROR  
 BEGIN  
  SET @Ret = 0
  RETURN @Ret
 END  
  
 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebRefreshBattleTimeRewardDescription]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebRefreshBattleTimeRewardDescription]
-- ALTER PROC dbo.spAdmWebRefreshBattleTimeRewardDescription
AS BEGIN
    
    SET NOCOUNT ON;

    DECLARE @DWIndex    INT,
            @ID         INT,
            @RCode      CHAR(7);

    SELECT @DWIndex = DATEPART(DW, GETDATE());

    DECLARE Curs CURSOR FAST_FORWARD FOR 
        SELECT  BRID, ResetCode
        FROM    dbo.BattleTimeRewardDescription(NOLOCK)
        WHERE   IsOpen = 1
        AND     GETDATE() BETWEEN StartDate AND EndDate


    OPEN Curs
    FETCH NEXT FROM Curs INTO @ID, @RCode;
    		
    WHILE( @@FETCH_STATUS = 0 )
    BEGIN
    	
        IF( SUBSTRING(@RCode, @DWIndex, 1) = 1 )
        BEGIN

            UPDATE  dbo.BattleTimeRewardTerm
            SET     ClosedDate = GETDATE()
            WHERE   BRID = @ID
            AND     BRTID IN    (   SELECT  TOP 1 BRTID 
                                    FROM    dbo.BattleTimeRewardTerm 
                                    WHERE   BRID = @ID
                                    ORDER BY BRTID DESC )

            INSERT  dbo.BattleTimeRewardTerm(BRID, LastResetDate)
            VALUES (@ID, GETDATE());

        END
    	
	    FETCH NEXT FROM Curs INTO @ID, @RCode;
    	
    END

    CLOSE Curs
    DEALLOCATE Curs

END
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebUndeleteCharacter]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[spAdmWebUndeleteCharacter]    
 @AID int    
, @CID int
, @GMID varchar(20)  
, @Ret int OUTPUT    
AS    
 SET NOCOUNT ON   
  
 IF EXISTS (SELECT LiveChar.CID FROM Character DelChar(NOLOCK) JOIN Character LiveChar(NOLOCK)
	ON DelChar.CID = @CID AND DelChar.DeleteFlag = 1 AND LiveChar.Name = DelChar.DeleteName
	WHERE LiveChar.DeleteFlag <> 1) BEGIN
  SET @Ret = 0    
  RETURN @Ret   
 END    
  
 DECLARE @CharCount int     
    
 SELECT @CharCount = COUNT(CID) FROM Character(NOLOCK) WHERE AID = @AID AND DeleteFlag <> 1    
 IF 4 > @CharCount BEGIN     
  DECLARE @FreeNum int    
  DECLARE @tb table( a int )  
  
  INSERT @tb VALUES( 0 )  
  INSERT @tb VALUES( 1 )  
  INSERT @tb VALUES( 2 )  
  INSERT @tb VALUES( 3 )  
  
  SELECT TOP 1 @FreeNum = t.a  
  FROM @tb t LEFT OUTER JOIN Character c(NOLOCK)  
  ON c.AID = @AID AND c.DeleteFlag <> 1 AND c.CharNum = t.a  
  WHERE c.CharNum IS NULL  
  
  IF @FreeNum IS NULL BEGIN    
   SET @Ret = 0    
   RETURN @Ret    
  END    
    
  BEGIN TRAN    
  UPDATE Character     
  SET Name = DeleteName, CharNum = @FreeNum, DeleteFlag = 0, DeleteName = ''
  WHERE CID = @CID AND AID = @AID AND DeleteFlag = 1 
  IF 0 = @@ROWCOUNT BEGIN    
   ROLLBACK TRAN    
   SET @Ret = 0    
   RETURN  @Ret  
  END    
  COMMIT TRAN    
  SET @Ret = 1    
  RETURN @Ret  
 END
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebUpdateAccountPenaltyPeriod]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebUpdateAccountPenaltyPeriod]
	@AID int
,	@UGradeID int
,	@Period int 
,	@GMID varchar(20)
,	@Ret int OUTPUT
AS
	SET NOCOUNT ON

	IF NOT EXISTS (SELECT AID FROM Account(NOLOCK) WHERE AID = @AID) BEGIN
		SET @Ret = 0
		RETURN @Ret
	END

	IF (0 > @Period) OR (@Period IS NULL) OR (0 > @UGradeID) OR (@UGradeID IS NULL) BEGIN
		SET @Ret = 0
		RETURN @Ret
	END

	BEGIN TRAN
	UPDATE Account SET UGradeID = @UGradeID WHERE AID = @AID
	IF 0 = @@ROWCOUNT BEGIN
		ROLLBACK TRAN
		SET @Ret = 0
		RETURN @Ret
	END

	IF NOT EXISTS (SELECT AID FROM AccountPenaltyPeriod(NOLOCK) WHERE AID = @AID) BEGIN
		IF 0 < @Period BEGIN
			-- 처음 재제를 받을경우.
			INSERT INTO AccountPenaltyPeriod( AID, DayLeft ) VALUES (@AID, @Period)
			IF 0 <> @@ERROR BEGIN 
				ROLLBACK TRAN
				SET @Ret = 0
				RETURN @Ret
			END
		END
	END
	ELSE BEGIN
		IF 0 < @Period BEGIN
			-- 이미 다른 재제를 받을경우 기간만 수정함.
			UPDATE AccountPenaltyPeriod SET DayLeft = @Period WHERE AID = @AID
				IF 0 = @@ROWCOUNT BEGIN
				ROLLBACK TRAN
				SET @Ret = 0
				RETURN @Ret
			END
		END
		ELSE BEGIN
			DELETE AccountPenaltyPeriod WHERE AID = @AID
			IF 0 <> @@ERROR BEGIN
				ROLLBACK TRAN	
				SET @Ret = 0
				RETURN @Ret
			END
		END
	END

	INSERT INTO AccountPenaltyLog( AID, UGradeID, DayLeft, RegDate, GMID )
	VALUES (@AID, @UGradeID, @Period, GETDATE(), @GMID )
	IF 0 <> @@ERROR BEGIN 
		ROLLBACK TRAN
		SET @Ret = 0
		RETURN @Ret
	END
	COMMIT TRAN

	SET @Ret = 1
	RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebUpdateBattleTimeRewardDescription]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spAdmWebUpdateBattleTimeRewardDescription]
-- ALTER PROC dbo.spAdmWebUpdateBattleTimeRewardDescription
    @BRID                   INT
    , @Name                 VARCHAR(128)
    , @StartDate            DATETIME
    , @EndDate              DATETIME
    , @StartHour            INT
    , @EndHour              INT
    , @RewardMinutePeriod   INT
    , @RewardCount          SMALLINT
    , @RewardKillCount      SMALLINT
    , @ResetCode            CHAR(7)
    , @ResetDesc            VARCHAR(128)
    , @IsOpen               TINYINT
    , @IsReset              TINYINT
AS BEGIN

    SET NOCOUNT ON;

    IF( @StartDate > @EndDate ) BEGIN
        SELECT -1 AS 'Ret';
        RETURN;
    END


    BEGIN TRAN -----------

        UPDATE  dbo.BattleTimeRewardDescription
        SET     [Name] = @Name, StartDate = @StartDate, EndDate = @EndDate, StartHour = @StartHour, EndHour = @EndHour,
                RewardMinutePeriod = @RewardMinutePeriod, RewardCount = @RewardCount, RewardKillCount = @RewardKillCount, 
                ResetCode = @ResetCode, ResetDesc = @ResetDesc, IsOpen = @IsOpen
        WHERE   BRID = @BRID

        IF( @@ERROR <> 0 ) BEGIN
            ROLLBACK TRAN;
            SELECT -2 AS 'Ret';
            RETURN;
        END

        IF( @IsReset = 1 ) BEGIN

            UPDATE  dbo.BattleTimeRewardTerm
            SET     ClosedDate = GETDATE()
            WHERE   BRID = @BRID
            AND     BRTID IN    (   SELECT  TOP 1 BRTID 
                                    FROM    dbo.BattleTimeRewardTerm 
                                    WHERE   BRID = @BRID 
                                    ORDER BY BRTID DESC )

            INSERT dbo.BattleTimeRewardTerm(BRID, LastResetDate)
            VALUES(@BRID, GETDATE());

            IF( @@ERROR <> 0 ) BEGIN
                ROLLBACK TRAN;
                SELECT -3 AS 'Ret';
                RETURN;
            END

        END        

    COMMIT TRAN ----------

    SELECT 0 AS 'Ret';
    
END
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebUpdateBattleTimeRewardItemList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebUpdateBattleTimeRewardItemList]
-- ALTER PROC dbo.spAdmWebUpdateBattleTimeRewardItemList
    @BRIID                  INT
    , @ItemIDMale           INT
    , @ItemIDFemale         INT
    , @RentHourPeriod       INT
    , @ItemCnt              INT
    , @RatePerThousand      INT
AS BEGIN

    SET NOCOUNT ON;

    UPDATE  dbo.BattleTimeRewardItemList
    SET     ItemIDMale = @ItemIDMale, ItemIDFemale = @ItemIDFemale,
            RentHourPeriod = @RentHourPeriod, ItemCnt = @ItemCnt, RatePerThousand = @RatePerThousand
    WHERE   BRIID = @BRIID;

END
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebUpdateBlockCountryCode]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------
 
CREATE PROC [dbo].[spAdmWebUpdateBlockCountryCode]  
 @CountryCode3 char(3)  
, @RoutingURL varchar(64)  
, @IsBlock tinyint  
, @Ret int Output  
AS  
 SET NOCOUNT ON  
 UPDATE BlockCountryCode   
 SET RoutingURL = @RoutingURL , IsBlock = @IsBlock  
 WHERE CountryCode3 = @CountryCode3   
 IF 0 = @@ROWCOUNT SET @Ret = 0  
 ELSE SET @Ret = 1  
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebUpdateCashSetShopItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
----------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebUpdateCashSetShopItem]  
 @CSSID int  
, @Name varchar(64)
, @ResSex tinyint  
, @ResLevel int  
, @Weight int  
, @Description varchar(1024)
, @Opened tinyint  
, @CashPrice int  
, @WebImgName varchar(64)  
, @RentType tinyint
, @Ret int OUTPUT  
 AS  
 SET NOCOUNT ON  
 IF (@CSSID IS NULL) OR (@ResSex IS NULL) OR (@Weight IS NULL)  
  OR (@Opened IS NULL) OR (@Description IS NULL ) OR (@CashPrice IS NULL)
  OR (@WebImgName IS NULL) OR (@RentType IS NULL) OR (@Name IS NULL) BEGIN  
  SET @Ret = 0  
  RETURN @Ret  
 END  
  
 UPDATE CashSetShop  
 SET ResSex = @ResSex, ResLevel = @ResLevel, Weight = @Weight,   
  Description = @Description, Opened = @Opened, CashPrice = @CashPrice,   
  WebImgName = @WebImgName, RentType = @RentType, Name = @Name
 WHERE CSSID = @CSSID  
 IF 0 = @@ROWCOUNT BEGIN  
  SET @Ret = 0  
  RETURN   
 END  
  
 SET @Ret = 1  
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebUpdateCashShopItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
---------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebUpdateCashShopItem]  
 @CSID int  
, @Opened tinyint  
, @CashPrice int  
, @WebImgName varchar(64)  
, @RentType tinyint
, @Ret int OUTPUT  
AS  
 UPDATE CashShop   
 SET Opened = @Opened, CashPrice = @CashPrice, WebImgName = @WebImgName,
  RentType = @RentType
 WHERE CSID = @CSID  
 IF 0 = @@ROWCOUNT BEGIN  
  SET @Ret = 0  
  RETURN @Ret  
 END  
   
 SET @Ret = 1  
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebUpdateCashShopNewItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebUpdateCashShopNewItem]
 @NewOrder int
, @CSID int
, @CSSID int
, @IsSetItem int
, @CategoryID int
, @Ret int OUTPUT
AS
 SET NOCOUNT ON

 DECLARE @Category varchar(12)
 SELECT @Category = Description FROM CashShopNewItemCategory(NOLOCK)
 WHERE CategoryID = @CategoryID

 IF 0 = @IsSetItem BEGIN
  UPDATE CashShopNewItem 
  SET Category = @Category, NewOrder = @NewOrder, IsSetItem = @IsSetItem,
   CSID = @CSID, CSSID = @CSSID, Slot = ist.Description, Name = i.Name,
   ResSex = i.ResSex, ResLevel = i.ResLevel, CashPrice = cs.CashPrice, 
   WebImgName = cs.WebImgName, RegDate = cs.RegDate
  FROM (Item i(NOLOCK) JOIN CashShop cs(NOLOCK)
  ON cs.CSID = @CSID AND i.ItemID = cs.ItemID) 
   JOIN ItemSlotType ist(NOLOCK) ON ist.SlotType = i.Slot
  WHERE NewOrder = @NewOrder
  IF 0 = @@ROWCOUNT BEGIN
   SET @Ret = 0
   RETURN @Ret
  END
 END
 ELSE IF 1 = @IsSetItem BEGIN
  UPDATE CashShopNewItem
  SET Category = @Category, NewOrder = @NewOrder, IsSetItem = @IsSetItem,
   CSID = @CSID, CSSID = @CSSID, Slot = ist.Description, Name = css.Name,
   ResSex = css.ResSex, ResLevel = css.ResLevel, CashPrice = css.CashPrice,
   WebImgName = css.WebImgName, RegDate = css.RegDate
  FROM CashSetShop css(NOLOCK) JOIN ItemSlotType ist(NOLOCK)
  ON css.CSSID = @CSSID AND ist.SlotType = 10
  WHERE NewOrder = @NewOrder
  IF 0 = @@ROWCOUNT BEGIN
   SET @Ret = 0
   RETURN @Ret
  END
 END

 SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebUpdateCustomIP]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------
/*
 * @Ret(0:Fail, 1:Success, 2:Duplicate, 3:Invers range)
 */
CREATE PROC [dbo].[spAdmWebUpdateCustomIP]
 @IPFrom varchar(15)
, @IPTo varchar(15)
, @NewIPFrom varchar(15)
, @NewIPTo varchar(15)
, @IsBlock tinyint
, @CountryCode3 char(3)
, @Comment varchar(128)
, @Ret int OUTPUT
AS
 SET NOCOUNT ON 
 DECLARE @DupRet bigint
 DECLARE @TmpIPFrom BIGINT
 DECLARE @TmpIPTo BIGINT
 DECLARE @TmpNewIPFrom bigint
 DECLARE @TmpNewIPTo bigint

 SET @TmpIPFrom = GunzDB.dbo.inet_aton( @IPFrom )
 SET @TmpIPTo = GunzDB.dbo.inet_aton( @IPTo )

 IF @TmpIPFrom > @TmpIPTo BEGIN
  SET @Ret = 3
  RETURN @Ret
 END

 SET @TmpNewIPFrom = GunzDB.dbo.inet_aton( @NewIPFrom )
 SET @TmpNewIPTo = GunzDB.dbo.inet_aton( @NewIPTo )

 IF @TmpNewIPFrom > @TmpNewIPTo BEGIN
  SET @Ret = 0
  RETURN @Ret
 END

 -- 이전 IP범위와 같으면 IP변경 없이 다른 데이터만 변경하는 것임.
 IF (@TmpIPFrom <> @TmpNewIPFrom) OR (@TmpIPTo <> @TmpNewIPTo) BEGIN
  EXEC spIPFltCheckIsDuplicateRange @TmpNewIPFrom, @TmpNewIPTo, @DupRet OUTPUT
  IF 1 = @DupRet BEGIN 
   SET @Ret = 2
   RETURN @Ret
  END
 END

 UPDATE CustomIP
 SET IPFrom = @TmpNewIPFrom, IPTo = @TmpNewIPTo,
  IsBlock = @IsBlock, CountryCode3 = @CountryCode3,
  Comment = @Comment
 WHERE IPFrom = @TmpIPFrom AND IPTo = @TmpIPTo
 IF 0 <> @@ERROR OR 0 = @@ROWCOUNT SET @Ret = 0
 ELSE SET @Ret = 1
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spAdmWebUpdateQuestItemInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
---------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spAdmWebUpdateQuestItemInfo]
 @CID int
, @QuestItemInfo binary(292)
AS
 SET NOCOUNT ON 
 UPDATE Character
 SET QuestItemInfo = @QuestItemInfo
 WHERE CID = @CID
GO
/****** Object:  StoredProcedure [dbo].[spBringAccountItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spBringAccountItem]
-- ALTER PROC dbo.spBringAccountItem
	@AID	INT,
	@CID	INT,
	@AIID	INT,		
	@CIID	INT,
	@Count	INT
AS BEGIN

	SET NOCOUNT ON

	------------------------------------------------------------------------------------------------------------

	DECLARE @CAID INT;	
	SELECT @CAID = AID FROM dbo.Character(NOLOCK) WHERE CID = @CID
	
	IF( @CAID != @AID ) BEGIN
		SELECT -1 AS 'Ret'
		RETURN;
	END
		
		
	DECLARE @ItemID				INT    
	DECLARE @RentDate			DATETIME    
	DECLARE @RentHourPeriod		SMALLINT    
	DECLARE @Cnt				SMALLINT
	
	SELECT	@ItemID = ItemID, @RentDate = RentDate, @RentHourPeriod = RentHourPeriod, @Cnt = ISNULL(Cnt, 1)
	FROM	dbo.AccountItem(NOLOCK)
	WHERE	AIID = @AIID
	AND		AID = @AID;
		
	IF( @ItemID IS NULL ) BEGIN
		SELECT -2 AS 'Ret'
		RETURN;
	END
	
	------------------------------------------------------------------------------------------------------------

		
	DECLARE @NowDate DATETIME
	SELECT @NowDate = GETDATE();
	
	DECLARE @OrderCIID	INT
	
	BEGIN TRAN ----------------
	
		IF ( @Cnt = @Count ) BEGIN
			
			DELETE	AccountItem 
			WHERE	AIID = @AIID AND AID = @AID;
			
			IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN 
				ROLLBACK TRAN     
				SELECT -3 AS 'Ret'
				RETURN    
			END
			
		END
		ELSE BEGIN
		
			UPDATE	AccountItem 
			SET		Cnt = @Cnt - @Count 
			WHERE	AIID = @AIID 
			AND		AID = @AID
			AND		Cnt - @Count > 0;
			
			IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN    
				ROLLBACK TRAN     
				SELECT -4 AS 'Ret'
				RETURN 
			END
			
		END 				
		
		IF( @CIID > 0 ) BEGIN
		
			UPDATE	CharacterItem 
			SET		Cnt = Cnt + @Count 
			WHERE	CIID = @CIID
			AND		CID = @CID;
				
			SET @OrderCIID = @CIID;
			
			IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN      
				ROLLBACK TRAN
				SELECT -6 AS 'Ret'  
				RETURN     
			END			
			
		END 
		ELSE BEGIN		
		
			INSERT INTO CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt)
			VALUES (@CID, @ItemID, @NowDate, @RentDate, @RentHourPeriod, @Count);
			
			SET @OrderCIID = @@IDENTITY;
			
			IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN      
				ROLLBACK TRAN
				SELECT -7 AS 'Ret'
				RETURN     
			END
						
		END	
		
		 INSERT INTO BringAccountItemLog (ItemID, AID, CID, Date)  
		 VALUES (@ItemID, @AID, @CID, GETDATE());
		 IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN
			 ROLLBACK TRAN  
			 SELECT -8 AS 'Ret'
			 RETURN  
		 END  
 
		INSERT INTO ItemChangeLog_AccountItem(ChangeType, ChangeDate, AID, AIID, CID, CIID, ItemID, [Count])
		VALUES (200, @NowDate, @AID, @AIID, @CID, @OrderCIID, @ItemID, @Count);
		
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN      
			ROLLBACK TRAN
			SELECT -9 AS 'Ret'
			RETURN     
		END
		
		INSERT INTO ItemChangeLog_CharacterItem(ChangeType, ChangeDate, CID, CIID, AID, AIID, ItemID, [Count])
		VALUES (100, @NowDate, @CID, @OrderCIID, @AID, @AIID, @ItemID, @Count);
		
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN      
			ROLLBACK TRAN
			SELECT -10 AS 'Ret'
			RETURN     
		END
		

	COMMIT TRAN ---------------   	 
		

	SELECT	0 AS 'Ret'
			, @OrderCIID AS ORDERCIID, @ItemID AS ItemID  
			, @Count AS Cnt
			, @RentHourPeriod as 'RentHourPeriod'  
			, (@RentHourPeriod*60) - (DateDiff(n, @RentDate, GETDATE())) AS RentPeriodRemainder
END
GO
/****** Object:  StoredProcedure [dbo].[spBringAccountItem2]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spBringAccountItem2]  
 @AID  int,  
 @CID  int,  
 @AIID  int  
AS  
SET NoCount On  
  
DECLARE @ItemID int  
DECLARE @CAID int  
DECLARE @OrderCIID int  
  
DECLARE @RentDate   DATETIME  
DECLARE @RentHourPeriod  SMALLINT  
DECLARE @Cnt    SMALLINT  
  
SELECT @ItemID=ItemID, @RentDate=RentDate, @RentHourPeriod=RentHourPeriod, @Cnt=Cnt  
FROM AccountItem WHERE AIID = @AIID  
  
  
SELECT @CAID = AID FROM Character WHERE CID=@CID  
  
IF @ItemID IS NOT NULL AND @CAID = @AID  
BEGIN  
 BEGIN TRAN ----------------  
 DELETE FROM AccountItem WHERE AIID = @AIID  
 IF 0 <> @@ERROR BEGIN  
  ROLLBACK TRAN   
  RETURN  
 END  
  
 INSERT INTO CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt)  
 VALUES (@CID, @ItemID, GETDATE(), @RentDate, @RentHourPeriod, @Cnt)  
 IF 0 <> @@ERROR BEGIN   
  ROLLBACK TRAN  
  RETURN   
 END  
  
 SET @OrderCIID = @@IDENTITY  
  
 INSERT INTO BringAccountItemLog (ItemID, AID, CID, Date)  
 VALUES (@ItemID, @AID, @CID, GETDATE())  
 IF 0 <> @@ERROR BEGIN  
  ROLLBACK TRAN  
  RETURN  
 END  
  
 COMMIT TRAN ---------------  
  
 SELECT @OrderCIID AS ORDERCIID, @ItemID AS ItemID
  , @RentHourPeriod as 'RentHourPeriod'
  , (@RentHourPeriod*60) - (DateDiff(n, @RentDate, GETDATE())) AS RentPeriodRemainder  
END
GO
/****** Object:  StoredProcedure [dbo].[spBringBackAccountGambleItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------
-- ÀÛ¾÷ÇÒ Äõ¸®

CREATE PROC [dbo].[spBringBackAccountGambleItem]
-- ALTER PROC dbo.spBringBackAccountGambleItem
	@AID			INT,
	@CID			INT,
	@CIID			INT,
	@ItemCnt		INT	
AS BEGIN
	SET NOCOUNT ON
  	
  	-- Äõ¸® ½ÇÇà ³¯Â¥ ÀúÀå
	DECLARE @CurDate DATETIME;
	SET @CurDate = GETDATE();
	
	DECLARE @CharItemID				INT
	DECLARE @CharItemRentDate		DATETIME  
	DECLARE @CharItemRentHourPeriod SMALLINT  
	DECLARE @CharItemCnt			SMALLINT  	
				
	-- ¿Å±â°íÀÚ ÇÏ´Â °×ºí ¾ÆÀÌÅÛÀÇ ÀÎº¥ Á¤º¸ 
	SELECT	@CharItemID = ItemID, @CharItemRentDate = RentDate
			, @CharItemRentHourPeriod = RentHourPeriod, @CharItemCnt = ISNULL(Cnt, 1)
	FROM	CharacterItem 
	WHERE	CIID = @CIID
	AND		CID IS NOT NULL;

	IF( @CharItemID IS NULL ) BEGIN
		SELECT -1 AS 'Ret';
		RETURN;
	END
	
	IF( @CharItemCnt < @ItemCnt ) BEGIN
		SELECT -2 AS 'Ret';
		RETURN;
	END	
	
	DECLARE @AIID INT;	
	
	SELECT	TOP 1 @AIID = AIID 
	FROM	AccountItem 
	WHERE	AID = @AID 
	AND		ItemID = @CharItemID;
	 
	BEGIN TRAN -------------
	
		IF( @CharItemCnt = @ItemCnt ) BEGIN
		
			UPDATE	CharacterItem 
			SET		CID = NULL
			WHERE	CIID = @CIID
			AND		CID = @CID;
			
			IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN  
				ROLLBACK TRAN;
				SELECT -3 AS 'Ret';
				RETURN;
			END
			
		END
		ELSE BEGIN
			
			UPDATE	CharacterItem 
			SET		Cnt = @CharItemCnt - @ItemCnt 
			WHERE	CIID = @CIID
			AND		CID = @CID
			AND		Cnt - @ItemCnt > 0;
			
			IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN  
				ROLLBACK TRAN;
				SELECT -4 AS 'Ret';
				RETURN;		
			END
			
		END
  
  -------------------------------------------------------------------------------------------  			
			
		IF( @AIID IS NULL ) BEGIN
		
			INSERT INTO AccountItem (AID, ItemID, RentDate, RentHourPeriod, Cnt)   
			VALUES (@AID, @CharItemID, @CharItemRentDate, @CharItemRentHourPeriod, @ItemCnt);
			
			SET @AIID = @@IDENTITY;
			
			IF( 0 <> @@ERROR ) BEGIN  
				ROLLBACK TRAN;
				SELECT -5 AS 'Ret';
				RETURN;		
			END	
			
		END
		ELSE BEGIN
						
			UPDATE	AccountItem 
			SET		Cnt = Cnt + @ItemCnt 
			WHERE	AIID = @AIID 
			AND		AID = @AID;
				
			IF( 0 <> @@ERROR ) BEGIN  
				ROLLBACK TRAN;
				SELECT -6 AS 'Ret';
				RETURN;		
			END					
		END
			
	COMMIT TRAN -----------  
	
	
	
	SELECT 0 AS 'Ret';
END
GO
/****** Object:  StoredProcedure [dbo].[spBringBackAccountItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spBringBackAccountItem]
-- ALTER PROC dbo.spBringBackAccountItem
	@AID			INT,
	@CID			INT,
	@CIID			INT
AS BEGIN
	SET NOCOUNT ON
  	
	DECLARE @ItemID			INT;
	DECLARE @RentDate		DATETIME; 
	DECLARE @RentHourPeriod SMALLINT;
	
	DECLARE @CurDate DATETIME;
	SET @CurDate = GETDATE();
			
	SELECT	@ItemID = ItemID, @RentDate = RentDate
			, @RentHourPeriod = RentHourPeriod
	FROM	CharacterItem 
	WHERE	CIID = @CIID
	AND		CID = @CID;

	IF( (@ItemID IS NULL) AND (@ItemID < 400000) ) BEGIN
		SELECT -1 AS 'Ret';
		RETURN;
	END	
	
	IF( EXISTS(SELECT CID FROM CharacterEquipmentSlot WHERE CIID = @CIID AND CID = @CID) ) BEGIN
		SELECT -2 AS 'Ret';
		RETURN;
	END
	 
	BEGIN TRAN -------------
	
		UPDATE	CharacterItem 
		SET		CID = NULL
		WHERE	CIID = @CIID
		AND		CID = @CID;
		
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN  
			ROLLBACK TRAN;
			SELECT -3 AS 'Ret';
			RETURN;
		END
		
		INSERT INTO AccountItem (AID, ItemID, RentDate, RentHourPeriod, Cnt)   
		VALUES (@AID, @ItemID, @RentDate, @RentHourPeriod, 1);
		
		DECLARE @AIID INT;
		SET @AIID = @@IDENTITY;
			
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN  
			ROLLBACK TRAN;
			SELECT -4 AS 'Ret';
			RETURN;		
		END	
		
	COMMIT TRAN -----------  
	
	SELECT 0 AS 'Ret';
END
GO
/****** Object:  StoredProcedure [dbo].[spBuyBountyItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spBuyBountyItem]
-- ALTER PROC dbo.spBuyBountyItem
	@CID				INT,  
	@ItemID				INT,
	@ItemCount			INT,
	@Price				INT,
	@IsSpendableItem	INT,
	@RentHourPeriod		INT = NULL	
AS BEGIN
	SET NOCOUNT ON
	
	DECLARE @Bounty INT;
	DECLARE @OrderCIID INT;
	DECLARE @Cnt INT;
	
	IF( @RentHourPeriod IS NULL ) BEGIN
		SET @RentHourPeriod = 0;
	END
	
	DECLARE @CurDate DATETIME;
	SET @CurDate = GETDATE();

	BEGIN TRAN ----------------------------	
	
		-- ÀÜ¾×°Ë»ç => Bounty °¨¼Ò      
		UPDATE	dbo.Character 
		SET		BP = BP - @Price 
		WHERE	CID = @CID 
		AND		(BP - @Price > 0);
		
		IF( 0 <> @@ERROR OR 0 = @@ROWCOUNT ) BEGIN      
			ROLLBACK TRAN
			SELECT -1 AS 'Ret'
			RETURN;
		END      		
		
		IF( @IsSpendableItem = 1 ) BEGIN
					
			-- ÀÌ¹Ì °®°í ÀÖ´ÂÁö È®ÀÎÇØº»´Ù.
			SELECT	@OrderCIID = CIID 
			FROM	CharacterItem(NOLOCK) 
			WHERE	CID = @CID 
			AND		ItemID = @ItemID;
		
			-- ÀÌ¹Ì °®°í ÀÖÁö ¾Ê´Ù¸é »õ·Î Ãß°¡ÇØÁØ´Ù.
			IF( @OrderCIID IS NOT NULL ) BEGIN
			
				UPDATE	dbo.CharacterItem				-- Item Ãß°¡
				SET		Cnt = Cnt + @ItemCount
				WHERE	CIID = @OrderCIID
				AND		CID = @CID;
				
				IF( 0 <> @@ERROR OR 0 = @@ROWCOUNT ) BEGIN      
					ROLLBACK TRAN
					SELECT -2 AS 'Ret'
					RETURN;
				END
										
			END ELSE BEGIN
			
				INSERT INTO CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt)
				Values (@CID, @ItemID, @CurDate, @CurDate, @RentHourPeriod, @ItemCount)
				
				IF( 0 <> @@ERROR OR 0 = @@ROWCOUNT ) BEGIN      
					ROLLBACK TRAN
					SELECT -3 AS 'Ret'
					RETURN;
				END
				
				SELECT @OrderCIID = @@IDENTITY;	
			END
						
		END
		ELSE BEGIN
				
			INSERT dbo.CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt)
			Values (@CID, @ItemID, @CurDate, @CurDate, @RentHourPeriod, @ItemCount)
			
			SELECT @OrderCIID = @@IDENTITY;	
			
			IF( 0 <> @@ERROR OR 0 = @@ROWCOUNT ) BEGIN      
				ROLLBACK TRAN
				SELECT -4 AS 'Ret'
				RETURN;
			END
						
		END 
		
		-- Item ±¸¸Å·Î±× Ãß°¡      
		INSERT INTO ItemPurchaseLogByBounty (ItemID, CID, Date, Bounty, CharBounty, Type)
		VALUES (@ItemID, @CID, @CurDate, @Price, @Bounty, '±¸ÀÔ')
		
		IF( 0 <> @@ERROR OR 0 = @@ROWCOUNT ) BEGIN      
			ROLLBACK TRAN
			SELECT -5 AS 'Ret'
			RETURN;
		END
		
	COMMIT TRAN ----------------------------
		
	SELECT 0 AS 'Ret', @OrderCIID AS 'ORDERCIID'
END


----------------------------------------------------------------------------------------------------------------------------------------
-- º¹±¸ Äõ¸®
/*
DROP PROC spBuyBountyItem
EXEC sp_rename 'BackUp_spBuyBountyItem', 'spBuyBountyItem'
*/
GO
/****** Object:  StoredProcedure [dbo].[spBuyBountyItem_Backup_20071217]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[spBuyBountyItem_Backup_20071217]
	@CID		INT,
	@ItemID		INT,
	@Price		INT
AS
SET NOCOUNT ON
BEGIN
	DECLARE @OrderCIID	int
	DECLARE @Bounty	INT

	BEGIN TRAN
		-- ÀÜ¾×°Ë»ç
		SELECT @Bounty=BP FROM Character(NOLOCK) WHERE CID=@CID
		IF @Bounty IS NULL OR @Bounty < @Price
		BEGIN
			ROLLBACK TRAN
			RETURN 0
		END

		-- Bounty °¨¼Ò
		UPDATE Character SET BP=BP-@Price WHERE CID=@CID
		IF 0 = @@ROWCOUNT
		BEGIN
			ROLLBACK TRAN
			RETURN (-1)
		END

		-- Item Ãß°¡
		INSERT INTO CharacterItem (CID, ItemID, RegDate) Values (@CID, @ItemID, GETDATE())
		IF 0 <> @@ERROR
		BEGIN
			ROLLBACK TRAN
			RETURN (-1)
		END

		SELECT @OrderCIID = @@IDENTITY
		
		-- Item ±¸¸Å·Î±× Ãß°¡
		INSERT INTO ItemPurchaseLogByBounty (ItemID, CID, Date, Bounty, CharBounty, Type)
		VALUES (@ItemID, @CID, GETDATE(), @Price, @Bounty, '±¸ÀÔ')
		IF 0 <> @@ERROR BEGIN
			ROLLBACK TRAN
			RETURN (-1)
		END

		SELECT @OrderCIID as ORDERCIID
	COMMIT TRAN

	RETURN 1
END
GO
/****** Object:  StoredProcedure [dbo].[spBuyBountyItem2]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create    PROC [dbo].[spBuyBountyItem2]   
 @CID  INT  
,  @ItemID  INT  
, @Price  INT    
, @RentHourPeriod INT   
AS    
SET NOCOUNT ON    
BEGIN    
 DECLARE @OrderCIID int    
 DECLARE @Bounty INT    
    
 BEGIN TRAN    
  -- 잔액검사    
  SELECT @Bounty=BP FROM Character(NOLOCK) WHERE CID=@CID    
  IF @Bounty IS NULL OR @Bounty < @Price    
  BEGIN    
   ROLLBACK TRAN    
   RETURN 0    
  END    
    
  -- Bounty 감소    
  UPDATE Character SET BP=BP-@Price WHERE CID=@CID    
  IF 0 = @@ROWCOUNT    
  BEGIN    
   ROLLBACK TRAN    
   RETURN (-1)    
  END    
    
  -- Item 추가    
  INSERT INTO CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod)   
  Values (@CID, @ItemID, GETDATE(), GETDATE(), @RentHourPeriod)    
  IF 0 <> @@ERROR    
  BEGIN    
   ROLLBACK TRAN    
   RETURN (-1)    
  END    
    
  SELECT @OrderCIID = @@IDENTITY    
      
  -- Item 구매로그 추가    
  INSERT INTO ItemPurchaseLogByBounty (ItemID, CID, Date, Bounty, CharBounty, Type)    
  VALUES (@ItemID, @CID, GETDATE(), @Price, @Bounty, '구입')    
  IF 0 <> @@ERROR BEGIN    
   ROLLBACK TRAN    
   RETURN (-1)    
  END    
    
  SELECT @OrderCIID as ORDERCIID    
 COMMIT TRAN    
    
 RETURN 1    
END
GO
/****** Object:  StoredProcedure [dbo].[spBuyCashItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROC [dbo].[spBuyCashItem]  
 @UserID  varchar(20),  
 @CSID  int,  
 @Cash  int,  
 @RentHourPeriod smallint = NULL,  
 @MobileCode char(16) = NULL  
AS  
 SET NoCount On  

 IF NOT EXISTS (SELECT * FROM CashShop(NOLOCK) WHERE CSID= @CSID AND Opened = 1)
  RETURN 0;
  
 DECLARE @AID  int  
 DECLARE @ItemID  int  
  
 -- Account 검사  
 SELECT @AID = AID FROM Account WHERE UserID = @UserID  
 IF @AID IS NULL  
 BEGIN  
  RETURN 0  
 END  
 ELSE  
 BEGIN  
  SELECT @ItemID = ItemID 
  FROM CashShop cs (NOLOCK) 
  WHERE cs.CSID = @CSID AND Opened = 1
  
  IF @ItemID IS NOT NULL  
  BEGIN   
   DECLARE @RentDate datetime  
  
   -- @RentHourPeriod값을 가지고 기간제인지 검사.  
   IF @RentHourPeriod = 0 OR @RentHourPeriod IS NULL  
   BEGIN  
    -- 기간제 아이템일 경우 영구 아이템 판매 여부 검사  
    DECLARE @RentType  TINYINT  
    DECLARE @RCSPID  INT  
  
    SELECT @RentType = RentType 
    FROM CashShop(NOLOCK)
    WHERE CSID=@CSID AND Opened = 1
    IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) 
     RETURN 0

    IF @RentType = 1  
    BEGIN  
     SELECT @RCSPID = RCSPID FROM RentCashShopPrice WHERE CSID=@CSID AND RentHourPeriod is NULL  
     IF @RCSPID IS NULL  
     BEGIN  
      RETURN 0  
     END  
    END  
  
    -- 일반 아이템인 경우  
    SET @RentDate = NULL  
   END  
   ELSE  
   BEGIN  
    SET @RentDate = GETDATE()  
   END  
  
  
   BEGIN TRAN  
     
    -- 아이템 생성.  
    INSERT INTO accountitem(AID, ItemID, RentDate, RentHourPeriod)   
    VALUES (@AID, @ItemID, @RentDate, @RentHourPeriod)  
  
    IF @@ERROR <> 0  
    BEGIN  
     ROLLBACK  
     RETURN 0  
    END  
   
    -- 아이템 거래 log생성.  
    INSERT INTO ItemPurchaseLogByCash(AID, ItemID, Date, RentHourPeriod, Cash, MobileCode)   
    VALUES (@AID, @ItemID, GETDATE(), @RentHourPeriod, @Cash, @MobileCode)  
      
    IF @@ERROR <> 0  
    BEGIN  
     ROLLBACK  
     RETURN 0  
    END  
      
   COMMIT TRAN  
  
   RETURN 1  
  
  END   
  ELSE  
  BEGIN  
   RETURN 0  
  END  
 END  
  
 RETURN 1
GO
/****** Object:  StoredProcedure [dbo].[spBuyCashSetItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- cash set shop에서 거래된 아이템을 accountitme에 추가.
CREATE     PROC [dbo].[spBuyCashSetItem]
	@UserID		varchar(20),
	@CSSID		int,
	@Cash		int,
	@RentHourPeriod smallint = NULL,
	@MobileCode char(16) = NULL
AS
	SET NoCount On

	DECLARE @AID		int

	IF NOT EXISTS (SELECT * FROM CashSetShop(NOLOCK) WHERE CSSID = @CSSID AND Opened = 1)
 	 RETURN 0;
	
	SELECT @AID = AID FROM Account WHERE UserID = @UserID

	-- 존제하는 유저인지 검사.
	IF @AID IS NULL
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		DECLARE @RentDate		datetime			

		-- @RentHourPeriod값을 가지고 기간제인지 검사.
		IF @RentHourPeriod = 0 OR @RentHourPeriod IS NULL
		BEGIN
			-- 기간제 아이템일 경우 영구 아이템 판매 여부 검사
			DECLARE @RentType 	TINYINT
			DECLARE @RCSSPID		INT

			SELECT @RentType = RentType FROM CashSetShop WHERE CSSID=@CSSID

			IF @RentType = 1
			BEGIN
				SELECT @RCSSPID=RCSSPID FROM RentCashSetShopPrice WHERE CSSID=@CSSID AND RentHourPeriod is 
NULL
				IF @RCSSPID IS NULL
				BEGIN
					RETURN 0
				END
			END

			-- 일반 아이템일 경우
			SET @RentDate = NULL
		END
		ELSE
		BEGIN
			SET @RentDate = GETDATE()
		END



		BEGIN TRAN

			DECLARE curBuyCashSetItem 	INSENSITIVE CURSOR
			FOR
				SELECT CSID FROM CashSetItem (NOLOCK) WHERE CSSID = @CSSID
			FOR READ ONLY
	
			OPEN curBuyCashSetItem 
	
			DECLARE @varCSID		int
			DECLARE @ItemID			int
	
			FETCH FROM curBuyCashSetItem INTO @varCSID
	
			WHILE @@FETCH_STATUS = 0
			BEGIN
				SELECT @ItemID = cs.ItemID
				FROM CashShop cs (NOLOCK) 
				WHERE cs.CSID = @varCSID 
	
				IF @ItemID IS NOT NULL
				BEGIN
					-- 아이템 생성.
					INSERT INTO AccountItem(AID, ItemID, RentDate, RentHourPeriod)
					VALUES (@AID, @ItemID, @RentDate, @RentHourPeriod)
					
					IF @@ERROR <> 0
					BEGIN
						ROLLBACK
						CLOSE curBuyCashSetItem 
						DEALLOCATE curBuyCashSetItem 
						RETURN 0
					END					
				END
	
				FETCH curBuyCashSetItem  INTO @varCSID
			END
	
			CLOSE curBuyCashSetItem 
			DEALLOCATE curBuyCashSetItem 
	
			-- 셋트 아이템 구입 로그.
			INSERT INTO SetItemPurchaseLogByCash (AID, CSSID, Date, RentHourPeriod, Cash, MobileCode)
			VALUES (@AID, @CSSID, GETDATE(), @RentHourPeriod, @Cash, @MobileCode)

			IF @@ERROR <> 0
			BEGIN
				ROLLBACK
				RETURN 0
			END
							
		COMMIT TRAN
		RETURN 1
	END
GO
/****** Object:  StoredProcedure [dbo].[spCashShopGetRankedList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spCashShopGetRankedList]
	@Category	varchar(32)
	-- @Category : ¿ø°Å¸®¹«±â, ±ÙÁ¢¹«±â, Æ¯¼ö¾ÆÀÌÅÛ, ¹æ¾î±¸, ¼¼Æ®
AS
SET NOCOUNT ON
BEGIN
	IF (@Category = '¼¼Æ®')
	BEGIN
		SELECT TOP 5 r.Category, r.Rank, r.Name, r.CSID, r.CSSID, r.Slot, r.ResSex, r.ResLevel, r.CashPrice, r.RegDate, s.WebImgName
		FROM CashShopRank r(NOLOCK), CashSetShop s(NOLOCK)
		WHERE r.CSSID=s.CSSID AND Category=@Category AND s.Opened=1
	END
	ELSE
	BEGIN
		SELECT TOP 5 r.Category, r.Rank, r.Name, r.CSID, r.CSSID, r.Slot, r.ResSex, r.ResLevel, r.CashPrice, r.RegDate, s.WebImgName
		FROM CashShopRank r(NOLOCK), CashShop s(NOLOCK)
		WHERE r.CSID=s.CSID AND Category=@Category AND s.Opened=1
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spCashShopNewItemList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROC [dbo].[spCashShopNewItemList]
	@IsSetItem		INT
AS
SET NOCOUNT ON
BEGIN
	IF @IsSetItem=0
	BEGIN
		SELECT TOP 4 n.* FROM CashShopNewItem n(NOLOCK), CashShop c(NOLOCK)
		WHERE n.CSID=c.CSID AND c.Opened=1 AND Slot!='¼¼Æ®' ORDER BY NewOrder
	END
	ELSE
	BEGIN
		SELECT TOP 4 n.* FROM CashShopNewItem n(NOLOCK), CashSetShop c(NOLOCK)
		WHERE n.CSSID=c.CSSID AND c.Opened=1 AND  Slot='¼¼Æ®' ORDER BY NewOrder
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spCashShopNewItemUpdate]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spCashShopNewItemUpdate]
	@NewOrder		INT,
	@IsSetItem		INT,
	@CSID			INT,
	@CSSID			INT
AS
SET NOCOUNT ON
BEGIN

	IF EXISTS(SELECT id FROM CashShopNewItem(NOLOCK) WHERE NewOrder=@NewOrder)
	BEGIN
		DELETE CashShopNewItem WHERE NewOrder=@NewOrder
	END

	IF @IsSetItem = 0
	BEGIN
		INSERT INTO CashShopNewItem (NewOrder, Category, IsSetItem, CSID, CSSID, Slot, Name, ResSex, ResLevel, CashPrice, WebImgName)
		SELECT @NewOrder AS NewOrder, 
			CASE i.Slot 
				WHEN 0 THEN 'Á¦ÇÑ¾øÀ½'
				WHEN 1 THEN '±ÙÁ¢¹«±â'
				WHEN 2 THEN '¿ø°Å¸®¹«±â'
				WHEN 3 THEN 'Æ¯¼ö¾ÆÀÌÅÛ'
				WHEN 4 THEN '¹æ¾î±¸'
				WHEN 5 THEN '¹æ¾î±¸'
				WHEN 6 THEN '¹æ¾î±¸'
				WHEN 7 THEN '¹æ¾î±¸'
				WHEN 8 THEN '¹æ¾î±¸'
				WHEN 9 THEN '¹æ¾î±¸'
			END AS Category, 
			@IsSetItem, s.CSID, NULL AS CSSID,
			CASE i.Slot 
				WHEN 0 THEN 'Á¦ÇÑ¾øÀ½'
				WHEN 1 THEN '±ÙÁ¢¹«±â'
				WHEN 2 THEN '¿ø°Å¸®¹«±â'
				WHEN 3 THEN '¾ÆÀÌÅÛ'
				WHEN 4 THEN '¸Ó¸®'
				WHEN 5 THEN '°¡½¿'
				WHEN 6 THEN '¼Õ'
				WHEN 7 THEN '´Ù¸®'
				WHEN 8 THEN '¹ß'
				WHEN 9 THEN '¼Õ°¡¶ô'
			END AS Slot, 
			i.Name, i.ResSex, i.ResLevel, CashPrice, s.WebImgName
		FROM CashShop s(NOLOCK), Item i(NOLOCK) 
		WHERE s.ItemID=i.ItemID AND CSID=@CSID
	END
	ELSE
	BEGIN
		INSERT INTO CashShopNewItem (NewOrder, Category, IsSetItem, CSID, CSSID, Slot, Name, ResSex, ResLevel, CashPrice, WebImgName)
		SELECT @NewOrder AS NewOrder, '¼¼Æ®', @IsSetItem, NULL AS CSID, CSSID, '¼¼Æ®' AS Slot, Name, ResSex, ResLevel, CashPrice, WebImgName
		FROM CashSetShop(NOLOCK)
		WHERE CSSID=@CSSID
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spChangeCharName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Ä³¸¯ÅÍ ÀÌ¸§ º¯°æ
CREATE PROC [dbo].[spChangeCharName]
	@AID		int,
	@CID		int,
	@NewName	varchar(24)
AS
SET NOCOUNT ON
IF (LEN(@NewName) <= 0) OR (LEN(@NewName) > 12)
BEGIN
	SELECT 0 AS Ret
END

IF EXISTS (SELECT TOP 1 CID FROM Character where (Name=@NewName) AND (DeleteFlag=0))
BEGIN
	SELECT 0 AS Ret
	return (-1)
END

UPDATE Character SET Name=@NewName WHERE AID=@AID AND CID=@CID
IF 0 = @@ROWCOUNT BEGIN
	SELECT 0 AS Ret
	RETURN (-1)
END

SELECT 1 AS Ret
GO
/****** Object:  StoredProcedure [dbo].[spChangeGambleItemToRewardItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spChangeGambleItemToRewardItem]  
-- CREATE PROC dbo.spChangeGambleItemToRewardItem  
	@CID				INT
	, @CIID				INT
	, @GIID				INT
	, @GRIID			INT
	, @RewardItemID		INT
AS BEGIN

	SET NOCOUNT ON;

	DECLARE @RentHourPeriod		INT  
	DECLARE @GambleItemCount	INT;
	
	-----------------------------------------------------------------------------
			
	SELECT	@RentHourPeriod = ISNULL(RentHourPeriod, 0)
	FROM	GambleRewardItem gri(NOLOCK)  
	WHERE	GRIID = @GRIID
	AND		GIID = @GIID 
	AND		(ItemIDMale = @RewardItemID OR ItemIDFemale = @RewardItemID)  
	
	IF (0 = @@ROWCOUNT) BEGIN
		SELECT -1 AS 'Ret'  
		RETURN
	END
			
	SELECT	@GambleItemCount = ISNULL(Cnt, 1)
	FROM	CharacterItem(NOLOCK)
	WHERE	CIID = @CIID;
		
	-----------------------------------------------------------------------------
	
	DECLARE @NowDate	DATETIME;
	SET @NowDate = GETDATE();	
	
	-----------------------------------------------------------------------------
			
	BEGIN TRAN -----------  
	
		----------------------------------------------------------------------------------------
		
		IF( @GambleItemCount > 1 ) BEGIN
		
			UPDATE	CharacterItem 
			SET		Cnt = Cnt - 1
			WHERE	CID = @CID 
			AND		CIID = @CIID 
			
			IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN  
				ROLLBACK TRAN  
				SELECT -2 AS 'Ret'  
				RETURN
			END
			
		END
		ELSE BEGIN
		
			UPDATE	CharacterItem 
			SET		CID = NULL
			WHERE	CID = @CID 
			AND		CIID = @CIID
			
			IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN  
				ROLLBACK TRAN  
				SELECT -3 AS 'Ret'  
				RETURN
			END
			
		END
		
		---------------------------------------------------------------------------------------	
		
		INSERT CharacterItem(CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt)
		VALUES (@CID, @RewardItemID, @NowDate, @NowDate, @RentHourPeriod, 1)
		
		DECLARE @OrderCIID INT;			
		SET @OrderCIID = @@IDENTITY;
			
		IF (0 <> @@ERROR) BEGIN  
			ROLLBACK TRAN  
			SELECT -4 AS 'Ret'  
			RETURN
		END
			
			
		INSERT dbo.ItemChangeLog_CharacterItem(ChangeType, ChangeDate, CID, CIID, ItemID, [Count])
		VALUES (202, @NowDate, @CID, @CIID, @GIID, 1);	
		
		IF (0 <> @@ERROR) BEGIN  
			ROLLBACK TRAN  
			SELECT -5 AS 'Ret'  
			RETURN
		END

		INSERT dbo.ItemChangeLog_CharacterItem(ChangeType, ChangeDate, CID, CIID, ItemID, [Count])
		VALUES (102, @NowDate, @CID, @OrderCIID, @RewardItemID, 1);
		
		IF (0 <> @@ERROR) BEGIN  
			ROLLBACK TRAN  
			SELECT -6 AS 'Ret'  
			RETURN
		END

		INSERT INTO LogDB..GambleLog(CID, GIID, RewardItemID, RegDate)  
		VALUES (@CID, @GIID, @RewardItemID, @NowDate);
		
		IF (0 <> @@ERROR) BEGIN  
			ROLLBACK TRAN  
			SELECT -7 AS 'Ret'  
			RETURN
		END
		
		----------------------------------------------------------------------------------------

	COMMIT TRAN  -----------
		
	SELECT 0 AS 'Ret', @OrderCIID AS 'ORDERCIID'
END
GO
/****** Object:  StoredProcedure [dbo].[spCharUpdatePlayInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spCharUpdatePlayInfo]
(
	@AID INT
	, @CID INT
	, @XP INT
	, @Level INT
	, @TotalPlayTime INT
	, @PlayTime INT
	, @KillCount INT
	, @DeathCount INT
	, @BP INT
	, @IsLevelUp BIT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (GETDATE() BETWEEN '2009-05-26T19:00:00' AND '2009-06-26T19:00:00')
	BEGIN
		UPDATE dbo.EventCharacter
		SET PlayTime = PlayTime + @PlayTime, LastXP = @XP, LastLevel = @Level
		WHERE AID = @AID AND CID = @CID;
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spCheckDuplicateCharName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spCheckDuplicateCharName]   
 @Name varchar(24)  
as
 set nocount on  
 select top 1 cid from character(nolock) where name = @Name
GO
/****** Object:  StoredProcedure [dbo].[spCheckRegisteredUser]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[spCheckRegisteredUser]
	@UserID VARCHAR(20)
AS
BEGIN
 SET NOCOUNT ON
	DECLARE @AID INT

	SELECT @AID = AID FROM Account WHERE UserID = @UserID

	IF @@ERROR <> 0
	BEGIN
		RETURN	-- µðºñÀå¾Ö
	END

	IF @AID IS NULL
	BEGIN
		RETURN -1	-- ¹Ì°¡ÀÔÀÚ
	END
		select 1
	RETURN 1 -- °¡ÀÔÀÚ È®ÀÎ
END
GO
/****** Object:  StoredProcedure [dbo].[spClanUpdateEmblem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spClanUpdateEmblem]  
 @CLID   int,  
 @EmblemURL varchar(256)  
AS  
BEGIN  
 UPDATE Clan   
 SET EmblemURL=@EmblemURL, EmblemChecksum=EmblemChecksum+1  
 WHERE CLID=@CLID  
 RETURN 1  
END
GO
/****** Object:  StoredProcedure [dbo].[spClearAllEquipedItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spClearAllEquipedItem] 
-- ALTER PROC dbo.spClearAllEquipedItem 
	@CID  INT
AS BEGIN 

	SET NOCOUNT ON;

	UPDATE	CharacterEquipmentSlot
	SET		CIID = NULL, ItemID = NULL
	WHERE	CID = @CID;

END  
  
-------------------------------------------------------------------------------------------------------------------------
-- º¹±¸ Äõ¸®
/*
DROP PROC spClearAllEquipedItem
EXEC sp_rename 'BackUp_spClearAllEquipedItem', 'spClearAllEquipedItem';
*/
GO
/****** Object:  StoredProcedure [dbo].[spConfirmBuyCashItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ÀÏ¹Ý ¾ÆÀÌÅÛ ±¸¸Å°¡´ÉÀÎÁö È®ÀÎÇÏ±â */
CREATE PROC [dbo].[spConfirmBuyCashItem]
	@UserID								varchar(20),
	@CSID									int,
	@RetEnableBuyItem			int OUTPUT,
	@RetRepeatBuySameItem	int OUTPUT
AS
SET NoCount On
	
DECLARE @AID		int
DECLARE @ItemID	int
DECLARE @AIID		int


SELECT @AID = AID FROM Account(nolock) where UserID = @UserID
SELECT @ItemID = ItemID FROM CashShop(nolock) WHERE CSID=@CSID

IF @AID IS NULL
BEGIN
	SELECT @RetEnableBuyItem = 0
	SELECT @RetRepeatBuySameItem = 0
END
ELSE
BEGIN
	SELECT @RetEnableBuyItem = 1


	IF (@ItemID IS NOT NULL)
	BEGIN
		SELECT TOP 1 @AIID = AIID FROM AccountItem(nolock) WHERE AID=@AID AND ItemID=@ItemID
		IF (@AIID IS NOT NULL)
		BEGIN
			SELECT @RetRepeatBuySameItem = 1
		END
		ELSE
		BEGIN
			SELECT @RetRepeatBuySameItem = 0
		END
	END
	ELSE
	BEGIN
		SELECT @RetRepeatBuySameItem = 0
	END


END
GO
/****** Object:  StoredProcedure [dbo].[spConfirmBuyCashSetItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ¼¼Æ® ¾ÆÀÌÅÛ ±¸¸Å°¡´ÉÀÎÁö È®ÀÎÇÏ±â */
CREATE PROC [dbo].[spConfirmBuyCashSetItem]
	@UserID								varchar(20),
	@CSSID								int,
	@RetEnableBuyItem			int OUTPUT,
	@RetRepeatBuySameItem	int OUTPUT
AS
SET NoCount On
	
DECLARE @AID		int
DECLARE @SIL_ID	int
DECLARE @LAST_ID int

SELECT @AID = AID FROM Account(nolock) where UserID = @UserID


IF @AID IS NULL
BEGIN
	SELECT @RetEnableBuyItem = 0
	SELECT @RetRepeatBuySameItem = 0
END
ELSE
BEGIN
	SELECT @RetEnableBuyItem = 1

	SELECT TOP 1 @LAST_ID = id FROM SetItemPurchaseLogByCash spl(nolock) order by id desc

	SELECT TOP 1 @SIL_ID = id FROM SetItemPurchaseLogByCash spl(nolock) 
	WHERE id > (@LAST_ID-10000) AND AID=@AID AND CSSID=@CSSID

	IF (@SIL_ID IS NOT NULL)
	BEGIN
		SELECT @RetRepeatBuySameItem = 1
	END
	ELSE
	BEGIN
		SELECT @RetRepeatBuySameItem = 0
	END

END
GO
/****** Object:  StoredProcedure [dbo].[spConfirmExistClan]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Å¬·£ÀÌ Á¸ÀçÇÏ´ÂÁö È®ÀÎÇÏ±â
CREATE PROC [dbo].[spConfirmExistClan]
	@ClanName		varchar(24)
AS
	SET NOCOUNT ON
	SELECT COUNT(*) FROM Clan(NOLOCK) WHERE Name=@ClanName
GO
/****** Object:  StoredProcedure [dbo].[spCreateClan]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Å¬·£ »ý¼ºÇÏ±â
CREATE PROC [dbo].[spCreateClan]
	@ClanName		varchar(24),
	@MasterCID		int,
	@Member1CID		int,
	@Member2CID		int,
	@Member3CID		int,
	@Member4CID		int
AS
	DECLARE @NewCLID	int

	-- Å¬·£ÀÌ¸§ÀÌ Áßº¹ÀÎÁö °Ë»çÇØ¾ßÇÑ´Ù.
	SELECT @NewCLID=CLID FROM Clan(NOLOCK) WHERE Name=@ClanName

	IF @NewCLID IS NOT NULL
	BEGIN
		SELECT 0 AS Ret, 0 AS NewCLID
		RETURN
	END


	DECLARE @CNT		int

	-- Å¬·£¿øÀÌ ¸ðµÎ °¡ÀÔ °¡´ÉÇÑÁö °Ë»çÇØ¾ßÇÑ´Ù.
	SELECT @CNT = COUNT(*) FROM ClanMember cm(NOLOCK), Character c(NOLOCK) WHERE ((cm.CID=@MasterCID) OR (cm.CID=@Member1CID) OR (cm.CID=@Member2CID) OR (cm.CID=@Member3CID) OR
(cm.CID=@Member4CID) ) AND cm.CID=c.CID AND c.DeleteFlag=0

	IF @CNT != 0
	BEGIN
		SELECT 0 AS Ret, 0 AS NewCLID
		RETURN
	END


	BEGIN TRAN
	-- Å¬·£ »ý¼º
	INSERT INTO Clan (Name, MasterCID, RegDate) VALUES (@ClanName, @MasterCID, GETDATE())
	IF 0 <> @@ERROR BEGIN
		ROLLBACK TRAN
		SELECT 0 AS Ret, 0 AS NewCLID
		RETURN
	END

	SELECT @NewCLID = @@IDENTITY
	IF (@NewCLID IS not NULL)
	BEGIN
		DECLARE @Err1 int
		DECLARE @Err2 int
		DECLARE @Err3 int
		DECLARE @Err4 int
		DECLARE @Err5 int

		-- Å¬·£¿ø °¡ÀÔ
		INSERT INTO ClanMember (CLID, CID, Grade, RegDate) VALUES (@NewCLID, @MasterCID, 1, GETDATE())
		SET @Err1 = @@ERROR		
		INSERT INTO ClanMember (CLID, CID, Grade, RegDate) VALUES (@NewCLID, @Member1CID, 9, GETDATE())
		SET @Err2 = @@ERROR
		INSERT INTO ClanMember (CLID, CID, Grade, RegDate) VALUES (@NewCLID, @Member2CID, 9, GETDATE())
		SET @Err3 = @@ERROR
		INSERT INTO ClanMember (CLID, CID, Grade, RegDate) VALUES (@NewCLID, @Member3CID, 9, GETDATE())
		SET @Err4 = @@ERROR
		INSERT INTO ClanMember (CLID, CID, Grade, RegDate) VALUES (@NewCLID, @Member4CID, 9, GETDATE())
		SET @Err5 = @@ERROR

		IF (0 <> @Err1) OR (0 <> @Err2) OR (0 <> @Err3) OR (0 <> @Err4) OR (0 <> @Err5) BEGIN
			ROLLBACK TRAN
			SELECT 0 AS Ret, 0 AS NewCLID
			RETURN
		END
	END
	COMMIT TRAN

	-- ¸¶½ºÅÍ ¹Ù¿îÆ¼ »èÁ¦
	--UPDATE Character SET BP=BP-1000 WHERE CID=@MasterCID


	SELECT 1 AS Ret, @NewCLID AS NewCLID
GO
/****** Object:  StoredProcedure [dbo].[spDeleteChar]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spDeleteChar]    
 @AID  int,    
 @CharNum smallint,    
 @CharName varchar(24)    
AS    
BEGIN
SET NOCOUNT ON

DECLARE @CID  int    
    
SELECT @CID=CID FROM Character WITH (nolock) WHERE AID=@AID and CharNum=@CharNum    
IF (@CID IS NULL)    
BEGIN    
 return (-1)    
END    

IF EXISTS(SELECT * FROM CharacterItem(NOLOCK) WHERE CID = @CID AND ItemID >= 500000)
BEGIN
 RETURN (-1)
END

IF EXISTS(SELECT * FROM Clan(NOLOCK) WHERE MasterCID = @CID)
BEGIN
 RETURN (-1)
END

IF EXISTS(SELECT * FROM ClanMember(NOLOCK) WHERE CID = @CID)
BEGIN
 RETURN (-1)
END

BEGIN TRAN  
  
UPDATE Character SET CharNum = -1, DeleteFlag = 1, Name='', DeleteName=@CharName    
WHERE AID=@AID AND CharNum=@CharNum AND Name=@CharName    
IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN  
 ROLLBACK TRAN  
 RETURN (-1)  
END  
  
INSERT INTO CharacterMakingLog(AID, CharName, Type, Date)  
VALUES(@AID, @CharName, 'delete', GETDATE())  
IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN  
 ROLLBACK TRAN  
 RETURN (-1)   
END  

UPDATE Friend
SET DeleteFlag = 1
WHERE CID = @CID OR FriendCID = @CID
IF (0 <> @@ERROR)
BEGIN
 ROLLBACK TRAN
 RETURN (-1)
END

IF (GETDATE() < '2009-06-29T07:00:00')
BEGIN
	UPDATE dbo.EventCharacter
	SET DeleteFlag = 1
	WHERE AID = @AID AND CID = @CID;
	IF (0 <> @@ERROR)
	BEGIN
		ROLLBACK TRAN;
		RETURN (-1);
	END
END
    
COMMIT TRAN  
SELECT 1 AS Ret    
END
GO
/****** Object:  StoredProcedure [dbo].[spDeleteChar_orig]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Ä³¸¯ÅÍ »èÁ¦ */
CREATE PROC [dbo].[spDeleteChar_orig]
	@AID		int,
	@CharNum	smallint,
	@CharName	varchar(24)
AS
SET NOCOUNT ON
DECLARE @CID		int
DECLARE @CashItemCount	int

SELECT @CID=CID FROM Character WITH (nolock) WHERE AID=@AID and CharNum=@CharNum
IF (@CID IS NULL)
BEGIN
	return (-1)
END

SELECT @CashItemCount=COUNT(*) FROM CharacterItem(nolock) WHERE CID=@CID AND ItemID>=500000

IF (@CashItemCount > 0) OR
   (EXISTS (SELECT TOP 1 CLID FROM ClanMember WHERE CID=@CID))
BEGIN
	return (-1)
END

UPDATE Character SET CharNum = -1, DeleteFlag = 1, Name='', DeleteName=@CharName
WHERE AID=@AID AND CharNum=@CharNum AND Name=@CharName


SELECT 1 AS Ret
GO
/****** Object:  StoredProcedure [dbo].[spDeleteCharItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Ä³¸¯ÅÍ ¾ÆÀÌÅÛ »èÁ¦ */
CREATE PROC [dbo].[spDeleteCharItem]
	@CID		int,
	@CIID		int
AS
SET NOCOUNT ON

UPDATE CharacterItem SET CID=NULL
WHERE CID=@CID AND CIID=@CIID

/* ¿¹Àü²¨
DELETE FROM CharacterItem 
WHERE CID=@CID AND CIID=@CIID
*/
GO
/****** Object:  StoredProcedure [dbo].[spDeleteClan]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Å¬·£ »èÁ¦ÇÏ±â
CREATE PROC [dbo].[spDeleteClan]
	@CLID		int,
	@ClanName	varchar(24)

AS
	SET NOCOUNT ON
	-- Å¬·£¿ø ¸ðµÎ »èÁ¦
	DELETE FROM ClanMember WHERE CLID=@CLID

	-- Å¬·£ »èÁ¦
	UPDATE Clan SET Name=NULL, DeleteFlag=1, DeleteName=@ClanName WHERE CLID=@CLID
GO
/****** Object:  StoredProcedure [dbo].[spDeleteExpiredAccountItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spDeleteExpiredAccountItem]
-- ALTER PROC dbo.spDeleteExpiredAccountItem
	@AID		INT
	, @AIID		INT
AS BEGIN
	
	SET NOCOUNT ON;

	DECLARE @ItemID		INT;
	DECLARE @ItemCnt	INT;
	DECLARE @DateDiff	INT;
		
	SELECT	@ItemID = ItemID, @ItemCnt = ISNULL(Cnt, 1),
			@DateDiff = (RentHourPeriod * 60) - (DateDiff(n, RentDate, GETDATE()))
	FROM	AccountItem
	WHERE	AIID = @AIID
	AND		AID = @AID;
	
	DELETE AccountItem WHERE AIID = @AIID
	
	SELECT 0 AS 'Ret'
END
GO
/****** Object:  StoredProcedure [dbo].[spDeleteExpiredCharacterItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------------------------------------------------------------------
-- ÀÛ¾÷ÇÒ Äõ¸®

CREATE PROC [dbo].[spDeleteExpiredCharacterItem]
-- ALTER PROC dbo.spDeleteExpiredCharacterItem
	@CID	INT,
	@CIID	INT
AS BEGIN

	SET NOCOUNT ON;

	DECLARE @ItemID		INT;
	DECLARE @ItemCnt	INT;
	DECLARE @DateDiff	INT;
		
	SELECT	@ItemID = ItemID, @ItemCnt = ISNULL(Cnt, 1)
			, @DateDiff = (RentHourPeriod * 60) - (DateDiff(n, RentDate, GETDATE()))
	FROM	CharacterItem
	WHERE	CIID = @CIID
	AND		CID = @CID;
	
	IF ( @ItemCnt < 1 ) BEGIN
		SELECT -1 AS 'Ret'
		RETURN;
	END
	
	IF ( @DateDiff > 0 ) BEGIN
		SELECT -2 AS 'Ret'
		RETURN;
	END
	
	
	UPDATE	CharacterItem 
	SET		CID = NULL 
	WHERE	CIID = @CIID
	AND		CID = @CID;
		
	IF (@@ERROR <> 0) OR (@@ROWCOUNT = 0) BEGIN
		SELECT -3 AS 'Ret'
		RETURN;
	END		
			
	SELECT 0 AS 'Ret'	
END
GO
/****** Object:  StoredProcedure [dbo].[spDTFetchDTRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDTFetchDTRanking]	
AS BEGIN  

	SET NOCOUNT ON;

    ------------------------------------------------------------------------------------------------------------- 

	DECLARE @CurTimeStamp CHAR(8);  
	DECLARE @CurTimeStampIndex INT;
	
	DECLARE @PreTimeStamp CHAR(8);  
	DECLARE @PreTimeStampIndex INT;
			
	SELECT TOP 1 @CurTimeStamp = ts.TimeStamp, @CurTimeStampIndex = ts.ID  
	FROM DTTimeStamp ts WITH (NOLOCK)
	ORDER BY ts.TimeStamp DESC;
	
	SELECT @PreTimeStamp = TimeStamp 
	FROM DTTimeStamp 
	WHERE ID = @CurTimeStampIndex - 1;
	
	DECLARE @Closed TINYINT;
	SELECT @Closed = Closed FROM DTTimeStamp WHERE TimeStamp = @PreTimeStamp;

    ------------------------------------------------------------------------------------------------------------

	--과거의 TimeStamp의 랭킹 계산도 해주자!
	IF( @Closed = 0 ) BEGIN	

		UPDATE DTTimeStamp SET Closed = Closed + 1 WHERE TimeStamp = @PreTimeStamp;
		
		-- 일단 랭킹 계산 테이블의 모든 데이터를 지우고...  
		TRUNCATE TABLE DTCharacterRanking;		

        INSERT DTCharacterRanking(CID, TimeStamp, TP, FinalWins, Wins, Loses, PreGrade)  
	        SELECT  CI.CID, CI.TimeStamp, CI.TP, CI.FinalWins, CI.Wins, CI.Loses, CI.PreGrade  
	        FROM    DTCharacterInfo CI(NOLOCK) 
                    JOIN Character C(NOLOCK) 
                    ON C.CID = CI.CID
	        WHERE   CI.TimeStamp = @PreTimeStamp    
            AND     C.DeleteFlag = 0
	        ORDER BY CI.TP DESC, CI.FinalWins DESC, CI.SFinalWins DESC, CI.QFinalWins DESC
		

		-- 듀얼토너먼트 케릭터 정보 업데이트 해주고..
		UPDATE  ci  
		SET     ci.RankingIncrease = CASE WHEN ci.Ranking = -1 THEN -1 ELSE ci.Ranking - cr.Rank END  
			    , ci.Ranking  = cr.Rank
		FROM    DTCharacterInfo ci 
                JOIN DTCharacterRanking cr 
                ON ci.CID = cr.CID  
		WHERE   ci.CID = cr.CID 
        AND     ci.TimeStamp = @PreTimeStamp;  

		-- 랭킹 계산 테이블에 랭킹 변동치를 다시 업데이트 해준다.  
		UPDATE  cr  
		SET     cr.RankingIncrease = ci.RankingIncrease  
		FROM    DTCharacterRanking cr 
                JOIN DTCharacterInfo ci 
                ON ci.CID = cr.CID  
		WHERE   ci.CID = cr.CID 
        AND     ci.TimeStamp = @PreTimeStamp; 
		
		-- RankingHistory 테이블에 데이터 삽입!
		DELETE DTCharacterRankingHistory WHERE TimeStamp = @PreTimeStamp;
		
		DECLARE @UserCount INT;
		SELECT @UserCount = COUNT(*) FROM DTCharacterInfo WHERE TimeStamp = @PreTimeStamp;
	
		UPDATE  ci
		SET     ci.PreGrade = CASE  WHEN (cr.TP <= 1000) THEN 10
					WHEN ((cr.Rank * 100) / @UserCount <= 4 )   THEN 1
					WHEN ((cr.Rank * 100) / @UserCount <= 11 )  THEN 2
					WHEN ((cr.Rank * 100) / @UserCount <= 23 )  THEN 3
					WHEN ((cr.Rank * 100) / @UserCount <= 40 )  THEN 4
					WHEN ((cr.Rank * 100) / @UserCount <= 60 )  THEN 5
					WHEN ((cr.Rank * 100) / @UserCount <= 77 )  THEN 6
					WHEN ((cr.Rank * 100) / @UserCount <= 89 )  THEN 7
					WHEN ((cr.Rank * 100) / @UserCount <= 96 )  THEN 8
					WHEN ((cr.Rank * 100) / @UserCount <= 100 ) THEN 9
					ELSE 10 END
		FROM    DTCharacterInfo ci, DTCharacterRanking cr
		WHERE   ci.TimeStamp = @CurTimeStamp 
        AND     cr.TimeStamp = @PreTimeStamp
        AND     ci.CID = cr.CID;
		
		INSERT DTCharacterRankingHistory(TimeStamp, Rank, CID, Name, TP, FinalWins, Wins, Loses, Grade)
			SELECT TOP 100 cr.TimeStamp
						, cr.Rank
						, cr.CID
                        , CASE  WHEN c.DeleteFlag = 0 THEN c.Name ELSE c.DeleteName END AS Name
						, cr.TP
						, cr.FinalWins
						, cr.Wins
						, cr.Loses
						, CASE  WHEN (cr.TP <= 1000) THEN 10	
								WHEN (((cr.Rank * 100) / @UserCount) <= 4 )    THEN 1 
								WHEN (((cr.Rank * 100) / @UserCount) <= 11 )   THEN 2
								WHEN (((cr.Rank * 100) / @UserCount) <= 23 )   THEN 3 
								WHEN (((cr.Rank * 100) / @UserCount) <= 40 )   THEN 4 
								WHEN (((cr.Rank * 100) / @UserCount) <= 60 )   THEN 5 
								WHEN (((cr.Rank * 100) / @UserCount) <= 77 )   THEN 6 
								WHEN (((cr.Rank * 100) / @UserCount) <= 89 )   THEN 7 
								WHEN (((cr.Rank * 100) / @UserCount) <= 96 )   THEN 8 
								WHEN (((cr.Rank * 100) / @UserCount) <= 100 )  THEN 9 								
								ELSE 10 END		
			FROM    DTCharacterRanking cr(NOLOCK)
                    JOIN Character C(NOLOCK)
                    ON cr.CID = C.CID
			WHERE   cr.TimeStamp = @PreTimeStamp
			ORDER BY cr.Rank;
	END
	   

------------------------------------------------------------------------------------------------------------
	-- 일단 랭킹 계산 테이블의 모든 데이터를 지우고...  
	TRUNCATE TABLE DTCharacterRanking;
	   
	-- 랭킹 계산 테이블에 모두 집어넣고..  
	INSERT DTCharacterRanking(CID, TimeStamp, TP, FinalWins, Wins, Loses, PreGrade)  
		SELECT  CI.CID, CI.TimeStamp, CI.TP, CI.FinalWins, CI.Wins, CI.Loses, CI.PreGrade  
		FROM    DTCharacterInfo CI(NOLOCK) 
                JOIN Character C(NOLOCK) 
                ON C.CID = CI.CID
		WHERE   CI.TimeStamp = @CurTimeStamp    
        AND     C.DeleteFlag = 0
		ORDER BY CI.TP DESC, CI.FinalWins DESC, CI.SFinalWins DESC, CI.QFinalWins DESC  
	    
	-- 듀얼토너먼트 케릭터 정보 업데이트 해주고..  
	UPDATE  ci  
	SET     ci.RankingIncrease = CASE WHEN ci.Ranking = -1 THEN 1000000000 ELSE ci.Ranking - cr.Rank END  
		    , ci.Ranking = cr.Rank  
	FROM    DTCharacterInfo ci 
            JOIN DTCharacterRanking cr 
            ON ci.CID = cr.CID  
	WHERE   ci.CID = cr.CID 
    AND     ci.TimeStamp = @CurTimeStamp;  

	-- 랭킹 계산 테이블에 랭킹 변동치를 다시 업데이트 해준다.  
	UPDATE  cr  
	SET     cr.RankingIncrease = ci.RankingIncrease  
	FROM    DTCharacterRanking cr 
            JOIN DTCharacterInfo ci 
            ON  ci.CID = cr.CID  
	WHERE   ci.CID = cr.CID 
    AND     ci.TimeStamp = @CurTimeStamp;  
------------------------------------------------------------------------------------------------------------
END
GO
/****** Object:  StoredProcedure [dbo].[spDTGetDTCharacterInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDTGetDTCharacterInfo]
	@CID INT
AS BEGIN	
	SET NOCOUNT ON;
	
	DECLARE @TimeStamp CHAR(8);
	
	SELECT TOP 1 @TimeStamp = ts.TimeStamp 
	FROM DTTimeStamp ts WITH (NOLOCK) 
	ORDER BY TimeStamp DESC; 
   	
	SELECT * 
	FROM DTCharacterInfo dc WITH (NOLOCK) 
	WHERE dc.CID = @CID AND dc.TimeStamp = @TimeStamp;
END
GO
/****** Object:  StoredProcedure [dbo].[spDTGetDTCharacterInfoPrevious]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDTGetDTCharacterInfoPrevious]
	@CID				INT
AS BEGIN  
	SET NOCOUNT ON;
	
	DECLARE @TimeStampIndex INT;
	DECLARE @TimeStamp CHAR(8);	
	DECLARE @PreTimeStamp CHAR(8);	
	
	SELECT TOP 1 @TimeStampIndex = ts.ID, @TimeStamp = ts.TimeStamp 
	FROM DTTimeStamp ts(NOLOCK) 
	ORDER BY ts.TimeStamp DESC;
	
	SELECT @PreTimeStamp = TimeStamp 
	FROM DTTimeStamp 
	WHERE ID = @TimeStampIndex - 1;
   	
	SELECT dc.TP, dc.Wins, dc.Loses, dc.Ranking, dc.FinalWins
	FROM DTCharacterInfo dc WITH (NOLOCK)
	WHERE dc.CID = @CID AND dc.TimeStamp = @PreTimeStamp;
END
GO
/****** Object:  StoredProcedure [dbo].[spDTGetDTGroupRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDTGetDTGroupRanking]
AS BEGIN
	SET NOCOUNT ON;
	
	DECLARE @ShowCount INT;
	SET @ShowCount = 100;
	
	SELECT c.Name, t.TP, t.Wins, t.Loses, t.FinalWins, t.Rank, t.RankingIncrease, t.PreGrade
	FROM
	(
		SELECT cr.CID, cr.TP, ci.Wins, ci.Loses, ci.FinalWins, cr.Rank, ci.RankingIncrease, ci.PreGrade
		FROM DTCharacterRanking cr WITH (NOLOCK), DTCharacterInfo ci WITH (NOLOCK)
		WHERE cr.CID = ci.CID
			AND cr.Rank > 0
			AND cr.Rank <= @ShowCount
	) t, Character c WITH (NOLOCK)
	WHERE t.CID = c.CID
	ORDER BY t.Rank
END
GO
/****** Object:  StoredProcedure [dbo].[spDTGetDTSideRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDTGetDTSideRanking]
	@CID	INT
AS BEGIN
	SET NOCOUNT ON;
-----------------------------------------------------------------

	DECLARE @CurRank	INT;
	DECLARE @TotalUser	INT;
	DECLARE @TimeStamp	CHAR(8);
	
	SELECT TOP 1 @TimeStamp = ts.TimeStamp 
	FROM DTTimeStamp ts WITH (NOLOCK) 
	ORDER BY ts.TimeStamp DESC;
	
	SELECT @CurRank = cr.Rank 
	FROM DTCharacterRanking cr (NOLOCK) 
	WHERE cr.CID = @CID;
	
	SELECT @TotalUser = COUNT(*) 
	FROM DTCharacterRanking cr (NOLOCK) 
	
-----------------------------------------------------------------	

	DECLARE @FactorA INT;
	DECLARE @FactorB INT;

	IF( @CurRank = 1 ) BEGIN
		SET @FactorA = 0;
		SET @FactorB = 4;
	END	ELSE IF( @CurRank = 2 ) BEGIN 
		SET @FactorA = 1;
		SET @FactorB = 3;
	END	ELSE IF( @CurRank - 1 = @TotalUser) BEGIN
		SET @FactorA = 4;
		SET @FactorB = 1;
	END	ELSE IF( @CurRank = @TotalUser ) BEGIN
		SET @FactorA = 4;
		SET @FactorB = 0;
	END ELSE IF( @CurRank IS NULL ) BEGIN
		SET @CurRank = 3;
		SET @FactorA = 2;
		SET @FactorB = 2;		
	END ELSE BEGIN
		SET @FactorA = 2;
		SET @FactorB = 2;

	END
	
-----------------------------------------------------------------

	SELECT c.Name, t.TP, t.Wins, t.Loses, t.FinalWins, t.Rank, t.RankingIncrease, t.PreGrade
	FROM
	(
		SELECT cr.CID, cr.TP, cr.Wins, cr.Loses, cr.FinalWins, cr.Rank, cr.RankingIncrease, cr.PreGrade
		FROM DTCharacterRanking cr WITH (NOLOCK)
		WHERE cr.Rank > 0
			AND cr.Rank BETWEEN @CurRank - @FactorA AND @CurRank + @FactorB
	) t, Character c WITH (NOLOCK)
	WHERE t.CID = c.CID
		AND c.DeleteFlag = 0
	ORDER BY t.Rank
	
-----------------------------------------------------------------
END
GO
/****** Object:  StoredProcedure [dbo].[spDTGetDTTimeStamp]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDTGetDTTimeStamp]
AS BEGIN
	SET NOCOUNT ON;
	
	SELECT TOP 1 TimeStamp 
	FROM DTTimeStamp(NOLOCK) 
	ORDER BY TimeStamp DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[spDTInsertDTCharacterInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDTInsertDTCharacterInfo]  
	@CID INT  
AS BEGIN  
	SET NOCOUNT ON;
	
	DECLARE @BasicTP INT;		
	DECLARE @TimeStampIndex INT;
	DECLARE @TimeStamp CHAR(8);	
	
	SET @BasicTP = 1000;
	
	SELECT TOP 1 @TimeStampIndex = ts.ID, @TimeStamp = ts.TimeStamp 
	FROM DTTimeStamp ts WITH (NOLOCK) 
	ORDER BY TimeStamp DESC;
	
	----------------------------------------------------------------------------------
	-- 전주 랭킹에 대한 Grade 구하기	
	--  1등급 상위 4%,  2등급 상위 11%, 3등급 상위 23%, 4등급 상위 40%,  5등급 상위 60% 
	--	6등급 상위 77%,	7등급 상위 89%,	8등급 상위 96%,	9등급 상위 100%, 10등급 상위 천점이하
	
	DECLARE @Grade INT;	
	DECLARE @PreTP INT;
	DECLARE @PreRank INT;
	DECLARE @TotalUser INT;
	DECLARE @PreTimeStamp CHAR(8);	
	
	SELECT @PreTimeStamp = ts.TimeStamp, @TotalUser = ts.TotalUser 
	FROM DTTimeStamp ts WITH (NOLOCK) 
	WHERE ts.ID = @TimeStampIndex - 1 AND ts.TimeStamp < @TimeStamp;
	
	SELECT @PreRank = ci.Ranking, @PreTP = ci.TP
	FROM DTCharacterInfo ci WITH (NOLOCK) 
	WHERE ci.CID = @CID AND ci.TimeStamp = @PreTimeStamp;

	IF( @PreRank IS NOT NULL AND @TotalUser IS NOT NULL) BEGIN
		IF( @PreTP <= 1000 ) SET @Grade = 10;
		ELSE BEGIN
			SET @Grade = (@PreRank * 100) / @TotalUser;
			IF( @Grade <= 4 )			SET @Grade = 1;
			ELSE IF( @Grade <= 11 )		SET @Grade = 2;
			ELSE IF( @Grade <= 23 )		SET @Grade = 3;
			ELSE IF( @Grade <= 40 )		SET @Grade = 4;
			ELSE IF( @Grade <= 60 )		SET @Grade = 5;
			ELSE IF( @Grade <= 77 )		SET @Grade = 6;
			ELSE IF( @Grade <= 89 )		SET @Grade = 7;
			ELSE IF( @Grade <= 96 )		SET @Grade = 8;
			ELSE IF( @Grade <= 100 )	SET @Grade = 9;			
		END
	END	
	ELSE SET @Grade = 10;
----------------------------------------------------------------------------------   
	INSERT INTO DTCharacterInfo   
	VALUES(@TimeStamp, @CID, @BasicTP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, @Grade);	
END
GO
/****** Object:  StoredProcedure [dbo].[spDTInsertDTGameLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDTInsertDTGameLog]
	@TournamentType TINYINT, @MatchFactor TINYINT,
	@Player1 INT,	@Player2 INT,	@Player3 INT,	@Player4 INT,	
	@Player5 INT,	@Player6 INT,	@Player7 INT,	@Player8 INT
AS BEGIN
	SET NOCOUNT ON;
	
	DECLARE @TimeStamp CHAR(8);   	
	
	SELECT TOP 1 @TimeStamp = ts.TimeStamp 
	FROM DTTimeStamp ts(NOLOCK) 
	ORDER BY ts.TimeStamp DESC; 
   	
	INSERT dbo.DTGameLog(TimeStamp, TournamentType, StartTime, MatchFactor, Player1CID, Player2CID, Player3CID, Player4CID, Player5CID, Player6CID, Player7CID, Player8CID)
	VALUES(@TimeStamp, @TournamentType, GETDATE(), @MatchFactor, @Player1, @Player2, @Player3, @Player4, @Player5, @Player6, @Player7, @Player8);
	
	SELECT @@IDENTITY AS LogID, @TimeStamp AS TimeStamp;
END
GO
/****** Object:  StoredProcedure [dbo].[spDTInsertDTGameLogDetail]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDTInsertDTGameLogDetail]
	@LogID		INT,
	@TimeStamp	CHAR(8),
	@MatchType	TINYINT,
	@PlayTime	INT,
	@WinnerCID	INT,
	@GainTP		INT,
	@LoserCID	INT,
	@LoseTP		INT
AS BEGIN
	SET NOCOUNT ON;
	
	INSERT INTO dbo.DTGameLogDetail
	VALUES(@TimeStamp, @LogID
		, DATEADD(ss, -@PlayTime, GETDATE()), @PlayTime, @MatchType
		, @WinnerCID, @LoserCID, @GainTP, @LoseTP);
END
GO
/****** Object:  StoredProcedure [dbo].[spDTInsertDTTimeStamp]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDTInsertDTTimeStamp]
	@StampType TINYINT
AS BEGIN	
	SET NOCOUNT ON;
	
	DECLARE @TimeStamp CHAR(8);
	DECLARE @CurTimeStamp CHAR(8);
	DECLARE @TotalUser INT;
	DECLARE @RowID INT;

	IF( @StampType = 0 ) BEGIN		-- Daily
		SELECT @CurTimeStamp = CONVERT( CHAR(8), GETDATE(), 112);
	END ELSE IF( @StampType = 1 ) BEGIN -- Weekly
		SELECT @CurTimeStamp = CONVERT( CHAR(8), DATEADD(dd, DATEPART(WEEKDAY, CONVERT(DATETIME, GETDATE()))*(-1)+2, CONVERT(DATETIME, GETDATE())), 112);
	END ELSE BEGIN
		RETURN;
	END
	
	SELECT TOP 1 @TimeStamp = TimeStamp, @RowID = ID + 1
	FROM DTTimeStamp(NOLOCK)
	ORDER BY TimeStamp DESC;
	
	IF( @TimeStamp IS NULL ) BEGIN
		INSERT INTO DTTimeStamp(ID, TimeStamp, Closed) VALUES(1, @CurTimeStamp, 0);
		RETURN;
	END
	
	IF( @TimeStamp != @CurTimeStamp ) BEGIN
		SELECT @TotalUser = COUNT(ci.CID) 
		FROM DTCharacterInfo ci(NOLOCK) 
		WHERE ci.TimeStamp = @TimeStamp;
		
		UPDATE DTTimeStamp
		SET TotalUser = @TotalUser
		WHERE TimeStamp = @TimeStamp;
		
		INSERT INTO DTTimeStamp(ID, TimeStamp, Closed) VALUES(@RowID, @CurTimeStamp, 0)
	END	
END
GO
/****** Object:  StoredProcedure [dbo].[spDTUpdateDTCharacterInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDTUpdateDTCharacterInfo]
	@CID			INT,
	@TimeStamp		CHAR(8),
	@TP				INT,
	@Wins			INT,
	@Loses			INT,
	@FGames			INT,
	@FWins			INT,
	@SFGames		INT,
	@SFWins			INT,
	@QFGames		INT,
	@QFWins			INT,
	@LeaveCount		INT
AS BEGIN  
	SET NOCOUNT ON;
	
	UPDATE dbo.DTCharacterInfo
	SET TP = @TP
		, Wins			= @Wins
		, Loses			= @Loses
		, FinalGames	= @FGames
		, FinalWins		= @FWins
		, SFinalGames	= @SFGames
		, SFinalWins	= @SFWins
		, QFinalGames	= @QFGames
		, QFinalWins	= @QFWins
		, LeaveCount	= @LeaveCount
	WHERE CID = @CID AND TimeStamp = @TimeStamp
END
GO
/****** Object:  StoredProcedure [dbo].[spDTUpdateDTGameLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDTUpdateDTGameLog]
	@TimeStamp	CHAR(8),
	@LogID		INT,	
	@ChampCID	INT	
AS BEGIN
	SET NOCOUNT ON;
	
	UPDATE DTGameLog
	SET ChampCID = @ChampCID, EndTime = GETDATE()
	WHERE LogID = @LogID AND TimeStamp = @TimeSTamp
END
GO
/****** Object:  StoredProcedure [dbo].[spEventColiseum_FetchDailyRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spEventColiseum_FetchDailyRanking]
-- ALTER PROC dbo.spEventColiseum_FetchDailyRanking
	@TargetDate		DATETIME
AS BEGIN

	SET NOCOUNT ON;
	
	DECLARE @DateTag CHAR(10);	
	-- SELECT @DateTag = CONVERT( CHAR(8), DATEADD(dd, DATEPART(WEEKDAY, CONVERT(DATETIME, @TargetDate))*(-1)+4, @TargetDate), 112);
	SELECT @DateTag = CONVERT( CHAR(8), @TargetDate, 112) + '_D';
	
	--------------------------------------------------------------------------------------------------
		
	DELETE Event_Coliseum_KillsRanking_NHN		WHERE [DateTag] = @DateTag;
	DELETE Event_Coliseum_DeathsRanking_NHN		WHERE [DateTag] = @DateTag;
	DELETE Event_Coliseum_PlayTimeRanking_NHN	WHERE [DateTag] = @DateTag;
		
	--------------------------------------------------------------------------------------------------	
	
	INSERT Event_Coliseum_KillsRanking_NHN([Rank], [DateTag], CID)
		SELECT	ROW_NUMBER() OVER (ORDER BY (CAST(Kills AS FLOAT)/ CAST(PlayTime AS FLOAT)) DESC, PlayTime ASC) AS [Rank]
				, [DateTag], CID
		FROM	dbo.Event_Coliseum_PlayData_NHN
		WHERE	[DateTag] = @DateTag
		
	INSERT Event_Coliseum_DeathsRanking_NHN([Rank], [DateTag], CID)
		SELECT	ROW_NUMBER() OVER (ORDER BY (CAST(Deaths AS FLOAT)/ CAST(PlayTime AS FLOAT)) ASC, PlayTime ASC) AS [Rank]
				, [DateTag], CID
		FROM	dbo.Event_Coliseum_PlayData_NHN
		WHERE	[DateTag] = @DateTag
		
	INSERT Event_Coliseum_PlayTimeRanking_NHN([Rank], [DateTag], CID)
		SELECT	ROW_NUMBER() OVER (ORDER BY PlayTime DESC) AS [Rank]
				, [DateTag], CID
		FROM	dbo.Event_Coliseum_PlayData_NHN
		WHERE	[DateTag] = @DateTag
	
	--------------------------------------------------------------------------------------------------			
	
	UPDATE	ed
	SET		ed.KillRank = er.[Rank]
	FROM	Event_Coliseum_KillsRanking_NHN er, Event_Coliseum_PlayData_NHN ed
	WHERE	er.CID = ed.CID
	AND		er.[DateTag] = @DateTag
	AND		er.[DateTag] = ed.[DateTag]
	
	UPDATE	ed
	SET		ed.DeathRank = er.[Rank]
	FROM	Event_Coliseum_DeathsRanking_NHN er, Event_Coliseum_PlayData_NHN ed
	WHERE	er.CID = ed.CID
	AND		er.[DateTag] = @DateTag
	AND		er.[DateTag] = ed.[DateTag]
	
	
	UPDATE	ed
	SET		ed.PlayTimeRank = er.[Rank]
	FROM	Event_Coliseum_PlayTimeRanking_NHN er, Event_Coliseum_PlayData_NHN ed
	WHERE	er.CID = ed.CID
	AND		er.[DateTag] = @DateTag
	AND		er.[DateTag] = ed.[DateTag]
	
	--------------------------------------------------------------------------------------------------
END
GO
/****** Object:  StoredProcedure [dbo].[spEventColiseum_FetchWeeklyRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spEventColiseum_FetchWeeklyRanking]
-- ALTER PROC dbo.spEventColiseum_FetchWeeklyRanking
	@TargetWeekDate		DATETIME
AS BEGIN

	SET NOCOUNT ON;
	
	DECLARE @DateTag		DATETIME;
	DECLARE @PreDateTag		CHAR(10);
	DECLARE @CurDateTag		CHAR(10);
	DECLARE @StartDateTag	CHAR(10);
	DECLARE @EndDateTag		CHAR(10);
	
	SELECT	@DateTag = CASE WHEN DATEPART(WEEKDAY, CONVERT(DATETIME, @TargetWeekDate)) < 5
							THEN DATEADD(dd, DATEPART(WEEKDAY, CONVERT(DATETIME, @TargetWeekDate)) * (-1) + 4, @TargetWeekDate)
							ELSE DATEADD(dd, 11 - DATEPART(WEEKDAY, CONVERT(DATETIME, @TargetWeekDate)), @TargetWeekDate)
						END
	
	SELECT	@StartDateTag = CONVERT( CHAR(8), DATEADD(dd, -6, @DateTag), 112) + '_D'
			, @EndDateTag = CONVERT( CHAR(8), @DateTag, 112) + '_D'
			, @PreDateTag = CONVERT( CHAR(8), DATEADD(dd, -6, @DateTag), 112) + '_W'
			, @CurDateTag = CONVERT( CHAR(8), @DateTag, 112) + '_W'
	--------------------------------------------------------------------------------------------------
	
	DELETE dbo.Event_Coliseum_PlayData_NHN			WHERE [DateTag] = @CurDateTag;
	DELETE dbo.Event_Coliseum_KillsRanking_NHN		WHERE [DateTag] = @CurDateTag;
	DELETE dbo.Event_Coliseum_DeathsRanking_NHN		WHERE [DateTag] = @CurDateTag;
	DELETE dbo.Event_Coliseum_PlayTimeRanking_NHN	WHERE [DateTag] = @CurDateTag;
		
	--------------------------------------------------------------------------------------------------	
	
	INSERT dbo.Event_Coliseum_PlayData_NHN([DateTag], CID, PlayTime, Kills, Deaths, LastUpdatedDate)
		SELECT	@CurDateTag AS [DateTag], CID
				, SUM(PlayTime) AS PlayTime, SUM(Kills) AS Kills, SUM(Deaths) AS Deaths
				, GETDATE()
		FROM	dbo.Event_Coliseum_PlayData_NHN
		WHERE	[DateTag] BETWEEN @StartDateTag AND @EndDateTag
		AND		[DateTag] <> @PreDateTag
		GROUP BY CID

	INSERT Event_Coliseum_KillsRanking_NHN([Rank], [DateTag], CID)
		SELECT	ROW_NUMBER() OVER (ORDER BY (CAST(Kills AS FLOAT)/ CAST(PlayTime AS FLOAT)) DESC, PlayTime ASC) AS [Rank]
				, [DateTag], CID
		FROM	dbo.Event_Coliseum_PlayData_NHN
		WHERE	[DateTag] = @CurDateTag
		AND		PlayTime > 60 * 60
		
	INSERT Event_Coliseum_DeathsRanking_NHN([Rank], [DateTag], CID)
		SELECT	ROW_NUMBER() OVER (ORDER BY (CAST(Deaths AS FLOAT)/ CAST(PlayTime AS FLOAT)) ASC, PlayTime DESC) AS [Rank]
				, [DateTag], CID
		FROM	dbo.Event_Coliseum_PlayData_NHN
		WHERE	[DateTag] = @CurDateTag
		AND		Deaths > 5
		
	INSERT Event_Coliseum_PlayTimeRanking_NHN([Rank], [DateTag], CID)
		SELECT	ROW_NUMBER() OVER (ORDER BY PlayTime DESC) AS [Rank]
				, [DateTag], CID
		FROM	dbo.Event_Coliseum_PlayData_NHN
		WHERE	[DateTag] = @CurDateTag

	--------------------------------------------------------------------------------------------------			
	
	UPDATE	ed
	SET		ed.KillRank = er.[Rank]
	FROM	Event_Coliseum_KillsRanking_NHN er, Event_Coliseum_PlayData_NHN ed
	WHERE	er.CID = ed.CID
	AND		er.[DateTag] = @CurDateTag
	AND		er.[DateTag] = ed.[DateTag]
	
	UPDATE	ed
	SET		ed.DeathRank = er.[Rank]
	FROM	Event_Coliseum_DeathsRanking_NHN er, Event_Coliseum_PlayData_NHN ed
	WHERE	er.CID = ed.CID
	AND		er.[DateTag] = @CurDateTag
	AND		er.[DateTag] = ed.[DateTag]
	
	
	UPDATE	ed
	SET		ed.PlayTimeRank = er.[Rank]
	FROM	Event_Coliseum_PlayTimeRanking_NHN er, Event_Coliseum_PlayData_NHN ed
	WHERE	er.CID = ed.CID
	AND		er.[DateTag] = @CurDateTag
	AND		er.[DateTag] = ed.[DateTag]
	
	--------------------------------------------------------------------------------------------------
END
GO
/****** Object:  StoredProcedure [dbo].[spEventColiseum_GetCharacterDailyInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spEventColiseum_GetCharacterDailyInfo]
-- ALTER PROC dbo.spEventColiseum_GetCharacterDailyInfo
	@CID				INT
	, @TargetWeekDate	DATETIME
AS BEGIN

	SET NOCOUNT ON;
	
	DECLARE @DateTag		DATETIME;
	DECLARE @StartDateTag	CHAR(10);
	DECLARE @EndDateTag		CHAR(10);
	DECLARE @WeeklyDateTag	CHAR(10);
	
	SELECT	@DateTag = CASE WHEN DATEPART(WEEKDAY, CONVERT(DATETIME, @TargetWeekDate)) < 5
							THEN DATEADD(dd, DATEPART(WEEKDAY, CONVERT(DATETIME, @TargetWeekDate)) * (-1) + 4, @TargetWeekDate)
							ELSE DATEADD(dd, 11 - DATEPART(WEEKDAY, CONVERT(DATETIME, @TargetWeekDate)), @TargetWeekDate)
						END						
	
	SELECT	@StartDateTag = CONVERT( CHAR(8), DATEADD(dd, -6, @DateTag), 112) + '_D'
			, @EndDateTag = CONVERT( CHAR(8), @DateTag, 112) + '_D'
			, @WeeklyDateTag = CONVERT( CHAR(8), @DateTag, 112) + '_W';
	----------------------------------------------------------------------------------------------------
	
	SELECT	[DateTag], PlayTime, Kills, Deaths, PlayTimeRank, KillRank, DeathRank
	FROM	Event_Coliseum_PlayData_NHN(NOLOCK)
	WHERE	CID = @CID
	AND		[DateTag] BETWEEN @StartDateTag AND @EndDateTag
	AND		[DateTag] <> @WeeklyDateTag
	
	----------------------------------------------------------------------------------------------------
	
END
GO
/****** Object:  StoredProcedure [dbo].[spEventColiseum_GetCharacterWeeklyInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spEventColiseum_GetCharacterWeeklyInfo]
	@CID				INT
	, @TargetWeekDate	DATETIME
AS BEGIN

	SET NOCOUNT ON
	
	DECLARE @DateTag		DATETIME
	DECLARE @WeeklyDateTag	CHAR(10)
		
	SELECT	@DateTag = CASE WHEN DATEPART(WEEKDAY, CONVERT(DATETIME, @TargetWeekDate)) < 5
							THEN DATEADD(dd, DATEPART(WEEKDAY, CONVERT(DATETIME, @TargetWeekDate)) * (-1) + 4, @TargetWeekDate)
							ELSE DATEADD(dd, 11 - DATEPART(WEEKDAY, CONVERT(DATETIME, @TargetWeekDate)), @TargetWeekDate)
						END
		
	SELECT	@WeeklyDateTag = CONVERT( CHAR(8), @DateTag, 112) + '_W'
	
		
	SELECT	[DateTag], PlayTime, Kills, Deaths, PlayTimeRank, KillRank, DeathRank
	FROM	Event_Coliseum_PlayData_NHN(NOLOCK)
	WHERE	CID = @CID
	AND		[DateTag] = @WeeklyDateTag
	
		
END
GO
/****** Object:  StoredProcedure [dbo].[spEventColiseum_InsertCharacter]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spEventColiseum_InsertCharacter]
	@CID	INT
AS BEGIN
	
	SET NOCOUNT ON
	
	DECLARE @EventCID	INT
	
	SELECT	@EventCID = CID 
	FROM	Event_Coliseum_Character_NHN 
	WHERE	CID = @CID
		
	IF( EXISTS (SELECT CID FROM Event_Coliseum_Character_NHN(NOLOCK) WHERE CID = @CID ))
		RETURN -1
		
	
	INSERT Event_Coliseum_Character_NHN(CID, RegDate) 
	VALUES (@CID, GETDATE())
	
	RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[spEventColiseum_UpdatePlayData]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spEventColiseum_UpdatePlayData]
-- ALTER PROC dbo.spEventColiseum_UpdatePlayData
	@CID			INT
	, @PlayTime		INT
	, @Kills		INT
	, @Deaths		INT
AS BEGIN

	SET NOCOUNT ON;  	
	
	DECLARE @DateTag CHAR(10);
	-- SELECT @DateTag = CONVERT( CHAR(8), DATEADD(dd, DATEPART(WEEKDAY, CONVERT(DATETIME, GETDATE()))*(-1)+4, CONVERT(DATETIME, GETDATE())), 112);
	SELECT @DateTag = CONVERT( CHAR(8), GETDATE(), 112) + '_D';
	
	IF( NOT EXISTS ( SELECT CID FROM dbo.Event_Coliseum_Character_NHN WHERE CID = @CID ) ) RETURN;	
	
	IF( EXISTS ( SELECT CID FROM dbo.Event_Coliseum_PlayData_NHN WHERE CID = @CID AND [DateTag] = @DateTag ) ) 
	BEGIN
	
		UPDATE	dbo.Event_Coliseum_PlayData_NHN
		SET		PlayTime = PlayTime + @PlayTime
				, Kills = Kills + @Kills
				, Deaths = Deaths + @Deaths
				, LastUpdatedDate = GETDATE()
		WHERE	[DateTag] = @DateTag
		AND		CID = @CID;
		
	END
	ELSE BEGIN
	
		INSERT dbo.Event_Coliseum_PlayData_NHN([DateTag], CID, PlayTime, Kills, Deaths, LastUpdatedDate)
		VALUES (@DateTag, @CID, @PlayTime, @Kills, @Deaths, GETDATE());
		
	END					
END
GO
/****** Object:  StoredProcedure [dbo].[spEventGetCharList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spEventGetCharList]  
 @UserID VARCHAR(20)  
AS  
BEGIN  
 SELECT c.CID, c.Level, c.Name FROM Account a(NOLOCK), Character c(NOLOCK)  
 WHERE UserID=@UserID AND a.AID = c.AID AND c.DeleteFlag=0  
 RETURN 1  
END
GO
/****** Object:  StoredProcedure [dbo].[spEventGetClanPointAcquire]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--------------------------------------------------------------------------------------------

CREATE   PROC [dbo].[spEventGetClanPointAcquire]  
 @UserID VARCHAR(20)  
AS  
BEGIN  
 SELECT c.Name, m.CLID, r.Name, r.Point, r.Rank   
 FROM Account a(NOLOCK), Character c(NOLOCK), ClanMember m(NOLOCK), Event_ClanPointRanking r(NOLOCK)  
 WHERE a.UserID=@UserID AND a.AID=c.AID AND c.DeleteFlag=0 AND c.CID=m.CID AND m.CLID=r.CLID  
  
 RETURN 1  
END
GO
/****** Object:  StoredProcedure [dbo].[spEventGetPlayTime]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--------------------------------------------------------------------------------------------

CREATE   PROC [dbo].[spEventGetPlayTime]  
 @UserID VARCHAR(20)  
AS  
BEGIN  
 DECLARE @PlayTime INT  
 SELECT @PlayTime=SUM(l.PlayTime) FROM Account a(NOLOCK), Character c(NOLOCK), PlayerLog l(NOLOCK)  
 WHERE a.UserID=@UserID AND a.AID=c.AID AND c.DeleteFlag=0 AND c.CID=l.CID AND l.DisTime > '2005-08-18'  
   
 IF @PlayTime IS NULL  
 BEGIN  
  SELECT @PlayTime=0  
 END  
  
 SELECT @PlayTime=@PlayTime/60  
   
 SELECT @UserID, @PlayTime  
END
GO
/****** Object:  StoredProcedure [dbo].[spEventGetQuerifiedNewbie]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--------------------------------------------------------------------------------------------

CREATE    PROC [dbo].[spEventGetQuerifiedNewbie]  
 @UserID VARCHAR(20)  
AS  
BEGIN  
 DECLARE @AID INT  
 DECLARE @RegDate DATETIME  
 SELECT @AID=AID, @RegDate=RegDate FROM Account(NOLOCK) WHERE UserID=@UserID  
   
 IF @RegDate < '2005-08-18' OR @RegDate IS NULL  
 BEGIN  
  SELECT @UserID, -1  
  RETURN -1  
 END  
   
 DECLARE @MaxLevel INT  
 SELECT @MaxLevel=MAX(Level) FROM Character(NOLOCK) WHERE AID=@AID AND DeleteFlag=0  
   
 IF @MaxLevel < 7 OR @MaxLevel IS NULL  
 BEGIN  
  SELECT @UserID, 0  
  RETURN 0  
 END  
   
 SELECT @UserID, 1  
 RETURN 1  
END
GO
/****** Object:  StoredProcedure [dbo].[spEventSpring_GetAcountEasterTickets]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spEventSpring_GetAcountEasterTickets]
-- ALTER PROC dbo.spEventSpring_GetAcountEasterTickets
    @UserID     VARCHAR(24)
    , @ItemID   INT
    , @ItemCnt  INT OUTPUT 
AS BEGIN

    SET NOCOUNT ON;

    IF( @ItemID < 701001 OR @ItemID > 701004 ) RETURN;
    
    SET @ItemCnt = 0;

    SELECT  @ItemCnt = SUM(R.ItemCnt)
    FROM
            (
                SELECT  CI.ItemID, COUNT(CI.ItemID) AS ItemCnt
                FROM    dbo.Account A(NOLOCK) 
                        JOIN dbo.Character C(NOLOCK)
                        ON A.AID = C.AID
                        JOIN dbo.CharacterItem CI(NOLOCK) 
                        ON C.CID = CI.CID
                WHERE   A.UserID = @UserID
                AND     CI.ItemID = @ItemID
                AND     C.DeleteFlag = 0
                GROUP BY CI.ItemID

                UNION ALL

                SELECT  AI.ItemID, COUNT(AI.ItemID) AS ItemCnt
                FROM    dbo.Account A(NOLOCK) 
                        JOIN dbo.AccountItem AI(NOLOCK) 
                        ON A.AID = AI.AID
                WHERE   A.UserID = @UserID
                AND     AI.ItemID = @ItemID
                GROUP BY AI.ItemID
            ) R
    GROUP BY ItemID

END
GO
/****** Object:  StoredProcedure [dbo].[spEventSpring_GetEasterEggCount]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spEventSpring_GetEasterEggCount]
-- ALTER PROC dbo.spEventSpring_GetEasterEggCount
    @UserID VARCHAR(24)
AS BEGIN

    SET NOCOUNT ON;

    SELECT  R.ItemID, SUM(R.ItemCnt) AS ItemCnt
    FROM
            (
                SELECT  CI.ItemID, COUNT(CI.ItemID) AS ItemCnt
                FROM    dbo.Account A(NOLOCK) 
                        JOIN dbo.Character C(NOLOCK)
                        ON A.AID = C.AID
                        JOIN dbo.CharacterItem CI(NOLOCK) 
                        ON C.CID = CI.CID
                WHERE   A.UserID = @UserID
                AND     CI.ItemID BETWEEN 701001 AND 701004
                AND     C.DeleteFlag = 0
                GROUP BY CI.ItemID

                UNION ALL

                SELECT  AI.ItemID, COUNT(AI.ItemID) AS ItemCnt
                FROM    dbo.Account A(NOLOCK) 
                        JOIN dbo.AccountItem AI(NOLOCK) 
                        ON A.AID = AI.AID
                WHERE   A.UserID = @UserID
                AND     AI.ItemID BETWEEN 701001 AND 701004
                GROUP BY AI.ItemID
            ) R
    GROUP BY R.ItemID
    
END
GO
/****** Object:  StoredProcedure [dbo].[spEventSpring_RemoveEasterEgg]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spEventSpring_RemoveEasterEgg]
-- ALTER PROC dbo.spEventSpring_RemoveEasterEgg
    @UserID     VARCHAR(24)
    , @ItemID   INT
    , @ItemCnt  INT
AS BEGIN

    SET NOCOUNT ON;

    ------------------------------------------------------------------------------------

    IF( @ItemID < 701001 OR @ItemID > 701004 ) BEGIN
        SELECT -1 AS 'Ret';
        RETURN;
    END

    ------------------------------------------------------------------------------------

    DECLARE @UserItemCnt INT;
    SET @UserItemCnt = 0;
    
    SELECT  @UserItemCnt = SUM(R.ItemCnt)
    FROM
            (
                SELECT  CI.ItemID, COUNT(CI.ItemID) AS ItemCnt
                FROM    dbo.Account A(NOLOCK) 
                        JOIN dbo.Character C(NOLOCK)
                        ON A.AID = C.AID
                        JOIN dbo.CharacterItem CI(NOLOCK) 
                        ON C.CID = CI.CID
                WHERE   A.UserID = @UserID
                AND     CI.ItemID = @ItemID
                AND     C.DeleteFlag = 0
                GROUP BY CI.ItemID

                UNION ALL

                SELECT  AI.ItemID, COUNT(AI.ItemID) AS ItemCnt
                FROM    dbo.Account A(NOLOCK) 
                        JOIN dbo.AccountItem AI(NOLOCK) 
                        ON A.AID = AI.AID
                WHERE   A.UserID = @UserID
                AND     AI.ItemID = @ItemID
                GROUP BY AI.ItemID
            ) R
    GROUP BY ItemID

    IF( @UserItemCnt < @ItemCnt ) BEGIN
        SELECT -2 AS 'Ret';
        RETURN;
    END

    ------------------------------------------------------------------------------------

    BEGIN TRAN -----------

        DECLARE @SQLString NVARCHAR(MAX);
        DECLARE @DeletedCnt INT;

        SET @SQLString =                N'DELETE  AccountItem ';
        SET @SQLString = @SQLString +   N'WHERE   AIID IN ';
        SET @SQLString = @SQLString +   N'(';
        SET @SQLString = @SQLString +   N'  SELECT  TOP ' + CAST(@ItemCnt AS VARCHAR(MAX)) + ' AI.AIID';
        SET @SQLString = @SQLString +   N'  FROM    Account A(NOLOCK) JOIN AccountItem AI(NOLOCK) ON A.AID = AI.AID';
        SET @SQLString = @SQLString +   N'  WHERE   A.UserID = ''' + @UserID + ''' AND AI.ItemID = ' + CAST(@ItemID AS VARCHAR(MAX));
        SET @SQLString = @SQLString +   N')';

        EXEC SP_EXECUTESQL @SQLString;
        SET @DeletedCnt = @@ROWCOUNT;
        
        IF( @@ERROR <> 0 ) BEGIN
            ROLLBACK TRAN;
			SELECT -3 AS 'Ret';
			RETURN;
        END

        -- 더 지울 것이 남았다면 CharacterItem 테이블 쪽을 지우자.        
        IF( @ItemCnt - @DeletedCnt > 0 )
        BEGIN

            SET @SQLString =                N'DELETE  CharacterItem ';
            SET @SQLString = @SQLString +   N'WHERE   CIID IN ';
            SET @SQLString = @SQLString +   N'(';
            SET @SQLString = @SQLString +   N'  SELECT  TOP ' + CAST((@ItemCnt - @DeletedCnt) AS VARCHAR(MAX)) + ' CI.CIID';
            SET @SQLString = @SQLString +   N'  FROM    dbo.Character C(NOLOCK) JOIN Account A(NOLOCK) ON C.AID = A.AID';
            SET @SQLString = @SQLString +   N'          JOIN CharacterItem CI(NOLOCK) ON C.CID = CI.CID';
            SET @SQLString = @SQLString +   N'  WHERE   A.UserID = ''' + @UserID + ''' AND C.DeleteFlag = 0 AND CI.ItemID = ' + CAST(@ItemID AS VARCHAR(MAX));
            SET @SQLString = @SQLString +   N')';
            
            -- SELECT @SQLString;
            EXEC SP_EXECUTESQL @SQLString;

            IF( @@ERROR <> 0 ) BEGIN
                ROLLBACK TRAN;
			    SELECT -4 AS 'Ret';
			    RETURN;
            END
        END
        
    COMMIT TRAN ----------
    
    ------------------------------------------------------------------------------------

    SELECT 0 AS 'Ret';

END
GO
/****** Object:  StoredProcedure [dbo].[spEventThxGiving_GetTurkeyDinnerCount]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spEventThxGiving_GetTurkeyDinnerCount]
 @UserID   VARCHAR(24)
AS BEGIN

 SET NOCOUNT ON;

 
 DECLARE @AID INT;
 SELECT @AID = AID FROM Account WHERE UserID = @UserID;

 
 SELECT COUNT(r.CID) AS Count
 FROM ( SELECT c.CID 
    FROM Character c 
    WHERE c.AID = @AID ) r JOIN CharacterItem ci    
 ON  r.CID = ci.CID    
 AND  ci.ItemID = 400013 

 
END
GO
/****** Object:  StoredProcedure [dbo].[spEventThxGiving_RedeemTurkeyDinner]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spEventThxGiving_RedeemTurkeyDinner]
-- ALTER PROC dbo.spEventThxGiving_RedeemTurkeyDinner
	@UserID			VARCHAR(24),
	@RedeemCount	INT
AS BEGIN

	SET NOCOUNT ON;

	DECLARE @AID INT;
	SELECT @AID = AID FROM Account WHERE UserID = @UserID;
	
	DECLARE @TotalCount INT;
	SELECT	@TotalCount = COUNT(r.CID)
	FROM	(	SELECT c.CID 
				FROM Character c 
				WHERE c.AID = @AID ) r JOIN CharacterItem ci    
	ON		r.CID = ci.CID    
	AND		ci.ItemID = 400013 
	
	IF( @TotalCount < @RedeemCount ) BEGIN
		PRINT 'Not Enough Tukey!';
	END
	ELSE BEGIN
		DECLARE @SQLQuery VARCHAR(MAX);
		
		SET @SQLQuery =				'UPDATE	ci ';
		SET @SQLQuery = @SQLQuery + 'SET CID = NULL ';
		SET @SQLQuery = @SQLQuery + 'FROM CharacterItem ci ';
		SET @SQLQuery = @SQLQuery + 'WHERE	ci.CIID IN ( SELECT	TOP ' + CAST(@RedeemCount AS VARCHAR(MAX)) + ' ci.CIID ';
		SET @SQLQuery = @SQLQuery + 'FROM ( SELECT c.CID FROM Character c WHERE c.AID = ' +  CAST(@AID AS VARCHAR(MAX)) + ' ) r JOIN CharacterItem ci '
		SET @SQLQuery = @SQLQuery + 'ON	r.CID = ci.CID AND ci.ItemID = 400013 )';
		
		PRINT 'Enough to remove Tukey!'
		--PRINT @SQLQuery;
		EXEC (@SQLQuery);
	END	
END
GO
/****** Object:  StoredProcedure [dbo].[spFetchSurvivalRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spFetchSurvivalRanking]
AS
BEGIN
	SET NOCOUNT ON;
	
	BEGIN TRAN;
	
	------------------------------------------------------------------------------------------------------
	UPDATE dbo.SurvivalCharacterInfo
	SET tmpRP = RP;
	IF (0 <> @@ERROR)
	BEGIN
		ROLLBACK TRAN;
		RETURN;
	END
	
	CREATE TABLE dbo.tmpRanking(SID INT NOT NULL, RP INT NOT NULL, Ranking INT);		
	------------------------------------------------------------------------------------------------------
	
	DECLARE @nRank		INT
	DECLARE @nPreSID	INT
	DECLARE @nSID		INT
	DECLARE @nRP		INT
	DECLARE @nCount		INT
	
	DECLARE Curs CURSOR FAST_FORWARD FOR 
	SELECT t.SID, t.RP, t.Cnt 
	FROM	
	(
		SELECT SID, tmpRP AS RP, COUNT(tmpRP) AS Cnt	
		FROM dbo.SurvivalCharacterInfo WITH (NOLOCK)
		--WHERE RP_LatestTime < CONVERT(CHAR, DATEADD(dd, -1, GETDATE()), 112)
		GROUP BY SID, tmpRP
	) AS t
	ORDER BY t.SID ASC, t.RP DESC;
	
	OPEN Curs
	FETCH NEXT FROM Curs INTO @nSID, @nRP, @nCount;

	SET @nRank = 1
	SET @nPreSID = @nSID	
				
	WHILE( @@FETCH_STATUS = 0 )
	BEGIN
		INSERT INTO tmpRanking(SID, RP, Ranking) VALUES (@nSID, @nRP, @nRank);
		IF (0 = @@ROWCOUNT OR 0 <> @@ERROR)
		BEGIN
			ROLLBACK TRAN;
			CLOSE Curs;
			DEALLOCATE Curs;
			RETURN;
		END
		
		SET @nRank = @nRank + @nCount 		
		FETCH NEXT FROM Curs INTO @nSID, @nRP, @nCount
		
		IF( @nPreSID < @nSID )
		BEGIN
			SET @nRank = 1
			SET @nPreSID = @nSID			
		END
	END
	
	CLOSE Curs
	DEALLOCATE Curs
	
	------------------------------------------------------------------------------------------------------

	DECLARE @Date NVARCHAR(15);
	DECLARE @PKSQL NVARCHAR(512);
	DECLARE @IXSQL NVARCHAR(512);
	
	SET @Date = CAST(DATEDIFF(ss, '2009-06-09T00:00:00', GETDATE()) AS NVARCHAR(15));
	SET @PKSQL = N'ALTER TABLE tmpRanking ADD CONSTRAINT PK_SurvivalRanking_SID_RP_' + @Date + N' PRIMARY KEY (SID ASC, RP DESC);'	
	EXEC sp_executesql @PKSQL;
	
	
	EXEC sp_rename 'SurvivalCharacterInfo.IX_SurvivalCharacterInfo_RankRP', 'IX_SurvivalCharacterInfo_tmpRP', 'INDEX';	
	
	CREATE NONCLUSTERED INDEX IX_SurvivalCharacterInfo_RankRP ON SurvivalCharacterInfo(tmpRP);
	
	EXEC sp_rename 'SurvivalCharacterInfo.RankRP', 'tmpRP2', 'COLUMN';
	EXEC sp_rename 'SurvivalCharacterInfo.tmpRP', 'RankRP', 'COLUMN';
	EXEC sp_rename 'SurvivalCharacterInfo.tmpRP2', 'tmpRP', 'COLUMN';
	
	DROP INDEX dbo.SurvivalCharacterInfo.IX_SurvivalCharacterInfo_tmpRP;
	DROP TABLE dbo.SurvivalRanking;
	EXEC sp_rename 'tmpRanking', 'SurvivalRanking';
	
	
	------------------------------------------------------------------------------------------------------		
	TRUNCATE TABLE dbo.SurvivalCharacterInfoWeb;	
	INSERT INTO dbo.SurvivalCharacterInfoWeb(SID, CID)
		SELECT SID, CID 
		FROM dbo.SurvivalCharacterInfo WITH (NOLOCK)
		ORDER BY SID ASC, RankRP DESC
	------------------------------------------------------------------------------------------------------			
	
	COMMIT TRAN;
END
GO
/****** Object:  StoredProcedure [dbo].[spFetchTotalRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ÀüÃ¼ ·©Å·À» »êÃâÇÑ´Ù. - µðºñ ¿¡ÀÌÀüÆ®¿¡¼­ ½ÇÇà½ÃÅ°´Â ÇÁ·Î½ÃÁ® */
CREATE PROC [dbo].[spFetchTotalRanking]
AS
SET NOCOUNT ON
TRUNCATE TABLE TotalRanking

INSERT into TotalRanking(UserID, Name, Level, XP, KillCount, DeathCount)

SELECT Account.UserID, c.name, c.Level, c.XP, c.KillCount, c.DeathCount
FROM Character c(nolock), Account(nolock)
WHERE Account.AID=c.aid AND c.DeleteFlag=0 AND c.XP >= 500
ORDER BY c.xp DESC, c.KillCount DESC, c.DeathCount ASC, c.PlayTime DESC
GO
/****** Object:  StoredProcedure [dbo].[spGetAccountCharInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGetAccountCharInfo]
-- ALTER PROC dbo.spGetAccountCharInfo
	@AID		INT, 
	@CharNum	SMALLINT
AS BEGIN

	DECLARE @CID			INT
	DECLARE @CLID			INT
	DECLARE @ClanName		VARCHAR(24)  
	DECLARE @ClanGrade		INT
	DECLARE @ClanContPoint	INT
  
	SELECT @CID = CID FROM Character(NOLOCK) WHERE AID=@AID AND CharNum=@CharNum  
  
	SELECT @CID AS CID, c.Name AS Name, c.CharNum AS CharNum, c.Level AS Level
			, c.Sex AS Sex, c.Hair AS Hair, c.Face AS Face, c.XP AS XP, c.BP AS BP
			, (	SELECT	cl.Name 
				FROM	Clan cl(NOLOCK), ClanMember cm(NOLOCK) 
				WHERE	cm.cid = @CID 
				AND		cm.CLID=cl.CLID ) AS ClanName
	FROM Character c(NOLOCK)  
	WHERE c.CID = @CID
END

----------------------------------------------------------------------------------------------------------------------------------------
-- º¹±¸ Äõ¸®
/*
DROP PROC spGetAccountCharInfo
EXEC sp_rename 'BackUp_spGetAccountCharInfo', 'spGetAccountCharInfo'
*/
GO
/****** Object:  StoredProcedure [dbo].[spGetAccountInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------------------------------

CREATE   PROC [dbo].[spGetAccountInfo]
 @AID  int      
, @ServerID int = 0
AS    
BEGIN  
 SET NOCOUNT ON    

 SELECT AID, UserID, UGradeID, Name, HackingType
 , DATEPART(yy, EndHackingBlockTime) AS HackBlockYear, DATEPART(mm, EndHackingBlockTime) AS HackBlockMonth    
 , DATEPART(dd, EndHackingBlockTime) AS HackBlockDay, DATEPART(hh, EndHackingBlockTime) AS HackBlockHour    
 , DATEPART(mi, EndHackingBlockTime) AS HackBlockMin
 , DATEDIFF(mi, GETDATE(), EndHackingBlockTime) AS 'HackingBlockTimeRemainderMin'
 , IsPowerLevelingHacker
 , DATEDIFF(mi, PowerLevelingRegDate, GETDATE()) AS 'PowerLevelingRegPassedTimeMin'
 FROM Account(NOLOCK) WHERE AID = @AID      

 update Account set LastLoginTime = getdate(), ServerID = @ServerID  where aid = @aid  
END
GO
/****** Object:  StoredProcedure [dbo].[spGetAccountPenaltyInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGetAccountPenaltyInfo]
-- ALTER PROC dbo.spGetAccountPenaltyInfo
	@AID			INT	
AS BEGIN
	SET NOCOUNT ON
	
  	SELECT	a.PEndDate, PCode
	FROM	AccountPenaltyGMLog a(NOLOCK)
	WHERE	a.AID = @AID
	AND		a.Reset_Date IS NULL
END
GO
/****** Object:  StoredProcedure [dbo].[spGetAllItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------------------------------------------------
-- ÀÛ¾÷ÇÒ Äõ¸®

CREATE PROC [dbo].[spGetAllItem]
-- ALTER PROC dbo.spGetAllItem
AS BEGIN

	SET NOCOUNT ON;
	
	SELECT	ItemID, ResSex, ResLevel, Slot, Weight, BountyPrice, Damage, Delay
			, Controllability, MaxBullet, Magazine, ReloadTime, HP, AP
			, IsCashItem, IsSpendableItem
	FROM	Item(NOLOCK)
	
END
GO
/****** Object:  StoredProcedure [dbo].[spGetBattleTimeRewardDescription]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------------------------------------------------------------
/*
DROP PROC dbo.spGetBattleTimeRewardDescription;
DROP PROC dbo.spGetBattleTimeRewardItemList;
DROP PROC dbo.spGetCharBRInfoAll;
DROP PROC dbo.spGetCharBRInfo;
DROP PROC dbo.spInsertCharBRInfo;
DROP PROC dbo.spUpdateCharBRInfo;
DROP PROC dbo.spRewardCharBattleTimeReward;
*/
--------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spGetBattleTimeRewardDescription]
-- ALTER PROC dbo.spGetBattleTimeRewardDescription
AS BEGIN
    
    SET NOCOUNT ON;

    SELECT  BR.BRID, BR.[Name], T1.BRTID, BR.RewardMinutePeriod, BR.RewardCount, BR.RewardKillCount, BR.ResetDesc
    FROM    dbo.BattleTimeRewardDescription BR(NOLOCK) 
            JOIN
            (
                SELECT  BRID, MAX(BRTID) AS BRTID
                FROM    dbo.BattleTimeRewardTerm(NOLOCK)
                WHERE   ClosedDate IS NULL
                GROUP BY BRID
            ) T1 
            ON T1.BRID = BR.BRID
    WHERE   GETDATE() BETWEEN BR.StartDate AND BR.EndDate
    AND     DATEPART(hh, GETDATE()) BETWEEN BR.StartHour AND BR.EndHour
    AND     BR.IsOpen = 1
    ORDER BY BR.BRID
    
END
GO
/****** Object:  StoredProcedure [dbo].[spGetBattleTimeRewardItemList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spGetBattleTimeRewardItemList]
-- ALTER PROC dbo.spGetBattleTimeRewardItemList
AS BEGIN

    SET NOCOUNT ON;

    WITH T1 AS
    (
        SELECT  BRI.BRID
        FROM    BattleTimeRewardItemList BRI(NOLOCK)
        GROUP BY BRI.BRID HAVING SUM(BRI.RatePerThousand) = 1000
    ), 
    T2 AS
    (
        SELECT  BRI.BRID, BRI.BRIID, BRI.ItemIDMale, BRI.ItemIDFemale, BRI.ItemCnt, BRI.RentHourPeriod, BRI.RatePerThousand
        FROM    dbo.BattleTimeRewardDescription BR(NOLOCK)
                JOIN dbo.BattleTimeRewardItemList BRI(NOLOCK)
                ON BR.BRID = BRI.BRID
        WHERE   GETDATE() BETWEEN BR.StartDate AND BR.EndDate
        AND     DATEPART(hh, GETDATE()) BETWEEN BR.StartHour AND BR.EndHour
        AND     BR.IsOpen = 1
    )
    SELECT  T2.BRID, T2.BRIID, T2.ItemIDMale, T2.ItemIDFemale, T2.ItemCnt, T2.RentHourPeriod, T2.RatePerThousand
    FROM    T1 JOIN T2 ON T1.BRID = T2.BRID
    ORDER BY T2.BRIID

END
GO
/****** Object:  StoredProcedure [dbo].[spGetCashItemImageFile]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Ä³½¬ ÀÏ¹Ý¾ÆÀÌÅÛ ÀÌ¹ÌÁöÆÄÀÏ ¾Ë¾Æ¿À±â
CREATE PROC [dbo].[spGetCashItemImageFile]
	@CSID			int
,	@RetImageFileName	varchar(64) OUTPUT
AS
SET NOCOUNT ON

SELECT @RetImageFileName = WebImgName
FROM CashShop cs(nolock)
WHERE cs.csid=@CSID

RETURN 1
GO
/****** Object:  StoredProcedure [dbo].[spGetCashItemInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ¾ÆÀÌÅÛÀÇ »ó¼¼ Á¤º¸ º¸±â */
CREATE  PROC [dbo].[spGetCashItemInfo]
	@CSID		int
AS
	SET NOCOUNT ON

	SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot, 
		cs.CashPrice AS Cash, cs.WebImgName As WebImgName,
		i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight,
		i.Damage AS Damage, i.Delay AS Delay, i.Controllability AS Controllability,
		i.Magazine AS Magazine, i.MaxBullet AS MaxBullet, i.ReloadTime AS ReloadTime, 
		i.HP AS HP, i.AP AS AP,	i.MAXWT AS MaxWeight, i.LimitSpeed AS LimitSpeed,
		i.FR AS FR, i.CR AS CR, i.PR AS PR, i.LR AS LR,
		i.Description AS Description, cs.NewItemOrder AS IsNewItem,
		cs.RentType AS RentType
	FROM CashShop cs(nolock), Item i(nolock)
	WHERE i.ItemID = cs.ItemID AND cs.csid = @CSID
GO
/****** Object:  StoredProcedure [dbo].[spGetCashItemList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ¾ÆÀÌÅÛ ¸®½ºÆ® °¡Á®¿À±â */
CREATE PROC [dbo].[spGetCashItemList]
	@ItemType	int,
	@Page		int,		
	@PageCount	int OUTPUT
AS
SET NoCount On

DECLARE @Rows int
DECLARE @ViewCount int

SELECT @Rows = @Page * 8	/* ÇÑÆäÀÌÁö¿¡ 8°³¾¿ º¸¿©ÁØ´Ù */

DECLARE @PageSize INT
SELECT @PageSize = 8

DECLARE @PageHead INT
DECLARE @RowCount INT


IF @ItemType = 1 /* ±ÙÁ¢¹«±â */
BEGIN

	SELECT @PageCount = (COUNT(*) + (@PageSize-1)) / @PageSize
	FROM CashShop cs(nolock), Item i(nolock)
	WHERE i.ItemID = cs.ItemID AND i.Slot = 1 AND cs.Opened=1

	SELECT @RowCount = ((@Page -1) * @PageSize + 1)

	SET ROWCOUNT @RowCount
	SELECT @PageHead = cs.csid FROM CashShop cs(NOLOCK), Item i(nolock) 
	WHERE cs.ItemID=i.ItemID AND i.Slot=1 AND cs.Opened=1
	ORDER BY cs.csid DESC

	SET ROWCOUNT @PageSize
	SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot,
		cs.CashPrice AS Cash, cs.WebImgName As WebImgName,
		i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight,
		i.Description AS Description, cs.RegDate As RegDate, cs.NewItemOrder AS IsNewItem,
		cs.RentType AS RentType
	FROM CashShop cs(nolock), Item i(nolock)
	WHERE csid <= @PageHead AND i.ItemID = cs.ItemID AND i.Slot = 1 AND cs.Opened=1
	ORDER BY cs.csid DESC

END
ELSE
IF @ItemType=2 		/* ¿ø°Å¸®¹«±â */
BEGIN

	SELECT @PageCount = (COUNT(*) + (@PageSize-1)) / @PageSize
	FROM CashShop cs(nolock), Item i(nolock)
	WHERE i.ItemID = cs.ItemID AND i.Slot = 2 AND cs.Opened=1

	SELECT @RowCount = ((@Page -1) * @PageSize + 1)

	SET ROWCOUNT @RowCount
	SELECT @PageHead = cs.csid FROM CashShop cs(NOLOCK), Item i(nolock) 
	WHERE cs.ItemID=i.ItemID AND i.Slot=2 AND cs.Opened=1
	ORDER BY cs.csid DESC

	SET ROWCOUNT @PageSize
	SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot,
		cs.CashPrice AS Cash, cs.WebImgName As WebImgName,
		i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight,
		i.Description AS Description, cs.RegDate As RegDate, cs.NewItemOrder AS IsNewItem,
		cs.RentType AS RentType
	FROM CashShop cs(nolock), Item i(nolock)
	WHERE csid <= @PageHead AND i.ItemID = cs.ItemID AND i.Slot = 2 AND cs.Opened=1
	ORDER BY cs.csid DESC

END
ELSE
IF @ItemType=3 		/* ¹æ¾î±¸ */
BEGIN

	SELECT @PageCount = (COUNT(*) + (@PageSize-1)) / @PageSize
	FROM CashShop cs(nolock), Item i(nolock)
	WHERE i.ItemID = cs.ItemID AND i.Slot BETWEEN 4 AND 8 AND cs.Opened=1

	SELECT @RowCount = ((@Page -1) * @PageSize + 1)

	SET ROWCOUNT @RowCount
	SELECT @PageHead = cs.csid FROM CashShop cs(NOLOCK), Item i(nolock) 
	WHERE cs.ItemID=i.ItemID AND i.Slot BETWEEN 4 AND 8 AND cs.Opened=1
	ORDER BY cs.csid DESC

	SET ROWCOUNT @PageSize
	SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot,
		cs.CashPrice AS Cash, cs.WebImgName As WebImgName,
		i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight,
		i.Description AS Description, cs.RegDate As RegDate, cs.NewItemOrder AS IsNewItem,
		cs.RentType AS RentType
	FROM CashShop cs(nolock), Item i(nolock)
	WHERE csid <= @PageHead AND i.ItemID = cs.ItemID AND i.Slot BETWEEN 4 AND 8 AND cs.Opened=1
	ORDER BY cs.csid DESC

END
ELSE
IF @ItemType=4 		/* Æ¯¼ö¾ÆÀÌÅÛ */
BEGIN

	SELECT @PageCount = (COUNT(*) + (@PageSize-1)) / @PageSize
	FROM CashShop cs(nolock), Item i(nolock)
	WHERE i.ItemID = cs.ItemID AND (i.Slot = 3 OR i.Slot=9) AND cs.Opened=1

	SELECT @RowCount = ((@Page -1) * @PageSize + 1)

	SET ROWCOUNT @RowCount
	SELECT @PageHead = cs.csid FROM CashShop cs(NOLOCK), Item i(nolock) 
	WHERE cs.ItemID=i.ItemID AND (i.Slot = 3 OR i.Slot=9) AND cs.Opened=1
	ORDER BY cs.csid DESC

	SET ROWCOUNT @PageSize
	SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot,
		cs.CashPrice AS Cash, cs.WebImgName As WebImgName,
		i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight,
		i.Description AS Description, cs.RegDate As RegDate, cs.NewItemOrder AS IsNewItem,
		cs.RentType AS RentType
	FROM CashShop cs(nolock), Item i(nolock)
	WHERE csid <= @PageHead AND i.ItemID = cs.ItemID AND (i.Slot = 3 OR i.Slot=9) AND cs.Opened=1
	ORDER BY cs.csid DESC

END

SET ROWCOUNT 0
GO
/****** Object:  StoredProcedure [dbo].[spGetCashSetItemComposition]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ¼¼Æ® ¾ÆÀÌÅÛÀÇ ¼¼ºÎ¾ÆÀÌÅÛ ¸ñ·Ï º¸±â */
CREATE PROC [dbo].[spGetCashSetItemComposition]
	@CSSID		int,
	@OutRowCount	int OUTPUT
AS
SET NOCOUNT ON

SELECT @OutRowCount = COUNT(*)
FROM CashSetItem csi(nolock), CashShop cs(nolock), Item i(nolock)
WHERE @CSSID = csi.CSSID AND csi.csid = cs.csid	AND cs.ItemID = i.ItemID

SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot, 
	cs.CashPrice AS Cash, cs.WebImgName As WebImgName,
	i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight,
	i.Description AS Description, cs.RegDate As RegDate,
	cs.NewItemOrder AS IsNewItem

FROM CashSetItem csi(nolock), CashShop cs(nolock), Item i(nolock)
WHERE @CSSID = csi.CSSID AND csi.csid = cs.csid	AND cs.ItemID = i.ItemID
GO
/****** Object:  StoredProcedure [dbo].[spGetCashSetItemImageFile]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Ä³½¬ ¼¼Æ®¾ÆÀÌÅÛ ÀÌ¹ÌÁöÆÄÀÏ ¾Ë¾Æ¿À±â
CREATE PROC [dbo].[spGetCashSetItemImageFile]
	@CSSID			int
,	@RetImageFileName	varchar(64) OUTPUT
AS
SET NOCOUNT ON

SELECT @RetImageFileName=WebImgName FROM CashSetShop css(nolock) WHERE CSSID=@CSSID

RETURN 1
GO
/****** Object:  StoredProcedure [dbo].[spGetCashSetItemInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ¼¼Æ®¾ÆÀÌÅÛÀÇ »ó¼¼ Á¤º¸ º¸±â */
CREATE  PROC [dbo].[spGetCashSetItemInfo]
	@CSSID	int
AS
	SET NOCOUNT ON

	SELECT CSSID AS CSSID, Name AS Name, CashPrice AS Cash, WebImgName AS WebImgName, 
	ResSex AS ResSex, ResLevel AS ResLevel, Weight AS Weight,
	Description AS Description, NewItemOrder As IsNewItem, RentType AS RentType

	FROM CashSetShop css(nolock)
	WHERE CSSID = @CSSID
GO
/****** Object:  StoredProcedure [dbo].[spGetCashSetItemList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ¼¼Æ®¾ÆÀÌÅÛ ¸ñ·Ï º¸±â */
CREATE PROC [dbo].[spGetCashSetItemList]
	@Page		int,
	@PageCount	int OUTPUT
AS
SET NoCount On
DECLARE @Rows int
DECLARE @ViewCount int

DECLARE @PageSize INT
SELECT @PageSize = 8		/* ÇÑÆäÀÌÁö¿¡ 8°³¾¿ º¸¿©ÁØ´Ù */

DECLARE @PageHead INT
DECLARE @RowCount INT

SELECT @PageCount = (COUNT(*) + (@PageSize-1)) / @PageSize FROM CashSetShop css(nolock) WHERE css.Opened=1
SELECT @RowCount = ((@Page -1) * @PageSize + 1)

SET ROWCOUNT @RowCount
SELECT @PageHead = css.CSSID FROM CashSetShop css(nolock)
WHERE css.Opened=1
ORDER BY css.cssid DESC


SET ROWCOUNT @PageSize
SELECT CSSID AS CSSID, Name AS Name, CashPrice AS Cash, WebImgName AS WebImgName, 
	ResSex AS ResSex, ResLevel AS ResLevel, Weight AS Weight,
	Description AS Description, RegDate AS RegDate, NewItemOrder AS IsNewItem,
	RentType AS RentType
FROM CashSetShop css(nolock)
WHERE cssid <= @PageHead AND css.Opened=1
ORDER BY css.cssid DESC


SET ROWCOUNT 0
GO
/****** Object:  StoredProcedure [dbo].[spGetCharBRInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spGetCharBRInfo]
-- ALTER PROC dbo.spGetCharBRInfo
    @CID        INT
    , @BRID     INT
AS BEGIN

    SET NOCOUNT ON;

    WITH T1 AS
    (
        SELECT  CBRI.BRID, CBRI.BRTID, CBRI.BattleTime, CBRI.RewardCount, CBRI.KillCount
        FROM    dbo.CharacterBattleTimeRewardInfo CBRI(NOLOCK)
        WHERE   CBRI.CID = @CID
        AND     CBRI.BRID = @BRID
    ),
    T2 AS
    (   
        SELECT  BRT.BRID, MAX(BRT.BRTID) AS BRTID
        FROM    dbo.BattleTimeRewardTerm BRT(NOLOCK)
                JOIN dbo.BattleTimeRewardDescription BRD(NOLOCK)
                ON BRT.BRID = BRD.BRID
        WHERE   GETDATE() BETWEEN BRD.StartDate AND BRD.EndDate
        AND     DATEPART(hh, GETDATE()) BETWEEN BRD.StartHour AND BRD.EndHour
        AND     BRD.IsOpen = 1    
        AND     BRT.ClosedDate IS NULL   
        GROUP BY BRT.BRID
    )    
    SELECT  T1.BRID, T2.BRTID
            , CASE WHEN T1.BRTID = T2.BRTID   THEN T1.BattleTime
                                              ELSE 0 END AS 'BattleTime'
            , CASE WHEN T1.BRTID = T2.BRTID   THEN T1.RewardCount
                                              ELSE 0 END AS 'RewardCount'
            , CASE WHEN T1.BRTID = T2.BRTID   THEN T1.KillCount
                                              ELSE 0 END AS 'KillCount'
    FROM    T1 JOIN T2 ON T1.BRID = T2.BRID

END
GO
/****** Object:  StoredProcedure [dbo].[spGetCharBRInfoAll]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spGetCharBRInfoAll]
-- ALTER PROC dbo.spGetCharBRInfoAll
    @CID        INT
AS BEGIN

    SET NOCOUNT ON;

    WITH T1 AS
    (
        SELECT  CBRI.BRID, CBRI.BRTID, CBRI.BattleTime, CBRI.RewardCount, CBRI.KillCount
        FROM    dbo.CharacterBattleTimeRewardInfo CBRI(NOLOCK)
        WHERE   CBRI.CID = @CID
    ),
    T2 AS
    (   
        SELECT  BRT.BRID, MAX(BRT.BRTID) AS BRTID
        FROM    dbo.BattleTimeRewardTerm BRT(NOLOCK)
                JOIN dbo.BattleTimeRewardDescription BRD(NOLOCK)
                ON BRT.BRID = BRD.BRID
        WHERE   GETDATE() BETWEEN BRD.StartDate AND BRD.EndDate
        AND     DATEPART(hh, GETDATE()) BETWEEN BRD.StartHour AND BRD.EndHour
        AND     BRD.IsOpen = 1 
        AND     BRT.ClosedDate IS NULL   
        GROUP BY BRT.BRID
    )    
    SELECT  T1.BRID, T2.BRTID
            , CASE WHEN T1.BRTID = T2.BRTID   THEN T1.BattleTime
                                              ELSE 0 END AS 'BattleTime'
            , CASE WHEN T1.BRTID = T2.BRTID   THEN T1.RewardCount
                                              ELSE 0 END AS 'RewardCount'
            , CASE WHEN T1.BRTID = T2.BRTID   THEN T1.KillCount
                                              ELSE 0 END AS 'KillCount'
    FROM    T1 JOIN T2 ON T1.BRID = T2.BRID
    
END
GO
/****** Object:  StoredProcedure [dbo].[spGetCharClan]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Å¬·£ÀÌ¸§ ¾Ë¾Æ¿À±â
CREATE PROC [dbo].[spGetCharClan]
	@CID			int
AS
	SET NOCOUNT ON
	SELECT cl.CLID AS CLID, cl.Name AS ClanName FROM ClanMember cm(nolock), Clan cl(nolock) WHERE cm.cid=@CID AND cm.CLID=cl.CLID
GO
/****** Object:  StoredProcedure [dbo].[spGetCharEquipmentInfoByAID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------------------------------------------------------------------
-- ÀÛ¾÷ÇÒ Äõ¸®

CREATE PROC [dbo].[spGetCharEquipmentInfoByAID]
-- ALTER PROC dbo.spGetCharEquipmentInfoByAID
	@AID		INT, 
	@CharNum	SMALLINT
AS BEGIN
	SET NOCOUNT ON;
	
	DECLARE @CID INT
	SELECT @CID = CID FROM Character(NOLOCK) WHERE AID = @AID AND CharNum = @CharNum        
      
	SELECT	SlotID, ItemID, CIID
	FROM	CharacterEquipmentSlot(NOLOCK)
	WHERE	CID = @CID 
END

----------------------------------------------------------------------------------------------------------------------------------------
-- º¹±¸ Äõ¸®
/*
DROP PROC spGetCharEquipmentInfoByAID
*/
GO
/****** Object:  StoredProcedure [dbo].[spGetCharInfoByCharNum]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGetCharInfoByCharNum]
-- ALTER PROC dbo.spGetCharInfoByCharNum
	@AID		INT,
	@CharNum	SMALLINT
AS BEGIN        
	SET NOCOUNT ON;
	
	DECLARE @CID INT;	      
	SELECT @CID = CID FROM Character(NOLOCK) WHERE AID=@AID AND CharNum=@CharNum        
      
	SELECT	c.CID, c.AID, c.Name, c.Level, c.Sex, c.CharNum, c.Hair, c.Face      
			, c.XP, c.BP, c.HP, c.AP, c.FR, c.CR, c.ER, c.WR, c.GameCount, c.KillCount, c.DeathCount, c.PlayTime
			, cm.CLID, cl.Name AS 'ClanName', cm.Grade AS 'ClanGrade', cm.ContPoint AS ClanContPoint       
			, ISNULL(tr.Rank, 0) as 'rank'    
	FROM	( Character c(NOLOCK) LEFT OUTER JOIN TotalRanking tr(NOLOCK) ON c.name = tr.name )
			LEFT OUTER JOIN (Clan cl(NOLOCK) JOIN ClanMember cm(NOLOCK) ON cl.CLID = cm.CLID) ON c.CID = cm.CID      
	WHERE c.CID = @CID      
END 


----------------------------------------------------------------------------------------------------------------------------------------
-- º¹±¸ Äõ¸®
/*
DROP PROC spGetCharInfoByCharNum
EXEC sp_rename 'BackUp_spGetCharInfoByCharNum', 'spGetCharInfoByCharNum'
*/
GO
/****** Object:  StoredProcedure [dbo].[spGetCharList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* °èÁ¤ÀÇ Ä³¸¯ÅÍ ¸®½ºÆ® °¡Á®¿À±â  */
CREATE PROC [dbo].[spGetCharList]
	@AID		int
AS
SET NOCOUNT ON
SELECT c.CID AS CID, c.Name AS Name, c.CharNum AS CharNum, c.Level AS Level
FROM Character AS c WITH (nolock)
WHERE c.AID=@AID AND c.DeleteFlag = 0
GO
/****** Object:  StoredProcedure [dbo].[spGetCharNameByCID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------

create proc [dbo].[spGetCharNameByCID]
 @CID int
as 
 set nocount on
 select name from character(nolock) where CID = @CID
GO
/****** Object:  StoredProcedure [dbo].[spGetCIDbyCharName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------

create proc [dbo].[spGetCIDbyCharName]
 @Name varchar(24)
as
 set nocount on
 select cid from character(nolock) where name = @Name
GO
/****** Object:  StoredProcedure [dbo].[spGetClanHonorRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Å¬·£ ¸í¿¹ÀÇ Àü´ç º¸±â ¿ùº° 10À§±îÁö 
	2004³â 9¿ù ~ ÇöÀçÀú¹ø´Þ±îÁö(ÀÌ´Þ Á¦¿Ü) */
CREATE PROC [dbo].[spGetClanHonorRanking]
	@Year INT,
	@Month INT
AS
SET NOCOUNT ON
BEGIN
	SELECT TOP 10 r.Ranking, r.ClanName, r.Point, r.Wins, r.Losses, r.CLID, c.EmblemUrl 
	FROM ClanHonorRanking r(NOLOCK), Clan c(NOLOCK)
	WHERE r.CLID=c.CLID AND Year = @Year AND Month = @Month
	ORDER BY r.Ranking
END
GO
/****** Object:  StoredProcedure [dbo].[spGetClanInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Å¬·£ Á¤º¸ ¾ò±â
CREATE PROC [dbo].[spGetClanInfo]
	@CLID			int
AS
SET NOCOUNT ON

SELECT cl.CLID AS CLID, cl.Name AS Name, cl.TotalPoint AS TotalPoint, cl.Level AS Level, cl.Ranking AS Ranking,
cl.Point AS Point, cl.Wins AS Wins, cl.Losses AS Losses, cl.Draws AS Draws,
c.Name AS ClanMaster,
(SELECT COUNT(*) FROM ClanMember WHERE CLID=@CLID) AS MemberCount,
cl.EmblemUrl AS EmblemUrl, cl.EmblemChecksum AS EmblemChecksum

FROM Clan cl(nolock), Character c(nolock)
WHERE cl.CLID=@CLID and cl.MasterCID=c.CID
GO
/****** Object:  StoredProcedure [dbo].[spGetClanList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Å¬·£ ¸ñ·Ï º¸±â 
    ÇÑÆäÀÌÁö 15°³¾¿ °íÁ¤, ÃÖ´ë ÆäÀÌÁö ¼ö¸¦ À§ÇØ COUNT(*) ¾Ë¾Æ³»Áö ¸»°Í.(ÀÌÀü,´ÙÀ½ ÆäÀÌÁö·Î ÇØ°á) 
    Arg1 : @Page (ÆäÀÌÁö³Ñ¹ö)
    Arg2 : @Backward (»ý·«ÇÏ¸é Á¤»ó¼ø¼­, 1ÀÏ°æ¿ì ¿ª¼ø 					*/
CREATE PROC [dbo].[spGetClanList]
	@Page INT,
	@Backward INT  = 0
AS
SET NOCOUNT ON
BEGIN
	DECLARE @PageHead INT
	DECLARE @RowCount INT

	IF @Backward = 0
	BEGIN
		SELECT @RowCount = ((@Page -1) * 15 + 1)
		
		SET ROWCOUNT @RowCount
		SELECT @PageHead = CLID FROM Clan(NOLOCK) WHERE DeleteFlag=0 ORDER BY CLID DESC
		
		SET ROWCOUNT 15
		SELECT cl.CLID AS CLID, cl.Name as ClanName, c.Name AS Master, cl.RegDate AS RegDate, cl.EmblemUrl AS EmblemUrl, cl.Point AS Point
		FROM Clan cl(NOLOCK), Character c(nolock)
		WHERE cl.MasterCID=c.CID AND cl.DeleteFlag=0 AND cl.CLID<=@PageHead 
		ORDER BY cl.CLID DESC
	END
	ELSE
	BEGIN	-- ¿ª¼ø
		SELECT @RowCount = ((@Page -1) * 15 + 1)
		
		SET ROWCOUNT @RowCount
		SELECT @PageHead = CLID FROM Clan(NOLOCK) WHERE DeleteFlag=0 ORDER BY CLID
		
		SET ROWCOUNT 15
		SELECT CLID, ClanName, Master, RegDate, EmblemUrl, Point
		FROM
		(
			SELECT TOP 15 cl.CLID AS CLID, cl.Name as ClanName, c.Name AS Master, cl.RegDate AS RegDate, cl.EmblemUrl AS EmblemUrl, cl.Point AS Point
			FROM Clan cl(NOLOCK), Character c(nolock)
			WHERE cl.MasterCID=c.CID AND cl.DeleteFlag=0 AND cl.CLID>=@PageHead ORDER BY cl.CLID
		) AS t
		ORDER BY CLID DESC
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spGetClanListSearchByMaster]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Å¬·£ ¸ñ·ÏÃ£±â (¸¶½ºÅÍÀÌ¸§À¸·Î)
    Arg1 : @CharName (Å¬·£ÀÌ¸§) */
CREATE PROC [dbo].[spGetClanListSearchByMaster]
	@CharName VARCHAR(24)
AS
SET NOCOUNT ON
BEGIN

SELECT TOP 20 cl.CLID, cl.Name as ClanName, c.Name AS Master, cl.RegDate, cl.EmblemUrl, cl.Point
FROM Clan cl(NOLOCK), Character c(nolock)

WHERE cl.DeleteFlag=0 AND cl.MasterCID=c.CID and c.Name=@CharName
ORDER BY cl.CLID

END
GO
/****** Object:  StoredProcedure [dbo].[spGetClanListSearchByName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Å¬·£ ¸ñ·ÏÃ£±â (ÀÌ¸§À¸·Î)
    Arg1 : @Name (Å¬·£ÀÌ¸§) */
CREATE PROC [dbo].[spGetClanListSearchByName]
	@Name VARCHAR(24)
AS
SET NOCOUNT ON
BEGIN
	SELECT TOP 20 cl.CLID AS CLID, cl.Name as ClanName, c.Name AS Master, cl.RegDate AS RegDate, cl.EmblemUrl AS EmblemUrl, cl.Point AS Point
	FROM Clan cl(NOLOCK), Character c(NOLOCK)
	WHERE cl.MasterCID=c.CID AND c.DeleteFlag=0 AND cl.Name=@Name 
	ORDER BY cl.CLID
END
GO
/****** Object:  StoredProcedure [dbo].[spGetClanMember]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Å¬·£¿ø ¾Ë¾Æ¿À±â
CREATE PROC [dbo].[spGetClanMember]
	@CLID		int
AS
	SET NOCOUNT ON
	SELECT cm.clid AS CLID, cm.Grade AS ClanGrade, c.cid AS CID, c.name AS CharName
	FROM ClanMember cm(nolock), Character c(nolock)
	WHERE CLID=@CLID AND cm.cid=c.cid
GO
/****** Object:  StoredProcedure [dbo].[spGetClanRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- MasterÀÌ¸§°ú RegDateÃß°¡.
/* Å¬·£ ·©Å·º¸±â : ÇÑÆäÀÌÁö 20°³¾¿ °íÁ¤  
    Arg1 : @Page (ÆäÀÌÁö³Ñ¹ö)  
    Arg2 : @Backward (»ý·«ÇÏ¸é Á¤»ó¼ø¼­, 1ÀÏ°æ¿ì ¿ª¼ø */  
CREATE PROC [dbo].[spGetClanRanking]  
 @Page INT,  
 @Backward INT  = 0  
AS  
SET NOCOUNT ON
BEGIN  
 /* ÇÑÆäÀÌÁö¿¡ 20°³¾¿ º¸¿©ÁØ´Ù (¼Óµµ¸¦À§ÇØ °¹¼ö °íÁ¤) */  
 DECLARE @RowCount INT  
 DECLARE @PageHead INT  
  
 IF @Backward = 0  
 BEGIN  
  SELECT @RowCount = ((@Page -1) * 20 + 1)  
  SELECT TOP 20 cl.Ranking, cl.RankIncrease, cl.Name as ClanName, cl.Point, cl.Wins, cl.Losses, cl.CLID, cl.EmblemUrl, ch.Name AS Master, cl.RegDate
  FROM Clan cl(NOLOCK), Character ch(NOLOCK)
  WHERE cl.DeleteFlag=0 AND cl.Ranking>0 AND cl.Ranking >= @RowCount  AND ch.CID = cl.MasterCID
  ORDER BY cl.Ranking  
 END  
 ELSE  
 BEGIN  
  SELECT @RowCount = ((@Page -1) * 20 + 1)  
   
  SET ROWCOUNT @RowCount  
  SELECT @PageHead = Ranking FROM Clan(NOLOCK) WHERE DeleteFlag=0 ORDER BY Ranking DESC  
   
  SET ROWCOUNT 20  
  SELECT Ranking, RankIncrease, ClanName, Point, Wins, Losses, CLID, EmblemUrl, Master, RegDate FROM  
  (  
   SELECT TOP 20 cl.Ranking, cl.RankIncrease, cl.Name as ClanName, cl.Point, cl.Wins, cl.Losses, cl.CLID, cl.EmblemUrl, ch.Name AS Master, cl.RegDate
   FROM Clan cl(NOLOCK), Character ch(NOLOCK)
   WHERE cl.DeleteFlag=0 AND cl.Ranking>0 AND cl.Ranking <= @PageHead AND ch.CID = cl.MasterCID
   ORDER BY cl.Ranking DESC  
  ) AS t ORDER BY Ranking  
 END  
END
GO
/****** Object:  StoredProcedure [dbo].[spGetClanRankingHistory]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Å¬·£ ¿ª´ë ·©Å·Ã£±â
    Arg1 : @Year (³âµµ) 
    Arg2 : @Month (¿ù) 
    Arg3 : @Page (ÆäÀÌÁö) 
    Arg4 : @Backward (¿ª¼ø) */
CREATE  PROC [dbo].[spGetClanRankingHistory]
	@Year INT,
	@Month INT,
	@Page INT,
	@Backward INT = 0
AS
SET NOCOUNT ON
BEGIN
	/* ÇÑÆäÀÌÁö¿¡ 20°³¾¿ º¸¿©ÁØ´Ù (¼Óµµ¸¦À§ÇØ °¹¼ö °íÁ¤) */
	DECLARE @RowCount INT
	DECLARE @PageHead INT

	IF @Backward = 0
	BEGIN
		SELECT @RowCount = ((@Page -1) * 20 + 1)
		SELECT TOP 20 Ranking, ClanName as ClanName, Point, Wins, Losses, CLID FROM ClanHonorRanking(NOLOCK) 
		WHERE Year=@Year AND Month=@Month AND Ranking>0 AND Ranking >= @RowCount ORDER BY Ranking
	END
	ELSE
	BEGIN
		SELECT @RowCount = ((@Page -1) * 20 + 1)
	
		SET ROWCOUNT @RowCount
		SELECT @PageHead = Ranking FROM Clan(NOLOCK) WHERE DeleteFlag=0 ORDER BY Ranking DESC
	
		SET ROWCOUNT 20
		SELECT  Ranking, RankIncrease=0, ClanName, Point, Wins, Losses, CLID, EmblemUrl=NULL FROM
		(
			SELECT TOP 20 Ranking, ClanName, Point, Wins, Losses, CLID FROM ClanHonorRanking(NOLOCK) 
			WHERE Year=@Year AND Month=@Month AND Ranking>0 AND Ranking <= @PageHead ORDER BY Ranking DESC
		) AS t ORDER BY Ranking
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spGetClanRankingMaxPage]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGetClanRankingMaxPage]
AS
SET NOCOUNT ON
BEGIN
	DECLARE @MaxPage INT
	SELECT TOP 1 @MaxPage = Ranking / 20 + 1 FROM Clan(NOLOCK) WHERE DeleteFlag=0 AND Ranking>0 ORDER BY Ranking DESC
--	SELECT @MaxPage
	RETURN @MaxPage
END
GO
/****** Object:  StoredProcedure [dbo].[spGetClanRankingSearchByName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGetClanRankingSearchByName]
	@Name VARCHAR(24)
AS
SET NOCOUNT ON
BEGIN
	SELECT TOP 20 Ranking, RankIncrease, Name as ClanName, Point, Wins, Losses, CLID, EmblemUrl FROM Clan(NOLOCK) 
	WHERE DeleteFlag=0 AND Ranking>0 AND Name=@Name ORDER BY Ranking
END
GO
/****** Object:  StoredProcedure [dbo].[spGetClanRankingSearchByRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Å¬·£ ·©Å·Ã£±â (¼øÀ§·Î)
    Arg1 : @Ranking (¼øÀ§) */
CREATE PROC [dbo].[spGetClanRankingSearchByRanking]
	@Ranking INT
AS
SET NOCOUNT ON
BEGIN
	SELECT TOP 20 Ranking, RankIncrease, Name as ClanName, Point, Wins, Losses, CLID, EmblemUrl FROM Clan(NOLOCK) 
	WHERE DeleteFlag=0 AND Ranking>0 AND Ranking=@Ranking ORDER BY Ranking
END
GO
/****** Object:  StoredProcedure [dbo].[spGetCLIDFromClanName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Å¬·£ÀÌ¸§À¸·Î CLID¾Ë¾Æ¿À±â
CREATE PROC [dbo].[spGetCLIDFromClanName]
	@ClanName		varchar(24)
AS
	SET NOCOUNT ON
	SELECT CLID FROM Clan(NOLOCK) WHERE Name=@ClanName
GO
/****** Object:  StoredProcedure [dbo].[spGetFriendList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Ä£±¸ ¸ñ·Ï °¡Á®¿À±â
CREATE PROC [dbo].[spGetFriendList]
	@CID		int
AS
BEGIN    
 SET NOCOUNT ON
    
 SELECT  f.FriendCID, 0 AS 'Favorite', c.Name
 FROM Friend f(NOLOCK), Character c(NOLOCK)
 WHERE f.CID = @CID
  AND f.DeleteFlag = 0
  -- AND f.Type = 1
  AND f.FriendCID = c.CID
  AND c.DeleteFlag = 0
END
GO
/****** Object:  StoredProcedure [dbo].[spGetFriendList_backup_20080701]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Ä£±¸ ¸ñ·Ï °¡Á®¿À±â
CREATE PROC [dbo].[spGetFriendList_backup_20080701]
	@CID		int
AS
SET NOCOUNT ON

SELECT  f.FriendCID, f.Favorite,  c.Name 
FROM Friend f(NOLOCK), Character c(NOLOCK) 
WHERE f.CID=@CID AND f.FriendCID=c.CID AND f.DeleteFlag=0 AND f.Type=1
GO
/****** Object:  StoredProcedure [dbo].[spGetGambleItemList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROC [dbo].[spGetGambleItemList]
AS
BEGIN
 SET NOCOUNT ON
 
 SELECT GIID, Name, Description, Price
 , DATEDIFF(mi, GETDATE(), StartDate) AS 'StartDiffMin'
 , LifeTimeHour * 60 as 'LifeTimeMin', Opened, IsCash
 FROM GambleItem(NOLOCK) 
 WHERE Opened = 1
END
GO
/****** Object:  StoredProcedure [dbo].[spGetGambleRewardItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGetGambleRewardItem]  
AS  
BEGIN  
	SET NOCOUNT ON;
	
	SELECT	GRIID, GIID, ItemIDMale, ItemIDFemale, RentHourPeriod, RatePerThousand   
	FROM	GambleRewardItem(NOLOCK)  
END
GO
/****** Object:  StoredProcedure [dbo].[spGetHalloweenEventItemStatus]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetHalloweenEventItemStatus]
	@UserID		NVARCHAR(24)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @TrickItemID	INT
	DECLARE @TreatItemID	INT
	
	DECLARE @UpdatedDate	DATETIME
	DECLARE @Trick			INT
	DECLARE @Treat			INT
	
	SELECT	@TrickItemID = 403010, @TreatItemID = 403011
	
	SELECT	@UpdatedDate = e.UpdatedDate, @Trick = e.Trick, @Treat = e.Treat
	FROM	Event_CharacterItem_Halloween e
	WHERE	e.UserID = @UserID

	IF( @UpdatedDate IS NULL OR DATEDIFF(n, @UpdatedDate, GETDATE()) > 5 )
	BEGIN
		SELECT	@Trick = COUNT(ci.ItemID)
		FROM	(	SELECT	c.CID, a.UserID
					FROM	Account a(NOLOCK), Character c(NOLOCK)
					WHERE	a.UserID = @UserID
					AND		a.AID = c.AID
					AND		c.DeleteFlag = 0 ) r
				, CharacterItem ci(NOLOCK)
		WHERE	ci.CID = r.CID
		AND		ci.ItemID = @TrickItemID
		GROUP BY ci.ItemID
			
		SELECT	@Treat = COUNT(ci.ItemID)
		FROM	(	SELECT	c.CID, a.UserID
					FROM	Account a(NOLOCK), Character c(NOLOCK)
					WHERE	a.UserID = @UserID
					AND		a.AID = c.AID
					AND		c.DeleteFlag = 0 ) r
				, CharacterItem ci(NOLOCK)
		WHERE	ci.CID = r.CID
		AND		ci.ItemID = @TreatItemID
		GROUP BY ci.ItemID
		
		IF( @UpdatedDate IS NULL ) BEGIN
			INSERT Event_CharacterItem_Halloween(UserID, UpdatedDate, Trick, Treat)
			VALUES(@UserID, GETDATE(), @Trick, @Treat)
		END 
		ELSE BEGIN
			UPDATE	Event_CharacterItem_Halloween
			SET		Trick = @Trick, Treat = @Treat, UpdatedDate = GETDATE()
			WHERE	UserID = @UserID
		END		
	END

	SELECT	CASE WHEN @Trick IS NULL THEN 0 ELSE @Trick END AS 'Trick'
			, CASE WHEN @Treat IS NULL THEN 0 ELSE @Treat END AS 'Treat'
END
GO
/****** Object:  StoredProcedure [dbo].[spGetIPtoCountryList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-------------------------------------------------------------------

CREATE PROC [dbo].[spGetIPtoCountryList]  
AS  
 SELECT IPFrom, IPTo, CountryCode3   
 FROM IPtoCountry(NOLOCK)  
 ORDER BY IPFrom
GO
/****** Object:  StoredProcedure [dbo].[spGetItemList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
----------------------------------------------------------------------------

create proc [dbo].[spGetItemList]
 @ItemType int -- 0:any 1:melee 2:range 3:amor 4:special
, @Page int
, @PageCount int output
, @PageSize int
, @ItemSex tinyint -- 0:common 1:male 2:female
, @ItemLevel int -- max level 0:any
, @ItemName varchar(256)
, @Ret int output
as
 set nocount on

 declare @sql varchar(8000)
 declare @ItemTypeWhere varchar(256)
 declare @PageSizeWhere varchar(256)
 declare @ItemSexWhere varchar(256)
 declare @ItemLevelWhere varchar(256)
 declare @ItemNameWhere varchar(256)
 declare @rowcnt int
 declare @itemcnt int

 if (0 > @ItemType) or (4 < @ItemType) begin
  set @Ret = -1
  return @Ret
 end

 set @rowcnt = @page * @pagesize

 select @itemcnt = count(itemid) from item(nolock)
 if @rowcnt > @itemcnt begin
  set @Ret = -2
  return @Ret
 end 

 set @ItemTypeWhere = ''
 set @PageSizeWhere = ''
 set @ItemSexWhere = ''
 set @ItemLevelWhere = ''
 set @ItemNameWhere = ''

 set @PageCount = @itemcnt / @PageSize

 if 1 = @ItemType begin
  set @ItemTypeWhere = 'and i.Slot = 1 '
 end
 else if 2 = @ItemType begin
  set @ItemTypeWhere = 'and i.Slot = 2 '
 end
 else if 3 = @ItemType begin
  set @ItemTypeWhere = 'and (i.Slot = 4 or i.Slot = 5 or i.Slot = 6 or
 i.Slot = 7 or i.Slot = 8) '
 end
 else if 4 = @ItemType begin
  set @ItemTypeWhere = 'and i.SlotType = 3 or i.SlotType = 10 '
 end

 if 1 = @ItemSex begin
  set @ItemSexWhere = 'and i.ResSex = 1 '
 end
 else if 2 = @ItemSex begin
  set @ItemSexWhere = 'and i.ResSex = 2'
 end

 if 0 < @ItemLevel begin
  set @ItemLevelWhere = 'and  i.ResLevel <= ' + cast(@ItemLevel as char(2)) + ' '
 end

 if @itemName is not null begin
  set @ItemNameWhere = 'and i.Name like ''%' + @ItemName + '%'''
 end

 set @sql = '
  declare @csid table(id int)

  set rowcount ' + cast(@rowcnt as varchar(128)) + '

  insert into @csid(id) select cs.csid from item i(nolock), cashshop cs(nolock)
  where i.itemid = cs.itemid '  
  + @ItemTypeWhere
  + @ItemSexWhere
  + @ItemLevelWhere
  + @ItemNameWhere
  + ' order by cs.csid
  set rowcount ' + cast(@PageSize as varchar(128)) + ' 

  select t.*
  from
  (
   select top ' + cast(@PageSize as varchar(128)) + ' 
   cs.CSID, i.Name, i.Slot, cs.CashPrice as Cash, cs.WebImgName
    , i.ResSex, i.ResLevel, i.Weight, i.Description, cs.RegDate
    , cs.NewItemOrder, cs.RentType
   from cashshop cs(nolock), @csid c, item i(nolock)
   where cs.csid = c.id and i.itemid = cs.itemid
   order by cs.csid desc
  ) as t
  order by t.csid'

 exec (@sql)

 set @Ret = 1
 return @Ret
GO
/****** Object:  StoredProcedure [dbo].[spGetLadderTeamMemberByCID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ÆÀ¸â¹ö ¾ò¾î¿À±â
CREATE PROC [dbo].[spGetLadderTeamMemberByCID]
	@CID		int
AS
RETURN
GO
/****** Object:  StoredProcedure [dbo].[spGetLoginInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* LoginInfo ¾ò¾î¿È */
CREATE PROC [dbo].[spGetLoginInfo]
	@UserID		varchar(20)
AS
SET NOCOUNT ON
SELECT AID, UserID, Password FROM Login(nolock) WHERE UserID = @UserID
GO
/****** Object:  StoredProcedure [dbo].[spGetNewCashItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROC [dbo].[spGetNewCashItem]
	@ItemCount	int 	= 0
AS
SET NoCount On

IF @ItemCount != 0
BEGIN
	SET ROWCOUNT @ItemCount
END

	SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot, 
		cs.CashPrice AS Cash, cs.WebImgName As WebImgName,
		i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight,
		i.Description AS Description, cs.RentType AS RentType
	FROM CashShop cs (nolock) , Item i (nolock)
	WHERE i.ItemID = cs.ItemID AND cs.NewItemOrder > 0 AND Opened=1 
	order by cs.NewItemOrder asc
GO
/****** Object:  StoredProcedure [dbo].[spGetRaffleEventTrgUsers]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGetRaffleEventTrgUsers]
  @mins  int, 
  @sdate char(8)
AS
SET NOCOUNT ON 

declare @pdate datetime

if (@sdate is null)
begin
	set @sdate=convert(varchar,getdate()-1,112)
end

set @pdate=cast(@sdate as datetime)

insert into dbo.tmp_summerwave_raffle_event(sdate, userid, playtime, gifttype)
select * from 
(select @sdate AS sdate, c.userid, sum(b.psum) playtime, -1 AS gifttype from character as a
left join (
select cid, sum(playtime) psum from PlayerLog
where distime>=@pdate and distime < @pdate+1
group by cid) as b on a.cid = b.cid
left join account c on a.aid = c.aid
where c.userid is not null
group by a.aid, c.userid
having sum(b.psum) > @mins*60) AS n
where n.userid not in (select userid from tmp_summerwave_raffle_event where sdate = @sdate)
GO
/****** Object:  StoredProcedure [dbo].[spGetRentCashSetShopPrice]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ±â°£Á¦ ¼¼Æ® ¾ÆÀÌÅÛ »óÇ° °¡°Ý º¸±â
CREATE  PROC [dbo].[spGetRentCashSetShopPrice]
	@CSSID		int
AS
	SET NOCOUNT ON
	SELECT RentHourPeriod, CashPrice 
	FROM RentCashSetShopPrice(nolock) WHERE CSSID = @CSSID
	ORDER BY CashPrice
GO
/****** Object:  StoredProcedure [dbo].[spGetRentCashSetShopPriceByHour]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGetRentCashSetShopPriceByHour]
	@CSSID		int
,	@RentHourPeriod	smallint
AS
	SET NOCOUNT ON
	IF @RentHourPeriod IS NOT NULL
	BEGIN
		-- ±â°£Á¦ ¾ÆÀÌÅÛ
		SELECT CashPrice
		FROM RentCashSetShopPrice(nolock)
		WHERE CSSID = @CSSID AND RentHourPeriod = @RentHourPeriod
	END
	ELSE IF @RentHourPeriod IS NULL
	BEGIN
		-- ¿µ±¸ ¾ÆÀÌÅÛ.
		SELECT CashPrice
		FROM RentCashSetShopPrice(nolock)
		WHERE CSSID = @CSSID AND RentHourPeriod IS NULL
	END
GO
/****** Object:  StoredProcedure [dbo].[spGetRentCashShopPrice]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ±â°£Á¦ ¾ÆÀÌÅÛ »óÇ° °¡°Ý º¸±â
CREATE PROC [dbo].[spGetRentCashShopPrice]
	@CSID		int
AS
	SET NOCOUNT ON
	SELECT RentHourPeriod, CashPrice 
	FROM RentCashShopPrice(nolock) WHERE CSID = @CSID
	ORDER BY CashPrice
GO
/****** Object:  StoredProcedure [dbo].[spGetRentCashShopPriceByHour]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[spGetRentCashShopPriceByHour]
	@CSID		int
,	@RentHourPeriod	smallint
AS
	SET NOCOUNT ON
	IF @RentHourPeriod IS NOT NULL
	BEGIN
		-- ±â°£Á¦ ¾ÆÀÌÅÛ
		SELECT CashPrice 
		FROM RentCashShopPrice (nolock)
		WHERE CSID = @CSID AND RentHourPeriod = @RentHourPeriod
	END
	ELSE IF @RentHourPeriod IS NULL
	BEGIN
		-- ¿µ±¸ ¾ÆÀÌÅÛ
		SELECT CashPrice
		FROM RentCashShopPrice (nolock)
		WHERE CSID = @CSID AND RentHourPeriod IS NULL
	END
GO
/****** Object:  StoredProcedure [dbo].[spGetSexInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ¼ºº° Á¤º¸ ¾ò¾î¿È */
CREATE PROC [dbo].[spGetSexInfo]
	@AID		int
AS
SET NOCOUNT ON
SELECT Sex, RegNum, Email FROM Account WHERE AID=@AID
GO
/****** Object:  StoredProcedure [dbo].[spGetStampEventTrgUsers]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGetStampEventTrgUsers]
  @sdate char(8)
AS
SET NOCOUNT ON 

declare @pdate datetime

if (@sdate is null)
begin
	set @sdate=convert(varchar,getdate()-1,112)
end

set @pdate=cast(@sdate as datetime)

insert into dbo.tmp_stampevent(sdate, userid, playtime)
(select @sdate, c.userid, sum(b.psum) playtime from character as a
left join (
select cid, sum(playtime) psum from PlayerLog
where distime>=@pdate and distime<@pdate+1
group by cid) as b on a.cid = b.cid
left join account c on a.aid = c.aid
where c.userid is not null
group by a.aid, c.userid
having sum(b.psum) > 60*60)
GO
/****** Object:  StoredProcedure [dbo].[spGetSurvivalGroupRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetSurvivalGroupRanking]
AS BEGIN
	SET NOCOUNT ON;
	
	SELECT t.SID, t.CID, c.Name, t.Ranking, t.RP
	FROM 
	(
		SELECT s.SID, s.CID, s.RP, r.Ranking
		FROM SurvivalCharacterInfo s WITH (NOLOCK), SurvivalRanking r WITH (NOLOCK)
		WHERE s.RankRP = r.RP
			AND s.SID = r.SID
			AND r.Ranking <= 10 
			AND r.SID IN (1, 2, 3)
	) AS t, Character c WITH (NOLOCK)
	WHERE t.CID = c.CID 
	ORDER BY SID, Ranking
END
GO
/****** Object:  StoredProcedure [dbo].[spGetSurvivalPrivateRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetSurvivalPrivateRanking]
(
	@nCID int
)
AS 
BEGIN	
	SET NOCOUNT ON;
	
	SELECT s.SID, s.CID, s.RP, r.Ranking
	FROM SurvivalCharacterInfo s WITH (NOLOCK), SurvivalRanking r WITH (NOLOCK)
	WHERE r.SID = s.SID
		AND r.RP = s.RankRP		
		AND r.SID IN (1, 2, 3)
		AND s.CID = @nCID;
END
GO
/****** Object:  StoredProcedure [dbo].[spGetTotalRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ÀüÃ¼ ·©Å· º¸±â */
CREATE PROC [dbo].[spGetTotalRanking]
	@MinRank		int,
	@MaxRank		int
AS
SET NOCOUNT ON

SELECT Rank, Level, UserID, Name, XP, KillCount, DeathCount FROM TotalRanking(nolock)
WHERE Rank BETWEEN @MinRank AND @MaxRank
ORDER BY Rank
GO
/****** Object:  StoredProcedure [dbo].[spInsertAccount]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spInsertAccount]
	@UserID		varchar(20)
	, @Password	varchar(20)
	, @Cert		tinyint
	, @Name		varchar(128)
	, @Age		smallint
	, @Sex		tinyint

AS
BEGIN TRAN
 	SET NOCOUNT ON
	DECLARE @AIDIdent 	int

	INSERT INTO Account (UserID, Cert, Name, Age, Sex, UGradeID, PGradeID, RegDate)
	Values (@UserID, @Cert, @Name, @Age, @Sex, 0, 0, GETDATE())
	IF 0 <> @@ERROR
	BEGIN
		ROLLBACK TRAN
		RETURN
	END

	SET @AIDIdent = @@IDENTITY

	INSERT INTO Login (UserID, AID, Password, UGradeID)
	Values (@UserID, @AIDIdent, @Password, 0)
	IF 0 <> @@ERROR
	BEGIN
		ROLLBACK TRAN
		RETURN
	END
	
	IF (GETDATE() < '2009-06-29T07:00:00')
	BEGIN
		INSERT INTO dbo.EventAccount(AID, UserID)
		VALUES (@AIDIdent, @UserID);
		IF (0 <> @@ERROR)
		BEGIN
			ROLLBACK TRAN;
			RETURN;
		END
	END
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[spInsertAccountPenaltyInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spInsertAccountPenaltyInfo]
-- ALTER PROC dbo.spInsertAccountPenaltyInfo
	@AID			INT	
	, @PCode		TINYINT
	, @PHour		INT
	, @GM_ID		VARCHAR(24)
AS BEGIN
	SET NOCOUNT ON	
	
	BEGIN TRAN -----------------
	
		UPDATE	AccountPenaltyGMLog
		SET		Reset_Date = GETDATE(), Reset_GM_TypeID = 2, Reset_GM_ID = @GM_ID
		WHERE	AID = @AID
		AND		PCode = @PCode
		AND		Reset_Date IS NULL

		INSERT AccountPenaltyGMLog(AID, PEndDate, PCode, Set_GM_TypeID, Set_GM_ID, Set_Date)
		VALUES (@AID, DATEADD(hh, @PHour, GETDATE()), @PCode, 2, @GM_ID, GETDATE())		
		
	COMMIT TRAN ----------------		
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertChar]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spInsertChar]
-- ALTER PROC dbo.spInsertChar
	@AID		INT,
	@CharNum	SMALLINT,
	@Name		VARCHAR(24),
	@Sex		TINYINT,
	@Hair		INT,
	@Face		INT,
	@Costume	INT

AS BEGIN

	SET NOCOUNT ON;
	
	IF EXISTS(SELECT CID FROM dbo.Character where (AID=@AID AND CharNum=@CharNum) OR (Name=@Name)) BEGIN   
		SELECT -1 AS 'Ret';
		RETURN;
	END  

	DECLARE @CharIdent		INT;
	DECLARE @ChestCIID		INT;
	DECLARE @LegsCIID		INT;
	DECLARE @MeleeCIID		INT;
	DECLARE @PrimaryCIID	INT;
	DECLARE @SecondaryCIID	INT; 
	DECLARE @Custom1CIID	INT;
	DECLARE @Custom2CIID	INT;
	
	DECLARE @ChestItemID		INT;
	DECLARE @LegsItemID			INT;
	DECLARE @MeleeItemID		INT;
	DECLARE @PrimaryItemID		INT;
	DECLARE @SecondaryItemID	INT;
	DECLARE @Custom1ItemID		INT;
	DECLARE @Custom2ItemID		INT;
	
	DECLARE @NowDate DATETIME;
	SET @NowDate = GETDATE();

	SET @SecondaryCIID = NULL  
	SET @SecondaryItemID = NULL  

	SET @Custom1CIID = NULL  
	SET @Custom1ItemID = NULL  

	SET @Custom2CIID = NULL  
	SET @Custom2ItemID = NULL  

	BEGIN TRAN -----------
	
		INSERT INTO dbo.Character(AID, Name, CharNum, Level, Sex, Hair, Face, XP, BP, FR, CR, ER, WR,
									 GameCount, KillCount, DeathCount, RegDate, PlayTime, DeleteFlag)  
		Values(@AID, @Name, @CharNum, 1, @Sex, @Hair, @Face, 0, 0, 0, 0, 0, 0, 0, 0, 0, @NowDate, 0, 0)
		
		IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN
			ROLLBACK TRAN
			SELECT -2 AS 'Ret';
			RETURN;
		END
			

		SET @CharIdent = @@IDENTITY  


		/* Melee */  
		SET @MeleeItemID =   
			CASE @Costume  
				WHEN 0 THEN 1  
				WHEN 1 THEN 2  
				WHEN 2 THEN 1  
				WHEN 3 THEN 2  
				WHEN 4 THEN 2  
				WHEN 5 THEN 1  
			END  

		INSERT INTO dbo.CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt) 
		VALUES (@CharIdent, @MeleeItemID, @NowDate, @NowDate, 0, 1)
		IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN
			ROLLBACK TRAN
			SELECT -3 AS 'Ret';
			RETURN;
		END
		
		SET @MeleeCIID = @@IDENTITY
				
		/* Primary */  
		SET @PrimaryItemID =   
			CASE @Costume  
				WHEN 0 THEN 5001  
				WHEN 1 THEN 5002  
				WHEN 2 THEN 4005  
				WHEN 3 THEN 4001  
				WHEN 4 THEN 4002  
				WHEN 5 THEN 4006  
			END  

		INSERT INTO dbo.CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt) 
		VALUES (@CharIdent, @PrimaryItemID, @NowDate, @NowDate, 0, 1)
		IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN
			ROLLBACK TRAN
			SELECT -5 AS 'Ret';
			RETURN;
		END
	
		SET @PrimaryCIID = @@IDENTITY;			
		
				
		/* Secondary */  
		IF( @Costume = 0 OR @Costume = 2 ) BEGIN  
			SET @SecondaryItemID =  
				CASE @Costume  
					WHEN 0 THEN 4001  
					WHEN 1 THEN 0  
					WHEN 2 THEN 5001  
					WHEN 3 THEN 4006  
					WHEN 4 THEN 0  
					WHEN 5 THEN 4006  
				END  

			IF( @SecondaryItemID <> 0 ) BEGIN  
				INSERT INTO CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt) 
				VALUES (@CharIdent, @SecondaryItemID, @NowDate, @NowDate, 0, 1)
				IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN
					ROLLBACK TRAN
					SELECT -7 AS 'Ret';
					RETURN;
				END
				
				SET @SecondaryCIID = @@IDENTITY;								
			END  
		END 
	 
	
		/* Custom1 */ 
		SET @Custom1ItemID =   
			CASE @Costume  
				WHEN 0 THEN 30301
				WHEN 1 THEN 30301
				WHEN 2 THEN 30401
				WHEN 3 THEN 30401
				WHEN 4 THEN 30401
				WHEN 5 THEN 30101
			END
				 	
		INSERT INTO dbo.CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt) 
		VALUES (@CharIdent, @Custom1ItemID, @NowDate, @NowDate, 0, 1)
		IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN
			ROLLBACK TRAN
			SELECT -9 AS 'Ret';
			RETURN;
		END
							
		SET @Custom1CIID = @@IDENTITY
		
		/* Custom2 */  
		IF( @Costume = 4 OR @Costume = 5 ) BEGIN  
			SET @Custom2ItemID =  
				CASE @Costume  
					WHEN 0 THEN 0
					WHEN 1 THEN 0
					WHEN 2 THEN 0
					WHEN 3 THEN 0
					WHEN 4 THEN 30001
					WHEN 5 THEN 30001
				END

			IF( @Custom2ItemID <> 0 ) BEGIN  
				INSERT INTO CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt) 
				VALUES (@CharIdent, @Custom2ItemID, @NowDate, @NowDate, 0, 1)
				IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN
					SELECT -11 AS 'Ret';
					RETURN;
				END
				
				SET @Custom2CIID = @@IDENTITY;				
				
			END  
		END  

		/* ³²ÀÚÀÏ °æ¿ì */
		IF( @Sex = 0 ) BEGIN  
			
			/* Chest */  
			SET @ChestItemID =  
				CASE @Costume  
					WHEN 0 THEN 21001  
					WHEN 1 THEN 21001  
					WHEN 2 THEN 21001  
					WHEN 3 THEN 21001  
					WHEN 4 THEN 21001  
					WHEN 5 THEN 21001  
				END

			INSERT INTO CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt) 
			VALUES (@CharIdent, @ChestItemID, @NowDate, @NowDate, 0, 1)
			IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN
				ROLLBACK TRAN
				SELECT -13 AS 'Ret';
				RETURN;
			END
			
			SET @ChestCIID = @@IDENTITY
			
			
			/* Legs */  
			SET @LegsItemID =  
				CASE @Costume  
					WHEN 0 THEN 23001  
					WHEN 1 THEN 23001  
					WHEN 2 THEN 23001  
					WHEN 3 THEN 23001  
					WHEN 4 THEN 23001  
					WHEN 5 THEN 23001  
				END  

			INSERT INTO CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt) 
			VALUES (@CharIdent, @LegsItemID, @NowDate, @NowDate, 0, 1)
			IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN
				ROLLBACK TRAN
				SELECT -15 AS 'Ret';
				RETURN;
			END
			
			SET @LegsCIID = @@IDENTITY;
						
		END 
		/* ¿©ÀÚÀÏ °æ¿ì */  
		ELSE BEGIN   
			
			/* Chest */  
			SET @ChestItemID =  
				CASE @Costume  
					WHEN 0 THEN 21501  
					WHEN 1 THEN 21501  
					WHEN 2 THEN 21501  
					WHEN 3 THEN 21501  
					WHEN 4 THEN 21501  
					WHEN 5 THEN 21501  
				END 

			INSERT INTO dbo.CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt) 
			VALUES (@CharIdent, @ChestItemID, @NowDate, @NowDate, 0, 1)
			IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN
				ROLLBACK TRAN
				SELECT -17 AS 'Ret';
				RETURN;
			END
			
			SET @ChestCIID = @@IDENTITY  
			
			
			/* Legs */  
			SET @LegsItemID =  
				CASE @Costume  
					WHEN 0 THEN 23501  
					WHEN 1 THEN 23501  
					WHEN 2 THEN 23501  
					WHEN 3 THEN 23501  
					WHEN 4 THEN 23501  
					WHEN 5 THEN 23501  
				END  

			INSERT INTO dbo.CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt) 
			VALUES (@CharIdent, @LegsItemID, @NowDate, @NowDate, 0, 1)
			IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN
				ROLLBACK TRAN
				SELECT -19 AS 'Ret';
				RETURN;
			END
			
			SET @LegsCIID = @@IDENTITY;
		END
		
	COMMIT TRAN -----------
		
	INSERT dbo.CharacterEquipmentSlot(CID, SlotID)
		SELECT	@CharIdent, SlotID
		FROM	dbo.CharacterEquipmentSlotCode(NOLOCK)
			
	UPDATE	dbo.CharacterEquipmentSlot 
	SET		CIID = @ChestCIID, ItemID = @ChestItemID 
	WHERE	CID = @CharIdent AND SlotID = 1;
	
	UPDATE	dbo.CharacterEquipmentSlot 
	SET		CIID = @LegsCIID, ItemID = @LegsItemID 
	WHERE	CID = @CharIdent AND SlotID = 3;
	
	UPDATE	dbo.CharacterEquipmentSlot 
	SET		CIID = @MeleeCIID, ItemID = @MeleeItemID 
	WHERE	CID = @CharIdent AND SlotID = 7;
	
	UPDATE	dbo.CharacterEquipmentSlot 
	SET		CIID = @PrimaryCIID, ItemID = @PrimaryItemID 
	WHERE	CID = @CharIdent AND SlotID = 8;
	
	UPDATE	dbo.CharacterEquipmentSlot 
	SET		CIID = @SecondaryCIID, ItemID = @SecondaryItemID 
	WHERE	CID = @CharIdent AND SlotID = 9;
	
	UPDATE	dbo.CharacterEquipmentSlot 
	SET		CIID = @Custom1CIID, ItemID = @Custom1ItemID 
	WHERE	CID = @CharIdent AND SlotID = 10;
	
	UPDATE	dbo.CharacterEquipmentSlot 
	SET		CIID = @Custom2CIID, ItemID = @Custom2ItemID 
	WHERE	CID = @CharIdent AND SlotID = 11;
	
	SELECT 0 AS 'Ret'
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertChar_backup_20071218]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 캐릭터 추가 */    
CREATE  PROC [dbo].[spInsertChar_backup_20071218]    
 @AID  int,    
 @CharNum smallint,    
 @Name  varchar(24),    
 @Sex  tinyint,    
 @Hair  int,      
 @Face  int,    
 @Costume int    
AS    
BEGIN    
 SET NOCOUNT ON    
    
 IF EXISTS (SELECT CID FROM Character where (AID=@AID AND CharNum=@CharNum) OR (Name=@Name))    
 BEGIN     
 return(-1)    
 END    
    
 DECLARE @CharIdent  int    
 DECLARE @ChestCIID int    
 DECLARE @LegsCIID int    
 DECLARE @MeleeCIID int    
 DECLARE @PrimaryCIID int    
 DECLARE @SecondaryCIID  int    
 DECLARE @Custom1CIID int    
 DECLARE @Custom2CIID int    
  
 DECLARE @ChestItemID int    
 DECLARE @LegsItemID int    
 DECLARE @MeleeItemID int    
 DECLARE @PrimaryItemID int    
 DECLARE @SecondaryItemID  int    
 DECLARE @Custom1ItemID int    
 DECLARE @Custom2ItemID int    
    
 SET @SecondaryCIID = NULL    
 SET @SecondaryItemID = NULL    
    
 SET @Custom1CIID = NULL    
 SET @Custom1ItemID = NULL    
    
 SET @Custom2CIID = NULL    
 SET @Custom2ItemID = NULL    
    
 BEGIN TRAN    
    
  INSERT INTO Character     
 (AID, Name, CharNum, Level, Sex, Hair, Face, XP, BP, FR, CR, ER, WR,     
         GameCount, KillCount, DeathCount, RegDate, PlayTime, DeleteFlag)    
  Values    
 (@AID, @Name, @CharNum, 1, @Sex, @Hair, @Face, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 0, 0)    
  IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN    
   ROLLBACK TRAN    
   RETURN (-1)    
  END    
    
    
  SET @CharIdent = SCOPE_IDENTITY()    
    
  /* Melee */    
  SET @MeleeItemID =     
    CASE @Costume    
    WHEN 0 THEN 1    
    WHEN 1 THEN 2    
    WHEN 2 THEN 1    
    WHEN 3 THEN 2    
    WHEN 4 THEN 2    
    WHEN 5 THEN 1    
    END    
    
  INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @MeleeItemID)    
  IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN    
   ROLLBACK TRAN    
   RETURN (-1)    
  END    
    
  SET @MeleeCIID = SCOPE_IDENTITY()    
    
  /* Primary */    
  SET @PrimaryItemID =     
    CASE @Costume    
    WHEN 0 THEN 5001    
    WHEN 1 THEN 5002    
    WHEN 2 THEN 4005    
    WHEN 3 THEN 4001    
    WHEN 4 THEN 4002    
    WHEN 5 THEN 4006    
    END    
    
  INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @PrimaryItemID)    
  IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN    
   ROLLBACK TRAN    
   RETURN (-1)    
  END    
    
  SET @PrimaryCIID = SCOPE_IDENTITY()    
    
  /* Secondary */    
  IF @Costume = 0 OR @Costume = 2    
  BEGIN    
   SET @SecondaryItemID =    
     CASE @Costume    
     WHEN 0 THEN 4001    
     WHEN 1 THEN 0    
     WHEN 2 THEN 5001    
     WHEN 3 THEN 4006    
     WHEN 4 THEN 0    
     WHEN 5 THEN 4006    
     END    
    
   IF @SecondaryItemID <> 0    
   BEGIN    
    INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @SecondaryItemID)    
    IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN    
     ROLLBACK TRAN    
     RETURN (-1)    
    END    
    
    SET @SecondaryCIID = SCOPE_IDENTITY()    
   END    
  END    
    
  SET @Custom1ItemID =     
    CASE @Costume    
    WHEN 0 THEN 30301    
    WHEN 1 THEN 30301    
    WHEN 2 THEN 30401    
    WHEN 3 THEN 30401    
    WHEN 4 THEN 30401    
    WHEN 5 THEN 30101    
    END    
    
  /* Custom1 */    
  INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @Custom1ItemID)    
  IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN    
   ROLLBACK TRAN    
   RETURN (-1)    
  END    
    
  SET @Custom1CIID = SCOPE_IDENTITY()    
    
  /* Custom2 */    
  IF @Costume = 4 OR @Costume = 5    
  BEGIN    
   SET @Custom2ItemID =    
    CASE @Costume    
    WHEN 0 THEN 0    
    WHEN 1 THEN 0    
    WHEN 2 THEN 0    
    WHEN 3 THEN 0    
    WHEN 4 THEN 30001    
    WHEN 5 THEN 30001    
    END    
    
   IF @Custom2ItemID <> 0    
   BEGIN    
    INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @Custom2ItemID)    
    IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN    
     ROLLBACK TRAN    
     RETURN (-1)    
    END    
    
    SET @Custom2CIID = SCOPE_IDENTITY()    
   END    
  END    
    
    
  IF @Sex = 0  /* 남자일 경우 */    
  BEGIN    
   /* Chest */    
   SET @ChestItemID =    
    CASE @Costume    
    WHEN 0 THEN 21001    
    WHEN 1 THEN 21001    
    WHEN 2 THEN 21001    
    WHEN 3 THEN 21001    
    WHEN 4 THEN 21001    
    WHEN 5 THEN 21001    
    END    
    
    
   INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @ChestItemID)    
   IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN    
    ROLLBACK TRAN    
    RETURN (-1)    
   END    
    
   SET @ChestCIID = SCOPE_IDENTITY()    
    
   /* Legs */    
   SET @LegsItemID =    
    CASE @Costume    
    WHEN 0 THEN 23001    
    WHEN 1 THEN 23001    
    WHEN 2 THEN 23001    
    WHEN 3 THEN 23001    
    WHEN 4 THEN 23001    
    WHEN 5 THEN 23001    
    END    
    
    
   INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @LegsItemID)    
   IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN    
    ROLLBACK TRAN    
    RETURN (-1)    
   END    
   SET @LegsCIID = @@IDENTITY    
  END    
  ELSE    
  BEGIN   /* 여자일 경우 */    
    
   /* Chest */    
   SET @ChestItemID =    
    CASE @Costume    
    WHEN 0 THEN 21501    
    WHEN 1 THEN 21501    
    WHEN 2 THEN 21501    
    WHEN 3 THEN 21501    
    WHEN 4 THEN 21501    
    WHEN 5 THEN 21501    
    END    
    
   INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @ChestItemID)    
   IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN    
    ROLLBACK TRAN    
    RETURN (-1)    
   END    
   SET @ChestCIID = SCOPE_IDENTITY()    
    
   /* Legs */    
   SET @LegsItemID =    
    CASE @Costume    
    WHEN 0 THEN 23501    
    WHEN 1 THEN 23501    
    WHEN 2 THEN 23501    
    WHEN 3 THEN 23501    
    WHEN 4 THEN 23501    
    WHEN 5 THEN 23501    
    END    
    
    
   INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @LegsItemID)    
   IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN    
    ROLLBACK TRAN    
    RETURN (-1)    
   END    
   SET @LegsCIID = SCOPE_IDENTITY()    
  END      
    
  UPDATE Character    
  SET chest_slot = @ChestCIID, legs_slot = @LegsCIID, melee_slot = @MeleeCIID,    
    primary_slot = @PrimaryCIID, secondary_slot = @SecondaryCIID, custom1_slot = @Custom1CIID,    
    custom2_slot = @Custom2CIID,    
    chest_itemid = @ChestItemID, legs_itemid = @LegsItemID, melee_itemid = @MeleeItemID,    
    primary_itemid = @PrimaryItemID, secondary_itemid = @SecondaryItemID, custom1_itemid =    
@Custom1ItemID,    
    custom2_itemid = @Custom2ItemID    
  WHERE CID=@CharIdent    
  IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN    
   ROLLBACK TRAN    
   RETURN (-1)    
  END    
    
  INSERT INTO CharacterMakingLog(AID, CharName, Type, Date)    
  VALUES( @AID, @Name, 'Create', GETDATE() )    
  IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN    
   ROLLBACK TRAN    
   RETURN (-1)    
  END    
    
 COMMIT TRAN    
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertChar_old]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Ä³¸¯ÅÍ Ãß°¡ */  
CREATE PROC [dbo].[spInsertChar_old]  
 @AID  int,  
 @CharNum smallint,  
 @Name  varchar(24),  
 @Sex  tinyint,  
 @Hair  int,    
 @Face  int,  
 @Costume int  
AS  
SET NOCOUNT ON  
BEGIN TRAN  
IF EXISTS (SELECT CID FROM Character where (AID=@AID AND CharNum=@CharNum) OR (Name=@Name))  
BEGIN   
 ROLLBACK TRAN  
 return(-1)  
END  
  
DECLARE @CharIdent  int  
DECLARE @ChestCIID int  
DECLARE @LegsCIID int  
DECLARE @MeleeCIID int  
DECLARE @PrimaryCIID int  
DECLARE @SecondaryCIID  int  
DECLARE @Custom1CIID int  
DECLARE @Custom2CIID int  
  
DECLARE @ChestItemID int  
DECLARE @LegsItemID int  
DECLARE @MeleeItemID int  
DECLARE @PrimaryItemID int  
DECLARE @SecondaryItemID  int  
DECLARE @Custom1ItemID int  
DECLARE @Custom2ItemID int  
  
SET @SecondaryCIID = NULL  
SET @SecondaryItemID = NULL  
  
SET @Custom1CIID = NULL  
SET @Custom1ItemID = NULL  
  
SET @Custom2CIID = NULL  
SET @Custom2ItemID = NULL  
  
INSERT INTO Character (AID, Name, CharNum, Level, Sex, Hair, Face, XP, BP, FR, CR, ER, WR,   
                      GameCount, KillCount, DeathCount, RegDate, PlayTime, DeleteFlag)  
Values (@AID, @Name, @CharNum, 1, @Sex, @Hair, @Face, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 0, 0)  
IF 0 <> @@ERROR BEGIN  
 ROLLBACK TRAN  
 RETURN (-1)  
END  
  
  
SET @CharIdent = @@IDENTITY  
  
  /* Melee */  
  SET @MeleeItemID =   
    CASE @Costume  
    WHEN 0 THEN 1  
    WHEN 1 THEN 2  
    WHEN 2 THEN 1  
    WHEN 3 THEN 2  
    WHEN 4 THEN 2  
    WHEN 5 THEN 1  
    END  
  
  INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @MeleeItemID)  
  IF 0 <> @@ERROR BEGIN  
 ROLLBACK TRAN  
 RETURN (-1)  
  END  
  
  SET @MeleeCIID = @@IDENTITY  
  
  /* Primary */  
  SET @PrimaryItemID =   
    CASE @Costume  
    WHEN 0 THEN 5001  
    WHEN 1 THEN 5002  
    WHEN 2 THEN 4005  
    WHEN 3 THEN 4001  
    WHEN 4 THEN 4002  
    WHEN 5 THEN 4006  
    END  
  
  INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @PrimaryItemID)  
  IF 0 <> @@ERROR BEGIN  
 ROLLBACK TRAN  
 RETURN (-1)  
  END  
  
  SET @PrimaryCIID = @@IDENTITY  
  
  /* Secondary */  
IF @Costume = 0 OR @Costume = 2 BEGIN  
  SET @SecondaryItemID =  
    CASE @Costume  
    WHEN 0 THEN 4001  
    WHEN 1 THEN 0  
    WHEN 2 THEN 5001  
    WHEN 3 THEN 4006  
    WHEN 4 THEN 0  
    WHEN 5 THEN 4006  
    END  
  
  IF @SecondaryItemID <> 0 BEGIN  
    INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @SecondaryItemID)  
    IF 0 <> @@ERROR BEGIN  
 ROLLBACK TRAN  
 RETURN (-1)  
    END  
  
    SET @SecondaryCIID = @@IDENTITY  
  END  
END  
  SET @Custom1ItemID =   
    CASE @Costume  
    WHEN 0 THEN 30301  
    WHEN 1 THEN 30301  
    WHEN 2 THEN 30401  
    WHEN 3 THEN 30401  
    WHEN 4 THEN 30401  
    WHEN 5 THEN 30101  
    END  
  
  /* Custom1 */  
  INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @Custom1ItemID)  
  IF 0 <> @@ERROR BEGIN  
 ROLLBACK TRAN  
 RETURN (-1)  
  END  
  
  SET @Custom1CIID = @@IDENTITY  
  
  /* Custom2 */  
IF @Costume = 4 OR @Costume = 5  
BEGIN  
  SET @Custom2ItemID =  
    CASE @Costume  
    WHEN 0 THEN 0  
    WHEN 1 THEN 0  
    WHEN 2 THEN 0  
    WHEN 3 THEN 0  
    WHEN 4 THEN 30001  
    WHEN 5 THEN 30001  
    END  
  
  IF @Custom2ItemID <> 0  
  BEGIN  
    INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @Custom2ItemID)  
    IF 0 <> @@ERROR BEGIN  
 ROLLBACK TRAN  
 RETURN (-1)  
    END  
  
    SET @Custom2CIID = @@IDENTITY  
  END  
END  
  
  
IF @Sex = 0  /* ³²ÀÚÀÏ °æ¿ì */  
BEGIN  
  
  /* Chest */  
  SET @ChestItemID =  
    CASE @Costume  
    WHEN 0 THEN 21001  
    WHEN 1 THEN 21001  
    WHEN 2 THEN 21001  
    WHEN 3 THEN 21001  
    WHEN 4 THEN 21001  
    WHEN 5 THEN 21001  
    END  
  
  
  INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @ChestItemID)  
  IF 0 <> @@ERROR BEGIN  
 ROLLBACK TRAN  
 RETURN (-1)  
  END  
  
  SET @ChestCIID = @@IDENTITY  
  
  /* Legs */  
  SET @LegsItemID =  
    CASE @Costume  
    WHEN 0 THEN 23001  
    WHEN 1 THEN 23001  
    WHEN 2 THEN 23001  
    WHEN 3 THEN 23001  
    WHEN 4 THEN 23001  
    WHEN 5 THEN 23001  
    END  
  
  
  INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @LegsItemID)  
  IF 0 <> @@ERROR BEGIN   
 ROLLBACK TRAN  
 RETURN (-1)  
  END  
  
  SET @LegsCIID = @@IDENTITY  
  
END  
ELSE  
BEGIN   /* ¿©ÀÚÀÏ °æ¿ì */  
  
  /* Chest */  
  SET @ChestItemID =  
    CASE @Costume  
    WHEN 0 THEN 21501  
    WHEN 1 THEN 21501  
    WHEN 2 THEN 21501  
    WHEN 3 THEN 21501  
    WHEN 4 THEN 21501  
    WHEN 5 THEN 21501  
    END  
  
  
  INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @ChestItemID)  
  IF 0 <> @@ERROR BEGIN  
 ROLLBACK TRAN  
 RETURN (-1)  
  END  
  SET @ChestCIID = @@IDENTITY  
  
  /* Legs */  
  SET @LegsItemID =  
    CASE @Costume  
    WHEN 0 THEN 23501  
    WHEN 1 THEN 23501  
    WHEN 2 THEN 23501  
    WHEN 3 THEN 23501  
    WHEN 4 THEN 23501  
    WHEN 5 THEN 23501  
    END  
  
  
  INSERT INTO CharacterItem (CID, ItemID) Values (@CharIdent, @LegsItemID)  
  IF 0 <> @@ERROR BEGIN  
 ROLLBACK TRAN  
 RETURN (-1)  
  END  
  SET @LegsCIID = @@IDENTITY  
  
END    
  
UPDATE Character  
SET chest_slot = @ChestCIID, legs_slot = @LegsCIID, melee_slot = @MeleeCIID,  
    primary_slot = @PrimaryCIID, secondary_slot = @SecondaryCIID, custom1_slot = @Custom1CIID,  
    custom2_slot = @Custom2CIID,  
    chest_itemid = @ChestItemID, legs_itemid = @LegsItemID, melee_itemid = @MeleeItemID,  
    primary_itemid = @PrimaryItemID, secondary_itemid = @SecondaryItemID, custom1_itemid = @Custom1ItemID,  
    custom2_itemid = @Custom2ItemID  
WHERE CID=@CharIdent  
IF 0 = @@ROWCOUNT BEGIN  
 ROLLBACK TRAN  
 RETURN (-1)  
END  
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[spInsertCharBRInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spInsertCharBRInfo]
-- ALTER PROC dbo.spInsertCharBRInfo
    @CID        INT
    , @BRID     INT
    , @BRTID    INT
AS BEGIN

    SET NOCOUNT ON;

    INSERT dbo.CharacterBattleTimeRewardInfo(CID, BRID, BRTID)
    VALUES (@CID, @BRID, @BRTID);

END
GO
/****** Object:  StoredProcedure [dbo].[spInsertCharItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--------------------------------------------------------------------------

CREATE PROC [dbo].[spInsertCharItem]
	@CID			int,
	@ItemID			int,
	@RentHourPeriod 	smallint = NULL
AS
DECLARE @OrderCIID	int
DECLARE @RentDate 	datetime

-- @RentHourPeriod°ªÀ» °¡Áö°í ±â°£Á¦ÀÎÁö °Ë»ç.
IF @RentHourPeriod = 0 OR @RentHourPeriod IS NULL
BEGIN
	SET @RentDate = NULL
	SET @RentHourPeriod = NULL
END
ELSE
BEGIN
	SET @RentDate = GETDATE()
END

INSERT INTO CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod) Values (@CID, @ItemID, GETDATE(), @RentDate, @RentHourPeriod)

SET @OrderCIID = @@IDENTITY
SELECT @OrderCIID as ORDERCIID
GO
/****** Object:  StoredProcedure [dbo].[spInsertCharMakingLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Ä³¸¯ÅÍ »ý¼º ·Î±× */
CREATE PROC [dbo].[spInsertCharMakingLog]
	@AID		int,
	@CharName	varchar(32),
	@Type		varchar(20)
AS
SET NOCOUNT ON
BEGIN TRAN
INSERT INTO CharacterMakingLog (AID, CharName, Type, Date)
VALUES (@AID, @CharName, @Type, GETDATE())
IF 0 <> @@ERROR BEGIN
	ROLLBACK TRAN
	RETURN
END
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[spInsertConnLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spInsertConnLog]   
 @AID int  
, @IPPart1 tinyint  
, @IPPart2 tinyint  
, @IPPart3 tinyint  
, @IPPart4 tinyint  
, @CountryCode3 char(3)  
AS  
 SET NOCOUNT ON  
 INSERT INTO LogDB.dbo.ConnLog( AID, Time, IPPart1, IPPart2, IPPart3, IPPart4, CountryCode3)  
 VALUES (@AID, GETDATE(), @IPPart1, @IPPart2, @IPPart3, @IPPart4, @CountryCode3)
GO
/****** Object:  StoredProcedure [dbo].[spInsertDistributeItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------------------------------------------------------------------
-- ÀÛ¾÷ÇÒ Äõ¸®

CREATE PROC [dbo].[spInsertDistributeItem]  
-- ALTER PROC dbo.spInsertDistributeItem
	@CID			INT,  
	@ItemID			INT,
	@RentHourPeriod SMALLINT
AS BEGIN

	SET NOCOUNT ON;

	INSERT INTO CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt)   
	VALUES (@CID, @ItemID, GETDATE(), GETDATE(), @RentHourPeriod, 1);  

	SELECT 0 AS 'Ret', @@IDENTITY as ORDERCIID    
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertEvent]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-----------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spInsertEvent] 
 @AID int
, @CID int
, @EventName varchar(24)
AS
 SET NOCOUNT ON 
 INSERT INTO Event( AID, CID, RegDate, Checked, EventName )
 VALUES (@AID, @CID, GETDATE(), 0, @EventName)
GO
/****** Object:  StoredProcedure [dbo].[spInsertGameLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* °ÔÀÓ ·Î±× Ãß°¡ */
CREATE PROC [dbo].[spInsertGameLog]
	@GameName	varchar(64),
	@Map		varchar(32),
	@GameType	varchar(24),
	@Round		int,
	@MasterCID	int,
	@PlayerCount	tinyint,
	@Players	varchar(1000)

AS
SET NOCOUNT ON
BEGIN TRAN
INSERT INTO GameLog (GameName, Map, GameType, Round, MasterCID, StartTime, PlayerCount, Players)
VALUES (@GameName, @Map, @GameType, @Round, @MasterCID, GETDATE(), @PlayerCount, @Players)
IF 0 <> @@ERROR BEGIN 
	ROLLBACK TRAN
	RETURN
END
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[spInsertGameLog2]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spInsertGameLog2]
-- ALTER PROC dbo.spInsertGameLog2
    @MasterCID      INT
    , @MapName      VARCHAR(32)
    , @GameType     VARCHAR(24)
AS BEGIN

    SET NOCOUNT ON;

    INSERT INTO LogDB.dbo.GameLog(MasterCID, MapName, GameType)
    VALUES (@MasterCID, @MapName, @GameType);

    SELECT @@IDENTITY AS GameLogID;

END
GO
/****** Object:  StoredProcedure [dbo].[spInsertItemPurchaseLogByBounty]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ¾ÆÀÌÅÛ ±¸¸Å(¹Ù¿îÆ¼) ·Î±× */
CREATE PROC [dbo].[spInsertItemPurchaseLogByBounty]
	@ItemID		int,
	@CID		int,
	@Bounty		int,
	@CharBounty	int,
	@Type		varchar(20)
AS
SET NOCOUNT ON
INSERT INTO ItemPurchaseLogByBounty
	(ItemID, CID, Date, Bounty, CharBounty, Type)
VALUES
	(@ItemID, @CID, GETDATE(), @Bounty, @CharBounty, @Type)
GO
/****** Object:  StoredProcedure [dbo].[spInsertKillLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Å³ ·Î±× Ãß°¡ */
CREATE PROC [dbo].[spInsertKillLog]
	@AttackerCID	int,
	@VictimCID	int
AS
SET NOCOUNT ON
BEGIN TRAN
INSERT INTO KillLog (AttackerCID, VictimCID, Time)
VALUES (@AttackerCID, @VictimCID, GETDATE())
IF 0 <> @@ERROR BEGIN
	ROLLBACK TRAN
	RETURN
END
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[spInsertLevelUpLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ·¹º§¾÷ ·Î±× Ãß°¡
CREATE PROC [dbo].[spInsertLevelUpLog]
	@CID			int,
	@Level			smallint,
	@BP				int,
	@KillCount		int,
	@DeathCount		int,
	@PlayTime		int
AS
SET NOCOUNT ON
BEGIN TRAN
	INSERT INTO LevelUpLog(CID, Level, BP, KillCount, DeathCount, PlayTime, Date)
	VALUES (@CID, @Level, @BP, @KillCount, @DeathCount, @PlayTime, GETDATE())
	IF 0 <> @@ERROR BEGIN
		ROLLBACK TRAN
		RETURN
	END
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[spInsertLocatorLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spInsertLocatorLog]  
 @LocatorID int  
, @CountryCode3 varchar(3)  
, @Count int   
AS  
 SET NOCOUNT ON   
 INSERT INTO LogDB.dbo.LocatorLog(LocatorID, CountryCode3, Count, RegDate)  
 VALUES (@LocatorID, @CountryCode3, @Count, GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[spInsertPlayerLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 현재의 spInsertPlayerLog를 만든다.
CREATE PROC [dbo].[spInsertPlayerLog]
-- ALTER PROC [dbo].[spInsertPlayerLog]
	@CID			INT
	, @PlayTime		INT
	, @Kills		INT
	, @Deaths		INT
	, @XP			INT
	, @TotalXP		INT
AS BEGIN

	SET NOCOUNT ON;  
  
	DECLARE @DisTime DATETIME;  
	SET @DisTime = GETDATE();  
	  
	INSERT INTO PlayerLog(CID, DisTime, PlayTime, Kills, Deaths, XP, TotalXP)  
	VALUES(@CID, @DisTime, @PlayTime, @Kills, @Deaths, @XP, @TotalXP)
	
	-- 아래의 날짜가 지나면 아래의 쿼리 부분은 삭제해주자!
	IF( @DisTime BETWEEN '2010-12-01 00:00:00.0' AND '2011-01-06 00:00:00.0' ) 
	BEGIN
	
		EXEC spEventColiseum_UpdatePlayData @CID, @PlayTime, @Kills, @Deaths;
		
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertQuestGameLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Äù½ºÆ® °ÔÀÓ ·Î±× Á¤º¸ ÀúÀå ÇÁ·Î½ÃÁ®.
CREATE PROC [dbo].[spInsertQuestGameLog]
	@GameName varchar(64)
,	@Master int 
,	@Player1 int 
,	@Player2 int
,	@Player3 int
,	@TotalQItemCount smallint 
,	@ScenarioID smallint 
,	@GamePlayTime tinyint 
AS
SET NOCOUNT ON

BEGIN TRAN
	INSERT INTO QuestGameLog(GameName, Master, Player1, Player2, Player3, TotalQItemCount, ScenarioID, StartTime, EndTime)
	VALUES (@GameName, @Master, @Player1, @Player2, @Player3, @TotalQItemCount, @ScenarioID, DATEADD(n, -(@GamePlayTime), GETDATE()), GETDATE() )
	IF 0 <> @@ERROR BEGIN -- ¿©±â Ãß°¡.
		ROLLBACK TRAN
		RETURN
	END

	SELECT @@IDENTITY AS 'ORDERQGLID'
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[spInsertQUniqueItemLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Äù½ºÆ® À¯´ÏÅ© ¾ÆÀÌÅÛ ÀúÀå ÇÁ·Î½ÃÁ®.
CREATE PROC [dbo].[spInsertQUniqueItemLog]
	@QGLID int
,	@CID int
,	@QIID int
AS
BEGIN
	SET NOCOUNT ON
	INSERT INTO QUniqueItemLog(QGLID, CID, QIID) VALUES (@QGLID, @CID, @QIID)
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertRentCashSetShopPrice]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ±â°£Á¦ ¼¼Æ® ¾ÆÀÌÅÛ »óÇ° °¡°Ý ÀÔ·Â
CREATE PROC [dbo].[spInsertRentCashSetShopPrice]
	@CSSID		int,
	@RentHourPeriod	smallint,
	@CashPrice	int
AS
	SET NOCOUNT ON
	INSERT INTO RentCashSetShopPrice(CSSID, RentHourPeriod, CashPrice) 
	VALUES (@CSSID, @RentHourPeriod, @CashPrice)
GO
/****** Object:  StoredProcedure [dbo].[spInsertRentCashShopPrice]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ±â°£Á¦ ¾ÆÀÌÅÛ »óÇ° °¡°Ý ÀÔ·Â
CREATE PROC [dbo].[spInsertRentCashShopPrice]
	@CSID			int
,	@RentHourPeriod		smallint
,	@CashPrice		int
AS
	SET NOCOUNT ON
	INSERT INTO RentCashShopPrice (CSID, RentHourPeriod, CashPrice)
	VALUES (@CSID, @RentHourPeriod, @CashPrice)
GO
/****** Object:  StoredProcedure [dbo].[spInsertServerLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--------------------------------------------------------------------------

CREATE PROC [dbo].[spInsertServerLog]
 @ServerID smallint
, @PlayerCount smallint
, @GameCount smallint
, @BlockCount int
, @NonBlockCount int
AS
 SET NOCOUNT ON
 INSERT INTO ServerLog(ServerID, PlayerCount, 
  GameCount, Time, BlockCount, NonBlockCount)
 VALUES (@ServerID, @PlayerCount, @GameCount, 
  GETDATE(), @BlockCount, @NonBlockCount )
GO
/****** Object:  StoredProcedure [dbo].[spInsertSurvivalGameLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInsertSurvivalGameLog]
	@strGameName		VARCHAR(64),
	@nSID				TINYINT,
	@nTotalRound		SMALLINT,
	@nMasterPlayerCID	INT,
	@nGainRP1			INT,
	@nPlayer2CID		INT,
	@nGainRP2			INT,
	@nPlayer3CID		INT,
	@nGainRP3			INT,
	@nPlayer4CID		INT,
	@nGainRP4			INT,
	@nGamePlayTime		TINYINT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @StandardRankingPoint INT
	SET @StandardRankingPoint = 0
	
	INSERT INTO dbo.SurvivalGameLog
	VALUES (DATEADD(n, -@nGamePlayTime, GETDATE()), GETDATE()
		, @nMasterPlayerCID, @nGainRP1
		, @nPlayer2CID, @nGainRP2
		, @nPlayer3CID, @nGainRP3
		, @nPlayer4CID, @nGainRP4
		, @strGameName, @nSID, @nTotalRound)
	
	-- Standard Ranking Point
	IF( @nGainRP1 >= @StandardRankingPoint )
		IF( @nMasterPlayerCID > 0 )
			EXECUTE spUpdateSurvivalCharacterInfo @nMasterPlayerCID, @nSID, @nGainRP1
	
	IF( @nGainRP2 >= @StandardRankingPoint )
		IF( @nPlayer2CID IS NOT NULL and @nPlayer2CID > 0 )
			EXECUTE spUpdateSurvivalCharacterInfo @nPlayer2CID, @nSID, @nGainRP2
			
	IF( @nGainRP3 >= @StandardRankingPoint )
		IF( @nPlayer3CID IS NOT NULL and @nPlayer3CID > 0 )
			EXECUTE spUpdateSurvivalCharacterInfo @nPlayer3CID, @nSID, @nGainRP3	
			
	IF( @nGainRP4 >= @StandardRankingPoint )
		IF( @nPlayer4CID IS NOT NULL and @nPlayer4CID > 0 )
			EXECUTE spUpdateSurvivalCharacterInfo @nPlayer4CID, @nSID, @nGainRP4	
			
	RETURN 0;
END
GO
/****** Object:  StoredProcedure [dbo].[spIPFltCheckIsDuplicateRange]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
---------------------------------------------------------------------

CREATE PROC [dbo].[spIPFltCheckIsDuplicateRange]
 @IPFrom bigint
, @IPTo bigint
, @Ret int OUTPUT
AS
 SET NOCOUNT ON
  IF EXISTS (SELECT CountryCode3 FROM CustomIP(NOLOCK) 
  WHERE (IPFrom <= @IPFrom AND IPTo >= @IPFrom) OR
   (IPFrom <= @IPTo AND IPTo >= @IPTo)) SET @Ret = 1
 ELSE SET @Ret = 0
GO
/****** Object:  StoredProcedure [dbo].[spIPFltGetBlockCountryCodeList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
------------------------------------------------------------

CREATE PROC [dbo].[spIPFltGetBlockCountryCodeList]
AS
 SET NOCOUNT ON
 SELECT CountryCode3, RoutingURL, IsBlock
 FROM BlockCountryCode(NOLOCK)
 ORDER BY CountryCode3
GO
/****** Object:  StoredProcedure [dbo].[spIPFltGetCountryCode]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spIPFltGetCountryCode]
AS
 SET NOCOUNT ON
 SELECT CountryCode3, CountryName
 FROM CountryCode(NOLOCK)
 ORDER BY CountryCode3 ASC
GO
/****** Object:  StoredProcedure [dbo].[spIPFltGetCustomIP]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spIPFltGetCustomIP]  
 @IP varchar(15)  
AS  
 SET NOCOUNT ON  
 DECLARE @TmpIP bigint  
  
 SET @TmpIP = GunzDB.dbo.inet_aton( @IP )  
  
 SELECT IPFrom, IPTo, IsBlock, Comment, RegDate   
 FROM CustomIP(NOLOCK)          
 WHERE IPFrom <= @TmpIP AND IPTo >= @TmpIP
GO
/****** Object:  StoredProcedure [dbo].[spIPFltGetCustomIPList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--------------------------------------------------------------------------

CREATE PROC [dbo].[spIPFltGetCustomIPList]
AS
 SET NOCOUNT ON
 SELECT IPFrom, IPTo, IsBlock, CountryCode3, Comment FROM CustomIP(NOLOCK)
 ORDER BY IPFrom
GO
/****** Object:  StoredProcedure [dbo].[spIPFltGetIPtoCountry]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[spIPFltGetIPtoCountry]  
 @IP char(15)  
AS  
 SET NOCOUNT ON  
 DECLARE @IPNumber BIGINT          
 SET @IPNumber = GunzDB.dbo.inet_aton( @IP )  
          
 SELECT IPFrom, IPTo, CountryCode3 FROM IPtoCountry(NOLOCK)          
 WHERE IPFrom <= @IPNumber AND IPTo >= @IPNumber
GO
/****** Object:  StoredProcedure [dbo].[spIPFltGetIPtoCountryList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
------------------------------------------------------------------------------

CREATE PROC [dbo].[spIPFltGetIPtoCountryList]
AS
 SET NOCOUNT ON
 SELECT IPFrom, IPTo, CountryCode3
 FROM IPtoCountry(NOLOCK)
 ORDER BY IPFrom
GO
/****** Object:  StoredProcedure [dbo].[spIsExistCharName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Ä³¸¯ÅÍ ÀÌ¸§ Áßº¹ °Ë»ç
CREATE PROC [dbo].[spIsExistCharName]
	@CharName	varchar(24)
AS
SET NOCOUNT ON
IF EXISTS (SELECT TOP 1 CID FROM Character(nolock) where (Name=@CharName) AND (DeleteFlag=0))
BEGIN
	SELECT 1 AS Ret
END
ELSE
BEGIN
	SELECT 0 AS Ret
END
GO
/****** Object:  StoredProcedure [dbo].[spLeague_FetchLeagueInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spLeague_FetchLeagueInfo]
AS
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[spLeague_GetCID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spLeague_GetCID]
AS
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[spNHN_DropEventTable]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spNHN_DropEventTable]
AS
BEGIN
	SET NOCOUNT ON;

	IF OBJECT_ID('dbo.EventCharacter') IS NOT NULL
	BEGIN
		DROP TABLE dbo.EventCharacter;
	END

	IF OBJECT_ID('dbo.EventAccount') IS NOT NULL
	BEGIN
		DROP TABLE dbo.EventAccount;
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spNHN_GetEventMyPlayInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spNHN_GetEventMyPlayInfo]
(
	@UserID VARCHAR(20)
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT GainXP, GainLevel, (GainPlayTime/60) AS GainPlayTime, XPOrder, LevelOrder, PlayTimeOrder
	FROM dbo.EventAccount WITH (NOLOCK)
	WHERE UserID = @UserID;
END
GO
/****** Object:  StoredProcedure [dbo].[spNHN_GetEventOrder]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spNHN_GetEventOrder]
(
	@OrderType TINYINT
	, @RowCount INT
	, @PageNum INT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF 0 = @OrderType
	BEGIN 
		SELECT TOP (@RowCount) XPOrder AS OrderID, UserID, GainXP AS Data
		FROM dbo.EventAccount WITH (NOLOCK)
		WHERE XPOrder > 0 AND XPorder > (@RowCount * @PageNum)
		ORDER BY xpOrder;
	END
	ELSE IF (1 = @OrderType) 
	BEGIN
		SELECT TOP (@RowCount) LevelOrder AS OrderID, UserID, GainLevel AS Data
		FROM dbo.EventAccount WITH (NOLOCK)
		WHERE LevelOrder > 0 AND LevelOrder > (@RowCount * @PageNum)
		ORDER BY LevelOrder;
	END
	ELSE IF (2 = @OrderType)
	BEGIN
		SELECT TOP (@RowCount) PlayTimeOrder AS OrderID, UserID, (GainPlayTime/60) AS Data
		FROM dbo.EventAccount WITH (NOLOCK)
		WHERE PlayTimeOrder > 0 AND PlayTimeOrder > (@RowCount * @PageNum)
		ORDER BY PlayTimeOrder;
	END
	ELSE
	BEGIN
		RAISERROR(N'invalid order type(Type:%d).', 11, 1, @OrderType);
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spNHN_InitEvent]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spNHN_InitEvent]
AS
BEGIN
	SET NOCOUNT ON;

	DROP INDEX IX_EventAccount_Level_Order ON dbo.EventAccount;
	DROP INDEX IX_EventAccount_XP_Order ON dbo.EventAccount;
	DROP INDEX IX_EventAccount_PlayTime_Order ON dbo.EventAccount;
	
	INSERT INTO dbo.EventAccount WITH (TABLOCK) (AID, UserID, XPOrder, LevelOrder, PlayTimeOrder)
	SELECT AID, UserID, 0, 0, 0
	FROM dbo.Account WITH (NOLOCK);

	CREATE INDEX IX_EventAccount_Level_Order ON dbo.EventAccount(LevelOrder) INCLUDE (UserID, GainLevel);
	CREATE INDEX IX_EventAccount_XP_Order ON dbo.EventAccount(XPOrder) INCLUDE (UserID, GainXP);
	CREATE INDEX IX_EventAccount_PlayTime_Order ON dbo.EventAccount(PlayTimeOrder) INCLUDE (UserID, GainPlayTime);

	INSERT INTO dbo.EventCharacter WITH (TABLOCK) (AID, CID, DeleteFlag, StartXP, StartLevel, PlayTime, LastXP, LastLevel)
	SELECT AID, CID, DeleteFlag, XP, Level, 0, XP, Level
	FROM dbo.Character WITH (UPDLOCK)
	WHERE DeleteFlag = 0;
END
GO
/****** Object:  StoredProcedure [dbo].[spNHN_UpdateEventAccountOrder]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spNHN_UpdateEventAccountOrder]
AS
BEGIN
	SET NOCOUNT ON;
	
	DROP INDEX IX_EventAccount_Level_Order ON dbo.EventAccount;
	DROP INDEX IX_EventAccount_XP_Order ON dbo.EventAccount;
	DROP INDEX IX_EventAccount_PlayTime_Order ON dbo.EventAccount;

	UPDATE dbo.EventAccount WITH (TABLOCK)
	SET XPOrder = t2.XPOrder
		, LevelOrder = t2.LevelOrder
		, PlayTimeOrder = t2.PlayTimeOrder
		, GainXP = t2.GainXP
		, GainLevel = t2.GainLevel
		, GainPlayTime = t2.GainPlayTime
	FROM 
		(SELECT a.AID
			, ROW_NUMBER() OVER (ORDER BY t1.GainXP DESC, UserID) AS XPOrder
			, ROW_NUMBER() OVER (ORDER BY t1.GainLevel DESC, t1.GainXP DESC, UserID) AS LevelOrder
			, ROW_NUMBER() OVER (ORDER BY t1.GainPlayTime DESC, UserID) AS PlayTimeOrder
			, ISNULL(t1.GainXP, 0) AS GainXP
			, ISNULL(t1.GainLevel, 0) AS GainLevel
			, ISNULL(t1.GainPlayTime, 0) AS GainPlayTime
		 FROM dbo.EventAccount a WITH (NOLOCK) LEFT OUTER JOIN
			(SELECT AID
				, SUM(LastXP - StartXP) AS GainXP
				, SUM(LastLevel - StartLevel) AS GainLevel
				, SUM(PlayTime) AS GainPlayTime
			 FROM dbo.EventCharacter WITH (NOLOCK)
			 WHERE DeleteFlag = 0
			 GROUP BY AID) AS t1
		 ON a.AID = t1.AID) AS t2
	WHERE EventAccount.AID = t2.AID;
	
	CREATE INDEX IX_EventAccount_Level_Order ON dbo.EventAccount(LevelOrder) INCLUDE (UserID, GainLevel);
	CREATE INDEX IX_EventAccount_XP_Order ON dbo.EventAccount(XPOrder) INCLUDE (UserID, GainXP);
	CREATE INDEX IX_EventAccount_PlayTime_Order ON dbo.EventAccount(PlayTimeOrder) INCLUDE (UserID, GainPlayTime);
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNAddTopLevelCharBountry]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spNHNAddTopLevelCharBountry]
 @UserID varchar(20)
, @Bounty int
, @Ret int OUTPUT
AS
BEGIN
 IF (@UserID IS NULL) OR (0 >= @Bounty) BEGIN
  SET @Ret = (-1)
  RETURN
 END

 DECLARE @CID int
 DECLARE @AID int

 SELECT TOP 1 @AID = a.AID, @CID = c.CID
 FROM Account a(NOLOCK), Character c(NOLOCK)
 WHERE a.UserID = @UserID AND c.AID = a.AID 
  AND c.DeleteFlag <> 1
 ORDER BY c.Level DESC
 IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) OR (@CID IS NULL) BEGIN
  SET @Ret = (-2)
  RETURN
 END

 BEGIN TRAN
 UPDATE Character
 SET BP = BP + @Bounty
 WHERE CID = @CID
 IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN
  ROLLBACK TRAN
  SET @Ret = (-3)
  RETURN
 END

 INSERT INTO Event(AID, CID, RegDate, Checked, EventName, SubDescription)
 VALUES (@AID, @CID, GETDATE(), 0, 'referral event', 'user''s top level character bounty add event')
 IF (0 <> @@ERROR) OR ( 0 = @@ROWCOUNT) BEGIN
  ROLLBACK TRAN
  SET @Ret = (-4)
  RETURN
 END

 COMMIT TRAN
 
 SET @Ret = 1
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNBuyCashItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[spNHNBuyCashItem]    
 @UserID  varchar(20),    
 @CSID  int,    
 @Cash  int,    
 @sid varchar(20),
 @RentHourPeriod smallint = NULL,    
 @MobileCode char(16) = NULL    
AS
BEGIN
 SET NoCount On    

 IF NOT EXISTS (SELECT * FROM CashShop(NOLOCK) WHERE CSID= @CSID AND Opened = 1)
  RETURN 0;
  
 DECLARE @AID  int    
 DECLARE @ItemID  int    
    
 -- Account 검사    
 SELECT @AID = AID FROM Account WHERE UserID = @UserID    
 IF @AID IS NULL    
 BEGIN    
  RETURN 0    
 END    
 ELSE    
 BEGIN    
  SELECT @ItemID = ItemID FROM CashShop cs (NOLOCK) WHERE cs.CSID = @CSID    
    
  IF @ItemID IS NOT NULL    
  BEGIN     
   DECLARE @RentDate datetime    
    
   -- @RentHourPeriod값을 가지고 기간제인지 검사.    
   IF @RentHourPeriod = 0 OR @RentHourPeriod IS NULL    
   BEGIN    
    -- 기간제 아이템일 경우 영구 아이템 판매 여부 검사    
    DECLARE @RentType  TINYINT    
    DECLARE @RCSPID  INT    
    
    SELECT @RentType = RentType FROM CashShop WHERE CSID=@CSID    
    IF @RentType = 1    
    BEGIN    
     SELECT @RCSPID = RCSPID FROM RentCashShopPrice WHERE CSID=@CSID AND RentHourPeriod is NULL    
     IF @RCSPID IS NULL    
     BEGIN    
      RETURN 0    
     END    
    END    
    
    -- 일반 아이템인 경우    
    SET @RentDate = NULL    
   END    
   ELSE    
   BEGIN    
    SET @RentDate = GETDATE()    
   END    
    
    
   BEGIN TRAN    
       
    -- 아이템 생성.    
    INSERT INTO accountitem(AID, ItemID, RentDate, RentHourPeriod)     
    VALUES (@AID, @ItemID, @RentDate, @RentHourPeriod)    
    IF (@@ERROR <> 0) OR (0 = @@ROWCOUNT)
    BEGIN    
     ROLLBACK    
     RETURN 0    
    END    
     
    -- 아이템 거래 log생성.    
    INSERT INTO ItemPurchaseLogByCash(AID, ItemID, Date, RentHourPeriod, Cash, MobileCode, sid)     
    VALUES (@AID, @ItemID, GETDATE(), @RentHourPeriod, @Cash, @MobileCode, @sid)    
    IF (@@ERROR <> 0) OR (0 = @@ROWCOUNT)
    BEGIN    
     ROLLBACK    
     RETURN 0    
    END    
        
   COMMIT TRAN    
    
   RETURN 1    
    
  END     
  ELSE    
  BEGIN    
   RETURN 0    
  END    
 END    
    
 RETURN 1    
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNBuyCashSetItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- cash set shop에서 거래된 아이템을 accountitme에 추가.  
CREATE    PROC [dbo].[spNHNBuyCashSetItem]  
 @UserID  varchar(20),  
 @CSSID  int,  
 @Cash  int,  
 @sid varchar(20),
 @RentHourPeriod smallint = NULL,  
 @MobileCode char(16) = NULL  
AS
BEGIN  
 SET NoCount On  
  
 DECLARE @AID  int  

	IF NOT EXISTS (SELECT * FROM CashSetShop(NOLOCK) WHERE CSSID = @CSSID AND Opened = 1)
 	 RETURN 0;
   
 SELECT @AID = AID FROM Account WHERE UserID = @UserID  
  
 -- 존제하는 유저인지 검사.  
 IF @AID IS NULL  
 BEGIN  
  RETURN 0  
 END  
 ELSE  
 BEGIN  
  DECLARE @RentDate  datetime     
  
  -- @RentHourPeriod값을 가지고 기간제인지 검사.  
  IF @RentHourPeriod = 0 OR @RentHourPeriod IS NULL  
  BEGIN  
   -- 기간제 아이템일 경우 영구 아이템 판매 여부 검사  
   DECLARE @RentType  TINYINT  
   DECLARE @RCSSPID  INT  
  
   SELECT @RentType = RentType FROM CashSetShop WHERE CSSID=@CSSID  
   IF @RentType = 1  
   BEGIN  
    SELECT @RCSSPID=RCSSPID FROM RentCashSetShopPrice WHERE CSSID=@CSSID AND RentHourPeriod is    
NULL  
    IF @RCSSPID IS NULL  
    BEGIN  
     RETURN 0  
    END  
   END  
  
   -- 일반 아이템일 경우  
   SET @RentDate = NULL  
  END  
  ELSE  
  BEGIN  
   SET @RentDate = GETDATE()  
  END  
  
  
  
  BEGIN TRAN  
  
   DECLARE curBuyCashSetItem  INSENSITIVE CURSOR  
   FOR  
    SELECT CSID FROM CashSetItem (NOLOCK) WHERE CSSID = @CSSID  
   FOR READ ONLY  
   
   OPEN curBuyCashSetItem   
   
   DECLARE @varCSID  int  
   DECLARE @ItemID   int  
   
   FETCH FROM curBuyCashSetItem INTO @varCSID  
   
   WHILE @@FETCH_STATUS = 0  
   BEGIN  
    SELECT @ItemID = cs.ItemID  
    FROM CashShop cs (NOLOCK)   
    WHERE cs.CSID = @varCSID   
   
    IF @ItemID IS NOT NULL  
    BEGIN  
     -- 아이템 생성.  
     INSERT INTO AccountItem(AID, ItemID, RentDate, RentHourPeriod)  
     VALUES (@AID, @ItemID, @RentDate, @RentHourPeriod)  
     IF (@@ERROR <> 0) OR (0 = @@ROWCOUNT)
     BEGIN  
      ROLLBACK  
      CLOSE curBuyCashSetItem   
      DEALLOCATE curBuyCashSetItem   
      RETURN 0  
     END       
    END  
   
    FETCH curBuyCashSetItem  INTO @varCSID  
   END  
   
   CLOSE curBuyCashSetItem   
   DEALLOCATE curBuyCashSetItem   
   
   -- 셋트 아이템 구입 로그.  
   INSERT INTO SetItemPurchaseLogByCash (AID, CSSID, Date, RentHourPeriod, Cash, MobileCode, sid)  
   VALUES (@AID, @CSSID, GETDATE(), @RentHourPeriod, @Cash, @MobileCode, @sid)  
   IF (@@ERROR <> 0) OR (0 = @@ROWCOUNT)
   BEGIN  
    ROLLBACK  
    RETURN 0  
   END  
         
  COMMIT TRAN  
  RETURN 1  
 END  
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNGetCashItemInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ¾ÆÀÌÅÛÀÇ »ó¼¼ Á¤º¸ º¸±â */
CREATE  PROC [dbo].[spNHNGetCashItemInfo]	
	@CSID		int,
	@lang		varchar(2)
AS
	SET NOCOUNT ON

	SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot, 
		cs.CashPrice AS Cash, cs.WebImgName As WebImgName,
		i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight,
		i.Damage AS Damage, i.Delay AS Delay, i.Controllability AS Controllability,
		i.Magazine AS Magazine, i.MaxBullet AS MaxBullet, i.ReloadTime AS ReloadTime, 
		i.HP AS HP, i.AP AS AP,	i.MAXWT AS MaxWeight, i.LimitSpeed AS LimitSpeed,
		i.FR AS FR, i.CR AS CR, i.PR AS PR, i.LR AS LR,
		id.Description AS Description, cs.NewItemOrder AS IsNewItem,
		cs.RentType AS RentType, cs.Opened AS Opened
	FROM CashShop cs(nolock), Item i(nolock), ItemDetail id(nolock)
	WHERE i.ItemID = cs.ItemID AND cs.csid = @CSID AND i.ItemID=id.ItemID AND id.lang = @lang
GO
/****** Object:  StoredProcedure [dbo].[spNHNGetCashItemList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spNHNGetCashItemList]  
 @ItemType int  
, @Page int  
, @PageSize int  
, @SortType int  
, @Sex int  
, @Slot int   
, @PageCount int OUTPUT  
AS  
BEGIN  
 SET NOCOUNT ON  
  
 DECLARE @SortTypeSql varchar(100)  
 DECLARE @ItemTypeSql varchar(100)  
 DECLARE @SexSql varchar(100)  
 DECLARE @Order varchar(100)  
 DECLARE @SlotSql varchar(100)  
  
 IF 0 = @SortType   
  SET @SortTypeSql = 'ORDER BY cs.RegDate DESC'  
 ELSE IF 1 = @SortType   
  SET @SortTypeSql = 'ORDER BY i.ResLevel DESC'  
 ELSE IF 2 = @SortType   
  SET @SortTypeSql = 'ORDER BY i.ResLevel'  
 ELSE IF 3 = @SortType   
  SET @SortTypeSql = 'ORDER BY cs.CashPrice DESC'  
 ELSE IF 4 = @SortType   
  SET @SortTypeSql = 'ORDER BY cs.CashPrice'  
 ELSE   
  SET @SortTypeSql = ''  
  
  
 IF 1 = @ItemType  
  SET @ItemTypeSql = ' AND i.Slot = 1'  
 ELSE IF 2 = @ItemType  
  SET @ItemTypeSql = ' AND i.Slot = 2 '  
 ELSE IF 3 = @ItemType  
  SET @ItemTypeSql = ' AND i.Slot BETWEEN 4 AND 8 '  
 ELSE IF 4 = @ItemType  
  SET @ItemTypeSql = ' AND (i.Slot = 3 OR i.Slot = 9) '  
 ELSE IF 0 = @ItemType  
  SET @ItemTypeSql = ''  
 ELSE  
  SET @ItemTypeSql = ''  
  
  
 IF 1 = @Sex   
  SET @SexSql = ' AND i.ResSex = 1 '  
 ELSE IF 2 = @Sex  
  SET @SexSql = ' AND i.ResSex = 2 '  
 ELSE IF 0 = @Sex  
  SET @SexSql = ''  
 ELSE  
  SET @SexSql = ''  
  
  
 IF 0 <> @Slot  
  SET @SlotSql = ' AND i.Slot = ' + CAST(@Slot AS varchar(8)) + ' '  
 ELSE IF 0 = @slot  
  SET @SlotSql = ''  
 ELSE   
  SET @SlotSql = ''  
  
 DECLARE @Sql nvarchar(4000)  
  
 SET @Sql = N'  
 DECLARE @ItemCount int  
 DECLARE @FilterRowCount int  
 DECLARE @Reminder int  
 DECLARE @ShowPageSize int  
 DECLARE @CashItemList table(id int IDENTITY, CSID int, Name varchar(256), Slot tinyint, Cash int  
  , WebImgName varchar(64), ResSex tinyint, ResLevel int, Weight int, Description varchar(1000)  
  , RegDate datetime, IsNewItem tinyint, RentType tinyint)  
 DECLARE @ShowPageTmp table(id int IDENTITY, CSID int, Name varchar(256), Slot tinyint, Cash int  
  , WebImgName varchar(64), ResSex tinyint, ResLevel int, Weight int, Description varchar(1000)  
  , RegDate datetime, IsNewItem tinyint, RentType tinyint)  
 DECLARE @ShowPage table(id int IDENTITY, CSID int, Name varchar(256), Slot tinyint, Cash int  
  , WebImgName varchar(64), ResSex tinyint, ResLevel int, Weight int, Description varchar(1000)  
  , RegDate datetime, IsNewItem tinyint, RentType tinyint)  
  
 INSERT INTO @CashItemList(CSID, Name, Slot, Cash, WebImgName, ResSex, ResLevel, Weight, Description  
  , RegDate, IsNewItem, RentType)  
 SELECT cs.CSID, i.Name, i.Slot, cs.CashPrice AS ''Cash'', cs.WebImgName  
  , i.ResSex, i.ResLevel, i.Weight, i.Description, cs.RegDate, cs.NewItemOrder AS ''IsNewItem''  
 , cs.RentType  
 FROM CashShop cs(NOLOCK), Item i(NOLOCK)  
 WHERE i.ItemId = cs.ItemID AND cs.Opened = 1  
  ' + @ItemTypeSql + @SexSql + @SlotSql  + @SortTypeSql + '  
  
 SET @ItemCount = SCOPE_IDENTITY()  
 SET @FilterRowCount = @PageSize * @Page  
 SET @PageCount = @ItemCount / @PageSize  
 SET @Reminder = @ItemCount % @PageSize  
 
 IF @ItemCount IS NULL
  RETURN;
  
 IF 0 <> @Reminder   
  SET @PageCount = @PageCount + 1  
  
 IF @ItemCount >= @FilterRowCount  
  SET @ShowPageSize = @PageSize  
 ELSE  
  SET @ShowPageSize = @Reminder  
  
 SET ROWCOUNT @FilterRowCount  
  
 INSERT INTO @ShowPageTmp(CSID, Name, Slot, Cash, WebImgName, ResSex, ResLevel, Weight, Description  
  , RegDate, IsNewItem, RentType)  
 SELECT CSID, Name, Slot, Cash, WebImgName, ResSex, ResLevel, Weight, Description  
  , RegDate, IsNewItem, RentType  
 FROM @CashItemList  
 ORDER BY id 
  
 SET ROWCOUNT @ShowPageSize  
  
 INSERT INTO @ShowPage(CSID, Name, Slot, Cash, WebImgName, ResSex, ResLevel, Weight, Description  
  , RegDate, IsNewItem, RentType)  
 SELECT CSID, Name, Slot, Cash, WebImgName, ResSex, ResLevel, Weight, Description  
  , RegDate, IsNewItem, RentType  
 FROM @ShowPageTmp
 ORDER BY id DESC  

 SELECT CSID, Name, Slot, Cash, WebImgName, ResSex, ResLevel, Weight, Description  
  , RegDate, IsNewItem, RentType  
 FROM @ShowPage
 ORDER BY id DESC  
'  
  
 exec sp_executesql @Sql, N'@Page int, @PageSize int, @PageCount int OUTPUT'  
  , @Page, @PageSize, @PageCount OUTPUT  
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNGetCashSetItemComposition]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ¼¼Æ® ¾ÆÀÌÅÛÀÇ ¼¼ºÎ¾ÆÀÌÅÛ ¸ñ·Ï º¸±â */
CREATE PROC [dbo].[spNHNGetCashSetItemComposition]
	@CSSID		int,
	@OutRowCount	int OUTPUT
AS
SET NOCOUNT ON

SELECT @OutRowCount = COUNT(*)
FROM CashSetItem csi(nolock), CashShop cs(nolock), Item i(nolock)
WHERE @CSSID = csi.CSSID AND csi.csid = cs.csid	AND cs.ItemID = i.ItemID

SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot, 
	cs.CashPrice AS Cash, cs.WebImgName As WebImgName,
	i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight,
	i.Description AS Description, cs.RegDate As RegDate,
	cs.NewItemOrder AS IsNewItem, cs.RentType As RentType

FROM CashSetItem csi(nolock), CashShop cs(nolock), Item i(nolock)
WHERE @CSSID = csi.CSSID AND csi.csid = cs.csid	AND cs.ItemID = i.ItemID
GO
/****** Object:  StoredProcedure [dbo].[spNHNGetCashSetItemInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ¼¼Æ®¾ÆÀÌÅÛÀÇ »ó¼¼ Á¤º¸ º¸±â */
CREATE PROC [dbo].[spNHNGetCashSetItemInfo]
	@CSSID	int,
	@lang	varchar(2)
AS
	SET NOCOUNT ON

	SELECT css.CSSID AS CSSID, css.Name AS Name, css.CashPrice AS Cash, css.WebImgName AS WebImgName, 
	ResSex AS ResSex, ResLevel AS ResLevel, Weight AS Weight,
	csid.Description AS Description, NewItemOrder As IsNewItem, RentType AS RentType,
	Opened AS Opened
	FROM CashSetShop css(nolock), CashSetItemDetail csid(nolock)
	WHERE css.CSSID = @CSSID AND css.CSSID = csid.CSSID AND csid.lang = @lang
GO
/****** Object:  StoredProcedure [dbo].[spNHNGetCashSetItemList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spNHNGetCashSetItemList]  
@Page int  
, @PageSize int  
, @SortType int  
, @Sex int  
, @PageCount int OUTPUT  
AS  
BEGIN  
 SET NOCOUNT ON  
  
 DECLARE @SortTypeSql varchar(100)  
 DECLARE @SexSql varchar(100)  
  
 IF 0 = @SortType   
  SET @SortTypeSql = 'ORDER BY RegDate DESC'  
 ELSE IF 1 = @SortType   
  SET @SortTypeSql = 'ORDER BY ResLevel DESC'  
 ELSE IF 2 = @SortType   
  SET @SortTypeSql = 'ORDER BY ResLevel'  
 ELSE IF 3 = @SortType   
  SET @SortTypeSql = 'ORDER BY CashPrice DESC'  
 ELSE IF 4 = @SortType   
  SET @SortTypeSql = 'ORDER BY CashPrice'  
 ELSE   
  SET @SortTypeSql = ''  
  
 IF 1 = @Sex   
  SET @SexSql = ' AND ResSex = 1 '  
 ELSE IF 2 = @Sex  
  SET @SexSql = ' AND ResSex = 2 '  
 ELSE IF 0 = @Sex  
  SET @SexSql = ''  
 ELSE  
  SET @SexSql = ''  
  
 DECLARE @Sql nvarchar(4000)  
  
 SET @Sql = '  
 DECLARE @SetItemCount int  
 DECLARE @FilterRowCount int  
 DECLARE @Reminder int  
 DECLARE @ShowPageSize int  
 DECLARE @CashSetItemList table(id int IDENTITY, CSSID int, Name varchar(256)  
  , Cash int, WebImgName varchar(64), ResSex tinyint, ResLevel int, Weight int  
  , Description varchar(1000), RegDate datetime, IsNewItem tinyint, RentType tinyint)  
 DECLARE @ShowPageTmp table(id int IDENTITY, CSSID int, Name varchar(256)  
  , Cash int, WebImgName varchar(64), ResSex tinyint, ResLevel int, Weight int  
  , Description varchar(1000), RegDate datetime, IsNewItem tinyint, RentType tinyint)  
 DECLARE @ShowPage table(id int IDENTITY, CSSID int, Name varchar(256)  
  , Cash int, WebImgName varchar(64), ResSex tinyint, ResLevel int, Weight int  
  , Description varchar(1000), RegDate datetime, IsNewItem tinyint, RentType tinyint)  
  
 INSERT INTO @CashSetItemList(CSSID, Name, Cash, WebImgName, ResSex, ResLevel, Weight  
  , Description, RegDate, IsNewItem, RentType)  
 SELECT CSSID, Name, CashPrice AS ''Cash'', WebImgName, ResSex, ResLevel  
  , Weight, Description, RegDate, NewItemOrder AS ''IsNewItem'', RentType   
 FROM CashSetShop   
 WHERE Opened = 1 ' + @SexSql + @SortTypeSql+ '  
  
 SET @SetItemCount = SCOPE_IDENTITY()  
 SET @FilterRowCount = @PageSize * @Page  
 SET @PageCount = @SetItemCount / @PageSize  
 SET @Reminder = @SetItemCount % @PageSize  
 
 IF @SetItemCount IS NULL
  RETURN;
  
 IF 0 <> @Reminder   
  SET @PageCount = @PageCount + 1  
  
 IF @SetItemCount >= @FilterRowCount  
  SET @ShowPageSize = @PageSize  
 ELSE  
  SET @ShowPageSize = @Reminder  
  
 SET ROWCOUNT @FilterRowCount  
  
 INSERT INTO @ShowPageTmp(CSSID, Name, Cash, WebImgName, ResSex, ResLevel, Weight  
  , Description, RegDate, IsNewItem, RentType)  
 SELECT CSSID, Name, Cash, WebImgName, ResSex, ResLevel, Weight  
  , Description, RegDate, IsNewItem, RentType  
 FROM @CashSetitemList  
 ORDER BY id   
  
 SET ROWCOUNT @ShowPageSize  
  
 INSERT INTO @ShowPage(CSSID, Name, Cash, WebImgName, ResSex, ResLevel, Weight  
  , Description, RegDate, IsNewItem, RentType)  
 SELECT CSSID, Name, Cash, WebImgName, ResSex, ResLevel, Weight  
  , Description, RegDate, IsNewItem, RentType  
 FROM @ShowPageTmp
 ORDER BY id DESC  

 SELECT CSSID, Name, Cash, WebImgName, ResSex, ResLevel, Weight  
  , Description, RegDate, IsNewItem, RentType  
 FROM @ShowPage
 ORDER BY id DESC  
'  
 exec sp_executesql @Sql, N'@Page int, @PageSize int, @PageCount int OUTPUT'  
  ,@Page, @PageSize,  @PageCount OUTPUT  
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNGetCharList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spNHNGetCharList]
 @UserID varchar(20)
AS 
BEGIN
 SET NOCOUNT ON

 DECLARE @AID INT

 SELECT @AID = AID FROM Account(NOLOCK) WHERE UserID = @UserID
 IF @AID IS NULL BEGIN
  RETURN
 END
 
 SELECT c.CID, c.Name, c.Level, c.Sex, c.RegDate, c.XP, c.BP, c.LastTime
  , c.PlayTime, c.KillCount, c.DeathCount 
 FROM Character c(NOLOCK)
 WHERE c.AID = @AID AND c.DeleteFlag = 0
 ORDER BY c.CID
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNGetClanMarkList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spNHNGetClanMarkList]
	@Page INT,
	@Approved INT,
	@PageCount	int OUTPUT
AS
SET NOCOUNT ON
BEGIN
	DECLARE @PageHead INT
	DECLARE @RowCount INT
	DECLARE @PageSize INT
	SELECT @PageSize = 15

	IF @Approved >= 0 
		BEGIN
			SELECT @PageCount = (COUNT(*) + (@PageSize-1)) / @PageSize
			FROM Clan cl(NOLOCK), NHNClanMark cm(NOLOCK), Character c(nolock) 
			WHERE cl.CLID = cm.CLID AND cm.Approved = @Approved AND cl.MasterCID=c.CID AND cl.DeleteFlag=0 

			SELECT @RowCount = ((@Page -1) * @PageSize + 1)
			
			SET ROWCOUNT @RowCount
			SELECT @PageHead = CLMARKID 
			FROM Clan cl(NOLOCK), NHNClanMark cm(NOLOCK), Character c(nolock) 
			WHERE cl.CLID = cm.CLID AND cm.Approved = @Approved AND cl.MasterCID=c.CID AND cl.DeleteFlag=0 
			ORDER BY CLMARKID DESC
			
			SET ROWCOUNT @PageSize
			SELECT cl.CLID AS CLID, cl.Name as ClanName, cl.MasterCID as MasterCID, cl.EmblemUrl as currEmblemUrl, c.Name AS Master, cm.CLMARKID AS CLMARKID, cm.EmblemUrl AS EmblemUrl, cm.approved AS approved, cm.Created AS Created, cm.LastUpdate AS LastUpdate, cm.LastCount AS LastCount, cm.LastCreated AS LastCreated, DATEADD(dd, 30, LastCreated) AS expireDate
			FROM Clan cl(NOLOCK), NHNClanMark cm(NOLOCK), Character c(nolock)
			WHERE cm.CLMARKID <= @PageHead AND cm.Approved = @Approved AND cl.CLID = cm.CLID AND cl.MasterCID=c.CID AND cl.DeleteFlag=0 
			ORDER BY cm.CLMARKID DESC
		END
	ELSE 
		BEGIN
			SELECT @PageCount = (COUNT(*) + (@PageSize-1)) / @PageSize
			FROM Clan cl(NOLOCK), NHNClanMark cm(NOLOCK), Character c(nolock) 
			WHERE cl.CLID = cm.CLID AND cl.MasterCID=c.CID AND cl.DeleteFlag=0 

			SELECT @RowCount = ((@Page -1) * @PageSize + 1)
			
			SET ROWCOUNT @RowCount
			SELECT @PageHead = CLMARKID 
			FROM Clan cl(NOLOCK), NHNClanMark cm(NOLOCK), Character c(nolock) 
			WHERE cl.CLID = cm.CLID AND cl.MasterCID=c.CID AND cl.DeleteFlag=0 
			ORDER BY CLMARKID DESC
			
			SET ROWCOUNT @PageSize
			SELECT cl.CLID AS CLID, cl.Name as ClanName, cl.MasterCID as MasterCID, cl.EmblemUrl as currEmblemUrl, c.Name AS Master, cm.CLMARKID AS CLMARKID, cm.EmblemUrl AS EmblemUrl, cm.approved AS approved, cm.Created AS Created, cm.LastUpdate AS LastUpdate, cm.LastCount AS LastCount, cm.LastCreated AS LastCreated, DATEADD(dd, 30, LastCreated) AS expireDate
			FROM Clan cl(NOLOCK), NHNClanMark cm(NOLOCK), Character c(nolock)
			WHERE cm.CLMARKID <= @PageHead AND cl.CLID = cm.CLID AND cl.MasterCID=c.CID AND cl.DeleteFlag=0
			ORDER BY cm.CLMARKID DESC
		END
	
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNGetHistory]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spNHNGetHistory]  
 @UserID varchar(20)  
, @Page int  
, @PageSize int  
, @Category int  
, @PageCount int OUTPUT  
AS  
BEGIN  
-- Category 1 : Buy, 2 : Receivce, 3 : Send, 0  : All  
-- 비교를 할때는 꺼꾸로 비교를 한다.  
  
 SET NOCOUNT ON  
  
 DECLARE @AID int  
 DECLARE @Today datetime  
 DECLARE @MyItemList table(id int identity, ItemID int, CSSID int, Date datetime, RentHourPeriod int, ExpiredDate datetime  
  , Cash int, Name varchar(256), Slot int, BuyType int, Sender varchar(20), Receiver varchar(20))  
  
 SELECT @AID = AID FROM Account(NOLOCK) WHERE UserID = @UserID  
 IF @AID IS NULL   
  RETURN   
  
 SET @Today = GETDATE()  
  
 INSERT INTO @MyItemList(ItemID, CSSID, Date, RentHourPeriod, ExpiredDate, Cash, Name, Slot, BuyType, Sender, Receiver)  
 SELECT t1.ItemID, t1.CSSID, t1.Date, t1.RentHourPeriod, DATEADD(hh, t1.RentHourPeriod, t1.Date) AS 'ExpiredDate'  
  , t1.Cash  
  , CASE WHEN t1.ItemID IS NOT NULL THEN i.Name   
     WHEN t1.CSSID IS NOT NULL THEN css.Name  
    END AS 'Name'  
   , i.Slot, t1.BuyType, t1.Sender, t1.Receiver  
 FROM  
 ((  
  SELECT ItemID, NULL AS 'CSSID', Date, RentHourPeriod,  Cash, @Category AS 'BuyType', NULL AS 'Sender', NULL AS 'Receiver'  
  FROM ItemPurchaseLogByCash(NOLOCK)   
  WHERE (@Category = 1 OR @Category = 0) AND AID =  @AID   
  UNION ALL  
  SELECT NULL AS 'ItemID', sipl.CSSID, sipl.Date, sipl.RentHourPeriod, sipl.Cash, @Category AS 'BuyType', NULL AS 'Sender', NULL AS 'Receiver'  
  FROM SetItemPurchaseLogByCash sipl(NOLOCK)  
  WHERE (@Category = 1 OR @Category = 0) AND sipl.AID = @AID   
  UNION ALL  
  SELECT cs.ItemID, NULL AS 'CSSID', cipl.Date, cipl.RentHourPeriod, cipl.Cash, @Category AS 'BuyType', cipl.SenderUserID AS 'Sender', acc.UserID AS 'Receiver'  
  FROM CashItemPresentLog cipl(NOLOCK), CashShop cs(NOLOCK), Account acc(NOLOCK)  
  WHERE   
   ((@AID = CASE @Category WHEN 2 THEN cipl.ReceiverAID ELSE NULL END)   
    OR (@UserID = CASE @Category WHEN 3 THEN cipl.SenderUserID ELSE NULL END))  
   AND cipl.CSID IS NOT NULL AND cs.CSID = cipl.CSID
   AND acc.AID = cipl.ReceiverAID
  UNION ALL  
  SELECT NULL AS 'ItemID', cipl.CSSID, cipl.Date, cipl.RentHourPeriod, cipl.Cash, @Category AS 'BuyType', cipl.SenderUserID AS 'Sender', acc.UserID AS 'Receiver'  
  FROM CashItemPresentLog cipl(NOLOCK), Account acc(NOLOCK)  
  WHERE  
   ((@AID = CASE @Category WHEN 2 THEN cipl.ReceiverAID ELSE NULL END)   
    OR (@UserID = CASE @Category WHEN 3 THEN cipl.SenderUserID ELSE NULL END))  
   AND cipl.CSSID IS NOT NULL  
   AND acc.AID = cipl.ReceiverAID
 ) AS t1 LEFT OUTER JOIN Item i(NOLOCK) ON i.ItemID = t1.ItemID) LEFT OUTER JOIN CashSetShop css(NOLOCK) ON css.CSSID = t1.CSSID  
 ORDER BY t1.Date DESC, t1.ItemID  
  
 DECLARE @MyItemListCount int  
 DECLARE @FilterRowCount int  
 DECLARE @Reminder int   
 DECLARE @ShowPageSize int  
 DECLARE @ShowPageTmp table(id int identity, ItemID int, CSSID int, Date datetime, RentHourPeriod int, ExpiredDate datetime  
  , Cash int, Name varchar(256), Slot int, BuyType int, Sender varchar(20), Receiver varchar(20))  
 DECLARE @ShowPage table(id int identity, ItemID int, CSSID int, Date datetime, RentHourPeriod int, ExpiredDate datetime  
  , Cash int, Name varchar(256), Slot int, BuyType int, Sender varchar(20), Receiver varchar(20))  
  
 SET @MyItemListCount = SCOPE_IDENTITY()  
 SET @FilterRowCount = @PageSize * @Page  
 SET @PageCount = @MyItemListCount / @PageSize  
 SET @Reminder = @MyItemListCount % @PageSize  
 
 IF @MyItemListCount IS NULL
   RETURN;
   
 IF 0 <> @Reminder   
  SET @PageCount = @PageCount + 1  
  
 IF @MyItemListCount >= @FilterRowCount   
  SET @ShowPageSize = @PageSize  
 ELSE   
 SET @ShowPageSize = @Reminder  
  
  
 SET ROWCOUNT @FilterRowCount  
  
 INSERT INTO @ShowPageTmp(ItemID, CSSID, Date, RentHourPeriod, ExpiredDate, Cash, Name, Slot, BuyType, Sender, Receiver)  
 SELECT ItemID, CSSID, Date, RentHourPeriod, ExpiredDate, Cash, Name, Slot, BuyType, Sender, Receiver 
 FROM @MyItemList  
 ORDER BY id 
  
 SET ROWCOUNT @ShowPageSize  
  
 INSERT INTO @ShowPage(ItemID, CSSID, Date, RentHourPeriod, ExpiredDate, Cash, Name, Slot, BuyType, Sender, Receiver)  
 SELECT ItemID, CSSID, Date, RentHourPeriod, ExpiredDate, Cash, Name, Slot, BuyType, Sender, Receiver  
 FROM @ShowPageTmp  
 ORDER BY id DESC  

 SELECT ItemID, CSSID, Date, RentHourPeriod, ExpiredDate, Cash, Name, Slot, BuyType, Sender, Receiver  
 FROM @ShowPage
 ORDER BY id DESC   
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNGetMyClanList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[spNHNGetMyClanList]
 @UserID varchar(20)
AS 
BEGIN
 SET NOCOUNT ON

 SELECT t.Ranking, t.RankIncrease, t.ClanName, t.Point, t.Wins, t.Losses, t.CLID, t.EmblemUrl, 
ch.Name AS Master, t.RegDate, t.CharName, t.Level, t.XP, t.BP, t.Grade, t.MasterCID
FROM
(
SELECT cl.CLID, cl.Name AS ClanName, cl.Point, cl.Wins, cl.Losses, cl.EmblemUrl, cl.Ranking, cl.RankIncrease, 
cl.MasterCID, cl.RegDate, ch.Name AS CharName, ch.Level, ch.XP, ch.BP, cm.Grade
FROM Account ac (NOLOCK), Character ch(NOLOCK), ClanMember cm(NOLOCK), Clan cl(NOLOCK)
WHERE ac.UserID = @UserID
AND ac.AID = ch.AID AND cm.CID = ch.CID AND cl.CLID = cm.CLID
) AS t, Character ch(NOLOCK)
WHERE t.MasterCID = ch.CID ORDER BY t.CLID ASC

END
GO
/****** Object:  StoredProcedure [dbo].[spNHNGetMyItems]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spNHNGetMyItems]    
 @UserID varchar(20)    
, @Page int    
, @PageSize int    
, @Category int    
, @PageCount int OUTPUT  
AS    
BEGIN    
-- Category 1 : Buy, 2 : Receivce, 3 : All    
-- 비교를 할때는 거꾸로 비교를 한다.    
    
 SET NOCOUNT ON    
    
 DECLARE @AID int    
 DECLARE @Today datetime    
 DECLARE @MyItemList table(id int identity, ItemID int, Date datetime, RentHourPeriod int, ExpiredDate datetime    
  , Cash int, Name varchar(256), Slot int, BuyType int, Sender varchar(20))    
    
 SELECT @AID = AID FROM Account(NOLOCK) WHERE UserID = @UserID    
 IF @AID IS NULL     
  RETURN     
    
 SET @Today = GETDATE()    
    
 INSERT INTO @MyItemList(ItemID, Date, RentHourPeriod, ExpiredDate, Cash, Name, Slot, BuyType, Sender)    
 SELECT t1.ItemID, t1.Date, t1.RentHourPeriod, DATEADD(hh, t1.RentHourPeriod, t1.Date) AS 'ExpiredDate'    
  , t1.Cash, i.Name, i.Slot,     
  CASE t1.BuyType     
   WHEN 2 THEN 1     
   WHEN 1 THEN 2    
  END AS 'BuyType'    
  , t1.Sender    
 FROM    
 (    
  SELECT ItemID, Date, RentHourPeriod,  Cash, 2 AS 'BuyType', NULL AS 'Sender'    
  FROM ItemPurchaseLogByCash(NOLOCK)     
  WHERE AID =  @AID AND (RentHourPeriod IS NULL OR RentHourPeriod >= DATEDIFF(hh, Date, @Today))    
  UNION ALL    
  SELECT cs.ItemID, sipl.Date, sipl.RentHourPeriod, sipl.Cash, 2 AS 'BuyType', NULL AS 'Sender'    
  FROM SetItemPurchaseLogByCash sipl(NOLOCK), CashSetItem csi(NOLOCK), CashShop cs(NOLOCK)    
  WHERE sipl.AID = @AID AND (sipl.RentHourPeriod IS NULL OR sipl.RentHourPeriod >= DATEDIFF(hh, sipl.Date, @Today))     
   AND csi.CSSID = sipl.CSSID AND cs.CSID = csi.CSID    
  UNION ALL    
  SELECT cs.ItemID, cipl.Date, cipl.RentHourPeriod, cipl.Cash, 1 AS 'BuyType', cipl.SenderUserID AS 'Sender'    
  FROM CashItemPresentLog cipl(NOLOCK), CashShop cs(NOLOCK)    
  WHERE cipl.ReceiverAID = @AID AND cipl.CSID IS NOT NULL     
   AND (cipl.RentHourPeriod IS NULL OR cipl.RentHourPeriod >= DATEDIFF(hh, cipl.Date, @Today))    
   AND cs.CSID = cipl.CSID    
  UNION ALL    
  SELECT cs.ItemID, cipl.Date, cipl.RentHourPeriod, cipl.Cash, 1 AS 'BuyType', cipl.SenderUserID AS 'Sender'    
  FROM CashItemPresentLog cipl(NOLOCK), CashSetItem csi(NOLOCK)    
   , CashShop cs(NOLOCK)    
  WHERE cipl.ReceiverAID = @AID AND cipl.CSSID IS NOT NULL    
   AND (cipl.RentHourPeriod IS NULL OR cipl.RentHourPeriod >= DATEDIFF(hh, cipl.DATE, @Today))    
   AND csi.CSSID = cipl.CSSID AND cs.CSID = csi.CSID    
  UNION ALL    
  SELECT iodl.ItemID, iodl.Date, iodl.RentHourPeriod, iodl.Cash, 1 AS 'BuyType', iodl.SenderUserID AS 'Sender'    
  FROM NHNItemOfTheDayLog iodl 
  WHERE iodl.UserID = @UserID AND iodl.SenderUserId IS NOT NULL
   AND (iodl.RentHourPeriod IS NULL OR iodl.RentHourPeriod >= DATEDIFF(hh, iodl.DATE, @Today))    
  UNION ALL    
  SELECT risl.ItemID, risl.Date, risl.RentHourPeriod, risl.Cash, 1 AS 'BuyType', risl.SenderUserID AS 'Sender'    
  FROM NHNRareItemShopLog risl 
  WHERE risl.UserID = @UserID AND risl.SenderUserId IS NOT NULL
   AND (risl.RentHourPeriod IS NULL OR risl.RentHourPeriod >= DATEDIFF(hh, risl.DATE, @Today))    
 ) AS t1, Item i(NOLOCK)    
 WHERE t1.BuyType <> @Category AND i.ItemID = t1.ItemID    
 ORDER BY t1.Date DESC, t1.ItemID    
  
  
 DECLARE @MyItemListCount int    
 DECLARE @ShowPageSize int  
 DECLARE @Reminder int  
 DECLARE @FilterRowCount int  
 DECLARE @ShowPage table(id int identity, ItemID int, Date datetime, RentHourPeriod int, ExpiredDate datetime    
  , Cash int, Name varchar(256), Slot int, BuyType int, Sender varchar(20))    
 DECLARE @ShowPageTmp table(id int identity, ItemID int, Date datetime, RentHourPeriod int, ExpiredDate datetime    
  , Cash int, Name varchar(256), Slot int, BuyType int, Sender varchar(20))    
  
  
 SET @FilterRowCount = @PageSize * @Page  
 SET @MyItemListCount = SCOPE_IDENTITY()  
 SET @PageCount = @MyItemListCount / @PageSize  
 SET @Reminder = @MyItemListCount % @PageSize  
 
 IF @MyItemListCount IS NULL
   RETURN;
  
 IF 0 <> @Reminder   
  SET @PageCount = @PageCount + 1  
  
 IF @MyItemListCount >= @FilterRowCount   
  SET @ShowPageSize = @PageSize  
 ELSE   
 SET @ShowPageSize = @Reminder  
  
  
 SET ROWCOUNT @FilterRowCount  
  
 INSERT INTO @ShowPageTmp(ItemID, Date, RentHourPeriod, ExpiredDate, Cash, Name, Slot, BuyType, Sender)  
 SELECT ItemID, Date, RentHourPeriod, ExpiredDate, Cash, Name, Slot, BuyType, Sender  
 FROM @MyItemList  
 ORDER BY id   
  
 SET ROWCOUNT @ShowPageSize  

 INSERT INTO @ShowPage(ItemID, Date, RentHourPeriod, ExpiredDate, Cash, Name, Slot, BuyType, Sender)   
 SELECT ItemID, Date, RentHourPeriod, ExpiredDate, Cash, Name, Slot, BuyType, Sender  
 FROM @ShowPageTmp
 ORDER BY id   DESC

 SET ROWCOUNT 0

 SELECT ItemID, Date, RentHourPeriod, ExpiredDate, Cash, Name, Slot, BuyType, Sender  
 FROM @ShowPage
 ORDER BY id   DESC
 
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNGetMyLuckyBoxCoupons]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spNHNGetMyLuckyBoxCoupons]    
@UserID varchar(20)    
, @Page int    
--, @PageSize int    
, @PageCount int OUTPUT  
AS    
BEGIN   
	DECLARE @RowCount INT  
	DECLARE @PageHead INT 
	DECLARE @TotalRows INT  

	BEGIN  

		SELECT @RowCount = ((@Page -1) * 20 + 1)  
	
		SELECT @TotalRows = count(*) 
		FROM nhnluckyboxcoupon(NOLOCK) 
		WHERE userid = @UserID 
		SET @PageCount = (@TotalRows / 20) + 1
		
		SET ROWCOUNT @RowCount  
		SELECT @PageHead = boxcid 
		FROM nhnluckyboxcoupon(NOLOCK) 
		WHERE userid = @UserID 
		ORDER BY boxcid DESC  

		SET ROWCOUNT 20
		
		SELECT TOP 20 boxcid, userid, boxcategory, status, boxid, 
		sid, regdate, opendate, expiredate, datediff(s, getdate(), expiredate) as remaining
		FROM nhnluckyboxcoupon(NOLOCK)
		WHERE userid = @UserID AND boxcid <= @PageHead
		ORDER BY boxcid desc  
		
	END  
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNGetMyLuckyBoxItems]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spNHNGetMyLuckyBoxItems]    
@UserID varchar(20)    
, @Page int    
--, @PageSize int    
, @PageCount int OUTPUT  
AS    
BEGIN   
	DECLARE @RowCount INT  
	DECLARE @PageHead INT 
	DECLARE @TotalRows INT  

	BEGIN  

		SELECT @RowCount = ((@Page -1) * 20 + 1)  
	
		SELECT @TotalRows = count(*) 
		FROM nhnluckyboxinventory(NOLOCK) 
		WHERE userid = @UserID 
		SET @PageCount = (@TotalRows / 20) + 1
		
		SET ROWCOUNT @RowCount  
		SELECT @PageHead = boxiid 
		FROM nhnluckyboxinventory(NOLOCK) 
		WHERE userid = @UserID 
		ORDER BY boxiid DESC  

		SET ROWCOUNT 20
		SELECT c.boxiid, c.boxid, c.status, c.boxrid, c.refundprice, c.sender, c.regdate, c.name, c.category, d.name as itemname FROM  
		(SELECT a.boxiid, a.boxid, a.status, a.boxrid, a.refundprice, a.sender, a.regdate, b.name, b.category FROM  
		(  
			SELECT TOP 20 *
			FROM nhnluckyboxinventory(NOLOCK)
			WHERE userid = @UserID AND boxiid <= @PageHead
			ORDER BY boxiid desc  
		) a, nhnluckyboxitem b
		WHERE a.boxid = b.boxid 
		) c LEFT OUTER JOIN nhnluckyboxrewarditem d 
		ON c.boxrid= d.boxrid
		ORDER BY boxiid DESC 
	END  
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNGetUserCashItemCount]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 유저가 보유한 특정 아이템 개수
CREATE PROC [dbo].[spNHNGetUserCashItemCount]
 @UserID varchar(20)
, @CSID int
AS
BEGIN
 SET NOCOUNT ON

 DECLARE @AID int
 DECLARE @ItemID int
 DECLARE @Today datetime

 SELECT @AID = AID FROM Account(NOLOCK) WHERE UserID = @UserID
 SELECT @ItemID = ItemID FROM CashShop(NOLOCK) WHERE CSID = @CSID

 IF (@AID IS NULL) OR (@ItemID IS NULL) BEGIN
  SELECT (-1) AS 'Count'
  RETURN
 END

 SET @Today  = GETDATE()

 SELECT SUM(t.Count) AS 'Count'
 FROM
 (
  SELECT COUNT(ItemID) as 'Count'
  FROM ItemPurchaseLogByCash(NOLOCK)
  WHERE AID = @AID AND ItemID = @ItemID 
   AND ((RentHourPeriod >= DATEDIFF(hh, Date, @Today)) OR RentHourPeriod IS NULL)
  UNION ALL
  SELECT COUNT(CSID) as 'Count'
  FROM CashItemPresentLog(NOLOCK)
  WHERE ReceiverAID = @AID AND CSID IS NOT NULL AND CSID = @CSID 
   AND ((RentHourPeriod >= DATEDIFF(hh, Date, @Today)) OR RentHourPeriod IS NULL)
 ) AS t
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNGetUserCashSetItemCount]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 유저가 보유한 특정 세트 아이템 개수
CREATE PROC [dbo].[spNHNGetUserCashSetItemCount]
 @UserID varchar(20)
, @CSSID int
AS 
BEGIN
 SET NOCOUNT ON

 DECLARE @AID int
 DECLARE @Today datetime

 SELECT @AID = AID FROM Account(NOLOCK) WHERE UserID = @UserID
 IF @AID IS NULL BEGIN
  SELECT (-1) AS 'Count'
  RETURN
 END

 SET @Today = GETDATE()

 SELECT SUM(t.Count) AS 'Count'
 FROM
 (
  SELECT COUNT(CSSID) as 'Count'
  FROM SetItemPurchaseLogByCash(NOLOCK)
  WHERE AID = @AID AND CSSID = @CSSID 
   AND (RentHourPeriod >= DATEDIFF(hh, Date, @Today) OR RentHourPeriod IS NULL)
  UNION ALL
  SELECT COUNT(CSSID) as 'Count'
  FROM CashItemPresentLog(NOLOCK)
  WHERE ReceiverAID = @AID AND CSSID IS NOT NULL AND CSSID = @CSSID 
   AND (RentHourPeriod >= DATEDIFF(hh, Date, @Today) OR RentHourPeriod IS NULL)
 ) AS t
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNInsertCashItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spNHNInsertCashItem]  
 @UserID  varchar(20),  
 @ItemID  int,  
 @Cash  int,  
 @RentHourPeriod smallint = NULL  ,  
 @sid  varchar(20) = NULL
AS  
 SET NoCount On  

 DECLARE @AID  int  
  
 -- Account 검사  
 SELECT @AID = AID FROM Account WHERE UserID = @UserID  
 IF @AID IS NULL  
 BEGIN  
  RETURN 0  
 END  
 ELSE  
 BEGIN  

  BEGIN   
   DECLARE @RentDate datetime  
  
   SET @RentDate = GETDATE()  
   
   BEGIN TRAN  
     
    INSERT INTO accountitem(AID, ItemID, RentDate, RentHourPeriod)   
    VALUES (@AID, @ItemID, @RentDate, @RentHourPeriod)  
  
    IF @@ERROR <> 0  
    BEGIN  
     ROLLBACK  
     RETURN 0  
    END  
   
    INSERT INTO ItemPurchaseLogByCash(AID, ItemID, Date, RentHourPeriod, Cash, MobileCode, sid)   
    VALUES (@AID, @ItemID, GETDATE(), @RentHourPeriod, @Cash, null, @sid)  
      
    IF @@ERROR <> 0  
    BEGIN  
     ROLLBACK  
     RETURN 0  
    END  
      
   COMMIT TRAN  
  
   RETURN 1  
  
  END    
 END  
  
 RETURN 1
GO
/****** Object:  StoredProcedure [dbo].[spNHNInsertCashItemForItemOfTheDay]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[spNHNInsertCashItemForItemOfTheDay]  
 @UserID  varchar(20),  
 @ItemID  int,  
 @Cash  int,  
 @RentHourPeriod smallint = NULL  ,  
 @IsGift tinyint = 0,
 @sid  varchar(20) = NULL
AS  
 SET NoCount On  

 DECLARE @AID  int  
  
 -- Account 검사  
 SELECT @AID = AID FROM Account WHERE UserID = @UserID  
 IF @AID IS NULL  
 BEGIN  
  RETURN 0  
 END  
 ELSE  
 BEGIN  

  BEGIN   
   DECLARE @RentDate datetime  
  
   SET @RentDate = GETDATE()  
   
   BEGIN TRAN  
     
    INSERT INTO accountitem(AID, ItemID, RentDate, RentHourPeriod)   
    VALUES (@AID, @ItemID, @RentDate, @RentHourPeriod)  
  
    IF @@ERROR <> 0  
    BEGIN  
     ROLLBACK  
     RETURN 0  
    END  
   
    IF @IsGift <> 1 
    BEGIN
    INSERT INTO ItemPurchaseLogByCash(AID, ItemID, Date, RentHourPeriod, Cash, MobileCode, sid)   
    VALUES (@AID, @ItemID, GETDATE(), @RentHourPeriod, @Cash, null, @sid)  
    END
  
    IF @@ERROR <> 0  
    BEGIN  
     ROLLBACK  
     RETURN 0  
    END  
      
   COMMIT TRAN  
  
   RETURN 1  
  
  END    
 END  
  
 RETURN 1
GO
/****** Object:  StoredProcedure [dbo].[spNHNInsertEventItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spNHNInsertEventItem]
 @UserID varchar(20)		-- 유저 ID.
, @ItemID int			-- 지급할 ItemID.
, @RentHourPeriod int		-- 지급한 아이템의 사용 기간.
, @EventName varchar(20)	-- 진행중인 이벤트 이름.	
, @Ret int OUTPUT		-- 결과 반환값. 1:성공, 나머지는 실패.
AS
BEGIN
 SET NOCOUNT ON
 
 DECLARE @AID 			int
 DECLARE @SubDescription 	varchar(128)

 SELECT @AID = AID FROM Account(NOLOCK) WHERE UserID = @UserID
 IF @AID IS NULL
 BEGIN
  SET @Ret = -1
  RETURN @Ret
 END

 IF NOT EXISTS(
  SELECT ItemID FROM Item(NOLOCK) WHERE ItemID = @ItemID)
 BEGIN
  SET @Ret = -2
  RETURN @Ret
 END

 BEGIN TRAN
 INSERT INTO AccountItem(AID, ItemID, RentDate, RentHourPeriod)
 VALUES (@AID, @ItemID, GETDATE(), @RentHourPeriod)
 IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) 
 BEGIN
  ROLLBACK TRAN
  SET @Ret = -3
  RETURN @Ret
 END

 INSERT INTO ItemPurchaseLogByCash(AID, ItemID, Date, RentHourPeriod, Cash, MobileCode, sid)   
 VALUES (@AID, @ItemID, GETDATE(), @RentHourPeriod, 0, null, @EventName)  
 IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT)
 BEGIN  
  ROLLBACK TRAN
  SET @Ret = -4
  RETURN @Ret
 END 

 SET @SubDescription = 'Event ItemID : ' + CAST(@ItemID AS varchar(16))

 INSERT INTO Event(AID, CID, RegDate, EventName, SubDescription)
 VALUES (@AID, 0, GETDATE(), @EventName, @SubDescription)
 IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) 
 BEGIN
  ROLLBACK TRAN
  SET @Ret = -5
  RETURN @Ret
 END

 COMMIT TRAN
 SET @Ret = 1
 RETURN @Ret
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNInsertEventItemForMyItems]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[spNHNInsertEventItemForMyItems]
 @UserID varchar(20)		-- 유저 ID.
, @ItemID int			-- 지급할 ItemID.
, @RentHourPeriod int		-- 지급한 아이템의 사용 기간.
, @EventName varchar(24)	-- 진행중인 이벤트 이름.	
, @Ret int OUTPUT		-- 결과 반환값. 1:성공, 나머지는 실패.
AS
BEGIN
 SET NOCOUNT ON
 
 DECLARE @AID 			int
 DECLARE @SubDescription 	varchar(128)

 SELECT @AID = AID FROM Account(NOLOCK) WHERE UserID = @UserID
 IF @AID IS NULL
 BEGIN
  SET @Ret = -1
  RETURN @Ret
 END

 IF NOT EXISTS(
  SELECT ItemID FROM Item(NOLOCK) WHERE ItemID = @ItemID)
 BEGIN
  SET @Ret = -2
  RETURN @Ret
 END

 BEGIN TRAN
 INSERT INTO AccountItem(AID, ItemID, RentDate, RentHourPeriod)
 VALUES (@AID, @ItemID, GETDATE(), @RentHourPeriod)
 IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) 
 BEGIN
  ROLLBACK TRAN
  SET @Ret = -3
  RETURN @Ret
 END

    INSERT INTO ItemPurchaseLogByCash(AID, ItemID, Date, RentHourPeriod, Cash, MobileCode, sid)   
    VALUES (@AID, @ItemID, GETDATE(), @RentHourPeriod, 0, null, '-1')  

 SET @SubDescription = 'Event ItemID : ' + CAST(@ItemID AS varchar(16))

 INSERT INTO Event(AID, CID, RegDate, EventName, SubDescription)
 VALUES (@AID, 0, GETDATE(), @EventName, @SubDescription)
 IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) 
 BEGIN
  ROLLBACK TRAN
  SET @Ret = -4
  RETURN @Ret
 END

 COMMIT TRAN
 SET @Ret = 1
 RETURN @Ret
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNInsertEventSetItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spNHNInsertEventSetItem]
 @UserID varchar(20)		-- 유저 ID.
, @CSSID int			-- 지급할 ItemID.
, @RentHourPeriod int		-- 지급한 아이템의 사용 기간.
, @EventName varchar(24)	-- 진행중인 이벤트 이름.
, @Ret int OUTPUT		-- 결과 반환값. 1:성공, 나머지는 실패.
AS
BEGIN
 SET NOCOUNT ON
 
 DECLARE @AID 			int
 DECLARE @SubDescription 	varchar(128)

 SELECT @AID = AID FROM Account(NOLOCK) WHERE UserID = @UserID
 IF @AID IS NULL
 BEGIN
  SET @Ret = -1
  RETURN @Ret
 END

 IF NOT EXISTS(
  SELECT CSSID FROM CashSetShop(NOLOCK) WHERE CSSID = @CSSID)
 BEGIN
  SET @Ret = -2
  RETURN @Ret
 END

 BEGIN TRAN
 INSERT INTO AccountItem(AID, ItemID, RentDate, RentHourPeriod)
 SELECT @AID, i.ItemID, GETDATE(), @RentHourPeriod
 FROM CashSetShop css(NOLOCK), CashSetItem csi(NOLOCK), CashShop cs(NOLOCK), Item i(NOLOCK)
 WHERE css.CSSID = @CSSID AND csi.CSSID = css.CSSID AND cs.CSID = csi.CSID
  AND i.ItemID = cs.ItemID
 IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) 
 BEGIN
  ROLLBACK TRAN
  SET @Ret = -3
  RETURN @Ret
 END

 INSERT INTO SetItemPurchaseLogByCash (AID, CSSID, Date, RentHourPeriod, Cash, MobileCode, sid)  
 VALUES (@AID, @CSSID, GETDATE(), @RentHourPeriod, 0, null, @EventName)  
 IF (@@ERROR <> 0) OR (0 = @@ROWCOUNT)
 BEGIN  
  ROLLBACK TRAN
  SET @Ret = -4
  RETURN @Ret
 END  

 SET @SubDescription = 'Event CSSID : ' + CAST(@CSSID AS varchar(16))

 INSERT INTO Event(AID, CID, RegDate, EventName, SubDescription)
 VALUES (@AID, 0, GETDATE(), @EventName, @SubDescription)
 IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) 
 BEGIN
  ROLLBACK TRAN
  SET @Ret = -5
  RETURN @Ret
 END

 COMMIT TRAN
 SET @Ret = 1
 RETURN @Ret
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNPresentCashItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 단일 아이템 선물하기  
CREATE  PROC [dbo].[spNHNPresentCashItem]  
 @SenderUserID varchar(20)  
, @ReceiverUserID varchar(20)  
, @CSID  int  
, @Cash  int  
, @sid varchar(20)
, @RentHourPeriod smallint = NULL  
, @MobileCode char(16) = NULL  
AS  
BEGIN
 SET NoCount On  
  
 DECLARE @ItemID  int  
 DECLARE @ReceiverAID int  
  
 SELECT @ReceiverAID = AID FROM Account (NOLOCK) WHERE UserID = @ReceiverUserID  
   
 IF @ReceiverAID IS NULL  
 BEGIN  
  RETURN 0  
 END  
 ELSE  
 BEGIN  
  DECLARE @RentDate datetime  
  -- @RentHourPeriod값을 가지고 기간제인지 검사.  
  IF @RentHourPeriod = 0 OR @RentHourPeriod IS NULL  
  BEGIN  
   -- 기간제 아이템일 경우 영구 아이템 판매 여부 검사  
   DECLARE @RentType  TINYINT  
   DECLARE @RCSPID  INT  
  
    SELECT @RentType = RentType FROM CashShop WHERE CSID=@CSID  
   IF @RentType = 1  
   BEGIN  
    SELECT @RCSPID = RCSPID FROM RentCashShopPrice WHERE CSID=@CSID AND RentHourPeriod is NULL  
    IF @RCSPID IS NULL  
    BEGIN  
     RETURN 0  
    END  
   END  
  
   -- 일반 아이템인 경우  
   SET @RentDate = NULL  
  END  
  ELSE  
  BEGIN  
   SET @RentDate = GETDATE()  
  END  
  
  
  SELECT @ItemID = ItemID FROM CashShop (NOLOCK) WHERE CSID = @CSID  
  
  IF @ItemID IS NOT NULL  
  BEGIN  
   BEGIN TRAN  
     
    -- 아이템 생성.  
    INSERT INTO AccountItem (AID, ItemID, RentDate, RentHourPeriod)  
    VALUES (@ReceiverAID, @ItemID, @RentDate, @RentHourPeriod)  
    IF (@@ERROR <> 0) OR (0 = @@ROWCOUNT)
    BEGIN  
     ROLLBACK  
     RETURN 0  
    END  
           
    -- 선물 로그 생성.  
    INSERT INTO CashItemPresentLog (SenderUserID, ReceiverAID, CSID, Date, Cash, RentHourPeriod, MobileCode, sid)  
    VALUES (@SenderUserID, @ReceiverAID, @CSID, GETDATE(), @Cash, @RentHourPeriod, @MobileCode, @sid)  
    IF (@@ERROR <> 0) OR (0 = @@ROWCOUNT)
    BEGIN  
     ROLLBACK  
     RETURN 0  
    END  
       
   COMMIT TRAN  
  END  
  ELSE  
  BEGIN  
   RETURN 0  
  END  
  
    
  RETURN 1  
 END  
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNPresentCashSetItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROC [dbo].[spNHNPresentCashSetItem]  
 @SenderUserID varchar(20)  
, @ReceiverUserID varchar(20)  
, @CSSID  int  
, @Cash  int  
, @sid varchar(20)
, @RentHourPeriod smallint = NULL  
,  @MobileCode char(16) = NULL  
AS  
BEGIN
 SET NoCount On  
  
 DECLARE @ReceiverAID int  
  
 SELECT @ReceiverAID = AID FROM Account WHERE UserID = @ReceiverUserID  
  
 IF @ReceiverAID IS NOT NULL  
 BEGIN  
  DECLARE @RentDate  datetime     
  
  -- @RentHourPeriod값을 가지고 기간제인지 검사.  
  IF @RentHourPeriod = 0 OR @RentHourPeriod IS NULL  
  BEGIN  
   -- 기간제 아이템일 경우 영구 아이템 판매 여부 검사  
   DECLARE @RentType  TINYINT  
   DECLARE @RCSSPID INT  
  
   SELECT @RentType = RentType FROM CashSetShop WHERE CSSID=@CSSID  
   IF @RentType = 1  
   BEGIN  
    SELECT @RCSSPID = RCSSPID FROM RentCashSetShopPrice WHERE CSSID=@CSSID AND RentHourPeriod is NULL  
    IF @RCSSPID IS NULL  
    BEGIN  
     RETURN 0  
    END  
   END  
  
   -- 일반 아이템일 경우  
   SET @RentDate = NULL  
  END  
  ELSE  
  BEGIN  
   SET @RentDate = GETDATE()  
  END  
  
  
  BEGIN TRAN  
   DECLARE curBuyCashSetItem  INSENSITIVE CURSOR  
  
   FOR  
    SELECT CSID FROM CashSetItem WHERE CSSID = @CSSID  
   FOR READ ONLY  
  
   OPEN curBuyCashSetItem  
  
   DECLARE @varCSID int  
   DECLARE @ItemID  int  
  
   FETCH FROM curBuyCashSetItem INTO @varCSID  
  
   WHILE @@FETCH_STATUS = 0  
   BEGIN  
    SELECT @ItemID = ItemID FROM CashShop WHERE CSID = @varCSID  
  
    IF @ItemID IS NOT NULL  
    BEGIN   
     -- 아이템 생성.  
     INSERT INTO AccountItem (AID, ItemID, RentDate, RentHourPeriod)  
     VALUES (@ReceiverAID, @ItemID, @RentDate, @RentHourPeriod)  
     IF (@@ERROR <> 0) OR (0 = @@ROWCOUNT)
     BEGIN  
      ROLLBACK  
      CLOSE curBuyCashSetItem  
      DEALLOCATE curBuyCashSetItem  
      RETURN 0  
     END       
    END  
      
    FETCH FROM curBuyCashSetItem INTO @varCSID  
   END  
  
  CLOSE curBuyCashSetItem  
  DEALLOCATE curBuyCashSetItem  
  
  -- 셋트아이템 선물 로그 생성.  
  INSERT INTO CashItemPresentLog (SenderUserID, ReceiverAID, CSSID, Date, RentHourPeriod, Cash, MobileCode, sid)  
  VALUES (@SenderUserID, @ReceiverAID, @CSSID, GETDATE(), @RentHourPeriod, @Cash, @MobileCode, @sid)  
  IF (@@ERROR <> 0) OR (0 = @@ROWCOUNT)
  BEGIN  
   ROLLBACK  
   RETURN 0  
  END  
      
  COMMIT TRAN  
  RETURN 1  
  
 END  
 ELSE  
 BEGIN  
  RETURN 0  
 END  
END
GO
/****** Object:  StoredProcedure [dbo].[spNHNUpdateClanMarkRequest]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spNHNUpdateClanMarkRequest]
	@clid INT,
	@emblemURL VARCHAR(256),
	@result INT OUTPUT
AS
SET NOCOUNT ON
BEGIN
	DECLARE @clmarkid int
	DECLARE @lastCount int
	DECLARE @lastCreated DATETIME
	DECLARE @timePassed bigint
	
	SELECT @clmarkid=clmarkid, @lastCount=lastCount, @lastCreated=lastCreated
	FROM nhnclanmark 
	WHERE clid = @clid

	IF @clmarkid IS NULL
	BEGIN
		INSERT INTO nhnclanmark 
		(clid, emblemURL, lastCount, lastCreated) VALUES 
		(@clid, @emblemURL, 1, GETDATE())		
	END
	ELSE
	BEGIN
		SET @timePassed = datediff(hh, @lastCreated, GETDATE())

		IF @lastCount >= 3
		BEGIN
			IF @timePassed >= (24 * 30)
			BEGIN
				SET @lastCount = 1
				SET @lastCreated = GETDATE()
			END
			ELSE
			BEGIN
				SET @result = -1
				RETURN
			END
		END
		ELSE
		BEGIN
			IF @timePassed >= (24 * 30)
			BEGIN
				SET @lastCount = 1
				SET @lastCreated = GETDATE()
			END
			ELSE
			BEGIN
				SET @lastCount = @lastCount + 1
			END
		END

		BEGIN TRAN
			DELETE FROM nhnclanmark 
			WHERE clid = @clid
	
			INSERT INTO nhnclanmark 
			(clid, emblemURL, lastCount, lastCreated) VALUES 
			(@clid, @emblemURL, @lastCount, @lastCreated)
		COMMIT TRAN
		
	END

	SET @result = 0
	RETURN

END
GO
/****** Object:  StoredProcedure [dbo].[spPresentCashItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ´ÜÀÏ ¾ÆÀÌÅÛ ¼±¹°ÇÏ±â
CREATE  PROC [dbo].[spPresentCashItem]
	@SenderUserID	varchar(20)
,	@ReceiverUserID	varchar(20)
,	@CSID		int
,	@Cash		int
,	@RentHourPeriod	smallint = NULL
,	@MobileCode char(16) = NULL
AS
	SET NoCount On

	DECLARE	@ItemID		int
	DECLARE @ReceiverAID	int

	SELECT @ReceiverAID = AID FROM Account (NOLOCK) WHERE UserID = @ReceiverUserID
	
	IF @ReceiverAID IS NULL
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		DECLARE @RentDate	datetime
		-- @RentHourPeriod°ªÀ» °¡Áö°í ±â°£Á¦ÀÎÁö °Ë»ç.
		IF @RentHourPeriod = 0 OR @RentHourPeriod IS NULL
		BEGIN
			-- ±â°£Á¦ ¾ÆÀÌÅÛÀÏ °æ¿ì ¿µ±¸ ¾ÆÀÌÅÛ ÆÇ¸Å ¿©ºÎ °Ë»ç
			DECLARE @RentType 	TINYINT
			DECLARE @RCSPID		INT

				SELECT @RentType = RentType FROM CashShop WHERE CSID=@CSID
			IF @RentType = 1
			BEGIN
				SELECT @RCSPID = RCSPID FROM RentCashShopPrice WHERE CSID=@CSID AND RentHourPeriod is NULL
				IF @RCSPID IS NULL
				BEGIN
					RETURN 0
				END
			END

			-- ÀÏ¹Ý ¾ÆÀÌÅÛÀÎ °æ¿ì
			SET @RentDate = NULL
		END
		ELSE
		BEGIN
			SET @RentDate = GETDATE()
		END


		SELECT @ItemID = ItemID FROM CashShop (NOLOCK) WHERE CSID = @CSID

		IF @ItemID IS NOT NULL
		BEGIN
			BEGIN TRAN
			
				-- ¾ÆÀÌÅÛ »ý¼º.
				INSERT INTO AccountItem (AID, ItemID, RentDate, RentHourPeriod)
				VALUES (@ReceiverAID, @ItemID, @RentDate, @RentHourPeriod)
				
				IF @@ERROR <> 0
				BEGIN
					ROLLBACK
					RETURN 0
				END
									
				-- ¼±¹° ·Î±× »ý¼º.
				INSERT INTO CashItemPresentLog (SenderUserID, ReceiverAID, CSID, Date, Cash, RentHourPeriod, MobileCode)
				VALUES (@SenderUserID, @ReceiverAID, @CSID, GETDATE(), @Cash, @RentHourPeriod, @MobileCode)
				
				IF @@ERROR <> 0
				BEGIN
					ROLLBACK
					RETURN 0
				END
					
			COMMIT TRAN
		END
		ELSE
		BEGIN
			RETURN 0
		END

		
		RETURN 1
	END
GO
/****** Object:  StoredProcedure [dbo].[spPresentCashSetItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROC [dbo].[spPresentCashSetItem]
	@SenderUserID	varchar(20)
,	@ReceiverUserID	varchar(20)
,	@CSSID		int
,	@Cash		int
,	@RentHourPeriod	smallint = NULL
, 	@MobileCode char(16) = NULL
AS
	SET NoCount On

	DECLARE @ReceiverAID	int

	SELECT @ReceiverAID = AID FROM Account WHERE UserID = @ReceiverUserID

	IF @ReceiverAID IS NOT NULL
	BEGIN
		DECLARE @RentDate		datetime			

		-- @RentHourPeriod°ªÀ» °¡Áö°í ±â°£Á¦ÀÎÁö °Ë»ç.
		IF @RentHourPeriod = 0 OR @RentHourPeriod IS NULL
		BEGIN
			-- ±â°£Á¦ ¾ÆÀÌÅÛÀÏ °æ¿ì ¿µ±¸ ¾ÆÀÌÅÛ ÆÇ¸Å ¿©ºÎ °Ë»ç
			DECLARE @RentType 	TINYINT
			DECLARE @RCSSPID	INT

			SELECT @RentType = RentType FROM CashSetShop WHERE CSSID=@CSSID
			IF @RentType = 1
			BEGIN
				SELECT @RCSSPID = RCSSPID FROM RentCashSetShopPrice WHERE CSSID=@CSSID AND RentHourPeriod is NULL
				IF @RCSSPID IS NULL
				BEGIN
					RETURN 0
				END
			END

			-- ÀÏ¹Ý ¾ÆÀÌÅÛÀÏ °æ¿ì
			SET @RentDate = NULL
		END
		ELSE
		BEGIN
			SET @RentDate = GETDATE()
		END


		BEGIN TRAN
			DECLARE curBuyCashSetItem 	INSENSITIVE CURSOR

			FOR
				SELECT CSID FROM CashSetItem WHERE CSSID = @CSSID
			FOR READ ONLY

			OPEN curBuyCashSetItem

			DECLARE @varCSID	int
			DECLARE @ItemID		int

			FETCH FROM curBuyCashSetItem INTO @varCSID

			WHILE @@FETCH_STATUS = 0
			BEGIN
				SELECT @ItemID = ItemID FROM CashShop WHERE CSID = @varCSID

				IF @ItemID IS NOT NULL
				BEGIN	
					-- ¾ÆÀÌÅÛ »ý¼º.
					INSERT INTO AccountItem (AID, ItemID, RentDate, RentHourPeriod)
					VALUES (@ReceiverAID, @ItemID, @RentDate, @RentHourPeriod)
					
					IF @@ERROR <> 0
					BEGIN
						ROLLBACK
						CLOSE curBuyCashSetItem
						DEALLOCATE curBuyCashSetItem
						RETURN 0
					END					
				END
				
				FETCH FROM curBuyCashSetItem INTO @varCSID
			END

		CLOSE curBuyCashSetItem
		DEALLOCATE curBuyCashSetItem

		-- ¼ÂÆ®¾ÆÀÌÅÛ ¼±¹° ·Î±× »ý¼º.
		INSERT INTO CashItemPresentLog (SenderUserID, ReceiverAID, CSSID, Date, RentHourPeriod, Cash, MobileCode)
		VALUES (@SenderUserID, @ReceiverAID, @CSSID, GETDATE(), @RentHourPeriod, @Cash, @MobileCode)

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN 0
		END
				
		COMMIT TRAN
		RETURN 1

	END
	ELSE
	BEGIN
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[spRegularClearDeleletedCharIntem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spRegularClearDeleletedCharIntem]
AS
BEGIN
 SET NOCOUNT ON

 DELETE CharacterItem
 WHERE CIID IN (
  SELECT TOP 10000 CIID 
  FROM CharacterItem ci(NOLOCK)
  WHERE CID IS NULL 
  ORDER BY CIID)
END
GO
/****** Object:  StoredProcedure [dbo].[spRegularClearFriendList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spRegularClearFriendList]
AS
BEGIN
 SET NOCOUNT ON

 DELETE FROM Friend
 WHERE id IN (
  SELECT TOP 10000 id
  FROM Friend(NOLOCK)
  WHERE DeleteFlag = 1)
END
GO
/****** Object:  StoredProcedure [dbo].[spRegularTranslateServerLog]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spRegularTranslateServerLog]  
AS   
 SET NOCOUNT ON  
 DECLARE @StartTime char(16)  
 DECLARE @EndTime char(16)  

  

 SET @StartTime = CONVERT(char(13), DATEADD(hh, -1, GETDATE()), 120) + ':00'  

 SET @EndTime = CONVERT(char(13), GETDATE(), 120) + ':00'  

  

 INSERT INTO LogDB.dbo.ServerLogStorage(ServerID  

  , PlayerCount, GameCount, BlockCount, NonBlockCount  

  , Time)  

 SELECT ServerID, PlayerCount, GameCount, BlockCount, NonBlockCount, Time  

 FROM ServerLog(NOLOCK)  

 WHERE ServerID < 200 AND Time >= @StartTime AND Time < @EndTime  

 ORDER BY ServerID, Time
GO
/****** Object:  StoredProcedure [dbo].[spRegularUpdateAccountPenaltyPeriod]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Á¤±âÀûÀ¸·Î ÇØÁÖ´Â ÆÐ³ÎÆ¼ ¾÷µ¥ÀÌÆ®
CREATE PROC [dbo].[spRegularUpdateAccountPenaltyPeriod]
AS
SET NOCOUNT ON
UPDATE AccountPenaltyPeriod SET DayLeft=DayLeft-1

DECLARE curAccountPenaltyPeriod INSENSITIVE CURSOR
FOR
	SELECT AID FROM AccountPenaltyPeriod WHERE DayLeft <= 0
FOR READ ONLY

OPEN curAccountPenaltyPeriod

DECLARE @varAID int
DECLARE @sql varchar(100)

FETCH FROM curAccountPenaltyPeriod INTO @varAID

WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @sql = 'UPDATE Account SET UGradeID=100 WHERE AID=' + CONVERT(varchar(16), @varAID)
	EXEC(@sql)
	SELECT @sql = 'DELETE FROM AccountPenaltyPeriod WHERE AID=' + CONVERT(varchar(16), @varAID)
	EXEC(@sql)

	FETCH FROM curAccountPenaltyPeriod INTO @varAID
END

CLOSE curAccountPenaltyPeriod
DEALLOCATE curAccountPenaltyPeriod
GO
/****** Object:  StoredProcedure [dbo].[spRegularUpdateClanRankIncrease]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Å¬·£ ·©Å· Áõ°¡ºÐ ¾÷µ¥ÀÌÆ® - ¸ÅÀÏ »õº® 12½Ã¿¡ ¾÷µ¥ÀÌÆ®
CREATE PROC [dbo].[spRegularUpdateClanRankIncrease]
AS
	SET NOCOUNT ON

	-- ²Ãµî·©Å·À» ±¸ÇÑ´Ù.
	DECLARE @LowestRank int
	SELECT TOP 1 @LowestRank=Ranking FROM Clan 
	WHERE DeleteFlag=0 AND Ranking>0 
	order by ranking desc

	IF @LowestRank is NULL SELECT @LowestRank = 0

	UPDATE Clan
	SET RankIncrease=(LastDayRanking-Ranking)
	WHERE DeleteFlag=0 AND Ranking>0 AND LastDayRanking != 0

	-- Ã³À½ ·©Å·¿¡ ÁøÀÔÇßÀ» °æ¿ì
	UPDATE Clan
	SET RankIncrease=@LowestRank-Ranking
	WHERE DeleteFlag=0 AND Ranking>0 AND LastDayRanking = 0

	-- LastDayRanking ¾÷µ¥ÀÌÆ®
	UPDATE Clan 
	SET LastDayRanking=Ranking 
	where DeleteFlag=0 and Ranking>0
GO
/****** Object:  StoredProcedure [dbo].[spRegularUpdateClanRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spRegularUpdateClanRanking]
AS
BEGIN
 SET NOCOUNT ON
 CREATE TABLE #clan_rank (rank INT IDENTITY, clan_id INT)

 INSERT INTO #clan_rank(clan_id)
 SELECT clid
 FROM clan(NOLOCK)
 WHERE deleteflag = 0 AND ((wins <> 0) OR (Losses <> 0))
 ORDER BY Point DESC, Wins DESC, Losses DESC

 UPDATE clan
 SET Ranking = cr.rank
 FROM #clan_rank cr
 WHERE clid = cr.clan_id

 DROP TABLE #clan_rank
END
GO
/****** Object:  StoredProcedure [dbo].[spRegularUpdateClanRanking_backup_20080701]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spRegularUpdateClanRanking_backup_20080701]
AS
SET NOCOUNT ON

DECLARE @varRanking int
SELECT @varRanking = 0

DECLARE curRankClan INSENSITIVE CURSOR
FOR
	SELECT CLID
	FROM Clan(nolock)
	WHERE DeleteFlag=0 AND ((Wins != 0) OR (Losses != 0)) 
	ORDER BY Point Desc, Wins Desc, Losses Asc

FOR READ ONLY

OPEN curRankClan

DECLARE @varCLID int
DECLARE @sql varchar(100)

FETCH FROM curRankClan INTO @varCLID

WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @varRanking = @varRanking + 1

	-- ·©Å· ¾÷µ¥ÀÌÆ®
	UPDATE Clan SET Ranking = @varRanking WHERE CLID=@varCLID


	FETCH FROM curRankClan INTO @varCLID
END

CLOSE curRankClan
DEALLOCATE curRankClan
GO
/****** Object:  StoredProcedure [dbo].[spRegularUpdateDeleteClan]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Á¤±âÀûÀ¸·Î »õº® 7½Ã¿¡ ¾÷µ¥ÀÌÆ®ÇØÁÖ´Â Å¬·£ Æó¼â
CREATE PROC [dbo].[spRegularUpdateDeleteClan]
AS
SET NOCOUNT ON
DECLARE curDeleteClan INSENSITIVE CURSOR
FOR
	SELECT CLID FROM Clan WHERE DeleteFlag=2
FOR READ ONLY

OPEN curDeleteClan

DECLARE @varCLID int
DECLARE @varClanName	varchar(32)
DECLARE @sql varchar(100)

FETCH FROM curDeleteClan INTO @varCLID

WHILE @@FETCH_STATUS = 0
BEGIN
	-- Å¬·£¿ø »èÁ¦
	SELECT @sql = 'DELETE FROM ClanMember WHERE CLID=' + CONVERT(varchar(16), @varCLID)
	--SELECT @sql
	EXEC(@sql)

	SELECT @varClanName=Name FROM Clan WHERE CLID=@varCLID

	-- Å¬·£ »èÁ¦
	SELECT @sql = 'UPDATE Clan SET Name=NULL, MasterCID=NULL, DeleteFlag=1, DeleteName=''' + @varClanName + ''' WHERE CLID=' + CONVERT(varchar(16), @varCLID)
	--SELECT @sql
	EXEC(@sql)

	FETCH FROM curDeleteClan INTO @varCLID
END

CLOSE curDeleteClan
DEALLOCATE curDeleteClan
GO
/****** Object:  StoredProcedure [dbo].[spRegularUpdateHonorRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ÇÑ´Þ¿¡ ÇÑ¹ø¾¿ ¸í¿¹ÀÇ Àü´ç ¾÷µ¥ÀÌÆ®, ²À ±× ´ÙÀ½´ÞÀÇ 1ÀÏ¿¡ ÇØ¾ßÇÑ´Ù.
CREATE PROC [dbo].[spRegularUpdateHonorRanking]
AS
SET NOCOUNT ON
BEGIN TRAN -------------

EXEC [spRegularUpdateClanRanking]

DECLARE @Year		int
DECLARE @Month		int

SELECT @Year = YEAR(GETDATE())
SELECT @Month = MONTH(GETDATE())

IF (@Month = 1) 
BEGIN
	SELECT @Year = @Year-1
END

SELECT @Month = @Month - 1

IF (@Month = 0)
BEGIN
	SELECT @Month = 12
END

INSERT INTO ClanHonorRanking(CLID, ClanName, Point, Wins, Losses, Ranking, Year, Month)
SELECT CLID, Name AS ClanName, Point, Wins, Losses, Ranking, @Year, @Month
FROM Clan 
WHERE DeleteFlag=0 AND Ranking>0
ORDER BY Ranking
IF 0 <> @@ERROR BEGIN -- ¿©±â Ãß°¡.
	ROLLBACK TRAN
	RETURN
END

-- Å¬·£ ¸®¼Â
UPDATE Clan SET Ranking=0, Wins=0, Losses=0, Point=1000, RankIncrease=0, LastDayRanking=0
IF 0 = @@ROWCOUNT BEGIN -- ¿©±â Ãß°¡.
	ROLLBACK TRAN
	RETURN
END

COMMIT TRAN -----------
GO
/****** Object:  StoredProcedure [dbo].[spRegularUpdateShopRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spRegularUpdateShopRanking]
AS
SET NOCOUNT ON
BEGIN
	BEGIN TRAN
		/* ¿ø°Å¸® ¹«±â ÀÎ±â¼øÀ§ */
		IF EXISTS (SELECT name FROM tempdb.dbo.sysobjects WHERE name LIKE '#TempShopRankRange%')
		DROP TABLE #TempShopRankRange
		
	
		SELECT TOP 5 IDENTITY(INT,1,1) Rank, 'range weapon' AS Category, i.Name, COUNT(l.ItemID) AS Count, c.CSID, NULL AS CSSID, i.Slot,
			i.ResSex, i.ResLevel, c.CashPrice
		INTO #TempShopRankRange
		FROM ItemPurchaseLogByCash l(NOLOCK), Item i(NOLOCK), CashShop c(NOLOCK)
		WHERE Date > DATEADD(day, -7, GetDate()) AND i.Slot=2 AND l.ItemID=i.ItemID AND l.ItemID=c.ItemID
		GROUP BY l.ItemID, i.Slot, i.Name, c.CSID, i.ResSex, i.ResLevel, c.CashPrice
		ORDER BY Count DESC
		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN (-1)
		END
		
		/* ±ÙÁ¢ ¹«±â ÀÎ±â¼øÀ§ */
		IF EXISTS (SELECT name FROM tempdb.dbo.sysobjects WHERE name LIKE '#TempShopRankMelee%')
		DROP TABLE #TempShopRankMelee
		
		SELECT TOP 5 IDENTITY(INT,1,1) Rank, 'melee weapon' AS Category, i.Name, COUNT(l.ItemID) AS Count, c.CSID, NULL AS CSSID, i.Slot,
			i.ResSex, i.ResLevel, c.CashPrice
		INTO #TempShopRankMelee
		FROM ItemPurchaseLogByCash l(NOLOCK), Item i(NOLOCK), CashShop c(NOLOCK)
		WHERE Date > DATEADD(day, -7, GetDate()) AND i.Slot=1 AND l.ItemID=i.ItemID AND l.ItemID=c.ItemID
		GROUP BY l.ItemID, i.Slot, i.Name, c.CSID, i.ResSex, i.ResLevel, c.CashPrice
		ORDER BY Count DESC
		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN (-1)
		END
		
		/* Æ¯¼ö¾ÆÀÌÅÛ ÀÎ±â¼øÀ§ */
		IF EXISTS (SELECT name FROM tempdb.dbo.sysobjects WHERE name LIKE '#TempShopRankSpecial%')
		DROP TABLE #TempShopRankSpecial
		
		SELECT TOP 5 IDENTITY(INT,1,1) Rank, 'specail item' AS Category, i.Name, COUNT(l.ItemID) AS Count, c.CSID, NULL AS CSSID, i.Slot,
			i.ResSex, i.ResLevel, c.CashPrice
		INTO #TempShopRankSpecial
		FROM ItemPurchaseLogByCash l(NOLOCK), Item i(NOLOCK), CashShop c(NOLOCK)
		WHERE Date > DATEADD(day, -7, GetDate()) AND i.Slot=3 AND l.ItemID=i.ItemID AND l.ItemID=c.ItemID
		GROUP BY l.ItemID, i.Slot, i.Name, c.CSID, i.ResSex, i.ResLevel, c.CashPrice
		ORDER BY Count DESC
		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN (-1)
		END
		
		/* ¹æ¾î±¸ ÀÎ±â¼øÀ§ */
		IF EXISTS (SELECT name FROM tempdb.dbo.sysobjects WHERE name LIKE '#TempShopRankArmor%')
		DROP TABLE #TempShopRankArmor
		
		SELECT TOP 5 IDENTITY(INT,1,1) Rank, 'defence' AS Category, i.Name, COUNT(l.ItemID) AS Count, c.CSID, NULL AS CSSID, 
			CASE i.Slot 
				WHEN 0 THEN 'no limit'
				WHEN 1 THEN 'melee weapon'
				WHEN 2 THEN 'range weapon'
				WHEN 3 THEN 'item'
				WHEN 4 THEN 'haed'
				WHEN 5 THEN 'chest'
				WHEN 6 THEN 'hands'
				WHEN 7 THEN 'legs'
				WHEN 8 THEN 'feet'
				WHEN 9 THEN 'finger'
			END AS Slot, i.ResSex, i.ResLevel, c.CashPrice
		INTO #TempShopRankArmor
		FROM ItemPurchaseLogByCash l(NOLOCK), Item i(NOLOCK), CashShop c(NOLOCK)
		WHERE Date > DATEADD(day, -7, GetDate()) AND 4<=i.Slot AND i.Slot<=9 AND l.ItemID=i.ItemID AND l.ItemID=c.ItemID
		GROUP BY l.ItemID, i.Slot, i.Name, c.CSID, i.ResSex, i.ResLevel, c.CashPrice
		ORDER BY COUNT(l.ItemID) DESC
		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN (-1)
		END
		
		/* ¼¼Æ® ÀÎ±â¼øÀ§ */
		IF EXISTS (SELECT name FROM tempdb.dbo.sysobjects WHERE name LIKE '#TempShopRankSet%')
		DROP TABLE #TempShopRankSet
		
		SELECT TOP 5 IDENTITY(INT,1,1) Rank, 'set' AS Category, s.Name, COUNT(l.CSSID) AS Count, NULL AS CSID, l.CSSID, 
			'set' AS Slot, s.ResSex, s.ResLevel, s.CashPrice
		INTO #TempShopRankSet
		FROM SetItemPurchaseLogByCash l(NOLOCK), CashSetShop s(NOLOCK)
		WHERE Date > DATEADD(day, -7, GetDate()) AND l.CSSID=s.CSSID
		GROUP BY l.CSSID, s.Name, s.ResSex, s.ResLevel, s.CashPrice
		ORDER BY Count DESC
		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN (-1)
		END
		
		/* ¼¥·©Å· ¸®¼Â */
		DELETE FROM CashShopRank
		
		INSERT INTO CashShopRank (Rank, Category, Name, Count, CSID, CSSID, Slot, ResSex, ResLevel, CashPrice)
			 SELECT * FROM #TempShopRankRange
		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN (-1)
		END

		INSERT INTO CashShopRank (Rank, Category, Name, Count, CSID, CSSID, Slot, ResSex, ResLevel, CashPrice)
			SELECT * FROM #TempShopRankMelee
		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN (-1)
		END

		INSERT INTO CashShopRank (Rank, Category, Name, Count, CSID, CSSID, Slot, ResSex, ResLevel, CashPrice)
			SELECT * FROM #TempShopRankSpecial
		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN (-1)
		END

		INSERT INTO CashShopRank (Rank, Category, Name, Count, CSID, CSSID, Slot, ResSex, ResLevel, CashPrice)
			SELECT * FROM #TempShopRankArmor
		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN (-1)
		END

		INSERT INTO CashShopRank (Rank, Category, Name, Count, CSID, CSSID, Slot, ResSex, ResLevel, CashPrice)
			SELECT * FROM #TempShopRankSet
		IF @@ERROR <> 0
		BEGIN
			ROLLBACK
			RETURN (-1)
		END
		
		DROP TABLE #TempShopRankRange
		DROP TABLE #TempShopRankMelee
		DROP TABLE #TempShopRankSpecial
		DROP TABLE #TempShopRankArmor
		DROP TABLE #TempShopRankSet
	COMMIT TRAN
	RETURN (1)
END
GO
/****** Object:  StoredProcedure [dbo].[spRemoveClanMember]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ¸â¹ö »èÁ¦
CREATE PROC [dbo].[spRemoveClanMember]
	@CLID		int,
	@CID		int
AS
	SET NOCOUNT ON
	DELETE FROM ClanMember WHERE (CLID=@CLID) AND (CID=@CID) AND (Grade != 1)
GO
/****** Object:  StoredProcedure [dbo].[spRemoveClanMemberFromCharName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ¸â¹ö ÀÌ¸§À¸·Î ¸â¹ö »èÁ¦
CREATE PROC [dbo].[spRemoveClanMemberFromCharName]
	@CLID				int,
	@AdminGrade			int,		-- Å»Åð½ÃÅ°·Á°í ÇÏ´Â »ç¶÷ÀÇ ±ÇÇÑ
	@MemberCharName		varchar(36)
AS
	SET NOCOUNT ON
	DECLARE @CID				int
	DECLARE @MemberGrade		int


	SELECT @CID=c.cid, @MemberGrade=cm.Grade FROM Character c(nolock), ClanMember cm(nolock)
	WHERE cm.clid=@CLID AND c.cid=cm.cid AND c.Name=@MemberCharName AND (DeleteFlag=0)

	IF (@CID IS NULL)
	BEGIN
		SELECT 0 As Ret
		return (-1)
	END

	IF @AdminGrade >= @MemberGrade
	BEGIN
		SELECT 2 As Ret
		return (-1)
	END


	IF @CID IS NOT NULL
	BEGIN
		BEGIN TRAN
		DELETE FROM ClanMember WHERE (CLID=@CLID) AND (CID=@CID) AND (Grade != 1)
		IF 0 <> @@ERROR BEGIN 
			ROLLBACK TRAN
			SELECT 3 AS Ret -- ¼öÁ¤µÈ ºÎºÐ. By SungE
			RETURN
		END
		COMMIT TRAN
		SELECT 1 As Ret
	END

/* Ret°ª ¼³¸í : 1 - ¼º°ø, 0 - ÇØ´çÅ¬·£¿øÀÌ ¾ø´Ù. , 2 - ±ÇÇÑÀÌ ¸ÂÁö ¾Ê´Ù. */
GO
/****** Object:  StoredProcedure [dbo].[spRemoveFriend]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Ä£±¸ »èÁ¦
CREATE PROC [dbo].[spRemoveFriend]
	@CID		int
,	@FriendCID	int
AS
SET NOCOUNT ON
UPDATE Friend 
SET DeleteFlag=1
WHERE CID=@CID AND FriendCID=@FriendCID
GO
/****** Object:  StoredProcedure [dbo].[spReserveCloseClan]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Å¬·£ Æó¼â ¿¹¾àÇÏ±â
CREATE PROC [dbo].[spReserveCloseClan]
	@CLID		int,
	@ClanName	varchar(24),
	@MasterCID	int
AS
	SET NOCOUNT ON
	UPDATE Clan SET DeleteFlag=2 WHERE CLID=@CLID AND Name=@ClanName AND MasterCID=@MasterCID
GO
/****** Object:  StoredProcedure [dbo].[spResetAccountHackingBlock]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spResetAccountHackingBlock]
 @AID INT
, @HackingType TINYINT
AS
BEGIN
 SET NOCOUNT ON

 UPDATE Account
 SET HackingType = @HackingType
 WHERE AID = @AID
END
GO
/****** Object:  StoredProcedure [dbo].[spRewardCharBattleTimeReward]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spRewardCharBattleTimeReward]
-- ALTER PROC dbo.spRewardCharBattleTimeReward
    @CID                    INT
    , @BRID                 INT
    , @BRTID                INT
    , @BattleTime           INT
    , @KillCount            INT
    , @ItemID               INT
    , @ItemCnt              INT
    , @RentHourPeriod       INT
    , @IsSpendableItem      INT
AS BEGIN

    SET NOCOUNT ON;

    DECLARE @OrderCIID INT;

    BEGIN TRAN ----

        -- 업데이트 하고
        UPDATE  dbo.CharacterBattleTimeRewardInfo
        SET     RewardCount = CASE WHEN BRTID = @BRTID  THEN RewardCount + 1 
                                                        ELSE 1 END,
                BRTID = @BRTID, BattleTime = 0, KillCount = 0, LastUpdatedTime = GETDATE()
        WHERE   CID = @CID
        AND     BRID = @BRID

        IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN
            ROLLBACK TRAN;
            SELECT -1 AS 'Ret'
            RETURN;
        END

        IF( @IsSpendableItem = 1 ) BEGIN
					
			-- 이미 갖고 있는지 확인해본다.
			SELECT	@OrderCIID = CIID 
			FROM	CharacterItem(NOLOCK) 
			WHERE	CID = @CID 
			AND		ItemID = @ItemID;

            -- 이미 갖고 있지 않다면 새로 추가해준다.
            IF( @OrderCIID IS NOT NULL ) BEGIN

	            UPDATE	dbo.CharacterItem				-- Item 추가
	            SET		Cnt = Cnt + @ItemCnt
	            WHERE	CIID = @OrderCIID
	            AND		CID = @CID;
            	
	            IF( 0 <> @@ERROR OR 0 = @@ROWCOUNT ) BEGIN      
		            ROLLBACK TRAN
		            SELECT -2 AS 'Ret'
		            RETURN;
	            END
            							
            END ELSE BEGIN

	            INSERT INTO CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt)
	            VALUES (@CID, @ItemID, GETDATE(), GETDATE(), @RentHourPeriod, @ItemCnt)
            	
	            IF( 0 <> @@ERROR OR 0 = @@ROWCOUNT ) BEGIN      
		            ROLLBACK TRAN
		            SELECT -3 AS 'Ret'
		            RETURN;
	            END
            	
	            SET @OrderCIID = @@IDENTITY;	
            END
				
        END
        ELSE BEGIN
        		
	        INSERT INTO CharacterItem (CID, ItemID, RegDate, RentDate, RentHourPeriod, Cnt)
            VALUES (@CID, @ItemID, GETDATE(), GETDATE(), @RentHourPeriod, @ItemCnt)
        	
	        SET @OrderCIID = @@IDENTITY;	
        	
	        IF( 0 <> @@ERROR OR 0 = @@ROWCOUNT ) BEGIN      
		        ROLLBACK TRAN
		        SELECT -4 AS 'Ret'
		        RETURN;
	        END
        				
        END 

        -- 로그 남기고
        INSERT dbo.CharacterBattleTimeRewardLog(CID, BRID, BRTID, BattleTime, KillCount, ItemID, ItemCnt, RentHourPeriod)
        VALUES (@CID, @BRID, @BRTID, @BattleTime, @KillCount, @ItemID, @ItemCnt, @RentHourPeriod);

        IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN
            ROLLBACK TRAN;
            SELECT -5 AS 'Ret'
            RETURN;
        END        

    COMMIT TRAN ---

    SELECT @OrderCIID AS 'Ret';

END
GO
/****** Object:  StoredProcedure [dbo].[spSearchCashItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ¾ÆÀÌÅÛ °Ë»ö */
CREATE  PROC [dbo].[spSearchCashItem]
	@Slot		tinyint,
	@ResSex		tinyint,
	@ResMinLevel	int = NULL,
	@ResMaxLevel	int = NULL,
	@ItemName	varchar(256) = '',
	@Page		int = 1,
	@PageCount	int OUTPUT
AS
SET NOCOUNT ON

SELECT @PageCount = 1

SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot, cs.CashPrice AS Cash, 
cs.WebImgName AS WebImgName, i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight, 
i.Description AS Description, cs.NewItemOrder AS IsNewItem, cs.RentType AS RentType FROM CashShop cs(nolock), Item i(nolock) 
WHERE i.ItemID = cs.ItemID AND i.Name=@ItemName AND cs.Opened=1
ORDER BY cs.csid DESC
GO
/****** Object:  StoredProcedure [dbo].[spSearchCashItem2]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ¾ÆÀÌÅÛ °Ë»ö */
CREATE  PROC [dbo].[spSearchCashItem2]
	@Slot		tinyint,
	@ResSex		tinyint,
	@ResMinLevel	int = NULL,
	@ResMaxLevel	int = NULL,
	@ItemName	varchar(256) = '',
	@Page		int = 1,
	@PageCount	int OUTPUT
AS
SET NOCOUNT ON

SELECT @PageCount = 1

SELECT cs.csid AS CSID, i.name AS Name, i.Slot AS Slot, cs.CashPrice AS Cash, 
cs.WebImgName AS WebImgName, i.ResSex AS ResSex, i.ResLevel AS ResLevel, i.Weight AS Weight, 
i.Description AS Description, cs.NewItemOrder AS IsNewItem, cs.RentType AS RentType FROM CashShop cs(nolock), Item i(nolock) 
WHERE i.ItemID = cs.ItemID AND i.Name=@ItemName AND cs.Opened=1
ORDER BY cs.csid DESC
GO
/****** Object:  StoredProcedure [dbo].[spSearchTotalRankingByName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ¼øÀ§ °Ë»ö */
CREATE PROC [dbo].[spSearchTotalRankingByName]
	@Name				varchar(24)
AS
SET NOCOUNT ON
-- ¿ÍÀÏµåÄ«µå ¹®ÀÚ Ã³¸®
--SELECT @Name = REPLACE(@Name, '[', '[[]')
--SELECT @Name = REPLACE(@Name, '%', '[%]')
--SELECT @Name = REPLACE(@Name, '_', '[_]')

SELECT Rank, Level, UserID, Name, XP, KillCount, DeathCount 
FROM TotalRanking(nolock)
WHERE Name=@Name
GO
/****** Object:  StoredProcedure [dbo].[spSearchTotalRankingByNetmarbleID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ÀÚ½ÅÀÇ ·©Å· Á¤º¸.
CREATE PROC [dbo].[spSearchTotalRankingByNetmarbleID]
	@UserID varchar(20)
AS
SET NOCOUNT ON
BEGIN
	SELECT Rank, Level, Name, XP, KillCount, DeathCount, UserID 
	FROM TotalRanking (NOLOCK)
	WHERE Name = @UserID
END
GO
/****** Object:  StoredProcedure [dbo].[spSelectAccountItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spSelectAccountItem]
-- ALTER PROC dbo.spSelectAccountItem
	@AID   int    
AS BEGIN
	SET NOCOUNT ON  
		    
	SELECT	ai.AIID, ai.ItemID
			, (ai.RentHourPeriod * 60) - (DateDiff(n, ai.RentDate, GETDATE())) AS RentPeriodRemainder
			, ISNULL(RentHourPeriod, 0) AS 'RentHourPeriod'
			, ISNULL(ai.Cnt, 1) AS 'CNT'
	FROM	dbo.AccountItem ai(NOLOCK)
	WHERE	ai.AID = @AID 
	ORDER BY ai.AIID
		
END
GO
/****** Object:  StoredProcedure [dbo].[spSelectCharItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spSelectCharItem]
-- ALTER PROC dbo.spSelectCharItem  
	@CID  INT  
AS BEGIN    
	SET NOCOUNT ON
	 
	SELECT	CIID, ItemID
			, (RentHourPeriod*60) - (DateDiff(n, RentDate, GETDATE())) AS RentPeriodRemainder  
			, ISNULL(RentHourPeriod, 0) as 'RentHourPeriod'
			, ISNULL(Cnt, 1) AS 'Cnt'
	FROM	dbo.CharacterItem (NOLOCK)  
	WHERE	CID = @CID
	AND		Cnt > 0
	ORDER BY CIID
END
GO
/****** Object:  StoredProcedure [dbo].[spSelectCharItem2]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROC [dbo].[spSelectCharItem2]  
 @CID  int  
AS  
BEGIN
 SET NOCOUNT ON

 SELECT CIID, ItemID, (RentHourPeriod*60) - (DateDiff(n, RentDate, GETDATE())) AS RentPeriodRemainder
  , ISNULL(RentHourPeriod, 0) as 'RentHourPeriod'
 FROM CharacterItem (nolock)  
 WHERE CID=@CID ORDER BY CIID  
END
GO
/****** Object:  StoredProcedure [dbo].[spSelectCharQuestItemInfoByCID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROC [dbo].[spSelectCharQuestItemInfoByCID]
	@CID	int
AS
BEGIN
	SET NOCOUNT ON
	SELECT QuestItemInfo FROM Character (NOLOCK) WHERE CID = @CID
END
GO
/****** Object:  StoredProcedure [dbo].[spSellBountyItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spSellBountyItem]
-- ALTER PROC dbo.spSellBountyItem
	@CID		INT,  
	@CIID		INT,
	@ItemID		INT,
	@Price		INT,  
	@CharBP		INT  
AS BEGIN

	SET NOCOUNT ON;
	
	BEGIN TRAN -------------------
	
		-- Bounty Áõ°¡  
		UPDATE dbo.Character SET BP = BP + @Price WHERE CID = @CID
		
		IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN  
			ROLLBACK
			SELECT -1 AS Ret;
			RETURN;
		END  


		UPDATE	dbo.CharacterItem
		SET		CID = NULL
		WHERE	CIID = @CIID
		AND		CID = @CID;
		
		IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN  
			ROLLBACK
			SELECT -2 AS Ret;
			RETURN;
		END		
		
		-- Item ÆÇ¸Å ·Î±× Ãß°¡  
		INSERT INTO dbo.ItemPurchaseLogByBounty(ItemID, CID, Date, Bounty, CharBounty, Type)
		VALUES (@ItemID, @CID, GETDATE(), @Price, @CharBP, 'ÆÇ¸Å')
		
		IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN  
			ROLLBACK
			SELECT -3 AS Ret;
			RETURN;
		END		
		
	COMMIT TRAN ------------------- 
			
	SELECT 0 AS Ret
END
GO
/****** Object:  StoredProcedure [dbo].[spSellItemToBounty]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------------------------------------------------------------------
-- 작업할 쿼리
CREATE PROC [dbo].[spSellItemToBounty]
-- ALTER PROC dbo.spSellItemToBounty
	@CID		INT,  
	@CIID		INT,
	@ItemID		INT,
	@Price		INT,  
	@CharBP		INT  
AS BEGIN

	SET NOCOUNT ON;
	
	BEGIN TRAN -------------------
	
		-- Bounty 증가  
		UPDATE dbo.Character SET BP = BP + @Price WHERE CID = @CID
		
		IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN  
			ROLLBACK
			SELECT -1 AS Ret;
			RETURN;
		END  


		UPDATE	dbo.CharacterItem
		SET		CID = NULL
		WHERE	CIID = @CIID
		AND		CID = @CID;
		
		IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN  
			ROLLBACK
			SELECT -2 AS Ret;
			RETURN;
		END		
		
		-- Item 판매 로그 추가  
		INSERT INTO dbo.ItemPurchaseLogByBounty(ItemID, CID, Date, Bounty, CharBounty, Type)
		VALUES (@ItemID, @CID, GETDATE(), @Price, @CharBP, '판매')
		
		IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN  
			ROLLBACK
			SELECT -3 AS Ret;
			RETURN;
		END		
		
	COMMIT TRAN ------------------- 
			
	SELECT 0 AS Ret
END
GO
/****** Object:  StoredProcedure [dbo].[spSellSpendableItemToBounty]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------------------------------------------------------------------
-- ÀÛ¾÷ÇÒ Äõ¸®
CREATE PROC [dbo].[spSellSpendableItemToBounty]
-- ALTER PROC dbo.spSellSpendableItemToBounty
	@CID		INT,  
	@CIID		INT,
	@ItemID		INT,
	@ItemCnt	INT,	
	@Price		INT,
	@CharBP		INT
AS BEGIN

	SET NOCOUNT ON;
			
	BEGIN TRAN -------------------
	
		-- Bounty Áõ°¡  
		UPDATE dbo.Character SET BP = BP + @Price WHERE CID = @CID;
		
		IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN  
			ROLLBACK
			SELECT -1 AS Ret;
			RETURN;
		END
		
		UPDATE	dbo.CharacterItem 
		SET		Cnt = Cnt - @ItemCnt 
		WHERE	CIID = @CIID
		AND		CID = @CID
		AND		Cnt - @ItemCnt >= 0;
			
		IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN  
			ROLLBACK
			SELECT -2 AS Ret;
			RETURN;
		END
		
		-- Item ÆÇ¸Å ·Î±× Ãß°¡  
		INSERT INTO dbo.ItemPurchaseLogByBounty (ItemID, CID, Date, Bounty, CharBounty, Type)  
		VALUES (@ItemID, @CID, GETDATE(), @Price, @CharBP, 'ÆÇ¸Å')

		IF( @@ERROR <> 0 OR @@ROWCOUNT = 0 ) BEGIN  
			ROLLBACK
			SELECT -3 AS Ret;
			RETURN;
		END		
		
	COMMIT TRAN -------------------	
		
	SELECT 0 AS Ret
END
GO
/****** Object:  StoredProcedure [dbo].[spSimpleUpdateChar]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Ä³¸¯ÅÍ Á¤º¸ ¾÷µ¥ÀÌÆ® - ÇÑ»ç¶÷ Á×ÀÏ¶§¸¶´Ù ¾÷µ¥ÀÌÆ®ÇÑ´Ù. */
CREATE PROC [dbo].[spSimpleUpdateChar]
	@CID		int,
	@Name		varchar(24),
	@Level		smallint,
	@XP		int,
	@BP		int
AS
SET NOCOUNT ON
UPDATE Character WITH (rowlock)
SET Level=@Level, XP=@XP, BP=@BP
WHERE CID=@CID AND Name=@Name
GO
/****** Object:  StoredProcedure [dbo].[spStartUpLocatorStatus]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--------------------------------------------------------------------

CREATE PROC [dbo].[spStartUpLocatorStatus]
 @LocatorID int
, @IP varchar(15)
, @Port int
, @UpdateElapsedTime int
AS
 SET NOCOUNT ON 
 IF EXISTS (SELECT LocatorID FROM LocatorStatus(NOLOCK) 
	    WHERE LocatorID = @LocatorID) BEGIN
  UPDATE LocatorStatus 
  SET IP = @IP, Port = @Port, UpdateElapsedTime = @UpdateElapsedTime, 
   LastUpdatedTime = GETDATE()
  WHERE LocatorID = @LocatorID
 END
 ELSE BEGIN
  INSERT INTO LocatorStatus(LocatorID, IP, Port, UpdateElapsedTime, LastUpdatedTime)
  VALUES (@LocatorID, @IP, @Port, @UpdateElapsedTime, GETDATE())
 END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateAccountLastLogoutTime]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spUpdateAccountLastLogoutTime]
 @AID int
as
 set nocount on

 update Account set LastLogoutTime = getdate() where AID = @AID
GO
/****** Object:  StoredProcedure [dbo].[spUpdateAccountPowerLevelingInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spUpdateAccountPowerLevelingInfo]
 @AID int
, @IsHacker tinyint
AS
BEGIN
 SET NOCOUNT ON

 IF (1 = @IsHacker) BEGIN
  UPDATE Account 
  SET IsPowerLevelingHacker = 1, PowerLevelingRegDate = GETDATE()
  WHERE AID = @AID 
 END
 ELSE BEGIN
  UPDATE Account SET IsPowerLevelingHacker = 0  WHERE AID = @AID 
 END
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateAccountUGrade]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ÆÐ³ÎÆ¼ Àû¿ë
CREATE PROC [dbo].[spUpdateAccountUGrade]
	@AID		int
,	@UGrade		int
,	@Period		int
AS
BEGIN TRAN
	SET NOCOUNT ON
	UPDATE Account SET UGradeID=@UGrade WHERE AID=@AID
	IF 0 = @@ROWCOUNT BEGIN 
		ROLLBACK TRAN
		RETURN
	END


	IF (@UGrade >= 100) AND (@UGrade<=253) BEGIN
		INSERT INTO PenaltyLog(AID, UGradeID, Date) Values(@AID, @UGrade, GETDATE())
		IF 0 <> @@ERROR BEGIN
			ROLLBACK TRAN
			RETURN
		END
	END

	IF @UGrade = 104 OR @UGrade=105 BEGIN
		INSERT INTO AccountPenaltyPeriod(AID, DayLeft) VALUES(@AID, @Period)
		IF 0 <> @@ERROR	BEGIN
			ROLLBACK TRAN
			RETURN
		END
	END
	ELSE
	BEGIN
		-- ±â°£ ÆÐ³ÎÆ¼ ÇØÁ¦
		DELETE FROM AccountPenaltyPeriod WHERE AID=@AID
		IF 0 <> @@ERROR BEGIN
			ROLLBACK TRAN
			RETURN
		END	
	END
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[spUpdateChar]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Ä³¸¯ÅÍ Á¤º¸ ¾÷µ¥ÀÌÆ® - ¾ÆÀÌÅÛ Á¤º¸´Â ¾÷µ¥ÀÌÆ® ÇÏÁö ¾Ê´Â´Ù. */
CREATE PROC [dbo].[spUpdateChar]
	@Name		varchar(24),
	@CharNum	smallint,
	@Level		smallint,
	@Sex		tinyint,
	@Hair		tinyint,
	@Face		tinyint,
	@XP		int,
	@BP		int,
	@HP		smallint,
	@AP		smallint,
	@FR		smallint,
	@CR		smallint,
	@ER		smallint,
	@WR		smallint
AS
SET NOCOUNT ON
UPDATE Character WITH (rowlock)
SET Name=@Name, Level=@Level, Sex=@Sex, Hair=@Hair, Face=@Face, XP=@XP, BP=@BP, 
  HP=@HP, AP=@AP, FR=@FR, CR=@CR, ER=@ER, WR=@WR
WHERE Name=@Name and CharNum=@CharNum
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCharBP]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* BP ¾÷µ¥ÀÌÆ® */
CREATE PROC [dbo].[spUpdateCharBP]
  @BPInc        int,
  @CID          int
AS
SET NOCOUNT ON
UPDATE Character 
SET BP=BP+(@BPInc) 
WHERE CID=@CID
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCharBRInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROC [dbo].[spUpdateCharBRInfo]
-- ALTER PROC dbo.spUpdateCharBRInfo
    @CID            INT
    , @BRID         INT
    , @BRTID        INT
    , @RewardCount  INT
    , @BattleTime   INT
    , @KillCount    INT
AS BEGIN

    SET NOCOUNT ON;

    UPDATE  dbo.CharacterBattleTimeRewardInfo
    SET     BRTID = @BRTID, BattleTime = @BattleTime, RewardCount = @RewardCount,
            KillCount = @KillCount, LastUpdatedTime = GETDATE()
    WHERE   CID = @CID
    AND     BRID = @BRID;

END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCharClanContPoint]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Å¬·£±â¿©µµ ¾÷µ¥ÀÌÆ®
CREATE PROC [dbo].[spUpdateCharClanContPoint]
	@CID		int,
	@CLID		int,
	@AddedContPoint	int
AS
	SET NOCOUNT ON
	Update ClanMember SET ContPoint=ContPoint+@AddedContPoint WHERE CID=@CID AND CLID=@CLID
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCharGambleItemCount]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------------------------------------------------------------------
-- ÀÛ¾÷ÇÒ Äõ¸®

CREATE PROC [dbo].[spUpdateCharGambleItemCount]
-- ALTER PROC dbo.spUpdateCharGambleItemCount
	@CIID			INT,
	@GIID			INT,
	@GambleCount	INT
AS BEGIN

	SET NOCOUNT ON
	
	DECLARE @Cnt	INT;
	DECLARE @CID	INT;
	
	SELECT	@CID = CID,  @Cnt = ISNULL(Cnt, 1)
	FROM	CharacterItem 
	WHERE	CIID = @CIID
	AND		ItemID = @GIID
	AND		CID IS NOT NULL;
	
	BEGIN TRAN ----------
	
		IF( @GambleCount = @Cnt ) BEGIN
		
			UPDATE	CharacterItem 
			SET		CID = NULL
			WHERE	CIID = @CIID
			
			IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN  
				ROLLBACK TRAN
				SELECT -1 AS 'Ret'
				RETURN;
			END		
			
		END
		ELSE BEGIN
		
			UPDATE	CharacterItem 
			SET		Cnt = Cnt - @GambleCount 
			WHERE	CIID = @CIID
			AND		CID = @CID
			AND		Cnt - @GambleCount > 0
			
			IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN  
				ROLLBACK TRAN
				SELECT -2 AS 'Ret'
				RETURN;
			END		
			
		END
		
	COMMIT TRAN ----------		
		
	SELECT 0 AS 'Ret'
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCharInfoData]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spUpdateCharInfoData]
-- ALTER PROC dbo.spUpdateCharInfoData	
	@CID			INT,
	@XPInc			INT,
	@BPInc			INT,
	@KillInc		INT,  
	@DeathInc		INT,
	@PlayTimeInc	INT
AS BEGIN
	SET NOCOUNT ON;
	    
	UPDATE	dbo.Character   
	SET		XP = XP + (@XPInc)
			, BP = BP + (@BPInc)
			, KillCount = KillCount + (@KillInc)
			, DeathCount = DeathCount + (@DeathInc)
			, PlayTime = PlayTime + (@PlayTimeInc)
	WHERE	CID = @CID;
END

-------------------------------------------------------------------------------------------------------------------------
-- º¹±¸ Äõ¸®
/*
DROP PROC spUpdateCharInfoData
EXEC sp_rename 'BackUp_spUpdateCharInfoData', 'spUpdateCharInfoData';
*/
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCharItemSpendCount]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------------------------------------------------------------------
-- ÀÛ¾÷ÇÒ Äõ¸®
CREATE PROC [dbo].[spUpdateCharItemSpendCount]
-- ALTER PROC dbo.spUpdateCharItemSpendCount
	@CIID		INT,
	@SpendCount	INT
AS BEGIN

	SET NOCOUNT ON;
		
	DECLARE @Cnt				INT;
	DECLARE @CID				INT;
	DECLARE @ItemID				INT;
	
	BEGIN TRAN ----------
			
		SELECT	@CID = CID, @ItemID = ItemID, @Cnt = ISNULL(Cnt, 1)
		FROM	CharacterItem 
		WHERE	CIID = @CIID;
				
		IF( @SpendCount = @Cnt ) BEGIN
		
			UPDATE	CharacterItem 
			SET		CID = NULL
			WHERE	CIID = @CIID
			
			IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN  
				ROLLBACK TRAN
				SELECT -1 AS 'Ret'
				RETURN;
			END	
			
			UPDATE	CharacterEquipmentSlot 
			SET		CIID = NULL, ItemID = NULL
			WHERE	CID = @CID
			AND		CIID = @CIID
			AND		ItemID = @ItemID;
			
			IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN  
				ROLLBACK TRAN
				SELECT -2 AS 'Ret'
				RETURN;
			END	
			
		END
		ELSE BEGIN
		
			UPDATE	CharacterItem 
			SET		Cnt = Cnt - @SpendCount 
			WHERE	CIID = @CIID
			AND		Cnt - @SpendCount > 0;
			
			IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN  
				ROLLBACK TRAN
				SELECT -3 AS 'Ret'
				RETURN;
			END		
			
		END
		
		INSERT ItemChangeLog_CharacterItem(ChangeType, ChangeDate, CID, CIID, ItemID, [Count])
		VALUES (204, GETDATE(), @CID, @CIID, @ItemID, @SpendCount);
		
		IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN  
			ROLLBACK TRAN
			SELECT -4 AS 'Ret'
			RETURN;
		END		
		
	COMMIT TRAN ----------		
	
	SELECT 0 AS 'Ret'
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCharLevel]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ·¹º§ ¾÷µ¥ÀÌÆ® */
CREATE PROC [dbo].[spUpdateCharLevel]
  @Level        smallint,
  @CID          int
AS
SET NOCOUNT ON
UPDATE Character 
Set Level=@Level 
WHERE CID=@CID
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCharPlayTime]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Ä³¸¯ÅÍ ÇÃ·¹ÀÌ ½Ã°£ ¾÷µ¥ÀÌÆ® */
CREATE PROC [dbo].[spUpdateCharPlayTime]
  @PlayTimeInc    int,
  @CID            int
AS
SET NOCOUNT ON

UPDATE Character 
SET PlayTime=PlayTime+(@PlayTimeInc), LastTime=GETDATE() 
WHERE CID=@CID
GO
/****** Object:  StoredProcedure [dbo].[spUpdateClanGrade]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ±ÇÇÑ º¯°æ
CREATE PROC [dbo].[spUpdateClanGrade]
	@CLID		int,
	@CID		int,
	@NewGrade	tinyint
AS
	SET NOCOUNT ON
	UPDATE ClanMember SET Grade=@NewGrade WHERE CLID=@CLID AND CID=@CID
GO
/****** Object:  StoredProcedure [dbo].[spUpdateEquipItem]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spUpdateEquipItem]
-- ALTER PROC dbo.spUpdateEquipItem
	@CID		INT,
	@SlotID		INT,
	@CIID		INT,
	@ItemID		INT
AS BEGIN
 
	SET NOCOUNT ON;
  	
	IF( @CIID <> 0 ) BEGIN
	
		DECLARE @OldCIID INT;
		
		------------------------------------------------------------------
		
		IF( @SlotID = 10 ) BEGIN
		
			SELECT	@OldCIID = CIID
			FROM	CharacterEquipmentSlot(NOLOCK) 
			WHERE	CID = @CID 
			AND		CIID = @CIID
			AND		SlotID = 11;
			
			IF( @OldCIID IS NOT NULL ) BEGIN		
				SELECT -1 AS 'Ret';
				RETURN;				
			END			
		END
		ELSE IF( @SlotID = 11 ) BEGIn
		
			SELECT	@OldCIID = CIID
			FROM	CharacterEquipmentSlot(NOLOCK) 
			WHERE	CID = @CID 
			AND		CIID = @CIID
			AND		SlotID = 10;
			
			IF( @OldCIID IS NOT NULL ) BEGIN		
				SELECT -1 AS 'Ret';
				RETURN;				
			END			
		END	
		
		------------------------------------------------------------------
	END
	
	
	UPDATE  dbo.CharacterEquipmentSlot
	SET		CIID = @CIID, ItemID = @ItemID
	WHERE	CID = @CID 
	AND		SlotID = @SlotID
			
	SELECT 0 AS 'Ret';
	RETURN;
	
END

----------------------------------------------------------------------------------------------------------------------------------------
-- º¹±¸ Äõ¸®
/*
DROP PROC spUpdateEquipItem
EXEC sp_rename 'BackUp_spUpdateEquipItem', 'spUpdateEquipItem'
*/
GO
/****** Object:  StoredProcedure [dbo].[spUpdateLastConnDate]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* LastConn, IP¸¦ ÀúÀåÇÑ´Ù. */
CREATE PROC [dbo].[spUpdateLastConnDate]
	@IP		varchar(20),
	@UserID		varchar(20)
AS
SET NOCOUNT ON
UPDATE Login SET LastConnDate=GETDATE(), LastIP=@IP WHERE UserID = @UserID
GO
/****** Object:  StoredProcedure [dbo].[spUpdateLocatorStatus]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[spUpdateLocatorStatus]
 @LocatorID int
, @RecvCount int
, @SendCount int
, @BlockCount int
, @DuplicatedCount int
AS 
 SET NOCOUNT ON 
 UPDATE LocatorStatus 
 SET RecvCount = @RecvCount, SendCount = @SendCount, 
  BlockCount = @BlockCount, DuplicatedCount = @DuplicatedCount,
  LastUpdatedTime = GETDATE()
 WHERE LocatorID = @LocatorID
GO
/****** Object:  StoredProcedure [dbo].[spUpdateServerInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spUpdateServerInfo]
-- ALTER PROC dbo.spUpdateServerInfo
	@ServerID		INT,
	@ServerName		VARCHAR(24),
	@MaxPlayer		INT	
AS BEGIN
	SET NOCOUNT ON
	
  	UPDATE	ServerStatus 
  	SET		MaxPlayer = MaxPlayer, ServerName = @ServerName
  	WHERE	ServerID = @ServerID;
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateServerStatus]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ¼­¹ö µ¿Á¢ÀÚ »óÅÂ */
CREATE PROC [dbo].[spUpdateServerStatus]
  @CurrPlayer   smallint,
  @ServerID     int
AS
SET NOCOUNT ON
UPDATE ServerStatus 
Set CurrPlayer=@CurrPlayer, Time=GETDATE() 
WHERE ServerID=@ServerID
GO
/****** Object:  StoredProcedure [dbo].[spUpdateSurvivalCharacterInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spUpdateSurvivalCharacterInfo]
	@nCID			INT,
	@nSID			TINYINT,
	@nRP			INT
AS
BEGIN	
	SET NOCOUNT ON;
	
	UPDATE dbo.SurvivalCharacterInfo
	SET RP = CASE WHEN @nRP >= RP THEN @nRP ELSE RP END, RP_LatestTime = GETDATE()
	WHERE SID = @nSID AND CID = @nCID

	IF (0 = @@ROWCOUNT)
	BEGIN
		INSERT INTO dbo.SurvivalCharacterInfo(SID, CID, RP, RP_LatestTime) 
		VALUES(@nSID, @nCID, @nRP, getdate())
	END	
END
GO
/****** Object:  StoredProcedure [dbo].[spWebChangeCharName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spWebChangeCharName]
	@UserID VARCHAR(20)  
	, @OldName VARCHAR(24)  
	, @NewName VARCHAR(24)  
AS BEGIN  
	
SET NOCOUNT ON  

IF ((@UserID IS NULL) OR (@OldName IS NULL) OR (@NewName IS NULL))
	RETURN -1

-- Check Point Added By Hong(2009. 09. 02)
----------------------------------------------------
IF ( LEN(@NewName)<4 OR LEN(@NewName)>12 )
	RETURN -5

IF( DATALENGTH(@NewName)>24 )
	RETURN -6
----------------------------------------------------


DECLARE @AID int  
DECLARE @CID int  
   
SELECT @AID = c.AID, @CID = c.CID  
FROM Account a(NOLOCK), Character c(NOLOCK)  
WHERE a.UserID = @UserID 
	AND c.AID = a.AID  
	AND c.Name = @OldName 
	AND c.DeleteFlag <> 1  

IF (@CID IS NULL) OR (@AID IS NULL)  
	RETURN -2  
  
BEGIN TRAN ---------------------------------------------------  
  
UPDATE dbo.Character 
SET Name = @NewName 
WHERE CID = @CID  

IF (0 = @@ROWCOUNT) OR (0 <> @@ERROR)  
BEGIN  
	ROLLBACK TRAN  
	RETURN -3  
END  
  
INSERT INTO LogDB.dbo.ChangeCharNameLog(CID, OldName, NewName, RegDate)  
VALUES(@CID, @OldName, @NewName, GETDATE())  

IF (0 = @@ROWCOUNT) OR (0 <> @@ERROR)   
BEGIN  
	ROLLBACK TRAN  
	RETURN -4  
END  
  
COMMIT TRAN --------------------------------------------------  
  
 RETURN 0
  
END
GO
/****** Object:  StoredProcedure [dbo].[spWebChangeClanName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spWebChangeClanName]
-- ALTER PROC dbo.spWebChangeClanName
	@MasterName		VARCHAR(24)  
	, @NewClanName	VARCHAR(28)  
AS BEGIN
	
	SET NOCOUNT ON;
	
	------------------------------------------------------------------------
	
	DECLARE @CID INT;
	DECLARE @Sex TINYINT;
		
	SELECT @CID = CID, @Sex = Sex FROM dbo.Character(NOLOCK) WHERE Name = @MasterName;
	
	IF( @CID IS NULL) or ((0 <> @Sex) and (1 <> @Sex)) RETURN -1;
	
	------------------------------------------------------------------------
	
	DECLARE @CLID			INT;
	DECLARE @OldClanName	VARCHAR(28); 
	
	SELECT	@CLID = CLID, @OldClanName = Name  
	FROM	dbo.Clan(NOLOCK)
	WHERE	MasterCID = @CID AND 1 <> DeleteFlag  
	
	IF( @CLID IS NULL ) RETURN -2;
	
	------------------------------------------------------------------------
	DECLARE @NowDate		DATETIME;	
	DECLARE @ClanCoatItemID INT;
	DECLARE @OrderCIID		INT;  
    
    SET @NowDate = GETDATE();
    
    IF(0 = @Sex)		SET @ClanCoatItemID = 21011;
    ELSE IF(1 = @Sex )	SET @ClanCoatItemID = 21511;
    ELSE				RETURN -3;


		  
	BEGIN TRAN ------------

		UPDATE	dbo.Clan  
		SET		Name = @NewClanName  
		WHERE	CLID = @CLID  
		
		IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN
			ROLLBACK TRAN;
			RETURN -4;
		END
		

		INSERT dbo.CharacterItem(CID, ItemID, RegDate, RentDate, RentHourPeriod)  
		VALUES(@CID, @ClanCoatItemID, @NowDate, @NowDate, 2160 )  
		
		SET @OrderCIID = @@IDENTITY;
		
		IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN
			ROLLBACK TRAN;
			RETURN -5;
		END


		INSERT LogDB.dbo.ChangeClanNameLog(CLID, OldName, NewName, MasterCID, MasterName, RegDate)  
		VALUES(@CLID, @OldClanName, @NewClanName, @CID, @MasterName, @NowDate);
		
		IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN
			ROLLBACK TRAN;
			RETURN -6;
		END

	COMMIT TRAN ------------
  
	RETURN 1;
END
  
-------------------------------------------------------------------------------------------------------------------------
-- º¹±¸ Äõ¸®
/*
DROP PROC spWebChangeClanName
EXEC sp_rename 'BackUp_spWebChangeClanName', 'spWebChangeClanName';
*/
GO
/****** Object:  StoredProcedure [dbo].[spWebChangeClanName_Netmarble]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spWebChangeClanName_Netmarble]  
-- ALTER PROC dbo.spWebChangeClanName_Netmarble
	@MasterName		VARCHAR(24)  
	, @NewClanName	VARCHAR(28)  
AS BEGIN
	
	SET NOCOUNT ON;
	
	------------------------------------------------------------------------
	
	DECLARE @CID INT;
	DECLARE @Sex TINYINT;
		
	SELECT @CID = CID, @Sex = Sex FROM dbo.Character(NOLOCK) WHERE Name = @MasterName;
	
	IF( @CID IS NULL) or ((0 <> @Sex) and (1 <> @Sex)) RETURN -1;
	
	------------------------------------------------------------------------
	
	DECLARE @CLID			INT;
	DECLARE @OldClanName	VARCHAR(28); 
	
	SELECT	@CLID = CLID, @OldClanName = Name  
	FROM	dbo.Clan(NOLOCK)
	WHERE	MasterCID = @CID AND 1 <> DeleteFlag  
	
	IF( @CLID IS NULL ) RETURN -2;
	
	------------------------------------------------------------------------
	DECLARE @NowDate		DATETIME;	
	DECLARE @ClanCoatItemID INT;
	DECLARE @OrderCIID		INT;  
    
    SET @NowDate = GETDATE();
    
    IF(0 = @Sex)		SET @ClanCoatItemID = 21011;
    ELSE IF(1 = @Sex )	SET @ClanCoatItemID = 21511;
    ELSE				RETURN -3;


		  
	BEGIN TRAN ------------

		UPDATE	dbo.Clan  
		SET		Name = @NewClanName  
		WHERE	CLID = @CLID  
		
		IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN
			ROLLBACK TRAN;
			RETURN -4;
		END
		

		INSERT dbo.CharacterItem(CID, ItemID, RegDate, RentDate, RentHourPeriod)  
		VALUES(@CID, @ClanCoatItemID, @NowDate, @NowDate, 2160 )  
		
		SET @OrderCIID = @@IDENTITY;
		
		IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN
			ROLLBACK TRAN;
			RETURN -5;
		END


		INSERT LogDB.dbo.ChangeClanNameLog(CLID, OldName, NewName, MasterCID, MasterName, RegDate)  
		VALUES(@CLID, @OldClanName, @NewClanName, @CID, @MasterName, @NowDate);
		
		IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN
			ROLLBACK TRAN;
			RETURN -6;
		END

	COMMIT TRAN ------------
  
	RETURN 1;
END
  
-------------------------------------------------------------------------------------------------------------------------
-- º¹±¸ Äõ¸®
/*
DROP PROC spWebChangeClanName_Netmarble
EXEC sp_rename 'BackUp_spWebChangeClanName_Netmarble', 'spWebChangeClanName_Netmarble';
*/
GO
/****** Object:  StoredProcedure [dbo].[spWebCheckRegisteredUser]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-------------------------------------------------------------------

CREATE   PROC [dbo].[spWebCheckRegisteredUser]  
 @UserID VARCHAR(20),  
 @Ret int Output  
AS  
 SET NOCOUNT ON  
 DECLARE @AID INT  
 SELECT @AID = AID FROM Account(NOLOCK) WHERE UserID = @UserID  
 IF @@ERROR <> 0 BEGIN  
  SET @Ret = 0  
  RETURN @Ret -- µðºñÀå¾Ö  
 END  
  
 IF @AID IS NULL BEGIN  
  SET @Ret = -1  
  RETURN @Ret  -- ¹Ì°¡ÀÔÀÚ  
 END  
   
 SET @Ret = 1   
 RETURN @Ret -- °¡ÀÔÀÚ È®ÀÎ
GO
/****** Object:  StoredProcedure [dbo].[spWebDeleteClan]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- À¥¿¡¼­ Å¬·£ Æó¼â.
CREATE PROC [dbo].[spWebDeleteClan]
	@MasterName varchar(24)	/* ¸¶½ºÅÍ ÀÌ¸§ */
,	@ClanName varchar(24)	/* ¹æÃâÇÒ Å¬·£¿ø ÀÌ¸§ */
AS
SET NOCOUNT ON
BEGIN TRAN
	SET NOCOUNT ON

	DECLARE @MasterCID int
	DECLARE @CLID int

	SELECT @MasterCID = c.MasterCID, @CLID = c.CLID
	FROM Clan c (NOLOCK), Character ch(NOLOCK)
	WHERE ch.Name = @MasterName AND c.MasterCID = ch.CID

	-- ¿äÃ» Á¶°Ç °Ë»ç.
	IF (@MasterCID IS NULL) OR (@CLID IS NULL)
	BEGIN
		SELECT 0 AS Ret
		ROLLBACK TRAN
		SET NOCOUNT OFF
		RETURN
	END

	-- Clan Member »èÁ¦.
	DELETE ClanMember WHERE CLID = @CLID
	IF 0  <> @@ERROR
	BEGIN
		SELECT 0 AS Ret
		ROLLBACK TRAN
		SET NOCOUNT OFF
		RETURN
	END

	-- ClanÀ» À¯È¿ÇÏÁö ¾ÊÀº »óÅÂ·Î ¼³Á¤.
	UPDATE Clan SET DeleteFlag = 1, MasterCID = NULL, DeleteName = Name WHERE CLID = @CLID
	IF 0 = @@ROWCOUNT BEGIN 
		SELECT 0 AS Ret
		ROLLBACK TRAN
		SET NOCOUNT OFF
		RETURN
	END

	UPDATE Clan SET Name = NULL WHERE CLID = @CLID
	IF 0 = @@ROWCOUNT BEGIN 
		SELECT 0 AS Ret
		ROLLBACK TRAN
		SET NOCOUNT OFF
		RETURN
	END

	SELECT 1 AS Ret

	SET NOCOUNT OFF
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[spWebDeleteClanByCID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- CID·Î Å¬·£ Æó¼â.
CREATE  PROC [dbo].[spWebDeleteClanByCID]
	@MasterCID int /* ¸¶½ºÅÍ CID */
AS
SET NOCOUNT ON
BEGIN TRAN

	DECLARE @CLID int

	SELECT @CLID = c.CLID
	FROM Clan c(NOLOCK)
	WHERE c.MasterCID = @MasterCID

	-- ¿äÃ» Á¶°Ç °Ë»ç.
	IF (@MasterCID IS NULL) OR (@CLID IS NULL)
	BEGIN
		SELECT 0 AS Ret
		ROLLBACK TRAN
--		SET NOCOUNT OFF
		Select 0
		RETURN
	END

	-- Clan Member »èÁ¦.
	DELETE ClanMember WHERE CLID = @CLID
	IF 0  <> @@ERROR
	BEGIN
		SELECT 0 AS Ret
		ROLLBACK TRAN
--		SET NOCOUNT OFF
		Select 0
		RETURN
	END

	-- ClanÀ» À¯È¿ÇÏÁö ¾ÊÀº »óÅÂ·Î ¼³Á¤.
	UPDATE Clan SET DeleteFlag = 1, MasterCID = NULL, DeleteName = Name WHERE CLID = @CLID
	-- UPDATE Clan SET DeleteName = Name WHERE CLID = @CLID
	IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN -- ¿©±â Ãß°¡.
		SELECT 0 AS Ret
		ROLLBACK TRAN
		Select 0
		RETURN
	END
	UPDATE Clan SET Name = NULL WHERE CLID = @CLID
	IF (0 <> @@ERROR) OR (0 = @@ROWCOUNT) BEGIN -- ¿©±â Ãß°¡.
		SELECT 0 AS Ret
		ROLLBACK TRAN
		Select 0
		RETURN
	END

	SELECT 1

	
COMMIT TRAN
SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[spWebDTGetDTRankingTOP100]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spWebDTGetDTRankingTOP100]
-- ALTER PROC dbo.spWebDTGetDTRankingTOP100
	@TimeStamp	CHAR(8),
	@PageNum	INT
AS BEGIN

	DECLARE @PagePerNum INT;
	SET @PagePerNum = 20;
		
	SELECT  rh.Rank, rh.Name, ci.TP, ci.Wins, ci.Loses, ci.FinalWins, rh.Grade
	FROM    DTCharacterRankingHistory rh 
            JOIN DTCharacterInfo ci
            ON rh.CID = ci.CID
	WHERE   ci.TimeStamp = @TimeStamp
    AND     rh.TimeStamp = @TimeStamp
    AND     rh.Rank BETWEEN (@PagePerNum * (@PageNum - 1) + 1) AND (@PagePerNum * (@PageNum))
    ORDER BY rh.Rank

END
GO
/****** Object:  StoredProcedure [dbo].[spWebDTGetDTTimeStamp]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spWebDTGetDTTimeStamp]
AS BEGIN
	SELECT dt.TimeStamp
	FROM DTTimeStamp dt(NOLOCK)
	WHERE dt.Closed = 1
	ORDER BY dt.TimeStamp
END
GO
/****** Object:  StoredProcedure [dbo].[spWebFireClanMember]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ¸¶½ºÅÍ°¡ Å¬·£¿ø ¹æÃâ.
CREATE PROC [dbo].[spWebFireClanMember]
	@Master varchar(24) 	/* Å¬·£ ¸¶½ºÅÍ CID */
,	@ClanMem varchar(24) 	/* ¹æÃâÇÒ Å¬·£¿ø Ä³¸¯ÅÍ CID */
AS
SET NOCOUNT ON
BEGIN TRAN
	DECLARE @MasterCID int
	DECLARE @CLID int
	DECLARE @ClanMemCID int

	-- ÀÚ°Ý °Ë»ç¸¦ À§ÇØ Å¬·£¾ÆÀÌµð¿Í ¸¶½ºÅÍ ¾ÆÀÌÆ¼¸¦ ±¸ÇÔ.
	SELECT @CLID = cl.CLID, @MasterCID = cl.MasterCID
	FROM Character ch(NOLOCK), Clan cl(NOLOCK)
	WHERE ch.Name = @Master AND cl.MasterCID = ch.CID

	-- ¹æÃæÇÏ·Á´Â Å¬·£ ¸É¹ö.
	SELECT @ClanMemCID = ch.CID
	FROM Character ch(NOLOCK)
	WHERE ch.Name = @ClanMem

	-- Å¬·£ÀÌ Á¸ÀçÇÏ°í Å¬·£¸É¹ö°¡ Á¸ÀçÇØ¾ß ÇÏ°í ¹æÃâµÇ´Â ¸É¹ö°¡ ¸¶½ºÅÍ°¡ ¾Æ´Ï¾î¾ß ÇÔ.
	IF (@CLID IS NULL) OR (@ClanMemCID IS NULL) OR (@MasterCID = @ClanMemCID)
	BEGIN
		ROLLBACK TRAN
		SELECT 0
		RETURN
	END

	DELETE ClanMember 
	WHERE CLID = @CLID AND 	CID = @ClanMemCID
	IF 0 <> @@ERROR
	BEGIN
		ROLLBACK TRAN
		SELECT 0
		RETURN
	END

	SELECT 1
COMMIT TRAN
SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[spWebGetAccountMaxLevel]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spWebGetAccountMaxLevel]
	@UserID varchar(20)
AS
BEGIN
	SET NOCOUNT ON
	SELECT MAX(c.Level) FROM Account a(NOLOCK), Character c(NOLOCK)
	WHERE a.UserID=@UserID AND a.AID=c.AID AND c.DeleteFlag=0
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetActiveCharacterList_NHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spWebGetActiveCharacterList_NHN]
	@AID		INT
AS BEGIN
	SET NOCOUNT ON;	
	
	SELECT	c.AID, c.CID, c.Name, c.CharNum
	FROM	Character c(NOLOCK)
	WHERE	c.AID = @AID AND c.DeleteFlag = 0
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetCashItemImageFile]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ÀÌ¹ÌÁö ÆÄÀÏ ÀÌ¸§°ú ¾ÆÀÌÅÛ ÀÌ¸§À» °¡Á®¿È.
CREATE PROC [dbo].[spWebGetCashItemImageFile]
	@CSID int
,	@RetImageFileName varchar(64) OUT
,	@RetItemName varchar(256) OUT
AS
BEGIN
	SET NOCOUNT ON
	SELECT @RetImageFileName = cs.WebImgName, @RetItemName = i.Name
	FROM CashShop cs(NOLOCK), Item i(NOLOCK)
	WHERE cs.CSID = @CSID AND i.ItemID = cs.ItemID

	RETURN 1
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetCashSetItemImageFile]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Ä³½¬ ¼¼Æ®¾ÆÀÌÅÛ ÀÌ¹ÌÁöÆÄÀÏ°ú ¾ÆÀÌÅÛ ÀÌ¸§ ¾Ë¾Æ¿À±â.
CREATE PROC [dbo].[spWebGetCashSetItemImageFile]
 	@CSSID   int  
, 	@RetImageFileName varchar(64) OUTPUT  
,	@RetSetItemName varchar(64) OUTPUT
AS  
SET NOCOUNT ON
BEGIN
	SELECT @RetImageFileName = css.WebImgName, @RetSetItemName = css.Name
	FROM CashSetShop css(NOLOCK)
	WHERE css.CSSID=@CSSID  
  
	RETURN 1  
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetCharClan]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--------------------------------------------------------------------------------------

 -- Å¬·£ÀÌ¸§ ¾Ë¾Æ¿À±â  
CREATE PROC [dbo].[spWebGetCharClan]  -- ¼­¹ö¿¡¼­ spGetCharClanÀ¸·Î »ç¿ë.
 @CID   int  
AS  
 SET NOCOUNT ON
 SELECT cl.CLID AS CLID, cl.Name AS ClanName FROM ClanMember cm(nolock), Clan cl(nolock) WHERE cm.cid=@CID AND cm.CLID=cl.CLID
GO
/****** Object:  StoredProcedure [dbo].[spWebGetCharNameListByUserID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------


CREATE PROC [dbo].[spWebGetCharNameListByUserID]
 @UserID VARCHAR(20)
AS
BEGIN
 SET NOCOUNT ON 

 DECLARE @aid INT;
 SELECT @aid = aid 
 FROM dbo.account(nolock) 
 WHERE userid = @userid
 
 IF (@aid is null)
  RETURN -1

 SELECT NAME 
 FROM dbo.Character(NOLOCK) 
 WHERE AID = @aid AND DeleteFlag <> 1
 ORDER BY cid

 RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetClanAdsBoardList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[spWebGetClanAdsBoardList]  
AS  
 SET NOCOUNT ON  
 SELECT Seq, Userid, Subject, RegDate, ReadCount, Recommend, CommentCount  
 FROM ClanAdsBoard(NOLOCK)  
 ORDER BY Thread DESC
GO
/****** Object:  StoredProcedure [dbo].[spWebGetClanHonorRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
----------------------------------------------------------------------------------------

/* Å¬·£ ¸í¿¹ÀÇ Àü´ç º¸±â ¿ùº° 10À§±îÁö   
 2004³â 9¿ù ~ ÇöÀçÀú¹ø´Þ±îÁö(ÀÌ´Þ Á¦¿Ü) */  
CREATE PROC [dbo].[spWebGetClanHonorRanking]  
 @Year INT,  
 @Month INT  
AS  
SET NOCOUNT ON
BEGIN  
 SELECT TOP 10 r.Ranking, r.ClanName, r.Point, r.Wins, r.Losses, r.CLID, c.EmblemUrl   
 FROM ClanHonorRanking r(NOLOCK), Clan c(NOLOCK)  
 WHERE r.CLID=c.CLID AND Year = @Year AND Month = @Month  
 ORDER BY r.Ranking  
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetClanList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------------------

/* Å¬·£ ¸ñ·Ï º¸±â   
    ÇÑÆäÀÌÁö 15°³¾¿ °íÁ¤, ÃÖ´ë ÆäÀÌÁö ¼ö¸¦ À§ÇØ COUNT(*) ¾Ë¾Æ³»Áö ¸»°Í.(ÀÌÀü,´ÙÀ½ ÆäÀÌÁö·Î ÇØ°á)   
    Arg1 : @Page (ÆäÀÌÁö³Ñ¹ö)  
    Arg2 : @Backward (»ý·«ÇÏ¸é Á¤»ó¼ø¼­, 1ÀÏ°æ¿ì ¿ª¼ø      */  
CREATE PROC [dbo].[spWebGetClanList]  
 @Page INT,  
 @Backward INT  = 0  
AS  
SET NOCOUNT ON
BEGIN  
 DECLARE @PageHead INT  
 DECLARE @RowCount INT  
  
 IF @Backward = 0  
 BEGIN  
  SELECT @RowCount = ((@Page -1) * 15 + 1)  
    
  SET ROWCOUNT @RowCount  
  SELECT @PageHead = CLID FROM Clan(NOLOCK) WHERE DeleteFlag=0 ORDER BY CLID DESC  
    
  SET ROWCOUNT 15  
  SELECT cl.CLID AS CLID, cl.Name as ClanName, c.Name AS Master, cl.RegDate AS RegDate, cl.EmblemUrl AS EmblemUrl, cl.Point AS Point  
  FROM Clan cl(NOLOCK), Character c(nolock)  
  WHERE cl.MasterCID=c.CID AND cl.DeleteFlag=0 AND cl.CLID<=@PageHead   
  ORDER BY cl.CLID DESC  
 END  
 ELSE  
 BEGIN -- ¿ª¼ø  
  SELECT @RowCount = ((@Page -1) * 15 + 1)  
    
  SET ROWCOUNT @RowCount  
  SELECT @PageHead = CLID FROM Clan(NOLOCK) WHERE DeleteFlag=0 ORDER BY CLID  
    
  SET ROWCOUNT 15  
  SELECT CLID, ClanName, Master, RegDate, EmblemUrl, Point  
  FROM  
  (  
   SELECT TOP 15 cl.CLID AS CLID, cl.Name as ClanName, c.Name AS Master, cl.RegDate AS RegDate, cl.EmblemUrl AS EmblemUrl, cl.Point AS Point  
   FROM Clan cl(NOLOCK), Character c(nolock)  
   WHERE cl.MasterCID=c.CID AND cl.DeleteFlag=0 AND cl.CLID>=@PageHead ORDER BY cl.CLID  
  ) AS t  
  ORDER BY CLID DESC  
 END  
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetClanListSearchByMaster]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Å¬·£ ¸ñ·ÏÃ£±â (¸¶½ºÅÍÀÌ¸§À¸·Î)  
    Arg1 : @CharName (Å¬·£ ¸¶½ºÅÍ ÀÌ¸§) */  
CREATE PROC [dbo].[spWebGetClanListSearchByMaster]  
 	@CharName VARCHAR(24)  
AS  
SET NOCOUNT ON
BEGIN  
  	SELECT TOP 1 cl.Ranking, cl.RankIncrease, cl.Name as ClanName, cl.Point, cl.Wins, cl.Losses, cl.CLID, cl.EmblemUrl, c.Name AS Master, cl.RegDate
	FROM Clan cl(NOLOCK), Character c(nolock)  
  	WHERE c.Name = @CharName AND cl.DeleteFlag = 0 AND cl.MasterCID = c.CID
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetClanListSearchByName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
---------------------------------------------------------------------------------------

/* Å¬·£ ¸ñ·ÏÃ£±â (ÀÌ¸§À¸·Î)  
    Arg1 : @Name (Å¬·£ÀÌ¸§) */  
CREATE PROC [dbo].[spWebGetClanListSearchByName]
 @Name VARCHAR(24)  
AS  
SET NOCOUNT ON
BEGIN  
 SELECT TOP 20 cl.CLID AS CLID, cl.Name as ClanName, c.Name AS Master, cl.RegDate AS RegDate, cl.EmblemUrl AS EmblemUrl, cl.Point AS Point  
 FROM Clan cl(NOLOCK), Character c(NOLOCK)  
 WHERE cl.MasterCID=c.CID AND c.DeleteFlag=0 AND cl.Name=@Name   
 ORDER BY cl.CLID  
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetClanMember]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
----------------------------------------------------------------------------------------

   -- Å¬·£¿ø ¾Ë¾Æ¿À±â  
CREATE PROC [dbo].[spWebGetClanMember]  
 @CLID  int  
AS  
 SET NOCOUNT ON
 SELECT cm.clid AS CLID, cm.Grade AS ClanGrade, c.cid AS CID, c.name AS CharName  
 FROM ClanMember cm(nolock), Character c(nolock)  
 WHERE CLID=@CLID AND cm.cid=c.cid
GO
/****** Object:  StoredProcedure [dbo].[spWebGetClanRankByMaster]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Å¬·£ ·©Å·À» ¸¶½ºÅÍ ÀÌ¸§À» »ç¿ëÇØ¼­ °Ë»ö.
CREATE PROC [dbo].[spWebGetClanRankByMaster]
	@MasterName varchar(24)
AS
SET NOCOUNT ON
BEGIN
	SELECT cl.CLID, cl.Name AS ClanName, cl.Point, cl.Wins, cl.Losses, cl.EmblemUrl, cl.Ranking, cl.RankIncrease, c.Name AS Master, cl.RegDate
	FROM Clan cl(NOLOCK) JOIN Character c(NOLOCK) 
	ON c.Name = @MasterName AND cl.MasterCID = c.CID AND cl.Ranking > 0
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetClanRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- MasterÀÌ¸§°ú RegDateÃß°¡.
/* Å¬·£ ·©Å·º¸±â : ÇÑÆäÀÌÁö 20°³¾¿ °íÁ¤  
    Arg1 : @Page (ÆäÀÌÁö³Ñ¹ö)  
    Arg2 : @Backward (»ý·«ÇÏ¸é Á¤»ó¼ø¼­, 1ÀÏ°æ¿ì ¿ª¼ø */  
CREATE PROC [dbo].[spWebGetClanRanking]  
 @Page INT,  
 @Backward INT  = 0  
AS  
SET NOCOUNT ON
BEGIN  
 /* ÇÑÆäÀÌÁö¿¡ 20°³¾¿ º¸¿©ÁØ´Ù (¼Óµµ¸¦À§ÇØ °¹¼ö °íÁ¤) */  
 DECLARE @RowCount INT  
 DECLARE @PageHead INT  
  
 IF @Backward = 0  
 BEGIN  
  SELECT @RowCount = ((@Page -1) * 20 + 1)  
  SELECT TOP 20 cl.Ranking, cl.RankIncrease, cl.Name as ClanName, cl.Point, cl.Wins, cl.Losses, cl.CLID, cl.EmblemUrl, ch.Name AS Master, cl.RegDate
  FROM Clan cl(NOLOCK), Character ch(NOLOCK)
  WHERE cl.DeleteFlag=0 AND cl.Ranking>0 AND cl.Ranking >= @RowCount  AND ch.CID = cl.MasterCID
  ORDER BY cl.Ranking  
 END  
 ELSE  
 BEGIN  
  SELECT @RowCount = ((@Page -1) * 20 + 1)  
   
  SET ROWCOUNT @RowCount  
  SELECT @PageHead = Ranking FROM Clan(NOLOCK) WHERE DeleteFlag=0 ORDER BY Ranking DESC  
   
  SET ROWCOUNT 20  
  SELECT Ranking, RankIncrease, ClanName, Point, Wins, Losses, CLID, EmblemUrl, Master, RegDate FROM  
  (  
   SELECT TOP 20 cl.Ranking, cl.RankIncrease, cl.Name as ClanName, cl.Point, cl.Wins, cl.Losses, cl.CLID, cl.EmblemUrl, ch.Name AS Master, cl.RegDate
   FROM Clan cl(NOLOCK), Character ch(NOLOCK)
   WHERE cl.DeleteFlag=0 AND cl.Ranking>0 AND cl.Ranking <= @PageHead AND ch.CID = cl.MasterCID
   ORDER BY cl.Ranking DESC  
  ) AS t ORDER BY Ranking  
 END  
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetClanRankingHistory]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
----------------------------------------------------------------------------------------

/* Å¬·£ ¿ª´ë ·©Å·Ã£±â  
    Arg1 : @Year (³âµµ)   
    Arg2 : @Month (¿ù)   
    Arg3 : @Page (ÆäÀÌÁö)   
    Arg4 : @Backward (¿ª¼ø) */  
CREATE  PROC [dbo].[spWebGetClanRankingHistory]  
 @Year INT,  
 @Month INT,  
 @Page INT,  
 @Backward INT = 0  
AS  
SET NOCOUNT ON
BEGIN  
 /* ÇÑÆäÀÌÁö¿¡ 20°³¾¿ º¸¿©ÁØ´Ù (¼Óµµ¸¦À§ÇØ °¹¼ö °íÁ¤) */  
 DECLARE @RowCount INT  
 DECLARE @PageHead INT  
  
 IF @Backward = 0  
 BEGIN  
  SELECT @RowCount = ((@Page -1) * 20 + 1)  
  SELECT TOP 20 Ranking, ClanName as ClanName, Point, Wins, Losses, CLID FROM ClanHonorRanking(NOLOCK)   
  WHERE Year=@Year AND Month=@Month AND Ranking>0 AND Ranking >= @RowCount ORDER BY Ranking  
 END  
 ELSE  
 BEGIN  
  SELECT @RowCount = ((@Page -1) * 20 + 1)  
   
  SET ROWCOUNT @RowCount  
  SELECT @PageHead = Ranking FROM Clan(NOLOCK) WHERE DeleteFlag=0 ORDER BY Ranking DESC  
   
  SET ROWCOUNT 20  
  SELECT  Ranking, RankIncrease=0, ClanName, Point, Wins, Losses, CLID, EmblemUrl=NULL FROM  
  (  
   SELECT TOP 20 Ranking, ClanName, Point, Wins, Losses, CLID FROM ClanHonorRanking(NOLOCK)   
   WHERE Year=@Year AND Month=@Month AND Ranking>0 AND Ranking <= @PageHead ORDER BY Ranking DESC  
  ) AS t ORDER BY Ranking  
 END  
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetClanRankingMaxPage]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
----------------------------------------------------------------------------------------

CREATE PROC [dbo].[spWebGetClanRankingMaxPage]  
AS  
SET NOCOUNT ON
BEGIN  
 DECLARE @MaxPage INT  
 SELECT TOP 1 @MaxPage = Ranking / 20 + 1 FROM Clan(NOLOCK) WHERE DeleteFlag=0 AND Ranking>0 ORDER BY Ranking DESC  
-- SELECT @MaxPage  
 RETURN @MaxPage  
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetClanRankingSearchByName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Å¬·£ ÀÌ¸§À¸·Î °Ë»ö.
CREATE PROC [dbo].[spWebGetClanRankingSearchByName]  
 	@Name VARCHAR(24)  /* Å¬·£ ÀÌ¸§ */
AS  
SET NOCOUNT ON
BEGIN  
 	SELECT TOP 1 cl.Ranking, cl.RankIncrease, cl.Name as ClanName, cl.Point, cl.Wins, cl.Losses, cl.CLID, cl.EmblemUrl, ch.Name AS Master, cl.RegDate
	FROM Clan cl(NOLOCK), Character ch(NOLOCK)
 	WHERE ch.CID = cl.MasterCID AND cl.Ranking>0 AND cl.DeleteFlag=0 AND cl.Name=@Name
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetClanRankingSearchByRanking]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
----------------------------------------------------------------------------------------

/* Å¬·£ ·©Å·Ã£±â (¼øÀ§·Î)  
    Arg1 : @Ranking (¼øÀ§) */  
CREATE PROC [dbo].[spWebGetClanRankingSearchByRanking]  
 @Ranking INT  
AS  
SET NOCOUNT ON
BEGIN  
 SELECT TOP 20 Ranking, RankIncrease, Name as ClanName, Point, Wins, Losses, CLID, EmblemUrl FROM Clan(NOLOCK)   
 WHERE DeleteFlag=0 AND Ranking>0 AND Ranking=@Ranking ORDER BY Ranking  
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetMyClanInfo]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- My·©Å·Á¤º¸.
CREATE PROC [dbo].[spWebGetMyClanInfo]
	@CharName varchar(24) /* Ä³¸¯ÅÍ ÀÌ¸§ */
AS
SET NOCOUNT ON
BEGIN
	DECLARE @CLID int

	SELECT @CLID = cm.CLID 
	FROM Account a (NOLOCK), Character c (NOLOCK), ClanMember cm (NOLOCK)
	WHERE c.Name = @CharName AND a.AID = c.AID AND cm.CID = c.CID

	IF @CLID IS NOT NULL
	BEGIN
		SELECT cl.Name, ch.Name AS Master, cl.IntroDuction, cl.RegDate, cl.Homepage, cl.EmblemUrl, cl.Ranking
		FROM Clan cl(NOLOCK), Character ch(NOLOCK)
		WHERE cl.CLID = @CLID AND cl.DeleteFlag = 0 AND ch.CID = cl.MasterCID
	END
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetMyClanInfoByCID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- My·©Å·Á¤º¸¸¦ CID·Î °¡Á®¿È.  
CREATE PROC [dbo].[spWebGetMyClanInfoByCID]  
 	@CID int /* Ä³¸¯ÅÍ CID */  
AS  
SET NOCOUNT ON
BEGIN  
	SELECT t.Name, t.Name AS Master, t.IntroDuction, t.RegDate, t.Homepage, t.EmblemUrl, t.Ranking
	FROM 
	(
	 	SELECT cl.Name, cl.MasterCID, cl.IntroDuction, cl.RegDate, cl.Homepage, cl.EmblemUrl, cl.Ranking
	 	FROM ClanMember cm(NOLOCK), Clan cl(NOLOCK), Character ch(NOLOCK)  
	 	WHERE cm.CID = @CID AND cl.CLID = cm.CLID AND ch.CID = @CID  
	) AS t, Character ch(NOLOCK)
	WHERE t.MasterCID = ch.CID
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetMyClanInfoByCLID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spWebGetMyClanInfoByCLID]
	@CLID int
AS
SET NOCOUNT ON
BEGIN
	SELECT cl.Name, ch.Name AS Master, cl.IntroDuction, cl.RegDate, cl.Homepage, cl.EmblemUrl, cl.Ranking
	FROM Clan cl(NOLOCK), Character ch(NOLOCK)
	WHERE cl.CLID = @CLID AND cl.DeleteFlag = 0 AND ch.CID = cl.MasterCID
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetMyClanList]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- °¡ÀÔÇÑ Å¬·£ ¸®½ºÆ®¸¦ RankingÀ¸·Î Á¤·ÄÇØ¼­ º¸¿©ÁÜ. Å¬·£ÀÌ Áßº¹À¸·Î º¸ÀÏ¼ö ÀÖÀ½.
CREATE PROC [dbo].[spWebGetMyClanList]
	@UserID varchar(20) /* ³Ý¸¶ºí ¾ÆÀÌµð */
AS
SET NOCOUNT ON
BEGIN
	SELECT t.Ranking, t.RankIncrease, t.ClanName, t.Point, t.Wins, t.Losses, t.CLID, t.EmblemUrl, ch.Name AS Master, t.RegDate
	FROM 
	(
		SELECT cl.CLID, cl.Name AS ClanName, cl.Point, cl.Wins, cl.Losses, cl.EmblemUrl, cl.Ranking, cl.RankIncrease, cl.MasterCID, cl.RegDate
		FROM Account ac (NOLOCK), Character ch(NOLOCK), ClanMember cm(NOLOCK), Clan cl(NOLOCK)
		WHERE ac.UserID = @UserID AND ac.AID = ch.AID AND cm.CID = ch.CID AND cl.CLID = cm.CLID
	) AS t, Character ch(NOLOCK)
	WHERE t.MasterCID = ch.CID ORDER BY t.Ranking DESC
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetSleepCharacter_NHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spWebGetSleepCharacter_NHN]
	@CID		INT
AS BEGIN
	SET NOCOUNT ON;	
	
	SELECT	t.AID
		  , t.CID
		  , t.Name
		  , -1 AS CharNum
		  , CASE WHEN EXISTS (SELECT Name FROM Character(NOLOCK) WHERE Name = t.Name) 
				 THEN 0 
				 ELSE 1 
			END AS NameUsed
	FROM	SleepCharacterNHN t(NOLOCK)
	WHERE	t.CID = @CID
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetSleepCharacterList_NHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spWebGetSleepCharacterList_NHN]
	@AID		INT
AS BEGIN
	SET NOCOUNT ON;	
	
	SELECT	t.AID
		  , t.CID
		  , t.Name
		  , -1 AS CharNum
		  , CASE WHEN EXISTS (SELECT Name FROM Character(NOLOCK) WHERE Name = t.Name) 
				 THEN 0 
				 ELSE 1 
			END AS NameUsed
	FROM	SleepCharacterNHN t(NOLOCK)
	WHERE	t.AID = @AID
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetSurvivalRankingByAccount]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spWebGetSurvivalRankingByAccount]
	@SID		TINYINT
	, @AName	VARCHAR(64)
AS 
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @AID INT;
	SELECT @AID = AID FROM dbo.Account WITH (NOLOCK) WHERE UserID = @AName;
		
	SELECT r.Ranking AS Ranking		
		, t.Name AS CharacName
		, @AName AS UserID
		, t.Level AS Level
		, r.RP AS RankingPoint
	FROM
	(
		SELECT c.Name, c.Level, s.RankRP
		FROM dbo.Character c WITH (NOLOCK) 
			, dbo.SurvivalCharacterInfo s WITH (NOLOCK)
		WHERE AID = @AID
			AND s.CID = c.CID
			AND s.SID = @SID
	) t, dbo.SurvivalRanking r WITH (NOLOCK)
	WHERE r.SID = @SID
		AND r.RP = t.RankRP
	ORDER BY Ranking
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetSurvivalRankingByCharacter]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spWebGetSurvivalRankingByCharacter]
	@SID		TINYINT
	, @CName	VARCHAR(24)
AS 
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @CID INT;
	DECLARE @AID INT;
	DECLARE @Level INT;
	
	SELECT @AID = AID, @CID = CID, @Level = Level FROM dbo.Character WHERE Name = @CName;
		
	SELECT r.Ranking AS Ranking
		, @CName AS CharacName
		, (SELECT UserID FROM Account WHERE AID = @AID) AS UserID
		, @Level AS Level
		, s.RP AS RankingPoint
	FROM dbo.SurvivalCharacterInfo s WITH (NOLOCK)
		, dbo.SurvivalRanking r WITH (NOLOCK)
	WHERE s.SID = @SID
		AND s.CID = @CID
		AND r.SID = s.SID
		AND r.RP = s.RankRP
	ORDER BY s.SID
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetSurvivalRankingByPageNumber]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spWebGetSurvivalRankingByPageNumber]
	@SID TINYINT
	, @PageNum INT
	, @PagePerCount	INT
AS BEGIN
	SET NOCOUNT ON;
	
	DECLARE @StartRow	INT;
	DECLARE @EndRow		INT;
	
	SELECT TOP 1 @StartRow = RowNum FROM dbo.SurvivalCharacterInfoWeb WHERE SID = @SID
	SET @StartRow = @StartRow + ((@PageNum - 1) * @PagePerCount)
	SET @EndRow = @StartRow + @PagePerCount - 1;

	SELECT r.Ranking AS Ranking
		, c.Name AS CharacName
		, a.UserID AS UserID
		, c.Level AS Level
		, t.RankRP AS RankingPoint
	FROM 
	(
		SELECT ci.RowNum, ci.SID, ci.CID, i.RankRP
		FROM dbo.SurvivalCharacterInfoWeb ci WITH (NOLOCK)
			, dbo.SurvivalCharacterInfo i WITH (NOLOCK)
		WHERE ci.RowNum BETWEEN @StartRow AND @EndRow
			AND ci.SID = @SID
			AND	ci.SID = i.SID
			AND ci.CID = i.CID			
	) t	
		, dbo.Character c WITH (NOLOCK)
		, dbo.SurvivalRanking r WITH (NOLOCK)
		, dbo.Account a WITH (NOLOCK)
	WHERE c.CID = t.CID
		AND a.AID = c.AID
		AND r.SID = t.SID	
		AND r.RP = t.RankRP
	ORDER BY Ranking ASC
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetSurvivalRankingTopBySID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spWebGetSurvivalRankingTopBySID]
	@SID		TINYINT
	, @Count	INT
AS BEGIN
	SET NOCOUNT ON;
	
	DECLARE @StartRow INT;	
	SELECT TOP 1 @StartRow = RowNum FROM dbo.SurvivalCharacterInfoWeb WHERE SID = @SID
	
	SELECT c.Name AS CharacName
		, t.RankRP AS RankingPoint
	FROM 
	(
		SELECT ci.RowNum, ci.SID, ci.CID, i.RankRP
		FROM dbo.SurvivalCharacterInfoWeb ci WITH (NOLOCK)
			, dbo.SurvivalCharacterInfo i WITH (NOLOCK)
		WHERE ci.RowNum BETWEEN @StartRow AND (@StartRow + @Count - 1)
			AND ci.SID = @SID
			AND	i.SID = @SID
			AND ci.CID = i.CID			
	) t
	, dbo.Character c WITH (NOLOCK)
	WHERE t.CID = c.CID
	ORDER BY RankingPoint DESC
END
GO
/****** Object:  StoredProcedure [dbo].[spWebGetSurvivalScenario]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spWebGetSurvivalScenario]
AS BEGIN
	SET NOCOUNT ON;
	
	SELECT SID, SName
	FROM SurvivalScenarioID WITH (NOLOCK)	
END
GO
/****** Object:  StoredProcedure [dbo].[spWebInsertAccount]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-------------------------------------------------------------------

 CREATE    PROC [dbo].[spWebInsertAccount]   
 @UserID varchar(20)  
, @Password varchar(20)  
, @Cert tinyint  
, @Name varchar(30)  
, @Age smallint  
, @Country char(3)  
, @Sex tinyint  
, @Email varchar(50)=NULL  
, @Ret int OutPut  
AS  
 SET NOCOUNT ON  
 DECLARE @AIDIdent int  
  
 BEGIN TRAN  
 INSERT INTO Account (UserID, Cert, Name, Age, Sex, UGradeID, PGradeID, RegDate, Email,  Country)  
 VALUES (@UserID, @Cert, @Name, @Age, @Sex, 0, 0, GETDATE(), @Email,  @Country)  
 IF @@ERROR <> 0 BEGIN  
  ROLLBACK TRAN  
  SET @Ret = 0  
  RETURN @Ret   
 END  
  
 SET @AIDIdent = @@IDENTITY  
 INSERT INTO login(UserID, AID, Password)  
 VALUES (@UserID, @AIDIdent, @Password)  
 IF @@ERROR <> 0 BEGIN  
  ROLLBACK TRAN  
  SET @Ret = 0  
  RETURN @Ret   
 END  
 COMMIT TRAN  
  
 SET @Ret = 1  
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spWebIsCharacterNameExist_NHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spWebIsCharacterNameExist_NHN]
	@NewName	VARCHAR(24)
AS BEGIN
	SET NOCOUNT ON;	
	
	IF( EXISTS(SELECT CID FROM Character(NOLOCK) WHERE Name = @NewName) ) 
		RETURN 0;
	
	RETURN 1;	
END
GO
/****** Object:  StoredProcedure [dbo].[spWebIsValidCharacterName_NHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spWebIsValidCharacterName_NHN]
	@NewName	VARCHAR(24)
AS BEGIN
	SET NOCOUNT ON;	
	
	IF( EXISTS(SELECT CID FROM dbo.Character(NOLOCK) WHERE Name = @NewName) ) 
		RETURN -1;

    IF( EXISTS(SELECT id FROM dbo.AbuseList(NOLOCK) WHERE @NewName LIKE Word) )
        RETURN -2;

	RETURN 0;
END
GO
/****** Object:  StoredProcedure [dbo].[spWebIsValidCharName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------


CREATE PROC [dbo].[spWebIsValidCharName]
 @Name VARCHAR(20)
AS
BEGIN
 IF @Name IS NULL RETURN -1

 SET NOCOUNT ON

 IF EXISTS(SELECT * FROM dbo.AbuseList al(NOLOCK) WHERE @Name like al.Word)
 BEGIN
  RETURN -2
 END

 IF EXISTS(SELECT * FROM dbo.Character(NOLOCK) WHERE Name = @Name)
 BEGIN 
  RETURN -3
 END

 RETURN 0
END
GO
/****** Object:  StoredProcedure [dbo].[spWebIsValidClanName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[spWebIsValidClanName]
	@Name varchar(24)
as
begin
	set nocount on

	if (@Name is null) or (len(@Name) < 4)
		return (-1)

	if exists(select * from dbo.AbuseList with(nolock) where Word like @Name)
	begin
		return -2
	end

	if exists(select * from dbo.Clan with(nolock) where Name = @Name)
	begin
		return -3
	end

	return 1
end
GO
/****** Object:  StoredProcedure [dbo].[spWebLeaveClan]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ÀÚ½ÅÀÇ Å¬·£ Å»Åð.
CREATE PROC [dbo].[spWebLeaveClan]
	@CharName varchar(24) /* Ä³¸¯ÅÍ ÀÌ¸§ */
AS
BEGIN TRAN
	SET NOCOUNT ON

	DECLARE @CLID int
	DECLARE @CID int
	DECLARE @MasterCID int

	-- Á¸ÀçÇÏ´Â ¾ÆÀÌµðÀÎ°¡?
	SELECT @CLID = cm.CLID, @CID = c.CID, @MasterCID = cl.MasterCID
	FROM Account a (NOLOCK), Character c (NOLOCK), Clan cl(NOLOCK), ClanMember cm (NOLOCK)
	WHERE c.Name = @CharName AND a.AID = c.AID AND cm.CID = c.CID AND cl.CLID = cm.CLID

	-- Å¬·£¸¶½ºÅÍ°¡ ¾Æ´Ï°í Å¬·£¿¡ °¡ÀÔµÇ ÀÖÀ» °æ¿ì¸¸.
	IF (@CID IS NULL) OR (@MasterCID = @CID) OR (@CLID IS NULL)
	BEGIN
		ROLLBACK TRAN
		SET NOCOUNT OFF 
		RETURN
	END
		
	DELETE ClanMember WHERE CID = @CID
	IF 0 <> @@ERROR
	BEGIN
		ROLLBACK TRAN
		SET NOCOUNT OFF 
		RETURN
	END

	SET NOCOUNT OFF 
COMMIT TRAN
GO
/****** Object:  StoredProcedure [dbo].[spWebLeaveClanByCID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- CID·Î Å¬·£ Å»Åð.
CREATE  PROC [dbo].[spWebLeaveClanByCID]
	@CID int /* Å»Åð¿äÃ» Ä³¸¯ÅÍ CID */
AS
SET NOCOUNT ON
BEGIN TRAN
	

	DECLARE @CLID int
	DECLARE @MasterCID int

	-- Á¸ÀçÇÏ´Â ¾ÆÀÌµðÀÎ°¡?
	SELECT @CLID = cm.CLID, @MasterCID = cl.MasterCID
	FROM Clan cl(NOLOCK), ClanMember cm (NOLOCK)
	WHERE cm.CID = @CID AND cl.CLID = cm.CLID

	-- Å¬·£¸¶½ºÅÍ°¡ ¾Æ´Ï°í Å¬·£¿¡ °¡ÀÔµÇ ÀÖÀ» °æ¿ì¸¸.
	IF (@CID IS NULL) OR (@MasterCID = @CID) OR (@CLID IS NULL)
	BEGIN
		ROLLBACK TRAN
		SELECT 0
		RETURN
	END
		
	DELETE ClanMember WHERE CID = @CID
	IF 0 <> @@ERROR
	BEGIN
		ROLLBACK TRAN
		SELECT 0
		RETURN
	END

	SELECT 1	
COMMIT TRAN
SET NOCOUNT OFF
GO
/****** Object:  StoredProcedure [dbo].[spWebResetChar]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Ä³¸¯ÅÍ ÃÊ±âÈ­  
CREATE PROC [dbo].[spWebResetChar]
-- ALTER PROC dbo.spWebResetChar
	@CID  INT
AS BEGIN  
	
	SET NOCOUNT ON;
	
	BEGIN TRAN ----------------
		UPDATE	Character 
		SET		Level = 1, XP = 0, BP = 0, GameCount = 0, KillCount = 0, DeathCount = 0		
		WHERE	CID = @CID;
		IF (@@ERROR <> 0) OR (@@ROWCOUNT = 0) BEGIN
			ROLLBACK TRAN;
			RETURN;
		END
				
		UPDATE	CharacterEquipmentSlot
		SET		CIID = NULL, ItemID = NULL		
		WHERE	CID = @CID;
		IF (@@ERROR <> 0) OR (@@ROWCOUNT = 0) BEGIN
			ROLLBACK TRAN;
			RETURN;
		END
					
		UPDATE	CharacterItem 
		SET		CID = NULL 
		WHERE	CID = @CID 
		AND		ItemID < 500000  
		
		IF (@@ERROR <> 0) OR (@@ROWCOUNT = 0) BEGIN
			ROLLBACK TRAN;
			RETURN;
		END
		
	COMMIT TRAN ---------------
END  

-------------------------------------------------------------------------------------------------------------------------
-- º¹±¸ Äõ¸®
/*
DROP PROC spWebResetChar
EXEC sp_rename 'BackUp_spWebResetChar', 'spWebResetChar';
*/
GO
/****** Object:  StoredProcedure [dbo].[spWebRestoreSleepAccount_NHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spWebRestoreSleepAccount_NHN]  
    @UserID VARCHAR(24)  
AS BEGIN  
    SET NOCOUNT ON;   

    DECLARE @AID   INT;    
    DECLARE @HackingType INT;  
    DECLARE @RegDate  DATETIME;  

    SELECT  @AID = al.AID, @RegDate = al.RegDt  
    FROM    SleepAccountNHN al   
    WHERE   al.UserID = @UserID;  

    IF( @AID IS NULL ) SELECT -1 AS 'Ret';  -- UserID is Not Sleeped   

    BEGIN TRAN --------  

    UPDATE  Account   
    SET     HackingType = NULL   
    WHERE   AID = @AID 
    AND     HackingType = 10;  

    -- Update HackingType Field FAIL!  
    IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN      
        ROLLBACK TRAN       
        SELECT -2 AS 'Ret';  
    END  

    
    DELETE  SleepAccountNHN   
    WHERE   AID = @AID;  

    -- Delete SleepAccountNHN FAIL!  
    IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN      
        ROLLBACK TRAN       
        SELECT -3 AS 'Ret';  
    END  


    INSERT SleepAccountRestoredLogNHN(AID, UserID, RegDt, RestoredDt)  
    VALUES(@AID, @UserID, @RegDate, GETDATE());
  
    -- Insert SleepAccountRestoredLogNHN FAIL!  
    IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN      
        ROLLBACK TRAN       
        SELECT -4 AS 'Ret';  
    END  

    COMMIT TRAN -------  

    SELECT 0 AS 'Ret'
END
GO
/****** Object:  StoredProcedure [dbo].[spWebRestoreSleepAccount87_NHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spWebRestoreSleepAccount87_NHN]
	@UserID VARCHAR(24)
AS BEGIN
	SET NOCOUNT ON;	
	
	DECLARE @AID			INT;		
	DECLARE @HackingType	INT;
	DECLARE @RegDate		DATETIME;
	DECLARE @Ret	INT;
		
	SELECT	@AID = al.AID, @RegDate = al.RegDt
	FROM	SleepAccountNHN al 
	WHERE	al.UserID = @UserID;
	

	IF( @AID IS NULL ) BEGIN
  SET @Ret=-1
  RETURN @Ret
	END;			
	BEGIN TRAN 	
		UPDATE	Account 
		SET		HackingType = NULL 
		WHERE	AID = @AID AND HackingType = 10;
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN    
			ROLLBACK TRAN     
			RETURN -2;				END
			
		DELETE	SleepAccountNHN 
		WHERE	AID = @AID;
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN    
			ROLLBACK TRAN     
			RETURN -3;				END
		
		INSERT SleepAccountRestoredLogNHN(AID, UserID, RegDt, RestoredDt)
		VALUES(@AID, @UserID, @RegDate, GETDATE());
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN    
			ROLLBACK TRAN     
			RETURN -4;				END
		
	COMMIT TRAN 	
	RETURN 0;
END
GO
/****** Object:  StoredProcedure [dbo].[spWebRestoreSleepAccount88_NHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spWebRestoreSleepAccount88_NHN]
	@UserID VARCHAR(24)
AS BEGIN
	SET NOCOUNT ON;	
	
	DECLARE @AID			INT;		
	DECLARE @HackingType	INT;
	DECLARE @RegDate		DATETIME;
	DECLARE @Ret	INT;
		
	SELECT	@AID = al.AID, @RegDate = al.RegDt
	FROM	SleepAccountNHN al 
	WHERE	al.UserID = @UserID;
	

	IF( @AID IS NULL ) BEGIN
  SET @Ret=-1
  RETURN @Ret
	END;			
	BEGIN TRAN 	
		UPDATE	Account 
		SET		HackingType = NULL 
		WHERE	AID = @AID AND HackingType = 10;
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN    
			ROLLBACK TRAN     
			RETURN -2;				END
			
		DELETE	SleepAccountNHN 
		WHERE	AID = @AID;
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN    
			ROLLBACK TRAN     
			RETURN -3;				END
		
		INSERT SleepAccountRestoredLogNHN(AID, UserID, RegDt, RestoredDt)
		VALUES(@AID, @UserID, @RegDate, GETDATE());
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN    
			ROLLBACK TRAN     
			RETURN -4;				END
		
	COMMIT TRAN 	
	RETURN 0;
END
GO
/****** Object:  StoredProcedure [dbo].[spWebRestoreSleepAccount89_NHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spWebRestoreSleepAccount89_NHN]
	@UserID VARCHAR(24)
	, @Ret int OUTPUT
AS BEGIN
	SET NOCOUNT ON;	
	
	DECLARE @AID			INT;		
	DECLARE @HackingType	INT;
	DECLARE @RegDate		DATETIME;
		
	SELECT	@AID = al.AID, @RegDate = al.RegDt
	FROM	SleepAccountNHN al 
	WHERE	al.UserID = @UserID;
	

	IF( @AID IS NULL ) BEGIN
  SET @Ret=-1
  RETURN @Ret
	END;			
	BEGIN TRAN 	
		UPDATE	Account 
		SET		HackingType = NULL 
		WHERE	AID = @AID AND HackingType = 10;
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN    
			ROLLBACK TRAN     
  SET @Ret=-2
  RETURN @Ret

		END
			
		DELETE	SleepAccountNHN 
		WHERE	AID = @AID;
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN    
			ROLLBACK TRAN     
  SET @Ret=-3
  RETURN @Ret
					END
		
		INSERT SleepAccountRestoredLogNHN(AID, UserID, RegDt, RestoredDt)
		VALUES(@AID, @UserID, @RegDate, GETDATE());
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN    
			ROLLBACK TRAN     
  SET @Ret=-4
  RETURN @Ret
			
		END
		
	COMMIT TRAN 
	  SET @Ret=0
  RETURN @Ret

END
GO
/****** Object:  StoredProcedure [dbo].[spWebRestoreSleepAccount90_NHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spWebRestoreSleepAccount90_NHN]  
    @UserID VARCHAR(24)  
AS BEGIN  
    SET NOCOUNT ON;   

    DECLARE @AID   INT;    
    DECLARE @HackingType INT;  
    DECLARE @RegDate  DATETIME;  

    SELECT  @AID = al.AID, @RegDate = al.RegDt  
    FROM    SleepAccountNHN al   
    WHERE   al.UserID = @UserID;  

    IF( @AID IS NULL ) SELECT -1 AS Ret;  
    BEGIN TRAN 
    UPDATE  Account   
    SET     HackingType = NULL   
    WHERE   AID = @AID 
    AND     HackingType = 10;  

        IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN      
        ROLLBACK TRAN       
        SELECT -2 AS Ret;  
    END  

    
    DELETE  SleepAccountNHN   
    WHERE   AID = @AID;  

        IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN      
        ROLLBACK TRAN       
        SELECT -3 AS Ret;  
    END  


    INSERT SleepAccountRestoredLogNHN(AID, UserID, RegDt, RestoredDt)  
    VALUES(@AID, @UserID, @RegDate, GETDATE());
  
        IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN      
        ROLLBACK TRAN       
        SELECT -4 AS Ret;  
    END  

    COMMIT TRAN 
    SELECT 0 AS Ret
END
GO
/****** Object:  StoredProcedure [dbo].[spWebRestoreSleepAccount99_NHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spWebRestoreSleepAccount99_NHN]
	@UserID VARCHAR(24)
AS BEGIN
	SET NOCOUNT ON;	
	
	DECLARE @AID			INT;		
	DECLARE @HackingType	INT;
	DECLARE @RegDate		DATETIME;
		
	SELECT	@AID = al.AID, @RegDate = al.RegDt
	FROM	SleepAccountNHN al 
	WHERE	al.UserID = @UserID;
	IF( @AID IS NULL ) RETURN -1;			
	BEGIN TRAN 	
		UPDATE	Account 
		SET		HackingType = NULL 
		WHERE	AID = @AID AND HackingType = 10;
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN    
			ROLLBACK TRAN     
			RETURN -2;				END
			
		DELETE	SleepAccountNHN 
		WHERE	AID = @AID;
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN    
			ROLLBACK TRAN     
			RETURN -3;				END
		
		INSERT SleepAccountRestoredLogNHN(AID, UserID, RegDt, RestoredDt)
		VALUES(@AID, @UserID, @RegDate, GETDATE());
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN    
			ROLLBACK TRAN     
			RETURN -4;				END
		
	COMMIT TRAN 	
	RETURN 0;
END
GO
/****** Object:  StoredProcedure [dbo].[spWebRestoreSleepCharacter_NHN]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spWebRestoreSleepCharacter_NHN]
	@AID		INT,
	@CID		INT,
	@CharNum	SMALLINT,
	@NewName	VARCHAR(24)	
AS BEGIN
	SET NOCOUNT ON;
			
	DECLARE @RegDate			DATETIME;
	DECLARE @OriginName			VARCHAR(24);
	
	SELECT	@OriginName = Name, @RegDate = RegDt 
	FROM	SleepCharacterNHN(NOLOCK)
	WHERE	CID = @CID;
	
	-- Not Exists Information In SleepCharacterNHN
	IF( @RegDate IS NULL ) RETURN -1;
	
	-- Can't Use CharNum
	IF( @CharNum < 0 OR @CharNum > 3 )	RETURN -2;
	
	-- Can't Use CharNum
	IF( EXISTS(SELECT CID FROM Character(NOLOCK) WHERE AID = @AID AND CharNum = @CharNum) ) RETURN -3;
	
	-- Not Restored Account
	IF( EXISTS(SELECT AID FROM SleepAccountNHN(NOLOCK) WHERE AID = @AID) ) RETURN -4;
	
	-- Duplicate Character Name Exists!		
	IF( EXISTS(SELECT CID FROM Character(NOLOCK) WHERE Name = @NewName) ) RETURN -5;
		
			
	BEGIN TRAN --------		
		
		UPDATE	Character
		SET		Name = @NewName, DeleteName = '', DeleteFlag = 0, CharNum = @CharNum
		WHERE	CID = @CID
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN    
			ROLLBACK TRAN     
			RETURN -6;		-- Restore Character Information FAIL!
		END
		
		DELETE	SleepCharacterNHN 
		WHERE	CID = @CID;
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN    
			ROLLBACK TRAN     
			RETURN -7;		-- Delete SleepCharacterNHN FAIL!
		END
		
		INSERT SleepCharacterRestoredLogNHN(CID, OrginName, RestoreName, RegDt, RestoredDt)
		VALUES (@CID, @OriginName, @NewName, @RegDate, GETDATE());
		IF( 0 = @@ROWCOUNT OR 0 <> @@ERROR ) BEGIN    
			ROLLBACK TRAN     
			RETURN -8;		-- Insert SleepCharacterRestoredLogNHN FAIL!
		END
		
	COMMIT TRAN -------	
	
	RETURN 0;
	
END
GO
/****** Object:  StoredProcedure [dbo].[spWebSearchTotalRankingByName]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* Ä³¸¯ÅÍ ÀÌ¸§À¸·Î ¼øÀ§ °Ë»ö */    
CREATE PROC [dbo].[spWebSearchTotalRankingByName]    
  @Name    varchar(24)    
AS  
SET NOCOUNT ON
BEGIN    
 SELECT Rank, Level, Name, XP, KillCount, DeathCount, UserID  
 FROM TotalRanking(NOLOCK)    
 WHERE Name = @Name    
END
GO
/****** Object:  StoredProcedure [dbo].[spWebSearchTotalRankingByNetmarbleID]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ÀÚ½ÅÀÇ ·©Å· Á¤º¸.
CREATE PROC [dbo].[spWebSearchTotalRankingByNetmarbleID]
	@UserID varchar(20)
AS
SET NOCOUNT ON
BEGIN
	SELECT Rank, Level, Name, XP, KillCount, DeathCount, UserID 
	FROM TotalRanking (NOLOCK)
	WHERE UserID = @UserID
END
GO
/****** Object:  StoredProcedure [dbo].[spWebSelectClanMaster]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spWebSelectClanMaster]
 @UserID varchar(20)
as
begin
 set nocount on 

 select c.Name as 'MasterName', cl.Name as 'ClanName'
 from dbo.Account a(nolock), dbo.Character c(nolock), Clan cl(nolock)
 where a.UserID = @UserID and c.AID = a.AID and cl.MasterCID = c.CID
 order by c.CID
end
GO
/****** Object:  StoredProcedure [dbo].[spWebUndeleteChar]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROC [dbo].[spWebUndeleteChar]
	@CID INT
AS
SET NOCOUNT ON
BEGIN
	DECLARE @AID INT
	DECLARE @Name VARCHAR(64)
	SELECT @Name = DeleteName, @AID=AID FROM Character(NOLOCK) WHERE CID=@CID
	
	IF @AID IS NULL
	BEGIN
		SELECT 'It is not exist character.' AS ERROR, @CID AS CID
		GOTO label_finish
	END
	
	--SELECT @Name AS Name
	IF @Name IS NULL
	BEGIN
		SELECT 'already exist character' AS ERROR, @CID AS CID
		GOTO label_finish
	END
	
	-- find empty slot.
	DECLARE @CharNum INT
	SELECT @CharNum=a.CharNum FROM
	(
		SELECT 0 AS CharNum UNION 
		SELECT 1 AS CharNum UNION 
		SELECT 2 AS CharNum UNION 
		SELECT 3 AS CharNum
	) a WHERE NOT EXISTS
	(
		SELECT CharNum FROM Character(NOLOCK) 
		WHERE AID=@AID AND DeleteFlag=0 AND CharNum=a.CharNum
	)
	IF @CharNum IS NULL
	BEGIN
		SELECT 'no more empty slot' AS ERROR, @CID AS CID
		GOTO label_finish
	END
	
	DECLARE @ExistName VARCHAR(64)
	SELECT @ExistName = Name FROM Character(NOLOCK) WHERE AID=@AID AND CharNum=@CharNum
	IF @ExistName IS NOT NULL
	BEGIN
		SELECT 'already exist slot.' AS ERROR, @CID AS CID
		GOTO label_finish
	END
	
	DECLARE @Count int
	SELECT @Count=COUNT(*) FROM Character(NOLOCK) WHERE Name=@Name
	
	--SELECT @Name AS UndeleteTarget
	
	IF ( @Count <= 0 )
	BEGIN
		Update Character Set Name=@Name WHERE CID=@CID
		Update Character Set CharNum=@CharNum WHERE CID=@CID
		Update Character Set DeleteFlag=0 WHERE CID=@CID
		Update Character Set DeleteName=NULL WHERE CID=@CID
	
		SELECT 'completed restore' AS ERROR, @Name AS 'Name'
	END
	ELSE
	BEGIN
		SELECT 'already exist name' AS ERROR, @Name AS 'Name', @Count AS 'Count'
	END
		
label_finish:
END
GO
/****** Object:  StoredProcedure [dbo].[spWebUpdateAccount]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-------------------------------------------------------------------

 CREATE    PROC [dbo].[spWebUpdateAccount]     
 @UserID varchar(20)    
, @Password varchar(20)=NULL    
, @Cert tinyint    
, @Name  varchar(30)    
, @Age smallint    
, @Country char(3)    
, @Sex tinyint    
, @Email varchar(50)=NULL    
, @Ret int OutPut    
AS    
 SET NOCOUNT ON    
 BEGIN TRAN    
 UPDATE Account SET  Cert = @Cert, Name = @Name, Age = @Age, Sex = @Sex, Email = @Email,     
  Country = @Country    
 WHERE UserID = @UserID    
 IF 0 = @@ROWCOUNT BEGIN    
  ROLLBACK TRAN    
  SET @Ret = 0    
  RETURN @Ret     
 END    
    
 IF (@Password <> '') AND (@Password IS NOT NULL) BEGIN    
  UPDATE  login SET Password = @Password    
  WHERE UserID = @UserID    
  IF 0 = @@ROWCOUNT BEGIN    
   ROLLBACK TRAN    
   SET @Ret = 0    
   RETURN @Ret     
  END    
 END    
  
 COMMIT TRAN    
    
 SET @Ret = 1    
 RETURN @Ret
GO
/****** Object:  StoredProcedure [dbo].[spWinTheClanGame]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------------------------------------------------------------------------

CREATE  PROC [dbo].[spWinTheClanGame]  
 @WinnerCLID  int,  
 @LoserCLID  int,  
 @IsDrawGame  tinyint,  
 @WinnerPoint  int,  
 @LoserPoint  int,  
 @WinnerClanName  varchar(24),  
 @LoserClanName  varchar(24),  
 @RoundWins  tinyint,  
 @RoundLosses  tinyint,  
 @MapID   tinyint,  
 @GameType  tinyint,  
 @WinnerMembers  varchar(110),  
 @LoserMembers  varchar(110)  
AS  
 SET NOCOUNT ON 
  
 IF @IsDrawGame = 0 BEGIN  
  -- Wins+1  
  UPDATE Clan SET Wins=Wins+1, Point=Point+@WinnerPoint, TotalPoint=TotalPoint+@WinnerPoint WHERE CLID=@WinnerCLID  
  -- Losses+1  
  UPDATE Clan SET Losses=Losses+1, Point= dbo.fnGetMax(0, Point+(@LoserPoint)) WHERE CLID=@LoserCLID  
--  UPDATE Clan SET Point=0 WHERE CLID=@LoserCLID AND Point<0  
  
  -- write log
  INSERT INTO ClanGameLog(WinnerCLID, LoserCLID, WinnerClanName, LoserClanName, RoundWins, RoundLosses, MapID, GameType, RegDate, WinnerMembers, LoserMembers, WinnerPoint, LoserPoint)  
  VALUES (@WinnerCLID, @LoserCLID, @WinnerClanName, @LoserClanName, @RoundWins, @RoundLosses, @MapID, @GameType, GETDATE(), @WinnerMembers, @LoserMembers, @WinnerPoint, @LoserPoint)  
 END  
 ELSE  
  UPDATE Clan SET Draws=Draws+1 WHERE CLID=@WinnerCLID OR CLID=@LoserCLID
GO
/****** Object:  StoredProcedure [dbo].[USP_sjr_TableSizeIncr]    Script Date: 25.11.2023 2.19.31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_sjr_TableSizeIncr]

as
begin 
	SET NOCOUNT ON

	select identity(int,1,1) idx ,' insert sjr_TableSizeIncr (name,rows,reserved,date,index_size,unused) ' +char(10)+
	'exec sp_spaceused '+name  as sql  into #spaceusedTb
	from Gunzdb.dbo.sysobjects where xtype = 'U'
	 
	
	DECLARE @sql varchar(400) 
	DECLARE SQL_cursor CURSOR FOR 
	SELECT  sql
	FROM #spaceusedTb
	ORDER BY idx
	OPEN SQL_cursor
	FETCH NEXT FROM SQL_cursor 
	INTO @sql
	WHILE @@FETCH_STATUS = 0
	BEGIN
	   exec (@sql)
	   FETCH NEXT FROM SQL_cursor 
	   INTO @sql
	END
	CLOSE SQL_cursor
	DEALLOCATE SQL_cursor

end
GO
USE [master]
GO
ALTER DATABASE [GunzDB] SET  READ_WRITE 
GO
