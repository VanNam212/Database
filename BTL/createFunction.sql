use Football
--1. viết hàm tính tổng số bàn thắng của 1 đội
create function tinh_tong(@malop varchar(50)) returns int
as
begin
	declare @tongbt int
	select @tongbt=SUM(SoBanThang)
	from Diem
	return @tongbt
end
select * from tinh_tong('001')

--2. viết hàm đưa ra danh sách các cầu thủ của 1 đội
create function danhsach(@malop varchar(50)) returns table
as
begin
	return(select TenCauThu, SoAoCauThu, ViTri, SoBanGhiDuoc, SDT, Email, Que from CauThu where MaLop=@malop)
end
select * from danhsach('001')

--3. viết hàm tính tổng số tiền phải thuê của 1 giải đấu
create function TienThue() returns money
as
begin
	declare @tongtien money
	select @tongtien=SUM(TienThueSan)+SUM(TienThueTrongTai)
	from SanVanDong, TrongTai
	return @tongtien
end
select * from TienThue()

--4. viết hàm tính tổng số tiền tài trợ của mỗi giải đấu
create function TienTaiTro() returns table
as
begin
	return(select GiaiDau.MaGiaiDau, SUM(SoTienTaiTro) as TongTien
	from GiaiDau, NhaTaiTro, NhaTaiTro_GiaiDau
	where GiaiDau.MaGiaiDau=NhaTaiTro_GiaiDau.MaGiaiDau and NhaTaiTro_GiaiDau.MaNhaTaiTro=NhaTaiTro.MaNhaTaiTro
	group by GiaiDau.MaGiaiDau)
end