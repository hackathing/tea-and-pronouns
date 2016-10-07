export const SELECT_REGISTER = 'SELECT_REGISTER';
export const SELECT_LOGIN = 'SELECT_LOGIN';

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
