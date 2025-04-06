-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:44
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-11 23:57:40
local 装备处理类 = class()
local floor=math.floor
local random = 取随机数
local remove = table.remove
local ceil = math.ceil
local 附加范围={"力量","敏捷","体质","耐力","魔力"}
local 附加上限={
	[60]={27,22}
	,[80]={30,25}
	,[90]={33,28}
	,[100]={36,31}
	,[110]={39,34}
	,[120]={42,37}
	,[130]={45,40}
	,[140]={48,43}
	,[150]={51,46}
	,[160]={54,49}
}

local 星辉石属性={
	气血回复效果=8,
	气血=28,
	抵抗封印等级=8,
	抗法术暴击等级=8,
	抗物理暴击等级=8,
	防御=8,
	格挡值=8,
	法术防御=8,
	固定伤害=4,
	法术伤害=4,
	伤害=4,
	封印命中等级=4,
	法术暴击等级=4,
	物理暴击等级=4,
	狂暴等级=3,
	穿刺等级=4,
	法术伤害结果=3,
	治疗能力=3,
	速度=3
}

local 元身名称 = {"枪·元身","斧·元身","剑·元身","双剑·元身","飘带·元身","爪刺·元身","扇·元身","魔棒·元身","锤·元身","长鞭·元身","双环·元身","刀·元身","长杖·元身","弓·元身","宝珠·元身","巨剑·元身","灯笼·元身","伞·元身","头盔·元身","冠冕·元身","挂坠·元身","纱衣·元身","坚甲·元身","束带·元身","鞋履·元身"}

function 装备处理类:初始化()
	self.打造物品=绑定等级物品()
	self.双加熔炼数据=取csv数据("sql/熔炼双加.csv")
	self.装备数据={
	武器 = {
		基础属性 = function(lv,产出方式)
			if 产出方式==nil or 产出方式=="普通打造" or 产出方式=="系统产出" then
				if lv==0 then
					return {10,13} , {10,13}
				elseif lv==10 then
					return {45,58} , {40,52}
				elseif lv==20 then
					return {80,104} , {70,91}
				elseif lv==30 then
					return {115,149} , {100,130}
				elseif lv==40 then
					return {150,195} , {130,169}
				elseif lv==50 then
					return {185,240} ,{160,208}
				elseif lv==60 then
					return {220,286} , {190,247}
				elseif lv==70 then
					return {255,331} , {220,286}
				elseif lv==80 then
					return {290,377} , {250,325}
				elseif lv==90 then
					return {325,422} , {280,364}
				elseif lv==100 then
					return {360,468} , {310,403}
				elseif lv==110 then
					return {395,513} , {340,442}
				elseif lv==120 then
					return {430,559} , {370,481}
				elseif lv==130 then
					return {465,604} , {400,520}
				elseif lv==140 then
					return {500,650} , {430,559}
				elseif lv==150 then
					return {535,695} , {460,598}
				elseif lv==160 then
					return {571,777} , {490,667}
				end
			else
				if lv==0 then
					return {10,13} , {10,13}
				elseif lv==10 then
					return {47,60} , {42,54}
				elseif lv==20 then
					return {84,109} , {73,95}
				elseif lv==30 then
					return {120,156} , {105,136}
				elseif lv==40 then
					return {157,204} , {136,177}
				elseif lv==50 then
					return {194,252} , {168,218}
				elseif lv==60 then
					return {231,300} , {199,259}
				elseif lv==70 then
					return {267,347} , {231,300}
				elseif lv==80 then
					return {304,395} , {262,341}
				elseif lv==90 then
					return {341,443} , {294,382}
				elseif lv==100 then
					return {378,491} , {325,423}
				elseif lv==110 then
					return {414,538} , {357,464}
				elseif lv==120 then
					return {451,586} , {388,505}
				elseif lv==130 then
					return {488,634} , {420,546}
				elseif lv==140 then
					return {525,682} , {451,586}
				elseif lv==150 then
					return {561,729} , {483,627}
				elseif lv==160 then
					return {571,777} , {490,667}
				end
			end
		end
		},
	项链 = {
		基础属性 = function(lv,产出方式)
			if 产出方式==nil or 产出方式=="普通打造" or 产出方式=="系统产出" then
				if lv==0 then
					return {3,5}
				elseif lv==10 then
					return {17,22}
				elseif lv==20 then
					return {29,37}
				elseif lv==30 then
					return {41,53}
				elseif lv==40 then
					return {53,68}
				elseif lv==50 then
					return {65,84}
				elseif lv==60 then
					return {77,100}
				elseif lv==70 then
					return {89,115}
				elseif lv==80 then
					return {101,131}
				elseif lv==90 then
					return {113,146}
				elseif lv==100 then
					return {125,162}
				elseif lv==110 then
					return {137,178}
				elseif lv==120 then
					return {149,193}
				elseif lv==130 then
					return {161,209}
				elseif lv==140 then
					return {173,224}
				elseif lv==150 then
					return {185,240}
				elseif lv==160 then
					return {196,267}
				end
			else
				if lv==0 then
					return {3,5}
				elseif lv==10 then
					return {17,23}
				elseif lv==20 then
					return {30,38}
				elseif lv==30 then
					return {43,55}
				elseif lv==40 then
					return {55,71}
				elseif lv==50 then
					return {68,88}
				elseif lv==60 then
					return {80,105}
				elseif lv==70 then
					return {93,120}
				elseif lv==80 then
					return {106,137}
				elseif lv==90 then
					return {118,153}
				elseif lv==100 then
					return {131,170}
				elseif lv==110 then
					return {143,186}
				elseif lv==120 then
					return {156,202}
				elseif lv==130 then
					return {169,219}
				elseif lv==140 then
					return {181,235}
				elseif lv==150 then
					return {194,252}
				elseif lv==160 then
					return {196,267}
				end
			end
		end
		},
	衣服 = {
		基础属性 = function(lv,产出方式)
			if 产出方式==nil or 产出方式=="普通打造" or 产出方式=="系统产出" then
				if lv==0 then
					return {10,15}
				elseif lv==10 then
					return {25,30}
				elseif lv==20 then
					return {40,52}
				elseif lv==30 then
					return {55,71}
				elseif lv==40 then
					return {70,91}
				elseif lv==50 then
					return {85,100}
				elseif lv==60 then
					return {100,130}
				elseif lv==70 then
					return {115,149}
				elseif lv==80 then
					return {130,169}
				elseif lv==90 then
					return {145,188}
				elseif lv==100 then
					return {160,208}
				elseif lv==110 then
					return {175,227}
				elseif lv==120 then
					return {190,247}
				elseif lv==130 then
					return {205,266}
				elseif lv==140 then
					return {220,286}
				elseif lv==150 then
					return {235,305}
				elseif lv==160 then
					return {249,340}
				end
			else
				if lv==0 then
					return {10,15}
				elseif lv==10 then
				   return {25,30}
				elseif lv==20 then
					return {42,54}
				elseif lv==30 then
					return {57,74}
				elseif lv==40 then
					return {73,95}
				elseif lv==50 then
					return {89,115}
				elseif lv==60 then
					return {105,136}
				elseif lv==70 then
					return {120,156}
				elseif lv==80 then
					return {136,177}
				elseif lv==90 then
					return {152,197}
				elseif lv==100 then
					return {168,218}
				elseif lv==110 then
					return {183,238}
				elseif lv==120 then
					return {199,259}
				elseif lv==130 then
					return {215,279}
				elseif lv==140 then
					return {231,300}
				elseif lv==150 then
					return {246,320}
				elseif lv==160 then
					return {249,340}
				end
			end
		end
		},

	头盔 = {
		基础属性 = function(lv,产出方式)
			local 伤害={}
			local 命中={}
			if 产出方式==nil or 产出方式=="普通打造" or 产出方式=="系统产出" then
				if lv==0 then
					return {5,6} , {5,6}
				elseif lv==10 then
					return {10,13} , {15,19}
				elseif lv==20 then
					return {15,19} , {25,32}
				elseif lv==30 then
					return {20,26} , {35,45}
				elseif lv==40 then
					return {25,32} , {45,58}
				elseif lv==50 then
					return {30,39} ,{55,71}
				elseif lv==60 then
					return {35,45} , {65,84}
				elseif lv==70 then
					return {40,52} , {75,97}
				elseif lv==80 then
					return {45,58} , {85,110}
				elseif lv==90 then
					return {50,65} , {95,123}
				elseif lv==100 then
					return {55,71} , {105,136}
				elseif lv==110 then
					return {60,78} , {115,149}
				elseif lv==120 then
					return {65,84} , {125,162}
				elseif lv==130 then
					return {70,91} , {135,175}
				elseif lv==140 then
					return {75,97} , {145,188}
				elseif lv==150 then
					return {80,104} , {155,201}
				elseif lv==160 then
					return {84,115} , {163,224}
				end
			else
				if lv==0 then
					return {5,6} , {5,6}
				elseif lv==10 then
					return {10,13} , {15,20}
				elseif lv==20 then
					return {15,19} , {26,34}
				elseif lv==30 then
					return {21,27} , {36,47}
				elseif lv==40 then
					return {26,33} , {47,61}
				elseif lv==50 then
					return {31,40} , {57,75}
				elseif lv==60 then
					return {36,47} , {68,88}
				elseif lv==70 then
					return {42,54} , {78,102}
				elseif lv==80 then
					return {47,60} , {89,116}
				elseif lv==90 then
					return {52,68} , {99,129}
				elseif lv==100 then
					return {57,74} , {110,143}
				elseif lv==110 then
					return {63,81} , {120,156}
				elseif lv==120 then
					return {68,88} , {131,170}
				elseif lv==130 then
					return {73,95} , {141,184}
				elseif lv==140 then
					return {78,101} , {152,197}
				elseif lv==150 then
					return {84,109} , {162,211}
				elseif lv==160 then
					return {84,115} , {163,224}
				end
			end
		end
		},


	腰带 = {
		基础属性 = function(lv,产出方式)
			local 伤害={}
			local 命中={}
			if 产出方式==nil or 产出方式=="普通打造" or 产出方式=="系统产出" then
				if lv==0 then
					return {4,4} , {0,0}
				elseif lv==10 then
					return {10,13} , {30,39}
				elseif lv==20 then
					return {15,19} , {50,65}
				elseif lv==30 then
					return {20,26} , {70,91}
				elseif lv==40 then
					return {25,32} , {90,117}
				elseif lv==50 then
					return {30,39} ,{110,143}
				elseif lv==60 then
					return {35,45} , {130,169}
				elseif lv==70 then
					return {40,52} , {150,195}
				elseif lv==80 then
					return {45,58} , {170,221}
				elseif lv==90 then
					return {50,65} , {190,247}
				elseif lv==100 then
					return {55,71} , {210,273}
				elseif lv==110 then
					return {60,78} , {230,299}
				elseif lv==120 then
					return {65,84} , {250,325}
				elseif lv==130 then
					return {70,91} , {270,351}
				elseif lv==140 then
					return {75,97} , {290,377}
				elseif lv==150 then
					return {80,104} , {310,403}
				elseif lv==160 then
					return {84,115} , {329,449}
				end
			else
				if lv==0 then
					return {4,4} , {0,0}
				elseif lv==10 then
					return {10,13} , {31,40}
				elseif lv==20 then
					return {15,19} , {52,68}
				elseif lv==30 then
					return {21,27} , {73,95}
				elseif lv==40 then
					return {26,33} , {94,122}
				elseif lv==50 then
					return {31,40} , {115,149}
				elseif lv==60 then
					return {36,47} , {136,177}
				elseif lv==70 then
					return {42,54} , {157,204}
				elseif lv==80 then
					return {47,60} , {178,231}
				elseif lv==90 then
					return {52,68} , {199,258}
				elseif lv==100 then
					return {57,74} , {220,286}
				elseif lv==110 then
					return {63,81} , {241,313}
				elseif lv==120 then
					return {68,88} , {262,341}
				elseif lv==130 then
					return {73,95} , {283,368}
				elseif lv==140 then
					return {78,101} , {304,395}
				elseif lv==150 then
					return {84,109} , {325,423}
				elseif lv==160 then
					return {84,115} , {329,449}
				end
			end
		end
		},

	鞋子 = {
		基础属性 = function(lv,产出方式)
			local 伤害={}
			local 命中={}
			if 产出方式==nil or 产出方式=="普通打造" or 产出方式=="系统产出" then
				if lv==0 then
					return {4,4} , {5,5}
				elseif lv==10 then
					return {10,13} , {8,10}
				elseif lv==20 then
					return {15,19} , {11,14}
				elseif lv==30 then
					return {20,26} , {14,18}
				elseif lv==40 then
					return {25,32} , {17,22}
				elseif lv==50 then
					return {30,39} ,{20,26}
				elseif lv==60 then
					return {35,45} , {23,29}
				elseif lv==70 then
					return {40,52} , {26,33}
				elseif lv==80 then
					return {45,58} , {29,37}
				elseif lv==90 then
					return {50,65} , {32,41}
				elseif lv==100 then
					return {55,71} , {35,45}
				elseif lv==110 then
					return {60,78} , {38,49}
				elseif lv==120 then
					return {65,84} , {41,53}
				elseif lv==130 then
					return {70,91} , {46,59}
				elseif lv==140 then
					return {75,97} , {47,61}
				elseif lv==150 then
					return {80,104} , {50,65}
				elseif lv==160 then
					return {84,115} , {52,70}
				end
			else
				if lv==0 then
					return {4,4} , {5,5}
				elseif lv==10 then
					return {10,13} , {8,10}
				elseif lv==20 then
					return {15,19} , {11,14}
				elseif lv==30 then
					return {21,27} , {14,18}
				elseif lv==40 then
					return {26,33} , {17,22}
				elseif lv==50 then
					return {31,40} , {21,27}
				elseif lv==60 then
					return {36,47} , {24,31}
				elseif lv==70 then
					return {42,54} , {27,35}
				elseif lv==80 then
					return {47,60} , {30,39}
				elseif lv==90 then
					return {52,68} , {33,42}
				elseif lv==100 then
					return {57,74} , {36,46}
				elseif lv==110 then
					return {63,81} , {39,50}
				elseif lv==120 then
					return {68,88} , {43,55}
				elseif lv==130 then
					return {73,95} , {44,57}
				elseif lv==140 then
					return {78,101} , {49,63}
				elseif lv==150 then
					return {84,109} , {52,67}
				elseif lv==160 then
					return {84,115} , {52,70}
				end
			end
		end
		},
	}
end


-- function 装备处理类:转换符处理(id,装备编号,道具编号,装备数据,道具数据,全部道具,装备格子,道具格子)
--   if 道具数据.名称=="属性转换符" then
--     if 全部道具[道具编号]~=nil and 全部道具[道具编号].数量>=1 then
--       全部道具[道具编号].数量=全部道具[道具编号].数量-1
--       if 全部道具[道具编号].数量<1 then
--         全部道具[道具编号] = nil
--       end
--     else
--       常规提示(id,"#Y/转换符数量不足。")
--       return
--     end

--     local 五维={"魔力","力量","体质","耐力","敏捷"}
--     if 装备数据.分类==6 then 五维={"魔力","力量","体质","耐力"} end --鞋子不改敏捷
--     local ww1={}--转换前属性
--     local ww2={}--数值
--     local ww3={}--转换后属性
--     for i=1,#五维 do
--       if 装备数据[五维[i]]~=nil then
--         ww1[#ww1+1]=五维[i]
--         ww2[#ww2+1]=装备数据[五维[i]]+0
--       end
--     end

--     for i=1,#ww1 do
--       local wz=取随机数(1,#五维)
--       ww3[i]=五维[wz]
--       if #五维==1 and ww3[i]==ww1[i] and i==#ww1 then--极端情况下 5个属性 前四个互换了 第五个随到一样的 这种情况下和别的位置属性互换
--         local wz1=取随机数(1,i-1)
--         ww3[i]=ww3[wz1]
--         ww3[wz1]=五维[wz]
--       else
--         while ww3[i]==ww1[i] do
--           wz=取随机数(1,#五维)
--           ww3[i]=五维[wz]
--         end
--         table.remove(五维,wz)
--       end
--     end

--     local 临时文本={}
--     for i=1,#ww3 do--新转换的属性
--       临时文本[#临时文本+1]={ww3[i],ww2[i]}
--     end

--     发送数据(玩家数据[id].连接id,64.2,{装备编号=装备编号,装备数据=装备数据,临时文本=临时文本})
--     刷新道具行囊单格(id,"道具",道具格子,道具编号)
--     发送数据(玩家数据[id].连接id,64.3)
--   else
--     常规提示(id,"#Y/道具属性出错,使用失败。")
--     return
--   end
-- end




function 装备处理类:数据处理(连接id,序号,id,内容)
	if 玩家数据[id].摊位数据~=nil then
		常规提示(id,"少侠还摆着摊呢，为了保证您的财物安全，少侠还是低调行事为上。")
		return
	end
	if 序号==4501 then
		if 玩家数据[id].角色:取任务(5)~=0 then
			常规提示(id,"#Y/你已经有一个打造任务在进行了")
			return
		end
		self:打造类型处理(连接id,序号,id,内容)
	elseif 序号==4502 then
		self:装备幻化(连接id,序号,id,内容)
	elseif 序号==4514 then
	    self:装备附魔宝珠(连接id,序号,id,内容)
	elseif 序号==4515 then
	    self:装备特效宝珠(连接id,序号,id,内容)
	end
end
function 装备处理类:装备附魔宝珠(连接id,序号,id,内容)
    local 临时id1 = 玩家数据[id].角色.道具[内容.数据序列2]
    local 临时id2 = 玩家数据[id].角色.道具[内容.数据序列1]
    if 玩家数据[id].道具.数据[临时id1]==nil or 玩家数据[id].道具.数据[临时id1]==0 then
      常规提示(id,"你似乎并没有这样的道具")
      return 0
    elseif 玩家数据[id].道具.数据[临时id2]==nil then
      常规提示(id,"你似乎并没有这样的道具")
      return 0
    elseif 玩家数据[id].道具.数据[临时id2].名称 ~= "神级宝珠" then
      常规提示(id,"请不要移动附魔宝珠的位置！")
      return 0
    end
    if 玩家数据[id].道具.数据[临时id1].分类>=7 then
      常规提示(id,"该物品无法开孔")
      return 0
    end
    local 等级  = 玩家数据[id].道具.数据[临时id1].级别限制
    local 副属性 ={"法术伤害" ,"法术防御" ,"气血回复效果" ,"固定伤害" ,"法术伤害结果" ,"法伤结果","命中","气血","灵力","魔法","速度","防御","伤害"}
    临时属性=副属性[math.random(1,#副属性)]
    临时数值=math.random(math.floor(等级*0.1),math.floor(等级*0.3))
    玩家数据[id].道具.数据[临时id1].特殊属性 = {类型=临时属性,属性=临时数值}
    if 玩家数据[id].道具.数据[临时id2].数量~=nil and 玩家数据[id].道具.数据[临时id2].数量 > 1 then
      玩家数据[id].道具.数据[临时id2].数量=玩家数据[id].道具.数据[临时id2].数量-1
    else
      玩家数据[id].角色.道具[内容.数据序列1] = nil
      玩家数据[id].道具.数据[临时id2] = nil
    end
    道具刷新(id)
    常规提示(id,"附魔宝珠使用成功")
end

function 装备处理类:装备特效宝珠(连接id,序号,id,内容)
    local 临时id1 = 玩家数据[id].角色.道具[内容.数据序列2]
    local 临时id2 = 玩家数据[id].角色.道具[内容.数据序列1]
    if 玩家数据[id].道具.数据[临时id1]==nil or 玩家数据[id].道具.数据[临时id1]==0 then
      常规提示(id,"你似乎并没有这样的道具")
      return 0
    elseif 玩家数据[id].道具.数据[临时id2]==nil then
      常规提示(id,"你似乎并没有这样的道具")
      return 0
    elseif 玩家数据[id].道具.数据[临时id2].名称 ~= "特效宝珠" then
      常规提示(id,"请不要移动特效宝珠的位置！")
      return 0
    end
    if 玩家数据[id].道具.数据[临时id1].分类>=7 then
      常规提示(id,"该物品无法开孔")
      return 0
    end
    local 等级  = 玩家数据[id].道具.数据[临时id1].级别限制
    if 等级~=160 then
      常规提示(id,"只有160级的装备才可以附加特效")
      return 0
    end
    local 副属性 ={"物理暴击几率","法术暴击几率","物理暴击伤害","法术暴击伤害","治疗能力","封印命中率","抵抗封印命中率","穿刺效果","格挡物理伤害","法术伤害减免","魔法回复效果"}
    临时属性=副属性[math.random(1,#副属性)]
    local 临时数值
    if 临时属性 == "魔法回复效果" then
       临时数值 = random(10,30)
    elseif 临时属性 == "格挡物理伤害" then
       临时数值 = random(20,40)
    elseif 临时属性 == "治疗能力" then
       临时数值= random(8,25)
    else
       临时数值= string.format("%.2f",random(80,300)/100)
    end
    玩家数据[id].道具.数据[临时id1].新特效 = 临时属性
    玩家数据[id].道具.数据[临时id1].新特效数值 = 临时数值

    if 玩家数据[id].道具.数据[临时id2].数量~=nil and 玩家数据[id].道具.数据[临时id2].数量 > 1 then
      玩家数据[id].道具.数据[临时id2].数量=玩家数据[id].道具.数据[临时id2].数量-1
    else
      玩家数据[id].角色.道具[内容.数据序列1] = nil
      玩家数据[id].道具.数据[临时id2] = nil
    end
    道具刷新(id)
    常规提示(id,"特效宝珠使用成功")
end

local  function 打造金钱公式(等级)
	local fhz = 1000
	fhz = fhz* math.floor(等级/10)
	return fhz
end

local  function 打造体力消耗(等级)
	local fhz = 50
	fhz = math.floor(等级/10)*10
	return fhz
end

local  function 宝石合成体力消耗(等级)
	local fhz = 10
	fhz = 等级*10
	return fhz
end

local  function 宝石合成金钱公式(等级)
	local fhz = 2000
	fhz = fhz* 等级
	return fhz
end

local  function 熔炼消耗(等级)
	local fhz1,fhz2 = 0,0
	if 等级 <= 60 then
		fhz1,fhz2 = 26,8200
	elseif 等级 <= 70 then
		fhz1,fhz2 = 27,10800
	elseif 等级 <= 80 then
		fhz1,fhz2 = 28,13800
	elseif 等级 <= 90 then
		fhz1,fhz2 = 29,17200
	elseif 等级 <= 100 then
		fhz1,fhz2 = 30,21000
	elseif 等级 <= 110 then
		fhz1,fhz2 = 31,25200
	elseif 等级 <= 120 then
		fhz1,fhz2 = 32,29800
	elseif 等级 <= 130 then
		fhz1,fhz2 = 33,34800
	elseif 等级 <=140 then
		fhz1,fhz2 = 34,40200
	elseif 等级 <= 150 then
		fhz1,fhz2 = 35,50200
	elseif 等级 <= 160 then
		fhz1,fhz2 = 36,70200
	end
	return fhz1,fhz2
end

local  function 还原消耗(等级)
	local fhz=0
	if 等级 == 60 then
		fhz = 300000
	elseif 等级 == 70 then
		fhz = 400000
	elseif 等级 == 80 then
		fhz = 500000
	elseif 等级 == 90 then
		fhz = 600000
	elseif 等级 == 100 then
		fhz = 700000
	elseif 等级 == 110 then
		fhz = 800000
	elseif 等级 == 120 then
		fhz = 900000
	elseif 等级 == 130 then
		fhz = 1000000
	elseif 等级 ==140 then
		fhz = 1180000
	elseif 等级 == 150 then
		fhz = 1290000
	elseif 等级 == 160 then
		fhz = 1890000
	end
	return fhz
end

local  function 修理消耗(等级)
	local fhz1,fhz2 = 0,0
	if 等级 <= 60 then
		fhz1,fhz2 = 120,8200*5
	elseif 等级 <= 70 then
		fhz1,fhz2 = 140,10800*5
	elseif 等级 <= 80 then
		fhz1,fhz2 = 160,13800*5
	elseif 等级 <= 90 then
		fhz1,fhz2 = 180,17200*5
	elseif 等级 <= 100 then
		fhz1,fhz2 = 200,21000*5
	elseif 等级 <= 110 then
		fhz1,fhz2 = 220,25200*5
	elseif 等级 <= 120 then
		fhz1,fhz2 = 240,29800*5
	elseif 等级 <= 130 then
		fhz1,fhz2 = 260,34800*5
	elseif 等级 <=140 then
		fhz1,fhz2 = 280,40200*5
	elseif 等级 <= 150 then
		fhz1,fhz2 = 300,50200*5
	elseif 等级 <= 160 then
		fhz1,fhz2 = 320,70200*5
	end
	return fhz1,fhz2
end

function 装备处理类:取召唤兽镶嵌(装备分类,宝石特效)
	if (宝石特效=="速度" or 宝石特效=="躲避") and 装备分类==8 then --7 护腕，8项圈，9铠甲
		return true
	elseif (宝石特效=="伤害" or 宝石特效=="灵力") and 装备分类==7 then
		return true
	elseif (宝石特效=="防御" or 宝石特效=="气血") and 装备分类==9 then
		return true
	end
	return false
end

function 装备处理类:打造类型处理(连接id,序号,id,内容)
	local 格子1=玩家数据[id].角色.道具[内容.序列]
	local 格子2=玩家数据[id].角色.道具[内容.序列1]
	local 格子3=0
	if 内容.序列3~=nil then
		格子3=玩家数据[id].角色.道具[内容.序列3]
	end
	local 分类 = 内容.分类标识
	local 功能 = 内容.功能标识
	local 对方id = 内容.对方id
	local 工钱 = 内容.工钱 or 0
	if 对方id == nil then
		对方id = id
	end
	if (玩家数据[id].道具.数据[格子1]==nil or 玩家数据[id].道具.数据[格子2]==nil ) and 分类 ~= "修理" and 功能 ~= "还原装备"  then
		道具刷新(id)
		return
	elseif 分类 ~= "镶嵌" and 功能 == "星辉石" and (玩家数据[id].道具.数据[格子1]==nil or 玩家数据[id].道具.数据[格子2]==nil or 玩家数据[id].道具.数据[格子3]==nil)  then
		道具刷新(id)
		return
	end
	if 分类 == "打造" then
		if 功能 == "强化人物装备" then
			local 制造格子,精铁格子,元神打造,是否返回= self:取格子(格子1,格子2,id,5)
			if 是否返回 then return end
			if not 元神打造 and not self:取打造方式(玩家数据[id].道具.数据[制造格子].特效,玩家数据[id].道具.数据[制造格子].子类,id,对方id) then
				return --常规提示(id,"打造物品失败")
			elseif 元神打造 and not self:取打造方式(玩家数据[id].道具.数据[制造格子].子类,160,id,对方id) then
				return --常规提示(id,"打造物品失败")
			end

			if not self:打造判定消耗(玩家数据[id].道具.数据[制造格子],玩家数据[id].道具.数据[精铁格子],分类,功能,id,对方id,工钱)then
								return
			end
			if not 元神打造 then
				local 临时序列=玩家数据[id].道具.数据[制造格子].特效
				if 临时序列==25 then
					临时序列=23
				elseif 临时序列==24 then
					临时序列=22
				elseif 临时序列==23 or 临时序列==22 then
					临时序列=21
				elseif 临时序列==21 then
					临时序列=20
				elseif 临时序列==20 or 临时序列==19 then
					临时序列=19
				end
				local 临时等级=玩家数据[id].道具.数据[制造格子].子类/10
				if 临时序列<=18 and 临时等级>=9 then --是武器 10-12是普通光武
					if 临时等级<12 then
						临时等级=取随机数(10,12)
					elseif 临时等级<15 then
						临时等级=取随机数(13,15)
					else
						临时等级=临时等级+1
					end
				end
				local 临时类型=self.打造物品[临时序列][临时等级]
				if 临时序列>=19 then
					临时类型=self.打造物品[临时序列][临时等级+1]
				end
				if type(临时类型)=="table" then
					if 玩家数据[id].道具.数据[制造格子].特效 ==23 then
						临时类型=临时类型[2]
					elseif 玩家数据[id].道具.数据[制造格子].特效 ==22 then
						临时类型=临时类型[1]
					elseif 玩家数据[id].道具.数据[制造格子].特效 ==20 then
						临时类型=临时类型[2]
					elseif 玩家数据[id].道具.数据[制造格子].特效 ==19 then
						临时类型=临时类型[1]
					else
						临时类型=临时类型[取随机数(1,2)]
					end
				end
				打造150装备(id,临时类型,玩家数据[id].道具.数据[制造格子].子类,临时序列,对方id)
				玩家数据[id].道具.数据[制造格子]=nil
				玩家数据[id].道具.数据[精铁格子]=nil
				玩家数据[id].角色.道具[内容.序列]=nil
				玩家数据[id].角色.道具[内容.序列1]=nil
				常规提示(对方id,"打造熟练度增加"..临时等级)
				if 玩家数据[id].打造方式 == 1 then
					玩家数据[对方id].角色:增加生活技能熟练("打造技巧",临时等级)
				elseif 玩家数据[id].打造方式 == 2 then
					玩家数据[对方id].角色:增加生活技能熟练("裁缝技巧",临时等级)
				end
				道具刷新(id)
			else --元身打造
				local xl = self:取元身序列(玩家数据[id].道具.数据[制造格子].名称)
				local mc = self:取160名称(xl)
				local 打造id=id
				if 玩家数据[对方id] and 玩家数据[对方id].角色 then
					打造id=对方id
					玩家数据[id].道具.数据[制造格子].制造者 = 玩家数据[对方id].角色.名称.."强化打造"
				else
					玩家数据[id].道具.数据[制造格子].制造者 = 玩家数据[id].角色.名称.."强化打造"
				end
				打造160装备(id,mc,玩家数据[id].道具.数据[制造格子],打造id)
				玩家数据[id].道具.数据[制造格子]=nil
				玩家数据[id].道具.数据[精铁格子]=nil
				玩家数据[id].角色.道具[内容.序列]=nil
				玩家数据[id].角色.道具[内容.序列1]=nil
				道具刷新(id)
				return
			end
		elseif 功能 == "普通人物装备" then
			local 制造格子,精铁格子,元神打造,是否返回= self:取格子(格子1,格子2,id,5)
			if 是否返回 then return end
			if not self:取打造方式(玩家数据[id].道具.数据[制造格子].特效,玩家数据[id].道具.数据[制造格子].子类,id,对方id) then
				return --常规提示(id,"打造物品失败")
			elseif not self:打造判定消耗(玩家数据[id].道具.数据[制造格子],玩家数据[id].道具.数据[精铁格子],分类,功能,id,对方id,工钱)then
				return
			end
			local 临时序列=玩家数据[id].道具.数据[制造格子].特效
			if 临时序列==25 then
				临时序列=23
			elseif 临时序列==24 then
				临时序列=22
			elseif 临时序列==23 or 临时序列==22 then
				临时序列=21
			elseif 临时序列==21 then
				临时序列=20
			elseif 临时序列==20 or 临时序列==19 then
				临时序列=19
			end
			local 临时等级=玩家数据[id].道具.数据[制造格子].子类/10
			local 制造等级=临时等级
			-- 计算武器值
			if 临时序列<=18 and 临时等级>=9 then --是武器 10-12是普通光武
				if 临时等级<12 then
					临时等级=取随机数(10,12)
				elseif 临时等级<15 then
					临时等级=取随机数(13,15)
				else
					临时等级=临时等级+1
				end
			end
			local 临时类型=self.打造物品[临时序列][临时等级]
			if 临时序列>=19 then
				 临时类型=self.打造物品[临时序列][临时等级+1]
			end
			if type(临时类型)=="table" then
				if 玩家数据[id].道具.数据[制造格子].特效 ==23 then
				 临时类型=临时类型[2]
				elseif 玩家数据[id].道具.数据[制造格子].特效 ==22 then
				 临时类型=临时类型[1]
				elseif 玩家数据[id].道具.数据[制造格子].特效 ==20 then
				 临时类型=临时类型[2]
				elseif 玩家数据[id].道具.数据[制造格子].特效 ==19 then
				 临时类型=临时类型[1]
				else
						临时类型=临时类型[取随机数(1,2)]
				end
			end
			玩家数据[id].道具.数据[制造格子]=nil
			玩家数据[id].道具.数据[精铁格子]=nil
			玩家数据[id].角色.道具[内容.序列]=nil
			玩家数据[id].角色.道具[内容.序列1]=nil
			self:生成打造装备(id,制造等级*10,临时序列,临时类型,"普通打造",玩家数据[对方id].角色.名称.."打造")
			常规提示(id,"制造装备成功")
			if 玩家数据[id].打造方式 == 1 then
				玩家数据[对方id].角色:增加生活技能熟练("打造技巧",制造等级)
			elseif 玩家数据[id].打造方式 == 2 then
				玩家数据[对方id].角色:增加生活技能熟练("裁缝技巧",制造等级)
			end
		elseif 功能 == "召唤兽装备" then
			local 天珠格子=0
			local 图策格子=0
			if 玩家数据[id].道具.数据[格子1].名称=="上古锻造图策" and (玩家数据[id].道具.数据[格子2].名称=="天眼珠" or 玩家数据[id].道具.数据[格子2].名称=="三眼天珠" or 玩家数据[id].道具.数据[格子2].名称=="九眼天珠" ) then
				图策格子=格子1
				天珠格子=格子2
			elseif 玩家数据[id].道具.数据[格子2].名称=="上古锻造图策" and (玩家数据[id].道具.数据[格子1].名称=="天眼珠" or 玩家数据[id].道具.数据[格子1].名称=="三眼天珠" or 玩家数据[id].道具.数据[格子1].名称=="九眼天珠" ) then
				图策格子=格子2
				天珠格子=格子1
			end
			if  天珠格子 == 0 or 图策格子==0 then
				常规提示(id,"打造装备需要使用上古锻造图策和天珠，你这给我的是啥玩意？？？")
				return
			end
			if 玩家数据[id].道具.数据[图策格子].级别限制>玩家数据[id].道具.数据[天珠格子].级别限制 then
				常规提示(id,"天珠的等级小于图策的等级")
				return 0
			end
			if not self:打造判定消耗(玩家数据[id].道具.数据[图策格子],玩家数据[id].道具.数据[天珠格子],分类,功能,id,对方id,工钱)then

				return
			end
			local 类型序列=0
			if 玩家数据[id].道具.数据[图策格子].种类=="护腕" then
				类型序列=24
			elseif 玩家数据[id].道具.数据[图策格子].种类=="项圈" then
				类型序列=25
			else
				类型序列=26
			end
			local 临时序列=math.floor(玩家数据[id].道具.数据[图策格子].级别限制/10)
			local 临时名称=self.打造物品[类型序列][临时序列]
			local 道具 = 物品类()
			道具:置对象(临时名称) --以后置对象都要注意
			道具.级别限制 = 玩家数据[id].道具.数据[图策格子].级别限制
			道具.召唤兽装备 = true

			local 灵气=玩家数据[id].道具.数据[天珠格子].灵气*0.15
			local 等级=道具.级别限制
			local 等差序列 = math.floor(等级/10)
			if 玩家数据[id].道具.数据[图策格子].种类=="护腕" then
				道具.命中=math.floor(取随机数(5,等级*0.1+10))
			elseif 玩家数据[id].道具.数据[图策格子].种类=="项圈" then
				道具.速度=math.floor(取随机数(等差序列,等差序列*3+灵气))

			else
				道具.防御=math.floor(取随机数(等差序列*5,等差序列*9+灵气))
			end

			local 附加范围={"伤害","灵力","敏捷","耐力","体质","力量","魔力","气血","魔法"}
			for n=1,3 do
				if 取随机数()<=50 then
					local 类型=附加范围[取随机数(1,#附加范围)]

					if 道具[类型]==nil then
						if 类型=="伤害" then
							道具[类型]=math.floor(取随机数(等差序列,等差序列*5+灵气))
							if 取随机数()<=50 then
								道具[类型]=取随机数(1,50)
							end
						elseif 类型=="气血" then
							道具[类型]=math.floor(取随机数(等差序列*4,等差序列*8+灵气))
							if 取随机数()<=50 then
								道具[类型]=取随机数(50,200)
							end
						elseif 类型=="魔法" then
							道具[类型]=math.floor(取随机数(等差序列*7,等差序列*12+灵气))
							if 取随机数()<=50 then
								道具[类型]=取随机数(50,200)
							end
						elseif 类型=="力量" then
							道具[类型]=math.floor(取随机数(等差序列,等差序列*3))
							if 取随机数()<=50 then
								道具[类型]=取随机数(1,35)
							end
						elseif 类型=="敏捷" or 类型=="体质" or 类型=="耐力" or 类型=="魔力" or 类型=="灵力"   then
							道具[类型]=math.floor(取随机数(等差序列,等差序列*2))
							if 取随机数()<=50 then
								道具[类型]=取随机数(1,35)
							end
						end
					end
				end
			end

			道具.制造者 = 玩家数据[id].角色.名称
			玩家数据[id].道具.数据[图策格子]=道具
			玩家数据[id].道具.数据[天珠格子]=nil
			if 天珠格子==玩家数据[id].角色.道具[内容.序列] then
				玩家数据[id].角色.道具[内容.序列]=nil
			else
				玩家数据[id].角色.道具[内容.序列1]=nil
			end
			常规提示(id,"制造装备成功")
			道具刷新(id)
		elseif 功能 == "灵饰淬灵" then
			if 玩家数据[id].道具.数据[格子1].总类==5 then
				local 制造格子=0
				local 精铁格子=0
				if 玩家数据[id].道具.数据[格子1].名称=="灵饰指南书" and 玩家数据[id].道具.数据[格子2].名称=="元灵晶石" then
					制造格子=格子1
					精铁格子=格子2
				elseif 玩家数据[id].道具.数据[格子1].名称=="元灵晶石" and 玩家数据[id].道具.数据[格子2].名称=="灵饰指南书" then
					制造格子=格子2
					精铁格子=格子1
				end
				if 玩家数据[id].角色:取任务(5)~=0 then
					常规提示(id,"你已经有强化打造的任务了，请先完成任务在进行打造")
					return
				elseif 制造格子==0 or 精铁格子==0 then
					常规提示(id,"打造装备需要使用灵饰指南书和元灵晶石，你这给我的是啥玩意？？？")
					return
				elseif 玩家数据[id].道具.数据[制造格子].子类+0>玩家数据[id].道具.数据[精铁格子].子类+0 then
					常规提示(id,"你的这块元灵晶石等级太低了，配不上这本制造指南书")
					return

				end
				if not self:打造判定消耗(玩家数据[id].道具.数据[制造格子],玩家数据[id].道具.数据[精铁格子],分类,功能,id,对方id,工钱)then
					常规提示(id,"你没有那么多的体力或金钱")
					return
				end
				local 临时名称=制造装备[玩家数据[id].道具.数据[制造格子].特效][玩家数据[id].道具.数据[制造格子].子类]
				灵饰打造任务(id,临时名称,玩家数据[id].道具.数据[制造格子].子类,玩家数据[id].道具.数据[制造格子].特效,对方id)
				常规提示(对方id,"打造熟练度增加"..玩家数据[id].道具.数据[制造格子].子类/10)
				玩家数据[对方id].角色:增加生活技能熟练("打造技巧",玩家数据[id].道具.数据[制造格子].子类/10)
				玩家数据[id].道具.数据[精铁格子]=nil
				玩家数据[id].道具.数据[制造格子]=nil
				玩家数据[id].角色.道具[内容.序列1]=nil
				玩家数据[id].角色.道具[内容.序列]=nil
				道具刷新(id)
			end
		end
	elseif 分类 == "镶嵌" then
		local 宝石格子=0
		local 装备格子=0
		if 玩家数据[id].道具.数据[格子1].总类==5 or 玩家数据[id].道具.数据[格子1].总类=="召唤兽镶嵌" or 玩家数据[id].道具.数据[格子1].名称=="点化石" then
			宝石格子=格子1
			装备格子=格子2
		else
			宝石格子=格子2
			装备格子=格子1
		end


		if not 玩家数据[id].道具.数据[装备格子].鉴定 then
			常规提示(id,"只有鉴定后的装备才可以镶嵌宝石")
			return
		end
		if 功能 == "宝石" then --1黄宝石 1光芒石 2月亮石 3太阳石 4舍利子 5红玛瑙 6黑宝石 7神秘石 8星辉石
			if 玩家数据[id].道具.数据[宝石格子].分类~=6 then
				常规提示(id,"只有宝石才可以镶嵌在装备上")
				return
			end

			local 装备分类=玩家数据[id].道具.数据[装备格子].分类
		if 玩家数据[id].道具.数据[装备格子].角色限制~=nil then
			if 玩家数据[id].道具.数据[装备格子].分类==4 and 玩家数据[id].道具.数据[装备格子].角色限制[1]=="影精灵" or 玩家数据[id].道具.数据[装备格子].角色限制[1]=="影精灵(九黎城)" or 玩家数据[id].道具.数据[装备格子].角色限制[1]=="影精灵（九黎城）" then
					装备分类=3
			end
		end
			----------------------------------------------------------为把九黎城副武器改为能镶嵌武器类宝石
			if self:取可以镶嵌(装备分类,玩家数据[id].道具.数据[宝石格子].子类) then
				local 宝石等级=0
				if 玩家数据[id].道具.数据[装备格子].锻炼等级~=nil then
					宝石等级=玩家数据[id].道具.数据[装备格子].锻炼等级
				end
				宝石等级=宝石等级+1

				if 玩家数据[id].道具.数据[宝石格子].级别限制<宝石等级 then
					常规提示(id,"该装备目前只能用#R/"..宝石等级.."#Y/级宝石镶嵌")
					return
				elseif 玩家数据[id].道具.数据[装备格子].锻炼等级 and 玩家数据[id].道具.数据[装备格子].锻炼等级 >=玩家数据[id].道具.数据[装备格子].级别限制/10 then
					local 无级别=false
					local 精致=false
					if 玩家数据[id].道具.数据[装备格子].特效 and 玩家数据[id].道具.数据[装备格子].特效[1] then
						for i=1,#玩家数据[id].道具.数据[装备格子].特效 do
							if 玩家数据[id].道具.数据[装备格子].特效[i]=="无级别限制" then
								无级别=true
								break
							end
							if 玩家数据[id].道具.数据[装备格子].特效[i]=="精致" then
								精致=true
							end
						end
					end
					if 无级别==false then
						if 精致 then
							if 玩家数据[id].道具.数据[装备格子].锻炼等级 >=玩家数据[id].道具.数据[装备格子].级别限制/10+1 then
								常规提示(id,"#Y/该装备已经无法再继续镶嵌了")
								return
							end
						else
							常规提示(id,"#Y/该装备已经无法再继续镶嵌了")
							return
						end
					end
				end
				if 玩家数据[id].道具.数据[装备格子].镶嵌宝石==nil then
					玩家数据[id].道具.数据[装备格子].镶嵌宝石={}
					玩家数据[id].道具.数据[装备格子].镶嵌类型={}
					玩家数据[id].道具.数据[装备格子].宝石属性={}
				end
				if 玩家数据[id].道具.数据[装备格子].镶嵌宝石[1]==nil then
					玩家数据[id].道具.数据[装备格子].镶嵌宝石[1]=玩家数据[id].道具.数据[宝石格子].名称
				elseif 玩家数据[id].道具.数据[装备格子].镶嵌宝石[2]==nil and 玩家数据[id].道具.数据[装备格子].镶嵌宝石[1]~=玩家数据[id].道具.数据[宝石格子].名称  then
					玩家数据[id].道具.数据[装备格子].镶嵌宝石[2]=玩家数据[id].道具.数据[宝石格子].名称
				elseif 玩家数据[id].道具.数据[装备格子].镶嵌宝石[1]~=玩家数据[id].道具.数据[宝石格子].名称  and 玩家数据[id].道具.数据[装备格子].镶嵌宝石[2]~=玩家数据[id].道具.数据[宝石格子].名称 then
					常规提示(id,"装备最多只能镶嵌两种不同类型的宝石")
					return
				end
				玩家数据[id].道具.数据[装备格子].锻炼等级=宝石等级
				玩家数据[id].道具.数据[装备格子].镶嵌类型[宝石等级]=玩家数据[id].道具.数据[宝石格子].名称
				if 玩家数据[id].道具.数据[宝石格子].子类 == 1 then
					玩家数据[id].道具.数据[装备格子].宝石属性.气血 = (玩家数据[id].道具.数据[装备格子].宝石属性.气血 or 0) + 40
				elseif 玩家数据[id].道具.数据[宝石格子].子类 == 2 then
					玩家数据[id].道具.数据[装备格子].宝石属性.防御 = (玩家数据[id].道具.数据[装备格子].宝石属性.防御 or 0) + 12
				elseif 玩家数据[id].道具.数据[宝石格子].子类 == 3 then
					玩家数据[id].道具.数据[装备格子].宝石属性.伤害 = (玩家数据[id].道具.数据[装备格子].宝石属性.伤害 or 0) + 8
				elseif 玩家数据[id].道具.数据[宝石格子].子类 == 4 then
					玩家数据[id].道具.数据[装备格子].宝石属性.灵力 = (玩家数据[id].道具.数据[装备格子].宝石属性.灵力 or 0) + 6
				elseif 玩家数据[id].道具.数据[宝石格子].子类 == 5 then
					玩家数据[id].道具.数据[装备格子].宝石属性.命中 = (玩家数据[id].道具.数据[装备格子].宝石属性.命中 or 0) + 25
				elseif 玩家数据[id].道具.数据[宝石格子].子类 == 6 then
					玩家数据[id].道具.数据[装备格子].宝石属性.速度 = (玩家数据[id].道具.数据[装备格子].宝石属性.速度 or 0) + 8
				elseif 玩家数据[id].道具.数据[宝石格子].子类 == 7 then
					玩家数据[id].道具.数据[装备格子].宝石属性.躲避 = (玩家数据[id].道具.数据[装备格子].宝石属性.躲避 or 0) + 20
				elseif 玩家数据[id].道具.数据[宝石格子].子类 == 0 then
					玩家数据[id].道具.数据[装备格子].宝石属性.法术防御 = (玩家数据[id].道具.数据[装备格子].宝石属性.法术防御 or 0) + 12
				end
				if 宝石格子==玩家数据[id].角色.道具[内容.序列] then
					玩家数据[id].角色.道具[内容.序列]=nil
					玩家数据[id].道具.数据[宝石格子]=nil
				else
					玩家数据[id].角色.道具[内容.序列1]=nil
					玩家数据[id].道具.数据[宝石格子]=nil
				end
				常规提示(id,"镶嵌装备成功")
				道具刷新(id)
			else
				常规提示(id,"请检查类型是否正确")
				return
			end
		elseif 功能 == "灵石" then
			if 玩家数据[id].道具.数据[宝石格子].总类~="召唤兽镶嵌" then
				常规提示(id,"只有宝石才可以镶嵌在装备上")
				return
			end
			local 精魄格子=0
			local 装备格子=0
			if 玩家数据[id].道具.数据[格子2].总类=="召唤兽镶嵌" then
				装备格子=格子1
				精魄格子=格子2
			else
				装备格子=格子2
				精魄格子=格子1
			end
			if 玩家数据[id].道具.数据[精魄格子].总类=="召唤兽镶嵌" and 玩家数据[id].道具.数据[装备格子].总类==2
				and (玩家数据[id].道具.数据[装备格子].分类==7 or 玩家数据[id].道具.数据[装备格子].分类==8 or 玩家数据[id].道具.数据[装备格子].分类==9) then

				local 可镶嵌=false
				if 玩家数据[id].道具.数据[装备格子].精魄==nil and 玩家数据[id].道具.数据[装备格子].精魄等级==nil and self:取召唤兽镶嵌(玩家数据[id].道具.数据[装备格子].分类,玩家数据[id].道具.数据[精魄格子].特效) then
					可镶嵌=true
				elseif 玩家数据[id].道具.数据[装备格子].精魄~=nil then
					if 玩家数据[id].道具.数据[装备格子].精魄等级>=玩家数据[id].道具.数据[精魄格子].级别限制 then
						常规提示(id,"宝石等级不满足镶嵌条件")
						return
					end
					if 玩家数据[id].道具.数据[装备格子].精魄~=玩家数据[id].道具.数据[精魄格子].特效 then
						常规提示(id,"不能镶嵌不同属性的宝石")
						return
					end
					可镶嵌=true
				end
				if 可镶嵌 then
					玩家数据[id].道具.数据[装备格子].精魄=玩家数据[id].道具.数据[精魄格子].特效
					if 玩家数据[id].道具.数据[装备格子].精魄等级==nil then
						玩家数据[id].道具.数据[装备格子].精魄等级=0
					end
					玩家数据[id].道具.数据[装备格子].精魄等级=玩家数据[id].道具.数据[装备格子].精魄等级+1
					玩家数据[id].道具.数据[装备格子].宝石属性={}
					if 玩家数据[id].道具.数据[装备格子].精魄=="躲避" then
						玩家数据[id].道具.数据[装备格子].宝石属性.躲避=玩家数据[id].道具.数据[装备格子].精魄等级*20
					elseif 玩家数据[id].道具.数据[装备格子].精魄=="速度" then
						玩家数据[id].道具.数据[装备格子].宝石属性.速度=玩家数据[id].道具.数据[装备格子].精魄等级*6
					elseif 玩家数据[id].道具.数据[装备格子].精魄=="伤害" then
						玩家数据[id].道具.数据[装备格子].宝石属性.伤害=玩家数据[id].道具.数据[装备格子].精魄等级*10
					elseif 玩家数据[id].道具.数据[装备格子].精魄=="灵力" then
						玩家数据[id].道具.数据[装备格子].宝石属性.灵力=玩家数据[id].道具.数据[装备格子].精魄等级*4
					elseif 玩家数据[id].道具.数据[装备格子].精魄=="防御" then
						玩家数据[id].道具.数据[装备格子].宝石属性.防御=玩家数据[id].道具.数据[装备格子].精魄等级*8
					elseif 玩家数据[id].道具.数据[装备格子].精魄=="气血" then
						玩家数据[id].道具.数据[装备格子].宝石属性.气血=玩家数据[id].道具.数据[装备格子].精魄等级*30
					end

					if 精魄格子==玩家数据[id].角色.道具[内容.序列] then
						玩家数据[id].角色.道具[内容.序列]=nil
						玩家数据[id].道具.数据[精魄格子]=nil
					else
						玩家数据[id].角色.道具[内容.序列1]=nil
						玩家数据[id].道具.数据[精魄格子]=nil
					end
					常规提示(id,"镶嵌装备成功")
					道具刷新(id)
					return
				else
					常规提示(id,"请检查类型是否正确")
					return
				end
			end
		elseif 功能 == "星辉石" then
			if 玩家数据[id].道具.数据[宝石格子].分类~=6 then
				常规提示(id,"只有星辉石才可以镶嵌在灵饰上")
				return
			end

			if 玩家数据[id].道具.数据[宝石格子].名称=="星辉石" and 玩家数据[id].道具.数据[装备格子].灵饰 then  --处理灵饰
				if 玩家数据[id].道具.数据[装备格子].幻化等级==nil then
					玩家数据[id].道具.数据[装备格子].幻化等级=0
				end
				if 玩家数据[id].道具.数据[宝石格子].级别限制-1<玩家数据[id].道具.数据[装备格子].幻化等级 then
					常规提示(id,"宝石等级不满足镶嵌条件")
					return
				elseif 玩家数据[id].道具.数据[装备格子].幻化等级>=11 then
					常规提示(id,"灵饰最多镶嵌至11级。")
					return
				elseif 玩家数据[id].道具.数据[装备格子].幻化等级>=玩家数据[id].道具.数据[装备格子].级别限制/10 then
					常规提示(id,"#Y/该装备已经无法再继续镶嵌了")
					return
				end
				玩家数据[id].道具.数据[装备格子].幻化等级=玩家数据[id].道具.数据[装备格子].幻化等级+1
				for n=1,#玩家数据[id].道具.数据[装备格子].幻化属性.附加 do
玩家数据[id].道具.数据[装备格子].幻化属性.附加[n].强化=玩家数据[id].道具.数据[装备格子].幻化属性.附加[n].强化+星辉石属性[玩家数据[id].道具.数据[装备格子].幻化属性.附加[n].类型]
				end
				常规提示(id,"#Y/镶嵌装备成功")
				if 宝石格子==玩家数据[id].角色.道具[内容.序列] then
					玩家数据[id].角色.道具[内容.序列]=nil
					玩家数据[id].道具.数据[宝石格子]=nil
				else
					玩家数据[id].角色.道具[内容.序列1]=nil
					玩家数据[id].道具.数据[宝石格子]=nil
				end
				道具刷新(id)
				return
			else
				常规提示(id,"请检查类型是否正确")
				return
			end

		elseif 功能 == "点化石" then
			if 玩家数据[id].道具.数据[宝石格子].名称~="点化石" then
				常规提示(id,"只有点化石才可以进行此操作")
				return
			end
			if 玩家数据[id].道具.数据[宝石格子].名称=="点化石"  and 玩家数据[id].道具.数据[装备格子].召唤兽装备 then
				if 玩家数据[id].道具.数据[宝石格子].附带技能 then
					local 点化类型 = "附加状态"
					local ads = {"善恶有报","力劈华山","壁垒击破","惊心一剑","剑荡四方","水攻","烈火","雷击","落岩","奔雷咒","水漫金山","地狱烈火","泰山压顶","夜舞倾城","死亡召唤"}
					for i=1,#ads do
						if 玩家数据[id].道具.数据[宝石格子].附带技能==ads[i] then
							点化类型="追加法术"
							break
						end
					end

					玩家数据[id].道具.数据[装备格子].套装效果 = {点化类型,玩家数据[id].道具.数据[宝石格子].附带技能}
					if 宝石格子==玩家数据[id].角色.道具[内容.序列] then
						玩家数据[id].角色.道具[内容.序列]=nil
						玩家数据[id].道具.数据[宝石格子]=nil
					else
						玩家数据[id].角色.道具[内容.序列1]=nil
						玩家数据[id].道具.数据[宝石格子]=nil
					end
					常规提示(id,"#Y/装备点化成功！")
					道具刷新(id)
				end
			else
				常规提示(id,"请检查类型是否正确")
				return
			end
		elseif 功能 == "珍珠" then
			local 装备格子=0
			local 宝石格子=0
			if 玩家数据[id].道具.数据[格子2].总类==2  and 玩家数据[id].道具.数据[格子1].名称=="珍珠" then
				宝石格子=格子1
				装备格子=格子2
			elseif 玩家数据[id].道具.数据[格子1].总类==2  and 玩家数据[id].道具.数据[格子2].名称=="珍珠" then
				宝石格子=格子2
				装备格子=格子1
			end
			if 玩家数据[id].道具.数据[装备格子].修理失败~=nil and 玩家数据[id].道具.数据[装备格子].修理失败 >3 then
				常规提示(id,"#Y/该装备已经无法修理")
				return
			elseif 玩家数据[id].道具.数据[装备格子].耐久 >=400 then
				常规提示(id,"#Y/目前该装备无需修理")
				return
			end
			if 玩家数据[id].道具.数据[宝石格子].级别限制 < 玩家数据[id].道具.数据[装备格子].级别限制 then
				常规提示(id,"珍珠的等级无法修复这件装备")
				return
			end
			if not self:打造判定消耗(玩家数据[id].道具.数据[装备格子],玩家数据[id].道具.数据[装备格子],分类,功能,id,对方id,工钱)then
				常规提示(id,"没有那么多的体力或金钱")
				return
			end
				玩家数据[id].道具.数据[装备格子].耐久 = 玩家数据[id].道具.数据[装备格子].耐久+200--取随机数(500,700)
				常规提示(id,"#Y/装备修理成功！")
			if 宝石格子==玩家数据[id].角色.道具[内容.序列] then
				玩家数据[id].角色.道具[内容.序列]=nil
				玩家数据[id].道具.数据[宝石格子]=nil
			else
				玩家数据[id].角色.道具[内容.序列1]=nil
				玩家数据[id].道具.数据[宝石格子]=nil
			end
			道具刷新(id)
		elseif 功能 == "碎石锤" then
		end
	elseif 分类 == "合成" then
		if 功能 == "宝石" then
			if 玩家数据[id].道具.数据[格子1].总类==5 and 玩家数据[id].道具.数据[格子1].分类==6 and 玩家数据[id].道具.数据[格子2].总类==5 and 玩家数据[id].道具.数据[格子1].分类==6  then
				if 玩家数据[id].道具.数据[格子1].名称=="星辉石" or 玩家数据[id].道具.数据[格子2].名称=="星辉石" then
					常规提示(id,"请检查宝石类型是否正确")
					return
				end
				if 玩家数据[id].道具.数据[格子1].名称~=玩家数据[id].道具.数据[格子2].名称 then
					常规提示(id,"只有类型相同的宝石才可以合成")
					return
				elseif 玩家数据[id].道具.数据[格子1].级别限制~=玩家数据[id].道具.数据[格子2].级别限制 then
					常规提示(id,"只有等级相同的宝石才可以合成")
					return
				end
				if not self:打造判定消耗(玩家数据[id].道具.数据[格子1],玩家数据[id].道具.数据[格子2],分类,功能,id,对方id,工钱)then
					return
				end
				if self:取宝石合成几率(id,玩家数据[id].道具.数据[格子1].级别限制) then
					玩家数据[id].道具:删除道具(连接id,id,"道具",格子2,内容.序列1,1)
					玩家数据[id].道具.数据[格子1].级别限制=玩家数据[id].道具.数据[格子1].级别限制+1
					常规提示(id,"你合成了一个更高级的宝石")
				else
					玩家数据[id].道具:删除道具(连接id,id,"道具",格子2,内容.序列1,1)
					常规提示(id,"合成失败，你因此损失了一颗宝石")
				end
				道具刷新(id)
			end
	    elseif 功能 == "玄灵珠" then
		  	if 玩家数据[id].道具.数据[格子1]==nil or 玩家数据[id].道具.数据[格子2]==nil or 玩家数据[id].道具.数据[格子3]==nil then
		  		常规提示(id,"请放入3个同类型、同等级的玄灵珠")
					return
				elseif string.find(玩家数据[id].道具.数据[格子1].名称,"玄灵珠")==nil then
		  		常规提示(id,"请放入3个同类型、同等级的玄灵珠")
					return
				elseif 玩家数据[id].道具.数据[格子1].名称~=玩家数据[id].道具.数据[格子2].名称	or 玩家数据[id].道具.数据[格子1].名称~=玩家数据[id].道具.数据[格子3].名称 then
		  	  常规提示(id,"请放入3个同类型、同等级的玄灵珠")
					return
				elseif 玩家数据[id].道具.数据[格子1].级别限制>=10 then
	        常规提示(id,"玄灵珠最高10级")
					return
				elseif 玩家数据[id].道具.数据[格子1].级别限制~=玩家数据[id].道具.数据[格子2].级别限制	or 玩家数据[id].道具.数据[格子1].级别限制~=玩家数据[id].道具.数据[格子3].级别限制 then
		  	  常规提示(id,"请放入3个同类型、同等级的玄灵珠")
					return
		  	end
		  	玩家数据[id].道具:删除道具(连接id,id,"道具",格子1,内容.序列,1)
		  	玩家数据[id].道具:删除道具(连接id,id,"道具",格子2,内容.序列1,1)
		  	玩家数据[id].道具.数据[格子3].级别限制 = 玩家数据[id].道具.数据[格子3].级别限制 + 1
	        道具刷新(id)
		----------------------
		elseif 功能 == "灵石" then
			if 玩家数据[id].道具.数据[格子1].总类=="召唤兽镶嵌" and 玩家数据[id].道具.数据[格子2].总类=="召唤兽镶嵌" then
			if 玩家数据[id].道具.数据[格子1].子类~=玩家数据[id].道具.数据[格子2].子类 then
					常规提示(id,"只有类型相同的宝石才可以合成")
					return
				elseif 玩家数据[id].道具.数据[格子1].级别限制~=玩家数据[id].道具.数据[格子2].级别限制 then
					常规提示(id,"只有等级相同的宝石才可以合成")
					return
				elseif 玩家数据[id].道具.数据[格子1].级别限制 >=10 then
					常规提示(id,"精魄灵石最高等级为10级")
					return
				end
				if self:取宝石合成几率(id,玩家数据[id].道具.数据[格子1].级别限制) then
					玩家数据[id].道具:删除道具(连接id,id,"道具",格子2,内容.序列1,1)
					玩家数据[id].道具.数据[格子1].级别限制=玩家数据[id].道具.数据[格子1].级别限制+1
					常规提示(id,"你合成了一个更高级的宝石")
				else
					玩家数据[id].道具:删除道具(连接id,id,"道具",格子2,内容.序列1,1)
					常规提示(id,"合成失败，你因此损失了一颗宝石")
				end
				道具刷新(id)
			end
		elseif 功能 == "星辉石" then
			if 格子3~=0 then
				if 玩家数据[id].道具.数据[格子1].名称=="星辉石" and 玩家数据[id].道具.数据[格子2].名称=="星辉石" and 玩家数据[id].道具.数据[格子3].名称=="星辉石" then
					if 玩家数据[id].道具.数据[格子1].级别限制~=玩家数据[id].道具.数据[格子2].级别限制 or 玩家数据[id].道具.数据[格子1].级别限制~=玩家数据[id].道具.数据[格子3].级别限制 or 玩家数据[id].道具.数据[格子2].级别限制~=玩家数据[id].道具.数据[格子3].级别限制 then
						常规提示(id,"只有等级相同的宝石才可以合成")
						return
					elseif 玩家数据[id].道具.数据[格子1].级别限制 >=11 then
						常规提示(id,"星辉石最高等级为11级")
						return
					end
					if self:取宝石合成几率(id,玩家数据[id].道具.数据[格子1].级别限制) then
						玩家数据[id].道具:删除道具(连接id,id,"道具",格子2,内容.序列1,1)
						玩家数据[id].道具:删除道具(连接id,id,"道具",格子3,内容.序列3,1)
						玩家数据[id].道具.数据[格子1].级别限制=玩家数据[id].道具.数据[格子1].级别限制+1
						常规提示(id,"你合成了一个更高级的宝石")
					else
						玩家数据[id].道具:删除道具(连接id,id,"道具",格子3,内容.序列3,1)
						常规提示(id,"合成失败，你因此损失了一颗宝石")
					end
					道具刷新(id)
				else
					常规提示(id,"请检查宝石类型是否正确")
					return
				end
			end
		elseif 功能 == "变身卡" then
			常规提示(id,"该功能正在完善中^^")
			return
		elseif 功能 == "碎石锤" then
			常规提示(id,"该功能正在完善中^^")
			return
		elseif 功能 == "精铁" then
		elseif 功能 == "暗器" then
			常规提示(id,"该功能正在完善中^^")
			return
		elseif 功能 == "钟灵石" then
			if 格子3~=0 then
				if 玩家数据[id].道具.数据[格子1].名称=="钟灵石" and 玩家数据[id].道具.数据[格子2].名称=="钟灵石" and 玩家数据[id].道具.数据[格子3].名称=="钟灵石" then
					if 玩家数据[id].道具.数据[格子1].级别限制~=玩家数据[id].道具.数据[格子2].级别限制 or 玩家数据[id].道具.数据[格子1].级别限制~=玩家数据[id].道具.数据[格子3].级别限制 or 玩家数据[id].道具.数据[格子2].级别限制~=玩家数据[id].道具.数据[格子3].级别限制 then
						常规提示(id,"只有等级相同的钟灵石才可以合成")
						return
					elseif 玩家数据[id].道具.数据[格子1].技能~=玩家数据[id].道具.数据[格子2].技能 or 玩家数据[id].道具.数据[格子1].技能~=玩家数据[id].道具.数据[格子3].技能 or 玩家数据[id].道具.数据[格子2].技能~=玩家数据[id].道具.数据[格子3].技能 then
						常规提示(id,"只有技能相同的钟灵石才可以合成")
						return
					elseif 玩家数据[id].道具.数据[格子1].级别限制 >=8 then
						常规提示(id,"钟灵石最高等级为8级")
						return
					end

					if self:取钟灵石合成几率(id,玩家数据[id].道具.数据[格子1].级别限制) then
						玩家数据[id].道具:删除道具(连接id,id,"道具",格子2,内容.序列1,1)
						玩家数据[id].道具:删除道具(连接id,id,"道具",格子3,内容.序列3,1)
						玩家数据[id].道具.数据[格子1].级别限制=玩家数据[id].道具.数据[格子1].级别限制+1
						常规提示(id,"你合成了一个更高级的钟灵石")
					else
						玩家数据[id].道具:删除道具(连接id,id,"道具",格子3,内容.序列3,1)
						常规提示(id,"合成失败，你因此损失了一颗宝石")
					end
					道具刷新(id)
				else
					常规提示(id,"请检查宝石类型是否正确")
					return
				end
			end
		end
	elseif 分类 == "修理" then
		if 功能 == "人物装备" then
			local 装备格子=0
			local 宝石格子=0
			if 玩家数据[id].道具.数据[格子2].总类==2  and 玩家数据[id].道具.数据[格子1].名称=="珍珠" then
				宝石格子=格子1
				装备格子=格子2
			elseif 玩家数据[id].道具.数据[格子1].总类==2  and 玩家数据[id].道具.数据[格子2].名称=="珍珠" then
				宝石格子=格子2
				装备格子=格子1
			end
			if 玩家数据[id].道具.数据[装备格子].修理失败~=nil and 玩家数据[id].道具.数据[装备格子].修理失败 >3 then
				常规提示(id,"#Y/该装备已经无法修理")
				return
			elseif 玩家数据[id].道具.数据[装备格子].耐久 >=800 then
				常规提示(id,"#Y/目前该装备无需修理")
				return
			end
			if 玩家数据[id].道具.数据[宝石格子].级别限制 < 玩家数据[id].道具.数据[装备格子].级别限制 then
				常规提示(id,"珍珠的等级无法修复这件装备")
				return
			end

			if not self:打造判定消耗(玩家数据[id].道具.数据[装备格子],玩家数据[id].道具.数据[装备格子],分类,功能,id,对方id,工钱)then
				常规提示(id,"没有那么多的体力或金钱")
				return
			end
				玩家数据[id].道具.数据[装备格子].耐久 = 玩家数据[id].道具.数据[装备格子].耐久+200--取随机数(500,700)
				常规提示(id,"#Y/装备修理成功！")
			if 宝石格子==玩家数据[id].角色.道具[内容.序列] then
				玩家数据[id].角色.道具[内容.序列]=nil
				玩家数据[id].道具.数据[宝石格子]=nil
			else
				玩家数据[id].角色.道具[内容.序列1]=nil
				玩家数据[id].道具.数据[宝石格子]=nil
			end
			道具刷新(id)
		elseif 功能 == "召唤兽装备" then
		elseif 功能 == "召唤兽装饰" then
		elseif 功能 == "坐骑装饰" then
		end
	elseif 分类 == "熔炼" then
		if 功能 == "熔炼装备" then
			local 宝石格子=0
			local 装备格子=0
			if 玩家数据[id].道具.数据[格子1].名称=="钨金" and (玩家数据[id].道具.数据[格子2].总类 == 2 and 玩家数据[id].道具.数据[格子2].分类 <=6) then
				宝石格子=格子1
				装备格子=格子2
			elseif 玩家数据[id].道具.数据[格子2].名称=="钨金" and (玩家数据[id].道具.数据[格子1].总类 == 2 and 玩家数据[id].道具.数据[格子1].分类 <=6) then
				宝石格子=格子2
				装备格子=格子1
			end
			if 宝石格子 == 0 or 装备格子 == 0  then
				常规提示(id,"只有钨金和人物装备才可以熔炼")
				return
			elseif 玩家数据[id].道具.数据[装备格子].耐久 < 100 then
				常规提示(id,"这件装备耐久度不足100，无法熔炼")
				return
			elseif 玩家数据[id].道具.数据[装备格子].级别限制 < 60 or 玩家数据[id].道具.数据[装备格子].鉴定==false then
				常规提示(id,"大于等于60级的装备才可以熔炼")
				return
			elseif 玩家数据[id].道具.数据[宝石格子].级别限制 < 玩家数据[id].道具.数据[装备格子].级别限制 then
				常规提示(id,"钨金等级小于装备等级无法熔炼")
				return
			end
			if 玩家数据[id].道具.数据[装备格子].熔炼效果==nil then
				玩家数据[id].道具.数据[装备格子].熔炼效果 = {}
			end
			local ZB=玩家数据[id].道具.数据[装备格子]
			local lv = ZB.级别限制
			local 分类=ZB.分类
			local TL=self.双加熔炼数据[lv].体力
			local JQ=self.双加熔炼数据[lv].银两
			if 玩家数据[id].角色.体力<TL then
				常规提示(id,"你没有那么多的体力")
				return
			elseif 玩家数据[id].角色.银子<JQ and not 玩家数据[id].角色.武神坛角色 then
				常规提示(id,"你没有那么多的银子")
				return
			end
			if 取随机数()<=70 then
				local 词组=""
				if 分类 == 1 then --头盔
					local FY,MF=self.装备数据.头盔.基础属性(lv,"强化打造")
					local 熔炼上限={防御=qz((FY[2]-ZB.防御)/1.5),魔法=qz((MF[2]-ZB.魔法)/1.5)}
					local sx={"防御","魔法"}
					for i=1,2 do
						if ZB.熔炼效果[sx[i]]==nil then
							ZB.熔炼效果[sx[i]]=0
						end
						if ZB.熔炼效果[sx[i]]>=熔炼上限[sx[i]] then
							常规提示(id,"#Y装备上的"..sx[i].."属性已达熔炼上限，该属性无法通过熔炼继续提升。")
							table.remove(sx, i)
						end
					end
					if #sx==0 then
						return
					else
						local 属性=sx[取随机数(1,#sx)]
						local max =(熔炼上限[属性]-ZB.熔炼效果[属性])/10+2 --这个差永远大于2
						local num =取随机数(-2,max)
						if num+ZB.熔炼效果[属性]>熔炼上限[属性] then
							num=熔炼上限[属性]-ZB.熔炼效果[属性]
						end
						if num==0 then
							num=-1
						end
						ZB.熔炼效果[属性]=ZB.熔炼效果[属性]+num
						if num>0 then
							词组="增加了"..num.."点"..属性
						elseif num<0 then
							num=-num
							词组="好像减少了"..num.."点"..属性
						end
					end
				elseif 分类 == 2 then --项链
					if ZB.熔炼效果["灵力"]==nil then
						ZB.熔炼效果["灵力"]=0
					end
					local LL=self.装备数据.项链.基础属性(lv,"强化打造")
					local 熔炼上限={灵力=qz((LL[2]-ZB.灵力)/1.5)}
					if ZB.熔炼效果["灵力"]>=熔炼上限["灵力"] then
						常规提示(id,"#Y装备上的灵力属性已达熔炼上限，该属性无法通过熔炼继续提升。")
						return
					end
					local max =(熔炼上限["灵力"]-ZB.熔炼效果["灵力"])/10+2 --这个差永远大于2
					local num =取随机数(-2,max)
					if num+ZB.熔炼效果["灵力"]>=熔炼上限["灵力"] then
						num=熔炼上限["灵力"]-ZB.熔炼效果["灵力"]
					end
					if num==0 then
						num=-1
					end
					ZB.熔炼效果["灵力"]=ZB.熔炼效果["灵力"]+num
					if num>0 then
						词组="增加了"..num.."点灵力"
					elseif num<0 then
						num=-num
						词组="好像减少了"..num.."点灵力"
					end
				elseif 分类 == 3 or 分类 == 4 then
					local sjsx={"防御","力量","敏捷","体质","魔力","耐力"}
					local go=false
					local sx={}
					if ZB.子类 ==  911  then
						sjsx={"力量","敏捷","体质","魔力","耐力"}
							for i=1,5 do
							if ZB[sjsx[i]]~=nil then
							go=true
							if ZB.熔炼效果[sjsx[i]]==nil then
							ZB.熔炼效果[sjsx[i]]=0
							end
							sx[#sx+1]=sjsx[i]
							end
							end
						else
						sjsx={"防御","力量","敏捷","体质","魔力","耐力"}
							for i=1,6 do
							if ZB[sjsx[i]]~=nil then
							go=true
							if ZB.熔炼效果[sjsx[i]]==nil then
							ZB.熔炼效果[sjsx[i]]=0
							end
							sx[#sx+1]=sjsx[i]
							end
							end
					end

					if go==false and 分类==3 then
						常规提示(id,"#Y没有双加或单加的武器无法进行熔炼")
						return
					end
					local 类型="单加"
					if #sx>1 then
						类型="双加"
					end
					local 记录删除
					local 熔炼上限={}
					local FY=self.装备数据.衣服.基础属性(lv,"强化打造")

					for i=1,#sx do
						if sx[i] ~= nil then
							if sx[i]=="防御" and ZB.子类 ~= 911  then
								熔炼上限={防御=qz((FY[2]-ZB.防御)/1.5)}
							else
							熔炼上限[sx[i]]=self.双加熔炼数据[lv][类型]
							end
							if ZB.熔炼效果[sx[i]]>=熔炼上限[sx[i]] then
								常规提示(id,"#Y装备上的"..sx[i].."属性已达熔炼上限，该属性无法通过熔炼继续提升。")
								记录删除=i
							end
						end
					end
					if 记录删除 then
						table.remove(sx, 记录删除)
					end
					local abc={}
					for an=1,3 do
						if sx[an]~=nil then
							table.insert(abc,sx[an])
						end
					end
					sx=abc
					if #sx==0 then
						return
					else
						local 属性=sx[取随机数(1,#sx)]
						local max =(熔炼上限[属性]-ZB.熔炼效果[属性])/10
						local num =取随机数(-2,3)
						if num+ZB.熔炼效果[属性]>熔炼上限[属性] then
							num=熔炼上限[属性]-ZB.熔炼效果[属性]
						end
						if num==0 then
							num=-1
						end
						ZB.熔炼效果[属性]=ZB.熔炼效果[属性]+num
						if num>0 then
							词组="增加了"..num.."点"..属性
						elseif num<0 then
							num=-num
							词组="好像减少了"..num.."点"..属性
						end
					end
				elseif 分类 == 5 then --腰带
					local FY,QX=self.装备数据.腰带.基础属性(lv,"强化打造")
					local 熔炼上限={防御=qz((FY[2]-ZB.防御)/1.5),气血=qz((QX[2]-ZB.气血)/1.5)}
					local sx={"防御","气血"}
					for i=1,2 do
						if ZB.熔炼效果[sx[i]]==nil then
							ZB.熔炼效果[sx[i]]=0
						end
						if ZB.熔炼效果[sx[i]]>=熔炼上限[sx[i]] then
							常规提示(id,"#Y装备上的"..sx[i].."属性已达熔炼上限，该属性无法通过熔炼继续提升。")
							table.remove(sx, i)
						end
					end
					if #sx==0 then
						return
					else
						local 属性=sx[取随机数(1,#sx)]
						local max =(熔炼上限[属性]-ZB.熔炼效果[属性])/10+2 --这个差永远大于2

						local num =取随机数(-2,max)
						if num+ZB.熔炼效果[属性]>熔炼上限[属性] then
							num=熔炼上限[属性]-ZB.熔炼效果[属性]
						end
						if num==0 then
							num=-1
						end
						ZB.熔炼效果[属性]=ZB.熔炼效果[属性]+num
						if num>0 then
							词组="增加了"..num.."点"..属性
						elseif num<0 then
							num=-num
							词组="好像减少了"..num.."点"..属性
						end
					end
				elseif 分类 == 6 then --鞋子
					local FY,MJ=self.装备数据.鞋子.基础属性(lv,"强化打造")
					local 熔炼上限={防御=qz((FY[2]-ZB.防御)/1.5),敏捷=qz((MJ[2]-ZB.敏捷)/1.2)}
					local sx={"防御","敏捷"}
					for i=1,2 do
						if ZB.熔炼效果[sx[i]]==nil then
							ZB.熔炼效果[sx[i]]=0
						end
						if ZB.熔炼效果[sx[i]]>=熔炼上限[sx[i]] then
							常规提示(id,"#Y装备上的"..sx[i].."属性已达熔炼上限，该属性无法通过熔炼继续提升。")
							table.remove(sx, i)
						end
					end
					if #sx==0 then
						return
					else
						local 属性=sx[取随机数(1,#sx)]
						local max =(熔炼上限[属性]-ZB.熔炼效果[属性])/10+2 --这个差永远大于2
						local num =取随机数(-2,max)
						if num+ZB.熔炼效果[属性]>熔炼上限[属性] then
							num=熔炼上限[属性]-ZB.熔炼效果[属性]
						end
						if num==0 then
							num=-1
						end
						ZB.熔炼效果[属性]=ZB.熔炼效果[属性]+num
						if num>0 then
							词组="增加了"..num.."点"..属性
						elseif num<0 then
							num=-num
							词组="好像减少了"..num.."点"..属性
						end
					end
				end
				玩家数据[id].道具.数据[装备格子].耐久=玩家数据[id].道具.数据[装备格子].耐久-5
				常规提示(id,"#Y熔炼成功，"..词组.."，扣除"..TL.."点体力，"..JQ.."两金钱，并损耗了熔炼装备5点耐久")
			else
				local num=取随机数(1,20)
				玩家数据[id].道具.数据[装备格子].耐久=玩家数据[id].道具.数据[装备格子].耐久-num
				常规提示(id,"#Y熔炼失败，好像减少了"..num.."点耐久，扣除"..TL.."点体力， "..JQ.."两金钱，并损耗了熔炼装备5点耐久")
			end
			玩家数据[id].角色.体力= 玩家数据[id].角色.体力-TL
			玩家数据[id].角色:扣除银子(JQ,0,0,"熔炼",1)
			if 宝石格子==玩家数据[id].角色.道具[内容.序列] then
				if 玩家数据[id].道具.数据[宝石格子].数量 and 玩家数据[id].道具.数据[宝石格子].数量>1 then
					玩家数据[id].道具.数据[宝石格子].数量=玩家数据[id].道具.数据[宝石格子].数量-1
				else
					玩家数据[id].角色.道具[内容.序列]=nil
					玩家数据[id].道具.数据[宝石格子]=nil
				end
			else
				if 玩家数据[id].道具.数据[宝石格子].数量 and 玩家数据[id].道具.数据[宝石格子].数量>1 then
					玩家数据[id].道具.数据[宝石格子].数量=玩家数据[id].道具.数据[宝石格子].数量-1
				else
					玩家数据[id].角色.道具[内容.序列1]=nil
					玩家数据[id].道具.数据[宝石格子]=nil
				end
			end
			道具刷新(id)
			体活刷新(id)
		elseif 功能 == "还原装备" then
			local 装备格子=0
			if 玩家数据[id].道具.数据[格子1].总类 == 2  then
				装备格子=格子1
			end
			if not self:打造判定消耗(玩家数据[id].道具.数据[装备格子],玩家数据[id].道具.数据[装备格子],分类,功能,id,对方id,工钱) then
				return
			end
			if 装备格子 == 0  then
				常规提示(id,"只有人物装备才可以还原装备")
				return
			end
			if 玩家数据[id].道具.数据[装备格子].分类 > 6 then
				常规提示(id,"只有人物装备才可以还原装备")
				return
			end
			玩家数据[id].道具.数据[装备格子].熔炼效果 = {}
			发送数据(玩家数据[id].连接id,1501,{名称="",模型="",对话=format("还原成功，这件装备已经没有熔炼效果了。")})
			道具刷新(id)
		end
	elseif 分类 == "分解" then
		if 功能 == "分解装备" then
			local 制造格子=0
			local 分解符格子=0
			local 完成 = false
			if 玩家数据[id].道具.数据[格子1].总类 == 2 and 玩家数据[id].道具.数据[格子2]. 总类 == 5 then
				制造格子=格子1
				分解符格子=格子2
			elseif 玩家数据[id].道具.数据[格子1]. 总类 == 5 and 玩家数据[id].道具.数据[格子2].总类 == 2 then
				制造格子=格子2
				分解符格子=格子1
			else
				常规提示(id,"请检查类型是否正确")
				return
			end
			if 玩家数据[id].道具.数据[制造格子].分类 > 13 then
				常规提示(id,"请检查类型是否正确")
				return
			end

			if 玩家数据[id].道具.数据[分解符格子].分类 ~= 22 then
				常规提示(id,"请检查类型是否正确")
				return
			end
			if 玩家数据[id].道具.数据[分解符格子].数量 == nil then
				常规提示(id,"请检查类型是否正确")
				return
			end
			local 需分解符,需求体力,分解获得=self:取分解方法(玩家数据[id].道具.数据[制造格子].级别限制,玩家数据[id].道具.数据[制造格子].分类)
			if 玩家数据[id].道具.数据[分解符格子].数量 < 需分解符 then
				常规提示(id,"分解符数量不足无法分解")
				return
			end
			if 玩家数据[id].角色.体力 < 需求体力 then
				常规提示(id,"体力不足无法分解")
				return
			end
			if 玩家数据[id].道具.数据[制造格子].分类 >=1 and 玩家数据[id].道具.数据[制造格子].分类 <10 then --装备和宝宝装备
				if 玩家数据[id].道具.数据[制造格子].级别限制==160 then

					local num = 取随机数(1,7)
					for n=1,num do
						玩家数据[id].道具:给予道具(id,"陨铁")
					end
				else
					for i=1,分解获得 do
						玩家数据[id].道具:给予道具(id,"吸附石")
					end
				end
				完成=true
			elseif 玩家数据[id].道具.数据[制造格子].分类 >=10 and 玩家数据[id].道具.数据[制造格子].分类 <= 13 then --灵饰
				for i=1,分解获得[1] do
					玩家数据[id].道具:给予道具(id,"星辉石",分解获得[2])
				end
				完成=true
			end
			if 完成 then
				玩家数据[id].道具.数据[分解符格子].数量 = 玩家数据[id].道具.数据[分解符格子].数量-需分解符
				玩家数据[id].角色.体力= 玩家数据[id].角色.体力-需求体力
				if 玩家数据[id].道具.数据[分解符格子].数量==nil or 玩家数据[id].道具.数据[分解符格子].数量 <=0 then
					玩家数据[id].道具.数据[分解符格子]=nil
				end
				玩家数据[id].道具.数据[制造格子]=nil
				体活刷新(id)
				道具刷新(id)
				常规提示(id,"装备分解成功。")
			end
		elseif 功能 == "分解灵犀玉" then
		elseif 功能 == "宝石降级" then
			local 宝石格子=0
			local 装备格子=0
			if 玩家数据[id].道具.数据[格子1].总类==5 then
				宝石格子=格子1
				装备格子=格子2
			else
				宝石格子=格子2
				装备格子=格子1
			end
			if 玩家数据[id].道具.数据[装备格子].镶嵌类型==nil or 玩家数据[id].道具.数据[装备格子].镶嵌宝石==nil or 玩家数据[id].道具.数据[装备格子].锻炼等级==nil then
				return
			end
			if 玩家数据[id].道具.数据[宝石格子].名称=="精致碎石锤" and 玩家数据[id].道具.数据[装备格子].总类 == 2 and 玩家数据[id].道具.数据[装备格子].级别限制 <= 160 then
				local 敲掉等级 = 玩家数据[id].道具.数据[装备格子].锻炼等级
				local 敲掉名称 = 玩家数据[id].道具.数据[装备格子].镶嵌类型[敲掉等级]

				if 敲掉等级 >= 1 and 玩家数据[id].道具.数据[装备格子].镶嵌类型[敲掉等级] ~= nil then
					玩家数据[id].道具.数据[装备格子].锻炼等级=nil
					玩家数据[id].道具.数据[装备格子].镶嵌宝石=nil
					玩家数据[id].道具.数据[装备格子].镶嵌类型=nil
					玩家数据[id].道具.数据[装备格子].宝石属性={}
					if 宝石格子==玩家数据[id].角色.道具[内容.序列] then
						玩家数据[id].角色.道具[内容.序列]=nil
						玩家数据[id].道具.数据[宝石格子]=nil
					else
						玩家数据[id].角色.道具[内容.序列1]=nil
						玩家数据[id].道具.数据[宝石格子]=nil
					end
					道具刷新(id)
					玩家数据[id].道具:给予道具(id,敲掉名称,敲掉等级)
					return
				else
					常规提示(id,"请检查类型是否正确")
				end
			else
				常规提示(id,"请检查类型是否正确")
			end
		end
	end
end
function 装备处理类:发送定制装备(id,级别,种类,名称,生产方式,制造者,是否鉴定,专用,无级别,对方id,倍率,特技,双加,套装类型,套装效果) --真正的强化打造公式

	local dz = self:装备万能公式(级别,种类,生产方式,专用,对方id,倍率,制造者)
	local 道具 = 物品类()
	道具:置对象(名称,nil,nil,级别)
	道具.级别限制 = 级别
	if 种类 ~= nil then
		道具.子类= 种类+0
	end
	if dz[1] ~= nil then
		道具.命中 = dz[1] * 倍率
	end
	if dz[2] ~= nil then
		道具.伤害 = dz[2] * 倍率
	end
	if dz[3] ~= nil then
		道具.防御 = dz[3] * 倍率
	end
	if dz[4] ~= nil then
		道具.魔法 = dz[4] * 倍率
	end
	if dz[5] ~= nil then
		道具.灵力 = dz[5] * 倍率
	end
	if dz[6] ~= nil then
		道具.气血 = dz[6] * 倍率
	end
	if dz[7] ~= nil and dz[7]~=0 then
		道具.敏捷 = dz[7]
	end
	if dz[8] ~= nil and dz[8]~=0 then
		道具.体质 = dz[8]
	end
	if dz[9] ~= nil and dz[9]~=0 then
		道具.力量 = dz[9]
	end
	if dz[10] ~= nil and dz[10]~=0 then
		道具.耐力 = dz[10]
	end
	if dz[11] ~= nil and dz[11]~=0 then
		道具.魔力 = dz[11]
	end
	if dz[12] ~= nil then
		道具.特效 = dz[12]
	end
	if dz[13] ~= nil then
		道具.特技 = dz[13]
	end
	if dz[14] ~= nil then
		道具.五行 = dz[14]
	end
	if dz[15] ~= nil then
		道具.耐久 = dz[15]
	end
	if dz[16] ~= nil then
		道具.鉴定 = dz[16]
	end
	if 是否鉴定 then
		道具.鉴定 = true
	end
	if 无级别 ~= nil then
		if 道具.特效~=nil then
			if #道具.特效<3 then
				道具.特效[#道具.特效+1]=无级别
			else
				道具.特效[3]=无级别
			end
		else
			道具.特效={}
			道具.特效[1]=无级别
		end
	end
	if 特技 ~=nil then
		道具.特技=特技
	end

			if 双加 ~=nil then
				local 双加属性 = 分割文本(双加, "@")
				for i=1,#双加属性 do
					if i ~=2 and i~=4 then
							道具[双加属性[i]]=双加属性[i+1]+0
					end
				end
			end

	if 套装类型 ~=nil and 套装效果 ~=nil then
		if 套装类型 == 3 then
		    道具.套装效果={"变身术之",套装效果}
		elseif 套装类型 == 1 then
			道具.套装效果={"追加法术",套装效果}
		elseif 套装类型 == 2 then
			道具.套装效果={"附加状态",套装效果}
		end
	end
	if 专用 ~= nil then
		道具.专用 = 专用
	else
		if 鉴定==nil and 取随机数()<=15 and 道具.级别限制/10>=qz(玩家数据[id].角色.等级/10) then --and 道具.级别限制>=100
			道具.专用提示=true
		end
	end

	道具.生产方式 = 生产方式
	if 生产方式 == "普通打造" then
		道具.制造者 = 制造者
	elseif 生产方式 == "强化打造" then
		道具.制造者 = 制造者
	elseif 生产方式 == "礼包" or 生产方式== "网关发送" then
		道具.制造者 = "网关装备"
	else
		道具.制造者 = "系统产出"
	end
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,道具)
end
function 装备处理类:取分解方法(装备等级,装备分类)
	if 装备分类>=10 then
		if 装备等级==60 then
			return 4,60,{4,1}
		elseif 装备等级==80 then
			return 6,100,{2,2}
		elseif 装备等级==100 then
			return 8,140,{3,2}
		elseif 装备等级==120 then
			return 10,180,{2,3}
		elseif 装备等级==140 then
			return 12,220,{3,3}
		elseif 装备等级==160 then
			return 14,260,{2,4}
		end
	else
		--装备分解所需
		if 装备等级<=80 then
			return 5,90,1 --分解符数量,体力,吸附石数量
		elseif 装备等级<=100 then
			return 6,150,取随机数(3,5)
		elseif 装备等级<=110 then
			return 7,165,取随机数(3,5)
		elseif 装备等级<=120 then
			return 12,180,取随机数(4,6)
		elseif 装备等级<=130 then
			return 16,195,取随机数(5,6)
		elseif 装备等级<=140 then
			return 23,210,取随机数(5,7)
		end
		return 30,225,取随机数(6,8)
	end
end

function 装备处理类:打造判定消耗(物品1,物品2,分类标识,功能标识,id,对方id,工钱)
	local fhz1,fhz2 = 0,0
	if 分类标识 == "打造" then
		if 物品1.名称 == "制造指南书" or 物品1.名称 == "上古锻造图策" or 物品1.名称 == "灵饰指南书"  then
			fhz1,fhz2 = 打造体力消耗(物品1.子类),打造金钱公式(物品1.子类)
		elseif 物品2.名称 == "制造指南书" or 物品2.名称 == "上古锻造图策" or 物品2.名称 == "灵饰指南书"  then
			fhz1,fhz2 = 打造体力消耗(物品2.子类),打造金钱公式(物品2.子类)
		end
	elseif 分类标识 == "合成" then
		if 功能标识 == "宝石" or 功能标识 == "星辉石" then
			if 物品1.级别限制 == 物品2.级别限制 then
				fhz1,fhz2 = 宝石合成体力消耗(物品1.级别限制),宝石合成金钱公式(物品1.级别限制)
			end
		end
	elseif 分类标识 == "修理" then
		fhz1,fhz2 = 修理消耗(物品1.级别限制)
	elseif 分类标识 == "熔炼" then
		if 功能标识 == "熔炼装备" then

		elseif 功能标识 == "还原装备" then
			fhz1,fhz2 = 0,还原消耗(物品1.级别限制)
		end
	end
	if fhz1 ~= 0  then
		if 玩家数据[对方id].角色.体力 >= fhz1 then
			玩家数据[对方id].角色.体力 = 玩家数据[对方id].角色.体力 -fhz1
			体活刷新(id)
		else
			常规提示(id,"#Y/体力不足")
			return false
		end
	end
	if 玩家数据[id].角色.武神坛角色 then return true end
	if fhz2 ~= 0  then
		if 玩家数据[id].角色.银子 >= fhz2 +工钱 then
			玩家数据[id].角色:扣除银子( fhz2 +工钱, 0, 0, 分类标识.."_"..功能标识, true)
			if id ~= 对方id and 工钱 ~= 0 then
				玩家数据[对方id].角色:添加银子(工钱, 分类标识.."_"..功能标识, true)
			end
		else
			常规提示(id,"#Y/银子不足")
			return false
		end
	end
	return true
end

function 装备处理类:取打造方式(特效,等级,id,对方id)
	local 打造方式
	if 特效 <= 18  then
		打造方式 = "打造技巧"
	elseif (特效 == 19 or 特效 == 20 or 特效 == 22 or 特效 == 23)  then
		打造方式 = "裁缝技巧"
	elseif (特效 == 21 or 特效 == 24 or 特效 == 25) then
		打造方式 = "炼金术"
	end

	if 打造方式 ~= nil then
		if 是否需要打造技能 then
			if 玩家数据[对方id].角色:取生活技能等级(打造方式) < 等级 then --测试模式
				常规提示(id,"#Y/"..打造方式.."#Y/技能等级不足")
				return  false
			end
		end
		return true
	elseif 打造方式 == nil then
		常规提示(id,"#Y/请检查物品是否正确")
		return  false
	end
	return  true
end

function 装备处理类:取格子(格子1,格子2,id,任务)
	local 制造格子,精铁格子,元神打造,是否返回 = 0,0,false,false
	if 玩家数据[id].道具.数据[格子1].名称=="制造指南书" and 玩家数据[id].道具.数据[格子2].名称=="百炼精铁" then
		制造格子=格子1
		精铁格子=格子2
	elseif 玩家数据[id].道具.数据[格子2].名称=="制造指南书" and 玩家数据[id].道具.数据[格子1].名称=="百炼精铁" then
		制造格子=格子2
		精铁格子=格子1
	end
	if 玩家数据[id].道具.数据[格子1].总类==204 and 玩家数据[id].道具.数据[格子2].名称=="战魄" then
		制造格子=格子1
		精铁格子=格子2
		元神打造 = true
	elseif 玩家数据[id].道具.数据[格子2].总类==204 and 玩家数据[id].道具.数据[格子1].名称=="战魄" then
		制造格子=格子2
		精铁格子=格子1
		元神打造 = true
	end

	if 制造格子==0 or 精铁格子==0 then
		常规提示(id,"打造装备需要使用书和精铁，你这给我的是啥玩意？？？")
		是否返回 = true
	elseif 玩家数据[id].道具.数据[制造格子].子类+0>玩家数据[id].道具.数据[精铁格子].子类+0 then
		常规提示(id,"你的这块精铁等级太低了，配不上这本制造指南书")
		是否返回 = true
	elseif 玩家数据[id].角色:取任务(任务)~=0 then
		常规提示(id,"你已经有强化打造的任务了，请先完成任务在进行打造")
		是否返回 = true
	end
	return 制造格子,精铁格子,元神打造,是否返回
end

function 装备处理类:装备鉴定处理(连接id,id,装备属性,专用)
	local go = false

		if 装备属性.特效~=nil then
			if #装备属性.特效<3 then
				if 取随机数()<=3 then
					装备属性.特效[#装备属性.特效+1]="无级别限制"
					go=true
					广播消息({内容=format("#S(神器出世)#W玩家：#Y/%s#W鉴定#Y/%s#W的装备时，竟然鉴定出了#G/%s#Y#W特效，新神器就此诞生了吗#45",玩家数据[id].角色.名称,装备属性.制造者,"无级别限制"),频道="xt"})
				end
			end
		else
			if 取随机数()<=5 then
				装备属性.特效={}
				装备属性.特效[1]="无级别限制"
				go=true
				广播消息({内容=format("#S(神器出世)#W玩家：#Y/%s#W鉴定#Y/%s#W的装备时，竟然鉴定出了#G/%s#Y#W特效，新神器就此诞生了吗#45",玩家数据[id].角色.名称,装备属性.制造者,"无级别限制"),频道="xt"})
			end
		end

	if 专用 then --取装备的部位
		装备属性.专用=id
		if 装备属性.分类==2 or 装备属性.分类==3 then --项链，武器
			if 装备属性.分类==2 then --项链
				发送数据(连接id,105,{头像="法系的追求",标题="法系的追求",说明="鉴定一件专用项链"})
				装备属性.灵力=qz(装备属性.灵力*1.2)
				local okk = self.装备数据.项链.基础属性(装备属性.级别限制,装备属性.生产方式)
				if 装备属性.灵力>okk[2] then

					发送数据(连接id,105,{头像="法系的梦想",标题="法系的梦想",说明="大于非专用项链最高灵力的专用项链。"})
				end
			elseif 装备属性.分类==3 then --武器
				发送数据(连接id,105,{头像="物理系的追求",标题="物理系的追求",说明="鉴定一件专用武器"})
				装备属性.命中=qz(装备属性.命中*1.2)
				装备属性.伤害=qz(装备属性.伤害*1.2)
				local ww,okk = self.装备数据.武器.基础属性(装备属性.级别限制,装备属性.生产方式)
				if 装备属性.伤害>okk[2] then
					发送数据(连接id,105,{头像="物理系的梦想",标题="物理系的梦想",说明="大于非专用武器最高伤害的专用武器。"})
				end
			end
		elseif 装备属性.分类==1 then --头盔
			装备属性.防御=qz(装备属性.防御*1.2)
			装备属性.魔法=qz(装备属性.魔法*1.2)
		elseif 装备属性.分类==4 then --衣服
			装备属性.防御=qz(装备属性.防御*1.2)
		elseif 装备属性.分类==5 then --腰带
			装备属性.防御=qz(装备属性.防御*1.2)
			装备属性.气血=qz(装备属性.气血*1.2)
		elseif 装备属性.分类==6 then --鞋子
			装备属性.防御=qz(装备属性.防御*1.2)
			装备属性.敏捷=qz(装备属性.敏捷*1.2)
		end
	end

	if 装备属性.级别限制>=80 then
		local 蓝字数量 = 0
		if 装备属性.特效~=nil then
			蓝字数量=#装备属性.特效
		end
		if 装备属性.特技~=nil then
			蓝字数量=蓝字数量+1
		end

		if 蓝字数量>=2 then
			发送数据(连接id,105,{头像="双蓝字",标题="逆天的双蓝字",说明="鉴定至少80级装备时出现2种特效特技"})
		end
		if 蓝字数量>=3 then
			发送数据(连接id,105,{头像="三蓝字",标题="三蓝字我眼花了",说明="鉴定至少80级装备时出现3种特效特技"})
		end
		if 蓝字数量>=4 then
			发送数据(连接id,105,{头像="四蓝字",标题="居然可以四蓝字",说明="鉴定至少80级装备时出现4种特效特技"})
		end
		--然后提示无级别
		if go then
			发送数据(连接id,105,{头像="通用",标题="牛了！无级别啊",说明="鉴定至少80级装备时出现特效无级别"})
		end
		--然后提示特技
		if 装备属性.特技~=nil then
			发送数据(连接id,105,{头像="特技",标题="我的"..装备属性.特技,说明="鉴定至少80级装备时出现特技"..装备属性.特技})
			广播消息({内容=format("#S(神器出世)#W玩家：#Y/%s#W鉴定#Y/%s#W的装备时，竟然鉴定出了#G/%s#Y#W特技，新神器就此诞生了吗#45",玩家数据[id].角色.名称,装备属性.制造者,装备属性.特技),频道="xt"})
		end
	end
end

function 装备处理类:摊位打造装备(id,数据)
	local 格子1=玩家数据[id].角色.道具[数据.格子[1]]
	local 格子2=玩家数据[id].角色.道具[数据.格子[2]]
	local 对方id=玩家数据[id].给予数据.对方id
	if 玩家数据[对方id]==nil then
		常规提示(id,"对方已经下线，无法购买")
		return
	end
	local 制造格子,精铁格子,元神打造,是否返回= self:取格子(格子1,格子2,id,5)
	if 是否返回 then return end --是否返回是任务5 物品等级判断

	local 制造类型=玩家数据[id].给予数据.制造数据.名称
	if 制造类型 ~= "打造" and 制造类型 ~= "裁缝" and 制造类型 ~= "炼金" then
		常规提示(id,"制造类型，请重新操作")
		return
	end
	local 打造方式
	local 特效=玩家数据[id].道具.数据[制造格子].特效
	if 元神打造 then
		特效=玩家数据[id].道具.数据[制造格子].元身序列
	end
	if 特效 <= 18  then
		打造方式 = "打造技巧"
	elseif (特效 == 19 or 特效 == 20 or 特效 == 22 or 特效 == 23)  then
		打造方式 = "裁缝技巧"
	elseif (特效 == 21 or 特效 == 24 or 特效 == 25) then
		打造方式 = "炼金术"
	end

	if 打造方式~=nil then
		if 打造方式=="打造技巧" and 制造类型 ~= "打造" then
			常规提示(id,"你是不是选错打造类型了？打造此类型道具请购买打造技巧")
			return
		elseif 打造方式=="裁缝技巧" and 制造类型 ~= "裁缝" then
			常规提示(id,"你是不是选错打造类型了？打造此类型道具请购买裁缝技巧")
			return
		elseif 打造方式=="炼金术" and 制造类型 ~= "炼金" then
			常规提示(id,"你是不是选错打造类型了？打造此类型道具请购买炼金技巧")
			return
		end
	else
		常规提示(id,"请检查类型是否正确")
		return
	end
	local lv=160
	if not 元神打造 then
		lv=玩家数据[id].道具.数据[制造格子].子类
	end
	if lv > 玩家数据[id].给予数据.制造数据.等级 then
		常规提示(id,"你选择的打造等级不得低于书铁等级")
		return
	end
	local 打造费用 = 玩家数据[id].给予数据.制造数据.价格
	if 玩家数据[id].角色.银子 < 打造费用 then
		常规提示(id,"你没有这么多的银两支付打造费用")
		return
	elseif 玩家数据[对方id].角色.体力 < 20 then--玩家数据[id].道具.数据[制造格子].子类 then
		常规提示(id,"对方的体力好像不够了,请等会再来吧")
		return
	end
	local 是否强化=false
	if 玩家数据[id].给予数据.制造数据.是否强化 and 玩家数据[id].给予数据.制造数据.是否强化==2 then
		是否强化=true
	end
	----------------------------------------------打造开始
	if not 元神打造 then
		local 临时序列=玩家数据[id].道具.数据[制造格子].特效
		if 临时序列==25 then
			临时序列=23
		elseif 临时序列==24 then
			临时序列=22
		elseif 临时序列==23 or 临时序列==22 then
			临时序列=21
		elseif 临时序列==21 then
			临时序列=20
		elseif 临时序列==20 or 临时序列==19 then
			临时序列=19
		end
		local 临时等级=玩家数据[id].道具.数据[制造格子].子类/10
		-- 计算武器值
		if 临时序列<=18 and 临时等级>=9 then --是武器 10-12是普通光武
			if 临时等级<12 then
				临时等级=取随机数(10,12)
			elseif 临时等级<15 then
				临时等级=取随机数(13,15)            --do
			else
				临时等级=临时等级+1
			end
		end
		local 临时类型=self.打造物品[临时序列][临时等级]
		if 临时序列>=19 then
			临时类型=self.打造物品[临时序列][临时等级+1]
		end
		if type(临时类型)=="table" then
			if 玩家数据[id].道具.数据[制造格子].特效 ==23 then
				临时类型=临时类型[2]
			elseif 玩家数据[id].道具.数据[制造格子].特效 ==22 then
				临时类型=临时类型[1]
			elseif 玩家数据[id].道具.数据[制造格子].特效 ==20 then
				临时类型=临时类型[2]
			elseif 玩家数据[id].道具.数据[制造格子].特效 ==19 then
				临时类型=临时类型[1]
			else
				临时类型=临时类型[取随机数(1,2)]
			end
		end
		if 是否强化 then
			打造150装备(id,临时类型,玩家数据[id].道具.数据[制造格子].子类,临时序列,对方id,"摊位打造")
		else
			self:生成打造装备(id,玩家数据[id].道具.数据[制造格子].子类,临时序列,临时类型,"普通打造",玩家数据[对方id].角色.名称.."打造")
		end
		玩家数据[id].道具.数据[制造格子]=nil
		玩家数据[id].道具.数据[精铁格子]=nil
		玩家数据[id].角色.道具[数据.格子[1]]=nil
		玩家数据[id].角色.道具[数据.格子[2]]=nil

		常规提示(对方id,"你的打造熟练度增加"..临时等级)
		if 打造方式=="打造技巧" then
			玩家数据[对方id].角色:增加生活技能熟练("打造技巧",临时等级)
		else
			玩家数据[对方id].角色:增加生活技能熟练("裁缝技巧",临时等级)
		end
		道具刷新(id)
	else --元身打造
		local xl = self:取元身序列(玩家数据[id].道具.数据[制造格子].名称)
		local mc = self:取160名称(xl)
		玩家数据[id].道具.数据[制造格子].制造者 = 玩家数据[对方id].角色.名称.."强化打造"
		打造160装备(id,mc,玩家数据[id].道具.数据[制造格子],对方id,"摊位打造")
		玩家数据[id].道具.数据[制造格子]=nil
		玩家数据[id].道具.数据[精铁格子]=nil
		玩家数据[id].角色.道具[数据.格子[1]]=nil
		玩家数据[id].角色.道具[数据.格子[2]]=nil
		道具刷新(id)
		if 打造方式=="打造技巧" then
			玩家数据[对方id].角色:增加生活技能熟练("打造技巧",16)
		else
			玩家数据[对方id].角色:增加生活技能熟练("裁缝技巧",16)
		end
		常规提示(对方id,"你的打造熟练度增加16")
	end
	玩家数据[id].角色:扣除银子(打造费用,0,0,"购买摊位打造",1)
	玩家数据[对方id].角色:添加银子(打造费用,"出售摊位打造",1)
	玩家数据[对方id].角色.体力 = 玩家数据[对方id].角色.体力 -20 --玩家数据[id].道具.数据[制造格子].子类
	体活刷新(对方id)
end

function 装备处理类:添加强化打造装备(id,任务id)
	local 对方id=id
	if 任务数据[任务id].对方id then
		对方id=任务数据[任务id].对方id
	end
	self:生成打造装备(id,任务数据[任务id].级别,任务数据[任务id].序列,任务数据[任务id].名称,"强化打造",任务数据[任务id].制造者,nil,nil,nil,对方id)
	玩家数据[id].角色:取消任务(任务id)
	任务数据[任务id]=nil
end

function 装备处理类:生成固定属性装备(id,级别,种类,名称,生产方式,制造者,是否鉴定,专用,无级别,对方id) --武神坛专用礼包
	local dz
	if 无级别 ~= nil then
	 dz = self:装备固定公式(级别,种类,生产方式,专用,对方id,"双加")
	else
	 dz = self:装备固定公式(级别,种类,生产方式,专用,对方id)
	end
	local 道具 = 物品类()
	道具:置对象(名称,nil,nil,级别)
	道具.级别限制 = 级别
	if 种类 ~= nil then
		道具.子类= 种类+0
	end
	if dz[1] ~= nil then
		道具.命中 = dz[1]
	end
	if dz[2] ~= nil then
		道具.伤害 = dz[2]
	end
	if dz[3] ~= nil then
		道具.防御 = dz[3]
	end
	if dz[4] ~= nil then
		道具.魔法 = dz[4]
	end
	if dz[5] ~= nil then
		道具.灵力 = dz[5]
	end
	if dz[6] ~= nil then
		道具.气血 = dz[6]
	end
	if dz[7] ~= nil and dz[7]~=0 then
		道具.敏捷 = dz[7]
	end
	if dz[8] ~= nil and dz[8]~=0 then
		道具.体质 = dz[8]
	end
	if dz[9] ~= nil and dz[9]~=0 then
		道具.力量 = dz[9]
	end
	if dz[10] ~= nil and dz[10]~=0 then
		道具.耐力 = dz[10]
	end
	if dz[11] ~= nil and dz[11]~=0 then
		道具.魔力 = dz[11]
	end
	if dz[12] ~= nil then
		道具.特效 = dz[12]
	end
	if dz[13] ~= nil then
		道具.特技 = dz[13]
	end
	if dz[14] ~= nil then
		道具.五行 = dz[14]
	end
	if dz[15] ~= nil then
		道具.耐久 = dz[15]
	end
	if dz[16] ~= nil then
		道具.鉴定 = dz[16]
	end
	if 是否鉴定 then
		道具.鉴定 = true
	end
	if 无级别 ~= nil then
		if 道具.特效~=nil then
			if #道具.特效<3 then
				道具.特效[#道具.特效+1]="无级别限制"
			else
				道具.特效[3]="无级别限制"
			end
		else
			道具.特效={}
			道具.特效[1]="无级别限制"
		end
	end
	if 专用 ~= nil then
		道具.专用 = 专用
	else
		if 鉴定==nil and 取随机数()<=15 and 道具.级别限制/10>=qz(玩家数据[id].角色.等级/10) then --and 道具.级别限制>=100
			道具.专用提示=true
		end
	end

	道具.生产方式 = 生产方式
	if 生产方式 == "普通打造" then
		道具.制造者 = 制造者
	elseif 生产方式 == "强化打造" then
		道具.制造者 = 制造者
	end
	if 玩家数据[id].角色.武神坛角色 then --武神坛
		道具.专用 = id
		道具.不可交易 = true
	end
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,道具)
end
function 装备处理类:生成打造装备(id,级别,种类,名称,生产方式,制造者,是否鉴定,专用,无级别,对方id) --真正的强化打造公式
	local dz
	if 无级别 ~= nil then
	 dz = self:装备万能公式(级别,种类,生产方式,专用,对方id,"双加")
	else
	 dz = self:装备万能公式(级别,种类,生产方式,专用,对方id)
	end
	local 道具 = 物品类()
	道具:置对象(名称,nil,nil,级别)
	道具.级别限制 = 级别

	if 种类 ~= nil then
		道具.子类= 种类+0
	end
	if dz[1] ~= nil then
		道具.命中 = dz[1]
	end
	if dz[2] ~= nil then
		道具.伤害 = dz[2]
	end
	if dz[3] ~= nil then
		道具.防御 = dz[3]
	end
	if dz[4] ~= nil then
		道具.魔法 = dz[4]
	end
	if dz[5] ~= nil then
		道具.灵力 = dz[5]
	end
	if dz[6] ~= nil then
		道具.气血 = dz[6]
	end
	if dz[7] ~= nil and dz[7]~=0 then
		道具.敏捷 = dz[7]
	end
	if dz[8] ~= nil and dz[8]~=0 then
		道具.体质 = dz[8]
	end
	if dz[9] ~= nil and dz[9]~=0 then
		道具.力量 = dz[9]
	end
	if dz[10] ~= nil and dz[10]~=0 then
		道具.耐力 = dz[10]
	end
	if dz[11] ~= nil and dz[11]~=0 then
		道具.魔力 = dz[11]
	end
	if dz[12] ~= nil then
		道具.特效 = dz[12]
	end
	if dz[13] ~= nil then
		道具.特技 = dz[13]
	end
	if dz[14] ~= nil then
		道具.五行 = dz[14]
	end
	if dz[15] ~= nil then
		道具.耐久 = dz[15]
	end
	if dz[16] ~= nil then
		道具.鉴定 = dz[16]
	end
	if 是否鉴定 then
		道具.鉴定 = true
	end
	if 无级别 ~= nil then
		if 道具.特效~=nil then
			if #道具.特效<3 then
				道具.特效[#道具.特效+1]="无级别限制"
			else
				道具.特效[3]="无级别限制"
			end
		else
			道具.特效={}
			道具.特效[1]="无级别限制"
		end
	end
	if 专用 ~= nil then
		道具.专用 = 专用
	else
		if 鉴定==nil and 取随机数()<=15 and 道具.级别限制/10>=qz(玩家数据[id].角色.等级/10) then --and 道具.级别限制>=100
			道具.专用提示=true
		end
	end

	道具.生产方式 = 生产方式
	if 生产方式 == "普通打造" then
		道具.制造者 = 制造者
	elseif 生产方式 == "强化打造" then
		道具.制造者 = 制造者
	end
	if 玩家数据[id].角色.武神坛角色 then --武神坛
		道具.专用 = id
		道具.不可交易 = true
	end
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,道具)
end





function 装备处理类:生成打造装备假人(id,级别,种类,名称,生产方式,制造者,是否鉴定,专用,无级别,对方id,返回) --真正的强化打造公式
	-- (id,等级*10,武器序列,武器名称,"系统产出",nil,true,id,无级别)
	local dz = self:装备万能公式(级别,种类,生产方式,专用,对方id)
	local 道具 = 物品类()
	道具:置对象(名称,nil,nil,级别)
	道具.级别限制 = 级别
	if 种类 ~= nil then
		道具.子类= 种类+0
	end
	if dz[1] ~= nil then
		道具.命中 = dz[1]
	end
	if dz[2] ~= nil then
		道具.伤害 = dz[2]
	end
	if dz[3] ~= nil then
		道具.防御 = dz[3]
	end
	if dz[4] ~= nil then
		道具.魔法 = dz[4]
	end
	if dz[5] ~= nil then
		道具.灵力 = dz[5]
	end
	if dz[6] ~= nil then
		道具.气血 = dz[6]
	end
	if dz[7] ~= nil and dz[7]~=0 then
		道具.敏捷 = dz[7]
	end
	if dz[8] ~= nil and dz[8]~=0 then
		道具.体质 = dz[8]
	end
	if dz[9] ~= nil and dz[9]~=0 then
		道具.力量 = dz[9]
	end
	if dz[10] ~= nil and dz[10]~=0 then
		道具.耐力 = dz[10]
	end
	if dz[11] ~= nil and dz[11]~=0 then
		道具.魔力 = dz[11]
	end
	if dz[12] ~= nil then
		道具.特效 = dz[12]
	end
	if dz[13] ~= nil then
		道具.特技 = dz[13]
	end
	if dz[14] ~= nil then
		道具.五行 = dz[14]
	end
	if dz[15] ~= nil then
		道具.耐久 = dz[15]
	end
	if dz[16] ~= nil then
		道具.鉴定 = dz[16]
	end
	if 是否鉴定 then
		道具.鉴定 = true
	end
	if 无级别 ~= nil then
		if 道具.特效~=nil then
			if #道具.特效<3 then
				道具.特效[#道具.特效+1]="无级别限制"
			else
				道具.特效[3]="无级别限制"
			end
		else
			道具.特效={}
			道具.特效[1]="无级别限制"
		end
	end
	if 专用 ~= nil then
		道具.专用 = 专用
	else
		if 鉴定==nil and 取随机数()<=15 and 道具.级别限制/10>=qz(玩家数据[id].角色.等级/10) then --and 道具.级别限制>=100
			道具.专用提示=true
		end
	end
	-- if 限用时间 ~= nil then
	-- 	道具.限时= 限用时间
	-- end
	道具.生产方式 = 生产方式
	if 生产方式 == "普通打造" then
		道具.制造者 = 制造者
	elseif 生产方式 == "强化打造" then
		道具.制造者 = 制造者
	end
	if 返回 then
		return 道具
	else
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,道具)
	end
end


function 装备处理类:生成环装(id,级别,种类,名称,生产方式) --真正的强化打造公式
	local dz = self:装备万能公式(级别,种类,生产方式,专用,对方id)
	local 道具 = 物品类()
	道具:置对象(名称,nil,nil,级别)
	道具.级别限制 = 级别
	if 种类 ~= nil then
		道具.子类= 种类+0
	end
	if dz[1] ~= nil then
		道具.命中 = dz[1]
	end
	if dz[2] ~= nil then
		道具.伤害 = dz[2]
	end
	if dz[3] ~= nil then
		道具.防御 = dz[3]
	end
	if dz[4] ~= nil then
		道具.魔法 = dz[4]
	end
	if dz[5] ~= nil then
		道具.灵力 = dz[5]
	end
	if dz[6] ~= nil then
		道具.气血 = dz[6]
	end
	if dz[7] ~= nil and dz[7]~=0 then
		道具.敏捷 = dz[7]
	end
	if dz[8] ~= nil and dz[8]~=0 then
		道具.体质 = dz[8]
	end
	if dz[9] ~= nil and dz[9]~=0 then
		道具.力量 = dz[9]
	end
	if dz[10] ~= nil and dz[10]~=0 then
		道具.耐力 = dz[10]
	end
	if dz[11] ~= nil and dz[11]~=0 then
		道具.魔力 = dz[11]
	end
	if dz[12] ~= nil then
		道具.特效 = dz[12]
	end
	if dz[13] ~= nil then
		道具.特技 = dz[13]
	end
	if dz[14] ~= nil then
		道具.五行 = dz[14]
	end
	if dz[15] ~= nil then
		道具.耐久 = dz[15]
	end
	if dz[16] ~= nil then
		道具.鉴定 = dz[16]
	end
	道具.生产方式 = 生产方式
	return 道具
end

function 装备处理类:装备固定公式(a,b,生产方式,专用,对方id,双加) -- 武神坛160用无级别礼包，非打造公式
	local 附加属性 = false
	local c = {} -- 命中 伤害 防御 魔法 灵力 气血 敏捷 体质 力量 耐力 魔力 附加特效 附加特技 五行 耐久 鉴定
	if a == nil or b == nil then
		return false
	end
	local 通用特效 = {}
	local shangxian=取随机数(90,100)*0.01
	if b < 19 then -- 武器
		local 命中,伤害=self.装备数据.武器.基础属性(a,生产方式)
		c[1] = 854
		c[2] = 733
		附加属性 = true
		通用特效 = {"珍宝","简易","神佑","必中","绝杀","坚固","精致","永不磨损","易修理"}
	elseif b == 19 then -- 帽子
		local 防御,魔法=self.装备数据.头盔.基础属性(a,生产方式)
		c[3] = 126
		c[4] = 246
		通用特效 = {"珍宝","简易","再生","坚固","精致","永不磨损","易修理"}
	elseif b == 20 then -- 项链
		local 灵力=self.装备数据.项链.基础属性(a,生产方式)
		c[5] = 310
		通用特效 = {"珍宝","简易","神农","专注","坚固","精致","永不磨损","易修理"}
	elseif b == 21 then -- 衣服
		local 防御=self.装备数据.衣服.基础属性(a,生产方式)
		c[3] = 374
		附加属性 = true
		通用特效 = {"珍宝","简易","坚固","精致","永不磨损","易修理","伪装"}
	elseif b == 22 then -- 腰带
		local 防御,气血=self.装备数据.腰带.基础属性(a,生产方式)
		c[3] = 126
		if a >0 then
			c[6] = 494
		end
		通用特效 = {"珍宝","简易","坚固","精致","永不磨损","易修理","愤怒","暴怒"}
	elseif b == 23 then -- 鞋子
		local 防御,敏捷=self.装备数据.鞋子.基础属性(a,生产方式)
		c[3] = 126
		c[7] = 77
		通用特效 = {"珍宝","简易","坚固","精致","狩猎","迷踪","永不磨损","易修理"}
	end
	local tx = 取随机数()
	if tx <= 5 then
		local txb = {}
		local sj = random(1,#通用特效)
		txb[#txb+1]=通用特效[sj]
		table.remove(通用特效,sj)
		for i=1,2 do
			if 取随机数()<=5 then
				sj = random(1,#通用特效)
				txb[#txb+1]=通用特效[sj]
				table.remove(通用特效, sj)
			end
		end
		c[12] = txb
	end
	local tj = 取随机数()
	if tj <= 4 then
		local tytx ={"弱点击破","破血狂攻","心疗术","破碎无双","诅咒之伤","太极护法","罗汉金钟","慈航普度","放下屠刀","笑里藏刀","碎甲术","金刚怒目","命归术","心如明镜","气归术","凝气诀","凝神诀","命疗术","流云诀","啸风诀","河东狮吼","破甲术","凝滞术","吸血特技","金刚不坏","菩提心佑","起死回生","回魂咒","气疗术","野兽之力","魔兽之印","修罗咒","身似菩提","光辉之甲","圣灵之甲","四海升平","水清诀","玉清诀","冰清诀","晶清诀"}
		c[13] = tytx[random(1,#tytx)]
	end
	local 熟练度 = 10
	local gl=取随机数(1,5,10)
	local ab=0
	local 双加数值=0
	local 双加数值1=0
	if 双加 ~=nil then
		gl=101
		ab=100
		生产方式="礼包"
		if a == 160 then
			双加数值=50
			双加数值1=60
		end
	end
	if 附加属性  then
		local sx = {7,8,9,10,11}
			local fhz = 取随机数(1,#sx)
			local sx1 = sx[fhz]
			table.remove(sx,fhz)
			fhz = 取随机数(1,#sx)
			local sx2 = sx[fhz]
			if 双加数值~=0 then
				c[sx1] =50
				c[sx2] =50
			else
				c[sx1] = 50
				c[sx2] = 50
			end
	end
	c[14] =取五行()
	c[15] =取随机数(500,700)
	c[16] =false
	return c
end

function 装备处理类:装备万能公式(a,b,生产方式,专用,对方id,双加) -- 制作书等级 制作种类  --真正的强化打造公式
	local 附加属性 = false
	local c = {} -- 命中 伤害 防御 魔法 灵力 气血 敏捷 体质 力量 耐力 魔力 附加特效 附加特技 五行 耐久 鉴定
	if a == nil or b == nil then
		return false
	end
	local 通用特效 = {}
	local shangxian=取随机数(90,100)*0.01

	if b < 19 then -- 武器
		local 命中,伤害=self.装备数据.武器.基础属性(a,生产方式)
		c[1] = 取随机数(命中[1],命中[2]*shangxian)--qz(命中[2]*0.8)
		c[2] = 取随机数(伤害[1],伤害[2]*shangxian)--qz(伤害[2]*0.8)
		附加属性 = true
		通用特效 = {"珍宝","简易","神佑","必中","绝杀","坚固","精致","永不磨损","易修理"}
	elseif b == 19 then -- 帽子
		local 防御,魔法=self.装备数据.头盔.基础属性(a,生产方式)
		c[3] = 取随机数(防御[1],防御[2]*shangxian)--qz(防御[2]*0.8)--取随机数(防御[1],防御[2])--
		c[4] = 取随机数(魔法[1],魔法[2]*shangxian)--+100000
		通用特效 = {"珍宝","简易","再生","坚固","精致","永不磨损","易修理"}
	elseif b == 20 then -- 项链
		local 灵力=self.装备数据.项链.基础属性(a,生产方式)
		c[5] = 取随机数(灵力[1],灵力[2]*shangxian)--qz(灵力[2]*0.8)--取随机数(灵力[1],灵力[2])--
		通用特效 = {"珍宝","简易","神农","专注","坚固","精致","永不磨损","易修理"}
	elseif b == 21 then -- 衣服
		local 防御=self.装备数据.衣服.基础属性(a,生产方式)
		c[3] = 取随机数(防御[1],防御[2]*shangxian)--qz(防御[2]*0.8)--取随机数(防御[1],防御[2])--
		附加属性 = true
		通用特效 = {"珍宝","简易","坚固","精致","永不磨损","易修理","伪装"}
	elseif b == 22 then -- 腰带
		local 防御,气血=self.装备数据.腰带.基础属性(a,生产方式)
		c[3] = 取随机数(防御[1],防御[2]*shangxian)--qz(防御[2]*0.8)--取随机数(防御[1],防御[2])--
		if a >0 then
			c[6] = 取随机数(气血[1],气血[2]*shangxian)--qz(气血[2]*0.8)+100000--取随机数(气血[1],气血[2])--
		end
		通用特效 = {"珍宝","简易","坚固","精致","永不磨损","易修理","愤怒","暴怒"}
	elseif b == 23 then -- 鞋子
		local 防御,敏捷=self.装备数据.鞋子.基础属性(a,生产方式)
		c[3] = 取随机数(防御[1],防御[2]*shangxian)--qz(防御[2]*0.8)--取随机数(防御[1],防御[2])--
		c[7] = 取随机数(敏捷[1],敏捷[2]*shangxian)--qz(敏捷[2]*0.8)--取随机数(敏捷[1],敏捷[2])--
		通用特效 = {"珍宝","简易","坚固","精致","狩猎","迷踪","永不磨损","易修理"}
	end
	local tx = 取随机数()
	if tx <= 5 then
		local txb = {}
		local sj = random(1,#通用特效)
		txb[#txb+1]=通用特效[sj]
		table.remove(通用特效,sj)
		for i=1,2 do
			if 取随机数()<=5 then --
				sj = random(1,#通用特效)
				txb[#txb+1]=通用特效[sj]
				table.remove(通用特效, sj)
			end
		end
		c[12] = txb
	end
	local tj = 取随机数()
	if tj <= 10 then -- ,"琴音三叠"
		local tytx ={"琴音三叠","弱点击破","破血狂攻","心疗术","破碎无双","诅咒之伤","太极护法","罗汉金钟","慈航普度","放下屠刀","笑里藏刀","碎甲术","金刚怒目","命归术","心如明镜","气归术","凝气诀","凝神诀","命疗术","流云诀","啸风诀","河东狮吼","破甲术","凝滞术","吸血特技","金刚不坏","菩提心佑","起死回生","回魂咒","气疗术","野兽之力","魔兽之印","修罗咒","身似菩提","光辉之甲","圣灵之甲","四海升平","水清诀","玉清诀","冰清诀","晶清诀"}
		c[13] = tytx[random(1,#tytx)]
	end
	local 熟练度 = 10

	if 对方id and 玩家数据[对方id].角色 then
		熟练度=玩家数据[对方id].角色:取生活技能熟练("打造技巧")
	end
	local gl=取随机数(1,5+math.min(math.ceil(熟练度/100),10)) --最高15，保底5
	local ab=0
	local 双加数值=0
	local 双加数值1=0
	if 双加 ~=nil then
		gl=101
		ab=100
		生产方式="礼包"

		if a == 120 then
			双加数值=math.random(10,40)
			双加数值1=40-双加数值
		elseif a ==140 then
			双加数值=math.random(20,50)
			双加数值1=50-双加数值
		elseif a ==150 then
			双加数值=math.random(30,60)
			双加数值1=60-双加数值
		elseif a ==160 then---------------------不该加
			双加数值=math.random(40,70)
			双加数值1=70-双加数值
		end
	end
	if 附加属性 and a > 0 and 生产方式 ~="系统产出" and 取随机数() < gl then
		local 单加,双加=取单双加属性(a)--39,56

		local sx = {7,8,9,10,11}
		if 取随机数()<=60+ab then

			local fhz = 取随机数(1,#sx)
			local sx1 = sx[fhz]

			table.remove(sx,fhz)
			fhz = 取随机数(1,#sx)

			local sx2 = sx[fhz]

			if 双加数值~=0 then--礼包指定双加
				c[sx1] =双加数值
				c[sx2] =双加数值1
			else
				c[sx1] = math.ceil(取随机数(-8,双加)/2)
				c[sx2] = math.ceil(取随机数(-8,双加)/2)
			end--math.ceil(math.random(-8,56)/2)
		else
			local fhz = 取随机数(1,#sx)
			local sx1 = sx[fhz]
			c[sx1] = 取随机数(1,单加)
		end
	end
	c[14] =取五行()
	c[15] =取随机数(500,700)
	c[16] =false
	return c
end

function 装备处理类:野外掉落宝宝装备(id,lv)
	local 类型序列=取随机数(24,26)
	local 临时序列=math.floor(lv/10)
	local 临时名称=self.打造物品[类型序列][临时序列]
	local 道具 = 物品类()
	道具:置对象(临时名称)
	道具.级别限制 = lv
	道具.召唤兽装备 = true
	local 灵气=取随机数(30,60)*0.15
	local 等级=道具.级别限制
	local 等差序列 = math.floor(等级/10)
	if 类型序列==24 then --护腕
		道具.命中=math.floor(取随机数(5,等级*0.1+10))
	elseif 类型序列==25 then --项圈
		道具.速度=math.floor(取随机数(等差序列,等差序列*3+灵气))
	else --铠甲
		道具.防御=math.floor(取随机数(等差序列*5,等差序列*9+灵气))
	end
	local 附加范围={"伤害","灵力","敏捷","耐力","体质","力量","魔力","气血","魔法"}
	for n=1,3 do
		if 取随机数()<=20 then
			local 类型=附加范围[取随机数(1,#附加范围)]
			if 道具[类型]==nil then
				if 类型=="伤害" then
					道具[类型]=math.floor(取随机数(等差序列,等差序列*5+灵气))
					if 取随机数()<=10 then
						道具[类型]=-取随机数(1,15)
					end
				elseif 类型=="气血" then
					道具[类型]=math.floor(取随机数(等差序列*4,等差序列*8+灵气))
					if 取随机数()<=10 then
						道具[类型]=-取随机数(1,100)
					end
				elseif 类型=="魔法" then
					道具[类型]=math.floor(取随机数(等差序列*7,等差序列*12+灵气))
					if 取随机数()<=10 then
						道具[类型]=-取随机数(1,100)
					end
				elseif 类型=="灵力" then
					道具[类型]=math.floor(取随机数(等差序列,等差序列*2))
					if 取随机数()<=10 then
						道具[类型]=-取随机数(1,15)
					end
				elseif 类型=="力量" then
					道具[类型]=math.floor(取随机数(等差序列,等差序列*3))
					if 取随机数()<=10 then
						道具[类型]=-取随机数(1,15)
					end
				elseif 类型=="敏捷" or 类型=="体质" or 类型=="耐力" or 类型=="魔力"  then
					道具[类型]=math.floor(取随机数(等差序列,等差序列*2))
					if 取随机数()<=10 then
						道具[类型]=-取随机数(1,15)
					end
				end
			end
		end
	end
	玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,道具)
end

function 装备处理类:幻化公式(制造种类) -- 制作书等级 制作种类
	local fhz = {} -- 命中 伤害 防御 魔法 灵力 气血 敏捷 体质 力量 耐力 魔力 附加特效 附加特技
	if 制造种类 == nil then
		return false
	end
	local SX=1
	if 取随机数()<=70 then
		SX=0.95
	end
	if 制造种类 < 19 then -- 武器计算方式=元身属性*1.2（强化）*1.2（专用）*SX（0.95-1）
		fhz[1] = 取随机数(529,612*SX)
		fhz[2] = 取随机数(454,526*SX)
		if 取随机数(1,100) <= 4 then
			local 总属性编号 = {7,8,9,10,11} -- 命中 伤害 防御 魔法 灵力 气血 敏捷 体质 力量 耐力 魔力 附加特效 附加特技
			local 随机编号 = 取随机数(1,#总属性编号)
			local x1  = 总属性编号[随机编号]
			remove(总属性编号,随机编号)
			随机编号 = 取随机数(1,#总属性编号)
			local x2  = 总属性编号[随机编号]
			fhz[x1] = 取随机数(-8, 160 * 0.3)
			fhz[x2] = 取随机数(-8, 160 * 0.3)
		elseif 取随机数(1,100) <= 8 then
			local sx = 取随机数(7,11)
			fhz[sx] = 取随机数(-8, 160 * 0.3)
		end
	elseif 制造种类 == 19 or 制造种类 == 20 then -- 帽子
		fhz[3] = 取随机数(78,91*SX)
		fhz[4] = 取随机数(151,177*SX)
	elseif 制造种类 == 21 then -- 项链
		fhz[5] = 取随机数(182,211*SX)
	elseif 制造种类 == 22 or 制造种类 == 23 then -- 衣服
		fhz[3] = 取随机数(231,268*SX)
		if 取随机数(1,100) <= 4 then
			local 总属性编号 = {7,8,9,10,11} -- 命中 伤害 防御 魔法 灵力 气血 敏捷 体质 力量 耐力 魔力 附加特效 附加特技
			local 随机编号 = 取随机数(1,#总属性编号)
			local x1  = 总属性编号[随机编号]
			remove(总属性编号,随机编号)
			随机编号 = 取随机数(1,#总属性编号)
			local x2  = 总属性编号[随机编号]
			fhz[x1] = 取随机数(-8, 160 * 0.3)
			fhz[x2] = 取随机数(-8, 160 * 0.3)
		elseif 取随机数(1,100) <= 8 then
			local sx = 取随机数(7,11)
			fhz[sx] = 取随机数(-8, 160 * 0.3)
		end
	elseif 制造种类 == 24 then -- 腰带
		fhz[3] = 取随机数(78,91*SX)
		fhz[6] = 取随机数(329,354*SX)
	elseif 制造种类 == 25 then -- 鞋子
		fhz[3] = 取随机数(78,91*SX)
		fhz[7] = 取随机数(49,55)
	end
	local 特效 = 取随机数()
	if 特效 <= 5 then
		fhz[12] = 取随机数(1,20)
	end
	local 特技 = 取随机数()
	if 特技 <= 5 then
		fhz[13] = 取随机数(1,20)
	end
	return fhz
end

function 装备处理类:取160装备属性(制造种类,元身属性,id,打造id)
	local 打造属性 = {}
	local 特效 = 取随机数()
	local 特技 = 取随机数()
	local 范围 = {"命中", "伤害", "防御", "魔法", "灵力", "气血", "敏捷", "体质", "力量", "耐力", "魔力", "特效", "特技"}
	if 元身属性==nil then
		常规提示(id,"#Y/数据异常，请与管理员联系！")
		print("元身属性为空")
		return false
	end
	if 制造种类 == nil then
		常规提示(id,"#Y/数据异常……")
		print("元身等级为空或制造种类为空")
		return false
	end
	if 元身属性.特效概率==nil then
		元身属性.特效概率=0
	end
	if 元身属性.特技概率==nil then
		元身属性.特技概率=0
	end
	local 特效概率 = 元身属性.特效概率
	local 特技概率 = 元身属性.特技概率
	local LX = "打造技巧"
	if 制造种类 < 19 then
		LX = "打造技巧"
	elseif 制造种类 == 19 or 制造种类 == 20 or 制造种类 == 22 or 制造种类 == 23  then
		LX = "裁缝技巧"
	elseif 制造种类 ==21 or 制造种类 ==24 or 制造种类 ==25 then
		LX = "炼金术"
	end
	-------这个是 就算是没有双加，也会有概率增加双加，加入熟练度系统
	local SLD=0
	if 打造id~=id and 玩家数据[打造id] then
		SLD=玩家数据[打造id].角色:取生活技能熟练(LX)
	else
		SLD=玩家数据[id].角色:取生活技能熟练(LX)
	end
	SLD=取随机数(1,2+math.min(math.ceil(SLD/100),5)) --最高7，保底2
	local shangxian=1.27
	if 取随机数()<=60 then
		shangxian=1.2
	elseif 取随机数()<=65 then
		shangxian=1.25
	end
	if 制造种类 < 19 then -- 强化打造武器伤害
		打造属性[1] = 取随机数(元身属性.命中*1.2, 元身属性.命中*shangxian)
		打造属性[2] = 取随机数(元身属性.伤害*1.2, 元身属性.伤害*shangxian)-1
		local 属性个数 = 0
		local 选取属性 = 0

		for n=7,11 do --敏捷 体质 力量 耐力 魔力
			if 元身属性[范围[n]]~=nil then
				local 判断字 = 分割文本(元身属性[范围[n]],范围[n])
				if 判断字[1] == "增加" then
					属性个数 = 属性个数 + 1
					打造属性[n] = 取随机数(20, 50)
					选取属性 = n
				else
					属性个数 = 属性个数 + 1
					打造属性[n] = 取随机数(20, 50)
					选取属性 = n
				end
			end
		end
		if 属性个数 == 0 then --这里是就算没有双加，也有概率加上去，根据打造等级来附加
			if 取随机数(1,110) <= SLD then
				if 取随机数()<=40 then
					local 总属性编号 = {7,8,9,10,11} -- 敏捷 体质 力量 耐力 魔力
					local 随机编号 = 取随机数(1,#总属性编号)
					local x1  = 总属性编号[随机编号]
					remove(总属性编号,随机编号)
					随机编号 = 取随机数(1,#总属性编号)
					local x2  = 总属性编号[随机编号]
					打造属性[x1] = 取随机数(20, 50)
					打造属性[x2] = 取随机数(20, 50)
				else
					local sx = 取随机数(7,11)
					打造属性[sx] = 取随机数(20, 50)
				end
			end
		end
	elseif 制造种类 == 19 or 制造种类 == 20 then -- 帽子
		打造属性[3] = 取随机数(元身属性.防御*1.18, 元身属性.防御*shangxian)
		打造属性[4] = 取随机数(元身属性.魔法*1.18, 元身属性.魔法*shangxian)
	elseif 制造种类 == 21 then -- 项链
		打造属性[5] = 取随机数(元身属性.灵力*1.18, 元身属性.灵力*shangxian)
	elseif 制造种类 == 22 or 制造种类 == 23 then -- 衣服
		打造属性[3] = 取随机数(元身属性.防御*1.18, 元身属性.防御*shangxian)
		local 属性个数 = 0
		local 选取属性 = 0
		for n=7,11 do
			if 元身属性[范围[n]]~=nil then
				local 判断字 = 分割文本(元身属性[范围[n]],范围[n])
				if 判断字[1] == "增加" then
					属性个数 = 属性个数 + 1
					打造属性[n] = 取随机数(20, 50)
					选取属性 = n
				else
					属性个数 = 属性个数 + 1
					打造属性[n] = 取随机数(20, 50)
					选取属性 = n
				end
			end
		end
		if 属性个数 == 0 then --这里是就算没有双加，也有概率加上去，根据打造等级来附加
			if 取随机数(10,110) <= SLD then
				if 取随机数()<=40 then
					local 总属性编号 = {7,8,9,10,11} -- 敏捷 体质 力量 耐力 魔力
					local 随机编号 = 取随机数(1,#总属性编号)
					local x1  = 总属性编号[随机编号]
					remove(总属性编号,随机编号)
					随机编号 = 取随机数(1,#总属性编号)
					local x2  = 总属性编号[随机编号]
					打造属性[x1] = 取随机数(20, 50)
					打造属性[x2] = 取随机数(20, 50)
				else
					local sx = 取随机数(7,11)
					打造属性[sx] = 取随机数(20, 50)
				end
			end
		end
	elseif 制造种类 == 24 then -- 腰带
		打造属性[3] = 取随机数(元身属性.防御*1.2, 元身属性.防御*shangxian)
		打造属性[6] = 取随机数(元身属性.气血*1.2, 元身属性.气血*shangxian)
	elseif 制造种类 == 25 then -- 鞋子
		打造属性[3] = 取随机数(元身属性.防御*1.2, 元身属性.防御*shangxian)
		打造属性[7] = 取随机数(元身属性.敏捷*1.2, 元身属性.敏捷*shangxian)+1
	end
	if 特效 <= qz(SLD/2)+特效概率 then --最高3+特效概率
		打造属性[12] = 1
	end
	if 特技 <= qz(SLD/2)+特技概率 then --最高3+特技概率
		打造属性[13] = 1
	end
	return 打造属性
end

function 装备处理类:打造160神兵(id,任务id)
	local 属性=任务数据[任务id].元身属性.幻化元身属性
	local 装备名称=任务数据[任务id].名称
	local xl=任务数据[任务id].元身属性.元身序列
	local 装备 = 物品类()
	装备:置对象(装备名称)
	装备.级别限制 = 任务数据[任务id].级别
	装备.元身序列 = xl
	local dz = self:取160装备属性(xl,任务数据[任务id].元身属性.幻化元身属性,id,任务数据[任务id].打造id)
	local 属性 = {"命中", "伤害", "防御", "魔法", "灵力", "气血", "敏捷", "体质", "力量", "耐力", "魔力", "特效", "特技"}
	local tytx ={"弱点击破","破血狂攻","心疗术","破碎无双","诅咒之伤","太极护法","罗汉金钟","慈航普度","放下屠刀","笑里藏刀","碎甲术","金刚怒目","命归术","心如明镜","气归术",
	"凝气诀","凝神诀","命疗术","流云诀","啸风诀","河东狮吼","破甲术","凝滞术","吸血特技","金刚不坏","菩提心佑","起死回生","回魂咒","气疗术","野兽之力","魔兽之印","修罗咒",
	"身似菩提","光辉之甲","圣灵之甲","四海升平","水清诀","玉清诀","冰清诀","晶清诀","琴音三叠"}
	local 新特效 = {"物理暴击几率","法术暴击几率","物理暴击伤害","法术暴击伤害","治疗能力","封印命中率","抵抗封印命中率","穿刺效果","格挡物理伤害","法术伤害减免","魔法回复效果"}
	local 打造特效 = {}
	if xl < 19 then -- 武器
		打造特效 = {"简易","神佑","必中","绝杀","精致","永不磨损","易修理"}
	elseif xl == 19 then -- 帽子
		打造特效 = {"珍宝","简易","再生","坚固","精致","永不磨损","易修理"}
	elseif xl == 20 then -- 项链
		打造特效 = {"珍宝","简易","神农","专注","坚固","精致","永不磨损","易修理"}
	elseif xl == 21 then -- 衣服
		打造特效 = {"珍宝","简易","坚固","精致","永不磨损","易修理","伪装"}
	elseif xl == 22 then -- 腰带
		打造特效 = {"珍宝","简易","坚固","精致","永不磨损","易修理","愤怒","暴怒"}
	elseif xl == 23 then -- 鞋子
		打造特效 = {"珍宝","简易","坚固","精致","狩猎","迷踪","永不磨损","易修理"}
	end
	-- 新特效="物理暴击几率",新特效数值=0.1
	for n = 1, #属性 do
		if dz[n] ~= nil then
			if n == 12 then --特效
				if 取随机数(5,101) <= 10 then --双特效
					装备.特效={}
					装备.特效[1] = 打造特效[random(1,#打造特效)]
					装备.新特效 = 新特效[random(1,#新特效)]
					if 装备.新特效 == "魔法回复效果" then
						装备.新特效数值 = random(16,30)
					elseif 装备.新特效 == "格挡物理伤害" then
						装备.新特效数值 = random(40,50)
					elseif 装备.新特效 == "治疗能力" then
						装备.新特效数值 = random(10,25)
					else
						装备.新特效数值 = string.format("%.2f",random(80,300)/50)
					end
				else
					if 取随机数() <= 50 then
						local txb = {}
						local sj = random(1,#打造特效)
						txb[#txb+1]=打造特效[sj]
						table.remove(打造特效,sj)
						for i=1,2 do
							if 取随机数()<=5 then --
								sj = random(1,#打造特效)
								txb[#txb+1]=打造特效[sj]
								table.remove(打造特效, sj)
							end
						end
						装备.特效 = txb
					else
						装备.新特效 = 新特效[random(1,#新特效)]
						if 装备.新特效 == "魔法回复效果" then
							装备.新特效数值 = random(16,30)
						elseif 装备.新特效 == "格挡物理伤害" then
							装备.新特效数值 = random(40,50)
						elseif 装备.新特效 == "治疗能力" then
							装备.新特效数值 = random(10,25)
						else
							装备.新特效数值 = string.format("%.2f",random(80,300)/50)
						end
					end
				end
			elseif n == 13 then
				装备.特技 = tytx[random(1,#tytx)]
			else
				if dz[n] ~= 0 then
					装备[属性[n]] = math.floor(dz[n])
				end
			end
		end
	end
	装备.制造者 = 任务数据[任务id].元身属性.制造者
	装备.生产方式 = "强化打造"
	if 取随机数()<=15 then
		装备.专用提示=true
	end
	local gz = 玩家数据[id].道具:取新编号()
	玩家数据[id].道具.数据[gz] = 装备
	玩家数据[id].道具.数据[gz].五行 = 取五行()
	玩家数据[id].道具.数据[gz].耐久 = 取随机数(500,700)
	玩家数据[id].道具.数据[gz].识别码 = id.."_"..os.time().."_"..取随机数(1000,9999).."_"..随机序列
	随机序列=随机序列 + 1
	玩家数据[id].角色.道具[玩家数据[id].角色:取道具格子()] = gz
	玩家数据[id].道具.数据[gz].鉴定 = false
	if 玩家数据[id].角色.武神坛角色 then --武神坛
		玩家数据[id].道具.数据[gz].专用 = id
		玩家数据[id].道具.数据[gz].不可交易 = true
	end
	玩家数据[id].角色:取消任务(任务id)
	任务数据[任务id]=nil
	常规提示(id,"#Y/你得到了#G/"..玩家数据[id].道具.数据[gz].名称)
	道具刷新(id)
end

local function 获取幻化概率(次数)
	if 次数 <= 10 then
		return 100
	elseif 次数 <= 20 then
		return 95
	elseif 次数 <= 30 then
		return 90
	elseif 次数 <= 40 then
		return 85
	elseif 次数 <= 50 then
		return 80
	elseif 次数 <= 60 then
		return 75
	elseif 次数 <= 70 then
		return 70
	elseif 次数 <= 80 then
		return 65
	elseif 次数 <= 90 then
		return 60
	elseif 次数 <= 100 then
		return 55
	else
		return 50
	end
end

function 装备处理类:装备幻化(连接id,序号,id,内容)
	if 玩家数据[id].角色.体力 < 20 or 玩家数据[id].角色.活力 < 20 then
		常规提示(id,"#Y你的体活好像不够了！")
		return
	end
	local 装备格子=玩家数据[id].角色.道具[内容.序列]
	if 玩家数据[id].道具.数据[装备格子].总类 == 2 and 玩家数据[id].道具.数据[装备格子].级别限制 == 150 then
		if 玩家数据[id].道具:消耗背包道具(连接id,id,"陨铁",1) then
			local 临时序列=self:取150装备序列(玩家数据[id].道具.数据[装备格子].名称)
			local ysmc=元身名称[临时序列]
			local dz = self:幻化公式(临时序列)
			local yuanshen = 物品类()
			yuanshen:置对象(ysmc,nil,nil,160)
			yuanshen.级别限制 = 160
			yuanshen.幻化元身属性={}
			if yuanshen.幻化次数==nil then
				yuanshen.幻化次数=0
			end
			yuanshen.幻化次数 = yuanshen.幻化次数 + 1
			yuanshen.元身序列 = 临时序列
			local 属性 = {"命中", "伤害", "防御", "魔法", "灵力", "气血", "敏捷", "体质", "力量", "耐力", "魔力", "特效", "特技"}
			for n = 1, #属性 do
				if dz[n] ~= nil then
					if n >= 7 and n <= 11 and 临时序列~=25 then --不是鞋子的情况
						if dz[n] < 0 then
							yuanshen.幻化元身属性[属性[n]] = "减少"..属性[n]
						else
							yuanshen.幻化元身属性[属性[n]] = "增加"..属性[n]
						end
					elseif n == 12 then
						yuanshen.幻化元身属性.特效概率 = dz[n]
						yuanshen.幻化元身属性[属性[n]] = "增加"..属性[n].."概率 +"..math.floor(dz[n]).."%"
					elseif n == 13 then
						yuanshen.幻化元身属性.特技概率 = dz[n]
						yuanshen.幻化元身属性[属性[n]] = "增加"..属性[n].."概率 +"..math.floor(dz[n]).."%"
					else
						yuanshen.幻化元身属性[属性[n]] = math.floor(dz[n])
					end
				end
			end
			yuanshen.识别码 = id.."_"..os.time().."_"..取随机数(1000,9999).."_"..随机序列
			随机序列 = 随机序列 + 1
			玩家数据[id].道具.数据[装备格子]=yuanshen
			道具刷新(id)
			玩家数据[id].角色.体力 = 玩家数据[id].角色.体力-20
			玩家数据[id].角色.活力 = 玩家数据[id].角色.活力-20
			体活刷新(id)
			常规提示(id,"幻化成功，你获得了"..ysmc)
		end
	elseif 玩家数据[id].道具.数据[装备格子].总类 == 204 and 玩家数据[id].道具.数据[装备格子].级别限制 == 160 then --元身
		if not 玩家数据[id].道具:消耗背包道具(连接id,id,"陨铁",1) or 玩家数据[id].道具.数据[装备格子].幻化次数==nil then
			return
		end
		local QHS=内容.材料
		local 新增概率 = math.floor((QHS.青龙石+QHS.白虎石+QHS.朱雀石+QHS.玄武石)/2)
		if 新增概率 > 0 then
			for k,v in pairs(QHS) do
				if v>0 then
					if 玩家数据[id].道具:判定背包道具(id,k,v)==false then --判断
						常规提示(id,"你的强化石不够哦！")
						return
					end
				end
			end
			for k,v in pairs(QHS) do --消耗
				if v>0 then
					玩家数据[id].道具:消耗背包道具(连接id,id,k,v)
				end
			end
		end
		local yuanshen = 玩家数据[id].道具.数据[装备格子]
		local 幻化概率 = 获取幻化概率(yuanshen.幻化次数)
		if 取随机数(5,100) <=(幻化概率 + 新增概率) then
			yuanshen.幻化元身属性={}
			local 子类=yuanshen.子类
			local 元身序列=self:取元身序列(yuanshen.名称)
			local dz = self:幻化公式(元身序列)
			local 属性 = {"命中", "伤害", "防御", "魔法", "灵力", "气血", "敏捷", "体质", "力量", "耐力", "魔力", "特效", "特技"}
			for n = 1, #属性 do
				if dz[n] ~= nil then
					if n >= 7 and n <= 11 and 元身序列~=25 then
						if dz[n] < 0 then
							yuanshen.幻化元身属性[属性[n]] = "减少"..属性[n]
						else
							yuanshen.幻化元身属性[属性[n]] = "增加"..属性[n]
						end
					elseif n == 12 then
						yuanshen.幻化元身属性.特效概率 = dz[n]
						yuanshen.幻化元身属性[属性[n]] = "增加"..属性[n].."概率 +"..math.floor(dz[n]).."%"
					elseif n == 13 then
						yuanshen.幻化元身属性.特技概率 = dz[n]
						yuanshen.幻化元身属性[属性[n]] = "增加"..属性[n].."概率 +"..math.floor(dz[n]).."%"
					else
						yuanshen.幻化元身属性[属性[n]] = math.floor(dz[n])
					end
				end
			end
			yuanshen.幻化次数 = yuanshen.幻化次数+1
			if yuanshen.幻化次数>15 and yuanshen.幻化次数<=30 then
			   常规提示(id,"经历了多次幻化，元身出现了一些破损。")
			elseif yuanshen.幻化次数>30 then
			   常规提示(id,"经历了很多次幻化，元身的破损更严重了。")
			end
			常规提示(id,"幻化成功，你获得"..yuanshen.名称)
			道具刷新(id)
			玩家数据[id].角色.体力 = 玩家数据[id].角色.体力-20
			玩家数据[id].角色.活力 = 玩家数据[id].角色.活力-20
			体活刷新(id)
			return
		else
			玩家数据[id].角色.道具[内容.序列]=nil
			玩家数据[id].道具.数据[装备格子]=nil
			常规提示(id,"#R/幻化失败，幻化材料消失。")
			道具刷新(id)
			玩家数据[id].角色.体力 = 玩家数据[id].角色.体力-20
			玩家数据[id].角色.活力 = 玩家数据[id].角色.活力-20
			体活刷新(id)
			return
		end
	end
end

function 装备处理类:取160名称(子类)
	local n = {"弑皇","裂天","擒龙","浮犀","九霄","离钩","星瀚","醍醐","碎寂","霜陨","朝夕","鸣鸿","弦月","若木","赤明","长息","荒尘","晴雪","浑天玄火盔","乾元鸣凤冕","落霞陨星坠","鎏金浣月衣","混元一气甲","紫霄云芒带","辟尘分光履"}
	return n[子类]
end

function 装备处理类:取元身序列(子类)
	for i=1,#元身名称 do
		if 元身名称[i] == 子类 then
			return i
		end
	end
end
function 装备处理类:取150装备序列(子类)
	local n = {"天龙破城","碧血干戚","霜冷九州","紫电青霜","揽月摘星","忘川三途","浩气长舒","丝萝乔木","狂澜碎岳","牧云清歌","无关风月","业火三灾","碧海潮生","九霄风雷","云雷万里","百辟镇魂","夭桃秾李","浮生归梦","紫金磐龙冠","金珰紫焰冠","紫金碧玺佩","五彩凤翅衣","紫金磐龙甲","磐龙凤翔带","金丝逐日履"}
	for i=1,#n do
		if n[i] == 子类 then
			return i
		end
	end
end

function 装备处理类:取可以镶嵌(zb,bs) --1黄宝石 1光芒石 2月亮石 3太阳石 4舍利子 5红玛瑙 6黑宝石 7神秘石 8星辉石 0翡翠石
	if zb == 1 and (bs == 2 or bs == 3 or bs==5) then --头
		return true
	elseif zb == 2 and (bs == 4 or bs == 0) then --项链
		return true
	elseif zb == 3 and (bs == 3 or bs == 5 or bs == 7) then --武器
		return true
	elseif zb == 4 and (bs == 1 or bs == 2 or bs == 4 or bs == 0) then --衣服
		return true
	elseif zb == 5 and (bs == 1 or bs == 6 or bs == 7) then --腰带
		return true
	elseif zb == 6 and (bs == 6 or bs == 7) then --鞋子
		return true
	end
end

function 装备处理类:取宝石合成几率(id,级别)
	if 级别<=8 then
		return true
	elseif 级别>=20 then
		return false
	end
	local 失败=级别-(玩家数据[id].角色:取剧情技能等级("宝石工艺")+0)
	if 取随机数()<失败 then
		return false
	end
	return true
end
function 装备处理类:取钟灵石合成几率(id,级别)
	if 级别<=5 then
		return true
	elseif 级别>=8 then
		return false
	end
	local 失败=级别*2-(玩家数据[id].角色:取剧情技能等级("宝石工艺")+0)
	if 取随机数()<失败 then
		return false
	end
	return true
end

return 装备处理类