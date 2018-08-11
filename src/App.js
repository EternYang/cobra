import React, { Component }       from 'react';
import HomePage                   from './Component/homepage';
import Membership                 from './Component/Membership/Membership';
import Campaign                   from './Component/Campaign/Campaign';
import WrappedHorizontalLoginForm from './login/index';
import InformationDetail          from './Component/Membership/M_component/information/information_detail';
import WalletCoupon               from './Component/Membership/M_component/walletcoupon/walletcoupon';
import Performance                from './Component/Performance/Performance';
import {
  BrowserRouter as Router,
  Route,
  Switch,
  Redirect 
} from 'react-router-dom';

//import {  Button,Table } from 'antd';


class App extends Component {
  render() {
    return (
					<Router>
					    <div>	
					    <Switch>
					    	<Route  path="/login" component={WrappedHorizontalLoginForm}/>
					     	<Route  path="/Product" component={HomePage}/>
					     	<Route  path="/Membership" component={Membership}/>
					     	<Route  path="/Campaign" component={Campaign}/>
					     	<Route  path="/informationdetail" component={InformationDetail}/>
					     	<Route  path="/WalletCoupon" component={WalletCoupon}/>
					     	<Route  path="/Performance" component={Performance}/>
					     	<Redirect from="/" to="/login"></Redirect> 					     	 
					    </Switch>
					    </div>
					</Router>

    );
  }
}

export default App;
