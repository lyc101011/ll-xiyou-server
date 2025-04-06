-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:44
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-08-16 17:54:09
local random = 取随机数
local 坐骑资料库 = class()
local 读取坐骑 = require("script/属性控制/坐骑")
local insert = table.insert
function 坐骑资料库:初始化() end

function 坐骑资料库:获取坐骑(id,模型,名称,类型,属性)
	local n = 读取坐骑()
	local mx = 模型 == "小毛头" or 模型 == "小丫丫"
	if mx then
		类型 = "孩子"
	end
	n:置新对象(模型,名称,类型,属性,id)
	if #玩家数据[id].角色.坐骑列表 <= 6 then
		insert(玩家数据[id].角色.坐骑列表, n)
		常规提示(id,"你获得了一个新的坐骑#G"..模型)
		发送数据(玩家数据[id].连接id, 61, 玩家数据[id].角色.坐骑列表)
	else
		常规提示(id,"携带的坐骑已到上限无法继续获得坐骑！")
	end
end

-- function 坐骑资料库:增加坐骑(id,坐骑)
-- 	if 坐骑==nil then return end
-- 	local 坐骑物品 ={坐骑,nil}--"空"
-- 	if 玩家数据[id].角色.坐骑列表==nil  then
-- 	    玩家数据[id].角色.坐骑列表={}
-- 	end
-- 	insert(玩家数据[id].角色.坐骑列表, 坐骑物品)
-- end
function 坐骑资料库:取可转换坐骑(模型,种族)
	if 模型 == "偃无师" and 模型 == "鬼潇潇" and 模型 == "骨精灵" and 模型 == "桃夭夭" and 模型 == "龙太子" then
	    return {"宝贝葫芦"}
	end
	if 种族 == "人" then
		return {"欢喜羊羊","汗血宝马","宝贝葫芦","神气小龟"}
	elseif 种族 == "魔" then
		return {"魔力斗兽","披甲战狼","宝贝葫芦","神气小龟"}
	elseif 种族 == "仙" then
		return {"闲云野鹤","云魅仙鹿","宝贝葫芦","神气小龟"}
	end
end

function 坐骑资料库:取坐骑库(人物) --这里才对
	--local zqsQQ = "宝贝葫芦"
	if 人物.种族 == "人"  then
		local zqsQ = random(1,2)
		if zqsQ==1 then
		    zqsQQ = "汗血宝马"
		else
			zqsQQ = "欢喜羊羊"
		end
	elseif 人物.种族 == "魔"  then
		local zqsQ = random(1,2)
		if zqsQ==1 then
		    zqsQQ = "魔力斗兽"
		else
			zqsQQ = "披甲战狼"
		end
	elseif 人物.种族 == "仙"  then
		local zqsQ = random(1,2)
		if zqsQ==1 then
		   zqsQQ = "闲云野鹤"
		else
		   zqsQQ = "云魅仙鹿"
		end
	end
	if random(1,4)==1 and 人物.模型 ~= "偃无师" and 人物.模型 ~= "鬼潇潇" and 人物.模型 ~= "骨精灵" and 人物.模型 ~= "桃夭夭" and 人物.模型 ~= "龙太子" then
		zqsQQ = "神气小龟"
	end
	return zqsQQ
end

function 坐骑资料库:取坐骑饰品(bb)
	if bb=="云魅仙鹿" then
	    return ""
	end
end

return 坐骑资料库