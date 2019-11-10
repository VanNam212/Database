--2. Tạo thủ tục có đầu vào là ngày hóa đơn, đầu ra là số mặt hàng bán trong ngày đó
alter proc pro2 @ngay datetime, @somh int output
as
begin
	select @somh=COUNT(ChiTietHD.MaSP)
	from Hoadon,ChiTietHD
	where Hoadon.MaHD=ChiTietHD.MaHD and Ngayban=@ngay
end

declare @somh1 int
exec pro2 N'02-12-1999', @somh1 output
print N'Số mặt hàng: '+cast(@somh1 as char)

--3.Tạo hàm có đầu vào là mã khách hàng, năm, đầu ra là danh sách các hóa đơn khách hàng mua trong năm 
create function func3 (@makh nvarchar(5), @nam int) returns table
as
return(
	select MaKH, Hoadon.MaHD, Ngayban, sum(SlBan*GiaSP) as TongTien
	from Hoadon, ChiTietHD, SanPham
	where YEAR(Ngayban)=@nam and MaKH=@makh and Hoadon.MaHD=ChiTietHD.MaHD and ChiTietHD.MaSP=SanPham.MaSP
	group by MaKH, Hoadon.MaHD, Ngayban
)

select * from func3('0004',2015)

--4. Tạo View thống kê hàng tồn dựa trên số lượng nhập và bán trong năm 2015
alter view view4
as
select SanPham.MaSP, TenSP, sum(SLN) as SLN, sum(SlBan) as SLB, (sum(SLN)-sum(SlBan)) as Ton
from ChiTietHD, ChiTietHDN, SanPham, Hoadon, HoaDonNhap
where ChiTietHD.MaSP=SanPham.MaSP and SanPham.MaSP=ChiTietHDN.MaSP and Hoadon.MaHD=ChiTietHD.MaHD and HoaDonNhap.MaHDN=ChiTietHDN.MaHDN and YEAR(Ngayban)=2015 and YEAR(NgayNhap)=2015
group by SanPham.MaSP, TenSP

select * from view4

--5.
alter table HoaDon
add SLMua int
create trigger tri5 on ChiTietHD
for insert,update
as
begin
	declare @mahd nvarchar(5), @sl int
	select @mahd=MaHD
	from inserted
	select @sl=sum(SlBan)
	from ChiTietHD
	where MaHD=@mahd
	update Hoadon set SLMua=@sl where MaHD=@mahd
end


--6.
--create login A with password='123', default_database=QLBanDienThoai_NguyenVanNam_171200318
--create login B with password='123', default_database=QLBanDienThoai_NguyenVanNam_171200318
--create user D for login A
--grant select, insert, update on Hoadon to D with grant option
--grant select, insert, update on ChiTiet HD to A with grant option

exec sp_addlogin 'E','123'
exec sp_addlogin 'F','123'
exec sp_adduser E,EE
exec sp_adduser F,FF
grant select, update, insert on Hoadon to EE with grant option
--7.
