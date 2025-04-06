-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:53:54
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

__NPCdh111[1127]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号==1  then
      	wb[1] = "我、我死得好冤啊#15"
      	wb[2] = "文秀，你现在在哪儿呀，赶紧来陪我啊#54"
      	return {"巡游天神","幽冥鬼",wb[取随机数(1,#wb)],xx}
    end
	return
end