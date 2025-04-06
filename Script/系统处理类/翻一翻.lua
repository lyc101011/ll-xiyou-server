-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:44
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-08-16 17:55:12
local 翻一翻 = class()
function 翻一翻:初始化()
	-- self.数据 = {}
end

function 翻一翻:数据处理(id,序号,数据)
	-- local 数字id = 数据.数字id+0
	-- if 序号 == 6601 then
	-- 	self:打开翻一番(数字id)
	-- elseif 序号 == 6602 then
	-- 	self:翻牌(数字id,数据)
	-- elseif 序号 == 6603 then
	-- 	self:重置翻盘(数字id)
	-- elseif 序号 == 6604 then
	-- 	self:放弃翻盘(数字id)
	-- end
end

function 翻一翻:打开翻一番(id)
	-- if self.数据[id] == nil then
	-- 	self.数据[id] = {翻倍倍数=1,开始游戏=false,累计游戏次数=0,累计消费仙玉=0,剩余游戏次数=9999,道具 = {},显示顺序={}}
	-- end
	-- 发送数据(玩家数据[id].连接id,6601,self.数据[id])
end

function 翻一翻:翻牌(id,数据)
	-- if self.数据[id] ~= nil and self.数据[id].道具[数据.编号] ~= nil and self.数据[id].道具[数据.编号].名称 == 数据.名称 and self.数据[id].道具[数据.编号].状态 then
	-- 	if 玩家数据[id].角色:扣除银子(100,0,0,"新春翻一番",1)  then
	-- 		self.数据[id].道具[数据.编号].状态 = false
	-- 		if 数据.编号 < 7 then
	-- 			玩家数据[id].道具:给予道具(id,"新春翻一番",self.数据[id].翻倍倍数,self.数据[id].道具[数据.编号].名称)
	-- 			self.数据[id].翻倍倍数 = 1
	-- 		else
	-- 		    self.数据[id].翻倍倍数 = self.数据[id].道具[数据.编号].名称 +0
	-- 		end
	-- 		发送数据(玩家数据[id].连接id,6602,{倍数=self.数据[id].翻倍倍数,编号=数据.编号,累计消费=self.数据[id].累计消费仙玉,累计次数=self.数据[id].累计游戏次数,剩余次数=self.数据[id].剩余游戏次数})
	-- 	end
	-- else
	--    常规提示(id,"#Y请求失败数据错误")
	-- end
end

function 翻一翻:放弃翻盘(id)
	-- self.数据[id].开始游戏 = false
	-- self.数据[id].翻倍倍数 = 1
	-- self.数据[id].道具 = {}
	-- self.数据[id].显示顺序 = {}
	-- 发送数据(玩家数据[id].连接id,6604,self.数据[id])
end

function 翻一翻:奖励发放(id,名称,数量)
	-- local 发放 = false
	-- if 名称=="红玛瑙" or 名称=="舍利子" or 名称=="月亮石" or 名称=="黑宝石" or 名称=="光芒石" then
 --  		玩家数据[id].道具:给予道具(id,名称,数量)
 --  		发放 = true
 --  	elseif 名称=="星辉石" then
 --  		local 等级 = math.floor(数量/2)
 --  		if 等级 == 0 then 等级 = 1 end
 --  		if 等级 > 8 then 等级 = 8 end
 --  		玩家数据[id].道具:给予道具(id,名称,等级)
 --  		发放 = true
  	end
	-- if not 发放 then
	-- 	for i=1,数量 do
	--       	if 名称=="高级召唤兽内丹" then
	--       		玩家数据[id].道具:给予道具(id,名称,1,取内丹("高级"))
	--       	elseif 名称=="召唤兽内丹" then
	--       		玩家数据[id].道具:给予道具(id,名称,1,取内丹("低级"))
	--       	else
	--       		玩家数据[id].道具:给予道具(id,名称,1)
	--       	end
	--     end
	-- end
--end

-- function 翻一翻:重置翻盘(id)
-- 	if self.数据[id].剩余游戏次数 >=1 then
-- 		self.数据[id].累计游戏次数 = self.数据[id].累计游戏次数 +1
-- 		self.数据[id].剩余游戏次数 = self.数据[id].剩余游戏次数 -1
-- 		self.数据[id].开始游戏 = true
-- 		local 奖励= false
-- 		物品表 = {"高级召唤兽内丹","高级魔兽要诀","魔兽要诀","高级藏宝图","陨铁","玲珑宝图","神兜兜","金银锦盒","超级金柳露","红玛瑙","舍利子","月亮石","黑宝石","光芒石","星辉石","附魔宝珠","青龙石","白虎石","玄武石","朱雀石","破天石","冰火玄晶","悔梦石","神魔石","光芒石","真元火","三昧火","天淬火","地心火","天之痕","神兜兜"}
-- 		local 倍数表 = {2,3,4,5,6,7,8,9,10,9,2,3,4,5,12,15,17,6,7,8,9,20,2,3,4,5,6,7,8,9,2,3,4,5,6,7,8}
-- 		for i=1,9 do
-- 			if i <7 then
-- 				local sjz = 取随机数(1,#物品表)
-- 				self.数据[id].道具[i]= {状态=true,名称=物品表[sjz]}
-- 				table.remove(物品表,sjz)
-- 			else
-- 				local sjz = 取随机数(1,#倍数表)
-- 			    self.数据[id].道具[i]={状态=true,名称=倍数表[sjz]}
-- 			    table.remove(倍数表,sjz)
-- 			end
-- 		end
-- 		local 翻一翻显示初始 = {1,2,3,4,5,6,7,8,9}
-- 		self.数据[id].显示顺序 = {}
-- 		for i=1,9 do
-- 			local sjz = 取随机数(1,#翻一翻显示初始)
-- 			self.数据[id].显示顺序[i] = 翻一翻显示初始[sjz]
-- 			table.remove(翻一翻显示初始,sjz)
-- 		end
-- 		发送数据(玩家数据[id].连接id,6603,self.数据[id])
-- 	else
-- 	    常规提示(id,"#Y你的剩余次数不足无法游戏")
-- 	end
-- end
return 翻一翻