const fs = require('fs');
const http = require('http');

const server = http.createServer((request, response) => {
  const url = new URL(request.url, `http://${request.headers.host}`);

  switch (url.pathname) {
    case '/':
      if (request.method === 'GET') {
        const name = url.searchParams.get('name');
        console.log(name);
        response.writeHead(200, {'Content-Type':'text/html'});
        fs.createReadStream('index.html').pipe(response);
      }
      else if (request.method === 'POST') {
        handlePostResponse(request, response);
      }
      break;
    default:
      response.writeHead(404, {'Content-Type':'text/html'});
      fs.createReadStream('index.html').pipe(response);
      break;
  }
});

server.listen('4001', () => {
    console.log(server.address().port);
  });

// Function for handling POST responses
function handlePostResponse(request, response){
  request.setEncoding('utf8');
  
  // Receive chunks on 'data' event and concatenate to body variable
  let body = '';
  request.on('data', function (chunk) {
    body += chunk;
  });
  
  // When done receiving data, select a random choice for server
  // Compare server choice with player's choice and send an appropriate message back
  request.on('end', function () {
    const choices = ['rock', 'paper', 'scissors'];
    const randomChoice = choices[Math.floor(Math.random() * 3)];

    const choice = body;

    let message;

    const tied = `Aww, we tied! I also chose ${randomChoice}.`;
    const victory = `Dang it, you won! I chose ${randomChoice}.`;
    const defeat = `Ha! You lost. I chose ${randomChoice}.`;

    if (choice === randomChoice) {
      message = tied;
    } else if (
        (choice === 'rock' && randomChoice === 'paper') ||
        (choice === 'paper' && randomChoice === 'scissors') ||
        (choice === 'scissors' && randomChoice === 'rock')
    ) {
      message = defeat;
    } else {
      message = victory;
    }
    response.writeHead(200, { 'Content-Type': 'text/plain' });
    response.end(`You selected ${choice}. ${message}`);
  });
}