<?php

function error_mesg(array $e, $mess) {
    return "{$e['message']}<br><b><font color=red>$mess</font></b>";
}

include '2_table_style.php';
$conn = oci_connect("scott", "tiger", "localhost/course");
if (!$conn) {
    $e = oci_error();
    exit(error_mesg($e, "Connection Failed ..."));
}

$stmt =  oci_parse($conn,"select title, year, length, movieexec.name, studioname from movie, movieexec where  producerno = certno");
oci_execute($stmt);



table_head(array('제목', '년도', '상영시간', '제작자', '영화사'));
while ($row = oci_fetch_array($stmt, OCI_BOTH)) {
   print"<TR><TD>$row[0]<TD>{$row[1]}년<TD>{$row[2]}분<TD>$row[3]<TD>$row[4]</TR>";
}
table_tail();
oci_free_statement($stmt);
oci_close($conn);

?>
