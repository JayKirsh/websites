const Stack = require('./Stack.js');
const prompt = require('prompt-sync')();
// ------------------------------
// Initialization
// ------------------------------

const backPages = new Stack();
const nextPages = new Stack();

let currentPage = 'Start Page';
let finish = false;
let showBack = false;
let showNext = false;

// ------------------------------
// Helper Functions
// ------------------------------

showCurrentPage = action => {
  console.log(`\n${action}`);
  console.log(`CurrentPage = ${currentPage}`);
  console.log(`Back page = ${backPages.peek()}`);
  console.log(`Next page = ${nextPages.peek()}`);
}

newPage = page => {
  backPages.push(currentPage);
  currentPage = page;

  while (!nextPages.isEmpty()) {
    nextPages.pop();
  }

  showCurrentPage("NEW: ");
}

backPage = () => {
  nextPages.push(currentPage);
  currentPage = backPages.pop();
  showCurrentPage("BACK: ");
}

nextPage = () => {
  backPages.push(currentPage);
  currentPage = nextPages.pop();
  showCurrentPage("NEXT: ");
}

/*
 * The following strings are used to prompt the user
 */
const baseInfo = '\nEnter a url';
const backInfo = 'B|b for back page';
const nextInfo = 'N|n for next page';
const quitInfo = 'Q|q for quit';
const question = 'Where would you like to go today? '

// ------------------------------
// User Interface Part 1
// ------------------------------

showCurrentPage('DEFAULT: ');

while (!finish) {
  let instructions = baseInfo;

  if (!backPages.isEmpty()) {
    instructions += `, ${backInfo}`;
    showBack = true;
  }
  else {
    showBack = false;
  }

  if (!nextPages.isEmpty()) {
    instructions += `, ${nextInfo}`;
    showNext = true;
  }
  else {
    showNext = false;
  }

  instructions += `, ${quitInfo}.`;
  
  console.log(instructions);

  // ------------------------------
  // User Interface Part 2
  // ------------------------------

  const answer = prompt(question);
  const lowerCaseAnswer = answer.toLowerCase();

  switch(lowerCaseAnswer) {
    case 'b':
      if (showBack)
        backPage();
      else
        console.log('\nBack stack is empty jack!');
      break;
    case 'n':
      if (showNext)
        nextPage();
      else
        console.log('\nNo next = new nemesis!');
      break;
    case 'q':
      finish = true;
      break;
    default:
      newPage(answer);
      break;
  }
}
