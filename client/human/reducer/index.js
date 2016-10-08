import {
  SET_NAME,
} from '../actions';

const initialState = {
  name: '',
};

export default function auth(state = initialState, action = {}) {
  switch (action.type) {

    case SET_NAME:
      return { ...state, name: action.name };

    default:
      return state
  }
}
