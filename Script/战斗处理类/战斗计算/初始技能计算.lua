-- @Author: baidwwy
-- @Date:   2024-04-14 22:24:27
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-06 21:45:19
-- @Author: baidwwy
-- @Date:   2024-03-05 15:36:07
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-05-02 01:34:50
-- @Author: baidwwy
-- @Date:   2023-09-29 08:45:32
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2023-10-12 21:27:54
-- @Author: baidwwy
-- @Date:   2023-09-29 08:45:32
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2023-10-01 18:23:56
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-03-04 17:57:14
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-09-28 19:07:39
local 初始技能计算 = class()
local jhf = string.format
local random = math.random
local qz=math.floor
local sj = 取随机数

function 初始技能计算:初始化() end

function 初始技能计算:技能消耗(战斗数据,攻击方,数值,类型,名称)
	-- local go=true
	-- if go then
	--     return true --测试模式
	-- end
	-- if 攻击方.分类 ~= nil and 攻击方.分类 == "野怪" then
	-- 	return true
	-- end
		if 名称 == "幻镜术" then
		return self:愤怒消耗(战斗数据,数值,攻击方,名称)
end

	-- if 攻击方.队伍==0 or 调试模式 then
	-- 	if 类型=="战意" then
	-- 		local sl = 1
	-- 		if 名称=="天崩地裂" then
	-- 			sl = 3
	-- 		elseif 名称=="惊涛怒" or 名称=="断岳势" or 名称=="腾雷" then
	-- 			sl = 1
	-- 		elseif 名称=="翻江搅海" then
	-- 			sl = 3
	-- 		end
	-- 		攻击方.战意 = 攻击方.战意 - sl
	-- 		if 攻击方.战意<0 then
	-- 		    攻击方.战意=0
	-- 		end
	-- 	end
	--     return true
	-- end
	if 类型=="魔法" then
		return self:魔法消耗(战斗数据,攻击方, 数值 ,名称)
	elseif 类型=="魔法和气血" then --这个后面要归并成魔法
    	return self:魔法消耗(战斗数据,攻击方, 数值 ,名称)
	elseif 类型=="气血" then
		return true
	elseif 类型=="战意" then
		return self:战意消耗(战斗数据,攻击方,数值,名称)
	elseif 类型=="特技消耗" then
		return self:特技消耗(战斗数据,数值, 攻击方,名称)
	elseif 类型=="无消耗" then --气血啥的都写这
		return true
	elseif 类型=="魔法和愤怒" then
		if 名称 == "风雷韵动" then
			return self:消耗魔法和愤怒(战斗数据, 攻击方,  60, 10, 名称)
		elseif 名称 == "魍魉追魂" then
			return self:消耗魔法和愤怒(战斗数据, 攻击方,  100, 20, 名称)
		elseif 名称 == "子母神针" then
			return self:消耗魔法和愤怒(战斗数据, 攻击方,  35, 30, 名称)
		elseif 名称 == "谆谆教诲" then
			if 攻击方.法术状态.诵经 then
		    	    return self:消耗魔法和愤怒(战斗数据, 攻击方,  45+140, 20, 名称)
		    	end
		return self:消耗魔法和愤怒(战斗数据, 攻击方,  45, 20, 名称)
		elseif 名称 == "追魂刺" then
			if 战斗数据:取经脉(攻击方.序号, "无底洞", "弥愤") then
			     return self:消耗魔法和愤怒(战斗数据, 攻击方,  50, 0, 名称)
			else
			     return self:消耗魔法和愤怒(战斗数据, 攻击方,  50, 20, 名称)
			end
		elseif 名称 == "秘传三昧真火" then
			return self:消耗魔法和愤怒(战斗数据, 攻击方,  60, 0, 名称)
		elseif 名称 == "诸天看护" then
			return self:消耗魔法和愤怒(战斗数据,攻击方, 100, 10,名称)
		elseif 名称 == "秘传飞砂走石" then
			return self:消耗魔法和愤怒(战斗数据,攻击方, 120, 0,名称)
		end
		return false
	elseif 类型=="木精" then
		if 名称 == "古藤秘咒" then
			return self:魔法和木精消耗(战斗数据, 攻击方,  数值, 2, 名称)
		elseif 名称 == "疾风秋叶" then
			if 战斗数据:取经脉(攻击方.序号, "神木林", "凉秋") then
			    return self:魔法和木精消耗(战斗数据, 攻击方,  数值, 2, 名称)
			else
				return self:魔法和木精消耗(战斗数据, 攻击方,  数值, 1, 名称)
			end
		elseif 名称 == "枯木逢春" then
			return self:魔法和木精消耗(战斗数据, 攻击方,  数值, 3, 名称)
		end
	elseif 类型=="金鸦火羽（高级）" then --最后把化圣写了再搞
        return true
	elseif 类型=="愤怒" then
		return self:愤怒消耗(战斗数据,数值,攻击方,名称)
	elseif 类型=="风灵" then
		if 战斗数据:风灵消耗(攻击方,"毒萃",1)==1 then
		    return self:魔法消耗(战斗数据,攻击方, 数值 ,名称)
		end
	end
	return false
end

function 初始技能计算:战意消耗(战斗数据,攻击方,魔法,名称)
	if not self:魔法消耗(战斗数据,攻击方, 魔法 ,名称) then
		return false
	end
	local sl = 1
	if 名称=="天崩地裂" then
		sl = 3
	elseif 名称=="惊涛怒" or 名称=="断岳势" or 名称=="腾雷" then
		sl = 1
	elseif 名称=="翻江搅海" then
		sl = 3
	end

	if 攻击方.战意 < sl then
		return false
	end
	攻击方.战意 = 攻击方.战意 - sl
	if 战斗数据:取经脉(攻击方.序号,"凌波城","魂聚") then
		战斗数据:增加愤怒(攻击方.序号, 10)
	end
	if 攻击方.shenqi.name=="酣战" then
		战斗数据:添加状态("酣战",攻击方,攻击方,69)
	end
	return true
end

function 初始技能计算:取技能CD(战斗数据,攻击方,名称)
	local 返回参数 = false
	for k, v in pairs(攻击方.主动技能) do
		if v.名称 == 名称 then
			if v.剩余冷却回合 ~= nil then
				返回参数=false
			else
				v.剩余冷却回合=self:取使用后CD(战斗数据,攻击方,名称)
				返回参数=true
				break
			end
		end
	end
	return 返回参数
end

function 初始技能计算:取使用前CD(战斗数据,攻击方,名称)

	if 名称=="摧枯拉朽" then
	    return 15
    elseif 名称=="披挂上阵"  or 名称 == "耳目一新"  then
	    return 5
	elseif 名称== "观照万象" then
	    return 9
	elseif 名称== "惊天动地" then
	    return 2
	elseif 名称=="救死扶伤" and 战斗数据:取经脉(攻击方.序号, "化生寺", "心韧") then
	    return 4
	elseif 名称=="亢龙归海" or 名称=="魔焰滔天" or 名称=="风卷残云" or 名称=="威仪九霄"then
	    return 3
    elseif 名称=="风云变色" or 名称=="钟馗论道"  then
	    return 4
    elseif 名称=="绝命毒牙" or 名称 == "绝处逢生" or 名称 == "天神怒斩" then
	    return 5
    elseif 名称== "花谢花飞" then
    	return 8
    elseif 名称=="秘传三昧真火" or 名称=="秘传飞砂走石"  then
    	if 战斗数据:取经脉(攻击方.序号, "魔王寨", "固基") then
    		return 3
    	end
	    return 4
	elseif 名称=="侵蚀·棒掀北斗·刻骨"or 名称=="侵蚀·棒掀北斗·噬魂"or 名称 == "侵蚀·棒掀北斗·钻心" or 名称=="侵蚀·当头一棒·刻骨"or 名称=="侵蚀·当头一棒·噬魂"or 名称 == "侵蚀·当头一棒·钻心" or 名称=="侵蚀·绝烬残光·刻骨"or 名称=="侵蚀·绝烬残光·噬魂"or 名称 == "侵蚀·绝烬残光·钻心" or 名称=="侵蚀·天崩地裂·刻骨"or 名称=="侵蚀·天崩地裂·噬魂"or 名称 == "侵蚀·天崩地裂·钻心" or 名称=="侵蚀·幽夜无明·刻骨"or 名称=="侵蚀·幽夜无明·噬魂"or 名称 == "侵蚀·幽夜无明·钻心" or 名称=="侵蚀·千蛛噬魂·刻骨"or 名称=="侵蚀·千蛛噬魂·噬魂"or 名称 == "侵蚀·千蛛噬魂·钻心" or 名称=="侵蚀·幻魇谜雾·刻骨"or 名称=="侵蚀·幻魇谜雾·噬魂"or 名称 == "侵蚀·幻魇谜雾·钻心" or 名称=="侵蚀·魔化万灵·刻骨"or 名称=="侵蚀·魔化万灵·噬魂"or 名称 == "侵蚀·魔化万灵·钻心" or 名称=="侵蚀·龙卷雨击·刻骨"or 名称=="侵蚀·龙卷雨击·噬魂"or 名称 == "侵蚀·龙卷雨击·钻心" or 名称=="侵蚀·鹰击·刻骨"or 名称=="侵蚀·鹰击·噬魂"or 名称 == "侵蚀·鹰击·钻心" or 名称=="侵蚀·敲金击玉·刻骨"or 名称=="侵蚀·敲金击玉·噬魂"or 名称 == "侵蚀·敲金击玉·钻心" or 名称=="侵蚀·烟雨剑法·刻骨"or 名称=="侵蚀·烟雨剑法·噬魂"or 名称 == "侵蚀·烟雨剑法·钻心" or 名称=="侵蚀·日月乾坤·刻骨"or 名称=="侵蚀·日月乾坤·噬魂"or 名称 == "侵蚀·日月乾坤·钻心" or 名称=="侵蚀·雷霆万钧·刻骨"or 名称=="侵蚀·雷霆万钧·噬魂"or 名称 == "侵蚀·雷霆万钧·钻心"or 名称=="侵蚀·五雷轰顶·刻骨"or 名称=="侵蚀·五雷轰顶·噬魂"or 名称 == "侵蚀·五雷轰顶·钻心"or 名称=="侵蚀·五行攻击·刻骨"or 名称=="侵蚀·五行攻击·噬魂"or 名称 == "侵蚀·五行攻击·钻心"or 名称=="侵蚀·巨岩破·刻骨"or 名称=="侵蚀·巨岩破·噬魂"or 名称 == "侵蚀·巨岩破·钻心"or 名称=="侵蚀·地裂火·刻骨"or 名称=="侵蚀·地裂火·噬魂"or 名称 == "侵蚀·地裂火·钻心"or 名称=="侵蚀·靛沧海·刻骨"or 名称=="侵蚀·靛沧海·噬魂"or 名称 == "侵蚀·靛沧海·钻心"or 名称=="侵蚀·日光华·刻骨"or 名称=="侵蚀·日光华·噬魂"or 名称 == "侵蚀·日光华·钻心"or 名称=="侵蚀·苍茫树·刻骨"or 名称=="侵蚀·苍茫树·噬魂"or 名称 == "侵蚀·苍茫树·钻心"or 名称=="侵蚀·五雷正法·刻骨"or 名称=="侵蚀·五雷正法·噬魂"or 名称 == "侵蚀·五雷正法·钻心"or 名称=="侵蚀·五雷咒·刻骨"or 名称=="侵蚀·五雷咒·噬魂"or 名称 == "侵蚀·五雷咒·钻心"or 名称=="侵蚀·失魂符·刻骨"or 名称=="侵蚀·失魂符·噬魂"or 名称 == "侵蚀·失魂符·钻心"or 名称=="侵蚀·葬玉焚花·刻骨"or 名称=="侵蚀·葬玉焚花·噬魂"or 名称 == "侵蚀·葬玉焚花·钻心"or 名称=="侵蚀·似玉生香·刻骨"or 名称=="侵蚀·似玉生香·噬魂"or 名称 == "侵蚀·似玉生香·钻心"or 名称=="侵蚀·嗔怒金刚·刻骨"or 名称=="侵蚀·横扫千军·刻骨"or 名称 == "侵蚀·横扫千军·钻心"or 名称 == "侵蚀·横扫千军·噬魂"or 名称 == "侵蚀·嗔怒金刚·钻心"or 名称 == "侵蚀·嗔怒金刚·噬魂" or 名称=="侵蚀·唧唧歪歪·刻骨"or 名称 == "侵蚀·唧唧歪歪·钻心"or 名称 == "侵蚀·唧唧歪歪·噬魂"then
	    return 150
    elseif 名称=="电光火石"or 名称 == "风火燎原" then
	    return 9
	end
end

function 初始技能计算:取使用后CD(战斗数据 , 攻击方, 名称)
	if 名称=="摧枯拉朽" then
	    return 30
	elseif 名称=="长驱直入" or 名称 == "魔火焚世"or 名称 == "月下霓裳" or 名称 == "疯狂鹰击" or 名称=="翩鸿一击" or 名称=="亢龙归海" or 名称=="魔焰滔天" or 名称=="风卷残云" or 名称=="顺势而为" or 名称=="威仪九霄" then
		return 6
	elseif 名称=="侵蚀·棒掀北斗·刻骨"or 名称=="侵蚀·棒掀北斗·噬魂"or 名称 == "侵蚀·棒掀北斗·钻心" or 名称=="侵蚀·当头一棒·刻骨"or 名称=="侵蚀·当头一棒·噬魂"or 名称 == "侵蚀·当头一棒·钻心" or 名称=="侵蚀·绝烬残光·刻骨"or 名称=="侵蚀·绝烬残光·噬魂"or 名称 == "侵蚀·绝烬残光·钻心" or 名称=="侵蚀·天崩地裂·刻骨"or 名称=="侵蚀·天崩地裂·噬魂"or 名称 == "侵蚀·天崩地裂·钻心" or 名称=="侵蚀·幽夜无明·刻骨"or 名称=="侵蚀·幽夜无明·噬魂"or 名称 == "侵蚀·幽夜无明·钻心" or 名称=="侵蚀·千蛛噬魂·刻骨"or 名称=="侵蚀·千蛛噬魂·噬魂"or 名称 == "侵蚀·千蛛噬魂·钻心" or 名称=="侵蚀·幻魇谜雾·刻骨"or 名称=="侵蚀·幻魇谜雾·噬魂"or 名称 == "侵蚀·幻魇谜雾·钻心" or 名称=="侵蚀·魔化万灵·刻骨"or 名称=="侵蚀·魔化万灵·噬魂"or 名称 == "侵蚀·魔化万灵·钻心" or 名称=="侵蚀·龙卷雨击·刻骨"or 名称=="侵蚀·龙卷雨击·噬魂"or 名称 == "侵蚀·龙卷雨击·钻心" or 名称=="侵蚀·鹰击·刻骨"or 名称=="侵蚀·鹰击·噬魂"or 名称 == "侵蚀·鹰击·钻心" or 名称=="侵蚀·敲金击玉·刻骨"or 名称=="侵蚀·敲金击玉·噬魂"or 名称 == "侵蚀·敲金击玉·钻心" or 名称=="侵蚀·烟雨剑法·刻骨"or 名称=="侵蚀·烟雨剑法·噬魂"or 名称 == "侵蚀·烟雨剑法·钻心" or 名称=="侵蚀·日月乾坤·刻骨"or 名称=="侵蚀·日月乾坤·噬魂"or 名称 == "侵蚀·日月乾坤·钻心" or 名称=="侵蚀·雷霆万钧·刻骨"or 名称=="侵蚀·雷霆万钧·噬魂"or 名称 == "侵蚀·雷霆万钧·钻心"or 名称=="侵蚀·五雷轰顶·刻骨"or 名称=="侵蚀·五雷轰顶·噬魂"or 名称 == "侵蚀·五雷轰顶·钻心"or 名称=="侵蚀·五行攻击·刻骨"or 名称=="侵蚀·五行攻击·噬魂"or 名称 == "侵蚀·五行攻击·钻心"or 名称=="侵蚀·巨岩破·刻骨"or 名称=="侵蚀·巨岩破·噬魂"or 名称 == "侵蚀·巨岩破·钻心"or 名称=="侵蚀·地裂火·刻骨"or 名称=="侵蚀·地裂火·噬魂"or 名称 == "侵蚀·地裂火·钻心"or 名称=="侵蚀·靛沧海·刻骨"or 名称=="侵蚀·靛沧海·噬魂"or 名称 == "侵蚀·靛沧海·钻心"or 名称=="侵蚀·日光华·刻骨"or 名称=="侵蚀·日光华·噬魂"or 名称 == "侵蚀·日光华·钻心"or 名称=="侵蚀·苍茫树·刻骨"or 名称=="侵蚀·苍茫树·噬魂"or 名称 == "侵蚀·苍茫树·钻心"or 名称=="侵蚀·五雷正法·刻骨"or 名称=="侵蚀·五雷正法·噬魂"or 名称 == "侵蚀·五雷正法·钻心"or 名称=="侵蚀·五雷咒·刻骨"or 名称=="侵蚀·五雷咒·噬魂"or 名称 == "侵蚀·五雷咒·钻心"or 名称=="侵蚀·失魂符·刻骨"or 名称=="侵蚀·失魂符·噬魂"or 名称 == "侵蚀·失魂符·钻心"or 名称=="侵蚀·葬玉焚花·刻骨"or 名称=="侵蚀·葬玉焚花·噬魂"or 名称 == "侵蚀·葬玉焚花·钻心"or 名称=="侵蚀·似玉生香·刻骨"or 名称=="侵蚀·似玉生香·噬魂"or 名称 == "侵蚀·似玉生香·钻心"or 名称=="侵蚀·嗔怒金刚·刻骨"or 名称=="侵蚀·横扫千军·刻骨"or 名称 == "侵蚀·横扫千军·钻心"or 名称 == "侵蚀·横扫千军·噬魂"or 名称 == "侵蚀·嗔怒金刚·钻心"or 名称 == "侵蚀·嗔怒金刚·噬魂" or 名称=="侵蚀·唧唧歪歪·刻骨"or 名称 == "侵蚀·唧唧歪歪·钻心"or 名称 == "侵蚀·唧唧歪歪·噬魂"then
	    return 150
	elseif 名称=="诸天看护" or  名称=="谆谆教诲" or 名称=="潜龙在渊"  or 名称=="钟馗论道" or 名称=="偷龙转凤"	or 名称=="噬毒" or 名称=="困兽之斗" or 名称=="真君显灵" or 名称=="齐天神通" then
		return 8
	 elseif 名称== "秘传三昧真火" or  名称== "秘传飞砂走石"then
    	if   战斗数据:取经脉(攻击方.序号, "魔王寨", "固基") then
	    	return 7
	    elseif 战斗数据:取经脉(攻击方.序号, "魔王寨", "惊悟") and math.random(100)<=30 then
	    	return 6
	   	else
	    	return 8
	   	end
	elseif 名称=="天眼神通"  then
    	if 战斗数据:取经脉(攻击方.序号, "凌波城", "凝息") then
    		return 7
    	end
	    return 8
    elseif 名称=="碎玉弄影" or 名称=="画地为牢" or 名称=="凋零之歌" or 名称=="幻镜术" then
    	return 5
    elseif 名称=="观照万象" then
    	return 150
	elseif 名称 == "风火燎原" or 名称=="否极泰来"  then
	    return 12
	elseif 名称=="妙悟" then
	    return 2
	elseif 名称=="活血" and 战斗数据:取经脉(攻击方.序号, "化生寺", "化瘀") then
	    return 8
	elseif (名称=="勾魂" or 名称=="勾魂") and 战斗数据:取经脉(攻击方.序号, "盘丝洞", "绝媚") then
	    return 8
    elseif 名称=="救死扶伤" and 战斗数据:取经脉(攻击方.序号, "化生寺", "心韧") then
	    return 8
	elseif 名称=="分身术" and 战斗数据:取经脉(攻击方.序号, "方寸山", "幻变") then
	    return 8
	elseif 名称=="一笑倾城" and 战斗数据:取经脉(攻击方.序号, "女儿村", "倾国") then
	    return 8
	elseif 名称=="飞花摘叶" and 战斗数据:取经脉(攻击方.序号, "女儿村", "飞花") then
	    return 8
	elseif 名称=="碎甲符" and 战斗数据:取经脉(攻击方.序号, "方寸山", "碎甲") then
	    return 6
    elseif 名称=="判官令" and 战斗数据:取经脉(攻击方.序号, "阴曹地府", "咒令") then
	    return 6
	elseif 名称=="渡劫金身" or 名称=="风云变色" or 名称=="惊天动地" or 名称=="鸿渐于陆" or 名称=="落花成泥" or 名称=="天命剑法" or 名称 == "同舟共济" or 名称 == "妖风四起" or 名称 == "魍魉追魂" or 名称 == "清风望月" or 名称 == "其疾如风" or 名称 == "其徐如林" or 名称 == "侵略如火" or 名称 == "岿然如山" then
	    return 4
	elseif 名称=="鸣雷诀" or 名称=="同伤式" or 名称=="无双战魂" or 名称=="净土灵华" then
	    return 6
	elseif 名称=="功德无量" or 名称=="否极泰来" then
	    return 12
	elseif 名称=="牵魂蛛丝" or 名称=="清静菩提" then
	    return 8
	elseif 名称=="电光火石"  then
	    return 9
    elseif 名称== "花谢花飞" then
    	return 16
	elseif 名称=="绝命毒牙" or 名称 == "绝处逢生" or 名称 == "天神怒斩" or 名称=="披挂上阵" or 名称=="无间地狱" or 名称=="花语歌谣" then
	    return 10
	elseif 名称=="二龙戏珠" and 战斗数据:取经脉(攻击方.序号, "龙宫", "戏珠") then
	    return 8
	elseif 名称=="耳目一新" then
	    return 24
	elseif 名称=="生杀予夺" then
	    return 36
	elseif 名称=="超级永恒" then
	    return 150
	end
end

function 初始技能计算:被动技能(名称)
	-- local 临时名称={"连破","披坚执锐","明光","佛眷","聚气","度厄","龙魂","龙骇","风萦","鞭挞","木精"
	-- ,"奔雷","悲恸","咒符","自矜","电芒","返璞","五行珠","狮吼","骤雨","还丹","金莲","缚魂","裂魂"
	-- ,"超级战意","饮海","吞山"}--,"五行感应"
	-- for n=1,#临时名称 do
	-- 	if 临时名称[n]==名称 then return true end
	-- end
	if Qu被动技能[名称] then
	    return true
	end
	return false
end
--===================================================进战斗时加载的技能
function 初始技能计算:恢复技能(名称)
	if Qu恢复技能[名称] then
	    return true
	end
	return false
end

function 初始技能计算:法攻技能(名称)
	-- local 临时名称={"落叶萧萧","蛊木迷瘴","荆棘舞","尘土刃","冰川怒","唧唧歪歪","谆谆教诲","五雷咒","落雷符","雷霆万钧","龙卷雨击","二龙戏珠","龙腾",
	-- "三昧真火","飞砂走石","水攻","烈火","落岩","雷击","泰山压顶","水漫金山","亢龙归海","风雷韵动","地狱烈火","奔雷咒","月光","上古灵符","血雨",
	-- "魔火焚世","八凶法阵","流沙轻音","叱咤风云","食指大动","风卷残云","天降灵葫","摇头摆尾","风云变色","魔焰滔天","扶摇万里","秘传三昧真火","秘传飞砂走石",
	-- "古藤秘咒","疾风秋叶","枯木逢春","棒掀北斗","灵彻太虚","兴风作浪","棍打诸神","意马心猿"}
	if Qu法攻技能[名称] then
	    return true
	end
	return false
end

function 初始技能计算:固伤技能(名称)
	-- local 临时名称={"天罗地网","子母神针","飞花摘叶","勾魂","摄魄","瘴气","姐妹同心","夺命咒","鸿渐于陆","自爆","雨落寒沙","五雷轰顶","龙吟",
	-- "苍茫树","靛沧海","日光华","地裂火","巨岩破","判官令","阎罗令","黄泉之息","追魂刺","云暗天昏","诅咒之伤","吸血特技","夜舞倾城"}
	if Qu固伤技能[名称] then
	    return true
	end
	return false
end

function 初始技能计算:物攻技能(名称)
	-- local 临时名称={"牛刀小试","剑荡四方","翻江搅海","满天花雨","破血狂攻","弱点击破","善恶有报","惊心一剑","壁垒击破","横扫千军","破碎无双",
	-- "狮搏","象形","连环击","鹰击","烟雨剑法","飘渺式","天雷斩","裂石","断岳势","天崩地裂","浪涌","惊涛怒","力劈华山","高级连击","破釜沉舟",
	-- "死亡召唤","疯狂鹰击","六道无量","百爪狂杀","翩鸿一击","长驱直入","腾雷","天神怒斩","水击三千","惊天动地","摧枯拉朽","披挂上阵",
	-- "葬玉焚花","风雷斩","日光耀","靛沧啸","巨岩击","苍茫刺","地裂焚","威仪九霄","千蛛噬魂","蛛丝缠绕","绝命毒牙","无赦咒令",
	-- "百鬼噬魂","生杀予夺","血影蚀心","困兽之斗","敲金击玉","金击式","天命剑法","落土止息","威震凌霄","当头一棒","神针撼海","杀威铁棒",
	-- "泼天乱棒","棒打雄风"}
	if Qu物攻技能[名称] then
	    return true
	end
	return false
end

function 初始技能计算:封印技能(名称)
	if Qu封印技能[名称] then
	    return true
	end
	return false
end

function 初始技能计算:群体封印技能(名称)
	if Qu群体封印技能[名称] then
	    return true
	end
	return false
end

function 初始技能计算:减益技能(名称)
	if Qu减益技能[名称] then
	    return true
	end
	return false
end

function 初始技能计算:增益技能(名称)

	if Qu增益技能[名称] then
	    return true
	end
	return false
end
--===================================================进战斗时加载的技能

function 初始技能计算:取吸血异常(战斗数据,编号)

	for i, v in pairs(战斗数据.参战单位[编号].法术状态) do
		if Qu取吸血异常[i] then return true end
	end
	return false
end

function 初始技能计算:不可复活(单位)
	if 单位.气血 > 0 or 单位.逃跑~=nil or 单位.捕捉~=nil then
	    return true
	elseif 单位.法术状态.剑意 and 单位.法术状态.剑意.层数>=23 then
		return false
	end
	for i, v in pairs(单位.法术状态) do
		if Qu不可复活[i] then return true end
	end
	return false
end

function 初始技能计算:取是否被封印(战斗数据,编号)
	for i, v in pairs(战斗数据.参战单位[编号].法术状态) do
		if Qu取是否被封印[i] then return true end
	end
	return false
end

function 初始技能计算:取攻击状态(战斗数据,编号)

	if 战斗数据.参战单位[编号].法术状态["夺魄令"] and 战斗数据.参战单位[编号].法术状态["夺魄令"].封物理 then
		return true
	end
	for i, v in pairs(战斗数据.参战单位[编号].法术状态) do
		if Qu取攻击状态[i] then return false end
	end
	return true
end

function 初始技能计算:取法术状态(战斗数据,编号)

	for i, v in pairs(战斗数据.参战单位[编号].法术状态) do
		if Qu取法术状态[i] then return false end
	end
	return true
end

function 初始技能计算:取特技状态(战斗数据,编号)

	for i, v in pairs(战斗数据.参战单位[编号].法术状态) do
		if Qu取特技状态[i] then return false end
	end
	return true
end

function 初始技能计算:取法宝状态(单位)

	for i, v in pairs(单位.法术状态) do
		if Qu法宝状态[i] then return false end
	end
	return true
end

function 初始技能计算:取异常状态法术(法术状态)

	local fszt={}
    for i, v in pairs(法术状态) do
		if Qu异常法术状态[i] then
			fszt[#fszt+1]=i
		end
	end
	return fszt
end

function 初始技能计算:取封印状态法术()
	return {"催眠符", "失心符", "落魄符", "失忆符", "追魂符", "失魂符", "定身符", "莲步轻舞", "如花解语", "似玉生香", "含情脉脉", "魔音摄魂",
	"天罗地网", "夺魄令", "煞气诀", "惊魂掌", "摧心术", "烈火焚原", "毁灭之光", "秘传封印","顺势而为"}
end

function 初始技能计算:取增益状态法术() --这种都是解除状态结果的写法
	return{"碎星诀", "杀气诀", "安神诀", "金刚护法", "金刚护体", "韦陀护法", "一苇渡江", "乘风破浪", "神龙摆尾", "生命之泉", "炼气化神", "普渡众生",
	"灵动九天", "定心术", "啸风诀", "牛劲","风火燎原","诸天看护","同舟共济","功德无量"}
end

function 初始技能计算:取可驱散增益状态()
	return{"碎星诀", "杀气诀", "安神诀", "金刚护法", "金刚护体", "韦陀护法", "一苇渡江", "乘风破浪", "神龙摆尾", "生命之泉", "炼气化神", "普渡众生",
	"灵动九天", "定心术", "牛劲","风火燎原","幻镜术" ,"同舟共济","天神护体","功德无量","移魂化骨","炎护","蜜润","幽冥鬼眼"}
end

function 初始技能计算:取可解除状态(法术状态)
	local fszt={}
    for i, v in pairs(法术状态) do
		if Qu异常法术状态[i] then
			fszt[#fszt+1]=i
		end
	end
	return fszt
end

function 初始技能计算:取法宝增益状态()
	return{"铸兵锤","干将莫邪", "苍白纸人", "五彩娃娃", "混元伞","乾坤玄火塔","分水","赤焰","天煞","神木宝鼎","九梵清莲","苍灵雪羽","烽火狼烟","璞玉灵钵","金蟾"}
end

function 初始技能计算:取法宝封印法术()
	return {"发瘟匣", "番天印", "摄魂", "无尘扇", "无字经", "舞雪冰蝶", "无魂傀儡"}--,"掌心雷"
end

function 初始技能计算:取门派封印法术(门派)
	if 门派 == "方寸山" then
		return {"催眠符", "失心符", "落魄符", "失忆符", "追魂符", "失魂符", "定身符","顺势而为"}
	elseif 门派 == "女儿村" then
		return {"莲步轻舞", "如花解语", "似玉生香"}
	elseif 门派 == "盘丝洞" then
		return {"含情脉脉", "魔音摄魂", "天罗地网"}
	elseif 门派 == "无底洞" then
		return {"夺魄令", "煞气诀", "惊魂掌", "摧心术","妖风四起"}
	elseif 门派 == "天宫" then
		return {"画地为牢", "错乱", "掌心雷", "镇妖", "百万神兵"}
	end
end

function 初始技能计算:取道具状态(战斗数据,编号)
	local 技能名称 = {"烈火焚原"}
	for n = 1, #技能名称 do
		if 战斗数据.参战单位[编号].法术状态[技能名称[n]] ~= nil then
			return false
		end
	end
	return true
end

function 初始技能计算:取技能所属门派(名称)
	if 名称=="满天花雨" then
	    return "女儿村"
    elseif 名称=="夺命咒" then
		return "无底洞"
	elseif 名称=="唧唧歪歪" then
		return "化生寺"
	elseif 名称=="五雷咒" then
		return "方寸山"
	elseif 名称=="勾魂" then
		return "盘丝洞"
	elseif 名称=="浪涌" or 名称=="裂石" then
		return "凌波城"
	elseif 名称=="飞砂走石" or 名称=="三昧真火" then
		return "魔王寨"
	elseif 名称=="后发制人" or 名称=="横扫千军" then
		return "大唐官府"
	elseif 名称=="神针撼海" or 名称=="当头一棒" then
		return "花果山"
	elseif 名称=="龙卷雨击" or 名称=="龙吟" or 名称=="龙腾" then
		return "龙宫"
	elseif 名称=="阎罗令" or 名称=="判官令" or 名称=="尸腐毒" then
		return "阴曹地府"
	elseif 名称=="尘土刃" or 名称=="荆棘舞" or 名称=="冰川怒" or 名称=="落叶萧萧" then
		return "神木林"
    elseif 名称=="紧箍咒" or 名称=="日光华" or 名称=="靛沧海" or 名称=="巨岩破" or 名称=="苍茫树" or 名称=="地裂火" then
		return "普陀山"
	end
	return "空"
end

function 初始技能计算:魔法消耗(战斗数据,攻击方, 数值, 名称)
	local 临时消耗 = math.floor(数值)
	if 攻击方.慧根 ~= nil then
		临时消耗 = qz(临时消耗 * 攻击方.慧根)
	end
	if 攻击方.飞檐走壁 ~= nil then
		临时消耗 =  qz(临时消耗 * 攻击方.飞檐走壁)
	end

	if 战斗数据:取特定法术状态(攻击方, "罗汉珠") then
		临时消耗 = qz(临时消耗 * (1-攻击方.法术状态.罗汉珠.境界*0.04))
	end
	if 攻击方.法术状态.雷浪穿云 then
		临时消耗 = qz(临时消耗*2 + 30)
	end

	if 攻击方.法术状态.魔息术 and 攻击方.法术状态.魔息术.魔息~=nil then
		临时消耗 = 1
	end
	if 攻击方.魔法 < 临时消耗 then
		return false
	end
	攻击方.魔法 = 攻击方.魔法 - 临时消耗
	return true
end

function 初始技能计算:消耗魔法和愤怒(战斗数据,攻击方, 魔法, 愤怒, 名称)
	local 魔法消耗 = 魔法
	if 攻击方.慧根 ~= nil then
		魔法消耗 = qz(魔法消耗 * 攻击方.慧根)
		if 取随机数(1,100) <= 15 then
			魔法消耗 = 0
		end
	end
	if 战斗数据:取特定法术状态(攻击方, "罗汉珠") then
		临时消耗 = qz(临时消耗 * (1-攻击方.法术状态.罗汉珠.境界*0.04))
	end
    if 攻击方.愤怒==nil then 攻击方.愤怒=150 end
	if 攻击方.魔法 < 魔法消耗 or 攻击方.愤怒<愤怒 then
		return false
	else
		攻击方.愤怒 = 攻击方.愤怒 - 愤怒
		攻击方.魔法 = 攻击方.魔法 - 魔法消耗
		return true
	end
end

function 初始技能计算:魔法和木精消耗(战斗数据,攻击方, 魔法, 木精, 名称)
	local 魔法消耗 = qz(魔法)
	if 攻击方.慧根 ~= nil then
		魔法消耗 = qz(魔法消耗 * 攻击方.慧根)
	end
	if 战斗数据:取特定法术状态(攻击方, "罗汉珠") then
		临时消耗 = qz(临时消耗 * (1-攻击方.法术状态.罗汉珠.境界*0.04))
	end
    if 攻击方.愤怒==nil then 攻击方.愤怒=150 end

	if 攻击方.魔法 < 魔法消耗  or not 攻击方.法术状态.木精 or 攻击方.法术状态.木精.层数<木精 then
		return false
	else
		攻击方.法术状态.木精.层数 = 攻击方.法术状态.木精.层数 - 木精
		if 攻击方.法术状态.木精.层数<=0 then
		    战斗数据:取消状态("木精", 攻击方)
		end
		攻击方.魔法 = 攻击方.魔法 - 魔法消耗
		if 战斗数据:取经脉(攻击方.序号, "神木林", "归原") then
		    战斗数据:动画加血流程(攻击方.序号,木精*攻击方.等级*4)
		end
		if 名称=="枯木逢春" then
			战斗数据:添加状态("风灵",攻击方,攻击方,69,nil,2)
		else
			if 战斗数据:取经脉(攻击方.序号, "神木林", "灵精") and sj()<=20 then
				战斗数据:添加状态("风灵",攻击方,攻击方,69,nil,木精)
			end
		end

		return true
	end
end

function 初始技能计算:道具消耗(战斗数据,攻击方,魔法, 数量, 名称, 技能名称)
	if 玩家数据[攻击方.玩家id].道具:消耗背包道具(玩家数据[攻击方.玩家id].连接id, 攻击方.玩家id, 名称, 数量) and self:魔法消耗(战斗数据,攻击方, 魔法, 1, 技能名称) then
		return true
	else
		return false
	end
end

function 初始技能计算:愤怒消耗(战斗数据,数值,攻击方,名称)
	local 消耗 = qz(数值 *(攻击方.特效愤怒 or 1))
	if 攻击方.愤怒==nil  then 攻击方.愤怒=0 end
	if 攻击方.愤怒 < 消耗 then
		return false
	else
		攻击方.愤怒 = 攻击方.愤怒 - 消耗
		if 攻击方.shenqi.name=="玉魄" then
			攻击方.临时治疗=攻击方.shenqi.lv*消耗
		end
		return true
	end
end

function 初始技能计算:特技消耗(战斗数据,数值,攻击方,名称)
	local 消耗 = qz(数值 *(攻击方.特效愤怒 or 1))
	if 攻击方.门派=="女儿村" then
	    if 战斗数据:取经脉(攻击方.序号, "女儿村", "傲娇") then
			消耗 = 消耗 - 4
			if 名称 == "笑里藏刀" then 消耗 = 消耗 - 4 end
		elseif 战斗数据:取经脉(攻击方.序号, "女儿村", "花护") then
			if 名称 == "水清诀" or 名称 == "冰清诀" or 名称 == "晶清诀" or 名称 == "玉清诀" then
				消耗 = 消耗 - 8
			end
		elseif 战斗数据:取经脉(攻击方.序号, "女儿村", "空灵") then
			战斗数据:添加状态("空灵",攻击方,攻击方,69)
		elseif 名称 == "破碎无双" and 战斗数据:取经脉(攻击方.序号, "女儿村", "轻刃") then
			战斗数据:添加状态("自矜",攻击方,攻击方,69)
		end
	end

	if 攻击方.门派=="狮驼岭" and (名称 == "破血狂攻" or 名称 == "破碎无双") then
		if 战斗数据:取经脉(攻击方.序号, "狮驼岭", "怒火")  then
		    local bb = 战斗数据:取玩家召唤兽(攻击方.序号)
			if bb~=0 then
			    战斗数据:添加状态("怒火", 战斗数据.参战单位[bb], 攻击方,11)
			end
		elseif 战斗数据:取经脉(攻击方.序号, "狮驼岭", "狂血") then
			战斗数据:添加状态("狂怒", 攻击方, 攻击方,11,nil,3)
		end
	elseif 战斗数据:取经脉(攻击方.序号, "五庄观", "炼果") and (名称 == "破血狂攻" or 名称 == "破碎无双" or 名称 == "弱点击破") then
		战斗数据:增加人参果(攻击方.序号)
	elseif 名称 == "罗汉金钟" and 战斗数据:取经脉(攻击方.序号, "化生寺", "静气") then
		消耗 = 消耗 - 15
	elseif 名称 == "罗汉金钟" and 战斗数据:取经脉(攻击方.序号, "无底洞", "罗汉") then
		消耗 = 消耗 - 4
	elseif 名称 == "玉清诀" and 战斗数据:取经脉(攻击方.序号, "无底洞", "暗潮") then
		消耗 = 消耗 - 25
	elseif 战斗数据:取经脉(攻击方.序号, "无底洞", "噬魂") and (名称 == "水清诀" or 名称 == "冰清诀") and 战斗数据:取门派是否唯一(攻击方.序号,"无底洞") then
		消耗 = qz(消耗 / 2)
	elseif 战斗数据:取经脉(攻击方.序号, "花果山", "显圣") and (名称 == "晶清诀" or 名称 == "罗汉金钟") then
		消耗 = 消耗 - 8
		战斗数据:添加状态("显圣",攻击方,攻击方,69)
	end

    if 攻击方.愤怒==nil  then 攻击方.愤怒=0 end
	if 攻击方.愤怒 < 消耗 then
		if 名称~="慈航普度" and 攻击方.修心==nil and 战斗数据:取经脉(攻击方.序号,"五庄观","修心") and 攻击方.魔法>=消耗*20 then
			攻击方.修心 = 1
			战斗数据:减少魔法(攻击方.序号 , 消耗*20)
            return true
		end
		return false
	else
		if 攻击方.亢强~=nil then
			攻击方.亢强=数值*0.2
		end
		if 战斗数据:取经脉(攻击方.序号, "大唐官府", "催迫") and 数值>=120 then
			战斗数据.参战单位[攻击方.序号].催迫=1
		end
		if 战斗数据:取经脉(攻击方.序号, "天宫", "趁虚")  then
			战斗数据:添加状态("趁虚", 战斗数据.参战单位[攻击方.序号], 战斗数据.参战单位[攻击方.序号], 11)
		end
		if 战斗数据:取经脉(攻击方.序号, "天宫", "怒电") and 数值>=120 and sj()<=50 then
			战斗数据:添加状态("怒电",攻击方,攻击方,69)
		end
		if 战斗数据:取经脉(攻击方.序号, "天宫", "存雄") then
			战斗数据:添加状态("存雄",攻击方,攻击方,69)
		end
		if 战斗数据:取经脉(攻击方.序号, "阴曹地府", "鬼火") and 数值<=90 then
			战斗数据:增加愤怒(攻击方.序号, 16)
		end
		if 攻击方.门派=="凌波城" and 战斗数据:取经脉(攻击方.序号,"凌波城","聚气") and 消耗 >= 60  then
			战斗数据:增加战意(攻击方.序号, 1)
		end
		if 攻击方.门派=="魔王寨" and 战斗数据:取经脉(攻击方.序号,"魔王寨","烬藏") and 消耗 >= 120  then
			for k, v in pairs(战斗数据.参战单位[攻击方.序号].主动技能) do
					if (v.名称 == "秘传飞砂走石" or v.名称 == "秘传三昧真火")  and v.剩余冷却回合 ~= nil then
						v.剩余冷却回合=v.剩余冷却回合-1
						break
					end
			end
		end
		if 攻击方.shenqi.name=="万物滋长" then
		    战斗计算:添加护盾(战斗数据,攻击方.序号,攻击方.shenqi.lv*攻击方.等级*0.05)
		end
		攻击方.愤怒 = 攻击方.愤怒 - 消耗
		return true
	end
end

function 初始技能计算:不可操作状态(战斗数据,编号) --无法行动，要区分是否能防御，保护，召唤等等
	local 临时名称={"乾坤妙法"} --1、使用技能后，身上有负面效果(中毒等)会持续，不会消失2、身上有部分辅助效果(普渡众生等)自动消失
	for n=1,#临时名称 do
		if 临时名称[n]==名称 then return true end
	end
	return false
end

function 初始技能计算:取行动状态(战斗数据,编号)
	if (战斗数据.参战单位[编号].气血 <= 0 or 战斗数据.参战单位[编号].捕捉 or 战斗数据.参战单位[编号].逃跑) and not 战斗数据.参战单位[编号].狂袭 then
		return false
	elseif 战斗数据.参战单位[编号].法术状态.横扫千军 ~= nil and 战斗数据.参战单位[编号].法术状态.横扫千军.回合==1 then
		return false
	elseif 战斗数据.参战单位[编号].法术状态.落花成泥 ~= nil and 战斗数据.参战单位[编号].法术状态.落花成泥.回合==1 then
		return false
	elseif 战斗数据.参战单位[编号].法术状态.惊天动地 ~= nil then
		return false
	elseif 战斗数据.参战单位[编号].法术状态.破釜沉舟 ~= nil then
		return false
	elseif 战斗数据.参战单位[编号].法术状态.催眠符 ~= nil then
		if 战斗数据.参战单位[编号].指令 and 战斗数据.参战单位[编号].指令.类型 == "召唤" and 战斗数据.参战单位[编号].法术状态.催眠符.当前回合~=nil then
		    return true
		end
		return false
	elseif 战斗数据.参战单位[编号].法术状态.楚楚可怜 ~= nil then
		return false
	elseif 战斗数据.参战单位[编号].法术状态.冰川怒 ~= nil then
		return false
	elseif 战斗数据.参战单位[编号].法术状态.亢龙归海 ~= nil  then
		return false
	elseif 战斗数据.参战单位[编号].法术状态.天命剑法 ~= nil or 战斗数据.参战单位[编号].法术状态.落土止息 ~= nil then
		return false
	elseif 战斗数据.参战单位[编号].法术状态.乾坤妙法 ~= nil then
		return false
	elseif 战斗数据.参战单位[编号].精灵 and 战斗数据.回合数 == 1 then
		return false
	elseif 战斗数据.参战单位[编号].法术状态.龙鸣虎啸 ~= nil then
		return false
	end
	return true
end

return 初始技能计算