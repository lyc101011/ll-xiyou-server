-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:32:28
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

__NPCdh111[1101]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "我这里出售各种30级武器，你是否需要买一把武器防身呢？"
		local xx = {"购买","我只是路过"}
		return {"男人_兰虎","杜天",wb[sj(1,#wb)],xx}
	end
	return
end

__NPCdh222[1101 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="杜天" then  --建邺
        if 事件=="购买" then
          玩家数据[数字id].商品列表=商店处理类.商品列表[10]
          发送数据(id,9,{商品=商店处理类.商品列表[10],银子=玩家数据[数字id].角色.银子})
        end
    end
end