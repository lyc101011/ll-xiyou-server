-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-04-05 21:43:05
local 战斗准备类 = class()
function 战斗准备类:初始化()
	self.战斗盒子={}
	self.WPEtime=os.time()
	self.jingzhi=0
	self.xiaxian=0
end
function 战斗准备类:创建玩家战斗(玩家id, 序号, 对方id,地图,单挑模式)
	if 玩家数据[玩家id].zhandou ~= 0 and 玩家数据[对方id].zhandou ~= 0 then
	    return
	end
	if 玩家数据[对方id]==nil or (玩家数据[对方id]~=nil and 玩家数据[对方id].角色.战斗开关) and  玩家数据[对方id].zhandou ~= 0 then
		if 玩家数据[玩家id].队伍 == 0 then
			玩家数据[玩家id].zhandou = 玩家数据[对方id].zhandou
			玩家数据[玩家id].角色.战斗开关 = true
			地图处理类:设置战斗开关(玩家id,true)
			self.战斗盒子[玩家数据[玩家id].zhandou]:进入观战(玩家id,对方id)
			常规提示(玩家id,"#Y/正在观战#/R"..玩家数据[对方id].角色.名称.."#Y/的战斗")
		else
			常规提示(玩家id,"#Y/组队中不可以观战或者对方正在战斗战斗")
		end
		return
	end
	if 玩家id==对方id then
		常规提示(玩家id,"#Y/自己人啊大哥！")
		return
	end
	if 玩家数据[玩家id].队伍 ~= 0 and 玩家数据[对方id].队伍 ~=0 and 玩家数据[玩家id].队伍 == 玩家数据[对方id].队伍 then
		常规提示(玩家id,"#Y/自己人啊！大哥！")
		return
	end
	if 玩家数据[对方id].队伍~=0 and 玩家数据[对方id].队长==false  then
	    对方id=玩家数据[对方id].队伍
	end

	self.临时id = 玩家id
	self.临时id = self.临时id + 0
	if 玩家数据[玩家id].队伍 == 0 then
		玩家数据[玩家id].zhandou = self.临时id
		玩家数据[玩家id].角色.战斗开关 = true
		地图处理类:设置战斗开关(玩家id,true)
	else
		 for n=1,#队伍数据[玩家数据[玩家id].队伍].成员数据 do
		 	local cyid=队伍数据[玩家数据[玩家id].队伍].成员数据[n]
			if 玩家数据[cyid].队伍==玩家数据[玩家id].队伍 then
				玩家数据[cyid].zhandou=self.临时id
				玩家数据[cyid].角色.战斗开关=true
				地图处理类:设置战斗开关(cyid,true)
			end
		end
	end

	if 玩家数据[对方id].队伍 == 0 then
		玩家数据[对方id].zhandou = self.临时id
		玩家数据[对方id].角色.战斗开关 = true
		地图处理类:设置战斗开关(对方id,true)
		if 序号 == 200003 or 序号 == 200002 or 序号 == 200003 then --比武加200003
			常规提示(对方id,"#Y/你进入了由#R/" .. 玩家数据[玩家id].角色.名称 .. "#Y/发起的战斗中")
		end
	else
		for n=1,#队伍数据[玩家数据[对方id].队伍].成员数据 do
			local cyid=队伍数据[玩家数据[对方id].队伍].成员数据[n]
			if 玩家数据[cyid].队伍==玩家数据[对方id].队伍 then
				玩家数据[cyid].zhandou=self.临时id
				玩家数据[cyid].角色.战斗开关=true
				地图处理类:设置战斗开关(cyid,true)
				if 序号 == 200003 or 序号 == 200002 or 序号 == 200003 then --比武加200003
					常规提示(cyid,"#Y/你进入了由#r/" .. 玩家数据[玩家id].角色.名称 .. "#Y/对你发起的战斗中")
				end
			end
		end
	end

	self.战斗盒子[self.临时id] = 战斗处理类.创建()
	self.战斗盒子[self.临时id]:进入战斗(玩家id, 序号, 对方id, 地图,true,nil,单挑模式)
end

function 战斗准备类:创建战斗(玩家id,序号,任务id,地图)
	print(1)
	if 玩家数据[玩家id].zhandou~=0 then
	    return
	end
	if 玩家数据[玩家id].队伍 ~= 0 then
		local 异常成员=""
		for n=1,#队伍数据[玩家数据[玩家id].队伍].成员数据 do
			local cyid = 队伍数据[玩家数据[玩家id].队伍].成员数据[n]
			if 玩家数据[cyid].zhandou ~= 0 then
				常规提示(cyid,"#Y/队伍中#r/" .. 玩家数据[cyid].角色.名称 .. "#Y/状态有异常，请尝试重新登录！")
				return
			end
		end
	end

	local 临时id=玩家id
	临时id=临时id

	if 序号==100001 or 序号==100007 then --暗雷和明雷
		if 玩家数据[玩家id].角色.剧情.附加.野外战斗 ~= nil  and 玩家数据[玩家id].角色.地图数据.编号 == 玩家数据[玩家id].角色.剧情.地图 then
			local fhz = 活动怪物处理(玩家数据[玩家id].角色.剧情.附加.野外战斗,任务id,玩家id)
			if #fhz > 0 then
				玩家数据[玩家id].zhandou=临时id
				if 玩家数据[玩家id].队伍==0 then
					玩家数据[玩家id].角色.战斗开关=true
					地图处理类:设置战斗开关(玩家id,true)
				else
					for n=1,#队伍数据[玩家数据[玩家id].队伍].成员数据 do
						if 玩家数据[队伍数据[玩家数据[玩家id].队伍].成员数据[n]].队伍==玩家数据[玩家id].队伍 then
							玩家数据[队伍数据[玩家数据[玩家id].队伍].成员数据[n]].zhandou=临时id
							玩家数据[队伍数据[玩家数据[玩家id].队伍].成员数据[n]].角色.战斗开关=true
							地图处理类:设置战斗开关(队伍数据[玩家数据[玩家id].队伍].成员数据[n],true)
						end
					end
				end
				self.战斗盒子[临时id]=战斗处理类.创建(os.time())
				self.战斗盒子[临时id]:进入战斗(玩家id,玩家数据[玩家id].角色.剧情.附加.野外战斗,任务id,fhz)
			else
				self.战斗盒子[临时id] = nil
			end
		else
			玩家数据[玩家id].zhandou=临时id
			if 玩家数据[玩家id].队伍==0 then
				玩家数据[玩家id].角色.战斗开关=true
				地图处理类:设置战斗开关(玩家id,true)
			else
				for n=1,#队伍数据[玩家数据[玩家id].队伍].成员数据 do
					if 玩家数据[队伍数据[玩家数据[玩家id].队伍].成员数据[n]].队伍==玩家数据[玩家id].队伍 then
						玩家数据[队伍数据[玩家数据[玩家id].队伍].成员数据[n]].zhandou=临时id
						玩家数据[队伍数据[玩家数据[玩家id].队伍].成员数据[n]].角色.战斗开关=true
						地图处理类:设置战斗开关(队伍数据[玩家数据[玩家id].队伍].成员数据[n],true)
					end
				end
			end
			self.战斗盒子[临时id]=战斗处理类.创建(os.time())
			self.战斗盒子[临时id]:进入战斗(玩家id,序号,任务id,地图)
		end
		return
	end
	-------------------------------------怪物属性-------------------------------------
	-------------------------------------怪物属性-------------------------------------
	local Shifouyou=怪物属性.GUAIWU[tostring(序号)]
	if Shifouyou then
		local shux=Shifouyou(任务id,玩家id,序号)
--	table.print(shux)     --伤害打印伤害
		if 玩家数据[玩家id].队伍==0 then
		玩家数据[玩家id].zhandou=临时id
			玩家数据[玩家id].角色.战斗开关=true
			地图处理类:设置战斗开关(玩家id,true)
		else
			for n=1,#队伍数据[玩家数据[玩家id].队伍].成员数据 do
				if 玩家数据[队伍数据[玩家数据[玩家id].队伍].成员数据[n]].队伍==玩家数据[玩家id].队伍 then
					玩家数据[队伍数据[玩家数据[玩家id].队伍].成员数据[n]].zhandou=临时id
					玩家数据[队伍数据[玩家数据[玩家id].队伍].成员数据[n]].角色.战斗开关=true
					地图处理类:设置战斗开关(队伍数据[玩家数据[玩家id].队伍].成员数据[n],true)
				end
			end
		end
		self.战斗盒子[临时id]=战斗处理类.创建(os.time())
		self.战斗盒子[临时id]:进入战斗(玩家id,序号,任务id,shux)
		return
	else
		local fhz = 活动怪物处理(序号,任务id,玩家id)
		if #fhz > 0 then
			玩家数据[玩家id].zhandou=临时id
			if 玩家数据[玩家id].队伍==0 then
				玩家数据[玩家id].角色.战斗开关=true
				地图处理类:设置战斗开关(玩家id,true)
			else
				for n=1,#队伍数据[玩家数据[玩家id].队伍].成员数据 do
					if 玩家数据[队伍数据[玩家数据[玩家id].队伍].成员数据[n]].队伍==玩家数据[玩家id].队伍 then
						玩家数据[队伍数据[玩家数据[玩家id].队伍].成员数据[n]].zhandou=临时id
						玩家数据[队伍数据[玩家数据[玩家id].队伍].成员数据[n]].角色.战斗开关=true
						地图处理类:设置战斗开关(队伍数据[玩家数据[玩家id].队伍].成员数据[n],true)
					end
				end
			end
			self.战斗盒子[临时id]=战斗处理类.创建(os.time())
			self.战斗盒子[临时id]:进入战斗(玩家id,序号,任务id,fhz)
		else
			self.战斗盒子[临时id] = nil
		end
	end
		print(2)
end

function 战斗准备类:更新(dt)
	for n, v in pairs(self.战斗盒子) do
		if self.战斗盒子[n]~=nil then
			self.战斗盒子[n]:更新()
		end
		if self.战斗盒子[n].结束条件 then
			self.战斗盒子[n]=nil
		end
	end
end

function 战斗准备类:数据处理(玩家id,序号,内容,参数)

	if 玩家数据[玩家id].zhandou==0 or self.战斗盒子[玩家数据[玩家id].zhandou]==nil then
		return 0
	else
		self.战斗盒子[玩家数据[玩家id].zhandou]:数据处理(玩家id,序号,内容,参数)
	end
end

function 战斗准备类:显示(x,y)end
return 战斗准备类