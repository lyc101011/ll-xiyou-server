-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-08-14 16:02:37
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1210]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号==1  then
		wb[1] = "你可是需要传送至宝象国？"
		local xx={"是的送我过去","不了，我还要逛逛"}
		return {"男人_驿站老板","驿站老板",wb[取随机数(1,#wb)],xx}
	elseif 编号==2  then
		wb[1] = "爹爹其实很疼我,我问他要什么宝贝,他都会给我玩。"
		local xx = {"我要开启红孩儿副本","我只是一个路过的"}
		if 玩家数据[数字id].角色:取任务(740)~=0 then
			wb[1]="你的副本已经开启了，是否需要我帮你传送进去？"
			xx={"请送我进去","我等会再进去"}
		 end
		return{"小魔头","红孩儿",wb[取随机数(1,#wb)],xx}
	end
	return
end

__NPCdh222[1210 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 名称=="驿站老板" then
		if 事件=="是的送我过去" then
			地图处理类:跳转地图(数字id,1226,10,112)
		end
	elseif 名称=="红孩儿" then
		-- local zhouji=tonumber(os.date("%w", os.time()))
		if 事件=="我要开启红孩儿副本" then
		-- if zhouji==1  or zhouji==5  then
			设置任务760(数字id)
			-- else
   --           添加最后对话(数字id,"此副本每周一和周五开启。")
          --  end
		elseif 事件=="请送我进去" then
			任务处理类:副本传送(数字id,7)
		end
	end
end