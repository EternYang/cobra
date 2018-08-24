import React from 'react';
import { Table,DatePicker } from 'antd';
import './Ewallet.css';

const {RangePicker}=DatePicker
class Ewallet extends React.Component {
	state={
		value:''
	}
	onChange=(pagination, filters, sorter)=> {
	  if(pagination.current!==this.props.page){
	  	let data={
			page:pagination.current,
			page_size:6
		}
	  	this.props.callbackParent(data);
	  }else{
	  let type = '',
	      name = 'total_consumption'
	  if(sorter.order==='descend'){
	  	type = '-'
	  }
	  if(sorter.columnKey==='EWB'){
	  	name= 'balance'
	  }
	  let ordering = type + name
	  let data = {
	  	ordering
	  }
	  this.props.callbackParent(data);
	  }
		  
	}
	async datechange(name1,name2,mode){
		let Data = {[name1]:mode[0],[name2]:mode[1],page:1}
		this.props.callbackParent(Data);
	}
	inputchange=(e)=>{
  	let inputvalue = e.target.value
    this.setState({
		value:inputvalue
		})
  	}
	async handletext(){
		const value = this.state.value
		const data = {
			search:value
		}
		this.props.callbackParent(data);
		this.setState({
			value:''
		})
    }
    render() {
  	const 	{ name,count,page }=this.props
  	const data=name
  	const pagenation = {
  		   current:page,
  		   hideOnSinglePage:true,
  		   total:count,
  		   pageSize: 6
  		}
	 const columns = [{
		  title: 'Member Name',
		  dataIndex: 'MemberName',
		
		}, {
		  title: 'Total Consumption$',
		  dataIndex: 'TotalConsumption',
		  sorter: (a, b) =>{}
		},{
		  title: 'E-wallet Balance$',
		  dataIndex: 'EWB',
		  sorter: (a, b) =>{}
		  
		}, {
		  title: 'Latest Top Up Date',
		  dataIndex: 'LTUD',
		  defaultSortOrder: 'descend',
		  filterDropdown: <span></span>,
          filterIcon: <RangePicker onChange={(value,mode)=>{this.datechange('min_lastest_top_up','max_lastest_top_up',mode)}} />
		}];
		
    return (
    	<div className='Ewallet'>
	    	 <div className="input-group col-md-2 search">
					<input 
					type="text" 
					className="form-control" 
					placeholder="Search ..." 
					name='search'
					autoComplete="off"
			        value={this.state.value}
			        onChange={e => this.inputchange(e)}
					/>
					<span className="input-group-btn">
				    <button className="btn btn-default searchBtn" type="button" onClick={this.handletext.bind(this)}>
			        <i className="fa fa-search" ></i>
			        </button>
					</span>
				</div>
	        <Table columns={columns} dataSource={data} onChange={this.onChange}  pagination={ pagenation }/>
   		</div>
    );
  }
}

export default Ewallet;