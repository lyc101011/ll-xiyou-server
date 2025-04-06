-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 12:51:42
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-09-01 15:06:08
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1204]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
			wb[1] = "小仙有一宝画，乃是上古流传下来的珍品，名曰《乾坤九曜图》。此画中有雾楼云阁，亭台水榭，青山秀水，蕊珠宫阙，只要轻轻将画卷展开，便可身临其境。各路神魔仙怪因为厌倦尘世杀戮而隐居在此，再也不问时世。天帝命丹青生将此画卷谨慎收藏，不再沾染红尘血腥。只可惜近日魔神将要现世，画中诸雄无不感到了他的怨念与仇恨而杀意萌动。他们忘却了修身养性的要诀，却没有忘记运用盖世的神功手段来杀戮他们看到的一切……于是，丹青生手执画卷，在此等待有缘的侠义之士，来化解他们的戾气。"
			local wb2 = {"侠士准备要做什么"}
			local xx2 = {"准备好了，你就等我们的好消息吧","我来一观《天地七元图》","我突然想起今天体力还没用完，等会再来"}
			 if 玩家数据[数字id].角色:取任务(630)~=0 then
			 	wb[1]="你的副本轮回境已经开启了，是否需要我帮你传送进去？"
				xx2={"请送我进去","我等会再进去"}
			end
			return{"男人_书生","丹青生",wb[取随机数(1,#wb)],xx,nil,nil,{"男人_书生","丹青生",wb2[取随机数(1,#wb2)],xx2}}
		end
	return
end

__NPCdh222[1204]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
		local 名称=内容[3]
		if 名称=="丹青生" then
				if 事件=="准备好了，你就等我们的好消息吧" then
					发送数据(id,6116)
				elseif 事件=="我来一观《天地七元图》" then
					设置任务630(数字id)
				elseif 事件=="请送我进去" then
					任务处理类:副本传送(数字id,4)
				end
		end
end