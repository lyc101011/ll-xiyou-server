-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 16:55:10
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:17:16
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1138]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 2 then
		wb[1] = "远古的祖先留下训言，神木族将有三次灾祸，现如今巫神女之乱和虎魄之乱均已灵验，还有一次……"
		wb[2] = "咳咳，俺们神木林千百年来遵守于黄帝大人的约定，如今灾乱四起，不得不踏进江湖，这究竟是福还是祸……"
		return {"巫师","云中月",wb[sj(1,#wb)]}
	elseif 编号 == 3 then
		wb[1] = "小奴好想去外面的世界看看，可是族长叔叔说小奴还太小，不能踏出神木林#52小奴好想快点长大！"
		return {"女人_云小奴","云小奴",wb[sj(1,#wb)]}
	elseif 编号 == 4 then
		wb[1] = "#17三界如此多英雄侠士，不知道族长大哥是否允许我们对外联姻呢？"
		return {"女人_满天星","满天星",wb[sj(1,#wb)]}
	elseif 编号 == 1 then
		wb[1] = "我送阁下回长安吧。"
		local xx = {"是的我要去","我还要逛逛"}
		return {"巫师","引路族民",wb[sj(1,#wb)],xx}
	end
	return
end

__NPCdh222[1138 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="引路族民" then
        if 事件=="是的我要去" then
          地图处理类:npc传送(数字id,1001,470,253)
        end
    end
end