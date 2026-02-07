<?php
// Pear Mail Library

$from = 'contact@infectati.ro';
$to = 'serban_alexandru2001@yahoo.com';
$subject = 'Hi!';
$body = "Hi,\n\nHow are you?";

$headers = array(
    'From' => $from,
    'To' => $to,
    'Subject' => $subject
);

$smtp = Mail::factory('smtp', array(
        'host' => 'web.quality-host.ro',
        'port' => '465',
        'auth' => true,
        'username' => 'contact@infectati.ro',
        'password' => 'iamcreativity16'
    ));

$mail = $smtp->send($to, $headers, $body);

if (PEAR::isError($mail)) {
    echo('<p>' . $mail->getMessage() . '</p>');
} else {
    echo('<p>Message successfully sent!</p>');
}
?>