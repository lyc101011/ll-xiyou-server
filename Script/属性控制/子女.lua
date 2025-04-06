-- @Author: baidwwy
-- @Date:   2024-05-13 15:10:42
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-05-23 02:10:42
--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2024-04-28 01:43:02
--======================================================================--
local floor = math.floor
local ceil  = math.ceil
local bbs = 取宝宝
local jnsss = require("script/角色处理类/技能类")
local random = 取随机数
local insert = table.insert
local cfs    = 删除重复
local rand   = 取随机小数
local 五行_ = {"金","木","水","火","土"}
local 内存类_宝宝 = class()

function 内存类_子女:初始化()
	self.参战等级 = 0
	self.等级 = 0
	self.名称 = 0
	self.模型 = 0
	self.气血 = 0
	self.魔法 = 0
	self.攻击 = 0
	self.防御 = 0
	self.速度 = 0
	self.灵力 = 0
	self.体质 = 0
	self.魔力 = 0
	self.力量 = 0
	self.耐力 = 0
	self.敏捷 = 0
	self.潜力 = 0
	self.忠诚 = 100
	self.成长 = 0
	self.装备 = {}
	self.技能 = {}
	self.种类 = ""
	self.五行 = 0
	self.饰品 = nil
	self.染色组 = 0
	self.染色方案 = nil
	self.参战信息 = nil
	self.战斗技能 = {}
	self.装备属性 = {
		气血 = 0,
		魔法 = 0,
		命中 = 0,
		伤害 = 0,
		防御 = 0,
		速度 = 0,
		躲避 = 0,
		灵力 = 0,
		体质 = 0,
		魔力 = 0,
		力量 = 0,
		耐力 = 0,
		敏捷 = 0,
		元宵 = 0,
	}
	self.当前经验 = 0
	self.最大经验 = 0
	self.最大气血 = 0
	self.最大魔法 = 0
	self.攻击资质 = 0
	self.防御资质 = 0
	self.体力资质 = 0
	self.法力资质 = 0
	self.速度资质 = 0
	self.躲闪资质 = 0
	self.自动 = nil
	self.默认技能 = nil
end

function 内存类_子女:加载数据(数据)
	for n, v in pairs(数据) do
		if type(n)=="table" then
			self[n]=table.loadstring(table.tostring(v))
		else
			self[n]=v
		end
	end
end

function 内存类_子女:取存档数据()
	local 返回数据={}
	for n, v in pairs(self) do
		if type(n)~="function" and type(n)~="运行父函数" and n~="返回数据" then
			if type(n)=="table" then ----------
				返回数据[n]=table.loadstring(table.tostring(v))
			else
				返回数据[n]=v
			end
		end
	end
   return 返回数据
end

function 内存类_子女:穿戴装备(装备,格子)
	if 装备.气血 ~= nil then
		self.装备属性.气血 = self.装备属性.气血 + 装备.气血
	end
	if 装备.魔法 ~= nil then
		self.装备属性.魔法 = self.装备属性.魔法 +  装备.魔法
	end
	if 装备.命中 ~= nil then
		self.装备属性.命中 = self.装备属性.命中 +  装备.命中
	end
	if 装备.伤害 ~= nil then
		self.装备属性.伤害 = self.装备属性.伤害 +  装备.伤害
	end
	if 装备.防御 ~= nil then
		self.装备属性.防御 = self.装备属性.防御 + 装备.防御
	end
	if 装备.速度 ~= nil then
		self.装备属性.速度 = self.装备属性.速度 +  装备.速度
	end
	if 装备.躲避 ~= nil then
		self.装备属性.躲避 = self.装备属性.躲避 +  装备.躲避
	end
	if 装备.灵力 ~= nil then
		self.装备属性.灵力 = self.装备属性.灵力 +  装备.灵力
	end
	if 装备.体质 ~= nil then
		self.装备属性.体质 = self.装备属性.体质 + 装备.体质
	end
	if 装备.魔力 ~= nil then
		self.装备属性.魔力 = self.装备属性.魔力 + 装备.魔力
	end
	if 装备.力量 ~= nil then
		self.装备属性.力量 = self.装备属性.力量 + 装备.力量
	end
	if 装备.耐力 ~= nil then
		self.装备属性.耐力 = self.装备属性.耐力 + 装备.耐力
	end
	if 装备.敏捷 ~= nil then
		self.装备属性.敏捷 = self.装备属性.敏捷 + 装备.敏捷
	end
	self.装备[格子] = 装备
	if 装备.套装效果 ~= nil then
		local sl = {}
		local ab = true
		self.套装 = self.套装 or {}
		for i=1,#self.套装 do
			if self.套装[i][1] == 装备.套装效果[1] and self.套装[i][2] == 装备.套装效果[2] then
				local abc = false
				local abd = true
				for s=1,#self.套装[i][4] do
					if self.套装[i][4][s] == 格子 then
					    abd = false
					    break
					end
				end
				if abd then
					insert(self.套装[i][4],格子)
					abc = true
				end
				if abc then
					self.套装[i][3] = (self.套装[i][3] or 0) + 1
				end
				ab = false
				break
			end
		end
		if ab then
			insert(self.套装,{装备.套装效果[1],装备.套装效果[2],1,{格子}})
		end
	end
	self:刷新信息()
end

function 内存类_子女:卸下装备(装备,格子)
	if 装备.气血 ~= nil then
		self.装备属性.气血 = self.装备属性.气血 - 装备.气血
	end
	if 装备.魔法 ~= nil then
		self.装备属性.魔法 = self.装备属性.魔法 -  装备.魔法
	end
	if 装备.命中 ~= nil then
		self.装备属性.命中 = self.装备属性.命中 -  装备.命中
	end
	if 装备.伤害 ~= nil then
		self.装备属性.伤害 = self.装备属性.伤害 -  装备.伤害
	end
	if 装备.防御 ~= nil then
		self.装备属性.防御 = self.装备属性.防御 - 装备.防御
	end
	if 装备.速度 ~= nil then
		self.装备属性.速度 = self.装备属性.速度 -  装备.速度
	end
	if 装备.躲避 ~= nil then
		self.装备属性.躲避 = self.装备属性.躲避 -  装备.躲避
	end
	if 装备.灵力 ~= nil then
		self.装备属性.灵力 = self.装备属性.灵力 -  装备.灵力
	end
	if 装备.体质 ~= nil then
		self.装备属性.体质 = self.装备属性.体质 - 装备.体质
	end
	if 装备.魔力 ~= nil then
		self.装备属性.魔力 = self.装备属性.魔力 - 装备.魔力
	end
	if 装备.力量 ~= nil then
		self.装备属性.力量 = self.装备属性.力量 - 装备.力量
	end
	if 装备.耐力 ~= nil then
		self.装备属性.耐力 = self.装备属性.耐力 - 装备.耐力
	end
	if 装备.敏捷 ~= nil then
		self.装备属性.敏捷 = self.装备属性.敏捷 - 装备.敏捷
	end
	self:刷新信息()
end

function 内存类_子女:重置等级(等级)
	local 属性范围={"体质","力量","敏捷","耐力","魔力"}
	if self.种类=="野怪" then
		for n=1,等级*10 do
			local 随机序列=取随机数(1,5)
		end
	else
		local 总属性 = 0
		for n=1,5 do
			self[属性范围[n]]=等级+10
		end
		总属性= 等级*5
		if self.进阶~= nil and self.进阶.灵性~= nil then
			总属性 = 总属性 + self.进阶.灵性 * 2
		end
		self.潜力=0
		self.潜力=self.潜力+总属性
	end
	self.等级=等级
	self:刷新信息("1")
end

function 内存类_子女:置新对象(模型)
	local n = bbs(模型,类型,模型)
	if n[1] == nil or 属性表 ~= nil then
		self.模型 = 模型
		self.等级 = 等级 or 0
		self.种类 = 类型
		self.名称 = 名称 or 模型
		资质组 = 资质组 or {0,0,0,0,0,0}
		self.攻击资质 = 资质组[1]
		self.防御资质 = 资质组[2]
		self.体力资质 = 资质组[3]
		self.法力资质 = 资质组[4]
		self.速度资质 = 资质组[5]
		self.躲闪资质 = 资质组[6]
		self.寿命 = 资质组[7]
		self.技能 = 技能组 or {}
		self.成长 = 成长 or 0
		self.参战等级 = 参战等级 or 0
		self.五行 = 五行_[random(1,5)]
		self.内丹 = {floor(self.参战等级 / 35)+1}
		for m=1,#self.技能 do
			local w = self.技能[m]
		end
		属性表 = 属性表 or {0,0,0,0,0,0}
		self.忠诚 = 属性表[1]
		self.体质 = 属性表[2]
		self.魔力 = 属性表[3]
		self.力量 = 属性表[4]
		self.耐力 = 属性表[5]
		self.敏捷 = 属性表[6]
		if 属性表 ~= nil then
			self:刷新信息("1")
		end
		return
	end
	self.模型 = 模型
	self.种类 = "孩子"
	self.寿命=1000000
	self.忠诚 = 100
	self.体质 = 30
	self.魔力 = 30
	self.力量 = 30
	self.耐力 = 30
	self.敏捷 = 30
	self.名称 =  模型
	self.参战等级 = 0
	self.攻击资质= 1600
	self.防御资质= 1500
	self.体力资质= 6000
	self.法力资质= 3100
	self.速度资质= 1500
	self.躲闪资质= 1400
	self.成长 =1.41
	self.技能={}
	self:刷新信息("1")
end

function 内存类_子女:升级()
	self.等级 = self.等级 + 1
	self.体质 = self.体质 + 1
	self.魔力 = self.魔力 + 1
	self.力量 = self.力量 + 1
	self.耐力 = self.耐力 + 1
	self.敏捷 = self.敏捷 + 1
	self.潜力 = self.潜力 + 5
	self.当前经验 = self.当前经验 - self.最大经验
	self:刷新信息("1")
end

function 内存类_子女:降级(级数)
	self.等级 = self.等级 - 级数
	self.体质 = self.体质 - 级数
	self.魔力 = self.魔力 - 级数
	self.力量 = self.力量 - 级数
	self.耐力 = self.耐力 - 级数
	self.敏捷 = self.敏捷 - 级数
	self.潜力 = self.潜力 - 级数 * 5
	self:刷新信息("1")
end

function 内存类_子女:添加技能(名称)
	local jn = jnsss()
	jn:置对象(名称)
	self.技能[#self.技能+1] = jn
end

function 内存类_子女:替换技能(名称)
	local jn = jnsss()
	jn:置对象(名称)
	self.技能[random(1,#self.技能)] = jn
end

function 内存类_子女:取差异属性(sxb)
	local sx1 = self.最大气血
	local sx2 = self.最大魔法
	local sx3 = self.伤害
	local sx4 = self.防御
	local sx5 = self.速度
	local sx6 = self.灵力
	local 体质 = self.体质 + self.装备属性.体质 + sxb.体质
	local 魔力 = self.魔力 + self.装备属性.魔力 + sxb.魔力
	local 力量 = self.力量 + self.装备属性.力量 + sxb.力量
	local 耐力 = self.耐力 + self.装备属性.耐力 + sxb.耐力
	local 敏捷 = self.敏捷 + self.装备属性.敏捷 + sxb.敏捷
	local 最大气血 = ceil(self.等级*self.体力资质/1000+体质*self.成长*6) + self.装备属性.气血
	local 最大魔法 = ceil(self.等级*self.法力资质/500+魔力*self.成长*3) + self.装备属性.魔法
	local 伤害1 = ceil(self.等级*self.攻击资质*(self.成长+1.4)/750+力量*self.成长) + self.装备属性.伤害
	local 防御1 = ceil(self.等级*self.防御资质*(self.成长+1.4)/1143+耐力*(self.成长-1/253)*253/190)+ self.装备属性.防御
	local 速度1 = ceil(self.速度资质 * 敏捷/1000)  + self.装备属性.速度
	local 灵力1 = ceil(self.等级*(self.法力资质+1666)/3333+魔力*0.7+力量*0.4+体质*0.3+耐力*0.2) + self.装备属性.灵力
	return {气血=最大气血-sx1,魔法=最大魔法-sx2,伤害=伤害1-sx3,防御=防御1-sx4,速度=速度1-sx5,灵力=灵力1-sx6}
end

function 内存类_子女:取指定技能(名称)
	for n=1,#self.技能 do
		if self.技能[n]==名称 then
			return true
		end
	end
	return false
end

function 内存类_子女:刷新信息(是否,体质,魔力)
	local ls体质 = self.体质 + self.装备属性.体质
	local ls魔力 = self.魔力 + self.装备属性.魔力
	local ls力量 = self.力量 + self.装备属性.力量
	local ls耐力 = self.耐力 + self.装备属性.耐力
	local ls敏捷 = self.敏捷 + self.装备属性.敏捷
	if self.附加属性~=nil then
		ls体质 = ls体质 + self.附加属性.体质
		ls魔力 = ls魔力 + self.附加属性.魔力
		ls力量 = ls力量 + self.附加属性.力量
		ls耐力 = ls耐力 + self.附加属性.耐力
		ls敏捷 = ls敏捷 + self.附加属性.敏捷
	end
	self.最大气血 = ceil(self.等级*self.体力资质/1000+ls体质*self.成长*7) + self.装备属性.气血
	self.最大魔法 = ceil(self.等级*self.法力资质/500+ls魔力*self.成长*3) + self.装备属性.魔法
	self.伤害 = ceil(self.等级*self.攻击资质*(self.成长+1.4)/750+ls力量*self.成长) + self.装备属性.伤害
	self.防御 = ceil(self.等级*self.防御资质*(self.成长+1.4)/1143+ls耐力*(self.成长-1/253)*253/190)+ self.装备属性.防御
	self.速度 = ceil(self.速度资质 * ls敏捷/1000)  + self.装备属性.速度
	self.灵力 = ceil(self.等级*(self.法力资质+1666)/3333+ls魔力*1+ls力量*0.4+ls体质*0.3+ls耐力*0.2) + self.装备属性.灵力
	if 是否 == "1" then
		self.气血 = self.最大气血
		self.魔法 = self.最大魔法
	end
	if 体质 ~= nil and 体质 > 0 then
		self.气血 = self.最大气血
	end
	if 魔力 ~= nil and 魔力 > 0 then
		self.魔法 = self.最大魔法
	end
	self.气血 = self.气血
	self.最大气血 = self.最大气血
	if self.气血 > self.最大气血 then
		self.气血 = self.最大气血 - self.气血 + self.气血
	end
	self.魔法 = self.魔法
	self.最大魔法 = self.最大魔法
	if self.魔法 > self.最大魔法 then
		self.魔法 = self.最大魔法 - self.魔法 + self.魔法
	end
	self.等级 = self.等级
	if self.等级 <= 175 then
		self.最大经验 = self:取经验(2,self.等级)
	end
	if self:取指定技能("高级强力") then
		self.伤害=self.伤害+math.floor(self.等级*0.715)
	elseif self:取指定技能("强力") then
		self.伤害=self.伤害+math.floor(self.等级*0.52)
	end
	if self:取指定技能("超级防御") then
		self.防御=self.防御+math.floor(self.等级)
	elseif self:取指定技能("高级防御") then
		self.防御=self.防御+math.floor(self.等级*0.8)
	elseif self:取指定技能("防御") then
		self.防御=self.防御+math.floor(self.等级*0.6)
	end
	if self:取指定技能("逍遥游") then
		self.速度=self.速度+math.floor(self.速度*0.2)
	elseif self:取指定技能("高级敏捷") then
		self.速度=self.速度+math.floor(self.速度*0.2)
	elseif self:取指定技能("敏捷") then
		self.速度=self.速度+math.floor(self.速度*0.1)
	end
	if self:取指定技能("迟钝") then
		self.速度=self.速度-math.floor(self.速度*0.2)
	end
	if self:取指定技能("净台妙谛") then
		self.气血=self.气血+math.floor(ls体质*self.成长*2)
	end
    if self.内丹.技能 ~= nil then
    	local ls1 = 分割文本(self.认证码,"_")
    	local ls2,ls4 = 玩家数据[ls1[1]+0].角色:取召唤兽统御(ls1[1]+0,self.认证码)
	    for i=1,#self.内丹.技能 do
	    	local ls3 = 1
	    	ls3 = ls3+ self.内丹.技能[i].等级*0.2
	    	if ls2 ~= false then
	    		ls3 = ls3+ls4-1
	    	end
	    	if self.内丹.技能[i].技能 == "迅敏" then
	    		self.速度 = math.floor(self.速度 + (self.等级 *(0.05*ls3)))
	    		self.伤害 = math.floor(self.伤害 + (self.等级 *(0.08*ls3)))
	    	elseif self.内丹.技能[i].技能 == "静岳" then
	    		self.气血 = math.floor(self.气血 + (self.等级 *(0.4*ls3)))
	    		self.灵力 = math.floor(self.灵力 + (self.等级 *(0.04*ls3)))
	    		self.最大气血 = self.气血
	    	elseif self.内丹.技能[i].技能 == "矫健" then
	    		self.气血 = math.floor(self.气血 + (self.等级 *(0.4*ls3)))
	    		self.速度 = math.floor(self.速度 + (self.等级 *(0.05*ls3)))
	    		self.最大气血 = self.气血
	    	elseif self.内丹.技能[i].技能 == "玄武躯" then
	    		self.最大气血 = math.floor(self.最大气血 +(self.等级*(2*ls3)))
	    	elseif self.内丹.技能[i].技能 == "龙胄铠" then
	    		self.防御 = math.floor(self.防御 +(self.等级/(2*ls3)))
	    	end
	    end
	end
end

function 内存类_子女:取经验(id,lv)
	local exp={}
	if id==1 then
		exp={
			40,110,237,450,779,1252,1898,2745,3822,5159,6784,8726,11013,13674,16739,20236,24194,28641,33606,39119,45208,
			51902,55229,67218,75899,85300,95450,106377,118110,130679,144112,158438,173685,189882,207059,225244,244466,264753,
			286134,308639,332296,357134,383181,410466,439019,468868,500042,532569,566478,601799,638560,676790,716517,757770,
			800579,844972,890978,938625,987942,1038959,1091704,1146206,1202493,1260594,1320539,1382356,1446074,1511721,1579326,
			1648919,1720528,1794182,1869909,1947738,2027699,2109820,2194130,2280657,2369431,2460479,2553832,2649518,2747565,
			2848003,2950859,3056164,3163946,3274233,3387055,3502439,3620416,3741014,3864261,3990187,4118819,4250188,4384322,
			4521249,4660999,4803599,4998571,5199419,5406260,5619213,5838397,6063933,6295941,6534544,6779867,7032035,7291172,
			7557407,7830869,8111686,8399990,8695912,8999586,9311145,9630726,9958463,10294496,10638964,10992005,11353761,11724374,
			12103988,12492748,12890799,13298287,13715362,14142172,14578867,15025600,15482522,15949788,16427552,16915970,17415202,
			17925402,18446732,18979354,19523428,20079116,20646584,21225998,43635044,44842648,46075148,47332886,48616200,74888148,
			76891401,78934581,81018219,83142835,85308969,87977421,89767944,92061870,146148764,150094780,154147340,158309318,
			162583669,166973428,171481711,176111717,180866734,185780135,240602904,533679362,819407100,1118169947, 1430306664,
			1756161225,2096082853
		}
	else
		exp={
			50,200,450,800,1250,1800,2450,3250,4050,5000,6050,7200,8450,9800,11250,12800,14450,16200,18050,20000,22050,24200,
			26450,28800,31250,33800,36450,39200,42050,45000,48050,51200,54450,57800,61250,64800,68450,72200,76050,80000,84050,
			88200,92450,96800,101250,105800,110450,115200,120050,125000,130050,135200,140450,145800,151250,156800,162450,
			168200,174050,180000,186050,192200,198450,204800,211250,217800,224450,231200,238050,245000,252050,259200,266450,
			273800,281250,288800,296450,304200,312050,320000,328050,336200,344450,352800,361250,369800,378450,387200,396050,
			405000,414050,423200,432450,441800,451250,460800,470450,480200,490050,500000,510050,520200,530450,540800,551250,
			561800,572450,583200,594050,605000,616050,627200,638450,649800,661250,672800,684450,696200,708050,720000,732050,
			744200,756450,768800,781250,793800,806450,819200,832050,845000,858050,871200,884450,897800,911250,924800,938450,
			952200,966050,980000,994050,1008200,1022450,1036800,1051250,1065800,1080450,1095200,1110050,1125000,1140050,1155200,
			1170450,1185800,1201250,1216800,1232450,1248200,1264050,1280000,1300000,1340000,1380000,1420000,1460000,1500000,1540000,
			1580000,1700000,1780000,1820000,1940000,2400000,2880000,3220000,4020000,4220000,4420000,4620000,5220000,5820000,6220000,
			7020000,8020000,9020000
		}
	end
	return exp[lv+1]
end

return 内存类_子女