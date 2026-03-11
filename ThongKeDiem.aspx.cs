using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DOAN_HQTCSDL
{
    public partial class ThongKeDiem : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["QLDIEMConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMonHoc();
                LoadDiemStats(); // Tải thống kê mặc định khi load trang
            }
        }

        private void LoadMonHoc()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT DISTINCT MAMH FROM DIEM", conn);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    ddlMaMH.DataSource = dt;
                    ddlMaMH.DataTextField = "MAMH";
                    ddlMaMH.DataValueField = "MAMH";
                    ddlMaMH.DataBind();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Lỗi khi tải danh sách môn học: " + ex.Message;
                }
                finally
                {
                    conn.Close();
                }
            }
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            LoadDiemStats();
        }

        private void LoadDiemStats()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    string maMH = ddlMaMH.SelectedValue;

                    // Stored Procedure để thống kê
                    SqlCommand cmd = new SqlCommand("ThongKeDiem", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MaMH", string.IsNullOrEmpty(maMH) ? (object)DBNull.Value : maMH);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        gvStats.DataSource = dt;
                        gvStats.DataBind();
                        lblMessage.Text = "";
                        // Tính và hiển thị tóm tắt
                        double tongDiemTB = Convert.ToDouble(dt.Compute("AVG(DiemTB)", ""));
                        int tongSV = Convert.ToInt32(dt.Compute("SUM(SoLuongSV)", ""));
                        lblSummary.Text = $"Tổng số SV: {tongSV} | Điểm TB toàn khóa: {tongDiemTB:F2}";
                    }
                    else
                    {
                        gvStats.DataSource = null;
                        gvStats.DataBind();
                        lblMessage.Text = "Không có dữ liệu để thống kê!";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Lỗi khi thống kê: " + ex.Message;
                }
                finally
                {
                    conn.Close();
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            // Quay lại trang Admin.aspx
            Response.Redirect("Admin.aspx");
        }
    }
}