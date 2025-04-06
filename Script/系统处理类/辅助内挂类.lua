-- @Author: baidwwy
-- @Date:   2024-12-14 19:53:29
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-01-06 08:32:12
-- @Author: baidwwy
-- @Date:   2024-12-14 19:53:29
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-01-04 13:34:31
-- @Author: baidwwy
-- @Date:   2024-08-21 11:47:40
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-02 05:41:59
local 辅助内挂类 = class()
local 游泳坐标={
        {z=1092,x=208,y=19,f=1}
        ,{z=1514,x=43,y=16,f=1}
        ,{z=1514,x=101,y=103,f=0}
        ,{z=1118,x=53,y=38,f=1}
        ,{z=1119,x=52,y=22,f=1}
        ,{z=1119,x=5,y=21,f=0}
        ,{z=1532,x=58,y=37,f=1}
        ,{z=1532,x=8,y=30,f=0}
        ,{z=1121,x=8,y=7,f=0}
        ,{z=1121,x=34,y=39,f=0}
        ,{z=1120,x=8,y=32,f=0}
        ,{z=1120,x=53,y=29,f=1}
        ,{z=1118,x=26,y=39,f=0}
        ,{z=1116,x=88,y=15,f=0}
        ,{z=1116,x=206,y=61,f=1}
        ,{z=1116,x=78,y=101,f=1}
        ,{z=1506,x=113,y=6,f=0}
        ,{z=1506,x=104,y=63,f=0}
        ,{z=1092,x=132,y=142,f=0}
        ,{z=1092,x=201,y=45,f=1}
    }

function 辅助内挂类:初始化()
    self.对话单位= require("Script/对话处理类/怪物对话内容")()
    self.活动NPC对话 = require("Script/对话处理类/怪物对话处理")()
    -- self.对话内容 = require("Script/对话处理类/NPC对话内容")()
    self.time明雷 = {} --为了岔开时间
    self.time明雷["2"]=true
    self.time明雷["7"]=true
    self.time明雷["12"]=true
    self.time明雷["17"]=true
    self.time明雷["22"]=true
    self.time明雷["27"]=true
    self.time明雷["32"]=true
    self.time明雷["37"]=true
    self.time明雷["42"]=true
    self.time明雷["47"]=true
    self.time明雷["52"]=true
    self.time明雷["57"]=true

    self.time活动 = {}
    self.time活动["1"]=true
    self.time活动["5"]=true
    self.time活动["9"]=true
    self.time活动["13"]=true
    self.time活动["17"]=true
    self.time活动["21"]=true
    self.time活动["25"]=true
    self.time活动["29"]=true
    self.time活动["33"]=true
    self.time活动["37"]=true
    self.time活动["41"]=true
    self.time活动["45"]=true
    self.time活动["49"]=true
    self.time活动["53"]=true
    self.time活动["57"]=true

    -- self.time抓鬼 = {}
    -- self.time抓鬼["3"]=true
    -- self.time抓鬼["6"]=true
    -- self.time抓鬼["9"]=true
    -- self.time抓鬼["12"]=true
    -- self.time抓鬼["15"]=true
    -- self.time抓鬼["18"]=true
    -- self.time抓鬼["21"]=true
    -- self.time抓鬼["24"]=true
    -- self.time抓鬼["27"]=true
    -- self.time抓鬼["30"]=true
    -- self.time抓鬼["33"]=true
    -- self.time抓鬼["36"]=true
    -- self.time抓鬼["39"]=true
    -- self.time抓鬼["42"]=true
    -- self.time抓鬼["45"]=true
    -- self.time抓鬼["48"]=true
    -- self.time抓鬼["51"]=true
    -- self.time抓鬼["54"]=true
    -- self.time抓鬼["57"]=true
    -- self.time抓鬼["00"]=true

    self.time抓鬼 = {}
    self.time抓鬼["1"]=true
    self.time抓鬼["2"]=true
    self.time抓鬼["3"]=true
    self.time抓鬼["4"]=true
    self.time抓鬼["5"]=true
    self.time抓鬼["6"]=true
    self.time抓鬼["7"]=true
    self.time抓鬼["8"]=true
    self.time抓鬼["9"]=true
    self.time抓鬼["10"]=true
    self.time抓鬼["11"]=true
    self.time抓鬼["12"]=true
    self.time抓鬼["13"]=true
    self.time抓鬼["14"]=true
    self.time抓鬼["15"]=true
    self.time抓鬼["16"]=true
    self.time抓鬼["17"]=true
    self.time抓鬼["18"]=true
    self.time抓鬼["19"]=true
    self.time抓鬼["20"]=true
    self.time抓鬼["21"]=true
    self.time抓鬼["22"]=true
    self.time抓鬼["23"]=true
    self.time抓鬼["24"]=true
    self.time抓鬼["25"]=true
    self.time抓鬼["26"]=true
    self.time抓鬼["27"]=true
    self.time抓鬼["28"]=true
    self.time抓鬼["29"]=true
    self.time抓鬼["30"]=true
    self.time抓鬼["31"]=true
    self.time抓鬼["32"]=true
    self.time抓鬼["33"]=true
    self.time抓鬼["34"]=true
    self.time抓鬼["35"]=true
    self.time抓鬼["36"]=true
    self.time抓鬼["37"]=true
    self.time抓鬼["38"]=true
    self.time抓鬼["39"]=true
    self.time抓鬼["40"]=true
    self.time抓鬼["41"]=true
    self.time抓鬼["42"]=true
    self.time抓鬼["43"]=true
    self.time抓鬼["44"]=true
    self.time抓鬼["45"]=true
    self.time抓鬼["46"]=true
    self.time抓鬼["47"]=true
    self.time抓鬼["48"]=true
    self.time抓鬼["49"]=true
    self.time抓鬼["50"]=true
    self.time抓鬼["51"]=true
    self.time抓鬼["52"]=true
    self.time抓鬼["53"]=true
    self.time抓鬼["54"]=true
    self.time抓鬼["55"]=true
    self.time抓鬼["56"]=true
    self.time抓鬼["57"]=true
    self.time抓鬼["58"]=true
    self.time抓鬼["59"]=true


    self.明雷表={}
    self.活动表={}
    self.抓鬼表={}
    self.挂明雷={}
    self.挂活动={}
    self.挂抓鬼={}
    self:初始化明雷表()
    self:初始化活动表()
    self:初始化抓鬼表()
end

function 辅助内挂类:初始化明雷表() --最多24个
    self.明雷表={
        [1]={名称="新手活动怪",类型组={20},模式="__GWdh"},
        [2]={名称="知了先锋",类型组={210},模式="__GWdh"},
        [3]={名称="知了统领",类型组={1177}},
        [4]={名称="知了小王",类型组={1178}},
        [5]={名称="知了大王",类型组={1176}},
        [6]={名称="千年知了王",类型组={1182}},
        [7]={名称="三打白骨精",类型组={1173}},
        [8]={名称="狮驼国",类型组={1174}},
        [9]={名称="真假美猴王",类型组={1175}},
        [10]={名称="龙族",类型组={135},模式="__GWdh"},
        [11]={名称="地煞星",类型组={206}},
        [12]={名称="天罡星",类型组={748,749,750}},
        [13]={名称="裂风兽",类型组={1186}},
    }
end

function 辅助内挂类:初始化活动表() --最多10个
    self.活动表={
        [1]={名称="门派闯关",类型组={0}},
        [2]={名称="游泳比赛",类型组={0}},
    }
end

function 辅助内挂类:初始化抓鬼表()
    self.抓鬼表={
        [1]={名称="自动抓鬼",类型组={0}},
        [2]={名称="自动鬼王",类型组={0}},
    }
end

function 辅助内挂类:数据处理(序号, 内容)
    local 数字id = 内容.数字id + 0

    if 玩家数据[数字id].角色.月卡 == nil then
        玩家数据[数字id].角色.月卡 = {生效=false,到期时间=0}
    end

    if 玩家数据[数字id]==nil then return end
    if 序号 == 550 then
        self:置角色内挂数据(数字id)
        local ngvip = 玩家数据[数字id].角色.月卡.生效 --这要根据你的端改一下
        local data = table.copy(玩家数据[数字id].角色.内挂)
        发送数据(玩家数据[数字id].连接id, 550, {vip=ngvip, mlb=self.明雷表, hdb=self.活动表, zgb=self.抓鬼表,data=data})
    elseif 序号 == 551 then --保存配置
        self:置角色内挂数据(数字id)
        玩家数据[数字id].角色.内挂.明雷 = 内容.明雷
        玩家数据[数字id].角色.内挂.活动 = 内容.活动
        玩家数据[数字id].角色.内挂.抓鬼 = 内容.抓鬼
        常规提示(数字id,"#Y/保存配置成功。")
    elseif 序号 == 552 then --开始、结束、挂机
        self:变更挂机(数字id,内容.界面,内容.变更)
    elseif 序号 == 553 then --关闭界面自动停止挂机
        if self.挂明雷[数字id]~=nil or self.挂活动[数字id]~=nil or self.挂抓鬼[数字id]~=nil then
            常规提示(数字id,"#Y/关闭界面自动#R/停止挂机")
        end
        self:关闭所有挂机(数字id)
    elseif 序号 == 554 then
        发送数据(玩家数据[数字id].连接id, 551, {变更=false})
        常规提示(数字id,"#R/所有挂机项目已被强制停止")
        self:关闭所有挂机(数字id)
    end
end

function 辅助内挂类:变更挂机(数字id,jm,bg) --开始、停止、挂机
    self:关闭其它挂机(数字id,jm)
    local abc = {"挂明雷","挂活动","挂抓鬼"}
    local wjb = {"明雷","活动","抓鬼"}
    for n=1,3 do
        if n==jm then
            if bg then
                if 玩家数据[数字id].角色.月卡.生效 then --这要根据你的端改一下
                    if 玩家数据[数字id].队长 then
                        local go = false
                        local 队伍id = 玩家数据[数字id].队伍
                        for n=1,#队伍数据[队伍id].成员数据 do
                            if 玩家数据[队伍数据[队伍id].成员数据[n]].道具:取禁止飞行(队伍数据[队伍id].成员数据[n]) then
                                发送数据(玩家数据[数字id].连接id, 551, {变更=false})
                                常规提示(数字id,format("#Y/%s#R/有队员有飞行禁制,当前不能传送,禁止挂机",玩家数据[队伍数据[队伍id].成员数据[n]].角色.名称))
                                return
                            end
                        end
                        for an=1,#玩家数据[数字id].角色.内挂[wjb[n]] do
                            if 玩家数据[数字id].角色.内挂[wjb[n]][an] then
                                go = true
                            end
                        end
                        if wjb[n] == "活动" then
                            local 提示 = ""
                            for wjbk,wjbv in pairs(self.活动表) do
                                if 玩家数据[数字id].角色.内挂.活动[wjbk] then
                                    提示 = self:活动可进行(数字id,wjbv.名称)
                                    if 提示~=true then
                                        self.挂活动[数字id] = nil
                                        发送数据(玩家数据[数字id].连接id, 551, {变更=false})
                                        发送数据(玩家数据[数字id].连接id,1501,{名称=玩家数据[数字id].角色.名称,模型=玩家数据[数字id].角色.模型,对话=提示})
                                        return
                                    end
                                end
                            end
                        elseif wjb[n] == "抓鬼" then
                            local 提示 = ""
                            for wjbk,wjbv in pairs(self.抓鬼表) do
                                if 玩家数据[数字id].角色.内挂.抓鬼[wjbk] then
                                    提示 = self:抓鬼可进行(数字id,wjbv.名称)
                                    if 提示~=true then
                                        self.挂抓鬼[数字id] = nil
                                        发送数据(玩家数据[数字id].连接id, 551, {变更=false})
                                        发送数据(玩家数据[数字id].连接id,1501,{名称=玩家数据[数字id].角色.名称,模型=玩家数据[数字id].角色.模型,对话=提示})
                                        return
                                    end
                                end
                            end
                        end
                        if go then
                            self[abc[n]][数字id] = {} --为了记录，打某类型死亡次数达到多少次就剔除该怪物类型
                            常规提示(数字id,"#G/已开始挂机。")
                        else
                            发送数据(玩家数据[数字id].连接id, 551, {变更=false})
                            常规提示(数字id,"#Y/至少有一个选项才可挂机。")
                        end
                    else
                        发送数据(玩家数据[数字id].连接id, 551, {变更=false})
                        常规提示(数字id,"#Y/只有队长才可挂机。")
                    end
                else
                    self:关闭所有挂机(数字id)
                    发送数据(玩家数据[数字id].连接id, 551, {变更=false})
                    常规提示(数字id,"#Y/你不是会员禁止挂机。")
                end
            else
                if self.挂明雷[数字id]~=nil or self.挂活动[数字id]~=nil or self.挂抓鬼[数字id]~=nil then
                    常规提示(数字id,"#Y/你已#R/停止挂机")
                end
                self:关闭所有挂机(数字id)
            end
            break
        end
    end
end

-------------------------------------------------------挂机执行 始
function 辅助内挂类:挂机定时器()
    if self.time明雷[服务端参数.秒] then
        for k,v in pairs(self.挂明雷) do
            if 玩家数据[k]==nil or 玩家数据[k].角色==nil or not 玩家数据[k].队长 or not 玩家数据[k].角色.月卡.生效 then --这要根据你端会员
                self.挂明雷[k] = nil
                if 玩家数据[k]~=nil and 玩家数据[k].角色~=nil then
                    发送数据(玩家数据[k].连接id, 551, {变更=false})
                    常规提示(k,"#R/场景挂机已被强制停止")
                end
            else
                self:明雷寻怪(k)
            end
        end
    elseif self.time活动[服务端参数.秒] then
        for k,v in pairs(self.挂活动) do
            if 玩家数据[k]==nil or 玩家数据[k].角色==nil or not 玩家数据[k].队长 or not 玩家数据[k].角色.月卡.生效 then --这要根据你端会员
                self.挂活动[k] = nil
                if 玩家数据[k]~=nil and 玩家数据[k].角色~=nil then
                    发送数据(玩家数据[k].连接id, 551, {变更=false})
                    常规提示(k,"#R/活动挂机已被强制停止")
                end
            else
                self:活动流程(k)
            end
        end
    elseif self.time抓鬼[服务端参数.秒] then
        for k,v in pairs(self.挂抓鬼) do
            if 玩家数据[k]==nil or 玩家数据[k].角色==nil or not 玩家数据[k].队长 or not 玩家数据[k].角色.月卡.生效 then --这要根据你端会员
                self.挂抓鬼[k] = nil
                if 玩家数据[k]~=nil and 玩家数据[k].角色~=nil then
                    发送数据(玩家数据[k].连接id, 551, {变更=false})
                    常规提示(k,"#R/抓鬼挂机已被强制停止")
                end
            else
                self:抓鬼流程(k)
            end
        end
    end
end
-------------------------------------------------------明雷处理
function 辅助内挂类:明雷寻怪(数字id) --单人处理
    if 玩家数据[数字id].zhandou ~= 0 or not 玩家数据[数字id].队长 then return end
    local data = 玩家数据[数字id].角色.内挂.明雷
    local wj地图 = 玩家数据[数字id].角色.地图数据.编号
    local wj地图x = 玩家数据[数字id].角色.地图数据.x
    local wj地图y = 玩家数据[数字id].角色.地图数据.y
    local 比较xy = {x=wj地图x/20,y=wj地图y/20}

    if self:有人不可飞行(数字id) then
        return
    end
    for k,v in pairs(self.明雷表) do
        if data[k] then
            for kn,vn in pairs(任务数据) do
                if not vn.zhandou then
                    for cn=1,#v.类型组 do
                        if vn.类型 == v.类型组[cn] then
                            if wj地图~= vn.地图编号 then
                                地图处理类:跳转地图(数字id,vn.地图编号,vn.x,vn.y)
                                return
                            else
                                if v.模式=="__GWdh" then
                                    local 对话内容 = __GWdh111[vn.类型](玩家数据[数字id].连接id,数字id,vn.序列,vn.id,vn.地图编号)
                                    if 对话内容~=nil and 对话内容.选项~=nil and 对话内容.选项[1]~=nil then
                                        玩家数据[数字id].地图单位={地图=vn.地图编号,标识=vn.id,编号=vn.编号}
                                        __GWdh222[vn.类型](玩家数据[数字id].连接id,数字id,nil,对话内容.选项)
                                        return
                                    end
                                else
                                    local 对话内容 = self.对话单位:活动对话NR(数字id,vn.单位编号,vn.id,vn.地图编号,vn.类型)
                                    if 对话内容~=nil and 对话内容.选项~=nil and 对话内容.选项[1]~=nil then
                                        玩家数据[数字id].地图单位={地图=vn.地图编号,标识=vn.id,编号=vn.单位编号}
                                        self.活动NPC对话:活动对话CL(数字id,对话内容.名称,对话内容.选项[1],vn.类型,kn)
                                        return
                                    end
                                end
                            end
                            return
                        end
                    end
                end
            end
        end
    end
end

function 辅助内挂类:战斗失败记录(数字id,rwid) --只记录明雷
    if 任务数据[rwid]==nil or 玩家数据[数字id]==nil or 玩家数据[数字id].角色.内挂==nil then return end
    if self.挂明雷[数字id]~=nil then
        for k,v in pairs(self.明雷表) do
            for an=1,#v.类型组 do
                if v.类型组[an]==任务数据[rwid].类型 then
                    local xbh = 任务数据[rwid].类型
                    if self.挂明雷[数字id][xbh]==nil then
                        self.挂明雷[数字id][xbh] = 0
                    end
                    self.挂明雷[数字id][xbh] = self.挂明雷[数字id][xbh] + 1
                    if self.挂明雷[数字id][xbh] >= 10 then
                        玩家数据[数字id].角色.内挂.明雷[k] = false
                        local data = table.copy(玩家数据[数字id].角色.内挂)
                        发送数据(玩家数据[数字id].连接id, 552, data)
                        常规提示(数字id,"#Y/与#R/" ..v.名称 .."#Y/的战斗死亡过多，自动剔除。")
                    end
                    return
                end
            end
        end
    end
end
-------------------------------------------------------活动处理
function 辅助内挂类:活动流程(数字id) --单人处理
    if 玩家数据[数字id].zhandou ~= 0 or not 玩家数据[数字id].队长 then return end
    local data = 玩家数据[数字id].角色.内挂.活动
    local 提示 = ""
    for k,v in pairs(self.活动表) do
        if data[k] then
            提示 = self:活动可进行(数字id,v.名称)
            if 提示 == true then
                if v.名称=="门派闯关" and 玩家数据[数字id].角色:取任务(107)~=0 then
                    self:门派闯关进程(数字id)
                elseif v.名称=="游泳比赛" and 玩家数据[数字id].角色:取任务(109)~=0 then
                    self:游泳活动进程(数字id)
                else
                    self:接活动任务(数字id,v.名称)
                end
            else
                self.挂活动[数字id] = nil
                发送数据(玩家数据[数字id].连接id, 551, {变更=false})
                发送数据(玩家数据[数字id].连接id,1501,{名称=玩家数据[数字id].角色.名称,模型=玩家数据[数字id].角色.模型,对话=提示})
            end
            break
        end
    end
end

function 辅助内挂类:接活动任务(数字id,hdmc)
    local 队伍id = 玩家数据[数字id].队伍
    for n=1,#队伍数据[队伍id].成员数据 do
        if 玩家数据[队伍数据[队伍id].成员数据[n]].道具:取禁止飞行(队伍数据[队伍id].成员数据[n]) then
            for k,v in pairs(self.活动表) do
                玩家数据[数字id].角色.内挂.活动[k]=nil
                self.活动表[数字id] = nil
            end
            发送数据(玩家数据[数字id].连接id, 551, {变更=false})
            常规提示(数字id,format("#Y/%s#R/当前不能传送,禁止挂机",玩家数据[队伍数据[队伍id].成员数据[n]].角色.名称))
            return
        end
    end

    local wj地图 = 玩家数据[数字id].角色.地图数据.编号
    -- local wj地图x = 玩家数据[数字id].角色.地图数据.x
    -- local wj地图y = 玩家数据[数字id].角色.地图数据.y
    -- local 比较xy = {x=wj地图x/20,y=wj地图y/20}
    if hdmc=="门派闯关" then
        if wj地图 ~= 1001 then
            地图处理类:跳转地图(数字id,1001,132,91)
        else
            门派闯关:添加闯关任务(数字id)
        end
    elseif hdmc=="游泳比赛" then
        if wj地图 ~= 1092 then
            地图处理类:跳转地图(数字id,1092,141,60)
        else
            游泳活动:添加任务(数字id)
        end
    end
end

function 辅助内挂类:活动可进行(数字id,hdmc)
    if hdmc=="门派闯关" then
        local 活动开关 = 门派闯关:取活动开关()
        if 活动开关 and 玩家数据[数字id].角色:取任务(107)~=0 then
            local 队长任务=玩家数据[数字id].角色:取任务(107)
            if 队长任务~=0 then
                local 当前=任务数据[队长任务].当前序列
                local 队伍id=玩家数据[数字id].队伍
                for n=1,#队伍数据[队伍id].成员数据 do
                    local cyid=队伍数据[队伍id].成员数据[n]
                    local 队员任务=玩家数据[cyid].角色:取任务(107)
                    if 队员任务~=0 then
                        if 当前~= 任务数据[队员任务].当前序列 then
                            return "队友。"..玩家数据[cyid].角色.名称.."任务NPC与队长不一致"
                        end
                    else
                        return "队友。"..玩家数据[cyid].角色.名称.."没有领取任务"
                    end
                end
            end
            return true
        elseif 活动开关 then --无任务
            if 玩家数据[数字id].队伍==0 then
                return "少侠别拿我开玩笑了……你连队伍都没有？"
            elseif 玩家数据[数字id].队伍==0 or 取队伍人数(数字id)<3 or 取队伍最低等级(玩家数据[数字id].队伍,40) then
                return "门派闯关参与条件：≥40级，≥3人"
            elseif 玩家数据[数字id].队长==false then
                return "这种重要的事情还是让队长来吧！"
            else
                local 队伍id=玩家数据[数字id].队伍
                for n=1,#队伍数据[队伍id].成员数据 do
                    local cyid=队伍数据[队伍id].成员数据[n]
                    if 门派闯关.数据[cyid] then
                        if  门派闯关.数据[cyid].取消~=nil and 门派闯关.数据[cyid].取消 > os.time() then
                            return 玩家数据[cyid].角色.名称.."在五分钟内取消过任务，需等待五分钟后才可以继续任务哦。"
                        elseif 门派闯关.活动时间.日期=="全天" and  门派闯关.数据[cyid].每日次数>=2 then
                            return 玩家数据[cyid].角色.名称.."今日已经完成了两轮，无法再继续领取今日门派闯关任务了！"
                        end
                    end
                    if 玩家数据[cyid].角色:取任务(107)~=0 then
                        return 玩家数据[cyid].角色.名称.."已经领取过任务了"
                    end
                end
            end
            return true
        else
            return "门派闯关未开启"
        end
    elseif hdmc=="游泳比赛" then
        local 活动开关 = 游泳活动:取活动开关()
        if 活动开关 and 玩家数据[数字id].角色:取任务(109)~=0 then
            return true
        elseif 活动开关 then --无任务
            if 玩家数据[数字id].队伍==0 then
                return "此活动最少需要三人组队参加。"
            elseif 取队伍人数(数字id) < 3 then
                return "此活动最少需要三人组队参加。"
            elseif 取等级要求(数字id,30)==false then
                return "游泳比赛活动要求最低等级不能小于30级，队伍中有成员等级未达到此要求。"
            else
                local 队伍id=玩家数据[数字id].队伍
                for n=1,#队伍数据[队伍id].成员数据 do
                    local 队员id = 队伍数据[队伍id].成员数据[n]
                    if 玩家数据[队员id].角色:取任务(109)~=0 then
                        return "#Y/" ..玩家数据[队员id].角色.名称 .."已经领取过任务了"
                    elseif 游泳活动.数据[队员id]~=nil and 游泳活动.数据[队员id]>=3 then
                        return "#Y/"..玩家数据[队员id].角色.名称.."本日已完成了3轮无法参加游泳比赛了"
                    end
                end
                return true
            end
        else
            return "游泳比赛未开启"
        end
    end
    return "活动未开启"
end

function 辅助内挂类:游泳活动进程(数字id)
    if 玩家数据[数字id].zhandou ~= 0 or not 玩家数据[数字id].队长 then return end
    local 任务id = 玩家数据[数字id].角色:取任务(109)
    local wj地图 = 玩家数据[数字id].角色.地图数据.编号
    local wj地图x = 玩家数据[数字id].角色.地图数据.x
    local wj地图y = 玩家数据[数字id].角色.地图数据.y
    local 比较xy = {x=wj地图x/20,y=wj地图y/20}
    local jr地图 = 游泳坐标[任务数据[任务id].序列]
    if 任务数据[任务id]~=nil then
        if wj地图 ~= 游泳坐标[任务数据[任务id].序列].z or 取两点距离(比较xy,jr地图) > 20 then
            地图处理类:跳转地图(数字id,jr地图.z,jr地图.x,jr地图.y)
        else
            local jrmc = 任务数据[任务id].序列 .."号裁判"
            for k,v in pairs(地图处理类.地图单位[wj地图]) do
                if 任务数据[v.id]~=nil and 任务数据[v.id].名称 == jrmc and 任务数据[v.id].序列 == 任务数据[任务id].序列 then
                    local 对话内容 = self.对话单位:活动对话NR(数字id,任务数据[v.id].单位编号,任务数据[v.id].id,任务数据[v.id].地图编号,任务数据[v.id].类型)
                    if 对话内容~=nil and 对话内容.选项~=nil and 对话内容.选项[1]~=nil then
                        玩家数据[数字id].地图单位={地图=任务数据[v.id].地图编号,标识=任务数据[v.id].id,编号=任务数据[v.id].序列}
                        self.活动NPC对话:活动对话CL(数字id,对话内容.名称,对话内容.选项[1],任务数据[v.id].类型,任务数据[v.id].id)
                    end
                    break
                end
            end
        end
    end
end

function 辅助内挂类:门派闯关进程(数字id)
    if 玩家数据[数字id].zhandou ~= 0 or not 玩家数据[数字id].队长 then return end
    local 任务id = 玩家数据[数字id].角色:取任务(107)
    local wj地图 = 玩家数据[数字id].角色.地图数据.编号
    local wj地图x = 玩家数据[数字id].角色.地图数据.x
    local wj地图y = 玩家数据[数字id].角色.地图数据.y
    local 比较xy = {x=wj地图x/20,y=wj地图y/20}
    local 提示 = self:活动可进行(数字id,"门派闯关")
    if 提示~=true then
        self.挂活动[数字id] = nil
        发送数据(玩家数据[数字id].连接id, 551, {变更=false})
        发送数据(玩家数据[数字id].连接id,1501,{名称=玩家数据[数字id].角色.名称,模型=玩家数据[数字id].角色.模型,对话=提示})
        return
    end
    if 任务数据[任务id]~=nil then
        local n = 任务数据[任务id].当前序列
        local data = Q_闯关数据[Q_门派编号[n]]
        local qmpdt = 取门派地图(Q_门派编号[n])
        local jr地图 = {z=qmpdt[1],x=data.x,y=data.y}
        if data then
            if wj地图 ~= jr地图.z or 取两点距离(比较xy,jr地图) > 20 then
                地图处理类:跳转地图(数字id,jr地图.z,jr地图.x,jr地图.y)
            else
                for k,v in pairs(地图处理类.地图单位[wj地图]) do
                    local npcmc = Q_门派编号[n] .."护法"
                    if v.名称 == npcmc then
                        local 对话内容 = self.对话单位:活动对话NR(数字id,任务数据[v.id].单位编号,任务数据[v.id].id,任务数据[v.id].地图编号,任务数据[v.id].类型)
                        if 对话内容~=nil and 对话内容.选项~=nil and 对话内容.选项[1]~=nil then
                            玩家数据[数字id].地图单位={地图=任务数据[v.id].地图编号,标识=任务数据[v.id].id,编号=任务数据[v.id].序列}
                            __GWdh222[106](玩家数据[数字id].连接id,数字id,nil,对话内容.选项)
                        end
                        break
                    end
                end
            end
        end
    end
end
-------------------------------------------------------抓鬼处理
function 辅助内挂类:抓鬼流程(数字id) --单人处理
    if 玩家数据[数字id].zhandou ~= 0 or not 玩家数据[数字id].队长 then return end
    if self:有人不可飞行(数字id) then
        return
    end
    local data = 玩家数据[数字id].角色.内挂.抓鬼
    for k,v in pairs(self.抓鬼表) do
        if data[k] then
            if v.名称=="自动抓鬼" then
                self:普通抓鬼流程(数字id)
            elseif v.名称=="自动鬼王" then
                self:自动鬼王流程(数字id)
            end
            break
        end
    end
end

function 辅助内挂类:普通抓鬼流程(数字id)
    local wj地图 = 玩家数据[数字id].角色.地图数据.编号
    local wj地图x = 玩家数据[数字id].角色.地图数据.x
    local wj地图y = 玩家数据[数字id].角色.地图数据.y
    local 比较xy = {x=wj地图x/20,y=wj地图y/20}
    local 任务id = 玩家数据[数字id].角色:取任务(8)
    local 钟馗xy=取假人表(1122,1)
    local jr地图= {z=1122,x=钟馗xy.X,y=钟馗xy.Y}
    if 任务id==0 then
        if wj地图 ~= 1122 or 取两点距离(比较xy,jr地图) > 20 then
            地图处理类:跳转地图(数字id,jr地图.z,jr地图.x,jr地图.y)
        else
            设置任务8(数字id)
        end
    else
        local jg地图 = {z=任务数据[任务id].地图编号,x=任务数据[任务id].x,y=任务数据[任务id].y}
        if wj地图 ~= jg地图.z or 取两点距离(比较xy,jg地图) > 20 then
            地图处理类:跳转地图(数字id,jg地图.z,jg地图.x,jg地图.y)
        else
            for k,v in pairs(地图处理类.地图单位[jg地图.z]) do
                if v.id == 任务id then
                    local 对话内容 = __GWdh111[任务数据[v.id].类型](玩家数据[数字id].连接id,数字id,任务数据[v.id].序列,任务数据[v.id].id,jg地图.z)
                    if 对话内容~=nil and 对话内容.选项~=nil and 对话内容.选项[1]~=nil then
                        玩家数据[数字id].地图单位={地图=任务数据[v.id].地图编号,标识=任务数据[v.id].id,编号=任务数据[v.id].编号}
                        __GWdh222[任务数据[v.id].类型](玩家数据[数字id].连接id,数字id,nil,对话内容.选项)
                    end
                    break
                end
            end
        end
    end
end

function 辅助内挂类:自动鬼王流程(数字id)
    local wj地图 = 玩家数据[数字id].角色.地图数据.编号
    local wj地图x = 玩家数据[数字id].角色.地图数据.x
    local wj地图y = 玩家数据[数字id].角色.地图数据.y
    local 比较xy = {x=wj地图x/20,y=wj地图y/20}
    local 任务id=玩家数据[数字id].角色:取任务(14)
    if 任务id==0 then
        if wj地图 ~= 1125 then
            地图处理类:跳转地图(数字id,1125,35,27)
        else
            设置任务14(数字id)
        end
    else
        local jg地图 = {z=任务数据[任务id].地图编号,x=任务数据[任务id].x,y=任务数据[任务id].y}
        if wj地图 ~= jg地图.z or 取两点距离(比较xy,jg地图) > 20 then
            地图处理类:跳转地图(数字id,jg地图.z,jg地图.x,jg地图.y)
        else
            for k,v in pairs(地图处理类.地图单位[jg地图.z]) do
                if v.id == 任务id then
                    local 对话内容 = __GWdh111[任务数据[v.id].类型](玩家数据[数字id].连接id,数字id,任务数据[v.id].序列,任务数据[v.id].id,jg地图.z)
                    if 对话内容~=nil and 对话内容.选项~=nil and 对话内容.选项[1]~=nil then
                        玩家数据[数字id].地图单位={地图=任务数据[v.id].地图编号,标识=任务数据[v.id].id,编号=任务数据[v.id].编号}
                        __GWdh222[任务数据[v.id].类型](玩家数据[数字id].连接id,数字id,nil,对话内容.选项)
                    end
                    break
                end
            end
        end
    end
end

function 辅助内挂类:抓鬼可进行(数字id,mc)
    if mc == "自动抓鬼" then
        if 玩家数据[数字id].队伍==0 or 玩家数据[数字id].队长==false  then
            return "#Y/该任务必须组队完成且由队长领取"
        elseif 取队伍最低等级(玩家数据[数字id].队伍,20) then
            return "#Y/等级小于20级的玩家无法领取此任务"
        elseif 取队伍任务(玩家数据[数字id].队伍,8) then
            return "#Y/队伍中已有队员领取过此任务了"
        end
    elseif mc == "自动鬼王" then
        if 玩家数据[数字id].队伍==0 or 玩家数据[数字id].队长==false  then
            return "#Y/该任务必须组队完成且由队长领取"
        elseif 取队伍最低等级(玩家数据[数字id].队伍,100) then --100
            return "#Y/等级小于100级的玩家无法领取此任务"
        elseif 取队伍任务(玩家数据[数字id].队伍,14) then
            return "#Y/队伍中已有队员领取过此任务了"
        end
    end
    return true
end
------------------------------------------------------挂机执行 终
function 辅助内挂类:有人不可飞行(数字id)
    if not 玩家数据[数字id].队长 then
        常规提示(数字id,"你不是队长")
        return true
    end
    local 队伍id = 玩家数据[数字id].队伍
    for n=1,#队伍数据[队伍id].成员数据 do
        if 玩家数据[队伍数据[队伍id].成员数据[n]].道具:取禁止飞行(队伍数据[队伍id].成员数据[n]) then
            常规提示(数字id,format("#Y/%s#R/当前不能传送,禁止挂机",玩家数据[队伍数据[队伍id].成员数据[n]].角色.名称))
            return true
        end
    end
    return false
end

function 辅助内挂类:是否明雷挂机中(数字id)
    if self.挂明雷[数字id]~=nil then
        return true
    end
    return false
end

function 辅助内挂类:是否挂机中(数字id) --取所有挂机模式
    if self.挂明雷[数字id]~=nil or self.挂活动[数字id]~=nil or self.挂抓鬼[数字id]~=nil then
        return true
    end
    return false
end

function 辅助内挂类:关闭其它挂机(数字id,jm)
    local abc = {"挂明雷","挂活动","挂抓鬼"}
    for n=1,3 do
        if n~=jm and self[abc[n]][数字id]~=nil then
            self[abc[n]][数字id] = nil
        end
    end
end

function 辅助内挂类:关闭所有挂机(数字id)
    if self.挂明雷[数字id]~=nil then
        self.挂明雷[数字id] = nil
    end
    if self.挂活动[数字id]~=nil then
        self.挂活动[数字id] = nil
    end
    if self.挂抓鬼[数字id]~=nil then
        self.挂抓鬼[数字id] = nil
    end
end

function 辅助内挂类:置角色内挂数据(数字id)
    if 玩家数据[数字id].角色.内挂==nil then
        玩家数据[数字id].角色.内挂={}
    end
    if 玩家数据[数字id].角色.内挂.明雷==nil then
        玩家数据[数字id].角色.内挂.明雷={}
    end
    if 玩家数据[数字id].角色.内挂.活动==nil then
        玩家数据[数字id].角色.内挂.活动={}
    end
    if 玩家数据[数字id].角色.内挂.抓鬼==nil then
        玩家数据[数字id].角色.内挂.抓鬼={}
    end
    for n=1,50 do --目的是为了让玩家内挂数据根据(明雷表、活动表等)的变更而变更
        if self.明雷表[n]~=nil then
            if 玩家数据[数字id].角色.内挂.明雷[n]==nil then
                玩家数据[数字id].角色.内挂.明雷[n] = false
            end
        else
            玩家数据[数字id].角色.内挂.明雷[n] = nil
        end
        if self.活动表[n]~=nil then
            if 玩家数据[数字id].角色.内挂.活动[n]==nil then
                玩家数据[数字id].角色.内挂.活动[n] = false
            end
        else
            玩家数据[数字id].角色.内挂.活动[n] = nil
        end
        if self.抓鬼表[n]~=nil then
            if 玩家数据[数字id].角色.内挂.抓鬼[n]==nil then
                玩家数据[数字id].角色.内挂.抓鬼[n] = false
            end
        else
            玩家数据[数字id].角色.内挂.抓鬼[n] = nil
        end
    end
end

return 辅助内挂类