-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-08-19 10:42:26
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__GWdh111[212]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
  	对话数据.模型=任务数据[标识].模型
  	对话数据.名称=任务数据[标识].名称
  	if 任务数据[标识].zhandou==nil then
      对话数据.对话="喜迎新春大吉大利，享好运"
      对话数据.选项={"福禄新春过大年","我再准备准备"}
    else
      对话数据.对话="我正在战斗中，请勿打扰。"
    end
	return 对话数据
end

__GWdh222[212]=function (连接id,数字id,序号,内容)
  local 事件=内容[1]
  local 名称=内容[3]
  if 事件=="福禄新春过大年" then
    if 任务数据[玩家数据[数字id].地图单位.标识].zhandou~=nil then 常规提示(数字id,"#Y/对方正在战斗中") return  end
    if 取队伍人数(数字id)<1  and 调试模式==false then 常规提示(数字id,"#Y挑战最少必须由五人进行") return  end
    if 取等级要求(数字id,30)==false and 调试模式==false then 常规提示(数字id,"#Y/队伍中有成员等级不符合要求") return  end
    战斗准备类:创建战斗(数字id+0,100098,玩家数据[数字id].地图单位.标识)
    任务数据[玩家数据[数字id].地图单位.标识].zhandou=true
    玩家数据[数字id].地图单位=nil
    return
  end
end

function 设置任务212()
  local 地图范围={1193,1506,1091,1110,1514}
  local 地图=地图范围[取随机数(1,#地图范围)]
  local xy=地图处理类.地图坐标[地图]:取随机点()
  local 提示名称=""
  --xy={x=25,y=18}
  local 结束时间=3500
  local 数量=取随机数(1,1)
  local 地图=地图范围[取随机数(1,#地图范围)]
  local x待发送数据={}
  x待发送数据[地图]={}
  for i=1,数量 do
    local 任务id="_"..i.."_"..取随机数(11,88).."_212_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
    随机序列=随机序列+1
    local xy=地图处理类.地图坐标[地图]:取随机点()
    任务数据[任务id]={
      id=任务id,
      起始=os.time(),
      结束=结束时间,
      玩家id=0,
      队伍组={},
      名称="福禄仙人",
      模型="葫芦宝贝",
      x=xy.x,
      y=xy.y,
      地图编号=地图,
      地图名称=取地图名称(地图),
      类型=212
    }
    table.insert(x待发送数据[地图], 地图处理类:批量添加单位(任务id))
  end
  for n, v in pairs(地图处理类.地图玩家[地图]) do
    if n~=id and 地图处理类:取同一地图(地图,id,n,1)  then
      发送数据(玩家数据[n].连接id,1021,x待发送数据[地图])
    end
  end
  x待发送数据={}
  广播消息({内容=format("#W/福禄仙人处在了#G/%s#W/，还请各位英雄侠士赶紧去找到他。",取地图名称(地图)),频道="xt"})
end

function rwgx212(任务id)
  if os.time()-任务数据[任务id].起始>=任务数据[任务id].结束 and 任务数据[任务id].结束 ~= 99999999 then -- 任务时间到期
    if 任务数据[任务id].zhandou==nil  then
      地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
      任务数据[任务id]=nil
    end
  end
end