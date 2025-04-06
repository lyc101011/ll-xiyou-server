-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 22:28:20
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

__GWdh111[137]=function(连接id,数字id,序列,标识,地图)
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

__GWdh222[137]=function (连接id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 事件=="讨教一二" then
		if 取等级要求(数字id,60)==false and 调试模式==false then 常规提示(数字id,"#Y/队伍中有成员等级高于60级") return  end
		if 任务数据[玩家数据[数字id].地图单位.标识].zhandou~=nil then 常规提示(数字id,"#Y/对方正在战斗中") return  end
		if 取队伍人数(数字id)<1 and 调试模式==false then 常规提示(数字id,"#Y队伍人数低于3人，无法进入战斗") return  end
		任务数据[玩家数据[数字id].地图单位.标识].zhandou=true
		战斗准备类:创建战斗(数字id+0,100077,玩家数据[数字id].地图单位.标识)
		-- 玩家数据[数字id].地图单位=nil
		return
	end
end

function 设置任务137(id)
	local 地图范围={1230}
	local x待发送数据 = {}
	for i=1,#地图范围 do
		local 临时数量=10
		local 地图=地图范围[i]
		x待发送数据[地图]={}
		for n=1,临时数量 do
			local 任务id=地图.."_137_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_"..n
			随机序列=随机序列+1
			local xy=地图处理类.地图坐标[地图]:取随机点()
			local 模型范围={"蓐收","帝江","强良","饕餮"}--"宠物口粮",
			local 模型=模型范围[取随机数(1,#模型范围)]
			local x称谓 = "蚩尤部下"
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3000,
				玩家id=0,
				队伍组={},
				名称=模型,
				模型=模型,
				等级=取随机数(125,155),
				称谓=x称谓,
				x=xy.x,
				y=xy.y,
				事件="明雷活动",
				地图编号=地图,
				地图名称=取地图名称(地图),
				显示饰品=true,
				类型=137
			}
			-- 地图处理类:添加单位(任务id)
			table.insert(x待发送数据[地图], 地图处理类:批量添加单位(任务id))--修改
		end
	end
	for i=1,#地图范围 do--修改
		local 地图编号=地图范围[i]
		for n, v in pairs(地图处理类.地图玩家[地图编号]) do
			if n~=id and 地图处理类:取同一地图(地图编号,id,n,1)  then
				发送数据(玩家数据[n].连接id,1021,x待发送数据[地图编号])
			end
		end
	end
	x待发送数据={}
	广播消息({内容=format("#R/一群蚩尤的部下，出现了在涿鹿。"),频道="xt"})
end

function rwgx137(任务id)
	if os.time()-任务数据[任务id].起始>=任务数据[任务id].结束 and 任务数据[任务id].结束 ~= 99999999 then -- 任务时间到期
		if 任务数据[任务id].zhandou==nil  then
			地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
			任务数据[任务id]=nil
		end
	end
end