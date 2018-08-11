import React from 'react';
import './center.css';
import { requnimembership,requnivoucher,patchmembership,postmembership,deletemembership,reqUnivoucher } from '../../../../api/requrl';
import { Table,Button,Drawer,Select,message,Modal  } from 'antd';
import Cookies from 'js-cookie';

const Option = Select.Option;
class Center extends React.Component {
 	state = {
		search:'',
		id:'',
		unimembership:{},
	    visible: false,
	    Drawerdata:'',
	    voucher:[],
	    submitdata:'',
	    Archivedvisible : false,
	    bottonname: '',
	    bottonname2: '',
	    Modalmessage:'',
	    univoucher:[],
	    univoucher2:[]
	    
	}
 	async componentDidMount() {
		const Token = Cookies.get("Authorization")
 		let data = {state:[1,2],page_size:100}
		let req1   = await requnivoucher(data,Token)
		let voucher = req1.data.results
		this.setState({
		voucher
		})
	}
 	async reqUnivoucher(item){
    	let {univoucher} = this.state
    	const Token      = Cookies.get("Authorization")
    	let req = await reqUnivoucher(item,Token)
    	univoucher.push(req.data.name)
    	this.setState({univoucher})
    }
 	async reqUnivoucher2(item){
    	let {univoucher2} = this.state
    	const Token      = Cookies.get("Authorization")
    	let req = await reqUnivoucher(item,Token)
    	univoucher2.push(req.data.name)
    	this.setState({univoucher2})
    }
    async showDrawer (e) {
    	this.setState({ visible: true });
		const Token         =  Cookies.get("Authorization")
		let req             =  await requnimembership(e.target.value,Token)
		let unimembership   =  req.data
		let id              =  req.data.id
		let bottonname   = (unimembership.state===2 ? 'Delete' : 'Archived')
		let bottonname2  = (unimembership.state===2 ? 'Recovery' : 'Edit')
		let Modalmessage = (unimembership.state===2 ? `Are you sure to delete permanently?
			This data will disappear forever and can not be recovered.` : "This data will be moved to Archived." +  
			"you can recovery it in Archive.")
		if(unimembership.complimentary_vouchers){
			unimembership.complimentary_vouchers.map((item)=>(
				this.reqUnivoucher(item)
			))
		}
		if(unimembership.birthday_vouchers){
			unimembership.birthday_vouchers.map((item)=>(
				this.reqUnivoucher2(item)
			))
		}
	    this.setState({
		      unimembership,
		      Drawerdata:1,
		      submitdata:unimembership,
		      id,
		      bottonname,
		      Modalmessage,
		      bottonname2
		    });
	};
	async onChange(current, pageSize){ 
          const data={
	 		page:current,
	 		page_size:6
	 	}
	 	this.props.callbackParent(data);
    }
	info = (text) => {
	  message.info(text);
	}
	Archived = () => {
	    this.setState({
	    Archivedvisible   : true,
	  });
	}
	async handleArchivedOk (e)  {
		let { id,unimembership } = this.state
		let Token       =  Cookies.get("Authorization")
		if(unimembership.state===2 || unimembership.state==="archived"){
			try{
				await deletemembership(id,Token)
	    		this.info('success')
	    		this.setState({ id:'' })
	    	}catch(error){
	    		let message = error.response.status
				this.info(message)
				this.setState({ id:'' })
	    	}
		}else{
			try{
    			await patchmembership({state:2,id},Token)
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
      	this.props.callbackParent(true);
  		this.onClose()
    }

    handleArchivedCancel = (e) => {
        this.setState({
        Archivedvisible   : false,
       });
    }
	handlecoupons= (value,name)=>{
		let submitdata = this.state.submitdata
	  	submitdata = {...submitdata,[name]:value}
	  	this.setState({ submitdata })
	}
	onClose = () => {
	  this.setState( {  
	  	visible: false,
	  	Drawerdata:'',
	  	submitdata:'',
	  	unimembership:'',
	  	univoucher:[],
	  	univoucher2:[]
	  })
	  this.props.callbackParent(false);
	}
	toEdit=()=>{
		let { unimembership } = this.state
		this.setState({ Drawerdata:2 })
		if(unimembership.state===2 || unimembership.state==="archived"){
			this.handledata(1)
			this.onClose()
		}else{
			this.setState({ Drawerdata:2 })
		}
	}
	
	async handledata(State){
		const Token         =  Cookies.get("Authorization")
    	let {submitdata,id} = this.state
	  	submitdata  = {...submitdata,state:State,id:id}
	  	if(!submitdata.start_points){
	  		submitdata  = {...submitdata,start_points:0}
	  	}
	  	if(!submitdata.renewal_points){
	  		submitdata  = {...submitdata,renewal_points:0}
	  	}
	  	let message = 'success'
	  	for(var key in submitdata) {
		    if(submitdata[key]==='') {
		      delete submitdata[key]
		    }
		} 
		if(submitdata.id && submitdata.id>0){
			try{
				await patchmembership(submitdata,Token)
				this.info(message)
				this.setState({ submitdata:'',id:'' })
			  	this.props.callbackParent(true);
		  		this.onClose()
			}catch(error){
				if (error.response) {
		      	console.log(error.response.data);
		      	console.log(error.response.status);
		      	message = error.response.status+ 'name is required'
		      	this.info(message)
		   		}
			}
	    }else{
	   		try{
				await postmembership(submitdata,Token)
				message = 'success'
				this.info(message)
				this.setState({ submitdata:'',id:'' })
			  	this.props.callbackParent(true);
		  		this.onClose()
			}catch(error){
				if (error.response) {
		      	console.log(error.response.data);
		      	console.log(error.response.status);
		      	message = error.response.status+ 'name is required'
				this.info(message)
		   		}
			}
	    }
   }
	async handlesavedata(){
    	this.handledata(0)
    }
	async handleCreatedata(){
    	this.handledata(1)
    }
	submitdatachange=(e)=>{
	  	let {submitdata} = this.state
	  	let value = e.target.value
	  	let name  = e.target.name
	  	submitdata = {...submitdata,[name]:value}
	  	this.setState({ submitdata })
  	}
	tochange=(item)=>{
 	  	if(item.state===0){
 	  		item.state='processing'
 	  	}else if(item.state===1){
 	  		item.state='launched'
 	  	}else if(item.state===2){
 	  		item.state='archived'
 	  	}
	}
	async onChangedata(pagination,filters){
		if(pagination){
			filters={
				page:pagination.current,
				page_size:6
			}
		}
		
		this.props.callbackParent2(filters);
	}
    render() {
  	let { Drawerdata,voucher,unimembership,visible,univoucher,univoucher2 } = this.state
  	let {count,membership,drawerdata,page }=this.props
  	if( drawerdata===true ){
  		visible    = drawerdata
  		Drawerdata = 2
  	}
  
  	const pagenation = {
  		   current:page,
  		   hideOnSinglePage:true,
  		   total:count,
  		   pageSize: 6
  		}
  	let	 Membership=[]
  	if(membership && membership.length>0){
  	 	membership.map((item,index)=>{
  	 		this.tochange(item)
 			return Membership.push({  
		 	key: item.id,
			name:item.name,
			start_points:item.start_points,
			renewal_points: item.renewal_points,
			num_of_membership:item.num_of_membership,
			state:item.state,
			Action:(<Button value={item.id} onClick={this.showDrawer.bind(this)}>Details</Button>)
		 	})
		 })
  	 	
  	}
  	
  	const children = [];
	voucher.map((item,index)=>(
  		children.push(<Option key={item.id}>{item.name}</Option>)
  	))
  	const columns = [{
		  title: 'Rank Name',
		  dataIndex: 'name',
		}, {
		  title: 'Start Points',
		  dataIndex: 'start_points',
		}, {
		  title: 'End Points',
		  dataIndex: 'renewal_points',
		}, {
		  title: 'Num of Member',
		  dataIndex: 'num_of_membership',
		}, {
		  title: 'State',
		  dataIndex: 'state',
		}, {
		  title: 'Action',
		  dataIndex: 'Action',
		}];
   
    return (
		<div >
			<Table 
	        columns={columns} 
	        dataSource={Membership}
	        onChange={this.onChangedata.bind(this)}
	        pagination={ pagenation }
          />
			
			{ visible ? 
			<Drawer
	          width={520}
	          placement="right"
	          onClose={this.onClose}
	          maskClosable={false}
	          visible={visible}
	        >
	    		
	    	   <div  style={{ display:  Drawerdata===1 ? "block" : "none"  }}  className='rules'>
	          <h2>Name</h2>
	          <p>{unimembership.name ? unimembership.name : 'null'}</p>
	          <hr/>
	          <h2>Description</h2>
	          <p>{unimembership.description ? unimembership.description : 'null'}</p>
	          <hr/>
	          <h2>Complimentary coupon</h2>
	          <p>{unimembership.complimentary_vouchers ? univoucher + '' : 'null'}</p>
	          <hr/>
			  <h2>Birthday coupon</h2>
			  <p>{unimembership.birthday_vouchers ? univoucher2 + '' : 'null'}</p>
	          <hr/>
			  <ul className='rulesUl'>
			  	  <li>Upgrade condition : Start point:<span >{unimembership.start_points ? unimembership.start_points : ''}</span></li>
				  <li><span>{unimembership.renewal_points ? unimembership.renewal_points : ''}</span>
				  bubble points every 12 months for free renewal </li>
				  <li>Complimentary 1 M size drink on the menu for every accumulation of &nbsp;&nbsp;&nbsp;&nbsp;
				  <span>{unimembership.complimentary_m_drink_points ? unimembership.complimentary_m_drink_points : ''}</span>
				  bubble points</li>
				  <li>The bubble points will be reset upon anniversary date.</li>
				  <li>The unredeemed bubble points accumulated will be automatically
	 				  &nbsp;&nbsp;&nbsp;converted to free M size drink voucher in accordance to the
					  membership &nbsp;&nbsp;&nbsp;tiers on anniversary date just before reset.</li>
				  <li>The free/complimentary drink will be given in voucher form.</li>
			  </ul>
	          <div className='drawercentainbtn'>
	            <Button className='btn1'   onClick={this.toEdit} >{this.state.bottonname2}</Button>
	            <Button  className='btn2'  onClick={this.Archived}>{this.state.bottonname}</Button>
	          </div>
	          </div>
	    	  
	    	  
	    	  
	    	  
	    	  
	    	  <div  style={{ display:  Drawerdata===2 ? "block" : "none"  }}  className='rules'>
	          <h2>Name</h2>
	          <input 
	          autoComplete="off"
	          placeholder={unimembership.name ? unimembership.name : "Please type the name of the rank"}
	          name='name' 
	          onChange={this.submitdatachange}/>
	          <h2>Description</h2>
	          <textarea 
	          placeholder={unimembership.description ? unimembership.description : "Please describe the coupon"}
	          name='description' 
	          onChange={this.submitdatachange}>
	          </textarea>
	          <h2>Complimentary coupon</h2>
	          <Select
	            placeholder={univoucher.length>0 ? univoucher + '' : "Please choose the coupon"}
			    mode="multiple"
			    style={{ width: '103%',marginLeft: "-9px" }}
			    onChange={(value)=>this.handlecoupons(value,'complimentary_vouchers')}
			  >
			    {children}
			  </Select>
			  <h2>Birthday coupon</h2>
	          <Select
	           placeholder={univoucher2.length>0 ? univoucher2 + '' : "Please choose the coupon"}
			    mode="multiple"
			    style={{ width: '103%',marginLeft: "-9px" }}
			    onChange={(value)=>this.handlecoupons(value,'birthday_vouchers')}
			  >
			    {children}
			  </Select>
			  <ul className='rulesUl'>
			  	  <li>Upgrade condition : Start point:
				  <input  
				  type='number' 
				  placeholder={unimembership.start_points ? unimembership.start_points : ""}
				  name='start_points' 
				  onChange={this.submitdatachange}/>
				  </li>
				  <li>
				  <input
				  placeholder={unimembership.renewal_points ? unimembership.renewal_points : ""}
				  type='number' 
				  name='renewal_points' 
				  onChange={this.submitdatachange}/>
				  bubble points every 12 months for free renewal </li>
				  <li>Complimentary 1 M size drink on the menu for every accumulation of &nbsp;&nbsp;&nbsp;
				  <input 
				  placeholder={unimembership.complimentary_m_drink_points ? unimembership.complimentary_m_drink_points : ""}
				  type='number' 
				  name='complimentary_m_drink_points' 
				  onChange={this.submitdatachange}/>
				  bubble points</li>
				  <li>The bubble points will be reset upon anniversary date.</li>
				  <li>The unredeemed bubble points accumulated will be automatically
	 				  &nbsp;&nbsp;&nbsp;converted to free M size drink voucher in accordance to the
					  membership  &nbsp;&nbsp;&nbsp;tiers on anniversary date just before reset.</li>
				  <li>The free/complimentary drink will be given in voucher form.</li>
			  </ul>
			  
	          <div className='drawercentainbtn'>
	            <Button className='btn1' onClick={this.handlesavedata.bind(this)}>
	              Save
	            </Button>
	            <Button onClick={this.handleCreatedata.bind(this)} className='btn2'>Create</Button>
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
	        </Drawer >   : ''  }
			
			
			
			
			
			
		</div>    	
       );
  }
}

export default Center;
