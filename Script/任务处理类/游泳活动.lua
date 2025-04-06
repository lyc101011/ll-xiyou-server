-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-01-07 09:10:22
local 游泳活动 = class()

function 游泳活动:初始化()
	self.数据={}
	self.活动开关=false
	self.活动时间=QJHDSJ["游泳比赛"]
	self:加载公共数据()
	if self.活动时间.日期=="全天" then
		self:开启活动()
	end
end

function 游泳活动:活动定时器()
	if self.活动时间.日期=="全天" then
		if 服务端参数.秒=="00" and 服务端参数.小时=="00" and 服务端参数.分钟=="00"then
			self.数据={}
		end
		if not self.活动开关 then
			self:开启活动()
		end
	else
		if self.活动开关 then
			if self.开启Time-os.time()<0 then
				self:关闭活动()
			end
		else
			if self.活动时间.日期=="每天" then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
					self:开启活动()
				end
			else
				local zhouji=tonumber(os.date("%w", os.time()))
				if zhouji==self.活动时间.日期 then
					if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
						self:开启活动()
					end
				elseif self.活动时间.日期=="周135" and (zhouji==1 or zhouji==3 or zhouji==5) then
					if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
						self:开启活动()
					end
				elseif self.活动时间.日期=="周246" and (zhouji==2 or zhouji==4 or zhouji==6) then
					if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0 then
						self:开启活动()
					end
				end
			end
		end
	end
end

function 游泳活动:开启活动()
	self.活动开关=true
	local 删除=true
	if self.活动时间.日期=="全天" then
		删除=false
	else
	self.开启Time=os.time()+82800
	end
	for n=1,20 do
		local 任务id=取唯一任务(108)
		local 地图=self.游泳数据[n].z
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=84600,
			玩家id=id,
			队伍组={},
			名称=n.."号裁判",
			称谓="游泳比赛裁判",
			模型="雨师",
			x=self.游泳数据[n].x,
			y=self.游泳数据[n].y,
			方向=self.游泳数据[n].f,
			地图编号=地图,
			序列=n,
			地图名称=取地图名称(地图),
			销毁=删除,
			类型=108
		}
		地图处理类:添加单位(任务id)
	end
	广播消息({内容="#G/游泳比赛活动已经开启，各位玩家可以前往傲来国#R/游泳报名官#G/处参加游泳比赛#32",频道="hd"})
	发送公告("#P/游泳比赛活动已经开启，各位玩家可以前往傲来国#R/游泳报名官#P/处参加游泳比赛！")
end

function 游泳活动:关闭活动()
	self.数据={}
	self.活动开关=false
	self.开启Time=nil
	广播消息({内容="#G/游泳比赛活动结束，感谢大家参与。",频道="hd"})
end

function 游泳活动:取活动开关() --挂机
	if self.活动开关 then
		return true
	else
	    return false
	end
end

function 游泳活动:添加任务(id)
	if 玩家数据[id].队伍==0 then
		添加最后对话(id,"此活动最少需要三人组队参加。")
		return
	elseif 取队伍人数(id)<3 and 调试模式==false then
		添加最后对话(id,"此活动最少需要三人组队参加。")
		return
	elseif 取等级要求(id,30)==false then
		添加最后对话(id,"游泳比赛活动要求最低等级不能小于30级，队伍中有成员等级未达到此要求。")
		return
	elseif self.活动开关==false then
		添加最后对话(id,"当前不是比赛时间。")
		return
	end
	local 提示=""
	local 队伍id=玩家数据[id].队伍
	local id组={}
	for n=1,#队伍数据[队伍id].成员数据 do
		id组[n]=队伍数据[队伍id].成员数据[n]
		if self.数据[id组[n]]==nil then
			self.数据[id组[n]]=0
		end
		if 玩家数据[id组[n]].角色:取任务(109)~=0 then
			提示="#Y/"..玩家数据[id组[n]].角色.名称.."已经领取过任务了"
		elseif self.数据[id组[n]]~=nil and self.数据[id组[n]]>=3 then
			提示="#Y/"..玩家数据[id组[n]].角色.名称.."本日已完成了3轮无法参加游泳比赛了"
		end
	end
	if 提示~="" then
		常规提示(id,提示)
		return
	end
	local 任务id=id.."_109_"..os.time()
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=84600,
		玩家id=id,
		队伍组={},
		序列=1,
		名称="游泳比赛裁判",
		战斗=false,
		类型=109
	}
	for n=1,#id组 do
		玩家数据[id组[n]].角色:添加任务(任务id)
		发送数据(玩家数据[id组[n]].连接id,1501,{名称="王副将",模型="男人_马副将",对话=format("你成功参加了游泳比赛，现在请立即前往#Y/%s(%s,%s)#W/的%s号裁判报道。",取地图名称(self.游泳数据[任务数据[任务id].序列].z),self.游泳数据[任务数据[任务id].序列].x,self.游泳数据[任务数据[任务id].序列].y,1)})
		self.数据[id组[n]]=self.数据[id组[n]]+1
	end
end

function 游泳活动:怪物对话内容(id,类型,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	if not self.活动开关 then
		对话数据.对话="今日游泳比赛活动已经结束，再接再厉吧。"
		return 对话数据
	end
	if 玩家数据[id].角色:取任务(109)~=0 then
		if 任务数据[玩家数据[id].角色:取任务(109)].序列== 任务数据[标识].序列 then
			对话数据.对话="恭喜你们成功抵达，点击我要报道即可。"
			对话数据.选项={"我要报道","我只是路过"}
		else
			对话数据.对话="你现在无法在我这里进行报道，请查看任务说明。"
		end
	else
		对话数据.对话="请先前往傲来国报名官处领取任务。"
	end
	return 对话数据
end

function 游泳活动:对话事件处理(id,名称,事件,类型)
	if 事件=="我要报道" then
		if 玩家数据[id].角色:取任务(109) ==0 then 常规提示(id,"#Y/你没有领取这样的任务") return  end
		if 取队伍人数(id)<3 and 调试模式==false then 常规提示(id,"#Y/进行游泳比赛活动最少必须由三人进行") return  end
		if 取等级要求(id,30)==false then 常规提示(id,"#Y/进行游泳比赛活动至少要达到30级") return  end
		local 比较xy={x=qz(玩家数据[id].角色.地图数据.x/20),y=qz(玩家数据[id].角色.地图数据.y/20)}
		local 假人数据={x=任务数据[玩家数据[id].地图单位.标识].x,y=任务数据[玩家数据[id].地图单位.标识].y}
		if 玩家数据[id].角色.地图数据.编号~=任务数据[玩家数据[id].地图单位.标识].地图编号 or 取两点距离(比较xy,假人数据)>20 then
			return
		end
		local 任务id=玩家数据[id].角色:取任务(109)
		if 任务id==0 then
			常规提示(id,"#Y/请先领取一个任务")
			return
		end
		for n=1,#队伍数据[玩家数据[id].队伍] do
			if 玩家数据[队伍数据[玩家数据[id].队伍][n]].角色:取任务(109)~=任务id then
				常规提示(id,"#Y/队伍中有成员任务不一致")
				return
			end
		end
		if 任务数据[任务id].已战斗 and 取随机数()<=50 then
			任务数据[任务id].已战斗=false
			self:完成游泳任务(id)
		else
			战斗准备类:创建战斗(id+0,100012,玩家数据[id].地图单位.标识)
			任务数据[任务id].已战斗=true
			玩家数据[id].地图单位=nil
		end
	end
end

function 游泳活动:战斗胜利处理(id组,战斗类型,任务id)
	self:完成游泳任务(id组[1])
end

function 游泳活动:完成游泳任务(id)
	local 队伍id=玩家数据[id].队伍
	local 任务id=玩家数据[id].角色:取任务(109)
	local qx = true
	if 任务数据[任务id].序列<20 then
		任务数据[任务id].序列=任务数据[任务id].序列+1
		发送数据(玩家数据[id].连接id,1501,{名称=任务数据[任务id].序列.."号裁判",模型="雨师",对话=format("报道成功，现在请立即前往#Y/%s(%s,%s)#W/的%s号裁判报道。",取地图名称(self.游泳数据[任务数据[任务id].序列].z),self.游泳数据[任务数据[任务id].序列].x,self.游泳数据[任务数据[任务id].序列].y,任务数据[任务id].序列)})
		qx=false
	end
	local 链接
	for n=1,#队伍数据[队伍id].成员数据 do
		local cyid=队伍数据[队伍id].成员数据[n]
		local 等级=玩家数据[cyid].角色.等级
		local 经验=qz(等级*取随机数(1550,1800))
		local 银子=qz(等级*取随机数(105,125))+10000
		local 仙玉=qz(等级*取随机数(1,5))
		玩家数据[cyid].角色:添加经验(经验*HDPZ["游泳比赛"].经验,"游泳比赛",1)
		玩家数据[cyid].角色:添加银子(qz((银子+7000)*0.8*HDPZ["游泳比赛"].银子),"游泳比赛",1)
		玩家数据[cyid].角色:添加仙玉(等级*取随机数(1,5))
		if qx then
			玩家数据[cyid].角色:取消任务(任务id)
			添加最后对话(cyid,"恭喜你们成功完成了一轮游泳比赛，去找傲来国#R/游泳报名官#W/继续比赛吧。")
		else
			玩家数据[cyid].角色:刷新任务跟踪()
		end

		if 取随机数()<=HDPZ["游泳比赛"].爆率 then
			local 链接={提示=format("#S(游泳比赛)#G/%s#Y经过一番激烈的追逐和竞争，游泳试练官员随手奖励了他",玩家数据[cyid].角色.名称),频道="hd",结尾="#Y一个！".."#"..取随机数(1,110)}
							local 名称,数量,参数=生成产出(产出物品计算(HDPZ["游泳比赛"].ITEM),"游泳比赛")
							if 数量== 9999 then --环
								玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
							else
								玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
			end
		end
	end
end

function 游泳活动:任务说明(玩家id,任务id)
	local 说明 = {}
	if not self.活动开关 or not self.数据[玩家id] then
		说明={"游泳比赛",format("活动已经结束。")}
		return 说明
	end
	说明={"游泳比赛",format("请立即前往#Y/%s#L/找到".."#R/qqq|%s号裁判*%s*临时npc*%s*%s/%s号裁判".."#W报道，当前第#Y%s#W轮。",取地图名称(self.游泳数据[任务数据[任务id].序列].z),任务数据[任务id].序列,self.游泳数据[任务数据[任务id].序列].z,self.游泳数据[任务数据[任务id].序列].x,self.游泳数据[任务数据[任务id].序列].y,任务数据[任务id].序列,self.数据[玩家id])}
	return 说明
end

function 游泳活动:加载公共数据()
	self.游泳数据={
		{z=1092,x=208,y=19,f=1}
		,{z=1514,x=43,y=16,f=1}
		,{z=1514,x=101,y=103,f=0}
		,{z=1118,x=53,y=38,f=1}
		,{z=1119,x=52,y=22,f=1}
		,{z=1119,x=5,y=21,f=0}
		,{z=1532,x=58,y=37,f=1}
		,{z=1532,x=8,y=30,f=0}
		,{z=1121,x=8,y=7,f=0}
		,{z=1121,x=34,y=39,f=0}
		,{z=1120,x=8,y=32,f=0}
		,{z=1120,x=53,y=29,f=1}
		,{z=1118,x=26,y=39,f=0}
		,{z=1116,x=88,y=15,f=0}
		,{z=1116,x=206,y=61,f=1}
		,{z=1116,x=78,y=101,f=1}
		,{z=1506,x=113,y=6,f=0}
		,{z=1506,x=104,y=63,f=0}
		,{z=1092,x=132,y=142,f=0}
		,{z=1092,x=201,y=45,f=1}
	}
end
return 游泳活动