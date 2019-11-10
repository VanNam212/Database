use BT7
create procedure pro5 @thang int, @nam int, @dt float output
as
begin
select @dt=SUM(GiaBan*SoLuong)
from [tbl Chi Tiet Hoa Don], [tbl Hoa Don]
where [tbl Chi Tiet Hoa Don].MaHD=[tbl Hoa Don].MaHD and MONTH(NgayLapHD)=@thang and YEAR(NgayLapHD)=@nam
end

declare @dt1 float
exec pro5 1,1997, @dt1 output
print N'Doanh thu: '+cast(@dt1 as char)
--1.
alter table [tbl San Pham]
add constraint PK_MaSP primary key(MaSP)

--2.
create proc pro2 @mahd nvarchar(5), @makh nvarchar(10), @manv int, @ngaylaphd datetime, @ngaygh datetime, @masp tinyint,
@sl tinyint, @gia money, @mahd1 nvarchar(5)
as
begin
	begin try
		begin tran
			insert into [tbl Hoa Don] values (@mahd,@makh,@manv,@ngaylaphd,@ngaygh)
			insert into [tbl Chi Tiet Hoa Don] values (@mahd1,@masp,@sl,@gia)
		commit tran
	end try
	begin catch
		print N'Lỗi'
		rollback tran
	end catch
end

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
use BT7
create procedure pro6 @ngay datetime, @shd nvarchar(5) output, @dt money output
as
begin
	select @shd=[tbl Hoa Don].MaHD, @dt=SUM(SoLuong*GiaBan)
	from [tbl Chi Tiet Hoa Don], [tbl Hoa Don]
	where [tbl Chi Tiet Hoa Don].MaHD=[tbl Hoa Don].MaHD and NgayLapHD=@ngay
	group by [tbl Hoa Don].MaHD
end

declare @hd nvarchar(5), @tien money
exec pro6 N'1997-01-08 00:00:00.000', @hd output, @tien output
print N'Số hóa đơn: '+@hd+ N' Doanh thu: '+cast(@tien as char)

--7.
use BT7
alter function func7 (@shd nvarchar(5)) returns table
as
return(
	select [tbl Chi Tiet Hoa Don].*,Sum(SoLuong*GiaBan) as ThanhTien
	from [tbl Hoa Don],[tbl Chi Tiet Hoa Don]
	where [tbl Hoa Don].MaHD=@shd and [tbl Hoa Don].MaHD=[tbl Chi Tiet Hoa Don].MaHD
	group by [tbl Chi Tiet Hoa Don].MaHD, MaSP
)
select * from func7('10526')

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
--8.
create function fun8(@ngay datetime) returns table
as
return(
	select *
	from tNhanVien
	where MONTH(@ngay)=MONTH(NgayBD) and (YEAR(@ngay)-YEAR(NgayBD))%3=0 and YEAR(@ngay)-YEAR(NgayBD)>0
)

select * from fun8(N'1995-05-05 00:00:00.000')