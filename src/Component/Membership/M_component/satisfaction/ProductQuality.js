import React from 'react';
import { Table,Icon,Checkbox } from 'antd';
import Cookies from 'js-cookie';
import {reqcategory } from '../../../../api/requrl';

class ProductQuality extends React.Component {
	state={
		category:[]
	}
	async componentDidMount() {
		const Token = Cookies.get("Authorization")
		let req2 = await reqcategory(Token,{page_size:100})
		let category   = req2.data.results
		this.setState({
			category
		})
  	}
	onselectChange(e){
		let data  = {category_name:e}
		this.props.callbackParent(data)
	}
	onTableChange=(pagination, filters, sorter)=> {	  
	 let data = {}
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
	  this.props.callbackParent(Data)
	  }
	}
    render() {
    const { category }=  this.state
    const { productdata,productcount,page }=  this.props
	let productData  = []
	let Category  = []
	if(productdata && productdata.length>0){
		 productdata.map((item,index)=>(
 			productData.push({  
		 	  key: item.id,
			  ProductName:item.name,
			  Type:item.category.name,
			  Satisfaction: item.satisfaction,
		 	})
		 ))
	}
	category.map((item)=>(
		Category.push(<li key={item.id}><Checkbox value={item.id} >{item.name}</Checkbox></li>)
	))
  	const data=productData
  	let pagenation = {
  		total:productcount,
  		pageSize: 6,
  		current:page,
  	}
	const columns = [{
		  title: 'Product Name',
		  dataIndex: 'ProductName',
		  
		}, {
		  title: 'Type',
		  dataIndex: 'Type',
		  filterDropdown: <div className="tabledropdown"><Checkbox.Group onChange={(e)=>this.onselectChange(e)} >
		  <ul>{Category}</ul></Checkbox.Group></div>,
		  filterIcon: <Icon type="filter" className="dropdownIcon" />
		  
		},{
		  title: 'Satisfaction',
		  dataIndex: 'Satisfaction',
		  defaultSortOrder: 'descend',
		  onFilter: (value, record) => record.Satisfaction.indexOf(value) === 0,
  		  sorter: (a, b) => a.value - b.value,
		}];
    	return(
		    <Table 
	        columns={columns} 
	        dataSource={data} 
	        onChange={this.onTableChange}
	        pagination={pagenation}
	        
          />
    	)
  }
}

export default ProductQuality;