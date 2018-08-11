import React from 'react';
import { Table,Icon,Checkbox } from 'antd';
import { reqDistrict } from '../../api/requrl';
import Cookies from 'js-cookie';
class Store extends React.Component {
	state={
		District:[],
	}
	async componentDidMount() {
   	    const Token   = Cookies.get("Authorization")
		let   req      = await reqDistrict(Token)
		let District   = req.data.results
		this.setState({
			District
		})		
   }
	onTableChange=(pagination, filters, sorter)=> {	  
	  let data={page:1}
	  if(pagination.current!==this.props.page){
	  	data={page:pagination.current,page_size: 6}
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
	  if(sorter.columnKey==='Transactions'){
	  	name= 'transactions'
	  }
	  if(sorter.columnKey==='transactions_incr'){
	  	name= 'transactions_incr'
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
    	let { storecount,store,page,District }=  this.props
	 	let Store     = []
	 	let district  = []
		if(store && store.length>0){
			 store.map((item,index)=>(
				  Store.push({  
			 	  key: index,
				  outlet_name:item.outlet_name,
				  outlet_manager:item.outlet_manager,
				  outlet_district: item.outlet_district,
				  turnover:item.turnover,
				  turnover_incr:item.turnover_incr,
				  transactions: item.transactions,
				  products_sold:item.products_sold,
				  Transactions:item.transactions,
				  transactions_incr: item.transactions_incr,
			 	})
			 ))
		}
		if(District && District.length>0){
			District.map((item)=>(
				district.push(<li key={item.id}><Checkbox value={item.id} >{item.name}</Checkbox></li>)
			))
		}
		let pagenation = {
  		current:page,
  		hideOnSinglePage:true,
  		total:storecount,
  		pageSize: 6
  		}
		const columns = [{
			  title: 'Branch Name',
			  dataIndex: 'outlet_name',
			  
			}, {
			  title: 'Manager ',
			  dataIndex: 'outlet_manager',
			  
			},{
			  title: 'District',
			  dataIndex: 'outlet_district',
			  filterDropdown: <div className="tabledropdown"><Checkbox.Group onChange={(e)=>this.onselectChange(e,'outlet_district')} >
		      <ul>{district}</ul></Checkbox.Group></div>,
		      filterIcon: <Icon type="filter" className="dropdownIcon"/>
			},{
			  title: 'Turnover$',
			  dataIndex: 'turnover',
			  sorter: (a, b) =>{}
			},{
			  title: 'Turnover Incr(mom)',
			  dataIndex: 'turnover_incr',
			  sorter: (a, b) =>{}
			},{
			  title: 'Transactions',
			  dataIndex: 'transactions',
			  sorter: (a, b) =>{}
			},{
			  title: 'Product Sold',
			  dataIndex: 'products_sold',
			  sorter: (a, b) =>{}
			},{
			  title: 'Cust Count',
			  dataIndex: 'Transactions',
			  sorter: (a, b) =>{}
			},{
			  title: 'Cust Incr(mom)',
			  dataIndex: 'transactions_incr',
			  sorter: (a, b) =>{}
			}];
			
    	return(
		    <Table 
	        columns={columns} 
	        dataSource={Store} 
	        onChange={this.onTableChange}
	        pagination={pagenation}
	        
          />
    	)
  }
}

export default Store;