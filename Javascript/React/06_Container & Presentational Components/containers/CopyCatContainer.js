import React from 'react';
import ReactDOM from 'react-dom';
import {CopyCat} from '../components/CopyCat';

const images = {
  copycat: 'https://content.codecademy.com/courses/React/react_photo_copycat.png',
  quietcat: 'https://content.codecademy.com/courses/React/react_photo_quietcat.png'
};


class CopyCatContainer extends React.Component {
    constructor(props) {
    super(props);

    this.state = { 
      copying: true,
      input: 'test',
    };

    this.toggleTape = this.toggleTape.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  toggleTape() {
    this.setState({copying: !this.state.copying});
  }

  handleChange(e) {
    this.setState({input: e.target.value});
  }

  
  
  render() {
    const copying = this.state.copying;
    const input = this.state.input;
    const toggleTape = this.toggleTape;
    const handleChange = this.handleChange;
    
    return <CopyCat copying={copying} input={input} toggleTape={toggleTape} handleChange={handleChange} />
  };
}


ReactDOM.render(<CopyCatContainer />, document.getElementById('app'));