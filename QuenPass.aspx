<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuenPass.aspx.cs" Inherits="DOAN_HQTCSDL.QuenPass" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quên Mật Khẩu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .forgot-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 350px;
        }
        h2 {
            color: #ff1493;
        }
        .input-field {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ff1493;
            border-radius: 5px;
            font-size: 16px;
        }
        .button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            background-color: #ff69b4;
            color: white;
        }
        .result {
            color: green;
            font-size: 16px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="forgot-container">
            <h2>Quên Mật Khẩu</h2>
            <asp:TextBox ID="txtMaSV" runat="server" CssClass="input-field" Placeholder="Mã Sinh Viên"></asp:TextBox>
            <asp:TextBox ID="txtNgaySinh" runat="server" CssClass="input-field" TextMode="Date"></asp:TextBox>
            <asp:Button ID="btnRetrieve" runat="server" CssClass="button" Text="Lấy lại mật khẩu" OnClick="btnRetrieve_Click" />
            <br />
            <asp:Label ID="lblResult" runat="server" CssClass="result"></asp:Label>
        </div>
    </form>
</body>
</html>