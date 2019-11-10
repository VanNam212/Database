using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CSDL
{
    class DoiBong
    {
        private string MaLop;
        private string TenLop;
        private int SoLuong;
        private string TrangThai;
        private string GhiChu;

        public DoiBong(string maLop, string tenLop, int soLuong, string trangThai, string ghiChu)
        {
            MaLop1 = maLop;
            TenLop1 = tenLop;
            SoLuong1 = soLuong;
            TrangThai1 = trangThai;
            GhiChu1 = ghiChu;
        }

        public string MaLop1 { get => MaLop; set => MaLop = value; }
        public string TenLop1 { get => TenLop; set => TenLop = value; }
        public int SoLuong1 { get => SoLuong; set => SoLuong = value; }
        public string TrangThai1 { get => TrangThai; set => TrangThai = value; }
        public string GhiChu1 { get => GhiChu; set => GhiChu = value; }
    }
}
