-- @Author: baidwwy
-- @Date:   2024-03-05 15:36:07
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-01-06 14:40:25
-- @Author: baidwwy
-- @Date:   2023-09-12 12:17:35
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-03-06 22:01:54
--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-06-23 00:28:24
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

function 内存类_宝宝:初始化()
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
	}
	self.特性五维={
		力量 = 0,
		敏捷 = 0,
		耐力 = 0,
		魔力 = 0,
		体质 = 0,
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

function 内存类_宝宝:置新对象(模型,名称,类型,属性,等级,染色方案,技能组,资质组,成长,参战等级,属性表,物法,dingzhi,灵性,内丹,特性)
	if 类型=="定制神兽" then
		self.模型 = 模型
		self.等级 = 0
		self.种类 = "神兽"
		self.名称 = 名称
		self.攻击资质 = 1600
		self.防御资质 = 1600
		self.体力资质 = 5500
		self.法力资质 = 3500
		self.速度资质 = 1400
		self.躲闪资质 = 1400
		self.寿命 = 9999
		self.技能 = 技能组 or {}
		self.成长 = 1.3
		self.参战等级 = 0
		self.五行 = 五行_[random(1,5)]
		self.内丹 = {可用内丹=3,内丹上限=3}
		self.忠诚 = 100
		self.体质 = 20
		self.魔力 = 20
		self.力量 = 20
		self.耐力 = 20
		self.敏捷 = 20
		self:刷新信息("1")
		return
	end
	local n = bbs(模型,类型,物法,dingzhi)
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
		self.参战等级 = n[1] or 0
		self.五行 = 五行_[random(1,5)]
		self.内丹 = {可用内丹=取内丹数量(self.参战等级),内丹上限=取内丹数量(self.参战等级)}
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
	elseif 技能组~=nil and 资质组~=nil and 成长~=nil then
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
		self.成长 = 成长 or 1
		self.参战等级 = 参战等级 or 0
		self.五行 = 五行_[random(1,5)]
		self.内丹 = {可用内丹=取内丹数量(self.参战等级),内丹上限=取内丹数量(self.参战等级)}
		属性表 = 属性表 or {0,0,0,0,0,0}
		self.忠诚 = 100
		self.体质 = 20
		self.魔力 = 20
		self.力量 = 20
		self.耐力 = 20
		self.敏捷 = 20
		if 属性表 ~= nil then
			self:刷新信息("1")
		end
		return
	end
	等级 = 等级 or 0
	self.模型 = 模型
	self.种类 = 类型
	self.寿命=取随机数(5000,7000)
	local 波动上限 = 1
	local 波动下限 = 0
	if 类型 == "野怪"  or 类型 == "孩子" then
		波动下限 = 0.725
		if 类型 == "孩子" then
			self.忠诚 = 100
		else
			self.忠诚 = 80
			local 属性范围={"力量","魔力","敏捷","体质","耐力"}
			local 随机属性=""
			for i=1,50 do --首先是0级的50点属性随机
				随机属性=属性范围[取随机数(1,#属性范围)]
				self[随机属性]=self[随机属性]+1
			end
			if 等级~=0 then --然后是等级影响的属性，随机加进去
				for n=1,等级*5 do
					随机属性=属性范围[取随机数(1,#属性范围)]
					self[随机属性]=self[随机属性]+1
				end
			end
		end
	elseif 类型 == "宝宝" then
		波动下限 = 0.925
		self.忠诚 = 100
		self.体质 = 20
		self.魔力 = 20
		self.力量 = 20
		self.耐力 = 20
		self.敏捷 = 20
	elseif 类型 == "变异" then
		波动下限 = 1.105
		self.忠诚 = 100
		self.体质 = 20
		self.魔力 = 20
		self.力量 = 20
		self.耐力 = 20
		self.敏捷 = 20
		n[2] = n[2] + 80
		n[3] = n[3] + 80
		n[4] = n[4] + 80
		n[5] = n[5] + 80
		n[6] = n[6] + 80
		n[7] = n[7] + 80
	elseif 类型 == "神兽" then
		self.忠诚 = 100
		self.体质 = 20
		self.魔力 = 20
		self.力量 = 20
		self.耐力 = 20
		self.敏捷 = 20
	end
	self.名称 = 名称 or 模型
	self.参战等级 = n[1]

	if 类型=="神兽" then
		self.攻击资质= n[2]
		self.防御资质= n[3]
		self.体力资质= n[4]
		self.法力资质= n[5]
		self.速度资质= n[6]
		self.躲闪资质= n[7]
	else
		self.攻击资质= ceil(n[2]*rand(波动下限,波动上限))
		self.防御资质= ceil(n[3]*rand(波动下限,波动上限))
		self.体力资质= ceil(n[4]*rand(波动下限,波动上限))
		self.法力资质= ceil(n[5]*rand(波动下限,波动上限))
		self.速度资质= ceil(n[6]*rand(波动下限,波动上限))
		self.躲闪资质= ceil(n[7]*rand(波动下限,波动上限))
	end
	local jn = n[9]
	local jn0 = {}
	local cz1 = random(1,100)
	for i=1,5 do
		if  not n[8][i] then
			if n[8][1]  == nil then
				n[8][i] = 1.254
			else
				n[8][i] = n[8][1]
			end
		end
	end
	if cz1 < 30 then
		self.成长 = n[8][1]
	elseif cz1 > 30  and cz1 < 60 then
		self.成长 = n[8][2]
	elseif cz1 > 60  and cz1 < 80 then
		self.成长 = n[8][3]
	elseif cz1 > 80  and cz1 < 95 then
		self.成长 = n[8][4]
	elseif cz1 > 95  and cz1 < 100 then
		self.成长 = n[8][5]
	end
	if self.成长 == 0 then
		self.成长 = n[8][1]
	end
	if 类型=="神兽" then
		self.技能=table.loadstring(table.tostring(n[9]))
		self.内丹 = {可用内丹=6,内丹上限=6}
	else
		for q=1,#jn do
			insert(jn0, jn[random(1,#jn)])
		end
		self.技能={}
		jn0 = cfs(技能组 or jn0)
		for j=1,#jn0 do
			self.技能[j] = jn0[j]
		end
		self.内丹 = {可用内丹=取内丹数量(self.参战等级),内丹上限=取内丹数量(self.参战等级)}
	end
	self.五行 = 五行_[random(1,5)]
	if n.染色方案 ~= nil then
		self.染色方案 = n.染色方案
		self.染色组 = {1,0}
	end
	if 染色方案 ~= nil then
		self.染色方案 = 染色方案[1]
		self.染色组 = 染色方案[2]
	end

	if 类型=="变异" then
		self.变异=true
		if 染色信息[模型]~=nil then
			self.染色方案 = 染色信息[模型].id
			self.染色组 = 染色信息[模型].方案
		end
	end
	if self.丸子技能 == nil then
		self.丸子技能={}
	end

	self:刷新信息("1")
end

function 内存类_宝宝:加载数据(数据)
	for n, v in pairs(数据) do
		if type(n)=="table" then
			self[n]=table.loadstring(table.tostring(v))
		else
			self[n]=v
		end
	end
end

function 内存类_宝宝:取存档数据()
	local 返回数据={}
	for n, v in pairs(self) do
		if type(n)~="function" and type(n)~="运行父函数" and n~="返回数据" then
			if type(n)=="table" then
				返回数据[n]=table.loadstring(table.tostring(v))
			else
				返回数据[n]=v
			end
		end
	end
	return 返回数据
end

function 内存类_宝宝:气血公式()
	return ceil(self.等级*0.5*self.成长*6 + self.体质*0.25)
end
function 内存类_宝宝:伤害公式()
	return ceil(self.等级*0.5*self.成长 + self.力量*0.04)
end
function 内存类_宝宝:防御公式()
	return ceil(self.等级*0.5*self.成长*1.33 + self.耐力*0.08)
end
function 内存类_宝宝:速度公式()
	return ceil(self.速度资质*self.等级*0.5/1000 + self.敏捷*0.08)
end
function 内存类_宝宝:灵力公式()
	return ceil(self.等级*0.7*0.5 + self.魔力*0.04)
end
function 内存类_宝宝:躲避公式()
	return self.等级
end

function 内存类_宝宝:刷新信息(是否,体质,魔力) --召唤兽刷新
	self:特性五维影响()
	if self.种类=="野怪" and self.yeguai==nil then
	   self:重置野怪属性()
	end
	local ls体质 = self.体质 + self.装备属性.体质 + self.特性五维.体质
	local ls魔力 = self.魔力 + self.装备属性.魔力 + self.特性五维.魔力
	local ls力量 = self.力量 + self.装备属性.力量 + self.特性五维.力量
	local ls耐力 = self.耐力 + self.装备属性.耐力 + self.特性五维.耐力
	local ls敏捷 = self.敏捷 + self.装备属性.敏捷 + self.特性五维.敏捷
	if self.进阶属性~=nil then
		ls体质 = ls体质 + self.进阶属性.体质
		ls魔力 = ls魔力 + self.进阶属性.魔力
		ls力量 = ls力量 + self.进阶属性.力量
		ls耐力 = ls耐力 + self.进阶属性.耐力
		ls敏捷 = ls敏捷 + self.进阶属性.敏捷
	end

	self.最大气血 = ceil((self.等级*self.体力资质/1000) + (ls体质*self.成长*6) + self.装备属性.气血 )
	self.最大魔法 = ceil((self.等级*self.法力资质/500) + (ls魔力*self.成长*3) + self.装备属性.魔法)
	self.伤害 = ceil((self.等级*self.攻击资质*(13.8+10*self.成长)/7500) + (ls力量*self.成长) + self.装备属性.伤害)
	self.防御 = ceil((self.等级*self.防御资质*(4.8+10*self.成长)/7500) + (ls耐力*self.成长*1.33) + self.装备属性.防御)
	self.速度 = ceil((self.速度资质*ls敏捷/1000) + self.装备属性.速度)
	self.灵力 = ceil((self.等级*self.法力资质/3500) + (self.等级*0.4+ls体质*0.3+ls耐力*0.2+ls力量*0.4+ls魔力*0.65) + self.装备属性.灵力)
	self.躲避 = ceil((self.速度资质*ls敏捷/1000) + self.装备属性.躲避)

	if self.天赋符 then
		if self.天赋符.lx~="我再想想" then
			self[self.天赋符.lx]=self[self.天赋符.lx]+self.天赋符.zhi
		end

	end
	if self:取指定技能("净台妙谛") then
		self.最大气血=self.最大气血+math.floor(self.体质*self.成长*2)
	end

	if self:取指定技能("欣欣向荣") and self.五行=="木" then
		self.最大气血 = floor(self.最大气血 * 1.4)
		self.欣欣向荣 = 1
	end

	if self.进阶 ~= nil  and self.进阶.开启 and self.进阶.特性 ~= "无" then --降低气血上限
		local biao = {"瞬击","瞬法","灵断"}
		for i=1,#biao do
			if self.进阶.特性 ==biao[i] then
				self.最大气血=math.floor(self.最大气血*(1-self.进阶.特性属性[2]*0.01))
				break
			end
		end

	end
	self.等级 = self.等级
	if self.等级 <= 175 then
		self.最大经验 = self:取经验(2,self.等级)
	end
	if self:取指定技能("高级强力") then
		self.伤害=self.伤害+math.floor(self.等级*0.55)
	elseif self:取指定技能("强力") then
		self.伤害=self.伤害+math.floor(self.等级*0.4)
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
	elseif self:取指定技能("溜之大吉") then
		self.速度=self.速度+math.floor(self.速度*0.2)
	elseif self:取指定技能("高级敏捷") then
		self.速度=self.速度+math.floor(self.速度*0.2)
	elseif self:取指定技能("敏捷") then
		self.速度=self.速度+math.floor(self.速度*0.1)
	end
	if self:取指定技能("迟钝") then
		self.速度=self.速度-math.floor(self.速度*0.2)
	end

	if self.内丹 ~= nil and self.内丹.格子 then
		local ls1 = 分割文本(self.认证码,"_")
		local ls2,ls4
		if 玩家数据[ls1[1]+0] then
			ls2,ls4 = 玩家数据[ls1[1]+0].角色:取召唤兽统御(ls1[1]+0,self.认证码) --技能，成长
		end
		if self.内丹.格子 then
			for i=1,#self.内丹.格子 do
				local ls3 = 1
				ls3 = ls3 + self.内丹.格子[i].等级*0.2
				if ls2 then
					ls3 = ls3+ls4-1 --统御的时候坐骑的成长
				end
				if self.内丹.格子[i].技能 == "迅敏" then
					self.速度 = math.floor(self.速度 + (self.等级 *(0.05*ls3)))
					self.伤害 = math.floor(self.伤害 + (self.等级 *(0.08*ls3)))
				elseif self.内丹.格子[i].技能 == "静岳" then
					self.最大气血 = math.floor(self.最大气血 + (self.等级 *(0.4*ls3)))
					self.灵力 = math.floor(self.灵力 + (self.等级 *(0.04*ls3)))
				elseif self.内丹.格子[i].技能 == "矫健" then
					self.最大气血 = math.floor(self.最大气血 + (self.等级 *(0.4*ls3)))
					self.速度 = math.floor(self.速度 + (self.等级 *(0.05*ls3)))
				elseif self.内丹.格子[i].技能 == "玄武躯" then
					self.最大气血 = math.floor(self.最大气血 +(self.等级*(2*ls3)))
					self.玄武躯=1
				elseif self.内丹.格子[i].技能 == "龙胄铠" then
					self.防御 = math.floor(self.防御 +(self.等级/(2*ls3)))
					self.龙胄铠=1
				end
			end
		end
	end
	if 是否 == "1" then
		self.气血 = math.floor(self.最大气血)
		self.魔法 = math.floor(self.最大魔法)
	end
	if 体质 ~= nil and 体质 > 0 then
		self.气血 = math.floor(self.最大气血)
	end
	if 魔力 ~= nil and 魔力 > 0 then
		self.魔法 = math.floor(self.最大魔法)
	end

	if self.气血 > self.最大气血 then
		self.气血 = math.floor(self.最大气血 - self.气血 + self.气血)
	end

	if self.魔法 > self.最大魔法 then
		self.魔法 = math.floor(self.最大魔法 - self.魔法 + self.魔法)
	end
	self.法伤=math.floor(self.灵力)
	self.法防=math.floor(self.灵力)
end

function 内存类_宝宝:穿戴装备(装备,格子)
	local sx={"速度","躲避","伤害","灵力","防御","气血"}
	if 装备 and 装备.宝石属性 then
		for i=1,#sx do
			if 装备.宝石属性[sx[i]]~=nil then
				self.装备属性[sx[i]] = self.装备属性[sx[i]] + 装备.宝石属性[sx[i]]
				break
			end
		end
	end
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
	self:刷新信息()
end

function 内存类_宝宝:卸下装备(装备,格子)
	local sx={"速度","躲避","伤害","灵力","防御","气血"}
	if 装备 and 装备.宝石属性 then
		for i=1,#sx do
			if 装备.宝石属性[sx[i]]~=nil then
				self.装备属性[sx[i]] = self.装备属性[sx[i]] - 装备.宝石属性[sx[i]]
				break
			end
		end
	end
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
	self.装备[格子] = nil
	self:刷新信息()
end

function 内存类_宝宝:重置五行(wx)
	self.五行 = wx
	self:刷新信息("1")
end

function 内存类_宝宝:重置等级(等级)
	local 属性范围={"体质","力量","敏捷","耐力","魔力"}
	if self.种类=="野怪" then

	else
		self.潜力=0
		local 总属性 = 0
		for n=1,5 do
			self[属性范围[n]]=等级+20
		end
		总属性= 等级*5
		if self.进阶~= nil and self.进阶.灵性~= nil then
			总属性 = 总属性 + self.进阶.灵性 * 2
		end
		self.潜力=self.潜力+总属性
		self.等级=等级
		self:刷新信息("1")
	end
end

function 内存类_宝宝:升级()
	self.等级 = self.等级 + 1
	self.体质 = self.体质 + 1
	self.魔力 = self.魔力 + 1
	self.力量 = self.力量 + 1
	self.耐力 = self.耐力 + 1
	self.敏捷 = self.敏捷 + 1
	self.潜力 = self.潜力 + 5
	self.当前经验 = self.当前经验 - self.最大经验
	if self.进阶 ~= nil then
		if self.进阶.特性 == "力破" then --跟随等级提升的属性
			self.进阶.特性属性[2] = self.进阶.特性属性[2] + 1
		elseif self.进阶.特性 == "怒吼" then --跟随等级提升的属性
			self.进阶.特性属性[1] = self.进阶.特性属性[1] + 1
		end
	end
	if self.元宵~=nil then
		local num=qz(self.等级/20+1)
		self.元宵.千金露=num-self.元宵.千金露使用
		if self.元宵.千金露<=0 then
			self.元宵.千金露=0
		end
	end
	self:刷新信息("1")
end

function 内存类_宝宝:降级(级数)
	local 扣除潜力,扣除五维 = 级数*5,级数
	self.等级 = self.等级 - 级数
	if self.进阶 ~= nil then
		if self.进阶.特性 == "力破" then --跟随等级提升的属性
			self.进阶.特性属性[2] = self.进阶.特性属性[2] - 级数
		elseif self.进阶.特性 == "怒吼" then --跟随等级提升的属性
			self.进阶.特性属性[1] = self.进阶.特性属性[1] - 级数
		end
	end
	if self.元宵~=nil then
		local num=qz(self.等级/20+1)
		self.元宵.千金露=num
		if self.元宵.千金露<=0 then
			self.元宵.千金露=0
		end
	end
	if self.潜力>=扣除潜力 then
		self.潜力 = self.潜力-扣除潜力
		self.体质 = self.体质-扣除五维
		self.魔力 = self.魔力-扣除五维
		self.力量 = self.力量-扣除五维
		self.耐力 = self.耐力-扣除五维
		self.敏捷 = self.敏捷-扣除五维
	else
		local lsb = {
			{数值=self.体质,五维="体质"},
			{数值=self.魔力,五维="魔力"},
			{数值=self.力量,五维="力量"},
			{数值=self.耐力,五维="耐力"},
			{数值=self.敏捷,五维="敏捷"}
		}
		table.sort(lsb,function(a,b) return a.数值>b.数值 end )
		for i=1,#lsb do
			if i == 1 then
				self[lsb[i].五维] = self[lsb[i].五维] -扣除潜力-扣除五维
			else
					self[lsb[i].五维] = self[lsb[i].五维] -扣除五维
			end
		end
	end
	self:刷新信息("1")
end

function 内存类_宝宝:添加技能(名称)
	local jn = jnsss()
	jn:置对象(名称)
	self.技能[#self.技能+1] = jn
end

function 内存类_宝宝:替换技能(名称)
	local jn = jnsss()
	jn:置对象(名称)
	self.技能[random(1,#self.技能)] = jn
end

function 内存类_宝宝:取指定技能(名称)
	for n=1,#self.技能 do
		if self.技能[n]==名称 then
			return true
		end
	end
	return false
end

function 内存类_宝宝:特性五维影响()
	self.特性五维={
		力量 = 0,
		敏捷 = 0,
		耐力 = 0,
		魔力 = 0,
		体质 = 0,
	}
	local jd = 0

	if self.进阶 ~= nil and self.进阶.开启 and self.进阶.特性 ~= "无" then --全属性降低
		local biao = {"自恋","预知","灵动","识物","洞察","乖巧"} --"力破", --全属性降低
		for i=1,#biao do
			if self.进阶.特性 ==biao[i] then
				jd = self.进阶.特性属性[2]

				break
			end
		end

		if jd==nil then jd=0 end
		self.特性五维={
			力量 = -jd,
			敏捷 = -jd,
			耐力 = -jd,
			魔力 = -jd,
			体质 = -jd,
		}
	end
end

function 内存类_宝宝:重置野怪属性()
	self.体质=self.等级+10
	self.魔力=self.等级+10
	self.力量=self.等级+10
	self.耐力=self.等级+10
	self.敏捷=self.等级+10
	self.潜力=self.等级*5
	self.yeguai=true
end

function 内存类_宝宝:如意丹洗点(属性)
	self[属性]=self[属性]-1
	self.潜力=self.潜力+1
	if self.元宵 then
		self.元宵.如意丹=self.元宵.如意丹-1
	end
	self:刷新信息("1")
end

function 内存类_宝宝:取经验(id,lv)
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

return 内存类_宝宝