-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:44
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-10-24 07:51:00

function 取随机法术(数量)
	local 法术={"荆棘舞","水攻","雷击","烈火","落岩","奔雷咒","碎星诀","推气过宫","金刚护体","落叶萧萧","裂石","地涌金莲","推拿","夺魄令","地涌金莲","催眠符","失心符","含情脉脉","似玉生香","横扫千军","唧唧歪歪","金刚护法","五雷咒","龙卷雨击","浪涌","龙吟","龙腾","天雷斩","烟雨剑法","五雷轰顶","飞砂走石","三昧真火","狮搏","鹰击","连环击","超级三昧真火"}
	local 返回组={}
	for n=1,数量 do
		返回组[n]=法术[取随机数(1,#法术)]
	end
	return 返回组
end

function 取随机法术1(数量)
	local 法术={"横扫千军","唧唧歪歪","金刚护法","五雷咒","雨落寒沙","龙卷雨击","龙吟","龙腾","天雷斩","苍茫树","地裂火","靛沧海","日光华","紧箍咒","烟雨剑法","五雷轰顶","飞砂走石","三昧真火","狮搏","鹰击","连环击","天罗地网","阎罗令","判官令","尸腐毒"}
	local 返回组={}
	for n=1,数量 do
		返回组[n]=法术[取随机数(1,#法术)]
	end
	return 返回组
end

function 取法术技能(jn)
	local jns = {}
	for k,v in pairs(技能信息) do
		if 技能信息[k].名称==jn and 技能信息[k].门派 ~= "子女" then
			jns[1] =技能信息[k].功效
			jns[3] =技能信息[k].使用类型
			jns[4] =技能信息[k].消耗
		end
	end
	return jns
end
-- local xxx = "龙卷雨击"
-- local 战斗技能表 = {
-- 	龙卷雨击 = {
-- 	    使用对象=4,
-- 		使用前CD=0,
-- 		使用后CD=0,
-- 		技能类型="法攻技能",
-- 		技能人数 = function(lv)
-- 		    if lv >= 150 then
-- 		        return 7
-- 	        elseif lv >= 125 then
-- 		        return 6
-- 	        elseif lv >= 100 then
-- 		        return 5
-- 	        elseif lv >= 75 then
-- 		        return 4
-- 	        elseif lv >= 50 then
-- 		        return 3
-- 		    else
-- 		        return 2
-- 		    end
-- 		end,
-- 		技能消耗 = function(num)
-- 			return  20*num
-- 		end,
-- 		伤害公式 = function(灵力,a,b)
-- 			return 100
-- 		end
-- 	},
-- }
-- local 法术技能特效 = class()
-- function 法术技能特效:初始化()
-- 	self.数据={
-- 	龙卷雨击 = {
-- 	    使用对象=4,
-- 		使用前CD=0,
-- 		使用后CD=0,
-- 		技能类型="法攻技能",
-- 		技能人数 = function(lv,条件)
-- 			local num = 0
-- 		    if lv >= 150 then
-- 		        num =  7
-- 	        elseif lv >= 125 then
-- 		        return 6
-- 	        elseif lv >= 100 then
-- 		        return 5
-- 	        elseif lv >= 75 then
-- 		        return 4
-- 	        elseif lv >= 50 then
-- 		        return 3
-- 		    else
-- 		        return 2
-- 		    end
-- 		    if 条件 === XXX then
--         		num = num + 2
-- 		    end
-- 		end,
-- 		技能消耗 = function(num)
-- 			return  20*num
-- 		end,
-- 		技能伤害 = function(lv)
-- 			return  lv * 2 + 56
-- 		end
-- 	},
-- }
-- end

-- -- 基础攻击  =
-- -- 伤害差 =  （攻击（技能等级*1+本身攻击 +  buff ） - 防御 ） * 技能系数（70% 90% 130%） * 修炼差
-- -- 基础伤害 ==   暴击  》 百分比减伤  百分比加伤  ====》 固定数值加 减
-- -- -- 法术
-- -- 基础伤害 * 修炼差
-- -- 基础伤害 == 暴击 》 百分比减伤  百分比加伤  ====》 固定数值加 减

-- function 法术技能特效:取技能人数(jnname,lv)
-- 	if self.数据[jnname]~=nil then
-- 		if lv==nil then
-- 		    lv = 0
-- 		end
-- 		return self.数据[jnname].技能人数(lv)
-- 	end
-- 	return false
-- end
-- function 法术技能特效:更新(dt)
-- end
-- function 法术技能特效:显示()
-- end
-- return 法术技能特效