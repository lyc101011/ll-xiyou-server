-- @Author: baidwwy
-- @Date:   2024-08-21 11:47:38
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-01-09 21:51:10
local wstjstime=0 --武神坛
function 整秒处理(时间)
  if 服务端参数.秒=="00" or 服务端参数.秒=="15" or 服务端参数.秒=="30" or 服务端参数.秒=="45" or 服务端参数.秒=="59" then
	  for i,v in pairs(玩家数据) do
				if 玩家数据[i] and 玩家数据[i].角色.自动遇怪 then
						if  地图处理类:遇怪条件检测(玩家数据[i].角色.地图数据.编号,i) then
							战斗准备类:创建战斗(i,100001,0)
						end
		   end
	 end
	end

	if 服务端参数.秒%10==0 then
		for i,v in pairs(玩家数据) do
			if 玩家数据[i] then
				玩家数据[i].保持在线=(玩家数据[i].保持在线 or 0)+10
			end
		end
	end


	if 服务端参数.小时 ~= 0 and 服务端参数.分钟 ~= 0 and 活动次数.日期 ~= os.date("%m月%d日") then
		刷新每日()
	end

	if 服务端参数.秒=="00" and 服务端参数.小时=="00" and 服务端参数.分钟=="00"then
		------------------抽奖
							奖池抽奖类:更新奖池数据()
					常规提示(id,"刷新奖池数据成功")
		-- if tonumber(os.date("%w", os.time()))==1 then------------------每周刷新
		-- 	奖池抽奖类:更新奖池数据()
		-- end
		------------------
    藏宝阁更新()
		押镖:重置数据()
		for k, v in pairs(玩家数据) do
			每日任务[k]={日常任务={},副本任务={},挑战竞技={},节日活动={},活跃度={当前=0,总活跃=0},签到数据={}}
		end
		重置数据()
		采矿活动={}
		发送公告("#G美好的一天从这一秒开始，游戏对应的活动任务数据已经刷新，合理安排时间，注意休息。")
		for n, v in pairs(任务数据) do
			if v.副本重置 then
				if 任务数据[n].地图编号 and 任务数据[n].单位编号 then
					地图处理类:删除单位(任务数据[n].地图编号,任务数据[n].单位编号)
				end
				任务数据[n]=nil
			end
		end
		雁塔地宫:每日下调()
		if tonumber(os.date("%w", os.time()))==0 then
			  通天塔重置记录={}
		    雁塔地宫:每周归零()
		end
	elseif 服务端参数.秒=="05" or 服务端参数.秒=="15" or 服务端参数.秒=="25" or 服务端参数.秒=="35" or 服务端参数.秒=="45" or 服务端参数.秒=="55" then --武神坛
		for kk,vv in pairs(玩家数据) do
			if 玩家数据[kk]~=nil and 玩家数据[kk].角色~=nil and 玩家数据[kk].角色.地图数据~=nil then
				if 玩家数据[kk].角色.武神坛角色 then
					if 玩家数据[kk].角色.地图数据.编号 ~= 6227 then
						发送数据(玩家数据[kk].连接id, 998, "武神坛角色不可出现在武神坛地图外面!")
					end
				else
				  if 玩家数据[kk].角色.地图数据.编号 == 6227 then
						if 玩家数据[kk].队伍~=0 then
							队伍处理类:退出队伍(kk)
						end
						local xy=地图处理类.地图坐标[1001]:取随机点()
						地图处理类:跳转地图(kk,1001, xy.x, xy.y)
						消息提示(kk,"#Y非武神坛角色#R不可进入#G武神坛地图!")
						常规提示(kk,"#Y非武神坛角色#R不可进入#G武神坛地图!")
					end
				end
			end
		end
	end

	if 服务器关闭 ~= nil and 服务器关闭.开关 then
		服务器关闭.计时=服务器关闭.计时-1
		__S服务:输出("服务器关闭倒计时："..服务器关闭.计时)
		广播消息({内容="#R/服务器关闭倒计时："..服务器关闭.计时,频道="xt"})
		if 服务器关闭.计时<=120 and 服务器关闭.计时>0 then
			广播消息({内容="#Y/服务器将在#R/"..服务器关闭.计时.."#Y/秒后关闭,请所有玩家立即下线，请勿在副本地图下线。",频道="xt"})
		elseif 服务器关闭.计时<=1 then
			自动关闭服务器()
			return
		end
	end

	if 小龟赛跑.次数3 == 3 and 小龟赛跑.开关==true then
		local 结算目标 = nil
		if 小龟赛跑.第一名 == 1 then
			结算目标 = "小龟村一郎"
		elseif 小龟赛跑.第一名 == 2 then
			结算目标 = "小龟蹦二郎"
		elseif 小龟赛跑.第一名 == 3 then
			结算目标 = "小龟驰三郎"
		end
		广播消息({内容="#G/本次小龟赛跑第一名的小龟是#R/"..结算目标.."#G/希望其他小龟不要气馁继续加油",频道="xt"})
		for k,v in pairs(小龟赛跑[结算目标]) do
		 	玩家数据[k].角色:添加银子(20000*小龟赛跑[结算目标][k].下注,"小龟赛跑",1)
		end
		小龟赛跑={开关=false,开始比赛=false,起始=os.time(),次数=0,次数2=0,次数3=0,小龟村一郎={},小龟蹦二郎={},小龟驰三郎={},第一名=0,随机事件={"休息","雷劈"},结束=20}
	end

	if os.date("%X", os.time())==os.date("%H", os.time())..":00:00" then
	    整点处理(os.date("%H", os.time()))
	end
end

function 整点处理(时刻)
	帮派处理:维护处理()
	假人事件类:刷新摊位()-------整点刷新摊位物品
end

function 活动检查()
	for i=1,#活动列表 do
		if 活动列表[i] and 活动列表[i].星期 == "全天" then
			if 活动列表[i].开启方式 == "间隔" then
				if 活动列表[i].刷新 == nil then
					活动列表[i].刷新 = os.time()
					if type(活动列表[i].脚本) == "table" then
						for o=1,#活动列表[i].脚本 do
							local fun = _G[活动列表[i].脚本[o]]
							if fun ~= nil  then
								 fun()
							end
						end
					else
				    	local fun = _G[活动列表[i].脚本]
						if fun ~= nil  then
							fun()
						end
					end
				end
				if os.time() >= 活动列表[i].刷新+活动列表[i].分 then
					if 活动列表[i].名称 == "珍品" then
						商店处理类:刷新珍品()
					else
						if type(活动列表[i].脚本) == "table" then
							for o=1,#活动列表[i].脚本 do
								local fun = _G[活动列表[i].脚本[o]]
								if fun ~= nil  then
									 fun()
								end
							end
						else
						    local fun = _G[活动列表[i].脚本]
							if fun ~= nil  then
								fun()
							end
						end
					end
					活动列表[i].刷新 = os.time()
				end
			elseif 活动列表[i].开启方式 == "分" then
				if 活动列表[i].分 == 服务端参数.分钟+0 and 服务端参数.秒+0 ==0 then
					if 活动列表[i].名称 == "青铜矿石" then
						设置任务2031()
					elseif 活动列表[i].名称 == "白银矿石" then
						设置任务2032()
					elseif 活动列表[i].名称 == "翡翠矿石" then
						设置任务2033()
					elseif 活动列表[i].名称 == "黄金矿石" then
						设置任务2034()
					elseif 活动列表[i].名称 == "紫金矿石" then
						设置任务2035()
					elseif 活动列表[i].名称 == "知了大王" then
						自写活动:知了大王()
					elseif 活动列表[i].名称 == "知了统领" then
						自写活动:知了统领()
					elseif 活动列表[i].名称 == "千年知了王" then
						自写活动:千年知了王()
					elseif 活动列表[i].名称 == "知了小王" then
						自写活动:知了小王()
					elseif 活动列表[i].名称 == "世界boss" then
						自写活动:世界boss(id)
					elseif 活动列表[i].名称 == "裂风兽" then
						自写活动:裂风兽()
							else
					if type(活动列表[i].脚本) == "table" then
						for o=1,#活动列表[i].脚本 do
							local fun = _G[活动列表[i].脚本[o]]
							if fun ~= nil  then
								 fun()
							end
						end
					else
				    	local fun = _G[活动列表[i].脚本]
						if fun ~= nil  then
							 fun()
						end
					end
				end
			end

			elseif 活动列表[i].开启方式 == "时" then
				if type(活动列表[i].时) == "table" then
					for o=1,#活动列表[i].时 do
						if 服务端参数.小时+0 == 活动列表[i].时[o] and 活动列表[i].分 == 服务端参数.分钟+0 and 服务端参数.秒+0 ==0 then
							if type(活动列表[i].脚本) == "table" then
								for o=1,#活动列表[i].脚本 do
									local fun = _G[活动列表[i].脚本[o]]
									if fun ~= nil  then
										 fun()
									end
								end
							    else
							    	local fun = _G[活动列表[i].脚本]
								if fun ~= nil  then
									 fun()
								end
							end
						end
					end
				else
					if 服务端参数.小时+0 == 活动列表[i].时 and 活动列表[i].分 == 服务端参数.分钟+0 and 服务端参数.秒+0 ==0 then
						if type(活动列表[i].脚本) == "table" then
							for o=1,#活动列表[i].脚本 do
								local fun = _G[活动列表[i].脚本[o]]
								if fun ~= nil  then
									 fun()
								end
							end
						    else
						    	local fun = _G[活动列表[i].脚本]
							if fun ~= nil  then
								 fun()
							end
						end
					end
				end
			end
		else
			if 活动列表[i] and os.date("%a",os.time()) == 活动列表[i].星期 and 服务端参数.小时+0 == 活动列表[i].时 and 活动列表[i].分 == 服务端参数.分钟+0 and 服务端参数.秒+0 ==0  then
				if 活动列表[i].名称 == "科举" and not 科举.开关 then
					-- 科举.开关=true
					-- 科举.起始=os.time()
					-- 广播消息({内容="#G/科举活动已经开启，各位玩家可以前往长安城#R/礼部侍郎#G/处领取战报。",频道="xt"})
				-- elseif 活动列表[i].名称 == "军阵威仪" and not 军阵威仪.开关  then
				-- 	军阵威仪.开关=true
				-- 	军阵威仪.起始=os.time()
				-- 	广播消息({内容="#G军阵威仪活动已经开启，各位玩家可以前往长安城#R/礼部尚书#G/处领取战报。",频道="xt"})
				-- elseif 活动列表[i].名称 == "月影觅仙踪（奔月）" and not 月影觅仙踪（奔月）.开关 then
				-- 	月影觅仙踪（奔月）.开关=true
				-- 	月影觅仙踪（奔月）.起始=os.time()
				-- 	广播消息({内容="#G/月影觅仙踪（奔月）活动已经开启，各位玩家可以前往长安城#R/婵娟#G/处领取战报。",频道="xt"})

				else
					if type(活动列表[i].脚本) == "table" then
						for o=1,#活动列表[i].脚本 do
							local fun = _G[活动列表[i].脚本[o]]
							if fun ~= nil  then
								 fun()
							end
						end
					     else
					    	local fun = _G[活动列表[i].脚本]
						if fun ~= nil  then
							 fun()
						end
					end
				end
			end
		end
	end
end

function 自动关闭服务器()
  for n, v in pairs(玩家数据) do
    if 玩家数据[n]~=nil then
      发送数据(玩家数据[n].连接id,998,"服务器已经关闭，你被强制断开连接")
    end
  end
  保存系统数据()
  os.exit()
end

function 全部玩家下线()
	for n, v in pairs(玩家数据) do
		if 玩家数据[n]~=nil and 玩家数据[n].连接id then
			发送数据(玩家数据[n].连接id,998,"服务器维护中，你被强制断开连接")
		end
	end
	保存系统数据()
	for n, v in pairs(__C客户信息) do
		if __C客户信息[n].网关==nil then
			__S服务:断开连接(n)
			__C客户信息[n]=nil
		end
	end
	print("全部玩家下线成功！")
end

function 输入函数(t)
	local lssj = 分割文本(t,"*")
	t=lssj[1]
	local t2 = lssj[2]
	if t=="@gxdm" then
		local 临时函数=loadstring(读入文件("热更新/更新初始.txt"))
		临时函数()
		print("热更新代码成功")
	elseif t=="@520" then
	地煞星:刷新资源()
  elseif t=="@1314" then
	设置任务2031()
	设置任务2032()
	设置任务2033()
	设置任务2034()
	设置任务2035()
	elseif t=="@gxcz" then
		测试重置()
	elseif t=="@gxgw" then
		怪物数据= 取csv数据("sql/怪物数据.csv")
		活动数据= 取csv数据("sql/活动数据.csv")
		阶段属性= 取csv数据("sql/阶段属性.csv")
		print("更新怪物成功")
	elseif t=="@5555" then
		十八妖王:妖王排行()
		print("更新排行成功")
	elseif t=="@cq" then
		保存系统数据()
		保存帮派数据()
		if  调试模式 then
		    服务器关闭={开关=true,计时=10,起始=os.time()}
		else
			服务器关闭={开关=true,计时=180,起始=os.time()}
			发送公告("#R各位玩家请注意，服务器将在3分钟后进行更新,届时服务器将临时关闭，请所有玩家注意提前下线。")
		    广播消息({内容=format("#R各位玩家请注意，服务器将在3分钟后进行更新,届时服务器将临时关闭,，请所有玩家提前下线。"),频道="xt"})
		end

	elseif t=="@qxcq" then
	  服务器关闭=nil
	elseif t=="@1111" then
    自写活动:知了大王()
    自写活动:知了统领()
    自写活动:千年知了王()
    自写活动:知了小王()
    自写活动:裂风兽()
    自写活动:世界boss(id)
	elseif t=="@bcsj" then
		保存系统数据()
	elseif t=="@123123" then
    镖王任务.活动开关=true
    镖王任务:开启活动()

	elseif t=="@bcwjsj" then
		保存玩家数据()
	elseif t=="@bcqtsj" then
		保存帮派数据()
	elseif t=="@qbxx" then
		全部玩家下线()
	elseif t=="@bcbpsj" then
		for k,v in pairs(取所有帮派) do
			if v.已解散 then
		    	local sdfew="bpsj/帮派数据"..k..".txt"
				写出文件(sdfew,table.tostring({}))
			else
			    local sdfew="bpsj/帮派数据"..k..".txt"
				写出文件(sdfew,table.tostring(帮派数据[k]))
			end
		end
		__S服务:输出("保存帮派数据成功……")
	elseif t=="@bcwj" then
		for n, v in pairs(玩家数据) do
			if 玩家数据[n]~=nil then
				玩家数据[n].角色:存档()
			end
		end
		__S服务:输出("保存玩家数据成功……")
	elseif t=="@8881" then --这里是改错
		local sadwe=table.loadstring(读入文件([[全局新增bl.txt]]))
	            for k,v in pairs(HDPZ) do
			if sadwe[k] then
			           HDPZ[k]=sadwe[k]
			end
		end
		写出文件([[全局bl.txt]],table.tostring(HDPZ))
		__S服务:输出("修改爆率成功！")
	elseif t=="@8882" then --这里是新增
		local sadwe=table.loadstring(读入文件([[全局新增bl.txt]]))
		for k,v in pairs(sadwe) do
			HDPZ[k]={}
			HDPZ[k]=v
		end
		写出文件([[全局bl.txt]],table.tostring(HDPZ))
		__S服务:输出("新增爆率成功")
	elseif t=="@bcrw" then
		local llsj={}
		local 数量=0
		for n, v in pairs(任务数据) do --罗庚  回梦丹  打造
			if v.是存档 then
				数量=数量+1
				llsj[数量]=table.loadstring(table.tostring(任务数据[n]))
				llsj[数量].存储id=n
			end
		end
		写出文件([[sql/任务数据.txt]],table.tostring(llsj))
		llsj=nil
		__S服务:输出("保存任务数据成功……")
	elseif t=="@222" then
		QAQ=ReadExcel("怪物数据","H3aM5ow4Ot6i5OyyDc3m5Q==")
		print("更新怪物属性成功")
	elseif t=="@333" then
		QJDJSX=f函数.读配置(程序目录.."配置文件.ini","主要配置","等级上限")+0
		print("更新服务器等级=="..QJDJSX)
	elseif t=="@444" then
		服务端参数.经验获得率=f函数.读配置(程序目录.."配置文件.ini","主要配置","经验")+0
		print("经验获得率=="..服务端参数.经验获得率)
	elseif t=="@zx" then
		print(服务端参数.在线人数)
	elseif t=="@bcrz" then
		local 保存语句=""
		for n=1,#错误日志 do
			保存语句=保存语句..时间转换(错误日志[n].时间)..'：#换行符'..错误日志[n].记录..'#换行符'..'#换行符'
		end
		写出文件("错误日志.txt",保存语句)
		错误日志={}
		__S服务:输出("保存错误日志成功")
	elseif t=="@cklb" then
		查看在线列表()
	elseif t=="@qzxx" then
		强制下线()
	elseif t=="@kqjr" then
	  假人事件类:登录()

	-- elseif t=="@结束战斗" then
	-- 	local id =t2+0
	-- 	if 玩家数据[id]~= nil and  玩家数据[id].zhandou~=0 then
	-- 		if  战斗准备类.战斗盒子[玩家数据[id].zhandou]~=nil  then
	-- 			战斗准备类.战斗盒子[玩家数据[id].zhandou]:结束战斗(0,0,1,1)
	-- 		end
	-- 	end
	-- elseif t=="@小龟赛跑开启" then
	-- 	设置任务506()
	-- elseif t=="@统计实力刷新" then
	-- 	系统处理类:统计实力榜更新数据()
	-- elseif t=="@长安保卫战"  then
	-- 	设置任务220()
	-- elseif t=="@czfw"  then
	-- 	重置房屋()
	-- elseif t=="@重置首席"  then
	-- 	首席初始化()
	-- elseif t=="@首席竞选开启"  then
	-- 	首席弟子类:开启首席竞选()
	-- elseif t=="@首席竞选结束"  then
	-- 	首席弟子类:结束首席竞选()
	-- elseif t=="@科举开启"  then
	-- 	科举.开关=true
	-- 	科举.起始=os.time()
	-- 	广播消息({内容="#G/科举活动已经开启，各位玩家可以前往长安城#R/礼部侍郎#G/处领取战报。",频道="xt"})
	-- elseif t=="@军阵开启"  then
	-- 	军阵威仪.开关=true
	-- 	军阵威仪.起始=os.time()
	-- 	广播消息({内容="#G军阵威仪活动已经开启，各位玩家可以前往长安城#R/礼部尚书#G/处领取战报。",频道="xt"})
	-- elseif t=="@月影开启"  then
	-- 	月影觅仙踪（奔月）.开关=true
	-- 	月影觅仙踪（奔月）.起始=os.time()
	-- 	广播消息({内容="#G/月影觅仙踪（奔月）活动已经开启，各位玩家可以前往长安城#R/婵娟#G/处领取战报。",频道="xt"})
	-- elseif t=="@战斗监控打印"  then
	-- 	写出文件("/战斗监控.txt", table.tostring(战斗监控))
	-- 	战斗监控={}
	end
end

function 循环函数()
	if 服务端参数.启动时间 ~= os.time() and 初始化完毕 then
		时辰函数()
		服务端参数.分钟=os.date("%M", os.time())
		服务端参数.小时=os.date("%H", os.time())
		服务端参数.秒=os.date("%S", os.time())
		服务端参数.启动时间=os.time()
		整秒处理()
	end
end

function 退出函数()
	保存系统数据()
	os.execute("pause")
end