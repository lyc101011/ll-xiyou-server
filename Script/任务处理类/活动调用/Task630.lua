-- @Author: baidwwy
-- @Date:   2024-11-01 04:09:49
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-09 21:26:01
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 22:16:36
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:29:57
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

function 设置任务630(id)
	if 玩家数据[id].队伍==0 or 玩家数据[id].队长==false  then
		常规提示(id,"#Y/该任务必须组队完成且由队长领取")
		return
	elseif 取队伍人数(id)<5 and 调试模式==false then
		常规提示(id,"#Y此副本要求队伍人数不低于5人")
		return
	elseif  取等级要求(id,115)==false then
		常规提示(id,"#Y此副本要求角色等级不能低于155级")
		return
	end
	-- if not 玩家数据[id].角色:扣除积分(50, "轮回境", id) then
	-- 	常规提示(id,"#Y积分不足50无法开启副本")
	-- 	return
	-- end
	local 队伍id=玩家数据[id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		if 副本数据.轮回境.完成[临时id]~=nil then
			常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."本日已经完成过此副本了")
			return
		elseif 玩家数据[临时id].角色:取任务(630)~=0 then
			常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."正在进行副本任务，无法领取新的副本")
			return
		end
	end
	副本数据.轮回境.进行[id]={进程=1}
	GetUpMOB630(id)
	local 任务id=id.."_630_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=7200,
		玩家id=0,
		队伍组=table.loadstring(table.tostring(队伍数据[玩家数据[id].队伍].成员数据)),
		副本id=id,
		类型=630
	}
	任务处理类:添加队伍任务(id,任务id,"#Y你开启了轮回境副本")
end

function GetUpMOB630(id)
	if 副本数据.轮回境.进行[id]==nil then
		return
	end
	if 副本数据.轮回境.进行[id].进程==1 then
		local 任务id=id.."_631_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		local 地图=2000
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			玩家id=0,
			队伍组={},
			名称="中央鬼帝",
			模型="阎罗王",
			x=112,
			y=72,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			方向=0,
			类型=631
		}
		地图处理类:添加单位(任务id)
	elseif 副本数据.轮回境.进行[id].进程==2 then
		local 任务id=id.."_632_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		local 地图=2000
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			玩家id=0,
			队伍组={},
			名称="九灵元圣",
			模型="大大王",
			x=112,
			y=72,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			方向=0,
			类型=632
		}
		地图处理类:添加单位(任务id)
	 elseif 副本数据.轮回境.进行[id].进程==3 then
	 	local 任务id=id.."_633_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		local 地图=2000
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			玩家id=0,
			队伍组={},
			名称="华岳圣母",
			模型="进阶曼珠沙华",
			x=112,
			y=72,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			方向=0,
			类型=633
		}
		地图处理类:添加单位(任务id)
	 elseif 副本数据.轮回境.进行[id].进程==4 then
	 	local 任务id=id.."_634_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		local 地图=2000
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			玩家id=0,
			队伍组={},
			名称="南斗星君",
			模型="进阶天兵",
			x=112,
			y=72,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			方向=0,
			类型=634
		}
		地图处理类:添加单位(任务id)
	 elseif 副本数据.轮回境.进行[id].进程==5 then
	 	local 任务id=id.."_635_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		local 地图=2000
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			玩家id=0,
			队伍组={},
			名称="天龙八部",
			模型="进阶金身罗汉",
			x=112,
			y=72,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			方向=0,
			类型=635
		}
		地图处理类:添加单位(任务id)
	 elseif 副本数据.轮回境.进行[id].进程==6 then
	 	local 任务id=id.."_636_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		local 地图=2000
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			玩家id=0,
			队伍组={},
			名称="无上天尊",
			模型="进阶风伯",
			x=112,
			y=72,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			方向=0,
			类型=636
		}
		地图处理类:添加单位(任务id)
	elseif 副本数据.轮回境.进行[id].进程==7 then
		local 任务id=id.."_637_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"
		local 地图=2000
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			玩家id=0,
			队伍组={},
			名称="自在天魔",
			模型="自在天魔",
			x=20,
			y=18,
			副本id=id,
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=637
		}
		地图处理类:添加单位(任务id)
	end
end

__GWdh111[631]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
  	对话数据.名称=任务数据[标识].名称
	if not 任务处理类:判定队伍组(数字id,630)then
		return
	end
	local 副本id = 任务处理类:取副本id(数字id,630)
	if 副本id == 0 or 副本id ~= 数字id  then
		对话数据.对话="只有创建副本的队长才能和我对话"
		return 对话数据
	end
	if 任务数据[标识].zhandou==nil then
		if 副本数据.轮回境.进行[数字id].进程==1  then
			if 取队伍人数(数字id)<1  and 调试模式==false then 常规提示(数字id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[标识].zhandou=true
			战斗准备类:创建战斗(数字id+0,100105,标识)
			玩家数据[数字id].地图单位=nil
		end
	end
end

__GWdh111[632]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
  	对话数据.名称=任务数据[标识].名称
	if not 任务处理类:判定队伍组(数字id,630)then
		return
	end
	local 副本id = 任务处理类:取副本id(数字id,630)
	if 副本id == 0 or 副本id ~= 数字id  then
		对话数据.对话="只有创建副本的队长才能和我对话"
		return 对话数据
	end
	if 任务数据[标识].zhandou==nil then
		if 副本数据.轮回境.进行[数字id].进程==2  then
			if 取队伍人数(数字id)<1  and 调试模式==false then 常规提示(数字id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[标识].zhandou=true
			战斗准备类:创建战斗(数字id+0,100106,标识)
			玩家数据[数字id].地图单位=nil
		end
	end
end

__GWdh111[633]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
  	对话数据.名称=任务数据[标识].名称
	if not 任务处理类:判定队伍组(数字id,630)then
		return
	end
	local 副本id = 任务处理类:取副本id(数字id,630)
	if 副本id == 0 or 副本id ~= 数字id  then
		对话数据.对话="只有创建副本的队长才能和我对话"
		return 对话数据
	end
	if 任务数据[标识].zhandou==nil then
		if 副本数据.轮回境.进行[数字id].进程==3  then
			if 取队伍人数(数字id)<1  and 调试模式==false then 常规提示(数字id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[标识].zhandou=true
			战斗准备类:创建战斗(数字id+0,100107,标识)
			玩家数据[数字id].地图单位=nil
		end
	end
end

__GWdh111[634]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
  	对话数据.名称=任务数据[标识].名称
	if not 任务处理类:判定队伍组(数字id,630)then
		return
	end
	local 副本id = 任务处理类:取副本id(数字id,630)
	if 副本id == 0 or 副本id ~= 数字id  then
		对话数据.对话="只有创建副本的队长才能和我对话"
		return 对话数据
	end
	if 任务数据[标识].zhandou==nil then
		if 副本数据.轮回境.进行[数字id].进程==4  then
			if 取队伍人数(数字id)<1  and 调试模式==false then 常规提示(数字id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[标识].zhandou=true
			战斗准备类:创建战斗(数字id+0,100108,标识)
			玩家数据[数字id].地图单位=nil
		end
	end
end

__GWdh111[635]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
  	对话数据.名称=任务数据[标识].名称
	if not 任务处理类:判定队伍组(数字id,630)then
		return
	end
	local 副本id = 任务处理类:取副本id(数字id,630)
	if 副本id == 0 or 副本id ~= 数字id  then
		对话数据.对话="只有创建副本的队长才能和我对话"
		return 对话数据
	end
	if 任务数据[标识].zhandou==nil then
		if 副本数据.轮回境.进行[数字id].进程==5  then
			if 取队伍人数(数字id)<1  and 调试模式==false then 常规提示(数字id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[标识].zhandou=true
			战斗准备类:创建战斗(数字id+0,100109,标识)
			玩家数据[数字id].地图单位=nil
		end
	end
end

__GWdh111[636]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
  	对话数据.名称=任务数据[标识].名称
	if not 任务处理类:判定队伍组(数字id,630)then
		return
	end
	local 副本id = 任务处理类:取副本id(数字id,630)
	if 副本id == 0 or 副本id ~= 数字id  then
		对话数据.对话="只有创建副本的队长才能和我对话"
		return 对话数据
	end
	if 任务数据[标识].zhandou==nil then
		if 副本数据.轮回境.进行[数字id].进程==6  then
			if 取队伍人数(数字id)<1  and 调试模式==false then 常规提示(数字id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[标识].zhandou=true
			战斗准备类:创建战斗(数字id+0,100110,标识)
			玩家数据[数字id].地图单位=nil
		end
	end
end

__GWdh111[637]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
  	对话数据.名称=任务数据[标识].名称
	if not 任务处理类:判定队伍组(数字id,630)then
		return
	end
	local 副本id = 任务处理类:取副本id(数字id,630)
	if 副本id == 0 or 副本id ~= 数字id  then
		对话数据.对话="只有创建副本的队长才能和我对话"
		return 对话数据
	end
	if 任务数据[标识].zhandou==nil then
		if 副本数据.轮回境.进行[数字id].进程==7  then
			if 取队伍人数(数字id)<1  and 调试模式==false then 常规提示(数字id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[标识].zhandou=true
			战斗准备类:创建战斗(数字id+0,100111,标识)
			玩家数据[数字id].地图单位=nil
		end
	end
end

function rwgx630(任务id)
	if os.time()-任务数据[任务id].起始>=任务数据[任务id].结束 and 任务数据[任务id].结束 ~= 99999999 then
		if 任务数据[任务id].zhandou~=true then  --未进入战斗状态
			if  任务数据[任务id].类型== 630 then
				for i=1,#任务数据[任务id].队伍组 do
					if 玩家数据[任务数据[任务id].队伍组[i]] ~= nil then
						玩家数据[任务数据[任务id].队伍组[i]].角色:取消任务(玩家数据[任务数据[任务id].队伍组[i]].角色:取任务(630))
					end
				end
				任务数据[任务id]=nil
			else
				地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
				任务数据[任务id]=nil
			end
		end
	end
end

function 任务说明630(玩家id,任务id)
	local 说明 = {}
	local 副本id=任务数据[任务id].副本id
	if 副本数据.轮回境.进行[副本id]==nil then
		说明={"轮回境","#L您的副本已经完成"}
	else
		说明={"轮回境",format("#L挑战#R七关#L，击败自在天魔。(剩余%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
	end
	return 说明
end