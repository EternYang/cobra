import { combineReducers } from 'redux'
import {
	AUTH_SUCCESS,
	ERROR_MSG
} from './action-types'

const initUser = {
	username:'',
	msg:''
}
 
function user(state=initUser,action){
	switch(action.type){
		case AUTH_SUCCESS:
		return{ ...action.data}
		case ERROR_MSG:
		return {...state,msg:action.data}
		default:
		return state
	}
}


//function  xxx (state=0,action){
//	return state
//}
//function  yyy (state=0,action){
//	return state
//}


export default combineReducers({
//	xxx,
//	yyy,
	user
})
