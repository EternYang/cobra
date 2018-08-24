import React from 'react';
import { Tree,Icon,message  } from 'antd';
import { reqdatamembership,sendoccupation,reqoccupation } from '../../api/requrl'
import './TargetGroup.css';
import Cookies from 'js-cookie';

const TreeNode = Tree.TreeNode;
class TargetGroup extends React.Component {
	state={
		membership:'',
		inputvalue:'',
		inputage:'',
		inputage2:'',
		Age:['18-60'],
		handledata:'',
		Occupation:[]
	}
	async componentDidMount() {
		const Token       = Cookies.get("Authorization")  
		let req           = await reqdatamembership({state:1,page_size:999},Token)
		let req2          = await reqoccupation({page_size:100},Token)
		let membership    = req.data.results
		let Occupation    = req2.data.results
		this.setState({
			membership,
			Occupation
		})
		
	}
	info = (text) => {
	  message.info(text);
	}
	onCheck = (checkedKeys,name) => {
		if(checkedKeys.indexOf("key")!==-1){
			checkedKeys.splice(checkedKeys.indexOf("key"),1)
		}
		let { handledata } = this.state
		let data = {[name]:checkedKeys}
		handledata = { ...handledata,...data }
    	this.setState({
	  	handledata
	  	})
    }
	
	closeTargetGroup = () =>{
		this.props.callbackParent(false);
	}
	OK = () =>{
		let {handledata} = this.state
		
		this.props.callbackParent(false,handledata);
	}
	inputchange=(e)=>{
  	let inputvalue = e.target.value
  	    this.setState({
	  	inputvalue
	  	})
  	}
	async additem  () {
		let { inputvalue } = this.state
		if(!inputvalue){
			this.info('type can not be empty')
		}else{
			let data = {name:inputvalue}
			const Token       = Cookies.get("Authorization")
				  try{
				  	await sendoccupation(data,Token)
				  }catch(error){
					if (error.response.status===400) {
					this.info( 'this Occupation is already exists')
			   		}
				}
			let req3          = await reqoccupation({page_size:100},Token)
			let Occupation    = req3.data.results
		  	this.setState({ Occupation,inputvalue:'' })
		}
		
	}
	inputage=(e)=>{
  	let inputage = e.target.value
  	inputage=inputage.slice(0,3)
  	    this.setState({
	  	inputage
	  	})
  	}
	inputage2=(e)=>{
  	let inputage2 = e.target.value
  	inputage2=inputage2.slice(0,3)
  	    this.setState({
	  	inputage2
	  	})
  	}
	addAge = () =>{
		let {inputage,inputage2,Age} = this.state
		if(!inputage || !inputage2){
			this.info('age can not be empty')
		}else if(inputage*1 > inputage2*1){
			this.info('The number two must be more than one')
		}else if(inputage*1 < 0){
			let text='Age must be greater than 0'
			this.info(text)
			inputage=0
		}else if(inputage2*1 < 0){
			this.info('Age must be greater than 0')
			inputage=0
		}else{
			let value = inputage + ' - ' + inputage2
			Age.push(value)
			this.setState({
		  	Age,
		  	inputage:'',
		  	inputage2:''
	  		})
		}
	}
	/*
	async deleteOccupation  (e) {
		const Token   = Cookies.get("Authorization") 
		await deleteoccupation(e[0],Token)
		let req3          = await reqoccupation({page_size:100},Token)
		let Occupation    = req3.data.results
	  	this.setState({ Occupation })
		e.shift()
	}
	*/
	render() {
		let { membership,Occupation,Age } =this.state
		let Membership=[]
		if (membership && membership.length>0){
     		Membership = membership
    	}
		return(
			<div className='TargetGroup'>
				<div className='title'>
				<Icon type="close-circle-o" className='icon' onClick={this.closeTargetGroup}/>
				</div>
				<div className='center'>
				<h2>Please choose the target group</h2>
	    		<Tree
			        checkable
			        multiple
			        treeCheckable= {true}
			        selectable={false}
			        onCheck={(checkedKeys, info)=>{this.onCheck(checkedKeys,'memberships')}}
			     >
			        <TreeNode value='Members' title='Members' key='key'>
			        {
			      	  Membership.map((item,index)=>(
			      		<TreeNode key={item.id} 
			      		value={item.id}
			      		title={item.name}>
			      		</TreeNode>
			      	  ))
				    }
			        </TreeNode>
			     </Tree>
	    		<Tree
			        checkable
			        multiple
			        treeCheckable= {true}
			        selectable={false}
			        onCheck={(checkedKeys, info)=>{this.onCheck(checkedKeys,'occupations')}}
			        defaultExpandAll={true}
			     >
	    			<TreeNode value='Occupation' title='Occupation' key='key'>
			        {
			      	  Occupation.map((item,index)=>(
			      		<TreeNode key={item.id} 
			      		value={item.id}
			      		title={item.name}>
			      		</TreeNode>
			      	  ))
				    }
			        </TreeNode>
			    </Tree>
			    <input required="required" value={this.state.inputvalue} onChange={this.inputchange}/>
			    <button className='btn1' onClick={this.additem.bind(this)}><Icon type="plus" />AddOccupation</button>
				<Tree
			        checkable
			        multiple
			        treeCheckable= {true}
			        selectable={false}
			        onCheck={(checkedKeys, info)=>{this.onCheck(checkedKeys,'gender')}}
			     >
	    			<TreeNode value='Gender' title='Gender' key='key'>
			        	<TreeNode key='0' value='0' title='male'></TreeNode>
			        	<TreeNode key='1' value='1' title='female'></TreeNode>
			        </TreeNode>
			    </Tree>
			   <Tree
			        checkable
			        multiple
			        treeCheckable= {true}
			        selectable={false}
			        onCheck={(checkedKeys, info)=>{this.onCheck(checkedKeys,'age')}}
			        defaultExpandAll={true}
			     >
	    			<TreeNode value='Age' title='Age' key='key'>
			        
			        {
			        
			      	  Age.map((item,index)=>(
			      		<TreeNode key={item} 
			      		value={item}
			      		title={item}>
			      		</TreeNode>
			      	  ))
				    }
			        </TreeNode>
			    </Tree>
			    <input 
			    className='input1' 
			    type='number' 
			    value={this.state.inputage} 
			    onChange={this.inputage}
			    /> ~
			    <input 
			    className='input2' 
			    type='number'
			    value={this.state.inputage2} 
			    onChange={this.inputage2}
			    />
			    <button className='btn1' onClick={this.addAge}><Icon type="plus" />AddAge</button>
			    <br/>
			   	<button className='btn2' onClick={this.closeTargetGroup}>Cancel</button>
			    <button className='btn3' onClick={this.OK}>OK!</button>
				</div>
    	    </div>
		);
	}
}

export default TargetGroup;