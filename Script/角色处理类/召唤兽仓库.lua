local 召唤兽仓库类 = class()

function 召唤兽仓库类:初始化(id,数字id)
	self.玩家id=数字id
	self.数据={}
end
function 召唤兽仓库类:数据处理(连接id,序号,数字id,数据)
	if 序号==6801 then --打开宝宝仓库信息
		发送数据(连接id,3526,{召唤兽仓库总数=#self.数据,召唤兽仓库数据=self.数据[1]})
		发送数据(连接id,3534,{宝宝列表=玩家数据[数字id].召唤兽.数据})
	elseif 序号==6802 then
		self:仓库存取(连接id,数字id,数据)
	elseif 序号==6803 then
		if 数据.序列 > #self.数据 then
			常规提示(数字id,"#Y/这已经是最后一页了")
			return
		elseif 数据.序列<1 then
			return
		end
		发送数据(连接id,3524,{召唤兽仓库数据=self.数据[数据.序列],页数=数据.序列,宝宝列表=玩家数据[数字id].召唤兽.数据})
	elseif 序号==6804 then
		if #self.数据 >=5 then 常规提示(数字id,"最多只能购买5个召唤兽仓库！") return end
		local yzi = (#self.数据-1)*1000000+1000000
		if 玩家数据[数字id].角色:扣除银子(yzi,0,0,"购买宝宝仓库",1) then
			self.数据[#self.数据+1]={}
			常规提示(数字id,"购买召唤兽仓库成功！")
			发送数据(连接id,3526,{召唤兽仓库总数=#self.数据,召唤兽仓库数据=self.数据[1]})
		else
			常规提示(数字id,"#R少侠你这银子也不够呀")
		end
	end
end

function 召唤兽仓库类:加载数据(账号,数字id)
	if f函数.文件是否存在(程序目录..[[data/]]..账号..[[/]]..数字id..[[/宝宝仓库.txt]])==false then
		self.数据 = {[1]={}}
		写出文件([[data/]]..账号..[[/]]..数字id.."/宝宝仓库.txt",table.tostring(self.数据))
	else
		self.数据=table.loadstring(读入文件(程序目录..[[data/]]..账号..[[/]]..数字id..[[/宝宝仓库.txt]]))
	end
end

function 召唤兽仓库类:仓库存取(连接id,数字id,内容)
	if 玩家数据[数字id].摊位数据~=nil then
		常规提示(数字id,"#Y/摆摊中无法操作仓库。")
		return
	end
	local 类型 = 内容.类型
	local 页数 = 内容.页数
	local 认证码 = 内容.认证码
	if #self.数据 < 页数 or 页数<1 then
		常规提示(数字id,"#Y/数据异常，请重新打开仓库。")
		return
	end
	if 类型 == "存" then
		if 玩家数据[数字id].角色.参战宝宝.认证码 == 认证码 then
			常规提示(数字id,"参战召唤兽无法存入仓库")
			return
		end
		if #self.数据[页数]~=nil and #self.数据[页数] >=7 then
			常规提示(数字id,"#Y/一个仓库只能存放7只召唤兽。")
			return
		end
		local 是否存在 = false
		local bianh = nil
		for k,v in pairs(玩家数据[数字id].召唤兽.数据) do
			if 认证码 == v.认证码 then
				是否存在 = true
				bianh = k
			end
		end
		if 是否存在 and bianh~=nil then
			local bb=table.copy(玩家数据[数字id].召唤兽.数据[bianh])
			table.insert(self.数据[页数],bb)
			玩家数据[数字id].角色:日志记录(format("[召唤兽系统-仓库存取]存入角色ID[%s]召唤兽认证码[%s]",数字id,bb.认证码))
			table.remove(玩家数据[数字id].召唤兽.数据,bianh)
			发送数据(连接id,3524,{召唤兽仓库数据=self.数据[页数],页数=页数})
			发送数据(连接id,3534,{宝宝列表=玩家数据[数字id].召唤兽.数据})
		end
	elseif 类型 =="取" then
		if 玩家数据[数字id].角色:取新增宝宝数量() then
			local 是否存在 = false
			local bianh = nil
			for k,v in pairs(self.数据[页数]) do
				if 认证码 == v.认证码 then
					是否存在 = true
					bianh = k
				end
			end
			if 是否存在 and bianh~=nil then
				local 宝宝=宝宝类.创建()
				宝宝:加载数据(self.数据[页数][bianh])
				table.insert(玩家数据[数字id].召唤兽.数据,宝宝)
				玩家数据[数字id].角色:日志记录(format("[召唤兽系统-仓库存取]取出角色ID[%s]召唤兽认证码[%s]",数字id,self.数据[页数][bianh].认证码))
				table.remove(self.数据[页数],bianh)
				发送数据(连接id,3524,{召唤兽仓库数据=self.数据[页数],页数=页数})
				发送数据(连接id,3534,{宝宝列表=玩家数据[数字id].召唤兽.数据})
			end
		else
			常规提示(id,"携带召唤兽数量达到上限")
		end
	end
end



function 召唤兽仓库类:更新(dt) end

function 召唤兽仓库类:显示(x,y) end

return 召唤兽仓库类