-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:44
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-13 07:52:03
local 管理工具 = class()
local 书铁范围 = {"枪矛","斧钺","剑","双短剑","飘带","爪刺","扇","魔棒","锤","鞭","环圈","刀","法杖","弓弩","宝珠","巨剑","伞","灯笼","头盔","发钗","项链","女衣","男衣","腰带","鞋子"}
local 高级内丹 ={ "神机步","腾挪劲","玄武躯","龙胄铠","玉砥柱","碎甲刃","阴阳护","凛冽气","舍身击","电魂闪","通灵法","双星爆","催心浪","隐匿击","生死决","血债偿"}
local 普通内丹 = {"迅敏","狂怒","阴伤","静岳","擅咒","灵身","矫健","深思","钢化","坚甲","慧心","撞击","无畏","愤恨","淬毒","狙刺","连环","圣洁","灵光"}
function 管理工具:初始化()
end

local function 星期转数字(xq)
	if xq=="周一" then
		return 1
	elseif xq=="周二" then
		return 2
	elseif xq=="周三" then
		return 3
	elseif xq=="周四" then
		return 4
	elseif xq=="周五" then
		return 5
	elseif xq=="周六" then
		return 6
	elseif xq=="周日" then
		return 0
	end
	return xq
end

function 管理工具:验证管理员身份(管理id)
	if f函数.读配置(程序目录..[[data\]]..玩家数据[管理id].账号..[[\账号信息.txt]],"账号配置","管理") == "1" then
		return true
	end
	return false
end

function 管理工具:数据处理(连接id,序号,内容)
	local 管理id = 内容.数字id+0
	if self:验证管理员身份(管理id) then
		if 序号 ==6901 then
			self:更改活动时间(连接id,管理id,内容)
		elseif 序号 ==6902 then
			self:发放物品(连接id,管理id,内容)
		elseif 序号 ==6903 then
			self:修改爆率(连接id,管理id,内容)
		elseif 序号 ==6904 then
			发送数据(连接id, 6565, HDPZ)

		elseif 序号 ==6905 then
			写出文件([[回收设置/服务端回收.txt]],(内容[1]))
			常规提示(管理id,"物品回收设置成功！\n"..内容[1])
		elseif 序号 ==6906 then
			self:LS修改(连接id,管理id,内容)
		end
	end
end


function 管理工具:gj灵饰处理(id,shux)--,部位,lv,shux名称,专用,制造者)
	local 名称=制造装备[shux.部位][shux.等级]
	local 临时道具 =物品类()
	临时道具:置对象(名称)
	临时道具.幻化等级=0
	临时道具.部位类型=shux.部位
	临时道具.灵饰=true
	临时道具.耐久=500
	临时道具.鉴定=true
	临时道具.幻化属性={附加={}}
	临时道具.识别码=id.."_"..os.time().."_"..取随机数(1000,9999999).."_"..随机序列
	随机序列=随机序列+1
	local 主属性=shux.主属性.mc
	local 临时数值=shux.主属性.num
	临时道具.幻化属性.基础={类型=主属性,数值=临时数值,强化=0}
	for n=1,3 do
		if shux.副属性[n] then
			local 副属性=shux.副属性[n].mc
			临时数值=shux.副属性[n].num
			临时道具.幻化属性.附加[n]={类型=副属性,数值=临时数值,强化=0}
		end
	end
	if shux.专用 then
		临时道具.专用=id
	end
	if shux.超简易 then
		临时道具.特效="无级别限制"
	end
	if shux.制造者~="否" then
	    临时道具.制造者=shux.制造者.."强化打造"
	end
	return 临时道具
end
function 管理工具:LS修改(连接id,管理id,sx)
	local 玩家id=sx.mubiao+0
	if not 玩家数据[玩家id] or not 玩家数据[玩家id].角色 then
		常规提示(管理id,"该玩家不在线！")
		return
	end
	if 灵饰属性[sx.部位] then
		local tab1 = {主属性={},副属性={}}
		local go1=false
		for i=1,#灵饰属性[sx.部位].主属性 do
			if 灵饰属性[sx.部位].主属性[i]==sx.属性表[1] then --1是主属性
				if sx.属性值[1]>灵饰主属性[sx.属性表[1]][sx.等级].b then
					常规提示(管理id,"主属性：属性值范围不正确")
					return
				end
				tab1.主属性={mc=sx.属性表[1],num=sx.属性值[1]}
				go1=true --主属性是否对上
				break
			end
		end
		if not go1 then
			常规提示(管理id,"主属性：类型不正确")
			return
		end
		local ssaa=0
		for i=1,3 do
			if sx.属性值[i+1]~=0 then
				ssaa=ssaa+1
				tab1.副属性[ssaa]={}
				tab1.副属性[ssaa].mc=sx.属性表[i+1]
				tab1.副属性[ssaa].num=sx.属性值[i+1]
			end
		end
		if sx.专用=="是" then
		    tab1.专用=玩家id
		end
		if sx.制造者~="否" then
		    tab1.制造者=sx.制造者
		end
		if sx.超简易~="否" then
		    tab1.超简易=true
		end
		tab1.等级=sx.等级
		tab1.部位=sx.部位
		local daoj=self:gj灵饰处理(玩家id,tab1)
		玩家数据[玩家id].道具:给予道具(玩家id,nil,nil,nil,nil,nil,daoj)
		local 超链接 = {提示=format("#Y给#G%s#Y发放物品#G",玩家数据[玩家id].角色.名称),频道="xx",结尾="#Y成功！"}
		local 文本 = 超链接.提示.."#G/qqq|"..daoj.名称.."*"..daoj.识别码.."*道具/["..daoj.名称.."]#W"..超链接.结尾
		local 返回信息 = {}
		返回信息[#返回信息+1] = daoj
		返回信息[#返回信息].索引类型 = "道具"
		常规提示(管理id,"#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放物品#G"..daoj.名称.."#Y成功！")
		链接消息提示(管理id, 文本,返回信息)
	else
		常规提示(管理id,"灵饰部位不正确。")
	end

end
function 管理工具:修改爆率(连接id,管理id,内容)
	local sdwer={}
	sdwer[1]="难度"
	sdwer[2]="经验"
	sdwer[3]="银子"
	sdwer[4]="爆率"
	sdwer[5]="书铁"
	sdwer[6]="宝珠钨金珍珠"
	sdwer[7]="宝石"
	sdwer[8]="金丹"
	sdwer[9]="怪物卡片"
	local hd=内容.活动
	local fzsfewr={}
	fzsfewr[hd]=table.copy(HDPZ[hd])
	fzsfewr[hd].ITEM={}
	for k,v in pairs(内容.爆率文本) do
		if v~="" then
	local wp = 分割文本(v,"=")
	fzsfewr[hd].ITEM[wp[1]]=wp[2]+0
		end
	end
	for k,v in pairs(内容.其他) do
		if k<=4 then
			fzsfewr[hd][sdwer[k]]=v+0
		else
	local fw=分割文本(v,"，")
	fzsfewr[hd][sdwer[k]]={fw[1],fw[2]}
		end
	end
	HDPZ[hd]=table.copy(fzsfewr[hd])
	添加最后对话(管理id,"#G"..hd.."#W活动爆率设置成功。" )
	写出文件([[全局bl.txt]],table.tostring(HDPZ))
	fzsfewr=nil
end

function 管理工具:发放物品(连接id,管理id,内容)
	local 玩家id=内容.mubiao+0
	local 物品=分割文本(内容.wup,"，")
	local 类型=物品[1]
	if 类型=="封禁" then
		if 物品[2]=="ID" then
			if 玩家数据[玩家id] and 玩家数据[玩家id].角色 then
				写配置("./ip封禁.ini", "ip", 玩家数据[玩家id].角色.ip, 1)
				f函数.写配置(程序目录..[[data\]]..玩家数据[玩家id].账号..[[\账号信息.txt]],"账号配置","封禁","1")
				f函数.写配置(程序目录..[[data\]]..玩家数据[玩家id].账号..[[\账号信息.txt]],"账号配置","最后封禁ip",玩家数据[玩家id].角色.ip)
				local 临时文件=table.loadstring(读入文件(程序目录..[[data/]]..玩家数据[玩家id].账号..[[/信息.txt]]))
				for n=1,#临时文件 do
					local 子id=临时文件[n]+0
					if 玩家数据[子id]~=nil then
						发送数据(玩家数据[子id].连接id, 998, "请注意你的角色异常！已经对你进行封禁")
						__S服务:断开连接(玩家数据[子id].连接id)
					end
				end
				添加最后对话(管理id,"已对【在线玩家】#W账号：#G"..玩家数据[玩家id].账号.."#W   ID：#G"..玩家id.."#W  玩家名称：#G"..玩家数据[玩家id].角色.名称.."#W 进行封禁处理！该账号下所有角色已被强制下线。" )
			else
				local 账号=0
				for i=1,#名称数据 do
					if 名称数据[i].id ~= nil and 名称数据[i].账号 ~= nil and 名称数据[i].id+0 == 玩家id then
						账号 = 名称数据[i].账号
						break
					end
				end
				if 账号~=0 and f函数.文件是否存在(程序目录..[[data/]]..账号)~=false then
					f函数.写配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","封禁","1")
					添加最后对话(管理id,"已对【离线玩家】#W账号：#G"..账号.."   ID：#G"..玩家id.."#W 进行封禁处理！" )
				else
					常规提示(管理id,"ID不正确，或不存在这个ID" )
				end
			end
		elseif 物品[2]=="账号" then
			if not 物品[3] then
				添加最后对话(管理id,"封禁账号格式：  封禁，账号，玩家的账号")
				return
			end
			if f函数.文件是否存在(程序目录..[[data/]]..物品[3])~=false then
				f函数.写配置(程序目录..[[data\]]..物品[3]..[[\账号信息.txt]],"账号配置","封禁","1")
				添加最后对话(管理id,"#G已对账号： "..物品[3].." 进行封禁账号处理")
			else
				常规提示(管理id,"账号不正确，或不存在这个账号" )
			end
		else
			添加最后对话(管理id,"封禁ID格式：  封禁，ID")
		end
		return
	elseif 类型=="解封" then
		local 账号=0

		for i=1,#名称数据 do
			if 名称数据[i].id ~= nil and 名称数据[i].账号 ~= nil and 名称数据[i].id+0 == 玩家id then
				账号 = 名称数据[i].账号
				break
			end
		end
		if 账号~=0 and f函数.文件是否存在(程序目录..[[data/]]..账号)~=false and f函数.读配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","封禁")=="1" then
			f函数.写配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","封禁","0")
			添加最后对话(管理id,"已对#W账号：#G"..账号.."   ID：#G"..玩家id.."#W 解除封禁！" )
			local 获取ip=f函数.读配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","最后封禁ip")

			if 获取ip then
				写配置("./ip封禁.ini", "ip", 获取ip, 2)
			end
		end
		return

	elseif 类型=="银子记录" then
		local xxx=""
		local num=0
		local function px(a,b) return a.yz>b.yz end
		table.sort(银子jilu,px)
		for k,v in pairs(银子jilu) do
			num=num+1
			xxx=xxx.."【ID="..k.." 账号="..v.zh.." 银子="..v.yz.."】， "
			if num>=30 then
			    break
			end
		end
		if xxx~="" then
		    发送数据(连接id,6333,xxx)
		else
			添加最后对话(管理id,"当前没有任何记录。")
		end
		return
	elseif 类型=="修改密码" then
		local zh=物品[2]
		local mm=物品[3]
		if f函数.文件是否存在(程序目录..[[data/]]..zh)==false then
			常规提示(管理id,"#R未查询到该账号")
			return
		end
		if string.len(mm)<6 then
			常规提示(管理id,"#R密码不能低于6位数")
			return
		elseif string.len(mm)>15 then
			常规提示(管理id,"#R密码过长无法修改")
			return
		end
		f函数.写配置(程序目录..[[data\]]..zh..[[\账号信息.txt]],"账号配置","密码",mm)
		添加最后对话(管理id,"#W修改密码成功 #G账号 "..zh.." 密码  "..mm)
		return
	elseif 类型=="注册开关" then
		local go=true
		if 物品[2]=="关闭" then
			go=false
		end
		注册kaiguan=go
		if 注册kaiguan then
			添加最后对话(管理id,"#G开启成功！玩家可正常注册账号。")
		else
			添加最后对话(管理id,"#R关闭成功！玩家已无法注册账号。")
		end
		return
	elseif 类型=="注册账号" then
		local zh=物品[2]
		local mm=物品[3]
		if f函数.文件是否存在(程序目录..[[data/]]..zh)~=false then
			常规提示(管理id,"#R该账号已存在！")
			return
		end
		if string.len(mm)<6 or string.len(zh)<6 then
			常规提示(管理id,"#R账号或密码不能低于6位数")
			return
		elseif string.len(mm)>15 then
			常规提示(管理id,"#R密码过长")
			return
		elseif zh=="" or string.len(zh)>14 then
			常规提示(管理id,"#R账号过长")
			return
		end
		os.execute("md "..[[data\]]..zh)
		local file =io.open([[data\]]..zh..[[\信息.txt]],"w")
		file:write([[do local ret={} return ret end]])
		file:close()
		local file =io.open([[data\]]..zh..[[\账号信息.txt]],"r")
		f函数.写配置(程序目录..[[data\]]..zh..[[\账号信息.txt]],"账号配置","密码",mm)
		f函数.写配置(程序目录..[[data\]]..zh..[[\账号信息.txt]],"账号配置","管理","0")
		f函数.写配置(程序目录..[[data\]]..zh..[[\账号信息.txt]],"账号配置","仙玉","0")---------
		f函数.写配置(程序目录..[[data\]]..zh..[[\账号信息.txt]],"账号配置","安全码","0")
		f函数.写配置(程序目录..[[data\]]..zh..[[\账号信息.txt]],"账号配置","创建时间",时间转换(os.time()))
		f函数.写配置(程序目录..[[data\]]..zh..[[\账号信息.txt]],"账号配置","创建ip","GM注册")
		f函数.写配置(程序目录..[[data\]]..zh..[[\账号信息.txt]],"账号配置","储备","0")
		添加最后对话(管理id,"账号注册成功 #G【账号： "..zh.."  密码： "..mm.."】")
		return
	-- elseif 类型=="消除体验" then
	-- 	local zh=物品[2]
	-- 	if f函数.文件是否存在(程序目录..[[data/]]..zh)~=false then
	-- 		f函数.写配置(程序目录..[[data\]]..zh..[[\账号信息.txt]],"账号配置","体验状态","1")
	-- 		添加最后对话(管理id,"消除体验状态成功 #G【账号： "..zh.."】")
	-- 	else
	-- 		常规提示(管理id,"#R该账号不存在")
	-- 	end
	-- 	return
	-- elseif 类型=="清空服务器" then
	-- 	玩家数据={}
	-- 	道具仓库数据={}
	-- 	宝宝仓库数据={}
	-- 	账号记录={}
	-- 	帮派数据={}
	-- 	名称数据={}
	-- 	取所有帮派={}
	-- 	服务器关闭={开关=true,计时=120,起始=os.time()}
	-- 	return
	elseif 类型=="关闭服务器" then
		保存系统数据()
		保存帮派数据()
		服务器关闭={开关=true,计时=120,起始=os.time()}
		return
	elseif 类型=="查看在线" then
		local eorr=服务端参数.在线人数
		-- if eorr>=45 then
		-- 	eorr=qz(eorr*1.65)
		-- end
		添加最后对话(管理id,""..eorr)
		return
	elseif 类型=="服务器等级" then
		QJDJSX=物品[2]+0
		f函数.写配置(程序目录.."配置文件.ini","主要配置","等级上限",QJDJSX)
		添加最后对话(管理id,"开发等级成功，目前等级为："..QJDJSX)
		return
	elseif 类型=="自动抓鬼次数" then
		__Zdzgcs=物品[2]+0
		f函数.写配置(程序目录.."配置文件.ini","主要配置","自动抓鬼",__Zdzgcs)
		添加最后对话(管理id,"自动抓鬼次数修改为："..__Zdzgcs)
		return
	end

	if 类型=="物品" then
		if not 玩家数据[玩家id] or not 玩家数据[玩家id].角色 then
			常规提示(管理id,"该玩家不在线！")
			return
		end
		local 临时格子=玩家数据[玩家id].角色:取道具格子()
		if 临时格子==0 then
			常规提示(玩家id,"#Y/GM正在为您发放物品请先整理下包裹吧！")
			常规提示(管理id,"#R/对方道具栏已满")
			return
		end
		if 物品[2] and 物品[3] and 物品[4] and 物品[5] then
			local 名称=物品[2]
			local 数量=物品[3]
			local 等级=物品[4]
			local 专用=物品[5]
			if 专用+0==2 then
				专用=true
			else
				专用=nil
			end

			if 名称=="鬼谷子" then
				玩家数据[玩家id].道具:给予道具(玩家id,名称,nil,等级,nil,专用)
			elseif 名称=="制造指南书" then
				local go = false
				local zilei=0
				for i=1,#书铁范围 do
					if 数量==书铁范围[i] then
						zilei=i
						go=true
						break
					end
				end
				if go and zilei~=0 then

					玩家数据[玩家id].道具:给予道具(玩家id,名称,等级+0,zilei,nil,专用)
				else
					添加最后对话(管理id,"该物品等级应设置为：#Y枪矛，斧钺，剑，双短剑，飘带，爪刺，扇，魔棒，锤，鞭，环圈，刀，法杖，弓弩，宝珠，巨剑，伞，灯笼，头盔，发钗，项链，女衣，男衣，腰带，鞋子")
					return
				end
			elseif 名称=="百炼精铁" then
				玩家数据[玩家id].道具:给予道具(玩家id,名称,等级+0)
			elseif 名称=="元灵晶石" then
				等级=qz(等级/10)
				玩家数据[玩家id].道具:给予道具(玩家id,名称,{等级+0,等级+0})
			elseif 名称=="钨金" then
				if qz(等级/10)<2 then
					常规提示(管理id,"该物品等级应设置为：#Y钨金等级")
					return
				end
				玩家数据[玩家id].道具:给予道具(玩家id,名称,数量+0,等级+0,nil,专用)
			elseif 名称=="召唤兽内丹" or 名称=="高级召唤兽内丹" then
				local go = false
				if 名称=="高级召唤兽内丹" then
					for i=1,#高级内丹 do
						if 等级==高级内丹[i] then
							go=true
							break
						end
					end
				else
					for i=1,#普通内丹 do
						if 等级==普通内丹[i] then
							go=true
							break
						end
					end
				end
				if go then
					玩家数据[玩家id].道具:给予道具(玩家id,名称,nil,等级,nil,专用)
				else
					添加最后对话(管理id,"高级内丹：神机步,腾挪劲,玄武躯,龙胄铠,玉砥柱,碎甲刃,阴阳护,凛冽气,舍身击,电魂闪,通灵法,双星爆,催心浪,隐匿击,生死决,血债偿\n低级内丹：迅敏,狂怒,阴伤,静岳,擅咒,灵身,矫健,深思,钢化,坚甲,慧心,撞击,无畏,愤恨,淬毒,狙刺,连环,圣洁,灵光")
					return
				end
			elseif 名称=="灵犀玉" then
				玩家数据[玩家id].道具:给予道具(玩家id,名称,nil,数量,nil,专用)
			elseif 名称=="灵饰指南书" then
				if type(等级+0)~="number" then
					添加最后对话(管理id,"该物品等级应设置为：#Y书铁等级/10")
					return
				end
				等级=qz(等级/10)
				玩家数据[玩家id].道具:给予道具(玩家id,名称,{等级,等级},nil,nil,专用)
			elseif 名称=="魔兽要诀" or 名称=="高级魔兽要诀" then
				玩家数据[玩家id].道具:给予道具(玩家id,名称,nil,等级,nil,专用)
			elseif 名称=="九转金丹" then
				if 等级+0>1500 then
					添加最后对话(管理id,"该物品等级应设置为：#Y≤1500")
					return
				end
				for i=1,数量 do
					玩家数据[玩家id].道具:给予道具(玩家id,名称,等级+0,nil,nil,专用)
				end
			elseif 名称=="上古锻造图策" or 名称=="炼妖石" then
				if 等级/10~=qz(等级/10) then
					添加最后对话(管理id,"该物品等级应设置为：#Y书铁等级+5#W，例：65级应设置为65+5=70")
					return
				end
				等级=qz(等级/10)
				玩家数据[玩家id].道具:给予道具(玩家id,名称,{等级,等级},nil,nil,专用)
			elseif 名称=="怪物卡片" or 名称=="点化石" then
				添加最后对话(管理id,"该物品暂时不能发放")
				return
			elseif 名称=="红玛瑙" or 名称=="太阳石" or 名称=="翡翠石" or 名称=="舍利子" or 名称=="黑宝石" or 名称=="月亮石" or 名称=="光芒石" or 名称=="精魄灵石" or 名称=="星辉石" then
				if type(数量+0)~="number" then
					添加最后对话(管理id,"该物品数量应设置为：#Y给予数量")
					return
				end
				if type(等级+0)~="number" then
					添加最后对话(管理id,"该物品等级应设置为：#Y宝石等级")
					return
				end
				for i=1,数量 do
					玩家数据[玩家id].道具:给予道具(玩家id,名称,等级+0,nil,nil,专用)
				end
			else
				if type(数量+0)~="number" then
					添加最后对话(管理id,"该物品数量应设置为：#Y给予数量")
					return
				end
				玩家数据[玩家id].道具:给予道具(玩家id,名称,数量+0,nil,nil,专用)
			end
			常规提示(玩家id,"#Y成功给您发放了物品#G"..名称)
			常规提示(管理id,"#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放物品#G"..名称.."#Y成功！")
			消息提示(管理id, "#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放物品#G"..名称.."#Y成功！")
		end
	elseif 类型=="三打160" then
		if not 玩家数据[玩家id] or not 玩家数据[玩家id].角色 then
			常规提示(管理id,"该玩家不在线！")
			return
		end
		for k,v in pairs(玩家数据[玩家id].角色.辅助技能) do
			if v.名称=="打造技巧" then
				v.等级=160
			elseif v.名称=="裁缝技巧" then
				v.等级=160
			elseif v.名称=="炼金术" then
				v.等级=160
			end
		end
		常规提示(玩家id,"#Y成功给您发放了三打160")
		常规提示(管理id,"#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放#G三打160#Y成功！")
		消息提示(管理id, "#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放#G三打160#Y成功！")

	elseif 类型=="辅助技能" then
		if not 玩家数据[玩家id] or not 玩家数据[玩家id].角色 then
			常规提示(管理id,"该玩家不在线！")
			return
		end
		local 技能=物品[2]
		local lv=物品[3]+0
		for k,v in pairs(玩家数据[玩家id].角色.辅助技能) do
			if v.名称==技能 then
				v.等级=lv
			end
		end
		常规提示(玩家id,"#Y成功给您发放了技能#G"..技能.."等级为#G"..lv)
		常规提示(管理id,"#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放#G"..技能.."等级为#G"..lv)
		消息提示(管理id, "#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放#G"..技能.."等级为#G"..lv)

	elseif 类型=="全套专用装备" then
		if not 玩家数据[玩家id] or not 玩家数据[玩家id].角色 then
			常规提示(管理id,"该玩家不在线！")
			return
		end
		local 等级=物品[2]+0
		礼包奖励类:全套专用装备(玩家id,等级,"无级别限制",玩家id)
	elseif 类型=="银子" then
		if not 玩家数据[玩家id] or not 玩家数据[玩家id].角色 then
			常规提示(管理id,"该玩家不在线！")
			return
		end
		local 金额=物品[2]+0
		if 金额>0 then
			玩家数据[玩家id].角色:添加银子(qz(金额),"GM工具",1)
			常规提示(玩家id,"#Y成功给您发放了#G"..金额.."#Y两银子")
			常规提示(管理id,"#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放银子#G"..金额.."#Y成功！")
			消息提示(管理id, "#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放银子#G"..金额.."#Y成功！")
		end
	elseif 类型=="经验" then
		if not 玩家数据[玩家id] or not 玩家数据[玩家id].角色 then
			常规提示(管理id,"该玩家不在线！")
			return
		end
		local 金额=物品[2]+0
		if 金额>0 then
			玩家数据[玩家id].角色:添加经验(qz(金额),"GM工具")
			常规提示(管理id,"发放经验成功"..金额)
		end
	elseif 类型=="剧情点" then
		if not 玩家数据[玩家id] or not 玩家数据[玩家id].角色 then
			常规提示(管理id,"该玩家不在线！")
			return
		end
		local 金额=物品[2]+0
		if 金额>0 then
			玩家数据[玩家id].角色:增加剧情点(金额)
			常规提示(管理id,"发放剧情点成功"..金额)
		end
	elseif 类型=="帮派建筑" then
		local 帮派编号=物品[2]+0
		local 金额=物品[3]+0
		帮派处理:增加当前内政(帮派编号,金额)
		常规提示(管理id,"为"..帮派数据[帮派编号].帮派名称.."发放帮派建筑成功"..金额)
	elseif 类型=="强制退出战斗" then
		if not 玩家数据[玩家id] or not 玩家数据[玩家id].角色 then
			常规提示(管理id,"该玩家不在线！")
			return
		end
		local 队伍id=玩家数据[玩家id].队伍
		if 队伍id~=0 then
			for n=1,#队伍数据[队伍id].成员数据 do
				local cyid=队伍数据[队伍id].成员数据[n]
				玩家数据[cyid].遇怪时间=os.time()+取随机数(10,20)
				发送数据(玩家数据[cyid].连接id,5505)
				发送数据(玩家数据[cyid].连接id,31,玩家数据[cyid].角色:取总数据1())
				玩家数据[cyid].zhandou=0
				玩家数据[cyid].道具:重置法宝回合(cyid)
				玩家数据[cyid].角色.战斗开关=false
				地图处理类:设置战斗开关(cyid,false)
			end
			if 战斗准备类.战斗盒子[队伍id] then
				战斗准备类.战斗盒子[队伍id]=nil
			end
		else
			玩家数据[玩家id].遇怪时间=os.time()+取随机数(10,20)
			发送数据(玩家数据[玩家id].连接id,5505)
			发送数据(玩家数据[玩家id].连接id,31,玩家数据[玩家id].角色:取总数据1())
			玩家数据[玩家id].zhandou=0
			玩家数据[玩家id].道具:重置法宝回合(玩家id)
			玩家数据[玩家id].角色.战斗开关=false
			地图处理类:设置战斗开关(玩家id,false)
			if 战斗准备类.战斗盒子[玩家id] then
			   战斗准备类.战斗盒子[玩家id]=nil
			end
		end
		常规提示(管理id,"#Y给#G"..玩家数据[玩家id].角色.名称.."#Y强制退出战斗成功！")
	elseif 类型=="存档强制下线" then
		if 玩家数据[玩家id] then
			玩家数据[玩家id].角色:存档()
			发送数据(玩家数据[玩家id].连接id,999,"你已经被管理员强制下线")
			常规提示(管理id,"#Y/存档强制下线玩家:"..玩家id.."成功！")
		else
			常规提示(管理id,"#Y目标不在线")
		end
	elseif 类型=="不存档强制下线" then
		玩家数据[玩家id]=nil
		常规提示(管理id,"#Y/已对玩家:"..玩家id.."进行清档处理！")
	elseif 类型=="发送公告" then
		发送公告("#S(系统公告)#R"..物品[2])
	elseif 类型=="坐骑" then
		if not 玩家数据[玩家id] or not 玩家数据[玩家id].角色 then
			常规提示(管理id,"该玩家不在线！")
			return
		end
		local mx=物品[2]
		玩家数据[玩家id].角色:增加指定坐骑(玩家id, mx)
		常规提示(管理id,"#Y发放坐骑成功")
	elseif 类型=="IP限制归零" then
		IPxianzhi={}
		常规提示(管理id,"#Y清除成功")
	elseif 类型=="关闭WPE开关" then
		WPE开关=false
		常规提示(管理id,"#Y关闭WPE开关成功")
	elseif 类型=="累充" then
		if not 玩家数据[玩家id] or not 玩家数据[玩家id].角色 then
			常规提示(管理id,"该玩家不在线！")
			return
		end
		local ljje=物品[2]+0
		self:fafang(ljje,玩家id,管理id)

	elseif 类型=="泡泡" or 类型=="巨蛙" or 类型=="蝴蝶仙子"  or 类型=="龙鲤" or 类型=="超级鲲鹏" or 类型=="毗舍童子" or 类型=="超级神虎（壬寅）" or 类型=="超级飞天" then
		if not 玩家数据[玩家id] or not 玩家数据[玩家id].角色 then
			常规提示(管理id,"该玩家不在线！")
			return
		end
		if #玩家数据[玩家id].召唤兽.数据 >= 玩家数据[玩家id].角色.召唤兽携带上限 then
			常规提示(管理id, "#Y/对方召唤兽已满！")
			return
		end
		if 类型=="超级神虎（壬寅）" or 类型=="超级飞天"  then
			if 物品[3]==nil then
				常规提示(管理id, "#Y/需输入礼包价格")
				return
			end
			物品[3]=物品[3]+0
			local go=false
			if 物品[3]==388 or 物品[3]==888 or 物品[3]==1288 then
			else
				常规提示(管理id, "#Y/请输入礼包价格388，888，1288")
				return
			end
		end
		self:增加宠物(玩家id,类型,物品[2],物品[3])
		常规提示(玩家id,"#Y成功给您发放了一只#G"..类型)
		常规提示(管理id,"#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放一只#G"..类型.."#Y成功！")
		消息提示(管理id, "#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放一只#G"..类型.."#Y成功！")
	elseif 类型=="神兽" then
		if not 玩家数据[玩家id] or not 玩家数据[玩家id].角色 then
			常规提示(管理id,"该玩家不在线！")
			return
		end
		if #玩家数据[玩家id].召唤兽.数据 >= 玩家数据[玩家id].角色.召唤兽携带上限 then
			常规提示(管理id, "#Y/对方召唤兽已满！")
			return
		end
		local 名称=物品[2]
		local 物法="物理型（单点爆伤）"
		if 物品[3]==1 then
			物法="法术型（秒伤）"
		end
		玩家数据[玩家id].召唤兽:添加神兽(名称,物法)
		常规提示(玩家id,"#Y成功给您发放了一只#G"..名称)
		常规提示(管理id,"#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放一只#G"..名称.."#Y成功！")
		消息提示(管理id, "#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放一只#G"..名称.."#Y成功！")
	elseif 类型=="定制神兽" then
		if not 玩家数据[玩家id] or not 玩家数据[玩家id].角色 then
			常规提示(管理id,"该玩家不在线！")
			return
		end
		if #玩家数据[玩家id].召唤兽.数据 >= 玩家数据[玩家id].角色.召唤兽携带上限 then
			常规提示(管理id, "#Y/对方召唤兽已满！")
			return
		end
		local 名称=物品[2]
		local 技能组=Split(物品[3], "+")
		if #技能组>23 then
			常规提示(管理id, "#Y/技能数量不得超过24")
			return
		end
		玩家数据[玩家id].召唤兽:定制神兽(名称,技能组,玩家id)
		常规提示(玩家id,"#Y成功给您发放了一只#G"..名称)
		常规提示(管理id,"#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放一只#G"..名称.."#Y成功！")
		消息提示(管理id, "#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放一只#G"..名称.."#Y成功！")
	elseif 类型=="定制宝宝" then
		if not 玩家数据[玩家id] or not 玩家数据[玩家id].角色 then
			常规提示(管理id,"该玩家不在线！")
			return
		end
		if #玩家数据[玩家id].召唤兽.数据 >= 玩家数据[玩家id].角色.召唤兽携带上限 then
			常规提示(管理id, "#Y/对方召唤兽已满！")
			return
		end
		local 模型=物品[2]
		if not Qubaobao[模型] then
			常规提示(管理id, "#Y/没有这个宝宝模型")
		    return
		end
		local lv=Qubaobao[模型].bbs_1
		local 技能组=Split(物品[3], "+")
		if #技能组>23 then
			常规提示(管理id, "#Y/技能数量不得超过24")
			return
		end
		local 资质组=Split(物品[4], "+")
		local zz={}
		for i=1,7 do
			zz[i]=资质组[i]+0
		end
		local cz = 资质组[8] or 0
		玩家数据[玩家id].召唤兽:添加召唤兽(模型, 模型, "宝宝", nil, 0 , nil , 技能组,zz,cz,lv)
		常规提示(玩家id,"#Y你获得一只#G"..模型)
		常规提示(管理id,"#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放一只#G"..模型.."#Y成功！")
		消息提示(管理id, "#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放一只#G"..模型.."#Y成功！")
	else
		常规提示(管理id,"没有这个项目类型")
	end
	管理日志=nil
end

function 管理工具:增加宠物(id,名称,物法,dingzhi)
	local jnz,类型,zz,cz
	if 名称=="火月蛙" or 名称=="蝴蝶仙子" then
		jnz = {"高级魔之心","高级法术暴击","高级法术连击","高级法术波动","高级反震","奔雷咒"}
		类型="宝宝"
		zz={1100,1100,3000,2000,1100,1100,1100}
		cz=1.1
		if 注册称谓=="生日快乐" then
			jnz = {"水漫金山","高级敏捷","高级魔之心","高级法术暴击","高级法术波动","高级神佑复生"}
			zz={1200,1200,3000,2000,1200,1200,1100}
			cz=1.2
		end
		玩家数据[id].召唤兽:添加召唤兽(名称, 名称, 类型, nil, 0 , nil , jnz,zz,cz,0)
	elseif 名称=="超级鲲鹏" then
		if 物法+0==1 then
			玩家数据[id].召唤兽:添加神兽("超级鲲鹏","物理型（单点爆伤）")
		else
			玩家数据[id].召唤兽:添加神兽("超级鲲鹏","法术型（秒伤）")
		end
	elseif 名称=="超级神虎（壬寅）" or 名称=="超级飞天" then
		if 物法+0==1 then
			玩家数据[id].召唤兽:添加神兽(名称,"物理型（单点爆伤）",dingzhi)
		else
			玩家数据[id].召唤兽:添加神兽(名称,"法术型（秒伤）",dingzhi)
		end
	end
	常规提示(id,"#Y你获得一只#G"..名称)
end

function 管理工具:fafang(num,玩家id,管理id)
	if num==88 then
		   玩家数据[玩家id].道具:给予道具(玩家id,"鬼谷子",nil,"天覆阵",nil,nil)
		for i=1,5 do
			玩家数据[玩家id].道具:给予道具(玩家id,"120无级别礼包",nil,nil,nil,nil)
		end
		玩家数据[玩家id].角色:添加银子(qz(100000000),"GM工具",1)
	elseif  num==200 then
		玩家数据[玩家id].道具:给予道具(玩家id,"特技书",5,nil,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"修炼果",50,nil,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"九转金丹礼包",6,nil,nil,nil)
	elseif  num==500 then
		玩家数据[玩家id].道具:给予道具(玩家id,"特技书",10,nil,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"修炼果",99,nil,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"九转金丹礼包",6,nil,nil,nil)
	elseif  num==1000 then
		玩家数据[玩家id].道具:给予道具(玩家id,"特技书",20,nil,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"神兜兜",99,nil,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"修炼果",99,nil,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"九转金丹礼包",10,nil,nil,nil)
	elseif  num==2000 then
		玩家数据[玩家id].道具:给予道具(玩家id,"特技书",20,nil,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"神兜兜",99,nil,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"修炼果",99,nil,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"九转金丹礼包",10,nil,nil,nil)
	elseif  num==3000 then
		玩家数据[玩家id].道具:给予道具(玩家id,"特技书",20,nil,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"神兜兜",99,nil,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"修炼果",99,nil,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"九转金丹礼包",10,nil,nil,nil)
	elseif  num==4000 then
		玩家数据[玩家id].道具:给予道具(玩家id,"神兜兜",99,nil,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"修炼果",99,nil,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"九转金丹礼包",10,nil,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"160附魔宝珠礼包",10,nil,nil,nil)
		for i=1,5 do
			玩家数据[玩家id].道具:给予道具(玩家id,"装备特效宝珠",nil,nil,nil,nil)
		end
		玩家数据[玩家id].道具:给予道具(玩家id,"钨金",99,160,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"特殊清灵仙露",nil,nil,nil,nil)
	elseif  num==5000 then
		玩家数据[玩家id].道具:给予道具(玩家id,"神兜兜",99,nil,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"160附魔宝珠礼包",10,nil,nil,nil)
		for i=1,5 do
			玩家数据[玩家id].道具:给予道具(玩家id,"装备特效宝珠",nil,nil,nil,nil)
		end
		玩家数据[玩家id].道具:给予道具(玩家id,"钨金",99,160,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"特殊清灵仙露",nil,nil,nil,nil)
	elseif  num==6000 then
		玩家数据[玩家id].道具:给予道具(玩家id,"特技书",20,nil,nil,nil)
		玩家数据[玩家id].道具:给予道具(玩家id,"神兜兜",199,nil,nil,nil)
	elseif  num==7000 then
		玩家数据[玩家id].道具:给予道具(玩家id,"神兜兜",199,nil,nil,nil)
	end
	常规提示(玩家id,"#Y成功给您发放了#G"..num.."#Y奖励")
	常规提示(管理id,"#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放#G"..num.."#Y成功！")
	消息提示(管理id, "#Y给#G"..玩家数据[玩家id].角色.名称.."#Y发放#G"..num.."#Y成功！")
end

function 管理工具:更改活动时间(连接id,管理id,内容)
	local Time=分割文本(内容.TIME,"，")
	if Time[1] and Time[2] and Time[3] then
		local SHI=Time[1]+0
		local FEN=Time[2]+0
		local MIAO=Time[3]+0
		local 更改类型=内容.类型
		local 日期=内容.RQ
		if 更改类型=="游泳比赛" then
			if 游泳活动.活动开关 then
				常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。") --设置是成功了，但是活动结束后得重新设置一次才行
				return
			end
		elseif 更改类型=="文韵墨香" then
			if 文韵墨香.活动开关 then
				常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。")
				return
			end
		elseif 更改类型=="彩虹争霸" then
			if 彩虹争霸.活动开关 then
				常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。")
				return
			end
		elseif 更改类型=="降妖伏魔" then
			if 降妖伏魔.活动开关 then
				常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。")
				return
			end
		elseif 更改类型=="帮派迷宫" then
			if 帮派迷宫.活动开关 then
				常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。")
				return
			end
		elseif 更改类型=="天降辰星" then
			if 天降辰星.活动开关 then
				常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。")
				return
			end
		elseif 更改类型=="保卫长安" then
			if 长安保卫战.活动开关 then
				长安保卫战.活动开关=false
				常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。")
				return
			end
		elseif 更改类型=="帮战" then
			if 帮派PK.活动开关 then
				帮派PK.活动开关=false
				常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。已为你关闭了该活动")
				return
			end
		elseif 更改类型=="比武大会" then
			常规提示(管理id,"设置失败，"..更改类型.."活动正在完善中")
			return

		elseif 更改类型=="剑会" then
		   if 剑会.活动开关 then
				剑会.活动开关=false
				常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。已为你关闭了该活动")
				return
			end
		end
		if 更改类型=="定时刷怪" then
			if 日期=="天罡星" or 日期=="地煞星" or 日期=="封妖" or 日期=="妖王" then
				常规提示(管理id,"该活动暂时无法更改")
				return
			end
			QJHDSJ[更改类型][日期].时=SHI
			QJHDSJ[更改类型][日期].分=FEN
			QJHDSJ[更改类型][日期].秒=MIAO
			投放怪.活动时间=QJHDSJ[更改类型]
			写出文件([[活动时间.txt]],table.tostring(QJHDSJ))
			添加最后对话(管理id,"#G"..更改类型.."#W已更改成功，更改如下 #G日期："..日期.." 时："..SHI.." 分："..FEN.." 秒："..MIAO)
			return
		end
		if QJHDSJ[更改类型] then
			QJHDSJ[更改类型].日期=星期转数字(日期)
			QJHDSJ[更改类型].大写日期=日期
			QJHDSJ[更改类型].时=SHI
			QJHDSJ[更改类型].分=FEN
			QJHDSJ[更改类型].秒=MIAO
			if 更改类型=="游泳比赛" then
				游泳活动.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="门派闯关" then
				门派闯关.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="文韵墨香" then
				文韵墨香.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="彩虹争霸" then
				彩虹争霸.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="降妖伏魔" then
				降妖伏魔.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="帮派迷宫" then
				帮派迷宫.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="天降辰星" then
				天降辰星.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="保卫长安" then
				长安保卫战.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="帮战" then
				帮派PK.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="比武大会" then
				比武大会.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="剑会" then
				剑会.活动时间=QJHDSJ[更改类型]
			end
			写出文件([[活动时间.txt]],table.tostring(QJHDSJ))
			添加最后对话(管理id,"#G"..更改类型.."#W已更改成功，更改如下 #G日期："..日期.." 时："..SHI.." 分："..FEN.." 秒："..MIAO.."\n#R（“如果时超过24或分秒超过60”该活动就会处于关闭状态！）")
		end
	else
		常规提示(管理id,"#R设置失败，请注意大小写")
	end
end

function 管理工具:添加称谓(管理id,称谓)
	if 管理id ~= nil then
		if 玩家数据[管理id] ~= nil then
			玩家数据[管理id].角色:添加称谓(称谓)
			闪烁消息(管理id,"恭喜你在本次的首席弟子竞选中脱颖而出获得了门派首席弟子的称谓")
		else
			local sj = 取userdata表(管理id)
			sj1=table.loadstring(sj.称谓)
			local fhz = false
			for i=1,#sj1 do
				if sj1[i] ==  称谓 then
					fhz = true
				end
			end
			if fhz == false then
				table.insert(sj1,fhz)
				sj2 = 称谓
				if sj2 == 称谓 then sj2 = "沉默西游" end
				m:执行SQL(string.format("update userdata set 称谓 = '%s',当前称谓 = '%s' where  szid='%s'",table.tostring(sj1),sj2,管理id))
			end
			闪烁消息(管理id,"恭喜你在本次的首席弟子竞选中脱颖而出获得了门派首席弟子的称谓")
		end
	end
end

return 管理工具
