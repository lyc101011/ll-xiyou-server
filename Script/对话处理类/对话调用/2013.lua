-- @Author: baidwwy
-- @Date:   2024-04-14 22:24:27
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-04-29 21:42:27
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 11:51:19
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

__NPCdh111[2013]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {"剑出龙吟，武动风雷！三界之中，谁是英豪！有什么我可以帮助你的吗？"}
	local xx = {"剑会天下（单挑模式）紅"}
	return{"蜃气妖","欧冶子",wb[取随机数(1,#wb)],xx}
end

__NPCdh222[2013 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="欧冶子" then  --建邺
        if 事件=="剑会天下（单挑模式）紅" then
        	return  剑会:对话事件处理(数字id,名称,事件)
        end
    end
end