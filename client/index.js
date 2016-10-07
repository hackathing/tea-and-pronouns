import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore } from 'redux';
import reducer from './reducer';

import 'reset-css';
import './styles.css';

const store = createStore(reducer);

function ConnectedApp() {
  return (
    <Provider store={store}>
      <h1>Tea & Pronouns!</h1>
    </Provider>
  );
};

const element = document.querySelector('.js-app');
ReactDOM.render(<ConnectedApp />, element);
