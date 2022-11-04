<?php
  
function pee() {
	global $location, $needs_to_pee;
  
  if ($needs_to_pee) {
    if ($location === "bathroom" || $location === "woods") {
      echo "You relieve yourself.\n";
      $needs_to_pee = false;
    }
    else
      echo "This is not the place to piss!\n";
  }
  else
    echo "No juice in the tank.\n";
}