<?php
// the message

if($_SERVER["REQUEST_METHOD"] == "GET") {
$msg = = $_GET[data];

// use wordwrap() if lines are longer than 70 characters
$msg = wordwrap($msg,70);

// send email
mail("contact@alexanderdavis.tech","New Form Submitted",$msg);
?>
