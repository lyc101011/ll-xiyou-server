-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:02:06
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

__NPCdh111[1140]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 2 then
		wb[1] = "这里就是普陀山紫竹林了。"
		wb[2] = "你也是来拜见大慈大悲观世音菩萨的吗？#18"
		wb[3] = "菩萨最近正在招收徒，只有女性的仙族才收哦#0"
		wb[4] = "元宵节要到了，谁能陪我去长安城观灯？"
		wb[5] = "紫竹林风光无限好，我再也不愿回到水晶宫了。"
		return {"小龙女","龙女宝宝",wb[sj(1,#wb)]}
	elseif  编号 == 3 then
		wb[1] = "这里是观音大士清修之地，闲杂人等不得乱闯。"
		wb[2] = "比起暗无天日的黑风山，这里可真是清明自在之地啊。#18"
		wb[3] = "跟着观音姐姐，我总会有成仙的那天#89"
		return {"黑熊精","黑熊怪",wb[sj(1,#wb)]}
	elseif  编号 == 1 then
		wb[1] = "我可以送你去长安，你要去吗？"
		local xx = {"是的我要去","我还要逛逛"}
		return {"普陀山_接引仙女","接引仙女",wb[sj(1,#wb)],xx}
	end
	return
end

__NPCdh222[1140 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="接引仙女" then
        if 事件=="是的我要去" then
          地图处理类:npc传送(数字id,1001,470,253)
        end
    end
end