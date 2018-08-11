import React 											 from 'react';
import Cookies 											 from 'js-cookie';
import Top 												 from '../../../top/index';
import WcCenter 										 from './center';
import _ 												 from 'lodash';
import moment											 from "moment";
import { Icon,Button,Drawer,DatePicker,Menu,
		 Select, Dropdown,TreeSelect, message  } 	     from 'antd';
import { Link } 										 from 'react-router-dom';
import { reqvoucher,requnivoucher,reqtoppings,
	     reqdatamembership, reqcategory,reqoutletName,
	     requniproductname,sendvoucherdata,patchvoucherdata
}  														 from '../../../../api/requrl';
import './index.css';


const ButtonGroup = Button.Group;
const SubMenu = Menu.SubMenu;
const Option = Select.Option;
const TreeNode = TreeSelect.TreeNode;

class WalletCoupon extends React.Component {
  state={
  	  visible: false,
    	value:'',
    	id: '',
    	coupondata:{},
    	Value: [],
    	treevalue: undefined,
    	coupon:'',
    	count:'',
    	type:'',
    	selesctValue:'',
    	toppings:'',
    	outlet:'',
    	membership:'',
    	productdata:{},
    	Editdata:{outlets:[],membership:[],topping:[]},
    	Archivedvisible:false,
    	termdata:[false,false,[false,false],[false,false,false,false,false,false,false,false]],
    	data:{
    		state:'',
    		page:1,
    		type:'',
    		page_size:6
    	},
    	submitdata:{}
    }
	async componentDidMount() {
		const Token = Cookies.get("Authorization")  
		if(!Token){
		  window.location.href='/login'
		}else{
			let req        = await reqvoucher(Token)
			let req2       = await reqtoppings(Token,{page_size:100})
			let req3       = await reqcategory(Token,{page_size:999})
			let req4       = await reqoutletName(Token,{page_size:100})
			let req5       = await reqdatamembership({page_size:100},Token)
			let req6       = await requniproductname({page_size:999},Token)
			let count      = req.data.count
			let coupon     = req.data.results
			let toppings   = req2.data.results
			let category   = req3.data.results
			let product    = req6.data.results
			let productdata= {}
			if(category && category.length>0){
				category.map((item,index)=>{
					let name = item.name
					let data = {[name]:[]}
					return	productdata={...productdata,...data}
				})
			}
			if(product && product.length>0){
				product.map((item,index)=>{
					let Productdata = item.category.name
					if(productdata[Productdata]){
						return productdata[Productdata].push(item)
						
					}else{
						productdata.push(item.name)
						return productdata[item.name].push(item)
					}
				})
			}
			let outlet     = req4.data.results
			let membership = req5.data.results
			this.setState({
			coupon,
			count,
			toppings,
			outlet,
			membership,
			productdata
			})
		}
	}
	
	async onChildChanged(data) {
	  const Token = Cookies.get("Authorization");
	  if(!data.page) {
			data.page = 1
		}
		const Data = { ...this.state.data,...data }
		 for(let key in Data) {
		    if(Data[key]==='') {
		      delete Data[key]
		    }
		 }
		 if(Data.type && Data.type.length===0) {
		      delete Data.type
		 }
		const req   = await requnivoucher(Data,Token)
		let count = req.data.count
    	const coupon=req.data.results
    	this.setState({
    		data:Data,
    		coupon,
    		count
    	})
	}
	async onChildChanged2(id,coupondata,Editdata,recovery) {
    	if(recovery==='recovery'){
			await this.setState( { coupondata,id })
			this.Createdata()
		}else{
			let selesctValue = ''
			if(coupondata.product_number|| (coupondata.product_size && coupondata.product_size.length>0) || 
			   (coupondata.redemption_products &&  coupondata.redemption_products.length>0)){
				selesctValue = '0'
			}else if(coupondata.size_upgrade ){
				selesctValue = '1'
			}else if(coupondata.discount_percent ){
				selesctValue = '2'
			}else if(coupondata.discount_price ){
				selesctValue = '3'
			}else if(coupondata.number_purchase ||  coupondata.number_complimentary_drinks ){
				selesctValue = '4'
			}else if(coupondata.toppings_number ||  (coupondata.redemption_toppings  && coupondata.redemption_toppings.length>0 )){
				selesctValue = '5'
			}
			this.setState( { coupondata,id,Editdata,selesctValue })
		}
    	this.showDrawer()
	}
	showDrawer = () => {
    this.setState({
      visible: true,
	    });
	 };
	onClose = () => {
	  this.setState( {  
	  	visible: false,
	  	coupondata:{},
	  	submitdata:{},
	  	id:'',
	  	termdata:[false,false,[false,false],[false,false,false,false,false,false,false,false]],
	  	selesctValue:'',
	  	treevalue:'',
	  	Editdata:{outlets:[],membership:[],topping:[]}
	  });
	};
	inputchange=(e)=>{
	  	let inputvalue = e.target.value
	  	let data = this.state.data
	  	let Data = {...data,search:inputvalue}
	    this.setState({
			data:Data,
			value:inputvalue
		})
  	}
    async handletext(){
    	const Token = Cookies.get("Authorization");
        let {data,value} = this.state
        let Data ={...data,page:1,search:value}
        for(let key in Data) {
		    if(Data[key].length === 0) {
		      delete Data[key]
		    }
		}
		let req     = await requnivoucher(Data,Token)
		let coupon  = req.data.results
		let count   = req.data.count
	    Data        = {...data}
		this.setState({
			data:Data,
			coupon,
			count,
			value:''
		})
    }
  	async Click(e){
  		const Token = Cookies.get("Authorization");
    	const data  = this.state.data
    	const state = e.target.value
    	let   Data  = {state}
    	      Data  = {...data,...Data,page:1}
    	for(let key in Data) {
		    if(Data[key]==='') {
		      delete Data[key]
		    }
		 }      
    	const req   = await requnivoucher(Data,Token)
    	const coupon=req.data.results
    	let count = req.data.count
    	this.setState({
    		data:Data,
    		coupon,
    		count
    	})
    }
	info = (text) => {
		  message.info(text);
	}
    handleChange=(value)=> {
  	 	let submitdata = this.state.submitdata
  	 	let data = {
  	 		redemption_toppings : [],
  	 		toppings_number     : null,
  	 		redemption_products : [],
  	 		product_size        : null,
  	 		product_number      : null,
  	 		size_upgrade        : false,
  	 		discount_percent    : null,
  	 		discount_price      : null,
  	 		number_purchase     : null,
  	 		number_complimentary_drinks : null
  	 	}
  		submitdata = {...submitdata,...data,type:value}
  	    if(value===1 || value==='1'){
	  	submitdata = {...submitdata,size_upgrade:true}
  	}
     this.setState({
    	selesctValue:value,
    	submitdata
  	 })
	}
    handleArchivedCancel = (e) => {
        this.setState({
        Archivedvisible   : false,
       });
    }
    termdata=(e)=>{
		let termdata = this.state.termdata
		if(e.key[5]==='0' || e.key[5]==='1'){
		let	first=e.key[5]
		termdata[first]=true
		}if(e.key[5]==='2'){
		const	first='2'
		let	second=e.key[17]*1
		termdata[first][second]=true	
		}if(e.key[5]==='3'){
		const	first='3'
		let	second=e.key[17]*1
		termdata[first][second]=true	
		let submitdata = this.state.submitdata
		let other_limits=[]
		termdata[first].map((item,index)=>{
			 if(item){
			 	other_limits.push(index)
			 }
			 return other_limits
		})
  		submitdata = {...submitdata,other_limits}
  		this.setState({ submitdata })
		termdata[first][second]=true	
		}
		this.setState({ termdata })
	}
    submitdatachange=(e)=>{
  	let submitdata = this.state.submitdata
  	let value=e.target.value
  	let name  = e.target.name
  	submitdata = {...submitdata,[name]:value}
  	this.setState({ submitdata })
  	}
    selectmemberships=(e)=>{
	    let submitdata = this.state.submitdata
	  	submitdata = {...submitdata,limit_memberships:e}
	  	this.setState({ submitdata })
    }
    selectoutlets=(e)=>{
    	let submitdata = this.state.submitdata
	  	submitdata = {...submitdata,unparticipated_outlets:e}
	  	this.setState({ submitdata })
    }
    selectToppings=(e)=>{
	    let submitdata = this.state.submitdata
	    let value = []
    	value[0]  = e
	  	submitdata = {...submitdata,redemption_toppings:value}
	  	this.setState({ submitdata })
    }
    selectCategory=(e)=>{
	    let submitdata = this.state.submitdata
	  	submitdata = {...submitdata,redemption_products:e}
	  	this.setState({ submitdata })
    }
    selectproduct_size=(e)=>{
	    let submitdata = this.state.submitdata
	  	submitdata = {...submitdata,product_size:e}
	  	this.setState({ submitdata })
    }
    dateonChange1=(date, dateString)=>{
	  	const effective_date=dateString
	  	let submitdata = this.state.submitdata
	  	submitdata = {...submitdata,effective_date}
	  	this.setState({ submitdata })
	}
    dateonChange2=(date, dateString)=>{
	  	const expiring_date= dateString
	  	let submitdata = this.state.submitdata
	  	submitdata = {...submitdata,expiring_date}
	  	this.setState({ submitdata })
	}
    membershipChange=(e)=>{
    	let submitdata = this.state.submitdata
	  	submitdata = {...submitdata,limit_memberships:e}
	  	this.setState({ submitdata })
    }
    ProductSize=(e)=>{
    	let submitdata = this.state.submitdata
	  	submitdata = {...submitdata,product_size:e}
	  	this.setState({ submitdata })
    }
    onproductChange = (treevalue) => {
	    let submitdata = this.state.submitdata
	  	submitdata = {...submitdata,redemption_products:treevalue}
	    this.setState({ treevalue,submitdata });
	 }
    async handledata(State){
    	const Token = Cookies.get("Authorization");
    	let {submitdata,id} = this.state
	  	submitdata  = {...submitdata,state:State,id:id}
	  	let message = 'success'
	  	for(let key in submitdata) {
		    if(submitdata[key]==='') {
		      delete submitdata[key]
		    }
		} 
		if(submitdata.id && submitdata.id>0){
			try{
				if(submitdata.redemption_toppings || submitdata.toppings_number || submitdata.redemption_products || submitdata.product_size || 
					submitdata.product_number || submitdata.size_upgrade || submitdata.discount_percent || submitdata.discount_price || 
					submitdata.number_purchase || submitdata.number_complimentary_drinks){
					let data = {
		  	 		redemption_toppings : [],
		  	 		toppings_number     : null,
		  	 		redemption_products : [],
		  	 		product_size        : null,
		  	 		product_number      : null,
		  	 		size_upgrade        : false,
		  	 		discount_percent    : null,
		  	 		discount_price      : null,
		  	 		number_purchase     : null,
		  	 		number_complimentary_drinks : null
		  	 		}
					submitdata = {...data,...submitdata}	
				}
				
				await patchvoucherdata(submitdata,Token)
				this.info(message)
				this.setState({ submitdata:'',id:'' ,data:{page:1}})
			  	let req2        = await requnivoucher({page:1,page_size:6},Token)
			  	let count       = req2.data.count
			  	let coupon      = req2.data.results
			  	this.setState({ count,coupon,})
		  		this.onClose()
			}catch(error){
				if (error.response) {
		      	message = error.response.status
		      	this.info(message)
		      	if(error.response.status){
		      		this.info("Unique Serial Number Already exist")
		      	 }
		   		}
			}
	    }else{
	    	if(!submitdata.voucher_code){
	  			this.info("Unique Serial Number is required")
	  	   }else if(!submitdata.redemption_points){
	  			this.info("Bubble points is required")
	  	    }else if(!submitdata.name){
	  			this.info("name is required")
	  		}else if(!submitdata.type){
	  			this.info("Coupon Content is required")
	  		}else{
	  			try{
	  				if(!submitdata.type){
	  					let {coupondata} = this.state
	  					submitdata.type  = coupondata.type ? coupondata.type : '0'
	  				}
	  				
					await sendvoucherdata(submitdata,Token)
					message = 'success'
					this.info(message)
					this.setState({ submitdata:'',id:'' })
					let data = this.state.data
					for(let key in data) {
					    if(data[key].length===0) {
					      delete data[key]
					    }
					}
					let req2       = await requnivoucher(data,Token)
				  	let count      = req2.data.count
				  	let coupon     = req2.data.results
			  		this.setState({ count,coupon })
			  		this.onClose()
			}catch(error){
				if (error.response) {
		      	console.log(error.response.data);
		      	message = error.response.status 
		      	this.info(message)
				if(error.response.status===400){
		      		this.info("Unique Serial Number Already exist")
		      	 }else if((error.response.status===500)){
		      	 	this.info("Server Error 500")
		      	 	this.onClose()
		      	 }
		   		}
			 }
	  		}
	    }
   }
	async handlesavedata(){
		let Submitdata= this.state.submitdata
    	if(!Submitdata.effective_date){
  			Submitdata  = {...Submitdata,effective_date:'1000-01-01'}
  			this.setState({submitdata:Submitdata})
	  	}
	  	if(!Submitdata.expiring_date){
	  		Submitdata  = {...Submitdata,expiring_date:'1000-01-01'}
	  		this.setState({submitdata:Submitdata})
	  	}
	  		this.handledata(0)
    }
	async Createdata(){
		let Submitdata= this.state.submitdata
		let ID  = this.state.id
		let {coupondata} = this.state
		if(!coupondata.expiring_date || !coupondata.effective_date){
			coupondata.expiring_date = ''
			coupondata.effective_date= ''
		}
		let date2 = moment().format('YYYY-MM-DD')
		if(!ID){
			if(Submitdata.expiring_date && Submitdata.effective_date){
	  			if(Submitdata.expiring_date<Submitdata.effective_date){
	  				this.info('End Data must greater than Launch Date')
	  			}else if(date2>Submitdata.expiring_date){
	  				this.handledata(3)
	  			}else if((Submitdata.expiring_date>date2 || Submitdata.expiring_date===date2) && 
	  						(date2>Submitdata.effective_date || date2===Submitdata.effective_date)){
	  				this.handledata(2)
	  			}else if(date2<Submitdata.effective_date){
	  				this.handledata(1)
	  			}
  			}else{
  				this.info('Launch Data and End Date is required')
  			}
		}else{
			if(coupondata.expiring_date<coupondata.effective_date){
  				this.info('End Data must greater than Launch Date')
  			}else if(date2>coupondata.expiring_date){
  				this.handledata(3)
  			}else if(  (coupondata.expiring_date>date2 || coupondata.expiring_date===date2) && 
  			          (date2>coupondata.effective_date || date2=== coupondata.effective_date)){
  				this.handledata(2)
  			}else if(date2<coupondata.effective_date){
  				this.handledata(1)
  			}
		}
    }
	
	render() {
		let { coupon,count,data,toppings,selesctValue,termdata,
					outlet,membership,productdata,coupondata,Editdata} = this.state
		let Toppings=[]
		let Outlet=[]
		let Membership=[]
		if (toppings && toppings.length>0){
     	Toppings = toppings
    	 }
		if (outlet && outlet.length>0){
     		Outlet = outlet
     	}
		if (membership && membership.length>0){
     		Membership = membership
    	}
		const page = data.page
		const children = [];
		Membership.map((item,index)=>(
			children.push(<Option key={item.id} value={item.id}>{item.name}</Option>)
		))
		
		const menu = (
		  <Menu>
		    <Menu.Item  onClick={this.termdata}>Outlets limit</Menu.Item>
		    <Menu.Item  onClick={this.termdata}>Members limit</Menu.Item>
		    <SubMenu title="Frequency Limit" >
		      <Menu.Item onClick={this.termdata}>X redemption per person/member</Menu.Item>
		      <Menu.Item onClick={this.termdata}>Limit to first XX redemption</Menu.Item>
		    </SubMenu>
		    <SubMenu title="Other Limit" >
		      <Menu.Item onClick={this.termdata}>Not vaild with other promo</Menu.Item>
		      <Menu.Item onClick={this.termdata}>Non-refundable,non-transferable, non-reusable and non-exchangable 
		      for cash/points/credit in kind</Menu.Item>
		      <Menu.Item onClick={this.termdata}>Voucher(s) must be used upon payment</Menu.Item>
		      <Menu.Item onClick={this.termdata}>Voucher(s) must be utilized fully to the amount stated. Any unused 
		      amount will not be refunded. </Menu.Item>
		      <Menu.Item onClick={this.termdata}>Purchase exxceeding redemption value shall be topped up with cash or 
		      other payment option</Menu.Item>
		      <Menu.Item onClick={this.termdata}>itea reserves the right to amend the terms and conditions without 
		      prior notice </Menu.Item>
		      <Menu.Item onClick={this.termdata}>Redemption must be shown upon ordering for counter ordering </Menu.Item>
		      <Menu.Item onClick={this.termdata}>itea will not be responsible for replacing expired vouchers</Menu.Item>
		    </SubMenu>
		  </Menu>
		);
		return(
			<div className='walletcoupon'>
	    		<Top />
	    		<div className='detail'>
	    		<Link  to={"/Membership?2"} className="back" ><h5><Icon type="arrow-left" />&nbsp;Back to E-wallet Data Table</h5></Link>
				<h3 >Coupon</h3>
				   <ButtonGroup >
				      <Button value=''  onClick={this.Click.bind(this)} >All</Button>
				      <Button value='0' onClick={this.Click.bind(this)} >Processing</Button>
				      <Button value='1' onClick={this.Click.bind(this)} >Waiting</Button>
				      <Button value='2' onClick={this.Click.bind(this)} >Launched</Button>
				      <Button value='3' onClick={this.Click.bind(this)} >Completed</Button>
				      <Button value='4' onClick={this.Click.bind(this)} >Archived</Button>
				    </ButtonGroup>
				    <div className="input-group col-md-2 search">
						<input
						type="text" 
						autoComplete="off"
						className="form-control" 
						placeholder="Search ..." 
						name='search'
				        value={this.state.value}
				        onChange={e => this.inputchange(e)}
						/>
						<span className="input-group-btn">
					    <button className="btn btn-default searchBtn" type="button" onClick={this.handletext.bind(this)}>
				        <i className="fa fa-search" ></i>
				        </button>
						</span>
					</div>
					<Button className="button2" onClick={this.showDrawer}>Add</Button>
	    		</div>
	    		<WcCenter 
	    		coupon={coupon}
	    		callbackParent={this.onChildChanged.bind(this)} 
	    		callbackParent2={this.onChildChanged2.bind(this)}
	    		count={count}
	    		page={page}
	    		/>
	    	{ this.state.visible ?  (
	    	<Drawer
	    	  className='walletcouponcenter'
	          width={520}
	          placement="right"
	          onClose={this.onClose}
	          maskClosable={false}
	          visible={this.state.visible}
	        >
	    	
	          <h2>Name</h2>
	          <input
	          autoComplete="off"
	          placeholder={ coupondata.name ? coupondata.name : "Please type the name of the coupon" } 
	          name='name' onChange={this.submitdatachange}/>
	          <h2>Unique Serial Number</h2>
	          <input 
	          autoComplete="off"
	          placeholder={ coupondata.voucher_code ? coupondata.voucher_code : "Please type the number" }
	          name='voucher_code' 
	          onChange={this.submitdatachange}/>
	          <h2>Description</h2>
	          <textarea placeholder={ coupondata.description ? coupondata.description : "Please describe coupon" } name='description' onChange={this.submitdatachange}>
	          </textarea>
	          <div className='date'>
	          <div>
	          <h2>Launch Date</h2>
	            <DatePicker 
	            placeholder={ coupondata.effective_date ? coupondata.effective_date : 'Please select'}
	            onChange={this.dateonChange1} />
	          </div>
	          <div>
	          	<h2>End Data</h2>
	              <DatePicker 
	              placeholder={ coupondata.expiring_date ? coupondata.expiring_date : 'Please select'}
	              onChange={this.dateonChange2} />
	          </div>
	          </div>
	          <h2>Coupon Content 
	          	 <Select 
	          	 defaultValue='Choose type' style={{ width: 120 }} onChange={this.handleChange}>
				      <Option value="5">Toppings</Option>
				      <Option value="0">Product</Option>
				      <Option value="1">Size upgrade</Option>
				      <Option value="2">Cash</Option>
				      <Option value="3">Discount</Option>
				      <Option value="4">Buy ? get ?</Option>
				  </Select>
	          </h2>
	          
			  <div  className='Content'>
	          	<h5 style={{ display:  selesctValue==='5'  ? "block" : "none"  }}>1.Toppings name 
          		  <Select placeholder={ Editdata.topping.length>0 ? Editdata.topping : 'Please select toppings'} onChange={this.selectToppings}>
			      {
			      	Toppings ? Toppings.map((item,index)=>(
			      		<Option key={item.id} value={item.id}>{item.name}</Option>
			      	))       :  ''
			      }
			      </Select>
				</h5>
				<h5 style={{ display:  selesctValue==='5'  ? "block" : "none"   }}>2.Number of Toppings:
          		  <input type="number"
          		  placeholder={(coupondata.toppings_number && coupondata.toppings_number.toString().length>0) ? coupondata.toppings_number : ''}
          		  name='toppings_number' onChange={this.submitdatachange}/>
				</h5>
				<h5 className='nobottom'  style={{ display:  selesctValue==='0' ? "block" : "none"  }}>1.Product name 
          		  <TreeSelect
			        showSearch
			        value={this.state.treevalue}
			        dropdownStyle={{ maxHeight: 400, width: 260,minWidth:0 }}
			        allowClear
			        multiple
			        treeDefaultExpandAll= {true}
			        treeCheckable= {true}
			        onChange={this.onproductChange}
			      >
		           {
			           	_.map(productdata,(value,key)=>(
							<TreeNode key={key} value={key} title={key}>
							 {
							 	value.map((item,index)=>(
								  <TreeNode key={item.id} value={item.id.toString()} title={item.name}>
								  </TreeNode>
								 ))
							 }
							</TreeNode>
							
						))
		           }
			      </TreeSelect>
				</h5>
				<h5 
				className='nobottom'
				style={{ display:  selesctValue==='0' ? "block" : "none"  }}>2.Product size
          		   <Select
          		   		className="boderbottomnone"
					    mode="multiple" style={{ minWidth: '200px',height:'20px' }} 
					    onChange={this.ProductSize} >
					    <Option key='0'>Medium size</Option>
					    <Option key='1'>Large siz</Option>
					  </Select> 
				</h5>
				<h5 style={{ display:  selesctValue==='0' ? "block" : "none"  }}>3.Number of product:
          		  <input type="number" 
          		  name='product_number' onChange={this.submitdatachange}/>
				</h5>
				<h5 style={{ display:  selesctValue==='1'  ? "block" : "none"  }}>1. 1complimentary size upgrade</h5>
				<h5 style={{ display:  selesctValue==='2'  ? "block" : "none"  }}>1. Discount:Enjoy
				<input type="number" 
				placeholder={(coupondata.discount_percent && coupondata.discount_percent.toString().length>0) 
					? coupondata.discount_percent : ''}
					name='discount_percent' onChange={this.submitdatachange}/>%off</h5>
				<h5 style={{ display:  selesctValue==='3' ? "block" : "none"  }}>1. Discount:Enjoy $
				<input type="number" 
				placeholder={(coupondata.discount_price && coupondata.discount_price.toString().length>0) 
					? coupondata.discount_price : ''}
				name='discount_price' onChange={this.submitdatachange}/>off</h5>
				<h5 style={{ display:  selesctValue==='4' ? "block" : "none"  }}>1. The number of purchase(s):
				<input 
				placeholder={(coupondata.number_purchase && coupondata.number_purchase.toString().length>0) 
					? coupondata.number_purchase : ''}
				type="number"  name='number_purchase' onChange={this.submitdatachange}/>:</h5>
				<h5 style={{ display:  selesctValue==='4'  ? "block" : "none"  }}>1. The number of complimentary drinks:
				<input 
				placeholder={(coupondata.number_complimentary_drinks && coupondata.number_complimentary_drinks.toString().length>0) 
					? coupondata.number_complimentary_drinks : ''}
				type="number"  name='number_complimentary_drinks' onChange={this.submitdatachange}/>:</h5>
	         </div>
	          <h2>Terms 
	          <Dropdown overlay={menu} trigger={['click']} >
				    <span className="ant-dropdown-link Dropdownmume" >
				      Add terms<Icon type="down" />
				    </span>
				  </Dropdown>
			  </h2>
	     	  <div className='Content' >
	          <div className='nobottom' style={{ display:(termdata[0] || Editdata.outlets.length>0) ? "block" : "none"  }} >
	         			●Exclusive for 
	         		 <Select mode="multiple"  
	         		 placeholder={Editdata.outlets.length>0 ? Editdata.outlets : 'Please select'}
	         		 onChange={this.selectoutlets}>
				      {
				      	Outlet.map((item,index)=>(
				      		<Option key={item.id} value={item.id}>{item.outlet_name}</Option>
				      	))
				      }
				      </Select> outlet(s) in (country)
      			</div >
      			<div className='nobottom' style={{ display:(termdata[1] || (Editdata.membership && Editdata.membership.length>0)) ? "block" : "none"  }} >
	         			●Exclusive for 
         			 <Select
         			    className='nobottom'
					    mode="multiple"
					    style={{ minWidth: '200px',height:'20px' }}
					    placeholder={(Editdata.membership && Editdata.membership.length>0) ? Editdata.membership + ' ': 'Please select'}
					    onChange={this.membershipChange} >
					    {children}
					  </Select> members
				                      
      			</div >
      			<div style={{ display:termdata[2][0] ? "block" : "none"  }} >
	         			●<input type='number' name='limit_first_redemption' onChange={this.submitdatachange}/>redemption per person/member
      			</div >
      			<div style={{ display:termdata[2][1] ? "block" : "none"  }} >
	         			●Limit to frist<input type='number' name='redemption_per' onChange={this.submitdatachange}/>redemption
      			</div >
      			<div style={{ display:termdata[3][0] ? "block" : "none"  }} >
	         			Not valid with other promo.
      			</div >
      			<div style={{ display:termdata[3][1] ? "block" : "none"  }} >
	         			Non- refundable, non-transferable, non-reusable 
	         			and non-exchangable for cash/points/credit in kind.
      			</div >
      			<div style={{ display:termdata[3][2] ? "block" : "none"  }} >
	         			Voucher(s) must be used upon payment. 
      			</div >
      			<div style={{ display:termdata[3][3] ? "block" : "none"  }} >
	         			Voucher(s) must be utilized fully to the amount
	         			stated. Any unused amount will not be refunded.
      			</div >
      			<div style={{ display:termdata[3][4] ? "block" : "none"  }} >
	         			Purchase exxceeding redemption value shall be topped
	         			up with cash or other payment option.
      			</div >
      			<div style={{ display:termdata[3][5] ? "block" : "none"  }} >
	         			itea reserves the right to amend the terms and
	         			conditions without prior notice.
      			</div >
      			<div style={{ display:termdata[3][6] ? "block" : "none"  }} >
	         			Redemption must be shown upon ordering for counter ordering. 
      			</div >
      			<div style={{ display:termdata[3][7] ? "block" : "none"  }} >
	         			itea will not be responsible for replacing expired vouchers.
      			</div >
	         </div> 
	          <h2> Deducted 'Bubble' points:
	          <input 
	          style={{ width: '456px',marginTop: '8px' }}
	          placeholder={ coupondata.redemption_points ? coupondata.redemption_points : ''}
	          type='number' name='redemption_points' onChange={this.submitdatachange}/></h2>
	          <div className='drawercentainbtn'>
	            <Button
	              className='btn1'
	              onClick={this.handlesavedata.bind(this)}
	            >
	              Save
	            </Button>
	            <Button onClick={this.Createdata.bind(this)} className='btn2'>Create</Button>
	          </div>
	        </Drawer>) :'' }
    	  </div>
		);
	}
}

export default WalletCoupon;