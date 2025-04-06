local ffi = require("ffi")
local 数据数量 = ffi.new("int[1]")
local 线程发送数据 = {}
local 定时时间 = os.time()
local 定时器 = class()
function 定时器:初始化(v,循环文件)
	self.线程 = require("ggethread")(循环文件)
	self.线程.消息返回 = function(self,...)
		if ... == "取数量指针" then
		    return tonumber(ffi.cast("intptr_t",数据数量))
		elseif ... == "取数据" then
			return unpack(r)
		elseif ... == "循环更新" then
			if os.time()-定时时间>=1 then
				定时时间 = os.time()
				活动检查()
			end
			if 服务端参数.秒+0 == 0 and 服务端参数.分钟+0==51 then
				if not 服务端参数.玩家存档 or 服务端参数.玩家存档 < os.time() then
					服务端参数.玩家存档 = os.time()
					保存系统数据() -- --存档 测试模式
				end
			end
			-- 随机序列=随机序列+1
			if 随机序列>=1000 then 随机序列=0 end
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