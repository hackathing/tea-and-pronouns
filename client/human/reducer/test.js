import deepFreeze from 'deep-freeze';
import human from '.';
import {
  setName,
} from '../actions';

const defaultState = deepFreeze({
  name: '',
});

describe('human reducer', () => {
  it('has default state', () => {
    const state = human(undefined, {});
    expect(state).to.deep.equal(defaultState);
  });

  it('setName updates name value', () => {
    const action = setName('hello');
    const newState = human(defaultState, action);
    expect(newState.name).to.equal('hello');
  });
});
