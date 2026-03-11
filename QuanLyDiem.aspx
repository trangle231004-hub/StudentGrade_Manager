<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuanLyDiem.aspx.cs" Inherits="DOAN_HQTCSDL.QuanLyDiem" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quản Lý Điểm</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f4e1e1, #e6b8c3);
            margin: 0;
            padding: 20px;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            position: relative;
        }
        .container {
            width: 90%;
            max-width: 1200px;
            background: #ffffff;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(255, 105, 180, 0.2);
            border-left: 6px solid #ff69b4;
            animation: slideIn 0.6s ease-out;
            position: relative;
            z-index: 1;
        }
        @keyframes slideIn {
            from { transform: translateY(-20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        h2 {
            text-align: center;
            color: #ff1493;
            font-size: 32px;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 3px solid #ff69b4;
            font-weight: 600;
        }
        .toolbar {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 10px;
        }
        .search-bar {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .search-bar input {
            padding: 10px;
            width: 250px;
            border: 2px solid #ff69b4;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        .search-bar input:focus {
            border-color: #ff1493;
            outline: none;
        }
        .button {
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 8px;
            font-size: 14px;
            transition: transform 0.3s, background-color 0.3s;
            font-weight: 500;
        }
        .btn-add { background-color: #ff69b4; color: white; }
        .btn-add:hover { background-color: #ff1493; transform: scale(1.05); }
        .btn-edit { background-color: #ffb6c1; color: #333; }
        .btn-edit:hover { background-color: #ff8c94; transform: scale(1.05); }
        .btn-delete { background-color: #ff4d94; color: white; }
        .btn-delete:hover { background-color: #e01177; transform: scale(1.05); }
        .btn-reset { background-color: #b0e0e6; color: #333; }
        .btn-reset:hover { background-color: #87ceeb; transform: scale(1.05); }
        .btn-back { 
            background-color: #d3d3d3; 
            color: #333; 
            position: absolute; 
            top: 20px; 
            left: 20px; 
            z-index: 10;
        }
        .btn-back:hover { background-color: #a9a9a9; transform: scale(1.05); }
        .input-section {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        .input-section label {
            color: #ff1493;
            font-weight: 600;
            font-size: 14px;
            min-width: 100px;
            text-align: right;
        }
        .input-section input {
            padding: 8px;
            width: 150px;
            border: 2px solid #ff69b4;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        .input-section input:focus {
            border-color: #ff1493;
            outline: none;
        }
        .grid-view {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border-radius: 10px;
            overflow: hidden;
            font-size: 14px;
        }
        .grid-view th, .grid-view td {
            border: 1px solid #ff69b4;
            padding: 12px;
            text-align: center;
        }
        .grid-view th {
            background-color: #ff69b4;
            color: white;
            font-weight: 600;
        }
        .grid-view tr:nth-child(even) {
            background-color: #fff0f5;
        }
        .grid-view tr:hover {
            background-color: #ffd1dc;
            transition: background-color 0.3s;
        }
        .message {
            text-align: center;
            margin: 10px 0;
            font-size: 14px;
            padding: 10px;
            border-radius: 5px;
            min-height: 20px;
        }
        .message .success-label {
            color: #008000;
            display: block;
        }
        .message .error-label {
            color: #ff0000;
            display: none; /* Ẩn mặc định, chỉ hiển thị khi có lỗi */
        }
        #editModal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            max-width: 90%;
            z-index: 1000;
            border: 2px solid #ffb6c1;
        }
        #editModal label {
            color: #ff85a2;
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
            text-align: left;
        }
        #editModal input {
            width: 100%;
            padding: 6px;
            margin-bottom: 15px;
            border: 1px solid #ffb6c1;
            border-radius: 5px;
            box-sizing: border-box;
        }
        #editModal .button {
            width: 100px;
            margin: 0 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- Nút Quay lại ở góc trái -->
            <asp:Button ID="btnBack" runat="server" CssClass="button btn-back" Text="🔙 Quay lại" OnClick="btnBack_Click" />

            <h2>Quản Lý Điểm</h2>
            <!-- Khu vực hiển thị thông báo -->
            <div class="message">
                <asp:Label ID="lblMessage" runat="server" CssClass="success-label"></asp:Label>
                <asp:Label ID="lblMaSVError" runat="server" CssClass="error-label" Text="Mã SV không hợp lệ!"></asp:Label>
                <asp:Label ID="lblMaMHErr" runat="server" CssClass="error-label" Text="Mã môn học không hợp lệ!"></asp:Label>
                <asp:Label ID="lblDiemError" runat="server" CssClass="error-label" Text="Điểm không hợp lệ (0-10)!"></asp:Label>
            </div>

            <div class="toolbar">
                <div class="search-bar">
                    <asp:TextBox ID="txtSearch" runat="server" Placeholder="🔍 Nhập từ khóa (MASV hoặc MAMH)..."></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" CssClass="button btn-add" Text="Tìm kiếm" OnClick="btnSearch_Click" />
                </div>
            </div>

            <div class="input-section">
                <div><label>Mã SV:</label><asp:TextBox ID="txtMaSV" runat="server"></asp:TextBox></div>
                <div><label>Mã MH:</label><asp:TextBox ID="txtMaMH" runat="server"></asp:TextBox></div>
                <div><label>Điểm CC:</label><asp:TextBox ID="txtDiemCC" runat="server" TextMode="Number" step="0.1" min="0" max="10"></asp:TextBox></div>
                <div><label>Điểm TD:</label><asp:TextBox ID="txtDiemTD" runat="server" TextMode="Number" step="0.1" min="0" max="10"></asp:TextBox></div>
                <div><label>Điểm GK:</label><asp:TextBox ID="txtDiemGK" runat="server" TextMode="Number" step="0.1" min="0" max="10"></asp:TextBox></div>
                <div><label>Điểm DA:</label><asp:TextBox ID="txtDiemDA" runat="server" TextMode="Number" step="0.1" min="0" max="10"></asp:TextBox></div>
                <div><label>Điểm CK:</label><asp:TextBox ID="txtDiemCK" runat="server" TextMode="Number" step="0.1" min="0" max="10"></asp:TextBox></div>
                <div>
                    <asp:Button ID="btnAdd" runat="server" CssClass="button btn-add" Text="+ Thêm" OnClick="btnAdd_Click" />
                    <asp:Button ID="btnUpdate" runat="server" CssClass="button btn-edit" Text="Sửa" OnClick="btnUpdate_Click" />
                    <asp:Button ID="btnDelete" runat="server" CssClass="button btn-delete" Text="Xóa" OnClick="btnDelete_Click" OnClientClick="return confirm('Bạn có chắc muốn xóa?');" />
                    <asp:Button ID="btnReset" runat="server" CssClass="button btn-reset" Text="Làm mới" OnClick="btnReset_Click" />
                </div>
            </div>

            <asp:GridView ID="gvDiem" runat="server" CssClass="grid-view" AutoGenerateColumns="False" OnRowCommand="gvDiem_RowCommand">
                <Columns>
                    <asp:BoundField DataField="MASV" HeaderText="Mã SV" />
                    <asp:BoundField DataField="MAMH" HeaderText="Mã Môn Học" />
                    <asp:BoundField DataField="DIEMCC" HeaderText="Điểm CC" DataFormatString="{0:F1}" />
                    <asp:BoundField DataField="DIEMTD" HeaderText="Điểm TD" DataFormatString="{0:F1}" />
                    <asp:BoundField DataField="DIEMGK" HeaderText="Điểm GK" DataFormatString="{0:F1}" />
                    <asp:BoundField DataField="DIEMDA" HeaderText="Điểm DA" DataFormatString="{0:F1}" />
                    <asp:BoundField DataField="DIEMCK" HeaderText="Điểm CK" DataFormatString="{0:F1}" />
                    <asp:TemplateField HeaderText="Thao tác">
                        <ItemTemplate>
                            <asp:Button ID="btnSelect" runat="server" CssClass="button btn-edit" Text="Chọn" CommandName="Select" CommandArgument='<%# Eval("MASV") + "," + Eval("MAMH") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <div id="editModal" runat="server">
                <h3 style="color: #ff85a2; text-align: center;">Cập nhật Điểm</h3>
                <label>Mã SV:</label>
                <asp:TextBox ID="txtEditMaSV" runat="server" ReadOnly="true"></asp:TextBox>
                <label>Mã MH:</label>
                <asp:TextBox ID="txtEditMaMH" runat="server" ReadOnly="true"></asp:TextBox>
                <label>Điểm CC:</label>
                <asp:TextBox ID="txtEditDiemCC" runat="server" TextMode="Number" step="0.1" min="0" max="10"></asp:TextBox>
                <label>Điểm TD:</label>
                <asp:TextBox ID="txtEditDiemTD" runat="server" TextMode="Number" step="0.1" min="0" max="10"></asp:TextBox>
                <label>Điểm GK:</label>
                <asp:TextBox ID="txtEditDiemGK" runat="server" TextMode="Number" step="0.1" min="0" max="10"></asp:TextBox>
                <label>Điểm DA:</label>
                <asp:TextBox ID="txtEditDiemDA" runat="server" TextMode="Number" step="0.1" min="0" max="10"></asp:TextBox>
                <label>Điểm CK:</label>
                <asp:TextBox ID="txtEditDiemCK" runat="server" TextMode="Number" step="0.1" min="0" max="10"></asp:TextBox>
                <div style="text-align: center;">
                    <asp:Button ID="btnSave" runat="server" CssClass="button btn-edit" Text="Lưu" OnClick="btnSave_Click" />
                    <asp:Button ID="btnCloseModal" runat="server" CssClass="button btn-delete" Text="Đóng" OnClick="btnCloseModal_Click" />
                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        function showModal() {
            document.getElementById('<%= editModal.ClientID %>').style.display = 'block';
        }
        function hideModal() {
            document.getElementById('<%= editModal.ClientID %>').style.display = 'none';
        }
    </script>
</body>
</html>