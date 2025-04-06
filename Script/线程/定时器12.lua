-- @Author: baidwwy
-- @Date:   2024-06-17 19:45:53
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-10-20 17:48:52
local ffi = require("ffi")
local 数据数量 = ffi.new("int[1]")
local 线程发送数据 = {}
local asdwe = os.time()
local 定时器 = class()
local 计数器= 0
local 对话内容 = require("Script/对话处理类/NPC对话内容")()
function 定时器:初始化(v,循环文件)
	self.线程 = require("ggethread")(循环文件)
	self.线程.消息返回 = function(self,...)
		if ... == "取数量指针" then
		    return tonumber(ffi.cast("intptr_t",数据数量))
		elseif ... == "取数据" then
			return unpack(r)
		elseif ... == "循环更新" then --开始执行用户挂机线程数据
			计数器=计数器+1
			if 计数器 == 10 then
				计数器=0
			end
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