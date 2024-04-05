<?php
function error_mesg (array $e, $mess) {
    return "{$e['message']}<br><b><font color=red>$mess</font></b>";
}

$conn = oci_connect("scott","tiger", "localhost/course");
if (!$conn) {
	$e = oci_error();
        exit(error_mesg($e, "Connection Failed ..."));
}

$t = str_replace("'", "''", $_GET['title']);
$y = $_GET['year'];
$query = "select title, year, length, studioname, name from movie, movieexec where title = '$t' and year = $y and producerno = certno";
$stmt = oci_parse($conn,$query);
oci_execute($stmt);

print "<TABLE style='background: yellow;color: blue' border=2 cellspacing=2>\n";

$chk = true;
while ($row = oci_fetch_array($stmt, OCI_BOTH)) {
    $chk = false;
    print "<tr><td> 제목 <td> $row[0]({$row[1]}년 개봉) </tr>";
    print "<tr><td> 상영시간 <td> $row[2] </tr>";
    print "<tr><td> 제작사 <td> $row[3] </tr>";
    print "<tr><td> 제작자 이름 <td> $row[4] </tr>";

}
if($chk) print "<tr><td style='background:red;color:white'> {$t}({$y})의 영화 없음</tr>";

print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>
