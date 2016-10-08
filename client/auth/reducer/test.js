import deepFreeze from 'deep-freeze';
import auth, { LOGIN, REGISTER } from '.';
import {
  selectRegister,
  selectLogin,
  setField,
  submit,
} from '../actions';

const defaultState = deepFreeze({
  mode: LOGIN,
  loading: false,
  email: { value: '', error: null },
  password1: { value: '', error: null },
  password2: { value: '', error: null },
});

describe('auth reducer', () => {
  it('has default state', () => {
    const state = auth(undefined, {});
    expect(state).to.deep.equal(defaultState);
  });

  it('selectRegister sets mode to register', () => {
    const action = selectRegister();
    expect(defaultState.mode).to.equal(LOGIN);
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
      const newState = auth(defaultState, action);
      expect(newState.email).to.deep.equal({
        value: 'hello',
        error: null,
      });
    });

    it('updates password1 value', () => {
      const action = setField('password1', 'hunter1');
      const newState = auth(defaultState, action);
      expect(newState.password1).to.deep.equal({
        value: 'hunter1',
        error: null,
      });
    });

    it('updates password2 value', () => {
      const action = setField('password2', '*******');
      const newState = auth(defaultState, action);
      expect(newState.password2).to.deep.equal({
        value: '*******',
        error: null,
      });
    });
  });

  describe('submit action handling', () => {
    const action = submit();

    it('noops if loading', () => {
      const state = { ...defaultState, loading: true };
      const newState = auth(state, action);
      expect(newState).to.deep.equal(state);
    });

    describe('LOGIN', () => {
      it('sets error if email invalid', () => {
        const state = {
          ...defaultState, email: { value: 'aaa', error: null },
        };
        const newState = auth(state, action);
        expect(newState.email).to.deep.equal({
          value: 'aaa', error: "Doesn't look like an email",
        });
      });

      it('sets error if password1 too short', () => {
        const state = {
          ...defaultState, password1: { value: '123', error: null },
        };
        const newState = auth(state, action);
        expect(newState.password1).to.deep.equal({
          value: '123', error: 'Too short',
        });
      });

      it('hits login endpoint if valid');
    });

    describe('REGISTER', () => {
      it('sets error if email invalid', () => {
        const state = {
          ...defaultState,
          mode: REGISTER,
          email: { value: 'aaa', error: null },
        };
        const newState = auth(state, action);
        expect(newState.email).to.deep.equal({
          value: 'aaa', error: "Doesn't look like an email",
        });
      });

      it('sets error if password1 too short', () => {
        const state = {
          ...defaultState,
          mode: REGISTER,
          password1: { value: '123', error: null },
        };
        const newState = auth(state, action);
        expect(newState.password1).to.deep.equal({
          value: '123', error: 'Too short',
        });
      });

      it('sets error if passwords do not match', () => {
        const state = {
          ...defaultState,
          mode: REGISTER,
          password1: { value: '123', error: null },
          password2: { value: '456', error: null },
        };
        const newState = auth(state, action);
        expect(newState.password2).to.deep.equal({
          value: '123', error: "Doesn't match password",
        });
      });


      it('hits register endpoint if valid');
    });
  });
});
