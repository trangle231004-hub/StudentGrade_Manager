<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="XemDiem.aspx.cs" Inherits="DOAN_HQTCSDL.XemDiem" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Xem Điểm</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #ffdde1, #ee9ca7);
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            width: 90%;
            max-width: 1000px;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(255, 105, 180, 0.3);
            border-left: 5px solid #ff69b4;
            animation: fadeIn 0.5s ease-in-out;
            position: relative;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #fff;
            padding: 10px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .navbar-left {
            display: flex;
            align-items: center;
        }
        .navbar-right {
            display: flex;
            align-items: center;
        }
        .navbar a, .navbar .back-btn {
            text-decoration: none;
            color: #ff69b4;
            font-size: 16px;
            margin-right: 20px;
            transition: color 0.3s ease;
        }
        .navbar a:hover {
            color: #ff1493;
        }
        .back-btn {
            padding: 8px 15px;
            background-color: #ffccd5;
            color: #d1476e;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        .back-btn:hover {
            background-color: #ffb6c1;
            transform: translateY(-2px);
        }
        h2 {
            text-align: center;
            color: #ff1493;
            font-size: 28px;
            margin-bottom: 20px;
            border-bottom: 2px solid #ff69b4;
            padding-bottom: 10px;
            font-weight: 600;
        }
        .info-section {
            text-align: center;
            color: #ff1493;
            font-size: 18px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        .grid-view {
            width: 100%;
            border-collapse: collapse;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(255, 105, 180, 0.2);
            font-size: 14px;
        }
        .grid-view th, .grid-view td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ff69b4;
        }
        .grid-view th {
            background: linear-gradient(135deg, #ff69b4, #ff1493);
            color: white;
            font-weight: 600;
            text-transform: uppercase;
        }
        .grid-view tr:nth-child(even) {
            background-color: #ffe6f2;
        }
        .grid-view tr:hover {
            background-color: #ffd1dc;
            transition: background-color 0.3s ease;
        }
        .grid-view td {
            color: #333;
        }
        .error-message {
            color: red;
            font-size: 14px;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="navbar">
                <div class="navbar-left">
                    <asp:Button ID="btnBack" runat="server" CssClass="back-btn" Text="Đăng xuất" OnClick="btnBack_Click" />
                </div>
                <div class="navbar-right">
                    <a href="XemDiem.aspx">Xem Điểm</a>
                    <a href="ChangePassword.aspx">Thay đổi mật khẩu</a>
                </div>
            </div>
            <h2>Xem Điểm</h2>
            <div class="info-section">
                <asp:Label ID="lblInfo" runat="server" Text=""></asp:Label>
            </div>
            <asp:Label ID="lblMessage" runat="server" CssClass="error-message"></asp:Label>
            <asp:GridView ID="gvDiem" runat="server" CssClass="grid-view" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="MAMH" HeaderText="Mã Môn Học" />
                    <asp:BoundField DataField="TENMH" HeaderText="Tên Môn Học" />
                    <asp:BoundField DataField="DIEMCC" HeaderText="Điểm Chuyên Cần" DataFormatString="{0:F1}" />
                    <asp:BoundField DataField="DIEMTD" HeaderText="Điểm Thường Xuyên" DataFormatString="{0:F1}" />
                    <asp:BoundField DataField="DIEMGK" HeaderText="Điểm Giữa Kỳ" DataFormatString="{0:F1}" />
                    <asp:BoundField DataField="DIEMDA" HeaderText="Điểm Đồ Án" DataFormatString="{0:F1}" />
                    <asp:BoundField DataField="DIEMCK" HeaderText="Điểm Cuối Kỳ" DataFormatString="{0:F1}" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>