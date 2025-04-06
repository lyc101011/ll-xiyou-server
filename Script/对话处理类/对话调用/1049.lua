-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:35:21
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

__NPCdh111[1049]=function(ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "当今圣上日李万姬，阴明过人。"
		if 玩家数据[数字id].角色:取任务(1164)~=0 then
			xx = {"文韵墨香","我要做其他事情","我点错了"}
		end
		return{"考官2","殷丞相",wb[1],xx}
	end
	return
end

__NPCdh222[1049]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 名称=="殷丞相" then
		if 事件=="文韵墨香" then
			if 玩家数据[数字id].角色:取任务(1164)~=0 then
				玩家数据[数字id].角色:取消任务(玩家数据[数字id].角色:取任务(1164))
				抽奖处理:转盘抽奖(数字id)
			else
			end
		elseif 事件=="我要做其他事情" then
		    添加最后对话(数字id,"当今圣上日李万姬，阴明过人。")
		end
	end
end