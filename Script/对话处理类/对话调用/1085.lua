-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:47:50
-- @最后修改来自: baidwwy
-- @Last Modified time: 2024-04-08 23:01:42
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1085]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号==1 then
		wb[1] = "这里的风景还不错吧。"
		wb[2] = "行走江湖不能两手空空，来挑一件趁手的兵器吧。"
		wb[3] = "少侠是来选购兵器的吧？请慢慢挑选，务必看清楚名称哦！"
		return {"男人_武器店老板","武器店老板",wb[sj(1,#wb)],{"购买","我只是来看看"}}
	end
	return
end

__NPCdh222[1085 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 事件=="购买" then
        玩家数据[数字id].商品列表=商店处理类.商品列表[16]
        发送数据(id,9,{商品=商店处理类.商品列表[16],银子=玩家数据[数字id].角色.银子})
    end
end