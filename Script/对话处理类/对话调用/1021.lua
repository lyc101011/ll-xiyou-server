-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:35:21
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

__NPCdh111[1021]=function(ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
			wb[1] = "本店是小本经营，客官想要买些什么？#40"
			wb[2] = "小店新进了一批黄纸香烛，要不要买一些？#40"
			wb[3] = "这里出售供奉和祭祀用品。#40"
			wb[4] = "今生多行善，福寿自绵长。#40"
			wb[5] = "常来店里走一走，多儿多女多福寿。#40"
			local xx = {"购买","我什么都不想做"}
			if 玩家数据[数字id].角色:取任务(1163)~=0 and 任务数据[玩家数据[数字id].角色:取任务(1163)].分类==7 then
    			xx = {"文韵墨香","我要做其他事情","我点错了"}
			end
			return {"男人_老伯","福寿店老板",wb[sj(1,#wb)],xx}
		end
	return
end

__NPCdh222[1021]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
		local 名称=内容[3]
		if 名称=="福寿店老板" then  --建邺
			if 事件=="购买" then
				玩家数据[数字id].商品列表=商店处理类.商品列表[46]
				发送数据(id,9,{商品=商店处理类.商品列表[46],银子=玩家数据[数字id].角色.银子})
			elseif 事件=="文韵墨香" then
				文韵墨香:得到纸钱(数字id)
			elseif 事件=="我要做其他事情" then
			    添加最后对话(数字id,"小店新进了一批黄纸香烛，要不要买一些？#40",{"购买","我什么都不想做"})
			end
		end
end