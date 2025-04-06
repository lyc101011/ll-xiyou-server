-- @Author: baidwwy
-- @Date:   2024-03-05 15:36:07
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-01-07 09:35:45
local 门派闯关 = class()

function 门派闯关:初始化()
	self.数据={}
	self.活动开关=false
	self.活动时间=QJHDSJ["门派闯关"]
end

function 门派闯关:活动定时器()
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

function 门派闯关:取活动开关() --挂机
	if self.活动开关 then
		return true
	end
	return false
end

function 门派闯关:开启活动()
	self.开启Time=os.time()+7200
	self.活动开关=true
	for n=1,15 do
		local 任务id=取唯一任务(106)
		local 地图范围=取门派地图(Q_门派编号[n])
		local 地图=地图范围[1]
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			销毁=true,
			结束=7200,
			玩家id=0,
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
	广播消息({内容="#G/门派闯关活动已经开启，各位玩家可以前往长安城#R/门派闯关活动使者#G/处开启闯关活动#32",频道="hd"})
	发送公告("#G门派闯关活动已经开启，各位玩家可以前往长安城门派闯关活动使者处开启闯关活动")
end

function 门派闯关:关闭活动()
	self.数据={}
	self.活动开关=false
	self.开启Time=nil
	发送公告("#R(门派闯关)#W活动已经结束，已处战斗中的玩家在战斗结束后依然可以获得奖励。感谢大家的参与！")
	广播消息({内容=format("#R(门派闯关)#W活动已经结束，已处战斗中的玩家在战斗结束后依然可以获得奖励。感谢大家的参与！"),频道="hd"})
end

__GWdh111[106]=function(连接id,id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	if 玩家数据[id].角色:取任务(107)~=0 then
		if 任务数据[玩家数据[id].角色:取任务(107)].当前序列== 任务数据[标识].序列 then
			对话数据.对话="你们是否已经做好了接受考验的准备？"
			对话数据.选项={"请出招吧","我再准备准备"}
		else
			对话数据.对话="你当前应该前往#G/"..Q_门派编号[任务数据[玩家数据[id].角色:取任务(107)].当前序列].."#W/接受考验。"
		end
	else
		对话数据.对话="请先前往长安城门派闯关使者处领取任务。"
	end
	return 对话数据
end

function 门派闯关:怪物对话内容(id,类型,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	if not self.活动开关 then
		对话数据.对话="今日门派闯关活动已经结束，再接再厉吧。"
		return 对话数据
	end
	local 名称 = 任务数据[标识].名称
	if 玩家数据[id].角色:取任务(107)~=0 then
		if 任务数据[玩家数据[id].角色:取任务(107)].当前序列== 任务数据[标识].序列 then
			对话数据.对话="你们是否已经做好了接受考验的准备？"
			对话数据.选项={"请出招吧","我再准备准备"}
		else
			对话数据.对话="你当前应该前往#G/"..Q_门派编号[任务数据[玩家数据[id].角色:取任务(107)].当前序列].."#W/接受考验。"
		end
	else
		对话数据.对话="请先前往长安城门派闯关使者处领取任务。"
	end
	return 对话数据
end

__GWdh222[106]=function (连接id,id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 事件=="请出招吧" then
		if 玩家数据[id].角色:取任务(107) ==0 then 常规提示(id,"#Y/你没有领取这样的任务") return  end
		if not 调试模式 and ( 玩家数据[id].队伍==0 or 取队伍人数(id)<3 or 取队伍最低等级(玩家数据[id].队伍,40)) then
			添加最后对话(id,"门派闯关参与条件：≥40级，≥3人")
			return
		elseif 玩家数据[id].队长==false then
			添加最后对话(id,"这种重要的事情还是让队长来吧！")
			return
		end
		local 比较xy={x=qz(玩家数据[id].角色.地图数据.x/20),y=qz(玩家数据[id].角色.地图数据.y/20)}
		local 假人数据={x=任务数据[玩家数据[id].地图单位.标识].x,y=任务数据[玩家数据[id].地图单位.标识].y}
		if 玩家数据[id].角色.地图数据.编号~=任务数据[玩家数据[id].地图单位.标识].地图编号 or 取两点距离(比较xy,假人数据)>20 then
			return
		end

		local 任务id=玩家数据[id].角色:取任务(107)
		for n=1,#队伍数据[玩家数据[id].队伍] do
			if 玩家数据[队伍数据[玩家数据[id].队伍][n]].角色:取任务(107) ~=任务id then
				常规提示(id,"#Y/队伍中有成员任务不一致")
				return
			end
		end
		战斗准备类:创建战斗(id+0,100011,玩家数据[id].地图单位.标识)
		任务数据[玩家数据[id].地图单位.标识].zhandou=true
		玩家数据[id].地图单位=nil
		return
	end
end

function 门派闯关:对话事件处理(id,名称,事件)
	if 事件=="准备好了，请告诉我们第一关的挑战地点" then
		if not self.活动开关  then --测试模式
			添加最后对话(id,"当前不是活动时间~")
			return
		elseif not 调试模式 and ( 玩家数据[id].队伍==0 or 取队伍人数(id)<3 or 取队伍最低等级(玩家数据[id].队伍,40)) then
			添加最后对话(id,"门派闯关参与条件：≥40级，≥3人")
			return
		elseif 玩家数据[id].队长==false then
			添加最后对话(id,"这种重要的事情还是让队长来吧！")
			return
		end
		local go=true
		local 队伍id=玩家数据[id].队伍
		for n=1,#队伍数据[队伍id].成员数据 do
			local cyid=队伍数据[队伍id].成员数据[n]
			if self.数据[cyid] and self.数据[cyid].取消>os.time() then
				添加最后对话(id,玩家数据[cyid].角色.名称.."在五分钟内取消过任务，需等待五分钟后才可以继续任务哦。")
				if cyid~=id then
					添加最后对话(cyid,"取消任务后，需等待5分钟后才可以继续领取。")
				end
				return
			end
			if 玩家数据[cyid].角色:取任务(107)~=0 then
				常规提示(cyid,"你已经有了一个这样的任务了！")
				if cyid~=id then
					添加最后对话(id,玩家数据[cyid].角色.名称.."已经领取过任务了")
				end
				go=false
				break
			end
		end
		if go then
			self:添加闯关任务(id)
		end
	elseif 事件=="取消任务" then
		local 任务id=玩家数据[id].角色:取任务(107)
		if 任务id~=0 then
			玩家数据[id].角色:取消任务(任务id)
			if self.活动开关 and self.数据[id] then
				if self.数据[id]==nil then
					self.数据[id]={次数=0,取消=0}
				end
				self.数据[id].取消=os.time()+300
			end
			添加最后对话(id,"已成功取消，并清空任务次数。5分钟可再次领取。")
		else
			添加最后对话(id,"你没有这样的任务哦。")
		end
	end
end

function 门派闯关:添加闯关任务(id)
	local 任务id,ZU=取唯一任务(107,id)
	任务数据[任务id]={
		id=任务id,
		DWZ=ZU,
		销毁=true,
		起始=os.time(),
		结束=3600,
		队伍组={},
		类型=107
	}
	任务数据[任务id].闯关序列=table.loadstring(table.tostring(Q_门派编号))
	任务数据[任务id].当前序列=取随机数(1,#任务数据[任务id].闯关序列)
	for n=1,#任务数据[任务id].闯关序列 do
		任务数据[任务id].闯关序列[n]=n
	end
	if self.数据[id]==nil then
		self.数据[id]={次数=0,取消=0}
	end
	self.数据[id].次数=self.数据[id].次数+1
	local 队伍id=玩家数据[id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local cyid=队伍数据[队伍id].成员数据[n]
		if self.数据[cyid]==nil then
			self.数据[cyid]={次数=0,取消=0}
		end
		self.数据[cyid].次数=self.数据[id].次数
		添加最后对话(cyid,"欢迎参加门派闯关竞赛，你们的第一关是"..Q_门派编号[任务数据[任务id].当前序列].."，请速去挑战闯关。")
		玩家数据[cyid].角色:添加任务(任务id)
	end
end

function 门派闯关:战斗胜利处理(id组,战斗类型)
	local id=id组[1]
	local 删除序列=0
	local 任务id=玩家数据[id].角色:取任务(107)
	if 任务id==0 then
		return
	end
	for n=1,#任务数据[任务id].闯关序列 do
		if 任务数据[任务id].闯关序列[n]==任务数据[任务id].当前序列 then
			删除序列=n
		end
	end
	table.remove(任务数据[任务id].闯关序列,删除序列)
	local qx = false
	if #任务数据[任务id].闯关序列==0 then
		qx=true
	else
		任务数据[任务id].当前序列=任务数据[任务id].闯关序列[取随机数(1,#任务数据[任务id].闯关序列)]
	end
	for n=1,#id组 do
		local cyid=id组[n]
		local 等级=玩家数据[cyid].角色.等级
		local 经验=等级*取随机数(1200,1500)+25000
		local 银子=等级*160+10000
		local 仙玉=等级*取随机数(1,3)
		玩家数据[cyid].角色:添加经验(经验*HDPZ["门派闯关"].经验,"门派闯关",1)
		玩家数据[cyid].角色:添加银子(银子*HDPZ["门派闯关"].银子,"门派闯关",1)
		玩家数据[cyid].角色:添加仙玉(等级*取随机数(1,3))
		if qx then
			玩家数据[cyid].角色:取消任务(玩家数据[cyid].角色:取任务(107))
			添加最后对话(cyid,"恭喜你们完成了本轮门派闯关活动#1")
			if 取随机数()<=5  then
				local 链接1 = {提示=format("#P(门派闯关)#R%s#Y成功完成了一轮任务，因表现突出，唐王奖励其",玩家数据[cyid].角色.名称),频道="hd",结尾="#Y一个。"}
				玩家数据[cyid].道具:给予超链接书铁(cyid,{15,15},nil,链接1,"成功")
			end
		else
			self:设置奖励(cyid)
			玩家数据[cyid].角色:刷新任务跟踪()
			发送数据(玩家数据[cyid].连接id,1501,{名称=任务数据[任务id].名称,模型=任务数据[任务id].模型,对话="恭喜你们挑战过关，你们下一关是挑战#Y"..Q_门派编号[任务数据[任务id].当前序列].."#W，请速去挑战闯关。"})
		end
	end
end

function 门派闯关:设置奖励(id)
	if 取随机数()<=HDPZ["门派闯关"].爆率 then
		local 链接 = {提示=format("#P(门派闯关)#R%s#Y在门派闯关活动中喜获",玩家数据[id].角色.名称),频道="hd",结尾="#Y一个。"}
						local 名称,数量,参数=生成产出(产出物品计算(HDPZ["门派闯关"].ITEM),"门派闯关")
						if 数量== 9999 then --环
							玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
						else
									玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
						end
	end

end

function 任务说明107(玩家id,任务id)
	local 说明 = {}
	说明={"门派闯关",format("你已通过#R/%s#L/关，当前第#R/%s#L/关，挑战关卡是#R/%s#L/。",15-#任务数据[任务id].闯关序列,16-#任务数据[任务id].闯关序列,Q_门派编号[任务数据[任务id].当前序列])}
	return 说明
end

return 门派闯关