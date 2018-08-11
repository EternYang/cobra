import React from 'react';
import Cookies from 'js-cookie';
import Top from '../top/index';
import Information from './M_component/information';
import Ewallet from './M_component/Ewallet';
import Satisfaction from './M_component/satisfaction';
import Rules from './M_component/rules/rules';
import {reqMember,reqwallet,requniwallet} from '../../api/requrl';
import './index.css';
import { Tabs } from 'antd';

const TabPane = Tabs.TabPane;
class Membership extends React.Component {
	state={
		memberdata:'',
		wallet:'',
		count:'',
		data:{
			page:1,
		},
		Key:"3",
	}
	componentWillMount(){
		let str=window.location.href;
		let Key=str.split("?")[1];
		this.setState({ Key })
	}
    async componentDidMount() {
    	const token = Cookies.get("Authorization")
		if(!token){
			this.props.history.push("/")
		}else{
			let req  = await reqMember(token),
			    count = req.data.count,
			    req2 = await reqwallet(token)
			let 	memberdata = req.data.results,
				    wallet = req2.data.results
			this.setState({
			memberdata,
			wallet,
			count
			})
		}
  	}
    
    async onChildChanged(data,count){
		this.setState({
		memberdata: data,
		count
		})
	}
    async onChildChanged2(data) {
    	const Token = Cookies.get("Authorization")
		if(!data.page) {
			data.page = 1
			data.page_size = 6
		}
		await this.setState({
			data: { ...this.state.data,
				...data
			}
		});
		const Data = this.state.data
		 for(let key in Data) {
		    if(Data[key]==='') {
		      delete Data[key]
		    }
		 }
		let req = await requniwallet(Data, Token)
		let wallet = req.data.results,
			count  = req.data.count,
			page   = data.page
			await this.setState({
			wallet,
			count,
			page
			})
	}
    
    render() {
	const 	{ wallet,memberdata,count,data,Key }=  this.state
	const page = data.page
	let memberData      = [],
		Wallet          = []
	if(memberdata && memberdata.length>0){
		    memberdata.map((item,index)=>(
 			memberData.push({  
		 	key: item.id,
			name:item.name ? item.name : 'null' ,
			Race:item.race,
			MembershipLevel: item.membership.name,
			registration_date:item.registration_date,
			last_purchase_date:item.last_purchase_date
		 	})
		 ))
	}
	if(wallet && wallet.length>0){
		  wallet.map((item,index)=>(
 			  Wallet.push({  
		 	  key: item.id,
			  MemberName: item.member.name,
			  TotalConsumption:item.total_consumption,
			  EWB: item.balance,
			  LTUD:item.lastest_top_up,
		 	})
		 ))
	}
    return (
         <div>
         	<Top/>
				<div className="membership">
					<h3>Membership</h3>
						<div>
						  <Tabs className="Tab" defaultActiveKey={Key} >
						    <TabPane tab="information" key="1" >
								<Information 
								name={memberData} 
								callbackParent={this.onChildChanged.bind(this)} 
								count={this.state.count}
								search={this.state.count}/>
						    </TabPane>
						    <TabPane tab="E-wallet" key="2">
								<Ewallet 
								name={Wallet} 
								callbackParent={this.onChildChanged2.bind(this)}
								count={count}
								page = {page}
								/>
						    </TabPane>
						    <TabPane tab="Satisfaction" key="3" className="tab2">
						    	<Satisfaction />
						    </TabPane>
						    <TabPane tab="Rules" key="4">
						    <Rules/>
						    </TabPane>
						  </Tabs>
					   
					</div>
				</div>
    	  </div>
    );
  }
}

export default Membership;