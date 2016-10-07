import {
  SELECT_REGISTER,
  SELECT_LOGIN,
} from '../actions';

export const LOGIN = 'LOGIN';
export const REGISTER = 'REGISTER';

const initialState = {
  mode: LOGIN,
  email: '',
  password1: '',
  password2: '',
};

export default function auth(state = initialState, action = {}) {
  switch (action.type) {

    case SELECT_REGISTER:
      return { ...state, mode: REGISTER };

    case SELECT_LOGIN:
      return { ...state, mode: LOGIN };

    default:
      return state
  }
  return state
}
