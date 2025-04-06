-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-25 14:08:03
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1044]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
			wb[1] = "我们已发现在大唐境外有一叫做“ 幽森洞”的神越洞穴，被一凶恶幽灵霸占纵容各种妖魔鬼怪残害百姓，洞内妖魔猖狂，现招募天下英雄共伐之少侠如有此侠义之心，羽林军统领将带你们前往“幽森洞”"
			local xx = {"有劳丞相了。","一队御林军进洞都无法全身而退，我，我上有老下有小呀！"}
			if 玩家数据[数字id].角色:取任务(900)~=0 then
			wb[1]="你的副本已经开启了，是否需要我帮你传送进去？"
			xx={"请送我进去","我等会再进去"}
		 end
			return {"考官2","魏征",wb[1],xx}
	elseif 编号 == 2 then
			wb[1] = "本官的宗旨就是为大家排忧解难的。如果有对自己名字不满意的朋友可以找我来修改名。"
			local xx ={"我要修改名字","我就随便看看"}
			return {"考官2","进阶涂山雪",wb[1],xx}
	elseif 编号 == 3 then
			wb[1] = "我大唐人才辈出，民间有不少能人异士在某些方面为常人所不同。唐王特令我搜寻这些能人异士，并将他们的功绩张榜公示，以鞭策后人。"
			local xx = {"查看实力榜","我只是路过"}
			return{"考官2","房玄龄",wb[取随机数(1,#wb)],xx}
	elseif 编号 == 5 then
			wb[1] = "为选拔天下贤能之士，特在此举行御前科举大赛，会试入围的才子可以在金銮殿上进行殿试，所有参加殿试的才子都可按成绩获得一定的奖励和称谓"
			return {"皇帝","李世民",wb[1],xx}
	end
	return
end

__NPCdh222[1044 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 名称=="房玄龄" then
		if 事件=="查看实力榜" then
			-- 系统处理类:统计实力榜(数字id)
		end
	elseif 名称=="魏征" then
		-- local zhouji=tonumber(os.date("%w", os.time()))
	    if 事件=="有劳丞相了。" then
	    -- if zhouji==2  or zhouji==4  then
			开启泾河龙王(数字id)
			-- else
   --           添加最后对话(数字id,"此副本每周二和周四开启。")
           -- end
		elseif 事件=="请送我进去" then
			任务处理类:副本传送(数字id,11)
		end
	elseif 名称=="戴胄" then
		if 事件=="我要修改名字" then
			发送数据(玩家数据[数字id].连接id,237)
		end
	end
end