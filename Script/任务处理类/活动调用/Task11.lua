-- @Author: baidwwy
-- @Date:   2024-05-23 06:02:27
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-06-03 14:12:30
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 22:08:19
-- @最后修改来自: baidwwy
-- @Last Modified time: 2024-04-08 23:01:42
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__GWdh111[11]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
		对话数据.模型=任务数据[标识].模型
		对话数据.名称=任务数据[标识].名称
		if 任务数据[标识].zhandou==nil then
			if 玩家数据[数字id].角色:取任务(11)==标识 then
				对话数据.对话="少侠为追查官府被盗一事而来，必定想听听看我是不是说真话。你听好了，我要说的是：#Y"..[[@*&@*&(!&(*@&)@*()*@)(*@()*!)。]]..[[#W现在你知道我是侠客还是大盗了吧。#90]]
				对话数据.选项={"嗯，你是磊落的侠客，失敬失敬！","哼，你是真的盗贼，我要将你抓捕归案！","让我再想一想"}
			else
				对话数据.对话="我好像不认识你吧？？？"
			end
		else
			对话数据.对话="我正在战斗中，请勿打扰。"
		end
	return 对话数据
end

__GWdh222[11]=function (连接id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 事件=="嗯，你是磊落的侠客，失敬失敬！" or 事件=="哼，你是真的盗贼，我要将你抓捕归案！" then
		if 任务数据[玩家数据[数字id].地图单位.标识].zhandou~=nil then 常规提示(数字id,"#Y/对方正在战斗中") return  end
		if 玩家数据[数字id].队伍==nil then
			常规提示(数字id,"#Y/请先组队！")
			return
		end
		local 比较xy={x=qz(玩家数据[数字id].角色.地图数据.x/20),y=qz(玩家数据[数字id].角色.地图数据.y/20)}
		local 假人数据={x=任务数据[玩家数据[数字id].地图单位.标识].x,y=任务数据[玩家数据[数字id].地图单位.标识].y}
		if 玩家数据[数字id].角色.地图数据.编号~=任务数据[玩家数据[数字id].地图单位.标识].地图编号 or 取两点距离(比较xy,假人数据)>20 then
			return
		end
		local 符合=false
		for n=1,#任务数据[玩家数据[数字id].地图单位.标识].队伍组 do
			if 任务数据[玩家数据[数字id].地图单位.标识].队伍组[n]==数字id then
				符合=true
			end
		end
		if 符合 then
			战斗准备类:创建战斗(数字id+0,130064,玩家数据[数字id].地图单位.标识)
			任务数据[玩家数据[数字id].地图单位.标识].zhandou=true
			玩家数据[数字id].地图单位=nil
		else
			发送数据(玩家数据[数字id].连接id,1501,{内容="你是谁？我们认识吗#55",模型=任务数据[玩家数据[数字id].地图单位.标识].模型,名称=任务数据[玩家数据[数字id].地图单位.标识].名称})
		end
		return
	end
end

function 设置任务11(id)
	local 队伍id=玩家数据[id].队伍
 	if 队伍id==0 or 玩家数据[id].队长==false  then
		 常规提示(id,"#Y/该任务必须组队完成且由队长领取")
		 return
	elseif 取队伍最低等级(队伍id,25) then
		 常规提示(id,"#Y/等级小于25级的玩家无法领取此任务")
		 return
	elseif 取队伍任务(队伍id,11) then
		 常规提示(id,"#Y/队伍中已有队员领取过此任务了")
		 return
	elseif 取队伍最高等级(队伍id,69) then
		 常规提示(id,"#Y/等级高于69级的玩家无法领取此任务")
		 return
	elseif 取队伍人数(id)<3 then
		常规提示(id,"#Y/本任务至少需要三人组队完成")
		return
	else
		for n=1,#队伍数据[队伍id].成员数据 do
			local 临时id=队伍数据[队伍id].成员数据[n]
			if 取每日是否重置(临时id,"初出江湖") then --为空
		        玩家数据[临时id].角色.杜少海数据={次数=0,间隔=0}
		    end
			if 玩家数据[临时id].角色.杜少海数据.次数>=100 then
				常规提示(id,"#Y/队伍中"..玩家数据[临时id].角色.名称.."今日江湖次数已达到100次，无法再领取此任务")
			    return
			end
		end
	end
	local 任务id,ZU=取唯一任务(11,id)
	local 地图范围={1501,1193,1506}
	local 地图=地图范围[取随机数(1,#地图范围)]
	local 随机参数=取随机数()
	local 模型="护卫"
	local 名称 = "江湖大盗"
	local xy=地图处理类.地图坐标[地图]:取随机点()
	任务数据[任务id]={
		领取人id=ZU,
		id=任务id,
		起始=os.time(),
		结束=3600,
		DWZ=ZU,
		销毁=true,
		玩家id=0,
		队伍组=ZU,
		名称=名称,
		模型=模型,
		x=xy.x,
		y=xy.y,
		地图编号=地图,
		地图名称=取地图名称(地图),
		类型=11
	}
	地图处理类:添加单位(任务id)
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		玩家数据[临时id].角色.杜少海数据.次数=玩家数据[临时id].角色.杜少海数据.次数+1
		玩家数据[临时id].角色:添加任务(任务id)
		发送数据(玩家数据[临时id].连接id,1501,{名称="杜少海",模型="男人_店小二",对话=format("听说近日有#Y/%s#W/正在#G/%s(%s,%s)#W/处作恶，请立即前去查明真相。这些江湖大盗中有不少为侠客所扮，所以请少侠多仔细分辨他们的身份。",任务数据[任务id].名称,任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y)})
	end
end

function 胜利MOB_130064(id组,战斗类型,任务id) --江湖大盗
	local id=id组[1]
	for n=1,#id组 do
		local cyid=id组[n]
		local 等级=玩家数据[cyid].角色.等级
		local 经验=qz(等级*等级*5*(玩家数据[cyid].角色.杜少海数据.次数*0.15+1)+30000)
		local 银子=qz(等级*400)
		玩家数据[cyid].角色:添加经验(经验,"初出江湖")
		玩家数据[cyid].角色:添加储备(银子,"初出江湖",1)
		if 玩家数据[cyid].角色.杜少海数据.次数>=10 then
			玩家数据[cyid].角色.杜少海数据.次数=0
		end
		玩家数据[cyid].道具:给予超链接道具(cyid,"金银锦盒",1,nil,nil)
		玩家数据[cyid].角色:取消任务(任务id) --这里已经删除了
		更新玩家每日(cyid,"日常任务","江湖任务")
	end
end

function 任务说明11(玩家id,任务id)
	local 说明 = {}
	说明={"初出江湖",format("前往#Y/%s(%s,%s)#W/#L/处查明#G/%s#L的身份#R(当前第%s次)",任务数据[任务id].地图名称,任务数据[任务id].x,任务数据[任务id].y,任务数据[任务id].名称,玩家数据[玩家id].角色.杜少海数据.次数),"可获得经验、银子、储备金"}
	return 说明
end