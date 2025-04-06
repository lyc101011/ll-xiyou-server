-- @Author: baidwwy
-- @Date:   2024-11-01 04:09:49
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-09 11:20:55
local 帮派PK = class()

function 帮派PK:初始化()
	self:清空数据()
	self:加载公共数据()
	self.活动时间=QJHDSJ["帮战"]
end

function 帮派PK:活动定时器()
	if self.活动开关 then
		if self.活动结束 then
			if self.宝箱开关 then --
				if self.宝箱Time-os.time()<=300 then --这里主动结束，需要附加 self.宝箱Time=600
					self:发放帮战宝箱()
					self.宝箱开关=false
				end
			else
				if self.宝箱Time-os.time()<=0 then
					print("关闭活动")
					self:关闭活动()--清空
				end
			end
		else
			if self.正式开始 then --打怪时间
				if os.time()>= 300+self.刷怪Time then
					print("刷出场景怪")
					self:刷出场景怪()
					self.刷怪Time=os.time()
				end
				if self.开始Time-os.time()<600 then --最后10分钟，关闭打怪 计算胜利  如果已分胜负，那么活动开关将会处于关闭状态
					print("强制计算胜利方")
					self:强制计算胜利方()
				end
			else
				if self.进场开关==false and self.进场Time-os.time()<0 then --5分钟后 开启进场
					print("开启帮战进场")
					self:开启帮战进场()--计算哪两个帮派PK
					self.进场开关 = true
				elseif self.正式Time~=nil and self.正式Time-os.time()<0 then --10分钟后 正式开始 正式开始为关闭状态
					print("正式开始帮战")
					self:正式开始帮战()
					self.正式Time=nil
				end
			end
		end
	else
		if self.活动时间.日期=="每天" then
			if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
				print("开启帮战报名")
				self:开启帮战报名()
			end
		else
			local zhouji=tonumber(os.date("%w", os.time()))
			if zhouji==self.活动时间.日期 then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
					print("开启帮战报名")
					self:开启帮战报名()
				end
			elseif self.活动时间.日期=="周135" and (zhouji==1 or zhouji==3 or zhouji==5) then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
					print("开启帮战报名")
					self:开启帮战报名()
				end
			elseif self.活动时间.日期=="周246" and (zhouji==2 or zhouji==4 or zhouji==6) then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
					print("开启帮战报名")
					self:开启帮战报名()
				end
			end
		end
	end
end

function 帮派PK:开启帮战报名()
	self:清空数据()
	self.进场Time=os.time()+300
	self.活动开关=true
	if 取偶数(取星期几()) then
		self.夺旗活动=true
		广播消息({内容="#G帮派竞赛活动已经开启报名，想要一展拳脚的帮派可到长安找到帮派竞赛主持人处报名参赛！！！#Y（今日帮战活动为帮战夺旗）",频道="xt"})
		发送公告("#G帮派竞赛活动已经开启报名，想要一展拳脚的帮派可到长安找到帮派竞赛主持人处报名参赛！！！#Y（今日帮战活动为帮战夺旗）")
	else
		self.砍树活动=true
		广播消息({内容="#G帮派竞赛活动已经开启报名，想要一展拳脚的帮派可到长安找到帮派竞赛主持人处报名参赛！！！#Y（今日帮战活动为帮战伐木）",频道="xt"})
		发送公告("#G帮派竞赛活动已经开启报名，想要一展拳脚的帮派可到长安找到帮派竞赛主持人处报名参赛！！！#Y（今日帮战活动为帮战伐木）")
	end
end

function 帮派PK:正式开始帮战()
	self.开始Time=os.time()+4200+600 --1小时10分钟+刷箱子10分钟
	self.刷怪Time=os.time()
	self.正式开始=true
	广播消息({内容="#S(帮派竞赛)#G/帮派竞赛已经开始，为了帮派的强大和繁荣贡献出自己的一份力量吧！",频道="xt"})
	发送公告("#S(帮派竞赛)#G/帮派竞赛已经开始，为了帮派的强大和繁荣贡献出自己的一份力量吧！")
end

function 帮派PK:关闭活动()
	self:清空数据()
end

function 帮派PK:清空数据()
	self.已报名={}
	self.参赛帮派={}
	self.是否参战={}
	self.玩家表={蓝方={成员={},参战=0,击败=0,完成度=0},红方={成员={},参战=0,击败=0,完成度=0}}
	self.死亡数据={}
	self.胜利方="无"
	self.砍树活动=false
	self.夺旗活动=false
	self.活动开关=false
	self.进场开关=false
	self.正式开始=false
	self.活动结束=false
	self.宝箱开关=false
	self.蓝方玩家 = 0
	self.红方玩家 = 0
	self.夺旗ID={}
	self.开始Time=nil
	self.刷怪Time=nil
	self.进场Time=nil
	self.正式Time=nil
	self.宝箱Time=nil
end

function 帮派PK:怪物对话内容(id,类型,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	if 类型==1202 then--伐木工
		对话数据.对话="你们想干嘛？别妨碍我工作啊~！"
		对话数据.选项={"我们需要你的木材","没事，我随便看看"}
	elseif 类型==1203 then --伐木兔子
		if 任务数据[标识].zhandou==nil then
			对话数据.对话="#18鬼鬼祟祟#18鬼鬼祟祟#18鬼鬼祟祟！"
			对话数据.选项={"鬼鬼祟祟一看就不是好兔","没事，我随便看看"}
		else
			对话数据.对话="我正在战斗中，请勿打扰。"
		end
	elseif 类型==1204 then --伐木泡泡
		self:戳泡泡(id,标识)
		return
	elseif 类型==1205 then --宝箱
		self:开启宝箱(id,标识)
		return
	elseif 类型==1206 then --蓝
		if self.活动结束 then
			对话数据.对话="活动已经结束！"
			return 对话数据
		end
		if 任务数据[标识].zhandou==nil then
			if 任务数据[标识].被抢夺==false then
				if self.玩家表["蓝方"].成员[id]~=nil then
					if self.夺旗ID[id]~=nil then
						对话数据.对话="我就说传说中的那啥那啥的红旗手#17你们一定要把我看照的水泄不通哦，敌人如果从我这里抢走了本帮镇帮之旗，咱们就输啦#32"
						对话数据.选项={"上交红方帮派旗帜","没事，你继续做好准备吧"}
					else
						对话数据.对话="我就说传说中的那啥那啥的红旗手#17你们一定要把我看照的水泄不通哦，敌人如果从我这里抢走了本帮镇帮之旗，咱们就输啦#32"
						对话数据.选项={"移动到我这里","没事，你继续做好准备吧"}
					end
				elseif self.玩家表["红方"].成员[id]~=nil then
					任务数据[标识].zhandou=true
					战斗准备类:创建战斗(id+0,130086,标识)
					return
				end
			else
				if self.玩家表["蓝方"].成员[id]~=nil then
					对话数据.对话="我们的旗子被对方抢走啦！还不快去抢回来。"
				end
			end
		else
			对话数据.对话="我正在战斗中，请勿打扰。"
		end
	elseif 类型==1207 then --红
		if self.活动结束 then
			对话数据.对话="活动已经结束！"
			return 对话数据
		end
		if 任务数据[标识].zhandou==nil then
			if 任务数据[标识].被抢夺==false then
				if self.玩家表["红方"].成员[id]~=nil then
					if self.夺旗ID[id]~=nil then
						对话数据.对话="我就说传说中的那啥那啥的红旗手#17你们一定要把我看照的水泄不通哦，敌人如果从我这里抢走了本帮镇帮之旗，咱们就输啦#32"
						对话数据.选项={"上交蓝方帮派旗帜","没事，你继续做好准备吧"}
					else
						对话数据.对话="我就说传说中的那啥那啥的红旗手#17你们一定要把我看照的水泄不通哦，敌人如果从我这里抢走了本帮镇帮之旗，咱们就输啦#32"
						对话数据.选项={"移动到我这里","没事，你继续做好准备吧"}
					end
				elseif self.玩家表["蓝方"].成员[id]~=nil then
					任务数据[标识].zhandou=true
					战斗准备类:创建战斗(id+0,130086,标识)
					return
				end
			else
				if self.玩家表["红方"].成员[id]~=nil then
					对话数据.对话="我们的旗子被对方抢走啦！还不快去抢回来。"
				end
			end
		else
			对话数据.对话="我正在战斗中，请勿打扰。"
		end
	elseif 类型==1209 then --守卫
		if self.活动结束 then
			对话数据.对话="活动已经结束！"
			return 对话数据
		end
		if 任务数据[标识].zhandou==nil then
			local dh={
				[1]="胆小的怕胆大的，胆大的怕不要命的#67你属于哪个#55",
				[2]="这位少侠，看你这么严肃的样子，是不是觉得我们帮的兵种搭配和兵力分布有问题？#24如果你有更好的兵力配置计划，可以向我们帮主建议哦#81",
				[3]="抢回他们的旗，我把你奉为偶终生的偶像#89",
				[4]="飘逸的步法，灵敏的身手是找到对方“帮派护法”必备的技能#76",
				[5]="你可要保护好我哦，如果敌人把我喀嚓了，咱们会有可能会输的#17",
				[6]="别乱点，都是自家人#69",
			}
			if self.玩家表[任务数据[标识].归属方].成员[id]~=nil then
				对话数据.对话=dh[取随机数(1,#dh)]
				对话数据.选项={"移动到我这里","没事，你继续做好准备吧"}
			end
		else
			对话数据.对话="我正在战斗中，请勿打扰。"
		end
	end
	return 对话数据
end

function 帮派PK:怪物对话处理(id,名称,事件,类型,RWID)
	if 类型==1202 then--伐木工
		if 事件=="我们需要你的木材" then
			if not self.正式开始 then
				添加最后对话(id,"没错，我就说传说中玉树临风赛潘安，一朵梨花压海棠……&*&*&&&*（以下省略2万字）的……伐木工#17就连鲁班都夸过我的手艺呢。不过比赛还没开始，你一会儿再来找我吧")
				return
			elseif self.活动结束 then
				添加最后对话(id,"你们已经不需要我的木材了！")
				return
			end
			local 归属=任务数据[RWID].归属方
			if 归属~="无" and self.玩家表[归属].成员[id]~=nil then
				添加最后对话(id,"我没偷懒#17这不正干着嘛#74")
				return
			end
			战斗准备类:创建战斗(id,130083,RWID)
		end
	elseif 类型==1203 then--伐木兔子
		if 事件=="鬼鬼祟祟一看就不是好兔" then
			if 任务数据[RWID].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
			战斗准备类:创建战斗(id,130084,RWID)
			任务数据[RWID].zhandou=true
		end
	elseif 类型==1206 or 类型==1207 then --夺旗旗子
		if self.活动结束 then
			添加最后对话(id,"活动已经结束！")
			return
		end
		if 任务数据[RWID].zhandou==nil then
			if 事件=="移动到我这里" then
				local bh = 玩家数据[id].角色.BPBH
				if self.已报名[bh] and 玩家数据[id].角色.BPMC ~= "无帮派" and 帮派数据[bh] and 帮派数据[bh].成员数据[id].权限>=3 then
				else
					添加最后对话(id,"需报名帮派护法以上权限才能进行此操作")
					return
				end
				if os.time()-任务数据[RWID].移动CD<=4 then
					常规提示(id,"#Y/移动我太频繁了，人家走来走去很累的（两次移动间隔必须大于4秒）")
					return
				end
				local 玩家x=math.floor(玩家数据[id].角色.地图数据.x/20)
				local 玩家y=math.floor(玩家数据[id].角色.地图数据.y/20)
				地图处理类:npc行走(任务数据[RWID].地图编号,任务数据[RWID].单位编号,玩家x,玩家y)
				任务数据[RWID].移动CD=os.time()
			elseif 事件=="上交蓝方帮派旗帜" or 事件=="上交红方帮派旗帜" then
				self:上交旗子(id)
			end
		else
			添加最后对话(id,"我正在战斗中，请勿打扰。")
			return
		end
	elseif 类型==1209 then --夺旗旗子
		if self.活动结束 then
			添加最后对话(id,"活动已经结束！")
			return
		end
		if 任务数据[RWID].zhandou==nil then
			if 事件=="移动到我这里" then
				if os.time()-任务数据[RWID].移动CD<=4 then
					常规提示(id,"#Y/移动我太频繁了，人家走来走去很累的（两次移动间隔必须大于4秒）")
					return
				end
				local 玩家x=math.floor(玩家数据[id].角色.地图数据.x/20)
				local 玩家y=math.floor(玩家数据[id].角色.地图数据.y/20)
				地图处理类:npc行走(任务数据[RWID].地图编号,任务数据[RWID].单位编号,玩家x,玩家y)
				任务数据[RWID].移动CD=os.time()
			end
		else
			添加最后对话(id,"我正在战斗中，请勿打扰。")
			return
		end
	end
end

function 帮派PK:对话内容调用(id,名称,事件,类型)
	local 地图 = 玩家数据[id].角色.地图数据.编号
	if 地图==1511 then
		if 名称=="帮派竞赛接引人" then --我要离开此场地帮派竞赛接引人
			地图处理类:跳转地图(id,1092,122,54)
			if self.正式开始 and self.砍树活动 and self.活动结束==false then
				if self.玩家表["蓝方"].成员[id]~=nil then
					self.玩家表["蓝方"].参战=self.玩家表["蓝方"].参战-取队伍人数(id)
					if self.正式开始 then
						if self.玩家表["蓝方"].参战<=0 then
							self.玩家表["蓝方"].参战=0
							self:计算最终胜利方("红方",nil,"放弃")
						end
					end
				elseif self.玩家表["红方"].成员[id]~=nil then
					self.玩家表["红方"].参战=self.玩家表["红方"].参战-取队伍人数(id)
					if self.正式开始 then
						if self.玩家表["红方"].参战<=0 then
							self.玩家表["红方"].参战=0
							self:计算最终胜利方("蓝方",nil,"放弃")
						end
					end
				end
			end
		end
	elseif 地图==2010 or 地图==2011 then
		if 名称=="帮派竞赛接引人" and 事件=="送我离开这里" then
			if self.夺旗ID[id] then
				常规提示(id,"#Y/你身上有敌方旗帜在身，无法离开比赛场地")
				return
			else
				地图处理类:跳转地图(id,1092,122,54)
			end
			if self.正式开始 and self.夺旗活动 and self.活动结束==false then
				if self.玩家表["蓝方"].成员[id]~=nil then
					self.玩家表["蓝方"].参战=self.玩家表["蓝方"].参战-取队伍人数(id)
					if self.正式开始 then
						if self.玩家表["蓝方"].参战<=0 then
							self.玩家表["蓝方"].参战=0
							self:计算最终胜利方("红方",nil,"放弃")
						end
					end
				elseif self.玩家表["红方"].成员[id]~=nil then
					self.玩家表["红方"].参战=self.玩家表["红方"].参战-取队伍人数(id)
					if self.正式开始 then
						if self.玩家表["红方"].参战<=0 then
							self.玩家表["红方"].参战=0
							self:计算最终胜利方("蓝方",nil,"放弃")
						end
					end
				end
			end
		end
	end
end

function 帮派PK:NPC对话事件处理(id,名称,事件,地图ID)
	if 名称=="帮派竞赛主持人" then
		if 事件=="我来领取帮战奖励" then
			-- 添加最后对话(id,"这种重要的事情还是让队长来吧！")
			return
		end
		if self.活动开关 then
			if 玩家数据[id].队伍~=0 and 玩家数据[id].队长==false then
				添加最后对话(id,"这种重要的事情还是让队长来吧！")
				return
			end
			if 事件=="我要报名参赛（帮派）" then
				if self.活动结束 then
					常规提示(id,"#Y/帮战活动已经结束。")
					return
				elseif self.进场开关 then --not 调试模式 and
					添加最后对话(id,"活动已经开始了哦#1")
					return
				end
				local 报名费用=500000
				local bh = 玩家数据[id].角色.BPBH
				if 玩家数据[id].角色.BPMC == "无帮派" or 帮派数据[bh]==nil or 取所有帮派[bh]==nil or 取所有帮派[bh].已解散 or 帮派数据[bh].成员数据[id].权限<4  then
					添加最后对话(id,"帮战报名需要副帮主以上权限！")
					return
				end
				if self.已报名[bh] then
					添加最后对话(id,"你们帮派已经报过名了！")
					return
				end
				if 帮派数据[bh].帮派资金.当前<报名费用 then
					添加最后对话(id,"贵帮帮派资金不足"..报名费用.."两，无法报名帮派竞赛啊！")
					return
				end
				发送数据(玩家数据[id].连接id,78)--报名费用缴纳
			elseif 事件=="我要报名参赛（个人或队伍）" then
				if self.活动结束 then
					添加最后对话(id,"帮战活动已经结束。")
					return
				elseif self.进场开关==false then
					添加最后对话(id,"请等待帮派报名结束才能开始个人报名")
					return
				end
				local 队伍id = 玩家数据[id].队伍
				if 队伍id ~= 0 then
					if 取队伍人数(id)<3 then
						添加最后对话(id,"组队报名至少得3人组队！")
						return
					end
					for n=1,#队伍数据[队伍id].成员数据 do
						local cyid = 队伍数据[队伍id].成员数据[n]
						if self.玩家表["蓝方"].成员[cyid]~=nil or self.玩家表["红方"].成员[cyid]~=nil then
							添加最后对话(id,"队伍中"..玩家数据[cyid].角色.名称.."已经报过名了！")
							return
						end
					end
				end
				if self.玩家表["蓝方"].成员[id]~=nil or self.玩家表["红方"].成员[id]~=nil then
					添加最后对话(id,"你已经报过名了！")
					return
				end
				self:分配阵营(id)
				常规提示(id,"报名成功，请注意入场时间！")
			elseif 事件=="送我去比赛场地--送到赛场" then
				if not self.进场开关 then
					添加最后对话(id,"请耐心等待进场通知！（开启报名5分钟后可进场，且满足两个帮派参赛）")
					return
				end
				if 玩家数据[id].角色.飞行中 then
					常规提示(id,"#Y/飞行状态下无法进入此地图！")
					return
				end
				if self.死亡数据[id] and self.死亡数据[id]<=0 then
					常规提示(id,"#Y/今日帮战死亡次数为0无法继续比赛")
					return
				end
				if self.胜利方=="无" or self.玩家表[self.胜利方].成员[id] then
					self:进入地图检查阵营(id)
					if self.玩家表["蓝方"].成员[id] then
						if self.砍树活动 then
							地图处理类:跳转地图(id,1511,23,33)
						elseif self.夺旗活动 then
							地图处理类:跳转地图(id,2010,134,13)
						end
					elseif self.玩家表["红方"].成员[id] then
						if self.砍树活动 then
							地图处理类:跳转地图(id,1511,123,81)
						elseif self.夺旗活动 then
							地图处理类:跳转地图(id,2011,134,13)
						end
					end
				else
					添加最后对话(id,"胜负已分！下次再接再厉吧。")
				end
			elseif 事件=="查看对战表" then
				local hh="帮派竞赛因报名帮派数量少于2个帮派，或未开始活动！暂时无法查看对战表！"
				if self.进场开关 then
					hh="帮派竞赛帮派竞赛报名对决如下：\n\n#S"..self.参赛帮派[1].帮派名称.."#W".."  VS  ".."#R"..self.参赛帮派[2].帮派名称
				end
				添加最后对话(id,hh)
			end
		else
			添加最后对话(id,"当前不是帮派竞赛报名时间！")
			return
		end
	end
end

function 帮派PK:进入地图检查阵营(id)
	local 队伍id = 玩家数据[id].队伍
	local zy = "蓝方"
	if self.红方玩家 <= self.蓝方玩家 then
		zy = "红方"
	end
	if self.玩家表["红方"].成员[id]~=nil or self.玩家表["蓝方"].成员[id]~=nil then
		if self.玩家表["红方"].成员[id] then
			zy="红方"
		else
			zy="蓝方"
		end
	end
	if 队伍id ~= 0 then
		for n=1,#队伍数据[队伍id].成员数据 do
			local cyid=队伍数据[队伍id].成员数据[n]
			if zy == "红方" then
				if self.玩家表["红方"].成员[cyid]==nil then
				   self.红方玩家 = self.红方玩家+1
				end
				if self.是否参战[cyid]==nil then
					self.是否参战[cyid]=1
					self.玩家表["红方"].参战=self.玩家表["红方"].参战+1
				end
				self.玩家表["红方"].成员[cyid]=0
			else
				if self.玩家表["蓝方"].成员[cyid]==nil then
				   self.蓝方玩家 = self.蓝方玩家+1
				end
				if self.是否参战[cyid]==nil then
					self.是否参战[cyid]=1
					self.玩家表["蓝方"].参战=self.玩家表["蓝方"].参战+1
				end
				self.玩家表["蓝方"].成员[cyid]=0
			end
			地图处理类:系统更新称谓(cyid,zy)
			发送数据(玩家数据[cyid].连接id,6570) --发送客户端帮战开关
		end
	else
		if zy == "红方" then
			if self.玩家表["红方"].成员[id]==nil then
			   self.红方玩家 = self.红方玩家+1
			end
			if self.是否参战[id]==nil then
				self.是否参战[id]=1
				self.玩家表["红方"].参战=self.玩家表["红方"].参战+1
			end
			self.玩家表["红方"].成员[id]=0
		else
			if self.玩家表["蓝方"].成员[id]==nil then
				self.蓝方玩家 = self.蓝方玩家+1
			end
			if self.是否参战[id]==nil then
				self.是否参战[id]=1
				self.玩家表["蓝方"].参战=self.玩家表["蓝方"].参战+1
			end
			self.玩家表["蓝方"].成员[id]=0
		end
		地图处理类:系统更新称谓(id,zy)
		发送数据(玩家数据[id].连接id,6570) --发送客户端帮战开关
	end
end

function 帮派PK:分配阵营(id,检查是否报名)
	local 队伍id = 玩家数据[id].队伍
	local zy = "蓝方"
	if self.红方玩家 <= self.蓝方玩家 then
		zy = "红方"
	end
	if 队伍id ~= 0 then
		for n=1,#队伍数据[队伍id].成员数据 do
			local cyid=队伍数据[队伍id].成员数据[n]
			if zy == "红方" then
				self.玩家表["红方"].成员[cyid]=0
				self.红方玩家 = self.红方玩家 + 1
			else
				self.玩家表["蓝方"].成员[cyid]=0
				self.蓝方玩家 = self.蓝方玩家 + 1
			end
		end
	else
		if zy == "红方" then
			self.玩家表["红方"].成员[id]=0
			self.红方玩家 = self.红方玩家+1
		else
			self.玩家表["蓝方"].成员[id]=0
			self.蓝方玩家 = self.蓝方玩家+1
		end
	end
end

function 帮派PK:计算伐木完成度(胜利,num)
	if self.活动结束 then
		return
	end
	self.玩家表[胜利].完成度=self.玩家表[胜利].完成度+num
	if self.玩家表[胜利].完成度>=10000 then
		self.玩家表[胜利].完成度=10000
		self:计算最终胜利方(胜利)
	end
end

function 帮派PK:强制计算胜利方()
	if self.活动结束 then
		return
	end
	local 胜利="蓝方"
	local lannum = self.玩家表["蓝方"].击败
	local hongnum = self.玩家表["红方"].击败
	if self.玩家表["红方"].完成度+hongnum>=self.玩家表["蓝方"].完成度+lannum then
		胜利="红方"
	end
	self:计算最终胜利方(胜利)
end

function 帮派PK:计算最终胜利方(胜利,清场,放弃)
	if self.活动结束 then
		return
	end
	self.胜利方=胜利
	self.活动结束=true
	self.宝箱开关=true
	self.宝箱Time=os.time()+600
	local Win = self.参赛帮派[1].帮派名称 --蓝
	local Fail = self.参赛帮派[2].帮派名称 --红
	if 胜利=="红方" then
		Win = self.参赛帮派[2].帮派名称
		Fail = self.参赛帮派[1].帮派名称
		帮派数据[self.参赛帮派[2].编号].帮派资金.上限 = 帮派数据[self.参赛帮派[2].编号].帮派资金.上限 + 20000000
		帮派数据[self.参赛帮派[2].编号].帮派资金.当前 = 帮派数据[self.参赛帮派[2].编号].帮派资金.当前 + 20000000
	else
		帮派数据[self.参赛帮派[1].编号].帮派资金.上限 = 帮派数据[self.参赛帮派[1].编号].帮派资金.上限 + 20000000
		帮派数据[self.参赛帮派[1].编号].帮派资金.当前 = 帮派数据[self.参赛帮派[1].编号].帮派资金.当前 + 20000000
	end
	广播消息({内容=format("#Y帮派#G%s#Y赢得本场帮派伐木比赛的胜利获得20000000帮派资金！",Win),频道="bp"})
	if self.砍树活动 then
		if 放弃~=nil then
			广播消息({内容=format("#Y最新赛况：由于#R%s#Y提前放弃了比赛，#G%s#Y帮派直接获得了本场比赛的胜利#84#Y。5分钟后将会刷出大宝箱在#G“帮战建设”#Y地图，请大家做好准备！",Fail,Win),频道="bp"})
			return
		end
		if 清场 then
			广播消息({内容=format("#Y最新赛况：皇天不负有心人，经过不懈努力和艰苦奋战，随着#R%s#Y帮派的最后一支队伍被清理出场，帮派#G%s#Y直接获得了本场帮派伐木比赛的胜利#84#Y，5分钟后将会刷出大宝箱在#G“帮战建设”#Y地图，请大家做好准备！",Fail,Win),频道="bp"})
		else
			广播消息({内容=format("#Y最新赛况：皇天不负有心人，经过不懈努力和艰苦奋战，帮派#G%s#Y最终获得了本场帮派伐木比赛的胜利#84#Y。5分钟后将会刷出大宝箱在#G“帮战建设”#Y地图，请大家做好准备！",Win),频道="bp"})
		end
	elseif self.夺旗活动 then
		if 放弃~=nil then
			广播消息({内容=format("#Y最新赛况：由于#R%s#Y提前放弃了比赛，#G%s#Y帮派直接获得了本场比赛的胜利#84。#Y5分钟后将会刷出大宝箱在#G“%s”#Y地图，请大家做好准备！",Fail,Win,胜利),频道="bp"})
			return
		end
		if 清场 then
			广播消息({内容=format("#Y最新赛况：皇天不负有心人，经过不屑努力和艰苦奋战，随着#R%s#Y帮派的最后一支队伍被清理出场，帮派#G%s#Y直接获得了本场帮派夺旗比赛的胜利#84#Y。5分钟后将会刷出大宝箱在#G“%s”#Y地图，请大家做好准备！",Fail,Win,胜利),频道="bp"})
		else
			广播消息({内容=format("#Y最新赛况：皇天不负有心人，经过不屑努力和艰苦奋战，帮派#G%s#Y最终获得了本场帮派夺旗比赛的胜利#84#Y。分钟后将会刷出大宝箱在#G“%s”#Y地图，请大家做好准备！",Win,胜利),频道="bp"})
		end
	end

end

function 帮派PK:进入游戏判断(id)
	if self.进场开关 then
		if self.玩家表["蓝方"].成员[id] or self.玩家表["红方"].成员[id] then
			发送数据(玩家数据[id].连接id,6570) --打开战报
		end
		if self.夺旗ID[id] then
			发送数据(玩家数据[id].连接id,6573,{逻辑=self.夺旗ID[id].旗子颜色})
		end
	end
end

function 帮派PK:铁锤点击(id,内容)
	if self.正式开始==false or self.活动结束 then
		return
	end
	local NPC名称=内容.名称
	local zy="蓝方"
	if self.玩家表["红方"].成员[id]~=nil then
		zy="红方"
	end
	if (zy=="蓝方" and NPC名称=="帮派师爷藍") or (zy=="红方" and NPC名称=="帮派师爷紅") then
		常规提示(id,"#Y/锤子不能乱敲啊，你敲错人了啊#24")
		return
	end
	if 玩家数据[id].道具:消耗背包道具(玩家数据[id].连接id,id,"铁锤",1) then
		if zy=="蓝方" then
			zy="红方"
			self.玩家表["红方"].完成度=self.玩家表["红方"].完成度-100
			if self.玩家表["红方"].完成度<=0 then
				self.玩家表["红方"].完成度=0
			end
		else
			zy="蓝方"
			self.玩家表["蓝方"].完成度=self.玩家表["蓝方"].完成度-100
			if self.玩家表["蓝方"].完成度<=0 then
				self.玩家表["蓝方"].完成度=0
			end
		end
		常规提示(id,"#Y/使用成功！")
		广播消息({内容=format("#S(帮派竞赛)#R/%s#W建筑遭到#G/%s#W的铁锤破坏，建筑完成度降低100点……",zy,玩家数据[id].角色.名称),频道="bp"})
	end
end

function 帮派PK:发起PK(id,内容)
	if 玩家数据[id].队伍 ~= 0 and 玩家数据[id].队长==false then
		常规提示(id,"#Y/只有队长才能触发战斗！")
		return
	end
	local 对手id=内容.序列
	if self.正式开始 then
		if self.活动结束 then
			常规提示(id,"#Y/帮战活动已经结束。")
			return
		end
		local 地图 = 玩家数据[id].角色.地图数据.编号
		if self.砍树活动 and 地图~=1511 then
			return
		elseif self.夺旗活动 and 地图==1511 then
			return
		end
		local zjzy="无"
		local dfzy="无"
		if self.玩家表["蓝方"].成员[id]~=nil then
			zjzy="蓝方"
		elseif self.玩家表["红方"].成员[id]~=nil then
			zjzy="红方"
		else
			常规提示(id,"#Y/少侠，你属于哪个阵营呢？")
			return
		end
		if self.玩家表["蓝方"].成员[对手id]~=nil then
			dfzy="蓝方"
		elseif self.玩家表["红方"].成员[对手id]~=nil then
			dfzy="红方"
		else
			常规提示(id,"#Y/对方现在有点忙，少侠稍候再试吧")
			return
		end
		if zjzy~=dfzy then
			if os.time()-self.玩家表[zjzy].成员[id]<=42 then
				常规提示(id,"#Y/你刚刚失败不久，还不能进行PK")
				return
			elseif os.time()-self.玩家表[dfzy].成员[对手id]<=42 then
				常规提示(id,"#Y/对方处于切磋保护状态，不能进入切磋战斗")
				return
			end
			战斗准备类:创建玩家战斗(id, 200002, 对手id, 地图)
		else
			常规提示(id,"#Y/自己人啊大哥！")
		end
	else
		常规提示(id,"#Y/未到活动竞赛时间不能进入切磋战斗！")
		return
	end
end

function 帮派PK:计算死亡次数(失败,id,队长)
	if self.死亡数据[id]==nil then
		self.死亡数据[id]=0
	end
	local 胜利="蓝方"
	if 失败=="蓝方" then
		胜利="红方"
	end
	self.玩家表[胜利].击败=self.玩家表[胜利].击败+1
	self.死亡数据[id]=self.死亡数据[id]+1
	if self.死亡数据[队长]>=5 then
		if id==队长 then
			玩家数据[队长].zhandou=0
			地图处理类:跳转地图(队长,1092,122,54)
			self.玩家表[失败].参战=self.玩家表[失败].参战-取队伍人数(队长)
			self:添加失败出场奖励(id)
			if self.玩家表[失败].参战<=0 then
				self.玩家表[失败].参战=0
				self:计算最终胜利方(胜利,"清场")
			end
		end
		return false
	else
		if self.活动结束==false then
			self.玩家表[失败].成员[id]=os.time()
			发送数据(玩家数据[id].连接id,6572) --保护时间
			常规提示(id,"#Y/您还有"..(5-self.死亡数据[id]).."次失败机会，失败次数为0时会自动被清理出场！")
		end
		if self.夺旗活动 then
			if id==队长 then
				if 失败=="蓝方" then
					玩家数据[队长].zhandou=0
					地图处理类:跳转地图(队长,2010,134,13)
				elseif 失败=="红方" then
					玩家数据[队长].zhandou=0
					地图处理类:跳转地图(队长,2011,134,13)
				end
			end
		end
	end
	return true
end

function 帮派PK:获取对战信息(连接id)
	-- 发送数据(连接id,6571,{类型="砍树",蓝方={参战=self.玩家表["蓝方"].参战,击败=self.玩家表["蓝方"].击败,完成度=self.玩家表["蓝方"].完成度,帮派名称="蓝方"},红方={参战=self.玩家表["红方"].参战,击败=self.玩家表["红方"].击败,完成度=self.玩家表["红方"].完成度,帮派名称="红方"}})
	if self.进场开关==false then
		return
	end
	if self.砍树活动 then
		发送数据(连接id,6571,{类型="砍树",蓝方={参战=self.玩家表["蓝方"].参战,击败=self.玩家表["蓝方"].击败,完成度=self.玩家表["蓝方"].完成度,帮派名称=self.参赛帮派[1].帮派名称},红方={参战=self.玩家表["红方"].参战,击败=self.玩家表["红方"].击败,完成度=self.玩家表["红方"].完成度,帮派名称=self.参赛帮派[2].帮派名称}})
	elseif self.夺旗活动 then
		发送数据(连接id,6571,{类型="夺旗",蓝方={参战=self.玩家表["蓝方"].参战,击败=self.玩家表["蓝方"].击败,完成度=self.玩家表["蓝方"].完成度,帮派名称=self.参赛帮派[1].帮派名称},红方={参战=self.玩家表["红方"].参战,击败=self.玩家表["红方"].击败,完成度=self.玩家表["红方"].完成度,帮派名称=self.参赛帮派[2].帮派名称}})
	end
end

function 帮派PK:帮战报名处理(id,数据)
	local 报名费用=tonumber(数据.文本)
	local bh = 玩家数据[id].角色.BPBH
	local 现任帮主=帮派数据[bh].现任帮主.名称
	local 帮主id=帮派数据[bh].现任帮主.id
	local 帮派名称=帮派数据[bh].帮派名称
	报名费用=qz(报名费用)
	if 帮派数据[bh].帮派资金.当前<报名费用 or 报名费用<500000 then
		添加最后对话(id,"贵帮帮派资金不足500000两，无法报名帮派竞赛！")
		return
	end
	if self.已报名[bh] then
		添加最后对话(id,"你们帮派已经报过名了！")
		return
	end
	帮派数据[bh].帮派资金.当前=帮派数据[bh].帮派资金.当前-报名费用
	self.已报名[bh]=true
	self.参赛帮派[#self.参赛帮派+1]={报名费用=报名费用,编号=bh,帮派名称=帮派名称}
	常规提示(id,"#Y帮派竞赛报名成功，等待报名结束，系统自动截取报名费用前2的帮派进行帮派竞赛！")
	广播消息({内容="#S(帮派竞赛)#W帮派:#G"..帮派名称.."#W报名帮派竞赛成功！",频道="xt"})
	帮派处理:增加当前内政(bh,1000,"提示")
	-- if 调试模式 and #self.参赛帮派>=2 then --要删除
	-- 	self:开启帮战进场()
	-- end
end

function 帮派PK:开启帮战进场()
	if #self.参赛帮派<2 then
		发送公告("#S(帮派竞赛)#Y/因报名帮派数量少于2个帮派，无法开启帮派建设！")
		self:清空数据()
		return
	end
	table.sort(self.参赛帮派, function (a,b) return a.报名费用>b.报名费用 end )
	local 发送信息="#S(帮派竞赛)#Y/帮派竞赛报名已结束，对决如下：\n   #S"..self.参赛帮派[1].帮派名称.."  #YVS  #R"..self.参赛帮派[2].帮派名称.."\n   #Y未上榜的或无帮派人员可以通过长安的帮派竞赛主持人进行报名，5分钟后将正式开始帮派竞赛！"
	for k,v in pairs(帮派数据[self.参赛帮派[1].编号].成员数据) do
		self.玩家表["蓝方"].成员[v.id]=0
	end
	for k,v in pairs(帮派数据[self.参赛帮派[2].编号].成员数据) do
		self.玩家表["红方"].成员[v.id]=0
	end
	广播消息({内容=发送信息,频道="xt"})
	self.进场开关=true
	self.正式Time=os.time()+300 --进去准备5分钟，然后开始打架
	if self.砍树活动 then
		self:伐木工()
	elseif self.夺旗活动 then
		self:夺旗蓝旗()
		self:夺旗红旗()
		self:设置夺旗守卫(35)
	end
end

function 帮派PK:加载公共数据()
	地图处理类.地图数据[2010]={npc={},单位={},传送圈={}} --帮战夺旗蓝方
	地图处理类.地图玩家[2010]={}
	地图处理类.地图坐标[2010]=地图处理类.地图坐标[1876]
	地图处理类.地图单位[2010]={}
	地图处理类.单位编号[2010]=1000

	地图处理类.地图数据[2011]={npc={},单位={},传送圈={}} --帮战夺旗红方
	地图处理类.地图玩家[2011]={}
	地图处理类.地图坐标[2011]=地图处理类.地图坐标[1876]
	地图处理类.地图单位[2011]={}
	地图处理类.单位编号[2011]=1000

	地图处理类.地图数据[2012]={npc={},单位={},传送圈={}}  --中立区
	地图处理类.地图玩家[2012]={}
	地图处理类.地图坐标[2012]=地图处理类.地图坐标[1514]
	地图处理类.地图单位[2012]={}
	地图处理类.单位编号[2012]=1000
end

function 帮派PK:刷出场景怪()
	if self.砍树活动 then
		self:伐木兔子()
		self:伐木泡泡()
	elseif self.夺旗活动 then
		self:设置夺旗守卫(20)
	end
end

function 帮派PK:伐木工()
	local zuob={{x=15,y=85},{x=70,y=100},{x=86,y=56},{x=89,y=38},{x=76,y=18},{x=132,y=25},{x=144,y=57}}
	local mc = {"伐木工董","伐木工郑","伐木工刘","伐木工林","伐木工吴","伐木工陈","伐木工戴"}
	for i=1,7 do
		local 任务id=取唯一任务(1202)
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=7200,
			名称=mc[i],
			模型="樵夫",
			x=zuob[i].x,
			y=zuob[i].y,
			地图编号=1511,
			地图名称=取地图名称(1511),
			销毁=true,
			归属方="无",
			类型=1202
		}
		地图处理类:添加单位(任务id)
	end
end

function 帮派PK:伐木兔子()
	for i=1,20 do
		local 任务id=取唯一任务(1203)
		local xy=地图处理类.地图坐标[1511]:取随机点()
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=200,
			玩家id=id,
			名称="鬼鬼祟祟的兔子",
			模型="兔子怪",
			x=xy.x,
			y=xy.y,
			地图编号=1511,
			地图名称=取地图名称(1511),
			销毁=true,
			类型=1203
		}
		地图处理类:添加单位(任务id)
	end
	广播消息({内容=format("#S(帮派竞赛)#W一群鬼鬼祟祟的兔子出现了……)"),频道="bp"})
end

function 帮派PK:伐木泡泡()
	local 模型 ={"小气泡","中气泡","大气泡"}
	local mc
	for i=1,30 do
		local 任务id=取唯一任务(1204)
		local xy=地图处理类.地图坐标[1511]:取随机点()
		local mx=模型[取随机数(1,#模型)]
		if mx=="小气泡" then
			mc="小"
		elseif mx=="中气泡" then
			mc="中"
		else
			mc="大"
		end
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=300,
			名称=mc.."泡泡",
			模型=mx,
			事件="可点击对话",
			x=xy.x,
			y=xy.y,
			地图编号=1511,
			地图名称=取地图名称(1511),
			销毁=true,
			类型=1204
		}
		地图处理类:添加单位(任务id)
	end
	广播消息({内容=format("#S(帮派竞赛)#W友谊第一比赛第二，来戳戳泡泡放松放松吧"),频道="bp"})
end

function 帮派PK:夺旗蓝旗()
	local 任务id=取唯一任务(1206)
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=7200,
		名称="帮派旗帜",
		模型="蓝旗",
		归属="蓝方",
		x=121,
		y=17,
		地图编号=2010,
		地图名称=取地图名称(2010),
		销毁=true,
		移动CD=0,
		被抢夺=false,
		类型=1206
	}
	地图处理类:添加单位(任务id)
end

function 帮派PK:夺旗红旗()
	local 任务id=取唯一任务(1207)
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=7200,
		名称="帮派旗帜",
		模型="红旗",
		归属="红方",
		x=121,
		y=17,
		地图编号=2011,
		地图名称=取地图名称(2011),
		销毁=true,
		移动CD=0,
		被抢夺=false,
		类型=1207
	}
	地图处理类:添加单位(任务id)
end

function 帮派PK:设置夺旗守卫(num)
	local 地图范围={2010,2011}
	local 模型={"凤凰","巡游天神","古代瑞兽","炎魔神","净瓶女娲","幽灵","灵鹤","风伯","大力金刚","夜罗刹","地狱战神","律法女娲"}
	for n=1,#地图范围 do
		local 地图=地图范围[n]
		for i=1,num do
			local xy=地图处理类.地图坐标[地图]:取随机点()
			local 任务id=取唯一任务(1209)
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=1200,
				名称="帮派守卫",
				模型=模型[取随机数(1,#模型)],
				x=xy.x,
				y=xy.y,
				地图编号=地图,
				地图名称=取地图名称(地图),
				销毁=true,
				事件="明雷",
				变异=true,
				移动CD=0,
				类型=1209
			}
			if 地图==2010 then
				任务数据[任务id].归属方="蓝方"
			elseif 地图==2011 then
				任务数据[任务id].归属方="红方"
			end
			地图处理类:添加单位(任务id)
		end
	end
end

function 帮派PK:发放帮战宝箱()
	local 地图=1511
	if self.夺旗活动 then
		-- if self.胜利方=="蓝方" then
		-- 	地图=2010
		-- elseif self.胜利方=="红方" then
		-- 	地图=2011
		-- end

		local 人数=地图处理类:取地图人数(2010)
		local 数量=人数+20
		for n=1,数量 do
			local 任务id=取唯一任务(1205)
			local xy=地图处理类.地图坐标[2010]:取随机点()
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=300,
				玩家id=0,
				名称="大宝箱",
				模型="宝箱",
				x=xy.x,
				y=xy.y,
				地图编号=2010,
				地图名称=取地图名称(2010),
				销毁=true,
				类型=1205
			}
			地图处理类:添加单位(任务id)
		end

		人数=地图处理类:取地图人数(2011)
		数量=人数+20
		for n=1,数量 do
			local 任务id=取唯一任务(1205)
			local xy=地图处理类.地图坐标[2011]:取随机点()
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=300,
				玩家id=0,
				名称="大宝箱",
				模型="宝箱",
				x=xy.x,
				y=xy.y,
				地图编号=2011,
				地图名称=取地图名称(2011),
				销毁=true,
				类型=1205
			}
			地图处理类:添加单位(任务id)
		end
		广播消息({内容=format("#S(帮派竞赛)#R宝箱已刷新，今日帮派竞赛活动结束，感谢大家的参与！"),频道="bp"})
	else
		local 人数=地图处理类:取地图人数(地图)
		local 数量=人数+20
		for n=1,数量 do
			local 任务id=取唯一任务(1205)
			local xy=地图处理类.地图坐标[地图]:取随机点()
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=300,
				玩家id=0,
				名称="大宝箱",
				模型="宝箱",
				x=xy.x,
				y=xy.y,
				地图编号=地图,
				地图名称=取地图名称(地图),
				销毁=true,
				类型=1205
			}
			地图处理类:添加单位(任务id)
		end
		广播消息({内容=format("#S(帮派竞赛)#R宝箱已刷新，今日帮派竞赛活动结束，感谢大家的参与！"),频道="bp"})
	end

end

function 帮派PK:添加失败出场奖励(id)
	local 队伍id=玩家数据[id].队伍
	if 队伍id~=0 then
		for n=1,#队伍数据[队伍id].成员数据 do
			local cyid=队伍数据[队伍id].成员数据[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*10000
			local 银子=等级*3000
			玩家数据[cyid].角色:添加经验(经验*HDPZ["帮战：失败奖励"].经验,"出场奖励",1)
			玩家数据[cyid].角色:添加银子(qz(银子*HDPZ["帮战：失败奖励"].银子),"出场奖励",1)
			添加帮贡(cyid,50)
			if 取随机数()<=HDPZ["帮战：失败奖励"].爆率 then
				local 链接 = {提示=format("#S(帮战竞赛)#Y玩家#G%s#Y虽败犹荣，得到补贴奖励",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y！"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["帮战：失败奖励"].ITEM),"帮战：失败奖励")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		end
	else
		local 等级=玩家数据[id].角色.等级
		local 经验=等级*10000
		local 银子=等级*3000
		玩家数据[id].角色:添加经验(经验*HDPZ["帮战：失败奖励"].经验,"出场奖励",1)
		玩家数据[id].角色:添加银子(qz(银子*HDPZ["帮战：失败奖励"].银子),"出场奖励",1)
		添加帮贡(id,50)
		if 取随机数()<=HDPZ["帮战：失败奖励"].爆率 then
			local 链接 = {提示=format("#S(帮战竞赛)#Y玩家#G%s#Y虽败犹荣，得到补贴奖励",玩家数据[id].角色.名称),频道="xt",结尾="#Y！"}
			local 名称,数量,参数=生成产出(产出物品计算(HDPZ["帮战：失败奖励"].ITEM),"帮战：失败奖励")
			if 数量== 9999 then --环
				玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
			else
				玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
			end
		end
	end
end

function 帮派PK:戳泡泡(id,任务id)
	if 任务数据[任务id]==nil then
		常规提示(id,"#Y/这个泡泡已经被人先行一步了！")
		return
	end
	local num=取随机数(10,20)
	if 任务数据[任务id].名称=="大泡泡" then
		num=取随机数(25,40)
	elseif 任务数据[任务id].名称=="中泡泡" then
		num=取随机数(15,30)
	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
	if self.玩家表["蓝方"].成员[id] then
		self:计算伐木完成度("蓝方",取队伍人数(id)*2)
	elseif self.玩家表["红方"].成员[id] then
		self:计算伐木完成度("红方",取队伍人数(id)*2)
	end
	local 队伍id=玩家数据[id].队伍
	if 队伍id~=0 then
		for n=1,#队伍数据[队伍id].成员数据 do
			local cyid=队伍数据[队伍id].成员数据[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(800,900)
			local 银子=等级*取随机数(150,250)+10000
			玩家数据[cyid].角色:添加经验(经验,"chuopp",1)
			玩家数据[cyid].角色:添加储备(qz(银子),"chuopp",1)
			添加帮贡(cyid,5)
			local go=true
			if 玩家数据[cyid].角色:添加人物修炼经验(cyid,num) then
				go=false
			elseif 玩家数据[cyid].角色:添加bb修炼经验(cyid,num) then
				go=false
			end
			if go then --上述未添加
				玩家数据[cyid].角色:添加银子(qz(银子),"chuopp",1)
			end
		end
	else
		local 等级=玩家数据[id].角色.等级
		local 经验=等级*取随机数(800,900)
		local 银子=等级*取随机数(150,250)+10000
		玩家数据[id].角色:添加经验(经验,"chuopp",1)
		玩家数据[id].角色:添加储备(qz(银子),"chuopp",1)
		添加帮贡(id,5)
		local go=true
		if 玩家数据[id].角色:添加人物修炼经验(id,num) then
			go=false
		elseif 玩家数据[id].角色:添加bb修炼经验(id,num) then
			go=false
		end
		if go then --上述未添加
			玩家数据[id].角色:添加银子(qz(银子),"chuopp",1)
		end
	end
end

function 帮派PK:战斗胜利处理(id组,战斗类型,任务id)
	local id=id组[1]
	if 任务数据[任务id]==nil then
		return
	end
	if 战斗类型==130083 then --伐木工
		if self.玩家表["蓝方"].成员[id] then
			任务数据[任务id].归属方="蓝方"
			self:计算伐木完成度("蓝方",取队伍人数(id)*8)
			广播消息({内容=format("#Y%s：虽然我武艺出众，但还是双拳难敌四手，从今以后我就为你们#R%s#Y帮派效劳了#17",任务数据[任务id].名称,self.参赛帮派[1].帮派名称),频道="bp"})
		else
					任务数据[任务id].归属方="红方"
					self:计算伐木完成度("红方",取队伍人数(id)*8)
					广播消息({内容=format("#Y%s：虽然我武艺出众，但还是双拳难敌四手，从今以后我就为你们#R%s#Y帮派效劳了#17",任务数据[任务id].名称,self.参赛帮派[2].帮派名称),频道="bp"})
		end
		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(950,1050)
			local 银子=等级*取随机数(80,85)+10000
			玩家数据[cyid].角色:添加经验(经验*HDPZ["帮战伐木：伐木工"].经验,"伐木工",1)
			玩家数据[cyid].角色:添加银子(qz(银子*HDPZ["帮战伐木：伐木工"].银子),"伐木工",1)
			添加帮贡(cyid,10)
			if 取随机数()<=HDPZ["帮战伐木：伐木工"].爆率 then --伐木工
				local 链接 = {提示=format("#S(帮派竞赛)#G/%s#Y在帮派竞赛中勤恳伐木，因此奖励",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["帮战伐木：伐木工"].ITEM),"帮战伐木：伐木工")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
			-- if 取随机数(1,101)<=20 then
			-- 	local 链接 = {提示=format("#S(帮派竞赛)#G/%s#Y在帮派竞赛中勤恳伐木，因此奖励",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。"}
			-- 	local 奖励参数=取随机数(1,40)
			-- 	if 奖励参数<=18 then
			-- 	    local 名称=取强化石()
			-- 		玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			-- 	elseif 奖励参数<=20 then
			-- 		local 名称="玲珑宝图"
			-- 		玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
			-- 	elseif 奖励参数<=25 then
			-- 	    local 名称=取宝石()
			-- 		玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			-- 	elseif 奖励参数<=30 then
			-- 	    local 名称="未激活的符石"
			-- 	    玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			-- 	elseif 奖励参数<=32 then
			-- 		local 名称="修炼果"
			-- 		玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			-- 	elseif 奖励参数<=33 then
			-- 		if 取随机数()<=50 then
			-- 		    玩家数据[cyid].道具:给予超链接道具(cyid,"陨铁",nil,nil,链接)
			-- 		else
			-- 			玩家数据[cyid].道具:给予超链接道具(cyid,"神兜兜",1,nil,链接)
			-- 		end
			-- 	elseif 奖励参数<=35 then
			-- 	    local 名称="九转金丹"
			-- 		玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(100,150),nil,链接)
			-- 	else
			-- 		local 名称=QJBBWP[取随机数(1,#QJBBWP)]
			-- 		玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			-- 	end
			-- end
		end
	elseif 战斗类型==130084 then --兔子
		-- local 链接 = {提示=format("#S(帮派竞赛)#G/%s#W在帮派竞赛中赶走了鬼鬼祟祟的兔子，获得一个",玩家数据[id].角色.名称),频道="xt",结尾="#24#W。"}
		-- if 取随机数(1,101)<=15 then
		-- 	local 名称="铁锤"
		-- 	玩家数据[id].道具:给予道具(id,名称,nil,nil,nil,nil,链接)
		-- end
		for n=1,#id组 do
			 local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(950,1050)
			local 银子=等级*取随机数(80,85)+10000
			玩家数据[cyid].角色:添加经验(经验*HDPZ["帮战伐木：伐木兔子"].经验,"伐木兔子",1)
			玩家数据[cyid].角色:添加银子(qz(银子*HDPZ["帮战伐木：伐木兔子"].银子),"伐木兔子",1)
			添加帮贡(cyid,10)
			if 取随机数()<=HDPZ["帮战伐木：伐木兔子"].爆率 then --伐木工
				local 链接 = {提示=format("#S(帮派竞赛)#G/%s#W在帮派竞赛中赶走了鬼鬼祟祟的兔子，获得一个",玩家数据[cyid].角色.名称),频道="xt",结尾="#24#W。"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["帮战伐木：伐木兔子"].ITEM),"帮战伐木：伐木兔子")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		end
		地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
		任务数据[任务id]=nil
	elseif 战斗类型==130085 then --夺旗守卫
		for n=1,#id组 do
				local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(950,1050)
			local 银子=等级*取随机数(80,85)+10000
			玩家数据[cyid].角色:添加经验(经验*HDPZ["帮战夺旗：夺旗守卫"].经验,"夺旗守卫",1)
			玩家数据[cyid].角色:添加银子(qz(银子*HDPZ["帮战夺旗：夺旗守卫"].银子),"夺旗守卫",1)
				添加帮贡(cyid,10)
			if 取随机数()<=HDPZ["帮战夺旗：夺旗守卫"].爆率 then
				local 链接 = {提示=format("#S(帮派竞赛)#G/%s#Y在帮派夺旗竞赛中消灭敌方守卫，为本方夺旗勇士冲开一条大道，奖励宝贝",玩家数据[cyid].角色.名称),频道="bp",结尾="#84#Y。"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["帮战夺旗：夺旗守卫"].ITEM),"帮战夺旗：夺旗守卫")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		end
		地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
		任务数据[任务id]=nil
	elseif 战斗类型==130086 then --帮战夺旗旗子--战胜棋子然后拿走
		任务数据[任务id].zhandou = nil
		任务数据[任务id].模型 = "旗桩"
		任务数据[任务id].被抢夺 = true
		local 旗帜="蓝旗"
		if 任务数据[任务id].归属=="红方" then
			旗帜="红旗"
		end
		地图处理类:更换单位模型名称(任务数据[任务id].地图编号,任务数据[任务id].单位编号,任务id,"旗桩","帮派旗帜")
		地图处理类:更改帮战旗帜(id,旗帜)
		self.夺旗ID[id]={旗子颜色=旗帜,旗帜id=任务id}
		if 颜色=="蓝旗" then
			广播消息({内容=format("#R(红方)"..self.参赛帮派[2].帮派名称.."#Y帮的旗帜被蓝方的#R"..玩家数据[id].角色.名称.."#Y抢去啦#69#Y大伙快快行动起来，一起去保卫我们的旗帜啊！"),频道="bp"})
		else
			广播消息({内容=format("#S(蓝方)"..self.参赛帮派[1].帮派名称.."#Y帮的旗帜被红方的#R"..玩家数据[id].角色.名称.."#Y抢去啦#69#Y大伙快快行动起来，一起去保卫我们的旗帜啊！"),频道="bp"})
		end
		for n=1,#id组 do
				local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(950,1050)
			local 银子=等级*取随机数(80,85)+20000
			玩家数据[cyid].角色:添加经验(经验*HDPZ["帮战夺旗：抢夺旗帜"].经验,"夺旗旗子",1)
			玩家数据[cyid].角色:添加银子(qz(银子*HDPZ["帮战夺旗：抢夺旗帜"].银子),"夺旗旗子",1)
				添加帮贡(cyid,50)
				常规提示(cyid,"#Y/恭喜你们夺得了对方帮派的旗子，赶快交给本帮的“帮派旗帜”吧！")
				if 取随机数()<=HDPZ["帮战夺旗：抢夺旗帜"].爆率 then
				local 链接 = {提示=format("#S(帮派竞赛)#G/%s#Y在帮派夺旗竞赛中抢到了敌方的帮派旗帜并奖励",玩家数据[cyid].角色.名称),频道="bp",结尾="#Y，大伙快快行动起来，一起去护送他们归来！。"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["帮战夺旗：抢夺旗帜"].ITEM),"帮战夺旗：抢夺旗帜")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		end
	end
end

function 帮派PK:PK胜利处理(胜利组,失败组)
	if self.活动开关 then
		if 胜利组 and 胜利组[1] and 失败组 and 失败组[1] then
					if self.砍树活动 then
				for n=1,#胜利组 do
					local cyid=胜利组[n]
					local 等级=玩家数据[cyid].角色.等级
					local 经验=等级*取随机数(950,1050)
					local 银子=等级*取随机数(80,70)+30000
					玩家数据[cyid].角色:添加经验(经验*HDPZ["帮战：PVP胜利"].经验,"帮战",1)
					玩家数据[cyid].角色:添加银子(qz(银子*HDPZ["帮战：PVP胜利"].银子),"帮战",1)
					添加帮贡(cyid,30)
					if 取随机数()<=HDPZ["帮战：PVP胜利"].爆率 then
						local 链接 = {提示=format("#S(帮派竞赛)#G/%s#Y在帮派竞赛中成功击退了敌方的#R/%s#Y，奖励",玩家数据[cyid].角色.名称,玩家数据[失败组[1]].角色.名称),频道="bp",结尾="#Y一个。"}
						local 名称,数量,参数=生成产出(产出物品计算(HDPZ["帮战：PVP胜利"].ITEM),"帮战：PVP胜利")
						if 数量== 9999 then --环
							玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
						else
							玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
						end
					end
					for n=1,#失败组 do
						local cyid=失败组[n]
						if self.玩家表["蓝方"].成员[cyid] then
							if self:计算死亡次数("蓝方",cyid,失败组[1]) then
								self:计算伐木完成度("红方",25)
							end
						elseif self.玩家表["红方"].成员[cyid] then
							if self:计算死亡次数("红方",cyid,失败组[1]) then
								self:计算伐木完成度("蓝方",25)
							end
						end
					end
				end
			elseif self.夺旗活动 then
				local shifou=false
				for n=1,#失败组 do
					local cyid=失败组[n]
					if self.玩家表["蓝方"].成员[cyid] then
						self:计算死亡次数("蓝方",cyid,失败组[1])
					elseif self.玩家表["红方"].成员[cyid] then
						self:计算死亡次数("红方",cyid,失败组[1])
					end
					if self.夺旗ID[cyid] then
						self:抢回丢失的旗子(胜利组[1],失败组[1],cyid) --先判断是否玩家身上是否有旗帜
						shifou=true
					end
				end
				for n=1,#胜利组 do
					local cyid=胜利组[n]
					local 等级=玩家数据[cyid].角色.等级
					local 经验=等级*取随机数(950,1050)
					local 银子=等级*取随机数(80,70)+30000
					玩家数据[cyid].角色:添加经验(经验*HDPZ["帮战：PVP胜利"].经验,"帮战",1)
					玩家数据[cyid].角色:添加银子(qz(银子*HDPZ["帮战：PVP胜利"].银子),"帮战",1)
					添加帮贡(cyid,30)
					local 链接 = {提示=format("#S(帮派竞赛)#G/%s#Y在帮派夺旗竞赛中成功夺回被敌方抢去的帮派旗帜！奖励宝贝",玩家数据[cyid].角色.名称),频道="bp",结尾="#84#Y。"}
					if not shifou then
						链接 = {提示=format("#S(帮派竞赛)#G/%s#Y在帮派竞赛中成功击退了敌方的#R/%s#Y，奖励",玩家数据[cyid].角色.名称,玩家数据[失败组[1]].角色.名称),频道="bp",结尾="#Y一个。"}
					end
					if 取随机数()<=HDPZ["帮战：PVP胜利"].爆率 then
						local 名称,数量,参数=生成产出(产出物品计算(HDPZ["帮战：PVP胜利"].ITEM),"帮战：PVP胜利")
						if 数量== 9999 then --环
							玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
						else
							玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
						end
					end
				end
			end
			local Win="蓝方"
			if self.玩家表["红方"].成员[胜利组[1]] then
				Win="红方"
			end
			if Win=="蓝方" then
				广播消息({内容=format("#P(蓝方)“"..self.参赛帮派[1].帮派名称.."”#G"..取队伍所有玩家名称(胜利组[1]).."#Y战胜敌方#R"..取队伍所有玩家名称(失败组[1]).."#Y，对面还有谁#28"),频道="bp"})
			else
				广播消息({内容=format("#R(红方)“"..self.参赛帮派[2].帮派名称.."”#G"..取队伍所有玩家名称(胜利组[1]).."#Y战胜敌方#R"..取队伍所有玩家名称(失败组[1]).."#Y，对面还有谁#28"),频道="bp"})
			end
		end
	end
end

function 帮派PK:上交旗子(id)
	if self.夺旗ID[id] then
		常规提示(id,"战旗上交成功！")
		local 任务id
		if self.玩家表["蓝方"].成员[id] then
			self.玩家表["蓝方"].完成度=self.玩家表["蓝方"].完成度+1
			广播消息({内容=format("#P(蓝方)“"..self.参赛帮派[1].帮派名称.."”#Y的#G"..取队伍所有玩家名称(id).."#Y，成功为帮派夺回一面敌方旗帜！大家欢迎英雄的归来！#88#88#88"),频道="bp"})
			if self.玩家表["蓝方"].完成度>=2 then
				self:计算最终胜利方("蓝方")
				广播消息({内容=format("#Y最新赛况：由于#R“"..self.参赛帮派[2].帮派名称.."”#Y帮派比赛连连失利，失去了两面帮派旗帜，#P“"..self.参赛帮派[1].帮派名称.."”#Y获得了本次比赛的胜利#84"),频道="bp"})
			else
				self:夺旗红旗()
				任务id=self.夺旗ID[id].旗帜id
				if 任务数据[任务id] then
					地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
					任务数据[任务id]=nil
				end
			end
		elseif self.玩家表["红方"].成员[id] then
			self.玩家表["红方"].完成度=self.玩家表["红方"].完成度+1
			广播消息({内容=format("#P(红方)“"..self.参赛帮派[2].帮派名称.."”#Y的#G"..取队伍所有玩家名称(id).."#Y，成功为帮派夺回一面敌方旗帜！大家欢迎英雄的归来！#88#88#88"),频道="bp"})
			if self.玩家表["红方"].完成度>=2 then
				self:计算最终胜利方("红方")
				广播消息({内容=format("#Y最新赛况：由于#S“"..self.参赛帮派[1].帮派名称.."”#Y帮派比赛连连失利，失去了两面帮派旗帜，#R“"..self.参赛帮派[2].帮派名称.."”#Y获得了本次比赛的胜利#84"),频道="bp"})
			else
				self:夺旗蓝旗()
				任务id=self.夺旗ID[id].旗帜id
				if 任务数据[任务id] then
					地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
					任务数据[任务id]=nil
				end
			end
		end
		地图处理类:更改帮战旗帜(id)--清空
		self.夺旗ID[id]=nil
		local 队伍id=玩家数据[id].队伍
		if 队伍id~=0 then
			for n=1,#队伍数据[队伍id].成员数据 do
				local cyid=队伍数据[队伍id].成员数据[n]
				local 等级=玩家数据[cyid].角色.等级
				local 经验=等级*15000
				local 银子=等级*10000
				玩家数据[cyid].角色:添加经验(经验,"上交旗子",1)
				玩家数据[cyid].角色:添加银子(qz(银子),"上交旗子",1)
				添加帮贡(cyid,100)
			end
		else
			local 等级=玩家数据[id].角色.等级
			local 经验=等级*15000
			local 银子=等级*10000
			玩家数据[id].角色:添加经验(经验,"上交旗子",1)
			玩家数据[id].角色:添加银子(qz(银子),"上交旗子",1)
			添加帮贡(id,100)
		end
	end
end

function 帮派PK:抢回丢失的旗子(胜利者,失败者,拥有者)
	if self.夺旗ID[拥有者] then
		local 任务id=self.夺旗ID[拥有者].旗帜id
		local 旗帜="蓝旗"
		if 任务数据[任务id].归属=="红方" then
			旗帜="红旗"
		end
		任务数据[任务id].模型 = 旗帜
		任务数据[任务id].被抢夺 = false
		地图处理类:更换单位模型名称(任务数据[任务id].地图编号,任务数据[任务id].单位编号,任务id,旗帜,"帮派旗帜")
		地图处理类:更改帮战旗帜(拥有者)--清空
		self.夺旗ID[拥有者]=nil
		if 旗帜=="蓝旗" then
			广播消息({内容=format("#P(蓝方)“"..self.参赛帮派[1].帮派名称.."”#Y的#G"..取队伍所有玩家名称(胜利者).."#Y战胜敌方#R"..取队伍所有玩家名称(失败者).."#Y，成功保护了帮派旗帜！#84"),频道="bp"})
		else
			广播消息({内容=format("#R(红方)“"..self.参赛帮派[2].帮派名称.."”#Y的#G"..取队伍所有玩家名称(胜利者).."#Y战胜敌方#R"..取队伍所有玩家名称(失败者).."#Y，成功保护了帮派旗帜！#84"),频道="bp"})
		end
	end
end

function 帮派PK:开启宝箱(id,rwid)
	if 任务数据[rwid]==nil then
		常规提示(id,"#Y这个宝箱已经被人抢先一步！")
		return
	end
	local 等级=玩家数据[id].角色.等级
	local 经验=等级*12000
	local 银子=等级*4000
	local shibai="蓝方"
	if self.胜利方=="蓝方" then
		shibai="红方"
	end
	if self.玩家表[self.胜利方].成员[id] then
		地图处理类:删除单位(任务数据[rwid].地图编号,任务数据[rwid].单位编号)
		任务数据[rwid]=nil
		玩家数据[id].角色:添加经验(qz(经验*HDPZ["帮战：胜利奖励"].经验),"帮战宝箱",1)
		玩家数据[id].角色:添加银子(qz(银子*HDPZ["帮战：胜利奖励"].银子),"帮战宝箱",1)
		添加帮贡(id,100)
		self.玩家表[self.胜利方].成员[id]=nil
		地图处理类:跳转地图(id,1092,122,54)
		local 链接 = {提示=format("#S(帮战)#G/%s#Y在帮派竞赛中打开一个大宝箱后，居然得到了",玩家数据[id].角色.名称),频道="xt",结尾="#50"}
		if 取随机数()<=HDPZ["帮战：胜利奖励"].爆率 then
		 -- local 链接 = {提示=format("#S(长安保卫战)#G/%s#Y直捣虎穴，击败振威大王，并缴获一份",玩家数据[id].角色.名称),频道="xt",结尾="#Y！#24"}
		local 名称,数量,参数=生成产出(产出物品计算(HDPZ["帮战：胜利奖励"].ITEM),"帮战：胜利奖励")
		if 数量== 9999 then --环
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
		else
			玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
		end
	end

	elseif self.玩家表[shibai].成员[id] then
		地图处理类:删除单位(任务数据[rwid].地图编号,任务数据[rwid].单位编号)
		任务数据[rwid]=nil
		玩家数据[id].角色:添加经验(qz(经验*HDPZ["帮战：失败奖励"].经验),"帮战宝箱",1)
		玩家数据[id].角色:添加储备(qz(银子*HDPZ["帮战：失败奖励"].银子),"帮战宝箱",1)
		添加帮贡(id,50)
		self.玩家表[shibai].成员[id]=nil
		地图处理类:跳转地图(id,1092,122,54)
		local 链接 = {提示=format("#S(帮战)#G/%s#Y在帮派竞赛中打开一个大宝箱后，居然得到了",玩家数据[id].角色.名称),频道="xt",结尾="#50"}
			 if 取随机数()<=HDPZ["帮战：失败奖励"].爆率 then
			local 名称,数量,参数=生成产出(产出物品计算(HDPZ["帮战：失败奖励"].ITEM),"帮战：失败奖励")
			if 数量== 9999 then --环
				玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
			else
				玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
			end
		end
	else
		常规提示(id,"#Y这个宝箱不属于你！")
	end
end

return 帮派PK