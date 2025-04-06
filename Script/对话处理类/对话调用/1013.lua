-- @Author: baidwwy
-- @Date:   2024-08-21 11:47:39
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-08-24 10:10:46
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1013]=function (ID,编号,页数,已经在任务中,数字id)
	 local wb = {}
	 local xx = {}
	 if 编号 == 1 then
	 	wb[1] = "恭喜发财！本钱庄为客户提供多种服务，可存钱取款，还有类似保险箱的特殊账户。"
	 	local xx = {"银两存取","临时路过"}
	 	return{"男人_财主","钱庄老板",wb[取随机数(1,#wb)],xx}
	 end
	 return
end

__NPCdh222[1013]=function (id,数字id,序号,内容)
	 local 事件=内容[1]
	 	local 名称=内容[3]
	 	if 名称=="钱庄老板" then  --建邺
	 		if 事件=="银两存取" then
	 			发送数据(id,216,{存银=玩家数据[数字id].角色.存银,银子=玩家数据[数字id].角色.银子})
	 		end
	 	end
end