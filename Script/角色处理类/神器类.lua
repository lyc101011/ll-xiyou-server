-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:44
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-09-09 21:59:08

local 神器类 = class()
local 五行 = {"金","木","水","火","土"}
local 五行属性 = {金 = "速度",木 = "气血",土 = "抵抗封印"}
local 神器属性 = {
    大唐官府 = {"伤害","物理暴击"},化生寺 = {"防御","治疗能力"},方寸山 = {"封印命中","法术伤害"},女儿村 = {"封印命中","固定伤害"},天宫 = {"法术伤害","封印命中"},
    普陀山 = {"固定伤害","治疗能力"},龙宫 = {"法术伤害","法术暴击"},五庄观 = {"伤害","封印命中"},魔王寨 = {"法术伤害","法术暴击"},狮驼岭 = {"伤害","物理暴击"},
    盘丝洞 = {"封印命中","法术防御"},阴曹地府 = {"伤害","法术防御"},神木林 = {"法术伤害","法术暴击"},凌波城 = {"伤害","物理暴击"},无底洞 = {"封印命中","治疗能力"},
    花果山 = {"伤害","物理暴击"},九黎城 = {"伤害","物理暴击"}
}
local 神器门派技能 = {
    大唐官府 = {"藏锋敛锐","惊锋"},化生寺 = {"风起云墨","挥毫"},方寸山 = {"披坚执锐","金汤之固"},女儿村 = {"盏中晴雪","泪光盈盈"},天宫 = {"弦外之音","裂帛"},
    普陀山 = {"玉魄","璇华"},龙宫 = {"定风波","沧浪赋"},五庄观 = {"斗转参横","静笃"},魔王寨 = {"业焰明光","流火"},狮驼岭 = {"蛮血","狂战"},
    盘丝洞 = {"镜花水月","澄明"},阴曹地府 = {"亡灵泣语","魂魇"},神木林 = {"凭虚御风","钟灵"},凌波城 = {"威服天下","酣战"},无底洞 = {"情思悠悠","相思"},
    花果山 = {"万物滋长","开辟"},九黎城 = {"鸣空","骇神"}
  }

function 神器类:初始化(id)
    self.玩家id=id
	self.数据={}
	self.num={}
	self.num["速度"]=2
    self.num["法术防御"]=2
	self.num["抵抗封印"]=2
	self.num["防御"]=2
	self.num["封印命中"]=2
	self.num["气血"]=3
	self.num["伤害"]=1
	self.num["法术伤害"]=1
	self.num["固定伤害"]=1
	self.num["物理暴击"]=1
	self.num["治疗能力"]=1
	self.num["法术暴击"]=1
end

function 神器类:加载数据(账号,id)
	if f函数.文件是否存在(程序目录..[[data/]]..账号..[[/]]..id..[[/神器.txt]])==false then
		写出文件([[data/]]..账号..[[/]]..id..[[/神器.txt]],table.tostring({}))
	else
		self.数据=table.loadstring(读入文件(程序目录..[[data/]]..账号..[[/]]..id..[[/神器.txt]]))
	end
end

function 神器类:数据处理(连接id,序号,id,内容) --序号>6200 and 序号<=6300

	if 序号==6201 then --更换神器五行，打开更换界面
		if not 判断是否为空表(self.数据) then
		    发送数据(连接id,6201,self.数据)
		else
			常规提示(id,"您当前暂未获得神器！")
		end
	elseif 序号==6202 then
		玩家数据[id].给予数据={类型=1,id=0,事件="炼制灵犀之屑"}
		发送数据(连接id,3530,{道具=玩家数据[id].道具:索要道具1(id),名称="",类型="NPC",等级="无"})
	elseif 序号==6203 then --更换神器五行，打开更换界面
		if not 判断是否为空表(self.数据) then
		    发送数据(连接id,6203,self.数据)
		else
			常规提示(id,"您当前暂未获得神器！")
		end
	elseif 序号==6205 then --放弃镶嵌
		发送数据(连接id,6205,self.数据)
	elseif 序号==6204 then --解锁其他部件
		--if not 玩家数据[id].角色.武神坛角色 and 玩家数据[id].角色:扣除银子(5000000,0,0,"神器解锁部件",1) then
		if  玩家数据[id].角色:扣除银子(5000000,0,0,"神器解锁部件",1) or 玩家数据[id].角色.武神坛角色 then
		    local 区域=内容.区域
			self:神器解锁区域(区域,连接id,id)
		else
			添加最后对话(id,"解锁这个部件需消耗5000000两梦幻币。")
		end
	elseif 序号==6225 then --更换五行
		self:神器取五行(连接id,id)
	elseif 序号==6226 then --更换五行
		self:神器保存五行(内容.神器部件,内容.五行,连接id,id)
	elseif 序号==6208 then --法宝打开神器查看界面

	    发送数据(连接id,6208,{神器=self.数据})
	elseif 序号==6210 then --修复神器
		local 物品 = 玩家数据[id].道具:索要灵犀玉(id)
		发送数据(连接id,6210,{神器=self.数据,灵犀玉=物品.道具})
	elseif 序号==6215 then --确定紅 --神器激活插槽
		if self.数据.神器解锁点<100 then
			常规提示(id,"神器解锁点不足无法解锁该插槽！")
			return
		end
		if 玩家数据[id].角色.当前经验 < 50000000 then
			常规提示(id,"您的经验不足无法解锁该插槽！")
			return
		end
		local bj = 内容.部件 --主部件
	    local cc = 内容.插槽位 --解锁的插槽
	    self.数据.神器解锁点=self.数据.神器解锁点-100
	    玩家数据[id].角色.当前经验=玩家数据[id].角色.当前经验-50000000
	    self.数据.神器解锁[bj].神器卡槽解锁[cc]=true
	    发送数据(连接id,6215,self.数据)
	    常规提示(id,"解锁成功！")
    elseif 序号==6216 then
    	local yz=5000000
		if 玩家数据[id].角色:扣除银子(yz,0,0,"神器解锁点",1) or  玩家数据[id].角色.武神坛角色 then            --and not 玩家数据[id].角色.武神坛角色 then
		    添加最后对话(id,"你花费了"..yz.."两梦幻币，补充了50点神器解锁点")
			self.数据.神器解锁点=self.数据.神器解锁点+50
			发送数据(连接id,6216,self.数据.神器解锁点)
		else
			常规提示(id,"您的银子不足。")
		end
	elseif 序号==6218 then --打开界面开始
		local 灵犀数量 = 玩家数据[id].道具:取灵犀之屑数量(id)
		发送数据(连接id,6218,灵犀数量)
	end
end
function 神器类:切换神器(id)
	新技能=""
	if not  玩家数据[id].神器.数据.是否有 then
		添加最后对话(id,"你连神器都没有！#24")
		return
	end
  if 玩家数据[id].角色:扣除银子(5000000,0,0,"切换神器",1) or  玩家数据[id].角色.武神坛角色 then
	神器名字=玩家数据[id].神器.数据.神器技能.name
	if 神器名字==神器门派技能[玩家数据[id].角色.门派][1] then
	   新技能=神器门派技能[玩家数据[id].角色.门派][2]
	else
	   新技能=神器门派技能[玩家数据[id].角色.门派][1]
	end
    玩家数据[id].神器.数据.神器技能.name=新技能
    添加最后对话(id,"扣除500W银子切换神器技能成功！请重新打开神器界面查看！")
    玩家数据[id].角色:存档()
   end
end

function 神器类:添加神器(id)
	self.数据={}
	local 门派神器名称 = {
		大唐官府 = "轩辕剑",化生寺 = "墨魂笔",方寸山 = "黄金甲",女儿村 = "泪痕碗",天宫 = "独弦琴",
		普陀山 = "华光玉",龙宫 = "清泽谱",五庄观 = "星斗盘",魔王寨 = "明火珠",狮驼岭 = "噬魂齿",
		盘丝洞 = "昆仑镜",阴曹地府 = "四神鼎",神木林 = "月光草",凌波城 = "天罡印",无底洞 = "玲珑结",
		花果山 = "鸿蒙石",九黎城 = "魔息角"
	}
	local 随机五行={}
	for n=1,4 do

		随机五行[n] = 五行[取随机数(1,5)]
	end
	local 随机五行属性 = {}
	local 五行数值 = {}
	local 灵犀玉 = {}
	for n=1,4 do
		if 随机五行[n] == "水" then
			随机五行属性[n] = 神器属性[玩家数据[id].角色.门派][1]
		elseif 随机五行[n] == "火" then
			随机五行属性[n] = 神器属性[玩家数据[id].角色.门派][2]
		else
			随机五行属性[n] = 五行属性[随机五行[n]]
		end
		五行数值[n] = 0
		灵犀玉[n] = {}
	end
	self.数据 = {
		神器技能 = {name=神器门派技能[玩家数据[id].角色.门派][1],lv=1},
		灵气 = 50,
		神器解锁点 = 0,
		是否佩戴神器 = false,
		是否有 = true,
		神器解锁 = {[1] = {神器五行属性=随机五行属性,神器五行=随机五行,神器五行数值=五行数值,神器卡槽解锁={},镶嵌灵犀玉=灵犀玉}}
	}

	玩家数据[id].角色:存档()
	常规提示(id,"#Y/恭喜你获得了 #R/"..玩家数据[id].角色.门派.." #Y/专属神器 #Z/【"..门派神器名称[玩家数据[id].角色.门派].."】。")
	发送数据(玩家数据[id].连接id,6202,{mp=玩家数据[id].角色.门派})--神器获得
end

function 神器类:切换神器技能(id)
	if 判断是否为空表(self.数据) then
		常规提示(id,"您当前没有神器，无法转换神器！请与管理员联系")
	    return
	end
	if 玩家数据[id].角色.银子 < 50000000 and not 玩家数据[id].角色.武神坛角色 then
		常规提示(id,"银子不足，无法进行更换！")
		return
	end
	玩家数据[id].角色:扣除银子(50000000,0,0,"切换神器技能",1)
	local 门派 = 玩家数据[id].角色.门派

if  self.数据.神器技能.name == 神器门派技能[门派][1] then
    self.数据.神器技能.name = 神器门派技能[门派][2]
elseif self.数据.神器技能.name == 神器门派技能[门派][2] then
     self.数据.神器技能.name = 神器门派技能[门派][1]
end
    self:转换神器重置属性(self.数据,id)
end

function 神器类:转换神器(id)
	if 判断是否为空表(self.数据) then
		常规提示(id,"您当前没有神器，无法转换神器！请与管理员联系")
	    return
	end
	local 门派 = 玩家数据[id].角色.门派
	self.数据.神器技能.name=神器门派技能[门派][1]
	local 随机五行 = {}
	for k,v in pairs(self.数据.神器解锁) do
		随机五行[k]=v.神器五行
	end
	for i=1,3 do
		if self.数据.神器解锁[i]~=nil then
			for n=1,4 do
				if 随机五行[i][n] == "水" then
					self.数据.神器解锁[i].神器五行属性[n] = 神器属性[门派][1]
				elseif 随机五行[i][n] == "火" then
					self.数据.神器解锁[i].神器五行属性[n] = 神器属性[门派][2]
				else
					self.数据.神器解锁[i].神器五行属性[n] = 五行属性[随机五行[i][n]]
				end
			end
		end
	end
    self:转换神器重置属性(self.数据,id)
    发送数据(玩家数据[id].连接id,6212,门派) ----修复神器:重新载入()
end

function 神器类:佩戴神器(连接id,id,位置)
	玩家数据[id].角色.神器属性={速度=0,法术防御=0,防御=0,气血=0,伤害=0,法术伤害=0,固定伤害=0,治疗能力=0,法术暴击等级=0,物理暴击等级=0,封印命中等级=0,抵抗封印等级=0}
    if self.数据.是否佩戴神器==false then
	    local sx = {速度=0,法术防御=0,防御=0,气血=0,伤害=0,法术伤害=0,固定伤害=0,治疗能力=0,法术暴击等级=0,物理暴击等级=0,封印命中等级=0,抵抗封印等级=0}
		for k,v in pairs(self.数据.神器解锁) do
		    for n=1,#v.神器五行属性 do
		    	if v.神器五行属性[n] == "物理暴击" or v.神器五行属性[n] == "法术暴击" or v.神器五行属性[n] == "封印命中" or v.神器五行属性[n] == "抵抗封印" then
		    	    sx[v.神器五行属性[n].."等级"] = sx[v.神器五行属性[n].."等级"] + v.神器五行数值[n]
		    	else
		    		sx[v.神器五行属性[n]] = sx[v.神器五行属性[n]] + v.神器五行数值[n]
		    	end
		    end
		end
		玩家数据[id].角色.神器佩戴=true
		玩家数据[id].角色.神器属性=sx
		self.数据.是否佩戴神器=true
		self.数据.格子=位置
		发送数据(连接id,6211,{是否=true,格子=位置})
	else
		玩家数据[id].角色.神器佩戴=false
	    self.数据.是否佩戴神器=false
	    self.数据.格子=nil
	    发送数据(连接id,6211,{是否=false})
	end
	玩家数据[id].角色:刷新信息("1")
end

function 神器类:卸下神器(连接id,id,位置)
	self:佩戴神器(连接id,id,位置)
end

function 神器类:刷新角色神器属性(id)
	玩家数据[id].角色.神器属性={速度=0,法术防御=0,防御=0,气血=0,伤害=0,法术伤害=0,固定伤害=0,治疗能力=0,法术暴击等级=0,物理暴击等级=0,封印命中等级=0,抵抗封印等级=0}
    if self.数据.是否佩戴神器 then
	    local sx = {速度=0,法术防御=0,防御=0,气血=0,伤害=0,法术伤害=0,固定伤害=0,治疗能力=0,法术暴击等级=0,物理暴击等级=0,封印命中等级=0,抵抗封印等级=0}
		for k,v in pairs(self.数据.神器解锁) do
		    for n=1,#v.神器五行属性 do
		    	if v.神器五行属性[n] == "物理暴击" or v.神器五行属性[n] == "法术暴击" or v.神器五行属性[n] == "封印命中" or v.神器五行属性[n] == "抵抗封印" then
		    	    sx[v.神器五行属性[n].."等级"] = sx[v.神器五行属性[n].."等级"] + v.神器五行数值[n]
		    	else
		    		sx[v.神器五行属性[n]] = sx[v.神器五行属性[n]] + v.神器五行数值[n]
		    	end
		    end
		end
		玩家数据[id].角色.神器属性=sx
		玩家数据[id].角色:刷新信息("1")
	end
end

function 神器类:神器取五行(连接id,id)
	local yz=100000
	if 玩家数据[id].角色.银子 < yz and not 玩家数据[id].角色.武神坛角色 then
		常规提示(id,"银子不足，无法进行更换！")
		return
	end
	if 玩家数据[id].角色.体力 < 10 then
		常规提示(id,"你没有那么多的体力！")
		return
	end
	if not 玩家数据[id].角色.武神坛角色 then
		玩家数据[id].角色:扣除银子(yz,0,0,"神器换五行",1)
	end
	玩家数据[id].角色.体力=玩家数据[id].角色.体力-10
	local 随机五行 = {}
	for n=1,4 do
		随机五行[n] = 五行[取随机数(1,5)]
	end
	体活刷新(id)
	发送数据(连接id,6207,随机五行)
end

function 神器类:神器保存五行(部件,五行,连接id,id) --这里有问题
	local sx = {}
	for n=1,4 do
	    if 五行[n] == "水" then
	        sx[n] = 神器属性[玩家数据[id].角色.门派][1]
	    elseif 五行[n] == "火" then
	        sx[n] = 神器属性[玩家数据[id].角色.门派][2]
	    else
	        sx[n] = 五行属性[五行[n]]
	    end
	end
	self.数据.神器解锁[部件].神器五行=五行
	self.数据.神器解锁[部件].神器五行属性=sx
    self:重新计算神器属性(部件,id)
    发送数据(连接id,6209,self.数据)
end

function 神器类:神器解锁区域(区域,连接id,id)
	local 随机五行={}
	for n=1,4 do
		随机五行[n] = 五行[取随机数(1,5)]
	end
	local 随机五行属性 = {}
	local 五行数值 = {}
	local 灵犀玉 = {}
	for n=1,4 do
		if 随机五行[n] == "水" then
			随机五行属性[n] = 神器属性[玩家数据[id].角色.门派][1]
		elseif 随机五行[n] == "火" then
			随机五行属性[n] = 神器属性[玩家数据[id].角色.门派][2]
		else
			随机五行属性[n] = 五行属性[随机五行[n]]
		end
		五行数值[n] = 0
		灵犀玉[n] = {}
	end
	if self.数据.神器解锁[区域]~=nil then
		常规提示(self.数据.id,"#Y/数据异常，请重新打开后尝试。")
	else
		self.数据.神器解锁[区域] = {神器五行属性=随机五行属性,神器五行=随机五行,神器五行数值=五行数值,神器卡槽解锁={},镶嵌灵犀玉=灵犀玉}
		发送数据(连接id,6204,self.数据)

	end
end


function 神器类:转换神器重置属性(神器,id)
	local 寄存属性 = 神器
	local sq = {}
	for k=1,3 do

		if 寄存属性.神器解锁[k]~=nil then
			sq[k] = 寄存属性.神器解锁[k]

		    local 特性激活={}
		    local 临时镶嵌属性 = {}
		    local 灵犀玉基础属性 = {}
			for i=1,4 do
				特性激活[i] = {蔓延=false,天平=false,相生=false,相克=false,耀=false,利=false}
				临时镶嵌属性[i] = 0
				灵犀玉基础属性[i] = 0
			end

			for i=1,4 do
				if not 判断是否为空表(sq[k].镶嵌灵犀玉[i]) then
					if sq[k].神器五行属性[i]=="速度" or sq[k].神器五行属性[i]=="防御" or sq[k].神器五行属性[i]=="法术防御"
							or sq[k].神器五行属性[i]=="封印命中" or sq[k].神器五行属性[i]=="抵抗封印" then
						if sq[k].镶嵌灵犀玉[i].子类==1 then
							灵犀玉基础属性[i]=6
						elseif sq[k].镶嵌灵犀玉[i].子类==2 then
							灵犀玉基础属性[i]=10
						else
							灵犀玉基础属性[i]=14
						end

					elseif sq[k].神器五行属性[i]=="气血" then
						if sq[k].镶嵌灵犀玉[i].子类==1 then
							灵犀玉基础属性[i]=9
						elseif sq[k].镶嵌灵犀玉[i].子类==2 then
							灵犀玉基础属性[i]=15
						else
							灵犀玉基础属性[i]=21
						end
					else
						if sq[k].镶嵌灵犀玉[i].子类==1 then
							灵犀玉基础属性[i]=3
						elseif sq[k].镶嵌灵犀玉[i].子类==2 then
							灵犀玉基础属性[i]=5
						else
							灵犀玉基础属性[i]=7
						end
					end
				end
			end

		    for i=1,4 do
		        if not 判断是否为空表(sq[k].镶嵌灵犀玉[i]) then
			    	for n=1,4 do
						if sq[k].镶嵌灵犀玉[i].特性==sq[k].神器五行[n].."耀" then
					        特性激活[n].耀=true
					    end
					end
				    if sq[k].镶嵌灵犀玉[i].特性=="蔓延" and (i==1 or i==3) then
				    	特性激活[2].蔓延=true
				    	特性激活[4].蔓延=true
				    end
				    if sq[k].镶嵌灵犀玉[i].特性=="天平" and (i==2 or i==4) then
				    	特性激活[2].天平=true
				    	特性激活[4].天平=true
				    end
				    if sq[k].镶嵌灵犀玉[i].特性=="相生" then
						if i==1 or i==3 then
							if self:取五行相生(sq[k].神器五行[i])==sq[k].神器五行[2] then
								特性激活[2].相生=true
							end
							if self:取五行相生(sq[k].神器五行[i])==sq[k].神器五行[4] then
								特性激活[4].相生=true
							end
						elseif i==2 or i==4 then
							if self:取五行相生(sq[k].神器五行[i])==sq[k].神器五行[1] then
								特性激活[1].相生=true
							end
							if self:取五行相生(sq[k].神器五行[i])==sq[k].神器五行[3] then
								特性激活[3].相生=true
							end
						end
					end
					if sq[k].镶嵌灵犀玉[i].特性=="相克" then
						if i==1 or i==3 then
							if self:取五行相克(sq[k].神器五行[i])==sq[k].神器五行[2] then
								特性激活[2].相克=true
							end
							if self:取五行相克(sq[k].神器五行[i])==sq[k].神器五行[4] then
								特性激活[4].相克=true
							end
						elseif i==2 or i==4 then
							if self:取五行相克(sq[k].神器五行[i])==sq[k].神器五行[1] then
								特性激活[1].相克=true
							end
							if self:取五行相克(sq[k].神器五行[i])==sq[k].神器五行[3] then
								特性激活[3].相克=true
							end
						end
					end
					if sq[k].镶嵌灵犀玉[i].特性=="利"..sq[k].神器五行[i] then
						特性激活[i].利=true

					end
					for n=1,4 do
						if sq[k].镶嵌灵犀玉[i].特性==sq[k].神器五行[n].."耀" then
					        特性激活[n].耀=true
					    end
					end
				    if sq[k].镶嵌灵犀玉[i].特性=="蔓延" and (i==1 or i==3) then
				    	特性激活[2].蔓延=true
				    	特性激活[4].蔓延=true
				    end
				    if sq[k].镶嵌灵犀玉[i].特性=="天平" and (i==2 or i==4) then
				    	特性激活[2].天平=true
				    	特性激活[4].天平=true
				    end
				    if sq[k].镶嵌灵犀玉[i].特性=="相生" then
						if i==1 or i==3 then
							if self:取五行相生(sq[k].神器五行[i])==sq[k].神器五行[2] then
								特性激活[2].相生=true
							end
							if self:取五行相生(sq[k].神器五行[i])==sq[k].神器五行[4] then
								特性激活[4].相生=true
							end
						elseif i==2 or i==4 then
							if self:取五行相生(sq[k].神器五行[i])==sq[k].神器五行[1] then
								特性激活[1].相生=true
							end
							if self:取五行相生(sq[k].神器五行[i])==sq[k].神器五行[3] then
								特性激活[3].相生=true
							end
						end
					end
					if sq[k].镶嵌灵犀玉[i].特性=="相克" then
						if i==1 or i==3 then
							if self:取五行相克(sq[k].神器五行[i])==sq[k].神器五行[2] then
								特性激活[2].相克=true
							end
							if self:取五行相克(sq[k].神器五行[i])==sq[k].神器五行[4] then
								特性激活[4].相克=true
							end
						elseif i==2 or i==4 then
							if self:取五行相克(sq[k].神器五行[i])==sq[k].神器五行[1] then
								特性激活[1].相克=true
							end
							if self:取五行相克(sq[k].神器五行[i])==sq[k].神器五行[3] then
								特性激活[3].相克=true
							end
						end
					end
					if sq[k].镶嵌灵犀玉[i].特性=="利"..sq[k].神器五行[i] then
						特性激活[i].利=true
					end
				end
			end


			for i=1,4 do
				if not 判断是否为空表(sq[k].镶嵌灵犀玉[i]) then
					if 特性激活[i].耀 then
						灵犀玉基础属性[i]=灵犀玉基础属性[i]+self.num[sq[k].神器五行属性[i]]
					end
					if 特性激活[i].蔓延 then
						灵犀玉基础属性[i]=灵犀玉基础属性[i]+self.num[sq[k].神器五行属性[i]]
					end
					if 特性激活[i].天平 then
						灵犀玉基础属性[i]=灵犀玉基础属性[i]+self.num[sq[k].神器五行属性[i]]
					end
					if 特性激活[i].相生 then
						灵犀玉基础属性[i]=灵犀玉基础属性[i]+self.num[sq[k].神器五行属性[i]]
					end
					if 特性激活[i].相克 then
						灵犀玉基础属性[i]=灵犀玉基础属性[i]+self.num[sq[k].神器五行属性[i]]
					end
					if 特性激活[i].利 then
						灵犀玉基础属性[i]=灵犀玉基础属性[i]+self.num[sq[k].神器五行属性[i]]
					end
				end
				临时镶嵌属性[i]=灵犀玉基础属性[i]
				sq[k].神器五行数值[i] = 临时镶嵌属性[i]
			end
		end
	end

	for a,v in pairs(self.数据.神器解锁) do
		self.数据.神器解锁[a]=sq[a]
	end
	常规提示(id,"#G神器转换成功！")

end

function 神器类:计算灵犀玉属性(连接id,id,镶嵌部件,灵犀玉)
    -- local sq = self.数据.神器解锁[镶嵌部件]
    --这里加上灵犀玉基础属性
    local 特性激活={}
    local 临时镶嵌属性 = {}
    local 灵犀玉基础属性 = {}
	for i=1,4 do
		特性激活[i] = {蔓延=false,天平=false,相生=false,相克=false,耀=false,利=false}
		临时镶嵌属性[i] = 0
		灵犀玉基础属性[i] = 0
	end

	for i=1,4 do
		if not 判断是否为空表(self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i]) then
			if self.数据.神器解锁[镶嵌部件].神器五行属性[i]=="速度" or self.数据.神器解锁[镶嵌部件].神器五行属性[i]=="防御" or self.数据.神器解锁[镶嵌部件].神器五行属性[i]=="法术防御"
					or self.数据.神器解锁[镶嵌部件].神器五行属性[i]=="封印命中" or self.数据.神器解锁[镶嵌部件].神器五行属性[i]=="抵抗封印" then
				if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].子类==1 then
					灵犀玉基础属性[i]=6
				elseif self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].子类==2 then
					灵犀玉基础属性[i]=10
				else
					灵犀玉基础属性[i]=14
				end
			elseif self.数据.神器解锁[镶嵌部件].神器五行属性[i]=="气血" then
				if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].子类==1 then
					灵犀玉基础属性[i]=9
				elseif self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].子类==2 then
					灵犀玉基础属性[i]=15
				else
					灵犀玉基础属性[i]=21
				end
			else
				if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].子类==1 then
					灵犀玉基础属性[i]=3
				elseif self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].子类==2 then
					灵犀玉基础属性[i]=5
				else
					灵犀玉基础属性[i]=7
				end
			end
		end
	end
    for i=1,4 do
        if not 判断是否为空表(self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i]) then
	    	for n=1,4 do
				if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性==self.数据.神器解锁[镶嵌部件].神器五行[n].."耀" then
			        特性激活[n].耀=true
			    end
			end
		    if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="蔓延" and (i==1 or i==3) then
		    	特性激活[2].蔓延=true
		    	特性激活[4].蔓延=true
		    end
		    if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="天平" and (i==2 or i==4) then
		    	特性激活[2].天平=true
		    	特性激活[4].天平=true
		    end
		    if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="相生" then
				if i==1 or i==3 then
					if self:取五行相生(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[2] then
						特性激活[2].相生=true
					end
					if self:取五行相生(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[4] then
						特性激活[4].相生=true
					end
				elseif i==2 or i==4 then
					if self:取五行相生(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[1] then
						特性激活[1].相生=true
					end
					if self:取五行相生(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[3] then
						特性激活[3].相生=true
					end
				end
			end
			if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="相克" then
				if i==1 or i==3 then
					if self:取五行相克(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[2] then
						特性激活[2].相克=true
					end
					if self:取五行相克(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[4] then
						特性激活[4].相克=true
					end
				elseif i==2 or i==4 then
					if self:取五行相克(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[1] then
						特性激活[1].相克=true
					end
					if self:取五行相克(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[3] then
						特性激活[3].相克=true
					end
				end
			end
			if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="利"..self.数据.神器解锁[镶嵌部件].神器五行[i] then
				特性激活[i].利=true
			end        	for n=1,4 do
				if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性==self.数据.神器解锁[镶嵌部件].神器五行[n].."耀" then
			        特性激活[n].耀=true
			    end
			end
		    if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="蔓延" and (i==1 or i==3) then
		    	特性激活[2].蔓延=true
		    	特性激活[4].蔓延=true
		    end
		    if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="天平" and (i==2 or i==4) then
		    	特性激活[2].天平=true
		    	特性激活[4].天平=true
		    end
		    if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="相生" then
				if i==1 or i==3 then
					if self:取五行相生(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[2] then
						特性激活[2].相生=true
					end
					if self:取五行相生(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[4] then
						特性激活[4].相生=true
					end
				elseif i==2 or i==4 then
					if self:取五行相生(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[1] then
						特性激活[1].相生=true
					end
					if self:取五行相生(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[3] then
						特性激活[3].相生=true
					end
				end
			end
			if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="相克" then
				if i==1 or i==3 then
					if self:取五行相克(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[2] then
						特性激活[2].相克=true
					end
					if self:取五行相克(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[4] then
						特性激活[4].相克=true
					end
				elseif i==2 or i==4 then
					if self:取五行相克(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[1] then
						特性激活[1].相克=true
					end
					if self:取五行相克(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[3] then
						特性激活[3].相克=true
					end
				end
			end
			if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="利"..self.数据.神器解锁[镶嵌部件].神器五行[i] then
				特性激活[i].利=true
			end
		end
	end

	for i=1,4 do
		if not 判断是否为空表(self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i]) then
			if 特性激活[i].耀 then
				灵犀玉基础属性[i]=灵犀玉基础属性[i]+self.num[self.数据.神器解锁[镶嵌部件].神器五行属性[i]]
			end
			if 特性激活[i].蔓延 then

				灵犀玉基础属性[i]=灵犀玉基础属性[i]+self.num[self.数据.神器解锁[镶嵌部件].神器五行属性[i]]
			end
			if 特性激活[i].天平 then
				灵犀玉基础属性[i]=灵犀玉基础属性[i]+self.num[self.数据.神器解锁[镶嵌部件].神器五行属性[i]]
			end
			if 特性激活[i].相生 then
				灵犀玉基础属性[i]=灵犀玉基础属性[i]+self.num[self.数据.神器解锁[镶嵌部件].神器五行属性[i]]
			end
			if 特性激活[i].相克 then
				灵犀玉基础属性[i]=灵犀玉基础属性[i]+self.num[self.数据.神器解锁[镶嵌部件].神器五行属性[i]]
			end
			if 特性激活[i].利 then
				灵犀玉基础属性[i]=灵犀玉基础属性[i]+self.num[self.数据.神器解锁[镶嵌部件].神器五行属性[i]]
			end
		end

		临时镶嵌属性[i]=灵犀玉基础属性[i]
		self.数据.神器解锁[镶嵌部件].神器五行数值[i] = 临时镶嵌属性[i]
	end
	发送数据(连接id,6217,{神器=self.数据,灵犀玉=灵犀玉})
	self:刷新角色神器属性(id)
end

function 神器类:重新计算神器属性(镶嵌部件,id)
    -- local sq = self.数据.神器解锁[镶嵌部件]
    --这里加上灵犀玉基础属性
    local 特性激活={}
    local 临时镶嵌属性 = {}
    local 灵犀玉基础属性 = {}
	for i=1,4 do
		特性激活[i] = {蔓延=false,天平=false,相生=false,相克=false,耀=false,利=false}
		临时镶嵌属性[i] = 0
		灵犀玉基础属性[i] = 0
	end

	for i=1,4 do
		if not 判断是否为空表(self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i]) then
			if self.数据.神器解锁[镶嵌部件].神器五行属性[i]=="速度" or self.数据.神器解锁[镶嵌部件].神器五行属性[i]=="防御" or self.数据.神器解锁[镶嵌部件].神器五行属性[i]=="法术防御"
					or self.数据.神器解锁[镶嵌部件].神器五行属性[i]=="封印命中" or self.数据.神器解锁[镶嵌部件].神器五行属性[i]=="抵抗封印" then
				if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].子类==1 then
					灵犀玉基础属性[i]=6
				elseif self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].子类==2 then
					灵犀玉基础属性[i]=10
				else
					灵犀玉基础属性[i]=14
				end

			elseif self.数据.神器解锁[镶嵌部件].神器五行属性[i]=="气血" then
				if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].子类==1 then
					灵犀玉基础属性[i]=9
				elseif self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].子类==2 then
					灵犀玉基础属性[i]=15
				else
					灵犀玉基础属性[i]=21
				end
			else
				if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].子类==1 then
					灵犀玉基础属性[i]=3
				elseif self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].子类==2 then
					灵犀玉基础属性[i]=5
				else
					灵犀玉基础属性[i]=7
				end
			end
		end
	end

    for i=1,4 do
        if not 判断是否为空表(self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i]) then
	    	for n=1,4 do
				if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性==self.数据.神器解锁[镶嵌部件].神器五行[n].."耀" then
			        特性激活[n].耀=true
			    end
			end
		    if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="蔓延" and (i==1 or i==3) then
		    	特性激活[2].蔓延=true
		    	特性激活[4].蔓延=true
		    end
		    if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="天平" and (i==2 or i==4) then
		    	特性激活[2].天平=true
		    	特性激活[4].天平=true
		    end
		    if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="相生" then
				if i==1 or i==3 then
					if self:取五行相生(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[2] then
						特性激活[2].相生=true
					end
					if self:取五行相生(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[4] then
						特性激活[4].相生=true
					end
				elseif i==2 or i==4 then
					if self:取五行相生(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[1] then
						特性激活[1].相生=true
					end
					if self:取五行相生(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[3] then
						特性激活[3].相生=true
					end
				end
			end
			if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="相克" then
				if i==1 or i==3 then
					if self:取五行相克(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[2] then
						特性激活[2].相克=true
					end
					if self:取五行相克(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[4] then
						特性激活[4].相克=true
					end
				elseif i==2 or i==4 then
					if self:取五行相克(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[1] then
						特性激活[1].相克=true
					end
					if self:取五行相克(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[3] then
						特性激活[3].相克=true
					end
				end
			end
			if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="利"..self.数据.神器解锁[镶嵌部件].神器五行[i] then
				特性激活[i].利=true

			end
			for n=1,4 do
				if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性==self.数据.神器解锁[镶嵌部件].神器五行[n].."耀" then
			        特性激活[n].耀=true
			    end
			end
		    if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="蔓延" and (i==1 or i==3) then
		    	特性激活[2].蔓延=true
		    	特性激活[4].蔓延=true
		    end
		    if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="天平" and (i==2 or i==4) then
		    	特性激活[2].天平=true
		    	特性激活[4].天平=true
		    end
		    if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="相生" then
				if i==1 or i==3 then
					if self:取五行相生(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[2] then
						特性激活[2].相生=true
					end
					if self:取五行相生(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[4] then
						特性激活[4].相生=true
					end
				elseif i==2 or i==4 then
					if self:取五行相生(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[1] then
						特性激活[1].相生=true
					end
					if self:取五行相生(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[3] then
						特性激活[3].相生=true
					end
				end
			end
			if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="相克" then
				if i==1 or i==3 then
					if self:取五行相克(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[2] then
						特性激活[2].相克=true
					end
					if self:取五行相克(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[4] then
						特性激活[4].相克=true
					end
				elseif i==2 or i==4 then
					if self:取五行相克(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[1] then
						特性激活[1].相克=true
					end
					if self:取五行相克(self.数据.神器解锁[镶嵌部件].神器五行[i])==self.数据.神器解锁[镶嵌部件].神器五行[3] then
						特性激活[3].相克=true
					end
				end
			end
			if self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i].特性=="利"..self.数据.神器解锁[镶嵌部件].神器五行[i] then
				特性激活[i].利=true
			end
		end
	end

	for i=1,4 do
		if not 判断是否为空表(self.数据.神器解锁[镶嵌部件].镶嵌灵犀玉[i]) then
			if 特性激活[i].耀 then
				灵犀玉基础属性[i]=灵犀玉基础属性[i]+self.num[self.数据.神器解锁[镶嵌部件].神器五行属性[i]]
			end
			if 特性激活[i].蔓延 then

				灵犀玉基础属性[i]=灵犀玉基础属性[i]+self.num[self.数据.神器解锁[镶嵌部件].神器五行属性[i]]
			end
			if 特性激活[i].天平 then
				灵犀玉基础属性[i]=灵犀玉基础属性[i]+self.num[self.数据.神器解锁[镶嵌部件].神器五行属性[i]]
			end
			if 特性激活[i].相生 then
				灵犀玉基础属性[i]=灵犀玉基础属性[i]+self.num[self.数据.神器解锁[镶嵌部件].神器五行属性[i]]
			end
			if 特性激活[i].相克 then
				灵犀玉基础属性[i]=灵犀玉基础属性[i]+self.num[self.数据.神器解锁[镶嵌部件].神器五行属性[i]]
			end
			if 特性激活[i].利 then
				灵犀玉基础属性[i]=灵犀玉基础属性[i]+self.num[self.数据.神器解锁[镶嵌部件].神器五行属性[i]]
			end
		end

		临时镶嵌属性[i]=灵犀玉基础属性[i]
		self.数据.神器解锁[镶嵌部件].神器五行数值[i] = 临时镶嵌属性[i]
	end
	self:刷新角色神器属性(id)
end

function 神器类:取五行相生(五行)
  local 相生="水"
  if 五行=="金" then
     相生="水"
  elseif 五行=="水" then
     相生="木"
  elseif 五行=="木" then
     相生="水"
  elseif 五行=="火" then
     相生="土"
  elseif 五行=="土" then
     相生="金"
  end
  return 相生
end

function 神器类:取五行相克(五行)
  local 相克="木"
  if 五行=="金" then
     相克="木"
  elseif 五行=="木" then
     相克="土"
  elseif 五行=="土" then
     相克="水"
  elseif 五行=="水" then
     相克="火"
  elseif 五行=="火" then
     相克="金"
  end
  return 相克
end

return 神器类