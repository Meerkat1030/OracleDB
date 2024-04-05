<?php
function error_mesg (array $e, $mess) {//$붙은건 변수명
    return $e['message']."<br><b><font color=red>$mess</font></b>";//여기서는 ""안에 변수가 잇으면 파라미터로 들어온 변수 값이 나옴 ''은 있는그대로 출력시킴 .은 sql의 ||과 같은 기능
}/*{}를 쓸때는 변수인지 아닌지 명확히 하기위해서 사용 {$e['message']}여기서는 특수 문자때문에 써줌 <br>은 줄바꿈*/

$conn = oci_connect("db2017948072","db33646926", "localhost/course");//oci_로 시작하는건 php사용을 위함 라이브러리 오라클 계정과 비번 순으로
if (!$conn) {
	$e = oci_error();
        exit(error_mesg($e, "Connection Failed ..."));
}//로그인이 잘못됫다면

$stmt = oci_parse($conn,"select title, year, length len, incolor col, name, studioname std from movie, movieexec"
        . " where producerno = certno");//무조건 한칸 띄우기 movieexecwhere로 인식해버림
if (!$stmt) {
    $e = oci_error();
    exit(error_mesg($e, "Parsing Failed ..."));
}//여기까진 parsing만
//oci_define_by_name($stmt, "YEAR", $year);
//where에 title = movietitle year = movieyear을 이용해서 출연한 배우들을 뽑아보기

$r = oci_execute($stmt);//이제 실행
if (!$r) {
	$e = oci_error();
        exit(error_mesg($e, "Execute Failed ..."));
}

print "<TABLE style='background: yellow;color: blue' border=1 cellspacing=2>\n";
print "<TR bgcolor=white><TH> 제목 <TH> 연도 <TH> 칼러영화? <TH> 상영시간 <TH> 제작자 이름<TH> 영화사 이름</TR>\n";

while ($row = oci_fetch_array($stmt, OCI_BOTH)) {//oci_fetch_array자주사용 parsing된 문장이 옴 oci_both를 하면 배열의 수로 검색이 가능하고 애트리뷰트로도 검색이 가능해진다.
    $year = $row[1];
    print "<TR> <TD> ".$row[0];//title
	print "<TD>{$year}년 개봉";
        print "<TD>{$row['COL']}";
        // print "<TD>".$row['YEAR'];
	print "<TD align=center>".$row['LEN'];//애트리뷰트 이름으로 검색을 할때엔 반드시 대문자로만 적어줘야 한다. 또한 문자열이기에 ""나 ''사이에 넣어줘야 한다.
        print "<TD>{$row['NAME']} \n";
        print "<TD> {$row['STD']} </TR>\n";
}//튜플이 배열로 넘어 온다 row[0] = title값이 들어 잇을거고 row[1]은 year값이
print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>

