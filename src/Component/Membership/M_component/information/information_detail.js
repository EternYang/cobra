import React 						from 'react';
import Cookies					    from 'js-cookie';
import Top                          from '../../../top/index';
import Nav 							from '../../../nav/index';
import Center 						from './inf_detail_center';
import { reqmember,reqtransaction } from '../../../../api/requrl';

class InformationDetail extends React.Component {
    state = {
		member:[],
		classicmembership:'',
		transaction:'',
		navdata: '',
		productdata: '',
		count: '',
		page: 1,
		data:{
      	min_transact_datetime:'',
      	max_transact_datetime:'',
      	search:'',
      	category_name:'',
      	page:1,
      	page_size:6
        }
	}
	async componentDidMount() {
		const Token = Cookies.get("Authorization")  
		if(!Token){
		  window.location.href='/login'
		}else{
			let str=window.location.href;
			let id=str.split("?")[1];
			let data = {transaction__membe:id}
			let req         = await reqmember(id,Token)
			let req2        = await reqtransaction(data,Token)
			let member      = req.data
			let transaction = req2.data.results,
			    count       = req2.data.count
			const classicmembership = member.membership.name
			this.setState({
			member:member,
			classicmembership,
			transaction,
			count
			})
		}
		
	}
	async onChildChanged(data) {
		const Token = Cookies.get("Authorization")
		if(!data.page) {
			data.page = 1
		}
		let Data = this.state.data
		Data = {...Data,...data}
		for(let key in Data) {
		    if(Data[key].length===0) {
		      delete Data[key]
		    }
		 }
		let req = await reqtransaction(Data, Token)
		let transaction = req.data.results,
			count = req.data.count,
			Page = data.page
		    this.setState({
				transaction,
				count: count,
				page: Page,
				data:Data
			})
	}
	render() {
		const {productdata,count,page,member,classicmembership,transaction} = this.state
		return(
			<div className='Ind'>
	    		<Top />
	    		<Nav callbackParent={this.onChildChanged.bind(this)}/>
	    		<Center callbackParent={this.onChildChanged.bind(this)}  
	    		data={productdata} 
	    		count={count}
	    		page={page}
	    		member={member}
	    		classicmembership={classicmembership}
	    		transaction={transaction}
	    		/>
    	  </div>
		);
	}
}
export default InformationDetail;