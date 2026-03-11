<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ADMIN.aspx.cs" Inherits="DOAN_HQTCSDL.ADMIN" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #ffe6f2;
            text-align: center;
            margin: 50px;
        }
        .container {
            background: #fff0f5;
            width: 60%;
            margin: auto;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 0px 12px rgba(255, 20, 147, 0.3);
            border: 2px solid #ff1493;
            position: relative;
        }
        h2 {
            font-family: 'Pacifico', cursive;
            font-size: 35px;
            color: #ff1493;
            text-shadow: 2px 2px 4px rgba(255, 20, 147, 0.2);
        }

        /* Bố cục lưới cho các nút */
        .button-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            justify-content: center;
            margin-bottom: 20px;
        }

        .button {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            padding: 15px;
            border: none;
            border-radius: 10px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            text-align: center;
            transition: all 0.3s ease-in-out;
            box-shadow: 0px 4px 8px rgba(255, 20, 147, 0.2);
        }
        .btn-student { background-color: #ff69b4; color: white; }
        .btn-score { background-color: #ff85c2; color: white; }
        .btn-class { background-color: #ffb6c1; color: black; }
        .btn-subject { background-color: #ff1493; color: white; }
        .btn-stats { background-color: #c3e8ff; color: #333; } /* Pastel xanh nước biển */
        .btn-account { background-color: #fef9c3; color: #333; } /* Pastel vàng */
        .btn-backup { background-color: #b9fbc0; color: #333; } /* Pastel xanh lá */

        /* Hiệu ứng khi hover */
        .button:hover {
            opacity: 0.85;
            transform: scale(1.05);
        }

        /* Nút Đăng xuất */
        .logout-container {
            text-align: right;
            margin-top: 20px;
        }
        .btn-logout {
            background-color: #ffccd5;
            color: black;
            padding: 12px 20px;
            border-radius: 25px;
            font-weight: bold;
            border: 2px solid #ff7b9c;
            cursor: pointer;
            width: auto;
            transition: all 0.3s ease-in-out;
            box-shadow: 0px 4px 6px rgba(255, 20, 147, 0.2);
        }
        .btn-logout:hover {
            background-color: #ffb3c6;
            transform: scale(1.1);
            box-shadow: 0px 6px 10px rgba(255, 20, 147, 0.3);
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>🌸 Admin Dashboard 🌸</h2>
            <div class="button-grid">
                <asp:Button ID="btnStudent" runat="server" CssClass="button btn-student" Text="📚 Quản lý Sinh viên" OnClick="btnStudent_Click" />
                <asp:Button ID="btnScore" runat="server" CssClass="button btn-score" Text="📊 Quản lý Điểm" OnClick="btnScore_Click" />
                <asp:Button ID="btnClass" runat="server" CssClass="button btn-class" Text="🏫 Quản lý Lớp học" OnClick="btnClass_Click" />
                <asp:Button ID="btnSubject" runat="server" CssClass="button btn-subject" Text="📖 Quản lý Môn học" OnClick="btnSubject_Click" />
                <asp:Button ID="btnStats" runat="server" CssClass="button btn-stats" Text="📈 Thống kê Điểm" OnClick="btnStats_Click" />
                <asp:Button ID="btnAccount" runat="server" CssClass="button btn-account" Text="👤 Quản lý Tài khoản" OnClick="btnAccount_Click" />
                <asp:Button ID="btnBackup" runat="server" CssClass="button btn-backup" Text="💾 Backup Dữ liệu" OnClick="btnBackup_Click" />
            </div>

            <div class="logout-container">
                <asp:Button ID="btnLogout" runat="server" Text="🚪 Đăng xuất" CssClass="btn-logout" OnClick="btnLogout_Click"/>
            </div>
        </div>
    </form>
</body>
</html>