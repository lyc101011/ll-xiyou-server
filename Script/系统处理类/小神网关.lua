-- @Author: baidwwy
-- @Date:   2024-10-20 02:54:08
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-10 08:32:58
local 小神网关 = class()
local 书铁范围 = {"枪矛","斧钺","剑","双短剑","飘带","爪刺","扇","魔棒","锤","鞭","环圈","刀","法杖","弓弩","宝珠","巨剑","伞","灯笼","头盔","发钗","项链","女衣","男衣","腰带","鞋子"}
local 高级内丹 ={ "神机步","腾挪劲","玄武躯","龙胄铠","玉砥柱","碎甲刃","阴阳护","凛冽气","舍身击","电魂闪","通灵法","双星爆","催心浪","隐匿击","生死决","血债偿"}
local 普通内丹 = {"迅敏","狂怒","阴伤","静岳","擅咒","灵身","矫健","深思","钢化","坚甲","慧心","撞击","无畏","愤恨","淬毒","狙刺","连环","圣洁","灵光"}
function 小神网关:初始化()
end

local function 星期转数字(xq)
	if xq=="周一" then
		return 1
	elseif xq=="周二" then
		return 2
	elseif xq=="周三" then
		return 3
	elseif xq=="周四" then
		return 4
	elseif xq=="周五" then
		return 5
	elseif xq=="周六" then
		return 6
	elseif xq=="周日" then
		return 0
	end
	return xq
end

function 小神网关:验证管理员身份(管理id)
	if 玩家数据[管理id].ip ==连接ip  then
		return true
	end
	return false
end
function 小神网关:GM自定义物品(data)
  if data[1] == "全服" then

    -- for k, v in pairs(玩家数据) do
    --   for i = 3, 6 do
    --     if data[i] == "" then
    --       data[i] = nil
    --     elseif i == 3 or i == 5 or i == 6 then
    --       data[i] = tonumber(data[i])
    --     end
    --   end
    --   if not v.假人 and v.角色.等级 > 68 then
    --     ItemControl:GiveItem(k, data[2], data[3], data[4], data[5], data[6])
    --   end
    --   广播消息(9,
    --     "#xt/#g/ " .. v.角色.名称 ..
    --     "#y/获得了游戏管理员赠送的红包，打开一看竟是#r/" ..
    --     data[2] .. "。#S/玩家热情不断,GM福利嗨翻天" .. "#" .. math.random(110))
    -- end
    发送网关消息(string.format("全服69级以上玩家发送%s成功", data[2]))
  else
    if 玩家数据[ data[1] ] == nil then
	      发送网关消息(string.format("[%d]角色不存在或未上线", data[1]))
	       elseif not data[2] then
	         发送网关消息(string.format("[%d]物品数据未定义", data[1]))-----------如果出现这个提示，就该找问题了
	    else


	    for i = 3, 6 do
	        if data[i] == "" then
	          data[i] = 1
	        elseif i == 3 or i == 4 or i == 5 then
	          data[i] = tonumber(data[i])
	        end
	      end

			local 输入ID=data[1]
			local 名称=data[2]
			local 数量=data[3]
			local 等级=data[4]
			local 专用=data[5]
			local 技能=data[6]
			-- print(名称,数量,等级,专用)
			if 专用+0==2 then
				专用=true
			else
				专用=nil
			end
			-- function 道具处理类:给予道具(id,名称,数量,参数,附加,专用,数据,消费,消费方式,消费内容,超链接)
			-- local 可叠加=false
			if 名称=="鬼谷子" then
				玩家数据[输入ID].道具:给予道具(输入ID,名称,nil,data[6])
			elseif 名称=="制造指南书" then
				for i=1,#书铁范围 do
					if 技能==书铁范围[i] then
						技能=i
						break
					end
				end
				玩家数据[输入ID].道具:给予道具(输入ID,名称,等级+0,技能,nil,专用)
 			发送网关消息("技能应为：枪矛、斧钺、剑、双短剑、飘带、爪刺、扇、魔棒、锤、鞭、环圈、刀、法杖、弓弩、宝珠、巨剑、伞、灯笼、头盔、发钗、项链、女衣、男衣、腰带、鞋子")

			elseif 名称=="百炼精铁" then
				玩家数据[输入ID].道具:给予道具(输入ID,名称,等级+0)
			elseif 名称=="元灵晶石" then
				等级=qz(等级/10)
				玩家数据[输入ID].道具:给予道具(输入ID,名称,{等级+0,等级+0})
			elseif 名称=="钨金" then
				玩家数据[输入ID].道具:给予道具(输入ID,名称,数量+0,等级+0,nil,专用)
			elseif 名称=="召唤兽内丹" or 名称=="高级召唤兽内丹" then
				if 名称=="高级召唤兽内丹" then
					for i=1,#高级内丹 do
						if 技能==高级内丹[i] then
							break
						end
					end
				else
					for i=1,#普通内丹 do
						if 技能==普通内丹[i] then
							break
						end
					end
				end

				玩家数据[输入ID].道具:给予道具(输入ID,名称,nil,技能,nil,专用)
				-- 发送网关消息("高级内丹：神机步,腾挪劲,玄武躯,龙胄铠,玉砥柱,碎甲刃,阴阳护,凛冽气,舍身击,电魂闪,通灵法,双星爆,催心浪,隐匿击,生死决,血债偿\n低级内丹：迅敏,狂怒,阴伤,静岳,擅咒,灵身,矫健,深思,钢化,坚甲,慧心,撞击,无畏,愤恨,淬毒,狙刺,连环,圣洁,灵光")
			elseif 名称=="灵犀玉" then
				玩家数据[输入ID].道具:给予道具(输入ID,名称,nil,数量,nil,专用)
			elseif 名称=="灵饰指南书" then
				玩家数据[输入ID].道具:给予道具(输入ID,名称,{等级/10,等级/10},技能,专用)
			elseif 名称=="魔兽要诀" or 名称=="高级魔兽要诀" then
				玩家数据[输入ID].道具:给予道具(输入ID,名称,nil,技能,nil,专用)
			elseif 名称=="九转金丹" then
				if 等级+0>1500 then
					发送网关消息("该物品等级应不超过1500")
					return
				end
				for i=1,数量 do
					玩家数据[输入ID].道具:给予道具(输入ID,名称,等级+0,nil,nil,专用)
				end
			elseif 名称=="上古锻造图策" or 名称=="炼妖石" then
				if 等级/10~=qz(等级/10) then
					发送网关消息("该物品等级应设置为：书铁等级+5，例：65级应设置为70")
					return
				end
				等级=qz(等级/10)
				玩家数据[输入ID].道具:给予道具(输入ID,名称,{等级,等级},nil,nil,专用)
			elseif 名称=="怪物卡片" or 名称=="点化石" then
				发送网关消息("该物品暂时不能发放")
				return
			elseif 名称=="红玛瑙" or 名称=="太阳石" or 名称=="舍利子" or 名称=="黑宝石" or 名称=="月亮石" or 名称=="光芒石" or 名称=="精魄灵石" or 名称=="星辉石" then
				if 数量~="number" then
					发送网关消息("该物品数量应设置为：给予数量")
					return
				end
				if 等级~="number" then
					发送网关消息("该物品等级应设置为：宝石等级")
					return
				end
				for i=1,数量 do
					玩家数据[输入ID].道具:给予道具(输入ID,名称,等级+0,nil,nil,专用)
				end
			else
				玩家数据[输入ID].道具:给予道具(输入ID,名称,数量+0,等级+0,专用)
				发送网关消息(string.format("发送%s成功",名称))
			end
	end
 end
end
function 小神网关:数据处理(序号,内容)
  管理日志 = ReadFile("管理日志.txt")
  管理日志 = 管理日志 .. "\n" .. os.date("[%Y年%m月%d日%X]:") .. 内容
  WriteFile("管理日志.txt", 管理日志)
		if 序号 ==190909219 then
			self:GM自定义物品(table.loadstring(内容))
		elseif 序号 ==190909220 then
			self:发送货币(table.loadstring(内容))
		elseif 序号 ==190909221 then
			self:发送称谓(table.loadstring(内容))
		elseif 序号 ==190909222 then
			self:定制召唤兽(table.loadstring(内容))
		elseif 序号 ==190909223 then
			self:定制装备(table.loadstring(内容))
		elseif 序号 ==190909224 then
			self:定制灵饰(table.loadstring(内容))
		elseif 序号 ==190909225 then
			self:定制BB装备(table.loadstring(内容))

		elseif 序号 ==190909226 then
			self:按钮代码(内容)
		-- elseif 序号 ==190909227 then
		-- 	self:全服经验倍率修改(table.loadstring(内容))


		elseif 序号 ==1231231002 then
			self:GM修改参数(table.loadstring(内容))
		elseif 序号 ==1231231000 then
			self:GM网关开关(内容)
		elseif 序号 ==1231231001 then
			self:GM玩家管理(table.loadstring(内容))
		elseif 序号 ==1231231008 then
			self:GM地图系统(table.loadstring(内容))
		elseif 序号 ==1231231009 then
			self:GM自定义刷新怪(内容)
		elseif 序号 ==1231231011 then
			self:GM转发消息(table.loadstring(内容))
		elseif 序号 ==1231231012 then
			self:CDK兑换(table.loadstring(内容))





		end
end

function 小神网关:GM自定义刷新怪(data)
	if  data=="巡山小妖" then
		投放怪:巡山小妖()
		发送网关消息(string.format("%s刷新成功",data))
		elseif data=="三打白骨精" then
			投放怪:三打白骨精()
			发送网关消息(string.format("%s刷新成功",data))
			elseif data=="真假美猴王" then
				投放怪:真假美猴王()
				发送网关消息(string.format("%s刷新成功",data))
				elseif data=="狮驼国" then
					投放怪:狮驼国()
					发送网关消息(string.format("%s刷新成功",data))
					elseif data=="二十八星宿" then
						二八星宿:刷新资源()
						发送网关消息(string.format("%s刷新成功",data))
						elseif data=="封妖" then
							设置任务101()--封妖
							发送网关消息(string.format("%s刷新成功",data))
								elseif data=="妖王" then
									设置任务205()--妖王
									发送网关消息(string.format("%s刷新成功",data))
									elseif data=="天罡星" then
										天罡星:刷新资源()
										发送网关消息(string.format("%s刷新成功",data))
										elseif data=="地煞星" then
											地煞星:刷新资源()
											发送网关消息(string.format("%s刷新成功",data))
	else
		发送网关消息(string.format("数据表未定义%s刷新怪任务",data))
	end
end


function id取账号(id)
    for n, v in pairs(玩家数据) do
        if 玩家数据[n].id ==id then
            return 玩家数据[n].账号
        end
    end

    return false
end
function id名称取账号(id)
    for n, v in pairs(玩家数据) do
        if 玩家数据[n].名称 ==id then
            return n
        end
    end

    return false
end
function 账号取id(账号)
    for n, v in pairs(玩家数据) do
        if 玩家数据[n].账号 == 账号 then
            return n
        end
    end

    return 0
end



function 小神网关:GM玩家管理(...)	---------------未完成
  local arg=...
  arg[1]=tonumber(   arg[1]  )
     if arg[2]=="解封(账号)" then
        if  f函数.文件是否存在(程序目录..[[data\]]..arg[1])~=true then
            发送网关消息(string.format("%s账号不存在(请确认输入的是账号而非id)",arg[1]))
        else
            f函数.写配置(程序目录..[[data\]]..arg[1]..[[\账号信息.txt]],"账号配置","封禁","0")
            发送网关消息(string.format("%s账号解封成功",arg[1]))
        end
      return
     end

     arg[1] =arg[1]+0
     if  玩家数据[arg[1]] == nil then
         发送网关消息(string.format("%d角色不存在或未上线",arg[1]))
    elseif arg[2]=="强制下线" then
                发送数据(玩家数据[arg[1]].连接id,998,"你已被管事GM强制下线")
                系统处理类:断开游戏(arg[1])
                玩家数据[arg[1]] = nil
                发送网关消息(string.format("%d退出了游戏",arg[1]))
    elseif arg[2]=="取ID账号" then
      -- 发送网关消息(string.format("%d角色账号为%s",arg[1],id取账号(arg[1])))
      发送网关消息(string.format("%d角色账号为%s",arg[1],玩家数据[arg[1]].账号   ))
    elseif arg[2]=="退出战斗" then
            if 玩家数据[arg[1]].zhandou == 0 then
                 发送网关消息(string.format("%d未处于战斗中",arg[1]))
            else
            	   战斗准备类.战斗盒子[玩家数据[arg[1]].zhandou]:强制结束战斗()
            	   常规提示(arg[1],"#Y/你已被管事GM强行拉出战斗！")
                发送网关消息(string.format("%d退出了战斗",arg[1]))
            end
    elseif arg[2]=="封禁账号" then
        f函数.写配置(程序目录..[[data\]]..玩家数据[arg[1]].账号..[[\账号信息.txt]],"账号配置","封禁","1")
        发送数据(玩家数据[arg[1]].连接id,998,"此账号已被封禁")
        系统处理类:断开游戏(arg[1])
        发送网关消息(string.format("%d封禁成功",arg[1]))
    elseif arg[2]=="网关封禁账号" then
        f函数.写配置(程序目录..[[data\]]..玩家数据[arg[1]].账号..[[\账号信息.txt]],"账号配置","封禁","1")
        发送数据(玩家数据[arg[1]].连接id,998,"此账号已被封禁2")
        系统处理类:断开游戏(arg[1])
        发送网关消息(string.format("%d因拦截封包封禁成功",arg[1]))
    elseif arg[2]=="清除摆摊" then
        -- 道具处理类:收摊处理(玩家数据[arg[1]].连接id, arg[1])
        	玩家数据[arg[1]].摊位数据=nil
	玩家数据[arg[1]].离线摆摊=nil
	发送数据(玩家数据[arg[1]].连接id,3518)
	地图处理类:取消玩家摊位(arg[1])
	常规提示(arg[1],"#Y/你被游戏管事取消了摆摊！")



    elseif arg[2]=="清空背包" then
        	玩家数据[arg[1]].道具:清空包裹(玩家数据[arg[1]].连接id,arg[1])
	常规提示(arg[1],"#Y/游戏管事已清空了您的背包")
        	发送网关消息(string.format("%d清除背包成功",arg[1]))

    elseif arg[2]=="限制喊话" then
        玩家数据[arg[1]].限制喊话=true
        发送网关消息(string.format("%d限制了喊话功能",arg[1]))
    elseif arg[2]=="解除限制喊话" then
        玩家数据[arg[1]].限制喊话=false
        发送网关消息(string.format("%d解除了限制了喊话功能",arg[1]))

    elseif arg[2]=="删除角色" then
        角色处理类:删除角色(arg[1])
       发送网关消息(string.format("%d角色删除成功",arg[1]))
    end
---------------------可能是在这里加,忘了----------------------------------------------------------
  --   elseif data =="随机仙玉(50-500)" then
  --    local 随机银子 = math.random(10, 50)
  --    for k,v in pairs(UserData) do
  --      if not v.假人  and v.角色.等级 >68 then
  --      RoleControl:添加仙玉(v,随机银子,"GM奖励")
  --      广播消息(9,"#xt/#g/ " .. v.角色.名称 .. "#y/获得了游戏管理员赠送的新年红包，打开一看竟是#r/" .. 随机银子 .. "#y/仙玉。#S/快喊上你的朋友一起来组队吧！玩家热情不断,GM福利嗨翻天".."#"..math.random(110))
  --    end
  --   end
  --   发送网关消息(string.format("发送全服%s成功",data))
  -- elseif data =="随机储备" then
  --    local 随机银子 = math.random(90000, 50000000)
  --    for k,v in pairs(UserData) do
  --      if not v.假人  and v.角色.等级 >68 then
  --      RoleControl:添加储备(v,随机银子,"GM奖励")
  --      广播消息(9,"#xt/#g/ " .. v.角色.名称 .. "#y/获得了游戏管理员赠送的新年红包，打开一看竟是#r/" .. 随机银子 .. "#y/储备金。#S/快喊上你的朋友一起来组队吧！玩家热情不断,GM福利嗨翻天".."#"..math.random(110))
  --    end
  --   end
  --    发送网关消息(string.format("发送全服%s成功",data))
  -- elseif data =="随机银子(50W-200W)" then
  --     local 随机银子 = math.random(500000, 2000000)
  --    for k,v in pairs(UserData) do
  --      if not v.假人  and v.角色.等级 >68 then
  --       RoleControl:添加银子(v,随机银子,"GM奖励")
  --      广播消息(9,"#xt/#g/ " .. v.角色.名称 .. "#y/获得了游戏管理员赠送的新年红包，打开一看竟是#r/" .. 随机银子 .. "#y/银子。#S/快喊上你的朋友一起来组队吧！玩家热情不断,GM福利嗨翻天".."#"..math.random(110))
  --    end
  --  end
  --   发送网关消息(string.format("发送全服%s成功",data))
  -- elseif data =="随机兽决" then
  --   for k,v in pairs(UserData) do
  --      if not v.假人  and v.角色.等级 >68 then
  --      ItemControl:GiveItem(k,"魔兽要诀")
  --      广播消息(9, "#xt/#g/ " .. v.角色.名称 .. "#y/获得了游戏管理员赠送的新年红包，打开一看竟是#g/魔兽要诀".."#"..math.random(110))
  --     end
  --   end
  --   发送网关消息(string.format("发送全服%s成功",data))
  -- elseif data =="随机高级兽决" then
  --    for k,v in pairs(UserData) do
  --     if not v.假人  and v.角色.等级 >68 then
  --       local 随机兽决 = 取垃圾兽诀名称()
  --       ItemControl:GiveItem(k,"高级魔兽要诀",nil,随机兽决)
  --      广播消息(9, "#xt/#g/ " .. v.角色.名称 .. "#y/获得了游戏管理员赠送的开服红包，打开一看竟是#g/"..随机兽决.."#"..math.random(110))
  --    end
  --  end
  --   发送网关消息(string.format("发送全服%s成功",data))
---------------------可能是在这里加,忘了----------------------------------------------------------
end



function 小神网关:GM修改参数(...)
    local num,text=unpack(...)
    if text =="调整经验" then
	f函数.写配置(程序目录.."配置文件.ini","主要配置","经验",num)
	服务端参数.经验获得率=f函数.读配置(程序目录.."配置文件.ini","主要配置","经验")+0
	发送网关消息("当前服务端的经验获得率改为"..num)
	广播消息({内容="当前服务器的经验倍率为："..服务端参数.经验获得率,频道="xt"})
	发送公告("当前服务器的经验倍率为："..服务端参数.经验获得率);


    elseif text =="限制等级" then
    	f函数.写配置(程序目录.."配置文件.ini","主要配置","等级上限",num)
	QJDJSX=f函数.读配置(程序目录.."配置文件.ini","主要配置","等级上限")+0
	发送网关消息("当前服务端的限制等级改为"..num)
	广播消息({内容="当前服务器的限制等级为："..QJDJSX,频道="xt"})
	发送公告("当前服务器的限制等级为："..QJDJSX);

    elseif text =="调试开关" then
    	if 调试模式==false then
  	   调试模式=true
  	广播消息({内容="调试模式：true",频道="xt"})
  	else
  	    调试模式=false
  	广播消息({内容="调试模式：false",频道="xt"})
  	end


    end
end


function 小神网关:按钮代码(data)
	if data == "更新抽奖" then
		更新抽奖数据()
	end
end
function 小神网关:按钮代码(data)
	if data == "全局存档" then
		保存系统数据()
		发送网关消息("服务器数据保存成功")
	end
end
-- function 小神网关:全服经验倍率修改(data)
-- 		if data[2]=="调整经验" then
-- 		    服务端参数.经验获得率=data[1]+0
-- 		    广播消息({内容="#S(GM在线调整)#R/当前经验倍率为"..服务端参数.经验获得率,频道="xt"})
-- 		    发送网关消息("当前经验倍率已经调整到" .. 服务端参数.经验获得率)
-- 		end
-- end


function 小神网关:发送货币(data)
    if 玩家数据[data[1]] == nil then
      发送网关消息(string.format("[%d]角色不存在或未上线", data[1]))
      return
    end
    local 帮派1=false
    if data[2]=="充值经验" then
			玩家数据[data[1]].角色:添加经验(data[3],"网关充值")
		elseif data[2]=="充值银子" then
			玩家数据[data[1]].角色:添加银子(data[3],"网关充值",1)
		elseif data[2]=="充值储备" then
			玩家数据[data[1]].角色:添加储备(data[3],"网关充值",1)
		elseif data[2]=="充值仙玉" then
			玩家数据[data[1]].角色:添加仙玉(data[3],"网关充值",1)
		elseif data[2]=="充值累充" then
			添加累充(data[3],玩家数据[data[1]].账号,data[1],"网关充值")
          	累冲金额总计(data[3], 玩家数据[data[1]].账号,data[1], "网关充值")
          	-- 常规提示(data[3],"充值和累充同时增加"..je.."点")

		elseif data[2]=="副本积分" then
			玩家数据[data[1]].角色:添加副本积分(data[3])
		elseif data[2]=="充值帮贡" then
			if 玩家数据[data[1]].角色.BPMC ~= "无帮派" and 帮派数据[玩家数据[data[1]].角色.BPBH] then
				添加帮贡(data[1],data[3],"上限")
			else
				帮派1=true
			end
		elseif data[2]=="充值门贡" then
			-- 玩家数据[data[1]].角色:添加门贡(data[3])
			玩家数据[data[1]].角色.门贡=玩家数据[data[1]].角色.门贡+0+data[3]+0
			常规提示(data[1],"你获得了"..data[3].."点门贡")
		else
			发送网关消息(string.format("[%d]没有内置发送代码", data[2]))
		end
		if not 帮派1 then
				发送网关消息(string.format("角色%d%s%s", data[1], data[2], data[3]))
		else
				发送网关消息(string.format("[%d]没有帮派", data[1]))
		end
end
function 小神网关:发送称谓(arg)
  if 玩家数据[arg[1]] == nil then
    发送网关消息(string.format("[%d]角色不存在或未上线", arg[1]))
  elseif 玩家数据[arg[1]].角色:检查称谓(arg[2]) then
    发送网关消息(玩家数据[arg[1]].角色.名称 .. "已有称谓无法添加")
  else
    玩家数据[arg[1]].角色:添加称谓(arg[2])
    发送网关消息(玩家数据[arg[1]].角色.名称 .. "赠送" .. arg[2] .. "称谓成功")
  end
end


function 小神网关:GM网关开关(data)
  if data =="当前监听关闭" then
    当前监听=false
    发送网关消息(data)
  elseif data =="队伍监听关闭" then
    队伍监听=false
    发送网关消息(data)
  elseif data =="世界监听关闭" then
    世界监听=false
    发送网关消息(data)
  elseif data =="帮派监听关闭" then
    帮派监听=false
    发送网关消息(data)
  elseif data =="门派监听关闭" then
    门派监听=false
    发送网关消息(data)
  elseif data =="传闻监听关闭" then
    传闻监听=false
    发送网关消息(data)
  elseif data =="当前监听开启" then
    当前监听=true
    发送网关消息(data)
  elseif data =="队伍监听开启" then
    队伍监听=true
    发送网关消息(data)
  elseif data =="世界监听开启" then
    世界监听=true
    发送网关消息(data)
  elseif data =="帮派监听开启" then
    帮派监听=true
    发送网关消息(data)
  elseif data =="门派监听开启" then
    门派监听=true
    发送网关消息(data)
  elseif data =="传闻监听开启" then
    传闻监听=true
    发送网关消息(data)
--[[

设置任务127(id)----地上物品和宝宝
天降辰星:开启活动()
剑会:开启活动()
剑会:关闭活动()
帮派迷宫:开启活动()
帮派迷宫:关闭活动(id)
帮派PK:开启帮战报名()
帮派PK:正式开始帮战()
帮派PK:关闭活动()
帮派PK:清空数据()
彩虹争霸:开启报名()
彩虹争霸:开启彩虹进场()
彩虹争霸:正式开始比赛()
彩虹争霸:关闭活动()
文韵墨香:开启活动()
文韵墨香:关闭活动(id)

--]]
	elseif data =="全局存档" then
		保存系统数据()
		保存帮派数据()
		保存玩家数据()
		发送网关消息(string.format("%s成功",data))


	elseif data =="清空排行数据" then
	Ranking ={}
    		local 数组 ={  "玩家伤害排行","玩家速度排行","玩家防御排行","玩家气血排行","玩家法伤排行","玩家法防排行","玩家等级排行","玩家银子排行"  }
    		for i=1,#数组 do
      			Ranking[数组[i]]={}
        				-- for io=1,10 do
          		-- 			Ranking[数组[i]][io]={}
        				-- end
      		end
    		写出文件([[sql/排行榜.txt]],table.tostring(Ranking))
    		加载排行榜()
		发送网关消息(string.format("%s成功",data))
	elseif data =="降妖伏魔" then
		降妖伏魔:开启活动()
		发送网关消息(string.format("%s成功",data))
	elseif data =="天降辰星" then
		天降辰星:开启活动()
		发送网关消息(string.format("%s成功",data))
	elseif data =="文韵墨香" then
		文韵墨香:开启活动()
		发送网关消息(string.format("%s成功",data))
	elseif data =="门派闯关开关" then
		门派闯关:开启活动()
		发送网关消息(string.format("%s成功",data))
	elseif data =="皇宫飞贼开关" then
		设置任务12()
		发送网关消息(string.format("%s成功",data))
	elseif data =="首席争霸开关" then
		发送网关消息(string.format("%s成功---未添加",data))
	elseif data =="剑会开关" then
		剑会:开启活动()
		发送网关消息(string.format("%s成功",data))
	elseif data =="彩虹争霸报名" then
		彩虹争霸:开启报名()
		发送网关消息(string.format("%s成功",data))
	elseif data =="彩虹争霸进场" then
		彩虹争霸:开启彩虹进场()
		发送网关消息(string.format("%s成功",data))
	elseif data =="彩虹争霸开始" then
		彩虹争霸:正式开始比赛()
		发送网关消息(string.format("%s成功",data))
	elseif data =="彩虹争霸结束" then
		彩虹争霸:关闭活动()
		发送网关消息(string.format("%s成功",data))
	elseif data =="帮派迷宫" then
		帮派迷宫:开启活动()
		发送网关消息(string.format("%s成功",data))
	elseif data =="重置活动次数" then

		假人事件类:刷新摊位()

		发送网关消息(string.format("%s成功---未添加",data))
	elseif data =="帮战pk报名" then
		帮派PK:开启帮战报名()
		发送网关消息(string.format("%s成功",data))
	elseif data =="帮战pk开始" then
		帮派PK:正式开始帮战()
		发送网关消息(string.format("%s成功",data))
	elseif data =="帮战pk结束" then
		帮派PK:关闭活动()
		发送网关消息(string.format("%s成功",data))
	elseif data =="帮战pk数据清" then
		帮派PK:清空数据()
		发送网关消息(string.format("%s成功",data))
	elseif data =="游泳活动" then
		游泳活动:开启活动()
		发送网关消息(string.format("%s成功",data))
	elseif data =="比武大会开关" then
		if 比武大会.活动开关==false then
			比武大会.活动开关=true
		发送网关消息(string.format("%s成功--开启",data))
		else
			比武大会.活动开关=false
		发送网关消息(string.format("%s成功--关闭",data))
		end

  elseif data =="更新全部数据" then
  -- MonsterData=ReadExcel("怪物数据",ServerConfig.key)
	QAQ=ReadExcel("怪物数据","H3aM5ow4Ot6i5OyyDc3m5Q==")
	加载全局数据()
	发送网关消息(string.format("%s成功",data))

   elseif data =="调试开关" then
   	local 状态
  	if 调试模式==true then
  	   调试模式=false
  	   状态="关"
  	else
  	   调试模式=true
  	   状态="开"
  	end
      发送网关消息("调试模式="..状态 )
end
end



function 小神网关:更改活动时间(连接id,管理id,内容)
	local Time=分割文本(内容.TIME,"，")
	if Time[1] and Time[2] and Time[3] then
		local SHI=Time[1]+0
		local FEN=Time[2]+0
		local MIAO=Time[3]+0
		local 更改类型=内容.类型
		local 日期=内容.RQ
		if 更改类型=="游泳比赛" then
			if 游泳活动.活动开关 then
				常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。") --设置是成功了，但是活动结束后得重新设置一次才行
				return
			end
		elseif 更改类型=="文韵墨香" then
			if 文韵墨香.活动开关 then
				常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。")
				return
			end
		elseif 更改类型=="彩虹争霸" then
			if 彩虹争霸.活动开关 then
				常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。")
				return
			end
		elseif 更改类型=="降妖伏魔" then
			if 降妖伏魔.活动开关 then
				常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。")
				return
			end
		elseif 更改类型=="帮派迷宫" then
			if 帮派迷宫.活动开关 then
				常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。")
				return
			end
		elseif 更改类型=="天降辰星" then
			if 天降辰星.活动开关 then
				常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。")
				return
			end
		elseif 更改类型=="保卫长安" then
			if 长安保卫战.活动开关 then
				长安保卫战.活动开关=false
				常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。")
				return
			end
		elseif 更改类型=="帮战" then
			if 帮派PK.活动开关 then
				帮派PK.活动开关=false
				常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。已为你关闭了该活动")
				return
			end
		elseif 更改类型=="比武大会" then
			常规提示(管理id,"设置失败，"..更改类型.."活动正在完善中")
			return
			-- if 比武大会.活动开关 then
		 --   	    比武大会.活动开关=false
			-- 	常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。已为你关闭了该活动")
			--     return
			-- end
		 --    if 比武大会.活动开关 then
		 --   	    比武大会.活动开关=false
			-- 	常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。已为你关闭了该活动")
			--     return
			-- end
		elseif 更改类型=="剑会" then
		   if 剑会.活动开关 then
				剑会.活动开关=false
				常规提示(管理id,"设置失败，"..更改类型.."活动正在进行中，等活动结束后才能进行更改。已为你关闭了该活动")
				return
			end
		end
		if 更改类型=="定时刷怪" then
			if 日期=="天罡星" or 日期=="地煞星" or 日期=="封妖" or 日期=="妖王" then
				常规提示(管理id,"该活动暂时无法更改")
				return
			end
			QJHDSJ[更改类型][日期].时=SHI
			QJHDSJ[更改类型][日期].分=FEN
			QJHDSJ[更改类型][日期].秒=MIAO
			投放怪.活动时间=QJHDSJ[更改类型]
			写出文件([[活动时间.txt]],table.tostring(QJHDSJ))
			print("写入新的活动时间成功！")
			添加最后对话(管理id,"#G"..更改类型.."#W已更改成功，更改如下 #G日期："..日期.." 时："..SHI.." 分："..FEN.." 秒："..MIAO)
			return
		end
		if QJHDSJ[更改类型] then
			QJHDSJ[更改类型].日期=星期转数字(日期)
			QJHDSJ[更改类型].大写日期=日期
			QJHDSJ[更改类型].时=SHI
			QJHDSJ[更改类型].分=FEN
			QJHDSJ[更改类型].秒=MIAO
			if 更改类型=="游泳比赛" then
				游泳活动.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="门派闯关" then
				门派闯关.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="文韵墨香" then
				文韵墨香.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="彩虹争霸" then
				彩虹争霸.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="降妖伏魔" then
				降妖伏魔.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="帮派迷宫" then
				帮派迷宫.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="天降辰星" then
				天降辰星.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="保卫长安" then
				长安保卫战.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="帮战" then
				帮派PK.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="比武大会" then
				比武大会.活动时间=QJHDSJ[更改类型]
			elseif 更改类型=="剑会" then
				剑会.活动时间=QJHDSJ[更改类型]
			end
			写出文件([[活动时间.txt]],table.tostring(QJHDSJ))
			print("写入新的活动时间成功！")
			添加最后对话(管理id,"#G"..更改类型.."#W已更改成功，更改如下 #G日期："..日期.." 时："..SHI.." 分："..FEN.." 秒："..MIAO.."\n#R（“如果时超过24或分秒超过60”该活动就会处于关闭状态！）")
		end
	else
		常规提示(管理id,"#R设置失败，请注意大小写")
	end
end

function 小神网关:定制召唤兽(arg)
  if 玩家数据[arg[1]] == nil then
    发送网关消息(string.format("[%d]角色不存在或未上线", arg[1]))
  else
    local 数据 = 分割文本(arg[2], "*-*")
    local 技能组={}
    local zz={}

    if not Qubaobao[数据[2]] then
      发送网关消息(string.format("没有%s召唤兽模型", 数据[2]))
      return
    end

  	for i=1,6 do--资质
  		zz[#zz+1]=数据[i+5]
  	end
  	zz[7]=5000 --寿命
    if 数据[14] then  --技能组
    	local 技能组1 = 分割文本(数据[14],"@")

    	for i=1,#技能组1 do
    		if 技能组1[i] ~="" then
    		技能组[#技能组+1]=技能组1[i]
    		end
    	end
  	end
  	if 数据[5] ==nil or 数据[5] =="" then
  		数据[5]=0
  	end
    玩家数据[arg[1]].召唤兽:添加召唤兽(数据[2], 数据[2], 数据[3], nil,数据[5]+0, nil , 技能组,{数据[6]+0,数据[7]+0,数据[8]+0,数据[9]+0,数据[10]+0,数据[11]+0,8000},数据[12]+0,数据[1]+0)

    -- 玩家数据[arg[1]].召唤兽:添加召唤兽(数据[2], 数据[2], 数据[3], nil, 数据[1]+0, nil , 技能组,zz,数据[12]+0,Qubaobao[数据[2]].bbs_1)
    发送网关消息(string.format("[%d]召唤兽(%s)发送成功", arg[1],数据[2]))
    常规提示(arg[1],"#Y你获得一只#G"..#技能组.."技能的"..数据[2])
  end
end

function 小神网关:定制装备(arg)
	if 玩家数据[arg[1]] == nil then
    发送网关消息(string.format("[%d]角色不存在或未上线", arg[1]))
  else
  	-- table.print(arg)
  	local 数据 = 分割文本(arg[2], "*-*")
  	--  1-等级  2-装备类型  3-装备倍率  4-特效1  5-特技  6-套装类型(1追加2状态3变身)  7-套装效果   8-双加@分割
  	local 等级 =数据[1]+0
  	local 类型 =数据[2]
  	local 特效 =数据[4]
  	local 特技 =数据[5]
  	local 倍率 =数据[3]+0
  	local 双加 =数据[8]

  	if 数据[6]=="" then
  	数据[6]=0
  	end
  	local 套装类型 =数据[6]+0
  	local 套装效果 =数据[7]
  	if 双加=="@@@" then
  	   双加=nil
  	end
  	if 特技=="" then
  	特技=nil
  	end
  	if 特效==""  then
  	特效=nil
  	end

	if 等级>=100 then
		等级=等级/10
		等级=math.floor(等级)
	else
		等级=等级/10
		等级=math.floor(等级)
	end
	等级=math.floor(等级)
	local 武器序列,武器名称
			if 类型 =="武器" then
				武器序列=角色武器类型[玩家数据[arg[1]].角色.造型][取随机数(1,#角色武器类型[玩家数据[arg[1]].角色.造型])]
				武器名称=装备处理类.打造物品[武器序列][等级+1]
			elseif 类型 =="衣服" then
				local 衣服类型=2
				if 玩家数据[arg[1]].角色.性别=="女" then
					衣服类型=1
				end
				武器序列=21
				武器名称= 装备处理类.打造物品[武器序列][等级+1][衣服类型]
			elseif 类型 =="头盔" then
				local 头盔类型=1
				if 玩家数据[arg[1]].角色.性别=="女" then
					头盔类型=2
				end
				武器序列=19
				武器名称= 装备处理类.打造物品[武器序列][等级+1][头盔类型]
			elseif 类型 =="项链" then
				武器序列=20
				武器名称= 装备处理类.打造物品[武器序列][等级+1][取随机数(1,2)]
				-- print(武器名称)
				if type(装备处理类.打造物品[武器序列][等级+1])=="table" then
					武器名称= 装备处理类.打造物品[武器序列][等级+1][取随机数(1,2)]
				else
					武器名称= 装备处理类.打造物品[武器序列][等级+1]
				end
				-- print(武器名称)
			elseif 类型 =="腰带" then
				武器序列=22
				武器名称= 装备处理类.打造物品[武器序列][等级+1][取随机数(1,2)]
				if type(装备处理类.打造物品[武器序列][等级+1])=="table" then
					武器名称= 装备处理类.打造物品[武器序列][等级+1][取随机数(1,2)]
				else
					武器名称= 装备处理类.打造物品[武器序列][等级+1]
				end
			elseif 类型 =="鞋子" then
				武器序列=23
				武器名称= 装备处理类.打造物品[武器序列][等级+1]
			end
				装备处理类:发送定制装备(arg[1],等级*10,武器序列,武器名称,"网关发送",nil,true,arg[1],特效,nil,倍率,特技,双加,套装类型,套装效果)
				发送网关消息(string.format("[%d]发送装备(%s)成功", arg[1],武器名称))
	end
end
-- function 小神网关:定制装备(arg)
--   if 玩家数据[arg[1]] == nil then
--     发送网关消息(string.format("[%d]角色不存在或未上线", arg[1]))
--   else
--   	local 数据 = 分割文本(arg[2], "*-*")
--   	--  1-等级  2-装备类型  3-装备倍率  4-特效1  5-特技  6-套装类型(1追加2状态3变身)  7-套装效果   8-双加@分割
--   	local 等级,类型,特效,特技,倍率,双加,套装类型,套装效果
--   	等级 =数据[1]+0
--   	类型 =数据[2]
--   	倍率 =数据[3]+0
--   	if 数据[4] ~=""then
--   		特效 =数据[4]
--   	else
--   		特效 =nil
--   	end
--   	if 数据[5] ~=""then
--   		特技 =数据[5]
--   	else
--   		特技 =nil
--   	end
--   	if 数据[6] ~="" and 数据[7]~="" then
--   		套装类型 =数据[6]+0
--   		套装效果 =数据[7]
--   	else
--   		套装类型 =nil
--   		套装效果 =nil
--   	end
--   	if 数据[8] ~=""then
--   		双加 =数据[8]
--   	else
--   		双加 =nil
--   	end
-- 	if 等级>=100 then
-- 		等级=等级/10
-- 		等级=math.floor(等级)
-- 	else
-- 		等级=等级/10
-- 		等级=math.floor(等级)
-- 	end
-- 	等级=math.floor(等级)
-- 	local 武器序列,武器名称
-- 			if 类型 =="武器" then
-- 				武器序列=角色武器类型[玩家数据[arg[1]].角色.造型][取随机数(1,#角色武器类型[玩家数据[arg[1]].角色.造型])]
-- 				武器名称=装备处理类.打造物品[武器序列][等级+1]
-- 			elseif 类型 =="衣服" then
-- 				local 衣服类型=2
-- 				if 玩家数据[arg[1]].角色.性别=="女" then
-- 					衣服类型=1
-- 				end
-- 				武器序列=21
-- 				武器名称= 装备处理类.打造物品[武器序列][等级+1][衣服类型]
-- 			elseif 类型 =="头盔" then
-- 				local 头盔类型=1
-- 				if 玩家数据[arg[1]].角色.性别=="女" then
-- 					头盔类型=2
-- 				end
-- 				武器序列=19
-- 				武器名称= 装备处理类.打造物品[武器序列][等级+1][头盔类型]
-- 			elseif 类型 =="项链" then
-- 				武器序列=20
-- 				武器名称= 装备处理类.打造物品[武器序列][等级+1][取随机数(1,2)]
-- 				if type(装备处理类.打造物品[武器序列][等级+1])=="table" then
-- 					武器名称= 装备处理类.打造物品[武器序列][等级+1][取随机数(1,2)]
-- 				else
-- 					武器名称= 装备处理类.打造物品[武器序列][等级+1]
-- 				end
-- 			elseif 类型 =="腰带" then
-- 				武器序列=22
-- 				武器名称= 装备处理类.打造物品[武器序列][等级+1][取随机数(1,2)]
-- 				if type(装备处理类.打造物品[武器序列][等级+1])=="table" then
-- 					武器名称= 装备处理类.打造物品[武器序列][等级+1][取随机数(1,2)]
-- 				else
-- 					武器名称= 装备处理类.打造物品[武器序列][等级+1]
-- 				end
-- 			elseif 类型 =="鞋子" then
-- 				武器序列=23
-- 				武器名称= 装备处理类.打造物品[武器序列][等级+1]
-- 			end
-- 				装备处理类:发送定制装备(arg[1],等级*10,武器序列,武器名称,"网关发送",nil,true,arg[1],特效,nil,倍率,特技,双加,套装类型,套装效果)
-- 				发送网关消息(string.format("[%d]发送装备(%s)成功", arg[1],武器名称))
-- 	end
-- end
function 小神网关:定制灵饰(arg)
  if 玩家数据[arg[1]] == nil then
    发送网关消息(string.format("[%d]角色不存在或未上线", arg[1]))
  else
  	-- table.print(arg)
  	local 数据 = 分割文本(arg[2], "*-*")
  	-- table.print(数据)
  	--  1-等级  2-装备类型  3-主属性类型  4-主属性数值  5-是否超级简易(1是简易)  6-副属性 （分割@=）
  	local 等级 =数据[1]+0
  	local 类型 =数据[2]
  	local 主属性类型 =数据[3]
  	local 主属性数值 =数据[4]+0

  	if 数据[5]== nil or 数据[5]=="" then
  		数据[5]=0
  	elseif 数据[5]==1 then
  	    数据[5]=1
  	end
  	local 无级别限制=数据[5]+0
  	-- local 无级别限制 =数据[5]+0
  	local 副属性 =数据[6]
  	local 副属性数据 = 分割文本(副属性, "@")
  	local 副属性数据分割={}
  	local 通过=false

  	for i=1,#灵饰属性[类型].主属性 do
			if 灵饰属性[类型].主属性[i]==主属性类型 then
					通过=true
					break
			end
		end
		if 通过==false then
			 return 发送网关消息("主属性类型不对！")
		else
	  	for i=1,#副属性数据 do
	  		副属性数据分割[i] = 分割文本(副属性数据[i], "=")
	    end
	    tab1={主属性={},副属性={}}
	    tab1.主属性={mc=主属性类型,num=主属性数值}
	    for i=1,#副属性数据分割 do
	    	tab1.副属性[i]={mc=副属性数据分割[i][1],num=副属性数据分割[i][2]}
	    end
			tab1.专用=arg[1]
			tab1.制造者="网关灵饰"

			if 无级别限制==1 then---------不勾选则为0 为0则默认为超级简易
			    tab1.无级别限制=true
			end

			tab1.等级=等级
			tab1.部位=类型
			local daoj=self:gj灵饰处理(arg[1],tab1)
			玩家数据[arg[1]].道具:给予道具(arg[1],nil,nil,nil,nil,nil,daoj)
			发送网关消息(string.format("[%d]发送灵饰(%s)成功", arg[1],daoj.名称))
		end
	end
end
-- function 小神网关:定制灵饰(arg)
--   if 玩家数据[arg[1]] == nil then
--     发送网关消息(string.format("[%d]角色不存在或未上线", arg[1]))
--   else
--   	local 数据 = 分割文本(arg[2], "*-*")
--   	local 等级 =数据[1]+0
--   	local 类型 =数据[2]
--   	local 主属性类型 =数据[3]
--   	local 主属性数值 =数据[4]+0
--   	local 无级别限制 =数据[5] or 0
--   	local 副属性 =数据[6]
--   	local 副属性数据 = 分割文本(副属性, "@")
--   	local 副属性数据分割={}
--   	local 通过=false
--   	for i=1,#灵饰属性[类型].主属性 do
-- 			if 灵饰属性[类型].主属性[i]==主属性类型 then
-- 					通过=true
-- 					break
-- 			end
-- 		end
-- 		if 通过==false then
-- 			 return 发送网关消息("主属性类型不对！")
-- 		else
-- 	  	for i=1,#副属性数据 do
-- 	  		副属性数据分割[i] = 分割文本(副属性数据[i], "=")
-- 	    end
-- 	    tab1={主属性={},副属性={}}
-- 	    tab1.主属性={mc=主属性类型,num=主属性数值}
-- 	    for i=1,#副属性数据分割 do
-- 	    	if 副属性数据分割[i][1]~="" and 副属性数据分割[i][2]~="" then
-- 	    	tab1.副属性[i]={mc=副属性数据分割[i][1],num=副属性数据分割[i][2]}
-- 	    	end
-- 	    end
-- 			tab1.专用=arg[1]
-- 			tab1.制造者="系统制造"
-- 			if 无级别限制==1 then
-- 			    tab1.无级别=true
-- 			end
-- 			tab1.等级=等级
-- 			tab1.部位=类型
-- 			local daoj=self:gj灵饰处理(arg[1],tab1)
-- 			玩家数据[arg[1]].道具:给予道具(arg[1],nil,nil,nil,nil,nil,daoj)
-- 			发送网关消息(string.format("[%d]发送灵饰(%s)成功", arg[1],daoj.名称))
-- 		end
-- 	end
-- end
function 小神网关:定制BB装备(arg)
  if 玩家数据[arg[1]] == nil then
    发送网关消息(string.format("[%d]角色不存在或未上线", arg[1]))
  else
  	local 数据 = 分割文本(arg[2], "*-*")
  -- 	--  1-等级  2-装备类型  3-主属性类型  4-主属性数值  5-副属性类型  6-副属性数值  78-副2  910-副3
  	local 等级 =数据[1]+0
  	local 类型 =数据[2]
  	local 类型序列
  	if 类型 =="护腕" then
  		类型序列=24
  	elseif 类型 =="项圈" then
  		类型序列=25
  	elseif 类型 =="铠甲" then
  		类型序列=26
  	end
	local 临时序列=math.floor(等级/10)
	local 临时名称=装备处理类.打造物品[类型序列][临时序列]
	local 道具 = 物品类()
	道具:置对象(临时名称)
	道具.级别限制 = 等级
	道具.召唤兽装备 = true
	if 数据[3]~="" and 数据[4]~="" then
		道具[数据[3]]=数据[4]+0
	end
	if 数据[5]~="" and 数据[6]~="" then
		道具[数据[5]]=数据[6]+0
	end
	if 数据[7]~="" and 数据[8]~="" then
		道具[数据[7]]=数据[8]+0
	end
	if 数据[9]~="" and 数据[10]~="" then
		道具[数据[9]]=数据[10]+0
	end
	道具.制造者 = "网关宠装"
	玩家数据[arg[1]].道具:给予道具(arg[1],nil,nil,nil,nil,nil,道具)
	发送网关消息(string.format("[%d]发送BB装备(%s)成功", arg[1],临时名称))
	end
end
function 小神网关:gj灵饰处理(id,shux)--,部位,lv,shux名称,专用,制造者)
	local 名称=制造装备[shux.部位][shux.等级]
	local 临时道具 =物品类()
	临时道具:置对象(名称)
	临时道具.幻化等级=0
	临时道具.部位类型=shux.部位
	临时道具.灵饰=true
	临时道具.耐久=500
	临时道具.鉴定=true
	临时道具.幻化属性={附加={}}
	临时道具.识别码=id.."_"..os.time().."_"..取随机数(1000,9999999).."_"..随机序列
	随机序列=随机序列+1
	local 主属性=shux.主属性.mc
	local 临时数值=shux.主属性.num
	临时道具.幻化属性.基础={类型=主属性,数值=临时数值,强化=0}
	for n=1,#shux.副属性 do
		if shux.副属性[n] then
			local 副属性=shux.副属性[n].mc
			临时数值=shux.副属性[n].num
			临时道具.幻化属性.附加[n]={类型=副属性,数值=临时数值,强化=0}
		end
	end
	if shux.专用 then
		临时道具.专用=id
	end
	if shux.无级别限制 then
		临时道具.特效="无级别限制"
	else
		临时道具.特效="超级简易"
	end
	if shux.制造者~="否" then
	    临时道具.制造者=shux.制造者
	end
	return 临时道具
end

function 小神网关:添加称谓(管理id,称谓)
	if 管理id ~= nil then
		if 玩家数据[管理id] ~= nil then
			玩家数据[管理id].角色:添加称谓(称谓)
			闪烁消息(管理id,"恭喜你在本次的首席弟子竞选中脱颖而出获得了门派首席弟子的称谓")
		else
			local sj = 取玩家数据表(管理id)
			sj1=table.loadstring(sj.称谓)
			local fhz = false
			for i=1,#sj1 do
				if sj1[i] ==  称谓 then
					fhz = true
				end
			end
			if fhz == false then
				table.insert(sj1,fhz)
				sj2 = 称谓
				if sj2 == 称谓 then sj2 = "明月楼" end
				m:执行SQL(string.format("update 玩家数据 set 称谓 = '%s',当前称谓 = '%s' where  szid='%s'",table.tostring(sj1),sj2,管理id))
			end
			闪烁消息(管理id,"恭喜你在本次的首席弟子竞选中脱颖而出获得了门派首席弟子的称谓")
		end
	end
end


-- function GMTool:GM地图系统(...)----未完成
--   local arg=...
--   local MapNumber = tonumber(arg[2])
--     if  arg[1] == "更新数据" then

--     elseif arg[1] == "清除摆摊" then
--       for n, v in pairs(MapControl.MapData[MapNumber].玩家) do
--          if UserData[n] and UserData[n].摆摊 then
--               摊位数据[n]=nil
--               UserData[n].摆摊 = nil
--               MapControl.MapData[MapNumber].摆摊人数=MapControl.MapData[MapNumber].摆摊人数-1
--               SendMessage(UserData[n].连接id, 7, "#y/收摊回家玩老婆咯！")
--               SendMessage(UserData[n].连接id, 20008,"")
--               MapControl:更新摊位(n, "", MapNumber)
--          end
--       end
--     elseif arg[1] == "清除假人" then
--         -- 假人移动 =false
--         -- 协程列表["假人移动"]=nil
--         -- for n, v in pairs(MapControl.MapData[MapNumber].玩家) do
--         --    if UserData[n] and UserData[n].假人 then
--         --           if UserData[n].摆摊 then
--         --               MapControl.MapData[MapNumber].摆摊人数=MapControl.MapData[MapNumber].摆摊人数-1
--         --           end
--         --           MapControl:移除玩家(UserData[n].地图, n)
--         --           MapControl.MapData[MapNumber].假人=MapControl.MapData[MapNumber].假人-1
--         --           UserData[n]=nil
--         --    end
--         -- end
--         --  collectgarbage("collect")
--  local ss = 0
--         if arg[2] == 1040 then
-- ss = 0
-- elseif arg[2] == 1041 then
--   ss = 1
--   elseif arg[2] == 1042 then
--   ss = 2
--   elseif arg[2] == 1070 then
--   ss = 3
--     elseif arg[2] == 1091 then
--   ss = 4
--   end
--         for n, v in pairs(UserData) do
--             if v.假人 then
--                 if jrsj[n].假人类型 == ss then
--           Network:退出处理(n)
--                 end
--             end
--         end
--          collectgarbage("collect")

--     elseif arg[1] == "清除怪物" then
--       for k,v in pairs(MapControl.MapData[MapNumber].单位组) do
--            for n, s in pairs(MapControl.MapData[MapNumber].玩家) do
--             if UserData[n] then
--                 SendMessage(UserData[n].连接id,1018,v.任务id)
--              end
--           end
--           MapControl.MapData[MapNumber].单位组[k]=nil
--       end
--     elseif arg[1] == "清除玩家" then
--         for n, v in pairs(MapControl.MapData[MapNumber].玩家) do
--          if UserData[n]  then
--             SendMessage(UserData[n].连接id,99998,"GM清空地图处理")
--          end
--         end
--     elseif arg[1] == "添加假人" then
--        Network:假人进入游戏处理(arg[3])
--       -- if not MapControl.MapData[MapNumber].坐标 then
--       --   发送网关消息("这个地图不支持刷出假人,请尝试在主城刷新，如果有特别要求请联系作者")
--       --    return
--       -- end
--       --   local 玩家账号 =取目录下名称(ServerDirectory.."玩家信息")
--       --   if arg[3] > #玩家账号 then
--       --     arg[3]=#玩家账号
--       --   end
--       --   协程列表["假人生成"]=nil
--       --   local co = coroutine.wrap(
--       --     function(玩家账号,arg,MapNumber)
--       --         local ls= 0;
--       --         for i=1,arg do
--       --             Network:假人进入游戏处理({账号=玩家账号[i],编号=1,ip="127.0.0.1",id=0},MapNumber)
--       --             ls=ls+1
--       --             if ls ==30 then
--       --                 ls =0
--       --                  SendMessage(1,993,cjson.encode({
--       --                           Role=tostring(取表数量(MapControl.MapData[MapNumber].玩家)),
--       --                           Monster=tostring(#MapControl.MapData[MapNumber].单位组),
--       --                           Model=tostring(MapControl.MapData[MapNumber].假人),
--       --                           Stall=tostring(MapControl.MapData[MapNumber].摆摊人数),
--       --                           Number=tostring(MapControl.MapData[MapNumber].编号)
--       --                           }))
--       --                   coroutine.yield()
--       --             end
--       --         end
--       --         return true
--       --     end

--       --     )
--       --   if not co(玩家账号,arg[3],MapNumber) then
--       --         协程列表["假人生成"]= co
--       --   end

--       --    假人移动=true
--     end
--      --  SendMessage(1,993,cjson.encode({
--      --  Role=tostring(取表数量(MapControl.MapData[MapNumber].玩家)),
--      --  Monster=tostring(#MapControl.MapData[MapNumber].单位组),
--      --  Model=tostring(MapControl.MapData[MapNumber].假人),
--      --  Stall=tostring(MapControl.MapData[MapNumber].摆摊人数),
--      --  Number=tostring(MapControl.MapData[MapNumber].编号)
--      --  }))
--      -- 发送网关消息(string.format("地图%s成功",arg[1]))
-- end




return 小神网关