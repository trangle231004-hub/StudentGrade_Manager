<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TRANGCHU.aspx.cs" Inherits="DOAN_HQTCSDL.TRANGCHU" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Hệ Thống Quản Lý Điểm</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <style>
        :root {
            --primary-pink: #ff4da6;
            --light-pink: #fff0f6;
            --accent-pink: #ff1493;
            --text-main: #2d3436;
            --text-sub: #636e72;
            --white: #ffffff;
            --radius-lg: 20px;
            --radius-md: 12px;
            --shadow: 0 10px 30px rgba(255, 77, 166, 0.1);
        }

        * { box-sizing: border-box; transition: all 0.3s ease; }
        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #fff5f8 0%, #ffeef4 100%);
            color: var(--text-main);
            min-height: 100vh;
        }

        /* NAVBAR */
        .navbar {
            position: fixed; top: 0; width: 100%; height: 75px;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(15px);
            display: flex; align-items: center; justify-content: space-between;
            padding: 0 6%; z-index: 1000;
            border-bottom: 1px solid rgba(255, 77, 166, 0.1);
        }
        .brand { display: flex; align-items: center; gap: 12px; font-weight: 800; font-size: 20px; color: var(--accent-pink); }
        .brand i { background: var(--primary-pink); color: white; padding: 8px; border-radius: 10px; font-size: 18px; }
        .nav-links a { text-decoration: none; color: var(--text-sub); margin-left: 25px; font-weight: 600; font-size: 15px; }
        .nav-links a:hover { color: var(--primary-pink); }

        /* MAIN CONTAINER */
        .container { max-width: 1300px; margin: 0 auto; padding: 120px 25px 50px; }

        /* HERO SECTION */
        .hero-box {
            background: var(--white);
            border-radius: var(--radius-lg);
            padding: 50px;
            box-shadow: var(--shadow);
            margin-bottom: 30px;
            position: relative; overflow: hidden;
        }
        .hero-box::before {
            content: ""; position: absolute; top: 0; right: 0;
            width: 300px; height: 300px;
            background: radial-gradient(circle, rgba(255,77,166,0.05) 0%, transparent 70%);
        }
        .hero-box h1 { font-size: 42px; margin: 0; font-weight: 800; line-height: 1.2; }
        .hero-box h1 span { color: var(--primary-pink); }
        .hero-box p.lead { font-size: 17px; color: var(--text-sub); max-width: 800px; margin: 20px 0 40px; line-height: 1.6; }

        /* 4 COLUMNS GRID */
        .features-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }
        .f-card {
            background: #fff9fb;
            border: 1px solid rgba(255, 77, 166, 0.1);
            border-radius: var(--radius-md);
            padding: 25px;
            text-align: center;
        }
        .f-card:hover { transform: translateY(-8px); background: white; border-color: var(--primary-pink); box-shadow: var(--shadow); }
        .f-icon { 
            width: 55px; height: 55px; margin: 0 auto 15px;
            background: var(--light-pink); color: var(--primary-pink);
            display: flex; align-items: center; justify-content: center;
            border-radius: 50%; font-size: 22px;
        }
        .f-card h4 { margin: 0 0 10px; font-size: 17px; font-weight: 700; }
        .f-card p { margin: 0; font-size: 14px; color: var(--text-sub); line-height: 1.4; }

        /* AUTH CONTAINER - HOÁN ĐỔI BỐ CỤC */
        .auth-container { display: grid; grid-template-columns: 1fr 350px; gap: 30px; margin-top: 30px; }
        
        /* Chỉnh lại Login box để nằm bên trái (phần 1fr) */
        .login-box {
            background: var(--white); 
            padding: 40px; 
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow); 
            text-align: center; 
            border: 1px solid rgba(255, 77, 166, 0.05);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .btn-pink {
            width: 280px; padding: 15px; border-radius: 12px; border: none;
            background: linear-gradient(90deg, var(--primary-pink), #ff75b5);
            color: white; font-weight: 700; font-size: 16px; cursor: pointer;
            margin-top: 20px; box-shadow: 0 5px 15px rgba(255, 77, 166, 0.3);
        }
        .btn-pink:hover { filter: brightness(1.1); transform: scale(1.02); }
        
        .btn-outline {
            width: 280px; padding: 13px; border-radius: 12px; background: transparent;
            border: 2px solid var(--light-pink); color: var(--primary-pink);
            font-weight: 700; margin-top: 10px; cursor: pointer;
        }

        /* SUPPORT BOX - Nằm bên phải (Sidebar 350px) */
        .support-card {
            background: var(--white);
            border-left: 5px solid var(--primary-pink);
            padding: 30px 25px; 
            border-radius: var(--radius-md);
            box-shadow: var(--shadow);
            height: 100%;
        }

        @media (max-width: 1100px) {
            .features-grid { grid-template-columns: repeat(2, 1fr); }
            .auth-container { grid-template-columns: 1fr; }
            .btn-pink, .btn-outline { width: 100%; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar">
            <div class="brand">
                <i class="fa-solid fa-user-graduate"></i>
                HỆ THỐNG QUẢN LÝ ĐIỂM
            </div>
            <div class="nav-links">
                <a href="#"><i class="fa-solid fa-house-chimney"></i> Trang chủ</a>
                <a href="#"><i class="fa-solid fa-circle-info"></i> Hỗ trợ</a>
                <a href="LOGIN.aspx"><i class="fa-solid fa-lock"></i> Đăng nhập</a>
            </div>
        </nav>

        <div class="container">
            <div class="hero-box">
                <h1>Giải pháp quản lý <span>Học tập & Điểm số</span> toàn diện</h1>
                <p class="lead">Tự động hóa quy trình quản lý hồ sơ, tối ưu hóa việc nhập liệu và tra cứu điểm số cho sinh viên và giảng viên chỉ với vài thao tác đơn giản.</p>
                
                <div class="features-grid">
                    <div class="f-card">
                        <div class="f-icon"><i class="fa-solid fa-address-book"></i></div>
                        <h4>Hồ sơ Sinh viên</h4>
                        <p>Quản lý thông tin cá nhân và lớp học chuyên nghiệp.</p>
                    </div>
                    <div class="f-card">
                        <div class="f-icon"><i class="fa-solid fa-book-bookmark"></i></div>
                        <h4>Môn học</h4>
                        <p>Hệ thống học phần và tín chỉ sắp xếp khoa học.</p>
                    </div>
                    <div class="f-card">
                        <div class="f-icon"><i class="fa-solid fa-chart-pie"></i></div>
                        <h4>Quản lý Điểm</h4>
                        <p>Nhập điểm tập trung và tính điểm trung bình tự động.</p>
                    </div>
                    <div class="f-card">
                        <div class="f-icon"><i class="fa-solid fa-shield-heart"></i></div>
                        <h4>An toàn Dữ liệu</h4>
                        <p>Sao lưu bảo mật và phân quyền truy cập tuyệt đối.</p>
                    </div>
                </div>
            </div>

            <div class="auth-container">
                <main>
                    <asp:Panel ID="pnlNotLogged" runat="server" Visible="true">
                        <div class="login-box">
                            <i class="fa-solid fa-fingerprint" style="font-size: 50px; color: var(--primary-pink); margin-bottom: 15px;"></i>
                            <h2 style="margin:0">Cổng xác thực hệ thống</h2>
                            <p style="font-size: 15px; color: var(--text-sub); max-width: 450px;">Chào mừng bạn quay trở lại. Vui lòng đăng nhập để bắt đầu phiên làm việc và quản lý dữ liệu học tập cá nhân.</p>
                            <asp:Button ID="btnLogin" runat="server" CssClass="btn-pink" Text="ĐĂNG NHẬP NGAY" />
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlLogged" runat="server" Visible="false">
                        <div class="login-box">
                            <i class="fa-solid fa-circle-check" style="font-size: 50px; color: #4cd137; margin-bottom: 15px;"></i>
                            <h2 style="margin-bottom:5px">Phiên làm việc sẵn sàng</h2>
                            <p style="color:var(--text-sub)">Xin chào, <asp:Label ID="lblWelcome" runat="server" Text="Quản trị viên" Font-Bold="true" ForeColor="#ff4da6" /></p>
                            <asp:Button ID="btnDashboard" runat="server" CssClass="btn-pink" Text="VÀO BẢNG ĐIỀU KHIỂN" />
                            <asp:Button ID="btnLogout" runat="server" CssClass="btn-outline" Text="Đăng xuất tài khoản" />
                        </div>
                    </asp:Panel>
                </main>

                <aside>
                    <div class="support-card">
                        <h3 style="margin-top:0; color: var(--accent-pink);"><i class="fa-solid fa-headset"></i> Hỗ trợ kỹ thuật</h3>
                        <p style="color:var(--text-sub); line-height: 1.6; font-size: 14px;">
                            Nếu bạn gặp sự cố về tài khoản hoặc không thể đăng nhập, vui lòng liên hệ trực tiếp phòng Đào tạo để được hướng dẫn xử lý sớm nhất.
                        </p>
                        <div style="margin-top: 20px; border-top: 1px solid #f0f0f0; padding-top: 15px;">
                            <p style="font-size: 13px; color: var(--text-sub); margin: 5px 0;">
                                <i class="fa-solid fa-phone-volume" style="margin-right:8px; color: var(--primary-pink)"></i> Hotline: <b>(+84) 123 456 789</b>
                            </p>
                            <p style="font-size: 13px; color: var(--text-sub); margin: 5px 0;">
                                <i class="fa-solid fa-envelope" style="margin-right:8px; color: var(--primary-pink)"></i> Email: abc@gmail.com
                            </p>
                        </div>
                    </div>
                </aside>
            </div>

            <footer style="text-align: center; margin-top: 50px; color: var(--text-sub); font-size: 13px; padding-bottom: 20px;">
                &copy; 2024 Hệ Thống Quản Lý Điểm — Giải pháp số hóa giáo dục chuyên nghiệp
            </footer>
        </div>
    </form>
</body>
</html>