-- @Author: baidwwy
-- @Date:   2023-10-11 14:46:42
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-10-16 19:39:48
local 好友消息类 = class()

function 好友消息类:初始化()
	-- self.数据={}
	消息数据={}
	好友黑名单={}
end

function 好友消息类:数据处理(连接id,序号,内容)
	local 数字id = 内容.数字id+0
	if 序号 ==6956 then --16
		if self:取消息数据(数字id,连接id)==false then
			玩家数据[数字id].角色:取好友数据(数字id,连接id,50)
		end
		return
	elseif 序号 ==6957 then --17  --查找添加好友
		local 查找数据=self:查找角色(内容.名称,内容.id)
		if #查找数据==0 then
			常规提示(数字id,"#Y这个角色并不存在或当前没有在线")
			return
		else
			发送数据(连接id,51,查找数据)
		end


	elseif 序号 ==6958 then --18 --添加好友 --这个要更改
		local 查找数据=self:查找角色(内容.名称,内容.id)
		if #查找数据==0 then
			常规提示(数字id,"#Y这个角色并不存在或当前没有在线")
			return
		else
			--发送数据(连接id,51,查找数据)
			self:添加好友(数字id,连接id,查找数据[2],内容.类型)
		end
	elseif 序号 ==6959 then --19 --添加好友 --这个要更改
		玩家数据[数字id].角色:取好友数据(数字id,连接id,53)
	elseif 序号==6960 then --更新好友数据  20
		local 类型=内容.类型
		local 序列=内容.序列
		if 玩家数据[数字id].角色.好友数据[类型]==nil then
			常规提示(数字id,"#Y更新失败，你没有这个分类")
			return
		elseif 玩家数据[数字id].角色.好友数据[类型][序列]==nil then
			常规提示(数字id,"#Y更新失败，你没有这个好友")
			return
		else
			local 好友id=玩家数据[数字id].角色.好友数据[类型][序列].id
			if 玩家数据[好友id]==nil then
				常规提示(数字id,"#Y对方当前不在线，无法更新其信息")
				return
			else
				玩家数据[数字id].角色.好友数据[类型][序列].名称=玩家数据[好友id].角色.名称
				玩家数据[数字id].角色.好友数据[类型][序列].等级=玩家数据[好友id].角色.等级
				玩家数据[数字id].角色.好友数据[类型][序列].门派=玩家数据[好友id].角色.门派
				玩家数据[数字id].角色.好友数据[类型][序列].称谓=玩家数据[好友id].角色.称谓
				玩家数据[数字id].角色.好友数据[类型][序列].帮派=玩家数据[好友id].角色.BPMC
				玩家数据[数字id].角色.好友数据[类型][序列].称谓=玩家数据[好友id].角色.当前称谓
				发送数据(连接id,54,{数据=玩家数据[数字id].角色.好友数据[类型][序列],类型=类型,序列=序列})
			end
		end
	elseif 序号==6961 then --21
		local 好友id=内容.id
		if 玩家数据[好友id]==nil then
			常规提示(数字id,"#Y对方当前不在线，无法添加其为好友")
			return
		else
			self:添加好友(数字id,连接id,好友id,1)
		end
	elseif 序号==6962 then --22
		local 好友id=内容.id
		if 玩家数据[好友id]==nil then
			常规提示(数字id,"#Y对方当前不在线，无法添加其为好友")
			return
		else
			self:添加好友(数字id,连接id,好友id,3)
		end
	elseif 序号==6963 then --移除好友
		local 好友id=内容.id
		local 类型=内容.类型
		local 删除序列=0
		for n=1,#玩家数据[数字id].角色.好友数据[类型] do
			if 玩家数据[数字id].角色.好友数据[类型][n].id==好友id then
				删除序列=n
				break
			end
		end
		if 删除序列~=0 then
			table.remove(玩家数据[数字id].角色.好友数据[类型],删除序列)
			发送数据(连接id,52)
			常规提示(数字id,"#Y删除好友成功！")
			if 类型=="黑名单" then
				-- 删除序列=0
				-- for n=1,#好友黑名单[数字id] do
				-- 	if 好友黑名单[数字id][n]==好友id then 删除序列=n end
				-- end
				-- if 删除序列~=0 then
				-- 	table.remove(好友黑名单[数字id],删除序列)
				-- end
			end
		end
		return
	elseif 序号==6964 then --请求发送消息 24
		local 好友id=内容.id
		if 消息数据[好友id]==nil then
			消息数据[好友id]={}
		end
		-- if self:拒收消息检查(好友id,id,id)==false then return  end
		消息数据[好友id][#消息数据[好友id]+1]={名称=玩家数据[数字id].角色.名称,类型=1,模型=玩家数据[数字id].角色.模型,内容=内容.内容,id=数字id,时间=时间转换1(os.time()),等级=玩家数据[数字id].角色.等级,好友度=self:取好友度(数字id,好友id)}
		发送数据(玩家数据[数字id].连接id,55,{信息=玩家数据[数字id].角色.名称.."   "..时间转换1(os.time()),id=好友id,内容=内容.内容})
		self:更新消息通知(好友id)
	elseif 序号==6965 then --请求发送消息 25
		self:取消息数据(数字id,连接id)
	elseif 序号==6966 then
		self:消除体验状态(连接id,数字id,内容)
	elseif 序号==6967 then --安卓战斗测试
		战斗准备类:创建战斗(数字id+0,121111,1)
	end
end
function 好友消息类:消除体验状态(连接id,id,内容)
	if f函数.读配置(程序目录..[[data\]]..玩家数据[id].账号..[[\账号信息.txt]],"账号配置","体验状态") == "0" then
		添加最后对话(id,"解除体验功能，请联系管理员。（免费）")
	else
		玩家数据[id].角色.体验状态=nil
		发送数据(连接id,225)
		常规提示(id,"消除体验状态成功。")
	end
end

function 好友消息类:更新消息通知(id)
	if 消息数据[id]==nil then
		消息数据[id]={}
	end
	if 玩家数据[id]~=nil and #消息数据[id]>0  then
		发送数据(玩家数据[id].连接id,56,"1")
	end
end

function 好友消息类:查找角色(名称,id)
	if id==nil then
		return
	end
	local 数据组={}
	id=id+0
	for i, v in pairs(玩家数据) do
		if 玩家数据[i].角色.名称==名称 or i==id then
			数据组[1]=玩家数据[i].角色.名称
			数据组[2]=i
			数据组[3]=玩家数据[i].角色.等级
			数据组[4]=玩家数据[i].角色.门派
		end
	end
	return 数据组
end

function 好友消息类:取消息数据(id,连接id)
	if 消息数据[id]==nil then
		消息数据[id]={}
	end
	if 玩家数据[id]~=nil and #消息数据[id]>0 then
		local 接收消息=true
		发送数据(玩家数据[id].连接id,58,{信息=消息数据[id][1].名称.."   "..消息数据[id][1].时间,模型=消息数据[id][1].模型,类型=消息数据[id][1].类型,id=消息数据[id][1].id,内容=消息数据[id][1].内容,名称=消息数据[id][1].名称,好友度=消息数据[id][1].好友度,等级=消息数据[id][1].等级})
		table.remove(消息数据[id],1)
		if #消息数据[id]<1 then
			发送数据(玩家数据[id].连接id,57,"1") --消息闪烁=false
		end
		return true
	else
		发送数据(玩家数据[id].连接id,57,"1") --消息闪烁=false
		return false
	end
end


function 好友消息类:添加好友(id,连接id,好友id,类型)
	if id==好友id then
		常规提示(id,"#Y你无法将自己添加到好友名单中")
		return
	end
	if 类型==1 then
		if #玩家数据[id].角色.好友数据.好友>=50 then
			常规提示(id,"#Y你的好友人数已达上限")
			return
		else
			--检查是否重复
			for n=1,#玩家数据[id].角色.好友数据.好友 do
				if 玩家数据[id].角色.好友数据.好友[n].id==好友id then
					常规提示(id,"#Y对方已经在你的好友名单中了")
					return
				end
			end
			local 删除序列=0
			for n=1,#玩家数据[id].角色.好友数据.黑名单 do
				if 玩家数据[id].角色.好友数据.黑名单[n].id==好友id then
					删除序列=n
				end
			end
			if 删除序列~=0 then
				table.remove(玩家数据[id].角色.好友数据.黑名单,删除序列)
			end
			--增加新朋友
		end
		玩家数据[id].角色.好友数据.好友[#玩家数据[id].角色.好友数据.好友+1]={关系="陌生人",模型=玩家数据[好友id].角色.模型,名称=玩家数据[好友id].角色.名称,id=好友id,门派=玩家数据[好友id].角色.门派,帮派=玩家数据[好友id].角色.BPMC,等级=玩家数据[好友id].角色.等级,称谓=玩家数据[好友id].角色.当前称谓}
		for n=1,#玩家数据[好友id].角色.好友数据.好友 do
			if 玩家数据[好友id].角色.好友数据.好友[n].id==id then
				if 玩家数据[好友id].角色.好友数据.好友[n].好友度~=nil then
					玩家数据[id].角色.好友数据.好友[#玩家数据[id].角色.好友数据.好友].好友度=玩家数据[好友id].角色.好友数据.好友[n].好友度
				end
				玩家数据[好友id].角色.好友数据.好友[n].关系="普通朋友"
				玩家数据[id].角色.好友数据.好友[#玩家数据[id].角色.好友数据.好友].关系="普通朋友"
			end
		end
		常规提示(id,"#Y添加好友成功")
		常规提示(好友id,"#Y"..玩家数据[id].角色.名称.."将你添加为好友")
		local 删除序列=0
		for n=1,#玩家数据[id].角色.好友数据.临时 do
			if 玩家数据[id].角色.好友数据.临时[n].id==好友id then
			删除序列=n
			end
		end
		if 删除序列~=0 then
			table.remove(玩家数据[id].角色.好友数据.临时,删除序列)
		end
		发送数据(连接id,52)
		if 玩家数据[id].角色.好友数据.好友[#玩家数据[id].角色.好友数据.好友].关系~="陌生人" then
			发送数据(玩家数据[好友id].连接id,52)
		end
	elseif 类型==2 then  --加为临时
		for n=1,#玩家数据[id].角色.好友数据.好友 do
			if 玩家数据[id].角色.好友数据.好友[n].id==好友id then
				常规提示(id,"#Y对方已经在你的好友名单中了")
				return
			end
		end
		for n=1,#玩家数据[id].角色.好友数据.临时 do
			if 玩家数据[id].角色.好友数据.临时[n].id==好友id then
				常规提示(id,"#Y对方已经在你的临时好友名单中了")
				return
			end
		end
		local 序列=0
		if #玩家数据[id].角色.好友数据.临时<6 then
			序列=#玩家数据[id].角色.好友数据.临时+1
		else
			table.remove(玩家数据[id].角色.好友数据.临时,1)
			序列=6
		end
		玩家数据[id].角色.好友数据.临时[序列]={关系="陌生人",模型=玩家数据[好友id].角色.模型,名称=玩家数据[好友id].角色.名称,id=好友id,门派=玩家数据[好友id].角色.门派,帮派=玩家数据[好友id].角色.BPMC,等级=玩家数据[好友id].角色.等级,称谓=玩家数据[好友id].角色.当前称谓}
		常规提示(id,"#Y添加临时好友成功")
		发送数据(连接id,52)
	elseif 类型==3 then  --加为临时
		for n=1,#玩家数据[id].角色.好友数据.黑名单 do
			if 玩家数据[id].角色.好友数据.黑名单[n].id==好友id then
				常规提示(id,"#Y对方已经在你的黑名单中了")
				return
			end
		end
		if #玩家数据[id].角色.好友数据.黑名单>=20 then
			常规提示(id,"#Y你的黑名单人数已达上限")
			return
		end
		玩家数据[id].角色.好友数据.黑名单[#玩家数据[id].角色.好友数据.黑名单+1]={关系="黑名单",模型=玩家数据[好友id].角色.模型,名称=玩家数据[好友id].角色.名称,id=好友id,门派=玩家数据[好友id].角色.门派,帮派=玩家数据[好友id].角色.BPMC,等级=玩家数据[好友id].角色.等级,称谓=玩家数据[好友id].角色.当前称谓}
		常规提示(id,"#Y添加黑名单成功")
		local 删除序列=0
		for n=1,#玩家数据[id].角色.好友数据.好友 do
			if 玩家数据[id].角色.好友数据.好友[n].id==好友id then
				删除序列=n
				break
			end
		end
		if 删除序列~=0 then
			table.remove(玩家数据[id].角色.好友数据.好友,删除序列)
		end
		删除序列=0
		for n=1,#玩家数据[id].角色.好友数据.临时 do
			if 玩家数据[id].角色.好友数据.临时[n].id==好友id then
				删除序列=n
				break
			end
		end
		if 删除序列~=0 then
			table.remove(玩家数据[id].角色.好友数据.临时,删除序列)
		end
		删除序列=0
		for n=1,#玩家数据[id].角色.好友数据.最近 do
			if 玩家数据[id].角色.好友数据.最近[n].id==好友id then
				删除序列=n
				break
			end
		end
		if 删除序列~=0 then
			table.remove(玩家数据[id].角色.好友数据.最近,删除序列)
		end
		发送数据(连接id,52)
	end
end

function 好友消息类:取好友度(id,好友id)
	for n=1,#玩家数据[id].角色.好友数据.好友 do
		if 玩家数据[id].角色.好友数据.好友[n].id==好友id then
			if 玩家数据[id].角色.好友数据.好友[n].好友度==nil then
				return 0
			else
				return 玩家数据[id].角色.好友数据.好友[n].好友度
			end
		end
	end
	return 0
end

function 好友消息类:拒收消息检查(id,好友id,提示id)
  -- if 好友黑名单[id]==nil then 好友黑名单[id]={} end
  -- for n=1,#好友黑名单[id] do
  --   if 好友黑名单[id][n]==好友id then
  --     常规提示(提示id,"#Y你已被对方拉入黑名单中！")
  --     return false
  --   end
  -- end
  return true
end

return 好友消息类

-- function 好友消息类:数据处理(连接id,序号,内容)
-- 	local 数字id = 内容.数字id+0
-- 	if 序号 ==6956 then --16
-- 		if self:取消息数据(数字id,连接id)==false then
-- 			玩家数据[数字id].角色:取好友数据(数字id,连接id,50)
-- 		end
-- 		return
-- 	elseif 序号 ==6957 then --17  --查找添加好友
-- 		local 查找数据=self:查找角色(内容.名称,内容.id)
-- 		if #查找数据==0 then
-- 			常规提示(数字id,"#Y这个角色并不存在或当前没有在线")
-- 			return
-- 		else
-- 			发送数据(连接id,51,查找数据)
-- 		end
-- 	elseif 序号 ==6958 then --18 --添加好友 --这个要更改
-- 		local 查找数据=self:查找角色(内容.名称,内容.id)
-- 		if #查找数据==0 then
-- 			常规提示(数字id,"#Y这个角色并不存在或当前没有在线")
-- 			return
-- 		else
-- 			--发送数据(连接id,51,查找数据)
-- 			self:添加好友(数字id,连接id,查找数据[2],内容.类型)
-- 		end
-- 	elseif 序号 ==6959 then --19 --添加好友 --这个要更改
-- 		玩家数据[数字id].角色:取好友数据(数字id,连接id,53)
-- 	elseif 序号==6960 then --更新好友数据  20
-- 		local 类型=内容.类型
-- 		local 序列=内容.序列
-- 		if 玩家数据[数字id].角色.好友数据[类型]==nil then
-- 			常规提示(数字id,"#Y更新失败，你没有这个分类")
-- 			return
-- 		elseif 玩家数据[数字id].角色.好友数据[类型][序列]==nil then
-- 			常规提示(数字id,"#Y更新失败，你没有这个好友")
-- 			return
-- 		else
-- 			local 好友id=玩家数据[数字id].角色.好友数据[类型][序列].id
-- 			if 玩家数据[好友id]==nil then
-- 				常规提示(数字id,"#Y对方当前不在线，无法更新其信息")
-- 				return
-- 			else
-- 				玩家数据[数字id].角色.好友数据[类型][序列].名称=玩家数据[好友id].角色.名称
-- 				玩家数据[数字id].角色.好友数据[类型][序列].等级=玩家数据[好友id].角色.等级
-- 				玩家数据[数字id].角色.好友数据[类型][序列].门派=玩家数据[好友id].角色.门派
-- 				玩家数据[数字id].角色.好友数据[类型][序列].称谓=玩家数据[好友id].角色.称谓
-- 				玩家数据[数字id].角色.好友数据[类型][序列].帮派=玩家数据[好友id].角色.BPMC
-- 				玩家数据[数字id].角色.好友数据[类型][序列].称谓=玩家数据[好友id].角色.当前称谓
-- 				发送数据(连接id,54,{数据=玩家数据[数字id].角色.好友数据[类型][序列],类型=类型,序列=序列})
-- 			end
-- 		end
-- 	elseif 序号==6961 then --21
-- 		local 好友id=内容.id
-- 		if 玩家数据[好友id]==nil then
-- 			常规提示(数字id,"#Y对方当前不在线，无法添加其为好友")
-- 			return
-- 		else
-- 			self:添加好友(数字id,连接id,好友id,1)
-- 		end
-- 	elseif 序号==6962 then --22
-- 		local 好友id=内容.id
-- 		if 玩家数据[好友id]==nil then
-- 			常规提示(数字id,"#Y对方当前不在线，无法添加其为好友")
-- 			return
-- 		else
-- 			self:添加好友(数字id,连接id,好友id,3)
-- 		end
-- 	elseif 序号==6963 then --移除好友
-- 		local 好友id=内容.id
-- 		local 类型=内容.类型
-- 		local 删除序列=0
-- 		for n=1,#玩家数据[数字id].角色.好友数据[类型] do
-- 			if 玩家数据[数字id].角色.好友数据[类型][n].id==好友id then
-- 				删除序列=n
-- 				break
-- 			end
-- 		end
-- 		if 删除序列~=0 then
-- 			table.remove(玩家数据[数字id].角色.好友数据[类型],删除序列)
-- 			发送数据(连接id,52)
-- 			常规提示(数字id,"#Y删除好友成功！")
-- 			if 类型=="黑名单" then
-- 				-- 删除序列=0
-- 				-- for n=1,#好友黑名单[数字id] do
-- 				-- 	if 好友黑名单[数字id][n]==好友id then 删除序列=n end
-- 				-- end
-- 				-- if 删除序列~=0 then
-- 				-- 	table.remove(好友黑名单[数字id],删除序列)
-- 				-- end
-- 			end
-- 		end
-- 		return
-- 	elseif 序号==6964 then --请求发送消息 24
-- 		local 好友id=内容.id
-- 		if 消息数据[好友id]==nil then
-- 			消息数据[好友id]={}
-- 		end
-- 		-- if self:拒收消息检查(好友id,id,id)==false then return  end
-- 		消息数据[好友id][#消息数据[好友id]+1]={名称=玩家数据[数字id].角色.名称,类型=1,模型=玩家数据[数字id].角色.模型,内容=内容.内容,id=数字id,时间=时间转换1(os.time()),等级=玩家数据[数字id].角色.等级,好友度=self:取好友度(数字id,好友id)}
-- 		发送数据(玩家数据[数字id].连接id,55,{信息=玩家数据[数字id].角色.名称.."   "..时间转换1(os.time()),id=好友id,内容=内容.内容})
-- 		self:更新消息通知(好友id)
-- 	elseif 序号==6965 then --请求发送消息 25
-- 		self:取消息数据(数字id,连接id)
-- 	elseif 序号==6966 then
-- 		self:消除体验状态(连接id,数字id,内容)
-- 	elseif 序号==6967 then --安卓战斗测试
-- 		战斗准备类:创建战斗(数字id+0,121111,1)
-- 	end
-- end