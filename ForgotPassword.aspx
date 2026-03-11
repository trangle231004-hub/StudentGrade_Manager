<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="DOAN_HQTCSDL.ForgotPassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quên mật khẩu</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #fff0f5, #ffe4e1);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            overflow: hidden;
        }

        .forgot-container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0px 5px 20px rgba(255, 105, 180, 0.3);
            text-align: center;
            width: 400px;
            animation: fadeInUp 1s ease-out;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            color: #ff1493;
            margin-bottom: 30px;
            font-weight: 600;
        }

        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .input-field {
            width: 100%;
            padding: 12px;
            margin: 5px 0;
            border: 1px solid #ff69b4;
            border-radius: 8px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }

        .input-field:focus {
            outline: none;
            border-color: #ff1493;
            box-shadow: 0 0 5px rgba(255, 20, 147, 0.3);
        }

        .message {
            color: #ff1493;
            font-size: 14px;
            margin-bottom: 15px;
        }

        .button {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: none;
            border-radius: 8px;
            font-size: 16px;
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

        .btn-back {
            background: transparent;
            color: #ff1493;
            border: none;
            text-decoration: underline;
            cursor: pointer;
            font-size: 14px;
            margin-top: 10px;
        }

        .btn-back:hover {
            color: #ff69b4;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="forgot-container">
            <h2>Quên mật khẩu</h2>
            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
            <div class="input-group">
                <asp:TextBox ID="txtUsername" runat="server" CssClass="input-field" Placeholder="Nhập mã sinh viên"></asp:TextBox>
            </div>
            <asp:Button ID="btnSubmit" runat="server" CssClass="button btn-submit" Text="Gửi yêu cầu" OnClick="btnSubmit_Click" />
            <asp:Button ID="btnBack" runat="server" CssClass="btn-back" Text="Quay lại đăng nhập" OnClick="btnBack_Click" CausesValidation="false" />
        </div>
    </form>
</body>
</html>