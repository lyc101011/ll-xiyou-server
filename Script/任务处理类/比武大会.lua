-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-08-14 17:41:21
local 比武大会 = class()
local 灵饰范围={"手镯","佩饰","戒指","耳饰"}
local 书铁范围 = {"枪矛","斧钺","剑","双短剑","飘带","爪刺","扇","魔棒","锤","鞭","环圈","刀","法杖","弓弩","宝珠","巨剑","伞","灯笼","头盔","发钗","项链","女衣","男衣","腰带","鞋子"}
-- 精锐群雄·全服冠军　精锐群雄·全服亚军　精锐群雄·全服季军
-- 勇武群雄·全服冠军　勇武群雄·全服亚军　勇武群雄·全服季军
-- 神威群雄·全服冠军　神威群雄·全服亚军　神威群雄·全服季军
-- 天科群雄·全服冠军　天科群雄·全服亚军　天科群雄·全服季军
-- 天启群雄·全服冠军　天启群雄·全服亚军　天启群雄·全服季军
-- 天元群雄·全服冠军　天元群雄·全服亚军　天元群雄·全服季军
function 比武大会:初始化()
	self.数据={青龙=0,玄武=0,白虎=0,朱雀=0}
	-- self.阵营={}
	self.活动开关=false
	self.结束time=false --初始化固定为false不要动这里
	self.进场开关=false
	self.进场time=0 --5分钟 60*5=300
	self.进场倒计时=0
	self.报名开关=true
	self.正式开启time=false --初始化固定为false不要动这里
	self.正式PK=false
	self.按级分组=true -- =true 就按69、109、129、>129分 否则=false全部天元组
	self.战败限制=3 --失败几次踢出比武场
	self.胜利积分=10 --胜利加的积分
	self.战败积分=2  --战败加的积分
--	self.刷出假人={间隔=120,记录=0}
end

function 比武大会:开启比武() --不想等直接调用
	比武大会数据={进程=0,报名={},玩家表={},精锐组={},神威组={},天科组={},天元组={}} --初始化
    比武大会数据.进程=1
    self.活动开关=true
     self.进场time = os.time()
	self.结束time = os.time() + 3600
	发送公告("#S(比武大会)#Y/开启报名，请想参赛的玩家抓紧通过英雄大会主持人报名。")
end
--比武大会数据.进程 1开启报名
function 比武大会:活动定时器()
	if not self.活动开关 then
	    if 服务端参数.小时=="20" and 服务端参数.分钟=="00" and tonumber(os.date("%w", os.time()))==0 then --晚8点开启
	       比武大会数据={进程=0,报名={},玩家表={},精锐组={},神威组={},天科组={},天元组={}} --初始化
	   	   比武大会数据.进程=1
	   	   self.活动开关=true
	   	   self.进场time = os.time() + 300
	   	--   self.进场time = os.time() + 30 --测试用
	   	   self.结束time = os.time() + 3600
	   	   发送公告("#S(比武大会)#Y/开启报名，请想参赛的玩家抓紧通过英雄大会主持人报名。")
	    end
	else
		if self.活动开关 and 比武大会数据.进程 == 1 and tonumber(self.进场time)~=nil and os.time() - self.进场time >= 0 then
	    	比武大会数据.进程=2
	    	self.进场开关=true
	    	-------------------------------
	    	 self.正式开启time=os.time()+300
	    --	 self.正式开启time=os.time()+30 --测试用
	    	-------------------------------
	    	发送公告("#Y比武大会已经开启进场，请报名成功的玩家抓紧通过英雄大会主持人进入场地(正式比赛将于5分钟后开启,开启后将无法进入比赛地图)。")
	    elseif self.活动开关 and 比武大会数据.进程 == 2 and self.正式开启time and tonumber(self.正式开启time)~=nil and os.time() - self.正式开启time >= 0 then
	        比武大会数据.进程=3
	        self.正式PK=true
	        self.报名开关=false
	        self.进场开关=false
	        self.正式开启time=false
	        ------------------------------
	   	    self.结束time=os.time()+3600 --正式战斗时间60分钟
	   	    ------------------------------
	        for n, v in pairs(地图处理类.地图玩家[1197]) do
	        	if 玩家数据[n] and 玩家数据[n].连接id then
	        		常规提示(n,"#Y/开打开打，现在可通过#R/比武传送人#Y/传送至战场")
		        	消息提示(n,"#Y/开打开打，现在可通过#R/比武传送人#Y/传送至战场")
		        end
	        end
	    end
		if self.活动开关 and self.结束time and tonumber(self.结束time)~=nil and os.time() - self.结束time >= 0 then
			发送公告("#S(比武大会)#Y/比武大会已经结束，请在#R/比武大会主持人#Y/处领取奖励。")
			self.活动开关=false
			self.结束time=false
			self.报名开关=true
			self.正式PK=false
			self.结束time=false
			比武大会数据.进程=0
			self:比武结束计算排名()
			for n, v in pairs(地图处理类.地图玩家[1197]) do
				if 玩家数据[n] and 玩家数据[n].连接id then
					if 玩家数据[n].zhandou ~= 0 then
					    战斗准备类.战斗盒子[玩家数据[n].zhandou]:强制结束战斗()
					    玩家数据[n].zhandou=0
				    end
				    玩家数据[n].当前称谓=""
				    地图处理类:系统更新称谓(n,"")
				    地图处理类:跳转地图(n,1001,取随机数(200,230),取随机数(100,130))
                end
			end
			for n, v in pairs(地图处理类.地图玩家[5136]) do
				if 玩家数据[n] and 玩家数据[n].连接id then
					if 玩家数据[n].zhandou ~= 0 then
					    战斗准备类.战斗盒子[玩家数据[n].zhandou]:强制结束战斗()
					    玩家数据[n].zhandou=0
				    end
				    玩家数据[n].当前称谓=""
				    地图处理类:系统更新称谓(n,"")
				    地图处理类:跳转地图(n,1001,取随机数(200,230),取随机数(100,130))
                end
			end
			for n, v in pairs(地图处理类.地图玩家[5137]) do
				if 玩家数据[n] and 玩家数据[n].连接id then
					if 玩家数据[n].zhandou ~= 0 then
					    战斗准备类.战斗盒子[玩家数据[n].zhandou]:强制结束战斗()
					    玩家数据[n].zhandou=0
				    end
				    玩家数据[n].当前称谓=""
				    地图处理类:系统更新称谓(n,"")
				    地图处理类:跳转地图(n,1001,取随机数(200,230),取随机数(100,130))
                end
			end
			for n, v in pairs(地图处理类.地图玩家[5138]) do
				if 玩家数据[n] and 玩家数据[n].连接id then
					if 玩家数据[n].zhandou ~= 0 then
					    战斗准备类.战斗盒子[玩家数据[n].zhandou]:强制结束战斗()
					    玩家数据[n].zhandou=0
				    end
				    玩家数据[n].当前称谓=""
				    地图处理类:系统更新称谓(n,"")
				    地图处理类:跳转地图(n,1001,取随机数(200,230),取随机数(100,130))
                end
			end
			for n, v in pairs(地图处理类.地图玩家[5139]) do
				if 玩家数据[n] and 玩家数据[n].连接id then
					if 玩家数据[n].zhandou ~= 0 then
					    战斗准备类.战斗盒子[玩家数据[n].zhandou]:强制结束战斗()
					    玩家数据[n].zhandou=0
				    end
				    玩家数据[n].当前称谓=""
				    地图处理类:系统更新称谓(n,"")
				    地图处理类:跳转地图(n,1001,取随机数(200,230),取随机数(100,130))
                end
			end
			return
		end
		-- if os.time() - self.刷出假人.记录 >= self.刷出假人.间隔 then
	 --       self.刷出假人.记录	 = os.time()
	 --       self:比武刷出假人()
	 --    end
	end
end

function 比武大会:排行单位初始化() --服务端启动即加载
	local 地图数据={
		[1]={地图=1001,x=387,y=209,方向=0}, --假人地图、坐标、方向
		[2]={地图=1001,x=391,y=211,方向=0},
		[3]={地图=1001,x=395,y=213,方向=0},
		[4]={地图=1001,x=399,y=215,方向=0},
		[5]={地图=1001,x=404,y=217,方向=0},
		[6]={地图=1001,x=409,y=219,方向=0},
		[7]={地图=1001,x=414,y=222,方向=0},
		[8]={地图=1001,x=419,y=224,方向=0},
		[9]={地图=1001,x=424,y=227,方向=0},
		[10]={地图=1001,x=429,y=229,方向=0},
		[11]={地图=1001,x=434,y=232,方向=0},
		[12]={地图=1001,x=439,y=234,方向=0},
		[13]={地图=1001,x=443,y=236,方向=0},
		[14]={地图=1001,x=447,y=238,方向=0},
		[15]={地图=1001,x=451,y=240,方向=0},
		[16]={地图=1001,x=455,y=242,方向=0},
		[17]={地图=1001,x=459,y=244,方向=0},
		[18]={地图=1001,x=464,y=246,方向=0},
		[19]={地图=1001,x=469,y=248,方向=0},
		[20]={地图=1001,x=475,y=251,方向=0},
	}
	local fz={"精锐组","神威组","天科组","天元组"}
	local cw=""
	for n=1,20 do
		-------------------------随机取名
		local xms=取随机数(2,5)
		local xm=""
		for nv=1,xms do
			xm=xm ..Q_取单字[取随机数(1,#Q_取单字)]
		end
		-------------------------
		if n<=5 then
			cw="精锐组冠军"
		elseif n<=10 then
		    cw="神威组冠军"
		elseif n<=15 then
		    cw="天科组冠军"
		else
		    cw="天元组冠军"
		end
		-------------------------
		local xy=地图处理类.地图坐标[1339]:取随机点()
		-------------------------
		local fjid=3489+n
		local qmp=取随机数(1,15)
		local 模型=Q_随机模型[qmp]
		随机序列=随机序列+1
		local 任务id=取随机数(1999,11111).."_"..fjid.."_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
		任务数据[任务id]={
	      id=任务id,
	      起始=os.time(),
	      结束=99999999999,
	      名称=xm,
	      模型=模型,
	      称谓=cw,
	      武器=Q_随机武器[模型][7],
	      x=xy.x,
	      y=xy.y,
	      地图编号=1339,
	      行走开关=true,
	      序列=n,
	      类型=3489,
	      标识="比武排行单位",
	    }
	    地图处理类:添加单位(任务id)
	end
end

function 比武大会:排行单位变更()
	local 排行编号={}
	local 排行称谓={}
	for n=1,5 do
		排行称谓[n]="天元组冠军"
		排行称谓[n+5]="天科组冠军"
		排行称谓[n+10]="神威组冠军"
		排行称谓[n+15]="精锐组冠军"
	end
	if self.按级分组 then
		for nv,vv in pairs(比武大会数据.天元组) do
			排行编号[nv]=vv.id
		end
		for nv,vv in pairs(比武大会数据.天科组) do
			排行编号[nv+5]=vv.id
		end
		for nv,vv in pairs(比武大会数据.神威组) do
			排行编号[nv+10]=vv.id
		end
		for nv,vv in pairs(比武大会数据.精锐组) do
			排行编号[nv+15]=vv.id
		end
	else --若不分组、则全匹配天元组
		for nv,vv in pairs(比武大会数据.天元组) do
			排行编号[nv]=vv.id
		end
		for n=1,5 do
			排行称谓[n]="天元组冠军"
			排行称谓[n+5]="天元组亚军"
			排行称谓[n+10]="天元组季军"
			排行称谓[n+15]="天元组第" ..数字转大写[n] .."名"
		end
	end
	for n,v in pairs(任务数据) do
		if 任务数据[n] ~= nil and 任务数据[n].类型 == 3489 and 任务数据[n].标识 ~= nil and 任务数据[n].标识 == "比武排行单位" then
			local 序列=任务数据[n].序列
			if 排行编号[序列] ~= nil and 玩家数据[排行编号[序列]] ~= nil then
				local 临时id=排行编号[序列]
				任务数据[n].名称=玩家数据[临时id].角色.名称
				任务数据[n].模型=玩家数据[临时id].角色.模型
				任务数据[n].称谓=排行称谓[序列]
				if 玩家数据[临时id].角色.装备[3] ~= nil then
					local 武器id=玩家数据[临时id].角色.装备[3]
					if 玩家数据[临时id].道具.数据[武器id] ~= nil then
						任务数据[n].武器=玩家数据[临时id].道具.数据[武器id].名称
					end
					if 玩家数据[临时id].角色.锦衣[1] ~= nil then
						local 锦衣id = 玩家数据[临时id].角色.锦衣[1]
						if 玩家数据[临时id].道具.数据[锦衣id] ~= nil then
							任务数据[n].锦衣=玩家数据[临时id].道具.数据[锦衣id].名称
						end
					end
			    end
				地图处理类:更换假人模型数据(n)
			end
		end
	end
end

function 比武大会:比武刷出假人()
-- 	local 地图组={5136,5137,5138,5139}
-- 	local xy=地图处理类.地图坐标[1197]:取随机点()
-- 	local djz={69,109,129,150} --等级组
-- 	local xlz={5,15,20,25} --修炼组
-- 	local fz={"精锐组大赛成员","神威组大赛成员","天科组大赛成员","天元组大赛成员"} --称谓组
-- 	for n=1,#地图组 do
-- 		local 任务id=取唯一任务(3488)
-- 		local dtbh=地图组[n]
-- 		-------------------------随机取名
-- 		local xms=取随机数(2,5)
-- 		local xm=""
-- 		for nv=1,xms do
-- 			xm=xm ..Q_取单字[取随机数(1,#Q_取单字)]
-- 		end
-- 		-------------------------
-- 		local qmp=取随机数(1,15)
-- 		local 模型=Q_随机模型[qmp]
-- 		任务数据[任务id]={
-- 			id=任务id,
-- 			起始=os.time(),
-- 			结束=900,
-- 			玩家id=id,
-- 			称谓=fz[n],
-- 			名称=xm,
-- 			模型=模型,
-- 			x=xy.x,
-- 			y=xy.y,
-- 			地图编号=dtbh,
-- 			武器 = Q_随机武器[模型][7],
-- 			序列=qmp,
-- 			角色=true,
-- 			行走开关=true,
-- 			销毁=true,
-- 			等级=djz[n],
-- 			修炼 = {防修=xlz[n],攻修=xlz[n]},
-- 			类型=3488
-- 		}
-- 		地图处理类:添加单位(任务id)
-- 	end
end
function 比武大会:比武假人对话内容(id,序列,标识,地图)
-- 	local 对话数据={}
-- 	对话数据.模型=任务数据[标识].模型
-- 	对话数据.名称=任务数据[标识].名称
-- 	对话数据.对话="送积分喽~只有运数高的人和存活越久的人才能有幸看到我。"
-- 	对话数据.选项={"积分积分，我要积分！","简直是作弊啊，拜拜！"}
-- 	return 对话数据
end

function 比武大会:比武假人对话事件处理(id,名称,事件,类型,rwid)
-- 	if 任务数据[rwid].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
-- 	if 事件 == "积分积分，我要积分！" then
-- 		战斗准备类:创建战斗(id,134872,rwid)
-- 		任务数据[rwid].zhandou=true
-- 	end
end

function 比武大会:对话事件处理(id,名称,事件)
	if 事件=="我要参加天下英雄大会" then
		if not self.活动开关 then
			添加最后对话(id,"还没到报名时间")
		return
		elseif 玩家数据[id].队伍~=0 then
			添加最后对话(id,"请单人参与报名")
			return
		elseif 玩家数据[id].角色.等级<50 then
			添加最后对话(id,"报名条件：≥50级、人气≥500")
			return
		elseif 比武大会数据.报名[id] then
				添加最后对话(id,"你已经报过名了，无需再报名。")
				return
		elseif self.报名开关==false then
		        添加最后对话(id,"活动已经开始禁止报名。")
				return
		end
		添加最后对话(id,"以你的等级，报名参加比武大会需要交纳"..(玩家数据[id].角色.等级*1000).."两报名费用，你要交纳吗？",{"交纳报名费用","我再想想"})
	elseif 事件=="交纳报名费用" then
		if 玩家数据[id].角色:扣除银子(玩家数据[id].角色.等级*1000,0,0,"比武大会") then
		    比武大会数据.报名[id]={积分=0,分组=""}
		    玩家数据[id].角色:删除比武称谓()
		    添加最后对话(id,"报名成功！请于20点之前来我这里传送至比赛地图。")
		end
	elseif 事件=="打听天下英雄会消息" then
	    添加最后对话(id,"天下英雄会每晚8点开放。活动开启后在我这里报名，等待5分钟后即可入场。入场后有5分钟等待时间，方便玩家组队。正式比赛开始后可通过比武传送人转至战场。\n#R/规则：#W/分组为69以下精锐组、109以下神威组、129以下天科组、130以上天元组，组不组队都行，你可以单挑别人一群，输赢都有积分，每隔段时间会刷出假人，战胜方可获得积分，比武结束后按积分排名。")
	elseif 事件=="进入比赛会场" then
		if not 比武大会数据.报名[id] then
			添加最后对话(id,"请先报名。")
			return
		end
		self.进场倒计时 = self.进场time - os.time()
		if self.进场开关 then
			地图处理类:跳转地图(id,1197,63,41)
		else
			添加最后对话(id,"活动还未正式开始，请耐心等待一下。距离进场还有【" ..self.进场倒计时 .."】",nil,self.进场倒计时)
		end
	elseif 事件=="我前来领取比赛奖励" then
		local pm={排名=0,分组=""}
	    if 比武大会数据.进程 == 0 then
            local fz={"精锐组","神威组","天科组","天元组"}
            for n=1,#fz do
           	   for k,v in pairs(比武大会数据[fz[n]]) do
           	   	  if v.id == id then
           	   	  	  pm.排名 = k
           	   	  	  pm.分组 = fz[n]
           	   	  end
           	   end
            end
	    else
	       添加最后对话(id,"比赛还没结束无法领取！")
	       return
	    end
	    if pm.排名 ~= 0 then
	    	if 比武大会数据.玩家表[id].领取 == false then
	    		比武大会数据.玩家表[id].领取 = true
			    self:领取比赛奖励处理(id,pm.排名,pm.分组)
			else
			    添加最后对话(id,"你已经领取过比武奖励了#24")   --11.16
			end
		else
		   添加最后对话(id,"你没有报名比武，无法领取奖励")
		end
	elseif 事件=="查询英雄榜以及积分" then
		local 待发送数据={}
	    local pm={排名=0,分组="",积分=0}
        local fz={"精锐组","神威组","天科组","天元组"}
        for n=1,#fz do
       	   for k,v in pairs(比武大会数据[fz[n]]) do
       	   	  if v.id == id then
       	   	  	  pm.排名 = k
       	   	  	  pm.积分 = v.积分
       	   	  	  pm.分组 = fz[n]
       	   	  end
       	   end
        end
        待发送数据.我的排名=pm
	    待发送数据["精锐组"]=比武大会数据["精锐组"]
	    待发送数据["神威组"]=比武大会数据["神威组"]
	    待发送数据["天科组"]=比武大会数据["天科组"]
	    待发送数据["天元组"]=比武大会数据["天元组"]
	    发送数据(玩家数据[id].连接id,1039,待发送数据)
	end --事件结束end
end

function 比武大会:领取比赛奖励处理(id,pm,fz) --id,排名,分组 这里给排名奖励
	if 比武大会数据 == nil then 发送网关消息("比武大会数据为空(领取比赛奖励处理)") return end --防错
    local 百强=false
    -- if self.按级分组 then
    	if fz == "精锐组" then
    		if 比武大会数据.精锐组 and 比武精锐组奖励[pm] ~= nil then
    			local 经验=tonumber(比武精锐组奖励[pm].经验) or 0
    			local 银子=tonumber(比武精锐组奖励[pm].银子) or 0
    		    百强=true
    		    玩家数据[id].角色:添加银子(银子,"比武奖励",1)
    		    for k,v in pairs(比武精锐组奖励[pm].物品) do
    		    	local wp=k
    		    	local sl=tonumber(v) or 1
    		    	if ItemData[wp] then
    		    		self:比武给予道具(id,wp,sl)
    		    	else
    		    	    发送网关消息("比武大会领奖励:未定义物品" ..wp )
    		    	end
    		    end
    		end
    	elseif fz == "神威组" then
    		if 比武大会数据.神威组 and 比武神威组奖励[pm] ~= nil then
    			local 经验=tonumber(比武神威组奖励[pm].经验) or 0
    			local 银子=tonumber(比武神威组奖励[pm].银子) or 0
    		    百强=true
    		    玩家数据[id].角色:添加银子(银子,"比武奖励",1)
    		    for k,v in pairs(比武神威组奖励[pm].物品) do
    		    	local wp=k
    		    	local sl=tonumber(v) or 1
    		    	if ItemData[wp] then
    		    		self:比武给予道具(id,wp,sl)
    		    	else
    		    	    发送网关消息("比武大会领奖励:未定义物品" ..wp )
    		    	end
    		    end
    		end
    	elseif fz == "天科组" then
    		if 比武大会数据.天科组 and 比武天科组奖励[pm] ~= nil then
    			local 经验=tonumber(比武天科组奖励[pm].经验) or 0
    			local 银子=tonumber(比武天科组奖励[pm].银子) or 0
    		    百强=true
    		    玩家数据[id].角色:添加银子(银子,"比武奖励",1)
    		    for k,v in pairs(比武天科组奖励[pm].物品) do
    		    	local wp=k
    		    	local sl=tonumber(v) or 1
    		    	if ItemData[wp] then
    		    		self:比武给予道具(id,wp,sl)
    		    	else
    		    	    发送网关消息("比武大会领奖励:未定义物品" ..wp )
    		    	end
    		    end
    		end
    	elseif fz == "天元组" then
    		if 比武大会数据.天元组 and 比武天元组奖励[pm] ~= nil then
    			local 经验=tonumber(比武天元组奖励[pm].经验) or 0
    			local 银子=tonumber(比武天元组奖励[pm].银子)*00000000 or 0
    		    百强=true
    		    玩家数据[id].角色:添加银子(银子,"比武奖励",1)
    		    for k,v in pairs(比武天元组奖励[pm].物品) do
    		    	local wp=k
    		    	local sl=tonumber(v) or 1
    		    	if ItemData[wp] then
    		    		self:比武给予道具(id,wp,sl)
    		    	else
    		    	    发送网关消息("比武大会领奖励:未定义物品" ..wp )
    		    	end
    		    end
    		end
    	end
    if 百强 == false then
    	常规提示(id,"只有比武百强才能获得奖励")
    end
end

function 比武大会:比武给予道具(id,名称,数量)
	local 技能=nil
	local 等级=nil
	local 模式=1 --给予方式默认可叠加
	if 名称 == "灵饰指南书" or 名称 == "元灵晶石" then --数量就是它的等级，写世纪等级，例："元灵晶石":140
		if 数量 < 60 then
  	 	    数量={6,6}
  	 	elseif 数量 > 140 then
  	 	    数量={14,14}
  	    end
  	    技能=灵饰范围[取随机数(1,#灵饰范围)]
  	    模式=2
  	elseif 名称 == "制造指南书" or 名称 == "百炼精铁" then --少许物品有附加参数，你要添加可向我反映
  	    if 等级 < 20 then
 	  	 	等级={2,2}
 	  	elseif 等级 > 150 then
 	  	 	等级={15,15}
 	  	end
 	  	技能=取随机数(1,#书铁范围)
 	  	模式 = 3
 	elseif 名称 == "未激活的符石" then
 		模式 = 2
 	    -- 技能 = 新三级符石[取随机数(1,#新三级符石)]
 	    等级 = 3
 	else
		local 临时道具=物品类(名称)
		临时道具:置对象(名称)
		if not 临时道具.可叠加 then
		  模式 = 2
		end
	end
	if 模式 == 1 then
		玩家数据[id].道具:给予道具(id,名称,数量,技能,nil)
	elseif 模式 == 2 then	--不可叠加
		if tonumber(数量) ~= nil and 数量 > 10 then --不可叠加物品限制发送数量
	 	   数量 = 10
	 	end
	 	for n=1,数量 do
 		    玩家数据[id].道具:给予道具(id,名称,等级,技能,nil)
 		end
	elseif 模式 == 3 then --只给书铁模式
		玩家数据[id].道具:网关给予书铁(id,等级,名称,技能)
	end
end

function 比武大会:比武大会对话入场事件(id) --分组开打
	if 玩家数据[id].队伍~=0 and not 玩家数据[id].队长 then 常规提示(id,"不是队长不配和我说话") return end
	local id组 = {id}
	if 玩家数据[id].队伍~=0 then
	  id组={}
	  for i=1,#队伍数据[玩家数据[id].队伍].成员数据 do
	    id组[#id组+1] = 队伍数据[玩家数据[id].队伍].成员数据[i]
	  end
	end
	if not self:检查报名状态(id) then return end
	if self.按级分组 then
		local 分组信息=self:取比武大会入场参数(id)
		for i=1,#id组 do
		    local 队员分组=self:取比武大会入场参数(id组[i])
		    if 分组信息[2] ~= 队员分组[2] then
		      添加最后对话(id,玩家数据[id组[i]].角色.名称 .."等级分组与队长不一致，无法组队进入场地")
		      return false
		    end
		end
		for i=1,#id组 do
		    比武大会数据.玩家表[id组[i]]={积分=0,小组=分组信息[2],战败=0,地图=分组信息[1],领取=false,保护=0} --11.16改
		    玩家数据[id组[i]].当前称谓="" ..分组信息[2] .."大赛成员"
		    地图处理类:系统更新称谓(id组[i],玩家数据[id组[i]].当前称谓)
	    end
	    local 临时yx=地图处理类.地图坐标[1197]:取随机点()
	    地图处理类:跳转地图(id,分组信息[1],临时yx.x,临时yx.y)
	else --若self.按级分组=false不分什么组就全服进一个地图PK
	    local 分组信息={5139,"天元组"}
	    for i=1,#id组 do
		    比武大会数据.玩家表[id组[i]]={积分=0,小组=分组信息[2],战败=0,地图=分组信息[1],领取=false,保护=0} --11.16改
		    玩家数据[id组[i]].当前称谓="" ..分组信息[2] .."大赛成员"
		    地图处理类:系统更新称谓(id组[i],玩家数据[id组[i]].当前称谓)
	    end
	    local 临时yx=地图处理类.地图坐标[1197]:取随机点()
	    地图处理类:跳转地图(id,分组信息[1],临时yx.x,临时yx.y)
	end
end

function 比武大会:比武结束计算排名()
	local 精锐组jfsj={}
	local 神威组jfsj={}
	local 天科组jfsj={}
	local 天元组jfsj={}
	for k,v in pairs(比武大会数据.玩家表) do
		if 玩家数据[k] and 玩家数据[k].连接id then
			if v.小组 == "精锐组" then
				精锐组jfsj[#精锐组jfsj+1]={名称=玩家数据[k].角色.名称,id=k,积分=v.积分}
			elseif v.小组 == "神威组" then
				神威组jfsj[#神威组jfsj+1]={名称=玩家数据[k].角色.名称,id=k,积分=v.积分}
			elseif v.小组 == "天科组" then
				天科组jfsj[#天科组jfsj+1]={名称=玩家数据[k].角色.名称,id=k,积分=v.积分}
			elseif v.小组 == "天元组" then
			    天元组jfsj[#天元组jfsj+1]={名称=玩家数据[k].角色.名称,id=k,积分=v.积分}
			end
		end
	end
	if #精锐组jfsj > 0 then
		table.sort(精锐组jfsj,function(a,b) return a.积分>b.积分 end )
	end
	if #神威组jfsj > 0 then
		table.sort(神威组jfsj,function(a,b) return a.积分>b.积分 end )
	end
	if #天科组jfsj > 0 then
		table.sort(天科组jfsj,function(a,b) return a.积分>b.积分 end )
	end
	if #天元组jfsj > 0 then
		table.sort(天元组jfsj,function(a,b) return a.积分>b.积分 end )
	end
	for k,v in pairs(精锐组jfsj) do --排名
		比武大会数据.精锐组[k]={名称=v.名称,id=v.id,积分=v.积分}
    end
	for k,v in pairs(神威组jfsj) do
		比武大会数据.神威组[k]={名称=v.名称,id=v.id,积分=v.积分}
    end
	for k,v in pairs(天科组jfsj) do
		比武大会数据.天科组[k]={名称=v.名称,id=v.id,积分=v.积分}
    end
	for k,v in pairs(天元组jfsj) do
		比武大会数据.天元组[k]={名称=v.名称,id=v.id,积分=v.积分}
    end
	self:集体添加排名称谓()
    self:排行单位变更()
end

function 比武大会:集体添加排名称谓()
	local pmcw={"冠军","季军","亚军"}
    local hdcw=""
    for k,v in pairs(比武大会数据.精锐组) do
    	local pmfz="精锐组"
    	local hdcw=""
    	if k <= 5 then
    		hdcw = pmfz ..pmcw[1]
    	elseif k <= 10 then
    	    hdcw = pmfz ..pmcw[2]
    	elseif k <= 15 then
    	    hdcw = pmfz ..pmcw[3]
    	end
    	if hdcw ~= "" and 玩家数据[v.id] and 玩家数据[v.id].连接id and not 玩家数据[v.id].角色:检查称谓(hdcw) then
    		玩家数据[v.id].角色:添加称谓(hdcw)
    	end
    end
    for k,v in pairs(比武大会数据.神威组) do
    	local pmfz="神威组"
    	local hdcw=""
    	if k <= 5 then
    		hdcw = pmfz ..pmcw[1]
    	elseif k <= 10 then
    	    hdcw = pmfz ..pmcw[2]
    	elseif k <= 15 then
    	    hdcw = pmfz ..pmcw[3]
    	end
    	if hdcw ~= "" and 玩家数据[v.id] and 玩家数据[v.id].连接id and not 玩家数据[v.id].角色:检查称谓(hdcw) then
    		玩家数据[v.id].角色:添加称谓(hdcw)
    	end
    end
    for k,v in pairs(比武大会数据.天科组) do
    	local pmfz="天科组"
    	local hdcw=""
    	if k <= 5 then
    		hdcw = pmfz ..pmcw[1]
    	elseif k <= 10 then
    	    hdcw = pmfz ..pmcw[2]
    	elseif k <= 15 then
    	    hdcw = pmfz ..pmcw[3]
    	end
    	if hdcw ~= "" and 玩家数据[v.id] and 玩家数据[v.id].连接id and not 玩家数据[v.id].角色:检查称谓(hdcw) then
    		玩家数据[v.id].角色:添加称谓(hdcw)
    	end
    end
    for k,v in pairs(比武大会数据.天元组) do
    	local pmfz="天元组"
    	local hdcw=""
    	if k <= 5 then
    		hdcw = pmfz ..pmcw[1]
    	elseif k <= 10 then
    	    hdcw = pmfz ..pmcw[2]
    	elseif k <= 15 then
    	    hdcw = pmfz ..pmcw[3]
    	end
    	if hdcw ~= "" and 玩家数据[v.id] and 玩家数据[v.id].连接id and not 玩家数据[v.id].角色:检查称谓(hdcw) then
    		玩家数据[v.id].角色:添加称谓(hdcw)
    	end
    end
end

function 比武大会:取比武大会入场参数(id)
	local 等级=玩家数据[id].角色.等级
	  if 等级<=69 then
	    return {5136,"精锐组"}
	  elseif 等级<=109 then
	    return {5137,"神威组"}
	  elseif 等级<=129 then
	    return {5138,"天科组"}
	  elseif 等级>129 then
	    return {5139,"天元组"}
	  end
end

function 比武大会:检查报名状态(id)
	if 玩家数据[id].队伍==0 then
	    if 比武大会数据.报名[id]==nil then
	      添加最后对话(id,"你还没有在此次大会中报名，现在无法进入大会场地")
	      return false
	    end
    else
        for i=1,#队伍数据[玩家数据[id].队伍].成员数据 do
          local lsid = 队伍数据[玩家数据[id].队伍].成员数据[i]
          if 比武大会数据.报名[lsid] == nil then
            添加最后对话(id,玩家数据[lsid].角色.名称.."尚未在此次大会中报名,现在无法进入大会场地")
            return false
          end
        end
    end
    return true
end

function 比武大会:发起PK(id,内容)
	if 玩家数据[id].队伍 ~= 0 and 玩家数据[id].队长==false then
		常规提示(id,"#Y/只有队长才能触发战斗！")
		return
	elseif 比武大会数据.玩家表[id]~=nil and 比武大会数据.玩家表[id].战败 >= 3 then	--防
		常规提示(id,"#Y/你战败3次无法战斗！")
		return
	elseif 比武大会数据.玩家表[内容.序列]~=nil and 比武大会数据.玩家表[内容.序列].战败 >= 3 then	--防
		常规提示(id,"#Y/对方战败3次无法战斗！")
		return
	elseif 比武大会数据.玩家表[内容.序列]~=nil and 比武大会数据.玩家表[内容.序列].保护 > os.time() then	--防
		local bhsj = 比武大会数据.玩家表[内容.序列].保护 - os.time()
		常规提示(id,"#Y/对方处于保护期" ..bhsj .."秒后才能战斗！")
		return
	end
	local PK地图=玩家数据[id].角色.地图数据.编号 or 内容.PK地图
	local 对手id=内容.序列
	if 玩家数据[对手id] == nil then return 常规提示(id,"#Y/对方不在线！") end
	local 对手地图=玩家数据[对手id].角色.地图数据.编号
	if 比武大会数据.进程 == 3 and self.正式PK then
	    if (PK地图==1197 or PK地图==5136 or PK地图==5137 or PK地图==5138 or PK地图==5139) and (对手地图==1197 or 对手地图==5136 or 对手地图==5137 or 对手地图==5138 or 对手地图==5139) then
		   战斗准备类:创建玩家战斗(id, 200003, 对手id, PK地图)
		else
		   常规提示(id,"#Y/对方或你不在比武地图中！")
		end
	end
end

function 比武大会:PK胜利处理(胜利组,失败组)
	if not self.活动开关 then return end
	for i=1,#胜利组 do
		local 胜利id=胜利组[i]
		玩家数据[胜利id].zhandou = 0
		if 比武大会数据.玩家表[胜利id] then
		   比武大会数据.玩家表[胜利id].积分 = 比武大会数据.玩家表[胜利id].积分 + self.胜利积分
		   常规提示(胜利id,"#Y/获得本场胜利，积分+" ..self.胜利积分)
        end
    end
	for i=1,#失败组 do
		local 失败id=失败组[i]
		玩家数据[失败id].zhandou = 0
		if 比武大会数据.玩家表[失败id] then
		    比武大会数据.玩家表[失败id].积分 = 比武大会数据.玩家表[失败id].积分 + self.战败积分
		    比武大会数据.玩家表[失败id].战败 = 比武大会数据.玩家表[失败id].战败 + 1
		    比武大会数据.玩家表[失败id].保护 = os.time() + 30
		    if 比武大会数据.玩家表[失败id].战败 >= self.战败限制 then
		       玩家数据[失败id].当前称谓=""
		       地图处理类:系统更新称谓(失败id,玩家数据[失败id].当前称谓)
		   	   队伍处理类:退出队伍(失败id)
		   	   地图处理类:跳转地图(失败id,1001,214,115)
		   	   常规提示(失败id,"#Y/你已战败" ..self.战败限制 .."次，慢走不送！")
		   	else
		   	   常规提示(失败id,"#Y/你已战败,只获得" ..self.战败积分 .."积分")  --战败也有积分是为了让玩家积极战斗，而不是打不过就避战
		   	end
		end
	end
end

-- function 比武大会:假人PK胜利处理(任务id,id组,战斗类型)
-- 	if 任务数据[任务id]==nil then
-- 		return
-- 	end
-- 	local id=id组[1]
-- 	for n=1,#id组 do
-- 		local 胜利id=id组[n]
-- 		玩家数据[胜利id].zhandou = 0
-- 		if 比武大会数据.玩家表[胜利id] then
-- 		   比武大会数据.玩家表[胜利id].积分 = 比武大会数据.玩家表[胜利id].积分 + self.胜利积分
-- 		   常规提示(胜利id,"#Y/获得本场胜利，积分+" ..self.胜利积分)
--         end
-- 	end
-- 	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
-- 	任务数据[任务id]=nil
-- end

return 比武大会