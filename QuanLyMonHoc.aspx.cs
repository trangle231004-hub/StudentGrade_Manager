using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DOAN_HQTCSDL
{
    public partial class QuanLyMonHoc : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["QLDIEMConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMonHoc();
                lblMaMHError.Visible = false;
                lblTenMHError.Visible = false;
                lblSoTCError.Visible = false;
            }
        }

        private void LoadMonHoc()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("TimKiemMH", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MAMH", DBNull.Value);
                    cmd.Parameters.AddWithValue("@TENMH", DBNull.Value);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvMonHoc.DataSource = dt;
                    gvMonHoc.DataBind();
                    lblMessage.Text = dt.Rows.Count > 0 ? "" : "Không có dữ liệu môn học!";
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
                    SqlCommand cmd = new SqlCommand("TimKiemMH", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MAMH", string.IsNullOrEmpty(searchText) ? (object)DBNull.Value : searchText);
                    cmd.Parameters.AddWithValue("@TENMH", string.IsNullOrEmpty(searchText) ? (object)DBNull.Value : searchText);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvMonHoc.DataSource = dt;
                    gvMonHoc.DataBind();
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
            lblMaMHError.Visible = false;
            lblTenMHError.Visible = false;
            lblSoTCError.Visible = false;
            lblMessage.Visible = false;

            try
            {
                int soTC;
                if (!int.TryParse(txtSoTC.Text.Trim(), out soTC))
                    throw new FormatException("Số tín chỉ không hợp lệ!");

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("ThemMH", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@MAMH", string.IsNullOrEmpty(txtMaMH.Text) ? (object)DBNull.Value : txtMaMH.Text.Trim());
                    cmd.Parameters.AddWithValue("@TENMH", string.IsNullOrEmpty(txtTenMH.Text) ? (object)DBNull.Value : txtTenMH.Text.Trim());
                    cmd.Parameters.AddWithValue("@SOTC", soTC);

                    cmd.ExecuteNonQuery();
                    lblMessage.Text = "Thêm môn học thành công!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Visible = true;

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
            lblMaMHError.Visible = false;
            lblTenMHError.Visible = false;
            lblSoTCError.Visible = false;
            lblMessage.Visible = false;

            try
            {
                int soTC;
                if (!int.TryParse(txtSoTC.Text.Trim(), out soTC))
                    throw new FormatException("Số tín chỉ không hợp lệ!");

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SuaMH", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@MAMH", string.IsNullOrEmpty(txtMaMH.Text) ? (object)DBNull.Value : txtMaMH.Text.Trim());
                    cmd.Parameters.AddWithValue("@TENMH", string.IsNullOrEmpty(txtTenMH.Text) ? (object)DBNull.Value : txtTenMH.Text.Trim());
                    cmd.Parameters.AddWithValue("@SOTC", soTC);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = "Cập nhật môn học thành công!";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        lblMessage.Visible = true;

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
            lblMaMHError.Visible = false;
            lblMessage.Visible = false;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("XoaMH", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@MAMH", string.IsNullOrEmpty(txtMaMH.Text) ? (object)DBNull.Value : txtMaMH.Text.Trim());

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = "Xóa môn học thành công!";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        lblMessage.Visible = true;

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
            txtMaMH.Text = "";
            txtTenMH.Text = "";
            txtSoTC.Text = "";
            txtSearch.Text = "";
            lblMaMHError.Visible = false;
            lblTenMHError.Visible = false;
            lblSoTCError.Visible = false;
            LoadMonHoc();
        }

        protected void gvMonHoc_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                string maMH = e.CommandArgument.ToString();
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    try
                    {
                        conn.Open();
                        SqlCommand cmd = new SqlCommand("SELECT * FROM MONHOC WHERE MAMH = @MAMH", conn);
                        cmd.Parameters.AddWithValue("@MAMH", maMH);
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            txtMaMH.Text = reader["MAMH"].ToString();
                            txtTenMH.Text = reader["TENMH"].ToString();
                            txtSoTC.Text = reader["SOTC"].ToString();
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

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
    }
}