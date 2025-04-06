-- @Author: baidwwy
-- @Date:   2024-10-15 01:51:56
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-10-18 00:57:39
local ffi = require("ffi")
local 数据数量 = ffi.new("int[1]")
local 线程发送数据 = {}
local asdwe = os.time()
local 定时器 = class()

function 定时器:初始化(v,循环文件)
	self.线程 = require("ggethread")(循环文件)
	self.线程.消息返回 = function(self,...)
		if ... == "取数量指针" then
		    return tonumber(ffi.cast("intptr_t",数据数量))
		elseif ... == "取数据" then
			return unpack(r)
		elseif ... == "循环更新" then
			for k,v in pairs(勾魂索名单) do
				if v.倒计时开始==false then
				    if 玩家数据[v.主动] and 玩家数据[v.被动] then --玩家在线的情况
				    	if 玩家数据[v.主动].zhandou==0 and 玩家数据[v.主动].zhandou==0 then
				    	    v.倒计时开始=true
				    	    -- 发送数据--倒计时 等客户端传回倒计时完成的信息，
				    	    local 主动队伍id = 玩家数据[v.主动].队伍
							if 主动队伍id ~= 0 then --进入队伍时也要判断
								for n=1,#队伍数据[主动队伍id].成员数据 do
									local 成员id=队伍数据[主动队伍id].成员数据[n]
									发送数据(玩家数据[成员id].连接id,3707)
								end
							else
								发送数据(玩家数据[v.主动].连接id,3707)
							end
				    	    local 被动队伍id = 玩家数据[v.被动].队伍
				    	    if 被动队伍id ~= 0 then
								for n=1,#队伍数据[被动队伍id].成员数据 do
									local 成员id=队伍数据[被动队伍id].成员数据[n]
									发送数据(玩家数据[成员id].连接id,3707)
								end
							else
								发送数据(玩家数据[v.被动].连接id,3707)
							end
				    	end
				    end
				else
				    if 玩家数据[v.主动] and 玩家数据[v.被动] then
						if v.战斗开始 and 玩家数据[v.主动].zhandou==0 and 玩家数据[v.被动].zhandou==0 then --确认或者是客户端传回倒计时结束信息
							v.战斗开始=false
							local 被动方队伍 = v.被动
					    	--创建战斗成功后，清空
					    	local 主动队伍id = 玩家数据[v.主动].队伍
							if 主动队伍id ~= 0 then --进入队伍时也要判断
								for n=1,#队伍数据[主动队伍id].成员数据 do
									local 成员id=队伍数据[主动队伍id].成员数据[n]
									玩家数据[成员id].勾魂索中=nil
									玩家数据[成员id].已扣除勾魂索=nil ---------------------------------------------------自己添加
									发送数据(玩家数据[成员id].连接id,3719)--勾魂索进入战斗后即可走路
								end
							else
								玩家数据[v.主动].勾魂索中=nil
								玩家数据[v.主动].已扣除勾魂索=nil----------------------------------------------------
								发送数据(玩家数据[v.主动].连接id,3719)--勾魂索进入战斗后即可走路
							end

				    	    local 被动队伍id = 玩家数据[v.被动].队伍
				    	    if 被动队伍id ~= 0 then
				    	    	被动方队伍=被动队伍id
								for n=1,#队伍数据[被动队伍id].成员数据 do
									local 成员id=队伍数据[被动队伍id].成员数据[n]
									玩家数据[成员id].勾魂索中=nil
									玩家数据[成员id].已扣除勾魂索=nil--------------------------------------------------
									发送数据(玩家数据[成员id].连接id,3719)--勾魂索进入战斗后即可走路
								end
							else
								玩家数据[v.被动].勾魂索中=nil
								玩家数据[v.被动].已扣除勾魂索=nil------------------------------------------------
								发送数据(玩家数据[v.被动].连接id,3719)--勾魂索进入战斗后即可走路
							end
                            战斗准备类:创建玩家战斗(v.主动, 200005, 被动方队伍, 1001)
					    	table.remove(勾魂索名单, k)
						end
					else
				    	--不在线的情况 上线后扣除勾魂索
				    	if 玩家数据[v.主动] then
				    		玩家数据[v.主动].勾魂索中=nil
				    		玩家数据[v.主动].已扣除勾魂索=nil-------------------------------------
				    	    local 主动队伍id = 玩家数据[v.主动].队伍
							if 主动队伍id ~= 0 then --进入队伍时也要判断
								for n=1,#队伍数据[主动队伍id].成员数据 do
									local 成员id=队伍数据[主动队伍id].成员数据[n]
									玩家数据[成员id].勾魂索中=nil
									玩家数据[成员id].已扣除勾魂索=nil----------------------------------------------
									发送数据(玩家数据[成员id].连接id,3709)
									-- 玩家数据[成员id].道具:给予道具(成员id,"无常勾魂索")
								end
							else
								发送数据(玩家数据[v.主动].连接id,3709)
								-- 玩家数据[v.主动].道具:给予道具(v.主动,"无常勾魂索")
							end
				    	end
				    	if 玩家数据[v.被动] then
				    		玩家数据[v.被动].勾魂索中=nil
				    		玩家数据[v.被动].已扣除勾魂索=nil--------------------------------------------
				    	    local 被动队伍id = 玩家数据[v.被动].队伍
				    	    if 被动队伍id ~= 0 then
								for n=1,#队伍数据[被动队伍id].成员数据 do
									local 成员id=队伍数据[被动队伍id].成员数据[n]
									玩家数据[成员id].勾魂索中=nil
									玩家数据[成员id].已扣除勾魂索=nil---------------------------------------------
									发送数据(玩家数据[成员id].连接id,3709)
								end
							else
								发送数据(玩家数据[v.被动].连接id,3709)
							end
				    	end
				    	table.remove(勾魂索名单, k) --删除勾魂信息
					end
				end
			end

			for k,v in pairs(天罚名单) do
				if 玩家数据[v.ID] and 玩家数据[v.ID].zhandou==0 and 取随机数(1,1000)<3 then
					if 玩家数据[v.ID].队伍 ~= 0 then
						队伍处理类:退出队伍(v.ID)
					end
					战斗准备类:创建战斗(v.ID, 111112)--执法天兵
					table.remove(天罚名单, k)
				end
			end
			for k,v in pairs(坐牢名单) do
				if 玩家数据[v.ID] and 玩家数据[v.ID].坐牢中 and os.time() - v.时间>1800 then --30分钟
					玩家数据[v.ID].坐牢中=nil
					玩家数据[v.ID].角色:出狱处理()
					table.remove(坐牢名单, k)
				end
			end

		else
			print("线程返回",...)
		end
	end
	self:启动(v)
end


function 定时器:启动(v)
	self.线程:启动(v)
	self.线程:置延迟(v)
end

function 定时器:发送(...)--这里是不定数据,如果是固定的,可以参考客户的多线程 纹理
	数据数量[0] = 数据数量[0]+1
	table.insert(线程发送数据,{...})
end

return 定时器