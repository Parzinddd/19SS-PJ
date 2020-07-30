<?php
session_start();
//消除session
unset($_SESSION['admin']);
echo "<script type='text/javascript'>alert('注销成功！');location.href='log.php';</script>";
?>
