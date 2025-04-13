-- @Author: baidwwy
-- @Date:   2024-11-23 13:32:07
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-04-13 14:58:30
-- @Author: baidwwy
-- @Date:   2024-11-01 04:09:49
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-12-15 15:40:11
function 产出物品计算(name) --还差个yuanxiao
	if name["装备特效宝珠"] and math.random(100)<=name["装备特效宝珠"] then
	    return "装备特效宝珠"
	elseif name["灵饰特效宝珠"] and math.random(100)<=name["灵饰特效宝珠"]  then
	    return "灵饰特效宝珠"
	elseif name["神兜兜"] and math.random(100)<=name["神兜兜"] then
	    return "神兜兜",取随机数(1,3)
	end
	local zgl = 0
	for _, rate in pairs(name) do
		zgl = zgl + rate
	end
	local num = math.random(zgl) --设置为100时 会有nil
	local lj = 0
	for item, rate in pairs(name) do
		lj = lj + rate
		if num <= lj then
			return item
		end
	end
end

function 生成产出(name,hd) --名称,数量,参数
	if __Funfa[name] then
		return __Funfa[name](name,hd)
	end
	return name,1
end

__Funfa={}
__Funfa["宝石"]=function(name,hd) --这个不对 1
	return 取宝石(),取随机数(HDPZ[hd]["宝石"][1],HDPZ[hd]["宝石"][2])
	-- 玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(3,4),nil,链接)
end
---------------------------------------------------------------
__Funfa["钟灵石"]=function(name,hd)
	return name,1,取随机数(1,3)
end
__Funfa["月华露"]=function(name,hd)
	return name,取随机数(1,3)
end
__Funfa["星辉石"]=function(name,hd)
	return name,取随机数(1,3)
end
__Funfa["精魄灵石"]=function(name,hd)
	return name,取随机数(1,3)
end
__Funfa["灵犀之屑"]=function(name,hd)
	return name,取随机数(2,5)
end
__Funfa["青龙印"]=function(name,hd)
	return name,取随机数(1,1)
end
__Funfa["白虎印"]=function(name,hd)
	return name,取随机数(1,1)
end
__Funfa["朱雀印"]=function(name,hd)
	return name,取随机数(1,1)
end
__Funfa["玄武印"]=function(name,hd)
	return name,取随机数(1,1)
end

__Funfa["特效宝珠"]=function(name,hd)
	return "160特效宝珠",1
end


----------------------------------------------------------------

-- 玩家数据[cyid].道具:给予超链接道具(cyid,强化石,1,nil,链接,"成功")
__Funfa["强化石"]=function(name,hd)
	return 取强化石(),取随机数(1,1)
end

__Funfa["五宝"]=function(name,hd) --玩家数据[id].道具:给予道具(id,取五宝())
	return 取五宝()
end
__Funfa["未激活的符石"]=function(name,hd)
	return name,取随机数(1,1)
end

QJBBWP={"水晶糕","芝麻沁香元宵","桂花酒酿元宵","细磨豆沙元宵","蜜糖腰果元宵","山楂拔丝元宵","如意丹","滑玉莲蓉元宵","蜜糖腰果元宵","芝麻沁香元宵","桂花酒酿元宵","细磨豆沙元宵","蜜糖腰果元宵","山楂拔丝元宵","滑玉莲蓉元宵","蜜糖腰果元宵","炼兽真经"}
-- 玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
__Funfa["元宵"]=function(name,hd)
	return QJBBWP[取随机数(1,#QJBBWP)],取随机数(1,1)
end
-- 玩家数据[cyid].道具:给予超链接道具(cyid,钨金,1,160,链接)
__Funfa["钨金"]=function(name,hd)
	-- return name,1,取随机数(qz(HDPZ[hd]["宝珠钨金珍珠"][1]/10),qz(HDPZ[hd]["宝珠钨金珍珠"][2]/10))*10
	return name,取随机数(1,3),取随机数(qz(HDPZ[hd]["宝珠钨金珍珠"][1]/10),qz(HDPZ[hd]["宝珠钨金珍珠"][2]/10))*10
end
-- 玩家数据[cyid].道具:给予超链接道具(cyid,附魔宝珠,取随机数(15,16),nil,链接)
__Funfa["附魔宝珠"]=function(name,hd)
	-- return name,取随机数(qz(HDPZ[hd]["宝珠钨金珍珠"][1]/10),qz(HDPZ[hd]["宝珠钨金珍珠"][2]/10))*10
	return name,取随机数(1,1),取随机数(qz(HDPZ[hd]["宝珠钨金珍珠"][1]/10),qz(HDPZ[hd]["宝珠钨金珍珠"][2]/10))*10
end
-- 玩家数据[id].道具:给予道具(id,"珍珠",160,nil,"商店")
__Funfa["珍珠"]=function(name,hd)
	return name,1,取随机数(qz(HDPZ[hd]["宝珠钨金珍珠"][1]/10),qz(HDPZ[hd]["宝珠钨金珍珠"][2]/10))*10
end
-- 玩家数据[失败id].道具:给予超链接道具(失败id,高级摄灵珠,1,取随机数(10,30),链接)
__Funfa["高级摄灵珠"]=function(name,hd)
	return name,1,取随机数(20,50)
end
-- 玩家数据[cyid].道具:给予超链接道具(cyid,九转金丹,取随机数(100,200),nil,链接,"成功")
__Funfa["九转金丹"]=function(name,hd)
	return name,取随机数(HDPZ[hd]["金丹"][1],HDPZ[hd]["金丹"][2])
end
-- 玩家数据[id].道具:给予超链接道具(id,怪物卡片,取随机数(4,8),nil,链接,"成功")
__Funfa["怪物卡片"]=function(name,hd)
	return name,取随机数(HDPZ[hd]["怪物卡片"][1],HDPZ[hd]["怪物卡片"][2])
end
__Funfa["装备书铁"]=function(name,hd)
	local mc="制造指南书"
	if 取随机数()<40 then
		mc="百炼精铁"
	end
	local 书铁等级=取随机数(qz(HDPZ[hd]["书铁"][1]/10),qz(HDPZ[hd]["书铁"][2]/10))*10 --{150,150} 书铁
	local 书铁种类=取随机数(1,#书铁范围)
	if 取随机数()<=40 then
		书铁种类=取随机数(19,#书铁范围)
	end
	书铁等级=math.floor(书铁等级/10)*10
	return mc,书铁等级,书铁种类
	-- if 取随机数()<=50 then
	--             return "装备书铁" ,{qz(num[1]/10),qz(num[2]/10)} ,"书"
	-- else
	-- 	return "装备书铁" ,{qz(num[1]/10),qz(num[2]/10)} ,"铁"
	-- end
end
__Funfa["百炼精铁"]=function(name,hd)
	local mc="百炼精铁"
	local 书铁等级=取随机数(qz(HDPZ[hd]["书铁"][1]/10),qz(HDPZ[hd]["书铁"][2]/10))*10 --{150,150} 书铁
	local 书铁种类=取随机数(1,#书铁范围)
	if 取随机数()<=40 then
		书铁种类=取随机数(19,#书铁范围)
	end
	书铁等级=math.floor(书铁等级/10)*10
	return mc,书铁等级,书铁种类
end
__Funfa["制造指南书"]=function(name,hd)
	local mc="制造指南书"
	local 书铁等级=取随机数(qz(HDPZ[hd]["书铁"][1]/10),qz(HDPZ[hd]["书铁"][2]/10))*10 --{150,150} 书铁
	local 书铁种类=取随机数(1,#书铁范围)
	if 取随机数()<=40 then
		书铁种类=取随机数(19,#书铁范围)
	end
	书铁等级=math.floor(书铁等级/10)*10
	return mc,书铁等级,书铁种类
end

__Funfa["灵饰书铁"]=function(name,hd) --等级也可以不自己设置
	if 取随机数()<=50 then
	    return "元灵晶石",{(math.random(1,5)*2+4)}
	else
		return "灵饰指南书",{(math.random(1,5)*2+4)}
	end
	-- local mc="灵饰指南书"
	-- if 取随机数()<=55 then
	-- 	mc="元灵晶石"
	-- end
	-- local fanwei={num[1],num[2]}
	-- if num[2]>14 then
	--         fanwei={12,14}
	-- end
	-- return mc,fanwei
	-- 玩家数据[id].道具:给予超链接道具(id,名称,fanwei,nil,链接,"成功")
end
__Funfa["宝宝书铁"]=function(name,hd) --等级也可以不自己设置
	if 取随机数()<=60 then
		return "炼妖石",{(math.random(8,16))}
	else
		return "上古锻造图策",{(math.random(8,16))}
	end
end



function 取暗器(等级)
	local 名称="飞刀"
	if 等级==1 then
		名称="飞刀"
	elseif 等级==2 then
		名称="飞蝗石"
	elseif 等级==3 then
		名称="铁蒺黎"
	elseif 等级==4 then
		名称="无影神针"
	elseif 等级==5 then
		名称="孔雀翎"
	elseif 等级==6 then
		名称="含沙射影"
	elseif 等级==7 then
		名称="回龙镊魂镖"
	elseif 等级==8 then
		名称="寸阴若梦"
	elseif 等级==9 then
		名称="魔睛子"
	elseif 等级==10 then
		名称="顺逆神针"
	end
	return 名称
end
__Funfa["暗器"]=function(name,hd)
	return 取暗器(取随机数(1,10))
end

书铁范围 = {"枪矛","斧钺","剑","双短剑","飘带","爪刺","扇","魔棒","锤","鞭","环圈","刀","法杖","弓弩","宝珠","巨剑","伞","灯笼","头盔","发钗","项链","女衣","男衣","腰带","鞋子"}
function 开始生成环装(lv)

	local 临时等级=lv
	local 临时参数=取随机数(1,#书铁范围)
	if 取随机数()<=40 then
		临时参数=取随机数(19,#书铁范围)
	end
	local 临时序列=临时参数
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
	-- local 临时等级=玩家数据[id].道具.数据[制造格子].子类/10
	-- 计算武器值
	if 临时序列<=18 and 临时等级>=9 then --是武器 10-12是普通光武
		临时等级=取随机数(10,12)
	else
		if 临时等级>=12 then
			临时等级=13
		end
	end
	local 临时类型=装备处理类.打造物品[临时序列][临时等级+1]
	if type(临时类型)=="table" then
		if 临时参数 ==23 then
		 临时类型=临时类型[2]
		elseif 临时参数 ==22 then
		 临时类型=临时类型[1]
		elseif 临时参数 ==20 then
		 临时类型=临时类型[2]
		elseif 临时参数 ==19 then
		 临时类型=临时类型[1]
		else
			临时类型=临时类型[取随机数(1,2)]
		end
	end

	return 装备处理类:生成环装(id,临时等级*10,临时序列,临时类型,"系统产出") --所有系统产出的都给他未鉴定，让他自己鉴定去
end

-- 玩家数据[cyid].道具:取随机装备(cyid,取随机数(5,8))
__Funfa["环装"]=function(name,hd)
	return 开始生成环装(取随机数(5,8)),9999
end

QSJZW={"回梦丹","天眼通符","回梦丹","秘制回梦饮","如意丹","彩果","金柳露","超级金柳露","净瓶玉露","超级净瓶玉露","五宝盒","福禄丹","高级摄灵珠","天赋符","分解符","储灵袋","易经丹","玉葫灵髓"}
__Funfa["杂物"]=function(name,hd)
	return QSJZW[取随机数(1,#QSJZW)],1
end

HDPZ=table.loadstring(读入文件([[全局bl.txt]]))
-- if HDPZ["地宫1至10"] then
--    HDPZ["地宫1至10"].排序=53
-- end
------------------------------------------------------------------------------
XZBL={}
XZBL={


}

for k,v in pairs(XZBL) do
	HDPZ[k]={}
	HDPZ[k]=v
end
local sadwe=table.loadstring(读入文件([[全局新增bl.txt]]))
for k,v in pairs(sadwe) do
	if sadwe[k] then
		print(k)
		HDPZ[k]=sadwe[k]
	end
end
__S服务:输出("修改爆率成功！")
__S服务:输出("新增爆率成功")

