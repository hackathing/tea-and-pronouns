import deepFreeze from 'deep-freeze';
import auth, { LOGIN, REGISTER } from '.';
import {
  selectRegister,
  selectLogin,
  setField,
} from '../actions';

const defaultState = deepFreeze({
  mode: LOGIN,
  email: { value: '', errors: [] },
  password1: { value: '', errors: [] },
  password2: { value: '', errors: [] },
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
    const state = deepFreeze({ ...defaultState, mode: REGISTER });
    const newState = auth(defaultState, action);
    expect(newState.mode).to.equal(LOGIN);
  });

  describe('setField action handling', () => {
    it('updates email value', () => {
      const action = setField('email', 'hello');
      const state = defaultState;
      const newState = auth(defaultState, action);
      expect(newState.email).to.deep.equal({
        value: 'hello',
        errors: [],
      });
    });

    it('updates password1 value', () => {
      const action = setField('password1', 'hunter1');
      const state = defaultState;
      const newState = auth(defaultState, action);
      expect(newState.password1).to.deep.equal({
        value: 'hunter1',
        errors: [],
      });
    });

    it('updates password2 value', () => {
      const action = setField('password2', '*******');
      const state = defaultState;
      const newState = auth(defaultState, action);
      expect(newState.password2).to.deep.equal({
        value: '*******',
        errors: [],
      });
    });
  });
});
