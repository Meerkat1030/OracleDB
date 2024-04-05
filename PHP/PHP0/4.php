<?php
function gcd($a, $b) {
    if ($a == 0)
        return $b;
    return gcd($b % $a, $a);
}

function lcm($a, $b) {
    return ($a * $b) / gcd($a, $b);
}

function error_mesg(array $e, $mess) {
    return "{$e['message']}<br><b><font color=red>$mess</font></b>";
}

include 'table_style1.php';
$conn = oci_connect("scott", "tiger", "localhost/course");
if (!$conn) {
    $e = oci_error();
    exit(error_mesg($e, "Connection Failed ..."));
}
$stmt = oci_parse($conn, "select name from moviestar  order by name");
$cnt_si = oci_parse($conn, "select count(*) si_cnt from starsin where starname = :1");//출연영화 갯수
$se_si = oci_parse($conn, "select movietitle, movieyear from starsin where starname = :1"); //출연영화 정보
$cnt_st = oci_parse($conn, "select count(*) st_cnt from studio where presno = (select certno from movieexec where name = :1)");//이사람이 운영하는 영화사 수
$se_st = oci_parse($conn, "select name presname from studio where presno = (select certno from movieexec where name = :1)"); //이사람이 운영하는 영화사 이름
$cnt_mo = oci_parse($conn, "select count(*) mo_cnt from movie where producerno = (select certno from movieexec where name = :1)");//이사람이 제작한 영화 갯수

oci_define_by_name($cnt_si, "SI_CNT", $si_cnt);
oci_define_by_name($cnt_st, "ST_CNT", $st_cnt);
oci_define_by_name($se_st, "PRESNAME", $presname);
oci_define_by_name($cnt_mo, "MO_CNT", $mo_cnt);
oci_execute($stmt);

table_head(array('영화배우', '출연영화', '영화 임원 경력'));
while ($row = oci_fetch_array($stmt, OCI_BOTH)) {
    oci_bind_by_name($cnt_si, ":1", $name);
    oci_execute($cnt_si); 
    $si_cnt_row = oci_fetch_array($cnt_si);
    
    oci_bind_by_name($se_si, ":1", $name);
    oci_execute($se_si); 
    
    oci_bind_by_name($cnt_st, ":1", $name);
    oci_execute($cnt_st); 
    $st_cnt_row = oci_fetch_array($cnt_st);
    
    oci_bind_by_name($se_st, ":1", $name);
    oci_execute($se_st); 
    
    oci_bind_by_name($cnt_mo, ":1", $name);
    oci_execute($cnt_mo); 
    $mo_cnt_row = oci_fetch_array($cnt_mo);
    
    $str = "";
    $chk = true;
    while ($si_row = oci_fetch_array($se_si)) {
        if ($chk)
            $str = "$movietitle($movieyear)";
        else
            $str = $str . ",$movietitle($movieyear)";
        $chk = false;
    }
    if ($chk) {
        $si_arr = array("없음");
        $si_cnt = 1;
    } else {
        $si_arr = explode(",", $str3);
    }
    if($mo_cnt == 0){
        $mo = "영화 제작 경력 없음";
    }
    else{
        $mo = "{$mo_cnt}편의 영화 제작";
    }
    $all_lcm = lcm($si_cnt,2);
    $sispan = $all_lcm/$si_cnt;
    $mespan = $all_lcm/2;
    print "<TR> <TD rowspan = $all_lcm> $name ";
    for ($i = 0; $i < $all_lcm; $i++) {
         if ($i == 0) {//제일 처음 이라면 무조건 다 출력
            print "<TD rowspan = $morspan> $mo_arr[$i]";
            print "<TD rowspan = $sirspan> $si_arr[$i]";
    }
}
}
?>