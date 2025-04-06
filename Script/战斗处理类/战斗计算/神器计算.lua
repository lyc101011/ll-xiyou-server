-- @Author: ASUS
-- @Date:   2021-10-06 20:13:50
-- @Last Modified by:   ASUS
-- @Last Modified time: 2023-01-30 20:49:23
local sj = 取随机数
local 神器计算 = class()

function 神器计算:初始化()
    self.SQ = {}
    self.SQ["藏锋敛锐"]=function(战斗数据,编号,攻击方,挨打方)
        return self:大唐官府_藏锋敛锐(战斗数据,编号,攻击方,挨打方)
    end
    self.SQ["凭虚御风"]=function(战斗数据,编号,攻击方,挨打方,挨打方)
        return self:神木林_凭虚御风(战斗数据,编号,攻击方,挨打方,挨打方)
    end
end

function 神器计算:神器技能(战斗数据,编号,cs)
    if 战斗数据.参战单位[编号].shenqi.name then
    	self.SQ[战斗数据.参战单位[编号].shenqi.name](战斗数据,编号,cs.攻击方,cs.挨打方,cs.qita)
    end
end

function 神器计算:大唐官府_藏锋敛锐(战斗数据,编号,lv,攻击方,挨打方)
    战斗计算:添加护盾(战斗数据,编号,qz(结尾气血*战斗数据.参战单位[编号].shenqi.lv))
end

function 神器计算:神木林_凭虚御风(战斗数据,编号,攻击方,挨打方,挨打方)
    战斗数据:添加状态("凭虚御风",攻击方,攻击方,69)
end

return 神器计算