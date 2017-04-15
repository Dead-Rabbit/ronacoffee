-- 创建ronacoffee数据库
create database ronacoffee;

-- 全局变量 
-- 会员费
create table ronacoffee.globalVariable(
	vipCharge float not null
)
-- 创建VIP用户表
-- 表中记录所有购买过VIP的用户，未购买则不记录
create table ronacoffee.users(
	-- 用户微信ID
	weichatId varchar(50) not null,
    -- 用户VIP截止日期 
    vipExpiryDate datetime not null,
    -- 用户交过的钱数
    shellEdOut int not null,
    -- 初始注册会员所在店ID号
    shopId varchar(100) not null,
    
    -- 设置注册商店的外键
    foreign key(shopId) references ronacoffee.shops(shopId)
);

select * from ronacoffee.users;

insert into ronacoffee.users(weichatId,vipExpiryDate,shellEdOut,shopId) 
	value('asdfweqwe12312jj123k1l21','2017-4-1',100,'100011');

-- drop table  ronacoffee.users;

-- 创建分店表
create table ronacoffee.shops(
	-- 分店ID
    shopId varchar(100) not null primary key,
    -- 分店名称
    shopName varchar(50) not null,
    -- 分店经纬度 -经度 经纬度以字符串的形式存在
    shopPosition_longitude nvarchar(50) not null,
    -- 分店经纬度 -纬度
    shopPosition_lat nvarchar(50) not null
);

select * from ronacoffee.shops;

-- drop table  ronacoffee.shops;

insert into ronacoffee.shops(shopId,shopName,shopPosition_longitude,shopPosition_lat) value('100011','黄岛金沙滩总店',100,100);

insert into ronacoffee.shops(shopId,shopName,shopPosition_longitude,shopPosition_lat) value('100012','中国石油大学华东店','101','102');

insert into ronacoffee.shops(shopId,shopName,shopPosition_longitude,shopPosition_lat) value('100013','新疆店（地理位置测试）','40.5863215946','90.2420009918');

insert into ronacoffee.shops(shopId,shopName,shopPosition_longitude,shopPosition_lat) value('100014','北京店（地理位置测试）','39.6274362358','116.3987843474');

insert into ronacoffee.shops(shopId,shopName,shopPosition_longitude,shopPosition_lat) value('100015','海洋大学店（地理位置测试）','36.0630984369','120.3393541153');

-- delete from ronacoffee.shops where shopId = '100011';

-- 创建商品类别
create table ronacoffee.itemTypes(
	itemType int not null primary key,
    typeName varchar(50) not null
);

update ronacoffee.itemTypes set typeName = '类别' where typeName= '全部';

insert into ronacoffee.itemTypes(itemType,typeName) value(0,'全部');
insert into ronacoffee.itemTypes(itemType,typeName) value(1,'饮品');
insert into ronacoffee.itemTypes(itemType,typeName) value(2,'点心');
insert into ronacoffee.itemTypes(itemType,typeName) value(3,'蛋糕');
insert into ronacoffee.itemTypes(itemType,typeName) value(4,'披萨');
insert into ronacoffee.itemTypes(itemType,typeName) value(5,'面条');
insert into ronacoffee.itemTypes(itemType,typeName) value(6,'酒品');

drop table ronacoffee.itemTypes;

-- 创建商品详情 用来存储所有的商品
create table ronacoffee.items(
	itemId varchar(50) not null primary key,
    itemName varchar(100) not null,
    itemType int not null ,
    description varchar(1500) ,
    foreign key(itemType) references ronacoffee.itemTypes(itemType)
);

insert into ronacoffee.items(itemId,itemName,itemType,description) 
	value('100-100-100','饮品-卡布奇诺',1,
		'浓香醇厚');
insert into ronacoffee.items(itemId,itemName,itemType,description) 
	value('100-100-101','点心-小饼干',2,
		'好吃，嘎嘣脆');
insert into ronacoffee.items(itemId,itemName,itemType,description) 
	value('100-100-102','蛋糕-榴莲千层',3,
		'香到爆');
insert into ronacoffee.items(itemId,itemName,itemType,description) 
	value('100-100-103','披萨-芝士披萨',4,
		'香甜可口');
insert into ronacoffee.items(itemId,itemName,itemType,description) 
	value('100-100-104','面条-意大利面',5,
		'好吃…');
insert into ronacoffee.items(itemId,itemName,itemType,description) 
	value('100-100-105','酒品-葡萄酒',6,
		'50年醇酿');
insert into ronacoffee.items(itemId,itemName,itemType,description) 
	value('100-100-106','饮品-太妃摩卡',1,
		'丝丝可口');

select * from ronacoffee.items;

-- delete from ronacoffee.items where itemId = '100-100-101';

-- drop table ronacoffee.items

-- 创建商店对应商品的表
-- 对应商店中商品的排序根据此表进行排序
create table ronacoffee.prices(
	shopId varchar(100) not null,
    itemId varchar(50) not null,
    price float not null default 0,
    vipPrice float not null default 0,
    -- 标志（招牌、特价、新品之类）
    sign varchar(50) not null default '无',
    
    -- 设置商店为外键
    foreign key(shopId) references ronacoffee.shops(shopId),
    -- 设置item为外键
    foreign key(itemId) references ronacoffee.items(itemId)
);

insert into ronacoffee.prices(shopId,itemId,price,vipPrice,sign) value('100011','100-100-100',100,80.5,'无');

insert into ronacoffee.prices(shopId,itemId,price,vipPrice,sign) value('100011','100-100-101',90,72,'招牌');

insert into ronacoffee.prices(shopId,itemId,price,vipPrice,sign) value('100011','100-100-102',100,80,'招牌');

insert into ronacoffee.prices(shopId,itemId,price,vipPrice,sign) value('100011','100-100-103',90,72,'特价');

insert into ronacoffee.prices(shopId,itemId,price,vipPrice,sign) value('100011','100-100-104',100,80,'特价');


insert into ronacoffee.prices(shopId,itemId,price,vipPrice,sign) value('100012','100-100-102',80,64,'招牌');

insert into ronacoffee.prices(shopId,itemId,price,vipPrice,sign) value('100012','100-100-101',100,80,'特价');

insert into ronacoffee.prices(shopId,itemId,price,vipPrice,sign) value('100012','100-100-103',80,64,'招牌');

insert into ronacoffee.prices(shopId,itemId,price,vipPrice,sign) value('100012','100-100-104',100,80,'特价');

insert into ronacoffee.prices(shopId,itemId,price,vipPrice,sign) value('100013','100-100-104',100,80,'特价');

insert into ronacoffee.prices(shopId,itemId,price,vipPrice,sign) value('100011','100-100-106',100,80,'招牌');

insert into ronacoffee.prices(shopId,itemId,price,vipPrice,sign) value('100011','100-100-105',120,100,'招牌');

select * from ronacoffee.prices;

delete from ronacoffee.prices where shopId = '100013' ;

-- drop table ronacoffee.prices


-- 创建工单详情
-- 工单ID，用户weichatId，店铺ID，产品编号，价格，是否结算，
-- 规定如果订单时间超过十分钟则进行删除
create table ronacoffee.workOrder(
	-- 自增id
    -- id int not null AUTO_INCREMENT primary key,
	-- 工单ID
	orderId varchar(50) not null primary key,
    -- 用户weichatId
    weichatId varchar(150) not null,
	-- 店铺ID
    shopId varchar(50) not null,
	-- 产品编号
    itemId nvarchar(1000) not null,
	-- 价格
    price float not null,
	-- 是否结算
    ifBalance int not null,
    -- 招领token
    token varchar(50) not null,
    -- 工单创建时间
    createTime datetime not null,
    
    -- 设置商店为外键
    foreign key(shopId) references ronacoffee.shops(shopId)
    -- 设置商品ID为外键
    -- foreign key(itemId) references ronacoffee.items(itemId)
)

select * from ronacoffee.workOrder order by orderId+0 DESC;

select * from ronacoffee.workOrder where weichatId = 'asdfweqwe12312jj123k1l21'
-- 创建一个工单
insert into ronacoffee.workOrder(orderId,weichatId,shopId,itemId,price,ifBalance,token,createTime) 
	value('1000000001','asdfweqwe12312jj123k1l21','100011','100-100-101;100-100-102;100-100-103;100-100-104;100-100-105',100,false,'20','2017-4-8 20:00:00');
insert into ronacoffee.workOrder(orderId,weichatId,shopId,itemId,price,ifBalance,token,createTime) 
	value('1000000002','asdfweqwe12312jj123k1l21','100011','100-100-101;100-100-102;100-100-103;100-100-104;100-100-105',100,false,'20','2017-4-8 20:00:00');
insert into ronacoffee.workOrder(orderId,weichatId,shopId,itemId,price,ifBalance,token,createTime) 
	value('1000002','asdfweqwe12312jj123k1l21','100011','100-100-101;100-100-102;100-100-103;100-100-104;100-100-105',100,false,'20','2017-4-8 20:00:00');

delete from ronacoffee.workorder where orderId = '1000000001';

drop table ronacoffee.workorder

