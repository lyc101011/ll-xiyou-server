-- @Author: baidwwy
-- @Date:   2024-05-23 06:02:27
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-05-27 10:56:24
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 16:49:10
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

__NPCdh111[1135]=function (ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号 == 2 then
		wb[1] = "这里就是灵台方寸山，斜月三星洞。"
		wb[2] = "当年大闹天宫的齐天大圣就是在这里学艺的。"
		wb[3] = "菩提祖师管教很严厉，如果拜在他的门下，可要严于律己。"
		wb[4] = "金木水火土,急急如律令！"
		return {"男人_道士","觉明",wb[sj(1,#wb)]}
	elseif 编号 == 3 then
		wb[1] = "听说菩提祖师在广招门徒，常有能人异士来拜师。"
		wb[2] = "若不回头，为何不忘？若已无缘，何必誓言！"
		wb[3] = "别离仿佛昨日，转眼却已经年。旧事依然，物是人非。"
		return {"女人_丫鬟","灵儿",wb[sj(1,#wb)]}
	elseif 编号 == 4 then
		wb[1] = "方寸山远离红尘，清净雅致，正适合修道炼丹。"
		wb[2] = "方寸山以用符出名，方寸山的弟子人人都会画两手符。"
		wb[3] = "修道贵在专心，一心向道才能学有所成。"
		wb[4] = "由迷茫到觉悟的境界即是觉岸。可是苦海无边，哪里才是岸啊？"
		wb[5] = "是谁在此喧哗？打扰了我的清修#4"
		local xx={"我想学习奇门遁甲","购买五色旗盒","我只是路过"}
		return {"男人_道士","觉岸",wb[sj(1,#wb)],xx}
	elseif 编号 == 1 then
		wb[1] = "我送阁下回长安吧。"
		local xx = {"是的我要去","我还要逛逛"}
		return {"男人_道童","接引道童",wb[sj(1,#wb)],xx}
	end
	return
end

__NPCdh222[1135 ]=function  (id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="接引道童" then
        if 事件=="是的我要去" then
          地图处理类:npc传送(数字id,1001,470,253)
        end
    elseif 名称=="觉岸" then
        if 事件=="我想学习奇门遁甲" then
          玩家数据[数字id].角色:学习剧情技能(数字id,"奇门遁甲",4,4)
        elseif 事件=="购买五色旗盒" then
          添加最后对话(数字id,"你可以在我这里花费100E两银子购买五色旗盒，请确认是否要购买五色旗盒？",{"确认购买","我没那么多的钱"})
        elseif 事件=="确认购买" then
          if 玩家数据[数字id].角色.银子<10000000000 then
            添加最后对话(数字id,"你没有那么多的银子")
            return
          else
            if 玩家数据[数字id].角色:扣除银子(1000000000,0,0,"觉案购买五色旗盒",1)== false then 常规提示(数字id,"你的银两不足") return end
            玩家数据[数字id].道具:给予法宝(数字id,"五色旗盒")
            添加最后对话(数字id,"你花费5000000两银子成功购买了一个五色旗盒#1")
            return
          end
        end
    end
end