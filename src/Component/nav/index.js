import React from 'react';
import Cookies from 'js-cookie';
import { reqcategory,reqTeaBase } from '../../api/requrl'
import './index.css';

class Nav extends React.Component {
  	constructor(props){
	  	super(props);
	  	this.state = {
	  		btn        :'false',
	  		arr        :[1,1,0,0],
	  		key        :'',
	  		logo       : false,
	  		category   :'',
	  		type       :'',
	  		TeaBase    :'',
	  		TeaBasetype:''
	  	}
  	}
    async componentDidMount() {
	    const Token    = Cookies.get("Authorization")
			let   req      = await reqcategory(Token)
			let   req2     = await reqTeaBase(Token)
			let   category = req.data.results,
			      TeaBase  = req2.data.results
			this.setState({
				category:category,
				TeaBase:TeaBase
			})		
	  }
    change=(id)=>{
			let temarr=this.state.arr
			temarr[id]=temarr[id] === 1 ? 0 : 1
			this.setState({ 
				logo : !this.state.logo,
				arr  : temarr
			})
		}
	  async handletype(item,e){
		 	const name = item.name,
		        type = this.state.type
		 	if(name===type){
			 	await	this.setState({
			 		type:''
			 	})
		 	}else{
			 	await	this.setState({
			 		type:item.name
			 	})
	 		}
			const Type = this.state.type
		  const data={ category_name:Type }
			this.props.callbackParent(data);
	  }
	  async handleTeaBasetype(item,e){
		 	const name = item.tea_base,
		        type = this.state.TeaBasetype
		 	if(name===type){
		 		await	this.setState({ TeaBasetype:''})
		 	}else{
		 		await	this.setState({ TeaBasetype:item.tea_base})
		 	}
		 	const Type = this.state.TeaBasetype
		 	const data={ product_tea_base:Type }
		 	this.props.callbackParent(data);
	 }
	
   render() {
     const { category,type,TeaBase,TeaBasetype } =this.state
     let Category = [],
         TeaBases=[]
     if(category && category.length>0){
     	Category =category
     }
     if(TeaBase && TeaBase.length>0){
     	TeaBases =TeaBase
     }
   return (
    
	 <div className="nav"> 
				<ul >
						<p  onClick={ this.change.bind(this,0) }>
					<li >
					<i className={(this.state.arr)[0] ? "fa fa-caret-down" : "fa fa-caret-right" }></i>
					&nbsp;Type
					</li></p>
					<ul className={(this.state.arr)[0] ?  "active" : "hidden"}>
						{
						Category.map((item,index)=>(
							<li 
							key={item.id} onClick={(e) => this.handletype(item, e)} 
							name={item.name}
							className={ type===item.name ? "active" : '' }
							>
							<i className={ type===item.name ? "fa fa-check-square" : "fa fa-square-o " } ></i> 
							<span >&nbsp;{item.name}</span>
					     </li>
						))
					}
					</ul>
			 </ul>
				 
				 <ul >
						<p  onClick={ this.change.bind(this,1) }>
					<li >
					<i className={(this.state.arr)[1] ? "fa fa-caret-down" : "fa fa-caret-right" }></i>
					&nbsp;TeaBases
					</li></p>
					<ul className={(this.state.arr)[1] ?  "active" : "hidden"}>
						{
						TeaBases.map((item,index)=>(
							<li 
							key={index} onClick={(e) => this.handleTeaBasetype(item, e)} 
							name={item.tea_base}
							className={ TeaBasetype===item.tea_base ? "active" : '' }
							>
							<i className={ TeaBasetype===item.tea_base ? "fa fa-check-square" : "fa fa-square-o " } ></i> 
							<span >&nbsp;{item.tea_base}</span>
					     </li>
						))
					}
					</ul>
			 </ul>
	</div> 
    );
  }
}

export default Nav;