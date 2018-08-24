import React from 'react';
import { Table,Button,DatePicker,Drawer,message,Modal }  from 'antd';
import Cookies from 'js-cookie';
import { Link } from 'react-router-dom';
import { requnicampaignbyid,patchCampaign,deleteCampaign,requnimembership,requnioccupation,requnioutletName,
	     reqUnivoucher,reqUniproductname,requnicategory} from '../../api/requrl';
import './center.css';

const {RangePicker}=DatePicker
class CampaignCenter extends React.Component {
	state={
		visible: false ,
		unicampaign:{},
		Drawerdata:1,
		id:'',
		Archivedvisible:false,
		Modalmessage:'Are you sure to delete permanently?',
    	bottonname:'Archived',
    	bottonname2:'',
    	campaign_condition:{},
    	upgrade_membership:'',
    	membership:[],
    	occupation:[],
    	outlets:[],
    	univoucher:[],
    	productname:[],
    	category:[]
		
	}
	async reqmembership(item){
    	let {membership} = this.state
    	const Token      = Cookies.get("Authorization")
    	let req = await requnimembership(item,Token)
    	membership.push(req.data.name)
    	this.setState({membership})
    }
	async reqmembership2(item){
    	const Token      = Cookies.get("Authorization")
    	let req = await requnimembership(item,Token)
    	let upgrade_membership = req.data.name
    	this.setState({upgrade_membership})
    }
	async requnioccupation(item){
    	let {occupation} = this.state
    	const Token      = Cookies.get("Authorization")
    	let req = await requnioccupation(item,Token)
    	occupation.push(req.data.name)
    	this.setState({occupation})
    }
	async reqoutlets(item){
    	let {outlets} = this.state
    	const Token      = Cookies.get("Authorization")
    	let req = await requnioutletName(item,Token)
    	outlets.push(req.data.outlet_name)
    	this.setState({outlets})
    }
	async reqUnivoucher(item){
    	let {univoucher} = this.state
    	const Token      = Cookies.get("Authorization")
    	let req = await reqUnivoucher(item,Token)
    	univoucher.push(req.data.name)
    	this.setState({univoucher})
    }
	async reqUniproductname(item){
    	let {productname} = this.state
    	const Token      = Cookies.get("Authorization")
    	let req = await reqUniproductname(item,Token)
    	productname.push(req.data.name)
    	this.setState({productname})
    }
	async requnicategory(item){
    	let {category} = this.state
    	const Token      = Cookies.get("Authorization")
    	let req = await requnicategory(item,Token)
    	category.push(req.data.name)
    	this.setState({category})
    }
	async showDrawer (e) {
		this.setState({ visible: true,Drawerdata:1})
	    const Token         =  Cookies.get("Authorization")
		let req             =  await requnicampaignbyid(e.target.value,Token)
		let unicampaign     =  req.data
		let id              =  req.data.id
		let bottonname   = (unicampaign.state===4 ? 'Delete'   : 'Archived')
		let bottonname2  = (unicampaign.state===4 ? 'Recovery' : 'Edit')
		let Modalmessage = (unicampaign.state===4 ? `Are you sure to delete permanently?
			This data will disappear forever and can not be recovered.` : "This data will be moved to Archived." +  
			"You can recovery it in Archive.")
		if(unicampaign.memberships && unicampaign.memberships.length>0){
			unicampaign.memberships.map((item)=>(
				this.reqmembership(item)
			))
		}
		if(unicampaign.occupations && unicampaign.occupations.length>0){
			unicampaign.occupations.map((item)=>(
				this.requnioccupation(item)
			))
		}
		if(unicampaign.outlets && unicampaign.outlets.length>0){
			unicampaign.outlets.map((item)=>(
				this.reqoutlets(item)
			))
		}
		if(unicampaign.campaigntypes && unicampaign.campaigntypes.length>0 &&  unicampaign.campaigntypes[0].upgrade_membership ){
			this.reqmembership2(unicampaign.campaigntypes[0].upgrade_membership)
		}
		if(unicampaign.campaigntypes && unicampaign.campaigntypes.length>0 &&  unicampaign.campaigntypes[0].free_vouchers ){
			unicampaign.campaigntypes[0].free_vouchers.map((item)=>(
				this.reqUnivoucher(item)
			))
		}
		let campaign_condition  = {}
		if(unicampaign.campaigntypes && unicampaign.campaigntypes.length>0 &&  unicampaign.campaigntypes[0] && 
			unicampaign.campaigntypes[0].campaign_condition){
		    campaign_condition = unicampaign.campaigntypes[0].campaign_condition
		    if(campaign_condition.every_purchase_m_drinks_flavors.length>0 || campaign_condition.every_purchase_l_drinks_flavors.length>0 ){
				let data = []
				data = campaign_condition.every_purchase_m_drinks_flavors.length>0 ? campaign_condition.every_purchase_m_drinks_flavors :  
																					 campaign_condition.every_purchase_l_drinks_flavors
				data.map((item)=>(
				this.reqUniproductname(item)
				))
			}
		    if(campaign_condition.every_purchase_products.length>0){
				this.reqUniproductname(campaign_condition.every_purchase_products)
			}
		}
		
	    this.setState({
		      unicampaign,
		      id,
		      bottonname,
		      Modalmessage,
		      bottonname2,
		      campaign_condition
		    });
	};
	Archived = () => {
	    this.setState({
	    Archivedvisible   : true,
	  });
	}
	tochange=(item)=>{
 	  	if(item.state===0){
 	  		item.state='processing'
 	  	}else if(item.state===1){
 	  		item.state='waiting'
 	  	}else if(item.state===2){
 	  		item.state='launched'
 	  	}else if(item.state===3){
 	  		item.state='completed'
 	  	}else if(item.state===4){
 	  		item.state='archived'
 	  	}
 	  	if(item.type===0){
 	  		item.type='Product'
 	  	}else if(item.type===1){
 	  		item.type='Size upgrade'
 	  	}else if(item.type===2){
 	  		item.type='Cash'
 	  	}else if(item.type===3){
 	  		item.type='Discount'
 	  	}else if(item.type===4){
 	  		item.type='Buy one get one free'
 	  	}
	}
	onChange=(pagination, filters, sorter)=> {
		let type = '',
		    name = ''
	    if(pagination.current!==this.props.page){
		    let	data={page:pagination.current,page_size: 6}
		  	this.props.callbackParent(data);
	    }else{
		if(sorter && sorter.order==='descend'){
			type = '-'
		}
		if(sorter && sorter.order==='ascend'){
			type = ''
		}
		name = sorter.columnKey
		let ordering = type + name
		  let data = {
		  	ordering,
		  	pagesize:6
		  }
		this.props.callbackParent(data);
		}
	}
	async datechange(name1,name2,mode){
		let Data = { [name1]:mode[0],[name2]:mode[1] }
		this.props.callbackParent(Data);
	}
	Nextpage = () => {
		this.setState({ Drawerdata:2 })
	}
	PreviousPage = () => {
		this.setState({ Drawerdata:1 })
	}
	Edit = () => {
		let { unicampaign,id,outlets,occupation,membership,univoucher,productname,category,upgrade_membership } = this.state
		const Editdata = {outlets,occupation,membership,univoucher,productname,category,upgrade_membership  }
		if(unicampaign.state===4){
			const recovery = 'recovery'
			this.props.callbackParent2(unicampaign,id,Editdata,recovery);
		}else{
			this.props.callbackParent2(unicampaign,id,Editdata);
		}
		console.log(unicampaign,Editdata)
		this.onClose()
	}
	onClose = () => {
	  this.setState( {  
	  	visible: false,
	  	unicampaign:'',
	  	membership:[],
	  	occupation :[],
	  	outlets:[],
	  	campaign_condition:{},
	  	productname:[]
	  });
	}
	handleData= () => {
		
	}
	info = (text) => {
	  message.info(text);
	}
	async handleArchivedOk (e)  {
		let { id,unicampaign } = this.state
		let Token       =  Cookies.get("Authorization")
		if(unicampaign.state===4){
			try{
				await deleteCampaign(id,Token)
	    		this.info('success')
	    		this.setState({ id:'' })
	    	}catch(error){
	    		let message = error.response.status
				this.info(message)
				this.setState({ id:'' })
	    	}
		}else{
			try{
    		await patchCampaign({state:4,id},Token)
    		this.info('success')
    		this.setState({ id:'' })
	    	}catch(error){
	    		let message = error.response.status
				this.info(message)
				this.setState({ id:'' })
	    	}
		}
    	
    	this.setState({
        Archivedvisible   : false,
     	});
      	this.props.callbackParent({page:1});
  		this.onClose()
    }
	handleArchivedCancel = (e) => {
		this.setState({
    		Archivedvisible   : false,
     	});
    }
    render() {
     let  { campaigndata,count,page } =this.props
     let  { unicampaign,visible,Drawerdata,membership,occupation,outlets,upgrade_membership,univoucher,
      		productname,campaign_condition } =this.state
     const pagenation = {
  		   current:page,
  		   hideOnSinglePage:true,
  		   total:count,
  		   pageSize: 6,
  		}
  	 let data=[]
  	 let online_actions=[]
  	 let ordering_modes=[]
  	 let repetition_periods=[]
  	 if(campaigndata && campaigndata.length>0){
     	    campaigndata.map((item,index)=>{
     	  	this.tochange(item)
     	    return  data.push({
 	  		key: item.id,
			name:item.name,
			effective_date:item.effective_date,
			expiring_date: item.expiring_date,
			turnover:item.turnover,
			transactions_count:item.transactions_count,
			products_sold:item.products_sold,
			state:item.state,
			Action:(<Button value={item.id} onClick={this.showDrawer.bind(this)}>Details</Button>)
     	  	})
     	  })
     }
  	 let gender = []
  	 if(unicampaign.gender && unicampaign.gender.length>0){
  	 	unicampaign.gender.map((item)=>{
  	 		if(item===1){
  	 			gender.push('female')
  	 		}else if(item===0){
  	 			gender.push('male')
  	 		}
  	 		return gender
  	 	})
  	 }
  	 if(campaign_condition){
	  	 if(campaign_condition.online_actions && campaign_condition.online_actions.length>0){
	  	 	campaign_condition.online_actions.map((item,index)=>{
	  	 		if(item===0){
	  	 			online_actions.push(<p key={index}>● Like our facebook page itea.sg</p>)
	  	 		}else if(item===1){
	  	 			online_actions.push(<p key={index}>● Like our facebook post</p>)
	  	 		}else if(item===2){
	  	 			online_actions.push(<p key={index}>● Rate us on facebook</p>)
	  	 		}else if(item===3){
	  	 			online_actions.push(<p key={index}>● Post on our facebook page g</p>)
	  	 		}else if(item===4){
	  	 			online_actions.push(<p key={index}>● Share our facebook page/ post</p>)
	  	 		}else if(item===5){
	  	 			online_actions.push(<p key={index}>● Like our instagram</p>)
	  	 		}
	  	 		return online_actions
	  	 	})
	  	 }
	 }	 
  	 if(campaign_condition && campaign_condition.ordering_modes && campaign_condition.ordering_modes.length>0){
  	 	campaign_condition.ordering_modes.map((item,index)=>{
  	 		if(item===0){
  	 			ordering_modes.push('cash' )
  	 		}else if(item===1){
  	 			ordering_modes.push('apple pay')
  	 		}else if(item===2){
  	 			ordering_modes.push('andriod pay')
  	 		}else if(item===3){
  	 			ordering_modes.push('visa')
  	 		}else if(item===4){
  	 			ordering_modes.push('mastercard')
  	 		}else if(item===5){
  	 			ordering_modes.push('ezylink')
  	 		}else if(item===6){
  	 			ordering_modes.push('QR code')
  	 		}else if(item===7){
  	 			ordering_modes.push('favepay')
  	 		}else if(item===8){
  	 			ordering_modes.push('grabpay')
  	 		}else if(item===9){
  	 			ordering_modes.push('Alipay')
  	 		}else if(item===10){
  	 			ordering_modes.push('Internet Banking')
  	 		}
  	 		return ordering_modes
  	 	})
  	 }
  	 let payment_modes = []
  	 if(campaign_condition && campaign_condition.payment_modes && campaign_condition.payment_modes.length>0){
  	 	campaign_condition.payment_modes.map((item,index)=>{
  	 		if(item===0){
  	 			payment_modes.push('Walk-in')
  	 		}else if(item===1){
  	 			payment_modes.push('Mobile ordering')
  	 		}
  	 		return payment_modes
  	 	})
  	 }
  	 let days_of_month = []
  	 if(unicampaign.days_of_month && unicampaign.days_of_month.length>0){
  	 	days_of_month = unicampaign.days_of_month
  	 }
  	 if(unicampaign.repetition_periods && unicampaign.repetition_periods.length>0){
  	 	unicampaign.repetition_periods.map((item,index)=>{
  	 		if(item===0){
  	 			return repetition_periods.push(<span key={index}>Daily </span>)
  	 		}else if(item===8){
  	 			return repetition_periods.push(<span key={index}>Monthly</span>)
  	 		}else if(item===1){
  	 			return repetition_periods.push(<span key={index}>Every Monday</span>)
  	 		}else if(item===2){
  	 			return repetition_periods.push(<span key={index}>Every Tuesday </span>)
  	 		}else if(item===3){
  	 			return repetition_periods.push(<span key={index}>Every Wednesday</span>)
  	 		}else if(item===4){
  	 			return repetition_periods.push(<span key={index}>Every Thursday </span>)
  	 		}else if(item===5){
  	 			return repetition_periods.push(<span key={index}>Every Friday </span>)
  	 		}else if(item===6){
  	 			return repetition_periods.push(<span key={index}>Every Saturday  </span>)
  	 		}else if(item===7){
  	 			return repetition_periods.push(<span key={index}>Every Sunday </span>)
  	 		}
  	 		return repetition_periods
  	 	})
  	 }
	 const columns = [{
		  title: 'Name',
		  dataIndex: 'name',
		  render: (text,recoder)=> <Link  to={"/Performance?"+recoder.key} >
		  <div onClick={this.handleData.bind(this,recoder)}>{text}</div></Link>
		  
		}, {
		  title: 'Launch Date',
		  dataIndex: 'effective_date',
		  filterDropdown: <span></span>,
          filterIcon: <RangePicker onChange={(value,mode)=>{this.datechange('min_effective_date','max_effective_date',mode)}} />
		
		},{
		  title: 'End Date',
		  dataIndex: 'expiring_date',
		  filterDropdown: <span></span>,
          filterIcon: <RangePicker onChange={(value,mode)=>{this.datechange('min_expiring_date','max_expiring_date',mode)}} />
		 
		}, {
		  title: 'Turnover$',
		  dataIndex: 'turnover',
		  sorter: (a, b) =>{}
		 }, {
		  title: 'Transactions',
		  dataIndex: 'transactions_count',
		  sorter: (a, b) =>{}
		 }, {
		  title: 'Products Sold',
		  dataIndex: 'products_sold',
		  sorter: (a, b) =>{}
		 }, {
		  title: 'State',
		  dataIndex: 'state',
		  
		 }, {
		  title: 'Action',
		  dataIndex: 'Action',
		  
		 }];
    	return(
    		<div>
		    <Table 
		    className="WAcenter"
	        columns={columns} 
	        dataSource={data} 
	        onChange={this.onChange.bind(this)}
	        pagination={ pagenation }
          />
		    {   visible ? ( 
	    		<Drawer
	    		 className='walletcouponcenter'
		          width={520}
		          placement="right"
		          onClose={this.onClose}
		          maskClosable={false}
		          visible={ visible }
		        >
	    	  <div  style={{ display:  Drawerdata===1 ? "block" : "none"  }}>
	          <h2>Name</h2>
	          <p>{unicampaign.name ? unicampaign.name : ''}</p>
	          <hr/>
	          <h2>Description</h2>
	          <p>{unicampaign.description ? unicampaign.description : ''}</p>
	          <hr/>
	          <h2>Target Group</h2>
	          <p>{(membership && membership.length>0) ? 'Members: '+ membership : ''}</p>
	          <p>{(occupation && occupation.length>0)? 'Occupation: '+ occupation : ''}</p>
	          <p>{(gender && gender.length>0) ? 'Gender: '+gender : ''}</p>
	          <p>{((unicampaign.age && unicampaign.age.length>0) ) 
	          	? 'Age: '+ unicampaign.age : ''}</p>
	          <hr/>
	          <h2>Repetition period</h2>
	          <p>{ (repetition_periods && repetition_periods.length>0 ) ? repetition_periods 
	          	 : 'null'}&nbsp;{days_of_month + ''}</p>
	          <hr/>
	          <p>Launch Date : {unicampaign.effective_date ? unicampaign.effective_date : ''}</p>
	          <p>End Date : {unicampaign.expiring_date ? unicampaign.expiring_date : ''}</p>
	          <hr/>
	          <h2>Participant</h2>
	          <p>{(outlets && outlets.length>0) ? outlets  + ' ': ''}</p>
	          <hr/>
	          <h2>Event venue</h2>
	          <p>{(unicampaign.event_venue && unicampaign.event_venue.length>0) ? unicampaign.event_venue : ''}</p>
	          <hr/>
	          <div className='inputTableButton' >
	            <Button  className='btn1' onClick={this.Nextpage } > Nextpage </Button>
	            <Button onClick={this.Edit} className='btn2'>{this.state.bottonname2}</Button>
	            <Button onClick={this.Archived} className='btn2'>{this.state.bottonname}</Button>
	          </div>
	          </div>
	          
	          <div  style={{ display:  Drawerdata===2 ? "block" : "none"  }}>
	          <h2>Activity Type</h2>
	          <p>{(unicampaign.campaigntypes && unicampaign.campaigntypes.length>0 && unicampaign.campaigntypes[0].first_discount_per 
	          	&& unicampaign.campaigntypes[0].first_discount_per.toString().length>0)
	          	? '● Discount: Enjoy ' + unicampaign.campaigntypes[0].first_discount_per + ' % off' : ''}
	         	</p>
	          <p>{((unicampaign.campaigntypes && unicampaign.campaigntypes.length>0 && 
	          	   unicampaign.campaigntypes[0].last_discount_price && unicampaign.campaigntypes[0].last_discount_price.toString().length>0) ||
	          		(unicampaign.campaigntypes && unicampaign.campaigntypes.length>0 && unicampaign.campaigntypes[0].first_discount_price 
	          			&& unicampaign.campaigntypes[0].first_discount_price.toString().length>0))
	          	? '● Discount: $ ' + (unicampaign.campaigntypes[0].last_discount_price ? unicampaign.campaigntypes[0].last_discount_price : '')
	          	+ (unicampaign.campaigntypes[0].first_discount_price ? unicampaign.campaigntypes[0].first_discount_price : '') + ' off': ''}
	         	 </p>
	         <p>{(unicampaign.campaigntypes && unicampaign.campaigntypes.length>0 && 
	         	unicampaign.campaigntypes[0].last_discount_per && unicampaign.campaigntypes[0].last_discount_per.toString().length>0)
	          	? '● Discount: Enjoy ' + unicampaign.campaigntypes[0].last_discount_per + ' % off' : ''}
	         	</p>
	          <p>{(unicampaign.campaigntypes && unicampaign.campaigntypes.length>0 && 
	          	unicampaign.campaigntypes[0].top_up_money  )
	          	? ('● Member: Top up $ ' + unicampaign.campaigntypes[0].top_up_money  + ' and be our '
	          	  + upgrade_membership + ' member') : ''}</p>
	          <p>{ univoucher.length>0 ? '● Vouchers: ' +  univoucher + '  % off' : ''}</p>
	         
	          <p>{(unicampaign.campaigntypes && unicampaign.campaigntypes.length>0 && unicampaign.campaigntypes[0].bouns_points )
	          		? '● With every $1 can get '+ unicampaign.campaigntypes[0].bouns_points + "  'bubble' points " : ''}</p>
	          <hr/>
	          <h2>Activity Conditions</h2>
	          <p>{ campaign_condition.every_spent ? 
	          	'● With every $ ' + campaign_condition.every_spent + ' spen' : ''}</p>
	          <p>{ campaign_condition.every_top_up ? 
	          	'● With every $ ' + campaign_condition.every_top_up + ' top up to E-wallet ' : ''}</p>
	          <p>{ campaign_condition.every_use_points ? 
	          	'● With every use of ' + campaign_condition.every_use_points + " 'bubble' points" : ''}</p>
	          <p>{ (campaign_condition.every_purchase_m_drinks_flavors && campaign_condition.every_purchase_m_drinks_flavors.length>0 )? 
	          	'● With every purchase of  ' + productname  + ' medium size drinks' : ''}</p>
	          <p>{ (campaign_condition.every_purchase_l_drinks_flavors &&campaign_condition.every_purchase_l_drinks_flavors.length>0 )? 
	          	'● With every purchase of ' + productname  + ' large size drinks' : ''}</p>
	          <p>{ (campaign_condition.every_purchase_products &&campaign_condition.every_purchase_products.length>0 )? 
	          	'● With every purchase of ' + productname   : ''}</p>
	          {online_actions}
	          <p>{ (campaign_condition.every_customers ) ? 
	          	'● Select Every ' + campaign_condition.every_customers + ' th customers' : ''}</p>
	          <p>{ (campaign_condition.limit_redemption) ? 
	          	'● Limit to ' + campaign_condition.limit_redemption + ' redemption' : ''}</p>
	          <p>{ (campaign_condition.payment_modes && payment_modes.length>0) ? 
	          	'● Mode of ordering: ' + payment_modes  : ''}</p>
	          <p>{ (ordering_modes.length>0 ) ? 
	          	'● Mode of payment： ' +  ordering_modes : ''}</p>
	          <p>{ (campaign_condition  && campaign_condition.other_actions ) ? 
	          	'● other_actions: ' + campaign_condition.other_actions : ''}</p>
	          <hr/>
	          <div className='inputTableButton' >
	            <Button  className='btn1' onClick={this.PreviousPage } > Previous Page </Button>
	            <Button onClick={this.Edit} className='btn2'>{this.state.bottonname2}</Button>
	            <Button onClick={this.Archived} className='btn2'>{this.state.bottonname}</Button>
	          </div>
	          </div>
		          <Modal
		          title="MESSAGE"
		          visible={this.state.Archivedvisible}
		          onOk={this.handleArchivedOk.bind(this)}
		          onCancel={this.handleArchivedCancel}
		        >
		         <p>{this.state.Modalmessage}</p>
	          </Modal>
	    		</Drawer >  ) : '' }
	     </div>
    	)
  }
}
export default CampaignCenter;