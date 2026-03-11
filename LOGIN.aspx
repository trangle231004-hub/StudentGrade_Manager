<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LOGIN.aspx.cs" Inherits="DOAN_HQTCSDL.LOGIN" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng nhập</title>
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

        .login-container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0px 5px 20px rgba(255, 105, 180, 0.3);
            text-align: center;
            width: 400px;
            animation: fadeInUp 1s ease-out;
            position: relative; /* Để căn chỉnh nút Quay lại */
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .btn-back {
            position: absolute;
            top: 15px;
            left: 15px;
            background: none;
            border: none;
            font-size: 24px;
            color: #ff69b4; /* Màu hồng giống giao diện */
            cursor: pointer;
            transition: color 0.3s ease, transform 0.3s ease;
        }

        .btn-back:hover {
            color: #ff1493; /* Đậm hơn khi hover */
            transform: scale(1.2); /* Phóng to nhẹ khi hover */
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

        .validation-error {
            color: red;
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-bottom: 15px;
            display: none;
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

        .btn-login {
            background: linear-gradient(135deg, #ff69b4, #ff1493);
            color: white;
            box-shadow: 0 5px 15px rgba(255, 105, 180, 0.4);
        }

        .btn-login:hover {
            background: linear-gradient(135deg, #ff1493, #ff69b4);
            transform: translateY(-2px);
            box-shadow: 0 7px 20px rgba(255, 105, 180, 0.6);
        }

        .btn-forgot {
            background: transparent;
            color: #ff1493;
            border: none;
            text-decoration: underline;
            cursor: pointer;
            font-size: 14px;
            margin-top: 10px;
        }

        .btn-forgot:hover {
            color: #ff69b4;
        }

        .checkbox {
            margin: 15px 0;
            text-align: left;
        }

        .checkbox label {
            font-size: 14px;
            color: #333;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <asp:Button ID="btnBack" runat="server" CssClass="btn-back" Text="⬅" OnClick="btnBack_Click" CausesValidation="false" ToolTip="Quay lại Trang chủ" />
            <h2>Đăng nhập</h2>
            <asp:Label ID="lblMessage" runat="server" CssClass="error-message"></asp:Label>
            <div class="input-group">
                <asp:TextBox ID="txtMaSV" runat="server" CssClass="input-field" Placeholder="Mã sinh viên"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvMaSV" runat="server" 
                    ControlToValidate="txtMaSV" 
                    ErrorMessage="Vui lòng nhập mã sinh viên!" 
                    CssClass="validation-error" 
                    Display="Dynamic" 
                    EnableClientScript="true"></asp:RequiredFieldValidator>
            </div>
            <div class="input-group">
                <asp:TextBox ID="txtPassword" runat="server" CssClass="input-field" TextMode="Password" Placeholder="Mật khẩu"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                    ControlToValidate="txtPassword" 
                    ErrorMessage="Vui lòng nhập mật khẩu!" 
                    CssClass="validation-error" 
                    Display="Dynamic" 
                    EnableClientScript="true"></asp:RequiredFieldValidator>
            </div>
            <div class="checkbox">
                <asp:CheckBox ID="chkRememberMe" runat="server" Text="Nhớ tôi" />
            </div>
            <asp:Button ID="btnLogin" runat="server" CssClass="button btn-login" Text="Đăng nhập" OnClick="btnLogin_Click" />
            <asp:Button ID="btnForgotPassword" runat="server" CssClass="btn-forgot" Text="Quên mật khẩu?" OnClick="btnForgotPassword_Click" CausesValidation="false" />
        </div>
    </form>
</body>
</html>