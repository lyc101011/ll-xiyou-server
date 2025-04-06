-- @Author: baidwwy
-- @Date:   2023-09-20 21:15:07
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-02-05 16:16:09
local ffi = require("ffi")
local 数据数量 = ffi.new("int[1]")
local 线程发送数据 = {}
local fenzhong = 654   -----654
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
					for i=1,#假人事件类.假人id do
					 假人事件类:循环事件(i)
					end
		-- elseif ... == "循环移动事件" then
		-- 			 假人事件类:循环移动事件()
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