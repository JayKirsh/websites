

// Foursquare API Info
const foursquareKey = 'fsq3x0vZ3T7I3YkSHfaxahd9Y6YYOzMLZbsrQHZHnXizbWc=';
const url = 'https://api.foursquare.com/v3/places/search?near=';

// OpenWeather Info
const openWeatherKey = 'd1933378730c98970a1570f454fb7879';
const weatherUrl = 'https://api.openweathermap.org/data/2.5/weather';

// Page Elements
const $input = $('#city');
const $submit = $('#button');
const $destination = $('#destination');
const $container = $('.container');
const $placeDivs = [$("#place1"), $("#place2"), $("#place3"), $("#place4")];
const $weatherDiv = $("#weather1");
const weekDays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

const options = {
  method: 'GET',
  headers: {
    Accept: 'application/json',
    Authorization: foursquareKey
  }
};

// Add AJAX functions here:
const getPlaces = async () => {
  const city = $input.val();
  const urlToFetch = `${url}${city}&limit=5`;
  try { 
    const response = await fetch(urlToFetch, options);
    if (response.ok) {
      const jsonResponse = await response.json();
      const places = jsonResponse.results;
      console.log(places);
      return places;
    }
  } catch (error) {
    console.log(error);
  }
};

const getForecast = async () => {
  const urlToFetch = `${weatherUrl}?q=${$input.val()}&APPID=${openWeatherKey}`;
  try {
    const response = await fetch(urlToFetch);
    if (response.ok) {
      const jsonResponse = await response.json();
      console.log(jsonResponse);
      return jsonResponse;
    }
  } catch (error) {
    console.log(error);
  }
};


// Render functions
const renderPlaces = (places) => {
  $placeDivs.forEach(($place, index) => {
    // Add your code here:
    const place = places[index];
    const placeIcon = place.categories[0].icon;
    const placeImgSrc = `${placeIcon.prefix}bg_64${placeIcon.suffix}`;
    const placeContent = createPlaceHTML(place.name, place.location, placeImgSrc);
    $place.append(placeContent);
  });
  $destination.append(`<h2>${places[0].location.locality}</h2>`);
};

const renderForecast = (forecast) => {
  const weatherContent = createWeatherHTML(forecast);
  $weatherDiv.append(weatherContent);
};

const executeSearch = () => {
  $placeDivs.forEach(place => place.empty());
  $weatherDiv.empty();
  $destination.empty();
  $container.css("visibility", "visible");
  getPlaces().then(places => renderPlaces(places));
  getForecast().then(forecast => renderForecast(forecast));
  return false;
}

$submit.click(executeSearch);