-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:54:59
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:17:16
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1103]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号==1  then
      	wb[1] = "无敌是一种寂寞，无敌是一种孤独。你是来解脱我的吗#55"
      	local xx={"我要学习变化之术","您继续无敌吧"}
      	return {"孙悟空","美猴王",wb[取随机数(1,#wb)],xx}
    end
	return
end

__NPCdh222[1103 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="美猴王" then
        if 事件=="我要学习变化之术" then
          玩家数据[数字id].角色:学习剧情技能(数字id,"变化之术",4,6)
        end
    end
end