import {
	AUTH_SUCCESS,
	ERROR_MSG
} from './action-types'
import{
	reqLogin
} from '../api/requrl'

const authSuccess = (user)=>({type:AUTH_SUCCESS,data:user})
const errorMsg    = (msg) =>({type:ERROR_MSG,data:msg})

export const login = (user) => {
	const {username,password} = user
	if(!username){
		return errorMsg('用户名不能为空')
	}else if(!password){
		return errorMsg('密码不能为空')
	}
	return async dispatch => {
		const response = await reqLogin(user)
		const result = response.data
		if(result.stata===200){
			dispatch(authSuccess(result.data))
		}else{
			dispatch(ERROR_MSG(result.msg))
		}
	}
}
