-- @Author: baidwwy
-- @Date:   2023-10-25 19:03:14
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-08-26 14:07:02
function 取id组(id)
	local id组={}
	if 玩家数据[id].队伍==0 then
		id组[1]=id
	else
		local 队伍id=玩家数据[id].队伍
		for n=1,#队伍数据[队伍id].成员数据 do
		 id组[n]=队伍数据[队伍id].成员数据[n]
		end
	end
	return id组
end

function 取队伍人数(id)
	if 玩家数据[id].队伍==0 then
		return 1
	else
		return #队伍数据[玩家数据[id].队伍].成员数据
	end
end
function 移动文件1(购买,目标,id,目标id)
  local 临时 = 取文件夹内所有文件名 (程序目录..[[\data\]]..目标..[[\]]..目标id)
  lfs.mkdir([[data/]]..购买..[[/]]..目标id)
  lfs.mkdir([[data/]]..购买..[[/]]..目标id..[[/]]..[[日志记录]])
  for i=1,#临时 do
       copyfile(程序目录..[[\data\]]..目标..[[\]]..目标id..[[\]]..临时[i],程序目录..[[\data\]]..购买..[[\]]..目标id..[[\]]..临时[i])
       os.remove(程序目录..[[\data\]]..目标..[[\]]..目标id..[[\]]..临时[i])
  end
  local 临时 = 取文件夹内所有文件名 (程序目录..[[\data\]]..目标..[[\]]..目标id..[[\日志记录]])
  for i=1,#临时 do
       copyfile(程序目录..[[\data\]]..目标..[[\]]..目标id..[[\日志记录\]]..临时[i],程序目录..[[\data\]]..购买..[[\]]..目标id..[[\日志记录\]]..临时[i])
       os.remove(程序目录..[[\data\]]..目标..[[\]]..目标id..[[\日志记录\]]..临时[i])
  end
  os.execute("rd "..[[data\]]..目标..[[\]]..目标id..[[\日志记录]])
  os.execute("rd "..[[data\]]..目标..[[\]]..目标id)
end
function copyfile(source,destination)
    local sourcefile = io.open(source, "r")
    local destinationfile = io.open(destination, "w")
    destinationfile:write(sourcefile:read("*all"))
    sourcefile:close()
    destinationfile:close()
end
function 取队员任务存在(队伍id,类型)
  if 队伍数据[队伍id]==nil then return false end
  for n=1,#队伍数据[队伍id].成员数据 do
    if 玩家数据[队伍数据[队伍id].成员数据[n]].角色:取任务(类型)~=0 then
      return true
    end
  end
  return false
end
function 取文件夹内所有文件名 (path)
  local z={}
  for file in lfs.dir(path) do
    if file ~= "." and file ~= ".." then
      local f = path..'/'..file
      local attr = lfs.attributes (f)
      assert (type(attr) == "table")
      if attr.mode == "file" then
         z[#z+1]=file
      end
    end
  end
  return z
end
function 取队长权限(id)
	if 玩家数据[id].队伍==0 then
		return true
	elseif 玩家数据[id].队长 then
		return true
	end
	return false
end

function 取唯一任务(类型,id)
	随机序列=随机序列+1
	if id~=nil then
		local bm = id.."_"..类型.."_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
	    if 玩家数据[id].队伍==0 then
			return bm,{id}
		else
			local fh={}
			for i=1,#队伍数据[玩家数据[id].队伍].成员数据 do
				if 队伍数据[玩家数据[id].队伍].成员数据[i]~=nil then
					fh[#fh+1]=队伍数据[玩家数据[id].队伍].成员数据[i]
				end
			end
			return bm,fh
		end
	end
	return "_"..类型.."_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
end

function 取个人唯一任务(类型,id)
	随机序列=随机序列+1
	if id~=nil then
		local bm = id.."_"..类型.."_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
	    return bm,{id}
	end
	return "_"..类型.."_"..os.time().."_"..随机序列.."_"..取随机数(88,99999999)
end

function 取队伍所有玩家名称(id)
	if id==nil then
		print("取队伍所有玩家名称时，有id为空值")
		return
	end
	if 玩家数据[id].队伍==0 then
		return 玩家数据[id].角色.名称
	else
		local 队伍id=玩家数据[id].队伍
		local fh=玩家数据[id].角色.名称
		for n=2,#队伍数据[队伍id].成员数据 do
			local cyid = 队伍数据[队伍id].成员数据[n]
			fh=fh.."、"..玩家数据[cyid].角色.名称
		end
		return fh
	end
end

function 队伍活动击杀判定(id,任务id)
	local id组 = 取id组(id)
	for i=1,#id组 do
		if 任务数据[任务id].参与组[id组[i]] ~= nil then
			return  false
		end
	end
	return true
end

function 取等级要求(id,等级)
	local id组={}
	if 玩家数据[id].队伍==0 then
		id组[1]=id
	else
		local 队伍id=玩家数据[id].队伍
		for n=1,#队伍数据[队伍id].成员数据 do
		 id组[n]=队伍数据[队伍id].成员数据[n]
		end
	end
	for n=1,#id组 do
		if 玩家数据[id组[n]].角色.等级<等级 then
			return false
		end
	end
	return true
end

function 取任务符合id(id,任务id)
	if 任务数据[任务id]==nil then return false end
	for n=1,#任务数据[任务id].队伍组 do
		if 任务数据[任务id].队伍组[n]==id then
			return true
		end
	end
	return false
end

function 广播队伍消息(队伍id,文本)
	for n=1,#队伍数据[队伍id].成员数据 do
		if 玩家数据[队伍数据[队伍id].成员数据[n]] then
			发送数据(玩家数据[队伍数据[队伍id].成员数据[n]].连接id,38,{内容=文本,频道="dw"})
		end
	end
	return false
end
function 广播队伍链接(队伍id,文本)
	for n=1,#队伍数据[队伍id].成员数据 do
		if 玩家数据[队伍数据[队伍id].成员数据[n]] then
			发送数据(玩家数据[队伍数据[队伍id].成员数据[n]].连接id,113,文本)
		end
	end
	return false
end

function 取门派示威对象(门派)
 local 示威对象={}
	for n, v in pairs(玩家数据) do
		if 玩家数据[n].角色.门派~="无" and 玩家数据[n].角色.门派~=门派 then
			示威对象[#示威对象+1]=n
		end
	end
	if #示威对象==0 then
		return
	else
		local 临时序列=取随机数(1,#示威对象)
		local id=示威对象[临时序列]
		return 玩家数据[id].角色:取地图数据()
	end
end

function 添加对话(id,名称,头像,对话,选项)
	发送数据(玩家数据[id].连接id,1501,{名称=名称,模型=头像,对话=对话,选项=选项})--,寄存数据
end

function 添加最后对话(id,对话,选项)--,寄存数据
	local mc=""
	local mx=""
	if 玩家数据[id].最后对话 and 玩家数据[id].最后对话.名称 then
	    mc=玩家数据[id].最后对话.名称
	    mx=玩家数据[id].最后对话.模型
	end
	发送数据(玩家数据[id].连接id,1501,{名称=mc,模型=mx,对话=对话,选项=选项})--,寄存=寄存数据
end

function 取队伍最低等级(队伍id,等级)
	for n=1,#队伍数据[队伍id].成员数据 do
		if 玩家数据[队伍数据[队伍id].成员数据[n]].角色.等级<等级 then
			return true
		end
	end
	return false
end

function 取队伍最高等级(队伍id,等级)
	if 队伍数据[队伍id] == nil then return  false end
	for n=1,#队伍数据[队伍id].成员数据 do
		if 玩家数据[队伍数据[队伍id].成员数据[n]].角色.等级>等级 then
			return true
		end
	end
	return false
end

function 取队伍平均等级(队伍id,id)
	if 队伍数据[队伍id]==nil then
		return 玩家数据[id].角色.等级
	end
	local 等级=0
	for n=1,#队伍数据[队伍id].成员数据 do
		等级=等级+玩家数据[队伍数据[队伍id].成员数据[n]].角色.等级
	end
	等级=math.floor(等级/#队伍数据[队伍id].成员数据)
	return 等级
end
function 取队伍最高等级数(队伍id,id)
	local t = {}
	if 队伍数据[队伍id]==nil then
		return 玩家数据[id].角色.等级
	end
	for n=1,#队伍数据[队伍id].成员数据 do
		t[n]=玩家数据[队伍数据[队伍id].成员数据[n]].角色.等级
	end
	table.sort(t)
	if t[#队伍数据[队伍id].成员数据]<10 then
		t[#队伍数据[队伍id].成员数据]=10
	end
	return t[#队伍数据[队伍id].成员数据]
end
function 取队伍任务(队伍id,rw)
	for n=1,#队伍数据[队伍id].成员数据 do
		if 玩家数据[队伍数据[队伍id].成员数据[n]].角色:取任务(rw)~=0 then
			return true
		end
	end
	return false
end

function 取队伍活动(队伍id,类型)
	for n=1,#队伍数据[队伍id].成员数据 do
		if 类型 == "国庆" then
			if 玩家数据[队伍数据[队伍id].成员数据[n]] and 玩家数据[队伍数据[队伍id].成员数据[n]].角色.国庆活动~=0 then
				return true
			end
		elseif 类型 == "中秋" then
			if 玩家数据[队伍数据[队伍id].成员数据[n]] and 玩家数据[队伍数据[队伍id].成员数据[n]].角色.中秋活动~=0 then
				return true
			end
		end
	end
	return false
end

function 队伍活动变更(队伍id,类型,进度)
	for n=1,#队伍数据[队伍id].成员数据 do
		if 类型 == "国庆" then
			if 玩家数据[队伍数据[队伍id].成员数据[n]].角色.国庆活动 <进度 then
				玩家数据[队伍数据[队伍id].成员数据[n]].角色.国庆活动=进度
				m:执行SQL(string.format("update user set gqhd = '%s' where  szid='%s'",进度,队伍数据[队伍id].成员数据[n]))
				发送数据(玩家数据[队伍数据[队伍id].成员数据[n]].连接id,234,{类型=1,进度=进度})
			end
		elseif 类型 == "中秋" then
			if 玩家数据[队伍数据[队伍id].成员数据[n]].角色.中秋活动 <进度 then
				玩家数据[队伍数据[队伍id].成员数据[n]].角色.中秋活动=进度
				 m:执行SQL(string.format("update user set zqhd = '%s' where  szid='%s'",进度,队伍数据[队伍id].成员数据[n]))
				发送数据(玩家数据[队伍数据[队伍id].成员数据[n]].连接id,234,{类型=2,进度=进度})
			end
		end
	end
end
function 取地宫挑战模型1(层数)
  if 层数 <= 2 then
    return {"觉醒涂山雪"}
  elseif 层数 == 3 then
    return {"火月蛙"}
  elseif 层数 == 4 then
    return {"天机虫"}
  elseif 层数 == 5 then
    return {"进阶金翼"}
  elseif 层数 == 6 then
    return {"进阶司雨"}
  elseif 层数 == 7 then
    return {"黑熊"}
  elseif 层数 == 8 then
    return {"老虎"}
  elseif 层数 == 9 then
    return {"野鬼"}
  elseif 层数 == 10 then
    return {"超级恶魔泡泡"}
  elseif 层数 == 11 then
    return {"牛头"}
  elseif 层数 == 12 then
    return {"马面"}
  elseif 层数 == 13 then
    return {"古代瑞兽"}
  elseif 层数 == 14 then
    return {"雷鸟人"}
  elseif 层数 == 15 then
    return {"蝴蝶仙子"}
  elseif 层数 == 16 then
    return {"白熊"}
  elseif 层数 == 17 then
    return {"黑山老妖"}
  elseif 层数 == 18 then
    return {"天兵"}
  elseif 层数 == 19 then
    return {"天将"}
  elseif 层数 == 20 then
    return {"超级泡泡"}
  elseif 层数 == 21 then
    return {"风伯"}
  elseif 层数 == 22 then
    return {"凤凰"}
  elseif 层数 == 23 then
    return {"碧水夜叉"}
  elseif 层数 == 24 then
    return {"蚌精"}
  elseif 层数 == 25 then
    return {"鲛人"}
  elseif 层数 == 26 then
    return {"蛟龙"}
  elseif 层数 == 27 then
    return {"巡游天神"}
  elseif 层数 == 28 then
    return {"芙蓉仙子"}
  elseif 层数 == 29 then
    return {"星灵仙子"}
  elseif 层数 == 30 then
    return {"沙暴"}
  elseif 层数 == 31 then
    return {"冰月蛙"}
  elseif 层数 == 32 then
    return {"千年蛇魅"}
  elseif 层数 == 33 then
    return {"百足将军"}
  elseif 层数 == 34 then
    return {"犀牛将军人形"}
  elseif 层数 == 35 then
    return {"犀牛将军兽形"}
  elseif 层数 == 36 then
    return {"野猪精"}
  elseif 层数 == 37 then
    return {"鼠先锋"}
  elseif 层数 == 38 then
    return {"泪妖"}
  elseif 层数 == 39 then
    return {"镜妖"}
  elseif 层数 == 40 then
    return {"雷龙"}
  elseif 层数 == 41 then
    return {"律法女娲"}
  elseif 层数 == 42 then
    return {"炎魔神"}
  elseif 层数 == 43 then
    return {"画魂"}
  elseif 层数 == 44 then
    return {"灵符女娲"}
  elseif 层数 == 45 then
    return {"吸血鬼"}
  elseif 层数 == 46 then
    return {"巴蛇"}
  elseif 层数 == 47 then
    return {"净瓶女娲"}
  elseif 层数 == 48 then
    return {"踏云兽"}
  elseif 层数 == 49 then
    return {"龙龟"}
  elseif 层数 == 50 then
    return {"自在心猿"}
  elseif 层数 == 51 then
    return {"夜罗刹"}
  elseif 层数 == 52 then
    return {"连弩车"}
  elseif 层数 == 53 then
    return {"琴仙"}
  elseif 层数 == 54 then
    return {"机关兽"}
  elseif 层数 == 55 then
    return {"超级神狗"}
  elseif 层数 == 56 then
    return {"进阶月魅"}
  elseif 层数 == 57 then
    return {"猫灵人形"}
  elseif 层数 == 58 then
    return {"猫灵兽形"}
  elseif 层数 == 59 then
    return {"狂豹人形"}
  elseif 层数 == 60 then
    return {"觉醒涂山雪"}
  elseif 层数 == 61 then
    return {"蝎子精"}
 elseif 层数 == 62 then
    return {"进阶凤凰"}
  elseif 层数 == 63 then
    return {"进阶碧水夜叉"}
  elseif 层数 == 64 then
    return {"进阶蚌精"}
  elseif 层数 == 65 then
    return {"进阶鲛人"}
  elseif 层数 == 66 then
    return {"进阶蛟龙"}
  elseif 层数 == 67 then
    return {"进阶巡游天神"}
  elseif 层数 == 68 then
    return {"进阶芙蓉仙子"}
  elseif 层数 == 69 then
    return {"进阶星灵仙子"}
  elseif 层数 == 70 then
    return {"超级飞廉"}
  elseif 层数 == 71 then
    return {"进阶锦毛貂精"}
  elseif 层数 == 72 then
    return {"进阶千年蛇魅"}
  elseif 层数 == 73 then
    return {"进阶百足将军"}
  elseif 层数 == 74 then
    return {"进阶犀牛将军人形"}
  elseif 层数 == 75 then
    return {"进阶犀牛将军兽形"}
  elseif 层数 == 76 then
    return {"进阶野猪精"}
  elseif 层数 == 77 then
    return {"进阶鼠先锋"}
  elseif 层数 == 78 then
    return {"进阶泪妖"}
  elseif 层数 == 79 then
    return {"进阶镜妖"}
  elseif 层数 == 80 then
    return {"进阶阴阳伞"}
  elseif 层数 == 81 then
    return {"进阶律法女娲"}
  elseif 层数 == 82 then
    return {"进阶炎魔神"}
  elseif 层数 == 83 then
    return {"进阶画魂"}
  elseif 层数 == 84 then
    return {"进阶灵符女娲"}
  elseif 层数 == 85 then
    return {"进阶吸血鬼"}
  elseif 层数 == 86 then
    return {"进阶巴蛇"}
  elseif 层数 == 87 then
    return {"进阶净瓶女娲"}
  elseif 层数 == 88 then
    return {"进阶踏云兽"}
  elseif 层数 == 89 then
    return {"进阶龙龟"}
  elseif 层数 == 90 then
    return {"进阶红萼仙子"}
  elseif 层数 == 91 then
    return {"进阶噬天虎"}
  elseif 层数 == 92 then
    return {"进阶灵鹤"}
  elseif 层数 == 93 then
    return {"进阶大力金刚"}
  elseif 层数 == 94 then
    return {"进阶机关鸟"}
  elseif 层数 == 95 then
    return {"进阶鬼将"}
  elseif 层数 == 96 then
    return {"进阶葫芦宝贝"}
  elseif 层数 == 97 then
    return {"超级红孩儿"}
  elseif 层数 == 98 then
    return {"进阶幽灵"}
  elseif 层数 == 99 then
    return {"进阶幽萤娃娃"}
  elseif 层数 == 100 then
    return {"进阶谛听"}
  elseif 层数 == 101 then
    return {"进阶夜罗刹"}
  elseif 层数 == 102 then
    return {"进阶连弩车"}
  elseif 层数 == 103 then
    return {"进阶琴仙"}
  elseif 层数 == 104 then
    return {"进阶机关兽"}
  elseif 层数 == 105 then
    return {"进阶自在心猿"}
  elseif 层数 == 106 then
    return {"进阶混沌兽"}
  elseif 层数 == 107 then
    return {"进阶猫灵人形"}
  elseif 层数 == 108 then
    return {"进阶猫灵兽形"}
  elseif 层数 == 109 then
    return {"进阶狂豹人形"}
  elseif 层数 == 110 then
    return {"进阶狂豹人形"}
  elseif 层数 == 111 then
    return {"进阶蝎子精"}
  elseif 层数 == 112 then
    return {"进阶金翼"}
  elseif 层数 == 113 then
    return {"进阶金翼"}
  elseif 层数 == 114 then
    return {"进阶金翼"}
  elseif 层数 == 115 then
    return {"进阶金翼"}
  elseif 层数 == 116 then
    return {"进阶金翼"}
  elseif 层数 == 117 then
    return {"进阶金翼"}
  elseif 层数 == 118 then
    return {"进阶蝎子精"}
  elseif 层数 == 119 then
    return {"进阶金翼"}
  elseif 层数 == 120 then
    return {"进阶金翼"}
  else
    return {"进阶谛听"}
  end
end