-- @Author: baidwwy
-- @Date:   2024-08-30 18:34:24
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-09 13:47:17
local 剑会天下 = class()
local 变身卡选项={"龟丞相","白熊","黑山老妖","天兵","天将","地狱战神","风伯","凤凰","蛟龙","如意仙子","巡游天神","星灵仙子","芙蓉仙子","幽灵","吸血鬼","鬼将","雾中仙","夜罗刹","噬天虎","进阶猫灵人形","进阶毗舍童子","进阶夜罗刹","进阶混沌兽","进阶曼珠沙华"}
local function 积分排序(a,b) return a.积分<b.积分 end
local qz=math.floor
function 剑会天下:初始化()
	self.检测time=0
	self.活动开关=false
	self.正式开始=false
	self.备战Time=0
	self.结束time=0
    self.房间数据={}
    self.发送数据={}
    self.五人匹配={}
    self.五人匹配["天元组"]={}
    self.五人匹配["天启组"]={}
    self.五人匹配["天科组"]={}
    self.五人匹配["神威组"]={}
    self.五人匹配["勇武组"]={}
    self.五人匹配["精锐组"]={}
    self.假人={} --外部数据，战斗内调用
    ---------------------奖励这里改
    self.战胜假人积分 = {a=15,b=25} --要比真人少
    self.胜利经验 = 1000000
    self.胜利银子 = 100000
    self.失败经验 = 100000
    self.失败银子 = 10000
    ---------------------
    self.剑会排行={天元组={},天启组={},天科组={},神威组={},勇武组={},精锐组={}}
	-- self.活动时间=QJHDSJ["剑会天下"]
	if f函数.文件是否存在(程序目录..[[sql/剑会排行.txt]])==false then
		写出文件([[sql/剑会排行.txt]],table.tostring(self.剑会排行))
	else
		self.剑会排行=table.loadstring(读入文件(程序目录..[[sql/剑会排行.txt]]))
	end
	if f函数.文件是否存在(程序目录..[[sql/剑会待领取.txt]])==false then
		self.剑会待领取={}
		写出文件([[sql/剑会待领取.txt]],table.tostring(self.剑会待领取))
	else
		self.剑会待领取=table.loadstring(读入文件(程序目录..[[sql/剑会待领取.txt]]))
	end
end

function 剑会天下:活动定时器()
	if 服务端参数.小时+0 == 20 and 服务端参数.分钟+0 == 0 and tonumber(self.检测time) ~= nil and os.time() - self.检测time >= 1 then
		self:开启活动()---华山剑会开启时间
	end
	if self.活动开关 and not self.正式开始 and self.备战Time - os.time() <= 0 then
		self.正式开始=true
		广播消息({内容="#R《剑会天下·团队赛》#G活动正式开始，现可通过#Y/剑会主持人#G/寻找对手PK了。",频道="xt"})
	    发送公告("#R《剑会天下·团队赛》#G活动正式开始，现可通过#Y/剑会主持人#G/寻找对手PK了。")
	elseif self.活动开关 and self.正式开始 and self.结束time - os.time() <= 0 then
	    self:关闭活动()
	elseif self.活动开关 and self.正式开始 then
		self:自动匹配_五人()
	end
end

function 剑会天下:开启活动()
	Q_剑会赛季 = Q_剑会赛季 + 1 --剑会天下
	self.活动开关=true
	self.检测time=os.time()+9999
    self.正式开始=false
	self.备战Time=os.time()+600 --前10分钟是准备时间
	self.结束time=self.备战Time+3600 --60分钟时间
	self.剑会排行={天元组={},天启组={},天科组={},神威组={},勇武组={},精锐组={}}
	self.剑会待领取={}
	----------------------------测试用
	-- self.活动开关=true
	-- self.检测time=os.time()+9999
 --    self.正式开始=false
	-- self.备战Time=os.time()+8 --前30分钟是准备时间
	-- self.结束time=self.备战Time+99972 --两小时PK时间
	-- self:重置赛季剑会数据()
	----------------------------
	-- 广播消息({内容="#R《华山剑会》#G活动开启，三界之中，谁是英豪！凡三界之侠士，俱可前往其中一试身手。#Y（长安华山接引人205，116处）",频道="xt"})
	广播消息({内容="#R《剑会天下·团队赛》#G活动开启，三界之中，谁是英豪！凡三界之侠士，俱可前往其中一试身手。#Y（长安欧冶子之灵142，177处）",频道="xt"})
	发送公告("#R《剑会天下·团队赛》#G活动开启，三界之中，谁是英豪！凡三界之侠士，俱可前往其中一试身手。（长安欧冶子之灵142，177处）")
end

function 剑会天下:重置赛季剑会数据()
	for id,v in pairs(玩家数据) do
		if 玩家数据[id] then
			if 玩家数据[id].角色.剑会数据==nil then
				玩家数据[id].角色.剑会数据={总场=0,战胜=0,战败=0,胜率=50,赛季场次=0,赛季积分=1000,商店积分=0,参加赛季=0}
			else
			    玩家数据[id].角色.剑会数据.赛季场次=0
			    self:单独重置胜率(id)
				玩家数据[id].角色.剑会数据.赛季积分=1000 --每次剑会开启后重置
			end
		end
	end
end

function 剑会天下:单独重置赛季剑会数据(id) --防有的玩家上次剑会中退出，下赛季再中途加入
	if 玩家数据[id] then
		if 玩家数据[id].角色.剑会数据==nil then
			玩家数据[id].角色.剑会数据={总场=0,战胜=0,战败=0,胜率=50,赛季场次=0,赛季积分=1000,商店积分=0,参加赛季=0}
		else
			if 玩家数据[id].角色.剑会数据.参加赛季 ~= Q_剑会赛季 then
			    玩家数据[id].角色.剑会数据.赛季场次=0
			    self:单独重置胜率(id)
				玩家数据[id].角色.剑会数据.赛季积分=1000 --每次剑会开启后重置
			end
		end
	end
end

function 剑会天下:关闭活动()
    self.活动开关=false
    self.正式开始=false
	self.备战Time=0
	self.结束time=0
	for k,v in pairs(玩家数据) do
		self:踢出地图(k)
	end
	--self.剑会待领取
	local 组类={"精锐组","勇武组","神威组","天科组","天启组","天元组"}
	for n=1,#组类 do
		if type(self.剑会排行[组类[n]])=="table" then
			for kn,vn in pairs(self.剑会排行[组类[n]]) do
				if 101-kn > 0 then
					self.剑会待领取[vn.id] = (101-kn) * 50
				end
			end
        end
	end
    写出文件([[sql/剑会待领取.txt]],table.tostring(self.剑会待领取))
	写出文件([[sql/剑会排行.txt]],table.tostring(self.剑会排行))
	广播消息({内容="#S《剑会天下·团队赛》#R此次活动结束，还处于战斗中的玩家仍可获得奖励。",频道="xt"})
	发送公告("#S《剑会天下·团队赛》#R此次活动结束，还处于战斗中的玩家仍可获得奖励。")
end

function 剑会天下:踢出地图(id)
	if 玩家数据[id]==nil then return end
	if not self.活动开关 and (玩家数据[id].角色.地图数据.编号 == 6135 or 玩家数据[id].角色.地图数据.编号 == 6136) then
		local xy=地图处理类.地图坐标[1001]:取随机点()
        地图处理类:跳转地图(id,1001,xy.x,xy.y)
	end
end

function 剑会天下:NPC对话内容(ID,编号,页数,已经在任务中,id)
	local wb = {}
	local xx = {}
	if ID == 6135 then
		-- if 编号 == 1 then
		wb[1] = "在活动场地可购买战备，少侠是否要前往？还是要先去擂台玩玩？"
		xx = {"我要前往活动场地购买战备","先去擂台玩玩","点错了"}
		return {"男人_马副将","战备管理员",wb[1],xx}
		-- end
	elseif ID == 6136 then
		if 编号 == 1 then
			wb[1] = "剑会等级段分组：\n天元组:≥160级   天启组：130级-159级   天科组：110级-129级   神威组：90级-109级  勇武组：70级-89级   精锐组：≤69级\n你的等级为" ..玩家数据[id].角色.等级 .."级，将自动匹配到" ..self:等级取分组(id)
			xx = {"查看剑会房间列表","点错了"}
			return {"男人_兰虎","剑会主持人",wb[1],xx}
		elseif 编号 == 2 then
		    wb[1] = "在这里你可以购买药品、设置变身"
			xx = {"购买药品","设置变身","点错了"}
			-- xx = {"设置变身","点错了"}
			return {"男人_马副将","战备管理员",wb[1],xx}
		end
	end
end

function 剑会天下:对话事件处理(id,名称,事件)
	if 名称=="华山接引人"  then
        if 事件=="我要参加剑会天下" or 事件=="剑会天下（团队模式）" then
        	if not self.活动开关 then
        		常规提示(id,"现在不是活动时间")
        		return
        	-- elseif self.活动开关 and self.正式开始 then
        	-- 	常规提示(id,"剑会已经正式开始，无法进入，下次要早点来吧！")
        	-- 	return
        	end
        	if 玩家数据[id].角色.剑会数据==nil then
				玩家数据[id].角色.剑会数据={总场=0,战胜=0,战败=0,胜率=50,赛季场次=0,赛季积分=1000,商店积分=0,参加赛季=0}
			else
				玩家数据[id].角色.剑会数据.参加赛季 = Q_剑会赛季
			    玩家数据[id].角色.剑会数据.赛季场次=0
			    self:单独重置胜率(id)
				玩家数据[id].角色.剑会数据.赛季积分=1000 --每次剑会开启后重置
			end
			local djdbxf=false
			if 玩家数据[id].队伍~=0 then
				local 队伍id=玩家数据[id].队伍
				for n=1,#队伍数据[队伍id].成员数据 do
					local 队员id=队伍数据[队伍id].成员数据[n]
					if 玩家数据[队员id].角色.剑会数据==nil then
						玩家数据[队员id].角色.剑会数据={总场=0,战胜=0,战败=0,胜率=50,赛季场次=0,赛季积分=1000,商店积分=0,参加赛季=0}
					else
						玩家数据[队员id].角色.剑会数据.参加赛季 = Q_剑会赛季
					    玩家数据[队员id].角色.剑会数据.赛季场次=0
					    self:单独重置胜率(队员id)
						玩家数据[队员id].角色.剑会数据.赛季积分=1000 --每次剑会开启后重置
					end
					if self:等级段不相符(id,队伍数据[队伍id].成员数据[n]) then
						djdbxf = 玩家数据[队伍数据[队伍id].成员数据[n]].角色.名称
						break
					end
	            end
			end
			if djdbxf then 常规提示(id,"玩家#R/" ..djdbxf .."#Y/等级段不一致") return end
        	地图处理类:跳转地图(id,6135,142,176)
        	-- 常规提示(id,"#S注意：#R"..self.备战Time - os.time().."#Y秒后，将无法再进入本场地！")
        -----------------------剑会天下
        elseif 事件=="领取排行积分" then
        	if self.剑会待领取[id]~=nil then
        		玩家数据[id].角色.剑会数据.商店积分 = 玩家数据[id].角色.剑会数据.商店积分 + self.剑会待领取[id]
        		self.剑会待领取[id]=nil
        	else
        	  常规提示(id,"你没有待领取积分")
        	end
        elseif 事件=="积分兑换" or 事件=="兑换奖励（团队）" then
        	local 对话="商店积分和赛季积分是不一样的哦！赛季积分是每次剑会开启后重置，用来排名，然后按排名给商店积分。商店积分是永久存在的，类似银子。在我这里可以用商店积分兑换商品，现在要兑换商品吗？"
        	local 选项={"嗯我现在要兑换","等我攒够一箩筐积分再来兑换"}
        	发送数据(玩家数据[id].连接id,1501,{名称="华山接引人",模型="男人_道士",对话=对话,选项=选项})
        elseif 事件=="嗯我现在要兑换" then
        	if 玩家数据[id].角色.剑会数据==nil then
				玩家数据[id].角色.剑会数据={总场=0,战胜=0,战败=0,胜率=50,赛季场次=0,赛季积分=1000,商店积分=0,参加赛季=0}
			end
			local 积分 = 玩家数据[id].角色.剑会数据.商店积分
            发送数据(玩家数据[id].连接id,411,{积分=积分,类型="道具",数据=table.copy(剑会商店类:取商品数据())})
        elseif 事件=="查看排行榜" then
        	local 临时排行 = self:取剑会排行榜()
            发送数据(玩家数据[id].连接id,409,table.copy(临时排行))
        -----------------------
        end
    elseif 名称=="战备管理员" then
    	if 事件=="我要前往活动场地购买战备" then
    		local xy=地图处理类.地图坐标[6136]:取随机点()
        	地图处理类:跳转地图(id,6136,xy.x,xy.y)
        elseif 事件=="先去擂台玩玩" then
        	地图处理类:跳转地图(id,6135,392,183)
        elseif 事件=="购买药品" then
        	玩家数据[id].商品列表=商店处理类.商品列表[53]
			发送数据(玩家数据[id].连接id,9,{商品=商店处理类.商品列表[53],银子=玩家数据[id].角色.银子})
        elseif 事件=="设置变身" then
        	发送数据(玩家数据[id].连接id,1501,{名称="剑会星君",模型="男人_太上老君",对话="请选择你要变身的动物",选项=变身卡选项})
        -- elseif 事件=="购买强化符" then
        -- 	local spsj = self:取强化符商店()
        -- 	发送数据(玩家数据[id].连接id,436,spsj)
        end
    elseif 名称=="剑会主持人" then
        if 事件=="查看剑会房间列表" then
        	local 房间总数=0
        	self.发送数据={}
        	self.发送数据,房间总数 = self:取预发送房间(id)
        	self.发送数据.房间总数 = 房间总数
        	self.发送数据.已有房间 = self:是否已有房间(id)
        	发送数据(玩家数据[id].连接id,400,table.copy(self.发送数据))
        end
    elseif 名称=="剑会星君" then
    	for k,v in pairs(变身卡选项) do
    		if 事件==v then
    			if 玩家数据[id].角色:取任务(1)~=0 then
					任务数据[玩家数据[id].角色:取任务(1)]=nil
					玩家数据[id].角色:取消任务(1)
				end
			    玩家数据[id].角色.变身数据=v
			    玩家数据[id].角色:刷新信息()
		        发送数据(玩家数据[id].连接id,37,玩家数据[id].角色.变身数据)
		        发送数据(玩家数据[id].连接id,47,{玩家数据[id].角色:取气血数据()})
				发送数据(玩家数据[id].连接id,12)
				设置任务1(id,8,玩家数据[id].角色.变身数据)
				地图处理类:更改模型(id,玩家数据[id].角色.变身数据,1)
				常规提示(id,"你已变身为#R/" ..v)
    			break
            end
    	end
	end
end

function 剑会天下:取强化符商店()
	-- local 临时道具={}
	-- local djz={
	-- 	{名称="强化符",技能="尸气漫天"},
	-- 	{名称="强化符",技能="神兵护法"},
	-- 	{名称="强化符",技能="嗜血"},
	-- 	{名称="强化符",技能="莲华妙法"},
	-- 	{名称="强化符",技能="担山赶月"},
	-- 	{名称="强化符",技能="轻如鸿毛"},
	-- 	{名称="强化符",技能="盘丝舞"},
	-- 	{名称="强化符",技能="魔王护持"},
	-- 	{名称="强化符",技能="龙附"},
	-- 	{名称="强化符",技能="元阳护体"},
	-- 	{名称="强化符",技能="浩然正气"},
	-- 	{名称="强化符",技能="一气化三清"},
	-- 	{名称="强化符",技能="神力无穷"},
	-- 	{名称="强化符",技能="穿云破空"},
	-- 	{名称="强化符",技能="拈花妙指"},
	-- 	{名称="强化符",技能="神木呓语"},
	-- }
	-- for an=1,#djz do
	-- 	临时道具[an]=物品类()
	-- 	临时道具[an]:置对象(djz[an].名称,djz[an])
	-- 	临时道具[an].名称 = djz[an].名称
	-- 	临时道具[an].等级 = 180
	-- 	临时道具[an].技能 = djz[an].技能
	-- 	临时道具[an].分类 = 取强化符分类(djz[an].技能)
	-- end
	-- return 临时道具
end

function 剑会天下:购买强化符处理(数字id,xz)
	-- if 玩家数据[数字id]==nil or xz==nil then
	-- 	return
	-- end
	-- local 选中 = xz+0
	-- local spsj = self:取强化符商店()
	-- if spsj[选中]~=nil then
	-- 	if 玩家数据[数字id].角色:扣除银子(1,0,0,"剑会购买强化符",1) then----5人剑会临时符
	-- 	   玩家数据[数字id].道具:给予道具(数字id,spsj[选中].名称,nil,nil,"不存共享",nil,spsj[选中])
	-- 	end
	-- end
end

function 剑会天下:数据处理(id,内容)
	if 玩家数据[id]==nil then return end
	if 内容.操作 == "创建房间" then
		local 已有房间 = self:是否已有房间(id)
		if 已有房间 then
			常规提示(id,"你已经在" ..已有房间 .."号房间了")
		else
			self:创建房间处理(id,内容)
		end
	elseif 内容.操作 == "我的房间" then
		self.发送数据={}
    	self.发送数据 = self:取我的房间(id)
    	self.发送数据.已有房间 = self:是否已有房间(id)
		发送数据(玩家数据[id].连接id,401,table.copy(self.发送数据))
	elseif 内容.操作 == "加入房间" then
		self:加入房间处理(id,内容)
	elseif 内容.操作 == "快速组队" then
	    self:快速组队处理(id)
	elseif 内容.操作 == "退出房间" then
	    队伍处理类:退出队伍(id)
	elseif 内容.操作 == "准备游戏" then
		if self.活动开关 and self.正式开始 then
		    self:准备游戏处理(id)
		else
			发送数据(玩家数据[id].连接id,1501,{名称="战备管理员",模型="男人_马副将",对话="报名时间未结束，PK时间未到。#R正式开始倒计时："..self.备战Time - os.time().."秒，#W少侠不妨先去擂台玩玩。",选项={"先去擂台玩玩","我不去"}})
		end
	elseif 内容.操作 == "离开队列" then
	    self:离开队列处理(id)
	elseif 内容.操作 == "对方阵容" or 内容.操作 == "己方阵容" then
	    self:发送对方阵容(id,内容.操作)
	elseif 内容.操作 == "战斗物品设置" then
	    发送数据(玩家数据[id].连接id,1501,{名称="战备管理员",模型="男人_马副将",对话="自行购买剑会药品后放在背包前20格即可"})
	elseif 内容.操作 == "变身效果设置" then
	    发送数据(玩家数据[id].连接id,1501,{名称="剑会星君",模型="男人_太上老君",对话="请选择你要变身的动物",选项=变身卡选项})
	elseif 内容.操作 == "最后准备" then
		if self.活动开关 and self.正式开始 then
		    self:最后准备处理(id,内容.按钮文字)
		else
			发送数据(玩家数据[id].连接id,1501,{名称="战备管理员",模型="男人_马副将",对话="活动时间已过。"})
		end
	-- elseif 内容.操作 == "购买强化符" then
	-- 	self:购买强化符处理(id,内容.选中)
	end
end

--============================================================剑会天下队伍处理-始
function 剑会天下:创建房间处理(id,内容)
	if 玩家数据[id].队伍 == 0 or not 玩家数据[id].队长 then 常规提示(id,"只有队长才可进行此操作") return end
	local 队伍id=玩家数据[id].队伍
	if 队伍数据[队伍id] == nil then return end
	local 可创建 = true
	local 临时数据 = {id组={},成员数据={},对方成员={},队长编号=nil,队长id=nil,房间编号=nil,房间密码=nil,zhandou=0,分组=nil,战斗倒计时=false,对手类型=false} --把(临时数据)插入(self.房间数据)
	for n=1,#队伍数据[队伍id].成员数据 do
		if 队伍数据[队伍id].成员数据[n] ~= nil and 玩家数据[队伍数据[队伍id].成员数据[n]] ~= nil then
			local 成员id = 队伍数据[队伍id].成员数据[n]
			if self:等级段不相符(id,成员id) then 可创建 = false end
			if 成员id == id then 临时数据.队长编号 = n end
			table.insert(临时数据.id组,成员id)
			临时数据.成员数据[n] = 玩家数据[成员id].角色:取队伍信息()
			临时数据.成员数据[n].准备=false
			临时数据.成员数据[n].最后准备=false --最后一步剑会战斗准备界面的
			临时数据.成员数据[n].剑会数据 = 玩家数据[成员id].角色.剑会数据
		end
	end
	if 可创建 == false then 常规提示(id,"创建房间失败，有队员等级段与队长不一致") return end
	临时数据.队长id = id
	临时数据.zhandou = 玩家数据[id].zhandou --只要取队长是否战斗中就行
	临时数据.分组 = self:等级取分组(id)
	if 内容.建房打勾==true and string.len(内容.建房密码)>3 then 临时数据.房间密码 = 内容.建房密码 end
	table.insert(self.房间数据,临时数据)
	self:重置房间编号()
	常规提示(id,"创建房间成功")
	local 已有房间 = self:是否已有房间(id)
	if 已有房间 then
		self.发送数据={}
		self.发送数据=table.copy(self.房间数据[已有房间])
		self.发送数据.已有房间 = 已有房间
		发送数据(玩家数据[id].连接id,401,table.copy(self.发送数据))
	end
end

function 剑会天下:加入房间处理(id,内容)
	local 房间编号=内容.房间编号+0
	if self.房间数据[房间编号]==nil then 常规提示(id,"房间不存在，请重新打开界面") return end
	local 已有房间 = self:是否已有房间(id)
	if 已有房间 then
		常规提示(id,"加入房间失败，你已有房间了，回你房间去！")
	elseif #self.房间数据[房间编号].id组 >= 5 then
	    常规提示(id,"加入房间失败，房间已满员！")
	elseif 玩家数据[id].队伍 ~= 0 then --房间密码
	    常规提示(id,"禁止组队进入！")
	elseif self.房间数据[房间编号].房间密码 ~= 内容.房间密码 then
	    常规提示(id,"房间密码错误！")
	else
	    table.insert(self.房间数据[房间编号].id组,id)
	    local 临时数据 = {}
	    临时数据 = 玩家数据[id].角色:取队伍信息()
	    临时数据.准备=false
	    临时数据.最后准备=false
	    临时数据.剑会数据 = 玩家数据[id].角色.剑会数据
	    table.insert(self.房间数据[房间编号].成员数据,临时数据)
	    self:队伍数据_加入队伍(id,房间编号)
	    self:房间列表信息刷新()
	    发送数据(玩家数据[id].连接id,403)
	    self:刷新我的房间(房间编号)
	end
end

function 剑会天下:队伍数据_加入队伍(id,房间编号)
	local 队伍id = self.房间数据[房间编号].队长id
	队伍数据[队伍id].成员数据[#队伍数据[队伍id].成员数据+1]=id
	玩家数据[id].队伍=队伍id
    玩家数据[id].队长=false
    for n=1,#队伍数据[队伍id].成员数据 do
		队伍处理类:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
	end
end

function 剑会天下:快速组队处理(id) --优先加入自己账号下的队伍
	if 玩家数据[id]==nil then return end
	if 玩家数据[id].队伍 ~= 0 then 常规提示(id,"你已经有队伍了") return end
	local 对方id,房间编号 = false,false
	local 继续匹配 = true
	local zhxx=读入文件(程序目录..[[data/]]..玩家数据[id].账号..[[/信息.txt]])
	local 帐号id组 = table.loadstring(zhxx)
	for n=1,#帐号id组 do
		if 帐号id组[n] ~= id and 玩家数据[帐号id组[n]]~=nil and 玩家数据[帐号id组[n]].连接id and 玩家数据[帐号id组[n]].队长 then --自己号的房间不需要密码就可加入
			local 已有房间 = self:是否已有房间(帐号id组[n])
			if self.房间数据[已有房间] ~= nil and #self.房间数据[已有房间].成员数据 < 5 then
				对方id = 帐号id组[n]
				房间编号 = 已有房间
				继续匹配 = false
				break
			end
		end
	end
	if 继续匹配 then
		for k,v in pairs(self.房间数据) do
			if 玩家数据[v.队长id] ~= nil and 玩家数据[v.队长id].连接id and 玩家数据[v.队长id].队长 and not v.房间密码 then --别人有密码的房间不能快速加入
				local 已有房间 = self:是否已有房间(v.队长id)
				if self.房间数据[已有房间] ~= nil and #self.房间数据[已有房间].成员数据 < 5 then
					对方id = v.队长id
					房间编号 = 已有房间
					break
				end
			end
		end
	end
	if 对方id and 房间编号 then
		table.insert(self.房间数据[房间编号].id组,id)
	    local 临时数据 = {}
	    临时数据 = 玩家数据[id].角色:取队伍信息()
	    临时数据.准备=false
	    临时数据.最后准备=false
	    临时数据.剑会数据 = 玩家数据[id].角色.剑会数据
	    table.insert(self.房间数据[房间编号].成员数据,临时数据)
	    self:队伍数据_加入队伍(id,房间编号)
	    self:房间列表信息刷新()
	    self:刷新我的房间(房间编号)
	end
end

function 剑会天下:房间列表信息刷新()
	for id,v in pairs(玩家数据) do
		if 玩家数据[id]~=nil and 玩家数据[id].连接id ~= nil and 玩家数据[id].角色.地图数据.编号 == 6136 then
			local 房间总数=0
        	self.发送数据={}
        	self.发送数据,房间总数 = self:取预发送房间(id)
        	self.发送数据.房间总数 = 房间总数
        	self.发送数据.已有房间 = self:是否已有房间(id)
			发送数据(玩家数据[id].连接id,402,table.copy(self.发送数据))
		end
	end
end

function 剑会天下:刷新我的房间(已有房间)
	if self.房间数据[已有房间] ~= nil then
		self.发送数据={}
		self.发送数据=table.copy(self.房间数据[已有房间])
		self.发送数据.已有房间 = 已有房间
		for n=1,#self.房间数据[已有房间].id组 do
			if self.房间数据[已有房间].id组[n]~=nil and 玩家数据[self.房间数据[已有房间].id组[n]]~=nil then
				发送数据(玩家数据[self.房间数据[已有房间].id组[n]].连接id,401,table.copy(self.发送数据))
			end
		end
	end
end

function 剑会天下:同意入队(id,对方id)
	local 已有房间 = self:是否已有房间(id)
	if 玩家数据[对方id]~=nil and 玩家数据[对方id].角色.剑会数据==nil then
		玩家数据[对方id].角色.剑会数据={总场=0,战胜=0,战败=0,胜率=50,赛季场次=0,赛季积分=1000,商店积分=0,参加赛季=0}
	end
	if self.房间数据[已有房间] ~= nil then
		if 玩家数据[对方id].角色.地图数据.编号 >=6135 and 玩家数据[对方id].角色.地图数据.编号 <= 6139 then
			if #self.房间数据[已有房间].成员数据 >= 5 then
				常规提示(id,"房间已满员")
				常规提示(对方id,"房间已满员")
			else
				table.insert(self.房间数据[已有房间].id组,对方id)
			    local 临时数据 = {}
			    临时数据 = 玩家数据[对方id].角色:取队伍信息()
			    临时数据.准备=false
			    临时数据.最后准备=false
			    if 玩家数据[对方id].连接id=="zhuzhan" then
			    	临时数据.准备=true
			    	临时数据.最后准备=true
			    end
			    临时数据.剑会数据 = 玩家数据[对方id].角色.剑会数据
			    table.insert(self.房间数据[已有房间].成员数据,临时数据)
			    self:房间列表信息刷新()
			    self:刷新我的房间(已有房间)
			end
		else
			table.remove(self.房间数据,已有房间)
			self:重置房间编号()
		    发送数据(玩家数据[id].连接id,1501,{名称="剑会主持人",模型="男人_兰虎",对话="严谨场外带人，清除剑会房间！"})
		end
	end
end

function 剑会天下:新任队长(原来id,玩家id)
	local 已有房间 = self:是否已有房间(玩家id)
	if self.房间数据[已有房间] ~= nil then
		self.房间数据[已有房间].队长id = 玩家id
		for k,v in pairs(self.房间数据[已有房间].成员数据) do
			if v.id == 玩家id then
				self.房间数据[已有房间].队长编号 = k
				break
			end
		end
		self:房间列表信息刷新()
	end
end

function 剑会天下:离开队伍(id) --剑会天下
	local 已有房间 = self:是否已有房间(id)
	if self.房间数据[已有房间] ~= nil then
		self:清除双方最后准备(id)
		if 玩家数据[id].队长 then
			self:清除战斗(id)
			table.remove(self.房间数据,已有房间)
			self:重置房间编号()
		else
			for k,v in pairs(self.房间数据[已有房间].id组) do
				if v == id then
					self:清除战斗(id)
					table.remove(self.房间数据[已有房间].id组,k)
				end
			end
			for k,v in pairs(self.房间数据[已有房间].成员数据) do
				if v.id == id then
					self:清除战斗(id)
					table.remove(self.房间数据[已有房间].成员数据,k)
				end
            end
            self.房间数据[已有房间].对方成员={}
		end
		self:房间列表信息刷新()
		self:刷新我的房间(已有房间)
    end
end

function 剑会天下:清除战斗(玩家id) --剑会天下
	if not 玩家数据[玩家id] or not 玩家数据[玩家id].角色 then
		return
	end
	local 队伍id=玩家数据[玩家id].队伍
	if 队伍id~=0 then
		for n=1,#队伍数据[队伍id].成员数据 do
			local cyid=队伍数据[队伍id].成员数据[n]
			玩家数据[cyid].遇怪时间=os.time()+取随机数(10,20)
			发送数据(玩家数据[cyid].连接id,5505)
			发送数据(玩家数据[cyid].连接id,31,玩家数据[cyid].角色:取总数据1())
			玩家数据[cyid].zhandou=0
			玩家数据[cyid].道具:重置法宝回合(cyid)
			玩家数据[cyid].角色.战斗开关=false
			地图处理类:设置战斗开关(cyid,false)
		end
		if 战斗准备类.战斗盒子[队伍id] then
			战斗准备类.战斗盒子[队伍id]=nil
		end
	else
		玩家数据[玩家id].遇怪时间=os.time()+取随机数(10,20)
		发送数据(玩家数据[玩家id].连接id,5505)
		发送数据(玩家数据[玩家id].连接id,31,玩家数据[玩家id].角色:取总数据1())
		玩家数据[玩家id].zhandou=0
		玩家数据[玩家id].道具:重置法宝回合(玩家id)
		玩家数据[玩家id].角色.战斗开关=false
		地图处理类:设置战斗开关(玩家id,false)
		if 战斗准备类.战斗盒子[玩家id] then
			战斗准备类.战斗盒子[玩家id]=nil
		end
	end
end

function 剑会天下:清除双方最后准备(id)
	local 已有房间 = self:是否已有房间(id)
	if self.房间数据[已有房间] ~= nil then
		if self.房间数据[已有房间].对方成员~=nil and self.房间数据[已有房间].对方成员[1]~=nil then
			local 对方房间 = self:是否已有房间(self.房间数据[已有房间].对方成员[1].id)
			if 对方房间 and self.房间数据[对方房间]~=nil then
				self.房间数据[对方房间].对方成员 = {}
				self.房间数据[对方房间].战斗倒计时 = false
				self.房间数据[对方房间].对手类型 = false
				if self.房间数据[对方房间].成员数据 ~= nil then
					for k,v in pairs(self.房间数据[对方房间].成员数据) do
						self.房间数据[对方房间].成员数据[k].最后准备 = false
						if 玩家数据[v.id]~=nil then
							发送数据(玩家数据[v.id].连接id,408)
						end
					end
				end
			end
		end
		self.房间数据[已有房间].对方成员 = {}
		self.房间数据[已有房间].战斗倒计时 = false
		self.房间数据[已有房间].对手类型 = false
		if self.房间数据[已有房间].成员数据 ~=nil then
			for k,v in pairs(self.房间数据[已有房间].成员数据) do
				self.房间数据[已有房间].成员数据[k].最后准备 = false
				if 玩家数据[v.id]~=nil then
					发送数据(玩家数据[v.id].连接id,408)
				end
			end
		end
	end
end

function 剑会天下:重置房间编号() --全部重置
	for k,v in pairs(self.房间数据) do
	    v.房间编号 = k
	end
end

function 剑会天下:等级段不相符(队长id,队员id)
	if self:等级取分组(队长id) ~= self:等级取分组(队员id) then
		return true
	end
	return false
end

function 剑会天下:等级取分组(id)
	local fh="精锐组"
	if 玩家数据[id] ~= nil then
		local dj = 玩家数据[id].角色.等级
		if dj >= 160  then
			fh = "天元组"
		elseif dj >= 130  then
			fh = "天启组"
		elseif dj >= 110  then
			fh = "天科组"
		elseif dj >= 90  then
			fh = "神威组"
		elseif dj >= 70  then
			fh = "勇武组"
		end
	end
	fh="天元组" --剑会天下，若全服统一分组，恢复这里，反之注释掉。要分组就注释
	return fh
end

function 剑会天下:是否已有房间(id)
	local fh=false
	for k,v in pairs(self.房间数据) do
		for n=1,#v.id组 do
			if v.id组[n]~=nil and v.id组[n]==id then
				fh=k
				break
			end
		end
	end
	return fh
end

function 剑会天下:取预发送房间(id)
	local fjsj={}
	local 分组 = self:等级取分组(id)
	local fjzs=0
	for k,v in pairs(self.房间数据) do
		if v.分组 == 分组 then
			fjsj[k] = table.copy(v)
			fjzs=fjzs+1
		end
	end
	return fjsj,fjzs
end
function 剑会天下:取我的房间(id)
	local fjsj={}
	local 已有房间 = self:是否已有房间(id)
	if self.房间数据[已有房间] ~= nil then
		fjsj = table.copy(self.房间数据[已有房间])
	end
	return fjsj
end

function 剑会天下:单独重置胜率(id)
	if 玩家数据[id].角色.剑会数据==nil then
		玩家数据[id].角色.剑会数据={总场=0,战胜=0,战败=0,胜率=50,赛季场次=0,赛季积分=1000,商店积分=0,参加赛季=0}
	end
	local zc = 玩家数据[id].角色.剑会数据.总场
	local zs = 玩家数据[id].角色.剑会数据.战胜
	if zc ~= 0 then
		玩家数据[id].角色.剑会数据.胜率 = math.floor(zs/zc*100)
	else
	    玩家数据[id].角色.剑会数据.胜率 = 50
	end
end
--============================================================剑会天下队伍处理-终
--============================================================剑会匹配处理-始
function 剑会天下:准备游戏处理(id)
	local 已有房间 = self:是否已有房间(id)
	if self.房间数据[已有房间] ~= nil then
		if id == self.房间数据[已有房间].队长id and 玩家数据[id].队长 then
			self:开始匹配处理(id)
		elseif not 玩家数据[id].队长 then
			for k,v in pairs(self.房间数据[已有房间].成员数据) do
				if v.id == id then
					v.准备 = not v.准备
					break
				end
			end
			self:刷新我的房间(已有房间)
		end
	end
end

function 剑会天下:最后准备处理(id,按钮文字)
	local 已有房间 = self:是否已有房间(id)
	local 最后准备 = false
	local 发送文字 = "准备确认"
	if 按钮文字 == "准备确认" then
		最后准备 = true
		发送文字 = "取消准备"
	end
	if self.房间数据[已有房间] ~= nil and self.房间数据[已有房间].对方成员 ~= nil then
		local 对方房间 = false
		if self.房间数据[已有房间].对方成员[1] then
			对方房间 = self:是否已有房间(self.房间数据[已有房间].对方成员[1].id)
		end
		if 对方房间 and self.房间数据[对方房间].对方成员~=nil and self.房间数据[对方房间].对方成员[1]~=nil then
			for n=1,#self.房间数据[对方房间].对方成员 do
				if self.房间数据[对方房间].对方成员[n]~=nil then --从对方那查找自己id
					if 玩家数据[id].队长 then
						self.房间数据[对方房间].对方成员[n].最后准备 = 最后准备
					elseif id == self.房间数据[对方房间].对方成员[n].id then
						self.房间数据[对方房间].对方成员[n].最后准备 = 最后准备
						break
					end
				end
			end
		end
		for n=1,#self.房间数据[已有房间].成员数据 do
			if self.房间数据[已有房间].成员数据[n]~=nil then
				if 玩家数据[id].队长 then
					self.房间数据[已有房间].成员数据[n].最后准备 = 最后准备
				elseif id == self.房间数据[已有房间].成员数据[n].id then
					self.房间数据[已有房间].成员数据[n].最后准备 = 最后准备
					break
				end
			end
		end
		发送数据(玩家数据[id].连接id,407,发送文字) --换按钮文字
	end
end

function 剑会天下:离开队列处理(id)
	local 已有房间 = self:是否已有房间(id)
	if self.房间数据[已有房间] ~= nil then
		local 分组 = self.房间数据[已有房间].分组
		for k,v in pairs(self.五人匹配[分组]) do
			if v.id == id then
				table.remove(self.五人匹配[分组],k)
			end
		end
		if self.房间数据[已有房间].对方成员~=nil and self.房间数据[已有房间].对方成员[1]~=nil then
			local 对方房间 = self:是否已有房间(self.房间数据[已有房间].对方成员[1].id)
			if 对方房间 then
				self.房间数据[对方房间].对方成员 = {}
				self.房间数据[对方房间].战斗倒计时 = false
				self.房间数据[对方房间].对手类型 = false
				for nv=1,#self.房间数据[对方房间].成员数据 do
					local 成员id = self.房间数据[对方房间].成员数据[nv].id
					if self.房间数据[对方房间].成员数据[nv]~=nil then
						self.房间数据[对方房间].成员数据[nv].最后准备 = false
					end
					if 成员id ~= nil and 玩家数据[成员id] ~= nil then
				        发送数据(玩家数据[成员id].连接id,408)
                    end
				end
			end
		end
		for n=1,#self.房间数据[已有房间].id组 do
			local 成员id = self.房间数据[已有房间].id组[n]
			if 成员id ~= nil and 玩家数据[成员id] ~= nil then
				self.房间数据[已有房间].对方成员 = {}
				self.房间数据[已有房间].战斗倒计时 = false
				self.房间数据[已有房间].对手类型 = false
				self.房间数据[已有房间].成员数据[n].最后准备 = false
				常规提示(成员id,"#W/玩家#R/" ..玩家数据[id].角色.名称 .."#W/取消准备")
				发送数据(玩家数据[成员id].连接id,405)
				发送数据(玩家数据[成员id].连接id,408)
			end
		end
    end
end

function 剑会天下:开始匹配处理(id)
    local 已有房间 = self:是否已有房间(id)
	if self.房间数据[已有房间] ~= nil then
		if 玩家数据[id].队长 then
			local 场数限制=false
			local 已准备 = 0
			for k,v in pairs(self.房间数据[已有房间].成员数据) do
				if 玩家数据[v.id].角色.剑会数据.赛季场次 >= 10 then
					场数限制=玩家数据[id].角色.名称
				end
				if 玩家数据[v.id].连接id=="zhuzhan" then
					v.准备 = true
					v.最后准备 = true
				end
				if v.id ~= id and v.准备 then
					已准备 = 已准备 + 1
				end
            end
			local 队伍id=玩家数据[id].队伍
			local 战斗中=false
			for n=1,#队伍数据[队伍id].成员数据 do
				local 队员id=队伍数据[队伍id].成员数据[n]
				if 玩家数据[队员id]==nil or 玩家数据[队员id].zhandou ~= 0 then
					战斗中=true
				end
			end
			if #队伍数据[队伍id].成员数据 < 5 then
			-- if #队伍数据[队伍id].成员数据 < 0 then --测试用
				常规提示(id,"#Y/操作失败，你的队伍少于5人")
				return
			elseif 战斗中 then
			    常规提示(id,"#Y/操作失败，有队员正在战斗中")
		        return
		    elseif 已准备 < 4 then
		    -- elseif 已准备 < 0 then --测试用
		        常规提示(id,"#Y/操作失败，有队员还没准备")
		        return
		    elseif 场数限制 then
		        常规提示(id,"#Y/操作失败，" ..场数限制 .."战斗次数达到上限!")
		        return
			end
			local crsj = {id=self.房间数据[已有房间].队长id,执行等待=os.time()}
			table.insert(self.五人匹配[self.房间数据[已有房间].分组],crsj)
			for n=1,#self.房间数据[已有房间].id组 do
				local 成员id = self.房间数据[已有房间].id组[n]
			    if 成员id ~= nil and 玩家数据[成员id] ~= nil then
					发送数据(玩家数据[成员id].连接id,404)
				end
			end
		else
		    常规提示(id,"你不是队长无权操作")
		end
	end
end

function 剑会天下:自动匹配_五人() --活动定时器循环调用
	local 组类={"精锐组","勇武组","神威组","天科组","天启组","天元组"}
	for n=1,#组类 do
		if #self.五人匹配[组类[n]] >= 1 then
			self:自动匹配_五人_计算(组类[n]) --匹配对手
		end
	end
	for k,v in pairs(self.房间数据) do --判定双方都点(最后准备)后进入战斗
		if v.对方成员 ~= nil and #v.对方成员 >= 5 and v.战斗倒计时 and v.战斗倒计时 - os.time() >= 0 then
		-- if v.对方成员 ~= nil and #v.对方成员 >= 1 and v.战斗倒计时 and v.战斗倒计时 - os.time() >= 0 then --测试用
			local 红方id,蓝方id = false
			local 我方准备=0
			local 对方准备=0
			local 记录对方id=0
			for n=1,#v.成员数据 do
				if v.成员数据[n]~=nil and v.成员数据[n].最后准备 then
					我方准备 = 我方准备 + 1
				end
			end
			for n=1,#v.对方成员 do
				if v.对方成员[n]~=nil and v.对方成员[n].最后准备 then
					记录对方id = v.对方成员[n].id
					对方准备 = 对方准备 + 1
				end
			end
			if 我方准备 >= 5 and 对方准备 >= 5 and v.对手类型 == "玩家" then
			-- if 我方准备 >= 1 and 对方准备 >= 1 and v.对手类型 == "玩家" then --测试用
				local 对方房间 = self:是否已有房间(记录对方id)
				self:清除双方最后准备(self.房间数据[k].队长id)
				红方id = self.房间数据[k].队长id
				蓝方id = self.房间数据[对方房间].队长id
				if 玩家数据[红方id]~=nil and 玩家数据[蓝方id]~=nil then
					战斗准备类:创建玩家战斗(红方id, 200014, 蓝方id, 6136)
				end
				break
			elseif 我方准备 >= 5 and v.对手类型 == "假人" then
			-- elseif 我方准备 >= 1 and v.对手类型 == "假人" then	--测试用
				红方id = self.房间数据[k].队长id
				self:清除双方最后准备(self.房间数据[k].队长id)
				if 玩家数据[红方id]~=nil then
					战斗准备类:创建战斗(红方id+0,160001)
				end
			end
		elseif v.对方成员 ~= nil and #v.对方成员 >= 1 and v.战斗倒计时 and v.战斗倒计时 - os.time() < 0 then	--否则超时
			self:清除双方最后准备(self.房间数据[k].队长id)
		end
	end
end

function 剑会天下:战斗取假人信息(id)
	local fh=false
	if self.假人[id] ~= nil then
		fh = self.假人[id]
	end
	return fh
end

function 剑会天下:自动匹配_五人_计算(分组)
	local 红方数据,蓝方数据 = false,false
	for k,v in pairs(self.五人匹配[分组]) do
		if v.id then
			if 红方数据==false then
				if os.time() - v.执行等待 > 3 then
					红方数据 = v
				end
			elseif 红方数据.id ~= v.id then
				if os.time() - v.执行等待 > 3 then
					蓝方数据 = v
				end
			end
			if 红方数据 and 蓝方数据 then
				break
			end
		end
	end
	if 红方数据 and 蓝方数据 then
		self:最后准备_五人(self.五人匹配,分组,红方数据.id,蓝方数据.id)
		self:删除匹配数据(self.五人匹配,红方数据.id,分组)
	    self:删除匹配数据(self.五人匹配,蓝方数据.id,分组)
	elseif 红方数据 and os.time() - 红方数据.执行等待 >= 取随机数(6,12) and 蓝方数据==false then
		self:最后准备_假人(self.五人匹配,分组,红方数据.id)
		self:删除匹配数据(self.五人匹配,红方数据.id,分组)
	end
	红方数据,蓝方数据 = false,false
end

function 剑会天下:删除匹配数据(匹配数据,id,分组) --匹配到了对手，就清除
	local 已有房间 = self:是否已有房间(id)
	if self.房间数据[已有房间] ~= nil then
	for n=1,#self.房间数据[已有房间].id组 do
			local 成员id = self.房间数据[已有房间].id组[n]
			if 成员id ~= nil and 玩家数据[成员id] ~= nil then
				发送数据(玩家数据[成员id].连接id,405)
			end
		end
    end
	for k,v in pairs(匹配数据[分组]) do
		if v.id == id  then
			table.remove(匹配数据[分组],k)
			break
		end
	end
end

function 剑会天下:最后准备_五人(匹配数据,分组,红方id,蓝方id)
	local 取消战斗=false
	if 玩家数据[红方id]==nil or 玩家数据[蓝方id]==nil then --预防
		取消战斗=true
	elseif 玩家数据[红方id].zhandou~=0 or 玩家数据[蓝方id].zhandou~=0 then
		取消战斗=true
	elseif 队伍数据[红方id]==nil or 队伍数据[蓝方id]==nil then
		取消战斗=true
	elseif #队伍数据[红方id].成员数据 < 5 or #队伍数据[蓝方id].成员数据 < 5 then --测试时注释
		取消战斗=true
	end
	if 取消战斗 then
		return
	end
	local 红方房间 = self:是否已有房间(红方id)
	local 蓝方房间 = self:是否已有房间(蓝方id)
	if 红方房间 and 蓝方房间 then
		self.发送数据={}
		self.房间数据[红方房间].对方成员 = {}
		self.房间数据[红方房间].对方成员 = self.房间数据[蓝方房间].成员数据
		self.房间数据[红方房间].战斗倒计时 = os.time()+120
		self.房间数据[红方房间].对手类型 = "玩家"
		self.房间数据[蓝方房间].对方成员 = {}
		self.房间数据[蓝方房间].对方成员 = self.房间数据[红方房间].成员数据
		self.房间数据[蓝方房间].战斗倒计时 = os.time()+120
		self.房间数据[蓝方房间].对手类型 = "玩家"
		for k,v in pairs(self.房间数据[红方房间].id组) do
			if 玩家数据[v] and 玩家数据[v].连接id then
				发送数据(玩家数据[v].连接id,406,table.copy(self.发送数据))
			end
		end
		for k,v in pairs(self.房间数据[蓝方房间].id组) do
			if 玩家数据[v] and 玩家数据[v].连接id then
				发送数据(玩家数据[v].连接id,406,table.copy(self.发送数据))
			end
		end
	end
end

function 剑会天下:最后准备_假人(匹配数据,分组,红方id)
	local 取消战斗=false
	if 玩家数据[红方id]==nil then --预防
		取消战斗=true
	elseif 玩家数据[红方id].zhandou~=0 then
		取消战斗=true
	elseif 队伍数据[红方id]==nil then
		取消战斗=true
	elseif #队伍数据[红方id].成员数据 < 5 then --测试时注释
		取消战斗=true
	end
	if 取消战斗 then
		return
	end
	local 红方房间 = self:是否已有房间(红方id)
	if 红方房间 then
		self.发送数据={}
		self.房间数据[红方房间].对方成员 = {}
		self.房间数据[红方房间].对方成员 = self:生成假人数据(self.房间数据[红方房间],self.房间数据[红方房间].队长id) --self.房间数据[蓝方房间].成员数据
		self.房间数据[红方房间].战斗倒计时 = os.time()+120
		self.房间数据[红方房间].对手类型 = "假人"
		for k,v in pairs(self.房间数据[红方房间].id组) do
			if 玩家数据[v] and 玩家数据[v].连接id then
				发送数据(玩家数据[v].连接id,406,table.copy(self.发送数据))
			end
		end
	end
end

function 剑会天下:生成假人数据(房间数据,队长id)
	local jr={}
	self.假人[队长id] = {}
	local 等级 = 175
	for k,v in pairs(房间数据.成员数据) do
		if v.id == 队长id then
			等级 = v.等级
		end
	end
	for n=1,5 do
		local xx={}
		等级 = math.floor(取随机数(等级*0.95,等级*1.1))
	    if 等级 > 175 then 等级 = 175 end
		xx=self:取假人信息()
		jr[n]={}
		jr[n].剑会数据 = {总场=0,战胜=0,战败=0,胜率=50,赛季场次=0,赛季积分=1000,商店积分=0,参加赛季=0}
		jr[n].名称 = xx[1]
        jr[n].模型 = xx[2]
        jr[n].等级 = 等级
        jr[n].装备 = {五行="火",总类=2,鉴定=true,耐久=550,子类=2,识别码=0,分类=3,级别限制=150}
        jr[n].装备.名称 = xx[3]
        jr[n].最后准备 = true
        jr[n].门派 = xx[4]
        jr[n].id = 0
        jr[n].锦衣 = {}
        jr[n].准备 = true
	end
	self.假人[队长id] = jr
	return jr
end

function 剑会天下:取假人信息()
	local 姓 = {"钕","天","神","南","皇","荒天","洗浴","搓澡","麻将","喝酒","金牌","鬼"}
	local 名 = {"帝"}
	local xx={} --1名称、2模型、3武器(模型取武器)、4门派
	xx[1] = 姓[取随机数(1,#姓)]..名[取随机数(1,#名)]
	xx[2] = Q_随机模型[取随机数(1,#Q_随机模型)]
	local 武器 = 取150角色武器(xx[2])
	xx[3] = 武器.武器
	xx[4] = Qu角色属性[xx[2]].门派[取随机数(1,#Qu角色属性[xx[2]].门派)]
	return xx
end

function 剑会天下:发送对方阵容(id,阵容)
	local 已有房间 = self:是否已有房间(id)
	local 房间编号=false --对方房间
	if 已有房间 then
		if 阵容 == "对方阵容" then
			for k,v in pairs(self.房间数据[已有房间].id组) do
				if 玩家数据[v] and 玩家数据[v].连接id then
					self.发送数据={}
					self.发送数据 = self.房间数据[已有房间].对方成员
					发送数据(玩家数据[v].连接id,406,table.copy(self.发送数据))
				end
			end
		else --"己方阵容"
			for k,v in pairs(self.房间数据[已有房间].id组) do
				if 玩家数据[v] and 玩家数据[v].连接id then
					self.发送数据={}
					发送数据(玩家数据[v].连接id,406,table.copy(self.发送数据))
				end
			end
		end
	end
end

function 剑会天下:PK胜利处理(胜利组,失败组)
	local 分差值 = self:取积分差异(胜利组,失败组)
	if 胜利组 and type(胜利组)=="table" then
		for k,v in pairs(胜利组) do
			local id = v
			if 玩家数据[id] ~= nil then
				玩家数据[id].角色.剑会数据.赛季场次 = 玩家数据[id].角色.剑会数据.赛季场次 + 1
				玩家数据[id].角色.剑会数据.总场 = 玩家数据[id].角色.剑会数据.总场 + 1
				玩家数据[id].角色.剑会数据.战胜 = 玩家数据[id].角色.剑会数据.战胜 + 1
				玩家数据[id].角色.剑会数据.赛季积分 = 玩家数据[id].角色.剑会数据.赛季积分 + 分差值[1]
				玩家数据[id].角色:添加经验(self.胜利经验,"剑会天下",1)
		        玩家数据[id].角色:添加银子(self.胜利银子,"剑会天下",1)
				self:单独重置胜率(id)
				发送数据(玩家数据[id].连接id,408)
				常规提示(id,"战斗胜利，获得排名积分" ..分差值[1])
			end
			--不写打完3次传送出去了，因为有的队可能有的队员没打完3次，因为组队的时候，只能传送走全队！已经有判定队里有人打了3次就不能匹配
			if not self.活动开关 then
				self:踢出地图(id)
			end
		end
	end
	if 失败组 and type(失败组)=="table" then
		for k,v in pairs(失败组) do
			local id = v
			if 玩家数据[id] ~= nil then
				玩家数据[id].角色.剑会数据.赛季场次 = 玩家数据[id].角色.剑会数据.赛季场次 + 1
				玩家数据[id].角色.剑会数据.总场 = 玩家数据[id].角色.剑会数据.总场 + 1
				玩家数据[id].角色.剑会数据.战败 = 玩家数据[id].角色.剑会数据.战败 + 1
				玩家数据[id].角色.剑会数据.赛季积分 = 玩家数据[id].角色.剑会数据.赛季积分 + 分差值[2]
				玩家数据[id].角色:添加经验(self.失败经验,"剑会天下",1)
		        玩家数据[id].角色:添加银子(self.失败银子,"剑会天下",1)
				self:单独重置胜率(id)
				发送数据(玩家数据[id].连接id,408)
				常规提示(id,"战斗失败，获得排名积分" ..分差值[2])
			end
			if not self.活动开关 then
				self:踢出地图(id)
			end
		end
	end
	self:更新剑会排行()
end

function 剑会天下:假人胜利处理(id组,战斗类型,任务id)
	local 奖励积分 = 取随机数(self.战胜假人积分.a,self.战胜假人积分.b)
	if type(id组) == "table" then
		for n=1,#id组 do
			local id = id组[n]
			if 玩家数据[id] ~= nil then
				玩家数据[id].角色.剑会数据.赛季场次 = 玩家数据[id].角色.剑会数据.赛季场次 + 1
				玩家数据[id].角色.剑会数据.总场 = 玩家数据[id].角色.剑会数据.总场 + 1
				玩家数据[id].角色.剑会数据.战胜 = 玩家数据[id].角色.剑会数据.战胜 + 1
				玩家数据[id].角色.剑会数据.赛季积分 = 玩家数据[id].角色.剑会数据.赛季积分 + 奖励积分
				玩家数据[id].角色:添加经验(self.胜利经验,"剑会天下",1)
		        玩家数据[id].角色:添加银子(self.胜利银子,"剑会天下",1)
				self:单独重置胜率(id)
				发送数据(玩家数据[id].连接id,408)
				常规提示(id,"战斗胜利，获得排名积分" ..奖励积分)
				if not self.活动开关 then
				self:踢出地图(id)
				end
			end
		end
		self:更新剑会排行()
	end
end

function 剑会天下:取积分差异(胜利组,失败组)
	local 胜利组总分 = 0
	local 胜利组平均分 = 0
	local 胜利组人数 = 0
	local 失败组总分 = 0
	local 失败组平均分 = 0
	local 失败组人数 = 0
	local 分差值 = 0
	local 胜利基础分 = 40
    local 失败基础分 = 12
	if 胜利组 and type(胜利组)=="table" then
		for k,v in pairs(胜利组) do
			local id = v
			if 玩家数据[id] ~= nil then
				if 玩家数据[id].角色.剑会数据==nil then
					玩家数据[id].角色.剑会数据={总场=0,战胜=0,战败=0,胜率=50,赛季场次=0,赛季积分=1000,商店积分=0,参加赛季=0}
				end
				胜利组总分 = 胜利组总分 + 玩家数据[id].角色.剑会数据.赛季积分
				胜利组人数 = 胜利组人数 + 1
			end
		end
		胜利组平均分 = math.floor(胜利组总分/胜利组人数)
	end
	if 失败组 and type(失败组)=="table" then
		for k,v in pairs(失败组) do
			local id = v
			if 玩家数据[id] ~= nil then
				if 玩家数据[id].角色.剑会数据==nil then
					玩家数据[id].角色.剑会数据={总场=0,战胜=0,战败=0,胜率=50,赛季场次=0,赛季积分=1000,商店积分=0,参加赛季=0}
				end
				失败组总分 = 失败组总分 + 玩家数据[id].角色.剑会数据.赛季积分
				失败组人数 = 失败组人数 + 1
			end
		end
		失败组平均分 = math.floor(失败组总分/失败组人数)
	end
	分差值 = 胜利组平均分 - 失败组平均分
	if 分差值<0 then  --低分打赢高分的情况下
		if math.abs(分差值) >100 then
            local 增加值 = math.floor(math.abs(分差值)/100) * 2
            if 增加值 >= 10 then
                增加值 = 10
            end
            胜利基础分 = 胜利基础分 + 增加值
            失败基础分 = 失败基础分 + 增加值
        end
	else --高分打赢低分的情况下
		if math.abs(分差值) >100 then
            local 增加值 = math.floor(math.abs(分差值)/100) * 2
            if 增加值 >= 10 then
                增加值 = 10
            end
            胜利基础分 = 胜利基础分 - 增加值
            失败基础分 = 失败基础分 - 增加值
        end
	end
	return {胜利基础分,失败基础分}
end

function 剑会天下:更新剑会排行()
	self.剑会排行={天元组={},天启组={},天科组={},神威组={},勇武组={},精锐组={}}
	local 组类={"精锐组","勇武组","神威组","天科组","天启组","天元组"}
	local 临时记录={天元组={},天启组={},天科组={},神威组={},勇武组={},精锐组={}}
	for id,v in pairs(玩家数据) do
		if 玩家数据[id]~=nil and 玩家数据[id].角色.剑会数据~=nil then
			local 分组 = self:等级取分组(id)
			if 临时记录[分组]~=nil then
				local crsj={}
				crsj.名称 = 玩家数据[id].角色.名称
				crsj.门派 = 玩家数据[id].角色.门派
				crsj.id = id
				crsj.积分 = 玩家数据[id].角色.剑会数据.赛季积分
				crsj.胜率 = 玩家数据[id].角色.剑会数据.胜率
				table.insert(临时记录[分组],crsj)
			end
		end
	end
	for n=1,#组类 do
		if type(临时记录[组类[n]])=="table" then
			table.sort(临时记录[组类[n]],function(a,b) return a.积分>b.积分 end)
			self.剑会排行[组类[n]] = table.copy(临时记录[组类[n]])
		end
	end
end

function 剑会天下:取剑会排行榜()
    return self.剑会排行
end
--============================================================剑会天下匹配处理-终

function 剑会天下:取剑会NPC(名称)
	local npc={"华山接引人","战备管理员","剑会主持人","剑会星君"} --剑会:对话事件处理里的NPC名字都要加到这里面来
	local fh=false
	for k,v in pairs(npc) do
		if 名称==v then
			fh=true
			break
		end
	end
	return fh
end

return 剑会天下