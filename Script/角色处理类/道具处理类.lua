-- @Author: baidwwy
-- @Date:   2024-11-14 12:45:49
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-04-12 17:45:17
-- @Author: baidwwy
-- @Date:   2024-11-14 12:45:49
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-12-13 17:24:33
-- @Author: baidwwy
-- @Date:   2024-10-20 02:54:08
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-20 17:15:52
-- @Author: baidwwy
-- @Date:   2024-09-11 20:07:56
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-10-29 19:43:48
local 道具处理类 = class()
local 图策范围={"项圈","护腕","铠甲"}
local qz=math.floor
local floor=math.floor
local random = 取随机数
local remove = table.remove
local 我的可回收物品={
	魔兽要诀=40000,
	彩果=20000,
	金刚石=100000,
	定魂珠=100000,
	避水珠=50000,
	夜光珠=100000,
	龙鳞=50000,
	红玛瑙=30000,
	太阳石=30000,
	舍利子=30000,
	黑宝石=30000,
	月亮石=30000,
	翡翠石=30000,
	神秘石=20000,
	光芒石=30000,
	星辉石=40000,
	精魄灵石=30000,
	金柳露=20000,
	超级金柳露=60000,
	净瓶玉露=30000,
	超级净瓶玉露=60000,
}
local 生日快乐可回收物品={
	魔兽要诀=40000,
	彩果=20000,
	金刚石=100000,
	定魂珠=100000,
	避水珠=50000,
	夜光珠=100000,
	龙鳞=50000,
	红玛瑙=30000,
	太阳石=30000,
	舍利子=30000,
	黑宝石=30000,
	月亮石=30000,
	神秘石=20000,
	光芒石=30000,
	星辉石=40000,
	精魄灵石=30000,
	金柳露=20000,
	超级金柳露=60000,
	净瓶玉露=30000,
	超级净瓶玉露=60000,
	高级魔兽要诀=50000,
	召唤兽内丹=50000,
	高级召唤兽内丹=30000,
}
local 其他可回收物品={
	魔兽要诀=40000,
	彩果=20000,
	金刚石=100000,
	定魂珠=100000,
	避水珠=50000,
	夜光珠=100000,
	龙鳞=50000,
	红玛瑙=30000,
	太阳石=30000,
	舍利子=30000,
	黑宝石=30000,
	月亮石=30000,
	神秘石=20000,
	光芒石=30000,
	星辉石=40000,
	精魄灵石=30000,
	金柳露=20000,
	超级金柳露=60000,
	净瓶玉露=30000,
	高级魔兽要诀=150000,
	召唤兽内丹=400000,
	高级召唤兽内丹=1000000,
	附魔宝珠=10000,
	制造指南书=50000,
	百炼精铁=50000,
}

local 右键合成宝石={
	红玛瑙=1,
	太阳石=1,
	舍利子=1,
	黑宝石=1,
	月亮石=1,
	神秘石=1,
	光芒石=1,
	翡翠石=1,
}

local 右键合成五宝={
	金刚石=1,
	定魂珠=1,
	避水珠=1,
	夜光珠=1,
	龙鳞=1,
}

local 右键合成神印={
	青龙印=1,
	白虎印=1,
	朱雀印=1,
	玄武印=1,
}

function 道具处理类:初始化(id,数字id)
	self.玩家id=数字id
	self.数据={}
	self.阵法名称={
		[3]="普通",
		[4]="风扬阵",
		[5]="虎翼阵",
		[6]="天覆阵",
		[7]="云垂阵",
		[8]="鸟翔阵",
		[9]="地载阵",
		[10]="龙飞阵",
		[11]="蛇蟠阵",
		[12]="鹰啸阵",
		[13]="雷绝阵",
	}
	self.飞行传送点={
		[1]={1001,336,217},
		[2]={1001,358,35},
		[3]={1501,65,112},
		[4]={1092,122,54},
		[5]={1070,106,158},
		[6]={1040,108,98},
		[7]={1226,117,48},
		[8]={1208,128,36},
	}
	self.kediejia={}
	self.kediejia["金银锦盒"]=999
	self.kediejia["月饼"]=99
	self.kediejia["五宝盒"]=999
	self.kediejia["金柳露"]=99
	self.kediejia["超级金柳露"]=99
	self.kediejia["净瓶玉露"]=99
	self.kediejia["超级净瓶玉露"]=99
	self.kediejia["金钥匙"]=99
	self.kediejia["银钥匙"]=99
	self.kediejia["铜钥匙"]=99
	self.kediejia["特殊兽诀·碎片"]=9999
	self.kediejia["超级兽诀·碎片"]=9999    --新加
	self.kediejia["60灵饰礼包"]=1
	self.kediejia["80灵饰礼包"]=99
	self.kediejia["100灵饰礼包"]=99
	self.kediejia["120灵饰礼包"]=99
	self.kediejia["140灵饰礼包"]=99

	self.kediejia["五宝"]=1
	self.kediejia["五宝盒"]=99
	self.kediejia["清灵净瓶"]=999
	self.kediejia["陨铁"]=999
	self.kediejia["神兜兜"]=999
	self.kediejia["修炼果"]=999
	self.kediejia["特技书"]=99
	self.kediejia["九转金丹"]=999
	self.kediejia["九转金丹礼包"]=999
	self.kediejia["160附魔宝珠礼包"]=99
	-- self.kediejia["附魔宝珠"]=99
	self.kediejia["八级玄灵珠礼包"]=99
	self.kediejia["6级钟灵石礼包"]=99
	self.kediejia["灵犀玉礼包"]=99
	self.kediejia["高级宝石礼包"]=99
	self.kediejia["装备特效宝珠礼包"]=99
	self.kediejia["陨铁礼包"]=99
	self.kediejia["160钨金礼包"]=99

  self.kediejia["高级星辉石礼包"]=99
	self.kediejia["装备特效宝珠"]=999
	self.kediejia["灵饰特效宝珠"]=999
	self.kediejia["特效宝珠"]=999
	self.kediejia["灵犀玉礼包"]=999
	self.kediejia["灵犀之屑"]=999
	self.kediejia["灵兜兜"]=999
	self.kediejia["易经丹"]=99
	self.kediejia["符石卷轴"]=99
	self.kediejia["修炼果礼包"]=99
	self.kediejia["神兜兜礼包"]=99
	self.kediejia["月华露"]=99
	self.kediejia["技能突破符"]=999
	self.kediejia["宝石礼包"]=99
	self.kediejia["十万银票"]=99
	self.kediejia["百万银票"]=99
	self.kediejia["千万银票"]=99
	self.kediejia["一亿银票"]=99
	self.kediejia["十亿银票"]=99
	self.kediejia["百亿银票"]=99
	self.kediejia["千亿银票"]=99
	self.kediejia["万亿银票"]=99

	self.kediejia["十点仙玉"]=99
	self.kediejia["一百仙玉"]=99
	self.kediejia["一千仙玉"]=99
	self.kediejia["一万仙玉"]=99
	self.kediejia["十万仙玉"]=99
	self.kediejia["百万仙玉"]=99
	self.kediejia["千万仙玉"]=99
	self.kediejia["一亿仙玉"]=99
	self.kediejia["十亿仙玉"]=99
	self.kediejia["百亿仙玉"]=99
	self.kediejia["千亿仙玉"]=99
	self.kediejia["万亿仙玉"]=99
	self.kediejia["随机仙玉礼包"]=99
	self.kediejia["随机仙玉微礼包"]=99
	self.kediejia["随机仙玉小礼包"]=99
	self.kediejia["随机仙玉中礼包"]=99
	self.kediejia["随机仙玉大礼包"]=99

	self.kediejia["随机经验礼包"]=99
	self.kediejia["随机经验微礼包"]=99
	self.kediejia["随机经验小礼包"]=99
	self.kediejia["随机经验中礼包"]=99
	self.kediejia["随机经验大礼包"]=99

	self.kediejia["菩提果"]=9999

	self.kediejia["特殊清灵仙露"]=99
	self.kediejia["魔兽要诀"]=99
	self.kediejia["高级魔兽要诀"]=99
	self.kediejia["超级魔兽要诀"]=99
	self.kediejia["特殊魔兽要诀"]=99
	self.kediejia["召唤兽内丹"]=99
	self.kediejia["高级召唤兽内丹"]=99
	self.kediejia["修业通天录"]=9999
	self.kediejia["四象天罡印"]=9999
	self.kediejia["青龙印"]=9999
	self.kediejia["白虎印"]=9999
	self.kediejia["朱雀印"]=9999
	self.kediejia["玄武印"]=9999
	self.kediejia["珍珠"]=1


	self.js=os.time()
	self.jingzhi=0
	self.xiaxian=0
end

function 道具处理类:取可叠加(名称) --剑会天下
	local fh = false
	if self.kediejia[名称] then fh = true end
	return fh
end


function 道具处理类:加载数据(账号,数字id)
	self.数字id=数字id
	self.数据=table.loadstring(读入文件(程序目录..[[data/]]..账号..[[/]]..数字id..[[/道具.txt]]))
	if not self.数据 then
		常规提示(数字id,"#Y账号道具异常请与GM联系")
		return
	end
	for n, v in pairs(self.数据) do
		if self.数据[n].名称==nil then
			self.数据[n]=nil
		end
		if n~=nil and self.数据[n]~=nil and self.数据[n].名称~=nil and self.数据[n].名称=="帮派银票" then
			local 是否存在 = false
			for i=1,20 do
				if 玩家数据[数字id].角色.道具[i] ~= nil and 玩家数据[数字id].角色.道具[i] == n then
					是否存在 = true
				end
			end
			if 是否存在 == false then
				self.数据[n] = nil
			end
		end
	end
end

function 道具处理类:数据处理(连接id,序号,数字id,数据)
	-- if self.js then
	-- 	if os.time()==self.js then
	-- 	    self.jingzhi=self.jingzhi+1
	   --      if self.jingzhi>=5 then --禁止1秒内连续点击5此以上
	   --          self.jingzhi=0
	   --          self.xiaxian=self.xiaxian+1
	   --          常规提示(数字id,"#Y/请勿频繁操作。")
	   --          if self.xiaxian>=200 then
		  --   		发送数据(连接id,998,"操作过于频繁")
		  --   		__S服务:断开连接(连接id)
		  --   	end
	   --          return
	   --      end
	   --  else
	   --  	self.jingzhi=0
	-- 	end
	-- 	self.js=os.time()
	-- end

	if 玩家数据[数字id].摊位数据~=nil then
		if 序号~=3699 and 序号~=3700 and 序号~=3720 and 序号~=3721 and 序号~=3722 and 序号~=3723 and 序号~=3724 and 序号~=3725 then
			常规提示(数字id,"#Y/摆摊状态下禁止此种行为")
			return
		end

	elseif 玩家数据[数字id].角色.体验状态 then
		if 序号==3715 or 序号==3716 or 序号==3717 or 序号==3718 or 序号==3720 or 序号==3722 or 序号==3725 or 序号==3726 then
			常规提示(数字id,"体验状态下无法进行此操作。")
			return
		end
	end

	if 序号==3699 then
		self:索要道具(连接id,数字id)
	elseif 序号==3700 then
		self:索要行囊(连接id,数字id)
	elseif 序号==3701 then
		self:道具格子互换(连接id,数字id,数据)
	elseif 序号==3702 then
		self:丢弃道具(连接id,数字id,数据)
	elseif 序号==3703 then
		self:佩戴装备(连接id,数字id,数据)
	elseif 序号==3704 then
		self:卸下装备(连接id,数字id,数据)
	elseif 序号==3705 then
		self:使用道具(连接id,数字id,数据)
	elseif 序号==3706 then
		self:飞行符传送(连接id,数字id,数据)
	elseif 序号==3740 then
		self:新春飞行符传送(连接id,数字id,数据)
	elseif 序号==3707 then
		发送数据(连接id,14,玩家数据[数字id].道具:索要道具1(数字id))
	elseif 序号==3708 then
		self:佩戴bb装备(连接id,数字id,数据)
	elseif 序号==3709 then
		self:卸下bb装备(连接id,数字id,数据)
	elseif 序号==3710 then
		self:染色处理(连接id,数字id,数据)
	elseif 序号==3711 then
		玩家数据[数字id].角色:学习门派技能(连接id,数字id,数据.序列)
	elseif 序号==3711.1 then
		 for i=1,10 do
		玩家数据[数字id].角色:学习门派技能(连接id,数字id,数据.序列)
           end
	elseif 序号==3712 then
		玩家数据[数字id].角色:学习生活技能(连接id,数字id,数据.序列)
	elseif 序号==3712.9 then
		玩家数据[数字id].角色:学习强化技能(连接id,数字id,数据.序列)
	elseif 序号==3713 then
		self:烹饪处理(连接id,数字id,1)
	elseif 序号==3714 then
		self:炼药处理(连接id,数字id,1)
	elseif 序号==3715 then
		self:给予处理(连接id,数字id,数据)
	elseif 序号==3716 then --请求给予
		玩家数据[数字id].给予数据={类型=2,id=数据.id+0}
		发送数据(连接id,3507,{道具=self:索要道具1(数字id),名称=玩家数据[数据.id+0].角色.名称,类型="玩家",等级=玩家数据[数据.id+0].角色.等级})
	elseif 序号==3717 then
		self:设置交易数据(连接id,数字id,数据)
	elseif 序号==3718 then
		self:发起交易处理(连接id,数字id,数据.id)
	elseif 序号==3719 then
		self:取消交易(数字id)
	elseif 序号==3720 then --自己创建、索要摊位
		self:索要摊位数据(连接id,数字id,3515)
	elseif 序号==3721 then --更改招牌
		self:更改摊位招牌(连接id,数字id,数据.名称)
	elseif 序号==3722 then --上架
		self:摊位上架商品(连接id,数字id,数据)
	elseif 序号==3723 then --下架
		self:摊位下架商品(连接id,数字id,数据)
	elseif 序号==3724 then --收摊
		self:收摊处理(连接id,数字id)
	elseif 序号==3725 then --索取其他玩家摊位
		self:索要其他玩家摊位(连接id,数字id,数据.id,3521)
	elseif 序号==3726 then --购买摊位商品
		self:购买摊位商品(连接id,数字id,数据)
	elseif 序号==3726.1 then
	   self:购买摊位制造商品(连接id,数字id,数据)
	elseif 序号==3727 then
		self:快捷加血(连接id,数字id,数据.类型)
	elseif 序号==3728 then
		self:快捷加蓝(连接id,数字id,数据.类型)
	elseif 序号==3732 then
		self:索要法宝(连接id,数字id)
	elseif 序号==3733 then
		self:修炼法宝(连接id,数字id,数据.序列)
	elseif 序号==3733.1 then
		self:法宝补充灵气(连接id,数字id,数据.序列)
	elseif 序号==3734 then
		self:卸下法宝(连接id,数字id,数据.序列,数据.神器)
	elseif 序号==3735 then
		self:替换法宝(连接id,数字id,数据.序列,数据.序列1)
	elseif 序号==3736 then
		self:使用法宝(连接id,数字id,数据.序列)
	elseif 序号==3737 then
		self:使用合成旗(连接id,数字id,数据.序列)
	elseif 序号==3739 then
		self:开运(连接id,数字id,数据.格子)
	-- elseif 序号==3740 then
		-- self:符石镶嵌(连接id,数字id,数据)
	-- elseif 序号==3741 then
		-- self:符石卸下(连接id,数字id,数据)
	-- elseif 序号==3742 then
		-- self:符石组合(连接id,数字id,数据)
	-- elseif 序号==3743 then
		-- self:星位(连接id,数字id,数据.格子)
	-- elseif 序号==3744 then
		-- self:星位镶嵌(连接id,数字id,数据)
	-- elseif 序号==3745 then
		-- self:星位卸下(连接id,数字id,数据)
	elseif 序号==3746 then
		self:道具转移(连接id,数字id,数据)
	elseif 序号==3747 then
		self:坐骑装饰卸下(连接id,数字id,数据)
	elseif 序号==3748 then --请求给予
		玩家数据[数字id].给予数据={类型=1,地图=数据.地图,编号=数据.编号,序号=数据.序号,标识=数据.标识,名称=数据.名称,模型=数据.模型}
		发送数据(连接id,3530,{道具=self:索要道具1(数字id),名称=数据.名称,类型="NPC"})
	elseif 序号==3749 then
		self:临时背包处理(连接id,数字id,数据)
	elseif 序号==3750 then
		self:索要任务(连接id,数字id)
	elseif 序号==3751 then
		self:索要道具更新(数字id,数据.类型)
	elseif 序号==3752 then
		self:修炼灵宝(连接id,数字id,数据.序列)
	elseif 序号==3753 then
		self:卸下灵宝(连接id,数字id,数据.序列)
	elseif 序号==3754 then
		self:替换灵宝(连接id,数字id,数据.序列,数据.序列1)
	elseif 序号==3755 then
		self:使用灵宝(连接id,数字id,数据.序列)
	elseif 序号==3738 then
		self:符纸使用(连接id,数字id,数据)
	elseif 序号==3758 then
		self:鉴定专用装备(连接id,数字id,数据)
	elseif 序号==3759 then
		self:吸附兽诀(连接id,数字id,数据)
	elseif 序号==3760 then
		降妖伏魔:铃铛抽奖(连接id,数字id,数据)
	elseif 序号==3761 then
		降妖伏魔:铃铛处理(连接id,数字id,数据)
	elseif 序号==3762 then
		self:宝宝进阶(连接id,数字id,数据)
	elseif 序号==3763 then
		self:装备点化套装(连接id,数字id,数据)
	elseif 序号==3779 then
     self:合成精炼之锤(数字id,数据)
  elseif 序号==3780 then
     self:精炼锻造(数字id,数据.选择,数据.选择1)
  elseif 序号==3781 then
     self:一键精炼锻造(数字id,数据.选择,数据.选择1)
  elseif 序号 == 3782 then
   self:获取套装数据(数字id)
	elseif 序号==3800 then
		if 数据.类型=="道具" then
			玩家数据[数字id].符石镶嵌=玩家数据[数字id].角色.道具[数据.装备]
		else
			玩家数据[数字id].符石镶嵌=玩家数据[数字id].角色.行囊[数据.装备]
		end
		发送数据(玩家数据[数字id].连接id,3550,{装备=self.数据[玩家数据[数字id].符石镶嵌]})
	elseif 序号==3801 then
		self:装备镶嵌符石(数字id,数据.内容)
	elseif 序号==3802 then
		self:翻转星石对话(数字id)
	elseif 序号==3803 then
		self:合成符石(连接id,数字id,数据)
	elseif 序号==3806 then	 --道具拆分
		self:拆分道具(连接id,数字id,数据)
	elseif 序号==3770 then
		self:装备开启星位(连接id,数字id,数据)
	elseif 序号==3778 then
    self:灵饰自选(连接id,数字id,数据)
	elseif 序号==3780 then --新增
		if 数据.道具类型 == "道具" then
			发送数据(玩家数据[数字id].连接id,3535,{类型="道具",数据=self:索要道具2(数字id)})
		elseif 数据.道具类型 == "行囊" then
			发送数据(玩家数据[数字id].连接id,3535,{类型="行囊",数据=self:索要行囊2(数字id)})
		end
	elseif 序号==3781 then --新增 光武拓印
		self:获取光武拓印(连接id,数字id,数据)
	elseif 序号==3782 then --新增 光武拓印
		发送数据(连接id,233,{nil,nil,nil,nil,"光武拓印"})



	elseif 序号==3782.1 then --新增 合宠物品
		发送数据(连接id,233.1,"合宠物品")


	elseif 序号==3781.1 then --新增 合宠物品
		self:获取合宠物品(连接id,数字id,数据)





	elseif 序号==3783 then --新增 光武拓印
		self:光武拓印转化(连接id,数字id,数据)
	elseif 序号==3784 then
		self:宝宝坐骑喂养(连接id,数字id,数据)
	elseif 序号==3784.1 then
		self:修业点兑换(连接id,数字id,数据)
	elseif 序号==3785 then
			self:一键回收(连接id,数字id,数据)
	elseif 序号==3811 then
		self:灵犀之屑合成(连接id,数字id,数据)
	elseif 序号==3813 then
		self:镶嵌灵犀玉(数字id,数据)
	elseif 序号==3814 then
		self:激活天赋符(连接id,数字id,数据)
	elseif 序号==3815 then
		self:整理背包(连接id,数字id)
	elseif 序号==3816 then
		self:武器染色(连接id,数字id,数据)
	elseif 序号==3817 then
		local 神器类=require("Script/角色处理类/神器类")()
      神器类:切换神器(数字id)
    elseif 序号==3818 then
		self:索要新道具1(连接id,数字id)
	-- elseif 序号==3817 then
	-- 	self:索要新道具2(连接id,数字id)
	-- elseif 序号==3818 then
	-- 	self:索要新道具3(连接id,数字id)
	elseif 序号==3819 then --超级合成旗
    self:使用超级合成旗(连接id,数字id,数据)
	elseif 序号==3820 then
    self:侵蚀系统(连接id,数字id,数据)
	elseif 序号==3888 then --灵宝丢弃
    self:丢弃灵宝(连接id,数字id,数据)
  elseif 序号==3823 then
    self:侵蚀洗练系统(连接id,数字id,数据)
	-------------神器
	 elseif 序号==3801.4 then
    self:进化宝宝(连接id,数字id,数据)
   elseif 序号==3801.5 then
    self:兑换宝宝(连接id,数字id,数据)


 	 elseif 序号 == 3832 then
    local 类型 = "杂货"
    local 参数 = 数据.序列
    if 参数 == 1 then
     类型 = "杂货"
    elseif 参数 == 2 then
     类型 = "宝石"
    elseif 参数 == 3 then
     类型 = "兽诀"
    elseif 参数 == 4 then
      类型 = "高兽诀"
    elseif 参数 == 5 then
      类型 = "特兽诀"
    elseif 参数 == 6 then
      类型 = "打造"
    elseif 参数 == 7 then
      类型 = "装备"
    end
    发送数据(玩家数据[数字id].连接id,3555,self:索要临时行囊(数字id,类型,参数))
    self:整理临时行囊啊(数字id,类型,参数)

  elseif 序号 == 3833 then
    local 参数=数据.序列
    local 物品 = 数据.物品
   if 参数 == 1 then
      类型 = "杂货"
    elseif 参数 == 2 then
     类型 = "宝石"
    elseif 参数 == 3 then
     类型 = "兽诀"
    elseif 参数 == 4 then
     类型 = "高兽诀"
    elseif 参数 == 5 then
      类型 = "特兽诀"
    elseif 参数 == 6 then
     类型 = "打造"
    elseif 参数 == 7 then
     类型 = "装备"
   end
   local wpxh = tonumber(物品)+0
   local wpid = 玩家数据[数字id].角色.临时行囊[类型][wpxh]
    if wpid  == nil then
     return  0
   end
   local 临时格子 =  玩家数据[数字id].角色:取道具格子()
    if 临时格子 == 0 then
      常规提示(数字id,"#y/包裹已满，无可用的格子。")
      return 0
     end
   玩家数据[数字id].角色.道具[临时格子] = 玩家数据[数字id].角色.临时行囊[类型][wpxh]
   玩家数据[数字id].角色.临时行囊[类型][wpxh] = nil
   发送数据(玩家数据[数字id].连接id,3555,self:索要临时行囊(数字id,类型,参数))
   道具刷新(数字id)

   elseif 序号 == 3834 then
      for n=1,80 do
      local 道具id=玩家数据[数字id].角色.道具[n]
    if self.数据[道具id]~=nil  then
    local 物品类型 = ""
   if self.数据[道具id].名称 == "魔兽要诀"  then
   物品类型 = "兽诀"
   elseif self.数据[道具id].名称 == "高级魔兽要诀" then
   物品类型 = "高兽诀"
    elseif self.数据[道具id].名称 == "上古锻造图策" then
   物品类型 = "宝石"
    elseif self.数据[道具id].名称 ==  "特殊魔兽要诀" then
   物品类型 = "特兽诀"
   elseif self.数据[道具id].总类 == 5 and self.数据[道具id].分类==6 then
   物品类型 = "宝石"
    elseif self.数据[道具id].总类 == 5 and self.数据[道具id].分类==1 or (self.数据[道具id].总类 == 5 and self.数据[道具id].分类==2) or (self.数据[道具id].总类 == 5 and self.数据[道具id].分类==20) or (self.数据[道具id].总类 == 5 and self.数据[道具id].分类==21) then
   物品类型 = "打造"
    elseif self.数据[道具id].总类 == 2  then
   物品类型 = "装备"
   elseif self.数据[道具id].名称 == "飞行符" or self.数据[道具id].名称 == "回梦丹" or self.数据[道具id].名称 =="秘制红罗羹" or self.数据[道具id].名称 =="秘制绿芦羹"  or self.数据[道具id].名称 =="新春飞行符" or self.数据[道具id].名称 =="摄妖香" or self.数据[道具id].名称 =="洞冥草" or self.数据[道具id].名称 =="包子" or self.数据[道具id].名称 =="顺逆神针" then
    物品类型 = "不存仓"
   elseif self.数据[道具id].名称 == "附加专用符"  then
    物品类型 = "不存仓"
   elseif self.数据[道具id].不可交易 == true  then
   物品类型 = "不存仓"
   elseif self.数据[道具id].名称 == "超级合成旗" or self.数据[道具id].名称 == "九眼天珠"  or self.数据[道具id].名称 == "上古锻造图策"  then
    物品类型 = "不存仓"
   elseif self.数据[道具id].名称 == "红色合成旗" or self.数据[道具id].名称 == "黄色合成旗" or self.数据[道具id].名称 == "蓝色合成旗" or self.数据[道具id].名称 == "绿色合成旗" or self.数据[道具id].名称 == "白色合成旗"  then
    物品类型 = "不存仓"
   else
   物品类型 = "杂货"
   end
   if 物品类型=="不存仓" then
   else
   local 新格子  =  玩家数据[数字id].角色:取可用临时行囊格子(数字id,物品类型)
   if 新格子>0 then
     玩家数据[数字id].角色.临时行囊[物品类型][新格子] = 玩家数据[数字id].角色.道具[n]
     玩家数据[数字id].角色.道具[n] = nil
   else
   	常规提示(数字id,"临时仓库已满，请及时清理")
     end
   end
  end
end
   道具刷新(数字id)
   发送数据(玩家数据[数字id].连接id,3555,self:索要临时行囊(数字id,"杂货",1))

   elseif 序号 == 3835 then
    local 类型 = "杂货"
    local 参数 = 数据.序列
    if 参数 == 1 then
     类型 = "杂货"
    elseif 参数 == 2 then
     类型 = "宝石"
    elseif 参数 == 3 then
     类型 = "兽诀"
    elseif 参数 == 4 then
      类型 = "高兽诀"
    elseif 参数 == 5 then
      类型 = "特兽诀"
    elseif 参数 == 6 then
      类型 = "打造"
    elseif 参数 == 7 then
      类型 = "装备"
  end
     self:整理临时行囊(数字id,类型,参数)
    elseif 序号 == 3836 then
      local id=数字id
    if 玩家数据[id].角色.自动存仓==nil then
      玩家数据[id].角色.自动存仓=0
    end

    if 玩家数据[id].角色.自动存仓==0 then
      玩家数据[id].角色.自动存仓=1
        常规提示(id,"自动存仓已开启")
    else
      玩家数据[id].角色.自动存仓=0
      常规提示(id,"自动存仓已关闭")
    end
    -------------------------超级技能
	elseif 序号 == 3900 then
	 	self:制作仙露丸子(连接id,数字id,数据.材料1,数据.材料2)
	elseif 序号 == 3901 then
	    发送数据(连接id,16,玩家数据[数字id].召唤兽.数据)
	    发送数据(玩家数据[数字id].连接id,352,{道具=玩家数据[数字id].道具:索要道具1(数字id),丸子赐福={进程=1,技能={},认证码=0}})
	elseif 序号 == 3902 then
	    self:丸子赐福处理(连接id,数字id,数据.材料,数据.bb,数据.认证码,数据.锁定)
	elseif 序号 == 3903 then
	    玩家数据[数字id].召唤兽:保存赐福技能(连接id,数字id,数据.bb,数据.认证码,数据.锁定,数据.技能)
	----------------武神坛
  elseif 序号==3901.9 then
    self:wst书铁商店购买(数字id,数据.数量,数据.选中,数据.商店类型)
  elseif 序号==3902.9 then
    self:wst法宝商店购买(数字id,数据.选中,数据.商店类型)
  elseif 序号==3903.9 then
    self:wst灵宝商店购买(数字id,数据.选中)
  elseif 序号==3904.9 then
    self:wst宝石商店购买(数字id,数据.选中)
  elseif 序号==3905.9 then
    self:wst强化符商店购买(数字id,数据.选中)
  elseif 序号==3906.9 then
    self:wst药品商店购买(数字id,数据.选中)
  elseif 序号==3907 then --武神坛8.25
    self:wst积分商店购买(数字id,数据.选中,数据.数量)


	end
	数据=nil
end



-------------------------------------------------------------武神坛 始
function 道具处理类:wst书铁商店购买(数字id,数量,选中,商店类型)
	  if 玩家数据[数字id].角色.武神坛角色==nil then return end
	  if tonumber(数量)~=nil then
  			数量 = 数量+0
  	else
  	    数量 = 1
  	end
	  local wj账号
  	if 玩家数据[数字id].账号 ~= nil then
  		wj账号 = 玩家数据[数字id].账号
  	elseif 玩家数据[数字id].角色.账号 ~= nil then
  	  wj账号 = 玩家数据[数字id].角色.账号
  	end
  	if not wj账号 then return end
  	local 临时道具a,临时道具b,临时道具c = 武神坛数据[wj账号]:取wst书铁商店()
  	if 商店类型=="bb类" then
  		if type(临时道具c)=="table" and 临时道具c[选中]~=nil then
  			临时道具c[选中].不可交易 = true
  			临时道具c[选中].专用 = 数字id
  			if 临时道具c[选中].名称=="召唤兽内丹" then
  				if 临时道具c[选中].特效 == nil then
	  				临时道具c[选中].特效=取内丹("低级")
	  			end
  			elseif 临时道具c[选中].名称=="高级召唤兽内丹" then
  				if 临时道具c[选中].特效 == nil then
	  				临时道具c[选中].特效=取内丹("高级")
	  			end
  			end
		    if 临时道具c[选中].可叠加 then
					临时道具c[选中].数量 = 数量
					self:给予道具(数字id,临时道具c[选中].名称,数量,nil,"不存共享","专用",临时道具c[选中])
				else
				    if 数量 > 10 then 数量=10 end --不叠加的最多买10个
				    for an=1,数量 do
					    self:给予道具(数字id,临时道具c[选中].名称,nil,nil,"不存共享","专用",临时道具c[选中])
					  end
				end
  		end
  	elseif 商店类型=="书" then
  		if type(临时道具a)=="table" and 临时道具a[选中]~=nil then
  			if 数量 > 10 then 数量=10 end --不叠加的最多买10个
  			临时道具a[选中].不可交易 = true
  			临时道具a[选中].专用 = 数字id
		    for an=1,数量 do
			    self:给予道具(数字id,临时道具a[选中].名称,nil,nil,"不存共享","专用",临时道具a[选中])
			  end
  		end
		elseif 商店类型=="其它" then
			if type(临时道具a)=="table" and 临时道具b[选中]~=nil then
				临时道具b[选中].不可交易 = true
  			临时道具b[选中].专用 = 数字id
				if 临时道具b[选中].可叠加 then
					临时道具b[选中].数量 = 数量
					self:给予道具(数字id,临时道具b[选中].名称,数量,nil,"不存共享","专用",临时道具b[选中])
				else
				    if 数量 > 10 then 数量=10 end --不叠加的最多买10个
				    for an=1,数量 do
					    self:给予道具(数字id,临时道具b[选中].名称,nil,nil,"不存共享","专用",临时道具b[选中])
					  end
				end
  		end
		end
		道具刷新(数字id)
		发送数据(玩家数据[数字id].连接id,14,玩家数据[数字id].道具:索要道具1(数字id))
end

function 道具处理类:wst法宝商店购买(数字id,选中,商店类型) --武神坛
	  if 玩家数据[数字id].角色.武神坛角色==nil then return end
	  local wj账号
  	if 玩家数据[数字id].账号 ~= nil then
  		wj账号 = 玩家数据[数字id].账号
  	elseif 玩家数据[数字id].角色.账号 ~= nil then
  	  wj账号 = 玩家数据[数字id].角色.账号
  	end
  	if not wj账号 then return end
	  local dja,djb,djc,djd = 武神坛数据[wj账号]:取wst法宝商店()
	  local 临时道具
	  if 商店类型==1 then
	  	临时道具=dja
	  elseif 商店类型==2 then
	    临时道具=djb
	  elseif 商店类型==3 then
	    临时道具=djc
	  elseif 商店类型==4 then
	    临时道具=djd
	  end
	  if type(临时道具)=="table" and 临时道具[选中]~=nil then
			self:给予法宝(数字id,临时道具[选中].名称)
	  end
	  道具刷新(数字id)
		发送数据(玩家数据[数字id].连接id,14,玩家数据[数字id].道具:索要道具1(数字id))
end

function 道具处理类:wst灵宝商店购买(数字id,选中,商店类型) --武神坛
	  if 玩家数据[数字id].角色.武神坛角色==nil then return end
	  local wj账号
  	if 玩家数据[数字id].账号 ~= nil then
  		wj账号 = 玩家数据[数字id].账号
  	elseif 玩家数据[数字id].角色.账号 ~= nil then
  	  wj账号 = 玩家数据[数字id].角色.账号
  	end
  	if not wj账号 then return end
  	local 临时道具 = 武神坛数据[wj账号]:取wst灵宝商店()
  	if type(临时道具)=="table" and 临时道具[选中]~=nil then
			self:给予灵宝(数字id,临时道具[选中].名称)
	  end
	  道具刷新(数字id)
		发送数据(玩家数据[数字id].连接id,14,玩家数据[数字id].道具:索要道具1(数字id))
end
function 道具处理类:wst宝石商店购买(数字id,选中) --武神坛
	  if 玩家数据[数字id].角色.武神坛角色==nil then return end
	  local wj账号
  	if 玩家数据[数字id].账号 ~= nil then
  		wj账号 = 玩家数据[数字id].账号
  	elseif 玩家数据[数字id].角色.账号 ~= nil then
  	  wj账号 = 玩家数据[数字id].角色.账号
  	end
  	if not wj账号 then return end
  	local 临时道具 = 武神坛数据[wj账号]:取wst宝石商店()
  	if type(临时道具)=="table" and 临时道具[选中]~=nil then
			临时道具[选中].不可交易 = true
			临时道具[选中].专用 = 数字id
	    self:给予道具(数字id,临时道具[选中].名称,nil,nil,"不存共享","专用",临时道具[选中])
		end
end
function 道具处理类:wst强化符商店购买(数字id,选中) --武神坛
	  if 玩家数据[数字id].角色.武神坛角色==nil then return end
	  local wj账号
  	if 玩家数据[数字id].账号 ~= nil then
  		wj账号 = 玩家数据[数字id].账号
  	elseif 玩家数据[数字id].角色.账号 ~= nil then
  	  wj账号 = 玩家数据[数字id].角色.账号
  	end
  	if not wj账号 then return end
  	local 临时道具 = 武神坛数据[wj账号]:取wst强化符商店()
  	if type(临时道具)=="table" and 临时道具[选中]~=nil then
			临时道具[选中].不可交易 = true
			临时道具[选中].专用 = 数字id
	    self:给予道具(数字id,临时道具[选中].名称,nil,nil,"不存共享","专用",临时道具[选中])
		end
end

function 道具处理类:wst药品商店购买(数字id,选中) --武神坛
	  if 玩家数据[数字id].角色.武神坛角色==nil then return end
	  local wj账号
  	if 玩家数据[数字id].账号 ~= nil then
  		wj账号 = 玩家数据[数字id].账号
  	elseif 玩家数据[数字id].角色.账号 ~= nil then
  	  wj账号 = 玩家数据[数字id].角色.账号
  	end
  	if not wj账号 then return end
  	local 临时道具 = 武神坛数据[wj账号]:取wst药品商店()
  	if type(临时道具)=="table" and 临时道具[选中]~=nil then
  		if 临时道具[选中].可叠加 then
  		  临时道具[选中].数量 = 99
  		end
			临时道具[选中].不可交易 = true
			临时道具[选中].专用 = 数字id
	    self:给予道具(数字id,临时道具[选中].名称,nil,nil,"不存共享","专用",临时道具[选中])
		end
end

function 道具处理类:wst积分商店购买(数字id,选中,sl) --武神坛8.25
	  local 数量 = sl + 0
	  if 数量 <= 0 then 数量=1 end
	  local 拥有积分 = _武神坛记录.积分[数字id]
	  if 拥有积分 == nil then
	  	常规提示(数字id,"你没有积分")
	  	return
	  end
	  local wj账号
  	if 玩家数据[数字id].账号 ~= nil then
  		wj账号 = 玩家数据[数字id].账号
  	elseif 玩家数据[数字id].角色.账号 ~= nil then
  	  wj账号 = 玩家数据[数字id].角色.账号
  	end
  	if not wj账号 then return end
  	local 临时道具 = 武神坛数据[wj账号]:取积分兑换商店()
  	if type(临时道具)=="table" and 临时道具[选中]~=nil then
  		if 拥有积分 < 临时道具[选中].价格 * 数量 then
	  		常规提示(数字id,"积分不足以购买")
		  	return
	  	end
  		if 临时道具[选中].可叠加 then
  		  临时道具[选中].数量 = 数量
  		  self:给予道具(数字id,临时道具[选中].名称,nil,nil,"不存共享","专用",临时道具[选中])
  		else
  			if 数量 > 10 then
  				数量=10
  				常规提示(数字id,"不可叠加物品单次最多购买10个")
  			end
  		  for an = 1,数量 do
  		  	self:给予道具(数字id,临时道具[选中].名称,nil,nil,"不存共享","专用",临时道具[选中])
  		  end
  		end
		end
		local 扣除 = 临时道具[选中].价格 * 数量
		_武神坛记录.积分[数字id] = _武神坛记录.积分[数字id] - 扣除
		if _武神坛记录.积分[数字id] <= 0 then
			_武神坛记录.积分[数字id] = nil
		end
		local syjf = _武神坛记录.积分[数字id] or 0
		发送数据(玩家数据[数字id].连接id, 6160, {积分=syjf})
end
-------------------------------------------------------------武神坛 终

function 道具处理类:网关给予书铁(id,等级,名称,种类) --比武
	  local 书铁等级=取随机数(等级[1]*10,等级[2]*10)
	  书铁等级=math.floor(书铁等级/10)*10
	  self.书铁名称=名称
	  self:给予道具(id,self.书铁名称,书铁等级,种类)
	  return {self.书铁名称,书铁等级,种类}
end

function 道具处理类:制作仙露丸子(连接id,id,材料1,材料2)
	local 神兽涎=玩家数据[id].角色.道具[材料1]
	local 小丸子=玩家数据[id].角色.道具[材料2]
	if self.数据[神兽涎]==nil or self.数据[小丸子]==nil or self.数据[神兽涎].名称~="神兽涎" or self.数据[小丸子].名称~="仙露小丸子" then 常规提示(id,"道具数据有误,请忽移动背包道具") return end
    if self.数据[小丸子].数量 < 10 then 常规提示(id,"你的仙露小丸子不够10个哦") return end
    if 玩家数据[id].角色.体力 < 100 then 常规提示(id,"你没有那么多的体力！") return end
    玩家数据[id].角色.体力 = 玩家数据[id].角色.体力-100
    self.数据[神兽涎].数量 = self.数据[神兽涎].数量 - 1
    self.数据[小丸子].数量 = self.数据[小丸子].数量 - 10
    if self.数据[神兽涎].数量 <= 0 then
    	self.数据[神兽涎]=nil
    	玩家数据[id].角色.道具[材料1]=nil
    end
    if self.数据[小丸子].数量 <= 0 then
    	self.数据[小丸子]=nil
    	玩家数据[id].角色.道具[材料2]=nil
    end
    self:给予道具(id,"仙露丸子",取随机数(2,6))
    发送数据(玩家数据[id].连接id,15,{体力=玩家数据[id].角色.体力,活力=玩家数据[id].角色.活力})
    发送数据(连接id,3513,玩家数据[id].道具:索要道具2(id))
    发送数据(玩家数据[id].连接id,351,玩家数据[id].道具:索要道具1(id))
end

	-- elseif 名称=="指定元素曜石" then
	-- local 对话="#W/请选择所需要的元素曜石"
	-- local 门派={"元素曜石·冰","元素曜石·风","元素曜石·火","元素曜石·雷","元素曜石·水"
	-- 	,"元素曜石·岩"}
	-- local xx={}
	-- for i = 1,#门派 do
	-- 	xx[#xx+1]=门派[i]
	-- end
	-- 玩家数据[id].最后对话={}
	-- 玩家数据[id].最后对话.名称="指定元素曜石"
	-- 玩家数据[id].最后对话.模型=玩家数据[id].角色.模型
	-- 发送数据(玩家数据[id].连接id,1501,{名称="指定元素曜石",模型=玩家数据[id].角色.模型,对话=对话,选项=xx})
	-- return
----------------------------------------
function 道具处理类:丸子赐福处理(连接id,id,材料,bbbh,认证码,锁定)
	local qsdcd=0
	local xhsx={[1]=1,[2]=5,[3]=25}
	for k,v in pairs(锁定) do
		qsdcd=qsdcd+1
	end
	if qsdcd > 2 then return end --防错，最多锁定2个技能
	local xiaohao = qsdcd + 1
	local 丸子=玩家数据[id].角色.道具[材料]
	if 玩家数据[id].召唤兽.数据[bbbh] == nil or  玩家数据[id].召唤兽.数据[bbbh].认证码~=认证码 then 常规提示(id,"召唤兽数据有误,请重新打开界面") return end
	if #玩家数据[id].召唤兽.数据[bbbh].技能 <= 3 then 常规提示(id,"垃圾召唤兽4技能都没有不配赐福") return end
	if self.数据[丸子]==nil or self.数据[丸子].名称~="仙露丸子" then 常规提示(id,"道具数据有误,请忽移动背包道具") return end
	if self.数据[丸子].数量 < xhsx[xiaohao] then 常规提示(id,"仙露丸子不足，本次赐福需要#R/" ..xhsx[xiaohao] .."#Y/个仙露丸子") return end
	self.数据[丸子].数量 = self.数据[丸子].数量 - xhsx[xiaohao]
	if self.数据[丸子].数量 <= 0 then
    	self.数据[丸子]=nil
    	玩家数据[id].角色.道具[材料]=nil
    end
    local wzcfjna=table.copy(丸子赐福技能)
    local q4jn={}
    for kv,nv in pairs(wzcfjna) do --删除wzcfjna里的锁定技能避免重复
    	for nvb=1,4 do
    		if 锁定[nvb]~=nil and (锁定[nvb]==nv or 锁定[nvb].名称==nv) then
    			table.remove(wzcfjna,kv)
			end
		end
	end
    for nv=1,4 do
    	if 锁定[nv] == nil then
	    	local sjq = 取随机数(1,#wzcfjna)
	    	q4jn[nv] = wzcfjna[sjq]
	    	table.remove(wzcfjna,sjq)
	    else
	    	  if 锁定[nv].名称 ~= nil then
		        q4jn[nv] = 锁定[nv].名称
		      else
		        q4jn[nv] = 锁定[nv]
		      end
	    end
    end
    if 取随机数(1,300) <= xhsx[xiaohao] then     --超级技能获得概率300
    	local hdcjjn=取超级要诀()
    	self:给予道具(id,"超级魔兽要诀",1,hdcjjn)
      发送数据(连接id,354,hdcjjn)
    end
    if 取随机数(1,100) <= xhsx[xiaohao] then
    	self:给予道具(id,"仙露小丸子",取随机数(8,12))
    end
    if 取随机数(1,100) <= xhsx[xiaohao] then
    	self:给予道具(id,"神兽涎",1)
    end
    发送数据(连接id,3513,玩家数据[id].道具:索要道具2(id))
    发送数据(玩家数据[id].连接id,353,{道具=玩家数据[id].道具:索要道具1(id),丸子赐福={进程=3,技能=q4jn,认证码=认证码}})
end

function 道具处理类:进化宝宝(连接id,id,数据)
  local 操作类型=数据.操作
  local 操作编号=数据.序列
  if 玩家数据[id].召唤兽.数据[操作编号]==nil  then
    return
  end

	if 操作类型=="进化宝宝" then
	if 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数>=8 then
	  常规提示(id,"#Y/少侠召唤兽已进化8次,无法继续进化！")
	  return
	end
	if 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数==0 then
	 if self:消耗背包道具(玩家数据[id].连接id,id,"神兜兜",100) then
	 玩家数据[id].召唤兽.数据[操作编号].攻击资质 = 玩家数据[id].召唤兽.数据[操作编号].攻击资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].防御资质 = 玩家数据[id].召唤兽.数据[操作编号].防御资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].体力资质 = 玩家数据[id].召唤兽.数据[操作编号].体力资质  + 100
	 玩家数据[id].召唤兽.数据[操作编号].法力资质 = 玩家数据[id].召唤兽.数据[操作编号].法力资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].躲闪资质 = 玩家数据[id].召唤兽.数据[操作编号].躲闪资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].速度资质 = 玩家数据[id].召唤兽.数据[操作编号].速度资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数=玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数+1
	常规提示(id,"恭喜你的召唤兽#R攻击资质#W + #G50,#R防御资质#W + #G100,#R体力资质#W + #G50,#R法力资质#W + #G50,#R躲闪资质#W + #G50,#R速度资质#W + #G50")
	玩家数据[id].召唤兽.数据[操作编号]:刷新信息()
	发送数据(连接id,16,玩家数据[id].召唤兽.数据)
	else
	          常规提示(id,"#Y/少侠还没有集齐“神兜兜”，第一次进化需要100个神兜兜！")
	 end
	elseif 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数==1 then
	 if self:消耗背包道具(玩家数据[id].连接id,id,"神兜兜",200) then
	 玩家数据[id].召唤兽.数据[操作编号].攻击资质 = 玩家数据[id].召唤兽.数据[操作编号].攻击资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].防御资质 = 玩家数据[id].召唤兽.数据[操作编号].防御资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].体力资质 = 玩家数据[id].召唤兽.数据[操作编号].体力资质  + 100
	 玩家数据[id].召唤兽.数据[操作编号].法力资质 = 玩家数据[id].召唤兽.数据[操作编号].法力资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].躲闪资质 = 玩家数据[id].召唤兽.数据[操作编号].躲闪资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].速度资质 = 玩家数据[id].召唤兽.数据[操作编号].速度资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数=玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数+1
	常规提示(id,"恭喜你的召唤兽#R攻击资质#W + #G50,#R防御资质#W + #G100,#R体力资质#W + #G50,#R法力资质#W + #G50,#R躲闪资质#W + #G50,#R速度资质#W + #G50")
	玩家数据[id].召唤兽.数据[操作编号]:刷新信息()
	发送数据(连接id,16,玩家数据[id].召唤兽.数据)
	else
	          常规提示(id,"#Y/少侠还没有集齐“神兜兜”，第二次进化需要200个神兜兜！")
	 end
	elseif 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数==2 then
	 if self:消耗背包道具(玩家数据[id].连接id,id,"神兜兜",300) then
	 玩家数据[id].召唤兽.数据[操作编号].攻击资质 = 玩家数据[id].召唤兽.数据[操作编号].攻击资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].防御资质 = 玩家数据[id].召唤兽.数据[操作编号].防御资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].体力资质 = 玩家数据[id].召唤兽.数据[操作编号].体力资质  + 100
	 玩家数据[id].召唤兽.数据[操作编号].法力资质 = 玩家数据[id].召唤兽.数据[操作编号].法力资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].躲闪资质 = 玩家数据[id].召唤兽.数据[操作编号].躲闪资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].速度资质 = 玩家数据[id].召唤兽.数据[操作编号].速度资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数=玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数+1
	常规提示(id,"恭喜你的召唤兽#R攻击资质#W + #G50,#R防御资质#W + #G100,#R体力资质#W + #G50,#R法力资质#W + #G50,#R躲闪资质#W + #G50,#R速度资质#W + #G50")
	玩家数据[id].召唤兽.数据[操作编号]:刷新信息()
	发送数据(连接id,16,玩家数据[id].召唤兽.数据)
	else
	          常规提示(id,"#Y/少侠还没有集齐“神兜兜”，第三次进化需要300个神兜兜！")
	 end
	elseif 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数==3 then
	 if self:消耗背包道具(玩家数据[id].连接id,id,"神兜兜",400) then
	 玩家数据[id].召唤兽.数据[操作编号].攻击资质 = 玩家数据[id].召唤兽.数据[操作编号].攻击资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].防御资质 = 玩家数据[id].召唤兽.数据[操作编号].防御资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].体力资质 = 玩家数据[id].召唤兽.数据[操作编号].体力资质  + 100
	 玩家数据[id].召唤兽.数据[操作编号].法力资质 = 玩家数据[id].召唤兽.数据[操作编号].法力资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].躲闪资质 = 玩家数据[id].召唤兽.数据[操作编号].躲闪资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].速度资质 = 玩家数据[id].召唤兽.数据[操作编号].速度资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数=玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数+1
	常规提示(id,"恭喜你的召唤兽#R攻击资质#W + #G50,#R防御资质#W + #G100,#R体力资质#W + #G50,#R法力资质#W + #G50,#R躲闪资质#W + #G50,#R速度资质#W + #G50")
	玩家数据[id].召唤兽.数据[操作编号]:刷新信息()
	发送数据(连接id,16,玩家数据[id].召唤兽.数据)
	else
	          常规提示(id,"#Y/少侠还没有集齐“神兜兜”，第四次进化需要400个神兜兜！")
	 end
	elseif 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数==4 then
	 if self:消耗背包道具(玩家数据[id].连接id,id,"神兜兜",500) then
	 玩家数据[id].召唤兽.数据[操作编号].攻击资质 = 玩家数据[id].召唤兽.数据[操作编号].攻击资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].防御资质 = 玩家数据[id].召唤兽.数据[操作编号].防御资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].体力资质 = 玩家数据[id].召唤兽.数据[操作编号].体力资质  + 100
	 玩家数据[id].召唤兽.数据[操作编号].法力资质 = 玩家数据[id].召唤兽.数据[操作编号].法力资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].躲闪资质 = 玩家数据[id].召唤兽.数据[操作编号].躲闪资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].速度资质 = 玩家数据[id].召唤兽.数据[操作编号].速度资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数=玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数+1
	常规提示(id,"恭喜你的召唤兽#R攻击资质#W + #G50,#R防御资质#W + #G100,#R体力资质#W + #G50,#R法力资质#W + #G50,#R躲闪资质#W + #G50,#R速度资质#W + #G50")
	玩家数据[id].召唤兽.数据[操作编号]:刷新信息()
	发送数据(连接id,16,玩家数据[id].召唤兽.数据)
	else
	          常规提示(id,"#Y/少侠还没有集齐“神兜兜”，第五次进化需要500个神兜兜！")
	end
	elseif 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数==5 then
	 if self:消耗背包道具(玩家数据[id].连接id,id,"神兜兜",600) then
	 玩家数据[id].召唤兽.数据[操作编号].攻击资质 = 玩家数据[id].召唤兽.数据[操作编号].攻击资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].防御资质 = 玩家数据[id].召唤兽.数据[操作编号].防御资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].体力资质 = 玩家数据[id].召唤兽.数据[操作编号].体力资质  + 100
	 玩家数据[id].召唤兽.数据[操作编号].法力资质 = 玩家数据[id].召唤兽.数据[操作编号].法力资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].躲闪资质 = 玩家数据[id].召唤兽.数据[操作编号].躲闪资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].速度资质 = 玩家数据[id].召唤兽.数据[操作编号].速度资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数=玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数+1
	常规提示(id,"恭喜你的召唤兽#R攻击资质#W + #G50,#R防御资质#W + #G100,#R体力资质#W + #G50,#R法力资质#W + #G50,#R躲闪资质#W + #G50,#R速度资质#W + #G50")
	玩家数据[id].召唤兽.数据[操作编号]:刷新信息()
	发送数据(连接id,16,玩家数据[id].召唤兽.数据)
	else
	          常规提示(id,"#Y/少侠还没有集齐“神兜兜”，第六次进化需要600个神兜兜！")
	end
	elseif 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数==6 then
	 if self:消耗背包道具(玩家数据[id].连接id,id,"神兜兜",700) then
	 --玩家数据[id].召唤兽.数据[操作编号].攻击资质 = 玩家数据[id].召唤兽.数据[操作编号].攻击资质  + 50
	 --玩家数据[id].召唤兽.数据[操作编号].防御资质 = 玩家数据[id].召唤兽.数据[操作编号].防御资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].体力资质 = 玩家数据[id].召唤兽.数据[操作编号].体力资质  + 200
	 玩家数据[id].召唤兽.数据[操作编号].法力资质 = 玩家数据[id].召唤兽.数据[操作编号].法力资质  + 100
	 玩家数据[id].召唤兽.数据[操作编号].躲闪资质 = 玩家数据[id].召唤兽.数据[操作编号].躲闪资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].速度资质 = 玩家数据[id].召唤兽.数据[操作编号].速度资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数=玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数+1
	常规提示(id,"恭喜你的召唤兽#R 200,#R体力资质#W + #G100,#R法力资质#W + #G50,#R躲闪资质#W + #G50,#R速度资质#W + #G50")
	玩家数据[id].召唤兽.数据[操作编号]:刷新信息()
	发送数据(连接id,16,玩家数据[id].召唤兽.数据)
	else
	         常规提示(id,"#Y/少侠还没有集齐“神兜兜”，第七次进化需要700个神兜兜！")
	end
	elseif 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数==7 then
	 if self:消耗背包道具(玩家数据[id].连接id,id,"神兜兜",800) then
	-- 玩家数据[id].召唤兽.数据[操作编号].攻击资质 = 玩家数据[id].召唤兽.数据[操作编号].攻击资质  + 50
	 --玩家数据[id].召唤兽.数据[操作编号].防御资质 = 玩家数据[id].召唤兽.数据[操作编号].防御资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].体力资质 = 玩家数据[id].召唤兽.数据[操作编号].体力资质  + 200
	 玩家数据[id].召唤兽.数据[操作编号].法力资质 = 玩家数据[id].召唤兽.数据[操作编号].法力资质  + 100
	 玩家数据[id].召唤兽.数据[操作编号].躲闪资质 = 玩家数据[id].召唤兽.数据[操作编号].躲闪资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].速度资质 = 玩家数据[id].召唤兽.数据[操作编号].速度资质  + 50
	 玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数=玩家数据[id].召唤兽.数据[操作编号].元宵.进化次数+1
	常规提示(id,"恭喜你的召唤兽 #G200,#R体力资质#W + #G100,#R法力资质#W + #G50,#R躲闪资质#W + #G50,#R速度资质#W + #G50")
	玩家数据[id].召唤兽.数据[操作编号]:刷新信息()
	发送数据(连接id,16,玩家数据[id].召唤兽.数据)
	else
	          常规提示(id,"#Y/少侠还没有集齐“神兜兜”，第八次进化需要800个神兜兜！")
	end
	end
	end
end

function 道具处理类:整理临时行囊啊(id,类型,参数)---整理xxxxxx
 local id = id + 0
  local function 简易排序(a,b)
    return a.序号<b.序号
  end
    local data = {}
    for k,v in pairs(玩家数据[id].角色.临时行囊[类型]) do
      local 字符编码=string.byte(string.sub(self.数据[v].名称,1,2))
      字符编码=字符编码+#self.数据[v].名称
      字符编码=字符编码+0
      data[#data+1]={内容=v,序号=字符编码}
      if  self.数据[v].数量~=nil and self.数据[v].数量<99999999 and self.数据[v].名称 ~="制造指南书" and self.数据[v].名称 ~="百炼精铁" then
        for i,n in pairs(玩家数据[id].角色.临时行囊[类型]) do
          if k~=i and  self.数据[n] ~= nil and self.数据[v] ~= nil and  self.数据[n].名称==self.数据[v].名称 and self.数据[n].数量~=nil  and self.数据[v].数量+self.数据[n].数量<99999999    then
            if self.数据[v].名称 == "高级清灵仙露" and self.数据[n].名称 == "高级清灵仙露" then
              if self.数据[v].灵气 ==  self.数据[n].灵气  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

            elseif self.数据[v].名称 == "中级清灵仙露" and self.数据[n].名称 == "中级清灵仙露" then
              if self.数据[v].灵气 ==  self.数据[n].灵气  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

            elseif self.数据[v].名称 == "初级清灵仙露" and self.数据[n].名称 == "初级清灵仙露" then
              if self.数据[v].灵气 ==  self.数据[n].灵气  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

           elseif self.数据[v].名称 == "元宵" and self.数据[n].名称 == "元宵" then
              if self.数据[v].参数 ==  self.数据[n].参数  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

              elseif self.数据[v].名称 == "水晶元宵" and self.数据[n].名称 == "水晶元宵" then
              if self.数据[v].参数 ==  self.数据[n].参数  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

        elseif self.数据[v].名称 == "黑宝石" and self.数据[n].名称 == "黑宝石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

        elseif self.数据[v].名称 == "月亮石" and self.数据[n].名称 == "月亮石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

        elseif self.数据[v].名称 == "红玛瑙" and self.数据[n].名称 == "红玛瑙" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

        elseif self.数据[v].名称 == "舍利子" and self.数据[n].名称 == "舍利子" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

        elseif self.数据[v].名称 == "太阳石" and self.数据[n].名称 == "太阳石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
        elseif self.数据[v].名称 == "光芒石" and self.数据[n].名称 == "光芒石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

        elseif self.数据[v].名称 == "速度精魄灵石" and self.数据[n].名称 == "速度精魄灵石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

        elseif self.数据[v].名称 == "气血精魄灵石" and self.数据[n].名称 == "气血精魄灵石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

        elseif self.数据[v].名称 == "灵力精魄灵石" and self.数据[n].名称 == "灵力精魄灵石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

        elseif self.数据[v].名称 == "躲避精魄灵石" and self.数据[n].名称 == "躲避精魄灵石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

        elseif self.数据[v].名称 == "防御精魄灵石" and self.数据[n].名称 == "防御精魄灵石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

        elseif self.数据[v].名称 == "伤害精魄灵石" and self.数据[n].名称 == "伤害精魄灵石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

        elseif self.数据[v].名称 == "星辉石" and self.数据[n].名称 == "星辉石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

          elseif self.数据[v].名称 == "钟灵石" and self.数据[n].名称 == "钟灵石" then
              if self.数据[v].技能 ==  self.数据[n].技能  and self.数据[v].等级 ==  self.数据[n].等级 then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

          elseif self.数据[v].名称 == "钨金" and self.数据[n].名称 == "钨金" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

          elseif self.数据[v].名称 == "附魔宝珠" and self.数据[n].名称 == "附魔宝珠" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

          elseif  self.数据[v].名称 == "魔兽要诀" and self.数据[n].名称 == "魔兽要诀" then
              if self.数据[v].附带技能 ==  self.数据[n].附带技能  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

          elseif  self.数据[v].名称 == "高级魔兽要诀" and self.数据[n].名称 == "高级魔兽要诀" then
              if self.数据[v].附带技能 ==  self.数据[n].附带技能  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
          elseif  self.数据[v].名称 == "特殊魔兽要诀" and self.数据[n].名称 == "特殊魔兽要诀" then
              if self.数据[v].附带技能 ==  self.数据[n].附带技能  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

          elseif  self.数据[v].名称 == "特色魔兽要诀" and self.数据[n].名称 == "特色魔兽要诀" then
              if self.数据[v].附带技能 ==  self.数据[n].附带技能  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
          elseif  self.数据[v].名称 == "超级魔兽要诀" and self.数据[n].名称 == "超级魔兽要诀" then
              if self.数据[v].附带技能 ==  self.数据[n].附带技能  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
          elseif  self.数据[v].名称 == "召唤兽内丹" and self.数据[n].名称 == "召唤兽内丹" then
              if self.数据[v].特效 ==  self.数据[n].特效  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
          elseif  self.数据[v].名称 == "高级召唤兽内丹" and self.数据[n].名称 == "高级召唤兽内丹" then
              if self.数据[v].特效 ==  self.数据[n].特效  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end



            else
             self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
             self.数据[n]=nil
             玩家数据[id].角色.临时行囊[类型][i]=nil
            end
        end
      end
    end
  end
    table.sort(data,简易排序)
    local tabdata={}
    for k,v in pairs(data) do
      tabdata[#tabdata+1]=v.内容
    end
    玩家数据[id].角色.临时行囊[类型]=tabdata

    发送数据(玩家数据[id].连接id,3555.1,self:索要临时行囊(id,类型,参数))
end

function 道具处理类:武器染色(连接id,id,内容) --染色
				if 玩家数据[id].角色.装备[3] ==nil then
					return
				end
				local 武器id=玩家数据[id].角色.装备[3]
	if 玩家数据[id].角色:扣除银子(5000000,0,0,"购买银两",1) or 玩家数据[id].角色.武神坛角色 then

		if self.数据[武器id].染色方案==nil then
			self.数据[武器id].染色方案=0
		end
		if self.数据[武器id].染色组==nil then
			self.数据[武器id].染色组={}
		end
		self.数据[武器id].染色方案 = 内容.序列+0
		self.数据[武器id].染色组[1] = tonumber(内容.序列1) or 0
		self.数据[武器id].染色组[2] = tonumber(内容.序列2) or 0
		发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
		添加最后对话(id,"染色成功！换个颜色换个心情#3")
	end
end
function 道具处理类:整理背包(连接id,id)---整理xxxxxx
	local data = {}
	local 计数 = 0
  local function 简易排序(a,b)
    return 排序整理(a.序号)<排序整理(b.序号)
  end
	 for k,v in  pairs (玩家数据[id].角色.道具) do  --判断背包道具--
      data[#data+1]={内容=v,序号=self.数据[v].名称}
	    if self.数据[v].数量~=nil and self.数据[v].数量+0<999 and self.数据[v].可叠加 then
		 			for i,n in pairs(玩家数据[id].角色.道具) do	--二次判断背包道具--

	          if k~=i and  self.数据[n] ~= nil and self.数据[v] ~= nil and  self.数据[n].名称==self.数据[v].名称 and self.数据[n].数量~=nil  and self.数据[v].数量+self.数据[n].数量<999  then
 							 if (self.数据[n].名称== "初级清灵仙露"  and self.数据[v].名称 =="初级清灵仙露") or (self.数据[n].名称== "中级清灵仙露"  and self.数据[v].名称 =="中级清灵仙露") or (self.数据[n].名称== "高级清灵仙露"  and self.数据[v].名称 =="高级清灵仙露") or (self.数据[n].名称== "高级摄灵珠"  and self.数据[v].名称 =="高级摄灵珠") then
 							 	  if self.数据[v].灵气 == self.数据[n].灵气 then
			          	 self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
			             self.数据[n]=nil
			             玩家数据[id].角色.道具[i]=nil
			            end
			         elseif self.数据[n].名称== "钨金"  and self.数据[v].名称 =="钨金" then
 							 	  if self.数据[v].级别限制 == self.数据[n].级别限制 then
			          	 self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
			             self.数据[n]=nil
			             玩家数据[id].角色.道具[i]=nil
			            end

--------------------------------------------------------------------------------------------
        elseif self.数据[v].名称 == "黑宝石" and self.数据[n].名称 == "黑宝石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
        elseif self.数据[v].名称 == "月亮石" and self.数据[n].名称 == "月亮石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end

        elseif self.数据[v].名称 == "红玛瑙" and self.数据[n].名称 == "红玛瑙" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end

        elseif self.数据[v].名称 == "舍利子" and self.数据[n].名称 == "舍利子" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end

        elseif self.数据[v].名称 == "太阳石" and self.数据[n].名称 == "太阳石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
        elseif self.数据[v].名称 == "光芒石" and self.数据[n].名称 == "光芒石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
        elseif self.数据[v].名称 == "速度精魄灵石" and self.数据[n].名称 == "速度精魄灵石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
        elseif self.数据[v].名称 == "气血精魄灵石" and self.数据[n].名称 == "气血精魄灵石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end

        elseif self.数据[v].名称 == "灵力精魄灵石" and self.数据[n].名称 == "灵力精魄灵石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
        elseif self.数据[v].名称 == "躲避精魄灵石" and self.数据[n].名称 == "躲避精魄灵石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
        elseif self.数据[v].名称 == "防御精魄灵石" and self.数据[n].名称 == "防御精魄灵石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
        elseif self.数据[v].名称 == "伤害精魄灵石" and self.数据[n].名称 == "伤害精魄灵石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
        elseif self.数据[v].名称 == "星辉石" and self.数据[n].名称 == "星辉石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end

          elseif self.数据[v].名称 == "钟灵石" and self.数据[n].名称 == "钟灵石" then
              if self.数据[v].技能 ==  self.数据[n].技能  and self.数据[v].等级 ==  self.数据[n].等级 then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
          elseif self.数据[v].名称 == "钨金" and self.数据[n].名称 == "钨金" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
          elseif self.数据[v].名称 == "附魔宝珠" and self.数据[n].名称 == "附魔宝珠" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
          elseif  self.数据[v].名称 == "魔兽要诀" and self.数据[n].名称 == "魔兽要诀" then
                if self.数据[v].附带技能 ==  self.数据[n].附带技能  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
          elseif  self.数据[v].名称 == "高级魔兽要诀" and self.数据[n].名称 == "高级魔兽要诀" then
              if self.数据[v].附带技能 ==  self.数据[n].附带技能  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
          elseif  self.数据[v].名称 == "特殊魔兽要诀" and self.数据[n].名称 == "特殊魔兽要诀" then
              if self.数据[v].附带技能 ==  self.数据[n].附带技能  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
          elseif  self.数据[v].名称 == "超级魔兽要诀" and self.数据[n].名称 == "超级魔兽要诀" then
              if self.数据[v].附带技能 ==  self.数据[n].附带技能  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
          elseif  self.数据[v].名称 == "召唤兽内丹" and self.数据[n].名称 == "召唤兽内丹" then
              if self.数据[v].特效 ==  self.数据[n].特效  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
          elseif  self.数据[v].名称 == "高级召唤兽内丹" and self.数据[n].名称 == "高级召唤兽内丹" then
              if self.数据[v].特效 ==  self.数据[n].特效  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.道具[i]=nil
              end
---------------------------------------------------------------------------------------------
 							 else
			          	 self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
			             self.数据[n]=nil
			             玩家数据[id].角色.道具[i]=nil
	           	 end
	          end
		 			end
		  end
   end
    table.sort(data,简易排序)
    local tabdata={}
    for k,v in pairs(data) do
      tabdata[#tabdata+1]=v.内容
    end
   玩家数据[id].角色.道具 = tabdata
   道具刷新(id)
end

function 道具处理类:激活天赋符(连接id,id,数据)
	local 包裹类型=数据.类型
	local 道具格子=数据.编号
	local 属性=数据.事件
	if 包裹类型~="道具" then
		常规提示(id,"只有道具栏的物品才可以使用")
		return
	elseif 道具格子==nil then
		return
	end
	local 道具id=玩家数据[id].角色[包裹类型][道具格子]
	if 道具id==nil or self.数据[道具id]==nil then
		玩家数据[id].道具[道具格子]=nil
		发送数据(连接id,3699)
		return
	end
	if self.数据[道具id].属性 then
		常规提示(id,"这个物品已被激活过了。")
		return
	end
	if 属性 and 属性~="我再想想" then
		self.数据[道具id].属性=属性
		常规提示(id,"激活成功。")
		发送数据(连接id,3699)
	end
end

function 道具处理类:镶嵌灵犀玉(数字id,数据) --保存镶嵌结果
	local id = 数字id + 0
	local 镶嵌部件 = 数据.部件
	local 灵犀玉数据=数据.灵犀玉
	local 客户端属性=数据.客户端属性
	local sqsj = 玩家数据[id].神器.数据.神器解锁[镶嵌部件]
	for i=1,20 do
		local 道具id=玩家数据[id].角色.道具[i]
		if 道具id~=nil and 玩家数据[id].道具.数据[道具id]~=nil and self.数据[道具id].名称 == "灵犀玉" then --判断物品是否存在
			for n=1,4 do --循环镶嵌的部位
					if 灵犀玉数据[n]~=nil and self.数据[道具id].识别码==灵犀玉数据[n].识别码 then --判断物品是否相同，并删除该物品
					sqsj.镶嵌灵犀玉[n].子类 = self.数据[道具id].子类
					sqsj.镶嵌灵犀玉[n].特性 = self.数据[道具id].特性
					self.数据[道具id] = nil
					玩家数据[id].角色.道具[i]=nil
					break
				end
			end
		end
	end
	local 灵犀玉 = 玩家数据[id].道具:索要灵犀玉(id)
	道具刷新(id)
	玩家数据[id].神器:计算灵犀玉属性(玩家数据[id].连接id,id,镶嵌部件,灵犀玉)
end
function 道具处理类:自动存仓处理(id)
 for n=1,80 do
  local 道具id=玩家数据[id].角色.道具[n]
    if self.数据[道具id]~=nil  then
    local 物品类型 = ""
   if self.数据[道具id].名称 == "魔兽要诀"  then
   物品类型 = "兽诀"
   elseif self.数据[道具id].名称 == "高级魔兽要诀" then
   物品类型 = "高兽诀"
    elseif self.数据[道具id].名称 ==  "特殊魔兽要诀" then
   物品类型 = "特兽诀"
   elseif self.数据[道具id].总类 == 5 and self.数据[道具id].分类==6 then
   物品类型 = "宝石"
    elseif self.数据[道具id].总类 == 5 and self.数据[道具id].分类==1 or (self.数据[道具id].总类 == 5 and self.数据[道具id].分类==2) or (self.数据[道具id].总类 == 5 and self.数据[道具id].分类==20) or (self.数据[道具id].总类 == 5 and self.数据[道具id].分类==21) then
   物品类型 = "打造"
    elseif self.数据[道具id].总类 == 2  then
   物品类型 = "装备"
   elseif self.数据[道具id].名称 == "飞行符"  or self.数据[道具id].名称 =="秘制红罗羹" or self.数据[道具id].名称 =="秘制绿芦羹" then
    物品类型 = "不存仓"
   elseif self.数据[道具id].名称 == "附加专用符"  then
    物品类型 = "不存仓"
   elseif self.数据[道具id].不可交易 == true  then
   物品类型 = "不存仓"
   elseif self.数据[道具id].名称 == "超级合成旗"  then
    物品类型 = "不存仓"
   elseif self.数据[道具id].名称 == "红色合成旗" or self.数据[道具id].名称 == "黄色合成旗" or self.数据[道具id].名称 == "蓝色合成旗" or self.数据[道具id].名称 == "绿色合成旗" or self.数据[道具id].名称 == "白色合成旗"  then
    物品类型 = "不存仓"
   else
   物品类型 = "杂货"
   end

   if 物品类型=="不存仓" then
   else
   	if  玩家数据[id].角色.临时行囊==nil  then
        玩家数据[id].角色.临时行囊 = {杂货={},宝石={},兽诀={},高兽诀={},特兽诀={},打造={},装备={}}
    end
   	if 玩家数据[id].角色.临时行囊~=nil then
   for k,v in pairs(玩家数据[id].角色.临时行囊[物品类型]) do
    if  self.数据[v]~=nil  then
      if  self.数据[v].数量~=nil and self.数据[v].数量<99999 then

        if self.数据[v].名称~=self.数据[道具id].名称 then
        elseif self.数据[v].灵气 ~= self.数据[道具id].灵气  then
        elseif self.数据[v].阶品~=self.数据[道具id].阶品 then
        elseif  self.数据[v].食材~=self.数据[道具id].食材 then
        elseif  self.数据[v].级别限制~=self.数据[道具id].级别限制 then
        elseif  self.数据[v].子类~=self.数据[道具id].子类 then
        elseif  self.数据[v].特效~=self.数据[道具id].特效 then
        elseif  self.数据[v].附带技能~=self.数据[道具id].附带技能 then
        else
          self.数据[v].数量=self.数据[v].数量+self.数据[道具id].数量
          玩家数据[id].角色.道具[n] = nil
        end
     end
     end
     end
     end
 end
 end
 end
   道具刷新(id)
   发送数据(玩家数据[id].连接id,3556,self:索要临时行囊(id,"杂货",1))
end

function 道具处理类:自动存仓处理1(id)
	local 参数=1
  local 物品类型="杂货"
  for n=1,80 do
  local 道具id=玩家数据[id].角色.道具[n]
  if self.数据[道具id]~=nil  then
  	-----------------------武神坛
	if 玩家数据[id].角色.武神坛角色 then
		self.数据[道具id].专用 = id
		self.数据[道具id].不可交易=true
	end
	-----------------------

   if self.数据[道具id].名称 == "魔兽要诀"  then
   物品类型 = "兽诀"
   参数 = 3
   elseif self.数据[道具id].名称 == "高级魔兽要诀" then
   物品类型 = "高兽诀"
   参数 = 4
    elseif self.数据[道具id].名称 ==  "特殊魔兽要诀" then
   物品类型 = "特兽诀"
   参数 = 5
   elseif self.数据[道具id].总类 == 5 and self.数据[道具id].分类==6 then
   物品类型 = "宝石"
   参数 = 2
    elseif self.数据[道具id].总类 == 5 and self.数据[道具id].分类==1 or (self.数据[道具id].总类 == 5 and self.数据[道具id].分类==2) or (self.数据[道具id].总类 == 5 and self.数据[道具id].分类==20) or (self.数据[道具id].总类 == 5 and self.数据[道具id].分类==21) then
   物品类型 = "打造"
   参数 = 6
    elseif self.数据[道具id].总类 == 2  then
   物品类型 = "装备"
   参数 = 7
   elseif self.数据[道具id].名称 == "飞行符" or self.数据[道具id].名称 =="秘制红罗羹" or self.数据[道具id].名称 =="秘制绿芦羹" then
    物品类型 = "不存仓"
   elseif self.数据[道具id].名称 == "附加专用符"  then
    物品类型 = "不存仓"
   elseif self.数据[道具id].不可交易 == true  then
   物品类型 = "不存仓"
   elseif self.数据[道具id].名称 == "超级合成旗" or self.数据[道具id].名称 == "九眼天珠"   or self.数据[道具id].名称 == "上古锻造图策" then
    物品类型 = "不存仓"
   elseif self.数据[道具id].名称 == "红色合成旗" or self.数据[道具id].名称 == "黄色合成旗" or self.数据[道具id].名称 == "蓝色合成旗" or self.数据[道具id].名称 == "绿色合成旗" or self.数据[道具id].名称 == "白色合成旗"  then
    物品类型 = "不存仓"
   else
   物品类型 = "杂货"
   参数 = 1
   end
   if 物品类型=="不存仓" then
   else
   local 新格子  =  玩家数据[id].角色:取可用临时行囊格子(id,物品类型)
   if 新格子>0 then
     玩家数据[id].角色.临时行囊[物品类型][新格子] = 玩家数据[id].角色.道具[n]
     玩家数据[id].角色.道具[n] = nil
     else
       常规提示(id,"临时仓库已满，请及时清理")
     end
   end
  end
   end
   if #玩家数据[id].角色.临时行囊.杂货>200 and 玩家数据[id].角色.自动出售 then
   	  -- self:包满出售临时行囊(id,"杂货",参数)
    end
   道具刷新(id)
end
function 道具处理类:灵饰自选(连接id,id,数据)
  local 临时格子=玩家数据[id].角色:取道具格子()
  if 临时格子 == 0 then 常规提示(id,"#Y你身上没有足够的空间") return  end
  if 玩家数据[id].道具操作==nil or 玩家数据[id].最后操作 == nil then 常规提示(id,"#Y生成异常请重新生成") return  end
  local 编号=玩家数据[id].道具操作.编号
  local 道具id=玩家数据[id].角色[玩家数据[id].道具操作.类型][编号]
  if 道具id==nil or self.数据[道具id]==nil or self.数据[道具id].名称~=玩家数据[id].最后操作 then
    常规提示(id,"#Y你没有这样的道具或者请勿移动道具")
    return
  end
  local itemm = self.数据[道具id].名称
  local itemc
  local itemd
  local itemb
  if  itemm=="120灵饰自选-戒指" then
    itemc = "悦碧水"
    itemd = 120
    itemb = "戒指"
  elseif itemm=="140灵饰自选-戒指" then
    itemc = "九曜光华"
    itemd = 140
    itemb = "戒指"
  elseif itemm=="120灵饰自选-手镯" then
    itemc = "花映月"
    itemd = 120
    itemb = "手镯"
  elseif itemm=="140灵饰自选-手镯" then
    itemc = "金水菩提"
    itemd = 140
    itemb = "手镯"
  elseif itemm=="120灵饰自选-佩饰" then
    itemc = "相思染"
    itemd = 120
    itemb = "佩饰"
  elseif itemm=="140灵饰自选-佩饰" then
    itemc = "玄龙苍珀"
    itemd = 140
    itemb = "佩饰"
  elseif itemm=="120灵饰自选-耳饰" then
    itemc = "点星芒"
    itemd = 120
    itemb = "耳饰"
  elseif itemm=="140灵饰自选-耳饰" then
    itemc = "凤羽流苏"
    itemd = 140
    itemb = "耳饰"
  end
  self.数据[道具id] = nil
  local 道具 = 物品类()
  道具:置对象(itemc)
  道具.级别限制 = itemd
  道具.幻化等级=0
  self.数据[道具id]=道具
  self.数据[道具id].部位类型=itemb
  灵饰处理(id,道具id,itemd,nil,itemb)
  self.数据[道具id].制造者 = "自选灵饰"
  self.数据[道具id].特效 = "无级别限制"
  if 数据.幻化属性.基础  and 灵饰属性.基础[数据.幻化属性.基础.类型] and 灵饰属性.基础[数据.幻化属性.基础.类型][itemd] then
    local 数值 = 灵饰属性.基础[数据.幻化属性.基础.类型][itemd].b
    self.数据[道具id].幻化属性.基础.类型 = 数据.幻化属性.基础.类型
    self.数据[道具id].幻化属性.基础.数值 = 数值
  end
  self.数据[道具id].幻化属性.附加={}
  for i=1,4 do ----------灵饰4条属性
    if 数据.幻化属性.附加[i] and 灵饰属性.基础[数据.幻化属性.附加[i].类型] and 灵饰属性.基础[数据.幻化属性.附加[i].类型][itemd] then
      local 数值 = 灵饰属性.基础[数据.幻化属性.附加[i].类型][itemd].b
      self.数据[道具id].幻化属性.附加[#self.数据[道具id].幻化属性.附加+1]={}
      self.数据[道具id].幻化属性.附加[#self.数据[道具id].幻化属性.附加].类型 = 数据.幻化属性.附加[i].类型
      self.数据[道具id].幻化属性.附加[#self.数据[道具id].幻化属性.附加].数值 = 数值
      self.数据[道具id].幻化属性.附加[#self.数据[道具id].幻化属性.附加].强化 = 0
    end
  end
  常规提示(id,"#Y/你得到了#R/"..self.数据[道具id].名称)
  道具刷新(id)
end

function 道具处理类:灵犀之屑合成(连接id,id,内容)
	local 数量=内容.数量
	if 数量>self:取灵犀之屑数量(id) then
		常规提示(id,"#Y/灵犀之屑数量不足！")
		return
	end
	--接下来要写扣除灵犀玉
	if 玩家数据[id].道具:消耗背包道具(连接id,id,"灵犀之屑",数量) then--self:扣除灵犀之屑(id,数量) then
		local go = self:取灵犀之屑成功率(数量)
		if go then
			玩家数据[id].道具:给予道具(id,"未鉴定的灵犀玉")
		end
		发送数据(连接id,6219,{是否成功=go,剩余灵犀玉=self:取灵犀之屑数量(id)})
	end
	道具刷新(id)
end

function 道具处理类:取灵犀之屑数量(id)
  local shuliang = 0
  for i=1,20 do
	local 道具id=玩家数据[id].角色.道具[i]
	if 道具id~=nil and 玩家数据[id].道具.数据[道具id]~=nil then
	  if self.数据[道具id].名称 == "灵犀之屑" then
		shuliang = shuliang + self.数据[道具id].数量
	  end
	end
  end
  return shuliang
end

function 道具处理类:取灵犀之屑成功率(数量)
	数量 = 数量 + 0
	local 成功率 =  数量*10
	local go = false
	if 取随机数(1,100) <= 成功率 then
		go = true
	end
	return go
end
function 道具处理类:索要临时行囊(id,类型,参数)
 	    if  玩家数据[id].角色.临时行囊==nil  then
       玩家数据[id].角色.临时行囊 = {杂货={},宝石={},兽诀={},高兽诀={},特兽诀={},打造={},装备={}}
      end
   for n=1,300 do
   if 玩家数据[id].角色.临时行囊[类型][n] ~=nil and self.数据[玩家数据[id].角色.临时行囊[类型][n]]~=nil then
   else
   	  玩家数据[id].角色.临时行囊[类型][n]=nil
   	end
   end

    if 玩家数据[id].角色.临时行囊[类型]~=nil then
    for n = 1,#玩家数据[id].角色.临时行囊[类型] do
      for i = 1,#玩家数据[id].角色.临时行囊[类型] do
        if n~= i and  玩家数据[id].角色.临时行囊[类型][i]~=nil and 玩家数据[id].角色.临时行囊[类型][n] == 玩家数据[id].角色.临时行囊[类型][i] then
                玩家数据[id].角色.临时行囊[类型][i] = nil
         end
      end

       if  self.数据[玩家数据[id].角色.临时行囊[类型][n]] == nil then
              玩家数据[id].角色.临时行囊[类型][n] = nil
        end
    end
  end
        self.发送数据 = {}
          for n = 1, 300 do
            if 玩家数据[id].角色.临时行囊[类型][n] ~= nil and self.数据[玩家数据[id].角色.临时行囊[类型][n]] ~= nil then
              self.发送数据[n] = table.loadstring(table.tostring(self.数据[玩家数据[id].角色.临时行囊[类型][n]]))
            end
          end
      self.发送数据.类型 = 参数
      self.发送数据.体力=玩家数据[id].角色.体力
      self.发送数据.银子=玩家数据[id].角色.银子
      self.发送数据.储备=玩家数据[id].角色.储备
      self.发送数据.存银=玩家数据[id].角色.存银
       return self.发送数据
end
function 道具处理类:取新编号()
	for n = 1,1200 do
		if self.数据[n]==nil then
			return n
		end
	end
	return #self.数据+1
end

function 道具处理类:修业点兑换(连接id,id,数据)
	local 道具格子=数据.道具格子
	local 道具id=玩家数据[id].角色["道具"][道具格子]
	local 点数=0
	if self.数据[道具id] == nil then
		常规提示(id,"#Y/你没有这个道具")
		return
	end
	if 玩家数据[id].角色.修业点 == nil then
      	玩家数据[id].角色.修业点 = 0
 	end
	if self.数据[道具id].总类==2 or self.数据[道具id].灵饰 or self.数据[道具id].召唤兽装备 then ---装备/灵饰类
			local lv=self.数据[道具id].级别限制
			点数=lv*2

	elseif self.数据[道具id].总类==889 and ( self.数据[道具id].分类==88 or self.数据[道具id].分类==89 or self.数据[道具id].分类==90 or self.数据[道具id].分类==91 ) then ---符石 含4J
			local lv=self.数据[道具id].子类
			点数=lv*8
			if self.数据[道具id].名称== "未激活的星石" then 点数=点数*2 end

	elseif self.数据[道具id].总类==5 and self.数据[道具id].分类==6 or self.数据[道具id].名称=="精魄灵石" then ---宝石
			local lv=self.数据[道具id].级别限制
			点数=lv*5
			if self.数据[道具id].名称=="星辉石" or self.数据[道具id].名称=="精魄灵石" or self.数据[道具id].名称=="钟灵石" then 点数=qz(点数*1.2) end
			if self.数据[道具id].名称=="珍珠" or self.数据[道具id].名称=="附魔宝珠" or self.数据[道具id].名称=="钨金" then
				点数=qz(lv/8)
			end
			if 点数>160 then 点数=1 常规提示(id,"#R/该物品未归类，请截图反馈！")  end

	elseif string.find(self.数据[道具id].名称,"清灵仙露") then
			local lv=self.数据[道具id].灵气
			点数=lv*5
	elseif self.数据[道具id].名称=="灵饰指南书" or self.数据[道具id].名称=="元灵晶石" or self.数据[道具id].名称=="制造指南书" or self.数据[道具id].名称=="百炼精铁" then
			local lv=self.数据[道具id].子类
			点数=lv
	elseif self.数据[道具id].名称=="九眼天珠" or self.数据[道具id].名称=="三眼天珠" or self.数据[道具id].名称=="天眼珠" then
			local lv=self.数据[道具id].级别限制
			点数=qz(lv/3)
	elseif string.find(self.数据[道具id].名称,"元宵") then
			点数=10
	elseif string.find(self.数据[道具id].名称,"玄灵珠·") then
			local lv=self.数据[道具id].级别限制
			点数=lv*10
	elseif self.数据[道具id].名称=="炼妖石" then
			local lv=self.数据[道具id].级别限制
			点数=qz(lv/10)
	elseif self.数据[道具id].名称=="怪物卡片" then
			local lv=self.数据[道具id].等级
			点数=lv*3
	elseif self.数据[道具id].名称=="灵犀玉" then
			local lv=self.数据[道具id].子类
			点数=lv*30
	elseif self.数据[道具id].名称=="青龙石" or self.数据[道具id].名称=="白虎石" or self.数据[道具id].名称=="玄武石" or self.数据[道具id].名称=="朱雀石" or self.数据[道具id].名称=="钨金" then
			点数=3
	elseif self.数据[道具id].名称=="灵犀之屑" or self.数据[道具id].名称=="炼兽真经"  then
			点数=5
	elseif self.数据[道具id].名称=="青龙印" or self.数据[道具id].名称=="白虎印" or self.数据[道具id].名称=="朱雀印" or self.数据[道具id].名称=="玄武印" then
			点数=5
	elseif self.数据[道具id].名称=="特殊兽诀·碎片" or self.数据[道具id].名称=="魔兽要诀" or self.数据[道具id].名称=="召唤兽内丹" or self.数据[道具id].名称=="神兜兜" then
			点数=10
	elseif self.数据[道具id].名称=="超级兽诀·碎片" then
			点数=20
	elseif self.数据[道具id].名称=="高级魔兽要诀" or self.数据[道具id].名称=="高级召唤兽内丹" or self.数据[道具id].名称=="战魄" then
			点数=50
	elseif self.数据[道具id].名称=="特殊魔兽要诀" or self.数据[道具id].名称=="灵兜兜" then
			点数=150
	elseif self.数据[道具id].名称=="超级魔兽要诀" then
			点数=200
	elseif self.数据[道具id].名称=="灵饰特效宝珠" or self.数据[道具id].名称=="装备特效宝珠" or self.数据[道具id].名称=="宠装特效宝珠" or self.数据[道具id].名称=="160特效宝珠"
			or self.数据[道具id].名称=="特技书" or self.数据[道具id].名称=="愤怒符" or self.数据[道具id].名称=="双加转换符" or self.数据[道具id].名称=="不磨符"
			or self.数据[道具id].名称=="未鉴定的灵犀玉"
			then
			点数=25
	elseif self.数据[道具id].名称=="修业通天录" then
			点数=1000
	else
		常规提示(id,"#Y/我不认识这个物品")
		return
	end

	if self.数据[道具id].数量 and self.数据[道具id].数量 > 1 then
			self.数据[道具id].数量 = self.数据[道具id].数量-1
	else
			self.数据[道具id]=nil
			玩家数据[id].角色["道具"][道具格子]=nil
	end
		玩家数据[id].角色.修业点=玩家数据[id].角色.修业点+点数
		常规提示(id,"#Y/你的修业点增加了#R"..点数.."#Y点，当前修业点：#R"..玩家数据[id].角色.修业点)
		发送数据(连接id,3513,玩家数据[id].道具:索要道具2(id))
		发送数据(连接id,440006.2,道具格子)

	end

function 道具处理类:宝宝坐骑喂养(连接id,id,数据)
	local 道具格子=数据.道具格子
	local 道具id=玩家数据[id].角色["道具"][道具格子]
	if self.数据[道具id] == nil then
		常规提示(id,"#Y/你没有这个道具")
		return
	end
	if self.数据[道具id].总类~=2 then
		常规提示(id,"炼化需要#Y/60至80级#W/的人物武器装备或#Y/0至125级#W/的召唤兽装备")
		return
	elseif self.数据[道具id].灵饰 then
		常规提示(id,"炼化需要#Y/60至80级#W/的人物武器装备或#Y/0至125级#W/的召唤兽装备")
		return
	end
	local lv=self.数据[道具id].级别限制
	local 认证码 = 数据.rzm
	local 类型=数据.类型
	if self.数据[道具id].召唤兽装备 then
		if lv>125 then
			常规提示(id,"炼化需要#Y/60至80级#W/的人物武器装备或#Y/0至125级#W/的召唤兽装备")
			return
		end
	else
		if lv>80 or lv<60 then
			常规提示(id,"炼化需要#Y/60至80级#W/的人物武器装备或#Y/0至125级#W/的召唤兽装备")
			return
		end
	end
	if 类型=="宝宝忠诚" then
		local 编号=玩家数据[id].角色:取参战宝宝编号()
		if 编号~=0 and 玩家数据[id].召唤兽.数据[编号] and 玩家数据[id].角色.参战信息~=nil then
			if 玩家数据[id].召唤兽.数据[编号].种类=="神兽" then
				添加最后对话(id,"神兽无需进行此操作。")
				return
			end
			if 玩家数据[id].召唤兽.数据[编号].忠诚>=100 then
				添加最后对话(id,"忠诚最高只能提升到100")
				return
			end
			self.数据[道具id]=nil
			玩家数据[id].角色["道具"][道具格子]=nil
			lv=qz(lv/5)
			玩家数据[id].召唤兽.数据[编号].忠诚=玩家数据[id].召唤兽.数据[编号].忠诚+lv
			常规提示(id,"你的召唤兽 "..玩家数据[id].召唤兽.数据[编号].名称.." 的忠诚提升了#G"..lv.."#Y点。")
			if 玩家数据[id].召唤兽.数据[编号].忠诚>100 then
				玩家数据[id].召唤兽.数据[编号].忠诚=100
			end
			发送数据(连接id,6568,{zc=玩家数据[id].召唤兽.数据[编号].忠诚,rzm=玩家数据[id].召唤兽.数据[编号].认证码})
			发送数据(连接id,3513,玩家数据[id].道具:索要道具2(id))
		end
	elseif 类型=="修炼" then
		local 坐骑编号=玩家数据[id].角色:取坐骑编号(认证码)
		if 坐骑编号~=0 then
			if 玩家数据[id].角色.坐骑列表[坐骑编号].好感度>=200 then
				添加最后对话(id,"好感度最高只能提升到200")
				return
			end
			self.数据[道具id]=nil
			玩家数据[id].角色["道具"][道具格子]=nil
			lv=qz(lv/10)
			玩家数据[id].角色.坐骑列表[坐骑编号].好感度 = 玩家数据[id].角色.坐骑列表[坐骑编号].好感度+lv
			常规提示(id,"你的坐骑 "..玩家数据[id].角色.坐骑列表[坐骑编号].名称.." 的好感度提升了#G"..lv.."#Y点。")
			if 玩家数据[id].角色.坐骑列表[坐骑编号].好感度>200 then
				玩家数据[id].角色.坐骑列表[坐骑编号].好感度=200
			end
			发送数据(连接id,6569,{hgd=玩家数据[id].角色.坐骑列表[坐骑编号].好感度,rzm= 玩家数据[id].角色.坐骑列表[坐骑编号].认证码})
			发送数据(连接id,3513,玩家数据[id].道具:索要道具2(id))
		end
	end
end

function 道具处理类:获取合宠物品(连接id,id,数据)
	local 道具格子=数据.道具格子
	local 道具id=玩家数据[id].角色["道具"][道具格子]
	if self.数据[道具id] == nil then
		常规提示(id,"#Y/数据异常！")
		return
	end

	if self.数据[道具id].名称~="神兜兜"  then
		常规提示(id,"#Y/这里只可以放置神兜兜哦！")
		return
	end

		发送数据(连接id,308.1,数据)

end


function 道具处理类:获取光武拓印(连接id,id,数据)
	local 道具格子=数据.道具格子
	local 道具id=玩家数据[id].角色["道具"][道具格子]
	if self.数据[道具id] == nil then
		常规提示(id,"#Y/数据异常！")
		return
	end
	if self.数据[道具id].总类~=2 or self.数据[道具id].分类 ~= 3  then
		常规提示(id,"#Y/选择武器有误！")
		return
	end
	if not self.数据[道具id].鉴定 then
		常规提示(id,"#Y/请鉴定后再来！")
		return
	end
	if self.数据[道具id].专用 and self.数据[道具id].专用 ~= id then
		常规提示(id,"#Y/无法对该武器进行操作！")
		return
	end
	发送数据(连接id,308,{道具格子})
end

function 道具处理类:光武拓印转化(连接id,id,数据)
	local 道具格子=数据.道具格子
	local 道具id=玩家数据[id].角色["道具"][道具格子]
	if self.数据[道具id] == nil or 数据.新造型 == nil then
		常规提示(id,"#Y/数据异常！")
		return
	end
	local 新造型 = 数据.新造型
	if self.数据[道具id].总类~=2 or self.数据[道具id].分类 ~= 3  then
		常规提示(id,"#Y/选择武器有误！")
		return
	end
	if not self.数据[道具id].鉴定 then
		常规提示(id,"#Y/请鉴定后再来！")
		return
	end
	if self.数据[道具id].专用 and self.数据[道具id].专用 ~= id then
		常规提示(id,"#Y/无法对该武器进行操作！")
		return
	end

	local 临时武器数据 = 取物品数据(新造型)
	if 临时武器数据 == nil then
		常规提示(id,"#Y/数据异常，请重试！")
		return
	end
	if self.数据[道具id].子类 ~= 临时武器数据[4]  then
		常规提示(id,"#Y/数据异常，请重试！")
		return
	end
	local 原造型=self.数据[道具id].名称
	if 玩家数据[id].角色:扣除银子(5000000,0,0,"光武拓印",1) or 玩家数据[id].角色.武神坛角色 then
		if self.数据[道具id].光武拓印 == nil then
			self.数据[道具id].光武拓印 = {
				原名称 = self.数据[道具id].名称,
				id  = id
			}
		end
		self.数据[道具id].名称 = 新造型
		发送数据(连接id,3513,玩家数据[id].道具:索要道具1(id))
		发送数据(连接id,308,{})
		添加最后对话(id,"一阵金光闪过，你手中的#Y"..原造型.."#W变成了#Y"..新造型.."#W的造型#80。")
	end
end

function 道具处理类:装备点化套装(连接id,id,sjj)
	local 强化石 = {"青龙石","朱雀石","玄武石","白虎石"}
	local 套装类型 = sjj.套装
	local 宝珠id = sjj.宝珠数据
	local 装备编号 = 玩家数据[id].角色.道具[sjj.装备]
	local 装备等级 = self.数据[装备编号].级别限制
	local 消耗石头 = self.数据[装备编号].分类
	local 强化石数据 = {青龙石=0,朱雀石=0,玄武石=0,白虎石=0}
	if 消耗石头 == 5 or 消耗石头 == 6 then
		消耗石头 = 3
	end

	强化石数据[强化石[消耗石头]] = math.floor(装备等级/10)
	for k,v in pairs(强化石数据) do
		if v>0 then
			强化石数据={k,v}
			break
		end
	end
	if sjj.装备 == nil or sjj.套装==0 or sjj.套装==nil then
		常规提示(id,"道具数据异常，请重新打开界面进行操作。")
		return
	end
	if 宝珠id==nil or self.数据[宝珠id] == nil and self.数据[宝珠id].名称~="附魔宝珠" then
		常规提示(id,"道具数据异常，请重新打开界面进行操作。")
		return
	end
	if self.数据[宝珠id].级别限制<装备等级 then
		常规提示(id,"宝珠等级小于装备等级，无法进行点化。")
		return
	end
	if 玩家数据[id].角色.当前经验 < 装备等级*3000 then --改经脉
		常规提示(id,"您的经验不足，无法进行点化。")
		return
	end
	if 玩家数据[id].角色.银子 < 装备等级*5000 and not 玩家数据[id].角色.武神坛角色 then
		常规提示(id,"您的银子不足，无法进行点化。")
		return
	end

	if 玩家数据[id].道具:判定背包道具(id,强化石数据[1],强化石数据[2])==false then
		常规提示(id,"您的"..强化石[消耗石头].."不足，无法进行点化。")
		return
	end

	if self.数据[装备编号].祈福值==nil or self.数据[装备编号].祈福值==0 or self.数据[装备编号].祈福值 < 30 then
		if 玩家数据[id].道具:消耗背包道具(连接id,id,强化石数据[1],强化石数据[2]) then
			-- self.数据[宝珠id] = nil
			玩家数据[id].道具:消耗背包道具(连接id,id,"附魔宝珠",1)
			-- 发送数据(连接id,3718)
			if 套装类型 == 1 then
				local 随机动物套 = 取所有动物套[取随机数(1,#取所有动物套)]
				self.数据[装备编号].套装效果={"变身术之",随机动物套}
			elseif 套装类型 == 2 then
				local 套装类型="追加法术"
				local 套装效果={追加法术={"知己知彼","满天花雨","唧唧歪歪","龙卷雨击","尘土刃","荆棘舞","冰川怒","夺命咒","夺魄令","浪涌","裂石","落叶萧萧","龙腾","龙吟","五雷咒","飞砂走石","三昧真火","姐妹同心","阎罗令","判官令","紧箍咒","日光华","靛沧海","巨岩破","苍茫树","地裂火","尸腐毒","勾魂","摄魄","百万神兵","魔音摄魂","镇妖","含情脉脉","似玉生香","后发制人","横扫千军","日月乾坤","威慑","催眠符","失心符","落魄符","定身符","神针撼海","当头一棒","雷击","落岩","水攻","烈火","奔雷咒","泰山压顶","水漫金山","地狱烈火",}}
				self.数据[装备编号].套装效果={套装类型,套装效果[套装类型][取随机数(1,#套装效果[套装类型])]}

			elseif 套装类型 == 4 then
				local 套装类型="附加状态"
				local 套装效果={附加状态={"金刚护法","金刚护体","生命之泉","炼气化神","普渡众生","定心术","碎星诀","变身","极度疯狂","盘丝阵","逆鳞","魔王回首","幽冥鬼眼","楚楚可怜","修罗隐身","杀气诀","一苇渡江"}}
				self.数据[装备编号].套装效果={套装类型,套装效果[套装类型][取随机数(1,#套装效果[套装类型])]}
			end
			if self.数据[装备编号].祈福值 == nil then
				self.数据[装备编号].祈福值 = 0
			end
			self.数据[装备编号].祈福值 = self.数据[装备编号].祈福值 + 2
			常规提示(id,"点化成功!"..self.数据[装备编号].套装效果[1].."-"..self.数据[装备编号].套装效果[2])
			玩家数据[id].角色.当前经验=qz(玩家数据[id].角色.当前经验-装备等级*3000)
			玩家数据[id].角色:扣除银子(装备等级*2000,0,0,"点化套装",1)
			道具刷新(id)
		end
	else
		local 套装类型名称 = "变身术"
		local 选项 = {}
		if 套装类型 == 1 then
			for n=1,#取所有动物套 do
				table.insert(选项,取所有动物套[n])
			end
		elseif 套装类型 == 2 then
			套装类型名称 = "追加法术"
			local 追加法术={"知己知彼","满天花雨","唧唧歪歪","龙卷雨击","尘土刃","荆棘舞","冰川怒","夺命咒","夺魄令","浪涌","裂石","落叶萧萧","龙腾","龙吟","五雷咒","飞砂走石","三昧真火","姐妹同心","阎罗令","判官令","紧箍咒","日光华","靛沧海","巨岩破","苍茫树","地裂火","尸腐毒","勾魂","摄魄","百万神兵","魔音摄魂","镇妖","含情脉脉","似玉生香","后发制人","横扫千军","日月乾坤","威慑","催眠符","失心符","落魄符","定身符","神针撼海","当头一棒","雷击","落岩","水攻","烈火","奔雷咒","泰山压顶","水漫金山","地狱烈火",}
			for n=1,#追加法术 do
				table.insert(选项,追加法术[n])
			end
		elseif 套装类型 == 4 then
			套装类型名称 = "附加状态"
			local 附加状态={"金刚护法","金刚护体","生命之泉","炼气化神","普渡众生","定心术","碎星诀","变身","极度疯狂","盘丝阵","逆鳞","魔王回首","幽冥鬼眼","楚楚可怜","修罗隐身","杀气诀","一苇渡江"}
			for n=1,#附加状态 do
				table.insert(选项,附加状态[n])
			end
		end
		table.insert(选项,"我暂时先不点化了")
		local 对话="装备祈福值已满，您可以选择一个自己想要的套装效果进行祈福：(正在点化：#Z"..套装类型名称.."#W)"
		玩家数据[id].点化套装数据 = sjj
		发送数据(连接id,1501,{名称="点化装备套装",模型=玩家数据[id].角色.模型,对话=对话,选项=选项})
	end
end

function 道具处理类:判断强化石(数据)
  local 青龙石数量 = 0
  local 白虎石数量 = 0
  local 朱雀石数量 = 0
  local 玄武石数量 = 0
  local 判断 = nil
  if 数据.青龙石 ~= 0 then
	for n, v in pairs(self.数据) do
	  if self.数据[n].名称 == "青龙石" then
		青龙石数量 = 青龙石数量 + self.数据[n].数量
	  end
	end
	if 青龙石数量 < 数据.青龙石 then
	  判断 = false
	else
	  判断 = true
	end
  end

  if 数据.白虎石 ~= 0 then
	for n, v in pairs(self.数据) do
	  if self.数据[n].名称 == "白虎石" then
		白虎石数量 = 白虎石数量 + self.数据[n].数量
	  end
	end
	if 白虎石数量 < 数据.白虎石 then
	  判断 = false
	else
	  判断 = true
	end
  end

  if 数据.朱雀石 ~= 0 then
	for n, v in pairs(self.数据) do
		if self.数据[n].名称 == "朱雀石" then
		朱雀石数量 = 朱雀石数量 + self.数据[n].数量
	  end
	end
	if 朱雀石数量 < 数据.朱雀石 then
	  判断 = false
	else
	  判断 = true
	end
  end

  if 数据.玄武石 ~= 0 then
	for n, v in pairs(self.数据) do
		if self.数据[n].名称 == "玄武石" then
		玄武石数量 = 玄武石数量 + self.数据[n].数量
	  end
	end
	if 玄武石数量 < 数据.玄武石 then
	  判断 = false
	else
	  判断 = true
	end
  end
  return 判断
end

function 道具处理类:吸附兽诀(连接id,id,内容)
	local gz=内容.兽诀格子
	local 删除数量=1
	local 道具id=玩家数据[id].角色["道具"][gz]
	if self.数据[道具id] == nil then
		常规提示(id,"#Y/该物品不存在")
		return
	elseif self.数据[道具id].名称~="魔兽要诀" and self.数据[道具id].名称~="高级魔兽要诀" and self.数据[道具id].名称~="特殊魔兽要诀" then
		常规提示(id,"#Y/我只认识低级、高级、特殊魔兽要诀")
		return
	end
	if self.数据[道具id].附带技能 then
		local 吸附名称=self.数据[道具id].附带技能
		if 吸附名称=="须弥真言" or 吸附名称=="观照万象" or 吸附名称=="津津有味" or 吸附名称=="净台妙谛" or 吸附名称=="叱咤风云" or 吸附名称=="无畏布施"
			or 吸附名称=="风起龙游" or 吸附名称=="神来气旺" or 吸附名称=="出其不意" or 吸附名称=="灵能激发" then
			常规提示(id,"#Y/我不认识这个技能（部分技能无法吸附）")
			return
		end
		if 玩家数据[id].道具:消耗背包道具(玩家数据[id].连接id,id,"吸附石",1) then
			玩家数据[id].道具:给予道具(id,"点化石",吸附名称)
			self:删除道具(连接id,id,"道具",道具id,gz,删除数量)
			常规提示(id,"#Y/吸附成功！获得了点化石")
			发送数据(连接id,3699)
		end
	end
end

function 道具处理类:开运(连接id,id,gz)
	local lsgz = gz
	gz=玩家数据[id].角色["道具"][gz]
	if self.数据[gz].开运孔数.当前 < self.数据[gz].开运孔数.上限 then
		if 玩家数据[id].角色.银子 < (self.数据[gz].开运孔数.当前+1) * 200000 and not 玩家数据[id].角色.武神坛角色 then self:更新道具1(连接id,id,gz,lsgz) return  end
		if 玩家数据[id].角色:扣除银子((self.数据[gz].开运孔数.当前+1) * 200000,0,0) or 玩家数据[id].角色.武神坛角色 then
			if 取随机数() < 60 - (self.数据[gz].开运孔数.当前 * 10) then
				self.数据[gz].开运孔数.当前 = self.数据[gz].开运孔数.当前 + 1
				self:更新道具1(连接id,id,gz,lsgz)
				if 玩家数据[id].角色.武神坛角色 then --武神坛改
					常规提示(id,"#Y开运#G成功")
				else
					常规提示(id,"#Y开运#G成功#Y扣除了#R"..((self.数据[gz].开运孔数.当前+1) * 200000).."#Y银两")
				end
			else
				self:更新道具1(连接id,id,gz,lsgz,"装备开运")
				if 玩家数据[id].角色.武神坛角色 then --武神坛改
					常规提示(id,"#Y开运#G成功")
				else
					常规提示(id,"#Y开运#R失败#Y失去了#R"..((self.数据[gz].开运孔数.当前+1) * 200000).."#Y银两")
				end
			end
		end
	else
		self:更新道具1(连接id,id,gz,lsgz,"装备开运")
		常规提示(id,"#Y开运孔数到达上限!")
	end
end

function 道具处理类:更新道具(连接id,id,gz,lx)
	道具刷新(id)
end
function 道具处理类:更新道具1(连接id,id,gz,lx)
	发送数据(连接id,201,{self.数据[gz],lx})
	道具刷新(id)
end
function 道具处理类:更新道具2(连接id,id,gz)
	发送数据(连接id,202,self.数据[gz])
end

function 道具处理类:一键出售环装(连接id,数字id)
	local ts=""
	for n=1,20 do
		if 玩家数据[数字id].角色.道具[n] and self.数据[玩家数据[数字id].角色.道具[n]] then
			local 道具id=玩家数据[数字id].角色.道具[n]
			if self.数据[道具id] and self.数据[道具id].总类==2 and self.数据[道具id].级别限制 and self.数据[道具id].级别限制>=50 and self.数据[道具id].级别限制<=80 then
				local 名称=self.数据[道具id].名称
				local sbm=self.数据[道具id].识别码
				if not self.数据[道具id].专用 and not self.数据[道具id].灵饰 and not self.数据[道具id].召唤兽装备 then
					local 价格=self:取装备价格(道具id)
					self.数据[道具id]=nil
					玩家数据[数字id].角色.道具[n]=nil
					玩家数据[数字id].角色:添加银子(价格,"出售环装"..名称..sbm,1)
					ts=ts.."#G"..名称.."="..价格.."#Y，"
				end
			end
		end
	end
	if ts~="" then
		常规提示(数字id,"出售#G"..ts.."成功！")
		道具刷新(数字id)
	end
end

function 道具处理类:一键回收(连接id,数字id,数据) --羔羊回收
	local start = (数据.page - 1) * 20 + 1
	if start < 1 then
		start = 1
	end
	local e = start + 19
	local t = 数据.type
	if t == nil then
			常规提示(数字id,"请选中道具或行囊！")
	end
	for n=start,e do
		local id = 玩家数据[数字id].角色[t][n]
		if id and self.数据[id] then
			local 道具id = 玩家数据[数字id].角色[t][n]
		  self:自动回收道具(数字id,道具id)
		end
	end
end

function 道具处理类:一键回收_老回收(连接id,数字id)
	local ts=""
	for n=1,20 do
		if 玩家数据[数字id].角色.道具[n] and self.数据[玩家数据[数字id].角色.道具[n]] then
			local 道具id=玩家数据[数字id].角色.道具[n]
			if self.数据[道具id] then
						local wp  = self.数据[道具id].名称
						local sbm = self.数据[道具id].识别码
				if  self.数据[道具id].总类==2 and self.数据[道具id].级别限制 and self.数据[道具id].级别限制>=50 and self.数据[道具id].级别限制<=80 then
					if not self.数据[道具id].专用 and not self.数据[道具id].灵饰 and not self.数据[道具id].召唤兽装备 then
						local 总价=self:取回收环价格(道具id)
						self.数据[道具id]=nil
						玩家数据[数字id].角色.道具[n]=nil
						玩家数据[数字id].角色:添加银子(总价,"出售环装"..wp..sbm,1)
						ts=ts.."#G"..wp.."="..总价.."#Y，"
					end
				elseif (wp=="制造指南书" or wp=="百炼精铁") and self.数据[道具id].子类 and self.数据[道具id].子类==150 then
						local 价格=0
						if wp=="制造指南书" then
							价格=1500000
						else
							价格=1000000
						end
						if 价格~=0 then
						self.数据[道具id]=nil
						玩家数据[数字id].角色.道具[n]=nil
						玩家数据[数字id].角色:添加银子(价格,"出售书铁"..wp..sbm,1)
						ts=ts.."#G"..wp.."="..价格.."#Y，"
						end
				else
					local 单价= f函数.读配置([[回收设置/服务端回收.txt]], "出售单价",wp)
					if 单价~="空"then
						local 数量=self.数据[道具id].数量 or 1
						local 总价=单价*数量
						self.数据[道具id]=nil
						玩家数据[数字id].角色.道具[n]=nil
						ts=ts.."#G"..wp.."*"..数量.."="..总价.."#Y，"
						玩家数据[数字id].角色:添加银子(总价,"物品回收"..wp..sbm,1)
					end
				end
			end
		end
	end

	if ts~="" then
		常规提示(数字id,"出售#G"..ts.."成功！")
		道具刷新(数字id)
	else
		常规提示(数字id,"你没有可以出售的物品！请勿频繁操作。")
	end
end

function 道具处理类:一键合宝石(id,dj1,lv,名称1)
	if 名称1=="星辉石" and lv>=11 then
		常规提示(id,"星辉石最高只能合到11级！")
		return
	end
	if lv>0 and dj1 then
		for n=1,20 do
			local dj2 = 玩家数据[id].角色.道具[n]
			if dj2 and self.数据[dj2] and dj1~=dj2 and 名称1==self.数据[dj2].名称 then
				local 名称2=self.数据[dj2].名称
				if 右键合成宝石[名称2] and self.数据[dj2].级别限制==lv then
					if 装备处理类:取宝石合成几率(id,lv) then
						玩家数据[id].角色.道具[n] = nil
						self.数据[dj2] = nil
						self.数据[dj1].级别限制 = self.数据[dj1].级别限制 +1
						道具刷新(id)
						常规提示(id,"#Y/你合成了一个更高级的宝石")
						return
					else
						self.数据[玩家数据[id].角色.道具[n]] = nil
						玩家数据[id].角色.道具[n] = nil
						道具刷新(id)
						常规提示(id,"#Y/你合成失败你损失了一颗宝石")
						return
					end
				end
			end
		end
	end
	常规提示(id,"#Y/没有找到可以合成的宝石")
end

function 道具处理类:一键合五宝(id)
	local sadwe={金刚石=0,定魂珠=0,夜光珠=0,避水珠=0,龙鳞=0}
	local shanchu={}
	local 满足=0
	for n=1,20 do
		local dj = 玩家数据[id].角色.道具[n]
		if dj and self.数据[dj] then
			local 名称=self.数据[dj].名称
			if 右键合成五宝[名称] and sadwe[名称]==0 then
				sadwe[名称]=123
				shanchu[名称]={道具id=dj,角色寄存=n}
				满足=满足+1
				if 满足>=5 then
					break
				end
			end
		end
	end
	if 满足>=5 then
		for k,v in pairs(shanchu) do
			if v.道具id~=0 and self.数据[v.道具id] and 右键合成五宝[self.数据[v.道具id].名称] then
				玩家数据[id].角色.道具[v.角色寄存] = nil
				self.数据[v.道具id] = nil
			end
		end
		玩家数据[id].道具:给予道具(id,"特赦令牌")
	else
		常规提示(id,"不满足合成五宝条件")
	end
end

function 道具处理类:一键合神印(id)
	local sadwe={白虎印=0,朱雀印=0,青龙印=0,玄武印=0}
	local shanchu={}
	local 满足=0
	for n=1,80 do
		local dj = 玩家数据[id].角色.道具[n]
		if dj and self.数据[dj] then
			local 名称=self.数据[dj].名称
			if 右键合成神印[名称] and sadwe[名称]==0 then
				sadwe[名称]=123
				shanchu[名称]={道具id=dj,角色寄存=n}
				满足=满足+1
				if 满足>=4 then
					break
				end
			end
		end
	end
	if 满足>=4 then
		for k,v in pairs(shanchu) do
			if v.道具id~=0 and self.数据[v.道具id] and 右键合成神印[self.数据[v.道具id].名称] then
				if 玩家数据[id].道具.数据[玩家数据[id].角色.道具[v.角色寄存]].数量~=nil and 玩家数据[id].道具.数据[玩家数据[id].角色.道具[v.角色寄存]].数量>1 then
							玩家数据[id].道具.数据[玩家数据[id].角色.道具[v.角色寄存]].数量 = 玩家数据[id].道具.数据[玩家数据[id].角色.道具[v.角色寄存]].数量 -1
				else
							玩家数据[id].角色.道具[v.角色寄存] = nil
							self.数据[v.道具id] = nil
				end
				-- 玩家数据[id].角色.道具[v.角色寄存] = nil
				-- self.数据[v.道具id] = nil
			end
		end
		if 取随机数()>=25 then
				玩家数据[id].道具:给予道具(id,"四象天罡印")
		else
				常规提示(id,"#R夹杂了一个残次印，合成四象天罡印失败。。。")
		end

	else
		常规提示(id,"不满足合成四象天罡印条件")
	end
end

function 道具处理类:使用道具(连接id,id,内容)
	if 玩家数据[id].坐牢中 or 玩家数据[id].烤火 then
		常规提示(id,"当前不能使用道具")
		return
	end
	local 包裹类型=内容.类型
	local 道具格子=内容.编号
	local 删除数量=1
	local 加血对象=0
	local 道具提示 = true
	if 内容.窗口=="召唤兽" then
		if 玩家数据[id].召唤兽.数据[内容.序列]==nil then
			常规提示(id,"请选择一只召唤兽")
			return
		else
			加血对象=内容.序列
		end
	elseif 内容.窗口=="坐骑" then
		local yxz=true
		local 道具id=玩家数据[id].角色[包裹类型][道具格子]
		if self.数据[道具id]~=nil and (self.数据[道具id].名称=="玄灵珠·回春" or self.数据[道具id].名称=="玄灵珠·破军" or self.数据[道具id].名称=="玄灵珠·空灵" or self.数据[道具id].名称=="玄灵珠·噬魂") then
			yxz=false
		end
		if 玩家数据[id].角色.坐骑列表[内容.序列]==nil then
			常规提示(id,"请选择一只坐骑")
			return
		else
			加血对象=内容.序列
		end
	end
	if 包裹类型~="道具" then
		常规提示(id,"只有道具栏的物品才可以使用")
		return
	elseif 道具格子==nil then
		return
	end
	local 道具id=玩家数据[id].角色[包裹类型][道具格子]
	if 道具id==nil or self.数据[道具id]==nil then
		玩家数据[id].道具[道具格子]=nil
		发送数据(连接id,3699)
		return
	end
	local 名称=self.数据[道具id].名称
	-----------------------武神坛
	if 玩家数据[id].角色.武神坛角色 then
		if self.数据[道具id].专用~=nil and self.数据[道具id].专用 ~= id then
			常规提示(id,"该道具为武神坛专用，且它并非你的道具")
			return
		end
	end
	-----------------------
	local 道具使用=false
	if self:取加血道具(名称) then
		道具使用=true
		local 加血数值=self:取加血道具1(名称,道具id)
		local 加魔数值=self:取加魔道具1(名称,道具id)
		local 伤势数值=self:取加血道具2(名称,道具id)
		if 名称=="翡翠豆腐" then
			self:加血处理(连接id,id,加血数值,加血对象)
			self:加魔处理(连接id,id,加魔数值,加血对象)
		else
			self:加血处理(连接id,id,加血数值,加血对象,nil,伤势数值)
		end
	elseif self:取加魔道具(名称) then
		道具使用=true
		local 加血数值=self:取加血道具1(名称,道具id)
		local 加魔数值=self:取加魔道具1(名称,道具id)
		if 名称=="翡翠豆腐" then
			self:加血处理(连接id,id,加血数值,加血对象)
			self:加魔处理(连接id,id,加魔数值,加血对象)
		else
			self:加魔处理(连接id,id,加魔数值,加血对象)
		end
	elseif self:取寿命道具(名称) then
		if 加血对象==0 then
			常规提示(id,"请选择一只召唤兽")
			return
		elseif 玩家数据[id].召唤兽.数据[加血对象].种类 =="神兽" then
			常规提示(id,"神兽无法使用此物品")
			return
		else
			local 加血数值=self:取寿命道具1(名称,道具id)
			玩家数据[id].召唤兽:加寿命处理(加血对象,加血数值.数值,加血数值.中毒,连接id,id)
			道具使用=true
		end
	elseif 右键合成宝石[名称] then
		self:一键合宝石(id,道具id,self.数据[道具id].级别限制,self.数据[道具id].名称)
		return
	elseif 右键合成五宝[名称] then
		self:一键合五宝(id)
		return
	elseif 右键合成神印[名称] then
		self:一键合神印(id)
		return
		----------召唤兽----------
	elseif 名称 == "水晶糕" then
		if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
			常规提示(id,"请选择一只召唤兽")
			return
		elseif 玩家数据[id].召唤兽.数据[加血对象].种类=="神兽" then
			常规提示(id,"神兽无法使用此物品")
			return
		end
		if 玩家数据[id].召唤兽.数据[加血对象].元宵.水晶糕<=0 then
			常规提示(id,"#Y你的"..玩家数据[id].召唤兽.数据[加血对象].名称.."#Y可食用的水晶糕已达上限。")
			return
		end
		玩家数据[id].召唤兽.数据[加血对象].元宵.水晶糕=玩家数据[id].召唤兽.数据[加血对象].元宵.水晶糕-1
		玩家数据[id].召唤兽.数据[加血对象].元宵.可用=玩家数据[id].召唤兽.数据[加血对象].元宵.可用+1
		常规提示(id,"#Y你的#G"..玩家数据[id].召唤兽.数据[加血对象].名称.."#Y的本周可食用元宵数量增加到了#G"..玩家数据[id].召唤兽.数据[加血对象].元宵.可用.."#Y个。")
		道具使用=true
	elseif 名称 == "炼兽真经" then
		if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
			常规提示(id,"请选择一只召唤兽")
			return
		elseif 玩家数据[id].召唤兽.数据[加血对象].种类=="神兽" then
			常规提示(id,"神兽无法使用此物品")
			return
		elseif 玩家数据[id].召唤兽.数据[加血对象].成长>=1.3 then
			常规提示(id,"当成长≥1.3时，不可以使用炼兽珍经")
			return
		elseif 玩家数据[id].召唤兽.数据[加血对象].元宵.炼兽真经<=0 then
			if 玩家数据[id].召唤兽.数据[加血对象].元宵.真经时间>os.time() then
				常规提示(id,"这个召唤兽已经吃了太多炼兽真经了，留着"..时间转换(玩家数据[id].召唤兽.数据[加血对象].元宵.真经时间).."给它吃吧。")
				return
			else
				玩家数据[id].召唤兽.数据[加血对象].元宵.炼兽真经=10
			end
		end
		local sx = 1
		local xx = 1
		if 玩家数据[id].召唤兽.数据[加血对象].成长<1.2 then
			sx = 7
			xx = 5
		elseif 玩家数据[id].召唤兽.数据[加血对象].成长<1.23 then
			sx = 6
			xx = 4
		elseif 玩家数据[id].召唤兽.数据[加血对象].成长<1.25 then
			sx = 6
			xx = 3
		elseif 玩家数据[id].召唤兽.数据[加血对象].成长<1.27 then
			sx = 5
			xx = 2
		elseif 玩家数据[id].召唤兽.数据[加血对象].成长<1.29 then
			sx = 4
			xx = 1
		else
			sx = 3
			xx = 1
		end
		local num = 取随机数(sx,xx)*0.001
		玩家数据[id].召唤兽.数据[加血对象].元宵.炼兽真经=玩家数据[id].召唤兽.数据[加血对象].元宵.炼兽真经-1
		玩家数据[id].召唤兽.数据[加血对象].成长 = 玩家数据[id].召唤兽.数据[加血对象].成长 + num
		玩家数据[id].召唤兽.数据[加血对象].元宵.真经时间=os.time()+3600
		常规提示(id,"#Y经过一番学习，您的#G"..玩家数据[id].召唤兽.数据[加血对象].名称.."#Y成长提升了#G"..num.."#Y。")
		玩家数据[id].召唤兽.数据[加血对象]:刷新信息()
		发送数据(连接id,115,{宝宝数据=玩家数据[id].召唤兽.数据,认证码=玩家数据[id].召唤兽.数据[加血对象].认证码,成长=玩家数据[id].召唤兽.数据[加血对象].成长})
		道具使用=true
	elseif 名称 == "芝麻沁香元宵" or 名称 == "桂花酒酿元宵" or 名称 == "细磨豆沙元宵" or 名称 == "蜜糖腰果元宵" or 名称 == "山楂拔丝元宵" or 名称 == "滑玉莲蓉元宵" then
		if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
			常规提示(id,"请选择一只召唤兽")
			return
		elseif 玩家数据[id].召唤兽.数据[加血对象].种类=="神兽" then
			常规提示(id,"神兽无法使用此物品")
			return
		elseif 玩家数据[id].召唤兽.数据[加血对象].元宵.可用<=0 then
			if 玩家数据[id].召唤兽.数据[加血对象].元宵.元宵时间>os.time() then
				常规提示(id,"这个召唤兽已经吃了太多元宵了，留着"..时间转换(玩家数据[id].召唤兽.数据[加血对象].元宵.元宵时间).."给它吃吧。")
				return
			else
				玩家数据[id].召唤兽.数据[加血对象].元宵.可用=10
			end
		end
		local zz = "攻击资质"
		if 名称 == "桂花酒酿元宵" then
			zz = "防御资质"
		elseif 名称 == "细磨豆沙元宵" then
			zz = "速度资质"
		elseif 名称 == "蜜糖腰果元宵" then
			zz = "躲闪资质"
		elseif 名称 == "山楂拔丝元宵" then
			zz = "体力资质"
		elseif 名称 == "滑玉莲蓉元宵" then
			zz = "法力资质"
		end
		local shangxian = {攻击资质=1600,防御资质=1600,体力资质=6500,法力资质=3500,速度资质=1600,躲闪资质=1600}
		if 玩家数据[id].召唤兽.数据[加血对象].参战等级>=155 then
			shangxian = {攻击资质=1600,防御资质=1600,体力资质=6500,法力资质=3500,速度资质=1600,躲闪资质=1600}
		end

		if 玩家数据[id].召唤兽.数据[加血对象][zz]>=shangxian[zz] then
			常规提示(id,"通过元宵提升的"..zz.."最高为"..shangxian[zz])
			return
		end
		local sx = 30
		local xx = 10
		if zz=="攻击资质" or zz=="攻击资质" or zz=="速度资质" or zz=="躲闪资质" then
			if 玩家数据[id].召唤兽.数据[加血对象][zz]<1300 then
				sx = 20
				xx = 10
			elseif 玩家数据[id].召唤兽.数据[加血对象][zz]<1400 then
				sx = 15
				xx = 8
			else
				sx = 10
				xx = 5
			end
		elseif  zz=="法力资质" then
			if 玩家数据[id].召唤兽.数据[加血对象][zz]<1500 then
				sx = 40
				xx = 20
			elseif 玩家数据[id].召唤兽.数据[加血对象][zz]<1700 then
				sx = 30
				xx = 15
			elseif 玩家数据[id].召唤兽.数据[加血对象][zz]<2000 then
				sx = 25
				xx = 10
			else
				sx = 20
				xx = 10
			end
		else
			if 玩家数据[id].召唤兽.数据[加血对象][zz]<3000 then
				sx = 50
				xx = 30
			elseif 玩家数据[id].召唤兽.数据[加血对象][zz]<4000 then
				sx = 40
				xx = 25
			elseif 玩家数据[id].召唤兽.数据[加血对象][zz]<5000 then
				sx = 25
				xx = 10
			else
				sx = 20
				xx = 10
			end
		end
		local num = 取随机数(sx,xx)
		玩家数据[id].召唤兽.数据[加血对象].元宵.可用 = 玩家数据[id].召唤兽.数据[加血对象].元宵.可用-1
		玩家数据[id].召唤兽.数据[加血对象][zz]=玩家数据[id].召唤兽.数据[加血对象][zz]+num
		玩家数据[id].召唤兽.数据[加血对象].元宵.元宵时间=os.time()+3600
		常规提示(id,"#Y恭喜！你的#G"..玩家数据[id].召唤兽.数据[加血对象].名称.."#Y的#G"..zz.."#Y增加了#G"..num.."#Y。")
		玩家数据[id].召唤兽.数据[加血对象]:刷新信息()
		发送数据(连接id,114,{宝宝数据=玩家数据[id].召唤兽.数据,认证码=玩家数据[id].召唤兽.数据[加血对象].认证码,资质=zz,资质数额=玩家数据[id].召唤兽.数据[加血对象][zz]})
		道具使用=true
	elseif 名称 == "易经丹" then
		if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
			常规提示(id,"请选择一只召唤兽")
			return
		elseif 玩家数据[id].召唤兽.数据[加血对象].等级<30 then
			常规提示(id,"需等级≥30级才能进阶！")
			return
		elseif 玩家数据[id].召唤兽.数据[加血对象].参战等级<45 and 玩家数据[id].召唤兽.数据[加血对象].等级<60 and 玩家数据[id].召唤兽.数据[加血对象].种类~="神兽" then
			常规提示(id,"参战等级45级↑召唤兽、等级60级↑才能进阶！")
			return
		elseif 玩家数据[id].召唤兽.数据[加血对象].内丹.格子==nil then
			常规提示(id,"要求：满内丹，所有低内丹5层，高内丹至少1层")
			return
		end
		if 玩家数据[id].召唤兽.数据[加血对象].进阶 == nil then
			local go = false
			local 高级内丹 ={ "神机步","腾挪劲","玄武躯","龙胄铠","玉砥柱","碎甲刃","阴阳护","凛冽气","舍身击","电魂闪","通灵法","双星爆","催心浪","隐匿击","生死决","血债偿"}
			for i=1,玩家数据[id].召唤兽.数据[加血对象].内丹.内丹上限 do
				if 玩家数据[id].召唤兽.数据[加血对象].内丹.格子[i] == nil then
					常规提示(id,"要求：满内丹，所有低内丹5层，高内丹至少1层！")
					return
				end
				if i==1 then --第一个格子，高内丹只需打一层
					for k,v in pairs(高级内丹) do
						if 玩家数据[id].召唤兽.数据[加血对象].内丹.格子[1].技能==v then
							go = true
						end
					end
				end
			end
			if go then
				for i=2,玩家数据[id].召唤兽.数据[加血对象].内丹.内丹上限 do
					if 玩家数据[id].召唤兽.数据[加血对象].内丹.格子[i].等级<5 then
						常规提示(id,"要求：满内丹，所有低内丹5层，高内丹至少1层")
						return
					end
				end
			else
				for i=1,玩家数据[id].召唤兽.数据[加血对象].内丹.内丹上限 do
					if 玩家数据[id].召唤兽.数据[加血对象].内丹.格子[i].等级<5 then
						常规提示(id,"要求：满内丹，所有低内丹5层，高内丹至少1层")
						return
					end
				end
			end
			玩家数据[id].召唤兽.数据[加血对象].进阶 ={清灵仙露=0,灵性=0,特性="无",特性属性={},开启=false} --所有条件都通过以后才给他赋予这个进阶的值
		end
		if 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 <50 then
			玩家数据[id].召唤兽.数据[加血对象].进阶.灵性= 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性+10
			玩家数据[id].召唤兽.数据[加血对象].潜力 = 玩家数据[id].召唤兽.数据[加血对象].潜力 + 20
			常规提示(id,玩家数据[id].召唤兽.数据[加血对象].名称.."服用了一个易经丹后，神清气爽，仙气缭绕，灵性增加了#R10#Y点")
			if 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性==50 then
			if 玩家数据[id].召唤兽.数据[加血对象].参战等级<45 then
					常规提示(id,"#G你的召唤兽已经达到了进阶的条件了")
				else
			if string.find(玩家数据[id].召唤兽.数据[编号].模型,"进阶")~=nil then
					  玩家数据[id].召唤兽.数据[加血对象].模型="进阶"..玩家数据[id].召唤兽.数据[加血对象].模型
					  发送数据(id,6556,玩家数据[id].召唤兽.数据[加血对象])
						添加最后对话(id,"恭喜你的召唤兽获得了新的形态！")
            else
            添加最后对话(id,"#17少侠，该进阶召唤兽造型未开放哦")
			end
			end
			end
			玩家数据[id].召唤兽.数据[加血对象]:刷新信息()
			发送数据(连接id,108,{认证码=玩家数据[id].召唤兽.数据[加血对象].认证码,进阶=玩家数据[id].召唤兽.数据[加血对象].进阶})
		elseif 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 >= 80 then
			local txb={"复仇","自恋","灵刃","灵法","巧劲","预知","灵动","瞬击","瞬法","抗法","抗物","阳护","识物","护佑","洞察","弑神","御风","顺势","怒吼","逆境","乖巧","力破","识药","吮魔","争锋","灵断"}
			local a =txb[取随机数(1,#txb)] --"逆境"--
			玩家数据[id].召唤兽.数据[加血对象].进阶.特性 = a
			玩家数据[id].召唤兽.数据[加血对象].进阶.特性属性 = {宝宝特性属性(玩家数据[id].召唤兽.数据[加血对象].等级,a)}
			玩家数据[id].召唤兽.数据[加血对象].进阶.开启=true
			常规提示(id,"#Y"..玩家数据[id].召唤兽.数据[加血对象].名称.."充分吸收了易经丹中的灵气，特性变得和原来不同了！")
			玩家数据[id].召唤兽.数据[加血对象]:刷新信息()
			发送数据(连接id,16,玩家数据[id].召唤兽.数据)
			发送数据(连接id,108,{认证码=玩家数据[id].召唤兽.数据[加血对象].认证码,进阶=玩家数据[id].召唤兽.数据[加血对象].进阶})
		else
			常规提示(id,"你的召唤兽目前无法使用该道具")
			return
		end
		道具使用=true
-------------曜石-----------------------
elseif 名称=="元素曜石·冰" or 名称=="元素曜石·风"  or 名称=="元素曜石·火" or 名称=="元素曜石·雷" or 名称=="元素曜石·水" or 名称=="元素曜石·岩"  then

	         if self.数据[道具id].部位 or  self.数据[道具id].数值 then
	           	发送数据(玩家数据[id].连接id,233,{道具格子,self.数据[道具id].总类,self.数据[道具id].分类,self.数据[道具id].子类,"鉴定"})
		return
	          else

		if 玩家数据[id].角色.当前经验<20000000 then
		常规提示(id,"当前经验不足2千万")
		return
		end
		if 玩家数据[id].角色:扣除银子(10000000,0,0,"元素宝石鉴定",1) then
			玩家数据[id].角色.当前经验=玩家数据[id].角色.当前经验-20000000
			       local 临时属性={"武器" ,"衣服" ,"项链" ,"腰带" ,"头盔" ,"鞋子"}
			       self.数据[道具id].部位=  临时属性[math.random(1,#临时属性)]
			       self.数据[道具id].数值=取随机数(1,100)
			       self.数据[道具id].专用 = id
			      发送数据(连接id,3699)
			      发送数据(连接id, 7, "#y/鉴定成功，当前部位为：#R/"..self.数据[道具id].部位.."#Y/增加数值："..(self.数据[道具id].数值/100).."%")
			      return
		end
	         end
-------------------------------------------------
	elseif 名称 == "玉葫灵髓" then
		if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
			常规提示(id,"请选择一只召唤兽")
			return
		end
		if 玩家数据[id].召唤兽.数据[加血对象].进阶 ~= nil and 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性>50 then
			local dj = 玩家数据[id].召唤兽.数据[加血对象].等级
			if 玩家数据[id].召唤兽.数据[加血对象].种类=="神兽" then
				玩家数据[id].召唤兽.数据[加血对象].体质=dj+20
				玩家数据[id].召唤兽.数据[加血对象].魔力=dj+20
				玩家数据[id].召唤兽.数据[加血对象].力量=dj+20
				玩家数据[id].召唤兽.数据[加血对象].耐力=dj+20
				玩家数据[id].召唤兽.数据[加血对象].敏捷=dj+20
				玩家数据[id].召唤兽.数据[加血对象].潜力=dj*5
			elseif 玩家数据[id].召唤兽.数据[加血对象].种类=="变异" then
				玩家数据[id].召唤兽.数据[加血对象].体质=dj+15
				玩家数据[id].召唤兽.数据[加血对象].魔力=dj+15
				玩家数据[id].召唤兽.数据[加血对象].力量=dj+15
				玩家数据[id].召唤兽.数据[加血对象].耐力=dj+15
				玩家数据[id].召唤兽.数据[加血对象].敏捷=dj+15
				玩家数据[id].召唤兽.数据[加血对象].潜力=dj*5
			else--if 玩家数据[id].召唤兽.数据[加血对象].种类=="宝宝" then
				玩家数据[id].召唤兽.数据[加血对象].体质=dj+10
				玩家数据[id].召唤兽.数据[加血对象].魔力=dj+10
				玩家数据[id].召唤兽.数据[加血对象].力量=dj+10
				玩家数据[id].召唤兽.数据[加血对象].耐力=dj+10
				玩家数据[id].召唤兽.数据[加血对象].敏捷=dj+10
				玩家数据[id].召唤兽.数据[加血对象].潜力=dj*5
			end
			玩家数据[id].召唤兽.数据[加血对象].潜力 = 玩家数据[id].召唤兽.数据[加血对象].潜力+100--50灵性加成
			玩家数据[id].召唤兽.数据[加血对象].进阶 = {清灵仙露=0,灵性=50,特性="无",特性属性={},开启=false}
			常规提示(id,"你的召唤兽#R/"..玩家数据[id].召唤兽.数据[加血对象].名称.."#Y/服用一个玉葫灵髓后,灵性已回归原始！")
			玩家数据[id].召唤兽.数据[加血对象]:刷新信息()
			发送数据(连接id,16,玩家数据[id].召唤兽.数据)
			发送数据(连接id,108,{认证码=玩家数据[id].召唤兽.数据[加血对象].认证码,进阶=玩家数据[id].召唤兽.数据[加血对象].进阶})
		else
			常规提示(id,"召唤兽的灵性必须大于50才能使用玉葫灵髓")
			return
		end
		道具使用=true
	elseif 名称 == "初级清灵仙露" or 名称 == "中级清灵仙露" or 名称 == "高级清灵仙露" or 名称=="特殊清灵仙露" then
		if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
			常规提示(id,"请选择一只召唤兽")
			return
		elseif 玩家数据[id].召唤兽.数据[加血对象].进阶 == nil then
			常规提示(id,"召唤兽灵性未达到50！")
			return
		end
		if self:清灵仙露处理(连接id,id,加血对象,道具id) then
			道具使用=true
		else
			return
		end
	elseif self.数据[道具id].总类==149 then --召唤兽饰品
		if 加血对象==0 then
			常规提示(id,"请选择一只召唤兽")
			return
		elseif 玩家数据[id].召唤兽.数据[加血对象].饰品~=nil then
			常规提示(id,"这只召唤兽已经有饰品了")
			return
		end
		if 玩家数据[id].召唤兽.数据[加血对象].模型.."饰品"==self.数据[道具id].名称 then
			玩家数据[id].召唤兽.数据[加血对象].饰品 = 1
			常规提示(id,"佩戴召唤兽饰品成功！")
		else
			常规提示(id,"该饰品不符合这个召唤兽")
			return
		end
		道具使用=true
		elseif 名称 == "蒲扇"  then
		local rwid = 玩家数据[id].角色:取任务(81)
		if rwid ~= 0 then
		if 玩家数据[id].角色.地图数据.编号 ~= 6018 then
		常规提示(id,"#Y/该地图无法使用该物品！")
		return
		elseif math.abs(任务数据[rwid].x-玩家数据[id].角色.地图数据.x/20)>3 and math.abs(任务数据[rwid].y-玩家数据[id].角色.地图数据.y/20)>3 then
		常规提示(id,"#Y/并不是要在这里打扫哟！")
		return
		else
		副本_黑风山:完成黑风山任务({id},rwid,81)
		end
		else
		常规提示(id,"#Y/你没有这样的任务！")
		return
		end
		道具使用=true
	elseif 名称 == "拘魂镜"  then
		local rwid = 玩家数据[id].角色:取任务(956)
		if rwid ~= 0 then
		if 玩家数据[id].角色.地图数据.编号 ~= 6054 then
		常规提示(id,"#Y/该地图无法使用该物品！")
		return
		elseif math.abs(任务数据[rwid].x-玩家数据[id].角色.地图数据.x/20)>3 and math.abs(任务数据[rwid].y-玩家数据[id].角色.地图数据.y/20)>3 then
		常规提示(id,"#Y/坐标不对！")
		return
		else
		完成天火之殇上任务({id},rwid,956)
		常规提示(id,"#Y/很可惜，没能阻拦住这些鬼魂~#108")
		end
		else
		常规提示(id,"#Y/你没有这样的任务！")
		return
		end
		道具使用=true
		elseif 名称 == "大闹小铲子"  then
      local rwid = 玩家数据[id].角色:取任务(71)
      if rwid ~= 0 then
      if 玩家数据[id].角色.地图数据.编号 ~= 6033 then
      常规提示(id,"#Y/该地图无法使用该物品！")
      return
    elseif math.abs(任务数据[rwid].x-玩家数据[id].角色.地图数据.x/20)>3 and math.abs(任务数据[rwid].y-玩家数据[id].角色.地图数据.y/20)>3 then
      常规提示(id,"#Y/大圣并不是要在这里除草哟！")
      return
    else
      local 对话="蟠桃园锄树清草，可得讲究力道,增之一分则太多,减之一分则太少。请选择你要使用的力道"
      local 选项={"一分力道","二分力道","我还是在考虑考虑"}
      玩家数据[id].大闹锄树=选项[取随机数(1,2)]
      发送数据(玩家数据[id].连接id,1501,{名称=玩家数据[id].角色.名称,模型=玩家数据[id].角色.模型,对话=对话,选项=选项})
    end
  else
    常规提示(id,"#Y/你没有这样的任务！")
    return
  end
	道具使用=true
	elseif 名称 == "如意丹"  then
		if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
			常规提示(id,"请选择一只召唤兽")
			return
		elseif self.数据[道具id].灵气==nil then
			return
		end
		local 五行=self.数据[道具id].灵气
		local sx=""
		if 五行=="金" then
			sx="力量"
		elseif 五行=="水" then
			sx="敏捷"
		elseif 五行=="木" then
			sx="体质"
		elseif 五行=="火" then
			sx="魔力"
		elseif 五行=="土" then
			sx="耐力"
		end
		if 玩家数据[id].召唤兽.数据[加血对象].种类=="神兽" then
			if 玩家数据[id].召唤兽.数据[加血对象][sx]<玩家数据[id].召唤兽.数据[加血对象].等级+20 then
				 常规提示(id,"神兽的属性点最低只能调整到等级+20")
				return
			end
		else
			if 玩家数据[id].召唤兽.数据[加血对象][sx]<玩家数据[id].召唤兽.数据[加血对象].等级+10 then
				常规提示(id,"该宝宝属性点最低只能调整到等级+10")
				return
			end
		end
		玩家数据[id].召唤兽.数据[加血对象]:如意丹洗点(sx)
		发送数据(连接id,16,玩家数据[id].召唤兽.数据)
		常规提示(id,"你的召唤兽#R/"..玩家数据[id].召唤兽.数据[加血对象].名称.."#Y/服用一个如意丹后，"..sx.."减少了1点，潜力点增加了1点")
		道具使用=true
	elseif 名称 == "修业通天录" then
		-- 玩家数据[id].角色.修业点=玩家数据[id].角色.修业点+1000
		常规提示(id,"#Y请至修业系统处“炼化”")
		return

	elseif 名称 == "天赋符" then
		if 加血对象==0 or 玩家数据[id].召唤兽.数据[加血对象]==nil then
			常规提示(id,"请选择一只召唤兽")
			return
		end
		if self.数据[道具id].属性 then
			local sx=0
			local b0bo=玩家数据[id].召唤兽.数据[加血对象]
			local leixing=self.数据[道具id].属性
			local fwd=leixing
			local weizhi=1
			if leixing=="攻击" then
				fwd="伤害"
				weizhi=3
				sx=玩家数据[id].召唤兽.数据[加血对象]:伤害公式()
			elseif leixing=="气血" then
				fwd="最大气血"
				weizhi=1
				sx=玩家数据[id].召唤兽.数据[加血对象]:气血公式()
			elseif leixing=="防御" then
				weizhi=4
				sx=玩家数据[id].召唤兽.数据[加血对象]:防御公式()
			elseif leixing=="速度" then
				weizhi=5
				sx=玩家数据[id].召唤兽.数据[加血对象]:速度公式()
			elseif leixing=="灵力" then
				weizhi=6
				sx=玩家数据[id].召唤兽.数据[加血对象]:灵力公式()
			elseif leixing=="躲闪" then
				fwd="躲避"
				sx=玩家数据[id].召唤兽.数据[加血对象]:躲避公式()
			end
			玩家数据[id].召唤兽.数据[加血对象].天赋符={lx=fwd,khdwz=weizhi,zhi=sx,sj=os.time()+604800}
			玩家数据[id].召唤兽.数据[加血对象]:刷新信息("1")
			发送数据(连接id,20,玩家数据[id].召唤兽.数据[加血对象])
			道具使用=true
			常规提示(id,"使用天赋符成功。这个天赋符将在7天后消失。")
		end

	elseif 名称=="月华露" then
		if 内容.窗口~="召唤兽" or 玩家数据[id].召唤兽.数据[内容.序列]==nil then
			常规提示(id,"请先选中一只召唤兽")
			return
		elseif 玩家数据[id].召唤兽.数据[内容.序列].等级>=180 then
			常规提示(id,"该召唤兽等级已达到上限！")
			return
		elseif 玩家数据[id].召唤兽.数据[内容.序列].等级 >= 玩家数据[id].角色.等级 + 10 then
			常规提示(id,"该召唤兽已超过人物等级10级，无法使用该道具")
			return
		else
			local 临时等级=玩家数据[id].召唤兽.数据[内容.序列].等级
			if 临时等级==0 then
				临时等级=1
			end
			玩家数据[id].召唤兽:添加经验(连接id,id,内容.序列,self.数据[道具id].阶品*50*临时等级)
			道具使用=true
		end
		----------技能突破符
		elseif  名称=="技能突破符" then--打书
		if 内容.窗口~="召唤兽" or 玩家数据[id].召唤兽.数据[内容.序列]==nil then
			常规提示(id,"请先选中一只召唤兽")
			return
		end
		local 技能数量 = #玩家数据[id].召唤兽.数据[内容.序列].技能
		local 选定技能={}
		if 技能数量<10 then
				常规提示(id,"技能突破符只能在召唤兽达到10技能后才能使用")
			return
		end
		if 技能数量>=36 then
				常规提示(id,"最多只能到36技能哦")
			return
		end

		if 玩家数据[id].召唤兽.数据[内容.序列].技能突破 ==nil then
		玩家数据[id].召唤兽.数据[内容.序列].技能突破=0
		end
		if 玩家数据[id].召唤兽.数据[内容.序列].技能突破>=5 then
				常规提示(id,"每个宝宝最多可使用5个技能突破符")
			return
		end
		local 兽决技能={"高级神佑复生","高级驱鬼","高级必杀","高级感知","高级连击","高级防御","高级强力"
				,"高级反震","高级再生","高级敏捷","高级反击","高级飞行","高级慧根","高级魔之心"
				,"高级幸运","高级法术暴击","高级法术连击","高级感知","高级招架"
				,"高级驱鬼","高级慧根","高级法术抵抗"}
		local 随机技能=兽决技能[取随机数(1,#兽决技能)]
		for  i=1,技能数量 do
			if 玩家数据[id].召唤兽.数据[内容.序列].技能[i]==随机技能 then
				随机技能=兽决技能[取随机数(1,#兽决技能)]
			end
		end
		for  i=1,技能数量 do
			if 玩家数据[id].召唤兽.数据[内容.序列].技能[i]==随机技能 then
				随机技能=兽决技能[取随机数(1,#兽决技能)]
			end
		end
		for  i=1,技能数量 do
			if 玩家数据[id].召唤兽.数据[内容.序列].技能[i]==随机技能 then
				随机技能=兽决技能[取随机数(1,#兽决技能)]
			end
		end
		for  i=1,技能数量 do
			if 玩家数据[id].召唤兽.数据[内容.序列].技能[i]==随机技能 then
				常规提示(id,"请重新使用道具，出现未知错误，请尝试重新使用")
				return
			end
		end
		local 顶书格子=#玩家数据[id].召唤兽.数据[内容.序列].技能+1
		玩家数据[id].召唤兽.数据[内容.序列].技能[顶书格子]=随机技能
		玩家数据[id].召唤兽.数据[内容.序列].技能突破=玩家数据[id].召唤兽.数据[内容.序列].技能突破+1
		-- self:当前图排序(bb)
		if 玩家数据[id].召唤兽.数据[内容.序列].超级技能~=nil then
			for k,v in pairs(玩家数据[id].召唤兽.数据[内容.序列].技能) do

				玩家数据[id].召唤兽.数据[内容.序列].超级技能[1].拥有=false
				玩家数据[id].召唤兽.数据[内容.序列].超级技能[2].拥有=false
				玩家数据[id].召唤兽.数据[内容.序列].超级技能[3].拥有=false
				玩家数据[id].召唤兽.数据[内容.序列].超级技能[4].拥有=false
				if v == 玩家数据[id].召唤兽.数据[内容.序列].超级技能[1].技能 then
				玩家数据[id].召唤兽.数据[内容.序列].超级技能[1].拥有=true
				end
				if v == 玩家数据[id].召唤兽.数据[内容.序列].超级技能[2].技能 then
				玩家数据[id].召唤兽.数据[内容.序列].超级技能[2].拥有=true
				end
				if v == 玩家数据[id].召唤兽.数据[内容.序列].超级技能[3].技能 then
				玩家数据[id].召唤兽.数据[内容.序列].超级技能[3].拥有=true
				end
				if v == 玩家数据[id].召唤兽.数据[内容.序列].超级技能[4].技能 then
				玩家数据[id].召唤兽.数据[内容.序列].超级技能[4].拥有=true
				end
			end
		end
			道具使用=true
		玩家数据[id].召唤兽.数据[内容.序列]:刷新信息()
		常规提示(id,"#Y你的召唤兽学会了#R"..随机技能.."#Y技能")


		----------召唤兽----------
	elseif 内容.窗口 =="坐骑" and self.数据[道具id].总类 == 112 then
		self:坐骑装饰佩戴(id,加血对象,道具格子,包裹类型)
		return

	elseif 名称=="指定元素曜石" then
	local 对话="#W/请选择所需要的元素曜石"
	local 门派={"元素曜石·冰","元素曜石·风","元素曜石·火","元素曜石·雷","元素曜石·水"
		,"元素曜石·岩"}
	local xx={}
	for i = 1,#门派 do
		xx[#xx+1]=门派[i]
	end
	玩家数据[id].最后对话={}
	玩家数据[id].最后对话.名称="指定元素曜石"
	玩家数据[id].最后对话.模型=玩家数据[id].角色.模型
	发送数据(玩家数据[id].连接id,1501,{名称="指定元素曜石",模型=玩家数据[id].角色.模型,对话=对话,选项=xx})
	return
	--------------------------
  elseif 名称=="玄灵珠·回春" then
  	if 玩家数据[id].角色.玄灵珠==nil then
  		玩家数据[id].角色.玄灵珠={类型="回春",破军=0,回春=0,空灵=0,噬魂=0}
  	end
  	if self.数据[道具id].级别限制==nil then self.数据[道具id].级别限制=1 end
  	if 玩家数据[id].角色.玄灵珠.回春>=10 then
  		常规提示(id,"玄灵珠·回春已满级")
			return
		elseif self.数据[道具id].级别限制+0 <= 玩家数据[id].角色.玄灵珠.回春+0 then
  	  	常规提示(id,"请使用等级" ..玩家数据[id].角色.玄灵珠.回春+1 .."的玄灵珠·回春")
			  return
  	end
		玩家数据[id].角色.玄灵珠.回春 = 玩家数据[id].角色.玄灵珠.回春 + 1
		发送数据(玩家数据[id].连接id,207,玩家数据[id].角色.玄灵珠)
		常规提示(id,"使用成功，当前玄灵珠·回春等级" ..玩家数据[id].角色.玄灵珠.回春)
		道具使用=true
  elseif 名称=="玄灵珠·破军" then
  	if 玩家数据[id].角色.玄灵珠==nil then
  		玩家数据[id].角色.玄灵珠={类型="回春",破军=0,回春=0,空灵=0,噬魂=0}
  	end
  	if self.数据[道具id].级别限制==nil then self.数据[道具id].级别限制=1 end
  	if 玩家数据[id].角色.玄灵珠.破军>=10 then
  		常规提示(id,"玄灵珠·破军已满级")
			return
		elseif self.数据[道具id].级别限制+0 <= 玩家数据[id].角色.玄灵珠.破军+0 then
  	  	常规提示(id,"请使用等级" ..玩家数据[id].角色.玄灵珠.破军+1 .."的玄灵珠·破军")
			  return
  	end
		玩家数据[id].角色.玄灵珠.破军 = 玩家数据[id].角色.玄灵珠.破军 + 1
		发送数据(玩家数据[id].连接id,207,玩家数据[id].角色.玄灵珠)
		常规提示(id,"使用成功，当前玄灵珠·破军等级" ..玩家数据[id].角色.玄灵珠.破军)
		道具使用=true
	elseif 名称=="玄灵珠·空灵" then
  	if 玩家数据[id].角色.玄灵珠==nil then
  		玩家数据[id].角色.玄灵珠={类型="回春",破军=0,回春=0,空灵=0,噬魂=0}
  	end
  	if self.数据[道具id].级别限制==nil then self.数据[道具id].级别限制=1 end
  	if 玩家数据[id].角色.玄灵珠.空灵>=10 then
  		常规提示(id,"玄灵珠·空灵已满级")
			return
		elseif self.数据[道具id].级别限制+0 <= 玩家数据[id].角色.玄灵珠.空灵+0 then
  	  	常规提示(id,"请使用等级" ..玩家数据[id].角色.玄灵珠.空灵+1 .."的玄灵珠·空灵")
			  return
  	end
	  	玩家数据[id].角色.玄灵珠.空灵 = 玩家数据[id].角色.玄灵珠.空灵 + 1
	  	发送数据(玩家数据[id].连接id,207,玩家数据[id].角色.玄灵珠)
		  常规提示(id,"使用成功，当前玄灵珠·空灵等级" ..玩家数据[id].角色.玄灵珠.空灵)
		  道具使用=true
	elseif 名称=="玄灵珠·噬魂" then
  	  if 玩家数据[id].角色.玄灵珠==nil then
  		玩家数据[id].角色.玄灵珠={类型="回春",破军=0,回春=0,空灵=0,噬魂=0}
  	end
  	  if self.数据[道具id].级别限制==nil then self.数据[道具id].级别限制=1 end
  	  if 玩家数据[id].角色.玄灵珠.噬魂>=10 then
  		常规提示(id,"玄灵珠·噬魂已满级")
			return
		elseif self.数据[道具id].级别限制+0 <= 玩家数据[id].角色.玄灵珠.噬魂+0 then
  	  常规提示(id,"请使用等级" ..玩家数据[id].角色.玄灵珠.噬魂+1 .."的玄灵珠·噬魂")
			 return
  	end
		  玩家数据[id].角色.玄灵珠.噬魂 = 玩家数据[id].角色.玄灵珠.噬魂 + 1
		  发送数据(玩家数据[id].连接id,207,玩家数据[id].角色.玄灵珠)
		  常规提示(id,"使用成功，当前玄灵珠·噬魂等级" ..玩家数据[id].角色.玄灵珠.噬魂)
		  道具使用=true
	---------------------------------------
  elseif 名称=="随机经验礼包" then
    local sjs=取随机数(5,10)*100000
    玩家数据[id].角色.当前经验=玩家数据[id].角色.当前经验+sjs
    常规提示(id,"#Y/你打开了随机经验礼包，获得了#R"..sjs.."#Y经验。")
    道具使用=true
  elseif 名称=="随机经验微礼包" then
    local sjs=取随机数(10,20)*150000
    玩家数据[id].角色.当前经验=玩家数据[id].角色.当前经验+sjs
    常规提示(id,"#Y/你打开了随机经验礼包，获得了#R"..sjs.."#Y经验。")
    道具使用=true
  elseif 名称=="随机经验小礼包" then
    local sjs=取随机数(20,30)*200000
    玩家数据[id].角色.当前经验=玩家数据[id].角色.当前经验+sjs
    常规提示(id,"#Y/你打开了随机经验礼包，获得了#R"..sjs.."#Y经验。")
    道具使用=true
  elseif 名称=="随机经验中礼包" then
    local sjs=取随机数(30,40)*250000
    玩家数据[id].角色.当前经验=玩家数据[id].角色.当前经验+sjs
    常规提示(id,"#Y/你打开了随机经验礼包，获得了#R"..sjs.."#Y经验。")
    道具使用=true
  elseif 名称=="随机经验大礼包" then
    local sjs=取随机数(10,50)*1000000
    玩家数据[id].角色.当前经验=玩家数据[id].角色.当前经验+sjs
    常规提示(id,"#Y/你打开了随机经验礼包，获得了#R"..sjs.."#Y经验。")
    道具使用=true
-------------------------------------------------------------
  elseif 名称=="随机仙玉礼包" then
    local sjs=取随机数(10,50)*10
    玩家数据[id].角色:添加仙玉(sjs,"随机仙玉礼包",1)
    常规提示(id,"#Y/你打开了随机仙玉礼包，获得了#R"..sjs.."#Y仙玉。")
    道具使用=true
  elseif 名称=="随机仙玉微礼包" then
    local sjs=取随机数(15,60)*10
    玩家数据[id].角色:添加仙玉(sjs,"随机仙玉礼包",1)
    常规提示(id,"#Y/你打开了随机仙玉礼包，获得了#R"..sjs.."#Y仙玉。")
    道具使用=true
  elseif 名称=="随机仙玉小礼包" then
    local sjs=取随机数(20,70)*10
    玩家数据[id].角色:添加仙玉(sjs,"随机仙玉礼包",1)
    常规提示(id,"#Y/你打开了随机仙玉礼包，获得了#R"..sjs.."#Y仙玉。")
    道具使用=true
  elseif 名称=="随机仙玉中礼包" then
    local sjs=取随机数(30,80)*10
    玩家数据[id].角色:添加仙玉(sjs,"随机仙玉礼包",1)
    常规提示(id,"#Y/你打开了随机仙玉礼包，获得了#R"..sjs.."#Y仙玉。")
    道具使用=true
  elseif 名称=="随机仙玉大礼包" then
    local sjs=取随机数(10,50)*100
    玩家数据[id].角色:添加仙玉(sjs,"随机仙玉礼包",1)
    常规提示(id,"#Y/你打开了随机仙玉大礼包，获得了#R"..sjs.."#Y仙玉。")
    道具使用=true
--------------------------------------
	elseif 名称 == "福禄丹" then
		if 加血对象==0 then
			常规提示(id,"请选择一只坐骑")
			return
		end
		if 内容.窗口 =="坐骑" and 玩家数据[id].角色.坐骑列表[加血对象] then
			if 玩家数据[id].角色.坐骑列表[加血对象].初始成长>=1.3433 then
				常规提示(id,"这只坐骑的初始成长已达先天的成长上限，无法继续服用。")
				return
			end
			玩家数据[id].角色.坐骑列表[加血对象].初始成长=玩家数据[id].角色.坐骑列表[加血对象].初始成长+0.05
			if 玩家数据[id].角色.坐骑列表[加血对象].初始成长>1.3433 then
				玩家数据[id].角色.坐骑列表[加血对象].初始成长=1.3433
			end
			常规提示(id,玩家数据[id].角色.坐骑列表[加血对象].名称.."服用了一个福禄丹后，神清气爽，仙气缭绕，初始成长增加了#R0.05#Y点！")
			发送数据(玩家数据[id].连接id,69,玩家数据[id].角色.坐骑列表[加血对象])
			玩家数据[id].角色:刷新信息("1")
			道具使用=true
		end
	elseif 名称 == "高级摄灵珠" or 名称 == "摄灵珠" then
		if 加血对象==0 then
			常规提示(id,"请选择一只坐骑")
			return
		end
		if 内容.窗口 =="坐骑" and 玩家数据[id].角色.坐骑列表[加血对象] then
			local zuoqi=玩家数据[id].角色.坐骑列表[加血对象]
			if zuoqi.额外成长>=0.9 then
				常规提示(id,"这只坐骑的额外成长最高不能超过1。")
				return
			end
			local lq=self.数据[道具id].灵气
			if 取随机数()<=10 then
				lq=lq*2
			end
			if zuoqi.SLZ==nil then
				zuoqi.SLZ={次数=100,灵气=0,时间=os.time()+86400,成长次数=1}
			else
				if os.time()-zuoqi.SLZ.时间>0 then
					zuoqi.SLZ.次数=100
					zuoqi.SLZ.时间=os.time()+86400
				elseif zuoqi.SLZ.次数<=0 then
					常规提示(id,"#Y/这只坐骑今日剩喂食次数不足，"..时间转换(zuoqi.SLZ.时间).."后才能继续喂食！")
					return
				end
			end
			  zuoqi.SLZ.灵气=zuoqi.SLZ.灵气+self.数据[道具id].灵气
			  zuoqi.SLZ.次数=zuoqi.SLZ.次数-1
			  zuoqi.SLZ.时间=os.time()+86400
			local gs = {80,200,320,520,820,1240,1820,2640,3760,6480}
			if zuoqi.SLZ.灵气>=gs[zuoqi.SLZ.成长次数] then
				zuoqi.SLZ.成长次数=zuoqi.SLZ.成长次数+1
				zuoqi.额外成长=zuoqi.额外成长+0.1
				常规提示(id,"#G"..zuoqi.名称.."服用了一个摄灵珠后，额外成长增加了0.1。")
				if zuoqi.额外成长>=0.9 then
					zuoqi.SLZ=nil
				end
			else
				常规提示(id,zuoqi.名称.."服用了一个摄灵珠后，灵气增加了#R"..lq.."#Y点，当前灵气#R"..zuoqi.SLZ.灵气.."#Y点，今日还可以喂食#R"..zuoqi.SLZ.次数.."#Y次。")
			end
			  发送数据(玩家数据[id].连接id,69,zuoqi)
			  玩家数据[id].角色:刷新信息("1")
			  道具使用=true
		end
	elseif 名称=="特殊兽诀·碎片" then
		   if self.数据[道具id].数量<50 then
			 常规提示(id,"还是先凑齐50本再打开看看吧。")
			 return
		end
		   self:删除道具(连接id,id,包裹类型,道具id,道具格子,50)
		   发送数据(连接id,3699)
		   local 链接 = {提示=format("#G/%s#P集齐了50本特殊兽诀·碎片，打开一看发现了一本",玩家数据[id].角色.名称),频道="xt",结尾="#28#P！"}
		   玩家数据[id].道具:给予超链接道具(id,"特殊魔兽要诀",nil,取碎片特殊要诀(),链接,"成功")

	 elseif 名称=="超级兽诀·碎片" then      --新加
	   	if self.数据[道具id].数量<99 then
	 		常规提示(id,"还是先凑齐99本再打开看看吧。")
	 		return
	 	end
	 	self:删除道具(连接id,id,包裹类型,道具id,道具格子,99)
	 	发送数据(连接id,3699)
	 	local 链接 = {提示=format("#G/%s#P集齐了99本超级兽诀·碎片，打开一看发现了一本",玩家数据[id].角色.名称),频道="xt",结尾="#28#P！"}
	 	玩家数据[id].道具:给予超链接道具(id,"超级魔兽要诀",nil,取碎片超级要诀(),链接,"成功")

	elseif 名称=="秘境降妖卡" then
		副本_秘境降妖:开启秘境降妖()
		发送公告("#R"..玩家数据[id].角色.名称.."#G为全服开启了【秘境降妖副本】")
		local 链接 = {提示=format("#G/%s#P为全服开启【秘境降妖副本】时偶然发现了一本",玩家数据[id].角色.名称),频道="hd",结尾="#28#P！"}
		玩家数据[id].道具:给予超链接道具(id,"高级魔兽要诀",nil,取高级要诀(),链接,"成功")
		道具使用=true
	--------------------------武神坛
 elseif 名称=="新三符石礼包" then
    local 获取符石 = 新三级符石[取随机数(1,#新三级符石)]
	  玩家数据[id].道具:给予道具(id,"少阳符石",3,获取符石)
	   玩家数据[id].道具:给予道具(id,"太阳符石",3,获取符石)
	    玩家数据[id].道具:给予道具(id,"太阴符石",3,获取符石)
	     玩家数据[id].道具:给予道具(id,"太极符石",3,获取符石)
	      玩家数据[id].道具:给予道具(id,"阴仪符石",3,获取符石)
	       玩家数据[id].道具:给予道具(id,"少阴符石",3,获取符石)
	       玩家数据[id].道具:给予道具(id,"阳仪符石",3,获取符石)
    道具使用=true
  elseif 名称=="星石礼包" then
		玩家数据[id].道具:给予道具(id,"未激活的星石")
    道具使用=true
  --------------------------
	elseif 名称=="五宝盒" then
		玩家数据[id].道具:给予道具(id,取五宝())
		道具使用=true
	elseif 名称=="未激活的符石" or 名称=="未激活的星石" then
		self:激活符石对话(id,道具id)
		return
	--------------------------武器附神-----------------------------------------------
	elseif 名称=="武器附神锤" then
		道具提示=false
		发送数据(玩家数据[id].连接id,233,{道具格子,self.数据[道具id].总类,self.数据[道具id].分类,self.数据[道具id].子类,"武器附神"})
---------------------------------------------------------------------------------------

	elseif 名称=="招魂帖" then
		if self:取队长权限(id)==false then
			常规提示(id,"#Y/你不是队长，无法使用此道具！")
			return
		elseif self.数据[道具id].地图编号~=玩家数据[id].角色.地图数据.编号 then
			常规提示(id,"#Y/地图不对哟！")
			return
		elseif math.abs(self.数据[道具id].x-玩家数据[id].角色.地图数据.x/20)>2 and math.abs(self.数据[道具id].y-玩家数据[id].角色.地图数据.y/20)>2 then
			常规提示(id,"#Y/坐标不对哟！")
			return
		end
		道具使用=true
		降妖伏魔:使用招魂帖(id,self.数据[道具id].地图编号,self.数据[道具id].x,self.数据[道具id].y)
	elseif 名称=="逐妖蛊虫" then
		if self:取队长权限(id)==false then
			常规提示(id,"#Y/你不是队长，无法使用此道具！")
			return
		elseif self.数据[道具id].地图编号~=玩家数据[id].角色.地图数据.编号 then
			常规提示(id,"#Y/地图不对哟！")
			return
		elseif math.abs(self.数据[道具id].x-玩家数据[id].角色.地图数据.x/20)>2 and math.abs(self.数据[道具id].y-玩家数据[id].角色.地图数据.y/20)>2 then
			常规提示(id,"#Y/坐标不对哟！")
			return
		end
		道具使用=true
		降妖伏魔:使用逐妖蛊虫(id)
	elseif 名称=="新手大礼包" then
		发送数据(连接id,3715,{是否领取=玩家数据[id].角色.成长礼包})
		return
	elseif 名称=="月饼" then
		if 玩家数据[id].角色.月饼==nil then
    		玩家数据[id].角色.月饼=0
		end
		if 玩家数据[id].角色.月饼 and 玩家数据[id].角色.月饼 >=100 then
		常规提示(id,"#Y/该道具使用次数已经达到上限")
		else
		玩家数据[id].角色.月饼 = (玩家数据[id].角色.月饼 or 0) + 1
		玩家数据[id].角色.潜力 = 玩家数据[id].角色.潜力 + 1
		常规提示(id,"#Y/你增加了1点潜能点")
		道具使用 = true
		end
		elseif 名称=="体验月卡" then
      if 玩家数据[id].角色.月卡 == nil then
	      玩家数据[道具id].专用 = nil
				玩家数据[道具id].专用 = true
		-- end
         玩家数据[id].角色.月卡 = {生效=true,到期时间=os.time()+86400*7}
      elseif os.time()-玩家数据[id].角色.月卡.到期时间 >= 0 then
         玩家数据[id].角色.月卡 = {生效=true,到期时间=os.time()+86400*7}
      else
         玩家数据[id].角色.月卡 = {生效=true,到期时间=玩家数据[id].角色.月卡.到期时间+86400*7}
      end
      常规提示(id,"#Y激活7天月卡成功,月卡到期日前,每日可领取奖励物品！")
	    道具使用=true
		elseif 名称=="月卡" then
      if 玩家数据[id].角色.月卡 == nil then
         玩家数据[id].角色.月卡 = {生效=true,到期时间=os.time()+2592000}
      elseif os.time()-玩家数据[id].角色.月卡.到期时间 >= 0 then
         玩家数据[id].角色.月卡 = {生效=true,到期时间=os.time()+2592000}
      else
         玩家数据[id].角色.月卡 = {生效=true,到期时间=玩家数据[id].角色.月卡.到期时间+2592000}
      end
      玩家数据[id].角色:添加称谓("威震天下")
      常规提示(id,"#Y激活月卡成功,月卡到期日前,每日可领取奖励物品！")
	    道具使用=true
	elseif 名称 == "抽奖令牌" then
		if 玩家数据[id].角色.抽奖机会 == nil then
        玩家数据[id].角色.抽奖机会=0
    end
    玩家数据[id].角色.抽奖机会=玩家数据[id].角色.抽奖机会+1
    常规提示(id,"当前抽奖机会为"..玩家数据[id].角色.抽奖机会..'次')
		道具使用=true
	elseif 名称 == "抽奖仙令" then
		if 玩家数据[id].角色.抽奖机会 == nil then
        玩家数据[id].角色.抽奖机会=0
    end
    玩家数据[id].角色.抽奖机会=玩家数据[id].角色.抽奖机会+10
    常规提示(id,"当前抽奖机会为"..玩家数据[id].角色.抽奖机会..'次')
		道具使用=true
	elseif 名称 == "天猴宝石箱" then
		local 名称=取宝石()
    玩家数据[id].道具:给予道具(id,名称,math.random(1,3))
		道具使用=true
	elseif 名称 == "天残宝石箱" then
		local 名称=取宝石()
    玩家数据[id].道具:给予道具(id,名称,math.random(3,5))
		道具使用=true
	elseif 名称 == "精锐宝石箱" then
		local 名称=取宝石()
    玩家数据[id].道具:给予道具(id,名称,math.random(4,6))
		道具使用=true
	elseif 名称 == "勇武宝石箱" then
		local 名称=取宝石()
    玩家数据[id].道具:给予道具(id,名称,math.random(6,8))
		道具使用=true
	elseif 名称 == "神威宝石箱" then
		local 名称=取宝石()
    玩家数据[id].道具:给予道具(id,名称,math.random(10,12))
		道具使用=true
	elseif 名称 == "天科宝石箱" then
		local 名称=取宝石()
    玩家数据[id].道具:给予道具(id,名称,math.random(12,14))
		道具使用=true
	elseif 名称 == "天元宝石箱" then
		local 名称=取宝石()
    玩家数据[id].道具:给予道具(id,名称,math.random(14,16))
		道具使用=true
	elseif 名称 == "王者宝石箱" then
		local 名称=取宝石()
    玩家数据[id].道具:给予道具(id,名称,math.random(16,20))
		道具使用=true
	----------
	elseif 名称 == "plus宝石箱" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<8 then
			常规提示(id,"背包不足，开启此物品至少需要8个格子")
			return 0
		end
		local 名称=取宝石()
		for i=1,8 do
    玩家数据[id].道具:给予道具(id,名称,i)
		end
		道具使用=true
	------
		elseif 名称=="精魄灵石灵石礼包-速度" then
			local 道具格子=玩家数据[id].角色:取道具格子2()
			if 道具格子<10 then
				常规提示(id,"背包不足，开启此物品至少需要10个格子")
				return 0
			end
			for i=1,10 do
    		玩家数据[id].道具:给予道具(id,"精魄灵石",i,'速度')
			end
			道具使用=true
		elseif 名称=="精魄灵石灵石礼包-伤害" then
			local 道具格子=玩家数据[id].角色:取道具格子2()
			if 道具格子<10 then
				常规提示(id,"背包不足，开启此物品至少需要10个格子")
				return 0
			end
			for i=1,10 do
    		玩家数据[id].道具:给予道具(id,"精魄灵石",i,'伤害')
			end
			道具使用=true
		elseif 名称=="精魄灵石灵石礼包-灵力" then
			local 道具格子=玩家数据[id].角色:取道具格子2()
			if 道具格子<10 then
				常规提示(id,"背包不足，开启此物品至少需要10个格子")
				return 0
			end
			for i=1,10 do
    		玩家数据[id].道具:给予道具(id,"精魄灵石",i,'灵力')
			end
			道具使用=true
		elseif 名称=="精魄灵石灵石礼包-防御" then
			local 道具格子=玩家数据[id].角色:取道具格子2()
			if 道具格子<10 then
				常规提示(id,"背包不足，开启此物品至少需要10个格子")
				return 0
			end
			for i=1,10 do
    		玩家数据[id].道具:给予道具(id,"精魄灵石",i,'防御')
			end
			道具使用=true
		elseif 名称=="精魄灵石灵石礼包-气血" then
			local 道具格子=玩家数据[id].角色:取道具格子2()
			if 道具格子<10 then
				常规提示(id,"背包不足，开启此物品至少需要10个格子")
				return 0
			end
			for i=1,10 do
    		玩家数据[id].道具:给予道具(id,"精魄灵石",i,'气血')
			end
			道具使用=true
	elseif 名称 == "黑宝石max" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<10 then
			常规提示(id,"背包不足，开启此物品至少需要10个格子")
			return 0
		end
		for i=1,10 do
    玩家数据[id].道具:给予道具(id,"黑宝石",i)
		end
		道具使用=true
	elseif 名称 == "红玛瑙max" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<10 then
			常规提示(id,"背包不足，开启此物品至少需要10个格子")
			return 0
		end
		for i=1,10 do
    玩家数据[id].道具:给予道具(id,"红玛瑙",i)
		end
		道具使用=true
	elseif 名称 == "太阳石max" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<10 then
			常规提示(id,"背包不足，开启此物品至少需要10个格子")
			return 0
		end
		for i=1,10 do
    玩家数据[id].道具:给予道具(id,"太阳石",i)
		end
		道具使用=true
	elseif 名称 == "光芒石max" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<10 then
			常规提示(id,"背包不足，开启此物品至少需要10个格子")
			return 0
		end
		for i=1,10 do
    玩家数据[id].道具:给予道具(id,"光芒石",i)
		end
		道具使用=true
	elseif 名称 == "月亮石max" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<16 then
			常规提示(id,"背包不足，开启此物品至少需要10个格子")
			return 0
		end
		for i=1,10 do
    玩家数据[id].道具:给予道具(id,"月亮石",i)
		end
		道具使用=true
	elseif 名称 == "舍利子max" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<10 then
			常规提示(id,"背包不足，开启此物品至少需要10个格子")
			return 0
		end
		for i=1,10 do
    玩家数据[id].道具:给予道具(id,"舍利子",i)
		end
		道具使用=true
	elseif 名称 == "翡翠石max" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<10 then
			常规提示(id,"背包不足，开启此物品至少需要10个格子")
			return 0
		end
		for i=1,10 do
    玩家数据[id].道具:给予道具(id,"翡翠石",i)
		end
		道具使用=true
	elseif 名称 == "黑宝石11-15" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<5 then
			常规提示(id,"背包不足，开启此物品至少需要5个格子")
			return 0
		end
		for i=11,15 do
    玩家数据[id].道具:给予道具(id,"黑宝石",i)
		end
		道具使用=true
	elseif 名称 == "红玛瑙11-15" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<5 then
			常规提示(id,"背包不足，开启此物品至少需要5个格子")
			return 0
		end
		for i=11,15 do
    玩家数据[id].道具:给予道具(id,"红玛瑙",i)
		end
		道具使用=true
	elseif 名称 == "太阳石11-15" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<5 then
			常规提示(id,"背包不足，开启此物品至少需要5个格子")
			return 0
		end
		for i=11,15 do
    玩家数据[id].道具:给予道具(id,"太阳石",i)
		end
		道具使用=true
	elseif 名称 == "光芒石11-15" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<5 then
			常规提示(id,"背包不足，开启此物品至少需要5个格子")
			return 0
		end
		for i=11,15 do
    玩家数据[id].道具:给予道具(id,"光芒石",i)
		end
		道具使用=true
	elseif 名称 == "月亮石11-15" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<5 then
			常规提示(id,"背包不足，开启此物品至少需要5个格子")
			return 0
		end
		for i=11,15 do
    玩家数据[id].道具:给予道具(id,"月亮石",i)
		end
		道具使用=true
	elseif 名称 == "舍利子11-15" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<5 then
			常规提示(id,"背包不足，开启此物品至少需要5个格子")
			return 0
		end
		for i=11,15 do
    玩家数据[id].道具:给予道具(id,"舍利子",i)
		end
		道具使用=true
	elseif 名称 == "翡翠石11-15" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<5 then
			常规提示(id,"背包不足，开启此物品至少需要5个格子")
			return 0
		end
		for i=11,15 do
    	玩家数据[id].道具:给予道具(id,"翡翠石",i)
		end
		道具使用=true
		-------------------------

	elseif 名称=="大额银票" then
		玩家数据[id].角色:添加银子(100000000,"抽奖",1)
		道具使用=true
	elseif 名称=="5E银票" then
		玩家数据[id].角色:添加银子(500000000,"抽奖",1)
		道具使用=true
	elseif 名称=="10E银票" then
		玩家数据[id].角色:添加银子(1000000000,"抽奖",1)
		道具使用=true
	elseif 名称=="小袋银两" then
		玩家数据[id].角色:添加银子(2000000,"抽奖",1)
		道具使用=true

	elseif 名称=="一万银票" then
		玩家数据[id].角色:添加银子(10000,"抽奖",1)
		道具使用=true
	elseif 名称=="十万银票" then
		玩家数据[id].角色:添加银子(100000,"抽奖",1)
		道具使用=true
	elseif 名称=="百万银票" then
		玩家数据[id].角色:添加银子(1000000,"抽奖",1)
		道具使用=true
	elseif 名称=="千万银票" then
		玩家数据[id].角色:添加银子(10000000,"抽奖",1)
		道具使用=true
	elseif 名称=="一亿银票" then
		玩家数据[id].角色:添加银子(100000000,"抽奖",1)
		道具使用=true
	elseif 名称=="十亿银票" then
		玩家数据[id].角色:添加银子(1000000000,"抽奖",1)
		道具使用=true
	elseif 名称=="百亿银票" then
		玩家数据[id].角色:添加银子(10000000000,"抽奖",1)
		道具使用=true
	elseif 名称=="千亿银票" then
		玩家数据[id].角色:添加银子(100000000000,"抽奖",1)
		道具使用=true



	elseif 名称=="十点仙玉" then
		玩家数据[id].角色:添加仙玉(10,"抽奖",1)
		道具使用=true
	elseif 名称=="一百仙玉" then
		玩家数据[id].角色:添加仙玉(100,"抽奖",1)
		道具使用=true
	elseif 名称=="一千仙玉" then
		玩家数据[id].角色:添加仙玉(1000,"抽奖",1)
		道具使用=true
	elseif 名称=="一万仙玉" then
		玩家数据[id].角色:添加仙玉(10000,"抽奖",1)
		道具使用=true
	elseif 名称=="十万仙玉" then
		玩家数据[id].角色:添加仙玉(100000,"抽奖",1)
		道具使用=true
	elseif 名称=="百万仙玉" then
		玩家数据[id].角色:添加仙玉(1000000,"抽奖",1)
		道具使用=true
	elseif 名称=="千万仙玉" then
		玩家数据[id].角色:添加仙玉(10000000,"抽奖",1)
		道具使用=true
	elseif 名称=="一亿仙玉" then
		玩家数据[id].角色:添加仙玉(100000000,"抽奖",1)
		道具使用=true
	elseif 名称=="十亿仙玉" then
		玩家数据[id].角色:添加仙玉(1000000000,"抽奖",1)
		道具使用=true
	elseif 名称=="百亿仙玉" then
		玩家数据[id].角色:添加仙玉(10000000000,"抽奖",1)
		道具使用=true
	elseif 名称=="千亿仙玉" then
		玩家数据[id].角色:添加仙玉(100000000000,"抽奖",1)
		道具使用=true


	elseif 名称 == "八级玄灵珠礼包" then
      local aa名称={"玄灵珠·回春","玄灵珠·破军","玄灵珠·空灵","玄灵珠·噬魂"}
      local abc = aa名称[取随机数(1,#aa名称)]
		 	玩家数据[id].道具:给予道具(id,abc,nil,8,nil,nil)
			道具使用=true
	elseif 名称 == "十级玄灵珠礼包" then
      local aa名称={"玄灵珠·回春","玄灵珠·破军","玄灵珠·空灵","玄灵珠·噬魂"}
      local abc = aa名称[取随机数(1,#aa名称)]
		 	玩家数据[id].道具:给予道具(id,abc,nil,10,nil,nil)
			道具使用=true
	elseif 名称 == "6级钟灵石礼包" then
      local aa名称 = {"健步如飞","血气方刚","回春之术","锐不可当","通真达灵","气壮山河"}
      local abc = aa名称[取随机数(1,#aa名称)]
	 	 	玩家数据[id].道具:给予道具(id,"钟灵石",nil,6,abc,nil)
	 		道具使用=true
	elseif 名称 == "8级钟灵石礼包" then
      local aa名称 = {"健步如飞","血气方刚","回春之术","锐不可当","通真达灵","气壮山河"}
      local abc = aa名称[取随机数(1,#aa名称)]
	 	 	玩家数据[id].道具:给予道具(id,"钟灵石",nil,8,abc,nil)
	 		道具使用=true
	elseif 名称 == "初级星辉石礼包" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<5 then
			常规提示(id,"背包不足，开启此物品至少需要5个格子")
			return 0
		end
		for i=1,5 do
    	玩家数据[id].道具:给予道具(id,"星辉石",i)
		end
		道具使用=true
	elseif 名称 == "中级星辉石礼包" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<4 then
			常规提示(id,"背包不足，开启此物品至少需要4个格子")
			return 0
		end
		for i=6,9 do
    	玩家数据[id].道具:给予道具(id,"星辉石",i)
		end
		道具使用=true
	elseif 名称 == "高级星辉石礼包" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<2 then
			常规提示(id,"背包不足，开启此物品至少需要2个格子")
			return 0
		end
		for i=10,11 do
    	玩家数据[id].道具:给予道具(id,"星辉石",i)
		end
		道具使用=true
	elseif 名称 == "plus星辉石礼包" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<6 then
			常规提示(id,"背包不足，开启此物品至少需要6个格子")
			return 0
		end
		for i=1,6 do
    玩家数据[id].道具:给予道具(id,"星辉石",i)
		end
		道具使用=true
elseif 名称 == "星辉石max" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<11 then
			常规提示(id,"背包不足，开启此物品至少需要11个格子")
			return 0
		end
		for i=1,11 do
    	玩家数据[id].道具:给予道具(id,"星辉石",i)
		end
		道具使用=true
	elseif 名称=="灵犀玉礼包" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<10 then
			常规提示(id,"您的道具栏物品已经满啦")
			return 0
		end
		玩家数据[id].道具:给予道具(id,"未鉴定的灵犀玉")
		玩家数据[id].道具:给予道具(id,"未鉴定的灵犀玉")
		玩家数据[id].道具:给予道具(id,"未鉴定的灵犀玉")
		玩家数据[id].道具:给予道具(id,"未鉴定的灵犀玉")
		玩家数据[id].道具:给予道具(id,"未鉴定的灵犀玉")
		玩家数据[id].道具:给予道具(id,"未鉴定的灵犀玉")
		玩家数据[id].道具:给予道具(id,"未鉴定的灵犀玉")
		玩家数据[id].道具:给予道具(id,"未鉴定的灵犀玉")
		玩家数据[id].道具:给予道具(id,"未鉴定的灵犀玉")
		玩家数据[id].道具:给予道具(id,"未鉴定的灵犀玉")
		道具使用=true
	elseif 名称=="九转金丹礼包" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<10 then
			常规提示(id,"您的道具栏物品已经满啦")
			return 0
		end
		玩家数据[id].道具:给予道具(id,"九转金丹",10)
		-- 玩家数据[id].道具:给予道具(id,"九转金丹")
		-- 玩家数据[id].道具:给予道具(id,"九转金丹")
		-- 玩家数据[id].道具:给予道具(id,"九转金丹")
		-- 玩家数据[id].道具:给予道具(id,"九转金丹")
		-- 玩家数据[id].道具:给予道具(id,"九转金丹")
		-- 玩家数据[id].道具:给予道具(id,"九转金丹")
		-- 玩家数据[id].道具:给予道具(id,"九转金丹")
		-- 玩家数据[id].道具:给予道具(id,"九转金丹")
		-- 玩家数据[id].道具:给予道具(id,"九转金丹")
		道具使用=true
	elseif 名称 == "超级鲲鹏礼盒（物理）" then
			玩家数据[id].召唤兽:添加神兽("超级鲲鹏","物理型（单点爆伤）")
			道具使用=true
  elseif 名称 == "超级鲲鹏礼盒（法术）" then
			玩家数据[id].召唤兽:添加神兽("超级鲲鹏","法术型（秒伤）")
		道具使用=true
	elseif 名称 == "特色兽诀礼盒" then
		local 链接 = {提示=format("#G/%s#P在开启特色兽诀礼盒发现了一本",玩家数据[id].角色.名称),频道="xt",结尾="#24#P！"}
		玩家数据[id].道具:给予超链接道具(id,"特色魔兽要诀",nil,取特色要诀(),链接,"成功")
		道具使用=true

	elseif 名称 == "24技能善恶" then
			if #玩家数据[id].召唤兽.数据 >= 玩家数据[id].角色.召唤兽携带上限 then
					常规提示(id,"#Y/你当前可携带的召唤兽数量已达上限！")
					return
			else
					礼包奖励类:增加礼包宠物(id,名称)
					道具使用=true
			end
	elseif 名称 == "定制宠礼盒（法术）" then
			if #玩家数据[id].召唤兽.数据 >= 玩家数据[id].角色.召唤兽携带上限 then
					常规提示(id,"#Y/你当前可携带的召唤兽数量已达上限！")
					return
			else
					礼包奖励类:增加礼包宠物(id,名称)
					道具使用=true
			end
	elseif 名称 == "定制宠礼盒（物理）" then
			if #玩家数据[id].召唤兽.数据 >= 玩家数据[id].角色.召唤兽携带上限 then
					常规提示(id,"#Y/你当前可携带的召唤兽数量已达上限！")
					return
			else
					礼包奖励类:增加礼包宠物(id,名称)
					道具使用=true
			end
	elseif 名称 == "24技能攻宠" then
		if #玩家数据[id].召唤兽.数据 >= 玩家数据[id].角色.召唤兽携带上限 then
					常规提示(id,"#Y/你当前可携带的召唤兽数量已达上限！")
					return
			else
					礼包奖励类:增加礼包宠物(id,名称)
					道具使用=true
			end
	elseif 名称 == "24技能法宠" then
		if #玩家数据[id].召唤兽.数据 >= 玩家数据[id].角色.召唤兽携带上限 then
					常规提示(id,"#Y/你当前可携带的召唤兽数量已达上限！")
					return
			else
					礼包奖励类:增加礼包宠物(id,名称)
					道具使用=true
			end
	elseif 名称 == "18技能攻宠" then
		if #玩家数据[id].召唤兽.数据 >= 玩家数据[id].角色.召唤兽携带上限 then
					常规提示(id,"#Y/你当前可携带的召唤兽数量已达上限！")
					return
			else
					礼包奖励类:增加礼包宠物(id,名称)
					道具使用=true
			end
	elseif 名称 == "18技能法宠" then
		if #玩家数据[id].召唤兽.数据 >= 玩家数据[id].角色.召唤兽携带上限 then
					常规提示(id,"#Y/你当前可携带的召唤兽数量已达上限！")
					return
			else
					礼包奖励类:增加礼包宠物(id,名称)
					道具使用=true
			end





	elseif 名称 == "24技能胚子" then
			if #玩家数据[id].召唤兽.数据 >= 玩家数据[id].角色.召唤兽携带上限 then
					常规提示(id,"#Y/你当前可携带的召唤兽数量已达上限！")
					return
			else
					礼包奖励类:增加礼包胚子(id,24)
					道具使用=true
			end
	elseif 名称 == "20技能胚子" then
			if #玩家数据[id].召唤兽.数据 >= 玩家数据[id].角色.召唤兽携带上限 then
					常规提示(id,"#Y/你当前可携带的召唤兽数量已达上限！")
					return
			else
					礼包奖励类:增加礼包胚子(id,20)
					道具使用=true
			end
	elseif 名称 == "16技能胚子" then
			if #玩家数据[id].召唤兽.数据 >= 玩家数据[id].角色.召唤兽携带上限 then
					常规提示(id,"#Y/你当前可携带的召唤兽数量已达上限！")
					return
			else
					礼包奖励类:增加礼包胚子(id,16)
					道具使用=true
			end
	elseif 名称 == "12技能胚子" then
			if #玩家数据[id].召唤兽.数据 >= 玩家数据[id].角色.召唤兽携带上限 then
					常规提示(id,"#Y/你当前可携带的召唤兽数量已达上限！")
					return
			else
					礼包奖励类:增加礼包胚子(id,12)
					道具使用=true
			end
	elseif 名称 == "10技能胚子" then
			if #玩家数据[id].召唤兽.数据 >= 玩家数据[id].角色.召唤兽携带上限 then
					常规提示(id,"#Y/你当前可携带的召唤兽数量已达上限！")
					return
			else
					礼包奖励类:增加礼包胚子(id,10)
					道具使用=true
			end
	elseif 名称 == "8技能胚子" then
			if #玩家数据[id].召唤兽.数据 >= 玩家数据[id].角色.召唤兽携带上限 then
					常规提示(id,"#Y/你当前可携带的召唤兽数量已达上限！")
					return
			else
					礼包奖励类:增加礼包胚子(id,8)
					道具使用=true
			end
	elseif 名称 == "特殊兽诀礼盒" then
		local 链接 = {提示=format("#G/%s#P在开启特殊兽诀礼盒时偶然发现了一本",玩家数据[id].角色.名称),频道="xt",结尾="#28#P！"}
		玩家数据[id].道具:给予超链接道具(id,"特殊魔兽要诀",nil,兑换特殊要诀(),链接,"成功")
		道具使用=true
	elseif 名称 == "稀有兽诀礼盒" then
		local 链接 = {提示=format("#G/%s#P在开启稀有兽诀礼盒时偶然发现了一本",玩家数据[id].角色.名称),频道="xt",结尾="#28#P！"}
		玩家数据[id].道具:给予超链接道具(id,"特殊魔兽要诀",nil,打开特殊要诀(),链接,"成功")
		道具使用=true
	elseif 名称 == "超级兽诀礼盒" then
		local 链接 = {提示=format("#G/%s#P在开启超级兽诀礼盒时偶然发现了一本",玩家数据[id].角色.名称),频道="xt",结尾="#28#P！"}
		local sj=取超级要诀()
		发送数据(玩家数据[id].连接id,354,sj)
		玩家数据[id].道具:给予超链接道具(id,"超级魔兽要诀",nil,sj,链接,"成功")
		道具使用=true
	elseif 名称 == "特色兽诀礼盒" then
		local 链接 = {提示=format("#G/%s#P在开启特色兽诀礼盒时偶然发现了一本",玩家数据[id].角色.名称),频道="xt",结尾="#28#P！"}
		玩家数据[id].道具:给予超链接道具(id,"特色魔兽要诀",nil,取特色要诀(),链接,"成功")
		道具使用=true

	elseif 名称=="三打160plus" then
		for k,v in pairs(玩家数据[id].角色.辅助技能) do
			if v.名称=="打造技巧" then
				v.等级=160
			elseif v.名称=="裁缝技巧" then
				v.等级=160
			elseif v.名称=="炼金术" then
				v.等级=160
			-- elseif v.名称=="养生之道" then
			-- 	v.等级=160
			-- elseif v.名称=="健身术" then
			-- 	v.等级=160
			-- elseif v.名称=="熔炼技巧" then
			-- 	v.等级=160
			-- elseif v.名称=="巧匠之术" then
			-- 	v.等级=160
			-- elseif v.名称=="灵石技巧" then
			-- 	v.等级=160
			-- elseif v.名称=="淬灵之术" then
			-- 	v.等级=160
			-- elseif v.名称=="中药医理" then
			-- 	v.等级=160
			-- elseif v.名称=="烹饪技巧" then
			-- 	v.等级=160
			-- elseif v.名称=="强身术" then
			-- 	v.等级=60
			-- elseif v.名称=="冥思" then
			-- 	v.等级=60
			end
		end
		玩家数据[id].角色:刷新信息()
		常规提示(id,"恭喜！您的打造技能通关啦")
		道具使用=true


	elseif 名称=="装备特效宝珠礼包" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<1 then
			常规提示(id,"您的道具栏物品已经满啦")
			return 0
		end
		玩家数据[id].道具:给予道具(id,"装备特效宝珠",10)
		道具使用=true
	elseif 名称=="神兜兜礼包" then
		玩家数据[id].道具:给予道具(id,"神兜兜",取随机数(2,5))
		道具使用=true
	elseif 名称=="高级宝石礼包" then
    local 随机宝石 = {"红玛瑙","太阳石","舍利子","黑宝石","月亮石","光芒石","星辉石"}
    local  随机宝石1=随机宝石[取随机数(1,#随机宝石)]
		玩家数据[id].道具:给予道具(id,随机宝石1,取随机数(12,15))
		道具使用=true
	elseif 名称=="修炼果礼包" then
		玩家数据[id].道具:给予道具(id,"修炼果",取随机数(5,5))
		道具使用=true
	elseif 名称=="陨铁礼包" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<1 then
			常规提示(id,"您的道具栏物品已经满啦")
			return 0
		end
		玩家数据[id].道具:给予道具(id,"陨铁",10)
		道具使用=true
  elseif 名称=="160附魔宝珠礼包" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<10 then
		常规提示(id,"您的道具栏物品已经满啦")
		return 0
		end
		玩家数据[id].道具:给予道具(id,"附魔宝珠",1)
		玩家数据[id].道具:给予道具(id,"附魔宝珠",1)
		玩家数据[id].道具:给予道具(id,"附魔宝珠",1)
		玩家数据[id].道具:给予道具(id,"附魔宝珠",1)
		玩家数据[id].道具:给予道具(id,"附魔宝珠",1)
		玩家数据[id].道具:给予道具(id,"附魔宝珠",1)
		玩家数据[id].道具:给予道具(id,"附魔宝珠",1)
		玩家数据[id].道具:给予道具(id,"附魔宝珠",1)
		玩家数据[id].道具:给予道具(id,"附魔宝珠",1)
		玩家数据[id].道具:给予道具(id,"附魔宝珠",1)
		道具使用=true

	elseif 名称=="160钨金礼包" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<1 then
		常规提示(id,"您的道具栏物品已经满啦")
		return 0
		end
		玩家数据[id].道具:给予道具(id,"钨金",10)
		道具使用=true
	elseif 名称=="灵犀之屑礼包" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<1 then
		常规提示(id,"您的道具栏物品已经满啦")
		return 0
		end
		玩家数据[id].道具:给予道具(id,"灵犀之屑",10)
		道具使用=true

  elseif 名称=="路费大礼包" then
  		玩家数据[id].道具:给予道具(id,"鬼谷子",nil,nil)
  		玩家数据[id].道具:给予道具(id,"小袋银两")
  		玩家数据[id].道具:给予道具(id,"金银锦盒",100)
  		玩家数据[id].道具:给予道具(id,"120无级别礼包")
  		玩家数据[id].道具:给予道具(id,"120无级别礼包")
  		玩家数据[id].道具:给予道具(id,"120无级别礼包")
  		玩家数据[id].道具:给予道具(id,"120无级别礼包")
  		玩家数据[id].道具:给予道具(id,"120无级别礼包")
  		道具使用=true
  elseif 名称=="100无级别礼包" then
		礼包奖励类:全套专用装备(id,100,"无级别限制",id)
		道具使用=true
	elseif 名称=="110无级别礼包" then
		礼包奖励类:全套专用装备(id,110,"无级别限制",id)
		道具使用=true
	elseif 名称=="120无级别礼包" then
		礼包奖励类:全套专用装备(id,120,"无级别限制",id)
		道具使用=true
	elseif 名称=="130无级别礼包" then
		礼包奖励类:全套专用装备(id,130,"无级别限制",id)
		道具使用=true
	elseif 名称=="140无级别礼包" then
		礼包奖励类:全套专用装备(id,140,"无级别限制",id)
		道具使用=true
	elseif 名称=="150无级别礼包" then
		礼包奖励类:全套专用装备(id,150,"无级别限制",id)
		道具使用=true
	elseif 名称=="160无级别礼包" then
		礼包奖励类:全套专用装备(id,160,"无级别限制",id)
		道具使用=true
---------------------------------------------------------------------
	elseif 名称=="元素曜石礼包" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<10 then
			常规提示(id,"请在背包预留10个道具格子再开启礼包")
			return
		end
		for i = 1,10 do
		local  随机元素 = {"元素曜石·冰","元素曜石·风","元素曜石·火","元素曜石·雷","元素曜石·水","元素曜石·岩"}
		local  随机元素1=随机元素[取随机数(1,#随机元素)]
		玩家数据[id].道具:给予道具(id,随机元素1,0)
		end
		道具使用=true

----------------------------------------------------------------------
	elseif 名称=="160无级别全套" then
		礼包奖励类:固定属性装备(id,160,"无级别限制",id)
		道具使用=true
	elseif 名称=="60灵饰礼包" then
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"枫华戒",60,"戒指"))
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"翠叶环",60,"耳饰"))
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"香木镯",60,"手镯"))
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"芝兰佩",60,"佩饰"))
		道具使用=true
	elseif 名称=="80灵饰礼包" then
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"芙蓉戒",80,"戒指"))
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"明月珰",80,"耳饰"))
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"翡玉镯",80,"手镯"))
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"逸云佩",80,"佩饰"))
		道具使用=true
	elseif 名称=="100灵饰礼包" then
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"金麟绕",100,"戒指"))
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"玉蝶翩",100,"耳饰"))
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"墨影扣",100,"手镯"))
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"莲音玦",100,"佩饰"))
		道具使用=true
	elseif 名称=="120灵饰礼包" then
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"悦碧水",120,"戒指"))
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"点星芒",120,"耳饰"))
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"花映月",120,"手镯"))
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"相思染",120,"佩饰"))
		道具使用=true
	elseif 名称=="140灵饰礼包" then
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"九曜光华",140,"戒指"))
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"凤羽流苏",140,"耳饰"))
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"金水菩提",140,"手镯"))
		玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"玄龙苍珀",140,"佩饰"))
		道具使用=true
  elseif 名称=="特效宝珠" then
		 玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id,道具=玩家数据[id].道具:索要道具1(id)}
		 发送数据(连接id,314,玩家数据[id].道具操作)
		  return
	elseif 名称=="低级矿石" then
     local 奖励参数=取随机数(1,100)
    if 奖励参数<=30 then
    	local 名称="摇钱树苗"
      玩家数据[id].道具:给予道具(id,名称,1)
			常规提示(id,"#Y/你获得了"..名称)
			广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
  elseif 奖励参数<=40 then
    	local 名称="召唤兽内丹"
      玩家数据[id].道具:给予道具(id,名称,1)
			常规提示(id,"#Y/你获得了"..名称)
			广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
  elseif 奖励参数<=50 then
    	local 名称="五宝盒"
    	玩家数据[id].道具:给予道具(id,名称,1)
			常规提示(id,"#Y/你获得了"..名称)
			广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
  elseif 奖励参数<=55 then
      local 名称="金银锦盒"
      玩家数据[id].道具:给予道具(id,名称,1)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
  elseif 奖励参数<=60 then
      local 名称="九转金丹"
      玩家数据[id].道具:给予道具(id,名称,1,10)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
  elseif 奖励参数<=65 then
      local 名称="修炼果"
      玩家数据[id].道具:给予道具(id,名称,1)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
  elseif 奖励参数<=70 then
      local 名称=取宝石()
      玩家数据[id].道具:给予道具(id,名称,取随机数(1,2))
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
  elseif 奖励参数<=75 then
      local 名称=取强化石()
      玩家数据[id].道具:给予道具(id,名称,1)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
      else
      local 名称="20W银子"
      玩家数据[id].角色:添加银子(200000,"低级矿石",1)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,"5W银子"),频道="xt"})
      end
      道具使用=true
  elseif 名称=="中级矿石" then
      local 奖励参数=取随机数(1,100)
      if 奖励参数<=30 then
    	local 名称="摇钱树苗"
      玩家数据[id].道具:给予道具(id,名称,1)
			常规提示(id,"#Y/你获得了"..名称)
			广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
  elseif 奖励参数<=40 then
    	local 名称="召唤兽内丹"
      玩家数据[id].道具:给予道具(id,名称,1)
			常规提示(id,"#Y/你获得了"..名称)
			广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
  elseif 奖励参数<=50 then
    	local 名称="五宝盒"
    	玩家数据[id].道具:给予道具(id,名称,1)
			常规提示(id,"#Y/你获得了"..名称)
			广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
  elseif 奖励参数<=55 then
      local 名称="金银锦盒"
      玩家数据[id].道具:给予道具(id,名称,1)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
  elseif 奖励参数<=60 then
      local 名称="九转金丹"
      玩家数据[id].道具:给予道具(id,名称,1,10)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
  elseif 奖励参数<=65 then
      local 名称="修炼果"
      玩家数据[id].道具:给予道具(id,名称,1)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
  elseif 奖励参数<=70 then
      local 名称=取宝石()
      玩家数据[id].道具:给予道具(id,名称,取随机数(2,3))
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
  elseif 奖励参数<=75 then
      local 名称=取强化石()
      玩家数据[id].道具:给予道具(id,名称,1)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
      else
      local 名称="10W银子"
      玩家数据[id].角色:添加银子(100000,"中级矿石",1)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,"10W银子"),频道="xt"})
      end
      道具使用=true
  elseif 名称=="高级矿石" then
      local 奖励参数=取随机数(1,100)
      if 奖励参数<=30 then
    	local 名称="摇钱树苗"
      玩家数据[id].道具:给予道具(id,名称,1)
			常规提示(id,"#Y/你获得了"..名称)
			广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
  elseif 奖励参数<=40 then
    	local 名称="召唤兽内丹"
      玩家数据[id].道具:给予道具(id,名称,1)
			常规提示(id,"#Y/你获得了"..名称)
			广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
  elseif 奖励参数<=50 then
    	local 名称="五宝盒"
    	玩家数据[id].道具:给予道具(id,名称,1)
			常规提示(id,"#Y/你获得了"..名称)
			广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
    elseif 奖励参数<=55 then
      local 名称="金银锦盒"
      玩家数据[id].道具:给予道具(id,名称,1)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
    elseif 奖励参数<=60 then
      local 名称="九转金丹"
      玩家数据[id].道具:给予道具(id,名称,1,20)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
    elseif 奖励参数<=65 then
      local 名称="修炼果"
      玩家数据[id].道具:给予道具(id,名称,1)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
    elseif 奖励参数<=70 then
      local 名称=取宝石()
      玩家数据[id].道具:给予道具(id,名称,取随机数(3,4))
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
    elseif 奖励参数<=75 then
      local 名称=取强化石()
      玩家数据[id].道具:给予道具(id,名称,1)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
    else
      local 名称="30W银子"
      玩家数据[id].角色:添加银子(300000,"高级矿石",1)
      常规提示(id,"#Y/你获得了"..名称)
      广播消息({内容=format("#S(采矿大师)#R/%s#Y在#R采矿大师#Y处上交了矿石，因此获得了采矿大师的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,"15W银子"),频道="xt"})
     end
     道具使用=true
	elseif 名称=="机缘宝箱" then
		  抽奖处理:设置钥匙神秘宝箱(id,连接id)
		  道具使用=true
	elseif 名称=="秘宝宝箱" then
		  抽奖处理:转盘抽奖(id)
		  道具使用=true
	elseif 名称=="祈愿宝箱" then
		  帮派迷宫:开祈愿宝箱(id)
		  self.数据[道具id].次数=self.数据[道具id].次数-1
		  if self.数据[道具id].次数<=0 then
			道具使用=true
		else
			return
		end
	elseif 名称=="符纸" then
		if 玩家数据[id].角色:取任务(1163)~=0 and 任务数据[玩家数据[id].角色:取任务(1163)].分类==7 and 任务数据[玩家数据[id].角色:取任务(1163)].子类==2 then
			if 任务数据[玩家数据[id].角色:取任务(1163)].SZDT=="大雁塔一层" and 玩家数据[id].角色.地图数据.编号==1004 then
				文韵墨香:大雁塔烧纸(id)
				道具使用=true
	elseif 任务数据[玩家数据[id].角色:取任务(1163)].SZDT=="大雁塔二层" and 玩家数据[id].角色.地图数据.编号==1005 then
				文韵墨香:大雁塔烧纸(id)
				道具使用=true
			else
				常规提示(id,"请到指定地点焚烧！")
				return
			end
		else
			常规提示(id,"请到指定地点焚烧！")
			return
		end
	elseif 名称=="鬼谷子" then
		  if 玩家数据[id].角色.阵法[self.数据[道具id].子类]==nil then
			 玩家数据[id].角色.阵法[self.数据[道具id].子类]=1
			 常规提示(id,"恭喜你学会了如何使用#R/"..self.数据[道具id].子类)
			 道具使用=true
		else
			 常规提示(id,"你已经学过如何使用这个阵型了，请勿重复学习")
			 return
		end
	elseif 名称=="超级合成旗" then
      发送数据(玩家数据[id].连接id,3529.4,"超级合成旗")
      玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
      玩家数据[id].最后操作="超级合成旗"
      return
	elseif self.数据[道具id].总类==11 and self.数据[道具id].分类==2 then  --合成旗
		  发送数据(玩家数据[id].连接id,3529,{地图=self.数据[道具id].地图,xy=self.数据[道具id].xy})
		  玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
		  玩家数据[id].最后操作="合成旗"
		  return
	elseif 名称=="怪物卡片" then
		  local 剧情等级=玩家数据[id].角色:取剧情技能等级("变化之术")
		  if 剧情等级<6 and self.数据[道具id].等级>剧情等级 then
			常规提示(id,"#Y/你的变化之术等级太低了")
			return
		end
		if 玩家数据[id].角色:取任务(1)~=0 then
			任务数据[玩家数据[id].角色:取任务(1)]=nil
			玩家数据[id].角色:取消任务(1)
		end
		玩家数据[id].角色.变身数据=self.数据[道具id].造型
		道具使用=true
		玩家数据[id].角色:刷新信息()
		发送数据(连接id,37,玩家数据[id].角色.变身数据)
		常规提示(id,"你使用了怪物卡片")
		发送数据(连接id,47,{玩家数据[id].角色:取气血数据()})
		发送数据(玩家数据[id].连接id,12)
		设置任务1(id,剧情等级,玩家数据[id].角色.变身数据)
		地图处理类:更改模型(id,玩家数据[id].角色.变身数据,1)
	elseif 名称=="小象炫卡" or 名称=="腾蛇炫卡" or 名称=="龙马炫卡" or 名称=="雪人炫卡" then
		if 玩家数据[id].角色:取任务(1)~=0 then
			任务数据[玩家数据[id].角色:取任务(1)]=nil
			玩家数据[id].角色:取消任务(1)
		end
		玩家数据[id].角色.变身数据=self.数据[道具id].造型
		道具使用=true
		玩家数据[id].角色:刷新信息()
		发送数据(连接id,37,玩家数据[id].角色.变身数据)
		常规提示(id,"你使用了怪物卡片")
		发送数据(连接id,47,{玩家数据[id].角色:取气血数据()})
		发送数据(玩家数据[id].连接id,12)
		设置任务1a(id,剧情等级,玩家数据[id].角色.变身数据)
		地图处理类:更改模型(id,玩家数据[id].角色.变身数据,1)
	elseif 名称=="摄妖香" then
		if 玩家数据[id].角色:取任务(9)~=0 then
			玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(9))
		end
		设置任务9(id)
		常规提示(id,"#Y/你使用了摄妖香")
		道具使用=true
	elseif 名称=="未鉴定的灵犀玉" then
		玩家数据[id].道具:给予道具(id,"灵犀玉")
		道具使用=true
	elseif 名称=="自动抓鬼卡" then
		if self.数据[道具id].专用 == nil then
			self.数据[道具id].专用 = id
		end
		if self.数据[道具id].专用 ~= id then
			常规提示(id,"#Y/该道具为玩家" ..id .."专用")
			return
		end
		玩家数据[id].角色:判断抓鬼卡日期(id)
		return
	elseif 名称 == "清灵净瓶" then
		local 随机瓶子={"高级清灵仙露","中级清灵仙露","初级清灵仙露"}
		local a =随机瓶子[取随机数(1,#随机瓶子)]
		self:给予道具(id,a)
		道具使用=true
	elseif 名称=="洞冥草" then
		if 玩家数据[id].角色:取任务(9)~=0 then
			玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(9))
			常规提示(id,"#Y/你解除了摄妖香的效果")
			道具使用=true
		end
	elseif 名称=="无常勾魂索" then
		发送数据(玩家数据[id].连接id,3706)
		return
	elseif 名称=="三界悬赏令" then
		if 玩家数据[id].角色:取任务(209)~=0 then
			常规提示(id,"#Y/你已经有个悬赏任务在进行了")
		else
			设置任务209(id)
			常规提示(id,"#Y/你获得了三界悬赏任务")
			道具使用=true
		end
	elseif 名称=="树苗" then
			设置任务505(id)
			常规提示(id,"#Y/你种下了树苗")
			道具使用=true
	elseif 名称=="秘制红罗羹" then
		if 玩家数据[id].角色:取任务(10)~=0 then
			local 任务id=玩家数据[id].角色:取任务(10)
			if 任务数据[任务id].气血 == nil then
				任务数据[任务id].气血 = 0
			end
			任务数据[任务id].气血=任务数据[任务id].气血+5000000
			常规提示(id,"#Y/你使用了秘制红罗羹")
			道具使用=true
			玩家数据[id].角色:刷新任务跟踪()
		else
			设置任务10(id,5000000,0,0)
			常规提示(id,"#Y/你使用了秘制红罗羹")
			道具使用=true
		end
	elseif 名称=="秘制绿芦羹" then
		if 玩家数据[id].角色:取任务(10)~=0 then
			local 任务id=玩家数据[id].角色:取任务(10)
			if 任务数据[任务id].魔法 == nil then
				任务数据[任务id].魔法 = 0
			end
			任务数据[任务id].魔法=任务数据[任务id].魔法+5000000
			常规提示(id,"#Y/你使用了秘制绿罗羹")
			道具使用=true
			玩家数据[id].角色:刷新任务跟踪()
		else
			设置任务10(id,0,5000000,0)
			常规提示(id,"#Y/你使用了秘制绿罗羹")
			道具使用=true
		end
	elseif 名称=="秘制回梦饮" then
		玩家数据[id].角色.储备灵气 = 玩家数据[id].角色.储备灵气+160
		常规提示(id,"#Y/你获得了#R/160#Y/点神仙饮灵气，现有神仙饮灵气#R"..玩家数据[id].角色.储备灵气.."#Y/点")
		道具使用=true
	elseif 名称=="神仙饮" then
		玩家数据[id].角色.神仙饮灵气 = 玩家数据[id].角色.神仙饮灵气+200
		常规提示(id,"#Y/你获得了#R/200#Y/点神仙饮灵气，现有神仙饮灵气#R"..玩家数据[id].角色.神仙饮灵气.."#Y/点")
		道具使用=true
	elseif 名称=="百岁香" then
		if 玩家数据[id].角色.活力+(self.数据[道具id].阶品*2+150) > 玩家数据[id].角色.最大活力 then 常规提示(id,"使用后活力超过了最大数值无法使用") return end
		if 玩家数据[id].角色.体力+(self.数据[道具id].阶品*2+150) > 玩家数据[id].角色.最大体力 then 常规提示(id,"使用后体力超过了最大数值无法使用") return end
		玩家数据[id].角色.活力 = 玩家数据[id].角色.活力+(self.数据[道具id].阶品*2+150)
		玩家数据[id].角色.体力 = 玩家数据[id].角色.体力+(self.数据[道具id].阶品*2+150)
		道具使用=true
	elseif 名称=="白色导标旗" or 名称=="黄色导标旗" or 名称=="蓝色导标旗" or 名称=="绿色导标旗" or 名称=="红色导标旗"  then
		if self.数据[道具id].地图==nil then --定标
			local 地图=玩家数据[id].角色.地图数据.编号
			if 地图~=1001 and 地图~=1070 and 地图~=1208 and 地图~=1092 and 地图~=1122 then
				常规提示(id,"只有长安城、长寿村、傲来国、朱紫国、地府、这四个城市才可以定标哟！")
				return
			end
			local 等级=玩家数据[id].角色:取剧情技能等级("奇门遁甲")
			if 地图==1070 and 等级<1 then
			  常规提示(id,"本场景定标需要您的奇门遁甲技能等级达到1级")
			  return
			elseif 地图==1092 and 等级<2 then
			  常规提示(id,"本场景定标需要您的奇门遁甲技能等级达到2级")
			  return
			elseif 地图==1001 and 等级<1 then
			  常规提示(id,"本场景定标需要您的奇门遁甲技能等级达到3级")
			  return
			elseif 地图==1208 and 等级<2 then
			  常规提示(id,"本场景定标需要您的奇门遁甲技能等级达到4级")
			  return
			end
			self.数据[道具id].地图=玩家数据[id].角色.地图数据.编号
			self.数据[道具id].x=math.floor(玩家数据[id].角色.地图数据.x/20)
			self.数据[道具id].y=math.floor(玩家数据[id].角色.地图数据.y/20)
			self.数据[道具id].次数=20
			发送数据(玩家数据[id].连接id,3699)
			常规提示(id,"定标成功！")
			return
		else
			发送数据(玩家数据[id].连接id,1501,{选项={"请送我过去","我再想想"},对话=format("请确认是否要传送至#G/%s(%s,%s)#W/处",取地图名称(self.数据[道具id].地图),self.数据[道具id].x,self.数据[道具id].y)})
			玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
			玩家数据[id].最后操作="导标旗"
			return
		end
	elseif 名称=="飞行符" then
		if self:取飞行限制(id)==false then
			玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
			玩家数据[id].最后操作="飞行符"
			发送数据(连接id,13)
			return
		end
	elseif 名称=="新春飞行符" then
		if self:取飞行限制(id)==false then
			玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
			玩家数据[id].最后操作="新春飞行符"
			发送数据(连接id,26)
			return
		end
	elseif 名称=="天眼通符" then
		if 玩家数据[id].角色:取任务(8)~=0 then
			任务数据[玩家数据[id].角色:取任务(8)].显示x= 任务数据[玩家数据[id].角色:取任务(8)].x
			任务数据[玩家数据[id].角色:取任务(8)].显示y= 任务数据[玩家数据[id].角色:取任务(8)].y
			道具使用=true
			常规提示(id,"#Y/你使用了天眼通符")
			玩家数据[id].角色:刷新任务跟踪()
			地图处理类:跳转地图(id,任务数据[玩家数据[id].角色:取任务(8)].地图编号,任务数据[玩家数据[id].角色:取任务(8)].x,任务数据[玩家数据[id].角色:取任务(8)].y)
		elseif 玩家数据[id].角色:取任务(14)~=0 then
			任务数据[玩家数据[id].角色:取任务(14)].显示x= 任务数据[玩家数据[id].角色:取任务(14)].x
			任务数据[玩家数据[id].角色:取任务(14)].显示y= 任务数据[玩家数据[id].角色:取任务(14)].y
			道具使用=true
			常规提示(id,"#Y/你使用了天眼通符")
			玩家数据[id].角色:刷新任务跟踪()
			if 调试模式 then
				地图处理类:跳转地图(id,任务数据[玩家数据[id].角色:取任务(14)].地图编号,任务数据[玩家数据[id].角色:取任务(14)].x,任务数据[玩家数据[id].角色:取任务(14)].y)
			end
		end
-------------------------------即时战斗-宝石怪-----------------
  elseif 名称=="沸涌炎海的信标" then
      地图处理类:跳转地图(id,5001,112,27)
      自写活动:沸涌炎海的信标(id)
      道具使用=true
  elseif 名称=="钢铁炼境的信标" then
      地图处理类:跳转地图(id,1241,99,78)
      自写活动:钢铁炼境的信标(id)
      道具使用=true
  elseif 名称=="雷鸣废土的信标" then
      地图处理类:跳转地图(id,1885,47,32)
      自写活动:雷鸣废土的信标(id)
      道具使用=true
  elseif 名称=="幽夜暗域的信标" then
      地图处理类:跳转地图(id,1223,66,46)
      自写活动:幽夜暗域的信标(id)
      道具使用=true
  elseif 名称=="混乱终末的信标" then
      地图处理类:跳转地图(id,1041,68,60)
      自写活动:混乱终末的信标(id)
      道具使用=true
  elseif 名称=="伟大虚空的信标" then
      地图处理类:跳转地图(id,1212,81,58)
      自写活动:伟大虚空的信标(id)
      道具使用=true
  elseif 名称=="巅峰领域的信标" then
      地图处理类:跳转地图(id,5006,143,88)
      自写活动:巅峰领域的信标(id)
      道具使用=true
-------------------------------------------------------------------------------------
	elseif 名称=="藏宝图" or 名称=="高级藏宝图" or 名称=="玲珑宝图" then
		if self:取队长权限(id)==false then
			常规提示(id,"#Y/你不是队长，无法使用此道具！")
			return
		end
		local datas = self.数据[道具id]      --挖图直飞，沉默自改
		if datas.地图编号 and datas.x and datas.y then
			地图处理类:跳转地图(id,datas.地图编号,datas.x,datas.y)
		end
		if self.数据[道具id].地图编号~=玩家数据[id].角色.地图数据.编号 then
			常规提示(id,"#Y/这里没有宝藏哟！")
			return
		end
		if math.abs(self.数据[道具id].x-玩家数据[id].角色.地图数据.x/20)>2 and math.abs(self.数据[道具id].y-玩家数据[id].角色.地图数据.y/20)>2 then
			常规提示(id,"#Y/这里没有宝藏哟！")
			return
		end
		道具使用=true
		if 名称=="高级藏宝图" then
			self:高级藏宝图处理(id)
		elseif 名称=="玲珑宝图" then
			self:玲珑宝图处理(id)
		else
			self:低级藏宝图处理(id)
		end
	elseif 名称=="九转金丹" then
		if  玩家数据[id].角色.修炼[玩家数据[id].角色.修炼.当前][1] >= 玩家数据[id].角色.修炼[玩家数据[id].角色.修炼.当前][3]  then 常规提示(id,"#Y/你的此项修炼已经达上限") return end
		玩家数据[id].角色:添加人物修炼经验(id,math.floor((self.数据[道具id].阶品 or 1)*0.5))
		道具使用=true
	elseif 名称=="修炼果" then
		if  玩家数据[id].角色.bb修炼[玩家数据[id].角色.bb修炼.当前][1]>= 玩家数据[id].角色.bb修炼[玩家数据[id].角色.bb修炼.当前][3]  then 常规提示(id,"#Y/你的此项修炼已经达上限") return end
		玩家数据[id].角色:添加bb修炼经验(id,150)
		道具使用=true
	elseif 名称=="吸附石" then
		发送数据(玩家数据[id].连接id,245)
		return
	elseif 名称=="储灵袋" then
		    for n = 1,4 do
			  local 已佩戴=玩家数据[id].角色.法宝佩戴[n]
			  if 已佩戴 and self.数据[已佩戴] and self.数据[已佩戴].魔法 then
				local 上限=取灵气上限(self.数据[已佩戴].分类)
				self.数据[已佩戴].魔法=self.数据[已佩戴].魔法+15
				if self.数据[已佩戴].魔法>上限 then
					self.数据[已佩戴].魔法=上限
				end
				消息提示(id, "你的法宝"..self.数据[已佩戴].名称.."灵气增加了15点")
			  end
		    end
		    道具使用=true
	elseif 名称=="回梦丹" then
		 --  if 玩家数据[id].角色:取任务(15)~=0 then
			-- 常规提示(id,"#Y/当前已经使用回梦丹了，无法再使用该物品")
			-- return
			-- end
		  设置任务15(id)
		  道具使用=true
	elseif 名称=="海马" then
		  玩家数据[id].角色.活力 = 玩家数据[id].角色.活力+150
		  玩家数据[id].角色.体力 = 玩家数据[id].角色.体力+150
		  if 玩家数据[id].角色.活力 > 玩家数据[id].角色.最大活力 then
			玩家数据[id].角色.活力=玩家数据[id].角色.最大活力
		end
	    if 玩家数据[id].角色.体力 > 玩家数据[id].角色.最大体力 then
			玩家数据[id].角色.体力=玩家数据[id].角色.最大体力
		end
		  体活刷新(id)
		  道具使用=true
	elseif string.find(名称,"自选")  and string.find(名称,"灵饰") and string.find(名称,"-") then
    发送数据(玩家数据[id].连接id,3539,{类型=名称})
    玩家数据[id].道具操作={类型=包裹类型,编号=内容.编号,id=道具id}
    玩家数据[id].最后操作=名称
    return
	elseif self.数据[道具id].名称 == "钟灵石" or self.数据[道具id].名称=="淬灵石" or  self.数据[道具id].名称 == "空白强化符" or self.数据[道具id].名称 == "强化符" or self.数据[道具id].名称 == "神兵图鉴" or self.数据[道具id].名称 == "器灵·金蝉"   or self.数据[道具id].名称 == "器灵·无双"   or self.数据[道具id].名称 == "青铜灵物"   or self.数据[道具id].名称 == "上古残符"or self.数据[道具id].名称 == "灵宝图鉴" or self.数据[道具id].名称 == "灵饰图鉴" or self.数据[道具id].名称 == "特技书" or self.数据[道具id].名称 == "装备特效宝珠"  or self.数据[道具id].名称 == "灵饰特效宝珠"  or self.数据[道具id].名称 == "愤怒符" then
		  发送数据(玩家数据[id].连接id,233,{道具格子,self.数据[道具id].总类,self.数据[道具id].分类,self.数据[道具id].子类,"鉴定"})
		  return
	elseif self.数据[道具id].名称 == "不磨符" then
	    发送数据(玩家数据[id].连接id,233,{道具格子,self.数据[道具id].总类,self.数据[道具id].分类,self.数据[道具id].子类,"特效"})
		  return
	elseif self.数据[道具id].名称 == "双加转换符" then
	    发送数据(玩家数据[id].连接id,233,{道具格子,self.数据[道具id].总类,self.数据[道具id].分类,self.数据[道具id].子类,"双加转换"})
		  return
	elseif 名称=="附魔宝珠" then
		  发送数据(连接id,3717,{道具=self:索要道具1(id),宝珠数据 = 道具id})
		  return
	elseif self.数据[道具id].总类 == 144 then --冒泡框
		  玩家数据[id].角色.发言特效 = self.数据[道具id].分类
		  道具使用=true
	elseif 名称=="炫彩ID" then
		  玩家数据[id].角色.id特效 = self.数据[道具id].特效
		  道具使用=true
		  常规提示(id,"使用成功！")
	elseif 名称 == "队标特效" then
		  local tx = {"桃心","风车","彩虹","扇子","小猪","音符","火苗","草莓","兔子","蝴蝶","海星","葫芦","螃蟹","狮王","绿叶","红伞","猫头"}
		  玩家数据[id].角色.队标特效 = tx[取随机数(1,#tx)]
		  常规提示(id,"你获得#G"..玩家数据[id].角色.队标特效.."#Y队标……")
		  地图处理类:更改队伍样式(id,玩家数据[id].角色.队标特效)
		  道具使用=true
	elseif self.数据[道具id].名称 == "神秘宝箱" then
		if self:消耗背包道具(连接id,id,"神秘钥匙",1) then
			道具使用=true
			商店处理类:设置神秘宝箱(id)
			发送数据(连接id,235,{道具=神秘宝箱[id],类型="神秘宝箱"})
		else
			常规提示(id,"你没有神秘钥匙无法打开神秘宝箱")
		  end
	elseif self.数据[道具id].名称 == "陨铁" then
		  发送数据(连接id,239)
		  道具提示 = false
	-- elseif self.数据[道具id].名称 == "秘制食谱" then
	-- 	  local lssj = 秘制食谱子类()[self.数据[道具id].子类]
	-- 	  if 玩家数据[id].角色.秘制食谱.食谱[lssj] == nil then
	-- 		玩家数据[id].角色.秘制食谱.食谱[lssj] = {次数=秘制食谱消耗()[lssj].次数}
	-- 	else
	-- 		玩家数据[id].角色.秘制食谱.食谱[lssj].次数 =  玩家数据[id].角色.秘制食谱.食谱[lssj].次数+秘制食谱消耗()[lssj].次数
	-- 	end
	-- 	  道具使用=true
	elseif self.数据[道具id].名称 == "长安战报" then
		  长安保卫战:获取玩家数据(id)
		  道具提示 = false
	elseif self.数据[道具id].名称 == "九霄清心丸" then
		  设置任务241(id)
		  道具使用=true

	elseif 名称=="种族坐骑" then
		  玩家数据[id].角色:增加种族坐骑(id)
		  道具使用=true
	elseif self.数据[道具id].名称 == "摇钱树苗" then
		 if 玩家数据[id].角色:取任务(505)~=0 then
			常规提示(id,"#Y/你之前已经种下一棵摇钱树苗了")
			return
		elseif 地图处理类.遇怪地图[玩家数据[id].角色.地图数据.编号]==nil then
			常规提示(id,"#Y/本场景无法种植树苗")
			return
		elseif 玩家数据[id].队伍~=0 then
			常规提示(id,"队伍中无法进行此任务。")
			return
		else
				设置任务505(id)
				常规提示(id,"#Y/你种下了一颗摇钱树")
				道具使用=true
		end




	elseif self.数据[道具id].名称 == "超级兽诀·碎片" or self.数据[道具id].名称 == "特殊兽诀·碎片" then
		  道具提示=false

	end
	    if 道具使用 then
		  		self:删除道具(连接id,id,包裹类型,道具id,道具格子,删除数量)
		  		发送数据(连接id,3699)
			else
		  		if 道具提示 then
						常规提示(id,"您无法使用这样的道具")
					end
			end
end
function 道具处理类:清灵仙露处理(连接id,id,加血对象,道具id)
	    if 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 > 100 then
		  常规提示(id,"该召唤兽已无法再使用清灵仙露")
		  return false
	elseif 玩家数据[id].召唤兽.数据[加血对象].进阶.清灵仙露 >= 8 then
		  常规提示(id,"该召唤兽已使用8瓶清灵仙露！无法再继续服用了")
		  return false
	end
	    local 临时灵性 =1
	    if 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 >= 50 then
		  if self.数据[道具id].灵气 == 8 then
			if 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 >=100 then
				临时灵性 = 取随机数(9,10)
			else
				临时灵性 = 取随机数(self.数据[道具id].灵气 - 1,self.数据[道具id].灵气+2)
			end
		else
			local jil = 25
			if self.数据[道具id].名称 == "中级清灵仙露" then
				jil = 45
			elseif self.数据[道具id].名称 == "高级清灵仙露" then
				jil = 60
			end
			if 取随机数()<jil then
				临时灵性 = 取随机数(self.数据[道具id].灵气+1,self.数据[道具id].灵气+2)
			else
				临时灵性 = self.数据[道具id].灵气
			end
		end
	   else
		  常规提示(id,"召唤兽灵性必须达到50以上才能使用清灵仙露！")
		  return false
	end
	if self.数据[道具id].名称=="特殊清灵仙露" then
		玩家数据[id].召唤兽.数据[加血对象].潜力 = 玩家数据[id].召唤兽.数据[加血对象].潜力 + (110-玩家数据[id].召唤兽.数据[加血对象].进阶.灵性)*2
		玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 = 110
	else
		玩家数据[id].召唤兽.数据[加血对象].潜力 = 玩家数据[id].召唤兽.数据[加血对象].潜力 + 临时灵性*2
		玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 = 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 + 临时灵性
		玩家数据[id].召唤兽.数据[加血对象].进阶.清灵仙露 = 玩家数据[id].召唤兽.数据[加血对象].进阶.清灵仙露 + 1
		常规提示(id,玩家数据[id].召唤兽.数据[加血对象].名称.."服用了一个清灵仙露后，神清气爽，仙气缭绕，灵性增加了#R"..临时灵性.."#Y点！（还可以食用#R"..(8-玩家数据[id].召唤兽.数据[加血对象].进阶.清灵仙露).."#Y个清灵仙露）") --
	end
	if 玩家数据[id].召唤兽.数据[加血对象].进阶.灵性 == 110 then
		玩家数据[id].召唤兽.数据[加血对象].临时进阶 = {
			力量 = 0,
			敏捷 = 0,
			耐力 = 0,
			魔力 = 0,
			体质 = 0,
		}
		发送数据(连接id,105,{头像="进阶",标题="灵兽现世",说明="获得一只灵性为110的召唤兽！"})
		常规提示(id,"你的召唤兽#R"..玩家数据[id].召唤兽.数据[加血对象].名称.."#Y发生了一些变化，快去找御兽仙（仙缘洞天,151,59）问看看吧？")
	end
	玩家数据[id].召唤兽.数据[加血对象]:刷新信息()
	发送数据(连接id,16,玩家数据[id].召唤兽.数据)
	发送数据(连接id,108,{认证码=玩家数据[id].召唤兽.数据[加血对象].认证码,进阶=玩家数据[id].召唤兽.数据[加血对象].进阶})
	return true
end

function 道具处理类:宝宝进阶(连接id,id,内容)
	if 玩家数据[id].角色.参战信息==nil then
		常规提示(id,"#Y/请将需要进阶的宝宝参战！")
		return
	end
	local 最低灵气 = {}
	if 玩家数据[id].角色.参战宝宝.进阶 and 玩家数据[id].角色.参战宝宝.进阶.灵性==110 then
		local gz = 内容.位置
		for i=1,5 do
			if gz[i]==nil then
				常规提示(id,"#Y/物品数据异常！")
				return
			end
			local 道具id=玩家数据[id].角色["道具"][gz[i]]
			if self.数据[道具id] == nil then
				常规提示(id,"#Y/物品数据异常！")
				return
			elseif self.数据[道具id].名称~="初级清灵仙露" and self.数据[道具id].名称~="中级清灵仙露" and self.数据[道具id].名称~="高级清灵仙露" then
				常规提示(id,"#Y/物品数据异常！")
				return
			end
			最低灵气[i]=self.数据[道具id].灵气
			if self.数据[道具id].数量~=nil and self.数据[道具id].数量>1 then
				self.数据[道具id].数量 = self.数据[道具id].数量 -1
			else
				self.数据[道具id]=nil
				玩家数据[id].角色["道具"][gz[i]]=nil
			end
		end
		table.sort(最低灵气, function(a, b) return a < b end)
		local bbbh=玩家数据[id].召唤兽:取编号(玩家数据[id].角色.参战宝宝.认证码)
		玩家数据[id].召唤兽.数据[bbbh].临时进阶 = {
			力量 = 取随机数(最低灵气[1],最低灵气[5]*3),
			敏捷 = 取随机数(最低灵气[1],最低灵气[5]*3),
			耐力 = 取随机数(最低灵气[1],最低灵气[5]*3),
			魔力 = 取随机数(最低灵气[1],最低灵气[5]*3),
			体质 = 取随机数(最低灵气[1],最低灵气[5]*3),
		}
		常规提示(id,"#Y/清灵仙露的灵气已经环绕在召唤兽周围，请选择希望#R保留哪个属性#Y。")
		玩家数据[id].召唤兽.数据[bbbh]:刷新信息()
		发送数据(连接id,3699)
		发送数据(连接id,3513,玩家数据[id].道具:索要道具2(id))
		发送数据(连接id,110,{宝宝=玩家数据[id].召唤兽.数据[bbbh]})
	else
		常规提示(id,"#Y/提升召唤兽能力需灵性达到110")
		return
	end
end

function 道具处理类:使用合成旗(连接id,id,序列)
	if 玩家数据[id].道具操作==nil then return  end
	local 编号=玩家数据[id].道具操作.编号
	local 道具id=玩家数据[id].角色[玩家数据[id].道具操作.类型][编号]
	if 道具id==nil or self.数据[道具id]==nil or self.数据[道具id].总类~=11 or self.数据[道具id].分类~=2 then
		常规提示(id,"#Y你没有这样的道具")
		return
	end
	if self.数据[道具id].xy[序列]==nil then
		常规提示(id,"#Y错误的坐标选择点")
		return
	end
	if self.数据[道具id].xy[序列].x==nil then
		常规提示(id,"#Y错误的坐标选择点")
		return
	end
	if self.数据[道具id].xy[序列].y==nil then
		常规提示(id,"#Y错误的坐标选择点")
		return
	end
	if self:取飞行限制(id) then
		return
	end
	self.数据[道具id].次数=self.数据[道具id].次数-1
	地图处理类:跳转地图(id,self.数据[道具id].地图,self.数据[道具id].xy[序列].x,self.数据[道具id].xy[序列].y)
	if self.数据[道具id].次数<=0 then
		玩家数据[id].角色[玩家数据[id].道具操作.类型][编号]=nil
		self.数据[道具id]=nil
	else
		常规提示(id,format("#Y你的%s还可以使用%s次",self.数据[道具id].名称,self.数据[道具id].次数))
	end
	玩家数据[id].道具操作=nil
	道具刷新(id)
end
function 道具处理类:使用超级合成旗(连接id,id,内容)
  local 地图=内容.地图
  local 地图x=内容.地图x
  local 地图y=内容.地图y
  if 玩家数据[id].道具操作==nil then return  end
  local 编号=玩家数据[id].道具操作.编号
  local 道具id=玩家数据[id].角色[玩家数据[id].道具操作.类型][编号]
  if 道具id==nil or self.数据[道具id]==nil or self.数据[道具id].总类~=11 or self.数据[道具id].分类~=2 then
    常规提示(id,"#Y你没有这样的道具")
    return
  elseif 地图x==nil or 地图y==nil or 地图==nil then
    常规提示(id,"#Y错误的坐标选择点")
    return
  end
  if self.数据[道具id].次数 then
self.数据[道具id].次数=self.数据[道具id].次数-1
end
  if self.数据[道具id].次数<=0 then
    玩家数据[id].角色[玩家数据[id].道具操作.类型][编号]=nil
    常规提示(id,format("#Y你的%s已经用完了",self.数据[道具id].名称))
    self.数据[道具id]=nil
  else
    玩家数据[id].道具操作=nil
    道具刷新(id)
    地图处理类:跳转地图(id,地图,地图x,地图y)
  end
end
function 道具处理类:侵蚀系统(连接id,id,内容)----侵蚀系统
		if 	 玩家数据[id].角色.等级<69 then
			常规提示(id,"#Y你修为尚浅，身子骨受不了这种折腾，起码要69级以上")
			return
		end
		local aa ="侵蚀品质由低到高分为刻骨、钻心、噬魂。每接受一次侵蚀需要耗费大量银子和经验，深度侵蚀的概率会随着侵蚀次数而提升，你愿意赌一把吗？"
		local xx={"我愿意接受侵蚀","消费不起"}
		发送数据(连接id,1501,{名称="接受侵蚀",对话=aa,选项=xx})
end
function 道具处理类:使用法宝(连接id,id,编号)
	local 道具id=玩家数据[id].角色.法宝[编号]
	if 道具id==nil or self.数据[道具id]==nil then
		常规提示(id,"#Y你没有这件法宝")
		self:索要法宝(连接id,id)
		return
	end
	local 名称=self.数据[道具id].名称
	if 名称=="五色旗盒" then
		if self.数据[道具id].魔法<=0 then
			常规提示(id,"#Y你的法宝灵气不足")
			return
		elseif 玩家数据[id].角色.等级<60 then
			常规提示(id,"#Y你的等级不足以使用此法宝")
			return
		end
		local aa ="请选择你要进行的操作："
		local xx={"合成导标旗","补充合成旗"}
		发送数据(连接id,1501,{名称="五色旗盒",对话=aa,选项=xx})
		玩家数据[id].最后操作="合成旗1"
		玩家数据[id].法宝id=编号
		return
	elseif 名称=="月光宝盒" then
		if self.数据[道具id].魔法<5 then
			常规提示(id,"#Y你的法宝灵气不足")
			return
		elseif 玩家数据[id].角色.等级<100 then
			常规提示(id,"#Y你的等级不足以使用此法宝")
			return
		end
		local aa ="请选择你要进行的操作："
		local xx={"送我过去","在这里定标"}
		发送数据(连接id,1501,{名称="月光宝盒",对话=aa,选项=xx})
		玩家数据[id].最后操作="月光宝盒"
		玩家数据[id].法宝id=编号
		return
	elseif 名称=="影蛊" then
		if self.数据[道具id].魔法<5 then
			常规提示(id,"#Y你的法宝灵气不足")
			return
		elseif 玩家数据[id].角色.等级<100 then
			常规提示(id,"#Y你的等级不足以使用此法宝")
			return
		end
		发送数据(连接id,63,{名称="影蛊"})
		玩家数据[id].最后操作="影蛊"
		玩家数据[id].法宝id=编号
		return
	end
	常规提示(id,"#Y鼠标左键抓取，方可替换或使用此法宝")
	return
end

function 道具处理类:替换法宝(连接id,id,编号,位置)
	if 编号=="神器" then
		if 玩家数据[id].角色.法宝佩戴[位置] and self.数据[玩家数据[id].角色.法宝佩戴[位置]] then
			if not self:卸下法宝(连接id,id,位置) then
				return
			end
		end
		玩家数据[id].神器:佩戴神器(连接id,id,位置)
		return
	else
		if 玩家数据[id].神器.数据.是否佩戴神器 and 玩家数据[id].神器.数据.格子==位置 then
			玩家数据[id].神器:卸下神器(连接id,id)
		end
	end
	local 道具id=玩家数据[id].角色.法宝[编号]
	if 道具id==nil or self.数据[道具id]==nil then
		常规提示(id,"#Y你没有这件法宝")
		self:索要法宝(连接id,id)
		return
	end
	if 玩家数据[id].角色.等级<self.数据[道具id].特技 then
		常规提示(id,"#Y你当前的等级无法佩戴此类型的法宝")
		return
	end
	if 取法宝门派(self.数据[道具id].名称) ~= "无门派" and 玩家数据[id].角色.门派 ~= 取法宝门派(self.数据[道具id].名称) then --测试
		常规提示(id,"#Y你无法佩戴这个门派的法宝")
		self:索要法宝(连接id,id)
		return
	end
	if 位置 and 位置==4 and  玩家数据[id].角色.等级 <120 then
		常规提示(id,"#Y120级才可以佩戴第4个法宝")
		return
	end
	-------------------
	local pd3jfb=0
	for n = 1,4 do
		local 已佩戴=玩家数据[id].角色.法宝佩戴[n]
		if 玩家数据[id].角色.法宝佩戴[n] and self.数据[已佩戴] then
			if self.数据[已佩戴].分类==3 then
				pd3jfb=pd3jfb+1
			end
		end
	end
	if  pd3jfb >= 1 then
		常规提示(id,"#Y3级法宝只可以佩戴一个")
		return
	end
	-------------------
	if self.数据[道具id].分类 == 4 and  玩家数据[id].角色.等级 <120 then return 常规提示(id,"#Y120级才可以佩戴第4个法宝") end
	local 类型判定 = 0
	local 佩戴判定 = 0
	local 同类型=0
	for n = 1,4 do
		local 已佩戴=玩家数据[id].角色.法宝佩戴[n]
		if 玩家数据[id].角色.法宝佩戴[n] and self.数据[已佩戴] then
			if self.数据[已佩戴].子类 == self.数据[道具id].子类 then
				同类型=同类型+1
				if 同类型>=2 then
					常规提示(id,"#Y相同类型的法宝佩戴不能超过2个")
					self:索要法宝(连接id,id)
					return
				end
			end
			if self.数据[已佩戴].分类==4 then --4级法宝
				佩戴判定 = 佩戴判定 +1
			end
		end
	end
	if self.数据[道具id].分类 == 4 then
		if 佩戴判定 == 1 then
			if 玩家数据[id].角色.历劫.化圣 == false then
				if 玩家数据[id].角色.法宝佩戴[位置] == nil then
					self:索要法宝(连接id,id)
					return 常规提示(id,"#Y只有化圣后化圣境界3可以佩戴两个四级法宝")
				elseif 玩家数据[id].角色.法宝佩戴[位置] ~= nil and self.数据[玩家数据[id].角色.法宝佩戴[位置]].分类~=4  then
					self:索要法宝(连接id,id)
					return 常规提示(id,"#Y只有化圣后化圣境界3可以佩戴两个四级法宝")
				end
			elseif 玩家数据[id].角色.历劫.化圣 and 玩家数据[id].角色.历劫.化圣境界 ~= nil and 玩家数据[id].角色.历劫.化圣境界 < 3 then
				if 玩家数据[id].角色.法宝佩戴[位置] == nil then
					self:索要法宝(连接id,id)
					return 常规提示(id,"#Y只有化圣后化圣境界3可以佩戴两个四级法宝")
				elseif 玩家数据[id].角色.法宝佩戴[位置] ~= nil and self.数据[玩家数据[id].角色.法宝佩戴[位置]].分类~=4  then
					self:索要法宝(连接id,id)
					return 常规提示(id,"#Y只有化圣后化圣境界3可以佩戴两个四级法宝")
				end
			end
		elseif 佩戴判定 == 2 then
			if 玩家数据[id].角色.历劫.化圣 and 玩家数据[id].角色.历劫.化圣境界 ~= nil and 玩家数据[id].角色.历劫.化圣境界 < 3 then
				self:索要法宝(连接id,id)
				return 常规提示(id,"#Y只有化圣后化圣境界3可以佩戴两个四级法宝")
			elseif 玩家数据[id].角色.历劫.化圣 and 玩家数据[id].角色.历劫.化圣境界 ~= nil and 玩家数据[id].角色.历劫.化圣境界 >= 3 then
				if 玩家数据[id].角色.法宝佩戴[位置] == nil then
					self:索要法宝(连接id,id)
					return 常规提示(id,"#Y只有化圣后化圣境界3可以佩戴两个四级法宝")
				elseif 玩家数据[id].角色.法宝佩戴[位置] ~= nil and self.数据[玩家数据[id].角色.法宝佩戴[位置]].分类~=4  then
					self:索要法宝(连接id,id)
					return 常规提示(id,"#Y只有化圣后化圣境界3可以佩戴两个四级法宝")
				end
			end
		end
	end
	if 玩家数据[id].角色.法宝佩戴[位置]==nil then
		玩家数据[id].角色.法宝佩戴[位置]=玩家数据[id].角色.法宝[编号]
		玩家数据[id].角色.法宝[编号]=nil
	else
		local 临时编号=玩家数据[id].角色.法宝[编号]
		玩家数据[id].角色.法宝[编号]=玩家数据[id].角色.法宝佩戴[位置]
		玩家数据[id].角色.法宝佩戴[位置]=临时编号
	end
	self:索要法宝(连接id,id)
	玩家数据[id].角色:刷新信息()
end

function 道具处理类:卸下法宝(连接id,id,编号,神器)
	if 神器 then
		玩家数据[id].神器:卸下神器(连接id,id)
		return false
	end
	local 格子=玩家数据[id].角色:取法宝格子()
	if 格子==0 then
		常规提示(id,"#Y你的法宝栏已经满了")
		return false
	end
	玩家数据[id].角色.法宝[格子]=玩家数据[id].角色.法宝佩戴[编号]
	玩家数据[id].角色.法宝佩戴[编号]=nil
	self:索要法宝(连接id,id)
	玩家数据[id].角色:刷新信息()
	return true
end

function 道具处理类:修炼法宝(连接id,id,编号)
	local 道具id=玩家数据[id].角色.法宝[编号]
	if 道具id==nil or self.数据[道具id]==nil then
		常规提示(id,"#Y你没有这件法宝")
		self:索要法宝(连接id,id)
		return
	end
	local 上限=9
	if self.数据[道具id].分类==2 then
		上限=12
	elseif self.数据[道具id].分类==3 then
		上限=15
	elseif self.数据[道具id].分类==4 then
		上限=18
	end
	if self.数据[道具id].气血==上限 then
		常规提示(id,"#Y你的这件法宝已经满层了，无法再进行修炼")
		return
	end
	local 消耗经验=math.floor(self.数据[道具id].升级经验*0.5)
	if 消耗经验>10000000 then
		消耗经验=10000000
	end
	if 玩家数据[id].角色.当前经验<消耗经验 then
		常规提示(id,"#Y本次修炼需要消耗#R"..消耗经验.."#Y点人物经验，您似乎没有那么多的经验哟")
		return
	end
	玩家数据[id].角色.当前经验=玩家数据[id].角色.当前经验-消耗经验
	常规提示(id,"#Y修炼成功,你消耗了#R"..消耗经验.."#Y了点人物经验")
	self.数据[道具id].当前经验=self.数据[道具id].当前经验+消耗经验
	if self.数据[道具id].当前经验>=self.数据[道具id].升级经验 then
		self.数据[道具id].气血=self.数据[道具id].气血+1
		self.数据[道具id].当前经验=self.数据[道具id].当前经验-self.数据[道具id].升级经验
		self.数据[道具id].魔法=取灵气上限(self.数据[道具id].分类)
		if self.数据[道具id].气血<上限 then
			self.数据[道具id].升级经验=法宝经验[self.数据[道具id].分类][self.数据[道具id].气血+1]
		end
		常规提示(id,"#Y你的法宝#R"..self.数据[道具id].名称.."#Y境界提升了")
	end
	发送数据(连接id,226,{当前经验=玩家数据[id].角色.当前经验,最大经验=玩家数据[id].角色.最大经验})
	发送数据(连接id,3528,{id=编号,当前经验=self.数据[道具id].当前经验,升级经验=self.数据[道具id].升级经验,境界=self.数据[道具id].气血,灵气=self.数据[道具id].魔法})
end

function 道具处理类:法宝补充灵气(连接id,id,编号)
	local 道具id=玩家数据[id].角色.法宝[编号]
	if 道具id==nil or self.数据[道具id]==nil then
		常规提示(id,"#Y只有法宝才可以补充灵气哟，你这个是什么玩意？")

		return
	elseif self.数据[道具id].总类~=1000 then
		添加最后对话(id,"只有法宝才可以补充灵气哟，你这个是什么玩意？")
		return
	end
	local 价格=500000
	if 玩家数据[id].角色.银子<价格 then
		添加最后对话(id,"本次补充法宝灵气需要消耗"..价格.."两银子，你身上没有那么多的现金哟。")
		return
	end
	玩家数据[id].角色:扣除银子(价格,0,0,"补充法宝扣除，法宝名称为"..self.数据[道具id].名称,1)
	-- self.数据[道具id].魔法=取灵气上限(self.数据[道具id].分类)
	self.数据[道具id].魔法=self.数据[道具id].魔法+50
	添加最后对话(id,"补充法宝灵气成功！")
	self:索要法宝(连接id,id)
end

function 道具处理类:替换灵宝(连接id,id,编号,编号1)
	local 道具id=玩家数据[id].角色.灵宝[编号]
	if 道具id==nil or self.数据[道具id]==nil then
		常规提示(id,"#Y你没有这件法宝")
		self:索要法宝(连接id,id)
		return
	end
	-- if self.数据[道具id].特技 ~= "通用灵宝" then
	-- 	if self.数据[道具id].特技 ~= 玩家数据[id].角色.门派 then
	-- 		self:索要法宝(连接id,id)
	-- 		return 常规提示(id,"#Y你的门派无法佩戴此灵宝")
	-- 	end
	-- end
	if 玩家数据[id].角色.灵宝佩戴[编号1]==nil then
		玩家数据[id].角色.灵宝佩戴[编号1]=玩家数据[id].角色.灵宝[编号]
		玩家数据[id].角色.灵宝[编号]=nil
	else
		local 临时编号=玩家数据[id].角色.灵宝[编号]
		玩家数据[id].角色.灵宝[编号]=玩家数据[id].角色.灵宝佩戴[编号1]
		玩家数据[id].角色.灵宝佩戴[编号1]=临时编号
	end
	self:索要法宝(连接id,id)
end

function 道具处理类:卸下灵宝(连接id,id,编号)
	local 格子=玩家数据[id].角色:取灵宝格子()
	if 格子==0 then
		常规提示(id,"#Y你的灵宝栏已经满了")
		return
	end
	玩家数据[id].角色.灵宝[格子]=玩家数据[id].角色.灵宝佩戴[编号]
	玩家数据[id].角色.灵宝佩戴[编号]=nil
	self:索要法宝(连接id,id)
end

function 道具处理类:修炼灵宝(连接id,id,编号)
	local 道具id=玩家数据[id].角色.灵宝[编号]
	if 道具id==nil or self.数据[道具id]==nil then
		常规提示(id,"#Y你没有这件灵宝")
		self:索要法宝(连接id,id)
		return
	end
	local 上限=5
	if self.数据[道具id].气血==上限 then
		常规提示(id,"#Y你的这件灵宝已经满层了，无法再进行修炼")
		return
	end
	local 消耗经验=math.floor(self.数据[道具id].升级经验*0.5)
	if 消耗经验>10000000 then
		消耗经验=10000000
	end
	if 玩家数据[id].角色.当前经验<消耗经验 then
		常规提示(id,"#Y本次修炼需要消耗#R"..消耗经验.."#Y点人物经验，您似乎没有那么多的经验哟")
		return
	end
	玩家数据[id].角色.当前经验=玩家数据[id].角色.当前经验-消耗经验
	常规提示(id,"#Y修炼成功,你消耗了#R"..消耗经验.."#Y了点人物经验")
	self.数据[道具id].当前经验=self.数据[道具id].当前经验+消耗经验
	if self.数据[道具id].当前经验>=self.数据[道具id].升级经验 then
		self.数据[道具id].气血=self.数据[道具id].气血+1
		self.数据[道具id].当前经验=self.数据[道具id].当前经验-self.数据[道具id].升级经验
		self.数据[道具id].魔法=取灵气上限(self.数据[道具id].分类)
		if self.数据[道具id].气血<上限 then
			self.数据[道具id].升级经验=灵宝经验[self.数据[道具id].分类][self.数据[道具id].气血+1]
		end
		常规提示(id,"#Y你的灵宝#R"..self.数据[道具id].名称.."#Y境界提升了")
	end
	发送数据(连接id,226,{当前经验=玩家数据[id].角色.当前经验,最大经验=玩家数据[id].角色.最大经验})
	发送数据(连接id,3528,{id=编号,当前经验=self.数据[道具id].当前经验,升级经验=self.数据[道具id].升级经验,境界=self.数据[道具id].气血,灵气=self.数据[道具id].魔法})
end

function 道具处理类:快捷加血(连接id,id,类型)
	if 玩家数据[id].zhandou~=0 then return  end
	local 数值=0
	local 编号=0
	if 类型==1 then
		数值=玩家数据[id].角色.最大气血-玩家数据[id].角色.气血
	else
		编号=玩家数据[id].召唤兽:取编号(玩家数据[id].角色.参战宝宝.认证码)
		数值=玩家数据[id].召唤兽.数据[编号].最大气血-玩家数据[id].召唤兽.数据[编号].气血
	end
	if 数值==0 then
		return
	end
	local 恢复=self:快捷加血1(id,数值)
	if 恢复==0 then
		return
	end
	self:加血处理(连接id,id,恢复,编号)
	道具刷新(id)
end

function 道具处理类:快捷加血1(id,数值)
	local 道具={"包子","四叶花","八角莲叶","人参"}
	local 恢复=0
	local 道具删除={}
	for n=1,20 do
		if 玩家数据[id].角色.道具[n]~=nil then
			local 道具id=玩家数据[id].角色.道具[n]
			local 符合=false
			for i=1,#道具 do
				if self.数据[道具id].名称==道具[i] then
					符合=true
				end
			end
			if 符合 then
				if 恢复<数值 and self:取加血道具1(self.数据[道具id].名称,道具id)*self.数据[道具id].数量>=数值 then --
					local 扣除数量=0
					for i=1,self.数据[道具id].数量 do
						if 恢复<数值 then
							恢复=恢复+self:取加血道具1(self.数据[道具id].名称,道具id)
							扣除数量=扣除数量+1
						end
					end
					道具删除[#道具删除+1]={格子=n,id=道具id,数量=扣除数量}
				elseif 恢复<数值 then
					恢复= self:取加血道具1(self.数据[道具id].名称,道具id)*self.数据[道具id].数量
					道具删除[#道具删除+1]={格子=n,id=道具id,数量=self.数据[道具id].数量}
				end
			end
		end
	end
	if 恢复~=0 then
		for n=1,#道具删除 do
			self.数据[道具删除[n].id].数量=self.数据[道具删除[n].id].数量-道具删除[n].数量
			if self.数据[道具删除[n].id].数量<=0 then
				玩家数据[id].角色.道具[道具删除[n].格子]=nil
			end
		end
	end
	if 恢复>数值 then 恢复=数值 end
	return 恢复
end

function 道具处理类:快捷加蓝(连接id,id,类型)
	if 玩家数据[id].zhandou~=0 then return  end
	local 数值=0
	local 编号=0
	if 类型==1 then
		数值=玩家数据[id].角色.最大魔法-玩家数据[id].角色.魔法
	else
		编号=玩家数据[id].召唤兽:取编号(玩家数据[id].角色.参战宝宝.认证码)
		数值=玩家数据[id].召唤兽.数据[编号].最大魔法-玩家数据[id].召唤兽.数据[编号].魔法
	end
	if 数值==0 then
		return
	end
	local 恢复=self:快捷加蓝1(id,数值)
	if 恢复==0 then
		return
	end
	self:加魔处理(连接id,id,恢复,编号)
	道具刷新(id)
end

function 道具处理类:快捷加蓝1(id,数值)
 local 道具={"鬼切草","佛手","紫丹罗"}
 local 恢复=0
 local 道具删除={}
	for n=1,20 do
		if 玩家数据[id].角色.道具[n]~=nil then
			local 道具id=玩家数据[id].角色.道具[n]
			local 符合=false
			for i=1,#道具 do
				if self.数据[道具id].名称==道具[i] then
					符合=true
				end
			end
			if 符合 then
				if 恢复<数值 and self:取加魔道具1(self.数据[道具id].名称,道具id)*self.数据[道具id].数量>=数值 then --
					local 扣除数量=0
					for i=1,self.数据[道具id].数量 do
						if 恢复<数值 then
							恢复=恢复+self:取加魔道具1(self.数据[道具id].名称,道具id)
							扣除数量=扣除数量+1
						end
					end
					道具删除[#道具删除+1]={格子=n,id=道具id,数量=扣除数量}
				elseif 恢复<数值 then
					恢复= self:取加魔道具1(self.数据[道具id].名称,道具id)*self.数据[道具id].数量
					道具删除[#道具删除+1]={格子=n,id=道具id,数量=self.数据[道具id].数量}
				end
			end
		end
	end
	if 恢复~=0 then
		for n=1,#道具删除 do
			self.数据[道具删除[n].id].数量=self.数据[道具删除[n].id].数量-道具删除[n].数量
			if self.数据[道具删除[n].id].数量<=0 then
				玩家数据[id].角色.道具[道具删除[n].格子]=nil
			end
		end
	end
	if 恢复>数值 then 恢复=数值 end
	return 恢复
end

function 道具处理类:摊位上架商品(连接id,id,数据)
  if 玩家数据[id].摊位数据==nil then return end
  if 数据.价格=="" or 数据.价格==nil or 数据.价格+0<=0 then
	数据.价格=1
  end
  local 价格=数据.价格+0
  if 数据.bb==nil and 数据.制造 == nil then --上架道具
	local 编号=玩家数据[id].角色.道具[数据.道具+0]
	if self.数据[编号].不可交易 or self.数据[编号].专用  then
	  常规提示(id,"#Y/该物品不可转移给他人")
	  return
	end
	玩家数据[id].摊位数据.道具[数据.道具+0]=table.loadstring(table.tostring(self.数据[编号]))
	玩家数据[id].摊位数据.道具[数据.道具+0].价格=价格
	常规提示(id,"#Y/上架物品成功！")
  elseif 数据.bb and 数据.道具==nil and 数据.制造 == nil then
	local 编号=数据.bb+0
	if 玩家数据[id].召唤兽.数据[编号].不可交易 or 玩家数据[id].召唤兽.数据[编号].专用 then
	  常规提示(id,"#Y/该召唤兽不可转移给他人")
	  return
	elseif 玩家数据[id].召唤兽.数据[编号].统御 ~= nil then
	  常规提示(id,"#Y/已被坐骑统御的召唤兽无法转移给他人")
	  return
	elseif 玩家数据[id].角色.参战信息~=nil and 玩家数据[id].角色.参战宝宝 then
		if 玩家数据[id].角色.参战宝宝.认证码==玩家数据[id].召唤兽.数据[编号].认证码 then
			常规提示(id,"#Y/参战中的召唤兽无法转移给他人")
			return
		end
	end
	玩家数据[id].摊位数据.bb[编号]=table.loadstring(table.tostring(玩家数据[id].召唤兽.数据[编号]))
	玩家数据[id].摊位数据.bb[编号].价格=价格
	玩家数据[id].摊位数据.bb[编号].id=编号
	常规提示(id,"#Y/上架召唤兽成功！")
  elseif 数据.bb==nil and 数据.道具 == nil then
	  local 编号1=数据.制造[1]
	  local 编号2=数据.制造[2]
	  for k, v in pairs(玩家数据[id].摊位数据.制造) do
		if v~=nil and k==编号1 and v[编号2]~=nil then
		  常规提示(id,"#Y/该制造技能等级已经上架了")
		  return
		end
	  end
	  if 玩家数据[id].摊位数据.制造[编号1]==nil then
		玩家数据[id].摊位数据.制造[编号1]={}
	  end
	  玩家数据[id].摊位数据.制造[编号1][编号2]={价格=价格,序号=tonumber(编号1..编号2)}
	  玩家数据[id].摊位数据.制造.制造组=数据.制造组
	  常规提示(id,"#Y/上架成功！")
  end
  玩家数据[id].摊位数据.更新=os.time()
  self:索要摊位数据(连接id,id,3517)
end

function 道具处理类:摊位下架商品(连接id,id,数据)

	if 玩家数据[id].摊位数据==nil then return end
	if 数据.道具~=nil then --下架道具
		玩家数据[id].摊位数据.道具[数据.道具+0]=nil
		常规提示(id,"#Y/下架物品成功！")
	elseif 数据.bb~=nil then
		local 编号=数据.bb+0
		玩家数据[id].摊位数据.bb[编号]=nil
		常规提示(id,"#Y/下架召唤兽成功！")
	end
	玩家数据[id].摊位数据.更新=os.time()
	self:索要摊位数据(连接id,id,3517)
end

function 道具处理类:收摊处理(连接id,id)
	玩家数据[id].摊位数据=nil
	玩家数据[id].离线摆摊=nil
	常规提示(id,"#Y/收摊回家咯！")
	发送数据(连接id,3518)
	地图处理类:取消玩家摊位(id)
end

function 道具处理类:更改摊位招牌(连接id,id,名称)
	if 玩家数据[id].摊位数据==nil then return end
	if os.time()-玩家数据[id].摊位数据.更新<=5 then
		常规提示(id,"#Y/请不要频繁更换招牌")
		return
	end
	常规提示(id,"#Y/更新招牌成功")
	玩家数据[id].摊位数据.更新=os.time()
	玩家数据[id].摊位数据.名称=名称
	发送数据(连接id,3516,名称)
	地图处理类:设置玩家摊位(id,名称)
end

function 道具处理类:购买摊位商品(连接id,id,数据)
	local 对方id=玩家数据[id].摊位id
	if 对方id==nil or 玩家数据[对方id]==nil or 玩家数据[对方id].摊位数据==nil then
		常规提示(id,"#Y/这个摊位并不存在")
		return
	end
	if 玩家数据[id].摊位查看<玩家数据[对方id].摊位数据.更新 then
		常规提示(id,"#Y/这个摊位的数据已经发生了变化，请重新打开该摊位")
		return
	end
	if 玩家数据[对方id].角色:检测交易是否正常(对方id) or 玩家数据[id].角色:检测交易是否正常(id) then
		return
	end
	--数据转移
	local 名称=玩家数据[对方id].角色.名称
	local 名称1=玩家数据[id].角色.名称
	local 账号=玩家数据[对方id].账号
	local 账号1=玩家数据[id].账号
	if 数据.道具~=nil then --购买道具
		local 购买数量 = 数据.数量+0
		if 玩家数据[对方id].摊位数据.道具[数据.道具]==nil then
			常规提示(id,"#Y/这个商品并不存在")
			return
		end
		if 购买数量<1 or 购买数量>99 then
			常规提示(id,"#R数据异常！")
			local 封禁原因=玩家数据[id].角色.ip.."“违规行为：购买摊位商品”数量=="..购买数量.."，玩家ID=="..id.."，玩家账号=="..玩家数据[id].账号.."时间="..os.date("%Y%m%d")..os.date("%H",os.time())..os.date("%S",os.time())
			f函数.写配置(程序目录..[[data\]]..玩家数据[id].账号..[[\账号信息.txt]],"账号配置","已违规9",封禁原因)
			f函数.写配置(程序目录..[[各类情况查看\]]..[[\违规汇总.txt]],"违规详情","已违规9:",封禁原因)
			return
		end
		购买数量=math.floor(购买数量)
		local 剩余数量=玩家数据[对方id].摊位数据.道具[数据.道具].数量 or 1
		if 购买数量>剩余数量 then
			购买数量=math.floor(剩余数量)
		end
		local 价格=玩家数据[对方id].摊位数据.道具[数据.道具].价格*购买数量
		价格=math.floor(价格)
		if 玩家数据[id].角色.银子<价格 then
			常规提示(id,"#Y/你没有那么多的银子")
			return
		elseif 价格<0 then
			常规提示(id,"#R数据异常！")
			local 封禁原因=玩家数据[id].角色.ip.."“违规行为：购买摊位商品”价格=="..价格.."，玩家ID=="..id.."，玩家账号=="..玩家数据[id].账号.."时间="..os.date("%Y%m%d")..os.date("%H",os.time())..os.date("%S",os.time())
			f函数.写配置(程序目录..[[data\]]..玩家数据[id].账号..[[\账号信息.txt]],"账号配置","已违规10",封禁原因)
			f函数.写配置(程序目录..[[各类情况查看\]]..[[\违规汇总.txt]],"违规详情","已违规10:",封禁原因)
			return
		end
		local 临时格子=玩家数据[id].角色:取道具格子()
		if 临时格子==0 then
			常规提示(id,"#Y/请先整理下包裹吧！")
			return
		end
		local jiuid=玩家数据[对方id].角色.道具[数据.道具]
		if (jiuid==nil or 玩家数据[对方id].道具.数据[jiuid]==nil) and not 玩家数据[对方id].角色.假人 then
			print("摊位购买道具为空！")
			return
		end

		local 新道具=self:取新编号()
		local 道具名称=玩家数据[对方id].摊位数据.道具[数据.道具].名称
		local 道具识别码=玩家数据[对方id].摊位数据.道具[数据.道具].识别码
		if 玩家数据[对方id].道具:检查道具是否存在(对方id,道具识别码,购买数量)==false and not 玩家数据[对方id].角色.假人 then
			return
		end
		玩家数据[id].角色:扣除银子(价格,0,0,"摊位购买",1)
		玩家数据[id].角色:日志记录(format("[摊位系统-购买]购买道具[%s][%s]，花费%s两银子,出售者信息：[%s][%s][%s]",道具名称,道具识别码,价格,账号,对方id,名称))
		玩家数据[对方id].角色:日志记录(format("[摊位系统-出售]出售道具[%s][%s]，花费%s两银子,购买者信息：[%s][%s][%s]",道具名称,道具识别码,价格,账号1,id,名称1))
		常规提示(对方id,"#W/出售#R/"..道具名称.."#W/成功！")
		常规提示(id,"#W/购买#R/"..道具名称.."#W/成功！")
		self.数据[新道具]=table.loadstring(table.tostring(玩家数据[对方id].摊位数据.道具[数据.道具]))
	  if not 玩家数据[对方id].角色.假人 then
			if  not 玩家数据[对方id].摊位数据.道具[数据.道具].可叠加 or 玩家数据[对方id].摊位数据.道具[数据.道具].数量 == nil then
				玩家数据[对方id].道具.数据[jiuid]=nil
				玩家数据[对方id].角色.道具[数据.道具]=nil
				玩家数据[对方id].摊位数据.道具[数据.道具]=nil
			else
				self.数据[新道具].数量=购买数量
				玩家数据[对方id].摊位数据.道具[数据.道具].数量=玩家数据[对方id].摊位数据.道具[数据.道具].数量-购买数量
				if 玩家数据[对方id].摊位数据.道具[数据.道具].数量<=0 then
					玩家数据[对方id].道具.数据[jiuid]=nil --这里等会儿着重整改
					玩家数据[对方id].角色.道具[数据.道具]=nil
					玩家数据[对方id].摊位数据.道具[数据.道具]=nil
				else
					玩家数据[对方id].道具.数据[jiuid].数量=玩家数据[对方id].道具.数据[jiuid].数量-购买数量
				end
			end
		else
			if  not 玩家数据[对方id].摊位数据.道具[数据.道具].可叠加 or 玩家数据[对方id].摊位数据.道具[数据.道具].数量 == nil then
				玩家数据[对方id].摊位数据.道具[数据.道具]=nil
			else
				self.数据[新道具].数量=购买数量
				玩家数据[对方id].摊位数据.道具[数据.道具].数量=玩家数据[对方id].摊位数据.道具[数据.道具].数量-购买数量
				if 玩家数据[对方id].摊位数据.道具[数据.道具].数量<=0 then
					玩家数据[对方id].摊位数据.道具[数据.道具]=nil
				end
			end
	  end
		玩家数据[id].角色.道具[临时格子]=新道具
		玩家数据[对方id].角色:添加银子(价格,"摊位出售",1)
		道具刷新(id)
		道具刷新(对方id)

	elseif 数据.bb~=nil then
		if 玩家数据[对方id].摊位数据.bb[数据.bb]==nil then
			常规提示(id,"#Y/这只召唤兽不存在")
			return
		elseif  not 玩家数据[id].角色:取新增宝宝数量()then
			常规提示(id,"#Y/你当前可携带的召唤兽数量已达上限！")
			return
		end
		local 价格=玩家数据[对方id].摊位数据.bb[数据.bb].价格
		价格=math.floor(价格)
		if 玩家数据[id].角色.银子<价格 then
			常规提示(id,"#Y/你没有那么多的银子")
			return
		end
		local 道具名称=玩家数据[对方id].摊位数据.bb[数据.bb].名称
		local 道具等级=玩家数据[对方id].摊位数据.bb[数据.bb].等级
		local 道具模型=玩家数据[对方id].摊位数据.bb[数据.bb].模型
		local 道具技能=#玩家数据[对方id].摊位数据.bb[数据.bb].技能
		local 道具识别码=玩家数据[对方id].摊位数据.bb[数据.bb].认证码
		local 临时宝宝 = table.loadstring(table.tostring(玩家数据[对方id].摊位数据.bb[数据.bb]))

		玩家数据[对方id].摊位数据.bb[数据.bb]=nil
		玩家数据[id].角色:扣除银子(价格,0,0,"摊位购买",1)
		玩家数据[对方id].角色:添加银子(价格,"摊位出售",1)
		玩家数据[id].角色:日志记录(format("[摊位系统-购买]购买召唤兽[%s][%s][%s][%s][%s]，花费%s两银子,出售者信息：[%s][%s][%s]",道具名称,道具模型,道具等级,道具技能,道具识别码,价格,账号,对方id,名称))
		玩家数据[对方id].角色:日志记录(format("[摊位系统-出售]出售召唤兽[%s][%s][%s][%s][%s]，花费%s两银子,购买者信息：[%s][%s][%s]",道具名称,道具模型,道具等级,道具技能,道具识别码,价格,账号1,id,名称1))
		常规提示(对方id,"#W/出售#R/"..道具名称.."#W/成功！")
		常规提示(id,"#W/购买#R/"..道具名称.."#W/成功！")
		local 宝宝=宝宝类.创建()
		宝宝:加载数据(临时宝宝)
		玩家数据[id].召唤兽.数据[#玩家数据[id].召唤兽.数据+1]=宝宝
		玩家数据[id].召唤兽.数据[#玩家数据[id].召唤兽.数据].认证码 = id.."_"..os.time().."_"..取随机数(111111111111,999999999999)


		local 现有数据 = {}
		local 临时摆摊数据 = {}
		for n = 1, 7 do
			if 玩家数据[对方id].召唤兽.数据[n] ~= nil and 玩家数据[对方id].召唤兽.数据[n] ~= 0 and 玩家数据[对方id].召唤兽.数据[n].认证码 ~= 道具识别码 then
				现有数据[#现有数据 + 1] = {
				bb = 玩家数据[对方id].召唤兽.数据[n],
				编号 = n --原本位置
				}
			end
		end
		玩家数据[对方id].召唤兽.数据 = {}
			for n = 1, #现有数据 do
		玩家数据[对方id].召唤兽.数据[n] = 现有数据[n].bb
		for i = 1, 7 do
			if 玩家数据[对方id].摊位数据.bb[i] ~= nil and 玩家数据[对方id].摊位数据.bb[i].id == 现有数据[n].编号 then
					临时摆摊数据[n] = {
					id = n,
					bb = 玩家数据[对方id].摊位数据.bb[i],
					价格 = 玩家数据[对方id].摊位数据.bb[i].价格
					}
				end
			end
		end


	if  not 玩家数据[对方id].角色.假人 then----------去掉的话 假人摊位上购买一只BB会全部消失
			玩家数据[对方id].摊位数据.bb = {}
			for n = 1, 7 do
				if 临时摆摊数据[n] ~= nil then
					玩家数据[对方id].摊位数据.bb[n] = 临时摆摊数据[n].bb
					玩家数据[对方id].摊位数据.bb[n].价格 = 临时摆摊数据[n].价格
					玩家数据[对方id].摊位数据.bb[n].id = 临时摆摊数据[n].id
				end
			end
	end
		if 玩家数据[id].召唤兽.数据[#玩家数据[id].召唤兽.数据].参战信息~=nil then
			玩家数据[id].召唤兽.数据[#玩家数据[id].召唤兽.数据].参战信息=nil
			玩家数据[对方id].角色.参战信息=nil
			玩家数据[对方id].角色.参战宝宝={}
			发送数据(玩家数据[对方id].连接id,18,玩家数据[对方id].角色.参战宝宝)
		end
		发送数据(玩家数据[id].连接id,3512,玩家数据[id].召唤兽.数据)
		发送数据(玩家数据[对方id].连接id,3512,玩家数据[对方id].召唤兽.数据)
	end

	玩家数据[对方id].角色:存档()
	玩家数据[id].角色:存档()

	玩家数据[对方id].摊位数据.更新=os.time()
	玩家数据[id].摊位查看=os.time()
	self:索要其他玩家摊位(连接id,id,对方id,3522)
	self:索要摊位数据(玩家数据[对方id].连接id,对方id,3517)
end

function 道具处理类:购买摊位制造商品(连接id,id,数据)
	local 对方id=玩家数据[id].摊位id
	if 玩家数据[id].摊位数据~=nil then
		常规提示(id,"#Y/摆摊中无法此操作。")
		return
	end
	if 对方id==nil or 玩家数据[对方id]==nil or 玩家数据[对方id].摊位数据==nil then
		常规提示(id,"#Y/这个摊位并不存在")
		return
	end
	if 玩家数据[id].摊位查看<玩家数据[对方id].摊位数据.更新 then
		常规提示(id,"#Y/摊主正忙，请稍等片刻，或重新打开")
		return
	end
	local 价格 = 0
	local 查找标识 = false
	for k,v in pairs(玩家数据[对方id].摊位数据.制造) do
		for i,v in pairs(v) do
			if 查找标识 then  --双for循环跳出用
				break
			end
			if v.序号 == 数据.选中序号 then
				价格 = v.价格
				查找标识 = true
				break
			end
		end
	end
	if 价格 < 1  then
		常规提示(id,"#Y/数据异常！")
		return
	end
	价格=math.floor(价格)
	if 数据.制造类别 == "其他类" then
		if 玩家数据[id].角色.银子<价格 then
			常规提示(id,"#Y/你没有那么多的银子")
			return
		end
		if 数据.技能名称 == "嗜血" or 数据.技能名称 == "轻如鸿毛" or 数据.技能名称 == "拈花妙指" or 数据.技能名称 == "穿云破空"
			or 数据.技能名称 == "盘丝舞" or 数据.技能名称 == "一气化三清" or 数据.技能名称 == "浩然正气" or 数据.技能名称 == "龙附"
			or 数据.技能名称 == "神兵护法" or 数据.技能名称 == "魔王护持" or 数据.技能名称 == "莲华妙法" or 数据.技能名称 == "神力无穷"
			or 数据.技能名称 == "尸气漫天" or 数据.技能名称 == "元阳护体" or 数据.技能名称 == "担山赶月" or 数据.技能名称 == "神木呓语" then

			local 等级 = 玩家数据[对方id].角色:取师门技能等级(数据.技能名称)
			if 玩家数据[对方id].角色:扣除活力(等级) then
				玩家数据[对方id].角色:摊位符制造(数据.技能名称,id)
			else
				常规提示(id, "#Y/摊主的活力不足无法制造!")
				return
			end
			玩家数据[id].角色:扣除银子(价格,0,0,"购买强化符",1)
			玩家数据[对方id].角色:添加银子(价格,"玩家购买强化符",1)
			玩家数据[对方id].角色.活力 = 玩家数据[对方id].角色.活力 - qz(数据.等级)
			体活刷新(对方id)
		end
	else
		if 数据.技能名称 == "打造" or 数据.技能名称 == "裁缝" or 数据.技能名称 == "炼金" then
			玩家数据[id].给予数据 = {事件="购买玩家打造",制造数据={名称=数据.技能名称,等级=数据.等级,价格=数据.价格,是否强化=数据.打造模式},对方id=对方id,类型=1}
			发送数据(玩家数据[id].连接id,3507,{道具=玩家数据[id].道具:索要道具1(id),名称="打铁炉",类型="NPC",等级=数据.等级})
		end
	end
end

function 道具处理类:索要其他玩家摊位(连接id,id,对方id,序号)
	if 玩家数据[对方id]==nil or 玩家数据[对方id].摊位数据==nil then
		常规提示(id,"#Y/这个摊位并不存在")
		return
	end
	玩家数据[id].摊位查看=os.time()
	玩家数据[id].摊位id=对方id
	-- 发送数据(玩家数据[id].连接id,3520,{银子=玩家数据[id].角色.银子, 仙玉=玩家数据[id].角色.仙玉})
	发送数据(玩家数据[id].连接id,3520,{银子=玩家数据[id].角色.银子, 仙玉=f函数.读配置(程序目录..[[data\]]..玩家数据[id].账号..[[\账号信息.txt]], "账号配置", "仙玉") + 0})
	发送数据(玩家数据[id].连接id,序号,{bb=玩家数据[对方id].摊位数据.bb,物品=玩家数据[对方id].摊位数据.道具,制造=玩家数据[对方id].摊位数据.制造,id=对方id,摊主名称=玩家数据[对方id].角色.名称,名称=玩家数据[对方id].摊位数据.名称})
end

function 道具处理类:索要摊位数据(连接id,id,序号)
	if 玩家数据[id].摊位数据==nil then --新建摊位
		if 玩家数据[id].队伍~=0 then
			常规提示(id,"#Y/组队状态下无法摆摊")
			return
		elseif 玩家数据[id].角色.飞行中 then
			常规提示(id,"#Y/飞行状态下无法摆摊")
			return
		else
			local 地图=玩家数据[id].角色.地图数据.编号
			if 地图~=1001 and 地图~=1501 and 地图~=1070 and 地图~=1092 and 地图~=1208 and 地图~=1226 and 地图~=1040 then
				常规提示(id,"#Y/该场景无法摆摊")
				return
			elseif 玩家数据[id].角色.等级<30 and 连接id ~="假人"then
				常规提示(id,"#Y/只有等级达到30级的玩家才可使用摆摊功能")
				return
			end
		end
		-----------武神坛
  	if 玩家数据[id].角色.武神坛角色 then
  		常规提示(id,"#Y/武神坛内禁止使用摆摊功能")
  		return
  	end
		-----------
		玩家数据[id].摊位数据={道具={},bb={},制造={},id=id,名称="杂货摊位",摊主=玩家数据[id].角色.名称,更新=os.time()}
		地图处理类:设置玩家摊位(id,"杂货摊位")
	end
	发送数据(玩家数据[id].连接id,3512,玩家数据[id].召唤兽.数据)
	发送数据(玩家数据[id].连接id,3513,玩家数据[id].道具:索要道具2(id))

	local bb={}
	for k, v in pairs(玩家数据[id].摊位数据.bb) do
		if v~=nil then
			bb[k]={v.价格,v.认证码,v.模型,v.名称}
		end
	end
	local 道具={}
	for n=1,20 do
		if 玩家数据[id].摊位数据.道具[n]~=nil then
			道具[n]=玩家数据[id].摊位数据.道具[n]
		end
	end
	发送数据(连接id,序号,{bb=bb,物品=道具,制造=玩家数据[id].摊位数据.制造,id=id,摊主名称=玩家数据[id].角色.名称,名称=玩家数据[id].摊位数据.名称})
end

function 道具处理类:取消交易(id)
	if 玩家数据[id].交易信息~=nil then
		if 玩家数据[玩家数据[id].交易信息.id]~=nil then
			发送数据(玩家数据[玩家数据[id].交易信息.id].连接id,3511)
			常规提示(玩家数据[id].交易信息.id,"#Y/对方取消了交易")
			玩家数据[玩家数据[id].交易信息.id].交易信息=nil
		end
		交易数据[玩家数据[id].交易信息.编号]=nil
		玩家数据[id].交易信息=nil
	end
end

function 道具处理类:取指定道具(编号)
	return table.loadstring(table.tostring(self.数据[编号]))
end

function 道具处理类:检查道具是否存在(id,识别码,数量)
	for n=1,20 do
		if 玩家数据[id].角色.道具[n]~=nil and self.数据[玩家数据[id].角色.道具[n]]~=nil and self.数据[玩家数据[id].角色.道具[n]].识别码==识别码 then
			if self.数据[玩家数据[id].角色.道具[n]].数量~=nil then
				if self.数据[玩家数据[id].角色.道具[n]].数量>=数量 then
					return true
				end
			else
				return true
			end
		end
	end
	return false
end

function 道具处理类:发起交易处理(连接id,id,id1)
	if 玩家数据[id1]==nil then
		常规提示(id,"#Y/对方并不在线")
		return
	elseif 地图处理类:比较距离(id,id1,500)==false then
		常规提示(id,"#Y/你们的距离太远了")
		return
	elseif 玩家数据[id1].交易信息~=nil or 玩家数据[id1].摊位数据~=nil then
		常规提示(id,"#Y/对方正忙，请稍后再试")
		return
	elseif 玩家数据[id].交易信息~=nil then
		常规提示(id,"#Y/你上次的交易还没有结束哟~")
		return
	elseif 玩家数据[id1].禁止交易 then
		常规提示(id,"#Y/对方没有打开交易开关")
		return
	elseif 玩家数据[id1].角色:检测交易是否正常(id1) or 玩家数据[id].角色:检测交易是否正常(id) then
		return
	-----------武神坛
  else
  	if 玩家数据[id].角色.武神坛角色 then
  		常规提示(id,"#Y/武神坛角色不可交易")
		  return
  	end
  	if 玩家数据[id1].角色.武神坛角色 then
  		常规提示(id1,"#Y/武神坛角色不可交易")
		  return
  	end
	-----------
	end
	交易数据[id]={[id]={},[id1]={}}
	常规提示(id,"你正在和"..玩家数据[id1].角色.名称.."进行交易")
	常规提示(id1,"你正在和"..玩家数据[id].角色.名称.."进行交易")
	发送数据(玩家数据[id].连接id,3512,玩家数据[id].召唤兽.数据)
	发送数据(玩家数据[id1].连接id,3512,玩家数据[id1].召唤兽.数据)
	发送数据(玩家数据[id].连接id,3513,玩家数据[id].道具:索要道具2(id))
	发送数据(玩家数据[id1].连接id,3513,玩家数据[id1].道具:索要道具2(id1))
	发送数据(玩家数据[id].连接id,3514,{名称=玩家数据[id1].角色.名称,等级=玩家数据[id1].角色.等级})
	发送数据(玩家数据[id1].连接id,3514,{名称=玩家数据[id].角色.名称,等级=玩家数据[id].角色.等级})
	玩家数据[id1].交易信息={编号=id,id=id}
	玩家数据[id].交易信息={编号=id,id=id1}
end

function 道具处理类:完成交易处理(交易id,id,id1)
	if 玩家数据[id1].角色:检测交易是否正常(id1) or 玩家数据[id].角色:检测交易是否正常(id) then
		return
	end
	if 玩家数据[id].zhandou~=0 or 玩家数据[id1].zhandou~=0 then
		常规提示(id,"#Y/战斗中无法使用此功能")
		常规提示(id1,"#Y/战斗中无法使用此功能")
		发送数据(玩家数据[id].连接id,3511)
		发送数据(玩家数据[id1].连接id,3511)
		玩家数据[id1].交易信息=nil
		玩家数据[id].交易信息=nil
		交易数据[交易id]=nil
		return
	elseif 玩家数据[id1].摊位数据~=nil or 玩家数据[id].摊位数据~=nil then
		常规提示(id,"#Y/摆摊状态下无法使用此功能")
		常规提示(id1,"#Y/摆摊状态下无法使用此功能")
		发送数据(玩家数据[id].连接id,3511)
		发送数据(玩家数据[id1].连接id,3511)
		玩家数据[id1].交易信息=nil
		玩家数据[id].交易信息=nil
		交易数据[交易id]=nil
		return
	elseif 地图处理类:比较距离(id,id1,500)==false then
		常规提示(id,"#Y/你们的距离太远了")
		常规提示(id1,"#Y/你们的距离太远了")
		发送数据(玩家数据[id].连接id,3511)
		发送数据(玩家数据[id1].连接id,3511)
		玩家数据[id1].交易信息=nil
		玩家数据[id].交易信息=nil
		交易数据[交易id]=nil
		return
	end
	local 银子=交易数据[交易id][id].银子+0
	local 银子1=交易数据[交易id][id1].银子+0
	if 玩家数据[id].角色.银子<银子 then
		常规提示(id,"#Y/你没有那么多的银子")
		常规提示(id1,"#Y/对方没有那么多的银子")
		发送数据(玩家数据[id].连接id,3511)
		发送数据(玩家数据[id1].连接id,3511)
		玩家数据[id1].交易信息=nil
		玩家数据[id].交易信息=nil
		交易数据[交易id]=nil
		return
	elseif 玩家数据[id1].角色.银子<银子1 then
		常规提示(id1,"#Y/你没有那么多的银子")
		常规提示(id,"#Y/对方没有那么多的银子")
		发送数据(玩家数据[id].连接id,3511)
		发送数据(玩家数据[id1].连接id,3511)
		交易数据[交易id]=nil
		玩家数据[id1].交易信息=nil
		玩家数据[id].交易信息=nil
		return
	end
	--检查道具是否存在
	local 操作id=id
	local 对象id=id1
	for n=1,#交易数据[交易id][操作id].道具 do
		local 道具id=交易数据[交易id][操作id].道具[n].编号
		local 道具id1=玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]
		if 道具id~=道具id1 or 玩家数据[操作id].道具.数据[道具id]==nil or 玩家数据[操作id].道具.数据[道具id1]==nil or 玩家数据[操作id].道具.数据[道具id1].识别码~=交易数据[交易id][操作id].道具[n].认证码 then
			常规提示(操作id,"#Y/你此次交易的道具数据与锁定前的数据不匹配，本次交易取消")
			常规提示(对象id,"#Y/对方此次交易的道具数据与锁定前的数据不匹配，本次交易取消")
			发送数据(玩家数据[操作id].连接id,3511)
			发送数据(玩家数据[对象id].连接id,3511)
			玩家数据[id1].交易信息=nil
			玩家数据[id].交易信息=nil
			交易数据[交易id]=nil
			return
		elseif 玩家数据[操作id].道具.数据[道具id1].不可交易 or 玩家数据[操作id].道具.数据[道具id1].专用 then
			常规提示(操作id,"#Y/该道具不可交易给他人，本次交易取消")
			常规提示(对象id,"#Y/对方此次交易存在无法交易的道具，本次交易取消")
			发送数据(玩家数据[操作id].连接id,3511)
			发送数据(玩家数据[对象id].连接id,3511)
			玩家数据[id1].交易信息=nil
			玩家数据[id].交易信息=nil
			交易数据[交易id]=nil
			return
		end
	end
	local 操作id=id1
	local 对象id=id
	for n=1,#交易数据[交易id][操作id].道具 do
		local 道具id=交易数据[交易id][操作id].道具[n].编号
		local 道具id1=玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]
		if 道具id~=道具id1 or 玩家数据[操作id].道具.数据[道具id]==nil or 玩家数据[操作id].道具.数据[道具id1]==nil or 玩家数据[操作id].道具.数据[道具id1].识别码~=交易数据[交易id][操作id].道具[n].认证码 then
			常规提示(操作id,"#Y/你此次交易的道具数据与锁定前的数据不匹配，本次交易取消")
			常规提示(对象id,"#Y/对方此次交易的道具数据与锁定前的数据不匹配，本次交易取消")
			发送数据(玩家数据[操作id].连接id,3511)
			发送数据(玩家数据[对象id].连接id,3511)
			玩家数据[id1].交易信息=nil
			玩家数据[id].交易信息=nil
			交易数据[交易id]=nil
			return
		elseif 玩家数据[操作id].道具.数据[道具id1].不可交易 or 玩家数据[操作id].道具.数据[道具id1].专用 then
			常规提示(操作id,"#Y/该道具不可交易给他人，本次交易取消")
			常规提示(对象id,"#Y/对方此次交易存在无法交易的道具，本次交易取消")
			发送数据(玩家数据[操作id].连接id,3511)
			发送数据(玩家数据[对象id].连接id,3511)
			玩家数据[id1].交易信息=nil
			玩家数据[id].交易信息=nil
			交易数据[交易id]=nil
			return
		end
	end
	local 操作id=id
	local 对象id=id1
	for n=1,#交易数据[交易id][操作id].bb do
		local bb编号= 交易数据[交易id][操作id].bb[n].编号
		local 认证码=玩家数据[操作id].召唤兽.数据[bb编号].认证码
		if 认证码~=交易数据[交易id][操作id].bb[n].认证码 then
			常规提示(操作id,"#Y/你此次交易的召唤兽数据与锁定前的数据不匹配，本次交易取消")
			常规提示(对象id,"#Y/对方此次交易的召唤兽数据与锁定前的数据不匹配，本次交易取消")
			发送数据(玩家数据[操作id].连接id,3511)
			发送数据(玩家数据[对象id].连接id,3511)
			玩家数据[id1].交易信息=nil
			玩家数据[id].交易信息=nil
			交易数据[交易id]=nil
			return
		elseif 玩家数据[操作id].召唤兽.数据[bb编号].不可交易 or 玩家数据[操作id].召唤兽.数据[bb编号].专用 then
			常规提示(操作id,"#Y/该召唤兽不可交易给他人，本次交易取消")
			常规提示(对象id,"#Y/对方此次交易存在无法交易的召唤兽，本次交易取消")
			发送数据(玩家数据[操作id].连接id,3511)
			发送数据(玩家数据[对象id].连接id,3511)
			交易数据[交易id]=nil
			return
		elseif 玩家数据[操作id].角色.参战信息~=nil then
			常规提示(操作id,"#Y/请先取消所有召唤兽参战状态，本次交易取消")
			常规提示(对象id,"#Y/对方尚未取消召唤兽参战状态，本次交易取消")
			发送数据(玩家数据[操作id].连接id,3511)
			发送数据(玩家数据[对象id].连接id,3511)
			玩家数据[id1].交易信息=nil
			玩家数据[id].交易信息=nil
			交易数据[交易id]=nil
			return
		elseif 玩家数据[操作id].召唤兽.数据[bb编号].统御~=nil then
			常规提示(操作id,"#Y/该召唤兽处于统御状态，请解除统御后再进行此操作")
			常规提示(对象id,"#Y/对方召唤兽处于统御状态，本次交易取消")
			发送数据(玩家数据[操作id].连接id,3511)
			发送数据(玩家数据[对象id].连接id,3511)
			玩家数据[id1].交易信息=nil
			玩家数据[id].交易信息=nil
			交易数据[交易id]=nil
			return
		end
	end
	local 操作id=id1
	local 对象id=id
	for n=1,#交易数据[交易id][操作id].bb do
		local bb编号= 交易数据[交易id][操作id].bb[n].编号
		local 认证码=玩家数据[操作id].召唤兽.数据[bb编号].认证码
		if 认证码~=交易数据[交易id][操作id].bb[n].认证码 then
			常规提示(操作id,"#Y/你此次交易的召唤兽数据与锁定前的数据不匹配，本次交易取消")
			常规提示(对象id,"#Y/对方此次交易的召唤兽数据与锁定前的数据不匹配，本次交易取消")
			发送数据(玩家数据[操作id].连接id,3511)
			发送数据(玩家数据[对象id].连接id,3511)
			玩家数据[id1].交易信息=nil
			玩家数据[id].交易信息=nil
			交易数据[交易id]=nil
			return
		elseif 玩家数据[操作id].召唤兽.数据[bb编号].不可交易 or 玩家数据[操作id].召唤兽.数据[bb编号].专用 then
			常规提示(操作id,"#Y/该召唤兽不可交易给他人，本次交易取消")
			常规提示(对象id,"#Y/对方此次交易存在无法交易的召唤兽，本次交易取消")
			发送数据(玩家数据[操作id].连接id,3511)
			发送数据(玩家数据[对象id].连接id,3511)
			玩家数据[id1].交易信息=nil
			玩家数据[id].交易信息=nil
			交易数据[交易id]=nil
			return
		elseif 玩家数据[操作id].角色.参战信息~=nil then
			常规提示(操作id,"#Y/请先取消所有召唤兽参战状态，本次交易取消")
			常规提示(对象id,"#Y/对方尚未取消召唤兽参战状态，本次交易取消")
			发送数据(玩家数据[操作id].连接id,3511)
			发送数据(玩家数据[对象id].连接id,3511)
			玩家数据[id1].交易信息=nil
			玩家数据[id].交易信息=nil
			交易数据[交易id]=nil
			return
		elseif 玩家数据[操作id].召唤兽.数据[bb编号].统御~=nil then
			常规提示(操作id,"#Y/该召唤兽处于统御状态，请解除统御后再进行此操作")
			常规提示(对象id,"#Y/对方召唤兽处于统御状态，本次交易取消")
			发送数据(玩家数据[操作id].连接id,3511)
			发送数据(玩家数据[对象id].连接id,3511)
			玩家数据[id1].交易信息=nil
			玩家数据[id].交易信息=nil
			交易数据[交易id]=nil
			return
		end
	end
	local 道具数量=玩家数据[id].角色:取道具格子2()
	local 道具数量1=玩家数据[id1].角色:取道具格子2()
	if 道具数量<#交易数据[交易id][id1].道具 then
		常规提示(id,"#Y/你身上的空间不够")
		常规提示(id1,"#Y/对方身上的空间不够")
		发送数据(玩家数据[id].连接id,3511)
		发送数据(玩家数据[id1].连接id,3511)
		玩家数据[id1].交易信息=nil
		玩家数据[id].交易信息=nil
		交易数据[交易id]=nil
		return
	elseif 道具数量1<#交易数据[交易id][id].道具 then
		常规提示(id1,"#Y/你身上的空间不够")
		常规提示(id,"#Y/对方身上的空间不够")
		发送数据(玩家数据[id].连接id,3511)
		发送数据(玩家数据[id1].连接id,3511)
		玩家数据[id1].交易信息=nil
		玩家数据[id].交易信息=nil
		交易数据[交易id]=nil
		return
	end
	if #玩家数据[id].召唤兽.数据+#交易数据[交易id][id1].bb>玩家数据[id].角色.召唤兽携带上限 then
		常规提示(id,"#Y/你可携带的召唤兽数量已达上限")
		常规提示(id1,"#Y/对方可携带的召唤兽数量已达上限")
		发送数据(玩家数据[id].连接id,3511)
		发送数据(玩家数据[id1].连接id,3511)
		玩家数据[id1].交易信息=nil
		玩家数据[id].交易信息=nil
		交易数据[交易id]=nil
		return
	elseif #玩家数据[id1].召唤兽.数据+#交易数据[交易id][id].bb>玩家数据[id].角色.召唤兽携带上限 then
		常规提示(id1,"#Y/你可携带的召唤兽数量已达上限")
		常规提示(id,"#Y/对方可携带的召唤兽数量已达上限")
		发送数据(玩家数据[id].连接id,3511)
		发送数据(玩家数据[id1].连接id,3511)
		玩家数据[id1].交易信息=nil
		玩家数据[id].交易信息=nil
		交易数据[交易id]=nil
		return
	end
	--数据转移起始
	local 操作id=id
	local 对象id=id1
	local 账号=玩家数据[操作id].账号
	local 账号1=玩家数据[对象id].账号
	local 名称=玩家数据[操作id].角色.名称
	local 名称1=玩家数据[对象id].角色.名称
	if 交易数据[交易id][操作id].银子>1 then
		local 之前银子=玩家数据[操作id].角色.银子
		玩家数据[操作id].角色.银子 =玩家数据[操作id].角色.银子 -  交易数据[交易id][操作id].银子
		玩家数据[操作id].角色:日志记录(format("[交易系统-扣除银子]给了[%s][%s][%s]银子,银子数额%s,之前数额%s,余额%s",账号1,对象id,名称1,交易数据[交易id][操作id].银子,之前银子,玩家数据[操作id].角色.银子))
		local 之前银子=玩家数据[对象id].角色.银子
		玩家数据[对象id].角色.银子 =玩家数据[对象id].角色.银子 +  交易数据[交易id][操作id].银子
		玩家数据[操作id].角色:日志记录(format("[交易系统-获得银子]获得[%s][%s][%s]银子,银子数额%s,之前数额%s,余额%s",账号,操作id,名称,交易数据[交易id][操作id].银子,之前银子,玩家数据[对象id].角色.银子))
		常规提示(对象id,format("#Y/%s给了你%s两银子",名称,交易数据[交易id][操作id].银子))
		常规提示(操作id,format("#Y/你给了%s%s两银子",名称1,交易数据[交易id][操作id].银子))
	end
	for n=1,#交易数据[交易id][操作id].道具 do
		local 道具id=交易数据[交易id][操作id].道具[n].编号
		local 数量 = 交易数据[交易id][操作id].道具[n].数量
		数量=math.floor(数量)
		if 数量 < 1 then
			return
		end
		local 新格子=玩家数据[对象id].角色:取道具格子()
		local 新id=玩家数据[对象id].道具:取新编号()
		local 道具识别码=玩家数据[对象id].道具.数据[新id].识别码
		local 道具名称=玩家数据[对象id].道具.数据[新id].名称
		if 玩家数据[操作id].道具:检查道具是否存在(操作id,道具识别码,数量) then
			if 数量==1 and (玩家数据[操作id].道具.数据[道具id].可叠加==nil or 玩家数据[操作id].道具.数据[道具id].可叠加==false) then
				玩家数据[对象id].道具.数据[新id]=玩家数据[操作id].道具:取指定道具(道具id)
				玩家数据[对象id].角色.道具[新格子]=新id
				玩家数据[操作id].道具.数据[道具id]=nil
				玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]=nil
			elseif 玩家数据[操作id].道具.数据[道具id].可叠加~=nil and 玩家数据[操作id].道具.数据[道具id].数量~=nil then
				if 数量<玩家数据[操作id].道具.数据[道具id].数量 then
					玩家数据[对象id].道具.数据[新id]=玩家数据[操作id].道具:取指定道具(道具id)
					玩家数据[对象id].道具.数据[新id].数量 = 数量
					玩家数据[对象id].角色.道具[新格子]=新id
					玩家数据[操作id].道具.数据[道具id].数量 = 玩家数据[操作id].道具.数据[道具id].数量 - 数量
				elseif 数量==玩家数据[操作id].道具.数据[道具id].数量 then
					玩家数据[对象id].道具.数据[新id]=玩家数据[操作id].道具:取指定道具(道具id)
					玩家数据[对象id].角色.道具[新格子]=新id
					玩家数据[操作id].道具.数据[道具id]=nil
					玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]=nil
				end
			elseif 玩家数据[操作id].道具.数据[道具id].数量 == nil then
				玩家数据[对象id].道具.数据[新id]=玩家数据[操作id].道具:取指定道具(道具id)
				玩家数据[对象id].角色.道具[新格子]=新id
				玩家数据[操作id].道具.数据[道具id]=nil
				玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]=nil
			end
			玩家数据[操作id].角色:日志记录(format("[交易系统-扣除物品]给了[%s][%s][%s]物品,物品名称为%s,识别码为%s",账号1,对象id,名称1,道具名称,道具识别码))
			玩家数据[对象id].角色:日志记录(format("[交易系统-获得物品]获得[%s][%s][%s]物品,物品名称为%s,识别码为%s",账号,操作id,名称,道具名称,道具识别码))
			常规提示(对象id,format("#Y/%s给了你%s",名称,道具名称))
			常规提示(操作id,format("#Y/你给了%s%s",名称1,道具名称))
		end
	end
	local 操作=false
	for n=1,#交易数据[交易id][操作id].bb do
		玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据+1]=table.loadstring(table.tostring(玩家数据[操作id].召唤兽.数据[交易数据[交易id][操作id].bb[n].编号]))
		local 宝宝=宝宝类.创建()
		宝宝:加载数据(玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据])
		玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据]=宝宝
		玩家数据[操作id].召唤兽.数据[交易数据[交易id][操作id].bb[n].编号]=nil
		local bb名称=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].名称
		local bb模型=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].模型
		local bb种类=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].种类
		local bb等级=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].等级
		玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].认证码=对象id.."_"..os.time().."_"..取随机数(111111111111,999999999999)
		local bb认证码=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].认证码
		local bb技能=""
		玩家数据[操作id].角色:日志记录(format("[交易系统-扣除bb]给了[%s][%s][%s]bb,名称为%s、模型为%s、种类为%s、等级为%s、技能为%s、认证码为%s",账号1,对象id,名称1,bb名称,bb模型,bb种类,bb等级,bb技能,bb认证码))
		玩家数据[对象id].角色:日志记录(format("[交易系统-获得bb]获得[%s][%s][%s]bb,名称为%s、模型为%s、种类为%s、等级为%s、技能为%s、认证码为%s",账号,操作id,名称,bb名称,bb模型,bb种类,bb等级,bb技能,bb认证码))
		操作=true
		常规提示(对象id,format("#Y/%s给了你%s",名称,bb名称))
		常规提示(操作id,format("#Y/你给了%s%s",名称1,bb名称))
	end
	local 临时bb={}
	if 操作 then
		for n=1,7 do
			if 玩家数据[操作id].召唤兽.数据[n]~=nil then
				临时bb[#临时bb+1]=table.loadstring(table.tostring(玩家数据[操作id].召唤兽.数据[n]))
			end
		end
		玩家数据[操作id].召唤兽.数据={}
		for n=1,#临时bb do
			玩家数据[操作id].召唤兽.数据[n]=table.loadstring(table.tostring(临时bb[n]))
			local 宝宝=宝宝类.创建()
			宝宝:加载数据(玩家数据[操作id].召唤兽.数据[n])
			玩家数据[操作id].召唤兽.数据[n]=宝宝
		end
		发送数据(玩家数据[操作id].连接id,3512,玩家数据[操作id].召唤兽.数据)
		发送数据(玩家数据[对象id].连接id,3512,玩家数据[操作id].召唤兽.数据)
	end
	--交换数据终止
	local 操作id=id1
	local 对象id=id
	local 账号=玩家数据[操作id].账号
	local 账号1=玩家数据[对象id].账号
	local 名称=玩家数据[操作id].角色.名称
	local 名称1=玩家数据[对象id].角色.名称
	if 交易数据[交易id][操作id].银子>0 then
		local 之前银子=玩家数据[操作id].角色.银子
		玩家数据[操作id].角色.银子 =玩家数据[操作id].角色.银子 -  交易数据[交易id][操作id].银子
		玩家数据[操作id].角色:日志记录(format("[交易系统-扣除银子]给了[%s][%s][%s]银子,银子数额%s,之前数额%s,余额%s",账号1,对象id,名称1,交易数据[交易id][操作id].银子,之前银子,玩家数据[操作id].角色.银子))
		local 之前银子=玩家数据[对象id].角色.银子
		玩家数据[对象id].角色.银子 =玩家数据[对象id].角色.银子 +  交易数据[交易id][操作id].银子
		玩家数据[操作id].角色:日志记录(format("[交易系统-获得银子]获得[%s][%s][%s]银子,银子数额%s,之前数额%s,余额%s",账号,操作id,名称,交易数据[交易id][操作id].银子,之前银子,玩家数据[对象id].角色.银子))
		常规提示(对象id,format("#Y/%s给了你%s两银子",名称,交易数据[交易id][操作id].银子))
		常规提示(操作id,format("#Y/你给了%s%s两银子",名称1,交易数据[交易id][操作id].银子))
	end

	玩家数据[操作id].角色:存档()
	玩家数据[对象id].角色:存档()

	for n=1,#交易数据[交易id][操作id].道具 do
		local 道具id=交易数据[交易id][操作id].道具[n].编号
		local 数量 = 交易数据[交易id][操作id].道具[n].数量
		数量=math.floor(数量)
		if 数量 < 1 then
			return
		end
		local 新格子=玩家数据[对象id].角色:取道具格子()
		local 新id=玩家数据[对象id].道具:取新编号()

		if 数量==1 and (玩家数据[操作id].道具.数据[道具id].可叠加==nil or 玩家数据[操作id].道具.数据[道具id].可叠加==false) then
			玩家数据[对象id].道具.数据[新id]=玩家数据[操作id].道具:取指定道具(道具id)
			玩家数据[对象id].角色.道具[新格子]=新id
			玩家数据[操作id].道具.数据[道具id]=nil
			玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]=nil
		elseif 玩家数据[操作id].道具.数据[道具id].可叠加~=nil and 玩家数据[操作id].道具.数据[道具id].数量~=nil then
			if 数量<玩家数据[操作id].道具.数据[道具id].数量 then
				玩家数据[对象id].道具.数据[新id]=玩家数据[操作id].道具:取指定道具(道具id)
				玩家数据[对象id].道具.数据[新id].数量 = 数量
				玩家数据[对象id].角色.道具[新格子]=新id
				玩家数据[操作id].道具.数据[道具id].数量 = 玩家数据[操作id].道具.数据[道具id].数量 - 数量
			elseif 数量==玩家数据[操作id].道具.数据[道具id].数量 then
				玩家数据[对象id].道具.数据[新id]=玩家数据[操作id].道具:取指定道具(道具id)
				玩家数据[对象id].角色.道具[新格子]=新id
				玩家数据[操作id].道具.数据[道具id]=nil
				玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]=nil
			end
		elseif 玩家数据[操作id].道具.数据[道具id].数量 == nil then
			玩家数据[对象id].道具.数据[新id]=玩家数据[操作id].道具:取指定道具(道具id)
			玩家数据[对象id].角色.道具[新格子]=新id
			玩家数据[操作id].道具.数据[道具id]=nil
			玩家数据[操作id].角色.道具[交易数据[交易id][操作id].道具[n].格子]=nil
		end

		local 道具识别码=玩家数据[对象id].道具.数据[新id].识别码
		local 道具名称=玩家数据[对象id].道具.数据[新id].名称
		玩家数据[操作id].角色:日志记录(format("[交易系统-扣除物品]给了[%s][%s][%s]物品,物品名称为%s,识别码为%s",账号1,对象id,名称1,道具名称,道具识别码))
		玩家数据[对象id].角色:日志记录(format("[交易系统-获得物品]获得[%s][%s][%s]物品,物品名称为%s,识别码为%s",账号,操作id,名称,道具名称,道具识别码))
		常规提示(对象id,format("#Y/%s给了你%s",名称,道具名称))
		常规提示(操作id,format("#Y/你给了%s%s",名称1,道具名称))
	end
	local 操作=false
	for n=1,#交易数据[交易id][操作id].bb do
		玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据+1]=table.loadstring(table.tostring(玩家数据[操作id].召唤兽.数据[交易数据[交易id][操作id].bb[n].编号]))
		local 宝宝=宝宝类.创建()
		宝宝:加载数据(玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据])
		玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据]=宝宝
		玩家数据[操作id].召唤兽.数据[交易数据[交易id][操作id].bb[n].编号]=nil
		local bb名称=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].名称
		local bb模型=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].模型
		local bb种类=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].种类
		local bb等级=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].等级
		玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].认证码 = 对象id.."_"..os.time().."_"..取随机数(111111111111,999999999999)
		local bb认证码=玩家数据[对象id].召唤兽.数据[#玩家数据[对象id].召唤兽.数据].认证码
		local bb技能=""
		玩家数据[操作id].角色:日志记录(format("[交易系统-扣除bb]给了[%s][%s][%s]bb,名称为%s、模型为%s、种类为%s、等级为%s、技能为%s、认证码为%s",账号1,对象id,名称1,bb名称,bb模型,bb种类,bb等级,bb技能,bb认证码))
		玩家数据[对象id].角色:日志记录(format("[交易系统-获得bb]获得[%s][%s][%s]bb,名称为%s、模型为%s、种类为%s、等级为%s、技能为%s、认证码为%s",账号,操作id,名称,bb名称,bb模型,bb种类,bb等级,bb技能,bb认证码))
		操作=true
		常规提示(对象id,format("#Y/%s给了你%s",名称,bb名称))
		常规提示(操作id,format("#Y/你给了%s%s",名称1,bb名称))
	end
	local 临时bb={}
	if 操作 then
		for n=1,7 do
			if 玩家数据[操作id].召唤兽.数据[n]~=nil then
				临时bb[#临时bb+1]=table.loadstring(table.tostring(玩家数据[操作id].召唤兽.数据[n]))
			end
		end
		玩家数据[操作id].召唤兽.数据={}
		for n=1,#临时bb do
			玩家数据[操作id].召唤兽.数据[n]=table.loadstring(table.tostring(临时bb[n]))
			local 宝宝=宝宝类.创建()
			宝宝:加载数据(玩家数据[操作id].召唤兽.数据[n])
			玩家数据[操作id].召唤兽.数据[n]=宝宝
		end
		发送数据(玩家数据[操作id].连接id,3512,玩家数据[操作id].召唤兽.数据)
		发送数据(玩家数据[对象id].连接id,3512,玩家数据[对象id].召唤兽.数据)
	end

	发送数据(玩家数据[id].连接id,3511,玩家数据[id].召唤兽.数据)
	发送数据(玩家数据[id1].连接id,3511,玩家数据[id1].召唤兽.数据)
	道具刷新(id)
	道具刷新(id1)
	玩家数据[id].角色:存档()
	玩家数据[id1].角色:存档()
	交易数据[交易id]=nil
	玩家数据[id].交易信息=nil
	玩家数据[id1].交易信息=nil
end

function 道具处理类:设置交易数据(连接id,id,数据)
	if type(玩家数据[id].交易信息)~= "table" then return end
	local 交易id=玩家数据[id].交易信息.编号
	local 对方id=玩家数据[id].交易信息.id
	if 交易数据[交易id][id].锁定 and 交易数据[交易id][对方id].锁定==nil then
		常规提示(id,"#Y/请耐心等待对方锁定交易状态")
		return
	elseif 交易数据[交易id][id].锁定 and 交易数据[交易id][对方id].锁定 then
		self:完成交易处理(交易id,id,对方id)
		return
	end
	local 道具数据={}
	local bb数据={}
	local 银子数据=数据.银子
	交易数据[交易id][id].道具={}
	交易数据[交易id][id].bb={}
	交易数据[交易id][id].银子=银子数据+0
	交易数据[交易id][id].锁定=true
	for n=1,3 do
		local 道具格子=数据.道具[n]
		if 道具格子~=nil then
			if 数据.数量[n]~=nil and (数据.数量[n]<1 or 数据.数量[n]>99) then
				return
			end
			local 道具id=玩家数据[id].角色.道具[道具格子]
			道具数据[#道具数据+1]=self:取指定道具(道具id)
			交易数据[交易id][id].道具[#交易数据[交易id][id].道具+1]={认证码=道具数据[#道具数据].识别码,格子=道具格子,编号=道具id,数量=数据.数量[n]}
		end
	end
	for n=1,3 do
		local bb编号=数据.bb[n]
		if bb编号~=nil then
			bb数据[#bb数据+1]=table.loadstring(table.tostring(玩家数据[id].召唤兽.数据[bb编号]))
			交易数据[交易id][id].bb[#交易数据[交易id][id].bb+1]={认证码=bb数据[#bb数据].认证码,编号=bb编号}
		end
	end
	发送数据(连接id,3508)
	常规提示(id,"#Y/你已经锁定了交易状态，对方锁定交易状态后点击确定即可完成交易")
	常规提示(对方id,"#Y/对方已经锁定了交易状态，等你锁定交易状态后点击确定即可完成交易")
	发送数据(玩家数据[对方id].连接id,3510,{bb=bb数据,道具=道具数据,银子=银子数据,数量=数据.数量})
end

function 道具处理类:出售装备(连接id,id)
	if 玩家数据[id].出售装备==nil or 玩家数据[id].角色.道具[玩家数据[id].出售装备]==nil then
		添加最后对话(id,"该装备不存在！")
		return
	end
	local 道具id=玩家数据[id].角色.道具[玩家数据[id].出售装备]
	if self.数据[道具id].总类~=2 or self.数据[道具id].灵饰 or self.数据[道具id].分类==9 then
		添加最后对话(id,"该物品无法被我收购")
		return
	end
	local 银子=self:取装备价格(道具id)
	玩家数据[id].角色:添加银子(银子,format("出售装备:%s,%s",self.数据[道具id].名称,self.数据[道具id].识别码),1)
	self.数据[道具id]=nil
	玩家数据[id].角色.道具[玩家数据[id].出售装备]=nil
	玩家数据[id].出售装备=nil
	添加最后对话(id,"出售装备成功，你获得了"..银子.."两银子")
	道具刷新(id)
	return
end

function 道具处理类:取回收环价格(道具id)
	local 等级=self.数据[道具id].级别限制
	if not 等级 then
		return 1
	end
	local 价格=150
	if 等级==10 then
		价格=30*等级
	elseif  等级==20 then
		价格=50*等级
	elseif 等级==30 then
		价格=100*等级
	elseif 等级==40 then
		价格=150*等级
	elseif 等级==50 then
		if f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","50环")~="空" then
					 价格=f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","50环")+0
		else
			价格=200*等级
		end
	elseif 等级==60 then
		if f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","60环")~="空" then
					 价格=f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","60环")+0
		else
			价格=300*等级
		end
	elseif 等级==70 then
		if f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","70环")~="空" then
					价格=f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","70环")+0
		else
			价格=500*等级
		end
	elseif 等级==80 then
		if f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","80环")~="空" then
					价格=f函数.读配置([[回收设置/服务端回收.txt]], "出售单价","80环")+0
		else
			价格=700*等级
		end
	else
		价格=1000
	end
	if self.数据[道具id].专用~=nil or self.数据[道具id].不可交易~=nil then
		价格=1
	end
	return 价格
end

function 道具处理类:取装备价格(道具id)
	local 等级=self.数据[道具id].级别限制
	if not 等级 then
		return
	end
	local 价格=150
	if 等级==10 then
		价格=30
	elseif  等级==20 then
		价格=50
	elseif 等级==30 then
		价格=100
	elseif 等级==40 then
		价格=150
	elseif 等级==50 then
		价格=200
	elseif 等级==60 then
		价格=300
	elseif 等级==70 then
		价格=500
	elseif 等级==80 then
		价格=700
	else
		价格=1000
	end
	if self.数据[道具id].专用~=nil then
		价格=1
		等级=1
	end
	return 价格*等级
end

function 道具处理类:生成合成旗(连接id,id,名称)
	if 玩家数据[id].合成旗序列==nil or #玩家数据[id].合成旗序列<=0 then
		常规提示(id,"#Y未找到已提交的导标旗，请重新使用法宝进行合成")
		玩家数据[id].合成旗序列=nil
		return
	end
	local 编号=玩家数据[id].法宝id
	if 玩家数据[id].角色.法宝[编号]==nil or self.数据[玩家数据[id].角色.法宝[编号]]==nil or self.数据[玩家数据[id].角色.法宝[编号]].名称~="五色旗盒" then
		常规提示(id,"#Y你没有这样的法宝")
		return
	elseif self.数据[玩家数据[id].角色.法宝[编号]].魔法<=0 then
		常规提示(id,"#Y你的法宝灵气不足")
		return
	end
	self.数据[玩家数据[id].角色.法宝[编号]].魔法=self.数据[玩家数据[id].角色.法宝[编号]].魔法-1
	local 次数=0
	for n=1,#玩家数据[id].合成旗序列 do
		local 临时id=玩家数据[id].角色.道具[玩家数据[id].合成旗序列[n]]
		if 临时id==nil or self.数据[临时id]==nil or self.数据[临时id].总类~=11 or self.数据[临时id].分类~=1 or self.数据[临时id].地图~=玩家数据[id].合成旗序列.地图 then
			常规提示(id,"#Y您的物品数据已经发生变化，请重新使用法宝进行合成")
			玩家数据[id].合成旗序列=nil
			return
		end
		if self.数据[临时id].次数==nil then
			self.数据[临时id].次数=1
		end
		次数=次数+self.数据[临时id].次数
	end
	local 临时id=玩家数据[id].角色.道具[玩家数据[id].合成旗序列[1]]
	self.数据[临时id].名称=名称
	self.数据[临时id].分类=2
	self.数据[临时id].次数=次数
	self.数据[临时id].xy={}
	for n=1,#玩家数据[id].合成旗序列 do
		local 临时id1=玩家数据[id].角色.道具[玩家数据[id].合成旗序列[n]]
		self.数据[临时id].xy[n]={x=self.数据[临时id1].x,y=self.数据[临时id1].y}
		if n~=1 then
			玩家数据[id].角色.道具[玩家数据[id].合成旗序列[n]]=nil
			self.数据[临时id1]=nil
		end
	end
	玩家数据[id].合成旗序列=nil
	玩家数据[id].法宝id=nil
	玩家数据[id].最后操作=nil
	发送数据(连接id,38,{内容="你的法宝#R/五色旗盒#W/灵气减少了1点"})
	常规提示(id,"#Y您获得了#R"..名称)
	道具刷新(id)
end

function 道具处理类:系统购买道具(id,名称,数量,价格,道具数据,消费方式,购买渠道,锦衣)
	if 价格<1 and 锦衣==nil then
		print("玩家id  "..id.."   商城购买物品存在作弊行为！")
		return false
	end
	价格=qz(价格)
	if not 玩家数据[id].角色:扣除银子(价格,0,0,购买渠道,1) then
		常规提示(id,"你没有那么多的银子")
		return false
	end

	local 识别码=id.."_"..os.time().."_"..取随机数(1000,9999).."_"..随机序列
	随机序列=随机序列+1

	local 临时道具
	local 道具id
	local 重置id=0
	local 提醒 = true
	for n=1,80 do
		if 重置id==0 and 玩家数据[id].角色.道具[n] and 数量~=nil and self.数据[玩家数据[id].角色.道具[n]] and self.数据[玩家数据[id].角色.道具[n]].名称==道具数据.名称 and self.数据[玩家数据[id].角色.道具[n]].数量 then
			-- if 数量 == nil or 数量 == "假" then 数量 =1 end
			-- if self.数据[玩家数据[id].角色.道具[n]].数量=="假" then
			-- 	self.数据[玩家数据[id].角色.道具[n]].数量 = 1
			-- end
			if self.数据[玩家数据[id].角色.道具[n]].数量+数量<=99999 then
				self.数据[玩家数据[id].角色.道具[n]].数量= self.数据[玩家数据[id].角色.道具[n]].数量 +数量
				重置id=1
			end
		end
	end

	if 重置id==0 then --这里检测到道具栏没有这个道具 或者是这个道具已经超过叠加数量
		local 道具格子=玩家数据[id].角色:取道具格子()
		if 道具格子==0 and 玩家数据[id].角色.自动存仓~=nil and 玩家数据[id].角色.自动存仓==1 then --道具格子满的情况
			--if 玩家数据[id].角色.自动存仓~=nil and 玩家数据[id].角色.自动存仓==1 then
				self:自动存仓处理1(id)
			  --[[else
				常规提示(id,"您的道具栏物品已经满啦")
        return
        end--]]
			--local 道具格子 =玩家数据[id].角色:取临时格子() --给到临时格子里面
			-- if 道具格子~=0 then --临时格子没满
			-- 	道具id=self:取新编号()
			-- 	self.数据[道具id]= 道具数据
			-- 	self.数据[道具id].识别码=识别码
			-- 	if 数量 ~= nil and self.数据[道具id].可叠加 then
			-- 		self.数据[道具id].数量 = 数量
			-- 	end
			-- 	玩家数据[id].角色.临时包裹[道具格子]=道具id
			-- else
			-- 	提醒=false
			-- 	常规提示(id,"#Y/你无法再继续获得道具")
			-- end
			-- local fhz = self:临时背包索取()
			-- if fhz[2] then
			-- 	发送数据(玩家数据[id].连接id,303,{"底图框","临时背包闪烁",true})
			-- end
		else
			道具id=self:取新编号()
			self.数据[道具id]= 道具数据
			self.数据[道具id].识别码=识别码
			if 数量 ~= nil and self.数据[道具id].可叠加 then
				self.数据[道具id].数量 = 数量
			end
			玩家数据[id].角色.道具[道具格子]=道具id
		end
	end
	临时道具 = 取物品数据(名称)
	临时道具.总类=临时道具[2]
	临时道具.子类=临时道具[4]
	临时道具.分类=临时道具[3]
	if 提醒 then
		常规提示(id,"#Y/你得到了#G"..(数量 or 1).."#Y个#G"..名称)
	end
	local 道具格子=玩家数据[id].角色:取道具格子()

	if 玩家数据[id].角色.自动存仓~=nil and 玩家数据[id].角色.自动存仓==1 and 道具格子==0 then --更改为包满再存仓，减少存仓刷新频率
	   --	local 道具格子=玩家数据[id].角色:取道具格子()
			--if 道具格子==0 then
          self:自动存仓处理1(id)----系统购买存
       -- 常规提示(id,"#Y/你的获得的#R/"..名称.."#Y/已自动存仓")
      --end
     end

	发送数据(玩家数据[id].连接id,3699)
	刷新玩家货币(玩家数据[id].连接id, id)
end

function 道具处理类:商场仙玉购买道具(id,名称,数量,价格,道具数据,消费方式,购买渠道)
	if 价格<1 then
		print("玩家id  "..id.."   商城购买物品存在作弊行为！")
		return false
	end
	价格=qz(价格)
	if not 玩家数据[id].角色:扣除仙玉(价格,0,0,购买渠道,1) then
		return false
	end

	local 识别码=id.."_"..os.time().."_"..取随机数(1000,9999).."_"..随机序列
	随机序列=随机序列+1

	local 临时道具
	local 道具id
	--  (道具数据)
	local 重置id=0
	local 提醒 = true

	for n=1,20 do
		if 重置id==0 and 玩家数据[id].角色.道具[n] and 数量~=nil and self.数据[玩家数据[id].角色.道具[n]] and self.数据[玩家数据[id].角色.道具[n]].名称==道具数据.名称 and self.数据[玩家数据[id].角色.道具[n]].数量 then
			if self.数据[玩家数据[id].角色.道具[n]].数量+数量<=99 then
				self.数据[玩家数据[id].角色.道具[n]].数量= self.数据[玩家数据[id].角色.道具[n]].数量 +数量
				重置id=1
			end
		end
	end

	if 重置id==0 then --这里检测到道具栏没有这个道具 或者是这个道具已经超过叠加数量
		local 道具格子=玩家数据[id].角色:取道具格子()
		if 道具格子==0 then --道具格子满的情况
			local 道具格子 =玩家数据[id].角色:取临时格子() --给到临时格子里面
			if 道具格子~=0 then --临时格子没满
				道具id=self:取新编号()
				self.数据[道具id]= 道具数据
				self.数据[道具id].识别码=识别码
				if 数量 ~= nil and self.数据[道具id].可叠加 then
					self.数据[道具id].数量 = 数量
				end
				--  (self.数据[道具id])
				玩家数据[id].角色.临时包裹[道具格子]=道具id
			else
				提醒=false
				常规提示(id,"#Y/你无法再继续获得道具")
			end
			local fhz = self:临时背包索取()
			if fhz[2] then
				发送数据(玩家数据[id].连接id,303,{"底图框","临时背包闪烁",true})
			end
		else
			道具id=self:取新编号()
			self.数据[道具id]= 道具数据
			self.数据[道具id].识别码=识别码
			if 数量 ~= nil and self.数据[道具id].可叠加 then
				self.数据[道具id].数量 = 数量
			end
			玩家数据[id].角色.道具[道具格子]=道具id
		end
	end


	临时道具 = 取物品数据(名称)
	临时道具.总类=临时道具[2]
	临时道具.子类=临时道具[4]
	临时道具.分类=临时道具[3]
	-- print(数量)
	if 提醒 then
		常规提示(id,"#Y/你得到了#G"..(数量 or 1).."#Y个#G"..名称)
	end
	发送数据(玩家数据[id].连接id,3699)
	刷新玩家货币(玩家数据[id].连接id, id)
end



function 道具处理类:给予超链接道具(id,名称,数量,参数,超链接)
	self:给予道具(id,名称,数量,参数,附加,专用,数据,消费,消费方式,消费内容,超链接)
end

function 道具处理类:给予道具(id,名称,数量,参数,附加,专用,数据,消费,消费方式,消费内容,超链接,灵气)
	local 识别码=id.."_"..os.time().."_"..取随机数(1000,9999).."_"..随机序列
	随机序列=随机序列+1
	local 临时道具
	local 道具id
	local 原始数量 = 数量
	if 原始数量 == nil then
		原始数量 = 1
	end

	if 数据 == nil then
		if 消费方式 ~= nil then
			if 消费<1 then
				print("玩家id  "..id.."   商城购买物品存在作弊行为！")
				return false
			end
			消费=qz(消费)
			if 消费方式 == "银子" then
				if not 玩家数据[id].角色:扣除银子(qz(消费*原始数量),0,0,消费内容,1) then
					常规提示(id,"你没有那么多的银子")
					return false
				end
			else
				常规提示(id,"你没有那么多的积分")
				return
			end
		end
		if 名称 == "超级净瓶玉露" or 名称 == "净瓶玉露"or 名称 == "超级金柳露" or 名称 == "金柳露" or 名称=="易经丹" or 名称=="金钥匙" or 名称=="银钥匙" or 名称=="铜钥匙" then
			if 数量 == nil then
				数量 = 1
			end
		end

		local 灵性
		if 名称=="初级清灵仙露" then
			灵性 = 取随机数(1,4)
			if 数量 == nil then
				数量 = 1
			end
		elseif 名称=="中级清灵仙露" then
			灵性 = 取随机数(2,6)
			if 数量 == nil then
				数量 = 1
			end
		elseif 名称=="高级清灵仙露" then
			灵性 = 取随机数(4,8)
			if 数量 == nil then
				数量 = 1
			end
		elseif 名称=="高级摄灵珠" then
			if 参数 then
				灵性=参数
			else
				灵性 = 4
			end

			if 数量 == nil then
				数量 = 1
			end
		elseif 名称=="如意丹" then
			灵性=取五行()
		end
		local 重置id=0
		for n=1,20 do
			if 重置id==0 and 玩家数据[id].角色.道具[n] and 数量~=nil and self.数据[玩家数据[id].角色.道具[n]] and self.数据[玩家数据[id].角色.道具[n]].名称==名称
				and self.数据[玩家数据[id].角色.道具[n]].数量
				and 名称 ~= "钨金" and 名称 ~= "元宵" and 名称 ~= "九转金丹" and 名称 ~= "月华露" and not string.find(名称, '召唤兽内丹') and not string.find(名称, '魔兽要诀') then
				if self.数据[玩家数据[id].角色.道具[n]].数量+数量<=99  then
					数量=self.数据[玩家数据[id].角色.道具[n]].数量+数量
					道具id=玩家数据[id].角色.道具[n]
					识别码=self.数据[玩家数据[id].角色.道具[n]].识别码
					重置id=1
					-----------------------武神坛
					if 玩家数据[id].角色.武神坛角色 then
						self.数据[玩家数据[id].角色.道具[n]].专用 = id
						self.数据[道具id].不可交易=true
					end
					-----------------------
				end
			end
		end

		if 重置id==0 then
			local 道具格子=玩家数据[id].角色:取道具格子()
			if 道具格子==0 then
				local 临时格子 =玩家数据[id].角色:取临时格子()
				if 临时格子~=0 then
					道具id=self:取新编号()
					self.数据[道具id]=物品类()
					self.数据[道具id]:置对象(名称)
					玩家数据[id].角色.临时包裹[临时格子]=道具id
				else
					常规提示(id,"#Y/你的临时背包已满无法继续获得道具")
				end
				local fhz = self:临时背包索取()
				if fhz[2] then
					发送数据(玩家数据[id].连接id,303,{"底图框","临时背包闪烁",true})
				end
			else
				道具id=self:取新编号()
				self.数据[道具id]=物品类()
				self.数据[道具id]:置对象(名称)
				玩家数据[id].角色.道具[道具格子]=道具id
			end
		end
		临时道具 = 取物品数据(名称)
		临时道具.总类=临时道具[2]
		临时道具.子类=临时道具[4]
		临时道具.分类=临时道具[3]
		if self.kediejia[名称] then
			if 数量==nil then
				数量=1
			end
			self.数据[道具id].可叠加 = true
		end
		if 名称=="鬼谷子" then
			local go=false
			if 参数 then
				for i=4,13 do
					if self.阵法名称[i]==参数 then
						self.数据[道具id].子类=参数
						go=true
						break
					end
				end
			end
			if not go then
			   self.数据[道具id].子类 = self.阵法名称[取随机数(4,13)]
			end
		---------------------------------------
	  elseif 名称=="玄灵珠·回春" or 名称=="玄灵珠·破军" then
		    if 参数~=nil then
		    	self.数据[道具id].级别限制 = 参数+0
		    elseif self.数据[道具id].级别限制 ==nil then
		      self.数据[道具id].级别限制 = 1
		    end
		elseif 名称=="玄灵珠·空灵" or 名称=="玄灵珠·噬魂" then
			  if 参数~=nil then
			  	self.数据[道具id].级别限制 = 参数+0
			  elseif self.数据[道具id].级别限制 ==nil then
			    self.数据[道具id].级别限制 = 1
			  end
		elseif 名称=="器灵·金蝉" or  名称=="器灵·无双"  then

			local 部位={"衣服","武器","鞋子","头盔","项链","腰带"}
		self.数据[道具id].限制=参数 or 部位[取随机数(1,#部位)]
		self.数据[道具id].级别限制=数量 or 160
		---------------------------------------
		elseif 名称=="战魄" then
				self.数据[道具id].级别限制 = 160
		elseif 名称=="钟灵石" then
				self.数据[道具id].级别限制 = 参数 or 1
				self.数据[道具id].技能 = 附加 or 钟灵石技能[取随机数(1,#钟灵石技能)]
		elseif 名称=="初级清灵仙露" or 名称=="中级清灵仙露" or 名称=="高级清灵仙露" or 名称=="高级摄灵珠" then
			if 灵气 ~= nil then
				self.数据[道具id].灵气=灵气
			else
				self.数据[道具id].灵气=灵性
			end

			self.数据[道具id].可叠加 = false
		elseif 名称=="特殊清灵仙露"	then
			self.数据[道具id].灵气=110
			self.数据[道具id].可叠加 = true
		elseif 名称=="特效宝珠" then
			self.数据[道具id].可叠加 = true
		elseif 名称=="神兜兜" then
			self.数据[道具id].可叠加 = true
		elseif 名称=="装备特效宝珠" then
			self.数据[道具id].可叠加 = true
		elseif 名称=="灵兜兜" then
			self.数据[道具id].可叠加 = true
		elseif 名称=="元素曜石·冰" or 名称=="元素曜石·风"  or 名称=="元素曜石·火" or 名称=="元素曜石·雷" or 名称=="元素曜石·水" or 名称=="元素曜石·岩"  then
			self.数据[道具id].级别限制 = 数量 or 0
		elseif 名称=="镇妖拘魂铃" then
			self.数据[道具id].可叠加 = true
			self.数据[道具id].不可交易 = true
		elseif  名称=="新手大礼包" or 名称=="秘宝宝箱" or 名称=="机缘宝箱" or 名称=="月卡" then
			self.数据[道具id].可叠加 = false
			self.数据[道具id].不可交易 = true
		elseif 名称=="新春飞行符" then
			self.数据[道具id].可叠加 = false
			if 数量 then
				self.数据[道具id].次数=数量
			end
		elseif 名称=="自动抓鬼卡" then
			self.数据[道具id].专用 = id
			self.数据[道具id].可叠加 = false
			self.数据[道具id].不可交易 = true
		elseif 名称=="炫彩ID" then
			local sdsd={"绿色ID","蓝色ID","紫色ID","黄金ID"}   --2
			if  数量 and type(数量)~= "number" then
				 self.数据[道具id].特效=数量
			else
				local sdsd={"绿色ID","蓝色ID","紫色ID","黄金ID"}
				 self.数据[道具id].特效=sdsd[取随机数(1,#sdsd)]
			end
		elseif 名称=="超级合成旗" then
			if 数量~=500 then
			self.数据[道具id].地图="全部"
			self.数据[道具id].可叠加=false
			self.数据[道具id].次数=120
		              else
		  self.数据[道具id].地图="全部"
			self.数据[道具id].可叠加=false
			self.数据[道具id].次数=500
		             end
		elseif 名称=="未激活的符石" then
			local 级别 = 数量 or 1
			self.数据[道具id].子类 = 级别
				if 级别 == 1 then
					self.数据[道具id].符石名称 = 一级符石[取随机数(1,#一级符石)]
				elseif 级别==2 then
					self.数据[道具id].符石名称 = 二级符石[取随机数(1,#二级符石)]
				elseif 级别==3 then
					self.数据[道具id].符石名称 = 三级符石[取随机数(1,#三级符石)]
				else
					self.数据[道具id].子类 = 1
					self.数据[道具id].符石名称 = 一级符石[取随机数(1,#一级符石)]
				end
				local lssj = 取物品数据(self.数据[道具id].符石名称)
				self.数据[道具id].符石属性 = lssj[21]
				self.数据[道具id].颜色 = lssj[20]
---新三级符石 = {"太极符石","阴仪符石","阳仪符石","太阴符石","少阴符石","少阳符石","太阳符石"}
		elseif 名称=="太极符石" or 名称=="阴仪符石" or 名称=="阳仪符石" or 名称=="太阴符石" or 名称=="少阴符石" or 名称=="少阳符石"or 名称=="太阳符石" then
			local 级别 = 数量 or 1
			self.数据[道具id].子类 = 级别
				local lssj = 取物品数据(名称)
				self.数据[道具id].符石属性 = lssj[21]
				self.数据[道具id].颜色 = lssj[20]
		elseif 名称=="未激活的星石" then
			if 参数==nil then
				self.数据[道具id].子类 = 取随机数(1,6)
			else
				if 参数 == "头盔" then
					self.数据[道具id].子类 = 1
				elseif 参数 == "饰物" then
					self.数据[道具id].子类 = 2
				elseif 参数 == "武器" then
					self.数据[道具id].子类 = 3
				elseif 参数 == "衣甲" then
					self.数据[道具id].子类 = 4
				elseif 参数 == "腰带" then
					self.数据[道具id].子类 = 5
				elseif 参数 == "靴子" then
					self.数据[道具id].子类 = 6
				else
					self.数据[道具id].子类 = 取随机数(1,6)
				end
			end
		elseif 名称=="灵犀玉" then
			if 参数==nil then
				if 取随机数() <=80 then
					self.数据[道具id].子类 = 取随机数(1,2)
				else
					self.数据[道具id].子类 = 取随机数(2,3)
				end
				self.数据[道具id].特性 = 取灵犀玉特性()
			else
				self.数据[道具id].子类 = 3
				self.数据[道具id].特性 = 取礼包灵犀玉特性()
			end
			if 玩家数据[id].角色.武神坛角色 then --武神坛
				self.数据[道具id].不可交易=true
				self.数据[道具id].专用=id
			end
		elseif 名称=="神兵图鉴" or 名称=="灵宝图鉴" or 名称=="灵饰图鉴" then
			self.数据[道具id].子类 = 数量
		elseif 名称=="阎罗免死牌" then
			self.数据[道具id].次数 = 3
			self.数据[道具id].限时 = os.time()+86400
		elseif 名称=="制造指南书" then
			if 参数==nil then
				self.数据[道具id].子类=数量[取随机数(1,#数量)]*10
				self.数据[道具id].特效=取随机数(1,#书铁范围)
				if 取随机数()<=40 then
					self.数据[道具id].特效=取随机数(19,#书铁范围)
				end
			else
				self.数据[道具id].子类=数量
				self.数据[道具id].特效=参数
			end
		elseif 名称=="灵饰指南书" then
			if 数量 then
				self.数据[道具id].子类=数量[取随机数(1,#数量)]*10
			else
				local lv = 玩家数据[id].角色.等级
				local fanwei={6,8}
				if lv>=80 and lv<100 then
					fanwei={8,10}
				elseif lv>=100 and lv<120 then
					fanwei={10,12}
				elseif lv>=120 then
					fanwei={10,12,14}
				end
				self.数据[道具id].子类=fanwei[取随机数(1,#fanwei)]*10
			end
			if 参数 then
				self.数据[道具id].特效=参数
			else
				self.数据[道具id].特效=随机灵饰[取随机数(1,#随机灵饰)]
			end

		elseif 名称=="元灵晶石" then
			if 数量 then
				self.数据[道具id].子类=数量[取随机数(1,#数量)]*10
			else
				local lv = 玩家数据[id].角色.等级
				local fanwei={6,8}
				if lv>=80 and lv<100 then
					fanwei={8,10}
				elseif lv>=100 and lv<120 then
					fanwei={10,12}
				elseif lv>=120 then
					fanwei={10,12,14}
				end
				self.数据[道具id].子类=fanwei[取随机数(1,#fanwei)]*10
			end
		elseif 名称=="百炼精铁" then
			self.数据[道具id].子类=数量
		elseif 名称=="精魄灵石" then
			if 参数 ~= nil then
				sj = 1
				if 参数 == '速度' then
					sj =1
				elseif 参数 =='躲避' then
					sj =2
				elseif 参数 == '伤害'then
					sj =3
				elseif 参数 == '灵力' then
					sj =4
				elseif 参数 == '防御' then
					sj =5
				elseif 参数 == '气血' then
					sj =6
				end
				self.数据[道具id].子类=sj --红黄蓝
				self.数据[道具id].级别限制=数量 or 1
				self.数据[道具id].特效=参数
			else
				local sj = 取随机数(1,6)
				local 类型={"速度","躲避","伤害","灵力","防御","气血"}
				self.数据[道具id].子类=sj --红黄蓝
				self.数据[道具id].级别限制=数量 or 1
				self.数据[道具id].特效=参数 or 类型[sj]
			end

			self.数据[道具id].可叠加=false
		elseif 名称=="精魄灵石灵石礼包-速度" then
			self.数据[道具id].可叠加=false
		elseif 名称=="精魄灵石灵石礼包-伤害" then
			self.数据[道具id].可叠加=false
		elseif 名称=="精魄灵石灵石礼包-灵力" then
			self.数据[道具id].可叠加=false
		elseif 名称=="精魄灵石灵石礼包-防御" then
			local 类型={"速度","躲避","伤害","灵力","防御","气血"}
			self.数据[道具id].可叠加=false
		elseif 名称=="精魄灵石灵石礼包-气血" then
			self.数据[道具id].可叠加=false
		elseif 名称=="钨金" then-----------------------------------------------------------
			if 数量==nil then
					数量=1
			else
				数量=数量+0
			end
			self.数据[道具id].可叠加=true
			if 参数~=nil then
				self.数据[道具id].级别限制=160
			else
				self.数据[道具id].级别限制=self.数据[道具id].级别限制 or 160
			end
			self.数据[道具id].级别限制=160
		elseif 名称=="珍珠" then--------------------------------------
			self.数据[道具id].可叠加=true
			if 数量~=nil then
				self.数据[道具id].数量=数量
				self.数据[道具id].级别限制=self.数据[道具id].级别限制 or 160
			else
				self.数据[道具id].数量=1
				self.数据[道具id].级别限制=self.数据[道具id].级别限制 or 160
			end

		elseif 名称=="附魔宝珠"  then--------------------------------------
			self.数据[道具id].可叠加=true
			if 数量~=nil then
				self.数据[道具id].数量=数量
				self.数据[道具id].级别限制=self.数据[道具id].级别限制 or 160
			else
				self.数据[道具id].数量=1
				self.数据[道具id].级别限制=self.数据[道具id].级别限制 or 160
			end

		elseif 名称=="召唤兽内丹" then
			self.数据[道具id].特效=参数 or 取内丹("低级")
		elseif 名称=="高级召唤兽内丹" then
			self.数据[道具id].特效=参数 or 取内丹("高级")


		elseif 名称=="魔兽要诀" then
			if 参数==nil then
				self.数据[道具id].附带技能=取低级要诀()
			else
				self.数据[道具id].附带技能=参数
			end

		elseif 名称=="高级魔兽要诀" then
			if 参数==nil then
				self.数据[道具id].附带技能=取高级要诀()
			else
				self.数据[道具id].附带技能=参数
			end
		elseif 名称=="特殊魔兽要诀" then
			if 参数==nil then
				self.数据[道具id].附带技能=取特殊要诀()
			else
				self.数据[道具id].附带技能=参数
			end
			self.数据[道具id].名称="特殊魔兽要诀"
		elseif 名称=="特色魔兽要诀" then
			if 参数==nil then
				self.数据[道具id].附带技能=取特色要诀()
			else
				self.数据[道具id].附带技能=参数
			end
			self.数据[道具id].名称="特色魔兽要诀"

		elseif 名称=="超级魔兽要诀" then   --新加
			if 参数==nil then
				self.数据[道具id].附带技能=取超级要诀()
			else
				self.数据[道具id].附带技能=参数
			end
		elseif 名称=="招魂帖" then
			local 随机地图={1208,1040,1501,1070,1040,1226,1092}
			local 临时地图=随机地图[取随机数(1,#随机地图)]
			self.数据[道具id].地图名称=取地图名称(临时地图)
			self.数据[道具id].地图编号=临时地图
			local xy=地图处理类.地图坐标[临时地图]:取随机点()
			self.数据[道具id].x=xy.x
			self.数据[道具id].y=xy.y
			降妖伏魔:招魂帖(id,self.数据[道具id].地图编号,self.数据[道具id].x,self.数据[道具id].y)
		elseif 名称=="逐妖蛊虫" then
			local 随机地图={1208,1040,1501,1070,1040,1226,1092}
			local 临时地图=随机地图[取随机数(1,#随机地图)]
			self.数据[道具id].地图名称=取地图名称(临时地图)
			self.数据[道具id].地图编号=临时地图
			local xy=地图处理类.地图坐标[临时地图]:取随机点()
			self.数据[道具id].x=xy.x
			self.数据[道具id].y=xy.y
			降妖伏魔:逐妖蛊虫(id,self.数据[道具id].地图编号,self.数据[道具id].x,self.数据[道具id].y)
		elseif 名称=="点化石" then
			self.数据[道具id].附带技能=数量 or "感知"
		elseif  名称=="九转金丹" then
			self.数据[道具id].阶品= 100
			self.数据[道具id].可叠加 = true--false
		elseif 名称=="月华露" then
			self.数据[道具id].阶品= 数量 or 500
			self.数据[道具id].可叠加 = true
		-- elseif 名称=="五味露" then
		-- 	self.数据[道具id].阶品=数量 or 500
		-- 	self.数据[道具id].可叠加 = false
		elseif 名称=="藏宝图" or 名称=="高级藏宝图" or 名称=="玲珑宝图" then
			local 随机地图={1501,1506,1092,1091,1110,1142,1514,1174,1173,1146,1208}
			local 临时地图=随机地图[取随机数(1,#随机地图)]
			self.数据[道具id].地图名称=取地图名称(临时地图)
			self.数据[道具id].地图编号=临时地图
			local xy=地图处理类.地图坐标[临时地图]:取随机点()
			self.数据[道具id].x=xy.x
			self.数据[道具id].y=xy.y
		elseif 名称=="上古锻造图策" then
			if 数量 then
				self.数据[道具id].级别限制=数量[取随机数(1,#数量)]*10-5
			else
				local 等级=玩家数据[id].角色.等级
				local lv = math.min(qz(等级/10),13)
				local nm={lv+1,lv+2}
				self.数据[道具id].级别限制=nm[取随机数(1,#nm)]*10-5
			end
			-- self.数据[道具id].级别限制=数量[取随机数(1,#数量)]*10-5
			self.数据[道具id].种类=图策范围[取随机数(1,#图策范围)]
		elseif 名称=="炼妖石" then
			if 数量 then
				self.数据[道具id].级别限制=数量[取随机数(1,#数量)]*10-5
			else
				local 等级=玩家数据[id].角色.等级
				local lv = math.min(qz(等级/10),13)
				local nm={lv+1,lv+2}
				self.数据[道具id].级别限制=nm[取随机数(1,#nm)]*10-5
			end
			-- self.数据[道具id].级别限制=数量[取随机数(1,#数量)]*10-5
			self.数据[道具id].分类=3
		elseif 名称=="怪物卡片" then
			if 变身卡数据[数量]==nil then
				self.数据[道具id].等级=数量
				self.数据[道具id].造型=变身卡范围[数量][取随机数(1,#变身卡范围[数量])]
			else
				self.数据[道具id].等级=变身卡数据[数量].等级
				self.数据[道具id].造型=数量
			end
			self.数据[道具id].类型=变身卡数据[self.数据[道具id].造型].类型
			self.数据[道具id].单独=变身卡数据[self.数据[道具id].造型].单独
			self.数据[道具id].正负=变身卡数据[self.数据[道具id].造型].正负
			self.数据[道具id].技能=变身卡数据[self.数据[道具id].造型].技能
			self.数据[道具id].属性=变身卡数据[self.数据[道具id].造型].属性
			self.数据[道具id].次数=self.数据[道具id].等级
		 elseif 名称=="如意丹" then
		 	self.数据[道具id].灵气 = 灵性
		 	self.数据[道具id].可叠加 = true
		-- elseif 名称=="龙之筋" then
		-- 	self.数据[道具id].五行 = 取五行()
		-- elseif 名称=="天蚕丝" then
		-- 	self.数据[道具id].五行 = "金"
		-- elseif 名称=="阴沉木" then
		-- 	self.数据[道具id].五行 = "木"
		-- elseif 名称=="玄龟板" then
		-- 	self.数据[道具id].五行 = 取五行()
		-- elseif 名称=="麒麟血" then
		-- 	self.数据[道具id].五行 = 取五行()
		-- elseif 名称=="补天石" then
		-- 	self.数据[道具id].五行 = 取五行()
		-- elseif 名称=="金凤羽" then
		-- 	self.数据[道具id].五行 =取五行()
		-- elseif 名称=="内丹" then
		-- 	self.数据[道具id].五行 =取五行()
	--	elseif 名称 == "秘制食谱" then
	--		self.数据[道具id].子类 =参数
		elseif 名称 == "祈愿宝箱" then
			self.数据[道具id].次数 =数量
		elseif 临时道具.总类==3 and  临时道具.分类==11 then  --{"天眼珠","三眼天珠","九眼天珠"}
			if 灵气 == nil then
				self.数据[道具id].灵气=取随机数(10,100)
			else
				self.数据[道具id].灵气=灵气
			end
			self.数据[道具id].级别限制 = 数量
		elseif 临时道具.总类==5 and  临时道具.分类==4 then
			if 数量 == nil then
				self.数据[道具id].级别限制=1
			else
				self.数据[道具id].级别限制=数量+0
			end
		elseif 临时道具.总类==5 and  临时道具.分类==6 then --宝石
			if 数量 == nil then
				self.数据[道具id].级别限制=1
			else
				self.数据[道具id].级别限制=数量+0
			end
		elseif 临时道具.总类==1 and 临时道具.子类==1 and 临时道具.分类==4 then
			self.数据[道具id].阶品=参数
		elseif 名称=="金创药" or 名称=="红雪散" or 名称=="小还丹"  or 名称=="千年保心丹" or 名称=="金香玉" or 名称=="风水混元丹" or 名称=="蛇蝎美人" or 名称=="定神香" or 名称=="佛光舍利子" or 名称=="九转回魂丹" or 名称=="五龙丹" or 名称=="十香返生丸"  then
			self.数据[道具id].阶品=参数 or 取随机数(30,50)
		    self.数据[道具id].附加技能=附加
		elseif 名称=="醉仙果" or 名称=="七珍丸" or 名称=="凝气丸"  or 名称=="舒筋活络丸" or 名称=="固本培元丹" or 名称=="九转续命丹" or 名称=="十全大补丸"  then
			self.数据[道具id].阶品=参数 or 取随机数(25,35)
		end
		if self.数据[道具id].名称 then
			if self.数据[道具id].可叠加 then
				djflag = false
				if 数量 == nil then
					self.数据[道具id].数量=1
					常规提示(id,"#Y/你获得了 "..self.数据[道具id].名称)
				else
					self.数据[道具id].数量=数量 or 1
					常规提示(id,"#Y/你获得了"..原始数量.."个"..self.数据[道具id].名称)
				end
			else
				常规提示(id,"#Y/你获得了"..self.数据[道具id].名称)
			end
		end

		self.数据[道具id].识别码=识别码
		if  self.数据[道具id].名称=="心魔宝珠" then
			self.数据[道具id].不可交易=true
		end
		if 专用~=nil then
			self.数据[道具id].专用=id
			self.数据[道具id].不可交易=true
		end
		-----------------------武神坛
		if 玩家数据[id].角色.武神坛角色 then
			self.数据[道具id].专用 = id
			self.数据[道具id].不可交易=true
		end
		-----------------------
	else
		  if 消费方式 ~= nil then
				if 消费<1 then
					print("玩家id  "..id.."   商城购买物品存在作弊行为！")
					return false
				end
				消费=qz(消费)
				if 消费方式 == "银子" then
					if not 玩家数据[id].角色:扣除银子(消费*原始数量,0,0,消费内容,1) then
						常规提示(id,"你没有那么多的银子")
						return false
					end
				end
			end
		local 重置id=0
		for n=1,20 do

			  if 重置id==0 and 玩家数据[id].角色.道具[n] and 数量~=nil and self.数据[玩家数据[id].角色.道具[n]] and self.数据[玩家数据[id].角色.道具[n]].名称==名称 and self.数据[玩家数据[id].角色.道具[n]].数量 then
					if self.数据[玩家数据[id].角色.道具[n]].数量+数量<=99 then
						self.数据[玩家数据[id].角色.道具[n]].数量= self.数据[玩家数据[id].角色.道具[n]].数量 +数量
						重置id=1
					-----------------------武神坛
						if 玩家数据[id].角色.武神坛角色 then
							self.数据[玩家数据[id].角色.道具[n]].专用 = id
							self.数据[玩家数据[id].角色.道具[n]].不可交易=true
						end
					-----------------------
					end
				end
		end

		if 重置id==0 then
			local 道具格子=玩家数据[id].角色:取道具格子()
			  if 道具格子==0 then
				if 玩家数据[id].角色.自动存仓~=nil and 玩家数据[id].角色.自动存仓==1 then
				self:自动存仓处理1(id)------给予道具存
			  else
				常规提示(id,"您的道具栏物品已经满啦")
        return
        end

			else
				道具id=self:取新编号()
				self.数据[道具id]= table.copy(数据)
				self.数据[道具id].识别码=识别码
				if self.数据[道具id].名称 then
					if 数量 ~= nil then
						self.数据[道具id].数量 = 数量
						常规提示(id,"#Y/你获得了"..原始数量.."#Y个"..self.数据[道具id].名称)
					else
						常规提示(id,"#Y/你获得了"..self.数据[道具id].名称)
					end
				end
				玩家数据[id].角色.道具[道具格子]=道具id
				-----------------------武神坛
				if 玩家数据[id].角色.武神坛角色 then
					self.数据[道具id].专用 = id
					self.数据[道具id].不可交易=true
				end
				-----------------------
			end
		end
	end
	if self.数据[道具id] then --羔羊回收
		-- 移除自动回收功能
		-- self:自动回收道具(id,道具id)
	end
	if 超链接 and self.数据[道具id] then
		local 文本 = 超链接.提示.."#G/qqq|"..self.数据[道具id].名称.."*"..self.数据[道具id].识别码.."*道具/["..self.数据[道具id].名称.."]#W"..超链接.结尾
		local 返回信息 = {}
		返回信息[#返回信息+1] = self.数据[道具id]
		返回信息[#返回信息].索引类型 = "道具"
		广播消息({内容=文本,频道=超链接.频道,方式=1,超链接=返回信息})
	end
	   if 玩家数据[id].角色.自动存仓~=nil and 玩家数据[id].角色.自动存仓==1 then
	   	local 道具格子=玩家数据[id].角色:取道具格子()
			if 道具格子==0 then
          self:自动存仓处理1(id)
      end
     end
	发送数据(玩家数据[id].连接id,3699)
	return true
end

function 道具处理类:自动回收道具(id,道具id) --羔羊回收
	  if self.数据[道具id] == nil then return end
		local 获得银子 = 0
		local 提示
		if 玩家数据[id].自动回收==nil then return end
		local Q_选项回收价格 = 玩家数据[id].自动回收:取Q_选项回收价格()
		if self.数据[道具id].总类==5 and self.数据[道具id].分类==6 and self.数据[道具id].名称~="陨铁" and self.数据[道具id].名称~="精致碎石锤" and self.数据[道具id].名称~="钨金" and self.数据[道具id].名称~="战魄" then --宝石、星辉
				local djdj = self.数据[道具id].级别限制 or 1
				if self.数据[道具id].名称 == "星辉石" then
					if Q_选项回收价格.星辉石  then
						获得银子 = Q_选项回收价格.星辉石 * 3 ^(djdj -1)
						玩家数据[self.数字id].角色:添加银子(获得银子,"回收")
						提示=true
					end
				else
				  if Q_选项回收价格.宝石 then
						获得银子 = Q_选项回收价格.宝石 * 2 ^(djdj -1)
						玩家数据[self.数字id].角色:添加银子(获得银子,"回收")
						提示=true
					end
				end
		elseif self.数据[道具id].名称 == "灵犀玉" then
				local djdj = self.数据[道具id].子类 or 1
				if Q_选项回收价格.灵犀玉[djdj] ~= nil then
					获得银子 = Q_选项回收价格.灵犀玉[djdj]
					玩家数据[self.数字id].角色:添加银子(获得银子,"回收")
					提示=true
				end
		elseif self.数据[道具id].名称 == "精魄灵石" then
				local djdj = self.数据[道具id].级别限制 or 1
				if Q_选项回收价格.精魄灵石 ~= nil then
					获得银子 = Q_选项回收价格.精魄灵石 * 2 ^(djdj -1)
					玩家数据[self.数字id].角色:添加银子(获得银子,"回收")
					提示=true
				end
		elseif self.数据[道具id].总类==2 and self.数据[道具id].分类 >= 1 and self.数据[道具id].分类 <= 6 then --装备
				if self.数据[道具id].专用 then return end
				if self.数据[道具id].锻炼等级 ~= nil and self.数据[道具id].锻炼等级 >= 5 then return end
				local djdj = self.数据[道具id].级别限制 or 60
				if djdj > 90 then
					return
				end
				if Q_选项回收价格.装备[djdj] ~= nil then
					获得银子 = Q_选项回收价格.装备[djdj]
					玩家数据[self.数字id].角色:添加银子(获得银子,"回收")
				end
				提示=true
		elseif self.数据[道具id].总类==2 and self.数据[道具id].分类 >= 10 and self.数据[道具id].分类 <= 14 then --灵饰
				if self.数据[道具id].专用 or not self.数据[道具id].鉴定 then return end
				if self.数据[道具id].幻化等级 ~= nil and self.数据[道具id].幻化等级 >= 5 then return end
				local djdj = self.数据[道具id].级别限制 or 60
				if Q_选项回收价格.灵饰[djdj] ~= nil then
					获得银子 = Q_选项回收价格.灵饰[djdj]
					玩家数据[self.数字id].角色:添加银子(获得银子,"回收")
				end
				提示=true
		elseif self.数据[道具id].名称=="制造指南书" then
				local djdj = self.数据[道具id].子类 or 10
				local wz = self.数据[道具id].特效
				local rate = 1
				if wz <= 18 then
					rate = 1
				elseif wz == 21 or wz == 24 then
					rate = 4
				elseif wz > 18 and wz < 26 then
					rate = 2
				end
				if Q_选项回收价格.装备书[djdj] ~= nil then
					获得银子 = Q_选项回收价格.装备书[djdj] * rate
					玩家数据[self.数字id].角色:添加银子(获得银子,"回收")
					提示=true
				end

		elseif self.数据[道具id].名称=="百炼精铁" then
			  local djdj = self.数据[道具id].子类 or 10
				if Q_选项回收价格.百炼精铁[djdj] ~= nil then
					获得银子 = Q_选项回收价格.百炼精铁[djdj]
					玩家数据[self.数字id].角色:添加银子(获得银子,"回收")
					提示=true
				end

		elseif self.数据[道具id].名称=="灵饰指南书" then
			  local djdj = self.数据[道具id].子类 or 10
				if Q_选项回收价格.灵饰书[djdj] ~= nil then
					获得银子 = Q_选项回收价格.灵饰书[djdj]
					玩家数据[self.数字id].角色:添加银子(获得银子,"回收")
					提示=true
				end

		elseif self.数据[道具id].名称=="元灵晶石" then
				local djdj = self.数据[道具id].子类 or 10
				if Q_选项回收价格.元灵晶石[djdj] ~= nil then
					获得银子 = Q_选项回收价格.元灵晶石[djdj]
					玩家数据[self.数字id].角色:添加银子(获得银子,"回收")
					提示=true
				end
		elseif self.数据[道具id].名称=="怪物卡片" then
				local djdj = self.数据[道具id].等级 or 1
				if djdj >=7 then
					return
				end
				if Q_选项回收价格.怪物卡片[djdj] ~= nil then
					获得银子 = Q_选项回收价格.怪物卡片[djdj]
					玩家数据[self.数字id].角色:添加银子(获得银子,"回收")
					提示=true
				end
		elseif self.数据[道具id].名称=="高级清灵仙露" then
				local lq = self.数据[道具id].灵气 or 1
				获得银子 = 1000000
				if lq == 8 then
					获得银子 = 15000000
				end
				if self.数据[道具id].可叠加 then
          获得银子 = 获得银子 * self.数据[道具id].数量
        end
				玩家数据[self.数字id].角色:添加银子(获得银子,"回收")
				提示=true
		else
		    local Q_直接回收 = 玩家数据[id].自动回收:取Q_直接回收()
            for k,v in pairs(Q_直接回收) do
                if v.名称 == self.数据[道具id].名称 then
                        获得银子 = v.价格
                        if self.数据[道具id].可叠加 then
                        	获得银子 = 获得银子 * self.数据[道具id].数量
                        end
                        玩家数据[self.数字id].角色:添加银子(获得银子,"回收")
                        提示=true
                    break
                end
            end
		end
		if 提示 then
			消息提示(id,"#W/自动回收#Y/" ..self.数据[道具id].名称 .."#W/获得#R/" ..获得银子 .."#W/两银子。")
			for k,v in pairs(玩家数据[id].角色.道具) do
				if v == 道具id then
					玩家数据[id].角色.道具[k] = nil
					break
				end
	    end
			self.数据[道具id] = nil
			道具刷新(id)
		end
end

function 道具处理类:整理临时行囊(id,类型,参数)---整理xxxxxx

 local id = id + 0
  local function 简易排序(a,b)
    return a.序号<b.序号
  end
    if 玩家数据[id].整理背包 ~= nil then
        if os.time()-玩家数据[id].整理背包 <= 10 then
            常规提示(id,"不要频繁点击整理请"..(10-(os.time()-玩家数据[id].整理背包)).."秒后再尝试！",多角色)
            return
        end
    end
    玩家数据[id].整理背包=os.time()
    local data = {}
    for k,v in pairs(玩家数据[id].角色.临时行囊[类型]) do
      local 字符编码=string.byte(string.sub(self.数据[v].名称,1,2))
      字符编码=字符编码+#self.数据[v].名称
      字符编码=字符编码+0
      data[#data+1]={内容=v,序号=字符编码}
      if self.数据[v].数量~=nil and self.数据[v].数量<99999999 and self.数据[v].名称 ~="制造指南书" and self.数据[v].名称 ~="百炼精铁" then
        for i,n in pairs(玩家数据[id].角色.临时行囊[类型]) do
          if k~=i and  self.数据[n] ~= nil and self.数据[v] ~= nil and  self.数据[n].名称==self.数据[v].名称 and self.数据[n].数量~=nil
          	and self.数据[v].数量+self.数据[n].数量<99999999    then
            if self.数据[v].名称 == "高级清灵仙露" and self.数据[n].名称 == "高级清灵仙露" then
              if self.数据[v].灵气 ==  self.数据[n].灵气  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
            elseif self.数据[v].名称 == "中级清灵仙露" and self.数据[n].名称 == "中级清灵仙露" then
              if self.数据[v].灵气 ==  self.数据[n].灵气  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
            elseif self.数据[v].名称 == "初级清灵仙露" and self.数据[n].名称 == "初级清灵仙露" then
              if self.数据[v].灵气 ==  self.数据[n].灵气  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

           elseif self.数据[v].名称 == "元宵" and self.数据[n].名称 == "元宵" then
              if self.数据[v].参数 ==  self.数据[n].参数  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
              elseif self.数据[v].名称 == "水晶元宵" and self.数据[n].名称 == "水晶元宵" then
              if self.数据[v].参数 ==  self.数据[n].参数  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end


        elseif self.数据[v].名称 == "黑宝石" and self.数据[n].名称 == "黑宝石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
        elseif self.数据[v].名称 == "月亮石" and self.数据[n].名称 == "月亮石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

        elseif self.数据[v].名称 == "红玛瑙" and self.数据[n].名称 == "红玛瑙" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

        elseif self.数据[v].名称 == "舍利子" and self.数据[n].名称 == "舍利子" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

        elseif self.数据[v].名称 == "太阳石" and self.数据[n].名称 == "太阳石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
        elseif self.数据[v].名称 == "光芒石" and self.数据[n].名称 == "光芒石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
        elseif self.数据[v].名称 == "速度精魄灵石" and self.数据[n].名称 == "速度精魄灵石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
        elseif self.数据[v].名称 == "气血精魄灵石" and self.数据[n].名称 == "气血精魄灵石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

        elseif self.数据[v].名称 == "灵力精魄灵石" and self.数据[n].名称 == "灵力精魄灵石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
        elseif self.数据[v].名称 == "躲避精魄灵石" and self.数据[n].名称 == "躲避精魄灵石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
        elseif self.数据[v].名称 == "防御精魄灵石" and self.数据[n].名称 == "防御精魄灵石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
        elseif self.数据[v].名称 == "伤害精魄灵石" and self.数据[n].名称 == "伤害精魄灵石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
        elseif self.数据[v].名称 == "星辉石" and self.数据[n].名称 == "星辉石" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end

          elseif self.数据[v].名称 == "钟灵石" and self.数据[n].名称 == "钟灵石" then
              if self.数据[v].技能 ==  self.数据[n].技能  and self.数据[v].等级 ==  self.数据[n].等级 then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
          elseif self.数据[v].名称 == "钨金" and self.数据[n].名称 == "钨金" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
          elseif self.数据[v].名称 == "附魔宝珠" and self.数据[n].名称 == "附魔宝珠" then
              if self.数据[v].等级 ==  self.数据[n].等级  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
          elseif  self.数据[v].名称 == "魔兽要诀" and self.数据[n].名称 == "魔兽要诀" then
                if self.数据[v].附带技能 ==  self.数据[n].附带技能  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
          elseif  self.数据[v].名称 == "高级魔兽要诀" and self.数据[n].名称 == "高级魔兽要诀" then
              if self.数据[v].附带技能 ==  self.数据[n].附带技能  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
          elseif  self.数据[v].名称 == "特殊魔兽要诀" and self.数据[n].名称 == "特殊魔兽要诀" then
              if self.数据[v].附带技能 ==  self.数据[n].附带技能  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
          elseif  self.数据[v].名称 == "超级魔兽要诀" and self.数据[n].名称 == "超级魔兽要诀" then
              if self.数据[v].附带技能 ==  self.数据[n].附带技能  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
          elseif  self.数据[v].名称 == "召唤兽内丹" and self.数据[n].名称 == "召唤兽内丹" then
              if self.数据[v].特效 ==  self.数据[n].特效  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end
          elseif  self.数据[v].名称 == "高级召唤兽内丹" and self.数据[n].名称 == "高级召唤兽内丹" then
              if self.数据[v].特效 ==  self.数据[n].特效  then
                self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
                self.数据[n]=nil
                玩家数据[id].角色.临时行囊[类型][i]=nil
              end


            else
             self.数据[v].数量=self.数据[v].数量+self.数据[n].数量
             self.数据[n]=nil
             玩家数据[id].角色.临时行囊[类型][i]=nil
            end

        end
      end
    end
  end
    table.sort(data,简易排序)
    local tabdata={}
    for k,v in pairs(data) do
      tabdata[#tabdata+1]=v.内容
    end
    玩家数据[id].角色.临时行囊[类型]=tabdata
    常规提示(id,"整理成功")
    玩家数据[id].整理时间=os.time() + 5
    发送数据(玩家数据[id].连接id,3555,self:索要临时行囊(id,类型,参数))
end
function 道具处理类:系统给予处理(连接id,id,数据)
	local 事件=玩家数据[id].给予数据.事件
	local 临时NPC=玩家数据[id].给予数据.临时NPC
	local 任务编号=玩家数据[id].给予数据.任务编号
	local 类型 = 数据.类型
	if 事件 ~= nil and 事件~="法宝补充灵气" and  (数据.格子[1]==nil or 玩家数据[id].角色[类型][数据.格子[1]]==nil or self.数据[玩家数据[id].角色[类型][数据.格子[1]]]==nil) then
		常规提示(id,"#Y/你没有这样的道具")
		return
	end
	if 事件=="打造角色装备" then
		local 任务id=玩家数据[id].角色:取任务(5)
		if 任务id==0 then
			常规提示(id,"#Y/你没有这样的任务")
			return
		end
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].名称~=任务数据[任务id].石头 then
			常规提示(id,"#Y/对方需要的不是这种物品")
			return
		end
		if 任务数据[任务id].数量>1 and self.数据[道具id].数量<任务数据[任务id].数量 then
			常规提示(id,"#Y/该物品的数量无法达到要求")
			return
		end
		if 任务数据[任务id].数量>1 then
			self.数据[道具id].数量=self.数据[道具id].数量-任务数据[任务id].数量
		end
		if self.数据[道具id].数量==nil or self.数据[道具id].数量<=0 then
			self.数据[道具id]=nil
			玩家数据[id].角色[类型][数据.格子[1]]=nil
		end
		if 任务数据[任务id].打造类型=="装备" then
			装备处理类:添加强化打造装备(id,任务id)
		elseif 任务数据[任务id].打造类型=="神兵苏醒" then
			装备处理类:打造160神兵(id,任务id)
		elseif 任务数据[任务id].打造类型=="灵饰" then
			local 临时道具 = self:灵饰处理(id,任务数据[任务id].名称,任务数据[任务id].级别,1,任务数据[任务id].部位)
			临时道具.制造者 = 任务数据[任务id].制造者
			if self:给予道具(id,nil,nil,nil,nil,nil,临时道具) then
				玩家数据[id].角色:取消任务(任务id)
				任务数据[任务id]=nil
			end
		end
		return


elseif 事件 == '铸斧(乾)' or 事件 == '铸斧(坤)' then
		  local 道具id = 玩家数据[id].角色.道具[数据.格子[1]]
			if self.数据[道具id].总类 ~= 2 or self.数据[道具id].分类 ~= 3 or self.数据[道具id].子类 == 910 then
				添加最后对话(id, "#Y/你交给我的是什么鬼东西？！")
				return
			else
				if 玩家数据[id].角色.门派 ~= "九黎城" then
					if not 玩家数据[id].角色:扣除银子(1000000, 0, 0, "转换九黎副武器", 1) then
						return
					end
				end

				local aa = {"顽石双斧", "镔铁双斧", "黑曜双斧", "枭首双斧", "破军双斧", "隳城双戚", "飞头蛮", "竹叶青", "鲛煞", "啖月", "义战", "恶来", "烬世野火", "九州海沸", "八狱末劫", "罗喉计都", "非天"}
				local 武器名称 = aa[self.数据[道具id].级别限制 / 10 + 1]
				self.数据[道具id].原始造型 = self.数据[道具id].名称

				if 事件 == "铸斧(乾)" then
					武器名称 = 武器名称 .. "(乾)"
					self.数据[道具id].名称 = 武器名称
					添加最后对话(id, "#W/我已将这把#Y" .. self.数据[道具id].原始造型 .. "#重铸成#Y" .. 武器名称 .. "#、怎么样，我的铸兵术厉害吧！")
				else
					武器名称 = 武器名称 .. "(坤)"
					self.数据[道具id].临时附魔=nil
					self.数据[道具id].名称 = 武器名称
					添加最后对话(id, "#W/我已将这把#Y" .. self.数据[道具id].原始造型 .. "#重铸成#Y" .. 武器名称 .. "#、怎么样，我的铸兵术厉害吧！")
				end
				self.数据[道具id].名称 = 武器名称

				if self.数据[道具id].光武拓印 then
					self.数据[道具id].原始光武拓印 = self.数据[道具id].光武拓印
					self.数据[道具id].光武拓印 = nil
				end

				local sj = 取物品数据(self.数据[道具id].名称)
				self.数据[道具id].原始子类 = self.数据[道具id].子类 + 0
				self.数据[道具id].分类 = sj[3]
				self.数据[道具id].子类 = sj[4]
				self.数据[道具id].角色限制 = sj[7]

				if (self.数据[道具id].伤害 or 0) == 0 then
					self.数据[道具id].伤害 = 1
				end

				if (self.数据[道具id].命中 or 0) == 0 then
					self.数据[道具id].命中 = 1
				end

				if self.数据[道具id].分类 == 4 then
					self.数据[道具id].防御 = self.数据[道具id].防御 or 0
				end

				常规提示(id, "#Y/你获得了#P" .. 武器名称)
				self:索要道具更新(id,'道具')
			end
		elseif 事件 == '还原武器' then
		  local 道具id = 玩家数据[id].角色.道具[数据.格子[1]]
			if self.数据[道具id].总类 ~= 2 or (self.数据[道具id].分类 ~= 4 or self.数据[道具id].子类 ~= 911) and (self.数据[道具id].分类 ~= 3 or self.数据[道具id].子类 ~= 910) or self.数据[道具id].原始造型 == nil then
				添加最后对话(id, "#Y/你交给我的是什么鬼东西？！")
				return
			else
				if 玩家数据[id].角色.门派 ~= "九黎城" then
					if not 玩家数据[id].角色:扣除银子(1000000, 0, 0, "九黎副武器还原", 1) then
						return
					end
				end
				添加最后对话(id, "#W/我已将这把#Y" .. self.数据[道具id].名称 .. "#重铸成#Y" .. self.数据[道具id].原始造型 .. "#、怎么样，我的铸兵术厉害吧！")
				self.数据[道具id].名称 = self.数据[道具id].原始造型 .. ""
				self.数据[道具id].光武拓印 = self.数据[道具id].原始光武拓印
				self.数据[道具id].原始造型 = nil
				if self.数据[道具id].防御 == 0 then
					self.数据[道具id].防御 = nil
				end
				self.数据[道具id].分类 = 3
				local sj = 取物品数据(self.数据[道具id].名称)
				self.数据[道具id].子类 = sj[4] + 0
				if (self.数据[道具id].伤害 or 0) == 0 then
					self.数据[道具id].伤害 = 1
				end
				if (self.数据[道具id].命中 or 0) == 0 then
					self.数据[道具id].命中 = 1
				end
				self.数据[道具id].角色限制 = sj[7]
				常规提示(id, "#Y/你获得了#P" .. self.数据[道具id].名称)
				self:索要道具更新(id,'道具')
			end
	elseif 事件=="购买玩家打造" then
		if 数据.格子[1] == nil or 数据.格子[2] == nil then
			常规提示(id,"#Y/请放入你要打造的书和铁")
			return
		elseif 玩家数据[id].给予数据 == nil or 玩家数据[id].给予数据.制造数据 == nil then
			常规提示(id,"#Y/数据错误请重新购买操作")
			return
		end
		装备处理类:摊位打造装备(id,数据)
		return
	elseif 临时NPC~=nil then
		-- 玩家数据[玩家id].给予数据={类型=1,临时NPC="竹罗汉",物品="包子",任务id=任务id}
		if 任务数据[玩家数据[id].给予数据.任务id]==nil then
			return
		end
		local 任务id=玩家数据[id].给予数据.任务id
		local 物品名称=玩家数据[id].给予数据.物品
		local NPC名称=任务数据[任务id].名称
		if 临时NPC==NPC名称 then
			local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
			if self.数据[道具id].名称==物品名称 then
				if self.数据[道具id].数量~=nil and self.数据[道具id].数量>1 then
					self.数据[道具id].数量 = self.数据[道具id].数量 -1
				else
					self.数据[道具id]=nil
					玩家数据[id].角色[类型][数据.格子[1]]=nil
				end
				if 临时NPC=="竹罗汉" and 事件 == "副本五更寒给予签文" then
					local 副本id = 任务处理类:取副本id(id,670)
					if 副本id == 0 or 副本id ~= id  then
						return
					end
					副本数据.如梦奇谭之五更寒.进行[id].阶段=1
					刷新任务670(id)
				end
			else
				添加最后对话(id,"你要给我什么？")
			end
			return

		elseif 任务数据[任务id].神器NPC and  任务数据[任务id].神器NPC==临时NPC then --314更新
			local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
			--玩家数据[数字id].给予数据={类型=1,临时NPC="陆云鹤",地图=1002,物品="墨魂灯",任务id=任务id,事件=self.任务标题}
			if self.数据[道具id].名称==物品名称 then
				local 事件=玩家数据[id].给予数据.事件
				if 事件=="墨魂笔之踪" then
					if 墨魂笔之踪:更新神器进度(id) then
						if self.数据[道具id].数量~=nil and self.数据[道具id].数量>1 then
							self.数据[道具id].数量 = self.数据[道具id].数量 -1
						else
							self.数据[道具id]=nil
							玩家数据[id].角色[类型][数据.格子[1]]=nil
						end
					end
				end
			else
				添加最后对话(id,"你要给我什么？")
			end
			return
		end
	-- elseif 事件=="墨魂笔之踪" or 事件=="神归昆仑镜"  then --314更新
	-- 	local dj={}
	-- 	local num=0
	-- 	local 名称=玩家数据[id].给予数据.需求物品.名称
	-- 	local 数量=玩家数据[id].给予数据.需求物品.数量
	-- 	for i=1,数量 do
	-- 		if 数据.格子[i]~=nil then
	-- 			dj[i]=玩家数据[id].角色[类型][数据.格子[i]]
	-- 			if self.数据[dj[i]]==nil then
	-- 				添加最后对话(id,"#45#45#45")
	-- 				return
	-- 			end
	-- 			if self.数据[dj[i]].名称~=名称 then
	-- 				添加最后对话(id,"一次性给物品#G"..数量.."颗"..名称.."#W吧")
	-- 				return
	-- 			end
	-- 			num=num+1
	-- 		else
	-- 			添加最后对话(id,"一次性给物品#G"..数量.."颗"..名称.."#W吧")
	-- 			return
	-- 		end
	-- 	end
	-- 	if num==数量 then
	-- 		for i=1,数量 do
	-- 			self.数据[dj[i]]=nil
	-- 			玩家数据[id].角色[类型][数据.格子[i]]=nil
	-- 		end
	-- 		if 事件=="墨魂笔之踪" then
	-- 			墨魂笔之踪:更新神器进度(id)
	-- 		elseif 事件=="神归昆仑镜" then
	-- 			神归昆仑镜:更新神器进度(id)
	-- 		end

	-- 	end
	-- 	玩家数据[id].给予数据=nil
	-- 	self:索要道具更新(id,类型)
	elseif 事件=="上交心魔宝珠" then
		if 玩家数据[id].角色.等级>=100 then
			常规提示(id,"#Y/你已经脱离了新手阶段，无法获得此种奖励")
			return
		elseif 玩家数据[id].角色.等级<15 then
			常规提示(id,"#Y/只有等级达到15级的玩家才可获得此种奖励")
			return
		elseif 心魔宝珠[id]~=nil and 心魔宝珠[id]>=20 then
			常规提示(id,"#Y/请明天再来上交心魔宝珠")
			return
		end
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		local 名称="心魔宝珠"
		local 数量=20
		if self.数据[道具id].名称~=名称 then
			常规提示(id,"#Y/对方需要的不是这种物品")
			return
		end
		if 数量>1 and self.数据[道具id].数量<数量 then
			常规提示(id,"#Y/该物品的数量无法达到要求")
			return
		end
		if 数量>1 then
			self.数据[道具id].数量=self.数据[道具id].数量-数量
		end
		if self.数据[道具id].数量==nil or self.数据[道具id].数量<=0 then
			self.数据[道具id]=nil
			玩家数据[id].角色[类型][数据.格子[1]]=nil
		end
		local 等级=取等级(id)
		local 经验=等级*等级+3000
		local 储备=等级*200
		玩家数据[id].角色:添加经验(经验,"心魔宝珠奖励")
		玩家数据[id].角色:添加银子(储备,"心魔宝珠奖励",1)
		if 心魔宝珠[id]==nil then
			心魔宝珠[id]=1
		else
			心魔宝珠[id]=心魔宝珠[id]+1
		end
		常规提示(id,format("#Y/你本日还可领取#R/%s#Y/次奖励",(20-心魔宝珠[id])))
		self:索要道具更新(id,类型)
	elseif 事件=="降妖伏魔给予包子" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].名称=="包子" then
			if self.数据[道具id].数量~=nil and self.数据[道具id].数量>1 then
				self.数据[道具id].数量 = self.数据[道具id].数量 -1
			else
				self.数据[道具id]=nil
				玩家数据[id].角色[类型][数据.格子[1]]=nil
			end
			降妖伏魔:完成饿鬼(id,玩家数据[id].给予数据.任务id)
		else
			添加最后对话(id,"你给我什么玩意儿，忽悠鬼呢？")
		end
		return
	elseif 事件=="转换武器造型" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].总类==2 and self.数据[道具id].分类 == 3  then
			if 武器转换临时数据[id]~= nil then
				if not 玩家数据[id].角色:扣除银子(5000000,0,0,"转换武器造型",1) and not 玩家数据[id].角色.武神坛角色 then --武神坛
					return 添加最后对话(id,"需要支付500W两银子才可以转换此类道具")
				end
				local 序列 = 1
				local 等级 = self.数据[道具id].级别限制
				if 等级 <= 80 then
					序列 = 等级/10 + 1
				elseif 等级<= 110 then
					序列 = 取随机数(10,12)
				elseif 等级<= 140 then
					序列 = 取随机数(13,15)
				elseif 等级<= 150 then
					序列 = 16
				else
					序列 = 17
				end
				self.数据[道具id].名称 = 武器表[武器转换临时数据[id]][序列]
				local 临时武器数据 = 取物品数据(self.数据[道具id].名称)
				self.数据[道具id].子类 = 临时武器数据[4]
				self.数据[道具id].角色限制 = 临时武器数据[7]
				道具刷新(id)
				添加最后对话(id,"转换成功！")
			else
				添加最后对话(id,"转换失败，请重试！")
			end
		else
			添加最后对话(id,"你给我什么玩意儿？")
		end
		return
	elseif 事件=="转换装备" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].总类==2 then
			local 子类=self:取武器类型(玩家数据[id].给予数据.转换造型)
			玩家数据[id].角色:转换装备操作(id,self.数据[道具id],子类)
		else
			添加最后对话(id,"请给我正确的装备")
		end
		return
	elseif 事件=="降妖伏魔给予酒" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].名称=="女儿红" or self.数据[道具id].名称=="虎骨酒" or self.数据[道具id].名称=="珍露酒"
			  or self.数据[道具id].名称=="梅花酒" or self.数据[道具id].名称=="百味酒" or self.数据[道具id].名称=="蛇胆酒" or self.数据[道具id].名称=="醉生梦死" then

			if self.数据[道具id].数量~=nil and self.数据[道具id].数量>1 then
				self.数据[道具id].数量 = self.数据[道具id].数量 -1
			else
				self.数据[道具id]=nil
				玩家数据[id].角色[类型][数据.格子[1]]=nil
			end
			降妖伏魔:完成酒鬼(id,玩家数据[id].给予数据.任务id)
		else
			添加最后对话(id,"你给我什么玩意儿，忽悠鬼呢？")
		end
		return

	elseif 事件=="上交暑假道具" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].名称 ~= "知了" and self.数据[道具id].名称 ~= "蟋蟀" and self.数据[道具id].名称 ~= "小螃蟹"  then
			常规提示(id,"#Y/对方需要的不是这种物品")
			return
		end
		local 数量 = 1
		if self.数据[道具id].数量~= nil then 数量 = self.数据[道具id].数量 end
		self.数据[道具id]=nil
		玩家数据[id].角色[类型][数据.格子[1]]=nil
		local 储备=20000*数量
		玩家数据[id].角色:添加银子(储备,"上交暑假道具",1)
		self:索要道具更新(id,类型)
	elseif 事件=="更换指南造型" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].名称 ~= "制造指南书" or self.数据[道具id].特效 > 18 then
			常规提示(id,"#Y/只有武器类的指南书才可以更换")
			return
		end
		if 玩家数据[id].角色.银子 < self.数据[道具id].子类 *10000 then
			常规提示(id,"#Y/你的银两不足")
			return
		end
		if 玩家数据[id].角色:扣除银子(self.数据[道具id].子类 *10000,0,0,"更换指南造型",1) and 玩家数据[id].角色:扣除仙玉(100, "更换指南造型", id) then
			self.数据[道具id].特效=取随机数(1,18)
			self:索要道具更新(id,类型)
		end
	elseif 事件=="指南2换1" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		local 道具id2=玩家数据[id].角色[类型][数据.格子[2]]
		if 数据.格子[1]==nil or 数据.格子[2]==nil then
			常规提示(id,"#Y/物品数据错误请重新放置")
			return
		end
		if self.数据[道具id].子类 ~= self.数据[道具id2].子类 then
			常规提示(id,"两本书的等级不一样无法更换")
			return
		end
		if self.数据[道具id].名称 ~= "制造指南书" or self.数据[道具id2].名称 ~= "制造指南书" then
			常规提示(id,"#Y/只有制造指南书才能换")
			return
		end
		self.数据[道具id].特效=取随机数(1,25)
		self.数据[道具id2]=nil
		玩家数据[id].角色[类型][数据.格子[2]]=nil
		self:索要道具更新(id,类型)
		常规提示(id,"#Y/您的指南更换成功请查看背包")

    elseif 事件=="神兜兜增加成长" then
	   local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
	   local 编号=玩家数据[id].角色:取参战宝宝编号()
	   if 编号==0 then
		添加最后对话(id,"请先将宝宝参战！")
		return
	elseif  玩家数据[id].召唤兽.数据[编号].成长>=1.35 then
		添加最后对话(id,"这只宝宝已经无法再次增加了")
		return
	elseif self.数据[道具id].名称~="神兜兜" then
		添加最后对话(id,"增加宝宝成长需要消耗神兜兜")
		return
	elseif self.数据[道具id].数量< 199 then
		添加最后对话(id,"神兜兜数量不足，需要199个")
		return
	end
	玩家数据[id].召唤兽.数据[编号].成长=玩家数据[id].召唤兽.数据[编号].成长+0.05
	if 玩家数据[id].召唤兽.数据[编号].成长 > 1.35 then
		玩家数据[id].召唤兽.数据[编号].成长 = 1.35
	end
		玩家数据[id].道具:删除道具(连接id,id,"道具",道具id,数据.格子[1],199)
		添加最后对话(id,"增加召唤兽成长成功！")
	elseif 事件=="解除装备专用" then
		if 玩家数据[id].角色.武神坛角色 then
			常规提示(id,"#Y/武神坛角色滚")
			return
		end
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].总类 ~= 2 then
			常规提示(id,"#Y/只有装备才可以使用该功能")
			return
		end
		if self.数据[道具id].专用 == nil then
			常规提示(id,"#Y/这件装备不需要解除")
			return
		end
		if 玩家数据[id].角色:扣除银子(5000000,0,0,"装备解除专用",1) then
			self.数据[道具id].专用=nil
			常规提示(id,"#Y/解除专用成功")
		else
	    		常规提示(id,"#Y/该功能需要500万银两")
		end

	elseif 事件=="裁缝/炼金熟练度" or 事件=="打造/淬灵熟练度" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].名称 ~= "制造指南书" then
			if self.数据[道具id].名称 ~= "百炼精铁" then
				常规提示(id,"#Y/我不需要这个东西")
				return
			end
		end
		if 事件=="裁缝/炼金熟练度"  then
			玩家数据[id].角色:增加生活技能熟练("裁缝技巧",self.数据[道具id].子类/10)
			消息提示(id,"#Y/你上交了#R/制造指南书#Y/熟练度增加了#R"..self.数据[道具id].子类/10)
		else
			玩家数据[id].角色:增加生活技能熟练("打造技巧",self.数据[道具id].子类/10)
			消息提示(id,"#Y/你上交了#R/百炼精铁#Y/熟练度增加了#R/"..self.数据[道具id].子类/10)
		end
		self.数据[道具id]=nil
		玩家数据[id].角色[类型][数据.格子[1]]=nil
		self:索要道具更新(id,类型)
	elseif 事件=="我来归还勾魂索。" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].名称 ~= "无常勾魂索" then
			常规提示(id,"#Y/你给我的是什么玩意儿？")
			return
		end
		self.数据[道具id]=nil
		玩家数据[id].角色[类型][数据.格子[1]]=nil
		玩家数据[id].已扣除勾魂索=nil --购买后上交，会清空一次这个东西 不然出问题很麻烦
		玩家数据[id].勾魂索中=nil --购买后上交，会清空一次这个东西 不然出问题很麻烦
		self:索要道具更新(id,类型)
		玩家数据[id].角色:添加银子(5000000,"归还勾魂索",1)
	elseif 事件=="官职任务上交物品" then
		local 任务id=玩家数据[id].角色:取任务(110)
		if 任务id==0 or 任务数据[任务id]==nil then
			常规提示(id,"#Y/你没有这样的任务")
			return
		end
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		local 名称="？？？"
		if 任务数据[任务id].分类==3 then
			名称="情报"
		elseif 任务数据[任务id].分类==4 then
			名称=任务数据[任务id].物品
		end
		if self.数据[道具id].名称~=名称 then
			常规提示(id,"#Y/对方需要的不是这种物品")
			return
		end
		if self.数据[道具id].数量 and self.数据[道具id].数量 >=2 then
			self.数据[道具id].数量 = self.数据[道具id].数量-1
		else
		self.数据[道具id]=nil
		玩家数据[id].角色[类型][数据.格子[1]]=nil
		end
		完成任务_110(id,任务数据[任务id].分类)
		self:索要道具更新(id,类型)
	elseif 事件=="门派任务上交物品" then
		local 任务id=玩家数据[id].角色:取任务(111)
		if 任务id==0 or 任务数据[任务id]==nil then
			常规提示(id,"#Y/你没有这样的任务")
			return
		end
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		local 名称=任务数据[任务id].物品
		if self.数据[道具id].名称~=名称 then
			常规提示(id,"#Y/对方需要的不是这种物品")
			return
		end
		local 双倍
		if 任务数据[任务id].品质~=nil and self.数据[道具id].阶品>=任务数据[任务id].品质 then
			双倍=1
		end
		if  self.数据[道具id].数量~=nil and self.数据[道具id].数量 >=2 then
			self.数据[道具id].数量 = self.数据[道具id].数量-1
		else
		self.数据[道具id]=nil
		玩家数据[id].角色[类型][数据.格子[1]]=nil
		end
		完成任务_111(id,4,双倍)
		self:索要道具更新(id,类型)
	elseif 事件=="门派任务上交乾坤袋" then
		local 任务id=玩家数据[id].角色:取任务(111)
		if 任务id==0 or 任务数据[任务id]==nil then
			常规提示(id,"#Y/你没有这样的任务")
			return
		end
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		local 名称="乾坤袋"
		if self.数据[道具id].名称~=名称 then
			常规提示(id,"#Y/对方需要的不是这种物品")
			return
		elseif 任务数据[任务id].乾坤袋==nil then
			常规提示(id,"#Y/你似乎还没有完成这个任务哟~")
			return
		end
		self.数据[道具id]=nil
		玩家数据[id].角色[类型][数据.格子[1]]=nil
		完成任务_111(id,7,双倍)
		self:索要道具更新(id,类型)

	elseif 事件=="偷偷怪上交物品" then
		return
	elseif 事件=="低内丹二换一" then
		local dj={}
		local num=0
		for i=1,2 do
			if 数据.格子[i]~=nil then
				dj[i]=玩家数据[id].角色[类型][数据.格子[i]]
				if self.数据[dj[i]]==nil then
					添加最后对话(id,"#45#45#45")
					return
				end
				if self.数据[dj[i]].名称~="召唤兽内丹" then
					添加最后对话(id,"一次性给两颗你想兑换的#Y“召唤兽内丹”#W即可兑换一颗新的召唤兽内丹")
					return
				end
				num=num+1
			else
				添加最后对话(id,"一次性给两颗你想兑换的#Y“召唤兽内丹”#W即可兑换一颗新的召唤兽内丹")
				return
			end
		end
		if num==2 then
			for i=1,2 do
				self.数据[dj[i]]=nil
				玩家数据[id].角色[类型][数据.格子[i]]=nil
			end
			self:给予道具(id,"召唤兽内丹")
			添加最后对话(id,"嗯嗯~不错不错~#Y1颗召唤兽内丹#W已经放进你的兜兜里啦~#109")
		end
		玩家数据[id].给予数据=nil
		self:索要道具更新(id,类型)
	elseif 事件=="高内丹三换一" then
		local dj={}
		local num=0
		for i=1,3 do
			if 数据.格子[i]~=nil then
				dj[i]=玩家数据[id].角色[类型][数据.格子[i]]
				if self.数据[dj[i]]==nil then
					添加最后对话(id,"#45#45#45")
					return
				end
				if self.数据[dj[i]].名称~="高级召唤兽内丹" then
					添加最后对话(id,"一次性给三颗你想兑换的#Y“高级召唤兽内丹”#W即可兑换一颗新的高级召唤兽内丹")
					return
				end
				num=num+1
			else
				添加最后对话(id,"一次性给三颗你想兑换的#Y“高级召唤兽内丹”#W即可兑换一颗新的高级召唤兽内丹")
				return
			end
		end
		if num==3 then
			for i=1,3 do
				self.数据[dj[i]]=nil
				玩家数据[id].角色[类型][数据.格子[i]]=nil
			end
			self:给予道具(id,"高级召唤兽内丹")
			添加最后对话(id,"嗯嗯~不错不错#Y1颗高级召唤兽内丹#W已经放进你的兜兜里啦~#109")
		end
		玩家数据[id].给予数据=nil
		self:索要道具更新(id,类型)
	elseif 事件=="高兽诀三换一" then
		local dj={}
		local num=0
		for i=1,3 do
			if 数据.格子[i]~=nil then
				dj[i]=玩家数据[id].角色[类型][数据.格子[i]]
				if self.数据[dj[i]]==nil then
					添加最后对话(id,"#45#45#45")
					return
				end
				if self.数据[dj[i]].名称~="高级魔兽要诀" then
					添加最后对话(id,"一次性给三本你想兑换的#Y“高级魔兽要诀”#W即可兑换一本新的高级魔兽要诀")
					return
				end
				num=num+1
			else
				添加最后对话(id,"一次性给三本你想兑换的#Y“高级魔兽要诀”#W即可兑换一本新的高级魔兽要诀")
				return
			end
		end
		if num==3 then
			for i=1,3 do
				self.数据[dj[i]]=nil
				玩家数据[id].角色[类型][数据.格子[i]]=nil
			end
			self:给予道具(id,"高级魔兽要诀")
			添加最后对话(id,"嗯嗯~不错不错#Y1本高级魔兽要诀#W已经放进你的兜兜里啦~#109")
		end
		玩家数据[id].给予数据=nil
		self:索要道具更新(id,类型)
	elseif 事件=="我要还原装备拓印" then
		local 道具1=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具1]==nil then
			玩家数据[id].给予数据=nil
			return
		end
		if self.数据[道具1].总类~=2 or self.数据[道具1].分类 ~= 3  then
			常规提示(id,"#Y/选择武器有误！")
			return
		end
		if self.数据[道具1].光武拓印 == nil then
			常规提示(id,"#Y/这把武器没有光武拓印啊？")
			return
		end
		local 原造型=self.数据[道具1].光武拓印.原名称
		self.数据[道具1].名称 = 原造型
		self.数据[道具1].光武拓印=nil
		玩家数据[id].给予数据=nil
		添加最后对话(id,"一阵金光闪过，你手中的这把武器变成了#Y"..原造型.."#W的造型#80。")
		self:索要道具更新(id,类型)

		elseif 事件=="器灵指定部位" then
		local dj={}
		local num=0
		if not 玩家数据[id].器灵部位 then
			添加最后对话(id,"#Y/数据出错，请重新选择#45#45#45")
			return
		end
		for i=1,3 do
			if 数据.格子[i]~=nil then
				dj[i]=玩家数据[id].角色[类型][数据.格子[i]]
				if self.数据[dj[i]]==nil then
					添加最后对话(id,"#45#45#45")
					return
				end
				if self.数据[dj[i]].名称~="器灵·无双" and  self.数据[dj[i]].名称~="器灵·金蝉" then
					添加最后对话(id,"一次性给三个你想兑换的#Y“相同属性器灵”#W即可兑换一个指定的器灵部位")
					return
				end
				if self.数据[dj[i]].名称~=self.数据[dj[1]].名称 then
					添加最后对话(id,"请给我#Y“相同属性”#W的器灵哦")
					return
				end
				if self.数据[dj[i]].级别限制~=self.数据[dj[1]].级别限制 then
					添加最后对话(id,"请给我#Y“相同等级”#W的器灵哦")
					return
				end

				num=num+1
			else
				添加最后对话(id,"一次性给三个你想兑换的#Y“相同属性器灵”#W即可兑换一个指定的器灵部位")
				return
			end
		end

		if num==3 then
			for i=2,3 do
				if dj[i]==dj[1] then return end
			end
			local 名称=self.数据[dj[1]].名称
			local 等级=self.数据[dj[1]].级别限制

			for i=1,3 do
				self.数据[dj[i]]=nil
				玩家数据[id].角色[类型][数据.格子[i]]=nil
			end
			self:给予道具(id,名称,等级,玩家数据[id].器灵部位)
			添加最后对话(id,"嗯嗯~不错不错~待我施展法力…@………~&，变#113#Y1个"..玩家数据[id].器灵部位.."部位的器灵#W已经放进你的兜兜里啦~#109")
		end
		玩家数据[id].器灵部位=nil
		玩家数据[id].给予数据=nil
		self:索要道具更新(id,类型)
		elseif 事件=="器灵升级等级" then
		local dj={}
		local num=0
		for i=1,3 do
			if 数据.格子[i]~=nil then
				dj[i]=玩家数据[id].角色[类型][数据.格子[i]]
				if self.数据[dj[i]]==nil then
					添加最后对话(id,"#45#45#45")
					return
				end
				if self.数据[dj[i]].名称~="器灵·无双" and  self.数据[dj[i]].名称~="器灵·金蝉" then
					添加最后对话(id,"一次性给三个你想兑换的#Y“相同等级器灵”#W即可兑换一个指定的器灵部位")
					return
				end
				-- if self.数据[dj[i]].名称~=self.数据[dj[1]].名称 then
				-- 	添加最后对话(id,"请给我#Y“相同属性”#W的器灵哦")
				-- 	return
				-- end
				if self.数据[dj[i]].级别限制>=160 then
					添加最后对话(id,"器灵等级最高为160级，无法进行进行提升哦")
					return
				end
				if self.数据[dj[i]].级别限制~=self.数据[dj[1]].级别限制 then
					添加最后对话(id,"请给我#Y“相同等级”#W的器灵哦")
					return
				end
				num=num+1
			else
				添加最后对话(id,"一次性给三个你想兑换的#Y“相同等级器灵”#W即可兑换一个指定的器灵部位")
				return
			end
		end

		if num==3 then
			for i=2,3 do
				if dj[i]==dj[1] then return end
			end
			local 名称=self.数据[dj[1]].名称
			local 等级=self.数据[dj[1]].级别限制+10
			for i=1,3 do
				self.数据[dj[i]]=nil
				玩家数据[id].角色[类型][数据.格子[i]]=nil
			end
			self:给予道具(id,名称,等级)
			添加最后对话(id,"嗯嗯~不错不错~待我施展法力…@………~&，变#113#Y1个"..等级.."级的器灵#W已经放进你的兜兜里啦~#109")
		end
		玩家数据[id].给予数据=nil
		self:索要道具更新(id,类型)
	elseif 事件=="增加神兽技能格子" then
		local 道具1=玩家数据[id].角色[类型][数据.格子[1]]
		local 道具2=玩家数据[id].角色[类型][数据.格子[2]]
		if self.数据[道具1]==nil or self.数据[道具2]==nil then
			玩家数据[id].给予数据=nil
			添加最后对话(id,"你得将“神兜兜”、需要附加技能的“兽诀”一起给我啊#24")
			return
		end
		local 名称1=self.数据[道具1].名称
		local 名称2=self.数据[道具2].名称
		local 兽诀,兜兜
		local sjgz=1
		if 名称1=="特殊魔兽要诀" or 名称1=="高级魔兽要诀"  then
			兽诀=道具1
		elseif 名称2=="特殊魔兽要诀" or 名称2=="高级魔兽要诀"  then
			兽诀=道具2
			sjgz=2
		end
		if 名称1=="神兜兜" then
			兜兜=道具1
		elseif 名称2=="神兜兜" then
			兜兜=道具2
		end
		if 兽诀~=nil and 兜兜~=nil and 兽诀~=兜兜 then
			local jn=self.数据[兽诀].附带技能
			if jn then
				local bh=玩家数据[id].角色:取参战宝宝编号()
				local xianzhi=24
				-- if 玩家数据[id].召唤兽.数据[bh].种类~="神兽" and RpbARGB.序列==2 then
				-- 	xianzhi=24
				-- end
				local 是否重复=0
				for i=1,#玩家数据[id].召唤兽.数据[bh].技能 do
					if 玩家数据[id].召唤兽.数据[bh].技能[i]==jn then
						常规提示(id,"这只宝宝已经学会了这个技能了。")
						return
					end
					if 玩家数据[id].召唤兽.数据[bh].技能[i]==zd then
						是否重复=i
					end
				end
				if #玩家数据[id].召唤兽.数据[bh].技能<xianzhi then
					if 玩家数据[id].召唤兽.数据[bh].打书次数==nil then
						玩家数据[id].召唤兽.数据[bh].打书次数=0
					end
					local num=99
					-- if 玩家数据[id].召唤兽.数据[bh].种类~="神兽" then
					-- num=159
					-- end
					if 玩家数据[id].道具:消耗背包道具(连接id,id,"神兜兜",num) then
						self.数据[兽诀]=nil
						玩家数据[id].角色[类型][数据.格子[sjgz]]=nil
						玩家数据[id].召唤兽.数据[bh].技能[#玩家数据[id].召唤兽.数据[bh].技能+1]=jn
						玩家数据[id].召唤兽.数据[bh].打书次数=玩家数据[id].召唤兽.数据[bh].打书次数+1
						常规提示(id,"#G恭喜，你的召唤兽领悟了新技能！#Y"..jn)
						道具刷新(id)
					else
						添加最后对话(id,"需要"..num.."个“神兜兜”才行哦。")
					end
				else
					添加最后对话(id,"只能对小于等于.."..xianzhi.."..技能的宝宝使用。")
				end
			end
		else
			添加最后对话(id,"除了“高级兽诀”或“特殊兽诀”以及“神兜兜”，其他东西我可不敢乱收！#83")
		end
		玩家数据[id].给予数据=nil
		return


	elseif 事件=="替换神兽技能" then
		local 道具1=玩家数据[id].角色[类型][数据.格子[1]]
		local 道具2=玩家数据[id].角色[类型][数据.格子[2]]
		if self.数据[道具1]==nil or self.数据[道具2]==nil then
			玩家数据[id].给予数据=nil
			添加最后对话(id,"你得将“神兜兜”和要替换的“兽诀”一起给我啊#24")
			return
		end
		local 名称1=self.数据[道具1].名称
		local 名称2=self.数据[道具2].名称
		local 兽诀,兜兜
		local sjgz=1
		if 名称1=="特殊魔兽要诀" or 名称1=="高级魔兽要诀"  then
			兽诀=道具1
		elseif 名称2=="特殊魔兽要诀" or 名称2=="高级魔兽要诀" then
			兽诀=道具2
			sjgz=2
		end
		if 名称1=="神兜兜" then
			兜兜=道具1
		elseif 名称2=="神兜兜" then
			兜兜=道具2
		end
		if 兽诀~=nil and 兜兜~=nil and 兽诀~=兜兜 then
			local zd=玩家数据[id].给予数据.替换技能
			local jn=self.数据[兽诀].附带技能
			if jn then
				local bh=玩家数据[id].角色:取参战宝宝编号()
				local jngz=0
				for i=1,#玩家数据[id].召唤兽.数据[bh].技能 do
					if 玩家数据[id].召唤兽.数据[bh].技能[i]==jn then
						常规提示(id,"这只宝宝已经学会了这个技能了。")
						return
					end
					if 玩家数据[id].召唤兽.数据[bh].技能[i]==zd then
						jngz=i
					end
				end
				if jngz~=0 then
					if 玩家数据[id].召唤兽.数据[bh].打书次数==nil then
						玩家数据[id].召唤兽.数据[bh].打书次数=0
					end
					local num=99
					-- if 玩家数据[id].召唤兽.数据[bh].种类~="神兽" then
					-- num=159
					-- end
					if 玩家数据[id].道具:消耗背包道具(连接id,id,"神兜兜",num) then
						self.数据[兽诀]=nil
						玩家数据[id].角色[类型][数据.格子[sjgz]]=nil
						玩家数据[id].召唤兽.数据[bh].技能[jngz]=jn
						玩家数据[id].召唤兽.数据[bh].打书次数=玩家数据[id].召唤兽.数据[bh].打书次数+1
						常规提示(id,"#G恭喜，您心爱的宝宝学会了新技能！")
						道具刷新(id)
					else
						添加最后对话(id,"需要"..num.."个“神兜兜”才行哦。")
					end
				end
			end
		else
			添加最后对话(id,"除了“高级兽诀”或“特殊兽诀”以及“神兜兜”，其他东西我可不敢乱收！")
		end
		玩家数据[id].给予数据=nil
		return


	elseif 事件=="替换超级技能" then
		local 道具1=玩家数据[id].角色[类型][数据.格子[1]]
		local 道具2=玩家数据[id].角色[类型][数据.格子[2]]
		if self.数据[道具1]==nil or self.数据[道具2]==nil then
			玩家数据[id].给予数据=nil
			添加最后对话(id,"你得将“神兜兜”和要替换的“兽诀”一起给我啊#24")
			return
		end
		local 名称1=self.数据[道具1].名称
		local 名称2=self.数据[道具2].名称
		local 兽诀,兜兜
		local sjgz=1
		if 名称1=="超级魔兽要诀" then
			兽诀=道具1
		elseif 名称2=="超级魔兽要诀" then
			兽诀=道具2
			sjgz=2
		end
		if 名称1=="神兜兜" then
			兜兜=道具1
		elseif 名称2=="神兜兜" then
			兜兜=道具2
		end
		if 兽诀~=nil and 兜兜~=nil and 兽诀~=兜兜 then
			local zd=玩家数据[id].给予数据.替换技能
			local jn=self.数据[兽诀].附带技能
			if jn then
				local bh=玩家数据[id].角色:取参战宝宝编号()
				local jngz=0
				for i=1,#玩家数据[id].召唤兽.数据[bh].技能 do
					if 玩家数据[id].召唤兽.数据[bh].技能[i]==jn then
						常规提示(id,"这只宝宝已经学会了这个技能了。")
						return
					end
					if 玩家数据[id].召唤兽.数据[bh].技能[i]==zd then
						jngz=i
					end
				end
				if jngz~=0 then
					if 玩家数据[id].召唤兽.数据[bh].打书次数==nil then
						玩家数据[id].召唤兽.数据[bh].打书次数=0
					end
					local num=999
					-- if 玩家数据[id].召唤兽.数据[bh].种类~="神兽" then
					-- num=159
					-- end
					if 玩家数据[id].道具:消耗背包道具(连接id,id,"神兜兜",num) then
						self.数据[兽诀]=nil
						玩家数据[id].角色[类型][数据.格子[sjgz]]=nil
						玩家数据[id].召唤兽.数据[bh].技能[jngz]=jn
						玩家数据[id].召唤兽.数据[bh].打书次数=玩家数据[id].召唤兽.数据[bh].打书次数+1
						常规提示(id,"#G恭喜，您心爱的宝宝学会了新技能！")
						道具刷新(id)
					else
						添加最后对话(id,"需要"..num.."个“神兜兜”才行哦。")
					end
				end
			end
		else
			添加最后对话(id,"除了“超级魔兽要诀”以及“神兜兜”，其他东西我可不敢乱收！")
		end
		玩家数据[id].给予数据=nil
		return



	elseif 事件=="无名野鬼上交物品" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		local 名称="特赦令牌"
		if self.数据[道具id].名称~=名称 then
			添加最后对话(id,"我需要的是特赦令牌，你给我的这个能当饭吃吗？")
			return
		end
		self.数据[道具id]=nil
		玩家数据[id].角色[类型][数据.格子[1]]=nil
		self:给予道具(id,"高级藏宝图")
		添加最后对话(id,"您可真是大好人啊，这块特赦令牌终于让我能离开这地狱了。我这里有一张高级藏宝图你拿去吧，就当你做好事的回报。")
		self:索要道具更新(id,类型)
	elseif 事件=="我帮你带来了驱邪扇芝" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].名称~="驱邪扇芝" then
			添加最后对话(id,"少侠别拿我开玩笑了……")
			return
		end
		self.数据[道具id]=nil
		玩家数据[id].角色[类型][数据.格子[1]]=nil
		self:索要道具更新(id,类型)
		完成任务_19(id)
	elseif 事件=="文墨门派送信" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].名称~="密信" then
			添加最后对话(id,"这不是我要的东西#55")
			return
		else
			self.数据[道具id]=nil
			玩家数据[id].角色[类型][数据.格子[1]]=nil
			self:索要道具更新(id,类型)
			战斗准备类:创建战斗(id,130040,玩家数据[id].角色:取任务(1163))
		end
		return
	elseif 事件=="上交锦盒" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		local 名称="金银锦盒"
		if self.数据[道具id].名称~=名称 then
			添加最后对话(id,"我需要的是金银锦盒，你给我的这个能当饭吃吗？")
			return
		end
		if 帮派数据[玩家数据[id].角色.BPBH] == nil then
			添加最后对话(id,"你没有帮派无法上交金银锦盒")
			return
		end
		local 数量 = qz(self.数据[道具id].数量 or 1)
		self.数据[道具id]=nil
		玩家数据[id].角色[类型][数据.格子[1]]=nil
		local 增加帮贡=数量*5
		local 增加帮派资金=数量*50000
		帮派数据[玩家数据[id].角色.BPBH].帮派资金.当前 = 帮派数据[玩家数据[id].角色.BPBH].帮派资金.当前+增加帮派资金
		帮派处理:增加当前内政(玩家数据[id].角色.BPBH,数量*2)
		if 帮派数据[玩家数据[id].角色.BPBH].帮派资金.当前> 50000000 then--帮派数据[玩家数据[id].角色.BPBH].帮派资金.上限 then
			帮派数据[玩家数据[id].角色.BPBH].帮派资金.当前=50000000--帮派数据[玩家数据[id].角色.BPBH].帮派资金.上限
		end
		添加帮贡(id,增加帮贡,"上限")
		广播帮派消息({内容="[金库总管]#G/"..玩家数据[id].角色.名称.."#Y/上交金银锦盒为帮派增加了帮派资金#R/"..增加帮派资金.."#Y/两银子。#93",频道="bp"},玩家数据[id].角色.BPBH)
		self:索要道具更新(id,类型)
	elseif 事件=="点化装备" then


	elseif 事件=="合成旗4" then --补充
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].总类~=11 or  self.数据[道具id].分类~=2 then
			常规提示(id,"#Y我只可以为合成旗补充次数哟。")
			return
		elseif self.数据[道具id].次数>=140 then
			常规提示(id,"#Y你的这个合成旗次数已经满了")
			return
		end
		local 编号=玩家数据[id].法宝id
		if 玩家数据[id].角色.法宝[编号]==nil or self.数据[玩家数据[id].角色.法宝[编号]]==nil or self.数据[玩家数据[id].角色.法宝[编号]].名称~="五色旗盒" then
			常规提示(id,"#Y你没有这样的法宝")
			return
		end
		local 灵气=140-self.数据[道具id].次数
		灵气=math.floor(灵气/5)
		if 灵气<1 then 灵气=1 end
		if 灵气>self.数据[玩家数据[id].角色.法宝[编号]].魔法 then
			常规提示(id,"#Y本次补充需要消耗#R"..灵气.."#Y点法宝灵气，你的法宝没有那么多的灵气")
			return
		end
		self.数据[玩家数据[id].角色.法宝[编号]].魔法=self.数据[玩家数据[id].角色.法宝[编号]].魔法-灵气
		self.数据[道具id].次数=140
		发送数据(连接id,38,{内容="你的法宝#R/五色旗盒#W/灵气减少了"..灵气.."点"})
		常规提示(id,"#Y补充成功！你的这个合成旗可使用次数已经恢复到140次了")
		self:索要道具更新(id,类型)
	elseif 事件=="合成旗" then
		local 道具id={}
		for n=1,#数据.格子 do
			if 数据.格子[n]~=nil  then
				道具id[n]=数据.格子[n]
				local 临时id=玩家数据[id].角色[类型][数据.格子[n]]
				if self.数据[临时id].总类~=11 and self.数据[临时id].分类~=1 then
					常规提示(id,"#Y只有导标旗才可以合成哟")
					return
				end
			end
		end
		if 玩家数据[id].合成旗序列==nil then
			玩家数据[id].合成旗序列={}
			for n=1,#道具id do
				local 临时id=玩家数据[id].角色[类型][道具id[n]]
				for i=1,#道具id do
					local 临时id1=玩家数据[id].角色[类型][道具id[i]]
					if i~=n and 临时id1==临时id then
						常规提示(id,"#Y合成的导标旗中存在重复导标旗")
						return
					elseif i~=n and self.数据[临时id].地图~=self.数据[临时id1].地图 then
						常规提示(id,"#Y合成的导标旗定标场景必须为同一个")
						return
					end
				end
			end
		else
			for n=1,#道具id do
				local 临时id=玩家数据[id].角色[类型][道具id[n]]
				if 玩家数据[id].合成旗序列.地图~=nil and 玩家数据[id].合成旗序列.地图~=self.数据[临时id].地图 then
					常规提示(id,"#Y只有#R"..取地图名称(玩家数据[id].合成旗序列.地图).."#Y的导标旗才可合成")
					return
				end
				for i=1,#道具id do
					local 临时id1=玩家数据[id].角色[类型][道具id[i]]
					if i~=n and 临时id1==临时id then
						常规提示(id,"#Y合成的导标旗中存在重复导标旗")
						return
					end
				end
				for i=1,#玩家数据[id].合成旗序列 do
					local 临时id1=玩家数据[id].角色[类型][玩家数据[id].合成旗序列[i]]
					if  临时id1==临时id then
						常规提示(id,"#Y合成的导标旗中存在重复导标旗")
						return
					end
				end
			end
		end
		local 编号=玩家数据[id].法宝id
		if 玩家数据[id].角色.法宝[编号]==nil or self.数据[玩家数据[id].角色.法宝[编号]]==nil or self.数据[玩家数据[id].角色.法宝[编号]].名称~="五色旗盒" then
			常规提示(id,"#Y你没有这样的法宝")
			return
		end
		local 上限=7
		if self.数据[玩家数据[id].角色.法宝[编号]].气血<=0 then
			上限=3
		elseif self.数据[玩家数据[id].角色.法宝[编号]].气血<=2 then
			上限=4
		elseif self.数据[玩家数据[id].角色.法宝[编号]].气血<=5 then
			上限=5
		elseif self.数据[玩家数据[id].角色.法宝[编号]].气血<=8 then
			上限=6
		elseif self.数据[玩家数据[id].角色.法宝[编号]].气血<=9 then
			上限=7
		end
		for n=1,#道具id do
			if #玩家数据[id].合成旗序列<上限 then
				if 玩家数据[id].合成旗序列.地图==nil then
					玩家数据[id].合成旗序列.地图=self.数据[玩家数据[id].角色[类型][道具id[n]]].地图
				end
				玩家数据[id].合成旗序列[#玩家数据[id].合成旗序列+1]=道具id[n]
			end
		end
		if #玩家数据[id].合成旗序列==上限 then
			local aa ="请选择超级合成旗的颜色："
			local xx={"绿色合成旗","蓝色合成旗","红色合成旗","白色合成旗","黄色合成旗",}
			发送数据(连接id,1501,{名称="五色旗盒",对话=aa,选项=xx})
			玩家数据[id].最后操作="合成旗3"
		else
			玩家数据[id].给予数据={类型=1,id=0,事件="合成旗"}
			发送数据(连接id,3530,{道具=玩家数据[id].道具:索要道具1(id),名称="五色旗盒",类型="法宝",等级="无"})
			玩家数据[id].最后操作="合成旗2"
			常规提示(id,format("#Y你已提交%s个导标旗，还需要提交%s个导标旗",#玩家数据[id].合成旗序列,上限-#玩家数据[id].合成旗序列))
		end
	elseif 事件=="装备出售" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].总类~=2 or self.数据[道具id].灵饰 or self.数据[道具id].分类==9 then
			添加最后对话(id,"我这里只收购人物装备哟，其它的破铜烂铁我可是不收滴哟。")
			return
		end
		玩家数据[id].出售装备=数据.格子[1]
		玩家数据[id].最后操作="出售装备"
		添加最后对话(id,format("你的这件#Y%s#W我将以#R%s#W两银子进行收购，请确认是否出售该装备？",self.数据[道具id].名称,self:取装备价格(道具id)),{"确认出售","我不卖了"})
	elseif 事件=="转换召唤兽饰品" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id] == nil then
			添加最后对话(id,"#24")
			return
		end
		if self.数据[道具id].总类==149 then
			if string.find(self.数据[道具id].名称,"进阶")~=nil then
				local mc=string.gsub(self.数据[道具id].名称,"进阶","")
				if 取饰品表1(mc) then
					self.数据[道具id].名称=mc
					发送数据(连接id,3699)
					常规提示(id,"转换成功！")
				else
					添加最后对话(id,"#17少侠，你给我的似乎不是召唤兽饰品哦？（或对应进阶召唤兽还未开放饰品）")
				end
			else
				local mc="进阶"..self.数据[道具id].名称
				if 取饰品表1(mc) then
					self.数据[道具id].名称=mc
					发送数据(连接id,3699)
					常规提示(id,"转换成功！")
				else
					添加最后对话(id,"#17少侠，你给我的似乎不是召唤兽饰品哦？（或对应进阶召唤兽还未开放饰品）")
				end
			end
		end
	elseif 事件=="法宝补充灵气" then
		local 道具id=玩家数据[id].角色.法宝[数据.格子[1]]
		if self.数据[道具id] == nil then
			添加最后对话(id,"只有法宝才可以补充灵气哟，你这个是什么玩意？")
			return
		end
		if self.数据[道具id].总类~=1000 then
			添加最后对话(id,"只有法宝才可以补充灵气哟，你这个是什么玩意？")
			return
		end
		local 价格=2000000
		if self.数据[道具id].分类==2 then
			价格=3500000
		elseif self.数据[道具id].分类==3 then
			价格=6000000
		end
		if 玩家数据[id].角色.银子<价格 then
			添加最后对话(id,"本次补充法宝灵气需要消耗"..价格.."两银子，你身上没有那么多的现金哟。")
			return
		end
		玩家数据[id].角色:扣除银子(价格,0,0,"补充法宝扣除，法宝名称为"..self.数据[道具id].名称,1)
		self.数据[道具id].魔法=取灵气上限(self.数据[道具id].分类)
		添加最后对话(id,"补充法宝灵气成功！")
	elseif 事件 == "青龙任务" then
		local 任务id=玩家数据[id].角色:取任务(301)
		if 任务id==0 then
			添加最后对话(id,"你没有这个任务！")
			return
		end
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].名称~=任务数据[任务id].物品  then
			添加最后对话(id,"我拿这个玩意用来干啥？")
			return
		end
		if self.数据[道具id].数量~=nil and self.数据[道具id].数量>0 then
			self.数据[道具id].数量=self.数据[道具id].数量-1
			if self.数据[道具id].数量<=0 then
				self.数据[道具id]=nil
				玩家数据[id].角色[类型][数据.格子[1]]=nil
			end
		else
			self.数据[道具id]=nil
			玩家数据[id].角色[类型][数据.格子[1]]=nil
		end
		self:索要道具更新(id,类型)
		帮派青龙玄武:完成青龙任务(任务id,id,任务数据[任务id].分类)
	elseif 事件 == "玄武任务" then
		local 任务id=玩家数据[id].角色:取任务(302)
		if 任务id==0 then
			添加最后对话(id,"你没有这个任务！")
			return
		end
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].名称~=任务数据[任务id].物品  then
			添加最后对话(id,"我拿这个玩意用来干啥？")
			return
		end
		if self.数据[道具id].数量~=nil and self.数据[道具id].数量>0 then
			self.数据[道具id].数量=self.数据[道具id].数量-1
			if self.数据[道具id].数量<=0 then
				self.数据[道具id]=nil
				玩家数据[id].角色[类型][数据.格子[1]]=nil
			end
		else
			self.数据[道具id]=nil
			玩家数据[id].角色[类型][数据.格子[1]]=nil
		end
		self:索要道具更新(id,类型)
		帮派青龙玄武:完成玄武任务(任务id,id,任务数据[任务id].分类)
	elseif 事件=="上交任务物品" then
		local 任务id=玩家数据[id].角色:取任务(任务编号)
		if 任务id==0 then
			添加最后对话(id,"你没有这个任务！")
			return
		end
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].名称~=任务数据[任务id].物品  then
			添加最后对话(id,"我拿这个玩意用来干啥？")
			return
		end
		if self.数据[道具id].数量~=nil and self.数据[道具id].数量>0 then
			self.数据[道具id].数量=self.数据[道具id].数量-1
			if self.数据[道具id].数量<=0 then
				self.数据[道具id]=nil
				玩家数据[id].角色[类型][数据.格子[1]]=nil
			end
		else
			self.数据[道具id]=nil
			玩家数据[id].角色[类型][数据.格子[1]]=nil
		end
		self:索要道具更新(id,类型)
		local fun = _G["完成任务_"..tostring(任务编号)]
		if fun ~= nil  then
			return fun(id,任务id)
		else
			return
		end
	elseif 事件=="上交副本物品" then
		local 副本id = 任务处理类:取副本id(数字id,数据.副本编号)
		local 需求编号 = 0
		for i=1,#副本数据.车迟斗法.进行[副本id].任务需求 do
			if self.数据[道具id].名称 == 副本数据.车迟斗法.进行[副本id].任务需求[i].物品 then
				需求编号 = i
			end
		end
		if 需求编号 ~= 0 then
			self.数据[道具id]=nil
			玩家数据[id].角色[类型][数据.格子[1]]=nil
			副本数据.车迟斗法.进行[数字id][副本数据.车迟斗法.进行[副本id].任务需求[需求编号].回执]=副本数据.车迟斗法.进行[数字id][副本数据.车迟斗法.进行[副本id].任务需求[需求编号].回执]+副本数据.车迟斗法.进行[副本id].任务需求[需求编号].奖励
		else
			添加最后对话(id,"我拿这个玩意用来干啥？")
		end
		self:索要道具更新(id,类型)
		local fun = _G[""..数据.脚本]
		if fun ~= nil  then
			return fun(id)
		else
			return
		end

	elseif 事件=="法宝锻造" then
		local 内丹,材料1,材料2,法宝,天珠
		if 数据.格子[1] ~= nil then
			local 道具id = 玩家数据[id].角色[类型][数据.格子[1]]
			if  self.数据[道具id].名称 == "内丹" then
				内丹=self.数据[道具id].名称..self.数据[道具id].五行
			end
		end
		if 数据.格子[2] ~= nil then
			local 道具id = 玩家数据[id].角色[类型][数据.格子[2]]
			if self.数据[道具id].总类 == 1003 and self.数据[道具id].分类 ~= 5 then
				材料1=self.数据[道具id].名称..self.数据[道具id].五行
			end
		end
		if 数据.格子[3] ~= nil then
			local 道具id = 玩家数据[id].角色[类型][数据.格子[3]]
			 if self.数据[道具id].总类 == 1003 and self.数据[道具id].分类 ~= 5 then
				材料2=self.数据[道具id].名称..self.数据[道具id].五行
			end
		end
		if 数据.格子[4] ~= nil then
			local 道具id = 玩家数据[id].角色[类型][数据.格子[4]]
			if self.数据[道具id].总类 == 1000 then
				法宝=self.数据[道具id].名称..self.数据[道具id].五行
			end
		end
		if 数据.格子[5] ~= nil then
			local 道具id = 玩家数据[id].角色[类型][数据.格子[5]]
			天珠=self.数据[道具id].名称..self.数据[道具id].五行
		end
		local lsb = 法宝公式(内丹,材料1,材料2,法宝,天珠)
		if #lsb == 0 then
			常规提示(id,"#Y/合成失败无法合成法宝")
			return
		elseif #lsb > 1 then
			if lsb[时辰信息.当前] ~= nil then
				self.数据[玩家数据[id].角色[类型][数据.格子[1]]] = nil
				玩家数据[id].角色[类型][数据.格子[1]] = nil
				常规提示(id,"#Y/合成失败无法损失了内丹")
				return
			else
				self:给予法宝(id,lsb[时辰信息.当前])
				self.数据[玩家数据[id].角色[类型][数据.格子[1]]] = nil
				玩家数据[id].角色[类型][数据.格子[1]] = nil
				self.数据[玩家数据[id].角色[类型][数据.格子[2]]] = nil
				玩家数据[id].角色[类型][数据.格子[2]] = nil
				self.数据[玩家数据[id].角色[类型][数据.格子[3]]] = nil
				玩家数据[id].角色[类型][数据.格子[3]] = nil
				if 数据.格子[4] ~= nil then
					self.数据[玩家数据[id].角色[类型][数据.格子[4]]] = nil
					玩家数据[id].角色[类型][数据.格子[4]] = nil
				end
				if 数据.格子[5] ~= nil then
					self.数据[玩家数据[id].角色[类型][数据.格子[5]]] = nil
					玩家数据[id].角色[类型][数据.格子[5]] = nil
				end
				self:索要道具更新(id,类型)
			end
		else
			self:给予法宝(id,lsb[1])
			self.数据[玩家数据[id].角色[类型][数据.格子[1]]] = nil
			玩家数据[id].角色[类型][数据.格子[1]] = nil
			self.数据[玩家数据[id].角色[类型][数据.格子[2]]] = nil
			玩家数据[id].角色[类型][数据.格子[2]] = nil
			self.数据[玩家数据[id].角色[类型][数据.格子[3]]] = nil
			玩家数据[id].角色[类型][数据.格子[3]] = nil
			if 数据.格子[4] ~= nil then
				self.数据[玩家数据[id].角色[类型][数据.格子[4]]] = nil
				玩家数据[id].角色[类型][数据.格子[4]] = nil
			end
			if 数据.格子[5] ~= nil then
				self.数据[玩家数据[id].角色[类型][数据.格子[5]]] = nil
				玩家数据[id].角色[类型][数据.格子[5]] = nil
			end
			self:索要道具更新(id,类型)
		end
	elseif 事件=="更改法宝五行" then
		local 道具id=玩家数据[id].角色.法宝[数据.格子[1]]
		if self.数据[道具id] == nil then
			添加最后对话(id,"只有法宝才可以更换五行哟，你这个是什么玩意？")
			return
		end
		if self.数据[道具id].总类~=1000 then
			添加最后对话(id,"只有法宝才可以更换五行哟，你这个是什么玩意？")
			return
		end
		local 价格=300000
		if 玩家数据[id].角色.银子<价格 then
			添加最后对话(id,"本次更换五行需要消耗"..价格.."两银子，你身上没有那么多的现金哟。")
			return
		end
		玩家数据[id].角色:扣除银子(价格,0,0,"法宝更换五行，法宝名称为"..self.数据[道具id].名称,1)
		self.数据[道具id].五行=取五行()
		添加最后对话(id,"更换五行成功！")
	elseif 事件=="更改法宝材料五行" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].总类~=1003 then
			添加最后对话(id,"我这里目前只能更换法宝材料五行，其它的我可没那么大的能耐。")
			return
		end
		local 银子=30000
		if 玩家数据[id].角色.银子<银子 then
			添加最后对话(id,format("本次更换五行需要消耗#Y%s#W两银子，你似乎手头有点紧哟？",银子))
			return
		end
		玩家数据[id].角色:扣除银子(银子,0,0,"点化装备",1)
		self.数据[道具id].五行=取五行()
	elseif 事件=="更改装备五行" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id].总类~=2 or self.数据[道具id].灵饰 then
			添加最后对话(id,"我这里目前只能更换装备五行，其它的我可没那么大的能耐。")
			return
		end
		local 银子=300000
		if 玩家数据[id].角色.银子<银子 then
			添加最后对话(id,format("本次更换五行需要消耗#Y%s#W两银子，你似乎手头有点紧哟？",银子))
			return
		end
		玩家数据[id].角色:扣除银子(银子,0,0,"点化装备",1)
		self.数据[道具id].五行=取五行()
	elseif 事件=="炼制灵犀之屑" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		if self.数据[道具id] == nil then
			添加最后对话(id,"炼制灵犀之屑需要，150级-160级的“人物装备”，#W即可兑换到对应数量的灵犀之屑")
			return
		elseif self.数据[道具id].总类~=2 or self.数据[道具id].灵饰 or self.数据[道具id].召唤兽装备 then
			添加最后对话(id,"我这里只接受人物装备兑换！")
			return
		elseif self.数据[道具id].级别限制<150 then
			添加最后对话(id,"装备"..self.数据[道具id].名称.."等级过低！")
			return
		end
		if self.数据[道具id].级别限制==150 then
			玩家数据[id].道具:给予道具(id,"灵犀之屑",20)
		elseif self.数据[道具id].级别限制==160 then
			玩家数据[id].道具:给予道具(id,"灵犀之屑",30)
		end
		玩家数据[id].角色[类型][数据.格子[1]]=nil
		self.数据[道具id]=nil
		self:索要道具更新(id,类型)
	elseif 事件=="上交烹饪换取材料" then
		local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
		local lsb = {女儿红=10,臭豆腐=20,烤肉=20,豆斋果=60,翡翠豆腐=40,佛跳墙=20,桂花丸=50,长寿面=80,珍露酒=10,蛇胆酒=70,梅花酒=40,百味酒=40,醉生梦死=80}
		if 数据.格子[1]==nil then
			添加最后对话(id,format("你什么都没有还不快滚",fhz2,玩家数据[id].角色.秘制食谱.材料),{"继续上交烹饪换取材料","告辞"})
			return
		end
		if lsb[self.数据[道具id].名称] == nil or self.数据[道具id].阶品 == nil then
			添加最后对话(id,format("这个物品无法无法兑换成材料",fhz2,玩家数据[id].角色.秘制食谱.材料),{"继续上交烹饪换取材料","告辞"})
			return
		end
		local fhz = qz(self.数据[道具id].阶品/20)
		local fhz2
		if fhz >= 4 then
			fhz2 = lsb[self.数据[道具id].名称]/10*(fhz-4)+lsb[self.数据[道具id].名称]
		else
			fhz2 = lsb[self.数据[道具id].名称]-(lsb[self.数据[道具id].名称]/10*(fhz+2-4))
		end
		玩家数据[id].角色[类型][数据.格子[1]]=nil
		self.数据[道具id]=nil
		self:索要道具更新(id,类型)
		玩家数据[id].角色.秘制食谱.材料 = 玩家数据[id].角色.秘制食谱.材料 + fhz2
		添加最后对话(id,format("上交成功,您本次上交兑换了#Y%s#W现有材料#Y%s",fhz2,玩家数据[id].角色.秘制食谱.材料),{"继续上交烹饪换取材料","告辞"})
	elseif 事件 == nil and 玩家数据[id].角色.剧情.附加.物品~= nil then
		if 玩家数据[id].角色.剧情.地图 == 玩家数据[id].给予数据.地图 and 玩家数据[id].角色.剧情.编号 == 玩家数据[id].给予数据.编号 then
			local 道具id=玩家数据[id].角色[类型][数据.格子[1]]
			local 名称=玩家数据[id].角色.剧情.附加.物品
			local 数量=玩家数据[id].角色.剧情.附加.数量
			if 数量 == nil then 数量 = 1 end
			if self.数据[道具id]==nil then
				return
			end
			if self.数据[道具id].名称~=名称 then
				常规提示(id,"#Y/对方需要的不是这种物品")
				return
			end
			if self.数据[道具id].数量 ~= nil and self.数据[道具id].数量<数量 then
				常规提示(id,"#Y/该物品的数量无法达到要求")
				return
			end
			if self.数据[道具id].数量 ~= nil then
				self.数据[道具id].数量=self.数据[道具id].数量-数量
			end
			if self.数据[道具id].数量==nil or self.数据[道具id].数量<=0 then
				self.数据[道具id]=nil
				玩家数据[id].角色[类型][数据.格子[1]]=nil
			end
		end
		玩家数据[id].角色.剧情.给予=true
		对话处理类:数据处理(玩家数据[id].连接id,1501,id,玩家数据[id].给予数据)
	elseif 事件 == nil and 玩家数据[id].角色.剧情.附加.银子~= nil then
		if 玩家数据[id].角色.剧情.地图 == 玩家数据[id].给予数据.地图 and 玩家数据[id].角色.剧情.编号 == 玩家数据[id].给予数据.编号 then
			if 玩家数据[id].角色.剧情.附加.银子 >  数据.银子+0 then
				常规提示(id,"#Y/你给予的银两未达到任务要求")
				return
			end
			if 玩家数据[id].角色:扣除银子(玩家数据[id].角色.剧情.附加.银子,0,0,"剧情任务",1) then
				玩家数据[id].角色.剧情.给予=true
				对话处理类:数据处理(玩家数据[id].连接id,1501,id,玩家数据[id].给予数据)
			end
		end
	end
end

function 道具处理类:给予处理(连接id,id,数据)
	if 玩家数据[id].给予数据==nil then
		return
	elseif 玩家数据[id].给予数据.类型==1 then --npc给予
		self:系统给予处理(连接id,id,数据)
		return
	end
	local 对方id=玩家数据[id].给予数据.id
	if 玩家数据[对方id]==nil then
		常规提示(id,"#Y/对方并不在线")
		return
	elseif 玩家数据[对方id].角色.武神坛角色 then --武神坛
		常规提示(id,"#Y/武神坛角色禁止给予")
		return
	end
	if 地图处理类:比较距离(id,对方id,500)==false then
		常规提示(id,"#Y/你们的距离太远了")
		return
	end
	-- 给予银子
	local 金额=0
	local 银子来源=数据.银子
	local 名称=玩家数据[id].角色.名称
	local 名称1=玩家数据[对方id].角色.名称
	if 银子来源=="" or 银子来源==nil then
		金额=0
	else
		金额=数据.银子+0
	end
	if 金额<0 then
		return
	end
	if 玩家数据[id].角色.银子<金额 then
		常规提示(id,"#Y/你没有那么多的银子")
		return
	end
	if 金额>0 then
		金额=qz(金额)
		local 之前银子=玩家数据[id].角色.银子
		玩家数据[id].角色.银子=玩家数据[id].角色.银子-金额
		玩家数据[id].角色:日志记录(format("[给予系统-发起]接受账号为[%s][%s][%s]角色%s两银子，初始银子为%s，余额为%s两银子",玩家数据[对方id].账号,对方id,玩家数据[对方id].角色.名称,银子,之前银子,玩家数据[id].角色.银子))
		local 之前银子=玩家数据[对方id].角色.银子
		玩家数据[对方id].角色.银子=玩家数据[对方id].角色.银子+金额
		玩家数据[对方id].角色:日志记录(format("[给予系统-接受]发起账号为[%s][%s][%s]角色%s两银子，初始银子为%s，余额为%s两银子",玩家数据[id].账号,id,玩家数据[id].角色.名称,银子,之前银子,玩家数据[对方id].角色.银子))
		常规提示(id,format("#Y/你给了%s%s两银子",名称1,金额))
		常规提示(对方id,format("#Y/%s给了你%s两银子",名称,金额))
	end
	for n=1,3 do
		local 格子=数据.格子[n]
		if 格子~=nil then
			local 数量 = 数据.数量[n] +0 --给予数量
			local go=true
			if 数量<1 or 数量>99 then --or 数量>99
				__S服务:输出("玩家"..id.." 存在作弊行为！！！给予处理")
				local 封禁原因=玩家数据[id].角色.ip.."“违规行为：给予处理”数量=="..数量.."，玩家ID=="..id.."，玩家账号=="..玩家数据[id].账号.."时间="..os.date("%Y%m%d")..os.date("%H",os.time())..os.date("%S",os.time())
				f函数.写配置(程序目录..[[data\]]..玩家数据[id].账号..[[\账号信息.txt]],"账号配置","已违规7",封禁原因)
				f函数.写配置(程序目录..[[各类情况查看\]]..[[\违规汇总.txt]],"违规详情","已违规7:",封禁原因)
				go=false
			end
			if go then
				数量=math.floor(数量)
				local 道具id=玩家数据[id].角色.道具[格子]
				if 道具id~=nil and 玩家数据[id].道具.数据[道具id]~=nil then
					if 玩家数据[id].道具.数据[道具id].绑定 or 玩家数据[id].道具.数据[道具id].不可交易 or 玩家数据[id].道具.数据[道具id].专用 then
						常规提示(id,"#Y/该物品无法交易或给予给他人")
					else
						local 对方格子=玩家数据[对方id].角色:取道具格子()
						if 对方格子==0 then
							常规提示(id,"#Y/对方身上没有足够的空间")
						else
							local 对方道具=玩家数据[对方id].道具:取新编号()
							local 道具名称=玩家数据[id].道具.数据[道具id].名称
							local 道具识别码=玩家数据[id].道具.数据[道具id].识别码
							if 玩家数据[id].道具:检查道具是否存在(id,道具识别码,数量) then
								玩家数据[对方id].道具.数据[对方道具]=table.loadstring(table.tostring(玩家数据[id].道具.数据[道具id]))
								玩家数据[对方id].角色.道具[对方格子]=对方道具
								if 玩家数据[id].道具.数据[道具id].可叠加 and   玩家数据[id].道具.数据[道具id].数量 ~= nil and   玩家数据[id].道具.数据[道具id].数量 ~= "假" then
									if 玩家数据[id].道具.数据[道具id].数量 - 数量 > 0 then
										玩家数据[对方id].道具.数据[对方道具].数量 = 数量
										玩家数据[id].道具.数据[道具id].数量 = 玩家数据[id].道具.数据[道具id].数量 - 数量
									else
										玩家数据[id].道具.数据[道具id]=nil
										玩家数据[id].角色.道具[格子]=nil
									end
								else
									玩家数据[id].道具.数据[道具id]=nil
									玩家数据[id].角色.道具[格子]=nil
								end
								常规提示(id,"#Y/你给了"..名称1..玩家数据[对方id].道具.数据[对方道具].名称)
								常规提示(对方id,"#Y/"..名称.."给了你"..玩家数据[对方id].道具.数据[对方道具].名称)
								玩家数据[id].角色:日志记录(format("[给予系统-发起]物品名称%s、识别码%s,对方信息[%s][%s][%s]",道具名称,道具识别码,玩家数据[对方id].账号,对方id,名称1))
								玩家数据[对方id].角色:日志记录(format("[给予系统-接受]物品名称%s、识别码%s,对方信息[%s][%s][%s]",道具名称,道具识别码,玩家数据[id].账号,id,名称))
								-- 更改道具归属(道具识别码,玩家数据[对方id].账号,对方id,名称1)
							end
						end
					end
				end
			end
		end
	end

	道具刷新(id)
	道具刷新(对方id)
	玩家数据[id].角色:存档()--给予存档
	玩家数据[对方id].角色:存档()--给予存档
	玩家数据[id].给予数据=nil
end

function 道具处理类:取武器类型(子类)
  local n = {"枪矛","斧钺","剑","双短剑","飘带","爪刺","扇","魔棒","锤","鞭","环圈","刀","法杖","弓弩","宝珠","巨剑","伞","灯笼","头盔","发钗","项链","女衣","男衣","腰带","鞋子"}
  for i=1,#n do
	if n[i]==子类 then
		return i
	end
  end
end

function 道具处理类:迷宫奖励(id)
	if 迷宫数据[id]~=nil  then
		添加最后对话(id,"你不是已经领取过奖励了吗？")
		return
	end
	迷宫数据[id]=true
	local 等级=玩家数据[id].角色.等级
	local 经验=等级*等级+30000
	local 银子=等级*等级+20000
	local 奖励参数=取随机数(1,500)
	if 奖励参数<=100 then
		 local 名称=取宝石()
		 玩家数据[id].道具:给予道具(id,名称,取随机数(1,1))
		 广播消息({内容=format("#S(幻域迷宫)#R/%s#Y成功通过了所有迷宫，因此获得了迷宫守卫奖励的#G/%s#Y",玩家数据[id].角色.名称,名称),频道="xt"})
	elseif 奖励参数<=110 then
		 local 名称="高级魔兽要诀"
		 玩家数据[id].道具:给予道具(id,名称)
		 广播消息({内容=format("#S(幻域迷宫)#R/%s#Y成功通过了所有迷宫，因此获得了迷宫守卫奖励的#G/%s#Y",玩家数据[id].角色.名称,名称),频道="xt"})
	 elseif 奖励参数<=250 then
		 local 名称="修炼果"
		 玩家数据[id].道具:给予道具(id,名称)
		 广播消息({内容=format("#S(幻域迷宫)#R/%s#Y成功通过了所有迷宫，因此获得了迷宫守卫奖励的#G/%s#Y",玩家数据[id].角色.名称,名称),频道="xt"})
	 elseif 奖励参数<=300 then
		 local 名称="九转金丹"
		 玩家数据[id].道具:给予道具(id,名称,20)
		 广播消息({内容=format("#S(幻域迷宫)#R/%s#Y成功通过了所有迷宫，因此获得了迷宫守卫奖励的#G/%s#Y",玩家数据[id].角色.名称,名称),频道="xt"})
	else
		 local 名称="星辉石"
		 玩家数据[id].道具:给予道具(id,名称,1)
		 广播消息({内容=format("#S(幻域迷宫)#R/%s#Y成功通过了所有迷宫，因此获得了迷宫守卫奖励的#G/%s#Y",玩家数据[id].角色.名称,名称),频道="xt"})
	end
	if 迷宫数据.奖励<5 then
		迷宫数据.奖励=迷宫数据.奖励+1
		if 取随机数()<=50 then
			self:给予道具(id,"灵饰指南书",{6,8,10})
			广播消息({内容=format("#S(幻域迷宫)#R/%s#Y以惊人的速度率先通过了所有迷宫，获得了迷宫守卫额外奖励的#G/%s#Y",玩家数据[id].角色.名称,"灵饰指南书"),频道="xt"})
		else
			self:给予道具(id,"元灵晶石",{6,8,10,12,14})
			广播消息({内容=format("#S(幻域迷宫)#R/%s#Y以惊人的速度率先通过了所有迷宫，获得了迷宫守卫额外奖励的#G/%s#Y",玩家数据[id].角色.名称,"元灵晶石"),频道="xt"})
		end
	end
	道具刷新(id)
end
function 道具处理类:玲珑宝图处理(id)
	local 奖励参数=取随机数(1,100)
	local lv = 玩家数据[id].角色.等级
	local fanwei={6,8}
	if lv>=80 and lv<100 then
		fanwei={8,10}
	elseif lv>=100 and lv<120 then
		fanwei={10,12}
	elseif lv>=120 then
		fanwei={10,12,14}
	end
	local 链接
	local 名称
	if 奖励参数<=10 then
		名称=玩家数据[id].角色.等级*1000
		玩家数据[id].角色:添加经验(qz(玩家数据[id].角色.等级*1000),"玲珑宝图")
		添加最后对话(id,"你的修为又增加了，获得了"..名称.."点经验")
	elseif 奖励参数<=40 then
		名称="灵饰指南书"
		链接 = {提示=format("#Y天降大运！#G/%s#Y拿着玲珑宝图，在野外挖宝意外获得了神仙遗留的",玩家数据[id].角色.名称),频道="xt",结尾="#Y。"}
		玩家数据[id].道具:给予超链接道具(id,名称,fanwei,nil,链接,"成功")
		添加最后对话(id,"天降大运，你意外获得了神仙遗留的1个"..名称)
	elseif 奖励参数<=70 then
		名称="元灵晶石"
		链接 = {提示=format("#Y天降大运！#G/%s#Y拿着玲珑宝图，在野外挖宝意外获得了神仙遗留的",玩家数据[id].角色.名称),频道="xt",结尾="#Y。"}
		玩家数据[id].道具:给予超链接道具(id,名称,fanwei,nil,链接,"成功")
		添加最后对话(id,"天降大运，你意外获得了神仙遗留的1个"..名称)
	elseif 奖励参数<=75 then
		名称="符石卷轴"
		链接 = {提示=format("#Y天降大运！#G/%s#Y拿着玲珑宝图，在野外挖宝意外获得了神仙遗留的",玩家数据[id].角色.名称),频道="xt",结尾="#Y。"}
		玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接,"成功")
		添加最后对话(id,"天降大运，你意外获得了神仙遗留的1个"..名称)
	elseif 奖励参数<=85 then
		设置任务101(id)
	else
		设置任务205(id)
	end
end

function 道具处理类:高级藏宝图处理(id)
	local 奖励参数=取随机数(1,100)
	local 链接 = {提示=format("#Y天降福缘！#G/%s#Y拿着获得的高级藏宝图，在野外挖宝惊喜的获得了",玩家数据[id].角色.名称),频道="xt",结尾="#24#Y。"}
   if 奖励参数<=10 then
		local 名称="召唤兽内丹"
		玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接,"成功")
		常规提示(id,"#Y你获得了一个宝贝")
	elseif 奖励参数<=20 then
		常规提示(id,"#Y/你获得了一本妖怪遗留下来的秘籍")
		玩家数据[id].道具:给予超链接道具(id,"高级魔兽要诀",nil,nil,链接,"成功")
	elseif 奖励参数<=40 then
		self:取随机装备(id,取随机数(5,7))
		常规提示(id,"#Y你获得了一个宝贝")
	elseif 奖励参数<=50 then
		local 名称="高级召唤兽内丹"
		玩家数据[id].道具:给予超链接道具(id,名称,nil,nil,链接,"成功")
		常规提示(id,"#Y你获得了一个宝贝")
	elseif 奖励参数<=60 then
		玩家数据[id].道具:给予超链接道具(id,"神兜兜",1,nil,链接,"成功")
		常规提示(id,"#Y你获得了一个宝贝")
	elseif 奖励参数<=70 then
		设置任务205(id) --妖王
	elseif 奖励参数<=90 then
		设置任务101(id)
	else
		玩家数据[id].道具:给予超链接道具(id,"未激活的符石",取随机数(1,3),nil,链接,"成功")
		常规提示(id,"#Y你获得了一个宝贝")
	end
end

function 道具处理类:低级藏宝图处理(id)
	local 奖励参数=取随机数(1,100)
	if 奖励参数<=45 then
		玩家数据[id].角色:添加银子(取随机数(3000,8000),"挖宝",1)
		常规提示(id,"#Y/你得到了妖怪遗留下来的宝物")
	elseif 奖励参数<=60 then --设置
		local 名称=self:取五宝()
		self:给予道具(id,名称)
	elseif 奖励参数<=70 then
		设置任务205(id)
	elseif 奖励参数<=80 then
		self:给予道具(id,"魔兽要诀")
	elseif 奖励参数<=90 then
		战斗准备类:创建战斗(id+0,100003)
		常规提示(id,"#Y/你一锄头挖下去，似乎触碰到了一个奇形怪状的物体")
	else
		设置任务101(id)
	end
end

function 道具处理类:完成宝图遇怪(id)
	local 奖励参数=取随机数()
	if 奖励参数<=100 then
		local 名称=取宝石()
		self:给予道具(id,名称,取随机数(1,1))
		发送数据(玩家数据[id].连接id,38,{内容="你得到了#R/"..名称})
	elseif 奖励参数<=40 then
		self:取随机装备(id,取随机数(2,7))
	end
	local 临时经验=取等级(id)*50+1000
	玩家数据[id].角色:添加经验(临时经验,"挖图遇怪",1)
end

function 道具处理类:取五宝()
	return 五宝名称[取随机数(1,5)]
end

function 道具处理类:灵饰处理(id,名称,等级,强化,类型)
	if 等级 == nil then
		return
	end
	local 临时道具 =物品类()
	临时道具:置对象(名称)
	临时道具.级别限制 = 等级
	临时道具.幻化等级=0
	临时道具.部位类型=类型
	临时道具.灵饰=true
	临时道具.耐久=500
	临时道具.鉴定=false
	临时道具.幻化属性={附加={},}
	临时道具.识别码=id.."_"..os.time().."_"..取随机数(1000,9999999).."_"..随机序列
	随机序列=随机序列+1
	self.临时属性=灵饰属性[类型].主属性[取随机数(1,#灵饰属性[类型].主属性)]
	self.临时数值=灵饰主属性[self.临时属性][等级].b
	self.临时下限=灵饰主属性[self.临时属性][等级].a
	self.临时数值=取随机数(self.临时下限,self.临时数值)
	临时道具.幻化属性.基础={类型=self.临时属性,数值=self.临时数值,强化=0}
	for n=1,取随机数(1,4) do--------------灵饰4条属性  灵饰3条属性
		self.临时属性=灵饰属性[类型].副属性[取随机数(1,#灵饰属性[类型].副属性)]
		self.临时数值=灵饰副属性[self.临时属性][等级].b
		self.临时下限=灵饰副属性[self.临时属性][等级].a
		self.临时数值=取随机数(self.临时下限,self.临时数值)
		for i=1,#临时道具.幻化属性.附加 do
			if 临时道具.幻化属性.附加[i].类型==self.临时属性 then
				self.临时数值=临时道具.幻化属性.附加[i].数值
			end
		end
		临时道具.幻化属性.附加[n]={类型=self.临时属性,数值=self.临时数值,强化=0}
	end
	if 玩家数据[id].角色.武神坛角色 then --武神坛
		临时道具.专用 = id
		临时道具.不可交易 = true
	end
	return 临时道具 --##
end

function 道具处理类:dz灵饰处理(id,名称,等级,类型)
	local 临时道具 =物品类()
	临时道具:置对象(名称)
	临时道具.级别限制 = 等级
	临时道具.幻化等级=0
	临时道具.部位类型=类型
	临时道具.灵饰=true
	临时道具.耐久=500
	临时道具.鉴定=true
	临时道具.幻化属性={附加={},}
	临时道具.识别码=id.."_"..os.time().."_"..取随机数(1000,9999999).."_"..随机序列
	随机序列=随机序列+1
	self.临时属性=灵饰属性[类型].主属性[取随机数(1,#灵饰属性[类型].主属性)]
	self.临时数值=灵饰主属性[self.临时属性][等级].b
	self.临时下限=灵饰主属性[self.临时属性][等级].a
	self.临时数值=取随机数(self.临时下限,self.临时数值)
	临时道具.幻化属性.基础={类型=self.临时属性,数值=self.临时数值,强化=0}
	for n=1,4 do
		self.临时属性=灵饰属性[类型].副属性[取随机数(1,#灵饰属性[类型].副属性)]
		if n>1 and RpbARGB.序列==3 and 取随机数()<=30 then
			   self.临时属性=临时道具.幻化属性.附加[1].类型
		end
		self.临时数值=灵饰副属性[self.临时属性][等级].b
		self.临时下限=灵饰副属性[self.临时属性][等级].a
		self.临时数值=取随机数(self.临时下限,self.临时数值)
		for i=1,#临时道具.幻化属性.附加 do
			if 临时道具.幻化属性.附加[i].类型==self.临时属性 then
				self.临时数值=临时道具.幻化属性.附加[i].数值
			end
		end
		临时道具.幻化属性.附加[n]={类型=self.临时属性,数值=self.临时数值,强化=0}
	end
	if RpbARGB.序列~=5 then
	   临时道具.专用=id
	end
	if 玩家数据[id].角色.武神坛角色 then --武神坛
		临时道具.不可交易 = true
		临时道具.专用=id
	end

	临时道具.特效="超级简易"
	return 临时道具
end

function 道具处理类:烹饪处理(连接id,数字id,数据)
	local 临时等级=玩家数据[数字id].角色:取生活技能等级("烹饪技巧")
	local 临时消耗=20
	if 玩家数据[数字id].角色.活力<临时消耗 then
		常规提示(数字id,"本次操作需要消耗"..临时消耗.."点活力")
		return
	end
	local 物品表={}
	玩家数据[数字id].角色.活力= 玩家数据[数字id].角色.活力-临时消耗
	体活刷新(数字id)
	if 临时等级<=4 then
	 物品表={"包子"}
	elseif 临时等级<=9 then
	 物品表={"包子","包子","佛跳墙","包子"}
	elseif 临时等级<=14 then
	 物品表={"包子","包子","佛跳墙","包子","烤鸭"}
	elseif 临时等级<=19 then
	 物品表={"包子","珍露酒","佛跳墙","烤鸭","佛跳墙","佛跳墙","包子","烤鸭"}
	elseif 临时等级<=24 then
	 物品表={"包子","珍露酒","佛跳墙","佛跳墙","醉生梦死","烤鸭","包子","烤鸭","虎骨酒","佛跳墙","佛跳墙","包子","女儿红"}
	elseif 临时等级<=29 then
	 物品表={"包子","珍露酒","豆斋果","佛跳墙","烤鸭","包子","佛跳墙","醉生梦死","烤鸭","虎骨酒","烤鸭","包子","女儿红"}
 elseif 临时等级<=34 then
	 物品表={"包子","佛跳墙","佛跳墙","醉生梦死","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
	elseif 临时等级<=39 then
	 物品表={"烤肉","桂花丸","佛跳墙","佛跳墙","醉生梦死","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
	elseif 临时等级<=44 then
	 物品表={"烤肉","翡翠豆腐","桂花丸","佛跳墙","醉生梦死","佛跳墙","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
	elseif 临时等级<=49 then
	 物品表={"烤肉","长寿面","翡翠豆腐","桂花丸","佛跳墙","醉生梦死","佛跳墙","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
	elseif 临时等级<=54 then
	 物品表={"烤肉","梅花酒","长寿面","翡翠豆腐","桂花丸","佛跳墙","醉生梦死","佛跳墙","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
	elseif 临时等级<=59 then
	 物品表={"烤肉","百味酒","梅花酒","长寿面","翡翠豆腐","桂花丸","佛跳墙","佛跳墙","醉生梦死","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
	elseif 临时等级<=64 then
	 物品表={"烤肉","蛇胆酒","百味酒","梅花酒","长寿面","翡翠豆腐","桂花丸","佛跳墙","醉生梦死","佛跳墙","珍露酒","烤鸭","烤鸭","豆斋果","烤鸭","臭豆腐","佛跳墙","包子","烤鸭","虎骨酒","包子","女儿红"}
	else
	 物品表={"烤肉","醉生梦死","蛇胆酒","百味酒","梅花酒","长寿面","翡翠豆腐","桂花丸","珍露酒","豆斋果","臭豆腐","佛跳墙","烤鸭","虎骨酒","女儿红"}
	end
	local 临时物品=物品表[取随机数(1,#物品表)]
	local 临时品质=0
	if 临时物品~="包子" then
		临时品质=qz(取随机数(math.floor(临时等级*0.5),临时等级)*数据)
	end
	常规提示(数字id,"#W/经过一阵忙碌，你烹制出了#R/"..临时物品)
	self:给予道具(数字id,临时物品,1,临时品质)
	发送数据(连接id,3699)
end

function 道具处理类:领取每日活跃奖励(数字id,类型)
	local lq = "领取" ..类型
	if 每日任务[数字id]==nil or tonumber(类型)==nil then
		常规提示(数字id,"#Y/你不可领取此活跃进度")
		return
	elseif 每日任务[数字id][lq]~=nil then
		常规提示(数字id,"#Y/此活跃进度你已经领取过了")
		return
	end
	每日任务[数字id][lq]=true
	local 经验银子={
		[1]={经验=1000000,银子=150000},
		[2]={经验=1500000,银子=200000},
		[3]={经验=2000000,银子=250000},
		[4]={经验=3000000,银子=300000}
	}
	玩家数据[数字id].角色:添加经验(经验银子[类型+0].经验,"每日活跃领取",1)
	玩家数据[数字id].角色:添加银子(经验银子[类型+0].银子,"每日活跃领取",1)
	local 奖励物品={[1]={},[2]={},[3]={},[4]={}}
	奖励物品[1]={

		{名称="金银锦盒",可叠加=true,给予数量=5},
	}
	奖励物品[2]={

		{名称="金银锦盒",可叠加=true,给予数量=10},
	}
	奖励物品[3]={

		{名称="修炼果",可叠加=true,给予数量=1},
	}
	奖励物品[4]={

		{名称="神兜兜",可叠加=true,给予数量=1},
	}
	for an=1,#奖励物品[类型+0] do
		local data=奖励物品[类型+0][an]
		local 临时道具 = 物品类()
		临时道具:置对象(data.名称)
		临时道具.名称 = data.名称
		if data.可叠加 then
			self:给予道具(数字id,data.名称,data.给予数量,nil,"不存共享",nil,临时道具)
		else
			for ansb=1,data.给予数量 do
			  self:给予道具(数字id,data.名称,nil,nil,"不存共享",nil,临时道具)
			end
		end
	end
	常规提示(数字id,"#Y/成功领取活跃进度" ..类型 .."奖励")
end

function 道具处理类:炼药处理(连接id,数字id,数据)
	local 临时等级=玩家数据[数字id].角色:取生活技能等级("中药医理")
	local 临时消耗=20
	if 玩家数据[数字id].角色.活力<临时消耗 then
	 常规提示(数字id,"本次操作需要消耗"..临时消耗.."点活力")
	 return
	elseif 临时等级<10 then
	 常规提示(数字id,"您的中药医理技能尚未达到10级，无法进行炼药操作")
	 return
	elseif 玩家数据[数字id].角色.银子<10000 then
		常规提示(数字id,"炼药需要消耗1000两银子")
		return
	end
	玩家数据[数字id].角色:扣除银子(10000,0,0,"炼药消耗",1)
	玩家数据[数字id].角色.活力= 玩家数据[数字id].角色.活力-临时消耗
	体活刷新(数字id)
	local 特性表={"倍愈","藏神"}
	local 物品表={}
	物品表={"金香玉","小还丹","千年保心丹","风水混元丹","定神香","蛇蝎美人","九转回魂丹","金香玉","佛光舍利子","金香玉","十香返生丸","五龙丹"} --炼药获得的种类
	local 临时物品=物品表[取随机数(1,#物品表)]
	 if 临时物品=="五龙丹" then
	    for n=1,#特性表 do
	      if 特性表[n]=="倍愈" then
	      table.remove(特性表,n)
	      break
	      end
	    end
	  end
	  local 临时特性=特性表[取随机数(1,#特性表)]
	  if 取随机数() >= 50  or 临时物品=="金创药"  then  --概率
	    临时特性=nil
	  end

	local 临时品质=0
	临时品质=qz(取随机数(math.floor(临时等级*0.5),临时等级*1.1))
	self:给予道具(数字id,临时物品,1,临时品质,临时特性)
	发送数据(连接id,3699)
end

function 道具处理类:消耗背包道具(连接id,id,名称,数量)
	local 扣除数量 = 数量
	local 扣除数据={}
	local 已扣除=0
	for n=1,20 do
		if 玩家数据[id].角色.道具[n]~=nil and self.数据[玩家数据[id].角色.道具[n]]~=nil and self.数据[玩家数据[id].角色.道具[n]].名称==名称 and 已扣除<扣除数量 then
			if self.数据[玩家数据[id].角色.道具[n]].数量 == nil then
				已扣除=已扣除+1
				扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=1}
			else
				if self.数据[玩家数据[id].角色.道具[n]].数量>=扣除数量-已扣除 then
					扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=扣除数量-已扣除}
					已扣除=已扣除+(扣除数量-已扣除)
				else
					已扣除=已扣除+self.数据[玩家数据[id].角色.道具[n]].数量
					扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=self.数据[玩家数据[id].角色.道具[n]].数量}
				end
			end
		end
	end
	if 已扣除<扣除数量 then
		if 玩家数据[id].zhandou==0 then
			常规提示(id,"你没有那么多的"..名称)
		else
			发送数据(连接id, 38, {内容 = "你没有那么多的"..名称})
		end
		return false
	else
		for n=1,#扣除数据 do
			玩家数据[id].道具:删除道具(连接id,id,"道具",扣除数据[n].id,扣除数据[n].格子,扣除数据[n].数量)
		end
		发送数据(连接id,3699)
		return true
	end
	return false
end

function 道具处理类:消耗任务道具(连接id,id,名称,数量)
	local 扣除数量 = 数量
	local 扣除数据={}
	local 已扣除=0
	for n=1,20 do
		if 玩家数据[id].角色.任务包裹[n]~=nil and self.数据[玩家数据[id].角色.任务包裹[n]]~=nil and self.数据[玩家数据[id].角色.任务包裹[n]].名称==名称 and 已扣除<扣除数量 then
			if self.数据[玩家数据[id].角色.任务包裹[n]].数量 == nil then
				已扣除=已扣除+1
				扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.任务包裹[n],数量=1}
			else
				if self.数据[玩家数据[id].角色.任务包裹[n]].数量>=扣除数量-已扣除 then
					扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.任务包裹[n],数量=扣除数量-已扣除}
					已扣除=已扣除+(扣除数量-已扣除)
				else
					已扣除=已扣除+self.数据[玩家数据[id].角色.任务包裹[n]].数量
					扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.任务包裹[n],数量=self.数据[玩家数据[id].角色.任务包裹[n]].数量}
				end
			end
		end
	end
	if 已扣除<扣除数量 then
		常规提示(id,"你没有那么多的"..名称)
		return false
	else
		for n=1,#扣除数据 do
			玩家数据[id].道具:删除道具(连接id,id,"任务包裹",扣除数据[n].id,扣除数据[n].格子,扣除数据[n].数量)
		end
		发送数据(连接id,3699)
		return true
	end
end

function 道具处理类:删除道具(连接id,id,包裹类型,道具id,道具格子,删除数量)
	-- if self.数据[道具id].名称=="怪物卡片" then self.数据[道具id].次数=self.数据[道具id].次数-1 end
	if self.数据[道具id]==nil then
		玩家数据[id].角色[包裹类型][道具格子]=nil
		return
	end
	if 删除数量==nil then 删除数量=1 end
	if self.数据[道具id].数量==nil and self.数据[道具id].名称~="怪物卡片" and self.数据[道具id].名称~="小象炫卡" and self.数据[道具id].名称~="腾蛇炫卡"  and self.数据[道具id].名称~="龙马炫卡"  and self.数据[道具id].名称~="雪人炫卡" then
		self.数据[道具id]=nil
		玩家数据[id].角色[包裹类型][道具格子]=nil
	elseif self.数据[道具id].名称=="怪物卡片" or self.数据[道具id].名称=="小象炫卡" or self.数据[道具id].名称=="腾蛇炫卡"  or self.数据[道具id].名称=="龙马炫卡"  or self.数据[道具id].名称=="雪人炫卡"  then
		self.数据[道具id].次数=self.数据[道具id].次数-1
		if  self.数据[道具id].次数<=0 then
			self.数据[道具id]=nil
			玩家数据[id].角色[包裹类型][道具格子]=nil
		end
	else
		if type(self.数据[道具id].数量 ) ~= "number" then
			self.数据[道具id]=nil
			玩家数据[id].角色[包裹类型][道具格子]=nil
		else
			self.数据[道具id].数量=self.数据[道具id].数量-删除数量
			if self.数据[道具id].数量<=0  then
				self.数据[道具id]=nil
				玩家数据[id].角色[包裹类型][道具格子]=nil
			end
		end
	end
end

function 道具处理类:判断道具是否有(id,名称)
	for n=1,20 do
		if 玩家数据[id].角色.道具[n]~=nil and self.数据[玩家数据[id].角色.道具[n]]~=nil and self.数据[玩家数据[id].角色.道具[n]].名称==名称 then
			return true
		end
	end
	return false
end

function 道具处理类:取对方道具(id,名称)
	for n=1,20 do
		if 玩家数据[id].角色.道具[n]~=nil and self.数据[玩家数据[id].角色.道具[n]]~=nil and self.数据[玩家数据[id].角色.道具[n]].名称==名称 then
			return self.数据[玩家数据[id].角色.道具[n]],玩家数据[id].角色.道具[n]
		end
	end
	return 0
end

function 道具处理类:随机删除道具(连接id,id)
	local t={}
	for n=1,20 do
		if 玩家数据[id].角色.道具[n]~=nil and self.数据[玩家数据[id].角色.道具[n]]~=nil then
			t[#t+1]=n
		end
	end
	if #t>0 then
		local bh = t[取随机数(1,#t)]
		local 名称 = self.数据[玩家数据[id].角色.道具[bh]].名称
		self.数据[玩家数据[id].角色.道具[bh]]=nil
		玩家数据[id].角色.道具[bh]=nil
		发送数据(连接id,3699)
		return 名称
	end
end

function 道具处理类:判定背包道具(id,名称,数量)
	local 扣除数量 = 数量+0
	local 扣除数据={}
	local 已扣除=0
	for n=1,20 do
		if 玩家数据[id].角色.道具[n]~=nil and self.数据[玩家数据[id].角色.道具[n]]~=nil and self.数据[玩家数据[id].角色.道具[n]].名称==名称 and 已扣除<扣除数量 then
			if self.数据[玩家数据[id].角色.道具[n]].数量 ~= nil then
				if self.数据[玩家数据[id].角色.道具[n]].数量>=扣除数量-已扣除 then
					扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=扣除数量-已扣除}
					已扣除=已扣除+(扣除数量-已扣除)
				else
					已扣除=已扣除+self.数据[玩家数据[id].角色.道具[n]].数量
					扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=self.数据[玩家数据[id].角色.道具[n]].数量}
				end
			else
				扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=1}
				已扣除 = 已扣除 +1
			end
		end
	end

	if 已扣除<扣除数量 then
		return false
	else
		return true
	end
end

function 道具处理类:判定任务道具(连接id,id,名称,数量)
	local 扣除数量 = 数量
	local 扣除数据={}
	local 已扣除=0
	for n=1,20 do
		if 玩家数据[id].角色.任务包裹[n]~=nil and self.数据[玩家数据[id].角色.任务包裹[n]]~=nil and self.数据[玩家数据[id].角色.任务包裹[n]].名称==名称 and 已扣除<扣除数量 then
			if self.数据[玩家数据[id].角色.任务包裹[n]].数量 ~= nil then
				if self.数据[玩家数据[id].角色.任务包裹[n]].数量>=扣除数量-已扣除 then
					扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.任务包裹[n],数量=扣除数量-已扣除}
					已扣除=已扣除+(扣除数量-已扣除)
				else
					已扣除=已扣除+self.数据[玩家数据[id].角色.任务包裹[n]].数量
					扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.任务包裹[n],数量=self.数据[玩家数据[id].角色.任务包裹[n]].数量}
				end
			else
				扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.任务包裹[n],数量=1}
					已扣除 = 已扣除 +1
			end
		end
	end
	if 已扣除<扣除数量 then
		return false
	else
		return true
	end
end

function 道具处理类:扣除装备耐久(类型) --耐久弄成记次数，然后结束战斗再扣除
	local 玩家id = self.玩家id
	if  类型 == "攻击" or 类型 == "施法" then
		local 道具id = 玩家数据[玩家id].角色.装备[3]
		if self.数据[道具id] ~= nil and self.数据[道具id].特效 ~= "永不磨损" then
			if self.数据[道具id].耐久 == nil then
				self.数据[道具id].耐久 = 0
			end
			if 类型 == "攻击" then
				if 玩家数据[玩家id].角色.门派=="狮驼岭" then
					self.数据[道具id].耐久 = self.数据[道具id].耐久- 0.07
				elseif 玩家数据[玩家id].角色.门派=="大唐官府" then
					self.数据[道具id].耐久 = self.数据[道具id].耐久- 0.05
				elseif 玩家数据[玩家id].角色.门派=="五庄观" and 玩家数据[玩家id].角色.奇经八脉.锤炼==1 then
					self.数据[道具id].耐久 = self.数据[道具id].耐久- 0.05
				else
					self.数据[道具id].耐久 = self.数据[道具id].耐久- 0.1
				end
			else
				self.数据[道具id].耐久 =  self.数据[道具id].耐久- 0.05
			end
			if  self.数据[道具id].耐久 < 0 then
				self.数据[道具id].耐久 = 0
			end
		end
	end
	if  类型 == "挨打" then
		for w, v in pairs(玩家数据[玩家id].角色.装备) do
			if w ~= 3 then
				local 道具id = 玩家数据[玩家id].角色.装备[w]
				if self.数据[道具id] ~= nil  then
					if self.数据[道具id].耐久 == nil then
						self.数据[道具id].耐久 = 0
					end
					if self.数据[道具id] ~= nil and self.数据[道具id].特效 ~= "永不磨损" then
						self.数据[道具id].耐久 = self.数据[道具id].耐久- 0.1
					end
					if  self.数据[道具id].耐久 < 0 then
						self.数据[道具id].耐久 = 0
					end
				end
			end
		end
		for w, v in pairs(玩家数据[玩家id].角色.灵饰) do
			local 道具id = 玩家数据[玩家id].角色.灵饰[w]
			if self.数据[道具id] ~= nil  then
				if self.数据[道具id].耐久 == nil then
					self.数据[道具id].耐久 = 0
				end
				if self.数据[道具id] ~= nil then
					self.数据[道具id].耐久 = self.数据[道具id].耐久- 0.1
				end
				if  self.数据[道具id].耐久 < 0 then
					self.数据[道具id].耐久 = 0
				end
			end
		end
	end
end

function 道具处理类:染色处理(连接id,id,数据)
	local 彩果数量=0
	for n=1,#数据 do
		彩果数量=彩果数量+数据[n]
	end
	local 扣除数据={}
	local 已扣除=0
	for n=1,20 do
		if 玩家数据[id].角色.道具[n]~=nil and self.数据[玩家数据[id].角色.道具[n]]~=nil and self.数据[玩家数据[id].角色.道具[n]].名称=="彩果" and 已扣除<彩果数量 then
			if self.数据[玩家数据[id].角色.道具[n]].数量>=彩果数量-已扣除 then
				扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=彩果数量-已扣除}
				已扣除=已扣除+(彩果数量-已扣除)
			else
				已扣除=已扣除+self.数据[玩家数据[id].角色.道具[n]].数量
				扣除数据[#扣除数据+1]={格子=n,id=玩家数据[id].角色.道具[n],数量=self.数据[玩家数据[id].角色.道具[n]].数量}
			end
		end
	end
	if 已扣除<彩果数量 then
		常规提示(id,"你没有那么多的彩果")
		return
	else
		for n=1,#扣除数据 do
			self.数据[扣除数据[n].id].数量=self.数据[扣除数据[n].id].数量-扣除数据[n].数量
			if self.数据[扣除数据[n].id].数量<=0 then
				self.数据[扣除数据[n].id]=nil
				玩家数据[id].角色.道具[扣除数据[n].格子]=nil
			end
		end
		常规提示(id,"染色成功！")
		玩家数据[id].角色.染色组=数据
		发送数据(连接id,30,数据)
		发送数据(连接id,3699)
		地图处理类:更改染色(id,数据,玩家数据[id].角色.染色方案)
	end
end

function 道具处理类:卸下bb装备(连接id,id,数据)
	local 角色=数据.角色
	local 类型="道具"--数据.类型
	local 道具=数据.道具
	-- if 数据.类型 == "任务包裹" or 数据.类型 == "法宝" or 数据.类型 == "行囊" then return 常规提示(id,"#Y这件物品不能移动到任务栏") end
	--local 道具id=玩家数据[id].角色[类型][道具]
	local bb=数据.编号
	local 道具格子=玩家数据[id].角色:取道具格子1(类型)
	if 道具格子==0 then
		常规提示(id,"您的道具栏物品已经满啦")
		return
	else
		local 临时id=self:取新编号()
		self.数据[临时id]=玩家数据[id].召唤兽.数据[bb].装备[道具]
		玩家数据[id].召唤兽.数据[bb]:卸下装备(玩家数据[id].召唤兽.数据[bb].装备[道具],道具)
		玩家数据[id].角色.道具[道具格子]=临时id
		玩家数据[id].召唤兽.数据[bb].装备[道具]=nil
		self:刷新道具行囊(id,类型)
		发送数据(连接id,20,玩家数据[id].召唤兽.数据[bb]:取存档数据())
		发送数据(连接id,28)
	end
end

function 道具处理类:佩戴bb装备(连接id,id,数据)
	local 角色=数据.角色
	local 类型=数据.类型
	local 道具=数据.道具
	local 道具id=玩家数据[id].角色[类型][道具]
	local bb=数据.编号
	if self.数据[道具id].分类>6 and self:召唤兽可装备(self.数据[道具id],self.数据[道具id].分类-6,玩家数据[id].召唤兽.数据[bb].等级,id) then
		local 装备格子=self.数据[道具id].分类 - 6
		if 玩家数据[id].召唤兽.数据[bb].装备[装备格子] ~= nil then
			local 临时道具=玩家数据[id].召唤兽.数据[bb].装备[装备格子]
		 玩家数据[id].召唤兽.数据[bb]:卸下装备(玩家数据[id].召唤兽.数据[bb].装备[装备格子],装备格子)
		 玩家数据[id].召唤兽.数据[bb].装备[装备格子] =nil
		 玩家数据[id].召唤兽.数据[bb]:穿戴装备(self.数据[道具id],装备格子)
		 self.数据[道具id]=临时道具
		else
		 玩家数据[id].召唤兽.数据[bb]:穿戴装备(self.数据[道具id],装备格子)
		 self.数据[道具id]=nil
		 玩家数据[id].角色[类型][道具]=nil
		end
		self:刷新道具行囊(id,数据.类型)
		发送数据(连接id,20,玩家数据[id].召唤兽.数据[bb]:取存档数据())
		发送数据(连接id,28)
	end
end

function 道具处理类:召唤兽可装备(i1,i2,等级,id)
	if i1 ~= nil and i1.分类 - 6 == i2 then
		if (i1.级别限制 == 0 or i1.特效 == "无级别限制" or 等级 >= i1.级别限制) then
			return true
		else
			if i1.级别限制 > 等级 then
				常规提示(id,"#Y/你的召唤兽等级不足哦")
			end
		end
	end
	return false
end

function 道具处理类:取随机装备(id,等级,返回)
	local 临时等级=等级
	local 临时参数=取随机数(1,#书铁范围)
	if 取随机数()<=40 then
		临时参数=取随机数(19,#书铁范围)
	end
	local 临时序列=临时参数
	if 临时序列==25 then
		临时序列=23
	elseif 临时序列==24 then
		临时序列=22
	elseif 临时序列==23 or 临时序列==22 then
		临时序列=21
	elseif 临时序列==21 then
		临时序列=20
	elseif 临时序列==20 or 临时序列==19 then
		临时序列=19
	end
	-- local 临时等级=玩家数据[id].道具.数据[制造格子].子类/10
	-- 计算武器值
	if 临时序列<=18 and 临时等级>=9 then --是武器 10-12是普通光武
		临时等级=取随机数(10,12)
	else
		if 临时等级>=12 then
			临时等级=10
		end
	end
	local 临时类型=装备处理类.打造物品[临时序列][临时等级+1]
	if type(临时类型)=="table" then
		if 临时参数 ==23 then
		 临时类型=临时类型[2]
		elseif 临时参数 ==22 then
		 临时类型=临时类型[1]
		elseif 临时参数 ==20 then
		 临时类型=临时类型[2]
		elseif 临时参数 ==19 then
		 临时类型=临时类型[1]
		else
			临时类型=临时类型[取随机数(1,2)]
		end
	end
	装备处理类:生成打造装备(id,临时等级*10,临时序列,临时类型,"系统产出") --所有系统产出的都给他未鉴定，让他自己鉴定去
	if 返回 then
		return 临时类型
	end
end

function 道具处理类:取随机装备1(id,等级,名称)
	-- 装备处理类:生成装备(id,等级*10,取装备序列(名称),名称,nil,true,"系统产出")
	装备处理类:生成打造装备(id,等级*10,取装备序列(名称),名称,"系统产出")
end

function 道具处理类:给予超链接书铁(id,等级,类型,链接)
	if 类型==nil then  --随机获取
		self.临时随机=取随机数()
		if self.临时随机<=50 then
			self.书铁名称="制造指南书"
		else
			self.书铁名称="百炼精铁"
		end
		local 书铁等级=取随机数(等级[1]*10,等级[2]*10)
		local 书铁种类=取随机数(1,#书铁范围)
		if 取随机数()<=40 then
			书铁种类=取随机数(19,#书铁范围)
		end
		书铁等级=math.floor(书铁等级/10)*10
		self:给予超链接道具(id,self.书铁名称,书铁等级,书铁种类,链接,"成功")
		return {self.书铁名称,书铁等级,书铁种类}
	else
		if 类型=="书" then
			self.临时随机=取随机数()
			self.书铁名称="制造指南书"
			local 书铁等级=取随机数(等级[1]*10,等级[2]*10)
			local 书铁种类=取随机数(1,#书铁范围)
			if 取随机数()<=40 then
				书铁种类=取随机数(19,#书铁范围)
			end
			书铁等级=math.floor(书铁等级/10)*10
			self:给予超链接道具(id,self.书铁名称,书铁等级,书铁种类,链接,"成功")
			return {self.书铁名称,书铁等级,书铁种类}
		else
			self.临时随机=取随机数()
			self.书铁名称="百炼精铁"
			local 书铁等级=取随机数(等级[1]*10,等级[2]*10)
			书铁等级=math.floor(书铁等级/10)*10
			self:给予超链接道具(id,self.书铁名称,书铁等级,书铁种类,链接,"成功")
			return {self.书铁名称,书铁等级}
		end
	end
end
function 道具处理类:给予书铁(id,等级,类型)
	if 类型==nil then  --随机获取
		self.临时随机=取随机数()
		if self.临时随机<=50 then
			self.书铁名称="制造指南书"
		else
			self.书铁名称="百炼精铁"
		end
		local 书铁等级=取随机数(等级[1]*10,等级[2]*10)
		local 书铁种类=取随机数(1,#书铁范围)
		if 取随机数()<=40 then
			书铁种类=取随机数(19,#书铁范围)
		end
		书铁等级=math.floor(书铁等级/10)*10
		self:给予道具(id,self.书铁名称,书铁等级,书铁种类)
		return {self.书铁名称,书铁等级,书铁种类}
	else
		if 类型=="书" then
			self.临时随机=取随机数()
			self.书铁名称="制造指南书"
			local 书铁等级=取随机数(等级[1]*10,等级[2]*10)
			local 书铁种类=取随机数(1,#书铁范围)
			if 取随机数()<=40 then
				书铁种类=取随机数(19,#书铁范围)
			end
			书铁等级=math.floor(书铁等级/10)*10
			self:给予道具(id,self.书铁名称,书铁等级,书铁种类)
			return {self.书铁名称,书铁等级,书铁种类}
		else
			self.临时随机=取随机数()
			self.书铁名称="百炼精铁"
			local 书铁等级=取随机数(等级[1]*10,等级[2]*10)
			书铁等级=math.floor(书铁等级/10)*10
			self:给予道具(id,self.书铁名称,书铁等级)
			return {self.书铁名称,书铁等级}
		end
	end
end

function 道具处理类:飞行符传送(连接id,id,内容)
	local 传送序列=内容.序列
	if self:取飞行限制(id)==false then
		local 包裹类型=玩家数据[id].道具操作.类型
		local 道具格子=玩家数据[id].道具操作.编号
		local 道具id=玩家数据[id].角色[包裹类型][道具格子]
		地图处理类:跳转地图(id,self.飞行传送点[传送序列][1],self.飞行传送点[传送序列][2],self.飞行传送点[传送序列][3])
		self:删除道具(连接id,id,包裹类型,道具id,道具格子,删除数量)
		发送数据(连接id,3699)
	end
end

function 道具处理类:新春飞行符传送(连接id,id,内容)
	if 玩家数据[id].最后操作=="新春飞行符" then
		if self:取飞行限制(id)==false then
			local 地图id=内容.地图
			local 坐标=内容.zb
			local 包裹类型=玩家数据[id].道具操作.类型
			local 道具格子=玩家数据[id].道具操作.编号
			local 道具id=玩家数据[id].角色[包裹类型][道具格子]
			if self.数据[道具id].名称=="新春飞行符" then
						if self.数据[道具id].次数 then
					self.数据[道具id].次数 =self.数据[道具id].次数-1
					if self.数据[道具id].次数<=0 then
						 self:删除道具(连接id,id,包裹类型,道具id,道具格子,删除数量)
					end
				end
				地图处理类:跳转地图(id+0,地图id,坐标.x,坐标.y)
				道具刷新(id)
			end
		end
		 玩家数据[id].最后操作=nil
	end
end

function 道具处理类:取加血道具(名称)
	local 临时名称={"包子","草果","山药","九香虫","八角莲叶","人参","烤鸭","翡翠豆腐","烤肉","臭豆腐","金创药","小还丹","千年保心丹","金香玉","天不老","紫石英","血色茶花","熊胆","鹿茸","六道轮回","凤凰尾","硫磺草","龙之心屑","火凤之睛","四叶花","天青地白","七叶莲"}
	for n=1,#临时名称 do
		if 临时名称[n]==名称 then
			return true
		end
	end
	return false
end

function 道具处理类:取寿命道具(名称)
	local 临时名称={"桂花丸","长寿面","豆斋果"}
	for n=1,#临时名称 do
		if 临时名称[n]==名称 then
			return true
		end
	end
	return false
end

function 道具处理类:取寿命道具1(名称,道具id)
	local 品质=self.数据[道具id].阶品
	local 数值=0
	local 中毒=0
	if 名称=="桂花丸" then
		数值=品质*0.5
	elseif 名称=="豆斋果" then
		数值=品质*3
		中毒=3
	elseif 名称=="长寿面" then
		数值=品质*2+50
		中毒=3
	end
	return {数值=qz(数值),中毒=中毒}
end

function 道具处理类:取加魔道具(名称)
	local 临时名称={"翡翠豆腐","佛跳墙","蛇蝎美人","风水混元丹","定神香","十香返生丸","丁香水","月星子","仙狐涎","地狱灵芝","麝香","血珊瑚","餐风饮露","白露为霜","天龙水","孔雀红","紫丹罗","佛手","旋复花","龙须草","百色花","香叶","白玉骨头","鬼切草","灵脂","曼陀罗花"}
	for n=1,#临时名称 do
		if 临时名称[n]==名称 then
			return true
		end
	end
	return false
end

function 道具处理类:取加血道具1(名称,道具id)
	local 品质=self.数据[道具id].阶品
	if 品质 == nil then
		品质 = 1
	end
	local 数值=0
	if 名称=="包子" then
	 数值=100
	elseif 名称=="烤鸭" then
	 数值=品质*10+100
	elseif 名称=="烤肉" then
	 数值=品质*10
	elseif 名称=="臭豆腐" then
	 数值=品质*20+200
	elseif 名称=="翡翠豆腐" then
	 数值=品质*15+150
	elseif 名称=="草果" then
	 数值=0
	elseif 名称=="山药" then
	 数值=40
	elseif 名称=="九香虫" then
	 数值=0
	elseif 名称=="八角莲叶" then
	 数值=60
	elseif 名称=="人参" then
	 数值=80
	elseif 名称=="金创药" then
	 数值=400
	elseif 名称=="小还丹" then --恢复气血=品质×18+100,疗伤=品质+80
	 数值=品质*15+100
	elseif 名称=="金香玉" or 名称=="固本培元丹" then --恢复气血=品质×12+150
	 数值=品质*20+100
	elseif 名称=="千年保心丹" or 名称=="十全大补丸" then --恢复血气=品质×4+200,疗伤=品质×4+100
	 数值=品质*10+200
	elseif 名称=="五龙丹" or 名称=="舒筋活络丸" then --解除封类异常状态,恢复气血=品质×3。  解封成功率=(五龙品质+100-人物等级+60)%，最低几率为40%
	 数值=品质*9
	elseif 名称=="佛光舍利子" then --复活并回复气血=品质×3,临时气血上限=品质×7+100
	 数值=品质*10
	elseif 名称=="九转回魂丹" or 名称=="九转续命丹" then --复活人物并恢复气血=品质×5+100
	 数值=品质*10+200
	elseif 名称=="天不老" or 名称=="紫石英" then
	 数值=100
	elseif 名称=="血色茶花" or 名称=="鹿茸" then
	 数值= 150
	elseif 名称=="六道轮回" or 名称=="熊胆" then
	 数值= 200
	elseif 名称=="凤凰尾" or 名称=="硫磺草" then
	 数值= 250
	elseif 名称=="龙之心屑" or 名称=="火凤之睛" then
	 数值= 300
	elseif 名称=="四叶花" then
	 数值= 40
	elseif 名称=="天青地白" then
	 数值= 80
	elseif 名称=="七叶莲" then
	 数值= 60
	end
	return qz(数值)
end

function 道具处理类:取加血道具2(名称,道具id)
	local 品质=self.数据[道具id].阶品
	local 数值=0
	if 名称=="包子" then
	 数值=0
	elseif 名称=="烤鸭" then
	 数值=品质*5
	elseif 名称=="烤肉" then
	 数值=品质*10+10
	elseif 名称=="臭豆腐" then
	 数值=0
	elseif 名称=="翡翠豆腐" then
	 数值=0
	elseif 名称=="草果" then
	 数值=10
	elseif 名称=="山药" then
	 数值=10
	elseif 名称=="九香虫" then
	 数值=15
	elseif 名称=="八角莲叶" then
	 数值=15
	elseif 名称=="人参" then
	 数值=20
	elseif 名称=="金创药" then
	 数值=400
	elseif 名称=="小还丹" then
	 数值=品质+500
	elseif 名称=="金香玉" then
	 数值=0
	elseif 名称=="千年保心丹" then
	 数值=品质*8+100
	elseif 名称=="五龙丹" then
	 数值=0
	elseif 名称=="佛光舍利子" then
	 数值=0
	elseif 名称=="九转回魂丹" then
	 数值=0
	elseif 名称=="天不老" or 名称=="紫石英" then
	 数值=0
	elseif 名称=="血色茶花" or 名称=="鹿茸" then
	 数值= 0
	elseif 名称=="六道轮回" or 名称=="熊胆" then
	 数值= 0
	elseif 名称=="凤凰尾" or 名称=="硫磺草" then
	 数值= 0
	elseif 名称=="龙之心屑" or 名称=="火凤之睛" then
	 数值= 0
	elseif 名称=="四叶花" then
	 数值= 0
	elseif 名称=="天青地白" then
	 数值= 0
	elseif 名称=="七叶莲" then
	 数值= 0
	end
	return qz(数值)
end

function 道具处理类:取加魔道具1(名称,道具id)
	local 品质=self.数据[道具id].阶品
	local 数值=0
	if 名称=="佛跳墙" or 名称=="翡翠豆腐" then
	 数值=品质*10+100
	elseif 名称=="定神香"  then
	 数值=品质*15+50
	elseif 名称=="风水混元丹"  then
	 数值=品质*13+50
	elseif 名称=="蛇蝎美人"or 名称=="凝气丸"then
	 数值=品质*15+100
	elseif 名称=="十香返生丸" or 名称=="七珍丸"  then
	 数值=品质*13+50
	elseif 名称=="女儿红" or 名称=="虎骨酒"  then
	 数值=20
	elseif 名称=="珍露酒"  then
	 数值=品质*0.4+20
	elseif 名称=="梅花酒"  then
	 数值=品质*0.6
	elseif 名称=="百味酒"  then
	 数值=品质*0.7
	elseif 名称=="蛇胆酒" or 名称=="醉生梦死"  or 名称=="醉仙果" then
	 数值=品质*1
	elseif 名称=="丁香水" or 名称=="月星子"  then
	 数值=75
	elseif 名称=="仙狐涎" or 名称=="地狱灵芝" or 名称=="麝香" or 名称=="血珊瑚" or 名称=="餐风饮露" or 名称=="白露为霜"  then
	 数值=100
	elseif 名称=="天龙水" or 名称=="孔雀红"  then
	 数值=150
	elseif 名称=="紫丹罗" or 名称=="佛手" or 名称=="旋复花" then
	 数值=20
	elseif 名称=="龙须草" or 名称=="百色花" or 名称=="香叶"  then
	 数值=30
	elseif 名称=="白玉骨头" or 名称=="鬼切草" or 名称=="灵脂"  then
	 数值=40
	elseif 名称=="曼陀罗花"  then
	 数值=50
	end
	return qz(数值)
end

function 道具处理类:清空包裹(连接id,id)
	for n=1,20 do
		if 玩家数据[id].角色.道具[n]~=nil then
			self.数据[玩家数据[id].角色.道具[n]]=nil
			玩家数据[id].角色.道具[n]=nil
		end
	end
	发送数据(连接id,3699)
end

function 道具处理类:清空所有包裹(连接id,id)
	for n=1,80 do
		if 玩家数据[id].角色.道具[n]~=nil then
			self.数据[玩家数据[id].角色.道具[n]]=nil
			玩家数据[id].角色.道具[n]=nil
		end
	end
	发送数据(连接id,3699)
end


function 道具处理类:取是否有相同内丹(id,加血对象,技能)
	local wz = 0
	for i=1,玩家数据[id].召唤兽.数据[加血对象].内丹[1] do
			if 玩家数据[id].召唤兽.数据[加血对象].内丹.技能[i]~= nil and 玩家数据[id].召唤兽.数据[加血对象].内丹.技能[i].技能 == 技能 then
				wz = i
			end
	end
	return wz
end
function 道具处理类:取是内丹空格子(id,加血对象)
	local wz = 0
	for i=1,玩家数据[id].召唤兽.数据[加血对象].内丹[1] do
		if 玩家数据[id].召唤兽.数据[加血对象].内丹.技能[i] == nil then
			wz = i
			return wz
		end
	end
end
function 道具处理类:符纸使用(连接id,id,内容)
	-- table.print(内容)
	local 包裹类型=内容.类型
	local 道具格子=内容.道具格子
	local 符纸格子 =内容.符纸格子
	local 删除数量=1
	local 道具id=玩家数据[id].角色["道具"][符纸格子]
	local 装备=玩家数据[id].角色["道具"][道具格子]
	if self.数据[道具id] == nil or self.数据[装备] == nil then
		常规提示(id,"#Y/数据异常！")
		return
	end


--------------------------------武器附神-------------------------------------
	if 包裹类型=="武器附神" then
		local 神附强度= 1 + math.random(15,50)/100
		local 神附品阶=""
		if 神附强度 <= 1.5 then 神附品阶="神赐" end
		if 神附强度 <= 1.4 then 神附品阶="完美" end
		if 神附强度 <= 1.3 then 神附品阶="神圣" end
		if 神附强度 <= 1.2 then 神附品阶="卓越" end

		if self.数据[装备].武器神附 then self.数据[装备].武器神附[1]=神附品阶 end
		if self.数据[装备].武器神附[2]==nil then
				self.数据[装备].武器神附[2] = 1
				if self.数据[装备].命中==nil then self.数据[装备].武器神附[4]=0  else self.数据[装备].武器神附[4] = self.数据[装备].命中 + 0 end
				if self.数据[装备].伤害==nil then self.数据[装备].武器神附[5]=0  else self.数据[装备].武器神附[5] = self.数据[装备].伤害 + 0 end
				if self.数据[装备].体质==nil then self.数据[装备].武器神附[6]=0  else self.数据[装备].武器神附[6] = self.数据[装备].体质 + 0 end
				if self.数据[装备].魔力==nil then self.数据[装备].武器神附[7]=0  else self.数据[装备].武器神附[7] = self.数据[装备].魔力 + 0 end
				if self.数据[装备].力量==nil then self.数据[装备].武器神附[8]=0  else self.数据[装备].武器神附[8] = self.数据[装备].力量 + 0 end
				if self.数据[装备].耐力==nil then self.数据[装备].武器神附[9]=0  else self.数据[装备].武器神附[9] = self.数据[装备].耐力 + 0 end
				if self.数据[装备].敏捷==nil then self.数据[装备].武器神附[10]=0  else self.数据[装备].武器神附[10] = self.数据[装备].敏捷 + 0 end
				if self.数据[装备].灵力==nil then self.数据[装备].武器神附[11]=0 else  self.数据[装备].武器神附[11] = self.数据[装备].灵力 + 0 end
		end

				if self.数据[装备].命中~=nil and self.数据[装备].命中~=0 then  self.数据[装备].命中 = math.floor( self.数据[装备].武器神附[4] * 神附强度 )  end
				if self.数据[装备].伤害~=nil and self.数据[装备].伤害~=0 then  self.数据[装备].伤害 = math.floor( self.数据[装备].武器神附[5] * 神附强度 )  end
				if self.数据[装备].体质~=nil and self.数据[装备].体质~=0 then  self.数据[装备].体质 = math.floor( self.数据[装备].武器神附[6] * 神附强度 )  end
				if self.数据[装备].魔力~=nil and self.数据[装备].魔力~=0 then  self.数据[装备].魔力 = math.floor( self.数据[装备].武器神附[7] * 神附强度 )  end
				if self.数据[装备].力量~=nil and self.数据[装备].力量~=0 then  self.数据[装备].力量 = math.floor( self.数据[装备].武器神附[8] * 神附强度 )  end
				if self.数据[装备].耐力~=nil and self.数据[装备].耐力~=0 then  self.数据[装备].耐力 = math.floor( self.数据[装备].武器神附[9] * 神附强度 )  end
				if self.数据[装备].敏捷~=nil and self.数据[装备].灵力~=0 then  self.数据[装备].敏捷 = math.floor( self.数据[装备].武器神附[10] * 神附强度 )  end
				if self.数据[装备].灵力~=nil and self.数据[装备].敏捷~=0 then  self.数据[装备].灵力 = math.floor( self.数据[装备].武器神附[11] * 神附强度 )  end
			self.数据[装备].武器神附[11]=神附强度

		self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
		常规提示(id,"#G武器附神成功！")
		发送数据(连接id,3699)
    道具刷新(id)
	end
---------------------------------------------------------------------------------------------------


	if 包裹类型=="强化符" then
		local 强化效果  = {}
		强化效果 = 取强化符效果(self.数据[道具id].技能,self.数据[道具id].等级,self.数据[装备].分类)
		if 强化效果.类型 == "无" then return 常规提示(id,"#Y/附魔部位不正确") end
		if self.数据[装备].分类==1 or self.数据[装备].分类==2 or self.数据[装备].分类==4 then --项链，铠甲，头盔 不能同时存在多个
			self.数据[装备].临时附魔 = {}
		else
			if self.数据[装备].临时附魔 == nil then
				self.数据[装备].临时附魔 = {}
			end
		end
		self.数据[装备].临时附魔[强化效果.类型] = {}
		self.数据[装备].临时附魔[强化效果.类型].数值 = 强化效果.数值
		self.数据[装备].临时附魔[强化效果.类型].时间 = os.time()+86400*3    --临时符时间修改 强化符时间修改

		常规提示(id,"#Y/装备附魔成功！")
		self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
		发送数据(连接id,3699)
		return
	elseif 包裹类型=="双加转换" then
		local 附加范围={"力量","敏捷","体质","耐力","魔力"}
		local zbysj={}
		for an=1,#附加范围 do
			if self.数据[装备][附加范围[an]]~=nil then
				table.insert(zbysj,self.数据[装备][附加范围[an]])
				self.数据[装备][附加范围[an]]=nil
			end
		end
		if #zbysj <= 0 then
			常规提示(id,"#Y/一个双加都没转换个毛线！")
			return
		else
		  	for an=1,#zbysj do
		  		local qsj=取随机数(1,#附加范围)
		  		self.数据[装备][附加范围[qsj]] = zbysj[an]
		  		table.remove(附加范围,qsj)
		  	end
		  	常规提示(id,"#Y/转换成功！")
		  	self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
				发送数据(连接id,3699)
				return
		end
	elseif 包裹类型=="不磨符" then
	  local	txbh=false
	  if self.数据[装备].特效[3]==nil then
	  	txbh=#self.数据[装备].特效 + 1
	  else
			for i=1,3 do
				if self.数据[装备].特效[i]~="无级别限制" then
					txbh = i
					break
				end
			end
		end
		if 取随机数(1,100)<= 50 then
			self.数据[装备].特效[txbh] = "永不磨损"
			常规提示(id,"#Y/附加不磨成功！")
		else
		  常规提示(id,"#Y/附加不磨失败！")
		end
		self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
		发送数据(连接id,3699)
		return

	elseif 包裹类型=="装备鉴定" then
		if self.数据[装备].鉴定 == false then
			if self.数据[道具id].子类 >= self.数据[装备].级别限制 then
				self.数据[装备].鉴定 = true
				self.数据[装备].专用提示=nil --直接删除该项
				常规提示(id,"#Y/物品鉴定成功！")
				常规提示(id,"#Y/可以查询装备的属性范围。")
				self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
				装备处理类:装备鉴定处理(连接id,id,self.数据[装备])
				发送数据(连接id,3699)
			else
				常规提示(id,"#Y/此图鉴的等级过低无法鉴定该装备")
				return
			end
		else
			常规提示(id,"#Y/这件装备已经鉴定过了请不要重复鉴定")
			return
		end
	elseif 包裹类型=="灵饰鉴定" then
		if self.数据[装备].鉴定 == false then
			local 物品=取物品数据(self.数据[装备].名称)
			local 级别=物品[5]
			if self.数据[道具id].子类 >= 级别 then
				self.数据[装备].鉴定 = true
				常规提示(id,"#Y/物品鉴定成功")
				self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
				if self.数据[装备].幻化属性.附加 then
					local go = self.数据[装备].幻化属性.附加[1].类型
					for i=1,#self.数据[装备].幻化属性.附加 do
						if go~=self.数据[装备].幻化属性.附加[i].类型 then
							go=false
							break
						end
					end

					if go~=false and #self.数据[装备].幻化属性.附加==4 then
						local xt1 = "沉默眷顾之神赐耳饰"
						local xt2 = "鉴定出一个四种属性皆一样的耳饰"
						if self.数据[装备].子类==2 then
							xt1 = "沉默眷顾之神赐佩饰"
							xt2 = "鉴定出一个四种属性皆一样的佩饰"
						elseif self.数据[装备].子类==3 then
							xt1 = "沉默眷顾之神赐戒指"
							xt2 = "鉴定出一个四种属性皆一样的戒指"
						elseif self.数据[装备].子类==4 then
							xt1 = "沉默眷顾之神赐手镯"
							xt2 = "鉴定出一个四种属性皆一样的手镯"
						end
						发送数据(连接id,105,{头像=xt1,标题=xt1,说明=xt2})
					end
				end
				if 取随机数(1,100)<=10 then
					self.数据[装备].特效="超级简易"
				end
				发送数据(连接id,3699)
			else
				常规提示(id,"#Y/此图鉴的等级过低无法鉴定该装备")
				return
			end
		else
			常规提示(id,"#Y/这件装备已经鉴定过了请不要重复鉴定")
			return
		end
	elseif 包裹类型=="特技书" then
		if not self.数据[装备].鉴定 then
			常规提示(id,"#Y/这个装备未鉴定无法附加特技")
			return
		end
		if self.数据[装备].总类~=2 or self.数据[装备].灵饰 or self.数据[装备].召唤兽装备 then
			常规提示(id,"该物品只能对人物装备使用")
			return
		end
		if self.数据[道具id].名称~=包裹类型 then
			return
		end
		self:删除道具(连接id,id,"道具",道具id,符纸格子,1)
		local tj ={"琴音三叠","弱点击破","破血狂攻","心疗术","破碎无双","诅咒之伤","太极护法","罗汉金钟","慈航普度","放下屠刀","笑里藏刀","碎甲术","金刚怒目","命归术","心如明镜","气归术","命疗术","流云诀","破甲术","气归术","凝气诀","凝神诀","命疗术","流云诀","啸风诀","河东狮吼","破甲术","凝滞术","吸血特技","金刚不坏","菩提心佑","起死回生","回魂咒","气疗术","野兽之力","魔兽之印","修罗咒","身似菩提","光辉之甲","圣灵之甲","四海升平","水清诀","玉清诀","冰清诀","晶清诀"}
		if self.数据[装备].特技~=nil then
			for k,v in pairs(tj) do
				if v==self.数据[装备].特技 then
					table.remove(tj,k)
					break
				end
			end
		end
		self.数据[装备].特技=tj[取随机数(1,#tj)]
		  常规提示(id,"#G添加装备特技成功！")
		  发送数据(连接id,3699)

	elseif 包裹类型=="装备特效宝珠" then
		if not self.数据[装备].鉴定 then
			常规提示(id,"#Y/这个装备未鉴定无法附加特效")
			return
		end
		if self.数据[装备].总类~=2 or self.数据[装备].灵饰 or self.数据[装备].召唤兽装备 then
			常规提示(id,"该物品只能对人物装备使用")
			return
		end
		if self.数据[道具id].名称~=包裹类型 then
			return
		end

		self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
		local tx = {}
		local 保底=15
		if RpbARGB.序列==4 then
			保底=30
		end
		if self.数据[装备].分类 == 1 then --头盔
			tx = {"珍宝","珍宝","简易","再生","精致","易修理"}
		elseif self.数据[装备].分类 == 2 then --项链
			tx = {"珍宝","坚固","珍宝","简易","神农","专注","精致"}
		elseif self.数据[装备].分类 == 3 then --武器
			tx = {"珍宝","坚固","简易","神佑","必中","绝杀","精致"}
		elseif self.数据[装备].分类 == 4 then --衣服
			tx = {"珍宝","坚固","简易","精致","易修理","伪装"}
		elseif self.数据[装备].分类 == 5 then --腰带
			tx = {"珍宝","坚固","简易","精致","易修理"}
		elseif self.数据[装备].分类 == 6 then --鞋子
			tx = {"珍宝","坚固","简易","精致","狩猎","迷踪","易修理"}
		end
		local wjbGl=12
		if RpbARGB.序列==3 then
		    wjbGl=2
		end
		if 取随机数()<=wjbGl then
		    table.insert(tx,"无级别限制")
		end
		if self.数据[装备].特效~=nil and self.数据[装备].特效[1] then
			for n=1,#tx do
				for i=1,#self.数据[装备].特效 do
					if tx[n]==self.数据[装备].特效[i] then
						table.remove(tx,n)
					end
				end
			end
			local sj = 取随机数(1,#tx)
			local num = 取随机数(1,#self.数据[装备].特效)
			self.数据[装备].特效[num]=tx[sj]
			if tx[sj]~="无级别限制" then
				if self.数据[装备].附魔次数==nil then
					self.数据[装备].附魔次数=0
				end
				self.数据[装备].附魔次数=self.数据[装备].附魔次数+1
				if self.数据[装备].附魔次数>=保底 then
					self.数据[装备].附魔次数=nil
					self.数据[装备].特效[num]="无级别限制"
				end
			end
		else
			self.数据[装备].特效={}
			local dwq=tx[取随机数(1,#tx)]
			self.数据[装备].特效[1]=dwq
			if dwq~="无级别限制" then
				if self.数据[装备].附魔次数==nil then
					self.数据[装备].附魔次数=0
				end
				self.数据[装备].附魔次数=self.数据[装备].附魔次数+1
				if self.数据[装备].附魔次数>=保底 then--性感30
					self.数据[装备].附魔次数=nil
					self.数据[装备].特效[1]="无级别限制"
				end
			end
		end
		常规提示(id,"#G添加装备特效成功！")
		发送数据(连接id,3699)
	elseif 包裹类型=="淬灵石" then

		if self.数据[道具id].特性 ==nil then
		 	self.数据[道具id].特性={等级=0,技能=""}
		end

		if self.数据[道具id].特性.技能 == "" and self.数据[装备].特性.技能 ~= nil then
				  	  self.数据[道具id].特性.等级 = self.数据[装备].特性.等级
				  	  self.数据[道具id].特性.技能 = self.数据[装备].特性.技能
                      self.数据[装备].特性 = nil
				  	  常规提示(id,"吸附灵饰特性成功。")
				  	  发送数据(连接id,3699)
				  	  道具刷新(id)
				      return
                else
		if not self.数据[装备].鉴定 then
			常规提示(id,"#Y/这个装备未鉴定无法附加特效")
			return
		elseif not self.数据[装备].灵饰 then
			常规提示(id,"该物品只能对灵饰使用")
			return
		elseif self.数据[道具id].名称~=包裹类型 then
			return

		elseif  self.数据[装备].特性~=nil then
			if   self.数据[道具id].特性.技能 ~= self.数据[装备].特性.技能  then
			常规提示(id,"请使用你灵饰前面的特性类型！")
			return
		elseif self.数据[道具id].特性.等级 <= self.数据[装备].特性.等级  then
			常规提示(id,"宝石等级不符合")
			return
		end
	end

		if self.数据[装备].特性 ==nil then
		 	self.数据[装备].特性={等级=0,技能=""}
		end
		--if self.数据[装备].特性.技能 == "" then
			self.数据[装备].特性.技能=self.数据[道具id].特性.技能
			--self.数据[装备].特性.等级=self.数据[道具id].特性.等级
		--end
		self.数据[装备].特性.等级=self.数据[装备].特性.等级+self.数据[道具id].特性.等级
		self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
		常规提示(id,"#G添加灵饰特性成功！")
		发送数据(连接id,3699)
        道具刷新(id)
		end

	elseif 包裹类型=="灵饰特效宝珠" then
		if not self.数据[装备].鉴定 then
			常规提示(id,"#Y/这个装备未鉴定无法附加特效")
			return
		end
		if not self.数据[装备].灵饰 then
			常规提示(id,"该物品只能对灵饰使用")
			return
		end
		if self.数据[装备].特效 == "无级别限制" then
			常规提示(id,"该装备已经拥有该特效了，不要浪费哦。")
			return
		end
		if self.数据[道具id].名称~=包裹类型 then
			return
		end
		self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
		local num=21
		if RpbARGB.序列==3 then
		    num=11
		end
		if 取随机数()<=num then
			self.数据[装备].特效="无级别限制"
			常规提示(id,"#G添加装备特效成功！")
		else
			常规提示(id,"#R很遗憾，附魔失败！")
		end
		发送数据(连接id,3699)


	elseif 包裹类型=="钟灵石" then
		if self.数据[装备].特性 ==nil then
		 	self.数据[装备].特性={等级=0,技能=""}
		end
		if not self.数据[装备].鉴定 then
			常规提示(id,"#Y/这个装备未鉴定无法附加特效")
			return
		elseif not self.数据[装备].灵饰 then
			常规提示(id,"该物品只能对灵饰使用")
			return
		elseif self.数据[道具id].名称~=包裹类型 then
			return
		elseif self.数据[装备].特性  and self.数据[装备].特性.技能 ~= ""  and self.数据[装备].特性.技能 ~= self.数据[道具id].技能 then
			常规提示(id,"请使用你灵饰前面的特性类型！")
			return
		elseif self.数据[道具id].级别限制 <= self.数据[装备].特性.等级  then
			常规提示(id,"宝石等级不符合")
			return
		end
		if self.数据[装备].特性.技能 == "" then
				self.数据[装备].特性.技能=self.数据[道具id].技能
		end
		self.数据[装备].特性.等级=self.数据[装备].特性.等级+1
		self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
		常规提示(id,"#G添加灵饰特性成功！")
		发送数据(连接id,3699)

		elseif 包裹类型=="器灵·无双" then
		if not self.数据[装备].鉴定 then
			常规提示(id,"#Y/这个装备未鉴定无法附加特效")
			return
		end
		if self.数据[装备].总类~=2 or self.数据[装备].灵饰 or self.数据[装备].召唤兽装备 then
			常规提示(id,"该物品只能对人物装备使用")
			return
		end
		if self.数据[道具id].名称~=包裹类型 then
			return
		end
		local 道具类型=0
		if self.数据[道具id].限制 == "头盔" then --头盔
			道具类型=1
		elseif self.数据[道具id].限制 == "项链" then --项链
			道具类型=2
		elseif self.数据[道具id].限制 == "武器" then --武器
			道具类型=3
		elseif self.数据[道具id].限制 == "衣服" then --衣服
			道具类型=4
		elseif self.数据[道具id].限制 == "腰带" then --腰带
			道具类型=5
		elseif self.数据[道具id].限制 == "鞋子" then --鞋子
			道具类型=6
		end
		if 道具类型~=self.数据[装备].分类 then
			常规提示(id,"请检查附加的装备部位是否正确")
			return
		end
		if self.数据[道具id].级别限制<self.数据[装备].级别限制 then
			常规提示(id,"请检查附加的装备等级是否正确")
			return
		end
		self.数据[装备].器灵="无双"
		self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
		常规提示(id,"装备无双效果附加成功")
		发送数据(连接id,3699)



elseif 包裹类型=="器灵·金蝉" then
		if not self.数据[装备].鉴定 then
			常规提示(id,"#Y/这个装备未鉴定无法附加特效")
			return
		end
		if self.数据[装备].总类~=2 or self.数据[装备].灵饰 or self.数据[装备].召唤兽装备 then
			常规提示(id,"该物品只能对人物装备使用")
			return
		end
		if self.数据[道具id].名称~=包裹类型 then
			return
		end
		local 道具类型=0
		if self.数据[道具id].限制 == "头盔" then --头盔
			道具类型=1
		elseif self.数据[道具id].限制 == "项链" then --项链
			道具类型=2
		elseif self.数据[道具id].限制 == "武器" then --武器
			道具类型=3
		elseif self.数据[道具id].限制 == "衣服" then --衣服
			道具类型=4
		elseif self.数据[道具id].限制 == "腰带" then --腰带
			道具类型=5
		elseif self.数据[道具id].限制 == "鞋子" then --鞋子
			道具类型=6
		end
		if 道具类型~=self.数据[装备].分类 then
			常规提示(id,"请检查附加的装备部位是否正确")
			return
		end
		if self.数据[道具id].级别限制<self.数据[装备].级别限制 then
			常规提示(id,"请检查附加的装备等级是否正确")
			return
		end
		self.数据[装备].器灵="金蝉"
		self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
		常规提示(id,"装备金蝉效果附加成功")
		发送数据(连接id,3699)
-----------------------------------------无双移植--------
elseif 包裹类型=="元素曜石" then

		if self.数据[道具id].名称~="元素曜石·冰" and  self.数据[道具id].名称~="元素曜石·风" and  self.数据[道具id].名称~="元素曜石·火"   and  self.数据[道具id].名称~="元素曜石·雷"   and  self.数据[道具id].名称~="元素曜石·水"   and  self.数据[道具id].名称~="元素曜石·岩"    then
			常规提示(id,"请使用正确的道具进行镶嵌")
			return
		end
		if not self.数据[道具id].部位 or not  self.数据[道具id].数值  or not  self.数据[道具id].级别限制 or self.数据[道具id].专用~=id then
			常规提示(id,"道具数据出错")
		return
		end
		if self.数据[装备].总类~=2 or self.数据[装备].灵饰 or self.数据[装备].召唤兽装备 then
			常规提示(id,"该物品只能对人物装备使用")
			return
		end
		local 道具类型=0
		if self.数据[道具id].部位 == "头盔" then --头盔
			道具类型=1
		elseif self.数据[道具id].部位 == "项链" then --项链
			道具类型=2
		elseif self.数据[道具id].部位 == "武器" then --武器
			道具类型=3
		elseif self.数据[道具id].部位 == "衣服" then --衣服
			道具类型=4
		elseif self.数据[道具id].部位 == "腰带" then --腰带
			道具类型=5
		elseif self.数据[道具id].部位 == "鞋子" then --鞋子
			道具类型=6
		end

		if 道具类型~=self.数据[装备].分类 then
			常规提示(id,"请检查附加的装备部位是否正确")
			return
		end
		-- if self.数据[道具id].级别限制~=self.数据[装备].级别限制 then
		-- 	常规提示(id,"请检查附加的装备等级是否正确")
		-- 	return
		-- end
		local 道具附加=""
		if self.数据[道具id].名称=="元素曜石·冰" then
			道具附加="防御"
		elseif  self.数据[道具id].名称=="元素曜石·风" then
			道具附加="速度"
		elseif  self.数据[道具id].名称=="元素曜石·火" then
			道具附加="伤害"
		elseif  self.数据[道具id].名称=="元素曜石·雷" then
			道具附加="固定伤害"
		elseif  self.数据[道具id].名称=="元素曜石·水" then
			道具附加="法伤"
		elseif  self.数据[道具id].名称=="元素曜石·岩" then
			道具附加="封印命中等级"
		end
		if not self.数据[装备].五行镶嵌 then
		self.数据[装备].五行镶嵌={}
		end
		if self.数据[装备].五行镶嵌[1]== nil then
		self.数据[装备].五行镶嵌[1]={属性=道具附加,数值=self.数据[道具id].数值}
		elseif  self.数据[装备].五行镶嵌[2]== nil then
		self.数据[装备].五行镶嵌[2]={属性=道具附加,数值=self.数据[道具id].数值}
		else
			if self.数据[装备].五行镶嵌[1].数值>= self.数据[装备].五行镶嵌[2].数值 then
			self.数据[装备].五行镶嵌[2]={属性=道具附加,数值=self.数据[道具id].数值}
			else
			self.数据[装备].五行镶嵌[1]={属性=道具附加,数值=self.数据[道具id].数值}
			end
		end
		self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
		常规提示(id,"装备元素宝石镶嵌成功")
		发送数据(连接id,3699)
	elseif 包裹类型=="器灵·金蝉" then
		if not self.数据[装备].鉴定 then
			常规提示(id,"#Y/这个装备未鉴定无法附加特效")
			return
		end
		if self.数据[装备].总类~=2 or self.数据[装备].灵饰 or self.数据[装备].召唤兽装备 then
			常规提示(id,"该物品只能对人物装备使用")
			return
		end
		if self.数据[道具id].名称~=包裹类型 then
			return
		end
		local 道具类型=0
		if self.数据[道具id].限制 == "头盔" then --头盔
			道具类型=1
		elseif self.数据[道具id].限制 == "项链" then --项链
			道具类型=2
		elseif self.数据[道具id].限制 == "武器" then --武器
			道具类型=3
		elseif self.数据[道具id].限制 == "衣服" then --衣服
			道具类型=4
		elseif self.数据[道具id].限制 == "腰带" then --腰带
			道具类型=5
		elseif self.数据[道具id].限制 == "鞋子" then --鞋子
			道具类型=6
		end
		if 道具类型~=self.数据[装备].分类 then
			常规提示(id,"请检查附加的装备部位是否正确")
			return
		end
		-- if self.数据[道具id].级别限制~=self.数据[装备].级别限制 then
		-- 	常规提示(id,"请检查附加的装备等级是否正确")
		-- 	return
		-- end


		self.数据[装备].器灵="金蝉"
		self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
		常规提示(id,"装备金蝉效果附加成功")
		发送数据(连接id,3699)

	elseif 包裹类型=="青铜灵物" then
		if not self.数据[装备].鉴定 then
			常规提示(id,"#Y/这个装备未鉴定无法附加特效")
			return
		end
		if self.数据[装备].总类~=2 or self.数据[装备].灵饰 or self.数据[装备].召唤兽装备 then
			常规提示(id,"该物品只能对人物装备使用")
			return
		end
		if self.数据[道具id].名称~=包裹类型 then
			return
		end
		self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
		if  self.数据[装备].上古残符==nil then
			常规提示(id,"该装备并没有附加过上古残符的力量")
			return
		end
		if self.数据[装备].上古残符.上次==nil then
			self.数据[装备].上古残符.上次=0
		end
		if self.数据[装备].上古残符.次数<=0 then
			return
		end
		local 五行={"金","木","水","火","土"}
		local 五行1=五行[取随机数(1,#五行)]

		self.数据[装备].上古残符.数值=self.数据[装备].上古残符.数值-self.数据[装备].上古残符.上次
		self.数据[装备].上古残符.次数=self.数据[装备].上古残符.次数-1
		self.数据[装备].上古残符.五行=五行1
		self.数据[装备].上古残符.上次=30

		if self.数据[装备].上古残符.数值<=0 then
			self.数据[装备].上古残符.数值=0
		end
		常规提示(id,"附加五行效果已经改变")
		常规提示(id,"附加数值已经清洗")

		发送数据(连接id,3699)
	elseif 包裹类型=="上古残符" then
		if not self.数据[装备].鉴定 then
			常规提示(id,"#Y/这个装备未鉴定无法附加特效")
			return
		end
		if self.数据[装备].总类~=2 or self.数据[装备].灵饰 or self.数据[装备].召唤兽装备 then
			常规提示(id,"该物品只能对人物装备使用")
			return
		end
		if self.数据[道具id].名称~=包裹类型 then
			return
		end
		self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
		local 数值1=取随机数(3,30)
		local 五行={"金","木","水","火","土"}
		local 五行1=五行[取随机数(1,#五行)]

		if self.数据[装备].上古残符==nil then
			self.数据[装备].上古残符={数值=0,五行="无",次数=0,上次=0}
		end
		if self.数据[装备].上古残符.上次==nil then
			self.数据[装备].上古残符.上次=0
		end
		if self.数据[装备].上古残符.次数>=10 then
			常规提示(id,"此装备熔炼已达10次，无法继续熔炼")
			return
		end

		self.数据[装备].上古残符.数值=self.数据[装备].上古残符.数值+数值1
		self.数据[装备].上古残符.上次 = 数值1
		self.数据[装备].上古残符.次数=self.数据[装备].上古残符.次数+1
		if self.数据[装备].上古残符.五行=="无" then
			self.数据[装备].上古残符.五行=五行1
		end

		常规提示(id,"#Y/添加装备附加效果成功！")
		发送数据(连接id,3699)
------------
	elseif 包裹类型=="愤怒符" then
		if not self.数据[装备].鉴定 then
			常规提示(id,"#Y/这个装备未鉴定无法附加特效")
			return
		end
		if self.数据[装备].总类~=2 or self.数据[装备].灵饰 or self.数据[装备].召唤兽装备 or self.数据[装备].分类~=5   then
			常规提示(id,"该物品只能腰带使用")
			return
		end
		if self.数据[道具id].名称~=包裹类型 then
			return
		end
		if self.数据[装备].特效~=nil and self.数据[装备].特效[1] then
			local go
			for i=1,#self.数据[装备].特效 do
				if self.数据[装备].特效[i]=="愤怒" then
					常规提示(id,"#Y/该装备已经拥有愤怒特效了，不要浪费哦。")
					return
				end
				if self.数据[装备].特效[i]=="无级别限制" then
					go=i
				end
			end
			if go~=nil then
				self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
				if #self.数据[装备].特效==1 then
					self.数据[装备].特效[#self.数据[装备].特效+1]="愤怒"
				else
					for i=1,100 do
						local sjs = 取随机数(1,#self.数据[装备].特效)
						if sjs~=go then
							self.数据[装备].特效[sjs]="愤怒"
							break
						end
					end
				end
			else
				常规提示(id,"#Y/不能附魔没有无级别限制的腰带。")
				return
			end
		else
			常规提示(id,"#Y/不能附魔没有无级别限制的腰带。")
			return

		end
		常规提示(id,"#G添加装备特效愤怒成功！")
		发送数据(连接id,3699)
	end
end

function 道具处理类:鉴定专用装备(连接id,id,内容)
	local 包裹类型=内容.类型
	local 道具格子=内容.道具格子
	local 符纸格子 =内容.符纸格子
	local 删除数量=1
	local 道具id=玩家数据[id].角色["道具"][符纸格子]
	local 装备=玩家数据[id].角色["道具"][道具格子]
	if self.数据[道具id] == nil or self.数据[装备] == nil or self.数据[装备].专用提示==nil then
		常规提示(id,"#Y/数据错误请重新鉴定")
	end
	if 包裹类型=="装备鉴定" then
		if self.数据[装备].鉴定 == false then
			if self.数据[道具id].子类 >= self.数据[装备].级别限制 then
				self.数据[装备].鉴定 = true
				self.数据[装备].专用提示=nil
				常规提示(id,"#Y/物品鉴定成功！")
				常规提示(id,"#Y/可以通过梦幻精灵网页版查询装备的属性范围，你有兴趣的话可以去瞧瞧。")
				self:删除道具(连接id,id,"道具",道具id,符纸格子,删除数量)
				装备处理类:装备鉴定处理(连接id,id,self.数据[装备],true)
				发送数据(连接id,3699)
			else
				常规提示(id,"#Y/此图鉴的等级过低无法鉴定该装备")
				return
			end
		else
			常规提示(id,"#Y/这件装备已经鉴定过了请不要重复鉴定")
			return
		end
	end
end

function 道具处理类:取队长权限(id)
	if 玩家数据[id].队伍==0 then
		return true
	elseif 玩家数据[id].队伍~=0 and 玩家数据[id].队长 then
		return true
	else
		return false
	end
end

function 道具处理类:加血处理(连接id,id,加血数值,加血对象,动画,伤势数值)
	if 动画==nil then
		动画="加血"
	end
	if 加血对象==0 then
		玩家数据[id].角色.气血=玩家数据[id].角色.气血+加血数值
		if 伤势数值 ~= nil then
			玩家数据[id].角色.气血上限=玩家数据[id].角色.气血上限+伤势数值
			if 玩家数据[id].角色.气血上限>玩家数据[id].角色.最大气血 then
				玩家数据[id].角色.气血上限=玩家数据[id].角色.最大气血
			end
		end
		if 玩家数据[id].角色.气血>玩家数据[id].角色.气血上限 then
			玩家数据[id].角色.气血=玩家数据[id].角色.气血上限
		end
		发送数据(连接id,36,{动画=动画})
		发送数据(连接id,47,{玩家数据[id].角色:取气血数据()})
		地图处理类:加入动画(id,玩家数据[id].角色.地图数据.编号,玩家数据[id].角色.地图数据.x,玩家数据[id].角色.地图数据.y,动画)
	else
		玩家数据[id].召唤兽:加血处理(加血对象,加血数值,连接id,id)
	end
end

function 道具处理类:加魔处理(连接id,id,加血数值,加血对象)
	if 加血对象==0 then
		玩家数据[id].角色.魔法=玩家数据[id].角色.魔法+加血数值
		if 玩家数据[id].角色.魔法>玩家数据[id].角色.最大魔法 then
			玩家数据[id].角色.魔法=玩家数据[id].角色.最大魔法
		end
		发送数据(连接id,36,{动画="加蓝"})
		发送数据(连接id,47,{玩家数据[id].角色:取气血数据()})
		地图处理类:加入动画(id,玩家数据[id].角色.地图数据.编号,玩家数据[id].角色.地图数据.x,玩家数据[id].角色.地图数据.y,"加蓝")
	else
		玩家数据[id].召唤兽:加蓝处理(加血对象,加血数值,连接id,id)
	end
end

function 道具处理类:取飞行限制(id)
	if 玩家数据[id].队伍~=0 and 玩家数据[id].队长==false then
		常规提示(id,"只有队长才可以使用飞行道具")
		return true
	elseif self:取禁止飞行(id) then
		常规提示(id,"#Y/您当前无法使用飞行道具")
		return true
	elseif 玩家数据[id].角色.等级<10 then
		常规提示(id,"#Y/您当前等级太低了无法使用飞行道具")
		return true
	elseif 玩家数据[id].队伍~=0 and 玩家数据[id].队长 then
		local 队伍id=玩家数据[id].队伍
		for n=1,#队伍数据[队伍id].成员数据 do
			if self:取禁止飞行(队伍数据[队伍id].成员数据[n]) then
				常规提示(id,format("#G/%s当前不能使用飞行道具",玩家数据[队伍数据[队伍id].成员数据[n]].角色.名称))
				return true
			end
		end
	end
	return false
end

function 道具处理类:取禁止飞行(id)
	if 玩家数据[id].摊位数据~=nil then return true end
	local 任务id=玩家数据[id].角色:取任务(110)
	if 任务id~=0 and 任务数据[任务id].分类==2 then return true  end
	if 玩家数据[id].角色:取任务(208)~=0 or 玩家数据[id].角色:取任务(300)~=0 or 玩家数据[id].勾魂索中 or 玩家数据[id].坐牢中 or 玩家数据[id].烤火 then return true end
	if 玩家数据[id].角色.剧情.附加.禁止飞行 then return true end
	if feixingdaoju[玩家数据[id].角色.地图数据.编号] then
		return true
	end
	return false
end

function 道具处理类:神兽兑换(id,事件,名称)
	if 玩家数据[id].道具:判定背包道具(id,"神兜兜",99) and 玩家数据[id].道具:判定背包道具(id,"灵兜兜",1) then
		玩家数据[id].道具:消耗背包道具(玩家数据[id].连接id,id,"神兜兜",99)
		玩家数据[id].道具:消耗背包道具(玩家数据[id].连接id,id,"灵兜兜",1)
		local 链接 = {提示=format("#R%s#W成功集齐了99个神兜兜和1个灵兜兜在#R%s#W处换取了一只",玩家数据[id].角色.名称,名称),频道="xt",结尾="#117"}
		玩家数据[id].召唤兽:添加神兽(名称,事件,nil,链接)
	else
		常规提示(id,"#Y/大侠还没有集齐“神兜兜”或是“灵兜兜”，无法兑换神兽")
	end
end

function 道具处理类:给予随机法宝(id)
	local 参数=取随机数()
	local 名称=""
	local 等级=0
	if 参数<=30 then
	 名称={"碧玉葫芦","五色旗盒","飞剑","拭剑石","金甲仙衣","惊魂铃","嗜血幡","风袋","清心咒","九黎战鼓","盘龙壁","神行飞剑","汇灵盏","天师符","织女扇"}
	 等级=1
	elseif 参数<=65 then
	 名称={"发瘟匣","断线木偶","五彩娃娃","七杀","金刚杵","兽王令","摄魂"}
	 等级=2
	else
	 名称={"失心钹","五火神焰印","九幽","普渡","鬼泣","月光宝盒","混元伞","无魂傀儡","苍白纸人","聚宝盆","乾坤玄火塔","无尘扇","无字经","干将莫邪","慈悲","救命毫毛","伏魔天书","镇海珠","奇门五行令"}
	 等级=3
	end
	名称=名称[取随机数(1,#名称)]
	self:给予法宝(id,名称)
end

function 道具处理类:给予法宝(id,名称,消费,消费方式,消费内容)
	if 消费方式 ~= nil then
		if 消费方式 == "银子" then
			if not 玩家数据[id].角色:扣除银子(消费,0,0,消费内容,1) then
				常规提示(id,"你没有那么多的银子")
				return false
			end
		elseif 消费方式 == "仙玉" then
			if not 玩家数据[id].角色:扣除仙玉(消费, 消费内容, id) then
				return false
			end
		elseif 消费方式 == "仙玉积分" then
			if not 玩家数据[id].角色:扣除积分(消费, 消费内容, id) then
				return false
			end
		end
	end
	local 识别码=id.."_"..os.time().."_"..取随机数(1000,9999999).."_"..随机序列
	随机序列=随机序列+1
	local 道具格子=玩家数据[id].角色:取法宝格子()
	if 道具格子==0 then
		常规提示(id,"您的法宝栏已经满啦")
		return
	end
	local 道具id=self:取新编号()
	self.数据[道具id]=物品类()
	self.数据[道具id]:置对象(名称)
	玩家数据[id].角色.法宝[道具格子]=道具id
	self.数据[道具id].识别码=识别码
	local 道具 = 取物品数据(名称)
	self.数据[道具id].总类=1000
	self.数据[道具id].分类=道具[3]
	self.数据[道具id].使用 = 道具[5]
	self.数据[道具id].特技 = 道具[6]
	self.数据[道具id].气血 = 0
	self.数据[道具id].魔法 = 取灵气上限(道具[3])
	self.数据[道具id].角色限制 = 道具[7] or 0
	self.数据[道具id].五行 = 取五行()
	self.数据[道具id].伤害 = 道具[8] or 0
	self.数据[道具id].当前经验=0
	self.数据[道具id].升级经验=法宝经验[道具[3]][1]
	玩家数据[id].角色:日志记录(format("获得新法宝：名称%s,识别码%s",名称,识别码))
	常规提示(id,"#Y你获得了新的法宝#R"..名称)
	return true
end

function 道具处理类:给予灵宝(id,名称,消费,消费方式,消费内容)

	if 消费方式 ~= nil then

			if not 玩家数据[id].角色:扣除银子(消费,0,0,消费内容,1) then
				常规提示(id,"你没有那么多的银子")
				return false
			end
	end
	if 名称 == nil then
		名称 = 取随机灵宝()
	end
	local 识别码=id.."_"..os.time().."_"..取随机数(1000,9999999).."_"..随机序列
	随机序列=随机序列+1
	local 道具格子=玩家数据[id].角色:取灵宝格子()
	if 道具格子==0 then
		常规提示(id,"您的灵宝栏已经满啦")
		return
	end
	local 道具id=self:取新编号()
	self.数据[道具id]=物品类()
	self.数据[道具id]:置对象(名称)
	玩家数据[id].角色.灵宝[道具格子]=道具id
	self.数据[道具id].识别码=识别码
	local 道具 = 取物品数据(名称)
	self.数据[道具id].总类=1002
	self.数据[道具id].分类=道具[3]
	self.数据[道具id].使用 = 道具[5]
	self.数据[道具id].特技 = 道具[6]
	self.数据[道具id].气血 = 0
	self.数据[道具id].魔法 = 取灵气上限(道具[3])
	self.数据[道具id].当前经验=0
	self.数据[道具id].升级经验=灵宝经验[self.数据[道具id].分类][1]
	玩家数据[id].角色:日志记录(format("获得新法宝：名称%s,识别码%s",名称,识别码))
	常规提示(id,"#Y你获得了新的灵宝#R"..名称)
	return true
end

function 道具处理类:给予任务道具(id,名称,数量,参数,附加)
	local 识别码=id.."_"..os.time().."_"..取随机数(1000,9999999).."_"..随机序列
	local 道具id
	随机序列=随机序列+1
	local 道具格子=玩家数据[id].角色:取任务格子()
	if 道具格子==0 then
		常规提示(id,"您的任务栏物品已经满啦")
		return false
	else
			local 重置id=0
		for n=1,20 do
			if 重置id==0 and 玩家数据[id].角色.任务包裹[n]~=nil and self.数据[玩家数据[id].角色.任务包裹[n]]~=nil and self.数据[玩家数据[id].角色.任务包裹[n]].名称==名称 and self.数据[玩家数据[id].角色.任务包裹[n]].数量~=nil then
				if 数量 == nil then 数量 =1 end
				if self.数据[玩家数据[id].角色.任务包裹[n]].数量+数量<=99 then
					数量=self.数据[玩家数据[id].角色.任务包裹[n]].数量+数量
					道具id=玩家数据[id].角色.任务包裹[n]
					识别码=self.数据[玩家数据[id].角色.任务包裹[n]].识别码
					重置id=1
				end
			end
		end
		if 重置id==0 then
			道具id=self:取新编号()
			self.数据[道具id]=物品类()
			self.数据[道具id]:置对象(名称)
			玩家数据[id].角色.任务包裹[道具格子]=道具id
		end
		临时道具 = 取物品数据(名称)
		临时道具.总类=临时道具[2]
		临时道具.子类=临时道具[4]
		临时道具.分类=临时道具[3]
		if self.数据[道具id].可叠加 then
			if 数量 == nil then
				self.数据[道具id].数量=1
				常规提示(id,"#Y/你得到了#R1#Y个#R"..self.数据[道具id].名称.."#Y已存入任务栏")
			else
				self.数据[道具id].数量=数量
				常规提示(id,"#Y/你得到了#R"..数量.."#Y个#R"..self.数据[道具id].名称.."#Y已存入任务栏")
			end
		else
			常规提示(id,"#Y/你得到了#R1#Y个#R"..self.数据[道具id].名称.."#Y已存入任务栏")
		end
	end
end

function 道具处理类:临时背包索取()
	local fhz ={道具={}}
	local fhz2 = false
	for k,v in pairs(玩家数据[self.玩家id].角色.临时包裹) do
		if self.数据[玩家数据[self.玩家id].角色.临时包裹[k]]==nil then
			玩家数据[self.玩家id].角色.临时包裹[k]=nil
		else
			fhz.道具[k]=table.copy(self.数据[玩家数据[self.玩家id].角色.临时包裹[k]])
			fhz2 = true
		end
	end
	return {fhz,fhz2}
end

function 道具处理类:临时背包处理(连接id,id,sj)
	if sj.方式  == "获取" then
		local 格子=玩家数据[id].角色:取道具格子()
		if 格子<1 then
			常规提示(id,"#Y/你身上的包裹没有足够的空间")
			return
		end
		if 玩家数据[id].角色.临时包裹[sj.选中] ~= nil and self.数据[玩家数据[id].角色.临时包裹[sj.选中]]  ~= nil then
			self:给予道具(id,nil,nil,nil,nil,nil,table.copy(self.数据[玩家数据[id].角色.临时包裹[sj.选中]]))
		else
			常规提示(id,"#Y/临时背包没有这个道具")
			return
		end
		玩家数据[id].角色.临时包裹[sj.选中] = nil
		local fhz = self:临时背包索取()
		if fhz[2] then
			发送数据(玩家数据[id].连接id,301,{"临时背包",fhz[1]})
		else
			发送数据(玩家数据[id].连接id,302,{"临时背包"})
			发送数据(玩家数据[id].连接id,303,{"底图框","临时背包闪烁",false})
		end
	elseif sj.方式  == "清空" then
		for k,v in pairs(玩家数据[id].角色.临时包裹) do
			self.数据[玩家数据[id].角色.临时包裹[k]] = nil
		end
		玩家数据[id].角色.临时包裹 = {}
		发送数据(玩家数据[id].连接id,302,{"临时背包"})
		发送数据(玩家数据[id].连接id,303,{"底图框","临时背包闪烁",false})
	elseif sj.方式  == "索取" then
		发送数据(玩家数据[id].连接id,300,{"临时背包",self:临时背包索取()[1]})
	end
end

function 道具处理类:卸下锦衣(连接id,id,道具id,道具格子,数据)
	玩家数据[id].角色[数据.类型][道具格子]=玩家数据[id].角色.锦衣[数据.道具]
	玩家数据[id].角色.锦衣[数据.道具]=nil
	self:刷新道具行囊(id,数据.类型)
	发送数据(玩家数据[id].连接id,3703,玩家数据[id].角色:取锦衣数据())
	发送数据(玩家数据[id].连接id,3704)
	地图处理类:更新锦衣(id,nil,数据.道具)
	发送数据(玩家数据[id].连接id,12)
end

function 道具处理类:卸下装备(连接id,id,数据)
	if 数据.类型 == "任务包裹" then return 常规提示(id,"#Y这件物品不能移动到任务栏") end
	local 道具格子=玩家数据[id].角色:取道具格子1(数据.类型)
	if 道具格子==0 then
		常规提示(id,"您的道具栏物品已经满啦")
		return 0
	end
	if 数据.灵饰 then
		self:卸下灵饰(连接id,id,道具id,道具格子,数据)
		return
	end
	if 数据.锦衣 then
		self:卸下锦衣(连接id,id,道具id,道具格子,数据)
		return
	end
	local 道具id=玩家数据[id].角色.装备[数据.道具]
	玩家数据[id].角色:卸下装备(self.数据[道具id],self.数据[道具id].分类)


		local 道具类型
	if self.数据[道具id].分类 == 1 then --头盔
		道具类型="头盔"
	elseif self.数据[道具id].分类 == 2 then --项链
		道具类型="项链"
	elseif self.数据[道具id].分类 == 3 then --武器
		道具类型="武器"
	elseif self.数据[道具id].分类 == 4 then --衣服
		道具类型="衣服"
	elseif self.数据[道具id].分类 == 5 then --腰带
		道具类型="腰带"
	elseif self.数据[道具id].分类 == 6 then --鞋子
		道具类型="鞋子"
	end
	神兵异兽榜:删除处理(id,道具类型)



	玩家数据[id].角色.装备[数据.道具]=nil
	玩家数据[id].角色[数据.类型][道具格子]=道具id
	玩家数据[id].角色:刷新信息()
	self:刷新道具行囊(id,数据.类型)
	发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
	-- if 数据.道具==3 then
	-- 	发送数据(玩家数据[id].连接id,3505)
	-- 	地图处理类:更新武器(id)
	-- end
	-- 发送数据(玩家数据[id].连接id,12)
	if 数据.道具==3 then
		发送数据(玩家数据[id].连接id,3505)
		地图处理类:更新武器(id)
	elseif 数据.道具 == 4 and 玩家数据[id].角色.模型 == "影精灵" and self.数据[道具id].子类 == 911 then
	  发送数据(玩家数据[id].连接id, 3505)
	  if 玩家数据[id].角色.装备[3] ~= nil then
			地图处理类:更新武器(id, self.数据[玩家数据[id].角色.装备[3]])
		else
			地图处理类:更新武器(id)
		end
	end
	return 道具格子
end

function 道具处理类:佩戴灵饰(连接id,id,道具id,数据)
	local 物品=取物品数据(self.数据[道具id].名称)
	local 级别=物品[5]
	if 级别>玩家数据[id].角色.等级 then
		if self.数据[道具id].特效 =="无级别限制" and 级别<=玩家数据[id].角色.等级+180 then
		elseif self.数据[道具id].特效 =="超级简易"   and 级别<=玩家数据[id].角色.等级+25 then
		else
			常规提示(id,"#Y你当前的等级不足以佩戴这样的灵饰")
			return
		end
	end
	if not self.数据[道具id].鉴定 then
		常规提示(id,"#Y没有鉴定的灵饰无法佩戴")
		return
	end
	if self.数据[道具id].专用 and  self.数据[道具id].专用~=id then
		常规提示(id,"#Y这个灵饰id与你不匹配无法穿戴")
		return
	end

	if 玩家数据[id].角色.灵饰[self.数据[道具id].子类]==nil then
		玩家数据[id].角色.灵饰[self.数据[道具id].子类]=道具id
		玩家数据[id].角色:佩戴灵饰(self.数据[道具id])
		玩家数据[id].角色[数据.类型][数据.道具]=nil
------------------------------------------------------------------------
		-- 玩家数据[id].角色:检测钟灵石(id)
			if self.数据[道具id].装备比赛 and self.数据[道具id].装备比赛.开启 then
			self.数据[道具id].装备比赛.开启= false
			end
      神兵异兽榜:灵饰穿戴处理(id,self.数据[道具id].部位类型,道具id)
------------------------------------------------------------------------

	else
		local 道具id1=玩家数据[id].角色.灵饰[self.数据[道具id].子类]
		玩家数据[id].角色:卸下灵饰(self.数据[道具id1])
		玩家数据[id].角色.灵饰[self.数据[道具id].子类]=道具id
		玩家数据[id].角色:佩戴灵饰(self.数据[道具id])
		玩家数据[id].角色[数据.类型][数据.道具]=道具id1
------------------------------------------------------------------------
		-- 玩家数据[id].角色:检测钟灵石(id)
			if self.数据[道具id].装备比赛 and self.数据[道具id].装备比赛.开启 then
			self.数据[道具id].装备比赛.开启= false
			end
		神兵异兽榜:删除处理(id,self.数据[道具id].部位类型)
    神兵异兽榜:灵饰穿戴处理(id,self.数据[道具id].部位类型,道具id)
------------------------------------------------------------------------
	end
	self:刷新道具行囊(id,数据.类型)
	发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
	发送数据(玩家数据[id].连接id,3506,玩家数据[id].角色:取灵饰数据())
	发送数据(连接id,47,{玩家数据[id].角色:取气血数据()})
	发送数据(玩家数据[id].连接id,12)
end

function 道具处理类:卸下灵饰(连接id,id,道具id,道具格子,数据)
	玩家数据[id].角色:卸下灵饰(self.数据[玩家数据[id].角色.灵饰[数据.道具]])
	神兵异兽榜:删除处理(id,玩家数据[id].道具.数据[玩家数据[id].角色.灵饰[数据.道具]].部位类型)---------
	玩家数据[id].角色[数据.类型][道具格子]=玩家数据[id].角色.灵饰[数据.道具]
	玩家数据[id].角色.灵饰[数据.道具]=nil
	self:刷新道具行囊(id,数据.类型)
	发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
	发送数据(玩家数据[id].连接id,3506,玩家数据[id].角色:取灵饰数据())
	发送数据(连接id,47,{玩家数据[id].角色:取气血数据()})
	发送数据(玩家数据[id].连接id,12)
end

function 道具处理类:佩戴锦衣(连接id,id,道具id,数据)
	 local 物品=取物品数据(self.数据[道具id].名称)

	if self.数据[道具id].角色限制~=nil then
	if 玩家数据[id].角色.造型 ~= self.数据[道具id].角色限制 then
		常规提示(id,"#Y你无法穿戴这个造型的锦衣套装")
		return
	end
	end

	if 玩家数据[id].角色.锦衣[self.数据[道具id].子类]==nil then
		玩家数据[id].角色.锦衣[self.数据[道具id].子类]=道具id
		玩家数据[id].角色[数据.类型][数据.道具]=nil
	else
		local 道具id1=玩家数据[id].角色.锦衣[self.数据[道具id].子类]
		玩家数据[id].角色.锦衣[self.数据[道具id].子类]=道具id
		玩家数据[id].角色[数据.类型][数据.道具]=道具id1
	end
	self:刷新道具行囊(id,数据.类型)
	发送数据(玩家数据[id].连接id,3703,玩家数据[id].角色:取锦衣数据())
	发送数据(玩家数据[id].连接id,3704)
	地图处理类:更新锦衣(id,玩家数据[id].道具.数据[玩家数据[id].角色.锦衣[self.数据[道具id].子类 ]].名称,self.数据[道具id].子类 )
	发送数据(玩家数据[id].连接id,12)
end

function 道具处理类:佩戴装备(连接id,id,数据)
	local 道具id=玩家数据[id].角色[数据.类型][数据.道具]
	if self.数据[道具id] == nil then
		return
	end
	if self.数据[道具id].总类 == 2 and self.数据[道具id].灵饰~=nil then
		self:佩戴灵饰(连接id,id,道具id,数据)
		return
	end
	if self.数据[道具id].总类 == 2 and self.数据[道具id].分类 >=14 and self.数据[道具id].分类 <=21 then
		self:佩戴锦衣(连接id,id,道具id,数据)
		return
	end
	local 装备条件=self:可装备(self.数据[道具id],self.数据[道具id].分类,数据.角色,id)
	if 装备条件~=true then
		发送数据(连接id,7,装备条件)
		return 0
	else
		if 玩家数据[id].角色.装备[self.数据[道具id].分类]~=nil then --检查是否有装备已经佩戴
			local 道具id1=玩家数据[id].角色.装备[self.数据[道具id].分类]
			玩家数据[id].角色:卸下装备(self.数据[道具id1],self.数据[道具id1].分类)
			玩家数据[id].角色.装备[self.数据[道具id].分类]= 道具id
			玩家数据[id].角色:穿戴装备(self.数据[道具id],self.数据[道具id].分类)
--------------------------------------------------------------------
			local 道具类型
			if self.数据[道具id].分类 == 1 then --头盔
				道具类型="头盔"
			elseif self.数据[道具id].分类 == 2 then --项链
				道具类型="项链"
			elseif self.数据[道具id].分类 == 3 then --武器
				道具类型="武器"
			elseif self.数据[道具id].分类 == 4 then --衣服
				道具类型="衣服"
			elseif self.数据[道具id].分类 == 5 then --腰带
				道具类型="腰带"
			elseif self.数据[道具id].分类 == 6 then --鞋子
				道具类型="鞋子"
			end
			神兵异兽榜:删除处理(id,道具类型)
			神兵异兽榜:装备穿戴处理(id,道具类型,道具id)
-----------------------------------------------------------
			玩家数据[id].角色[数据.类型][数据.道具]=道具id1 ----------原带
----------------------------------------------------------------------------
			if self.数据[道具id].装备比赛 and self.数据[道具id].装备比赛.开启 then
			self.数据[道具id].装备比赛.开启= false
			end
------------------------------------------------------
		else
			玩家数据[id].角色.装备[self.数据[道具id].分类]= 道具id
			玩家数据[id].角色:穿戴装备(self.数据[道具id],self.数据[道具id].分类)

			local 道具类型------------------------------------------------
			if self.数据[道具id].分类 == 1 then --头盔
				道具类型="头盔"
			elseif self.数据[道具id].分类 == 2 then --项链
				道具类型="项链"
			elseif self.数据[道具id].分类 == 3 then --武器
				道具类型="武器"
			elseif self.数据[道具id].分类 == 4 then --衣服
				道具类型="衣服"
			elseif self.数据[道具id].分类 == 5 then --腰带
				道具类型="腰带"
			elseif self.数据[道具id].分类 == 6 then --鞋子
				道具类型="鞋子"
			end
			神兵异兽榜:装备穿戴处理(id,道具类型,道具id)---------------------


			玩家数据[id].角色[数据.类型][数据.道具]=nil---原带

			if self.数据[道具id].装备比赛 and self.数据[道具id].装备比赛.开启 then-------------------------------
			self.数据[道具id].装备比赛.开启= false
			end----------------------------------------
		end
		玩家数据[id].角色:检查临时属性()
	end
	self:刷新道具行囊(id,数据.类型)
	发送数据(玩家数据[id].连接id,3503,玩家数据[id].角色:取装备数据())
	-- if self.数据[道具id].分类==3 then
	-- 	发送数据(玩家数据[id].连接id,3504)
	-- 	地图处理类:更新武器(id,self.数据[玩家数据[id].角色.装备[3]])
	-- end
	if self.数据[道具id].分类==3 then
		发送数据(玩家数据[id].连接id,3504)
		地图处理类:更新武器(id,self.数据[玩家数据[id].角色.装备[3]])
	elseif self.数据[道具id].分类 == 4 and 玩家数据[id].角色.装备[4] ~= nil and self.数据[道具id].子类 == 911 and 玩家数据[id].角色.模型 == "影精灵" then
		发送数据(玩家数据[id].连接id, 3504)
		地图处理类:更新武器(id, self.数据[玩家数据[id].角色.装备[3]])
	end
	发送数据(玩家数据[id].连接id,12	)
end

function 道具处理类:坐骑装饰佩戴(id,加血对象,道具格子,包裹类型)
	local 道具id=玩家数据[id].角色[包裹类型][道具格子]
if getMountDecorationMatch(玩家数据[id].角色.坐骑列表[加血对象].模型,self.数据[道具id].名称)==false then
   return 常规提示(id,"#Y这个坐骑无法装备这个装饰")
end
	if 玩家数据[id].角色.坐骑列表[加血对象].饰品 == nil then
		玩家数据[id].角色.坐骑列表[加血对象].饰品 = self.数据[道具id]
		self.数据[道具id] = nil
	else
		local 临时道具 = 玩家数据[id].角色.坐骑列表[加血对象].饰品
		玩家数据[id].角色.坐骑列表[加血对象].饰品 = self.数据[道具id]
		self.数据[道具id] = 临时道具
	end
	发送数据(玩家数据[id].连接id,62,{编号=加血对象,坐骑数据=玩家数据[id].角色.坐骑列表[加血对象]})
	self:刷新道具行囊(id,包裹类型)
	发送数据(玩家数据[id].连接id,28)
	玩家数据[id].角色.坐骑=table.loadstring(table.tostring(玩家数据[id].角色.坐骑列表[加血对象]))
	发送数据(玩家数据[id].连接id,60,玩家数据[id].角色.坐骑)
	地图处理类:更新坐骑(id,玩家数据[id].角色.坐骑)
end

function 道具处理类:坐骑装饰卸下(连接id,id,数据)
	local 角色=数据.角色
	local 类型=数据.类型
	local 道具=数据.道具
	local bb=数据.编号
	local 道具格子=玩家数据[id].角色:取道具格子()
	if 道具格子==0 then
		常规提示(id,"您的道具栏物品已经满啦")
		return
	else
		local 临时id=self:取新编号()
		self.数据[临时id]=玩家数据[id].角色.坐骑列表[bb].饰品
		玩家数据[id].角色.道具[道具格子]=临时id
		玩家数据[id].角色.坐骑列表[bb].饰品 = nil
		发送数据(玩家数据[id].连接id,62,{编号=bb,坐骑数据=玩家数据[id].角色.坐骑列表[bb]})
		self:刷新道具行囊(id,数据.类型)
		发送数据(连接id,28)
		玩家数据[id].角色.坐骑=table.loadstring(table.tostring(玩家数据[id].角色.坐骑列表[bb]))
		发送数据(玩家数据[id].连接id,60,玩家数据[id].角色.坐骑)
		地图处理类:更新坐骑(id,玩家数据[id].角色.坐骑)
	end
end

function 道具处理类:可装备(i1,i2,类型,id)
	if i2 > 6 and 类型 == "主角" then
		return "#Y/该装备与你的种族不符"
	elseif i2 < 6 and 类型 == "召唤兽" then
		return "#Y/召唤兽不能穿戴该装备"
	end
	if i1.总类 ~= 2 then
		return "#Y/这个物品不可以装备"
	end
	if not i1.鉴定 then
		return "#Y/该装备未鉴定，无法佩戴"
	end
	if i1.专用~=nil and i1.专用~=id then
		return "#Y/你无法佩戴他人的专用装备"
	end

	if type( i1.级别限制) ~=  "number"  then
		return "#Y/该装备的等级数据错误请联系管理员"
	end
	if i1.耐久~=nil and i1.耐久<=0  then
		return "#Y/该装备耐久不足，无法穿戴"
	end
	if i1.修理失败~=nil and i1.修理失败==3 and i1.耐久<=0 then
		return "#Y/该装备因修理失败过度，而无法使用！"--常规提示(id,"#Y/该装备因修理失败过度，而无法使用！")
	end
	if i1 ~= nil and i1.分类 == i2 then
		if i2 == 1 or i2 == 4 then --头盔 衣服
			if i2 == 4 then
				if i1.子类 == 911 then
				  if 玩家数据[id].角色.门派 == "九黎城" then
				  	if 玩家数据[id].角色.装备[3] ~= nil and 玩家数据[id].道具.数据[玩家数据[id].角色.装备[3]].子类 ~= 910 then
						  return "#Y/该武器无法与当前携带的主武器共同装备。"
						end
				    return true
				  else
				  	return "#Y/九黎城专属装备,其他门派不可使用。"
				  end
				else
					if 玩家数据[id].角色.装备[3] ~= nil and 玩家数据[id].道具.数据[玩家数据[id].角色.装备[3]].子类 == 910 then
					  return "#Y/当前装备与当前武器冲突,请装备副武器。"
					end
				end
			end
			if i1.性别限制 ~= 0 and i1.性别限制 == 玩家数据[id].角色.性别 then
				if i1.级别限制 == 0 or 玩家数据[id].角色.等级 >= i1.级别限制 then
					return true
				end
				if i1.特效 then
					for i=1,#i1.特效 do
						if i1.特效[i]=="无级别限制" then
							return true
						elseif i1.特效[i] == "简易" and 玩家数据[id].角色.等级+5 >= i1.级别限制 then
							return true
						end
					end
				end
				return "#Y/你的等级不够呀"
			else
				return "#Y/该装备您无法使用呀"
         end
		elseif i2 == 2 or i2 == 5 or i2 == 6 then --项链，腰带，鞋子
			if i1.级别限制 == 0 or 玩家数据[id].角色.等级 >= i1.级别限制 then
				return true
			end
			if i1.特效 then
				for i=1,#i1.特效 do
					if i1.特效[i]=="无级别限制" then
						return true
					elseif i1.特效[i] == "简易" and 玩家数据[id].角色.等级+5 >= i1.级别限制 then
						return true
					end
				end
			end
			return "#Y/你的等级不够呀"
		elseif i2 == 3 then --武器
			-- if i1.角色限制 ~= 0 and (i1.角色限制[1] == 玩家数据[id].角色.模型 or i1.角色限制[2] == 玩家数据[id].角色.模型 or i1.角色限制[3] == 玩家数据[id].角色.模型) then
			-- 	if i1.级别限制 == 0 or 玩家数据[id].角色.等级 >= i1.级别限制 then
			-- 		return true
			-- 	end
			-- 	if i1.特效 then
			-- 		for i=1,#i1.特效 do
			-- 			if i1.特效[i]=="无级别限制" then
			-- 				return true
			-- 			elseif i1.特效[i] == "简易" and 玩家数据[id].角色.等级+5 >= i1.级别限制 then
			-- 				return true
			-- 			end
			-- 		end
			-- 	end
			-- 	return "#Y/你的等级不够呀"
			-- else
			-- 	return "#Y/该装备您无法使用呀"
			if i1.子类 == 910 then
			  if 玩家数据[id].角色.门派 == "九黎城" then
			  	if 玩家数据[id].角色.装备[4] ~= nil and 玩家数据[id].道具.数据[玩家数据[id].角色.装备[4]].子类 ~= 911 then
			  	  return "#Y/请先脱下当前穿戴防具。"
			  	end
			    return true
			  else
			  	return "#Y/九黎城专属装备,其他门派不可使用。"
			  end
			end
			if i1.子类 ~= 910 then
			  if 玩家数据[id].角色.装备[4] ~= nil and 玩家数据[id].道具.数据[玩家数据[id].角色.装备[4]].子类 == 911 then
			    return "#Y/该武器无法与当前携带的主武器共同装备。"
			  end
			end
			if i1.角色限制 ~= 0 and (i1.角色限制[1] == 玩家数据[id].角色.模型 or i1.角色限制[2] == 玩家数据[id].角色.模型 or i1.角色限制[3] == 玩家数据[id].角色.模型) then
				if i1.级别限制 == 0 or 玩家数据[id].角色.等级 >= i1.级别限制 then
					return true
				end
				if i1.特效 then
					for i=1,#i1.特效 do
						if i1.特效[i]=="无级别限制" then
							return true
						elseif i1.特效[i] == "简易" and 玩家数据[id].角色.等级+5 >= i1.级别限制 then
							return true
						end
					end
				end
				return "#Y/你的等级不够呀"
			else
				return "#Y/该装备您无法使用呀"
			end
		end
	end
	return false
end

function 道具处理类:取可叠加道具(mc,sl)
	for n, v in pairs(self.数据) do

		if self.数据[n].名称==mc and self.数据[n].可叠加 and self.数据[n].数量 + tonumber(sl) <= 99 then
			return n
		end
	end
	return 0
end

function 道具处理类:判定装备条件()
	for n, v in pairs(玩家数据[self.玩家id].角色.装备) do
		local 格子 = 玩家数据[self.玩家id].角色.装备[n]
		if self.数据[格子] ~= nil then
			local 装备条件=self:可装备(self.数据[格子],self.数据[格子].分类,"主角",self.玩家id)
			if 装备条件 ~= true then
				常规提示(self.玩家id,"#Y你的等级不够，不能装备"..self.数据[格子].名称)

			end
		end
	end
end

function 道具处理类:更新()
	local 更新属性 = false
	for n, v in pairs(玩家数据[self.玩家id].角色.装备) do --这个是穿戴的装备
		local 格子 = 玩家数据[self.玩家id].角色.装备[n]
		if self.数据 and self.数据[格子] ~= nil then
			if self.数据[格子].临时附魔 ~= nil  then

				for k,v in pairs(self.数据[格子].临时附魔) do
					if v.数值 and v.时间 < os.time() then
						玩家数据[self.玩家id].角色:清除装备附魔属性(self.数据[格子],self.数据[格子].分类,k,v.数值)
						self.数据[格子].临时附魔[k] = nil
						常规提示(self.玩家id,"#Y你装备上的附魔特效消失了！")
					end
				end
			end
		end
	end

	if 更新属性 then
		发送数据(玩家数据[self.玩家id].连接id,3503,玩家数据[self.玩家id].角色:取装备数据())
		发送数据(玩家数据[self.玩家id].连接id,31,玩家数据[self.玩家id].角色:取总数据1())
	end
end



function 道具处理类:丢弃道具(连接id,id,数据)
	local 类型=数据.类型
	local wpid=数据.物品
	if not 类型 or not wpid then
	    return
	end

	if self.数据[玩家数据[id].角色[类型][wpid]]==nil then--------为了CTRL快速删除道具服务端不报错加的无意义代码
		return
	end

	local 名称 = self.数据[玩家数据[id].角色[类型][wpid]].名称
	if not 玩家数据[id].角色[类型][wpid] or 名称==nil then
		玩家数据[id].角色[类型][wpid]=nil
		return
	end

	玩家数据[id].角色:日志记录("丢弃道具["..self.数据[玩家数据[id].角色[类型][wpid]].名称.."],道具识别码为"..(self.数据[玩家数据[id].角色[类型][wpid]].识别码 or id))
	self.数据[玩家数据[id].角色[类型][wpid]]=nil
	玩家数据[id].角色[数据.类型][wpid]=nil

	self:刷新道具行囊(id,类型)
end
function 道具处理类:丢弃灵宝(连接id,id,数据)
	local 类型="灵宝"
	local wpid=数据.物品
	if not 类型 or not wpid then
	    return
	end
	local 名称 = self.数据[玩家数据[id].角色[类型][wpid]].名称
	if not 玩家数据[id].角色[类型][wpid] or 名称==nil then
		玩家数据[id].角色[类型][wpid]=nil
		return
	end

	玩家数据[id].角色:日志记录("丢弃道具["..self.数据[玩家数据[id].角色[类型][wpid]].名称.."],道具识别码为"..(self.数据[玩家数据[id].角色[类型][wpid]].识别码 or id))
	self.数据[玩家数据[id].角色[类型][wpid]]=nil
	玩家数据[id].角色[数据.类型][wpid]=nil

	self:刷新道具行囊(id,类型)
end
function 道具处理类:道具转移(连接id,id,数据)

	local 临时格子= 0
	local 允许放置=true
	if not self.数据[玩家数据[id].角色[数据.抓取类型][数据.序列]] then
		错误日志[#错误日志+1]={记录="玩家id"..id.."。错误方式：道具转移。错误数据："..table.tostring(数据),时间=os.time()}
		return
	end
	if 数据.放置类型 == "道具" then
		临时格子=玩家数据[id].角色:取道具格子()
		if 临时格子 == 0 then  常规提示(id,"#Y道具背包已满") end
	elseif 数据.放置类型 == "法宝" then
		临时格子=玩家数据[id].角色:取法宝格子()
		if 临时格子 == 0 then  常规提示(id,"#Y法宝背包已满") end

	elseif 数据.放置类型 == "行囊" then
		临时格子=玩家数据[id].角色:取行囊格子()
		if 临时格子 == 0 then  常规提示(id,"#Y行囊背包已满") end
		if  self.数据[玩家数据[id].角色[数据.抓取类型][数据.序列]].总类 == 150 then
			允许放置 = false
			常规提示(id,"#Y任务物品不能移动到这里")
		end
	elseif 数据.放置类型 == "任务包裹" then
		临时格子=玩家数据[id].角色:取任务格子()
		if 临时格子 == 0 then  常规提示(id,"#Y任务背包已满") end
		if  self.数据[玩家数据[id].角色[数据.抓取类型][数据.序列]].总类 ~= 150 then
			允许放置 = false
			常规提示(id,"#Y这件物品不能移动到任务栏")
		end
	end
	if 临时格子 ~= 0 and 允许放置 then
		玩家数据[id].角色[数据.放置类型][临时格子] = 玩家数据[id].角色[数据.抓取类型][数据.序列]
		玩家数据[id].角色[数据.抓取类型][数据.序列]=nil
	end
	发送数据(连接id,3699)
end

function 道具处理类:道具格子互换(连接id,id,数据)
	if 数据.放置类型==数据.抓取类型 and 数据.放置id==数据.抓取id then
		发送数据(连接id,3699)
		return
	end
	if 数据.放置类型~=数据.抓取类型 and self.数据[玩家数据[id].角色[数据.抓取类型][数据.抓取id]].总类==1000 then
		if self.数据[玩家数据[id].角色[数据.抓取类型][数据.抓取id]].分类~=1 then
			常规提示(id,"#Y只有一级法宝才可以移动")
			return
		end
	end
	if 数据.放置类型=="法宝" and self.数据[玩家数据[id].角色[数据.抓取类型][数据.抓取id]].总类~=1000 then
		常规提示(id,"#Y法宝栏只可以放入法宝哟")
		return
	end
	if 玩家数据[id].角色[数据.放置类型][数据.放置id]==nil then --没有道具
		玩家数据[id].角色[数据.放置类型][数据.放置id]=玩家数据[id].角色[数据.抓取类型][数据.抓取id]
		玩家数据[id].角色[数据.抓取类型][数据.抓取id]=nil
	else
		local 放置id=玩家数据[id].角色[数据.放置类型][数据.放置id]
		self.允许互换=true
		local 放置id=玩家数据[id].角色[数据.放置类型][数据.放置id]
		local 抓取id=玩家数据[id].角色[数据.抓取类型][数据.抓取id]
		if self.数据[放置id].名称==self.数据[抓取id].名称 and self.数据[抓取id].数量~=nil and self.数据[放置id].数量~=nil then
			if self.数据[抓取id].数量<99 and self.数据[放置id].数量<99 then
				if self.数据[抓取id].阶品~= nil and self.数据[放置id].阶品~=nil and self.数据[抓取id].阶品~=self.数据[放置id].阶品 then
					常规提示(id,"#Y不同阶品的物品，无法叠加")
					发送数据(连接id,3699)
					道具刷新(id)
					return
				elseif self.数据[抓取id].灵气~= nil and self.数据[放置id].灵气~=nil and self.数据[抓取id].灵气~=self.数据[放置id].灵气 then --如意丹等
					常规提示(id,"#Y不同灵气的物品，无法叠加")
					发送数据(连接id,3699)
					道具刷新(id)
					return
				elseif self.数据[抓取id].级别限制~= nil and self.数据[放置id].级别限制~=nil and self.数据[抓取id].级别限制~=self.数据[放置id].级别限制 and self.数据[抓取id].名称=="钨金" and self.数据[放置id].名称=="钨金" then
					常规提示(id,"#Y不同等级的物品，无法叠加")
					发送数据(连接id,3699)
					道具刷新(id)
					return
				elseif self.数据[抓取id].附带技能~= nil and self.数据[放置id].附带技能~=nil and self.数据[抓取id].附带技能~=self.数据[放置id].附带技能 then
					玩家数据[id].角色[数据.放置类型][数据.放置id]=玩家数据[id].角色[数据.抓取类型][数据.抓取id]
					玩家数据[id].角色[数据.抓取类型][数据.抓取id]=放置id
					发送数据(连接id,3699)
					道具刷新(id)
					return

				end
				if self.数据[抓取id].数量+self.数据[放置id].数量<=99 then
					self.数据[放置id].数量=self.数据[放置id].数量+self.数据[抓取id].数量
					self.数据[抓取id]=nil
					玩家数据[id].角色[数据.抓取类型][数据.抓取id]=nil
					self.允许互换=false
				else
					local 临时数量=self.数据[抓取id].数量+self.数据[放置id].数量
					local 临时数量1=临时数量-99
					self.数据[放置id].数量=99
					self.数据[抓取id].数量=临时数量1
					self.允许互换=false
				end
			end
		end
		if self.允许互换 then
			玩家数据[id].角色[数据.放置类型][数据.放置id]=玩家数据[id].角色[数据.抓取类型][数据.抓取id]
			玩家数据[id].角色[数据.抓取类型][数据.抓取id]=放置id
		end
	end

	self:刷新道具行囊(id,数据.放置类型)
end

function 道具处理类:刷新道具行囊(id,类型)
	if 类型=="道具" then
		self:索要道具(玩家数据[id].连接id,id)
	elseif 类型=="法宝" then
		self:索要法宝(玩家数据[id].连接id,id)
	elseif 类型=="任务包裹" then
		self:索要任务(玩家数据[id].连接id,id)
	else
		self:索要行囊(玩家数据[id].连接id,id)
	end
end

function 道具处理类:索要灵犀玉(id)
	self.发送数据={道具={}}
	for n=1,20 do
		if 玩家数据[id].角色.道具[n]~=nil then
			if self.数据[玩家数据[id].角色.道具[n]]~=nil and self.数据[玩家数据[id].角色.道具[n]].名称=="灵犀玉" then
				self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.道具[n]]))
			end
		end
	end
	return self.发送数据
end

function 道具处理类:索要法宝(连接id,id)
	self.发送数据={法宝={},佩戴={},灵宝={},灵宝佩戴={},神器={}}
	for n=1,180 do
		if 玩家数据[id].角色.法宝[n]~=nil then
			if self.数据[玩家数据[id].角色.法宝[n]]==nil then
				玩家数据[id].角色.法宝[n]=nil
			else
				self.发送数据.法宝[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.法宝[n]]))
			end
		end
	end
	for n=1,4 do
		if 玩家数据[id].角色.法宝佩戴[n]~=nil then
			self.发送数据.佩戴[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.法宝佩戴[n]]))
		end
	end
	for n=1,20 do
		if 玩家数据[id].角色.灵宝[n]~=nil then
			if self.数据[玩家数据[id].角色.灵宝[n]]==nil then
				玩家数据[id].角色.灵宝[n]=nil
			else
				self.发送数据.灵宝[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.灵宝[n]]))
			end
		end
	end
	for n=1,2 do
		if 玩家数据[id].角色.灵宝佩戴[n]~=nil then
			self.发送数据.灵宝佩戴[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.灵宝佩戴[n]]))
		end
	end
	if 玩家数据[id].神器.数据.是否有 and 玩家数据[id].角色.门派~="无门派" then--and not 判断是否为空表(玩家数据[id].神器.数据) then
		self.发送数据.是否有神器=true
		self.发送数据.是否佩戴神器=玩家数据[id].神器.数据.是否佩戴神器
		self.发送数据.神器格子=玩家数据[id].神器.数据.格子
	end
	发送数据(连接id,3527,self.发送数据)
end

function 道具处理类:索要灵宝佩戴(id)
	self.发送数据={}
	for n=1,2 do
		if 玩家数据[id].角色.灵宝佩戴[n]~=nil then
			self.发送数据[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.灵宝佩戴[n]]))
		end
	end
	return self.发送数据
end

function 道具处理类:索要任务(连接id,id)
	self.发送数据={道具={}}
	for n=1,20 do
		if 玩家数据[id].角色.任务包裹[n]~=nil then
			if self.数据[玩家数据[id].角色.任务包裹[n]]==nil then
				玩家数据[id].角色.任务包裹[n]=nil
			else
				self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.任务包裹[n]]))
			end
		end
	end
	发送数据(连接id,3531,self.发送数据)
end

function 道具处理类:索要道具(连接id,id)
	self.发送数据={道具={}}
	    if 采矿活动[id]==nil then
         采矿活动[id]={总计=0}
         end
     if  玩家数据[id].角色.采矿数据 == nil then
         玩家数据[id].角色.采矿数据= {熟练度=0,矿业声望=0}
         end
	for n=1,80 do
		if 玩家数据[id].角色.道具[n]~=nil then
			if self.数据[玩家数据[id].角色.道具[n]]==nil then
				玩家数据[id].角色.道具[n]=nil
			else
				self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.道具[n]]))
			end
		end
	end
	self.发送数据.银子=玩家数据[id].角色.银子
	self.发送数据.储备=玩家数据[id].角色.储备
	self.发送数据.存银=玩家数据[id].角色.存银
	self.发送数据.装备 = 玩家数据[id].角色:取装备数据()
	self.发送数据.灵饰 = 玩家数据[id].角色:取灵饰数据()
	self.发送数据.熟练度1=玩家数据[id].角色.采矿数据.熟练度
   self.发送数据.矿业声望=玩家数据[id].角色.采矿数据.矿业声望
   self.发送数据.次数1=采矿活动[id].总计
  self.发送数据.套装激活=玩家数据[id].角色.套装激活
   self.发送数据.套装名称=玩家数据[id].角色.套装名称
	发送数据(连接id,3501,self.发送数据)
end

function 道具处理类:索要道具1(id)
	self.发送数据={道具={}}
	for n=1,80 do
		if 玩家数据[id].角色.道具[n]~=nil then
			if self.数据[玩家数据[id].角色.道具[n]]==nil then
				玩家数据[id].角色.道具[n]=nil
			else
				self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.道具[n]]))
			end
		end
	end
	self.发送数据.银子=玩家数据[id].角色.银子
	self.发送数据.储备=玩家数据[id].角色.储备
	self.发送数据.存银=玩家数据[id].角色.存银
	return self.发送数据
end

function 道具处理类:索要道具2(id)
	self.发送数据={道具={}}
	for n=1,80  do
		if 玩家数据[id].角色.道具[n]~=nil then
			if self.数据[玩家数据[id].角色.道具[n]]==nil then
				玩家数据[id].角色.道具[n]=nil
			else
				self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.道具[n]]))
			end
		end
	end
	return self.发送数据
end

function 道具处理类:索要行囊2(id)
	self.发送数据={道具={}}
	for n=1,20 do
		if 玩家数据[id].角色.行囊[n]~=nil then
			if self.数据[玩家数据[id].角色.行囊[n]]==nil then
				玩家数据[id].角色.行囊[n]=nil
			else
				self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.行囊[n]]))
			end
		end
	end
	return self.发送数据
end

function 道具处理类:索要道具3(连接id,id)
	self.发送数据={道具={}}
	for n=1,80 do
		if 玩家数据[id].角色.道具[n]~=nil then
			if self.数据[玩家数据[id].角色.道具[n]]==nil then
				玩家数据[id].角色.道具[n]=nil
			else
				self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.道具[n]]))
			end
		end
	end
	self.发送数据.银子=玩家数据[id].角色.银子
	self.发送数据.储备=玩家数据[id].角色.储备
	self.发送数据.存银=玩家数据[id].角色.存银
	发送数据(连接id,200,self.发送数据)
end

function 道具处理类:索要道具更新(id,类型)
	self.发送数据={道具={},类型=类型}
	for n=1,80 do
		if 玩家数据[id].角色[类型][n]~=nil then
			if self.数据[玩家数据[id].角色[类型][n]]==nil then
				玩家数据[id].角色[类型][n]=nil
			else
				self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色[类型][n]]))
			end
		end
	end
	self.发送数据.银子=玩家数据[id].角色.银子
	self.发送数据.储备=玩家数据[id].角色.储备
	self.发送数据.存银=玩家数据[id].角色.存银
	发送数据(玩家数据[id].连接id,3532,self.发送数据)
end

function 道具处理类:重置法宝回合(id)
	for n=1,20 do
		if 玩家数据[id].角色.法宝[n]~=nil then
			if self.数据[玩家数据[id].角色.法宝[n]]==nil then
				玩家数据[id].角色.法宝[n]=nil
			else
				self.数据[玩家数据[id].角色.法宝[n]].回合=nil
			end
		end
	end
end

function 道具处理类:索要法宝2(id,回合)
	self.发送数据={道具={}}
	for n=1,20 do
		if 玩家数据[id].角色.法宝[n]~=nil then
			if self.数据[玩家数据[id].角色.法宝[n]]==nil then
				玩家数据[id].角色.法宝[n]=nil
			else
				self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.法宝[n]]))
				if self.发送数据.道具[n].回合~=nil then
					if self.发送数据.道具[n].回合<=回合 then
						self.发送数据.道具[n].回合=nil
					else
						self.发送数据.道具[n].回合=self.发送数据.道具[n].回合-回合
					end
				end
			end
		end
	end
	self.发送数据.银子=玩家数据[id].角色.银子
	self.发送数据.储备=玩家数据[id].角色.储备
	self.发送数据.存银=玩家数据[id].角色.存银
	return self.发送数据
end

function 道具处理类:索要法宝1(id,回合)
	self.发送数据={道具={}}
	for n=1,20 do
		if 玩家数据[id].角色.法宝[n]~=nil then
			if self.数据[玩家数据[id].角色.法宝[n]]==nil then
				玩家数据[id].角色.法宝[n]=nil
			else
				self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.法宝[n]]))
				if self.发送数据.道具[n].回合~=nil then
					if self.发送数据.道具[n].回合<=回合 then
						self.发送数据.道具[n].回合=nil
					else
						self.发送数据.道具[n].回合=self.发送数据.道具[n].回合-回合
					end
				end
			end
		end
	end
	return self.发送数据
end

function 道具处理类:索要行囊(连接id,id)
	self.发送数据={道具={}}
	for n=1,20 do
		if 玩家数据[id].角色.行囊[n]~=nil then
			if self.数据[玩家数据[id].角色.行囊[n]]==nil then
				玩家数据[id].角色.行囊[n]=nil
			else
				self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.行囊[n]]))
			end
		end
	end
	self.发送数据.银子=玩家数据[id].角色.银子
	self.发送数据.储备=玩家数据[id].角色.储备
	self.发送数据.存银=玩家数据[id].角色.存银
	发送数据(连接id,3502,self.发送数据)
end

function 道具处理类:激活符石对话(id,道具id)
  if self.数据[道具id]~=nil and  self.数据[道具id].名称=="未激活的符石" then
	玩家数据[id].激活符石 = 道具id
	local 消耗数据 = 激活符石消耗(self.数据[道具id].子类)
	local 对话="#W/需要消耗"..消耗数据.体力.."点体力"..消耗数据.经验.."点经验来激活这块符石么。#Y/(激活后为专用，无法转移给他人)"
	local xx={"确定","取消"}
	玩家数据[id].最后对话={}
	玩家数据[id].最后对话.名称="激活符石"
	玩家数据[id].最后对话.模型=玩家数据[id].角色.模型
	发送数据(玩家数据[id].连接id,1501,{名称="激活符石",模型=玩家数据[id].角色.模型,对话=对话,选项=xx})
  elseif self.数据[道具id]~=nil and self.数据[道具id].名称=="未激活的星石" then
	玩家数据[id].激活符石 = 道具id
	local 消耗数据 = 激活符石消耗(4)
	local 对话="#W/需要消耗"..消耗数据.体力.."点体力"..消耗数据.经验.."点经验来激活这块符石么。#Y/(激活后为专用，无法转移给他人)"
	local xx={"确定","取消"}
	玩家数据[id].最后对话={}
	玩家数据[id].最后对话.名称="激活符石"
	玩家数据[id].最后对话.模型=玩家数据[id].角色.模型
	发送数据(玩家数据[id].连接id,1501,{名称="激活符石",模型=玩家数据[id].角色.模型,对话=对话,选项=xx})
  end
end

function 道具处理类:激活符石(id)
  local 道具id = 玩家数据[id].激活符石
  if self.数据[道具id]~=nil and  self.数据[道具id].名称=="未激活的符石" then
	local 消耗数据 = 激活符石消耗(self.数据[道具id].子类)
	if 玩家数据[id].角色.体力 < 消耗数据.体力 then
	  常规提示(id,"体力不足，无法激活符石。")
	  return
	end
	if 玩家数据[id].角色.当前经验<消耗数据.经验 then
	  常规提示(id,"经验不足，无法激活符石。")
	  return
	end
	玩家数据[id].角色.当前经验 = 玩家数据[id].角色.当前经验 - 消耗数据.经验
	玩家数据[id].角色.体力 = 玩家数据[id].角色.体力 - 消耗数据.体力
	self.数据[道具id].名称 = self.数据[道具id].符石名称
	self.数据[道具id].分类 = 88
	self.数据[道具id].不可交易 = true
	添加最后对话(id,"你消耗了"..消耗数据.体力.."体力"..消耗数据.经验.."经验,将"..self.数据[道具id].名称.."成功激活.这块符石可以镶嵌在已经开运过的装备上#50。")
	道具刷新(id)
	return
  elseif self.数据[道具id]~=nil and  self.数据[道具id].名称=="未激活的星石" then
	local 消耗数据 = 激活符石消耗(4)
	if 玩家数据[id].角色.体力 < 消耗数据.体力 then
	  常规提示(id,"体力不足，无法激活符石。")
		return
	end
	if 玩家数据[id].角色.当前经验<消耗数据.经验 then
	  常规提示(id,"经验不足，无法激活符石。")
	  return
	end
	玩家数据[id].角色.当前经验 = 玩家数据[id].角色.当前经验 - 消耗数据.经验
	玩家数据[id].角色.体力 = 玩家数据[id].角色.体力 - 消耗数据.体力
	self.数据[道具id].分类 = 91
	self.数据[道具id].不可交易 = true
	if self.数据[道具id].子类 == 1 then
	  self.数据[道具id].名称 = "云荒"
	elseif self.数据[道具id].子类 == 2 then
	  self.数据[道具id].名称 = "暮霭"
	elseif self.数据[道具id].子类 == 3 then
	  self.数据[道具id].名称 = "落日"
	elseif self.数据[道具id].子类 == 4 then
	  self.数据[道具id].名称 = "晓天"
	elseif self.数据[道具id].子类 == 5 then
	  self.数据[道具id].名称 = "林海"
	elseif self.数据[道具id].子类 == 6 then
	  self.数据[道具id].名称 = "流霞"
	else
	  self.数据[道具id].名称 = "云荒"
	end
	添加最后对话(id,"你消耗了"..消耗数据.体力.."体力"..消耗数据.经验.."经验,将"..self.数据[道具id].名称.."成功激活.这块符石可以镶嵌在已经开运过的装备上#50。")
	道具刷新(id)
	return
  end
end

function 道具处理类:拆分道具(连接id,id,数据) --道具拆分
  local 拆分数量 = 数据.文本
  if type(拆分数量)~="number" then
    常规提示(id,"#Y/请输入数字！谢谢")
    return
  elseif 拆分数量+0 < 1 then
    常规提示(id,"#Y/至少拆分一个")
    return
  elseif 玩家数据[id].角色.道具[数据.道具id+0]==nil then
  	常规提示(id,"#Y/你没有这个道具")
    return
  end
  local djbh=玩家数据[id].角色.道具[数据.道具id+0]
  if self.数据[djbh]==nil then
  	常规提示(id,"#Y/你没有这个道具")
  elseif self.数据[djbh].可叠加 and self.数据[djbh].数量 then
  	if self.数据[djbh].数量 > 拆分数量 then
  		local 临时格子 = 玩家数据[id].角色:取道具格子()
      local 新编号 = 玩家数据[id].道具:取新编号()
      if 临时格子~=0 then
      	self.数据[新编号] = table.copy(self.数据[djbh])
      	self.数据[新编号].数量 = 拆分数量
      	local 识别码=id.."_"..os.time().."_"..取随机数(1000,9999).."_"..随机序列
	      随机序列=随机序列+1
	      self.数据[新编号].识别码 = 识别码
	      玩家数据[id].角色.道具[临时格子] = 新编号
      	self.数据[djbh].数量 = self.数据[djbh].数量 - 拆分数量
      	道具刷新(id)
      else
      	常规提示(id,"#Y/背包已满不可拆分")
      end
  	else
  	  常规提示(id,"#Y/道具数量必须大于拆分数量")
  	end
  else
    常规提示(id,"#Y/这个物品不能拆分")
  end
end

function 道具处理类:装备镶嵌符石(数字id,sj)
	local id = 数字id + 0
	local 装备道具=self.数据[玩家数据[id].符石镶嵌]
	local 符石操作序列 = sj
	local 星石操作 = nil
	--判断装备是否可以镶嵌
	if 装备道具==nil then
		常规提示(id,"你没有这样的装备！")
		return
	elseif 装备道具.总类~=2 or 装备道具.灵饰 or 装备道具.召唤兽装备 then
		常规提示(id,"我这里目前只能点化人物装备的星位，其它的我可没那么大的能耐。")
		return
	end

	if not 判断是否为空表(符石操作序列) then
		local 重复 = false
		for k,v in pairs(符石操作序列) do
			if 重复 then
				break
			end
			if v.方式=="镶嵌" then
				local lssj =玩家数据[数字id].角色.道具[v.物品id]
				if v.背包类型=="道具" then
					lssj=玩家数据[数字id].角色.道具[v.物品id]
				else
					lssj=玩家数据[数字id].角色.行囊[v.物品id]
				end
				if self.数据[lssj]==nil then
					常规提示(id,"道具数据异常，请重新打开界面进行操作1。")
					return
				end
				if k<=5 and (self.数据[lssj].总类~=889 or self.数据[lssj].分类~=88) then
					常规提示(id,"镶嵌需要符石，请给予我符石道具。")
					return
				elseif k==6 and (self.数据[lssj].总类~=889 or self.数据[lssj].分类~=91) then
					常规提示(id,"镶嵌需要星石，请给予我星石道具。")
					return
				end
				for n,i in pairs(符石操作序列) do
					if k~=n and i.方式=="镶嵌" and v.背包类型==i.背包类型 and v.物品id==i.物品id then
						重复=true
						break
					end
				end
			end
		end

		if not 重复 then

			if 装备道具.星位==nil then
				装备道具.星位={组合="",部位="无",门派="无"}
			end
			for k,v in pairs(符石操作序列) do
				if v.方式=="扣除" then
					装备道具.星位[k]=nil
				elseif v.方式=="镶嵌" then
					local lssj =玩家数据[数字id].角色.道具[v.物品id]
					if v.背包类型=="道具" then
						lssj=玩家数据[数字id].角色.道具[v.物品id]
					else
						lssj=玩家数据[数字id].角色.行囊[v.物品id]
					end
					if k==6 then --星石
						装备道具.星位[k] = {}
						装备道具.星位[k].名称 = self.数据[lssj].名称
						装备道具.星位[k].颜色 = 取星位颜色(self.数据[lssj].子类)[2]
						装备道具.星位[k].阴阳 = 2
						local 临时属性 = 取星位属性(self.数据[lssj].子类)
						装备道具.星位[k].符石属性={}
						装备道具.星位[k].符石属性[临时属性.名称]=临时属性.属性值
					else
						装备道具.星位[k]={颜色=self.数据[lssj].颜色,名称=self.数据[lssj].名称,符石属性=self.数据[lssj].符石属性,符石等级=self.数据[lssj].子类}
					end
					self.数据[lssj]=nil
				end
			end
			if 装备道具.星位组 and 装备道具.星位~=nil and 装备道具.星位[6]~=nil then
				装备道具.星位[6].相互 = nil
				local 等级计算 = 0
				for n=1,5 do
					if  装备道具.星位~=nil and 装备道具.星位[n]~=nil then
						等级计算 = 等级计算 + (装备道具.星位[n].符石等级 or 0)
					end
				end
				if 等级计算~=0 then
					if 等级计算%2==0 then
						--偶数 反面
						if 装备道具.星位[6].阴阳==2 then
							装备道具.星位[6].相互={}
							装备道具.星位[6].相互[取星位相互(装备道具.分类)]=2
						end
					else
						if 装备道具.星位[6].阴阳==1 then
							装备道具.星位[6].相互={}
							装备道具.星位[6].相互[取星位相互(装备道具.分类)]=2
						end
					end
				end
			end
			常规提示(id,"镶嵌成功。")
			local 星位数据=取星位组合(装备道具.星位)
			if 星位数据 ~=nil then
				装备道具.星位.组合=星位数据.组合
				装备道具.星位.部位=星位数据.部位
				装备道具.星位.门派=星位数据.门派
				装备道具.星位.组合等级=星位数据.等级
				常规提示(id,"#Y你的这件装备似乎开启了神秘的力量")
			else
				装备道具.星位.组合=nil
				装备道具.星位.部位=nil
				装备道具.星位.门派=nil
				装备道具.星位.组合等级=nil
			end
			if 符石操作序列[6]~=nil then
				星石操作=true
			end
			道具刷新(id)

			发送数据(玩家数据[id].连接id,3550,{装备=装备道具,星石操作=星石操作})
		else
			常规提示(id,"道具数据异常，请重新打开界面进行操作2。")
			return
		end
	else
		常规提示(id,"道具数据异常，请重新打开界面进行操作3。")
		return
	end
end

function 道具处理类:装备开启星位(连接id,数字id,数据)
  local 装备编号 = 玩家数据[数字id].角色.道具[数据.装备]
  local id = 数字id
  if self.数据[装备编号].总类~=2 or self.数据[装备编号].灵饰 or self.数据[装备编号].分类>6 then
	常规提示(id,"少侠，只有人物装备才可以开启星位。")
	return
  elseif self.数据[装备编号].级别限制==nil and self.数据[装备编号].级别限制<60 then
	常规提示(id,"少侠，需要装备等级达到60级才可以开启星位。")
	return
  elseif self.数据[装备编号].开运孔数==nil or self.数据[装备编号].开运孔数.当前<self.数据[装备编号].开运孔数.上限 then
	常规提示(id,"少侠，你的装备孔数没满，不能开启星位。")
	return
  elseif self.数据[装备编号].星位组~=nil then
	常规提示(id,"少侠，你这件装备已经开启过星位了别闹了（&……*&")
	return
  end
  local 临时消耗 = 取开启星位消耗(self.数据[装备编号].级别限制)
  if 玩家数据[id].角色.银子<临时消耗.金钱 and not 玩家数据[id].角色.武神坛角色 then
	常规提示(id,format("开启星位需要消耗#Z/%s#Y/两银子，你似乎手头有点紧哟？",临时消耗.金钱))
	return
  elseif 玩家数据[id].角色.当前经验<临时消耗.经验 then
	常规提示(id,format("开启星位需要消耗#Z/%s#Y/点经验，你似乎没有那么多的经验？",临时消耗.经验))
	return
  end
  if not 玩家数据[id].角色.武神坛角色 then --武神坛改
	  玩家数据[id].角色:扣除银子(临时消耗.金钱,0,0,"开启星位",1)
	end

  玩家数据[id].角色.当前经验=玩家数据[id].角色.当前经验-临时消耗.经验
  self.数据[装备编号].星位组 = true
  常规提示(id,"#Z/恭喜你开启星位成功！")
  道具刷新(id)
end

function 道具处理类:装备翻转星石(数字id)
	local id = 数字id + 0
	local 装备道具 = self.数据[玩家数据[id].符石镶嵌]
	if 装备道具==nil then
	常规提示(id,"你没有这样的装备！")
	return
  elseif 装备道具.总类~=2 or 装备道具.灵饰 or 装备道具.分类==9 or 装备道具.分类==8 or 装备道具.分类==7 then
	常规提示(id,"我这里目前只能点化人物装备的星位，其它的我可没那么大的能耐。")
	return
  elseif not 装备道具.星位组 or 装备道具.星位==nil or 装备道具.星位[6]==nil then
	常规提示(id,"装备数据错误，请重新打开界面！")
	return
  end
  if 玩家数据[id].角色.体力 >= 100 then
	if 装备道具.星位组 and 装备道具.星位~=nil and 装备道具.星位[6]~=nil then
	  if 装备道具.星位[6].阴阳 ==1 then
		装备道具.星位[6].阴阳 = 2
		装备道具.星位[6].颜色 = 取星位颜色(装备道具.分类)[2]
	  else
		装备道具.星位[6].阴阳 = 1
		装备道具.星位[6].颜色 = 取星位颜色(装备道具.分类)[1]
	  end
	  装备道具.星位[6].相互 = nil
	  local 等级计算 = 0
	  for n=1,5 do
		if  装备道具.星位~=nil and 装备道具.星位[n]~=nil then
		  等级计算 = 等级计算 + 装备道具.星位[n].符石等级
		end
	  end
	  if 等级计算~=0 then
		if 等级计算%2==0 then
		  --偶数 反面
		  if 装备道具.星位[6].阴阳==2 then
			装备道具.星位[6].相互={}
			装备道具.星位[6].相互[取星位相互(装备道具.分类)]=2
		  end
		else
		  if 装备道具.星位[6].阴阳==1 then
			装备道具.星位[6].相互={}
			装备道具.星位[6].相互[取星位相互(装备道具.分类)]=2
		  end
		end
	  end
	end
	玩家数据[id].角色.体力=玩家数据[id].角色.体力-100
	常规提示(id,"翻转星位成功。")
	道具刷新(id)
	玩家数据[id].角色:刷新信息()

	发送数据(玩家数据[id].连接id,3550,{装备=装备道具})
  else
	常规提示(id,"体力不足，无法翻转")
  end
end

function 道具处理类:翻转星石对话(id,道具id)
  local 装备道具 = self.数据[玩家数据[id].符石镶嵌]
	if 装备道具==nil then
	常规提示(id,"你没有这样的装备！")
	return
  elseif 装备道具.总类~=2 or 装备道具.灵饰 or 装备道具.分类==9 or 装备道具.分类==8 or 装备道具.分类==7 then
	常规提示(id,"我这里目前只能点化人物装备的星位，其它的我可没那么大的能耐。")
	return
  elseif not 装备道具.星位组 or 装备道具.星位==nil or 装备道具.星位[6]==nil then
	常规提示(id,"装备数据错误，请重新打开界面！")
	return
  end
  local 对话="#W/确定要将星石翻转吗？翻转星石不会引起星石自身属性变化，请放心操作。"
  local xx={"消耗100体力进行翻转","取消"}
  玩家数据[id].最后对话={}
  玩家数据[id].最后对话.名称="翻转星石"
  玩家数据[id].最后对话.模型=玩家数据[id].角色.模型
  发送数据(玩家数据[id].连接id,1501,{名称="翻转星石",模型=玩家数据[id].角色.模型,对话=对话,选项=xx})
end

function 道具处理类:合成符石(连接id,数字id,数据)
  local id = 数字id
  local 物品 = 数据.材料
  local 卷轴 = 0
  local 卷轴道具 = 0
  local 符石 = {}
  local 符石道具 = {}
  local f1,f2,f3=0,0,0
  local 玩家道具栏 = 玩家数据[id].角色.道具
  local 道具格子 = 玩家数据[id].角色:取道具格子()
  if 道具格子 == 0 then
	常规提示(id,"你的道具栏已经满了,保留至少一格以上的位置进行合成哦")
	return
  end
  if 玩家数据[id].角色.体力<40 then
	常规提示(id,"合成符石至少需要40点体力哦。")
	return
  end
  for k,v in pairs(物品) do
	if self.数据[玩家道具栏[v]]~=nil and self.数据[玩家道具栏[v]].总类 == 889 and self.数据[玩家道具栏[v]].分类 == 89 then
	  if self.数据[玩家道具栏[v]].子类==6 then
		卷轴 = 玩家道具栏[v]
		卷轴道具 = v
	  else
		符石[#符石+1] = 玩家道具栏[v]
		符石道具[#符石道具+1] = v
		if self.数据[符石[#符石]].子类==1 then
		  f1=f1+1
		elseif self.数据[符石[#符石]].子类==2 then
		  f2=f2+1
		elseif self.数据[符石[#符石]].子类==3 then
		  f3=f3+1
		end
	  end
	else
	  常规提示(id,"少侠，给的物品不对哦。")
		return
	end
  end

  local 是否合成 = false
  if f1>=1 and f1+f2==3 and f3==0 and 卷轴==0 then -- 合成二级符石
	是否合成 = 1
  elseif f2>=1 and f2+f3==2 and 卷轴~=0 and f1==0 then -- 合成三级符石
	是否合成 = 2
  elseif f3>=2 and 卷轴~=0 and f2==0 and f1==0 then  --合成新三符石
	是否合成 = 3
  elseif f3>=1 and f1+f2+f3==3 and 卷轴~=0 then --合成4级符石
	是否合成 = 4
  else
	常规提示(id,"请仔细查看放入的材料是否正确。")
	return
  end
  玩家数据[id].角色:扣除体力(40,nil,1)
  local 概率范围 = 取随机数(1,1000)
  if 是否合成 == 1 then
	local 成功率 = 800
	if 概率范围 <= 成功率 then
	  for i=1,#符石 do
		self.数据[符石[i]] = nil
		玩家道具栏[符石道具[i]] = nil
	  end
	  玩家数据[id].道具:给予道具(id,"未激活的符石",2)
	  常规提示(id,"合成成功")
	else
	  for i=1,#符石 do
		if 50 <= 取随机数(1,100) then
		  self.数据[符石[i]] = nil
		  玩家道具栏[符石道具[i]] = nil
		  break
		elseif i==#符石 then
		  self.数据[符石[i]] = nil
		  玩家道具栏[符石道具[i]] = nil
		  break
		end
	  end
	  道具刷新(id)
	  常规提示(id,"合成失败，你因此随机损失了一个符石")
	end
  elseif 是否合成 == 2 then
	local 成功率 = 600
	if  概率范围 <= 成功率 then
	  for i=1,#符石 do
		self.数据[符石[i]]=nil
		玩家道具栏[符石道具[i]] = nil
	  end
		self.数据[卷轴] = nil
		玩家道具栏[卷轴道具] = nil
	  玩家数据[id].道具:给予道具(id,"未激活的符石",3)
	  常规提示(id,"合成成功")
	else
		self.数据[卷轴] = nil
	  道具刷新(id)
	  常规提示(id,"合成失败，你因此损失了一个符石卷轴")
	end
  elseif 是否合成 == 3 then
	local 成功率 = 300
	if 概率范围 <= 成功率 then
	  for i=1,#符石 do
		self.数据[符石[i]]=nil
		玩家道具栏[符石道具[i]] = nil
	  end
		self.数据[卷轴] = nil
		玩家道具栏[卷轴道具] = nil
	  local 获取符石 = 新三级符石[取随机数(1,#新三级符石)]
	  玩家数据[id].道具:给予道具(id,获取符石,3)
	  常规提示(id,"合成成功")
	else
		self.数据[卷轴] = nil
		玩家道具栏[卷轴道具] = nil
	  for i=1,#符石 do
		if 50 <= 取随机数(1,100) then
		  self.数据[符石[i]] = nil
		  玩家道具栏[符石道具[i]] = nil
		  break
		else
		  self.数据[符石[i]] = nil
		  玩家道具栏[符石道具[i]] = nil
		  break
		end
	  end
	  道具刷新(id)
	  常规提示(id,"合成失败，你因此损失了一个符石卷轴及一颗符石")
	end
  elseif 是否合成 == 4 then
	local 成功率 = 400
	if 概率范围 <= 成功率 then
	  for i=1,#符石 do
		self.数据[符石[i]]=nil
		玩家道具栏[符石道具[i]] = nil
	  end
	 	self.数据[卷轴] = nil
		玩家道具栏[卷轴道具] = nil
	    玩家数据[id].道具:给予道具(id,"未激活的星石")
	    常规提示(id,"合成成功")
	else
		self.数据[卷轴] = nil
		玩家道具栏[卷轴道具] = nil
	    道具刷新(id)
	    常规提示(id,"合成失败，你因此损失了一个符石卷轴")
	      end
    end
end

function 道具处理类:月卡奖励(id)
  if 玩家数据[id].角色.月卡 == nil  then
    玩家数据[id].角色.月卡 = {生效=false,到期时间=0}
  end
  if os.time()-玩家数据[id].角色.月卡.到期时间 >= 0 or 玩家数据[id].角色.月卡.生效 == false then
    玩家数据[id].角色.月卡.生效=false
    常规提示(id,"#Y该会员已到期！")
    return
  end
  if 玩家数据[id].角色.月卡.使用日期 == nil then
    玩家数据[id].角色.月卡.使用日期 = os.date("%d", os.time())
    玩家数据[id].角色.月卡.使用月份 = os.date("%m", os.time())
  elseif os.date("%d", os.time()) == 玩家数据[id].角色.月卡.使用日期 and os.date("%m", os.time()) == 玩家数据[id].角色.月卡.使用月份 then
  	  常规提示(id,"#您今日已经领取月卡奖励！")
    return 0
  else
    玩家数据[id].角色.月卡.使用日期 = os.date("%d", os.time())
    玩家数据[id].角色.月卡.使用月份 = os.date("%m", os.time())
  end
  --玩家数据[id].角色:添加经验(20000000,"月卡奖励",1)
  玩家数据[id].角色:添加银子(10000000,"月卡奖励",1)
  self:给予道具(id,"特殊兽诀·碎片",5)
  self:给予道具(id,"超级兽诀·碎片",5)
  self:给予道具(id,"神兜兜",10)
  self:给予道具(id,"修炼果",10)
  道具刷新(id)
end
function 道具处理类:开启铜矿(id,任务id)
          if 采矿活动[id]==nil then
           采矿活动[id]={总计=0}
          end
         if  玩家数据[id].角色.采矿数据 == nil then
         玩家数据[id].角色.采矿数据= {熟练度=0,矿业声望=0}
         end
  if 采矿活动[id].总计>=30 then
    常规提示(id,"#Y少侠今日已开采矿石30次,无法继续开采。")
    return
  elseif  玩家数据[id].角色.体力< 20  then
     常规提示(id,"#Y少侠体力不足,无法继续开采。")
    return
  end
  采矿活动[id].总计=采矿活动[id].总计+1
  玩家数据[id].角色.采矿数据.熟练度=玩家数据[id].角色.采矿数据.熟练度+1
  玩家数据[id].角色.采矿数据.矿业声望=玩家数据[id].角色.采矿数据.矿业声望+1
  玩家数据[id].角色.体力 = 玩家数据[id].角色.体力-20
  常规提示(id,"#Y恭喜少侠采矿#R熟练度#Y和#R声望#Y各增加#G1#Y点！")
  local 银子=取随机数(30000,50000)
  玩家数据[id].角色:添加银子(银子,"铜矿",1)
  local 奖励参数=取随机数(1,200)
  if 取随机数()<=50 then
     local 获得物品={}
     for i=1,#自定义数据.铜铁矿 do
         if 取随机数()<=自定义数据.铜铁矿[i].概率 then
            获得物品[#获得物品+1]=自定义数据.铜铁矿[i]
         end
     end
     获得物品=删除重复(获得物品)
     if 获得物品~=nil then
        local 取编号=取随机数(1,#获得物品)
        if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
           玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
           广播消息({内容=format("#S(铜铁矿)#R/%s#Y坚持五天五夜挖矿，终于挖出宝物[#G/%s]#Y",玩家数据[id].角色.名称,获得物品[取编号].名称),频道="xt"})
        end
     end
  else
     local 等级=玩家数据[id].角色.等级
     local 经验=(等级*300*2)
     玩家数据[id].角色:添加经验(经验,"宝藏山大箱子",1)
  end
end
function 道具处理类:开启银矿(id,任务id)
        if 采矿活动[id]==nil then
           采矿活动[id]={总计=0}
          end
       if  玩家数据[id].角色.采矿数据 == nil then
         玩家数据[id].角色.采矿数据= {熟练度=0,矿业声望=0}
         end
  if 采矿活动[id].总计>=30 then
    常规提示(id,"#Y少侠今日已开采矿石30次,无法继续开采。")
    return
  elseif  玩家数据[id].角色.采矿数据.熟练度< 25 then
    常规提示(id,"#Y少侠采矿熟练度不足,无法继续开采白银矿。")
    return
  elseif  玩家数据[id].角色.体力< 20  then
     常规提示(id,"#Y少侠体力不足,无法继续开采。")
    return
  end
  采矿活动[id].总计=采矿活动[id].总计+1
  玩家数据[id].角色.采矿数据.熟练度=玩家数据[id].角色.采矿数据.熟练度+2
  玩家数据[id].角色.采矿数据.矿业声望=玩家数据[id].角色.采矿数据.矿业声望+2
  玩家数据[id].角色.体力 = 玩家数据[id].角色.体力-20
  常规提示(id,"#Y恭喜少侠采矿#R熟练度#Y和#R声望#Y各增加#G2#Y点！")
  local 银子=取随机数(40000,60000)
  玩家数据[id].角色:添加银子(银子,"银矿",1)
  local 奖励参数=取随机数(1,200)
  if 取随机数()<=50 then
     local 获得物品={}
     for i=1,#自定义数据.白银矿 do
         if 取随机数()<=自定义数据.白银矿[i].概率 then
            获得物品[#获得物品+1]=自定义数据.白银矿[i]
         end
     end
     获得物品=删除重复(获得物品)
     if 获得物品~=nil then
        local 取编号=取随机数(1,#获得物品)
        if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
           玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
           广播消息({内容=format("#S(白银矿)#R/%s#Y坚持五天五夜挖矿，终于挖出宝物[#G/%s]#Y",玩家数据[id].角色.名称,获得物品[取编号].名称),频道="xt"})
        end
     end
  else
     local 等级=玩家数据[id].角色.等级
     local 经验=(等级*300*2)
     玩家数据[id].角色:添加经验(经验,"银矿",1)
  end
end
function 道具处理类:开启翡翠矿(id,任务id)
        if 采矿活动[id]==nil then
           采矿活动[id]={总计=0}
          end
      if  玩家数据[id].角色.采矿数据 == nil then
         玩家数据[id].角色.采矿数据= {熟练度=0,矿业声望=0}
         end
  if 采矿活动[id].总计>=30 then
    常规提示(id,"#Y少侠今日已开采矿石30次,无法继续开采。")
    return
  elseif  玩家数据[id].角色.采矿数据.熟练度< 100 then
    常规提示(id,"#Y少侠采矿熟练度不足100,无法继续开采翡翠矿。")
    return
  elseif  玩家数据[id].角色.体力< 20  then
     常规提示(id,"#Y少侠体力不足,无法继续开采。")
    return
  end
  采矿活动[id].总计=采矿活动[id].总计+1
  玩家数据[id].角色.采矿数据.熟练度=玩家数据[id].角色.采矿数据.熟练度+2
  玩家数据[id].角色.采矿数据.矿业声望=玩家数据[id].角色.采矿数据.矿业声望+2
  玩家数据[id].角色.体力 = 玩家数据[id].角色.体力-20
  常规提示(id,"#Y恭喜少侠采矿#R熟练度#Y和#R声望#Y各增加#G2#Y点！")
  local 银子=取随机数(50000,80000)
  玩家数据[id].角色:添加银子(银子,"银矿",1)
  local 奖励参数=取随机数(1,200)
  if 取随机数()<=50 then
     local 获得物品={}
     for i=1,#自定义数据.翡翠矿 do
         if 取随机数()<=自定义数据.翡翠矿[i].概率 then
            获得物品[#获得物品+1]=自定义数据.翡翠矿[i]
         end
     end
     获得物品=删除重复(获得物品)
     if 获得物品~=nil then
        local 取编号=取随机数(1,#获得物品)
        if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
           玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
           广播消息({内容=format("#S(翡翠矿)#R/%s#Y坚持五天五夜挖矿，终于挖出宝物[#G/%s]#Y",玩家数据[id].角色.名称,获得物品[取编号].名称),频道="xt"})
        end
     end
  else
     local 等级=玩家数据[id].角色.等级
     local 经验=(等级*300*2)
     玩家数据[id].角色:添加经验(经验,"银矿",1)
  end
end
function 道具处理类:开启黄金矿(id,任务id)
        if 采矿活动[id]==nil then
           采矿活动[id]={总计=0}
          end
        if  玩家数据[id].角色.采矿数据 == nil then
         玩家数据[id].角色.采矿数据= {熟练度=0,矿业声望=0}
         end
  if 采矿活动[id].总计>=30 then
    常规提示(id,"#Y少侠今日已开采矿石30次,无法继续开采。")
    return
  elseif  玩家数据[id].角色.采矿数据.熟练度< 300 then
    常规提示(id,"#Y少侠采矿熟练度不足300,无法继续开采黄金矿。")
    return
  elseif  玩家数据[id].角色.体力< 20  then
     常规提示(id,"#Y少侠体力不足,无法继续开采。")
    return
  end
  采矿活动[id].总计=采矿活动[id].总计+1
  玩家数据[id].角色.采矿数据.熟练度=玩家数据[id].角色.采矿数据.熟练度+3
  玩家数据[id].角色.采矿数据.矿业声望=玩家数据[id].角色.采矿数据.矿业声望+3
  玩家数据[id].角色.体力 = 玩家数据[id].角色.体力-20
  常规提示(id,"#Y恭喜少侠采矿#R熟练度#Y和#R声望#Y各增加#G2#Y点！")
 local 银子=取随机数(50000,80000)
  玩家数据[id].角色:添加银子(银子,"黄金矿",1)
  local 奖励参数=取随机数(1,200)
  if 取随机数()<=50 then
     local 获得物品={}
     for i=1,#自定义数据.黄金矿 do
         if 取随机数()<=自定义数据.黄金矿[i].概率 then
            获得物品[#获得物品+1]=自定义数据.黄金矿[i]
         end
     end
     获得物品=删除重复(获得物品)
     if 获得物品~=nil then
        local 取编号=取随机数(1,#获得物品)
        if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
           玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
           广播消息({内容=format("#S(黄金矿)#R/%s#Y坚持五天五夜挖矿，终于挖出宝物[#G/%s]#Y",玩家数据[id].角色.名称,获得物品[取编号].名称),频道="xt"})
        end
     end
  else
     local 等级=玩家数据[id].角色.等级
     local 经验=(等级*300*2)
     玩家数据[id].角色:添加经验(经验,"黄金矿",1)
  end
end
function 道具处理类:开启紫金矿(id,任务id)
        if 采矿活动[id]==nil then
           采矿活动[id]={总计=0}
          end
        if  玩家数据[id].角色.采矿数据 == nil then
         玩家数据[id].角色.采矿数据= {熟练度=0,矿业声望=0}
         end
  if 采矿活动[id].总计>=30 then
    常规提示(id,"#Y少侠今日已开采矿石30次,无法继续开采。")
    return
  elseif  玩家数据[id].角色.采矿数据.熟练度< 500 then
    常规提示(id,"#Y少侠采矿熟练度不足500,无法继续开采黄金矿。")
    return
  elseif  玩家数据[id].角色.体力< 20  then
     常规提示(id,"#Y少侠体力不足,无法继续开采。")
    return
  end
  采矿活动[id].总计=采矿活动[id].总计+1
  玩家数据[id].角色.采矿数据.熟练度=玩家数据[id].角色.采矿数据.熟练度+5
  玩家数据[id].角色.采矿数据.矿业声望=玩家数据[id].角色.采矿数据.矿业声望+5
  玩家数据[id].角色.体力 = 玩家数据[id].角色.体力-20
    常规提示(id,"#Y恭喜少侠采矿#R熟练度#Y和#R声望#Y各增加#G2#Y点！")
  local 银子=取随机数(100000,120000)
  玩家数据[id].角色:添加银子(银子,"紫金矿",1)
  local 奖励参数=取随机数(1,200)
  if 取随机数()<=50 then
     local 获得物品={}
     for i=1,#自定义数据.紫金矿 do
         if 取随机数()<=自定义数据.紫金矿[i].概率 then
            获得物品[#获得物品+1]=自定义数据.紫金矿[i]
         end
     end
     获得物品=删除重复(获得物品)
     if 获得物品~=nil then
        local 取编号=取随机数(1,#获得物品)
        if 获得物品[取编号]~=nil and 获得物品[取编号].名称~=nil and 获得物品[取编号].数量~=nil then
           玩家数据[id].道具:自定义给予道具(id,获得物品[取编号].名称,获得物品[取编号].数量,获得物品[取编号].参数)
           广播消息({内容=format("#S(紫金矿)#R/%s#Y坚持五天五夜挖矿，终于挖出宝物[#G/%s]#Y",玩家数据[id].角色.名称,获得物品[取编号].名称),频道="xt"})
        end
     end
  else
     local 等级=玩家数据[id].角色.等级
     local 经验=(等级*300*2)
     玩家数据[id].角色:添加经验(经验,"紫金矿",1)
  end
end
function 道具处理类:自定义给予道具(id,名称,数量,参数)
  if 名称=="钨金" or 名称=="附魔宝珠" or 名称=="炼妖石" or 名称=="天眼珠" or 名称=="上古锻造图策" then
     self:给予道具(id,名称,数量,参数)
     if 玩家数据[id].抽中编号~=nil then
         广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,名称),频道="xt"})
     end
   elseif  名称=="珍珠" or 名称=="战魄" then
     local 给予等级 = 数量[取随机数(1,#数量)]
     self:给予道具(id,名称,给予等级,参数)
     if 玩家数据[id].抽中编号~=nil then
         广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/级的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,给予等级,名称),频道="xt"})
     end
   elseif 名称=="制造指南书" or 名称=="百炼精铁" then
      local 给予等级 = 取随机数(数量[1],数量[#数量])*10
      if 参数==nil then
        if 取随机数()<=50 then
           参数= 取随机数(1,18)
        else
           参数= 取随机数(19,#书铁范围)
        end
      end
      self:给予道具(id,名称,给予等级,参数)
      if 玩家数据[id].抽中编号~=nil then
         广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/级的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,给予等级,名称),频道="xt"})
      end
   elseif 名称=="150随机书铁"then
   	  local 给予等级 = 取随机数(数量[1],数量[#数量])*10
      if 参数==nil then
        if 取随机数()<=50 then
           参数= 取随机数(1,18)
        else
           参数= 取随机数(19,#书铁范围)
        end
      end
      self:给予道具(id,"制造指南书",给予等级,参数)
      self:给予道具(id,"百炼精铁",给予等级,参数)
      if 玩家数据[id].抽中编号~=nil then
         广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/级的#G/随机书铁一套#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,给予等级),频道="xt"})
      end

    elseif  名称=="140灵饰书铁" then
      if 参数==nil then
         local 临时范围 = {"手镯","佩饰","戒指","耳饰"}
         参数= 临时范围[取随机数(1,4)]
      end
      self:给予道具(id,"灵饰指南书",数量,参数)
      self:给予道具(id,"元灵晶石",数量,参数)

      if 玩家数据[id].抽中编号~=nil then
         广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了制作#G/%s#Y/的#G/随机灵饰书铁一套#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,参数),频道="xt"})
      end
   elseif  名称=="灵饰指南书" or 名称=="元灵晶石" then
      if 参数==nil then
         local 临时范围 = {"手镯","佩饰","戒指","耳饰"}
         参数= 临时范围[取随机数(1,4)]
      end
      self:给予道具(id,名称,数量,参数)
      if 玩家数据[id].抽中编号~=nil then
         广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了制作#G/%s#Y/的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,参数,名称),频道="xt"})
      end
   elseif 名称=="魔兽要诀" or 名称=="高级魔兽要诀" or 名称=="特殊魔兽要诀" or 名称=="超级魔兽要诀" or 名称=="召唤兽内丹" or 名称=="高级召唤兽内丹" or 名称=="点化石" then
         if 参数 ==nil then
           if 名称=="召唤兽内丹" then
              参数=取内丹()
           elseif 名称=="高级召唤兽内丹" then
                  参数=取内丹("高级")
           elseif 名称=="魔兽要诀" then
                  参数=取低级要诀()
           elseif 名称=="高级魔兽要诀" then
                  参数=取高级要诀()
           elseif 名称=="特殊魔兽要诀" then
                  参数=取特殊要诀()
           elseif 名称=="超级魔兽要诀" then
                  参数=取超级要诀()
           elseif 名称=="点化石" then
                  local 生成几率 = 取随机数()
                  if 生成几率<= 5 then
                     参数=取特殊要诀()
                  elseif 生成几率<= 35 and 生成几率>=6 then
                      参数=取高级要诀()
                  else
                      参数=取低级要诀()
                end
            end
        end
           local 给予数量 = 取随机数(数量[1],数量[#数量])
           for i=1,给予数量 do
              self:给予道具(id,名称,1,参数)
           end
      if 玩家数据[id].抽中编号~=nil then
         广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了携带技能为#G/%s#Y/的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,参数,名称),频道="xt"})
      end
    elseif 名称=="鬼谷子"  then
           local 给予数量 = 取随机数(数量[1],数量[#数量])
           for i=1,给予数量 do
              self:给予道具(id,名称,1,参数)
           end
          if 玩家数据[id].抽中编号~=nil then
             广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,参数),频道="xt"})
          end
  elseif 名称=="初级清灵仙露"  or 名称=="中级清灵仙露"  or 名称=="高级清灵仙露" then
           local 给予数量 = 取随机数(数量[1],数量[#数量])
           for i=1,给予数量 do
              self:给予道具(id,名称,1,参数)
           end
	elseif 名称=="元素曜石·冰" or 名称=="元素曜石·风"  or 名称=="元素曜石·火" or 名称=="元素曜石·雷" or 名称=="元素曜石·水" or 名称=="元素曜石·岩"  then
			级别限制 = 数量 or 120
	elseif 名称=="器灵·金蝉" or  名称=="器灵·无双"  then
			local 部位={"衣服","武器","鞋子","头盔","项链","腰带"}
			限制=参数 or 部位[取随机数(1,#部位)]
			级别限制=数量 or 120

   elseif 名称=="宝石" then
          local 宝石名称 = {"红玛瑙","太阳石","舍利子","黑宝石","月亮石","光芒石","星辉石"}
          local 给予名称 = 宝石名称[取随机数(1,#宝石名称)]
          local 给予数量 = 取随机数(数量[1],数量[#数量])
          self:给予道具(id,给予名称,给予数量,参数)
   elseif 名称=="五宝" then
          local 给予名称 = self:取五宝()
          local 给予数量 = 取随机数(数量[1],数量[#数量])
          self:给予道具(id,给予名称,给予数量,参数)
    elseif 名称=="强化石" then
          local 给予名称 = 取强化石()
          local 给予数量 = 取随机数(数量[1],数量[#数量])
          self:给予道具(id,给予名称,给予数量,参数)
    elseif 名称=="九转金丹" then
          local 给予名称 = "九转金丹"
    elseif 名称=="150无级别礼包" then
          local 给予名称 = "150无级别礼包"
    	self:给予道具(id,给予名称,给予数量,参数)
  else
        local 是否广播 =true
        local 给予数量 = 取随机数(数量[1],数量[#数量])
        self:给予道具(id,名称,给予数量,参数)
        if 名称 =="红玛瑙" or  名称 =="太阳石" or  名称 =="舍利子" or  名称 =="黑宝石" or  名称 =="月亮石" or  名称 =="光芒石" or  名称 =="星辉石" then
           if 玩家数据[id].抽中编号~=nil then
             广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/级的#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,给予数量,名称),频道="xt"})
             是否广播 =false
          end
        end
        if 玩家数据[id].抽中编号~=nil and 是否广播 then
            广播消息({内容=format("#S(搏一搏,单车变摩托)#Y/恭喜玩家#R/%s#Y获得了#G/%s#Y/个#G/%s#Y".."#"..取随机数(1,110),玩家数据[id].角色.名称,给予数量,名称),频道="xt"})
        end
  end
  常规提示(id,"#Y你获得了#R"..名称)
end
---助战
--------------------------助战操作开始
function 道具处理类:助战使用道具(连接id,id,主人id,内容)
	local 道具格子=内容.编号
	local 删除数量=1
	local 加血对象=0
	local 道具提示 = true
	local 重要事件=false
	local 道具id=玩家数据[id].角色["道具"][道具格子]
	local 助战编号=内容.助战编号
	if 道具id==nil or self.数据[道具id]==nil then
		玩家数据[id].道具[道具格子]=nil
		玩家数据[id].道具:助战索要道具(连接id,id,助战编号)
		return
	end
	local 名称=self.数据[道具id].名称
	local 道具使用=false
	if 玩家数据[id].坐牢中 or 玩家数据[id].烤火 then
		常规提示(id,"当前不能使用道具")
		return
	end
	if self:取加血道具(名称) then
		道具使用=true
		local 加血数值=self:取加血道具1(名称,道具id)
		local 加魔数值=self:取加魔道具1(名称,道具id)
		local 伤势数值=self:取加血道具2(名称,道具id)
		if 名称=="翡翠豆腐" then
			self:加血处理(连接id,id,加血数值,加血对象)
			self:加魔处理(连接id,id,加魔数值,加血对象)
		else
			self:加血处理(连接id,id,加血数值,加血对象,nil,伤势数值)
		end
	elseif self:取加魔道具(名称) then
		道具使用=true
		local 加血数值=self:取加血道具1(名称,道具id)
		local 加魔数值=self:取加魔道具1(名称,道具id)
		if 名称=="翡翠豆腐" then
			self:加血处理(连接id,id,加血数值,加血对象)
			self:加魔处理(连接id,id,加魔数值,加血对象)
		else
			self:加魔处理(连接id,id,加魔数值,加血对象)
		end
	elseif self:取寿命道具(名称) then
		if 加血对象==0 then
			常规提示(id,"请选择一只召唤兽")
			return
		elseif 玩家数据[id].召唤兽.数据[加血对象].种类 =="神兽" then
			常规提示(id,"神兽无法使用此物品")
			return
		else
			local 加血数值=self:取寿命道具1(名称,道具id)
			玩家数据[id].召唤兽:加寿命处理(加血对象,加血数值.数值,加血数值.中毒,连接id,id)
			道具使用=true
		end
	elseif 右键合成宝石[名称] then
		self:一键合宝石(id,道具id,self.数据[道具id].级别限制,self.数据[道具id].名称)
		return
	elseif 右键合成五宝[名称] then
		self:一键合五宝(id)
		return
	elseif 名称=="特殊兽诀·碎片" then
		if self.数据[道具id].数量<50 then
			常规提示(id,"还是先凑齐50本再打开看看吧。")
			return
		end
		self:删除道具(连接id,id,包裹类型,道具id,道具格子,50)
		local 链接 = {提示=format("#G/%s#P集齐了50本特殊兽诀·碎片，打开一看发现了一本",玩家数据[id].角色.名称),频道="xt",结尾="#28#P！"}
		玩家数据[id].道具:给予超链接道具(id,"高级魔兽要诀",nil,取碎片特殊要诀(),链接)
		发送数据(连接id,3699)
		return
	elseif 名称=="五宝盒" then
		玩家数据[id].道具:给予道具(id,取五宝())
		道具使用=true
	elseif 名称=="新手大礼包" then
	elseif 名称=="坐骑礼包" or 名称=="种族坐骑" then
		玩家数据[id].角色:增加种族坐骑(id)
		道具使用=true
	elseif 名称=="九转金丹礼包" then
		local 道具格子=玩家数据[id].角色:取道具格子2()
		if 道具格子<10 then
			常规提示(id,"您的道具栏物品已经满啦")
			return 0
		end

	----------------================商城lib==================--------------
	elseif 名称=="90无级别礼包" or 名称=="120无级别礼包" or 名称=="130无级别礼包" or 名称=="140无级别礼包" or 名称=="150无级别礼包" or 名称=="160无级别礼包" then
		local fls={}
		fls["90无级别礼包"]=90
		fls["120无级别礼包"]=120
		fls["130无级别礼包"]=130
		fls["140无级别礼包"]=140
		fls["150无级别礼包"]=150
		fls["160无级别礼包"]=160
		重要事件=function()
			礼包奖励类:全套专用装备(id,fls[名称],"无级别限制",id)
		end
		道具使用=true
	elseif 名称=="160无级别全套" then
		local fls={}
		fls["160无级别全套"]=160
		重要事件=function()
			礼包奖励类:全套非专装备(id,fls[名称],"无级别限制")
		end
		道具使用=true
	elseif 名称=="60灵饰礼包" then
		local 专用=self.数据[道具id].专用
		重要事件=function()
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"枫华戒",60,"戒指",专用,专用))
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"翠叶环",60,"耳饰",专用,专用))
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"香木镯",60,"手镯",专用,专用))
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"芝兰佩",60,"佩饰",专用,专用))
		end
		道具使用=true
	elseif 名称=="80灵饰礼包" then
		local 专用=self.数据[道具id].专用
		重要事件=function()
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"芙蓉戒",80,"戒指",专用,专用))
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"明月珰",80,"耳饰",专用,专用))
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"翡玉镯",80,"手镯",专用,专用))
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"逸云佩",80,"佩饰",专用,专用))
		end
		道具使用=true
	elseif 名称=="100灵饰礼包" then
		local 专用=self.数据[道具id].专用
		重要事件=function()
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:商城灵饰处理(id,"金麟绕",100,"戒指",专用,专用))
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:商城灵饰处理(id,"玉蝶翩",100,"耳饰",专用,专用))
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:商城灵饰处理(id,"墨影扣",100,"手镯",专用,专用))
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:商城灵饰处理(id,"莲音玦",100,"佩饰",专用,专用))
		end
		道具使用=true
	elseif 名称=="120灵饰礼包" then
		local 专用=self.数据[道具id].专用
		  重要事件=function()
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:商城灵饰处理(id,"悦碧水",120,"戒指",专用,专用))
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:商城灵饰处理(id,"点星芒",120,"耳饰",专用,专用))
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:商城灵饰处理(id,"花映月",120,"手镯",专用,专用))
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:商城灵饰处理(id,"相思染",120,"佩饰",专用,专用))
		end
		道具使用=true
	elseif 名称=="140灵饰礼包" then
		local 专用=self.数据[道具id].专用
		  重要事件=function()
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"九曜光华",140,"戒指",专用,专用))
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"凤羽流苏",140,"耳饰",专用,专用))
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"金水菩提",140,"手镯",专用,专用))
			玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,玩家数据[id].道具:dz灵饰处理(id,"玄龙苍珀",140,"佩饰",专用,专用))
		end
		道具使用=true

	elseif 名称=="鬼谷子" then
		if 玩家数据[id].角色.阵法[self.数据[道具id].子类]==nil then
			玩家数据[id].角色.阵法[self.数据[道具id].子类]=1
			常规提示(id,"恭喜你学会了如何使用#R/"..self.数据[道具id].子类)
			道具使用=true
		else
			常规提示(id,"你已经学过如何使用这个阵型了，请勿重复学习")
			return
		end
	elseif 名称=="怪物卡片" then
		local 剧情等级=玩家数据[id].角色:取剧情技能等级("变化之术")
		if 剧情等级<6 and self.数据[道具id].等级>剧情等级 then
			常规提示(id,"#Y/你的变化之术等级太低了")
			return
		end
		if 玩家数据[id].角色:取任务(1)~=0 then
			任务数据[玩家数据[id].角色:取任务(1)]=nil
			玩家数据[id].角色:取消任务(1)
		end
		玩家数据[id].角色.变身数据=self.数据[道具id].造型
		道具使用=true
		玩家数据[id].角色:刷新信息()
		发送数据(连接id,37,玩家数据[id].角色.变身数据)
		常规提示(id,"你使用了怪物卡片")
		发送数据(连接id,47,{玩家数据[id].角色:取气血数据()})
		发送数据(玩家数据[id].连接id,12)
		设置任务1(id,剧情等级,玩家数据[id].角色.变身数据)
		地图处理类:更改模型(id,玩家数据[id].角色.变身数据,1)
	elseif 名称=="小象炫卡" or 名称=="腾蛇炫卡" or 名称=="龙马炫卡" or 名称=="雪人炫卡" then
		if 玩家数据[id].角色:取任务(1)~=0 then
			任务数据[玩家数据[id].角色:取任务(1)]=nil
			玩家数据[id].角色:取消任务(1)
		end
		玩家数据[id].角色.变身数据=self.数据[道具id].造型
		道具使用=true
		玩家数据[id].角色:刷新信息()
		发送数据(连接id,37,玩家数据[id].角色.变身数据)
		常规提示(id,"你使用了怪物卡片")
		发送数据(连接id,47,{玩家数据[id].角色:取气血数据()})
		发送数据(玩家数据[id].连接id,12)
		-- 设置任务1(id,剧情等级,玩家数据[id].角色.变身数据)
		设置任务1a(id,剧情等级,玩家数据[id].角色.变身数据)
		地图处理类:更改模型(id,玩家数据[id].角色.变身数据,1)
	elseif 名称=="摄妖香" then  --
		if 玩家数据[id].角色:取任务(9)~=0 then
			玩家数据[id].角色:取消任务(玩家数据[id].角色:取任务(9))
		end
		设置任务9(id)
		常规提示(id,"#Y/你使用了摄妖香")
		道具使用=true
	elseif 名称=="未鉴定的灵犀玉" then
		玩家数据[id].道具:给予道具(id,"灵犀玉")
		道具使用=true
	elseif 名称=="秘制红罗羹" then
		if 玩家数据[id].角色:取任务(10)~=0 then
			local 任务id=玩家数据[id].角色:取任务(10)
			if 任务数据[任务id].气血 == nil then
				任务数据[任务id].气血 = 0
			end
			任务数据[任务id].气血=任务数据[任务id].气血+5000000
			常规提示(id,"#Y/你使用了秘制红罗羹")
			道具使用=true
			玩家数据[id].角色:刷新任务跟踪()
		else
			设置任务10(id,5000000,0,0)
			常规提示(id,"#Y/你使用了秘制红罗羹")
			道具使用=true
		end
	elseif 名称=="秘制绿芦羹" then
		if 玩家数据[id].角色:取任务(10)~=0 then
			local 任务id=玩家数据[id].角色:取任务(10)
			if 任务数据[任务id].魔法 == nil then
				任务数据[任务id].魔法 = 0
			end
			任务数据[任务id].魔法=任务数据[任务id].魔法+500000
			常规提示(id,"#Y/你使用了秘制绿罗羹")
			道具使用=true
			玩家数据[id].角色:刷新任务跟踪()
		else
			设置任务10(id,0,500000,0)
			常规提示(id,"#Y/你使用了秘制绿罗羹")
			道具使用=true
		end
	elseif 名称=="百岁香" then
		if 玩家数据[id].角色.活力+(self.数据[道具id].阶品*2+150) > 玩家数据[id].角色.最大活力 then 常规提示(id,"使用后活力超过了最大数值无法使用") return end
		if 玩家数据[id].角色.体力+(self.数据[道具id].阶品*2+150) > 玩家数据[id].角色.最大体力 then 常规提示(id,"使用后体力超过了最大数值无法使用") return end
		玩家数据[id].角色.活力 = 玩家数据[id].角色.活力+(self.数据[道具id].阶品*2+150)
		玩家数据[id].角色.体力 = 玩家数据[id].角色.体力+(self.数据[道具id].阶品*2+150)
		道具使用=true
	elseif 名称=="九转金丹" then
		if  玩家数据[id].角色.修炼[玩家数据[id].角色.修炼.当前][1] >= 玩家数据[id].角色.修炼[玩家数据[id].角色.修炼.当前][3]  then 常规提示(id,"#Y/你的此项修炼已经达上限") return end
		玩家数据[id].角色:添加人物修炼经验(id,math.floor((self.数据[道具id].阶品 or 1)*0.5))
		道具使用=true
	elseif 名称=="修炼果" then
		if  玩家数据[id].角色.bb修炼[玩家数据[id].角色.bb修炼.当前][1]>= 玩家数据[id].角色.bb修炼[玩家数据[id].角色.bb修炼.当前][3]  then 常规提示(id,"#Y/你的此项修炼已经达上限") return end
		玩家数据[id].角色:添加bb修炼经验(id,150)
		道具使用=true
	elseif 名称=="回梦丹" then
		if 玩家数据[id].角色:取任务(15)~=0 then
			常规提示(id,"#Y/当前已经使用回梦丹了，无法再使用该物品")
			return
		end
		设置任务15(id)
		道具使用=true
	elseif 名称=="海马" then
		玩家数据[id].角色.活力 = 玩家数据[id].角色.活力+150
		玩家数据[id].角色.体力 = 玩家数据[id].角色.体力+150
		if 玩家数据[id].角色.活力 > 玩家数据[id].角色.最大活力 then
			玩家数据[id].角色.活力=玩家数据[id].角色.最大活力
		end
		if 玩家数据[id].角色.体力 > 玩家数据[id].角色.最大体力 then
			玩家数据[id].角色.体力=玩家数据[id].角色.最大体力
		end
		体活刷新(id)
		道具使用=true
	elseif self.数据[道具id].总类 == 144 then --冒泡框
		玩家数据[id].角色.发言特效 = self.数据[道具id].分类
		道具使用=true
		常规提示(id,"使用成功！")
	elseif 名称=="炫彩ID" then
		玩家数据[id].角色.id特效 = self.数据[道具id].特效  --3
		道具使用=true
		常规提示(id,"使用成功！")
	elseif 名称 == "队标特效" then
		local tx = {"桃心","风车","彩虹","扇子","小猪","音符","火苗","草莓","兔子","蝴蝶","海星","葫芦","螃蟹","狮王","绿叶","红伞","猫头"}
		玩家数据[id].角色.队标特效 = tx[取随机数(1,#tx)]
		常规提示(id,"你获得#G"..玩家数据[id].角色.队标特效.."#Y队标……")
		地图处理类:更改队伍样式(id,玩家数据[id].角色.队标特效)
		道具使用=true
	elseif self.数据[道具id].名称 == "九霄清心丸" then
		设置任务241(id)
		道具使用=true
	elseif self.数据[道具id].名称 == "天机培元丹" then
		if not 初始活动.昆仑仙境[id] then
			初始活动.昆仑仙境[id]={次数=0,最大次数=60,时间=os.time() + 180}
		end
		初始活动.昆仑仙境[id].最大次数=初始活动.昆仑仙境[id].最大次数+20
		常规提示(id,"你的昆仑仙境今日修行次数增加了20次，当前剩余"..初始活动.昆仑仙境[id].最大次数.."次")
		道具使用=true
	end
	if 道具使用 then
		self:删除道具(连接id,id,"道具",道具id,道具格子,删除数量)
		if 重要事件 then
			重要事件()
		end
		玩家数据[id].道具:助战索要道具(连接id,id,助战编号)
		常规提示(id,"#G使用成功")
	else
		if 道具提示 then
			常规提示(id,"无法使用这样的道具")
		end
	end
end
function 道具处理类:助战卸下装备(连接id,id,主人id,数据)
	-- local 道具格子=玩家数据[id].角色:取道具格子(数据.类型)
	数据.类型="道具"
	local 道具格子=玩家数据[id].角色:取道具格子(数据.类型)
	if 道具格子==0 then
		常规提示(主人id,"该助战道具栏物品已经满啦")
		return 0
	end
	if 数据.灵饰 then
		self:卸下助战灵饰(连接id,id,道具id,道具格子,数据)
		return
	end
	if 数据.锦衣 then
		self:卸下助战锦衣(连接id,id,道具id,道具格子,数据)
		return
	end

	local 道具id=玩家数据[id].角色.装备[数据.道具]
	玩家数据[id].角色:卸下装备(self.数据[道具id],self.数据[道具id].分类)
	玩家数据[id].角色.装备[数据.道具]=nil
	玩家数据[id].角色[数据.类型][道具格子]=道具id
	玩家数据[id].角色:刷新信息()
	self:助战索要道具(连接id,id,数据.助战编号)
	-- 发送数据(连接id,2009,玩家数据[id].角色:取装备数据())
	if 数据.道具==3 then
		地图处理类:更新武器(id)
	end
end
function 道具处理类:佩戴助战灵饰(连接id,id,主人id,道具id,数据)
	if 玩家数据[id].角色.等级<60 then
		常规提示(主人id,"#Y小于60级无法佩戴灵饰")
		return
	end
	local 物品=取物品数据(self.数据[道具id].名称)
	local 级别=物品[5]
	if 级别>玩家数据[id].角色.等级 then
		if self.数据[道具id].特效 =="无级别限制" then
		elseif  self.数据[道具id].特效 =="无级别限制" and 级别<=玩家数据[id].角色.等级+25 then
		else
			常规提示(主人id,"#Y助战当前的等级不足以佩戴这样的灵饰")
			return
		end
	end
	if not self.数据[道具id].鉴定 then
		常规提示(主人id,"#Y没有鉴定的灵饰无法佩戴")
		return
	end
	if self.数据[道具id].专用 and  self.数据[道具id].专用~=id then
		常规提示(主人id,"#Y这个灵饰id与助战不匹配无法穿戴")
		return
	end

	if 玩家数据[id].角色.灵饰[self.数据[道具id].子类]==nil then
		玩家数据[id].角色.灵饰[self.数据[道具id].子类]=道具id
		玩家数据[id].角色:佩戴灵饰(self.数据[道具id])
		玩家数据[id].角色[数据.类型][数据.道具]=nil
	else
		local 道具id1=玩家数据[id].角色.灵饰[self.数据[道具id].子类]
		玩家数据[id].角色:卸下灵饰(self.数据[道具id1])
		玩家数据[id].角色.灵饰[self.数据[道具id].子类]=道具id
		玩家数据[id].角色:佩戴灵饰(self.数据[道具id])
		玩家数据[id].角色[数据.类型][数据.道具]=道具id1
	end
	self:助战索要道具(连接id,id,数据.助战编号)
end
function 道具处理类:卸下助战灵饰(连接id,id,道具id,道具格子,数据)
	玩家数据[id].角色:卸下灵饰(self.数据[玩家数据[id].角色.灵饰[数据.道具]])
	玩家数据[id].角色[数据.类型][道具格子]=玩家数据[id].角色.灵饰[数据.道具]
	玩家数据[id].角色.灵饰[数据.道具]=nil
	self:助战索要道具(连接id,id,数据.助战编号)
	-- 发送数据(连接id,2010,玩家数据[id].角色:取灵饰数据())
end
function 道具处理类:卸下助战锦衣(连接id,id,道具id,道具格子,数据)
	玩家数据[id].角色[数据.类型][道具格子]=玩家数据[id].角色.锦衣[数据.道具]
	玩家数据[id].角色.锦衣[数据.道具]=nil
	self:助战索要道具(连接id,id,数据.助战编号)
	-- 发送数据(连接id,2011,玩家数据[id].角色:取锦衣数据())
	地图处理类:更新锦衣(id,nil,数据.道具)
end
function 道具处理类:佩戴助战锦衣(连接id,id,主人id,道具id,数据)
	 local 物品=取物品数据(self.数据[道具id].名称)
	-- if 玩家数据[id].角色.性别 ~= 物品[6] and 物品[4] == 1 then
	-- 	常规提示(id,"#Y你无法穿戴这个性别的锦衣套装")
	-- 	return
	-- end
	if 玩家数据[id].角色.锦衣[self.数据[道具id].子类]==nil then
		玩家数据[id].角色.锦衣[self.数据[道具id].子类]=道具id
		玩家数据[id].角色[数据.类型][数据.道具]=nil
	else
		local 道具id1=玩家数据[id].角色.锦衣[self.数据[道具id].子类]
		玩家数据[id].角色.锦衣[self.数据[道具id].子类]=道具id
		玩家数据[id].角色[数据.类型][数据.道具]=道具id1
	end
	self:助战索要道具(连接id,id,数据.助战编号)
	地图处理类:更新锦衣(id,玩家数据[id].道具.数据[玩家数据[id].角色.锦衣[self.数据[道具id].子类 ]].名称,self.数据[道具id].子类 )
end
function 道具处理类:助战穿戴装备(连接id,id,主人id,数据)
	数据.类型="道具"
	local 道具id=玩家数据[id].角色[数据.类型][数据.道具]
	if self.数据[道具id] == nil then
		return
	end
	if self.数据[道具id].总类 == 2 and self.数据[道具id].灵饰~=nil then
		self:佩戴助战灵饰(连接id,id,主人id,道具id,数据)
		return
	end
	if self.数据[道具id].总类 == 2 and self.数据[道具id].分类 >=14 and self.数据[道具id].分类 <=19 then
		self:佩戴助战锦衣(连接id,id,主人id,道具id,数据)
		return
	end
	local 装备条件=self:可装备(self.数据[道具id],self.数据[道具id].分类,数据.角色,id)
	if 装备条件~=true and 装备条件~=false then
		发送数据(连接id,7,装备条件)
		return 0
	else
		if 玩家数据[id].角色.装备[self.数据[道具id].分类]~=nil then --检查是否有装备已经佩戴
			local 道具id1=玩家数据[id].角色.装备[self.数据[道具id].分类]
			玩家数据[id].角色:卸下装备(self.数据[道具id1],self.数据[道具id1].分类)
			玩家数据[id].角色.装备[self.数据[道具id].分类]= 道具id
			玩家数据[id].角色:穿戴装备(self.数据[道具id],self.数据[道具id].分类)
			玩家数据[id].角色[数据.类型][数据.道具]=道具id1
		else
			玩家数据[id].角色.装备[self.数据[道具id].分类]= 道具id
			玩家数据[id].角色:穿戴装备(self.数据[道具id],self.数据[道具id].分类)
			玩家数据[id].角色[数据.类型][数据.道具]=nil
		end
		玩家数据[id].角色:检查临时属性()
	end
	self:助战索要道具(连接id,id,数据.助战编号)
	-- 发送数据(连接id,2009,玩家数据[id].角色:取装备数据())
	发送数据(连接id, 2007, 玩家数据[id].角色:取总数据1())
	if self.数据[道具id].分类==3 then
		地图处理类:更新武器(id,self.数据[玩家数据[id].角色.装备[3]])
	end
end
function 道具处理类:助战索要道具(连接id,id,助战编号)
	self.发送数据={道具={}}
	for n=1,道具总数量 do
		if 玩家数据[id].角色.道具[n]~=nil then
			if self.数据[玩家数据[id].角色.道具[n]]==nil then
				玩家数据[id].角色.道具[n]=nil
			else
				self.发送数据.道具[n]=table.loadstring(table.tostring(self.数据[玩家数据[id].角色.道具[n]]))
			end
		end
	end
	self.发送数据.助战信息={助战编号=助战编号,id=id,模型=玩家数据[id].角色.模型,门派=玩家数据[id].角色.门派}
	self.发送数据.装备 = 玩家数据[id].角色:取装备数据()
	self.发送数据.灵饰 = 玩家数据[id].角色:取灵饰数据()
	self.发送数据.锦衣 = 玩家数据[id].角色:取锦衣数据()
	发送数据(连接id,2012,self.发送数据)
end
--------------------------助战操作结束
function 道具处理类:给予伙伴道具(id,名称,数量,参数,附加,专用,数据,消费,消费方式,消费内容,超链接,hbname)
	local 识别码=id.."_"..os.time().."_"..取随机数(1000,9999).."_"..随机序列
	随机序列=随机序列+1
	local 临时道具
	local Linshiwuping
	local 原始数量 = 数量
	if 原始数量 == nil then
		原始数量 = 1
	end
	if 数据 == nil then
		if 名称 == "超级净瓶玉露" or 名称 == "净瓶玉露"or 名称 == "超级金柳露" or 名称 == "金柳露" or 名称=="易经丹" or 名称=="金钥匙" or 名称=="银钥匙" or 名称=="铜钥匙" then
			if 数量 == nil then
				数量 = 1
			end
		end
		local 灵性
		if 名称=="初级清灵仙露" then
			灵性 = 取随机数(1,4)
			if 数量 == nil then
				数量 = 1
			end
		elseif 名称=="中级清灵仙露" then
			灵性 = 取随机数(2,6)
			if 数量 == nil then
				数量 = 1
			end
		elseif 名称=="高级清灵仙露" then
			灵性 = 取随机数(4,8)
			if 数量 == nil then
				数量 = 1
			end
		elseif 名称=="高级摄灵珠" then
			if 参数 then
				灵性=参数
			else
				灵性 = 4
			end

			if 数量 == nil then
				数量 = 1
			end
		elseif 名称=="如意丹" then
			灵性=取五行()
		end
		Linshiwuping=物品类()
		Linshiwuping:置对象(名称)
		临时道具 = 取物品数据(名称)
		临时道具.总类=临时道具[2]
		临时道具.子类=临时道具[4]
		临时道具.分类=临时道具[3]

		if kediejia[名称] then
			if 数量==nil then
				数量=1
			end
			Linshiwuping.可叠加 = true
		elseif 名称=="鬼谷子" then
			local 阵法名称={
				[3]="普通",
				[4]="风扬阵",
				[5]="虎翼阵",
				[6]="天覆阵",
				[7]="云垂阵",
				[8]="鸟翔阵",
				[9]="地载阵",
				[10]="龙飞阵",
				[11]="蛇蟠阵",
				[12]="鹰啸阵",
				[13]="雷绝阵",
			}
			local go=false
			if 参数 then
				for i=4,13 do
					if 阵法名称[i]==参数 then
						Linshiwuping.子类=参数
						go=true
						break
					end
				end
			end
			if not go then
			   Linshiwuping.子类 = 阵法名称[取随机数(4,13)]
			end
			-- Linshiwuping.子类 = 参数 or 阵法名称[取随机数(4,13)]
			-- elseif 名称=="新春翻一番" then
			-- 	Linshiwuping.子类 = 数量
			-- 	Linshiwuping.特效 = 参数
		elseif 名称=="初级清灵仙露" or 名称=="中级清灵仙露" or 名称=="高级清灵仙露" or 名称=="高级摄灵珠" then
			Linshiwuping.灵气=灵性
			Linshiwuping.可叠加 = false
		elseif 名称=="特殊清灵仙露"	then
			Linshiwuping.灵气=110
			Linshiwuping.可叠加 = false
		elseif 名称=="灵兜兜" then
			Linshiwuping.可叠加 = false
		elseif 名称=="镇妖拘魂铃" then
			Linshiwuping.可叠加 = true
			Linshiwuping.不可交易 = true
		elseif  名称=="新手大礼包" or 名称=="秘宝宝箱" or 名称=="机缘宝箱" then
			Linshiwuping.可叠加 = false
			Linshiwuping.不可交易 = true
		elseif 名称=="新春飞行符" then
			Linshiwuping.可叠加 = false
			Linshiwuping.次数=100
		-- elseif 名称=="自动抓鬼卡" or  名称=="月卡" then
		-- 	Linshiwuping.可叠加 = false
		-- 	Linshiwuping.不可交易 = true
		elseif 名称=="炫彩ID" then
			local sdsd={"绿色ID","蓝色ID","紫色ID","黄金ID"}   --4
			if  数量 and type(数量)~= "number" then
				 Linshiwuping.特效=数量
			else
				local sdsd={"绿色ID","蓝色ID","紫色ID","黄金ID"}
				 Linshiwuping.特效=sdsd[取随机数(1,#sdsd)]
			end
		elseif 名称=="未激活的符石" then
			local 级别 = 数量 or 1
			Linshiwuping.子类 = 级别
			if 参数==nil then
				if 级别 == 1 then
					Linshiwuping.符石名称 = 一级符石[取随机数(1,#一级符石)]
				elseif 级别==2 then
					Linshiwuping.符石名称 = 二级符石[取随机数(1,#二级符石)]
				elseif 级别==3 then
					Linshiwuping.符石名称 = 三级符石[取随机数(1,#三级符石)]
				else
					Linshiwuping.子类 = 1
					Linshiwuping.符石名称 = 一级符石[取随机数(1,#一级符石)]
				end
				local lssj = 取物品数据(Linshiwuping.符石名称)
				Linshiwuping.符石属性 = lssj[21]
				Linshiwuping.颜色 = lssj[20]
			else
				local lssj = 取物品数据(参数)
				Linshiwuping.符石属性 = lssj[21]
				if Linshiwuping.符石属性~=nil then
					Linshiwuping.符石名称 = 参数
					Linshiwuping.子类 = lssj[4]
					Linshiwuping.颜色 = lssj[20]
				else
					Linshiwuping.符石名称 = 一级符石[取随机数(1,#一级符石)]
					local lssj = 取物品数据(Linshiwuping.符石名称)
					Linshiwuping.符石属性 = lssj[21]
					Linshiwuping.子类 = lssj[4]
					Linshiwuping.颜色 = lssj[20]
				end
			end
		elseif 名称=="未激活的星石" then
			if 参数==nil then
				Linshiwuping.子类 = 取随机数(1,6)
			else
				if 参数 == "头盔" then
					Linshiwuping.子类 = 1
				elseif 参数 == "饰物" then
					Linshiwuping.子类 = 2
				elseif 参数 == "武器" then
					Linshiwuping.子类 = 3
				elseif 参数 == "衣甲" then
					Linshiwuping.子类 = 4
				elseif 参数 == "腰带" then
					Linshiwuping.子类 = 5
				elseif 参数 == "靴子" then
					Linshiwuping.子类 = 6
				else
					Linshiwuping.子类 = 取随机数(1,6)
				end
			end
		elseif 名称=="灵犀玉" then
			if 参数==nil then
				if 取随机数() <=90 then
					Linshiwuping.子类 = 取随机数(1,2)
				else
					Linshiwuping.子类 = 取随机数(2,3)
				end
				Linshiwuping.特性 = 取灵犀玉特性()
			else
				Linshiwuping.子类 = 3
				Linshiwuping.特性 = 取礼包灵犀玉特性()
			end

		elseif 名称=="神兵图鉴" or 名称=="灵宝图鉴" or 名称=="灵饰图鉴" then
			Linshiwuping.子类 = 数量
		elseif 名称=="阎罗免死牌" then
			Linshiwuping.次数 = 3
			Linshiwuping.限时 = os.time()+86400
		elseif 名称=="制造指南书" then
			if 参数==nil then
				Linshiwuping.子类=数量[取随机数(1,#数量)]*10
				Linshiwuping.特效=取随机数(1,#书铁范围)
				if 取随机数()<=40 then
					Linshiwuping.特效=取随机数(19,#书铁范围)
				end
			else
				Linshiwuping.子类=数量
				Linshiwuping.特效=参数
			end
		elseif 名称=="灵饰指南书" then
			-- Linshiwuping.子类=数量[取随机数(1,#数量)]*10
			if 数量 then
				Linshiwuping.子类=数量[取随机数(1,#数量)]*10
			else
				local lv = 玩家数据[id].角色.等级
				local fanwei={6,8}
				if lv>=80 and lv<100 then
					fanwei={8,10}
				elseif lv>=100 and lv<120 then
					fanwei={10,12}
				elseif lv>=120 then
					fanwei={10,12,14}
				end
				Linshiwuping.子类=fanwei[取随机数(1,#fanwei)]*10
			end
			if 参数 then
				Linshiwuping.特效=参数
			else
				Linshiwuping.特效=随机灵饰[取随机数(1,#随机灵饰)]
			end

		elseif 名称=="元灵晶石" then
			if 数量 then
				Linshiwuping.子类=数量[取随机数(1,#数量)]*10
			else
				local lv = 玩家数据[id].角色.等级
				local fanwei={6,8}
				if lv>=80 and lv<100 then
					fanwei={8,10}
				elseif lv>=100 and lv<120 then
					fanwei={10,12}
				elseif lv>=120 then
					fanwei={10,12,14}
				end
				Linshiwuping.子类=fanwei[取随机数(1,#fanwei)]*10
			end
			-- Linshiwuping.子类=数量[取随机数(1,#数量)]*10
		elseif 名称=="百炼精铁" then
			Linshiwuping.子类=数量
		elseif 名称=="精魄灵石" then
			local sj = 取随机数(1,6)
			local 类型={"速度","躲避","伤害","灵力","防御","气血"}
			Linshiwuping.子类=sj --红黄蓝
			Linshiwuping.级别限制=数量 or 1
			Linshiwuping.特效=类型[sj]
			Linshiwuping.可叠加=false
		elseif 名称=="钨金" then
			Linshiwuping.可叠加=true
			if 数量==nil then
				数量=1
			else
				数量=数量+0
			end
			if 参数~=nil then
				Linshiwuping.级别限制=参数 or 160
			else
				Linshiwuping.级别限制=Linshiwuping.级别限制 or 160
			end
				Linshiwuping.级别限制=160


			-- if RpbARGB~=1 and Linshiwuping.级别限制>书铁_等级上限 then
			--  Linshiwuping.级别限制=书铁_等级上限
			-- end
		elseif 名称=="珍珠"  then
			Linshiwuping.可叠加=false
			if 数量~=nil then
				Linshiwuping.级别限制=数量
			else
				Linshiwuping.级别限制=Linshiwuping.级别限制 or 160
			end
		elseif 名称=="附魔宝珠"  then
			Linshiwuping.可叠加=true
			if 数量~=nil then
				数量=数量+0
				Linshiwuping.级别限制=Linshiwuping.级别限制 or 160
			else
				数量=1
				Linshiwuping.级别限制=Linshiwuping.级别限制 or 160
			end





			-- if RpbARGB~=1 and Linshiwuping.级别限制>书铁_等级上限 then
			--  Linshiwuping.级别限制=书铁_等级上限
			-- end
		elseif 名称=="召唤兽内丹" then
			Linshiwuping.特效=参数 or 取内丹("低级")
		elseif 名称=="高级召唤兽内丹" then
			Linshiwuping.特效=参数 or 取内丹("高级")
		elseif 名称=="魔兽要诀" then
			if 参数==nil then
				Linshiwuping.附带技能=取低级要诀()
			else
				Linshiwuping.附带技能=参数
			end
		elseif 名称=="高级魔兽要诀" then
			if 参数==nil then
				Linshiwuping.附带技能=取高级要诀()
			else
				Linshiwuping.附带技能=参数
			end
		elseif 名称=="超级魔兽要诀" then
			if 参数==nil then
				Linshiwuping.附带技能=取超级要诀[取随机数(1,#取超级要诀)]
			else
				Linshiwuping.附带技能=参数
			end
		elseif 名称=="特殊兽诀" then
			if 参数==nil then
				Linshiwuping.附带技能=取特殊要诀()
			else
				Linshiwuping.附带技能=参数
			end
			Linshiwuping.名称="特殊魔兽要诀"
		elseif 名称=="招魂帖" then
			local 随机地图={1208,1040,1501,1070,1040,1226,1092}
			local 临时地图=随机地图[取随机数(1,#随机地图)]
			Linshiwuping.地图名称=取地图名称(临时地图)
			Linshiwuping.地图编号=临时地图
			local xy=地图处理类.地图坐标[临时地图]:取随机点()
			Linshiwuping.x=xy.x
			Linshiwuping.y=xy.y
			降妖伏魔:招魂帖(id,Linshiwuping.地图编号,Linshiwuping.x,Linshiwuping.y)
		elseif 名称=="逐妖蛊虫" then
			local 随机地图={1208,1040,1501,1070,1040,1226,1092}
			local 临时地图=随机地图[取随机数(1,#随机地图)]
			Linshiwuping.地图名称=取地图名称(临时地图)
			Linshiwuping.地图编号=临时地图
			local xy=地图处理类.地图坐标[临时地图]:取随机点()
			Linshiwuping.x=xy.x
			Linshiwuping.y=xy.y
			降妖伏魔:逐妖蛊虫(id,Linshiwuping.地图编号,Linshiwuping.x,Linshiwuping.y)
		elseif 名称=="点化石" then
			Linshiwuping.附带技能=数量 or "感知"
		elseif  名称=="九转金丹" then
			Linshiwuping.阶品=数量
			Linshiwuping.可叠加 = true
		elseif 名称=="月华露" then
			Linshiwuping.阶品= 数量 or 500
			Linshiwuping.可叠加 = true
		-- elseif 名称=="五味露" then
		-- 	Linshiwuping.阶品=数量 or 500
		-- 	Linshiwuping.可叠加 = false
		elseif 名称=="藏宝图" or 名称=="高级藏宝图" or 名称=="玲珑宝图" then
			local 随机地图={1501,1506,1092,1091,1110,1142,1514,1174,1173,1146,1208}
			local 临时地图=随机地图[取随机数(1,#随机地图)]
			Linshiwuping.地图名称=取地图名称(临时地图)
			Linshiwuping.地图编号=临时地图
			local xy=地图处理类.地图坐标[临时地图]:取随机点()
			Linshiwuping.x=xy.x
			Linshiwuping.y=xy.y
		elseif 名称=="上古锻造图策" then
			if 数量 then
				Linshiwuping.级别限制=数量[取随机数(1,#数量)]*10-5
			elseif  参数 then
				Linshiwuping.级别限制=参数+0
			else
				local 等级=玩家数据[id].角色.等级
				local lv = math.min(qz(等级/10),13)
				local nm={lv+1,lv+2}
				Linshiwuping.级别限制=nm[取随机数(1,#nm)]*10-5
			end
			-- Linshiwuping.级别限制=数量[取随机数(1,#数量)]*10-5
			Linshiwuping.种类=图策范围[取随机数(1,#图策范围)]
		elseif 名称=="炼妖石" then
			if 数量 then
				Linshiwuping.级别限制=数量[取随机数(1,#数量)]*10-5
			elseif  参数 then
				Linshiwuping.级别限制=参数+0
			else
				local 等级=玩家数据[id].角色.等级
				local lv = math.min(qz(等级/10),13)
				local nm={lv+1,lv+2}
				Linshiwuping.级别限制=nm[取随机数(1,#nm)]*10-5
			end
			-- Linshiwuping.级别限制=数量[取随机数(1,#数量)]*10-5
			Linshiwuping.分类=3
		elseif 名称=="怪物卡片" then
			if 变身卡数据[数量]==nil then
				Linshiwuping.等级=数量
				Linshiwuping.造型=变身卡范围[数量][取随机数(1,#变身卡范围[数量])]
			else
				Linshiwuping.等级=变身卡数据[数量].等级
				Linshiwuping.造型=数量
			end
			Linshiwuping.类型=变身卡数据[Linshiwuping.造型].类型
			Linshiwuping.单独=变身卡数据[Linshiwuping.造型].单独
			Linshiwuping.正负=变身卡数据[Linshiwuping.造型].正负
			Linshiwuping.技能=变身卡数据[Linshiwuping.造型].技能
			Linshiwuping.属性=变身卡数据[Linshiwuping.造型].属性
			Linshiwuping.次数=Linshiwuping.等级
		elseif 名称=="如意丹" then
			Linshiwuping.灵气 = 灵性
			Linshiwuping.可叠加 = true
		-- elseif 名称=="龙之筋" then
		-- 	Linshiwuping.五行 = 取五行()
		-- elseif 名称=="天蚕丝" then
		-- 	Linshiwuping.五行 = "金"
		-- elseif 名称=="阴沉木" then
		-- 	Linshiwuping.五行 = "木"
		-- elseif 名称=="玄龟板" then
		-- 	Linshiwuping.五行 = 取五行()
		-- elseif 名称=="麒麟血" then
		-- 	Linshiwuping.五行 = 取五行()
		-- elseif 名称=="补天石" then
		-- 	Linshiwuping.五行 = 取五行()
		-- elseif 名称=="金凤羽" then
		-- 	Linshiwuping.五行 =取五行()
		-- elseif 名称=="内丹" then
		-- 	Linshiwuping.五行 =取五行()
		-- elseif 名称 == "秘制食谱" then
		-- 	Linshiwuping.子类 =参数
		elseif 名称 == "祈愿宝箱" then
			Linshiwuping.次数 =数量
		elseif 临时道具.总类==3 and  临时道具.分类==11 then  --{"天眼珠","三眼天珠","九眼天珠"}
			Linshiwuping.灵气=取随机数(10,100)
			Linshiwuping.级别限制 = 数量
		elseif 临时道具.总类==5 and  临时道具.分类==4 then
			if 数量 == nil then
				Linshiwuping.级别限制=1
			else
				Linshiwuping.级别限制=数量+0
			end
		elseif 临时道具.总类==5 and  临时道具.分类==6 then --宝石
			if 数量 == nil then
				Linshiwuping.级别限制=1
			else
				Linshiwuping.级别限制=数量+0
			end
		elseif 临时道具.总类==1 and 临时道具.子类==1 and 临时道具.分类==4 then
			Linshiwuping.阶品=参数
		elseif  名称=="红雪散" or 名称=="小还丹"  or 名称=="千年保心丹" or 名称=="金香玉" or 名称=="风水混元丹" or 名称=="蛇蝎美人" or 名称=="定神香" or 名称=="佛光舍利子" or 名称=="九转回魂丹" or 名称=="五龙丹" or 名称=="十香返生丸"  then
			Linshiwuping.阶品=参数 or 取随机数(30,50)
			Linshiwuping.可叠加=false
		elseif 名称=="醉仙果" or 名称=="七珍丸" or 名称=="凝气丸"  or 名称=="舒筋活络丸" or 名称=="固本培元丹" or 名称=="九转续命丹" or 名称=="十全大补丸"  then
			Linshiwuping.阶品=参数 or 取随机数(160,180)
			Linshiwuping.可叠加=false
		end

		if Linshiwuping.名称 then
			if Linshiwuping.可叠加 then
				if 数量 == nil then --测试？
					Linshiwuping.数量=1
					消息提示(id,"#Y/【助战仓库】：#P"..hbname.."#Y获得了#G"..Linshiwuping.名称)
				else
					Linshiwuping.数量=数量 or 1
					消息提示(id,"#Y/【助战仓库】：#P"..hbname.."#Y获得了"..原始数量.."个#G"..Linshiwuping.名称)
				end
			else
				消息提示(id,"#Y/【助战仓库】：#P"..hbname.."#Y获得了#G"..Linshiwuping.名称)
			end
		end

		Linshiwuping.识别码=识别码
		if  Linshiwuping.名称=="心魔宝珠" then
			Linshiwuping.专用=id
			Linshiwuping.不可交易=true
		end
		if 专用~=nil then
			Linshiwuping.专用=id
			Linshiwuping.不可交易=true
		end
	else
		Linshiwuping= 数据
		Linshiwuping.识别码=识别码
		if Linshiwuping.名称 then
			if 数量 ~= nil then
				Linshiwuping.数量 = 数量
				消息提示(id,"#Y/【助战仓库】：#P"..hbname.."#Y获得了"..原始数量.."#Y个#G"..Linshiwuping.名称)
			else
				消息提示(id,"#Y/【助战仓库】：#P"..hbname.."#Y获得了#G"..Linshiwuping.名称)
			end
		end
	end

	if 超链接 and Linshiwuping and  超链接.提示 and  Linshiwuping.名称 and  Linshiwuping.识别码 and  超链接.结尾 then
		local qianzhui="【"..玩家数据[id].角色.名称.."】"
		local 文本 =qianzhui..超链接.提示.."#G/ht|"..Linshiwuping.名称.."*"..Linshiwuping.识别码.."*道具/["..Linshiwuping.名称.."]#W"..超链接.结尾
		local 返回信息 = {}
		返回信息[#返回信息+1] = table.copy(Linshiwuping)
		返回信息[#返回信息].索引类型 = "道具"
		广播消息({内容=文本,频道=超链接.频道,方式=1,超链接=返回信息})
	end

	共享背包数据[id]:添加道具(id,Linshiwuping)
	Linshiwuping=nil
	return true
end

function 道具处理类:索要空道具4(连接id,id)
	self.发送数据={道具={}}
	self.发送数据.银子=玩家数据[id].角色.银子
	self.发送数据.储备=玩家数据[id].角色.储备
	self.发送数据.存银=玩家数据[id].角色.存银
	self.发送数据.仙玉=f函数.读配置(程序目录..[[data\]]..玩家数据[id].账号..[[\账号信息.txt]], "账号配置", "仙玉") + 0
	-- self.发送数据.仙玉=玩家数据[id].角色.仙玉
	发送数据(连接id,200,self.发送数据)
end

function 道具处理类:精炼数据获取(id)
    self.发送信息={}
    self.发送信息.所需数量={}
    self.发送信息.需要祝福={}
    self.发送信息.祝福值={}
    self.发送信息.低级祝福={}
    self.发送信息.中级祝福={}
    self.发送信息.高级祝福={}
    self.发送信息.低级成功率={}
    self.发送信息.中级成功率={}
    self.发送信息.高级成功率={}
    self.发送信息.精炼等级={}
    self.发送信息.精炼数值={}


       for n=1,6 do
         if 玩家数据[id].角色.装备[n]~=nil and self.数据[玩家数据[id].角色.装备[n]]~=nil then
             self.发送信息[n]=玩家数据[id].道具.数据[玩家数据[id].角色.装备[n]]
             if 玩家数据[id].角色.精炼等级 == nil then
               玩家数据[id].角色.精炼等级 = {[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0}
             end
             if 玩家数据[id].角色.祝福值 == nil then
                玩家数据[id].角色.祝福值 = 0
             end
             self.发送信息.所需数量[n] = self:取精炼所需数量(玩家数据[id].角色.精炼等级[n])
             self.发送信息.需要祝福[n] = self:取所需祝福值(玩家数据[id].角色.精炼等级[n])
             self.发送信息.祝福值 = 玩家数据[id].角色.祝福值
             self.发送信息.低级祝福[n] = self:取低级祝福(玩家数据[id].角色.精炼等级[n])
             self.发送信息.中级祝福[n] = self:取中级祝福(玩家数据[id].角色.精炼等级[n])
             self.发送信息.高级祝福[n] = self:取高级祝福(玩家数据[id].角色.精炼等级[n])
             self.发送信息.低级成功率[n] = self:取低级成功率(玩家数据[id].角色.精炼等级[n])
             self.发送信息.中级成功率[n] = self:取中级成功率(玩家数据[id].角色.精炼等级[n])
             self.发送信息.高级成功率[n] = self:取高级成功率(玩家数据[id].角色.精炼等级[n])
             self.发送信息.精炼等级[n] = 玩家数据[id].角色.精炼等级[n]
         end
       end
       self.发送信息.低级精炼 = 0
       self.发送信息.中级精炼 = 0
       self.发送信息.高级精炼 = 0
      发送数据(玩家数据[id].连接id,3699)
      发送数据(玩家数据[id].连接id,3006,"66")
      发送数据(玩家数据[id].连接id,155,self.发送信息)
end

function 道具处理类:获取套装数据(id)
    self.发送信息={}
    if 玩家数据[id].角色.精炼等级 == nil then
       玩家数据[id].角色.精炼等级 = {[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0}
    end
    self.发送信息.套装等级 = 0
    self.发送信息.气血上限 = 0
    self.发送信息.魔法上限 = 0
    self.发送信息.物理攻击 = 0
    self.发送信息.灵力 = 0
    self.发送信息.速度 = 0
    if 玩家数据[id].角色.精炼等级[2] >= 40 and 玩家数据[id].角色.精炼等级[2] >= 40 and 玩家数据[id].角色.精炼等级[3] >= 40 and 玩家数据[id].角色.精炼等级[4] >= 40
         and 玩家数据[id].角色.精炼等级[5] >= 40 and 玩家数据[id].角色.精炼等级[6] >= 40 then
            self.发送信息.套装等级 = 40
            self.发送信息.气血上限 = 10
            self.发送信息.魔法上限 = 10
            self.发送信息.物理攻击 = 10
            self.发送信息.灵力 = 10
            self.发送信息.速度 = 10
    elseif 玩家数据[id].角色.精炼等级[1] >= 36 and 玩家数据[id].角色.精炼等级[2] >= 36 and 玩家数据[id].角色.精炼等级[3] >= 36 and 玩家数据[id].角色.精炼等级[4] >= 36
         and 玩家数据[id].角色.精炼等级[5] >= 36 and 玩家数据[id].角色.精炼等级[6] >= 36 then
            self.发送信息.套装等级 = 36
            self.发送信息.气血上限 = 9
            self.发送信息.魔法上限 = 9
            self.发送信息.物理攻击 = 9
            self.发送信息.灵力 = 9
            self.发送信息.速度 = 9
    elseif 玩家数据[id].角色.精炼等级[1] >= 32 and 玩家数据[id].角色.精炼等级[2] >= 32 and 玩家数据[id].角色.精炼等级[3] >= 32 and 玩家数据[id].角色.精炼等级[4] >= 32
         and 玩家数据[id].角色.精炼等级[5] >= 32 and 玩家数据[id].角色.精炼等级[6] >= 32 then
            self.发送信息.套装等级 = 32
            self.发送信息.气血上限 = 8
            self.发送信息.魔法上限 = 8
            self.发送信息.物理攻击 = 8
            self.发送信息.灵力 = 8
            self.发送信息.速度 = 8
    elseif 玩家数据[id].角色.精炼等级[1] >= 28 and 玩家数据[id].角色.精炼等级[2] >= 28 and 玩家数据[id].角色.精炼等级[3] >= 28 and 玩家数据[id].角色.精炼等级[4] >= 28
         and 玩家数据[id].角色.精炼等级[5] >= 28 and 玩家数据[id].角色.精炼等级[6] >= 28 then
            self.发送信息.套装等级 = 28
            self.发送信息.气血上限 = 7
            self.发送信息.魔法上限 = 7
            self.发送信息.物理攻击 = 7
            self.发送信息.灵力 = 7
            self.发送信息.速度 = 7
    elseif 玩家数据[id].角色.精炼等级[1] >= 24 and 玩家数据[id].角色.精炼等级[2] >=24 and 玩家数据[id].角色.精炼等级[3] >=24 and 玩家数据[id].角色.精炼等级[4] >= 24
         and 玩家数据[id].角色.精炼等级[5] >= 24 and 玩家数据[id].角色.精炼等级[6]>= 24 then
            self.发送信息.套装等级 = 24
            self.发送信息.气血上限 = 6
            self.发送信息.魔法上限 = 6
            self.发送信息.物理攻击 = 6
            self.发送信息.灵力 = 6
            self.发送信息.速度 = 6
    elseif 玩家数据[id].角色.精炼等级[1]>= 20 and 玩家数据[id].角色.精炼等级[2]>= 20 and 玩家数据[id].角色.精炼等级[3]>= 20 and 玩家数据[id].角色.精炼等级[4] >= 20
         and 玩家数据[id].角色.精炼等级[5]>= 20 and 玩家数据[id].角色.精炼等级[6] >=20 then
            self.发送信息.套装等级 = 20
            self.发送信息.气血上限 = 5
            self.发送信息.魔法上限 = 5
            self.发送信息.物理攻击 = 5
            self.发送信息.灵力 = 5
            self.发送信息.速度 = 5
    elseif 玩家数据[id].角色.精炼等级[1] >= 16 and 玩家数据[id].角色.精炼等级[2] >= 16 and 玩家数据[id].角色.精炼等级[3] >= 16 and 玩家数据[id].角色.精炼等级[4]>= 16
         and 玩家数据[id].角色.精炼等级[5]>= 16 and 玩家数据[id].角色.精炼等级[6]>= 16 then
            self.发送信息.套装等级 = 16
            self.发送信息.气血上限 = 4
            self.发送信息.魔法上限 = 4
            self.发送信息.物理攻击 = 4
            self.发送信息.灵力 = 4
            self.发送信息.速度 = 4
    elseif 玩家数据[id].角色.精炼等级[1] >= 12 and 玩家数据[id].角色.精炼等级[2] >= 12 and 玩家数据[id].角色.精炼等级[3] >= 12 and 玩家数据[id].角色.精炼等级[4] >= 12
         and 玩家数据[id].角色.精炼等级[5]>= 12 and 玩家数据[id].角色.精炼等级[6] >= 12 then
            self.发送信息.套装等级 = 12
            self.发送信息.气血上限 = 3
            self.发送信息.魔法上限 = 3
            self.发送信息.物理攻击 = 3
            self.发送信息.灵力 = 3
            self.发送信息.速度 = 3
    elseif 玩家数据[id].角色.精炼等级[1] >= 8 and 玩家数据[id].角色.精炼等级[2] >= 8 and 玩家数据[id].角色.精炼等级[3]>= 8 and 玩家数据[id].角色.精炼等级[4] >= 8
         and 玩家数据[id].角色.精炼等级[5]>= 8 and 玩家数据[id].角色.精炼等级[6] >= 8 then
            self.发送信息.套装等级 = 8
            self.发送信息.气血上限 = 2
            self.发送信息.魔法上限 = 2
            self.发送信息.物理攻击 = 2
            self.发送信息.灵力 = 2
            self.发送信息.速度 = 2
    elseif 玩家数据[id].角色.精炼等级[1] >= 4 and 玩家数据[id].角色.精炼等级[2] >= 4 and 玩家数据[id].角色.精炼等级[3] >= 4 and 玩家数据[id].角色.精炼等级[4] >= 4
         and 玩家数据[id].角色.精炼等级[5]>= 4 and 玩家数据[id].角色.精炼等级[6] >= 4 then
            self.发送信息.套装等级 = 4
            self.发送信息.气血上限 = 1
            self.发送信息.魔法上限 = 1
            self.发送信息.物理攻击 = 1
            self.发送信息.灵力 = 1
            self.发送信息.速度 = 1
    end
    发送数据(玩家数据[id].连接id,156,self.发送信息)
end


function 道具处理类:刷新精炼数据(id)
       self.发送信息={}
    self.发送信息.所需数量={}
    self.发送信息.需要祝福={}
    self.发送信息.祝福值={}
    self.发送信息.低级祝福={}
    self.发送信息.中级祝福={}
    self.发送信息.高级祝福={}
    self.发送信息.低级成功率={}
    self.发送信息.中级成功率={}
    self.发送信息.高级成功率={}
    self.发送信息.精炼等级={}
    self.发送信息.精炼数值={}


       for n=1,6 do
         if 玩家数据[id].角色.装备[n]~=nil and self.数据[玩家数据[id].角色.装备[n]]~=nil then
             self.发送信息[n]=玩家数据[id].道具.数据[玩家数据[id].角色.装备[n]]
             if 玩家数据[id].角色.精炼等级 == nil then
               玩家数据[id].角色.精炼等级 = {[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0}
             end
             if 玩家数据[id].角色.祝福值 == nil then
                玩家数据[id].角色.祝福值 = 0
             end
             self.发送信息.所需数量[n] = self:取精炼所需数量(玩家数据[id].角色.精炼等级[n])
             self.发送信息.需要祝福[n] = self:取所需祝福值(玩家数据[id].角色.精炼等级[n])
             self.发送信息.祝福值 = 玩家数据[id].角色.祝福值
             self.发送信息.低级祝福[n] = self:取低级祝福(玩家数据[id].角色.精炼等级[n])
             self.发送信息.中级祝福[n] = self:取中级祝福(玩家数据[id].角色.精炼等级[n])
             self.发送信息.高级祝福[n] = self:取高级祝福(玩家数据[id].角色.精炼等级[n])
             self.发送信息.低级成功率[n] = self:取低级成功率(玩家数据[id].角色.精炼等级[n])
             self.发送信息.中级成功率[n] = self:取中级成功率(玩家数据[id].角色.精炼等级[n])
             self.发送信息.高级成功率[n] = self:取高级成功率(玩家数据[id].角色.精炼等级[n])
             self.发送信息.精炼等级[n] = 玩家数据[id].角色.精炼等级[n]
         end
       end
       self.发送信息.低级精炼 = 0
       self.发送信息.中级精炼 = 0
       self.发送信息.高级精炼 = 0
      发送数据(玩家数据[id].连接id,3699)
      发送数据(玩家数据[id].连接id,3006,"66")
      发送数据(玩家数据[id].连接id,157,self.发送信息)
      print(157)
end


function 道具处理类:一键精炼锻造(id,参数,内容)
    local 包裹 = "道具"
    local 所需数量
    local 实际数量=0

    local 消耗银子=f函数.读配置(程序目录..[[功能设置\精炼装备配置.txt]], "精炼装备", "消耗银子")+0
    if 玩家数据[id].角色.装备[参数]~=nil and 玩家数据[id].道具.数据[玩家数据[id].角色.装备[参数]]~=nil then
      所需数量 = self:取精炼所需数量(玩家数据[id].角色.精炼等级[参数])
      for i=1,10 do
       	 if 取银子(id) < 消耗银子 then
            发送数据(玩家数据[id].连接id,7,"#y/精炼装备每次需要"..消耗银子.."两银子")
            return true
        end
           local 物品名称="精炼之锤低"
        local 找到物品 = false
       local 特赦格子 = 0
        if 内容 == 1 then
          物品名称="精炼之锤低"



        elseif 内容 == 2 then
         物品名称="精炼之锤中"
        elseif 内容 == 3 then
          物品名称="精炼之锤高"
        end
         for n = 1, 100 do
              if 玩家数据[id].角色["道具"][n] ~= nil and 找到物品 == false and 玩家数据[id].道具.数据[玩家数据[id].角色["道具"][n]].名称 == 物品名称 then
              找到物品 = true
              特赦格子=n
              break
             end

           end

        if 特赦格子~=0 then
        道具id=玩家数据[id].角色.道具[特赦格子]
        实际数量=玩家数据[id].道具.数据[道具id].数量
        end
       if 实际数量<所需数量 then
             发送数据(玩家数据[id].连接id,7,"#y/你的精炼之锤数量不够本次精炼。")
             return true
          end
        玩家数据[id].道具.数据[道具id].数量=玩家数据[id].道具.数据[道具id].数量-所需数量

        if 实际数量<所需数量 then
           发送数据(玩家数据[id].连接id,7,"#y/你的精炼之锤数量不够本次精炼。")
           return true
        else
           self:精炼锻造(id,参数,内容)
        end
      end
    end

     道具刷新(id)--通过
end

function 道具处理类:精炼锻造(id,参数,内容)
    local 消耗银子=f函数.读配置(程序目录..[[功能设置\精炼装备配置.txt]], "精炼装备", "消耗银子")+0
 	 if 取银子(id) < 消耗银子 then
        发送数据(玩家数据[id].连接id,7,"#y/精炼装备每次需要"..消耗银子.."两银子")
        return true
    end

    local 包裹 = "包裹"
    local 实际数量=0
    local 概率
    local 祝福值
    local 需要祝福
    local 所需数量
    local 数组
    local 数组1

    if 玩家数据[id].角色.装备[参数]~=nil and 玩家数据[id].道具.数据[玩家数据[id].角色.装备[参数]]~=nil then
       所需数量 = self:取精炼所需数量(玩家数据[id].角色.精炼等级[参数])
    else
       发送数据(玩家数据[id].连接id,7,"#y/参数错误，请重新打开精炼界面")
       return true
    end
    if 玩家数据[id].角色.精炼等级[参数]>=40 then
       发送数据(玩家数据[id].连接id,7,"#y/当前精炼已经为最高等级，无法在进行精炼")
       return true
    end
    if 玩家数据[id].角色.装备[参数]~=nil and 玩家数据[id].道具.数据[玩家数据[id].角色.装备[参数]]~=nil then

        local 物品名称="精炼之锤低"
        local 找到物品 = false
       local 特赦格子 = 0
        local 道具id=0
        概率=self:取低级成功率(玩家数据[id].角色.精炼等级[参数])
       if 内容 == 1 then

       elseif 内容 == 2 then
        物品名称="精炼之锤中"
      概率=self:取中级成功率(玩家数据[id].角色.精炼等级[参数])
        elseif 内容 == 3 then
             物品名称="精炼之锤高"
            概率=self:取高级成功率(玩家数据[id].角色.精炼等级[参数])
        end
        for n = 1, 100 do
              if 玩家数据[id].角色["道具"][n] ~= nil and 找到物品 == false and 玩家数据[id].道具.数据[玩家数据[id].角色["道具"][n]].名称 == 物品名称 then
              找到物品 = true
              特赦格子=n
              break
             end

           end


        if 特赦格子~=0 then
        道具id=玩家数据[id].角色.道具[特赦格子]
        实际数量=玩家数据[id].道具.数据[道具id].数量
        end
       if 实际数量<所需数量 then
             发送数据(玩家数据[id].连接id,7,"#y/你的精炼之锤数量不够本次精炼。")
             return true
          end
        玩家数据[id].道具.数据[道具id].数量=玩家数据[id].道具.数据[道具id].数量-所需数量


       需要祝福 = self:取所需祝福值(玩家数据[id].角色.精炼等级[参数])
      玩家数据[id].角色:扣除银子(id,消耗银子,"精炼锻造")
       if 内容 == 1 then
          祝福值 = self:取低级祝福(玩家数据[id].角色.精炼等级[参数])
       elseif 内容 == 2 then
          祝福值 = self:取中级祝福(玩家数据[id].角色.精炼等级[参数])
       elseif 内容 == 3 then
          祝福值 = self:取高级祝福(玩家数据[id].角色.精炼等级[参数])
       end
       if (参数 == 1 and math.random(100)<=概率) or (玩家数据[id].角色.祝福值>=需要祝福) then
        if 玩家数据[id].角色.祝福值>=需要祝福 then
            玩家数据[id].角色.祝福值 = 0
        end
        玩家数据[id].角色.精炼等级[参数] = 玩家数据[id].角色.精炼等级[参数] + 1
        发送数据(玩家数据[id].连接id,7,"#y/恭喜你精炼装备成功")
       elseif 参数 == 2 and math.random(100)<=概率 or (玩家数据[id].角色.祝福值>=需要祝福) then
        if 玩家数据[id].角色.祝福值>=需要祝福 then
            玩家数据[id].角色.祝福值 = 0
        end
        玩家数据[id].角色.精炼等级[参数] = 玩家数据[id].角色.精炼等级[参数] + 1
        发送数据(玩家数据[id].连接id,7,"#y/恭喜你精炼装备成功")
       elseif 参数 == 3 and math.random(100)<=概率 or (玩家数据[id].角色.祝福值>=需要祝福) then
        if 玩家数据[id].角色.祝福值>=需要祝福 then
            玩家数据[id].角色.祝福值 = 0
        end
        玩家数据[id].角色.精炼等级[参数] = 玩家数据[id].角色.精炼等级[参数] + 1
        发送数据(玩家数据[id].连接id,7,"#y/恭喜你精炼装备成功")
       elseif 参数 == 4 and math.random(100)<=概率 or (玩家数据[id].角色.祝福值>=需要祝福) then
        if 玩家数据[id].角色.祝福值>=需要祝福 then
            玩家数据[id].角色.祝福值 = 0
        end
        玩家数据[id].角色.精炼等级[参数] = 玩家数据[id].角色.精炼等级[参数] + 1
        发送数据(玩家数据[id].连接id,7,"#y/恭喜你精炼装备成功")
       elseif 参数 == 5 and math.random(100)<=概率 or (玩家数据[id].角色.祝福值>=需要祝福) then
        if 玩家数据[id].角色.祝福值>=需要祝福 then
            玩家数据[id].角色.祝福值 = 0
        end
        玩家数据[id].角色.精炼等级[参数] = 玩家数据[id].角色.精炼等级[参数] + 1
        发送数据(玩家数据[id].连接id,7,"#y/恭喜你精炼装备成功")
       elseif 参数 == 6 and math.random(100)<=概率 or (玩家数据[id].角色.祝福值>=需要祝福) then
        if 玩家数据[id].角色.祝福值>=需要祝福 then
            玩家数据[id].角色.祝福值 = 0
        end
        玩家数据[id].角色.精炼等级[参数] = 玩家数据[id].角色.精炼等级[参数] + 1
        发送数据(玩家数据[id].连接id,7,"#y/恭喜你精炼装备成功")
       else
        玩家数据[id].角色.祝福值 = 玩家数据[id].角色.祝福值 + 祝福值
        发送数据(玩家数据[id].连接id,7,"#y/很遗憾，你本次精炼失败。")
       end
   else
        发送数据(玩家数据[id].连接id,7,"#y/数据有误，请重新打开精炼界面")
   end
   玩家数据[id].角色:刷新信息()
     self:刷新精炼数据(id)
   道具刷新(id)--通过

end

function 道具处理类:取精炼所需数量(等级)
    local 数量=f函数.读配置(程序目录..[[功能设置\精炼装备配置.txt]], "消耗锤子数量",tostring(等级))+0

    return 数量
end

function 道具处理类:取所需祝福值(等级)
    local 祝福值
    for i=1,41 do
      if 等级 == i-1 then
         祝福值 = i*100
      end
    end
    return 祝福值
end

function 道具处理类:取低级祝福(等级)
    local 祝福值
    for i=1,41 do
      if 等级 == i-1 then
         祝福值 = i*5
      end
    end
    return 祝福值
end

function 道具处理类:取中级祝福(等级)
    local 祝福值
    for i=1,41 do
      if 等级 == i-1 then
         祝福值 = i*10
      end
    end
    return 祝福值
end

function 道具处理类:取高级祝福(等级)
    local 祝福值
    for i=1,41 do
      if 等级 == i-1 then
         祝福值 = i*15
      end
    end
    return 祝福值
end
function 道具处理类:合成精炼之锤(id,数据)
  local 物品=数据.物品
   local 找到物品 = false
      local 特赦格子 = 0
      local 道具id = 0
      for n = 1, 100 do
          if 玩家数据[id].角色["道具"][n] ~= nil and 找到物品 == false and 玩家数据[id].道具.数据[玩家数据[id].角色["道具"][n]].名称 == 物品 then
              找到物品 = true
              特赦格子=n
                  break
          end

      end
        if 特赦格子~=0 then
        道具id=玩家数据[id].角色.道具[特赦格子]
        实际数量=玩家数据[id].道具.数据[道具id].数量
        end
      if 找到物品 == false then
          发送数据(玩家数据[id].连接id, 7,"你身上没有"..物品.."呀")
      elseif 玩家数据[id].道具.数据[道具id].数量 < 50 then
          发送数据(玩家数据[id].连接id, 7, "你身上没有"..物品.."数量不够")
      else
    玩家数据[id].道具.数据[道具id].数量=  玩家数据[id].道具.数据[道具id].数量-50
        if 物品=="精炼之锤中" then
         玩家数据[id].道具:给予道具(id, '精炼之锤高')
        elseif 物品=="精炼之锤低" then
           玩家数据[id].道具:给予道具(id, '精炼之锤中')
        end
      end
  发送数据(玩家数据[id].连接id,3699)

end

function 道具处理类:取低级成功率(等级)
    local 成功率=f函数.读配置(程序目录..[[功能设置\精炼装备配置.txt]], "低级锤子概率",tostring(等级))+0
    return 成功率
end

function 道具处理类:取中级成功率(等级)
    local 成功率=f函数.读配置(程序目录..[[功能设置\精炼装备配置.txt]], "中级锤子概率",tostring(等级))+0
    return 成功率
end

function 道具处理类:取高级成功率(等级)
    local 成功率=f函数.读配置(程序目录..[[功能设置\精炼装备配置.txt]], "高级锤子概率",tostring(等级))+0
    return 成功率
end
function 道具处理类:显示(x,y) end

function 道具处理类:显示(x,y) end

return 道具处理类
