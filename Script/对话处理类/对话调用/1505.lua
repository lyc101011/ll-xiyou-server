-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 11:51:19
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:17:17
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1505]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "建邺里一年四季温暖如春。"
		wb[2] = "客官想买其他杂货可以去城里看看。"
		wb[3] = "洞冥草可以解除摄妖香的效果，你记住了吗#1"
		wb[4] = "宠物口粮只能通过怪物获得"
		local xx = {"购买","我什么也不想做"}
		return{"男人_巫医","杂货店老板",wb[取随机数(1,#wb)],xx}
	end
	return
end

__NPCdh222[1505 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="杂货店老板" then  --建邺
        if 事件=="购买" then
          玩家数据[数字id].商品列表=商店处理类.商品列表[5]
          发送数据(id,9,{商品=商店处理类.商品列表[5],银子=玩家数据[数字id].角色.银子})
        end
    end
end