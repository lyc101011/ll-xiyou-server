-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:51:42
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:18:35
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[5002]=function (ID,编号,页数,已经在任务中,数字id)

  	local wb = {}
  	local xx = {}
    local 临时名称=取假人表(5002)
  	if 编号 then
      	wb[1] = "我是“"..临时名称[编号].名称.."使者”，如果你身上有99个神兜兜+1个灵兜兜可以在我这里领取神兽“超级神龙”！当然您也可以看看我或者来了解一下我们的族群，我最喜欢聊天了。"
      	local xx = {"我来带你一起回家（领取时需要花费50点体力）","我还有事，下回再来好好交流吧"}
      	return {临时名称[编号].名称,临时名称[编号].名称,wb[1],xx}
    end
	return
end

__NPCdh222[5002]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
    if 事件=="我来带你一起回家（领取时需要花费50点体力）" then
      添加最后对话(数字id,"少侠你要选择哪种类型的超级神龙",{"物理型（单点爆伤）","法术型（秒伤）","让我思考一下"})
    elseif 事件=="物理型（单点爆伤）" or 事件=="法术型（秒伤）" then
      if #玩家数据[数字id].召唤兽.数据 >= 7 then
        常规提示(数字id, "#Y/你目前最多只能携带7只召唤兽")
        return false
      end
      玩家数据[数字id].道具:神兽兑换(数字id,事件,名称)
    end

end