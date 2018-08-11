import React from 'react';
import { Table,Button,Drawer,DatePicker,Modal,message,Checkbox }  from 'antd';
import { reqcoupon,reqUniproductname,deletevoucherdata,patchvoucherdata,requnioutletName,requnimembership,
		 requnitoppings} from '../../../../api/requrl';
import Cookies from 'js-cookie';
import './center.css';

const {RangePicker}=DatePicker
class WcCenter extends React.Component {
    state={
    	visible        : false ,
    	confirmLoading : false,
    	Drawerdata     :1,
    	coupondata     :'',
    	productname    :[],
    	Archivedvisible:false,
    	id      : '',
    	data    :'',
    	Modalmessage:'Are you sure to delete permanently?',
    	bottonname:'Archived',
    	bottonname2:'',
    	outlets:[],
    	membership:[],
    	topping:[]
    }
    async reqoutlets(item){
    	let {outlets} = this.state
    	const Token      = Cookies.get("Authorization")
    	let req = await requnioutletName(item,Token)
    	outlets.push(req.data.outlet_name)
    	this.setState({outlets})
    }
    async reqmembership(item){
    	let {membership} = this.state
    	const Token      = Cookies.get("Authorization")
    	let req = await requnimembership(item,Token)
    	membership.push(req.data.name)
    	this.setState({membership})
    }
    async reqtopping(item){
    	let {topping} = this.state
    	const Token      = Cookies.get("Authorization")
    	let req = await requnitoppings(item,Token)
    	topping.push(req.data.name)
    	this.setState({topping})
    }
    async requniproductname(item){
    	let {productname} = this.state
    	const Token      = Cookies.get("Authorization")
    	let req = await reqUniproductname(item,Token)
    	productname.push(req.data.name)
    	this.setState({productname})
    }
	async showDrawer (e) {
		this.setState({visible: true })
		const Token      = Cookies.get("Authorization")
		let req          =  await reqcoupon(e.target.value,Token)
		let coupondata   =  req.data
		let productid    =  coupondata.redemption_products 
		let id           =  coupondata.id
		let outlets      =  []
		if(coupondata.unparticipated_outlets && coupondata.unparticipated_outlets.length>0){
			coupondata.unparticipated_outlets.map((item)=>(
				this.reqoutlets(item)
			))
		}
		if(coupondata.limit_memberships && coupondata.limit_memberships.length>0){
			coupondata.limit_memberships.map((item)=>(
				this.reqmembership(item)
			))
		}
		if(coupondata.redemption_toppings && coupondata.redemption_toppings.length>0){
			coupondata.redemption_toppings.map((item)=>(
				this.reqtopping(item)
			))
		}
		if(productid && productid.length>0){
			productid.map((item)=>(
				this.requniproductname(item)
			))
		}
		let bottonname   = (coupondata.state===4 ? 'Delete'   : 'Archived')
		let bottonname2  = (coupondata.state===4 ? 'Recovery' : 'Edit')
		let Modalmessage = (coupondata.state===4 ? `Are you sure to delete permanently?
			This data will disappear forever and can not be recovered.` : "This data will be moved to Archived." +  
			"you can recovery it in Archive.")
	    this.setState({
		      coupondata,
		      Drawerdata:1,
		      id,
		      bottonname,
		      Modalmessage,
		      bottonname2,
		      outlets
		    });
	};
	info = (text) => {
		  message.info(text);
	}
	async datechange(name1,name2,mode){
		let data = this.state.data
		let Data = {...data,[name1]:mode[0],[name2]:mode[1],page:1}
		this.props.callbackParent(Data);
	}
    onClose = () => {
      this.setState({
        visible: false,
        Drawerdata:1,
        coupondata:'',
        id:'',
        outlets:[],
    	membership:[],
    	topping:[],
    	productname:[]
      });
    };
	onTableChange=(pagination, filters, sorter)=> {
		let data={page:1}
	  if(pagination.current!==this.props.page){
	  	data={page:pagination.current}
	  	this.props.callbackParent(data);
	  }
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
 	  	}else if(item.type===5){
 	  		item.type='Toppings'
 	  	}
	}
    showModal = () => {
	    this.setState({
	      Archivedvisible: true,
	    });
 	}
	async handleArchivedOk (e)  {
		let { id,coupondata } = this.state
		let Token       =  Cookies.get("Authorization")
		if(coupondata.state===4 || coupondata.state==="archived"){
			try{
				await deletevoucherdata(id,Token)
	    		this.info('success')
	    		this.setState({ id:'' })
	    	}catch(error){
	    		let message = error.response.status
				this.info(message)
				this.setState({ id:'' })
	    	}
		}else{
			try{
    			await patchvoucherdata({state:4,id},Token)
    			this.info('success')
    			this.setState({ id:'' })
	    	}catch(error){
	    		let message = error.response.status
				this.info(message)
				this.setState({ id:'' })
	    	}
		}
    	this.setState({
       	    Archivedvisible   : false
     	});
     	const data = {page:1}
      	this.props.callbackParent(data);
  		this.onClose()
    }
	handleArchivedCancel = (e) => {
        this.setState({
        Archivedvisible   : false,
       });
    }
	Archived = () => {
	    this.setState({
	    Archivedvisible   : true,
	  });
	}
	changedrawer=()=>{
		let { id,coupondata,outlets,membership,topping } = this.state
		const Editdata = {outlets,membership,topping}
		this.onClose()
		if(coupondata.state===4 || coupondata.state==="archived"){
			const recovery = 'recovery'
			this.props.callbackParent2(id,coupondata,Editdata,recovery);
		}else{
			this.props.callbackParent2(id,coupondata,Editdata);
		}
	}
	onselectChange=(e,name)=>{
		const data={
	 		page:1,
	 		[name]:e
	 	}
	 	this.props.callbackParent(data);
	}
    render() {
     let  { coupon,count,page } =this.props
     let  { coupondata,Drawerdata,productname,outlets,membership,topping   } = this.state
     let  product_size=[]
     let  otherlimits=[]
     if (coupondata.product_size && coupondata.product_size.length > 0){
     	 coupondata.product_size.map((item)=>{
     	 	if(item===0){
     	 		product_size.push('medium')
     	 	}else if(item===1){
     	 		product_size.push('large ')
     	 	}
     	 	return product_size
     	 })
     }
     if(coupondata.other_limits&&coupondata.other_limits.length>0){
     	let other_limits=coupondata.other_limits
     	other_limits.map((index,item)=>{
     		if(index===0){
     			otherlimits.push('Not valid with other promo.')
     		}
     		if(index===1){
     			otherlimits.push('Non- refundable, non-transferable, non-reusable and non-exchangable for cash/points/credit in kind.')
     		}
     		if(index===2){
     			otherlimits.push('Voucher(s) must be used upon payment.')
     		}
     		if(index===3){
     			otherlimits.push('Voucher(s) must be utilized fully to the amount stated. Any unused amount will not be refunded.')
     		}
     		if(index===4){
     			otherlimits.push('Purchase exxceeding redemption value shall be topped up with cash or other payment option.')
     		}
     		if(index===5){
     			otherlimits.push('itea reserves the right to amend the terms and conditions without prior notice.')
     		}
     		if(index===6){
     			otherlimits.push('Redemption must be shown upon ordering for counter ordering.')
     		}
     		if(index===7){
     			otherlimits.push('itea will not be responsible for replacing expired vouchers.')
     		}
     		return otherlimits
     	})
     }
     this.tochange(coupondata)
     const pagenation = {
  		   current:page,
  		   hideOnSinglePage:true,
  		   total:count,
  		   pageSize: 6
  		 
  		}
  	 let data=[]
  	 if(coupon && coupon.length>0){
     	  coupon.map((item,index)=>{
     	  	this.tochange(item)
     	    return  data.push({
 	  		key: item.id,
			name:item.name,
			type:item.type,
			redemption_points: item.redemption_points,
			effective_date:item.effective_date,
			expiring_date:item.expiring_date,
			state:item.state,
			Action:(<Button value={item.id} onClick={this.showDrawer.bind(this)}>Details</Button>)
     	  	})
     	  })
     }
		let type = []
		type.push(<li key="0"><Checkbox value='0' >Product</Checkbox></li>)
		type.push(<li key="1"><Checkbox value='1' >Size upgrade</Checkbox></li>)
		type.push(<li key="2"><Checkbox value='2' >Cash</Checkbox></li>)
		type.push(<li key="3"><Checkbox value='3' >Discount</Checkbox></li>)
		type.push(<li key="4"><Checkbox value='4' >Buy one get one free</Checkbox></li>)
		type.push(<li key="5"><Checkbox value='5' >Toppings</Checkbox></li>)
	 const columns = [{
		  title: 'Name',
		  dataIndex: 'name',
		  
		}, {
		  title: 'Type',
		  dataIndex: 'type',
		  filterDropdown: <div className="tabledropdown" style={{ minWidth : '185px' }}>
		  <Checkbox.Group onChange={(e)=>this.onselectChange(e,'type')} ><ul>{type}</ul></Checkbox.Group></div>,
 		},{
		  title: 'Deducted Points',
		  dataIndex: 'redemption_points',
		  defaultSortOrder: 'descend',
		 
		}, {
		  title: 'Launch Date',
		  dataIndex: 'effective_date',
		  filterDropdown: <span></span>,
          filterIcon: <RangePicker onChange={(value,mode)=>{this.datechange('min_effective_date','max_effective_date',mode)}} />
		 }, {
		  title: 'End Date',
		  dataIndex: 'expiring_date',
		  filterDropdown: <span></span>,
          filterIcon: <RangePicker onChange={(value,mode)=>{this.datechange('min_expiring_date','max_expiring_date',mode)}} />
		 }, {
		  title: 'State',
		  dataIndex: 'state',
		 }, {
		  title: 'Action',
		  dataIndex: 'Action',
		  
		 }];
    	return(
    		<div>
    		{ this.state.visible ? 
	        <Drawer
	          className="walletcouponcenter"
	          width={520}
	          placement="right"
	          onClose={this.onClose}
	          maskClosable={false}
	          visible={this.state.visible}
	        > 
	        <div  style={{ display:  Drawerdata===1 ? "block" : "none"  }}>
	          <h2>Name</h2>
	          <p>{coupondata.name ? coupondata.name : ''}</p>
	          <hr/>
	          <h2>Unique Serial Number</h2>
	          <p>{coupondata.voucher_code ? coupondata.voucher_code : ''}</p>
	          <hr/>
	          <h2>Description</h2>
	          <p>{coupondata.description ? coupondata.description : ''}</p>
	          <hr/>
	          <div>
	          <div style={{ float: 'left',width:'48%',}}>
	          <h2>Launch Date</h2>
	               <p>{coupondata.effective_date ? coupondata.effective_date : ''}</p>
	               <hr/>
	          </div>
	          <div style={{ marginLeft:'4%', float: 'left',width:'48%',}}>
	          	<h2>End Data</h2>
	               <p>{coupondata.expiring_date ? coupondata.expiring_date : ''}</p>
	               <hr/>
	          </div>
	          </div>
	          <h2>Coupon Content</h2>
	          <p>{ productname.length>0  ? (coupondata.product_number+ ' ' + product_size + ' ' + productname) : ''}</p>
	          <p>{ coupondata.size_upgrade  ? '1 complimentary size upgrade' : ''}</p>
	          <p>{coupondata.discount_percent  ? 
	          	  'Discount: Enjoy ' + coupondata.discount_percent + ' %off' : ''}</p>
	          <p>{coupondata.discount_price ? 
	          	  'Discount:Enjoy $ '+ coupondata.discount_price + ' off' : ''}</p>
	          <p>{(coupondata.number_purchase ||  coupondata.number_complimentary_drinks) ? 
	          	  'buy ' + coupondata.number_purchase + ' get '+coupondata.number_complimentary_drinks+' free': ''}</p>
	          <p>{(topping && topping.length>0) ?  
	          	  'Toppings name: '+ topping : ''}</p>
	          <p>{(coupondata.toppings_number && coupondata.toppings_number.toString().length>0) ?  'Number of Toppings  '+coupondata.toppings_number : ''}</p>
	          <hr/>
	          <h2>Terms</h2>
	          <p>{(outlets && outlets.length>0) ? 
	          	'●Exclusive for ' + outlets + ' outlet(s) in (country) '  : '' }</p>
	          <p>{(membership && membership.length>0) ? 
	          	'●Exclusive for ' + membership +' members': ''}</p>
	          <p>{(coupondata.limit_first_redemption&&coupondata.limit_first_redemption.toString().length>0) ? 
	          	'● ' +coupondata.limit_first_redemption +' redemption per person/member ': ''}</p>
	           <p>{(coupondata.redemption_per&&coupondata.redemption_per.toString().length>0) ? 
	          	'● Limit to first  ' +coupondata.redemption_per +'  redemption': ''}</p>
	          	{otherlimits.map((item,index)=><p key={index}>{item}</p>)}
	          	<hr/>
	          <h2>Deducted 'Bubble' points</h2>
	          <p>{coupondata.redemption_points ? coupondata.redemption_points : ''}</p>
	          <div className='drawercentainbtn'>
	            <Button className='btn1' onClick={this.changedrawer}>
	              {this.state.bottonname2}
	            </Button>
	            <Button onClick={this.showModal} className='btn2 fontsize14'>{this.state.bottonname}</Button>
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
	        </Drawer>  :  '' }
		    <Table 
		    className="WAcenter"
	        columns={columns} 
	        dataSource={data} 
	        onChange={this.onTableChange.bind(this)}
	        pagination={ pagenation }
          />
	     </div>
    	)
  }
}
export default WcCenter;