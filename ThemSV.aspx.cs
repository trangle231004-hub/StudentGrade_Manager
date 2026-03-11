using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace DOAN_HQTCSDL
{
    public partial class ThemSV : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["QLDIEMConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Kiểm tra kết nối SQL
                try
                {
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        conn.Open();
                        lblMessage.Text = "Kết nối SQL thành công!";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        lblMessage.Visible = true;
                        conn.Close();
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Lỗi kết nối SQL: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Visible = true;
                    return; // Dừng lại nếu không kết nối được
                }

                LoadMaLop();
            }
            if (Session["SuccessMessage"] != null)
            {
                lblMessage.Text = Session["SuccessMessage"].ToString();
                lblMessage.Visible = true;
                Session["SuccessMessage"] = null;
            }
        }

        private void LoadMaLop()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT MALOP FROM LOP", conn); // Chỉ lấy MALOP
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    if (dt.Rows.Count == 0)
                    {
                        lblMessage.Text = "Không có lớp nào trong CSDL. Vui lòng thêm lớp trước!";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        lblMessage.Visible = true;
                        return;
                    }
                    ddlMaLop.DataSource = dt;
                    ddlMaLop.DataTextField = "MALOP"; // Hiển thị MALOP
                    ddlMaLop.DataValueField = "MALOP"; // Giá trị là MALOP
                    ddlMaLop.DataBind();
                    ddlMaLop.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Chọn lớp", "")); // Thêm mục mặc định
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Lỗi khi tải danh sách lớp: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Visible = true;
                }
                finally
                {
                    conn.Close();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Kiểm tra validation client-side trước
            if (!Page.IsValid)
            {
                return;
            }

            // Ẩn tất cả thông báo lỗi trước khi kiểm tra
            lblMaSVError.Visible = false;
            lblTenSVError.Visible = false;
            lblHoLotError.Visible = false;
            lblPhaiError.Visible = false;
            lblNgaySinhError.Visible = false;
            lblDiaChiError.Visible = false;
            lblDienThoaiError.Visible = false;
            lblMaLopError.Visible = false;
            lblMessage.Visible = false;

            try
            {
                // Kiểm tra server-side cơ bản (chỉ kiểm tra đầu vào, không tự tạo lỗi)
                if (string.IsNullOrEmpty(txtMaSV.Text) || string.IsNullOrEmpty(txtTenSV.Text) ||
                    string.IsNullOrEmpty(txtHoLot.Text) || string.IsNullOrEmpty(ddlPhai.SelectedValue) ||
                    string.IsNullOrEmpty(txtNgaySinh.Text) || string.IsNullOrEmpty(txtDiaChi.Text) ||
                    string.IsNullOrEmpty(txtDienThoai.Text) || string.IsNullOrEmpty(ddlMaLop.SelectedValue))
                {
                    lblMessage.Text = "Vui lòng điền đầy đủ thông tin!";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Visible = true;
                    return;
                }

                if (!DateTime.TryParse(txtNgaySinh.Text, out DateTime ngaySinh))
                {
                    lblMessage.Text = "Ngày sinh không hợp lệ!";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Visible = true;
                    return;
                }

                // Thực hiện thêm sinh viên, để SQL Server tự tạo lỗi
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("ThemSinhVien", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@MASV", txtMaSV.Text.Trim());
                    cmd.Parameters.AddWithValue("@TENSV", txtTenSV.Text.Trim());
                    cmd.Parameters.AddWithValue("@HOLOT", txtHoLot.Text.Trim());
                    cmd.Parameters.AddWithValue("@PHAI", Convert.ToBoolean(int.Parse(ddlPhai.SelectedValue)));
                    cmd.Parameters.AddWithValue("@NGAYSINH", DateTime.Parse(txtNgaySinh.Text));
                    cmd.Parameters.AddWithValue("@DIACHI", txtDiaChi.Text.Trim());
                    cmd.Parameters.AddWithValue("@DIENTHOAI", txtDienThoai.Text.Trim());
                    cmd.Parameters.AddWithValue("@MALOP", ddlMaLop.SelectedValue.Trim());

                    SqlParameter usernameParam = new SqlParameter("@Username", SqlDbType.NVarChar, 50)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(usernameParam);

                    SqlParameter passwordParam = new SqlParameter("@Password", SqlDbType.NVarChar, 10)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(passwordParam);

                    // Thực thi, để SQL Server ném lỗi
                    cmd.ExecuteNonQuery();

                    // Nếu không có ngoại lệ, hiển thị thông báo thành công
                    string username = usernameParam.Value.ToString();
                    string password = passwordParam.Value.ToString();
                    lblMessage.Text = $"Thêm sinh viên thành công! Username: {username}, Password: {password}";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Visible = true;

                    // Làm mới form
                    ClearInputFields();
                }
            }
            catch (SqlException ex)
            {
                // Lấy và hiển thị thông điệp lỗi từ SQL Server nguyên vẹn
                lblMessage.Text = ex.Message.Trim();
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
            }
            catch (Exception ex)
            {
                // Hiển thị lỗi hệ thống nếu có
                lblMessage.Text = $"Lỗi hệ thống: {ex.Message}";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
            }
        }

        private void ClearInputFields()
        {
            txtMaSV.Text = "";
            txtTenSV.Text = "";
            txtHoLot.Text = "";
            ddlPhai.SelectedIndex = 0;
            txtNgaySinh.Text = "";
            txtDiaChi.Text = "";
            txtDienThoai.Text = "";
            ddlMaLop.SelectedIndex = 0;
        }
    }
}