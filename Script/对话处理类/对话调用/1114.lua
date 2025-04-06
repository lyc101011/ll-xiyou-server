-- @Author: baidwwy
-- @Date:   2024-11-01 04:09:49
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-10 00:35:20
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:23:14
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

__NPCdh111[1114]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "完成主线剧情及人物等级达到135级，再来找我开启飞升化境系统。"
		local xx = {}
		return {"男人_打铁","吴刚",wb[sj(1,#wb)],xx}
	elseif 编号 == 2 then
		wb[1] = "纵有端正没人姿，又有谁能知道广寒宫的寂寞？"
		wb[2] = "做错的事，能否重来呢？"
		local xx = {}
		return {"女人_满天星","嫦娥",wb[sj(1,#wb)],xx}
	elseif 编号 == 3 then
		wb[1] = "我们老大就是人称玉面无敌的多情公子二郎神，怎么样，怕了吧！"
		local xx = {}
		return {"天兵","康太尉",wb[sj(1,#wb)],xx}
	end
	return
end