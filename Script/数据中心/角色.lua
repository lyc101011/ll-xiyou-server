-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:44
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-09-08 20:58:08

角色武器类型={
	神天兵={1,9},
	龙太子={1,7},
	舞天姬={5,11},
	玄彩娥={5,8},
	桃夭夭={18,5},
	剑侠客={3,12},
	逍遥生={7,3},
	飞燕女={4,11},
	英女侠={4,10},
	羽灵神={14,13},
	虎头怪={2,9},
	巨魔王={2,12},
	骨精灵={8,6},
	狐美人={6,10},
	鬼潇潇={17,6},
	杀破狼={14,15},
	偃无师={16,3},
	巫蛮儿={13,15},
    影精灵={8,6},
}
-- function 取星位效果(sj,mp)
--  	if mp == "大唐官府" and sj[1].颜色 == "白" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "金" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "红" then
--  		return "燃魂"
-- 	elseif mp == "大唐官府" and sj[1].颜色 == "白" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "金" and  sj[4].颜色 == "白" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "蓝" then
--     	return "锐杀"
--     elseif mp == "方寸山" and sj[1].颜色 == "白" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "金" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "蓝" and  sj[6].颜色 == "红" then
--     	return "灵压"
--     elseif mp == "方寸山" and sj[1].颜色 == "黑" and  sj[2].颜色 == "红" and  sj[3].颜色 == "金" and  sj[4].颜色 == "白" and  sj[5].颜色 == "蓝" and  sj[6].颜色 == "红" then
--     	return "再塑"
--     elseif mp == "化生寺" and sj[1].颜色 == "白" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "红" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "红" then
--     	return "弘法"
--     elseif mp == "化生寺" and sj[1].颜色 == "白" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "金" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "蓝" and  sj[6].颜色 == "红" then
--     	return "佛心"
--     elseif mp == "龙宫" and sj[1].颜色 == "白" and  sj[2].颜色 == "红" and  sj[3].颜色 == "金" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "蓝" and  sj[6].颜色 == "红" then
--     	return "招云"
--     elseif mp == "龙宫" and sj[1].颜色 == "白" and  sj[2].颜色 == "红" and  sj[3].颜色 == "红" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "蓝" and  sj[6].颜色 == "红" then
--     	return "腾蛟"
--     elseif mp == "魔王寨" and sj[1].颜色 == "白" and  sj[2].颜色 == "红" and  sj[3].颜色 == "金" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "红" then
--     	return "蕴气"
--     elseif mp == "魔王寨" and sj[1].颜色 == "白" and  sj[2].颜色 == "红" and  sj[3].颜色 == "金" and  sj[4].颜色 == "白" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "红" then
--     	return "怒焰"
--     elseif mp == "女儿村" and sj[1].颜色 == "白" and  sj[2].颜色 == "红" and  sj[3].颜色 == "红" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "红" then
--     	return "花药"
--     elseif mp == "女儿村" and sj[1].颜色 == "黑" and  sj[2].颜色 == "红" and  sj[3].颜色 == "红" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "红" then
--     	return "花冢"
--     elseif mp == "盘丝洞" and sj[1].颜色 == "白" and  sj[2].颜色 == "红" and  sj[3].颜色 == "金" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "蓝" then
--     	return "踏网"
--     elseif mp == "盘丝洞" and sj[1].颜色 == "白" and  sj[2].颜色 == "红" and  sj[3].颜色 == "红" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "蓝" and  sj[6].颜色 == "蓝" then
--     	return "艳妆"
--     elseif mp == "普陀山" and sj[1].颜色 == "白" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "红" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "蓝" then
--     	return "法决"
--     elseif mp == "普陀山" and sj[1].颜色 == "白" and  sj[2].颜色 == "红" and  sj[3].颜色 == "红" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "蓝" then
--     	return "莲佑"
--     elseif mp == "狮驼岭" and sj[1].颜色 == "黑" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "金" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "红" then
--     	return "威压"
--     elseif mp == "狮驼岭" and sj[1].颜色 == "黑" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "红" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "蓝" then
--     	return "索命"
--     elseif mp == "天宫" and sj[1].颜色 == "黑" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "红" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "蓝" and  sj[6].颜色 == "红" then
--     	return "天威"
--     elseif mp == "天宫" and sj[1].颜色 == "黑" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "红" and  sj[4].颜色 == "白" and  sj[5].颜色 == "蓝" and  sj[6].颜色 == "红" then
--     	return "凝力"
--     elseif mp == "五庄观" and sj[1].颜色 == "白" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "金" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "蓝" then
--     	return "云步"
--     elseif mp == "五庄观" and sj[1].颜色 == "黑" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "红" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "蓝" then
--     	return "清风"
--     elseif mp == "阴曹地府" and sj[1].颜色 == "白" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "金" and  sj[4].颜色 == "白" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "红" then
--     	return "魂附"
--     elseif mp == "阴曹地府" and sj[1].颜色 == "黑" and  sj[2].颜色 == "红" and  sj[3].颜色 == "金" and  sj[4].颜色 == "白" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "红" then
--     	return "毒附"
--     elseif mp == "神木林" and sj[1].颜色 == "白" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "红" and  sj[4].颜色 == "白" and  sj[5].颜色 == "蓝" and  sj[6].颜色 == "蓝" then
--     	return "秋风"
--     elseif mp == "神木林" and sj[1].颜色 == "白" and  sj[2].颜色 == "红" and  sj[3].颜色 == "红" and  sj[4].颜色 == "白" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "蓝" then
--     	return "云击"
--     elseif mp == "凌波城" and sj[1].颜色 == "白" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "金" and  sj[4].颜色 == "白" and  sj[5].颜色 == "蓝" and  sj[6].颜色 == "蓝" then
--     	return "怒袭"
--     elseif mp == "凌波城" and sj[1].颜色 == "白" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "金" and  sj[4].颜色 == "白" and  sj[5].颜色 == "蓝" and  sj[6].颜色 == "红" then
--     	return "狂扫"
--     elseif mp == "无底洞" and sj[1].颜色 == "白" and  sj[2].颜色 == "红" and  sj[3].颜色 == "金" and  sj[4].颜色 == "白" and  sj[5].颜色 == "蓝" and  sj[6].颜色 == "蓝" then
--     	return "山甲"
--     elseif mp == "无底洞" and sj[1].颜色 == "白" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "红" and  sj[4].颜色 == "白" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "红" then
--     	return "灵决"
--     elseif sj[1].颜色 == "黑" and  sj[2].颜色 == "红" and  sj[3].颜色 == "红" and  sj[4].颜色 == "白" and  sj[5].颜色 == "蓝" and  sj[6].颜色 == "蓝" then
--     	return "全能"
--     elseif sj[1].颜色 == "白" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "红" and  sj[4].颜色 == "白" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "蓝" then
--     	return "药香"
--     elseif sj[1].颜色 == "黑" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "红" and  sj[4].颜色 == "白" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "红" then
--     	return "破杀"
--     elseif sj[1].颜色 == "白" and  sj[2].颜色 == "红" and  sj[3].颜色 == "金" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "蓝" and  sj[6].颜色 == "蓝" then
--     	return "法门"
--     elseif sj[1].颜色 == "白" and  sj[2].颜色 == "红" and  sj[3].颜色 == "金" and  sj[4].颜色 == "白" and  sj[5].颜色 == "蓝" and  sj[6].颜色 == "红" then
--     	return "屠兽"
--     elseif sj[1].颜色 == "黑" and  sj[2].颜色 == "红" and  sj[3].颜色 == "金" and  sj[4].颜色 == "黑" and  sj[5].颜色 == "蓝" and  sj[6].颜色 == "红" then
--     	return "逐兽"
--     elseif sj[1].颜色 == "白" and  sj[2].颜色 == "红" and  sj[3].颜色 == "金" and  sj[4].颜色 == "白" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "蓝" then
--     	return "心印"
--     elseif sj[1].颜色 == "黑" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "金" and  sj[4].颜色 == "白" and  sj[5].颜色 == "蓝" and  sj[6].颜色 == "红" then
--     	return "聚焦"
--     elseif sj[1].颜色 == "黑" and  sj[2].颜色 == "蓝" and  sj[3].颜色 == "金" and  sj[4].颜色 == "白" and  sj[5].颜色 == "绿" and  sj[6].颜色 == "蓝" then
--     	return "仙骨"
--     end
--     return ""
-- end

function 取法宝门派(名称)
    if 名称=="天师符" or 名称=="救命毫毛" then
        return "方寸山"
    elseif 名称=="织女扇" or 名称=="曼陀罗" then
        return "女儿村"
    elseif 名称=="雷兽" or 名称=="伏魔天书" then
        return "天宫"
    elseif 名称=="忘情" or 名称=="迷魂灯" then
        return "盘丝洞"
    elseif 名称=="幽灵珠" or 名称=="金蟾" or 名称=="宝烛" then
        return "无底洞"
    elseif 名称=="七杀" or 名称=="干将莫邪" then
        return "大唐官府"
    elseif 名称=="罗汉珠" or 名称=="慈悲" then
        return "化生寺"
    elseif 名称 == "分水" or 名称=="镇海珠" then
        return "龙宫"
    elseif 名称 == "赤焰" or 名称 == "五火神焰印"  then
        return "魔王寨"
    elseif 名称=="金刚杵" or 名称=="普渡" then
        return "普陀山"
    elseif 名称=="兽王令" or 名称=="失心钹" then
        return "狮驼岭"
    elseif 名称=="摄魂" or 名称=="九幽" then
        return "阴曹地府"
    elseif 名称 == "天煞" or 名称 == "斩魔" then
        return "凌波城"
    elseif 名称=="定风珠" or 名称=="奇门五行令" then
        return "五庄观"
    elseif 名称 == "月影" or 名称 == "神木宝鼎" then
        return "神木林"
    elseif 名称=="琉璃灯" or 名称=="金箍棒" then
        return "花果山"
    elseif 名称 == '驭魔笼'or 名称=="铸兵锤" then
        return "九黎城"
    end
    return "无门派"
end

function 取法宝是否存在(id,名称)
    for n=1,#玩家数据[id].角色.法宝佩戴 do
        if 玩家数据[id].角色.法宝佩戴[n].名称==名称 then
            return true
        end
    end
    return false
end

