import React          from 'react';
import Cookies        from 'js-cookie';
import { Tabs,Icon }  from 'antd';
import Top            from '../top/index';
import Product        from './Product';
import Store          from './Store';
import { reqPerformanceProductbyID,reqStorebyID,reqcampaignbyID } from '../../api/requrl';
import { Link }       from 'react-router-dom';
import './index.css';

const TabPane = Tabs.TabPane;
class Performance extends React.Component {
	
	
	state={
		voucher        : [],
		vouchercount   : '',
		store          : [],
		storecount     : '',
		value          : '',
		Key			   : '1',
		storepage      : 1,
		voucherpage    : 1,
		data           : {},
		data2          : {},
	    campaigndata   : {
	    expiring_date  : '',
	    effective_date : ''
	    }
	}
	async componentDidMount() {
		const Token = Cookies.get("Authorization")  
		if(!Token){
		  window.location.href='/login'
		}else{
			let {campaigndata}    = this.state
			let str=window.location.href;
			let id=str.split("?")[1];
			let data = {campaign_id:id}
			let data2= {campaign_id:id}
			let req             = await reqPerformanceProductbyID(data,Token)
			let req2            = await reqStorebyID(data,Token)
			let req3            = await reqcampaignbyID(id,Token)
			let vouchercount    = req.data.count
			let voucher         = req.data.results
			let storecount      = req2.data.count
			let store           = req2.data.results
			let campaigndata2   = req3.data.results
			campaigndata        = {...campaigndata,...campaigndata2}
			this.setState({
			vouchercount,
			voucher,
			storecount,
			store,
			data,
			data2,
			campaigndata
			})
		}
	}
	inputchange=(e)=>{
  	let inputvalue = e.target.value
    this.setState({
		value:inputvalue
		})
  	}
	async handletext(){
		let { value,Key,data,data2 } = this.state
		const Token = Cookies.get("Authorization") 
        if(Key==='1'){
	        data = {...data,search:value}
	        for(let key in data) {
			    if(data[key]==='') {
			      delete data[key]
			    }
			 }
			let req        = await reqStorebyID(data,Token)
			let storecount = req.data.count
			let store      = req.data.results
			this.setState({
				storecount,
				store,
				data,
				value:''
			})
        }
		if(Key==='2'){
			data2 = {...data2,search:value}
	        for(let key in data2) {
			    if(data2[key]==='') {
			      delete data2[key]
			    }
			 }
			let req          = await reqPerformanceProductbyID(data2,Token)
			let vouchercount = req.data.count
			let voucher      = req.data.results
			this.setState({
				vouchercount,
				voucher,
				data2,
				value:''
			})
		}
    }
	async onChildChanged(Data,count){
		const Token = Cookies.get("Authorization") 
		let data = this.state.data
		data = {...data,...Data}
        for(let key in data) {
		    if(data[key]==='') {
		      delete data[key]
		    }
		 }
		let req        = await reqStorebyID(data,Token)
		let storecount = req.data.count
		let store      = req.data.results
		this.setState({
			storecount,
			store,
			data
		})
	}
	async onChildChanged2(Data,count){
		const Token = Cookies.get("Authorization") 
		let data2 = this.state.data2
		data2 = {...data2,...Data}
        for(let key in data2) {
		    if(data2[key].length===0) {
		      delete data2[key]
		    }
		 }
		let req          = await reqPerformanceProductbyID(data2,Token)
		let vouchercount = req.data.count
		let voucher      = req.data.results
		this.setState({
			vouchercount,
			voucher,
			data2
		})
	}
	activeKeychange=(value)=>{
		this.setState({
			Key:value
		})
	}
    render() {
    const { voucher,vouchercount,storecount,store,data,data2,campaigndata }=  this.state
	 
		
		return(
		    <div className='membership performance'>
	    		<Top />
	    		<div className='cent'>
	    		<Link  to={"/Campaign"} className="back" ><h5><Icon type="arrow-left" />&nbsp;Back to Campaign Data Table</h5></Link>
				<h3 className="performantitle">Valentine's Day Event
				<span style={{ fontSize: "12px",fontWeight: "300",  }}>&nbsp; (Validity Period : 
					 { campaigndata.effective_date ? campaigndata.effective_date : ''} 00:00:00 ~ 
					 { campaigndata.expiring_date  ? campaigndata.expiring_date : '' } 00:00:00)
				</span>
	    		</h3>
				<div className="input-group col-md-2 search">
					<input
					type="text" 
					autoComplete="off"
					className="form-control" 
					placeholder="Search ..." 
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
				<Tabs className="PerformanceTab" activeKey={this.state.Key} onChange={this.activeKeychange}>
				    <TabPane tab="Store Performance" key="1">
				    <Store 
				    storecount={storecount} 
				    store={store} 
				    page= {data.page}
				    callbackParent={this.onChildChanged.bind(this)}/>
				    </TabPane>
				    <TabPane tab="Product Performance" key="2">
				    <Product 
				    voucher={voucher} 
				    vouchercount={vouchercount} 
				    callbackParent={this.onChildChanged2.bind(this)}
				    page={data2.page}/>
				    </TabPane>
				 </Tabs>
				</div>
		</div>		
		)
    }
}

export default Performance;