-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 17:49:38
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:09:37
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1132]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "老牛又叫我去喝酒，好象九头虫也去了，我可不能让这酒虫把酒都喝光了才到。"
		wb[2] = "近来好象又招收了不少门徒，看来得扩充山头了。"
		wb[3] = "狮驼岭的武功博大精深，不是一两天就能领悟的，想要出人头地还需用心苦练。"
		wb[4] = "高级反震什么的，最讨厌了#47"
		return {"二大王","二大王",wb[sj(1,#wb)]}
	end
	return
end