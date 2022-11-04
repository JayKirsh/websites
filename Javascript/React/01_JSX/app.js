import { animals } from './animals';
import React from 'react';
import ReactDOM from 'react-dom';

const showBackground = true;

function displayFact(e) {
  const name = e.target.alt;
  const animalFacts = animals[name].facts
  const optionIndex = Math.floor(Math.random() * animalFacts.length);
  const funFact = animalFacts[optionIndex];
  document.getElementById('fact').innerHTML = funFact;
}

const title = '';
const background = (
  <img 
    className='background' 
    alt='ocean' 
    src='./pics/ocean.jpg' 
  />
);

const images = [];
for (const animal in animals) {
  images.push(
    <img 
      key={animal}
      className='animal'
      alt={animal}
      src={animals[animal].image}
      aria-label={animal}
      role='button'
      onClick={displayFact}
    />
  );
}

const animalFacts = (
  <div>
    <h1>{title ? title : 'Click an animal for a fun fact'}</h1>
    {showBackground && background}
    <div className='animals'>
      {images}
    </div>
    <p id='fact'></p>
  </div>
);

ReactDOM.render(
  animalFacts,
  document.getElementById('root')
);