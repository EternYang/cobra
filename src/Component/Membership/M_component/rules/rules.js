import React from 'react';
import Cookies from 'js-cookie';
import { reqmembership,reqdatamembership } from '../../../../api/requrl';
import { Button    } from 'antd';
import Center from './center';

const ButtonGroup = Button.Group;
class Rules extends React.Component {
	state={
		data        : {page:1,page_size:6},
		value       : '',
		count       : '',
		membership  : '',
		drawerdata  : false
		
	}
	async componentDidMount() {
		const Token = Cookies.get("Authorization")  
		if(!Token){
		  window.location.href='/login'
		}else{
			const Token = Cookies.get("Authorization")
			let req        = await reqmembership(Token)
			let count      = req.data.count
			let membership = req.data.results
			this.setState({
				count,
				membership
			})
		}
	}
	async onChildChanged(data) {
		if(data){
			const Token = Cookies.get("Authorization")
			let req        = await reqmembership(Token)
			let count      = req.data.count
			let membership = req.data.results
			this.setState({
				count,
				membership
			})
		}
		this.setState({	drawerdata  : false })
	}
	async onChildChanged2(data) {
    	const Token = Cookies.get("Authorization")
		if(!data.page) {
			data.page = 1
			data.page_size = 6
		}
		await this.setState({
			data: { ...this.state.data,
				...data
			}
		});
		const Data = this.state.data
		 for(let key in Data) {
		    if(Data[key].length===0) {
		      delete Data[key]
		    }
		 }
		let req = await reqdatamembership(Data, Token)
		let membership = req.data.results,
			count  = req.data.count
			await this.setState({
			membership,
			count,
			})
	}
	async Click(e){
		const Token = Cookies.get("Authorization") 
		const data  = this.state.data
		const state = e.target.value
		let   Data  = {state}
		      Data  = {...data,...Data,page:1,page_size:6}
		for(let key in Data) {
		    if(Data[key].length===0) {
		      delete Data[key]
		    }
		 }  
		const req   = await reqdatamembership(Data,Token)
		const membership=req.data.results
		let count = req.data.count
		this.setState({
			data:Data,
			membership,
			count
		})
  	}
	inputchange=(e)=>{
  	let inputvalue = e.target.value
    this.setState({
		value:inputvalue
		})
  	}
	async handletext(){
	    let {data,value} = this.state
	    let Data ={...data,page:1,page_size:6,search:value}
	    for(let key in Data) {
		    if(Data[key].length===0) {
		      delete Data[key]
		    }
		}
   		const Token = Cookies.get("Authorization") 
		let req         = await reqdatamembership(Data,Token)
		let membership  = req.data.results
		let count       = req.data.count
		this.setState({
			data:Data,
			membership,
			count,
			value:''
		})
    }
 	add = () =>{
 		this.setState({ drawerdata:true })
 	}
 	
	render() {
		let { membership,count,drawerdata } = this.state
		return(
			<div className='walletcoupon'>
			<div style={{ marginBottom: '12px' }}>
	    		<ButtonGroup className='rulebtngroup'>
			      <Button value=''  onClick={this.Click.bind(this)} >All</Button>
			      <Button value='0' onClick={this.Click.bind(this)} >Processing</Button>
			      <Button value='1' onClick={this.Click.bind(this)} >Launched</Button>
			      <Button value='2' onClick={this.Click.bind(this)} >Archived</Button>
			    </ButtonGroup>
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
				<Button className="button2" onClick={this.add}>Add</Button>
				</div>
    			<Center 
    			membership={membership} 
    			count={count}
    			page ={this.state.data.page}
    			drawerdata={drawerdata} 
    			callbackParent={this.onChildChanged.bind(this)}
    			callbackParent2={this.onChildChanged2.bind(this)}/>
	    			
    	</div>
		);
	}
}

export default Rules;