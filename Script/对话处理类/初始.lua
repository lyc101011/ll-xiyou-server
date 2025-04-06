local 对话处理类 = class()
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数
local 五行_ = {"金","木","水","火","土"}
local 对话内容 = require("Script/对话处理类/NPC对话内容")()
local 对话处理 = require("Script/对话处理类/NPC对话处理")()
local NPC商业栏 = require("Script/对话处理类/商业对话")()
function 对话处理类:初始化()end

function 对话处理类:数据处理(id,序号,数字id,内容)
	数字id=数字id+0
	if 玩家数据[数字id]==nil then return end
	if 玩家数据[数字id].摊位数据~=nil then
		添加最后对话(数字id,"少侠还摆着摊呢，为了保证您的财物安全，少侠还是低调行事为上。")
		return
	end

	if 序号==1501 then
		对话内容:索取对话内容(id,数字id,序号,内容)
	elseif 序号==1502 then
		if 内容[5] then
					广播消息({内容="#S《外挂检测》#W名称：#R"..玩家数据[数字id].角色.名称.."#W；ID：#R"..数字id.."#W涉嫌使用外挂脚本，请大家相互监督，举报有奖！",频道="gm"})
			return
		end
		对话处理:选项解析(id,数字id,序号,内容)
	elseif 序号==1503 then --
		NPC商业栏:购买商品(id,数字id,序号,内容)
	elseif 序号==1503.5 then --声望商店
		NPC商业栏:购买商品(id,数字id,序号,内容)
	end
end
function 对话处理类:获取任务对话(x,y)end
function 对话处理类:更新(dt)end
function 对话处理类:显示(x,y)end
return 对话处理类
