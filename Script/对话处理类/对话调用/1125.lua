-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 17:56:56
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

__NPCdh111[1125]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
  if 编号 == 1 then
    wb[1] = "我可以帮你传送到长安城，你是否需要我对你进行传送？"
    local xx={"请送我过去","我暂时不想去"}
    return {"白无常","白无常",wb[sj(1,#wb)],xx}
  elseif 编号 == 2 then
    wb[1] = "幽冥阴界的鬼类大都生前怀有怨气执念,死后化为强大异能。然而鬼族的能力也有高低之分,等闲小鬼尚好对付,鬼族中有一种凶残暴戾的千年厉鬼最难降服,他们修行干年,戾气太重,如今不少干年厉鬼潜伏阳界残害无辜百姓,少侠可否助我替天行道?"
    local xx={"千年厉鬼这么厉害吗？我去见识见识！","我只是路过此地"}
    if 玩家数据[数字id].角色:取任务(14)~=0 then
      xx={"这厉鬼这么厉害，我还是不去了","我只是路过此地"}
    end
    return {"黑无常","黑无常",wb[sj(1,#wb)],xx}
  end
  return
end

__NPCdh222[1125 ]=function  (id,数字id,序号,内容)
  local 事件=内容[1]
  local 名称=内容[3]
  if 名称=="白无常" then
    if 事件=="请送我过去" then
      地图处理类:跳转地图(数字id,1001,359,34)
    end
  elseif 名称=="黑无常" then
    if 事件=="千年厉鬼这么厉害吗？我去见识见识！" then
      设置任务14(数字id)
    elseif 事件== "这厉鬼这么厉害，我还是不去了" then
      local 队伍id=玩家数据[数字id].队伍
      local 任务id=玩家数据[数字id].角色:取任务(14)
      if 任务id==0 then
          常规提示(数字id,"#Y/你都没接任务，何来取消？")
          return
      end
      if 队伍id~=0 then
        for n=1,#队伍数据[队伍id].成员数据 do
          玩家数据[队伍数据[队伍id].成员数据[n]].角色:取消任务(任务id)
          玩家数据[队伍数据[队伍id].成员数据[n]].角色.鬼王数据.次数=0
          常规提示(队伍数据[队伍id].成员数据[n],"#Y/已经取消任务，同时任务总数清零")
        end
      else
        玩家数据[数字id].角色:取消任务(任务id)
        玩家数据[数字id].角色.鬼王数据.次数=0
        常规提示(数字id,"#Y/已经取消任务，同时任务总数清零")
      end
    end
  end
end