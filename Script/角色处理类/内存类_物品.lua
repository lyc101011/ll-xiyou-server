-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:44
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-15 13:41:10
local 内存类_物品 = class()
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数
local 五行_ = {"金","木","水","火","土"}

local function 变身卡(模型)
	if 模型 == "大海龟" then
		return "大海龟","item.wdf",0x4A028BEE,0x3C7B89E8,nil,nil,20,1,3
	elseif 模型 == "巨蛙" then
		return "巨蛙","item.wdf",0x4A028BEE,0x98E3377F,nil,nil,20,1,3
	elseif 模型 == "海星" then
		return "海星","item.wd1",1241680878,3876179373,nil,nil,20,1,3,"item.wdf"
	elseif 模型 == "章鱼" then
		return "章鱼","item.wd1",1241680878,2880866697,nil,nil,20,1,3,"item.wdf"
	elseif 模型 == "狸" then
		return "狸","item.wd1",1241680878,2785980633,nil,nil,20,1,3,"item.wdf"
	elseif 模型 == "大蝙蝠" then
		return "大蝙蝠","item.wdf",1241680878,0x2481DFCC,nil,nil,20,1,3
	elseif 模型 == "赌徒" then
		return "赌徒","item.wdf",1241680878,0x6BE81A68,nil,nil,20,1,3
	elseif 模型 == "海毛虫" then
		return "海毛虫","item.wdf",1241680878,0x3BD0B554,nil,nil,20,1,3
	elseif 模型 == "护卫" then
		return "护卫","item.wdf",1241680878,0x7003F174,nil,nil,20,1,3
	elseif 模型 == "强盗" then
		return "强盗","item.wdf",1241680878,0xD5C2566E,nil,nil,20,1,3
	elseif 模型 == "山贼" then
		return "山贼","item.wdf",1241680878,0x5F7346A8,nil,nil,20,1,3
	elseif 模型 == "树怪" then
		return "树怪","item.wdf",1241680878,0x4ED5C9C4,nil,nil,20,1,3
	elseif 模型 == "野猪" then
		return "野猪","item.wdf",1241680878,0xEF3A830D,nil,nil,20,1,3
	end
end

local function 取套装效果(tz)
	if tz == "盘丝阵" or tz == "定心术" or tz == "极度疯狂" or tz == "金刚护法" or tz == "逆鳞" or tz == "生命之泉" or tz == "魔王回首" or tz == "幽冥鬼眼" or tz == "楚楚可怜" or tz == "百毒不侵" or tz == "变身" or tz == "普渡众生" or
		tz == "炼气化神" or tz == "修罗隐身" or tz == "杀气诀" or tz == "一苇渡江" or tz == "碎星诀" or tz == "明光宝烛" then
		return "附加状态"
	elseif tz == "知己知彼" or tz == "似玉生香" or tz == "三味真火" or tz == "日月乾坤" or tz == "镇妖" or tz == "尸腐毒" or tz == "阎罗令" or tz == "百万神兵" or tz == "勾魂" or tz == "判官令" or tz == "雷击" or tz == "魔音摄魂" or tz == "摄魄" or tz == "紧箍咒" or
		tz == "落岩" or tz == "含情脉脉" or tz == "日光华" or tz == "水攻" or tz == "唧唧歪歪" or tz == "靛沧海" or tz == "烈火" or tz == "催眠符" or tz == "龙卷雨击" or tz == "巨岩破" or tz == "奔雷咒" or tz == "失心符" or tz == "龙腾" or tz == "苍茫树" or tz == "泰山压顶" or
		tz == "落魄符" or tz == "龙吟" or tz == "地裂火" or tz == "水漫金山" or tz == "定身符" or tz == "五雷咒" or tz == "后发制人" or tz == "地狱烈火" or tz == "满天花雨" or tz == "飞砂走石" or tz == "横扫千军" or tz == "落叶萧萧" or tz == "尘土刃" or tz == "荆棘舞" or tz == "冰川怒" or tz == "夺命咒" or tz == "浪涌" or tz == "裂石" then
		return "法术追加"
	end
end

function 内存类_物品:初始化()
end

function 取坐骑装饰(fl)
	local fhz = ""
	if fl == 1 then
		fhz = "宝贝葫芦"
	elseif fl == 2 then
		fhz = "神气小龟"
	elseif fl == 3 then
		fhz = "流星天马"
	elseif fl == 4 then
		fhz = "欢喜羊羊"
	elseif fl == 5 then
		fhz = "披甲战狼"
	elseif fl == 6 then
		fhz = "魔力斗兽"
	elseif fl == 7 then
		fhz = "闲云野鹤"
	elseif fl == 8 then
		fhz = "云魅仙鹿"
	end
	return fhz
end
function getMountDecorationMatch(坐骑,名称)
    local decorations = {
        ["宝贝葫芦"] = {},
        ["神气小龟"] = {"独眼观天", "威武不屈", "深藏不露"},
        ["汗血宝马"] = {"异域浓情", "流星天马", "威猛将军"},
        ["欢喜羊羊"] = {"知情达理", "气宇轩昂", "如花似玉"},
        ["披甲战狼"] = {"傲视天下", "铁血豪情", "唯我独尊"},
        ["魔力斗兽"] = {"叱咤风云", "异域风情", "假面勇者"},
        ["闲云野鹤"] = {"霓裳魅影", "披星戴月", "烈焰燃情"},
        ["云魅仙鹿"] = {"天雨流芳", "灵光再现", "倾国倾城"}
    }

    local decorationList = decorations[坐骑]
    if decorationList then
        for _, decoration in ipairs(decorationList) do
            if 名称 == decoration then
                return true
            end
        end
    end

    return false
end

function 取坐骑装饰分类(坐骑)
	local asd={"展翅高飞","旗开得胜","霸王雄风"}
	if 坐骑=="宝贝葫芦" then
		local sj=取随机数(1,#asd)
	    return {mc=asd[sj],fl=1,zl=sj}
	elseif 坐骑=="神气小龟" then
		asd={"独眼观天","威武不屈","深藏不露"}
		local sj=取随机数(1,#asd)
	    return {mc=asd[sj],fl=2,zl=sj}
    elseif 坐骑=="汗血宝马" then
		asd={"异域浓情","流星天马","威猛将军"}
		local sj=取随机数(1,#asd)
	    return {mc=asd[sj],fl=3,zl=sj}
    elseif 坐骑=="欢喜羊羊" then
		asd={"知情达理","气宇轩昂","如花似玉"}
	    local sj=取随机数(1,#asd)
	    return {mc=asd[sj],fl=4,zl=sj}
    elseif 坐骑=="披甲战狼" then
		asd={"傲视天下","铁血豪情","唯我独尊"}
	    local sj=取随机数(1,#asd)
	    return {mc=asd[sj],fl=5,zl=sj}
    elseif 坐骑=="魔力斗兽" then
		asd={"叱咤风云","异域风情","假面勇者"}
	    local sj=取随机数(1,#asd)
	    return {mc=asd[sj],fl=6,zl=sj}
    elseif 坐骑=="闲云野鹤" then
		asd={"霓裳魅影","披星戴月","烈焰燃情"}
	    local sj=取随机数(1,#asd)
	    return {mc=asd[sj],fl=7,zl=sj}
    elseif 坐骑=="云魅仙鹿" then
		asd={"天雨流芳","灵光再现","倾国倾城"}
	    local sj=取随机数(1,#asd)
	    return {mc=asd[sj],fl=8,zl=sj}
	end
end

function 内存类_物品:置对象(名称,打造,总类,级别)
	local 道具
	local c = false
	if typ(名称) == "table" then
		道具 = 名称
		self.名称 = 道具.名称
		c = true
		self.介绍 = 道具.介绍
		self.总类 = 道具.总类
		self.分类 = 道具.分类
		self.子类 = 道具.子类
		if  道具.总类 == 2 then
			self.级别限制 = 道具.级别限制
			self.角色限制 = 道具.角色限制
			self.性别限制 = 道具.性别限制
			self.级别限制 = 道具.级别限制
		end
		self.小模型 = 道具.小模型
		self.大模型 = 道具.大模型
		if 道具.阶品 ~= nil then
		    self.阶品 = 道具.阶品
		end
		if 道具.价格 ~= nil then
		    self.价格 = 道具.价格
		end
		if 道具.气血 ~= nil then
			self.气血 = 道具.气血
		end
		if 道具.魔法 ~= nil then
			self.魔法 = 道具.魔法
		end
	else
		道具 = wps(名称)
		self.介绍 = 道具[1]
		self.总类 = 道具[2]
		self.分类 = 道具[3]
		self.子类 = 道具[4]
		self.名称 = 名称
		if 道具[2] == 2 then
			self.级别限制 = 0
			if 道具[7] ~= nil then
				self.角色限制 = 道具[7]
			end
			if 道具[6] ~= nil then
				self.性别限制 = 道具[6]
			end
			if 道具[5] ~= nil then
				self.级别限制 = 道具[5]
			end
		end
		if 道具[3] == 10 and 道具[4] == 2 then
			self.阶品 = 道具[8]
		end
		if 道具[2] == 1 then --PK药品
			self.阶品 = 道具[8]
		end
		if 道具[14] ~= nil then
			self.价格 = 道具[14]
		end
		if 道具[9] ~= nil then
			self.气血 = 道具[9]
		end
		if 道具[10] ~= nil then
			self.魔法 = 道具[10]
		end
	end
	self.资源 = 道具[11]
	self.小模型资源 = 道具[12]
	self.大模型资源 = 道具[13]
	if self.总类 == 2 then--1==2 --装备
		if self.级别限制 == nil then
			self.级别限制 = 0
		end
		local lv = self.级别限制
		self.鉴定 = true
		self.五行 = 五行_[取随机数(1,5)]
		self.耐久 = 取随机数(500,700)
		self.价格 = 10000
		if 级别 ~= nil then
			self.级别限制 = 级别
		end
		if self.分类 <7 then
			self.开运孔数 = {当前=0,上限=0}
			if self.级别限制<30 then
			    self.开运孔数 = {当前=0,上限=1}
			elseif self.级别限制>=40 and self.级别限制<=60 then
			    self.开运孔数 = {当前=0,上限=2}
			elseif self.级别限制>=70 and self.级别限制<=90 then
			    self.开运孔数 = {当前=0,上限=3}
			elseif self.级别限制>=100 and self.级别限制<=120 then
			    self.开运孔数 = {当前=0,上限=4}
			elseif self.级别限制>=130 then
			    self.开运孔数 = {当前=0,上限=5}
			end
			self.熔炼效果={}
			self.武器神附={} -------------武器附神
		end
	elseif self.总类 == 3 then
		if self.分类 == 1 then
			self.附带技能 = 打造
		end
	elseif self.总类 == 1 then
		if self.阶品 ~= 3 and self.分类 ~= 12  and self.名称 ~= "金香玉"then
			self.可叠加 = true
		else
			self.可叠加 = false
		end
	elseif self.总类 == 4 then
		self.可叠加 = true
	elseif self.总类 == 5 then --宝石
		self.子类 = 打造
		if 总类 ~= nil then
			self.特效 = 总类
		end
		self.可叠加 = false
		if self.分类 == 4 then
			self.子类 = 道具[4]
			self.特效 = 道具[5]
			self.可叠加 = true
		elseif self.分类 == 6 then
			self.子类 = 道具[4]
			self.角色限制 = 道具[8]
			self.级别限制 = 打造 or 1
			self.特效 = 道具[9]
			if 道具[5] ~= nil then
				self.级别限制 = 道具[5]
			end
		elseif self.分类 == 22 then
			self.可叠加 = true
		end
	elseif  self.总类 == 6 then
		self.可叠加 = true
	elseif self.总类 == 7 then
		if self.分类 == 2 then
			self.可叠加 = true
		else
		    self.可叠加 = false
		end
	elseif  self.总类 == 9 then
		self.可叠加 = true
	elseif self.总类 == 10 then
		self.可叠加 = true
	elseif self.总类 == 11 then
		self.可叠加 = false
	elseif self.总类 == 12 then
		self.子类 = 打造
		self.可叠加 = false
	elseif self.总类 == 13 then
		self.子类 = 打造
		self.可叠加 = false
	elseif self.总类 == 100 then
		self.可叠加 = true
	elseif self.总类 == 103 then
		--self.可叠加 = true
	elseif self.总类 == 102 then
		self.可叠加 = true
	elseif self.总类 == 105 then
		self.可叠加 = true
	elseif self.总类 == 107 then
		self.可叠加 = true
	elseif self.总类 == 109 then
		self.可叠加 = true
	-------------------超级技能
    elseif self.总类 == 110 then
		self.可叠加 = true
	-------------------
	elseif self.总类 == 112 then
		local 临时五维 = {"体质","魔力","力量","耐力","敏捷"}
		self.气血 = 0
		self.装备坐骑 = 取坐骑装饰(道具[3])
		self.特技 = 临时五维[取随机数(1,#临时五维)]
		self.级别限制 = 0
		self.耐久=500
	elseif self.总类 == 145 then
		self.可叠加 = true
	elseif self.总类 == 146 then
		self.可叠加 = true
	elseif self.总类 == 147 then
		self.可叠加 = true
	elseif self.总类 == 148 then
		self.可叠加 = true
	elseif self.总类 == 151 then
		if self.分类 == 1 or self.分类 == 2 or self.分类 == 3 or self.分类 == 7 or self.分类 == 11 or self.分类 == 12 or self.分类 == 13 or self.分类 == 17 or self.分类 == 18 or self.分类 == 19 then
			self.可叠加 = true
		end
	elseif self.总类 == 20 or self.总类 == 25 or self.总类 == 8 then
		self.可叠加 = true
	elseif self.总类 == 199 then --玄灵珠
		self.可叠加 = false
	    self.级别限制 = 打造 or 1
        if 道具[5] ~= nil then
		    self.级别限制 = 道具[5]
		end
	elseif self.总类 == 200 then
		self.价格 = 5000 * self.分类
	elseif self.总类 == 1000 then --法宝
		self.使用 = 道具[5] --需要佩戴才可在战斗中发挥效用
		self.特技 = 道具[6] --【等级限制】：
		self.气血 = 0 --当前层数
		self.魔法 = 道具[3] * 50 --灵气
		self.角色限制 = 道具[7] or 0 --CD
		self.五行 = 五行_[取随机数(1,5)]
		-- self.耐久=取随机数(500,700)
		-- self.伤害 = 道具[8] or 0
	elseif self.总类 == 1002 then
		self.使用 = 道具[5]
		self.特技 = 道具[6]
		self.魔法 = 道具[3] * 50
		self.气血 = 0
	elseif self.总类 == 21 then
		self.特效 = 道具[8]
		if self.分类 == 3 then
			self.可叠加 = false
		else
			self.可叠加 = true
		end
	elseif self.总类 == 30 then
		self.角色限制,self.资源,self.小模型资源,self.大模型资源,self.特技,self.特效,self.魔法,self.气血,self.伤害,self.小模型id = 变身卡(打造)
	elseif self.总类 == 1100 then
		if self.子类 == 10001 then
			self.可叠加 = true
		end
	end
	if self.名称=="修炼果" or self.名称=="月饼" or self.名称=="灵饰特效宝珠" or self.名称=="特技书"  or self.名称=="80灵饰礼包" or self.名称=="特殊兽诀·碎片"
		or self.名称=="超级兽诀·碎片" or self.名称=="不磨符" or self.名称=="双加转换符" or self.名称=="160附魔宝珠礼包" or self.名称=="140灵饰礼包" or self.名称=="八级玄灵珠礼包"
		or self.名称=="月华露" or self.名称=="灵犀玉礼包" or self.名称=="6级钟灵石礼包"  or self.名称=="高级宝石礼包" or self.名称=="装备特效宝珠礼包" or self.名称=="陨铁礼包"
		or self.名称=="高级星辉石礼包" or self.名称=="灵犀之屑礼包" or self.名称=="愤怒符" or self.名称=="一万银票" or self.名称=="十万银票" or self.名称=="百万银票"
		or self.名称=="千万银票" or self.名称=="一亿银票" or self.名称=="十亿银票" or self.名称=="百亿银票" or self.名称=="千亿银票" or self.名称=="万亿银票"
		or self.名称=="特殊兽诀礼盒" or self.名称=="120无级别礼包" or self.名称=="130无级别礼包" or self.名称=="140无级别礼包" or self.名称=="150无级别礼包" or self.名称=="160无级别礼包"
		or self.名称=="稀有兽诀礼盒" or self.名称=="超级兽诀礼盒" or self.名称=="特殊清灵仙露" or self.名称=="附魔宝珠" or self.名称=="陨铁" or self.名称=="钨金"
		 -- or self.名称=="魔兽要诀" --or self.名称=="附魔宝珠" or self.名称=="附魔宝珠" or self.名称=="附魔宝珠" or self.名称=="附魔宝珠" or self.名称=="附魔宝珠"
		then
		self.可叠加 = true
	end
	if self.总类~=2 and self.总类 ~= 55  then
		self.特效=nil
		self.角色限制=nil
	end
	self.介绍=nil
	self.大模型资源=nil
	self.资源=nil
	self.小模型资源=nil
end

return 内存类_物品