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
$stmt = oci_parse($conn, "select me.certno mecertno, me.name mename, me.address meaddr from movieexec me order by me.name"); //임원 이름, 주소 찾고
$cnt_st = oci_parse($conn, "select count(*) st_cnt from studio where presno = :1"); //그 임원이 운영하는 영화사 갯수를 샌후
$se_st = oci_parse($conn, "select s.name stname from studio s where s.presno = :1"); //그 임원의 영화사 이름을 얻음
$cnt_mo = oci_parse($conn, "select count(*) mo_cnt from movie where producerno = :1"); //임원이 제작한 영화 갯수를 샌후
$se_mo = oci_parse($conn, "select title mtitle, year myear from movie where producerno = :1 order by 2,1"); //임원이 제작한 영화 제목과 연도를 받아온다
$cnt_si = oci_parse($conn, "select count(*) si_cnt from starsin where starname = :1"); //임원이 출연한 영화 갯수를 샌후
$se_si = oci_parse($conn, "select movietitle sititle, movieyear siyear from starsin where starname = :1 order by 2,1"); //임원이 출연한 영화 제목과 연도를 받아온다


oci_define_by_name($stmt, "MENAME", $mename);
oci_define_by_name($stmt, "MEADDR", $meaddr);
oci_define_by_name($stmt, "MECERTNO", $mecertno);
oci_define_by_name($cnt_st, "ST_CNT", $st_cnt);
oci_define_by_name($se_st, "STNAME", $stname);
oci_define_by_name($cnt_mo, "MO_CNT", $mo_cnt);
oci_define_by_name($se_mo, "MTITLE", $mtitle);
oci_define_by_name($se_mo, "MYEAR", $myear);
oci_define_by_name($cnt_si, "SI_CNT", $si_cnt);
oci_define_by_name($se_si, "SITITLE", $sititle);
oci_define_by_name($se_si, "SIYEAR", $siyear);

oci_execute($stmt);

$no = 1; //순번을 위한것 하나씩 증가 시켜줘야 함
table_head(array('순번', '이름', '주소', '영화사', '제작 영화', '출연 영화'));

while ($row = oci_fetch_array($stmt, OCI_BOTH)) {
    oci_bind_by_name($cnt_st, ":1", $mecertno);
    oci_execute($cnt_st); //cnt_st에 certno넘겨주기 완료$
    $st_cnt_row = oci_fetch_array($cnt_st);

    oci_bind_by_name($se_st, ":1", $mecertno);
    oci_execute($se_st); //se_st에 certno넘겨주기 완료

    oci_bind_by_name($cnt_mo, ":1", $mecertno);
    oci_execute($cnt_mo); //cnt_mo에 certno넘겨주기 완료
    $mo_cnt_row = oci_fetch_array($cnt_mo);

    oci_bind_by_name($se_mo, ":1", $mecertno);
    oci_execute($se_mo); //se_mo에 certno넘겨주기 완료

    oci_bind_by_name($cnt_si, ":1", $mename);
    oci_execute($cnt_si); //cnt_si에 certno넘겨주기 완료
    $si_cnt_row = oci_fetch_array($cnt_si);

    oci_bind_by_name($se_si, ":1", $mename);
    oci_execute($se_si); //se_si에 certno넘겨주기 완료

    $str1 = "";
    $chk1 = true;
    while ($st_row = oci_fetch_array($se_st)) {
        if ($chk1)
            $str1 = $stname;
        else
            $str1 = $str1 . ",$stname";
        $chk1 = false;
    }
    if ($chk1) {
        $st_arr = array("없음");
        $st_cnt = 1;
    } else {
        $st_arr = explode(",", $str1);
    }
    $str2 = "";
    $chk2 = true;
    while ($mo_row = oci_fetch_array($se_mo)) {
        if ($chk2)
            $str2 = "$mtitle($myear)";
        else
            $str2 = $str2 . ",$mtitle($myear)";
        $chk2 = false;
    }
    if ($chk2) {
        $mo_arr = array("없음");
        $mo_cnt = 1;
    } else {
        $mo_arr = explode(",", $str2);
    }
    $str3 = "";
    $chk3 = true;
    while ($si_row = oci_fetch_array($se_si)) {
        if ($chk3)
            $str3 = "$sititle($siyear)";
        else
            $str3 = $str3 . ",$sititle($siyear)";
        $chk3 = false;
    }
    if ($chk3) {
        $si_arr = array("없음");
        $si_cnt = 1;
    } else {
        $si_arr = explode(",", $str3);
    }
//    $rspan = $st_cnt * $mo_cnt * $si_cnt;
    $all_lcm = lcm(lcm($st_cnt, $mo_cnt), $si_cnt);
    $strspan = $all_lcm / $st_cnt;
    $morspan = $all_lcm / $mo_cnt;
    $sirspan = $all_lcm / $si_cnt;

    print "<TR> <TD rowspan = $all_lcm> $no <TD rowspan = $all_lcm>$mename <TD rowspan = $all_lcm>$meaddr";

    $st = 0;//영화사의 최대 크기에서 삽입한 만큼 빼주기 위한 변수 사람마다의 초기화를 위해 바깥에 선언
    $mo = 0;//제작영화의 최대 크기에서 삽입한 만큼 빼주기 위한 변수
    $si = 0;//출연 영화의 최대 크기에서 삽입한 만큼 빼주기 위한 변수
    $a = 0;//i가 증가함에 따라 3번째 키가 없는데 출력되는 걸 막기위한 변수 사람마다의 초기화를 위해 바깥에 선언
    $b = 0;//i가 증가함에 따라 3번째 키가 없는데 출력되는 걸 막기위한 변수
    $c = 0;//i가 증가함에 따라 3번째 키가 없는데 출력되는 걸 막기위한 변수
    for ($i = 0; $i < $all_lcm; $i++) {
        if ($i == 0) {//제일 처음 이라면 무조건 다 출력
            print "<TD rowspan = $strspan> $st_arr[$i]";
            print "<TD rowspan = $morspan> $mo_arr[$i]";
            print "<TD rowspan = $sirspan> $si_arr[$i]";
            $st += $strspan;//사용한만큼 크기 변수 증가
            $mo += $morspan;
            $si += $sirspan;
            $a+=1;//각 배열의 index값도 증가
            $b+=1;
            $c+=1;
        } else {//처음이 아니라면
            print "<TR>";//TR로 시작 겁나게 중요
            if ($i == $st && $st < $all_lcm) {//만약 2번째 정보라면
                print "<TD rowspan = $strspan> $st_arr[$a]";//a번째 value출력
                $st += $strspan;//사용량 증가
                $a+=1;//index 증가
            }
            if ($i == $mo && $mo < $all_lcm) {
                print "<TD rowspan = $morspan> $mo_arr[$b]";
                $mo += $morspan;
                $b+=1;
            }
            if ($i == $si && $si < $all_lcm) {
                print "<TD rowspan = $sirspan> $si_arr[$c]";
                $si += $sirspan;
                $c+=1;
            }
        }
        print "</TR>";//무조건 한바퀴 돌때마다 TR이 마무리가 되게
    }
    $no = $no + 1;
}
table_tail();

oci_free_statement($stmt);
oci_close($conn);
?>
