<?php
function error_mesg (array $e, $mess) {
    return "{$e['message']}<br><b><font color=red>$mess</font></b>";
}
include 'table_style1.php';
$conn = oci_connect("scott","tiger", "localhost/course");
if (!$conn) {
	$e = oci_error();
        exit(error_mesg($e, "Connection Failed ..."));
}

$stmt = oci_parse($conn,"select title, year, length, name prod, studioname stud from movie,movieexec ".
        "where producerno = certno order by 2 desc, 1");
$cnt_tmt = oci_parse($conn,"select count(*) cnt from starsin where movietitle = :1 and movieyear = :2 ");
$si_tmt = oci_parse($conn,"select starname sname from starsin where movietitle = :1 and movieyear = :2 ");

oci_define_by_name($stmt, "TITLE", $title);//반드시 대문자로 잇어야 한다 아님 안돌아감
oci_define_by_name($stmt, "YEAR", $year);
oci_define_by_name($stmt, "LENGTH", $len);
oci_define_by_name($stmt, "STUD", $stud);
oci_define_by_name($stmt, "PROD", $prod);
oci_define_by_name($cnt_tmt, "CNT", $cnt);
oci_define_by_name($si_tmt, "SNAME", $sname);

oci_execute($stmt);//excute되면 일종의 cursor가 된다
/*
print "<TABLE style='background: yellow;color: blue' border=1 cellspacing=2>\n";
print "<TR bgcolor=#1ebcbabf><TH> 제목 <TH> 상영시간 <TH> 제작자 <TH> 영화사</TR>\n";
*/
table_head(array('제목','상영시간','제작자','영화사','출연배우 수'));
while ($row = oci_fetch_array($stmt, OCI_BOTH)) {//oci fetch array를 가장 많이 씀 & row안에 튜플 하나씩 배열로 넣어주고있다.
    oci_bind_by_name($si_tmt, ":1", $title);
    oci_bind_by_name($si_tmt, ":2", $year);
    oci_execute($si_tmt);
    
    oci_bind_by_name($cnt_tmt, ":1", $title);
    oci_bind_by_name($cnt_tmt, ":2", $year);
    oci_execute($cnt_tmt);
    $cnt_row = oci_fetch_array($cnt_tmt);
    
    $str = "";
    $chk = true;
    while($si_row = oci_fetch_array($si_tmt)){
       if($chk) $str = $sname;
       else $str = $str. ",$sname";
       $chk = false;
    }
    if($chk) { 
        $sn_arr = array("출연배우 정보 없음");
        $cnt = 1;//cnt가 0일때에도 한칸을 차지를 해야 하기 때문에 1을 증가 시켜 주어야 한다
    }
    else{
        $sn_arr = explode(",", $str);
    }
    foreach ($sn_arr as $k => $v){
        if($k == 0)//rowspan을 사용할때 첫줄은 무조건 다나오고
            print "<TR> <TD rowspan = $cnt> $title($year) <TD rowspan = $cnt> $len <TD rowspan = $cnt> $prod <TD rowspan = $cnt> $stud <TD> $v </TR>\n";//fetch를 해줄때마다 현재 읽은 결과 튜플의 각 컬럼값을 지시한 변수의 이름으로 엑세스 해줌
        else //첫줄 이후로는 필요한 정보만 나오게 해주기
            print "<TR> <TD> $v </TR>";
        // print "<TR> <TD> $row[0] <TD> $year <TD align=center> $row[2] <TD> {$row['STUD']} </TR>\n";
    }
}
table_tail();
//print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>
