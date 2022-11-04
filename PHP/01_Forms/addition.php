<html>
<body>
	<?php print_r($_GET);?>
	<br>
	<?php 
  		$first = $_GET['add_first'];
  		$second = $_GET['add_second'];
  		$sum = $first + $second;

		echo "${first} + ${second} = ${sum}";
	?>
	<br>

	<a href="index.php">Reset</a>
</body>
</html>