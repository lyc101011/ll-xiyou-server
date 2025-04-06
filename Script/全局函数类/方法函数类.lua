-- @Author: ASUS
-- @Date:   2020-11-26 19:00:48
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-10 22:09:02
function 调试信息(...)
end

function RequireFile(FilaName)
	require(FilaName)
	collectgarbage("collect")
end

function 分割文本(str,delimiter)
	local dLen = string.len(delimiter)
	local newDeli = ''
	for i=1,dLen,1 do
		newDeli = newDeli .. "["..string.sub(delimiter,i,i).."]"
	end
	local locaStart,locaEnd = string.find(str,newDeli)
	local arr = {}
	local n = 1
	while locaStart ~= nil
	do
		if locaStart>0 then
			arr[n] = string.sub(str,1,locaStart-1)
			n = n + 1
		end
		str = string.sub(str,locaEnd+1,string.len(str))
		locaStart,locaEnd = string.find(str,newDeli)
	end
	if str ~= nil then
		arr[n] = str
	end
	return arr
end

function table_leng(t)
  local leng=0
  for k, v in pairs(t) do
    leng=leng+1
  end
  return leng;
end

function GetPreciseDecimal(nNum, n)
	if type(nNum) ~= "number" then
			return nNum;
	end
	n = n or 0;
	n = math.floor(n)
	if n < 0 then
			n = 0;
	end
	local nDecimal = 10 ^ n
	local nTemp = math.floor(nNum * nDecimal);
	local nRet = nTemp / nDecimal;
	return nRet;
end

function 取随机数(q,w)
	随机序列=随机序列+1
	if 随机序列>=1000 then 随机序列=0 end
	if q==nil or w==nil then
		q=1 w=100
	else

	end
	math.randomseed(tostring(os.clock()*os.time()*随机序列))
	return  math.random(math.floor(q),math.floor(w))
end

function 四舍五入(a)
	return  math.floor(a+0.5)
end

function DeepCopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for key, value in pairs(object) do
            new_table[_copy(key)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

function 判断是否为空表(t)
  return _G.next( t ) == nil
end

function 取星期几()
  if tonumber(os.date("%w", os.time()))==1 then
    return 1
  elseif tonumber(os.date("%w", os.time()))==2 then
    return 2
  elseif tonumber(os.date("%w", os.time()))==3 then
    return 3
  elseif tonumber(os.date("%w", os.time()))==4 then
    return 4
  elseif tonumber(os.date("%w", os.time()))==5 then
    return 5
  elseif tonumber(os.date("%w", os.time()))==6 then
    return 6
  elseif tonumber(os.date("%w", os.time()))==0 then
    return 7
  end
end

function 写出内容(qq, ww)
	if qq == nil or ww == nil or ww == "" then
		return 0
	end
	-- print(qq.."位置:全局函数-方法函数类")
		qq = 程序目录 .. qq
	local file = io.open(qq,"w")
	file:write(ww)
	file:close()
	text =0
	程序目录=lfs.currentdir()..[[\]]
	return text
end

function 写出文件(qq,ww)
	写出内容(qq,ww)
	lfs.chdir(初始目录)
	程序目录=初始目录
end

function 另存文件(qq, ww)
	local file = io.open(qq,"w")
	file:write(ww)
	file:close()
end

function 写配置(文件,节点,名称,值)--写配置("./config.ini","mhxy","宽度",全局游戏宽度)
	return ffi.C.WritePrivateProfileStringA(节点,名称,tostring(值),文件)
end

function 取分(a)
	return math.floor(a/60)
end

function 读入文件(fileName)
	local f = assert(io.open(fileName,'r'))
	local content = f:read('*all')
	f:close()
	if content=="" then content="无文本" end
	return content
end

function qbfb(a,b)
	return a/b
end

function txt(布尔值)
	if 布尔值 then
		return "true"
	else
		return "false"
	end
end

function 时间转换(时间)
	return  "["..os.date("%Y", 时间).."年"..os.date("%m", 时间).."月"..os.date("%d", 时间).."日 "..os.date("%X", 时间).."]"
end

function 时间转换1(时间)
	return  os.date("%Y", 时间).."-"..os.date("%m", 时间).."-"..os.date("%d", 时间).." "..os.date("%X", 时间)
end

function 取年月日()
	return  os.date("%Y", 时间).."年"..os.date("%m", 时间).."月"..os.date("%d", 时间).."日 "
end

function 删除重复(key)
	local k;
	for i=1,#key do
		for j=i+1,#key do
			if(key[i] == key[j]) then
				key[i] = - 1
			end
		end
	end
	k = 1;
	for i=1, #key do
		if (key[k] == -1) then
			table.remove(key, k);k=k - 1
		end
		k=k+1
	end
	k = nil;
	return key
end
function 判断是否为小数(num)
	if math.floor(num)<num then
        return true
	end
	return false
end
function 取随机小数(x,y)
	return 取随机数(x*10000,y*10000)/10000
end
function 取随机小数2(x,y)
	return 取随机数(x*1000,y*1000)/1000
end


function 生成XY(x,y)
	local f ={}
	f.x = tonumber(x) or 0
	f.y = tonumber(y) or 0
	setmetatable(f,{
	__add = function (a,b)
		return 生成XY(a.x + b.x,a.y + b.y)
	end,
	__sub = function (a,b)
		return 生成XY(a.x - b.x,a.y - b.y)
	end
	})
	return f
end

function 取两点距离(src,dst)
		return math.sqrt(math.pow(src.x-dst.x,2) + math.pow(src.y-dst.y,2))
end

function 取两点距离a(x, y, x1, y1)
	return math.sqrt(math.pow(x - x1, 2) + math.pow(y - y1, 2))
end
function 取两点孤度(src,dst)
		local pi = math.pi
		local pi2 = pi*2
	if(dst.y ==src.y and dst.x==src.x)then
		return 0
	elseif(dst.y >=src.y and dst.x<=src.x)then
		return pi-math.abs(math.atan((dst.y-src.y)/(dst.x-src.x)))
	elseif(dst.y <=src.y and dst.x>=src.x)then
		return pi2-math.abs(math.atan((dst.y-src.y)/(dst.x-src.x)))
	elseif(dst.y <=src.y and dst.x<=src.x)then
		return math.atan((dst.y-src.y)/(dst.x-src.x))+pi

	elseif(dst.y >=src.y and dst.x>=src.x)then
		return math.atan((dst.y-src.y)/(dst.x-src.x))
	end
end
function 取距离坐标(xy,r,a) --r距离,a孤度
		local xys = 生成XY
		local cos = math.cos
		local sin = math.sin
		local floor = math.floor
		local x1,y1 = 0,0
		x1=r* cos(a) + xy.x
		y1=r* sin(a) + xy.y
		return xys(floor(x1),floor(y1))
end

function 读csv数据( str,reps )
	local resultStrList = {}
	string.gsub(str,'[^'..reps..']+',function ( w )
			table.insert(resultStrList,w)
	end)
	return resultStrList
end
--用于获取csv表
function 取csv数据(filePath)
	-- 读取文件
	local data = 读入文件(filePath)
	-- 按行划分
	local lineStr = 读csv数据(data, '\n\r')
	local titles = string.split(lineStr[1], ",")
	local returntable = {}
	for i=2,#lineStr do
			local cursor = string.split(lineStr[i], ",")
			returntable[tonumber(cursor[1]) or cursor[1]] = {}
			for n=2,#titles do
					if cursor[n] ~= "" then
						if cursor[n] == "真" then
							returntable[tonumber(cursor[1]) or cursor[1]][tonumber(titles[n]) or titles[n]]= true
						elseif cursor[n] == "假" then
							returntable[tonumber(cursor[1]) or cursor[1]][tonumber(titles[n]) or titles[n]]= false
						else
							if #string.split(cursor[n], "|") >=2 then
								local lsb = string.split(cursor[n], "|")
								if #string.split(lsb[1], "=") ==2 then
									local lsb2 = {}
									for i=1,#lsb do
										local lsb3 = string.split(lsb[i], "=")
										if lsb3[2] == "true" then
											lsb3[2] = true
										end
										if lsb3[2] == "false" then
											lsb3[2] = false
										end
										lsb2[lsb3[1]]=tonumber(lsb3[2]) or lsb3[2]
									end
									returntable[tonumber(cursor[1]) or cursor[1]][tonumber(titles[n]) or titles[n]] = lsb2
								else
									local lsb2 = {}
									for i=1,#lsb do
										if lsb[i]  ~= "" then
											table.insert(lsb2,tonumber(lsb[i]) or lsb[i])
										end
									end
									returntable[tonumber(cursor[1]) or cursor[1]][tonumber(titles[n]) or titles[n]] = lsb2
								end
							else
								returntable[tonumber(cursor[1]) or cursor[1]][tonumber(titles[n]) or titles[n]]= tonumber(cursor[n]) or cursor[n]
							end
						end
					else
						returntable[tonumber(cursor[1]) or cursor[1]][tonumber(titles[n]) or titles[n]]= nil
					end
			end
	end
	return returntable
end

技能信息= 取csv数据("sql/技能信息.csv")
战斗法术技能= 取csv数据("sql/战斗技能.csv")

function table_copy_table(ori_tab)
	if (type(ori_tab) ~= "table") then
		return nil
	end
	local new_tab = {}
	for i,v in pairs(ori_tab) do
		local vtyp = type(v)
		if (vtyp == "table") then
			new_tab[i] = table_copy_table(v)
		elseif (vtyp == "thread") then
			new_tab[i] = v
		elseif (vtyp == "userdata") then
			new_tab[i] = v
		else
			new_tab[i] = v
		end
	end
	return new_tab
end

function 取偶数(num)
    return num%2==0
end

