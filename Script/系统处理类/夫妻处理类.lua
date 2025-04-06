-- @Author: baidwwy
-- @Date:   2024-10-15 01:51:56
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-10-31 17:43:57
-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:44
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-10-16 23:29:40
local 夫妻处理类 = class()
function 夫妻处理类:初始化() end

function 夫妻处理类:数据处理(连接id,序号,内容) --序号>6500 and 序号<=6600
    local 数字id = 内容.数字id+0
    if 序号==6550 then
		帮派PK:帮战报名处理(数字id,内容)
	elseif 序号==6551 then
		帮派PK:获取对战信息(连接id)
	elseif 序号==6552 then
		帮派PK:发起PK(数字id,内容)
	elseif 序号==6553 then
		帮派PK:铁锤点击(数字id,内容)
	elseif 序号==6561 then--PK台PK
		local 自己id = 数字id
		local 对手id = 内容.序列
		if 玩家数据[自己id].队伍~=0 and 玩家数据[自己id].队长==false  then
			常规提示(自己id,"只有队长才可以进行切磋")
		    return
		end
		战斗准备类:创建玩家战斗(自己id, 200001, 对手id, 1001)
	elseif 序号==6562 then--PK台PK 单挑模式
		local 自己id = 数字id
		local 对手id = 内容.序列
		if 玩家数据[自己id].队伍~=0 and 玩家数据[自己id].队长==false  then
			常规提示(自己id,"只有队长才可以进行切磋")
		    return
		elseif 玩家数据[自己id].队伍~=0 or 玩家数据[自己id].队长==true then
			常规提示(自己id,"单挑不可以组队")
		    return
		end
		战斗准备类:创建玩家战斗(自己id, 200001, 对手id, 1001, "单挑")
	elseif 序号==6565 then--观战
		local 自己id = 数字id
    	local 观战对象 = 内容.序列
    	if 玩家数据[观战对象]~=nil and 玩家数据[观战对象].角色.战斗开关 and  玩家数据[观战对象].zhandou ~= 0 then
			if 玩家数据[自己id].队伍 == 0 then
				玩家数据[自己id].zhandou = 玩家数据[观战对象].zhandou
				玩家数据[自己id].角色.战斗开关 = true
				地图处理类:设置战斗开关(自己id,true)
				--------------------------------------------
				if 玩家数据[自己id]~=nil then print(自己id,玩家数据[自己id],"================进入观战11") end
				if 玩家数据[自己id].zhandou~=nil then print(自己id,玩家数据[自己id].zhandou,"================进入观战22") end
				if 玩家数据[自己id]~=nil and 玩家数据[自己id].zhandou~=nil  then
					print(战斗准备类.战斗盒子[玩家数据[自己id].zhandou],"================进入观战33")
				end
				--------------------------------------------
				战斗准备类.战斗盒子[玩家数据[自己id].zhandou]:进入观战(自己id,观战对象)
				常规提示(自己id,"#Y/你进入了观战")
			else
				常规提示(自己id,"#Y/组队时不能观战")
			end
			return
		end
	elseif 序号==6566 then --比武
		----[[此段未验证]]
		local 对方id=内容.序列
		if 玩家数据[数字id].队伍~=0 and 玩家数据[数字id].队长==false  then
			常规提示(数字id,"只有队长才可以进行切磋")
		    return
		end
		if 比武大会数据.阶段 == 3 then
			if 比武大会数据.玩家[对方id] ~= nil and 比武大会数据.玩家[对方id].间隔 + 40 < os.time() then
				战斗准备类:创建玩家战斗(数字id, 200003, 对方id, 1197)
			else
				常规提示(内容.数字id,"对方处于保护时间无法PK")
			end
		end
		----[[此段未验证]]
		----[[以下为原端 看着就不对,暂时关]]
		-- 比武大会:发起PK(数字id,内容)
		-- 发送数据(玩家数据[自己id].连接id,1501,{名称="勾魂索PK",模型="",对话="确定发起决斗么？" ,选项={"确定","取消"} })


	elseif 序号==6567 then
		local 目标id=tonumber(内容.文本)+0
		local 自己id = 数字id
		-- if 玩家数据[自己id].队伍 ~= 0 and 玩家数据[目标id].队伍 ~=0 and 玩家数据[自己id].队伍 == 玩家数据[目标id].队伍 then
		-- if 目标账号 == 自己账号 and 玩家数据[自己id].角色.地图数据.编号 ~= 6227 then ----and后面 使武神坛内可以同一账号决斗


		if 玩家数据[目标id]==nil then
		    常规提示(自己id,"该玩家不在线无法查找！")
		    return
	    elseif 目标id==自己id then
	    	常规提示(自己id,"自己打自己？")
	    	return
	    elseif 玩家数据[自己id].zhandou~=0 or 玩家数据[目标id].zhandou~=0 then
			常规提示(自己id,"对方正在战斗中")
			return
		elseif 玩家数据[自己id].角色.地图数据.编号~=玩家数据[目标id].角色.地图数据.编号 then
			常规提示(自己id,"对方与你不在同一地图。")
			return
		elseif  玩家数据[自己id].队伍 ~= 0 and 玩家数据[自己id].队长 ==false then
			常规提示(数字id,"只有队长才可以进行此操作")
			return
		elseif  玩家数据[自己id].队伍 ~= 0 and 玩家数据[自己id].队伍 == 玩家数据[目标id].队伍 then
			常规提示(自己id,"这是自己人啊大哥~")
		    return

		elseif  玩家数据[目标id].队伍 ~= 0 and 玩家数据[目标id].队长 == false then
		    local 目标队长id = 玩家数据[目标id].队伍
		    常规提示(数字id,"对方不是队长，智能切换为对方队长id："..目标队长id.." ")
		    目标id = 目标队长id
		end

		if 取安全区(目标id) then
			常规提示(自己id,"目标不在线或在安全区内呢！")
		    return
		end
		local 对话="对方已打开pk开关，进入生死决斗双方将有100秒时间准备，确定发起决斗么？"
		local xx={"确定","取消"}
		if 玩家数据[目标id].角色.PK开关==nil then
		    对话="对方没有打开pk开关，你确定要与他进入生死决斗么？双方将有100秒时间准备，确定发起决斗么？"
		end
		玩家数据[自己id].勾魂索目标=目标id
		发送数据(玩家数据[自己id].连接id,1501,{名称="勾魂索PK",模型="",对话=对话,选项=xx})

	elseif 序号==6563 then--勾魂索PK
    	for k,v in pairs(勾魂索名单) do
    		if v.倒计时开始 then
    		    if v.主动==数字id or v.被动==数字id  then
    		        v.战斗开始 = true
    		        break
    		    end
    		end
    	end
	elseif 序号==6564 then--勾魂索10秒倒计时
		for k,v in pairs(勾魂索名单) do
    		if v.倒计时开始 then
    		    if v.主动==数字id then
    		        v.主动方确认 = true
		        elseif v.被动==数字id then
    		        v.被动方确认 = true
    		    end
    		    if v.被动方确认 and  v.主动方确认 then --勾魂索10秒倒计时
    		    	发送数据(玩家数据[v.主动].连接id,3708)
    		        发送数据(玩家数据[v.被动].连接id,3708)
    		        break
    		    end
    		end
    	end
	elseif 序号==6580 then
		剑会:发起匹配请求(数字id,内容)
	elseif 序号==6581 then
		剑会:取消匹配(数字id,内容)
	elseif 序号==6582 then
		剑会:重新匹配(数字id,内容)
	elseif 序号==6583 then
		剑会:领取称谓(数字id)
	elseif 序号==6584 then
		剑会:剑会排行榜(数字id)
	elseif 序号==6586 then
		if 取指引数据.坐标[内容.名称] then
			if not 取指引传送次数[内容.数字id] then
				取指引传送次数[内容.数字id]=10
			end
			地图处理类:跳转地图(内容.数字id,取指引数据.坐标[内容.名称].map,取指引数据.坐标[内容.名称].xy.X,取指引数据.坐标[内容.名称].xy.Y)
		else
			发送数据(玩家数据[数字id].连接id,7,"#Y/这个地图不支持传送")
		end
	elseif 序号==6587 then---------玩家数据[内容.数字id].角色.系统设置[内容.选项] = 内容.回调
		local 对方id=内容.序列+0
		if 玩家数据[对方id] then
			if 玩家数据[对方id].角色.系统设置.允许查看装备 then
				发送数据(玩家数据[数字id].连接id,6587,{装备=玩家数据[对方id].角色:取装备数据(),灵饰=玩家数据[对方id].角色:取灵饰数据(),角色=玩家数据[对方id].角色:取观察数据()})
			else
				常规提示(数字id,"对方没有开启装备观察……")
			end
		end
	elseif 序号==6587.1 then
		local 对方id=内容.数字id+0
		if 玩家数据[对方id] then
				发送数据(玩家数据[对方id].连接id,6587.1,{装备=玩家数据[对方id].角色:取装备数据(),灵饰=玩家数据[对方id].角色:取灵饰数据(),角色=玩家数据[对方id].角色:取观察数据()})
		end

	----------------武神坛8.25
    elseif 序号==6588 then
    	local 自己id = 数字id
		local 对手id = 内容.序列
		if 玩家数据[自己id].队伍~=0 and 玩家数据[自己id].队长==false  then
			常规提示(自己id,"只有队长才可以进行切磋")
		    return
		end
		if 玩家数据[自己id].队伍~=nil and 玩家数据[自己id].队伍~=0 then
		    local 队伍id = 玩家数据[自己id].队伍
		    for n=1,#队伍数据[队伍id].成员数据 do
		    	local dyid = 队伍数据[队伍id].成员数据[n]
		    	if _武神坛记录.次数[dyid]~=nil and _武神坛记录.次数[dyid] >= 10 then
		    		常规提示(自己id,玩家数据[dyid].角色.名称 .."#W/今日已无PK次数，每日限10次。")
		            return
		    	end
		    end
		elseif _武神坛记录.次数[自己id]~=nil and _武神坛记录.次数[自己id] >= 10 then
			常规提示(自己id,"你今日已无PK次数，每日限10次。")
		    return
		end
		if 玩家数据[对手id].队伍~=nil and 玩家数据[对手id].队伍~=0 then
		    local 队伍id = 玩家数据[对手id].队伍
		    for n=1,#队伍数据[队伍id].成员数据 do
		    	local dyid = 队伍数据[队伍id].成员数据[n]
		    	if _武神坛记录.次数[dyid]~=nil and _武神坛记录.次数[dyid] >= 10 then
		    		常规提示(对手id,"对方#G/" ..玩家数据[dyid].角色.名称 .."#W/今日已无PK次数，每日限10次。")
		            return
		    	end
		    end
		elseif _武神坛记录.次数[对手id]~=nil and _武神坛记录.次数[对手id] >= 10 then
			常规提示(对手id,"对方今日已无PK次数，每日限10次。")
		    return
		end
		战斗准备类:创建玩家战斗(自己id, 200006, 对手id, 6227)
	----------------
	end
end
function 夫妻处理类:判定双方房屋(id,id2)
end

function 夫妻处理类:判定结婚状态(id,id2)
end

function 夫妻处理类:发送求婚请求(id,id2)
end

function 夫妻处理类:拒绝求婚请求(id,id2)
end

function 夫妻处理类:同意求婚请求(id,id2)
end

function 夫妻处理类:同意求婚离婚(id,id2)
	-- 玩家数据[id].角色.姻缘.婚姻 = false
	-- 玩家数据[id].角色.姻缘.配偶 = nil
	-- 玩家数据[id].角色.姻缘.房屋所属ID = nil
	-- 玩家数据[id].角色:删除称谓(玩家数据[id2].角色.名称.."的夫君")
	-- 玩家数据[id2].角色.姻缘.婚姻 = false
	-- 玩家数据[id2].角色.姻缘.配偶 = nil
	-- 玩家数据[id2].角色.姻缘.房屋所属ID = nil
	-- 玩家数据[id2].角色:删除称谓(玩家数据[id].角色.名称.."的娘子")
	-- for i=1,#房屋数据 do
	--     if 房屋数据[i].注销 and (房屋数据[i].ID == id or 房屋数据[i].ID == id2) then
	--       房屋数据[i].注销 = false
	--     end
	-- end
	-- 广播消息({内容=format("#S(大唐新闻快报)#Y玩家#R/%s#Y和#R/%s#Y各奔东西，祝他们好聚好散",玩家数据[id].角色.名称,玩家数据[id2].角色.名称),频道="xt"})
end

return 夫妻处理类