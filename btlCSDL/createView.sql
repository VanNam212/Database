USE Football
--1. View--
--1.1: Đưa ra bảng điểm của các lớp--
create VIEW BangDiem
AS 
SELECT TenLop, SUM(Diem) as SoDiem
FROM Diem, DoiBong
WHERE Diem.MaLop = DoiBong.MaLop
GROUP BY TenLop
--1.2: Đưa ra thông tin về cầu thủ ghi nhiều bàn thắng nhất--
CREATE VIEW Information
AS
SELECT TOP 1 SoAoCauThu, TenCauThu, TenLop, SUM(SoBanGhiDuoc) AS TongBanThang, SDT
FROM CauThu, DoiBong
WHERE CauThu.MaLop=DoiBong.MaLop
GROUP BY SoAoCauThu, TenCauThu, TenLop, SDT
ORDER BY TongBanThang DESC
--1.3: Đưa ra danh sách các nhà tài trợ--
CREATE VIEW DSNhaTaiTro
AS
SELECT TenNhaTaiTro, DiaChi, SoTienTaiTro, TenGiaiDau
FROM NhaTaiTro, NhaTaiTro_GiaiDau, GiaiDau
WHERE NhaTaiTro.MaNhaTaiTro=NhaTaiTro_GiaiDau.MaNhaTaiTro AND NhaTaiTro_GiaiDau.MaGiaiDau=GiaiDau.MaGiaiDau
--1.4: Đưa ra danh sách cầu thủ của lớp Công Nghệ Thông Tin 1-k58--
CREATE VIEW DSCauThu
AS 
SELECT SoAoCauThu, TenCauThu, ViTri
FROM DoiBong, CauThu
WHERE TenLop=N'Công Nghệ Thông Tin 1-k58' AND DoiBong.MaLop=CauThu.MaLop