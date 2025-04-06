-- @Author: baidwwy
-- @Date:   2023-09-20 21:13:17
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-10-27 03:08:50
-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2016-05-10 22:34:27
-- @最后修改来自: baidwwy
-- @Last Modified time: 2022-12-05 20:51:14
local ffi = require("ffi")
math.randomseed(tostring(os.time()):reverse():sub(1, 7))
状态 = "等待启动"
local xs = 300	--------------------- 第一圈 600=1秒
function 循环函数()
	if 状态 == "等待启动" then
		local 指针 = 返回消息("取数量指针")--获取共享内存指针
		数量指针 = ffi.cast("int*",指针)
	    状态 = "启动中"
	    返回消息("假人线程启动中")
	elseif 状态 == "启动中" then
		if 数量指针[0] > 0 then--向主线程拉数据
		    等到数据 = {返回消息("取数据")}
		    数量指针[0] = 数量指针[0] -1
		end
		if xs == 1 then
			xs= 300 --math.random(500,2000)
			返回消息("循环更新")
		else
	    	xs = xs -1
		end
	end
end




-------=======================
-- local ffi = require("ffi")
-- 状态 = "等待启动"
-- local xs = 100
-- local 转圈=0
-- function 循环函数()
--  if 转圈 > 10 then
-- 	return
--  else
-- 	if 状态 == "等待启动" then
-- 		local 指针 = 返回消息("取数量指针")--获取共享内存指针
-- 		数量指针 = ffi.cast("int*",指针)
-- 	    状态 = "启动中"
-- 	    返回消息("假人线程启动中")
-- 	elseif 状态 == "启动中" then
-- 		if 数量指针[0] > 0 then--向主线程拉数据
-- 		    等到数据 = {返回消息("取数据")}
-- 		    数量指针[0] = 数量指针[0] -1
-- 		end
-- 		if xs == 1 then
-- 			xs= 100 -------------------卡的根源
-- 			返回消息("循环更新")
-- 			转圈=转圈+1
-- 		else
-- 	    	xs = xs -1
-- 		end
-- 	end
--  end
-- end
