USE [master]
GO
/****** Object:  Database [FoodManagement]    Script Date: 3/12/2022 8:20:55 PM ******/
CREATE DATABASE [FoodManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FoodManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\FoodManagement.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FoodManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\FoodManagement_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [FoodManagement] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FoodManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FoodManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FoodManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FoodManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FoodManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FoodManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [FoodManagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FoodManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FoodManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FoodManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FoodManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FoodManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FoodManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FoodManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FoodManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FoodManagement] SET  ENABLE_BROKER 
GO
ALTER DATABASE [FoodManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FoodManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FoodManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FoodManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FoodManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FoodManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FoodManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FoodManagement] SET RECOVERY FULL 
GO
ALTER DATABASE [FoodManagement] SET  MULTI_USER 
GO
ALTER DATABASE [FoodManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FoodManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FoodManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FoodManagement] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FoodManagement] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FoodManagement] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'FoodManagement', N'ON'
GO
ALTER DATABASE [FoodManagement] SET QUERY_STORE = OFF
GO
USE [FoodManagement]
GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 3/12/2022 8:20:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategory](
	[categoryID] [varchar](10) NOT NULL,
	[categoryName] [varchar](50) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrder]    Script Date: 3/12/2022 8:20:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrder](
	[orderID] [varchar](100) NOT NULL,
	[orderDate] [date] NULL,
	[total] [int] NULL,
	[userID] [varchar](20) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrderDetail]    Script Date: 3/12/2022 8:20:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrderDetail](
	[detailID] [varchar](200) NOT NULL,
	[price] [float] NULL,
	[quantity] [int] NULL,
	[orderID] [varchar](100) NULL,
	[productID] [varchar](10) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[detailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProduct]    Script Date: 3/12/2022 8:20:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProduct](
	[productID] [varchar](10) NOT NULL,
	[productName] [varchar](50) NULL,
	[image] [varchar](2000) NULL,
	[price] [float] NULL,
	[quantity] [int] NULL,
	[categoryID] [varchar](10) NULL,
	[importDate] [date] NULL,
	[expiredDate] [date] NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRoles]    Script Date: 3/12/2022 8:20:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRoles](
	[roleID] [varchar](10) NOT NULL,
	[roleName] [varchar](20) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 3/12/2022 8:20:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsers](
	[userID] [varchar](20) NOT NULL,
	[fullName] [nvarchar](50) NULL,
	[password] [varchar](20) NULL,
	[roleID] [varchar](10) NULL,
	[address] [varchar](2000) NULL,
	[birthday] [date] NULL,
	[phone] [varchar](20) NULL,
	[email] [varchar](200) NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[tblCategory] ([categoryID], [categoryName], [status]) VALUES (N'CEREAL', N'Cereal', 1)
INSERT [dbo].[tblCategory] ([categoryID], [categoryName], [status]) VALUES (N'FRUIT', N'Fruit', 1)
INSERT [dbo].[tblCategory] ([categoryID], [categoryName], [status]) VALUES (N'VEGETABLE', N'Vegetable', 1)
GO
INSERT [dbo].[tblOrder] ([orderID], [orderDate], [total], [userID], [status]) VALUES (N'5b3f03aa-9072-48dc-ad52-10aff5b2abfe', CAST(N'2022-03-12' AS Date), 9, N'SE161202', 1)
INSERT [dbo].[tblOrder] ([orderID], [orderDate], [total], [userID], [status]) VALUES (N'6179a6ed-361c-452a-ab00-741687ba022f', CAST(N'2022-03-12' AS Date), 12, N'SE161202', 1)
INSERT [dbo].[tblOrder] ([orderID], [orderDate], [total], [userID], [status]) VALUES (N'7904f035-a310-45d7-83e2-15f082850b00', CAST(N'2022-03-12' AS Date), 42, N'SE161202', 1)
INSERT [dbo].[tblOrder] ([orderID], [orderDate], [total], [userID], [status]) VALUES (N'864a5174-7641-4361-ad0a-6f4d178515a7', CAST(N'2022-03-12' AS Date), 6, N'SE161202', 1)
GO
INSERT [dbo].[tblOrderDetail] ([detailID], [price], [quantity], [orderID], [productID], [status]) VALUES (N'5b3f03aa-9072-48dc-ad52-10aff5b2abfe-APPLE', 2, 2, N'5b3f03aa-9072-48dc-ad52-10aff5b2abfe', N'APPLE', 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [price], [quantity], [orderID], [productID], [status]) VALUES (N'5b3f03aa-9072-48dc-ad52-10aff5b2abfe-CARROT', 2.5, 2, N'5b3f03aa-9072-48dc-ad52-10aff5b2abfe', N'CARROT', 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [price], [quantity], [orderID], [productID], [status]) VALUES (N'6179a6ed-361c-452a-ab00-741687ba022f-BANANA', 6, 2, N'6179a6ed-361c-452a-ab00-741687ba022f', N'BANANA', 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [price], [quantity], [orderID], [productID], [status]) VALUES (N'7904f035-a310-45d7-83e2-15f082850b00-BANANA', 6, 2, N'7904f035-a310-45d7-83e2-15f082850b00', N'BANANA', 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [price], [quantity], [orderID], [productID], [status]) VALUES (N'7904f035-a310-45d7-83e2-15f082850b00-LEMON', 2, 10, N'7904f035-a310-45d7-83e2-15f082850b00', N'LEMON', 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [price], [quantity], [orderID], [productID], [status]) VALUES (N'7904f035-a310-45d7-83e2-15f082850b00-PEAR', 5, 2, N'7904f035-a310-45d7-83e2-15f082850b00', N'PEAR', 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [price], [quantity], [orderID], [productID], [status]) VALUES (N'864a5174-7641-4361-ad0a-6f4d178515a7-APPLE', 2, 3, N'864a5174-7641-4361-ad0a-6f4d178515a7', N'APPLE', 1)
GO
INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [expiredDate], [status]) VALUES (N'APPLE', N'Apples', N'https://www.collinsdictionary.com/images/full/apple_158989157.jpg?version=4.0.234', 2, 45, N'FRUIT', CAST(N'2022-03-01' AS Date), CAST(N'2022-04-09' AS Date), 1)
INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [expiredDate], [status]) VALUES (N'BANANA', N'Bananas', N'https://www.collinsdictionary.com/images/full/banana_64728013.jpg', 6, 196, N'FRUIT', CAST(N'2022-03-04' AS Date), CAST(N'2022-03-30' AS Date), 1)
INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [expiredDate], [status]) VALUES (N'CARROT', N'Carrots', N'https://everydayorganic.com.vn/data/news/3965/carot.02.jpg', 2.5, 298, N'VEGETABLE', CAST(N'2022-03-10' AS Date), CAST(N'2022-04-07' AS Date), 1)
INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [expiredDate], [status]) VALUES (N'LEMON', N'Lemons', N'https://cf.shopee.vn/file/2c3c7dbcd1da13ea86c66945067aa885', 2, 190, N'FRUIT', CAST(N'2022-03-03' AS Date), CAST(N'2022-04-06' AS Date), 1)
INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [expiredDate], [status]) VALUES (N'MANGO', N'Mangos', N'https://www.vietnamonline.com/media/uploads/froala_editor/images/VNO_Mango.jpg', 4, 100, N'FRUIT', CAST(N'2022-03-03' AS Date), CAST(N'2022-04-02' AS Date), 1)
INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [expiredDate], [status]) VALUES (N'ONION', N'Onions', N'https://produits.bienmanger.com/34833-0w600h600_Organic_Yellow_Onion.jpg', 2, 200, N'VEGETABLE', CAST(N'2022-03-10' AS Date), CAST(N'2022-04-01' AS Date), 1)
INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [expiredDate], [status]) VALUES (N'ORANGE', N'Oranges', N'http://riviste.newbusinessmedia.it/wp-content/uploads/sites/27/2013/12/Fotolia_11313277_M.jpg', 3, 50, N'FRUIT', CAST(N'2022-03-02' AS Date), CAST(N'2022-04-09' AS Date), 1)
INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [expiredDate], [status]) VALUES (N'PEAR', N'Pears', N'https://askthefoodgeek.com/wp-content/uploads/2017/02/pears-in-season.jpg', 5, 98, N'FRUIT', CAST(N'2022-03-11' AS Date), CAST(N'2022-04-09' AS Date), 1)
INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [expiredDate], [status]) VALUES (N'POTATO', N'Potatos', N'https://m.media-amazon.com/images/I/41rd9GEct2L.jpg', 2, 300, N'VEGETABLE', CAST(N'2022-03-10' AS Date), CAST(N'2022-04-09' AS Date), 1)
INSERT [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [expiredDate], [status]) VALUES (N'TOMATO', N'Tomatos', N'https://www.collinsdictionary.com/images/full/tomato_281240360.jpg', 3, 100, N'VEGETABLE', CAST(N'2022-03-10' AS Date), CAST(N'2022-04-09' AS Date), 1)
GO
INSERT [dbo].[tblRoles] ([roleID], [roleName], [status]) VALUES (N'AD', N'Admin', 1)
INSERT [dbo].[tblRoles] ([roleID], [roleName], [status]) VALUES (N'US', N'User', 1)
GO
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email], [status]) VALUES (N'SE161201', N'Nguyen Dang Khoa', N'123', N'US', N'HN', CAST(N'2003-06-24' AS Date), N'0123456789', N'khoa@gmail.com', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email], [status]) VALUES (N'SE161202', N'Mai Thanh Phuong', N'123', N'US', N'HN', CAST(N'2022-03-01' AS Date), N'1234567890', N'phuong@gmail.com', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email], [status]) VALUES (N'SE161203', N'Nguyen Dang Khoa', N'123', N'US', N'HCM', CAST(N'2002-07-04' AS Date), N'0903679090', N'dangkhoa0202@gmail.com', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email], [status]) VALUES (N'SE161204', N'Ngo Viet Tien', N'123', N'AD', N'HCM', CAST(N'2002-02-16' AS Date), N'0903678282', N'viettien1602@gmail.com', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email], [status]) VALUES (N'SE161205', N'Ngo Duc Viet', N'123', N'US', N'HCM', CAST(N'2002-02-16' AS Date), N'0903678280', N'ducviet1602@gmail.com', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email], [status]) VALUES (N'SE161206', N'Ngo Duc Hung', N'123', N'US', N'HCM', CAST(N'2002-02-16' AS Date), N'0903678280', N'duchung1602@gmail.com', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email], [status]) VALUES (N'SE161207', N'Ngo Duc Hung', N'123', N'US', N'HCM', CAST(N'2002-02-16' AS Date), N'0903678280', N'duchung1602@gmail.com', 1)
INSERT [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email], [status]) VALUES (N'SE161208', N'Thach Lien Ngoc Han', N'123', N'US', N'HCM', CAST(N'2006-07-17' AS Date), N'0123456789', N'han@gmail.com', 1)
GO
ALTER TABLE [dbo].[tblOrder]  WITH CHECK ADD FOREIGN KEY([userID])
REFERENCES [dbo].[tblUsers] ([userID])
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD FOREIGN KEY([orderID])
REFERENCES [dbo].[tblOrder] ([orderID])
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD FOREIGN KEY([productID])
REFERENCES [dbo].[tblProduct] ([productID])
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD FOREIGN KEY([categoryID])
REFERENCES [dbo].[tblCategory] ([categoryID])
GO
ALTER TABLE [dbo].[tblUsers]  WITH CHECK ADD FOREIGN KEY([roleID])
REFERENCES [dbo].[tblRoles] ([roleID])
GO
USE [master]
GO
ALTER DATABASE [FoodManagement] SET  READ_WRITE 
GO
