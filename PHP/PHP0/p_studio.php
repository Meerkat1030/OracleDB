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
$query = "select s.name, s.address, e.name, e.address from studio s, movieexec e where e.certno = s.presno and s.name = '$sname' ";
$stmt = oci_parse($conn,$query);
oci_execute($stmt);

print "<TABLE style='background: yellow;color: blue' border=2 cellspacing=2>\n";

$chk = true;
while ($row = oci_fetch_array($stmt, OCI_BOTH)) {
    $chk = false;
    print "<tr><td> 영화사 <td> $row[0] </tr>";
    print "<tr><td> 영화사 주소 <td> $row[1] </tr>";
    print "<tr><td> 사장이름 <td> $row[2] </tr>";
    print "<tr><td> 사장주소 <td> $row[3] </tr>";

}
if($chk) print "<tr><td style='background:red;color:white'> {$sname}의 회사 없음</tr>";

print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>
