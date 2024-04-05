<?php
function table_head(array $th) {//배열이 넘어온다
    print "<head><link rel='stylesheet' href='table1.css'></head><body>";//같은 디렉토리에 잇는 table1.css파일을 사용해라
    print "<TABLE>";
    print "<thead>";
    if(count($th) > 0) {
        print "<TR align=center>";
        foreach($th as $k => $v) {
            print "<th> $v";//배열의 문자열을 th의 문자값으로 사용
        }
        print "</TR>\n";//<TR></TR>사이는 행이라는 의미
    }
    print "</thead><tbody>";
}

function table_tail() {
    print "</tbody>";
    print "</TABLE></body>";
}
?>