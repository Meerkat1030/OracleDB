<?php

include 'table_style1.php';

$a = array("a"=>1, "b"=>2);
$b = array("c"=>3, "d"=>4);
$c = array("e"=>5, "f"=>6);
$d = array($a,$b,$c);

table_head(array('TH','TB'));

foreach($d as $k => $val) {
    print "<tr align=center>\n";
    foreach ($val as $key => $value) {
        print "<td>".strtoupper($key); 
    }
    print "</tr>\n";
}
table_tail();
?>