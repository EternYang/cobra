import React from 'react';
import Cookies from 'js-cookie';
import { requniproduct2 } from '../api/requrl'
import Top from './top/index';
import Nav from './nav/index';
import Center from './Product/index';


class HomePage extends React.Component {
	state = {
		data: {
			page_size:6
		},
		navdata: '',
		productdata: '',
		count: '',
		page: 1
	}
	async componentDidMount() {
	   const Token       = Cookies.get("Authorization")
	   let   req         = await requniproduct2({}, Token)
	   let   productdata = req.data.results,
		     count       = req.data.count
	   this.setState({
		    productdata,
		    count
		})
	}
	async onChildChanged(data) {
		if(!data.page) {
			data.page = 1
			data.page_size=6
			
		}
		await this.setState({
			data: { ...this.state.data,
				...data
			}
		});
		const Token = Cookies.get("Authorization")
		const Data  = this.state.data
		for(let key in Data) {
		    if(Data[key].length === 0) {
		      delete Data[key]
		    }
		}
		let req         = await requniproduct2(Data, Token)
		let productdata = req.data.results,
			count       = req.data.count,
			Page        = data.page
			await this.setState({
			productdata: productdata,
			count: count,
			page: Page
		})
	}

	render() {
		return(
			<div >
	    		<Top />
	    		<Nav callbackParent={this.onChildChanged.bind(this)}/>
	    		<Center callbackParent={this.onChildChanged.bind(this)}  
	    		 data={this.state.productdata} 
	    		 count={this.state.count}
	    		 page={this.state.page}
	    		/>
    	  </div>
		);
	}
}

export default HomePage;