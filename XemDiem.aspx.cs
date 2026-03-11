using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace DOAN_HQTCSDL
{
    public partial class XemDiem : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["QLDIEMConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    lblMessage.Text = "Vui lòng đăng nhập để xem điểm!";
                    return;
                }

                string maSV = Session["UserID"]?.ToString();
                if (string.IsNullOrEmpty(maSV))
                {
                    lblMessage.Text = "Không tìm thấy mã sinh viên!";
                    return;
                }

                LoadSinhVienInfo(maSV);
                LoadDiem(maSV);
            }
        }

        private void LoadSinhVienInfo(string maSV)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT HOTEN FROM SINHVIEN WHERE MASV = @MASV", conn);
                    cmd.Parameters.AddWithValue("@MASV", maSV);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        lblInfo.Text = $"Sinh viên: {reader["HOTEN"]} | Mã SV: {maSV}";
                    }
                    else
                    {
                        lblInfo.Text = "Không tìm thấy thông tin sinh viên!";
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Lỗi khi tải thông tin sinh viên: " + ex.Message;
                }
            }
        }

        private void LoadDiem(string maSV)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("XemDiemSinhVien", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MASV", maSV);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvDiem.DataSource = dt;
                    gvDiem.DataBind();
                    lblMessage.Text = dt.Rows.Count > 0 ? "" : "Không có dữ liệu điểm!";
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Lỗi khi tải dữ liệu điểm: " + ex.Message;
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/LOGIN.aspx");
        }
    }
}