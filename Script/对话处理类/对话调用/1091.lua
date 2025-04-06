-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:38:54
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

__NPCdh111[1091]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "我可以送你去北俱芦洲，你要去吗？"
		local xx = {"是的我要去","我还要逛逛"}
		return {"男人_驿站老板","驿站老板",wb[1],xx}
	elseif 编号 == 2 then
		wb[1] = "我可以送你去天宫，你要去吗？"
		local xx = {"是的我要去","我还要逛逛"}
		return {"男人_将军","传送天将",wb[1],xx}
	elseif 编号 == 3 then
		wb[1] = "我可以送你去大唐境外，你要去吗？"
		local xx = {"是的我要去","我还要逛逛"}
		return {"男人_土地","西牛贺洲土地",wb[1],xx}
	elseif 编号 == 4 then
		if 玩家数据[数字id].角色:取任务(1163)~=0 and 任务数据[玩家数据[数字id].角色:取任务(1163)].子类==1 and 任务数据[玩家数据[数字id].角色:取任务(1163)].护送地点=="长寿郊外" then
			文韵墨香:见到西域使者(数字id)
			wb[1] = "少侠真实及时雨啊，我正苦于如何安全到达长安城呢。听说有些地方强盗闹的厉害，少侠可要避开这些区域啊。"
      		return {"宝象国国王","西域使者",wb[1]}
		else
			wb[1] = "去长安是走这条路吗#111，少侠是来带我去长安的吗？"
			return {"宝象国国王","西域使者",wb[1]}
		end
	end
	return
end

__NPCdh222[1091 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="驿站老板" then
        if 事件=="是的我要去" then
          地图处理类:跳转地图(数字id,1174,193,155)
        end
    elseif 名称=="传送天将" then
        if 事件=="是的我要去" then
          地图处理类:跳转地图(数字id,1111,246,158)
        end
    elseif 名称=="西牛贺洲土地" then
        if 事件=="是的我要去" then
          地图处理类:跳转地图(数字id,1173,33,96)
        end
    end
end