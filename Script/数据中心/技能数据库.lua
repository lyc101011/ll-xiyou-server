-- @Author: baidwwy
-- @Date:   2024-10-20 02:54:08
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-12-14 20:41:40
-- @Author: baidwwy
-- @Date:   2024-10-20 02:54:08
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-10-21 21:52:07
-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:44
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-10-15 18:52:40

local 技能数据库 = class()
local qz=math.floor
九黎城攻击技能 = {
	枫影二刃 = 1,
	三荒尽灭 = 1,
	力辟苍穹 = 1,
	铁血生风 = 1,
	一斧开天 = 1,
	魔神之刃 = 1
}
function 技能数据库:初始化()
	self.数据={
		枫影二刃 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
				return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 20*mbs , "魔法"
			end,
		},
		三荒尽灭 = {
			技能类型="九黎技能",
			技能人数 = function(lv,攻击方,PK)
				return 3
			end,
			技能消耗 = function(mbs,攻击方)

				return 20 , "魔法"
			end
		},
		力辟苍穹 = {
			技能类型="九黎技能",
			技能人数 = function(lv,攻击方,PK)
				return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 20*mbs , "魔法"
			end
		},
		铁血生风 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
				return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 20*mbs , "魔法"
			end
		},
		一斧开天 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
				return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 20*mbs , "魔法"
			end
		},
		魔神之刃 = {
			技能类型="九黎技能",
			技能人数 = function(lv,攻击方,PK)
				return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 20*mbs , "魔法"
			end
		},
		炎魂 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
				return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 20*mbs , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return  {类型=2,状态回合=1}
			end
		},
		怒哮 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
				return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {状态回合=999}
			end,
		},
	    --====================龙宫====================--

		龙卷雨击 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = qz(lv/25+1)
			    if sl > 7 then
			        sl = 7
		        elseif sl < 2 then
		        	sl = 2
			    end

			    if 攻击方.JM.龙魄 and 取随机数() <= 20 then
				    sl = sl + 3
			    elseif 攻击方.JM.龙钩 and 攻击方.法术状态["龙骇"] and 攻击方.法术状态["龙骇"].触发=="龙卷雨击" then
			    	sl = sl + 3
			    end
 			    if 攻击方.JM.沐雨 and 时辰信息.天气==2  then
				    sl = sl + 3
			    elseif 攻击方.JM.龙钩 and 攻击方.法术状态["龙骇"] and 攻击方.法术状态["龙骇"].触发=="龙卷雨击" then
			    	sl = sl + 3
			    end
			    return sl
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.法术状态.龙战于野 then
					return 20*mbs+350 , "魔法"
				else
					return 20*mbs , "魔法"
				end
			end,
		},



		侵蚀·龙卷雨击·刻骨 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = qz(lv/25+1)
			    if sl > 7 then
			        sl = 7
		        elseif sl < 2 then
		        	sl = 2
			    end
			    if 攻击方.JM.龙魄 and 取随机数() <= 20 then
				    sl = sl + 3
			    elseif 攻击方.JM.龙钩 and 攻击方.法术状态["龙骇"] and 攻击方.法术状态["龙骇"].触发=="龙卷雨击" then
			    	sl = sl + 3
			    end
 			    if 攻击方.JM.沐雨 and 时辰信息.天气==2  then
				    sl = sl + 3
			    elseif 攻击方.JM.龙钩 and 攻击方.法术状态["龙骇"] and 攻击方.法术状态["龙骇"].触发=="龙卷雨击" then
			    	sl = sl + 3
			    end
			    return sl
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.法术状态.龙战于野 then
					return 20*mbs+350 , "魔法"
				else
					return 20*mbs , "魔法"
				end
			end,
		},
		侵蚀·龙卷雨击·钻心 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = qz(lv/25+1)
			    if sl > 7 then
			        sl = 7
		        elseif sl < 2 then
		        	sl = 2
			    end
			    if 攻击方.JM.龙魄 and 取随机数() <= 20 then
				    sl = sl + 3
			    elseif 攻击方.JM.龙钩 and 攻击方.法术状态["龙骇"] and 攻击方.法术状态["龙骇"].触发=="龙卷雨击" then
			    	sl = sl + 3
			    end
 			    if 攻击方.JM.沐雨 and 时辰信息.天气==2  then
				    sl = sl + 3
			    elseif 攻击方.JM.龙钩 and 攻击方.法术状态["龙骇"] and 攻击方.法术状态["龙骇"].触发=="龙卷雨击" then
			    	sl = sl + 3
			    end
			    return sl
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.法术状态.龙战于野 then
					return 20*mbs+350 , "魔法"
				else
					return 20*mbs , "魔法"
				end
			end,
		},
		侵蚀·龙卷雨击·噬魂 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = qz(lv/25+1)
			    if sl > 7 then
			        sl = 7
		        elseif sl < 2 then
		        	sl = 2
			    end
			    if 攻击方.JM.龙魄 and 取随机数() <= 20 then
				    sl = sl + 3
			    elseif 攻击方.JM.龙钩 and 攻击方.法术状态["龙骇"] and 攻击方.法术状态["龙骇"].触发=="龙卷雨击" then
			    	sl = sl + 3
			    end
 			    if 攻击方.JM.沐雨 and 时辰信息.天气==2  then
				    sl = sl + 3
			    elseif 攻击方.JM.龙钩 and 攻击方.法术状态["龙骇"] and 攻击方.法术状态["龙骇"].触发=="龙卷雨击" then
			    	sl = sl + 3
			    end
			    return sl
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.法术状态.龙战于野 then
					return 20*mbs+350 , "魔法"
				else
					return 20*mbs , "魔法"
				end
			end,
		},
		二龙戏珠 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
		        return 2
			end,
			技能消耗 = function(mbs,攻击方)
				return  70 , "魔法"
			end,
		},
		龙腾 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
--------------------------18奇技龙宫1-------------------------------
			if self:取门派秘籍(攻击方.玩家id,"龙宫A") >=1  and not PK then
  				return math.floor(self:取门派秘籍(攻击方.玩家id,"龙宫A")/25)
  			else
  				return 1
  			end
--------------------------18奇技龙宫1-------------------------------
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.法术状态.龙战于野 then
					return 380 , "魔法"
				else
					return 30 , "魔法"
				end
			end,
		},




		亢龙归海 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.法术状态.龙战于野 then
					return 275 , "魔法"
				else
					return 100 , "魔法"
				end
			end,
			双封 = true,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=2}
			end,

		},
		龙吟 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
		        return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		解封 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "魔法"
			end,
		},
		清心 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		神龙摆尾 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    local hh = 6
			    if lv >= 175 then
			        hh = 8
		        elseif lv >= 150 then
			        hh = 8
			    end
			    return  {类型=2,状态回合=hh}
			end,
		},
		龙战于野 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "金鸦火羽（高级）"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定) --技能效果：降低自身法防并提高法伤，使用龙卷雨击、龙腾、亢龙归海时额外消耗350点魔法并提高16%(化圣1)/16%(化圣5)/20%(化圣9)伤害结果，持续8回合
			    return  {类型=1,状态回合=12,法防=qz(sx.法防*0.1)}
			end,
		},
		逆鳞 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    local hh = 12
			    if lv >= 160 then
			        hh = 12
		        elseif lv >= 120 then
			        hh = 12
		        elseif lv >= 80 then
			        hh = 12
		        elseif lv >= 40 then
			        hh = 12
			    end
			    return  {类型=2,状态回合=hh,伤害=qz(lv*1.5)}
			end,
		},
		裂魂 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=4,伤害=qz(lv*1.5)}
			end,
		},
		侵蚀 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=1,伤害=qz(lv*1.5)}
			end,
		},
		乘风破浪 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    local hh = 4
			    if lv >= 160 then
			        hh = 8
		        elseif lv >= 120 then
			        hh = 8
		        elseif lv >= 80 then
			        hh = 8
		        elseif lv >= 40 then
			        hh = 8
			    end
			    return {类型=2,状态回合=hh,躲避=qz(lv*1.5)}
			end,
		},
		潜龙在渊 = {
			技能类型="增益技能",
			指定对象="自己",
			层数上限=999,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2 ,状态回合=150 ,层数=指定}
			end,
		},
		破浪 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2 ,状态回合=1} --无
			end,
		},
		盘龙 = {
		    不可驱散=true,
		    层数上限=999,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2 ,状态回合=150,层数=1} --无
			end,
		},
		龙啸 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2 ,状态回合=3} --无
			end,
		},
		清吟 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2 ,状态回合=3} --无
			end,
		},
		龙魂 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2 ,状态回合=3} --无
			end,
		},
		龙骇 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=150} --无
			end,
		},
		雷浪穿云 = {
			技能类型="减益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {状态回合=5}
			end,
		},
		水遁 = {
			技能类型="逃跑技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  攻击方.魔法 , "魔法"
			end,
		},

        --====================狮驼岭====================--
        变身 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.法术状态.魔息术 and 攻击方.法术状态.魔息术.魔息~=nil then
					return  1 , "魔法"
				end
				return  20 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 12
				if lv >= 160 then
			        hh = 12
			    elseif lv >= 120 then
			        hh = 12
		        elseif lv >= 80 then
			        hh = 12
		        elseif lv >= 40 then
			        hh = 12
			    end
			 --    local fj = {}
			 --    if 攻击方.JM.宁息 then --后期照这样改，这样添加状态就少很多判断了
				-- 	hh = hh + 2
				-- 	挨打方.法术状态["变身"].宁息 = true
				-- elseif 攻击方.JM.屏息 then
				-- 	挨打方.法术状态["变身"].屏息 = true
				-- end
				-- if 攻击方.JM.狂躁 then
				--     hh = hh - 3
				--     战斗数据:添加状态("狂怒",挨打方,挨打方,69,nil,hh)
				-- end
				-- if 指定 and 指定=="迅捷" then
				--     hh = 3
				--     伤害 = 等级
				--     类型=1
				-- else
				-- 	类型=2
				-- 	伤害= qz(等级*0.5)
				-- end
			    return {类型=2,状态回合=hh}
			end,
		},
		狂怒 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.法术状态.魔息术 and 攻击方.法术状态.魔息术.魔息~=nil then
					return  1 , "魔法"
				end
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 4
				if lv >= 160 then
			        hh = 8
			    elseif lv >= 120 then
			        hh = 8
		        elseif lv >= 80 then
			        hh = 8
		        elseif lv >= 40 then
			        hh = 8
			    end
			    if 指定 then
			        hh = 指定
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		天魔解体 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.气血 > 攻击方.最大气血 * 0.1 then
			        if 攻击方.法术状态.魔息术 and 攻击方.法术状态.魔息术.魔息~=nil then
						return  1 , "魔法"
					end
			        return  100 , "魔法"
			    end
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=8,伤害=lv}
			end,
		},
		鹰击 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = 3
			    if lv >= 125 then
			        sl = 6
		        elseif lv >= 75 then
			        sl = 5
		        elseif lv >= 50 then
			        sl = 4
			    end
			    if 取随机数()<=40 and 攻击方.法术状态.狂怒 and 攻击方.法术状态.狂怒.狂乱~=nil then
					sl = sl + 1
				end
				if 攻击方.法术状态.背水 then
					sl = sl + 1
				end
				return sl
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.法术状态.魔息术 and 攻击方.法术状态.魔息术.魔息~=nil then
					return  mbs , "魔法"
				end
				return  30*mbs , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=2}
			end,
		},
		侵蚀·鹰击·刻骨 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = 3
			    if lv >= 125 then
			        sl = 6
		        elseif lv >= 75 then
			        sl = 5
		        elseif lv >= 50 then
			        sl = 4
			    end
			    if 取随机数()<=40 and 攻击方.法术状态.狂怒 and 攻击方.法术状态.狂怒.狂乱~=nil then
					sl = sl + 1
				end
				if 攻击方.法术状态.背水 then
					sl = sl + 1
				end
				if math.random(100)<=50 then
									sl = sl + 1
				end
				return sl
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.法术状态.魔息术 and 攻击方.法术状态.魔息术.魔息~=nil then
					return  mbs , "魔法"
				end
				return  30*mbs , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=2}
			end,
		},
		侵蚀·鹰击·钻心 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = 3
			    if lv >= 125 then
			        sl = 6
		        elseif lv >= 75 then
			        sl = 5
		        elseif lv >= 50 then
			        sl = 4
			    end
			    if 取随机数()<=40 and 攻击方.法术状态.狂怒 and 攻击方.法术状态.狂怒.狂乱~=nil then
					sl = sl + 1
				end
				if 攻击方.法术状态.背水 then
					sl = sl + 1
				end
				if math.random(100)<=80 then
									sl = sl + 1
				end
				return sl
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.法术状态.魔息术 and 攻击方.法术状态.魔息术.魔息~=nil then
					return  mbs , "魔法"
				end
				return  30*mbs , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=2}
			end,
		},
		侵蚀·鹰击·噬魂 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = 3
			    if lv >= 125 then
			        sl = 6
		        elseif lv >= 75 then
			        sl = 5
		        elseif lv >= 50 then
			        sl = 4
			    end
			    if 取随机数()<=40 and 攻击方.法术状态.狂怒 and 攻击方.法术状态.狂怒.狂乱~=nil then
					sl = sl + 1
				end
				if 攻击方.法术状态.背水 then
					sl = sl + 1
				end
				if math.random(100)<=100 then
									sl = sl + 1
				end
				return sl
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.法术状态.魔息术 and 攻击方.法术状态.魔息术.魔息~=nil then
					return  mbs , "魔法"
				end
				return  30*mbs , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=2}
			end,
		},
		疯狂鹰击 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK) --若自身气血≥98%(化圣1)/94%(化圣5)/90%(化圣9)则额外作用两个目标
			    local sl = 6
			    if 攻击方.气血>=攻击方.最大气血*0.9 then
			        sl = 8
			    end
			    if 攻击方.法术状态.背水 then
					sl = sl + 1
				end
				return sl
			end,
			技能消耗 = function(mbs,攻击方) --技能消耗：400(化圣1)/200(化圣5)/50(化圣9)点魔法，1个金鸦火羽
			    if 攻击方.法术状态.魔息术 and 攻击方.法术状态.魔息术.魔息~=nil then
					return  1 , "金鸦火羽（高级）"
				end
				return  100 , "金鸦火羽（高级）"
			end,
		},
		狮搏 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
--------------------------18奇技狮驼岭1-------------------------------
			if self:取门派秘籍(攻击方.玩家id,"狮驼岭A") >=1 and not PK then
  				return math.floor(self:取门派秘籍(攻击方.玩家id,"狮驼岭A")/25)
  			else
  				return 1
  			end
--------------------------18奇技狮驼岭1-------------------------------
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.法术状态.魔息术 and 攻击方.法术状态.魔息术.魔息~=nil then
					return  1 , "魔法"
				end
				return  30 , "魔法"
			end,
		},
		困兽之斗 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.气血 > 攻击方.最大气血 * 0.1 then
			    	if 攻击方.法术状态.魔息术 and 攻击方.法术状态.魔息术.魔息~=nil then
						return  1 , "魔法和气血"
					end
			        return  100 , "魔法和气血"
			    end
			end,
		},
		象形 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.法术状态.魔息术 and 攻击方.法术状态.魔息术.魔息~=nil then
					return  1 , "魔法"
				end
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2}
			end,
		},
		象形（休息） = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2}
			end,
		},
		爪印 = {
		    不可驱散=true,
		    层数上限=5,
		    刷新回合=5,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=5,层数=1}
			end,
		},
		狂战 = {
		    不可驱散=true,
		    层数上限=4,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150,层数=1}
			end,
		},

		鹰啸 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2,伤害=qz(sx.伤害*0.32),法伤=qz(sx.法伤*0.32)}
			end,
		},
		狂袭 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=1}
			end,
		},
		背水 = {
		    刷新回合=2,
		    不可驱散=true,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=1}
			end,
		},
		肝胆 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150}
			end,
		},
		长啸 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=1}
			end,
		},
		威慑 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.法术状态.魔息术 and 攻击方.法术状态.魔息术.魔息~=nil then
					return  1 , "魔法"
				end
				return  20 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 1
				if lv >= 125 then
			        hh = 6
			    elseif lv >= 100 then
			        hh = 5
		        elseif lv >= 75 then
			        hh = 4
		        elseif lv >= 45 then
			        hh = 3
		        elseif lv >= 25 then
			        hh = 2
			    end
			    if 指定 then
				    hh = 指定
				end
			    return {状态回合=hh}
			end,
		},
		定心术 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.法术状态.魔息术 and 攻击方.法术状态.魔息术.魔息~=nil then
					return  1 , "魔法"
				end
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 12
				if lv >= 160 then
			        hh = 12
			    elseif lv >= 120 then
			        hh = 12
		        elseif lv >= 80 then
			        hh = 12
		        elseif lv >= 60 then
			        hh = 12
			    end
			    return {类型=2 ,状态回合=hh ,法伤 =qz(lv*1.5),法防 =qz(lv*1.5)}
			end,
		},
		魔息术 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "气血"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 6
				if lv >= 150 then
					hh = 6
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		--------------------
		玄灵珠·破军 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "无"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150}
			end,
		},
		玄灵珠·回春 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "无"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2}
			end,
		},
		玄灵珠·空灵 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "无"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150}
			end,
		},
		玄灵珠·噬魂 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "无"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150}
			end,
		},
		--------------------
		连环击 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 175 then
			        return 7
		        elseif lv >= 125 then
			        return 6
		        elseif lv >= 75 then
			        return 5
		        elseif lv >= 50 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.法术状态.魔息术 and 攻击方.法术状态.魔息术.魔息~=nil then
					return  mbs , "魔法"
				end
				return  30*mbs , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2}
			end,
		},
		极度疯狂 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.法术状态.魔息术 and 攻击方.法术状态.魔息术.魔息~=nil then
					return  1 , "魔法"
				end
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 5
				if lv >= 160 then
			        hh = 9
			    elseif lv >= 120 then
			        hh = 9
		        elseif lv >= 80 then
			        hh = 9
		        elseif lv >= 40 then
			        hh = 9
			    end
			    return {类型=2,状态回合=hh}
			end,
		},

		--====================大唐官府====================--
		杀气诀 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 12
				if lv >= 160 then
			        hh = 12
			    elseif lv >= 120 then
			        hh = 12
		        elseif lv >= 80 then
			        hh = 12
		        elseif lv >= 40 then
			        hh = 12
			    end
			    return {类型=2,状态回合=hh,伤害=qz(lv*1.3),命中=qz(lv*2)}
			end,
		},
		惊锋 = {
			层数上限=12,
		    不可驱散=true,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=150,层数=1}
			end,
		},
		翩鸿一击 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=2,速度=qz(sx.速度*0.15)}
			end,
		},
		长驱直入 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		重创 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2}
			end,
		},
		烈火焚原 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=3}
			end,
		},
		毁灭之光 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=1}
			end,
		},
		秘传封印 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2}
			end,
		},
		攻伐 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=3}
			end,
		},

		后发制人 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.气血 >= 攻击方.最大气血 * 0.05 then
				    return  0 , "无消耗"
				end
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=2,防御 = qz(lv * 3.5),法防 = qz(lv * 2),伤害 = qz(lv * 3.5),速度 = 9999}
			end,
		},
		摧枯拉朽 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  300 , "魔法"
			end,
		},
		披挂上阵 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.气血 >= 攻击方.最大气血 * 0.5 then
					return  0 , "无消耗"
				end
				if 攻击方.法术状态.干将莫邪~= nil and 攻击方.JM.神凝 then
					return true
				end
			end,
		},
		横扫千军 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.气血 >= 攻击方.最大气血 * 0.5 then
					return  0 , "无消耗"
				end
				if 攻击方.法术状态.干将莫邪~= nil and 攻击方.JM.神凝 then
					return true
				end
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2,防御 = qz(sx.防御 *0.1),法防 = qz(sx.法防 *0.05)}
			end,
		},
		侵蚀·横扫千军·刻骨 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.气血 >= 攻击方.最大气血 * 0.05 then
					return  0 , "无消耗"
				end
				if 攻击方.法术状态.干将莫邪~= nil and 攻击方.JM.神凝 then
					return true
				end
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2,防御 = qz(sx.防御 *0.1),法防 = qz(sx.法防 *0.05)}
			end,
		},
		侵蚀·横扫千军·钻心 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.气血 >= 攻击方.最大气血 * 0.05 then
					return  0 , "无消耗"
				end
				if 攻击方.法术状态.干将莫邪~= nil and 攻击方.JM.神凝 then
					return true
				end
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2,防御 = qz(sx.防御 *0.1),法防 = qz(sx.法防 *0.05)}
			end,
		},
		侵蚀·横扫千军·噬魂 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.气血 >= 攻击方.最大气血 * 0.05 then
					return  0 , "无消耗"
				end
				if 攻击方.法术状态.干将莫邪~= nil and 攻击方.JM.神凝 then
					return true
				end
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2,防御 = qz(sx.防御 *0.1),法防 = qz(sx.法防 *0.05)}
			end,
		},
		破釜沉舟 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方,PK)
				if PK then
					if 攻击方.气血 >= 攻击方.最大气血 * 0.1 and 攻击方.气血 < 攻击方.最大气血 * 0.5 then
						return  0 , "无消耗"
					end
				else
				    if 攻击方.气血 >= 攻击方.最大气血 * 0.1 then
				    	return  0 , "无消耗"
				    end
				end
				if 攻击方.法术状态.干将莫邪~= nil and 攻击方.JM.神凝 then
					return  0 , "无消耗"
				end
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2,防御 = qz(sx.防御 *0.1),法防 = qz(sx.法防 *0.05)}
			end,
		},
		反间之计 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 100 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 3
			    if lv >= 160 then
			        hh = 3
		        elseif lv >= 120 then
			        hh = 3
		        elseif lv >= 80 then
			        hh = 2
		        elseif lv >= 40 then
			        hh = 2
			    end
			    return {状态回合=hh}
			end,
		},
		风魂 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150}
			end,
		},
		剑意 = {
			层数上限=150,
			不可驱散=true,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150,层数=1}
			end,
		},
		傲视 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=6}
			end,
		},
		干将莫邪 = {
			技能类型="增益技能",
            指定对象="自己",
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=4}
			end,
		},
		安神诀 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 7
			    if lv >= 150 then
			        hh = 7
			    end
			    return {状态回合=8,法防 = qz(lv*1.8),法伤 = qz(lv*1.8)}
			end,
		},
		其疾如风 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 5
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "金鸦火羽（高级）"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=2}
			end,
		},
		其徐如林 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "金鸦火羽（高级）"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=2}
			end,
		},
		侵掠如火 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 5
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "金鸦火羽（高级）"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=2}
			end,
		},
		岿然如山 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 5
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "金鸦火羽（高级）"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=2}
			end,
		},
		惊天动地 = {
			技能类型="特殊技能",
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=1,状态回合=2}
			end,
		},

		--====================化生寺====================--
		佛法无边 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.JM.自在 then
				    return 0 , "魔法"
				end
				return  150 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 6
				if lv >= 150 then
			        hh = 6
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		妙悟 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=3,速度 = qz(lv*0.2)}
			end,
		},
		唧唧歪歪 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 150 then
			        return 7
		        elseif lv >= 125 then
			        return 6
		        elseif lv >= 100 then
			        return 5
		        elseif lv >= 75 then
			        return 4
		        elseif lv >= 50 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.气血 > 5 then
			    	if 攻击方.法术状态.诵经 then
			    	    return  30*mbs+140 , "魔法"
			    	end
					return  30*mbs , "魔法"
				end
			end,
		},
		侵蚀·唧唧歪歪·刻骨 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 150 then
			        return 8
		        elseif lv >= 125 then
			        return 7
		        elseif lv >= 100 then
			        return 6
		        elseif lv >= 75 then
			        return 5
		        elseif lv >= 50 then
			        return 4
			    else
			        return 3
			    end
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.气血 > 5 then
			    	if 攻击方.法术状态.诵经 then
			    	    return  30*mbs+140 , "魔法"
			    	end
					return  30*mbs , "魔法"
				end
			end,
		},
		侵蚀·唧唧歪歪·钻心 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 150 then
			        return 9
		        elseif lv >= 125 then
			        return 8
		        elseif lv >= 100 then
			        return 7
		        elseif lv >= 75 then
			        return 6
		        elseif lv >= 50 then
			        return 5
			    else
			        return 4
			    end
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.气血 > 5 then
			    	if 攻击方.法术状态.诵经 then
			    	    return  30*mbs+140 , "魔法"
			    	end
					return  30*mbs , "魔法"
				end
			end,
		},
		侵蚀·唧唧歪歪·噬魂 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 150 then
			        return 10
		        elseif lv >= 125 then
			        return 9
		        elseif lv >= 100 then
			        return 8
		        elseif lv >= 75 then
			        return 7
		        elseif lv >= 50 then
			        return 6
			    else
			        return 5
			    end
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.气血 > 5 then
			    	if 攻击方.法术状态.诵经 then
			    	    return  30*mbs+140 , "魔法"
			    	end
					return  30*mbs , "魔法"
				end
			end,
		},
		韦陀护法 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
			    if 攻击方.JM.无碍 then
				    return 1
				end
			    if lv >= 150 then
			        return 6
		        elseif lv >= 120 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 60 then
			        return 4
		        elseif lv >= 30 then
			        return 2
			    else
			        return 1
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 4
			    if lv >= 160 then
			        hh = 12
		        elseif lv >= 120 then
			        hh = 12
		        elseif lv >= 80 then
			        hh = 12
		        elseif lv >= 40 then
			        hh = 12
			    end
			    local 命中1 = lv*2
				local 伤害1 = qz(lv*0.5)
				if 攻击方.JM.感念 then
				    hh = 1
					命中1 = qz(命中1*1.5)
					伤害1 = qz(伤害1*1.5)
				elseif 攻击方.JM.无碍 then
					命中1 = qz(命中1*2)
					伤害1 = qz(伤害1*2)
				end
			    return {类型=2,状态回合=hh,伤害=伤害1,命中=命中1}
			end,
		},

		金刚护法 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
			    if 攻击方.JM.映法 and 取随机数() <= 50 then
					return 10
				end

--------------------------18奇技化生寺2-------------------------------
			local 附加人数=0
			if self:取门派秘籍(攻击方.玩家id,"化生寺A") >=1  and not PK then
  				附加人数 = math.floor(self:取门派秘籍(攻击方.玩家id,"化生寺A")/36)
  			end
--------------------------18奇技化生寺2-------------------------------

			if lv >= 125 then
			        return 5 + 附加人数
		        elseif lv >= 75 then
			        return 4 + 附加人数
		        elseif lv >= 50 then
			        return 3 + 附加人数
			    else
			        return 2 + 附加人数
			end


			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 12
				if lv >= 150 then
			        hh = 12
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		------------------
		真阳令旗 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
			    if 攻击方.灵元~=nil and 攻击方.灵元>=3 then
					return 3
				elseif 攻击方.灵元~=nil and 攻击方.灵元 >=1 then
					return 攻击方.灵元
			    else
			        return 1
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  1 , "灵元"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=150}
			end,
		},
		赤炎战笛 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  1 , "灵元"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=1}
			end,
		},
		-------------------
		侵蚀·嗔怒金刚·刻骨 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
					return 10
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 2
			    return {类型=2,状态回合=hh}
			end,
		},
		侵蚀·嗔怒金刚·钻心 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
					return 10
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 2
			    return {类型=2,状态回合=hh}
			end,
		},
		侵蚀·嗔怒金刚·噬魂 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
					return 10
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 2
			    return {类型=2,状态回合=hh}
			end,
		},
		一苇渡江 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
			    if 攻击方.JM.映法 and 取随机数() <= 50 then
					return 10
				end
			    if lv >= 150 then
			        return 7
			    elseif lv >= 125 then
			        return 6
		        elseif lv >= 100 then
			        return 5
		        elseif lv >= 75 then
			        return 4
			    elseif lv >= 50 then
			        return 3
			    else
			    	return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 12
				if lv >= 150 then
			        hh = 12
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		诸天看护 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法和愤怒" --100点魔法，10点愤怒
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=150,层数=指定}
			end,
		},
		诵经 = {
			层数上限=5,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=150,层数=1}
			end,
		},
		功德无量 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  1 , "金鸦火羽（高级）"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=3}
			end,
		},

		仁心 = {
		    层数上限=5,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=150,层数=1}
			end,
		},

		渡劫金身 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  10 , "愤怒"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=2}
			end,
		},
		醍醐灌顶 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  1 , "金鸦火羽（高级）"
			end,
		},
		我佛慈悲 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  150 , "魔法"
			end,
		},
		推拿 = {
			技能类型="恢复技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		解毒 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
		},
		活血 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  70 , "魔法"
			end,
		},
		推气过宫 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
			    if (攻击方.名称 == "天罡星" or 攻击方.名称 == "蜘蛛女王") and 攻击方.队伍 == 0 then
					return 取随机数(5,10)
				end
				local sl = 2
			    if lv >= 150 then
			        sl = 6
		        elseif lv >= 100 then
			        sl = 5
		        elseif lv >= 75 then
			        sl = 4
		        elseif lv >= 45 then
			        sl = 3
			    end
			    if 攻击方.JM.虔诚 and  时辰信息.天气==2 then
					sl = sl + 1
				end
				return sl
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
		},
		妙手回春 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 150 then
			        return 6
		        elseif lv >= 100 then
			        return 5
		        elseif lv >= 75 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  80 , "魔法"
			end,
		},
		救死扶伤 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 150 then
			        return 6
		        elseif lv >= 100 then
			        return 5
		        elseif lv >= 75 then
			        return 4
		        elseif lv >= 50 then
			        return 3
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  150 , "魔法"
			end,
		},
		六尘不染 = {
			技能类型="恢复技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
		},
		舍生取义 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  150 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150 ,防御 = qz(sx.防御 * 0.05),法防 = qz(sx.法防 * 0.03)}
			end,
		},
		谆谆教诲 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "魔法和愤怒"
			end,
		},

    --====================魔王寨====================--
	    飞砂走石 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			   if lv >= 100 then
			        return 5
		        elseif lv >= 75 then
			        return 4
			    elseif lv >= 50 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
		},

		秘传飞砂走石 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 100 then
			        return 5
		        elseif lv >= 75 then
			        return 4
		        elseif lv >= 50 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "魔法和愤怒"
			end,
		},
	    风云变色 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 100 then
			        return 6
		        elseif lv >= 75 then
			        return 5
		        elseif lv >= 50 then
			        return 4
			    else
			        return 3
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
		},
		魔焰滔天 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "魔法"
			end,
		},
		秘传三昧真火 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "魔法和愤怒"
			end,
		},
		魔火焚世 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 5
			end,
			技能消耗 = function(mbs,攻击方)
				return  400 , "金鸦火羽（高级）"
			end,
		},
		三昧真火 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		摇头摆尾 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  80 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 4
				if lv >= 160 then
			        hh = 5
			    end
			    return {状态回合=hh}
			end,
		},
		火甲术 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 6
				if lv >= 150 then
			        hh = 6
			    end
			    return {状态回合=hh}
			end,
		},
		牛劲 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=12}
			end,
		},
		炙烤 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=指定}
			end,
		},
    	烈火真言 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
		},
		风火燎原 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			return {类型=2,状态回合=6}
			end,
		},
		魔王回首 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 5
			    if lv >= 160 then
			        hh = 9
		        elseif lv >= 120 then
			        hh = 9
		        elseif lv >= 80 then
			        hh = 9
		        elseif lv >= 40 then
			        hh = 9
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		魔冥 = {
		    层数上限=4,
		    刷新回合=4,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=4,层数=1}
			end,
		},
		燃魂 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=4}
			end,
		},
		蚀天 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    if 指定 then
				    return {状态回合=指定}
				end
			    return {状态回合=4}
			end,
		},
		赤焰 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=3}
			end,
		},



    --====================神木林====================--
        侵蚀·魔化万灵·刻骨 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  80 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 4
				if lv >= 160 then
			        hh = 5
			    end
			    return {状态回合=hh}
			end,
		},
		侵蚀·魔化万灵·噬魂 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  80 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 4
				if lv >= 160 then
			        hh = 5
			    end
			    return {状态回合=hh}
			end,
		},
		侵蚀·魔化万灵·钻心 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  80 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 4
				if lv >= 160 then
			        hh = 5
			    end
			    return {状态回合=hh}
			end,
		},
	    蛊木迷瘴 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 100 then
			        return 5
		        elseif lv >= 75 then
			        return 4
		        elseif lv >= 50 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
		},
	    落叶萧萧 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 100 then
			        return 5
		        elseif lv >= 75 then
			        return 4
		        elseif lv >= 50 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
		},
		风卷残云 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 100 then
			        return 5
		        elseif lv >= 75 then
			        return 4
		        elseif lv >= 50 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
		},
		荆棘舞 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		尘土刃 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		冰川怒 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {状态回合=2}
			end,
		},
		雾杀 = {
			技能类型="减益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    local cs = 1
		        if 指定 then
				    cs = 指定
				end
				return {状态回合=4,层数=cs}
			end,
		},
		凋零之歌 = {
			技能类型="减益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {状态回合=2}
			end,
		},
		血雨 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.气血 >= 攻击方.最大气血 * 0.2 then
					return  0 , "无消耗"
				end
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {状态回合=2}
			end,
		},
		星月之惠 = {
			技能类型="恢复技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		炎护 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=6}
			end,
		},
		蔓延 = {
		    刷新回合=4,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=4}
			end,
		},
		毒萃 = {
		    技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  300 , "风灵"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=5}
			end,
		},

		风灵 = {
			不可驱散=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "金鸦火羽（高级）"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定) --效果未写
			    return {类型=2,状态回合=150}
			end,
		},
		凭虚御风 = {
			层数上限=3,
		    不可驱散=true,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=150,层数=1}
			end,
		},
		花语歌谣 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "金鸦火羽（高级）"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定) --效果未写
			    return {类型=2,状态回合=150}
			end,
		},
		木精 = {
		    层数上限=3,
		    不可驱散=true,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    if 指定>=3 then
			        指定=3
			    end
			    return {类型=2,状态回合=150,层数=指定}
			end,
		},
		疾风秋叶 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = 4
			    if lv >= 100 then
			        sl = 6
		        elseif lv >= 75 then
			        sl = 5
			    end
			    if 攻击方.JM.凉秋 then
					sl = sl + 1
				end
				return sl
			end,
			技能消耗 = function(mbs,攻击方)
				return  mbs*mbs , "木精"
			end,
		},
		枯木逢春 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "木精"
			end,
		},
		古藤秘咒 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "木精"
			end,
		},
		蜜润 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    if 攻击方.JM.滋养 then
				    return 1
				end
			    if lv >= 150 then
			        return 3
		        else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  25*mbs , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 9
			    if lv >= 175 then
			        hh = 9
		        elseif lv >= 140 then
			        hh = 8
			    end
			    return {类型=2,状态回合=hh}
			end,
		},

    --====================方寸山====================--
	    五雷咒 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
	             侵蚀·五雷咒·钻心 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		侵蚀·五雷咒·噬魂 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		侵蚀·五雷咒·刻骨 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		落雷符 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 60 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
		},
		五雷正法 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		侵蚀·五雷正法·钻心 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		侵蚀·五雷正法·噬魂 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		侵蚀·五雷正法·刻骨 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		 符咒 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150}
			end,
		},
		雷法·崩裂 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150}
			end,
		},
		雷法·震煞 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150}
			end,
		},
		雷法·坤伏 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150}
			end,
		},
		雷法·轰天 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150}
			end,
		},
		雷法·翻天 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150}
			end,
		},
		雷法·倒海 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150}
			end,
		},
		顺势而为 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "愤怒"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2}
			end,
		},
		催眠符 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  45 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 1
				if lv >= 125 then
			        hh = 4
			    elseif lv >= 100 then
			        hh = 4
		        elseif lv >= 75 then
			        hh = 3
		        elseif lv >= 45 then
			        hh = 2
			    end
			    return {状态回合=hh}
			end,
		},
		落魄符 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 1
				if lv >= 125 then
			        hh = 6
			    elseif lv >= 100 then
			        hh = 5
		        elseif lv >= 75 then
			        hh = 4
		        elseif lv >= 45 then
			        hh = 3
		        elseif lv >= 25 then
			        hh = 2
			    end
			    return {状态回合=hh}
			end,
		},
		追魂符 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  55 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 2
				if lv >= 125 then
			        hh = 7
			    elseif lv >= 100 then
			        hh = 6
		        elseif lv >= 75 then
			        hh = 5
		        elseif lv >= 45 then
			        hh = 4
		        elseif lv >= 25 then
			        hh = 3
			    end
			    return {状态回合=hh,防御 = lv * 2,负面="减防御"}
			end,
		},
		失忆符 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 2
				if lv >= 125 then
			        hh = 7
			    elseif lv >= 100 then
			        hh = 6
		        elseif lv >= 75 then
			        hh = 5
		        elseif lv >= 45 then
			        hh = 4
		        elseif lv >= 25 then
			        hh = 3
			    end
			    return {状态回合=hh}
			end,
		},
		定身符 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 3
				if lv >= 125 then
			        hh = 7
			    elseif lv >= 100 then
			        hh = 6
		        elseif lv >= 75 then
			        hh = 5
		        elseif lv >= 45 then
			        hh = 4
			    end
			    local zhi = 0.05
			    if 攻击方.JM.苦缠 or 攻击方.JM.灵咒 then
					zhi = 0.08
				end
				local 防御1 = qz(sx.防御 * zhi)
			    local 法防1 = qz(sx.法防 * zhi)
			    return {状态回合=hh,防御=防御1,法防=法防1,负面="减双抗"}
			end,
		},
		失魂符 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 2
				if lv >= 125 then
			        hh = 6
			    elseif lv >= 100 then
			        hh = 5
		        elseif lv >= 75 then
			        hh = 4
		        elseif lv >= 45 then
			        hh = 3
			    end
			    local zhi = 0.1
				if 攻击方.JM.苦缠 or 攻击方.JM.灵咒 then
					zhi = 0.13
				end
			    return {状态回合=hh,防御=qz(sx.防御 * zhi),负面="减防御"}
			end,
		},
		侵蚀·失魂符·刻骨 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 2
				if lv >= 125 then
			        hh = 6
			    elseif lv >= 100 then
			        hh = 5
		        elseif lv >= 75 then
			        hh = 4
		        elseif lv >= 45 then
			        hh = 3
			    end
			    local zhi = 0.1*1.05
				if 攻击方.JM.苦缠 or 攻击方.JM.灵咒 then
					zhi = 0.13
				end
			    return {状态回合=hh,防御=qz(sx.防御 * zhi),负面="减防御"}
			end,
		},
		侵蚀·失魂符·钻心 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 2
				if lv >= 125 then
			        hh = 6
			    elseif lv >= 100 then
			        hh = 5
		        elseif lv >= 75 then
			        hh = 4
		        elseif lv >= 45 then
			        hh = 3
			    end
			    local zhi = 0.1*1.08
				if 攻击方.JM.苦缠 or 攻击方.JM.灵咒 then
					zhi = 0.13
				end
			    return {状态回合=hh,防御=qz(sx.防御 * zhi),负面="减防御"}
			end,
		},
		侵蚀·失魂符·噬魂 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 2
				if lv >= 125 then
			        hh = 6
			    elseif lv >= 100 then
			        hh = 5
		        elseif lv >= 75 then
			        hh = 4
		        elseif lv >= 45 then
			        hh = 3
			    end
			    local zhi = 0.1*1.1
				if 攻击方.JM.苦缠 or 攻击方.JM.灵咒 then
					zhi = 0.13
				end
			    return {状态回合=hh,防御=qz(sx.防御 * zhi),负面="减防御"}
			end,
		},
		-- 离魂符 = {
		-- 	技能类型="单体封印",
		-- 	技能人数 = function(lv,攻击方,PK)
		-- 	    return 1
		-- 	end,
		-- 	技能消耗 = function(mbs,攻击方)
		-- 		return  50 , "魔法"
		-- 	end,
		-- 	状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
		-- 		local hh = 2
		-- 		if lv >= 125 then
		-- 	        hh = 6
		-- 	    elseif lv >= 100 then
		-- 	        hh = 5
		--         elseif lv >= 75 then
		-- 	        hh = 4
		--         elseif lv >= 45 then
		-- 	        hh = 3
		-- 	    end
		-- 	    return {状态回合=hh,躲避 = lv}
		-- 	end,
		-- },
		失心符 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 1
				if lv >= 125 then
			        hh = 6
			    elseif lv >= 100 then
			        hh = 5
		        elseif lv >= 75 then
			        hh = 4
		        elseif lv >= 45 then
			        hh = 3
		        elseif lv >= 25 then
			        hh = 2
			    end
			    local zhi = 0.1
				if 攻击方.JM.苦缠 or 攻击方.JM.灵咒 then
					zhi = 0.13
				end
			    return {状态回合=hh,法防=qz(sx.法防 * zhi),负面="减法防"}
			end,
		},
		碎甲符 = {
			技能类型="群体封印",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 150 then
			        return 4
		        elseif lv >= 120 then
			        return 3
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50*mbs , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 4
				if lv >= 150 then
			        hh = 5
			    end
			    return {状态回合=hh}
			end,
		},
		归元咒 = {
			技能类型="恢复技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  20 , "魔法"
			end,
		},
		凝神术 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=10}
			end,
		},
		练魂 = {
		    不可驱散=true,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150}
			end,
		},
		炼魂 = {
		    不可驱散=true,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150}
			end,
		},
		摧心 = {
		    刷新回合=3,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=3,伤害 = qz(sx.伤害 * 0.12),防御 = qz(sx.防御 * 0.12),法伤 = qz(sx.法伤 * 0.12),法防 = qz(sx.法防 * 0.12)}
			end,
		},

		怒霆 = {
		    层数上限=5,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150,层数=1}
			end,
		},

		钟馗论道 = {
			技能类型="增益技能",
			指定对象="自己",
			不可驱散=true,
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.气血 >= 攻击方.最大气血 * 0.5 then
					return  80 , "魔法和气血"
				end
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=5}
			end,
		},
		乾天罡气 = {
			技能类型="恢复技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.气血 > 20 then
					return  0 , "无消耗"
				end
			end,
		},
		分身术 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  80 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 6
				if lv >= 150 then
			        hh = 6
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		否极泰来 = {
			技能类型="减益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "金鸦火羽（高级）"
			end,
		},
    --====================女儿村====================--
	    楚楚可怜 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 5
				if lv >= 160 then
			        hh = 9
			    elseif lv >= 120 then
			        hh = 8
		        elseif lv >= 80 then
			        hh = 7
		        elseif lv >= 40 then
			        hh = 6
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		一笑倾城 = {
			技能类型="群体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    if 攻击方.JM.嫣然 and 取随机数()<=40 then
					return {状态回合=3}
				end
			    return {状态回合=2}
			end,
		},
		满天花雨 = {
			技能类型="物攻技能",
			佛法加成=true,
			层数上限=3,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=150,层数=1}
			end,
		},
		花谢花飞 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
		},
		花护 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=1}
			end,
		},
		毒 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=5}
			end,
		},
		自矜 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=150}
			end,
		},

		空灵 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=1}
			end,
		},
		淬芒 = {
		    层数上限=2,
		    刷新回合=3,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=3,层数=1}
			end,
		},

		雨落寒沙 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if 攻击方.队伍==0 then
			    --     return 1
			    -- end
			    local sl = 2
			    if lv >= 150 then
			        sl = 7
		        elseif lv >= 125 then
			        sl = 6
		        elseif lv >= 100 then
			        sl = 5
		        elseif lv >= 75 then
			        sl = 4
		        elseif lv >= 50 then
			        sl = 3
			    end
			    if 攻击方.JM.百花 and 取随机数() <= 9 then
				    sl = sl + 3
				end
				return sl
			end,
			技能消耗 = function(mbs,攻击方)
				return  10*mbs , "魔法"
			end,
		},
		子母神针 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    return 2
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "魔法和愤怒"
			end,
		},
		鸿渐于陆 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
		},
		莲步轻舞 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 2
			    if lv >= 125 then
			        hh = 6
		        elseif lv >= 100 then
			        hh = 5
		        elseif lv >= 75 then
			        hh = 4
		        elseif lv >= 45 then
			        hh = 3
			    end
			    return {状态回合=hh}
			end,
		},
		如花解语 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  35 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 2
			    if lv >= 125 then
			        hh = 7
		        elseif lv >= 100 then
			        hh = 6
		        elseif lv >= 75 then
			        hh = 5
		        elseif lv >= 45 then
			        hh = 4
		        elseif lv >= 25 then
			        hh = 3
			    end
			    return {状态回合=hh}
			end,
		},
		似玉生香 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 1
			    if lv >= 125 then
			        hh = 6
		        elseif lv >= 100 then
			        hh = 5
		        elseif lv >= 75 then
			        hh = 4
		        elseif lv >= 45 then
			        hh = 3
		        elseif lv >= 25 then
			        hh = 2
			    end
			    if 攻击方.JM.嫣然 then
					hh = hh + 1
				end
			    return {状态回合=hh}
			end,
		},
		侵蚀·似玉生香·刻骨 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 1
			    if lv >= 125 then
			        hh = 7
		        elseif lv >= 100 then
			        hh = 6
		        elseif lv >= 75 then
			        hh = 5
		        elseif lv >= 45 then
			        hh = 4
		        elseif lv >= 25 then
			        hh = 3
			    end
			    if 攻击方.JM.嫣然 then
					hh = hh + 1
				end
			    return {状态回合=hh}
			end,
		},
		侵蚀·似玉生香·钻心 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 1
			    if lv >= 125 then
			        hh = 8
		        elseif lv >= 100 then
			        hh = 7
		        elseif lv >= 75 then
			        hh = 6
		        elseif lv >= 45 then
			        hh = 5
		        elseif lv >= 25 then
			        hh = 4
			    end
			    if 攻击方.JM.嫣然 then
					hh = hh + 1
				end
			    return {状态回合=hh}
			end,
		},
		侵蚀·似玉生香·噬魂 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 1
			    if lv >= 125 then
			        hh = 9
		        elseif lv >= 100 then
			        hh = 8
		        elseif lv >= 75 then
			        hh = 7
		        elseif lv >= 45 then
			        hh = 6
		        elseif lv >= 25 then
			        hh = 5
			    end
			    if 攻击方.JM.嫣然 then
					hh = hh + 1
				end
			    return {状态回合=hh}
			end,
		},
		碎玉弄影 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "愤怒"
			end,
		},
		娉婷袅娜 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 2
			    if lv >= 125 then
			        hh = 7
		        elseif lv >= 100 then
			        hh = 6
		        elseif lv >= 75 then
			        hh = 5
		        elseif lv >= 45 then
			        hh = 4
			    end
			    return {状态回合=hh}
			end,
		},
		月下霓裳 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "金鸦火羽（高级）"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=4}
			end,
		},
		百毒不侵 = {
			技能类型="恢复技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 6
			    if lv >= 160 then
			        hh = 10
		        elseif lv >= 120 then
			        hh = 9
		        elseif lv >= 80 then
			        hh = 8
		        elseif lv >= 40 then
			        hh = 7
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		葬玉焚花 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 4
			end,
			技能消耗 = function(mbs,攻击方)
				return  20*mbs , "魔法"
			end,
		},
		侵蚀·葬玉焚花·钻心 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 4
			end,
			技能消耗 = function(mbs,攻击方)
				return  20*mbs , "魔法"
			end,
		},
		侵蚀·葬玉焚花·噬魂 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 4
			end,
			技能消耗 = function(mbs,攻击方)
				return  20*mbs , "魔法"
			end,
		},
		侵蚀·葬玉焚花·刻骨 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 4
			end,
			技能消耗 = function(mbs,攻击方)
				return  20*mbs , "魔法"
			end,
		},
		飞花摘叶 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = 3
			    if lv >= 150 then
			        sl = 4
			    end
			    if 攻击方.JM.花殇 then
					sl = sl + 6
				end
				return sl
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "魔法"
			end,
		},

    --====================天宫====================--
    	天眼神通 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  300 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=6}
			end,
		},
		耳目一新 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  300 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=1}
			end,
		},
		天眼 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=6}
			end,
		},
		怒眼 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=6}
			end,
		},
		智眼 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=6}
			end,
		},
	    电光火石 = {
			技能类型="恢复技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  140 , "魔法"
			end,
		},
	    霹雳弦惊 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  70 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    local hh=6
			    if 攻击方.JM.激越 then
			        hh=4
			        攻击方.法术状态.霹雳弦惊.激越=1
			    end
			    if 攻击方.JM.气势 then
			        if 挨打方.霹雳弦惊==nil then
			            hh = qz(hh*1.5)
			            挨打方.霹雳弦惊 = 1
			        end
			    end
			    if 攻击方.JM.啸傲 then
			    	return {类型=2,状态回合=hh,层数=1}
				end

			    return {类型=2,状态回合=hh}
			end,
		},
		雷怒霆激 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  70 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    local hh=6
			    local sh=0
			    if 攻击方.JM.激越 then
			        hh=4
			        攻击方.法术状态.雷怒霆激.激越=1
			    end
			    if 攻击方.JM.气势 then
			        if 挨打方.雷怒霆激==nil then
			            hh = qz(hh*1.5)
			            挨打方.雷怒霆激 = 1
			        end
			    end
			    if 攻击方.JM.啸傲 then
			    	return {类型=2,状态回合=hh,层数=1}
				end
			    return {类型=2,状态回合=hh}
			end,
		},
		天神护体 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 3
			    if lv >= 160 then
			        hh = 12
		        elseif lv >= 120 then
			        hh = 12
		        elseif lv >= 80 then
			        hh = 12
		        elseif lv >= 40 then
			        hh = 12
			    end
				local 法伤1 = qz(lv*1.5)
				local 法防1 = qz(lv*1.5)
				local 速度1 = 0
				local 防御1 = 0
				if 攻击方.JM.神律 then
				    法伤1 = 0
				    法防1 = qz(sx.法防 * 2)
				    速度1 = qz(lv*0.3)
				elseif 攻击方.JM.神尊 then
					法伤1 = 0
				    防御1 = qz(lv*1.5)
				end
			    return {类型=2,状态回合=hh,法伤=法伤1,防御=防御1,速度=速度1,法防=法防1}
			end,
		},
		-- 天神护法 = {
		-- 	技能类型="增益技能",
		-- 	技能人数 = function(lv,攻击方,PK)
		--         return 1
		-- 	end,
		-- 	技能消耗 = function(mbs,攻击方)
		-- 		return  30 , "魔法"
		-- 	end,
		-- 	状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
		-- 		local hh = 3
		-- 	    if lv >= 160 then
		-- 	        hh = 7
		--         elseif lv >= 120 then
		-- 	        hh = 6
		--         elseif lv >= 80 then
		-- 	        hh = 5
		--         elseif lv >= 40 then
		-- 	        hh = 4
		-- 	    end
		-- 	    return {类型=2,状态回合=hh}
		-- 	end,
		-- },
		威仪九霄 = {
		    技能类型="物攻技能",
		    技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*攻击方.法术状态.威仪九霄.层数 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150,层数=1}
			end,
		},
        轰鸣 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=3,防御=qz(lv*1.6)}
			end,
		},
		电芒 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    if 攻击方.JM.雷波 then
			        挨打方.法术状态.电芒.雷波=1
			    end
			    return {状态回合=指定}
			end,
		},
		趁虚 = {
			刷新回合=3,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=3}
			end,
		},
		存雄 = {
		    刷新回合=3,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=3,伤害=qz(sx.伤害*0.1)}
			end,
		},
		怒电 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150}
			end,
		},

		五雷轰顶 = {
			技能类型="固伤技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·五雷轰顶·刻骨 = {
			技能类型="固伤技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·五雷轰顶·钻心 = {
			技能类型="固伤技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·五雷轰顶·噬魂 = {
			技能类型="固伤技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		雷霆万钧 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
				return  35*mbs , "魔法"
			end,
		},
		侵蚀·雷霆万钧·钻心 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
				return  35*mbs , "魔法"
			end,
		},
		侵蚀·雷霆万钧·噬魂 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
				return  35*mbs , "魔法"
			end,
		},
		侵蚀·雷霆万钧·刻骨 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
				return  35*mbs , "魔法"
			end,
		},
		雷霆汹涌 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
				return  35*mbs , "魔法"
			end,
		},
		风雷韵动 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "魔法和愤怒"
			end,
		},
		天雷斩 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if PK then--or 攻击方.队伍==0 then
			        return 1
			    end
			    if lv >= 60 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local 法伤1 = qz(lv / 2)
				local 法防1 = qz(lv / 2)
				if 攻击方.天雷斩==nil then
				    攻击方.天雷斩=1
				    攻击方.防御=攻击方.防御-qz(lv / 2)
				end
			    return {状态回合=150,法伤=法伤1,法防=法防1}
			end,
		},
		风雷斩 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if 攻击方.法术状态.雷怒霆激 and 攻击方.法术状态.霹雳弦惊 then
			    	return 3
			    end
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		风雷斩·飞霆 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if 攻击方.法术状态.天雷灌注 then --这里用了会取消吗
			        return 6
			    end
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		风雷斩·霹雳 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		侵蚀·风雷斩·霹雳·刻骨 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		侵蚀·风雷斩·霹雳·噬魂 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		侵蚀·风雷斩·霹雳·钻心 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		鸣雷诀 = {
			技能类型="增益技能",
			指定对象="自己",
			不可驱散=true,
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "金鸦火羽（高级）"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=3}
			end,
		},
		宁心 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=4}
			end,
		},
		知己知彼 = {
		    刷新回合=3,
			技能类型="减益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  80 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=3,伤害=lv*2,防御=lv*2,法伤=lv*2,法防=lv*2}
			end,
		},
		画地为牢 = {
			技能类型="减益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=5}
			end,
		},
		镇妖 = {
			技能类型="群体封印",
			技能人数 = function(lv,攻击方,PK)
			    if 攻击方.缭乱~=nil and 取随机数()<=30 then
				    攻击方.缭乱=nil
				    return 2
				end
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 4
				if lv >= 125 then
			        hh = 7
		        elseif lv >= 100 then
			        hh = 6
		        elseif lv >= 75 then
			        hh = 5
			    end
			    return {状态回合=hh}
			end,
		},
		错乱 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 2
				if lv >= 125 then
			        hh = 4
		        elseif lv >= 100 then
			        hh = 3
		        elseif lv >= 75 then
			        hh = 3
		        elseif lv >= 45 then
			        hh = 2
			    end
			    return {状态回合=hh}
			end,
		},
		掌心雷 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    if 攻击方.JM.藏招 then
					return 2
				end
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 4
				if lv >= 125 then
			        hh = 7
		        elseif lv >= 100 then
			        hh = 6
		        elseif lv >= 75 then
			        hh = 5
			    end
			    return {状态回合=hh,防御 =  qz(lv*1.6)}
			end,
		},
		百万神兵 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 2
				if lv >= 125 then
			        hh = 7
		        elseif lv >= 100 then
			        hh = 6
		        elseif lv >= 75 then
			        hh = 5
		        elseif lv >= 45 then
			        hh = 4
		        elseif lv >= 25 then
			        hh = 3
			    end
			    return {状态回合=hh}
			end,
		},
		金刚镯 = {
			技能类型="减益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 3
				if lv >= 150 then
			        hh = 4
			    end
			    local 伤害1=qz(lv*3)
				if 攻击方.JM.套索 then
				    伤害1 = 伤害1 + qz(sx.伤害*0.1)
				    hh = hh + 1
				end
			    return {状态回合=hh,伤害=伤害1}
			end,
		},
		天雷灌注 = {
			技能类型="增益技能",
			指定对象="自己",
			不可驱散=true,
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.气血 > 攻击方.最大气血 * 0.25 then
			        return  100 , "魔法和气血"
			    end
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=150}
			end,
		},
    --====================普陀山====================--
	    普渡众生 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 10
				if lv >= 160 then
			        hh = 10
			    elseif lv >= 120 then
			        hh = 8
		        elseif lv >= 80 then
			        hh = 6
		        elseif lv >= 40 then
			        hh = 4
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		自在心法 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		波澜不惊 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=2}
			end
		},
		莲花心音 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "魔法"
			end,
		},
		清静菩提 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "金鸦火羽（高级）"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			   return {状态回合=1}
			end
		},
		灵动九天 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
			    if 攻击方.JM.法华 then
			    	return 1
			    end
--------------------------18奇技普陀山2-------------------------------
			local 附加人数=0
			if self:取门派秘籍(攻击方.玩家id,"普陀山A") >=1  and not PK then
  				附加人数 = math.floor(self:取门派秘籍(攻击方.玩家id,"普陀山A")/45)
  			end
--------------------------18奇技普陀山2-------------------------------
		        if lv >= 140 then
			        return 6 + 附加人数
			    else
			        return 5 + 附加人数
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 12
				if lv >= 160 then
			        hh = 12
			    end
				local 法伤1 = qz(lv)
				local 法防1 = qz(lv)
				if 攻击方.JM.法华 then
					法伤1=法伤1+100
					法防1=0
				elseif 攻击方.JM.灵动 then
					法伤1=法伤1+30
					法防1=法防1+30
					hh=hh+2
				end
			    return {类型=2,状态回合=hh,法伤=法伤1,法防=法防1}
			end,
		},
		紧箍咒 = {
			技能类型="减益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 4
				if lv >= 160 then
			        hh = 8
			    elseif lv >= 120 then
			        hh = 8
		        elseif lv >= 80 then
			        hh = 8
		        elseif lv >= 40 then
			        hh = 8
			    end
				return {状态回合=hh}
			end,
		},
		杨柳甘露 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  150 , "魔法"
			end,
		},
		剑意莲心 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=150}
			end,
		},
		莲音 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=3,伤害 = qz(sx.伤害*0.2)}
			end,
		},

		莲心剑意 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=150}
			end,
		},
		日光华 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    if PK then--or 攻击方.队伍==0 then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		靛沧海 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		巨岩破 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		苍茫树 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·日光华·噬魂 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·日光华·钻心 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·地裂火·噬魂 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·地裂火·钻心 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·巨岩破·噬魂 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·巨岩破·钻心 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·靛沧海·噬魂 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·靛沧海·钻心 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·靛沧海·刻骨 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·巨岩破·刻骨 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·地裂火·刻骨 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·日光华·刻骨 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·苍茫树·噬魂 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·苍茫树·钻心 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·苍茫树·刻骨 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		地裂火 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 180 then
			        return 6
		        elseif lv >= 135 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 45 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·五行攻击·刻骨 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·五行攻击·钻心 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·五行攻击·噬魂 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		苍茫刺 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		日光耀 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		靛沧啸 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		巨岩击 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		地裂焚 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		颠倒五行 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  80 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 9
				if lv >= 160 then
			        hh = 9
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		清净 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			   return {类型=2,状态回合=2}
			end
		},
		慧眼 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			   return {状态回合=1}
			end
		},
		秘术 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			   return {状态回合=1}
			end
		},
		困兽 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			   return {状态回合=1}
			end
		},

    --====================盘丝洞====================--
        	侵蚀·幻魇谜雾·刻骨 = {
			技能类型="减益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {状态回合=1}
			end,
		},
    	侵蚀·幻魇谜雾·钻心 = {
			技能类型="减益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {状态回合=1}
			end,
		},
    	侵蚀·幻魇谜雾·噬魂 = {
			技能类型="减益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {状态回合=1}
			end,
		},
	    天罗地网 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    if PK then
			        return 1
			    end
--------------------------18奇技盘丝洞1-------------------------------
			local 附加人数=0
			if self:取门派秘籍(攻击方.玩家id,"盘丝洞A") >=1  and not PK then
  				附加人数 = math.floor(self:取门派秘籍(攻击方.玩家id,"盘丝洞A")/45)
  			end
--------------------------18奇技盘丝洞1-------------------------------
			    if lv >= 60 then
			        return 3 + 附加人数
			    else
			        return 2 + 附加人数
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=4}
			end,
		},
		勾魂 = {
			技能类型="固伤技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
		},
		摄魄 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  35 , "魔法"
			end,
		},
		千蛛噬魂 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
				return  20*mbs+10 , "魔法"
			end,
		},
		侵蚀·千蛛噬魂·刻骨 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
				return  20*mbs+10 , "魔法"
			end,
		},
		侵蚀·千蛛噬魂·钻心 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
				return  20*mbs+10 , "魔法"
			end,
		},
		侵蚀·千蛛噬魂·噬魂 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
				return  20*mbs+10 , "魔法"
			end,
		},
		蛛丝缠绕 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		绝命毒牙 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		牵魂蛛丝 = {
			技能类型="减益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
		},
		含情脉脉 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 1
			    if lv >= 125 then
			        hh = 6
		        elseif lv >= 100 then
			        hh = 5
		        elseif lv >= 75 then
			        hh = 4
		        elseif lv >= 45 then
			        hh = 3
		        elseif lv >= 25 then
			        hh = 2
			    end
			    return {状态回合=hh}
			end,
		},
		偷龙转凤 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  80 , "愤怒"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=8}
			end,
		},
		落花成泥 = {
			技能类型="减益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  20 , "愤怒"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {状态回合=2}
			end,
		},
		魔音摄魂 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 3
			    if lv >= 125 then
			        hh = 7
		        elseif lv >= 100 then
			        hh = 6
		        elseif lv >= 75 then
			        hh = 5
		        elseif lv >= 45 then
			        hh = 4
			    end
			    return {状态回合=hh}
			end,
		},
		瘴气 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = 3
			    if lv >= 150 then
			        sl = 4
			    end
			    if 攻击方.JM.意乱 then
					sl = math.floor(lv/20+1)
				end
				return sl
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 4
				if lv >= 150 then
			        hh = 5
			    end
			    return {状态回合=hh}
			end,
		},
		姐妹同心 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		盘丝阵 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 12
				if lv >= 160 then
			        hh = 12
			    elseif lv >= 120 then
			        hh = 12
		        elseif lv >= 80 then
			        hh = 12
		        elseif lv >= 40 then
			        hh = 12
			    end
			    return {类型=2,状态回合=hh,防御 = qz(sx.防御*0.13)}
			end,
		},
		复苏 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=4}
			end,
		},
		媚眼如丝 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "金鸦火羽（高级）"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=1}
			end,
		},
		幻镜术 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "愤怒"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=1}
			end,
		},

    --====================阴曹地府====================--
	    百爪狂杀 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 4
			end,
			技能消耗 = function(mbs,攻击方)
				return  35*mbs , "魔法"
			end,
		},
	    魍魉追魂 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=150}
			end,
		},
	    阎罗令 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if 攻击方.队伍==0 then
			    --     return 1
			    -- end
			    if lv >= 150 then
			        return 7
		        elseif lv >= 125 then
			        return 6
		        elseif lv >= 100 then
			        return 5
		        elseif lv >= 75 then
			        return 4
		        elseif lv >= 50 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  20*mbs , "魔法"
			end,
		},
		判官令 = {
			技能类型="固伤技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  20 , "魔法"
			end,
		},
		寡欲令 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=4}
			end,
		},
		摄魂 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=3}
			end,
		},
		恶焰 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=6,伤害=qz(sx.伤害*0.12)}
			end,
		},
		轮回 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定) --暴击等级、穿刺等级、狂暴等级、格挡值没写
			    return {类型=2,状态回合=6,伤害=60}
			end,
		},

		百鬼噬魂 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 4
			end,
			技能消耗 = function(mbs,攻击方)
				return  35*mbs , "魔法"
			end,
		},
		血影蚀心 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		六道无量 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2,防御 = 指定}
			end,
		},
		无赦咒令 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		生杀予夺 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
		},
		魂飞魄散 = {
			技能类型="减益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 2
			end,
			技能消耗 = function(mbs,攻击方)
				return  80 , "魔法"
			end,
		},
		噬毒 = {
			技能类型="减益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.气血 > 攻击方.等级*10 then
			        return  50 , "魔法"
			    end
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150}
			end,
		},

		魂飞 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=1}
			end,
		},
		魂魇 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=1}
			end,
		},
		锢魂术 = {
			技能类型="减益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    if 指定 then
				    return {状态回合=指定}
				end
				if 攻击方.shenqi.name=="亡灵泣语" then
				    return {状态回合=5,法防=qz(sx.法防*0.1),防御=qz(sx.防御*0.1)}
				end
			    return {状态回合=5}
			end,
		},
		尸腐毒 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)

--------------------------18奇技阴曹地府1-------------------------------
			if self:取门派秘籍(攻击方.玩家id,"阴曹地府A") >=1  and not PK then
  				return math.floor( 1 + self:取门派秘籍(攻击方.玩家id,"阴曹地府A")/36)
  			else
  				return 1
  			end
--------------------------18奇技阴曹地府1-------------------------------
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 5
			    if lv >= 180 then
			        hh = 11
		        elseif lv >= 150 then
			        hh = 10
		        elseif lv >= 120 then
			        hh = 9
		        elseif lv >= 90 then
			        hh = 8
		        elseif lv >= 60 then
			        hh = 7
		        elseif lv >= 30 then
			        hh = 6
			    end
			    return {状态回合=hh}
			end,
		},
		-- 尸腐无常 = {
		-- 	技能类型="减益技能",
		-- 	技能人数 = function(lv,攻击方,PK)
		-- 	    return 1
		-- 	end,
		-- 	技能消耗 = function(mbs,攻击方)
		-- 		return  40 , "魔法"
		-- 	end,
		-- 	状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
		-- 		local hh = 5
		-- 	    if lv >= 180 then
		-- 	        hh = 11
		--         elseif lv >= 150 then
		-- 	        hh = 10
		--         elseif lv >= 120 then
		-- 	        hh = 9
		--         elseif lv >= 90 then
		-- 	        hh = 8
		--         elseif lv >= 60 then
		-- 	        hh = 7
		--         elseif lv >= 30 then
		-- 	        hh = 6
		-- 	    end
		-- 	    return {状态回合=hh}
		-- 	end,
		-- },
		黄泉之息 = {
			技能类型="固伤技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		修罗隐身 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  150 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    local hh = 8
			    local 类型 = 1
				if 攻击方.隐身==1 then --低
					hh = 取随机数(2,3)
					local ls = 0.2
					if 攻击方.隐匿击 ~= nil then
						ls = ls - 攻击方.隐匿击
					end
					sh=qz(sx.伤害*ls)
				elseif 攻击方.隐身==2 then --高
					hh = 取随机数(3,5)
					local ls = 0.15
					if 攻击方.隐匿击 ~= nil then
						ls = ls - 攻击方.隐匿击
					end
					sh=qz(sx.伤害*ls)

				elseif 攻击方.隐身==3 then --超
					hh = 取随机数(3,5)
					local ls = 0.1
					if 攻击方.隐匿击 ~= nil then
						ls = ls - 攻击方.隐匿击
					end
					sh=qz(sx.伤害*ls)
				-------------------------------
				elseif 攻击方.神出鬼没 then
					hh = 取随机数(3,5)
					local ls = 0.1
					if 攻击方.隐匿击 ~= nil then
						ls = ls + 攻击方.隐匿击
					end
					sh=qz(sx.伤害*ls)
					类型 = 2
				end
			    return {类型=类型,状态回合=hh,伤害=sh}
			end,
		},
		无间地狱 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "金鸦火羽（高级）"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=1}
			end,
		},
		森罗迷瘴 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=10}
			end,
		},
		还阳术 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  150 , "魔法"
			end,
		},
		幽冥鬼眼 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        if 攻击方.JM.通瞑 then
				    return 1
				end
		        if lv >= 120 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 60 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  20 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=8}
			end,
		},
		侵蚀·幽夜无明·刻骨 = {
			技能类型="群体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 10
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=1,速度 = qz(lv/2)}
			end,
		},
		侵蚀·幽夜无明·噬魂 = {
			技能类型="群体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 10
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2,速度 = qz(lv/2)}
			end,
		},
		侵蚀·幽夜无明·钻心 = {
			技能类型="群体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 10
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = math.random(1,2)
			    return {状态回合=hh,速度 = qz(lv/2)}
			end,
		},
    --====================五庄观====================--
	    清风望月 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "愤怒"
			end,
		},
	    日月乾坤 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  35 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 1
			    if lv >= 125 then
			        hh = 5
		        elseif lv >= 100 then
			        hh = 4
		        elseif lv >= 75 then
			        hh = 3
		        elseif lv >= 45 then
			        hh = 2
			    end
			    return {状态回合=hh}
			end,
		},
                 侵蚀·日月乾坤·刻骨 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  35 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 1
			    if lv >= 125 then
			        hh = 5
		        elseif lv >= 100 then
			        hh = 4
		        elseif lv >= 75 then
			        hh = 3
		        elseif lv >= 45 then
			        hh = 2
			    end
			    return {状态回合=hh}
			end,
		},
	    侵蚀·日月乾坤·钻心 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  35 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 1
			    if lv >= 125 then
			        hh = 5
		        elseif lv >= 100 then
			        hh = 4
		        elseif lv >= 75 then
			        hh = 3
		        elseif lv >= 45 then
			        hh = 2
			    end
			    return {状态回合=hh}
			end,
		},
	    侵蚀·日月乾坤·噬魂 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  35 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 1
			    if lv >= 125 then
			        hh = 5
		        elseif lv >= 100 then
			        hh = 4
		        elseif lv >= 75 then
			        hh = 3
		        elseif lv >= 45 then
			        hh = 2
			    end
			    return {状态回合=hh}
			end,
		},
		天命剑法 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.气血>=攻击方.最大气血*0.7 then
					return  0 , "气血" --(最大气血的2%×实际攻击次数)点气血
				end
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2}
			end,
		},
		烟雨剑法 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.气血>=攻击方.最大气血*0.7 then
					return  50 , "魔法"
				end
			end,
		},
		侵蚀·烟雨剑法·刻骨 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
					return  50 , "魔法"
			end,
		},
		侵蚀·烟雨剑法·钻心 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
					return  50 , "魔法"
			end,
		},
		侵蚀·烟雨剑法·噬魂 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
					return  50 , "魔法"
			end,
		},
		飘渺式 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if PK then
					return 1
				end
			    if lv >= 60 then
			        return 3
		        else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
		},
		金击式 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 60 then
			        return 3
		        else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
		},
		敲金击玉 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·敲金击玉·刻骨 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·敲金击玉·钻心 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·敲金击玉·噬魂 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		落土止息 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法和气血"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2,防御 = qz(sx.防御 *0.1 ),法防 = qz(sx.法防 *0.1 )}
			end,
		},
		同伤式 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "金鸦火羽（高级）"
			end,
		},
		驱魔 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  45 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=4}
			end,
		},
		驱尸 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
		},
		天地同寿 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 3
				if lv >= 150 then
			        hh = 4
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		心随意动 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=8}
			end,
		},
		乾坤妙法 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 3
				if lv >= 150 then
			        hh = 4
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		炼气化神 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.气血 > 30 then
			        return  30 , "气血"
			    end
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 12
			    if lv >= 160 then
			        hh = 12
		        elseif lv >= 120 then
			        hh = 12
		        elseif lv >= 80 then
			        hh = 12
		        elseif lv >= 40 then
			        hh = 12
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		生命之泉 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        if lv >= 180 then
			        return 7
		        elseif lv >= 150 then
			        return 6
		        elseif lv >= 120 then
			        return 5
		        elseif lv >= 90 then
			        return 4
		        elseif lv >= 60 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 12
			    if lv >= 120 then
			        hh = 12
		        elseif lv >= 100 then
			        hh = 12
		        elseif lv >= 80 then
			        hh = 12
		        elseif lv >= 60 then
			        hh = 12
		        elseif lv >= 40 then
			        hh = 12
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		疯狂 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=5}
			end,
		},
		-- 骤雨 = {
		-- 	状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
		-- 	    return {状态回合=3,层数=1}
		-- 	end,
		-- },
		还元 = {
		    不可驱散=true,
		    层数上限=99,
		    刷新回合=2,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2,层数=1}
			end,
		},


		-- 三花聚顶 = {
		-- 	技能类型="恢复技能",
		-- 	指定对象="自己",
		-- 	技能人数 = function(lv,攻击方,PK)
		--         return 1
		-- 	end,
		-- 	技能消耗 = function(mbs,攻击方)
		-- 		return  30 , "气血"
		-- 	end,
		-- },

    --====================无底洞====================--
    		侵蚀·绝烬残光·刻骨 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
					return 10
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 2
			    return {类型=2,状态回合=hh}
			end,
		},
		侵蚀·绝烬残光·钻心 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
					return 10
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 2
			    return {类型=2,状态回合=hh}
			end,
		},
		侵蚀·绝烬残光·噬魂 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
					return 10
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 2
			    return {类型=2,状态回合=hh}
			end,
		},
    	裂魂 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=4,伤害=qz(lv*1.5)}
			end,
		},
		绝处逢生 = {
			技能类型="恢复技能",
			指定对象="自己",
			不可驱散=true,
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=3,速度 = qz(sx.速度*0.1)}
			end,
		},
		噬魂 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=1}
			end,
		},
		陷阱 = {
		    层数上限=7,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=150,层数=1}
			end,
		},
		同舟共济 = {
			技能类型="增益技能",
			不可驱散=true,
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  200 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    挨打方.法术状态.同舟共济.次数 = 6
			    return {类型=2,状态回合=1}
			end,
		},

	    移魂化骨 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.气血 >= 攻击方.最大气血 * 0.3 then
			        return  0.1 , "气血"
			    end
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 6
			    if lv >= 150 then
			        hh = 6
		        elseif lv >= 100 then
			        hh = 6
		        elseif lv >= 50 then
			        hh = 6
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		夺魄令 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 1
			    if lv >= 125 then
			        hh = 6
		        elseif lv >= 100 then
			        hh = 5
		        elseif lv >= 75 then
			        hh = 4
		        elseif lv >= 45 then
			        hh = 3
		        elseif lv >= 25 then
			        hh = 2
			    end
			    return {状态回合=hh}
			end,
		},
		妖风四起 = {
			技能类型="单体封印",
			不可驱散=true, --不能被 晶清等解除
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.气血>攻击方.最大气血*0.4 then
			        return  100 , "魔法"
			    end

			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2}
			end,
		},
		煞气诀 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2}
			end,
		},
		惊魂掌 = {
			技能类型="单体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 3
			    if lv >= 150 then
			        hh = 5
		        elseif lv >= 100 then
			        hh = 4
			    end
			    if 攻击方.JM.持戒 then
					hh = 2
				end
			    return {状态回合=hh}
			end,
		},
		摧心术 = {
			技能类型="群体封印",
			技能人数 = function(lv,攻击方,PK)
			    return 2
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=3,速度 = qz(lv/2)}
			end,
		},
		夺命咒 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    -- if PK or 攻击方.队伍==0 then
			    if PK then
			        return 1
			    end
			    if lv >= 140 then
			        return 5
		        elseif lv >= 105 then
			        return 4
		        elseif lv >= 70 then
			        return 3
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  20*mbs , "魔法"
			end,
		},
		明光宝烛 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
			    if 攻击方.JM.救人 then
					return 1
				end
		        if lv >= 175 then
			        return 7
		        elseif lv >= 150 then
			        return 6
		        elseif lv >= 125 then
			        return 5
		        elseif lv >= 100 then
			        return 4
		        elseif lv >= 75 then
			        return 3
		        elseif lv >= 50 then
			        return 2
			    else
			        return 1
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 2
				if lv >= 160 then
			        hh = 12
			    elseif lv >= 120 then
			        hh = 12
		        elseif lv >= 80 then
			        hh = 12
		        elseif lv >= 40 then
			        hh = 12
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		金身舍利 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        if 攻击方.JM.救人 then
					return 1
				end
		        if lv >= 175 then
			        return 7
		        elseif lv >= 150 then
			        return 6
		        elseif lv >= 125 then
			        return 5
		        elseif lv >= 120 then
			        return 4
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 12
				if lv >= 160 then
			        hh = 12
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		净土灵华 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "金鸦火羽（高级）"
			end,
		},
		地涌金莲 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
		        return 2
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.气血>50 then
					return  50 , "气血"
				end
			end,
		},
		由己渡人 = {
			技能类型="恢复技能",
			-- 指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.气血>攻击方.最大气血*0.1 then
			    	return  50 , "气血"
			    end
			end,
		},
		追魂刺 = {
			技能类型="固伤技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0, "魔法和愤怒"
			end,
		},
		燃血术 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        if lv >= 175 then
			        return 8
		        elseif lv >= 150 then
			        return 8
		        elseif lv >= 125 then
			        return 8
			    end
			    return 4
			end,
			技能消耗 = function(mbs,攻击方)
				if 攻击方.JM.盛怒 then--"#Y
					return  0 , "气血"
				else
					    if 攻击方.气血>=攻击方.最大气血*0.5 then
					    	return  50 , "气血"
					    end
				 end
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=150}
			end,
		},
		化羽为血 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "金鸦火羽（高级）"
			end,
		},

    --====================凌波城====================--
	    天神怒斩 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  300 , "魔法"
			end,
		},
	    裂石 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		浪涌 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 70 then
			        return 3
		        elseif lv >= 35 then
			        return 2
			    else
			        return 1
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  20*mbs+10 , "魔法"
			end,
		},
		断岳势 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "战意"
			end,
		},
		天崩地裂 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "战意"
			end,
		},
		侵蚀·天崩地裂·刻骨 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·天崩地裂·钻心 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		侵蚀·天崩地裂·噬魂 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		惊涛怒 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 4
			end,
			技能消耗 = function(mbs,攻击方)
				return  20*mbs+10 , "战意"
			end,
		},
		翻江搅海 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 125 then
			        return 6
			    else
			        return 5
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  20*mbs+10 , "战意"
			end,
		},
        强袭 = {
            刷新回合=3,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=3}
			end,
		},
		真君显灵 = {
		    技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    挨打方.法术状态.真君显灵.加伤点 = 挨打方.战意*20
			    if 挨打方.超级战意>0 then
				    挨打方.法术状态.真君显灵.加伤点 = 挨打方.法术状态.真君显灵.加伤点*2
				    挨打方.超级战意=0
				end
				挨打方.战意=0
			    return {状态回合=3}
			end,
		},
        再战 = {
            不可驱散=true,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=150}
			end,
		},
		酣战 = {
			层数上限=6,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2 ,状态回合=150 ,层数=1}
			end,
		},
		力竭 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    挨打方.法术状态.力竭.减伤 = 0.2
			    return {状态回合=3}
			end,
		},
        怒涛 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2,防御=qz(攻击方.战意 *20)}
			end,
		},
		腾雷 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "战意"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 3
			    if lv >= 150 then
			        hh = 4
			    end
			    return {状态回合=hh}
			end,
		},
		无双战魂 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "金鸦火羽（高级）"
			end,
		},
		不动如山 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  150 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=1}
			end,
		},
		碎星诀 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 12
			    if lv >= 180 then
			        hh = 12
			    elseif lv >= 135 then
			        hh = 12
		        elseif lv >= 90 then
			        hh = 12
		        elseif lv >= 45 then
			        hh = 12
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		镇魂诀 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    if 攻击方.气血 >= 攻击方.最大气血 * 0.1 then
					return  0 , "无消耗"
				end
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local hh = 12
			    if lv >= 180 then
			        hh = 12
			    elseif lv >= 135 then
			        hh = 12
			    end
			    return {类型=2,状态回合=hh}
			end,
		},
		无穷妙道 = {
			技能类型="恢复技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "魔法"
			end,
		},
		超级赐福·元吉 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
				return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {类型=2,状态回合=150}
			end,
		},

		超级赐福·双喜 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
				return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {类型=2,状态回合=150}
			end,
		},
		超级赐福·三和 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
				return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {类型=2,状态回合=150}
			end,
		},
		超级赐福·四季 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
				return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {类型=2,状态回合=150}
			end,
		},
		超级赐福·五福 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
				return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {类型=2,状态回合=150}
			end,
		},

		超级赐福·六祥 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
				return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {类型=2,状态回合=150}
			end,
		},
		超级赐福·七瑞 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
				return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {类型=2,状态回合=150}
			end,
		},
		超级赐福·八荒 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
				return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {类型=2,状态回合=150}
			end,
		},
		超级赐福·九州 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
				return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {类型=2,状态回合=150}
			end,
		},
		超级赐福·十全 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
				return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {类型=2,状态回合=150}
			end,
		},


    --====================花果山====================--
       	显圣 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=2}
			end,
		},
    	得意 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=150}
			end,
		},
	    棒打雄风 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  75 , "魔法"
			end,
		},
	    当头一棒 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  75 , "魔法"
			end,
		},
		   侵蚀·当头一棒·刻骨 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  75 , "魔法"
			end,
		},
	    侵蚀·当头一棒·钻心 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  75 , "魔法"
			end,
		},
	    侵蚀·当头一棒·噬魂 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  75 , "魔法"
			end,
		},
		神针撼海 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 125 then
			        return 5
		        elseif lv >= 75 then
			        return 4
		        elseif lv >= 45 then
			        return 3
		        elseif lv >= 25 then
			        return 2
			    else
			        return 1
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  75 , "魔法"
			end,
		},
		杀威铁棒 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  75 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=1}
			end,
		},
		泼天乱棒 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  75 , "魔法"
			end,
		},
		威震凌霄 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=3}
			end,
		},
		铜头铁臂 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  75 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=150}
			end,
		},
		愈勇 = {
		    层数上限=3,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=150,层数=1}
			end,
		},
		开辟 = {
			层数上限=6,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2 ,状态回合=150 ,层数=1}
			end,
		},
		齐天神通 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "愤怒"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=8}
			end,
		},
		无所遁形 = {
			技能类型="增益技能",
			指定对象="自己",
			层数上限=3,
			刷新回合=8,
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=12,层数=1}
			end,
		},
		九幽除名 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  75 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=1}
			end,
		},
		棒掀北斗 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  75 , "魔法"
			end,
		},
		侵蚀·棒掀北斗·刻骨 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  75 , "魔法"
			end,
		},
		侵蚀·棒掀北斗·钻心 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  75 , "魔法"
			end,
		},
		侵蚀·棒掀北斗·噬魂 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  75 , "魔法"
			end,
		},
		兴风作浪 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 100 then
			        return 5
		        elseif lv >= 75 then
			        return 4
		        elseif lv >= 50 then
			        return 3
		        elseif lv >= 30 then
			        return 2
			    else
			        return 1
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  75 , "魔法"
			end,
		},
		棍打诸神 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 10
			end,
			技能消耗 = function(mbs,攻击方)
				return  75 , "魔法"
			end,
		},
		意马心猿 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  75 , "魔法"
			end,
		},
		灵彻太虚 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=3}
			end,
		},
		云暗天昏 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    if lv >= 140 then
			        return 6
		        elseif lv >= 105 then
			        return 5
		        elseif lv >= 70 then
			        return 4
		        elseif lv >= 35 then
			        return 4
			    else
			        return 2
			    end
			end,
			技能消耗 = function(mbs,攻击方)
				return  75 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=2}
			end,
		},
		天地洞明 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "金鸦火羽（高级）"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=1}
			end,
		},
		-- 呼子唤孙 = {
		-- 	技能类型="增益技能",
		-- 	指定对象="自己",
		-- 	技能人数 = function(lv,攻击方,PK)
		--         return 1
		-- 	end,
		-- 	技能消耗 = function(mbs,攻击方)
		-- 		return  30 , "魔法"
		-- 	end,
		-- },
		气慑天军 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=4}
			end,
		},
		八戒上身 = {
			技能类型="群体封印",
			技能人数 = function(lv,攻击方,PK)
				 return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				if 攻击方.JM.圈养 then
				   return {状态回合=3}
				else
				    return {状态回合=2}
				end
			end,
		},

    --====================特技====================--
	    弱点击破 = {
			技能类型="物攻技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "特技消耗"
			end,
		},
		破血狂攻 = {
			技能类型="物攻技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  80 , "特技消耗"
			end,
		},
		破碎无双 = {
			技能类型="物攻技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  80 , "特技消耗"
			end,
		},
		琴音三叠 = {
			技能类型="特殊技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  80 , "特技消耗"
			end,
		},
		移行换影 = {
			技能类型="特殊技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  150 , "特技消耗"
			end,
		},
		妙手空空 = {
			技能类型="特殊技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  4*mbs , "魔法"
			end,
		},
		起死回生 = {
			技能类型="恢复技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  130 , "特技消耗"
			end,
		},
		回魂咒 = {
			技能类型="恢复技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "特技消耗"
			end,
		},
		气疗术 = {
			技能类型="恢复技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "特技消耗"
			end,
		},
		四海升平 = {
			技能类型="恢复技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return  135 , "特技消耗"
			end,
		},
		水清诀 = {
			技能类型="恢复技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "特技消耗"
			end,
		},
		玉清诀 = {
			技能类型="恢复技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return  125 , "特技消耗"
			end,
		},
		冰清诀 = {
			技能类型="恢复技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "特技消耗"
			end,
		},
		晶清诀 = {
			技能类型="恢复技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return  150 , "特技消耗"
			end,
		},
		慈航普度 = {
			技能类型="恢复技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return  150 , "特技消耗"
			end,
		},
		金刚怒目 = {
			技能类型="恢复技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  80 , "特技消耗"
			end,
		},
		心疗术 = {
			技能类型="恢复技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "特技消耗"
			end,
		},
		命归术 = {
			技能类型="恢复技能",
			指定对象="自己",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  130 , "特技消耗"
			end,
		},
		气归术 = {
			技能类型="恢复技能",
			指定对象="自己",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "特技消耗"
			end,
		},
		命疗术 = {
			技能类型="恢复技能",
			指定对象="自己",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  90 , "特技消耗"
			end,
		},
		凝气诀 = {
			技能类型="恢复技能",
			指定对象="自己",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  60 , "特技消耗"
			end,
		},
		凝神诀 = {
			技能类型="恢复技能",
			指定对象="自己",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  90 , "特技消耗"
			end,
		},
		诅咒之伤 = {
			技能类型="固伤技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "特技消耗"
			end,
		},
		吸血特技 = {
			技能类型="固伤技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
		        return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  70 , "特技消耗"
			end,
		},
		太极护法 = {
			技能类型="增益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  90 , "特技消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=3}
			end,
		},
		罗汉金钟 = {
			技能类型="增益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return  150 , "特技消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    if 攻击方.JM.罗汉 then
				    return  {类型=2,状态回合=4}
				end
			    return  {类型=2,状态回合=3}
			end,
		},
		心如明镜 = {
			技能类型="增益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "特技消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=4}
			end,
		},
		流云诀 = {
			技能类型="增益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "特技消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=150,速度 = qz(sx.速度 * 0.1)}
			end,
		},
		啸风诀 = {
			技能类型="增益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return  80 , "特技消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    local sd = qz(sx.速度 * 0.05)
			    if 攻击方.门派=="天宫" and 攻击方.JM.余韵 then
		            sd = qz(sd * 1.5)
				end
			    return  {类型=2,状态回合=150,速度 = sd}
			end,
		},
		金刚不坏 = {
			技能类型="增益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  90 , "特技消耗"
			end,
		},
		菩提心佑 = {
			技能类型="增益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return  150 , "特技消耗"
			end,
		},
		野兽之力 = {
			技能类型="增益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "特技消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=150,伤害 = qz(sx.伤害 * 0.1)}
			end,
		},
		魔兽之印 = {
			技能类型="增益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return  70 , "特技消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    local sh = qz(sx.速度 * 0.05)
			    if 攻击方.门派=="天宫" and 攻击方.JM.余韵 then
		            sh = qz(sh * 1.5)
				end
			    return  {类型=2,状态回合=150,伤害 = sh}
			end,
		},
		光辉之甲 = {
			技能类型="增益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "特技消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=150,防御 = qz(sx.防御 * 0.1)}
			end,
		},
		圣灵之甲 = {
			技能类型="增益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return  80 , "特技消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    local fy = qz(sx.防御 * 0.05)
			    if 攻击方.门派=="天宫" and 攻击方.JM.余韵 then
		            fy = qz(fy * 1.5)
				end
			    return  {类型=2,状态回合=150,防御 = fy}
			end,
		},
		修罗咒 = {
			技能类型="增益技能",
			指定对象="自己",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  120 , "特技消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=6}
			end,
		},
		身似菩提 = {
			技能类型="增益技能",
			指定对象="自己",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  130 , "特技消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=2}
			end,
		},
		放下屠刀 = {
			技能类型="减益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "特技消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {状态回合=150,伤害 = qz(sx.伤害 * 0.1)}
			end,
		},
		笑里藏刀 = {
			技能类型="减益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  40 , "特技消耗"
			end,
		},
		碎甲术 = {
			技能类型="减益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return  80 , "特技消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {状态回合=150,防御 = qz(sx.防御 * 0.05)}
			end,
		},
		河东狮吼 = {
			技能类型="减益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "特技消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    local sh = qz(sx.伤害 * 0.05)
			    if 攻击方.门派=="天宫" and 攻击方.JM.余韵 then
		            sh = qz(sh * 1.5)
				end
				return {状态回合=150,伤害 = sh}
			end,
		},
		破甲术 = {
			技能类型="减益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  35 , "特技消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {状态回合=150,防御 = qz(sx.防御 * 0.1)}
			end,
		},
		凝滞术 = {
			技能类型="减益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  35 , "特技消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {状态回合=150,速度 = qz(sx.速度 * 0.1)}
			end,
		},
		停陷术 = {
			技能类型="减益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return  80 , "特技消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    local sd = qz(sx.速度 * 0.05)
			    if 攻击方.门派=="天宫" and 攻击方.JM.余韵 then
		            sd = qz(sd * 1.5)
				end
				return {状态回合=150,速度 = sd}
			end,
		},
		死亡之音 = {
			技能类型="减益技能",
			是否特技=true,
			技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return  90 , "特技消耗"
			end,
		},

	--====================召唤兽====================--
		力劈华山 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  攻击方.等级+20 , "魔法"
			end,
		},
		法术防御 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  qz(攻击方.等级/2+50) , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {类型=2,状态回合=6}
			end,
		},
		苍鸾怒击 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				return {状态回合=2,伤害=qz(sx.伤害*0.2),速度=qz(sx.速度*0.2)}
			end,
		},
		--观照万象 = {
			--技能类型="特殊技能",
			--技能人数 = function(lv,攻击方,PK)
			 --   return 1
			--end,
			--技能消耗 = function(mbs,攻击方)
			--	return  100 , "魔法"
			--end,
	--	},

        观照万象 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = qz(lv/30+1)
			    if sl>=3 then
			        sl = 3
			    end
			    return sl
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
		},


	    地狱烈火 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = qz(lv/30+1)
			    if sl>=3 then
			        sl = 3
			    end
			    return sl
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
		},
		奔雷咒 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = qz(lv/30+1)
			    if sl>=3 then
			        sl = 3
			    end
			    return sl
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
		},
		水漫金山 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = qz(lv/30+1)
			    if sl>=3 then
			        sl = 3
			    end
			    return sl
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
		},
		泰山压顶 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = qz(lv/30+1)
			    if sl>=3 then
			        sl = 3
			    end
			    return sl
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
		},
		水攻 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		落岩 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		雷击 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		烈火 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		超级三昧真火 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  30 , "魔法"
			end,
		},
		-- 迅风出击 = {
		-- 	技能类型="物攻技能",
		-- 	技能人数 = function(lv,攻击方,PK)
		-- 	    return 1
		-- 	end,
		-- 	技能消耗 = function(mbs,攻击方)
		-- 		return  30 , "魔法"
		-- 	end,
		-- },
		月光 = {
			技能类型="特殊技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  100 , "魔法"
			end,
		},
		上古灵符 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  qz(攻击方.等级/3+30) , "魔法"
			end,
		},
		冰冻 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2}
			end,
		},
		八凶法阵 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
				return  qz(攻击方.等级/3+30) , "魔法"
			end,
		},
		柳暗花明 = {
			层数上限=2,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
				local 加成=1.25
				if 攻击方.法连>=30 then
					加成=1.5
				end
				攻击方.柳暗花明=加成
				return {状态回合=99,层数=1}
			end,
		},
		八凶法阵（红） = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2,伤害=qz(sx.伤害*0.08)}
			end,
		},
		八凶法阵（黄） = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2,防御=qz(sx.防御*0.08)}
			end,
		},
		八凶法阵（蓝） = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2,法伤=qz(sx.法伤*0.08)}
			end,
		},
		八凶法阵（白） = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2,速度=qz(sx.速度*0.08)}
			end,
		},
		叱咤风云 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
				return  50 , "魔法"
			end,
		},
		流沙轻音 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = qz(lv/20)
			    if sl>=5 then
			        sl = 5
		        elseif sl<1 then
			        sl = 1
			    end
			    return sl
			end,
			技能消耗 = function(mbs,攻击方)
				return  mbs*30 , "魔法"
			end,
		},
		食指大动 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = qz(lv/20)
			    if sl>=5 then
			        sl = 5
		        elseif sl<1 then
			        sl = 1
			    end
			    return sl
			end,
			技能消耗 = function(mbs,攻击方)
				return  mbs*30 , "魔法"
			end,
		},
		天降灵葫 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    sx = qz(lv/30+2)
			    if sx>=5 then
			        sx=5
			    end
			    return 取随机数(1,sx)
			end,
			技能消耗 = function(mbs,攻击方)
				return  qz(攻击方.等级/3+30) , "魔法"
			end,
		},
		扶摇万里 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    sx = qz(lv/15+1)
			    if sx>=10 then
			        sx=10
			    end
			    if PK then
			        sx=3
			    end
			    return sx
			end,
			技能消耗 = function(mbs,攻击方)
				return  mbs*12 , "魔法"
			end,
		},
		水击三千 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  qz(攻击方.等级/2+30) , "魔法"
			end,
		},
		北冥之渊 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 5
			end,
			技能消耗 = function(mbs,攻击方)
				return  qz(mbs*20) , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=1}
			end,
		},
		鲲鹏出场 = {
			技能类型="恢复技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "无消耗"
			end,
		},
		武神之怒 = {
			技能类型="物攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 10
			end,
			技能消耗 = function(mbs,攻击方)
				return  1 , "魔法"
			end,
		},
		刀光剑影 = {
			技能类型="法攻技能",
			佛法加成=true,
			技能人数 = function(lv,攻击方,PK)
			    return 10
			end,
			技能消耗 = function(mbs,攻击方)
				return  1 , "魔法"
			end,
		},
		超级飞砂走石 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    sx = qz(lv/15+1)
			    if sx>=10 then
			        sx=10
			    end
			    return sx
			end,
			技能消耗 = function(mbs,攻击方)
				return  mbs*12 , "魔法"
			end,
		},
		------------------------------------
		自爆 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "无消耗"
			end,
		},
		夜舞倾城 = {
			技能类型="固伤技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  qz(攻击方.等级/2+50) , "魔法"
			end,
		},
		牛刀小试 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 2
			end,
			技能消耗 = function(mbs,攻击方)
				return  20 , "魔法"
			end,
		},
		剑荡四方 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 3
			end,
			技能消耗 = function(mbs,攻击方)
				return  0.1 , "气血"
			end,
		},
		善恶有报 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  攻击方.等级+10 , "魔法"
			end,
		},
	特色善恶有报 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  攻击方.等级+10 , "魔法"
			end,
		},

		惊心一剑 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  qz(攻击方.等级/2+10) , "魔法"
			end,
		},
		壁垒击破 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  攻击方.等级+10 , "魔法"
			end,
		},

		弱点火 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=3}
			end,
		},
		弱点土 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=3}
			end,
		},
		弱点水 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=3}
			end,
		},
		弱点雷 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=3}
			end,
		},
		超级神迹复活 = {
			技能类型="恢复技能",
			是否特技=false,
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
		},
		超级壁垒击破 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  攻击方.等级+10 , "魔法"
			end,
		},
		超级地狱烈火 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = qz(lv/30+1)
			    if sl>=3 then
			        sl = 3
			    end
			    return sl
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
		},
		超级泰山压顶 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = qz(lv/30+1)
			    if sl>=3 then
			        sl = 3
			    end
			    return sl
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
		},
		超级水漫金山 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = qz(lv/30+1)
			    if sl>=3 then
			        sl = 3
			    end
			    return sl
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
		},
		超级奔雷咒 = {
			技能类型="法攻技能",
			技能人数 = function(lv,攻击方,PK)
			    local sl = qz(lv/30+1)
			    if sl>=3 then
			        sl = 3
			    end
			    return sl
			end,
			技能消耗 = function(mbs,攻击方)
				return  30*mbs , "魔法"
			end,
		},
		超级连击 = {
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,lv)
				return 0 , "无消耗"
			end,
		},

		超级永恒 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
			    return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {类型=2,状态回合=3}
			end,
		},

		超级强力 = {
			技能类型="减益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return {状态回合=2}
			end,
		},

		超级盾气 = {
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=5}
			end,
		},
		超级进击必杀 = {
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=5}
			end,
		},
		--=====================================
		死亡召唤 = {
			技能类型="物攻技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return  攻击方.等级+10 , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    if 指定 then
			        return  {状态回合=指定}
			    end
			    return  {状态回合=10}
			end,
		},
		灵能激发 = {
			技能类型="增益技能",
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=5,法伤=qz(sx.法伤 * 0.25)}
			end,
		},
		无畏布施 = {
			技能类型="增益技能",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return qz(攻击方.等级/2+50) , "魔法"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=3,法防=qz(sx.法防 * 0.1),防御=qz(sx.防御 * 0.1)}
			end,
		},
		无畏布施（减） = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=1,状态回合=3,法防=qz(sx.法防 * 0.1),防御=qz(sx.防御 * 0.1)}
			end,
		},
		遗志 = {
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=5,层数=1}
			end,
		},
		高级遗志 = {
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=5,层数=1}
			end,
		},

		超级遗志 = {
			指定对象="自己",
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=5,层数=1}
			end,
		},
		---------------------------
		高级连击 = {
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,lv)
				return 0 , "无消耗"
			end,
		},
		理直气壮 = {
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,lv)
				return 0 , "无消耗"
			end,
		},
		乘胜追击 = {
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,lv)
				return 0 , "无消耗"
			end,
		},
		嗜血追击 = {
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,lv)
				return 0 , "无消耗"
			end,
		},
    --====================宝宝特性====================--
	    复活 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=1,状态回合=挨打方.鬼魂}
			end,
		},
        顾盼生姿 = {
            层数上限=4,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=150,层数=1}
			end,
		},
	    灵刃 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=4}
			end,
		},
		灵法 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=4}
			end,
		},
		灵断 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=4}
			end,
		},
		护佑 = {
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,lv)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=2}
			end,
		},
		阳护 = {
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,lv)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=1}
			end,
		},
		御风 = {
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,lv)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=3,速度=lv}
			end,
		},
		怒吼 = {
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,lv)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=2,伤害=lv}
			end,
		},
		逆境 = {
		    技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,lv)
				return 0 , "无消耗"
			end,
		},

    --====================纯状态====================--
	    进击必杀 = {
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=5}
			end,
		},
		进击必杀 = {
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=5}
			end,
		},
		高级进击必杀 = {
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=5}
			end,
		},
		进击法暴 = {
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=5}
			end,
		},
		高级进击法暴 = {
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=5}
			end,
		},

		超级进击法暴 = {
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=5}
			end,
		},
		-----------------------------------
		盾气 = {
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=6}
			end,
		},
		高级盾气 = {
			技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {类型=2,状态回合=6}
			end,
		},

    --====================法宝====================--
	    鬼泣 = {
		    技能类型="减益技能",
	        技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
		},
	    惊魂铃 = {
	        技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
		},
		清心咒 = {
	        技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
		},
		-- 分水 = {
	 --        技能人数 = function(lv,攻击方,PK)
		-- 	    return 1
		-- 	end,
		-- 	技能消耗 = function(mbs,攻击方)
		-- 		return 0 , "无消耗"
		-- 	end,
		-- },
	    混元伞 = {
		    技能类型="增益技能",
			指定对象="自己",
			法宝增益=true,
	        技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    local hh = 4
			    if 挨打方.JM.坚壁 and 挨打方.坚壁==nil then
				    hh = 5
				    挨打方.坚壁=1
				end
			    return  {状态回合=hh}
			end,
		},
		苍白纸人 = {
			技能类型="增益技能",
			指定对象="自己",
			法宝增益=true,
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    local hh = 4
			    if 挨打方.JM.坚壁 and 挨打方.坚壁==nil then
				    hh = 5
				    挨打方.坚壁=1
				end
			    return  {状态回合=hh}
			end,
		},
		乾坤玄火塔 = {
			技能类型="增益技能",
			法宝增益=true,
			指定对象="自己",
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=5}
			end,
		},
		苍灵雪羽 = {
			技能类型="增益技能",
			法宝增益=true,
		    技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=1}
			end,
		},
		烽火狼烟 = {
			技能类型="增益技能",
			法宝增益=true,
		    技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=1}
			end,
		},
		璞玉灵钵 = {
			技能类型="增益技能",
			法宝增益=true,
		    技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=1}
			end,
		},
		断线木偶 = {
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=1}
			end,
		},
		发瘟匣 = {
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=1}
			end,
		},
		九梵清莲 = {
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=1}
			end,
		},
		缚妖索 = {
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=3}
			end,
		},
		捆仙绳 = {
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=3}
			end,
		},
		缚龙索 = {
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=3}
			end,
		},
		罗汉珠 = {
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=3}
			end,
		},
		舞雪冰蝶 = {
			法宝增益=true,
		    技能人数 = function(lv,攻击方,PK)
			    return 15
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=3}
			end,
		},
		五彩娃娃 = {
		    法宝增益=true,
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=3}
			end,
		},
		无魂傀儡 = {
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=3}
			end,
		},
		天煞 = {
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=3}
			end,
		},
		无尘扇 = {
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=3}
			end,
		},
		神木宝鼎 = {
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=3}
			end,
		},
		赤焰 = {
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=3}
			end,
		},
		分水 = {
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=3}
			end,
		},
		番天印 = {
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=4}
			end,
		},
		无字经 = {
		    技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=4}
			end,
		},
		金蟾 = {
            技能人数 = function(lv,攻击方,PK)
			    return 1
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=4}
			end,
		},
		碎甲刃 = {
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=4,防御=等级,负面="减防御"}
			end,
		},

    --====================道具？====================--
    --====================NPC特殊技能====================--
	    龙鸣虎啸 = {
		    技能类型="群体封印",
            技能人数 = function(lv,攻击方,PK)
			    return 5
			end,
			技能消耗 = function(mbs,攻击方)
				return 0 , "无消耗"
			end,
			状态属性 = function(lv,sx,挨打方,攻击方,等级,境界,指定)
			    return  {状态回合=1}
			end,
		},
	}
end



function 技能数据库:取技能类型(jn)
	if self.数据[jn]~=nil then
		return self.数据[jn].技能类型
	end
	return 0
end

function 技能数据库:取技能消耗(jn,mbs,攻击方,PK)
	if self.数据[jn]~=nil then
		return self.数据[jn].技能消耗(mbs,攻击方,PK)
	end
	return true
end

function 技能数据库:取技能人数(jn,lv)
	if self.数据[jn]~=nil then
		if lv==nil then
		    lv = 0
		end
		return self.数据[jn].技能人数(lv) or 1
	end
	return 1
end



function 技能数据库:更新(dt) end
function 技能数据库:显示() end

function 技能数据库:取门派秘籍(id,技能)
	if id == 0 or id == nil or id == "" then return 0 end
  local lv=0
  if id~=nil and 技能~=nil and 玩家数据[id].角色.门派秘籍~=nil and 玩家数据[id].角色.门派秘籍[技能]~=nil then
     lv=玩家数据[id].角色.门派秘籍[技能]
  end
  return lv
end

return 技能数据库