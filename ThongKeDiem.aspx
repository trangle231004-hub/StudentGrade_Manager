<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ThongKeDiem.aspx.cs" Inherits="DOAN_HQTCSDL.ThongKeDiem" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Thống Kê Điểm</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #ffdde1, #ee9ca7);
            margin: 20px;
            display: flex;
            justify-content: center;
            min-height: 100vh;
            position: relative; /* Thêm để hỗ trợ vị trí tuyệt đối cho nút Quay lại */
        }
        .container {
            width: 900px;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(255, 20, 147, 0.3);
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
            font-size: 28px;
            margin-bottom: 20px;
            border-bottom: 2px solid #ff69b4;
            padding-bottom: 10px;
        }
        .filter-section {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        .filter-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .filter-group label {
            color: #ff1493;
            font-weight: bold;
            min-width: 80px;
        }
        .filter-group select, .filter-group input {
            padding: 8px;
            border-radius: 6px;
            border: 1px solid #ff1493;
            width: 150px;
            transition: all 0.3s;
        }
        .filter-group select:focus, .filter-group input:focus {
            border-color: #ff69b4;
            box-shadow: 0 0 5px rgba(255, 105, 180, 0.3);
        }
        .button {
            padding: 8px 15px;
            border: none;
            cursor: pointer;
            border-radius: 6px;
            font-size: 14px;
            transition: 0.3s;
            font-weight: bold;
            width: 120px;
        }
        .btn-search { background: linear-gradient(to right, #ff69b4, #ff1493); color: white; }
        .btn-search:hover { background: linear-gradient(to right, #ff1493, #ff69b4); box-shadow: 0 3px 8px rgba(255, 20, 147, 0.3); }
        .btn-back {
            position: absolute;
            top: 20px;
            left: 20px;
            background: linear-gradient(to right, #d3d3d3, #a9a9a9);
            color: #333;
            padding: 8px 15px;
            border-radius: 6px;
            font-size: 14px;
            transition: 0.3s;
            font-weight: bold;
        }
        .btn-back:hover {
            background: linear-gradient(to right, #a9a9a9, #d3d3d3);
            box-shadow: 0 3px 8px rgba(169, 169, 169, 0.3);
            transform: scale(1.05);
        }
        .stats-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 14px;
        }
        .stats-table th, .stats-table td {
            border: 1px solid #ff1493;
            padding: 12px;
            text-align: center;
        }
        .stats-table th {
            background-color: #ff69b4;
            color: white;
            font-weight: bold;
        }
        .stats-table tr:nth-child(even) {
            background-color: #ffe6f2;
        }
        .stats-table tr:hover {
            background-color: #ffd1dc;
            transition: background-color 0.3s;
        }
        .summary {
            text-align: center;
            margin-top: 20px;
            color: #ff1493;
            font-size: 16px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- Nút Quay lại ở góc trái trên cùng -->
            <asp:Button ID="btnBack" runat="server" CssClass="button btn-back" Text="🔙 Quay lại" OnClick="btnBack_Click" />

            <h2>Thống Kê Điểm</h2>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
            <div class="filter-section">
                <div class="filter-group">
                    <label>Mã Môn Học:</label>
                    <asp:DropDownList ID="ddlMaMH" runat="server" AppendDataBoundItems="true">
                        <asp:ListItem Value="" Text="Tất cả"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="filter-group">
                    <asp:Button ID="btnGenerate" runat="server" CssClass="button btn-search" Text="Thống kê" OnClick="btnGenerate_Click" />
                </div>
            </div>
            <asp:GridView ID="gvStats" runat="server" CssClass="stats-table" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="MaMH" HeaderText="Mã Môn Học" />
                    <asp:BoundField DataField="SoLuongSV" HeaderText="Số Lượng SV" />
                    <asp:BoundField DataField="DiemTB" HeaderText="Điểm Trung Bình" DataFormatString="{0:F2}" />
                    <asp:BoundField DataField="Dat" HeaderText="Đạt (%)" DataFormatString="{0:F2}" />
                    <asp:BoundField DataField="KhongDat" HeaderText="Không Đạt (%)" DataFormatString="{0:F2}" />
                </Columns>
            </asp:GridView>
            <div class="summary">
                <asp:Label ID="lblSummary" runat="server" Text=""></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>