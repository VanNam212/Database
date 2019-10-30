use Football
--1. Tạo login vannam và user VanNam212, gán quyền select, update cho người dùng VanNam212 trên bảng DoiBong
create login vannam with password='vannam212', default_database=Football
create user VanNam212 for login vannam
grant select, update on DoiBong to VanNam212

--2. Tạo login hailita1 và user hailit, ngăn quyền delete trên bảng CauThu của người dùng hailit
create login hailita1 with password='thanhhai', default_database=Football
create user hailit for login hailita1
deny delete on CauThu from hailit