use Football
--1. Tạo login vannam và user VanNam212, gán quyền select, update cho người dùng VanNam212 trên bảng DoiBong
--create login vannam with password='vannam212', default_database=Football
--create user VanNam212 for login vannam
--grant select, update on DoiBong to VanNam212
exec sp_addlogin vannam,'vannam212'
exec sp_adduser vannam,VanNam212
grant select, update on DoiBong to VanNam212

--2. Tạo login hailita1 và user hailit, ngăn quyền delete trên bảng CauThu của người dùng hailit
--create login hailita1 with password='thanhhai', default_database=Football
--create user hailit for login hailita1
--deny delete on CauThu to hailit
exec sp_addlogin hailita1,'thanhhai'
exec sp_adduser hailita1,hailit
deny delete on CauThu to hailit

--3. Tạo login gdeath và user DoDuong, gán quyền insert trên bảng Diem của người dùng DoDuong
--create login gdeath with password='doduong019', default_database=Football
--create user DoDuong for login gdeath
--grant insert on Diem to DoDuong
exec sp_addlogin gdeath,'doduong019'
exec sp_adduser gdeath,DoDuong
grant insert on Diem to DoDuong