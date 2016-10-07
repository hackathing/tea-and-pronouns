import { combineReducers } from 'redux';

const initialState = {};

function empty(state = initialState, action) {
  switch (action.type) {
    default:
      return state
  }
  return state
}

export default combineReducers({
  empty,
});
