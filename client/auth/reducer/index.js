import {
  SELECT_REGISTER,
  SELECT_LOGIN,
  SET_FIELD,
} from '../actions';

export const LOGIN = 'LOGIN';
export const REGISTER = 'REGISTER';

const initialFieldState = { value: '', errors: [] };

const initialState = {
  mode: LOGIN,
  email: initialFieldState,
  password1: initialFieldState,
  password2: initialFieldState,
};

function updateField(fieldName, value, state) {
  return {
    ...state,
    [fieldName]: { ...state[fieldName], value }
  };
}

export default function auth(state = initialState, action = {}) {
  switch (action.type) {

    case SELECT_REGISTER:
      return { ...state, mode: REGISTER };

    case SELECT_LOGIN:
      return { ...state, mode: LOGIN };

    case SET_FIELD:
      return updateField(action.fieldName, action.value, state);

    default:
      return state
  }
  return state
}
