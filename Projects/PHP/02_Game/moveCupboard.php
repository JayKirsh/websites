<?php
  
function moveCupboard(){
  global $is_hungry, $wearing_contacts, $wearing_glasses, $needs_to_pee, $location, $moved_cupboard;

  $ready_to_work = !$is_hungry && $wearing_contacts && !$wearing_glasses && !$needs_to_pee;

  if ($location === "kitchen") {
    if (!$moved_cupboard) {
      if ($ready_to_work) {
        echo "You move the cupboard aside. You have revealed a safe crudely fit into the wall behind where the cupboard used to be.\n";
        $moved_cupboard = true;
      }
      else 
        echo "You're not ready to work! You need to be properly fed, have an empty bladder, and have corrected vision (without dealing with those pesky glasses). Without these things, there's no point in even trying to move the cupboard.\n";
    }
    else
      echo "You've already moved the cupboard!\n";
  }
  else
    echo "You don't see a cupboard here!\n";
}