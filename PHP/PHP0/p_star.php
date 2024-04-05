<?php
function error_mesg (array $e, $mess) {
    return "{$e['message']}<br><b><font color=red>$mess</font></b>";
}

$conn = oci_connect("scott","tiger", "localhost/course");
if (!$conn) {
	$e = oci_error();
        exit(error_mesg($e, "Connection Failed ..."));
}

$sname = $_GET['sname'];
$query = "select name, address, gender, to_char(birthdate,'YYYY-MM-DD') from moviestar where name = '$sname' ";
$stmt = oci_parse($conn,$query);
oci_execute($stmt);

print "<TABLE style='background: yellow;color: blue' border=2 cellspacing=2>\n";

$chk = true;
while ($row = oci_fetch_array($stmt, OCI_BOTH)) {
    $chk = false;
    print "<tr><td> 배우이름 <td> $row[0]($row[2]) </tr>";
    print "<tr><td> 주소 <td> $row[1] </tr>";
    $d = explode("-", $row[3]);
    print "<tr><td> 생일 <td> {$d[0]}년 {$d[1]}월 {$d[2]}일 </tr>";
}
if($chk) print "<tr><td style='background:red;color:white'> {$sname}의 배우 없음</tr>";

print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>
