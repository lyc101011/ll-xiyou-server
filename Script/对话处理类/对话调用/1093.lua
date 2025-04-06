-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:37:05
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

__NPCdh111[1093]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "我的店里有好酒，保准让客官饮后忘却一切烦恼！"
		local xx = {"购买","我什么都不想做"}
		return {"男人_酒店老板","王福来",wb[sj(1,#wb)],xx}
   elseif 编号 == 2 then
		wb[1] = "春茶苦，夏茶涩，品茶当品秋白露。"
		wb[2] = "认人如同品茶，观色闻香尚不够，还需切身细细体会和感受。"
		wb[3] = "这位朋友喜欢红茶，绿茶，还是乌龙茶？"
		wb[4] = "夏季宜饮绿，冬季宜饮红，春秋两季皆饮花，此乃养生之道也。"
		wb[5] = "这里就是东胜神洲傲来国了，听说齐天大圣就住在附近。"
		wb[6] = "我这里有上好的龙井茶，你想不想尝尝？"
		if 玩家数据[数字id].角色:取任务(19)~=0 and 任务数据[玩家数据[数字id].角色:取任务(19)].任务NPC=="慕容先生" then
			xx = {"我帮你带来了驱邪扇芝","我点错了"}
		end
		return {"男人_老书生","慕容先生",wb[sj(1,#wb)],xx}
	end
	return
end

__NPCdh222[1093 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="王福来" then  --建邺
        if 事件=="购买" then
          玩家数据[数字id].商品列表=商店处理类.商品列表[14]
          发送数据(id,9,{商品=商店处理类.商品列表[14],银子=玩家数据[数字id].角色.银子})
        end
    elseif 名称=="慕容先生" then
    	if 事件=="我帮你带来了驱邪扇芝" then
            玩家数据[数字id].给予数据={类型=1,id=0,事件="我帮你带来了驱邪扇芝"}
            发送数据(id,3530,{道具=玩家数据[数字id].道具:索要道具1(数字id),名称=名称,类型="NPC",等级="无"})
        end
    end
end