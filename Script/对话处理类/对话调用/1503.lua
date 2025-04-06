-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 11:53:56
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

__NPCdh111[1503]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "小店的服饰都是请城里的裁缝精心裁剪的，做工绝对没有问题。"
		wb[2] = "城里的老少都穿我卖的衣服。"
		wb[3] = "小店布匹又快用光了，过两天得去城里进货。"
		wb[4] = "本店服装纯手工制作，随便看看吧。"
		local xx = {"购买","我只是来看看"}
		return{"男人_服装店老板","服装店老板",wb[取随机数(1,#wb)],xx}
	elseif 编号 == 2 then
		wb[1] = "（缝纫台上摆放着布匹、剪刀、尺子等物品，欢迎使用）"
		local xx = {"查看熟练度","打造","合成","认证"}
		return{nil,"缝纫台",wb[取随机数(1,#wb)],xx}
	end
	return
end

__NPCdh222[1503 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="服装店老板" then  --建邺
        if 事件=="购买" then
          玩家数据[数字id].商品列表=商店处理类.商品列表[1]
          发送数据(id,9,{商品=商店处理类.商品列表[1],银子=玩家数据[数字id].角色.银子})
        end
    end
end