import React from 'react';
import Cookies from 'js-cookie';
import { Icon,Button,Drawer,DatePicker,message,
				 Select,Menu,Dropdown,Checkbox,Radio,Col,Modal   } from 'antd';
import _ from 'lodash';
import moment from "moment";
import { reqcampaign,requnicampaign,reqoutletName,reqcategory,reqproduct,reqmembership,requnivoucher,
		 sendCampaign,sendCampaignCondition,sendCampaignType,patchCampaign,patchCampaignCondition,patchCampaignType } from '../../api/requrl';
import Top from '../top/index';
import CampaignCenter from './center';
import TargetGroup from './TargetGroup';
import './index.css'

const ButtonGroup = Button.Group;
const Option = Select.Option;
const RadioGroup = Radio.Group;
const SubMenu = Menu.SubMenu;
class Campaign extends React.Component {
  state={
    	campaigndata:'',
    	count:'',
    	data:'',
    	inputvalue:'',
    	unicampaign:{},
    	id:'',
    	submitdata:{page_size:6},
    	Drawerdata:'',
    	groupdata:'',
    	category:[],
    	discountdollarup:true,
    	product:[],
    	voucher:[],
    	outlet:[],
    	radiovalue:'',
    	discount_per:'',
    	membership:[],
    	Conditiondata:{},
    	Typedata:{},
    	Editdata:{outlets:[],membership:[],topping:[]},
    	Archivedvisible:false,
    	date:[false,false,false],
    	termdata:[false,false,false,false,false],
    	termdata2:[[false,false,false,false],[false,false,false],[false,false,false,false,false,false],false,false,false,false,false],
    	visible: false
    }
  	async componentDidMount() {
		const Token = Cookies.get("Authorization")  
		if(!Token){
		  window.location.href='/login'
		}else{
			let req         = await reqcampaign(Token)
			let req2        = await requnivoucher({page_size:999,state:[1,2]},Token)
			let req3        = await reqmembership(Token)
			let req4        = await reqoutletName(Token)
			let req5        = await reqcategory(Token)
			let req6        = await reqproduct(Token)
			let count       = req.data.count
			let voucher     = req2.data.results
			let membership  = req3.data.results
			let outlet      = req4.data.results
			let category    = req5.data.results
			let product     = req6.data.results
			let campaigndata = req.data.results
			this.setState({
			campaigndata,
			count,
			outlet,
			voucher,
			product,
			category,
			membership
			})
		}
	}
	async onChildChanged(data) {
	  const Token = Cookies.get("Authorization"); 
	  if(!data.page) {
			data.page = 1
		}
		const Data = { ...this.state.data,...data }
		 for(var key in Data) {
		    if(Data[key]==='') {
		      delete Data[key]
		    }
		 }
		 if(Data.type && Data.type.length===0) {
		      delete Data.type
		 }
		const req         = await requnicampaign(Data,Token)
		let   count       = req.data.count
		const campaigndata=req.data.results
		this.setState({
			data:Data,
			campaigndata,
			count
	  })
	}
	async onChildChanged2(data,data2){
			let {submitdata,Archivedvisible} = this.state
			let groupdata    = [] 
			console.log(data)
			Archivedvisible=data
			groupdata = data2
			submitdata = { ...submitdata,...groupdata }
			this.setState({
				submitdata,
				groupdata,
				Archivedvisible
	    })
	}
	async onChildChanged3(unicampaign,id,Editdata,recovery){
		if(recovery==='recovery'){
			await this.setState( { unicampaign,id })
			this.Create()
		}else{
			this.setState( { unicampaign,id,Editdata })
			this.showDrawer()
		}
	}
	showDrawer = () => {
    this.setState({
    	Drawerdata:1,
        visible: true,
	    });
	 };
	inputchange=(e)=>{
  	let value = e.target.value
    this.setState({
		inputvalue:value
		})
	}
    async handletext(){
    	const Token = Cookies.get("Authorization"); 
	    let { data,inputvalue } = this.state
	    let Data ={...data,page:1,search:inputvalue}
	    for(var key in Data) {
		    if(Data[key]==='') {
		      delete Data[key]
		    }
			 }
			let req     = await requnicampaign(Data,Token)
			let campaigndata  = req.data.results
			let count   = req.data.count
			    Data    = {...data,search:''}
					this.setState({
						data:Data,
						campaigndata,
						count,
						inputvalue:''
				})
    }
    async Click(e){
		const Token = Cookies.get("Authorization") 
		const data  = this.state.data
		const state = e.target.value
		let   Data  = {state}
		      Data  = {...data,...Data,page:1}
		for(var key in Data) {
		    if(Data[key]==='') {
		      delete Data[key]
		    }
		 }      
		const req   = await requnicampaign(Data,Token)
		const campaigndata=req.data.results
		let count = req.data.count
		this.setState({
			data:Data,
			campaigndata,
			count
		})
    }
  	submitdatachange=(e)=>{
	  	let submitdata   = this.state.submitdata
	  	let value  =e.target.value
	  	let name   = e.target.name
	  	submitdata = {...submitdata,[name]:value}
	  	this.setState({ submitdata })
    }
  	submitConditiondata=(e)=>{
	  	let Conditiondata   = this.state.Conditiondata
	  	let value  =e.target.value
	  	let name   = e.target.name
	  	let every_spent           = null,
			every_top_up          = null ,
			every_use_points      = null
	    if(name === 'every_spent ' ){
			every_spent        = value
			every_top_up       = null
			every_use_points   = null
		}else if( name === 'every_top_up  ' ){
			every_spent        = null
			every_top_up       = value
			every_use_points   = null
		}else if( name === 'every_use_points'){
			every_spent        = null
			every_top_up       = null
			every_use_points   = value
		}
	  	Conditiondata = {...Conditiondata,every_spent,every_top_up,every_use_points,[name]:value}
	  	this.setState({ Conditiondata })
    }
  	submitTypedata=(e)=>{
	  	let Typedata   = this.state.Typedata
	  	let	discount_per = this.state.discount_per
	  	let value  =e.target.value
	  	let name   = e.target.name
	  	if(name==="first_discount_per" || name==="last_discount_per"){
	  		discount_per = value
	  	}
	  	Typedata = {...Typedata,[name]:value}
	  	this.setState({ Typedata,discount_per })
    }
    onClose = () => {
	  this.setState( {  
	  	visible: false,
	  	date:[false,false,false],
	  	termdata:[false,false,false,false,false],
    	termdata2:[[false,false,false,false],[false,false,false],[false,false,false,false,false,false],false,false,false,false,false],
	  	groupdata:'',
	  	unicampaign:{},
	  	id:'',
	  	submitdata:{page_size:6},
	  	discount_per:'',
	  	Typedata : '',
	  	Conditiondata: '',
	  	Editdata:{outlets:[],membership:[],topping:[]}
	  });
	}
    targetgroup = () => {
  		this.setState( {  
	  	Archivedvisible:true,
	  });
  	}
     selectoutlets=(e)=>{
		let submitdata = this.state.submitdata
  		submitdata = {...submitdata,unparticipated_outlets:e}
  		this.setState({ submitdata })
   }
   PreviousStep=()=>{
  	this.setState({ Drawerdata:1 })
   }
	NextStep=()=>{
	  this.setState({ Drawerdata:2 })
	}
  	termdata=(e)=>{
		let termdata = this.state.termdata
		let value = e.key[5]
		termdata[value] = true
		this.setState({ termdata })
	}
  	termdata2=(e)=>{
  		let {termdata2,submitdata,Conditiondata } = this.state
		if(e.key[5]==='3' || e.key[5]==='4'|| e.key[5]==='5' || e.key[5]==='6'|| e.key[5]==='7'){
		let	first=e.key[5]
		termdata2[first]=true
		}else if(e.key[5]==='0'){
			if(submitdata.every_spent){
				delete submitdata.every_spent
			}
			if(submitdata.every_top_up){
				delete submitdata.every_spent
			}
			if(submitdata.every_use_points){
				delete submitdata.every_use_points
			}
		const	first=e.key[5]
		let	second=e.key[17]*1
		termdata2[first]=[false,false,false,false]
		termdata2[first][second]=true	
		}else if(e.key[5]==='1'){
			if(submitdata.every_purchase_m_drinks_flavors){
				delete submitdata.every_purchase_m_drinks_flavors
			}
			if(submitdata.every_purchase_l_drinks_flavors){
				delete submitdata.every_purchase_l_drinks_flavors
			}
			if(submitdata.every_purchase_products){
				delete submitdata.every_purchase_products
			}
		const	first=e.key[5]
		let	second=e.key[17]*1
		termdata2[first]=[false,false,false]
		termdata2[first][second]=true	
		}else if(e.key[5]==='2'){
		const	first='2'
		let	second=e.key[17]*1
		termdata2[first][second]=true	
		let online_actions=[]
		termdata2[first].map((item,index)=>{
			 if(item){
			 	online_actions.push(index)
			 }
			 return online_actions
		})
  		Conditiondata = {...Conditiondata,online_actions}
  		this.setState({ Conditiondata })
		}
		
		this.setState({ termdata2 })
  	}
    Dailyshow=()=>{
    	let { submitdata } = this.state
    	if(submitdata.days_of_month){
	 		delete submitdata.days_of_month
	 	}
    	let repetition_periods = [0]
    	submitdata = {...submitdata,repetition_periods}
	 	this.setState({ submitdata,date:[true,false,false] })
	}
	Weeklyshow=()=>{
	 	this.setState({ date:[false,true,false] })
	}
	Monthlyshow=()=>{
	  	this.setState({ date:[false,false,true] })
	}
	ondateChange=(e)=>{
	 	let { submitdata } = this.state
	 	if(submitdata.days_of_month){
	 		delete submitdata.days_of_month
	 	}
	 	e[0]=e
	 	let repetition_periods = []
	 	repetition_periods[0]=e.target.value
    	submitdata = {...submitdata,repetition_periods}
    	this.setState({ submitdata,radiovalue:e.target.value })
	}
	ondayChange=(e)=>{
	 	let { submitdata } = this.state
	 	let repetition_periods = [8]
    	submitdata = {...submitdata,repetition_periods,days_of_month:e}
    	this.setState({ submitdata })
	}
	selectdata=(value,name)=>{
	    let submitdata = this.state.submitdata
	  	submitdata = {...submitdata,[name]:value}
	  	this.setState({ submitdata })
    }
	selectTypedata=(value,name)=>{
	    let Typedata = this.state.Typedata
	  	Typedata = {...Typedata,[name]:value}
	  	this.setState({ Typedata })
    }
	seletConditiondata=(value,name)=>{
	    let Conditiondata = this.state.Conditiondata
	    let every_purchase_m_drinks_flavors = [] ,
			every_purchase_l_drinks_flavors = [] ,
			every_purchase_products         = []
	    if(name === 'every_purchase_m_drinks_flavors' ){
			every_purchase_m_drinks_flavors = value
			every_purchase_l_drinks_flavors = []
			every_purchase_products         = []
		}else if( name === 'every_purchase_l_drinks_flavors' ){
			every_purchase_m_drinks_flavors = []
			every_purchase_l_drinks_flavors = value
			every_purchase_products         = []
		}else if( name === 'every_purchase_products'){
			every_purchase_m_drinks_flavors = []
			every_purchase_l_drinks_flavors = []
			every_purchase_products         = value
		}
	  	Conditiondata = {...Conditiondata,every_purchase_m_drinks_flavors,every_purchase_l_drinks_flavors,every_purchase_products}
	  	this.setState({ Conditiondata })
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
    info = (text) => {
	  message.info(text);
	}
    async handledata(State){
    	const Token = Cookies.get("Authorization"); 
    	let {submitdata,id} = this.state
	  	submitdata  = {...submitdata,state:State,id:id}
	  	let message = 'success'
	  	for(let key in submitdata) {
		    if(submitdata[key].length===0) {
		      delete submitdata[key]
		    }
		} 
		if(submitdata.id && submitdata.id>0){
			try{
				let CampaignID = await patchCampaign(submitdata,Token)
					CampaignID = CampaignID.data.id
				let { Typedata , Conditiondata } = this.state
					Conditiondata = {...Conditiondata,campaign:CampaignID,id}
					if(Conditiondata.every_spent ){
						Conditiondata.every_top_up = null
						Conditiondata.every_use_points = null
					}
					if(Conditiondata.every_top_up ){
						Conditiondata.every_spent = null
						Conditiondata.every_use_points = null
					}
					if(Conditiondata.every_use_points){
						Conditiondata.every_spent = null
						Conditiondata.every_top_up = null
					}
					if(Conditiondata.every_purchase_m_drinks_flavors && Conditiondata.every_purchase_m_drinks_flavors.length>0 ){
						Conditiondata.every_purchase_l_drinks_flavors = []
						Conditiondata.every_purchase_products = []
					}else if(Conditiondata.every_purchase_l_drinks_flavors && Conditiondata.every_purchase_l_drinks_flavors.length>0 ){
						Conditiondata.every_purchase_m_drinks_flavors = []
						Conditiondata.every_purchase_products = []
					}else if(Conditiondata.every_purchase_products && Conditiondata.every_purchase_products.length>0){
						Conditiondata.every_purchase_m_drinks_flavors = []
						Conditiondata.every_purchase_l_drinks_flavors = []
					}
					console.log(Conditiondata)
					let CampaignconditionID = await patchCampaignCondition  (Conditiondata,Token)
					CampaignconditionID = CampaignconditionID.data.id
					Typedata = {...Typedata,campaign_condition:CampaignconditionID,campaign:CampaignID,id }
					await patchCampaignType(Typedata,Token)
				this.setState({ submitdata:'',id:'' ,Conditiondata:'',Typedata:'' })
				this.info(message)
				let  e = {target:{value:''}}
				this.Click(e)
		  		this.onClose()
			}catch(error){
				if (error.response && error.response.status===400) {
		      	message = 'name is required'
		      	this.info(message)
		   		}
			}
	    }else{
	    	if(!submitdata.name){
	  			this.info("name is required")
	  		}else{
	  			try{
					let CampaignID = await sendCampaign(submitdata,Token)
					    CampaignID = CampaignID.data.id
					let { Typedata , Conditiondata } = this.state   
						Conditiondata = {...Conditiondata,campaign:CampaignID}
					let CampaignconditionID = await sendCampaignCondition(Conditiondata,Token)
						CampaignconditionID = CampaignconditionID.data.id
					Typedata = {...Typedata,campaign_condition:CampaignconditionID,campaign:CampaignID}
						await sendCampaignType(Typedata,Token)
					message = 'success'
					this.info(message)
					this.setState({ submitdata:'',id:'' ,Conditiondata:'',Typedata:'' })
					let req2       = await reqcampaign(Token)
				  	let count      = req2.data.count
				  	let coupon     = req2.data.results
			  		this.setState({ count,coupon })
			  		this.onClose()
				}catch(error){
					if (error.response) {
			      		message = error.response.status
					this.info(message)
			   		}
				}
	  		}
	   		
	    }
   }
    async Save(){
    	let Submitdata= this.state.submitdata
    	if(!Submitdata.effective_date){
  			Submitdata  = {...Submitdata,effective_date:'0000-01-01'}
  			this.setState({submitdata:Submitdata})
	  	}
	  	if(!Submitdata.expiring_date){
	  		Submitdata  = {...Submitdata,expiring_date:'0000-01-01'}
	  		this.setState({submitdata:Submitdata})
	  	} 
    	this.handledata(0)
	  	
    }
    async Create(){
		let Submitdata= this.state.submitdata
		let ID  = this.state.id
		let {unicampaign} = this.state
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
  				this.info('Launch Data ande End Date must be chooice')
  			}
		}else{
			if(unicampaign.expiring_date<unicampaign.effective_date){
  				this.info('End Data must greater than Launch Date')
  			}else if(date2>unicampaign.expiring_date){
  				this.handledata(3)
  			}else if(unicampaign.expiring_date>date2 && date2>unicampaign.effective_date){
  				this.handledata(2)
  			}else if(date2<unicampaign.effective_date){
  				this.handledata(1)
  			}
		}
    }
    discountdollarup = () => {
    	let  { discountdollarup,submitdata } = this.state
    	if(discountdollarup){
    		submitdata.last_discount_per     = submitdata.first_discount_per  ? submitdata.first_discount_per  :  ''
    		submitdata.first_discount_price  = submitdata.last_discount_price ? submitdata.last_discount_price :  ''
    	}else{
    		submitdata.first_discount_per    = submitdata.last_discount_per    ? submitdata.last_discount_per  :  ''
    		submitdata.last_discount_price   = submitdata.first_discount_price ? submitdata.first_discount_price :  ''
    	}
    	this.setState({
    		discountdollarup:!discountdollarup
    	})
    }
    membershipChange=(e)=>{
    	let Typedata = this.state.Typedata
	  	Typedata = {...Typedata,upgrade_membership:e}
	  	this.setState({ Typedata })
    }
	render() {
		let { campaigndata,count,data,Drawerdata,groupdata,outlet,voucher,termdata,Editdata,
			termdata2,date,category,product,unicampaign,discountdollarup,discount_per,membership } = this.state
		const page = data.page
		let dateMemu = []
		for(let i = 1; i<32 ; i++){
			dateMemu.push(<Col span={4} key={i}><Checkbox value={i} key={i}>{i}</Checkbox></Col>)
		}
		const children = [];
		membership.map((item,index)=>(
			children.push(<Option key={item.id} value={item.id}>{item.name}</Option>)
		))
		const menu = (
		  <Menu>
		    <Menu.Item  onClick={this.termdata}>%Discount</Menu.Item>
		    <Menu.Item  onClick={this.termdata}>$Discount</Menu.Item>
		  	<Menu.Item  onClick={this.termdata}>Member</Menu.Item>
		    <Menu.Item  onClick={this.termdata}>Vouchers </Menu.Item>
		    <Menu.Item  onClick={this.termdata}>Points</Menu.Item>
		  </Menu>
		);
		const menu2 = (
		  <Menu>
		    <SubMenu title="Cost" >
		      <Menu.Item onClick={this.termdata2} disabled={ (termdata2[0][1] || termdata2[0][2])
		      ? true : false}>$spent</Menu.Item>
		      <Menu.Item onClick={this.termdata2} disabled={ (termdata2[1].indexOf('true')!==-1 || termdata2[6]
		      || termdata2[0][0] || termdata2[0][2])? true : false}>top up</Menu.Item>
		      <Menu.Item onClick={this.termdata2} disabled={ (termdata2[0][0] || termdata2[0][1])
		      ? true : false}>'bubble' points </Menu.Item>
		      <Menu.Item onClick={this.termdata2} disabled>purchase 'bubble' points</Menu.Item>
		    </SubMenu>
		    <SubMenu title="Purchase product " disabled={ termdata2[0][1] ? true : false}>
		      <Menu.Item onClick={this.termdata2}>medium size drinks</Menu.Item>
		      <Menu.Item onClick={this.termdata2}>large size drinks </Menu.Item>
		      <Menu.Item onClick={this.termdata2}>product type</Menu.Item>
		    </SubMenu>
		    <SubMenu title="Online action" >
		      <Menu.Item onClick={this.termdata2}>Like facebook page</Menu.Item>
		      <Menu.Item onClick={this.termdata2}>Like facebook post </Menu.Item>
		      <Menu.Item onClick={this.termdata2}>Rate on facebook</Menu.Item>
		      <Menu.Item onClick={this.termdata2}>Post on facebook page </Menu.Item>
		      <Menu.Item onClick={this.termdata2}>Share facebook page/ post</Menu.Item>
		      <Menu.Item onClick={this.termdata2}>Like instagram</Menu.Item>
		    </SubMenu>
		    <Menu.Item  onClick={this.termdata2}>Visit order </Menu.Item>
		    <Menu.Item  onClick={this.termdata2}>Limit</Menu.Item>
		    <Menu.Item  onClick={this.termdata2} disabled={ termdata2[0][1] ? true : false}>Mode of ordering</Menu.Item>
		    <Menu.Item  onClick={this.termdata2} disabled={ termdata2[0][2] ? true : false}>Mode of payment</Menu.Item>
		    <Menu.Item  onClick={this.termdata2}>Other actiont</Menu.Item>
		  </Menu>
		);
		return(
			<div className='Campaign'>
	    	 <div className='detail'>
	    	 <Top />
	    	 <h3 >Campaigndata</h3>
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
						className="form-control" 
						placeholder="Search ..." 
						name='search'
				        value={this.state.inputvalue}
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
	    		<CampaignCenter 
	    		campaigndata={campaigndata}
	    		callbackParent={this.onChildChanged.bind(this)}
	    		callbackParent2={this.onChildChanged3.bind(this)}
	    		count={count}
	    		page={page}
	    		/>
	    		{ this.state.visible ? ( 
	    		<Drawer
	    		  className='walletcouponcenter'
		          width={520}
		          placement="right"
		          onClose={this.onClose}
		          maskClosable={false}
		          visible={this.state.visible}
		        >
	    		
	    		<div  style={{ display:  Drawerdata===1 ? "block" : "none"  }}>
	         	 <h2>Name</h2>
	          <input placeholder={unicampaign.name ? unicampaign.name : "Please type the name of the campaign"} 
	         		 autoComplete="off" name='name' onChange={this.submitdatachange}/>
	          <h2>Description</h2>
	          <textarea placeholder={unicampaign.description ? unicampaign.description :
	          	"Please describe the campaign"} name='description' onChange={this.submitdatachange}>
	          </textarea>
	          <h2>Target Group &nbsp;
	          <Icon type="plus-circle-o" onClick={this.targetgroup} style={{cursor: 'pointer'}} /></h2>
	          <div className='Target'>
	          { 
	          		_.map(groupdata,(value,key)=>(
							<p key={key}>
							{key}: {value.map((item,index)=>(<span key={item}>{item}&nbsp;</span>))}
							</p>
							))
	          }
	          </div>
	          <h2>Repetition period</h2>
	          <div className='Repetition'>
	          <div className='Repetitionperiod'>
		    		<ul>
		    			<li onClick={this.Dailyshow} 
		    			className={((unicampaign.repetition_periods && unicampaign.repetition_periods[0] === '0') || date[0])
		    			? 'active' :''}>Daily</li>
		    			<li onClick={this.Weeklyshow}
		    			className={((unicampaign.repetition_periods && unicampaign.repetition_periods[0] !== '0' 
		    			&& unicampaign.repetition_periods[0] !== '8') || date[1])? 'active' :''}
		    			>Weekly&nbsp;&nbsp;&nbsp;&nbsp;<Icon type="right" /></li>
		    			<li onClick={this.Monthlyshow}
		    			className={((unicampaign.repetition_periods && unicampaign.repetition_periods[8] === '0' ) || date[2])? 'active' :''}
		    			>Monthly&nbsp;&nbsp;<Icon type="right" /></li>
		    		</ul>
	    		</div>
	    		<div  className='Repetitionperiod2'>
		    		<RadioGroup 
		    		style={{ display:  date[1]  ? "block" : "none"  }}
		    		onChange={this.ondateChange}
		    		
		    		value={this.state.radiovalue}>
					    <Col span={12}><Radio value={1}>Every Monday</Radio></Col>
					    <Col span={12}><Radio value={2}>Every Tuesday</Radio></Col>
					    <Col span={12}><Radio value={3}>Every Wednesday</Radio></Col>
					    <Col span={12}><Radio value={4}>Every Thursday</Radio></Col>
					    <Col span={12}><Radio value={5}>Every Friday</Radio></Col>
					    <Col span={12}><Radio value={6}>Every Saturday </Radio></Col>
					    <Col span={12}><Radio value={7}>Every Sunday</Radio></Col>
					 </RadioGroup>
					<Checkbox.Group 
					onChange={this.ondayChange} 
					style={{ display:  date[2]  ? "block" : "none"  }}>
					    {dateMemu}
					</Checkbox.Group>
	    		</div>
	    		</div>
	          <div className='date'>
	          <div>
	          <h2>Launch Date</h2>
	            <DatePicker
	            placeholder={ unicampaign.effective_date ? unicampaign.effective_date : 'Please select'}
	            onChange={this.dateonChange1} />
	          </div>
	          <div>
	          	<h2>End Data</h2>
	              <DatePicker 
	              placeholder={ unicampaign.expiring_date ? unicampaign.expiring_date : 'Please select'}
	              onChange={this.dateonChange2} />
	          </div>
	          </div>
	          <h2>Participant</h2>
	         		 <Select mode="multiple" 
	         		 style={{ width:'103%'  ,marginLeft: '-2%'}}
	         		 onChange={(value)=>this.selectdata(value,'outlets')}
	         		 placeholder={Editdata.outlets ? Editdata.outlets : "Please type address"}
	         		 className='Participantselect'>
				      {
				      	outlet ? outlet.map((item,index)=>(
				      		<Option key={item.id} value={item.id}>{item.outlet_name}</Option>
				      	))     : ''
				      }
				      </Select>
	          <h2>Event venue</h2>
	          <input  name='event_venue' placeholder={unicampaign.event_venue ? unicampaign.event_venue : "Please type address"} 
	         		  autoComplete="off" onChange={this.submitdatachange}/>
	          <div className='inputTableButton' >
	            <Button  className='btn1' onClick={this.Save.bind(this)} > Save </Button>
	            <Button onClick={this.NextStep} className='btn2'>Next Step</Button>
	          </div>
	          </div>
	          
	          <div  style={{ display:  Drawerdata===2 ? "block" : "none"  }}>
	          	<div className='title'><h1>Activity Title</h1></div>
	          	<h2>Activity Type 
	          <Dropdown overlay={menu} trigger={['click']} >
				    <span className="ant-dropdown-link Dropdownmume" >
				      Add type<Icon type="down" />
				    </span>
				  </Dropdown>
			  </h2>
	     	  <div className='campaignContent Content' >
	          <div style={{ display:((termdata[0] || unicampaign.first_discount_per) && discountdollarup) ? "block" : "none"  }}  >
	         			● Discount: Enjoy 
	         			<input value = { discount_per }
	         			placeholder={unicampaign.first_discount_per ? unicampaign.first_discount_per : ""}
	         			type='number' name='first_discount_per' onChange={this.submitTypedata}/>% off
      			</div >
      			<div style={{ display:(termdata[1] || unicampaign.last_discount_price)? "block" : "none"  }} >
	         			● Discount: $ 
	         			<input  placeholder={unicampaign.last_discount_price ? unicampaign.last_discount_price : ""}
	         			type='number' name={discountdollarup ? 'last_discount_price' : 'first_discount_price'} onChange={this.submitTypedata}/>off
	         			&nbsp;&nbsp; { discountdollarup ? <Icon style={{ display:(termdata[0] && termdata[1]  )? "inline-block" : "none"}}  
	         			           
	         			type="arrow-up"  onClick={ this.discountdollarup }/> :  ''}
      			</div > 
      			
      			<div style={{ display:(termdata[0] && discountdollarup===false) ? "block" : "none"  }}  >
	         			● Discount: Enjoy 
	         			<input value = { discount_per }
	         			placeholder={unicampaign.last_discount_per ? unicampaign.last_discount_per : ""}
	         			type='number' name='last_discount_per' onChange={this.submitTypedata}/>% off
	         			&nbsp;&nbsp;<Icon style={{ display:(termdata[0] && termdata[1] && !discountdollarup )? "inline-block" : "none"  }}
	         			type="arrow-up"  onClick={ this.discountdollarup }/>
      			</div >
      			<div style={{ display:(termdata[2] || unicampaign.limit_first_redemption)? "block" : "none"  }} >
	         			● Member: Top up $  
	         			<input type='number' name='top_up_money' onChange={this.submitTypedata}/>
	         			 and be our
	         			 <Select
         			    className='nobottom'
					    style={{ minWidth: '100px',height:'20px' }}
					    onChange={this.membershipChange} >
					    {children}
					  </Select> member
      			</div >
      			<div style={{ display:(termdata[3] || unicampaign.limit_first_redemption)? "block" : "none"  }} >
	         			● Vouchers: 
	         			<Select 
	         			onChange={(value)=>this.selectTypedata(value,'free_vouchers')}
	         			mode="multiple"
	         			className='nobottom'
	         			>
						      {
						      	voucher ? voucher.map((item,index)=>(
						      		<Option key={item.id} value={item.id}>{item.name}</Option>
						      	))      : ''
						      }
					      </Select>
      			</div >
      			<div style={{ display:termdata[4] ? "block" : "none"  }} >
	         			● With every $1 can get 
	         			<input type='number' name='bouns_points' onChange={this.submitTypedata}/>
	         			 ‘bubble’ points
      			</div >
	         </div> 
	          	
	          	
	           <h2>Activity Conditions
	          <Dropdown overlay={menu2} trigger={['click']} >
				    <span className="ant-dropdown-link Dropdownmume" >
				      Activity Conditions<Icon type="down" />
				    </span>
				  </Dropdown>
			  </h2>
	     	  <div className='campaignContent Content' >
	          <div style={{ display:termdata2[0][0] ? "block" : "none"  }} >
	         			● With every $ 
	         			<input type='number' name='every_spent' onChange={this.submitConditiondata}/>
	         			  spent
      			</div >
      			<div style={{ display:termdata2[0][1] ? "block" : "none"  }} >
	         			● With every $ 
	         			<input type='number' name='every_top_up' onChange={this.submitConditiondata}/>
	         			  top up to E-wallet 
      			</div >
      			<div style={{ display:termdata2[0][2] ? "block" : "none"  }} >
	         			● With every use of
	         			<input type='number' name='every_use_points' onChange={this.submitConditiondata}/>
	         			  'bubble' points
      			</div >
      			{ termdata2[1][0] ? 
	          <div >
	         			● With every purchase of 
	         			<Select 
	         			mode="multiple"
	         			className="nobottom"
	         			onChange={(value)=>this.seletConditiondata(value,'every_purchase_m_drinks_flavors')}>
					      {
					      	product ? product.map((item,index)=>(
					      		<Option key={item.id} value={item.id}>{item.name}</Option>
					      	))     : ''
					      }
					      </Select>
	         			  &nbsp;medium size drinks
      			</div >	 : ''}
      			{ termdata2[1][1] ? 
      			 <div >
	         			● With every purchase of 
	         			<Select
	         			mode="multiple"
	         			className="nobottom"
	         			onChange={(value)=>this.seletConditiondata(value,'every_purchase_l_drinks_flavors')}
	         			 >
					      {
					      	product ? product.map((item,index)=>(
					      		<Option key={item.id} value={item.id}>{item.name}</Option>
					      	))      : ''
					      }
					      </Select>
	         			  &nbsp;large size drinks
      			</div >   : ''}
      			{ termdata2[1][2] ? 
      			 <div  >
	         			● With every purchase of 
	         			<Select  
	         			mode="multiple"
	         			className="nobottom"
	         			onChange={(value)=>this.seletConditiondata(value,'every_purchase_products')}
	         			 >
					      {
					      	category ? category.map((item,index)=>(
					      		<Option key={item.id} value={item.id}>{item.name}</Option>
					      	))       : ''
					      }
					      </Select>
      			</div >  : ''}
      			 <div style={{ display:termdata2[2][0] ? "block" : "none"  }} >
	         			● Like our facebook page itea.sg
      			</div >
      			<div style={{ display:termdata2[2][1] ? "block" : "none"  }} >
	         			● Like our facebook post
      			</div >
      			<div style={{ display:termdata2[2][2] ? "block" : "none"  }} >
	         			● Rate us on facebook
      			</div >
      			<div style={{ display:termdata2[2][3] ? "block" : "none"  }} >
	         			● Post on our facebook page g
      			</div >
      			<div style={{ display:termdata2[2][4] ? "block" : "none"  }} >
	         			● Share our facebook page/ post
      			</div >
      			<div style={{ display:termdata2[2][5] ? "block" : "none"  }} >
	         			● Like our instagram
      			</div >
      			<div style={{ display:termdata2[3] ? "block" : "none"  }} >
	         			● Select Every 
	         			<input type='number' name='every_customers' onChange={this.submitConditiondata}/>
	         			th customers
      			</div >
      			<div style={{ display:termdata2[4] ? "block" : "none"  }} >
	         			● Limit to
	         			<input type='number' name='limit_redemption' onChange={this.submitConditiondata}/>
	         			 redemption
      			</div >
      			<div className='nobottom' style={{ display:termdata2[5] ? "block" : "none"  }} >
	         			● Mode of ordering：
	         			<Select 
	         			mode="multiple"
	         			onChange={(value)=>this.seletConditiondata(value,'payment_modes')}  >
					      		<Option key= '0' value='0'>Walk-in</Option>
					      		<Option key= '1' value='1'>Mobile ordering</Option>
					      </Select>
      			</div >
      			<div className='nobottom' style={{ display:termdata2[6] ? "block" : "none"  }} >
	         			● Mode of payment：
	         			<Select 
	         			mode="multiple"
	         			onChange={(value)=>this.seletConditiondata(value,'ordering_modes')} >
					      		<Option key= '0' value='0'>cash</Option>
					      		<Option key= '1' value='1'>apple pay</Option>
					      		<Option key= '2' value='2'>andriod pay</Option>
					      		<Option key= '3' value='3'>visa</Option>
					      		<Option key= '4' value='4'>mastercard</Option>
					      		<Option key= '5' value='5'>ezylink</Option>
					      		<Option key= '6' value='6'>QR code</Option>
					      		<Option key= '7' value='7'>favepay</Option>
					      		<Option key= '8' value='8'>grabpay</Option>
					      		<Option key= '9' value='9'>Alipay</Option>
					      		<Option key= '10' value='10'>Internet Banking</Option>
					      </Select>
      			</div >
      			<div style={{ display:termdata2[7] ? "block" : "none"  }} >
	         			<textarea 
	         			placeholder="● Please describe the action"
	         			name='other_actions' 
	         			onChange={this.submitConditiondata}>
	         			</textarea >
      			</div >
	      			<div className='inputTableButton' >
		            <Button  className='btn2' onClick={this.PreviousStep}>Previous step</Button>
		            <Button  className='btn1' 
		            style={{ marginLeft: '8px'  }}
		            onClick={this.Save.bind(this)}> Save </Button>
		            <Button  className='btn1' onClick={this.Create.bind(this)}> Create </Button>
		          	</div>
	          	</div>
	          </div>
	        </Drawer >  ) : '' }
	        	{ this.state.visible ? ( 
	    		<Modal 
	    		closable={false}
	    		footer={null}
	    		style={{ width: '351px'  }}
	    		visible={this.state.Archivedvisible}>
	    		<TargetGroup
	    		unicampaign={unicampaign} callbackParent={this.onChildChanged2.bind(this)} />
	    		 </Modal>
	    		) : '' }
    	  </div>
		);
	}
}
export default Campaign;