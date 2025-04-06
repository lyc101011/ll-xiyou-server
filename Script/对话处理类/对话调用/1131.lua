-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 17:49:02
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

__NPCdh111[1131]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if (编号 == 1 or 编号 == 2) then
		wb[1] = "这里的三位大王各有一手看家本领，说出来怕会吓死你。"
		wb[2] = "我家的三个大王分别住在三个山洞里。"
		wb[3] = "加入我们狮驼岭，保证你有吃有喝，前途无量。"
		wb[4] = "我们狮驼岭的小妖，光是有名有姓的就有四万七八千。"
		wb[5] = "我家的三个大王神通广大，就是神仙来也得让着三分。"
		return {"雷鸟人","守山小妖",wb[sj(1,#wb)]}
	elseif 编号 == 3 then
		wb[1] = "我送阁下回长安吧。"
		local xx = {"是的我要去","我还要逛逛"}
		return {"雷鸟人","传送小妖",wb[sj(1,#wb)],xx}
	end
	return
end

__NPCdh222[1131]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="传送小妖" then
        if 事件=="是的我要去" then
          地图处理类:npc传送(数字id,1001,470,253)
        end
    end
end