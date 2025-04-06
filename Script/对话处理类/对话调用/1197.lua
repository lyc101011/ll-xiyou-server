local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1197]=function (ID,编号,页数,已经在任务中,数字id) --比武 新增整页 复制：1197.lua这个文件
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		local djsa=tonumber(比武大会.正式开启time)
		local djsb=""
		local djsc=0
		if type(比武大会)=="table" and tonumber(比武大会.正式开启time)~=nil then
			djsc=比武大会.正式开启time - os.time()
		end
		if djsa~=nil then
			djsb = " #G/还需等待：【" ..djsc .."】"
		end
		local dh="请等待比赛开始(会有提示)" ..djsb
		local xx = {"好的","我需要买点药品"}
		if 比武大会数据.进程 == 3 then
			 dh="现在可以正式比武了，要现在传送去比武吗？"
			 xx = {"开打开打","我需要买点药品","先让别人战一会"}
		end
    wb[1] = dh
		return{"男人_将军","比武大会传送人",wb[sj(1,#wb)],xx,nil,nil,nil,nil,nil,nil,djsc} --倒计时
	end
	return
end

__NPCdh222[1197]=function (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="比武大会传送人" then
        if 事件=="开打开打" then
        	比武大会:比武大会对话入场事件(数字id)
        elseif 事件=="我需要买点药品" then
        	玩家数据[数字id].商品列表=商店处理类.商品列表[52]
            发送数据(id,9,{商品=商店处理类.商品列表[52],银子=玩家数据[数字id].角色.银子})
        end
    end
end