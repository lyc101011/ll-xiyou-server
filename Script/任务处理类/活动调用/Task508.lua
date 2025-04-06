-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 22:31:34
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:42:28
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__GWdh111[508]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
		对话数据.模型=任务数据[标识].模型
		对话数据.名称=任务数据[标识].名称
		对话数据.对话="我是首席大弟子，你找我什么事？"
	if 任务数据[标识].门派 == 玩家数据[数字id].角色.门派 then
		对话数据.选项={"领取称谓","我要竞选","我是竞选者","我要挑战你","我要投票","我要定制门派秘方的消息",}
	end
	return 对话数据
end

__GWdh222[508]=function (连接id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	 if 事件=="领取称谓" then

		elseif 事件=="我要竞选" then
			-- if 首席竞选数据.开启 == true then
			-- 	if 首席竞选数据[玩家数据[数字id].角色.门派].挑战名单[数字id] ~= nil then
			-- 		首席弟子类:竞选首席(数字id)
			-- 	else
			-- 		常规提示(数字id,"#Y/你还没有挑战过门派首席")
			-- 	end
			-- else
			-- 	常规提示(数字id,"#Y/首席竞选没有开始")
			-- end
		elseif 事件=="我是竞选者" then
		elseif 事件=="我要投票" then
			-- if 首席竞选数据.开启 == true then
			-- 	首席弟子类:我要投票(数字id)
			-- else
			-- 	常规提示(数字id,"#Y/首席竞选没有开始")
			-- end
		elseif 事件=="我要挑战你" then
			-- if 首席竞选数据.开启 == true then
			-- 	if 玩家数据[数字id].队伍~=0 then
			-- 		常规提示(数字id,"#Y/挑战首席不允许组队")
			-- 	else
			-- 		if 首席竞选数据[玩家数据[数字id].角色.门派].挑战名单[数字id] == nil then
			-- 			战斗准备类:创建战斗(数字id+0,101001,玩家数据[数字id].地图单位.标识)
			-- 		else
			-- 			常规提示(数字id,"#Y/你已经挑战过了门派首席")
			-- 		end
			-- 	end
			-- else
			-- 	常规提示(数字id,"#Y/首席竞选没有开始")
			-- end
			return
		elseif 事件=="我要定制门派秘方的消息" then

		end
end