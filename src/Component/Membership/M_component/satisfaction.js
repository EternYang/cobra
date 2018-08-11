import React from 'react';
import { Tabs } from 'antd';
import Cookies        from 'js-cookie';
import { reqproduct,reqoutlet,requniproductname,reqoutletbydata } from '../../../api/requrl';
import ServiceQuality from './satisfaction/ServiceQuality';
import ProductQuality from './satisfaction/ProductQuality';
const TabPane = Tabs.TabPane;

class Satisfaction extends React.Component {
	state={
		productdata       :'',
		productcount  :'',
		outlet            :'',
		outletcount       :'',
		productsubmitdata :'',
		outletsubmitdata  :'',
		value			  :'',
		activeKey		  : '1'
	}
	async componentDidMount() {
		const Token = Cookies.get("Authorization")
		let req         = await reqproduct(Token)
		let req2        = await reqoutlet(Token)
		let productdata = req.data.results,
			productcount= req.data.count,
		    outletcount = req2.data.count,
		    outlet      = req2.data.results
		this.setState({
			productdata,
			outlet,
			outletcount,
			productcount
		})
  	}
     async onChildChanged(data) {
    	const Token = Cookies.get("Authorization")
		if(!data.page) {
			data.page = 1
		}
		let {outletsubmitdata} = this.state
		data = { ...outletsubmitdata,...data,page_size:6 }
		 for(let key in data) {
		    if(data[key].length===0) {
		      delete data[key]
		    }
		 }
		let req = await reqoutletbydata(data, Token)
		let outlet      = req.data.results,
			outletcount = req.data.count
			this.setState({
				outlet,
				outletcount,
				outletsubmitdata:data
			})
	}
    async onChildChanged2(data) {
    	const Token = Cookies.get("Authorization")
		if(!data.page) {
			data.page = 1
		}
		let {productsubmitdata} = this.state
		data = { ...productsubmitdata,...data,page_size:6 }
		 for(let key in data) {
		    if(data[key].length===0) {
		      delete data[key]
		    }
		 }
		let req = await requniproductname (data, Token)
		let productdata  = req.data.results,
			productcount = req.data.count
			this.setState({
				productdata,
				productcount,
				productsubmitdata:data
			})
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
        let {data,activeKey,value} = this.state
        let Data ={...data,page:1,page_size:6,search:value}
        if(activeKey==='1'){
        	this.onChildChanged(Data)
        }else if(activeKey==='2'){
        	this.onChildChanged2(Data)
        }
        this.setState({ value:'' })
    }
    activeKeychange=(activeKey)=>{
    	this.setState({ activeKey })
    }
    render() {
    	let { productdata,productcount,outlet,outletcount,productsubmitdata,outletsubmitdata } = this.state
    	return(
    		<div className='walletcoupon'>
    		<div className="input-group col-md-2 search" style={{ position: "absolute",right:"0" }} >
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
			<Tabs  type="card" activeKey={this.state.activeKey} onChange={this.activeKeychange}>
			    <TabPane tab="Service-Quality" key="1">
			    <ServiceQuality 
			    callbackParent={this.onChildChanged.bind(this)}
			    outletcount={outletcount}
			    outlet={outlet} 
			    page={outletsubmitdata.page}/>
			    </TabPane>
			    <TabPane tab="Product-Quality" key="2">
			    <ProductQuality 
			    callbackParent={this.onChildChanged2.bind(this)}
			    productcount={productcount}
			    productdata={productdata} 
			    page={productsubmitdata.page}/>
			    </TabPane>
			</Tabs>
			
			</div>
    	)
  }
}

export default Satisfaction;