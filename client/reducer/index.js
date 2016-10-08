import { combineReducers } from 'redux';


import auth from '../auth/reducer';
import human from '../human/reducer';

export default combineReducers({
  auth,
  human,
});
