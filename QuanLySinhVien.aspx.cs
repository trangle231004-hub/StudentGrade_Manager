using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;

namespace DOAN_HQTCSDL
{
    public partial class QuanLySinhVien : System.Web.UI.Page
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

                LoadLopData();
                LoadSinhVien();
            }
        }

        private void LoadLopData()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT MALOP, TENLOP FROM LOP", conn);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    editMALOP.DataSource = dt;
                    editMALOP.DataTextField = "TENLOP";
                    editMALOP.DataValueField = "MALOP";
                    editMALOP.DataBind();
                }
                catch (SqlException ex)
                {
                    lblMessage.Text = "Lỗi khi tải danh sách lớp: " + ex.Message;
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

        private void LoadSinhVien()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(
                        "SELECT sv.MASV, sv.HOLOT, sv.TENSV, " +
                        "CASE WHEN sv.PHAI = 1 THEN N'Nam' ELSE N'Nữ' END AS PHAI, " +
                        "sv.NGAYSINH, sv.DIACHI, sv.DIENTHOAI, sv.MALOP " +
                        "FROM SINHVIEN sv", conn);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvSinhVien.DataSource = dt;
                    gvSinhVien.DataBind();
                    lblMessage.Text = dt.Rows.Count > 0 ? "" : "Không có dữ liệu sinh viên!";
                    lblMessage.ForeColor = dt.Rows.Count > 0 ? System.Drawing.Color.Green : System.Drawing.Color.Red;
                    lblMessage.Visible = true;
                }
            }
            catch (SqlException ex)
            {
                lblMessage.Text = "Lỗi khi tải danh sách sinh viên: " + ex.Message;
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            string searchText = txtSearch.Text.Trim();

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("TimKiemSV", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MASV", string.IsNullOrEmpty(searchText) ? (object)DBNull.Value : searchText);
                    cmd.Parameters.AddWithValue("@TENSV", string.IsNullOrEmpty(searchText) ? (object)DBNull.Value : searchText);

                    // Thêm log để kiểm tra tham số
                    System.Diagnostics.Debug.WriteLine($"SearchText: {searchText}, MASV: {cmd.Parameters["@MASV"].Value}, TENSV: {cmd.Parameters["@TENSV"].Value}");

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvSinhVien.DataSource = dt;
                    gvSinhVien.DataBind();
                    lblMessage.Text = dt.Rows.Count > 0 ? "" : "Không tìm thấy kết quả!";
                    lblMessage.ForeColor = dt.Rows.Count > 0 ? System.Drawing.Color.Green : System.Drawing.Color.Red;
                    lblMessage.Visible = true;

                    // Thêm log để kiểm tra kết quả
                    System.Diagnostics.Debug.WriteLine($"Rows returned: {dt.Rows.Count}");
                }
            }
            catch (SqlException ex)
            {
                lblMessage.Text = "Lỗi khi tìm kiếm: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
                System.Diagnostics.Debug.WriteLine($"SQL Error: {ex.Number} - {ex.Message}");
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi hệ thống: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
                System.Diagnostics.Debug.WriteLine($"General Error: {ex.Message}");
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            LoadSinhVien();
            lblMessage.Text = "Đã làm mới danh sách!";
            lblMessage.ForeColor = System.Drawing.Color.Green;
            lblMessage.Visible = true;
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("ThemSV.aspx");
        }

        protected void btnSaveModal_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;

            try
            {
                if (!DateTime.TryParse(editNGAYSINH.Text, out DateTime ngaySinh))
                    throw new FormatException("Ngày sinh không hợp lệ!");

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("sp_SuaSinhVien", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@MASV", string.IsNullOrEmpty(editMASV.Value) ? (object)DBNull.Value : editMASV.Value);
                    cmd.Parameters.AddWithValue("@TENSV", string.IsNullOrEmpty(editTENSV.Text) ? (object)DBNull.Value : editTENSV.Text.Trim());
                    cmd.Parameters.AddWithValue("@HOLOT", string.IsNullOrEmpty(editHOLOT.Text) ? (object)DBNull.Value : editHOLOT.Text.Trim());
                    cmd.Parameters.AddWithValue("@PHAI", string.IsNullOrEmpty(editPHAI.SelectedValue) ? (object)DBNull.Value : int.Parse(editPHAI.SelectedValue));
                    cmd.Parameters.AddWithValue("@NGAYSINH", ngaySinh);
                    cmd.Parameters.AddWithValue("@DIACHI", string.IsNullOrEmpty(editDIACHI.Text) ? (object)DBNull.Value : editDIACHI.Text.Trim());
                    cmd.Parameters.AddWithValue("@DIENTHOAI", string.IsNullOrEmpty(editDIENTHOAI.Text) ? (object)DBNull.Value : editDIENTHOAI.Text.Trim());
                    cmd.Parameters.AddWithValue("@MALOP", string.IsNullOrEmpty(editMALOP.SelectedValue) ? (object)DBNull.Value : editMALOP.SelectedValue);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = "Cập nhật thông tin sinh viên thành công!";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        lblMessage.Visible = true;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "CloseModal", "closeModal();", true);
                        LoadSinhVien();
                    }
                    else
                    {
                        lblMessage.Text = "Bản ghi không tồn tại!";
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
            catch (FormatException ex)
            {
                lblMessage.Text = ex.Message;
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

        protected void gvSinhVien_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteStudent")
            {
                lblMessage.Visible = false;

                try
                {
                    string masv = e.CommandArgument.ToString();
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        conn.Open();
                        SqlCommand cmd = new SqlCommand("sp_XoaSinhVien", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@MASV", masv);

                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            lblMessage.Text = "Xóa sinh viên thành công!";
                            lblMessage.ForeColor = System.Drawing.Color.Green;
                            lblMessage.Visible = true;
                            LoadSinhVien();
                        }
                        else
                        {
                            lblMessage.Text = "Bản ghi không tồn tại!";
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
        }

        protected void btnBackToAdmin_Click(object sender, EventArgs e)
        {
            Response.Redirect("ADMIN.aspx");
        }

        protected void btnViewDetailSV_Click(object sender, EventArgs e)
        {
            Response.Redirect("XemChiTietSinhVien.aspx");
        }

        protected void btnViewDetailLop_Click(object sender, EventArgs e)
        {
            Response.Redirect("XemDanhSachLop.aspx");
        }

        protected void btnInHocBong_Click(object sender, EventArgs e)
        {
            Response.Redirect("InHocBong.aspx");
        }
    }
}