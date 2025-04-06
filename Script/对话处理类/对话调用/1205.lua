-- @Author: baidwwy
-- @Date:   2024-08-21 11:47:39
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-08-31 15:12:22
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1205]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
      if 蚩尤次数[数字id]==nil then
       蚩尤次数[数字id]={总计=0}
      end
      wb[1] = "尔等蝼蚁妄图封印我简直事痴心妄想，#G今日剩余挑战次数:#R "..2-蚩尤次数[数字id].总计..""
      local xx = {"开启挑战","我只是来看看"}
      return{"蚩尤","蚩尤元神",wb[取随机数(1,#wb)],xx}
    elseif 编号 == 2 then
      wb[1] = "上仙我可以把你传送到武神坛去挑战历届封印蚩尤的勇士镜像"
      local xx = {"我准备好了请送我们过去","我只是来看看"}
      return{"巫师","武神坛传送",wb[取随机数(1,#wb)],xx}
    end
	return
end

__NPCdh222[1205 ]=function  (id,数字id,序号,内容)
  local 事件=内容[1]
    local 名称=内容[3]
  if 名称=="武神坛传送" then
    if 事件=="我准备好了请送我们过去" then
      地图处理类:跳转地图(数字id,1206,185,45)
    end
  elseif 名称=="蚩尤元神" then
    if 事件=="开启挑战" then
      if 蚩尤次数[数字id]==nil then
         蚩尤次数[数字id]={总计=0}
     end
    if 蚩尤次数[数字id].总计>=2 then
    常规提示(数字id,"#Y少侠今日蚩尤挑战次数已用完,明日再来挑战吧。")
    return
    end
      战斗准备类:创建战斗(数字id,155555,1)
    end
  end
end

function 胜利MOB_155555(胜利id,战斗数据,id组)
  for n=1,#id组 do
    local id=id组[n]
    local 等级=取队伍平均等级(玩家数据[id].队伍,id)
    local 经验=10000000
    local 银子=1000000
    玩家数据[id].角色:添加经验(经验*HDPZ["蚩尤元神"].经验,"蚩尤元神")
    玩家数据[id].角色:添加银子(银子*HDPZ["蚩尤元神"].银子,"蚩尤元神",1)
    玩家数据[id].角色:添加每日活跃度(id, 10)
    if 蚩尤次数[id]==nil then
       蚩尤次数[id]={总计=0}
    end
    蚩尤次数[id].总计=蚩尤次数[id].总计+1
    if 玩家数据[id].角色.参战信息~=nil then
      玩家数据[id].召唤兽:获得经验(玩家数据[id].角色.参战宝宝.认证码,math.floor(经验*0.1),id,"蚩尤元神")
      end
    local 奖励参数=取随机数()
      if 取随机数()<=HDPZ["蚩尤元神"].爆率 then
        local 链接 = {提示=format("#P(蚩尤元神)#W玩家#Y%s#W最好再不懈坚持下，放出大招直接秒杀蚩尤获得最终奖励的",玩家数据[id].角色.名称),频道="hd",结尾="#W作为奖励！#80"}
                          local 名称,数量,参数=生成产出(产出物品计算(HDPZ["蚩尤元神"].ITEM),"蚩尤元神")
                          if 数量== 9999 then --环
                            玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
                          else
                                      玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
                          end
      end
    end
  end



