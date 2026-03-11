<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuanLyMonHoc.aspx.cs" Inherits="DOAN_HQTCSDL.QuanLyMonHoc" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quản Lý Môn Học</title>
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
            width: 200px;
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
        }
        .error-label {
            color: #ff0000;
            font-size: 12px;
            margin-top: 5px;
            text-align: center;
            display: block;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Quản Lý Môn Học</h2>
            <asp:Label ID="lblMessage" runat="server" CssClass="message" ForeColor="Green"></asp:Label>

            <!-- Thanh công cụ (Chỉ chứa Search) -->
            <div class="toolbar">
                <div class="search-bar">
                    <asp:TextBox ID="txtSearch" runat="server" Placeholder="🔍 Tìm mã môn học hoặc tên môn học..."></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" CssClass="button btn-add" Text="Tìm kiếm" OnClick="btnSearch_Click" />
                </div>
            </div>

            <!-- Nút Quay lại ở góc trái -->
            <asp:Button ID="btnBack" runat="server" CssClass="button btn-back" Text="🔙 Quay lại" OnClick="btnBack_Click" />

            <!-- Phần nhập liệu -->
            <div class="input-section">
                <div>
                    <label>Mã Môn Học:</label>
                    <asp:TextBox ID="txtMaMH" runat="server"></asp:TextBox>
                    <asp:Label ID="lblMaMHError" runat="server" CssClass="error-label" Text="Mã môn học không hợp lệ!"></asp:Label>
                </div>
                <div>
                    <label>Tên Môn Học:</label>
                    <asp:TextBox ID="txtTenMH" runat="server"></asp:TextBox>
                    <asp:Label ID="lblTenMHError" runat="server" CssClass="error-label" Text="Tên môn học không hợp lệ!"></asp:Label>
                </div>
                <div>
                    <label>Số Tín Chỉ:</label>
                    <asp:TextBox ID="txtSoTC" runat="server" TextMode="Number" min="1" max="10"></asp:TextBox>
                    <asp:Label ID="lblSoTCError" runat="server" CssClass="error-label" Text="Số tín chỉ không hợp lệ!"></asp:Label>
                </div>
                <div>
                    <asp:Button ID="btnAdd" runat="server" CssClass="button btn-add" Text="➕ Thêm" OnClick="btnAdd_Click" />
                    <asp:Button ID="btnUpdate" runat="server" CssClass="button btn-edit" Text="✏️ Sửa" OnClick="btnUpdate_Click" />
                    <asp:Button ID="btnDelete" runat="server" CssClass="button btn-delete" Text="🗑️ Xóa" OnClick="btnDelete_Click" OnClientClick="return confirm('Bạn có chắc muốn xóa?');" />
                    <asp:Button ID="btnReset" runat="server" CssClass="button btn-reset" Text="🔄 Làm mới" OnClick="btnReset_Click" />
                </div>
            </div>

            <!-- Bảng dữ liệu -->
            <asp:GridView ID="gvMonHoc" runat="server" CssClass="grid-view" AutoGenerateColumns="False" OnRowCommand="gvMonHoc_RowCommand">
                <Columns>
                    <asp:BoundField DataField="MAMH" HeaderText="Mã Môn Học" />
                    <asp:BoundField DataField="TENMH" HeaderText="Tên Môn Học" />
                    <asp:BoundField DataField="SOTC" HeaderText="Số Tín Chỉ" />
                    <asp:TemplateField HeaderText="Thao tác">
                        <ItemTemplate>
                            <asp:Button ID="btnSelect" runat="server" CssClass="button btn-edit" Text="✏️ Chọn" CommandName="Select" CommandArgument='<%# Eval("MAMH") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>