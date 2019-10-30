use BT1
--1. Viết một Trigger gắn với bảng DIEM dựa trên sự kiện Insert, Update bản ghi để chỉ cho phép nhập giá trị trong khoảng từ 0 đến 10--
CREATE TRIGGER tg1 ON DIEM
FOR INSERT,UPDATE
AS
BEGIN 
	DECLARE @dtoan float, @dly float, @dhoa float, @dvan float
	SELECT @dtoan=TOAN FROM inserted
	SELECT @dly=LY FROM inserted
	SELECT @dhoa=HOA FROM inserted
	SELECT @dvan=VAN FROM inserted
	if(@dtoan<0 or @dtoan>10 or @dly<0 or @dly>10 or @dhoa<0 or @dhoa>10 or @dvan<0 or @dvan>10)
	begin
		raiserror('Nhap sai diem',16,1)
		rollback transaction
	end
END

--2.  Viết một Trigger gắn với bảng DIEM dựa trên sự kiện Insert, Update để tự động cập nhật
--điểm trung bình của học sinh khi thêm mới hay cập nhật bảng điểm
--Điểm trung bình= ((Toán +Văn)*2+Lý+Hóa)/6--
CREATE TRIGGER tg2 ON DIEM
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @dtb float,@dt float, @dl float, @dh float, @dv float, @mhs nvarchar(5)
	SELECT @dt=TOAN, @dl=LY, @dh=HOA, @dv=VAN, @mhs=MAHS FROM inserted
	set @dtb=((@dt+@dv)*2+@dl+@dh)/6
	update DIEM set DTB=@dtb where MAHS=@mhs
END

--3. Viết một Trigger gắn với bảng DIEM dựa trên sự kiện Insert, Update để tự động xếp loại
--học sinh, cách thức xếp loại như sau
--- Nếu Điểm trung bình>=5 là lên lớp, ngược lại là lưu ban--
create trigger tg3 on DIEM
for insert, update
as
begin
	declare @dtb float, @xl nvarchar(10), @mhs nvarchar(5)
	select @dtb=DTB, @mhs=MAHS from inserted
	if(@dtb>=5)
		set @xl=N'lên lớp'
	else
		set @xl=N'Lưu ban'
	update DIEM set XepLoai=@xl where MAHS=@mhs
end

--4. Viết một Trigger gắn với bảng DIEM dựa trên sự kiện Insert, Update để tự động xếp loại
--học sinh, cách thức xếp loại như sau
--- Xét điểm thấp nhất (DTN) của các 4 môn
--- Nếu DTB>=5 và DTN>=4 là “Lên Lớp”, ngược lại là lưu ban--
create trigger tg4 on DIEM
for insert, update
as
begin
	declare @dtb float,@dt float, @dl float, @dh float, @dv float, @mhs nvarchar(5), @dtn float, @xl nvarchar(10)
	SELECT @dt=TOAN, @dl=LY, @dh=HOA, @dv=VAN, @mhs=MAHS, @dtb=DTB FROM inserted
	set @dtn = (case
		when @dt<@dl and @dt<@dh and @dt<@dv then @dt
		when @dl<@dt and @dl<@dh and @dl<@dv then @dl
		when @dh<@dl and @dt>@dh and @dh<@dv then @dh
		when @dv<@dl and @dv<@dh and @dt>@dv then @dv
	end)
	if(@dtb>=5 and @dtn>=4)
		set @xl=N'Lên lớp'
	else
		set @xl=N'Lưu ban'
	update DIEM set XepLoai=@xl where MAHS=@mhs
end

--5. Viết một trigger xóa tự động bản ghi về điểm học sinh khi xóa dữ liệu học sinh đó trong DSHS--
create trigger KiemTra on DIEM
for insert
as 
begin
	declare @MSHS nvarchar(5)
	select @MSHS=[MAHS] from DSHS
	if not exists(select 'true' from Inserted where Inserted.MAHS=@MSHS)
	begin
		raiserror (6000,16,1,'MSHS','DIEM','MSHS','DSHS')
		rollback tran
	end
end

--6. Viết nội thủ tục (Stored Procedure) cập nhật phần ghi chú là “Chuyển trường từ ngày 5/9/2016” cho học sinh có mã nhập vào trong bảng danh sách học sinh--
create procedure pro6 @ma nvarchar(5)
as
begin
	update DSHS set GhiChu=N'Chuyển trường từ ngày 5/9/2016' where MAHS=@ma
end

exec pro6 N'00001'

--7. Tạo View báo cáo Kết thúc năm học gồm các thông tin: Mã học sinh, Họ và tên, Ngày sinh, Giới tính, Điểm Toán, Lý, Hóa, Văn, Điểm Trung bình, Xếp loại--
create view view7
as
select DIEM.MAHS, (HO+TEN) as HoTen, NGAYSINH, NU, TOAN, LY, HOA, VAN, DTB, XepLoai
from DIEM, DSHS
where DIEM.MAHS=DSHS.MAHS

--8. Tạo trường điểm thấp nhất trong bảng Điểm, tạo thủ tục cập nhật điểm thấp nhất cho trường này của tất cả các bản ghi đã có (dùng con trỏ)--
alter table DIEM
add DTN float
create procedure pro8 @dt float, @dl float, @dh float, @dv float, @dtn float output
as
begin
	set @dtn=(
	case
		when @dt<@dl and @dt<@dh and @dt<@dv then @dt
		when @dl<@dt and @dl<@dh and @dl<@dv then @dl
		when @dh<@dl and @dt>@dh and @dh<@dv then @dh
		when @dv<@dl and @dv<@dh and @dt>@dv then @dv
	end)
end

declare diem cursor for select MAHS,TOAN,LY,HOA,VAN from DIEM
open diem
declare @dt1 float, @dl1 float, @dh1 float, @dv1 float, @dtn1 float, @ma nvarchar(5)
fetch next from diem into @ma,@dt1,@dl1,@dh1,@dv1
while(@@FETCH_STATUS=0)
begin
	exec pro8 @dt1, @dl1, @dh1, @dv1, @dtn1
	update DIEM set DTN=@dtn1 where MAHS=@ma
	fetch next from diem into @ma,@dt1,@dl1,@dh1,@dv1
end

--9. Tạo trigger cập nhật điểm thấp nhất mỗi khi insert, update một bản ghi vào bảng điểm.--
create trigger tg9 on DIEM
for insert, update
as
begin
	declare @dtn float,@dt float, @dl float, @dh float, @dv float
	select @dt=TOAN, @dl=LY, @dh=HOA, @dv=VAN from inserted
	set @dtn = (case
		when @dt<@dl and @dt<@dh and @dt<@dv then @dt
		when @dl<@dt and @dl<@dh and @dl<@dv then @dl
		when @dh<@dl and @dt>@dh and @dh<@dv then @dh
		when @dv<@dl and @dv<@dh and @dt>@dv then @dv
	end)
	update DIEM set DTN =@dtn
end

--10. Tạo View danh sách HOC SINH XUAT SAC bao gồm các học sinh có DTB>=8.5 và
--DTN>=8 với các trường: Lop, Mahs, Hoten, Namsinh (năm sinh), Nu, Toan, Ly, Hoa, Van,
--DTN, DTB (không dùng trường thấp nhất đã làm ở câu 7)--
create view DSHSXuatSac
as
select LOP, DSHS.MAHS, (HO+TEN) as HoTen, YEAR(NGAYSINH), NU, TOAN, LY,HOA,VAN,DTN,DTB
from DIEM, DSHS
where DIEM.MAHS=DSHS.MAHS and DTB>=8.5 and DTN>=8

--11. Tạo View danh sách HOC SINH DAT THU KHOA KY THI bao gồm các học sinh xuất
--sắc có DTB lớn nhất với các trường: Lop, Mahs, Hoten, Namsinh, Nu, Toan, Ly, Hoa, Van,
--DTB--
create view DSHSThuKhoa
as
select LOP, DSHS.MAHS, (HO+TEN) as HoTen, YEAR(NGAYSINH), NU, TOAN, LY,HOA,VAN,DTB
from DIEM, DSHS
where DIEM.MAHS=DSHS.MAHS
having DTB=MAX(DTB)

--
use BT2
--1. Tạo View gồm các field sau: MaDK, LoaiKH, TenKH,NgaySinh, Phai, DiaChi, DienThoai,
--SoPhong, LoaiPhong, NgayVao, SoNgayO.
--Trong đó Số Ngày ở = Ngày Ra – Ngày Vao--
create view view1
as
select tChiTietKH.MaDK, LoaiKH, TenKH, NgaySinh, Phai, DiaChi, DienThoai, SoPhong, LoaiPhong, NgayVao, NgayRa, (month(NgayRa)-month(NgayVao))*30 +(day(NgayRa)-day(NgayVao)) as SoNgayO
from tChiTietKH,tDangKy
where tChiTietKH.MaDK=tDangKy.MaDK

--2. Viết nội thủ tục có mã nhập vào là ngày vào trong năm 1999 và thông tin đưa ra như câu 1--
create procedure pro2 @ma nvarchar(3)
as
begin
	select tChiTietKH.MaDK, LoaiKH, TenKH, NgaySinh, Phai, DiaChi, DienThoai, SoPhong, LoaiPhong, NgayVao, (month(NgayRa)-month(NgayVao))*30 +(day(NgayRa)-day(NgayVao)) as SoNgayO
	from tChiTietKH,tDangKy
	where tChiTietKH.MaDK=tDangKy.MaDK and tDangKy.MaDK=@ma and YEAR(NgayVao)=1999
	print @ma+TenKH
end
exec pro2 N'010'

--3. Viết truy vấn tạo bảng doanh thu (tDoanhThu) gồm các trường--
create table tDoanhThu(
	MaDK nvarchar(3) not null,
	LoaiPhong nvarchar(2) null,
	SoNgayO int null,
	ThucThu float null
)

--4. Tạo Trigger tính tiền và điền tự động vào bảng tDoanhThu như sau:--
create trigger tg4 on tDoanhThu
for insert, update
as
begin
	declare @ma nvarchar(3), @lp nvarchar(20), @nv datetime, @nr datetime, @songay int, @thucthu float, @dongia int
	declare dki cursor for select MaDK, tLoaiPhong.LoaiPhong, NgayVao, NgayRa, DonGia from tDangKy, tLoaiPhong where tDangKy.LoaiPhong=tLoaiPhong.LoaiPhong
	open dki
	fetch next from dki into @ma,@lp,@nv,@nr,@dongia
	while(@@FETCH_STATUS=0)
	begin
		set @songay=(month(@nr)-month(@nv))*30 +(day(@nr)-day(@nv))
		set @thucthu=(case
			when @songay<10 then @dongia*@songay
			when @songay>=10 and @songay<30 then @dongia*@songay*0.95
			else @dongia*@songay*0.9
		end)
		insert into tDoanhThu values(@ma, @lp, @songay,@thucthu)
		fetch next from dki into @ma,@lp,@nv,@nr
	end
end

--
use BT3
--1. Tạo cơ sở dữ liệu trên, với các khóa chính như sau: ChiTietVanTai là MaVT, TrongTai là MaTrongTai, LoTrinh là MaLoTrinh--
create table ChiTietVanTai(
	MaVT int not null primary key,
	SoXe nvarchar(10),
	MaTrongTai nvarchar(10),
	MaLoTrinh nvarchar(10),
	SoLuongVT int,
	NgayDi datetime,
	NgayDen datetime
)

create table LoTrinh(
	MaLoTrinh nvarchar(10) not null primary key,
	TenLoTrinh nvarchar(20),
	DonGia int,
	ThoiGianQD int
)

create table TrongTai(
	MaTrongTai nvarchar(10) not null primary key,
	TrongTaiQD int
)

--2. Tạo view gồm các trường SoXe, MaLoTrinh, SoLuongVT, NgayDi, NgayDen, ThoiGianVT, CuocPhi, Thuong. Trong đó:--
create view view2
as
select SoXe, ChiTietVanTai.MaLoTrinh, SoLuongVT, NgayDi, NgayDen,	
	case
		when day(NgayDen)-day(NgayDi)=0 then 1
		else day(NgayDen)-day(NgayDi)
	end ThoiGianVT,
	case
		when SoLuongVT>TrongTaiQD then SoLuongVT*DonGia*1.05
		else SoLuongVT*DonGia
	end CuocPhi,
	case
		when (case
			when day(NgayDen)-day(NgayDi)=0 then 1
			else day(NgayDen)-day(NgayDi)
			end)>ThoiGianQD then 0.05*(case
										when SoLuongVT>TrongTaiQD then SoLuongVT*DonGia*1.05
										else SoLuongVT*DonGia
										end)
		else 0
	end Thuong
from ChiTietVanTai, TrongTai, LoTrinh
where ChiTietVanTai.MaTrongTai=TrongTai.MaTrongTai and ChiTietVanTai.MaLoTrinh=LoTrinh.MaLoTrinh

--3. Tạo view để lập bảng cước phí gồm các trường SoXe, TenLoTrinh, SoLuongVT, NgayDi, NgayDen, CuocPhi. --
create view view3
as
select SoXe, TenLoTrinh, SoLuongVT, NgayDi, NgayDen,
	case
		when SoLuongVT>TrongTaiQD then SoLuongVT*DonGia*1.05
		else SoLuongVT*DonGia
	end as CuocPhi
from ChiTietVanTai, LoTrinh, TrongTai
where ChiTietVanTai.MaLoTrinh=LoTrinh.MaLoTrinh and ChiTietVanTai.MaTrongTai=TrongTai.MaTrongTai

--4. Tạo view danh sách các xe có có SoLuongVT vượt trọng tải qui định, gồm các trường SoXe, TenLoTrinh, SoLuongVT, TronTaiQD, NgayDi, NgayDen.--
create view view4
as
select SoXe, TenLoTrinh, SoLuongVT, TrongTaiQD, NgayDi, NgayDen
from ChiTietVanTai, LoTrinh, TrongTai
where ChiTietVanTai.MaLoTrinh=LoTrinh.MaLoTrinh and ChiTietVanTai.MaTrongTai=TrongTai.MaTrongTai and SoLuongVT>TrongTaiQD

--5. Tạo thủ tục có đầu vào là lộ trình, đầu ra là số xe, mã trọng tải, số lượng vận tải, ngày đi, ngày đến (SoXe, MaTrongTai, SoLuongVT, NgayDi, NgayDen.)--
create procedure pro5 @lt nvarchar(10), @sx nvarchar(10) output, @mtt nvarchar(10) output, @slvt int output, @ndi datetime output, @nden datetime output
as
begin
	select @sx=SoXe, @mtt=MaTrongTai, @slvt=SoLuongVT, @ndi=NgayDi, @nden=NgayDen from ChiTietVanTai
	where MaLoTrinh=@lt
end

--6. Thiết lập hàm có đầu vào là số xe, đầu ra là thông tin về lộ trình--
create procedure pro6 @sx nvarchar(10), @mlt nvarchar(10) output, @tlt nvarchar(20) output, @gia int output, @time int output
as
begin
	select @mlt=LoTrinh.MaLoTrinh, @tlt=TenLoTrinh, @gia=DonGia, @time=ThoiGianQD from ChiTietVanTai, LoTrinh
	where ChiTietVanTai.MaLoTrinh=LoTrinh.MaLoTrinh and SoXe=@sx
end

--7. Thêm trường Thành tiền vào bảng chi tiết vận tải và tạo trigger điền dữ liệu cho trường này
--biết:
--Thành tiền = là SoLuongVT x DonGia x 105% nếu SoLuongVT nhiều hơn TrongTaiQD, là
--SoLuongVT x DonGia trong trường hợp ngược lại--
alter table ChiTietVanTai
add ThanhTien int,
create procedure pro7 @mvt int, @tt int output
	as
	begin
		select @tt=(
			case
				when SoLuongVT>TrongTaiQD then SoLuongVT*DonGia*1.05
				else SoLuongVT*DonGia
			end)
		from ChiTietVanTai, LoTrinh, TrongTai
		where ChiTietVanTai.MaLoTrinh=LoTrinh.MaLoTrinh and ChiTietVanTai.MaTrongTai=TrongTai.MaTrongTai and MaVT=@mvt
	end
create trigger tg7 on ChiTietVanTai
for insert, update
as
begin
	declare @ma int, @tien int
	select @ma=MaVT from inserted
	execute pro7 @ma, @tien
	update ChiTietVanTai set ThanhTien=@tien where MaVT=@ma
end

--8. Tạo thủ tục có đầu vào là mã lộ trình, năm vận tải, đầu ra là số tiền theo mã lộ trình đó--
create procedure pro8 @mlt nvarchar(10), @nvt int, @tt int output
as
begin
	select @tt=ThanhTien from ChiTietVanTai
	where @mlt=MaLoTrinh and year(NgayDi)=@nvt
end

--9. Tạo thủ tục có đầu vào là số xe, năm vận tải, đầu ra là số tiền theo mã lộ trình đó--
create procedure pro9 @sx nvarchar(10), @nvt int, @tt int output
as
begin
	select @tt=ThanhTien from ChiTietVanTai
	where @sx=SoXe and year(NgayDi)=@nvt
end

