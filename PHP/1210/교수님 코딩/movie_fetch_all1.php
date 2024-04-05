<?php
function error_mesg (array $e, $mess) {
    return "{$e['message']}<br><b><font color=red>$mess</font></b>";
}

$conn = oci_connect("scott","tiger", "localhost/course");
if (!$conn) {
	$e = oci_error();
        exit(error_mesg($e, "Connection Failed ..."));
}

$stmt = oci_parse($conn,"select * from movie ");
oci_execute($stmt);

$nrows = oci_fetch_all($stmt, $results);
if($nrows > 0) {
	print "<TABLE bgcolor=#abbebabc border=1>\n";
	print "<TR bgcolor=#fbfebaec align=center>";
        
	foreach ($results as $key => $val) {
		print "<TH>$key</th>\n";
	}
        
	print "</TR>\n";

	for($i = 0; $i < $nrows; $i++) {
		print "<TR>\n";
		foreach ($results as $data) {
			print "<TD> $data[$i]\n";
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
