-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-01-06 17:30:08
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1040]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号==1 or 编号==2 or 编号==3 or 编号==4 then
		wb[1] = "欢迎来到西梁女国，不要被乱花迷了眼哦#17"
		wb[2] = "喝了子母河的水就能生个孩子，这在方圆五百里也不是什么秘密了#90"
		wb[3] = "安全第一，预防为主#43"
		return {"女兵","西梁女兵",wb[取随机数(1,#wb)],xx}
    elseif 编号==5 then
      wb[1] = "我就是鬼谷道士如今三界最厉害的传人，专职负责降妖伏魔。皇后降至，妖孽现行之时。发力高深之辈挣脱了符咒的束缚，出来危害三界，也是我道人最忙碌的时候。少侠也一起来降妖伏魔吧。"
      xx = {"领取降妖伏魔任务","来此炼化镇妖拘魂铃","取消降妖伏魔任务","我只是路过","","了解炼化镇妖拘魂铃","关于假宝图"}
      return {"男人_道士","鬼谷道士分身",wb[1],xx}
    elseif 编号== 6 then
      	wb[1] = "我可以送你去朱紫国，你要去吗？"
      	local xx = {"是的我要去","我还要逛逛"}
       	return {"男人_驿站老板","驿站老板",wb[sj(1,#wb)],xx}
    elseif 编号 == 7 then
      	wb[1] = "少侠欲前往丝绸之路吗？"
      	local xx = {"我去！我去！","我路过瞧瞧而已"}
       	return {"男人_驿站老板","驿站老板",wb[sj(1,#wb)],xx}
    elseif 编号==8 then
        wb[1] = "行走江湖难免会得到不少财物，将这些财物放到仓库里，实在是个最保险的方法。"
        local xx={"我要进行仓库操作","离开"}
        return {"仓库保管员","仓库管理员",wb[取随机数(1,#wb)],xx}
    elseif 编号==9 then
        wb[1] = "唐僧师徒似乎遇到些麻烦，借助七窍玲珑阵的力量可以将你送到黑松林，你要不要进去？"--#99七巧玲珑阵的老石头最喜欢和年轻人玩了，空闲是过去听听他们的故事也不错。"
        local xx={"好的快送我一程。","婆婆！我还没准备好。"}
        if 玩家数据[数字id].角色:取任务(906)~=0 then
        wb[1]="你的副本已经开启了，是否需要我帮你传送进去？"
        xx={"请送我进去","我等会再进去"}
     end
        return {"女人_孟婆","慕容婆婆",wb[取随机数(1,#wb)],xx}

    elseif 编号 == 15 then
          wb[1] = "如果你在藏宝阁内寄售了角色,可以通过我这里取回哦!!"
          xx = {"藏宝阁物品和银子取回","我要取回角色","我路过瞧瞧而已"}
          return {"太白金星","藏宝阁大使",wb[取随机数(1,#wb)],xx}
    end
	return
end

__NPCdh222[1040 ]=function  (id,数字id,序号,内容)
  local 事件=内容[1]
  local 名称=内容[3]
    if 事件 == "是的我要去" and 名称 == "驿站老板" then
        地图处理类:跳转地图(数字id,1208,128,36)
    elseif 事件 == "我去！我去！" and 名称 == "驿站老板" then
        地图处理类:跳转地图(数字id,1235,465,85)
    elseif 事件=="好的快送我一程。" then
      副本_无底洞:开启无底洞副本(数字id)
    elseif 事件=="请送我进去" then
      任务处理类:副本传送(数字id,906)
    elseif 事件 == "我要取回角色" then
        发送数据(玩家数据[数字id].连接id,118.1,"")
    elseif 事件=="藏宝阁物品和银子取回" then
          local id = 数字id
          if 寄存数据[id] == nil then
            发送数据(玩家数据[id].连接id, 7, "#y/你没有在我这里寄存物品")
            return
          else
            if 寄存数据[id][1].类型 == "仙玉" then
             local 取回数= qz(寄存数据[id][1].数额*0.95)
              玩家数据[id].角色:添加仙玉(取回数,"藏宝阁出售寄存",1)
              table.remove(寄存数据[id],1)
              local 剩余 = 0
              if #寄存数据[id] > 0 then
                剩余 = #寄存数据[id]
              end
              发送数据(玩家数据[id].连接id,7,"#y/领取寄存物品成功,当前剩余"..剩余.."份待领取")
            elseif 寄存数据[id][1].类型 == "物品" then
              self.临时格子=玩家数据[id].角色:取道具格子()
              if self.临时格子==0 then
                发送数据(玩家数据[id].连接id,7,"#y/您当前的包裹空间已满，无法开启")
                return 0
              end
              self.可用id = 玩家数据[id].道具:取新编号()
              玩家数据[id].道具.数据[self.可用id] = 寄存数据[id][1].物品
              玩家数据[id].角色.数据.道具[self.临时格子] = self.可用id
              table.remove(寄存数据[id],1)
              local 剩余 = 0
              if #寄存数据[id] > 0 then
                剩余 = #寄存数据[id]
              end
                发送数据(玩家数据[id].连接id,7,"#y/领取寄存物品成功,当前剩余"..剩余.."份待领取")
            elseif 寄存数据[id][1].类型 == "召唤兽" then
              if #玩家数据[id].召唤兽.数据 >= 7 then
                发送数据(玩家数据[id].连接id,7,"#y/您的召唤兽空间已满，无法购买")
                return 0
              else
                玩家数据[id].召唤兽.数据[#玩家数据[id].召唤兽.数据+1] = 寄存数据[id][1].召唤兽
              end
              table.remove(寄存数据[id],1)
              local 剩余 = 0
              if #寄存数据[id] > 0 then
                剩余 = #寄存数据[id]
              end
                发送数据(玩家数据[id].连接id,7,"#y/领取寄存物品成功,当前剩余"..剩余.."份待领取")
            end
            if #寄存数据[id] <= 0  then
              寄存数据[id] = nil
            end
          end
        end
    end
