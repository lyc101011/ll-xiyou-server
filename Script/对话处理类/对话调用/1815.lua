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

__NPCdh111[1815]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		 wb[1] = "当帮中资金少于xx就无法维护，少于xx跑商会有额外的经验奖励，你加油为帮里出力啊。"
  	    -- xx = {"给我些任务","赏金任务","购买商品","查询商人任务额外物品奖励","申请成为商人","完成跑商任务","取消跑商任务","上交金银锦盒","路过，随便看看"}
  	    xx = {"上交金银锦盒","路过，随便看看"}
  		return {"男人_兰虎","金库总管",wb[1],xx}
  	elseif 编号 == 2 then
  		wb[1] = "我可以送您去帮派中的任何一间房间里，告诉我您要去的地方吧。"
  	 	xx={"帮派金库","帮派兽室","帮派药房","帮派聚义厅","帮派书院","帮派厢房","帮派青龙堂","送我回长安","路过，随便看看"}
  		return {"帮派机关人","紫色机关人",wb[1],xx}
	end
	return
end

__NPCdh222[1815 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="金库总管" then
        if 事件=="上交金银锦盒" then
            玩家数据[数字id].给予数据={类型=1,id=0,事件="上交锦盒"}
            发送数据(id,3530,{道具=玩家数据[数字id].道具:索要道具1(数字id),名称="龙太子",类型="NPC",等级="无"})
        end
    elseif 名称=="紫色机关人" then
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