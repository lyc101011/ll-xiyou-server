-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 11:56:43
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

__NPCdh111[1523]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "你要把物品典当给我吗？如果是#Y/古董#W/的话我的出价会高些，但是如果是普通的物品那么典当价格为正常价格的30%"
		xx = {"我有物品需要典当","我只是随便逛逛 打扰了"}
		return{"男人_特产商人","当铺老板",wb[取随机数(1,#wb)],xx}
	end
	return
end