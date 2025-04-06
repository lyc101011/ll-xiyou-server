-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 12:55:11
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

__NPCdh111[1206]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
      wb[1] = "少侠挑战的成果如何，一切还算顺利么"
      local xx = {"我要回长安","我点错了"}
      return{"太白金星","长安传送人",wb[取随机数(1,#wb)],xx}
    elseif 编号 == 2 then
      wb[1] = "你准备好了要挑战我们139界武神坛冠军队伍了么"
      local xx = {"准备好了","我点错了"}
      return{"骨精灵","歌泣メ",wb[取随机数(1,#wb)],xx}
    elseif 编号 == 3 then
      wb[1] = "你准备好了要挑战我们137界武神坛冠军队伍了么"
      local xx = {"准备好了","我点错了"}
      return{"鬼潇潇","Tercel°倾寒",wb[取随机数(1,#wb)],xx}
    elseif 编号 == 4 then
      wb[1] = "你准备好了要挑战我们133界武神坛冠军队伍了么"
      local xx = {"准备好了","我点错了"}
      return{"玄彩娥","弑ㄨ魔法琳琳",wb[取随机数(1,#wb)],xx}
    elseif 编号 == 5 then
      wb[1] = "你准备好了要挑战我们132界武神坛冠军队伍了么"
      local xx = {"准备好了","我点错了"}
      return{"杀破狼","江湖笑で",wb[取随机数(1,#wb)],xx}
    elseif 编号 == 6 then
      wb[1] = "你准备好了要挑战我们131界武神坛冠军队伍了么"
      local xx = {"准备好了","我点错了"}
      return{"龙太子","史竟呈来也",wb[取随机数(1,#wb)],xx}
    elseif 编号 == 7 then
      wb[1] = "你准备好了要挑战我们128界武神坛冠军队伍了么"
      local xx = {"准备好了","我点错了"}
      return{"神天兵","ぃ☆十月．",wb[取随机数(1,#wb)],xx}
    elseif 编号 == 8 then
      wb[1] = "你准备好了要挑战我们125界武神坛冠军队伍了么"
      local xx = {"准备好了","我点错了"}
      return{"玄彩娥","玲珑づ小小龙",wb[取随机数(1,#wb)],xx}
    elseif 编号 == 9 then
      wb[1] = "你准备好了要挑战我们123界武神坛冠军队伍了么"
      local xx = {"准备好了","我点错了"}
      return{"杀破狼","然こ低调",wb[取随机数(1,#wb)],xx}
    elseif 编号 == 10 then
      wb[1] = "你准备好了要挑战我们122界武神坛冠军伍了么"
      local xx = {"准备好了","我点错了"}
      return{"神天兵","ぃ☆给力．",wb[取随机数(1,#wb)],xx}
    end
	return
end

__NPCdh222[1206 ]=function  (id,数字id,序号,内容)
  local 事件=内容[1]
  local 名称=内容[3]
  if 名称=="长安传送人" then
    if 事件=="我要回长安" then
      地图处理类:跳转地图(数字id,1001,358,35)
    end
  elseif 名称=="歌泣メ" then
    if 事件=="准备好了" then
      战斗准备类:创建战斗(数字id+0,110100)
    end
  elseif 名称=="Tercel°倾寒" then
    if 事件=="准备好了" then
      战斗准备类:创建战斗(数字id+0,110101)
    end
  elseif 名称=="弑ㄨ魔法琳琳" then
    if 事件=="准备好了" then
      战斗准备类:创建战斗(数字id+0,110102)
    end
  elseif 名称=="江湖笑で" then
    if 事件=="准备好了" then
      战斗准备类:创建战斗(数字id+0,110103)
    end
  elseif 名称=="史竟呈来也" then
    if 事件=="准备好了" then
      战斗准备类:创建战斗(数字id+0,110104)
    end
  elseif 名称=="ぃ☆十月．" then
    if 事件=="准备好了" then
      战斗准备类:创建战斗(数字id+0,110105)
    end
  elseif 名称=="玲珑づ小小龙" then
    if 事件=="准备好了" then
      战斗准备类:创建战斗(数字id+0,110106)
    end
  elseif 名称=="然こ低调" then
    if 事件=="准备好了" then
      战斗准备类:创建战斗(数字id+0,110107)
    end
  elseif 名称=="ぃ☆给力．" then
    if 事件=="准备好了" then
      战斗准备类:创建战斗(数字id+0,110108)
    end
  end
end