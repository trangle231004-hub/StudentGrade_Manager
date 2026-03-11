# StudentGrade Manager

Centralized Student Grade Management System built with Visual Studio 2022 (ASP.NET WebForms, .NET Framework 4.7.2, C#, ADO.NET, SQL Server).  
Provides role-based authentication, student/course/grade CRUD, grade viewing, reporting and DB backup utilities.

## Quick summary
- Project name: StudentGrade Manager  
- Purpose: manage student records, courses and grades for educational administration (admin & student roles).  
- Repo slug suggestion: `studentgrade-manager`

## Tech stack
- .NET Framework 4.7.2 (Visual Studio 2022)
- ASP.NET WebForms (code-behind .aspx / .aspx.cs)
- C#
- ADO.NET / SQL Server
- HTML / CSS (responsive UI), Font Awesome for icons

## Key features
- Role-based authentication (Admin / Student) with session + optional "remember me" cookie
- Student profile CRUD (add / edit / search / export)
- Course / credit management
- Grade entry, automated GPA average calculation, paginated grade view (`XemDiem.aspx`)
- Admin dashboard (`ADMIN.aspx`) for managing entities
- Stored procedures for score queries, backup/restore utilities
- Simple responsive landing page and support/help info

## Important files
- `TRANGCHU.aspx`, `TRANGCHU.aspx.cs` — landing page / session-aware UI
- `LOGIN.aspx`, `LOGIN.aspx.cs` — authentication logic
- `XemDiem.aspx`, `XemDiem.aspx.cs` — student grade viewer
- `ADMIN.aspx`, `ADMIN.aspx.cs` — admin dashboard
- Management pages: `QuanLySinhVien.aspx`, `QuanLyMonHoc.aspx`, `QuanLyDiem.aspx`
- Connection string key expected by the code: `QLDIEMConnectionString` (see Web.config)

## Prerequisites
- Visual Studio 2022 with .NET Framework 4.7.2 targeting pack
- SQL Server (LocalDB or full instance)
- Git (optional)

## Setup (local)
1. Clone repository:
   git clone https://github.com/<your-username>/<your-repo>.git

2. Open solution in Visual Studio 2022.

3. Configure database connection:
   - Open `Web.config`.
   - Update the `connectionStrings` section so the key `QLDIEMConnectionString` points to your SQL Server and database. Example:
   - - For Windows Authentication use `Integrated Security=True;` and omit username/password.

4. Prepare the database:
- If the repo includes SQL scripts or a `.bak`, restore/import them.
- If not, create tables and stored procedures used in code (search for procedure names like `XemDiemSinhVien` in `*.aspx.cs` files).

5. Build & run:
- Press F5 (IIS Express) or use __Debug → Start Debugging__ in Visual Studio.
- Open browser to the app root and verify login and pages.

## Deploy notes / security
- For production:
- Use HTTPS and secure cookie options.
- Protect connection strings (encrypt `connectionStrings` section).
- Use parameterized queries (current code uses ADO.NET and parameters; continue this practice).
- Restrict DB account permissions and use least privilege.

## How to push to GitHub (quick)
- CLI:
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/<your-username>/<repo>.git
git branch -M main
git push -u origin main

- Visual Studio: use the __Git Changes__ window → commit → __Push__ / __Publish__ to remote.

## Tips & next steps
- Add a `Database` folder with SQL schema and seed scripts if not present.
- Add `README.md` (this file), `LICENSE` (MIT recommended), and a short `CONTRIBUTING.md`.
- Consider migrating to ASP.NET MVC / .NET 6+ for long-term maintenance.

## Contact
Open an issue on the repository or contact the project owner for questions about DB schema or credentials.
