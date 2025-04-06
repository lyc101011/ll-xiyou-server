-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-02-03 22:34:18
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-05-13 14:17:30
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2021-01-31 22:15:06
-- @最后修改来自: baidwwy
-- @Last Modified time: 2021-02-01 21:36:40
local sj = 取随机数
local format = string.format
local insert = table.insert
local ceil = math.ceil
local floor = math.floor
local wps = 取物品数据
local typ = type
local random = 取随机数

__NPCdh111[5005]=function(ID,编号,页数,已经在任务中,数字id)
	local wb = {}
	local xx = {}
	if 编号==1  then
      	wb[1] = "欢迎少侠来到这昆仑仙境之中修行二，修行之时服食使用昆仑仙果调配而成的丹药，可让修行事半功倍哦，少侯可有兴趣购买丹药食用。"
      	local xx={"请将我送回长安","我要购买修行秘药","查看今日修行次数","我还想在玩一会呢"}
      	return {"雾中仙","昆仑仙",wb[取随机数(1,#wb)],xx}
    end
	return
end

__NPCdh222[5005]=function(id,数字id,序号,内容)
	local 事件=内容[1]
  	local 名称=内容[3]
  	if 名称=="昆仑仙" then
        if 事件=="请将我送回长安" then
            跳转长安(数字id)
        elseif 事件 == "我要购买修行秘药" then
        	玩家数据[数字id].商品列表=商店处理类.商品列表[51]
			发送数据(id,9,{商品=商店处理类.商品列表[51],银子=玩家数据[数字id].角色.银子})
		elseif 事件 == "查看今日修行次数" then
			local 次数=0
			local 剩余=0
			if 初始活动.昆仑仙境[数字id] then
			    次数=初始活动.昆仑仙境[数字id].次数
			    剩余=初始活动.昆仑仙境[数字id].最大次数-初始活动.昆仑仙境[数字id].次数
			end
			添加最后对话(数字id,"少侠今日已修行"..次数.."次，剩余"..剩余.."次。")
        end
    end
end

function 设置任务241(id)
	if 玩家数据[id].角色:取任务(241)==0 then
		local 任务id=id.."_241_"..os.time()
		任务数据[任务id]={
			id=任务id,
			起始=os.time(),
			结束=3600,
			玩家id=id,
			类型=241
		}
		玩家数据[id].角色:添加任务(任务id)
	else
		任务数据[玩家数据[id].角色:取任务(241)].结束=任务数据[玩家数据[id].角色:取任务(241)].结束+3600
		玩家数据[id].角色:刷新任务跟踪()
	end
end

function rwgx241(任务id)
	if os.time()-任务数据[任务id].起始>=任务数据[任务id].结束 and 任务数据[任务id].结束 ~= 99999999 then -- 任务时间到期
		if 玩家数据[任务数据[任务id].玩家id]~=nil then
			玩家数据[任务数据[任务id].玩家id].角色:取消任务(任务id)
			发送数据(玩家数据[任务数据[任务id].玩家id].连接id,39)
			常规提示(任务数据[任务id].玩家id,"你的修行双倍时间到期了！")
		end
		任务数据[任务id]=nil
	end
end

function 任务说明241(玩家id,任务id)
	local 说明 = {}
	说明={"昆仑仙境","#L你的修行双倍时间还可持续#R/"..取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))).."#L/分钟。"}
	return 说明
end
