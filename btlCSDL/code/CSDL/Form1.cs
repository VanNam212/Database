using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CSDL
{
    public partial class Form1 : Form
    {
        SqlConnection sqlConnection;
        List<DoiBong> list;
        public Form1()
        {
            InitializeComponent();
            Connect();
        }
        private void Connect()
        {
            sqlConnection = new SqlConnection();
            sqlConnection.ConnectionString = @"Data Source=ADMIN\SQLEXPRESS;Initial Catalog=BTL123;Integrated Security=True";
            sqlConnection.Open();
        }

        private void Disconnect()
        {
            if (sqlConnection.State != ConnectionState.Closed)
            {
                sqlConnection.Close();
            }
            sqlConnection.Dispose();
        }

        private void load(string sql)
        {
            DataTable data = new DataTable();
            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sql, sqlConnection);
            sqlDataAdapter.Fill(data);
            dataGridView1.DataSource = data;
        }
        private void run(String sql)
        {
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnection;
            sqlCommand.CommandText = sql;
            try
            {
                sqlCommand.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                ex.ToString();
            }
        }

        private List<DoiBong> Select()
        {
            string sql = "SELECT * FROM DoiBong";
            List<DoiBong> list = new List<DoiBong>();
            SqlCommand cmd = new SqlCommand(sql, sqlConnection);
            using (DbDataReader reader = cmd.ExecuteReader())
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        string MaLop = reader.GetString(0);
                        string TenLop = reader.GetString(1);
                        int SoLuong = reader.GetInt32(2);
                        string TrangThai = reader.GetString(3);
                        string GhiChu = reader.GetString(4);
                        DoiBong nv = new DoiBong(MaLop, TenLop, SoLuong, TrangThai, GhiChu);
                        list.Add(nv);
                    }
                }
            }
            return list;
        }

        private void Button2_Click(object sender, EventArgs e)
        {
            load("select * from BangDiem");
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            int x;
            bool check = false;
            list = Select();
            for (int i = 0; i < list.Count; i++)
            {
                if (list[i].MaLop1.Equals(textBox1.Text))
                {
                    MessageBox.Show("Đã có mã lớp này!!", "message");
                    check = true;
                }
            }
            if(check==false && textBox1.Text.Trim() !="" && textBox2.Text.Trim() != "" && textBox3.Text.Trim() != "" && int.TryParse(textBox3.Text, out x))
            {
                string sql = "exec pro5 N'" + textBox1.Text + "',N'" + textBox2.Text + "','" + textBox3.Text + "',N'" + textBox4.Text + "',N'" + textBox5.Text + "'";
                run(sql);
                load("select * from DoiBong");
            }
        }

        private void Button4_Click(object sender, EventArgs e)
        {
            load("select * from DoiBong");
        }

        private void Button3_Click(object sender, EventArgs e)
        {
            Disconnect();
            this.Close();
        }

    }
}
