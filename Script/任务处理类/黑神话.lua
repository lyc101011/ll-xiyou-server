-- @Author: baidwwy
-- @Date:   2024-09-11 15:36:08
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-09-12 23:12:00
local 黑神话 = class()

function 黑神话:初始化()
	self.已刷time=0
	self.锦衣={"青花瓷","花间梦","鹿角弯弯","从军行","水云归","飞天舞","羽仙歌"}
end

function 黑神话:活动定时器()
	if 服务端参数.分钟+0==9 and os.time() - self.已刷time >= 0 then
		self.已刷time = os.time() + 99 --秒防重复刷
		self:刷出怪物()
	end
end

function 黑神话:刷出怪物()
	local 已刷图 = {}
	local 地图组 = {1142,1138,1198,1002,1135,1144,1139,1131,1512,1122,1140,1111,1150,1146,1116}
	local 星刷数 = {[1]=5,[2]=5,[3]=5,[4]=3,[5]=3,[6]=3,[7]=1,[8]=1,[9]=1}
	local 名称组 = {"黑神话☆","黑神话☆☆","黑神话☆☆☆","黑神话☆☆☆☆","黑神话☆☆☆☆☆","黑神话☆☆☆☆☆☆","黑神话☆☆☆☆☆☆☆","黑神话☆☆☆☆☆☆☆☆","黑神话☆☆☆☆☆☆☆☆☆"} --1到9星名称
	for an=1,9 do
		for bn=1,星刷数[an] do
			local 地图 = 地图组[取随机数(1,#地图组)]
			local 地图名称 = 取地图名称(地图)
			已刷图[地图] = 地图名称
			local xy = 地图处理类.地图坐标[地图]:取随机点()
			任务id =取唯一任务(3490)
			任务数据[任务id]={
				id=任务id,
				起始=os.time(),
				结束=3000,
				玩家id=0,
				显示饰品=true,
				名称=名称组[an],
				模型="进阶毗舍童子",
				难度=an,
				销毁=true,
				x=xy.x,
				y=xy.y,
				地图编号=地图,
				地图名称=地图名称,
				类型=3490
			}
	        地图处理类:添加单位(任务id)
		end
	end
	local tsdt = ""
	for k,v in pairs(已刷图) do
		tsdt = tsdt .. v .."、"
	end
	广播消息({内容=format("传闻中灭杀三界的#Y/黑神话#W/又现身于#G/" ..tsdt .."#W/请本服最强的英雄去与之一战，名动三界！#24",dtmc),频道="xt"})
end

function 黑神话:怪物对话内容(id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	对话数据.难度=任务数据[标识].难度
	if 任务数据[标识].zhandou==nil then
		对话数据.对话="我乃#Y/" ..对话数据.难度 .."星#W/黑神话，少侠可敢与我一战？"
		对话数据.选项={"挑战极限","我绕着走"}
	else
		对话数据.对话="我正在战斗中，请勿打扰。"
	end
	return 对话数据
end

function 黑神话:对话事件处理(id,名称,事件,类型,rwid)
	if 任务数据[rwid].zhandou~=nil then 常规提示(id,"#Y/对方正在战斗中") return  end
	if 玩家数据[id].队伍==0 then  常规提示(id,"#Y/你必须组队才能挑战我！") return  end
	if 取队伍人数(id)<5 and 调试模式==false then 常规提示(id,"#Y挑战我最少必须由五人进行") return  end
	if 取等级要求(id,60)==false and 调试模式==false then 常规提示(id,"#Y/队伍中有成员等级不符合要求") return  end
	if 事件=="挑战极限" then
    	战斗准备类:创建战斗(id,160002,rwid)
        任务数据[rwid].zhandou=true
	end
end

function 黑神话:战斗胜利处理(id组,战斗类型,任务id)
	local id=id组[1]
	if 任务数据[任务id]==nil then
		return
	end
	for n=1,#id组 do
	    local cyid=id组[n]
		local 等级=玩家数据[cyid].角色.等级
		local 经验=等级*取随机数(5000,5500)+难度*300000
		local 银子=等级*2000+难度*180000
		玩家数据[cyid].角色:添加经验(经验*HDPZ["黑神话：星级1"].经验,"黑神话",1)
		玩家数据[cyid].角色:添加银子(银子*HDPZ["黑神话：星级1"].银子,"黑山话",1)
		玩家数据[cyid].角色:添加每日活跃度(cyid, 10)
		if 难度==1 then
			if 取随机数()<=HDPZ["黑神话：星级1"].爆率 then
				local 链接 = {提示=format("#S(黑神话1星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#24"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["黑神话：星级1"].ITEM),"黑神话：星级1")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		elseif 难度==2 then
			if 取随机数()<=HDPZ["黑神话：星级2"].爆率 then
				local 链接 = {提示=format("#S(黑神话2星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#24"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["黑神话：星级2"].ITEM),"黑神话：星级2")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		elseif 难度==3 then
			if 取随机数()<=HDPZ["黑神话：星级3"].爆率 then
				local 链接 = {提示=format("#S(黑神话3星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#24"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["黑神话：星级3"].ITEM),"黑神话：星级3")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		elseif 难度==4 then
			if 取随机数()<=HDPZ["黑神话：星级4"].爆率 then
				local 链接 = {提示=format("#S(黑神话4星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#24"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["黑神话：星级4"].ITEM),"黑神话：星级4")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		elseif 难度==5 then
			if 取随机数()<=HDPZ["黑神话：星级5"].爆率 then
				local 链接 = {提示=format("#S(黑神话5星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#24"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["黑神话：星级5"].ITEM),"黑神话：星级5")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		elseif 难度==6 then
			if 取随机数()<=HDPZ["黑神话：星级6"].爆率 then
				local 链接 = {提示=format("#S(黑神话6星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#24"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["黑神话：星级6"].ITEM),"黑神话：星级6")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		elseif 难度==7 then
			if 取随机数()<=HDPZ["黑神话：星级7"].爆率 then
				local 链接 = {提示=format("#S(黑神话7星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#24"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["黑神话：星级1"].ITEM),"黑神话：星级7")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		elseif 难度==8 then
			if 取随机数()<=HDPZ["黑神话：星级8"].爆率 then
				local 链接 = {提示=format("#S(黑神话8星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#24"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["黑神话：星级9"].ITEM),"黑神话：星级8")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		elseif 难度==9 then
			if 取随机数()<=HDPZ["黑神话：星级9"].爆率 then
				local 链接 = {提示=format("#S(黑神话9星)#Y/%s对#G%s#Y的武艺深表佩服，特送上一个珍藏很久的",任务数据[任务id].名称,玩家数据[cyid].角色.名称),频道="xt",结尾="#Y一个。#24"}
				local 名称,数量,参数=生成产出(产出物品计算(HDPZ["黑神话：星级9"].ITEM),"黑神话：星级9")
				if 数量== 9999 then --环
					玩家数据[cyid].道具:给予道具(cyid,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
				else
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,数量,参数,链接)
				end
			end
		end
	end
end

return 黑神话