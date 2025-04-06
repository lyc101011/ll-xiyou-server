-- @Author: baidwwy
-- @Date:   2024-08-19 09:41:53
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-09-02 18:48:18
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数
local 知了先锋 = class()

function 知了先锋:活动定时器()
    if 服务端参数.分钟=="5" and 服务端参数.秒+0==2 then
        self:开启()
    elseif 服务端参数.分钟=="35" and 服务端参数.秒+0==2 then
        self:开启()
    end
end
function 知了先锋:开启(id)
    local 临时数量=取随机数(50,60)
    local 地图范围={1501}
    local 地图=地图范围[取随机数(1,#地图范围)]
    local 地图名称=取地图名称(地图)
    local 模型="知了王"
    local 名称 ="知了先锋"
    for n=1,临时数量 do
        local 任务id="9999_"..取随机数(1,99).."_210_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
        随机序列=随机序列+1
        xy=地图处理类.地图坐标[地图]:取随机点()
        任务数据[任务id]={
            id=任务id,
            起始=os.time(),
            结束=1800,
            销毁=true,
            玩家id=0,
            名称=名称,
            模型=模型,
            x=xy.x,
            y=xy.y,
            地图编号=地图,
            地图名称=地图名称,
            类型=210
        }
        地图处理类:添加单位(任务id)
    end
    广播消息({内容=format("#W/一批知了先锋出现在了#G/%s#W/处捣乱，还请各位英雄侠士赶紧去降服它们。#G(难度1)",取地图名称(地图)),频道="xt"})
end

__GWdh111[210]=function(连接id,数字id,序列,标识,地图)
    local 对话数据={}
    对话数据.模型=任务数据[标识].模型
    对话数据.名称=任务数据[标识].名称
    if 任务数据[标识].zhandou==nil then
        对话数据.对话="我是知了先锋#89"
        对话数据.选项={"消灭知了先锋","我只是路过"}
    else
        对话数据.对话="我正在战斗中，请勿打扰。"
    end
    return 对话数据
end

__GWdh222[210]=function (连接id,数字id,序号,内容)
    local 事件=内容[1]
    local 名称=内容[3]
    if 事件=="消灭知了先锋" then
        if 任务数据[玩家数据[数字id].地图单位.标识].zhandou~=nil then 常规提示(数字id,"#Y/对方正在战斗中") return  end
        if 玩家数据[数字id].队伍==nil then
            常规提示(数字id,"#Y/请先组队！")
            return
        end
        战斗准备类:创建战斗(数字id+0,140102,玩家数据[数字id].地图单位.标识)
        任务数据[玩家数据[数字id].地图单位.标识].zhandou=true
        玩家数据[数字id].地图单位=nil
        return
    end
end

function 知了先锋:战斗胜利处理(id组,战斗类型,任务id)
    if 任务数据[任务id]==nil then
        return
    end
    for n=1,#id组 do
        local cyid=id组[n]
        local 等级=玩家数据[cyid].角色.等级
        local 经验=qz(等级*取随机数(1800,1950))
        local 银子=qz(等级*160)+16000
        玩家数据[cyid].角色:添加经验(经验,"知了先锋",1)
        玩家数据[cyid].角色:添加银子(qz(银子),"知了先锋",1)
        玩家数据[cyid].角色:添加储备(qz(银子*0.3),"知了先锋",1)
        if  math.random(1,100) < 15  then
            local 链接 = {提示=format("#S(知了先锋)#Y意外惊喜，/%s#Y在知了先锋的战斗中额外获得了",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#80"}
            local 名称={"金柳露","魔兽要诀","超级金柳露","月华露","五宝盒"}
            local 临时道具= 名称[math.random(1,#名称)]
            玩家数据[cyid].道具:给予超链接道具(cyid,临时道具,nil,nil,链接)
        end
    end
    地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
    任务数据[任务id]=nil
end

return 知了先锋