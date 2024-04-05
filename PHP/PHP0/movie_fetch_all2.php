<?php //row 베이스
function error_mesg (array $e, $mess) {
    return "{$e['message']}<br><b><font color=red>$mess</font></b>";
}

$conn = oci_connect("scott","tiger", "localhost/course");
if (!$conn) {
   $e = oci_error();
        exit(error_mesg($e, "Connection Failed ..."));
}

$stmt = oci_parse($conn,"select name, movietitle, movieyear from moviestar,starsin where starname = name order by name,movieyear desc ");
oci_execute($stmt);


$nrows = oci_fetch_all($stmt, $results,null,null,OCI_FETCHSTATEMENT_BY_ROW);//몇번째값부터 받을건지(null넣으면 default),이제부터 ROW로 넘어옴
if($nrows > 0) {
   print "<TABLE bgcolor=#abbebabc border=1>\n";
   print "<TR bgcolor=#fbfebaec align=center>";
        
   foreach ($results[0] as $key => $val) {//첫 행에 대해 KEY값만 출력
      print "<TH>$key</th>\n";
   }
        
   print "</TR>\n";

   for($i = 0; $i < $nrows; $i++) {//튜플수만큼 돌림
      print "<TR>\n";
      foreach ($results[$i] as $key => $data) {
                    switch ($key) {//KEY값은 대문자로 써줘야함
//                        case "LENGTH":
//                            print "<TD> {$data}분\n";
//                            break;
//                        case "STUDIONAME":
//                            print "<TD> <a target=_blank href='p_studio.php?sname=$data'>$data</a>\n";//새창에서 띄우길 원하면target=_blank넣으면된다
//                            break;
//                        case "PRODUCERNO":
//                            print "<TD> <a target=_blank href='p_exec.php?certno=$data'>$data</a>\n";//새창에서 띄우길 원하면target=_blank넣으면된다
//                            break;
                         case "MOVIETITLE":
                             $title = htmlspecialchars($data,ENT_QUOTES);//문자열이 무엇이든 url에서 통용이 가능하게 인코딩이 가능하게 하라 '를 인식하기위해 넣어줌
                             $year = $results[$i]['MOVIEYEAR'];
                            print "<TD> <a target=_blank href='p_movie.php?title=$title&year=$year'>{$data}($year)</a>\n";//$title은 html에 맞게 변경되어 잇기 때문에 원본을 위해서 $data를 출력
                            break;
                         case "MOVIEYEAR":
                             break;
                        default:
                            print "<TD> $data\n";
                            break;
                    }
      }
      print "</TR>\n";
   }
   print "</TABLE>\n";
} else
   print "No Data Found<br>\n";
print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>