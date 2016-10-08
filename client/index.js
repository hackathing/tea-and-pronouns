import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore } from 'redux';
import reducer from './reducer';

import 'reset-css';
import './styles.css';
import {AppContainer} from './App';

const store = createStore(reducer);

function ConnectedApp() {
  return (
    <Provider store={store}>
      <div className="page-wrapper">
		<AppContainer />
      </div>
    </Provider>
  );
};

const element = document.querySelector('.js-app');
ReactDOM.render(<ConnectedApp />, element);
