-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:44
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-04-12 03:13:01
-- @Author: baidwwy
-- @Date:   2024-05-23 06:02:27
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-06-26 13:37:24
-- @Author: baidwwy
-- @Date:   2024-04-14 22:24:27
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-05-23 23:39:54
-- @Author: baidwwy
-- @Date:   2024-03-05 15:36:07
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-04-20 17:34:26
-- @Author: baidwwy
-- @Date:   2023-09-12 12:17:35
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-03-12 16:52:28
--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-09-01 19:17:48
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
local 召唤兽处理类 = class()
local 资质范围={"攻击资质","法力资质","体力资质","防御资质","速度资质","躲闪资质",}
local 属性范围={"力量","魔力","敏捷","体质","耐力"}
local random = math.random
function 召唤兽处理类:初始化(id,数字id)
	self.玩家id=数字id
	self.数据={}
end

function 召唤兽处理类:加载数据(账号,数字id)
	self.数字id=数字id
	self.临时数据=table.loadstring(读入文件(程序目录..[[data/]]..账号..[[/]]..数字id..[[/召唤兽.txt]]))
	for i=1,#self.临时数据 do
		self.数据[i]=宝宝类.创建()
		self.数据[i]:加载数据(self.临时数据[i])
		if self.数据[i].攻击资质==0 or self.数据[i].防御资质==0 then
			local 模型=self.数据[i].模型
			local 种类=self.数据[i].种类
			local 名称=self.数据[i].名称
			local 等级=self.数据[i].等级
			self.数据[i]:置新对象(模型,名称,类型,属性,等级,染色方案,技能组,资质组,成长,参战等级,属性表)
			self.数据[i].认证码=self.玩家id.."_"..os.time().."_"..取随机数(111111,9999999)
			if 等级~=nil and 等级~=0 then
				self.数据[i]:重置等级(等级)
			end
		end
		if self.数据[i].认证码 == nil then
			self.数据[i].认证码=self.玩家id.."_"..os.time().."_"..取随机数(111111,9999999)
		else
			local ls1 = 分割文本(self.数据[i].认证码,"_")
			if ls1[1]+0 ~= self.玩家id then
				self.数据[i].认证码=self.玩家id.."_"..os.time().."_"..取随机数(111111,9999999)
			end
		end
		self.数据[i].参战信息=nil
		if self.数据[i].认证码==玩家数据[数字id].角色.参战宝宝.认证码 then
			玩家数据[数字id].角色.参战宝宝={}
			玩家数据[数字id].角色.参战宝宝=table.copy((self.数据[i]:取存档数据()))
			玩家数据[数字id].角色.参战信息=1
			self.数据[i].参战信息=1
		end
		if self.数据[i].转生 ~= nil then
			if type(self.数据[i].转生) ~= "table" then
				self.数据[i].转生 = {次数=2,打书=false}
			end
		end
		if self.数据[i].元宵==nil then
		    self.数据[i].元宵={可用=0,炼兽真经=0,水晶糕=0,如意丹=1000,千金露=lv,千金露使用=0,元宵时间=0,真经时间=0,进化次数=0}
		elseif self.数据[i].元宵.进化次数==nil then
			self.数据[i].元宵.进化次数 = 0
		end
		if self.数据[i].丸子技能 == nil then
			self.数据[i].丸子技能={}
		end
		self.数据[i]:刷新信息()
	end
	self:重置丸子技能() --超级技能
end

function 召唤兽处理类:重置丸子技能()
	for k,v in pairs(self.数据) do
		if v.丸子技能 ~= nil then
			for kn,vn in pairs(v.丸子技能) do
				vn.有此技能 = false
				vn.生效=true
				for kna,knb in pairs(v.技能) do
					local gjjn="高级" ..vn.名称
					if vn.名称 == knb or gjjn == knb then
						vn.有此技能 = true
					end
				end
			end
		end
	end
end

function 召唤兽处理类:保存赐福技能(连接id,id,bbbh,认证码,锁定,技能)
	if self.数据[bbbh] == nil or  self.数据[bbbh].认证码~=认证码 then 常规提示(id,"召唤兽数据有误,请重新打开界面") return end
	if type(技能)~="table" or 技能[1]==nil then 常规提示(id,"召唤兽数据有误,请重新打开界面") return end --防错
	local kbc={}
	local tsjn={}
	self.数据[bbbh].丸子技能={}
	for n=1,4 do
		local qmc=""
		if 技能[n].名称 then
			qmc=技能[n].名称
		else
		    qmc=技能[n]
		end
        kbc[n]={有此技能=false,生效=true,名称=qmc}
        tsjn[n] = kbc[n].名称 .."、"
	end
	self.数据[bbbh].丸子技能={}
	self.数据[bbbh].丸子技能=table.copy(kbc)
	self:重置丸子技能()
	常规提示(id,"保存赐福技能#R/" ..tsjn[1] ..tsjn[2] ..tsjn[3] ..tsjn[4] .."#Y/成功")
	发送数据(连接id,16,self.数据)
	发送数据(连接id,383)
end

function 召唤兽处理类:数据处理(连接id,序号,id,内容)
	if 玩家数据[id].摊位数据~=nil and 序号~=5001 then
		常规提示(id,"#Y/摆摊状态下禁止此种行为")
		return
	end
	if 序号==5001 then
		发送数据(连接id,17,self.数据)
	elseif 序号==5002 then
		self:参战处理(连接id,序号,id,内容.序列)
	elseif 序号==5003 then
		self:改名处理(连接id,序号,id,内容.序列,内容.名称)
	elseif 序号==5004 then
		self:加点处理(连接id,序号,id,内容)
	elseif 序号==5005 then
		self:放生处理(连接id,序号,id,内容)
	elseif 序号==5006 then
		发送数据(连接id,22,玩家数据[id].角色.宠物)
	elseif 序号==5007 then --
		发送数据(连接id,16,self.数据)
		local lssj = 玩家数据[id].道具:索要道具2(id)
		if 内容.类型=="炼化" or 内容.类型=="洗练" then
		发送数据(连接id,23,{道具=lssj.道具})
	elseif 内容.类型=="合宠" then
		发送数据(连接id,64,{道具=lssj.道具})
	elseif 内容.类型=="打书" or 内容.类型=="内丹" then
		发送数据(连接id,65,{道具=lssj.道具,类型=内容.类型})
		end
	elseif 序号==5008 then
		self:洗练处理(连接id,序号,id,内容)
	elseif 序号==5009 then
		self:合宠处理(连接id,序号,id,内容)
	elseif 序号==5009.1 then
		self:合宠引所数据处理(连接id,序号,id,内容)
	elseif 序号==5010 then
		self:炼化处理(连接id,序号,id,内容)
	elseif 序号==5011 then
		self:内丹处理(连接id,序号,id,内容)
	elseif 序号==5012 then
		self:法术认证(连接id,序号,id,内容)
	elseif 序号==5013 then
		self:自定义神兽造型(连接id,id,内容)
	elseif 序号==5014 then
		self:内丹升级处理(连接id,序号,id,内容)
	elseif 序号==5015 then
		self:召唤兽染色(连接id,序号,id,内容)
	-- elseif 序号==5015 then
	-- 	if 内容.序列 > #玩家数据[id].角色.召唤兽仓库 then
	-- 		常规提示(id,"#Y/这已经是最后一页了")
	-- 		return
	-- 	elseif 内容.序列<1 then
	-- 		return
	-- 	end
	-- 	发送数据(玩家数据[id].连接id,3524,{召唤兽仓库数据=玩家数据[id].角色.召唤兽仓库[内容.序列],页数=内容.序列,宝宝列表=self.数据})
	elseif 序号==5016 then
		self:进阶属性(连接id,id,内容)
	elseif 序号==5017 then
		self:特性开关(连接id,id,内容)
	-- elseif 序号==5018 then --索取召唤兽仓库信息
	-- 	发送数据(连接id,3526,{召唤兽仓库总数=#玩家数据[id].角色.召唤兽仓库,召唤兽仓库数据=玩家数据[id].角色.召唤兽仓库[1]})
	-- 	发送数据(连接id,3534,{宝宝列表=self.数据})
	elseif 序号==5019 then
		self:卸下饰品(连接id,id,内容)
	elseif 序号==5039 then
        self:wst召唤兽商店购买(连接id,id,内容)
	end
end

function 召唤兽处理类:wst召唤兽商店购买(连接id,数字id,内容) --武神坛
	if not 玩家数据[数字id].角色:取新增宝宝数量() then
		发送数据(玩家数据[数字id].连接id, 7, "#y/您当前无法携带更多的召唤兽了！")
		return false
	end
	local 选中 = 内容.选中 + 0
	local wj账号
  	if 玩家数据[数字id].账号 ~= nil then
  		wj账号 = 玩家数据[数字id].账号
  	elseif 玩家数据[数字id].角色.账号 ~= nil then
  	  wj账号 = 玩家数据[数字id].角色.账号
  	end
  	if wj账号 then
  		local 临时bb = 武神坛数据[wj账号]:取wst召唤兽商店()
  		if 临时bb[选中]~=nil then
			self.数据[#self.数据+1]=宝宝类.创建()
			self.数据[#self.数据]:置新对象(临时bb[选中].名称,临时bb[选中].名称,"神兽",nil,0,nil,临时bb[选中].技能,临时bb[选中].资质,临时bb[选中].资质[8],0)--:bb置新dx(名称,名称,"神兽",属性,0,染色方案,技能组,资质组,成长,参战等级,属性表,物法,dingzhi)
			self.数据[#self.数据].认证码=数字id.."_"..os.time().."_"..取随机数(111111,9999999)
			常规提示(数字id,"#Y你获得了一只#G"..临时bb[选中].名称)
			local lv=0
			lv=qz(lv/20+1)
			self.数据[#self.数据].内丹={可用内丹=6,内丹上限=6}
			self.数据[#self.数据].元宵={可用=0,炼兽真经=0,水晶糕=0,如意丹=1000,千金露=lv,千金露使用=0,元宵时间=0,真经时间=0}
			local txsx,txsy=宝宝特性属性(self.数据[#self.数据].等级,"复仇")
			--self.数据[#self.数据].进阶={开启=true,特性="复仇",清灵仙露=0,特性属性={txsx,txsy},灵性=110}
			self.数据[#self.数据].进阶 ={清灵仙露=0,灵性=0,特性="无",特性属性={},开启=false}
			self.数据[#self.数据].打书次数=0
			self:当前图排序(#self.数据)
			发送数据(玩家数据[数字id].连接id,16,self.数据)
			self.数据[#self.数据].专用=数字id
		end
	end
end

function 召唤兽处理类:自定义神兽造型(连接id,id,内容)
	local 新造型 = 内容.文本
	local 是否=取宝宝(新造型)
	if not 是否 or 判断是否为空表(是否) then
		常规提示(id,"#Y/没有该宠物造型哦。")
		return
	elseif 玩家数据[id].角色.参战信息==nil then
		添加最后对话(id,"请将需要自定义的宝宝参战！")
		return
	end
	local 编号=self:取编号(玩家数据[id].角色.参战宝宝.认证码)
	if 编号~=0 and 玩家数据[id].召唤兽.数据[编号] and self.数据[编号] then
		if self.数据[编号].种类=="超级神鸡" then
			添加最后对话(id,"超级神鸡，无法更改造型！")
			return
		end

		if self.数据[编号].饰品~=nil then
			添加最后对话(id,"请先卸下召唤兽饰品！")
			return
		elseif self.数据[编号].模型==新造型 then
			添加最后对话(id,"请仔细检查输入是否正确")
			return
		end
		if 玩家数据[id].角色:扣除银子(10000000,0,0,"自定义神兽造型") then
			if self.数据[编号].原造型==nil then
				self.数据[编号].原造型=self.数据[编号].模型
			end
			self.数据[编号].模型=新造型
			常规提示(id,"#Y/一道金光闪过，你的宝宝幻化成了一只"..新造型)
		end
	end
end

function 召唤兽处理类:卸下饰品(连接id,id,内容)
	local 认证码 = 内容[1]
	local 编号=self:取编号(认证码)
	if 编号~=0 then
		if self.数据[编号].饰品~=nil then
			self.数据[编号].饰品=nil
			self.数据[编号].饰品颜色=nil
			玩家数据[id].道具:给予道具(id,self.数据[编号].模型.."饰品")
			常规提示(id,"饰品卸下成功！")
			发送数据(连接id,6556,self.数据[编号])
		else
			常规提示(id,"该召唤兽没有饰品，无法卸下！")
		end
	end
end

function 召唤兽处理类:特性开关(连接id,id,内容)
	local 认证码 = 内容.认证码
	local 编号=self:取编号(认证码)
	if 编号~=0 then
		if self.数据[编号].进阶 and self.数据[编号].进阶.特性~="无" then
			self.数据[编号].进阶.开启 = not self.数据[编号].进阶.开启
			self.数据[编号]:刷新信息()
			发送数据(连接id,16,self.数据)
			发送数据(连接id,112,self.数据[编号].进阶.开启)
		end
	end
end

function 召唤兽处理类:进阶属性(连接id,id,内容)
	local 认证码 = 内容.认证码
	local 保留 = 内容.保留
	local 编号=self:取编号(认证码)
	if 编号~=0 and 玩家数据[id].角色.参战宝宝.认证码 == 认证码 and self.数据[编号].认证码== 认证码 then
		if self.数据[编号].进阶 and self.数据[编号].进阶.灵性==110 then
			if 保留=="新" then
				self.数据[编号].进阶属性=self.数据[编号].临时进阶
			end
			self.数据[编号].临时进阶=nil
		else
			常规提示(id,"#Y/提升召唤兽能力需灵性达到110")
		end
	else
		常规提示(id,"#Y/请将需要进阶的宝宝参战！")
	end
	self.数据[编号]:刷新信息()
	发送数据(连接id,16,self.数据)
	发送数据(连接id,111,self.数据[编号])
end

function 召唤兽处理类:定制神兽(名称,技能组,玩家id) --事件=="物理型（单点爆伤）" or 事件=="法术型（秒伤）"
	if not 玩家数据[self.玩家id].角色:取新增宝宝数量() then
		发送数据(玩家数据[self.玩家id].连接id, 7, "#y/您当前无法携带更多的召唤兽了！！")
		return false
	end
	self.数据[#self.数据+1]=宝宝类.创建()
	self.数据[#self.数据]:置新对象(名称,名称,"定制神兽",nil,0,染色方案,技能组)
	self.数据[#self.数据].认证码=self.玩家id.."_"..os.time().."_"..取随机数(111111,9999999)
	常规提示(self.玩家id,"#Y你获得了一只#G"..名称)
	local lv=0
	lv=qz(lv/20+1)
	self.数据[#self.数据].元宵={可用=0,炼兽真经=0,水晶糕=0,如意丹=1000,千金露=lv,千金露使用=0,元宵时间=0,真经时间=0,进化次数=0}
	self.数据[#self.数据].打书次数=0
	self:当前图排序(#self.数据)
	发送数据(玩家数据[self.玩家id].连接id,16,self.数据)
	if RpbARGB.序列==2 then
	   if self.数据[#self.数据].模型=="超级鲲鹏" then
		self.数据[#self.数据].专用=self.玩家id
	end
	end
end

function 召唤兽处理类:添加神兽(名称,物法,dingzhi,超链接) --事件=="物理型（单点爆伤）" or 事件=="法术型（秒伤）"
	if not 玩家数据[self.玩家id].角色:取新增宝宝数量() then
		发送数据(玩家数据[self.玩家id].连接id, 7, "#y/您当前无法携带更多的召唤兽了呀")
		return false
	end
	self.数据[#self.数据+1]=宝宝类.创建()
	self.数据[#self.数据]:置新对象(名称,名称,"神兽",属性,0,染色方案,技能组,资质组,成长,参战等级,属性表,物法,dingzhi)
	self.数据[#self.数据].认证码=self.玩家id.."_"..os.time().."_"..取随机数(111111,9999999)
	常规提示(self.玩家id,"#Y你获得了一只#G"..名称)
	local lv=0
	lv=qz(lv/20+1)
	self.数据[#self.数据].元宵={可用=0,炼兽真经=0,水晶糕=0,如意丹=1000,千金露=lv,千金露使用=0,元宵时间=0,真经时间=0,进化次数=0}
	self.数据[#self.数据].打书次数=0
	self:当前图排序(#self.数据)
	发送数据(玩家数据[self.玩家id].连接id,16,self.数据)
	if 超链接 then
		local 文本 = 超链接.提示.."#P/qqq|"..self.数据[#self.数据].名称.."*"..self.数据[#self.数据].认证码.."*".."召唤兽".."/["..self.数据[#self.数据].名称.."]#W"..超链接.结尾
		local fs={}
		fs[#fs+1] = self.数据[#self.数据]
		fs[#fs].索引类型 = "召唤兽"
		广播消息({内容=文本,频道=超链接.频道,方式=1,超链接=fs})
	end
	if RpbARGB.序列==2 then
	   if self.数据[#self.数据].模型=="超级鲲鹏" then
		self.数据[#self.数据].专用=self.玩家id
	end
	end
end

function 召唤兽处理类:添加召唤兽(模型,名称,类型,属性,等级,染色方案,技能组,资质组,成长,参战等级,属性表,内丹数量,数据,消费,消费方式,消费内容)
	if not 玩家数据[self.玩家id].角色:取新增宝宝数量() then
		发送数据(玩家数据[self.玩家id].连接id, 7, "#y/您当前无法携带更多的召唤兽了呀！")
		return false
	end
	if 消费方式 ~= nil and 消费 then
		if 消费<1 then
			print("玩家id  "..self.玩家id.."   商城购买宝宝存在作弊行为！")
			return false
		end
		消费=qz(消费)
		if not 玩家数据[self.玩家id].角色:扣除银子(消费,0,0,消费内容,1) then
			常规提示(self.玩家id,"你没有那么多的银子")
			return false
		end
			常规提示(self.玩家id,"#Y/您花费了#G/" .. 消费 .. "#Y/两银子购买了1只#G/" ..数据.模型)
	end
	self.数据[#self.数据+1]=宝宝类.创建()
	if 数据 == nil then
		self.数据[#self.数据]:置新对象(模型,名称,类型,属性,等级,染色方案,技能组,资质组,成长,参战等级,属性表)
		self.数据[#self.数据].认证码=self.玩家id.."_"..os.time().."_"..取随机数(111111,9999999)
		self.数据[#self.数据].内丹={可用内丹=取内丹数量(self.数据[#self.数据].参战等级),内丹上限=取内丹数量(self.数据[#self.数据].参战等级)}
		if 等级~=nil and 等级~=0  then--and 类型~="野怪"
			self.数据[#self.数据]:重置等级(等级)
		end
	else --商城购买
		self.数据[#self.数据]:加载数据(数据)
		self.数据[#self.数据].内丹={可用内丹=取内丹数量(self.数据[#self.数据].参战等级),内丹上限=取内丹数量(self.数据[#self.数据].参战等级)}
		self.数据[#self.数据].认证码=self.玩家id.."_"..os.time().."_"..取随机数(111111,9999999)
	end
	local lv=0
	if 等级~=nil and 等级~=0 then
		lv=等级
	end
	lv=qz(lv/20+1)
	self.数据[#self.数据].元宵={可用=10,炼兽真经=5,水晶糕=20,如意丹=1000,千金露=lv,千金露使用=0,元宵时间=0,真经时间=0,进化次数=0}
	self.数据[#self.数据].打书次数=0
	self:当前图排序(#self.数据)
	发送数据(玩家数据[self.玩家id].连接id,16,self.数据)
	return true
end


function 召唤兽处理类:添加商城仙玉召唤兽(模型,名称,类型,属性,等级,染色方案,技能组,资质组,成长,参战等级,属性表,内丹数量,数据,消费,消费方式,消费内容)
	if not 玩家数据[self.玩家id].角色:取新增宝宝数量() then
		发送数据(玩家数据[self.玩家id].连接id, 7, "#y/您当前无法携带更多的召唤兽了...")
		return false
	end
	if 消费方式 ~= nil and 消费 then
		if 消费<1 then
			print("玩家id  "..self.玩家id.."   商城购买宝宝存在作弊行为！")
			return false
		end
		消费=qz(消费)
		if not 玩家数据[self.玩家id].角色:扣除仙玉(消费,0,0,消费内容,1) then
			-- 常规提示(self.玩家id,"你没有那么多仙玉哦")
			return false
		end
			常规提示(self.玩家id,"#Y/您花费了#G/" .. 消费 .. "#Y/两仙玉购买了1只#G/" ..数据.模型)
	end
	self.数据[#self.数据+1]=宝宝类.创建()
	if 数据 == nil then
		self.数据[#self.数据]:置新对象(模型,名称,类型,属性,等级,染色方案,技能组,资质组,成长,参战等级,属性表)
		self.数据[#self.数据].认证码=self.玩家id.."_"..os.time().."_"..取随机数(111111,9999999)
		self.数据[#self.数据].内丹={可用内丹=取内丹数量(self.数据[#self.数据].参战等级),内丹上限=取内丹数量(self.数据[#self.数据].参战等级)}
		if 等级~=nil and 等级~=0  then--and 类型~="野怪"
			self.数据[#self.数据]:重置等级(等级)
		end
	else --商城购买
		self.数据[#self.数据]:加载数据(数据)
		self.数据[#self.数据].内丹={可用内丹=取内丹数量(self.数据[#self.数据].参战等级),内丹上限=取内丹数量(self.数据[#self.数据].参战等级)}
		self.数据[#self.数据].认证码=self.玩家id.."_"..os.time().."_"..取随机数(111111,9999999)
	end
	local lv=0
	if 等级~=nil and 等级~=0 then
		lv=等级
	end
	lv=qz(lv/20+1)
	self.数据[#self.数据].元宵={可用=10,炼兽真经=5,水晶糕=20,如意丹=1000,千金露=lv,千金露使用=0,元宵时间=0,真经时间=0,进化次数=0}
	self.数据[#self.数据].打书次数=0
	self:当前图排序(#self.数据)
	发送数据(玩家数据[self.玩家id].连接id,16,self.数据)
	return true
end




function 召唤兽处理类:添加召唤兽1(模型,名称,类型,属性,等级,染色方案,技能组,资质组,成长,参战等级,属性表,内丹数量,属性,消费,消费方式,消费内容)
	if not 玩家数据[self.玩家id].角色:取新增宝宝数量() then
		发送数据(玩家数据[self.玩家id].连接id, 7, "#y/您当前无法携带更多的召唤兽了哦！")
		return false
	end
	self.数据[#self.数据+1]=宝宝类.创建()
	if 属性 == nil then
		self.数据[#self.数据]:置新对象(模型,名称,类型,属性,等级,染色方案,技能组,资质组,成长,参战等级,属性表)

		self.数据[#self.数据].认证码=self.玩家id.."_"..os.time().."_"..取随机数(111111,9999999)
		self.数据[#self.数据].内丹={可用内丹=取内丹数量(self.数据[#self.数据].参战等级),内丹上限=取内丹数量(self.数据[#self.数据].参战等级)}
		if 等级~=nil and 等级~=0  then--and 类型~="野怪"
			self.数据[#self.数据]:重置等级(等级)
		end
	else --商城购买
		self.数据[#self.数据]:加载数据(属性)
		self.数据[#self.数据].内丹={可用内丹=取内丹数量(self.数据[#self.数据].参战等级),内丹上限=取内丹数量(self.数据[#self.数据].参战等级)}
		self.数据[#self.数据].认证码=self.玩家id.."_"..os.time().."_"..取随机数(111111,9999999)
	end
	local lv=0
	if 等级~=nil and 等级~=0 then
		lv=等级
	end
	lv=qz(lv/20+1)
	self.数据[#self.数据].元宵={可用=10,炼兽真经=5,水晶糕=20,如意丹=1000,千金露=lv,千金露使用=0,元宵时间=0,真经时间=0,进化次数=0}
	self.数据[#self.数据].打书次数=0
	self:当前图排序(#self.数据)
	self.数据[#self.数据].专用=true
	self.数据[#self.数据]:重置等级(0,#self.数据)
	发送数据(玩家数据[self.玩家id].连接id,16,self.数据)
	return true
end


function 召唤兽处理类:取存档数据()
	self.返回数据={}
	for n, v in pairs(self.数据) do
		if self.数据[n] then
			if self.数据[n].认证码 == nil then
				self.数据[n].认证码=self.玩家id.."_"..os.time().."_"..取随机数(111111,9999999)
			else
				local ls1 = 分割文本(self.数据[n].认证码,"_")
				if ls1[1]+0 ~= self.玩家id then
					self.数据[n].认证码=self.玩家id.."_"..os.time().."_"..取随机数(111111,9999999)
				end
			end
			self.返回数据[n]=table.copy((self.数据[n]))
		end
	end
	return self.返回数据
end

function 召唤兽处理类:召唤兽染色(连接id,序号,id,内容)
	if 玩家数据[id].角色:扣除银子(5000000,0,0,"购买银两",1) then
		local 编号=self:取编号(内容.序列)
		if self.数据[编号].染色方案==nil then
			self.数据[编号].染色方案=0
		end
		if self.数据[编号].染色组==nil then
			self.数据[编号].染色组={}
		end
		self.数据[编号].染色方案 = 内容.序列1
		self.数据[编号].染色组={}
		self.数据[编号].染色组[1] = 内容.序列2
		self.数据[编号].染色组[2] = 内容.序列3
		self.数据[编号].染色组[3] = 内容.序列4
		if 调试模式 then
		end
		添加最后对话(id,"染色成功！换个颜色换个心情#3")
		发送数据(连接id,20,self.数据[编号]:取存档数据())
	end
end

function 召唤兽处理类:放生处理(连接id,序号,id,点数)
	local 临时编号=self:取编号(点数.序列)
	if 临时编号==0 then
		常规提示(id,"你没有这只召唤兽")
		return
	else--先判断是否有bb装备
		if self.数据[临时编号].统御属性 then
			常规提示(id,"统御中的宝宝无法放生~~")
			return
		end
		table.remove(self.数据,临时编号) --先抹去参战信息
		if 点数.序列==玩家数据[id].角色.参战宝宝.认证码 then
			玩家数据[id].角色.参战宝宝={}
			发送数据(连接id,18,玩家数据[id].角色.参战宝宝)
		end
		常规提示(id,"你的这只召唤兽从你的眼前消失了~~")
		发送数据(连接id,21,临时编号)
	end
end

function 召唤兽处理类:飞升降级()
	local 编号 = self:取编号(玩家数据[self.玩家id].角色.参战宝宝.认证码)
	if self.数据[编号].认证码==玩家数据[self.玩家id].角色.参战宝宝.认证码 then
		if self.数据[编号].等级 >玩家数据[self.玩家id].角色.等级+10 then
			self.数据[编号]:降级(self.数据[编号].等级-玩家数据[self.玩家id].角色.等级-10)
		end
	end
end

function 召唤兽处理类:删除处理(id,临时编号)
	if 临时编号==0 then
		常规提示(id,"你没有这只召唤兽")
		return false
	else--先判断是否有bb装备
		if self.数据[临时编号].认证码==玩家数据[id].角色.参战宝宝.认证码 then
			玩家数据[id].角色.参战宝宝={}
			发送数据(玩家数据[id].连接id,18,玩家数据[id].角色.参战宝宝)
		end
		table.remove(self.数据,临时编号)--先抹去参战信息
		发送数据(玩家数据[id].连接id,45,临时编号)
	end
	return true
end

function 召唤兽处理类:是否有装备(编号)
	if self.数据[编号]==nil then
		return false
	end
	for n=1,3 do
		if  self.数据[编号].装备[n]~=nil then
			return true
		end
	end
	return false
end

function 召唤兽处理类:取气血差()
	local 数值=0
	for n=1,#self.数据 do
		数值=数值+(self.数据[n].最大气血-self.数据[n].气血)
	end
	return 数值
end

function 召唤兽处理类:取魔法差()
	local 数值=0
	for n=1,#self.数据 do
		数值=数值+(self.数据[n].最大魔法-self.数据[n].魔法)
	end
	return 数值
end

function 召唤兽处理类:取忠诚差()
	local 数值=0
	for n=1,#self.数据 do
		if self.数据[n].忠诚<100 then
			数值=数值+(100-self.数据[n].忠诚)
		end
	end
	return 数值
end
-------------------合宠处理------------------
-- function 召唤兽处理类:合宠处理(连接id,序号,id,内容)
-- 	local bb1=内容.序列
-- 	local bb2=内容.序列1
-- 	local 道具格子=内容.合宠材料.道具格子
-- 	local 材料数量=1
-- 	local 技能最大数量=24
-- 	-- print(玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]].名称)--名称
-- 	-- print(玩家数据[id].角色.道具[道具格子])--=53
-- 	local 随机模型=""
-- 	if self.数据[bb1]==nil or self.数据[bb2]==nil then
-- 		return
-- 	elseif self.数据[bb1].认证码==self.数据[bb2].认证码 then
-- 		常规提示(id,"同一只召唤兽怎么合成呢？")
-- 		return
-- 	elseif self.数据[bb1].等级<30 or self.数据[bb2].等级<30 then
-- 		常规提示(id,"要炼妖的召唤兽等级未达到30级!")
-- 		return
-- 	elseif self.数据[bb1].种类=="神兽" or self.数据[bb2].种类=="神兽" then
-- 		常规提示(id,"神兽不可进行此操作")
-- 		return
-- 	elseif self.数据[bb1].种类=="变异" or self.数据[bb2].种类=="变异" then
-- 		if RpbARGB.序列~=3 then
-- 			常规提示(id,"变异宝宝不可进行此操作")
-- 			return
-- 		end
-- 	elseif 玩家数据[id].角色.参战信息~=nil then --玩家数据[id].角色.参战信息~=nil or
-- 		常规提示(id,"请先取消所有召唤兽的参战状态")
-- 		return
-- 	elseif self:是否有装备(bb1) or self:是否有装备(bb2) then
-- 		常规提示(id,"请先卸下召唤兽所穿戴的装备")
-- 		return
-- 	elseif self.数据[bb1].进阶 or self.数据[bb2].进阶 then
-- 		常规提示(id,"进阶的召唤兽无法进行此操作")
-- 		return
-- 	 elseif self.数据[bb1].专用 or self.数据[bb2].专用 then
-- 		常规提示(id,"专用的召唤兽无法进行此操作")
-- 		return
-- 	else
-- 		--检查装备 等级
-- 		随机模型=self.数据[bb1].模型
-- 		local 随机数值=取随机数()
-- 		local 特殊合宠=false
-- 		if 随机数值<=1 then      --小于1是泡泡
-- 			特殊合宠=true
-- 			随机模型="泡泡"
-- 		elseif 随机数值<=2 then  --1-2是大海龟
-- 			特殊合宠=true
-- 			随机模型="大海龟"
-- 		elseif 随机数值<=50 then
-- 			随机模型=self.数据[bb2].模型   --2-50之间执行这里
-- 		else
-- 			随机模型=self.数据[bb1].模型   --大于50执行这里
-- 		end
-- 		if 特殊合宠 then
-- 			self.数据[bb1]:置新对象(随机模型,随机模型,"宝宝",属性,0,染色方案,技能组,资质组,成长,参战等级,属性表)
-- 		else
-- 			if 道具格子~=nil then
-- 				if  玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]] and 玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]].数量~=nil then
-- 					材料数量=玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]].数量
-- 					if 材料数量>10 then--神兜兜
-- 						材料数量=1000--神兜兜数量
-- 					end
-- 				end
-- 			end

-- 			self.数据[bb1].模型=随机模型
-- 			local pj = 0
-- 			for n=1,#资质范围 do
-- 				pj = math.floor((self.数据[bb1][资质范围[n]]+self.数据[bb2][资质范围[n]])/2)
-- 				if 道具格子~=nil and 材料数量>1 then
-- 					self.数据[bb1][资质范围[n]] = math.floor(取随机数(pj*950,pj*1050)/1000 * (1+材料数量/1000)   )
-- 				else
-- 					self.数据[bb1][资质范围[n]] = math.floor(取随机数(pj*950,pj*1050)/1000)
-- 				end
-- 			end
-- 			--计算成长
-- 			pj = string.format("%.3f", (self.数据[bb1].成长 + self.数据[bb2].成长)/2)
-- 			if 道具格子~=nil and 材料数量>1 then
-- 				self.数据[bb1].成长=GetPreciseDecimal(取随机小数2(pj*960* (1+材料数量/10000) , pj*1020)/1000* (1+材料数量/10000) ,3)
-- 			else
-- 				self.数据[bb1].成长=GetPreciseDecimal(取随机小数2(pj*960,pj*1020)/1000,3)
-- 			end
-- 			if self.数据[bb1].成长>=1.3 then
-- 				self.数据[bb1].成长=1.3
-- 			end
-- 			--计算技能
-- 			local 技能表={}
-- 			local bd =  取宝宝(随机模型,"宝宝")
-- 			if bd[10] then
-- 				for i=1,#bd[10] do
-- 					技能表[#技能表+1]=bd[10][i]
-- 				end
-- 			end
-- 			for n=1,#self.数据[bb2].技能 do
-- 				技能表[#技能表+1]=self.数据[bb2].技能[n]
-- 			end
-- 			for n=1,#self.数据[bb1].技能 do
-- 				技能表[#技能表+1]=self.数据[bb1].技能[n]
-- 			end
-- 			技能表=删除重复(技能表)
-- 			for n=1,#技能表 do
-- 				技能表[n]={名称=技能表[n],排列=取随机数(1,10000)}
-- 			end
-- 			table.sort(技能表,function(a,b) return a.排列>b.排列 end )
-- 			local 技能保底数=1
-- 			if #技能表>=2 then
-- 				 技能保底数=math.floor(#技能表/2)
-- 			end
-- 			local 技能总数=取随机数(技能保底数,#技能表)
-- 			if 技能总数>24 then 技能总数=24 end
-- 			self.数据[bb1].技能={}
-- 			if 技能表~={} then

-- 				for n=1,技能总数 do
-- 					local 成功几率=100-#self.数据[bb1].技能*3.5

-- 					if 取随机数()<=成功几率+材料数量/10 then
-- 						self.数据[bb1].技能[#self.数据[bb1].技能+1]=技能表[n].名称
-- 					end
-- 				end
-- 			end
-- 			--计算等级
-- 			local 等级总数=math.floor(((self.数据[bb1].等级+self.数据[bb2].等级)/2*( 取随机数(1,10)/10)   ))
-- 			if 等级总数<0 then
-- 				等级总数=0
-- 			end
-- 			self.数据[bb1].等级=等级总数
-- 			self.数据[bb1].当前经验=0
-- 			self.数据[bb1].最大经验=self.数据[bb1]:取经验(2,self.数据[bb1].等级)
-- 			--计算属性点
-- 			local 生成类型=""
-- 			local 随机点数=""
-- 			local 种类="野怪"
-- 			local 点数 = 10

-- 			if self.数据[bb1].种类=="宝宝" and self.数据[bb2].种类=="宝宝" then
-- 				种类="宝宝"
-- 				点数 = 15
-- 				if 取随机数(1,200)<3 then
-- 					种类="野怪"
-- 					点数 = 10
-- 				end
-- 			end

-- 			self.数据[bb1].种类=种类
-- 			if  self.数据[bb1].种类=="宝宝" then
-- 				for n=1,#属性范围 do
-- 					self.数据[bb1][属性范围[n]]=self.数据[bb1].等级+20
-- 				end
-- 				self.数据[bb1].潜力=self.数据[bb1].等级*5
-- 			else
-- 				self.数据[bb1].潜力=0
-- 				for n=1,#属性范围 do
-- 					self.数据[bb1][属性范围[n]]=self.数据[bb1].等级+10
-- 				end
-- 				if self.数据[bb1].等级~=0 then
-- 					for n=1,self.数据[bb1].等级*5 do
-- 						随机点数=属性范围[取随机数(1,#属性范围)]
-- 						self.数据[bb1][随机点数]=self.数据[bb1][随机点数]+1
-- 					end
-- 				end
-- 			end
-- 		end
-- 		self.数据[bb1].饰品 = nil
-- 		self.数据[bb1].寿命= 取随机数(4000,7000)
-- 		self.数据[bb1].自动指令=nil
-- 		self.数据[bb1].名称=self.数据[bb1].模型
-- 		local mx参战等级 =取宝宝(self.数据[bb1].模型,self.数据[bb2].种类)
-- 		if mx参战等级 ~= nil and mx参战等级[1] ~= nil then
-- 			self.数据[bb1].参战等级 = mx参战等级[1]
-- 		end
-- 		self:当前图排序(bb1)
-- 		self.数据[bb1].法术认证=nil
-- 		self.数据[bb1].内丹={可用内丹=取内丹数量(self.数据[bb1].参战等级),内丹上限=取内丹数量(self.数据[bb1].参战等级)}
-- 		self.数据[bb1].参战等级=0
-- 		table.remove(self.数据,bb2)

-- 		if 道具格子~=nil then
-- 		if 玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]]~=nil and 玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]].数量 > 1 and 材料数量>1 then
-- 			玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]].数量 = 玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]].数量 - 材料数量
-- 			if  玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]].数量 <=0 then
-- 				玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]]=nil
-- 				玩家数据[id].角色.道具[道具格子]=nil
-- 			end
-- 		else
-- 			玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]]=nil
-- 			玩家数据[id].角色.道具[道具格子]=nil
-- 		end
-- 		end


		-- if 道具格子~=nil then
		-- 玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]]=nil
		-- 玩家数据[id].角色.道具[道具格子]=nil
		-- end


-- 		发送数据(连接id,14,玩家数据[id].道具:索要道具1(id)) --刷新客户端道具
-- 		常规提示(id,"恭喜你合出了一只#R/"..随机模型)
-- 		发送数据(连接id,16,self.数据)
-- 	end
-- end
-----------------------------------------------------------------
function 召唤兽处理类:合宠处理(连接id,序号,id,内容)
	local bb1=内容.序列
	local bb2=内容.序列1
	local 道具格子
	if 内容.合宠材料==0 then
		道具格子=nil
	else
		道具格子=内容.合宠材料.道具格子
	end

	local 材料数量=0
	local 技能最大数量=24
	-- print(玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]].名称)--名称
	-- print(玩家数据[id].角色.道具[道具格子])--=53
	local 随机模型=""
	if self.数据[bb1]==nil or self.数据[bb2]==nil then
		return
	elseif self.数据[bb1].认证码==self.数据[bb2].认证码 then
		常规提示(id,"同一只召唤兽怎么合成呢？")
		return
	elseif self.数据[bb1].等级<30 or self.数据[bb2].等级<30 then
		常规提示(id,"要炼妖的召唤兽等级未达到30级!")
		return
	elseif self.数据[bb1].种类=="神兽" or self.数据[bb2].种类=="神兽" then
		常规提示(id,"神兽不可进行此操作")
		return
	elseif self.数据[bb1].种类=="变异" or self.数据[bb2].种类=="变异" then
		if RpbARGB.序列~=3 then
			常规提示(id,"变异宝宝不可进行此操作")
			return
		end
	elseif 玩家数据[id].角色.参战信息~=nil then --玩家数据[id].角色.参战信息~=nil or
		常规提示(id,"请先取消所有召唤兽的参战状态")
		return
	elseif self:是否有装备(bb1) or self:是否有装备(bb2) then
		常规提示(id,"请先卸下召唤兽所穿戴的装备")
		return
	elseif self.数据[bb1].进阶 or self.数据[bb2].进阶 then
		常规提示(id,"进阶的召唤兽无法进行此操作")
		return
	 elseif self.数据[bb1].专用 or self.数据[bb2].专用 then
		常规提示(id,"专用的召唤兽无法进行此操作")
		return
	else
		--检查装备 等级
		随机模型=self.数据[bb1].模型
		local 随机数值=取随机数()
		local 特殊合宠=false
		if 随机数值<=1 then      --小于1是泡泡
			特殊合宠=true
			随机模型="泡泡"
		elseif 随机数值<=2 then  --1-2是大海龟
			特殊合宠=true
			随机模型="大海龟"
		elseif 随机数值<=50 then
			随机模型=self.数据[bb2].模型   --2-50之间执行这里
		else
			随机模型=self.数据[bb1].模型   --大于50执行这里
		end
		if 特殊合宠 then
			self.数据[bb1]:置新对象(随机模型,随机模型,"宝宝",属性,0,染色方案,技能组,资质组,成长,参战等级,属性表)
		else
			if 道具格子~=nil then
				if  玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]] and 玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]].数量~=nil and 玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]].名称 =='神兜兜' then
					材料数量=1
				end
			end
			self.数据[bb1].模型=随机模型
			local pj = 0
			for n=1,#资质范围 do
				pj = math.floor((self.数据[bb1][资质范围[n]]+self.数据[bb2][资质范围[n]])/2)
				if 道具格子~=nil and 材料数量>=1 then
					self.数据[bb1][资质范围[n]] = math.floor(取随机数(pj*(950+材料数量*10),pj*1050)/1000   )
				else
					self.数据[bb1][资质范围[n]] = math.floor(取随机数(pj*950,pj*1050)/1000)
				end
			end
			-- if self.数据[bb1][资质范围["攻击资质"]] >=1000 then
			-- 	self.数据[bb1][资质范围["攻击资质"]]=111
			-- end
			--计算成长
			pj = string.format("%.3f", (self.数据[bb1].成长 + self.数据[bb2].成长)/2)
			if 道具格子~=nil and 材料数量>1 then
				self.数据[bb1].成长=GetPreciseDecimal(取随机小数2(pj*(920+材料数量*10), pj*1020)/1000,3)
			else
				self.数据[bb1].成长=GetPreciseDecimal(取随机小数2(pj*920,pj*1020)/1000,3)
			end
			if self.数据[bb1].成长>1.5 then
				self.数据[bb1].成长=1.5
			end
			--计算技能
			local 技能表={}
			local bd =  取宝宝(随机模型,"宝宝")
			if bd[10] then
				for i=1,#bd[10] do
					技能表[#技能表+1]=bd[10][i]
				end
			end
			for n=1,#self.数据[bb2].技能 do
				技能表[#技能表+1]=self.数据[bb2].技能[n]
			end
			for n=1,#self.数据[bb1].技能 do
				技能表[#技能表+1]=self.数据[bb1].技能[n]
			end

			技能表=删除重复(技能表)
			for n=1,#技能表 do
				技能表[n]={名称=技能表[n],排列=取随机数(1,10000)}
			end
			table.sort(技能表,function(a,b) return a.排列>b.排列 end )
			local 技能保底数=1
			if #技能表>=2 then
				 技能保底数=math.floor(#技能表/2)
			end
			local 技能总数=取随机数(技能保底数,#技能表)
			if 技能总数>24 then 技能总数=24 end
			self.数据[bb1].技能={}
			if 技能表~={} then
				for n=1,技能总数 do
					local 成功几率=100-#self.数据[bb1].技能*4
					if 取随机数()<=成功几率+材料数量*3 then
						self.数据[bb1].技能[#self.数据[bb1].技能+1]=技能表[n].名称
					end
				end
			end
			--计算等级
			local 等级总数=math.floor(((self.数据[bb1].等级+self.数据[bb2].等级)/2*( 取随机数(1,10)/10)   ))
			if 等级总数<0 then
				等级总数=0
			end
			self.数据[bb1].等级=等级总数
			self.数据[bb1].当前经验=0
			self.数据[bb1].最大经验=self.数据[bb1]:取经验(2,self.数据[bb1].等级)
			--计算属性点
			local 生成类型=""
			local 随机点数=""
			local 种类="野怪"
			local 点数 = 10

			if self.数据[bb1].种类=="宝宝" and self.数据[bb2].种类=="宝宝" then
				种类="宝宝"
				点数 = 15
				if 取随机数(1,200)<3 then
					种类="野怪"
					点数 = 10
				end
			end

			self.数据[bb1].种类=种类
			if  self.数据[bb1].种类=="宝宝" then
				for n=1,#属性范围 do
					self.数据[bb1][属性范围[n]]=self.数据[bb1].等级+20
				end
				self.数据[bb1].潜力=self.数据[bb1].等级*5
			else
				self.数据[bb1].潜力=0
				for n=1,#属性范围 do
					self.数据[bb1][属性范围[n]]=self.数据[bb1].等级+10
				end
				if self.数据[bb1].等级~=0 then
					for n=1,self.数据[bb1].等级*5 do
						随机点数=属性范围[取随机数(1,#属性范围)]
						self.数据[bb1][随机点数]=self.数据[bb1][随机点数]+1
					end
				end
			end
		end
		self.数据[bb1].饰品 = nil
		self.数据[bb1].寿命= 取随机数(4000,7000)
		self.数据[bb1].自动指令=nil
		self.数据[bb1].名称=self.数据[bb1].模型
		local mx参战等级 =取宝宝(self.数据[bb1].模型,self.数据[bb2].种类)
		if mx参战等级 ~= nil and mx参战等级[1] ~= nil then
			self.数据[bb1].参战等级 = mx参战等级[1]
		end
		self:当前图排序(bb1)
		self.数据[bb1].法术认证=nil
		self.数据[bb1].内丹={可用内丹=取内丹数量(self.数据[bb1].参战等级),内丹上限=取内丹数量(self.数据[bb1].参战等级)}
		self.数据[bb1].参战等级=0
		table.remove(self.数据,bb2)

		if 道具格子~=nil then
			if 玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]]~=nil and 玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]].数量 >= 1 and 材料数量>=1 then
				玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]].数量 = 玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]].数量 - 材料数量
				if  玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]].数量 <=0 then
					玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]]=nil
					玩家数据[id].角色.道具[道具格子]=nil
				end
			-- else
			-- 	玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]]=nil
			-- 	玩家数据[id].角色.道具[道具格子]=nil
			end
		end


		-- if 道具格子~=nil then
		-- 玩家数据[id].道具.数据[玩家数据[id].角色.道具[道具格子]]=nil
		-- 玩家数据[id].角色.道具[道具格子]=nil
		-- end
		发送数据(连接id,14,玩家数据[id].道具:索要道具1(id)) --刷新客户端道具
		常规提示(id,"恭喜你合出了一只#R/"..随机模型)
		发送数据(连接id,16,self.数据)
	end
end
-----------------------------------------------------------------

function 召唤兽处理类:合宠引所数据处理(连接id,序号,id,内容)
	local bb1=内容.序列
	local bb2=内容.序列1
	local 随机模型=""
	if self.数据[bb1]==nil or self.数据[bb2]==nil then
		return
	else
			local 技能表={}
			local bd =  取宝宝(随机模型,"宝宝")
			if bd[10] then
				for i=1,#bd[10] do
					技能表[#技能表+1]=bd[10][i]
				end
			end
			for n=1,#self.数据[bb2].技能 do
				技能表[#技能表+1]=self.数据[bb2].技能[n]
			end
			for n=1,#self.数据[bb1].技能 do
				技能表[#技能表+1]=self.数据[bb1].技能[n]
			end
			技能表=删除重复(技能表)
			for n=1,#技能表 do
				技能表[n]={名称=技能表[n],排列=取随机数(1,10000)}
			end
			table.sort(技能表,function(a,b) return a.排列>b.排列 end )
			发送数据(连接id,16.1,#技能表)
	end
end



function 召唤兽处理类:取野外等级差(地图等级,玩家等级)
	local 等级=math.abs(地图等级-玩家等级)
	if 等级<=5 then
		return 1
	elseif 等级<=10 then
		return 0.8
	elseif 等级<=20 then
		return 0.5
	else
		return 0.2
	end
end

function 召唤兽处理类:获得经验(认证码,经验,id,类型,地图等级)
	local 编号=self:取编号(认证码)
	if 编号==0 or self.数据[编号]==nil then return  end
	if self.数据[编号].等级>=玩家数据[id].角色.等级+5 then
		发送数据(玩家数据[id].连接id,38,{内容="你的召唤兽当前等级已经超过人物等级+5，目前已经无法再获得更多的经验了。"})
		return
	end
	经验=math.floor(经验)
	self:添加经验(玩家数据[id].连接id,id,编号,经验)
end

function 召唤兽处理类:添加经验(连接id,id,编号,数额)
	local 实际数额=数额
	if (self.数据[编号].等级 >= 玩家数据[id].角色.等级+10) or (self.数据[编号].等级 >= 180 and self.数据[编号].当前经验 >=  2100000000)  then
		return
	end
	self.数据[编号].当前经验=self.数据[编号].当前经验+实际数额
	发送数据(连接id,27,{文本="#W/你的"..self.数据[编号].名称.."#W/获得了"..实际数额.."点经验",频道="xt"})
	for i=1,20 do
		if (self.数据[编号].当前经验>=self.数据[编号].最大经验 and self.数据[编号].等级 < 玩家数据[id].角色.等级+10)  and self.数据[编号].等级 < 180 then
			self.数据[编号]:升级()
			发送数据(连接id,27,{文本="#W/你的#R/"..self.数据[编号].名称.."#W/等级提升到了#R/"..self.数据[编号].等级.."#W/级",频道="xt"})
		else
			break
		end
	end
end

function 召唤兽处理类:更新参战宝宝(编号)
	if 编号== nil then
		编号 = self:取编号(玩家数据[self.玩家id].角色.参战宝宝.认证码)
	end
	玩家数据[self.玩家id].角色.参战宝宝={}
	玩家数据[self.玩家id].角色.参战宝宝=table.copy((self.数据[编号]:取存档数据()))
	玩家数据[self.玩家id].角色.参战信息=1
	self.数据[编号].参战信息=1
	发送数据(玩家数据[self.玩家id].连接id,18,玩家数据[self.玩家id].角色.参战宝宝)
end

function 召唤兽处理类:加寿命处理(编号,数额,中毒,连接id,id)
	数额=数额+0
	if self.数据[编号].统御属性 and self.数据[编号].统御属性.延年益寿 then
		数额=qz(数额*(1+self.数据[编号].统御属性.延年益寿*0.01))
	end
	self.数据[编号].寿命=self.数据[编号].寿命+数额
	常规提示(id,"该召唤兽寿命增加了#R/"..数额.."点")
	if self.数据[编号].统御属性 and self.数据[编号].统御属性.正身清心 then
		中毒=nil
	end
	if 中毒~=nil and 中毒~=0 and 中毒>=取随机数() then
		local 减少类型=""
		local 减少数量=0
		local 随机参数=取随机数(1,6)
		if 随机参数==1 then
			减少类型="攻击资质"
			减少数量=取随机数(1,5)
		elseif 随机参数==2 then
			减少类型="防御资质"
			减少数量=取随机数(1,5)
		elseif 随机参数==3 then
			减少类型="体力资质"
			减少数量=取随机数(5,20)
		elseif 随机参数==4 then
			减少类型="法力资质"
			减少数量=取随机数(3,10)
		elseif 随机参数==5 then
			减少类型="躲闪资质"
			减少数量=取随机数(1,5)
		elseif 随机参数==6 then
			减少类型="速度资质"
			减少数量=取随机数(1,5)
		end
		self.数据[编号][减少类型]=self.数据[编号][减少类型]-减少数量
		-- 常规提示(id,"#Y/你的召唤兽因中毒而导致"..减少类型.."#W/减少了#R/"..减少数量.."#W/点")
		常规提示(id,"#Y/你的召唤兽#R"..self.数据[编号].名称.."#Y因中毒而导致资质降低了#14")
	end
	发送数据(连接id,20,self.数据[编号]:取存档数据())
end

function 召唤兽处理类:加血处理(编号,数额,连接id,id)
	self.数据[编号].气血=self.数据[编号].气血+数额
	if self.数据[编号].气血>self.数据[编号].最大气血 then
		self.数据[编号].气血=self.数据[编号].最大气血
	end
	发送数据(连接id,20,self.数据[编号]:取存档数据())
end

function 召唤兽处理类:加蓝处理(编号,数额,连接id,id)
	self.数据[编号].魔法=self.数据[编号].魔法+数额
	if self.数据[编号].魔法>self.数据[编号].最大魔法 then
		self.数据[编号].魔法=self.数据[编号].最大魔法
	end
	发送数据(连接id,20,self.数据[编号]:取存档数据())
end

function 召唤兽处理类:取是否有相同内丹(id,加血对象,技能)
	for i=1,self.数据[加血对象].内丹.内丹上限 do
		if self.数据[加血对象].内丹.格子[i]~= nil and self.数据[加血对象].内丹.格子[i].技能 == 技能 then
			return i
		end
	end
	return 0
end

function 召唤兽处理类:内丹升级处理(连接id,序号,id,内容)
	local 物品=内容.道具格子
	if 玩家数据[id].角色.道具[物品] == nil then
		常规提示(id,"数据错误无法洗练")
		发送数据(连接id,14,玩家数据[id].道具:索要道具1(id))
		return
	end
	local bb=内容.bb
	local 物品名称=玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].名称
	local 物品总类=玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].总类
	local 物品特效=玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].特效
	if 物品名称==nil or self.数据[bb]==nil then
		return
	elseif self.数据[bb].参战信息~=nil then
		常规提示(id,"请先取消召唤兽的参战状态")
		return
	elseif 物品总类~=203 then
		常规提示(id,"请使用正确的物品")
		return
	else
		local ndpd = self:取是否有相同内丹(id,bb,物品特效)
		if ndpd ~= 0 then --相同
			if self.数据[bb].内丹.格子[ndpd].等级 <5 then
				self.数据[bb].内丹.格子[ndpd].等级 = self.数据[bb].内丹.格子[ndpd].等级+1
				常规提示(id,"恭喜你，你的#R"..self.数据[bb].名称.."#Y的内丹技能#R"..物品特效.."#Y学习到了下一层次。")
			else
				常规提示(id,"该内丹层数已达上限！")
				return
			end
			self.数据[bb]:刷新信息("1")
		else
			常规提示(id,"你的召唤兽学习的内丹和此内丹不一致无法提升层数。")
			return
		end
		self.数据[bb]:刷新信息("1")

		if 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量~=nil and 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量>1 then
			玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 = 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 -1
		else
			玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]]=nil
			玩家数据[id].角色.道具[物品]=nil
		end

		-- 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]]=nil
		-- 玩家数据[id].角色.道具[物品]=nil
		发送数据(连接id,16,self.数据)
		发送数据(连接id,102,{序号=bb,内丹=self.数据[bb].内丹,bb=self.数据[bb]})
		发送数据(连接id,14,玩家数据[id].道具:索要道具1(id)) --刷新客户端道具
	end
end

function 召唤兽处理类:内丹处理(连接id,序号,id,内容)
	local 物品=内容.序列
	if 玩家数据[id].角色.道具[物品] == nil then
		常规提示(id,"物品数据错误")
		return
	end
	local bb=内容.序列1
	local 物品名称=玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].名称
	local 物品总类=玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].总类
	local 物品特效=玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].特效
	if 物品名称==nil or self.数据[bb]==nil then
		return
	elseif self.数据[bb].参战信息~=nil then
		常规提示(id,"请先取消召唤兽的参战状态")
		return
	elseif 物品总类~=203 then
		常规提示(id,"炼化的物品必须为内丹")
		return
	else

		if 物品名称=="高级召唤兽内丹" then
			if self.数据[bb].内丹.格子==nil then
				self.数据[bb].内丹.格子={}
				self.数据[bb].内丹.格子[1]={}
				self.数据[bb].内丹.格子[1].技能=物品特效
				self.数据[bb].内丹.格子[1].等级=1
				self.数据[bb].内丹.可用内丹 = self.数据[bb].内丹.可用内丹 - 1
				常规提示(id,"恭喜你的"..self.数据[bb].名称.."学会了#G/"..物品特效)
			else
				if self.数据[bb].内丹.格子[1].技能==物品特效 then
					常规提示(id,"你的召唤兽已经学习了此内丹技能，不能继续进行学习。")
					return
				end
				local dh = "少侠想学习高级内丹“"..物品特效.."”，需放弃一种已有的内丹，你要放弃哪种？"
				local xx = {}
				xx[#xx+1]=self.数据[bb].内丹.格子[1].技能
				xx[#xx+1]="算了，我再想想"
				发送数据(连接id,1501,{名称="内丹替换",模型="仓库管理员",对话=dh,选项=xx})--发送过去，再返回来？
				玩家数据[id].最后操作="内丹替换"
				玩家数据[id].宝宝内丹序号=bb
				玩家数据[id].物品序号=物品
				return
			end
		else
			if self.数据[bb].内丹.格子==nil then
				self.数据[bb].内丹.格子={}
			end
			local ndpd = self:取是否有相同内丹(id,bb,物品特效)
			if ndpd ~= 0 then --相同
				常规提示(id,"你的召唤兽已经学习了此内丹技能，不能继续进行学习。")
				return
			else --不同
				if self.数据[bb].内丹.可用内丹>0 then
					local bh = 0
					for i=1,self.数据[bb].内丹.内丹上限 do
						if self.数据[bb].内丹.格子[i] == nil then
							self.数据[bb].内丹.格子[i]={}
							bh = i
							break
						end
					end
					常规提示(id,"恭喜你的"..self.数据[bb].名称.."学会了#G/"..物品特效)
					self.数据[bb].内丹.格子[bh] = {技能 = 物品特效,等级=1}
					self.数据[bb].内丹.可用内丹 = self.数据[bb].内丹.可用内丹 - 1
				else --没有可用内丹格子就是替换
					local dh = "少侠想学习低级内丹“"..物品特效.."”，需放弃一种已有的内丹，你要放弃哪种？"
					local xx = {}
					for i=1,self.数据[bb].内丹.内丹上限 do
						if self.数据[bb].内丹.格子 and self.数据[bb].内丹.格子[i] ~= nil then
							xx[#xx+1]=self.数据[bb].内丹.格子[i].技能
						end
					end
					xx[#xx+1]="算了，我再想想"
					发送数据(连接id,1501,{名称="内丹替换",模型="仓库管理员",对话=dh,选项=xx})
					玩家数据[id].最后操作="内丹替换"
					玩家数据[id].宝宝内丹序号=bb
					玩家数据[id].物品序号=物品
					return
				end
			end
		end
		self.数据[bb]:刷新信息()
		-- 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]]=nil
		-- 玩家数据[id].角色.道具[物品]=nil
		玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 = (玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 or 1) -1
        		if 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 < 1 then
            		玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]]=nil
            		玩家数据[id].角色.道具[物品]=nil
        		end

		发送数据(连接id,16,self.数据)
		发送数据(连接id,67,玩家数据[id].道具:索要道具2(id))
		发送数据(连接id,66)
		发送数据(连接id,3699)
	end
end

function 召唤兽处理类:内丹替换(bb,物品,事件,连接id,id)
	if self.数据[bb]==nil then
		常规提示(id,"数据错误无法替换！")
		return
	end
	if 玩家数据[id].角色.道具[物品] == nil then
		发送数据(连接id,14,玩家数据[id].道具:索要道具1(id))
		常规提示(id,"数据错误无法替换！！")
		return
	end
	local 物品特效=玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].特效
	for i=1,self.数据[bb].内丹.内丹上限 do
		if self.数据[bb].内丹.格子[i] and self.数据[bb].内丹.格子[i].技能 == 事件 then
			self.数据[bb].内丹.格子[i] = {}
			self.数据[bb].内丹.格子[i] = {技能=物品特效,等级=1}
			常规提示(id,"替换成功，你的"..self.数据[bb].名称.."学会了#G/"..物品特效)
			break
		end
	end
	self.数据[bb]:刷新信息()

	if 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量~=nil and 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量>1 then
			玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 = 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 -1
		else
			玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]]=nil
			玩家数据[id].角色.道具[物品]=nil
		end

	-- 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]]=nil
	-- 玩家数据[id].角色.道具[物品]=nil
	发送数据(连接id,16,self.数据)
	发送数据(连接id,67,玩家数据[id].道具:索要道具2(id))
	发送数据(连接id,66)
	发送数据(连接id,3699)
end

function 召唤兽处理类:增加技能(连接id,id,序号)
	local bb=序号
	local rzfs1 = {"反震","吸血","反击","连击","飞行","隐身","感知","再生","冥思","慧根","必杀","幸运","神迹","招架","永恒","敏捷","强力","防御","偷袭","毒","驱鬼","鬼魂术","魔之心","神佑复生","精神集中","否定信仰","雷击","落岩","水攻","烈火","法术连击","法术暴击","法术波动"}
	for i=1,#rzfs1 do
		for n=1,#self.数据[bb].技能 do
			if self.数据[bb].技能[n] == rzfs1[i] then
				table.remove(rzfs1,i)
			end
		end
	end
	self.数据[bb].技能[#self.数据[bb].技能+1]=rzfs1[取随机数(1,#rzfs1)]
	self:当前图排序(bb)
	self.数据[bb]:刷新信息()
	发送数据(连接id,16,self.数据)
	常规提示(id,"你的召唤兽领悟了新技能")
end

function 召唤兽处理类:法术认证(连接id,序号,id,内容)

	local 技能=内容.序列
	local 技能1=内容.序列2
	local bb=内容.序列1
	if self.数据[bb]==nil  then
		return
	elseif self.数据[bb].参战信息~=nil then
		常规提示(id,"请先取消召唤兽的参战状态")
		return
	elseif self.数据[bb].技能[技能]==nil or self.数据[bb].技能[技能] ~= 技能1 then
		常规提示(id,"技能数据错误")
		return
	elseif self.数据[bb].法术认证 ~= nil then
		常规提示(id,"这只召唤兽已经认证过无法重复认证")
		return
	end
	if 玩家数据[id].角色:扣除银子(self.数据[bb].参战等级*self.数据[bb].参战等级*160+self.数据[bb].参战等级*4000,0,0,"法术认证") then
		local rzfs = {"再生","冥思","慧根"}
		local rzfs1 = {"雷属性吸收","土属性吸收","水属性吸收","火属性吸收","弱点雷","弱点土","弱点水","弱点火","迟钝"}
		for i=1,#rzfs do
			for n=1,#self.数据[bb].技能 do
				if self.数据[bb].技能[n] == rzfs[i] then
					table.remove(rzfs,i)
				end
			end
		end
		if #rzfs ~= 0 then
			self.数据[bb].技能[#self.数据[bb].技能+1]=rzfs[取随机数(1,#rzfs)]
		else
			for i=1,#rzfs1 do
				for n=1,#self.数据[bb].技能 do
					if self.数据[bb].技能[n] == rzfs1[i] then
						table.remove(rzfs1,i)
					end
				end
			end
			self.数据[bb].技能[#self.数据[bb].技能+1]=rzfs1[取随机数(1,#rzfs1)]
		end
		self.数据[bb].法术认证 = 技能
		self.数据[bb]:刷新信息()
		发送数据(连接id,16,self.数据)
		常规提示(id,"你的召唤兽认证成功了")
	else
		常规提示(id,"你的银两不足")
	end
end

function 召唤兽处理类:炼化处理(连接id,序号,id,内容)
	local 物品=内容.序列
	local bb=内容.序列1
	local 物品名称=玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].名称
	if 物品名称==nil or self.数据[bb]==nil  then
		return
	elseif self.数据[bb].参战信息~=nil then
		常规提示(id,"请先取消召唤兽的参战状态")
		return
	-- elseif 物品名称~="炼妖石" then
	-- 	常规提示(id,"炼化的物品必须为炼妖石")
	-- 	return
	else--检查银子和体力
		if 物品名称=="炼妖石" then
			local 名称表 = {"天眼珠","三眼天珠","九眼天珠"}
			local 临时等级=玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].级别限制
			local 成功几率=55+math.floor(self.数据[bb].等级/10)
			if self.数据[bb].种类=="宝宝" then
				成功几率=成功几率*1.6
			end
			if 成功几率>=取随机数() then
				玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]] = nil
				玩家数据[id].角色.道具[物品] = nil
				玩家数据[id].道具:给予道具(id,名称表[取随机数(1,3)],临时等级)
				道具刷新(id)
				常规提示(id,"炼化成功！")
			else
				常规提示(id,"很遗憾，本次炼化失败了！！！")
			end
			table.remove(self.数据,bb)
			发送数据(连接id,16,self.数据)
			发送数据(连接id,24,玩家数据[id].道具:索要道具2(id))
			发送数据(连接id,3699)
			-- 发送数据(连接id,25)
		elseif 物品名称=="吸附石" then
			if self:是否有装备(bb) then
				常规提示(id,"请先卸下召唤兽所穿戴的装备")
				return
			elseif #self.数据[bb].技能<=0 then
				常规提示(id,"你丫没技能吸什么！")
				return
			elseif self.数据[bb].种类=="野怪" then
				常规提示(id,"不能对野怪使用！")
				return
			else
				local 吸附概率 = 40
				local 吸附名称 = self.数据[bb].技能[取随机数(1,#self.数据[bb].技能)]
				if 吸附名称=="须弥真言" or 吸附名称=="观照万象" or 吸附名称=="津津有味" or 吸附名称=="净台妙谛" or 吸附名称=="叱咤风云" or 吸附名称=="无畏布施"
					or 吸附名称=="风起龙游" or 吸附名称=="神来气旺" or 吸附名称=="出其不意" or 吸附名称=="灵能激发" then
					吸附概率=0
				end
				local 低兽诀 = {"反震","吸血","反击","连击","飞行","驱鬼","隐身","感知","再生","冥思","慧根","必杀","幸运","神迹","招架","永恒","敏捷","强力","防御","偷袭","毒","驱鬼","鬼魂术","魔之心","神佑复生","精神集中","否定信仰","雷击","落岩","水攻","烈火","法术连击","法术暴击","法术波动","雷属性吸收","土属性吸收","火属性吸收","水属性吸收","迟钝"}
				for i=1,#低兽诀 do
					if 吸附名称==低兽诀[i] then
						吸附概率=70
						break
					end
				end
				if 取随机数()<=吸附概率 then
					玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]] = nil
					玩家数据[id].角色.道具[物品] = nil
					table.remove(self.数据,bb)
					玩家数据[id].道具:给予道具(id,"点化石",吸附名称)
					常规提示(id,"#Y/你成功的从召唤兽身上吸取到#R/"..吸附名称.."#Y/技能#80")
					发送数据(连接id,16,self.数据)
				else
					玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]] = nil
					玩家数据[id].角色.道具[物品] = nil
					table.remove(self.数据,bb)
					发送数据(连接id,16,self.数据)
					常规提示(id,"#R/吸附召唤兽技能失败")
				end
				发送数据(连接id,24,玩家数据[id].道具:索要道具2(id))
				发送数据(连接id,3699)
			end
		elseif 物品名称=="圣兽丹" then
			if 取饰品表(self.数据[bb].模型) then
				玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]] = nil
				玩家数据[id].角色.道具[物品] = nil
				常规提示(id,"炼化成功")
			--	玩家数据[id].道具:给予道具(id,self.数据[bb].模型.."饰品")
			    玩家数据[id].道具:给予道具(id,"进阶"..self.数据[bb].模型.."饰品")
				table.remove(self.数据,bb)
				发送数据(连接id,16,self.数据)
				发送数据(连接id,24,玩家数据[id].道具:索要道具2(id))
				发送数据(连接id,3699)
			else
				常规提示(id,"该召唤兽没有饰品模型暂时不能炼化")
			end
		end
	end
end

function 召唤兽处理类:重置等级(lv,bb)
	self.数据[bb]:重置等级(lv)
end
function 召唤兽处理类:重置五行(wx,bb)
	self.数据[bb]:重置五行(wx)
end

function 召唤兽处理类:洗练处理(连接id,序号,id,内容)
	local 物品=内容.序列
	if 玩家数据[id].角色.道具[物品] == nil then
		发送数据(连接id,14,玩家数据[id].道具:索要道具1(id))
		常规提示(id,"数据错误无法洗练")
		return
	end
	local bb=内容.序列1
	local 物品名称=玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].名称

	if 物品名称==nil or self.数据[bb]==nil  then
		return
	elseif self.数据[bb].参战信息~=nil then
		常规提示(id,"参战中的召唤兽无法进行此操作")
		return
	elseif 物品名称=="金柳露" or 物品名称=="超级金柳露" then
		if (物品名称=="金柳露" or 物品名称=="超级金柳露") and self.数据[bb].变异 then
			常规提示(id,"只有净瓶玉露才能作用于变异召唤兽")
			return
		elseif 物品名称=="金柳露" and self.数据[bb].参战等级>85 then
			常规提示(id,"金柳露只能作用在参战等级≤85级的召唤兽")
			return
		elseif 物品名称=="超级金柳露" and self.数据[bb].参战等级<=85 then
			常规提示(id,"超级金柳露只能作用在参战等级≥95级的召唤兽")
			return
		elseif self.数据[bb].种类=="神兽" then
			常规提示(id,"金柳露不能作用于神兽")
			return
		elseif self.数据[bb].进阶 then
			常规提示(id,"金柳露不能作用于进阶召唤兽")
			return
		elseif self:是否有装备(bb) then
			常规提示(id,"请先卸下召唤兽所穿戴的装备")
			return
		elseif self.数据[bb].统御 ~= nil then
			常规提示(id,"该召唤兽处于统御状态,请解除统御后再进行此操作")
			return
		end
		self.数据[bb]:置新对象(self.数据[bb].模型,self.数据[bb].模型,"宝宝")
		for i=1,#self.数据[bb].技能 do
			if self.数据[bb].技能[i]=="力劈华山" or self.数据[bb].技能[i]=="善恶有报" or self.数据[bb].技能[i]=="法术防御"
				or self.数据[bb].技能[i]=="死亡召唤"or self.数据[bb].技能[i]=="须弥真言"or self.数据[bb].技能[i]=="龙魂" or self.数据[bb].技能[i]=="桀骜自恃" then
				if 取随机数()<=75 then
					table.remove(self.数据[bb].技能,i)
				end
			end
		end
		local jnsl=#self.数据[bb].技能
		if 物品名称=="金柳露" and jnsl>3 then

			if 取随机数()<=80 then
				table.remove(self.数据[bb].技能,jnsl)
			end
		end
		self.数据[bb]:重置等级(0)
		self.数据[bb].当前经验=0
		self.数据[bb].法术认证=nil
		self:当前图排序(bb)
		if 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量~=nil and 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量>1 then
			玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 = 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 -1
		else
			玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]]=nil
			玩家数据[id].角色.道具[物品]=nil
		end
		-- 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]]=nil
		-- 玩家数据[id].角色.道具[物品]=nil
		发送数据(连接id,16,self.数据)
		发送数据(连接id,24,玩家数据[id].道具:索要道具2(id))
		发送数据(连接id,3699)
		-- 发送数据(连接id,25)
		常规提示(id,"洗练成功！")
		return
	elseif 物品名称=="净瓶玉露" or 物品名称=="超级净瓶玉露" then
		if not self.数据[bb].变异 then
			常规提示(id,"净瓶玉露只能作用于变异召唤兽")
			return
		end
		if 物品名称=="净瓶玉露" and self.数据[bb].参战等级>95 then
			常规提示(id,"净瓶玉露不用作用于这种召唤兽")
			return
		elseif self.数据[bb].种类=="神兽" then
			常规提示(id,"净瓶玉露不用作用于神兽身上")
			return
		elseif self.数据[bb].进阶 then
			常规提示(id,"净瓶玉露不用作用于进阶召唤兽")
			return
		elseif self:是否有装备(bb) then
			常规提示(id,"请先卸下召唤兽所穿戴的装备")
			return
		elseif self.数据[bb].统御 ~= nil then
			常规提示(id,"该召唤兽处于统御状态,请解除统御后再进行此操作")
			return
		end
		self.数据[bb]:置新对象(self.数据[bb].模型,self.数据[bb].模型,"变异")
		self.数据[bb]:重置等级(0)
		self.数据[bb].当前经验=0
		self.数据[bb].法术认证=nil
		self:当前图排序(bb)
		if 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量~=nil and 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量>1 then
			玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 = 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 -1
		else
			玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]]=nil
			玩家数据[id].角色.道具[物品]=nil
		end
		发送数据(连接id,16,self.数据)
		发送数据(连接id,24,玩家数据[id].道具:索要道具2(id))
		发送数据(连接id,3699)
		-- 发送数据(连接id,25)
		常规提示(id,"炼妖成功！")
		return
	elseif 物品名称=="魔兽要诀" or 物品名称=="高级魔兽要诀" or 物品名称=="特殊魔兽要诀" or 物品名称=="超级魔兽要诀" or 物品名称=="特色魔兽要诀" then--打书



				local 兽诀技能 = 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].附带技能
				local 技能数量 = #self.数据[bb].技能
				local 排除认证格子=0
				local yccjjn=1
				local cjjndsxz={[1]=5,[2]=8,[3]=10,[4]=12,[5]=14,[6]=16,[7]=18,[8]=20,[9]=22,[10]=24} --超级技能 前3本超级技能随便打,第4本要求达到16个技能才可打
		self.数据[bb].自动指令=nil
		for i=1,技能数量 do
			if self.数据[bb].技能[i] == 兽诀技能 then
				发送数据(连接id,66)
				常规提示(id,"#W你的这只召唤兽已学会该技能，无法再学习")
				return
			end
			--------------------------超级技能
			if string.find(self.数据[bb].技能[i],"超级")~=nil and self.数据[bb].技能[i]~="超级神柚复生" and self.数据[bb].技能[i]~="超级三昧真火" then
				yccjjn=yccjjn+1
			end
			--------------------------
			if self.数据[bb].法术认证 and self.数据[bb].法术认证==self.数据[bb].技能[i] then
				排除认证格子=i
			end
		end
			-- if 物品名称 == "超级魔兽要诀" then--------------官方的超级技能定义 暂取消
			-- 	if 技能数量 ~= 0 and 技能数量 < cjjndsxz[yccjjn] then --超级技能 ----
			-- 		local kxx=yccjjn-1
			-- 		-- 常规提示(id,"#R/" ..技能数量 .."#Y/技能召唤兽最多学习" ..kxx .."个超级技能")
			-- 		添加最后对话(id,"#W/16技能以下的召唤兽均可学习三个超级技能，达到16技能可以学习第四个，24技能可以学习五个。\n\n#R/" ..技能数量 .."#Y/技能召唤兽最多学习" ..kxx .."个超级技能")
			-- 		return
			-- 	end
			-- end




			常规提示(id,"这样物品发生了作用！")
		if #self.数据[bb].技能<24 then ---------------------打书概率不限制,在打书概率fun里限制概率即可
			if self:打书概率(#self.数据[bb].技能) then
				local 顶书格子=#self.数据[bb].技能+1
				self.数据[bb].技能[顶书格子]=兽诀技能
				self.数据[bb].技能=删除重复(self.数据[bb].技能)
				self:当前图排序(bb)

				玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 = (玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 or 1) -1
        		if 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 < 1 then
            		玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]]=nil
            		玩家数据[id].角色.道具[物品]=nil
        		end

				-- 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]]=nil
				-- 玩家数据[id].角色.道具[物品]=nil
				self.数据[bb]:刷新信息()
				发送数据(连接id,16,self.数据)
				发送数据(连接id,67,玩家数据[id].道具:索要道具2(id))
				发送数据(连接id,66)
				发送数据(连接id,3699)
				return
			end
		end
		--++----++----++----++----++----++----++----++----++----++----++----++--
		local dwtjc = {}
		for i=1,技能数量 do
			dwtjc[#dwtjc+1]=self.数据[bb].技能[i]
			if 宝宝队伍图[self.数据[bb].技能[i]]==nil then
				宝宝队伍图[self.数据[bb].技能[i]]=#宝宝队伍图+1
				print("队伍图： 没有 "..self.数据[bb].技能[i])
			end
		end
		table.sort(dwtjc,function(a,b) return 宝宝队伍图[a]<宝宝队伍图[b] end ) --取到队伍图位置
		--先做个队伍图排序
		local 完全一致 = {}
		for n=1,技能数量 do
			for i=1,技能数量 do
				if i==n and dwtjc[i]==self.数据[bb].技能[n] then --第一种位置相同的情况
					完全一致[#完全一致+1]=n
				end
			end
		end
		if #完全一致>0 then --完全一致的情况，取是否和兽诀技能位置一致

			local xh = 完全一致[取随机数(1,#完全一致)]
			if 排除认证格子~=0 then
				for i=1,#dwtjc do --这里要重新取 认证格子
					if self.数据[bb].法术认证==dwtjc[i] then
						排除认证格子=i
						break
					end
				end
				for i=1,100 do --循环100次。基本上可以保证不重复取到同一个值
					if xh == 排除认证格子 then
						xh = 完全一致[取随机数(1,#完全一致)]
					else
						break
					end
				end
			end

			if self.数据[bb].技能[xh] then --检查这个技能是否存在
				self.数据[bb].技能[xh]=兽诀技能
				self.数据[bb].技能=删除重复(self.数据[bb].技能)

				if 排除认证格子~=0 then
					local JCRZGZ=0
					for i=1,#self.数据[bb].技能 do --再写一个判断吧
						if self.数据[bb].法术认证==self.数据[bb].技能[i] then
							JCRZGZ=i
							break
						end
					end

					if JCRZGZ==0 then
						local sj=取随机数(1,#self.数据[bb].技能)
						for i=1,50 do
							if self.数据[bb].技能[sj]==兽诀技能 then
								sj=取随机数(1,#self.数据[bb].技能)
							else
								break
							end
						end

						self.数据[bb].技能[sj]=self.数据[bb].法术认证
					end
				end
				--------------再次检查认证技能是否存在，如果被替换了，那么随机替换一个
				self:当前图排序(bb)

				玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 = (玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 or 1) -1
        		if 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 < 1 then
            		玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]]=nil
            		玩家数据[id].角色.道具[物品]=nil
        		end

				-- 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]]=nil
				-- 玩家数据[id].角色.道具[物品]=nil
				self.数据[bb]:刷新信息()
				发送数据(连接id,16,self.数据)
				发送数据(连接id,67,玩家数据[id].道具:索要道具2(id))
				发送数据(连接id,66)
				发送数据(连接id,3699)
				return
			end
		end
		--++----++----++----++----++----++----++----++----++----++----++----++--
		-------------取前排技能书
		local 前面两格 = {}
		local 当前兽诀位置 = 取宝宝当前图[兽诀技能]
		for n=1,当前兽诀位置 do
			if self.数据[bb].技能[当前兽诀位置-n] and 当前兽诀位置>取宝宝当前图[self.数据[bb].技能[当前兽诀位置-n]] then
				if #前面两格<2 then
					前面两格[#前面两格+1]=取宝宝当前图[self.数据[bb].技能[当前兽诀位置-n]]
				else
					break
				end
			end
		end
		if #前面两格>0 then --这里可能有问题
			local sj1 = 前面两格[取随机数(1,#前面两格)]--当前图随机一个
			if 取随机数()<=60 then

				if 排除认证格子~=0 then
					for i=1,#前面两格 do --这里要重新取 认证格子
						if self.数据[bb].法术认证==前面两格[i] then
							排除认证格子=i
							break
						end
					end

					for i=1,200 do --循环200次。基本上可以保证不重复取到同一个值
						if sj1 == 排除认证格子 then
							sj1 = 前面两格[取随机数(1,#前面两格)]--当前图随机一个
						else
							break
						end
					end
				end
				if self.数据[bb].技能[sj1] then --检查技能是否存在
					self.数据[bb].技能[sj1]=兽诀技能
					self.数据[bb].技能=删除重复(self.数据[bb].技能)
					--------------再次检查认证技能是否存在，如果被替换了，那么随机替换一个
					if 排除认证格子~=0 then
						local JCRZGZ=0
						for i=1,#self.数据[bb].技能 do --再写一个判断吧
							if self.数据[bb].法术认证==self.数据[bb].技能[i] then
								JCRZGZ=i
								break
							end
						end

						if JCRZGZ==0 then
							local sj=取随机数(1,#self.数据[bb].技能)
							for i=1,50 do
								if self.数据[bb].技能[sj]==兽诀技能 then
									sj=取随机数(1,#self.数据[bb].技能)
								else
									break
								end
							end
							self.数据[bb].技能[sj]=self.数据[bb].法术认证
						end
					end
					--------------再次检查认证技能是否存在，如果被替换了，那么随机替换一个
					self:当前图排序(bb)

					玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 = (玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 or 1) -1
        		if 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 < 1 then
            		玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]]=nil
            		玩家数据[id].角色.道具[物品]=nil
        		end
					-- 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]]=nil
					-- 玩家数据[id].角色.道具[物品]=nil
					self.数据[bb]:刷新信息()
					发送数据(连接id,16,self.数据)
					发送数据(连接id,67,玩家数据[id].道具:索要道具2(id))
					发送数据(连接id,66)
					发送数据(连接id,3699)
					return
				end
			end
		end
		--++----++----++----++----++----++----++----++----++----++----++--
		local 完全随机 = 取随机数(1,#self.数据[bb].技能)
		if 排除认证格子~=0 then
			for i=1,#self.数据[bb].技能 do --这里要重新取 认证格子
				if self.数据[bb].法术认证==self.数据[bb].技能[i] then
					排除认证格子=i
					break
				end
			end
			for i=1,200 do --循环200次。基本上可以保证不重复取到同一个值
				if 完全随机 == 排除认证格子 then
					完全随机 = 取随机数(1,#self.数据[bb].技能)
				else
					break
				end
			end
		end
		if self.数据[bb].技能[完全随机] then --检查技能是否存在,
			self.数据[bb].技能[完全随机]=兽诀技能
			self.数据[bb].技能=删除重复(self.数据[bb].技能)
			--------------再次检查认证技能是否存在，如果被替换了，那么随机替换一个
			if 排除认证格子~=0 then
				local JCRZGZ=0
				for i=1,#self.数据[bb].技能 do --再写一个判断吧
					if self.数据[bb].法术认证==self.数据[bb].技能[i] then
						JCRZGZ=i
						break
					end
				end

				if JCRZGZ==0 then
					local sj=取随机数(1,#self.数据[bb].技能)
					for i=1,50 do
						if self.数据[bb].技能[sj]==兽诀技能 then
							sj=取随机数(1,#self.数据[bb].技能)
						else
							break
						end
					end

					self.数据[bb].技能[sj]=self.数据[bb].法术认证
				end
			end
			self:当前图排序(bb)

			玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 = (玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 or 1) -1
        		if 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]].数量 < 1 then
            		玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]]=nil
            		玩家数据[id].角色.道具[物品]=nil
        		end

			-- 玩家数据[id].道具.数据[玩家数据[id].角色.道具[物品]]=nil
			-- 玩家数据[id].角色.道具[物品]=nil
			self:重置丸子技能()
			self.数据[bb]:刷新信息()
			发送数据(连接id,16,self.数据)
			发送数据(连接id,67,玩家数据[id].道具:索要道具2(id))
			发送数据(连接id,66)
			发送数据(连接id,3699)
			return
		end
	end
end

function 召唤兽处理类:加点处理(连接id,序号,id,点数)
	local 临时编号=self:取编号(点数.序列)
	local 监控开关 = false
	if 临时编号==0 then
		常规提示(id,"你没有这只召唤兽")
		return
	else
		if self.数据[临时编号].潜力<1 then
			return
		end
		local 总数点=0
		总数点=点数.力量+点数.体质+点数.耐力+点数.魔力+点数.敏捷
		if 总数点 == 0 then
			常规提示(id,"您到底是要添加哪种属性点呢？")
			return
		elseif 总数点>self.数据[临时编号].潜力 then
			常规提示(id,"该召唤兽没有那么多的可分配属性点")
			return
		elseif 总数点<1 then
			-- 常规提示(id,"该召唤兽没有那么多的可分配属性点")
			监控开关 = true
		end
		if 点数.力量<0 or 点数.魔力<0 or 点数.耐力<0 or 点数.体质<0 or 点数.敏捷<0 or  点数.力量>self.数据[临时编号].潜力 or 点数.魔力>self.数据[临时编号].潜力 or 点数.耐力>self.数据[临时编号].潜力 or 点数.体质>self.数据[临时编号].潜力 or 点数.敏捷>self.数据[临时编号].潜力 then
			监控开关 = true
		elseif 总数点~=qz(总数点) then
			监控开关 = true
		end
		if 监控开关 then
			-- 写配置("./ip封禁.ini", "ip", 玩家数据[id].角色.ip, 1)
			-- f函数.写配置(程序目录..[[data\]]..玩家数据[id].账号..[[\账号信息.txt]],"账号配置","封禁","1")
			local 封禁原因=玩家数据[id].角色.ip.."“违规行为：宝宝加点处理”，玩家ID=="..id.."，玩家账号=="..玩家数据[id].账号.."时间="..os.date("%Y%m%d")..os.date("%H",os.time())..os.date("%S",os.time())
			f函数.写配置(程序目录..[[data\]]..玩家数据[id].账号..[[\账号信息.txt]],"账号配置","已违规3",封禁原因)
			f函数.写配置(程序目录..[[各类情况查看\]]..[[\违规汇总.txt]],"违规详情","已违规3:",封禁原因)
			-- 发送数据(玩家数据[id].连接id, 998, "请注意你的角色异常！已经对你进行封禁")
			-- __S服务:断开连接(玩家数据[id].连接id)
			常规提示(id,"属性异常！")
			return 0
		end
		self.数据[临时编号].力量=self.数据[临时编号].力量+点数.力量
		self.数据[临时编号].魔力=self.数据[临时编号].魔力+点数.魔力
		self.数据[临时编号].耐力=self.数据[临时编号].耐力+点数.耐力
		self.数据[临时编号].体质=self.数据[临时编号].体质+点数.体质
		self.数据[临时编号].敏捷=self.数据[临时编号].敏捷+点数.敏捷
		self.数据[临时编号].潜力=self.数据[临时编号].潜力-总数点
		self.数据[临时编号]:刷新信息(nil,点数.体质,点数.魔力)
		发送数据(连接id,20,self.数据[临时编号]:取存档数据())
	end
end

function 召唤兽处理类:改名处理(连接id,序号,id,序列,名称)
	local 临时编号=self:取编号(序列)
	if 临时编号==0 then
		常规提示(id,"你没有这只召唤兽")
		return
	elseif 名称=="" then
		常规提示(id,"名称不能为空")
		return
	elseif #名称>12 then
		常规提示(id,"名称太长了，换个试试！")
		return
	else
		self.数据[临时编号].名称=名称
		常规提示(id,"召唤兽名称修改成功！")
		发送数据(连接id,19,{序列=临时编号,名称=名称})
	end
end

function 召唤兽处理类:参战处理(连接id,序号,id,序列)
	local 临时编号=self:取编号(序列)
	if 临时编号==0 then
		常规提示(id,"你没有这只召唤兽")
		return
	-- elseif 玩家数据[id].角色.历劫.飞升 == false and (玩家数据[id].角色.等级<self.数据[临时编号].参战等级 or 玩家数据[id].角色.等级+10<self.数据[临时编号].等级)  then
	-- 	常规提示(id,"以你目前的能力还不足以驾驭此类型召唤兽")
	-- 	return
	elseif 玩家数据[id].角色.历劫.飞升 == true then
		-- if 玩家数据[id].角色.等级<=145 and self.数据[临时编号].参战等级 >155 then
		-- 	常规提示(id,"以你目前的等级还不足以驾驭该召唤兽")
		-- 	return
		-- elseif 玩家数据[id].角色.等级>=145 and (玩家数据[id].角色.等级<self.数据[临时编号].参战等级 or 玩家数据[id].角色.等级+10<self.数据[临时编号].等级) then
		-- 	常规提示(id,"以你目前的等级还不足以驾驭该召唤兽")
		-- 	return
		-- end
		if 玩家数据[id].角色.参战宝宝.认证码==self.数据[临时编号].认证码 then
			玩家数据[id].角色.参战宝宝={}
			self.数据[临时编号].参战信息=nil
			玩家数据[id].角色.参战信息=nil
			神兵异兽榜:删除处理(id,"宝宝")
			发送数据(连接id,18,玩家数据[id].角色.参战宝宝)
		else
			for n=1,#self.数据 do
				if self.数据[n].认证码==玩家数据[id].角色.参战宝宝.认证码 then
					self.数据[n].参战信息=nil
					break
				end
			end
			神兵异兽榜:宝宝参战处理(id,临时编号)
			self:更新参战宝宝(临时编号)
		end
	else
		if 玩家数据[id].角色.参战宝宝.认证码==self.数据[临时编号].认证码 then
			玩家数据[id].角色.参战宝宝={}
			self.数据[临时编号].参战信息=nil
			玩家数据[id].角色.参战信息=nil
			神兵异兽榜:删除处理(id,"宝宝")
			发送数据(连接id,18,玩家数据[id].角色.参战宝宝)
		else
			for n=1,#self.数据 do
				if self.数据[n].认证码==玩家数据[id].角色.参战宝宝.认证码 then
					self.数据[n].参战信息=nil
					break
				end
			end
			神兵异兽榜:宝宝参战处理(id,临时编号)
			self:更新参战宝宝(临时编号)
		end
	end
end

function 召唤兽处理类:死亡处理(认证码)
	local 编号=self:取编号(认证码)
	if self.数据[编号].种类 ~= "神兽" then
		self.数据[编号].寿命 = self.数据[编号].寿命 - 50  --这热么是寿命。。。
		if self.数据[编号].寿命<=0 then
			self.数据[编号].寿命 = 0
		end
	end
	-- self.数据[编号].忠诚=self.数据[编号].忠诚-qz(self.数据[编号].忠诚*0.1)
	-- if self.数据[编号].寿命 <= 50 and 取随机数()<=30 then
	-- 	玩家数据[self.数字id].角色.参战宝宝={}
	-- 	玩家数据[self.数字id].角色.参战信息=nil
	-- 	self.数据[编号].参战信息=nil
	-- 	常规提示(self.数字id,"该召唤兽寿命过低，已取消参战！")
	-- 	发送数据(玩家数据[self.数字id].连接id,18,玩家数据[self.数字id].角色.参战宝宝)
	-- end
end

function 召唤兽处理类:当前图排序(bb)
	for i=1,#self.数据[bb].技能 do
		if 取宝宝当前图[self.数据[bb].技能[i]]==nil then
			取宝宝当前图[self.数据[bb].技能[i]]=#取宝宝当前图+1
			print("当前图： 没有 "..self.数据[bb].技能[i])
		end
	end
	local function 简易排序(a,b)
		return 取宝宝当前图[a]<取宝宝当前图[b]
	end
	table.sort(self.数据[bb].技能,简易排序)
end
-- if self.统御~= nil then
--     	local cff = 分割文本(self.统御,"_")
--     	local 玩家id = cff[1]+0
--     	if 玩家数据[玩家id] and 玩家数据[玩家id].角色 then
--     		local 坐骑编号 = 玩家数据[玩家id].角色:取坐骑编号(self.统御)
--     		if 玩家数据[玩家id].角色.坐骑列表[坐骑编号] and 玩家数据[玩家id].角色.坐骑列表[坐骑编号].统御召唤兽 then
--     			local go = false
--     			for i=1,2 do
--     				玩家数据[玩家id].角色.坐骑列表[坐骑编号].统御召唤兽[i]=self.认证码
--     				go=true
--     				break
--     			end
--     			if go then
--     			    local zq = 玩家数据[玩家id].角色.坐骑列表[坐骑编号]
--     			end
--     		end
--     	end
--     end
function 召唤兽处理类:刷新统御属性(编号,坐骑)
	if self.数据[编号]==nil then
		print("刷新统御属性 宝宝数据为空")
		return false
	end
	self.数据[编号].统御属性={}
	local 成长 = 坐骑.成长
	local 饱食 = 坐骑.饱食度*0.01
	if 饱食>1 then
		饱食=1
	end
	for k,v in pairs(坐骑.坐骑技能) do
		if v>0 then
			if k=="开天辟地" then --增加统驭的召唤兽力量点数*"..((等级)*3).."%的伤害力
				self.数据[编号].统御属性.开天辟地=qz(self.数据[编号].力量*v*0.03*饱食)
			end
			if k=="破釜沉州" then --增加统驭的召唤兽致命几率"..(等级).."%，命中率增加"..(等级).."%"
				self.数据[编号].统御属性.破釜沉州=v*饱食
			end
			if k=="大浪淘沙" then --增加统驭的召唤兽对（水攻、水漫金山、落岩、泰山压顶）水系土系法术伤害结果减免
				self.数据[编号].统御属性.大浪淘沙=(v*3+v)*0.01*饱食
			end
			if k=="炫火乱舞" then --增加统驭的召唤兽对（烈火、地狱烈火、雷、奔雷咒）火系雷系法术伤害结果减免
				self.数据[编号].统御属性.炫火乱舞=(v*3+v)*0.01*饱食
			end
			if k=="偃旗息鼓" then --的召唤兽受到的所有伤害降低
				self.数据[编号].统御属性.偃旗息鼓=v*0.008*饱食
			end
			if k=="铜墙铁壁" then --敌人对的召唤兽物理暴击和法术暴击倍率降低
				self.数据[编号].统御属性.铜墙铁壁=v*10*0.01*饱食
			end
			if k=="飞火流星" then --统驭的召唤兽速度降低
				self.数据[编号].统御属性.飞火流星=qz(self.数据[编号].速度*v*3*0.01)
			end
			if k=="水来土掩" then --增加统驭召唤兽80%的中毒抵抗几率
				self.数据[编号].统御属性.水来土掩=qz(v*30 - 10)
			end
			if k=="忠贯日月" then --召唤兽在战斗中忠诚的消耗变为"..(3+等级).."场战斗掉1点忠诚
				self.数据[编号].统御属性.忠贯日月=v+3
			end
			if k=="正身清心" then --召唤兽在战斗中忠诚的消耗变为"..(3+等级).."场战斗掉1点忠诚
				self.数据[编号].统御属性.正身清心=v
			end
			if k=="延年益寿" then --召唤兽在战斗中忠诚的消耗变为"..(3+等级).."场战斗掉1点忠诚
				self.数据[编号].统御属性.延年益寿=v+1
			end
		end
	end
end

function 召唤兽处理类:检查临时属性()
	for n=1,#self.数据 do
		if self.数据[n] and self.数据[n].天赋符 then
			if os.time()>self.数据[n].天赋符.sj then
				self.数据[n].天赋符=nil
				常规提示(self.玩家id,"#Y/你的召唤兽"..self.数据[n].名称.."的天赋符效果消失了。")
				self.数据[n]:刷新信息()
			end
		end
	end
end

function 召唤兽处理类:刷新信息(认证码,参数)
	local 编号=self:取编号(认证码)

	self.数据[编号]:刷新信息(参数)
	if self.数据[编号].参战信息~=nil then
		玩家数据[self.玩家id].角色.参战宝宝=table.copy((self.数据[编号]:取存档数据()))
		发送数据(玩家数据[self.玩家id].连接id,18,玩家数据[self.玩家id].角色.参战宝宝)
	end
end

function 召唤兽处理类:取编号(认证码)
	for n=1,#self.数据 do
		if self.数据[n].认证码==认证码 then
			return n
		end
	end
	return 0
end

--zhuzhan
function 召唤兽处理类:索取助战bb基础信息()
	local fhsj={}
	for n=1,#self.数据 do
		fhsj[n]={认证码=self.数据[n].认证码,模型=self.数据[n].模型,名称=self.数据[n].名称,等级=self.数据[n].等级,参战信息=self.数据[n].参战信息}
	end
	return fhsj
end

function 召唤兽处理类:助战bb参战(连接id,id,认证码)
	local 临时编号=self:取编号(认证码)
	if not 临时编号 or 临时编号==0 then
		常规提示(id,"你没有这只召唤兽")
		return
	elseif 玩家数据[self.玩家id].角色.历劫.飞升 == false and (玩家数据[self.玩家id].角色.等级<self.数据[临时编号].参战等级 or 玩家数据[self.玩家id].角色.等级+10<self.数据[临时编号].等级)  then
		常规提示(id,"以你目前的能力还不足以驾驭此类型召唤兽")
		return
	elseif 玩家数据[self.玩家id].角色.历劫.飞升 == true then
		if 玩家数据[self.玩家id].角色.等级<=145 and self.数据[临时编号].参战等级 >155 then
			常规提示(id,"以你目前的等级还不足以驾驭该召唤兽")
			return
		elseif 玩家数据[self.玩家id].角色.等级>=145 and (玩家数据[self.玩家id].角色.等级<self.数据[临时编号].参战等级 or 玩家数据[self.玩家id].角色.等级+10<self.数据[临时编号].等级) then
			常规提示(id,"以你目前的等级还不足以驾驭该召唤兽")
			return
		end
	end
	for n=1,#self.数据 do
		self.数据[n].参战信息=nil
	end
	if 玩家数据[self.玩家id].角色.参战宝宝.认证码==self.数据[临时编号].认证码 then
		玩家数据[self.玩家id].角色.参战宝宝={}
		玩家数据[self.玩家id].角色.参战信息=nil
	else
		玩家数据[self.玩家id].角色.参战宝宝={}
		玩家数据[self.玩家id].角色.参战宝宝=table.copy((self.数据[临时编号]:取存档数据()))
		玩家数据[self.玩家id].角色.参战信息=1
		self.数据[临时编号].参战信息=1
	end
	发送数据(连接id,2006,self:索取助战bb基础信息())
end
function 召唤兽处理类:获取助战bb属性(连接id,id,认证码,zzbh)
	local 编号=self:取编号(认证码)
	if 编号~=0 then
		if self.数据[编号] then
			发送数据(连接id,2005,{bb=self.数据[编号],zz=zzbh})
			return
		end
	end
	常规提示(id,"暂无该召唤兽信息~~")
end

-- function 召唤兽处理类:打书概率(v)
-- 	local g = random(1,5)
-- 	if v == 1 then
-- 		if g == 1 then
-- 			return true
-- 		end
-- 	elseif v == 2 then
-- 		g = random(1,10)
-- 		if g == 1 then
-- 			return true
-- 		end
-- 	elseif v == 3 then
-- 		g = random(1,15)
-- 		if g == 1 then
-- 			return true
-- 		end
-- 	elseif v == 4 then
-- 		g = random(1,24)
-- 		if g <= 10 then
-- 			return true
-- 		end
-- 	elseif v == 5 then
-- 		g = random(1,35)
-- 		if g <= 1 then
-- 			return true
-- 		end
-- 	end
-- 	return false
-- end
function 召唤兽处理类:打书概率(v)
	local g = random(1,1)
	if v == 0 then
		if g == 1 then
		   return true
		end
	elseif v >= 1 and v < 8 then ----平均概率: 1技能打到8技能约55本书
		g = random(1,v*2-1)
		if g == 1 then
			return true
		end
	elseif v >= 8 and v < 10 then----平均概率: 8-10技能得打约81本书
		g = random(1,v*3)
		if g == 1 then
			return true
		end
	elseif v >= 10 and v< 12 then----平均概率: 10-12技能得打约132本书
		g = random(1,v*4)
		if g == 1 then
			return true
		end
	elseif v >= 12 and v< 14 then----平均概率: 12-14技能得打约195本书 -------1打到14技能 总共需要463本兽诀
		g = random(1,v*5)
		if g == 1 then
			return true
		end
	end
	return false
end

return 召唤兽处理类