import React from 'react';
import './index.css';
import { DatePicker,Table,Avatar,Icon   } from 'antd';
import { Link } from 'react-router-dom';
const { RangePicker } = DatePicker;
const myDate = new Date();

class Center extends React.Component {
 	state = {
		search:'',
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
    async onChange(current, pageSize){ 
          const data={
	 		page:current,
	 		page_size:6
	 	}
	 	this.props.callbackParent(data);
        }
  render() {
  	let {count,page,member,classicmembership,transaction}=this.props
  	let { dateActive }	    = this.state
  	const Page = page
  	const Count = count
  	const pagenation = {
  		current:Page,
  		hideOnSinglePage:true,
  		total:Count,
  		pageSize: 6,
  		onChange:this.onChange.bind(this),
  		onShowSizeChange:this.onShowSizeChange
  		
  	}
  	
  	let	 Transaction=[]
  	if(transaction && transaction.length>0){
  	 transaction.map((item,index)=>(
 			Transaction.push({  
		 	key: item.id,
			Product:item.product.name,
			Price:item.price,
			Type: item.product.category.name,
			Tea_base:item.product.tea_base,
			Toppings:item.toppings.name,
			Sweetness:item.sweetness,
			Ice_level: item.ice_level,
			Size:item.product.size,
			Amount:item.quantity
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
		  title: 'Toppings',
		  dataIndex: 'Toppings',
		}, {
		  title: 'Sweetness',
		  dataIndex: 'Sweetness',
		}, {
		  title: 'Ice_level',
		  dataIndex: 'Ice_level',
		}, {
		  title: 'Size',
		  dataIndex: 'Size',
		}, {
		  title: 'Amount',
		  dataIndex: 'Amount',
		}];
   
    return (
		<div className="cent" >
			<div>
			<Link  to={"/Membership"} className="back" ><h5><Icon type="arrow-left" />&nbsp;Back to Membership Information</h5></Link>
				<h3 >Details</h3>
				<div className='detail'>
					<div>
					<Avatar icon="user" className='detail_avatar'/>
					</div>
					<div className='detail_font'>
					<h5>ID:{member.id}</h5>
					<h4>{member.username} &nbsp;&nbsp;<span>Point:{member.points_bal}</span>&nbsp;&nbsp;<span>{classicmembership}</span></h4>
					<p>Birthday:{member.dob} &nbsp;&nbsp;<span>Tel:{member.telephone}&nbsp;&nbsp;</span><span>Email:{member.email}&nbsp;&nbsp;</span></p>
					</div>
				</div>
				<div className="btn-group" >
				  <button type="button" className={dateActive[0] ? "btn btn-default dateActive" : "btn btn-default"} 
				   onClick={this.monthselect}>month</button>
				  <button type="button"  className={dateActive[1] ? "btn btn-default dateActive" : "btn btn-default"} 
				   onClick={this.quarterselect}>quarter</button>
				  <button type="button"  className={dateActive[2] ? "btn btn-default dateActive" : "btn btn-default"} 
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
				      className="form-control" 
				      placeholder="Search ..." 
				      name='search'
				      autoComplete="off"
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
	        dataSource={Transaction}
	        onChange={
	        	this.pagechange
	        }
	         pagination={ pagenation }
          />
		</div>    	
       );
  }
}

export default Center;
