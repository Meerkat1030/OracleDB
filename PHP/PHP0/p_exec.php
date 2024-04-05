<?php
function error_mesg (array $e, $mess) {
    return "{$e['message']}<br><b><font color=red>$mess</font></b>";
}

$conn = oci_connect("scott","tiger", "localhost/course");
if (!$conn) {
	$e = oci_error();
        exit(error_mesg($e, "Connection Failed ..."));
}

$sname = $_GET['certno'];
$query = "select certno, name, address, networth from movieexec ";
if(!empty($sname)) $query = $query." where certno = $sname";
$stmt = oci_parse($conn,$query);
oci_execute($stmt);

print "<TABLE style='background: yellow;color: blue' border=2 cellspacing=2>\n";

$chk = true;
while ($row = oci_fetch_array($stmt, OCI_BOTH)) {
    $chk = false;
    print "<tr><td> 번호 <td> $row[0] </tr>";
    print "<tr><td> 이름 <td> $row[1] </tr>";
    print "<tr><td> 주소 <td> $row[2] </tr>";
    print "<tr><td> 재산 <td> {$row[3]}원 </tr>";
}
if($chk) print "<tr><td style='background:red;color:white'> {$sname}의 제작자 없음</tr>";

print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>
