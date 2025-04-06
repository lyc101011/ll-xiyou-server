-- @Author: baidwwy
-- @Date:   2024-08-21 11:47:38
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-10 20:31:08
-- -- @作者: baidwwy
-- -- @邮箱:  313738139@qq.com
-- -- @创建时间:   2021-01-31 22:24:33
-- -- @最后修改来自: baidwwy
-- -- @Last Modified time: 2023-05-13 14:42:27
-- local sj = 取随机数
-- local format = string.format
-- local insert = table.insert
-- local ceil = math.ceil
-- local floor = math.floor
-- local wps = 取物品数据
-- local typ = type
-- local random = 取随机数

__GWdh111[135]=function(连接id,数字id,序列,标识,地图)
	local 对话数据={}
		对话数据.模型=任务数据[标识].模型
		对话数据.名称=任务数据[标识].名称
		local wb = {}
		wb[1] = "天天在天界,都快闷死了".."#"..random(1,110).."？"
		wb[3] = "诶哦!你是什么发现我的,既然装不下去了,看来不能让你走了".."#"..random(1,110).."。"
		对话数据.对话=wb[random(1,#wb)]
		对话数据.选项={"叛徒抓你回去","我只是路过"}
	return 对话数据
end

__GWdh222[135]=function (连接id,数字id,序号,内容)
	local 事件=内容[1]
	local 名称=内容[3]
	if 事件=="叛徒抓你回去" then
			if 任务数据[玩家数据[数字id].地图单位.标识].zhandou~=nil then 常规提示(数字id,"#Y/对方正在战斗中") return  end
			 if 取等级要求(数字id,80)==false and 调试模式==false then 常规提示(数字id,"#Y/队伍中有成员等级不足80级") return  end
			if 取队伍人数(数字id)<3  and 调试模式==false then 常规提示(数字id,"#Y队伍人数低于3人，无法进入战斗") return  end
			任务数据[玩家数据[数字id].地图单位.标识].zhandou=true
			战斗准备类:创建战斗(数字id+0,100075,玩家数据[数字id].地图单位.标识)
			-- 玩家数据[数字id].地图单位=nil
			return
		end
end

-- function 设置任务135(id)
-- 	local 地图范围={1111,1114}
-- 	local x待发送数据 = {}
-- 	for i=1,#地图范围 do
-- 		local 临时数量=取随机数(3,10)
-- 		local 地图=地图范围[i]
-- 		x待发送数据[地图]={}
-- 		for n=1,临时数量 do
-- 			local 任务id=地图.."_135_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999).."_"..n
-- 			随机序列=随机序列+1
-- 			local xy=地图处理类.地图坐标[地图]:取随机点()
-- 			local 模型范围={"持国巡守","毗舍童子","灵灯侍者","般若天女","真陀护法","增长巡守","金身罗汉","曼珠沙华","红萼仙子","琴仙","金铙僧","灵鹤","雾中仙","大力金刚","净瓶女娲","律法女娲","灵符女娲"}--"宠物口粮",
-- 			local 模型=模型范围[取随机数(1,#模型范围)]
-- 			local x称谓 = "天界叛逆"
-- 			任务数据[任务id]={
-- 				id=任务id,
-- 				起始=os.time(),
-- 				结束=1800,
-- 				玩家id=0,
-- 				队伍组={},
-- 				名称=模型,
-- 				模型=模型,
-- 				等级=取随机数(125,155),
-- 				称谓=x称谓,
-- 				x=xy.x,
-- 				y=xy.y,
-- 				事件="明雷活动",
-- 				地图编号=地图,
-- 				地图名称=取地图名称(地图),
-- 				显示饰品=true,
-- 				类型=135
-- 			}
-- 			-- 地图处理类:添加单位(任务id)
-- 			table.insert(x待发送数据[地图], 地图处理类:批量添加单位(任务id))--修改
-- 		end
-- 	end
-- 	for i=1,#地图范围 do--修改
-- 		local 地图编号=地图范围[i]
-- 		for n, v in pairs(地图处理类.地图玩家[地图编号]) do
-- 			if n~=id and 地图处理类:取同一地图(地图编号,id,n,1)  then
-- 				发送数据(玩家数据[n].连接id,1021,x待发送数据[地图编号])
-- 			end
-- 		end
-- 	end
-- 	x待发送数据={}
-- 	广播消息({内容=format("#R/一群天界叛仙，出现了在天宫和月宫。"),频道="xt"})
-- end

-- function rwgx135(任务id)
-- 	if os.time()-任务数据[任务id].起始>=任务数据[任务id].结束 and 任务数据[任务id].结束 ~= 99999999 then -- 任务时间到期
-- 		if 任务数据[任务id].zhandou==nil  then
-- 			地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
-- 			任务数据[任务id]=nil
-- 		end
-- 	end
-- end