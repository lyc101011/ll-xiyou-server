local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数
__NPCdh111[6037]=function (ID,编号,页数,已经在任务中,数字id)
  local wb = {}
  local xx = {}
 if 编号 == 1 then
    wb[1] = "天宫重地，你这妖猴休得放肆！"
    return {"男人_杨戬","杨戬",wb[1],xx}
 elseif 编号 == 2 then
    wb[1] = "天宫重地，你这妖猴休得放肆！"
    return {"李靖","李靖",wb[1],xx}
 elseif 编号 == 3 then
    wb[1] = "妖孽休得无理，我已差遣佑圣真君请来力大无穷、法力无边的上古雷神对付你，你可别太放肆了！"
    local xx = {"谁来我都不怕","那我可得准备一番"}
    return {"男人_玉帝","玉皇大帝",wb[1],xx}
 elseif 编号 == 4 then
    wb[1] = "天宫重地，你这妖猴休得放肆！"
    return {"男人_哪吒","哪吒",wb[1],xx}
    end
  return
end

__NPCdh222[6037]=function  (id,数字id,序号,内容)
  local 事件=内容[1]
  local 名称=内容[3]
  local 任务id=玩家数据[数字id].角色:取任务(70)
  if 任务数据[任务id] == nil then 添加最后对话(数字id,"你没有这样的任务！") return  end
  local 副本id=任务数据[任务id].副本id
  if 名称=="玉皇大帝" and 事件=="谁来我都不怕" then
    if 玩家数据[数字id].队伍==0 then 常规提示(数字id,"#Y必须组队才能触发该活动") return end
    if 取队伍人数(数字id)<1 then 常规提示(数字id,"#Y/挑战此任务最少要有1人") return  end
    if 取等级要求(数字id,60)==false then 常规提示(数字id,"#Y/挑战次任务至少要达到60级") return  end
    if 玩家数据[数字id].zhandou ~= 0 then return end
    战斗准备类:创建战斗(数字id+0,155583,玩家数据[数字id].角色:取任务(70))
  end
end