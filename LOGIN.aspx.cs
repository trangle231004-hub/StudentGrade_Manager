using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;

namespace DOAN_HQTCSDL
{
    public partial class LOGIN : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["QLDIEMConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Kiểm tra cookie để tự động điền thông tin đăng nhập
                if (Request.Cookies["LoginInfo"] != null)
                {
                    txtMaSV.Text = Request.Cookies["LoginInfo"]["MaSV"];
                    chkRememberMe.Checked = true;
                }

                // Nếu đã đăng nhập, điều hướng thẳng đến trang chính
                if (Session["UserID"] != null)
                {
                    if (Session["Role"]?.ToString() == "Admin")
                    {
                        Response.Redirect("ADMIN.aspx");
                    }
                    else
                    {
                        Response.Redirect("XemDiem.aspx");
                    }
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        conn.Open();
                        SqlCommand cmd = new SqlCommand("SELECT Role FROM TAIKHOAN WHERE Username = @Username AND Password = @Password", conn);
                        cmd.Parameters.AddWithValue("@Username", txtMaSV.Text);
                        cmd.Parameters.AddWithValue("@Password", txtPassword.Text);

                        object result = cmd.ExecuteScalar();

                        if (result != null)
                        {
                            string role = result.ToString();
                            Session["UserID"] = txtMaSV.Text;
                            Session["Role"] = role;

                            // Lưu cookie nếu chọn "Nhớ tôi"
                            if (chkRememberMe.Checked)
                            {
                                HttpCookie cookie = new HttpCookie("LoginInfo");
                                cookie["MaSV"] = txtMaSV.Text;
                                cookie.Expires = DateTime.Now.AddDays(30);
                                Response.Cookies.Add(cookie);
                            }

                            // Chuyển hướng theo quyền
                            if (role == "Admin")
                            {
                                Response.Redirect("ADMIN.aspx");
                            }
                            else
                            {
                                Response.Redirect("XemDiem.aspx");
                            }
                        }
                        else
                        {
                            lblMessage.Text = "Mã sinh viên hoặc mật khẩu không đúng!";
                            lblMessage.Style["display"] = "block";
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Lỗi khi đăng nhập: " + ex.Message;
                    lblMessage.Style["display"] = "block";
                }
            }
        }

        protected void btnForgotPassword_Click(object sender, EventArgs e)
        {
            Response.Redirect("ForgotPassword.aspx");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("TRANGCHU.aspx");
        }
    }
}