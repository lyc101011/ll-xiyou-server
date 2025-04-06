-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-08-16 18:53:28
function 设置任务9(id)
	local 任务id=id.."_9_"..os.time()
	local 结束时间=43200    --摄妖香时间控制
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=结束时间,
		玩家id=id,
		队伍组={},
		类型=9
	}
	玩家数据[id].角色:添加任务(任务id)
	发送数据(玩家数据[id].连接id,39)
end

function rwgx9(任务id)
	if os.time()-任务数据[任务id].起始>=任务数据[任务id].结束 and 任务数据[任务id].结束 ~= 99999999 then -- 任务时间到期
		if 玩家数据[任务数据[任务id].玩家id]~=nil then
			玩家数据[任务数据[任务id].玩家id].角色:取消任务(任务id)
			发送数据(玩家数据[任务数据[任务id].玩家id].连接id,39)
			常规提示(任务数据[任务id].玩家id,"你的摄妖香过期了！")
		end
		任务数据[任务id]=nil
	end
end

function 任务说明9(玩家id,任务id)
	local 说明 = {}
	local sjx = 取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)))
	说明={"摄妖香","#L你的摄妖香效果还可持续#R/"..sjx.."#L/分钟。","在低于自身等级+10的场景中不会触发暗雷战斗。",sjx}
	return 说明
end