-- @Author: ASUS
-- @Date:   2020-07-20 19:58:52
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-04-28 01:43:01

local 商会处理类 = class()

function 商会处理类:初始化()
 self.数据={}
end

function 商会处理类:数据处理(id,序号,内容) --暂时注释
	local 数字id = 内容.数字id+0
	常规提示(id,"#Y/商会正在搭建中……")
	-- if 序号 ==6101 then
	-- 	self:物品上间(数字id,内容.序列,内容.编号,内容.店主id)
	-- elseif 序号 ==6102 then
	-- 	self:物品下间(数字id,内容.序列,内容.编号,内容.店主id)
	-- elseif 序号 ==6103 then
	-- 	self:商会上架物品(数字id,内容)
	-- elseif 序号 ==6104 then
	-- 	self:商会取出物品(数字id,内容)
	-- elseif 序号 ==6105 then
	-- 	self:商会改名(数字id,内容)
	-- elseif 序号 ==6106 then
	-- 	self:商会取出资金(数字id,内容)
	-- elseif 序号 ==6107 then
	-- 	self:取商会物品店(数字id,内容)
	-- elseif 序号 ==6108 then
	-- 	self:取商会宠物店(数字id,内容)
	-- elseif 序号 ==6109 then
	-- 	self:索要商会物品2(数字id,内容)
	-- elseif 序号 ==6110 then
	-- 	self:索要商会物品2(数字id,内容)
	-- elseif 序号 ==6111 then
	-- 	self:购买物品(数字id,内容)
	-- elseif 序号 ==6112 then
	-- 	self:商会宠物店数据(数字id,内容)
	-- elseif 序号 ==6113 then
	-- 	self:商会取出宠物(数字id,内容)
	-- elseif 序号 ==6114 then
	-- 	self:商会上架宠物(数字id,内容)
	-- elseif 序号 ==6115 then
	-- 	self:商会宠物页数数据(数字id,内容)
	-- elseif 序号 ==6116 then
	-- 	self:商会购买宠物(数字id,内容)
	-- elseif 序号 ==6117 then
	-- 	self:商会宠物页数数据2(数字id,内容)
	-- elseif 序号 ==6118 then
	-- end
end

function 商会处理类:加载商会(sj)
	self.数据={}
end

function 商会处理类:商会宠物页数数据2(id,数据)
	if 数据.店主id ~= self.数据[数据.编号].店主id and self.数据[数据.编号].宠物[数据.页数] ~=nil then
			常规提示(id,"#Y/商会数据错误")
		end
		发送数据(玩家数据[id].连接id,6114,{宠物=self.数据[数据.编号].宠物[数据.页数],页数=数据.页数})
end

function 商会处理类:商会购买宠物(id,数据)
	local 编号=数据.编号
	local 选中=数据.选中
	local 店主id=数据.店主id
	local 认证=数据.验证
	local 页数=数据.页数
	if 玩家数据[id].角色.银子<self.数据[编号].宠物[页数][选中].价格 then
		常规提示(id,"#Y/你没有那么多的银子")
		return
	end
	local 价格=self.数据[数据.编号].宠物[页数][选中].价格
	if self.数据[数据.编号].宠物[页数][选中].认证码== 认证 and 玩家数据[id].角色:取新增宝宝数量() then
		玩家数据[id].角色:扣除银子(价格,0,0,"商会购买宠物",1)
		self.数据[编号].资金=self.数据[编号].资金+价格
		local 宝宝=宝宝类.创建()
		self.数据[数据.编号].宠物[页数][选中].认证码 = id.."_"..os.time().."_"..取随机数(111111111111,999999999999)
		宝宝:加载数据(self.数据[数据.编号].宠物[页数][选中])
		table.insert(玩家数据[id].召唤兽.数据,宝宝)
		table.remove(self.数据[数据.编号].宠物[页数],选中)
		发送数据(玩家数据[id].连接id,6115,{编号=选中})
		闪烁消息(店主id,"#H/[商会消息]：#G/"..玩家数据[id].召唤兽.数据[#玩家数据[id].召唤兽.数据].模型.."n/#H/购买方：".."#R/["..玩家数据[id].角色.名称.."]"..玩家数据[id].角色.数字id.."n/#H/购买价:#R/"..价格.."n/#H/数量：#R/1n/#H/总价：#R/"..价格.."n/#Y/银两已存入你的商会资金，请注意查收。祝您游戏愉快")
	else
		常规提示(id,"召唤兽位置不够")
	end
end

function 商会处理类:商会上架宠物(id,数据)
	local 编号=数据.编号
	local 选中=数据.选中
	local 店主id=数据.店主id
	local 认证=数据.验证
	local 页数=数据.页数
	local 价格=数据.价格
	if 玩家数据[id].角色.参战宝宝.认证码 == 认证 then
			常规提示(id,"参战召唤兽无法上架")
			return
		end
		if 玩家数据[id].召唤兽.数据[选中].认证码== 认证 and #self.数据[数据.编号].宠物[页数] <16  then
			玩家数据[id].召唤兽.数据[选中].价格=价格+0
			table.insert(self.数据[数据.编号].宠物[页数],玩家数据[id].召唤兽.数据[选中])
			table.remove(玩家数据[id].召唤兽.数据,选中)
			发送数据(玩家数据[id].连接id,6111,{编号=选中})
		else
			常规提示(id,"宠物商铺位置不够")
		end
end

function 商会处理类:商会取出宠物(id,数据)
	local 编号=数据.编号
	local 选中=数据.选中
	local 店主id=数据.店主id
	local 认证=数据.验证
	local 页数=数据.页数
		if self.数据[数据.编号].宠物[页数][选中].认证码== 认证 and 玩家数据[id].角色:取新增宝宝数量() then
			table.insert(玩家数据[id].召唤兽.数据,self.数据[数据.编号].宠物[页数][选中])
			table.remove(self.数据[数据.编号].宠物[页数],选中)
			发送数据(玩家数据[id].连接id,6112,{编号=选中})
		else
			常规提示(id,"召唤兽位置不够")
		end
end

function 商会处理类:商会宠物页数数据(id,数据)
	if 数据.店主id ~= self.数据[数据.编号].店主id and self.数据[数据.编号].宠物[数据.页数] ~=nil then
			常规提示(id,"#Y/商会数据错误")
		end
		发送数据(玩家数据[id].连接id,6110,{宠物=self.数据[数据.编号].宠物[数据.页数],页数=数据.页数})
end

function 商会处理类:商会宠物店数据(id,数据)
	if 数据.店主id ~= self.数据[数据.编号].店主id then
			常规提示(id,"#Y/商会数据错误")
		end
		发送数据(玩家数据[id].连接id,6109,{名称=self.数据[数据.编号].名称,编号=数据.编号,店主id=self.数据[数据.编号].店主id,宠物=self.数据[数据.编号].宠物[1]})
end

function 商会处理类:取商会物品店(id,数据)
	if 数据.店主id ~= self.数据[数据.编号].店主id then
			常规提示(id,"#Y/商会数据错误")
		end
		发送数据(玩家数据[id].连接id,6107,{名称=self.数据[数据.编号].名称,编号=数据.编号,店主id=self.数据[数据.编号].店主id,道具=self.数据[数据.编号].物品[1]})
end
function 商会处理类:取商会宠物店(id,数据)
	if 数据.店主id ~= self.数据[数据.编号].店主id then
			常规提示(id,"#Y/商会数据错误")
		end
		发送数据(玩家数据[id].连接id,6113,{名称=self.数据[数据.编号].名称,编号=数据.编号,店主id=self.数据[数据.编号].店主id,宠物=self.数据[数据.编号].宠物[1]})
end

function 商会处理类:购买物品(id,数据)
	local 页数=数据.页数
	local 道具=数据.序列
	local 编号=数据.编号
	local 店主id=数据.店主id
	local 数量=数据.数量
	local 购买完成 = false
	if 数量<=0 then
		数量=1
	end
	if 店主id ~= self.数据[编号].店主id then
		常规提示(id,"#Y/商会数据错误")
		return
	end
	if self.数据[编号].物品[页数][道具] == nil then
		常规提示(id,"#Y/商会数据错误")
		return
	end
	local 价格=self.数据[编号].物品[页数][道具].价格
	local 道具名称=self.数据[编号].物品[页数][道具].名称
	local 道具识别码=self.数据[编号].物品[页数][道具].识别码
	local 临时道具 = table.loadstring(table.tostring(self.数据[编号].物品[页数][道具]))
	if self.数据[编号].物品[页数][道具].可叠加 == false or self.数据[编号].物品[页数][道具].数量 == nil then
		if 玩家数据[id].道具:给予道具(id,nil,nil,nil,"商会",nil,临时道具,价格,"银子","商会购买") then
			self.数据[编号].物品[页数][道具]=nil
			购买完成 = true
			数量=1
		end

	else
		if self.数据[编号].物品[页数][道具].数量 ~= nil and self.数据[编号].物品[页数][道具].数量< 数量 then
			数量 = self.数据[编号].物品[页数][道具].数量
		end
		if 玩家数据[id].道具:给予道具(id,nil,数量,nil,"商会",nil,临时道具,价格*数量,"银子","商会购买") then
			购买完成 = true
		end
		if  self.数据[编号].物品[页数][道具].数量-数量 <1 then
			self.数据[编号].物品[页数][道具]=nil
		else
			self.数据[编号].物品[页数][道具].数量=self.数据[编号].物品[页数][道具].数量-数量
		end
	end
	if 购买完成 then
		self.数据[编号].资金=self.数据[编号].资金+价格*数量
		玩家数据[id].角色:日志记录(format("[商会系统-购买]购买道具[%s][%s]，花费%s两银子购买了%s个,商铺信息：[%s][%s]",道具名称,道具识别码,价格*数量,数量,店主id,self.数据[编号].名称))
		常规提示(id,"#W/购买#R/"..道具名称.."#W/成功！")
		闪烁消息(店主id,"#H/[商会消息]：#G/"..道具名称.."n/#H/购买方：".."#R/["..玩家数据[id].角色.名称.."]"..玩家数据[id].角色.数字id.."n/#H/购买价:#R/"..价格.."n/#H/数量：#R/"..数量.."n/#H/总价：#R/"..价格*数量.."n/#Y/银两已存入你的商会资金，请注意查收。祝您游戏愉快")
		道具刷新(id)
		发送数据(玩家数据[id].连接id,3513,玩家数据[id].道具:索要道具2(id))
		发送数据(玩家数据[id].连接id,6108,{道具=self:索要商会物品(id,编号,页数),当前页数=数据.页数})
	end
end

function 商会处理类:商会取商会表名(数字id)
	if #self.数据<1 then
		常规提示(数字id,"目前还没有玩家申请商会")
		return
	end
	local lsb={}
	for k,v in pairs(self.数据) do
		lsb[#lsb+1]={}
		lsb[#lsb]={名称=v.名称,店主id=v.店主id,编号=k}
	end
	发送数据(玩家数据[数字id].连接id,6106,lsb)
end

function 商会处理类:商会取商会数据(数字id)
	for k,v in pairs(self.数据) do
		if v.店主id  == 数字id then
			发送数据(玩家数据[数字id].连接id,223,{店名=v.名称,店主id=v.店主id,资金=v.资金,物品=v.物品[1],物品总页=#v.物品,编号=k})
			return
		end
	end
	常规提示(数字id,"你还没有自己的商会")
end

function 商会处理类:商会创建商会(数字id)
	for k,v in pairs(self.数据) do
		if v.店主id == 数字id then
			常规提示(数字id,"你已经有商铺了")
			return
		end
	end
	if 玩家数据[数字id].角色:扣除银子(5000000,0,0,"申请开店",1)== false then 常规提示(数字id,"你的银两不足") return end
	self.数据[#self.数据+1] = {}
	self.数据[#self.数据] = {名称= 玩家数据[数字id].角色.名称,店主id=数字id,资金=0,物品={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}},宠物={[1]={},[2]={},[3]={},[4]={},[5]={},[6]={},[7]={},[8]={},[9]={},[10]={}}}
	常规提示(数字id,"商会申请成功")
end

function 商会处理类:物品上间(数字id,序列,编号,店主id)
	if 编号 == 0 then 常规提示(数字id,"商会数据错误") return end
	if self.数据[编号] ~= nil and self.数据[编号].店主id == 店主id and self.数据[编号].物品[序列] ~= nil then
		发送数据(玩家数据[数字id].连接id,6102,{道具=self.数据[编号].物品[序列],当前页数=序列})
	else
		常规提示(id,"#Y/商会数据错误")
	end
end

function 商会处理类:物品下间(数字id,序列,编号,店主id)
	if 编号 == 0 then 常规提示(数字id,"商会数据错误") return end
	if self.数据[编号] ~= nil and self.数据[编号].店主id == 店主id and self.数据[编号].物品[序列] ~= nil then
		发送数据(玩家数据[数字id].连接id,6102,{道具=self.数据[编号].物品[序列],当前页数=序列})
	else
		常规提示(id,"#Y/商会数据错误")
	end
end

function 商会处理类:索要商会物品2(id,数据)
	local 编号=数据.编号
	local 页数=数据.页数
	local 店主id=数据.店主id
	if self.数据[编号] ~= nil and self.数据[编号].物品[页数] ~= nil and self.数据[编号].店主id == 店主id then
		发送数据(玩家数据[id].连接id,6108,{道具=self.数据[编号].物品[页数],当前页数=数据.页数})
	else
		 常规提示(id,"#Y/商会数据错误")
	end
end

function 商会处理类:索要商会物品(id,编号,页数)
	if self.数据[编号] ~= nil and self.数据[编号].物品[页数] ~= nil then
		return self.数据[编号].物品[页数]
	else
		 常规提示(id,"#Y/商会数据错误")
	end
end

function 商会处理类:商会上架物品(id,数据)
	local 页数=数据.页数
		local 道具=数据.物品
		local 编号=数据.编号
		local 价格=数据.价格
		local 店主id=数据.店主id
		if 店主id ~= self.数据[编号].店主id then
			常规提示(id,"#Y/商会数据错误")
		end
	local 格子=0
	for n=1,20 do
		if  self.数据[编号].物品[页数][n]==nil and 格子==0 then
			格子=n
		end
	end
	if 格子==0 then
		常规提示(id,"#Y/你这个商铺已经无法存放更多的物品了")
		return
	end
	local 道具id = 玩家数据[id].角色.道具[道具]
	self.数据[编号].物品[页数][格子]=玩家数据[id].道具.数据[道具id]
	self.数据[编号].物品[页数][格子].价格=价格+0
	玩家数据[id].角色.道具[道具]=nil
	玩家数据[id].道具.数据[道具id] =nil
	道具刷新(id)
	发送数据(玩家数据[id].连接id,3513,玩家数据[id].道具:索要道具2(id))
	发送数据(玩家数据[id].连接id,6102,{道具=self:索要商会物品(id,编号,页数),当前页数=数据.页数})
	发送数据(玩家数据[id].连接id,6103)
end

function 商会处理类:商会取出物品(id,数据)
	local 页数=数据.页数
	local 道具=数据.物品
	local 编号=数据.编号
	local 店主id=数据.店主id
	if 店主id ~= self.数据[编号].店主id then
		常规提示(id,"#Y/商会数据错误")
	end
	local 格子=玩家数据[id].角色:取道具格子()
	if 格子==0 then
		 常规提示(id,"#Y/你身上的包裹没有足够的空间")
		 return
	end
	local 道具编号 = 玩家数据[id].道具:取新编号()
	玩家数据[id].道具.数据[道具编号] = table.loadstring(table.tostring(self.数据[编号].物品[页数][道具]))
	玩家数据[id].角色.道具[格子]=道具编号
	self.数据[编号].物品[页数][道具]=nil
	道具刷新(id)
	发送数据(玩家数据[id].连接id,3513,玩家数据[id].道具:索要道具2(id))
	发送数据(玩家数据[id].连接id,6102,{道具=self:索要商会物品(id,编号,页数),当前页数=数据.页数})
	发送数据(玩家数据[id].连接id,6103)
end

function 商会处理类:商会改名(id,数据)
	if 数据.店主id ~= self.数据[数据.编号].店主id then
			常规提示(id,"#Y/商会数据错误")
		end
		self.数据[数据.编号].名称=数据.店名
		发送数据(玩家数据[id].连接id,6104,self.数据[数据.编号].名称)
end

function 商会处理类:商会取出资金(id,数据)
	if 数据.店主id ~= self.数据[数据.编号].店主id then
			常规提示(id,"#Y/商会数据错误")
		end
		if self.数据[数据.编号].资金>0 then
		else
			常规提示(id,"#Y/你没有收入无法取出")
		end
end
function 商会处理类:更新(dt)
end

function 商会处理类:显示()

end
return 商会处理类