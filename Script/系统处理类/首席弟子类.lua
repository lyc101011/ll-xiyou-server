-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:44
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-09-02 20:03:49

local 首席弟子类 = class()
local 门派编号 = {女儿村=1,神木林=2,大唐官府=3,化生寺=4,方寸山=5,盘丝洞=6,无底洞=7,狮驼岭=8,魔王寨=9,阴曹地府=10,普陀山=11,天宫=12,凌波城=13,五庄观=14,龙宫=15}
function 首席弟子类:初始化()
end

function 首席弟子类:数据处理(连接id,序号,内容)
	local 数字id = 内容.数字id+0
	if 序号 ==6301 then
		self:投票(连接id,数字id,内容)

	elseif 序号 ==6302 then
		if 玩家数据[数字id+0] then
			local TM1=math.abs(os.time()-内容.时间)
			local CHA=math.abs(TM1-玩家数据[数字id+0].WG1)    --报错
				--1.  如果一直在增长那么就是开挂，不是一直在涨，那么就=
			if CHA>5 then
				if not 玩家数据[数字id+0].WG2 then
						   玩家数据[数字id+0].WG2=CHA --记录这个差
				else
					if CHA==玩家数据[数字id+0].WG2 then --如果这个差，没上涨  那么可能不是开挂
						玩家数据[数字id+0].WG2=nil --重置
						玩家数据[数字id+0].WG1=TM1  --重置
					elseif CHA>玩家数据[数字id+0].WG2 then --判断是否一直在增长，增长，那么就很有可能开了
						发送数据(连接id,998,"请注意你的角色异常！请与管理员联系")
					end
				end
			end
		end
	elseif 序号 ==6303 then
		玩家数据[数字id+0].WG1=math.abs(os.time()-内容.时间)
	end
end

function 首席弟子类:地图加载首席(sj)
	-- for i=1,#sj do
	--     local 任务id=取随机数(1999,11111).."_"..506+i.."_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
	--     任务数据[任务id]={
	--       id=任务id,
	--       起始=os.time(),
	--       结束=99999999,
	--       名称=sj[i].名称,
	--       模型=sj[i].模型,
	--       称谓=sj[i].称谓,
	--       方向=sj[i].方向,
	--       染色方案=sj[i].染色方案,
	--       染色组=sj[i].染色组,
	--       炫彩=sj[i].炫彩,
	--       炫彩组=sj[i].炫彩组,
	--       武器=sj[i].武器,
	--       门派=sj[i].门派,
	--       等级=50,
	--       x=sj[i].x,
	--       y=sj[i].y,
	--       地图编号=sj[i].地图编号,
	--       地图名称=取地图名称(sj[i].地图编号),
	--       类型=506+i
	--     }
	--     地图处理类:添加单位(任务id)
	-- end
end

function 首席弟子类:开启首席竞选()
	-- 首席竞选数据 = {}
	-- 首席竞选数据.开启= true
	-- for i=1,#Q_门派编号 do
	-- 	首席竞选数据[Q_门派编号[i]] = {}
	-- 	首席竞选数据[Q_门派编号[i]].竞选名单 = {}
	-- 	首席竞选数据[Q_门派编号[i]].投票名单 = {}
	-- 	首席竞选数据[Q_门派编号[i]].挑战名单 = {}
	-- 	首席竞选数据[Q_门派编号[i]].竞选ID ={}
	-- end
	-- 广播消息({内容="#G/每周一次的首席竞选现在开始了，需要竞选首席的玩家前往各自门派大弟子参加",频道="xt"})
end

function 首席弟子类:竞选首席(数字id)
	-- local mp = 玩家数据[数字id].角色.门派
	-- if 首席竞选数据[mp].竞选ID[数字id] == nil then
	-- 	local bh = #首席竞选数据[玩家数据[数字id].角色.门派].竞选名单+1
	-- 	首席竞选数据[mp].竞选ID[数字id] = 1
	-- 	首席竞选数据[mp].竞选名单[bh] = {}
	-- 	首席竞选数据[mp].竞选名单[bh].名称 = 玩家数据[数字id].角色.名称
	-- 	首席竞选数据[mp].竞选名单[bh].模型 = 玩家数据[数字id].角色.模型
	-- 	首席竞选数据[mp].竞选名单[bh].称谓 = 玩家数据[数字id].角色.门派.."首席弟子"
	-- 	首席竞选数据[mp].竞选名单[bh].染色方案 = 玩家数据[数字id].角色.染色方案
	-- 	首席竞选数据[mp].竞选名单[bh].染色组 = 玩家数据[数字id].角色.染色组
	-- 	首席竞选数据[mp].竞选名单[bh].炫彩 = 玩家数据[数字id].角色.炫彩
	-- 	首席竞选数据[mp].竞选名单[bh].炫彩组 = 玩家数据[数字id].角色.炫彩组
	-- 	首席竞选数据[mp].竞选名单[bh].等级 = 玩家数据[数字id].角色.等级
	-- 	首席竞选数据[mp].竞选名单[bh].数字id = 数字id
	-- 	首席竞选数据[mp].竞选名单[bh].得分 = 0
	-- 	首席竞选数据[mp].竞选名单[bh].竞选词 = "请大家多多支持"
	-- 	if 玩家数据[数字id].角色.装备[3] ~= nil then
	-- 		首席竞选数据[mp].竞选名单[bh].武器 = 玩家数据[数字id].道具.数据[玩家数据[数字id].角色.装备[3]].名称
	-- 	end
	-- 	闪烁消息(数字id,"你成功参加了首席弟子竞选，现在给你自己拉票吧")
	-- else
	-- 	常规提示(数字id,"#Y/你已经竞选过首席弟子了")
	-- end
end

function 首席弟子类:投票(连接id,数字id,内容)
	-- local mp = 玩家数据[数字id].角色.门派
	-- if 首席竞选数据[mp].竞选名单[内容.序号] ~= nil then
	-- 	if 首席竞选数据[mp].投票名单[数字id] == nil then
	-- 		首席竞选数据[mp].投票名单[数字id] = 1
	-- 	else
	-- 		常规提示(数字id,"#Y/你已经投票了")
	-- 	end
	-- 	首席竞选数据[mp].竞选名单[内容.序号].得分 = 首席竞选数据[mp].竞选名单[内容.序号].得分 +1
	-- end
end

function 首席弟子类:特殊投票(连接id,数字id,内容)
	-- local mp = 玩家数据[数字id].角色.门派
	-- if 首席竞选数据[mp].竞选名单[内容.序号] ~= nil then
	-- 	if 首席竞选数据[mp].投票名单[数字id] == nil then
	-- 		首席竞选数据[mp].投票名单[数字id] = 1
	-- 	else
	-- 		常规提示(数字id,"#Y/你已经投票了")
	-- 	end
	-- 	首席竞选数据[mp].竞选名单[内容.序号].得分 = 首席竞选数据[mp].竞选名单[内容.序号].得分 +10
	-- end
end

function 首席弟子类:挑战首席(数字id)
	-- local mp = 玩家数据[数字id].角色.门派
	-- if 首席竞选数据[mp].挑战名单[数字id] == nil then
	-- 	首席竞选数据[mp].挑战名单[数字id] = 1
	-- 	常规提示(数字id,"#Y/你挑战成功了门派首席可以竞选大弟子了")
	-- end
end

function 首席弟子类:我要投票(数字id)
	-- local mp = 玩家数据[数字id].角色.门派
	-- table.sort(首席竞选数据[mp].竞选名单,function(a,b)return a.得分>b.得分 end )
	-- 发送数据(玩家数据[数字id].连接id,6301,首席竞选数据[mp].竞选名单)
end

function 取编号(mp)
	return  门派编号[mp]
end

function 首席弟子类:结束首席竞选()
	-- 首席竞选数据.开启 = false
	-- for k,v in pairs(首席竞选数据) do
	-- 	if k ~= "开启" then
	-- 		table.sort(首席竞选数据[k].竞选名单,function(a,b)return a.得分>b.得分 end )
	-- 		if 首席竞选数据[k].竞选名单[1] ~= nil then
	-- 			local bh = 取编号(k)
	-- 			self:删除称谓(首席数据[bh].数字id,k.."首席弟子")
	-- 			首席数据[bh].名称 = 首席竞选数据[k].竞选名单[1].名称
	-- 			首席数据[bh].模型 = 首席竞选数据[k].竞选名单[1].模型
	-- 			首席数据[bh].称谓 = 首席竞选数据[k].竞选名单[1].称谓
	-- 			首席数据[bh].染色方案 = 首席竞选数据[k].竞选名单[1].染色方案
	-- 			首席数据[bh].染色组 = 首席竞选数据[k].竞选名单[1].染色组
	-- 			首席数据[bh].等级 = 首席竞选数据[k].竞选名单[1].等级
	-- 			首席数据[bh].炫彩 = 首席竞选数据[k].竞选名单[1].炫彩
	-- 			首席数据[bh].炫彩组 = 首席竞选数据[k].竞选名单[1].炫彩组
	-- 			首席数据[bh].数字id = 首席竞选数据[k].竞选名单[1].数字id
	-- 			首席数据[bh].武器 = 首席竞选数据[k].竞选名单[1].武器
	-- 			self:添加称谓(首席数据[bh].数字id,k.."首席弟子")
	-- 		end
	-- 	end
	-- end
	-- for n, v in pairs(任务数据) do
	-- 	if 任务数据[n]~=nil then
	-- 		if 任务数据[n].类型>= 507 and 任务数据[n].类型<=  522  then
	-- 			地图处理类:删除单位(任务数据[n].地图编号,任务数据[n].单位编号)
	-- 		end
	-- 	end
	-- end
	-- self:地图加载首席(首席数据)
	-- 广播消息({内容="#G/每周一次的首席竞选现在结束",频道="xt"})
end

function 首席弟子类:删除称谓(数字id,称谓)
	-- if 数字id ~= nil then
	-- 	if 玩家数据[数字id] ~= nil then
	-- 		玩家数据[数字id].角色:删除称谓(称谓)
	-- 		闪烁消息(数字id,"你在本次首席弟子竞选中失利系统回收了你的门派首席弟子称谓")
	-- 	else
	-- 		local sj = 取userdata表(数字id)
	-- 		sj1=table.loadstring(sj.称谓)
	-- 		sj2 = sj.当前称谓
	-- 		local fhz = 0
	-- 		for i=1,#sj1 do
	-- 			if sj1[i] ==  称谓 then
	-- 				fhz = i
	-- 			end
	-- 		end
	-- 		if fhz ~= 0 then
	-- 			table.remove(sj1,fhz)
	-- 			if sj2 == 称谓 then sj2 = "明月楼" end
	-- 			m:执行SQL(string.format("update userdata set 称谓 = '%s',当前称谓 = '%s' where  szid='%s'",table.tostring(sj1),sj2,数字id))
	-- 		end
	-- 		闪烁消息(数字id,"你在本次首席弟子竞选中失利系统回收了你的门派首席弟子称谓")
	-- 	end
	-- end
end

function 首席弟子类:添加称谓(数字id,称谓)
	-- if 数字id ~= nil then
	-- 	if 玩家数据[数字id] ~= nil then
	-- 		玩家数据[数字id].角色:添加称谓(称谓)
	-- 		闪烁消息(数字id,"恭喜你在本次的首席弟子竞选中脱颖而出获得了门派首席弟子的称谓")
	-- 	else
	-- 		local sj = 取userdata表(数字id)
	-- 		sj1=table.loadstring(sj.称谓)
	-- 		local fhz = false
	-- 		for i=1,#sj1 do
	-- 			if sj1[i] ==  称谓 then
	-- 				fhz = true
	-- 			end
	-- 		end
	-- 		if fhz == false then
	-- 			table.insert(sj1,fhz)
	-- 			sj2 = 称谓
	-- 			if sj2 == 称谓 then sj2 = "明月楼" end
	-- 			m:执行SQL(string.format("update userdata set 称谓 = '%s',当前称谓 = '%s' where  szid='%s'",table.tostring(sj1),sj2,数字id))
	-- 		end
	-- 		闪烁消息(数字id,"恭喜你在本次的首席弟子竞选中脱颖而出获得了门派首席弟子的称谓")
	-- 	end
	-- end
end

return 首席弟子类