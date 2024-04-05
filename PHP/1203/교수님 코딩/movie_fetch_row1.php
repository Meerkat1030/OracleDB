<?php
function error_mesg (array $e, $mess) {
    return "{$e['message']}<br><b><font color=red>$mess</font></b>";
}

$conn = oci_connect("scott","tiger", "localhost/course");
if (!$conn) {
	$e = oci_error();
        exit(error_mesg($e, "Connection Failed ..."));
}

$stmt = oci_parse($conn,"select title tt, year yy, length len, studioname std from movie ");
if (!$stmt) {
    $e = oci_error();
    exit(error_mesg($e, "Parsing Failed ..."));
}

oci_define_by_name($stmt, "TT", $title);
oci_define_by_name($stmt, "YY", $year);
oci_define_by_name($stmt, "STD", $studio);
oci_define_by_name($stmt, "LEN", $length);

$r = oci_execute($stmt);
if (!$r) {
	$e = oci_error();
        exit(error_mesg($e, "Execute Failed ..."));
}

print "<TABLE style='background: yellow;color: blue' border=1 cellspacing=2>\n";
print "<TR bgcolor=#1ebcbabf align=center><TH> 제목 <TH> 연도 <TH> 상영시간 <TH> 영화사</TR>\n";

while ($row = oci_fetch_row($stmt)) {
    print "<TR> <TD> $row[0] <TD> $row[1] <TD align=center> $row[2] <TD> $row[3] </TR>\n";
    // print "<TR> <TD> $title <TD> $year <TD align=center>$length <TD> $studio </TR>\n";
}

print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>
