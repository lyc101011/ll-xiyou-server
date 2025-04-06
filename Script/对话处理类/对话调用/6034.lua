-- @Author: baidwwy
-- @Date:   2023-12-03 11:44:24
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2023-12-04 10:18:56
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
__NPCdh111[6034]=function (ID,编号,页数,已经在任务中,数字id)
  local wb = {}
  local xx = {}
 if 编号 == 1 then
    wb[1] = "咦，你是何人来这蟠桃宴有何贵干？"
    wb[2] = "不知大仙前来有失远迎，这蟠桃会真实热闹啊！"
    wb[3] = "大仙真是好雅致，不知找小仙有何事？"

    return {"护卫","造酒仙官",wb[取随机数(1,#wb)]}
 elseif 编号 == 2 then
    wb[1] = "咦，你是何人来这蟠桃宴有何贵干？"
    wb[2] = "不知大仙前来有失远迎，这蟠桃会真实热闹啊！"
    wb[3] = "大仙真是好雅致，不知找小仙有何事？"

    return {"雨师","运水道人",wb[取随机数(1,#wb)]}
 elseif 编号 == 3 then
    wb[1] = "咦，你是何人来这蟠桃宴有何贵干？"
    wb[2] = "不知大仙前来有失远迎，这蟠桃会真实热闹啊！"
    wb[3] = "大仙真是好雅致，不知找小仙有何事？"

    return {"小魔头","烧火童子",wb[取随机数(1,#wb)]}
 elseif 编号 == 4 then
    wb[1] = "咦，你是何人来这蟠桃宴有何贵干？"
    wb[2] = "不知大仙前来有失远迎，这蟠桃会真实热闹啊！"
    wb[3] = "大仙真是好雅致，不知找小仙有何事？"

    return {"风伯","盘槽力士",wb[取随机数(1,#wb)]}
    end
  return
end

