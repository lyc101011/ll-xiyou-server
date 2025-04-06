-- @Author: baidwwy
-- @Date:   2024-12-14 19:53:28
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-12-27 22:39:02
local 地图坐标类 = class()

function 地图坐标类:初始化(文件)
	if 文件==5136 or 文件==5137 or 文件==5138 or 文件==5139  then
	    文件=1197
	elseif 文件==6227 then --武神坛
		文件=2000
	elseif 文件==6135 then
		文件=1001
	elseif 文件==6136 then
	    文件=1526
	elseif 文件==6228 then --修业所
		文件=1343
	end
	self.dtwj = 文件+0
	self.mapzz = {}
	self.增加 = {x=0,y=0,z=0}
	self.db = {}
	-- __S服务:输出(文件)
	--self.map = require("Script/地图处理类/MAP")([[scene/]]..文件..".map")
	--地图数据存储[self.dtwj]={宽度=self.map.Width,高度=self.map.Height}
	--self.宽度,self.高度,self.行数,self.列数 = self.map.Width,self.map.Height,self.map.MapRowNum,self.map.MapColNum
	self.路径点={}
	self.map ={}
	self.寻路 ={}
end

function 地图坐标类:取随机点()
	local 临时路径点 = {}
	local 返回点 = {}
	临时路径点 = table.loadstring(读入文件([[maplj\]]..self.dtwj..[[.txt]]))
	local 随机点=取随机数(1,#临时路径点)
	返回点 = {x=临时路径点[随机点].x,y=临时路径点[随机点].y}
	return  返回点
end

function 地图坐标类:取附近点(x,y)
	local 临时路径点 = {}
	local 返回点 = {}
	local 临时表 = {}
	临时路径点 = table.loadstring(读入文件([[maplj\]]..self.dtwj..[[.txt]]))
	local 随机点=取随机数(1,#临时路径点)
	for k,v in pairs(临时路径点) do
		local 临时x,临时y = 临时路径点[k].x-x,临时路径点[k].y-y
		if 临时x > -10  and 临时x < 10 and 临时y > -10  and 临时y < 10 then
			临时表[#临时表+1] = {x=临时路径点[k].x,y=临时路径点[k].y}
		end
	end
	local 随机点=取随机数(1,#临时表)
	返回点 = {x=临时表[随机点].x,y=临时表[随机点].y}
	return  返回点
	---下面这个貌似更好一些呢
	-- local 临时路径点 = {}
	-- local 返回点 = {}
	-- 临时路径点 = table.loadstring(读入文件([[maplj\]]..self.dtwj..[[.txt]]))
	-- local 随机点=取随机数(1,#临时路径点)
	-- 返回点 = {x=临时路径点[随机点].x,y=临时路径点[随机点].y}
	-- 临时路径点 = {}
	-- return  返回点
	---下面这个貌似更好一些呢
end

--助战


function 地图坐标类:更新(dt) end
function 地图坐标类:显示(x,y) end
return 地图坐标类