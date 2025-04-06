-- @Author: baidwwy
-- @Date:   2024-11-01 04:09:49
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-09 15:08:59
-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:44
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-02 04:05:10
-- @Author: baidwwy
-- @Date:   2024-05-13 15:10:42
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-08-19 10:42:26
local ffi = require("ffi")
local 数据数量 = ffi.new("int[1]")
local 线程发送数据 = {}
local dssj = os.time()
local 定时器 = class()

function 定时器:初始化(v,循环文件)
	self.线程 = require("ggethread")(循环文件)
	self.线程.消息返回 = function(self,...)
		if ... == "取数量指针" then
		    return tonumber(ffi.cast("intptr_t",数据数量))
		elseif ... == "取数据" then
			return unpack(r)
		elseif ... == "循环更新" then
			if os.time()-dssj>=1 then
				dssj = os.time()
				XSHDXH()
			end
		else
			print("线程返回",...)
		end
	end
	self:启动(v)
end

function XSHDXH() --限时活动定时器

	剑会:活动定时器()
	降妖伏魔:活动定时器()
	彩虹争霸:活动定时器()
	天降辰星:活动定时器()
	帮派迷宫:活动定时器()
	文韵墨香:活动定时器()
	门派闯关:活动定时器()
	游泳活动:活动定时器()
	投放怪:活动定时器()
	帮派PK:活动定时器()
	地煞星:活动定时器()
	二八星宿:活动定时器()
	长安保卫战:活动定时器()
	天罡星:活动定时器()
	十八妖王:活动定时器()
	新手活动怪:活动定时器()
	知了先锋:活动定时器()
	龙族:活动定时器()
	剑会天下:活动定时器() --剑会天下
	黑神话:活动定时器()
	镖王任务:活动定时器()
	local fz = 服务端参数.分钟 + 0
	local ms = 服务端参数.秒 + 0
	if ms==1 and (fz==0 or fz==10 or fz==20 or fz==30 or fz==40 or fz==50) then
		重置赐福材料价格()
	end
	----------------------防修改
	if __数据验证~=nil and os.time() - __数据验证.效验time > 0 then
		local xxcdk = 生成效验cdk()
		local 效验码=f函数.取MD5(xxcdk)
		for ak,vn in pairs(玩家数据) do
			if 玩家数据[ak]~=nil and 玩家数据[ak].连接id~=8888888 and 玩家数据[ak].连接id~="小伙伴"  then
				发送数据(玩家数据[ak].连接id, 9996, {效验码=效验码})
			end
		end
		__数据验证.sc效验码 = __数据验证.效验码
		__数据验证.效验码 = 效验码
		__数据验证.效验time = os.time() + 1
	end
	----------------------
	if 比武大会数据 and 比武大会数据.进程 and 比武大会~=nil then
		比武大会:活动定时器() --比武
	end
	沉默分身类:活动定时器()
	皇宫飞贼定时器()
	辅助内挂类:挂机定时器()
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