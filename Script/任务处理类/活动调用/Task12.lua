-- @Author: baidwwy
-- @Date:   2024-05-23 06:02:27
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-04 23:32:00
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 22:08:48
-- @最后修改来自: baidwwy
-- @Last Modified time: 2024-06-03 21:37:11
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数
local 飞贼time = 0

__GWdh111[12]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
		对话数据.模型=任务数据[标识].模型
		对话数据.名称=任务数据[标识].名称
		if 任务数据[标识].zhandou==nil then
			if 玩家数据[数字id].角色:取任务(12)==标识 then
				对话数据.对话="虽然我看起来像个贼，名字也跟贼有关。但实际上我是一个好人哟。"
				对话数据.选项={"将偷盗的宝物交出来","我相信你是个好人"}
			else
				对话数据.对话="我好像不认识你吧？？？"
			end
		else
			对话数据.对话="我正在战斗中，请勿打扰。"
		end
	return 对话数据
end

__GWdh222[12]=function (连接id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 事件=="将偷盗的宝物交出来" then
		if 任务数据[玩家数据[数字id].地图单位.标识].zhandou~=nil then 常规提示(数字id,"#Y/对方正在战斗中") return  end
		if 玩家数据[数字id].队伍==nil then
			常规提示(数字id,"#Y/请先组队！")
			return
		end
		local 符合=false
		for n=1,#任务数据[玩家数据[数字id].地图单位.标识].队伍组 do
			if 任务数据[玩家数据[数字id].地图单位.标识].队伍组[n]==数字id then
				符合=true
			end
		end
		if 符合 then
			战斗准备类:创建战斗(数字id+0,100022,玩家数据[数字id].地图单位.标识)
			任务数据[玩家数据[数字id].地图单位.标识].zhandou=true
			玩家数据[数字id].地图单位=nil
		else
			发送数据(玩家数据[数字id].连接id,1501,{内容="你是谁？我们认识吗#55",模型=任务数据[玩家数据[数字id].地图单位.标识].模型,名称=任务数据[玩家数据[数字id].地图单位.标识].名称})
		end
		return
	end
end

function 皇宫飞贼定时器()
	if 服务端参数.小时=="12" and 服务端参数.分钟=="01" and os.time()-飞贼time > 0 then
		飞贼time = os.time() + 3600
		设置任务12()
	elseif 服务端参数.小时=="14" and 皇宫飞贼.开关 then
		皇宫飞贼.开关=false
	end
end

function 设置任务12()
	皇宫飞贼.开关=true
	皇宫飞贼.起始=os.time()
	广播消息({内容="#G/皇宫飞贼活动已经开启，各位玩家可以前往长安城#R/御林军左统领#G/处领取任务#32",频道="xt"})
end

function GetUpMOB12(id)
	if 玩家数据[id].队伍==0 or 玩家数据[id].队长==false  then
		常规提示(id,"#Y/该任务必须组队完成且由队长领取")
		return
	elseif 取队伍最低等级(玩家数据[id].队伍,50) then
		常规提示(id,"#Y/等级小于50级的玩家无法领取此任务")
		return
	elseif 取队伍任务(玩家数据[id].队伍,12) then
		常规提示(id,"#Y/队伍中已有队员领取过此任务了")
		return
	elseif 取队伍人数(id)<1 then
		常规提示(id,"#Y/本任务至少需要五人组队完成")
		return
    elseif 活动次数查询(id,"皇宫飞贼贼王")==false then
    return
	elseif 取队伍最高等级(玩家数据[id].队伍,175) then
		常规提示(id,"#Y/等级大于于175级的玩家无法领取此任务")
		return
	end
	local 任务id=id.."_12_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
  if 皇宫飞贼[id]==nil then
    皇宫飞贼[id]=1
  elseif 皇宫飞贼[id]>=5 then
    皇宫飞贼[id]=1
  end



	local 模型="护卫"
	local 名称 = "江湖大盗"
	if 皇宫飞贼[id]==1 then
		名称="毛贼"
		模型="强盗"
	elseif 皇宫飞贼[id]==2 then
		名称="销赃贼"
		模型="吸血鬼"
	elseif 皇宫飞贼[id]==3 then
		名称="宝贼"
		模型="夜罗刹"
	elseif 皇宫飞贼[id]==4 then
		名称="盗贼首领"
		模型="雨师"
	end
	local 地图=1193
	local xy=地图处理类.地图坐标[地图]:取随机点()
	local x临时人物队伍={}
	if 玩家数据[id].队伍~=nil and 玩家数据[id].队伍~=0 then
		for i=1,#队伍数据[玩家数据[id].队伍].成员数据 do
			if 队伍数据[玩家数据[id].队伍].成员数据[i]~=nil then
				x临时人物队伍[#x临时人物队伍+1]=队伍数据[玩家数据[id].队伍].成员数据[i]
			end
		end
	end
	任务数据[任务id]={
		领取人id=x临时人物队伍,
		id=任务id,
		起始=os.time(),
		结束=3600,
		玩家id=0,
		队伍组=table.loadstring(table.tostring(队伍数据[玩家数据[id].队伍].成员数据)),
		名称=名称,
		模型=模型,
		x=xy.x,
		y=xy.y,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=12,
		分类=皇宫飞贼[id]
	}
	地图处理类:添加单位(任务id)
	local 队伍id=玩家数据[id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		if 皇宫飞贼[临时id]==nil then
			皇宫飞贼[临时id]=1
		end
		任务数据[任务id].队伍组[#任务数据[任务id].队伍组+1]=临时id
		-- 次数=次数+1
		玩家数据[临时id].角色:添加任务(任务id)
		发送数据(玩家数据[临时id].连接id,1501,{名称="御林军左统领",模型="护卫",对话=format("据可靠消息，偷盗皇宫宝物的#Y/%s#W/正躲藏#G/%s(%s,%s)#W/附近，请立即前去缉拿(已完成%s轮)。",任务数据[任务id].名称,任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y,皇宫飞贼.贼王[临时id])})
	end
end

function AgainUpMOB12(id)
	if 玩家数据[id].队伍==0 or 玩家数据[id].队长==false  then
		常规提示(id,"#Y/该任务必须组队完成且由队长领取")
		return
	elseif 取队伍最低等级(玩家数据[id].队伍,60) then
		常规提示(id,"#Y/等级小于60级的玩家无法领取此任务")
		return
	elseif 取队伍人数(id)<5 then
		常规提示(id,"#Y/本任务至少需要五人组队完成")
		return
  elseif 活动次数查询(id,"皇宫飞贼贼王")==false then
    return

	end
	local 队伍id=玩家数据[id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		if 皇宫飞贼.贼王[临时id]==nil or 皇宫飞贼.贼王[临时id]<5 then
			添加最后对话(id,format("缉拿贼王需要先完成5轮（非5次）飞贼任务,#G%s#W尚未满足条件。已完成%s轮",玩家数据[临时id].角色.名称,皇宫飞贼.贼王[临时id]))
			return
		elseif 皇宫飞贼.贼王[临时id]==-1 then
			添加最后对话(id,format("#G%s#W在本次活动中已经成功缉拿过贼王，现在不可以再次领取缉拿贼王任务哟。贼王任务每次活动都只可缉拿一次哟。",玩家数据[临时id].角色.名称))
			return
		end
	end
	战斗准备类:创建战斗(id,100023,0)
end

function 完成任务_12()
	local 任务id = 取任务id表(12)
	for i=1,#任务id do
		地图处理类:删除单位(任务数据[任务id[i]].地图编号,任务数据[任务id[i]].单位编号)
		任务数据[任务id[i]]=nil
	end
end

function 任务说明12(玩家id,任务id)
	local 说明 = {}
	说明={"皇宫飞贼",format("去#L%s的%s,%s缉拿%s,剩余时间%s分钟。",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y,任务数据[任务id].名称,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)))),"可获得经验、银子、储备金"}
	return 说明
end