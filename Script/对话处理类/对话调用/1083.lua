-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:46:59
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

__NPCdh111[1083]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号==1 then
		wb[1] = "三分长相，七分打扮，挑件合身的衣服吧。店里的张裁缝可以让你提高裁缝熟练度。"
		wb[2] = "人靠衣装马靠鞍，本店为您提供各种新款服装，就算不买也来看看吧。"
		wb[3] = "这里各色绸缎一应俱全，肯定有你想要的。只有大唐官府的玩家才能学会鉴定衣服的技能，而项链腰带的鉴定技能只有地府的玩家才能学。"
		return {"男人_服装店老板","裁缝张",wb[sj(1,#wb)],{"购买","我只是来看看"}}
	end
	return
end

__NPCdh222[1083 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 事件=="购买" then
        玩家数据[数字id].商品列表=商店处理类.商品列表[15]
        发送数据(id,9,{商品=商店处理类.商品列表[15],银子=玩家数据[数字id].角色.银子})
    end
end