<?php
// for correct error message outputs


$conn = oci_connect("scott","tiger", "localhost/course");
if (! $conn) {
    $e = oci_error();
    print htmlentities($e['message']);
}

$sql_q = "select name as mn, address as ms, certno as mc from movieexec order by mn";

$stmt = oci_parse($conn, $sql_q);
if (! $stmt) {
    $e = oci_error($conn);
    print $e['message'];
    // print htmlentities($e['message']);
}

$r = oci_execute($stmt);
if (! $r) {
    $e = oci_error();
    print htmlentities($e['message']);
}

print "<TABLE bgcolor=#abbcbabc border=1 cellspacing=2>\n";
print "<TR bgcolor=#1ebcbabf align=center><TH> 이름 <TH> 주소  <TH> 영화사 <TH> 제작 영화 <TH> 출연 영화 </TR>\n";

$row = oci_fetch_all($stmt, $results, null, null, OCI_FETCHSTATEMENT_BY_ROW);

if ($row > 0) {
    for ($i = 0; $i < $row; $i ++) {
        $exec = $results[$i];
        $e_name = $exec['MN'];
        $e_cert = $exec['MC'];
        $name = str_replace("'", "''", $exec['MN']);
        $address = str_replace("'", "''", $exec['MS']);
        $m_stmt = oci_parse($conn, "select name as sn from studio where presno = $e_cert ");
        if (! $m_stmt) {
            $e = oci_error($conn);
            print $e['message'];
        }
        if (! oci_execute($m_stmt)) {
            $e = oci_error();
            print htmlentities($e['message']);
        }
        $s_stu = oci_fetch_all($m_stmt, $studios, null, null, OCI_FETCHSTATEMENT_BY_ROW);
        // -----------------------------------------------------------
        $m_stmt2 = oci_parse($conn, "select title, year from movie where producerno = $e_cert order by title ");
        if (! $m_stmt2) {
            $e = oci_error($conn);
            print $e['message'];
            // print htmlentities($e['message']);
        }
        if (! oci_execute($m_stmt2)) {
            $e = oci_error();
            print htmlentities($e['message']);
        }
        $m_movs = oci_fetch_all($m_stmt2, $movies, null, null, OCI_FETCHSTATEMENT_BY_ROW);
        // ------------------------------------------------------------------
        $m_stmt3 = oci_parse($conn, "select movietitle, movieyear from starsin where starname = '$e_name' order by movietitle ");
        if (! $m_stmt3) {
            $e = oci_error($conn);
            print $e['message'];
            // print htmlentities($e['message']);
        }
        if (! oci_execute($m_stmt3)) {
            $e = oci_error();
            print htmlentities($e['message']);
        }
        $m_stars = oci_fetch_all($m_stmt3, $stars, null, null, OCI_FETCHSTATEMENT_BY_ROW);

        // ------------------------------------------------------------------
        $r_span = max($s_stu, $m_movs, $m_stars);
        if ($r_span == 0) {
            $r_span = 1;
        }
        print "<TR>";
        print "<TD rowspan={$r_span}> {$exec['MN']} ";
        print "<TD rowspan={$r_span}> {$exec['MS']}";

        if ($s_stu == 0) {
            $s = 1;
        } else if ($s_stu >= 1) {
            $s = $s_stu;
        }

        for ($j = 0; $j < $s; $j ++) {
            $studio = $studios[$j];
            if ($s_stu == 1) {
                print "<TD align=center rowspan={$r_span}> {$studio['SN']} ";
            } else if ($s_stu > 1) {
                print "<TD align=center rowspan= 1> {$studio['SN']} ";
                if ($j == $s - 1) {
                    break;
                }
            } else if ($s_stu == 0) {
                print "<TD align=center rowspan={$r_span}> 정보 없음";
            }
            $m = $m_movs;
            if ($m_movs == 0) {
                $m = 1;
            }
            $cnt = 0;
            $cnt2 = 0;
            $l = 0;
            for ($z = 0; $z < $m; $z ++) {
                $movie = $movies[$z];
                $l = $z;
                if ($m_movs == 1) {
                    print "<TD align=center rowspan={$r_span}> {$movie['TITLE']}({$movie['YEAR']}) ";
                } else if ($m_movs > 1) {

                    if ($cnt2 < $m_movs) {
                        print "<TD align=center rowspan=1> {$movie['TITLE']}({$movie['YEAR']}) ";
                        if ($m_stars > 1) {
                            $w = $l;
                            $star = $stars[$w];
                            print "<TD align=center rowspan=1> {$star['MOVIETITLE']}({$star['MOVIEYEAR']}) ";
                        }
                    } else if ($cnt2 >= $m_movs) {
                        print "<TD align=center rowspan=1> - ";
                        if ($m_stars > 1) {     
                            $w = $l;
                            $star = $stars[$w];
                            print "<TD align=center rowspan=1> {$star['MOVIETITLE']}({$star['MOVIEYEAR']}) ";
                        }
                    }
                    $cnt2 ++;
                    if ($m_movs <= $m_stars & $cnt2 != 0 && 2 <= $cnt2) {
                        $m = $m_stars;
                    }
                }
                if ($m_movs == 0) {
                    print "<TD align=center rowspan={$r_span}> 정보 없음 ";
                }
                $x = $m_stars;
                if ($m_stars == 0) {
                    $x = 1;
                }
                for ($w = 0; $w < $x; $w ++) {
                    $star = $stars[$w];
                    if ($m_stars == 1) {
                        print "<TD align=center rowspan={$r_span}> {$star['MOVIETITLE']}({$star['MOVIEYEAR']}) ";
                    } else if ($m_stars > 1 && $m_movs < 2) {
                        print "<TD align=center rowspan=1> {$star['MOVIETITLE']}({$star['MOVIEYEAR']}) ";
                    }
                    if ($m_stars == 0) {
                        if ($cnt == 0) {
                            print "<TD align=center rowspan={$r_span}> 정보 없음";
                            $cnt ++;
                        }
                    }
                    print "</TR>";
                }
            }
            $cnt = 0;
        }
    }
}

print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>