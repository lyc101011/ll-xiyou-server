-- @Author: baidwwy
-- @Date:   2024-08-21 11:47:40
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-05 18:54:52
local 队伍处理类 = class()

function 队伍处理类:初始化()end
function 队伍处理类:数据处理(连接id,序号,id,内容)

  if 玩家数据[id].摊位数据~=nil or 玩家数据[id].坐牢中 then
  	常规提示(id,"当前状态禁止此类操作，如有异常请重新登录！")
  	return
 	end

 	if 玩家数据[id].已扣除勾魂索 and not 玩家数据[id].角色.武神坛角色 then
 		常规提示(id,"当前状态禁止此类操作的喔")
 		return
 	end


if 玩家数据[id].角色.体验状态 then
	常规提示(id,"体验状态下无法进行此操作。")
	return
end
  if 序号==4001 then
	if 玩家数据[id].队伍==0 then
	  发送数据(连接id,4001)
	else
	  self:索取队伍信息(id,4002)
	end
  elseif 序号==4002 then --创建、加入队伍
	self:创建队伍(id,内容)
  elseif 序号==4003 then
	if 玩家数据[id].队长 then
		self:索取申请信息(连接id,id)
	else
		常规提示(id,"只有队长才可进行此操作")
	end
  elseif 序号==4004 then --同意加入队伍
	if 玩家数据[id].队长 then
	  self:同意入队(id,内容)
	else
	  常规提示(id,"只有队长才可进行此操作")
	end
  elseif 序号==4005 and 玩家数据[id].队长 then --删除申请列表
	--self:创建队伍(id,内容)
	if 玩家数据[队伍数据[玩家数据[id].队伍].申请数据[内容.序列].id]~=nil then
	  常规提示(队伍数据[玩家数据[id].队伍].申请数据[内容.序列].id,取名称(id).."拒绝了你的入队申请")
	end
	table.remove(队伍数据[玩家数据[id].队伍].申请数据,内容.序列)
	发送数据(玩家数据[id].连接id,4011,队伍数据[玩家数据[id].队伍].申请数据)
  elseif 序号==4006 then --同意加入队伍
	self:退出队伍(id)
  elseif 序号==4007  then
	if 玩家数据[id].队长 then
	  	local 临时id=队伍数据[玩家数据[id].队伍].成员数据[内容.序列]
	  	if id==临时id then
			常规提示(id,"您不能将自己请离队伍")
			return
	  	else
			常规提示(临时id,"你被队长请离了队伍")
			self:退出队伍(临时id)
	 	 end
	else
		常规提示(id,"只有队长才可进行此操作")
	end
  elseif 序号==4008  then
	if 玩家数据[id].队长 then
	  发送数据(连接id,4013,玩家数据[id].角色.阵法)
	else
	  常规提示(id,"只有队长才可进行此操作")
	end
	elseif 序号==4008.1  then
		if not 玩家数据[id].队长 then
		   常规提示(id,"只有队长才可进行此操作")
		   return
		end
		local zgdj = 玩家数据[id].角色.等级
		local 临时信息=table.loadstring(读入文件(程序目录..[[data/]]..玩家数据[id].账号..[[/信息.txt]]))
		for n=1,#临时信息 do
			 local 临时id=临时信息[n]+0
			 if 临时id~=id and  玩家数据[临时id] and 玩家数据[临时id].角色.地图数据.编号== 玩家数据[id].角色.地图数据.编号 and not self:取等级差二十(zgdj,玩家数据[临时id].角色.等级) then
			 	  local 通过=true
			    for nn=1,#队伍数据[id].成员数据 do
			    	if 队伍数据[id].成员数据[nn]==临时id then
			    		 通过=false
			    	end
			    end
			    if #队伍数据[id].成员数据>=5 then
			    	常规提示(id,"组队人数满了！")
			    	  通过=false
			    end
			     if 通过 then
	           地图处理类:跳转地图(临时id,玩家数据[id].角色.地图数据.编号,玩家数据[id].角色.地图数据.x/20,玩家数据[id].角色.地图数据.y/20)
	           队伍数据[id].成员数据[#队伍数据[id].成员数据+1]=临时id
	           玩家数据[临时id].队伍=id
           end
			 end
		end
			for n=1,#队伍数据[id].成员数据 do
					self:索取队伍信息(队伍数据[id].成员数据[n],4004)
			end
			常规提示(id,"请使用ALT+R分角色组队！")
  elseif 序号==4009 then
	if 玩家数据[id].队长==false then
	  常规提示(id,"只有队长才可进行此操作")
	  return
	elseif 玩家数据[id].角色.阵法[内容.名称]==nil then
	  常规提示(id,"您尚未学会如何使用该阵法")
	  return
	else
	  local 队伍id=玩家数据[id].队伍
	  队伍数据[队伍id].阵型=内容.名称
	  for n=1,#队伍数据[队伍id].成员数据 do
		self:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
	  end
	  常规提示(id,"更改阵型成功！")
	end
  elseif 序号==4010  then
	if 玩家数据[id].队长 then
	  	local 临时id=队伍数据[玩家数据[id].队伍].成员数据[内容.序列]
	  	if id==临时id then
			常规提示(id,"您不能将自己提升为队长")
			return
	  	else
			队伍数据[玩家数据[id].队伍].新队长.开关=true
			队伍数据[玩家数据[id].队伍].新队长.id=临时id
			self.发送数据={}
			self.发送数据.模型=玩家数据[id].角色.模型
			self.发送数据.名称=玩家数据[id].角色.名称
			self.发送数据.对话=玩家数据[id].角色.名称.."要把你提升为队长,你是否答应期要求?#94"
			self.发送数据.选项={"我同意当队长","我果断拒绝！"}
			发送数据(玩家数据[临时id].连接id,1501,self.发送数据)
	  	end
	else
	  	常规提示(id,"只有队长才可进行此操作")
	end
  elseif 序号==4011  then
	local 临时id=队伍数据[玩家数据[id].队伍].成员数据[内容.序列]
	if id==临时id then
		常规提示(id,"您不能查看自己!")
		return
	else
		local 查找数据=self:查找角色("",临时id)
		if 查找数据~=nil then
			发送数据(玩家数据[id].连接id,4015,查找数据)
			return
		else
			常规提示(id,"#Y这个角色并不存在或当前没有在线")
		end
	end
  	elseif 序号==4012 then --同意加入队伍
		if 玩家数据[id].队长 then
	  		if 内容.序列==nil or #内容.序列~=2 then
				常规提示(id,"错误数据!")
				return
	  		elseif 内容.序列[1]+0>内容.序列[2]+0 then
				常规提示(id,"最低等级不能比最高等级低噢!")
				return
	 		end
	 		if 内容.序列[2]+0>175 then
				内容.序列[2]=175
	  		end
	  		队伍数据[玩家数据[id].队伍].限制等级[1]=内容.序列[1]+0
	  		队伍数据[玩家数据[id].队伍].限制等级[2]=内容.序列[2]+0
	  		常规提示(id,"设置成功!")
		else
	  		常规提示(id,"只有队长才可进行此操作")
		end
	elseif 序号==4013 then
		if 玩家数据[id].队长 then
			self:调换位置(id,内容)
		else
	  		常规提示(id,"只有队长才可进行此操作")
		end
	elseif 序号==4014 then --对方没队伍的情况
		local 对方id = 内容.id+0
		if self:取等级差一百(玩家数据[id].角色.等级,玩家数据[对方id].角色.等级) then
			常规提示(id,"等级相差100禁止邀请组队")
			    return
		end
		if 玩家数据[id].队伍==0 then
		  队伍数据[id]={成员数据={[1]=id},申请数据={},阵型="普通",限制等级={0,175},新队长={开关=false,id=0}}
			玩家数据[id].队长=true
			玩家数据[id].队伍=id
			self:索取队伍信息(id,4004)
			发送数据(玩家数据[id].连接id,4006)
			地图处理类:更改队伍图标(id,true)
			常规提示(id,"组队成功，你现在是队长了。")
			常规提示(id,"你已邀请"..玩家数据[对方id].角色.名称.."加入队伍，请等待对方回应^^")
			发送数据(玩家数据[对方id].连接id,4018,{队长id=id,PK开关=玩家数据[id].角色.PK开关,等级=玩家数据[id].角色.等级,名称=玩家数据[id].角色.名称,模型=玩家数据[id].角色.模型,邀请id=id}) --发送邀请数据
		else
			if not 队伍数据[id] then
			    return
			end
			if 玩家数据[对方id].队伍~=0 then--自己和对方都有队伍
				常规提示(id,"对方已经有了一个队伍了")
			    return
			end
			for n=1,#队伍数据[id].成员数据 do
				if 队伍数据[id].成员数据[n]==对方id then
					return
				end
			end
			常规提示(id,"你已邀请"..玩家数据[对方id].角色.名称.."加入队伍，请等待对方回应^^")
			发送数据(玩家数据[对方id].连接id,4018,{队长id=玩家数据[id].队伍,PK开关=玩家数据[id].角色.PK开关,等级=玩家数据[id].角色.等级,名称=玩家数据[id].角色.名称,模型=玩家数据[id].角色.模型,邀请id=id}) --发送邀请数据
		end

	elseif 序号==4015 then --直接进组
		local 队伍id = 内容.队伍id+0
		local 邀请id = 内容.邀请id+0
		if 玩家数据[id].队伍~=0 then
			常规提示(id,"#Y/你已经有了一个队伍了")
			return
		end
		if 玩家数据[队伍id] then
			if 玩家数据[队伍id].队伍~=0 then
				for n=1,#队伍数据[队伍id].成员数据 do
					if 队伍数据[队伍id].成员数据[n]==id then
						return
					end
				end
				if 玩家数据[队伍id].zhandou~=0 then
					常规提示(id,"#Y/对方正在战斗中")
					return
				elseif 玩家数据[队伍id].摊位数据~=nil then
					常规提示(id,"#Y/对方目前无法加入队伍")
					return
				end
				local 角色xy={x=x,y=y}
				local 对方xy={x=0,y=0}
				对方xy.x,对方xy.y=玩家数据[队伍id].角色.地图数据.x,玩家数据[队伍id].角色.地图数据.y
				角色xy.x,角色xy.y=玩家数据[id].角色.地图数据.x,玩家数据[id].角色.地图数据.y
				if 取两点距离(对方xy,角色xy)>=500 then
					常规提示(id,"对方离你太远了~")
					return
				elseif #队伍数据[队伍id].成员数据>=5 then
					常规提示(id,"队伍人数已满！")
					return
				end
				发送数据(玩家数据[id].连接id,4011,队伍数据[队伍id].申请数据)
				发送数据(玩家数据[id].连接id,1001,{x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20)})
				local 地图编号=玩家数据[id].角色.地图数据.编号
				for i, v in pairs(地图处理类.地图玩家[地图编号]) do
					if i~=id and 玩家数据[i] then
						发送数据(玩家数据[i].连接id,1008,{数字id=id,路径={数字id=id,x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20)}})
					end
				end
				队伍数据[队伍id].成员数据[#队伍数据[队伍id].成员数据+1]=id
				玩家数据[id].队伍=队伍id
				-- 地图处理类:刷新玩家队伍(id,队伍id) --刷新的队伍，好进行选取
				玩家数据[id].队长=false
				if 玩家数据[邀请id] and 玩家数据[邀请id].队伍==队伍id then
				    常规提示(邀请id,"#R"..玩家数据[id].角色.名称.."#Y同意了你的邀请")
				end
				for n=1,#队伍数据[队伍id].成员数据 do
					self:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
				end
				self:同步飞行坐骑(队伍id,id)
				常规提示(id,"你已经被同意加入队伍")
			else
				常规提示(id,"该队伍已经解散了")
			      end
		    end
  	end
end

function 队伍处理类:调换位置(id,内容)
	if 队伍数据[玩家数据[id].队伍].成员数据 then
		if 队伍数据[玩家数据[id].队伍].成员数据[内容.序列] and 队伍数据[玩家数据[id].队伍].成员数据[内容.序列2] then
			local 临时数据 = 队伍数据[玩家数据[id].队伍].成员数据[内容.序列]
			local 临时数据2 = 队伍数据[玩家数据[id].队伍].成员数据[内容.序列2]
			队伍数据[玩家数据[id].队伍].成员数据[内容.序列] = 临时数据2
			队伍数据[玩家数据[id].队伍].成员数据[内容.序列2] = 临时数据
			for n=1,#队伍数据[玩家数据[id].队伍].成员数据 do
			  	self:索取队伍信息(队伍数据[玩家数据[id].队伍].成员数据[n],4004)
			end
		end
	end
end

function 队伍处理类:查找角色(名称,id)
  	local 数据组={}
	if id~="" then id=id+0 end
		for i, v in pairs(玩家数据) do
			if 玩家数据[i].角色.名称==名称 or i==id then
			  	数据组.名称=玩家数据[i].角色.名称
			  	数据组.等级=玩家数据[i].角色.等级
			  	数据组.门派=玩家数据[i].角色.门派
			  	数据组.称谓=玩家数据[i].角色.当前称谓
			  	数据组.模型=玩家数据[i].角色.模型
			  	数据组.帮派=玩家数据[i].角色.BPMC
			end
		end
	return 数据组
end

function 队伍处理类:退出队伍(id,重组)
	if 重组==nil or (重组~=nil and 重组~="关闭") then --剑会天下
	    剑会天下:离开队伍(id)
	end
	if 玩家数据[id].zhandou~=0 then
		return
	end
	local 队伍id=	玩家数据[id].队伍
	if 队伍id==0 or 队伍数据[队伍id]==nil then
		玩家数据[id].队伍=0
		return
	end
  if 玩家数据[id].队长 then
  	助战处理类:所有助战下线(id)
		if 重组==nil or (重组~=nil and 重组~="关闭") then
		  	广播队伍消息(队伍id,"本队伍已经被队长解散")
		end

		for n=1,#队伍数据[队伍id].成员数据 do
		  	if 玩家数据[队伍数据[队伍id].成员数据[n]]~=nil then
				玩家数据[队伍数据[队伍id].成员数据[n]].队伍=0
				发送数据(玩家数据[队伍数据[队伍id].成员数据[n]].连接id,4012)
		  	end
		end
		玩家数据[id].队长=false
		地图处理类:更改队伍图标(id,false)
		发送数据(玩家数据[id].连接id,4008)
  	else

		local 队员序列=0
		for n=1,#队伍数据[队伍id].成员数据 do
			if id==队伍数据[队伍id].成员数据[n] then
				队员序列=n
			end
		end

		广播队伍消息(队伍id,取名称(id).."离开了队伍")
		table.remove(队伍数据[玩家数据[id].队伍].成员数据,队员序列)
		玩家数据[id].队伍=0

		if 玩家数据[id].zhuzhan then
			助战处理类:单个助战下线(id)
		else
			发送数据(玩家数据[id].连接id,4012)
		end
		-- 发送数据(玩家数据[id].连接id,4012)
		for n=1,#队伍数据[队伍id].成员数据 do
		  	self:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
		end
  	end
end

function 队伍处理类:取等级差二十(dj1,dj2)
	if dj1 - dj2 >= 20 or dj2 - dj1 >= 20 then
		return true
	end
	return false
end
function 队伍处理类:取等级差四十(dj1,dj2)
	if dj1 - dj2 >= 40 or dj2 - dj1 >= 40 then
		return true
	end
	return false
end
function 队伍处理类:取等级差六十(dj1,dj2)
	if dj1 - dj2 >= 60 or dj2 - dj1 >= 60 then
		return true
	end
	return false
end
function 队伍处理类:取等级差八十(dj1,dj2)
	if dj1 - dj2 >= 80 or dj2 - dj1 >= 80 then
		return true
	end
	return false
end
function 队伍处理类:取等级差一百(dj1,dj2)
	if dj1 - dj2 >= 100 or dj2 - dj1 >= 100 then
		return true
	end
	return false
end
function 队伍处理类:取等级差176(dj1,dj2)
	if dj1 - dj2 >= 176 or dj2 - dj1 >= 176 then
		return true
	end
	return false
end

function 队伍处理类:同意入队(id,内容,重组)
	if not 队伍数据[玩家数据[id].队伍].申请数据[内容.序列] then
		return
	end
	local 对方id=队伍数据[玩家数据[id].队伍].申请数据[内容.序列].id
	local 是否清除=false
	local 队伍id=	玩家数据[id].队伍
	----------------------剑会天下
	if 玩家数据[id].角色.地图数据.编号 == 6135 or 玩家数据[id].角色.地图数据.编号 == 6136 then
		if 剑会天下:等级段不相符(id,对方id) then
			常规提示(id,"#Y/剑会中禁止加入等级段不相符的队员")
		  return
		end
	end
	----------------------
	local zgdj = 取队伍最高等级数(队伍id,id)
	if self:取等级差176(zgdj,玩家数据[对方id].角色.等级) then
		常规提示(id,"#Y/等级相差175禁止组队！！！")
		  return
	end
	----------------------
	if 玩家数据[对方id]==nil then
		常规提示(id,"#Y/这个玩家当前不在线")
		是否清除=true
	elseif 玩家数据[对方id].队伍~=0 then
		常规提示(id,"#Y/对方已经加入了其它队伍")
		是否清除=true
	elseif 玩家数据[对方id].zhandou~=0 then
		常规提示(id,"#Y/对方正在战斗中")
		return
	elseif 玩家数据[对方id].摊位数据~=nil then
		常规提示(id,"#Y/对方目前无法加入队伍")
		是否清除=true
	end
	for n=1,#队伍数据[队伍id].成员数据 do
		if 队伍数据[队伍id].成员数据[n]==对方id then
			常规提示(id,"#Y/对方已经在队伍中了")
			是否清除=true
		end
	end
	if 是否清除 then
		table.remove(队伍数据[玩家数据[id].队伍].申请数据,内容.序列)
		发送数据(玩家数据[id].连接id,4011,队伍数据[队伍id].申请数据)
		return
	end
	local 角色xy={x=x,y=y}
	local 对方xy={x=0,y=0}
	对方xy.x,对方xy.y=玩家数据[对方id].角色.地图数据.x,玩家数据[对方id].角色.地图数据.y
	角色xy.x,角色xy.y=玩家数据[id].角色.地图数据.x,玩家数据[id].角色.地图数据.y
	if 取两点距离(对方xy,角色xy)>=500 then
		常规提示(id,"对方离你太远了~")
		return
	elseif #队伍数据[队伍id].成员数据>=5 then
		常规提示(id,"队伍人数已满！")
		return
	end
	table.remove(队伍数据[玩家数据[id].队伍].申请数据,内容.序列)
	发送数据(玩家数据[id].连接id,4011,队伍数据[队伍id].申请数据)
	发送数据(玩家数据[对方id].连接id,1001,{x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20),})
	local 地图编号=玩家数据[id].角色.地图数据.编号
	for i, v in pairs(地图处理类.地图玩家[地图编号]) do
		if i~=对方id and 玩家数据[i] then
			发送数据(玩家数据[i].连接id,1008,{数字id=对方id,路径={数字id=对方id,x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20),}})
		end
	end
	队伍数据[队伍id].成员数据[#队伍数据[队伍id].成员数据+1]=对方id
	玩家数据[对方id].队伍=队伍id
	-- 地图处理类:刷新玩家队伍(对方id,队伍id) --刷新的队伍，好进行选取
	玩家数据[对方id].队长=false
	if 重组==nil or (重组~=nil and 重组~="关闭") then
		剑会天下:同意入队(id,对方id) --麻瓜剑会
		广播队伍消息(队伍id,取名称(对方id).."加入了队伍")
	end
	for n=1,#队伍数据[队伍id].成员数据 do
		self:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
	end
	常规提示(id,"已加入队伍")
	self:同步飞行坐骑(队伍id,id)
end

function 队伍处理类:同意假人入队(id,内容)----假人带队 暂时封存
	local 对方id=内容.数字id
	local 是否清除=false
	local 队伍id=	玩家数据[id].队伍
	local 角色xy={x=x,y=y}
	local 对方xy={x=0,y=0}
	对方xy.x,对方xy.y=玩家数据[对方id].角色.地图数据.x,玩家数据[对方id].角色.地图数据.y
	角色xy.x,角色xy.y=玩家数据[id].角色.地图数据.x,玩家数据[id].角色.地图数据.y

	if #队伍数据[队伍id].成员数据>=5 then
		常规提示(id,"队伍人数已满！")
		return
	end
	发送数据(玩家数据[对方id].连接id,1001,{x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20),})
	local 地图编号=玩家数据[id].角色.地图数据.编号
	for i, v in pairs(地图处理类.地图玩家[地图编号]) do
		if i~=对方id and 玩家数据[i] then
			发送数据(玩家数据[i].连接id,1008,{数字id=对方id,路径={数字id=对方id,x=math.floor(角色xy.x/20),距离=#队伍数据[队伍id].成员数据*地图处理类.队伍距离,y=math.floor(角色xy.y/20),}})
		end
	end
	队伍数据[队伍id].成员数据[#队伍数据[队伍id].成员数据+1]=对方id
	玩家数据[对方id].队伍=队伍id
	-- 地图处理类:刷新玩家队伍(对方id,队伍id) --刷新的队伍，好进行选取
	玩家数据[对方id].队长=false
	if 重组==nil or (重组~=nil and 重组~="关闭") then
		剑会天下:同意入队(id,对方id) --麻瓜剑会
		广播队伍消息(队伍id,取名称(对方id).."加入了队伍")
	end
	for n=1,#队伍数据[队伍id].成员数据 do
		self:索取队伍信息(队伍数据[队伍id].成员数据[n],4004)
	end
	常规提示(id,"对方已加入队伍")
	self:同步飞行坐骑(队伍id,id)
end


function 队伍处理类:同步飞行坐骑(队伍id,id)
	local 同步队长=玩家数据[队伍id].角色.飞行中
	local 是否有坐骑 = true
	for i=1,#队伍数据[队伍id].成员数据 do
		if 同步队长 and 玩家数据[队伍数据[队伍id].成员数据[i]].角色.坐骑==nil then --队员没坐骑的情况
			是否有坐骑=false
			break
		end
	end

	if 同步队长 then --队长是否飞行的情况
		if 是否有坐骑==false then --但是某队友没坐骑
			for i=1,#队伍数据[队伍id].成员数据 do
				if 玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中 then
					玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中=nil
					常规提示(队伍数据[队伍id].成员数据[i],"#Y/你落地了...")
				end
				地图处理类:玩家是否飞行(队伍数据[队伍id].成员数据[i],false)
			end
		else
			for i=1,#队伍数据[队伍id].成员数据 do
				if 玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中==nil then
					玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中=true
					常规提示(队伍数据[队伍id].成员数据[i],"#Y/你飞了起来...")
				end
				地图处理类:玩家是否飞行(队伍数据[队伍id].成员数据[i],true)
			end
		end
	else --队长没飞的情况
		for i=1,#队伍数据[队伍id].成员数据 do
			if 玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中 then
				玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中=nil
				常规提示(队伍数据[队伍id].成员数据[i],"#Y/你落地了...")
			end
			地图处理类:玩家是否飞行(队伍数据[队伍id].成员数据[i],false)
		end
	end
end



function 队伍处理类:同步飞行坐骑(队伍id,id)
	local 同步队长=玩家数据[队伍id].角色.飞行中
	local 是否有坐骑 = true
	for i=1,#队伍数据[队伍id].成员数据 do
		if 同步队长 and 玩家数据[队伍数据[队伍id].成员数据[i]].角色.坐骑==nil then --队员没坐骑的情况
			是否有坐骑=false
			break
		end
	end

	if 同步队长 then --队长是否飞行的情况
		if 是否有坐骑==false then --但是某队友没坐骑
			for i=1,#队伍数据[队伍id].成员数据 do
				if 玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中 then
					玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中=nil
					常规提示(队伍数据[队伍id].成员数据[i],"#Y/你落地了...")
				end
				地图处理类:玩家是否飞行(队伍数据[队伍id].成员数据[i],false)
			end
		else
			for i=1,#队伍数据[队伍id].成员数据 do
				if 玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中==nil then
					玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中=true
					常规提示(队伍数据[队伍id].成员数据[i],"#Y/你飞了起来...")
				end
				地图处理类:玩家是否飞行(队伍数据[队伍id].成员数据[i],true)
			end
		end
	else --队长没飞的情况
		for i=1,#队伍数据[队伍id].成员数据 do
			if 玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中 then
				玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中=nil
				常规提示(队伍数据[队伍id].成员数据[i],"#Y/你落地了...")
			end
			地图处理类:玩家是否飞行(队伍数据[队伍id].成员数据[i],false)
		end
	end
end




function 队伍处理类:取队伍飞行(队伍id,id)
	if 队伍数据[队伍id]==nil then
		return
	end
	--下面如果检测到队友没有飞行坐骑的时候,且队伍在飞行中,应该取消飞行状态
	for n=1,#队伍数据[队伍id].成员数据 do
		if 玩家数据[队伍数据[队伍id].成员数据[n]].角色.坐骑==nil then
			-- 常规提示(id,"#Y起飞失败，队伍中#R"..玩家数据[队伍数据[队伍id].成员数据[n]].角色.名称.."#Y没有骑乘坐骑...")
			-- return
		end
	end
	local 队长飞行=玩家数据[id].角色.飞行中
	if 取飞行坐骑限制(id) then
		for i=1,#队伍数据[队伍id].成员数据 do
			if 队长飞行 then --队长飞行的时候降落
			    if 玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中 then
			    	玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中=nil
					常规提示(队伍数据[队伍id].成员数据[i],"#Y/你落地了...")
			    end
			else --队长没飞的时候起飞
				玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中=true
				常规提示(队伍数据[队伍id].成员数据[i],"#Y/你飞了起来...")
			end

			地图处理类:玩家是否飞行(队伍数据[队伍id].成员数据[i],玩家数据[队伍数据[队伍id].成员数据[i]].角色.飞行中)
		end
	end
end

function 队伍处理类:索取申请信息(连接id,id)
	if 玩家数据[id].队长~=true then
		常规提示(id,"只有队长才可以查看申请列表哟~")
		return 0
	else
		local 队伍id=玩家数据[id].队伍
		发送数据(玩家数据[id].连接id,4010,队伍数据[队伍id].申请数据)
	end
end

function 队伍处理类:新任队长(原来id,玩家id)
  local xl临时队伍成员id = {}
  for n=1,#队伍数据[原来id].成员数据 do
	if 队伍数据[原来id].成员数据[n]~=nil then
	  if 原来id == 队伍数据[原来id].成员数据[n] then
		xl临时队伍成员id[n] = 玩家id
	  elseif 玩家id == 队伍数据[原来id].成员数据[n] then
		xl临时队伍成员id[n] = 原来id
	  else
		xl临时队伍成员id[n] = 队伍数据[原来id].成员数据[n]
	  end
	end
  end
  self:退出队伍(原来id,"关闭")--清除原来队伍
  玩家数据[原来id].队长=false
  玩家数据[原来id].队伍=0
  地图处理类:更改队伍图标(原来id,false)
  --==========
  local x内容 = {id=玩家id}--创建队伍
  self:创建队伍(玩家id,x内容,"关闭")
  for i=1,#xl临时队伍成员id do
	if xl临时队伍成员id[i]~=玩家id then
	  x内容 = {id=玩家id}--原队人申请队伍
	  self:创建队伍(xl临时队伍成员id[i],x内容,"关闭")
	  --==============
	  x内容 = {序列=1}--同意进队
	  self:同意入队(玩家id,x内容,"关闭")
	end
  end
  剑会天下:新任队长(原来id,玩家id) --剑会天下
  xl临时队伍成员id = {}
end

function 队伍处理类:创建队伍(id,内容,重组)
	local 创建id=内容.id+0
	if id==创建id then -- 自己创建队伍
		if 玩家数据[id].队伍==0 then
			队伍数据[id]={成员数据={[1]=id},申请数据={},阵型="普通",限制等级={0,175},新队长={开关=false,id=0}}
			玩家数据[id].队长=true
			玩家数据[id].队伍=id
			self:索取队伍信息(id,4004)
			发送数据(玩家数据[id].连接id,4006)
			地图处理类:更改队伍图标(id,true)
			if 重组==nil or (重组~=nil and 重组~="关闭") then
				常规提示(id,"组队成功，你现在是队长了！")
			end
		else
			常规提示(id,"你已经有一个队伍了")
			return 0
		end
	else
		if 玩家数据[创建id].队伍==0 then
			常规提示(id,"对方不在队伍中！")
			return 0
		else
			local 申请id= 玩家数据[创建id].队伍
			if 玩家数据[id].角色.等级<队伍数据[申请id].限制等级[1] or 玩家数据[id].角色.等级>队伍数据[申请id].限制等级[2] then
				常规提示(id,"你的等级不满对方的要求！")
				return 0
			end
			if #队伍数据[申请id].成员数据>=5 then
				常规提示(id,"对方队伍已满员！")
				return 0
			elseif #队伍数据[申请id].申请数据>=5 then
				常规提示(id,"对方申请名单已经满了~请过一会儿再试")
				return 0
			else
				--self.重复申请=false
				for n=1,#队伍数据[申请id].申请数据 do
					if 队伍数据[申请id].申请数据[n]~=nil and 队伍数据[申请id].申请数据[n].id~=nil and 队伍数据[申请id].申请数据[n].id ==id   then
						常规提示(id,"你已经在对方的申请名单中了，请勿重复申请")
						return 0
					end
				end
				local 申请位置s = #队伍数据[申请id].申请数据+1
				队伍数据[申请id].申请数据[申请位置s]=table.loadstring(table.tostring(玩家数据[id].角色:取队伍信息(id)))
				队伍数据[申请id].申请数据[申请位置s].id =id
				if 重组==nil or (重组~=nil and 重组~="关闭") then
					常规提示(id,"入队申请提交成功，请耐心等候~")
					常规提示(申请id,玩家数据[id].角色.名称.."申请加入你的队伍，请尽快处理！")
				end
				发送数据(玩家数据[申请id].连接id,4011,队伍数据[申请id].申请数据)
			end
		end
	end
end

function 队伍处理类:索取队伍信息(id,序号)
	local 队伍id=玩家数据[id].队伍
	local 发送信息={}
	if 队伍数据[队伍id]== nil then return  end
	for n=1,#队伍数据[队伍id].成员数据 do
		发送信息[#发送信息+1]=玩家数据[队伍数据[队伍id].成员数据[n]].角色:取队伍信息()
	 end
	发送信息.阵型=队伍数据[队伍id].阵型
	发送信息.限制等级=队伍数据[队伍id].限制等级
	发送数据(玩家数据[id].连接id,序号,发送信息)
end
function 队伍处理类:取队伍成员(id)
	local 队伍id=玩家数据[id].队伍
	local 发送信息={}
	if 队伍数据[队伍id]== nil then return false  end
	for n=1,#队伍数据[队伍id].成员数据 do
		发送信息[队伍数据[队伍id].成员数据[n]]=true
	end
	return 发送信息
end

function 队伍处理类:扣除队伍成员银子(id,数额)
	local 队伍id=玩家数据[id].队伍
	if 队伍数据[队伍id]== nil then return false  end
	local 允许执行 = true
	for n=1,#队伍数据[队伍id].成员数据 do
		local 数字id = 队伍数据[队伍id].成员数据[n]
		if 玩家数据[数字id].角色.银子 <  数额 then
			允许执行= false
		end
	end
	if 允许执行 then
		for n=1,#队伍数据[队伍id].成员数据 do
			local 数字id = 队伍数据[队伍id].成员数据[n]
			玩家数据[数字id].角色:扣除银子(数额, 0, 0, "五级镖银")
		end
	end
	return  允许执行
end

function 队伍处理类:扣除队伍成员道具(id,名称,数量)
	local 队伍id=玩家数据[id].队伍
	if 队伍数据[队伍id]== nil then return false  end
	local 允许执行 = true
	for n=1,#队伍数据[队伍id].成员数据 do
		local 数字id = 队伍数据[队伍id].成员数据[n]
		if not 玩家数据[数字id].道具:判定背包道具(数字id,名称,数量) then
			允许执行= false
		end
	end
	if 允许执行 then
		for n=1,#队伍数据[队伍id].成员数据 do
			local 数字id = 队伍数据[队伍id].成员数据[n]
			玩家数据[数字id].道具:消耗背包道具(玩家数据[数字id].连接id,数字id,名称,数量)
		end
	end
	return  允许执行
end

function 队伍处理类:删除队伍成员道具(id,名称)
	local 队伍id=玩家数据[id].队伍
	if 队伍数据[队伍id]== nil then return false  end
	local 允许执行 = true
	for n=1,#队伍数据[队伍id].成员数据 do
		local 数字id = 队伍数据[队伍id].成员数据[n]
		if not 玩家数据[数字id].道具:判定背包道具(数字id,名称,数量) then
			允许执行= false
		end
	end
	if 允许执行 then
	end
	return  允许执行
end


--助战
function 队伍处理类:助战进组(主号id,助战id)
	if 玩家数据[主号id].队伍==0 then
		队伍数据[主号id]={成员数据={[1]=主号id},申请数据={},阵型="普通",限制等级={0,175},新队长={开关=false,id=0}}
		玩家数据[主号id].队长=true
		玩家数据[主号id].队伍=主号id

		self:索取队伍信息(主号id,4004)
		发送数据(玩家数据[主号id].连接id,4006)
		地图处理类:更改队伍图标(主号id,true)
		常规提示(主号id,"组队成功,你现在是队长了。")
	elseif not 玩家数据[主号id].队长 then
		常规提示(主号id,"#Y/只有队长才以这种方式邀请小号进队！")
		return
	end
	local 队伍id = 玩家数据[主号id].队伍
	if #队伍数据[队伍id].成员数据>=5 then
		常规提示(主号id,"队伍人数已满！")
		return
	end
	队伍数据[队伍id].成员数据[#队伍数据[队伍id].成员数据+1]=助战id
	玩家数据[助战id].队伍=队伍id
	玩家数据[助战id].队长=false
	剑会天下:同意入队(主号id,助战id) --剑会天下
	常规提示(主号id,"#G"..玩家数据[助战id].角色.名称.."#Y加入了队伍")
	广播队伍消息(队伍id,玩家数据[助战id].角色.名称.."加入了队伍")
	for n=1,#队伍数据[主号id].成员数据 do
		local dyid=队伍数据[主号id].成员数据[n]
		if not 玩家数据[dyid].zhuzhan then
			self:索取队伍信息(dyid,4017)
		end
	end
	self:同步飞行坐骑(队伍id,id)
end
-- 队伍处理类:发起助战组队邀请(数字id,助战id,助战编号)
function 队伍处理类:发起助战组队邀请(id,对方id,助战编号)
	if 玩家数据[id].队伍==0 then
		队伍数据[id]={成员数据={[1]=id},申请数据={},阵型="普通",限制等级={0,175},新队长={开关=false,id=0}}
		玩家数据[id].队长=true
		玩家数据[id].队伍=id
		self:索取队伍信息(id,4004)
		发送数据(玩家数据[id].连接id,4006)
		地图处理类:更改队伍图标(id,true)
		常规提示(id,"组队成功，你现在是队长了。")
		常规提示(id,"你已邀请"..玩家数据[对方id].角色.名称.."加入队伍，请等待对方回应^^")
		发送数据(玩家数据[对方id].连接id,4018,{队长id=id,助战编号=助战编号,PK开关=玩家数据[id].角色.PK开关,等级=玩家数据[id].角色.等级,名称=玩家数据[id].角色.名称,模型=玩家数据[id].角色.模型,邀请id=id}) --发送邀请数据
	else
		if not 队伍数据[id] or 玩家数据[id].队伍~=id then
			常规提示(id,"只有队长才能进行此操作！")
			return
		end
		if 玩家数据[对方id].队伍~=0 then--自己和对方都有队伍
			常规提示(id,"对方已经有了一个队伍了")
			return
		end
		for n=1,#队伍数据[id].成员数据 do
			if 队伍数据[id].成员数据[n]==对方id then
				return
			end
		end
		常规提示(id,"你已邀请"..玩家数据[对方id].角色.名称.."加入队伍，请等待对方回应^^")
		发送数据(玩家数据[对方id].连接id,4018,{队长id=玩家数据[id].队伍,助战编号=助战编号,PK开关=玩家数据[id].角色.PK开关,等级=玩家数据[id].角色.等级,名称=玩家数据[id].角色.名称,模型=玩家数据[id].角色.模型,邀请id=id}) --发送邀请数据
	end
end

function 队伍处理类:助战切换队长(老队长,新队长)
	local xl临时队伍成员id = {}
	for n=1,#队伍数据[老队长].成员数据 do
		if 队伍数据[老队长].成员数据[n]~=nil then
			if 老队长 == 队伍数据[老队长].成员数据[n] then
				xl临时队伍成员id[n] = 新队长
			elseif 新队长 == 队伍数据[老队长].成员数据[n] then
				xl临时队伍成员id[n] = 老队长
			else
				xl临时队伍成员id[n] = 队伍数据[老队长].成员数据[n]
			end
		end
	end
	队伍数据[新队长]={成员数据={[1]=新队长},申请数据={},阵型="普通",限制等级={0,175},新队长={开关=false,id=0}}
	玩家数据[新队长].队长=true
	玩家数据[新队长].队伍=新队长
	发送数据(玩家数据[新队长].连接id,4006)
	地图处理类:更改队伍图标1(新队长,true,老队长)
	------------
	for i=2,#xl临时队伍成员id do
		队伍数据[新队长].成员数据[i]=xl临时队伍成员id[i]
		玩家数据[xl临时队伍成员id[i]].队伍=新队长
	end
	for n=1,#队伍数据[新队长].成员数据 do
		self:索取队伍信息(队伍数据[新队长].成员数据[n],4004)
	end
	玩家数据[老队长].队长=false
	地图处理类:更改队伍图标1(老队长,false,新队长)
	队伍数据[老队长]=nil
end

function 队伍处理类:更新(dt)end
function 队伍处理类:显示(x,y)end

return 队伍处理类