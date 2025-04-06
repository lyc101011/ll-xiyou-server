-- @Author: baidwwy
-- @Date:   2024-11-14 12:45:49
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-01-06 08:34:26
-- @Author: baidwwy
-- @Date:   2024-11-14 12:45:49
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-20 16:33:15
-- @Author: baidwwy
-- @Date:   2024-08-21 11:47:39
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-19 08:55:20
-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-08-13 12:18:49
-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-07-31 20:58:02

local 场景类_GW单位对话 = class()
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数
local 五行_ = {"金","木","水","火","土"}
trhrtutru={}
trhrtutru[1132]=1
trhrtutru[1133]=1
trhrtutru[1134]=1
trhrtutru[1135]=1
trhrtutru[1136]=1
trhrtutru[1137]=1
trhrtutru[1138]=1
trhrtutru[1139]=1
trhrtutru[1140]=1
trhrtutru[1141]=1
trhrtutru[1142]=1
trhrtutru[1143]=1
trhrtutru[1144]=1
trhrtutru[1145]=1
trhrtutru[1146]=1
trhrtutru[1147]=1
trhrtutru[1148]=1
trhrtutru[1149]=1
trhrtutru[1150]=1

trhrtutru[206]=1
trhrtutru[748]=1
trhrtutru[749]=1
trhrtutru[750]=1

--自写活动
trhrtutru[1186]=1
trhrtutru[1176]=1
trhrtutru[1177]=1
trhrtutru[1178]=1
trhrtutru[1179]=1
trhrtutru[1180]=1
trhrtutru[1181]=1
trhrtutru[1185]=1

trhrtutru[1187]=1---------圣兽青龙 别忘加
trhrtutru[1188]=1---------圣兽青龙 别忘加
trhrtutru[1189]=1---------圣兽青龙 别忘加
trhrtutru[1190]=1---------圣兽青龙 别忘加

trhrtutru[1187.0]=1
trhrtutru[1187.1]=1
trhrtutru[1187.2]=1
trhrtutru[1187.3]=1
trhrtutru[1187.4]=1
trhrtutru[1187.5]=1
trhrtutru[1187.6]=1
trhrtutru[1187.7]=1---------宝石怪

trhrtutru[1301]=1
trhrtutru[1302]=1
trhrtutru[1303]=1
trhrtutru[1304]=1
trhrtutru[1305]=1
trhrtutru[1306]=1
trhrtutru[1307]=1
trhrtutru[1308]=1
trhrtutru[1309]=1
trhrtutru[1310]=1
trhrtutru[1311]=1

trhrtutru[1171]=1
trhrtutru[1172]=1
trhrtutru[1173]=1
trhrtutru[1174]=1
trhrtutru[1175]=1

trhrtutru[207]=1  --标王
trhrtutru[108]=1   --游泳
trhrtutru[1202]=1
trhrtutru[1203]=1
trhrtutru[1204]=1
trhrtutru[1205]=1
trhrtutru[1206]=1
trhrtutru[1207]=1
trhrtutru[1208]=1
trhrtutru[1209]=1
trhrtutru[1210]=1

trhrtutru[691]=1
trhrtutru[692]=1
trhrtutru[693]=1
trhrtutru[694]=1
trhrtutru[695]=1
trhrtutru[696]=1
trhrtutru[697]=1
trhrtutru[698]=1
trhrtutru[699]=1
trhrtutru[700]=1

trhrtutru[104]=1
trhrtutru[106]=1
trhrtutru[6674]=1
trhrtutru[1159]=1

trhrtutru[1312]=1
trhrtutru[1313]=1
trhrtutru[1314]=1
trhrtutru[1315]=1

trhrtutru[710]=1
trhrtutru[711]=1
trhrtutru[712]=1
trhrtutru[713]=1
trhrtutru[714]=1
trhrtutru[715]=1
trhrtutru[716]=1
trhrtutru[717]=1
trhrtutru[718]=1
trhrtutru[719]=1

trhrtutru[800]=1
trhrtutru[801]=1
trhrtutru[802]=1
trhrtutru[803]=1
trhrtutru[804]=1
trhrtutru[805]=1
trhrtutru[806]=1
trhrtutru[807]=1
trhrtutru[808]=1
trhrtutru[809]=1
trhrtutru[810]=1
trhrtutru[811]=1
trhrtutru[812]=1
trhrtutru[813]=1
trhrtutru[814]=1
trhrtutru[815]=1
trhrtutru[816]=1
trhrtutru[817]=1
trhrtutru[818]=1
trhrtutru[819]=1
trhrtutru[820]=1
trhrtutru[1182]=1
trhrtutru[3487]=1 --沉默分身
trhrtutru[3488]=1 --比武
trhrtutru[3490]=1 --黑神话
function 场景类_GW单位对话:初始化()
end

function 场景类_GW单位对话:地图单位对话(连接id,数字id,序列,标识,地图) --怪物对话

	local 类型=任务数据[标识].类型
	if 类型==103 then  return end
	if 玩家数据[数字id].zhandou~=0 then return  end
	玩家数据[数字id].地图单位={地图=地图,标识=标识,编号=序列,清空=true}
	local 对话数据={}
	if trhrtutru[类型] then
 	      对话数据=self:活动对话NR(数字id,序列,标识,地图,类型)
	else
		local num=类型
		if 类型 >= 507 and 类型<= 522 then
			num=508
		end
		if __GWdh111[num] then
			对话数据 =  __GWdh111[num](连接id,数字id,序列,标识,地图)
		else
			对话数据.模型=任务数据[标识].模型
			对话数据.名称=任务数据[标识].名称
		end
	end
	if 对话数据 ~= nil then
		if 玩家数据[数字id].地图单位 ~= nil then
			玩家数据[数字id].地图单位.对话={模型=对话数据.模型,名称=对话数据.名称}
		end
		玩家数据[数字id].最后对话={模型=对话数据.模型,名称=对话数据.名称}
	end
	发送数据(连接id,1501,对话数据)
end
function 场景类_GW单位对话:活动对话NR(数字id,序列,标识,地图,类型)

	local 对话数据={}
	if 类型 >= 1132 and 类型<= 1150 then
	    对话数据 = 降妖伏魔:怪物对话内容(数字id,序列,标识,地图)
	elseif 类型 == 3487 then
	   对话数据 = 沉默分身类:沉默分身对话内容(数字id,类型,标识,地图)
	elseif 类型 == 3490 then
		对话数据 = 黑神话:怪物对话内容(数字id,序列,标识,地图)
	elseif 类型 == 206 then
		对话数据 = 地煞星:怪物对话内容(数字id,序列,标识,地图)
	elseif 类型 == 748 then
		对话数据 = 天罡星:怪物对话内容(数字id,序列,标识,地图)
	-- elseif 类型 == 749 then
	-- 	对话数据 = 天罡星:三BOSS对话内容(数字id,序列,标识,地图)
	-- elseif 类型 == 750 then
	-- 	对话数据 = 天罡星:头领对话内容(数字id,序列,标识,地图)
	 elseif 类型 ==6674 or 类型 ==1159 then
		 对话数据 = 彩虹争霸:怪物的对话(数字id,序列,标识,地图)
	elseif 类型 >= 1301 and 类型<= 1311 then
		对话数据 = 帮派迷宫:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型 == 106 then
		对话数据 = 门派闯关:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型 == 207 then
		对话数据 = 镖王任务:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型 == 108 then
		对话数据 = 游泳活动:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型 >= 1171 and 类型<= 1175 then
		对话数据 = 投放怪:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型 >= 1176 and 类型<= 1199  then

		对话数据 = 自写活动:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型 >= 1202 and 类型<= 1210 then
		对话数据 = 帮派PK:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型 >= 691 and 类型<= 700 then
		对话数据 = 副本_一斛珠:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型==104 then
		对话数据 = 二八星宿:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型 >= 1312 and 类型<= 1315 then
		对话数据 = 长安保卫战:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型>=710 and 类型<= 719 then
		对话数据 = 副本_通天河:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型>=800 and 类型<= 820 then
		对话数据 = 副本_双城记:怪物对话内容(数字id,类型,标识,地图)
	elseif 类型 == 3488 then --比武
	   对话数据 = 比武大会:比武假人对话内容(数字id,类型,标识,地图)
	end
	return 对话数据
end
function 场景类_GW单位对话:获取任务对话(x,y)end
return 场景类_GW单位对话