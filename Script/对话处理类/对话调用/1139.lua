-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 17:57:39
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

__NPCdh111[1139]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "欢迎你来到神秘而美丽的无底洞#86"
		wb[2] = "我们无底洞里还有很多神秘的故事呢#86"
		wb[3] = "我最喜欢这些红花了，闻起来香喷喷的~~"
		return {"幽萤娃娃","璎珞",wb[sj(1,#wb)]}
	elseif 编号 == 2 then
		wb[1] = "我们似乎已经在此处待了很久很久了。"
		wb[2] = "红莲那丫头的性子，还是那么莽撞冲动，真是伤脑筋啊#83"
		wb[3] = "能来到这里，真是一段难得的缘分呢……"
		return {"修罗傀儡妖","墨衣",wb[sj(1,#wb)]}
	elseif 编号 == 3 then
		wb[1] = "我这么年轻美丽，一定是妹妹啦，你们说对不对#86"
		wb[2] = "你猜墨衣是我的姐姐还是我的妹妹#110"
		wb[3] = "其实我有点害怕姐姐呢，这么多年了，她一直都是那么严厉，比地涌夫人还凶#17"
		return {"修罗傀儡妖","红莲",wb[sj(1,#wb)]}
	elseif 编号 == 4 then
		wb[1] = "我送阁下回长安吧。"
		local xx = {"是的我要去","我还要逛逛"}
		return {"幽萤娃娃","接引小妖",wb[sj(1,#wb)],xx}
	end
	return
end

__NPCdh222[1139 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="接引小妖" then
        if 事件=="是的我要去" then
          地图处理类:npc传送(数字id,1001,470,253)
        end
    end
end