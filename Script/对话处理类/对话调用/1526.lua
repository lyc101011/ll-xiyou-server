-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 11:55:19
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:12:35
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1526]=function(ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "最近都打不到什么猎物，日子还怎么过啊，老婆说再这样下去，就得考虑让我进京城打工了。"
		wb[2] = "城外的野兽倒不少，可都是凶猛无比，真是恐怖啊！"
		wb[3] = "如今外出打猎要带一包袱的草药，都搞不清是谁打谁了。"
		wb[4] = "进山不怕虎伤人，下海不怕龙卷身。没有胆量是做不得猎人的。"
		wb[5] = "自从建邺城开了新城门，经由我家门口去东海确实方便了许多。"
		return{"男人_兰虎","周猎户",wb[取随机数(1,#wb)]}
	end
	return
end