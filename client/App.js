import React from 'react';
import ReactDOM from 'react-dom';

import {connect} from 'react-redux';
import {setName} from './human/actions';

export default function App(props) {
	function onSubmit(event) {
		event.preventDefault();
		for (let input of event.target) {

			if (input.name === 'person-name') {
				props.setName(input.value)
			}
		}
	}
	return (
			<div className="full-page-form">
				<h1>Hello {props.name}</h1>
				<h2>What would you like us to call you?</h2>
				<form id="first-name" onSubmit={onSubmit}>
					<input type="text" name="person-name"></input>
					<input type="submit" id="submit" value="Go!" className="visually-hidden"></input>
					<label htmlFor="submit">enter</label>
				</form>
			</div>
	)
};



function mapStateProps (state) {
	return { name: state.human.name };
};

const mapDispatchToProps = {
	setName : setName,
}
export const AppContainer = connect(mapStateProps, mapDispatchToProps)(App);



