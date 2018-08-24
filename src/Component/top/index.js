import React                         from 'react';
import { Link }                      from 'react-router-dom';
import { Menu, Dropdown, Icon, Col } from 'antd';
import Cookies                       from 'js-cookie';
import './index.css';
class Top extends React.Component {
	  state={
	  	username:''
	  }
	  componentWillMount() {
	  	const Token = Cookies.get("Authorization")
			if(!Token) {
				window.location.href='/login'
		  }
	  }
		componentDidMount() {
		  const username = Cookies.get("user")
			this.setState({
				username
				})
  	}
    logOut=()=>{
  		Cookies.remove('Authorization')
  		Cookies.remove('user')
 			window.location.href='/login'
 		}
  
  	render() {
  	 	const menu = (
					  <Menu>
					    <Menu.Item key="0">
					      <p onClick={this.logOut}>Log out</p>
					    </Menu.Item>
					  </Menu>
					);
  	
	    return (
	         <div>
	         	<div className="top">
							<ul>
								<li className="CONBRA"><Col span={3}>COBRA CRM</Col></li>
								<li><Col span={3}><Link  to="/Product" >Product</Link></Col></li>
								<li><Col span={3}><Link  to="/WalletCoupon" >Voucher</Link></Col></li>
								<li><Col span={3}><Link  to="/Membership" >Membership</Link></Col></li>
								<li><Col span={3}><Link  to="/Campaign" >Campaign</Link></Col></li>
								<li>
									 <Dropdown overlay={menu} trigger={['click']}>
									    <a className="ant-dropdown-link" >
									    {this.state.username ? this.state.username : 'Administrators'}
									    <Icon type="down" />
									    </a>
									  </Dropdown>,
								</li>
							</ul>
	         	</div>
	    	 </div>
    );
  }
}

export default Top;