-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 16:42:47
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:18:23
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1057]=function(ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
			wb[1] = "在朝为官要尽好自己的本分，对得起圣上和天下百姓。"
			if 玩家数据[数字id].角色:取任务(1163)~=0 and 任务数据[玩家数据[数字id].角色:取任务(1163)].分类==5 then
    			xx = {"文韵墨香","我要做其他事情","我点错了"}
			end
			return{"秦琼","秦琼",wb[1],xx}
		end
	return
end

__NPCdh222[1057]=function(id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 名称=="秦琼" then
		if 事件=="文韵墨香" then
            战斗准备类:创建战斗(数字id,130039,玩家数据[数字id].角色:取任务(1163))
		end
	end
end