-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 11:53:11
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

__NPCdh111[1502]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "客官想要什么兵器？"
		wb[2] = "行走江湖不能两手空空，来挑一件趁手的兵器吧。"
		wb[3] = "这里的风景还不错吧。"
		wb[4] = "少侠是来选购兵器的吧？请慢慢挑选，务必看清楚名称哦！"
		local xx = {"购买","我只是来看看"}
		return{"男人_武器店老板","武器店老板",wb[取随机数(1,#wb)],xx}
	elseif 编号 == 2 then
		wb[1] = "长安武器店专卖0级和20级武器，0级和10级的武器则在建邺城出售。少侠记住了没#1"
		wb[2] = "瞧一瞧看一看了，我这里的武器最适合新人使用了。边上的老板出售高级一点的兵器，购买时请看清楚物品等级，别买错了哦#2"
		local xx = {"购买","我只是来看看"}
		return{"男人_老孙头","武器店掌柜",wb[取随机数(1,#wb)],xx}
	elseif 编号 == 3 then
		wb[1] = "（这是一个燃着暗红色火光的打铁炉，使用的时候请小心，烫到手就不好了。）"
		local xx = {"查看熟练度","打造","合成","修理","分解","熔炼"}
		return{nil,"打铁炉",wb[取随机数(1,#wb)],xx}
	end
	return
end

__NPCdh222[1502 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="武器店老板" then  --建邺
        if 事件=="购买" then
          玩家数据[数字id].商品列表=商店处理类.商品列表[4]
          发送数据(id,9,{商品=商店处理类.商品列表[4],银子=玩家数据[数字id].角色.银子})
        end
    elseif 名称=="武器店掌柜" then  --建邺
        if 事件=="购买" then
          玩家数据[数字id].商品列表=商店处理类.商品列表[3]
          发送数据(id,9,{商品=商店处理类.商品列表[3],银子=玩家数据[数字id].角色.银子})
        end
    end
end