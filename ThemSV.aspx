<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ThemSV.aspx.cs" Inherits="DOAN_HQTCSDL.ThemSV" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Thêm Sinh Viên</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet" />
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #ffdde1, #ee9ca7);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            overflow-y: auto;
        }

        .container {
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(255, 105, 180, 0.2);
            border-left: 6px solid #ff69b4;
            max-width: 450px;
            min-width: 350px;
            width: 100%;
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            text-align: center;
            color: #ff1493;
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 20px;
            text-shadow: 1px 1px 2px rgba(255, 20, 147, 0.1);
        }

        .input-group {
            margin-bottom: 20px;
            position: relative;
        }

        label {
            font-size: 14px;
            font-weight: 500;
            color: #333;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        label::before {
            content: "🌸";
            font-size: 16px;
        }

        input, select {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 2px solid #ddd;
            font-size: 14px;
            transition: all 0.3s ease;
            background: #fff5f5;
            color: #333;
        }

        input:focus, select:focus {
            border-color: #ff1493;
            box-shadow: 0 0 8px rgba(255, 20, 147, 0.2);
            background: #fff;
            outline: none;
        }

        select {
            appearance: none;
            background: #fff5f5 url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMiIgaGVpZ2h0PSIxMiIgdmlld0JveD0iMCAwIDI0IDI0Ij48cGF0aCBmaWxsPSIjZmYxNDkzIiBkPSJNMTIgMTdsLTEwLTcgMCAxNCAyMCAwIDAtMTQtMTAgN3oiLz48L3N2Zz4=') no-repeat right 10px center;
            background-size: 12px;
        }

        .error-label, .validator-error {
            color: #ff4d4d;
            font-size: 12px;
            margin-top: 5px;
            display: block;
            font-style: italic;
            visibility: visible;
        }

        .error-label {
            visibility: hidden;
        }

        .button-container {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .button {
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            flex: 1;
        }

        .btn-add {
            background: linear-gradient(135deg, #ff69b4, #ff1493);
            color: white;
        }

        .btn-cancel {
            background: #ddd;
            color: #333;
        }

        .btn-add:hover {
            background: linear-gradient(135deg, #ff1493, #ff69b4);
            box-shadow: 0 5px 10px rgba(255, 20, 147, 0.3);
            transform: translateY(-2px);
        }

        .btn-cancel:hover {
            background: #ccc;
            transform: translateY(-2px);
        }

        #lblMessage {
            display: block;
            text-align: center;
            font-size: 14px;
            margin-bottom: 15px;
            padding: 8px;
            border-radius: 8px;
        }

        #lblMessage[style*="color:Green"] {
            background: #e6ffed;
            color: #28a745;
        }

        #lblMessage[style*="color:Red"] {
            background: #ffe6e6;
            color: #dc3545;
        }
        .error-label[style*="visible"] {
            visibility: visible;
            color: #ff4d4d;
            font-weight: bold;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Thêm Sinh Viên</h2>
            <div class="input-group">
                <asp:Label ID="lblMessage" runat="server" ForeColor="Green" Visible="false"></asp:Label>
            </div>
            <div class="input-group">
                <label>Mã SV:</label>
                <asp:TextBox ID="txtMaSV" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvMaSV" runat="server" ControlToValidate="txtMaSV" ErrorMessage="Mã SV không được để trống!" CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revMaSV" runat="server" ControlToValidate="txtMaSV" ErrorMessage="Mã SV phải bắt đầu bằng 'SV' và theo sau là số!" ValidationExpression="^SV\d+$" CssClass="validator-error" Display="Dynamic"></asp:RegularExpressionValidator>
                <asp:Label ID="lblMaSVError" runat="server" CssClass="error-label" Text="Mã SV không được để trống!"></asp:Label>
            </div>
            <div class="input-group">
                <label>Tên SV:</label>
                <asp:TextBox ID="txtTenSV" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvTenSV" runat="server" ControlToValidate="txtTenSV" ErrorMessage="Tên SV không được để trống!" CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:Label ID="lblTenSVError" runat="server" CssClass="error-label" Text="Tên SV không được để trống!"></asp:Label>
            </div>
            <div class="input-group">
                <label>Họ lót:</label>
                <asp:TextBox ID="txtHoLot" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvHoLot" runat="server" ControlToValidate="txtHoLot" ErrorMessage="Họ lót không được để trống!" CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:Label ID="lblHoLotError" runat="server" CssClass="error-label" Text="Họ lót không được để trống!"></asp:Label>
            </div>
            <div class="input-group">
                <label>Phái:</label>
                <asp:DropDownList ID="ddlPhai" runat="server">
                    <asp:ListItem Value="" Selected="True">Chọn phái</asp:ListItem>
                    <asp:ListItem Value="1">Nam</asp:ListItem>
                    <asp:ListItem Value="0">Nữ</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvPhai" runat="server" ControlToValidate="ddlPhai" InitialValue="" ErrorMessage="Vui lòng chọn phái!" CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:Label ID="lblPhaiError" runat="server" CssClass="error-label" Text="Vui lòng chọn phái!"></asp:Label>
            </div>
            <div class="input-group">
                <label>Ngày sinh:</label>
                <asp:TextBox ID="txtNgaySinh" runat="server" TextMode="Date"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvNgaySinh" runat="server" ControlToValidate="txtNgaySinh" ErrorMessage="Ngày sinh không được để trống!" CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:Label ID="lblNgaySinhError" runat="server" CssClass="error-label" Text="Ngày sinh không hợp lệ hoặc để trống!"></asp:Label>
            </div>
            <div class="input-group">
                <label>Địa chỉ:</label>
                <asp:TextBox ID="txtDiaChi" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDiaChi" runat="server" ControlToValidate="txtDiaChi" ErrorMessage="Địa chỉ không được để trống!" CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:Label ID="lblDiaChiError" runat="server" CssClass="error-label" Text="Địa chỉ không được để trống!"></asp:Label>
            </div>
            <div class="input-group">
                <label>Điện thoại:</label>
                <asp:TextBox ID="txtDienThoai" runat="server"></asp:TextBox>
                <asp:RegularExpressionValidator ID="revDienThoai" runat="server" ControlToValidate="txtDienThoai" ErrorMessage="Điện thoại phải là số (10-12 số)!" ValidationExpression="^\d{10,12}$" CssClass="validator-error" Display="Dynamic"></asp:RegularExpressionValidator>
                <asp:Label ID="lblDienThoaiError" runat="server" CssClass="error-label" Text="Điện thoại không hợp lệ!"></asp:Label>
            </div>
            <div class="input-group">
                <label>Mã lớp:</label>
                <asp:DropDownList ID="ddlMaLop" runat="server"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvMaLop" runat="server" ControlToValidate="ddlMaLop" InitialValue="" ErrorMessage="Vui lòng chọn mã lớp!" CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:Label ID="lblMaLopError" runat="server" CssClass="error-label" Text="Vui lòng chọn mã lớp!"></asp:Label>
            </div>
            <div class="button-container">
                <asp:Button ID="btnSave" runat="server" CssClass="button btn-add" Text="Thêm Mới" OnClick="btnSave_Click" />
                <asp:Button ID="btnCancel" runat="server" CssClass="button btn-cancel" Text="Thoát" OnClientClick="window.location.href='QuanLySinhVien.aspx'; return false;" />
            </div>
        </div>
    </form>
</body>
</html>