-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 22:02:54
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:43:21
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__GWdh111[102]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
		对话数据.模型=任务数据[标识].模型
		对话数据.名称=任务数据[标识].名称
		if 任务数据[标识].zhandou==nil then
			对话数据.对话="人家一个小宝宝在这里好怕怕呀#15"
			对话数据.选项={"我来领养你","回家找你爸妈去"}
		else
			对话数据.对话="我正在战斗中，请勿打扰。"
		end
	return 对话数据
end

__GWdh222[102]=function(连接id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 事件=="我来领养你" then
		if 任务数据[玩家数据[数字id].地图单位.标识].zhandou~=nil then 常规提示(数字id,"#Y/对方正在战斗中") return  end
		战斗准备类:创建战斗(数字id+0,100005,玩家数据[数字id].地图单位.标识)
		任务数据[玩家数据[数字id].地图单位.标识].zhandou=true
		玩家数据[数字id].地图单位=nil
		return
	end
end

function 胜利MOB_100005(胜利id,战斗数据) --怪物取幼儿园
    地图处理类:删除单位(任务数据[战斗数据.任务id].地图编号,任务数据[战斗数据.任务id].单位编号)
    任务数据[战斗数据.任务id]=nil
end

function 设置任务102 (id)
	local 临时数量=取随机数(2,4)
	local 地图范围={1501,1506,1092,1193,1110,1173,1208,1040,1226,1142}
	local 地图=地图范围[取随机数(1,#地图范围)]
	for n=1,临时数量 do
		local 任务id=id.."_102_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
		随机序列=随机序列+1
		xy=地图处理类.地图坐标[地图]:取随机点()
		local 模型=取随机怪(1,130)
		模型=模型[2]
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=600,
			玩家id=0,
			队伍组={},
			名称=模型.."宝宝",
			模型=模型,
			等级=取随机数(1,140),
			x=xy.x,
			y=xy.y,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=102
		}
		-- if 取随机数()<=100 then
		-- 	 任务数据[任务id].变异=true
		-- 	 任务数据[任务id].名称="变异"..模型
		-- end
		地图处理类:添加单位(任务id)
	end
	广播消息({内容=format("#Y/%s#W/在挖宝时砸坏了#S/怪物幼儿园#W/，一群宝宝正在#Y/%s#w/哭闹,各路英雄快来领养#46",玩家数据[id].角色.名称,取地图名称(地图)),频道="xt"})
end

function rwgx102(任务id)
	if os.time()-任务数据[任务id].起始>=任务数据[任务id].结束 and 任务数据[任务id].结束 ~= 99999999 then -- 任务时间到期
		if 任务数据[任务id].zhandou==nil  then
			地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
			任务数据[任务id]=nil
		end
	end
end