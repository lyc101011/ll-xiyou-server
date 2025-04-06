--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2024-04-28 01:43:01
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--

local 师门商店类 = class()


function 师门商店类:初始化()
	self.道具数据={}
	self.环装数据={}
	self.召唤兽数据={}
end

function 师门商店类:加载数据()
	for i=1,#道具店数据 do
		self.道具数据[i]=物品类()
		self.道具数据[i]:置对象(道具店数据[i].名称)
		if 道具店数据[i].附加 ~= nil then
			for k,v in pairs(道具店数据[i].附加) do
				self.道具数据[i][k] = 道具店数据[i].附加[k]
			end
		end
		self.道具数据[i].价格=道具店数据[i].价格
	end
	for i=1,#环装店数据 do
		self.环装数据[i]=物品类()
		self.环装数据[i]:置对象(环装店数据[i].名称)
		self.环装数据[i].价格=环装店数据[i].价格
	end
	for i=1,#召唤兽店数据 do
		self.召唤兽数据[i]=宝宝类.创建()
		self.召唤兽数据[i]:置新对象(召唤兽店数据[i].名称,召唤兽店数据[i].名称,召唤兽店数据[i].类型,nil,召唤兽店数据[i].等级,nil,召唤兽店数据[i].技能,召唤兽店数据[i].资质,召唤兽店数据[i].成长,nil,召唤兽店数据[i].属性)
		self.召唤兽数据[i].价格=召唤兽店数据[i].价格
	end
end

function 师门商店类:取系统商会数据(数字id,类型,数据)
	if 类型 == "召唤兽店" then
		发送数据(玩家数据[数字id].连接id,301,{"系统商会",{数据=self.召唤兽数据,类型="召唤兽店"}})
	elseif 类型 == "物品店" then
		发送数据(玩家数据[数字id].连接id,301,{"系统商会",{数据=self.道具数据,类型="物品店"}})
	elseif 类型 == "打开商店" then
		发送数据(玩家数据[数字id].连接id,300,{"系统商会",{数据=self.道具数据,类型="物品店"}})
	elseif 类型 == "打开环装" then
		发送数据(玩家数据[数字id].连接id,300,{"系统商会",{数据=self.环装数据,类型="环装店"}})
	elseif 类型 == "购买" then
		local 选中
		if 数据.类型 == "召唤兽店" then
			if 数据.页数 then
				选中 = (数据.页数*12)+数据.选中
			else
		    	选中 =数据.选中
			end
		elseif 数据.类型 == "物品店" then
			if 数据.页数 then
				选中 = (数据.页数*25)+数据.选中
			else
		    	选中 =数据.选中
			end
		end
		if 数据.类型 == "召唤兽店" and self.召唤兽数据[选中] ~= nil then
			if 玩家数据[数字id].角色:取新增宝宝数量() then
				if 玩家数据[数字id].角色:扣除银子(self.召唤兽数据[选中].价格,0,0,"系统商会",1) then
					self.召唤兽数据[选中].认证码= 数字id.."_"..os.time().."_"..取随机数(111111111111,999999999999)
					local 临时道具 =table.copy(self.召唤兽数据[选中])--table.loadstring(table.tostring(self.召唤兽数据[选中]))
					玩家数据[数字id].召唤兽:添加召唤兽(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,临时道具,nil,nil,nil)
					常规提示(数字id,"你获得一只#R"..self.召唤兽数据[选中].模型)
				end
			else
				常规提示(数字id,"召唤兽位置不够")
			end
		elseif 数据.类型 == "物品店" then
			if 数据.环装 then
				if self.环装数据[选中] ~= nil then
					local 临时道具 =table.copy(self.环装数据[选中])--table.loadstring(table.tostring(self.环装数据[选中]))
					玩家数据[数字id].道具:给予道具(数字id,nil,math.min(math.max(数据.数量,1),99),nil,nil,nil,临时道具,self.环装数据[选中].价格,"银子","系统商会")
				end
			else
				if self.道具数据[选中] ~= nil then
				    local 临时道具 =table.copy(self.道具数据[选中])--table.loadstring(table.tostring(self.道具数据[选中]))
					玩家数据[数字id].道具:给予道具(数字id,nil,math.min(math.max(数据.数量,1),99),nil,nil,nil,临时道具,self.道具数据[选中].价格,"银子","系统商会")
				end

			end

		end

	end
end

return 师门商店类
