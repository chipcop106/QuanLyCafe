USE [master]
GO
/****** Object:  Database [QuanLyQuanCafe]    Script Date: 27-May-18 13:05:16 ******/
CREATE DATABASE [QuanLyQuanCafe]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyQuanCafe', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL13.IMEH\MSSQL\DATA\QuanLyQuanCafe.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuanLyQuanCafe_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL13.IMEH\MSSQL\DATA\QuanLyQuanCafe_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [QuanLyQuanCafe] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyQuanCafe].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyQuanCafe] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET RECOVERY FULL 
GO
ALTER DATABASE [QuanLyQuanCafe] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyQuanCafe] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyQuanCafe] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyQuanCafe] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyQuanCafe] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuanLyQuanCafe', N'ON'
GO
ALTER DATABASE [QuanLyQuanCafe] SET QUERY_STORE = OFF
GO
USE [QuanLyQuanCafe]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [QuanLyQuanCafe]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END

GO
/****** Object:  Table [dbo].[Account]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[PassWord] [nvarchar](1000) NOT NULL,
	[Type] [int] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [datetime] NULL,
	[DateCheckOut] [datetime] NULL,
	[idTable] [int] NOT NULL,
	[status] [int] NOT NULL,
	[discount] [int] NULL,
	[totalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[idCategory] [int] NOT NULL,
	[price] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[status] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type], [ID]) VALUES (N'Admin', N'Administrator', N'0', 1, 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type], [ID]) VALUES (N'Staff', N'NhanVien', N'1', 0, 3)
SET IDENTITY_INSERT [dbo].[Account] OFF
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (33, CAST(N'2018-05-24T18:51:49.927' AS DateTime), CAST(N'2018-05-24T18:57:33.707' AS DateTime), 11, 1, 0, 18000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (34, CAST(N'2018-05-24T18:51:52.790' AS DateTime), CAST(N'2018-05-24T18:57:35.660' AS DateTime), 3, 1, 0, 40500)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (35, CAST(N'2018-05-24T18:51:53.763' AS DateTime), CAST(N'2018-05-24T18:52:02.220' AS DateTime), 8, 1, 0, 81000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (36, CAST(N'2018-05-24T18:51:55.847' AS DateTime), CAST(N'2018-05-24T18:51:59.640' AS DateTime), 7, 1, 0, 31500)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (37, CAST(N'2018-05-24T18:51:57.780' AS DateTime), NULL, 6, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (38, CAST(N'2018-05-24T18:58:43.637' AS DateTime), CAST(N'2018-05-25T08:51:24.693' AS DateTime), 3, 1, 0, 103500)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (39, CAST(N'2018-05-24T18:58:45.510' AS DateTime), CAST(N'2018-05-24T18:58:53.820' AS DateTime), 8, 1, 0, 81000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (40, CAST(N'2018-05-24T18:58:49.140' AS DateTime), CAST(N'2018-05-24T18:58:52.370' AS DateTime), 11, 1, 0, 72000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (41, CAST(N'2018-05-24T19:04:51.820' AS DateTime), CAST(N'2018-05-25T22:59:16.927' AS DateTime), 7, 1, 0, 54000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (42, CAST(N'2018-05-25T08:49:30.757' AS DateTime), CAST(N'2018-05-25T08:50:32.913' AS DateTime), 2, 1, 0, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (43, CAST(N'2018-05-25T08:51:51.540' AS DateTime), NULL, 1, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (44, CAST(N'2018-05-25T08:52:13.483' AS DateTime), CAST(N'2018-05-25T08:53:31.863' AS DateTime), 3, 1, 0, 39600)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (45, CAST(N'2018-05-25T10:35:45.627' AS DateTime), NULL, 2, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (46, CAST(N'2018-05-25T22:56:56.320' AS DateTime), CAST(N'2018-05-25T22:57:13.267' AS DateTime), 10, 1, 0, 121500)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (47, CAST(N'2018-05-25T22:57:00.370' AS DateTime), NULL, 8, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (48, CAST(N'2018-05-25T22:59:49.827' AS DateTime), NULL, 4, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (49, CAST(N'2018-05-25T22:59:53.017' AS DateTime), NULL, 14, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (50, CAST(N'2018-05-25T22:59:56.433' AS DateTime), NULL, 12, 0, 0, NULL)
SET IDENTITY_INSERT [dbo].[Bill] OFF
SET IDENTITY_INSERT [dbo].[BillInfo] ON 

INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (18, 33, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (19, 34, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (20, 35, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (21, 35, 18, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (22, 36, 18, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (23, 34, 19, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (24, 38, 17, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (25, 38, 18, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (26, 39, 18, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (27, 39, 17, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (28, 39, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (29, 40, 1, 4)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (30, 43, 17, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (31, 38, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (32, 38, 19, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (34, 44, 31, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (35, 43, 33, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (36, 45, 18, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (37, 45, 19, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (38, 45, 2, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (39, 41, 17, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (40, 41, 19, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (41, 46, 18, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (42, 46, 2, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (43, 46, 9, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (44, 46, 10, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (45, 47, 10, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (46, 48, 2, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (47, 48, 19, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (48, 48, 18, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (49, 49, 29, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (50, 49, 4, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (51, 47, 4, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (52, 47, 7, 1)
SET IDENTITY_INSERT [dbo].[BillInfo] OFF
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (1, N'Capuchino', 1, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (2, N'Expresso', 1, 25000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (3, N'Lime Juice', 5, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (4, N'Orange Juice', 5, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (5, N'Grape Fruit Juice', 5, 25000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (6, N'Pine Apple Juice', 5, 15000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (7, N'Melon Juice', 5, 15000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (9, N'Apple & Honey', 6, 35000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (10, N'Raspberry', 6, 40000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (11, N'Lemon & Honey', 6, 40000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (12, N'Passion Fruit & BlueBerry', 6, 45000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (13, N'Macha Cake Cream', 4, 65000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (14, N'Chocolate Milk Cake', 4, 45000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (15, N'Bitscuit', 4, 15000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (16, N'Tuxedo Cake', 4, 35000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (17, N'Double Up Expresso', 1, 35000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (18, N'Coffee Late', 1, 35000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (19, N'Caramel Machiato', 1, 25000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (20, N'Chocolate Milk Tea', 2, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (21, N'Milk Tea', 2, 25000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (22, N'Long Black', 2, 22000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (23, N'Vodka', 3, 70000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (24, N'Tiger', 3, 18000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (25, N'Heiniken', 3, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (26, N'Beck', 3, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (27, N'Saporo', 3, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (28, N'Dry Chicken ( 1 pcs )', 7, 35000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (29, N' Vegetable Salad', 7, 25000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (30, N'Chicken Legs Barbecue', 8, 45000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (31, N'Mushroom Soup', 8, 22000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (32, N'Classic Bugers', 7, 35000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (33, N' Fish Barbecue Taco', 8, 45000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (34, N'Pho Noodle', 8, 45000)
SET IDENTITY_INSERT [dbo].[Food] OFF
SET IDENTITY_INSERT [dbo].[FoodCategory] ON 

INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (1, N'Coffee')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (2, N'Milk Tea')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (3, N'Alcoho')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (4, N'Cake')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (5, N'Juice Drink')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (6, N'Soda')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (7, N'Fast Food')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (8, N'Main Food')
SET IDENTITY_INSERT [dbo].[FoodCategory] OFF
SET IDENTITY_INSERT [dbo].[TableFood] ON 

INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (1, N'Bàn 0', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (2, N'Bàn 12aa', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (3, N'Bàn 2', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (4, N'Bàn 3', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (5, N'Bàn 4', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (6, N'Bàn 5', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (7, N'Bàn 6', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (8, N'Bàn 7', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (9, N'Bàn 8', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (10, N'Bàn 9', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (11, N'Bàn 10', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (12, N'Bàn 13', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (13, N'Bàn 12', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (14, N'Bàn 13', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (15, N'Bàn 14', N'Trống')
SET IDENTITY_INSERT [dbo].[TableFood] OFF
ALTER TABLE [dbo].[Account] ADD  DEFAULT (N'Kter') FOR [DisplayName]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [PassWord]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [discount]
GO
ALTER TABLE [dbo].[BillInfo] ADD  DEFAULT ((0)) FOR [count]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[FoodCategory] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Bàn chưa có tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Trống') FOR [status]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
/****** Object:  StoredProcedure [dbo].[USP_AdminCheck]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_AdminCheck]
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord AND Type=1
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetAccountByUserName]
@userName nvarchar(100)
AS 
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListBillByDate]
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT t.name AS [Table Name], b.totalPrice AS [Total Price], DateCheckIn AS [Date Checkin], DateCheckOut AS [Date CheckOut]
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDateAndPage]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListBillByDateAndPage]
@checkIn date, @checkOut date, @page int
AS 
BEGIN
	DECLARE @pageRows INT = 10
	DECLARE @selectRows INT = @pageRows
	DECLARE @exceptRows INT = (@page - 1) * @pageRows
	
	;WITH BillShow AS( SELECT b.ID, t.name AS [Tên bàn], b.totalPrice AS [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá]
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable)
	
	SELECT TOP (@selectRows) * FROM BillShow WHERE id NOT IN (SELECT TOP (@exceptRows) id FROM BillShow)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDateForReport]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetListBillByDateForReport]
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT t.name, b.totalPrice, DateCheckIn, DateCheckOut
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetNumBillByDate]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetNumBillByDate]
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT COUNT(*)
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetTableList]
AS SELECT * FROM dbo.TableFood
GO
/****** Object:  StoredProcedure [dbo].[USP_GroupTable]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[USP_GroupTable]
@idtable1 INT, @idtable2 INT
AS
BEGIN
	DECLARE @idfirstBill INT
	DECLARE @idsecondBill INT

	DECLARE @isfirstTableEmpty INT =1
	DECLARE @issecondTableEmpty INT =1

	SELECT @idfirstBill=id FROM dbo.Bill WHERE idTable = @idtable1 AND status = 0
	SELECT @idsecondBill=id FROM dbo.Bill WHERE idTable = @idtable2 AND status = 0

	IF(@idfirstBill IS NULL)
	BEGIN
		PRINT '0000001'
		INSERT dbo.Bill
		        ( DateCheckIn ,
		          DateCheckOut ,
		          idTable ,
		          status
		        )
		VALUES  ( GETDATE() , -- DateCheckIn - date
		          NULL , -- DateCheckOut - date
		          @idTable1 , -- idTable - int
		          0  -- status - int
		        )
		        
		SELECT @idFirstBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0
	END
	 SELECT @isfirstTableEmpty = COUNT(*) FROM dbo.Billinfo WHERE idBill = @idfirstBill
	IF(@idsecondBill IS NULL)
	BEGIN
		INSERT dbo.Bill
		        ( DateCheckIn ,
		          DateCheckOut ,
		          idTable ,
		          status
		        )
		VALUES  ( GETDATE() , -- DateCheckIn - date
		          NULL , -- DateCheckOut - date
		          @idTable2 , -- idTable - int
		          0  -- status - int
		        )
		SELECT @idSecondBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
    END
	
    
    UPDATE dbo.Billinfo SET idBill=@idfirstBill WHERE idBill = @idfirstBill
	UPDATE dbo.Billinfo SET idBill =@idfirstBill WHERE idBill = @idsecondBill
	SELECT @issecondTableEmpty =COUNT(*) FROM dbo.Billinfo WHERE idBill = @idsecondBill
	IF(@isfirstTableEmpty = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idtable1
	IF(@issecondTableEmpty = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idtable2
END	
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertBill]
@idTable INT
AS
BEGIN
	INSERT dbo.Bill 
	        ( DateCheckIn ,
	          DateCheckOut ,
	          idTable ,
	          status,
	          discount
	        )
	VALUES  ( GETDATE() , -- DateCheckIn - date
	          NULL , -- DateCheckOut - date
	          @idTable , -- idTable - int
	          0,  -- status - int
	          0
	        )
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertBillInfo]
@idBill INT, @idFood INT, @count INT
AS
BEGIN

	DECLARE @isExitsBillInfo INT
	DECLARE @foodCount INT = 1
	
	SELECT @isExitsBillInfo = id, @foodCount = b.count 
	FROM dbo.BillInfo AS b 
	WHERE idBill = @idBill AND idFood = @idFood

	IF (@isExitsBillInfo > 0)
	BEGIN
		DECLARE @newCount INT = @foodCount + @count
		IF (@newCount > 0)
			UPDATE dbo.BillInfo	SET count = @foodCount + @count WHERE idFood = @idFood
		ELSE
			DELETE dbo.BillInfo WHERE idBill = @idBill AND idFood = @idFood
	END
	ELSE
	BEGIN
		INSERT	dbo.BillInfo
        ( idBill, idFood, count )
		VALUES  ( @idBill, -- idBill - int
          @idFood, -- idFood - int
          @count  -- count - int
          )
	END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_Login]
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SwitchTabel]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[USP_SwitchTabel]
@idTable1 INT, @idTable2 int
AS BEGIN

	DECLARE @idFirstBill int
	DECLARE @idSeconrdBill INT
	
	DECLARE @isFirstTablEmty INT = 1
	DECLARE @isSecondTablEmty INT = 1
	
	
	SELECT @idSeconrdBill = id FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
	SELECT @idFirstBill = id FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0
	
	PRINT @idFirstBill
	PRINT @idSeconrdBill
	PRINT '-----------'
	
	IF (@idFirstBill IS NULL)
	BEGIN
		PRINT '0000001'
		INSERT dbo.Bill
		        ( DateCheckIn ,
		          DateCheckOut ,
		          idTable ,
		          status
		        )
		VALUES  ( GETDATE() , -- DateCheckIn - date
		          NULL , -- DateCheckOut - date
		          @idTable1 , -- idTable - int
		          0  -- status - int
		        )
		        
		SELECT @idFirstBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0
		
	END
	
	SELECT @isFirstTablEmty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idFirstBill
	
	PRINT @idFirstBill
	PRINT @idSeconrdBill
	PRINT '-----------'
	
	IF (@idSeconrdBill IS NULL)
	BEGIN
		PRINT '0000002'
		INSERT dbo.Bill
		        ( DateCheckIn ,
		          DateCheckOut ,
		          idTable ,
		          status
		        )
		VALUES  ( GETDATE() , -- DateCheckIn - date
		          NULL , -- DateCheckOut - date
		          @idTable2 , -- idTable - int
		          0  -- status - int
		        )
		SELECT @idSeconrdBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
		
	END
	
	SELECT @isSecondTablEmty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idSeconrdBill
	
	PRINT @idFirstBill
	PRINT @idSeconrdBill
	PRINT '-----------'

	SELECT id INTO IDBillInfoTable FROM dbo.BillInfo WHERE idBill = @idSeconrdBill
	
	UPDATE dbo.BillInfo SET idBill = @idSeconrdBill WHERE idBill = @idFirstBill
	
	UPDATE dbo.BillInfo SET idBill = @idFirstBill WHERE id IN (SELECT * FROM IDBillInfoTable)
	
	DROP TABLE IDBillInfoTable
	
	IF (@isFirstTablEmty = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable2
		
	IF (@isSecondTablEmty= 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable1
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 27-May-18 13:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_UpdateAccount]
@userName NVARCHAR(100), @displayName NVARCHAR(100), @password NVARCHAR(100), @newPassword NVARCHAR(100)
AS
BEGIN
	DECLARE @isRightPass INT = 0
	
	SELECT @isRightPass = COUNT(*) FROM dbo.Account WHERE USERName = @userName AND PassWord = @password
	
	IF (@isRightPass = 1)
	BEGIN
		IF (@newPassword = NULL OR @newPassword = '')
		BEGIN
			UPDATE dbo.Account SET DisplayName = @displayName WHERE UserName = @userName
		END		
		ELSE
			UPDATE dbo.Account SET DisplayName = @displayName, PassWord = @newPassword WHERE UserName = @userName
	end
END
GO
USE [master]
GO
ALTER DATABASE [QuanLyQuanCafe] SET  READ_WRITE 
GO
