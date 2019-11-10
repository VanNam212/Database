use BTThucHanh
--2.
create view view2
as
select pname,price
from [Chi Tiet Hoa Don]

--3.Viết một stored procedure tham số đầu vào là mã hàng, tham số đầu ra là mức giá bán của mã hàng đó.
create procedure pro3 @mahang nvarchar(15), @gia float output
as
begin
	select @gia=price
	from [Chi Tiet Hoa Don]
	where PID=@mahang
end

declare @gia1 float
exec pro3 N'1', @gia1 output
print N'Mức giá: '+cast(@gia1 as char)

--4.Viết một stored procedure tham số đầu vào là mã hàng, tham số đầu ra là tổng số lượng đã bán của mặt hàng 
--đã cho.
alter procedure pro4 @mahang nvarchar(15), @tong smallint output
as
begin
	select @tong=sum(quatity)
	from [Chi Tiet Hoa Don]
	where PID=@mahang
end

declare @tong1 smallint
exec pro4 N'1', @tong1 output
print N'tổng số lượng: '+cast(@tong1 as char)

--5.Viết một trigger tự động cập nhật trường pname, price và amount của bảng ChiTietHoaDon khi thêm mới hay 
--cập nhật một bản ghi.
alter trigger tri5 on [Chi Tiet Hoa Don]
for insert, update
as
begin
	declare @bid nvarchar(15) ,@pid nvarchar(15), @pname nvarchar(255), @gia float, @sl smallint
	select @pid=PID, @bid=BID, @sl=quatity from inserted
	select @pname=value
	from HangHoa
	where ID=@pid and attributes=N'name'
	select @gia=value
	from HangHoa
	where ID=@pid and attributes=N'price'
	update [Chi Tiet Hoa Don] set pname=@pname, price=@gia, amount=@gia*@sl where PID=@pid and BID=@bid
end

--6.
create trigger tri6 on [Chi Tiet Hoa Don]
for insert, update
as
begin
	declare @bid nvarchar(15), @total float, @discount float, @count int
	select @bid=BID, @total=sum(amount), @count=COUNT(PID) from inserted
	update HoaDon set total=@total, HoaDon.count=@count, discount=@discount where ID=@bid
end

--7.
create function fun7 (@cid nvarchar(15)) returns table
as
return(
	select *
	from HoaDon
	where CID=@cid
)

select * from fun7 (N'001')

--8.
create function fun8 ()