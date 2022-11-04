<?php
  $drinks = array("hot chocolate" => 1.00, "coffee" => 1.50, "gatorade" => 1.25);
  $pastries = ["doughnut", "muffin", "bagel"];
?>

<h1>Welcome to the Repetitive Cafe</h1>

<h3>Drinks!</h3>
<ul>
  <?php foreach($drinks as $drink=>$price):?>
    <?php $two_dec = number_format((float)$price, 2, '.', ''); ?>
    <li><?="${drink}: $${two_dec}"?></li>
  <?php endforeach;?>
</ul>

<h3>Pastries! ($2 each)</h3>
<ul>
  <?php 
    for($i = 0; $i < count($pastries); $i++):?>
    <li><?=$pastries[$i]?></li>
  <?php endfor;?>
</ul>