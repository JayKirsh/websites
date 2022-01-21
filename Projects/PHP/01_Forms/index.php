<html>
<body>
  <h1>My Calculator</h1>
  <h3>Addition</h3>
	<form action="addition.php" method="get">
		First Number: <input type="number" name="add_first"><br>
		Second Number: <input type="number" name="add_second"><br>
		<button type="submit">Add</button><br>
	</form>

	<h3>Division</h3>
	<form action="division.php" method="get" name="div">
		Numerator: <input type="number" name="div_first"><br>
		Denominator: <input type="number" name="div_second"><br>
		<button type="submit">Division</button><br>
	</form>
	<a href="index.php">Reset</a>
</body>
</html>