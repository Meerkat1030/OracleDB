<?php

include 'table_style1.php';

/*$a = array("a"=>1, "b"=>2);//array("a"=>1, "b"=>2) 왼쪽이 키값 오른쪽이 첨자값 a에 1을 넣은거
$b = array("c"=>3, "d"=>4);
$c = array("e"=>5, "f"=>6);
$d = array($a,$b,$c);//이차원 배열*/

$a = array("A1","A2","A3");
$b = array("B4","B5","B6");
$c = array("C7","C8","C9");
$d = array($a,$b,$c);//이차원 배열

$str1 = '가,나,다';
$arr1 = explode(",", $str1);//str1의 문자열을 ,단위로 끊어서 배열로 저장
$arr2 = array($arr1,$arr1,$arr1);

table_head(array('열 A','열 B','열 C'));

foreach($arr2 as $k => $val) {
    print "<tr align=center>\n";
    foreach ($val as $key => $value) {
        print "<td>".strtoupper($value)."[$key]"; //strtoupper는 문자를점부다 대문자로
    }
    print "</tr>\n";
}
table_tail();
?>