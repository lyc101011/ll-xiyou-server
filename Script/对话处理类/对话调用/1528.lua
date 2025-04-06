-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 16:48:07
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

__NPCdh111[1528]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if  编号 == 1 then
		wb[1] = "这法明长老是从金山寺过来的，你若有诉求，可直接找他。"
		  --xx = {"水陆大会","我点错了"}
		return {"男人_胖和尚","慧明",wb[sj(1,#wb)],xx}
	elseif 编号 == 2 then
		wb[1] = "得即是失，失即是得，世事本是过往烟云，不必太过看重"
		wb[2] = "不可说，不可说"
		wb[3] = "施主是来上香的吗？"
		wb[4] = "随心、随缘、随性。"
		wb[5] = "一念愚即般若绝，一念智即般若生。"
		local xx = {"我要学习打坐","我只是路过"}
		return {"男人_老和尚","法明长老",wb[sj(1,#wb)],xx}
	end
	return
end

__NPCdh222[1528 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="法明长老" then
        if 事件=="我要学习打坐" then
          玩家数据[数字id].角色:学习剧情技能(数字id,"打坐",3,5)
        end
    end
end