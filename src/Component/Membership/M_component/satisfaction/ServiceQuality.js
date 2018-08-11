import React from 'react';
import { Table,Icon,Checkbox } from 'antd';
import Cookies from 'js-cookie';
import {reqoutletName } from '../../../../api/requrl';

class ServiceQuality extends React.Component {
	state={
		outlettype:[]
	}
	onselectChange(e){
		let data  = {outlet_name:e}
		this.props.callbackParent(data)
	}
	async componentDidMount() {
		const Token = Cookies.get("Authorization")
		let req2 = await reqoutletName(Token,{paze_size:100})
		let outlettype   = req2.data.results
		this.setState({
			outlettype
		})
  	}
	onTableChange=(pagination, filters, sorter)=> {	  
	  	let data ={}
	  	if(pagination.current!==this.props.page){
  			let data={page:pagination.current,page_size:6}
	  		this.props.callbackParent(data);
	  	}else{
	  	let type = '',
	      	name = ''
	  	if(sorter.order==='descend'){
  			type = '-'
	 	 }
	 	 if(sorter.columnKey==='Satisfaction'){
	  		name= 'satisfaction'
	  	}
 		let ordering = type + name
	 	let Data = {...data,ordering}
	  	this.props.callbackParent(Data);
	  	}
	}
    render() {
	    let { outlettype}=  this.state
	    let { outlet,outletcount,page }=  this.props
		let outletData  = []
		let Outlettype  = []
		if(outlet && outlet.length>0){
			 outlet.map((item,index)=>(
	 			outletData.push({  
			 	  key: item.id,
				  Outlets: item.outlet_name,
				  Manger:item.outlet_manager,
				  Satisfaction: item.satisfaction,
				  Address:item.outlet_address
			 	})
			 ))
		}
		outlettype.map((item)=>(
			Outlettype.push(<li key={item.outlet_name}><Checkbox value={item.outlet_name} >{item.outlet_name}</Checkbox></li>)
		))
		let pagenation = {
	  		total:outletcount,
	  		pageSize: 6,
	  		current:page,
	  	}
		 const columns = [{
			  title: 'Outlets',
			  dataIndex: 'Outlets',
			  filterDropdown: <div className="tabledropdown"><Checkbox.Group onChange={(e)=>this.onselectChange(e)} >
			  <ul>{Outlettype}</ul></Checkbox.Group></div>,
			  filterIcon: <Icon type="filter" className="dropdownIcon" />
			}, {
			  title: 'Manger',
			  dataIndex: 'Manger',
			  
			},{
			  title: 'Satisfaction',
			  dataIndex: 'Satisfaction',
			  defaultSortOrder: 'descend',
			  onFilter: (value, record) => record.Satisfaction.indexOf(value) === 0,
	  		  sorter: (a, b) => a.value - b.value,
			}, {
			  title: 'Address',
			  dataIndex: 'Address',
			 }];
    	return(
		    <Table 
	        columns={columns} 
	        dataSource={outletData} 
	        onChange={this.onTableChange}
	        pagination={pagenation}
          />
    	)
	  }
}

export default ServiceQuality;