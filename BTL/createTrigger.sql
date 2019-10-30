--Cập nhập điểm
--1.
ALTER trigger [dbo].[triggerDiem] on [dbo].[Diem]
for insert, update
as
begin
	declare @luottran int, @malop varchar(50), @banthang int, @banthua int, @diem nchar(10)
	select @luottran=LuotTran, @malop=MaLop, @banthang=SoBanThang, @banthua=SoBanThua from inserted
	set @diem=(case
		when @banthang>@banthua then 3
		when @banthang<@banthua then 0
		else 1
	end)
	update Diem set Diem=@diem where LuotTran=@luottran and MaLop=@malop
end
--2. Thêm trường trạng thái cho đội bóng, đội bóng nào có trạng thái là "tiếp tục giải" thì tạo thêm trường 
-- ghi chú là đá tiếp, còn đội nào bỏ giải thì ghi chú sẽ là hủy trận đấu
alter table DoiBong
add TrangThai nvarchar(50), GhiChu nvarchar(50)
create trigger tg2 on DoiBong
for insert, update
as
begin
	declare @tt nvarchar(50), @ghichu nvarchar(50)
	select @tt=TrangThai from inserted
	set @ghichu=(case
		when @tt=N'Tiếp tục' then N'Đá tiếp'
		else N'Hủy trận'
	end)
end

--3. viết 1 trigger xóa tự động các bản ghi liên quan đến đội bóng đã xóa
create trigger tg3 on DoiBong
for delete
as
begin
	delete from DoiTruong where DoiTruong.MaLop in (select MaLop from deleted)
	delete from GiaiDau_DoiBong where GiaiDau_DoiBong.MaLop in (select MaLop from deleted)
	delete from CauThu where CauThu.MaLop in (select MaLop from deleted)
	delete from Diem where Diem.MaLop in (select MaLop from deleted)
	delete from DoiBong_Tran where DoiBong_Tran.MaLop in (select MaLop from deleted)
end

--4. viết trigger khi 1 đội bỏ giải thì điểm sẽ được cập nhật cho các đội gặp đội bỏ giải
create trigger tg4 on DoiBong
for insert, update
as
begin
	update Diem set Diem = '+3', SoBanThang=3, SoBanThua=0 where LuotTran in (select LuotTran from DoiBong_Tran where MaLop in 
	(select DoiBong.MaLop from DoiBong where TrangThai=N'Bỏ giải')) and 
	MaLop in (select DoiBong.MaLop from DoiBong where TrangThai=N'Tiếp tục')
	update Diem set Diem = '0', SoBanThang=0, SoBanThua=-3 where MaLop in (select DoiBong.MaLop from DoiBong where TrangThai=N'Bỏ giải')
end

--5. viết trigger tự động thông báo lịch thi đấu "đá" hay "hủy" khi có những đội bỏ giải
create trigger tg5 on DoiBong
for insert, update
as
begin
	update LichThiDau set ThongBao = N'Hủy trận' where LuotTran in (select LuotTran from DoiBong_Tran where MaLop in 
	(select DoiBong.MaLop from DoiBong where TrangThai=N'Bỏ giải'))
	update LichThiDau set ThongBao = N'Đá' where LuotTran not in (select LuotTran from DoiBong_Tran where MaLop in 
	(select DoiBong.MaLop from DoiBong where TrangThai=N'Bỏ giải'))
end