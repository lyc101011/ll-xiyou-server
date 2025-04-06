-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-07-05 18:36:56
__NPCdh111[3000]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	local mx=雁塔地宫.取怪物[(ID-3000+1)][1].模型
	if 编号 == 1 then
		wb[1] = "我乃第"..(ID-3000+1).."层的守护兽，少侠可有勇气挑战我？"
		local xx = {"我来会会你","我准备一下"}
		return {mx,mx,wb[取随机数(1,#wb)],xx}
	elseif 编号 == 2 then
		wb[1] ="我是专门治疗和调训召唤兽的医生，10级以下免费治疗驯养，选择驯养或治疗之前请注意：我每次都是把你身上携带的所有召唤兽进行统一治疗和驯养"
		xx = {"我的召唤兽受伤了，请帮我救治一下吧","我的召唤兽忠诚度降低了，请帮我驯养一下吧","我要同时补满召唤兽的气血、魔法和忠诚","我只是看看"}
		return {"男人_巫医","超级巫医",wb[取随机数(1,#wb)],xx}
	end
	return
end

__NPCdh222[3000]=function (id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
		if 事件=="我来会会你" then
		end
end