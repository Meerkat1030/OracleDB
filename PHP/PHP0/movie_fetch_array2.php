<?php
function error_mesg (array $e, $mess) {
    return "{$e['message']}<br><b><font color=red>$mess</font></b>";
}

$conn = oci_connect("scott","tiger", "localhost/course");
if (!$conn) {
	$e = oci_error();
        exit(error_mesg($e, "Connection Failed ..."));
}

$stmt = oci_parse($conn,"select title, year, length, studioname stud from movie ");

oci_define_by_name($stmt, "TITLE", $title);
oci_define_by_name($stmt, "YEAR", $year);
oci_define_by_name($stmt, "LENGTH", $len);
oci_define_by_name($stmt, "STUD", $stud);

oci_execute($stmt);

print "<TABLE style='background: yellow;color: blue' border=1 cellspacing=2>\n";
print "<TR bgcolor=#1ebcbabf align=center><TH> 제목 <TH> 연도 <TH> 상영시간 <TH> 영화사</TR>\n";

while ($row = oci_fetch_array($stmt, OCI_BOTH)) {
    print "<TR> <TD> $title <TD> $year <TD align=center> $len <TD> $stud </TR>\n";
    // print "<TR> <TD> $row[0] <TD> $year <TD align=center> $row[2] <TD> {$row['STUD']} </TR>\n";
}
print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>