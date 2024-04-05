<?php
function table_head(array $th) {
    print "<head><link rel='stylesheet' href='table1.css'></head><body>";
    print "<TABLE>";
    print "<thead>";
    if(count($th) > 0) {
        print "<TR align=center>";
        foreach($th as $k => $v) {
            print "<th> $v";
        }
        print "</TR>\n";
    }
    print "</thead><tbody>";
}

function table_tail() {
    print "</tbody>";
    print "</TABLE></body>";
}
?>