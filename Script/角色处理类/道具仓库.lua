-- @Author: baidwwy
-- @Date:   2023-08-31 23:34:34
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-03 08:41:21
local 道具仓库类 = class()

function 道具仓库类:初始化(id,数字id)
	self.玩家id=数字id
	self.数据={}
end
function 道具仓库类:数据处理(连接id,序号,数字id,数据)
	if 序号==6701 then --索取仓库信息
		发送数据(连接id,3513,玩家数据[数字id].道具:索要道具2(数字id)) --右侧道具栏
		发送数据(连接id,3523,{道具=self:索要仓库道具(数字id,1),道具仓库总数=#self.数据,召唤兽仓库总数=#宝宝仓库数据[数字id].召唤兽.数据})
	elseif 序号==6702 then
		self:仓库存放事件(连接id,数字id,数据)
	elseif 序号==6703 then
		self:仓库取走事件(连接id,数字id,数据)
	elseif 序号==6704 then
    	if #self.数据 >=47 then 常规提示(数字id,"最多只能购买47个仓库！") return end
		local yzi = (#self.数据-3)*100000+300000
		if 玩家数据[数字id].角色:扣除银子(yzi,0,0,"购买仓库",1) then
			self.数据[#self.数据+1]={}
			常规提示(数字id,"购买仓库成功！")
			发送数据(连接id,3533,{道具=self:索要仓库道具(数字id,1),总数=#self.数据})
		else
			常规提示(数字id,"#R少侠你这银子也不够呀")
		end
	elseif 序号==6705 then
		if 数据.序列>#self.数据 then
			常规提示(数字id,"#Y/这已经是最后一页了")
			return
		elseif 数据.序列<1 then
			return
		end
		发送数据(连接id,3524,{道具=self:索要仓库道具(数字id,数据.序列),页数=数据.序列})
	elseif 序号==6706 then
		self:仓库整理事件(连接id,数字id,数据)
	end
end

function 道具仓库类:加载数据(账号,数字id)
	if f函数.文件是否存在(程序目录..[[data/]]..账号..[[/]]..数字id..[[/道具仓库.txt]])==false then
		self.数据 = {[1]={},[2]={},[3]={}}
		写出文件([[data/]]..账号..[[/]]..数字id.."/道具仓库.txt",table.tostring(self.数据))
	else
	    self.数据=table.loadstring(读入文件(程序目录..[[data/]]..账号..[[/]]..数字id..[[/道具仓库.txt]]))
	end
end
function 道具仓库类:仓库整理事件(连接id,id,数据)---:整理xxxxxxx 4处整理
	if 玩家数据[id].摊位数据~=nil then
		常规提示(id,"#Y/摆摊中无法操作仓库。")
		return
	end
	local 页数=数据.页数
	local data = {}
	local 计数 = 0
  local function 简易排序(a,b)
    return 排序整理(a.序号)<排序整理(b.序号)
  end
	for k,v in  pairs (self.数据[页数]) do
      -- local 字符编码=string.byte(string.sub(v.名称,1,2))
      -- 字符编码=字符编码+string.byte(string.sub(v.名称,3,4))
      -- 字符编码=字符编码+#v.名称
      -- 字符编码=字符编码+0
      data[#data+1]={内容=v,序号=v.名称}
      if v.数量~=nil and v.数量<999 and v.可叠加 then
      		for i,n in pairs (self.数据[页数]) do
	          if k~=i and  n ~= nil and v ~= nil and  n.名称==v.名称 and n.数量~=nil  and v.数量+n.数量<999  then
	          	if (n.名称== "初级清灵仙露"  and v.名称 =="初级清灵仙露") or (n.名称== "中级清灵仙露"  and v.名称 =="中级清灵仙露") or (n.名称== "高级清灵仙露"  and v.名称 =="高级清灵仙露") or (n.名称== "高级摄灵珠"  and v.名称 =="高级摄灵珠") then
	          		if v.灵气 == n.灵气 then
		          	 self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
		             self.数据[页数][i]=nil
	          		end
			        elseif n.名称== "钨金"  and v.名称 =="钨金" then
 							 	  if v.级别限制 == n.级别限制 then
		          	 self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
		             self.数据[页数][i]=nil
			            end
---------------------------------------------------------------------------------------------------------------------------
				elseif n.名称 == "黑宝石" and v.名称 == "黑宝石" then
              if v.等级 == n.等级  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end
        elseif n.名称 == "月亮石" and v.名称 == "月亮石" then
              if v.等级 == n.等级  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end

        elseif n.名称 == "红玛瑙" and v.名称 == "红玛瑙" then
              if v.等级 == n.等级  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end

        elseif n.名称 == "舍利子" and v.名称 == "舍利子" then
              if v.等级 == n.等级  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end

        elseif n.名称 == "太阳石" and v.名称 == "太阳石" then
              if v.等级 == n.等级  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end
        elseif n.名称 == "光芒石" and v.名称 == "光芒石" then
              if v.等级 == n.等级  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end
        elseif n.名称 == "速度精魄灵石" and v.名称 == "速度精魄灵石" then
              if v.等级 == n.等级  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end
        elseif n.名称 == "气血精魄灵石" and v.名称 == "气血精魄灵石" then
              if v.等级 == n.等级  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end

        elseif n.名称 == "灵力精魄灵石" and v.名称 == "灵力精魄灵石" then
              if v.等级 == n.等级  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end
        elseif n.名称 == "躲避精魄灵石" and v.名称 == "躲避精魄灵石" then
              if v.等级 == n.等级  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end
        elseif n.名称 == "防御精魄灵石" and v.名称 == "防御精魄灵石" then
              if v.等级 == n.等级  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end
        elseif n.名称 == "伤害精魄灵石" and v.名称 == "伤害精魄灵石" then
              if v.等级 == n.等级  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end
        elseif n.名称 == "星辉石" and v.名称 == "星辉石" then
              if v.等级 == n.等级  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end

          elseif n.名称 == "钟灵石" and v.名称 == "钟灵石" then
              if v.技能 == n.技能  and self.数据[页数][k].等级 == n.等级 then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end
          elseif n.名称 == "钨金" and v.名称 == "钨金" then
              if v.等级 == n.等级  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end
          elseif n.名称 == "附魔宝珠" and v.名称 == "附魔宝珠" then
              if v.等级 == n.等级  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end
          elseif  n.名称 == "魔兽要诀" and v.名称 == "魔兽要诀" then
                if v.附带技能 == n.附带技能  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end
          elseif  n.名称 == "高级魔兽要诀" and v.名称 == "高级魔兽要诀" then
              if v.附带技能 == n.附带技能  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end
          elseif  n.名称 == "特殊魔兽要诀" and v.名称 == "特殊魔兽要诀" then
              if v.附带技能 == n.附带技能  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end
          elseif  n.名称 == "超级魔兽要诀" and v.名称 == "超级魔兽要诀" then
              if v.附带技能 == n.附带技能  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end
          elseif  n.名称 == "召唤兽内丹" and v.名称 == "召唤兽内丹" then
              if v.特效 == n.特效  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end
          elseif  n.名称 == "高级召唤兽内丹" and v.名称 == "高级召唤兽内丹" then
              if v.特效 == n.特效  then
                self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
                self.数据[页数][i]=nil
              end
 --------------------------------------------------------------------------------------------------
	          	else
		          	 self.数据[页数][k].数量=self.数据[页数][k].数量+self.数据[页数][i].数量
		             self.数据[页数][i]=nil
		          end
	          end
      		end
      end
		-- 计数=计数+1
		-- 背包重新排序[计数]=c
	end
    table.sort(data,简易排序)
    local tabdata={}
    for k,v in pairs(data) do
      tabdata[#tabdata+1]=v.内容
    end
   -- 玩家数据[id].角色.道具 = tabdata



	self.数据[页数]=tabdata
	道具刷新(id)
	发送数据(连接id,3524,{道具=self:索要仓库道具(id,数据.页数),页数=数据.页数})

	if 类型 == "道具" then
		发送数据(连接id,3535,{类型="道具",数据=玩家数据[id].道具:索要道具2(id)})
	elseif 类型 == "行囊" then
		发送数据(连接id,3535,{类型="行囊",数据=玩家数据[id].道具:索要行囊2(id)})
	end
end
function 道具仓库类:仓库存放事件(连接id,id,数据)
	if 玩家数据[id].摊位数据~=nil then
		常规提示(id,"#Y/摆摊中无法操作仓库。")
		return
	end
	local 页数=数据.页数
	local 道具=数据.物品
	local 格子=0
	local 类型=数据.类型
	for n=1,20 do
		if self.数据[页数][n]==nil and 格子==0 then
			格子=n
			break
		end
	end
	if 格子==0 then
		常规提示(id,"#Y/你这个仓库已经无法存放更多的物品了")
		return
	end
	-- local djgz=玩家数据[id].角色.道具[道具] --存入时的道具格子
	-- self.数据[页数][#self.数据[页数]+1]=玩家数据[id].道具.数据[djgz]
	-- 玩家数据[id].角色.道具仓库[页数][格子]=#self.数据[页数] --存入时仓库格子
	-- 玩家数据[id].道具.数据[djgz]=nil
	-- 玩家数据[id].角色.道具[道具]=nil
	local 道具id = 玩家数据[id].角色[类型][道具]
	if 道具id==nil or 玩家数据[id].道具.数据[道具id]==nil then
		常规提示(id,"#Y/你没有这个物品！")
	    return
	end
	local asdsadw=table.copy(玩家数据[id].道具.数据[道具id])
	玩家数据[id].角色[类型][道具]=nil
	玩家数据[id].道具.数据[道具id] =nil
	self.数据[页数][格子]=asdsadw--玩家数据[id].道具.数据[道具id]
	-- 玩家数据[id].角色[类型][道具]=nil
	-- 玩家数据[id].道具.数据[道具id] =nil
	-- 玩家数据[id].角色.道具仓库[页数][格子]=格子 --同步
	道具刷新(id)
	--发送数据(连接id,3513,玩家数据[id][类型]:索要道具2(id))
	发送数据(连接id,3524,{道具=self:索要仓库道具(id,数据.页数),页数=数据.页数})
	if 类型 == "道具" then
		发送数据(连接id,3535,{类型="道具",数据=玩家数据[id].道具:索要道具2(id)})
	elseif 类型 == "行囊" then
		发送数据(连接id,3535,{类型="行囊",数据=玩家数据[id].道具:索要行囊2(id)})
	end
	-- local 道具id = 玩家数据[id].角色.道具[道具]
	-- self.数据[页数][格子]=玩家数据[id].道具.数据[道具id]
	-- -- 玩家数据[id].角色.道具仓库[页数][格子]=格子 --同步
	-- 玩家数据[id].角色.道具[道具]=nil
	-- 玩家数据[id].道具.数据[道具id] =nil
	-- 道具刷新(id)
	-- 发送数据(连接id,3513,玩家数据[id].道具:索要道具2(id))
	-- 发送数据(连接id,3524,{道具=self:索要仓库道具(id,数据.页数),页数=数据.页数})
	-- 发送数据(连接id,3525)
end

function 道具仓库类:仓库取走事件(连接id,id,数据)
	-- if 玩家数据[id].摊位数据~=nil then
	-- 	常规提示(id,"#Y/摆摊中无法操作仓库。")
	-- 	return
	-- end
	-- local 页数=数据.页数
	-- local 仓库格子=数据.物品
	-- local 格子=玩家数据[id].角色:取道具格子() --从1-20取空实际上看到的道具 == 玩家数据[id].角色.道具["格子"] 的 "格子"
	-- if 格子==0 then
	-- 	常规提示(id,"#Y/你身上没有足够的空间")
	-- 	return
	-- end
	-- local 道具id = 玩家数据[id].道具:取新编号()
	-- 玩家数据[id].道具.数据[道具id] = table.copy((self.数据[页数][仓库格子]))
	-- 玩家数据[id].角色.道具[格子]=道具id
	-- -- 玩家数据[id].角色.道具仓库[页数][仓库格子]=nil
	-- self.数据[页数][仓库格子]=nil
	-- 道具刷新(id)
	-- 发送数据(玩家数据[id].连接id,3513,玩家数据[id].道具:索要道具2(id))
	-- 发送数据(连接id,3524,{道具=self:索要仓库道具(id,数据.页数),页数=数据.页数})

	if 玩家数据[id].摊位数据~=nil then
		常规提示(id,"#Y/摆摊中无法操作仓库。")
		return
	end
	local 页数=数据.页数
	local 仓库格子=数据.物品
	local 类型 =数据.类型
	local 格子=玩家数据[id].角色:取道具格子1(类型) --从1-20取空实际上看到的道具 == 玩家数据[id].角色.道具["格子"] 的 "格子"
	if 格子==0 then
		常规提示(id,"#Y/你身上没有足够的空间")
		return
	end
	local 道具id = 玩家数据[id].道具:取新编号()
	玩家数据[id].道具.数据[道具id] = table.copy((self.数据[页数][仓库格子]))
	玩家数据[id].角色[类型][格子]=道具id
	-- 玩家数据[id].角色.道具仓库[页数][仓库格子]=nil
	self.数据[页数][仓库格子]=nil

	道具刷新(id)
	--发送数据(玩家数据[id].连接id,3513,玩家数据[id].道具:索要道具2(id))
	发送数据(连接id,3524,{道具=self:索要仓库道具(id,数据.页数),页数=数据.页数})
	if 类型 == "道具" then
		发送数据(连接id,3535,{类型="道具",数据=玩家数据[id].道具:索要道具2(id)})
	elseif 类型 == "行囊" then
		发送数据(连接id,3535,{类型="行囊",数据=玩家数据[id].道具:索要行囊2(id)})
	end
end

function 道具仓库类:索要仓库道具(id,页)
	self.发送数据={道具={}}
	for n=1,20 do
		if self.数据[页] and self.数据[页][n]~=nil then
			if self.数据[页][n].名称~=nil then
				self.发送数据.道具[n]=table.copy((self.数据[页][n]))
			else
			    self.数据[页][n]=nil
			end
		end
	end
	return self.发送数据
end

function 道具仓库类:更新(dt) end

function 道具仓库类:显示(x,y) end

return 道具仓库类