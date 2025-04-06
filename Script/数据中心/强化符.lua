-- @Author: baidwwy
-- @Date:   2024-06-13 17:01:22
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-06-25 19:05:34
local floor = math.floor
function 取强化符分类(mc)
	if mc == "尸气漫天" or mc == "神兵护法" then --头
	    return 1
	elseif mc == "嗜血" or mc == "莲华妙法" or mc == "担山赶月" then  --项链
		return 2
	elseif mc == "轻如鸿毛" or mc == "盘丝舞" or mc == "魔王护持" or mc == "龙附" or mc == "元阳护体" then --武器
		return 3
	elseif mc == "浩然正气" or mc == "一气化三清" then  --衣服
		return 4
	elseif mc == "神力无穷" or mc == "穿云破空" then  --腰带
		return 5
	elseif mc == "拈花妙指" or mc == "神木呓语"  then  --鞋子
		return 6
	end
	return 0
end

function 取强化符效果(jn,lv,fl)
	local fhz = {类型 = "无",数值 =0}
	local 分类 = 取强化符分类(jn)
	if fl==分类 then
		if jn == "嗜血" then --大唐 项链  体质
			fhz = {类型 = "体质",数值 = floor(取随机数(lv*0.1,lv*0.2))}
		elseif jn == "轻如鸿毛" then --女儿村 武器 魔法
			fhz = {类型 = "魔法",数值 = floor(取随机数(lv,lv*2))}
		elseif jn == "拈花妙指" then --化生寺临时符技能(速度符)　 鞋子
			fhz = {类型 = "速度",数值 = floor(取随机数(lv*0.35,lv*0.7))}
		elseif jn == "盘丝舞" then --盘丝洞 临时符技能(防御符)  武器
			fhz = {类型 = "防御",数值 = floor(取随机数(lv*0.5,lv))}
		elseif jn == "一气化三清" then --五庄观 门派临时符技能-魔力  铠甲
			fhz = {类型 = "魔力",数值 = floor(取随机数(lv*0.15,lv*0.3))}
		elseif jn == "浩然正气" then --天宫 临时符技能(法防符) 铠甲
			fhz = {类型 = "法术防御",数值 = floor(取随机数(lv*0.2,lv*0.4))}
		elseif jn == "龙附" then --龙宫 技能(伤害符) 武器
			fhz = {类型 = "伤害",数值 = floor(取随机数(lv*0.5,lv))}
		elseif jn == "神兵护法" then --方寸山  临时符技能（命中符） 头盔
			fhz = {类型 = "命中",数值 = floor(取随机数(lv*0.5,lv))}
		elseif jn == "魔王护持" then --魔王寨 临时符技能(血符)　武器
			fhz = {类型 = "气血",数值 = floor(取随机数(lv,lv*2))}
		elseif jn == "莲华妙法" then --普陀山  门派临时符技能（法伤符） 项链
			fhz = {类型 = "法术伤害",数值 = floor(取随机数(lv*0.2,lv*0.4))}
		elseif jn == "神力无穷" then --狮驼岭 临时符技能(愤怒符)　腰带
			fhz = {类型 = "愤怒",数值 = floor(取随机数(lv*0.16,lv*0.3))}
		elseif jn == "尸气漫天" then --阴曹地府 临时符技能(耐力符)　 头盔/发钗
			fhz = {类型 = "耐力",数值 = floor(取随机数(lv*0.1,lv*0.2))}
		elseif jn == "担山赶月" then --花果山临时符技能(力量符)　 项链
			fhz = {类型 = "力量",数值 = floor(取随机数(lv*0.1,lv*0.2))}
		elseif jn == "神木呓语" then --神木林临时符技能(法伤结果符) 鞋子
			fhz = {类型 = "法伤结果",数值 = floor(取随机数(lv*0.15,lv*0.3))}
		elseif jn == "元阳护体" then --无底洞临时符技能(气血回复符)　武器
			fhz = {类型 = "气血回复效果",数值 = floor(取随机数(lv*0.2,lv*0.4))}
		elseif jn == "穿云破空" then --凌波城临时符技能(伤害结果符) 腰带
			fhz = {类型 = "物伤结果",数值 = floor(取随机数(lv*0.15,lv*0.3))}
		end
	end
	return fhz
end