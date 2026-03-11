using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace DOAN_HQTCSDL
{
    public partial class XemDanhSachLop : System.Web.UI.Page
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

                    // Hiển thị MALOP thay vì TENLOP
                    ddlMALOP.DataSource = dt;
                    ddlMALOP.DataTextField = "MALOP"; // Sửa từ TENLOP thành MALOP để hiển thị mã lớp
                    ddlMALOP.DataValueField = "MALOP";
                    ddlMALOP.DataBind();
                    ddlMALOP.Items.Insert(0, new ListItem("-- Chọn mã lớp --", ""));
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Lỗi khi tải danh sách lớp: " + ex.Message;
                    lblMessage.Visible = true;
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
            try
            {
                if (ddlMALOP.SelectedValue == "")
                {
                    lblMessage.Text = "Vui lòng chọn mã lớp!";
                    lblMessage.Visible = true;
                    return;
                }

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("EXEC XemDanhSachLop_C8 @MALOP", conn);
                    cmd.Parameters.AddWithValue("@MALOP", ddlMALOP.SelectedValue);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count == 0)
                    {
                        lblMessage.Text = "Không có sinh viên trong lớp " + ddlMALOP.SelectedValue;
                        lblMessage.Visible = true;
                        gvLopDetail.DataSource = null;
                        gvLopDetail.DataBind();
                    }
                    else
                    {
                        gvLopDetail.DataSource = dt;
                        gvLopDetail.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi khi xem danh sách lớp: " + ex.Message;
                lblMessage.Visible = true;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("QuanLySinhVien.aspx");
        }
    }
}