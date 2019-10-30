use Football
--1. viết nội thủ tục cập nhật phần trạng thái "Bỏ giải" cho đội bóng có mã lớp nhập vào
create procedure pro1 @malop varchar(50)
as
begin
	update DoiBong set TrangThai=N'Bỏ giải' where MaLop=@malop
end

--2. viết nội thủ tục tính tổng số tiền thuê trọng tài và thuê sân, sử dụng con trỏ
create procedure pro2 @trongtai money, @san money, @tienthue money output
as
begin
	set @tienthue=@trongtai+@san
end

declare tienthuett cursor for select MaTrongTai, TienThueTrongTai from TrongTai
open tienthuett
declare @matt varchar(50), @tientrongtai money, @tien money
set @tien=0
fetch next from tienthuett into @matt, @tientrongtai, @tien
while(@@FETCH_STATUS=0)
begin
	set @tien = @tien + @tientrongtai
	fetch next from tienthuett
end

declare tienthuesan cursor for select MaSan, TienThueSan from SanVanDong
open tienthuesan
declare @masan int, @tienthuesan money, @tiensan money
set @tiensan=0
fetch next from tienthuesan into @masan, @tienthuesan
while(@@FETCH_STATUS=0)
begin
	set @tiensan = @tiensan + @tienthuesan
	fetch next from tienthuesan
end

declare @tongtien money
exec pro2 @tien, @tiensan, @tongtien output
print N'Tổng tiền thuê sân và trọng tài: '+ @tongtien

--3. viết nội thủ tục có mã nhập vào là mã lớp và kiểm tra xem có đội trưởng của lớp đó chưa. 
--nếu chưa thì tự động thêm 1 đội trưởng trong danh sách cầu thủ của lớp đó
create procedure pro3 @malop varchar(50)
as
begin
	declare @ten nvarchar(50), @soao int, @masv varchar(50), @sdt nvarchar(50)
	set @soao=-1
	select top 1 @ten=TenCauThu, @soao=SoAoCauThu, @masv=MaSinhVien, @sdt=SDT
	from CauThu where @malop=MaLop and @malop not in (select MaLop from DoiTruong)
	if(@soao!=-1)
		insert into DoiTruong values(@malop,@soao,@ten,@masv,@sdt)
end

--4. viết nội thủ tục có mã nhập vào là mã lớp và thông tin đưa ra gồm tên lớp, số bàn thắng, thua, điểm và trạng thái
create procedure pro4 @malop varchar(50), @tenlop nvarchar(50) output, @sobanthang int output, @sobanthua int output, @diem int output, @trangthai nvarchar(50) output
as
begin
	select @tenlop=TenLop, @sobanthang=SUM(SoBanThang), @sobanthua=SUM(SoBanThua), @diem=SUM(Diem), @trangthai=TrangThai
	from Diem, DoiBong where Diem.MaLop=DoiBong.MaLop and DoiBong.MaLop=@malop
end