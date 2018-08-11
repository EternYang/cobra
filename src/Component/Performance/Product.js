import React from 'react';
import { Table,Icon,Checkbox  } from 'antd';
import { reqcategory,reqTeaBase } from '../../api/requrl'
import Cookies from 'js-cookie';
class Product extends React.Component {
	state={
		category:[],
		TeaBase:[]
	}
	async componentDidMount() {
    const Token   = Cookies.get("Authorization")
		let   req      = await reqcategory(Token)
		let   req2     = await reqTeaBase(Token)
		let category   = req.data.results,
		    TeaBase    = req2.data.results
		this.setState({
			category:category,
			TeaBase:TeaBase
		})		
   }
	onTableChange=(pagination, filters, sorter)=> {	  
	  let data={page:1}
	  if(pagination.current!==this.props.page){
	  	data={page:pagination.current}
	  	this.props.callbackParent(data);
	  }else{
	  let type = '',
	      name = ''
	  if(sorter.order==='descend'){
	  	type = '-'
	  }
	  if(sorter.columnKey==='turnover'){
	  	name= 'turnover'
	  }
	  if(sorter.columnKey==='turnover_incr'){
	  	name= 'turnover_incr'
	  }
	  if(sorter.columnKey==='products_sold'){
	  	name= 'products_sold'
	  }
	  if(sorter.columnKey==='products_sold_incr'){
	  	name= 'products_sold_incr'
	  }
	  if(sorter.columnKey==='turnover'){
	  	name= 'turnover'
	  }
	  if(sorter.columnKey==='turnover_incr'){
	  	name= 'turnover_incr'
	  }
	  let ordering = type + name
	  let Data = {...data,ordering}
	  this.props.callbackParent(Data);
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
    const { voucher,vouchercount,page}=  this.props
    let { TeaBase,category } = this.state
	let Voucher   = []
	let Category  = []
	let teaBase   = []
	
	if(voucher && voucher.length>0){
		 voucher.map((item,index)=>(
			  Voucher.push({  
		 	  key: index,
			  name:item.name,
			  Type:item.category.name,
			  tea_base: item.tea_base,
			  products_sold:item.products_sold,
			  products_sold_incr:item.products_sold_incr,
			  turnover: item.turnover,
			  turnover_incr: item.turnover_incr,
		 	})
		 ))
	}
	let pagenation = {
  		current:page,
  		total:vouchercount,
  		pageSize: 6,
  	}
	category.map((item)=>(
		Category.push(<li key={item.id}><Checkbox value={item.id} >{item.name}</Checkbox></li>)
	))
	TeaBase.map((item,index)=>(
		teaBase.push(<li key={index}><Checkbox value={item.tea_base} >{item.tea_base}</Checkbox></li>)
	))
	 const columns = [{
		  title: 'Product Name',
		  dataIndex: 'name',
		  
		}, {
		  title: 'Type',
		  dataIndex: 'Type',
		  filterDropdown: <div className="tabledropdown"><Checkbox.Group onChange={(e)=>this.onselectChange(e,'category_name')} >
		  <ul>{Category}</ul></Checkbox.Group></div>,
		  filterIcon: <Icon type="filter" className="dropdownIcon"/>
		},{
		  title: 'Tea_base ',
		  dataIndex: 'tea_base',
		  filterDropdown: <div className="tabledropdown"><Checkbox.Group onChange={(e)=>this.onselectChange(e,'tea_base')} >
		  <ul>{teaBase}</ul></Checkbox.Group></div>,
          filterIcon: <Icon type="filter"  className="dropdownIcon" />
		},{
		  title: 'Amount ',
		  dataIndex: 'products_sold',
		  sorter: (a, b) =>{}
		},{
		  title: 'Amount Incr(mom)',
		  dataIndex: 'products_sold_incr',
		  sorter: (a, b) =>{}
		},{
		  title: 'Turnover',
		  dataIndex: 'turnover',
		  sorter: (a, b) =>{}
		},{
		  title: 'Turnover Incr(mom) ',
		  dataIndex: 'turnover_incr',
		  sorter: (a, b) =>{}
		}];
		
    	return(
		    <Table 
	        columns={columns} 
	        dataSource={Voucher} 
	        onChange={this.onTableChange}
	        pagination={pagenation}
	        
          />
    	)
  }
}

export default Product;