import React from 'react';
import { Table,DatePicker,Checkbox,Icon } from 'antd';
import Cookies from 'js-cookie';
import { Link } from 'react-router-dom';
import {reqdatamembership,requinmember} from '../../../api/requrl';
import './information.css'

const {RangePicker}=DatePicker
class Information extends React.Component {
	async componentDidMount() {
		const token = Cookies.get("Authorization")
		let req  = await reqdatamembership({page_size:999},token)
		let membership = req.data.results
		this.setState({ membership })
  	}
	state = {
      key:'',
      membership:'',
      value:'',
      data:{
      	page:1,
      	page_size:6
      }
     };
     handleData=(recoder)=>{
     	
     }
	async onChangedata(pagination,filters){
		const Token = Cookies.get("Authorization")
		let data = this.state.data
		if(pagination){
			filters={
				page:pagination.current,
				page_size:6
			}
		}
		let Data={...data,...filters}
		if(!filters.race_exclude ) {
		      delete Data.race_exclude
		 }
		for(let key in Data) {
		    if(Data[key].length===0) {
		      delete Data[key]
		    }
		 }
		let req  = await requinmember(Data,Token)
		let reqdata  = req.data.results
		let   count = req.data.count
			this.setState({
				data:Data
			})
		this.props.callbackParent(reqdata,count);
	}
	async datechange(name1,name2,mode){
		const Token = Cookies.get("Authorization")
		let data = this.state.data
		let Data = {...data,[name1]:mode[0],[name2]:mode[1],page:1}
		 for(var key in Data) {
		    if(Data[key]==='' || Data[key].length===0) {
		      delete Data[key]
		    }
		 }
		let req  = await requinmember(Data,Token)
		let reqdata  = req.data.results
		let count = req.data.count
			this.setState({
				data:Data
			})
		this.props.callbackParent(reqdata,count);
	}
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
    	const Token = Cookies.get("Authorization")
        let {data,value} = this.state
        let Data ={...data,page:1,search:value}
        for(let key in Data) {
		    if(Data[key]==='') {
		      delete Data[key]
		    }
		 }
		let req  = await requinmember(Data,Token)
		let reqdata  = req.data.results
		let count = req.data.count
			this.setState({
				data:Data,
				value:''
			})
		this.props.callbackParent(reqdata,count);
    }
    async requinmember(Data){
    	const Token = Cookies.get("Authorization")
    	let data = this.state.data
    	    Data ={...data,page:1,...Data}
        for(let key in Data) {
		    if(Data[key].length===0) {
		      delete Data[key]
		    }
		 }
		let req  = await requinmember(Data,Token)
		let reqdata  = req.data.results
		let count = req.data.count
			this.setState({
				data:Data
			})
		this.props.callbackParent(reqdata,count);
    }
    onselectChange=(e)=>{
		let Data = {}
		if(e.indexOf("Other")!==-1){
			const RE_race=`${e.indexOf("Malay")===-1 ? 'Malay,' : ''}${e.indexOf("Chinese")===-1 ? 'Chinese,' : ''}${e.indexOf("Indian")===-1 ? 'Indian' : ''}`.trim()
			Data={race_exclude:RE_race,race:''}
		}else{
			Data={race:e,race_exclude:''}
		}
		this.requinmember(Data)
	}
    onselectChange2=(e)=>{
		let Data={
				membership_name:e,
			}
		this.requinmember(Data)
	}
    render() {
     let {  membership,data } = this.state;
     const page = data.page
     let   Race = []
     const { name,count }=this.props
	 const Data  = name
	 const pagenation = {
  		   current:page,
  		   hideOnSinglePage:true,
  		   total:count,
  		   pageSize: 6
  		}
     let Membership = [];
     if(membership && membership.length>0){
     	  membership.map((item,index)=>(
     	  	Membership.push(<li key={item.name}><p><Checkbox value={item.name} >{item.name}</Checkbox></p></li>)
     	  ))
     }
	Race.push(<li key='Chinese'><Checkbox value='Chinese' >Chinese</Checkbox></li>)
	Race.push(<li key='Indian'><Checkbox value='Indian' >Indian</Checkbox></li>)
	Race.push(<li key='Malay'><Checkbox value='Malay' >Malay</Checkbox></li>)
	Race.push(<li key='Other'><Checkbox value='Other' >Other</Checkbox></li>)
	const columns = [{
		  title: 'Name',
		  dataIndex: 'name',
		  render: (text,recoder)=> <Link  to={"/informationdetail?"+recoder.key} >
		  <div onClick={this.handleData.bind(this,recoder)}>{text}</div></Link>
		}, {
		  title: 'Race',
		  dataIndex: 'Race',
		  filterDropdown: <div className="tabledropdown" style={{ minWidth: '100px' }}>
		  <Checkbox.Group onChange={this.onselectChange} ><ul>{Race}</ul></Checkbox.Group></div>,
		  filterIcon: <Icon type="filter" className="dropdownIcon"/>
		  
		},{
		  title: 'Membership Level',
		  dataIndex: 'MembershipLevel',
		  filterDropdown: <div className="tabledropdown"><Checkbox.Group onChange={this.onselectChange2} >
		  <ul>{Membership}</ul></Checkbox.Group></div>,
		  filterIcon: <Icon type="filter" className="dropdownIcon"/>
     	  
		}, {
		  title: 'Registration Date',
		  dataIndex: 'registration_date',
		  filterDropdown: <span></span>,
          filterIcon: <RangePicker onChange={(value,mode)=>{this.datechange('min_registration_date','max_registration_date',mode)}} />
		},{
		  title: 'Latest Purchase Time',
		  dataIndex: 'last_purchase_date',
		  filterDropdown: <span></span>,
          filterIcon: <RangePicker  onChange={(value,mode)=>{this.datechange('min_last_purchase_date','max_last_purchase_date',mode)}}/>
		}];
 	
  	
    return (
    	<div className='information'>
		    <div className="input-group col-md-2 search">
				<input 
				type="text" 
				className="form-control" 
				placeholder="Search ..." 
				autoComplete="off"
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
	        <Table 
	        	style={{ overflow: 'hidden'  }}
		        columns={columns} 
		        dataSource={Data} 
		        onChange={this.onChangedata.bind(this)}
		        pagination={ pagenation }
	          />
        </div>
    );
  }
}

export default Information;