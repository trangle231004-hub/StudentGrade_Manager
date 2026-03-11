using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DOAN_HQTCSDL
{
    public partial class QuanLyTaiKhoan : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["QLDIEMConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null || Session["Role"]?.ToString() != "Admin")
                {
                    Response.Redirect("LOGIN.aspx");
                }

                LoadTaiKhoan();
                lblMaSVError.Visible = false;
                lblUsernameError.Visible = false;
                lblPasswordError.Visible = false;
            }
        }

        private void LoadTaiKhoan()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("LayDanhSachTaiKhoan", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvTaiKhoan.DataSource = dt;
                    gvTaiKhoan.DataBind();
                    lblMessage.Text = dt.Rows.Count > 0 ? "" : "Không có dữ liệu tài khoản!";
                    lblMessage.ForeColor = dt.Rows.Count > 0 ? System.Drawing.Color.Green : System.Drawing.Color.Red;
                    lblMessage.Visible = true;
                }
                catch (SqlException ex)
                {
                    lblMessage.Text = "Lỗi khi tải dữ liệu: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Visible = true;
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Lỗi hệ thống: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Visible = true;
                }
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            lblMaSVError.Visible = false;
            lblUsernameError.Visible = false;
            lblPasswordError.Visible = false;
            lblMessage.Visible = false;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("ThemTaiKhoan", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@MASV", txtMaSV.Text.Trim());
                    cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

                    cmd.ExecuteNonQuery();
                    lblMessage.Text = "Thêm tài khoản thành công!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Visible = true;

                    btnCancel_Click(sender, e);
                }
            }
            catch (SqlException ex)
            {
                lblMessage.Text = ex.Message.Trim();
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi hệ thống: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            lblMaSVError.Visible = false;
            lblUsernameError.Visible = false;
            lblPasswordError.Visible = false;
            lblMessage.Visible = false;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("CapNhatTaiKhoan", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@MASV", txtMaSV.Text.Trim());
                    cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = "Cập nhật tài khoản thành công!";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        lblMessage.Visible = true;

                        btnCancel_Click(sender, e);
                    }
                    else
                    {
                        lblMessage.Text = "Tài khoản không tồn tại!";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        lblMessage.Visible = true;
                    }
                }
            }
            catch (SqlException ex)
            {
                lblMessage.Text = ex.Message.Trim();
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi hệ thống: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            lblMaSVError.Visible = false;
            lblUsernameError.Visible = false;
            lblPasswordError.Visible = false;
            lblMessage.Visible = false;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("XoaTaiKhoan", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@MASV", txtMaSV.Text.Trim());

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = "Xóa tài khoản thành công!";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        lblMessage.Visible = true;

                        btnCancel_Click(sender, e);
                    }
                    else
                    {
                        lblMessage.Text = "Tài khoản không tồn tại!";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        lblMessage.Visible = true;
                    }
                }
            }
            catch (SqlException ex)
            {
                lblMessage.Text = ex.Message.Trim();
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi hệ thống: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            txtMaSV.Text = "";
            txtUsername.Text = "";
            txtPassword.Text = "";
            lblMaSVError.Visible = false;
            lblUsernameError.Visible = false;
            lblPasswordError.Visible = false;
            LoadTaiKhoan();
        }

        protected void gvTaiKhoan_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gvTaiKhoan.Rows[index];
                txtMaSV.Text = row.Cells[0].Text.Trim();
                txtUsername.Text = row.Cells[1].Text.Trim();
                txtPassword.Text = row.Cells[2].Text.Trim();
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
    }
}