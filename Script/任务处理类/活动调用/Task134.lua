-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 22:27:24
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:42:27
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__GWdh111[134]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
		对话数据.模型=任务数据[标识].模型
		对话数据.名称=任务数据[标识].名称
		if 任务数据[标识].zhandou==nil then
			对话数据.对话="好不容易有机会出来。你可不要打扰我的雅兴，要不然我要了你的小命#4"
			对话数据.选项={"讨教一二","我只是路过"}
		else
			对话数据.对话="我正在战斗中，请勿打扰。"
		end
	return 对话数据
end

__GWdh222[134]=function (连接id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 事件=="讨教一二" then
		if 取等级要求(数字id,60)==false and 调试模式==false then 常规提示(数字id,"#Y/队伍中有成员等级高于60级") return  end
		if 任务数据[玩家数据[数字id].地图单位.标识].zhandou~=nil then 常规提示(数字id,"#Y/对方正在战斗中") return  end
		if 取队伍人数(数字id)<1 and 调试模式==false then 常规提示(数字id,"#Y队伍人数低于3人，无法进入战斗") return  end
		任务数据[玩家数据[数字id].地图单位.标识].zhandou=true
		战斗准备类:创建战斗(数字id+0,100065,玩家数据[数字id].地图单位.标识)
		-- 玩家数据[数字id].地图单位=nil
		return
	end
end

function 设置任务134()
	local 任务id=取随机数(11,88).."_134_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
	随机序列=随机序列+1
	local 地图范围={1193,1192,1501,1116,1122,1131,1135,1140,1146,1173,1110,1070}
	local 地图=地图范围[取随机数(1,#地图范围)]
	local xy=地图处理类.地图坐标[地图]:取随机点()
	--xy={x=25,y=18}
	local 结束时间=3600
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=结束时间,
		玩家id=0,
		队伍组={},
		名称="相柳",
		模型="进阶野猪精",
		x=xy.x,
		y=xy.y,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=134
	}
	地图处理类:添加单位(任务id)
	广播消息({内容=format("#R/%s#W/下凡至#G/%s#W/附近搜寻有仙缘之人。凡通过神祇考验者，必将重重有赏#77",任务数据[任务id].名称,取地图名称(地图)),频道="xt"})
end

function rwgx134(任务id)
	if os.time()-任务数据[任务id].起始>=任务数据[任务id].结束 and 任务数据[任务id].结束 ~= 99999999 then -- 任务时间到期
		if 任务数据[任务id].zhandou==nil  then
			地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
			任务数据[任务id]=nil
		end
	end
end