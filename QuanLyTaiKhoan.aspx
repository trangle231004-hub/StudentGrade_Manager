<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuanLyTaiKhoan.aspx.cs" Inherits="DOAN_HQTCSDL.QuanLyTaiKhoan" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quản Lý Tài Khoản</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #ffdde1, #ee9ca7);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
            position: relative; /* Thêm để hỗ trợ vị trí tuyệt đối cho nút Quay lại */
        }

        .container {
            width: 900px;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
            border-left: 5px solid #ff69b4;
            animation: fadeIn 0.5s ease-in-out;
            position: relative; /* Đảm bảo container có thể chứa nút tuyệt đối */
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            text-align: center;
            color: #ff1493;
            margin-bottom: 20px;
        }

        .form-section {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .input-section {
            width: 45%;
        }

        .button-section {
            width: 45%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .input-group {
            margin-bottom: 15px;
        }

        label {
            font-size: 14px;
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        input, select {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            outline: none;
            transition: all 0.3s;
            box-sizing: border-box;
        }

        input:focus, select:focus {
            border-color: #ff1493;
            box-shadow: 0px 0px 5px rgba(255, 20, 147, 0.3);
        }

        .error-label {
            color: red;
            font-size: 12px;
            margin-top: 5px;
            display: block;
            visibility: hidden;
        }

        .validator-error {
            color: red;
            font-size: 12px;
            margin-top: 5px;
            display: block;
        }

        .button {
            padding: 12px;
            border: none;
            cursor: pointer;
            border-radius: 6px;
            font-size: 15px;
            width: 100%;
            transition: 0.3s;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .btn-back {
            position: absolute;
            top: 20px;
            left: 20px;
            background: linear-gradient(to right, #ff69b4, #ff1493); /* Đồng bộ với màu của btn-add */
            color: white;
            padding: 8px 15px;
            border-radius: 6px;
            font-size: 14px;
            transition: 0.3s;
            font-weight: bold;
            width: auto;
        }

        .btn-back:hover {
            background: linear-gradient(to right, #ff1493, #ff69b4); /* Hiệu ứng hover tương tự btn-add */
            box-shadow: 0px 3px 8px rgba(255, 20, 147, 0.3);
        }

        .btn-add {
            background: linear-gradient(to right, #ff69b4, #ff1493);
            color: white;
        }

        .btn-update {
            background: linear-gradient(to right, #ffeb3b, #fbc02d);
            color: #333;
        }

        .btn-delete {
            background: linear-gradient(to right, #ff5722, #d81b60);
            color: white;
        }

        .btn-cancel {
            background: linear-gradient(to right, #bdbdbd, #757575);
            color: white;
        }

        .btn-add:hover {
            background: linear-gradient(to right, #ff1493, #ff69b4);
            box-shadow: 0px 3px 8px rgba(255, 20, 147, 0.3);
        }

        .btn-update:hover {
            background: linear-gradient(to right, #fbc02d, #ffeb3b);
            box-shadow: 0px 3px 8px rgba(255, 193, 7, 0.3);
        }

        .btn-delete:hover {
            background: linear-gradient(to right, #d81b60, #ff5722);
            box-shadow: 0px 3px 8px rgba(255, 87, 34, 0.3);
        }

        .btn-cancel:hover {
            background: linear-gradient(to right, #757575, #bdbdbd);
            box-shadow: 0px 3px 8px rgba(0, 0, 0, 0.3);
        }

        .grid-view {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .grid-view th, .grid-view td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .grid-view th {
            background-color: #ff69b4;
            color: white;
        }

        .grid-view tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .grid-view tr:hover {
            background-color: #f1f1f1;
        }

        .grid-view .button {
            width: auto;
            padding: 5px 10px;
            font-size: 13px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- Nút Quay lại ở góc trái trên cùng -->
            <asp:Button ID="btnBack" runat="server" CssClass="button btn-back" Text="🔙 Quay lại" OnClick="btnBack_Click" CausesValidation="false" />

            <h2>Quản Lý Tài Khoản</h2>
            <div class="input-group">
                <asp:Label ID="lblMessage" runat="server" ForeColor="Green" Visible="false"></asp:Label>
            </div>
            <div class="form-section">
                <div class="input-section">
                    <div class="input-group">
                        <label>Mã SV:</label>
                        <asp:TextBox ID="txtMaSV" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvMaSV" runat="server" ControlToValidate="txtMaSV" ErrorMessage="Mã SV không được để trống!" CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:Label ID="lblMaSVError" runat="server" CssClass="error-label" Text="Mã SV không hợp lệ!"></asp:Label>
                    </div>
                    <div class="input-group">
                        <label>Username:</label>
                        <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" ErrorMessage="Username không được để trống!" CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:Label ID="lblUsernameError" runat="server" CssClass="error-label" Text="Username không hợp lệ!"></asp:Label>
                    </div>
                    <div class="input-group">
                        <label>Password:</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password không được để trống!" CssClass="validator-error" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:Label ID="lblPasswordError" runat="server" CssClass="error-label" Text="Password không hợp lệ!"></asp:Label>
                    </div>
                </div>
                <div class="button-section">
                    <asp:Button ID="btnAdd" runat="server" CssClass="button btn-add" Text="Thêm Tài Khoản" OnClick="btnAdd_Click" />
                    <asp:Button ID="btnUpdate" runat="server" CssClass="button btn-update" Text="Cập Nhật Tài Khoản" OnClick="btnUpdate_Click" />
                    <asp:Button ID="btnDelete" runat="server" CssClass="button btn-delete" Text="Xóa Tài Khoản" OnClick="btnDelete_Click" OnClientClick="return confirm('Bạn có chắc chắn muốn xóa tài khoản này không?');" />
                    <asp:Button ID="btnCancel" runat="server" CssClass="button btn-cancel" Text="Hủy" OnClick="btnCancel_Click" />
                </div>
            </div>
            <div class="input-group">
                <asp:GridView ID="gvTaiKhoan" runat="server" CssClass="grid-view" AutoGenerateColumns="False" OnRowCommand="gvTaiKhoan_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="MASV" HeaderText="Mã SV" />
                        <asp:BoundField DataField="Username" HeaderText="Username" />
                        <asp:BoundField DataField="Password" HeaderText="Password" />
                        <asp:ButtonField CommandName="Select" Text="Chọn" ButtonType="Button" ControlStyle-CssClass="button btn-add" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>