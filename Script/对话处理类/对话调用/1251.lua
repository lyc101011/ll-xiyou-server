-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:26:55
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

__NPCdh111[1251]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "学了本领要用在正途，不许恃强凌弱。"
		wb[2] = "修行要注重基础，持之以恒，切忌好高骛远。"
		wb[3] = "想成为仙界的精英，还要下一番苦功夫啊～"
		wb[4] = "我观中的人参果树乃是混沌初分，鸿蒙初判，天地未开之际产成的灵根。"
		wb[5] = "师傅领进门，修行在个人。本门法术之精妙还望各位多多领悟。"
		local xx = {"交谈","给予","乾元丹学习","师门任务","学习技能","我想切换流派"}
		if 玩家数据[数字id].角色.门派 == "无" or 玩家数据[数字id].角色.门派 == "无门派" then
	        xx={"我还想去其他门派看看……","请收我为徒"}
	    elseif 玩家数据[数字id].角色.门派~="花果山" then
	        xx={}
	    end
		return {"齐天大圣","齐天大圣",wb[sj(1,#wb)],xx,"门派师傅"}
	end
	return

end

__NPCdh222[1251 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="齐天大圣" then
        local 门派类型="花果山"
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