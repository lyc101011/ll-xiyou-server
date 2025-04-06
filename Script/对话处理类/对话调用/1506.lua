-- @Author: baidwwy
-- @Date:   2024-11-01 04:09:49
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-11 00:07:12
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 11:59:14
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

__NPCdh111[1506]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "我可以送你去#R/傲来国#W/你要不要去呢？"
		local xx = {"是的我要去","我还要逛逛"}
		return{"男人_驿站老板","船夫",wb[取随机数(1,#wb)],xx}
	elseif 编号 == 2 then
		wb[1] = "我只为10级以下的新人治疗，而且是免费的，有什么可以帮你的吗？"
		local xx = {"请帮我治疗","我随便看看,打扰了"}
		return{"男人_村长","云游神医",wb[取随机数(1,#wb)],xx}
	elseif 编号 == 3 then
		wb[1] = "我是专门治疗和调训召唤兽的医生，10级以下免费治疗驯养，选择驯养或治疗之前请注意：我每次都是把你身上携带的所有召唤兽进行统一治疗和驯养"
		local xx = {"我的召唤兽受伤了，请帮我救治一下吧","我的召唤兽忠诚度降低了，请帮我驯养一下吧","我要同时补满召唤兽的气血、魔法和忠诚","我要提升召唤兽忠诚","我只是看看","我要重置召唤兽属性点"}
		return{"男人_巫医","超级巫医",wb[取随机数(1,#wb)],xx}
	elseif 编号 == 4 then
		wb[1] = "这附近有个岩洞，进去过的人都说里面有很厉害的怪物，最好找一些伙伴一起进去比较安全，你也想进去冒险吗？"
		local xx = {"是的，我想进去探个究竟","我怕黑，还是不进去了"}
		return{"男人_钓鱼","捕鱼人",wb[取随机数(1,#wb)],xx}
	elseif 编号 == 5 then
		wb[1] = "我可以送你去#R/龙宫#W/，你要不要去呢？"
		local xx = {"是的我要去","我还有逛逛"}
		return{"虾兵","老虾",wb[取随机数(1,#wb)],xx}
	elseif 编号 == 6 then
		wb[1] = "从这里过去可以到建邺，那里的风景很不错的。"
		wb[2] = "东海湾常有怪物出没，可要小心"
		wb[3] = "长安城里的集市很热闹的，有机会一定要去看看"
		wb[4] = "东海边的林老汉可以带你去东海岩洞，那里能遇到海毛虫哦#40"
		wb[5] = "东海之水，载不动我沉沉的依恋"
		local 任务id
		if 玩家数据[数字id].角色:取任务(301)~=0 or 玩家数据[数字id].角色:取任务(302)~=0 then --青龙玄武
			wb={"你找我有什么事情吗？"}
			xx={}
			任务id= 玩家数据[数字id].角色:取任务(301)
			if 任务id~=0 and 任务数据[任务id].人物=="楚恋依" then
				xx[#xx+1] = "青龙任务"
			end
			任务id= 玩家数据[数字id].角色:取任务(302)
			if 任务id~=0 and 任务数据[任务id].人物=="楚恋依" then
				xx[#xx+1] = "玄武任务"
			end
			xx[#xx+1] = "没什么，我只是看看"
			return {"普陀山_接引仙女","楚恋依",wb[1],xx}
		end
		return{"普陀山_接引仙女","楚恋依",wb[取随机数(1,#wb)]}
	elseif 编号 == "1_蝴蝶精灵" then
	elseif 编号 == "1_转生后的蝴蝶精灵" then
	end
	return
end

__NPCdh222[1506 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="船夫" then
        if 事件=="是的我要去" then
          if 取等级要求(数字id,10)==false then
            发送数据(玩家数据[id].连接id,1501,{名称="船夫",模型="男人_驿站老板",对话="你或队伍中有玩家等级尚未达到10级，无法使用此传送功能。"})
            return
          elseif 取队长权限(数字id) then
            地图处理类:跳转地图(数字id,1092,165,132)
          end
        end
    elseif 名称=="老虾" then
        if 事件=="是的我要去" then
          地图处理类:跳转地图(数字id,1116,17,107)
        end
    elseif 名称=="云游神医" then
        if 事件=="请帮我治疗" then
          if 玩家数据[数字id].角色.等级<=10 then
            玩家数据[数字id].角色:刷新信息("1")
            添加最后对话(数字id,"已帮你的角色恢复至最佳状态。")
          else
            添加最后对话(数字id,"我这里只能治疗十级以下的玩家哟。")
          end
        end
    elseif 名称=="捕鱼人" then
        if 事件=="是的，我想进去探个究竟" then
          地图处理类:跳转地图(数字id,1126,12,77)
        end
    end
end