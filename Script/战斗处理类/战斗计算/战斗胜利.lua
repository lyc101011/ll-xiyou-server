-- @Author: baidwwy
-- @Date:   2024-08-21 11:47:39
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-14 12:34:47
-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:44
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-08-30 18:22:29
-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:44
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-08-19 01:48:39
-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:44
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-07-31 22:30:29
local 战斗胜利 = class()
local jhf = string.format
local random = math.random
local qz=math.floor
local sj = 取随机数

function 战斗胜利:初始化()
end

function 战斗胜利:胜利处理(胜利id,战斗数据,玩家PK,失败id)
	local RWID=战斗数据.任务id
	local id组={}
	if 玩家PK then
		local 胜利组={}
		local 失败组={}
		for n=1,#战斗数据.参战玩家 do
			local wjid=战斗数据.参战玩家[n].id
			if wjid and 玩家数据[wjid]~=nil and 玩家数据[wjid].角色 then
				if 战斗数据.参战玩家[n].队伍==胜利id then
					胜利组[#胜利组+1]=wjid
				elseif 战斗数据.参战玩家[n].队伍==失败id then
					失败组[#失败组+1]=wjid
				end
				local 编号=战斗数据:取参战编号(wjid,"角色")
				战斗数据:还原单位属性(编号)
			end
		end
		for n=1,#战斗数据.参战单位 do --还原BB属性
			if 战斗数据.参战单位[n].玩家id and 战斗数据.参战单位[n].类型=="bb" and 玩家数据[战斗数据.参战单位[n].玩家id]~=nil then
				战斗数据:还原单位属性(n)
			end
		end
		if 战斗数据.战斗类型==200002 then--帮战
			帮派PK:PK胜利处理(胜利组,失败组)
			return
		------------------------------------比武
	    elseif 战斗数据.战斗类型==200003 then
			比武大会:PK胜利处理(胜利组,失败组)
			return
		------------------------------------
		elseif 战斗数据.战斗类型==200004 then--剑会
			剑会:PK胜利处理(胜利组,失败组)
			return
		-------------------------麻瓜剑会
	    elseif 战斗数据.战斗类型==200014 then
	    	剑会天下:PK胜利处理(胜利组,失败组)
	    	return
		-------------------------
		elseif 战斗数据.战斗类型==200005 then--勾魂索
			self:胜利MOB_200005(胜利组)
		elseif 战斗数据.战斗类型==200006 then --武神坛8.25
		    self:胜利MOB_200006(胜利组,失败组)
		    return
		end
		return
	else
		for n=1,#战斗数据.参战玩家 do
			if 战斗数据.参战玩家[n].队伍==胜利id and 玩家数据[战斗数据.参战玩家[n].id]~=nil then
				id组[#id组+1]=战斗数据.参战玩家[n].id
				local 编号=战斗数据:取参战编号(战斗数据.参战玩家[n].id,"角色")
				战斗数据:还原单位属性(编号)
			end
		end
		for n=1,#战斗数据.参战单位 do --还原BB属性
			if 战斗数据.参战单位[n].队伍==胜利id and 战斗数据.参战单位[n].类型=="bb" and 战斗数据.参战单位[n].玩家id and 玩家数据[战斗数据.参战单位[n].玩家id]~=nil then
				战斗数据:还原单位属性(n)
			end
		end
	end

	if 胜利id~=0 then
		战斗数据.玩家胜利=true
		战斗数据.战斗胜利=true
		if 战斗数据.战斗类型 == 134872 then --比武
			比武大会:假人PK胜利处理(RWID,id组,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		-------------------------剑会天下
	    elseif 战斗数据.战斗类型 == 160001 then
			剑会天下:假人胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		-------------------------
		elseif 战斗数据.战斗类型 == 140101 then            --龙族
		    龙族:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
		    self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型 == 140102 then                   --知了先锋
		    知了先锋:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
		    self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=130002 and  战斗数据.战斗类型<=130029 then
			彩虹争霸:战斗胜利处理(RWID,id组,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=111127 and  战斗数据.战斗类型<=111129 then
			天罡星:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		-- elseif 战斗数据.战斗类型>=111130 then
		-- 	天罡星:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
		-- 	self:怪物检测(RWID)
		-- 	return
		-- elseif 战斗数据.战斗类型>=111128 and  战斗数据.战斗类型<=111129 then
		-- 	天罡星:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
		-- 	self:怪物检测(RWID)
		-- 	return
		elseif 战斗数据.战斗类型>=130030 and  战斗数据.战斗类型<=130035 then
			初识地宫:战斗胜利处理(id组,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=130036 and  战斗数据.战斗类型<=130040 then
			文韵墨香:战斗胜利处理(id组,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=130041 and  战斗数据.战斗类型<=130052 then
			天降辰星:战斗胜利处理(id组,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=130053 and  战斗数据.战斗类型<=130063 then
			帮派迷宫:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=145554  and 战斗数据.战斗类型<=145565 then
			副本_秘境降妖:完成秘境降妖任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=155566  and 战斗数据.战斗类型<=155574 then
			副本_黑风山:完成黑风山任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=155576  and 战斗数据.战斗类型<=155585 then
			完成大闹天宫任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==100011 then
			门派闯关:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==100012 then
			游泳活动:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==101012 then
			镖王任务:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==100224 then
			完成十八路妖王(RWID,id组,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=190201 and 战斗数据.战斗类型<=190216 then
			副本_通天河:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			if 战斗数据.战斗类型 == 190204 or 战斗数据.战斗类型 == 190205 or 战斗数据.战斗类型 == 190206 or 战斗数据.战斗类型 == 190207 then
				战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			end
			self:怪物检测(RWID)
			return

		elseif 战斗数据.战斗类型 == 155551 or 战斗数据.战斗类型 == 155552 or 战斗数据.战斗类型 == 155553 or 战斗数据.战斗类型 == 155554 then
				战斗数据.下场战斗序号 = 战斗数据.战斗类型 + 1
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==100015 or 战斗数据.战斗类型==100016 or 战斗数据.战斗类型==100018 or 战斗数据.战斗类型==100017 or 战斗数据.战斗类型==130064
			or 战斗数据.战斗类型==100028 or 战斗数据.战斗类型==100029 or 战斗数据.战斗类型==100030 or 战斗数据.战斗类型==100031
			or (战斗数据.战斗类型>=190001 and 战斗数据.战斗类型<=190007)  then
			local fun = _G["胜利MOB_"..tostring(战斗数据.战斗类型)]
			if fun ~= nil then
				fun(id组,战斗数据.战斗类型,RWID,战斗数据.同门死亡)
			end
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==100135 then
			梦魇夜叉:战斗胜利处理(id组,战斗数据.额外数据,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==100136 then
			新手活动怪:战斗胜利处理(id组,战斗数据.额外数据,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==100009 then
			二八星宿:战斗胜利处理(id组,战斗数据.额外数据,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=130066 and  战斗数据.战斗类型<=130082 then
			投放怪:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=155557  and  战斗数据.战斗类型<=155565 then
			自写活动:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=130083 and  战斗数据.战斗类型<=130086 then
			帮派PK:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=111125 and  战斗数据.战斗类型<=111126 then
			地煞星:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=155632   and  战斗数据.战斗类型<=155640 then
			完成天火之殇上任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=155609  and 战斗数据.战斗类型<=155618 then
			完成无底洞任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=155600  and 战斗数据.战斗类型<=155608 then
			完成齐天大圣任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=155576  and 战斗数据.战斗类型<=155585 then
			完成大闹天宫任务(id组,RWID,战斗数据.战斗类型)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=130087 and  战斗数据.战斗类型<=130096 then
			长安保卫战:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=190101 and 战斗数据.战斗类型<=190106 then
			副本_一斛珠:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=190201 and 战斗数据.战斗类型<=190216 then
			副本_通天河:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型>=190301 and 战斗数据.战斗类型<=190316 then
			副本_双城记:战斗胜利处理(id组,战斗数据.战斗类型,RWID)
			self:怪物检测(RWID)
			return
		elseif 战斗数据.战斗类型==140000 then
			雁塔地宫:战斗胜利处理(id组,战斗数据.战斗类型)
			return
		end
		local fun = _G["胜利MOB_"..tostring(战斗数据.战斗类型)]
		if fun ~= nil then
			fun(胜利id,战斗数据,id组)
		end
		self:怪物检测(RWID)
	end
end

function 战斗胜利:胜利MOB_200005(id组)

	for n=1,#id组 do
		local 队员id=id组[n]
		if 玩家数据[队员id].已扣除勾魂索 then
			玩家数据[队员id].已扣除勾魂索=nil
			玩家数据[队员id].勾魂索中=nil
		end
		玩家数据[队员id].角色:扣除人气()
	end
	for n=1,#id组 do
		local 队员id=id组[n]
			if 玩家数据[队员id].角色.武神坛角色 then
				local 实际人数=#id组
				for z,id in pairs(id组) do
					local dyid = 玩家数据[id].角色.wst对应id
					if dyid ~= nil then
						if _武神坛记录.次数[id]==nil then
							_武神坛记录.次数[id] = 0
						end
						if _武神坛记录.积分[dyid]==nil then
							_武神坛记录.积分[dyid] = 0
						end
						_武神坛记录.次数[id] = _武神坛记录.次数[id] + 1 -------
						_武神坛记录.积分[dyid] = _武神坛记录.积分[dyid] + 实际人数
						常规提示(id,"获得积分：#R" ..实际人数.."#W 武神坛奖励尚未想好，有建议可以提")
					end
				end
			end
	end
end

function 战斗胜利:胜利MOB_200006(id组,失败组) --武神坛8.25
	local gf = 5
	if #id组 > #失败组 then
		gf = #失败组
	end
	for n,id in pairs(id组) do
		local dyid = 玩家数据[id].角色.wst对应id
		if dyid ~= nil then
			if _武神坛记录.次数[id]==nil then
				_武神坛记录.次数[id] = 0
			end
			if _武神坛记录.积分[dyid]==nil then
				_武神坛记录.积分[dyid] = 0
			end
			_武神坛记录.次数[id] = _武神坛记录.次数[id] + 1
			_武神坛记录.积分[dyid] = _武神坛记录.积分[dyid] + gf
			常规提示(id,"胜利获得积分" ..gf)
		end
	end
end

function 战斗胜利:怪物检测(RWID)
	if RWID==nil or 任务数据[RWID]==nil then return  end
	任务数据[RWID].zhandou=nil
end

return 战斗胜利