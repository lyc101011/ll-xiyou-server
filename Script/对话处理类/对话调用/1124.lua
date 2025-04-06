-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 17:55:16
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:17:16
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1124]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "地狱不空，誓不成佛。"
		wb[2] = "修行贵在持之以恒，切忌浮躁自满。"
		wb[3] = "地府法术诡异玄妙，只传授有缘之人。"
		wb[4] = "地府弟子学有所成是师父我最大的心愿。"
		wb[5] = "要想在魔界扬名，还要多加历练才是啊。"
		wb[6] = "恶业将盈，地狱相现。"
		local xx = {"交谈","给予","乾元丹学习","师门任务","学习技能","我想切换流派"}
		if 玩家数据[数字id].角色.门派 == "无" or 玩家数据[数字id].角色.门派 == "无门派" then
			xx={"我还想去其他门派看看……","请收我为徒"}
    	elseif 玩家数据[数字id].角色.门派~="阴曹地府" then
	   		xx={}
		end
		if 玩家数据[数字id].角色:取任务(300)~=0 then
			local 任务id= 玩家数据[数字id].角色:取任务(300)
			if 任务数据[任务id].人物=="地藏王" then
				wb={}
				xx={}
				wb[1] = "原来是你给我送东西来了。怎么改行当镖师了？"
				押镖:完成押镖任务(任务id,数字id,任务数据[任务id].人物地图)
			else
				wb={}
				xx={}
			    wb[1] = "少侠你的镖是不是运送错了地方呢，再仔细看看任务提示！"
			end
		end
		return {"地藏王","地藏王",wb[sj(1,#wb)],xx,"门派师傅"}
	end
	return
end

__NPCdh222[1124 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	 if 名称=="地藏王" then
        local 门派类型="阴曹地府"
        if 事件=="请收我为徒" then
          玩家数据[数字id].角色:加入门派(数字id,门派类型)
        elseif 事件=="交谈" then
          --玩家数据[数字id].角色:门派交谈(数字id,门派类型)
        elseif 事件=="师门任务" then
          玩家数据[数字id].角色:门派任务(数字id,门派类型)

        elseif 事件=="学习技能" then
          --local 临时数据=玩家数据[数字id].角色:取总数据()
          发送数据(id,31,玩家数据[数字id].角色:取总数据1())
          发送数据(id,32)
        end
    end
end