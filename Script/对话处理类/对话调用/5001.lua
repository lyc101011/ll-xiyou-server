-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:51:42
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

__NPCdh111[5001]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号==1  then
      	wb[1] = "我可以帮助你离开本场景传送至宝象国，你需要我帮你进行传送吗？"
      	local xx={"送我过去","我再转转"}
      	return {"男人_土地","土地公公",wb[取随机数(1,#wb)],xx}
    end
	return
end

__NPCdh222[5001 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="土地公公" then
        if 事件=="送我过去" then
          地图处理类:跳转地图(数字id,1226,115,15)
        end
    end
end