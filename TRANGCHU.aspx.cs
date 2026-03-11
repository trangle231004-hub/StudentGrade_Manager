using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;

namespace DOAN_HQTCSDL
{
    public partial class TRANGCHU : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["QLDIEMConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UpdateUiForCurrentUser();
            }
        }

        private void UpdateUiForCurrentUser()
        {
            var userId = Session["UserID"]?.ToString();
            var role = Session["Role"]?.ToString();

            if (!string.IsNullOrEmpty(userId))
            {
                // Try to get display name for students; admins are labeled "Quản trị viên"
                string displayName = GetDisplayName(userId, role);
                lblWelcome.Text = $"<strong>Xin chào</strong><br/>{HttpUtility.HtmlEncode(displayName)}";
                pnlLogged.Visible = true;
                pnlNotLogged.Visible = false;
            }
            else
            {
                pnlLogged.Visible = false;
                pnlNotLogged.Visible = true;
            }
        }

        // Safe query to get student's full name (if exists). Falls back to userId or role label.
        private string GetDisplayName(string userId, string role)
        {
            if (string.Equals(role, "Admin", StringComparison.OrdinalIgnoreCase))
                return "Quản trị viên";

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand("SELECT HOTEN FROM SINHVIEN WHERE MASV = @MASV", conn))
                    {
                        cmd.Parameters.AddWithValue("@MASV", userId);
                        object result = cmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            string hoten = result.ToString();
                            if (!string.IsNullOrWhiteSpace(hoten))
                                return hoten;
                        }
                    }
                }
            }
            catch
            {
                // ignore DB errors and fallback to userId
            }

            return userId; // fallback
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // include return URL so login page can redirect back if desired
            string returnUrl = Server.UrlEncode(Request.Url.AbsoluteUri);
            Response.Redirect($"LOGIN.aspx?returnUrl={returnUrl}");
        }

        protected void btnDashboard_Click(object sender, EventArgs e)
        {
            var role = Session["Role"]?.ToString();
            if (string.Equals(role, "Admin", StringComparison.OrdinalIgnoreCase))
                Response.Redirect("ADMIN.aspx");
            else
                Response.Redirect("XemDiem.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            try
            {
                Session.Clear();
                Session.Abandon();

                if (Request.Cookies["LoginInfo"] != null)
                {
                    var cookie = new HttpCookie("LoginInfo") { Expires = DateTime.Now.AddDays(-1) };
                    Response.Cookies.Add(cookie);
                }
            }
            catch
            {
                // ignore logout cleanup errors
            }

            Response.Redirect(Request.Url.AbsolutePath);
        }
    }
}