import {
  SELECT_REGISTER,
  SELECT_LOGIN,
  SET_FIELD,
  SUBMIT,
} from '../actions';

export const LOGIN = 'LOGIN';
export const REGISTER = 'REGISTER';

const initialFieldState = { value: '', error: null };

const initialState = {
  mode: LOGIN,
  loading: false,
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

function validateEmail({ value, error }) {
  return {
    error: value.match(/.+@.+/) ? '' : "Doesn't look like an email",
    value,
  }
}

function validatePassword1({ value, error }) {
  return {
    error: value.length > 7 ? '' : "Too short",
    value,
  }
}

function validatePassword2({ value, error }, password2) {
  return {
    error: value === password2.value ? '' : "Doesn't match password",
    value,
  }
}

function submit(state) {
  if (state.loading) { return state; }
  if (state.mode === LOGIN) {
    return {
      ...state,
      email: validateEmail(state.email),
      password1: validatePassword1(state.password1),
    };
  }
  if (state.mode === REGISTER) {
    return {
      ...state,
      email: validateEmail(state.email),
      password1: validatePassword1(state.password1),
      password2: validatePassword2(state.password1, state.password2),
    };
  }
}

export default function auth(state = initialState, action = {}) {
  switch (action.type) {

    case SELECT_REGISTER:
      return { ...state, mode: REGISTER };

    case SELECT_LOGIN:
      return { ...state, mode: LOGIN };

    case SET_FIELD:
      return updateField(action.fieldName, action.value, state);

    case SUBMIT:
      return submit(state);

    default:
      return state
  }
}
