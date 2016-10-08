export const SELECT_REGISTER = 'AUTH_SELECT_REGISTER';
export const SELECT_LOGIN = 'AUTH_SELECT_LOGIN';
export const SET_FIELD = 'AUTH_SET_FIELD';
export const SUBMIT = 'AUTH_SUBMIT';

export function selectRegister() {
  return {
    type: SELECT_REGISTER,
  };
}

export function selectLogin() {
  return {
    type: SELECT_LOGIN,
  };
}

export function setField(fieldName, value) {
  return {
    type: SET_FIELD,
    fieldName,
    value,
  };
}

export function submit() {
  return {
    type: SUBMIT,
  };
}
