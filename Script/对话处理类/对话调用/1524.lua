-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 11:58:41
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

__NPCdh111[1524]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "角色所持有的金钱不能超过6亿，银行最大存款不能超过3亿"
		local xx = {"存款取款","我只是来看看"}
		return{"男人_财主","钱庄老板",wb[取随机数(1,#wb)],xx}
	end
	return
end

__NPCdh222[1524 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="钱庄老板" then
        if 事件=="存款取款" then
          发送数据(id,216,{存银=玩家数据[数字id].角色.存银,银子=玩家数据[数字id].角色.银子})
        end
  	end
end