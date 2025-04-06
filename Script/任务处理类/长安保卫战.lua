-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-09 11:12:00
local 长安保卫战 = class()

function 长安保卫战:初始化()
	self.数据={}
	self.活动开关=false
	self.进洞开关=false
	self.刷怪记录={}
	地图处理类.地图数据[5003]={npc={},单位={},传送圈={}} --妖怪巢穴
	地图处理类.地图玩家[5003]={}
	地图处理类.地图坐标[5003]=地图处理类.地图坐标[1221]
	地图处理类.地图单位[5003]={}
	地图处理类.单位编号[5003]=1000
	self.xianfeng={"风伯","蛟龙","雨师","鲛人","碧水夜叉","地狱战神","雷鸟人","白熊","古代瑞兽","黑山老妖"}
	self.toumu={"巴蛇","幽灵","吸血鬼","百足将军","画魂","狐不归","鬼将","阴阳伞"}
	self.dawang={"炎魔神","夜罗刹","噬天虎","大力金刚","混沌兽","狂豹人形","狂豹兽形"}
	self.jingrui={"炎魔神","夜罗刹","大力金刚","混沌兽","狂豹人形"}
	self.是否记录={}
	self.是否记录[130090]="魑"
	self.是否记录[130091]="魅"
	self.是否记录[130092]="魍"
	self.是否记录[130093]="魉"
	self.是否记录[130094]="鼍龙"
	self.是否记录[130095]="兕怪"
	self.是否记录[130096]="振威大王"
	self.先锋数量={}
	self.头目数量={}
	self.大王数量={}
	self.活动时间=QJHDSJ["保卫长安"]
end

function 长安保卫战:活动定时器()
	if self.活动开关 then
		if self.开启Time-os.time()<0 then
			self:关闭活动()
		else
			if not self.进洞开关 and self.开启Time-os.time()<3600 then --一小时后 就可以进洞了
				self.进洞开关=true
				self:添加巢穴NPC()
			end
			if os.time()-self.刷怪Time>=0 then
				self:刷出怪物()
				self.刷怪Time=os.time()+取随机数(300,420)
			end
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

function 长安保卫战:开启活动()
	self.活动开关=true
	self.进洞开关=false
	self:添加NPC()
	self:刷出怪物()
	self:刷出怪物()
	self.开启Time=os.time()+7200
	self.刷怪Time=os.time()+取随机数(300,420)
	self.数据={}
	发送公告("#G(长安保卫战)#P活动开启，望天下英雄豪杰前往皇城门口（117,61），一同守卫长安！")
	广播消息({内容=format("#G(长安保卫战)#P听闻有妖魔鬼怪妄图入侵长安，唐王特令我于此前往皇城门口（117,61），招募天下英雄豪杰，共同守卫长安！"),频道="hd"})
end

function 长安保卫战:关闭活动()
	self.数据={}
	self.活动开关=false
	self.进洞开关=false
	self.开启Time=nil
	self.刷怪Time=nil
	发送公告("#R(长安保卫战)#W活动已经结束，已处战斗中的玩家在战斗结束后依然可以获得奖励。感谢大家的参与！")
	广播消息({内容=format("#R(长安保卫战)#W活动已经结束，已处战斗中的玩家在战斗结束后依然可以获得奖励。感谢大家的参与！"),频道="hd"})
end

function 长安保卫战:添加NPC()
	local 地图=1001
	local dtmc=取地图名称(地图)
	local 任务id=取唯一任务(1312)
	任务数据[任务id]={
		id=任务id,
		销毁=true,
		起始=os.time(),
		结束=14400,
		名称="骠骑大将军",
		模型="男人_将军",
		x=117,
		y=61,
		方向=0,
		地图编号=地图,
		地图名称=dtmc,
		小地图名称颜色=6,
		类型=1312
	}
	地图处理类:添加单位(任务id)
end

function 长安保卫战:添加巢穴NPC()
	local 模型范围={"蛟龙","幽灵","吸血鬼","鬼将","进阶龙龟","进阶踏云兽","进阶黑山老妖"}
	local 名称范围={"魑","魅","魍","魉","鼍龙","兕怪","振威大王"}
	-- local 炫彩染色={"金黄","青色","淡紫色","土耳其蓝","白泽狮","猛蓝","青绿色"}
	local 坐标范围={{x=24,y=33},{x=81,y=49},{x=21,y=77},{x=92,y=19},{x=95,y=90},{x=171,y=29},{x=159,y=95}}
	for n=1,7 do
		local 任务id="_1314_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_"..n
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=4000,
			玩家id=0,
			销毁=true,
			名称=名称范围[n],
			模型=模型范围[n],
			x=坐标范围[n].x,
			y=坐标范围[n].y,
			变异=true,
			地图编号=5003,
			地图名称=取地图名称(5003),
			小地图名称颜色=6,
			显示饰品=true,
			类型=1314
		}
		地图处理类:添加单位(任务id)
	end
	local 任务id="_1314_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_"..1001
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=4500,
		玩家id=0,
		销毁=true,
		名称="除魔道人",
		模型="罗道人",
		小地图名称颜色=6,
		x=134,
		y=32,
		地图编号=1173,
		地图名称=取地图名称(1173),
		类型=1314
	}
	地图处理类:添加单位(任务id)
	广播消息({内容=format("紧急军情！三界英雄势如破竹，打得妖魔鬼怪节节败退，并意外发现妖怪巢穴！#Y除魔道人#W正在#Y大唐境外（134，32）#W接引能人异士进入巢穴，捉拿妖王#81#81#81"),频道="xt"})
	self.刷怪记录[#self.刷怪记录+1]="#M"..时间转换(os.time()).."#M紧急军情！三界英雄势如破竹，打得妖魔鬼怪节节败退，并意外发现妖怪巢穴！#Y除魔道人#W正在#Y大唐境外（134，32）#W接引能人异士进入巢穴，捉拿妖王#81#81#81\n"
	if #self.刷怪记录>2 then
		table.remove(self.刷怪记录,1)
	end
end

function 长安保卫战:刷出怪物()
	local 地图范围={1226,1040,1131,1514,1173,1091,1142,1146,1116,1506,1208,1110}
	local dtmc=""
	local dttab={}
	for i=1,3 do
		local sj=取随机数(1,#地图范围)
		dttab[i]=地图范围[sj]
		if i==3 then
			dtmc=dtmc..取地图名称(地图范围[sj])
		else
			dtmc=dtmc..取地图名称(地图范围[sj]).."、"
		end
		table.remove(地图范围,sj)
	end
	self.先锋数量={}
	self.头目数量={}
	self.大王数量={}
	self.先锋数量[dttab[1]]=20
	self.头目数量[dttab[1]]=7
	self.大王数量[dttab[1]]=3
	self.先锋数量[dttab[2]]=20
	self.头目数量[dttab[2]]=7
	self.大王数量[dttab[2]]=3
	self.先锋数量[dttab[3]]=20
	self.头目数量[dttab[3]]=7
	self.大王数量[dttab[3]]=3
	for n=1,3 do
		for i=1,30 do
			if i<20 then
				local 任务id=取唯一任务(1313)
				local 地图=dttab[n]
				local xy=地图处理类.地图坐标[地图]:取随机点()
				local mx=self.xianfeng[取随机数(1,#self.xianfeng)]
				任务数据[任务id]={
					id=任务id,
					起始=os.time(),
					结束=400,
					名称="妖魔鬼怪先锋",
					模型=mx,
					x=xy.x,
					y=xy.y,
					销毁=true,
					行走开关=true,
					地图编号=地图,
					地图名称=取地图名称(地图),
					类型=1313
				}
				地图处理类:添加单位(任务id)
			elseif i>=20 and i<=27 then
				local 任务id=取唯一任务(1313)
				local 地图=dttab[n]
				local xy=地图处理类.地图坐标[地图]:取随机点()
				local mx=self.toumu[取随机数(1,#self.toumu)]
				任务数据[任务id]={
					id=任务id,
					起始=os.time(),
					结束=400,
					名称="妖魔鬼怪头目",
					模型=mx,
					x=xy.x,
					y=xy.y,
					销毁=true,
					行走开关=true,
					地图编号=地图,
					地图名称=取地图名称(地图),
					类型=1313
				}
				地图处理类:添加单位(任务id)
			else
				local 任务id=取唯一任务(1313)
				local 地图=dttab[n]
				local xy=地图处理类.地图坐标[地图]:取随机点()
				local mx=self.dawang[取随机数(1,#self.dawang)]
				任务数据[任务id]={
					id=任务id,
					起始=os.time(),
					结束=400,
					名称="妖魔鬼怪大王",
					模型=mx,
					x=xy.x,
					y=xy.y,
					销毁=true,
					行走开关=true,
					地图编号=地图,
					地图名称=取地图名称(地图),
					类型=1313
				}
				地图处理类:添加单位(任务id)
			end
		end
	end

	if 取随机数()<=50 then
		self.刷怪记录[#self.刷怪记录+1]="#M"..时间转换(os.time()).."#M紧急公告，一部分妖魔鬼怪入侵，现正在#K"..dtmc.."#M作乱，各路影响赶快前往消灭他们！\n"
		广播消息({内容=format("#Y紧急公告，一部分妖魔鬼怪入侵，现正在#G"..dtmc.."#Y作乱，各路影响赶快前往消灭他们！"),频道="xt"})
	else
		self.刷怪记录[#self.刷怪记录+1]="#M"..时间转换(os.time()).."#K"..dtmc.."#M出现了一批前来捣乱的妖魔，请各路豪杰前去消灭他们，千万不要放走过一个。\n"
		广播消息({内容=format("#G"..dtmc.."#Y出现了一批前来捣乱的妖魔，请各路豪杰前去消灭他们，千万不要放走过一个。"),频道="xt"})
	end
	if #self.刷怪记录>2 then
		table.remove(self.刷怪记录,1)
	end
end

function 长安保卫战:怪物对话内容(id,类型,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	if 任务数据[标识].zhandou then
		对话数据.对话="正在战斗中，请勿打扰。"
		return 对话数据
	end
	local 名称 = 任务数据[标识].名称
	if 名称=="骠骑大将军" then
		对话数据.对话="听闻有妖魔鬼怪妄图入侵长安，唐王特令我于此招募天下英雄豪杰，共同守卫长安！少侠是否愿意加入我们？"
		对话数据.选项={"没问题，尽管吩咐！","了解本次活动","领取长安战报","","","取消任务","查看并使用积分","没事，我先回去准备下"}
	elseif 类型==1313 then
		对话数据.对话="长安城没人了吗？#35竟敢派几个小屁孩来拦我，真是丢尽颜面。"
		对话数据.选项={"妖怪如此嚣张，看打（战斗）","不要欺负小孩子"}
	elseif 名称=="除魔道人" then
		对话数据.对话="邪不胜正！此次守卫长安，我军力克众敌，狠狠地打击了妖怪的嚣张气焰。我特于此接引三界能人，进入巢穴捉拿妖王！为了保证少侠的安全，只允许本次活动积分达到30的玩家进入，还望见谅。"
		对话数据.选项={"我要前往捉拿妖王","查询当前积分","我先去侦察一下"}
	elseif 对话数据.名称 == "魑" then
		对话数据.对话="那里来的小毛贼，竟敢打扰大王清净！拿下他们！"
		对话数据.选项={"妖怪还不束手就擒（战斗）","路过此地"}
	elseif 对话数据.名称 == "魅" then
		对话数据.对话="那里来的小毛贼，竟敢打扰大王清净！拿下他们！"
		对话数据.选项={"妖怪还不束手就擒（战斗）","路过此地"}
	elseif 对话数据.名称 == "魍" then
		对话数据.对话="那里来的小毛贼，竟敢打扰大王清净！拿下他们！"
		对话数据.选项={"妖怪还不束手就擒（战斗）","路过此地"}
	elseif 对话数据.名称 == "魉" then
		对话数据.对话="那里来的小毛贼，竟敢打扰大王清净！拿下他们！"
		对话数据.选项={"妖怪还不束手就擒（战斗）","路过此地"}
	elseif 对话数据.名称 == "鼍龙" then
		对话数据.对话="魏征杀我父王，我一定要报仇，出兵长安！"
		对话数据.选项={"妖怪还不束手就擒（战斗）","路过此地"}
	elseif 对话数据.名称 == "兕怪" then
		对话数据.对话="连那猴子都不是我对手，你也敢来挑战？"
		对话数据.选项={"妖怪还不束手就擒（战斗）","路过此地"}
	elseif 对话数据.名称 == "振威大王" then
		对话数据.对话="哼，真是养了一群酒囊饭袋！你们既然打到这里来了，我就陪陪你们。"
		对话数据.选项={"妖怪还不束手就擒（战斗）","路过此地"}
	end
	return 对话数据
end

function 长安保卫战:怪物对话处理(id,名称,事件,类型,rwid)
	if not self.活动开关 then
		添加最后对话(id,"长安保卫战活动已经结束。")
		return
	end
	if 事件=="妖怪如此嚣张，看打（战斗）" then
		if 任务数据[rwid].zhandou~=nil then 添加最后对话(id,"正在战斗中，请勿打扰。") return  end
		if not 调试模式 then
			if 玩家数据[id].队伍==0 or 取队伍人数(id)<3 or 取队伍最低等级(玩家数据[id].队伍,40) then 添加最后对话(id,"长安保卫战参与条件：≥40级，≥3人") return end
			if 玩家数据[id].队长==false then
				添加最后对话(id,"这种重要的事情还是让队长来吧！")
				return
			end
		end
		if 名称=="妖魔鬼怪先锋" then
			战斗准备类:创建战斗(id,130087,rwid)
		elseif 名称=="妖魔鬼怪头目" then
			战斗准备类:创建战斗(id,130088,rwid)
		elseif 名称=="妖魔鬼怪大王" then
			战斗准备类:创建战斗(id,130089,rwid)
		end
		任务数据[rwid].zhandou=true
	elseif 名称=="除魔道人" then
		if 事件=="我要前往捉拿妖王" then
			if not 调试模式 then
				if 玩家数据[id].队伍==0 or 取队伍人数(id)<3 or 取队伍最低等级(玩家数据[id].队伍,40) then 添加最后对话(id,"长安保卫战参与条件：≥40级，≥3人") return end
				if 玩家数据[id].队长==false then
					添加最后对话(id,"这种重要的事情还是让队长来吧！")
					return
				end
				local 队伍id = 玩家数据[id].队伍
				for n=1,#队伍数据[队伍id].成员数据 do
					local 成员id=队伍数据[队伍id].成员数据[n]
					if not self:检查积分(成员id) then
						添加最后对话(id,"玩家#Y"..玩家数据[成员id].角色.名称.."#W积分不足30我可不放心让你们进去")
						return
					end
				end
			end
			地图处理类:跳转地图(id,5003,11,11)
		elseif 事件=="查询当前积分" then
			local 队伍id = 玩家数据[id].队伍
			local dhuihua="进入妖怪巢穴需要积分达到#Y30#W，队伍中各位玩家的积分为：\n"
			if 队伍id~=0 then
				for n=1,#队伍数据[队伍id].成员数据 do
					local 成员id=队伍数据[队伍id].成员数据[n]
					self:检查积分(成员id)
					dhuihua=dhuihua..玩家数据[成员id].角色.名称.."  "..self.数据[成员id].积分.."分\n"
				end
			else
				self:检查积分(id)
				dhuihua=dhuihua..玩家数据[id].角色.名称.."  "..self.数据[id].积分.."分"
			end
			添加最后对话(id,dhuihua)
		end
	elseif 事件=="妖怪还不束手就擒（战斗）" then
		local 队伍id = 玩家数据[id].队伍
		if not 调试模式 then
			if 玩家数据[id].队伍==0 or 取队伍人数(id)<3 or 取队伍最低等级(玩家数据[id].队伍,40) then 添加最后对话(id,"长安保卫战参与条件：≥40级，≥3人") return end
			if 玩家数据[id].队长==false then
				添加最后对话(id,"这种重要的事情还是让队长来吧！")
				return
			end
		end
		if 名称=="魑" then
			if self:检查是否重复(队伍id,名称) then
				战斗准备类:创建战斗(id,130090,rwid)
			end
		elseif 名称=="魅" then
			if self:检查是否重复(队伍id,名称) then
				战斗准备类:创建战斗(id,130091,rwid)
			end
		elseif 名称=="魍" then
			if self:检查是否重复(队伍id,名称) then
				战斗准备类:创建战斗(id,130092,rwid)
			end
		elseif 名称=="魉" then
			if self:检查是否重复(队伍id,名称) then
				战斗准备类:创建战斗(id,130093,rwid)
			end
		elseif 名称=="鼍龙" then
			if self:检查是否重复(队伍id,名称) then
				战斗准备类:创建战斗(id,130094,rwid)
			end
		elseif 名称=="兕怪" then
			if self:检查是否重复(队伍id,名称) then
				战斗准备类:创建战斗(id,130095,rwid)
			end
		elseif 名称=="振威大王" then
			if self:检查是否重复(队伍id,名称) then
				战斗准备类:创建战斗(id,130096,rwid)
			end
		end
	end
end

function 长安保卫战:检查是否重复(队伍id,怪物)
	for n=1,#队伍数据[队伍id].成员数据 do
		local 成员id=队伍数据[队伍id].成员数据[n]
		if not self:检查积分(成员id) then
			添加最后对话(队伍id,"玩家#Y"..玩家数据[成员id].角色.名称.."#W积分不足30。")
			return
		end
		if self.数据[成员id][怪物] then
			添加最后对话(队伍id,"玩家#Y"..玩家数据[成员id].角色.名称.."#W已经挑战过"..怪物)
			return false
		end
		if 怪物=="振威大王" then
			for k,v in pairs(self.数据[成员id]) do
				if k~="振威大王" and k~=怪物 and v==false then
					添加最后对话(队伍id,"玩家#Y"..玩家数据[成员id].角色.名称.."#W还未挑战过"..k)
					return false
				end
			end
		else
			for k,v in pairs(self.数据[成员id]) do
				if 怪物=="兕怪" or 怪物=="鼍龙" then
					if k~="振威大王" and k~="兕怪" and k~="鼍龙" and v==false then
						添加最后对话(队伍id,"玩家#Y"..玩家数据[成员id].角色.名称.."#W还未挑战过"..k)
						return false
					end
				end
			end
		end
	end
	return true
end

function 长安保卫战:NPC对话处理(id,名称,事件,类型,rwid)
	if 名称=="骠骑大将军" then
		if 事件=="了解本次活动" then
			添加最后对话(id,"大唐年间，国富民强，百姓生活幸福。东土的兴盛引起的一些西方妖魔的垂涎，欲进入大唐都城一一长安肆虐一番。为了保护长安百姓，唐王请天下英雄协助抵御西方妖魔,有志之士纷纷响应。本次活动包含三个阶段:",{"第一列段：守卫长安","第二列段：军备长安","第三列段：反攻长安"})
		elseif 事件=="第一列段：守卫长安" then
			添加最后对话(id,"活动开启后60分钟内，玩家可以根据系统消息前往大唐各处，抵御西方妖魔入侵。")
		elseif 事件=="第二列段：军备长安" then
			添加最后对话(id,"活动开启后60~90分钟之间，玩家可以在长安城骠骑大将军处领取环式任务，帮助三界百姓军民。")
		elseif 事件=="第三列段：反攻长安" then
			添加最后对话(id,"活动开启后90分钟后，积分达到一定值的玩家，可以通过#Y除魔道人(大唐境外134，32)#W的指引进入妖怪巢穴，擒拿妖王。")
		elseif 事件=="领取长安战报" then
			玩家数据[id].道具:给予道具(id,"长安战报")
		elseif 事件=="取消任务" then
		elseif 事件=="没问题，尽管吩咐！" then
			添加最后对话(id,"快去奋勇杀敌吧")
		elseif 事件=="查看并使用积分" then
			添加最后对话(id,"积分正在完善中。积分不会清空，敬请期待")
		end
	end
end

function 长安保卫战:检查积分(id)
	if not self.数据[id] then
		self.数据[id]={积分=0,魑=false,魅=false,魍=false,魉=false,鼍龙=false,兕怪=false,振威大王=false}
	end
	if self.数据[id].积分<30 then
		return false
	end
	return true
end

function 长安保卫战:增加积分(id,num)
	if not self.数据[id] then
		self.数据[id]={积分=0,魑=false,魅=false,魍=false,魉=false,鼍龙=false,兕怪=false,振威大王=false}
	end
	self.数据[id].积分=self.数据[id].积分+num
end

function 长安保卫战:获取玩家数据(id)
	if self.活动开关 then
		self:检查积分(id)
		发送数据(玩家数据[id].连接id,6575,{刷怪记录=self.刷怪记录,积分=self.数据[id].积分,先锋=self.先锋数量,头目=self.头目数量,大王=self.大王数量})
	else
		常规提示(id,"现在还不是活动时间没有战报可查询")
	end
end

function 长安保卫战:战斗胜利处理(id组,战斗类型,任务id)
	if 任务数据[任务id]==nil then
		return
	end
	if 战斗类型==130087 then  --先锋
		for n=1,#id组 do
			local id=id组[n]
			local 等级=玩家数据[id].角色.等级
			local 经验=等级*取随机数(1000,1100)+50000
			local 银子=等级*150+20000
			玩家数据[id].角色:添加经验(经验*HDPZ["保卫长安：小怪先锋"].经验,"保卫战",1)
			玩家数据[id].角色:添加银子(银子*HDPZ["保卫长安：小怪先锋"].银子,"保卫战",1)
			玩家数据[id].角色:添加储备(银子*HDPZ["保卫长安：小怪先锋"].银子,"保卫战",1)
			self:增加积分(id,3)
			if 取随机数()<=HDPZ["保卫长安：小怪先锋"].爆率 then
				 local 链接 = {提示=format("#S(长安保卫战)#Y意外惊喜，/%s#Y在抵御西方妖魔的战斗中额外获得了",玩家数据[id].角色.名称),频道="xt",结尾="#Y一个。#80"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["保卫长安：小怪先锋"].ITEM),"保卫长安：小怪先锋")
				if 数量== 9999 then --环
					玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
				end
			end
		end
		删除地图单位(任务id)
		local 地图 = 玩家数据[id组[1]].角色.地图数据.编号
		if self.先锋数量[地图] then
			self.先锋数量[地图]=self.先锋数量[地图]-1
		end
	elseif 战斗类型==130088 then  --头目
		for n=1,#id组 do
			local id=id组[n]
			local 等级=玩家数据[id].角色.等级
			local 经验=等级*取随机数(1000,1200)+60000
			local 银子=等级*250+8000
			玩家数据[id].角色:添加经验(经验*HDPZ["保卫长安：小怪头目"].经验,"保卫战",1)
			玩家数据[id].角色:添加银子(银子*HDPZ["保卫长安：小怪头目"].银子,"保卫战",1)
			玩家数据[id].角色:添加储备(银子*HDPZ["保卫长安：小怪头目"].银子,"保卫战",1)
			self:增加积分(id,5)
			if 取随机数()<=HDPZ["保卫长安：小怪头目"].爆率 then
				 local 链接 = {提示=format("#S(长安保卫战)#Y意外惊喜，/%s#Y在抵御西方妖魔的战斗中额外获得了",玩家数据[id].角色.名称),频道="xt",结尾="#Y一个。#80"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["保卫长安：小怪头目"].ITEM),"保卫长安：小怪头目")
				if 数量== 9999 then --环
					玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
				end
			end
		end
		删除地图单位(任务id)
		local 地图 = 玩家数据[id组[1]].角色.地图数据.编号
		if self.头目数量[地图] then
			self.头目数量[地图]=self.先锋数量[地图]-1
		end
	elseif 战斗类型==130089 then  --大王
		for n=1,#id组 do
			local id=id组[n]
			local 等级=玩家数据[id].角色.等级
			local 经验=等级*取随机数(1100,1300)+80000
			local 银子=等级*260+10000
			玩家数据[id].角色:添加经验(经验*HDPZ["保卫长安：小怪大王"].经验,"保卫战",1)
			玩家数据[id].角色:添加银子(银子*HDPZ["保卫长安：小怪大王"].银子,"保卫战",1)
			玩家数据[id].角色:添加储备(银子*HDPZ["保卫长安：小怪大王"].银子,"保卫战",1)
			self:增加积分(id,10)
			if 取随机数()<=HDPZ["保卫长安：小怪大王"].爆率 then
				 local 链接 = {提示=format("#S(长安保卫战)#Y意外惊喜，/%s#Y在抵御西方妖魔的战斗中额外获得了",玩家数据[id].角色.名称),频道="xt",结尾="#Y一个。#80"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["保卫长安：小怪大王"].ITEM),"保卫长安：小怪大王")
				if 数量== 9999 then --环
					玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
				end
			end
		end
		删除地图单位(任务id)
		local 地图 = 玩家数据[id组[1]].角色.地图数据.编号
		if self.大王数量[地图] then
			self.大王数量[地图]=self.先锋数量[地图]-1
		end
	elseif 战斗类型>=130090 and 战斗类型<=130093 then  --保卫长安_魑    保卫长安_魅    保卫长安_魍    保卫长安_魉
		for n=1,#id组 do
			local id=id组[n]
			local 等级=玩家数据[id].角色.等级
			local 经验=等级*取随机数(1200,1300)+80000
			local 银子=等级*260+22000
			玩家数据[id].角色:添加经验(经验*HDPZ["保卫长安：魑魅魍魉"].经验,"保卫战",1)
			玩家数据[id].角色:添加银子(银子*HDPZ["保卫长安：魑魅魍魉"].银子,"保卫战",1)
			玩家数据[id].角色:添加储备(银子*2*HDPZ["保卫长安：魑魅魍魉"].银子,"保卫战",1)
			self:增加积分(id,5)
			self.数据[id][self.是否记录[战斗类型]]=true
			if 取随机数()<=HDPZ["保卫长安：魑魅魍魉"].爆率 then
				local 链接 = {提示=format("#S(长安保卫战)#G/%s#Y勇闯魔窟，打的西方妖魔落荒而逃，并缴获一份",玩家数据[id].角色.名称),频道="xt",结尾="#Y！#24"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["保卫长安：魑魅魍魉"].ITEM),"保卫长安：魑魅魍魉")
				if 数量== 9999 then --环
					玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
				end
			end
		end
	elseif 战斗类型>=130094 and 战斗类型<=130095 then  --保卫长安_鼍龙    保卫长安_兕怪
		for n=1,#id组 do
			local id=id组[n]
			local 等级=玩家数据[id].角色.等级
			local 经验=等级*取随机数(1300,1400)+80000
			local 银子=等级*280+32000
			玩家数据[id].角色:添加经验(经验*HDPZ["保卫长安：鼍龙兕怪"].经验,"保卫战",1)
			玩家数据[id].角色:添加银子(银子*HDPZ["保卫长安：鼍龙兕怪"].银子,"保卫战",1)
			玩家数据[id].角色:添加储备(银子*2*HDPZ["保卫长安：鼍龙兕怪"].银子,"保卫战",1)
			self:增加积分(id,10)
			self.数据[id][self.是否记录[战斗类型]]=true
			if 取随机数()<=HDPZ["保卫长安：鼍龙兕怪"].爆率 then
				local 链接 = {提示=format("#S(长安保卫战)#G/%s#Y勇闯魔窟，打的西方妖魔落荒而逃，并缴获一份",玩家数据[id].角色.名称),频道="xt",结尾="#Y！#24"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["保卫长安：鼍龙兕怪"].ITEM),"保卫长安：鼍龙兕怪")
				if 数量== 9999 then --环
					玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
				end
			end
		end
	elseif 战斗类型==130096 then  --保卫长安_振威大王
		for n=1,#id组 do
			local id=id组[n]
			local 等级=玩家数据[id].角色.等级
			local 经验=等级*取随机数(1400,1500)+100000
			local 银子=等级*300+42000
			玩家数据[id].角色:添加经验(经验*HDPZ["保卫长安：鼍龙兕怪"].经验,"保卫战",1)
			玩家数据[id].角色:添加银子(银子*HDPZ["保卫长安：鼍龙兕怪"].银子,"保卫战",1)
			玩家数据[id].角色:添加储备(银子*2*HDPZ["保卫长安：鼍龙兕怪"].银子,"保卫战",1)
			self:增加积分(id,20)
			self.数据[id][self.是否记录[战斗类型]]=true
			if 取随机数()<=HDPZ["保卫长安：鼍龙兕怪"].爆率 then
				 local 链接 = {提示=format("#S(长安保卫战)#G/%s#Y直捣虎穴，击败振威大王，并缴获一份",玩家数据[id].角色.名称),频道="xt",结尾="#Y！#24"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["保卫长安：鼍龙兕怪"].ITEM),"保卫长安：鼍龙兕怪")
				if 数量== 9999 then --环
					玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
				end
			end
		end
	end
end

return 长安保卫战