-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 16:43:25
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

__NPCdh111[1026]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
      wb[1] = "等级达到50级且五人组队可以在我这里开启乌鸡国副本#Y（副本每种类型每日只可以领取一次，每日24点刷新）"
      local xx = {"我要开启乌鸡国副本","我只是一个路过的"}
      if 玩家数据[数字id].角色:取任务(120)~=0 then
        wb[1]="你的副本已经开启了，是否需要我帮你传送进去？"
        xx={"请送我进去","我等会再进去"}
      end
      return{"男人_书生","吴举人",wb[取随机数(1,#wb)],xx}
    end
	return
end

__NPCdh222[1026 ]=function  (id,数字id,序号,内容)
  local 事件=内容[1]
  local 名称=内容[3]
  if 名称=="吴举人" then
    if 事件=="我要开启乌鸡国副本" then
      副本_乌鸡国:开启副本(数字id)
    elseif 事件=="请送我进去" then
      任务处理类:副本传送(数字id,1)
    end
  end
end