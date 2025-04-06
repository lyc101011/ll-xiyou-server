-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:43:47
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:17:17
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[2003]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "这里是清风密林，是我们猴族的家园，才不是你们说的什么帮派迷宫... ...少侠找我何事？"
		xx = {"进入地下迷宫","离开"}
		return {"长眉灵猴","猴爷爷",wb[取随机数(1,#wb)],xx}
	end
	return
end
__NPCdh222[2003]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="猴爷爷" then
        帮派迷宫:对话事件处理(数字id,名称,事件)
    end
end