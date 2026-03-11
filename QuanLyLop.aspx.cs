using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DOAN_HQTCSDL
{
    public partial class QuanLyLop : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["QLDIEMConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLop();
                lblMaLopError.Visible = false;
                lblTenLopError.Visible = false;
                lblCVHTError.Visible = false;
            }
        }

        private void LoadLop()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("TimKiemLH", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MALOP", DBNull.Value);
                    cmd.Parameters.AddWithValue("@TENLOP", DBNull.Value);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvLop.DataSource = dt;
                    gvLop.DataBind();
                    lblMessage.Text = dt.Rows.Count > 0 ? "" : "Không có dữ liệu lớp!";
                    lblMessage.ForeColor = dt.Rows.Count > 0 ? System.Drawing.Color.Green : System.Drawing.Color.Red;
                }
                catch (SqlException ex)
                {
                    lblMessage.Text = "Lỗi khi tải dữ liệu: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Lỗi hệ thống: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
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
                    SqlCommand cmd = new SqlCommand("TimKiemLH", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                   
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvLop.DataSource = dt;
                    gvLop.DataBind();
                    lblMessage.Text = dt.Rows.Count > 0 ? "" : "Không tìm thấy kết quả!";
                    lblMessage.ForeColor = dt.Rows.Count > 0 ? System.Drawing.Color.Green : System.Drawing.Color.Red;
                }
                catch (SqlException ex)
                {
                    lblMessage.Text = $"Lỗi SQL: {ex.Number} - {ex.Message}";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Lỗi hệ thống: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
                finally
                {
                    conn.Close();
                }
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            lblMaLopError.Visible = false;
            lblTenLopError.Visible = false;
            lblCVHTError.Visible = false;
            lblMessage.Visible = false;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("ThemLH", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@MALOP", string.IsNullOrEmpty(txtMaLop.Text) ? (object)DBNull.Value : txtMaLop.Text.Trim());
                    cmd.Parameters.AddWithValue("@TENLOP", string.IsNullOrEmpty(txtTenLop.Text) ? (object)DBNull.Value : txtTenLop.Text.Trim());
                    cmd.Parameters.AddWithValue("@CVHT", string.IsNullOrEmpty(txtCVHT.Text) ? (object)DBNull.Value : txtCVHT.Text.Trim());

                    cmd.ExecuteNonQuery();
                    lblMessage.Text = "Thêm lớp thành công!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    btnReset_Click(sender, e);
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
            lblMaLopError.Visible = false;
            lblTenLopError.Visible = false;
            lblCVHTError.Visible = false;
            lblMessage.Visible = false;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SuaLH", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@MALOP", string.IsNullOrEmpty(txtMaLop.Text) ? (object)DBNull.Value : txtMaLop.Text.Trim());
                    cmd.Parameters.AddWithValue("@TENLOP", string.IsNullOrEmpty(txtTenLop.Text) ? (object)DBNull.Value : txtTenLop.Text.Trim());
                    cmd.Parameters.AddWithValue("@CVHT", string.IsNullOrEmpty(txtCVHT.Text) ? (object)DBNull.Value : txtCVHT.Text.Trim());

                    cmd.ExecuteNonQuery();
                    lblMessage.Text = "Cập nhật lớp thành công!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    btnReset_Click(sender, e);
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
            lblMaLopError.Visible = false;
            lblTenLopError.Visible = false;
            lblCVHTError.Visible = false;
            lblMessage.Visible = false;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("XoaLH", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@MALOP", string.IsNullOrEmpty(txtMaLop.Text) ? (object)DBNull.Value : txtMaLop.Text.Trim());

                    cmd.ExecuteNonQuery();
                    lblMessage.Text = "Xóa lớp thành công!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    btnReset_Click(sender, e);
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
            txtMaLop.Text = "";
            txtTenLop.Text = "";
            txtCVHT.Text = "";
            txtSearch.Text = "";
            lblMaLopError.Visible = false;
            lblTenLopError.Visible = false;
            lblCVHTError.Visible = false;
            lblMessage.Text = "";
            LoadLop();
        }

        protected void gvLop_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                string maLop = e.CommandArgument.ToString();
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    try
                    {
                        conn.Open();
                        SqlCommand cmd = new SqlCommand("SELECT * FROM LOP WHERE MALOP = @MALOP", conn);
                        cmd.Parameters.AddWithValue("@MALOP", maLop);
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            txtMaLop.Text = reader["MALOP"].ToString();
                            txtTenLop.Text = reader["TENLOP"].ToString();
                            txtCVHT.Text = reader["CVHT"].ToString();
                        }
                        reader.Close();
                    }
                    catch (SqlException ex)
                    {
                        lblMessage.Text = "Lỗi khi chọn bản ghi: " + ex.Message;
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Lỗi hệ thống: " + ex.Message;
                        lblMessage.ForeColor = System.Drawing.Color.Red;
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