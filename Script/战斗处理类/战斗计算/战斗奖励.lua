
local 战斗奖励 = class()
local jhf = string.format
local random = math.random
local qz=math.floor
local sj = 取随机数
function 战斗奖励:初始化()

end

function 战斗奖励:奖励事件(id,战斗数据)
	local fun = _G["奖励MOB"..tostring(战斗数据.战斗类型)]
	if fun ~= nil then
		fun(id,战斗数据)
	end
end

return 战斗奖励