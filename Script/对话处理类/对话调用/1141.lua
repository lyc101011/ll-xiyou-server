-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 18:02:47
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:17:16
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1141]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "观世间疾苦繁华，身身入耳，一一在心。"
		wb[2] = "我南海普陀山有救世正心之法，只传授给有缘之人。"
		wb[3] = "心欲若除，则万事可成，心无杂念，非外事可扰。"
		wb[4] = "佛祖有真经三藏，乃是修真之经，正善之门，可劝人为善。"
		wb[5] = "修行贵在持之以恒，切忌浮躁自满。"
		local xx = {"交谈","给予","乾元丹学习","师门任务","学习技能","我想切换流派"}
		if 玩家数据[数字id].角色.门派 == "无" or 玩家数据[数字id].角色.门派 == "无门派" then
		  	xx={"我还想去其他门派看看……","请收我为徒"}
    	elseif 玩家数据[数字id].角色.门派~="普陀山" then
    		xx={}
		end
		if 玩家数据[数字id].角色:取任务(300)~=0 then
			local 任务id= 玩家数据[数字id].角色:取任务(300)
			if 任务数据[任务id].人物=="观音姐姐" then
				wb={}
				xx={}
				wb[1] = "原来是你给我送东西来了。怎么改行当镖师了？"
				押镖:完成押镖任务(任务id,数字id,任务数据[任务id].人物地图)
			else
				wb={}
				xx={}
			    wb[1] = "少侠你的镖是不是运送错了地方呢，再仔细看看任务提示！"
			end
		end
		return {"观音姐姐","观音姐姐",wb[sj(1,#wb)],xx,"门派师傅"}
	elseif 编号 == 2 then
		wb[1] = "普陀山是观音姐姐清修之地，紫气蒸腾，烟围雾笼，景色可是十分奇秀。"
		wb[2] = "大慈与一切众生乐，大悲与一切众生苦。"
		wb[3] = "很多怪病奇毒只有仙家灵丹可以医治。"
		wb[4] = "欲朝普陀山，必度莲花池，穿过前面的莲池，便可见到观音姐姐了。"
		return {"普陀山_接引仙女","青莲仙女",wb[sj(1,#wb)]}
	end
	return
end

__NPCdh222[1141 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="观音姐姐" then
        local 门派类型="普陀山"
        if 事件=="请收我为徒" then
          玩家数据[数字id].角色:加入门派(数字id,门派类型)
        elseif 事件=="交谈" then
          --玩家数据[数字id].角色:门派交谈(数字id,门派类型)
        elseif 事件=="师门任务" then
          玩家数据[数字id].角色:门派任务(数字id,门派类型)

        elseif 事件=="学习技能" then
          --local 临时数据=玩家数据[数字id].角色:取总数据()
          发送数据(id,31,玩家数据[数字id].角色:取总数据1())
          发送数据(id,32)
        end
    end
end