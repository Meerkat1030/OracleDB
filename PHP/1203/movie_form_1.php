<html>
<head>
<title>Searching Movie Table</title>
</head>
<body>
	<h2>Searching Movie Table</h2>
	<br>
	<form method="post" action="p_movie.php">
		Title : <input type="text" size="20" maxlength="50" name="title" value="star wars"><br> 
		Year : <input type="text" size="4" maxlength="4" name="year" value="1900">- <input type="text" size="4" maxlength="4" name="year2" value="2018"><br> <br> 
		Length : <input	type="text" size="3" maxlength="3" name="length" value="100"><br> <br>
		InColor : Color <input type="radio" name="color" value="t"> 
				  B&W <input type="radio" name="color" value="f"><br> <br> 
		[정렬 기준]<br> <br> 
		<select name="sort" size=4>
    		<option value="t">Title</option>
    		<option value="y">YEAR</option>
    		<option value="l">LENGTH</option>
    		<option value="s">STUDIONAME</option>
		</select><br><br> 
		<input type="submit" value="submit" name="submit"> <br> 
		<input type="reset" value="reset" name="reset">
	</form>