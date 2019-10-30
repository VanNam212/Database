/*Declare @t int, @x int
Set @t=0;
Set @x=0;
While(@x<=100)
begin
     if((@x%2)= 0)
	    set @t=@t+@x
	 set @x=@x+1
end
Print N'Tổng: '+ cast(@t as char);

Declare @n int, @c int
set @n=1;
set @c=1;
while(@c<=10)
begin
     set @n = @n*@c
	 set @c = @c+1
end
Print N'10!: '+cast(@n as char) */
use BT1
Declare sv cursor for select * from DIEM 
Open sv
Declare @TOAN float, @LY float, @HOA float, @VAN float, @DiemTB float, @MAHS nvarchar(5) ,@XL nvarchar(10)
set @XL=N''
Fetch next from sv into @MAHS,@TOAN,@LY,@HOA,@VAN
While (@@fetch_status = 0) 
begin
Set @DiemTB = (@TOAN + @LY+ @HOA + @VAN)/4
set @XL=(case
when @DiemTB<5 then N'yeu'
when @DiemTB<7 then N'tb'
when @DiemTB<8 then N'Kha'
else N'gioi'
end)

print @MAHS + N' : ' + cast(@DiemTB as char) + @XL
Fetch next from sv into @MAHS,@TOAN,@LY,@HOA,@VAN 
end
Close sv
Deallocate sv

alter procedure tinh @ma nvarchar(5), @dtb float output
as begin

SELECT  @dtb=(TOAN + LY+ HOA + VAN)/4 FROM DIEM WHERE (MAHS = @ma)
end

declare @dtb1 float
exec tinh N'00002',@dtb1 output
print @dtb1

