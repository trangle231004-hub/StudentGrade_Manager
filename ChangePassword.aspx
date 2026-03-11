<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="DOAN_HQTCSDL.ChangePassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thay Đổi Mật Khẩu</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #ffdde1, #ee9ca7);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .container {
            width: 400px;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(255, 105, 180, 0.3);
            border-left: 5px solid #ff69b4;
            text-align: center;
            animation: fadeIn 0.5s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h2 {
            color: #ff1493;
            font-size: 24px;
            margin-bottom: 20px;
            font-weight: 600;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #ff1493;
            font-size: 14px;
            font-weight: 500;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ff69b4;
            border-radius: 8px;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .form-group input:focus {
            outline: none;
            border-color: #ff1493;
            box-shadow: 0 0 5px rgba(255, 20, 147, 0.3);
        }
        .form-group input[readonly] {
            background-color: #f9f9f9;
            color: #888;
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }
        .btn-submit, .back-btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .btn-submit {
            background: linear-gradient(135deg, #ff69b4, #ff1493);
            color: white;
            box-shadow: 0 5px 15px rgba(255, 105, 180, 0.4);
        }
        .btn-submit:hover {
            background: linear-gradient(135deg, #ff1493, #ff69b4);
            transform: translateY(-2px);
            box-shadow: 0 7px 20px rgba(255, 105, 180, 0.6);
        }
        .back-btn {
            background-color: #ffccd5;
            color: #d1476e;
        }
        .back-btn:hover {
            background-color: #ffb6c1;
            transform: translateY(-2px);
        }
        .message {
            margin-top: 15px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Thay Đổi Mật Khẩu</h2>
            <div class="form-group">
                <label for="txtUsername">Tên đăng nhập (MASV):</label>
                <asp:TextBox ID="txtUsername" runat="server" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtOldPassword">Mật khẩu cũ:</label>
                <asp:TextBox ID="txtOldPassword" runat="server" TextMode="Password"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtNewPassword">Mật khẩu mới:</label>
                <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="txtConfirmPassword">Xác nhận mật khẩu mới:</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
            </div>
            <div class="btn-group">
                <asp:Button ID="btnChangePassword" runat="server" CssClass="btn-submit" Text="Thay đổi" OnClick="btnChangePassword_Click" />
                <asp:Button ID="btnBack" runat="server" CssClass="back-btn" Text="Quay lại" OnClick="btnBack_Click" />
            </div>
            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
        </div>
    </form>
</body>
</html>