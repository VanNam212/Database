USE [Football]
GO
/****** Object:  Table [dbo].[Diem]    Script Date: 10/19/2019 8:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Diem](
	[LuotTran] [nchar](10) NOT NULL,
	[MaLop] [varchar](50) NOT NULL,
	[SoBanThang] [int] NULL,
	[SoBanThua] [int] NULL,
	[Diem] [int] NULL,
	[Bang] [nvarchar](50) NULL,
 CONSTRAINT [PK_Diem] PRIMARY KEY CLUSTERED 
(
	[LuotTran] ASC,
	[MaLop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DoiBong]    Script Date: 10/19/2019 8:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoiBong](
	[MaLop] [varchar](50) NOT NULL,
	[TenLop] [nvarchar](50) NULL,
	[SoLuongThanhVien] [int] NULL,
	[TrangThai] [nvarchar](50) NULL,
	[GhiChu] [nvarchar](50) NULL,
 CONSTRAINT [PK_DoiBong_1] PRIMARY KEY CLUSTERED 
(
	[MaLop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[BangDiem]    Script Date: 10/19/2019 8:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BangDiem](TenLop, SoDiem)
AS 
SELECT TenLop, SUM(Diem)
FROM Diem, DoiBong
WHERE Diem.MaLop = DoiBong.MaLop
GROUP BY TenLop
GO
/****** Object:  Table [dbo].[BanToChuc]    Script Date: 10/19/2019 8:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BanToChuc](
	[MaBanToChuc] [varchar](50) NOT NULL,
	[TenBanToChuc] [nvarchar](50) NULL,
 CONSTRAINT [PK_BanToChuc] PRIMARY KEY CLUSTERED 
(
	[MaBanToChuc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CauThu]    Script Date: 10/19/2019 8:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CauThu](
	[SoAoCauThu] [int] NOT NULL,
	[TenCauThu] [nvarchar](50) NULL,
	[MaLop] [varchar](50) NULL,
	[MaSinhVien] [nvarchar](50) NULL,
	[ViTri] [nvarchar](50) NULL,
	[SoBanGhiDuoc] [int] NULL,
	[Que] [nvarchar](550) NULL,
	[Email] [nvarchar](50) NULL,
	[SDT] [nvarchar](50) NULL,
 CONSTRAINT [PK_CauThu] PRIMARY KEY CLUSTERED 
(
	[SoAoCauThu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DoiBong_Tran]    Script Date: 10/19/2019 8:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoiBong_Tran](
	[LuotTran] [nchar](10) NOT NULL,
	[MaLop] [varchar](50) NOT NULL,
 CONSTRAINT [PK_DoiBong_Tran] PRIMARY KEY CLUSTERED 
(
	[LuotTran] ASC,
	[MaLop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DoiTruong]    Script Date: 10/19/2019 8:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoiTruong](
	[MaLop] [varchar](50) NOT NULL,
	[SoAoCauThu] [int] NOT NULL,
	[TenCauThu] [nvarchar](50) NULL,
	[MaSinhVien] [varchar](50) NULL,
	[SoDienThoai] [varchar](15) NULL,
 CONSTRAINT [PK_DoiTruong] PRIMARY KEY CLUSTERED 
(
	[MaLop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaiDau]    Script Date: 10/19/2019 8:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaiDau](
	[MaGiaiDau] [varchar](50) NOT NULL,
	[TenGiaiDau] [nvarchar](50) NULL,
	[MaBanToChuc] [varchar](50) NULL,
	[MuaGiai] [varchar](50) NULL,
 CONSTRAINT [PK_GiaiDau] PRIMARY KEY CLUSTERED 
(
	[MaGiaiDau] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaiDau_DoiBong]    Script Date: 10/19/2019 8:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaiDau_DoiBong](
	[MaGiaiDau] [varchar](50) NOT NULL,
	[MaLop] [varchar](50) NOT NULL,
 CONSTRAINT [PK_GiaiDau_DoiBong_1] PRIMARY KEY CLUSTERED 
(
	[MaGiaiDau] ASC,
	[MaLop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LichThiDau]    Script Date: 10/19/2019 8:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichThiDau](
	[LuotTran] [nchar](10) NOT NULL,
	[MaSan] [int] NOT NULL,
	[MaTrongTai] [varchar](50) NOT NULL,
	[ThongBao] [nvarchar](50) NULL,
	[MaThoiGian] [int] NULL,
 CONSTRAINT [PK_LichThiDau] PRIMARY KEY CLUSTERED 
(
	[LuotTran] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LuotTran]    Script Date: 10/19/2019 8:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LuotTran](
	[MaThoiGian] [int] NOT NULL,
	[ThoiGian] [datetime] NULL,
 CONSTRAINT [PK_LuotTran] PRIMARY KEY CLUSTERED 
(
	[MaThoiGian] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhaTaiTro]    Script Date: 10/19/2019 8:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaTaiTro](
	[MaNhaTaiTro] [varchar](50) NOT NULL,
	[TenNhaTaiTro] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[Hotline] [varchar](50) NULL,
	[Website] [varchar](50) NULL,
	[SoTienTaiTro] [money] NULL,
 CONSTRAINT [PK_NhaTaiTro] PRIMARY KEY CLUSTERED 
(
	[MaNhaTaiTro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhaTaiTro_GiaiDau]    Script Date: 10/19/2019 8:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaTaiTro_GiaiDau](
	[MaNhaTaiTro] [varchar](50) NOT NULL,
	[MaGiaiDau] [varchar](50) NOT NULL,
 CONSTRAINT [PK_NhaTaiTro_GiaiDau] PRIMARY KEY CLUSTERED 
(
	[MaNhaTaiTro] ASC,
	[MaGiaiDau] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanVanDong]    Script Date: 10/19/2019 8:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanVanDong](
	[MaSan] [int] NOT NULL,
	[TenSan] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[TienThueSan] [money] NULL,
 CONSTRAINT [PK_SanVanDong] PRIMARY KEY CLUSTERED 
(
	[MaSan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThanhVien]    Script Date: 10/19/2019 8:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThanhVien](
	[MaThanhVien] [varchar](50) NOT NULL,
	[MaBanToChuc] [varchar](50) NOT NULL,
	[TenThanhVien] [nvarchar](50) NULL,
	[ChucVu] [nvarchar](50) NULL,
	[SoDienThoai] [varchar](15) NULL,
	[Email] [varchar](50) NULL,
 CONSTRAINT [PK_ThanhVien] PRIMARY KEY CLUSTERED 
(
	[MaThanhVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrongTai]    Script Date: 10/19/2019 8:45:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrongTai](
	[MaTrongTai] [varchar](50) NOT NULL,
	[TenTrongTai] [nvarchar](50) NULL,
	[SoDienThoai] [varchar](15) NULL,
	[TienThueTrongTai] [money] NULL,
 CONSTRAINT [PK_TrongTai] PRIMARY KEY CLUSTERED 
(
	[MaTrongTai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[BanToChuc] ([MaBanToChuc], [TenBanToChuc]) VALUES (N'01', N'Khoa CNTT-Trường Đại học GTVT')
INSERT [dbo].[BanToChuc] ([MaBanToChuc], [TenBanToChuc]) VALUES (N'02', N'Khoa Công trình-Trường Đại học GTVT')
INSERT [dbo].[BanToChuc] ([MaBanToChuc], [TenBanToChuc]) VALUES (N'03', N'Khoa Cơ khí-Trường Đại học GTVT')
INSERT [dbo].[BanToChuc] ([MaBanToChuc], [TenBanToChuc]) VALUES (N'04', N'Khoa Vận tải kinh tế-Trường Đại học GTVT')
INSERT [dbo].[BanToChuc] ([MaBanToChuc], [TenBanToChuc]) VALUES (N'05', N'Khoa Quốc tế-Trường Đại học GTVT')
INSERT [dbo].[BanToChuc] ([MaBanToChuc], [TenBanToChuc]) VALUES (N'06', N'Khoa Quản lí xây dựng-Trường Đại học GTVT')
INSERT [dbo].[BanToChuc] ([MaBanToChuc], [TenBanToChuc]) VALUES (N'07', N'Khoa Điện - điện tử-Trường Đại học GTVT')
INSERT [dbo].[BanToChuc] ([MaBanToChuc], [TenBanToChuc]) VALUES (N'08', N'Khoa Kỹ thuật xây dựng-Trường Đại học GTVT')
INSERT [dbo].[BanToChuc] ([MaBanToChuc], [TenBanToChuc]) VALUES (N'09', N'Khoa MT và an toàn giao thông -Trường Đại học GTVT')
INSERT [dbo].[BanToChuc] ([MaBanToChuc], [TenBanToChuc]) VALUES (N'10', N'Khoa Cơ bản-Trường Đại học GTVT')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (0, N'x', N'001', NULL, N'Thủ môn', 0, NULL, NULL, NULL)
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (1, N'Nguyễn Văn Duy', N'013', NULL, N'Tiền vệ phòng ngự', 10, N'Hưng Yên', N'NguyenVanDuy	@gmail.com', N'0901234718')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (2, N'Đặng Trung Đức', N'013', NULL, N'Trung vệ', 0, N'Bình Thuận', N'DangTrungDuc	@gmail.com', N'0901234577')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (3, N'Vũ Văn Dương', N'013', NULL, N'Tiền đạo', 0, N'Kiên Giang', N'VuVanDuong	@gmail.com', N'0901234720')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (4, N'Ngô Công Tráng', N'008', NULL, N'Thủ môn', 0, N'Bình Định', N'NgoCongTrang	@gmail.com', N'0901234700')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (5, N'Hà Công Tuấn Anh', N'004', NULL, N'Hậu vệ trái', 0, N'Điện Biên', N'HaCongAnh	@gmail.com', N'0901234708')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (6, N'Lê Đức Anh', N'004', NULL, N'Trung vệ', 0, N'Sơn La', N'LeDucAnh	@gmail.com', N'0901234612')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (7, N'Lê Hoàng Anh', N'008', NULL, N'Tiền đạo', 0, N'Nam Định', N'LeHoangAnh	@gmail.com', N'0901234664')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (8, N'Ngô Văn Anh', N'001', NULL, N'Hậu vệ phải', 0, N'Đồng Nai', N'NgoVanAnh	@gmail.com', N'0901234709')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (9, N'Nguyễn Ngọc Anh', N'001', NULL, N'Tiền vệ phòng ngự', 0, N'Tây Ninh', N'NguyenNgocAnh	@gmail.com', N'0901234613')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (10, N'Nguyễn Tuấn Anh', N'004', NULL, N'Trung vệ', 0, N'Đồng Tháp', N'NguyenTuanAnh	@gmail.com', N'0901234710')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (11, N'Nguyễn Vân Anh', N'001', NULL, N'Thủ môn', 0, N'An Giang', N'NguyenVanAnh	@gmail.com', N'0901234567')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (12, N'Phạm Văn Anh', N'008', NULL, N'Thủ môn', 0, N'Nghệ An', N'PhamVanAnh	@gmail.com', N'0901234665')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (13, N'Ngô Thị Ba', N'008', NULL, N'Hậu vệ trái', 0, N'Bà Rịa - Vũng Tàu', N'NgoThiBa	@gmail.com', N'0901234568')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (14, N'Đinh Đức Bảo', N'004', NULL, N'Tiền vệ phòng ngự', 0, N'Thái Bình', N'DinhDucBao	@gmail.com', N'0901234614')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (15, N'Nguyễn Đức Bằng', N'001', NULL, N'Tiền vệ phòng ngự', 0, N'Gia Lai', N'NguyenDucBang	@gmail.com', N'0901234711')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (16, N'Nguyễn Hữu Bắc', N'008', NULL, N'Tiền vệ phòng ngự', 0, N'Bắc Giang', N'NguyenHuuBac	@gmail.com', N'0901234569')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (17, N'Phạm Thanh Bình', N'001', NULL, N'Tiền vệ phòng ngự', 0, N'Thái Nguyên', N'PhamThanhBinh	@gmail.com', N'0901234615')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (18, N'Phan Thị Ngọc Bích', N'001', NULL, N'Hậu vệ trái', 0, N'Ninh Bình', N'PhanThiBich	@gmail.com', N'0901234666')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (19, N'Trần Quốc Bộ', N'008', NULL, N'Tiền vệ trung tâm', 0, N'Hà Giang', N'TranQuocBo	@gmail.com', N'0901234712')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (20, N'Lưu Thị Chiên', N'008', NULL, N'Tiền vệ phòng ngự', 0, N'Thanh Hóa', N'LuuThiChien	@gmail.com', N'0901234616')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (21, N'Lê Xuân Chiến', N'008', NULL, N'Tiền đạo', 0, N'Hà Nam', N'LeXuanChien	@gmail.com', N'0901234713')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (22, N'Bùi Thị Tuyết Chinh', N'008', NULL, N'Hậu vệ trái', 0, N'Thừa Thiên Huế', N'BuiThiChinh	@gmail.com', N'0901234617')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (23, N'Trần Minh Chính', N'004', NULL, N'Tiền vệ phòng ngự', 0, N'Ninh Thuận', N'TranMinhChinh	@gmail.com', N'0901234667')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (24, N'Dương Thị Chúc', N'001', NULL, N'Thủ môn', 0, N'Hà Tĩnh', N'DuongThiChuc	@gmail.com', N'0901234714')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (25, N'Nguyễn Thị Cúc', N'001', NULL, N'Hậu vệ phải', 0, N'Tiền Giang', N'NguyenThiCuc	@gmail.com', N'0901234618')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (26, N'Lê Kim Cường', N'008', NULL, N'Trung vệ', 0, N'Phú Thọ', N'LeKimCuong	@gmail.com', N'0901234668')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (27, N'Hoàng Văn Cương', N'004', NULL, N'Tiền vệ phòng ngự', 0, N'Hải Dương', N'HoangVanCuong	@gmail.com', N'0901234715')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (28, N'Phạm Duy Cương', N'001', NULL, N'Trung vệ', 0, N'Bắc Kạn', N'PhamDuyCuong	@gmail.com', N'0901234570')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (29, N'Trần Văn Diện', N'004', NULL, N'Tiền vệ phòng ngự', 0, N'Trà Vinh', N'TranVanDien	@gmail.com', N'0901234619')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (30, N'Vũ Quốc Doanh', N'013', NULL, N'Hậu vệ phải', 0, N'Hậu Giang', N'VuQuocDoanh	@gmail.com', N'0901234716')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (31, N'Bùi Gia Duy', N'008', NULL, N'Tiền vệ trung tâm', 0, N'Bắc Ninh', N'BuiGiaDuy	@gmail.com', N'0901234572')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (32, N'Nguyễn Khánh Duy', N'013', NULL, N'Tiền vệ phòng ngự', 0, N'Quảng Bình', N'NguyenKhanhDuy	@gmail.com', N'0901234669')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (33, N'Nguyễn Thành Duy', N'008', NULL, N'Trung vệ', 0, N'Hòa Bình', N'NguyenThanhDuy	@gmail.com', N'0901234717')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (34, N'Nguyễn Văn Duy', N'013', NULL, N'Tiền đạo', 0, N'Bến Tre', N'NguyenVanDuy	@gmail.com', N'0901234573')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (35, N'Trần Lê Duy', N'009', NULL, N'Tiền vệ trung tâm', 0, N'Vĩnh Long', N'TranLeDuy	@gmail.com', N'0901234621')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (36, N'Trần Văn Duy', N'013', NULL, N'Tiền vệ trung tâm', 0, N'Quảng Nam', N'TranVanDuy	@gmail.com', N'0901234670')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (37, N'Lê Thị Duyên', N'009', NULL, N'Tiền vệ trung tâm', 0, N'Khánh Hòa', N'LeThiDuyen	@gmail.com', N'0901234719')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (38, N'Nguyễn Bá Dũng', N'013', NULL, N'Tiền vệ phòng ngự', 0, N'Bạc Liêu', N'NguyenBaDung	@gmail.com', N'0901234571')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (39, N'Nguyễn Hữu Dũng', N'009', NULL, N'Tiền vệ phòng ngự', 0, N'Tuyên Quang', N'NguyenHuuDung	@gmail.com', N'0901234620')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (40, N'Trần Thị Thuỳ Dương', N'013', NULL, N'Thủ môn', 0, N'Quảng Ninh', N'TranThiDuong	@gmail.com', N'0901234672')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (41, N'Lê Thị Đào', N'013', NULL, N'Thủ môn', 0, N'Kon Tum', N'LeThiDao	@gmail.com', N'0901234721')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (42, N'Bùi Công Đại', N'004', NULL, N'Tiền vệ phòng ngự', 0, N'Bình Định', N'BuiCongDai	@gmail.com', N'0901234574')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (43, N'Lê Quang Đạo', N'004', NULL, N'Tiền vệ phòng ngự', 0, N'Vĩnh Phúc', N'LeQuangDao	@gmail.com', N'0901234622')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (44, N'Nguyễn Hoàng Đạo', N'014', NULL, N'Hậu vệ trái', 0, N'Quảng Trị', N'NguyenHoangDao	@gmail.com', N'0901234673')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (45, N'Nguyễn Quang Đạt', N'014', NULL, N'Hậu vệ trái', 0, N'Lai Châu', N'NguyenQuangDat	@gmail.com', N'0901234722')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (46, N'Phan Quốc Đạt', N'004', NULL, N'Tiền vệ phòng ngự', 0, N'Bình Dương', N'PhanQuocDat	@gmail.com', N'0901234575')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (47, N'Trần Tiến Đạt', N'009', NULL, N'Thủ môn', 0, N'Yên Bái', N'TranTienDat	@gmail.com', N'0901234623')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (48, N'Hoàng Thị Định', N'004', NULL, N'Hậu vệ phải', 0, N'Lâm Đồng', N'HoangThiDinh	@gmail.com', N'0901234723')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (49, N'Vũ Thuý Đoan', N'014', NULL, N'Hậu vệ phải', 0, N'Bình Phước', N'VuThuyDoan	@gmail.com', N'0901234576')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (50, N'Đỗ Đức Độ', N'014', NULL, N'Hậu vệ phải', 0, N'Sóc Trăng', N'DoDucDo	@gmail.com', N'0901234674')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (51, N'Nguyễn Mạnh Đức', N'004', NULL, N'Trung vệ', 0, N'Lạng Sơn', N'NguyenManhDuc	@gmail.com', N'0901234724')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (52, N'Phạm Thị Hương Giang', N'001', NULL, N'Tiền vệ phòng ngự', 0, N'Lào Cai', N'PhamThiGiang	@gmail.com', N'0901234725')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (53, N'Nguyễn Hoàng Hải', N'014', NULL, N'Hậu vệ phải', 0, N'Cần Thơ', N'NguyenHoangHai	@gmail.com', N'0901234625')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (54, N'Phạm Văn Hậu', N'005', NULL, N'Tiền vệ trung tâm', 0, N'Long An', N'PhamVanHau	@gmail.com', N'0901234726')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (55, N'Lê Thị Hiền', N'014', NULL, N'Tiền vệ phòng ngự', 0, N'Cà Mau', N'LeThiHien	@gmail.com', N'0901234578')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (56, N'Nguyễn Thị Thu Hiền', N'014', NULL, N'Trung vệ', 0, N'Đà Nẵng', N'NguyenThiHien	@gmail.com', N'0901234626')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (57, N'Vũ Thị Thu Hiền', N'005', NULL, N'Tiền vệ phòng ngự', 0, N'Sơn La', N'VuThiHien	@gmail.com', N'0901234675')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (58, N'Nguyễn Đức Hiếu', N'005', NULL, N'Tiền vệ phòng ngự', 0, N'Cao Bằng', N'NguyenDucHieu	@gmail.com', N'0901234579')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (59, N'Vũ Xuân Hiếu', N'001', NULL, N'Tiền đạo', 0, N'Nam Định', N'VuXuanHieu	@gmail.com', N'0901234727')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (60, N'Nguyễn Thị Hoà', N'009', NULL, N'Thủ môn', 0, N'Nghệ An', N'NguyenThiHoa	@gmail.com', N'0901234728')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (61, N'Lâm Văn Hoàn', N'005', NULL, N'Tiền đạo', 0, N'Đắk Lắk', N'LamVanHoan	@gmail.com', N'0901234580')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (62, N'Nguyễn Thái Học', N'005', NULL, N'Tiền vệ phòng ngự', 0, N'Hải Phòng', N'NguyenThaiHoc	@gmail.com', N'0901234627')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (63, N'Lê Thị Hồng', N'001', NULL, N'Tiền vệ trung tâm', 0, N'Thái Bình', N'LeThiHong	@gmail.com', N'0901234677')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (64, N'Từ Tất Huân', N'009', NULL, N'Hậu vệ trái', 0, N'Ninh Bình', N'TuTatHuan	@gmail.com', N'0901234729')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (65, N'Nguyễn Thị Huế', N'005', NULL, N'Hậu vệ trái', 0, N'Điện Biên', N'NguyenThiHue	@gmail.com', N'0901234582')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (66, N'Vũ Thị Thu Huệ', N'005', NULL, N'Tiền vệ trung tâm', 0, N'Hà Nội', N'VuThiHue	@gmail.com', N'0901234628')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (67, N'Dương Đình Đức Huy', N'005', NULL, N'Tiền đạo', 0, N'Thái Nguyên', N'DuongDinhHuy	@gmail.com', N'0901234678')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (68, N'Lê Thế Huy', N'002', NULL, N'Hậu vệ phải', 0, N'Ninh Thuận', N'LeTheHuy	@gmail.com', N'0901234730')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (69, N'Nguyễn Đức Huy', N'002', NULL, N'Thủ môn', 0, N'Thanh Hóa', N'NguyenDucHuy	@gmail.com', N'0901234679')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (70, N'Nguyễn Quang Huy', N'014', NULL, N'Trung vệ', 0, N'Phú Thọ', N'NguyenQuangHuy	@gmail.com', N'0901234731')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (71, N'Lưu Thị Kim Huyền', N'002', NULL, N'Hậu vệ trái', 0, N'Bà Rịa - Vũng Tàu', N'LuuThiHuyen	@gmail.com', N'0901234631')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (72, N'Vũ Thị Thu Hiền', N'005', NULL, N'Tiền vệ phòng ngự', 0, N'Tây Ninh', N'VuThiHien	@gmail.com', N'0901234676')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (73, N'Trần Mạnh Hùng', N'005', NULL, N'Thủ môn', 0, N'An Giang', N'TranManhHung	@gmail.com', N'0901234630')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (74, N'Nguyễn Thị Hương', N'009', NULL, N'Hậu vệ trái', 0, N'Thừa Thiên Huế', N'NguyenThiHuong	@gmail.com', N'0901234680')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (75, N'Nguyễn Thị Hương', N'009', NULL, N'Tiền vệ phòng ngự', 0, N'Quảng Bình', N'NguyenThiHuong	@gmail.com', N'0901234732')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (76, N'Nguyễn Thị Hương', N'002', NULL, N'Hậu vệ phải', 0, N'Đồng Nai', N'NguyenThiHuong	@gmail.com', N'0901234583')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (77, N'Phạm Văn Khang', N'009', NULL, N'Hậu vệ phải', 0, N'Bắc Giang', N'PhamVanKhang	@gmail.com', N'0901234632')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (78, N'Nguyễn Ngọc Khánh', N'009', NULL, N'Tiền vệ trung tâm', 0, N'Quảng Nam', N'NguyenNgocKhanh	@gmail.com', N'0901234733')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (79, N'Nguyễn Đức Khôi', N'009', NULL, N'Tiền vệ phòng ngự', 0, N'Gia Lai', N'NguyenDucKhoi	@gmail.com', N'0901234585')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (80, N'Ngô Trung Kiên', N'009', NULL, N'Hậu vệ phải', 0, N'Tiền Giang', N'NgoTrungKien	@gmail.com', N'0901234681')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (81, N'Trương Thị Lan', N'002', NULL, N'Tiền vệ trung tâm', 0, N'Hà Giang', N'TruongThiLan	@gmail.com', N'0901234586')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (82, N'Nguyễn Thị Là', N'010', NULL, N'Trung vệ', 0, N'Bắc Kạn', N'NguyenThiLa	@gmail.com', N'0901234633')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (83, N'Lê Văn Lâm', N'002', NULL, N'Trung vệ', 0, N'Trà Vinh', N'LeVanLam	@gmail.com', N'0901234682')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (84, N'Nguyễn Tùng Lâm', N'014', NULL, N'Tiền đạo', 0, N'Quảng Ngãi', N'NguyenTungLam	@gmail.com', N'0901234734')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (85, N'Lương Tuấn Linh', N'005', NULL, N'Tiền vệ phòng ngự', 0, N'Bạc Liêu', N'LuongTuanLinh	@gmail.com', N'0901234634')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (86, N'Nguyễn Khánh Linh', N'005', NULL, N'Tiền vệ phòng ngự', 0, N'Tuyên Quang', N'NguyenKhanhLinh	@gmail.com', N'0901234683')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (87, N'Nguyễn Văn Linh', N'010', NULL, N'Thủ môn', 0, N'Quảng Ninh', N'NguyenVanLinh	@gmail.com', N'0901234735')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (88, N'Nguyễn Hoàn Long', N'014', NULL, N'Tiền vệ trung tâm', 0, N'Bắc Ninh', N'NguyenHoanLong	@gmail.com', N'0901234635')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (89, N'Kiều Thị Lụa', N'014', NULL, N'Tiền đạo', 0, N'Hà Nam', N'KieuThiLua	@gmail.com', N'0901234587')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (90, N'Nguyễn Trọng Lực', N'010', NULL, N'Tiền đạo', 0, N'Bến Tre', N'NguyenTrongLuc	@gmail.com', N'0901234636')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (91, N'Nguyễn Văn Lực', N'010', NULL, N'Tiền vệ trung tâm', 0, N'Vĩnh Long', N'NguyenVanLuc	@gmail.com', N'0901234684')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (92, N'Tạ Quang Lực', N'014', NULL, N'Hậu vệ trái', 0, N'Quảng Trị', N'TaQuangLuc	@gmail.com', N'0901234736')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (93, N'Lưu Thị Thảo Ly', N'010', NULL, N'Thủ môn', 0, N'Hà Tĩnh', N'LuuThiLy	@gmail.com', N'0901234588')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (94, N'Lê Thị Mai', N'010', NULL, N'Thủ môn', 0, N'Bình Định', N'LeThiMai	@gmail.com', N'0901234637')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (95, N'Nguyễn Thị Mai', N'015', NULL, N'Thủ môn', 0, N'Yên Bái', N'NguyenThiMai	@gmail.com', N'0901234686')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (96, N'Phan Văn Mạnh', N'015', NULL, N'Hậu vệ trái', 0, N'Bình Dương', N'PhanVanManh	@gmail.com', N'0901234638')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (97, N'Đào Trần Minh', N'015', NULL, N'Hậu vệ phải', 0, N'Sóc Trăng', N'DaoTranMinh	@gmail.com', N'0901234737')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (98, N'Nguyễn Quang Minh', N'010', NULL, N'Hậu vệ phải', 0, N'Bình Phước', N'NguyenQuangMinh	@gmail.com', N'0901234639')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (99, N'Vũ Tiến Minh', N'015', NULL, N'Trung vệ', 0, N'Sơn La', N'VuTienMinh	@gmail.com', N'0901234738')
GO
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (100, N'Nguyễn Đức Nam', N'015', NULL, N'Trung vệ', 0, N'Bình Thuận', N'NguyenDucNam	@gmail.com', N'0901234640')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (101, N'Vũ Thị Nga', N'010', NULL, N'Hậu vệ trái', 0, N'Hải Dương', N'VuThiNga	@gmail.com', N'0901234589')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (102, N'Nguyễn Thị Ngân', N'006', NULL, N'Tiền vệ phòng ngự', 0, N'Cà Mau', N'NguyenThiNgan	@gmail.com', N'0901234641')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (103, N'Nguyễn Anh Ngọc', N'010', NULL, N'Hậu vệ trái', 0, N'Phú Yên', N'NguyenAnhNgoc	@gmail.com', N'0901234687')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (104, N'Phạm Thị Ngọc', N'006', NULL, N'Tiền vệ trung tâm', 0, N'Thái Bình', N'PhamThiNgoc	@gmail.com', N'0901234740')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (105, N'Nguyễn Thị Nhàn', N'015', NULL, N'Tiền vệ phòng ngự', 0, N'Cao Bằng', N'NguyenThiNhan	@gmail.com', N'0901234642')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (106, N'Phạm Thị Nhung', N'006', NULL, N'Tiền đạo', 0, N'Đắk Lắk', N'PhamThiNhung	@gmail.com', N'0901234643')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (107, N'Phạm Thị Nhung', N'015', NULL, N'Hậu vệ phải', 0, N'Cần Thơ', N'PhamThiNhung	@gmail.com', N'0901234688')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (108, N'Đỗ Minh Phong', N'010', NULL, N'Tiền đạo', 0, N'Thái Nguyên', N'DoMinhPhong	@gmail.com', N'0901234741')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (109, N'Hoàng Minh Phong', N'015', NULL, N'Hậu vệ phải', 0, N'Hậu Giang', N'HoangMinhPhong	@gmail.com', N'0901234590')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (110, N'Nguyễn Quốc Phong', N'006', NULL, N'Thủ môn', 0, N'Đắk Nông', N'NguyenQuocPhong	@gmail.com', N'0901234644')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (111, N'Phùng Thị Phương', N'015', NULL, N'Trung vệ', 0, N'Hòa Bình', N'PhungThiPhuong	@gmail.com', N'0901234591')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (112, N'Chu Văn Quang', N'002', NULL, N'Hậu vệ trái', 0, N'Điện Biên', N'ChuVanQuang	@gmail.com', N'0901234645')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (113, N'Nguyễn Trung Quy', N'015', NULL, N'Trung vệ', 0, N'Đà Nẵng', N'NguyenTrungQuy	@gmail.com', N'0901234689')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (114, N'Đồng Viết Quyền', N'002', NULL, N'Thủ môn', 0, N'Thanh Hóa', N'DongVietQuyen	@gmail.com', N'0901234742')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (115, N'Nguyễn Thị Quỳnh', N'002', NULL, N'Tiền vệ phòng ngự', 0, N'Hưng Yên', N'NguyenThiQuynh	@gmail.com', N'0901234592')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (116, N'Nguyễn Văn Quý', N'006', NULL, N'Hậu vệ phải', 0, N'Đồng Nai', N'NguyenVanQuy	@gmail.com', N'0901234646')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (117, N'Nguyễn Hữu Sử', N'016', NULL, N'Tiền đạo', 0, N'Kiên Giang', N'NguyenHuuSu	@gmail.com', N'0901234594')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (118, N'Đỗ Hồng Sơn', N'006', NULL, N'Tiền vệ phòng ngự', 0, N'Gia Lai', N'DoHongSon	@gmail.com', N'0901234648')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (119, N'Vũ Hồng Sơn', N'002', NULL, N'Hậu vệ trái', 0, N'Thừa Thiên Huế', N'VuHongSon	@gmail.com', N'0901234743')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (120, N'Vũ Văn Sơn', N'016', NULL, N'Tiền vệ trung tâm', 0, N'Khánh Hòa', N'VuVanSon	@gmail.com', N'0901234593')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (121, N'Đào Kỳ Thanh', N'010', NULL, N'Trung vệ', 0, N'Trà Vinh', N'DaoKyThanh	@gmail.com', N'0901234745')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (122, N'Đỗ Chí Thanh', N'006', NULL, N'Thủ môn', 0, N'Kon Tum', N'DoChiThanh	@gmail.com', N'0901234595')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (123, N'Phạm Duy Thanh', N'011', NULL, N'Tiền vệ trung tâm', 0, N'Hà Giang', N'PhamDuyThanh	@gmail.com', N'0901234649')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (124, N'Lê Tất Thành', N'006', NULL, N'Tiền vệ phòng ngự', 0, N'Tuyên Quang', N'LeTatThanh	@gmail.com', N'0901234746')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (125, N'Nguyễn Văn Thành', N'006', NULL, N'Hậu vệ trái', 0, N'Lai Châu', N'NguyenVanThanh	@gmail.com', N'0901234596')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (126, N'Nguyễn Thị Thu Thảo', N'006', NULL, N'Tiền vệ trung tâm', 0, N'Hà Nội', N'NguyenThiThao	@gmail.com', N'0901234691')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (127, N'Lê Bá Thái', N'011', NULL, N'Hậu vệ phải', 0, N'Tiền Giang', N'LeBaThai	@gmail.com', N'0901234744')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (128, N'Hoàng Ngọc Thắng', N'006', NULL, N'Trung vệ', 0, N'Lạng Sơn', N'HoangNgocThang	@gmail.com', N'0901234598')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (129, N'Nguyễn Huy Thắng', N'002', NULL, N'Tiền đạo', 0, N'Hà Nam', N'NguyenHuyThang	@gmail.com', N'0901234650')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (130, N'Nguyễn Văn Thế', N'016', NULL, N'Thủ môn', 0, N'Hà Tĩnh', N'NguyenVanThe	@gmail.com', N'0901234651')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (131, N'Bạch Văn Thịnh', N'002', NULL, N'Tiền vệ phòng ngự', 0, N'Lào Cai', N'BachVanThinh	@gmail.com', N'0901234599')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (132, N'Đỗ Hữu Thịnh', N'011', NULL, N'Hậu vệ trái', 0, N'Hải Dương', N'DoHuuThinh	@gmail.com', N'0901234652')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (133, N'Trương Văn Thịnh', N'007', NULL, N'Tiền đạo', 0, N'TP HCM', N'TruongVanThinh	@gmail.com', N'0901234692')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (134, N'Mạc Thị Thu', N'011', NULL, N'Tiền vệ phòng ngự', 0, N'Vĩnh Phúc', N'MacThiThu	@gmail.com', N'0901234748')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (135, N'Nguyễn Thị Thu', N'011', NULL, N'Tiền vệ trung tâm', 0, N'Long An', N'NguyenThiThu	@gmail.com', N'0901234600')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (136, N'Nguyễn Thị Hoài Thu', N'011', NULL, N'Hậu vệ phải', 0, N'Hậu Giang', N'NguyenThiThu	@gmail.com', N'0901234653')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (137, N'Nguyễn Văn Thuân', N'006', NULL, N'Hậu vệ trái', 0, N'Bà Rịa - Vũng Tàu', N'NguyenVanThuan	@gmail.com', N'0901234694')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (138, N'Vũ Văn Thủy', N'011', NULL, N'Thủ môn', 0, N'Yên Bái', N'VuVanThuy	@gmail.com', N'0901234749')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (139, N'Lê Thị Thư', N'011', NULL, N'Tiền đạo', 0, N'Nam Định', N'LeThiThu	@gmail.com', N'0901234601')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (140, N'Quách Anh Thư', N'016', NULL, N'Trung vệ', 0, N'Hòa Bình', N'QuachAnhThu	@gmail.com', N'0901234654')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (141, N'Đặng Thị Thơm', N'003', NULL, N'Thủ môn', 0, N'An Giang', N'DangThiThom	@gmail.com', N'0901234693')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (142, N'Lương Hoàng Tiến', N'011', NULL, N'Hậu vệ phải', 0, N'Cần Thơ', N'LuongHoangTien	@gmail.com', N'0901234751')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (143, N'Nguyễn Ngọc Tiến', N'003', NULL, N'Thủ môn', 0, N'Nghệ An', N'NguyenNgocTien	@gmail.com', N'0901234602')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (144, N'Mai Thị Tình', N'011', NULL, N'Trung vệ', 0, N'Bắc Kạn', N'MaiThiTinh	@gmail.com', N'0901234696')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (145, N'Nguyễn Văn Toàn', N'012', NULL, N'Tiền vệ phòng ngự', 0, N'Bạc Liêu', N'NguyenVanToan	@gmail.com', N'0901234697')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (146, N'Đỗ Thị Huyền Trang', N'016', NULL, N'Trung vệ', 0, N'Đà Nẵng', N'DoThiTrang	@gmail.com', N'0901234752')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (147, N'Nguyễn Huyền Trang', N'012', NULL, N'Hậu vệ phải', 0, N'Ninh Thuận', N'NguyenHuyenTrang	@gmail.com', N'0901234604')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (148, N'Nguyễn Thị Trang', N'012', NULL, N'Tiền vệ phòng ngự', 0, N'Hưng Yên', N'NguyenThiTrang	@gmail.com', N'0901234655')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (149, N'Nguyễn Thị Trang', N'016', NULL, N'Tiền đạo', 0, N'Bến Tre', N'NguyenThiTrang	@gmail.com', N'0901234699')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (150, N'Vũ Thị Huyền Trang', N'012', NULL, N'Trung vệ', 0, N'Phú Thọ', N'VuThiTrang	@gmail.com', N'0901234605')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (151, N'Lê Thị Trà', N'003', NULL, N'Tiền vệ trung tâm', 0, N'Bắc Ninh', N'LeThiTra	@gmail.com', N'0901234698')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (152, N'Dương Công Tráng', N'016', NULL, N'Tiền vệ phòng ngự', 0, N'Hải Phòng', N'DuongCongTrang	@gmail.com', N'0901234753')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (153, N'Nguyễn Đức Trung', N'016', NULL, N'Tiền đạo', 0, N'Kiên Giang', N'NguyenDucTrung	@gmail.com', N'0901234657')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (154, N'Nguyễn Văn Trung', N'016', NULL, N'Tiền vệ trung tâm', 0, N'Hà Nội', N'NguyenVanTrung	@gmail.com', N'0901234754')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (155, N'Trần Quang Trung', N'016', NULL, N'Tiền vệ phòng ngự', 0, N'Quảng Bình', N'TranQuangTrung	@gmail.com', N'0901234606')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (156, N'Trịnh Thị Trung', N'016', NULL, N'Thủ môn', 0, N'Kon Tum', N'TrinhThiTrung	@gmail.com', N'0901234658')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (157, N'Trần Văn Trường', N'007', NULL, N'Tiền đạo', 0, N'TP HCM', N'TranVanTruong	@gmail.com', N'0901234755')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (158, N'Đỗ Đức Tuấn', N'007', NULL, N'Hậu vệ trái', 0, N'Lai Châu', N'DoDucTuan	@gmail.com', N'0901234659')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (159, N'Nguyễn Anh Tuấn', N'016', NULL, N'Hậu vệ phải', 0, N'Bình Phước', N'NguyenAnhTuan	@gmail.com', N'0901234702')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (160, N'Nguyễn Quang Tuấn', N'003', NULL, N'Hậu vệ trái', 0, N'Bà Rịa - Vũng Tàu', N'NguyenQuangTuan	@gmail.com', N'0901234757')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (161, N'Nguyễn Quang Tuấn', N'012', NULL, N'Tiền vệ trung tâm', 0, N'Quảng Nam', N'NguyenQuangTuan	@gmail.com', N'0901234607')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (162, N'Nguyễn Quang Tuấn', N'007', NULL, N'Hậu vệ phải', 0, N'Lâm Đồng', N'NguyenQuangTuan	@gmail.com', N'0901234660')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (163, N'Nguyễn Văn Tuấn', N'012', NULL, N'Trung vệ', 0, N'Bình Thuận', N'NguyenVanTuan	@gmail.com', N'0901234703')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (164, N'Nguyễn Văn Tuấn', N'007', NULL, N'Hậu vệ phải', 0, N'Bắc Giang', N'NguyenVanTuan	@gmail.com', N'0901234758')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (165, N'Đàm Quang Tuyển', N'017', NULL, N'Tiền vệ trung tâm', 0, N'Cao Bằng', N'DamQuangTuyen	@gmail.com', N'0901234705')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (166, N'Đoàn Văn Tuyến', N'003', NULL, N'Tiền vệ phòng ngự', 0, N'Bạc Liêu', N'DoanVanTuyen	@gmail.com', N'0901234760')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (167, N'Lê Thanh Tùng', N'017', NULL, N'Tiền đạo', 0, N'Quảng Ngãi', N'LeThanhTung	@gmail.com', N'0901234608')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (168, N'Nguyễn Thanh Tùng', N'017', NULL, N'Tiền vệ phòng ngự', 0, N'Cà Mau', N'NguyenThanhTung	@gmail.com', N'0901234704')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (169, N'Nguyễn Thanh Tùng', N'007', NULL, N'Trung vệ', 0, N'Bắc Kạn', N'NguyenThanhTung	@gmail.com', N'0901234759')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (170, N'Vũ Mạnh Tùng', N'003', NULL, N'Trung vệ', 0, N'Lạng Sơn', N'VuManhTung	@gmail.com', N'0901234661')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (171, N'Nguyễn Thị Tú', N'012', NULL, N'Hậu vệ trái', 0, N'Bình Dương', N'NguyenThiTu	@gmail.com', N'0901234701')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (172, N'Tạ Quang Tú', N'007', NULL, N'Thủ môn', 0, N'An Giang', N'TaQuangTu	@gmail.com', N'0901234756')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (173, N'Lê Thị Tố Uyên', N'017', NULL, N'Thủ môn', 0, N'Quảng Ninh', N'LeThiUyen	@gmail.com', N'0901234609')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (174, N'Đỗ Trung Văn', N'007', NULL, N'Tiền vệ phòng ngự', 0, N'Lào Cai', N'DoTrungVan	@gmail.com', N'0901234662')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (175, N'Nguyễn Thị Vân', N'017', NULL, N'Tiền đạo', 0, N'Đắk Lắk', N'NguyenThiVan	@gmail.com', N'0901234706')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (176, N'Nguyễn Bá Việt', N'017', NULL, N'Hậu vệ trái', 0, N'Quảng Trị', N'NguyenBaViet	@gmail.com', N'0901234610')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (177, N'Nguyễn Trọng Vinh', N'007', NULL, N'Thủ môn', 0, N'Đắk Nông', N'NguyenTrongVinh	@gmail.com', N'0901234707')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (178, N'Đinh Ngọc Vũ', N'007', NULL, N'Tiền vệ trung tâm', 0, N'Bắc Ninh', N'DinhNgocVu	@gmail.com', N'0901234761')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (179, N'Phạm Tuấn Vũ', N'007', NULL, N'Hậu vệ phải', 0, N'Sóc Trăng', N'PhamTuanVu	@gmail.com', N'0901234611')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (180, N'Tống Thị Hải Yến', N'003', NULL, N'Tiền vệ trung tâm', 0, N'Long An', N'TongThiYen	@gmail.com', N'0901234663')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (181, N'Nguyễn Thị Thùy Dương', N'012', NULL, N'Tiền đạo', 0, N'Quảng Ngãi', N'NguyenThiDuong	@gmail.com', N'0901234671')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (182, N'Hồ Sỹ Hoàng', N'003', NULL, N'Thủ môn', 0, N'Đắk Nông', N'HoSyHoang	@gmail.com', N'0901234581')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (183, N'Nguyễn Văn Hùng', N'003', NULL, N'Tiền đạo', 0, N'TP HCM', N'NguyenVanHung	@gmail.com', N'0901234629')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (184, N'Bùi Thị Khánh Ly', N'012', NULL, N'Tiền đạo', 0, N'Vĩnh Phúc', N'BuiThiLy	@gmail.com', N'0901234685')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (185, N'Nguyễn Thị Nga', N'007', NULL, N'Tiền vệ phòng ngự', 0, N'Tây Ninh', N'NguyenThiNga	@gmail.com', N'0901234739')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (186, N'Nguyễn Hữu Quỳnh', N'003', NULL, N'Trung vệ', 0, N'Đồng Tháp', N'NguyenHuuQuynh	@gmail.com', N'0901234647')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (187, N'Phạm Văn Sơn', N'017', NULL, N'Tiền vệ phòng ngự', 0, N'Hải Phòng', N'PhamVanSon	@gmail.com', N'0901234690')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (188, N'Phạm Trung Thành', N'017', NULL, N'Tiền vệ trung tâm', 0, N'Vĩnh Long', N'PhamTrungThanh	@gmail.com', N'0901234747')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (189, N'Hồ Hữu Thăng', N'003', NULL, N'Hậu vệ phải', 0, N'Lâm Đồng', N'HoHuuThang	@gmail.com', N'0901234597')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (190, N'Nguyễn Thị Thuật', N'003', NULL, N'Hậu vệ phải', 0, N'Bắc Giang', N'NguyenThiThuat	@gmail.com', N'0901234695')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (191, N'Hồ Sỹ Thức', N'017', NULL, N'Hậu vệ trái', 0, N'Phú Yên', N'HoSyThuc	@gmail.com', N'0901234750')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (192, N'Phan Sỹ Mạnh Tiến', N'017', NULL, N'Hậu vệ trái', 0, N'Ninh Bình', N'PhanSyTien	@gmail.com', N'0901234603')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (193, N'Nguyễn Thị Trang', N'017', NULL, N'Tiền vệ trung tâm', 0, N'Khánh Hòa', N'NguyenThiTrang	@gmail.com', N'0901234656')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (194, N'Trần Trọng Khoa', N'012', NULL, N'Trung vệ', 0, N'Đồng Tháp', N'TranTrongKhoa	@gmail.com', N'0901234584')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (195, N'Trần Quang Vũ', N'010', NULL, N'Tiền đạo', 0, N'Bến Tre', N'TranQuangVu	@gmail.com', N'0901234762')
INSERT [dbo].[CauThu] ([SoAoCauThu], [TenCauThu], [MaLop], [MaSinhVien], [ViTri], [SoBanGhiDuoc], [Que], [Email], [SDT]) VALUES (196, N'Hoàng Thị Giang', N'017', NULL, N'Hậu vệ trái', 0, N'Phú Yên', N'HoangThiGiang	@gmail.com', N'0901234624')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'1         ', N'001', 2, 1, 3, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'1         ', N'004', 1, 2, 0, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'10        ', N'010', 2, 1, 3, N'B')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'10        ', N'017', 1, 2, 0, N'B')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'11        ', N'008', 2, 2, 1, N'C')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'11        ', N'016', 2, 2, 1, N'C')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'12        ', N'004', 3, 0, 3, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'12        ', N'015', 0, 3, 0, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'13        ', N'005', 4, 0, 3, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'13        ', N'013', 0, 4, 0, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'14        ', N'001', 4, 0, 3, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'14        ', N'015', 0, 4, 0, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'15        ', N'004', 1, 3, 0, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'15        ', N'005', 3, 1, 3, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'16        ', N'002', 2, 1, 3, N'C')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'16        ', N'016', 1, 2, 0, N'C')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'17        ', N'008', 2, 0, 3, N'C')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'17        ', N'009', 0, 2, 0, N'C')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'18        ', N'007', 1, 0, 3, N'B')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'18        ', N'017', 0, 1, 0, N'B')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'19        ', N'010', 2, 2, 1, N'B')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'19        ', N'012', 2, 2, 1, N'B')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'2         ', N'007', 1, 2, 0, N'B')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'2         ', N'010', 2, 1, 3, N'B')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'20        ', N'003', 2, 1, 3, N'D')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'20        ', N'011', 1, 2, 3, N'D')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'21        ', N'006', 3, 0, 3, N'D')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'21        ', N'014', 0, 3, 0, N'D')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'22        ', N'013', 1, 1, 1, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'22        ', N'015', 1, 1, 1, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'23        ', N'002', 2, 1, 3, N'C')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'23        ', N'009', 1, 2, 0, N'C')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'24        ', N'001', 1, 3, 0, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'24        ', N'005', 3, 1, 3, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'25        ', N'004', 3, 0, 3, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'25        ', N'013', 0, 3, 0, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'26        ', N'007', 0, 1, 0, N'B')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'26        ', N'012', 1, 0, 3, N'B')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'27        ', N'003', 1, 1, 1, N'D')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'27        ', N'014', 1, 1, 1, N'D')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'28        ', N'006', 2, 0, 3, N'D')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'28        ', N'011', 0, 2, 0, N'D')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'29        ', N'001', 2, 0, 3, N'Tứ Kết')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'29        ', N'010', 0, 2, 0, N'Tứ Kết')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'3         ', N'002', 0, 3, 0, N'C')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'3         ', N'008', 3, 0, 3, N'C')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'30        ', N'002', 2, 1, 3, N'Tứ Kết')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'30        ', N'011', 1, 2, 0, N'Tứ Kết')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'31        ', N'006', 2, 0, 3, N'Tứ Kết')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'31        ', N'008', 0, 2, 0, N'Tứ Kết')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'32        ', N'005', 2, 1, 3, N'Tứ Kết')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'32        ', N'012', 1, 2, 0, N'Tứ Kết')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'33        ', N'001', 5, 6, 0, N'Bán Kết')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'33        ', N'002', 6, 5, 3, N'Bán Kết')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'34        ', N'005', 1, 2, 0, N'Bán Kết')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'34        ', N'006', 2, 1, 3, N'Bán Kết')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'35        ', N'002', 1, 2, 0, N'Chung Kết')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'35        ', N'006', 2, 1, 3, N'Chung Kết')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'4         ', N'005', 4, 0, 3, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'4         ', N'015', 0, 4, 0, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'5         ', N'011', 2, 0, 3, N'B')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'5         ', N'017', 0, 2, 0, N'B')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'6         ', N'003', 0, 2, 0, N'D')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'6         ', N'006', 2, 0, 3, N'D')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'7         ', N'009', 0, 1, 0, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'7         ', N'015', 1, 0, 3, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'8         ', N'011', 0, 2, 0, N'D')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'8         ', N'014', 2, 0, 3, N'D')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'9         ', N'001', 2, 0, 3, N'A')
INSERT [dbo].[Diem] ([LuotTran], [MaLop], [SoBanThang], [SoBanThua], [Diem], [Bang]) VALUES (N'9         ', N'013', 0, 2, 0, N'A')
INSERT [dbo].[DoiBong] ([MaLop], [TenLop], [SoLuongThanhVien], [TrangThai], [GhiChu]) VALUES (N'001', N'Công Nghệ Thông Tin 1-k57', 12, NULL, NULL)
INSERT [dbo].[DoiBong] ([MaLop], [TenLop], [SoLuongThanhVien], [TrangThai], [GhiChu]) VALUES (N'002', N'Công Nghệ Thông Tin 2-k57', 12, NULL, NULL)
INSERT [dbo].[DoiBong] ([MaLop], [TenLop], [SoLuongThanhVien], [TrangThai], [GhiChu]) VALUES (N'003', N'Công Nghệ Thông Tin 3-k57', 12, NULL, NULL)
INSERT [dbo].[DoiBong] ([MaLop], [TenLop], [SoLuongThanhVien], [TrangThai], [GhiChu]) VALUES (N'004', N'Công Nghệ Thông Tin 1-k58', 12, NULL, NULL)
INSERT [dbo].[DoiBong] ([MaLop], [TenLop], [SoLuongThanhVien], [TrangThai], [GhiChu]) VALUES (N'005', N'Công Nghệ Thông Tin 2-k58', 12, NULL, NULL)
INSERT [dbo].[DoiBong] ([MaLop], [TenLop], [SoLuongThanhVien], [TrangThai], [GhiChu]) VALUES (N'006', N'Công Nghệ Thông Tin 3-k58', 12, NULL, NULL)
INSERT [dbo].[DoiBong] ([MaLop], [TenLop], [SoLuongThanhVien], [TrangThai], [GhiChu]) VALUES (N'007', N'Công Nghệ Thông Tin 4-k58', 12, NULL, NULL)
INSERT [dbo].[DoiBong] ([MaLop], [TenLop], [SoLuongThanhVien], [TrangThai], [GhiChu]) VALUES (N'008', N'Công Nghệ Thông Tin 1-k59', 12, NULL, NULL)
INSERT [dbo].[DoiBong] ([MaLop], [TenLop], [SoLuongThanhVien], [TrangThai], [GhiChu]) VALUES (N'009', N'Công Nghệ Thông Tin 2-k59', 12, NULL, NULL)
INSERT [dbo].[DoiBong] ([MaLop], [TenLop], [SoLuongThanhVien], [TrangThai], [GhiChu]) VALUES (N'010', N'Công Nghệ Thông Tin 3-k59', 12, NULL, NULL)
INSERT [dbo].[DoiBong] ([MaLop], [TenLop], [SoLuongThanhVien], [TrangThai], [GhiChu]) VALUES (N'011', N'Công Nghệ Thông Tin 4-k59', 12, NULL, NULL)
INSERT [dbo].[DoiBong] ([MaLop], [TenLop], [SoLuongThanhVien], [TrangThai], [GhiChu]) VALUES (N'012', N'Công Nghệ Thông Tin 1-k60', 12, NULL, NULL)
INSERT [dbo].[DoiBong] ([MaLop], [TenLop], [SoLuongThanhVien], [TrangThai], [GhiChu]) VALUES (N'013', N'Công Nghệ Thông Tin 2-k60', 12, NULL, NULL)
INSERT [dbo].[DoiBong] ([MaLop], [TenLop], [SoLuongThanhVien], [TrangThai], [GhiChu]) VALUES (N'014', N'Công Nghệ Thông Tin 3-k60', 12, NULL, NULL)
INSERT [dbo].[DoiBong] ([MaLop], [TenLop], [SoLuongThanhVien], [TrangThai], [GhiChu]) VALUES (N'015', N'Công Nghệ Thông Tin 4-k60', 12, NULL, NULL)
INSERT [dbo].[DoiBong] ([MaLop], [TenLop], [SoLuongThanhVien], [TrangThai], [GhiChu]) VALUES (N'016', N'Công Nghệ Thông Tin 5-k60', 12, NULL, NULL)
INSERT [dbo].[DoiBong] ([MaLop], [TenLop], [SoLuongThanhVien], [TrangThai], [GhiChu]) VALUES (N'017', N'Công Nghệ Thông Tin 6-k60', 12, NULL, NULL)
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'1         ', N'001')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'1         ', N'004')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'10        ', N'009')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'10        ', N'016')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'11        ', N'010')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'11        ', N'014')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'12        ', N'010')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'12        ', N'017')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'13        ', N'008')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'13        ', N'016')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'14        ', N'004')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'14        ', N'015')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'15        ', N'005')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'15        ', N'013')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'16        ', N'001')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'16        ', N'015')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'17        ', N'004')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'17        ', N'005')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'18        ', N'002')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'18        ', N'016')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'19        ', N'008')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'19        ', N'009')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'2         ', N'007')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'2         ', N'010')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'20        ', N'007')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'20        ', N'016')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'21        ', N'010')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'21        ', N'012')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'22        ', N'003')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'22        ', N'011')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'23        ', N'006')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'23        ', N'014')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'24        ', N'013')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'24        ', N'015')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'25        ', N'002')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'25        ', N'009')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'26        ', N'001')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'26        ', N'005')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'27        ', N'004')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'27        ', N'013')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'28        ', N'006')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'28        ', N'012')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'29        ', N'003')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'29        ', N'014')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'3         ', N'002')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'3         ', N'008')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'30        ', N'006')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'30        ', N'011')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'31        ', N'001')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'31        ', N'010')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'32        ', N'002')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'32        ', N'011')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'33        ', N'006')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'33        ', N'008')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'34        ', N'005')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'34        ', N'012')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'35        ', N'001')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'35        ', N'002')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'36        ', N'005')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'36        ', N'006')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'37        ', N'002')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'37        ', N'006')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'4         ', N'005')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'4         ', N'015')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'5         ', N'012')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'5         ', N'017')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'6         ', N'003')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'6         ', N'006')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'7         ', N'009')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'7         ', N'015')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'8         ', N'011')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'8         ', N'014')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'9         ', N'001')
INSERT [dbo].[DoiBong_Tran] ([LuotTran], [MaLop]) VALUES (N'9         ', N'013')
INSERT [dbo].[DoiTruong] ([MaLop], [SoAoCauThu], [TenCauThu], [MaSinhVien], [SoDienThoai]) VALUES (N'001', 8, N'Ngô Văn Anh', N'171201099', N'0901234709')
INSERT [dbo].[DoiTruong] ([MaLop], [SoAoCauThu], [TenCauThu], [MaSinhVien], [SoDienThoai]) VALUES (N'002', 68, N'Lê Thế Huy', N'172202067', N'0901234730')
INSERT [dbo].[DoiTruong] ([MaLop], [SoAoCauThu], [TenCauThu], [MaSinhVien], [SoDienThoai]) VALUES (N'003', 143, N'Nguyễn Ngọc Tiến', N'172346775', N'0901234602')
INSERT [dbo].[DoiTruong] ([MaLop], [SoAoCauThu], [TenCauThu], [MaSinhVien], [SoDienThoai]) VALUES (N'004', 51, N'Nguyễn Mạnh Đức', N'172145368', N'0901234724')
INSERT [dbo].[DoiTruong] ([MaLop], [SoAoCauThu], [TenCauThu], [MaSinhVien], [SoDienThoai]) VALUES (N'005', 57, N'Vũ Thị Thu Hiền', N'171246397', N'0901234675')
INSERT [dbo].[DoiTruong] ([MaLop], [SoAoCauThu], [TenCauThu], [MaSinhVien], [SoDienThoai]) VALUES (N'006', 104, N'Phạm Thị Ngọc', N'171579236', N'0901234740')
INSERT [dbo].[DoiTruong] ([MaLop], [SoAoCauThu], [TenCauThu], [MaSinhVien], [SoDienThoai]) VALUES (N'007', 133, N'Trương Văn Thịnh', N'171572687', N'0901234692')
INSERT [dbo].[DoiTruong] ([MaLop], [SoAoCauThu], [TenCauThu], [MaSinhVien], [SoDienThoai]) VALUES (N'008', 33, N'Nguyễn Thành Duy', N'171247987', N'0901234573')
INSERT [dbo].[DoiTruong] ([MaLop], [SoAoCauThu], [TenCauThu], [MaSinhVien], [SoDienThoai]) VALUES (N'009', 47, N'Trần Tiến Đạt', N'171247964', N'0901234623')
INSERT [dbo].[DoiTruong] ([MaLop], [SoAoCauThu], [TenCauThu], [MaSinhVien], [SoDienThoai]) VALUES (N'010', 82, N'Nguyễn Thị Là', N'171875964', N'0901234633')
INSERT [dbo].[DoiTruong] ([MaLop], [SoAoCauThu], [TenCauThu], [MaSinhVien], [SoDienThoai]) VALUES (N'011', 123, N'Phạm Duy Thanh', N'171576321', N'0901234649')
INSERT [dbo].[DoiTruong] ([MaLop], [SoAoCauThu], [TenCauThu], [MaSinhVien], [SoDienThoai]) VALUES (N'012', 147, N'Nguyễn Huyền Trang', N'171514785', N'0901234604')
INSERT [dbo].[DoiTruong] ([MaLop], [SoAoCauThu], [TenCauThu], [MaSinhVien], [SoDienThoai]) VALUES (N'013', 41, N'Lê Thị Đào', N'171547628', N'0901234721')
INSERT [dbo].[DoiTruong] ([MaLop], [SoAoCauThu], [TenCauThu], [MaSinhVien], [SoDienThoai]) VALUES (N'014', 44, N'Nguyễn Hoàng Đạo', N'171878548', N'0901234673')
INSERT [dbo].[DoiTruong] ([MaLop], [SoAoCauThu], [TenCauThu], [MaSinhVien], [SoDienThoai]) VALUES (N'015', 109, N'Hoàng Minh Phong', N'171879456', N'0901234590')
INSERT [dbo].[DoiTruong] ([MaLop], [SoAoCauThu], [TenCauThu], [MaSinhVien], [SoDienThoai]) VALUES (N'016', 146, N'Đỗ Thị Huyền Trang', N'171578456', N'0901234752')
INSERT [dbo].[DoiTruong] ([MaLop], [SoAoCauThu], [TenCauThu], [MaSinhVien], [SoDienThoai]) VALUES (N'017', 168, N'Nguyễn Thanh Tùng', N'178567987', N'0901234704')
INSERT [dbo].[GiaiDau] ([MaGiaiDau], [TenGiaiDau], [MaBanToChuc], [MuaGiai]) VALUES (N'01', N'Giải bóng đá nam khoa CNTT', N'01', N'2019')
INSERT [dbo].[GiaiDau] ([MaGiaiDau], [TenGiaiDau], [MaBanToChuc], [MuaGiai]) VALUES (N'02', N'Giải bóng đá nữ khoa CNTT', N'01', N'2019')
INSERT [dbo].[GiaiDau] ([MaGiaiDau], [TenGiaiDau], [MaBanToChuc], [MuaGiai]) VALUES (N'03', N'Giải bóng đá khoa', N'02', N'2019')
INSERT [dbo].[GiaiDau] ([MaGiaiDau], [TenGiaiDau], [MaBanToChuc], [MuaGiai]) VALUES (N'04', N'Giải bóng đá trường', N'02', N'2019')
INSERT [dbo].[GiaiDau] ([MaGiaiDau], [TenGiaiDau], [MaBanToChuc], [MuaGiai]) VALUES (N'05', N'Giải Nghịch', N'01', N'2019')
INSERT [dbo].[GiaiDau_DoiBong] ([MaGiaiDau], [MaLop]) VALUES (N'01', N'001')
INSERT [dbo].[GiaiDau_DoiBong] ([MaGiaiDau], [MaLop]) VALUES (N'01', N'002')
INSERT [dbo].[GiaiDau_DoiBong] ([MaGiaiDau], [MaLop]) VALUES (N'01', N'003')
INSERT [dbo].[GiaiDau_DoiBong] ([MaGiaiDau], [MaLop]) VALUES (N'01', N'004')
INSERT [dbo].[GiaiDau_DoiBong] ([MaGiaiDau], [MaLop]) VALUES (N'01', N'005')
INSERT [dbo].[GiaiDau_DoiBong] ([MaGiaiDau], [MaLop]) VALUES (N'01', N'006')
INSERT [dbo].[GiaiDau_DoiBong] ([MaGiaiDau], [MaLop]) VALUES (N'01', N'007')
INSERT [dbo].[GiaiDau_DoiBong] ([MaGiaiDau], [MaLop]) VALUES (N'01', N'008')
INSERT [dbo].[GiaiDau_DoiBong] ([MaGiaiDau], [MaLop]) VALUES (N'01', N'009')
INSERT [dbo].[GiaiDau_DoiBong] ([MaGiaiDau], [MaLop]) VALUES (N'01', N'010')
INSERT [dbo].[GiaiDau_DoiBong] ([MaGiaiDau], [MaLop]) VALUES (N'01', N'011')
INSERT [dbo].[GiaiDau_DoiBong] ([MaGiaiDau], [MaLop]) VALUES (N'01', N'012')
INSERT [dbo].[GiaiDau_DoiBong] ([MaGiaiDau], [MaLop]) VALUES (N'01', N'013')
INSERT [dbo].[GiaiDau_DoiBong] ([MaGiaiDau], [MaLop]) VALUES (N'01', N'014')
INSERT [dbo].[GiaiDau_DoiBong] ([MaGiaiDau], [MaLop]) VALUES (N'01', N'015')
INSERT [dbo].[GiaiDau_DoiBong] ([MaGiaiDau], [MaLop]) VALUES (N'01', N'016')
INSERT [dbo].[GiaiDau_DoiBong] ([MaGiaiDau], [MaLop]) VALUES (N'01', N'017')
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'1         ', 1, N'01', N'a', 1)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'10        ', 1, N'01', N'a', 18)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'11        ', 2, N'03', N'a', 18)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'12        ', 1, N'01', N'a', 4)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'13        ', 2, N'02', N'a', 4)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'14        ', 1, N'01', N'a', 5)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'15        ', 1, N'01', N'a', 6)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'16        ', 1, N'02', N'a', 7)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'17        ', 2, N'03', N'a', 7)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'18        ', 1, N'01', N'a', 8)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'19        ', 2, N'02', N'a', 8)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'2         ', 1, N'02', N'a', 2)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'20        ', 1, N'03', N'a', 9)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'21        ', 2, N'01', N'a', 9)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'22        ', 1, N'01', N'a', 19)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'23        ', 2, N'02', N'a', 19)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'24        ', 1, N'01', N'a', 10)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'25        ', 1, N'01', N'a', 11)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'26        ', 2, N'02', N'a', 11)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'27        ', 1, N'01', N'a', 12)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'28        ', 2, N'02', N'a', 12)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'29        ', 1, N'03', N's', 13)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'3         ', 2, N'02', N'a', 3)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'30        ', 2, N'04', N'a', 13)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'31        ', 1, N'01', N'a', 20)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'32        ', 2, N'02', N'a', 20)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'33        ', 2, N'03', N'a', 21)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'34        ', 1, N'04', N'a', 21)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'35        ', 1, N'02', N'a', 22)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'36        ', 2, N'01', N'a', 23)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'37        ', 1, N'01', N'a', 24)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'4         ', 2, N'04', N'a', 1)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'5         ', 5, N'05', N'a', 1)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'6         ', 4, N'01', N'a', 2)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'7         ', 10, N'07', N'a', 3)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'8         ', 3, N'06', N'a', 3)
INSERT [dbo].[LichThiDau] ([LuotTran], [MaSan], [MaTrongTai], [ThongBao], [MaThoiGian]) VALUES (N'9         ', 1, N'01', N'a', 17)
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (1, CAST(N'2019-09-22T09:00:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (2, CAST(N'2019-09-22T10:00:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (3, CAST(N'2019-09-22T13:30:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (4, CAST(N'2019-09-25T09:00:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (5, CAST(N'2019-09-26T09:00:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (6, CAST(N'2019-09-27T09:00:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (7, CAST(N'2019-09-29T09:00:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (8, CAST(N'2019-09-29T10:00:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (9, CAST(N'2019-09-29T13:30:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (10, CAST(N'2019-10-04T10:00:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (11, CAST(N'2019-10-06T09:00:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (12, CAST(N'2019-10-06T13:30:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (13, CAST(N'2019-10-06T14:30:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (17, CAST(N'2019-09-15T09:00:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (18, CAST(N'2019-09-22T14:30:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (19, CAST(N'2019-09-29T14:30:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (20, CAST(N'2019-10-13T08:00:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (21, CAST(N'2019-10-13T09:00:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (22, CAST(N'2019-10-15T09:00:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (23, CAST(N'2019-10-13T10:00:00.000' AS DateTime))
INSERT [dbo].[LuotTran] ([MaThoiGian], [ThoiGian]) VALUES (24, CAST(N'2019-10-20T09:00:00.000' AS DateTime))
INSERT [dbo].[NhaTaiTro] ([MaNhaTaiTro], [TenNhaTaiTro], [DiaChi], [Hotline], [Website], [SoTienTaiTro]) VALUES (N'01', N'Khoa CNTT', N'Tầng 3 - Nhà A9 - Trường ĐH GTVT', N'0437664679', N'khoacntt@utc.edu.vn', 10000000.0000)
INSERT [dbo].[NhaTaiTro] ([MaNhaTaiTro], [TenNhaTaiTro], [DiaChi], [Hotline], [Website], [SoTienTaiTro]) VALUES (N'02', N'Văn Nam', N'Hà Nội', N'212', N'vannam212', 51561515.0000)
INSERT [dbo].[NhaTaiTro] ([MaNhaTaiTro], [TenNhaTaiTro], [DiaChi], [Hotline], [Website], [SoTienTaiTro]) VALUES (N'03', N'Thanh hải', N'thái nguyên', N'21513515', N'HaiLit', 215203231.0000)
INSERT [dbo].[NhaTaiTro] ([MaNhaTaiTro], [TenNhaTaiTro], [DiaChi], [Hotline], [Website], [SoTienTaiTro]) VALUES (N'04', N'ĐHGTVT', N'Cầu giấy', N'215', N'sis.utc.edu.vn', 1000000.0000)
INSERT [dbo].[NhaTaiTro_GiaiDau] ([MaNhaTaiTro], [MaGiaiDau]) VALUES (N'01', N'01')
INSERT [dbo].[NhaTaiTro_GiaiDau] ([MaNhaTaiTro], [MaGiaiDau]) VALUES (N'01', N'02')
INSERT [dbo].[NhaTaiTro_GiaiDau] ([MaNhaTaiTro], [MaGiaiDau]) VALUES (N'02', N'01')
INSERT [dbo].[NhaTaiTro_GiaiDau] ([MaNhaTaiTro], [MaGiaiDau]) VALUES (N'03', N'01')
INSERT [dbo].[NhaTaiTro_GiaiDau] ([MaNhaTaiTro], [MaGiaiDau]) VALUES (N'03', N'02')
INSERT [dbo].[NhaTaiTro_GiaiDau] ([MaNhaTaiTro], [MaGiaiDau]) VALUES (N'04', N'02')
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (1, N'Sân Yên Hòa', N'Yên Hoà, Cầu Giấy, Hà Nội
', 450000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (2, N'Sân Yên Hòa', N'Yên Hoà, Cầu Giấy, Hà Nội
', 450000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (3, N'Sân Yên Hòa', N'Yên Hoà, Cầu Giấy, Hà Nội
', 450000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (4, N'Sân Chùa Láng', N'Chùa Láng', 450000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (5, N'Sân Chùa Láng', N'Chùa Láng', 450000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (6, N'Sân Chùa Láng', N'Chùa Láng', 450000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (7, N'Sân Đông Đô', N'Phố Tôn Thất Thuyết
Hà Nội', 450000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (8, N'Sân Đông Đô', N'Phố Tôn Thất Thuyết
Hà Nội', 450000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (9, N'Sân Đông Đô', N'Phố Tôn Thất Thuyết
Hà Nội', 450000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (10, N'Sân Đông Đô', N'Phố Tôn Thất Thuyết
Hà Nội', 450000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (11, N'Sân Phạm Văn Đồng 3', N'232 Phạm Văn Đông', 400000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (12, N'ABC', N'333 Quận Ba Đình, Hà Nội', 400000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (13, N'Sân bóng đá VAS2', N'Số 5 Lê Trọng Tấn, Thanh Xuân', 400000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (14, N'Sân Bóng IC', N'82 Duy Tân, Cầu Giấy', 400000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (15, N'Sân bóng Đoan Môn', N'Lê Trọng Tấn', 400000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (16, N'Sân Bóng Hải Đăng', N'56 Đường Tố Hữu', 400000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (18, N'Sân Bóng Đầm Hồng II', N'Ngõ 93 - Hoàng Văn Thái (Quận Thanh Xuân, Hà Nội)', 400000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (19, N'Sân bóng Nhà Máy Đường', N'Khuân viên Nhà Máy Đường (Thị xã Sơn Tây, Hà Nội) ', 400000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (24, N'SÂN BÓNG ĐÁ MINH ĐỨC', N' Số 8 Dương Đình Nghệ, Yên Hoà , Cầu Giấy , Hà Nội', 400000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (26, N'
SÂN BÓNG ĐÁ AN KHÁNH', N' Hoàng Minh Giám, Yên Hoà , Cầu Giấy , Hà Nội', 400000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (27, N'SÂN BÓNG ĐÁ THÁI SƠN', N' Số 1 Hoàng Minh Giám, Yên Hoà , Cầu Giấy , Hà Nội', 400000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (28, N'SÂN BÓNG ĐÁ NHẤT SƠN', N' A7 Nam Trung Yên, Nghĩa Đô , Cầu Giấy , Hà Nội', 400000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (29, N'SÂN BÓNG ĐÁ BÁCH VIỆT', N' B10B Nam Trung Yên, Yên Hoà , Cầu Giấy , Hà Nội', 400000.0000)
INSERT [dbo].[SanVanDong] ([MaSan], [TenSan], [DiaChi], [TienThueSan]) VALUES (30, N'
SÂN BÓNG ĐÁ THÀNH ĐỒNG', N' Nam Trung Yên, Trung Hoà , Cầu Giấy , Hà Nội', 400000.0000)
INSERT [dbo].[ThanhVien] ([MaThanhVien], [MaBanToChuc], [TenThanhVien], [ChucVu], [SoDienThoai], [Email]) VALUES (N'01', N'01', N'TS. Phạm Thanh Hà', N'Trưởng khoa', NULL, NULL)
INSERT [dbo].[ThanhVien] ([MaThanhVien], [MaBanToChuc], [TenThanhVien], [ChucVu], [SoDienThoai], [Email]) VALUES (N'301', N'01', N'Tiến Đạt', N'Nhặt bóng', N'031625616', N'datQue')
INSERT [dbo].[ThanhVien] ([MaThanhVien], [MaBanToChuc], [TenThanhVien], [ChucVu], [SoDienThoai], [Email]) VALUES (N'302', N'02', N'Nhật Nam', N'Quét Sân', N'0512151521', N'GiaoSu')
INSERT [dbo].[ThanhVien] ([MaThanhVien], [MaBanToChuc], [TenThanhVien], [ChucVu], [SoDienThoai], [Email]) VALUES (N'303', N'02', N'Quang Minh', N'Dự Bị', N'0365655666', N'minhvu')
INSERT [dbo].[ThanhVien] ([MaThanhVien], [MaBanToChuc], [TenThanhVien], [ChucVu], [SoDienThoai], [Email]) VALUES (N'304', N'01', N'Văn Dương', N'Giám Đốc', N'096562523', N'GDeath019')
INSERT [dbo].[ThanhVien] ([MaThanhVien], [MaBanToChuc], [TenThanhVien], [ChucVu], [SoDienThoai], [Email]) VALUES (N'305', N'02', N'Thanh Hải', N'nhặt bóng', N'031562556', N'hailit')
INSERT [dbo].[TrongTai] ([MaTrongTai], [TenTrongTai], [SoDienThoai], [TienThueTrongTai]) VALUES (N'01', N'Trần Thanh Hải', N'0396355470', 200000.0000)
INSERT [dbo].[TrongTai] ([MaTrongTai], [TenTrongTai], [SoDienThoai], [TienThueTrongTai]) VALUES (N'02', N'Vũ Quang Minh', N'0973967200', 200000.0000)
INSERT [dbo].[TrongTai] ([MaTrongTai], [TenTrongTai], [SoDienThoai], [TienThueTrongTai]) VALUES (N'03', N'Nguyễn Văn Nam', N'0967045028', 200000.0000)
INSERT [dbo].[TrongTai] ([MaTrongTai], [TenTrongTai], [SoDienThoai], [TienThueTrongTai]) VALUES (N'04', N'Nguyễn Tiến Đạt', N'0914123456', 200000.0000)
INSERT [dbo].[TrongTai] ([MaTrongTai], [TenTrongTai], [SoDienThoai], [TienThueTrongTai]) VALUES (N'05', N'Bùi Minh Thảo', N'0689554712', 200000.0000)
INSERT [dbo].[TrongTai] ([MaTrongTai], [TenTrongTai], [SoDienThoai], [TienThueTrongTai]) VALUES (N'06', N'Đỗ Văn Dương', N'0879845613', 200000.0000)
INSERT [dbo].[TrongTai] ([MaTrongTai], [TenTrongTai], [SoDienThoai], [TienThueTrongTai]) VALUES (N'07', N'Nguyễn Văn Bằng', N'0989423217', 200000.0000)
INSERT [dbo].[TrongTai] ([MaTrongTai], [TenTrongTai], [SoDienThoai], [TienThueTrongTai]) VALUES (N'08', N'Hoàng Quảng An', N'0945174512', 200000.0000)
INSERT [dbo].[TrongTai] ([MaTrongTai], [TenTrongTai], [SoDienThoai], [TienThueTrongTai]) VALUES (N'09', N'Vũ Tuấn Anh', N'0975612375', 200000.0000)
INSERT [dbo].[TrongTai] ([MaTrongTai], [TenTrongTai], [SoDienThoai], [TienThueTrongTai]) VALUES (N'10', N'Nguyễn Phạm Song', N'0971324547', 200000.0000)
INSERT [dbo].[TrongTai] ([MaTrongTai], [TenTrongTai], [SoDienThoai], [TienThueTrongTai]) VALUES (N'11', N'Nguyễn Văn Đông', N'0975634786', 200000.0000)
SET ANSI_PADDING ON
GO
/****** Object:  Index [Unique_DT]    Script Date: 10/19/2019 8:45:08 PM ******/
ALTER TABLE [dbo].[DoiTruong] ADD  CONSTRAINT [Unique_DT] UNIQUE NONCLUSTERED 
(
	[MaLop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CauThu]  WITH CHECK ADD  CONSTRAINT [FK_CauThu_DoiBong] FOREIGN KEY([MaLop])
REFERENCES [dbo].[DoiBong] ([MaLop])
GO
ALTER TABLE [dbo].[CauThu] CHECK CONSTRAINT [FK_CauThu_DoiBong]
GO
ALTER TABLE [dbo].[Diem]  WITH CHECK ADD  CONSTRAINT [FK_Diem_DoiBong] FOREIGN KEY([MaLop])
REFERENCES [dbo].[DoiBong] ([MaLop])
GO
ALTER TABLE [dbo].[Diem] CHECK CONSTRAINT [FK_Diem_DoiBong]
GO
ALTER TABLE [dbo].[DoiBong_Tran]  WITH CHECK ADD  CONSTRAINT [FK_DoiBong_Tran_DoiBong] FOREIGN KEY([MaLop])
REFERENCES [dbo].[DoiBong] ([MaLop])
GO
ALTER TABLE [dbo].[DoiBong_Tran] CHECK CONSTRAINT [FK_DoiBong_Tran_DoiBong]
GO
ALTER TABLE [dbo].[DoiBong_Tran]  WITH CHECK ADD  CONSTRAINT [FK_DoiBong_Tran_LichThiDau] FOREIGN KEY([LuotTran])
REFERENCES [dbo].[LichThiDau] ([LuotTran])
GO
ALTER TABLE [dbo].[DoiBong_Tran] CHECK CONSTRAINT [FK_DoiBong_Tran_LichThiDau]
GO
ALTER TABLE [dbo].[DoiTruong]  WITH CHECK ADD  CONSTRAINT [FK_DoiTruong_DoiBong] FOREIGN KEY([MaLop])
REFERENCES [dbo].[DoiBong] ([MaLop])
GO
ALTER TABLE [dbo].[DoiTruong] CHECK CONSTRAINT [FK_DoiTruong_DoiBong]
GO
ALTER TABLE [dbo].[GiaiDau]  WITH CHECK ADD  CONSTRAINT [FK_GiaiDau_BanToChuc] FOREIGN KEY([MaBanToChuc])
REFERENCES [dbo].[BanToChuc] ([MaBanToChuc])
GO
ALTER TABLE [dbo].[GiaiDau] CHECK CONSTRAINT [FK_GiaiDau_BanToChuc]
GO
ALTER TABLE [dbo].[GiaiDau_DoiBong]  WITH CHECK ADD  CONSTRAINT [FK_GiaiDau_DoiBong_DoiBong] FOREIGN KEY([MaLop])
REFERENCES [dbo].[DoiBong] ([MaLop])
GO
ALTER TABLE [dbo].[GiaiDau_DoiBong] CHECK CONSTRAINT [FK_GiaiDau_DoiBong_DoiBong]
GO
ALTER TABLE [dbo].[GiaiDau_DoiBong]  WITH CHECK ADD  CONSTRAINT [FK_GiaiDau_DoiBong_GiaiDau] FOREIGN KEY([MaGiaiDau])
REFERENCES [dbo].[GiaiDau] ([MaGiaiDau])
GO
ALTER TABLE [dbo].[GiaiDau_DoiBong] CHECK CONSTRAINT [FK_GiaiDau_DoiBong_GiaiDau]
GO
ALTER TABLE [dbo].[LichThiDau]  WITH CHECK ADD  CONSTRAINT [FK_LichThiDau_LuotTran] FOREIGN KEY([MaThoiGian])
REFERENCES [dbo].[LuotTran] ([MaThoiGian])
GO
ALTER TABLE [dbo].[LichThiDau] CHECK CONSTRAINT [FK_LichThiDau_LuotTran]
GO
ALTER TABLE [dbo].[LichThiDau]  WITH CHECK ADD  CONSTRAINT [FK_LichThiDau_SanVanDong] FOREIGN KEY([MaSan])
REFERENCES [dbo].[SanVanDong] ([MaSan])
GO
ALTER TABLE [dbo].[LichThiDau] CHECK CONSTRAINT [FK_LichThiDau_SanVanDong]
GO
ALTER TABLE [dbo].[LichThiDau]  WITH CHECK ADD  CONSTRAINT [FK_LichThiDau_TrongTai] FOREIGN KEY([MaTrongTai])
REFERENCES [dbo].[TrongTai] ([MaTrongTai])
GO
ALTER TABLE [dbo].[LichThiDau] CHECK CONSTRAINT [FK_LichThiDau_TrongTai]
GO
ALTER TABLE [dbo].[NhaTaiTro_GiaiDau]  WITH CHECK ADD  CONSTRAINT [FK_NhaTaiTro_GiaiDau_GiaiDau] FOREIGN KEY([MaGiaiDau])
REFERENCES [dbo].[GiaiDau] ([MaGiaiDau])
GO
ALTER TABLE [dbo].[NhaTaiTro_GiaiDau] CHECK CONSTRAINT [FK_NhaTaiTro_GiaiDau_GiaiDau]
GO
ALTER TABLE [dbo].[NhaTaiTro_GiaiDau]  WITH CHECK ADD  CONSTRAINT [FK_NhaTaiTro_GiaiDau_NhaTaiTro] FOREIGN KEY([MaNhaTaiTro])
REFERENCES [dbo].[NhaTaiTro] ([MaNhaTaiTro])
GO
ALTER TABLE [dbo].[NhaTaiTro_GiaiDau] CHECK CONSTRAINT [FK_NhaTaiTro_GiaiDau_NhaTaiTro]
GO
ALTER TABLE [dbo].[ThanhVien]  WITH CHECK ADD  CONSTRAINT [FK_ThanhVien_BanToChuc] FOREIGN KEY([MaBanToChuc])
REFERENCES [dbo].[BanToChuc] ([MaBanToChuc])
GO
ALTER TABLE [dbo].[ThanhVien] CHECK CONSTRAINT [FK_ThanhVien_BanToChuc]
GO
