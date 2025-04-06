local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数
local 梦魇夜叉 = class()
数字转大写={}
数字转大写[1]="一"
数字转大写[2]="二"
数字转大写[3]="三"
数字转大写[4]="四"
数字转大写[5]="五"
数字转大写[6]="六"
数字转大写[7]="七"
数字转大写[8]="八"
数字转大写[9]="九"
数字转大写[10]="十"
数字转大写[11]="十一"
数字转大写[12]="十二"
数字转大写[13]="十三"
数字转大写[14]="十四"
数字转大写[15]="十五"

function 梦魇夜叉:开启(id)
	local 临时数量=取随机数(3,5)
	local 地图范围={1501,1092,1070,1193,1173,1146,1140,1208,1040,1226,1142}
	local 地图=地图范围[取随机数(1,#地图范围)]
	local 地图名称=取地图名称(地图)
	local 模型="夜罗刹"
	local 名称 ="梦魇夜叉"
	local 类型 = {"画魂","厉鬼","龙龟"}
	for n=1,临时数量 do
		local 任务id=id.."_19_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
		随机序列=随机序列+1
		xy=地图处理类.地图坐标[地图]:取随机点()
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			销毁=true,
			夜叉小怪=类型[math.random(#类型)],
			玩家id=0,
			名称=名称,
			模型=模型,
			变异=true,
			x=xy.x,
			y=xy.y,
			地图编号=地图,
			地图名称=地图名称,
			类型=19
		}
		地图处理类:添加单位(任务id)
	end
	广播消息({内容=format("#Y/%s#W/在抓鬼时触发了#S/梦魇夜叉#W/，一群梦魇夜叉正在#Y/%s#w/捣乱,各路英雄快去收服#46",玩家数据[id].角色.名称,取地图名称(地图)),频道="xt"})
	玩家数据[id].触发夜叉地图=地图
	添加最后对话(id,"受到你的惊吓，一群梦魇夜叉跑到#R"..地图名称.."#W祸害人间，是否前往驱逐它们？",{"好的，送我们过去","还是不去了吧"})
	return
end

__GWdh111[19]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
	对话数据.模型=任务数据[标识].模型
	对话数据.名称=任务数据[标识].名称
	if 任务数据[标识].zhandou==nil then
		对话数据.对话="悄悄地告诉你，其实我是从地狱里偷跑出来的#89"
		对话数据.选项={"让我看看你带了什么宝贝","我只是路过"}
	else
		对话数据.对话="我正在战斗中，请勿打扰。"
	end
	return 对话数据
end

__GWdh222[19]=function (连接id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 事件=="让我看看你带了什么宝贝" then
		if 任务数据[玩家数据[数字id].地图单位.标识].zhandou~=nil then 常规提示(数字id,"#Y/对方正在战斗中") return  end
		if 玩家数据[数字id].队伍==nil then
			常规提示(数字id,"#Y/请先组队！")
			return
		end
		战斗准备类:创建战斗(数字id+0,100135,玩家数据[数字id].地图单位.标识)
		任务数据[玩家数据[数字id].地图单位.标识].zhandou=true
		玩家数据[数字id].地图单位=nil
		return
	end
end

function 梦魇夜叉:战斗胜利处理(id组,额外数据,任务id)
	if 任务数据[任务id]==nil then
		return
	end
	if 额外数据.类型 == "画魂" then --没有物品，只有经验和金币
		local 倍率=1
		if 额外数据.特殊奖励 then
		    倍率=2
		end
		for n=1,#id组 do
			local cyid=id组[n]
	    	local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(950,1050)*倍率
			local 银子=(等级*500+20000)*倍率
			玩家数据[cyid].角色:添加经验(经验,"梦魇夜叉",1)
			玩家数据[cyid].角色:添加银子(qz(银子),"梦魇夜叉",1)
		end
	elseif 额外数据.类型 == "厉鬼" then
		local 变异小怪 = {}
		if #额外数据.变异模型>=1 then
		    for i=1,#额外数据.变异模型 do
		    	变异小怪[#变异小怪+1]=额外数据.变异模型[i]
		    end
		end
		for n=1,#id组 do
			local cyid=id组[n]
	    	local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(950,1050)
			local 银子=等级*382+15000
			玩家数据[cyid].角色:添加经验(经验,"梦魇夜叉",1)
			玩家数据[cyid].角色:添加银子(qz(银子),"梦魇夜叉",1)
			if #变异小怪~=0 and 取随机数()<=35 then
				local 名称
				local sjs = 取随机数(1,#变异小怪)
				local 链接 = {提示=format("#S(梦魇夜叉)#G/%s#Y积极追捕梦魇夜叉，居然碰到了#G/变异%s#Y，在还没有来得及反应过来的时候，手里已经多了一个",玩家数据[cyid].角色.名称,变异小怪[sjs]),频道="xt",结尾="#Y！#80"}
				if 变异小怪[sjs]=="鬼将" then --80环
					玩家数据[cyid].道具:取随机装备(cyid,8)
					if 取随机数()<=50 then
					    名称="玲珑宝图"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
					end

				elseif 变异小怪[sjs]=="吸血鬼" then --60-70环3
					玩家数据[cyid].道具:取随机装备(cyid,取随机数(6,7))
					if 取随机数()<=50 then
					    名称="玲珑宝图"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
					end
				elseif 变异小怪[sjs]=="幽灵" then  --兽诀
					if 取随机数()<=80 then
					    名称="魔兽要诀"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
					else
						名称="高级魔兽要诀"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
					end
				elseif 变异小怪[sjs]=="夜罗刹" then --3-4宝石
					名称=取宝石()
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(3,4),nil,链接)
				elseif 变异小怪[sjs]=="炎魔神" then --3-5变身卡
					名称="怪物卡片"
					玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(3,8),nil,链接)
				end
			end
		end
	elseif 额外数据.类型 == "龙龟" then
		for n=1,#id组 do
			local cyid=id组[n]
	    	local 等级=玩家数据[cyid].角色.等级
			local 经验=等级*取随机数(950,1050)
			local 银子=等级*382+15000
			玩家数据[cyid].角色:添加经验(经验,"梦魇夜叉",1)
			玩家数据[cyid].角色:添加银子(qz(银子),"梦魇夜叉",1)
			if 额外数据.变异数量>0 then
				local 奖励参数=取随机数(1,100)
				local 名称
				local 链接 = {提示=format("#S(梦魇夜叉)#G/%s#Y积极追捕梦魇夜叉，居然能碰到了%s个变异的携宝龙龟，在还没有来得及反应过来的时候，手里已经多了一个",玩家数据[cyid].角色.名称,数字转大写[额外数据.变异数量]),频道="xt",结尾="#Y！#80"}
			    if 额外数据.变异数量==1 and 取随机数()<=28 then
				    if 奖励参数<=35 then
				        名称="金柳露"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
					elseif 奖励参数<=70 then
				        名称="超级金柳露"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
					else
				        名称=取宝石()
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(1,2),nil,链接)
				    end
			    elseif 额外数据.变异数量==2 and 取随机数()<=31 then
			    	玩家数据[cyid].道具:取随机装备(cyid,取随机数(6,7))
					if 取随机数()<=50 then
					    名称="玲珑宝图"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
					end
				elseif 额外数据.变异数量==3 and 取随机数()<=34 then
			    	玩家数据[cyid].道具:取随机装备(cyid,8)
					if 取随机数()<=50 then
					    名称="玲珑宝图"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
					end
				elseif 额外数据.变异数量==4 and 取随机数()<=40 then
					if 奖励参数<=35 then
				        名称="召唤兽内丹"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
					elseif 奖励参数<=70 then
				        名称="高级召唤兽内丹"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
					elseif 奖励参数<=72 then
						名称="神兜兜"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
					else
				        名称=取宝石()
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(3,4),nil,链接)
				    end
				elseif 额外数据.变异数量>=5 and 额外数据.变异数量<=7 and 取随机数()<=50 then
					if 奖励参数<=25 then
				        名称="召唤兽内丹"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
					elseif 奖励参数<=28 then
				        名称="高级魔兽要诀"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
					elseif 奖励参数<=40 then
						名称="怪物卡片"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(4,8),nil,链接)
					elseif 奖励参数<=70 then
				        名称="高级召唤兽内丹"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
					elseif 奖励参数<=74 then
						名称="神兜兜"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
					else
				        名称=取宝石()
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,4,nil,链接)
				    end
				elseif 额外数据.变异数量>=8 then
					if 奖励参数<=25 then
				        名称="召唤兽内丹"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
					elseif 奖励参数<=40 then
				        名称="高级魔兽要诀"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
					elseif 奖励参数<=60 then
						名称="怪物卡片"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,取随机数(6,8),nil,链接)
					elseif 奖励参数<=70 then
				        名称="高级召唤兽内丹"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,nil,nil,链接)
					elseif 奖励参数<=80 then
						名称="神兜兜"
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,1,nil,链接)
					else
				        名称=取宝石()
						玩家数据[cyid].道具:给予超链接道具(cyid,名称,5,nil,链接)
				    end
				end
			end
		end
	end
	地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
	任务数据[任务id]=nil
end

return 梦魇夜叉