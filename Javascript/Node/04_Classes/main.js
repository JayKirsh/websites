const prompt = require('prompt-sync')({sigint: true});

const hat = '^';
const hole = 'O';
const fieldCharacter = '░';
const pathCharacter = '*';

class Field {
  constructor(field, x = 0, y = 0) {
    this.field = field;
    this.x = x;
    this.y = y;
  }

  print(){
    for (const row of this.field) {
      let str = '';
      for (const cell of row)
        str += cell;
      console.log(str);
      }
    }
  static generateField(width, height, percentage) {
    function getRandomInt(max) {
      return Math.floor(Math.random() * max);
    }

    const field = [];

    for (let i = 0; i < height; i++) {
      const row = [];
      for (let j = 0; j < width; j++) {
        row.push(getRandomInt(100) < percentage ? 'O' : '░');
      }
      field.push(row);
    }

    const startX = getRandomInt(width);
    const startY = getRandomInt(height);

    let endX = 0;
    let endY = 0;

    do {
      endX = getRandomInt(width);
      endY = getRandomInt(height);
    } while (startX === endX && startY === endY)

    field[startY][startX] = '*';
    field[endY][endX] = '^';

    return [field, startX, startY];
  }
}

const field = Field.generateField(20,10,25);

const myField = new Field(field[0], field[1], field[2]);

let running = true;

while (running) {
  myField.print();
  
  let input = prompt('Enter an input! ');

  const prevX = myField.x;
  const prevY = myField.y;

  switch (input) {
    case 'u':
      myField.y -= 1;
      break;
    case 'r':
      myField.x += 1;
      break;
    case 'd':
      myField.y += 1;
      break;
    case 'l':
      myField.x -= 1;
      break;
    default:
      console.log('Invalid input.\n');
      continue;
    }

    if (myField.x < 0) {
      console.log('Out of bounds left!');
      myField.x += 1;
      continue;
    }
    else if (myField.x >= myField.field[0].length) {
      console.log('Out of bounds right!');
      myField.x -= 1;
      continue;
    }
    else if (myField.y < 0) {
      console.log('Out of bounds down!');
      myField.y += 1;
      continue;
    }
    else if (myField.y >= myField.field.length) {
      console.log('Out of bounds up!');
      myField.y -= 1;
      continue;
    }
    
    const destination = myField.field[myField.y][myField.x];

    switch (destination) {
      case '^':
        console.log('You win :)');
        running = false;
        break;
      case 'O':
        console.log('You lose :(');
        running = false;
        break;
      case '░':
        myField.field[prevY][prevX] = '░';
        myField.field[myField.y][myField.x] = '*';
        break;
      default:
        console.log('Big error.');
    }
}