USE [master]
GO
/****** Object:  Database [QuickSet]    Script Date: 12/11/2019 2:54:28 PM ******/
CREATE DATABASE [QuickSet]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuickSet', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\QuickSet.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuickSet_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\QuickSet_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [QuickSet] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuickSet].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuickSet] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuickSet] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuickSet] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuickSet] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuickSet] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuickSet] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuickSet] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuickSet] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuickSet] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuickSet] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuickSet] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuickSet] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuickSet] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuickSet] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuickSet] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QuickSet] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuickSet] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuickSet] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuickSet] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuickSet] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuickSet] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuickSet] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuickSet] SET RECOVERY FULL 
GO
ALTER DATABASE [QuickSet] SET  MULTI_USER 
GO
ALTER DATABASE [QuickSet] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuickSet] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuickSet] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuickSet] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuickSet] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuickSet', N'ON'
GO
ALTER DATABASE [QuickSet] SET QUERY_STORE = OFF
GO
USE [QuickSet]
GO
/****** Object:  User [quicksetuser]    Script Date: 12/11/2019 2:54:28 PM ******/
CREATE USER [quicksetuser] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [quickset]    Script Date: 12/11/2019 2:54:28 PM ******/
CREATE USER [quickset] FOR LOGIN [quickset] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [quicksetuser]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [quicksetuser]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [quicksetuser]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [quicksetuser]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [quicksetuser]
GO
ALTER ROLE [db_datareader] ADD MEMBER [quicksetuser]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [quicksetuser]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [quicksetuser]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [quicksetuser]
GO
ALTER ROLE [db_owner] ADD MEMBER [quickset]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [quickset]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [quickset]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [quickset]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [quickset]
GO
ALTER ROLE [db_datareader] ADD MEMBER [quickset]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [quickset]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [quickset]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [quickset]
GO
/****** Object:  Table [dbo].[Sets]    Script Date: 12/11/2019 2:54:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sets](
	[setID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NULL,
	[title] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sets_Songs_Link]    Script Date: 12/11/2019 2:54:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sets_Songs_Link](
	[songID] [int] NOT NULL,
	[setID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Songs]    Script Date: 12/11/2019 2:54:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Songs](
	[songID] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](100) NULL,
	[artist] [varchar](100) NULL,
	[BPM] [int] NULL,
	[duration] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 12/11/2019 2:54:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](500) NOT NULL,
	[username] [varchar](100) NOT NULL,
	[password] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[getSetID]    Script Date: 12/11/2019 2:54:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getSetID]
	@userID as int,
	@title as varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Sets WHERE userID = @userID AND title = @title
END
GO
/****** Object:  StoredProcedure [dbo].[spDeleteUser]    Script Date: 12/11/2019 2:54:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteUser]
	@userID as int
AS
BEGIN
	DELETE FROM Users WHERE userID = @userID
END
GO
/****** Object:  StoredProcedure [dbo].[spDellAllSets]    Script Date: 12/11/2019 2:54:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spDellAllSets]

AS
BEGIN
	TRUNCATE TABLE Sets
END
GO
/****** Object:  StoredProcedure [dbo].[spGetAllUsers]    Script Date: 12/11/2019 2:54:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllUsers]
AS
BEGIN
	SELECT * FROM Users
END
GO
/****** Object:  StoredProcedure [dbo].[spGetSets]    Script Date: 12/11/2019 2:54:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetSets]
	@userID as int
AS
BEGIN
	SELECT * FROM Sets WHERE userID = @userID
END
GO
/****** Object:  StoredProcedure [dbo].[spGetSongID]    Script Date: 12/11/2019 2:54:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetSongID]
	@title as varchar(100),
	@artist as varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Songs WHERE title = @title AND artist = @artist
END
GO
/****** Object:  StoredProcedure [dbo].[spGetSpecificUser]    Script Date: 12/11/2019 2:54:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetSpecificUser]
	@userID as int
AS
BEGIN
	SELECT * FROM Users WHERE userID = @userID
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertSet]    Script Date: 12/11/2019 2:54:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertSet]
	@title as varchar(100),
	@userID as int
AS
BEGIN
	INSERT INTO Sets (userID, title) VALUES (@userID, @title)
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertSong]    Script Date: 12/11/2019 2:54:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertSong]
	@title as varchar(100),
	@artist as varchar(100),
	@BPM as int,
	@duration as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	INSERT INTO Songs(title, artist, BPM, duration) VALUES (@title, @artist, @BPM, @duration)
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertUser]    Script Date: 12/11/2019 2:54:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spInsertUser]
	@email as varchar(500),
	@username as varchar(100),
	@password as varchar(100)
AS
BEGIN
	INSERT INTO Users(email, username, password) 
	VALUES (@email, @username, @password)
END
GO
/****** Object:  StoredProcedure [dbo].[spLinkSongSet]    Script Date: 12/11/2019 2:54:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spLinkSongSet]
	@songID as int,
	@setID as int
AS
BEGIN
	INSERT INTO Sets_Songs_Link (songID, setID) VALUES (@songID, @setID)
END
GO
/****** Object:  StoredProcedure [dbo].[spSelectEmailPass]    Script Date: 12/11/2019 2:54:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSelectEmailPass]
	@email as varchar(500),
	@password as varchar(100)
AS
BEGIN
	SELECT * FROM Users WHERE email = @email AND password=@password
END
GO
/****** Object:  StoredProcedure [dbo].[spSelectSongTitleArtist]    Script Date: 12/11/2019 2:54:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSelectSongTitleArtist]
	@title as varchar(100),
	@artist as varchar(100)
AS
BEGIN
	SELECT * FROM Songs WHERE title = @title AND artist = @artist
END
GO
USE [master]
GO
ALTER DATABASE [QuickSet] SET  READ_WRITE 
GO
