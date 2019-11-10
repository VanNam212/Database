use Football
--1. viết nội thủ tục cập nhật phần trạng thái "Bỏ giải" cho đội bóng có mã lớp nhập vào
create procedure pro1 @malop varchar(50)
as
begin
	update DoiBong set TrangThai=N'Bỏ giải' where MaLop=@malop
end
exec pro1 '001'
--2. viết nội thủ tục tính tổng số tiền thuê trọng tài và thuê sân, sử dụng con trỏ
create procedure pro2 @tienthue money output
as
begin
	--set @tienthue=@trongtai+@san
	declare @tientt money, @tiensan money
	set @tientt=0
	declare tienthuett cursor for select MaTrongTai, TienThueTrongTai from TrongTai
	open tienthuett
	declare @matt varchar(50), @tientrongtai money
	fetch next from tienthuett into @matt, @tientrongtai
	while(@@FETCH_STATUS=0)
	begin
		set @tientt = @tientt + @tientrongtai
		fetch next from tienthuett into @matt, @tientrongtai
	end

	set @tiensan=0
	declare tienthuesan cursor for select MaSan, TienThueSan from SanVanDong
	open tienthuesan
	declare @masan int, @tienthuesan money
	fetch next from tienthuesan into @masan, @tienthuesan
	while(@@FETCH_STATUS=0)
	begin
		set @tiensan = @tiensan + @tienthuesan
		fetch next from tienthuesan into @masan, @tienthuesan
	end
	set @tienthue=@tientt+@tiensan
end

declare @tongtien money
exec pro2 @tongtien output
print N'Tổng tiền thuê sân và trọng tài: '+ cast(@tongtien as varchar(20))

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
exec pro3 '001'

--4. viết nội thủ tục có mã nhập vào là mã lớp và thông tin đưa ra gồm tên lớp, số bàn thắng, thua, điểm và trạng thái
create procedure pro4 @malop varchar(50), @tenlop nvarchar(50) output, @sobanthang int output, @sobanthua int output, @diem int output, @trangthai nvarchar(50) output
as
begin
	select @tenlop=TenLop, @sobanthang=SUM(SoBanThang), @sobanthua=SUM(SoBanThua), @diem=SUM(Diem), @trangthai=TrangThai
	from Diem, DoiBong where Diem.MaLop=DoiBong.MaLop and DoiBong.MaLop=@malop
	group by TenLop, TrangThai
end

declare @tenlop1 nvarchar(50), @sobanthang1 int, @sobanthua1 int, @diem1 int, @trangthai1 nvarchar(50)
exec pro4 '001', @tenlop1 output, @sobanthang1 output, @sobanthua1 output, @diem1 output, @trangthai1 output
print N'Tên lớp: '+@tenlop1+N' Số bàn thắng: '+cast(@sobanthang1 as char(10))+N' Số bàn thua: '+cast(@sobanthua1 as char(10))+
N' Điểm: '+cast(@diem1 as char(10))+N' Trạng thái: '+@trangthai1

--5. viết nội thủ tục nhập dữ liệu bảng đội bóng
create procedure pro5 @malop varchar(50), @tenlop varchar(50), @sl int, @trangthai varchar(50), @ghichu varchar(50)
as
begin
	insert into DoiBong values(@malop,@tenlop,@sl,@trangthai,@ghichu)
end