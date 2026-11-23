# Hospital Management System (HTML, CSS, JavaScript, PHP, MySQL)

## Folder layout
- `index.html` – the single page the browser opens
- `css/style.css` – all styling (light and dark mode)
- `js/app.js` – the interface: screens, forms, validation, printing
- `api/` – PHP back end (`auth.php` sign-in, `data.php` load/save, `backup.php`, `upload.php`, `config.php`, `bootstrap.php`)
- `setup.php` – run once to create the database and demo data
- `backups/` and `uploads/` – daily backups and patient documents (blocked from direct web access by `.htaccess`)

## Run it (XAMPP, easiest)
1. Install XAMPP (PHP 7.4 or newer) and start **Apache** and **MySQL**.
2. Copy this folder to `C:\xampp\htdocs\hospital-system` (macOS/Linux: the `htdocs` folder of your install).
3. Check `api/config.php`. XAMPP defaults (user `root`, empty password) work as they are.
4. Open `http://localhost/hospital-system/setup.php` once. It creates the `hospital_db` database, the tables and demo data.
5. Open `http://localhost/hospital-system/` and sign in. Demo accounts: username is the role (`admin`, `doctor`, `nurse`, `reception`, `lab`, `pharmacist`, `accountant`) and the password is the username followed by `123`.
6. Change the demo passwords (Administration → Users), then delete `setup.php`.

## Using Visual Studio Code
Open the folder in VS Code. The PHP built-in server also works: with MySQL running, run `php -S localhost:8000` in the project folder and open `http://localhost:8000`. That server ignores `.htaccess`, so use Apache for anything beyond local testing.

## What is enforced on the server
Password hashing (`password_hash`), sign-in attempt limit, 10-minute session timeout, role-based write access, admin-only delete, double-booking check, negative stock check, server-generated invoice numbers, audit log of every change, daily backups with restore.

## Before real hospital use
Serve over HTTPS, use a dedicated MySQL user (not `root`), restrict read access per role (the API currently lets any signed-in user read every module's data so forms can show names), and review the data-protection rules that apply to you.
