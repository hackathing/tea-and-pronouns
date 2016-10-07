import deepFreeze from 'deep-freeze';
import auth, { LOGIN, REGISTER } from '.';
import {
  selectRegister,
  selectLogin,
} from '../actions';

const defaultState = deepFreeze({
  mode: LOGIN,
  email: '',
  password1: '',
  password2: '',
});

describe('auth reducer', () => {
  it('has default state', () => {
    const state = auth(undefined, {});
    expect(state).to.deep.equal(defaultState);
  });

  it('selectRegister sets mode to register', () => {
    const action = selectRegister();
    const state = defaultState;
    expect(state.mode).to.equal(LOGIN);
    const newState = auth(defaultState, action);
    expect(newState.mode).to.equal(REGISTER);
  });

  it('selectLogin set mode to login', () => {
    const action = selectLogin();
    const state = { ...defaultState, mode: REGISTER };
    const newState = auth(defaultState, action);
    expect(newState.mode).to.equal(LOGIN);
  });
});
