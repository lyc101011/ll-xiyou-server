-- @Author: baidwwy
-- @Date:   2024-04-14 22:24:24
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-09 13:22:58
local 剑会 = class()
local function 积分排序(a,b) return a.积分<b.积分 end
local qz=math.floor
function 剑会:初始化()
	self.活动开关=false
	self.正式开始=false
	self.活动时间=QJHDSJ["剑会"]
	self.开始Time=0
	self.正式Time=0
	self.匹配时间={}
	self.匹配时间["10"]=1
	self.匹配时间["30"]=1
	self.匹配时间["50"]=1
	地图处理类.地图数据[2013]={npc={},单位={},传送圈={}}  --剑会天下
	地图处理类.地图玩家[2013]={}
	地图处理类.地图坐标[2013]=地图处理类.地图坐标[1207]
	地图处理类.地图单位[2013]={}
	地图处理类.单位编号[2013]=1000
	self.单挑={}
	self.jifenban={}
	if f函数.文件是否存在([[sql/剑会天下.txt]])==false then
		写出文件([[sql/剑会天下.txt]],table.tostring({}))
	else
		self.jifenban=table.loadstring(读入文件([[sql/剑会天下.txt]]))
	end
	-- if 调试模式 then
	--     self.活动开关=true
	-- 	self.正式开始=true
	-- 	self.匹配时间["14"]=1
	-- 	self.匹配时间["25"]=1
	-- 	self.匹配时间["35"]=1
	-- 	self.匹配时间["45"]=1
	-- 	for i=1,30 do
	-- 		self.jifenban[i]={积分=1000+i,胜利=1,失败=1,名称="名称"..i,门派="门派"..i,等级=60+i}
	-- 	end
	-- end

end

function 剑会:活动定时器()
	if self.活动开关 then
		if self.开始Time-os.time()>0 then
			if self.正式开始 then
				if self.匹配时间[服务端参数.秒] then
					self:单挑匹配处理()
				end
			else
				if os.time()>=self.正式Time then
					self.正式开始=true
					广播消息({内容="#R《剑会天下·单挑赛》#G正式开始，还等什么！数风流人物，还看今朝！",频道="xt"})
					发送公告("#R《剑会天下·单挑赛》#G正式开始，还等什么！数风流人物，还看今朝！")
				end
			end
		else
			self:关闭活动()
		end
	else
		if self.活动时间.日期=="每天" then
			if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
				self:开启活动()
			end
		else
			local zhouji=tonumber(os.date("%w", os.time()))
			if zhouji==self.活动时间.日期 then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
					self:开启活动()
				end
			elseif self.活动时间.日期=="周135" and (zhouji==1 or zhouji==3 or zhouji==5) then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
					self:开启活动()
				end
			elseif self.活动时间.日期=="周246" and (zhouji==2 or zhouji==4 or zhouji==6) then
				if self.活动时间.时==服务端参数.小时+0 and self.活动时间.分==服务端参数.分钟+0 and self.活动时间.秒<=服务端参数.秒+0  then
					self:开启活动()
				end
			end
		end
	end
end

function 剑会:开启活动()
	self.模式="单挑"
	self.正式开始=false
	self.开始Time=os.time()+3600 --前十分钟是准备时间
	self.正式Time=os.time()+5--开启后5秒正式PK
	self.活动开关=true
	self.单挑={}
	广播消息({内容="#R《剑会天下·单挑赛》#G活动开启，三界之中，谁是英豪！凡三界之侠士，俱可前往其中一试身手。#Y（长安欧冶子之灵142，177处）",频道="xt"})
	发送公告("#R《剑会天下·单挑赛》#G活动开启，三界之中，谁是英豪！凡三界之侠士，俱可前往其中一试身手。（长安欧冶子之灵142，177处）")
end

function 剑会:关闭活动()
	self.活动开关=false
	self.开始Time=nil
	self.正式Time=nil
	self.单挑={}
	写出文件([[sql/剑会天下.txt]],table.tostring(self.jifenban))
	print("写出剑会天下数据成功！")
	广播消息({内容="#S《剑会天下·单挑赛》#R此次活动结束，还处于战斗中的玩家仍可获得奖励。",频道="xt"})
	发送公告("#S《剑会天下·单挑赛》#R此次活动结束，还处于战斗中的玩家仍可获得奖励。")
end


function 剑会:单挑匹配处理()
	if not self.单挑[2] then
		return
	end
	table.sort(self.单挑,积分排序) --排序一次积分，让排到的人变得有规律
	for n,v in pairs(self.单挑) do
		if 玩家数据[v.id] ~= nil and v.匹配 and 玩家数据[v.id].zhandou==0 and 玩家数据[v.id].guanzhan == 0 then
			local 红方玩家id = v.id
			v.匹配=false
			local 蓝方玩家id = 0
			if self.单挑[n+1] then
				蓝方玩家id=self.单挑[n+1].id or 0
				self.单挑[n+1].匹配=false
			end
			if 玩家数据[红方玩家id] and 玩家数据[蓝方玩家id] and 红方玩家id~=蓝方玩家id then
				local 玩家表 = {[1]=红方玩家id,[2]=蓝方玩家id}
				for i=1,#玩家表 do
					发送数据(玩家数据[玩家表[i]].连接id,6581)
					常规提示(玩家表[i],"#G/你进入了单挑战斗")
				end
				战斗准备类:创建玩家战斗(红方玩家id, 200004, 蓝方玩家id, 2013, "单挑")
			end
		end
	end
	self.单挑={}
end


function 剑会:发起匹配请求(id,内容) --发送数据过来然后进行判断
	--判断开启模式，和匹配模式
	local 模式 = 内容.模式
	if self.活动开关 then
		if 剑会单挑[id]<=0 then 常规提示(id,"#Y/每日限制20次PK。") return end
		if self.正式开始 then
			if 取队伍人数(id)==1 then
				if 玩家数据[id].角色.门派=="无门派" or 玩家数据[id].角色.等级<55 then
					常规提示(id,"#Y/少侠你没有门派，或者等级未达到55级。")
					return
				end
				if not self.jifenban[id] then
					self.jifenban[id]={积分=1000,胜利=0,失败=0,名称=玩家数据[id].角色.名称,门派=玩家数据[id].角色.门派,等级=玩家数据[id].角色.等级}
				end
				self.单挑[#self.单挑+1]={匹配=true,id=id,积分=self.jifenban[id].积分+玩家数据[id].角色.等级*10}--玩家数据[id].角色.等级*20
				发送数据(玩家数据[id].连接id,6580,{人数=内容.人数,模式=模式})
				剑会单挑[id]=剑会单挑[id] - 1
			end
		else
			常规提示(id,"#Y/当前处于准备阶段，暂时不能匹配。")
		end
	else
		常规提示(id,"#Y/当前不是活动时间")
	end
end

function 剑会:取消匹配(id,内容) --发送数据过来然后进行判断
	--判断开启模式，和匹配模式
	local 模式 = 内容.模式
	for n,v in pairs(self.单挑) do
		if v.id == id and  玩家数据[v.id] and 玩家数据[v.id].zhandou==0 and 玩家数据[v.id].guanzhan == 0 then
			table.remove(self.单挑,n)
			break
		end
	end
	发送数据(玩家数据[id].连接id,6581)
	常规提示(id,"#Y/你已经取消了匹配！")
end

function 剑会:重新匹配(id,内容)
	if self.活动开关 and self.正式开始 then
		for n,v in pairs(self.单挑) do
			if v.id == id and 玩家数据[v.id] and 玩家数据[v.id].zhandou==0 and 玩家数据[v.id].guanzhan == 0 then
				table.remove(self.单挑,n)
				if not self.jifenban[id] then
					self.jifenban[id]={积分=1000,胜利=0,失败=0,名称=玩家数据[id].角色.名称,门派=玩家数据[id].角色.门派,等级=玩家数据[id].角色.等级}
				end
				self.单挑[#self.单挑+1]={匹配=true,id=id,积分=self.jifenban[id].积分+玩家数据[id].角色.等级*10}
				break
			end
		end
	end
end

function 剑会:PK胜利处理(胜利组,失败组)
	if 胜利组 and 失败组 and self.jifenban[胜利组[1]] and self.jifenban[失败组[1]] then
		local 分差值 = self.jifenban[胜利组[1]].积分 - self.jifenban[失败组[1]].积分
		local 保底=取随机数(4,8)
		local 加分,扣分
		if 分差值>=0 then --胜利方的分比失败方高
			加分=qz(分差值/10)+保底
			扣分=qz(分差值/15)+保底
		else--反杀
			local 额外分 = math.floor(math.abs(分差值)/10) * 2
			保底=取随机数(8,12)
			加分=保底+额外分
			扣分=保底+额外分
		end
		if 加分>85 then
			加分=取随机数(85,110)
		elseif 扣分>70 then
			扣分=取随机数(70,90)
		end
		self.jifenban[胜利组[1]].积分=self.jifenban[胜利组[1]].积分 +加分
		self.jifenban[失败组[1]].积分=self.jifenban[失败组[1]].积分 -扣分
		if self.jifenban[失败组[1]].积分<=0 then
			self.jifenban[失败组[1]].积分=0
		end
		self.jifenban[胜利组[1]].胜利=self.jifenban[胜利组[1]].胜利+1
		self.jifenban[失败组[1]].失败=self.jifenban[失败组[1]].失败+1
		常规提示(胜利组[1],"你的单挑积分#G上升了"..加分.."点#Y。")
		常规提示(胜利组[1],"恭喜你获得了本场战斗的胜利。")
		常规提示(失败组[1],"你的单挑积分#R减少了"..扣分.."点#Y。")
		发送数据(玩家数据[胜利组[1]].连接id,6584,self.jifenban[胜利组[1]])
		发送数据(玩家数据[失败组[1]].连接id,6584,self.jifenban[失败组[1]])
		if 取随机数()<=HDPZ["剑会：胜利"].爆率 then
			local 胜利id=胜利组[1]
			local 链接 = {提示=format("#Y剑出龙吟，武动风雷！一场酣畅淋漓的战斗后#G%s#Y获得一个",玩家数据[胜利id].角色.名称),频道="hd",结尾="#Y。"}
			local 名称,数量,参数=生成产出(产出物品计算(HDPZ["剑会：胜利"].ITEM),"剑会：胜利")
			if 数量== 9999 then --环
				玩家数据[胜利id].道具:给予道具(胜利id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
			else
				玩家数据[胜利id].道具:给予超链接道具(胜利id,名称,数量,参数,链接)
			end
		end
		if 取随机数()<=HDPZ["剑会：失败"].爆率 then
			local 失败id=胜利组[1]
			local 链接 = {提示=format("#Y剑会天下，以武会友！一场酣畅淋漓的战斗后#G%s#Y获得一个",玩家数据[失败id].角色.名称),频道="hd",结尾="#Y。"}
			local 名称,数量,参数=生成产出(产出物品计算(HDPZ["剑会：失败"].ITEM),"剑会：失败")
			if 数量== 9999 then --环
				玩家数据[失败id].道具:给予道具(失败id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
			else
				玩家数据[失败id].道具:给予超链接道具(失败id,名称,数量,参数,链接)
			end
		end
	end
end


function 剑会:对话事件处理(id,名称,事件)
	if 名称=="欧冶子之灵" or 名称=="欧冶子" then
		if 事件=="我要参加剑会天下" then
			添加最后对话(id,"请问，少侠要前往参加哪种剑会天下游戏模式：",{"剑会天下（团队模式）","剑会天下（单挑模式）"})
		elseif 事件=="剑会天下（单挑模式）" then
			if 剑会单挑[id]==nil then 剑会单挑[id]=20 end
			if not self.活动开关 then
				添加最后对话(id,"当前不是活动时间")
				return
			elseif 玩家数据[id].队伍~=0 then
				添加最后对话(id,"单挑模式不允许组队")
				return
			elseif 玩家数据[id].角色.等级<55 then
				添加最后对话(id,"剑会天下参与条件：≥55级，人气≥500且阴德≥300，无需报名")
			end
			常规提示(id,"正在处理您的传档请求，请不要进行其他操作。")
			地图处理类:跳转地图(id,2013,135,81)
		elseif 事件=="剑会天下（团队模式）" then
			剑会天下:对话事件处理(id,"华山接引人",事件)
			-- 添加最后对话(id,"这个模式还在开发中……")

		elseif 事件=="查看团队排行榜" then
        	local 临时排行 = 剑会天下:取剑会排行榜()
            发送数据(玩家数据[id].连接id,409,table.copy(临时排行))

        elseif 事件=="查看单挑排行榜" then
			self:剑会排行榜(id)
		elseif 事件=="了解剑会天下" then
			添加最后对话(id,"少侠要前了解哪种剑会天下游戏模式：",{"团队模式","单挑模式"})
		elseif 事件=="团队模式" then
			添加最后对话(id,"团队模式中，仅允许5人组队战斗，请进场后按照规则组满队员进行匹配。准备时间结束后后，可前往房间内管事处可进行系统匹配战斗。")
		elseif 事件=="单挑模式" then
			添加最后对话(id,"于太上老君处习得#Y“单挑诀”#W的玩家可与各门派精英展开一对一的对决，对决中可#Y召唤最多4个#W召唤兽同时在场。\n#Y活动开始后，进场自行进行系统匹配战斗。")

		elseif 事件=="兑换奖励（单挑）" then
			添加最后对话(id,"单挑模式奖励为称谓，满足相应积分可在单挑排行榜页面领取称谓。")
		elseif 事件=="兑换奖励（团队）" then
			剑会天下:对话事件处理(id,"华山接引人",事件)

		elseif 事件=="剑会天下（单挑模式）紅" then
			if not self.活动开关 then
				添加最后对话(id,"当前不是活动时间")
				return
			elseif 玩家数据[id].队伍~=0 then
				添加最后对话(id,"单挑模式不允许组队")
				return
			elseif 玩家数据[id].角色.等级<55 then
				添加最后对话(id,"剑会天下参与条件：≥55级，人气≥500且阴德≥300，无需报名")
			end
			if not self.jifenban[id] then
				self.jifenban[id]={积分=1000,胜利=0,失败=0,名称=玩家数据[id].角色.名称,门派=玩家数据[id].角色.门派,等级=玩家数据[id].角色.等级}
			end
			发送数据(玩家数据[id].连接id,6583, self.jifenban[id])

		end
	elseif 名称=="活动属性设置" then
		if not self.活动开关 then
			添加最后对话(id,"当前不是活动时间")
			return
		end
		if 事件=="战斗物品设置" then
			玩家数据[id].商品列表=商店处理类.商品列表[53]
			发送数据(玩家数据[id].连接id,9,{商品=商店处理类.商品列表[53],银子=玩家数据[id].角色.银子})
		elseif 事件=="变身效果设置" then
			添加最后对话(id,"该功能暂不开放")
		elseif 事件=="领取天赋符" then
			玩家数据[id].道具:给予道具(id,"天赋符",nil,nil,nil,"专用")
		end
	end
end

function 剑会:剑会排行榜(id)
	local 名单={剑会={},季度={}}
	for b, v in pairs(self.jifenban) do
		local sl="100%"
		if v.失败~=0 then
			sl=(string.format("%.2f", v.胜利/(v.失败+v.胜利))*100).."%"
		end
		名单.剑会[#名单.剑会+1]={id=b,名称=v.名称,门派=v.门派,等级=v.等级,积分=v.积分,胜率=sl}
	end
	table.sort(名单.剑会,function(a,b) return a.积分>b.积分 end )
	for i=41,#名单.剑会 do
		if 名单.剑会[i]~=nil then
			名单.剑会[i] = nil
		end
	end
	-- if 剑会赛季.排行~=nil then
	-- 	名单.季度 = 剑会赛季.排行
	-- end
	发送数据(玩家数据[id].连接id,6586,名单)
end

function 剑会:计算积分称谓(id)
	local qwe
	if self.jifenban[id].积分>=1000 and self.jifenban[id].积分<1300 then
		qwe="剑会天下·新秀"
	elseif self.jifenban[id].积分>=1300 and self.jifenban[id].积分<1400 then
		qwe="剑会天下·百胜"
	elseif self.jifenban[id].积分>=1400 and self.jifenban[id].积分<1500 then
		qwe="剑会天下·千胜"
	elseif self.jifenban[id].积分>=1500 and self.jifenban[id].积分<1900 then
		qwe="剑会天下·万军"
	elseif self.jifenban[id].积分>=1900 then
		qwe="剑会天下·神话"
	end
	return qwe
end

function 剑会:领取称谓(id)
	if self.jifenban[id] then
		local cw=self:计算积分称谓(id)
		if cw~=nil then
			if self.jifenban[id].领取 then
				if cw==self.jifenban[id].领取.称谓 then
					添加最后对话(id,"少侠没有称谓奖励可以领取，或已经领取过了。当前积分：#R"..self.jifenban[id].积分.."分#Y \n剑会天下·新秀：1000-1299分\n剑会天下·百战：1300-1399分\n剑会天下·千胜：1400-1499分\n剑会天下·万军：1500-1899分\n剑会天下·神话：≥1900分")
					return
				end
				玩家数据[id].角色:删除称谓(self.jifenban[id].领取.称谓)
				玩家数据[id].角色:添加称谓(cw)
				添加最后对话(id,"恭喜少侠获得#G"..cw.."#W称谓。")
			else
				self.jifenban[id].领取={}
				self.jifenban[id].领取.称谓=cw
				玩家数据[id].角色:添加称谓(cw)
				添加最后对话(id,"恭喜少侠获得#G"..cw.."#W称谓。")
			end
		else
			添加最后对话(id,"#Y以少侠#R"..self.jifenban[id].积分.."的单挑积分#Y，还没有称谓奖励可以领取。\n剑会天下·新秀：1000-1299分\n剑会天下·百战：1300-1399分\n剑会天下·千胜：1400-1499分\n剑会天下·万军：1500-1899分\n剑会天下·神话：≥1900分")
		end
	end
end

return 剑会