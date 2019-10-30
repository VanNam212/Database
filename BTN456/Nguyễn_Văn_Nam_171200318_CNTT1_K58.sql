use BT4
--1. Tạo view KET QUA
create view KQ
as
select DanhSach.SoBD, (Ho+' '+Ten) as HoTen,Phai, (YEAR(GETDATE())-YEAR(NTNS)) as Tuoi, Toan, Van, AnhVan,
	(Toan+Van+AnhVan+DiemUT) as TongDiem, 
	case
		when Toan+Van+AnhVan+DiemUT>=24 and Toan>=7 and Van>=7 and AnhVan>=7 then N'Gioi'
		when Toan+Van+AnhVan+DiemUT>=21 and Toan+Van+AnhVan+DiemUT<24 and Toan>=6 and Van>=6 and AnhVan>=6 then N'Kha'
		when Toan+Van+AnhVan+DiemUT>=15 and Toan+Van+AnhVan+DiemUT<21 and Toan>=4 and Van>=4 and AnhVan>=4 then N'Trung binh'
		else N'Truot'
	end as XepLoai, DanhSach.DTDuThi
from DanhSach, DiemThi, ChiTietDT
where DanhSach.SoBD=DiemThi.SoBD and DanhSach.DTDuThi=ChiTietDT.DTDuThi

--2. 
create view view2
as
select DanhSach.SoBD, (Ho+' '+Ten) as HoTen, Toan, Van, AnhVan,
	(Toan+Van+AnhVan+DiemUT) as TongDiem, DienGiaiDT
from DanhSach, DiemThi, ChiTietDT
where DanhSach.SoBD=DiemThi.SoBD and DanhSach.DTDuThi=ChiTietDT.DTDuThi
and (Toan=10 or Van=10 or AnhVan=10) and (Toan+Van+AnhVan+DiemUT)>=25

--3.
alter table DiemThi
add TongDiem float, XepLoai nvarchar(20)
update DiemThi set TongDiem=(Toan+Van+AnhVan+DiemUT), XepLoai=(case
		when Toan+Van+AnhVan+DiemUT>=24 and Toan>=7 and Van>=7 and AnhVan>=7 then N'Gioi'
		when Toan+Van+AnhVan+DiemUT>=21 and Toan+Van+AnhVan+DiemUT<24 and Toan>=6 and Van>=6 and AnhVan>=6 then N'Kha'
		when Toan+Van+AnhVan+DiemUT>=15 and Toan+Van+AnhVan+DiemUT<21 and Toan>=4 and Van>=4 and AnhVan>=4 then N'Trung binh'
		else N'Truot'
	end) from ChiTietDT, DanhSach where ChiTietDT.DTDuThi=DanhSach.DTDuThi and DiemThi.SoBD=DanhSach.SoBD
create view dsDau
as
select DanhSach.SoBD, (Ho+' '+Ten) as HoTen,Phai, (YEAR(GETDATE())-YEAR(NTNS)) as Tuoi, Toan, Van, AnhVan, TongDiem, 
	XepLoai, DanhSach.DTDuThi
from DanhSach, DiemThi, ChiTietDT
where DanhSach.SoBD=DiemThi.SoBD and DanhSach.DTDuThi=ChiTietDT.DTDuThi and (XepLoai=N'Gioi' or XepLoai=N'Kha' or XepLoai=N'Trung binh')

--4. 
create view thukhoa
as
select DanhSach.SoBD, (Ho+' '+Ten) as HoTen,Phai, (YEAR(GETDATE())-YEAR(NTNS)) as Tuoi, Toan, Van, AnhVan, TongDiem, DanhSach.DTDuThi
from DanhSach, DiemThi, ChiTietDT
where DanhSach.SoBD=DiemThi.SoBD and DanhSach.DTDuThi=ChiTietDT.DTDuThi and (XepLoai=N'Gioi' or XepLoai=N'Kha' or XepLoai=N'Trung binh')
having TongDiem= (select MAX(TongDiem) from DiemThi)

--5.
create procedure pro5 @sbd int, @dt real output, @dv real output, @dav real output, @dut int output, @tong float output
as
begin
	select @dt=Toan, @dv=Van, @dav=AnhVan, @dut=DiemUT, @tong=TongDiem
	from ChiTietDT, DanhSach, DiemThi
	where DanhSach.SoBD=DiemThi.SoBD and DanhSach.DTDuThi=ChiTietDT.DTDuThi and DiemThi.SoBD=@sbd
end

--6.
create trigger tg6 on DanhSach
for insert, update
as
begin
	declare @dtdt tinyint
	set @dtdt=0
	select @dtdt=DTDuThi from DanhSach where DTDuThi not in (select DTDuThi from ChiTietDT)
	if(@dtdt=0)
	begin
		raiserror('Nhap sai DTDuThi',16,1)
		rollback transaction
	end
end

--7. 
alter table DiemThi
add DiemUT int
create trigger tg7 on DiemThi
for insert, update
as
begin
	update DiemThi set DiemUT = (select DiemUT from ChiTietDT, DanhSach, DiemThi where ChiTietDT.DTDuThi=DanhSach.DTDuThi and DanhSach.SoBD=DiemThi.SoBD),
	TongDiem=(Toan+Van+AnhVan+DiemUT)
end

--8.
create trigger tg8 on DanhSach
for delete
as
begin
	delete from DiemThi where DiemThi.SoBD in (select SoBD from deleted)
end

--
use BT5New
--1.
create procedure pro1 @mhs nvarchar(5), @ht nvarchar(255) output, @gt nvarchar(255) output, @tt nvarchar(150) output, @td float output, @toan float output, @van float output
as
begin
	select @ht=Hoten, @gt=GioiTinh, @tt=TenTruong, @td=TD, @toan=Toan, @van=Van from BangDiemHS
	where MAHS=@mhs
end
declare @ht1 nvarchar(255), @gt1 nvarchar(255), @tt1 nvarchar(150), @td1 float, @toan1 float, @van1 float
exec pro1 N'0001',@ht1 output, @gt1 output, @tt1 output, @td1 output, @toan1 output, @van1 output
print @ht1+' '+@gt1+' '+@tt1+' '+@td1+' '+@toan1+' '+@van1
--2.
create function func2 (@ht nvarchar(255)) returns table
as
	return(select DANHSACH.MAHS, (DANHSACH.HO+' '+DANHSACH.TEN) as HoTen, GioiTinh, TenTruong, TD, Toan, Van from BangDiemHS, DANHSACH where BangDiemHS.MAHS=DANHSACH.MAHS and (DANHSACH.HO+' '+DANHSACH.TEN)=@ht)
select * from func2(N'Nguyen Viet Hong')
--3.
alter trigger tg3 on DANHSACH
for insert, update
as
begin
	declare @mhs nvarchar(5), @tenhs nvarchar(255), @gt nvarchar(255), @tt nvarchar(150)
	select @mhs=MAHS, @tenhs=(HO+' '+TEN), @gt=(case
		when PHAI='False' then 'nam'
		else 'nu'
	end), @tt=(select TENTRUONG from TRUONG where TRUONG.MATRUONG=inserted.MATRUONG) from inserted
	insert BangDiemHS (MAHS, Hoten, GioiTinh, TenTruong) values(@mhs, @tenhs,@gt, @tt)
	--update BangDiemHS set MAHS=@mhs, Hoten=@tenhs, GioiTinh=@gt, TenTruong=@tt 
end

--4.
create trigger tg4 on DIEM
for insert, update
as
begin
	declare @mhs nvarchar(5), @mon nvarchar(10), @diem float
	select @mhs=MAHS, @mon=MON, @diem=DIEM from inserted
	update BangDiemHS set Toan=@diem where @mon=N'Toan' and BangDiemHS.MAHS=@mhs
	update BangDiemHS set Van=@diem where @mon=N'Van' and BangDiemHS.MAHS=@mhs
end

--5.
create function func5(@mt nvarchar(4)) returns table
as
	return(select BangDiemHS.* from BangDiemHS, DANHSACH where BangDiemHS.MAHS=DANHSACH.MAHS and DANHSACH.MATRUONG=@mt)

select * from func5 (N'TV')

--
use BT6New
--1.
alter table tChiTietHDB
add GiaBan float
create trigger tri1 on tChiTietHDB
for insert, update
as
begin
	declare @masach nvarchar(255), @dgban float
	--select @masach=MaSach, @dgban=DonGiaBan from inserted
	declare capnhatgiaban cursor for select MaSach, DonGiaBan from tSach
	open capnhatgiaban
	fetch next from capnhatgiaban into @masach, @dgban
	while (@@FETCH_STATUS=0)
	begin
		update tChiTietHDB set GiaBan=@dgban where MaSach=@masach
		fetch next from capnhatgiaban into @masach, @dgban
	end
end

--2.
alter table tChiTietHDB
add ThanhTien float
alter trigger tri2 on tChiTietHDB
for insert, update
as
begin
	declare capnhattien cursor for select SoHDB, MaSach, SLBan, GiaBan from tChiTietHDB
	open capnhattien
	declare @shdb nvarchar(255), @ms nvarchar(255), @slb int, @gb float
	fetch next from capnhattien into @shdb, @ms, @slb, @gb
	while(@@FETCH_STATUS=0)
	begin
		--set @gb=SUBSTRING(@gb,2, @gb.DATALENGTH);
		update tChiTietHDB set ThanhTien=SLBan*@gb where SoHDB=@shdb and MaSach=@ms
		fetch next from capnhattien into @shdb, @ms, @slb, @gb
	end	
end

--3.
create trigger tri3 on tHoaDonBan
for delete
as
begin
	delete from tChiTietHDB where SoHDB in (select SoHDB from deleted)
end

--4.
create procedure proce4 @mk nvarchar(255), @tien float output
as
begin
	select @tien=SUM(ThanhTien)
	from tChiTietHDB, tHoaDonBan
	where tChiTietHDB.SoHDB=tHoaDonBan.SoHDB and tHoaDonBan.MaKH=@mk and YEAR(NgayBan)=2014
end
declare @tt float
exec proce4 N'KH01', @tt output
print N'Tổng tiền: '+ cast(@tt as char)

--5.
create view view5
as
select tKhachHang.MaKH, TenKH, DienThoai, SUM(ThanhTien)
from tKhachHang, tHoaDonBan, tChiTietHDB
where tKhachHang.MaKH=tHoaDonBan.MaKH and tHoaDonBan.SoHDB=tChiTietHDB.SoHDB and YEAR(NgayBan)=2013

--6.
create procedure proce6 @thang int, @doanhthu float output
as
begin
	select @doanhthu=SUM(ThanhTien)
	from tHoaDonBan, tChiTietHDB
	where tHoaDonBan.SoHDB=tChiTietHDB.SoHDB and MONTH(NgayBan)=@thang
end

declare @dt float
exec proce6 1,@dt output
print N'Doanh thu thang 1: '+cast(@dt as char)

--7.
