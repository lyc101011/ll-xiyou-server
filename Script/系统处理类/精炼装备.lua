-- @Author: 源梦屋资源网:www.52luntan.cn
-- @Date:   2023-07-24 20:51:51
-- @Last Modified by:    ★〓光唏蜀黍〓★ QQ:29582348      ★〓光唏蜀黍〓★ Q群:902038863
-- @Last Modified time: 2024-12-12 09:58:14
-- @Author: 源梦屋资源网:www.52luntan.cn
-- @Date:   2021-11-24 23:25:13
-- @Last Modified by:   源梦屋资源网:www.52luntan.cn
-- @Last Modified time: 2023-07-24 20:59:45
function ItemControl:精炼数据获取(id)
    self.发送信息={}
    self.发送信息.所需数量={}
    self.发送信息.需要祝福={}
    self.发送信息.祝福值={}
    self.发送信息.低级祝福={}
    self.发送信息.中级祝福={}
    self.发送信息.高级祝福={}
    self.发送信息.低级成功率={}
    self.发送信息.中级成功率={}
    self.发送信息.高级成功率={}
    self.发送信息.精炼等级={}
    self.发送信息.精炼数值={}
       for n=21,26 do
         if UserData[id].角色.装备数据[n]~=nil and UserData[id].物品[UserData[id].角色.装备数据[n]]~=nil then
             self.发送信息[n]=UserData[id].物品[UserData[id].角色.装备数据[n]]
             if UserData[id].角色.精炼等级 == nil then
                UserData[id].角色.精炼等级 = {[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0}
             end
             if UserData[id].角色.祝福值 == nil then
                UserData[id].角色.祝福值 = 0
             end
             self.发送信息.所需数量[n] = self:取精炼所需数量(UserData[id].角色.精炼等级[n])
             self.发送信息.需要祝福[n] = self:取所需祝福值(UserData[id].角色.精炼等级[n])
             self.发送信息.祝福值 = UserData[id].角色.祝福值
             self.发送信息.低级祝福[n] = self:取低级祝福(UserData[id].角色.精炼等级[n])
             self.发送信息.中级祝福[n] = self:取中级祝福(UserData[id].角色.精炼等级[n])
             self.发送信息.高级祝福[n] = self:取高级祝福(UserData[id].角色.精炼等级[n])
             self.发送信息.低级成功率[n] = self:取低级成功率(UserData[id].角色.精炼等级[n])
             self.发送信息.中级成功率[n] = self:取中级成功率(UserData[id].角色.精炼等级[n])
             self.发送信息.高级成功率[n] = self:取高级成功率(UserData[id].角色.精炼等级[n])
             self.发送信息.精炼等级[n] = UserData[id].角色.精炼等级[n]
         end
       end
       self.发送信息.低级精炼 = 材料仓库[id].精炼之锤低
       self.发送信息.中级精炼 = 材料仓库[id].精炼之锤中
       self.发送信息.高级精炼 = 材料仓库[id].精炼之锤高
       RoleControl:刷新装备属性(UserData[id])
       SendMessage(UserData[id].连接id,3006,"66")
       SendMessage(UserData[id].连接id,30093,self.发送信息)
end

function ItemControl:获取套装数据(id)
    self.发送信息={}
    if UserData[id].角色.精炼等级 == nil then
       UserData[id].角色.精炼等级 = {[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0}
    end
    self.发送信息.套装等级 = 0
    self.发送信息.气血上限 = 0
    self.发送信息.魔法上限 = 0
    self.发送信息.物理攻击 = 0
    self.发送信息.法术伤害 = 0
    self.发送信息.速度 = 0
    if UserData[id].角色.精炼等级[21] >= 40 and UserData[id].角色.精炼等级[22] >= 40 and UserData[id].角色.精炼等级[23] >= 40 and UserData[id].角色.精炼等级[24] >= 40
         and UserData[id].角色.精炼等级[25] >= 40 and UserData[id].角色.精炼等级[26] >= 40 then
            self.发送信息.套装等级 = 8
            self.发送信息.气血上限 = 10
            self.发送信息.魔法上限 = 10
            self.发送信息.物理攻击 = 10
            self.发送信息.法术伤害 = 10
            self.发送信息.速度 = 10
    elseif UserData[id].角色.精炼等级[21] >= 36 and UserData[id].角色.精炼等级[22] >= 36 and UserData[id].角色.精炼等级[23] >= 36 and UserData[id].角色.精炼等级[24] >= 36
         and UserData[id].角色.精炼等级[25] >= 36 and UserData[id].角色.精炼等级[26] >= 36 then
            self.发送信息.套装等级 = 4
            self.发送信息.气血上限 = 9
            self.发送信息.魔法上限 = 9
            self.发送信息.物理攻击 = 9
            self.发送信息.法术伤害 = 9
            self.发送信息.速度 = 9
    elseif UserData[id].角色.精炼等级[21] >= 32 and UserData[id].角色.精炼等级[22] >= 32 and UserData[id].角色.精炼等级[23] >= 32 and UserData[id].角色.精炼等级[24] >= 32
         and UserData[id].角色.精炼等级[25] >= 32 and UserData[id].角色.精炼等级[26] >= 32 then
            self.发送信息.套装等级 = 8
            self.发送信息.气血上限 = 8
            self.发送信息.魔法上限 = 8
            self.发送信息.物理攻击 = 8
            self.发送信息.法术伤害 = 8
            self.发送信息.速度 = 8
    elseif UserData[id].角色.精炼等级[21] >= 28 and UserData[id].角色.精炼等级[22] >= 28 and UserData[id].角色.精炼等级[23] >= 28 and UserData[id].角色.精炼等级[24] >= 28
         and UserData[id].角色.精炼等级[25] >= 28 and UserData[id].角色.精炼等级[26] >= 28 then
            self.发送信息.套装等级 = 4
            self.发送信息.气血上限 = 7
            self.发送信息.魔法上限 = 7
            self.发送信息.物理攻击 = 7
            self.发送信息.法术伤害 = 7
            self.发送信息.速度 = 7
    elseif UserData[id].角色.精炼等级[21] >= 24 and UserData[id].角色.精炼等级[22] >=24 and UserData[id].角色.精炼等级[23] >=24 and UserData[id].角色.精炼等级[24] >= 24
         and UserData[id].角色.精炼等级[25] >= 24 and UserData[id].角色.精炼等级[26]>= 24 then
            self.发送信息.套装等级 = 8
            self.发送信息.气血上限 = 6
            self.发送信息.魔法上限 = 6
            self.发送信息.物理攻击 = 6
            self.发送信息.法术伤害 = 6
            self.发送信息.速度 = 6
    elseif UserData[id].角色.精炼等级[21]>= 20 and UserData[id].角色.精炼等级[22]>= 20 and UserData[id].角色.精炼等级[23]>= 20 and UserData[id].角色.精炼等级[24] >= 20
         and UserData[id].角色.精炼等级[25]>= 20 and UserData[id].角色.精炼等级[26] >=20 then
            self.发送信息.套装等级 = 4
            self.发送信息.气血上限 = 5
            self.发送信息.魔法上限 = 5
            self.发送信息.物理攻击 = 5
            self.发送信息.法术伤害 = 5
            self.发送信息.速度 = 5
    elseif UserData[id].角色.精炼等级[21] >= 16 and UserData[id].角色.精炼等级[22] >= 16 and UserData[id].角色.精炼等级[23] >= 16 and UserData[id].角色.精炼等级[24]>= 16
         and UserData[id].角色.精炼等级[25]>= 16 and UserData[id].角色.精炼等级[26]>= 16 then
            self.发送信息.套装等级 = 8
            self.发送信息.气血上限 = 4
            self.发送信息.魔法上限 = 4
            self.发送信息.物理攻击 = 4
            self.发送信息.法术伤害 = 4
            self.发送信息.速度 = 4
    elseif UserData[id].角色.精炼等级[21] >= 12 and UserData[id].角色.精炼等级[22] >= 12 and UserData[id].角色.精炼等级[23] >= 12 and UserData[id].角色.精炼等级[24] >= 12
         and UserData[id].角色.精炼等级[25]>= 12 and UserData[id].角色.精炼等级[26] >= 12 then
            self.发送信息.套装等级 = 4
            self.发送信息.气血上限 = 3
            self.发送信息.魔法上限 = 3
            self.发送信息.物理攻击 = 3
            self.发送信息.法术伤害 = 3
            self.发送信息.速度 = 3
    elseif UserData[id].角色.精炼等级[21] >= 8 and UserData[id].角色.精炼等级[22] >= 8 and UserData[id].角色.精炼等级[23]>= 8 and UserData[id].角色.精炼等级[24] >= 8
         and UserData[id].角色.精炼等级[25]>= 8 and UserData[id].角色.精炼等级[26] >= 8 then
            self.发送信息.套装等级 = 8
            self.发送信息.气血上限 = 2
            self.发送信息.魔法上限 = 2
            self.发送信息.物理攻击 = 2
            self.发送信息.法术伤害 = 2
            self.发送信息.速度 = 2
    elseif UserData[id].角色.精炼等级[21] >= 4 and UserData[id].角色.精炼等级[22] >= 4 and UserData[id].角色.精炼等级[23] >= 4 and UserData[id].角色.精炼等级[24] >= 4
         and UserData[id].角色.精炼等级[25]>= 4 and UserData[id].角色.精炼等级[26] >= 4 then
            self.发送信息.套装等级 = 4
            self.发送信息.气血上限 = 1
            self.发送信息.魔法上限 = 1
            self.发送信息.物理攻击 = 1
            self.发送信息.法术伤害 = 1
            self.发送信息.速度 = 1
    end
    SendMessage(UserData[id].连接id,40095,self.发送信息)
end


function ItemControl:刷新数据(id)
    self.发送信息={}
    self.发送信息.所需数量={}
    self.发送信息.需要祝福={}
    self.发送信息.祝福值={}
    self.发送信息.低级祝福={}
    self.发送信息.中级祝福={}
    self.发送信息.高级祝福={}
    self.发送信息.低级成功率={}
    self.发送信息.中级成功率={}
    self.发送信息.高级成功率={}
    self.发送信息.精炼等级={}
       for n=21,26 do
         if UserData[id].角色.装备数据[n]~=nil and UserData[id].物品[UserData[id].角色.装备数据[n]]~=nil then
             self.发送信息[n]=UserData[id].物品[UserData[id].角色.装备数据[n]]
             if UserData[id].角色.精炼等级 == nil then
                UserData[id].角色.精炼等级 = {[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0}
             end
             if UserData[id].角色.祝福值 == nil then
                UserData[id].角色.祝福值 = 0
             end
             self.发送信息.所需数量[n] = self:取精炼所需数量(UserData[id].角色.精炼等级[n])
             self.发送信息.需要祝福[n] = self:取所需祝福值(UserData[id].角色.精炼等级[n])
             self.发送信息.祝福值 = UserData[id].角色.祝福值
             self.发送信息.低级祝福[n] = self:取低级祝福(UserData[id].角色.精炼等级[n])
             self.发送信息.中级祝福[n] = self:取中级祝福(UserData[id].角色.精炼等级[n])
             self.发送信息.高级祝福[n] = self:取高级祝福(UserData[id].角色.精炼等级[n])
             self.发送信息.低级成功率[n] = self:取低级成功率(UserData[id].角色.精炼等级[n])
             self.发送信息.中级成功率[n] = self:取中级成功率(UserData[id].角色.精炼等级[n])
             self.发送信息.高级成功率[n] = self:取高级成功率(UserData[id].角色.精炼等级[n])
             self.发送信息.精炼等级[n] = UserData[id].角色.精炼等级[n]
         end
       end
       self.发送信息.低级精炼 = 材料仓库[id].精炼之锤低
       self.发送信息.中级精炼 = 材料仓库[id].精炼之锤中
       self.发送信息.高级精炼 = 材料仓库[id].精炼之锤高
       RoleControl:刷新装备属性(UserData[id])
       SendMessage(UserData[id].连接id,3006,"66")
       SendMessage(UserData[id].连接id,30094,self.发送信息)
end

function ItemControl:一键精炼锻造(id,参数,内容,概率)
    local 包裹 = "包裹"
    local 所需数量
    local 实际数量=0
    local 消耗银子=f函数.读配置(ServerDirectory..[[配置文件\精炼装备配置.txt]], "精炼装备", "消耗银子")+0
    if UserData[id].角色.装备数据[参数]~=nil and UserData[id].物品[UserData[id].角色.装备数据[参数]]~=nil then
      所需数量 = self:取精炼所需数量(UserData[id].角色.精炼等级[参数])
      for i=1,10 do
        if 银子检查(id,消耗银子)==false then
            SendMessage(UserData[id].连接id,7,"#y/精炼装备每次需要"..消耗银子.."两银子")
            return true
        end
        if 内容 == "1" then
            实际数量 = 材料仓库[id].精炼之锤低
        elseif 内容 == "2" then
            实际数量 = 材料仓库[id].精炼之锤中
        elseif 内容 == "3" then
            实际数量 = 材料仓库[id].精炼之锤高
        end
        if 实际数量<所需数量 then
           SendMessage(UserData[id].连接id,7,"#y/你的精炼之锤数量不够本次精炼。")
           return true
        else
           self:精炼锻造(id,参数,内容,概率)
        end
      end
    end
end

function ItemControl:精炼锻造(id,参数,内容,概率)
    local 消耗银子=f函数.读配置(ServerDirectory..[[配置文件\精炼装备配置.txt]], "精炼装备", "消耗银子")+0
    if 银子检查(id,消耗银子)==false then
        SendMessage(UserData[id].连接id,7,"#y/精炼装备每次需要"..消耗银子.."两银子")
        return true
    end
    local 包裹 = "包裹"
    local 实际数量=0
    local 概率
    local 祝福值
    local 需要祝福
    local 所需数量
    local 数组
    local 数组1
    if UserData[id].角色.装备数据[参数]~=nil and UserData[id].物品[UserData[id].角色.装备数据[参数]]~=nil then
       所需数量 = self:取精炼所需数量(UserData[id].角色.精炼等级[参数])
    else
       SendMessage(UserData[id].连接id,7,"#y/参数错误，请重新打开精炼界面")
       return true
    end
    if UserData[id].角色.精炼等级[参数]>=40 then
       SendMessage(UserData[id].连接id,7,"#y/当前精炼已经为最高等级，无法在进行精炼")
       return true
    end
    if UserData[id].角色.装备数据[参数]~=nil and UserData[id].物品[UserData[id].角色.装备数据[参数]]~=nil then
       if 内容 == "1" then
          概率=self:取低级成功率(UserData[id].角色.精炼等级[参数])
          实际数量 = 材料仓库[id].精炼之锤低
          if 实际数量<所需数量 then
             SendMessage(UserData[id].连接id,7,"#y/你的精炼之锤数量不够本次精炼。")
             return true
          end
          材料仓库[id].精炼之锤低 = 材料仓库[id].精炼之锤低 - 所需数量
       elseif 内容 == "2" then
          概率=self:取中级成功率(UserData[id].角色.精炼等级[参数])
          实际数量 = 材料仓库[id].精炼之锤中
          if 实际数量<所需数量 then
             SendMessage(UserData[id].连接id,7,"#y/你的精炼之锤数量不够本次精炼。")
             return true
          end
          材料仓库[id].精炼之锤中 = 材料仓库[id].精炼之锤中 - 所需数量
       elseif 内容 == "3" then
          概率=self:取高级成功率(UserData[id].角色.精炼等级[参数])
          实际数量 = 材料仓库[id].精炼之锤高
          if 实际数量<所需数量 then
             SendMessage(UserData[id].连接id,7,"#y/你的精炼之锤数量不够本次精炼。")
             return true
          end
          材料仓库[id].精炼之锤高 = 材料仓库[id].精炼之锤高 - 所需数量
       end
       需要祝福 = self:取所需祝福值(UserData[id].角色.精炼等级[参数])
       RoleControl:扣除银子(UserData[id],消耗银子,"精炼锻造")
       if 内容 == "1" then
          祝福值 = self:取低级祝福(UserData[id].角色.精炼等级[参数])
       elseif 内容 == "2" then
          祝福值 = self:取中级祝福(UserData[id].角色.精炼等级[参数])
       elseif 内容 == "3" then
          祝福值 = self:取高级祝福(UserData[id].角色.精炼等级[参数])
       end
       if (参数 == 21 and math.random(100)<=概率) or (UserData[id].角色.祝福值>=需要祝福) then
        if UserData[id].角色.祝福值>=需要祝福 then
            UserData[id].角色.祝福值 = 0
        end
        UserData[id].角色.精炼等级[参数] = UserData[id].角色.精炼等级[参数] + 1
        SendMessage(UserData[id].连接id,7,"#y/恭喜你精炼装备成功")
       elseif 参数 == 22 and math.random(100)<=概率 or (UserData[id].角色.祝福值>=需要祝福) then
        if UserData[id].角色.祝福值>=需要祝福 then
            UserData[id].角色.祝福值 = 0
        end
        UserData[id].角色.精炼等级[参数] = UserData[id].角色.精炼等级[参数] + 1
        SendMessage(UserData[id].连接id,7,"#y/恭喜你精炼装备成功")
       elseif 参数 == 23 and math.random(100)<=概率 or (UserData[id].角色.祝福值>=需要祝福) then
        if UserData[id].角色.祝福值>=需要祝福 then
            UserData[id].角色.祝福值 = 0
        end
        UserData[id].角色.精炼等级[参数] = UserData[id].角色.精炼等级[参数] + 1
        SendMessage(UserData[id].连接id,7,"#y/恭喜你精炼装备成功")
       elseif 参数 == 24 and math.random(100)<=概率 or (UserData[id].角色.祝福值>=需要祝福) then
        if UserData[id].角色.祝福值>=需要祝福 then
            UserData[id].角色.祝福值 = 0
        end
        UserData[id].角色.精炼等级[参数] = UserData[id].角色.精炼等级[参数] + 1
        SendMessage(UserData[id].连接id,7,"#y/恭喜你精炼装备成功")
       elseif 参数 == 25 and math.random(100)<=概率 or (UserData[id].角色.祝福值>=需要祝福) then
        if UserData[id].角色.祝福值>=需要祝福 then
            UserData[id].角色.祝福值 = 0
        end
        UserData[id].角色.精炼等级[参数] = UserData[id].角色.精炼等级[参数] + 1
        SendMessage(UserData[id].连接id,7,"#y/恭喜你精炼装备成功")
       elseif 参数 == 26 and math.random(100)<=概率 or (UserData[id].角色.祝福值>=需要祝福) then
        if UserData[id].角色.祝福值>=需要祝福 then
            UserData[id].角色.祝福值 = 0
        end
        UserData[id].角色.精炼等级[参数] = UserData[id].角色.精炼等级[参数] + 1
        SendMessage(UserData[id].连接id,7,"#y/恭喜你精炼装备成功")
       else
        UserData[id].角色.祝福值 = UserData[id].角色.祝福值 + 祝福值
        SendMessage(UserData[id].连接id,7,"#y/很遗憾，你本次精炼失败。")
       end
   else
        SendMessage(UserData[id].连接id,7,"#y/数据有误，请重新打开精炼界面")
   end
   self:刷新数据(id)

end

function ItemControl:取精炼所需数量(等级)
    local 数量=f函数.读配置(ServerDirectory..[[配置文件\精炼装备配置.txt]], "消耗锤子数量",tostring(等级))+0
    return 数量
end

function ItemControl:取所需祝福值(等级)
    local 祝福值
    for i=1,41 do
      if 等级 == i-1 then
         祝福值 = i*100
      end
    end
    return 祝福值
end

function ItemControl:取低级祝福(等级)
    local 祝福值
    for i=1,41 do
      if 等级 == i-1 then
         祝福值 = i*5
      end
    end
    return 祝福值
end

function ItemControl:取中级祝福(等级)
    local 祝福值
    for i=1,41 do
      if 等级 == i-1 then
         祝福值 = i*10
      end
    end
    return 祝福值
end

function ItemControl:取高级祝福(等级)
    local 祝福值
    for i=1,41 do
      if 等级 == i-1 then
         祝福值 = i*15
      end
    end
    return 祝福值
end


function ItemControl:取低级成功率(等级)
    local 成功率=f函数.读配置(ServerDirectory..[[配置文件\精炼装备配置.txt]], "低级锤子概率",tostring(等级))+0
    return 成功率
end

function ItemControl:取中级成功率(等级)
    local 成功率=f函数.读配置(ServerDirectory..[[配置文件\精炼装备配置.txt]], "中级锤子概率",tostring(等级))+0
    return 成功率
end

function ItemControl:取高级成功率(等级)
    local 成功率=f函数.读配置(ServerDirectory..[[配置文件\精炼装备配置.txt]], "高级锤子概率",tostring(等级))+0
    return 成功率
end