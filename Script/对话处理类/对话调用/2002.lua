-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:43:47
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

__NPCdh111[2002]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "无源之水供养吾已有千年，如今吾却再感受不到水中的爱意#78，必然是那道人做了手脚。诸位可沿吾的树干寻找线索。"
		xx = {"回到秽气巢林","我就过来静静的看着你。"}
		return {"","灵木宝树树根",wb[取随机数(1,#wb)],xx}
	end
	return
end
__NPCdh222[2002]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 事件=="回到秽气巢林" then
        地图处理类:跳转地图(数字id,1230,118,82)
    end
end