import React from 'react';
import Cookies from 'cookies-js';
import {reqMember} from '../api/requrl'
class tool{
	ifcookies=()=>{
		const Token = Cookies.get('Authorization')
		if(!cookies){
			this.props.history.push("/")
		}else{
		 return	reqMember(Token)
		}
	}
}
export default tool;