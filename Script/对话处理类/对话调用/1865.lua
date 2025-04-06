-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 11:49:33
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

__NPCdh111[1865]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "为了帮派的发展,你可以在我这里领取任务,能得到丰厚的回报"
		local xx = {"领取青龙堂任务","我什么也不想做"}
		if 玩家数据[数字id].角色:取任务(301)~=0 then
			xx = {"青龙任务","取消青龙任务","我什么也不想做"}
		end
		return {"男人_兰虎","青龙总管",wb[1],xx}
	elseif 编号 == 2 then
		wb[1] = "你想要去哪"
		local xx = {"帮派金库","帮派兽室","帮派药房","帮派聚义厅","帮派书院","帮派厢房","帮派青龙堂","送我回长安","路过，随便看看"}
		return {"帮派机关人","橙色机关人",wb[1],xx}
	end
	return
end

__NPCdh222[1865 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="橙色机关人" then
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
    elseif 名称 == "青龙总管" then
        if 事件=="领取青龙堂任务" then
        	--设置任务503(数字id)
        	帮派青龙玄武:设置青龙任务(数字id)
    	elseif 事件=="青龙任务" then
        elseif 事件 == "取消青龙任务" then
        	if 玩家数据[数字id].取消青龙 and 玩家数据[数字id].取消青龙>os.time() then
        		添加最后对话(数字id,"#Y/取消任务后30秒内不能重复取消。")
        	    return
        	end
        	local 任务id= 玩家数据[数字id].角色:取任务(301)
        	if 任务id == 0 then
        		常规提示(数字id,"#Y/你没有这样的任务")
        		return
        	end
			if 任务数据[任务id]==nil then
				常规提示(数字id,"#Y/你没有这样的任务")
				return
			end
			任务数据[任务id]=nil
			玩家数据[数字id].角色:取消任务(任务id)
			常规提示(数字id,"#Y/你取消了青龙堂任务")
			玩家数据[数字id].取消青龙=os.time()+30
        end
    end
end