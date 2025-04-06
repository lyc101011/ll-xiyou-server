-- @Author: baidwwy
-- @Date:   2024-06-13 17:01:21
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-09 01:15:04
local 文韵墨香 = class()

function 文韵墨香:初始化()
	self.数据={}
	self.活动开关 = false
	self.巡逻地图={"长安衙门","建邺衙门","国子监书库"}
	self.护送地图={"长寿郊外","大唐国境"}
	self.烧纸地图={"大雁塔一层","大雁塔二层"}
	self.活动时间=QJHDSJ["文韵墨香"]
	self.送信={
		{地图名称="女儿村村长家",人物="孙婆婆",地图编号=1143,跳转={1142,37,37}},
		{地图名称="水晶宫",人物="东海龙王",地图编号=1117,跳转={1116,71,77}},
		{地图名称="程咬金府",人物="程咬金",地图编号=1054,跳转={1198,131,82}},
		{地图名称="藏经阁",人物="空度禅师",地图编号=1043,跳转={1002,7,88}},
		{地图名称="灵台宫",人物="菩提老祖",地图编号=1137,跳转={1135,72,63}},
		{地图名称="凌霄宝殿",人物="李靖",地图编号=1112,跳转={1111,175,122}},
		{地图名称="神木屋",人物="巫奎虎",地图编号=1154,跳转={1138,46,121}},
		}
end

function 文韵墨香:活动定时器()
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

function 文韵墨香:开启活动()
	self.开启Time=os.time()+5400
	self.活动开关=true
	发送公告("#P(文韵墨香)#Y普天盛会，文韵墨香已开启！大家可以到长安城#P礼部侍郎（234，168）#Y领取文韵墨香任务了！")
	广播消息({内容=format("#P(文韵墨香)#Y普天盛会，文韵墨香已开启！大家可以到长安城#P礼部侍郎（234，168）#Y领取文韵墨香任务了！"),频道="hd"})
end

function 文韵墨香:关闭活动(id)
	self.数据={}
	self.活动开关=false
	self.开启Time=nil
	发送公告("#R(文韵墨香)#W活动已经结束，已处战斗中的玩家在战斗结束后依然可以获得奖励。感谢大家的参与！")
	广播消息({内容=format("#R(文韵墨香)#W活动已经结束，已处战斗中的玩家在战斗结束后依然可以获得奖励。感谢大家的参与！"),频道="hd"})
end

function 文韵墨香:添加文墨任务(id)
	local 任务id,ZU=取唯一任务(1163,id)
	local 任务分类=取随机数(1,7)
	任务数据[任务id]={
		领取人id=id,
		id=任务id,
		玩家id=id,
		DWZ=ZU,
		销毁=true,
		起始=os.time(),
		结束=3600,
		队伍组={},
		分类=任务分类,
		类型=1163
	}
	local duihua=""
	if 任务分类==1 then--颜如羽答题
		duihua="科举临近，还需准备大量的砚台，上次听说#Y颜如羽#W处有很多，烦请少侠去借点过来。"
	elseif 任务分类==2 then --场景巡逻
		任务数据[任务id].巡逻地点=self.巡逻地图[取随机数(1,#self.巡逻地图)]
		duihua="科举大赛临近，听说有不少飞贼试图前来盗窃试卷，烦请少侠到各地考点巡查一下。"
	elseif 任务分类==3 then --护送西域使者
		任务数据[任务id].子类=1
		任务数据[任务id].护送地点=self.护送地图[取随机数(1,#self.护送地图)]
		duihua="科举正如火如荼的进行，西域番邦也都纷纷前来观摩，不过听闻西域一使者在途中迷路，少侠去护送一程吧。"
	elseif 任务分类==4 then --陈员外
		任务数据[任务id].子类=1
		duihua="科举临近，还需准备大量毛笔，烦请少侠到陈员外处帮忙制造一些毛笔。"
	elseif 任务分类==5 then --找秦琼写字
		duihua="科举临近，还需准备大量墨锭，听闻#Y秦琼#W大人那边有很多墨锭，还请少侠去借点过来。"
	elseif 任务分类==6 then --各门派送信
		local 序列=取随机数(1,#self.送信)
		任务数据[任务id].SX=self.送信[序列]
		玩家数据[id].道具:给予道具(id,"密信",nil,nil,nil,"专用")
		duihua="唐王为广开言路，所以今年的题目还想请三界门派略出一二题，还想请少侠去求几题来，这是密封信袋，请拿好。"
	else
		任务数据[任务id].子类=1
		duihua="科举临近，还需准备大量的纸张，请少侠到#Y福寿店老板#W处预定一些纸张。"
	end
	if self.数据[id]==nil then
		self.数据[id]={次数=1,取消=0}
	end
	local 队伍id=玩家数据[id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local cyid=队伍数据[队伍id].成员数据[n]
		if self.数据[cyid]==nil then
			self.数据[cyid]={次数=1,取消=0}
		end
		self.数据[cyid].次数=self.数据[id].次数
		添加最后对话(cyid,duihua)
		玩家数据[cyid].角色:添加任务(任务id)
	end
end

function 文韵墨香:任务说明(玩家id,任务id)
	local 说明 = {}
	if not self.活动开关 then
		说明={"文韵墨香",format("活动已经结束。")}
		return 说明
	end
	local 次数=self.数据[玩家id].次数
	if 任务数据[任务id].分类 == 1 then --颜如羽答题
		说明={"文韵墨香",format("到".."#R/qqq|颜如羽*书香斋*npc查询/颜如羽".."#W处借一些砚台。当前第%s环。剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."分钟。",次数)}
	elseif 任务数据[任务id].分类 == 2 then --场景巡逻
		说明={"文韵墨香",format("最近#R%s#W考点有飞贼出现，就去巡逻一番看看。当前第%s环。剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."分钟。",任务数据[任务id].巡逻地点,次数)}
	elseif 任务数据[任务id].分类 == 3 then --护送西域使者
		if 任务数据[任务id].子类==1 then
			说明={"文韵墨香",format("到%s(22，132)处护送".."#R/qqq|西域使者*%s*npc查询/西域使者".."#W，当前第%s环。剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."分钟。",任务数据[任务id].护送地点,任务数据[任务id].护送地点,次数)}
		elseif 任务数据[任务id].子类==2 then
			说明={"文韵墨香",format("将#R西域使者#W带到长安城内，再和其对话，(长安360,195)当前第%s环。剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."分钟。",次数)}
		end
	elseif 任务数据[任务id].分类 == 4 then --陈员外
		if 任务数据[任务id].子类==1 then
			说明={"文韵墨香",format("到".."#R/qqq|陈员外*长安城*npc查询/陈员外".."#W处帮忙制造一些毛笔。当前第%s环。剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."分钟。",次数)}
		elseif 任务数据[任务id].子类==2 then
			说明={"文韵墨香",format("到".."#R/qqq|王武*镇远武馆*npc查询/王武".."(擂台上方房间内)#W处取点木头来。当前第%s环。剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."分钟。",次数)}
		end
	elseif 任务数据[任务id].分类 == 5 then --找秦琼写字
		说明={"文韵墨香",format("到".."#R/qqq|秦琼*秦琼府*npc查询/秦琼".."#W处借一些墨锭。当前第%s环。剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."分钟。",次数)}
	elseif 任务数据[任务id].分类 == 6 then --各门派送信
		说明={"文韵墨香",format("将密封信袋送往".."#R/qqq|%s*%s*npc查询/%s".."#W处，求试题一二。当前第%s环。剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."分钟。",任务数据[任务id].SX.人物,任务数据[任务id].SX.地图名称,任务数据[任务id].SX.人物,次数)}
	elseif 任务数据[任务id].分类 == 7 then --福寿店买纸
		if 任务数据[任务id].子类==1 then
			说明={"文韵墨香",format("到".."#R/qqq|福寿店老板*长安福寿店*npc查询/福寿店老板".."#W处预定一些纸张。当前第%s环。剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."分钟。",次数)}
		elseif 任务数据[任务id].子类==2 then
			说明={"文韵墨香",format("到".."#R/%s#W处烧下符纸。当前第%s环。剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."分钟。",任务数据[任务id].SZDT,次数)}
		end
	end
	return 说明
end

function 任务说明1164(玩家id,任务id)
	return {"文韵墨香",format("到".."#R/qqq|殷丞相*丞相府*npc查询/殷丞相".."#W处领取奖励。剩余时间"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."分钟。")}
end

function 文韵墨香:对话事件处理(id,名称,事件)
	if 事件=="正闲着呢，请吩咐！" then
		if not self.活动开关  then --测试模式
			添加最后对话(id,"当前不是活动时间~")
			return
		elseif 玩家数据[id].队伍==0 or 取队伍人数(id)<1 or 取队伍最低等级(玩家数据[id].队伍,40) then
			添加最后对话(id,"文韵墨香参与条件：≥40级，≥3人")
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
			if 玩家数据[cyid].角色:取任务(1163)~=0 then
				常规提示(cyid,"你已经有了一个这样的任务了！")
				if cyid~=id then
					添加最后对话(id,玩家数据[cyid].角色.名称.."已经领取过任务了")
				end
				go=false
				break
			end
		end
		if go then
			self:添加文墨任务(id)
		end
	elseif 事件=="取消任务" then
		local 任务id=玩家数据[id].角色:取任务(1163)
		if 任务id~=0 then
			玩家数据[id].角色:取消任务(任务id)
			if self.活动开关 and self.数据[id] then
				if self.数据[id]==nil then
					self.数据[id]={次数=1,取消=0}
				end
				self.数据[id].取消=os.time()+300
			end
			添加最后对话(id,"已成功取消，并清空任务次数。5分钟可再次领取。")
		else
			添加最后对话(id,"你没有这样的任务哦。")
		end
	end
end

function 文韵墨香:增加任务次数(id)
	if self.活动开关 then
		if self.数据[id]==nil then
			self.数据[id]={次数=1,取消=0}
		else
			self.数据[id].次数=self.数据[id].次数+1
		end
		if self.数据[id].次数>6 then
			local 任务id,ZU=取唯一任务(1164,id)
			任务数据[任务id]={
				领取人id=id,
				id=任务id,
				玩家id=id,
				DWZ=ZU,
				销毁=true,
				起始=os.time(),
				结束=3600,
				队伍组={},
				类型=1164
			}
			玩家数据[id].角色:添加任务(任务id)
			self.数据[id].次数=1
			发送数据(玩家数据[id].连接id,1501,{名称="",模型="考官2",对话="少侠们如此辛苦，为了表示感谢，殷丞相已经准备了一份礼物赠与你们，不妨去碰碰运气吧#89"})
		end
	end
end

function 文韵墨香:刷新任务(id,类型)
	if self.活动开关 then
		local 任务id=玩家数据[id].角色:取任务(1163)
		local zl
		local sz
		if 类型==3 or 类型==4 or 类型==7 then
			zl=2
			if 类型==7 then
				sz=self.烧纸地图[取随机数(1,#self.烧纸地图)]
			end
		end
		if 任务id~=0 then
			任务数据[任务id].分类=类型
			任务数据[任务id].子类=zl
			任务数据[任务id].SZDT=sz
			任务数据[任务id].起始=os.time()
			玩家数据[id].角色:刷新任务跟踪()
		else
			if self.数据[id]==nil then
			self.数据[id]={次数=1,取消=0}
		else
			self.数据[id].次数=self.数据[id].次数+1
		end
			local 任务id,ZU=取唯一任务(1163,id)
			任务数据[任务id]={
				领取人id=id,
				id=任务id,
				玩家id=id,
				DWZ=ZU,
				销毁=true,
				起始=os.time(),
				结束=3600,
				队伍组={},
				分类=类型,
				子类=zl,
				SZDT=sz,
				类型=1163
			}
			玩家数据[id].角色:添加任务(任务id)
		end
	end
end

function 文韵墨香:设置颜如羽答题(id)
  local 序列=取随机数(1,#科举题库)
  local 正确答案=科举题库[序列][4]
  local 随机答案={}
  for n=2,4 do
	随机答案[n-1]={答案=科举题库[序列][n],序列=取随机数(1,9999)}
  end
  table.sort(随机答案,function(a,b) return a.序列>b.序列 end )
  local 显示答案={}
  for n=1,3 do
	显示答案[n]=随机答案[n].答案
  end
  if self.数据[id]==nil then
		self.数据[id]={次数=1,取消=0}
	end
  self.数据[id].文墨数据={}
  self.数据[id].文墨数据={题目=科举题库[序列][1],答案=显示答案,正确答案=正确答案}
  玩家数据[id].文墨对话="颜如羽"
  发送数据(玩家数据[id].连接id,1501,{名称="颜如羽",模型="男人_老书生",对话=self.数据[id].文墨数据.题目,选项=self.数据[id].文墨数据.答案})
  正确答案=nil
  序列=nil
  随机答案=nil
  显示答案=nil
end

function 文韵墨香:文墨回答题目(id,答案)
	if not self.活动开关 then
		return
	end
	local 正确=false
	玩家数据[id].文墨对话=nil
	if 答案==self.数据[id].文墨数据.正确答案 then
		正确=true
	end
	if 正确 then
		self.数据[id].文墨数据={}
		self:增加任务次数(id)
		local 队伍id=玩家数据[id].队伍
		if 队伍id~=0 then
			for n=1,#队伍数据[队伍id].成员数据 do
				local cyid = 队伍数据[队伍id].成员数据[n]
				玩家数据[cyid].角色:取消任务(玩家数据[cyid].角色:取任务(1163))
				if self.活动开关 and self.数据[cyid] then
					self.数据[cyid].次数=self.数据[id].次数
				end
				local 等级=玩家数据[cyid].角色.等级
				local 经验=等级*取随机数(1250,1350)
				local 银子=等级*140+5000
				玩家数据[cyid].角色:添加经验(经验*HDPZ["文韵墨香"].经验,"文韵墨香",1)
				玩家数据[cyid].角色:添加银子(银子*HDPZ["文韵墨香"].银子,"文韵墨香",1)
				self:设置奖励(cyid)
			end
		end
		发送数据(玩家数据[id].连接id,1501,{名称="颜如羽",模型="男人_老书生",对话="少侠满腹经纶，不错不错。"})
	else
		常规提示(id,"#Y/你还是考虑清楚再回答吧！")
	end
end

function 文韵墨香:见到西域使者(id)
	if 玩家数据[id].队伍 == 0 then
		添加最后对话(id,"路途凶险，少侠还是组队后再来吧！")
		return
	end
	for n=1,#队伍数据[玩家数据[id].队伍].成员数据 do
		local cyid = 队伍数据[玩家数据[id].队伍].成员数据[n]
		self:刷新任务(cyid,3)
		发送数据(玩家数据[cyid].连接id,1501,{名称="西域使者",模型="宝象国国王",对话="少侠真实及时雨啊，我正苦于如何安全到达长安城呢。听说有些地方强盗闹的厉害，少侠可要避开这些区域啊。"})
	end
end

function 文韵墨香:完成文墨护送(id)
	if not self.活动开关 then
		return
	end
	self:增加任务次数(id)
	local 队伍id=玩家数据[id].队伍
	if 队伍id~=0 then
		for n=1,#队伍数据[队伍id].成员数据 do
			local cyid = 队伍数据[队伍id].成员数据[n]
			玩家数据[cyid].角色:取消任务(玩家数据[cyid].角色:取任务(1163))
			if self.活动开关 and self.数据[cyid] then
				self.数据[cyid].次数=self.数据[id].次数
			end
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(1250,1350)
			local 银子=等级*150+6000
			玩家数据[cyid].角色:添加经验(经验*HDPZ["文韵墨香"].经验,"文韵墨香",1)
			玩家数据[cyid].角色:添加银子(银子*HDPZ["文韵墨香"].银子,"文韵墨香",1)
			self:设置奖励(cyid)
		end
	end
end

function 文韵墨香:陈员外对话(id)
	local 队伍id=玩家数据[id].队伍
	if 队伍id~=0 then
		for n=1,#队伍数据[队伍id].成员数据 do
			local cyid = 队伍数据[队伍id].成员数据[n]
			self:刷新任务(cyid,4)
			发送数据(玩家数据[cyid].连接id,1501,{名称="陈员外",模型="仓库保管员",对话="既然是礼部侍郎打人所托，老夫自当从命。只是老夫手头尚缺些木材，听闻长安武馆新进了一批上等木材制作习武木桩，若有余料，自是再好不过。"})
		end
	else
		添加最后对话(id,"还是先组队后再来吧。")
	end
end

function 文韵墨香:王武木材(id)
	if not self.活动开关 then
		return
	end
	self:增加任务次数(id)
	local 队伍id=玩家数据[id].队伍
	if 队伍id~=0 then
		for n=1,#队伍数据[队伍id].成员数据 do
			local cyid = 队伍数据[队伍id].成员数据[n]
			玩家数据[cyid].角色:取消任务(玩家数据[cyid].角色:取任务(1163))
			if self.活动开关 and self.数据[cyid] then
				self.数据[cyid].次数=self.数据[id].次数
			end
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(1250,1350)
			local 银子=等级*150+6000
			玩家数据[cyid].角色:添加经验(经验*HDPZ["文韵墨香"].经验,"文韵墨香",1)
			玩家数据[cyid].角色:添加银子(银子*HDPZ["文韵墨香"].银子,"文韵墨香",1)
			self:设置奖励(cyid)
		end
	end
end

function 文韵墨香:得到纸钱(id)
	local 队伍id=玩家数据[id].队伍
	if 队伍id~=0 then
		玩家数据[id].道具:给予道具(id,"符纸",nil,nil,nil,"专用")
		for n=1,#队伍数据[队伍id].成员数据 do
			local cyid = 队伍数据[队伍id].成员数据[n]
			self:刷新任务(cyid,7)
			发送数据(玩家数据[cyid].连接id,1501,{名称="陈员外",模型="仓库保管员",对话="既然是礼部侍郎打人所托，老夫自当从命。只是老夫手头尚缺些木材，听闻长安武馆新进了一批上等木材制作习武木桩，若有余料，自是再好不过。"})
		end
	else
		添加最后对话(id,"还是先组队后再来吧。")
	end
end

function 文韵墨香:大雁塔烧纸(id)
	if not self.活动开关 then
		return
	end
	self:增加任务次数(id)
	local 队伍id=玩家数据[id].队伍
	if 队伍id~=0 then
		for n=1,#队伍数据[队伍id].成员数据 do
			local cyid = 队伍数据[队伍id].成员数据[n]
			玩家数据[cyid].角色:取消任务(玩家数据[cyid].角色:取任务(1163))
			if self.数据[cyid] then
				self.数据[cyid].次数=self.数据[id].次数
			end
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(1250,1350)
			local 银子=等级*150+6000
			玩家数据[cyid].角色:添加经验(经验*HDPZ["文韵墨香"].经验,"文韵墨香",1)
			玩家数据[cyid].角色:添加银子(银子*HDPZ["文韵墨香"].银子,"文韵墨香",1)
			self:设置奖励(cyid)
		end
	end
end

function 文韵墨香:战斗胜利处理(id组,战斗类型)
	if not self.活动开关 then
		return
	end
	local id=id组[1]
	self:增加任务次数(id)
	for n=1,#id组 do
		local cyid=id组[n]
		玩家数据[cyid].角色:取消任务(玩家数据[cyid].角色:取任务(1163))
		if self.活动开关 and self.数据[cyid] then
			self.数据[cyid].次数=self.数据[id].次数
		end
		local 等级=玩家数据[cyid].角色.等级
		local 经验=等级*取随机数(1250,1350)
		local 银子=等级*150+6000
		玩家数据[cyid].角色:添加经验(经验*HDPZ["文韵墨香"].经验,"文韵墨香",1)
		玩家数据[cyid].角色:添加银子(银子*HDPZ["文韵墨香"].银子,"文韵墨香",1)
		self:设置奖励(cyid)
	end
end

function 文韵墨香:设置奖励(id)
	if 取随机数()<=HDPZ["文韵墨香"].爆率 then
		local 链接 = {提示=format("#P(文韵墨香)#Y普天盛会，文韵墨香！#G%s#Y为了筹备科举而忙里忙外，竟意外获得了礼部侍郎赠送的",玩家数据[id].角色.名称),频道="hd",结尾="#Y！#80"}
						local 名称,数量,参数=生成产出(产出物品计算(HDPZ["文韵墨香"].ITEM),"文韵墨香")
						if 数量== 9999 then --环
							玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
						else
									玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
						end
	end
	-- if 取随机数()<=40 then
	-- 	local 链接 = {提示=format("#P(文韵墨香)#Y普天盛会，文韵墨香！#G%s#Y为了筹备科举而忙里忙外，竟意外获得了礼部侍郎赠送的",玩家数据[id].角色.名称),频道="hd",结尾="#Y！#80"}
	-- 	local 奖励参数=取随机数(1,100)
	-- 	if 奖励参数<=20 then
	-- 		local 名称="金柳露"
	-- 		玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
	-- 	elseif 奖励参数<=25 then
	-- 		local 名称="超级金柳露"
	-- 		玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
	-- 	elseif 奖励参数<=29 then
	-- 		local 名称="召唤兽内丹"
	-- 		玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
	-- 	elseif 奖励参数<=30 then
	-- 		local 名称="高级召唤兽内丹"
	-- 		玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
	-- 	elseif 奖励参数<=36 then
	-- 		local 名称="魔兽要诀"
	-- 		玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
	-- 	elseif 奖励参数<=37 then
	-- 		local 名称="高级魔兽要诀"
	-- 		玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
	-- 	elseif 奖励参数<=39 then
	-- 		local 名称="五宝盒"
	-- 		玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
	-- 	elseif 奖励参数<=40 then
	-- 		local 名称="神兜兜"
	-- 		玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
	-- 	elseif 奖励参数<=55 then
	-- 		local 名称=取强化石()
	-- 		玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
	-- 	elseif 奖励参数<=56 then
	-- 		local 名称="装备特效宝珠"
	-- 		if 取随机数()<10 then
	-- 		    名称="陨铁"
	-- 		end
	-- 		玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接)
	-- 	elseif 奖励参数<=65 then
	-- 		local 名称=取宝石()
	-- 		玩家数据[id].道具:给予超链接道具(id,名称,1,nil,链接)
	-- 	elseif 奖励参数<=68 then
	-- 		local 名称="钨金"
	-- 		玩家数据[id].道具:给予超链接道具(id,名称,1,取随机数(14,16)*10,链接)
	-- 	end
	-- end
end

return 文韵墨香