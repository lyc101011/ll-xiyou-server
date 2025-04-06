-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-08-08 01:12:15
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1122]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "现在做鬼的也不安分，老是有出去闲逛的，你能帮我抓他们回来吗？"
		local xx = {"好的 我帮你","取消 抓鬼任务","不，我没有空"}
		return {"男人_钟馗","钟馗",wb[sj(1,#wb)],xx}
	elseif 编号 == 3 then
		wb[1] = "要想人不知，除非己莫为。做坏事的人可是要下地狱的。"
		wb[2] = "地府有十八层地狱，关押那些生前做尽坏事的家伙。"
		wb[3] = "想要尝尝我这跟铁链子的威力么？"
		return {"马面","马面",wb[sj(1,#wb)]}
	elseif 编号 == 4 then
		wb[1] = "生是追梦人，死为追梦鬼。还记得当初的梦想么？"
		wb[2] = "地府有十八层地狱，关押那些前生坏事做尽的恶人。"
		return {"兔子怪","追梦鬼",wb[sj(1,#wb)]}
	elseif 编号 == 5 then
		wb[1] = "我送阁下回长安吧。"
		local xx = {"是的我要去","我还要逛逛"}
		return {"僵尸","地遁鬼",wb[sj(1,#wb)],xx}
	elseif 编号 == 2 then
		wb[1] = "相见不如怀念，怀念不如忘记。"
		wb[2] = "喝下孟婆汤，过了奈何桥，前生的事就再与你无缘。"
		wb[3] = "孟婆汤有甘、苦、辛、酸、咸五种口味，少侠想要哪一种？"
		wb[4] = "听说地藏菩萨在广招门徒，年轻人想不想去学些本领？"
		return {"女人_孟婆","孟婆",wb[sj(1,#wb)]}
	end
	return
end

__NPCdh222[1122 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 名称=="地遁鬼" then
		if 事件=="是的我要去" then
		  地图处理类:npc传送(数字id,1001,470,253)
		end
	elseif 名称=="钟馗" then
		if 事件=="好的 我帮你" then
		  设置任务8(数字id)
		elseif 事件=="取消 抓鬼任务" then
			local 队伍id=玩家数据[数字id].队伍
			local 任务id=玩家数据[数字id].角色:取任务(8)
			if 队伍id~=0 then
				for n=1,#队伍数据[队伍id].成员数据 do
					玩家数据[队伍数据[队伍id].成员数据[n]].角色:取消任务(任务id)
					玩家数据[队伍数据[队伍id].成员数据[n]].角色.捉鬼数据.次数=0
					常规提示(队伍数据[队伍id].成员数据[n],"#Y/已经取消任务,同时任务总数清零")
				end
			else
				玩家数据[数字id].角色:取消任务(任务id)
				玩家数据[数字id].角色.捉鬼数据.次数=0
				常规提示(数字id,"#Y/已经取消任务,同时任务总数清零")
			end
		end
	end
end

__NPCdh111[5958]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "现在做鬼的也不安分，老是有出去闲逛的，你能帮我抓他们回来吗？"
		local xx = {"开始线上自动抓鬼","了解自动抓鬼","我点错了"}
		return {"男人_钟馗","钟馗分身",wb[sj(1,#wb)],xx}
	end
	return
end

-- __NPCdh222[5958 ]=function (id,数字id,序号,内容)
-- 	local 事件=内容[1]
-- 	local 名称=内容[3]
-- 	if 事件=="开始线上自动抓鬼" then
-- 		if 玩家数据[数字id].队伍 == 0 then
-- 			常规提示(数字id,"#Y/还是先组队再来吧！")
-- 			return
-- 		end
-- 		if 取队伍任务(玩家数据[数字id].队伍,8) then
-- 			常规提示(数字id,"#Y/请先完成当前的抓鬼任务再来吧！")
-- 			return
-- 		end

-- 		if not 调试模式 and 玩家数据[数字id].角色.自动抓鬼.次数<=0 then
-- 			常规提示(数字id,"#Y/抱歉，你的自动抓鬼次数不足！")
-- 			return
-- 		end
-- 		战斗准备类:创建战斗(数字id,110077,数字id)
-- 	elseif 事件=="开始线下自动抓鬼" then
-- 		添加最后对话(数字id,"此功能开启后全队将自动下线，下线后不影响自动抓鬼收益，是否开启下线抓鬼模式？",{"开启线下抓鬼模式","我再想想"})
-- 	elseif 事件=="了解自动抓鬼" then
-- 		添加最后对话(数字id,"#G线上：#W开启后如果下线将不会再继续战斗；\n#G线下：#W开启后将自动下线，这个功能不会影响你抓鬼获得的奖励。")
-- 	end
-- end

-- function 胜利MOB_110077(胜利id,战斗数据,id组)  --自动抓鬼卡
-- 	玩家数据[id组[1]].角色.自动抓鬼.次数=玩家数据[id组[1]].角色.自动抓鬼.次数-1
-- 	local cs=玩家数据[id组[1]].角色.自动抓鬼.次数
-- 	for i=1,#id组 do
-- 		local id=id组[i]
-- 		local 等级=取队伍平均等级(玩家数据[id].队伍,id)
-- 		local 经验=1000000
-- 		local 银子=200000
-- 		玩家数据[id].角色:添加经验(经验*HDPZ["自动抓鬼"].经验,"捉鬼")
-- 	--	玩家数据[id].角色:添加银子(银子*HDPZ["自动抓鬼"].银子,"捉鬼",1)
-- 		玩家数据[id].角色:添加储备(银子*HDPZ["自动抓鬼"].银子,"捉鬼",1)
-- 		local 奖励参数=取随机数()
-- 		if cs/10==math.ceil(cs/10) then
-- 			if 取随机数()<=HDPZ["自动抓鬼"].爆率 then
-- 				local 链接 = {提示=format("#P(轮回幻境)#W玩家#Y%s#W帮助钟馗追击鬼魂有功，钟馗送出一个",玩家数据[id].角色.名称),频道="hd",结尾="#W作为奖励！#80"}
-- 		                    	local 名称,数量,参数=生成产出(产出物品计算(HDPZ["自动抓鬼"].ITEM),"自动抓鬼")
-- 		                    	if 数量== 9999 then --环
-- 		                    		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,名称,nil,nil,nil,链接)
-- 		                    	else
-- 		                    	    玩家数据[id].道具:给予超链接道具(id,名称,数量,参数,链接)
-- 		        end
-- 			end
-- 		end
-- 	end
-- 		if cs<=0 then
-- 			常规提示(id组[1],"你今日自动抓鬼次数已达上限")
-- 			return
-- 		else
-- 			常规提示(id组[1],"你今日自动抓鬼次数还剩#G"..cs.."#Y次")
-- 		end
-- 	战斗数据.连续战斗 = 110077
-- end