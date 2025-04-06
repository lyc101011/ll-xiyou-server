-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-07-20 17:39:26
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:50:22
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:17:17
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1226]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号==1 then
				wb[1] = "走过路过不要错过~骏马骆驼一应俱全，保证安全、舒适、快捷、方便地让客官抵达目的地！那么客官想前往哪里呢？"
				local xx={"我要前往长安城","旅费不够，下次再说"}
				return {"男人_驿站老板","驿站老板",wb[取随机数(1,#wb)],xx}
		elseif 编号==2  then
				wb[1] = "押镖可是极其危险的活，如果没有足够的能力，还是不要随意接镖的好。"
				return {"男人_店小二","镖局学童",wb[取随机数(1,#wb)],xx}
		elseif 编号==3 then
				local xx={}
				if 宝藏山数据.开关==false then
					wb[1] = "宝藏山活动在每日11-12点、19-20点期间开放。当前不是活动时间."
				else
					wb[1] = "宝藏山活动已经开启，你是否需要进宝藏山里头寻宝呢？"
					xx={"请送我进去","我只是路过"}
				end
				return {"男人_土地","土地公公",wb[取随机数(1,#wb)],xx}
		elseif 编号==4 then
				wb[1] = "大音希声，重剑无锋，大巧若拙，大象无形。灵性所至之时，摘叶飞花，皆可伤人。相传，三界间曾有绝顶高手，通晓世间诸般武学玄妙，更以天地为师，万物为友，领悟出一套玄妙功法。功夫不负有心人，我搜寻数年终得此秘笈半部，虽是残章断简，若得领悟，亦可获得令人目眩神迷的招式效果。"
				local xx={"角色焕彩染色","我想了解一下"}
				return {"女人_万圣公主","炫彩大使",wb[取随机数(1,#wb)],xx}
		elseif 编号==5 then
				wb[1] = "本大师也曾游走西域，习得一些新鲜的巧匠秘籍。可以将一些闪闪发光的武器变个造型#2。想试试吗？"
				local xx={"我想进行光武拓印","我要还原装备拓印","我要进行武器染色","我想了解一下"}
				return {"男人_武器店老板","武器大师",wb[取随机数(1,#wb)],xx}
		end
	return
end

__NPCdh222[1226 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 名称=="驿站老板" then
		if 事件=="我要前往长安城" then
			地图处理类:跳转地图(数字id,1001,363,198)
		end
	elseif 名称=="土地公公" then
		if 事件=="请送我进去" then
			EnterUpMOB203(数字id)
		end
	elseif 名称=="炫彩大使" then
		if 事件=="角色焕彩染色" then
			发送数据(id,104,{类型="角色焕彩"})
		end
	elseif 名称=="武器大师" then
		if 事件=="我想进行光武拓印" then
		    发送数据(id,307,{类型="光武拓印"})
		elseif 事件=="我要进行武器染色" then
		    发送数据(id,104,{类型="武器焕彩"})
	    elseif 事件=="我要还原装备拓印" then
	    	添加最后对话(数字id,"还原装备拓印的原造型后，装备的光武拓印将会消失，你确定要这样操作吗？（该操作免费）",{"我确定还原","不好意思手抖了"})
    	elseif 事件=="我确定还原" then
    		玩家数据[数字id].给予数据={类型=1,id=0,事件="我要还原装备拓印"}
            发送数据(id,3530,{道具=玩家数据[数字id].道具:索要道具1(数字id),名称="武器大师",类型="NPC",等级="无"})
		end
	end
end