<?php
  
function cookSoup(){
	global $location, $has_mushrooms, $has_soup;
  
  if ($location === "kitchen" && $has_mushrooms) {
    echo "You made some mushroom soup.\n";
    $has_mushrooms = false;
    $has_soup = true;
  }
  else
    echo "You can't cook like this! You need something to cook AND to be in the kitchen.\n";
}