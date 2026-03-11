using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DOAN_HQTCSDL
{
    public partial class QuanLyDiem : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["QLDIEMConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDiem();
                editModal.Style["display"] = "none"; // Ẩn modal khi load
                lblMaSVError.Visible = false;
                lblMaMHErr.Visible = false;
                lblDiemError.Visible = false;
            }
        }

        private void LoadDiem()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("TimKiemDIEM", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MASV", DBNull.Value);
                    cmd.Parameters.AddWithValue("@MAMH", DBNull.Value);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvDiem.DataSource = dt;
                    gvDiem.DataBind();
                    lblMessage.Text = dt.Rows.Count > 0 ? "" : "Không có dữ liệu điểm!";
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
                finally
                {
                    conn.Close();
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchText = txtSearch.Text.Trim();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("TimKiemDIEM", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MASV", string.IsNullOrEmpty(searchText) ? (object)DBNull.Value : searchText);
                    cmd.Parameters.AddWithValue("@MAMH", string.IsNullOrEmpty(searchText) ? (object)DBNull.Value : searchText);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvDiem.DataSource = dt;
                    gvDiem.DataBind();
                    lblMessage.Text = dt.Rows.Count > 0 ? "" : "Không tìm thấy kết quả!";
                    lblMessage.ForeColor = dt.Rows.Count > 0 ? System.Drawing.Color.Green : System.Drawing.Color.Red;
                    lblMessage.Visible = true;
                }
                catch (SqlException ex)
                {
                    lblMessage.Text = "Lỗi khi tìm kiếm: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Visible = true;
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Lỗi hệ thống: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Visible = true;
                }
                finally
                {
                    conn.Close();
                }
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            lblMaSVError.Visible = false;
            lblMaMHErr.Visible = false;
            lblDiemError.Visible = false;
            lblMessage.Visible = false;

            try
            {
                double diemCC, diemTD, diemGK, diemDA, diemCK;

                // Kiểm tra và parse điểm
                if (!double.TryParse(txtDiemCC.Text.Trim(), out diemCC))
                    throw new FormatException("Điểm CC không hợp lệ!");
                if (!double.TryParse(txtDiemTD.Text.Trim(), out diemTD))
                    throw new FormatException("Điểm TD không hợp lệ!");
                if (!double.TryParse(txtDiemGK.Text.Trim(), out diemGK))
                    throw new FormatException("Điểm GK không hợp lệ!");
                if (!double.TryParse(txtDiemDA.Text.Trim(), out diemDA))
                    throw new FormatException("Điểm DA không hợp lệ!");
                if (!double.TryParse(txtDiemCK.Text.Trim(), out diemCK))
                    throw new FormatException("Điểm CK không hợp lệ!");

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("ThemDIEM", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@MASV", string.IsNullOrEmpty(txtMaSV.Text) ? (object)DBNull.Value : txtMaSV.Text.Trim());
                    cmd.Parameters.AddWithValue("@MAMH", string.IsNullOrEmpty(txtMaMH.Text) ? (object)DBNull.Value : txtMaMH.Text.Trim());
                    cmd.Parameters.AddWithValue("@DIEMCC", diemCC);
                    cmd.Parameters.AddWithValue("@DIEMTD", diemTD);
                    cmd.Parameters.AddWithValue("@DIEMGK", diemGK);
                    cmd.Parameters.AddWithValue("@DIEMDA", diemDA);
                    cmd.Parameters.AddWithValue("@DIEMCK", diemCK);

                    cmd.ExecuteNonQuery();
                    lblMessage.Text = "Thêm điểm thành công!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Visible = true;

                    // Chỉ gọi reset sau khi thông báo đã hiển thị
                    btnReset_Click(sender, e);
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

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            lblMaSVError.Visible = false;
            lblMaMHErr.Visible = false;
            lblDiemError.Visible = false;
            lblMessage.Visible = false;

            try
            {
                double diemCC, diemTD, diemGK, diemDA, diemCK;

                // Kiểm tra và parse điểm
                if (!double.TryParse(txtDiemCC.Text.Trim(), out diemCC))
                    throw new FormatException("Điểm CC không hợp lệ!");
                if (!double.TryParse(txtDiemTD.Text.Trim(), out diemTD))
                    throw new FormatException("Điểm TD không hợp lệ!");
                if (!double.TryParse(txtDiemGK.Text.Trim(), out diemGK))
                    throw new FormatException("Điểm GK không hợp lệ!");
                if (!double.TryParse(txtDiemDA.Text.Trim(), out diemDA))
                    throw new FormatException("Điểm DA không hợp lệ!");
                if (!double.TryParse(txtDiemCK.Text.Trim(), out diemCK))
                    throw new FormatException("Điểm CK không hợp lệ!");

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("CapNhatDIEM", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@MASV", string.IsNullOrEmpty(txtMaSV.Text) ? (object)DBNull.Value : txtMaSV.Text.Trim());
                    cmd.Parameters.AddWithValue("@MAMH", string.IsNullOrEmpty(txtMaMH.Text) ? (object)DBNull.Value : txtMaMH.Text.Trim());
                    cmd.Parameters.AddWithValue("@DIEMCC", diemCC);
                    cmd.Parameters.AddWithValue("@DIEMTD", diemTD);
                    cmd.Parameters.AddWithValue("@DIEMGK", diemGK);
                    cmd.Parameters.AddWithValue("@DIEMDA", diemDA);
                    cmd.Parameters.AddWithValue("@DIEMCK", diemCK);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = "Cập nhật điểm thành công!";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        lblMessage.Visible = true;

                        // Chỉ gọi reset sau khi thông báo đã hiển thị
                        btnReset_Click(sender, e);
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

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            lblMaSVError.Visible = false;
            lblMaMHErr.Visible = false;
            lblMessage.Visible = false;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("XoaDIEM", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@MASV", string.IsNullOrEmpty(txtMaSV.Text) ? (object)DBNull.Value : txtMaSV.Text.Trim());
                    cmd.Parameters.AddWithValue("@MAMH", string.IsNullOrEmpty(txtMaMH.Text) ? (object)DBNull.Value : txtMaMH.Text.Trim());

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = "Xóa điểm thành công!";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        lblMessage.Visible = true;

                        // Chỉ gọi reset sau khi thông báo đã hiển thị
                        btnReset_Click(sender, e);
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

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtMaSV.Text = "";
            txtMaMH.Text = "";
            txtDiemCC.Text = "";
            txtDiemTD.Text = "";
            txtDiemGK.Text = "";
            txtDiemDA.Text = "";
            txtDiemCK.Text = "";
            txtSearch.Text = "";
            lblMaSVError.Visible = false;
            lblMaMHErr.Visible = false;
            lblDiemError.Visible = false;
            LoadDiem();
        }

        protected void gvDiem_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                string[] args = e.CommandArgument.ToString().Split(',');
                string maSV = args[0];
                string maMH = args[1];

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    try
                    {
                        conn.Open();
                        SqlCommand cmd = new SqlCommand("SELECT * FROM DIEM WHERE MASV = @MASV AND MAMH = @MAMH", conn);
                        cmd.Parameters.AddWithValue("@MASV", maSV);
                        cmd.Parameters.AddWithValue("@MAMH", maMH);
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            txtMaSV.Text = reader["MASV"].ToString();
                            txtMaMH.Text = reader["MAMH"].ToString();
                            txtDiemCC.Text = reader["DIEMCC"].ToString();
                            txtDiemTD.Text = reader["DIEMTD"].ToString();
                            txtDiemGK.Text = reader["DIEMGK"].ToString();
                            txtDiemDA.Text = reader["DIEMDA"].ToString();
                            txtDiemCK.Text = reader["DIEMCK"].ToString();
                        }
                        reader.Close();
                    }
                    catch (SqlException ex)
                    {
                        lblMessage.Text = "Lỗi khi chọn bản ghi: " + ex.Message;
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        lblMessage.Visible = true;
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Lỗi hệ thống: " + ex.Message;
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        lblMessage.Visible = true;
                    }
                    finally
                    {
                        conn.Close();
                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            btnUpdate_Click(sender, e);
            ClientScript.RegisterStartupScript(this.GetType(), "HideModal", "hideModal();", true);
        }

        protected void btnCloseModal_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "HideModal", "hideModal();", true);
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
    }
}