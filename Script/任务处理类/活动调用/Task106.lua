-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 22:03:46
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

__GWdh111[106]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	if 玩家数据[数字id].角色:取任务(107)~=0 then
		if 任务数据[玩家数据[数字id].角色:取任务(107)].当前序列== 任务数据[标识].序列 then
			对话数据.对话="你们是否已经做好了接受考验的准备？"
			对话数据.选项={"请出招吧","我再准备准备"}
		else
			对话数据.对话="你当前应该前往#G/"..Q_门派编号[任务数据[玩家数据[数字id].角色:取任务(107)].当前序列].."#W/接受考验。"
		end
	else
		对话数据.对话="请先前往长安城门派闯关使者处领取任务。"
	end
	return 对话数据
end

__GWdh222[106]=function (连接id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 事件=="请出招吧" then
		if 玩家数据[数字id].角色:取任务(107) ==0 then 常规提示(数字id,"#Y/你没有领取这样的任务") return  end
		if 取队伍人数(数字id)<1 and 调试模式==false then 常规提示(数字id,"#Y/进行门派闯关活动最少必须由一人进行") return  end
		if 取等级要求(数字id,50)==false then 常规提示(数字id,"#Y/进行门派闯关活动至少要达到45级") return  end
		--检查任务一致
		local 任务id=玩家数据[数字id].角色:取任务(107)
		for n=1,#队伍数据[玩家数据[数字id].队伍] do
			if 玩家数据[队伍数据[玩家数据[数字id].队伍][n]].角色:取任务(107) ~=任务id then
				常规提示(数字id,"#Y/队伍中有成员任务不一致")
				return
			end
		end
		战斗准备类:创建战斗(数字id+0,100011,玩家数据[数字id].地图单位.标识)
		任务数据[玩家数据[数字id].地图单位.标识].zhandou=true
		玩家数据[数字id].地图单位=nil
		return
	end
end

function 设置任务106()
	for n=1,15 do
		local 任务id=n.."_"..取随机数(999,1111).."_106_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
		随机序列=随机序列+1
		local 地图范围=取门派地图(Q_门派编号[n])
		local 地图=地图范围[1]
		local 结束时间=7200
		任务数据[任务id]={
			id=任务id,
			-- 领取人id=id,
			起始=os.time(),
			结束=结束时间,
			玩家id=0,
			队伍组={},
			名称=Q_门派编号[n].."护法",
			模型=Q_闯关数据[Q_门派编号[n]].模型,
			x=Q_闯关数据[Q_门派编号[n]].x,
			y=Q_闯关数据[Q_门派编号[n]].y,
			武器=Q_闯关数据[Q_门派编号[n]].武器.名称,
			方向=Q_闯关数据[Q_门派编号[n]].方向,
			地图编号=地图,
			序列=n,
			地图名称=取地图名称(地图),
			类型=106
		}
		地图处理类:添加单位(任务id)
	end
	广播消息({内容="#G/门派闯关活动已经开启，各位玩家可以前往长安城#R/门派闯关活动使者#G/处开启闯关活动#32",频道="xt"})
	闯关参数.开关=true
	闯关参数.起始=os.time()
	闯关参数.记录={}
end

function GetUpMOB106(id)
	if 玩家数据[id].队伍==0 then
		添加最后对话(id,"此活动最少需要三人组队参加。")
		return
	elseif 调试模式==false and 取队伍人数(id)<1 then
		添加最后对话(id,"此活动最少需要三人组队参加。")
		return
	elseif 取等级要求(id,50)==false then
		添加最后对话(id,"此活动要求最低等级不能小于50级，队伍中有成员等级未达到此要求。")
		return
	end
	local 提示=""
	local 队伍id=玩家数据[id].队伍
	local id组={}
	for n=1,#队伍数据[队伍id].成员数据 do
		id组[n]=队伍数据[队伍id].成员数据[n]
		if 玩家数据[id组[n]].角色:取任务(107)~=0 then
			提示="#Y/"..玩家数据[id组[n]].角色.名称.."已经领取过任务了"
		end
	end
	if 提示~="" then
		常规提示(id,提示)
		return
	end
	local 任务id=id.."_107_"..os.time()
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=7200,
		玩家id=0,
		队伍组={},
		类型=107
	}
	任务数据[任务id].闯关序列=table.loadstring(table.tostring(Q_门派编号))
	任务数据[任务id].当前序列=取随机数(1,#任务数据[任务id].闯关序列)
	for n=1,#任务数据[任务id].闯关序列 do
		任务数据[任务id].闯关序列[n]=n
	end
	for n=1,#id组 do
		玩家数据[id组[n]].角色:添加任务(任务id)
		发送数据(玩家数据[id组[n]].连接id,1501,{名称="门派闯关使者",模型="男人_马副将",对话=format("你成功领取了门派闯关任务，请立即前往#Y/%s#W/接受考验。",Q_门派编号[任务数据[任务id].当前序列])})
	end
end

function 完成任务_106()
	local 任务id = 取任务id表(106)
	for i=1,#任务id do
		地图处理类:删除单位(任务数据[任务id[i]].地图编号,任务数据[任务id[i]].单位编号)
		任务数据[任务id[i]]=nil
	end
end

function 任务说明107(玩家id,任务id)
	local 说明 = {}
	说明={"门派闯关",format("你正在进行门派闯关活动，请立即前往#Y/%s#L/接受门派护法考验,截止到目前为止，你已成功完成了#R/%s#L/次考验。",Q_门派编号[任务数据[任务id].当前序列],15-#任务数据[任务id].闯关序列),"可获得经验、银子、物品奖励"}
	return 说明
end