-- @Author: baidwwy
-- @Date:   2024-05-13 15:10:42
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-05-23 02:16:58
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:56:08
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:17:16
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数


__NPCdh111[1030]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号==1  then
				wb[1] = "这位客官，本酒楼有上好的酒菜，您是否需要品尝？"
				local xx={"购买","制作仙露丸子","购买秘制烹饪","我只是路过"} --超级技能
				return {"男人_酒店老板","酒店老板",wb[取随机数(1,#wb)],xx}
		end
	return
end

__NPCdh222[1030 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
		local 名称=内容[3]
		if 名称=="酒店老板" then
			if 事件=="购买" then
				玩家数据[数字id].商品列表=商店处理类.商品列表[18]
				发送数据(id,9,{商品=商店处理类.商品列表[18],银子=玩家数据[数字id].角色.银子})
			elseif 事件=="购买秘制烹饪" then
				玩家数据[数字id].商品列表=商店处理类.商品列表[42]
				发送数据(id,9,{商品=商店处理类.商品列表[42],银子=玩家数据[数字id].角色.银子,类型="银子"})
			elseif 事件=="制作仙露丸子" then  --超级技能
				发送数据(连接id,3513,玩家数据[数字id].道具:索要道具2(数字id))
                发送数据(玩家数据[数字id].连接id,350,玩家数据[数字id].道具:索要道具1(数字id))
			end
		end
end
-- __NPCdh111[1030]=function (ID,编号,页数,已经在任务中,数字id)
-- 	local wb = {}
-- 	local xx = {}
-- 	if 编号==1  then
-- 				wb[1] = "这位客官，本酒楼有上好的酒菜，您是否需要品尝？"
-- 				local xx={"购买","购买秘制烹饪","我只是路过"}
-- 				return {"男人_酒店老板","酒店老板",wb[取随机数(1,#wb)],xx}
-- 		end
-- 	return
-- end

-- __NPCdh222[1030 ]=function  (id,数字id,序号,内容)
-- 	local 事件=内容[1]
-- 		local 名称=内容[3]
-- 		if 名称=="酒店老板" then
-- 			if 事件=="购买" then
-- 				玩家数据[数字id].商品列表=商店处理类.商品列表[18]
-- 				发送数据(id,9,{商品=商店处理类.商品列表[18],银子=玩家数据[数字id].角色.银子})
-- 			elseif 事件=="购买秘制烹饪" then
-- 				玩家数据[数字id].商品列表=商店处理类.商品列表[42]
-- 				发送数据(id,9,{商品=商店处理类.商品列表[42],银子=玩家数据[数字id].角色.银子,类型="银子"})
-- 			end
-- 		end
-- end