-- @Author: baidwwy
-- @Date:   2024-08-03 02:56:23
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-01-09 13:21:21
local 奖池抽奖类 = class() --抽奖

function 奖池抽奖类:初始化()
	self.满幸运 = 88 --自己设定，抽多少次可获得水晶
	self.奖池数据 = {}
	self.全部道具 = {}
	self.水晶商品 = {} --水晶商店的道具数据
	self:加载全部道具()
	self:加载奖池数据()
	self:加载水晶商店()
end

function 奖池抽奖类:加载奖池数据()
  if f函数.文件是否存在([[sql/奖池数据.txt]])==false then
    self:更新奖池数据()
    写出文件([[sql/奖池数据.txt]],table.tostring(self.奖池数据))
  else
    self.奖池数据=table.loadstring(读入文件([[sql/奖池数据.txt]]))
  end
end

function 奖池抽奖类:保存奖池数据()
	写出文件([[sql/奖池数据.txt]],table.tostring(self.奖池数据))
end

function 奖池抽奖类:更新奖池数据() --奖池物品，每周刷新一次
	self.奖池数据 = {}
	local data = table.copy(self.全部道具)
	while #self.奖池数据 < 32 do
		local qsj=取随机数(1,#data)
		if data[qsj]~=nil and data[qsj].已调用==nil then
			data[qsj].道具编号 = qsj --全部道具的编号，给奖励时要删除
			table.insert(self.奖池数据,table.copy(data[qsj]))
			data[qsj].已调用=true
		end
	end
	写出文件([[sql/奖池数据.txt]],table.tostring(self.奖池数据))
	发送公告("#G全服奖池已刷新，先抽先得，抽完为止！")
end

function 奖池抽奖类:加载全部道具() --非奖池，奖池物品会中这里随机选32种
	local data={
		-- {名称="十万仙玉",可叠加=true,给予数量=1,奖池数量=99,概率=2},
		-- {名称="百万仙玉",可叠加=true,给予数量=1,奖池数量=99,概率=1},
		{名称="神兜兜",可叠加=true,给予数量=30,奖池数量=66,概率=4},
		{名称="修炼果",可叠加=true,给予数量=5,奖池数量=66,概率=10},
		{名称="特殊兽诀·碎片",可叠加=true,给予数量=10,奖池数量=66,概率=8},
		{名称="特殊兽诀礼盒",可叠加=true,给予数量=1,奖池数量=66,概率=3},
		{名称="稀有兽诀礼盒",可叠加=true,给予数量=1,奖池数量=66,概率=2},
		{名称="回梦丹",可叠加=true,给予数量=3,奖池数量=66,概率=10},
		{名称="一亿银票",可叠加=true,给予数量=1,奖池数量=66,概率=2},
		{名称="灵犀玉礼包",可叠加=true,给予数量=1,奖池数量=66,概率=8},
		{名称="150无级别礼包",可叠加=true,给予数量=1,奖池数量=66,概率=2},
		{名称="战魄",可叠加=false,给予数量=3,奖池数量=66,概率=6},
		{名称="神兜兜",可叠加=true,给予数量=15,奖池数量=66,概率=6},
		{名称="精炼之锤低",可叠加=true,给予数量=100,奖池数量=500,概率=8},
		{名称="高级星辉石礼包",可叠加=true,给予数量=1,奖池数量=66,概率=8},
		{名称="八级玄灵珠礼包",可叠加=true,给予数量=1,奖池数量=66,概率=6},
		{名称="160附魔宝珠礼包",可叠加=true,给予数量=1,奖池数量=66,概率=8},
		{名称="超级兽诀礼盒",可叠加=true,给予数量=1,奖池数量=66,概率=1},
		{名称="百万银票",可叠加=true,给予数量=1,奖池数量=66,概率=6},
		{名称="装备特效宝珠礼包",可叠加=true,给予数量=1,奖池数量=66,概率=4},
		{名称="超级兽诀·碎片",可叠加=true,给予数量=10,奖池数量=66,概率=6},
		{名称="武器附神锤",可叠加=true,给予数量=1,奖池数量=66,概率=1},
		{名称="陨铁礼包",可叠加=true,给予数量=1,奖池数量=66,概率=5},
		{名称="特效宝珠",可叠加=true,给予数量=3,奖池数量=66,概率=5},
		{名称="特技书",可叠加=true,给予数量=3,奖池数量=66,概率=6},
		{名称="千万银票",可叠加=true,给予数量=1,奖池数量=66,概率=7},
		{名称="愤怒符",可叠加=true,给予数量=1,奖池数量=66,概率=3},
		{名称="双加转换符",可叠加=true,给予数量=3,奖池数量=66,概率=5},
		{名称="灵饰特效宝珠",可叠加=true,给予数量=3,奖池数量=66,概率=6},
		{名称="神兜兜",可叠加=true,给予数量=20,奖池数量=66,概率=6},
		{名称="元素曜石礼包",可叠加=true,给予数量=1,奖池数量=30,概率=1},
		{名称="神兜兜",可叠加=true,给予数量=10,奖池数量=66,概率=8},
		{名称="月饼",可叠加=true,给予数量=3,奖池数量=66,概率=8},
		{名称="超级兽诀·碎片",可叠加=true,给予数量=10,奖池数量=66,概率=8},
		{名称="精炼之锤中",可叠加=true,给予数量=50,奖池数量=500,概率=5},
		{名称="6级钟灵石礼包",可叠加=true,给予数量=1,奖池数量=66,概率=8},
		{名称="特殊清灵仙露",可叠加=true,给予数量=1,奖池数量=66,概率=1},
		{名称="一千仙玉",可叠加=true,给予数量=1,奖池数量=66,概率=6},
		{名称="一万仙玉",可叠加=true,给予数量=1,奖池数量=66,概率=2},
		{名称="朱雀印",可叠加=true,给予数量=3,奖池数量=66,概率=8},
		{名称="白虎印",可叠加=true,给予数量=3,奖池数量=66,概率=8},
		{名称="青龙印",可叠加=true,给予数量=3,奖池数量=66,概率=8},
		{名称="玄武印",可叠加=true,给予数量=3,奖池数量=66,概率=8},
		{名称="精炼之锤高",可叠加=true,给予数量=30,奖池数量=500,概率=4},
		{名称="随机经验礼包",可叠加=true,给予数量=1,奖池数量=66,概率=4},
		{名称="随机仙玉礼包",可叠加=true,给予数量=1,奖池数量=66,概率=4},
		{名称="随机经验大礼包",可叠加=true,给予数量=1,奖池数量=66,概率=2},
		{名称="随机仙玉大礼包",可叠加=true,给予数量=1,奖池数量=66,概率=2}

	}
	for an=1,#data do
		self.全部道具[an]=物品类()
		self.全部道具[an]:置对象(data[an].名称,data[an])
		self.全部道具[an].名称 = data[an].名称
		self.全部道具[an].概率 = data[an].概率
		self.全部道具[an].级别限制 = data[an].级别限制
		self.全部道具[an].给予数量 = data[an].给予数量
		self.全部道具[an].奖池数量 = data[an].奖池数量
			self.全部道具[an].可叠加 = data[an].可叠加
		if ItemData[data[an].名称]==nil then
			print("======================服务端少了：",data[an].名称)
		end
		if ItemData[data[an].名称]~=nil then
			self.全部道具[an].总类 = ItemData[data[an].名称].wp_2
			self.全部道具[an].分类 = ItemData[data[an].名称].wp_3
			self.全部道具[an].子类 = ItemData[data[an].名称].wp_4
		end
	end
end

function 奖池抽奖类:加载水晶商店() --固定18个道具
	local data={
		{名称="超级鲲鹏礼盒（法术）",可叠加=false,给予数量=1},
		{名称="超级鲲鹏礼盒（物理）",可叠加=false,给予数量=1},
		{名称="神兜兜",可叠加=true,给予数量=888},
		{名称="修炼果",可叠加=true,给予数量=888},
		{名称="定制宠礼盒（法术）",可叠加=false,给予数量=1},
		{名称="超级兽诀礼盒",可叠加=false,给予数量=5},
		{名称="定制宠礼盒（物理）",可叠加=false,给予数量=1},
		{名称="稀有兽诀礼盒",可叠加=false,给予数量=3},
		{名称="技能突破符",可叠加=true,给予数量=5},
		{名称="特效宝珠",可叠加=true,给予数量=50},
		{名称="愤怒符",可叠加=false,给予数量=5},
		{名称="特技书",可叠加=true,给予数量=50},
		{名称="双加转换符",可叠加=true,给予数量=30},
		{名称="160无级别礼包",可叠加=true,给予数量=3},
		{名称="特殊清灵仙露",可叠加=false,给予数量=6},
		{名称="十级玄灵珠礼包",可叠加=false,给予数量=6},
		{名称="回梦丹",可叠加=true,给予数量=20},
		{名称="8级钟灵石礼包",可叠加=false,给予数量=8}
	}
	for an=1,#data do
		self.水晶商品[an]=物品类()
		self.水晶商品[an]:置对象(data[an].名称,data[an])
		self.水晶商品[an].名称 = data[an].名称
		self.水晶商品[an].概率 = data[an].概率
		self.水晶商品[an].道具编号 = an
		self.水晶商品[an].级别限制 = data[an].级别限制
		self.水晶商品[an].给予数量 = data[an].给予数量
		self.水晶商品[an].奖池数量 = data[an].奖池数量
		if ItemData[data[an].名称]~=nil then
			self.水晶商品[an].总类 = ItemData[data[an].名称].wp_2
			self.水晶商品[an].分类 = ItemData[data[an].名称].wp_3
			self.水晶商品[an].子类 = ItemData[data[an].名称].wp_4
		end
	end
end

function 奖池抽奖类:数据处理(连接id,数字id,序号,数据)
    if 序号==255 then
    	if 玩家数据[数字id].角色.抽奖机会 == nil then
	        玩家数据[数字id].角色.抽奖机会=0
	    end
	    if 玩家数据[数字id].角色.奖池累抽 == nil then
	        玩家数据[数字id].角色.奖池累抽=0
	    end
	    if 玩家数据[数字id].角色.梦幻水晶 == nil then
	        玩家数据[数字id].角色.梦幻水晶=0
	    end
    	local mhsj = 玩家数据[数字id].角色.梦幻水晶 or 0
    	local ljcj = 玩家数据[数字id].角色.奖池累抽 or 100
    	local hjdj = {}
    	if 玩家数据[数字id].角色.奖池获得~=nil then --防获得后不领取就关闭窗口
    		for an=1,#玩家数据[数字id].角色.奖池获得 do
	    		local qbh = 玩家数据[数字id].角色.奖池获得[an]
	    		table.insert(hjdj,self.全部道具[qbh])
	    	end
    	end
    	local cjdh = 玩家数据[数字id].角色.系统设置["抽奖动画"] or false
    	local lssj = table.copy(self.奖池数据)
    	local sjsp = table.copy(self.水晶商品)
    	local hjdjb = table.copy(hjdj)
    	local cjjh = 玩家数据[数字id].角色.抽奖机会 or 0
    	发送数据(连接id, 6601, {奖池=lssj,获得=hjdjb,幸运值=ljcj,满幸运=self.满幸运,水晶=mhsj,抽奖机会=cjjh,抽奖动画=cjdh,水晶商品=sjsp})
    elseif 序号==256 then
    	if self:取奖池总剩余() >= 1 then
    		self:抽奖处理(连接id,数字id,1)
    	else
    		self:更新奖池数据()
    		常规提示(数字id,"奖池已无剩余奖品，即将自动刷新，请关闭界面后再尝试！")
    	end
    elseif 序号==257 then
    	local jcsy = self:取奖池总剩余()
    	if jcsy >= 10 then
    		self:抽奖处理(连接id,数字id,10)
    	else
    		if jcsy >= 1 then
	    		常规提示(数字id,"奖池剩余奖品不足，只能单抽了。")
	    	else
	    	    常规提示(数字id,"奖池已无剩余奖品，请下周再来。")
	    	end
    	end
    elseif 序号==258 then
        self:领取奖励(连接id,数字id)
    elseif 序号==259 then
        self:水晶商店兑换(连接id,数字id,数据.道具编号)
    end
end

function 奖池抽奖类:抽奖处理(连接id,数字id,次数)
	if 玩家数据[数字id].角色.抽奖机会 == nil then
        玩家数据[数字id].角色.抽奖机会=0
    end
    if 玩家数据[数字id].角色.奖池累抽 == nil then
        玩家数据[数字id].角色.奖池累抽=0
    end
    if 玩家数据[数字id].角色.梦幻水晶 == nil then
        玩家数据[数字id].角色.梦幻水晶=0
    end
	if 玩家数据[数字id].角色.奖池获得~=nil then
		常规提示(数字id,"请先领取你获得的奖品。")
		return
	elseif tonumber(os.date("%w", os.time()))==0 and 服务端参数.小时+0 >=23 then
	    常规提示(数字id,"正在准备清空奖池，不可抽奖。")
		return
	elseif 玩家数据[数字id].角色.抽奖机会 < 次数 then
		常规提示(数字id,"抽奖机会不足，当前抽奖机会为"..玩家数据[数字id].角色.抽奖机会..'次')
		return
	elseif 玩家数据[数字id].角色:取空道具格子数量() < 次数*3 then
		local xyl = 次数*3
	    常规提示(数字id,"请先预留" ..xyl .."格背包。")
		return

	end
	local jchd = {}
	local data={}
	while true do
		local zjsj = 取随机数(1,100)
		local qsj = 取随机数(1,#self.奖池数据)
		if self.奖池数据[qsj].奖池数量 >= 1 and self.奖池数据[qsj].概率 >= zjsj then
			self.奖池数据[qsj].奖池数量 = self.奖池数据[qsj].奖池数量 - 1
			table.insert(jchd,self.奖池数据[qsj].道具编号)
			table.insert(data,self.奖池数据[qsj])
		end

		if #data == 次数 then
			break
		end
	end



	玩家数据[数字id].角色.抽奖机会 = 玩家数据[数字id].角色.抽奖机会 - 次数
	玩家数据[数字id].角色.奖池累抽 = 玩家数据[数字id].角色.奖池累抽 + 次数
	if 玩家数据[数字id].角色.奖池累抽 >= self.满幸运 then
		玩家数据[数字id].角色.奖池累抽 = 玩家数据[数字id].角色.奖池累抽 - self.满幸运
		玩家数据[数字id].角色.梦幻水晶 = 玩家数据[数字id].角色.梦幻水晶 + 1
		发送数据(连接id,1501,{名称="",模型="超级土地公公",对话="恭喜你获得一颗#Y/梦幻水晶#W/。梦幻水晶可在水晶商店兑换奖池道具哦，要是奖池无中意物品，可以留着梦幻水晶下期奖池刷新后再兑换。"})
	end
	if 玩家数据[数字id].角色.抽奖机会 < 0 then
		玩家数据[数字id].角色.抽奖机会=0
	end
	local mhsj = 玩家数据[数字id].角色.梦幻水晶 or 0
	local ljcj = 玩家数据[数字id].角色.奖池累抽 or 100
	local jcsj = table.copy(self.奖池数据)
	local fhdata = table.copy(data)
	local cjjh = 玩家数据[数字id].角色.抽奖机会 or 0
	玩家数据[数字id].角色.奖池获得 = jchd --只记录编号，还要写防抽了后下周领。
	发送数据(连接id,6602,{获得=fhdata,奖池=jcsj,抽奖机会=cjjh,幸运值=ljcj,水晶=mhsj})
end

function 奖池抽奖类:领取奖励(连接id,数字id)
	if 玩家数据[数字id].角色.奖池获得==nil then
		常规提示(数字id,"你已经领取过奖品了。")
	else
		for a=1,#玩家数据[数字id].角色.奖池获得 do
			local qbh = 玩家数据[数字id].角色.奖池获得[a]
			local data = table.copy(self.全部道具[qbh])
			local 给予数量 = data.给予数量
			data.概率 = nil
			data.给予数量 = nil
			data.奖池数量 = nil
			data.运行父函数 = nil
			if data.可叠加 then
				玩家数据[数字id].道具:给予道具(数字id,data.名称,给予数量,nil,nil,nil,data)
			else
			    for ab=1,给予数量 do
			   	  玩家数据[数字id].道具:给予道具(数字id,data.名称,nil,nil,nil,nil,data)
			    end
			end
		end
		玩家数据[数字id].角色.奖池获得 = nil
	end
end

function 奖池抽奖类:水晶商店兑换(连接id,数字id,道具编号)
	if 玩家数据[数字id].角色.梦幻水晶 == nil then
        玩家数据[数字id].角色.梦幻水晶=0
    end
	if self.水晶商品[道具编号]==nil then
		常规提示(数字id,"选中道具错误。")
	elseif 玩家数据[数字id].角色.梦幻水晶 <= 0 then
	    常规提示(数字id,"请获得水晶后再来找我兑换奖励。")
	else
		local data = table.copy(self.水晶商品[道具编号])
		local 给予数量 = data.给予数量
		data.运行父函数 = nil
		data.道具编号 = nil
		data.给予数量 = nil
		if data.可叠加 then
			玩家数据[数字id].道具:给予道具(数字id,data.名称,给予数量,nil,nil,nil,data)
		else
		    for ab=1,给予数量 do
		   	  玩家数据[数字id].道具:给予道具(数字id,data.名称,nil,nil,nil,nil,data)
		    end
		end
		玩家数据[数字id].角色.梦幻水晶 = 玩家数据[数字id].角色.梦幻水晶 - 1
		发送数据(连接id,6603,玩家数据[数字id].角色.梦幻水晶)
	end
end

function 奖池抽奖类:取奖池总剩余() --还剩多少道具可以抽，非数量
	local sy = 0
	for a=1,#self.奖池数据 do
		if self.奖池数据[a].奖池数量 > 0 then
			sy = sy +1
		end
	end
	return sy
end

return 奖池抽奖类