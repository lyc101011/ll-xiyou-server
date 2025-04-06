-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 17:54:14
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:09:37
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1123]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "生死有命，富贵在天。拜师的请进内室，地藏菩萨正在招收门徒。"
		wb[2] = "阎王要你三更死，不敢留你过五更。"
		wb[3] = "人生切莫把心欺，神鬼昭彰放过谁？"
		wb[4] = "左执生死簿，右拿勾魂笔，赏善罚恶，管人生死――这说的就是老夫我啦#17"
		return {"男人_判官","判官",wb[sj(1,#wb)],xx}
	else
		local name = ""
	    if 编号 == 2 then
	    	wb[1] = "我掌第五殿，司掌叫唤大地狱。凡押解到此殿者，押赴望乡台，令之闻见世上本家因罪恶遭殃各事。"
	    	name = "阎罗王"
	    elseif 编号 == 3 then
	    	wb[1] = "我掌第十殿，专司各殿解到鬼魂。辨明善恶，核定等级，发往转生。"
	    	name = "转轮王"
	    elseif 编号 == 4 then
	    	wb[1] = "我掌第一殿，司人世天寿生死，统管幽冥吉凶。"
	    	name = "秦广王"
	    elseif 编号 == 5 then
	    	wb[1] = "我掌第二殿，司掌活大地狱。凡在阳间伤人肢体，奸盗杀生者，推入此狱。"
	    	name = "初江王"
	    elseif 编号 == 6 then
	    	wb[1] = "我掌第三殿，司掌黑蝇大地狱。凡是人抗粮赖租，交易狡诈者，推入此狱。"
	    	name = "宋帝王"
	    elseif 编号 == 7 then
	    	wb[1] = "我掌第六殿，司掌打叫唤大地狱及枉死城。凡世人怨天尤地，对北溺变涕泣者，推入此狱。"
	    	name = "卞城王"
		elseif 编号 == 8 then
	    	wb[1] = "我掌第九殿，司掌打叫酆都城铁网阿鼻地狱。凡阳世杀人放火，战绞正法者，解到本殿。"
	    	name = "平等王"
		elseif 编号 == 9 then
	    	wb[1] = "我掌第七殿，司掌热恼地狱。凡阳世取骸合药，离人至戚者，推入此狱。"
	    	name = "泰山王"
	    elseif 编号 == 10 then
	    	wb[1] = "我掌第八殿，司掌大热恼大地狱，凡谢世不孝，使父母翁姑愁闷懊恼者，发入此狱。"
	    	name = "都市王"
	    elseif 编号 == 11 then
	    	wb[1] = "我掌第四殿，司掌合大地狱。凡阳世忤逆尊长，教唆兴讼者，推入此狱。"
	    	name = "忤官王"
	    end
	    wb[2] = "人世沉浮，根本寂灭。"
	    wb[3] = "天网恢恢，疏而不漏。"
	    wb[4] = "善恶到头，神鬼难欺。"
	    wb[5] = "天理昭彰，报应不爽。"
	    wb[6] = "因果循环，六道轮回。"
	    wb[7] = "临阵无退，杀身有择。"
	    return {"阎罗王",name,wb[sj(1,#wb)],xx}
	end
	return
end