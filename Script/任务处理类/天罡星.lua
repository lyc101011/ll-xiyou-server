-- @Author: baidwwy
-- @Date:   2023-09-23 09:20:04
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-09-11 15:42:39
local 天罡星 = class()

function 天罡星:初始化()
	self.进度 = 1
end

function 天罡星:活动定时器()
	if 服务端参数.分钟=="30" and 服务端参数.秒+0==2 then
		for i=1,2 do
		self:刷新资源()
		自写活动:六星天罡()
		end
	end
end

function 天罡星:刷新资源()
    	local 任务id
	local 地图 = 1110
	local xy
	local 战斗名称
	local 名称
	local 武器数据
	local 模型
	local gw = {}
	for k,v in pairs(天罡星系统数据) do
		if v["刷新次序"] == self.进度 or v["刷新次序"] == math.fmod(self.进度,8)+1 then
			gw[#gw+1] = v
			gw[#gw]["名称"] = k
		end
	end
	for i=1,#gw do
		xy = 地图处理类.地图坐标[地图]:取随机点()
		任务id =取唯一任务(748)
		战斗名称 = gw[i]["名称"]
		名称 = gw[i]["名称"]
		武器数据 = gw[i]["武器数据"]
		模型 = gw[i]["造型"]
		锦衣 = gw[i]["锦衣数据"]
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3000,
			玩家id=0,
			名称=名称,
			战斗名称=战斗名称,
			模型=模型,
			等级=等级,
			难度= gw[i]["难度"],
			销毁=true,
			x=xy.x,
			y=xy.y,
			锦衣=gw[i]["锦衣数据"],
			地图编号=地图,
			地图名称=取地图名称(地图),
			类型=748
		}
		if 武器数据 ~= nil then
			任务数据[任务id]["武器"] = 武器数据["名称"]
			任务数据[任务id]["武器等级"] = 武器数据["等级"]
		end
		if Qu角色属性[模型]~= nil then
			任务数据[任务id]["门派"] = Qu角色属性[模型].门派[取随机数(1,#Qu角色属性[模型].门派)]
		else
			任务数据[任务id]["门派"] = "大唐官府"
		end
		地图处理类:添加单位(任务id)
	end
	广播消息({内容=format("神秘的#R天罡星#W带着天界宝物降临在了#Y大唐国境#W一带，只有智勇双全的强者才有机缘获得宝物，少侠敢来挑战么？#80",dtmc),频道="xt"})
	self.进度 = math.fmod(math.fmod(self.进度,8)+1,8)+1
end

function 天罡星:怪物对话内容(id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	if 任务数据[标识].zhandou==nil then
		对话数据.对话="我乃"..对话数据.名称.."的幻影#Y（#G"..任务数据[标识].难度.."#Y星）#W，少侠可愿与我一战？"
		对话数据.选项={"战就战，谁怕谁","我先准备一下吧"}
	else
		对话数据.对话="我正在战斗中，请勿打扰。"
	end
	return 对话数据
end

function 天罡星:对话事件处理(id,名称,事件,类型,rwid)
	if 任务数据[rwid].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
	if 玩家数据[id].队伍==0 then  常规提示(id,"#Y/你必须组队才能挑战我！") return  end
	if 取队伍人数(id)<5 and 调试模式==false then 常规提示(id,"#Y挑战天罡星最少必须由五人进行") return  end
	if 取等级要求(id,60)==false and 调试模式==false then 常规提示(id,"#Y/队伍中有成员等级不符合要求") return  end
	if 事件=="战就战，谁怕谁" then
	    	战斗准备类:创建战斗(id,111127,rwid)
	        任务数据[rwid].zhandou=true
	end
end

function 天罡星:战斗胜利处理(id组,战斗类型,任务id)
	local id=id组[1]
	if 任务数据[任务id]==nil then
		return
	end
	local 难度=任务数据[任务id].难度
	local gl = 30
	if 难度==3 or 难度==4 then
	    gl=60
    	elseif 难度==5 then
	    gl=80
    	-- elseif 难度>=6 then
	    -- gl=100
	end
	for n=1,#id组 do
	    local cyid=id组[n]
		local 等级=玩家数据[cyid].角色.等级
		local 经验=等级*取随机数(5000,6000)+难度*300000
		local 银子=等级*2000+难度*180000
		玩家数据[cyid].角色:添加经验(经验*HDPZ["天罡：星级1"].经验,"天罡星",1)
		玩家数据[cyid].角色:添加银子(银子*HDPZ["天罡：星级1"].银子,"天罡星",1)
		玩家数据[cyid].角色:添加每日活跃度(cyid, 1)

		    if 难度==1 then
            if 取随机数()<=HDPZ["天罡：星级1"].爆率 then
				 local 链接 = {提示=format("#S(天罡星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#24"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["天罡：星级1"].ITEM),"天罡：星级1")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end

		    elseif 难度==2 then
            if 取随机数()<=HDPZ["天罡：星级2"].爆率 then
				 local 链接 = {提示=format("#S(天罡星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#80"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["天罡：星级2"].ITEM),"天罡：星级2")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		    elseif 难度==3 then
            if 取随机数()<=HDPZ["天罡：星级3"].爆率 then
				 local 链接 = {提示=format("#S(天罡星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#80"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["天罡：星级3"].ITEM),"天罡：星级3")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		    elseif 难度==4 then
            if 取随机数()<=HDPZ["天罡：星级4"].爆率 then
				 local 链接 = {提示=format("#S(天罡星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#80"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["天罡：星级4"].ITEM),"天罡：星级4")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		    elseif 难度==5 then
            if 取随机数()<=HDPZ["天罡：星级5"].爆率 then
				 local 链接 = {提示=format("#S(天罡星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#80"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["天罡：星级5"].ITEM),"天罡：星级5")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		 --    elseif 难度==6 then
   --          if 取随机数()<=HDPZ["天罡：星级5"].爆率 then
			-- 	 local 链接 = {提示=format("#S(天罡星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#80"}
			-- 	local 名称,数量,参数=生成产出(产出物品计算(HDPZ["天罡：星级5"].ITEM),"天罡：星级5")
			-- 	if 数量== 9999 then --环
			-- 		玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
			-- 	else
			-- 		玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
			-- 	end
			-- end
		 --    elseif 难度==7 then
   --          if 取随机数()<=HDPZ["天罡：星级5"].爆率 then
			-- 	 local 链接 = {提示=format("#S(天罡星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#80"}
			-- 	local 名称,数量,参数=生成产出(产出物品计算(HDPZ["天罡：星级5"].ITEM),"天罡：星级5")
			-- 	if 数量== 9999 then --环
			-- 		玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
			-- 	else
			-- 		玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
			-- end
		--end
	end
end

	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
end

return 天罡星