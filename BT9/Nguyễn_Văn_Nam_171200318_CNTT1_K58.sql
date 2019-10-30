use BT9
--view
--1.
create view view1
as
select MaNV,HoTen,(YEAR(GETDATE())-YEAR(NgaySinh)) as Tuoi, QueQuan,SDT,HSL,  (HSL * 1500000) as Luong
from NHANVIEN

--2.
drop trigger tri2
alter table CT_HOADON
add GiaBan float
create trigger tri2 on CT_HOADON
for insert,update
as
begin
	declare @mhh nvarchar(50), @gb float
	declare capnhat cursor for select MaHH,GiaBan from HANGHOA
	open capnhat
	fetch next from capnhat into @mhh, @gb
	while(@@FETCH_STATUS=0)
	begin
		update CT_HOADON set GiaBan=@gb where MaHH=@mhh
		fetch next from capnhat into @mhh,@gb
	end
end
create view view2
as
select HOADON.MaHD, Sum(SL*GiaBan) as Tong
from HOADON, CT_HOADON
where HOADON.MaHD=CT_HOADON.MaHD
group by HOADON.MaHD

--3.
create view view3
as
select MaHH ,Sum(SL) as SL, SUm(SL*GiaBan)
from CT_HOADON
group by MaHH

--4.
create view view4
as
select MaHH ,Sum(SL) as SL, SUm(SL*GiaMua)
from CT_PHIEUNHAP
group by MaHH

--5.
create view view5
as
select MONTH(NgayLap), count(MaHD)
from HOADON
where year(NgayLap)=2015
group by MONTH(NgayLap)

--proc
--1.
create procedure proc1 @mhd nvarchar(50), @tien float output
as
begin
	select @tien=Sum(SL*GiaBan)
	from CT_HOADON 
	where MaHD=@mhd
end

declare @tien1 float
exec proc1 N'0001', @tien1 output
print N'Tiền: '+cast(@tien1 as char)

--2.
create procedure proc2 @thang int, @nam int, @tong int output
as
begin
	select @tong=count(MaHD)
	from HOADON 
	where MONTH(NgayLap)=@thang and year(NgayLap)=@nam
end

declare @tong1 float
exec proc2 3,2015, @tong1 output
print N'Tổng: '+cast(@tong1 as char)

--3.
alter procedure proc3 @mnv nvarchar(50), @nam int, @tonghd int output, @tongtien float output
as
begin
	select @tonghd=count(HOADON.MaHD), @tongtien=Sum(SL*GiaBan)
	from HOADON, CT_HOADON
	where MaNV=@mnv and year(NgayLap)=@nam and HOADON.MaHD=CT_HOADON.MaHD
end

declare @tongtien1 float, @tonghd1 int
exec proc3 N'0004',2015, @tonghd1 output, @tongtien1 output
print N'Tổng hd: '+cast(@tonghd1 as char)+N' Tổng tiền: '+cast(@tongtien1 as char)

--4.
create procedure proc4 @mhh nvarchar(50), @nam int, @tongsl int output, @tongtien float output
as
begin
	select @tongsl=sum(SL), @tongtien=Sum(SL*GiaMua)
	from PHIEUNHAP, CT_PHIEUNHAP
	where MaHH=@mhh and year(NgayLap)=@nam and PHIEUNHAP.MaPN=CT_PHIEUNHAP.MaPN
end

declare @tongtien1 float, @tongsl1 int
exec proc4 N'0001',2015, @tongsl1 output, @tongtien1 output
print N'Tổng sl: '+cast(@tongsl1 as char)+N' Tổng tiền: '+cast(@tongtien1 as char)

--trigger
--1.
create trigger trig1 on NHANVIEN
for insert, update
as
begin
	declare @gt nvarchar(5)
	select @gt=[Gioi Tinh] from inserted
	if(@gt!=N'Nam' and @gt!=N'Nữ')
	begin
		raiserror('Nhap sai gioi tinh',16,1)
		rollback transaction
	end
end

--2.
alter trigger trig2 on NHANVIEN
for insert, update
as
begin
	declare @ngaylam datetime, @ngaysinh datetime
	select @ngaylam=NgayLV, @ngaysinh=NgaySinh from inserted
	if(YEAR(GETDATE())-year(@ngaysinh)<18 or year(@ngaylam)-year(@ngaysinh)<18)
	begin
		raiserror('Nhap sai ngay lam',16,1)
		rollback transaction
	end
end

--3.
alter table HANGHOA
add DonViTinh nvarchar(10)
create trigger trig3 on HANGHOA
for insert, update
as
begin
	declare @donvi nvarchar(10)
	select @donvi=DonViTinh from inserted
	if(@donvi!=N'Cái' and @donvi!=N'hộp' and @donvi!=N'thùng' and @donvi!=N'kg' and @donvi!=N'chiếc')
	begin
		raiserror('Nhap sai don vi tinh',16,1)
		rollback transaction
	end
end

--4.
drop trigger trig4
create trigger trig4 on CT_HOADON
for insert, update
as
begin
	declare @mahh nvarchar(50), @gia float
	select @mahh=MaHH from inserted
	select @gia=GiaBan
	from HANGHOA
	where @mahh=MaHH
	update CT_HOADON set GiaBan=@gia where MaHH=@mahh
end

--5.
alter table CT_HOADON
add ChietKhau float
drop trigger trig5
alter trigger trig5 on CT_HOADON
for insert, update
as
begin
	declare @mahd nvarchar(50),@mahh nvarchar(50), @gia float
	declare capnhat cursor for select MaHD,MaHH,GiaBan from CT_HOADON
	open capnhat
	fetch next from capnhat into @mahd, @mahh,@gia
	while(@@FETCH_STATUS=0)
	begin
		update CT_HOADON set ChietKhau=@gia*0.15 where MaHH=@mahh and MaHD=@mahd
		fetch next from capnhat into @mahd, @mahh,@gia
	end	
	close capnhat
end

--6.
alter table CT_HOADON
add ThanhTien float
alter trigger trig6 on CT_HOADON
for insert, update
as
begin
	declare @mahd nvarchar(50),@mahh nvarchar(50), @sl int, @gia float, @ck float
	declare capnhat1 cursor for select MaHD,MaHH,SL ,GiaBan,ChietKhau from CT_HOADON
	open capnhat1
	fetch next from capnhat1 into @mahd, @mahh, @sl,@gia,@ck
	while(@@FETCH_STATUS=0)
	begin
		update CT_HOADON set ThanhTien=@gia*@sl+@ck where MaHH=@mahh and MaHD=@mahd
		fetch next from capnhat1 into @mahd, @mahh, @sl,@gia,@ck
	end	
end

--function
--1.
create function func1(@que nvarchar(max)) returns table
as
return(select * from NHANVIEN where QueQuan=@que)

select * from func1(N'Số 3, Ngõ 165,Cầu Giấy - Hà Nội')

--2.
create function func2(@mnv nvarchar(50), @ngay datetime) returns table
as
return(select MaHD from HOADON where MaNV=@mnv and NgayLap=@ngay)

select * from func1(N'0004',N'2015-04-02 00:00:00.000')

--3.
create function func3(@mhd nvarchar(50)) returns float
as
begin
	declare @tien float
	select @tien=Sum(SL*GiaBan)
	from CT_HOADON
	where MaHD=@mhd
	return @tien
end

select * from func1(N'0001')

--4.
create function func4(@mhh nvarchar(50)) returns table
as
return(
	select NHACUNGCAP.*
	from NHACUNGCAP, PHIEUNHAP, CT_PHIEUNHAP
	where NHACUNGCAP.MaNCC=PHIEUNHAP.MaNCC and PHIEUNHAP.MaPN=CT_PHIEUNHAP.MaPN and CT_PHIEUNHAP.MaHH=@mhh
)

select * from func1(N'0001')

--5.
create function func5(@mncc nvarchar(50)) returns table
as
return(
	select HANGHOA.*
	from NHACUNGCAP, PHIEUNHAP, CT_PHIEUNHAP, HANGHOA
	where NHACUNGCAP.MaNCC=PHIEUNHAP.MaNCC and PHIEUNHAP.MaPN=CT_PHIEUNHAP.MaPN and NHACUNGCAP.MaNCC=@mncc and CT_PHIEUNHAP.MaHH=HANGHOA.MaHH
)

select * from func5(N'0001')

--6.
alter function func6(@quan nvarchar(50)) returns table
as
return(
	select *
	from KHACHHANG
	where DiaChi like @quan
)

select * from func6(N'Cầu giấy')