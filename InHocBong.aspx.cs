using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace DOAN_HQTCSDL
{
    public partial class InHocBong : System.Web.UI.Page
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

                LoadHocBongData();
            }
        }

        private void LoadHocBongData()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("EXEC InHocBongTheoLop", conn);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count == 0)
                    {
                        lblMessage.Text = "Không có sinh viên nào đủ điều kiện nhận học bổng!";
                        lblMessage.Visible = true;
                        gvHocBong.DataSource = null;
                        gvHocBong.DataBind();
                    }
                    else
                    {
                        gvHocBong.DataSource = dt;
                        gvHocBong.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi khi tải danh sách học bổng: " + ex.Message;
                lblMessage.Visible = true;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("QuanLySinhVien.aspx");
        }
    }
}