import React from 'react';
import Cookies from 'js-cookie';
import { Form, Icon, Input, Button } from 'antd';
import {reqLogin} from '../api/requrl'
import './index.css'
const FormItem = Form.Item;

class LoginForm extends React.Component {
  
  handleSubmit = (e) => {
    e.preventDefault();
    this.props.form.validateFields((err, values) => {
      if (!err) {
        return;
      }
    });
  }
  constructor(props){
  	super(props);
  	this.state = {
  		username:'',
  		password :'',
  		loginmessage:'',
  		message:''
  	}
  }
	
	handle=()=>{  
	
	const password=this.state.password.trim()
	const username=this.state.username.trim()
	const user={username,
							password}
		if(!username){
			return 
		}else if(!password){
			return 
		}else{
			reqLogin(user)
					.then(res=>{
						const Token = 'Token ' + res.data.token,
						username =  user.username
 						Cookies.set('Authorization', Token)
 						Cookies.set('user', username)
 					  this.props.history.push("/Product")
 					})
 					.catch(err=>{this.setState({
 						message:'username or passsage was wrong'
 						})})
				}
 	 	
  }
  inputchange=(e)=>{
  	let inputvalue = e.target.value,
  	     inputname = e.target.name;
  	     this.setState({
			  		[inputname] : inputvalue,
			  		message:''
			  	})
  }
  render() {
    const { getFieldDecorator } = this.props.form;
    return (
     <div className="LoginView container">
      <p>Welcome back, admin</p>
      <Form
        onSubmit={this.handleSubmit}
        className="login-form"
        >
        <FormItem>
          {getFieldDecorator('username', {
              rules: [
                {
                  required: true,
                  message: 'Please input your username!'
                }
              ]
            })(<Input
              prefix={
                <Icon type = "user"
                style = {{ color: 'rgba(0,0,0,.25)' }}
            />}
            placeholder="Username"
              name="username"
              autoComplete="off"
              onChange={e => this.inputchange(e)}
            />)}
        </FormItem>
        
				
        <FormItem className="passwordinput">
          {getFieldDecorator('password', {
              rules: [
                {
                  required: true,
                  message: 'Please input your Password!'
                }
              ]
            })(<Input
              prefix={
                <Icon type = "lock"
                style = {{ color: 'rgba(0,0,0,.25)' }}
              />}
                type="password"
                placeholder="Password"
                className="passwordinput"
                name="password"
                autoComplete="off"
                onChange={e => this.inputchange(e)}
              />)}
          <Button
          	className="button"
          	onClick={this.handle}
            type="primary"
            htmlType="submit"
            >
           <span className="fa fa-arrow-circle-right"></span>
         </Button >
     		<h3>{this.state.message}</h3>
        </FormItem>
      </Form>
    </div>
    );
  }
}

const WrappedHorizontalLoginForm = Form.create()(LoginForm);
export default WrappedHorizontalLoginForm;

