-- @Author: baidwwy
-- @Date:   2024-05-23 06:02:27
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-10-18 02:28:55
local 战斗失败 = class()
local jhf = string.format
local random = math.random
local qz=math.floor
local sj = 取随机数
function 战斗失败:初始化()
    -- self.不计失败类型={111111=true}
    -- if cond then
    --do
    -- end
end

function 战斗失败:失败处理(失败id,是否逃跑,战斗数据)
	if 失败id==0 then return  end
	local id组={}
	local 失败队长 = nil
	------------------比武
	if 玩家数据[失败id] ~= nil then
		local 地图=玩家数据[失败id].角色.地图数据.编号+0
		if 地图==5136 or 地图==5137 or 地图==5138 or 地图==5139 or 地图==6135 or 地图==6136 then
			return
		end
	end
	------------------
	for n=1,#战斗数据.参战玩家 do
		if 战斗数据.参战玩家[n].队伍==失败id and 玩家数据[战斗数据.参战玩家[n].id]~=nil then
			local 编号=战斗数据:取参战编号(战斗数据.参战玩家[n].id,"角色")
			if 战斗数据.参战单位[编号]~=nil and 战斗数据.参战单位[编号].类型~=nil and 战斗数据.参战单位[编号].类型=="角色"  then
				战斗数据:还原单位属性(编号)
				id组[#id组+1]=战斗数据.参战玩家[n].id
			end
		end
	end
	for n=1,#战斗数据.参战单位 do --还原BB属性
		if 战斗数据.参战单位[n].队伍==失败id and 战斗数据.参战单位[n].类型=="bb" and 战斗数据.参战单位[n].玩家id and 玩家数据[战斗数据.参战单位[n].玩家id]~=nil then
		    战斗数据:还原单位属性(n)
		end
	end
	战斗数据.战斗失败=true

    辅助内挂类:战斗失败记录(失败id,战斗数据.任务id)
	local fun = _G["失败MOB"..tostring(战斗数据.战斗类型)]
	if fun ~= nil then
		fun(id组,失败id,是否逃跑,战斗数据)
	else

		for i=1,#id组 do
			if id组[i]~=nil and 玩家数据[id组[i]]~=nil then 玩家数据[id组[i]].zhandou = 0 end
			if id组[i]~=失败id then
				if 玩家数据[战斗数据.进入战斗玩家id].连接id~="zhuzhan" and 玩家数据[战斗数据.进入战斗玩家id].角色.等级~=nil and 玩家数据[战斗数据.进入战斗玩家id].角色.等级>10 and not 玩家数据[战斗数据.进入战斗玩家id].角色.武神坛角色 then
					战斗数据:扣除经验(id组[i],0.085)
					战斗数据:扣除银子(id组[i],0.075)
					战斗数据:死亡对话(id组[i])
				end
			else
				if 玩家数据[战斗数据.进入战斗玩家id].连接id~="zhuzhan" and 失败id==战斗数据.进入战斗玩家id and 玩家数据[战斗数据.进入战斗玩家id]~=nil and not 玩家数据[战斗数据.进入战斗玩家id].角色.武神坛角色 then
					if not 是否逃跑 and not biwu then
						if 玩家数据[战斗数据.进入战斗玩家id].角色.等级~=nil and 玩家数据[战斗数据.进入战斗玩家id].角色.等级>10 then
							战斗数据:扣除经验(失败id,0.085)
							战斗数据:扣除银子(失败id,0.075)
							地图处理类:跳转地图(失败id,1125,35,26) --死亡跳转地府
							战斗数据:死亡对话(失败id)
						end
					end
				end
			end
		end
	end
	if 战斗数据.任务id==nil or 任务数据[战斗数据.任务id]==nil then return  end
	任务数据[战斗数据.任务id].zhandou=nil --识别后统一清空，任务怪的战斗
end

return 战斗失败