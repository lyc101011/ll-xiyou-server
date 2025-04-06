-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:40:53
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

__NPCdh111[1511]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
        wb[1] = "这位朋友天资不错，是个练武的好材料。有没有兴趣来我们帮派深造啊。"
        -- xx = {"看锤","路过"}
		return {"男人_师爷","帮派师爷藍",wb[1],xx}
	elseif 编号 == 2 then
		wb[1] = "这位朋友天资不错，是个练武的好材料。有没有兴趣来我们帮派深造啊。"
		-- xx = {"看锤","路过"}
		return {"男人_师爷","帮派师爷紅",wb[1],xx}
	elseif 编号 == 3 or 编号 == 4 then
		wb[1] = "这位少侠，看你这么严肃的样子，有没有兴趣来我们帮派深造啊？"
		xx = {"我要离开此场地","路过"}
		return {"男人_老伯","帮派竞赛接引人",wb[1],xx}
	end
	return
end

__NPCdh222[1511 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 名称=="帮派竞赛接引人" then
		if 事件=="我要离开此场地" then
			帮派PK:对话内容调用(数字id,名称,事件)
		end
	end
end


-------------------
__NPCdh111[2010]=function (ID,编号,页数,已经在任务中,数字id) --蓝
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "这位少侠，看你这么严肃的样子，是不是觉得我们帮的兵种搭配和兵力分布有问题？如果本方阵营的参战人数≤0，会直接判敌方胜利哦#24"
		xx = {"送我离开这里","我没什么事"}
		return{"男人_将军","帮派竞赛接引人",wb[取随机数(1,#wb)],xx}
	elseif 编号 == 3 then
		if 帮派PK.正式开始 then
			地图处理类:跳转地图(数字id,2012,19,19) --中立区
			常规提示(数字id,"#Y/您已进入中立地带，小心四周，以免被敌人偷袭")
			return{"男人_老伯","传送人1号"}
		else
			添加最后对话(数字id,"活动还未开始，暂时不能过去哦")
		end
	end
	return
end

__NPCdh222[2010 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 名称=="帮派竞赛接引人" then
		if 事件=="送我离开这里" then
			帮派PK:对话内容调用(数字id,名称,事件)
		end
	end
end
-------------------

-------------------
__NPCdh111[2011]=function (ID,编号,页数,已经在任务中,数字id) --红
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "这位少侠，看你这么严肃的样子，是不是觉得我们帮的兵种搭配和兵力分布有问题？如果本方阵营的参战人数≤0，会直接判敌方胜利哦#24"
		xx = {"送我离开这里","我没什么事"}
		return{"男人_将军","帮派竞赛接引人",wb[取随机数(1,#wb)],xx}
	elseif 编号 == 3 then
		if 帮派PK.正式开始 then
			地图处理类:跳转地图(数字id,2012,110,108) --中立区
			常规提示(数字id,"#Y/您已进入中立地带，小心四周，以免被敌人偷袭")
			return{"男人_老伯","传送人1号"}
		else
			添加最后对话(数字id,"活动还未开始，暂时不能过去哦")
		end
	end
	return
end

__NPCdh222[2011 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 名称=="帮派竞赛接引人" then
		if 事件=="送我离开这里" then
			帮派PK:对话内容调用(数字id,名称,事件)
		end
	end
end
-------------------
__NPCdh111[2012]=function (ID,编号,页数,已经在任务中,数字id) --红
	local wb = {}
	local xx = {}
	if 编号 == 1 then --左
		地图处理类:跳转地图(数字id,2010,6,100)
		if 帮派PK.玩家表["红方"].成员[数字id]~=nil then
		    常规提示(数字id,"#Y/你已进入敌方基地，请提高警惕")
		elseif 帮派PK.玩家表["蓝方"].成员[数字id]~=nil then
			常规提示(数字id,"#Y/你回到了基地")
		end
		return{"男人_老伯","传送人1号"}
	elseif 编号 == 2 then --右
		地图处理类:跳转地图(数字id,2011,6,100)
		if 帮派PK.玩家表["蓝方"].成员[数字id]~=nil then
		    常规提示(数字id,"#Y/你已进入敌方基地，请提高警惕")
		elseif 帮派PK.玩家表["红方"].成员[数字id]~=nil then
			常规提示(数字id,"#Y/你回到了基地")
		end
		return{"男人_老伯","传送人1号"}
	end
	return
end