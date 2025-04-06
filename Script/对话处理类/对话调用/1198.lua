-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 16:45:03
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

__NPCdh111[1198]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 2 then
		wb[1] = "我家老程的三板斧据说是在梦中学会的，我才不信呢。"
		wb[2] = "现在是太平盛世，百姓安居乐业。"
		wb[3] = "我家兄弟当初与老爷并肩作战，现如今也不知身在何处？"
		wb[4] = "听说老爷最近要远征歼杀突厥，真担心他的身子。"
		return{"女人_程夫人","程夫人",wb[sj(1,#wb)],xx}
	elseif 编号 == 3 then
		wb[1] = "心比天高，命比纸薄，我的人生也会如此么？"
		wb[2] = "夫人什么时候再上街呢……好想再见到那个小哥一面#17"
		wb[3] = "我家老爷是开国功臣，现在正在广招门徒。"
		return{"女人_丫鬟","丫鬟",wb[sj(1,#wb)],xx}
	elseif 编号 >= 4 and 编号 < 8 then
		wb[1] = "程老爷三板斧，你学到第几斧啦？"
		wb[2] = "能拜我们程老爷为师可是一种荣幸呢！"
		wb[3] = "府衙禁地，闲杂人等不得入内。"
		wb[4] = "这里是天子脚下，太平得很"
		wb[5] = "大唐首席弟子之争日趋白热。"
		return{"护卫","程府护卫",wb[sj(1,#wb)],xx}
	elseif 编号 == 1 then
		wb[1] = "我送阁下回长安吧。"
		local xx = {"是的我要去","我还要逛逛"}
		return{"护卫","传送护卫",wb[sj(1,#wb)],xx}
	end
	return
end

__NPCdh222[1198 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="传送护卫" then
        if 事件=="是的我要去" then
          地图处理类:npc传送(数字id,1001,470,253)
        end
    end
end