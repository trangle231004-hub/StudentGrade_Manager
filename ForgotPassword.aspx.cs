using System;
using System.Data.SqlClient;
using System.Configuration;

namespace DOAN_HQTCSDL
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["QLDIEMConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "";
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            if (string.IsNullOrEmpty(username))
            {
                lblMessage.Text = "Vui lòng nhập mã sinh viên!";
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT Password FROM TAIKHOAN WHERE Username = @Username", conn);
                    cmd.Parameters.AddWithValue("@Username", username);
                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        lblMessage.Text = $"Mật khẩu của bạn là: {result.ToString()}";
                    }
                    else
                    {
                        lblMessage.Text = "Mã sinh viên không tồn tại!";
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi: " + ex.Message;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("LOGIN.aspx");
        }
    }
}