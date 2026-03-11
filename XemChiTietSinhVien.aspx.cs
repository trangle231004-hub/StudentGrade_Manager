using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace DOAN_HQTCSDL
{
    public partial class XemChiTietSinhVien : System.Web.UI.Page
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
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("EXEC XemDiemSinhVien_C5 @MASV", conn);
                    cmd.Parameters.AddWithValue("@MASV", txtMASV.Text.Trim());

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count == 0)
                    {
                        lblMessage.Text = "Không tìm thấy sinh viên với mã " + txtMASV.Text;
                        lblMessage.Visible = true;
                        gvSinhVienDetail.DataSource = null;
                        gvSinhVienDetail.DataBind();
                    }
                    else
                    {
                        gvSinhVienDetail.DataSource = dt;
                        gvSinhVienDetail.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi khi xem chi tiết sinh viên: " + ex.Message;
                lblMessage.Visible = true;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("QuanLySinhVien.aspx");
        }
    }
}