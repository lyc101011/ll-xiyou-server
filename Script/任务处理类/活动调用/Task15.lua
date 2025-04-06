-- @Author: baidwwy
-- @Date:   2024-11-01 04:09:49
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-01 22:51:24
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-02-01 22:52:07
-- @最后修改来自: baidwwy
-- @Last Modified time: 2022-12-17 01:24:46
function 设置任务15(id) --回梦丹

	if 玩家数据[id].角色:取任务(15)==0 then
	local 任务id=id.."_15_"..os.time()
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=3600,
		销毁=true,
		是存档=true,
		玩家id=id,
		队伍组={},
		类型=15
	}
	常规提示(id,"#Y/你使用了回梦丹")
	玩家数据[id].角色:添加任务(任务id)

	else
		任务数据[玩家数据[id].角色:取任务(15)].结束=任务数据[玩家数据[id].角色:取任务(15)].结束+3600
		常规提示(id,"#Y/你使用了回梦丹，有效时长增加了60分钟")
	end
end

function rwgx15(任务id)
	if os.time()-任务数据[任务id].起始>=任务数据[任务id].结束 then -- 任务时间到期
		if 玩家数据[任务数据[任务id].玩家id]~=nil then
			玩家数据[任务数据[任务id].玩家id].角色:取消任务(任务id)
			发送数据(玩家数据[任务数据[任务id].玩家id].连接id,39)
			常规提示(任务数据[任务id].玩家id,"你的双倍时间到期了！")
		end
		任务数据[任务id]=nil
	end
end

function 任务说明15(玩家id,任务id)
	return {"回梦丹","#你的回梦丹效果还可持续#R/"..取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))).."#分钟。"}
end