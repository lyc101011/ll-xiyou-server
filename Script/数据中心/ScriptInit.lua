-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:44
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-08-05 13:22:55
require("Script/数据中心/宝宝")
require("Script/数据中心/变身卡")
require("Script/数据中心/场景NPC")
require("Script/数据中心/场景等级")
require("Script/数据中心/场景名称")
require("Script/数据中心/传送圈位置")
require("Script/数据中心/传送位置")
require("Script/数据中心/法术技能特效")
require("Script/数据中心/活动")
require("Script/数据中心/角色")
require("Script/数据中心/明暗雷怪")
require("Script/数据中心/取经验")
require("Script/数据中心/取师门")
require("Script/数据中心/染色")
require("Script/数据中心/物品数据")
require("Script/数据中心/野怪")
require("Script/数据中心/装备特技")
require("Script/数据中心/强化符")
require("Script/数据中心/随机怪物")
require("Script/数据中心/活动配置")
-- require("Script/数据中心/全服抽奖")
全局坐骑资料=require("Script/数据中心/坐骑库")()

-- collectgarbage("collect");--为了有干净的环境,先把可以收集的其他垃圾赶走先
-- local  c1 = collectgarbage("count")
skill = require("Script/数据中心/技能数据库").创建()
-- local c2 = collectgarbage("count")