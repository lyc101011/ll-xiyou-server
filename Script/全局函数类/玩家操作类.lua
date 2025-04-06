-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-10-30 17:20:05
function 保存系统数据()
	 写出文件([[sql/武神坛蚩尤.txt]],table.tostring(武神坛蚩尤)) --武神坛
	 写出文件([[sql/武神坛记录.txt]],table.tostring(_武神坛记录)) --武神坛8.25
	写出文件([[sql/每日任务.txt]],table.tostring(每日任务))
	for n, v in pairs(玩家数据) do
		if 玩家数据[n] and 玩家数据[n].角色 then
			玩家数据[n].角色:存档()
		end
	end
	__S服务:输出("保存玩家数据成功……")
    保存帮派数据()
    奖池抽奖类:保存奖池数据() --抽奖
	当前时间=os.time()
	当前年份=os.date("%Y",当前时间)
	当前月份=os.date("%m",当前时间)
	当前日份=os.date("%d",当前时间)
	保存时间=os.date("%H",当前时间).."时"..os.date("%M",当前时间).."分"..os.date("%S",当前时间).."秒 "
	if f函数.文件是否存在([[log\]]..当前年份)==false then
		lfs.mkdir([[log\]]..当前年份)
	end
	if f函数.文件是否存在([[log\]]..当前年份..[[\]]..当前月份)==false then
		lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份)
	end
	if f函数.文件是否存在([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份)==false then
		lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份)
		lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."错误日志")
		lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."登录日志")
		lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."在线日志")
		lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."备份日志")
		lfs.mkdir([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."藏宝阁日志")
	end
	if #错误日志<500 then
		local 保存语句=""
		for n=1,#错误日志 do
			保存语句=保存语句..时间转换(错误日志[n].时间)..'：#换行符'..错误日志[n].记录..'#换行符'..'#换行符'
		end
		写出文件([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."错误日志"..[[\]]..保存时间..".txt",保存语句)
	else
		local 文件名称=保存时间
		local 计次数量=0
		local 保存语句=""
		for n=1,#错误日志 do
			保存语句=保存语句..时间转换(错误日志[n].时间)..'：#换行符'..错误日志[n].记录..'#换行符'..'#换行符'
			计次数量=计次数量+1
			if 计次数量>=500 then
				写出文件([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."错误日志"..[[\]]..文件名称.."_"..n..".txt",保存语句)
				计次数量=0
				保存语句=""
			end
		end
	end
	错误日志={}
	写出文件([[sql/通天塔重置记录.txt]],table.tostring(通天塔重置记录))
	写出文件([[sql/藏宝阁数据.txt]],table.tostring(藏宝阁数据))
	写出文件([[sql/蚩尤次数.txt]],table.tostring(蚩尤次数))
	写出文件([[sql/寄存数据.txt]],table.tostring(寄存数据))
	写出文件([[sql/通天塔数据.txt]],table.tostring(通天塔数据))
	写出文件([[sql/十八路妖王.txt]],table.tostring(十八路妖王))
	写出文件([[sql/移动数据.txt]],table.tostring(移动数据))
	写出文件([[sql/攻击数据.txt]],table.tostring(攻击数据))
	写出文件([[sql/施法数据.txt]],table.tostring(施法数据))
	写出文件([[sql/采矿活动.txt]],table.tostring(采矿活动))
	写出文件([[sql/押镖数据.txt]],table.tostring(押镖数据))
	写出文件([[sql/活动次数.txt]],table.tostring(活动次数))
	写出文件([[sql/充值数据.txt]],table.tostring(充值数据))
	写出文件([[log\]]..当前年份..[[\]]..当前月份..[[\]]..当前日份..[[\]].."藏宝阁日志"..[[\]]..保存时间..".txt",藏宝阁记录)
    藏宝阁记录 = ""
    __S服务:输出("藏宝阁记录保存成功……")
	__S服务:输出("错误日志保存成功……")
end

function 保存玩家数据()
	for n, v in pairs(玩家数据) do
		if 玩家数据[n] and 玩家数据[n].角色 then
			print("存档开始 id="..n)
			玩家数据[n].角色:存档()
		end
	end
	__S服务:输出("保存玩家数据成功……")
end

function 保存帮派数据()
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
	神兵异兽榜:存档()----------
	llsj=nil
	__S服务:输出("保存任务数据成功……")

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
end

function 写出封禁记录(账号,数字id,ip)
	封禁记录[账号]={id=数字id,ip=ip}
	写出文件([[WPE/封禁记录.txt]],table.tostring(封禁记录))
	__S服务:输出("写出封禁记录成功")
end

function 强制下线()
	for n, v in pairs(战斗准备类.战斗盒子) do
		if 战斗准备类.战斗盒子[n]~=nil  then
			战斗准备类.战斗盒子[n]:结束战斗(0,0,1,1)
		end
	end
	for n, v in pairs(玩家数据) do
		if 玩家数据[n]~=nil and 玩家数据[n].连接id ~= "假人" then
			玩家数据[n].角色:存档()
			系统处理类:断开游戏(n)
		end
	end
end

function 队友剧情同步(数字id,data) --剧情同步
	local fhid组={}
	if data==nil or type(data)~="table" or data.主线==nil then return fhid组 end
	if 玩家数据[数字id]~=nil and 玩家数据[数字id].队长 and 玩家数据[数字id].角色.剧情~=nil then
		local djqid = false
		local dzzx = data.主线
		local dzjd = data.进度
		local 队伍id=玩家数据[数字id].队伍
		if 队伍数据[队伍id]~=nil then
			for an=1,#队伍数据[队伍id].成员数据 do
				local 队员id = 队伍数据[队伍id].成员数据[an]
				if 队员id~=数字id and 玩家数据[队员id]~=nil and 玩家数据[队员id].角色.剧情~=nil and 玩家数据[队员id].角色.剧情.主线==dzzx and 玩家数据[队员id].角色.剧情.进度==dzjd then
					玩家数据[队员id].角色.剧情 = 玩家数据[数字id].角色.剧情
					if 玩家数据[队员id].连接id~="小伙伴" then
						发送数据(玩家数据[队员id].连接id,227,{剧情=玩家数据[队员id].角色.剧情})
					end
					table.insert(fhid组,队员id)
				elseif 队员id~=数字id and 玩家数据[队员id].角色.剧情~=nil and 玩家数据[队员id].角色.剧情.主线 < dzzx then
				    djqid = 队员id
				elseif 队员id~=数字id and 玩家数据[队员id].角色.剧情~=nil and 玩家数据[队员id].角色.剧情.主线 <= dzzx and 玩家数据[队员id].角色.剧情.进度 < dzjd then
				    djqid = 队员id
				end
			end
		end
		if djqid then
			常规提示(数字id,"#Y/队员#G/" ..玩家数据[djqid].角色.名称 .."#Y/剧情进度比你低，建议换他带队，剧情进度才能同步")
			消息提示(数字id,"#Y/队员#G/" ..玩家数据[djqid].角色.名称 .."#Y/剧情进度比你低，建议换他带队，剧情进度才能同步")
		end
	end
	return fhid组 --有奖励的剧情就返回队员id组，方便用
end

function 取剧情是否追踪(主线,等级)
	local JQsj={0,0,25,55,75,80,85,135,155}
	if JQsj[主线] and 等级>=JQsj[主线] then
	    return true
	end
	return false
end

function 打印在线时间()
	local 语句=""
	for n, v in pairs(在线时间) do
		语句=语句..string.format("角色id：%s，本日累积在线：%s秒#换行符",n,在线时间[n])
	end
	写出文件("在线时间.txt",语句)
end

function 异常账号(数字id,信息)
	 __S服务:输出(信息)
end

function 查看在线列表()
	local 列表=""
	for n, v in pairs(玩家数据) do
		列表=列表..format("账号%s,角色id%s",玩家数据[n].账号,n)..'#换行符'..'#换行符'
	end
	写出文件("在线列表.txt",列表)
end