<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Backup.aspx.cs" Inherits="DOAN_HQTCSDL.Backup" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Backup Dữ Liệu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #ffdde1, #ee9ca7);
            margin: 20px;
            display: flex;
            justify-content: center;
            min-height: 100vh;
            position: relative; /* Thêm để hỗ trợ vị trí tuyệt đối cho nút Quay lại */
        }
        .container {
            width: 600px;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(255, 20, 147, 0.3);
            border-left: 5px solid #ff69b4;
            animation: fadeIn 0.5s ease-in-out;
            text-align: center;
            position: relative; /* Đảm bảo container có thể chứa nút tuyệt đối */
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h2 {
            text-align: center;
            color: #ff1493;
            font-size: 28px;
            margin-bottom: 20px;
            border-bottom: 2px solid #ff69b4;
            padding-bottom: 10px;
        }
        .button {
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 6px;
            font-size: 16px;
            transition: 0.3s;
            font-weight: bold;
            width: 150px;
        }
        .btn-backup { background: linear-gradient(to right, #ff69b4, #ff1493); color: white; }
        .btn-backup:hover { background: linear-gradient(to right, #ff1493, #ff69b4); box-shadow: 0 3px 8px rgba(255, 20, 147, 0.3); }
        .btn-download { background: linear-gradient(to right, #ffb6c1, #ff8c94); color: white; }
        .btn-download:hover { background: linear-gradient(to right, #ff8c94, #ffb6c1); box-shadow: 0 3px 8px rgba(255, 140, 148, 0.3); }
        .btn-back {
            position: absolute;
            top: 20px;
            left: 20px;
            background: linear-gradient(to right, #d3d3d3, #a9a9a9);
            color: #333;
            padding: 8px 15px;
            border-radius: 6px;
            font-size: 14px;
            transition: 0.3s;
            font-weight: bold;
            width: auto; /* Điều chỉnh để tự động lấy kích thước */
        }
        .btn-back:hover {
            background: linear-gradient(to right, #a9a9a9, #d3d3d3);
            box-shadow: 0 3px 8px rgba(169, 169, 169, 0.3);
            transform: scale(1.05);
        }
        .status-message {
            margin-top: 20px;
            font-size: 16px;
            font-weight: bold;
        }
        .status-message.success { color: #28a745; }
        .status-message.error { color: #dc3545; }
        .backup-info {
            margin-top: 15px;
            font-size: 14px;
            color: #ff1493;
        }
        .backup-info a {
            color: #ff69b4;
            text-decoration: none;
        }
        .backup-info a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- Nút Quay lại ở góc trái trên cùng -->
            <asp:Button ID="btnBack" runat="server" CssClass="button btn-back" Text="🔙 Quay lại" OnClick="btnBack_Click" />

            <h2>Backup Dữ Liệu</h2>
            <asp:Button ID="btnBackup" runat="server" CssClass="button btn-backup" Text="Backup Ngay" OnClick="btnBackup_Click" />
            <div class="status-message">
                <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
            </div>
            <div class="backup-info">
                <asp:HyperLink ID="lnkDownload" runat="server" Visible="false" Text="Tải file backup"></asp:HyperLink>
            </div>
        </div>
    </form>
</body>
</html>