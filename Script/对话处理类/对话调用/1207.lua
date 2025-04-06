-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:53:24
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

__NPCdh111[1207]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号==1  then
      	wb[1] = "你可是需要传送至傲来国？"
      	local xx={"是的送我过去","不了，我还要逛逛"}
      	return {"男人_驿站老板","驿站老板",wb[取随机数(1,#wb)],xx}
    end
	return
end

__NPCdh222[1207 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="驿站老板" then
        if 事件=="是的送我过去" then
          地图处理类:跳转地图(数字id,1092,23,55)
        end
    end
end