-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 11:17:31
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:17:50

local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1003]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	-- if 编号 == 20 then
	-- 	wb[1] = "欢迎来到梦幻！请问我能帮你什么吗?".."#"..random(1,110)
	-- 	wb[2] = "练级可是人生的一大乐趣啊~".."#"..random(1,110)
	-- 	wb[4] = "真是太平盛世啊，老百姓衣食无忧，闲暇时间还是多听听戏吧。".."#"..random(1,110)
	-- 	local xx = {"我想要领取新手福利","我只是路过"}
	-- 	return{"普陀_接引仙女","新手使者",wb[取随机数(1,#wb)],xx}
	-- elseif 编号 == 7 or  编号 == 8 or  编号 == 9   then
		-- wb[1] = "#109？"
		-- local xx = {"",""}
		-- return{"狸","狸",wb[取随机数(1,#wb)],xx}
	-- end
	return
end

__NPCdh222[1003]=function(id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	-- if 名称=="新手使者" then
	-- 	if 事件=="我想要领取新手福利" then

	-- 	end
	-- end
end