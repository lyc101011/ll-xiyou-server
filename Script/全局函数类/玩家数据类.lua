function 取银子(id)
	return 玩家数据[id].角色.银子
end

function 取名称(id)
	return 玩家数据[id].角色.名称
end
function 道具刷新(id)
	发送数据(玩家数据[id].连接id,3699)
end

function 刷新修炼数据(id)
	发送数据(玩家数据[id].连接id,44,{人物=玩家数据[id].角色.修炼,bb=玩家数据[id].角色.bb修炼})
end

function 体活刷新(id)
	if id == nil then return  end
	发送数据(玩家数据[id].连接id,15,{体力=玩家数据[id].角色.体力,活力=玩家数据[id].角色.活力})
end

function 刷新玩家货币(连接id,id)
	发送数据(连接id,35,{银子=玩家数据[id].角色.银子,储备=玩家数据[id].角色.储备,存银=玩家数据[id].角色.存银,经验=玩家数据[id].角色.当前经验})
end

function 取灵气上限(等级)
	if 等级==1 then
		return 200
	elseif 等级==2 then
		return 300
	else
		return 500
	end
end

function 取等级(id)
	return 玩家数据[id].角色.等级
end
function 跳转长安(数字id)
	地图处理类:跳转地图(数字id,1001,427,73)
end