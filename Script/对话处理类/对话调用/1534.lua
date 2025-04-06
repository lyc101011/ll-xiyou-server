-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 11:56:07
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:12:35
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1534]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "日行一善，积善成德。"
		wb[2] = "钱财是身外之物，能用来济世行善是最好不过。"
		wb[3] = "老夫虽膝下无子，但这万贯家财我已经找到了继承人。"
		wb[4] = "我已经不再年轻了，但我喜欢帮助有志向有作为的年轻人"
		return{"男人_老财","李善人",wb[取随机数(1,#wb)]}
	end
	return
end