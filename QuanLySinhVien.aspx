<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuanLySinhVien.aspx.cs" Inherits="DOAN_HQTCSDL.QuanLySinhVien" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quản lý Sinh viên</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #ffe6f2;
            margin: 20px;
        }
        .container {
            width: 90%;
            max-width: 1200px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(255, 20, 147, 0.4);
            border: 2px solid #ff1493;
            position: relative;
        }
        h2 {
            text-align: center;
            color: #ff1493;
            font-size: 28px;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 2px solid #ff69b4;
        }
        .notification {
            text-align: center;
            margin-bottom: 20px;
            padding: 10px;
            background-color: #fff0f5;
            border: 2px solid #ff1493;
            border-radius: 10px;
            font-weight: bold;
            color: #333333;
            font-size: 16px;
            display: block;
        }
        .toolbar {
            text-align: center;
            margin-bottom: 25px;
            padding: 10px;
            background-color: #fff5f5;
            border-radius: 10px;
            border: 1px solid #ff69b4;
        }
        .toolbar input, .toolbar select, .toolbar button {
            padding: 10px 15px;
            margin: 0 10px;
            border-radius: 8px;
            border: 1px solid #ff1493;
            font-size: 14px;
            transition: background-color 0.3s;
        }
        .toolbar input:focus, .toolbar select:focus {
            outline: none;
            border-color: #ff69b4;
            box-shadow: 0 0 5px rgba(255, 105, 180, 0.5);
        }
        .button {
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 8px;
            font-size: 14px;
            transition: transform 0.2s, background-color 0.3s;
        }
        .button:hover {
            transform: scale(1.05);
        }
        .btn-search { background-color: #b9fbc0; color: #333; }
        .btn-reset { background-color: #f7d8e6; color: #333; }
        .btn-add { background-color: #d9e4ff; color: #333; }
        .btn-edit-pastel { background-color: #c3e8ff; color: #333; }
        .btn-delete-pastel { background-color: #ffdbac; color: #333; }
        .btn-back { 
            background-color: #ffccd5; 
            color: #333; 
            border: 2px solid #ff7b9c; 
            position: absolute; 
            top: 20px; 
            left: 20px; 
            padding: 8px 15px; 
        }
        .btn-back:hover { background-color: #ffb3c6; }
        .btn-detail { background-color: #ffd1dc; color: #333; }
        
        .grid-view {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border-radius: 10px;
            overflow: hidden;
            font-size: 14px;
        }
        .grid-view th, .grid-view td {
            border: 1px solid #ff1493;
            padding: 12px;
            text-align: center;
        }
        .grid-view th {
            background-color: #ff69b4;
            color: white;
            font-weight: bold;
        }
        .grid-view tr:nth-child(even) {
            background-color: #ffe6f2;
        }
        .grid-view tr:hover {
            background-color: #ffd1dc;
            transition: background-color 0.3s;
        }
        #editModal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(255, 20, 147, 0.5);
            width: 450px;
            max-width: 90%;
            z-index: 1000;
        }
        #editModal label {
            color: #ff1493;
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
        }
        #editModal input, #editModal select {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ff1493;
            border-radius: 5px;
            font-size: 14px;
        }
        #editModal input[type="date"] {
            padding: 8px;
        }
        #editModal .button {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container" style="position: relative;">
            <!-- Nút Quay lại ở góc trái trên -->
            <asp:Button ID="btnBackToAdmin" runat="server" CssClass="button btn-back" Text="🔙 Quay lại" OnClick="btnBackToAdmin_Click" />
            
            <h2>Quản lý Sinh viên</h2>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Label ID="lblMessage" runat="server" CssClass="notification"></asp:Label>
                    <div class="toolbar">
                        <asp:TextBox ID="txtSearch" runat="server" Placeholder="🔍 Nhập từ khóa..."></asp:TextBox>
                        <asp:Button ID="btnSearch" runat="server" CssClass="button btn-search" Text="Tìm kiếm" OnClick="btnSearch_Click" />
                        <asp:Button ID="btnReset" runat="server" CssClass="button btn-reset" Text="🔄 Làm mới" OnClick="btnReset_Click" />
                        <asp:Button ID="btnAdd" runat="server" CssClass="button btn-add" Text="+ Thêm mới" OnClick="btnAdd_Click" />
                        <asp:Button ID="btnViewDetailSV" runat="server" CssClass="button btn-detail" Text="Xem Chi Tiết Sinh Viên" OnClick="btnViewDetailSV_Click" />
                        <asp:Button ID="btnViewDetailLop" runat="server" CssClass="button btn-detail" Text="Xem Danh Sách Lớp" OnClick="btnViewDetailLop_Click" />
                        <asp:Button ID="btnInHocBong" runat="server" CssClass="button btn-detail" Text="In Học Bổng" OnClick="btnInHocBong_Click" />
                    </div>

                    <asp:GridView ID="gvSinhVien" runat="server" CssClass="grid-view" AutoGenerateColumns="False" DataKeyNames="MASV" OnRowCommand="gvSinhVien_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="MASV" HeaderText="Mã SV" ReadOnly="True" SortExpression="MASV" />
                            <asp:BoundField DataField="HOLOT" HeaderText="Họ Lót" SortExpression="HOLOT" />
                            <asp:BoundField DataField="TENSV" HeaderText="Tên" SortExpression="TENSV" />
                            <asp:BoundField DataField="PHAI" HeaderText="Giới Tính" SortExpression="PHAI" />
                            <asp:BoundField DataField="NGAYSINH" HeaderText="Ngày Sinh" SortExpression="NGAYSINH" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="DIACHI" HeaderText="Địa chỉ" SortExpression="DIACHI" />
                            <asp:BoundField DataField="DIENTHOAI" HeaderText="Điện Thoại" SortExpression="DIENTHOAI" />
                            <asp:BoundField DataField="MALOP" HeaderText="Mã Lớp" SortExpression="MALOP" />
                            <asp:TemplateField HeaderText="Thao tác">
                                <ItemTemplate>
                                    <asp:Button ID="btnEdit" runat="server" CssClass="button btn-edit-pastel" Text="✏️ Sửa"
                                        OnClientClick='<%# "editStudent(\"" + Eval("MASV") + "\", \"" + Eval("HOLOT") + "\", \"" + Eval("TENSV") + "\", \"" + Eval("PHAI") + "\", \"" + Eval("NGAYSINH", "{0:yyyy-MM-dd}") + "\", \"" + Eval("DIACHI") + "\", \"" + Eval("DIENTHOAI") + "\", \"" + Eval("MALOP") + "\"); return false;" %>' />
                                    <asp:Button ID="btnDelete" runat="server" CssClass="button btn-delete-pastel" Text="🗑️ Xóa" CommandName="DeleteStudent" CommandArgument='<%# Eval("MASV") %>' OnClientClick="return confirm('Bạn có chắc muốn xóa sinh viên này?');" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>

            <div id="editModal" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
                background: white; padding: 30px; border-radius: 10px; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
                width: 400px; max-width: 90%;">
                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <h3 style="margin: 0; color: #ff1493;">Cập nhật thông tin sinh viên</h3>
                    <button onclick="closeModal()" style="background: none; border: none; font-size: 20px; cursor: pointer; color: #ff1493;">×</button>
                </div>
                <asp:HiddenField ID="editMASV" runat="server" />
                <label style="color: #ff1493;"><b>Họ Lót:</b></label>
                <asp:TextBox ID="editHOLOT" runat="server" CssClass="form-control" style="width: 100%; padding: 5px; margin-bottom: 10px; border: 1px solid #ff1493;"></asp:TextBox><br />
                <label style="color: #ff1493;"><b>Tên:</b></label>
                <asp:TextBox ID="editTENSV" runat="server" CssClass="form-control" style="width: 100%; padding: 5px; margin-bottom: 10px; border: 1px solid #ff1493;"></asp:TextBox><br />
                <label style="color: #ff1493;"><b>Giới Tính:</b></label>
                <asp:DropDownList ID="editPHAI" runat="server" CssClass="form-control" style="width: 100%; padding: 5px; margin-bottom: 10px; border: 1px solid #ff1493;">
                    <asp:ListItem Text="Nam" Value="True"></asp:ListItem>
                    <asp:ListItem Text="Nữ" Value="False"></asp:ListItem>
                </asp:DropDownList><br />
                <label style="color: #ff1493;"><b>Ngày Sinh:</b></label>
                <asp:TextBox ID="editNGAYSINH" runat="server" TextMode="Date" CssClass="form-control" style="width: 100%; padding: 5px; margin-bottom: 10px; border: 1px solid #ff1493;"></asp:TextBox><br />
                <label style="color: #ff1493;"><b>Địa chỉ:</b></label>
                <asp:TextBox ID="editDIACHI" runat="server" CssClass="form-control" style="width: 100%; padding: 5px; margin-bottom: 10px; border: 1px solid #ff1493;"></asp:TextBox><br />
                <label style="color: #ff1493;"><b>Điện Thoại:</b></label>
                <asp:TextBox ID="editDIENTHOAI" runat="server" CssClass="form-control" style="width: 100%; padding: 5px; margin-bottom: 10px; border: 1px solid #ff1493;"></asp:TextBox><br />
                <label style="color: #ff1493;"><b>Mã Lớp:</b></label>
                <asp:DropDownList ID="editMALOP" runat="server" CssClass="form-control" style="width: 100%; padding: 5px; margin-bottom: 10px; border: 1px solid #ff1493;"></asp:DropDownList><br />
                <asp:Button ID="btnSaveModal" runat="server" CssClass="button btn-add" Text="Lưu" OnClick="btnSaveModal_Click" />
                <button onclick="closeModal()" style="background-color: #ffb6c1; color: black; padding: 8px 15px; border: none; cursor: pointer; border-radius: 5px;">Hủy</button>
            </div>
        </div>
    </form>

    <script>
        function editStudent(masv, holot, tensv, phai, ngaysinh, diachi, dienthoai, malop) {
            document.getElementById("<%= editMASV.ClientID %>").value = masv;
            document.getElementById("<%= editHOLOT.ClientID %>").value = holot;
            document.getElementById("<%= editTENSV.ClientID %>").value = tensv;
            document.getElementById("<%= editPHAI.ClientID %>").value = phai;
            document.getElementById("<%= editNGAYSINH.ClientID %>").value = ngaysinh;
            document.getElementById("<%= editDIACHI.ClientID %>").value = diachi;
            document.getElementById("<%= editDIENTHOAI.ClientID %>").value = dienthoai;
            document.getElementById("<%= editMALOP.ClientID %>").value = malop;
            document.getElementById("editModal").style.display = "block";
        }

        function closeModal() {
            document.getElementById("editModal").style.display = "none";
        }
    </script>
</body>
</html>