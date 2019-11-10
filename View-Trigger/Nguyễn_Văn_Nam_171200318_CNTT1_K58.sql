use BT22
--1.
create procedure pro1 @lp nvarchar(2), @sp int output, @spdang int output, @sptrong int output
as
begin
	select @sp=COUNT(SoPhong), 
	@sptrong=(select COUNT(SoPhong) from tPhong where LoaiPhong=@lp and SoPhong not in(select SoPhong from tDangKy where LoaiPhong=@lp)),
	@spdang=@sp-@sptrong
	from tPhong
	where LoaiPhong=@lp
end

declare @sp1 int, @spdang1 int, @sptrong1 int
exec pro1 N'A', @sp1, @spdang1, @sptrong1
print N'tổng số phòng: '+cast(@sp1 as char(5))+N' tổng phòng đang sử dụng: '+cast(@spdang1 as char(5))+N' tổng phòng đang trống: '
+cast(@sptrong1 as char(5))

--2.
create function fun2(@ngaybd datetime, @ngaykt datetime) returns table
as
return(
	select SoPhong
	from tDangKy
	where DATEDIFF(DAY,@ngaybd,NgayRa)>0 or DATEDIFF(DAY,NgayVao,@ngaykt)>0
	--((YEAR(@ngaybd)-YEAR(NgayRa))*365+(MONTH(@ngaybd)-MONTH(NgayRa))*30+DAY(@ngaybd)-DAY(NgayRa))>0 or
	--((YEAR(NgayVao)-YEAR(@ngaykt))*365+(MONTH(NgayVao)-MONTH(@ngaykt))*30+DAY(NgayVao)-DAY(@ngaykt))>0
)
select * from fun2(N'1998-05-28 00:00:00.000',N'1999-04-28 00:00:00.000')

--3.
create view view3
as
select LoaiKH,TenKH, SoPhong, LoaiPhong
from tChiTietKH, tDangKy
where tChiTietKH.MaDK=tDangKy.MaDK and (DATEDIFF(DAY,GETDATE(),NgayVao)>=0 or DATEDIFF(DAY,NgayRa,GETDATE())>0)
--((YEAR(GETDATE())-YEAR(NgayVao))*365+(MONTH(GETDATE())-MONTH(NgayVao))*30+DAY(GETDATE())-DAY(NgayVao))>=0 or
	--((YEAR(NgayRa)-YEAR(GETDATE()))*365+(MONTH(NgayRa)-MONTH(GETDATE()))*30+DAY(NgayRa)-DAY(GETDATE()))>0

--4.
alter table tChiTietKH
add Diem int
create trigger tri4 on tChiTietKH
for insert, update
as
begin
	declare @tien int, @madk nvarchar(3)
	select @tien=DonGia*SoNgayO, @madk=MaDK
	from tDoanhThu, tLoaiPhong
	where tDoanhThu.LoaiPhong=tLoaiPhong.LoaiPhong
	update tChiTietKH set Diem=50*(@tien/500000) where MaDK=@madk
end

--5.
create login vannam with password='vannam212', default_database =BT22
create user A for login vannam
grant select on tKhachHang to A

create user B for login vannam
grant insert, update to B
