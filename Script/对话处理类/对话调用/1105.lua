-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:36:37
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

__NPCdh111[1105]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "外面的家具市场真是人山人海，摩肩接踵。少侠就算不买东西，也可以进本店休憩片刻，寻个清静。#40"
		local xx = {"购买","我什么都不想做"}
		return {"男人_巫医","杂货店老板",wb[sj(1,#wb)],xx}
	end
	return
end

__NPCdh222[1105 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="杂货店老板" then  --建邺
        if 事件=="购买" then
          玩家数据[数字id].商品列表=商店处理类.商品列表[13]
          发送数据(id,9,{商品=商店处理类.商品列表[13],银子=玩家数据[数字id].角色.银子})
        end
    end
end