use BT7
--1.
alter table [tbl San Pham]
add constraint PK_MaSP primary key(MaSP)

--2.


--3.
create procedure pro3 @shd nvarchar(5), @tien money output
as
begin
	select @tien=SUM(SoLuong*GiaBan)
	from [tbl Chi Tiet Hoa Don] 
	where MaHD=@shd
end

declare @thanhtien money
exec pro3 N'10256', @thanhtien output
print N'T?ng ti?n: '+cast(@thanhtien as char)

--4.
create view QuaTang
as
select [tbl Hoa Don].MaHD, MaKH, NgayLapHD, TenSP, SoLuong, GiaBan, (SoLuong*GiaBan) as ThanhTien,
	case
		when SoLuong*GiaBan>=500 and SoLuong>=35 then 0.1*SoLuong*GiaBan
		else 0
	end as GiamGia, floor((SoLuong*GiaBan)/1000) as Quatang
from [tbl Chi Tiet Hoa Don], [tbl Hoa Don], [tbl San Pham]
where [tbl Chi Tiet Hoa Don].MaHD=[tbl Hoa Don].MaHD and [tbl Chi Tiet Hoa Don].MaSP=[tbl San Pham].MaSP
order by MaHD asc

--5.
create view DoanhThu
as
select MONTH(NgayLapHD) as Thang,SUM(GiaBan*SoLuong) as DoanhThu
from [tbl Chi Tiet Hoa Don], [tbl Hoa Don]
where [tbl Chi Tiet Hoa Don].MaHD=[tbl Hoa Don].MaHD
group by MONTH(NgayLapHD)

--6.
create procedure pro6 @ngay nvarchar(50), @shd nvarchar(5) output, @dt money output
as
begin
	select @shd=[tbl Hoa Don].MaHD, @dt=SUM(SoLuong*GiaBan)
	from [tbl Chi Tiet Hoa Don], [tbl Hoa Don]
	where [tbl Chi Tiet Hoa Don].MaHD=[tbl Hoa Don].MaHD and NgayLapHD=@ngay	
end

declare @hd nvarchar(5), @tien money
exec pro6 N'1997-01-06 00:00:00.000', @hd output, @tien output
print N'Doanh thu: '+cast(@tien as char)

--7.
create function func7 (@shd nvarchar(5)) returns table
as
return(
	select MaHD, Sum(SoLuong*GiaBan) as ThanhTien
	from [tbl Chi Tiet Hoa Don]
	group by MaHD
)


--
use BT8
--1.
alter table tPhongBan
add primary key(MaPB)
alter table tChiTietNhanVien
add primary key(MaNV)

--2.
create view view2
as
select tNhanVien.MaNV, HO, TEN, ChucVu, (year(GETDATE())-YEAR(NgayBD)) as ThamNien, (HSLuong*250000) as Luong, 
	case
		when day(NTNS)<30 and month(NTNS)<4 and year(NTNS)<1975 then 150000
		else 0
	end as TroCap, 
	case
		when year(GETDATE())-YEAR(NgayBD)>=5 then 50000*(year(GETDATE())-YEAR(NgayBD)-5+1)
		else 0
	end as PhuCapTN
from tChiTietNhanVien, tNhanVien
where tChiTietNhanVien.MaNV=tNhanVien.MaNV

--3.
create function fun3 (@nam int) returns int
as
begin
	declare @sonv int
	select @sonv=COUNT(MaNV)
	from tNhanVien
	where year(NTNS)=@nam
	return @sonv
end

--4.
create function fun4 (@stn int) returns table
as
return(
	select *
	from tNhanVien
	where (year(GETDATE())-YEAR(NgayBD))=@stn
)

--5.
create function fun5 (@chucvu nvarchar(3)) returns table
as
return(
	select tNhanVien.*
	from tNhanVien, tChiTietNhanVien
	where tNhanVien.MaNV=tChiTietNhanVien.MaNV and ChucVu=@chucvu
)

--6.
