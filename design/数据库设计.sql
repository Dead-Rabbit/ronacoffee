-- 创建ronacoffee数据库
create database ronacoffee;

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

delete from ronacoffee.shops where shopId = '100011';

-- 创建商品详情 用来存储所有的商品
create table ronacoffee.items(
	itemId varchar(50) not null primary key,
    itemName varchar(100) not null,
    description varchar(1500) 
);

insert into ronacoffee.items(itemId,itemName,description) 
	value('100-100-100','卡布奇诺',
		'脓现象醇厚脓现象醇厚脓现象脓现象醇厚脓现象醇厚脓现象醇厚脓现象醇厚脓现象醇厚脓现象醇厚脓现象醇厚脓现象醇厚脓现象醇厚脓现象醇厚脓现象醇厚脓现象醇厚脓现象醇厚脓现象醇厚脓现象醇厚脓现象醇厚脓现象醇厚脓现象醇厚醇厚脓现象醇厚脓现象醇厚脓现象醇厚');

select * from ronacoffee.items;

delete from ronacoffee.items where itemId = '100-100-100';


-- 创建商店对应商品的表
create table ronacoffee.prices(
	shopId varchar(100) not null,
    itemId varchar(50) not null,
    price float not null default 0,
    
    -- 设置商店为外键
    foreign key(shopId) references ronacoffee.shops(shopId),
    -- 设置item为外键
    foreign key(itemId) references ronacoffee.items(itemId)
);

insert into ronacoffee.prices(shopId,itemId,price) value('100011','100-100-100',100);

select * from ronacoffee.prices;

delete from ronacoffee.prices where shopId = '100011';
-- 创建工单详情


