local ffi = require("ffi")
local 数据数量 = ffi.new("int[1]")
local 线程发送数据 = {}
local fenzhong = 654
local 定时器 = class()
local meige=7
function 定时器:初始化(v,循环文件)
	self.线程 = require("ggethread")(循环文件)
	self.线程.消息返回 = function(self,...)
		if ... == "取数量指针" then
		    return tonumber(ffi.cast("intptr_t",数据数量))
		elseif ... == "取数据" then
			local r = 线程发送数据[1]
			return unpack(r)
		elseif ... == "循环更新" then
			if os.date("%S", os.time())+0==meige then ---每分钟01秒
				-- 线下自动抓鬼数据[数字id]={zcs=200,leij=0,on=true,jiangli=0}
				for k,v in pairs(线下自动抓鬼数据) do
					if v.on then
						v.zcs=v.zcs-1
						v.leij=v.leij+1
						if v.zcs<=0 then
							v.on=false
						end
					end
				end
				meige=math.random(7,30)
			end
			-- local s=os.date("%S", os.time()) --每秒
			-- if math.floor(s/meige)==s/meige then
				-- for k, v in pairs(玩家数据) do
				-- 	if 玩家数据[k] and 玩家数据[k].WGSJ then -- 玩家数据[k].WGSJ then
				-- 		发送数据(玩家数据[k].连接id,6302,玩家数据[k].WGSJ)
				-- 	end
				-- end
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