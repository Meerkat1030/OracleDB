<?php
function error_mesg (array $e, $mess) {
    return "{$e['message']}<br><b><font color=red>$mess</font></b>";
}
$title = $_POST['title'];
$min_length = $_POST['min_length'];
$max_length = $_POST['max_length'];
$birthdate = $_POST['birthdate'];

print "<h3>$title, $min_length - $max_length, $birthdate</h3>";
$conn = oci_connect("scott","tiger", "localhost/course");
if (!$conn) {
	$e = oci_error();
        exit(error_mesg($e, "Connection Failed ..."));
}
$query = "select distinct(title), year, movieexec.name mename, studioname stud, studio.address saddr from movie, movieexec, studio, moviestar, starsin "
        . "where producerno = certno and studioname = studio.name";
$t = str_replace("'", "''", $title);

if(!empty($title))  $query = $query." and upper(title) like upper('%{$t}%') ";
if ($min_length==null && $max_length==null ) $query = $query." ";
else if($min_length==null && $max_length!=null ) $query =$query. " and  length<=$max_length ";
else if ($min_length!=null &&$max_length ==null) $query =$query. " and length >= $min_length ";
else  $query =$query. " and length >= $min_length and  length<=$max_length ";
if(!empty($birthdate)) $query = $query."  and moviestar.name = starname and title = movietitle and year = movieyear and moviestar.birthdate > to_date('". $birthdate. "-12-31','RRRR-MM-DD')";

$stmt = oci_parse($conn,$query);

oci_define_by_name($stmt, "TITLE", $title);
oci_define_by_name($stmt, "YEAR", $year);
oci_define_by_name($stmt, "MENAME", $mename);
oci_define_by_name($stmt, "STUD", $stud);
oci_define_by_name($stmt, "SADDR", $saddr);

oci_execute($stmt);

print "<TABLE style='background: yellow;color: blue' border=1 cellspacing=2>\n";
print "<TR bgcolor=#1ebcbabf align=center><TH> 영화제목 <TH> 개봉년도 <TH> 제작자 이름 <TH> 영화사 이름 <TH> 영화사 주소</TR>\n";

while ($row = oci_fetch_array($stmt, OCI_BOTH)) {
    print "<TR> <TD> $title <TD> $year <TD> $mename <TD> $stud <TD> $saddr </TR>\n";
}
print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>

