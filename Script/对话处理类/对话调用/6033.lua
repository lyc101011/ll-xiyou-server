-- @Author: baidwwy
-- @Date:   2023-12-03 11:44:24
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-06-01 13:46:41
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:43:47
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
__NPCdh111[6033]=function (ID,编号,页数,已经在任务中,数字id)
  local wb = {}
  local xx = {}
 if 编号 == 1 then
    wb[1] = "这蟠桃园的桃树又该锄树清草了，你是要来帮我的忙么？1"
    local xx = {"我来帮你吧","我还要逛逛"}
    return {"至尊宝","锄树力士",wb[1],xx}
 elseif 编号 == 2 then
    wb[1] = "这蟠桃园的桃树又该浇水了，你是要来帮我的忙么？"
    local xx = {"我来帮你吧","我还要逛逛"}
    return {"赌霸天","浇水力士",wb[1],xx}
 elseif 编号 == 3 then
    wb[1] = "这蟠桃园的桃树修一修果实才能长得旺盛，你是要来帮我的忙么？"
    local xx = {"我来帮你吧","我还要逛逛"}
    return {"吴刚","修桃力士",wb[1],xx}
 elseif 编号 == 4 then
    wb[1] = "我乃是“一千年蟠桃树”，每千年一结果，大圣不想尝一尝么？"
    --local xx = {"我是来帮你浇水的","我还要逛逛"}
    return {"桃树","一千年桃树",wb[1],xx}
 elseif 编号 == 5 then
    wb[1] = "我乃是“两千年蟠桃树”，每两千年一结果，大圣不想尝一尝么？"
    return {"桃树","两千年桃树",wb[1],xx}
 elseif 编号 == 6 then
    wb[1] = "我乃是“三千年蟠桃树”，每三千年一结果，大圣不想尝一尝么？"
    return {"桃树","三千年桃树",wb[1],xx}
 elseif 编号 == 7 then
    wb[1] = "我乃是“四千年蟠桃树”，每四千年一结果，大圣不想尝一尝么？"
    return {"桃树","四千年桃树",wb[1],xx}
 elseif 编号 == 8 then
    wb[1] = "我乃是“五千年蟠桃树”，每五千年一结果，大圣不想尝一尝么？"
    return {"桃树","五千年桃树",wb[1],xx}
 elseif 编号 == 9 then
    wb[1] = "我乃是“六千年蟠桃树”，每六千年一结果，大圣不想尝一尝么？"
    return {"桃树","六千年桃树",wb[1],xx}
 elseif 编号 == 10 then
    wb[1] = "我乃是“七千年蟠桃树”，每七千年一结果，大圣不想尝一尝么？"
    return {"桃树","七千年桃树",wb[1],xx}
 elseif 编号 == 11 then
    wb[1] = "我乃是“八千年蟠桃树”，每八千年一结果，大圣不想尝一尝么？"
    return {"桃树","八千年桃树",wb[1],xx}
    end
  return
end

__NPCdh222[6033]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  local 名称=内容[3]
  local 任务id=玩家数据[数字id].角色:取任务(70)
  if 任务数据[任务id] == nil then 添加最后对话(数字id,"你没有这样的任务！") return  end
  local 副本id=任务数据[任务id].副本id
  if 名称=="锄树力士" and 事件=="我来帮你吧" then
    if 副本数据.大闹天宫.进行[副本id].三大力士 == nil or 副本数据.大闹天宫.进行[副本id].三大力士.锄树力士 <= 0 then
      添加最后对话(数字id,"我这里么有什么任务可以交给你了，你去其他地方看看吧！")
    else
      副本_大闹天宫:大闹锄树(数字id)
      玩家数据[数字id].道具:给予道具(数字id,"大闹小铲子")
      常规提示(数字id,"#Y/你得到了大闹小铲子")
    end
  elseif 名称=="浇水力士" and 事件=="我来帮你吧" then
    if 副本数据.大闹天宫.进行[副本id].三大力士 == nil or 副本数据.大闹天宫.进行[副本id].三大力士.浇水力士 <= 0 then
      添加最后对话(数字id,"我这里么有什么任务可以交给你了，你去其他地方看看吧！")
    else
      副本_大闹天宫:大闹浇水(数字id)
    end
  elseif 名称=="修桃力士" and 事件=="我来帮你吧" then
    if 副本数据.大闹天宫.进行[副本id].三大力士 == nil or 副本数据.大闹天宫.进行[副本id].三大力士.修桃力士 <= 0 then
      添加最后对话(数字id,"我这里么有什么任务可以交给你了，你去其他地方看看吧！")
    else
      副本_大闹天宫:大闹修桃(数字id)
    end
  else
    if 事件=="我是来帮你浇水的" then
      完成大闹天宫任务({数字id},玩家数据[数字id].角色:取任务(72),72)
    elseif 事件=="我是来帮你除虫的" then
      战斗准备类:创建战斗(数字id,155585,玩家数据[数字id].角色:取任务(73))
    end
  end
end