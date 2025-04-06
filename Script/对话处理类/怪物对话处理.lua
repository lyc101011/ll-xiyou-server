-- @Author: baidwwy
-- @Date:   2024-11-14 12:45:49
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-01-06 08:34:11
-- @Author: baidwwy
-- @Date:   2024-08-21 11:47:39
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-20 13:47:22
-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-07-31 20:57:55

local 场景类_GW活动对话 = class()
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数
local 五行_ = {"金","木","水","火","土"}
sdfetewtew={}
sdfetewtew[1132]=1
sdfetewtew[1133]=1
sdfetewtew[1134]=1
sdfetewtew[1135]=1
sdfetewtew[1136]=1
sdfetewtew[1137]=1
sdfetewtew[1138]=1
sdfetewtew[1139]=1
sdfetewtew[1140]=1
sdfetewtew[1141]=1
sdfetewtew[1142]=1
sdfetewtew[1143]=1
sdfetewtew[1144]=1
sdfetewtew[1145]=1
sdfetewtew[1146]=1
sdfetewtew[1147]=1
sdfetewtew[1148]=1
sdfetewtew[1149]=1
sdfetewtew[1150]=1

sdfetewtew[206]=1
sdfetewtew[748]=1
sdfetewtew[749]=1
sdfetewtew[750]=1
sdfetewtew[2060]=1

sdfetewtew[1301]=1
sdfetewtew[1302]=1
sdfetewtew[1303]=1
sdfetewtew[1304]=1
sdfetewtew[1305]=1
sdfetewtew[1306]=1
sdfetewtew[1307]=1
sdfetewtew[1308]=1
sdfetewtew[1309]=1
sdfetewtew[1310]=1
sdfetewtew[1311]=1

sdfetewtew[1187]=1----圣兽青龙 --别忘
sdfetewtew[1188]=1
sdfetewtew[1189]=1
sdfetewtew[1190]=1

sdfetewtew[1171]=1   --自学活动1185
sdfetewtew[1172]=1
sdfetewtew[1173]=1
sdfetewtew[1174]=1
sdfetewtew[1175]=1
sdfetewtew[1176]=1
sdfetewtew[1185]=1
sdfetewtew[1186]=1
sdfetewtew[1187.0]=1--宝石怪
sdfetewtew[1187.1]=1
sdfetewtew[1187.2]=1
sdfetewtew[1187.3]=1
sdfetewtew[1187.4]=1
sdfetewtew[1187.5]=1
sdfetewtew[1187.6]=1
sdfetewtew[1187.7]=1


sdfetewtew[207]=1   --标王
sdfetewtew[108]=1
sdfetewtew[1202]=1
sdfetewtew[1203]=1
sdfetewtew[1204]=1
sdfetewtew[1205]=1
sdfetewtew[1206]=1
sdfetewtew[1207]=1
sdfetewtew[1208]=1
sdfetewtew[1209]=1
sdfetewtew[1210]=1

sdfetewtew[691]=1
sdfetewtew[692]=1
sdfetewtew[693]=1
sdfetewtew[694]=1
sdfetewtew[695]=1
sdfetewtew[696]=1
sdfetewtew[697]=1
sdfetewtew[698]=1
sdfetewtew[699]=1
sdfetewtew[700]=1
sdfetewtew[104]=1

sdfetewtew[1313]=1
sdfetewtew[1314]=1
sdfetewtew[1315]=1
sdfetewtew[1316]=1
sdfetewtew[1317]=1
sdfetewtew[1318]=1
sdfetewtew[1319]=1
sdfetewtew[1320]=1
sdfetewtew[1321]=1

sdfetewtew[710]=1
sdfetewtew[711]=1
sdfetewtew[712]=1
sdfetewtew[713]=1
sdfetewtew[714]=1
sdfetewtew[715]=1
sdfetewtew[716]=1
sdfetewtew[717]=1
sdfetewtew[718]=1
sdfetewtew[719]=1

sdfetewtew[800]=1
sdfetewtew[801]=1
sdfetewtew[802]=1
sdfetewtew[803]=1
sdfetewtew[804]=1
sdfetewtew[805]=1
sdfetewtew[806]=1
sdfetewtew[807]=1
sdfetewtew[808]=1
sdfetewtew[809]=1
sdfetewtew[810]=1
sdfetewtew[811]=1
sdfetewtew[812]=1
sdfetewtew[813]=1
sdfetewtew[814]=1
sdfetewtew[815]=1
sdfetewtew[816]=1
sdfetewtew[817]=1
sdfetewtew[818]=1
sdfetewtew[819]=1
sdfetewtew[820]=1

sdfetewtew[1182]=1
sdfetewtew[1177]=1
sdfetewtew[1178]=1
sdfetewtew[1179]=1
sdfetewtew[1180]=1
sdfetewtew[1181]=1
sdfetewtew[3487]=1 --沉默分身
sdfetewtew[3488]=1 --比武
sdfetewtew[3490]=1 --黑神话

function 场景类_GW活动对话:初始化() end

function 场景类_GW活动对话:活动选项解析(连接id,数字id,序号,内容)

	if 任务数据[玩家数据[数字id].地图单位.标识] == nil then
		常规提示(数字id,"#Y/这只是个虚影")
		return
	end
	local 对话数据
	local rwid=玩家数据[数字id].地图单位.标识
 	local 类型=任务数据[rwid].类型
 	local 事件=内容[1]
 	local 名称=内容[3]

 	if 取队长权限(数字id)==false then return  end
 	if sdfetewtew[类型] then
 	      self:活动对话CL(数字id,名称,事件,类型,rwid)
	else
	 -- 	local fun = _G["怪物对话解析"..tostring(类型)]
		-- if 类型 >= 507 and 类型<= 522 then
		-- 	fun = _G["怪物对话解析"..tostring(508)]
		-- end
		-- if fun ~= nil  then
		-- 	对话数据 = fun(连接id,数字id,序号,内容)
		-- end
		local num=类型
		if 类型 >= 507 and 类型<= 522 then
			num=508
		end
		if __GWdh222[num] then
			对话数据 =  __GWdh222[num](连接id,数字id,序号,内容)
		end
	end
	if 对话数据 ~= nil then
		发送数据(连接id,1501,对话数据)
	end
end
function 场景类_GW活动对话:活动对话CL(数字id,名称,事件,类型,rwid)

-- 	.1 [把东西交给我]
-- .2 [1343]
-- .3 [宝石怪]
-- .ip [127.0.0.1]
-- .ID [573270]
-- .时间 [1731557959]
-- .数字id [10011]
-- .序号 [584783]
-- .效验码 [df01a0099f81234859186df4daaed67d]

	if 类型 >= 1132 and 类型<= 1150 then
		降妖伏魔:对话事件处理(数字id,名称,事件,类型,rwid)
	elseif 类型 == 3487 then --沉默分身
	    沉默分身类:沉默分身对话事件处理(数字id,名称,事件,类型,rwid)
	elseif 类型 == 3490 then
		黑神话:对话事件处理(数字id,名称,事件,类型,rwid)
	elseif 类型 == 206 then
		地煞星:对话事件处理(数字id,名称,事件,类型,rwid)
	elseif 类型 == 748 then
		天罡星:对话事件处理(数字id,名称,事件,类型,rwid)
	-- elseif 类型 == 749 then
	-- 	天罡星:三BOSS对话事件处理(数字id,名称,事件,类型,rwid)
	-- elseif 类型 == 750 then
	-- 	天罡星:头领对话事件处理(数字id,名称,事件,类型,rwid)
	elseif 类型 >= 1301 and 类型<= 1311 then
		帮派迷宫:对话事件处理(数字id,名称,事件,类型)
	elseif 类型 >= 1171 and 类型<= 1175 then
		投放怪:对话事件处理(数字id,名称,事件,类型)
	elseif 类型 >= 1176 and 类型<= 1199 then--宝石怪
		自写活动:对话事件处理(数字id,名称,事件,类型)
	elseif 类型==207 then
		镖王任务:对话事件处理(数字id,名称,事件,类型)
	elseif 类型==108 then
		游泳活动:对话事件处理(数字id,名称,事件,类型)
	elseif 类型 >= 1202 and 类型<= 1210 then
		帮派PK:怪物对话处理(数字id,名称,事件,类型,rwid)
	elseif 类型>=691 and 类型<= 700 then
		副本_一斛珠:对话事件处理(数字id,名称,事件,类型)
	elseif 类型==104 then
		二八星宿:怪物对话处理(数字id,名称,事件,类型,rwid)
	elseif 类型 >= 1313 and 类型<= 1321 then
		长安保卫战:怪物对话处理(数字id,名称,事件,类型,rwid)
	elseif 类型>=710 and 类型<= 719 then
		副本_通天河:对话事件处理(数字id,名称,事件,类型)
	elseif 类型>=800 and 类型<= 820 then
		副本_双城记:对话事件处理(数字id,名称,事件,类型)
	elseif 类型 == 3488 then --比武
	    比武大会:比武假人对话事件处理(数字id,名称,事件,类型,rwid)
	end
end
return 场景类_GW活动对话