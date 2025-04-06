-- @Author: baidwwy
-- @Date:   2024-07-28 20:19:05
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-08-14 16:02:38
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[1107]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 1 then
		wb[1] = "#15俺家小女儿也被捉去了~!俺就这么一个小女儿，老天爷你待俺不薄啊!啊，这几位少侠玉树临风英伟不凡，想必是热心助人的少年英雄，能否帮俺找回女儿?又来了!那风沙又来了!这次不知又是哪户人家遭决了？"
		xx = {"我们正是为此事而来，快追上去","天有不测风云，老伯节哀顺变吧···"}
		if 玩家数据[数字id].角色:取任务(950)~=0 then
        wb[1]="你的副本已经开启了，是否需要我帮你传送进去？"
        xx={"请送我进去","我等会再进去"}
            end
		return {"男人_老伯","文老伯",wb[取随机数(1,#wb)],xx}
	end
	return
end
__NPCdh222[1107]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	-- local zhouji=tonumber(os.date("%w", os.time()))
        if  事件=="我们正是为此事而来，快追上去" then
        	-- if zhouji==2  or zhouji==6  then
            副本_天火之殇上:开启天火之殇上副本(数字id)
            -- else
            --  添加最后对话(数字id,"此副本每周二和周六开启。")
          --  end
        elseif 事件=="请送我进去" then
            任务处理类:副本传送(数字id,950)
    end
end