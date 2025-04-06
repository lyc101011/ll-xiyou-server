-- @Author: baidwwy
-- @Date:   2024-09-11 20:07:56
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-09-11 21:40:39
local 剑会商店类 = class() --剑会天下


function 剑会商店类:初始化()
	local 加载数据=false
	self.临时数据={}
	self.道具数据={}
	self.召唤兽数据={}
	self.可购买={}
	if f函数.文件是否存在(程序目录..[[sql/剑会道具店.txt]])==false then
		self.临时数据 = 取csv数据("sql/剑会道具店.csv") --想增加或修改物品，在(剑会道具店.csv)里改，删除(剑会道具店.txt)，最后重启服务端即可
		加载数据=true
	else
		self.道具数据=table.loadstring(读入文件(程序目录..[[sql/剑会道具店.txt]]))
	end
	if 加载数据 then --读txt免加载，sql就要更新且取里面的附加
		self:加载数据()
	end
end

function 剑会商店类:加载数据()
	for n=1,#self.临时数据 do
		if self.临时数据[n]~=nil then
			self.道具数据[n]=物品类()
			self.道具数据[n]:置对象(self.临时数据[n].名称)
			if self.临时数据[n].附加 ~= nil then
				for k,v in pairs(self.临时数据[n].附加) do
				    self.道具数据[n][k] = self.临时数据[n].附加[k]
				end
			end
			self.道具数据[n].总数量 = self.临时数据[n].总数量
			self.道具数据[n].剩余数量 = self.临时数据[n].剩余数量
			self.道具数据[n].基础价格 = self.临时数据[n].基础价格
		end
	end
	self.临时数据 = {}
	写出文件([[sql/剑会道具店.txt]],table.tostring(self.道具数据))
end

function 剑会商店类:数量取总价(编号,预购)
	if self.道具数据[编号]==nil then return 999999999999999 end
	self.可购买[编号]=0
	local 总价 = 0
	if tonumber(预购)~=nil and 预购+0 >= 1 then
		local 单价组={}
		for n=1,预购 do
			if self.道具数据[编号].剩余数量 >= 1 then
				local 单价 = self:取单价(编号)
				self.可购买[编号] = self.可购买[编号] + 1
				self.道具数据[编号].剩余数量 = self.道具数据[编号].剩余数量 - 1
				table.insert(单价组,单价)
			else
			   break
			end
		end
		for k,v in ipairs(单价组) do
			总价 = 总价 + v
		end
	end
	return 总价,self.可购买[编号]
end

function 剑会商店类:取单价(编号)
--价格翻倍公式为：对比该商品总数量，剩余数量比总数量越小，则价格越贵。这样写的好处在于物品价值有的高，有的低，那你上架数量肯定不一样，价格翻倍幅度也不能一样
--用 总数量-剩余数量 的公式就能避免价格涨幅离谱的问题
	if self.道具数据[编号]==nil then return 999999999999999 end
	local 单价 = self.道具数据[编号].基础价格+0
	local gs = math.abs(self.道具数据[编号].剩余数量 - self.道具数据[编号].总数量)/100 --除100就是最大为基础价格的2倍，要加大幅度就把100改更小比如50
	单价 = math.floor(单价*(1+gs))
	return 单价
end

function 剑会商店类:取商品数据()
	return self.道具数据
end

function 剑会商店类:重置商品数量() --定时重置
end

function 剑会商店类:数据处理(数字id,类型,数据)
	if 类型 == "召唤兽店" then
	elseif 类型 == "物品店" then
	elseif 类型 == "打开商店" then
	elseif 类型 == "打开环装" then
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
        elseif 数据.类型 == "物品店" then
        	if 数据.环装 then
			else
				if self.道具数据[选中] ~= nil then
				    local 临时道具 =table.copy(self.道具数据[选中])
				    local 道具 =物品类()
				    道具:置对象(临时道具.名称)
				    local 总价,可购买 = self:数量取总价(数据.选中,数据.数量)
				    if 可购买 <= 0 then 常规提示(数字id,"#Y商品已无剩余") return end
				    if 道具.可叠加 or 玩家数据[数字id].道具:取可叠加(临时道具.名称) then
				    	if 玩家数据[数字id].角色:扣除剑会积分(总价) then
					    	local 参数=nil
			        		if 临时道具.阶品~=nil then 参数 = 临时道具.阶品 end
			        		玩家数据[数字id].道具:给予道具(数字id,临时道具.名称,可购买,参数)
			        		self.道具数据[选中].剩余数量 = self.道具数据[选中].剩余数量 - 可购买
			        		local 积分 = 玩家数据[数字id].角色.剑会数据.商店积分
			        		发送数据(玩家数据[数字id].连接id,411,{积分=积分,类型="道具",数据=table.copy(self:取商品数据())})
			        	end
				    else
				        if 可购买 <= 玩家数据[数字id].角色:取空道具格子数量() then
				        	if 玩家数据[数字id].角色:扣除剑会积分(总价) then
					        	for nv=1,可购买 do
					        		local 参数=nil
					        		local 附加=nil
					        		if 临时道具.阶品~=nil then 参数 = 临时道具.阶品 end
					        		if 临时道具.级别限制~=nil then 参数 = 临时道具.级别限制 end
					        		if 临时道具.技能~=nil then 附加 = 临时道具.技能 end
					        		玩家数据[数字id].道具:给予道具(数字id,临时道具.名称,nil,参数,附加)
					        	end
					        	self.道具数据[选中].剩余数量 = self.道具数据[选中].剩余数量 - 可购买
					        	local 积分 = 玩家数据[数字id].角色.剑会数据.商店积分
					        	发送数据(玩家数据[数字id].连接id,411,{积分=积分,类型="道具",数据=table.copy(self:取商品数据())})
					        end
				        else
				            常规提示(数字id,"#Y背包格子不足")
				        end
				    end
				end
			end
	    end
	end
end

return 剑会商店类
