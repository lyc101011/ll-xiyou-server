-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:55:27
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

__NPCdh111[1129]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号==1  then
      	wb[1] = "呜呜呜~我什么时候才能逃出这地狱去投胎啊，要是能有个特赦令牌，那该多好啊。"
      	local xx={"我给你特赦令牌","不好意思，我只是路过"}
      	return {"野鬼","无名野鬼",wb[取随机数(1,#wb)],xx}
    end
	return
end

__NPCdh222[1129 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="无名野鬼" then
        if 事件=="我给你特赦令牌" then
          玩家数据[数字id].给予数据={类型=1,id=0,事件="无名野鬼上交物品"}
          发送数据(id,3530,{道具=玩家数据[数字id].道具:索要道具1(数字id),名称="无名野鬼",类型="NPC",等级="无"})
        end
    end
end