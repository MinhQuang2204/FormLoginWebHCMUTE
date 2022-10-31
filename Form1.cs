using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace QuanLySinhVien
{
    public partial class FormLogin : Form
    {
        string strConnectionString = "Data Source=.;Initial Catalog=QUANLYSV;Integrated Security = True";
        SqlConnection conn = null;

        public FormLogin()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(strConnectionString);
            this.KeyPreview = true;
            this.KeyDown += Form1_KeyDown;
        }

        private void Form1_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                button1_Click(sender, e);
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            DialogResult dg = MessageBox.Show("Bạn có muốn thoát ?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (dg == DialogResult.Yes)
                Application.Exit();
        }

        private void radiobtnShowPass_CheckedChanged(object sender, EventArgs e)
        {
            if (radiobtnShowPass.Checked)
            {
                txtPassword.PasswordChar = (char)0;
            }
            else
            {
                txtPassword.PasswordChar = '*';
            }
        }

        public static string ID_USER = "";

        private string getID(string username, string password)
        {
            string id = "";
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM TAIKHOAN WHERE TenDangNhap ='" + username + "' and MatKhau='" + password + "'", conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt != null)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        id = dr["TenDangNhap"].ToString();
                    }
                }
            }
            catch (Exception)
            {
                MessageBox.Show("Lỗi xảy ra khi truy vấn dữ liệu hoặc kết nối với server thất bại !");
            }
            finally
            {
                conn.Close();
            }
            return id;
        }

        private string getIDper(string id_user)
        {
            string id = "";
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM TAIKHOAN WHERE TenDangNhap ='" + id_user + "'", conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt != null)
                {
                    foreach (DataRow dr in dt.Rows)
                    {                      
                            id = dr["VaiTro"].ToString();                        
                    }
                }
            }
            catch (Exception)
            {
                MessageBox.Show("Lỗi xảy ra khi truy vấn dữ liệu hoặc kết nối với server thất bại !");
            }
            finally
            {
                conn.Close();
            }
            return id;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            ID_USER = getID(txtUsername.Text, txtPassword.Text);
            if (ID_USER != "")
            {
                MessageBox.Show("Đăng nhập thành công");
                MessageBox.Show("Xin chào " + getIDper(ID_USER) + " có ID là: " + FormLogin.ID_USER);
                FormMain fmain = new FormMain();
                fmain.Show();
                this.Hide();
            }
            else
            {
                MessageBox.Show("Tên đăng nhập hoặc mật khẩu không đúng !");
            }
            if (String.IsNullOrEmpty(txtUsername.Text.Trim()))
            {
                MessageBox.Show("Please enter username!");
                txtUsername.Focus();
                return;
            }
        }
        private void txtUsername_Enter(object sender, EventArgs e)
        {

        }
    }
}
