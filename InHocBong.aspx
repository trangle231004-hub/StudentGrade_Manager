<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InHocBong.aspx.cs" Inherits="DOAN_HQTCSDL.InHocBong" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>In Học Bổng Theo Lớp</title>
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
        .toolbar button {
            padding: 10px 15px;
            margin: 0 10px;
            border-radius: 8px;
            border: 1px solid #ff1493;
            font-size: 14px;
            transition: background-color 0.3s;
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
        .btn-print { background-color: #b9fbc0; color: #333; }
        
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container" style="position: relative;">
            <asp:Button ID="btnBack" runat="server" CssClass="button btn-back" Text="🔙 Quay lại" OnClick="btnBack_Click" />
            
            <h2>Danh Sách Sinh Viên Nhận Học Bổng Theo Lớp</h2>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Label ID="lblMessage" runat="server" CssClass="notification"></asp:Label>
                    <div class="toolbar">
                        <asp:Button ID="btnPrint" runat="server" CssClass="button btn-print" Text="In Danh Sách" OnClientClick="window.print(); return false;" />
                    </div>

                    <asp:GridView ID="gvHocBong" runat="server" CssClass="grid-view" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="MALOP" HeaderText="Mã Lớp" />
                            <asp:BoundField DataField="TENLOP" HeaderText="Tên Lớp" />
                            <asp:BoundField DataField="MASV" HeaderText="Mã SV" />
                            <asp:BoundField DataField="HOLOT" HeaderText="Họ Lót" />
                            <asp:BoundField DataField="TENSV" HeaderText="Tên" />
                            <asp:BoundField DataField="GioiTinh" HeaderText="Giới Tính" />
                            <asp:BoundField DataField="Tuoi" HeaderText="Tuổi" />
                            <asp:BoundField DataField="DIEMTB" HeaderText="Điểm TB" DataFormatString="{0:F2}" />
                            <asp:BoundField DataField="XEPLOAI" HeaderText="Xếp Loại" />
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>