-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 11:46:08
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

__NPCdh111[1835]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
  	    wb[1] = "状态是帮派守护兽除等级外最重要的属性，初始状态为500点，上限为2500点；除了每个月会固定提升若干状态外，还可以通过培养的方式来主动提升守护兽状态。您想好要做什么了吗？"
  	    xx = {"培养召唤兽","路过，随便看看"}
  	    return {"帮派妖兽","帮派守护兽",wb[1],xx}
  	elseif 编号 == 2 then
  		wb[1] = "我可以送您去帮派中的任何一间房间里，告诉我您要去的地方吧。"
  	 	xx={"帮派金库","帮派兽室","帮派药房","帮派聚义厅","帮派书院","帮派厢房","帮派青龙堂","送我回长安","路过，随便看看"}
  	 	return {"帮派机关人","青色机关人",wb[1],xx}
  	end
	return
end

__NPCdh222[1835 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="帮派守护兽" then
        -- if 事件=="上交金银锦盒" then
        --     玩家数据[数字id].给予数据={类型=1,id=0,事件="上交锦盒"}
        --     发送数据(id,3530,{道具=玩家数据[数字id].道具:索要道具1(数字id),名称="龙太子",类型="NPC",等级="无"})
        -- end
    elseif 名称=="青色机关人" then
        if 事件=="帮派青龙堂" then
			地图处理类:跳转地图(数字id,1865,26,20)
		elseif 事件=="帮派金库" then
			地图处理类:跳转地图(数字id,1815,31,25)
		elseif 事件=="帮派兽室" then
			地图处理类:跳转地图(数字id,1835,29,25)
		elseif 事件=="帮派药房" then
			地图处理类:跳转地图(数字id,1854,22,22)
		elseif 事件=="帮派厢房" then
			地图处理类:跳转地图(数字id,1844,28,23)
		elseif 事件=="帮派聚义厅" then
			地图处理类:跳转地图(数字id,1874,31,28)
		elseif 事件=="帮派书院" then
			地图处理类:跳转地图(数字id,1825,23,23)
		elseif 事件=="送我回长安" then
			地图处理类:跳转地图(数字id,1001,387,13)
        end
    end
end