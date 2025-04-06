
local 账号管理 = class()


function 账号管理:初始化()

end

function 账号管理:数据处理(连接id,序号,内容)
	local 数字id = 内容.数字id+0
	if 序号 ==6401 then
		-- self:取账号数据(连接id,数字id)
	elseif 序号 ==6402 then
	    -- self:上传收款码(连接id,数字id,内容)
	elseif 序号 ==6403 then
	    self:修改密码(连接id,数字id,内容)
	elseif 序号 ==6404 then
		-- self:提现(连接id,数字id)
	elseif 序号 ==6405 then
		-- self:兑换仙玉(连接id,数字id)
	elseif 序号 ==6406 then
		-- self:取提现数据(连接id,数字id)
	elseif 序号 ==6407 then
		-- self:提现完成(连接id,数字id,内容)
	elseif 序号 ==6408 then
		self:在线系统消息(连接id,数字id,内容)
	elseif 序号 ==6409 then
		self:所有系统消息(连接id,数字id,内容)
	end
end

function 账号管理:在线系统消息(连接id,数字id,内容)
	-- for k,v in pairs(玩家数据) do
	-- 	if 玩家数据[k] ~= nil then --and 玩家数据[k].连接id ~= "假人"
	-- 		闪烁消息(k,内容.消息)
	-- 	end
	-- end
end

function 账号管理:所有系统消息(连接id,数字id,内容)
	-- 广播系统消息(内容.消息)
end



function 账号管理:修改密码(连接id,数字id,内容)
end

return 账号管理