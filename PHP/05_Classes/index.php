<?php

class StringUtilities {
  static function secondCase ($str) {
    $str = strtolower($str);

    if (strlen($str) > 1)
      $str[1] = strtoupper($str[1]);

    return $str;
  }
}

echo StringUtilities::secondCase("");

class Pajamas {
  private $owner, $fit, $color;

  function __construct($owner = "Jordan", $fit = "loose", $color = "green") {
    $this->owner = StringUtilities::secondCase($owner);
    $this->fit = $fit;
    $this->color = $color;
  }

  public function describe() {
    return "These $this->color pajamas are owned by $this->owner and fit $this->fit.\n";
  }

  public function setFit($new_fit) {
    $this->fit = $new_fit;
  }
}

$chicken_PJs = new Pajamas("CHICKEN","casual","blue");
echo $chicken_PJs->describe();

$chicken_PJs->setFit("tight");
echo $chicken_PJs->describe();

Class ButtonablePajamas extends Pajamas {
  private $button_state = "unbuttoned";

  public function describe() {
    echo Pajamas::describe() . "They're also $this->button_state.\n";
  }

  public function toggleButtons() {
    if ($this->button_state === "buttoned")
      $this->button_state = "unbuttoned";
    else
      $this->button_state = "buttoned";

  }
}

$moose_PJs = new ButtonablePajamas("moose");
echo $moose_PJs->describe();
$moose_PJs->toggleButtons();
echo $moose_PJs->describe();