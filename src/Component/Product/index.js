import React from 'react';
import './index.css';
import 'antd/dist/antd.css';
import { DatePicker,Table   } from 'antd';

const { RangePicker } = DatePicker;
const myDate = new Date();

class Center extends React.Component {
	state = {
		search    :'',
		page      :1,
		dateActive:[false,false,false]
	}

    dateChange(mode){
  		const min_transact_datetime=mode[0]
		const max_transact_datetime=mode[1]
  		this.handledata(min_transact_datetime,max_transact_datetime)
  		this.setState({ dateActive:[false,false,false] })
	}
    monthselect=()=>{
    	this.setState({ dateActive:[true,false,false] })
  		const getMonth = myDate.getMonth()
		const getYear = myDate.getFullYear()
		const Newdate = new Date(getYear, getMonth, 0)
		const daycount = Newdate.getDate()
		const min_transact_datetime=`${getYear}-${getMonth}-1`
		const max_transact_datetime=`${getYear}-${getMonth}-${daycount}`
  		this.handledata(min_transact_datetime,max_transact_datetime)
  	}
	quarterselect=()=>{
		this.setState({ dateActive:[false,true,false] })
		const month = myDate.getMonth()
  		const quarter = Math.floor( ( month % 3 === 0 ? ( month / 3 ) : ( month / 3 + 1 ) ) )-1
  		const getYear = myDate.getFullYear()
  		const startmonth=(quarter-1)*3+1
  		const endmonth  = quarter*3
  		const endmonthday = (endmonth===3 || endmonth===12) ? 31 : 30
  		const min_transact_datetime=`${getYear}-${startmonth}-1`
		const max_transact_datetime=`${getYear}-${endmonth}-${endmonthday}`
  		this.handledata(min_transact_datetime,max_transact_datetime)
  	}
    yearselect=()=>{
    	this.setState({ dateActive:[false,false,true] })
  		const getYear = myDate.getFullYear()-1
  		const min_transact_datetime=`${getYear}-1-1`
		const max_transact_datetime=`${getYear}-12-31`
  		this.handledata(min_transact_datetime,max_transact_datetime)
    }
    inputchange=(e)=>{
  	let inputvalue = e.target.value
  	    this.setState({
	  	search: inputvalue,
	  	})
  	}
    handledata=(min_transact_datetime,max_transact_datetime)=>{
	 	const data={
	 		min_transact_datetime:min_transact_datetime,
	 		max_transact_datetime:max_transact_datetime
	 	}
	 	this.props.callbackParent(data);
	 }
    handleinputdata=(search)=>{
	 	const data={
	 		search:search
	 	}
	 	this.props.callbackParent(data);
	 }
    async handletext(){
    	const search = this.state.search
    	 this.handleinputdata(search)  
    	 this.setState({
    	 	  search:''
    	 })
    }
    onTableChange=(pagination, filters, sorter)=> {	  
	  let data={page:1}
	  if(pagination.current!==this.props.page){
	  	data={page:pagination.current,page_size: 6}
	  	this.props.callbackParent(data);
	  }
	}
    render() {
  		let { data,count,page } = this.props
  		let { dateActive }	    = this.state
  		const Page       = page
  		const Count      = count
  		const pagenation = {
  			current:Page,
  			total:Count,
  			pageSize: 2
		}
	  	let	 Data=[]
	  	if(data && data.length>0){
	  	data.map((item,index)=>(
	 			Data.push({  
			 	key: index,
				Product:item.name,
				Price:item.price,
				Type: item.category_name,
				Tea_base:item.tea_base,
				Toppings:item.toppings,
				Sweetness:item.sugar_level,
				Ice_level: item.ice_level,
				Size:item.size,
				Amount:item.amount
			 	})
			))
	  	}
  	
	  	const columns = [{
			  title: 'Product',
			  dataIndex: 'Product',
			}, {
			  title: 'Price',
			  dataIndex: 'Price',
			}, {
			  title: 'Type',
			  dataIndex: 'Type',
			}, {
			  title: 'Tea_base',
			  dataIndex: 'Tea_base',
			}, {
			  title: 'Size',
			  dataIndex: 'Size',
			}, {
			  title: 'Amount',
			  dataIndex: 'Amount',
			}];
   
    return (
		<div className="cent" >
			<div className="c" >
				<h3 >Product sales record</h3>
				<div className="btn-group" >
				  <button  type="button" className={dateActive[0] ? "btn btn-default dateActive" : "btn btn-default"} 
				  	onClick={this.monthselect}>month</button>
				  <button type="button" className={dateActive[1] ? "btn btn-default dateActive" : "btn btn-default"}
				  	onClick={this.quarterselect}>quarter</button>
				  <button type="button" className={dateActive[2] ? "btn btn-default dateActive" : "btn btn-default"}
				  	onClick={this.yearselect}>year</button>
				</div >
				   <RangePicker 
				   style={{marginLeft:'20px'}}
				   className="date"
				   format="YYYY-MM-DD"
				   placeholder={['Commence', 'End']}
				   onChange={(value,mode)=>{this.dateChange(mode)}}
				   />
				<div className="input-group col-md-2 search">
				      <input type="text" 
				      autoComplete="off"
				      className="form-control" 
				      placeholder="Search ..." 
				      name='search'
				      value={this.state.search}
				      onChange={e => this.inputchange(e)}
				      />
				      <span className="input-group-btn">
				        <button className="btn btn-default searchBtn" type="button" onClick={this.handletext.bind(this)}>
				        <i className="fa fa-search" ></i>
				        </button>
				      </span>
				  </div>
			</div>
			<Table 
	        columns={columns} 
	        dataSource={Data}
	        onChange={
	        	this.onTableChange
	        }
	         pagination={ pagenation }
          />
		</div>    	
       );
  }
}

export default Center;
