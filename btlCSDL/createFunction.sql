use Football
--1. viết hàm tính tổng số bàn thắng của 1 đội
create function tinh_tong(@malop varchar(50)) returns int
as
begin
	declare @tongbt int
	select @tongbt=SUM(SoBanThang)
	from Diem
	where MaLop=@malop
	return @tongbt
end
print dbo.tinh_tong('001')

--2. viết hàm đưa ra danh sách các cầu thủ của 1 đội
create function danhsach(@malop varchar(50)) returns table
as
	return(select TenCauThu, SoAoCauThu, ViTri, SoBanGhiDuoc, SDT, Email, Que from CauThu where MaLop=@malop)
select * from danhsach('001')

--3. viết hàm tính tổng số tiền phải thuê của 1 giải đấu
alter function TienThue() returns money
as
begin
	declare @tongtien money, @ts money, @tt money
	select @ts=sum(TienThueSan)
	from SanVanDong
	select @tt=sum(TienThueTrongTai)
	from TrongTai
	set @tongtien=@ts+@tt
	return @tongtien
end
print dbo.TienThue()

--4. viết hàm tính tổng số tiền tài trợ của mỗi giải đấu
create function TienTaiTro() returns table
as
	return(select GiaiDau.MaGiaiDau, SUM(SoTienTaiTro) as TongTien
	from GiaiDau, NhaTaiTro, NhaTaiTro_GiaiDau
	where GiaiDau.MaGiaiDau=NhaTaiTro_GiaiDau.MaGiaiDau and NhaTaiTro_GiaiDau.MaNhaTaiTro=NhaTaiTro.MaNhaTaiTro
	group by GiaiDau.MaGiaiDau)
select * from TienTaiTro()