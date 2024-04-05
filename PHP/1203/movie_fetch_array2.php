<?php
function error_mesg (array $e, $mess) {
    return "{$e['message']}<br><b><font color=red>$mess</font></b>";
}
$title = $_POST['title'];
$year = $_POST['year'];
$stud = $_POST['studio'];


print "<h3>$title, $year, $stud</h3>";

$conn = oci_connect("scott","tiger", "localhost/course");
if (!$conn) {
	$e = oci_error();
        exit(error_mesg($e, "Connection Failed ..."));
}
$query = "select title, year, length, studioname stud from movie ";


if(!empty($title)|| !empty($year) || !empty($stud))//저 셋중 하나라도 null이 아니라면 where을 추가 하자
    $query = $query." where ";
$t = str_replace("'", "''", $title);//입력한것중에 '하나로 되어 잇다면 ''으로 replace시켜줌
// if(strcmp("'", $title) ==0) $title = "''";//제목에 '가 포함된 영화를 찾기위해서는 '를 ''으로 해서 검색해야한다.
if(!empty($title))  $query = $query." title like '%{$t}%' ";//문자열이라면 ''를 반드시 붙여주자
if(!empty($year)) $query = $query." and year >= $year ";
if(!empty($stud)) $query = $query." and studioname = '$stud' ";

$stmt = oci_parse($conn,$query);

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