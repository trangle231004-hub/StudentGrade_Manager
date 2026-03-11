using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace DOAN_HQTCSDL
{
    public partial class Backup : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["QLDIEMConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "";
                lnkDownload.Visible = false;
            }
        }

        protected void btnBackup_Click(object sender, EventArgs e)
        {
            try
            {
                string dbName = new SqlConnectionStringBuilder(connStr).InitialCatalog;
                if (string.IsNullOrEmpty(dbName))
                {
                    lblMessage.Text = "Không thể xác định tên cơ sở dữ liệu!";
                    lblMessage.CssClass = "status-message error";
                    return;
                }

                string backupFolder = Server.MapPath("~/Backups/");
                if (!Directory.Exists(backupFolder))
                {
                    Directory.CreateDirectory(backupFolder);
                }

                string backupFileName = $"Backup_{dbName}_{DateTime.Now:yyyyMMdd_HHmmss}.bak";
                string backupPath = Path.Combine(backupFolder, backupFileName);

                Response.Write($"Database Name: {dbName}<br/>");
                Response.Write($"Backup Folder: {backupFolder}<br/>");
                Response.Write($"Backup Path: {backupPath}<br/>");

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string backupQuery = $"BACKUP DATABASE [{dbName}] TO DISK = @BackupPath WITH NOFORMAT, NOINIT, NAME = 'Full Backup of {dbName}', SKIP, NOREWIND, NOUNLOAD, STATS = 10";
                    using (SqlCommand cmd = new SqlCommand(backupQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@BackupPath", backupPath);
                        cmd.ExecuteNonQuery();
                    }
                    conn.Close();
                }

                if (File.Exists(backupPath))
                {
                    lblMessage.Text = "Backup thành công! Tải file ngay.";
                    lblMessage.CssClass = "status-message success";
                    Response.Clear();
                    Response.ContentType = "application/octet-stream";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + backupFileName);
                    Response.TransmitFile(backupPath);
                    Response.End();
                }
                else
                {
                    lblMessage.Text = "File backup không được tạo! Kiểm tra quyền hoặc lỗi SQL.";
                    lblMessage.CssClass = "status-message error";
                }
                lnkDownload.Visible = false; // Tắt link nếu dùng Response
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi khi backup: " + ex.Message;
                lblMessage.CssClass = "status-message error";
                lnkDownload.Visible = false;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            // Quay lại trang Admin.aspx
            Response.Redirect("Admin.aspx");
        }
    }
}