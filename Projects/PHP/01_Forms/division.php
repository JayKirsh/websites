<html>
<body>
	<?php print_r($_GET);?>
	<br>
	<?php 
		$numer = $_GET['div_first'];
		$denom = $_GET['div_second'];
		$quotient = $numer / $denom;

		echo "${numer} / ${denom} = ${quotient}";
	?>
	<br>

	<a href="index.php">Reset</a>
</body>
</html>