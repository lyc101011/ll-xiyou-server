-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-01-16 20:34:34
-- @Author: baidwwy
-- @Date:   2024-04-14 22:24:26
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-08-12 20:07:05
local 副本_乌鸡国 = class()

function 副本_乌鸡国:初始化()
	地图处理类.地图数据[6001]={npc={},单位={},传送圈={}}
	地图处理类.地图玩家[6001]={}
	地图处理类.地图坐标[6001]=地图处理类.地图坐标[1131]
	地图处理类.地图单位[6001]={}
	地图处理类.单位编号[6001]=1000
	地图处理类.地图数据[6002]={npc={},单位={},传送圈={}}
	地图处理类.地图玩家[6002]={}
	地图处理类.地图坐标[6002]=地图处理类.地图坐标[1209]
	地图处理类.地图单位[6002]={}
	地图处理类.单位编号[6002]=1000
end

function 副本_乌鸡国:开启副本(id)
	if 服务端参数.小时+0 >= 23 then
		常规提示(id,"#Y/23点后不可做副本任务")
		return
	end
	if 玩家数据[id].队伍==0 or 玩家数据[id].队长==false then
		常规提示(id,"#Y/该任务必须组队完成且由队长领取")
		return
	elseif 取队伍人数(id)<5 and 调试模式==false then
		常规提示(id,"#Y此副本要求队伍人数不低于5人")
		return
	elseif 取等级要求(id,50)==false then
		常规提示(id,"#Y此副本要求角色等级不能低于50级")
		return
	end
	local 队伍id=玩家数据[id].队伍
	for n=1,#队伍数据[队伍id].成员数据 do
		local 临时id=队伍数据[队伍id].成员数据[n]
		if 副本数据.乌鸡国.完成[临时id]~=nil then
			常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."本日已经完成过此副本了")
			return
		elseif 玩家数据[临时id].角色:取任务(120)~=0 then
			常规提示(id,"#Y"..玩家数据[临时id].角色.名称.."正在进行副本任务，无法领取新的副本")
			return
		end
	end
	副本数据.乌鸡国.进行[id]={进程=1,数量=0}
	local 任务id,ZU=取唯一任务(120,id)
	任务数据[任务id]={
		id=任务id,
		起始=os.time(),
		结束=3600,
		玩家id=0,
		DWZ=ZU,
		销毁=true,
		副本重置=true,
		队伍组=ZU,
		副本id=id,
		类型=120
	}
	任务处理类:添加队伍任务(id,任务id,"#Y你开启了乌鸡国副本")
	刷新任务121(id)
end

__GWdh111[121]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	if 任务数据[标识].zhandou==nil then
		if 玩家数据[数字id].队伍==0 then 常规提示(数字id,"#Y请组队完成！") return   end
		任务数据[标识].zhandou=true
		战斗准备类:创建战斗(数字id+0,100028,标识) --芭蕉木妖
		玩家数据[数字id].地图单位=nil
		return
	else
		对话数据.对话="我正在战斗中，请勿打扰。"
	end
	return 对话数据
end

__GWdh111[122]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
		对话数据.模型=任务数据[标识].模型
		对话数据.名称=任务数据[标识].名称
		if 玩家数据[数字id].队伍==0 then
			常规提示(数字id,"#Y请组队完成")
			return
		else
			local 副本id=任务数据[标识].副本id
			副本数据.乌鸡国.进行[副本id].数量=副本数据.乌鸡国.进行[副本id].数量+1
			if 副本数据.乌鸡国.进行[副本id].数量>=15 then
				副本数据.乌鸡国.进行[副本id].进程=3
				刷新任务121(副本id)
			end
			local 任务id = 玩家数据[数字id].角色:取任务(120)
			if 任务id~=0 then
			    for i=1,#任务数据[任务id].队伍组 do
					local id = 任务数据[任务id].队伍组[i]
					if 玩家数据[id] then
						local 等级=玩家数据[id].角色.等级
						local 经验=等级*取随机数(1350,1550)
						local 银子=等级*取随机数(90,120)+16000
						玩家数据[id].角色:添加经验(经验,"乌鸡国热心仙人")
						玩家数据[id].角色:添加银子(银子,"乌鸡国热心仙人",1)
					end
				end
			end
			任务处理类:删除单位(标识)
			刷新队伍任务追踪(数字id)
		end
	return 对话数据
end

__GWdh111[123]=function(连接id,数字id,序列,标识,地图) --乌鸡国王
	local 对话数据={}
  	对话数据.模型=任务数据[标识].模型
  	对话数据.名称=任务数据[标识].名称
  	对话数据.对话="那妖怪正在皇宫内冒充我作恶，还请少侠赶紧进去揭露事情真相。"
    对话数据.选项={"送我进去","我再想想"}
	return 对话数据
end

__GWdh222[123]=function (连接id,数字id,序号,内容)
	local 事件=内容[1]
 	local 名称=内容[3]
 	地图处理类:跳转地图(数字id,6002,26,58)
    玩家数据[数字id].地图单位=nil
    local 副本id = 任务处理类:取副本id(数字id,120)
	if 副本数据.乌鸡国.进行[副本id]==nil then
		添加最后对话(数字id,"副本已被重置，请重新领取副本任务")
		return
	end
	if 副本数据.乌鸡国.进行[副本id].进程==3 and 副本数据.乌鸡国.进行[副本id].分类 then
	    副本数据.乌鸡国.进行[副本id].分类=nil
	    刷新队伍任务追踪(数字id)
	end
end

__GWdh111[124]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
  	对话数据.模型=任务数据[标识].模型
  	对话数据.名称=任务数据[标识].名称
  	对话数据.对话="你是谁？离这里远一点。"
    对话数据.选项={"哼，少废话，看打！","我这就走，这就走"}
	return 对话数据
end

__GWdh222[124]=function (连接id,数字id,序号,内容)
	local 事件=内容[1]
 	local 名称=内容[3]
 	if 事件=="哼，少废话，看打！" then
      if 任务数据[玩家数据[数字id].地图单位.标识].zhandou~=nil then 常规提示(数字id,"#Y/对方正在战斗中") return  end
      if 取队伍人数(数字id)<1  and 调试模式==false then 常规提示(数字id,"#Y队伍人数低于3人，无法进入战斗") return  end
      local 副本id=任务数据[玩家数据[数字id].地图单位.标识].副本id
      if 副本数据.乌鸡国.进行[副本id].序列[任务数据[玩家数据[数字id].地图单位.标识].序列] then 常规提示(数字id,"#Y/你都已经打败过我了，你还要鞭尸吗？？？") return  end
      战斗准备类:创建战斗(数字id+0,100029,玩家数据[数字id].地图单位.标识)
      任务数据[玩家数据[数字id].地图单位.标识].zhandou=true
      玩家数据[数字id].地图单位=nil
      return
    end
end

__GWdh111[125]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
  	对话数据.模型=任务数据[标识].模型
  	对话数据.名称=任务数据[标识].名称
  	if 任务数据[标识].zhandou==nil then
		if 玩家数据[数字id].队伍==0 then 常规提示(数字id,"#Y请组队完成！") return  end
		对话数据.对话="身怀异宝，快快的跑#80；宝物太重，我跑不动#15"
	    对话数据.选项={"准备好了","饶你一命"}
	else
	对话数据.对话="我正在战斗中，请勿打扰。"
	end
	return 对话数据
end

__GWdh222[125]=function (连接id,数字id,序号,内容)
	local 事件=内容[1]
 	local 名称=内容[3]
 	if 事件=="准备好了" and 玩家数据[数字id].角色:取任务(120)~=0 then
      if 任务数据[玩家数据[数字id].地图单位.标识].zhandou~=nil then 常规提示(数字id,"#Y/对方正在战斗中") return  end
      if 取队伍人数(数字id)<1 and 调试模式==false then 常规提示(数字id,"#Y队伍人数低于3人，无法进入战斗") return  end
      任务数据[玩家数据[数字id].地图单位.标识].zhandou=true
      战斗准备类:创建战斗(数字id+0,100030,玩家数据[数字id].地图单位.标识)
      玩家数据[数字id].地图单位=nil
      return
    end
end

__GWdh111[126]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
  	对话数据.模型=任务数据[标识].模型
  	对话数据.名称=任务数据[标识].名称
  	对话数据.对话="你确定他是假冒的乌鸡国王吗？（如果选择正确只需要完成一场战斗，如果误伤好人则还需要继续挑战假冒国王）。"
    对话数据.选项={"假冒国王就是他！","我再想想"}
	return 对话数据
end

__GWdh222[126]=function (连接id,数字id,序号,内容)
	local 事件=内容[1]
 	local 名称=内容[3]
 	if 事件=="假冒国王就是他！" and 玩家数据[数字id].角色:取任务(120)~=0 then
      -- if 任务数据[玩家数据[数字id].地图单位.标识].zhandou~=nil then 常规提示(数字id,"#Y/对方正在战斗中") return  end
      if 取队伍人数(数字id)<1 and 调试模式==false then 常规提示(数字id,"#Y队伍人数低于3人，无法进入战斗") return  end
      -- 任务数据[玩家数据[数字id].地图单位.标识].zhandou=true
      战斗准备类:创建战斗(数字id+0,100031,玩家数据[数字id].地图单位.标识)
      玩家数据[数字id].地图单位=nil
      return
    end
end

function 刷新任务121(id)
	local id = 任务处理类:取副本id(id,120)
	if 副本数据.乌鸡国.进行[id]==nil then
		return
	end
	local 数量=15
	if 副本数据.乌鸡国.进行[id].进程==1 then
		local 地图=6001
		local x待发送数据 = {[地图]={}}
		副本数据.乌鸡国.进行[id].数量=0
		for n=1,数量 do
			local 任务id=id.."_121_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"..n
			local xy=地图处理类.地图坐标[地图]:取随机点()
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				玩家id=0,
				销毁=true,
				副本重置=true,
				队伍组={},
				名称="芭蕉木妖",
				模型="树怪",
				变异=false,
				x=xy.x,
				y=xy.y,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=121
			}
			table.insert(x待发送数据[地图], 地图处理类:批量添加单位(任务id))
		end
		for n, v in pairs(地图处理类.地图玩家[地图]) do
			if 地图处理类:取同一地图(地图,id,n,1)  then
				发送数据(玩家数据[n].连接id,1021,x待发送数据[地图])
			end
		end
		x待发送数据={}
	elseif 副本数据.乌鸡国.进行[id].进程==2 then
		local 地图=6001
		local x待发送数据 = {[地图]={}}
		副本数据.乌鸡国.进行[id].数量=0
		for n=1,数量 do
			local 任务id=id.."_122_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"..n
			local xy=地图处理类.地图坐标[地图]:取随机点()
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				销毁=true,
				副本重置=true,
				玩家id=0,
				队伍组={},
				名称="热心仙人",
				模型="热心仙人",
				x=xy.x,
				y=xy.y,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=122
			}
			table.insert(x待发送数据[地图], 地图处理类:批量添加单位(任务id))
		end
		for n, v in pairs(地图处理类.地图玩家[地图]) do
			if 地图处理类:取同一地图(地图,id,n,1)  then
				发送数据(玩家数据[n].连接id,1021,x待发送数据[地图])
			end
		end
		x待发送数据={}
	elseif 副本数据.乌鸡国.进行[id].进程==3 then
		副本数据.乌鸡国.进行[id].数量=0
		副本数据.乌鸡国.进行[id].分类=1
		副本数据.乌鸡国.进行[id].序列={false,false,false}
		for n=1,1 do
			local 任务id=id.."_123_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"..n
			local 地图=6001
			local xy=地图处理类.地图坐标[地图]:取随机点()
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				销毁=true,
				副本重置=true,
				玩家id=0,
				队伍组={},
				名称="乌鸡国王",
				模型="文伯",
				x=115,
				y=71,
				方向=1,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=123
			}
			地图处理类:添加单位(任务id)
		end
		local 地图=6002
		local x待发送数据 = {[地图]={}}
		local 名称={"囚神妖怪","拘灵妖怪","缚仙妖怪"}
		for n=1,3 do
			local 任务id=id.."_124_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"..n
			local xy=地图处理类.地图坐标[地图]:取随机点()
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				销毁=true,
				副本重置=true,
				玩家id=0,
				队伍组={},
				名称=名称[n],
				模型="地狱战神",
				x=xy.x,
				y=xy.y,
				序列=n,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=124
			}
			table.insert(x待发送数据[地图], 地图处理类:批量添加单位(任务id))
		end
		for n, v in pairs(地图处理类.地图玩家[地图]) do
			if 地图处理类:取同一地图(地图,id,n,1)  then
				发送数据(玩家数据[n].连接id,1021,x待发送数据[地图])
			end
		end
		x待发送数据={}
	elseif 副本数据.乌鸡国.进行[id].进程==4 then
		副本数据.乌鸡国.进行[id].数量=0
		local 地图=6002
		local x待发送数据 = {[地图]={}}
		for n=1,数量 do
			local 任务id=id.."_125_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"..n
			local xy=地图处理类.地图坐标[地图]:取随机点()
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				销毁=true,
				副本重置=true,
				玩家id=0,
				队伍组={},
				名称="鬼祟小怪",
				模型="兔子怪",
				x=xy.x,
				y=xy.y,
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=125
			}
			table.insert(x待发送数据[地图], 地图处理类:批量添加单位(任务id))
		end
		for n, v in pairs(地图处理类.地图玩家[地图]) do
			if 地图处理类:取同一地图(地图,id,n,1)  then
				发送数据(玩家数据[n].连接id,1021,x待发送数据[地图])
			end
		end
		x待发送数据={}
	elseif 副本数据.乌鸡国.进行[id].进程==5 then
		副本数据.乌鸡国.进行[id].数量=2
		local 地图=6002
		local x待发送数据 = {[地图]={}}
		local xy={{x=50,y=47},{x=59,y=42}}
		local 方向={{2},{1}}
		local 真假={false,false}
		真假[取随机数(1,2)]=true
		for n=1,2 do
			local 任务id=id.."_126_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_1_"..n
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3600,
				销毁=true,
				副本重置=true,
				玩家id=0,
				队伍组={},
				名称="乌鸡国王",
				模型="文伯",
				x=xy[n].x,
				y=xy[n].y,
				真假=真假[n],
				副本id=id,
				地图编号=地图,
				地图名称=取地图名称(地图),
				类型=126
			}
			table.insert(x待发送数据[地图], 地图处理类:批量添加单位(任务id))
		end
		for n, v in pairs(地图处理类.地图玩家[地图]) do
			if 地图处理类:取同一地图(地图,id,n,1)  then
				发送数据(玩家数据[n].连接id,1021,x待发送数据[地图])
			end
		end
		x待发送数据={}
	end
end

function 胜利MOB_100028(id组,战斗类型,任务id)--副本芭蕉妖怪 --第一个怪
	local 副本id=任务数据[任务id].副本id
	任务处理类:删除单位(任务id)
	副本数据.乌鸡国.进行[副本id].数量=副本数据.乌鸡国.进行[副本id].数量+1
	刷新队伍任务追踪(id组[1])
	if 副本数据.乌鸡国.进行[副本id].数量>=15 then
		副本数据.乌鸡国.进行[副本id].进程=2
		刷新任务121(副本id)
		刷新队伍任务追踪(id组[1])
	end
    local 链接
	for n=1,#id组 do
		local cyid=id组[n]
		local 等级=玩家数据[cyid].角色.等级
		local 经验=等级*取随机数(1350,1550)
		local 银子=等级*取随机数(100,120)+10000
		玩家数据[cyid].角色:添加经验(经验,"初出江湖")
		玩家数据[cyid].角色:添加银子(银子,"初出江湖",1)
		if 取随机数()<=20 then
			local 奖励参数=取随机数(1,100)
			链接={提示=format("#S(乌鸡国副本)#Y乌鸡国的妖怪被#G/%s#Y打的抱头鼠窜，慌乱中遗落一个",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y。"}
            if 奖励参数<=10 then
				local 名称=取随机玄灵珠()
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			 elseif 奖励参数<=15 then
			 	local 名称="超级金柳露"
			 	玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			 elseif 奖励参数<=16 then
			 	local 名称="召唤兽内丹"
			 	玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
			 elseif 奖励参数<=30 then
			 	local 名称="魔兽要诀"
			 	玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			 elseif 奖励参数<=35 then
			 	local 名称="五宝盒"
			 	玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			 elseif 奖励参数<=50 then
			 	local 名称=取强化石()
			 	玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			 elseif 奖励参数<=55 then
			 	local 名称="九转金丹"
			 	玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(10,15),nil,链接)
			 elseif 奖励参数<=60 then
			 	local 名称=取宝石()
			 	玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			elseif 奖励参数<=90 then
				local 名称=取宝宝装备()
				local lv = math.min(qz(等级/10),13)
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
			end
		end
	end
end

function 失败MOB100028(id组,失败id,是否逃跑,战斗数据)--副本芭蕉妖怪
	for i=1,#id组 do
		战斗数据:扣除经验(id组[i],0.085)
		战斗数据:扣除银子(id组[i],0.075)
	end
end

function 胜利MOB_100029(id组,战斗类型,任务id)--三妖信息 2
	local 副本id=任务数据[任务id].副本id
	副本数据.乌鸡国.进行[副本id].序列[任务数据[任务id].序列]=true
	任务处理类:删除单位(任务id)
	local 通过=0
	for n=1,3 do
		if  副本数据.乌鸡国.进行[副本id].序列[n] then 通过=通过+1 end
	end
	local id=id组[1]
	刷新队伍任务追踪(id)
	if 通过>=3 then
		副本数据.乌鸡国.进行[副本id].进程=4
		刷新任务121(副本id)
		刷新队伍任务追踪(id)
	end
	local 链接
	for n=1,#id组 do
		local cyid=id组[n]
		local 等级=玩家数据[cyid].角色.等级
		local 经验=等级*取随机数(1350,1550)
		local 银子=等级*取随机数(100,120)+15000
		玩家数据[cyid].角色:添加经验(经验,"初出江湖")
		玩家数据[cyid].角色:添加银子(银子,"初出江湖",1)
		if 取随机数()<=25 then
			local 奖励参数=取随机数(1,100)
			链接={提示=format("#S(乌鸡国副本)#Y乌鸡国的妖怪被#G/%s#Y打的抱头鼠窜，慌乱中遗落一个",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y。"}
            if 奖励参数<=10 then
				local 名称="金柳露"
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			elseif 奖励参数<=15 then
				local 名称="超级金柳露"
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			elseif 奖励参数<=16 then
				local 名称="召唤兽内丹"
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
			elseif 奖励参数<=30 then
				local 名称="魔兽要诀"
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
			elseif 奖励参数<=35 then
				local 名称="五宝盒"
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			elseif 奖励参数<=50 then
				local 名称=取强化石()
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			elseif 奖励参数<=55 then
				local 名称="九转金丹"
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(10,15),nil,链接)
			elseif 奖励参数<=60 then
				local 名称=取宝石()
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			elseif 奖励参数<=63 then
				local 名称=取宝宝装备()
				local lv = math.min(qz(等级/10),13)
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
			elseif 奖励参数<=75 then
				local 名称="未激活的符石"
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,1),nil,链接)
			end
		end
	end
end

function 失败MOB100029(id组,失败id,是否逃跑,战斗数据)--战斗怪物取副本三妖信息
	for i=1,#id组 do
		战斗数据:扣除经验(id组[i],0.085)
		战斗数据:扣除银子(id组[i],0.075)
	end
end

function 胜利MOB_100030(id组,战斗类型,任务id)--战斗怪物取副本鬼祟小怪信息
	local 副本id=任务数据[任务id].副本id
	任务处理类:删除单位(任务id)
	副本数据.乌鸡国.进行[副本id].数量=副本数据.乌鸡国.进行[副本id].数量+1
	刷新队伍任务追踪(id组[1])
	local ggo=false
	if 副本数据.乌鸡国.进行[副本id].数量>=15 then
		副本数据.乌鸡国.进行[副本id].进程=5
		刷新任务121(副本id)
		刷新队伍任务追踪(id组[1])
		ggo=true
	end
	local 链接
	for n=1,#id组 do
		local cyid=id组[n]
		local 等级=玩家数据[cyid].角色.等级
		local 经验=等级*取随机数(1350,1550)
		local 银子=等级*取随机数(100,120)+15000
		玩家数据[cyid].角色:添加经验(经验,"初出江湖")
		玩家数据[cyid].角色:添加银子(银子,"初出江湖",1)
		if ggo and 取随机数()<=20 then
			local 奖励参数=取随机数(1,100)
			链接={提示=format("#S(乌鸡国副本)#Y乌鸡国的妖怪被#G/%s#Y打的抱头鼠窜，慌乱中遗落一个",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y。"}
            if 奖励参数<=10 then
				local 名称="金柳露"
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			elseif 奖励参数<=15 then
				local 名称="超级金柳露"
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			elseif 奖励参数<=16 then
				local 名称="召唤兽内丹"
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
			elseif 奖励参数<=30 then
				local 名称="魔兽要诀"
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
			elseif 奖励参数<=35 then
				local 名称="五宝盒"
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			elseif 奖励参数<=50 then
				local 名称=取强化石()
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			elseif 奖励参数<=55 then
				local 名称="九转金丹"
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(10,15),nil,链接)
			elseif 奖励参数<=60 then
				local 名称=取宝石()
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
			elseif 奖励参数<=63 then
				local 名称=取宝宝装备()
				local lv = math.min(qz(等级/10),13)
				玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
			end
		end
	end
end

function 失败MOB100030(id组,失败id,是否逃跑,战斗数据)--战斗怪物取副本鬼祟小怪信息
	for i=1,#id组 do
		战斗数据:扣除经验(id组[i],0.085)
		战斗数据:扣除银子(id组[i],0.075)
	end
end

function 胜利MOB_100031(id组,战斗类型,任务id)--战斗怪物取副本国王信息
	local 副本id=任务数据[任务id].副本id
	if 任务数据[任务id].真假 then
		local 任务id1 = 玩家数据[id组[1]].角色:取任务(120)
		local stid=取随机数(1,#id组)
		stid=id组[stid]
		local 链接={提示=format("#S(乌鸡国副本)#R/%s#R很好的表现了自己的实力，乌鸡国王送他一个",玩家数据[stid].角色.名称),频道="xt",结尾="#R！#50"}
		玩家数据[stid].道具:给予超链接书铁(stid,{15,15},nil,链接)

		for n=1,#id组 do
			local cyid=id组[n]
			local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(2050,2250)
			local 银子=等级*取随机数(100,120)+100000
			玩家数据[cyid].角色:添加经验(经验,"初出江湖")
			玩家数据[cyid].角色:添加银子(银子,"初出江湖",1)
			玩家数据[cyid].角色:添加副本积分(200)
			玩家数据[cyid].角色:添加仙玉(500)
			玩家数据[cyid].角色:添加每日活跃度(cyid, 5)
			玩家数据[cyid].角色:取消任务(任务id1)
			副本数据.乌鸡国.完成[cyid]=true --这里是乌鸡国完成
			if 取随机数()<=30 then
				local 奖励参数=取随机数(1,100)
				链接={提示=format("#S(乌鸡国副本)#Y祝贺#G/%s#Y成功解救出乌鸡国王！喜获",玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个#41#Y！"}
	            if 奖励参数<=10 then
					local 名称="金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=17 then
					local 名称="超级金柳露"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=22 then
					local 名称="召唤兽内丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=30 then
					local 名称="魔兽要诀"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
				elseif 奖励参数<=35 then
					local 名称="五宝盒"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=50 then
					local 名称=取强化石()
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=60 then
					local 名称="九转金丹"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(10,15),nil,链接)
				elseif 奖励参数<=65 then
					local 名称=取宝石()
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				elseif 奖励参数<=75 then
					local 名称=取宝宝装备()
					local lv = math.min(qz(等级/10),13)
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,{lv+1,lv+2},nil,链接)
				elseif 奖励参数<=85 then
					local 名称="未激活的符石"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,1),nil,链接)
				else
				    if 取随机数()<=1 then
				        local 名称="神兜兜"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
				    end
				end
			end
		end
		任务处理类:删除单位(任务id)
	else
		任务处理类:删除单位(任务id)
	end
end

function 失败MOB100031(id组,失败id,是否逃跑,战斗数据)--战斗怪物取副本国王信息
	for i=1,#id组 do
		战斗数据:扣除经验(id组[i],0.085)
		战斗数据:扣除银子(id组[i],0.075)
	end
end

function 任务说明120(玩家id,任务id)
	local 说明 = {}
	local 副本id=任务数据[任务id].副本id
	if 副本数据.乌鸡国.进行[副本id]==nil then
		说明={"乌鸡国","#L您的副本已经完成"}
	else
		local 进程=副本数据.乌鸡国.进行[副本id].进程
		local 数量=副本数据.乌鸡国.进行[副本id].数量
		local 序列=副本数据.乌鸡国.进行[副本id].序列
		if 进程==1 then
			说明={"乌鸡国",format("#L降伏所有的木妖（完成：%s-15）。剩余时间%s分钟。",数量,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==2 then
			说明={"乌鸡国",format("#L寻求场景中所有仙人的帮战（完成：%s-15）。剩余时间%s分钟。",数量,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==3 then
			if 副本数据.乌鸡国.进行[副本id].分类 then
			    return {"乌鸡国",format("#L和".."#R/qqq|乌鸡国王*6001*临时npc*%s*%s/乌鸡国王".."#W对话去皇宫(剩余%s分钟)",115,71,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
			end
			说明={"乌鸡国",format("#L12回合之内消灭三处囚禁仙人的妖怪。(剩余%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==4 then
			说明={"乌鸡国",format("#L消灭15个鬼祟小怪，当前已完成#Y%s-15#W(剩余%s分钟)",数量,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		elseif 进程==5 then
			说明={"乌鸡国",format("#L寻找出真正的乌鸡国王，与真正的国王战斗胜利后本副本将自动结束(剩余%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
		end
	end
	return 说明
end

return 副本_乌鸡国