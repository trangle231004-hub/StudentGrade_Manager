using System;
using System.Web.UI;

namespace DOAN_HQTCSDL
{
    public partial class ADMIN : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra quyền admin dựa trên Session["UserID"] và Session["Role"]
            if (Session["UserID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("LOGIN.aspx");
            }
        }

        protected void btnStudent_Click(object sender, EventArgs e)
        {
            Response.Redirect("QuanLySinhVien.aspx");
        }

        protected void btnScore_Click(object sender, EventArgs e)
        {
            Response.Redirect("QuanLyDiem.aspx");
        }

        protected void btnClass_Click(object sender, EventArgs e)
        {
            Response.Redirect("QuanLyLop.aspx");
        }

        protected void btnSubject_Click(object sender, EventArgs e)
        {
            Response.Redirect("QuanLyMonHoc.aspx");
        }

        protected void btnStats_Click(object sender, EventArgs e)
        {
            Response.Redirect("ThongKeDiem.aspx");
        }

        protected void btnAccount_Click(object sender, EventArgs e)
        {
            Response.Redirect("QuanLyTaiKhoan.aspx");
        }

        protected void btnBackup_Click(object sender, EventArgs e)
        {
            Response.Redirect("Backup.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("LOGIN.aspx");
        }
        

    }
}