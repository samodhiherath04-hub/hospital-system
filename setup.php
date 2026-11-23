<?php
// Run once in the browser: http://localhost/hospital-system/setup.php
require __DIR__ . '/api/bootstrap.php';
header('Content-Type: text/html; charset=utf-8');
try {
  $x = new PDO('mysql:host='.DB_HOST.';charset=utf8mb4', DB_USER, DB_PASS, [PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION]);
  $x->exec('CREATE DATABASE IF NOT EXISTS `'.DB_NAME.'` CHARACTER SET utf8mb4');
  schema(); $p = db();
} catch (Throwable $e) { die('<p>Could not reach MySQL. Start MySQL and check api/config.php.</p><pre>'.htmlspecialchars($e->getMessage()).'</pre>'); }
if ($p->query('SELECT COUNT(*) FROM hms_users')->fetchColumn() > 0) die('<p>Already set up. You can delete setup.php. <a href="index.html">Open the system</a></p>');
function ins($c, $rows) { global $p; $s = $p->prepare("INSERT INTO hms_$c(id,data) VALUES(?,?)"); foreach ($rows as $r) $s->execute([$r['id'], json_encode($r)]); }
$t = date('Y-m-d'); $d = fn($n) => date('Y-m-d', strtotime("$n days")); $W = 'Mon,Tue,Wed,Thu,Fri,Sat,Sun';
ins('departments', [['id'=>'DP1','name'=>'General Medicine','head'=>'Dr. Silva'],['id'=>'DP2','name'=>'Cardiology','head'=>'Dr. Perera'],['id'=>'DP3','name'=>'Paediatrics','head'=>'Dr. Fernando']]);
ins('doctors', [['id'=>'D1','name'=>'Dr. Silva','dept'=>'DP1','spec'=>'Physician','fee'=>1500,'days'=>$W,'hours'=>'09:00-15:00'],['id'=>'D2','name'=>'Dr. Perera','dept'=>'DP2','spec'=>'Cardiologist','fee'=>3000,'days'=>$W,'hours'=>'10:00-16:00']]);
ins('patients', [['id'=>'P1','name'=>'Nimal Jayasuriya','dob'=>'1978-03-14','gender'=>'Male','phone'=>'0771234567','address'=>'12 Lake Road','blood'=>'O+','allergies'=>'Penicillin'],['id'=>'P2','name'=>'Kamala Wijesinghe','dob'=>'1991-09-02','gender'=>'Female','phone'=>'0719876543','address'=>'48 Temple Lane','blood'=>'A+','allergies'=>'']]);
ins('appointments', [['id'=>'A1','patient'=>'P1','doctor'=>'D1','date'=>$t,'time'=>'10:00','status'=>'Booked','notes'=>'Fever'],['id'=>'A2','patient'=>'P2','doctor'=>'D2','date'=>$t,'time'=>'11:30','status'=>'Booked','notes'=>'Checkup']]);
ins('records', [['id'=>'R1','patient'=>'P1','doctor'=>'D1','date'=>$t,'diagnosis'=>'Viral fever','treatment'=>'Rest and fluids','med'=>'M1','qty'=>10,'report'=>'','done'=>0]]);
ins('labs', [['id'=>'L1','patient'=>'P1','doctor'=>'D1','test'=>'Full blood count','price'=>1200,'date'=>$t,'status'=>'Requested','result'=>'']]);
ins('meds', [['id'=>'M1','name'=>'Paracetamol 500mg','stock'=>200,'reorder'=>50,'price'=>5,'expiry'=>$d(400)],['id'=>'M2','name'=>'Amoxicillin 250mg','stock'=>12,'reorder'=>30,'price'=>18,'expiry'=>$d(30)]]);
ins('bills', [['id'=>'B1','inv'=>'INV-1001','patient'=>'P2','date'=>$t,'consult'=>3000,'lab'=>0,'pharmacy'=>0,'admission'=>0]]);
ins('employees', [['id'=>'E1','name'=>'Sunil Fernando','role'=>'Nurse','dept'=>'DP1','phone'=>'0702223344','joined'=>'2022-05-01']]);
$p->exec("REPLACE INTO hms_meta VALUES('inv',1001)");
$names = ['admin'=>'Administrator','doctor'=>'Doctor','nurse'=>'Nurse','reception'=>'Receptionist','lab'=>'Laboratory staff','pharmacist'=>'Pharmacist','accountant'=>'Accountant'];
$s = $p->prepare('INSERT INTO hms_users(id,username,name,role,pw_hash) VALUES(?,?,?,?,?)');
foreach ($names as $r => $n) $s->execute(['U-'.$r, $r, $n, $r, password_hash($r.'123', PASSWORD_DEFAULT)]);
echo '<p>Setup complete. Demo logins: username = role (for example <b>admin</b>), password = username + 123. Change them after signing in, then delete setup.php.</p><p><a href="index.html">Open the system</a></p>';
