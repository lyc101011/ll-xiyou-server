-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 22:07:54
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-01-04 00:35:03
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

function 设置任务16(id)
	if 玩家数据[id].角色:取任务(16)~=0 then 添加最后对话(id,"你已经有香飘飘跑任务了无法在重复领取")return end
	if 玩家数据[id].角色.等级<60 then
			添加最后对话(id,"只有等级达到60级的玩家才可以领取本任务。")
		 return
	end
	local 任务id="_16_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
	任务数据[任务id]={
	领取人id=x临时人物队伍,
	id=任务id,
	起始=os.time(),
	结束=99999999,
	玩家id=id,
	队伍组={},
	次数 = 1,
	类型=16
	}
	玩家数据[id].角色:添加任务(任务id)
	GetUpMOB16(id,任务id)
end

function GetUpMOB16(id,任务id)
	local  物品表={"金香玉","小还丹","千年保心丹","风水混元丹","定神香","蛇蝎美人","九转回魂丹","佛光舍利子","十香返生丸","五龙丹"}
	local lssj = 取香飘飘NPC()
	任务数据[任务id].名称=lssj.人物
	任务数据[任务id].地图编号=lssj.地图
	任务数据[任务id].地图名称=取地图名称(lssj.地图)
	if 任务数据[任务id].次数 < 10 then
		任务数据[任务id].物品 = "血色茶花"
	else
		任务数据[任务id].物品 = 物品表[取随机数(1,#物品表)]
	end
	添加最后对话(id,format("听闻%s的%s正在四处搜寻#Y%s#W，请你帮他寻找一个吧。",任务数据[任务id].地图名称,任务数据[任务id].名称,任务数据[任务id].物品))
	玩家数据[id].角色:刷新任务跟踪()
end

function 完成任务_16(id,任务id)
	local 积分 = 1
	更新玩家每日(id,"日常任务","香飘飘任务")
	任务数据[任务id].次数 = 任务数据[任务id].次数 +1
	if 任务数据[任务id].次数 == 10 then
		积分 = 积分+10
		玩家数据[id].角色:取消任务(任务id)
		常规提示(id,"#Y恭喜你完成了全部的香飘飘任务")
	else
		GetUpMOB16(id,任务id)
	end
	-- if 取每日限制(id,"香飘飘任务") then
	-- 	玩家数据[id].角色.秘制积分 = 玩家数据[id].角色.秘制积分 +积分
	-- end
end

function 任务说明16(玩家id,任务id)
   local 说明 = {}
	说明={"香飘飘任务",format("#L/将#R%s#L交给#R/qqq|%s*%s*npc查询/%s,#L/当前第%s环。",任务数据[任务id].物品,任务数据[任务id].名称,任务数据[任务id].地图名称,任务数据[任务id].名称,任务数据[任务id].次数),"可获得积分用于兑换秘制食谱"}
	return 说明
end