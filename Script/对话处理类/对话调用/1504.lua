-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 11:54:31
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

__NPCdh111[1504]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "城里有位好心的郎中陈长寿，看病从不收银子，他一般都在去东海湾的城门口附近摆摊看病。"
		wb[2] = "拉肚子，选好药，选药也要有诀窍。"
		wb[3] = "客官需要什么药？"
		wb[4] = "俗话说“对症下药”，这药可是不能乱吃的。"
		wb[5] = "佛手可以去长安、西梁女国和朱紫国的药店买哦。"
		wb[6] = "药材好，药才好。"
		local xx = {"购买","我只是来看看"}
		return{"男人_药店老板","药店老板",wb[取随机数(1,#wb)],xx}
	end
	return
end

__NPCdh222[1504 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="药店老板" then  --建邺
        if 事件=="购买" then
          玩家数据[数字id].商品列表=商店处理类.商品列表[2]
          发送数据(id,9,{商品=商店处理类.商品列表[2],银子=玩家数据[数字id].角色.银子})
        end
    end
end