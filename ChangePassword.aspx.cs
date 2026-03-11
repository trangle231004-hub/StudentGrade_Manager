using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace DOAN_HQTCSDL
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["QLDIEMConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("LOGIN.aspx");
                }
                else
                {
                    txtUsername.Text = Session["UserID"].ToString();
                    txtUsername.ReadOnly = true;
                }
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string oldPassword = txtOldPassword.Text.Trim();
            string newPassword = txtNewPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(oldPassword) || string.IsNullOrEmpty(newPassword) || string.IsNullOrEmpty(confirmPassword))
            {
                lblMessage.Text = "Vui lòng điền đầy đủ thông tin!";
                return;
            }

            if (newPassword != confirmPassword)
            {
                lblMessage.Text = "Mật khẩu mới và xác nhận không khớp!";
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand("ChangePassword", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@OldPassword", oldPassword);
                        cmd.Parameters.AddWithValue("@NewPassword", newPassword);

                        // Thực thi stored procedure và lấy kết quả
                        string result = cmd.ExecuteScalar()?.ToString();

                        if (result == "Thay đổi mật khẩu thành công!")
                        {
                            lblMessage.Text = result;
                            lblMessage.ForeColor = System.Drawing.Color.Green;
                            Response.Redirect("XemDiem.aspx");
                        }
                        else
                        {
                            lblMessage.Text = result;
                        }
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
            Response.Redirect("XemDiem.aspx");
        }
    }
}