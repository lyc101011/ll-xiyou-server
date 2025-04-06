-- @Author: baidwwy
-- @Date:   2023-08-31 23:34:34
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-06-14 12:32:13
local ffi = require("ffi")
local 数据数量 = ffi.new("int[1]")
local 线程发送数据 = {}
local 定时时间 = os.time()
local fenzhong = 654
local 定时器 = class()

function 定时器:初始化(v,循环文件)
	self.线程 = require("ggethread")(循环文件)
	self.线程.消息返回 = function(self,...)
		if ... == "取数量指针" then
			return tonumber(ffi.cast("intptr_t",数据数量))
		elseif ... == "取数据" then
			return unpack(r)
		elseif ... == "循环更新" then
			if fenzhong~=os.date("%M", os.time()) and os.date("%S", os.time())=="00" then
				fenzhong=os.date("%M", os.time())
				for n, v in pairs(玩家数据) do
					if 玩家数据[n]~=nil then
						玩家数据[n].角色:增加在线时间()
						if os.date("%M", os.time())+0==33 then --1小时更新一次装备附魔，耐久等等
							玩家数据[n].角色:检查临时属性()
						elseif os.date("%M", os.time())=="55" then
							if 玩家数据[n].召唤兽 then
								玩家数据[n].召唤兽:检查临时属性()
							end
						end
					end
				end
			end
			-- for n, v in pairs(玩家数据) do
			-- -- 	玩家数据[n].道具:更新()
			-- 	玩家数据[n].角色:更新()
			-- end
		else
			print("线程返回",...)
		end
	end
	self:启动(v)
end


function 定时器:启动(v)
	self.线程:启动(v)
	self.线程:置延迟(v)
end

function 定时器:发送(...)--这里是不定数据,如果是固定的,可以参考客户的多线程 纹理
	数据数量[0] = 数据数量[0]+1
	table.insert(线程发送数据,{...})
end

return 定时器