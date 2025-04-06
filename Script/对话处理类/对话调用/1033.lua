-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:43:47
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:06:52
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1033]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号==1 then
		wb[1] = "今宵有酒今宵醉，就让俺醉这一回吧！"
		wb[2] = "今天点谁来给我唱曲呢？"
		wb[3] = "人生在世不称意，可有哪位姑娘懂俺的心意？"
		return {"罗百万","罗百万",wb[取随机数(1,#wb)],xx}
    elseif 编号==2 then
		wb[1] = "人面桃花相映红。客官请与小女桃红满饮此杯。"
		wb[2] = "小女子擅弹琵琶，客官可要来上一曲？"
		wb[3] = "要不要小桃红唱首新学的小曲儿给您听听？"
		return {"少女","小桃红",wb[取随机数(1,#wb)],xx}
    elseif 编号==3 then
		wb[1] = "这位大爷一看就知道是怜香惜玉之人，我这儿的怜香惜玉两位姑娘能歌善舞，您去楼上看看？"
		wb[2] = "良辰夜景，花好月圆，这位客官喜欢哪位姑娘呀？我这儿的怜香惜玉两位姑娘能歌善舞，您去楼上看看？"
		wb[3] = "本楼可是正规娱乐场所#90客官您是要品茶还是饮酒啊？"
		return {"陈妈妈","陈妈妈",wb[取随机数(1,#wb)],xx}
    end
	return
end