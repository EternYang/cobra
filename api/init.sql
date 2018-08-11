insert into app01_role(id,name) values(1,0),(2,1),(3,2),(4,3),(5,4);
insert into app01_membership(id,name,start_points,renewal_points,state) values(1,'W',0,0,1),(2,'C',40,40,1),(3,'P',200,35,1);
insert into app01_member(id,email,mobile_no,username,password,role_id,registration_date,membership_id,points_bal,total_points) 
	values(1,'aa@gmail.com','root','root','root1234',1,'2018-06-01',1,0,0),(2,'bb@gmail.com','pos','pos','root1234',2,'2018-06-01',1,0,0),
	(3,'cc@gmail.com','member01','member01','root1234',3,'2018-06-01',1,0,0),(4,'dd@gmail.com','app','app','root1234',5,'2018-06-01',1,0,0);
insert into app01_wallet(id,member_id,balance,created) values(1,1,0,'2018-06-01'),(2,2,0,'2018-06-01'),(3,3,0,'2018-06-01'),(4,4,0,'2018-06-01');
insert into app01_token(key,user_id,created) values('fa3c5db850ada70422a02e4638984dc08822f010',1,'2018-06-01'),
	('62c366bacc6365c035fad818d2a77be51097e95d',2,'2018-06-01'),('1336161b67b86cf40faa3a86f8cb6b9e32dca5e3',3,'2018-06-01'),	('6c184f9c121c117a999b8f060c8f154e0af450fd',4,'2018-06-01');
insert into app01_occupation(id,name) values(1,'students'),(2,'teachers'),(3,'moms'),(4,'dads'),(5,'cleaners'),(6,'nurses');



insert into app01_category(id,name,category_code) values(1,'test category1','001');
insert into app01_outlet(id,outlet_name,outlet_code,outlet_manager,outlet_district,outlet_floor_area,outlet_address) values(1,'test outlet1','test_outlet_code','jack','district1',100,'address1');
insert into app01_product(id,name,price,item_code,category_id,created) values(1,'test product1',11.11,'001',1,'2018-06-01');
insert into app01_toppings(id,name,price) values(1,'test toppings1',11.11);



delete from app01_role
delete from app01_membership
delete from app01_member
delete from app01_wallet
delete from app01_token
delete from app01_occupation
delete from app01_category
delete from app01_outlet
delete from app01_product
delete from app01_toppings

