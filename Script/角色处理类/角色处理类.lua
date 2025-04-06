-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:44
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-04-05 18:09:21

local 角色处理类 = class()
local jnzbzz = require("script/角色处理类/技能类")
local floor = math.floor
local ceil = math.ceil
local insert = table.insert
local remove = table.remove
local tp
local 属性类型 = {"体质", "魔力", "力量", "耐力", "敏捷"}
local JSzbsx = {"伤害","灵力","防御","气血","魔法","命中","躲避","速度","愤怒","体质","力量","耐力","魔力","敏捷","物伤结果","固定伤害","气血回复效果","法术伤害结果","法伤结果","法术防御","法术伤害"}
local 可入门派 = {
	仙 = {天宫 = 1, 龙宫 = 1, 女 = {普陀山 = 1, }, 男 = {五庄观 = 1}, 凌波城 = 1, 花果山 = 1},
	魔 = {魔王寨 = 1, 阴曹地府 = 1, 女 = {盘丝洞 = 1, }, 男 = {狮驼岭 = 1}, 无底洞 = 1},
	人 = {大唐官府 = 1, 方寸山 = 1, 女 = {女儿村 = 1, }, 男 = {化生寺 = 1}, 神木林 = 1}
}
local 战斗无需加载={
		运行父函数=1,
		存档数据=1,
		日志内容=1,
		五宝数据=1,
		在线时间=1,
		技能属性=1,
		额外技能属性=1,
		行囊=1,
		临时包裹=1,
		坐骑列表=1,
		系统设置=1,
		可选门派=1,
		装备属性=1,
		人物技能=1,
		道具=1,
		加点方案=1,
		坐骑=1,
		坐骑=1,
		成长礼包=1,
		行走监测=1,
		武器数据=1,
		灵饰=1,
		辅助技能=1,
		任务=1,
		坐骑属性=1,
		快捷技能=1,
		捉鬼数据=1,
		鬼王数据=1,
		杜少海数据=1,
		官职数据=1,
		剧情=1,
		秘制食谱=1,
		改名=1,
		运镖数据=1,
		师门数据=1,
		地图数据=1,
		神器积分=1,
		当前经验=1,
		上次退出=1,
		任务包裹=1,
		日志编号=1,
		剧情点=1,
		押镖间隔=1,
		附加潜力=1,
		好友数据=1,
		可持有武器=1,
		特殊技能=1,
		剧情技能=1,
	}

function 角色处理类:初始化(id, ip)
	self.连接id = id
	self.连接ip = ip
	self.等级 = 0
	self.名称 = ""
	self.性别 = 0
	self.模型 = ""
	self.种族 = ""
	self.称谓 = {}
	self.当前称谓 = ""
	self.BPMC = "无帮派"
	self.BG = 0
	self.门派 = "无门派"
	self.人气 = 700
	self.门贡 = 0
	self.气血 = 0
	self.气血上限 = 0
	self.最大气血 = 0
	self.魔法 = 0
	self.最大魔法 = 0
	self.愤怒 = 0
	self.活力 = 0
	self.体力 = 0
	self.命中 = 0
	self.伤害 = 0
	self.武器伤害 = 0
	self.防御 = 0
	self.速度 = 0
	self.躲避 = 0
	self.灵力 = 0
	self.法术伤害 = 0
	self.法术防御 = 0
	self.法伤 = 0
	self.法防 = 0
	self.体质 = 0
	self.魔力 = 0
	self.力量 = 0
	self.耐力 = 0
	self.敏捷 = 0
	self.潜力 = 5
	self.侵蚀 = {刻骨 = false, 钻心 = false, 噬魂 = false}
	self.历劫 = {女娲 = false, 飞升 = false, 渡劫 = false, 化圣 = false}
	self.造化 = 0
	self.修炼 = {攻击修炼 = {0, 0, 0}, 法术修炼 = {0, 0, 0}, 防御修炼 = {0, 0, 0}, 抗法修炼 = {0, 0, 0}, 猎术修炼 = {0, 0, 0}, 当前 = "攻击修炼"}
	self.bb修炼 = {攻击控制力 = {0, 0, 0}, 法术控制力 = {0, 0, 0}, 防御控制力 = {0, 0, 0}, 抗法控制力 = {0, 0, 0}, 当前 = "攻击控制力"}
	self.最大体力 = 100
	self.最大活力 = 100
	self.当前经验 = 28077565 ---正好69
	self.最大经验 = 0
	-- self.宝宝列表 = {}
	self.子女列表 = {}
	self.参战宝宝 = {}
	self.可选门派 = {}
	self.装备 = {}
	self.灵饰 = {}
	self.法宝 = {}
	self.锦衣 = {}
	self.灵宝 = {}
	self.灵宝佩戴 = {}
	-- self.神器 = {}
	self.法宝佩戴 = {}
	self.师门技能 = {}
	self.人物技能 = {}
	self.特殊技能 = {}
	self.辅助技能 = {}
	self.强化技能 = {}
	-- self.战斗技能 = {}
	self.快捷技能 = {}
	self.染色方案 = 0
	self.染色组 = {}
	self.装备属性 = {伤害=0,治疗能力=0,灵力=0,防御=0,气血=0,魔法=0,命中=0,躲避=0,速度=0,愤怒=0,体质=0,力量=0,耐力=0,魔力=0,敏捷=0,物伤结果=0,气血回复效果=0,法术伤害结果=0,法术防御=0,法术伤害=0}
	-- self.装备属性 = {伤害=0,灵力=0,防御=0,气血=0,魔法=0,命中=0,躲避=0,速度=0,愤怒=0,体质=0,力量=0,耐力=0,魔力=0,敏捷=0,物伤结果=0,气血回复效果=0,法术伤害结果=0,法术防御=0,法术伤害=0}--新版本
	self.QYD={已用乾元丹=0,可用乾元丹=0,已换乾元丹=0,可换乾元丹=0,额外乾元丹=0}--新版本
	self.技能属性 = {气血 = 0, 魔法 = 0, 命中 = 0, 伤害 = 0, 防御 = 0, 速度 = 0, 躲避 = 0, 灵力 = 0, 体质 = 0, 魔力 = 0, 力量 = 0, 耐力 = 0, 敏捷 = 0}
	self.神器属性 = {速度=0,法术防御=0,防御=0,气血=0,伤害=0,法术伤害=0,固定伤害=0,治疗能力=0,法术暴击等级=0,物理暴击等级=0,封印命中等级=0,抵抗封印等级=0}
	self.加点方案 = {{体质=0,魔力=0,力量=0,耐力=0,敏捷=0,潜力=0}}
	self.奇经八脉 = {}
	self.变身 = {}
	self.默认技能 = nil
	self.可持有武器 = nil
	self.自动 = nil
	self.在线时间 = {小时 = 0, 分 = 0, 秒 = 0, 累积 = 0, 计算分 = 0, 活力 = 0, 体力 = 0}
	self.剧情点 = {当前=0,总额=0}
	self.官职点 = 0
	self.五宝数据 = {夜光珠 = 0, 龙鳞 = 0, 定魂珠 = 0, 避水珠 = 0, 金刚石 = 0}
	self.套装 = {}
	self.额外法宝等级 = {}
	self.额外技能等级 = {}
	self.好友数据 = {好友 = {}, 临时 = {}, 最近 = {}, 黑名单 = {}}
	self.剧情 = {}
	self.坐骑列表 = {}
	self.器灵效果={金蝉=0,无双=0}
	self.坐骑 = nil
	self.洗点次数 = 0
	self.上次退出 = 0 --这个到时候可以清除长时间未在线的玩家
	self.发言特效 = 0
	-- self.传音特效 = 0
	self.队标特效 = "无"
	self.姻缘 = {婚姻 = false, 结婚日期 = nil, 配偶 = nil, 房屋所属ID = nil}

	self.召唤兽携带上限 = 8
	-- if ip == "1.1.1.1" then
	-- 	 self.召唤兽携带上限 = 8
	-- end

	self.招式特效 = {}
	self.改名 = {曾用名={},次数=0,时间=os.time()-2592000}
	self.临时包裹 = {}
	self.任务包裹 = {}
	self.秘制食谱 = {材料=0,食谱={}}
	self.靓号 = {时间=0,ID=0,类型=0}
	-- self.行走监测 = {时间=os.time(),行走=false}
	self.系统设置={音乐开启=true,音效开启=true,音乐音量=80,音效音量=80,显示变身卡造型=true,连点模式=false,允许查看装备=true,显示坐骑=true,显示锦衣光环足迹=true} --,显示祥瑞=true ,地图特效=true,允许组队=true,允许加好友=true,允许查看装备=true
	self.捉鬼数据={次数=0,总次数=0,间隔=0}
	self.自动抓鬼={次数=0,领取日期=0}
	self.鬼王数据={次数=0,总次数=0,间隔=0}
	self.师门数据={次数=0,间隔=0}
	self.运镖数据={次数=0,总次数=0,间隔=0}
	self.官职数据={次数=0,总次数=0,间隔=0}
	self.杜少海数据={次数=0,间隔=0}
	self.十八路妖王={黄风怪=1}
	self.通天塔数量=0
	self.仙玉 = 0
	-- if 调试模式 then
	--    self.仙玉=1
	-- end
	self.副本积分 = 0
	self.活跃度 = 0
	self.神器积分 = 0
	self.剑会积分 = 0
	self.活动积分 = 0
	self.储备灵气 = 0
	self.安卓快捷施法={}
	self.玄灵珠={类型="回春",破军=0,回春=0,空灵=0,噬魂=0}
	self.修业 ={一="无",二="无",三="无",四="无",五="无",组合="无",开启=false,等级=0}
end

function 角色处理类:清空任务() --武神坛
	for n, v in pairs(self.任务) do
		if 任务数据[v] ~= nil then
			self.任务[n] = nil
		end
	end
end

function 角色处理类:创建武神坛角色(id, 账号, 模型, 名称, ip, 染色ID,假人id,武神坛id,数字id) --武神坛,若手动删号【全武神坛id.txt】里的id也要删
	local ms = 模型
	local ls = self:队伍角色(ms)
	local cw=""
	self.主角=true
	self.ID = 武神坛id
	self.数字id = 武神坛id
	self.名称 = 名称
	self.性别 = ls.性别
	self.账号 = 账号
	self.ip = ip
	self.模型 = ls.模型
	self.称谓 = {
		cw
	}


	self.当前称谓 = cw
	self.队标特效 = "无"
	self.储备 = 0
	self.银子 = 0
	self.套装激活 = 0
	self.套装名称 = "无"


	self.仙玉 = 0
	self.存银 = 0
	self.道具 = {}
	self.坐骑 = nil
	self.快捷技能 = {}
	self.行囊 = {}
	self.阵法 = {普通 = 1}
	self.出生日期 = os.time()
	self.造型 = ls.模型
	self.地图数据 = {编号 = 1003, x = 400, y = 500,方向=0}
	self.种族 = ls.种族
	self.可选门派 = ls.门派
	self.武器数据 = {名称 = "", 子类 = "", 等级 = 0}
	self.染色组 = {[1] = math.ceil(染色ID), [2] = math.ceil(染色ID), [3] = math.ceil(染色ID)} or {0, 0, 0}
	self.奇经八脉 = {}
	self.染色方案 = ls.染色方案
	self.任务 = {}
	self.历劫 = {女娲 = false, 飞升 = false, 渡劫 = false, 化圣 = false}
	self.可持有武器 = ls.武器
	self.宠物 = {模型 = "生肖龙", 名称 = "生肖龙", 等级 = 1, 最大等级 = 120, 耐力 = 5, 最大耐力 = 5, 经验 = 1, 最大经验 = 10, 领养次数 = 0}
	local cs = self:取初始属性(self.种族)
	self.体质 = cs[1]
	self.魔力 = cs[2]
	self.力量 = cs[3]
	self.耐力 = cs[4]
	self.敏捷 = cs[5]
	self.武器伤害 = 0
	-- self.新号创建 = 1
	self.神坛币 = 0 --货币

	self.剧情 = {}
	self.成长礼包={礼包一=false,礼包二=false,礼包三=false,礼包四=false,礼包五=false}
	self.附加潜力 = {潜能果=0}
	self.坐骑列表 = {}
	self.玄灵珠={类型="回春",破军=10,回春=10,空灵=10,噬魂=10}------------------------------------`1`
	self.QYD={已用乾元丹=0,可用乾元丹=9,已换乾元丹=9,可换乾元丹=0,额外乾元丹=0}
	for n = 1, #灵饰战斗属性 do
		self[灵饰战斗属性[n]] = 0
	end
	self.剧情技能 = {}
	local fz = self:取辅助技能()
	for i = 1, #fz do
		local 辅助技能 = jnzbzz()
		辅助技能:置对象(fz[i])
		辅助技能.等级 = 0
		insert(self.辅助技能, 辅助技能)
	end
	local fz = self:取强化技能()
	for i = 1, #fz do
		local 强化技能 = jnzbzz()
		强化技能:置对象(fz[i])
		强化技能.等级 = 0
		insert(self.强化技能, 强化技能)
	end
		self.wst对应id = 数字id
		self.武神坛角色=true
		self.等级=175
		self.当前经验 = 29999999999
    self.最大经验 = 29999999999
    self.历劫.化圣 = true
    self.历劫.飞升 = true
    self.历劫.渡劫 = true
    self.历劫.化圣境界 = 10
    for an=1,3 do
      self.修炼.防御修炼[an]=25
      self.修炼.抗法修炼[an]=25
      self.修炼.法术修炼[an]=25
      self.修炼.攻击修炼[an]=25
      self.bb修炼.法术控制力[an]=25
      self.bb修炼.防御控制力[an]=25
      self.bb修炼.攻击控制力[an]=25
      self.bb修炼.抗法控制力[an]=25
    end
    for an=1,#self.辅助技能 do
      self.辅助技能[an].学会=true
      self.辅助技能[an].等级=160
      if self.辅助技能[an].名称=="神速" or self.辅助技能[an].名称=="强壮" then
        self.辅助技能[an].等级=60
      end
    end
    for an=1,#self.强化技能 do
      self.强化技能[an].学会=true
      self.强化技能[an].等级=180
    end




  self.体质 = 10 + self.等级
	self.魔力 = 10 + self.等级
	self.力量 = 10 + self.等级
	self.耐力 = 10 + self.等级
	self.敏捷 = 10 + self.等级
	self.潜力 = self.等级 * 5 + 5
	if self.历劫.飞升 == true then
		self.潜力 = self.潜力 + 10
	end
	if self.历劫.渡劫 == true then
		self.潜力 = self.潜力 + 25
	end
	self.潜力 = self.潜力 + self.附加潜力.潜能果
	self.气血 = self.最大气血
	self.气血上限 =self.最大气血
	self.魔法 = self.最大魔法
	-- self:刷新信息("0")
	lfs.mkdir([[data/]]..账号..[[/]]..self.数字id)
	lfs.mkdir([[data/]]..账号..[[/]]..self.数字id..[[/日志记录]])
	self.日志编号=1
	self.日志内容="日志创建"
	写出文件([[data/]]..账号..[[/]]..self.数字id..[[/日志记录]]..[[/1.txt]],"日志创建\n")
	self:存档(ip)
end
---------------------------------------------------
---------------------------------------------------

function 角色处理类:创建角色(id, 账号, 模型, 名称, ip, 染色ID,假人id)
	local ms = 模型
	local ls = self:队伍角色(ms)
	local cw=""
	-- if RpbARGB.序列==3 then
	-- 	 cw="初入江湖"
	-- end
	if 假人id ==nil then
	全局角色id=全局角色id+1
	f函数.写配置(程序目录.."配置文件.ini","主要配置","id",全局角色id)
	self.ID = 全局角色id
	self.数字id = 全局角色id
	else
	self.ID = 假人id
	self.数字id = 假人id
  end
	self.名称 = 名称
	self.性别 = ls.性别
	self.账号 = 账号
	self.ip = ip
	self.模型 = ls.模型
	self.称谓 = {
		cw
	}
	self.当前称谓 = cw
	self.队标特效 = "无"
	self.储备 = 100000000
	self.银子 = 200000
	self.存银 = 0
	self.仙玉 = 0
	self.点卡 = 0
	self.道具 = {}
	self.坐骑 = nil
	self.快捷技能 = {}
	self.行囊 = {}
	self.阵法 = {普通 = 1}
	self.出生日期 = os.time()
	self.造型 = ls.模型
	self.地图数据 = {编号 = 1003, x = 400, y = 500,方向=0}--{编号=1501,x=420,y=60}
	self.种族 = ls.种族
	self.可选门派 = ls.门派
	self.武器数据 = {名称 = "", 子类 = "", 等级 = 0}
	self.染色组 = {[1] = math.ceil(染色ID), [2] = math.ceil(染色ID), [3] = math.ceil(染色ID)} or {0, 0, 0}
	self.奇经八脉 = {}
	self.染色方案 = ls.染色方案
	self.任务 = {}
	self.历劫 = {飞升 = false, 渡劫 = false, 化圣 = false}
	self.侵蚀 = {刻骨 = false, 钻心 = false, 噬魂 = false}
	self.造化 = 0
	self.可持有武器 = ls.武器
	-- self.道具仓库 = {[1] = {}, [2] = {}, [3] = {}}
	-- self.召唤兽仓库 = {[1] = {}}
	self.宠物 = {模型 = "生肖龙", 名称 = "生肖龙", 等级 = 1, 最大等级 = 120, 耐力 = 5, 最大耐力 = 5, 经验 = 1, 最大经验 = 10, 领养次数 = 0}
	local cs = self:取初始属性(self.种族)
	self.体质 = cs[1]
	self.魔力 = cs[2]
	self.力量 = cs[3]
	self.耐力 = cs[4]
	self.敏捷 = cs[5]
	self.武器伤害 = 0
	self.月饼 = 0
	self.套装激活 = 0
	self.套装名称 = "无"
	self.新号创建 = 1
	self.剧情 = {主线 = 1, 编号 = 19, 地图 = 1003, 进度 = 1, 附加 = {}}
	self.成长礼包={礼包一=false,礼包二=false,礼包三=false,礼包四=false,礼包五=false}
	self.附加潜力 = {潜能果=0}
	self.坐骑列表 = {}
	self.玄灵珠={类型="回春",破军=0,回春=0,空灵=0,噬魂=0}
	for n = 1, #灵饰战斗属性 do
		self[灵饰战斗属性[n]] = 0
	end
	self.剧情技能 = {}
	local fz = self:取辅助技能()
	for i = 1, #fz do
		local 辅助技能 = jnzbzz()
		辅助技能:置对象(fz[i])
		辅助技能.等级 = 0
		insert(self.辅助技能, 辅助技能)
	end
	local fz = self:取强化技能()
	for i = 1, #fz do
		local 强化技能 = jnzbzz()
		强化技能:置对象(fz[i])
		强化技能.等级 = 0
		insert(self.强化技能, 强化技能)
	end
--	self:刷新信息("0")--测试模式
	lfs.mkdir(程序目录..[[data/]]..账号..[[/]]..self.数字id)
	lfs.mkdir(程序目录..[[data/]]..账号..[[/]]..self.数字id..[[/日志记录]])
	self.日志编号=1
	self.日志内容="日志创建"
	写出文件([[data/]]..账号..[[/]]..self.数字id..[[/日志记录]]..[[/1.txt]],"日志创建\n")
	if f函数.文件是否存在(程序目录..[[data/]]..账号..[[/信息.txt]])==false then
		self.写入信息={[1]=self.数字id}
		写出文件([[data/]]..账号..[[/信息.txt]],table.tostring(self.写入信息))
	else
		self.写入信息=table.loadstring(读入文件(程序目录..[[data/]]..账号..[[/信息.txt]]))
		self.写入信息[#self.写入信息+1]=self.数字id
		写出文件([[data/]]..账号..[[/信息.txt]],table.tostring(self.写入信息))
		self.临时信息=nil
		self.临时数据=nil
		self.角色数量=nil
		self.角色信息=nil
	end
	-- if 调试模式 then
	-- 	 self.等级=0
	-- 	 self.银子=50000
	-- end
	-- if  then
	-- 	if f函数.读配置(程序目录..[[data\]]..账号..[[\账号信息.txt]],"账号配置","体验状态") == "0" then
	-- 	    self.体验状态=true
	-- 	end
	-- end
	self:存档(ip)
end
-- function 角色处理类:更新()
-- 	if self.在线时间.秒 < os.time()  then
-- 		self.在线时间.秒 = os.time() +60
-- 		self:增加在线时间()
-- 	end
-- end


function 角色处理类:增加在线时间()
	self.在线时间.分 = self.在线时间.分 + 1
	-- if 奖励数据.全服奖励[self.数字id] ~= nil then
	-- 	奖励数据.全服奖励[self.数字id].在线 = 奖励数据.全服奖励[self.数字id].在线 + 1
	-- end
	if self.在线时间.计算分 == nil then
		self.在线时间.计算分 = 0
	end
	self.在线时间.计算分 = self.在线时间.计算分 + 1
	if self.在线时间.计算分 >= 5 then--math.floor(self.在线时间.分/5)==self.在线时间.分/5
		self.活力 = self.活力 + math.floor(self.最大活力 * 0.02)
		self.体力 = self.体力 + math.floor(self.最大体力 * 0.02)
		if self.活力 > self.最大活力 then self.活力 = self.最大活力 end
		if self.体力 > self.最大体力 then self.体力 = self.最大体力 end
		if self.在线时间.活力 == nil then self.在线时间.活力 = self.活力 end
		if self.在线时间.体力 == nil then self.在线时间.体力 = self.体力 end
		if self.在线时间.活力 ~= self.最大活力 or self.在线时间.体力 ~= self.最大体力 then
			体活刷新(self.数字id)
		end
		self.在线时间.活力 = self.活力
		self.在线时间.体力 = self.体力
		self.在线时间.计算分 = 0
	end
	if self.在线时间.分 >= 60 then
		self.在线时间.分 = 0
		self.在线时间.小时 = self.在线时间.小时 + 1
		self.人气 = self.人气 + 10 -----------人气每小时+10
		if self.人气 > 800 then self.人气 = 800 end
	end
end

function 角色处理类:检查临时属性() --1小时33分检查
	local fso = false
	for n, v in pairs(self.装备) do --这个是穿戴的装备
		local 格子 = self.装备[n]
		if 玩家数据[self.数字id].道具.数据 and 玩家数据[self.数字id].道具.数据[格子] ~= nil then
			if 玩家数据[self.数字id].道具.数据[格子].临时附魔 ~= nil  then
				for k,v in pairs(玩家数据[self.数字id].道具.数据[格子].临时附魔) do
					if v.数值 and v.时间 < os.time() then
						玩家数据[self.数字id].道具.数据[格子].临时附魔[k] = nil
						 self:清除装备附魔属性(玩家数据[self.数字id].道具.数据[格子],玩家数据[self.数字id].道具.数据[格子].分类,k,v.数值)
						 常规提示(self.数字id,"#Y你装备上的附魔特效消失了！")
					end
				end
			end

			if 玩家数据[self.数字id].道具.数据[格子].临时效果 ~= nil  then
				for k,v in pairs(玩家数据[self.数字id].道具.数据[格子].临时效果) do
					if v.数值 and v.时间 < os.time() then
						玩家数据[self.数字id].道具.数据[格子].临时效果[k] = nil
						 self:清除装备附魔属性22(玩家数据[self.数字id].道具.数据[格子],玩家数据[self.数字id].道具.数据[格子].分类,k,v.数值)
						 常规提示(self.数字id,"#Y你装备上的附魔特效消失了！")
					end
				end
			end

			if 玩家数据[self.数字id].道具.数据[格子].耐久 ~= nil and 玩家数据[self.数字id].道具.数据[格子].耐久 <= 0 and 玩家数据[self.数字id].道具.数据[格子].刷新属性 == nil then
				self:清除装备属性(玩家数据[self.数字id].道具.数据[格子],玩家数据[self.数字id].道具.数据[格子].分类,"0")
				fso = true
			end
			if 玩家数据[self.数字id].道具.数据[格子].耐久 and 玩家数据[self.数字id].道具.数据[格子].耐久 <= 0 and 玩家数据[self.数字id].道具.数据[格子].刷新属性 == nil then
				玩家数据[self.数字id].道具.数据[格子].耐久=0
				local 道具格子=玩家数据[self.数字id].角色:取道具格子1("道具")
				if 道具格子~=0 and 玩家数据[self.数字id].道具.数据[格子] and 玩家数据[self.数字id].道具.数据[格子].分类 and 玩家数据[self.数字id].道具.数据[格子].分类<=6 then
					玩家数据[self.数字id].角色:卸下装备(玩家数据[self.数字id].道具.数据[格子],玩家数据[self.数字id].道具.数据[格子].分类)
					玩家数据[self.数字id].角色.装备[n]=nil
					玩家数据[self.数字id].角色["道具"][道具格子]=格子
					玩家数据[self.数字id].角色:刷新信息()
					玩家数据[self.数字id].道具:刷新道具行囊(self.数字id,"道具")
					发送数据(玩家数据[self.数字id].连接id,3503,玩家数据[self.数字id].角色:取装备数据())
					if n==3 then
						发送数据(玩家数据[self.数字id].连接id,3505)
						地图处理类:更新武器(self.数字id)
					end
					发送数据(玩家数据[self.数字id].连接id,12)
				end
				常规提示(self.数字id,"#Y你的装备耐久度不足请及时修理！")
			end
		end
	end
end

function 角色处理类:调试检查临时属性() --1小时一次 33  没用的
	local fso = false
	for n, v in pairs(self.装备) do --这个是穿戴的装备
		local 格子 = self.装备[n]
		if 玩家数据[self.数字id].道具.数据 and 玩家数据[self.数字id].道具.数据[格子] ~= nil then
			if 玩家数据[self.数字id].道具.数据[格子].临时附魔 ~= nil  then
				for k,v in pairs(玩家数据[self.数字id].道具.数据[格子].临时附魔) do
					if v.数值 then
						玩家数据[self.数字id].道具.数据[格子].临时附魔[k] = nil
						 self:清除装备附魔属性(玩家数据[self.数字id].道具.数据[格子],玩家数据[self.数字id].道具.数据[格子].分类,k,v.数值)
						 --玩家数据[self.数字id].道具.数据[格子].临时附魔[k] = nil
						 常规提示(self.数字id,"#Y你装备上的附魔特效消失了！")
					end
				end
			end
		end
	end
end

function 角色处理类:兑换潜能果()
	local 总数 = 0
	local 消耗经验 = self.附加潜力.潜能果 * 1500000+10000000
	if self.等级 >= 60 then
		总数 = 100
	end
	if self.等级 >= 90 then
		总数 = 150
	end
	if self.等级 > 155 and self.历劫.渡劫 then
		总数 = 200
	end
	if self.等级 > 170 and self.历劫.渡劫 then
		总数 = 300
	end
	local 可兑换 = 总数 - self.附加潜力.潜能果
	if 可兑换>0 then
		 if self:扣除经验(消耗经验) then
			self.附加潜力.潜能果=self.附加潜力.潜能果+1
				self.潜力=self.潜力+1
				常规提示(self.数字id,"兑换成功，你消耗了点"..消耗经验.."经验，你的潜能点增加了1点")
				--计算下一个
				消耗经验=self.附加潜力.潜能果 * 1500000+10000000
				可兑换=可兑换-1
				发送数据(玩家数据[self.数字id].连接id,6559,{可用经验=self.当前经验,下个经验=消耗经验,已食用潜能果=self.附加潜力.潜能果,剩余潜能果=可兑换})
		 else
				常规提示(self.数字id,"当前经验不足无法兑换下一个潜能果！")
			return
		 end
	else
		常规提示(self.数字id,"可兑换潜能果已达上限！")
	end
end

function 角色处理类:炼化乾元丹(id)
	if 调试模式 then
		self.QYD.可换乾元丹=100
		常规提示(self.数字id, "#W调试模式无视乾元丹数量！")
	else
			if self.QYD.可换乾元丹 < 1 then
					常规提示(self.数字id, "#Y/当前等级可兑换的乾元丹已达上限！")
		 			return
			end
	end
	local xh = self:兑换消耗()
	if next(xh) ~= nil then
		if self.当前经验 > xh.经验 and self.银子 > xh.金钱 then
			self.QYD.已换乾元丹 = self.QYD.已换乾元丹 + 1
			self.QYD.可用乾元丹 = self.QYD.可用乾元丹 + 1
			self.QYD.可换乾元丹 = self.QYD.可换乾元丹 - 1
			self.当前经验 = self.当前经验 - xh.经验
			self.银子 = self.银子 - xh.金钱
			local sj = {当前经验 = self.当前经验, 银子 = self.银子, 可用乾元丹 = self.QYD.可用乾元丹, 已换乾元丹 = self.QYD.已换乾元丹, 可换乾元丹 = self.QYD.可换乾元丹}
			发送数据(玩家数据[self.数字id].连接id, 203, sj)

		else
			发送数据(玩家数据[self.数字id].连接id,1501,{名称=取门派师父名称(self.门派),模型=取门派师父名称(self.门派),对话="学费和经验是不能少的#17。",选项=nil})
		end
	else
		常规提示(self.数字id, "#Y/你已经无法再兑换乾元丹了！")
	end
end

function 角色处理类:取可兑换乾元丹()
	local 数量=0
	if self.等级>=69 and self.等级<89 then
		数量=2
	elseif self.等级>=89 and self.等级<109 then
		数量=3
	elseif self.等级>=109 and self.等级<129 then
		数量=4
	elseif self.等级>=129 and self.等级<155 then
		数量=5
	elseif self.等级>=155 and self.等级<159 then
		数量=6
	elseif self.等级>=159 and self.等级<164 then
		数量=7
	elseif self.等级>=164 and self.等级<168 then
		数量=8
	elseif self.等级>=168 and self.等级<171 then
		数量=9
	elseif self.等级>=171 then
		数量=9
	end

	return 数量 - self.QYD.已换乾元丹
end

function 角色处理类:兑换消耗()
	local dj = self.QYD.已换乾元丹 + 1
	local fhz = {}
	if dj == 1 then
		fhz.经验 = 22340000
		fhz.金钱 = 5800000
	elseif dj == 2 then
		fhz.经验 = 27850000
		fhz.金钱 = 8000000
	elseif dj == 3 then
		fhz.经验 = 34350000
		fhz.金钱 = 10500000
	elseif dj == 4 then
		fhz.经验 = 42520000
		fhz.金钱 = 12500000
	elseif dj == 5 then
		fhz.经验 = 51920000
		fhz.金钱 = 13500000
	elseif dj == 6 then
		fhz.经验 = 62850000
		fhz.金钱 = 14500000
	elseif dj == 7 then
		fhz.经验 = 75420000
		fhz.金钱 = 15500000
	elseif dj == 8 then
		fhz.经验 = 75980000
		fhz.金钱 = 15500000
	elseif dj == 9 then
		fhz.经验 = 72200000
		fhz.金钱 = 15500000
	end
	return fhz
end
function 角色处理类:清除装备属性(装备, 格子, 刷新)
	if 装备.刷新属性 == nil then
		装备.刷新属性 = true
	end
end
function 角色处理类:增加奇经八脉(id, 位置)
	if 玩家数据[self.数字id].角色.门派 ~= nil and 玩家数据[self.数字id].角色.门派 ~= "无门派" then
		local x读取 = self:提取奇经八脉(玩家数据[self.数字id].角色.门派)
		x读取=x读取[玩家数据[self.数字id].角色.奇经八脉["当前流派"]]
		if x读取 ~= nil and x读取[位置] ~= nil and x读取[位置] ~= 1 then --and self:技能树(位置)  还要根据技能树位置来判断 前面是否学习了这个经脉，不然就不给切换
			if 玩家数据[self.数字id].角色.QYD.可用乾元丹 ~= nil and 玩家数据[self.数字id].角色.QYD.可用乾元丹 > 0 then
				玩家数据[self.数字id].角色.QYD.可用乾元丹 = 玩家数据[self.数字id].角色.QYD.可用乾元丹 - 1
				玩家数据[self.数字id].角色.QYD.已用乾元丹 = 玩家数据[self.数字id].角色.QYD.已用乾元丹 + 1
				玩家数据[self.数字id].角色.奇经八脉[x读取[位置]] = 1
				玩家数据[self.数字id].角色.奇经八脉.开启奇经八脉 = true
				玩家数据[self.数字id].角色.奇经八脉.技能树 = self:技能树(位置) or 1
				local sj = {已用乾元丹 = 玩家数据[self.数字id].角色.QYD.已用乾元丹, 可用乾元丹 = 玩家数据[self.数字id].角色.QYD.可用乾元丹, 可换乾元丹 = 玩家数据[self.数字id].角色.QYD.可换乾元丹}
				发送数据(玩家数据[self.数字id].连接id, 241, sj)
				self:刷新信息("33")
			else
				常规提示(self.数字id, "#Y/奇经八脉学习失败！因为可用乾元丹不够本次学习")
			end
			return
		end
	end
	常规提示(self.数字id, "#Y/可用乾元丹不足！奇经八脉学习失败")
	return
end

function 角色处理类:坐骑改名(内容)
	local 坐骑编号 = self:取坐骑编号(内容.认证码)
	if self.坐骑列表[坐骑编号] ~= nil then
		if self.坐骑列表[坐骑编号].名称~=内容.名称 and #内容.名称<12 then
			 self.坐骑列表[坐骑编号].名称=内容.名称
			 发送数据(玩家数据[self.数字id].连接id, 62.1, self.坐骑列表[坐骑编号].名称)
		end
	end
end

function 角色处理类:坐骑驯养(内容)
	local 坐骑编号 = self:取坐骑编号(内容[1])
	local 等级上限 = 玩家数据[self.数字id].角色.等级+15
	if self.历劫.飞升 then
		 等级上限=150
	end
	if self.历劫.渡劫 then
		 等级上限=170
	end
	if self.坐骑列表[坐骑编号] ~= nil then
		if self.坐骑列表[坐骑编号].等级 < 等级上限 then
			local 增加 = qz(self.坐骑列表[坐骑编号].最大经验/2)
			if 玩家数据[self.数字id].角色:扣除经验(增加) then
				 self.坐骑列表[坐骑编号].当前经验 = self.坐骑列表[坐骑编号].当前经验+增加
				 if self.坐骑列表[坐骑编号].当前经验>=self.坐骑列表[坐骑编号].最大经验 then
						self.坐骑列表[坐骑编号].等级=self.坐骑列表[坐骑编号].等级+1
						if self.坐骑列表[坐骑编号].等级 == 25 or self.坐骑列表[坐骑编号].等级 == 50 or self.坐骑列表[坐骑编号].等级 == 75 or self.坐骑列表[坐骑编号].等级 == 100 or self.坐骑列表[坐骑编号].等级 == 125 or self.坐骑列表[坐骑编号].等级 == 150 then
						self.坐骑列表[坐骑编号].可用技能点 = self.坐骑列表[坐骑编号].可用技能点 + 1
					end
						self.坐骑列表[坐骑编号].当前经验=0
						self.坐骑列表[坐骑编号].最大经验 = self:取经验(2, self.坐骑列表[坐骑编号].等级) --2是坐骑
						self:刷新信息("33")--坐骑升级刷新人物
				 end
				 发送数据(玩家数据[self.数字id].连接id, 62, self.坐骑列表[坐骑编号])
			else
				常规提示(self.数字id, "经验不足~")
			end
		else
			常规提示(self.数字id, "这个坐骑已经满级！")
		end
	end
end

function 角色处理类:坐骑修炼(id, 坐骑编号)
end

function 角色处理类:坐骑技能升级(内容)
	 local 技能 = 内容.技能
	 local 坐骑编号 = self:取坐骑编号(内容.认证码)
	 if self.坐骑列表[坐骑编号] ~= nil then
			if self.坐骑列表[坐骑编号].可用技能点 > 0 and self.坐骑列表[坐骑编号].坐骑技能[技能]<3 then
			if self.坐骑列表[坐骑编号].坐骑技能[技能]==0 then
				 if not 玩家数据[self.数字id].角色.武神坛角色 and 玩家数据[self.数字id].角色.银子<1000000 or 玩家数据[self.数字id].角色.当前经验<220000 then
					常规提示(self.数字id, "技能消耗不足！")
						return
				 end
				 if not 玩家数据[self.数字id].角色.武神坛角色 then
				 玩家数据[self.数字id].角色:扣除银子(1000000,0,0,"坐骑技能升级")
				 玩家数据[self.数字id].角色:扣除经验(220000)
				 end

			 elseif self.坐骑列表[坐骑编号].坐骑技能[技能]==1 then
				 if not 玩家数据[self.数字id].角色.武神坛角色 and 玩家数据[self.数字id].角色.银子<1500000 or 玩家数据[self.数字id].角色.当前经验<240000 then
					常规提示(self.数字id, "技能消耗不足！")
						return
				 end
				 if not 玩家数据[self.数字id].角色.武神坛角色 then
				 玩家数据[self.数字id].角色:扣除银子(1500000,0,0,"坐骑技能升级")
				 玩家数据[self.数字id].角色:扣除经验(240000)
				end
			elseif self.坐骑列表[坐骑编号].坐骑技能[技能]==2 then
				 if not 玩家数据[self.数字id].角色.武神坛角色 and 玩家数据[self.数字id].角色.银子<2000000 or 玩家数据[self.数字id].角色.当前经验<260000 then
					常规提示(self.数字id, "技能消耗不足！")
						return
				 end
				 if not 玩家数据[self.数字id].角色.武神坛角色 then
				 玩家数据[self.数字id].角色:扣除银子(2000000,0,0,"坐骑技能升级")
				 玩家数据[self.数字id].角色:扣除经验(260000)
				end
			end
			self.坐骑列表[坐骑编号].坐骑技能[技能]=self.坐骑列表[坐骑编号].坐骑技能[技能]+1
			self.坐骑列表[坐骑编号].可用技能点 = self.坐骑列表[坐骑编号].可用技能点 - 1
			if self.坐骑列表[坐骑编号].统御召唤兽 then
				if self.坐骑列表[坐骑编号].统御召唤兽[1] then
					玩家数据[self.数字id].召唤兽:刷新统御属性(玩家数据[self.数字id].召唤兽:取编号(self.坐骑列表[坐骑编号].统御召唤兽[1]),self.坐骑列表[坐骑编号])
				end
				if self.坐骑列表[坐骑编号].统御召唤兽[2] then
					玩家数据[self.数字id].召唤兽:刷新统御属性(玩家数据[self.数字id].召唤兽:取编号(self.坐骑列表[坐骑编号].统御召唤兽[2]),self.坐骑列表[坐骑编号])
				end
			end

			常规提示(self.数字id, "#G坐骑技能升级成功！")
			发送数据(玩家数据[self.数字id].连接id, 62, self.坐骑列表[坐骑编号])
			end
	 end
end

function 角色处理类:坐骑统御(内容)
	 local 位置=内容.位置
	 local id = 内容.数字id
	 local 坐骑认证码 = 内容.坐骑认证码
	 local 宝宝认证码 = 内容.认证码
	 local 坐骑编号=self:取坐骑编号(坐骑认证码)
	 local 宝宝编号=玩家数据[id].召唤兽:取编号(宝宝认证码)
	 for i=1,#self.坐骑列表 do
		if self.坐骑列表[i].统御召唤兽 and (self.坐骑列表[i].统御召唤兽[1]==宝宝认证码  or self.坐骑列表[i].统御召唤兽[2]==宝宝认证码 ) then
			常规提示(id, "#Y/该召唤兽已经被其他坐骑统御过了！")
			 return
		end
	 end
	if self.坐骑列表[坐骑编号] ~= nil then
		if 宝宝编号 ~= 0 then
			if self.坐骑列表[坐骑编号].统御召唤兽 ~= nil and self.坐骑列表[坐骑编号].统御召唤兽[位置]~= nil then
				常规提示(id, "#Y/该位置已经统御了一只召唤兽了！")
				 return
			end
			self.坐骑列表[坐骑编号].统御召唤兽[位置] = 宝宝认证码
			玩家数据[id].召唤兽.数据[宝宝编号].统御 = 坐骑认证码
			玩家数据[id].召唤兽:刷新统御属性(宝宝编号,self.坐骑列表[坐骑编号])
			玩家数据[id].召唤兽:刷新信息(宝宝认证码)
			常规提示(id, "#Y/统驭召唤兽成功！")
			发送数据(玩家数据[id].连接id, 20, 玩家数据[id].召唤兽.数据[宝宝编号])
			发送数据(玩家数据[id].连接id, 61, 玩家数据[id].角色.坐骑列表)
		else
			常规提示(id, "#Y/统驭召唤兽失败统驭的召唤兽不存在！")
		end
	else
		常规提示(id, "#Y/统驭失败坐骑数据错误！")
	end
end

function 角色处理类:取消坐骑统御(内容)
	local 坐骑认证码 = 内容.坐骑认证码
	 local 坐骑编号=self:取坐骑编号(坐骑认证码)
	 local id = 内容.数字id
	 if self.坐骑列表[坐骑编号]==nil or 坐骑编号==0 then
		常规提示(self.数字id,"#R你没有这样的坐骑！")
		 return
	end
	local 位置 = 内容.编号
	if self.坐骑列表[坐骑编号].统御召唤兽 ~= nil and self.坐骑列表[坐骑编号].统御召唤兽[位置] then
		local 宝宝编号 =玩家数据[id].召唤兽:取编号(self.坐骑列表[坐骑编号].统御召唤兽[位置])
		if 玩家数据[id].召唤兽.数据[宝宝编号] then
			 玩家数据[id].召唤兽.数据[宝宝编号].统御 = nil
			玩家数据[id].召唤兽.数据[宝宝编号].统御属性=nil
			玩家数据[id].召唤兽:刷新信息(self.坐骑列表[坐骑编号].统御召唤兽[位置])
			玩家数据[id].角色.坐骑列表[坐骑编号].统御召唤兽[位置]=nil
			常规提示(id, "#Y已经结束对该召唤兽的统御！")
			发送数据(玩家数据[id].连接id, 20, 玩家数据[id].召唤兽.数据[宝宝编号])
			发送数据(玩家数据[id].连接id, 76, 玩家数据[id].角色.坐骑列表[坐骑编号])
		else
			玩家数据[id].角色.坐骑列表[坐骑编号].统御召唤兽[位置]=nil
			常规提示(id, "#Y已经结束对该召唤兽的统御！")
			发送数据(玩家数据[id].连接id, 76, 玩家数据[id].角色.坐骑列表[坐骑编号])
		end
	end
end

function 角色处理类:取参战宝宝编号()
	local bh=0
	if self.参战信息~=nil then
			local 认证码 = self.参战宝宝.认证码
			bh=玩家数据[self.数字id].召唤兽:取编号(认证码)
	 end
	 return bh
end

function 角色处理类:取参战神兽技能(事件)
	if self.参战信息~=nil then
			local 认证码 = self.参战宝宝.认证码
			local bh=玩家数据[self.数字id].召唤兽:取编号(认证码)
			if bh~=0 then--and 玩家数据[self.数字id].召唤兽.数据[bh].种类=="神兽" then
				for i=1,#玩家数据[self.数字id].召唤兽.数据[bh].技能 do
					if 事件==玩家数据[self.数字id].召唤兽.数据[bh].技能[i] then
						return 事件
				end
			end
		 end
	 end
	 return
end

function 角色处理类:取召唤兽统御(id, 认证码)
	for n = 1, #self.坐骑列表 do
		if self.坐骑列表[n].统御召唤兽[1] == 认证码 or self.坐骑列表[n].统御召唤兽[2] == 认证码 then
			return self.坐骑列表[n].技能, self.坐骑列表[n].成长
		end
	end
	return false,1
end

function 角色处理类:取坐骑编号(认证码)
	for i = 1, #self.坐骑列表 do
		if self.坐骑列表[i].认证码 == 认证码 then
			return i
		end
	end
	return 0
end

function 角色处理类:坐骑主属性选择(内容)
	 local 编号=self:取坐骑编号(内容.认证码)
	 if self.坐骑列表[编号]==nil or 编号==0 then
		常规提示(self.数字id,"#R你没有这样的坐骑！")
		 return
	end
	self.坐骑列表[编号].主属性=内容.属性
	常规提示(self.数字id,"#G设置成功！")
	发送数据(玩家数据[self.数字id].连接id,61,玩家数据[self.数字id].角色.坐骑列表)
	--重新骑乘将刷新属性，懒得写刷新了
end

function 角色处理类:删除比武称谓() --比武 新增 自动删除
	local cwfz={"精锐组","神威组","天科组","天元组"}
	local hs=false
	for n = 1, #self.称谓 do
		if self.称谓[n]~=nil and self.称谓[n]~="" and string.find(self.称谓[n],"精锐组") ~= nil then
			if self.当前称谓 == self.称谓[n] then
				self.当前称谓 = "无称谓"
				地图处理类:系统更新称谓(self.数字id,"")
			end
			hs=true
			self:删除称谓(self.称谓[n])
		end
		if self.称谓[n]~=nil and self.称谓[n]~="" and string.find(self.称谓[n],"神威组") ~= nil then
			if self.当前称谓 == self.称谓[n] then
				self.当前称谓 = "无称谓"
				地图处理类:系统更新称谓(self.数字id,"")
			end
			hs=true
			self:删除称谓(self.称谓[n])
		end
		if self.称谓[n]~=nil and self.称谓[n]~="" and string.find(self.称谓[n],"天科组") ~= nil then
			if self.当前称谓 == self.称谓[n] then
				self.当前称谓 = "无称谓"
				地图处理类:系统更新称谓(self.数字id,"")
			end
			hs=true
			self:删除称谓(self.称谓[n])
		end
		if self.称谓[n]~=nil and self.称谓[n]~="" and string.find(self.称谓[n],"天元组") ~= nil then
			if self.当前称谓 == self.称谓[n] then
				self.当前称谓 = "无称谓"
				地图处理类:系统更新称谓(self.数字id,"")
			end
			hs=true
			self:删除称谓(self.称谓[n])
		end
	end
	if hs then
		常规提示(id,"咋还顶着这称谓来比武呢，回收了")
	end
end

function 角色处理类:坐骑放生(认证码)
	local 编号=self:取坐骑编号(认证码)
	if self.坐骑列表[编号]==nil or 编号==0 then
		常规提示(self.数字id,"#R你没有这样的坐骑")
		 return
	end
	if self.坐骑列表[编号].统御召唤兽 ~= nil and (self.坐骑列表[编号].统御召唤兽[1]~= nil or self.坐骑列表[编号].统御召唤兽[2]~= nil) then
		常规提示(self.数字id,"#R该坐骑尚有统御的召唤兽，不能放生！")
		return
	elseif self.坐骑列表[编号].饰品~=nil then
		常规提示(self.数字id,"#R请卸下该坐骑的饰品")
		return
	elseif self.坐骑 ~= nil and self.坐骑.认证码 == self.坐骑列表[编号].认证码 then
		常规提示(self.数字id,"#R该坐骑正在骑乘中，不能放生！")
		return
	else
		table.remove(self.坐骑列表,编号)
		发送数据(玩家数据[self.数字id].连接id,61,玩家数据[self.数字id].角色.坐骑列表)
		发送数据(玩家数据[self.数字id].连接id,75)
	end
end

function 角色处理类:增加种族坐骑(id)
	全局坐骑资料:获取坐骑(id, 全局坐骑资料:取坐骑库(玩家数据[id].角色))
end

function 角色处理类:增加指定坐骑(id, mc)
	local zqsQ = mc
	local zqsQ2 = true
	if 玩家数据[id].角色.坐骑列表 ~= nil then
		for i = 1, #玩家数据[id].角色.坐骑列表 do
			if 玩家数据[id].角色.坐骑列表[i].名称 == zqsQ then
				zqsQ2 = false
			end
		end
	end
	if zqsQ2 == false then
		常规提示(id, "#Y/使用失败!你已经换取过["..zqsQ.."]坐骑!")
	else
		if 玩家数据[id].角色.坐骑列表 ~= nil and #玩家数据[id].角色.坐骑列表 == 7 then
			常规提示(id, "#Y/对不起你换取的["..zqsQ.."]坐骑失败!携带坐骑数量已上限.")
			return false
		else
			常规提示(id, "#Y/恭喜你换取了["..zqsQ.."]坐骑!")
			全局坐骑资料:获取坐骑(id, zqsQ)
			发送数据(玩家数据[id].连接id, 61, 玩家数据[id].角色.坐骑列表)
		end
	end
end

function 角色处理类:门派任务(id, 门派)
	设置任务111(id, 门派)
end

function 角色处理类:取门派传送选项()
	local xx = {}
	if self.种族 == "仙" then
		xx = {"天宫", "龙宫", "凌波城"}
		if self.性别 == "男" then
			xx[#xx + 1] = "五庄观"
		else
			xx[#xx + 1] = "普陀山"
		end
	elseif self.种族 == "魔" then
		xx = {"魔王寨", "阴曹地府", "无底洞"}
		if self.性别 == "男" then
			xx[#xx + 1] = "狮驼岭"
		else
			xx[#xx + 1] = "盘丝洞"
		end
	elseif self.种族 == "人" then
		xx = {"神木林", "大唐官府", "方寸山"}
		if self.性别 == "男" then
			xx[#xx + 1] = "化生寺"
		else
			xx[#xx + 1] = "女儿村"
		end
	end
	return xx
end

function 角色处理类:添加经验(数额, 类型, 提示)
	local 倍率 = 服务端参数.经验获得率
	local 之前银子 = self.当前经验
	if 类型 == "野外" or 类型 == "捉鬼" or 类型 == "鬼王" or 类型 == "官职" or 类型 == "封妖战斗" or 类型 == "种族" then--or 类型 == "门派闯关" then
		if self:取任务(2) ~= 0 then --双倍
			倍率 = 倍率 + 1
		end
		if self:取任务(3) ~= 0 then --三倍
			倍率 = 倍率 + 1
		end
		if self.储备灵气 > 0 then
			倍率 = 倍率 + 1
			self.储备灵气 = self.储备灵气 - 1
			发送数据(玩家数据[self.数字id].连接id, 38, {内容 = "你的储备灵气消耗1点剩余储备灵气"..self.储备灵气.."点", 频道 = "xt"})
		end
	end
	if 类型 == "昆仑仙境" then
		倍率 = 1
		if self:取任务(241) ~= 0 then
			倍率 = 倍率 + 1
		end
	else
		if self:取任务(15) ~= 0 then --回梦丹
			倍率 = 倍率 + 1
		end
	end
	-- 	if self:取任务(241) ~= 0 then
	-- 		倍率 = 倍率 + 1
	-- 	end
	-- end
	local 经验 = math.floor(数额 * 倍率)
	self.当前经验 = math.floor(self.当前经验 + 经验)
	if self.等级<20 then
		 self:自动升级处理()
	end
	发送数据(玩家数据[self.数字id].连接id, 38, {内容 = "你获得了"..经验.."点经验", 频道 = "xt"})
	发送数据(玩家数据[self.数字id].连接id, 226, {当前经验 = 玩家数据[self.数字id].角色.当前经验, 最大经验 = 玩家数据[self.数字id].角色.最大经验})
	常规提示(self.数字id, "#Y/你获得了"..经验.."点经验")
	self:日志记录(format("事件:获得经验,类型%s,数额%s,倍率%s,获得前%s,获得后%s", 类型, 数额, 倍率, 之前银子, self.当前经验))
	if 玩家数据[self.数字id].角色.参战信息~=nil then
		玩家数据[self.数字id].召唤兽:获得经验(玩家数据[self.数字id].角色.参战宝宝.认证码,math.floor(经验*0.4),self.数字id,类型)
	end
end

function 角色处理类:取剧情技能等级(名称)
	local 等级 = 0
	for n = 1, #self.剧情技能 do
		if self.剧情技能[n].名称 == 名称 then
			等级 = self.剧情技能[n].等级
		end
	end
	return 等级
end

function 角色处理类:取师门技能等级(名称)
	for n = 1, #self.师门技能 do
		for i = 1, #self.师门技能[n].包含技能 do
			if self.师门技能[n].包含技能[i].名称 == 名称 and self.师门技能[n].包含技能[i].学会 then
				local fslv=self.额外技能等级[self.师门技能[n].名称] or 0
				return self.师门技能[n].等级 + fslv
			end
		end
	end
	for n = 1, #self.师门技能 do
		if self.师门技能[n].名称 then
			local fslv=self.额外技能等级[self.师门技能[n].名称] or 0
			return self.师门技能[n].等级 + fslv
		end
	end
	return 0
end

function 角色处理类:摊位符制造(mc,给与id)
	local id = self.数字id
	local 等级 = self:取师门技能等级(mc)
	local 分类 = 取强化符分类(mc)
	local 强化符 = 物品类()
	强化符:置对象("强化符")
	if 给与id then
		id =  给与id
	end
	local 临时道具 = 复制物品(强化符)
	local 道具编号 = 玩家数据[id].道具:取新编号()
	临时道具.技能 = mc
	临时道具.等级 = 等级
	临时道具.分类 = 分类
	玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,临时道具)
end

function 角色处理类:临时符制造(mc,给与id)
	local id = self.数字id
	local 等级 = self:取师门技能等级(mc)
	if 调试模式 then
	   等级=160
	end
	local 分类 = 取强化符分类(mc)
	if self.活力 < 等级 then return 常规提示(id, "#Y/当前活力不够！年轻人不要那么拼命！") end
	self.活力 = self.活力 - 等级
	local 强化符 = 物品类()
	强化符:置对象("强化符")
	if 给与id then
		id =  给与id
	end
	local 临时道具 = 复制物品(强化符)
	local 道具编号 = 玩家数据[id].道具:取新编号()
	临时道具.技能 = mc
	临时道具.等级 = 等级
	临时道具.分类 = 分类
	玩家数据[id].道具:给予道具(id,nil,nil,nil,nil,nil,临时道具)
end

function 角色处理类:临时鉴定符(mc,给与id)
	local id = self.数字id
	local 等级 = 0
	local 分类 = 取强化符分类(mc)
	for n = 1, #self.师门技能 do
		for i = 1, #self.师门技能[n].包含技能 do
			if self.师门技能[n].包含技能[i].名称 == mc and self.师门技能[n].包含技能[i].学会 then
				等级 = qz(self.师门技能[n].等级/10) *10
			end
		end
	end
	if self.活力 < 等级 then return 常规提示(id, "#Y/当前体力不够!年轻人不要那么拼命!") end
	self.活力 = self.活力 - 等级
	if 给与id then
		id =  给与id
	end
	local 名称 = "神兵图鉴"
	if mc == "堪察令" then
		名称 = "灵宝图鉴"
	end
	玩家数据[id].道具:给予道具(id,名称,等级)
	常规提示(id, "#Y/你获得了#R" .. 名称)
end

function 角色处理类:使用快捷技能(序列)
	if self.快捷技能[序列] == nil then
		return
	end
	local 名称 = self.快捷技能[序列].名称
	local 类型 = self.快捷技能[序列].类型
	local 等级 = 0
	local id = self.数字id
	if 类型 == 1 then -- 师门技能
		for n = 1, #self.师门技能 do
			for i = 1, #self.师门技能[n].包含技能 do
				if self.师门技能[n].包含技能[i].名称 == 名称 and self.师门技能[n].包含技能[i].学会 then
					等级 = self.师门技能[n].等级
				end
			end
		end
	elseif 类型 == 3 then -- 剧情技能
		for n = 1, #self.剧情技能 do
			if self.剧情技能[n].名称 == 名称 then
				等级 = self.剧情技能[n].等级
			end
		end
	elseif 类型 == 4 then --飞行
		等级 = 1 --这里可以判断 是否有燃料
	end
	if 等级 == 0 then
		return
	end
	if 类型 == 1 and 玩家数据[id].zhandou == 0 then
		if 名称 == "故壤归心" or 名称 == "纵地金光" or 名称 == "遁地术" or 名称 == "叶隐" or 名称 == "千里神行" or 名称 == "乙木仙遁" or 名称 == "佛门普渡" or 名称 == "移形换影" or 名称 == "叶隐" or 名称 == "水遁" or 名称 == "腾云驾雾" or 名称 == "斗转星移" or 名称 == "坐莲" or 名称 == "纵地金光" or 名称 == "振翅千里" or 名称 == "牛屎遁" or 名称 == "天蚕丝" or 名称 == "杳无音讯" or 名称 == "遁地术" or 名称 == "筋斗云" then
			if 玩家数据[id].角色.气血 < 10 or 玩家数据[id].角色.魔法 < 10 then
				常规提示(id, "您的气血魔法不足！")
				return
			elseif 玩家数据[id].队伍 ~= 0 then
				常规提示(id, "组队状态下无法使用此功能！")
				return
			end
			玩家数据[id].角色.气血 = 玩家数据[id].角色.气血 - 10
			玩家数据[id].角色.魔法 = 玩家数据[id].角色.魔法 - 10
			发送数据(玩家数据[id].连接id, 47, {玩家数据[id].角色:取气血数据()})
			if 等级 >= 玩家数据[id].角色.等级 - 5 and 玩家数据[id].角色.气血 > 10 and 玩家数据[id].角色.魔法 >10 then
				地图处理类:加入动画(self.数字id, self.地图数据.编号, self.地图数据.x, self.地图数据.y, 名称)
				发送数据(玩家数据[self.数字id].连接id,36,{动画=名称})
				地图处理类:门派传送(id, 玩家数据[id].角色.门派)
			elseif 等级 >= 取随机数(1, 玩家数据[id].角色.等级 - 5) and 玩家数据[id].角色.气血 > 10 and 玩家数据[id].角色.魔法 >10  then
				地图处理类:加入动画(self.数字id, self.地图数据.编号, self.地图数据.x, self.地图数据.y, 名称)
				发送数据(玩家数据[self.数字id].连接id,36,{动画=名称})
				地图处理类:门派传送(id, 玩家数据[id].角色.门派)
			else
				常规提示(id, "使用技能失败！")
				return
			end
		elseif 名称 == "活血" and 玩家数据[id].角色.魔法 > 70 then
			玩家数据[id].角色.魔法 = 玩家数据[id].角色.魔法 - 70
			local 气血 = qz(self:取师门技能等级(名称)*4+150)
			玩家数据[id].道具:加血处理(玩家数据[id].连接id, id, 气血, 0, "推拿",气血)
		elseif 名称 == "推气过宫" and 玩家数据[id].角色.魔法 > 100 then
			玩家数据[id].角色.魔法 = 玩家数据[id].角色.魔法 - 100
			local 气血 = qz(self:取师门技能等级(名称)*3.5)
			玩家数据[id].道具:加血处理(玩家数据[id].连接id, id, 气血, 0, "推拿")
		elseif 名称 == "救死扶伤" and 玩家数据[id].角色.魔法 > 150 then
			玩家数据[id].角色.魔法 = 玩家数据[id].角色.魔法 - 150
			local 气血 = qz(self:取师门技能等级(名称)*2.5)
			玩家数据[id].道具:加血处理(玩家数据[id].连接id, id, 气血, 0, "推拿",气血)
		elseif 名称 == "推拿" and 玩家数据[id].角色.魔法 > 50 then
			玩家数据[id].角色.魔法 = 玩家数据[id].角色.魔法 - 50
			local 气血 = qz(self:取师门技能等级(名称)*4+100)
			玩家数据[id].道具:加血处理(玩家数据[id].连接id, id, 气血, 0, "推拿",气血)
		elseif 名称 == "尸气漫天" or 名称 == "神兵护法" or 名称 == "嗜血" or 名称 == "莲华妙法" or 名称 == "担山赶月" or 名称 == "轻如鸿毛" or 名称 == "盘丝舞" or 名称 == "魔王护持" or 名称 == "龙附" or 名称 == "元阳护体" or 名称 == "浩然正气" or 名称 == "一气化三清" or 名称 == "神力无穷" or 名称 == "穿云破空" or 名称 == "拈花妙指" or 名称 == "神木呓语" then
			self:临时符制造(名称)
		end
	elseif 类型 == 3 and 玩家数据[id].zhandou == 0 then
		if 名称 == "仙灵店铺" then
			local 发送商品 = {}
			if 等级 == 1 then
				发送商品 = {"包子*150"}
			elseif 等级 == 2 then
				发送商品 = {"包子*150", "四叶花*50", "鬼切草*50", "摄妖香*1050", "蓝色导标旗*8000", "黄色导标旗*8000", "红色导标旗*8000", "绿色导标旗*8000", "白色导标旗*8000"}--  "",
			elseif 等级 == 3 then
				发送商品 = {"包子*150", "四叶花*50", "鬼切草*50", "摄妖香*1050", "蓝色导标旗*8000", "黄色导标旗*8000", "红色导标旗*8000", "绿色导标旗*8000", "白色导标旗*8000", "紫丹罗*50", "洞冥草*550"}--  "",
			elseif 等级 == 4 then
				发送商品 = {"包子*150", "四叶花*50", "鬼切草*50", "摄妖香*1050", "蓝色导标旗*8000", "黄色导标旗*8000", "红色导标旗*8000", "绿色导标旗*8000", "白色导标旗*8000", "紫丹罗*50", "洞冥草*550", "六道轮回*3500", "白露为霜*2500", "金创药*4000"}
			elseif 等级 == 5 then
				发送商品 = {"包子*150", "四叶花*50", "鬼切草*50", "摄妖香*1050", "蓝色导标旗*8000", "黄色导标旗*8000", "红色导标旗*8000", "绿色导标旗*8000", "白色导标旗*8000", "紫丹罗*50", "洞冥草*550", "六道轮回*3500", "白露为霜*2500", "金创药*4000", "天眼通符*9000",  "飞行符*750", "乾坤袋*6000", "高级宠物口粮*10000"}
			end
			玩家数据[id].商品列表 = 发送商品
			发送数据(玩家数据[id].连接id, 9, {商品 = 发送商品, 银子 = 玩家数据[id].角色.银子, 名称 = "仙灵店铺"})
		elseif 名称 == "仙灵酒店" then
			-- for n = 1, 20 do
			-- 	if 玩家数据[id].角色.道具[n] ~= nil then
			-- 		玩家数据[id].道具:一件回收(玩家数据[id].角色.道具[n], n, id)
			-- 	end
			-- end
			-- 道具刷新(id)
		elseif 名称 == "调息" then
			if 玩家数据[id].角色.调息间隔 ~= nil and os.time() - 玩家数据[id].角色.调息间隔 <= 180 then
				常规提示(id, "#Y/此技能使用的间隔时间为3分钟")
				return
			else
				玩家数据[id].角色.调息间隔 = os.time()
				玩家数据[id].道具:加血处理(玩家数据[id].连接id, id, 等级 * 60, 0, "推拿")
			end
		elseif 名称 == "打坐" then
			if 玩家数据[id].角色.打坐间隔 ~= nil and os.time() - 玩家数据[id].角色.打坐间隔 <= 180 then
				常规提示(id, "#Y/此技能使用的间隔时间为3分钟")
				return
			else
				玩家数据[id].角色.打坐间隔 = os.time()
				玩家数据[id].道具:加魔处理(玩家数据[id].连接id, id, 等级 * 30, 0, "推拿")
			end
		end
	elseif 类型 == 4 and 玩家数据[id].zhandou == 0 then
		if 玩家数据[id].角色.坐骑==nil then
			-- 常规提示(id,"#Y/请先骑乘你要飞的坐骑")
			-- return
		end
		if 取飞行坐骑限制(id)~=true then
			return
		end

		if 玩家数据[id].队伍==0 then
			if 玩家数据[id].角色.飞行中==nil then
				玩家数据[id].角色.飞行中=true
					常规提示(id,"#Y/你飞了起来...")
			else
				玩家数据[id].角色.飞行中=nil
				常规提示(id,"#Y/你落地了...")
			end
			地图处理类:玩家是否飞行(id,玩家数据[id].角色.飞行中)
		else
			 队伍处理类:取队伍飞行(玩家数据[id].队伍,id)
		end
	end
end

function 角色处理类:设置快捷技能(数据)
	local 名称 = 数据.名称
	local 类型 = 数据.类型
	local 找到 = false
	if 类型 == 1 then -- 师门技能
		for n = 1, #self.师门技能 do
			for i = 1, #self.师门技能[n].包含技能 do
				if self.师门技能[n].包含技能[i].名称 == 名称 and self.师门技能[n].包含技能[i].学会 then
					找到 = true
				end
			end
		end
		if 找到 == false then
			return
		end
	elseif 类型 == 3 then -- 剧情技能
		for n = 1, #self.剧情技能 do
			if self.剧情技能[n].名称 == 名称 then
				找到 = true
			end
		end
		if 找到 == false then
			return
		end
	end
	for n, v in pairs(self.快捷技能) do
		if self.快捷技能[n].名称 == 数据.名称 then
			self.快捷技能[n] = nil
		end
	end
	self.快捷技能[数据.位置] = {名称 = 数据.名称, 类型 = 数据.类型}
	发送数据(玩家数据[self.数字id].连接id, 42, self.快捷技能)
end

function 角色处理类:取快捷技能(id)
	local x数据 = {}
	for n, v in pairs(self.快捷技能) do
		if self.快捷技能[n].名称 ~= nil then
			x数据[n] = {名称 = self.快捷技能[n].名称, 类型 = self.快捷技能[n].类型}
		end
	end
	发送数据(玩家数据[id].连接id, 42, x数据)
end

function 角色处理类:添加属性点(数据, id)
	if self.潜力<1 then
		 return
	end
	local 属性总和 = 0
	local 监控开关 = false
	for n = 1, #属性类型 do
		if 数据[属性类型[n]] < 0 or 数据[属性类型[n]] > self.潜力 then
			监控开关 = true
		end
		属性总和 = 属性总和 + 数据[属性类型[n]]
	end
	if 属性总和~=qz(属性总和) then
		 监控开关=true
	end
	if 监控开关 then
		__S服务:输出("玩家"..self.数字id.." 非法修改数据警告!属性修改")
		-- 写配置("./ip封禁.ini", "ip", self.ip, 1)
		-- f函数.写配置(程序目录..[[data\]]..玩家数据[self.数字id].账号..[[\账号信息.txt]],"账号配置","封禁","1")
		服务端参数.分钟=os.date("%M", os.time())
		服务端参数.小时=os.date("%H", os.time())
		服务端参数.秒=os.date("%S", os.time())


		local 封禁原因=self.ip.."“违规行为：角色添加属性点”，玩家ID="..self.数字id.."，玩家账号="..玩家数据[self.数字id].账号.."时间="..os.date("%Y%m%d")..os.date("%H",os.time())..os.date("%S",os.time())
		f函数.写配置(程序目录..[[data\]]..玩家数据[self.数字id].账号..[[\账号信息.txt]],"账号配置","已违规4",封禁原因)
		f函数.写配置(程序目录..[[各类情况查看\]]..[[\违规汇总.txt]],"违规详情","已违规4:",封禁原因)
		-- 发送数据(玩家数据[self.数字id].连接id, 998, "请注意你的角色异常！已经对你进行封禁")
		-- __S服务:断开连接(玩家数据[self.数字id].连接id)
		常规提示(self.数字id, "属性异常！")
		return 0
	end
	if 属性总和 <1 then
		常规提示(self.数字id, "您到底是要添加哪种属性点呢？")
		return 0
	elseif self.潜力 < 属性总和 then
		常规提示(self.数字id, "你没有那么多可分配的属性点！")
		return 0
	else
		for n = 1, #属性类型 do
			self[属性类型[n]] = self[属性类型[n]] + 数据[属性类型[n]]
		end
		self.潜力 = self.潜力 - 属性总和
		self:刷新信息("0")
		self:加点方案刷新()
	end
end

function 角色处理类:加点方案刷新()
	self.加点方案[1].体质 = self.体质
	self.加点方案[1].魔力 = self.魔力
	self.加点方案[1].力量 = self.力量
	self.加点方案[1].耐力 = self.耐力
	self.加点方案[1].敏捷 = self.敏捷
	self.加点方案[1].潜力 = self.潜力
end
function 角色处理类:加点方案重置()
	self.加点方案={[1]={}}
	self.加点方案[1].体质 = self.体质
	self.加点方案[1].魔力 = self.魔力
	self.加点方案[1].力量 = self.力量
	self.加点方案[1].耐力 = self.耐力
	self.加点方案[1].敏捷 = self.敏捷
	self.加点方案[1].潜力 = self.潜力
end
function 角色处理类:启用当前方案(n)
	if 玩家数据[self.数字id].角色:扣除银子(500000,0,0,"购买银两",1) then
		self.体质=self.加点方案[n+1].体质
		self.魔力=self.加点方案[n+1].魔力
		self.力量=self.加点方案[n+1].力量
		self.耐力=self.加点方案[n+1].耐力
		self.敏捷=self.加点方案[n+1].敏捷
		self.潜力=self.加点方案[n+1].潜力
		self:加点方案刷新()
		self:刷新信息("0")
		发送数据(玩家数据[self.数字id].连接id,901,玩家数据[self.数字id].角色:取总数据1())
		常规提示(self.数字id, "启动方案"..n.."成功！")
	end
end
function 角色处理类:加点方案报存(id)
	if #self.加点方案 >=5 then
		常规提示(self.数字id, "最多4套方案")
		return 0
	end
	local 临时参数=#self.加点方案+1
	self.加点方案[临时参数]={}
	self.加点方案[临时参数].体质 = self.加点方案[1].体质
	self.加点方案[临时参数].魔力 = self.加点方案[1].魔力
	self.加点方案[临时参数].力量 = self.加点方案[1].力量
	self.加点方案[临时参数].耐力 = self.加点方案[1].耐力
	self.加点方案[临时参数].敏捷 = self.加点方案[1].敏捷
	self.加点方案[临时参数].潜力 = self.加点方案[1].潜力
	self:加点方案刷新()
	发送数据(玩家数据[id].连接id,247,self.加点方案)
end
function 角色处理类:加点方案替换(方案)
	self.加点方案[方案+1].体质 = self.加点方案[1].体质
	self.加点方案[方案+1].魔力 = self.加点方案[1].魔力
	self.加点方案[方案+1].力量 = self.加点方案[1].力量
	self.加点方案[方案+1].耐力 = self.加点方案[1].耐力
	self.加点方案[方案+1].敏捷 = self.加点方案[1].敏捷
	self.加点方案[方案+1].潜力 = self.加点方案[1].潜力
	self:加点方案刷新()
	常规提示(self.数字id, "已经将你当前方案替换到方案"..方案)
	发送数据(玩家数据[self.数字id].连接id,247,self.加点方案)
end

function 角色处理类:自动升级处理()
	local dj = 20
	if self.门派=="无门派" then
		 dj=10
	end
	for i=1,10 do
		if self.当前经验 >= self.最大经验 and self.等级<dj then
			self.等级 = self.等级 + 1
			self.体质 = self.体质 + 1
			self.魔力 = self.魔力 + 1
			self.力量 = self.力量 + 1
			self.耐力 = self.耐力 + 1
			self.敏捷 = self.敏捷 + 1
			self:增加潜力(5)
			self.最大体力 = self.最大体力 + 10
			self.最大活力 = self.最大活力 + 10
			self.当前经验 = self.当前经验 - self.最大经验
			if not self.历劫.飞升 then
				local 数值 = qz((self.等级-20)/5)
				if 数值 > 20 then 数值 =20 end
				local as = {"攻击修炼", "防御修炼", "法术修炼", "抗法修炼", "猎术修炼"}
				local as1 = {"攻击控制力", "防御控制力", "法术控制力", "抗法控制力"}
				for i = 1, #as do
					if self.修炼[as[i]][3] < 数值 then
						self.修炼[as[i]][3] = 数值
					end
				end
				for i = 1, #as1 do
					if self.bb修炼[as1[i]][3] <数值 then
						self.bb修炼[as1[i]][3] = 数值
					end
				end
			end
			self.QYD.可换乾元丹 = self:取可兑换乾元丹()
			self:刷新信息("0")
			self:加点方案刷新()
			地图处理类:加入动画(self.数字id, self.地图数据.编号, self.地图数据.x, self.地图数据.y, "升级")
			发送数据(玩家数据[self.数字id].连接id,36,{动画="升级"})
		else
			break
		end
	end
end

function 角色处理类:升级处理(id, 系统) --id为连接id
	if self.等级>=QJDJSX then
		常规提示(self.数字id, "#Y/您当前等级已达到服务器上限，等待GM开放更高等级")
			return 0
	 end
	if self:等级上限(id) then
		if self.当前经验 < self.最大经验 then
			常规提示(self.数字id, "你没有那么多的经验")
			return 0
		end
		if 系统==nil then
			-- if self.等级==59 then
			-- 	 添加最后对话(self.数字id,"是否确定将等级提升至60级吗？",{"我已确认将等级提升至60","我再考虑考虑！"})
			-- 	 return
			if self.等级==69 then
				 添加最后对话(self.数字id,"是否确定将等级提升至70级吗？",{"我已确认将等级提升至70","我再考虑考虑！"})
				 return
			 -- elseif self.等级==89 then
				--  添加最后对话(self.数字id,"是否确定将等级提升至90级吗？",{"我已确认将等级提升至90","我再考虑考虑！"})
				--  return
			 elseif self.等级==109 then
				 添加最后对话(self.数字id,"是否确定将等级提升至110级吗？",{"我已确认将等级提升至110","我再考虑考虑！"})
				 return
			 elseif self.等级==129 then
				 添加最后对话(self.数字id,"是否确定将等级提升至130级吗？",{"我已确认将等级提升至130","我再考虑考虑！"})
				 return
			end
		 end
		self.等级 = self.等级 + 1
		self.体质 = self.体质 + 1
		self.魔力 = self.魔力 + 1
		self.力量 = self.力量 + 1
		self.耐力 = self.耐力 + 1
		self.敏捷 = self.敏捷 + 1
		self:增加潜力(5)
		self.最大体力 = self.最大体力 + 10
		self.最大活力 = self.最大活力 + 10
		self.当前经验 = self.当前经验 - self.最大经验
		if not self.历劫.飞升 then
			local 数值 = qz((self.等级-20)/5)
			if 数值 > 20 then 数值 =20 end
			if 数值<0 then 数值 =0 end
			local as = {"攻击修炼", "防御修炼", "法术修炼", "抗法修炼", "猎术修炼"}
			local as1 = {"攻击控制力", "防御控制力", "法术控制力", "抗法控制力"}
			for i = 1, #as do
				self.修炼[as[i]][3] = 数值
			end
			for i = 1, #as1 do
				self.bb修炼[as1[i]][3] = 数值
			end
		end
		self.QYD.可换乾元丹 = self:取可兑换乾元丹()
		self:刷新信息("0")
		self:加点方案重置()
		发送数据(id, 10, self:取总数据1())
		地图处理类:加入动画(self.数字id, self.地图数据.编号, self.地图数据.x, self.地图数据.y, "升级")
		发送数据(玩家数据[self.数字id].连接id,36,{动画="升级"})
	end
end

function 角色处理类:快捷门派传送(id)
	local 临时数据 = {}
	临时数据.模型 = "男人_镖头"
	临时数据.名称 = "新手门派传送人"
	临时数据.对话 = "独自一人行走江湖可谓是凶多吉少，请少侠先加入一个门派吧。我可以帮你快速地传送到你想要去的门派哟。请选择你要进行传送的门派："
	临时数据.选项 = {"方寸山", "女儿村", "神木林","化生寺", "大唐官府","盘丝洞","阴曹地府","无底洞","魔王寨","狮驼岭","天宫","普陀山","凌波城","五庄观", "龙宫","花果山","九黎城"}
	发送数据(id, 1501, 临时数据)
end

function 角色处理类:取气血数据()
	return {气血 = self.气血, 气血上限 = self.气血上限, 最大气血 = self.最大气血, 魔法 = self.魔法, 最大魔法 = self.最大魔法, 愤怒 = self.愤怒}
end

function 角色处理类:等级上限(id)
	self.初始上限 = 144
	if self.历劫.飞升 == true then
		self.初始上限 = 155
	end
	if self.历劫.渡劫 == true then
		self.初始上限 = 175
	end
	if self.门派 == "无门派" then
		self.初始上限 = 10
	else
		local mz=0
		local jndj = qz(self.等级-self.等级/5-10)
		for i=1,#self.师门技能 do
			if self.师门技能[i].等级>=jndj then
				mz=mz+1
			end
		end

		if mz<5 then
			if 调试模式 then
				常规提示(self.数字id,"继续升级需要5项师门等级≥"..jndj.."#R[调试模式无视]")
			else
				常规提示(self.数字id,"继续升级需要5项师门等级≥"..jndj)
				return false
			end
		end

	end

	-- if self.初始上限 <= self.等级 then
	-- 	常规提示(self.数字id, "您的等级已经到达了上限！")
	-- 	return false
	-- else
	-- 	return true
	-- end
	if self.初始上限 <= self.等级 then
		if  self.门派 == "无门派" then
			常规提示(self.数字id, "您还没有门派,选择一个吧~")
	    发送数据(玩家数据[self.数字id].连接id,228)-----------根据角色选门派
	    return false
	  else
	  	if 调试模式 then
	  		常规提示(self.数字id, "需飞升/渡劫 #R[调试模式无视]")
	  		玩家数据[self.数字id].角色.历劫.飞升=true
	  		玩家数据[self.数字id].角色.历劫.渡劫=true
	  		玩家数据[self.数字id].角色.历劫.化圣=true
	  		return true
	  	else
				常规提示(self.数字id, "您的等级到达了上限！(或需飞升/渡劫)")
			return false
			end
		end
	else
		return true
	end

end

function 角色处理类:取好友数据(id, 连接id, 序号)
	for n = 1, #self.好友数据.好友 do
		if self.好友数据.好友[n].id ~= nil and 玩家数据[self.好友数据.好友[n].id] ~= nil then -- and (self.好友数据.好友[n].关系 =="普通朋友" or self.好友数据.好友[n].好友度>=10) then
			self.好友数据.好友[n].在线 = nil
			for i = 1, #玩家数据[self.好友数据.好友[n].id].角色.好友数据.好友 do
				if 玩家数据[self.好友数据.好友[n].id].角色.好友数据.好友[i].id == id then
					self.好友数据.好友[n].在线 = 1
				end
			end
		else
			self.好友数据.好友[n].在线 = nil
		end
	end
	发送数据(连接id, 序号, self.好友数据)
end

function 角色处理类:增加潜力(sj)
	self.潜力 = self.潜力 +sj
end

function 角色处理类:降级处理(级数) --飞升要改
	local 扣除潜力,扣除五维 = 级数*5,级数
	self.等级=self.等级-级数
	if self.潜力>=级数*5 then
		self.潜力 = self.潜力-扣除潜力
		self.体质 = self.体质-扣除五维
		self.魔力 = self.魔力-扣除五维
		self.力量 = self.力量-扣除五维
		self.耐力 = self.耐力-扣除五维
		self.敏捷 = self.敏捷-扣除五维
	else
		local lsb = {
			{数值=self.体质,五维="体质"},
			{数值=self.魔力,五维="魔力"},
			{数值=self.力量,五维="力量"},
			{数值=self.耐力,五维="耐力"},
			{数值=self.敏捷,五维="敏捷"}
		}
		table.sort(lsb,function(a,b) return a.数值>b.数值 end )
		for i=1,#lsb do
			if i == 1 then
				self[lsb[i].五维] = self[lsb[i].五维] -扣除潜力-扣除五维
			else
				self[lsb[i].五维] = self[lsb[i].五维] -扣除五维
			end
		end
	end
	self.潜力 = self.潜力 + (self.月饼 or 0)
	self:刷新信息("0")
end

function 角色处理类:自用升级处理(级数)
	local 增加潜力,增加五维 = 级数*5,级数
	self.等级=self.等级+级数
	if self.潜力<=级数*5 then
		self.潜力 = self.潜力+增加潜力
		self.体质 = self.体质+增加五维
		self.魔力 = self.魔力+增加五维
		self.力量 = self.力量+增加五维
		self.耐力 = self.耐力+增加五维
		self.敏捷 = self.敏捷+增加五维
	else
		local lsb = {
			{数值=self.体质,五维="体质"},
			{数值=self.魔力,五维="魔力"},
			{数值=self.力量,五维="力量"},
			{数值=self.耐力,五维="耐力"},
			{数值=self.敏捷,五维="敏捷"}
		}
		table.sort(lsb,function(a,b) return a.数值<b.数值 end )
		for i=1,#lsb do
			if i == 1 then
				self[lsb[i].五维] = self[lsb[i].五维] +增加潜力+增加五维
			else
				self[lsb[i].五维] = self[lsb[i].五维] +增加五维
			end
		end
	end
	self.潜力 = self.潜力 + (self.月饼 or 0)
	self:刷新信息("0")
end



function 角色处理类:飞升降修()
	local as = {"攻击修炼", "防御修炼", "法术修炼", "抗法修炼", "猎术修炼"}
	local as1 = {"攻击控制力", "防御控制力", "法术控制力", "抗法控制力"}
	for i = 1, #as do
		if self.修炼[as[i]][1] >= 13 then
			local 当前,经验,上限 = self.修炼[as[i]][1],self.修炼[as[i]][2],self.修炼[as[i]][3]
			if 当前 ==20 then
				当前 =15
				上限=25
				经验=0
			elseif 当前 ==19 then
				当前 =15
				上限=24
				经验=0
			elseif 当前 ==18 then
				当前 =14
				上限=24
				经验=0
			elseif 当前 ==17 then
				当前 =14
				上限=23
				经验=0
			elseif 当前 ==16 then
				当前 =13
				上限=23
				经验=0
			elseif 当前==15 then
				当前 =13
				上限=22
				经验=0
			elseif 当前 ==14 then
				当前 =12
				上限=22
				经验=0
			elseif 当前==13 then
				当前 =12
				上限=21
				经验=0
			end
			self.修炼[as[i]][1],self.修炼[as[i]][2],self.修炼[as[i]][3]=当前,经验,上限
		end
	end
	for i = 1, #as1 do
		if self.bb修炼[as1[i]][1] >= 13 then
			local 当前,经验,上限 = self.bb修炼[as1[i]][1],self.bb修炼[as1[i]][2],self.bb修炼[as1[i]][3]
			if 当前 ==20 then
				当前 =15
				上限=25
				经验=0
			elseif 当前 ==19 then
				当前 =15
				上限=24
				经验=0
			elseif 当前 ==18 then
				当前 =14
				上限=24
				经验=0
			elseif 当前 ==17 then
				当前 =14
				上限=23
				经验=0
			elseif 当前 ==16 then
				当前 =13
				上限=23
				经验=0
			elseif 当前==15 then
				当前 =13
				上限=22
				经验=0
			elseif 当前 ==14 then
				当前 =12
				上限=22
				经验=0
			elseif 当前==13 then
				当前 =12
				上限=21
				经验=0
			end
			self.bb修炼[as1[i]][1],self.bb修炼[as1[i]][2],self.bb修炼[as1[i]][3]=当前,经验,上限
		end
	end
end

function 角色处理类:帮派降修(类型)
	if 类型 == "攻击修炼" or 类型 == "防御修炼" or 类型 == "法术修炼" or 类型 == "抗法修炼" or 类型 == "猎术修炼" then
		if self.修炼[类型] and self.修炼[类型][3] < 25 and self.修炼[类型][1] == self.修炼[类型][3] then
			self.修炼[类型][1] = self.修炼[类型][1]-1
			self.修炼[类型][3] = self.修炼[类型][3]+1
			self.修炼[类型][2] = 0
			添加最后对话(self.数字id,"你的人物#R"..类型.."#W修炼上限提升至".."#R"..self.修炼[类型][3].."#W修炼降低至".."#R"..self.修炼[类型][1])
			刷新修炼数据(self.数字id)
		else
			添加最后对话(self.数字id,"你的修炼等级没有达到修炼上限，无法降低修炼提升修炼上限")
		end
	elseif 类型 == "攻击控制力" or 类型 == "防御控制力" or 类型 == "法术控制力" or 类型 == "抗法控制力"  then
		if self.bb修炼[类型] and self.bb修炼[类型][3] < 25 and self.bb修炼[类型][1] == self.bb修炼[类型][3] then
			self.bb修炼[类型][1] = self.bb修炼[类型][1]-1
			self.bb修炼[类型][3] = self.bb修炼[类型][3]+1
			self.bb修炼[类型][2] = 0
			添加最后对话(self.数字id,"你的召唤兽#R"..类型.."#W修炼上限提升至".."#R"..self.bb修炼[类型][3].."#W修炼降低至".."#R"..self.bb修炼[类型][1])
			刷新修炼数据(self.数字id)
		else
				添加最后对话(self.数字id,"你的修炼等级没有达到修炼上限，无法降低修炼提升修炼上限")
		end
	end
end

function 角色处理类:修炼测试()
	local as = {"攻击修炼", "防御修炼", "法术修炼", "抗法修炼", "猎术修炼"}
	local as1 = {"攻击控制力", "防御控制力", "法术控制力", "抗法控制力"}
	for i = 1, #as do
		self.修炼[as[i]][1],self.修炼[as[i]][2],self.修炼[as[i]][3]=20,0,20
	end
	for i = 1, #as1 do
		self.bb修炼[as1[i]][1],self.bb修炼[as1[i]][2],self.bb修炼[as1[i]][3]= 20,0,20
	end
	刷新修炼数据(self.数字id)
end

function 角色处理类:帮派学习修炼(类型,修炼项目)
	if 修炼项目 == nil then
		常规提示(self.数字id,"#Y/请选择你要提升的修炼")
		return
	 end
	local 消耗银子 = 60000
	 local 帮派编号 = self.BPBH
	 local 帮派资材 = 帮派数据[帮派编号].帮派资材.当前
	 local 帮贡上限 = 帮派数据[帮派编号].成员数据[self.数字id].帮贡.上限
	 local 当前储备 = self.储备
	 if 取银子(self.数字id) < 消耗银子 and 当前储备 < 消耗银子*2 then
			常规提示(self.数字id,"#Y/你的当前的银子不够修炼哦")
			return
	 end
	if 帮派资材 < 5 then
		常规提示(self.数字id,"#Y/贵帮当前的资材不足，无法进行帮派点修")
		return
	end
	if 类型=="人物修炼" then
		if self.修炼[修炼项目][1] > qz(帮贡上限/150) then
				常规提示(数字id,"#Y/继续学习这个修炼项目需帮贡上限不低于"..qz(帮贡上限/150))
				return
		 end
		 if self.修炼[修炼项目][1] >= self.修炼[修炼项目][3] then 常规提示(self.数字id, "#Y/你的此项修炼已经达上限") return end
		 帮派数据[帮派编号].帮派资材.当前 = 帮派数据[帮派编号].帮派资材.当前 -5
		 if 当前储备 >= 消耗银子*2 then
			self.储备=self.储备-消耗银子*2
			self:日志记录("帮派提升修炼消耗"..(消耗银子*2).."点储备")
			消息提示(self.数字id, "你失去了"..(消耗银子*2).."两储备")
		else
			self:扣除银子(消耗银子,0,0,"帮派点修",1)
		end
		self.修炼[修炼项目][2] = self.修炼[修炼项目][2] + 100
		常规提示(self.数字id, format("你的人物%s经验增加了%s点", 修炼项目, 100))
		if (self.修炼[修炼项目][2] >= 计算修炼等级经验(self.修炼[修炼项目][1], self.修炼[修炼项目][3])) then
			self.修炼[修炼项目][2] = self.修炼[修炼项目][2] - 计算修炼等级经验(self.修炼[修炼项目][1], self.修炼[修炼项目][3])
			self.修炼[修炼项目][1] = self.修炼[修炼项目][1] + 1
			常规提示(self.数字id, format("你的人物%s等级提升至%s级", 修炼项目, self.修炼[修炼项目][1]))
		end
		刷新修炼数据(self.数字id)
		发送数据(玩家数据[self.数字id].连接id,210,{修炼=self.修炼,帮派资材=帮派数据[帮派编号].帮派资材.当前,银子=self.银子,储备=self.储备})
	else
		if self.bb修炼[修炼项目][1] > qz(帮贡上限/150) then
				常规提示(数字id,"#Y/继续学习这个修炼项目需帮贡上限不低于"..qz(帮贡上限/150))
				return
		 end
		 if self.bb修炼[修炼项目][1] >= self.bb修炼[修炼项目][3] then 常规提示(self.数字id, "#Y/你的此项修炼已经达上限") return end
		 帮派数据[帮派编号].帮派资材.当前 = 帮派数据[帮派编号].帮派资材.当前 -5
		 if 当前储备 >= 消耗银子*2 then
			self.储备=self.储备-消耗银子*2
			self:日志记录("帮派提升修炼消耗"..(消耗银子*2).."点储备")
			消息提示(self.数字id, "你失去了"..(消耗银子*2).."两储备")
		else
			self:扣除银子(消耗银子,0,0,"帮派点修",1)
		end
		self.bb修炼[修炼项目][2] = self.bb修炼[修炼项目][2] + 20
		常规提示(self.数字id, format("你的召唤兽%s经验增加了%s点", 修炼项目, 20))
		if (self.bb修炼[修炼项目][2] >= 计算修炼等级经验(self.bb修炼[修炼项目][1], self.bb修炼[修炼项目][3])) then
			self.bb修炼[修炼项目][2] = self.bb修炼[修炼项目][2] - 计算修炼等级经验(self.bb修炼[修炼项目][1], self.bb修炼[修炼项目][3])
			self.bb修炼[修炼项目][1] = self.bb修炼[修炼项目][1] + 1
			常规提示(self.数字id, format("你的召唤兽%s等级提升至%s级", 修炼项目, self.bb修炼[修炼项目][1]))
		end
		刷新修炼数据(self.数字id)
		发送数据(玩家数据[self.数字id].连接id,210,{修炼=self.bb修炼,帮派资材=帮派数据[帮派编号].帮派资材.当前,银子=self.银子,储备=self.储备})
	end
end

function 角色处理类:帮派免资材学习修炼(类型,修炼项目)
	if 修炼项目 == nil then
		常规提示(self.数字id,"#Y/请选择你要提升的修炼")
		return
	 end
	local 消耗银子 = 150000
	 local 帮派编号 = self.BPBH
	 local 帮贡上限 = 帮派数据[帮派编号].成员数据[self.数字id].帮贡.上限
	 local 当前储备 = self.储备
	 if 取银子(self.数字id) < 消耗银子 and 当前储备 < 消耗银子*2 then
			常规提示(self.数字id,"#Y/你的当前的银子不够修炼哦")
			return
	 elseif self.MZC.次数<=0 then
		常规提示(self.数字id,"#Y/今日剩余次数不足，"..时间转换(self.MZC.时间).."后才能继续免资材学习！")
			return
	 end
	if 类型=="人物修炼" then
		if self.修炼[修炼项目][1] > qz(帮贡上限/150) then
				常规提示(数字id,"#Y/继续学习这个修炼项目需帮派帮贡上限不低于"..qz(帮贡上限/150))
				return
		 end
		 if self.修炼[修炼项目][1] >= self.修炼[修炼项目][3] then 常规提示(self.数字id, "#Y/你的此项修炼已经达上限") return end
		 if 当前储备 >= 消耗银子*2 then
			self.储备=self.储备-消耗银子*2
			self:日志记录("帮派提升修炼消耗"..(消耗银子*2).."点储备")
			消息提示(self.数字id, "你失去了"..(消耗银子*2).."两储备")
		else
			self:扣除银子(消耗银子,0,0,"帮派点修",1)
		end
		self.修炼[修炼项目][2] = self.修炼[修炼项目][2] + 100
		常规提示(self.数字id, format("你的人物%s经验增加了%s点", 修炼项目, 100))
		if (self.修炼[修炼项目][2] >= 计算修炼等级经验(self.修炼[修炼项目][1], self.修炼[修炼项目][3])) then
			self.修炼[修炼项目][2] = self.修炼[修炼项目][2] - 计算修炼等级经验(self.修炼[修炼项目][1], self.修炼[修炼项目][3])
			self.修炼[修炼项目][1] = self.修炼[修炼项目][1] + 1
			常规提示(self.数字id, format("你的人物%s等级提升至%s级", 修炼项目, self.修炼[修炼项目][1]))
		end
		self.MZC.次数=self.MZC.次数-1
		刷新修炼数据(self.数字id)
		发送数据(玩家数据[self.数字id].连接id,210,{修炼=self.修炼,帮派资材=帮派数据[帮派编号].帮派资材.当前,银子=self.银子,储备=self.储备,免资材=self.MZC.次数})
	else
		if self.bb修炼[修炼项目][1] > qz(帮贡上限/150) then
				常规提示(数字id,"#Y/继续学习这个修炼项目需帮派帮贡上限不低于"..qz(帮贡上限/150))
				return
		 end
		 if self.bb修炼[修炼项目][1] >= self.bb修炼[修炼项目][3] then 常规提示(self.数字id, "#Y/你的此项修炼已经达上限") return end
		 if 当前储备 >= 消耗银子*2 then
			self.储备=self.储备-消耗银子*2
			self:日志记录("帮派提升修炼消耗"..(消耗银子*2).."点储备")
			消息提示(self.数字id, "你失去了"..(消耗银子*2).."两储备")
		else
			self:扣除银子(消耗银子,0,0,"帮派点修",1)
		end
		self.bb修炼[修炼项目][2] = self.bb修炼[修炼项目][2] + 20
		常规提示(self.数字id, format("你的召唤兽%s经验增加了%s点", 修炼项目, 20))
		if (self.bb修炼[修炼项目][2] >= 计算修炼等级经验(self.bb修炼[修炼项目][1], self.bb修炼[修炼项目][3])) then
			self.bb修炼[修炼项目][2] = self.bb修炼[修炼项目][2] - 计算修炼等级经验(self.bb修炼[修炼项目][1], self.bb修炼[修炼项目][3])
			self.bb修炼[修炼项目][1] = self.bb修炼[修炼项目][1] + 1
			常规提示(self.数字id, format("你的召唤兽%s等级提升至%s级", 修炼项目, self.bb修炼[修炼项目][1]))
		end
		self.MZC.次数=self.MZC.次数-1
		刷新修炼数据(self.数字id)
		发送数据(玩家数据[self.数字id].连接id,210,{修炼=self.bb修炼,帮派资材=帮派数据[帮派编号].帮派资材.当前,银子=self.银子,储备=self.储备,免资材=self.MZC.次数})
	end
end

function 角色处理类:添加人物修炼经验(id,数值)
	if self.修炼[self.修炼.当前][1]>=self.修炼[self.修炼.当前][3] then
		-- 常规提示(id,format("你的该项经验已经达到上限，无法继续获得修炼经验"))
		return false
	end
	self.修炼[self.修炼.当前][2] = self.修炼[self.修炼.当前][2] + 数值
	常规提示(id, format("你的人物%s经验增加了%s点", self.修炼.当前, 数值))
	while(self.修炼[self.修炼.当前][2] >= 计算修炼等级经验(self.修炼[self.修炼.当前][1], self.修炼[self.修炼.当前][3])) do
		self.修炼[self.修炼.当前][2] = self.修炼[self.修炼.当前][2] - 计算修炼等级经验(self.修炼[self.修炼.当前][1], self.修炼[self.修炼.当前][3])
		self.修炼[self.修炼.当前][1] = self.修炼[self.修炼.当前][1] + 1
		常规提示(id, format("你的人物%s等级提升至%s级", self.修炼.当前, self.修炼[self.修炼.当前][1]))
	end
	刷新修炼数据(id)
	return true
end

function 角色处理类:添加bb修炼经验(id, 数值)
	if self.bb修炼[self.bb修炼.当前][1]>=self.bb修炼[self.bb修炼.当前][3] then
		-- 常规提示(id,format("你的该项经验已经达到上限，无法继续获得修炼经验"))
		return false
	end
	self.bb修炼[self.bb修炼.当前][2] = self.bb修炼[self.bb修炼.当前][2] + 数值
	常规提示(id, format("你的召唤兽%s经验增加了%s点", self.bb修炼.当前, 数值))
	while(self.bb修炼[self.bb修炼.当前][2] >= 计算修炼等级经验(self.bb修炼[self.bb修炼.当前][1], self.bb修炼[self.bb修炼.当前][3])) do
		self.bb修炼[self.bb修炼.当前][2] = self.bb修炼[self.bb修炼.当前][2] - 计算修炼等级经验(self.bb修炼[self.bb修炼.当前][1], self.bb修炼[self.bb修炼.当前][3])
		self.bb修炼[self.bb修炼.当前][1] = self.bb修炼[self.bb修炼.当前][1] + 1
		常规提示(id, format("你的召唤兽%s等级提升至%s级", self.bb修炼.当前, self.bb修炼[self.bb修炼.当前][1]))
	end
	刷新修炼数据(id)
	return true
end

function 角色处理类:添加法宝灵气(id, 类型, 下限, 上限)
	for n = 1, 4 do
		local 符合 = false
		if 玩家数据[id].角色.法宝佩戴[n] ~= nil then
			local 道具id = 玩家数据[id].角色.法宝佩戴[n]
			if 玩家数据[id].道具.数据[道具id] ~= nil then
				local 名称 = 玩家数据[id].道具.数据[道具id].名称
				local 境界 = 玩家数据[id].道具.数据[道具id].气血
				local 灵气 = 玩家数据[id].道具.数据[道具id].魔法
				local 等级 = 0
				if 境界 <= 5 then
					等级 = 30
				elseif 境界 <= 10 then
					等级 = 60
				else
					等级 = 100
				end
				if 下限 <= 等级 and 等级 <= 上限 then
					if 灵气 >= 取灵气上限(玩家数据[id].道具.数据[道具id].分类) then
						发送数据(玩家数据[id].连接id, 38, {内容 = "你的法宝灵气已满，无法再增加灵气了"})
					else
						玩家数据[id].道具.数据[道具id].魔法 = 玩家数据[id].道具.数据[道具id].魔法 + 2
						发送数据(玩家数据[id].连接id, 38, {内容 = "你的法宝灵气灵气增加了1点"})
					end
				end
			end
		end
	end
end

function 角色处理类:取法宝格子()
	for n = 1, 180 do
		if self.法宝[n] == nil then
			return n
		end
	end
	return 0
end

function 角色处理类:取灵宝格子()
	for n = 1, 20 do
		if self.灵宝[n] == nil then
			return n
		end
	end
	return 0
end

function 角色处理类:取行囊格子()
	for n = 1, 20 do
		if self.行囊[n] == nil then
			return n
		end
	end
	return 0
end

function 角色处理类:取道具格子()
	for n = 1,80  do
		if self.道具[n] == nil then
			return n
		end
	end
	return 0
end

function 角色处理类:取空道具格子数量()
	local fhz = 0
	for n = 1, 80 do
		if self.道具[n] == nil then
			fhz = fhz+1
		end
	end
	return fhz
end

function 角色处理类:取临时格子()
	for n = 1, 20 do
		if self.临时包裹[n] == nil then
			return n
		end
	end
	return 0
end

function 角色处理类:取任务格子()
	for n = 1, 20 do
		if self.任务包裹[n] == nil then
			return n
		end
	end
	return 0
end

function 角色处理类:取道具格子2()
	local 数量 = 0
	for n = 1, 80 do
		if self.道具[n] == nil then
			数量 = 数量 + 1
		end
	end
	return 数量
end

function 角色处理类:取道具格子1(类型)
	for n = 1,80 do
		if self[类型][n] == nil then
			return n
		end
	end
	return 0
end

function 角色处理类:清空临时包裹()
	for k,v in pairs(self.临时包裹) do
		玩家数据[self.数字id].道具.数据[self.临时包裹[k]] = nil
	end
	self.临时包裹 = {}
end

function 角色处理类:生活技能学习条件(名称,角色等级,目标技能等级)
	if 名称=="强壮" or 名称=="神速" then
		 if 目标技能等级>60 then
				return false
		 elseif 角色等级 /1<目标技能等级 then
			return false
		 end
	elseif 名称=="强身术" then
		if 目标技能等级>160 then
				return false
		 end
	else
		if 目标技能等级>160 then
				return false
		 end
	end
end
function 角色处理类:判断抓鬼卡日期(id)
	if 玩家数据[id].角色.自动抓鬼==nil then
		玩家数据[id].角色.自动抓鬼={领取日期=0,次数=0}
	end
	if 玩家数据[id].角色.自动抓鬼.领取日期 ~= tonumber(os.date("%Y%m%d")) then
		玩家数据[id].角色.自动抓鬼.领取日期 = tonumber(os.date("%Y%m%d"))
		if 玩家数据[id].角色.自动抓鬼.次数<0 then 玩家数据[id].角色.自动抓鬼.次数=0 end
		玩家数据[id].角色.自动抓鬼.次数 = __Zdzgcs+0
		常规提示(id,"领取成功，你获得"..__Zdzgcs.."个自动抓鬼次数~")
	else
		if 玩家数据[id].角色.自动抓鬼.次数<0 then 玩家数据[id].角色.自动抓鬼.次数=0 end
	end
	添加最后对话(id, "#W你今日的自动抓鬼次数还剩：#G"..玩家数据[id].角色.自动抓鬼.次数.."#W个，是否需要为你传送去地府幻境？",{"传送去地府幻境","手滑点错了"})
end

function 角色处理类:学习强化技能(连接id, id, 编号) --人物状态栏界面学习
	local 当前等级 = self.强化技能[编号].等级
	local 消耗经验 = 当前等级*50000
	local 消耗银子 = 当前等级*50000
	local jn等级上限 = 160
	if self.强化技能[编号] == nil then
		常规提示(id, "你没有这样的技能")
		return
	elseif self.银子 < 消耗银子 then
		常规提示(id, "银子不够学习技能")
		return
	elseif self.当前经验 < 消耗经验 then
		常规提示(id, "经验不够学习技能")
		return
	elseif self.强化技能[编号].等级 >= jn等级上限 then
		常规提示(id, "该技能等级已达到上限")
		return
	end
	self:扣除银子(消耗银子,0,0,"学习技能")
	self:扣除经验(消耗经验)
	self.强化技能[编号].学会 = true
	self.强化技能[编号].等级 = self.强化技能[编号].等级 + 1
	self:刷新信息("0")
	发送数据(连接id, 31, 玩家数据[id].角色:取总数据1())
	发送数据(连接id, 34.9, {序列 = 编号, 等级 = self.强化技能[编号].等级,名称=self.强化技能[编号].名称})
end

function 角色处理类:学习生活技能(连接id, id, 编号) --人物状态栏界面学习
	if self.辅助技能[编号].等级 >= 0 and self.BPMC ~= "无帮派" then
		 return self:帮派学习生活技能(编号)
	end
	if self.辅助技能[编号] == 0 then
		常规提示(id, "你没有这样的技能")
		return
	elseif self.辅助技能[编号].等级 >= 40 and self.BPMC == "无帮派" then
		常规提示(id, "你必须先加入一个帮派才可继续学习！")
		return
	elseif self.辅助技能[编号].技能=="强壮" or self.辅助技能[编号].技能=="神速" then
		常规提示(id, "强壮神速需要加入帮派才能进行学习！")
		return
	end
	if self.BPMC ~= "无帮派" and 帮派数据[self.BPBH].技能数据[self.辅助技能[编号].名称].当前<self.辅助技能[编号].等级+1 then
		 常规提示(id, "帮派技能等级不足，无法继续学习！")
		return
	end
	if self:生活技能学习条件(self.辅助技能[编号].名称,self.等级,self.辅助技能[编号].等级+1) ==false then
		 常规提示(id, "当前技能等级已满，或角色可学习等级不足！")
		return
	end
	 self.辅助技能[编号].等级=qz(self.辅助技能[编号].等级)
	local 临时消耗 = self:生活技能消耗(self.辅助技能[编号].等级 + 1,self.辅助技能[编号].名称)

	if self.当前经验 < 临时消耗.经验 then
		常规提示(id, "你没有那么多的经验")
		return
	end
	local 提示 = ""
	if self.储备 >= 临时消耗.金钱 then
		self.储备 = self.储备 - 临时消耗.金钱
		常规提示(id,"学习成功,你消耗了"..临时消耗.金钱.."储备银子以及"..临时消耗.经验.."经验")
		self:日志记录("学习生活技能["..self.辅助技能[编号].名称.."]消耗"..self.储备.."点储备")
		self:银子记录()
	elseif self.储备 + self.银子 >= 临时消耗.金钱 then
		临时消耗.金钱 = 临时消耗.金钱 - self.储备
		常规提示(id,"学习成功,你消耗了"..临时消耗.金钱.."银子以及"..临时消耗.经验.."经验")
		self:日志记录("学习生活技能["..self.辅助技能[编号].名称.."]消耗"..self.储备.."点储备、"..临时消耗.金钱.."两银子")
		self:银子记录()
		self.银子 = self.银子 - 临时消耗.金钱
		self.储备 = 0
	else
		常规提示(id, "你没有那么多的银子")
		return
	end
	self.当前经验 = self.当前经验 - 临时消耗.经验
	self:日志记录("学习生活技能["..self.辅助技能[编号].名称.."]消耗"..临时消耗.经验.."点经验")
	self:银子记录()
	self.辅助技能[编号].等级 = self.辅助技能[编号].等级 + 1
	发送数据(连接id, 34, {序列 = 编号, 等级 = self.辅助技能[编号].等级,名称=self.辅助技能[编号].名称})
	刷新玩家货币(连接id, id)
	local 名称 = self.辅助技能[编号].名称
	if 名称 == "强身术" or 名称 == "健身术" or 名称 == "冥想" or 名称 == "养生之道" or 名称 == "强壮" or 名称 == "神速" then
		self:刷新信息("0")
		发送数据(连接id, 31, 玩家数据[id].角色:取总数据1())
	end
end

function 角色处理类:帮派学习生活技能(编号)
	if self.辅助技能[编号] == 0 or 编号>18 then
		常规提示(self.数字id, "你没有这样的技能")
		return
	end
	if self.BPMC ~= "无帮派" and 帮派数据[self.BPBH].技能数据[self.辅助技能[编号].名称].当前<self.辅助技能[编号].等级+1 then
		 常规提示(self.数字id, "帮派技能等级不足，无法继续学习！")
		return
	end
	if self:生活技能学习条件(self.辅助技能[编号].名称,self.等级,self.辅助技能[编号].等级+1) ==false then
		 常规提示(self.数字id, "当前技能等级已满，或角色可学习等级不足！详情参考【生活技能学习条件】")
		return
	end
	 self.辅助技能[编号].等级=qz(self.辅助技能[编号].等级)
	local 临时消耗 = self:生活技能消耗(self.辅助技能[编号].等级 + 1,self.辅助技能[编号].名称)

	if self.当前经验 < 临时消耗.经验 then
		常规提示(self.数字id, "你没有那么多的经验")
		return
	end
	if self.BG < 临时消耗.需求 then 常规提示(self.数字id, "本次需角色帮贡达到"..临时消耗.需求.."点以上才能继续学习") return end
	local 提示 = ""
	if self.储备 >= 临时消耗.金钱 then
		self.储备 = self.储备 - 临时消耗.金钱
		常规提示(self.数字id,"学习成功,你消耗了"..临时消耗.金钱.."储备银子以及"..临时消耗.经验.."点经验"..临时消耗.帮贡.."点帮贡")
		self:日志记录("学习生活技能["..self.辅助技能[编号].名称.."]消耗"..self.储备.."点储备")
		self:银子记录()
	elseif self.储备 + self.银子 >= 临时消耗.金钱 then
		临时消耗.金钱 = 临时消耗.金钱 - self.储备
		常规提示(self.数字id,"学习成功,你消耗了"..临时消耗.金钱.."银子以及"..临时消耗.经验.."点经验"..临时消耗.帮贡.."点帮贡")
		self:日志记录("学习生活技能["..self.辅助技能[编号].名称.."]消耗"..self.储备.."点储备、"..临时消耗.金钱.."两银子")
		self:银子记录()
		self.银子 = self.银子 - 临时消耗.金钱
		self.储备 = 0
	else
		常规提示(self.数字id, "你没有那么多的银子")
		return
	end
	self.BG = self.BG - 临时消耗.帮贡
	self.当前经验 = self.当前经验 - 临时消耗.经验
	self:日志记录("学习生活技能["..self.辅助技能[编号].名称.."]消耗"..临时消耗.经验.."点经验")
	self:银子记录()
	self.辅助技能[编号].等级 = self.辅助技能[编号].等级 + 1
	发送数据(玩家数据[self.数字id].连接id, 34, {序列 = 编号, 等级 = self.辅助技能[编号].等级,名称=self.辅助技能[编号].名称})
	刷新玩家货币(玩家数据[self.数字id].连接id, self.数字id)
	local 名称 = self.辅助技能[编号].名称
	if 名称 == "强身术" or 名称 == "健身术" or 名称 == "冥想" or 名称 == "养生之道" or 名称 == "强壮" or 名称 == "神速" then
		self:刷新信息("0")
		发送数据(玩家数据[self.数字id].连接id, 31, 玩家数据[self.数字id].角色:取总数据1())
	end
end

function 角色处理类:学习剧情技能(id, 名称, 消耗, 上限)
	if self.剧情点.当前 < 消耗 then
		常规提示(id, "你的剧情点不够哟")
		return
	end
	local 编号 = 0
	for n = 1, #self.剧情技能 do
		if self.剧情技能[n].名称 == 名称 then
			编号 = n
		end
	end
	if 编号 ~= 0 then
		if self.剧情技能[编号].等级 >= 上限 then
			常规提示(id, "你的这项技能等级已达上限")
			return
		end
	else
		self.剧情技能[#self.剧情技能 + 1] = {名称 = 名称, 等级 = 0}
		编号 = #self.剧情技能
	end
	self.剧情点.当前 = self.剧情点.当前 - 消耗
	self.剧情技能[编号].等级 = self.剧情技能[编号].等级 + 1
	常规提示(id, "#Y/你的剧情点减少了"..消耗.."点")
	常规提示(id, "你的"..名称.."等级提升至"..self.剧情技能[编号].等级.."级")
end

function 角色处理类:门派转换(内容)
	if self.门派 == "无门派" then
		常规提示(self.数字id,"请先加入一个门派")
		return
	end
	if not self:属性转换检测() then
		 return
	end
	local 目标角色=内容.角色
	local 目标门派=内容.门派
	local 支付方式=内容.支付方式
	local 性别 = "男"
	local 种族 = "人"
	if 目标角色=="影精灵" or 目标角色=="飞燕女" or 目标角色=="英女侠" or 目标角色=="巫蛮儿" or 目标角色=="狐美人" or 目标角色=="骨精灵" or 目标角色=="鬼潇潇" or 目标角色=="舞天姬" or 目标角色=="玄彩娥" or 目标角色=="桃夭夭" then
		 性别="女"
		 if 目标角色=="狐美人" or 目标角色=="骨精灵" or 目标角色=="影精灵" or 目标角色=="鬼潇潇" then
		种族 = "魔"
	elseif 目标角色=="舞天姬" or 目标角色=="玄彩娥" or 目标角色=="桃夭夭" then
		种族 = "仙"
		 end
	elseif 目标角色=="杀破狼" or 目标角色=="巨魔王" or 目标角色=="虎头怪" then
		种族 = "魔"
	elseif 目标角色=="羽灵神" or 目标角色=="神天兵" or 目标角色=="龙太子" then
		种族 = "仙"
	end
	-- if 可入门派[种族][目标门派] == nil and 可入门派[种族][性别][目标门派] == nil then
	-- 	常规提示(self.数字id, "本门派不收你这样的弟子")
	-- 	return
	-- end
	if 目标角色 ~= '影精灵' then
	    if 可入门派[种族][目标门派] == nil and 可入门派[种族][性别][目标门派] == nil then
			常规提示(self.数字id, "本门派不收你这样的弟子")
			return
		end
	else
		if 目标门派 ~= '九黎城' then
		    常规提示(self.数字id, "影精灵只可以加入九黎城")
			return
		end
	end
	if self.转门派==nil then --直接免费
		self.转门派=1
		if self.模型~=目标角色 then
			local ls = self:队伍角色(目标角色)
			self.性别 = 性别
			self.模型 = 目标角色
			self.造型 = 目标角色
			self.种族 = 种族
			self.染色方案 = ls.染色方案
			self.可持有武器 = ls.武器
		end
		local 复刻师门等级={}
		for i=1,#self.师门技能 do
			 复刻师门等级[i]=self.师门技能[i].等级
		end
		self.快捷技能 = {}
		发送数据(玩家数据[self.数字id].连接id, 42, self.快捷技能)
		self.门派 = 目标门派
		self.师门技能 = {}
		self.人物技能 = {}
		self.技能属性 = {气血 = 0, 魔法 = 0, 命中 = 0, 伤害 = 0, 防御 = 0, 速度 = 0, 躲避 = 0, 灵力 = 0, 体质 = 0, 魔力 = 0, 力量 = 0, 耐力 = 0, 敏捷 = 0}
		self:刷新信息("0")
		self.奇经八脉 = {}
		self.奇经八脉 = 取经脉流派(self.门派)
		self.奇经八脉.开启奇经八脉 = true
		self.奇经八脉.技能树 = {1, 2, 3}
		self.QYD.可用乾元丹 = self.QYD.已换乾元丹 + self.QYD.额外乾元丹
		self.QYD.已用乾元丹 = 0
		local 列表 = self:取门派技能(目标门派)
		for n = 1, #列表 do
			local 等级 = 复刻师门等级[n]
			self.师门技能[n] = jnzbzz()
			self.师门技能[n]:置对象(列表[n])
			self.师门技能[n].包含技能 = {}
			self.师门技能[n].等级 = 等级
			local w = self:取包含技能(self.师门技能[n].名称,self.奇经八脉["当前流派"])
			for s = 1, #w do
				self.师门技能[n].包含技能[s] = jnzbzz()
				self.师门技能[n].包含技能[s]:置对象(w[s])
				self.师门技能[n].包含技能[s].等级 = 等级
			end
			self:升级技能(self.师门技能[n],self.奇经八脉["当前流派"])
		end
		self.招式特效= 取门派招式特效(self.门派)
			self:刷新信息("0")
	else
		if 支付方式=="经验银子" and not 玩家数据[self.数字id].角色.武神坛角色 then
			 if self.模型~=目标角色 then
					if self.当前经验<20000000 then
					常规提示(self.数字id, "#Y经验不足")
						return
					elseif self.银子<5000000 then
						常规提示(self.数字id, "#Y银子不足")
						return
					end
					self:扣除银子(5000000,0,0,"转换门派")
					self:扣除经验(20000000)
			 else
				if self.当前经验<10000000 then
					常规提示(self.数字id, "#Y经验不足")
						return
					elseif self.银子<5000000 then
						常规提示(self.数字id, "#Y银子不足")
						return
					end
					self:扣除银子(5000000,0,0,"转换门派")
					self:扣除经验(10000000)
			 end
		else
			if not 玩家数据[self.数字id].角色.武神坛角色 then
			if self.模型~=目标角色 then
					if self.银子<15000000 then
					常规提示(self.数字id, "#Y银子不足")
						return
					end
					self:扣除银子(15000000,0,0,"转换门派")
			 else
				if self.银子<10000000 then
					常规提示(self.数字id, "#Y银子不足")
						return
					end
					self:扣除银子(10000000,0,0,"转换门派")
			 end
			end
		end
		 self.转门派=2
		if self.模型~=目标角色 then
			local ls = self:队伍角色(目标角色)
			self.性别 = 性别
			self.模型 = 目标角色
			self.造型 = 目标角色
			self.种族 = 种族
			self.染色方案 = ls.染色方案
			self.可持有武器 = ls.武器
		end
		local 复刻师门等级={}
		for i=1,#self.师门技能 do
			 复刻师门等级[i]=self.师门技能[i].等级
		end
		self.快捷技能 = {}
		发送数据(玩家数据[self.数字id].连接id, 42, self.快捷技能)
		self.门派 = 目标门派
		self.师门技能 = {}
		self.人物技能 = {}
		self.技能属性 = {气血 = 0, 魔法 = 0, 命中 = 0, 伤害 = 0, 防御 = 0, 速度 = 0, 躲避 = 0, 灵力 = 0, 体质 = 0, 魔力 = 0, 力量 = 0, 耐力 = 0, 敏捷 = 0}
		self:刷新信息("0")

		self.奇经八脉 = {}
		self.奇经八脉 = 取经脉流派(self.门派)
		self.奇经八脉.开启奇经八脉 = true
		self.奇经八脉.技能树 = {1, 2, 3}
		self.QYD.可用乾元丹 = self.QYD.已换乾元丹 + self.QYD.额外乾元丹
		self.QYD.已用乾元丹 = 0

		local 列表 = self:取门派技能(目标门派)
		for n = 1, #列表 do
			local 等级 = 复刻师门等级[n]
			self.师门技能[n] = jnzbzz()
			self.师门技能[n]:置对象(列表[n])
			self.师门技能[n].包含技能 = {}
			self.师门技能[n].等级 = 等级
			local w = self:取包含技能(self.师门技能[n].名称,self.奇经八脉["当前流派"])
			for s = 1, #w do
				self.师门技能[n].包含技能[s] = jnzbzz()
				self.师门技能[n].包含技能[s]:置对象(w[s])
				self.师门技能[n].包含技能[s].等级 = 等级
			end
			self:升级技能(self.师门技能[n],self.奇经八脉["当前流派"])
		end
		self.招式特效= 取门派招式特效(self.门派)
			self:刷新信息("0")
	end
	self.安卓快捷施法={}
	self:洗点操作(self.数字id,"免费")
	if 玩家数据[self.数字id].神器 and 玩家数据[self.数字id].神器.数据 and 玩家数据[self.数字id].神器.数据.是否有 and self.门派~="无门派" then
		玩家数据[self.数字id].神器:转换神器(self.数字id)
	end
	self:存档()
	常规提示(self.数字id, "转换门派成功，请重新上线！")
end

function 角色处理类:学习门派技能(连接id, id, 编号)
	if self.师门技能[编号] == nil then
		常规提示(id, "你没有这样的技能")
		return
	elseif self.师门技能[编号].等级 >= self.等级 + 10 or self.师门技能[编号].等级 >= 180 then
		if self.师门技能[编号].等级 >= self.等级 + 10 then
			常规提示(id, "门派技能不能超过角色等级+10")
		elseif self.师门技能[编号].等级 >= 180 then
			常规提示(id, "门派技能不能超180级")
		end
		return
	elseif self.师门技能[编号].等级>=self.师门技能[self:取门派基础技能(id,self.门派).编号].等级 and 编号 ~= self:取门派基础技能(id,self.门派).编号 then
		 常规提示(id,"请先提升门派基础技能"..self:取门派基础技能(id,self.门派).基础技能)
		 return
	else
		--计算消耗的经验 金钱
		local 临时消耗 = self:师门技能消耗(self.师门技能[编号].等级 + 1)
		if self.当前经验 < 临时消耗.经验 then
			常规提示(id, "你没有那么多的经验")
			return
		end
		local 提示 = ""
		if self.储备 >= 临时消耗.金钱 then
			self.储备 = self.储备 - 临时消耗.金钱
		elseif self.银子 >= 临时消耗.金钱 then
			self.银子 = self.银子 - 临时消耗.金钱
		elseif self.储备 + self.银子 >= 临时消耗.金钱 then
			local x临时消耗 = 临时消耗.金钱 - self.储备
			self:银子记录()
			self.银子 = self.银子 - x临时消耗
			self.储备 = 0
		elseif self.储备 + self.银子 + self.存银 >= 临时消耗.金钱 then
			local x临时消耗 = 临时消耗.金钱 - (self.储备 + self.银子)
			self.银子 = 0
			self.储备 = 0
			self:银子记录()
			self.存银 = self.存银 - x临时消耗
		else
			常规提示(id, "你没有那么多的银子")
			return
		end
		self.当前经验 = self.当前经验 - 临时消耗.经验
		发送数据(玩家数据[self.数字id].连接id, 38, {内容 = "你消耗"..临时消耗.金钱.."点银两" .. "\n你消耗了"..临时消耗.经验.."点经验"})
		self:日志记录("学习师门技能["..self.师门技能[编号].名称.."]消耗"..临时消耗.金钱.."点金钱和 "..临时消耗.经验.."点经验")
		self:银子记录()
		self.师门技能[编号].等级 = self.师门技能[编号].等级 + 1
		self:升级技能(self.师门技能[编号],self.奇经八脉["当前流派"])
		发送数据(连接id, 31, 玩家数据[id].角色:取总数据1())
		刷新玩家货币(连接id, id)
	end
end

function 角色处理类:测试模式升级十次技能(连接id,id)
	for i=1,10 do
		for n=1,7 do
			self.师门技能[n].等级 = self.师门技能[n].等级 + 1
			self:升级技能(self.师门技能[n],self.奇经八脉["当前流派"])
		end
	end
	发送数据(连接id, 31, 玩家数据[id].角色:取总数据1())
end

function 角色处理类:银子记录()
	self:日志记录(self.当前经验.."点经验、"..self.储备.."点储备、"..self.银子.."两银子、"..self.存银.."两存银")
end

function 角色处理类:师门技能消耗(目标技能等级)
	local 等级 = 目标技能等级
	local 技能消耗 = {}
	技能消耗[1] = {经验 = 16, 金钱 = 6}
	技能消耗[2] = {经验 = 32, 金钱 = 12}
	技能消耗[3] = {经验 = 52, 金钱 = 19}
	技能消耗[4] = {经验 = 75, 金钱 = 28}
	技能消耗[5] = {经验 = 103, 金钱 = 38}
	技能消耗[6] = {经验 = 136, 金钱 = 51}
	技能消耗[7] = {经验 = 179, 金钱 = 67}
	技能消耗[8] = {经验 = 231, 金钱 = 86}
	技能消耗[9] = {经验 = 295, 金钱 = 110}
	技能消耗[10] = {经验 = 372, 金钱 = 139}
	技能消耗[11] = {经验 = 466, 金钱 = 174}
	技能消耗[12] = {经验 = 578, 金钱 = 216}
	技能消耗[13] = {经验 = 711, 金钱 = 266}
	技能消耗[14] = {经验 = 867, 金钱 = 325}
	技能消耗[15] = {经验 = 1049, 金钱 = 393}
	技能消耗[16] = {经验 = 1260, 金钱 = 472}
	技能消耗[17] = {经验 = 1503, 金钱 = 563}
	技能消耗[18] = {经验 = 1780, 金钱 = 667}
	技能消耗[19] = {经验 = 2096, 金钱 = 786}
	技能消耗[20] = {经验 = 2452, 金钱 = 919}
	技能消耗[21] = {经验 = 2854, 金钱 = 1070}
	技能消耗[22] = {经验 = 3304, 金钱 = 1238}
	技能消耗[23] = {经验 = 3807, 金钱 = 1426}
	技能消耗[24] = {经验 = 4364, 金钱 = 1636}
	技能消耗[25] = {经验 = 4983, 金钱 = 1868}
	技能消耗[26] = {经验 = 5664, 金钱 = 2124}
	技能消耗[27] = {经验 = 6415, 金钱 = 2404}
	技能消耗[28] = {经验 = 7238, 金钱 = 2714}
	技能消耗[29] = {经验 = 8138, 金钱 = 3050}
	技能消耗[30] = {经验 = 9120, 金钱 = 3420}
	技能消耗[31] = {经验 = 10188, 金钱 = 3820}
	技能消耗[32] = {经验 = 11347, 金钱 = 4255}
	技能消耗[33] = {经验 = 12602, 金钱 = 4725}
	技能消耗[34] = {经验 = 13959, 金钱 = 5234}
	技能消耗[35] = {经验 = 15423, 金钱 = 5783}
	技能消耗[36] = {经验 = 16998, 金钱 = 6374}
	技能消耗[37] = {经验 = 18692, 金钱 = 7009}
	技能消耗[38] = {经验 = 20508, 金钱 = 7690}
	技能消耗[39] = {经验 = 22452, 金钱 = 8419}
	技能消耗[40] = {经验 = 24532, 金钱 = 9199}
	技能消耗[41] = {经验 = 26753, 金钱 = 10032}
	技能消耗[42] = {经验 = 29121, 金钱 = 10920}
	技能消耗[43] = {经验 = 31642, 金钱 = 11865}
	技能消耗[44] = {经验 = 34323, 金钱 = 12871}
	技能消耗[45] = {经验 = 37169, 金钱 = 13938}
	技能消耗[46] = {经验 = 40188, 金钱 = 15070}
	技能消耗[47] = {经验 = 43388, 金钱 = 16270}
	技能消耗[48] = {经验 = 46773, 金钱 = 17540}
	技能消耗[49] = {经验 = 50352, 金钱 = 18882}
	技能消耗[50] = {经验 = 54132, 金钱 = 20299}
	技能消耗[51] = {经验 = 58120, 金钱 = 21795}
	技能消耗[52] = {经验 = 62324, 金钱 = 23371}
	技能消耗[53] = {经验 = 66750, 金钱 = 25031}
	技能消耗[54] = {经验 = 71407, 金钱 = 26777}
	技能消耗[55] = {经验 = 76303, 金钱 = 28613}
	技能消耗[56] = {经验 = 81444, 金钱 = 30541}
	技能消耗[57] = {经验 = 86840, 金钱 = 32565}
	技能消耗[58] = {经验 = 92500, 金钱 = 34687}
	技能消耗[59] = {经验 = 98430, 金钱 = 36911}
	技能消耗[60] = {经验 = 104640, 金钱 = 39240}
	技能消耗[61] = {经验 = 111136, 金钱 = 41676}
	技能消耗[62] = {经验 = 117931, 金钱 = 44224}
	技能消耗[63] = {经验 = 125031, 金钱 = 46886}
	技能消耗[64] = {经验 = 132444, 金钱 = 49666}
	技能消耗[65] = {经验 = 140183, 金钱 = 52568}
	技能消耗[66] = {经验 = 148253, 金钱 = 55595}
	技能消耗[67] = {经验 = 156666, 金钱 = 58749}
	技能消耗[68] = {经验 = 165430, 金钱 = 62036}
	技能消耗[69] = {经验 = 174556, 金钱 = 65458}
	技能消耗[70] = {经验 = 184052, 金钱 = 69019}
	技能消耗[71] = {经验 = 193930, 金钱 = 72723}
	技能消耗[72] = {经验 = 204198, 金钱 = 76574}
	技能消耗[73] = {经验 = 214868, 金钱 = 80575}
	技能消耗[74] = {经验 = 225948, 金钱 = 84730}
	技能消耗[75] = {经验 = 237449, 金钱 = 89043}
	技能消耗[76] = {经验 = 249383, 金钱 = 93518}
	技能消耗[77] = {经验 = 261760, 金钱 = 98160}
	技能消耗[78] = {经验 = 274589, 金钱 = 102971}
	技能消耗[79] = {经验 = 287884, 金钱 = 107956}
	技能消耗[80] = {经验 = 301652, 金钱 = 113119}
	技能消耗[81] = {经验 = 315908, 金钱 = 118465}
	技能消耗[82] = {经验 = 330662, 金钱 = 123998}
	技能消耗[83] = {经验 = 345924, 金钱 = 129721}
	技能消耗[84] = {经验 = 361708, 金钱 = 135640}
	技能消耗[85] = {经验 = 378023, 金钱 = 141758}
	技能消耗[86] = {经验 = 394882, 金钱 = 148080}
	技能消耗[87] = {经验 = 412297, 金钱 = 154611}
	技能消耗[88] = {经验 = 430280, 金钱 = 161355}
	技能消耗[89] = {经验 = 448844, 金钱 = 168316}
	技能消耗[90] = {经验 = 468000, 金钱 = 175500}
	技能消耗[91] = {经验 = 487760, 金钱 = 182910}
	技能消耗[92] = {经验 = 508137, 金钱 = 190551}
	技能消耗[93] = {经验 = 529145, 金钱 = 198429}
	技能消耗[94] = {经验 = 550796, 金钱 = 206548}
	技能消耗[95] = {经验 = 573103, 金钱 = 214913}
	技能消耗[96] = {经验 = 596078, 金钱 = 223529}
	技能消耗[97] = {经验 = 619735, 金钱 = 232400}
	技能消耗[98] = {经验 = 644088, 金钱 = 241533}
	技能消耗[99] = {经验 = 669149, 金钱 = 250931}
	技能消耗[100] = {经验 = 694932, 金钱 = 260599}
	技能消耗[101] = {经验 = 721452, 金钱 = 270544}
	技能消耗[102] = {经验 = 748722, 金钱 = 280770}
	技能消耗[103] = {经验 = 776755, 金钱 = 291283}
	技能消耗[104] = {经验 = 805566, 金钱 = 302087}
	技能消耗[105] = {经验 = 835169, 金钱 = 313188}
	技能消耗[106] = {经验 = 865579, 金钱 = 324592}
	技能消耗[107] = {经验 = 896809, 金钱 = 336303}
	技能消耗[108] = {经验 = 928876, 金钱 = 348328}
	技能消耗[109] = {经验 = 961792, 金钱 = 360672}
	技能消耗[110] = {经验 = 995572, 金钱 = 373339}
	技能消耗[111] = {经验 = 1030234, 金钱 = 386337}
	技能消耗[112] = {经验 = 1065190, 金钱 = 399671}
	技能消耗[113] = {经验 = 1102256, 金钱 = 413346}
	技能消耗[114] = {经验 = 1139649, 金钱 = 427368}
	技能消耗[115] = {经验 = 1177983, 金钱 = 441743}
	技能消耗[116] = {经验 = 1217273, 金钱 = 456477}
	技能消耗[117] = {经验 = 1256104, 金钱 = 471576}
	技能消耗[118] = {经验 = 1298787, 金钱 = 487045}
	技能消耗[119] = {经验 = 1341043, 金钱 = 502891}
	技能消耗[120] = {经验 = 1384320, 金钱 = 519120}
	技能消耗[121] = {经验 = 1428632, 金钱 = 535737}
	技能消耗[122] = {经验 = 1473999, 金钱 = 552749}
	技能消耗[123] = {经验 = 1520435, 金钱 = 570163}
	技能消耗[124] = {经验 = 1567957, 金钱 = 587984}
	技能消耗[125] = {经验 = 1616583, 金钱 = 606218}
	技能消耗[126] = {经验 = 1666328, 金钱 = 624873}
	技能消耗[127] = {经验 = 1717211, 金钱 = 643954}
	技能消耗[128] = {经验 = 1769248, 金钱 = 663468}
	技能消耗[129] = {经验 = 1822456, 金钱 = 683421}
	技能消耗[130] = {经验 = 1876852, 金钱 = 703819}
	技能消耗[131] = {经验 = 1932456, 金钱 = 724671}
	技能消耗[132] = {经验 = 1989284, 金钱 = 745981}
	技能消耗[133] = {经验 = 2047353, 金钱 = 767757}
	技能消耗[134] = {经验 = 2106682, 金钱 = 790005}
	技能消耗[135] = {经验 = 2167289, 金钱 = 812733}
	技能消耗[136] = {经验 = 2229192, 金钱 = 835947}
	技能消耗[137] = {经验 = 2292410, 金钱 = 859653}
	技能消耗[138] = {经验 = 2356960, 金钱 = 883860}
	技能消耗[139] = {经验 = 2422861, 金钱 = 908573}
	技能消耗[140] = {经验 = 2490132, 金钱 = 933799}
	技能消耗[141] = {经验 = 2558792, 金钱 = 959547}
	技能消耗[142] = {经验 = 2628860, 金钱 = 985822}
	技能消耗[143] = {经验 = 2700356, 金钱 = 1012633}
	技能消耗[144] = {经验 = 2773296, 金钱 = 1039986}
	技能消耗[145] = {经验 = 2847703, 金钱 = 1067888}
	技能消耗[146] = {经验 = 2923593, 金钱 = 1096347}
	技能消耗[147] = {经验 = 3000989, 金钱 = 1125371}
	技能消耗[148] = {经验 = 3079908, 金钱 = 1154965}
	技能消耗[149] = {经验 = 3160372, 金钱 = 1185139}
	技能消耗[150] = {经验 = 3242400, 金钱 = 1215900}
	技能消耗[151] = {经验 = 6652022, 金钱 = 2494508}
	技能消耗[152] = {经验 = 6822452, 金钱 = 2558419}
	技能消耗[153] = {经验 = 6996132, 金钱 = 2623549}
	技能消耗[154] = {经验 = 7173104, 金钱 = 2689914}
	技能消耗[155] = {经验 = 7353406, 金钱 = 2757527}
	技能消耗[156] = {经验 = 11305620, 金钱 = 4239607}
	技能消耗[157] = {经验 = 11586254, 金钱 = 4344845}
	技能消耗[158] = {经验 = 11872072, 金钱 = 4452027}
	技能消耗[159] = {经验 = 12163140, 金钱 = 4561177}
	技能消耗[160] = {经验 = 12459518, 金钱 = 4672319}
	技能消耗[161] = {经验 = 15033471, 金钱 = 450041}
	技能消耗[162] = {经验 = 15315219, 金钱 = 4594563}
	技能消耗[163] = {经验 = 15600468, 金钱 = 4680138}
	技能消耗[164] = {经验 = 15889236, 金钱 = 4766769}
	技能消耗[165] = {经验 = 16181550, 金钱 = 4854465}
	技能消耗[166] = {经验 = 16477425, 金钱 = 4943226}
	技能消耗[167] = {经验 = 16776885, 金钱 = 5033064}
	技能消耗[168] = {经验 = 17079954, 金钱 = 5123985}
	技能消耗[169] = {经验 = 17386650, 金钱 = 5215995}
	技能消耗[170] = {经验 = 17697000, 金钱 = 5309100}
	技能消耗[171] = {经验 = 24014692, 金钱 = 7204407}
	技能消耗[172] = {经验 = 24438308, 金钱 = 7331490}
	技能消耗[173] = {经验 = 24866880, 金钱 = 7460064}
	技能消耗[174] = {经验 = 25300432, 金钱 = 7590129}
	技能消耗[175] = {经验 = 25739000, 金钱 = 7721700}
	技能消耗[176] = {经验 = 32728255, 金钱 = 9818475}
	技能消耗[177] = {经验 = 33289095, 金钱 = 9986727}
	技能消耗[178] = {经验 = 33856310, 金钱 = 10156893}
	技能消耗[179] = {经验 = 34492930, 金钱 = 10328979}
	技能消耗[180] = {经验 = 40842000, 金钱 = 12252600}
	return {经验 = 技能消耗[目标技能等级].经验, 金钱 = qz(技能消耗[目标技能等级].金钱)}
end

function 角色处理类:生活技能消耗(目标技能等级,技能)
	local 等级 = 目标技能等级
	local 技能消耗 = {}
	if 技能=="强壮" or 技能=="神速" then
		技能消耗[1]={经验=1720000,金钱=430000}
		技能消耗[2]={经验=1980000,金钱=495000}
		技能消耗[3]={经验=2280000,金钱=570000}
		技能消耗[4]={经验=2620000,金钱=655000}
		技能消耗[5]={经验=3000000,金钱=750000}
		技能消耗[6]={经验=3420000,金钱=855000}
		技能消耗[7]={经验=3880000,金钱=970000}
		技能消耗[8]={经验=4380000,金钱=1095000}
		技能消耗[9]={经验=4920000,金钱=1230000}
		技能消耗[10]={经验=5500000,金钱=1375000}
		技能消耗[11]={经验=6120000,金钱=1530000}
		技能消耗[12]={经验=6780000,金钱=1695000}
		技能消耗[13]={经验=7480000,金钱=1870000}
		技能消耗[14]={经验=8220000,金钱=2055000}
		技能消耗[15]={经验=9000000,金钱=2250000}
		技能消耗[16]={经验=9820000,金钱=2455000}
		技能消耗[17]={经验=10680000,金钱=2670000}
		技能消耗[18]={经验=11580000,金钱=2895000}
		技能消耗[19]={经验=12520000,金钱=3130000}
		技能消耗[20]={经验=13500000,金钱=3375000}
		技能消耗[21]={经验=14520000,金钱=3630000}
		技能消耗[22]={经验=15580000,金钱=3895000}
		技能消耗[23]={经验=16680000,金钱=4170000}
		技能消耗[24]={经验=17820000,金钱=4455000}
		技能消耗[25]={经验=19000000,金钱=4750000}
		技能消耗[26]={经验=20220000,金钱=5055000}
		技能消耗[27]={经验=21480000,金钱=5370000}
		技能消耗[28]={经验=22780000,金钱=5695000}
		技能消耗[29]={经验=25500000,金钱=6375000}
		技能消耗[30]={经验=26920000,金钱=6730000}
		技能消耗[31]={经验=26920000,金钱=6730000}
		技能消耗[32]={经验=28380000,金钱=7095000}
		技能消耗[33]={经验=29880000,金钱=7470000}
		技能消耗[34]={经验=31420000,金钱=7855000}
		技能消耗[35]={经验=33000000,金钱=8250000}
		技能消耗[36]={经验=34620000,金钱=8655000}
		技能消耗[37]={经验=36280000,金钱=9070000}
		技能消耗[38]={经验=37980000,金钱=9495000}
		技能消耗[39]={经验=39720000,金钱=9930000}
		技能消耗[40]={经验=41500000,金钱=10375000}
		技能消耗[41]={经验=43500000,金钱=11375000}
		技能消耗[42]={经验=45180000,金钱=12255000}
		技能消耗[43]={经验=47080000,金钱=12750000}
		技能消耗[44]={经验=49020000,金钱=13255000}
		技能消耗[45]={经验=51000000,金钱=13770000}
		技能消耗[46]={经验=53020000,金钱=14295000}
		技能消耗[47]={经验=55080000,金钱=14830000}
		技能消耗[48]={经验=57180000,金钱=15375000}
		技能消耗[49]={经验=59320000,金钱=15930000}
		技能消耗[50]={经验=61500000,金钱=16495000}
		技能消耗[51]={经验=63720000,金钱=17070000}
		技能消耗[52]={经验=65980000,金钱=17655000}
		技能消耗[53]={经验=68280000,金钱=18250000}
		技能消耗[54]={经验=70620000,金钱=18855000}
		技能消耗[55]={经验=73000000,金钱=19470000}
		技能消耗[56]={经验=75420000,金钱=20095000}
		技能消耗[57]={经验=77880000,金钱=20730000}
		技能消耗[58]={经验=80380000,金钱=21375000}
		技能消耗[59]={经验=82920000,金钱=22220000}
		技能消耗[60]={经验=85500000,金钱=23500000}
		技能消耗[61]={经验=90000000,金钱=25000000}
		技能消耗[目标技能等级].帮贡=目标技能等级
		技能消耗[目标技能等级].需求=目标技能等级 * 5
		return 技能消耗[目标技能等级]
	end

	技能消耗[1] = {经验 = 16, 金钱 = 3, 需求 = 6, 帮贡 = 1}
	技能消耗[2] = {经验 = 32, 金钱 = 6, 需求 = 12, 帮贡 = 2}
	技能消耗[3] = {经验 = 52, 金钱 = 9, 需求 = 18, 帮贡 = 3}
	技能消耗[4] = {经验 = 75, 金钱 = 14, 需求 =24, 帮贡 = 4}
	技能消耗[5] = {经验 = 103, 金钱 = 19, 需求 = 30, 帮贡 = 5}
	技能消耗[6] = {经验 = 136, 金钱 = 25, 需求 = 36, 帮贡 = 6}
	技能消耗[7] = {经验 = 179, 金钱 = 33, 需求 = 42, 帮贡 = 7}
	技能消耗[8] = {经验 = 231, 金钱 = 43, 需求 = 48, 帮贡 = 8}
	技能消耗[9] = {经验 = 295, 金钱 = 55, 需求 = 54, 帮贡 = 9}
	技能消耗[10] = {经验 = 372, 金钱 = 69, 需求 = 60, 帮贡 = 10}
	技能消耗[11] = {经验 = 466, 金钱 = 87, 需求 = 66, 帮贡 = 11}
	技能消耗[12] = {经验 = 578, 金钱 = 108, 需求 = 72, 帮贡 = 12}
	技能消耗[13] = {经验 = 711, 金钱 = 133, 需求 = 78, 帮贡 = 13}
	技能消耗[14] = {经验 = 867, 金钱 = 162, 需求 = 84, 帮贡 = 14}
	技能消耗[15] = {经验 = 1049, 金钱 = 196, 需求 = 90, 帮贡 = 15}
	技能消耗[16] = {经验 = 1260, 金钱 = 236, 需求 = 96, 帮贡 = 16}
	技能消耗[17] = {经验 = 1503, 金钱 = 281, 需求 = 102, 帮贡 = 17}
	技能消耗[18] = {经验 = 1780, 金钱 = 333, 需求 = 108, 帮贡 = 18}
	技能消耗[19] = {经验 = 2096, 金钱 = 393, 需求 = 114, 帮贡 = 19}
	技能消耗[20] = {经验 = 2452, 金钱 = 459, 需求 = 120, 帮贡 = 20}
	技能消耗[21] = {经验 = 2854, 金钱 = 535, 需求 = 126, 帮贡 = 21}
	技能消耗[22] = {经验 = 3304, 金钱 = 619, 需求 = 132, 帮贡 = 22}
	技能消耗[23] = {经验 = 3807, 金钱 = 713, 需求 = 138, 帮贡 = 23}
	技能消耗[24] = {经验 = 4364, 金钱 = 818, 需求 = 144, 帮贡 = 24}
	技能消耗[25] = {经验 = 4983, 金钱 = 934, 需求 = 150, 帮贡 = 25}
	技能消耗[26] = {经验 = 5664, 金钱 = 1062, 需求 = 156, 帮贡 = 26}
	技能消耗[27] = {经验 = 6415, 金钱 = 1202, 需求 = 162, 帮贡 = 27}
	技能消耗[28] = {经验 = 7238, 金钱 = 1357, 需求 = 168, 帮贡 = 28}
	技能消耗[29] = {经验 = 8138, 金钱 = 1525, 需求 = 174, 帮贡 = 29}
	技能消耗[30] = {经验 = 9120, 金钱 = 1710, 需求 = 180, 帮贡 = 30}
	技能消耗[31] = {经验 = 10188, 金钱 = 1910, 需求 = 186, 帮贡 = 31}
	技能消耗[32] = {经验 = 11347, 金钱 = 2127, 需求 = 192, 帮贡 = 32}
	技能消耗[33] = {经验 = 12602, 金钱 = 2362, 需求 = 198, 帮贡 = 33}
	技能消耗[34] = {经验 = 13959, 金钱 = 2617, 需求 = 204, 帮贡 = 34}
	技能消耗[35] = {经验 = 15423, 金钱 = 2891, 需求 = 210, 帮贡 = 35}
	技能消耗[36] = {经验 = 16998, 金钱 = 3187, 需求 = 216, 帮贡 = 36}
	技能消耗[37] = {经验 = 18692, 金钱 = 3504, 需求 = 222, 帮贡 = 37}
	技能消耗[38] = {经验 = 20508, 金钱 = 3845, 需求 = 228, 帮贡 = 38}
	技能消耗[39] = {经验 = 22452, 金钱 = 4209, 需求 = 234, 帮贡 = 39}
	技能消耗[40] = {经验 = 24532, 金钱 = 4599, 需求 = 240, 帮贡 = 40}
	技能消耗[41] = {经验 = 26753, 金钱 = 5106, 需求 = 246, 帮贡 = 41}
	技能消耗[42] = {经验 = 29121, 金钱 = 5460, 需求 = 252, 帮贡 = 42}
	技能消耗[43] = {经验 = 31642, 金钱 = 5932, 需求 = 258, 帮贡 = 43}
	技能消耗[44] = {经验 = 34323, 金钱 = 6435, 需求 = 264, 帮贡 = 44}
	技能消耗[45] = {经验 = 37169, 金钱 = 6969, 需求 = 270, 帮贡 = 45}
	技能消耗[46] = {经验 = 40188, 金钱 = 7535, 需求 = 276, 帮贡 = 46}
	技能消耗[47] = {经验 = 43388, 金钱 = 8135, 需求 = 282, 帮贡 = 47}
	技能消耗[48] = {经验 = 46773, 金钱 = 8770, 需求 = 288, 帮贡 = 48}
	技能消耗[49] = {经验 = 50352, 金钱 = 9441, 需求 = 294, 帮贡 = 49}
	技能消耗[50] = {经验 = 54132, 金钱 = 10149, 需求 = 300, 帮贡 = 50}
	技能消耗[51] = {经验 = 58120, 金钱 = 10897, 需求 = 306, 帮贡 = 51}
	技能消耗[52] = {经验 = 62324, 金钱 = 11685, 需求 = 312, 帮贡 = 52}
	技能消耗[53] = {经验 = 66750, 金钱 = 12515, 需求 = 318, 帮贡 = 53}
	技能消耗[54] = {经验 = 71407, 金钱 = 13388, 需求 = 324, 帮贡 = 54}
	技能消耗[55] = {经验 = 76303, 金钱 = 14306, 需求 = 330, 帮贡 = 55}
	技能消耗[56] = {经验 = 81444, 金钱 = 15270, 需求 = 336, 帮贡 = 56}
	技能消耗[57] = {经验 = 86840, 金钱 = 16282, 需求 = 342, 帮贡 = 57}
	技能消耗[58] = {经验 = 92500, 金钱 = 17343, 需求 = 348, 帮贡 = 58}
	技能消耗[59] = {经验 = 98430, 金钱 = 18455, 需求 = 354, 帮贡 = 59}
	技能消耗[60] = {经验 = 104640, 金钱 = 19620, 需求 = 360, 帮贡 = 60}
	技能消耗[61] = {经验 = 111136, 金钱 = 20838, 需求 = 366, 帮贡 = 61}
	技能消耗[62] = {经验 = 117931, 金钱 = 22112, 需求 = 372, 帮贡 = 62}
	技能消耗[63] = {经验 = 125031, 金钱 = 23443, 需求 = 378, 帮贡 = 63}
	技能消耗[64] = {经验 = 132444, 金钱 = 24833, 需求 = 384, 帮贡 = 64}
	技能消耗[65] = {经验 = 140183, 金钱 = 26284, 需求 = 390, 帮贡 = 65}
	技能消耗[66] = {经验 = 148253, 金钱 = 27797, 需求 = 396, 帮贡 = 66}
	技能消耗[67] = {经验 = 156666, 金钱 = 29374, 需求 = 402, 帮贡 = 67}
	技能消耗[68] = {经验 = 165430, 金钱 = 31018, 需求 = 408, 帮贡 = 68}
	技能消耗[69] = {经验 = 174556, 金钱 = 32729, 需求 = 414, 帮贡 = 69}
	技能消耗[70] = {经验 = 184052, 金钱 = 34509, 需求 = 420, 帮贡 = 70}
	技能消耗[71] = {经验 = 193930, 金钱 = 36361, 需求 = 426, 帮贡 = 71}
	技能消耗[72] = {经验 = 204198, 金钱 = 38287, 需求 = 432, 帮贡 = 72}
	技能消耗[73] = {经验 = 214868, 金钱 = 40287, 需求 = 438, 帮贡 = 73}
	技能消耗[74] = {经验 = 225948, 金钱 = 42365, 需求 = 444, 帮贡 = 74}
	技能消耗[75] = {经验 = 237449, 金钱 = 44521, 需求 = 450, 帮贡 = 75}
	技能消耗[76] = {经验 = 249383, 金钱 = 46759, 需求 = 456, 帮贡 = 76}
	技能消耗[77] = {经验 = 261760, 金钱 = 39080, 需求 = 462, 帮贡 = 77}
	技能消耗[78] = {经验 = 274589, 金钱 = 51485, 需求 = 468, 帮贡 = 78}
	技能消耗[79] = {经验 = 287884, 金钱 = 53978, 需求 = 474, 帮贡 = 79}
	技能消耗[80] = {经验 = 301652, 金钱 = 56559, 需求 = 480, 帮贡 = 80}
	技能消耗[81] = {经验 = 315908, 金钱 = 59232, 需求 = 486, 帮贡 = 81}
	技能消耗[82] = {经验 = 330662, 金钱 = 61999, 需求 = 492, 帮贡 = 82}
	技能消耗[83] = {经验 = 345924, 金钱 = 64860, 需求 = 498, 帮贡 = 83}
	技能消耗[84] = {经验 = 361708, 金钱 = 67820, 需求 = 504, 帮贡 = 84}
	技能消耗[85] = {经验 = 378023, 金钱 = 70879, 需求 = 510, 帮贡 = 85}
	技能消耗[86] = {经验 = 394882, 金钱 = 73030, 需求 = 516, 帮贡 = 86}
	技能消耗[87] = {经验 = 412297, 金钱 = 77305, 需求 = 522, 帮贡 = 87}
	技能消耗[88] = {经验 = 430280, 金钱 = 80677, 需求 = 528, 帮贡 = 88}
	技能消耗[89] = {经验 = 448844, 金钱 = 84158, 需求 = 534, 帮贡 = 89}
	技能消耗[90] = {经验 = 468000, 金钱 = 87750, 需求 = 540, 帮贡 = 90}
	技能消耗[91] = {经验 = 487760, 金钱 = 91455, 需求 = 546, 帮贡 = 91}
	技能消耗[92] = {经验 = 508137, 金钱 = 95275, 需求 = 552, 帮贡 = 92}
	技能消耗[93] = {经验 = 529145, 金钱 = 99214, 需求 = 558, 帮贡 = 93}
	技能消耗[94] = {经验 = 550796, 金钱 = 103274, 需求 = 564, 帮贡 = 94}
	技能消耗[95] = {经验 = 573103, 金钱 = 107456, 需求 = 570, 帮贡 = 95}
	技能消耗[96] = {经验 = 596078, 金钱 = 111764, 需求 = 576, 帮贡 = 96}
	技能消耗[97] = {经验 = 619735, 金钱 = 116200, 需求 = 582, 帮贡 = 97}
	技能消耗[98] = {经验 = 644088, 金钱 = 120766, 需求 = 588, 帮贡 = 98}
	技能消耗[99] = {经验 = 669149, 金钱 = 125465, 需求 = 594, 帮贡 = 99}
	技能消耗[100] = {经验 = 694932, 金钱 = 130299, 需求 = 600, 帮贡 = 100}
	技能消耗[101] = {经验 = 721452, 金钱 = 135272, 需求 = 606, 帮贡 = 101}
	技能消耗[102] = {经验 = 748722, 金钱 = 140385, 需求 = 612, 帮贡 = 102}
	技能消耗[103] = {经验 = 776755, 金钱 = 145641, 需求 = 618, 帮贡 = 103}
	技能消耗[104] = {经验 = 805566, 金钱 = 151043, 需求 = 624, 帮贡 = 104}
	技能消耗[105] = {经验 = 835169, 金钱 = 156594, 需求 = 630, 帮贡 = 105}
	技能消耗[106] = {经验 = 865579, 金钱 = 162296, 需求 = 636, 帮贡 = 106}
	技能消耗[107] = {经验 = 896809, 金钱 = 168151, 需求 = 642, 帮贡 = 107}
	技能消耗[108] = {经验 = 928876, 金钱 = 174164, 需求 = 648, 帮贡 = 108}
	技能消耗[109] = {经验 = 961792, 金钱 = 180336, 需求 = 654, 帮贡 = 109}
	技能消耗[110] = {经验 = 995572, 金钱 = 186669, 需求 = 660, 帮贡 = 110}
	技能消耗[111] = {经验 = 1030234, 金钱 = 193168, 需求 = 666, 帮贡 = 111}
	技能消耗[112] = {经验 = 1065190, 金钱 = 199835, 需求 = 672, 帮贡 = 112}
	技能消耗[113] = {经验 = 1102256, 金钱 = 206673, 需求 = 678, 帮贡 = 113}
	技能消耗[114] = {经验 = 1139649, 金钱 = 213684, 需求 = 684, 帮贡 = 114}
	技能消耗[115] = {经验 = 1177983, 金钱 = 220871, 需求 = 690, 帮贡 = 115}
	技能消耗[116] = {经验 = 1217273, 金钱 = 228238, 需求 = 696, 帮贡 = 116}
	技能消耗[117] = {经验 = 1256104, 金钱 = 235788, 需求 = 702, 帮贡 = 117}
	技能消耗[118] = {经验 = 1298787, 金钱 = 243522, 需求 = 709, 帮贡 = 118}
	技能消耗[119] = {经验 = 1341043, 金钱 = 251445, 需求 = 714, 帮贡 = 119}
	技能消耗[120] = {经验 = 1384320, 金钱 = 259560, 需求 = 720, 帮贡 = 120}
	技能消耗[121] = {经验 = 1428632, 金钱 = 267868, 需求 = 726, 帮贡 = 121}
	技能消耗[122] = {经验 = 1473999, 金钱 = 276374, 需求 = 732, 帮贡 = 122}
	技能消耗[123] = {经验 = 1520435, 金钱 = 285081, 需求 = 738, 帮贡 = 123}
	技能消耗[124] = {经验 = 1567957, 金钱 = 293992, 需求 = 744, 帮贡 = 124}
	技能消耗[125] = {经验 = 1616583, 金钱 = 303109, 需求 = 750, 帮贡 = 125}
	技能消耗[126] = {经验 = 1666328, 金钱 = 312436, 需求 = 756, 帮贡 = 126}
	技能消耗[127] = {经验 = 1717211, 金钱 = 321977, 需求 = 762, 帮贡 = 127}
	技能消耗[128] = {经验 = 1769248, 金钱 = 331734, 需求 = 768, 帮贡 = 128}
	技能消耗[129] = {经验 = 1822456, 金钱 = 341710, 需求 = 774, 帮贡 = 129}
	技能消耗[130] = {经验 = 1876852, 金钱 = 351909, 需求 = 780, 帮贡 = 130}
	技能消耗[131] = {经验 = 1932456, 金钱 = 363335, 需求 = 786, 帮贡 = 131}
	技能消耗[132] = {经验 = 1989284, 金钱 = 372990, 需求 = 792, 帮贡 = 132}
	技能消耗[133] = {经验 = 2047353, 金钱 = 383878, 需求 = 798, 帮贡 = 133}
	技能消耗[134] = {经验 = 2106682, 金钱 = 395002, 需求 = 804, 帮贡 = 134}
	技能消耗[135] = {经验 = 2167289, 金钱 = 406366, 需求 = 810, 帮贡 = 135}
	技能消耗[136] = {经验 = 2229192, 金钱 = 417973, 需求 = 816, 帮贡 = 136}
	技能消耗[137] = {经验 = 2292410, 金钱 = 429826, 需求 = 822, 帮贡 = 137}
	技能消耗[138] = {经验 = 2356960, 金钱 = 441930, 需求 = 828, 帮贡 = 138}
	技能消耗[139] = {经验 = 2422861, 金钱 = 454286, 需求 = 834, 帮贡 = 139}
	技能消耗[140] = {经验 = 2490132, 金钱 = 466899, 需求 = 840, 帮贡 = 140}
	技能消耗[141] = {经验 = 2558792, 金钱 = 479773, 需求 = 846, 帮贡 = 141}
	技能消耗[142] = {经验 = 2628860, 金钱 = 492911, 需求 = 852, 帮贡 = 142}
	技能消耗[143] = {经验 = 2700356, 金钱 = 506316, 需求 = 858, 帮贡 = 143}
	技能消耗[144] = {经验 = 2773296, 金钱 = 519993, 需求 = 864, 帮贡 = 144}
	技能消耗[145] = {经验 = 2847703, 金钱 = 533944, 需求 = 870, 帮贡 = 145}
	技能消耗[146] = {经验 = 2923593, 金钱 = 548173, 需求 = 876, 帮贡 = 146}
	技能消耗[147] = {经验 = 3000989, 金钱 = 562685, 需求 = 882, 帮贡 = 147}
	技能消耗[148] = {经验 = 3079908, 金钱 = 577482, 需求 = 888, 帮贡 = 148}
	技能消耗[149] = {经验 = 3160372, 金钱 = 592569, 需求 = 894, 帮贡 = 149}
	技能消耗[150] = {经验 = 3242400, 金钱 = 607950, 需求 = 900, 帮贡 = 150}
	技能消耗[151] = {经验 = 5022276, 金钱 = 623627, 需求 = 906, 帮贡 = 151}
	技能消耗[152] = {经验 = 5185064, 金钱 = 639604, 需求 = 912, 帮贡 = 152}
	技能消耗[153] = {经验 = 5352040, 金钱 = 655887, 需求 = 918, 帮贡 = 153}
	技能消耗[154] = {经验 = 5523289, 金钱 = 672478, 需求 = 924, 帮贡 = 154}
	技能消耗[155] = {经验 = 5698889, 金钱 = 689381, 需求 = 930, 帮贡 = 155}
	技能消耗[156] = {经验 = 5878922, 金钱 = 706601, 需求 = 936, 帮贡 = 156}
	技能消耗[157] = {经验 = 6063472, 金钱 = 724140, 需求 = 942, 帮贡 = 157}
	技能消耗[158] = {经验 = 6252524, 金钱 = 742004, 需求 = 948, 帮贡 = 156}
	技能消耗[159] = {经验 = 6446464, 金钱 = 760195, 需求 = 954, 帮贡 = 159}
	技能消耗[160] = {经验 = 6645076, 金钱 = 778719, 需求 = 960, 帮贡 = 160}
	技能消耗[161] = {经验 = 12459518,金钱 = 839604, 需求 = 966, 帮贡 = 161}
	return 技能消耗[目标技能等级]
end

-- function 角色处理类:添加仙玉(数额, 说明, 提示)--f函数.读配置(程序目录..[[data\]]..玩家数据[id].账号..[[\账号信息.txt]], "账号配置", "仙玉") + 0
-- 	if 数额 == nil or 数额 + 0 < 1 then 数额 = 0 end
-- 	数额=qz(数额)
-- 	local 之前仙玉 = self.仙玉
-- 	self.仙玉 = self.仙玉 + 数额
-- 	if 提示 ~= nil then
-- 		消息提示(self.数字id,"#W你获得了#G"..数额.."#W点仙玉")
-- 		常规提示(self.数字id,"#W你获得了#G"..数额.."#W点仙玉")
-- 	end
-- 	self:日志记录(format("事件:获得仙玉,类型%s,数额%s,倍率%s,获得前%s,获得后%s", 说明, 数额, 倍率, 之前仙玉, self.仙玉))
-- end
function 角色处理类:添加仙玉(数额, 说明, 提示)--function 角色处理类:添加仙玉(数额, 说明, 提示)
	if 数额 == nil or 数额 + 0 < 1 then 数额 = 0 end

	    if type(数额)~= "number" then
		写配置("./ip封禁.ini", "ip", self.ip, 1)
		f函数.写配置(程序目录..[[data\]]..玩家数据[self.数字id].账号..[[\账号信息.txt]],"账号配置","封禁","1")
		local 封禁原因=self.ip.."“违规行为：添加仙玉数量不为number！！”，玩家ID=="..self.数字id.."，玩家账号=="..玩家数据[self.数字id].账号.."时间="..os.date("%Y%m%d")..os.date("%H",os.time())..os.date("%S",os.time())
		f函数.写配置(程序目录..[[data\]]..玩家数据[self.数字id].账号..[[\账号信息.txt]],"账号配置","已违规5",封禁原因)
		f函数.写配置(程序目录..[[各类情况查看\]]..[[\违规汇总.txt]],"违规详情","已违规5.1:",封禁原因)
		发送数据(玩家数据[self.数字id].连接id, 998, "请注意你的角色异常！已经对你进行封禁")
		__S服务:断开连接(玩家数据[self.数字id].连接id)
	      return false
	    end
	数额=qz(数额)

	local 之前仙玉 =f函数.读配置(程序目录..[[data\]]..玩家数据[self.数字id].账号..[[\账号信息.txt]],"账号配置","仙玉")+0

	    if type(之前仙玉)~= "number" then
		写配置("./ip封禁.ini", "ip", self.ip, 1)
		f函数.写配置(程序目录..[[data\]]..玩家数据[self.数字id].账号..[[\账号信息.txt]],"账号配置","封禁","1")
		local 封禁原因=self.ip.."“违规行为：添加银子不对！！”，玩家ID=="..self.数字id.."，玩家账号=="..玩家数据[self.数字id].账号.."时间="..os.date("%Y%m%d")..os.date("%H",os.time())..os.date("%S",os.time())
		f函数.写配置(程序目录..[[data\]]..玩家数据[self.数字id].账号..[[\账号信息.txt]],"账号配置","已违规5.2",封禁原因)
		f函数.写配置(程序目录..[[各类情况查看\]]..[[\违规汇总.txt]],"违规详情","已违规5.2:",封禁原因)
		发送数据(玩家数据[self.数字id].连接id, 998, "请注意你的角色异常！已经对你进行封禁")
		__S服务:断开连接(玩家数据[self.数字id].连接id)
	      return false
	    end
	if 数额~=0 then
	 local zjxy=之前仙玉+数额
	 f函数.写配置(程序目录..[[data\]]..玩家数据[self.数字id].账号..[[\账号信息.txt]],"账号配置","仙玉",zjxy)
			消息提示(self.数字id,"#W你获得了#G"..数额.."#W点仙玉")
			常规提示(self.数字id,"#W你获得了#G"..数额.."#W点仙玉")
	self:日志记录(format("事件:获得仙玉,类型：%s,数额：%s,获得前：%s,获得后：%s", 说明, 数额, 之前仙玉, zjxy))
	end
end

-- function 角色处理类:扣除仙玉(数额, 储备, 存银, 说明, 提示)
-- 	数额=qz(数额+0)
-- 	local 之前仙玉 = self.仙玉
-- 	local 倍率 = 1
-- 	if self.仙玉 >= 数额 then
-- 		self.仙玉 = math.floor(self.仙玉 - 数额)
-- 		if self.仙玉>之前仙玉 then
-- 			self.仙玉=之前仙玉
-- 			写配置("./ip封禁.ini", "ip", self.ip, 1)
-- 			f函数.写配置(程序目录..[[data\]]..玩家数据[self.数字id].账号..[[\账号信息.txt]],"账号配置","封禁","1")
-- 			local 封禁原因=self.ip.."“违规行为：扣除仙玉大于之前！！！”，玩家ID=="..self.数字id.."，玩家账号=="..玩家数据[self.数字id].账号.."时间="..os.date("%Y%m%d")..os.date("%H",os.time())..os.date("%S",os.time())
-- 			f函数.写配置(程序目录..[[data\]]..玩家数据[self.数字id].账号..[[\账号信息.txt]],"账号配置","已违规5",封禁原因)
-- 			f函数.写配置(程序目录..[[各类情况查看\]]..[[\违规汇总.txt]],"违规详情","已违规5.1:",封禁原因)
-- 			发送数据(玩家数据[self.数字id].连接id, 998, "请注意你的角色异常！已经对你进行封禁")
-- 			__S服务:断开连接(玩家数据[self.数字id].连接id)
-- 			return false
-- 		end
-- 			消息提示(self.数字id, "你失去了"..数额.."两仙玉")
-- 		self:日志记录(format("事件:扣除仙玉,类型%s,数额%s,倍率%s,获得前%s,获得后%s", 说明, 数额, 倍率, 之前仙玉, self.仙玉))
-- 		return true
-- 	else
-- 		  消息提示(self.数字id, "你没有那么多的仙玉")
-- 		常规提示(self.数字id,"#Y/你没有那么多的仙玉")
-- 		return false
-- 	end
-- end
function 角色处理类:扣除仙玉(数额, 储备, 存银, 说明, 提示)--function 角色处理类:扣除仙玉(数额, 储备, 存银, 说明, 提示)
	if 数额 == nil or 数额 + 0 < 1 then 数额 = 0 end
	    if type(数额)~= "number" then
		写配置("./ip封禁.ini", "ip", self.ip, 1)
		f函数.写配置(程序目录..[[data\]]..玩家数据[self.数字id].账号..[[\账号信息.txt]],"账号配置","封禁","1")
		local 封禁原因=self.ip.."“违规行为：添加仙玉不为number！！”，玩家ID=="..self.数字id.."，玩家账号=="..玩家数据[self.数字id].账号.."时间="..os.date("%Y%m%d")..os.date("%H",os.time())..os.date("%S",os.time())
		f函数.写配置(程序目录..[[data\]]..玩家数据[self.数字id].账号..[[\账号信息.txt]],"账号配置","已违规5.3",封禁原因)
		f函数.写配置(程序目录..[[各类情况查看\]]..[[\违规汇总.txt]],"违规详情","已违规5.3:",封禁原因)
		发送数据(玩家数据[self.数字id].连接id, 998, "请注意你的角色异常！已经对你进行封禁")
		__S服务:断开连接(玩家数据[self.数字id].连接id)
	      return false
	    end
	数额=qz(数额)
	local 之前仙玉 =f函数.读配置(程序目录..[[data\]]..玩家数据[self.数字id].账号..[[\账号信息.txt]],"账号配置","仙玉")+0
	if 之前仙玉<数额 then
		消息提示(self.数字id, "你没有那么多的仙玉")
		常规提示(self.数字id, "你没有那么多的仙玉")
		return false
	end
	 local zjxy=之前仙玉-数额
	 	f函数.写配置(程序目录..[[data\]]..玩家数据[self.数字id].账号..[[\账号信息.txt]],"账号配置","仙玉",zjxy)
		常规提示(self.数字id, "#W你扣除了#R"..数额.."#W仙玉")
		消息提示(self.数字id, "#W你扣除了#R"..数额.."#W仙玉")
		self:日志记录(format("事件:消费仙玉,类型：%s,数额：%s,获得前：%s,获得后：%s", 说明, 数额, 之前仙玉, zjxy))
	return true
end


function 添加累充(数额,账号,id,事件)
  if 账号==nil or 数额==nil or id==nil or 事件==nil then
    print("存在作弊行为")
    return false
  end

  local 金额 = math.floor(数额)
  if 充值数据[id]==nil then
    充值数据[id]={id=id,名称=玩家数据[id].角色.名称,金额=金额,门派=玩家数据[id].角色.门派,等级=玩家数据[id].角色.等级}
  end
    充值数据[id].金额=充值数据[id].金额+金额
    充值数据[id].等级=玩家数据[id].角色.等级
  消息提示(id, "你获得了#G"..数额.."#W点累充额度")
	常规提示(id, "你获得了#G"..数额.."#W点累充额度")
end

function 角色处理类:银子检查纠错() --防修改
	if self.银子==nil or tonumber(self.银子)==nil or type(self.银子)~="number" or self.银子+0 < 0 then
		self.银子=0
	end
end

function 角色处理类:添加银子(数额, 说明, 提示)
	if 玩家数据[self.数字id].角色.武神坛角色 then --武神坛
		常规提示(self.数字id,"武神坛角色不可获得银子")
		return
	end
	self:银子检查纠错()
	if 数额 == nil or tonumber(数额)==nil or 数额 + 0 < 1 then 数额 = 0 end
	数额=qz(数额)
	local 之前银子 = self.银子
	local 倍率 = 服务端参数.银子获得率
	if 说明 == "捉鬼" or 说明 == "封妖战斗" or 说明 == "鬼王" then
		if self:取任务(2) ~= 0 then --双倍
			倍率=倍率+1
		end
		if self:取任务(3) ~= 0 then --三倍
			倍率=倍率+1
		end
	end
	if 说明 == "宠物仙子新手奖励" or 说明 == "抽奖" or 说明 == "网关充值" or 说明 == "礼包" then
		倍率 = 1
	end
	数额 = qz(数额 * 倍率)
	self.银子 = self.银子 + 数额
	if 提示 ~= nil then
		常规提示(self.数字id, "你获得了"..数额.."两银子")
		消息提示(self.数字id, "你获得了"..数额.."两银子")
	end
	self:日志记录(format("事件:获得银子,类型%s,数额%s,倍率%s,获得前%s,获得后%s", 说明, 数额, 倍率, 之前银子, self.银子))
end

function 角色处理类:添加储备(数额, 说明, 提示)
	if 数额 == nil or 数额 + 0 <1 then 数额 = 0 end
	local 之前银子 = self.储备
	local 倍率 = 1
	if self:取任务(15) ~= 0 then --回梦丹
		倍率 = 倍率 + 0.4
	end
	if 说明 == "宠物仙子新手奖励" or 说明 == "抽奖" or 说明 == "网关充值" or 说明 == "礼包" then
		倍率 = 1
	end
	数额 = qz(数额 * 倍率)
	self.储备 = math.floor(self.储备 + 数额)

	if 提示 ~= nil then
		消息提示(self.数字id, "你获得了"..数额.."点储备金")
	end
	self:日志记录(format("事件:获得储备,类型%s,数额%s,倍率%s,获得前%s,获得后%s", 说明, 数额, 倍率, 之前银子, self.储备))
end

function 角色处理类:扣除体力(数额)
	if self.体力>=数额 then
		self.体力=self.体力-数额
		return true
	else
		return false
	end
end

function 角色处理类:扣除活力(数额)
	if self.活力>=数额 then
		self.活力=self.活力-数额
		return true
	else
		return false
	end
end

function 角色处理类:增加剧情点(num)
	self.剧情点.当前=self.剧情点.当前+num
	self.剧情点.总额=self.剧情点.总额+num
	消息提示(self.数字id,"#Y你获得了#G/"..num.."点#Y/剧情技能点")
end
function 角色处理类:添加声望积分(num)
        if  self.采矿数据 == nil then
         self.采矿数据= {熟练度=0,矿业声望=0}
         end
	self.采矿数据.矿业声望=self.采矿数据.矿业声望+num
	消息提示(self.数字id,"#Y你获得了#G/"..num.."点#Y/矿业声望")
end
function 角色处理类:添加副本积分(num)
	self.副本积分=self.副本积分+num
	消息提示(self.数字id,"#Y你获得了#G/"..num.."点#Y/副本积分")
end
-- function 角色处理类:添加仙玉(num)
-- 	self.仙玉=self.仙玉+num
-- 	消息提示(self.数字id,"#Y你获得了#G/"..num.."点#Y/仙玉")
-- end
function 角色处理类:添加门贡(num)
	self.门贡=self.门贡+num
	消息提示(self.数字id,"#Y你获得了#G/"..num.."点#Y/门派贡献")
end

function 角色处理类:添加每日活跃度(id, 数额)
	if 每日任务[id]==nil then
		每日任务[id]={日常任务={},副本任务={},挑战竞技={},节日活动={},活跃度={当前=0,总活跃=0},签到数据={}}
	end

	每日任务[id].活跃度.当前 = 每日任务[id].活跃度.当前 + 数额
	每日任务[id].活跃度.总活跃 = 每日任务[id].活跃度.总活跃 + 数额
	常规提示(id, "#Y/你获得了#G" .. 数额 .. "#Y点活跃度。")
end

function 角色处理类:添加活跃度(id, 数额)
    数额 = qz(数额 or 0)
	if 数额 < 1 then
		return
	end
	if 活跃数据[id] == nil then
		 活跃数据[id] = {
			领取300活跃 = false,
			领取500活跃 = false,
			领取400活跃 = false,
			领取200活跃 = false,
			领取100活跃 = false,
			活跃度 = 0
		}
	end
	活跃数据[id].活跃度 = (活跃数据[id].活跃度 or 0) + 数额
	玩家数据[id].角色.数据.累积活跃.当前积分 = 玩家数据[id].角色.数据.累积活跃.当前积分 + 数额
	常规提示(id, "#Y/你获得了#G" .. 数额 .. "#Y点活跃度。")
end
function 角色处理类:扣除活跃(数额, 说明, 提示)
	数额 = 数额 + 0
	local 之前活跃 = self.数据.累积活跃.当前积分
	if 数额 <= self.数据.累积活跃.当前积分 then
		self.数据.累积活跃.当前积分 = self.数据.累积活跃.当前积分 - 数额
		if 提示 ~= nil and 说明 ~= "商店购买" then
			常规提示(self.数据.数字id, "你失去了" .. 数额 .. "点可用活跃")
		end
		self:日志记录(format("事件:扣除活跃,类型%s,数额%s,倍率%s,获得前%s,获得后%s", 说明, 数额, 倍率, 之前活跃, self.数据.累积活跃.当前积分))
		return true
	end
	return false
end
function 角色处理类:扣除副本积分(num)
	if self.副本积分>=num then
		self.副本积分=self.副本积分-num
		消息提示(self.数字id,"你消耗了"..num.."点副本积分")
		 return true
	 else
		常规提示(self.数字id,"你的副本积分不足")
		return false
	end
end
function 角色处理类:扣除银子(数额, 储备, 存银, 说明, 提示)
	数额=qz(数额+0)
	local 之前银子 = self.银子
	local 倍率 = 1
	if 储备 == 0 and 存银 == 0 then
		if self.银子 >= 数额 then
			self.银子 = math.floor(self.银子 - 数额)
			if self.银子>之前银子 then
				self.银子=之前银子
				写配置("./ip封禁.ini", "ip", self.ip, 1)
				f函数.写配置(程序目录..[[data\]]..玩家数据[self.数字id].账号..[[\账号信息.txt]],"账号配置","封禁","1")
				local 封禁原因=self.ip.."“违规行为：扣除银子大于之前！！！”，玩家ID=="..self.数字id.."，玩家账号=="..玩家数据[self.数字id].账号.."时间="..os.date("%Y%m%d")..os.date("%H",os.time())..os.date("%S",os.time())
				f函数.写配置(程序目录..[[data\]]..玩家数据[self.数字id].账号..[[\账号信息.txt]],"账号配置","已违规5",封禁原因)
				f函数.写配置(程序目录..[[各类情况查看\]]..[[\违规汇总.txt]],"违规详情","已违规5:",封禁原因)
				发送数据(玩家数据[self.数字id].连接id, 998, "请注意你的角色异常！已经对你进行封禁")
				__S服务:断开连接(玩家数据[self.数字id].连接id)
				return false
			end
				消息提示(self.数字id, "你失去了"..数额.."两银子")
			self:日志记录(format("事件:扣除银子,类型%s,数额%s,倍率%s,获得前%s,获得后%s", 说明, 数额, 倍率, 之前银子, self.银子))
			return true
		else
			消息提示(self.数字id, "你没有那么多的银子")
			return false
		end
	end
end


function 角色处理类:扣除剑会积分(数额) --剑会天下
	if 玩家数据[self.数字id].角色.剑会数据==nil then
		玩家数据[self.数字id].角色.剑会数据={总场=0,战胜=0,战败=0,胜率=50,赛季场次=0,赛季积分=1000,商店积分=0,参加赛季=0} --麻瓜剑会3.8
	end
	if 数额 <= 0 then 消息提示(self.数字id, self.数字id .."存在作弊行为") return false end
	if 玩家数据[self.数字id].角色.剑会数据.商店积分 >= 数额 then
		玩家数据[self.数字id].角色.剑会数据.商店积分 = 玩家数据[self.数字id].角色.剑会数据.商店积分 - 数额
		消息提示(self.数字id, "你失去了"..数额.."剑会积分")
		return true
	end
	常规提示(self.数字id, "剑会积分不足以购买")
	return false
end

function 角色处理类:扣除经验(数额)
	数额=qz(数额+0)
	if self.当前经验>=数额 then
		 self.当前经验=math.floor(self.当前经验-数额)
		消息提示(self.数字id, "你消耗了"..数额.."点经验")
		return true
	end
	return false
end

function 角色处理类:扣除积分(数额, 事件, id)
end

function 角色处理类:加载变身属性()
	if self.变身数据 ~= nil and 变身卡数据[self.变身数据]  then
		if 变身卡数据[self.变身数据].技能 then
			if 变身卡数据[self.变身数据].技能=="高级敏捷" then
				self.速度=qz(self.速度*1.2)
			elseif 变身卡数据[self.变身数据].技能=="敏捷" then
				self.速度=qz(self.速度*1.1)
			elseif 变身卡数据[self.变身数据].技能=="高级强力" then
				self.伤害=self.伤害+qz(self.等级*0.55)
			elseif 变身卡数据[self.变身数据].技能=="强力" then
				self.伤害=self.伤害+qz(self.等级*0.4)
			elseif 变身卡数据[self.变身数据].技能=="高级防御" then
				self.防御=self.防御+qz(self.等级*0.8)
			elseif 变身卡数据[self.变身数据].技能=="防御" then
				self.防御=self.防御+qz(self.等级*0.6)
			elseif 变身卡数据[self.变身数据].技能=="迟钝" then
				self.速度=qz(self.速度*0.8)
			end
		end
		if 变身卡数据[self.变身数据].属性 ~= 0 then
			if 变身卡数据[self.变身数据].单独 == 1 then
				if 变身卡数据[self.变身数据].类型 == "气血" then
					if 变身卡数据[self.变身数据].正负 == 1 then
						self.最大气血 = self.最大气血 + 变身卡数据[self.变身数据].属性
					else
						self.最大气血 = self.最大气血 - 变身卡数据[self.变身数据].属性
					end
				else
					if 变身卡数据[self.变身数据].正负 == 1 then
						self[变身卡数据[self.变身数据].类型] = self[变身卡数据[self.变身数据].类型] + 变身卡数据[self.变身数据].属性
					else
						self[变身卡数据[self.变身数据].类型] = self[变身卡数据[self.变身数据].类型] - 变身卡数据[self.变身数据].属性
					end
				end
			else
				if 变身卡数据[self.变身数据].类型 == "气血" then
					if 变身卡数据[self.变身数据].正负 == 1 then
						self.最大气血 = self.最大气血 + math.floor(self.最大气血 * (变身卡数据[self.变身数据].属性 / 100))
					else
						self.最大气血 = self.最大气血 - math.floor(self.最大气血 * (变身卡数据[self.变身数据].属性 / 100))
					end
				else
					if 变身卡数据[self.变身数据].正负 == 1 then
						self[变身卡数据[self.变身数据].类型] = self[变身卡数据[self.变身数据].类型] + math.floor(self[变身卡数据[self.变身数据].类型] * (变身卡数据[self.变身数据].属性 / 100))
					else
						self[变身卡数据[self.变身数据].类型] = self[变身卡数据[self.变身数据].类型] - math.floor(self[变身卡数据[self.变身数据].类型] * (变身卡数据[self.变身数据].属性 / 100))
					end
				end
			end
		end
	end
end

function 角色处理类:加载经脉属性()
	if self.门派=="大唐官府" then
		 if self.奇经八脉.狂狷==1 then
				self.伤害 = self.伤害 + floor(self.力量/self.耐力*16)
		 end
		 if self.奇经八脉.无敌==1 then
				self.伤害 = self.伤害 + 80
		 elseif self.奇经八脉.破军==1 then
				self.最大气血 = self.最大气血 + 560
		 elseif self.奇经八脉.披挂上阵==1 then
				self.速度 = self.速度 + 60
		 end
	elseif self.门派=="化生寺" then
		if self.奇经八脉.渡劫金身==1 then
			self.治疗能力 = self.治疗能力 + 60
		end
		if self.奇经八脉.诵经==1 then
			 self.最大魔法 = self.最大魔法 - floor(self.魔力 * 2.5)
		end
		if self.奇经八脉.生花==1 and self:取师门技能等级("佛门普渡")>=self.等级 then --渡世步
				self.法伤 = self.法伤 + 60
		end
		if self.奇经八脉.金刚==1 then
			 self.防御 = self.防御 + 80
		elseif self.奇经八脉.达摩==1 then
			 self.最大气血 = self.最大气血 + 320
		elseif self.奇经八脉.韦陀==1 then
			 self.速度 = self.速度 + 30
		end
		if self.奇经八脉.坐禅==1 then
			 self.法伤 = self.法伤 + 80
		end
	 elseif self.门派=="龙宫" then
		if self.奇经八脉.踏涛==1 and self:取师门技能等级("破浪诀")>=self.等级 then
				self.法伤 = self.法伤 + 160
		end
		if self.奇经八脉.亢龙归海==1 then
			self.法伤 = self.法伤 + 80
		end
		if self.奇经八脉.雷浪穿云==1 then
			self.防御 = self.防御 + 160
		end
		if self.奇经八脉.潜龙在渊==1 then
			self.法术暴击等级 = self.法术暴击等级 + 0.8
		end
	 elseif self.门派=="魔王寨" then
		if self.奇经八脉.震天==1 and self:取师门技能等级("震天诀")>=self.等级 then
				self.法伤 = self.法伤 + 160
		end
		if self.奇经八脉.魔心==1 then
			self.法术暴击等级 = self.法术暴击等级 + 50
		end
		if self.奇经八脉.魔焰滔天==1 then
			 self.法伤 = self.法伤 + 80
		end
		if self.奇经八脉.升温==1 then
			 self.防御 = self.防御 + 160
		end
	 elseif self.门派=="神木林" then
		if self.奇经八脉.咒法==1 and self:取师门技能等级("巫咒")>=self.等级 then
				self.法伤 = self.法伤 + 160
		end
		if self.奇经八脉.风卷残云==1 then
			 self.法伤 = self.法伤 + 80
		end
		if self.奇经八脉.凋零之歌==1 then
				self.最大气血 = self.最大气血 + 560
		 end
	elseif self.门派=="方寸山" then
		if self.奇经八脉.顺势而为==1 then
			 self.速度 = self.速度 + 60
		end
		if self.奇经八脉.钟馗论道==1 then
			 self.法伤 = self.法伤 + 80
		end
	elseif self.门派=="女儿村" then
		if self.奇经八脉.碎玉弄影==1 then
			 self.封印命中等级 = self.封印命中等级 + 80
		end
		if self.奇经八脉.鸿渐于陆==1 then
			 self.抵抗封印等级 = self.抵抗封印等级 + 160
		end
		if self.奇经八脉.花谢花飞==1 then
			 self.伤害 = self.伤害 + 80
		end
	 elseif self.门派=="天宫" then
		if self.奇经八脉.护佑==1 then
			 self.防御 = self.防御 + 50
			 self.法防 = self.法防 + 50
		end
		if self.奇经八脉.画地为牢==1 then
			 self.封印命中等级 = self.封印命中等级 + 80
		end
		if self.奇经八脉.轰鸣==1 and self:取师门技能等级("混天术")>=self.等级 then
				self.法伤 = self.法伤 + 60
		end
		if self.奇经八脉.驭意==1 then --增加自身(魔力属性点×5%)的速度、(魔力属性点×10%)的法术伤害力、减少(魔力属性点×24%)的法术防御力。"
			 self.速度 = self.速度 + floor(self.魔力*0.05)
			 self.法伤 = self.法伤 + floor(self.魔力*0.1)
			 self.法防 = self.法防 - floor(self.魔力*0.24)
		end
		if self.奇经八脉.风雷韵动==1 then
			 self.法伤 = self.法伤 + 80
		end
		if self.奇经八脉.劲健==1 then
			 self.伤害 = self.伤害 + 50
		end
		if self.奇经八脉.威仪九霄==1 then
			 self.伤害 = self.伤害 + 80
		end
	elseif self.门派=="普陀山" then
		if self.奇经八脉.波澜不惊==1 then
			 self.法防 = self.法防 + 160
		end
		if self.奇经八脉.五行制化==1 then
			 self.速度 = self.速度 + 60
		end
		if self.奇经八脉.抖擞==1 then
				self.伤害 = self.伤害 + floor(self.力量*0.1+40)
		 end
		 if self.奇经八脉.万象==1 then
				self.伤害 = self.伤害 + 80
		 end
	elseif self.门派=="盘丝洞" then
		if self.奇经八脉.落花成泥==1 then
			 self.法防 = self.法防 + 160
		end
		if self.奇经八脉.妖气 then
			self.封印命中等级 = self.封印命中等级 + floor(self.武器伤害 * 0.12)
		end
		if self.奇经八脉.偷龙转凤==1 then
			 self.速度 = self.速度 + 60
		end
		if self.奇经八脉.亡缚==1 then
			self.物理暴击等级=self.物理暴击等级+50
		end
		if self.奇经八脉.绝命毒牙==1 then
			self.抵抗封印等级=self.抵抗封印等级+160
		end
	elseif self.门派=="阴曹地府" then
		if self.奇经八脉.魍魉追魂==1 then
			 self.速度 = self.速度 + 60
		end
		if self.奇经八脉.夜之王者==1 then
			 self.伤害 = self.伤害 + 80
		end
		if self.奇经八脉.生杀予夺==1 then
			 self.物理暴击等级 = self.物理暴击等级 + 80
		end
	 elseif self.门派=="狮驼岭" then
		if self.奇经八脉.背水==1 then
			 self.速度 = self.速度 + 60
		end
		if self.奇经八脉.困兽之斗==1 then
			 self.伤害 = self.伤害 + 80
		end
	 elseif self.门派=="五庄观" then
		if self.奇经八脉.清风望月==1 then
			 self.速度 = self.速度 + 60
		end
		if self.奇经八脉.锤炼==1 then
			 self.伤害 = self.伤害 + floor(self.武器伤害*0.04)
		end
		if self.奇经八脉.神附==1 then
			 self.伤害 = self.伤害 + floor(self.力量*0.08)
		end
		if self.奇经八脉.纳气==1 then
			 self.伤害 = self.伤害 + floor(self.力量*0.1+40)
		end
		if self.奇经八脉.天命剑法==1 then
			 self.伤害 = self.伤害 + 80
		end
		if self.奇经八脉.落土止息==1 then
			 self.物理暴击等级 = self.物理暴击等级 + 80
		end
	 elseif self.门派=="无底洞" then
		if self.奇经八脉.同舟共济==1 then
			 self.法防 = self.法防 + 160
		end
		if self.奇经八脉.烈煞 then
			self.封印命中等级=self.封印命中等级 + 50
		end
		if self.奇经八脉.妖风四起==1 then
			 self.封印命中等级 = self.封印命中等级 + 80
		end
	elseif self.门派=="凌波城" then
		if self.奇经八脉.海沸==1 then
			 self.伤害 = self.伤害 + floor(self.力量*0.1+40)
		end
		if self.奇经八脉.天神怒斩==1 then
			 self.伤害 = self.伤害 + 80
		end
		if self.奇经八脉.真君显灵==1 then
			 self.伤害 = self.伤害 + 80
		end
	elseif self.门派=="花果山" then
		if self.奇经八脉.伏妖==1 then
			 self.伤害 = self.伤害 + floor(self.力量*0.1+40)
		end
		if self.奇经八脉.战神==1 then
			 self.速度 = self.速度 + 80
		end
		if self.奇经八脉.齐天神通==1 then
			if self.奇经八脉.当前流派=="齐天武圣" then
				self.伤害 = self.伤害 + 80
			 elseif self.奇经八脉.当前流派=="通天行者" then
				self.法伤 = self.法伤 + 80
			end
		end
	end
end

function 角色处理类:加载法宝等级()

	for k, v in pairs(self.法宝佩戴) do
		if k~=nil and v ~= nil and 玩家数据[self.数字id].道具.数据[v].名称~=nil and 玩家数据[self.数字id].道具.数据[v].气血~=nil and 玩家数据[self.数字id].道具.数据[v].魔法~=nil then
			local 名称 = 玩家数据[self.数字id].道具.数据[v].名称
			 local 境界 = 玩家数据[self.数字id].道具.数据[v].气血
			 local 灵气 = 玩家数据[self.数字id].道具.数据[v].魔法
			 local 五行 = 玩家数据[self.数字id].道具.数据[v].五行

			 if 灵气>0 then
				if 名称=="风袋" then --加25速度
					local 加成 = 10
					if 境界==3 then
						 加成 = 11
					elseif 境界==4 then
						 加成 = 12
					elseif 境界==5 then
						 加成 = 14
					elseif 境界==6 then
						 加成 = 15
					elseif 境界==7 then
						 加成 = 18
					elseif 境界==8 then
						 加成 = 21
					elseif 境界==9 then
						 加成 = 25
					end
					if 五行=="水" then
						 self.速度 = self.速度 + 加成 + 1
					elseif 五行=="土" then
						 self.速度 = self.速度 + 加成 - 1
					else
						self.速度 = self.速度 + 加成
					end

				elseif 名称=="凌波仙符" and self.门派=="凌波城" then --无法与风袋一起佩戴
					 self.速度 = self.速度 + 境界*2 + 4
					 if 五行=="金" then
							self.速度 = self.速度 + 5
					 end
				end

				if 名称=="定风珠" and self.门派=="五庄观" then
					if self.额外法宝等级["乾坤袖"]==nil then
						 self.额外法宝等级["乾坤袖"]=0
					end
					if 境界<=7 then
						 self.额外法宝等级["乾坤袖"]=self.额外法宝等级["乾坤袖"]+1
					else
						self.额外法宝等级["乾坤袖"]=self.额外法宝等级["乾坤袖"]+2
					end
				elseif 名称=="天师符" and self.门派=="方寸山" then
					if self.额外法宝等级["符之术"]==nil then
						 self.额外法宝等级["符之术"]=0
					end
					if 境界<=7 then
						 self.额外法宝等级["符之术"]=self.额外法宝等级["符之术"]+1
					else
						self.额外法宝等级["符之术"]=self.额外法宝等级["符之术"]+2
					end
				elseif 名称=="织女扇" and self.门派=="女儿村" then
					if self.额外法宝等级["闭月羞花"]==nil then
						 self.额外法宝等级["闭月羞花"]=0
					end
					if 境界<=7 then
						 self.额外法宝等级["闭月羞花"]=self.额外法宝等级["闭月羞花"]+1
					else
						self.额外法宝等级["闭月羞花"]=self.额外法宝等级["闭月羞花"]+2
					end
				elseif 名称=="雷兽" and self.门派=="天宫" then
					if self.额外法宝等级["乾坤塔"]==nil then
						 self.额外法宝等级["乾坤塔"]=0
					end
					if 境界<=7 then
						 self.额外法宝等级["乾坤塔"]=self.额外法宝等级["乾坤塔"]+1
					else
						self.额外法宝等级["乾坤塔"]=self.额外法宝等级["乾坤塔"]+2
					end
				elseif 名称=="迷魂灯" and self.门派=="盘丝洞" then
					if self.额外法宝等级["迷情大法"]==nil then
						 self.额外法宝等级["迷情大法"]=0
					end
					if 境界<=7 then
						 self.额外法宝等级["迷情大法"]=self.额外法宝等级["迷情大法"]+1
					else
						self.额外法宝等级["迷情大法"]=self.额外法宝等级["迷情大法"]+2
					end
				elseif 名称=="幽灵珠" and self.门派=="无底洞" then
					if self.额外法宝等级["阴风绝章"]==nil then
						 self.额外法宝等级["阴风绝章"]=0
					end
					if 境界<=7 then
						 self.额外法宝等级["阴风绝章"]=self.额外法宝等级["阴风绝章"]+1
					else
						self.额外法宝等级["阴风绝章"]=self.额外法宝等级["阴风绝章"]+2
					end
				end
			 end
		end
	end
end

function 角色处理类:装备附加属性()
	local 动物套 = {}
	local 符石组合 = {}
	local 星位颜色 = {}
	local 装备等级 = 0
	local 套装数量 = 0
	local 套装名称 = 0

	for n, v in pairs(self.装备) do
		if 玩家数据[self.数字id].道具.数据[self.装备[n]] ~=nil and 玩家数据[self.数字id].道具.数据[self.装备[n]].套装效果~=nil then
if 玩家数据[self.数字id].道具.数据[self.装备[n]].套装效果 == 玩家数据[self.数字id].道具.数据[self.装备[n]].套装效果 then
	 套装数量 = 套装数量+1
	if 套装数量 >=3  then
玩家数据[self.数字id].角色.套装名称=玩家数据[self.数字id].道具.数据[self.装备[n]].套装效果
         end
      end
   end
end


if   玩家数据[self.数字id].角色.套装激活~=nil   then
if  套装数量>=3 then
玩家数据[self.数字id].角色.套装激活=1
else
	玩家数据[self.数字id].角色.套装激活=0
	玩家数据[self.数字id].角色.套装名称="无"
end
end

	for n, v in pairs(self.装备) do
		--装备套装属性
		if 玩家数据[self.数字id].道具.数据[self.装备[n]] ~=nil and 玩家数据[self.数字id].道具.数据[self.装备[n]].套装效果~=nil then
			if 玩家数据[self.数字id].道具.数据[self.装备[n]].套装效果[1]=="变身术之" then
				if 判断是否为空表(动物套) then
					动物套[#动物套+1]={玩家数据[self.数字id].道具.数据[self.装备[n]].套装效果[2],数量=1}
				else
					local 新套装效果 = true
					for i=1,#动物套 do
						if 动物套[i][1] == 玩家数据[self.数字id].道具.数据[self.装备[n]].套装效果[2] then
							动物套[i].数量=动物套[i].数量+1
							新套装效果=false
						end
					end
					if 新套装效果 then
						动物套[#动物套+1]={玩家数据[self.数字id].道具.数据[self.装备[n]].套装效果[2],数量=1}
					end
				end
			end
		end

		local ZB = 玩家数据[self.数字id].道具.数据[v]
		--装备符石
		if ZB~=nil and ZB.星位~=nil and ZB.星位.组合~=nil then
			if (ZB.星位.门派==nil or ZB.星位.门派==self.门派) and (ZB.星位.部位==nil or ZB.星位.部位==ZB.分类) then
				if 符石组合[ZB.星位.组合]==nil then
					符石组合[ZB.星位.组合]={}
					符石组合[ZB.星位.组合][#符石组合[ZB.星位.组合]+1]=ZB.星位.组合等级
				else
					if ZB.星位.组合=="高山流水" or ZB.星位.组合=="天降大任"or ZB.星位.组合=="柳暗花明" then
						for k,i in pairs(符石组合[ZB.星位.组合]) do
							if ZB.星位.组合等级>i then
								i=ZB.星位.组合等级
								break
							end
						end
					else
						符石组合[ZB.星位.组合][#符石组合[ZB.星位.组合]+1]=ZB.星位.组合等级
						if #符石组合[ZB.星位.组合]>2 then
							table.sort(符石组合[ZB.星位.组合])
							table.remove(符石组合[ZB.星位.组合],1)
						end
					end
				end
			end
		end
	end
	if 判断是否为空表(动物套)~=nil then
		for i=1,#动物套 do
			if 动物套[i].数量>=3 then
				local 属性加成 = 取动物套加成(动物套[i][1],self.等级)
				local 数值 = 0
				if 动物套[i].数量>=5 then
					数值 = 数值 + 属性加成.属性 + 属性加成.件数[2]
					self.动物套属性[属性加成.类型] = self.动物套属性[属性加成.类型] + 数值
				else
					数值 = 数值 + 属性加成.属性 + 属性加成.件数[1]
					self.动物套属性[属性加成.类型] = self.动物套属性[属性加成.类型] + 数值
				end
				self.动物套属性.名称=动物套[i][1]
				self.动物套属性.件数=动物套[i].数量
			end
		end
	end
	if not 判断是否为空表(符石组合) then
		self:符石组合效果刷新(符石组合)
	end


end




function 角色处理类:刷新信息(是否, 体质, 魔力, 装备)
	self.动物套属性 = {体质=0,魔力=0,力量=0,耐力=0,敏捷=0,名称="无",件数=0}
	self.额外技能属性 = {伤害=0,灵力=0,防御=0,命中=0,速度=0,气血=0,魔法=0,治疗能力=0,暗器防御=0,躲避=0}
	self.坐骑属性 = {体质=0,魔力=0,力量=0,耐力=0,敏捷=0}
	self.符石技能效果 = {}
	self.额外技能等级 = {}
	self.额外法宝等级 = {}
	self:装备附加属性()

	local 修身 = 0
	if self.坐骑 ~= nil then --还要算一个好感度影响人物属性  ，饱食度影响宝宝
		local num = self.坐骑.等级
		local jiac = self.坐骑.好感度*0.01
		if jiac>1 then
			 jiac=1
		end
		local cz = self.坐骑.初始成长+self.坐骑.额外成长
		    cz=cz*jiac
		   self.坐骑属性 = {体质=num,魔力=num,力量=num,耐力=num,敏捷=num}
		if self.坐骑.主属性~=nil then
			 self.坐骑属性[self.坐骑.主属性]=self.坐骑属性[self.坐骑.主属性]+num*5
		end
		self.坐骑属性.体质=math.floor(self.坐骑属性.体质/25*cz)
		self.坐骑属性.魔力=math.floor(self.坐骑属性.魔力/31*cz)
		self.坐骑属性.力量=math.floor(self.坐骑属性.力量/21*cz)
		self.坐骑属性.耐力=math.floor(self.坐骑属性.耐力/24*cz)
		self.坐骑属性.敏捷=math.floor(self.坐骑属性.敏捷/33*cz)
	end

	if self.门派=="五庄观" and self.奇经八脉.修身==1 then
		修身 = 14
	end
	local zbsx = {体质 = self.装备属性.体质, 魔力 = self.装备属性.魔力, 力量 = self.装备属性.力量, 耐力 = self.装备属性.耐力, 敏捷 = self.装备属性.敏捷}
	local 五维属性 = self:取属性(self.种族, {
		self.体质 + zbsx.体质+修身+self.坐骑属性.体质+self.动物套属性.体质,
		self.魔力 + zbsx.魔力+修身+self.坐骑属性.魔力+self.动物套属性.魔力,
		self.力量 + zbsx.力量+修身+self.坐骑属性.力量+self.动物套属性.力量,
		self.耐力 + zbsx.耐力+修身+self.坐骑属性.耐力+self.动物套属性.耐力,
		self.敏捷 + zbsx.敏捷+修身+self.坐骑属性.敏捷+self.动物套属性.敏捷
		})

local 锻炼加成伤害=0
local 锻炼加成命中=0
local 锻炼加成魔法=0
local 锻炼加成防御=0
local 锻炼加成灵力=0
local 锻炼加成敏捷=0
local 锻炼加成气血=0
local 锻炼加成速度=0
if self.精炼等级~=nil then
      if self.精炼等级[1] >= 40 and self.精炼等级[2] >= 40 and self.精炼等级[3] >= 40 and self.精炼等级[4] >= 40 and self.精炼等级[5] >= 40
        and self.精炼等级[6] >= 40 then
        锻炼加成气血 = math.floor(self.装备属性.气血*1.2)
        锻炼加成魔法 = math.floor(self.装备属性.魔法*1.2)
        锻炼加成伤害=math.floor(self.装备属性.伤害*1.1)
        锻炼加成灵力=math.floor(self.装备属性.灵力*1.1)
        锻炼加成速度=math.floor(self.装备属性.敏捷*1.1)
    elseif self.精炼等级[1] >= 36 and self.精炼等级[2] >= 36 and self.精炼等级[3] >= 36 and self.精炼等级[4] >= 36 and self.精炼等级[5] >= 36
        and self.精炼等级[6] >= 36 then
      锻炼加成气血 = math.floor(self.装备属性.气血*1.09)
       锻炼加成魔法 = math.floor(self.装备属性.魔法*1.09)
       锻炼加成伤害=math.floor(self.装备属性.伤害*1.09)
       锻炼加成灵力=math.floor(self.装备属性.灵力*1.09)
      锻炼加成速度=math.floor(self.装备属性.敏捷*1.09)
    elseif self.精炼等级[1] >= 32 and self.精炼等级[2] >= 32 and self.精炼等级[3] >= 32 and self.精炼等级[4] >= 32 and self.精炼等级[5] >= 32
        and self.精炼等级[6] >= 32 then
       锻炼加成气血 = math.floor(self.装备属性.气血*1.08)
       锻炼加成魔法 = math.floor(self.装备属性.魔法*1.08)
       锻炼加成伤害=math.floor(self.装备属性.伤害*1.08)
       锻炼加成灵力=math.floor(self.装备属性.灵力*1.08)
       锻炼加成速度=math.floor(self.装备属性.敏捷*1.08)
    elseif self.精炼等级[1] >= 28 and self.精炼等级[2] >= 28 and self.精炼等级[3] >= 28 and self.精炼等级[4] >= 28 and self.精炼等级[5] >= 28
        and self.精炼等级[6] >= 28 then
       锻炼加成气血 = math.floor(self.装备属性.气血*1.07)
       锻炼加成魔法 = math.floor(self.装备属性.魔法*1.07)
      锻炼加成伤害=math.floor(self.装备属性.伤害*1.07)
        锻炼加成灵力=math.floor(self.装备属性.灵力*1.07)
      锻炼加成速度=math.floor(self.装备属性.敏捷*1.07)
    elseif self.精炼等级[1] >= 24 and self.精炼等级[2] >= 24 and self.精炼等级[3] >= 24 and self.精炼等级[4] >= 24 and self.精炼等级[5] >= 24
        and self.精炼等级[6] >= 24 then
       锻炼加成气血 = math.floor(self.装备属性.气血*1.06)
       锻炼加成魔法 = math.floor(self.装备属性.魔法*1.06)
     锻炼加成伤害=math.floor(self.装备属性.伤害*1.06)
       锻炼加成灵力=math.floor(self.装备属性.灵力*1.06)
       锻炼加成速度=math.floor(self.装备属性.敏捷*1.06)
    elseif self.精炼等级[1] >= 20 and self.精炼等级[2] >= 20 and self.精炼等级[3] >= 20 and self.精炼等级[4] >= 20 and self.精炼等级[5] >= 20
        and self.精炼等级[6] >= 20 then
      锻炼加成气血 = math.floor(self.装备属性.气血*1.05)
       锻炼加成魔法 = math.floor(self.装备属性.魔法*1.05)
      锻炼加成伤害=math.floor(self.装备属性.伤害*1.05)
      锻炼加成灵力=math.floor(self.装备属性.灵力*1.05)
     锻炼加成速度=math.floor(self.装备属性.敏捷*1.05)
    elseif self.精炼等级[1] >= 16 and self.精炼等级[2] >= 16 and self.精炼等级[3] >= 16 and self.精炼等级[4] >= 16 and self.精炼等级[5] >= 16
        and self.精炼等级[6] >= 16 then
       锻炼加成气血 = math.floor(self.装备属性.气血*1.04)
        锻炼加成魔法 = math.floor(self.装备属性.魔法*1.04)
      锻炼加成伤害=math.floor(self.装备属性.伤害*1.04)
      锻炼加成灵力=math.floor(self.装备属性.灵力*1.04)
    锻炼加成速度=math.floor(self.装备属性.敏捷*1.04)
    elseif self.精炼等级[1] >= 12 and self.精炼等级[2] >= 12 and self.精炼等级[3] >= 12 and self.精炼等级[4] >= 12 and self.精炼等级[5] >= 12
        and self.精炼等级[6] >= 12 then
       锻炼加成气血 = math.floor(self.装备属性.气血*1.03)
       锻炼加成魔法 = math.floor(self.装备属性.魔法*1.03)
       锻炼加成伤害=math.floor(self.装备属性.伤害*1.03)
        锻炼加成灵力=math.floor(self.装备属性.灵力*1.03)
      锻炼加成速度=math.floor(self.装备属性.敏捷*1.03)
    elseif self.精炼等级[1] >= 8 and self.精炼等级[2] >= 8 and self.精炼等级[3] >= 8 and self.精炼等级[4] >= 8 and self.精炼等级[5] >= 8
        and self.精炼等级[6] >= 8 then
      锻炼加成气血 = math.floor(self.装备属性.气血*1.02)
    锻炼加成魔法 = math.floor(self.装备属性.魔法*1.02)
  锻炼加成伤害=math.floor(self.装备属性.伤害*1.02)
       锻炼加成灵力=math.floor(self.装备属性.灵力*1.02)
      锻炼加成速度=math.floor(self.装备属性.敏捷*1.02)
    elseif self.精炼等级[1] >= 4 and self.精炼等级[2] >= 4 and self.精炼等级[3] >= 4 and self.精炼等级[4] >= 4 and self.精炼等级[5] >= 4
        and self.精炼等级[6] >= 4 then
       锻炼加成气血 = math.floor(self.装备属性.气血*1.01)
       锻炼加成魔法 = math.floor(self.装备属性.魔法*1.01)
       锻炼加成伤害=math.floor(self.装备属性.伤害*1.01)
      锻炼加成灵力=math.floor(self.装备属性.灵力*1.01)
      锻炼加成速度=math.floor(self.装备属性.敏捷*1.01)
    end

     if self.装备[3]~=nil then
     锻炼加成伤害= 锻炼加成伤害+self.装备属性.伤害*self.精炼等级[3]*0.1
     锻炼加成命中= 锻炼加成命中+self.装备属性.命中*self.精炼等级[3]*0.1

     end
     if self.装备[1]~=nil then
     锻炼加成魔法=锻炼加成魔法+self.装备属性.魔法*self.精炼等级[1]*0.1
     锻炼加成防御=锻炼加成防御+self.装备属性.防御*self.精炼等级[1]*0.1
    end
      if self.装备[2]~=nil then
     锻炼加成灵力=锻炼加成灵力+self.装备属性.灵力*self.精炼等级[2]*0.1


     end
      if self.装备[4]~=nil then
     锻炼加成防御=锻炼加成防御+self.装备属性.防御*self.精炼等级[4]*0.1


     end
     if self.装备[5]~=nil then
       锻炼加成气血= 锻炼加成气血+self.装备属性.气血*self.精炼等级[5]*0.1
       锻炼加成防御=锻炼加成防御+self.装备属性.防御*self.精炼等级[5]*0.1

      end
      if self.装备[6]~=nil then
       锻炼加成敏捷= 锻炼加成敏捷+self.装备属性.敏捷*self.精炼等级[6]*0.1
       锻炼加成防御=锻炼加成防御+self.装备属性.防御*self.精炼等级[6]*0.1

      end

    end


	for n = 1, #灵饰战斗属性 do
		if self.装备属性[灵饰战斗属性[n]]==nil then
			self.装备属性[灵饰战斗属性[n]]=0
		end
		self[灵饰战斗属性[n]]= self.装备属性[灵饰战斗属性[n]]
	end

	self.命中 =锻炼加成命中+ math.floor(五维属性["命中"] + self.装备属性.命中 + self.技能属性.命中 + self.额外技能属性.命中)
	self.伤害 =锻炼加成伤害+ math.floor(五维属性["伤害"] + self.装备属性.伤害 + self.技能属性.伤害 + self.额外技能属性.伤害 + (self.装备属性.命中 / 3)+ (self.技能属性.命中 / 3) + (self.额外技能属性.命中 / 3))
	self.伤害 = self.伤害 + self:取强化技能等级("伤害强化")
	 if self.门派=="阴曹地府" then
		 self.黑夜伤害 =  qz(self:门派技能算法(2.3766,0.021073,self:取师门技能等级("六道轮回")))-qz(self:门派技能算法(1.46569,0.0092,self:取师门技能等级("六道轮回")))
	 end

	self.防御 =锻炼加成防御+ math.floor(五维属性["防御"] + self.装备属性.防御 + self.技能属性.防御 + self.额外技能属性.防御)
	self.防御 = self.防御 + self:取强化技能等级("防御强化")
	self.速度 = 锻炼加成敏捷+锻炼加成速度+math.floor(五维属性["速度"] + self.装备属性.速度 + self.技能属性.速度 + self.额外技能属性.速度 + self:取生活技能等级("神速")*1.5)
	self.灵力 = 锻炼加成灵力+ math.floor(五维属性["灵力"] + self.装备属性.灵力 + self.技能属性.灵力 + self.额外技能属性.灵力)
	self.躲避 = math.floor(五维属性["躲避"] + self.装备属性.躲避 + self.技能属性.躲避 + self.额外技能属性.躲避)
	self.最大气血 = 五维属性["气血"] + self.装备属性.气血 + self.技能属性.气血 + self.额外技能属性.气血
	self.最大魔法 =锻炼加成魔法+ 五维属性["法力"] + self.装备属性.魔法 + self.技能属性.魔法 + self.额外技能属性.魔法
	self.最大气血 = 锻炼加成气血+math.floor(self.最大气血 * ( 1 + ( self:取生活技能等级("强身术") * 0.01 + self:取师门技能等级("傲世诀") * 0.003 )) + (self:取生活技能等级("强壮") * 15 *(1 + self:取生活技能等级("强身术") * 0.01)))
	self.最大气血 = self.最大气血 + self:取强化技能等级("气血强化") * 10
	self.最大魔法 = math.floor(self.最大魔法 * ( 1 + ( self:取生活技能等级("冥想") * 0.01 +  self:取师门技能等级("周易学") * 0.005 )))
	self.最大活力 = math.floor( 10 + self.等级 * 5 + self:取生活技能等级("养生之道") * 4)
	self.最大体力 = math.floor( 10 + self.等级 * 5 + self:取生活技能等级("健身术") * 4)
	self.法伤 = self.灵力 + self:取强化技能等级("法伤强化")
	self.法防 = self.灵力 + self:取强化技能等级("法防强化")
	self.固定伤害=self.固定伤害+ 2*self:取强化技能等级("固伤强化")
	self.治疗能力=self.治疗能力+self.装备属性.治疗能力 + self:取强化技能等级("治疗强化")
	self:加载变身属性()
	self:加载经脉属性()
	self:加载法宝等级()
	if self.神器佩戴 then --xjs
		 for k,v in pairs(self.神器属性) do
			if v~=0 then
				if k=="气血" then
					 self.最大气血=self.最大气血+v
				else
					self[k]=self[k]+v
				end
			end
		end
	end

	if self.气血上限 > self.最大气血 then
		self.气血上限 = self.最大气血
		self.气血 = self.气血上限
	end
	if 是否 == "0" then
		self.气血上限 = self.最大气血
		self.气血 = self.气血上限
		self.魔法 = self.最大魔法
	end
	if 是否 == "1" then
		self.气血 = self.气血上限
		self.魔法 = self.最大魔法
	end
	if 体质 ~= nil and 体质 > 0 then
		self.气血 = self.气血上限
	end
	if 魔力 ~= nil and 魔力 > 0 then
		self.魔法 = self.最大魔法
	end
	if self.气血 > self.气血上限 then
		self.气血 = self.气血上限 - self.气血 + self.气血
		self.气血上限 = self.气血上限 - self.气血上限 + self.气血上限
	end
	if self.魔法 > self.最大魔法 then
		self.魔法 = self.最大魔法 - self.魔法 + self.魔法
	end
	if self.愤怒 > 150 then
		self.愤怒 = 150 - self.愤怒 + self.愤怒
	end
	if self.活力 > self.最大活力 then
		self.活力 = self.最大活力
	end
	if self.体力 > self.最大体力 then
		self.体力 = self.最大体力
	end
	self.气血 = math.floor(self.气血)
	self.气血上限 = math.floor(self.气血上限)
	self.最大气血 = math.floor(self.最大气血)
	self.魔法 = math.floor(self.魔法)
	self.愤怒 = math.floor(self.愤怒)
	self.活力 = math.floor(self.活力)
	self.体力 = math.floor(self.体力)
	self.等级 = self.等级
	if self.等级 <= 174 then
		self.最大经验 = self:取经验(1, self.等级)
	end
	if self.门派 ~= "无门派" then
		if self.师门技能[1] == nil then
			local 列表 = self:取门派技能(self.门派)
			if 列表 ~= nil and #列表 ~= nil then
				for n = 1, #列表 do
					self.师门技能[n] = jnzbzz()
					self.师门技能[n]:置对象(列表[n])
					self.师门技能[n].包含技能 = {}
					local w = self:取包含技能(self.师门技能[n].名称,self.奇经八脉["当前流派"])
					for s = 1, #w do
						self.师门技能[n].包含技能[s] = jnzbzz()
						self.师门技能[n].包含技能[s]:置对象(w[s])
					end
				end
			end
		end

	end

	if self.师门技能[1]~= nil then
		if 是否 == "2" then
			for n = 1, 7 do
				for l = 1, #self.师门技能[n].包含技能 do
					if self:有无技能(self.师门技能[n].包含技能[l].名称) then
						self.师门技能[n].包含技能[l].学会 = true
					end
				end
			end
		end
	end

	 if self.门派=="方寸山" and self.奇经八脉.斗法==1 then
			self.法伤 = math.floor(self.法伤 + self.法术伤害)
			self.封印命中等级=self.封印命中等级 + math.floor(self.装备属性.伤害*0.12)
	 elseif self.门派=="天宫" and self.奇经八脉.月桂==1 then
		self.法伤 = math.floor(self.法伤 + self.法术伤害)
		self.封印命中等级=self.封印命中等级 + math.floor(self.装备属性.伤害*0.12)
	 else
		self.法伤 = math.floor(self.法伤 + self.法术伤害  + (self.装备属性.伤害*0.25))
	 end
	self.法防 = math.floor(self.法防 + self.法术防御)

		if self.修业 and self.修业.等级>0 then
					self.最大气血=self.最大气血+self.修业.等级*8
					-- self.防御=self.防御+self.修业.等级
					self.伤害=self.伤害+self.修业.等级*3
					self.法伤=self.法伤+self.修业.等级*10
					self.固定伤害=self.固定伤害+self.修业.等级*10
					-- self.灵力=self.灵力+self.修业.等级*5
					self.速度=self.速度+self.修业.等级*2
				end
if  self.器灵效果 then
		if self.器灵效果.金蝉==2 then
			self.速度=self.速度+qz(self.速度*0.03)
			self.防御=self.防御+qz(self.防御*0.03)
			self.最大气血=self.最大气血+qz(self.最大气血*0.03)
		elseif  self.器灵效果.金蝉==4 then
			self.速度=self.速度+qz(self.速度*0.06)
			self.防御=self.防御+qz(self.防御*0.06)
			self.最大气血=self.最大气血+qz(self.最大气血*0.06)
		elseif  self.器灵效果.金蝉==6 then
			self.速度=self.速度+qz(self.速度*0.08)
			self.防御=self.防御+qz(self.防御*0.08)
			self.最大气血=self.最大气血+qz(self.最大气血*0.08)
		elseif  self.器灵效果.无双==2 then
			self.伤害=self.伤害+qz(self.伤害*0.03)
			self.灵力=self.灵力+qz(self.灵力*0.03)
			self.法伤=self.法伤+qz(self.法伤*0.03)
			self.封印命中等级=self.封印命中等级+qz(self.封印命中等级*0.03)
		elseif  self.器灵效果.无双==4 then
			self.伤害=self.伤害+qz(self.伤害*0.06)
			self.灵力=self.灵力+qz(self.灵力*0.06)
			self.法伤=self.法伤+qz(self.法伤*0.06)
			self.封印命中等级=self.封印命中等级+qz(self.封印命中等级*0.06)
		elseif  self.器灵效果.无双==6 then
			self.伤害=self.伤害+qz(self.伤害*0.08)
			self.灵力=self.灵力+qz(self.灵力*0.08)
			self.法伤=self.法伤+qz(self.法伤*0.08)
			self.封印命中等级=self.封印命中等级+qz(self.封印命中等级*0.08)
		end
	end
if self.元素曜石~=nil then
   self.防御=qz(self.防御+self.防御*self.元素曜石.防御)
   self.速度=qz(self.速度+self.速度*self.元素曜石.速度)
    self.伤害=qz(self.伤害+self.伤害*self.元素曜石.伤害)
       self.固定伤害=qz(self.固定伤害+self.固定伤害*self.元素曜石.固定伤害)
          self.法伤=qz(self.法伤+self.法伤*self.元素曜石.法伤)
             self.封印命中等级=qz(self.封印命中等级+self.封印命中等级*self.元素曜石.封印命中等级)


  	end
	if 是否 == "2" or 是否 == "6" or 是否 == "1" then
		发送数据(玩家数据[self.数字id].连接id, 47, {玩家数据[self.数字id].角色:取气血数据()})
	elseif 是否 == "33" then
		发送数据(玩家数据[self.数字id].连接id, 33, self:取总数据1())
	end
end

function 角色处理类:任务到期(rwid)
	local lx = 0
	if self and self.任务 then
		for n, v in pairs(self.任务) do
			if v == rwid then
				lx = n
				break
			end
		end
		if lx~=0 then
			 self.任务[lx]=nil
			 self:刷新任务跟踪()
		else
			f函数.写配置("./任务销毁.ini","未被销毁任务",""..rwid,1)
		end
	end
end

function 角色处理类:取消任务(id)
	local 任务id = 0
	if self and self.任务 then
		for n, v in pairs(self.任务) do
			if v == id then
				任务id = n
			end
		end

		if 任务id ~= 0 then
			local rwid=self.任务[任务id]
			if 任务数据[rwid] then  --判断避免同一个队伍，不同玩家先取消了，这个任务就不存在了
				if 任务数据[rwid].销毁 then
					if 任务数据[rwid].地图编号 and 任务数据[rwid].单位编号 then
						地图处理类:删除单位(任务数据[rwid].地图编号,任务数据[rwid].单位编号)
					else
						f函数.写配置("./怪物销毁.ini","未被销毁怪物",""..任务数据[rwid].类型,1)
					end
					任务数据[rwid]=nil
				else
					f函数.写配置("./任务销毁.ini","未被销毁任务",""..任务数据[rwid].类型,1)
				end
			end
		end
		self.任务[任务id]=nil --无论如何都清空，0 也清空
		self:刷新任务跟踪()
	end
end

function 角色处理类:获取任务信息(连接id)
	local 任务信息 = {}

	for n, v in pairs(self.任务) do
		if 任务数据[v] ~= nil then
			任务信息[#任务信息 + 1] = 任务处理类:取任务说明(self.数字id, v)
		else
			self.任务[n] = nil
		end
	end
	发送数据(连接id, 40, 任务信息)
end

function 角色处理类:取任务(id)
	local 任务id = 0
	for n, v in pairs(self.任务) do
		if 任务数据[v] ~= nil and 任务数据[v].类型 == id then
			任务id = v
		end
	end
	return 任务id
end

function 角色处理类:添加任务(id)

	local 任务id = 0
	for n, v in pairs(self.任务) do
		if v == nil then
			任务id = n
		end
	end
	if 任务id ~= 0 then
		self.任务[任务id] = id
	else
		self.任务[#self.任务 + 1] = id
	end
	self:刷新任务跟踪()
end
function 角色处理类:更新任务()
	for n, v in pairs(self.任务) do
		if 任务数据[v] == nil then
			self.任务[n] = nil
		end
	end
end
function 角色处理类:刷新任务跟踪()
	local 任务发送 = {}
	for n, v in pairs(self.任务) do
		if v ~= nil and 任务数据[v] ~= nil then
			if 任务数据[v].类型 == 10 then
				if 任务数据[v].气血上限 == nil then
					任务数据[v].气血上限 = 0
				end
			end
			任务发送[#任务发送+1] = 任务处理类:取任务说明(self.数字id, v)
			任务发送[#任务发送][3] = 任务数据[v].起始
		end
	end
	table.sort(任务发送, function(a, b) return a[3] > b[3] end)
	发送数据(玩家数据[self.数字id].连接id, 46, {任务 = 任务发送})
end

function 角色处理类:取随机法宝()
	local 名称 = {"碧玉葫芦", "五色旗盒", "飞剑", "拭剑石", "金甲仙衣", "惊魂铃", "嗜血幡", "风袋", "清心咒", "九黎战鼓", "盘龙壁", "神行飞剑", "汇灵盏", "发瘟匣", "断线木偶", "五彩娃娃", "鬼泣", "月光宝盒", "混元伞", "无魂傀儡", "苍白纸人", "聚宝盆", "乾坤玄火塔", "无尘扇", "无字经", "降魔斗篷"}
	if self.门派 == "大唐官府" then
		名称 = {"七杀", "干将莫邪", "碧玉葫芦", "五色旗盒", "飞剑", "拭剑石", "金甲仙衣", "惊魂铃", "嗜血幡", "风袋", "清心咒", "九黎战鼓", "盘龙壁", "神行飞剑", "汇灵盏", "发瘟匣", "断线木偶", "五彩娃娃", "鬼泣", "月光宝盒", "混元伞", "无魂傀儡", "苍白纸人", "聚宝盆", "乾坤玄火塔", "无尘扇", "无字经", "降魔斗篷"}
	elseif self.门派 == "化生寺" then
		名称 = {"慈悲", "碧玉葫芦", "五色旗盒", "飞剑", "拭剑石", "金甲仙衣", "惊魂铃", "嗜血幡", "风袋", "清心咒", "九黎战鼓", "盘龙壁", "神行飞剑", "汇灵盏", "发瘟匣", "断线木偶", "五彩娃娃", "鬼泣", "月光宝盒", "混元伞", "无魂傀儡", "苍白纸人", "聚宝盆", "乾坤玄火塔", "无尘扇", "无字经", "降魔斗篷"}
	elseif self.门派 == "方寸山" then
		名称 = {"救命毫毛", "碧玉葫芦", "五色旗盒", "飞剑", "拭剑石", "金甲仙衣", "惊魂铃", "嗜血幡", "风袋", "清心咒", "九黎战鼓", "盘龙壁", "神行飞剑", "汇灵盏", "发瘟匣", "断线木偶", "五彩娃娃", "鬼泣", "月光宝盒", "混元伞", "无魂傀儡", "苍白纸人", "聚宝盆", "乾坤玄火塔", "无尘扇", "无字经", "降魔斗篷"}
	elseif self.门派 == "天宫" then
		名称 = {"伏魔天书", "碧玉葫芦", "五色旗盒", "飞剑", "拭剑石", "金甲仙衣", "惊魂铃", "嗜血幡", "风袋", "清心咒", "九黎战鼓", "盘龙壁", "神行飞剑", "汇灵盏", "发瘟匣", "断线木偶", "五彩娃娃", "鬼泣", "月光宝盒", "混元伞", "无魂傀儡", "苍白纸人", "聚宝盆", "乾坤玄火塔", "无尘扇", "无字经", "降魔斗篷"}
	elseif self.门派 == "普陀山" then
		名称 = {"金刚杵", "普渡", "碧玉葫芦", "五色旗盒", "飞剑", "拭剑石", "金甲仙衣", "惊魂铃", "嗜血幡", "风袋", "清心咒", "九黎战鼓", "盘龙壁", "神行飞剑", "汇灵盏", "发瘟匣", "断线木偶", "五彩娃娃", "鬼泣", "月光宝盒", "混元伞", "无魂傀儡", "苍白纸人", "聚宝盆", "乾坤玄火塔", "无尘扇", "无字经", "降魔斗篷"}
	elseif self.门派 == "龙宫" then
		名称 = {"镇海珠", "碧玉葫芦", "金甲仙衣", "惊魂铃", "风袋", "清心咒", "九黎战鼓", "盘龙壁", "神行飞剑", "汇灵盏", "发瘟匣", "断线木偶", "五彩娃娃", "鬼泣", "月光宝盒", "混元伞", "无魂傀儡", "苍白纸人", "聚宝盆", "乾坤玄火塔", "无尘扇", "无字经", "降魔斗篷"}
	elseif self.门派 == "五庄观" then
		名称 = {"奇门五行令", "碧玉葫芦", "五色旗盒", "飞剑", "拭剑石", "金甲仙衣", "惊魂铃", "嗜血幡", "风袋", "清心咒", "九黎战鼓", "盘龙壁", "神行飞剑", "汇灵盏", "发瘟匣", "断线木偶", "五彩娃娃", "鬼泣", "月光宝盒", "混元伞", "无魂傀儡", "苍白纸人", "聚宝盆", "乾坤玄火塔", "无尘扇", "无字经", "降魔斗篷"}
	elseif self.门派 == "狮驼岭" then
		名称 = {"兽王令", "失心钹", "碧玉葫芦", "五色旗盒", "飞剑", "拭剑石", "金甲仙衣", "惊魂铃", "嗜血幡", "风袋", "清心咒", "九黎战鼓", "盘龙壁", "神行飞剑", "汇灵盏", "发瘟匣", "断线木偶", "五彩娃娃", "鬼泣", "月光宝盒", "混元伞", "无魂傀儡", "苍白纸人", "聚宝盆", "乾坤玄火塔", "无尘扇", "无字经", "降魔斗篷"}
	elseif self.门派 == "魔王寨" then
		名称 = {"五火神焰印", "碧玉葫芦", "五色旗盒", "飞剑", "拭剑石", "金甲仙衣", "惊魂铃", "嗜血幡", "风袋", "清心咒", "九黎战鼓", "盘龙壁", "神行飞剑", "汇灵盏", "发瘟匣", "断线木偶", "五彩娃娃", "鬼泣", "月光宝盒", "混元伞", "无魂傀儡", "苍白纸人", "聚宝盆", "乾坤玄火塔", "无尘扇", "无字经", "降魔斗篷"}
	elseif self.门派 == "阴曹地府" then
		名称 = {"九幽", "碧玉葫芦", "五色旗盒", "飞剑", "拭剑石", "金甲仙衣", "惊魂铃", "嗜血幡", "风袋", "清心咒", "九黎战鼓", "盘龙壁", "神行飞剑", "汇灵盏", "发瘟匣", "断线木偶", "五彩娃娃", "鬼泣", "月光宝盒", "混元伞", "无魂傀儡", "苍白纸人", "聚宝盆", "乾坤玄火塔", "无尘扇", "无字经", "降魔斗篷"}
	end
	return 名称[取随机数(1, #名称)]
end

function 角色处理类:取观察数据()
	local 要求数据 = {
		名称 = self.名称
		, 等级 = self.等级
		, 模型 = self.模型
		, id = self.数字id
		, 染色组 = self.染色组
		, 炫彩 = self.炫彩
		, 炫彩组 = self.炫彩组
		, 染色方案 = self.染色方案
		, 锦衣 = {}
	}
	for k, v in pairs(self.锦衣) do
		if 玩家数据[self.数字id].道具.数据[self.锦衣[k]] ~= nil then
			要求数据.锦衣[k] = 玩家数据[self.数字id].道具.数据[self.锦衣[k]].名称
		end
	end
	return 要求数据
end



function 角色处理类:取地图数据()
	local 要求数据 = {
		x = self.地图数据.x
		, y = self.地图数据.y
		, 方向 = self.地图数据.方向
		, 名称 = self.名称
		, 模型 = self.模型
		, id = self.数字id
		, 武器 = nil
		, 染色 = nil
		, 称谓 = nil
		, 当前称谓 = self.当前称谓
		, 队长 = 玩家数据[self.数字id].队长
		, 染色组 = self.染色组
		, 炫彩 = self.炫彩
		, 炫彩组 = self.炫彩组
		, 染色方案 = self.染色方案
		, 变身数据 = self.变身数据
		, 战斗开关 = self.战斗开关
		, 坐骑 = self.坐骑
		, 锦衣 = {}
		, 玩家类型 = "玩家"
		, 历劫 = self.历劫
		, 飞行中=self.飞行中
		, 队伍= 玩家数据[self.数字id].队伍
		, 队标特效=self.队标特效
		, 系统设置=self.系统设置
	}
	 if 帮派PK.夺旗ID[self.数字id] then
			要求数据.帮派夺旗=帮派PK.夺旗ID[self.数字id].旗子颜色
	 end
	for k, v in pairs(self.锦衣) do
		if 玩家数据[self.数字id].道具.数据[self.锦衣[k]] ~= nil then
			要求数据.锦衣[k] = 玩家数据[self.数字id].道具.数据[self.锦衣[k]].名称
		end
	end
	if self.装备[3] ~= nil then
		要求数据.武器 = table.loadstring(table.tostring(玩家数据[self.数字id].道具.数据[self.装备[3]]))
		if 玩家数据[self.数字id].道具.数据[self.装备[3]].染色方案 and  玩家数据[self.数字id].道具.数据[self.装备[3]].染色组 then
			要求数据.武器染色方案=玩家数据[self.数字id].道具.数据[self.装备[3]].染色方案
			要求数据.武器染色组=玩家数据[self.数字id].道具.数据[self.装备[3]].染色组
		end
	end

	if 玩家数据[self.数字id].摊位数据 ~= nil then
		要求数据.摊位名称 = 玩家数据[self.数字id].摊位数据.名称
	end
	return 要求数据
end

function 角色处理类:取队伍信息()
	local 发送数据 = {
		模型 = self.模型,
		染色 = self.染色,
		等级 = self.等级,
		名称 = self.名称,
		门派 = self.门派,
		染色方案 = self.染色方案,
		染色组 = self.染色组,
		炫彩 = self.炫彩,
		炫彩组 = self.炫彩组,
		当前称谓 = self.当前称谓,
		id = self.数字id,
		变身数据 = self.变身数据,
		锦衣 ={}
	}
	if self.锦衣 then
		 for k, v in pairs(self.锦衣) do
			if 玩家数据[self.数字id].道具.数据[self.锦衣[k]] ~= nil then
				发送数据.锦衣[k] = 玩家数据[self.数字id].道具.数据[self.锦衣[k]].名称
			end
		end
	end
	if self.装备[3] then
		发送数据.装备 = table.copy((玩家数据[self.数字id].道具.数据[self.装备[3]]))
	end
	if self.坐骑 and self.坐骑.模型 then
		发送数据.坐骑 = {
		模型 = self.坐骑.模型,
		饰品 = self.坐骑.饰品,
		饰品2 = self.坐骑.饰品2,
		炫彩 = self.坐骑.炫彩,
		炫彩组 = self.坐骑.炫彩组
	}
	end
	return 发送数据
end

function 角色处理类:取强化技能等级(mc)
	for k,v in pairs(self.强化技能) do
		if v.名称 == mc and v.学会 then
			return v.等级
		end
	end
	return 0
end

function 角色处理类:检查强化技能()
	if #self.强化技能 <= 0 then
		local fz = self:取强化技能()
		for i = 1, #fz do
			local 强化技能 = jnzbzz()
			强化技能:置对象(fz[i])
			强化技能.等级 = 0
			insert(self.强化技能, 强化技能)
		end
	end
end

function 角色处理类:取总数据()
	local fhsj = {}
	self:检查强化技能()
	for n, v in pairs(self) do
		if type(n) ~= "function" and n ~= "运行父函数" and n ~= "存档数据" and n ~= "日志内容" and n ~= "五宝数据" and n ~= "在线时间" and n ~= "技能属性" then
			if type(n) == "table" then
				fhsj[n] = table.copy((v))
			else
				fhsj[n] = v
			end
		end
	end
	fhsj.装备 = self:取装备数据()
	fhsj.灵饰 = self:取灵饰数据()
	fhsj.锦衣 = self:取锦衣数据()
	return fhsj
end

function 角色处理类:取总数据1()
	local fhsj = {}
	self:检查强化技能()
	for n, v in pairs(self) do
		if type(n) ~= "function" and type(n) ~= "运行父函数" and n ~= "存档数据" and n ~= "装备"and n ~= "锦衣"and n ~= "灵饰" and n ~= "日志内容" and n ~= "宝宝列表" and n ~= "子女列表" and n ~= "好友数据" and n ~= "坐骑列表" and n ~= "五宝数据" and n ~= "在线时间" and n ~= "技能属性" then
			if type(n) == "table" then
				fhsj[n] = table.copy((v))
			else
				fhsj[n] = v
			end
		end
	end
	return fhsj
end

function 角色处理类:发送总数据()
	local fhsj = {}
	for n, v in pairs(self) do
		if type(n) ~= "function" and type(n) ~= "运行父函数" and n ~= "存档数据" and n ~= "装备"and n ~= "锦衣"and n ~= "灵饰" and n ~= "日志内容" and n ~= "宝宝列表" and n ~= "子女列表" and n ~= "好友数据" and n ~= "坐骑列表" and n ~= "五宝数据" and n ~= "在线时间" and n ~= "技能属性" then
			if type(n) == "table" then
				fhsj[n] = table.copy((v))
			else
				fhsj[n] = v
			end
		end
	end
	发送数据(玩家数据[self.数字id].连接id,31,fhsj)
end

function 角色处理类:取战斗属性()
	local fhsj = {}
	for n, v in pairs(self) do

		if type(n) ~= "function" and not 战斗无需加载[n] then
			if type(n) == "table" then
				fhsj[n] = table.copy((v))
			else
				fhsj[n] = v
			end
		end
	end

	fhsj.装备 = self:取装备数据()
	fhsj.灵饰 = self:取灵饰数据()
	fhsj.锦衣 = self:取锦衣数据()
	return fhsj
end

function 角色处理类:加载数据(账号, id)
	self.临时数据 = table.loadstring(读入文件(程序目录..[[data/]]..账号..[[/]]..id..[[/角色.txt]]))
	self.临时数据.地图数据.方向 = self.临时数据.地图数据.方向 or 0
	self.数字id = id
	for n, v in pairs(self.临时数据) do
		if type(n) ~= "function" and type(n) ~= "运行父函数" and n ~= "存档数据" and n ~= "日志内容" then
			if type(n) == "table" then ----------
				self[n] = table.copy((v))
			else
				self[n] = v
			end
		end
	end

	self:清空临时包裹()
	self.临时数据 = nil
	if f函数.文件是否存在(程序目录..[[data/]]..账号..[[/]]..id..[[/日志记录/]]..self.日志编号..".txt")==false then
		self.日志内容="日志创建\n"
		写出文件([[data/]]..self.账号..[[/]]..self.数字id.."/日志记录/"..self.日志编号..".txt","日志创建\n")
	end
	 self.日志内容=读入文件(程序目录..[[data/]]..账号..[[/]]..id..[[/日志记录/]]..self.日志编号..".txt").."\n"

end

function 角色处理类:检测交易是否正常(id)
	if not self or not self.数字id then
		常规提示(id, "数据异常，请稍后重试")
		return true
	end
	return false
end

function 角色处理类:存档(ip)
	self.临时信息 = nil
	self.临时数据 = nil
	self.角色数量 = nil
	self.写入信息 = nil
	if not self or not self.数字id then
		print("玩家存档时，未提取到角色数据")
		 return
	end
	if self.日志内容 == nil then
		self.日志内容="日志创建\n"
	end
	if not self.日志编号 then
		 self.日志编号=1
	end
	写出文件([[data/]]..self.账号..[[/]]..self.数字id.."/日志记录/"..self.日志编号..".txt",self.日志内容)

	if self.日志内容 ~= nil then
		if string.len(self.日志内容)>=10240 then
			self.日志内容="日志创建\n"
			self.日志编号=self.日志编号+1
			写出文件([[data/]]..self.账号..[[/]]..self.数字id.."/日志记录/"..self.日志编号..".txt","日志创建\n")
		end
	end
	 local fhsj = {}
	for n, v in pairs(self) do
		if type(n) ~= "function" and type(n) ~= "运行父函数" and n ~= "存档数据" and n ~= "日志内容" then
			if type(n) == "table" then
				fhsj[n] = table.copy((v))
			else
				fhsj[n] = v
			end
		end
	end

	写出文件([[data/]]..self.账号..[[/]]..self.数字id.."/角色.txt", table.tostring(fhsj))
	if 玩家数据[self.数字id]==nil then
		写出文件([[data/]]..self.账号..[[/]]..self.数字id.."/道具.txt",table.tostring({}))
		写出文件([[data/]]..self.账号..[[/]]..self.数字id.."/召唤兽.txt",table.tostring({}))
		写出文件([[data/]]..self.账号..[[/]]..self.数字id.."/道具仓库.txt",table.tostring({[1]={},[2]={},[3]={}}))
		写出文件([[data/]]..self.账号..[[/]]..self.数字id.."/宝宝仓库.txt",table.tostring({[1]={}}))
		写出文件([[data/]]..self.账号..[[/]]..self.数字id.."/神器.txt",table.tostring({}))
	else
		写出文件([[data/]]..self.账号..[[/]]..self.数字id.."/道具.txt",table.tostring(玩家数据[self.数字id].道具.数据))
		 写出文件([[data/]]..self.账号..[[/]]..self.数字id.."/召唤兽.txt",table.tostring(玩家数据[self.数字id].召唤兽:取存档数据()))
		 写出文件([[data/]]..self.账号..[[/]]..self.数字id.."/道具仓库.txt",table.tostring(道具仓库数据[self.数字id].道具.数据))
		 写出文件([[data/]]..self.账号..[[/]]..self.数字id.."/宝宝仓库.txt",table.tostring(宝宝仓库数据[self.数字id].召唤兽.数据))
		 写出文件([[data/]]..self.账号..[[/]]..self.数字id.."/神器.txt",table.tostring(玩家数据[self.数字id].神器.数据))
	end
	-- print(self.账号,self.数字id,os.date("%c",os.time()),"=================4544")
	-- table.print(fhsj.道具)
	fhsj=nil
end

function 角色处理类:加入门派(id, 门派)
	-- if 可入门派[self.种族][门派] == nil and 可入门派[self.种族][self.性别][门派] == nil then
	-- 	常规提示(id, "本门派不收你这样的弟子")
	-- 	return
	-- elseif self.门派 ~= "无门派"then
	-- 	常规提示(id, "#Y你已经投入其它门派")
	-- 	return
	-- end
	if self.等级<10 then
		常规提示(id,"谁家好人还没10级就来拜师！")
		return
	end
	if self.模型 ~= '影精灵' then
	    if 可入门派[self.种族][门派] == nil and 可入门派[self.种族][self.性别][门派] == nil then
			常规提示(id, "本门派不收你这样的弟子")
			return
		end
	else
		if 门派 ~= '九黎城' then
		    常规提示(id, "影精灵只可以加入九黎城")
			return
		end
	end
	if self.门派 ~= "无门派"then
		常规提示(id, "#Y你已经投入其它门派")
		return
	end
	self.门派 = 门派
	常规提示(id, "你成为了#R/"..门派.."#Y/弟子")
	self.奇经八脉 = 取经脉流派(self.门派)
	self.师门技能 = {}
	if self.门派 ~= "无门派" and self.师门技能[1] == nil then
		local 列表 = self:取门派技能(self.门派)
		for n = 1, #列表 do
			self.师门技能[n] = jnzbzz()
			self.师门技能[n]:置对象(列表[n])
			self.师门技能[n].包含技能 = {}
			self.师门技能[n].等级 = 79
			if 玩家数据[id].角色.武神坛角色 then self.师门技能[n].等级 = 180 end
			local w = self:取包含技能(self.师门技能[n].名称,self.奇经八脉["当前流派"])
			for s = 1, #w do
				self.师门技能[n].包含技能[s] = jnzbzz()
				self.师门技能[n].包含技能[s]:置对象(w[s])
				self.师门技能[n].包含技能[s].等级 = 79
				if 玩家数据[id].角色.武神坛角色 then self.师门技能[n].包含技能[s].等级 = 180 end
			end
			self:升级技能(self.师门技能[n],self.奇经八脉["当前流派"])
		end
	end
	if self.师门技能[1] ~= nil then
		if 是否 == "2" then
			for n = 1, 7 do
				for l = 1, #self.师门技能[n].包含技能 do
					if self:有无技能(self.师门技能[n].包含技能[l].名称) then
						self.师门技能[n].包含技能[l].学会 = true
					end
				end
			end
		end
	end

	self.招式特效 = 取门派招式特效(self.门派)
	if self.等级==10 then
		 礼包奖励类:设置拜师奖励(id)
	end
	if 玩家数据[id].角色.武神坛角色 then --武神坛
		玩家数据[id].神器:添加神器(id)
	end
end

function 角色处理类:佩戴灵饰(道具)
	for n = 1, #灵饰正常属性 do
		if 道具.幻化属性.基础.类型 == 灵饰正常属性[n] then
			self.装备属性[灵饰正常属性[n]] = self.装备属性[灵饰正常属性[n]] + 道具.幻化属性.基础.数值
		end
		for i = 1, #道具.幻化属性.附加 do
			if 道具.幻化属性.附加[i].类型 == 灵饰正常属性[n] then
				self.装备属性[灵饰正常属性[n]] = self.装备属性[灵饰正常属性[n]] + 道具.幻化属性.附加[i].数值 + 道具.幻化属性.附加[i].强化
			end
		end
	end
	for n = 1, #灵饰战斗属性 do
		if 道具.幻化属性.基础.类型 == 灵饰战斗属性[n] then
			if self.装备属性[灵饰战斗属性[n]]==nil then
				self.装备属性[灵饰战斗属性[n]]=0
			end
			self.装备属性[灵饰战斗属性[n]]=self.装备属性[灵饰战斗属性[n]] + 道具.幻化属性.基础.数值
		end
		for i = 1, #道具.幻化属性.附加 do
			if 道具.幻化属性.附加[i].类型 == 灵饰战斗属性[n] then
				if self.装备属性[灵饰战斗属性[n]]==nil then
					self.装备属性[灵饰战斗属性[n]]=0
				end
				self.装备属性[灵饰战斗属性[n]]=self.装备属性[灵饰战斗属性[n]]+ 道具.幻化属性.附加[i].数值 + 道具.幻化属性.附加[i].强化
			end
		end
	end
	if 道具.特性 then
          local TempStatus = PropertyData[道具.特性.技能]
          local TempStatus1 = TempStatus[道具.部位类型]
          if TempStatus.类型 == "五行" or TempStatus.类型 == "属性" or TempStatus.类型 == "宿敌" then
          	self.装备属性[TempStatus1.pro]=self.装备属性[TempStatus1.pro] + 道具.特性.等级 * TempStatus1.rate
          elseif TempStatus.类型 == "趣味" then
          end
    end
    灵饰特性数据=self:取灵饰数据()
      if 灵饰特性数据[1] and 灵饰特性数据[2] and 灵饰特性数据[3] and 灵饰特性数据[4] then
    	if 灵饰特性数据[1].特性 and 灵饰特性数据[2].特性 and 灵饰特性数据[3].特性 and 灵饰特性数据[4].特性 then
    		if 灵饰特性数据[1].特性.技能 == 灵饰特性数据[2].特性.技能 and 灵饰特性数据[2].特性.技能 == 灵饰特性数据[3].特性.技能 and 灵饰特性数据[3].特性.技能 == 灵饰特性数据[4].特性.技能 then
    			for b=1,#self.灵饰 do
    				玩家数据[self.数字id].道具.数据[self.灵饰[b]].特性.套装=1
    			end
			      if PropertyData[灵饰特性数据[1].特性.技能].类型 == "属性" then
			        self.装备属性[PropertyData[灵饰特性数据[1].特性.技能].套装.pro1] = self.装备属性[PropertyData[灵饰特性数据[1].特性.技能].套装.pro1] + PropertyData[灵饰特性数据[1].特性.技能]["套装" .. 1]
			      end
    		end
    	end
      end
	self:刷新信息("6")
end

function 角色处理类:卸下灵饰(道具)
	if 道具.刷新属性 then
		道具.刷新属性 = nil
		return
	end
	for n = 1, #灵饰正常属性 do
		if 道具.幻化属性.基础.类型 == 灵饰正常属性[n] then
			self.装备属性[灵饰正常属性[n]] = self.装备属性[灵饰正常属性[n]] - 道具.幻化属性.基础.数值
		end
		for i = 1, #道具.幻化属性.附加 do
			if 道具.幻化属性.附加[i].类型 == 灵饰正常属性[n] then
				self.装备属性[灵饰正常属性[n]] = self.装备属性[灵饰正常属性[n]] - 道具.幻化属性.附加[i].数值 - 道具.幻化属性.附加[i].强化
			end
		end
	end
	for n = 1, #灵饰战斗属性 do
		if 道具.幻化属性.基础.类型 == 灵饰战斗属性[n] then
			if self.装备属性[灵饰战斗属性[n]]==nil then
				self.装备属性[灵饰战斗属性[n]]=0
			end
			self.装备属性[灵饰战斗属性[n]]=self.装备属性[灵饰战斗属性[n]] - 道具.幻化属性.基础.数值
		end
		for i = 1, #道具.幻化属性.附加 do
			if 道具.幻化属性.附加[i].类型 == 灵饰战斗属性[n] then
				if self.装备属性[灵饰战斗属性[n]]==nil then
					self.装备属性[灵饰战斗属性[n]]=0
				end
				self.装备属性[灵饰战斗属性[n]]=self.装备属性[灵饰战斗属性[n]] - 道具.幻化属性.附加[i].数值 - 道具.幻化属性.附加[i].强化
			end
		end
	end
	if 道具.特性 then
          local TempStatus = PropertyData[道具.特性.技能]
          local TempStatus1 = TempStatus[道具.部位类型]
          if TempStatus.类型 == "五行" or TempStatus.类型 == "属性" or TempStatus.类型 == "宿敌" then
          	self.装备属性[TempStatus1.pro]=self.装备属性[TempStatus1.pro] - 道具.特性.等级 * TempStatus1.rate
          elseif TempStatus.类型 == "趣味" then
          end
          	if 道具.特性.套装 then
    			for b=1,#self.灵饰 do
    				if 玩家数据[self.数字id].道具.数据[self.灵饰[b]] then
    				玩家数据[self.数字id].道具.数据[self.灵饰[b]].特性.套装=nil
    				end
    			end
			      if PropertyData[道具.特性.技能].类型 == "属性" then
			        self.装备属性[PropertyData[道具.特性.技能].套装.pro1] = self.装备属性[PropertyData[道具.特性.技能].套装.pro1] - PropertyData[道具.特性.技能]["套装" .. 1]
			      end
    		end
    end
	self:刷新信息("6")
end

function 角色处理类:清除灵饰属性(道具)
	if 道具.刷新属性 == nil then
		道具.刷新属性 = true
	else
		return
	end
	for n = 1, #灵饰正常属性 do
		if 道具.幻化属性.基础.类型 == 灵饰正常属性[n] then
			self.装备属性[灵饰正常属性[n]] = self.装备属性[灵饰正常属性[n]] - 道具.幻化属性.基础.数值
		end
		for i = 1, #道具.幻化属性.附加 do
			if 道具.幻化属性.附加[i].类型 == 灵饰正常属性[n] then
				self.装备属性[灵饰正常属性[n]] = self.装备属性[灵饰正常属性[n]] - 道具.幻化属性.附加[i].数值 - 道具.幻化属性.附加[i].强化
			end
		end
	end
	for n = 1, #灵饰战斗属性 do
		if 道具.幻化属性.基础.类型 == 灵饰战斗属性[n] then
			self[灵饰战斗属性[n]] = self[灵饰战斗属性[n]] - 道具.幻化属性.基础.数值
		end
		for i = 1, #道具.幻化属性.附加 do
			if 道具.幻化属性.附加[i].类型 == 灵饰战斗属性[n] then
				self[灵饰战斗属性[n]] = self[灵饰战斗属性[n]] - 道具.幻化属性.附加[i].数值 - 道具.幻化属性.附加[i].强化
			end
		end
	end
	self:刷新信息("6")
end
-- function 角色处理类:清除装备附魔属性22(装备,格子,名称,数值)
-- 	if 名称=="法术伤害" or 名称=="法术防御" or 名称=="伤害" or 名称=="法伤结果" or 名称=="气血回复效果" or 名称=="物伤结果" then
-- 		 self[名称] = self[名称] - 数值
-- 		 if self[名称]<=0 then
-- 			self[名称]=0
-- 		 end
-- 	end
-- 	self:刷新信息("0")
-- end
function 角色处理类:清除装备附魔属性(装备,格子,名称,数值)
	local go = false
	for n = 1, #灵饰战斗属性 do
		if self.装备属性[灵饰战斗属性[n]]==名称 then
			self.装备属性[灵饰战斗属性[n]]= self.装备属性[灵饰战斗属性[n]] - 数值
			go=true
			if self.装备属性[灵饰战斗属性[n]]<0 then
				self.装备属性[灵饰战斗属性[n]]=0
			end
			break
		end
	end
	if not go then
		self.装备属性[名称] = self.装备属性[名称] - 数值
		if not self.装备属性[名称] or self.装备属性[名称]<0 then
			self.装备属性[名称]=0
		end
	end
	self:刷新信息("0")
end

function 角色处理类:取符石属性(装备)
	local fssx = {伤害=0,灵力=0,防御=0,气血=0,魔法=0,命中=0,躲避=0,速度=0,愤怒=0,体质=0,力量=0,耐力=0,魔力=0,敏捷=0,物伤结果=0,法伤结果=0,固定伤害=0,气血回复效果=0,法术伤害结果=0,法术防御=0,法术伤害=0}
	if 装备.星位~=nil then

		for n=1,6 do
			if 装备.星位[n]~=nil and 装备.星位[n].符石属性 then
				for k,v in pairs(装备.星位[n].符石属性) do
					fssx[k] = fssx[k] + v
				end
			end
			if n==6 and 装备.星位[n]~=nil and 装备.星位[n].相互~=nil then
				for k,v in pairs(装备.星位[n].相互) do
					fssx[k] = fssx[k] + v
				end
			end
		end
	end
	return fssx
end

function 角色处理类:取宝石属性(装备)
	local zb = {伤害=0,灵力=0,防御=0,气血=0,魔法=0,命中=0,躲避=0,速度=0,愤怒=0,体质=0,力量=0,耐力=0,魔力=0,敏捷=0,物伤结果=0,固定伤害=0,法伤结果=0,气血回复效果=0,法术伤害结果=0,法术防御=0,法术伤害=0}
	if 装备.宝石属性 ~= nil then
		for n = 1, # JSzbsx do
			if 装备.宝石属性[JSzbsx[n]] ~= nil then
				zb[JSzbsx[n]] = zb[JSzbsx[n]] + 装备.宝石属性[JSzbsx[n]]
			end
		end
	end
	return zb
end

function 角色处理类:取熔炼属性(装备)
	local zb = {伤害=0,灵力=0,防御=0,气血=0,魔法=0,命中=0,躲避=0,速度=0,愤怒=0,体质=0,力量=0,耐力=0,魔力=0,敏捷=0,物伤结果=0,固定伤害=0,法伤结果=0,气血回复效果=0,法术伤害结果=0,法术防御=0,法术伤害=0}
	for n = 1, # JSzbsx do
		if 装备.熔炼效果[JSzbsx[n]] ~= nil then
			zb[JSzbsx[n]] = zb[JSzbsx[n]] + 装备.熔炼效果[JSzbsx[n]]
		end
	end
	return zb
end

function 角色处理类:取附魔属性(装备)
	local zb = {伤害=0,灵力=0,防御=0,气血=0,魔法=0,命中=0,躲避=0,速度=0,愤怒=0,体质=0,力量=0,耐力=0,魔力=0,敏捷=0,物伤结果=0,固定伤害=0,法伤结果=0,气血回复效果=0,法术伤害结果=0,法术防御=0,法术伤害=0}
	if 装备.临时附魔 ~= nil then
		for n = 1, # JSzbsx do
			if 装备.临时附魔[JSzbsx[n]] ~= nil then
				zb[JSzbsx[n]] = zb[JSzbsx[n]] + 装备.临时附魔[JSzbsx[n]].数值
			end
		end
	end
	return zb
end

function 角色处理类:取上古灵符属性(装备)
	local zb = {伤害=0,灵力=0,防御=0,气血=0,魔法=0,命中=0,躲避=0,速度=0,愤怒=0,法术暴击等级=0,物理暴击等级=0,治疗能力=0,封印命中等级=0,体质=0,力量=0,耐力=0,魔力=0,敏捷=0,物伤结果=0,固定伤害=0,法伤结果=0,气血回复效果=0,法术伤害结果=0,法术防御=0,法术伤害=0}
	if 装备.上古残符 ~= nil then
		local 额外数值=0
		if 装备.五行==装备.上古残符.五行 then
			额外数值=math.floor(装备.上古残符.数值*0.5)
		end
		if 装备.分类==1 then
		zb.法术防御=zb.法术防御+装备.上古残符.数值+额外数值
		elseif 装备.分类==2 then
		zb.灵力=zb.灵力+装备.上古残符.数值+额外数值
		elseif 装备.分类==3 or   装备.分类==30 then
		zb.伤害=zb.伤害+装备.上古残符.数值+额外数值
		elseif 装备.分类==4 then
		zb.防御=zb.防御+装备.上古残符.数值+额外数值
		elseif 装备.分类==5 then
		zb.气血=zb.气血+装备.上古残符.数值+额外数值
		elseif 装备.分类==6 then
		zb.速度=zb.速度+装备.上古残符.数值+额外数值
		end
	end
	return zb
end




-- 灵饰战斗属性={"气血回复效果","","","法术防御","","","","固定伤害","法术伤害","","","","","","法术伤害结果","","物伤结果","法伤结果","治疗能力"}
function 角色处理类:穿戴装备(装备, 格子)
	local 双斧临时伤害,双斧临时命中=装备.伤害,装备.命中
	if (装备.总类==2 and 装备.分类==3 and 装备.子类==910) or (装备.总类==2 and 装备.分类==4 and 装备.子类==911)then
		if 装备.伤害 then
			双斧临时伤害=math.floor(装备.伤害*0.6)
		end
 		if 装备.命中 then
 			双斧临时命中=math.floor(装备.命中*0.6)
 		end
	end
	local zb = {伤害=0,灵力=0,防御=0,气血=0,魔法=0,命中=0,躲避=0,速度=0,愤怒=0,体质=0,力量=0,耐力=0,魔力=0,敏捷=0,物伤结果=0,固定伤害=0,法伤结果=0,气血回复效果=0,法术伤害结果=0,法术防御=0,法术伤害=0}
	local fs = self:取符石属性(装备)
	local rl = self:取熔炼属性(装备)
	local bs = self:取宝石属性(装备)
	local ls = self:取附魔属性(装备)
	local sglf = self:取上古灵符属性(装备)


	for k,v in pairs(装备.临时效果 or {}) do
	      if v.时间>=os.time() then
	         if  zb[v.类型] then
                          zb[v.类型]=zb[v.类型]+v.数值
                      else
                      	 self[v.类型]=self[v.类型]+v.数值
                      end
	      end
	end

	for i=1,#JSzbsx do
		zb[JSzbsx[i]] = zb[JSzbsx[i]] + (fs[JSzbsx[i]] or 0)+ (sglf[JSzbsx[i]] or 0) + (rl[JSzbsx[i]] or 0) + (bs[JSzbsx[i]] or 0) + (ls[JSzbsx[i]] or 0)
	end
	--直接属性
	self.装备属性.气血 = self.装备属性.气血 + (装备.气血 or 0) + (zb.气血 or 0)
	self.装备属性.魔法 = self.装备属性.魔法 + (装备.魔法 or 0)  + (zb.魔法 or 0)
	if (装备.总类==2 and 装备.分类==3 and 装备.子类==910) or (装备.总类==2 and 装备.分类==4 and 装备.子类==911)then
		self.装备属性.命中 = self.装备属性.命中 + (双斧临时命中 or 0)  + (zb.命中 or 0)
		self.装备属性.伤害 = self.装备属性.伤害 + (双斧临时伤害 or 0)  + (zb.伤害 or 0)
	else
		self.装备属性.命中 = self.装备属性.命中 + (装备.命中 or 0)  + (zb.命中 or 0)
		self.装备属性.伤害 = self.装备属性.伤害 + (装备.伤害 or 0)  + (zb.伤害 or 0)
	end
	self.装备属性.防御 = self.装备属性.防御 + (装备.防御 or 0)  + (zb.防御 or 0)
	self.装备属性.速度 = self.装备属性.速度 + (装备.速度 or 0) + (zb.速度 or 0)
	self.装备属性.躲避 = self.装备属性.躲避 + (装备.躲避 or 0) + (zb.躲避 or 0)
	self.装备属性.灵力 = self.装备属性.灵力 + (装备.灵力 or 0)  + (zb.灵力 or 0)
	self.装备属性.体质 = self.装备属性.体质 + (装备.体质 or 0)  + (zb.体质 or 0)
	self.装备属性.魔力 = self.装备属性.魔力 + (装备.魔力 or 0)  + (zb.魔力 or 0)
	self.装备属性.力量 = self.装备属性.力量 + (装备.力量 or 0) + (zb.力量 or 0)
	self.装备属性.耐力 = self.装备属性.耐力 + (装备.耐力 or 0) + (zb.耐力 or 0)
	self.装备属性.敏捷 = self.装备属性.敏捷 + (装备.敏捷 or 0)  + (zb.敏捷 or 0)
	self.装备属性.法术伤害 = self.装备属性.法术伤害 + (zb.法术伤害 or 0)
	self.装备属性.法术防御 = self.装备属性.法术防御 + (zb.法术防御 or 0)
	self.装备属性.固定伤害 = self.装备属性.固定伤害 + (zb.固定伤害 or 0)
	self.装备属性.法术伤害结果 = self.装备属性.法术伤害结果 + (zb.法术伤害结果 or 0) + (zb.法伤结果 or 0)
	self.装备属性.气血回复效果 = self.装备属性.气血回复效果 + (zb.气血回复效果 or 0)
	self.装备属性.物伤结果 = self.装备属性.物伤结果 + (zb.物伤结果 or 0)
	self.装备属性.法伤结果 = self.装备属性.法伤结果 + (zb.法伤结果 or 0)

	if 格子 < 7 then
		if 装备.特技 ~= nil then
			self.特殊技能[格子] = jnzbzz()
			self.特殊技能[格子]:置对象(装备.特技)
		end
		if 格子==3 then
			self.武器伤害=装备.伤害
		end
	else
		self.灵饰[格子 - 9] = 装备
	end
	if self.元素曜石==nil then
	self.元素曜石={防御=0,速度=0,伤害=0,固定伤害=0,法伤=0,封印命中等级=0}
	end

	if 装备.器灵 then
	 	if 装备.器灵=="金蝉" then
		self.器灵效果.金蝉=self.器灵效果.金蝉+1
		常规提示(self.数字id, "#G金蝉器灵效果附加，当前已触发金蝉效果：#R/"..self.器灵效果.金蝉.."件")
		elseif 装备.器灵=="无双" then
		self.器灵效果.无双=self.器灵效果.无双+1
		常规提示(self.数字id, "#G无双器灵效果附加，当前已触发无双效果：#R/"..self.器灵效果.无双.."件")
		end
	end
	if 装备.五行镶嵌 then
	  if 装备.五行镶嵌[1] then
		self.元素曜石[装备.五行镶嵌[1].属性]=self.元素曜石[装备.五行镶嵌[1].属性]+装备.五行镶嵌[1].数值/50/100
		end
		if 装备.五行镶嵌[2] then
   	self.元素曜石[装备.五行镶嵌[2].属性]=self.元素曜石[装备.五行镶嵌[2].属性]+装备.五行镶嵌[2].数值/50/100
		end
	end

	self:刷新信息("2",nil,nil,true)
end

function 角色处理类:卸下装备(装备, 格子, 刷新)
	local 双斧临时伤害,双斧临时命中=装备.伤害,装备.命中
	if (装备.总类==2 and 装备.分类==3 and 装备.子类==910) or (装备.总类==2 and 装备.分类==4 and 装备.子类==911)then
		if 装备.伤害 then
			双斧临时伤害=math.floor(装备.伤害*0.6)
		end
 		if 装备.命中 then
 			双斧临时命中=math.floor(装备.命中*0.6)
 		end
	end
	if 装备.刷新属性 then
		装备.刷新属性 = nil
		return
	end
	local zb = {伤害=0,灵力=0,防御=0,气血=0,魔法=0,命中=0,躲避=0,速度=0,愤怒=0,体质=0,力量=0,耐力=0,魔力=0,敏捷=0,物伤结果=0,固定伤害=0,法伤结果=0,气血回复效果=0,法术伤害结果=0,法术防御=0,法术伤害=0}
	local fs = self:取符石属性(装备)
	local rl = self:取熔炼属性(装备)
	local bs = self:取宝石属性(装备)
	local ls = self:取附魔属性(装备)
	local sglf = self:取上古灵符属性(装备)

	for k,v in pairs(装备.临时效果 or {}) do
	         if  zb[v.类型] then
                          zb[v.类型]=zb[v.类型]+v.数值
                      else
                      	 self[v.类型]=self[v.类型]-v.数值
                      end
	end

	for i=1,#JSzbsx do
		zb[JSzbsx[i]] = zb[JSzbsx[i]] + (fs[JSzbsx[i]] or 0) + (sglf[JSzbsx[i]] or 0) + (rl[JSzbsx[i]] or 0) + (bs[JSzbsx[i]] or 0) + (ls[JSzbsx[i]] or 0)
	end
	--直接属性
	self.装备属性.气血 = self.装备属性.气血 - (装备.气血 or 0) - (zb.气血 or 0)
	self.装备属性.魔法 = self.装备属性.魔法 - (装备.魔法 or 0) - (zb.魔法 or 0)
	if (装备.总类==2 and 装备.分类==3 and 装备.子类==910) or (装备.总类==2 and 装备.分类==4 and 装备.子类==911)then
		self.装备属性.命中 = self.装备属性.命中 - (双斧临时命中 or 0) - (zb.命中 or 0)
		self.装备属性.伤害 = self.装备属性.伤害 - (双斧临时伤害 or 0) - (zb.伤害 or 0)
	else
		self.装备属性.命中 = self.装备属性.命中 - (装备.命中 or 0) - (zb.命中 or 0)
		self.装备属性.伤害 = self.装备属性.伤害 - (装备.伤害 or 0) - (zb.伤害 or 0)
	end
	self.装备属性.防御 = self.装备属性.防御 - (装备.防御 or 0) - (zb.防御 or 0)
	self.装备属性.速度 = self.装备属性.速度 - (装备.速度 or 0) - (zb.速度 or 0)
	self.装备属性.躲避 = self.装备属性.躲避 - (装备.躲避 or 0) - (zb.躲避 or 0)
	self.装备属性.灵力 = self.装备属性.灵力 - (装备.灵力 or 0) - (zb.灵力 or 0)
	self.装备属性.体质 = self.装备属性.体质 - (装备.体质 or 0)-  (zb.体质 or 0)
	self.装备属性.魔力 = self.装备属性.魔力  -(装备.魔力 or 0)-  (zb.魔力 or 0)
	self.装备属性.力量 = self.装备属性.力量  -(装备.力量 or 0) - (zb.力量 or 0)
	self.装备属性.耐力 = self.装备属性.耐力  -(装备.耐力 or 0)-  (zb.耐力 or 0)
	self.装备属性.敏捷 = self.装备属性.敏捷 - (装备.敏捷 or 0)-  (zb.敏捷 or 0)
	self.装备属性.法术伤害 = self.装备属性.法术伤害 - (zb.法术伤害 or 0)
	self.装备属性.法术防御 = self.装备属性.法术防御 - (zb.法术防御 or 0)
	self.装备属性.固定伤害 = self.装备属性.固定伤害 - (zb.固定伤害 or 0)
	self.装备属性.法术伤害结果 = self.装备属性.法术伤害结果 - (zb.法术伤害结果 or 0) - (zb.法伤结果 or 0)
	self.装备属性.气血回复效果 = self.装备属性.气血回复效果 - (zb.气血回复效果 or 0)
	self.装备属性.物伤结果 = self.装备属性.物伤结果 - (zb.物伤结果 or 0)
	self.装备属性.法伤结果 = self.装备属性.法伤结果 - (zb.法伤结果 or 0)
	if 格子 < 7 then
		if 装备.特技 ~= nil then
			self.特殊技能[格子] = nil
		end
		if 格子==3 then
			self.武器伤害=0
		end
	else
		self.灵饰[格子-9] = nil
		end
	 if self.元素曜石==nil then
	self.元素曜石={防御=0,速度=0,伤害=0,固定伤害=0,法伤=0,封印命中等级=0}
	end
		if 装备.器灵 then
	 	if 装备.器灵=="金蝉" then
		self.器灵效果.金蝉=self.器灵效果.金蝉-1
		常规提示(self.数字id, "#G金蝉器灵效果附加，当前已触发金蝉效果：#R/"..self.器灵效果.金蝉.."件")
		elseif 装备.器灵=="无双" then
		self.器灵效果.无双=self.器灵效果.无双-1
		常规提示(self.数字id, "#G无双器灵效果附加，当前已触发无双效果：#R/"..self.器灵效果.无双.."件")
		end
	end
	if 装备.五行镶嵌 then
	  if 装备.五行镶嵌[1] then
		self.元素曜石[装备.五行镶嵌[1].属性]=self.元素曜石[装备.五行镶嵌[1].属性]-装备.五行镶嵌[1].数值/50/100
		end
		if 装备.五行镶嵌[2] then
   	self.元素曜石[装备.五行镶嵌[2].属性]=self.元素曜石[装备.五行镶嵌[2].属性]-装备.五行镶嵌[2].数值/50/100
		end
	end

end


function 角色处理类:属性转换检测()
	 for n, v in pairs(self.装备) do
		if self.装备[n] ~= nil then
			常规提示(self.数字id, "#Y请先卸下人物装备")
			return false
		end
	end
	for n, v in pairs(self.灵饰) do
		if self.灵饰[n] ~= nil then
			常规提示(self.数字id, "#Y请先卸下灵饰")
			return false
		end
	end
	for n, v in pairs(self.法宝佩戴) do
		if self.法宝[n] ~= nil then
			常规提示(self.数字id, "#Y请先卸下法宝")
			return false
		end
	end
	for n, v in pairs(self.灵宝佩戴) do
		if self.灵宝[n] ~= nil then
			常规提示(self.数字id, "#Y请先卸下灵宝")
			return false
		end
	end
	if self.坐骑~=nil then
		常规提示(self.数字id,"#Y请先卸下坐骑")
		return false
	end
	if self.神器佩戴 or (玩家数据[self.数字id].神器.数据 and 玩家数据[self.数字id].神器.数据.是否佩戴神器) then
		常规提示(self.数字id,"#Y请先卸下神器")
		return false
	end
	return true
end

function 角色处理类:初始化装备属性()--明天检查
	for n = 1, #灵饰战斗属性 do
		self[灵饰战斗属性[n]] = 0
	end

	for k,v in pairs(self.装备属性) do
		self.装备属性[k]=0
	end
	self.强制洗点=true
end

function 角色处理类:洗点操作(id,免费)
	if not self:属性转换检测() then
		 return
	end
	if 免费  or 玩家数据[id].角色.武神坛角色 then
	elseif not self.强制洗点 then
	else
		 local 银子 = self.洗点次数 * 1000000
		if self.银子 < 银子 then
			常规提示(id, "#Y你身上没有那么多的银子")
			return
		end
		self.洗点次数 = self.洗点次数 + 1
		self:扣除银子(银子, 0, 0, "人物洗点", 1)
	end
	self.体质 = 10 + self.等级
	self.魔力 = 10 + self.等级
	self.力量 = 10 + self.等级
	self.耐力 = 10 + self.等级
	self.敏捷 = 10 + self.等级
	self.潜力 = self.等级 * 5 + 5
	if self.历劫.飞升 == true then
		self.潜力 = self.潜力 + 10
	end
	if self.历劫.渡劫 == true then
		self.潜力 = self.潜力 + 25
	end
	self.潜力 = self.潜力 + (self.月饼 or 0)
	self.潜力 = self.潜力 + self.附加潜力.潜能果
	self:初始化装备属性()
	self:刷新信息("0")
	self:加点方案刷新()
	添加最后对话(id, "你的人物属性重置成功！")
end

function 角色处理类:取装备数据()
	local 返回数据 = {}
		 for n, v in pairs(self.装备) do
			返回数据[n] = table.loadstring(table.tostring(玩家数据[self.数字id].道具.数据[self.装备[n]]))
		end
	return 返回数据
end

function 角色处理类:取特技()
	local 返回数据 = {}
	for n, v in pairs(self.装备) do
		if self.装备[n] ~= nil and 玩家数据[self.数字id].道具.数据[self.装备[n]] ~= nil and 玩家数据[self.数字id].道具.数据[self.装备[n]].特技 ~= nil then
			local 加入 = true
			for i = 1, #返回数据 do
				if 返回数据[i] == 玩家数据[self.数字id].道具.数据[self.装备[n]].特技 then
					加入 = false
				end
			end
			if 加入 then
				返回数据[#返回数据 + 1] = 玩家数据[self.数字id].道具.数据[self.装备[n]].特技
			end
		end
	end
	return 返回数据
end

function 角色处理类:取特效()
	local 返回数据 = {}
	for n, v in pairs(self.装备) do
		if self.装备[n] ~= nil and 玩家数据[self.数字id].道具.数据[self.装备[n]] ~= nil and 玩家数据[self.数字id].道具.数据[self.装备[n]].特效 ~= nil then
			for a,b in pairs(玩家数据[self.数字id].道具.数据[self.装备[n]].特效) do
				返回数据[b]=true
			end
		end
	end
	return 返回数据
end

function 角色处理类:取灵饰数据()
	local 返回数据 = {}
	for n, v in pairs(self.灵饰) do
		返回数据[n] = table.loadstring(table.tostring(玩家数据[self.数字id].道具.数据[self.灵饰[n]]))
	end
	return 返回数据
end

function 角色处理类:取锦衣数据()
	local 返回数据 = {}
	for n, v in pairs(self.锦衣) do
		返回数据[n] = table.loadstring(table.tostring(玩家数据[self.数字id].道具.数据[self.锦衣[n]]))
	end

	return 返回数据
end

function 角色处理类:死亡处理(PK)
	self:刷新信息()
	self.气血 = self.最大气血
	self.气血上限 = self.最大气血
	if not PK then
		self.愤怒=0
	end
end

function 角色处理类:取最高师门等级()
	local t = {}
	for n = 1, #self.师门技能 do
		t[n]={等级=self.师门技能[n].等级,名称=self.师门技能[n].名称}
	end
	table.sort(t,function(a,b) return a.等级<b.等级 end)
	return t[#t].名称
end

function 角色处理类:扣除最高师门等级(扣除等级)
	local t = {}
	for n = 1, #self.师门技能 do
		t[n]={等级=self.师门技能[n].等级,名称=self.师门技能[n].名称}
	end
	table.sort(t,function(a,b) return a.等级<b.等级 end )

	local mc = t[#t].名称
	for n = 1, #self.师门技能 do
		if self.师门技能[n].名称==mc then
			 self.师门技能[n].等级=self.师门技能[n].等级-扣除等级
			 local w = self:取包含技能(self.师门技能[n].名称,self.奇经八脉["当前流派"])
			for s = 1, #w do
				self.师门技能[n].包含技能[s].等级 = self.师门技能[n].等级
			end
			break
		end
	end
	return t[#t].名称
end

function 角色处理类:扣除人气(数额)
	if 数额==nil then
		 数额=100
	end
	self.人气 = self.人气 - 数额
	if self.人气 <= 500 then  --阴德低于500会受到天罚与天劫，在天劫中被成功捉拿后，将被关入天牢。关押时间为1小时
		天罚名单[#天罚名单+1]={ID=self.数字id}
	end
end

function 角色处理类:出狱处理()
	self.人气 = 600 ---出狱后的人气
	 if 玩家数据[self.数字id].角色.门派~="无门派" then
		 local 名称 = self:扣除最高师门等级(1)
		闪烁消息(self.数字id,"#H你出狱了···化生寺的主持特来为你诵经，你的人气恢复至#R"..self.人气.."#H点。但为了处罚你的冲动行为，你门派师傅将你的师门技能#R" .. 名称 .. "#H降了#R 1 #H级")
	end
	地图处理类:跳转地图(self.数字id,1050,26,21) --出狱到衙门
end

function 角色处理类:天罚处理()
	if 玩家数据[self.数字id].角色.武神坛角色 then return end
	self.气血 = self.最大气血 * 0.75
	self.气血上限 = self.最大气血 * 0.75
	local go = false
	if 玩家数据[self.数字id].角色.当前经验>=玩家数据[self.数字id].角色.最大经验*0.2 then
		go=true
	end
	------------------比武
	local 地图=玩家数据[self.数字id].角色.地图数据.编号
	if 地图==5136 or 地图==5137 or 地图==5138 or 地图==5139 then
		return
	end
	------------------
	if go then
		 local 扣除经验=qz(玩家数据[self.数字id].角色.最大经验*0.2)
		 local 扣除银子=qz(玩家数据[self.数字id].角色.银子*0.2)
		 玩家数据[self.数字id].角色.银子=qz(玩家数据[self.数字id].角色.银子-扣除银子)
		玩家数据[self.数字id].角色.当前经验=玩家数据[self.数字id].角色.当前经验-扣除经验
		闪烁消息(self.数字id,"#H你因为死亡死亡损失了" .. 扣除经验 .. "点经验\n#H你因为死亡损失了" .. 扣除银子 .. "金钱")
	else
		if 玩家数据[self.数字id].角色.门派~="无门派" then
			 local 名称 = self:扣除最高师门等级(1)
			闪烁消息(self.数字id,"#H你因为死亡死亡降低了师门技能" .. 名称 .. "1级")
		end
	end
	local 坐标={{x=13,y=30},{x=33,y=18},{x=45,y=13}}
	坐标=坐标[取随机数(1,#坐标)]
	地图处理类:跳转地图(self.数字id,1175,math.random(25,35),math.random(15,20))
	闪烁消息(self.数字id,"#H由于人气低于500，执法天兵将你拘押天牢30分钟！在此过程你可能会遭受天兵的反复折磨！")
	坐牢名单[#坐牢名单+1]={ID=self.数字id,时间=os.time()}
	玩家数据[self.数字id].坐牢中=true
	发送数据(玩家数据[self.数字id].连接id,3711)--坐牢不能走动，不能组队，不能使用道具
end


----===============================================================================================================
-- function 角色处理类:勾魂索死亡处理1111111()
-- 	if 玩家数据[self.数字id].角色.武神坛角色 then return end
-- 	self.气血 = self.最大气血 * 0.75
-- 	self.气血上限 = self.最大气血 * 0.75
-- 	if 玩家数据[self.数字id].道具:判断道具是否有(self.数字id,"无常勾魂索") then
-- 		 玩家数据[self.数字id].道具:消耗背包道具(玩家数据[self.数字id].连接id,self.数字id,"无常勾魂索",1)
-- 	end
-- 	------------------比武
-- 	local 地图=玩家数据[self.数字id].角色.地图数据.编号
-- 	if 地图==5136 or 地图==5137 or 地图==5138 or 地图==5139 then
-- 		return
-- 	end
-- 	------------------
-- 	local 扣除道具 = nil
-- 	扣除道具=玩家数据[self.数字id].道具:随机删除道具(玩家数据[self.数字id].连接id,self.数字id)
-- 	local go = false
-- 	if 玩家数据[self.数字id].角色.当前经验>=玩家数据[self.数字id].角色.最大经验*0.2 then
-- 		go=true
-- 	end
-- 	if go then
-- 		 local 扣除经验=qz(玩家数据[self.数字id].角色.最大经验*0.2)
-- 		 local 扣除银子=qz(玩家数据[self.数字id].角色.银子*0.2)
-- 		 玩家数据[self.数字id].角色.银子=qz(玩家数据[self.数字id].角色.银子-扣除银子)
-- 		玩家数据[self.数字id].角色.当前经验=玩家数据[self.数字id].角色.当前经验-扣除经验
-- 		 发送数据(玩家数据[self.数字id].连接id, 38, {内容 = "#Y/你因为死亡损失了" .. 扣除经验 .. "点经验", 频道 = "xt"})
-- 		 发送数据(玩家数据[self.数字id].连接id, 38, {内容 = "#Y/你因为死亡损失了" .. 扣除银子 .. "金钱", 频道 = "xt"})
-- 		 if 扣除道具~=nil then
-- 				闪烁消息(self.数字id,"#H你因为死亡死亡损失了" .. 扣除经验 .. "点经验\n#H你因为死亡损失了" .. 扣除银子 .. "金钱\n#H你被PK死亡损失了#K"..扣除道具.."#H物品")
-- 		 else
-- 			闪烁消息(self.数字id,"#H你因为死亡死亡损失了" .. 扣除经验 .. "点经验\n#H你因为死亡损失了" .. 扣除银子 .. "金钱")
-- 		 end
-- 	else
-- 		if 玩家数据[self.数字id].角色.门派~="无门派" then
-- 			 local 名称 = self:扣除最高师门等级(1)
-- 			 if 扣除道具~=nil then
-- 				 闪烁消息(self.数字id,"#H你因为死亡死亡降低了师门技能" .. 名称 .. "1级\n#H你被PK死亡损失了#K"..扣除道具.."#H物品")
-- 			else
-- 				闪烁消息(self.数字id,"#H你因为死亡死亡降低了师门技能" .. 名称 .. "1级")
-- 			end
-- 		end
-- 	end
-- 	self:刷新信息()
-- 	 玩家数据[self.数字id].道具:给予道具(self.数字id,"阎罗免死牌")
-- 	self:扣除人气(50)
-- 	地图处理类:跳转地图(self.数字id,1125,29,18)
-- end
--==================================================================================================================================================
function 角色处理类:勾魂索死亡处理()---勾魂索失败
					self.气血 = self.最大气血 * 1
					self.气血上限 = self.最大气血 * 1
					if 玩家数据[self.数字id].角色.武神坛角色 then return end
					local 地图=玩家数据[self.数字id].角色.地图数据.编号
					if 地图==5136 or 地图==5137 or 地图==5138 or 地图==5139 then return end

					local 扣除道具 = nil
					扣除道具=玩家数据[self.数字id].道具:随机删除道具(玩家数据[self.数字id].连接id,self.数字id)
					local go = false
					if 玩家数据[self.数字id].角色.当前经验>=玩家数据[self.数字id].角色.最大经验*0.2 then
						go=true
					end
					if go then
						 local 扣除经验=qz(玩家数据[self.数字id].角色.最大经验*0.2)
						 local 扣除银子=qz(玩家数据[self.数字id].角色.银子*0.2)
						 玩家数据[self.数字id].角色.银子=qz(玩家数据[self.数字id].角色.银子-扣除银子)
						 玩家数据[self.数字id].角色.当前经验=玩家数据[self.数字id].角色.当前经验-扣除经验
						 发送数据(玩家数据[self.数字id].连接id, 38, {内容 = "#Y/你因为死亡损失了" .. 扣除经验 .. "点经验", 频道 = "xt"})
						 发送数据(玩家数据[self.数字id].连接id, 38, {内容 = "#Y/你因为死亡损失了" .. 扣除银子 .. "金钱", 频道 = "xt"})
						 if 扣除道具~=nil then
									闪烁消息(self.数字id,"#H你因为死亡死亡损失了" .. 扣除经验 .. "点经验\n#H你因为死亡损失了" .. 扣除银子 .. "金钱\n#H你被PK死亡损失了#K"..扣除道具.."#H物品")
						 else
									闪烁消息(self.数字id,"#H你因为死亡死亡损失了" .. 扣除经验 .. "点经验\n#H你因为死亡损失了" .. 扣除银子 .. "金钱")
						 end
					else
						if 玩家数据[self.数字id].角色.门派~="无门派" then
							 local 名称 = self:扣除最高师门等级(1)
							 if 扣除道具~=nil then
								 	闪烁消息(self.数字id,"#H你因为死亡死亡降低了师门技能" .. 名称 .. "1级\n#H你被PK死亡损失了#K"..扣除道具.."#H物品")
							else
									闪烁消息(self.数字id,"#H你因为死亡死亡降低了师门技能" .. 名称 .. "1级")
							end
						end
					end
					self:刷新信息()
					self:扣除人气(50)
					玩家数据[self.数字id].已扣除勾魂索=nil
					玩家数据[self.数字id].勾魂索中=nil
					玩家数据[self.数字id].zhandou=0
					地图处理类:跳转地图(self.数字id,1125,29,18)
end


function 角色处理类:取新增宝宝数量()
	if #玩家数据[self.数字id].召唤兽.数据 < self.召唤兽携带上限 then
		return true
	else
		return false
	end
end

function 角色处理类:转换装备操作(id,装备,子类)
	local 装备转换费用=5000000
	if 取银子(id)<装备转换费用 and not 玩家数据[id].角色.武神坛角色 then --武神坛
		常规提示(id,"装备转换造型需要500W银子，少侠的银子不够哦！")
		return
	end
	local 等级=math.floor(装备.级别限制/10)
	local 装备名称=""

	if 装备.分类==4 and (子类==22 or 子类==23) then
		local 衣服类型=2
		if 子类==22 then
			衣服类型=1
		end
		子类=21
		装备名称 = 装备处理类.打造物品[子类][等级+1][衣服类型]
	elseif 装备.分类==1 and (子类==19 or 子类==20) then
		local 头盔类型=1
		if 子类==20 then
			头盔类型=2
		end
		子类=19
		装备名称 = 装备处理类.打造物品[子类][等级+1][头盔类型]
	else
		常规提示(id,"请选择正确的转换造型")
		return
	end
	self:扣除银子(装备转换费用,0,0,"装备转换费用",1)
	装备.子类=子类
	装备.名称=装备名称
	if 装备.性别限制 ~= nil and 取物品数据(装备.名称) ~= nil and 取物品数据(装备.名称)[6] ~= nil then
		装备.性别限制 = 取物品数据(装备.名称)[6]
	end
	if 装备.角色限制 ~= nil and 取物品数据(装备.名称) ~= nil and 取物品数据(装备.名称)[7] ~= nil then
		装备.角色限制 = 取物品数据(装备.名称)[7]
	end
	道具刷新(id)
	常规提示(id,"#G装备造型转换成功！")
end

function 角色处理类:取生活技能等级(名称)
	for n = 1, #self.辅助技能 do
		if self.辅助技能[n].名称 == 名称 then return self.辅助技能[n].等级 end
	end
end

function 角色处理类:取可用临时行囊格子(id,类型)
  local 格子 = 630  --战利品行囊页数，63*10是十页宫630个格子
  for n = 1, 格子 do
    if self.临时行囊[类型][n] == nil then
      return n
    end
  end
  return 0
end

function 角色处理类:取生活技能熟练(名称)
	for n = 1, #self.辅助技能 do
		if self.辅助技能[n].名称 == 名称 then
			if self.辅助技能[n].熟练度 == nil then
				self.辅助技能[n].熟练度 = 0
			end
			return self.辅助技能[n].熟练度
		end
	end
	return 0
end

function 角色处理类:增加生活技能熟练(名称,数额)
	local 附加 = 名称
	if 名称 == "打造技巧" then
		附加 = "淬灵之术"
	elseif 名称 == "淬灵之术" then
		附加 = "打造技巧"
	elseif 名称 == "裁缝技巧" then
		附加 = "炼金术"
	elseif 名称 == "炼金术" then
		附加 = "裁缝技巧"
	end
	for n = 1, #self.辅助技能 do
		if self.辅助技能[n].名称 == 名称 or self.辅助技能[n].名称 == 附加 then
			if self.辅助技能[n].熟练度 == nil then
				self.辅助技能[n].熟练度 = 0
			end
			if 数额==nil then
				 数额=10
			end
			self.辅助技能[n].熟练度 = self.辅助技能[n].熟练度+数额
		end
	end
end

function 角色处理类:取经验(id, lv)
	local exp = {}
	if id == 1 then
		exp = {
			40, 110, 237, 450, 779, 1252, 1898, 2745, 3822, 5159, 6784, 8726, 11013, 13674, 16739, 20236, 24194, 28641, 33606, 39119, 45208,
			51902, 55229, 67218, 75899, 85300, 95450, 106377, 118110, 130679, 144112, 158438, 173685, 189882, 207059, 225244, 244466, 264753,
			286134, 308639, 332296, 357134, 383181, 410466, 439019, 468868, 500042, 532569, 566478, 601799, 638560, 676790, 716517, 757770,
			800579, 844972, 890978, 938625, 987942, 1038959, 1091704, 1146206, 1202493, 1260594, 1320539, 1382356, 1446074, 1511721, 1579326,
			1648919, 1720528, 1794182, 1869909, 1947738, 2027699, 2109820, 2194130, 2280657, 2369431, 2460479, 2553832, 2649518, 2747565,
			2848003, 2950859, 3056164, 3163946, 3274233, 3387055, 3502439, 3620416, 3741014, 3864261, 3990187, 4118819, 4250188, 4384322,
			4521249, 4660999, 4803599, 4998571, 5199419, 5406260, 5619213, 5838397, 6063933, 6295941, 6534544, 6779867, 7032035, 7291172,
			7557407, 7830869, 8111686, 8399990, 8695912, 8999586, 9311145, 9630726, 9958463, 10294496, 10638964, 10992005, 11353761, 11724374,
			12103988, 12492748, 12890799, 13298287, 13715362, 14142172, 14578867, 15025600, 15482522, 15949788, 16427552, 16915970, 17415202,
			17925402, 18446732, 18979354, 19523428, 20079116, 20646584, 21225998, 43635044, 44842648, 46075148, 47332886, 48616200, 74888148,
			76891401, 78934581, 81018219, 83142835, 85308969, 87977421, 89767944, 92061870, 146148764, 150094780, 154147340, 158309318,
			162583669, 166973428, 171481711, 176111717, 180866734, 185780135, 240602904, 533679362, 819407100, 1118169947, 1430306664,
			1756161225, 2096082853
		}
	else
		exp = {
			50, 200, 450, 800, 1250, 1800, 2450, 3250, 4050, 5000, 6050, 7200, 8450, 9800, 11250, 12800, 14450, 16200, 18050, 20000, 22050, 24200,
			26450, 28800, 31250, 33800, 36450, 39200, 42050, 45000, 48050, 51200, 54450, 57800, 61250, 64800, 68450, 72200, 76050, 80000, 84050,
			88200, 92450, 96800, 101250, 105800, 110450, 115200, 120050, 125000, 130050, 135200, 140450, 145800, 151250, 156800, 162450,
			168200, 174050, 180000, 186050, 192200, 198450, 204800, 211250, 217800, 224450, 231200, 238050, 245000, 252050, 259200, 266450,
			273800, 281250, 288800, 296450, 304200, 312050, 320000, 328050, 336200, 344450, 352800, 361250, 369800, 378450, 387200, 396050,
			405000, 414050, 423200, 432450, 441800, 451250, 460800, 470450, 480200, 490050, 500000, 510050, 520200, 530450, 540800, 551250,
			561800, 572450, 583200, 594050, 605000, 616050, 627200, 638450, 649800, 661250, 672800, 684450, 696200, 708050, 720000, 732050,
			744200, 756450, 768800, 781250, 793800, 806450, 819200, 832050, 845000, 858050, 871200, 884450, 897800, 911250, 924800, 938450,
			952200, 966050, 980000, 994050, 1008200, 1022450, 1036800, 1051250, 1065800, 1080450, 1095200, 1110050, 1125000, 1140050, 1155200,
			1170450, 1185800, 1201250, 1216800, 1232450, 1248200, 1264050, 1280000, 1300000, 1340000, 1380000, 1420000, 1460000, 1500000, 1540000,
			1580000, 1700000, 1780000, 1820000, 1940000, 2400000, 2880000, 3220000, 4020000, 4220000, 4420000, 4620000, 5220000, 5820000, 6220000,
			7020000, 8020000, 9020000
		}
	end
	return exp[lv + 1]
end

function 角色处理类:取门派技能(门派)
	local n = {}
	if 门派 == "大唐官府" then
		return {"为官之道", "无双一击", "神兵鉴赏", "疾风步", "十方无敌", "紫薇之术", "文韬武略"}
	elseif 门派 == "方寸山" then
		return {"黄庭经", "磐龙灭法", "霹雳咒", "符之术", "归元心法", "神道无念", "斜月步"}
	elseif 门派 == "化生寺" then
		return {"小乘佛法", "金刚伏魔", "诵经", "佛光普照", "大慈大悲", "歧黄之术", "渡世步"}
	elseif 门派 == "女儿村" then
		return {"毒经", "倾国倾城", "沉鱼落雁", "闭月羞花", "香飘兰麝", "玉质冰肌", "清歌妙舞"}
	elseif 门派 == "阴曹地府" then
		return {"灵通术", "六道轮回", "幽冥术", "拘魂诀", "九幽阴魂", "尸腐恶", "无常步"}
	elseif 门派 == "魔王寨" then
		return {"牛逼神功", "震天诀", "火云术", "火牛阵", "牛虱阵", "回身击", "裂石步"}
	elseif 门派 == "狮驼岭" then
		return {"魔兽神功", "生死搏", "训兽诀", "阴阳二气诀", "狂兽诀", "大鹏展翅", "魔兽反噬"}
	elseif 门派 == "盘丝洞" then
		return {"蛛丝阵法", "迷情大法", "秋波暗送", "天外魔音", "盘丝大法", "盘丝步", "姊妹相随"}
	elseif 门派 == "天宫" then
		return {"天罡气", "傲世诀", "清明自在", "宁气诀", "乾坤塔", "混天术", "云霄步"}
	elseif 门派 == "五庄观" then
		return {"周易学", "潇湘仙雨", "乾坤袖", "修仙术", "混元道果", "明性修身", "七星遁"}
	elseif 门派 == "龙宫" then
		return {"九龙诀", "破浪诀", "呼风唤雨", "龙腾术", "逆鳞术", "游龙术", "龙附术"}
	elseif 门派 == "普陀山" then
		return {"灵性", "护法金刚", "观音咒", "五行学说", "金刚经", "五行扭转", "莲花宝座"}
	elseif 门派 == "神木林" then
		return {"瞬息万变", "万灵诸念", "巫咒", "万物轮转", "天人庇护", "神木恩泽", "驭灵咒"}
	elseif 门派 == "凌波城" then
		return {"天地无极", "九转玄功", "武神显圣", "啸傲", "气吞山河", "诛魔", "法天象地"}
	elseif 门派 == "无底洞" then
		return {"枯骨心法", "阴风绝章", "鬼蛊灵蕴", "燃灯灵宝", "地冥妙法", "混元神功", "秘影迷踪"}
	elseif 门派 == "花果山" then
		return {"神通广大", "如意金箍", "齐天逞胜", "金刚之躯", "灵猴九窍", "七十二变", "腾云驾霧"}
	elseif 门派 == '九黎城' then
		return {"九黎战歌","魂枫战舞","兵铸乾坤","燃铁飞花","战火雄魂","魔神降世","风行九黎"}
	end
end

function 角色处理类:取包含技能(名称,经脉流派)
	local 技能 = {
		--大唐官府
		为官之道 = {"杀气诀","翩鸿一击"},
		无双一击 = {"后发制人"},
		神兵鉴赏 = {"兵器谱"},
		疾风步 = {"千里神行"},
		十方无敌 = {"横扫千军", "破釜沉舟"},
		紫薇之术 = {"斩龙诀"},
		文韬武略 = {"反间之计", "安神诀", "嗜血", "其疾如风", "其徐如林", "侵掠如火", "岿然如山" },
		--化生寺
		金刚伏魔 = {"佛法无边"},
		小乘佛法 = {"紫气东来"},
		诵经 = {"唧唧歪歪"},
		佛光普照 = {"达摩护体", "金刚护法", "韦陀护法", "金刚护体", "一苇渡江", "拈花妙指", "醍醐灌顶"},
		大慈大悲 = {"我佛慈悲"},
		歧黄之术 = {"推拿", "活血", "推气过宫", "妙手回春", "救死扶伤", "解毒", "舍生取义"},
		渡世步 = {"佛门普渡","谆谆教诲"},
		--女儿村
		毒经 = {nil},
		倾国倾城 = {"红袖添香", "楚楚可怜", "一笑倾城"},
		沉鱼落雁 = {"满天花雨", "情天恨海", "雨落寒沙", "子母神针"},
		闭月羞花 = {"莲步轻舞", "如花解语", "似玉生香", "娉婷袅娜", "月下霓裳", "自矜"},
		香飘兰麝 = {"轻如鸿毛"},
		玉质冰肌 = {"百毒不侵"},
		清歌妙舞 = {"移形换影", "飞花摘叶"},
		--方寸山
		磐龙灭法 = {nil},
		黄庭经 = {"三星灭魔"},
		霹雳咒 = {"五雷咒"},
		符之术 = { "兵解符", "催眠符", "失心符", "落魄符", "失忆符", "追魂符", "离魂符", "失魂符", "定身符", "落雷符", "碎甲符"},
		归元心法 = {"归元咒", "凝神术"},
		神道无念 = {"乾天罡气", "分身术", "神兵护法", "否极泰来"},
		斜月步 = {"乙木仙遁"},
		--龙宫
		破浪诀 = {"神龙摆尾"},
		九龙诀 = {"解封", "清心", "龙魂", "龙骇", "二龙戏珠"},
		呼风唤雨 = {"龙卷雨击"},
		龙腾术 = {"龙腾", "龙战于野"},
		逆鳞术 = {"逆鳞"},
		游龙术 = {"乘风破浪", "水遁"},
		龙附术 = {"龙吟", "龙啸九天", "龙附"},
		--普陀山
		护法金刚 = {nil},
		金刚经 = {"普渡众生", "灵动九天", "莲华妙法"},
		观音咒 = {"紧箍咒", "杨柳甘露"},
		灵性 = {"自在心法", "清静菩提"},
		五行学说 = {"日光华", "靛沧海", "巨岩破", "苍茫树", "地裂火"},
		五行扭转 = {"五行错位", "颠倒五行"},
		莲花宝座 = {"坐莲"},
		--五庄观
		潇湘仙雨 = {"烟雨剑法", "飘渺式", "同伤式"},
		乾坤袖 = {"日月乾坤", "天地同寿", "乾坤妙法"},
		修仙术 = {"炼气化神", "生命之泉", "太极生化", "一气化三清"},
		周易学 = {"驱魔", "驱尸", "玄黄秘术"},
		混元道果 = {nil},
		明性修身 = {"三花聚顶"},
		七星遁 = {"斗转星移"},
		--天宫
		傲世诀 = {"天雷斩", "鸣雷诀"},
		天罡气 = {"天神护体", "天神护法", "天诛地灭", "五雷轰顶", "雷霆万钧", "浩然正气"},
		清明自在 = {"知己知彼"}, --知己知彼
		宁气诀 = {"宁心"},
		乾坤塔 = {"镇妖", "错乱", "掌心雷"}, --掌心雷
		混天术 = {"百万神兵", "金刚镯","天雷灌注"}, --金刚镯 天雷灌注
		云霄步 = {"腾云驾雾"},
		--地府
		六道轮回 = {"魂飞魄散", "六道无量"},
		幽冥术 = {"阎罗令", "锢魂术", "黄泉之息", "无间地狱"},
		拘魂诀 = {"判官令", "还阳术", "尸气漫天"},
		灵通术 = {"堪察令", "寡欲令"},
		九幽阴魂 = {"幽冥鬼眼", "冤魂不散"},
		尸腐恶 = {"尸腐毒", "修罗隐身"},
		无常步 = {"杳无音讯"},
		--狮驼岭
		生死搏 = {"象形", "鹰击", "狮搏", "天魔解体", "疯狂鹰击"},
		训兽诀 = {"威慑"},
		魔兽神功 = {"变身", "魔兽啸天", "狮吼"}, --狮吼
		阴阳二气诀 = {"定心术", "魔息术"},
		狂兽诀 = {"连环击", "神力无穷"},
		大鹏展翅 = {"振翅千里"},
		魔兽反噬 = {"极度疯狂"},
		--魔王寨
		震天诀 = {nil},
		牛逼神功 = {"魔王护持","风云变色","魔冥"},
		火云术 = {"飞砂走石", "三昧真火", "火甲术", "魔火焚世"},
		火牛阵 = {"牛劲", "踏山裂石"},
		牛虱阵 = {"无敌牛虱", "无敌牛妖", "摇头摆尾"},
		回身击 = {"魔王回首"},
		裂石步 = {"牛屎遁"},
		--盘丝洞
		秋波暗送 = {"勾魂", "摄魄"},
		天外魔音 = {nil},
		蛛丝阵法 = {"盘丝舞", "夺命蛛丝"},
		迷情大法 = {"含情脉脉", "瘴气", "魔音摄魂"},
		盘丝大法 = {"盘丝阵", "复苏", "媚眼如丝", "神迷"}, --神迷
		盘丝步 = {"天罗地网", "天蚕丝", "幻镜术"},
		姊妹相随 = {"姐妹同心"},
 	--凌波城
		天地无极 = {"无双战魂", "吞山", "战意", "饮海"}, --"吞山", "战意", "饮海"
		九转玄功 = {"不动如山"},
		武神显圣 = {"碎星诀", "镇魂诀"},
		啸傲 = {"穿云破空"},
		气吞山河 = {"裂石", "断岳势", "天崩地裂", "浪涌", "惊涛怒", "翻江搅海"},
		诛魔 = {"腾雷", "指地成钢"},
		法天象地 = {"无穷妙道", "纵地金光"},
		--无底洞
		枯骨心法 = {"移魂化骨", "金莲"}, --金莲
		阴风绝章 = {"夺魄令", "煞气诀", "惊魂掌", "摧心术"},
		鬼蛊灵蕴 = {"夺命咒"},
		燃灯灵宝 = {"明光宝烛", "金身舍利", "净土灵华"},
		地冥妙法 = {"地涌金莲", "万木凋枯", "追魂刺", "由己渡人"},
		混元神功 = {"元阳护体", "燃血术"},
		秘影迷踪 = {"遁地术"},
		--神木林
		瞬息万变 = {"落叶萧萧", "风灵", "鞭挞"},
		万灵诸念 = {"荆棘舞", "尘土刃", "冰川怒"},
		巫咒 = {"雾杀", "血雨"},
		万物轮转 = {"星月之惠"},
		天人庇护 = {"炎护", "叶隐"},
		神木恩泽 = {"神木呓语", "花语歌谣"},
		驭灵咒 = {"蜜润", "蝼蚁蚀天"},
		--花果山
		神通广大 = {"如意神通","威震凌霄", "气慑天军"}, --如意神通
		如意金箍 = {"当头一棒", "神针撼海", "杀威铁棒", "泼天乱棒"},
		齐天逞胜 = {"九幽除名", "移星换斗", "云暗天昏"},
		金刚之躯 = {"担山赶月", "铜头铁臂"},
		灵猴九窍 = {"无所遁形", "天地洞明", "除光息焰"},
		七十二变 = {"呼子唤孙", "八戒上身"},
		腾云驾霧 = {"筋斗云"},
		--九黎城
		九黎战歌 = {"黎魂","战鼓","怒哮","炎魂"},
		魂枫战舞 = {"枫影二刃"},
		兵铸乾坤 = {"一斧开天"},
		燃铁飞花 = {"三荒尽灭"},
		战火雄魂 = {"铁血生风"},
		魔神降世 = {"力辟苍穹"},
		风行九黎 = {"故壤归心"}
	}
	if 经脉流派=="无双战神" then --大唐
		 if 名称=="紫薇之术" then
				return {"斩龙诀", "连破"}
		 end
	elseif 经脉流派=="虎贲上将" then --大唐
		if 名称=="文韬武略" then
				return {"反间之计", "安神诀", "嗜血", "披坚执锐", "其疾如风", "其徐如林", "侵掠如火", "岿然如山" }
		 end
	elseif 经脉流派=="杏林妙手" then--化生
		if 名称=="小乘佛法" then
				return {"紫气东来","明光","佛眷"}
		 end
	elseif 经脉流派=="护法金刚" then--化生
		if 名称=="小乘佛法" then
				return {"紫气东来","明光","聚气"}
		 end
	elseif 经脉流派=="无量尊者" then--化生
		if 名称=="小乘佛法" then
				return {"紫气东来","度厄"}
		 elseif 名称=="佛光普照" then
			return {"达摩护体", "金刚护法", "韦陀护法", "金刚护体", "一苇渡江", "拈花妙指", "功德无量"}
		 elseif 名称=="歧黄之术" then
			return {"推拿", "活血", "推气过宫", "妙手回春", "救死扶伤", "解毒", "六尘不染"}
		 end
	elseif 经脉流派=="风火妖王" then --魔王
		if 名称=="牛逼神功" then
			 return {"魔王护持"}
		end
	elseif 经脉流派=="巫影祭司" then --神木
		if 名称=="瞬息万变" then
			 return {"蛊木迷瘴", "风灵", "鞭挞"}
		 elseif 名称=="巫咒" then
			return {"雾杀", "血雨", "催化"} --催化 这个技能还没写呢
		end
	elseif 经脉流派=="灵木神侍" then --神木
		if 名称=="瞬息万变" then
			 return {"落叶萧萧", "风灵", "风萦"}
		 elseif 名称=="神木恩泽" then
			return {"神木呓语", "花语歌谣", "疾风秋叶", "古藤秘咒", "木精"} --疾风秋叶 = 落叶萧萧
		end
	elseif 经脉流派=="伏魔天师" then --方寸山
		if 名称=="黄庭经" then
			 return {"三星灭魔","奔雷"} --奔雷是被动
		 elseif 名称=="归元心法" then
			return {"归元咒","凝神术","悲恸"} --悲恸是被动
		end
	elseif 经脉流派=="五雷正宗" then --方寸山
		if 名称=="霹雳咒" then
			 return {"五雷正法","雷法·崩裂","雷法·震煞","雷法·坤伏","雷法·轰天"}
		 elseif 名称=="符之术" then  --咒符是被动
			return {"兵解符", "催眠符", "失心符", "落魄符", "失忆符", "追魂符", "离魂符", "失魂符", "定身符", "落雷符", "咒符", "碎甲符"}
		 elseif 名称=="神道无念" then
			return {"乾天罡气", "神兵护法", "否极泰来"}
		end
	elseif 经脉流派=="花雨伊人" then --女儿
		if 名称=="闭月羞花" then
			 return {"莲步轻舞", "如花解语", "似玉生香", "娉婷袅娜", "月下霓裳"}
		end
	elseif 经脉流派=="花间美人" then --女儿
		if 名称=="闭月羞花" then
			 return {"莲步轻舞", "如花解语", "似玉生香", "娉婷袅娜", "花飞柳舞", "自矜"}
		 elseif 名称=="清歌妙舞" then
			return {"移形换影", "葬玉焚花", "飞花摘叶"}
		end
	elseif 经脉流派=="踏雷天尊" then --天宫
		if 名称=="天罡气" then
			 return {"天神护体", "天神护法", "天诛地灭", "五雷轰顶", "雷霆万钧", "浩然正气", "电芒"}
		end
	elseif 经脉流派=="霹雳真君" then --天宫
		if 名称=="傲世诀" then
			 return {"天雷斩", "风雷斩", "鸣雷诀"}
		elseif 名称=="天罡气" then
			 return {"天神护体", "天神护法", "天诛地灭", "五雷轰顶", "浩然正气", "霹雳弦惊", "雷怒霆激", "返璞"}
		end
	elseif 经脉流派=="落伽神女" then --普陀
		if 名称=="金刚经" then
			 return {"普渡众生", "莲华妙法"}
		elseif 名称=="观音咒" then
			 return {"紧箍咒", "杨柳甘露", "剑意莲心"}
		 elseif 名称=="灵性" then
			 return {"自在心法", "清静菩提" , "五行珠"} --五行珠
		 elseif 名称=="五行学说" then
			 return {"苍茫刺", "日光耀", "靛沧啸", "巨岩击", "地裂焚"}
		 elseif 名称=="五行扭转" then
			 return {"五行错位", "颠倒五行", "五行感应"} --五行感应
		end
	elseif 经脉流派=="百媚魔姝" then --盘丝
		if 名称=="蛛丝阵法" then
			 return {"盘丝舞", "夺命蛛丝","千蛛噬魂","蛛丝缠绕"}
		end
	elseif 经脉流派=="诛刑毒师" then --地府
		if 名称=="六道轮回" then
			 return {"魂飞魄散", "百鬼噬魂", "血影蚀心"}
		elseif 名称=="幽冥术" then
			 return {"黄泉之息", "无间地狱"}
		 elseif 名称=="拘魂诀" then
			 return {"尸气漫天", "森罗迷瘴"}
		end
	elseif 经脉流派=="万兽之王" then --狮驼
		if 名称=="魔兽神功" then
			 return {"变身", "魔兽啸天"}
		elseif 名称=="狂兽诀" then
			 return {"连环击", "神力无穷", "驯兽·幼狮", "幼狮之搏"}
		end
	elseif 经脉流派=="狂怒斗兽" then --狮驼
		if 名称=="魔兽神功" then
			 return {"变身", "魔兽啸天", "狂怒"}
		end
	elseif 经脉流派=="乾坤力士" then --五庄
		if 名称=="周易学" then
			 return {"驱魔", "驱尸", "骤雨", "玄黄秘术"}
		end
	elseif 经脉流派=="万寿真仙" then --五庄
		if 名称=="潇湘仙雨" then
			 return {"敲金击玉", "金击式", "同伤式"}
		elseif 名称=="周易学" then
			 return {"驱魔", "驱尸", "玄黄秘术", "还丹"}
		end
	elseif 经脉流派=="摄魂迷影" then --无底洞
		if 名称=="枯骨心法" then
			 return {"移魂化骨", "缚魂"}
		elseif 名称=="燃灯灵宝" then
			 return {"明光宝烛", "金身舍利"}
		 elseif 名称=="地冥妙法" then
			 return {"地涌金莲", "万木凋枯", "追魂刺"}
		 elseif 名称=="混元神功" then
			 return {"元阳护体", "燃血术","化羽为血"}
		end
	 elseif 经脉流派=="幽冥巫煞" then --无底洞
		if 名称=="枯骨心法" then
			 return {"移魂化骨"}
		elseif 名称=="阴风绝章" then
			 return {"夺魄令", "煞气诀", "惊魂掌", "摧心术", "裂魂"}
		elseif 名称=="燃灯灵宝" then
			 return {"明光宝烛", "金身舍利"}
		 elseif 名称=="地冥妙法" then
			 return {"地涌金莲", "万木凋枯", "追魂刺"}
		 elseif 名称=="混元神功" then
			 return {"元阳护体", "燃血术","化羽为血"}
		end
	 elseif 经脉流派=="灵霄斗士" then --凌波城
		if 名称=="天地无极" then
			 return {"无双战魂", "超级战意", "战意"}
		end
	 elseif 经脉流派=="风云战将" then --凌波城
		if 名称=="天地无极" then
			 return {"天眼神通", "无双战魂", "战意"}
		end
	 elseif 经脉流派=="通天行者" then --花果山
		if 名称=="神通广大" then
			 return {"如意神通","灵彻太虚", "气慑天军"}
		elseif 名称=="如意金箍" then
			 return {"棒掀北斗","兴风作浪", "棍打诸神"}
		 elseif 名称=="灵猴九窍" then
			 return {"意马心猿","无所遁形", "天地洞明", "除光息焰"}
		end
	end
	return 技能[名称]
end

function 角色处理类:切换师门技能(id,新流派,旧流派) --升级技能的时候加个变量进去，让他只提示某个没学会的技能
	local mbjn = {}
	mbjn = self.师门技能
	self.快捷技能 = {}
	发送数据(玩家数据[self.数字id].连接id, 42, self.快捷技能)
	self.师门技能 = {}
	self.人物技能 = {}
	self.技能属性 = {气血 = 0, 魔法 = 0, 命中 = 0, 伤害 = 0, 防御 = 0, 速度 = 0, 躲避 = 0, 灵力 = 0, 体质 = 0, 魔力 = 0, 力量 = 0, 耐力 = 0, 敏捷 = 0}
	self:刷新信息("0")
	local 列表 = self:取门派技能(self.门派)
	for n = 1, #列表 do
		local 等级 = mbjn[n].等级
		self.师门技能[n] = jnzbzz()
		self.师门技能[n]:置对象(列表[n])
		self.师门技能[n].包含技能 = {}
		self.师门技能[n].等级 = 等级
		local w = self:取包含技能(self.师门技能[n].名称,self.奇经八脉["当前流派"])
		for s = 1, #w do
			self.师门技能[n].包含技能[s] = jnzbzz()
			self.师门技能[n].包含技能[s]:置对象(w[s])
			self.师门技能[n].包含技能[s].等级 = 等级
		end
		    self:升级技能(self.师门技能[n],self.奇经八脉["当前流派"])
	end
end

function 角色处理类:提取奇经八脉(mp)
	if mp == "大唐官府" then
		local 技能表={
			浴血豪侠={"目空", "风刃", "扶阵", "翩鸿", "勇武", "长驱直入", "杀意", "念心", "静岳", "干将", "勇念", "神凝", "狂狷", "不惊", "傲视", "破空", "历战", "安神", "额外能力", "无敌", "浴血豪侠"},
			无双战神={"目空", "勇进", "突刺", "翩鸿", "勇武", "长驱直入", "亢强", "念心", "静岳", "干将", "勇念", "神凝", "惊天动地", "不惊", "突进", "破势", "孤勇", "熟练", "额外能力", "破军", "无双战神"},
			虎贲上将={"潜心", "笃志", "昂扬", "效法", "追戮", "烈光", "摧枯拉朽", "肃杀", "厉兵", "怒伤", "奉还", "催迫", "攻伐", "暴突", "诛伤", "破刃", "奋战", "灵能", "额外能力", "披挂上阵", "虎贲上将"}
		}
		return 技能表
	elseif mp == "化生寺" then
		local 技能表={
			杏林妙手={"销武", "止戈", "圣手", "妙手", "仁心", "化瘀", "佛显", "心韧", "归气", "天照", "舍利", "佛佑", "佛法", "佛性", "妙悟", "慈心", "虔诚", "佛缘", "额外能力", "渡劫金身", "杏林妙手"},
			护法金刚={"施他", "佛屠", "销武", "聚念", "仁心", "磅礴", "佛显", "心韧", "归气", "感念", "舍利", "无碍", "佛法", "佛性", "妙悟", "慈心", "映法", "流刚", "额外能力", "诸天看护", "护法金刚"},
			无量尊者={"诵律", "授业", "修习", "诵经", "悲悯", "解惑", "持戒", "生花", "悟彻", "抚琴", "舍利", "静气", "自在", "无量", "慧定", "金刚", "达摩", "韦陀", "额外能力", "坐禅", "无量尊者"}
		}
		return 技能表
	elseif mp == "龙宫" then
		local 技能表={
			海中蛟虬={"波涛", "破浪", "狂浪", "叱咤", "踏涛", "龙啸", "逐浪", "龙珠", "龙息", "龙慑", "傲翔", "飞龙", "骇浪", "月光", "戏珠", "汹涌", "龙魄", "斩浪", "额外能力", "亢龙归海", "海中蛟虬"},
			云龙真身={"波涛", "破浪", "云霄", "呼风", "踏涛", "清吟", "龙息", "龙珠", "唤雨", "龙慑", "傲翔", "飞龙", "戏珠", "月光", "云变", "沐雨", "龙魄", "摧意", "额外能力", "雷浪穿云", "云龙真身"},
			沧海潜龙={"傲岸", "云魂", "雨魄", "盘龙", "踏涛", "叱咤", "凛然", "龙珠", "回灵", "龙慑", "傲翔", "飞龙", "戏珠", "月光", "波涛", "龙钩", "睥睨", "惊鸿", "额外能力", "潜龙在渊", "沧海潜龙"},
		}
		return 技能表
	elseif mp == "魔王寨" then
		local 技能表={
			平天大圣={"充沛", "震怒", "激怒", "蚀天", "邪火", "赤暖", "火神", "震天", "真炎", "神焰", "崩摧", "焚尽", "咆哮", "狂月", "燃魂", "威吓", "连营", "魔心", "额外能力", "魔焰滔天", "平天大圣"},
			盖世魔君={"充沛", "震怒", "炙烤", "烈焰", "赤暖", "邪火", "火神", "震天", "折服", "焰星", "崩摧", "焰威", "咆哮", "狂月", "魔焱", "威吓", "连营", "狂劲", "额外能力", "升温", "盖世魔君"},
			风火妖王={"秘传三昧真火", "烈火真言", "秘传飞砂走石", "极炙", "咒言", "摧山", "不忿", "震天", "融骨", "神焰", "焦土", "不灭", "烬藏", "固基", "惊悟", "威吓", "旋阳", "魔心", "额外能力", "风火燎原", "风火妖王"},
		}
		return 技能表
	elseif mp == "神木林" then
		local 技能表={
			通天法王={"法身", "风魂", "灵佑", "追击", "咒法", "狂叶", "劲草", "冰锥", "苍埃", "神木", "月影", "薪火", "纯净", "蔓延", "破杀", "星光", "滋养", "灵归", "额外能力", "风卷残云", "通天法王"},
			巫影祭司={"风魂", "迷缚", "法身", "伏毒", "咒法", "灵木", "绞藤", "冰锥", "寄生", "神木", "月影", "薪火", "纯净", "蔓延", "破杀", "激活", "滋养", "毒萃", "额外能力", "凋零之歌", "巫影祭司"},
			灵木神侍={"风魂", "灵秀", "归原", "苍风", "咒法", "焕新", "萦风", "奉愿", "秀木", "神木", "月影", "薪火", "凉秋", "蔓延", "碾杀", "星光", "滋养", "灵精", "额外能力", "枯木逢春", "灵木神侍"},
		}
		return 技能表
	elseif mp == "方寸山" then
		local 技能表={
			拘灵散修={"雷动", "苦缠", "灵咒", "黄粱", "制约", "必果", "补缺", "不倦", "精炼", "化身", "调息", "幻变", "斗法", "吐纳", "专神", "鬼念", "灵威", "碎甲", "额外能力", "顺势而为", "拘灵散修"},
			伏魔天师={"驱雷", "策电", "雷动", "鬼怮", "穿透", "余悸", "宝诀", "妙用", "不灭", "化身", "怒霆", "批亢", "顺势", "炼魂", "吐纳", "灵能", "超导", "摧心", "额外能力", "钟馗论道", "伏魔天师"},
			五雷正宗={"震怒", "雷动", "天篆", "咒诀", "穿透", "符威", "宝诀", "妙用", "不灭", "雷法·翻天", "吞雷", "雷法·倒海", "顺势", "神机", "吐纳", "造化", "碎甲", "摧心", "额外能力", "五雷·挪移", "五雷正宗"},
		}
		return 技能表
	elseif mp == "女儿村" then
		local 技能表={
			绝代妖娆={"独尊", "暗伤", "重明", "倩影", "花舞", "风行", "傲娇", "花护", "空灵", "叶护", "国色", "轻霜", "抑怒", "机巧", "毒雾", "嫣然", "磐石", "倾国", "额外能力", "碎玉弄影", "绝代妖娆"},
			花雨伊人={"涂毒", "杏花", "暗伤", "淬芒", "花舞", "暗刃", "傲娇", "花护", "天香", "轻霜", "鸿影", "百花", "毒雾", "毒引", "余韵", "磐石", "飞花", "花殇", "额外能力", "鸿渐于陆", "花雨伊人"},
			花间美人={"花刺", "花骨", "汹涌", "花落", "花开", "花雨", "毒芒", "追毒", "曼珠", "清澈", "轻刃", "怒放", "驯宠", "乘胜", "痴念", "磐石", "轻霜", "毒引", "额外能力", "花谢花飞", "花间美人"},
		}
		return 技能表
	elseif mp == "天宫" then
		local 技能表={
			镇妖神使={"威吓", "疾雷", "轰鸣", "趁虚", "余韵", "缭乱", "震慑", "神念", "藏招", "苏醒", "护佑", "坚壁", "月桂", "怒火", "套索", "神律", "神尊", "洞察", "额外能力", "画地为牢", "镇妖神使"},
			踏雷天尊={"频变", "威吓", "惊曜", "震荡", "轰鸣", "驭意", "电掣", "神念", "伏魔", "雷霆汹涌", "苏醒", "天劫", "怒电", "共鸣", "灵光", "洞察", "仙音", "雷波", "额外能力", "风雷韵动", "踏雷天尊"},
			霹雳真君={"霆震", "疾雷", "激越", "存雄", "余韵", "慨叹", "电掣", "伏魔", "惊霆", "雷吞", "苏醒", "电光火石", "神采", "劲健", "啸傲", "神律", "气势", "洞察", "额外能力", "威仪九霄", "霹雳真君"},
		}
		return 技能表
	elseif mp == "普陀山" then
		local 技能表={
			莲台仙子={"推衍", "化戈", "普照", "莲花心音", "静心", "慈佑", "劳心", "普渡", "度厄", "甘露", "清净", "莲动", "法华", "灵动", "感念", "玉帛", "雨润", "道衍", "额外能力", "波澜不惊", "莲台仙子"},
			五行咒师={"庄严", "借灵", "推衍", "默诵", "静心", "莲花心音", "赐咒", "普渡", "慧眼", "无怖", "清净", "秘术", "感念", "莲心剑意", "灵动", "道衍", "缘起", "法咒", "额外能力", "五行制化", "五行咒师"},
			落伽神女={"湛然", "因缘", "莲音", "安忍", "静心", "低眉", "顿悟", "怒目", "馀威", "清净", "业障", "困兽", "无尽", "抖擞", "莲华", "相生", "智念", "执念", "额外能力", "万象", "落伽神女"},
		}
		return 技能表
	elseif mp == "盘丝洞" then
		local 技能表={
			风华舞圣={"粘附", "妖气", "怜心", "迷瘴", "鼓乐", "魔音", "玲珑", "安抚", "丹香", "迷梦", "忘川", "连绵", "情劫", "绝殇", "幻镜", "结阵", "媚态", "绝媚", "额外能力", "落花成泥", "风华舞圣"},
			迷情妖姬={"粘附", "妖气", "怜心", "迷瘴", "鼓乐", "忘忧", "玲珑", "安抚", "倾情", "连绵", "忘川", "意乱", "情劫", "魔瘴", "迷意", "结阵", "绝媚", "利刃", "额外能力", "偷龙转凤", "迷情妖姬"},
			百媚魔姝={"粘附", "杀戮", "罗网", "天网", "凌弱", "制怒", "狂击", "千蛛", "引诛", "附骨", "亡缚", "罗刹", "障眼", "连绵", "意乱", "结阵", "牵魂蛛丝", "扑袭", "额外能力", "绝命毒牙", "百媚魔姝"},
		}
		return 技能表
	elseif mp == "阴曹地府" then
		local 技能表={
			勾魂阎罗={"阎罗", "回旋", "夜行", "入骨", "聚魂", "拘魄", "索魂", "伤魂", "瘴幕", "黄泉", "幽冥", "冥视", "幽光", "泉爆", "鬼火", "魂飞", "汲魂", "扼命", "额外能力", "魍魉追魂", "勾魂阎罗"},
			六道魍魉={"阎罗", "回旋", "夜行", "聚魂", "狱火", "六道", "索魂", "伤魂", "百炼", "黄泉", "幽冥", "百爪狂杀", "咒令", "泉爆", "鬼火", "恶焰", "汲魂", "噬毒", "额外能力", "夜之王者", "六道魍魉"},
			诛刑毒师={"毒炽", "回旋", "阴翳", "聚魂", "狱火", "入魂", "毒慑", "破印", "瘴幕", "无赦咒令", "幽冥", "通瞑", "狂宴", "鬼火", "轮回", "蚀骨", "汲魂", "恶焰", "额外能力", "生杀予夺", "诛刑毒师"},
		}
		return 技能表

	elseif mp == "狮驼岭" then
		local 技能表={
			嗜血狂魔={"爪印", "迅捷", "驭兽", "化血", "宁息", "兽王", "威压", "怒象", "鹰啸", "九天", "魔息", "协战", "怒火", "狂袭", "癫狂", "死地", "乱击", "肝胆", "额外能力", "背水", "嗜血狂魔"},
			万兽之王={"拟形", "念主", "夜视", "宁息", "饮血", "健壮", "守势", "狂化", "矫健", "协同", "九天", "争宠", "羁绊", "狂袭", "钢牙", "追逐", "逞凶", "肝胆", "额外能力", "功勋", "万兽之王"},
			狂怒斗兽={"狂躁", "狂化", "狂啸", "攫取", "屏息", "不羁", "狮噬", "象踏", "长啸", "九天", "魔息", "协战", "羁绊", "狂袭", "狂血", "狂乱", "雄风", "狩猎", "额外能力", "困兽之斗", "狂怒斗兽"},
		}
		return 技能表
	elseif mp == "五庄观" then
		local 技能表={
			清心羽客={"体恤", "运转", "行气", "心浪", "养生", "蓄志", "归本", "修心", "存思", "修身", "同辉", "守中", "乾坤", "意境", "存神", "陌宝", "心随意动", "玄机", "额外能力", "清风望月", "清心羽客"},
			乾坤力士={"体恤", "锤炼", "神附", "心浪", "养生", "强击", "无极", "修心", "混元", "修身", "剑气", "雨杀", "意境", "起雨", "滂沱", "剑势", "心随意动", "致命", "额外能力", "天命剑法", "乾坤力士"},
			万寿真仙={"木摧", "道果", "饮露", "炼果", "心浪", "聚力", "无极", "修心", "混元", "刺果", "修身", "三元", "凝神", "纳气", "气盛", "剑势", "还元", "致命", "额外能力", "落土止息", "万寿真仙"},
		}
		return 技能表
	elseif mp == "无底洞" then
		local 技能表={
			妙谛金莲={"灵照", "秉幽", "护法", "涌泉", "绝处逢生", "烛照", "华光", "风墙", "血潮", "精进", "救人", "灵身", "持戒", "罗汉", "灵通", "忍辱", "暗潮", "噬魂", "额外能力", "同舟共济", "妙谛金莲"},
			摄魂迷影={"阴魅", "诡印", "萦魄", "御兽", "绝处逢生", "陷阱", "椎骨", "风墙", "血潮", "灵身", "精进", "救人", "烈煞", "持戒", "罗汉", "忍辱", "暗潮", "噬魂", "额外能力", "妖风四起", "摄魂迷影"},
			幽冥巫煞={"弥愤", "魂守", "刺骨", "余咒", "鬼袭", "羽裂", "分魄", "盛怒", "血潮", "夺血", "灵变", "深刻", "牵动", "独一", "聚魂", "纠缠", "灵身", "踏魄", "额外能力", "冥煞", "幽冥巫煞"},
		}
		return 技能表
	elseif mp == "凌波城" then
		local 技能表={
			九天武圣={"山破", "战诀", "无双", "聚气", "贯通", "魂聚", "神躯", "冰爆", "不动", "力战", "破击", "巧变", "海沸", "怒火", "煞气", "强袭", "混元", "再战", "额外能力", "天神怒斩", "九天武圣"},
			灵霄斗士={"石摧", "战诀", "天泽", "聚气", "贯通", "魂聚", "神躯", "斩魔", "不动", "妙得", "闪雷", "惊涛", "海沸", "怒火", "煞气", "乘势", "追袭", "再战", "额外能力", "真君显灵", "灵霄斗士"},
			风云战将={"山破", "战诀", "天泽", "凝息", "贯通", "魂聚", "神躯", "斩魔", "不动", "威震", "盛势", "天眼", "海沸", "怒火", "煞气", "蓄势", "杀罚", "再战", "额外能力", "耳目一新", "风云战将"},
		}
		return 技能表
	elseif mp == "花果山" then
		local 技能表={
			齐天武圣={"威仪", "逐胜", "愈勇", "斗志", "忘形", "贪天", "显圣", "火眼", "棒打雄风", "闹天", "铁骨", "填海", "伏妖", "豪胆", "压邪", "翻天", "圈养", "荡魔", "额外能力", "齐天神通", "齐天武圣"},
			斗战真神={"顽心", "逐胜", "自在", "变通", "忘形", "顽性", "显圣", "金睛", "棒打雄风", "通天", "铁骨", "威震", "伏妖", "豪胆", "压邪", "朝拜", "圈养", "荡魔", "额外能力", "战神", "斗战真神"},
			通天行者={"威仪", "闹海", "愈勇", "斗志", "忘形", "顽性", "显圣", "逞胜", "得意", "斗战", "添威", "胜意", "大圣", "冲霄", "锻炼", "朝拜", "圈养", "荡魔", "额外能力", "齐天神通", "通天行者"},
		}
		return 技能表
	elseif mp == "九黎城" then
		local 技能表={
			铁火战魔={"枫魂","怒刃","震怒","俾睨","识破","得势","飞扬","凌人","生风","蛮横","难保","乘风","擎天","族魂","魂力","狂暴","驭魔","野蛮","额外能力","魔神之刃","铁火战魔"},
			铁火战魔={"枫魂","怒刃","震怒","俾睨","识破","得势","飞扬","凌人","生风","蛮横","难保","乘风","擎天","族魂","魂力","狂暴","驭魔","野蛮","额外能力","魔神之刃","铁火战魔"},
			铁火战魔={"枫魂","怒刃","震怒","俾睨","识破","得势","飞扬","凌人","生风","蛮横","难保","乘风","擎天","族魂","魂力","狂暴","驭魔","野蛮","额外能力","魔神之刃","铁火战魔"}
		}
		return 技能表
	end
end

function 角色处理类:切换经脉流派(id,新流派,旧流派)
	if self:扣除体力(10)==false or self:扣除活力(10)==false then
		常规提示(id, "体活不足！")
		return
	end
	local go = false
	for i=1,3 do
		if self.奇经八脉[i]==新流派 then
			go=true
		end
	end
	if go then
		 self.奇经八脉 = {}
		 self.奇经八脉 = 取经脉流派(self.门派)
		 self.奇经八脉.开启奇经八脉 = true
		 self.奇经八脉.技能树 = {1, 2, 3}
		 self.奇经八脉["当前流派"]=新流派
		 self.QYD.可用乾元丹 = self.QYD.已换乾元丹 + self.QYD.额外乾元丹
		 self.QYD.已用乾元丹 = 0
		 self:切换师门技能(id,新流派,旧流派)
		 self:发送总数据()
		 发送数据(玩家数据[self.数字id].连接id, 242)
	else
		 常规提示(id, "数据异常！")
	end
end

function 角色处理类:切换经脉流派(id,新流派,旧流派)
	if self:扣除体力(10)==false or self:扣除活力(10)==false then
		常规提示(id, "体活不足！")
		return
	end
	local go = false
	for i=1,3 do
		if self.奇经八脉[i]==新流派 then
			go=true
		end
	end
	if go then
		 self.奇经八脉 = {}
		 self.奇经八脉 = 取经脉流派(self.门派)
		 self.奇经八脉.开启奇经八脉 = true
		 self.奇经八脉.技能树 = {1, 2, 3}
		 self.奇经八脉["当前流派"]=新流派
		 self.QYD.可用乾元丹 = self.QYD.已换乾元丹 + self.QYD.额外乾元丹
		 self.QYD.已用乾元丹 = 0
		--新增师门技能
		 self:切换师门技能(id,新流派,旧流派)
		 self:发送总数据()
		 发送数据(玩家数据[self.数字id].连接id, 242)
	else
		 常规提示(id, "数据异常！")
	end
end

function 角色处理类:重置奇经八脉(id)
	if 玩家数据[self.数字id].角色:扣除银子(1000000, 0, 0, "重置奇经八脉") then
		玩家数据[self.数字id].角色.奇经八脉 = {}
		玩家数据[self.数字id].角色.奇经八脉 = 取经脉流派(玩家数据[self.数字id].角色.门派)
		玩家数据[self.数字id].角色.奇经八脉.开启奇经八脉 = true
		玩家数据[self.数字id].角色.奇经八脉.技能树 = {1, 2, 3}
		玩家数据[self.数字id].角色.QYD.可用乾元丹 = 玩家数据[self.数字id].角色.QYD.已换乾元丹 + 玩家数据[self.数字id].角色.QYD.额外乾元丹
		玩家数据[self.数字id].角色.QYD.已用乾元丹 = 0
		常规提示(self.数字id, "重置奇经八脉成功")
		self:发送总数据()
	else
		常规提示(self.数字id, "银子不足！")
	end
end

function 角色处理类:技能树(a)
	if a == 1 or a == 4 or a == 7 or a == 10 or a == 13 or a == 16 then
		if a == 16 then
			return {20}
		else
			return {a + 3, a + 4}
		end
	elseif a == 2 or a == 5 or a == 8 or a == 11 or a == 14 or a == 17 then
		if a == 17 then
			return {20}
		else
			return {a + 2, a + 3, a + 4}
		end
	elseif a == 3 or a == 6 or a == 9 or a == 12 or a == 15 or a == 18 then
		if a == 18 then
			return {20}
		else
			return {a + 2, a + 3}
		end
	end
end

function 角色处理类:取辅助技能()
	return {"强身术", "冥想", "强壮", "暗器技巧", "中药医理", "烹饪技巧", "打造技巧","裁缝技巧","炼金术","神速", "养生之道", "健身术", "熔炼技巧","追捕技巧","逃离技巧","巧匠之术","灵石技巧","淬灵之术"}
end

function 角色处理类:取强化技能()
	return {"气血强化","伤害强化","防御强化","法伤强化","法防强化","治疗强化","固伤强化"}
end

function 角色处理类:有无技能(名称)
	for n = 1, #self.人物技能 do
		if self.人物技能[n].名称 == 名称 then
			return true
		end
	end
	return false
end

function 角色处理类:取模型(ID)
	local 角色信息 = {}
	角色信息[1] = "飞燕女"
	角色信息[2] = "英女侠"
	角色信息[3] = "巫蛮儿"
	角色信息[4] = "逍遥生"
	角色信息[5] = "剑侠客"
	角色信息[6] = "狐美人"
	角色信息[7] = "骨精灵"
	角色信息[8] = "杀破狼"
	角色信息[9] = "巨魔王"
	角色信息[10] = "虎头怪"
	角色信息[11] = "舞天姬"
	角色信息[12] = "玄彩娥"
	角色信息[13] = "羽灵神"
	角色信息[14] = "神天兵"
	角色信息[15] = "龙太子"
	角色信息[16] = "桃夭夭"
	角色信息[17] = "偃无师"
	角色信息[18] = "鬼潇潇"
	角色信息[19] = "影精灵"
	return 角色信息[ID]
end

function 角色处理类:队伍角色(模型)
	local 角色信息 = {
		飞燕女 = {模型 = "飞燕女", ID = 1, 染色方案 = 3, 性别 = "女", 种族 = "人", 门派 = {"大唐官府", "女儿村", "方寸山", "神木林"}, 武器 = {"双剑", "环圈"}},
		英女侠 = {模型 = "英女侠", ID = 2, 染色方案 = 4, 性别 = "女", 种族 = "人", 门派 = {"大唐官府", "女儿村", "方寸山", "神木林"}, 武器 = {"双剑", "鞭"}},
		巫蛮儿 = {模型 = "巫蛮儿", ID = 3, 染色方案 = 201, 性别 = "女", 种族 = "人", 门派 = {"大唐官府", "女儿村", "方寸山", "神木林"}, 武器 = {"宝珠", "法杖"}},
		逍遥生 = {模型 = "逍遥生", ID = 4, 染色方案 = 1, 性别 = "男", 种族 = "人", 门派 = {"大唐官府", "化生寺", "方寸山", "神木林"}, 武器 = {"扇", "剑"}},
		剑侠客 = {模型 = "剑侠客", ID = 5, 染色方案 = 2, 性别 = "男", 种族 = "人", 门派 = {"大唐官府", "化生寺", "方寸山", "神木林"}, 武器 = {"刀", "剑"}},
		狐美人 = {模型 = "狐美人", ID = 6, 染色方案 = 7, 性别 = "女", 种族 = "魔", 门派 = {"盘丝洞", "阴曹地府", "魔王寨", "无底洞"}, 武器 = {"爪刺", "鞭"}},
		骨精灵 = {模型 = "骨精灵", ID = 7, 染色方案 = 8, 性别 = "女", 种族 = "魔", 门派 = {"盘丝洞", "阴曹地府", "魔王寨", "无底洞"}, 武器 = {"魔棒", "爪刺"}},
		杀破狼 = {模型 = "杀破狼", ID = 8, 染色方案 = 202, 性别 = "男", 种族 = "魔", 门派 = {"狮驼岭", "阴曹地府", "魔王寨", "无底洞"}, 武器 = {"宝珠", "弓弩"}},
		巨魔王 = {模型 = "巨魔王", ID = 9, 染色方案 = 5, 性别 = "男", 种族 = "魔", 门派 = {"狮驼岭", "阴曹地府", "魔王寨", "无底洞"}, 武器 = {"刀", "斧钺"}},
		虎头怪 = {模型 = "虎头怪", ID = 10, 染色方案 = 6, 性别 = "男", 种族 = "魔", 门派 = {"狮驼岭", "阴曹地府", "魔王寨", "无底洞"}, 武器 = {"斧钺", "锤子"}},
		舞天姬 = {模型 = "舞天姬", ID = 11, 染色方案 = 11, 性别 = "女", 种族 = "仙", 门派 = {"天宫", "普陀山", "龙宫", "凌波城", "花果山"}, 武器 = {"飘带", "环圈"}},
		玄彩娥 = {模型 = "玄彩娥", ID = 12, 染色方案 = 12, 性别 = "女", 种族 = "仙", 门派 = {"天宫", "普陀山", "龙宫", "凌波城", "花果山"}, 武器 = {"飘带", "魔棒"}},
		羽灵神 = {模型 = "羽灵神", ID = 13, 染色方案 = 203, 性别 = "男", 种族 = "仙", 门派 = {"天宫", "普陀山", "龙宫", "凌波城", "花果山"}, 武器 = {"法杖", "弓弩"}},
		神天兵 = {模型 = "神天兵", ID = 14, 染色方案 = 9, 性别 = "男", 种族 = "仙", 门派 = {"天宫", "五庄观", "龙宫", "凌波城", "花果山"}, 武器 = {"锤", "枪矛"}},
		龙太子 = {模型 = "龙太子", ID = 15, 染色方案 = 10, 性别 = "男", 种族 = "仙", 门派 = {"天宫", "五庄观", "龙宫", "凌波城", "花果山"}, 武器 = {"扇", "枪矛"}},
		桃夭夭 = {模型 = "桃夭夭", ID = 16, 染色方案 = 204, 性别 = "女", 种族 = "仙", 门派 = {"天宫", "普陀山", "龙宫", "凌波城", "花果山"}, 武器 = {"灯笼"}},
		偃无师 = {模型 = "偃无师", ID = 17, 染色方案 = 205, 性别 = "男", 种族 = "人", 门派 = {"大唐官府", "化生寺", "方寸山", "神木林"}, 武器 = {"剑", "巨剑"}},
		鬼潇潇 = {模型 = "鬼潇潇", ID = 18, 染色方案 = 206, 性别 = "女", 种族 = "魔", 门派 = {"盘丝洞", "阴曹地府", "魔王寨", "无底洞"}, 武器 = {"爪刺", "伞"}},
	  影精灵 = {模型 = "影精灵",ID = 19,染色方案 = 8,性别 = "女",种族 = "魔",门派 = {"盘丝洞","阴曹地府","魔王寨","无底洞","九黎城"},武器 = {"魔棒","爪刺"}}
	}
	return 角色信息[模型]
end

function 角色处理类:取初始属性(种族)
	local 属性 = {
		人 = {10, 10, 10, 10, 10},
		魔 = {12, 11, 11, 8, 8},
		仙 = {12, 5, 11, 12, 10},
	}
	return 属性[种族]
end

function 角色处理类:取属性(种族, 五维)
	local 属性 = {}
	local 力量 = 五维[3]
	local 体质 = 五维[1]
	local 魔力 = 五维[2]
	local 耐力 = 五维[4]
	local 敏捷 = 五维[5]
	if 种族 == "人" or 种族 == 1 then
		属性 = {
			命中 = ceil(力量 * 2.01 + 30),
			伤害 = ceil(力量 * 0.67 + 60),
			防御 = ceil(耐力 * 1.5),
			速度 = ceil((体质 * 0.1) + (耐力 * 0.1) + (力量 * 0.1) + (敏捷 * 0.7)),
			灵力 = ceil((体质 * 0.3) + (魔力 * 0.7) + (耐力 * 0.2) + (力量 * 0.4)),
			躲避 = ceil(敏捷 + 10),
			气血 = ceil((体质 * 5 + 100)),
			法力 = ceil((魔力 * 3 + 100)),
		}
	elseif 种族 == "魔" or 种族 == 2 then
		属性 = {
			命中 = ceil(力量 * 2.31 + 29),
			伤害 = ceil(力量 * 0.77 + 60),
			防御 = ceil(耐力 * 1.4),
			速度 = ceil((体质 * 0.1) + (耐力 * 0.1) + (力量 * 0.1) + (敏捷 * 0.7)),
			灵力 = ceil((体质 * 0.3) + (魔力 * 0.7) + (耐力 * 0.2) + (力量 * 0.4)),
			躲避 = ceil(敏捷 + 10),
			气血 = ceil((体质 * 6 + 100)),
			法力 = ceil((魔力 * 2.5 + 100)),
		}
	elseif 种族 == "仙" or 种族 == 3 then
		属性 = {
			命中 = ceil(力量 * 1.71 + 30),
			伤害 = ceil(力量 * 0.57 + 60),
			防御 = ceil(耐力 * 1.6),
			速度 = ceil((体质 * 0.1) + (耐力 * 0.1) + (力量 * 0.1) + (敏捷 * 0.7)),
			灵力 = ceil((体质 * 0.3) + (魔力 * 0.7) + (耐力 * 0.2) + (力量 * 0.4)),
			躲避 = ceil(敏捷 + 10),
			气血 = ceil((体质 * 4.5 + 100)),
			法力 = ceil((魔力 * 3.5 + 100)),
		}
	end
	return 属性
end

function 角色处理类:日志记录(内容)
	self.日志内容 = self.日志内容.."#换行符"..时间转换(os.time())..内容.."#分割符" .. "#换行符"
end

function 角色处理类:学会技能(id, gz)
	if self.师门技能[id] ~= nil then
		for s = 1, #self.师门技能[id].包含技能 do
			if self.师门技能[id].包含技能[s].名称 == gz and not self:有无技能(gz) then
				self.师门技能[id].包含技能[s].学会 = true
				self.师门技能[id].包含技能[s].等级 = self.师门技能[id].等级
				insert(self.人物技能, table.copy((self.师门技能[id].包含技能[s])))
				常规提示(self.数字id, "恭喜你学会了新技能#G/"..self.师门技能[id].包含技能[s].名称)
			elseif self.师门技能[id].包含技能[s].名称 == gz then
				self.师门技能[id].包含技能[s].等级 = self.师门技能[id].等级
			end
		end
	end
end

function 角色处理类:升级技能(jn,lp) -- 升级获得技能
	-- 化生
	if jn.等级 == nil then
		jn.等级 = 1
	end
	if jn.名称 == "金刚伏魔" then
		self.技能属性.伤害 = qz(self:门派技能算法(2,0.02,jn.等级))
		if self.历劫.飞升 == true then
			if jn.等级 >= 120 then --测试模式1
				self:学会技能(2, "佛法无边")
			end
		end
	elseif jn.名称 == "小乘佛法" then
		if jn.等级 >= 1 then
			if lp=="杏林妙手" then
				 self:学会技能(1, "明光")--被动
				self:学会技能(1, "佛眷")--被动
			elseif  lp=="护法金刚" then
				self:学会技能(1, "明光")--被动
				self:学会技能(1, "聚气")--被动
			elseif  lp=="无量尊者" then
				self:学会技能(1, "度厄")--被动
			end
		end
		if jn.等级 >= 50 then
			self:学会技能(1, "紫气东来")
		end
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "诵经" then
		if jn.等级 >= 1 then
			self:学会技能(3, "唧唧歪歪")
		end
	elseif jn.名称 == "佛光普照" then
		if jn.等级 >= 20 then
			self:学会技能(4, "韦陀护法")
		end
		if jn.等级 >= 35 then
			self:学会技能(4, "金刚护体")
			self:学会技能(4, "拈花妙指")
		end
		if jn.等级 >= 30 then
			self:学会技能(4, "达摩护体")
			self:学会技能(4, "一苇渡江")
			self:学会技能(4, "金刚护法")
		end
		if self.历劫.化圣 == true then
			if jn.等级 >= 180 then --测试模式1
				if lp=="无量尊者" then
					self:学会技能(4, "功德无量")
				else
					self:学会技能(4, "醍醐灌顶")
				end
			end
		end
	elseif jn.名称 == "大慈大悲" then
		if jn.等级 >= 40 then
			self:学会技能(5, "我佛慈悲")
		end
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "歧黄之术" then
		if jn.等级 >= 10 then
			self:学会技能(6, "推拿")
		end
		if jn.等级 >= 15 then
			self:学会技能(6, "解毒")
		end
		if jn.等级 >= 25 then
			self:学会技能(6, "活血")
		end
		if jn.等级 >= 35 then
			self:学会技能(6, "推气过宫")
			self:学会技能(6, "妙手回春")
			self:学会技能(6, "救死扶伤")
		end
		if self.历劫.飞升 == true then
			if jn.等级 >= 120 then --测试模式1
				if lp=="无量尊者" then
					self:学会技能(6, "六尘不染")
				else
					self:学会技能(6, "舍生取义")
				end
			end
		end
	elseif jn.名称 == "渡世步" then
		if jn.等级 >= 1 then
			self:学会技能(7, "佛门普渡")
		end
		if jn.等级 >= 20 then
			self:学会技能(7, "谆谆教诲")
		end
		self.技能属性.躲避 = qz(jn.等级*2)


		-- 大唐
	elseif jn.名称 == "为官之道" then
		if jn.等级 >= 15 then
			self:学会技能(1, "杀气诀")
		end
		if jn.等级 >= 45 then
			self:学会技能(1, "翩鸿一击")
		end

	elseif jn.名称 == "无双一击" then
		if jn.等级 >= 25 then
			self:学会技能(2, "后发制人")
		end
		self.技能属性.命中 = qz(self:门派技能算法(0.97,0.0203,jn.等级))
	elseif jn.名称 == "神兵鉴赏" then
		if jn.等级 >= 15 then
			self:学会技能(3, "兵器谱")
		end
	elseif jn.名称 == "疾风步" then
		if jn.等级 >= 1 then
			self:学会技能(4, "千里神行")
		end
		self.技能属性.躲避 = floor(jn.等级 * 2.5)
	elseif jn.名称 == "十方无敌" then
		if jn.等级 >= 30 then
			self:学会技能(5, "横扫千军")
		end
		if self.历劫.飞升 == true then
			if jn.等级 >= 120 then --测试模式1
				self:学会技能(5, "破釜沉舟")
			end
		end
		self.技能属性.伤害 = qz(self:门派技能算法(2.46,0.0143,jn.等级))
	elseif jn.名称 == "紫薇之术" then
		if jn.等级 >= 50 then
			self:学会技能(6, "斩龙诀")
		end
		if lp=="无双战神" then
			 self:学会技能(6, "连破")
		end
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "文韬武略" then
		 if lp=="虎贲上将" then
				self:学会技能(7, "披坚执锐")
		 end
		if jn.等级 >= 20 then
			self:学会技能(7, "反间之计")
		end
		if jn.等级 >= 35 then
			self:学会技能(7, "嗜血")
		end
		if self.历劫.飞升 == true then
			if jn.等级 >= 120 then --测试模式1
				self:学会技能(7, "安神诀")
			end
		end
		if self.历劫.化圣 == true then
			if jn.等级 >= 180 then--测试模式1
				self:学会技能(7, "其疾如风")
				self:学会技能(7, "其徐如林")
				self:学会技能(7, "侵掠如火")
				self:学会技能(7, "岿然如山")
			end
		end
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))


		-- 龙宫
	elseif jn.名称 == "九龙诀" then
		if jn.等级 >= 1 then
			self:学会技能(1, "龙魂")--被动
			self:学会技能(1, "龙骇")--被动
		end
		if jn.等级 >= 15 then
			self:学会技能(1, "清心")
		end
		if jn.等级 >= 30 then
			self:学会技能(1, "解封")
		end
		if self.历劫.飞升 == true then
			if jn.等级 >= 130 then--测试模式1
				self:学会技能(1, "二龙戏珠")
			end
		end
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "破浪诀" then
		self.技能属性.伤害 = qz(self:门派技能算法(2.0973,0.01899,jn.等级))
		if self.历劫.飞升 == true then
			if jn.等级 >= 120 then--测试模式1
				self:学会技能(2, "神龙摆尾")
			end
		end
	elseif jn.名称 == "呼风唤雨" then
		if jn.等级 >= 15 then
			self:学会技能(3, "龙卷雨击")
		end
	elseif jn.名称 == "龙腾术" then
		if jn.等级 >= 50 then
			self:学会技能(4, "龙腾")
		end
		if self.历劫.化圣 == true then
			if jn.等级 >= 180 then--测试模式1
				self:学会技能(4, "龙战于野")
			end
		end
	elseif jn.名称 == "逆鳞术" then
		if jn.等级 >= 30 then
			self:学会技能(5, "逆鳞")
		end
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "游龙术" then
		if jn.等级 >= 1 then
			self:学会技能(6, "水遁")
		end
		if jn.等级 >= 20 then
			self:学会技能(6, "乘风破浪")
		end
		self.技能属性.躲避 = qz(jn.等级*2)
	elseif jn.名称 == "龙附术" then
		if jn.等级 >= 25 then
			self:学会技能(7, "龙啸九天")
		end
		if jn.等级 >= 30 then
			self:学会技能(7, "龙吟")
		end
		if jn.等级 >= 35 then
			self:学会技能(7, "龙附")
		end


		-- 方寸
	elseif jn.名称 == "黄庭经" then
		if jn.等级 >= 30 then
			self:学会技能(1, "三星灭魔")
		end
		if lp=="伏魔天师" then
			 if jn.等级 >= 1 then
				self:学会技能(1, "奔雷")
			end
		end
	elseif jn.名称 == "磐龙灭法" then
		self.技能属性.伤害 = qz(self:门派技能算法(1.9799,0.02019,jn.等级))
	elseif jn.名称 == "霹雳咒" then
		if lp=="五雷正宗" then
			 if jn.等级 >= 10 then
				self:学会技能(3, "五雷正法")
				self:学会技能(3, "雷法·崩裂")
				self:学会技能(3, "雷法·震煞")
				self:学会技能(3, "雷法·坤伏")
				self:学会技能(3, "雷法·轰天")
			end
		else
			if jn.等级 >= 1 then
				self:学会技能(3, "五雷咒")
			end
		end
	elseif jn.名称 == "符之术" then
		if jn.等级 >= 10 then
			self:学会技能(4, "催眠符")
		end
		if lp=="五雷正宗" then
			 if jn.等级 >= 10 then
				self:学会技能(4, "咒符")
			 end
		end
		if jn.等级 >= 15 then
			self:学会技能(4, "落魄符")
		end
		if jn.等级 >= 20 then
			self:学会技能(4, "追魂符")
		end
		if jn.等级 >= 20 then
			self:学会技能(4, "失忆符")
		end
		-- if jn.等级 >= 21 then
		-- 	self:学会技能(4, "飞行符")
		-- end
		if jn.等级 >= 30 then
			self:学会技能(4, "定身符")
		end
		if jn.等级 >= 20 then
			self:学会技能(4, "落雷符")
		end
		if jn.等级 >= 25 then
			self:学会技能(4, "失魂符")
			self:学会技能(4, "离魂符")
		end
		if jn.等级 >= 40 then
			self:学会技能(4, "失心符")
		end

		if self.历劫.飞升 == true then
			if jn.等级 >= 120 then--测试模式1
				self:学会技能(4, "碎甲符")
			end
		end
	elseif jn.名称 == "归元心法" then
		if jn.等级 >= 10 then
			self:学会技能(5, "归元咒")
			self:学会技能(5, "凝神术")
		end
		if lp=="伏魔天师" then
			 if jn.等级 >= 10 then
				self:学会技能(5, "悲恸")
			end
		end
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "神道无念" then
		if jn.等级 >= 30 then
			self:学会技能(6, "乾天罡气")
		end
		if jn.等级 >= 35 then
			self:学会技能(6, "神兵护法")
		end
		if lp~="五雷正宗" then
			if self.历劫.飞升 == true then
				if jn.等级 >= 120 then--测试模式1
					self:学会技能(6, "分身术")
				end
			end
		end
		if self.历劫.化圣 == true then
			if jn.等级 >= 180 then--测试模式1
				self:学会技能(6, "否极泰来")
			end
		end
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "斜月步" then
		if jn.等级 >= 1 then
			self:学会技能(7, "乙木仙遁")
		end
		self.技能属性.躲避 = qz(jn.等级*2)


		-- 地府
	elseif jn.名称 == "灵通术" then
		if jn.等级 >= 30 then
			self:学会技能(1, "寡欲令")
		end
		if jn.等级 >= 50 then
			self:学会技能(1, "堪察令")
		end
	elseif jn.名称 == "六道轮回" then
		if lp=="诛刑毒师" then
			 if jn.等级 >= 30 then
				self:学会技能(2, "百鬼噬魂")
				self:学会技能(2, "血影蚀心")
			end
		else
			if jn.等级 >= 45 then
				self:学会技能(2, "六道无量")
			end
		end
		if jn.等级 >= 50 then
			self:学会技能(2, "魂飞魄散")
		end

		-- self.技能属性.伤害 = qz(self:门派技能算法(2,0.02,jn.等级))
		-- if 时辰信息.昼夜 == 1 then
	 --    	self.技能属性.伤害 = qz(self:门派技能算法(2.3766,0.021073,jn.等级))
		-- else
			self.技能属性.伤害 = qz(self:门派技能算法(1.46569,0.0092,jn.等级))
		-- end
	elseif jn.名称 == "幽冥术" then
		if lp~="诛刑毒师" then
			if jn.等级 >= 25 then
				self:学会技能(3, "阎罗令")
			end
			if jn.等级 >= 75 then
				self:学会技能(3, "锢魂术")
			end
		end

		if self.历劫.飞升 == true then
			if jn.等级 >= 120 then--测试模式1
				self:学会技能(3, "黄泉之息")
			end
		end
		if self.历劫.化圣 == true then
			if jn.等级 >= 180 then--测试模式1
				self:学会技能(3, "无间地狱")
			end
		end
	elseif jn.名称 == "拘魂诀" then
		if lp=="诛刑毒师" then
			if jn.等级 >= 20 then
				self:学会技能(4, "森罗迷瘴")
			end
		else
			if jn.等级 >= 20 then
				self:学会技能(4, "判官令")
			end
			if self.历劫.飞升 == true then
				if jn.等级 >= 120 then--测试模式1
					self:学会技能(4, "还阳术")
				end
			end
		end
		if jn.等级 >= 35 then
			self:学会技能(4, "尸气漫天")
		end

	elseif jn.名称 == "九幽阴魂" then
		if jn.等级 >= 30 then
			self:学会技能(5, "幽冥鬼眼")
		end
		if jn.等级 >= 50 then
			self:学会技能(5, "冤魂不散")
		end
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "尸腐恶" then
		if jn.等级 >= 20 then
			self:学会技能(6, "尸腐毒")
		end
		if jn.等级 >= 20 then
			self:学会技能(6, "修罗隐身")
		end
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "无常步" then
		if jn.等级 >= 1 then
			self:学会技能(7, "杳无音讯")
		end
		self.技能属性.躲避 = qz(jn.等级*2)


		-- 天宫
	elseif jn.名称 == "天罡气" then
		if lp=="霹雳真君" then
			if jn.等级 >= 25 then
				self:学会技能(1, "霹雳弦惊")
				self:学会技能(1, "雷怒霆激")
			end
			if jn.等级 >= 1 then
				self:学会技能(1, "返璞")
			end
		end
		if jn.等级 >= 30 then
			self:学会技能(1, "天神护体")
		end
		if jn.等级 >= 40 then
			self:学会技能(1, "天神护法")
		end
		if jn.等级 >= 35 then
			self:学会技能(1, "五雷轰顶")
			self:学会技能(1, "浩然正气")
			self:学会技能(1, "天诛地灭")
		end
		if lp~="霹雳真君" and jn.等级 >= 50 then
			self:学会技能(1, "雷霆万钧")
		end
		if lp=="踏雷天尊" and jn.等级 >= 45 then
			self:学会技能(1, "电芒")
		end
		self.技能属性.伤害 = qz(self:门派技能算法(2.4612,0.02039,jn.等级))
	elseif jn.名称 == "傲世诀" then
		if jn.等级 >= 25 then
			self:学会技能(2, "天雷斩")
			if lp=="霹雳真君" then
				 self:学会技能(2, "风雷斩")
			end
		end

		if self.历劫.化圣 == true then
			if jn.等级 >= 180 then--测试模式1
				self:学会技能(2, "鸣雷诀")
			end
		end
	elseif jn.名称 == "宁气诀" then
		if jn.等级 >= 20 then
			self:学会技能(4, "宁心")
		end
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "清明自在" then
		if jn.等级 >= 20 then
			self:学会技能(3, "知己知彼")
		end
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "乾坤塔" then
		if jn.等级 >= 30 then
			self:学会技能(5, "镇妖")
		end
		if jn.等级 >= 50 then
			self:学会技能(5, "错乱")
		end
		if jn.等级 >= 50 then
			self:学会技能(5, "掌心雷") --新增
		end
	elseif jn.名称 == "混天术" then
		if jn.等级 >= 40 then
			self:学会技能(6, "百万神兵")
		end
		if self.历劫.飞升 == true then
			if jn.等级 >= 120 then--测试模式1
				self:学会技能(6, "金刚镯")
				self:学会技能(6,"天雷灌注")
			end
		end
	elseif jn.名称 == "云霄步" then
		if jn.等级 >= 1 then
			self:学会技能(7, "腾云驾雾")
		end
		self.技能属性.躲避 = qz(jn.等级*2)


		-- 魔王
	elseif jn.名称 == "牛逼神功" then
		if jn.等级 >= 35 then
			self:学会技能(1, "魔王护持")
		end
		if lp~="风火妖王" then
			if jn.等级 >= 1 then
					self:学会技能(1,"魔冥") --被动
			 end
			if jn.等级 >= 45 then
					self:学会技能(1,"风云变色")
			 end
		end
	elseif jn.名称 == "火云术" then
		if jn.等级 >= 30 then
			self:学会技能(3, "飞砂走石")
		end
		if jn.等级 >= 20 then
			self:学会技能(3, "三昧真火")
		end
		if self.历劫.飞升 == true then
			if jn.等级 >= 20 then--测试模式1
				self:学会技能(3, "火甲术")
			end
		end
		if self.历劫.化圣 == true then
			if jn.等级 >= 180 then--测试模式1
				self:学会技能(3, "魔火焚世")
			end
		end
	elseif jn.名称 == "裂石步" then
		if jn.等级 >= 1 then
			self:学会技能(7, "牛屎遁")
		end
		self.技能属性.躲避 = qz(jn.等级*2)
	elseif jn.名称 == "震天诀" then
		self.技能属性.伤害 = qz(self:门派技能算法(1.98309,0.02019,jn.等级))
	elseif jn.名称 == "牛虱阵" then
		if jn.等级 >= 30 then
			self:学会技能(5, "无敌牛虱")
			self:学会技能(5, "无敌牛妖")
			self:学会技能(5, "摇头摆尾")
		end
	elseif jn.名称 == "火牛阵" then
		if jn.等级 >= 30 then
			self:学会技能(4, "牛劲")
		end
		if jn.等级 >= 50 then
			self:学会技能(4, "踏山裂石")
		end
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "回身击" then
		if jn.等级 >= 30 then
			self:学会技能(6, "魔王回首")
		end
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))


		--普陀
	elseif jn.名称 == "灵性" then
		if jn.等级 >= 10 and lp=="落伽神女" then
			self:学会技能(1, "五行珠")
		end
		if jn.等级 >= 60 then
			self:学会技能(1, "自在心法")
		end
		if self.历劫.化圣 == true then
			if jn.等级 >= 180 then--测试模式1
				self:学会技能(1, "清静菩提")
			end
		end

		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "护法金刚" then
		self.技能属性.伤害 = qz(self:门派技能算法(1.99,0.02,jn.等级))
	elseif jn.名称 == "金刚经" then
		if jn.等级 >= 15 then
			self:学会技能(5, "普渡众生")
		end
		if jn.等级 >= 35 then
			self:学会技能(5, "莲华妙法")
		end
		if self.历劫.飞升 == true then
			if jn.等级 >= 120 and lp~="落伽神女" then--测试模式1
				self:学会技能(5, "灵动九天")
			end
		end
	elseif jn.名称 == "观音咒" then
		if jn.等级 >= 30 then
			self:学会技能(3, "紧箍咒")
		end
		if jn.等级 >= 20 then
			self:学会技能(3, "杨柳甘露")
			if lp=="落伽神女" then
				 self:学会技能(3, "剑意莲心")
			end
		end
	elseif jn.名称 == "五行学说" then
		if lp~="落伽神女" then
			 if jn.等级 >= 10 then
				self:学会技能(4, "日光华")
				self:学会技能(4, "靛沧海")
				self:学会技能(4, "巨岩破")
				self:学会技能(4, "苍茫树")
				self:学会技能(4, "地裂火")
			end
			else
			if jn.等级 >= 10 then
				self:学会技能(4, "苍茫刺")
				self:学会技能(4, "日光耀")
				self:学会技能(4, "靛沧啸")
				self:学会技能(4, "巨岩击")
				self:学会技能(4, "地裂焚")
			end
		end

	elseif jn.名称 == "五行扭转" then
		if jn.等级 >= 20 then
			self:学会技能(6, "颠倒五行")
			self:学会技能(6, "五行错位")
		end
		if self.历劫.飞升 == true then
			if jn.等级 >= 120 and lp=="落伽神女" then--测试模式1
				self:学会技能(6, "五行感应")
			end
		end
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "莲花宝座" then
		if jn.等级 >= 1 then
			self:学会技能(7, "坐莲")
		end
		self.技能属性.躲避 = qz(jn.等级*2)


		-- 五庄观
	elseif jn.名称 == "周易学" then
		if jn.等级 >= 20 then
			self:学会技能(1, "驱魔")
		end
		if jn.等级 >= 25 then
			self:学会技能(1, "驱尸")
		end
		if lp=="万寿真仙" then
			if jn.等级 >= 20 then
				self:学会技能(1, "还丹")--被动
			end
		elseif lp=="乾坤力士" then
			if jn.等级 >= 20 then
				self:学会技能(1, "骤雨")--被动
			end
		end
		if jn.等级 >= 25 then
			self:学会技能(1, "玄黄秘术")
		end
	elseif jn.名称 == "潇湘仙雨" then
		if lp=="万寿真仙" then
			 if jn.等级 >= 20 then
				self:学会技能(2, "金击式")
			end
			if jn.等级 >= 25 then
				self:学会技能(2, "敲金击玉")
			end
		else
			if jn.等级 >= 20 then
				self:学会技能(2, "飘渺式")
			end
			 if jn.等级 >= 25 then
				self:学会技能(2, "烟雨剑法")
			end
		end

		if self.历劫.化圣 == true then
			if jn.等级 >= 180 then--测试模式1
				self:学会技能(2, "同伤式")
			end
		end
		self.技能属性.伤害 = qz(self:门派技能算法(1.48049,0.02009,jn.等级))--好像确实是
	elseif jn.名称 == "乾坤袖" then
		if jn.等级 >= 20 then
			self:学会技能(3, "日月乾坤")
		end
		if self.历劫.飞升 == true then
			if jn.等级 >= 120 then--测试模式1
				self:学会技能(3, "天地同寿")
				self:学会技能(3, "乾坤妙法")
			end
		end
	elseif jn.名称 == "修仙术" then
		if jn.等级 >= 30 then
			self:学会技能(4, "炼气化神")
		end
		if jn.等级 >= 30 then
			self:学会技能(4, "生命之泉")
		end
		if jn.等级 >= 35 then
			self:学会技能(4, "一气化三清")
			self:学会技能(4, "太极生化")
		end
	elseif jn.名称 == "混元道果" then
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "明性修身" then
		if jn.等级 >= 30 then
			self:学会技能(6, "三花聚顶")
		end
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "七星遁" then
		if jn.等级 >= 1 then
			self:学会技能(7, "斗转星移")
		end
		self.技能属性.躲避 = qz(jn.等级*2)

		-- 狮驼岭
	elseif jn.名称 == "魔兽神功" then
		if jn.等级 >= 20 then
			self:学会技能(1, "变身")
			self:学会技能(1, "魔兽啸天")
		end
		if lp=="嗜血狂魔" then
			if jn.等级 >= 1 then
				self:学会技能(1, "狮吼") --被动
			end
		elseif lp=="狂怒斗兽" then
			if jn.等级 >= 30 then
				self:学会技能(1, "狂怒")
			end
		end

	elseif jn.名称 == "生死搏" then
		if jn.等级 >= 20 then
			self:学会技能(2, "象形")
		end
		if jn.等级 >= 30 then
			self:学会技能(2, "鹰击")
		end
		if jn.等级 >= 20 then
			self:学会技能(2, "狮搏")
		end
		if self.历劫.飞升 == true then
			if jn.等级 >= 120 then--测试模式1
				self:学会技能(2, "天魔解体")
			end
		end
		if self.历劫.化圣 == true then
			if jn.等级 >= 180 then--测试模式1
				self:学会技能(2, "疯狂鹰击")
			end
		end
		self.技能属性.伤害 = qz(self:门派技能算法(1.976,0.0091,jn.等级))
	elseif jn.名称 == "训兽诀" then
		if jn.等级 >= 15 then
			self:学会技能(3, "威慑")
		end
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "阴阳二气诀" then
		if jn.等级 >= 40 then
			self:学会技能(4, "定心术")
		end
		if self.历劫.飞升 == true then
			if jn.等级 >= 120 then--测试模式1
				self:学会技能(4, "魔息术")
			end
		end
	elseif jn.名称 == "狂兽诀" then
		if jn.等级 >= 30 then
			self:学会技能(5, "连环击")
		end
		if jn.等级 >= 35 then
			self:学会技能(5, "神力无穷")
		end
		-- if lp=="万兽之王" then
		--     if jn.等级 >= 20 then
		-- 		self:学会技能(5, "驯兽·幼狮")
		-- 		self:学会技能(5, "幼狮之搏")
		-- 	end
		-- end
	elseif jn.名称 == "大鹏展翅" then
		if jn.等级 >= 1 then
			self:学会技能(6, "振翅千里")
		end
		self.技能属性.躲避 = qz(jn.等级*2)
	elseif jn.名称 == "魔兽反噬" then
		if jn.等级 >= 20 then
			self:学会技能(7, "极度疯狂")
		end
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))


		-- 盘丝洞
	elseif jn.名称 == "秋波暗送" then
		if jn.等级 >= 20 then
			self:学会技能(3, "勾魂")
		end
		if jn.等级 >= 20 then
			self:学会技能(3, "摄魄")
		end
		self.技能属性.命中 = floor(jn.等级 * 3)
	elseif jn.名称 == "蛛丝阵法" then
		if jn.等级 >= 30 then
			self:学会技能(1, "盘丝舞")
			self:学会技能(1, "夺命蛛丝")
		end
		if lp=="百媚魔姝" then
			if jn.等级 >= 10 then
				self:学会技能(1, "千蛛噬魂")
				self:学会技能(1, "蛛丝缠绕")
			end
		end
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "迷情大法" then
		if jn.等级 >= 30 then
			self:学会技能(2, "含情脉脉")
		end
		if jn.等级 >= 45 then
			self:学会技能(2, "魔音摄魂")
		end
		if self.历劫.飞升 == true then
			if jn.等级 >= 120 then--测试模式1
				self:学会技能(2, "瘴气")
			end
		end
	elseif jn.名称 == "天外魔音" then
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0141,jn.等级))
	elseif jn.名称 == "盘丝大法" then
		if jn.等级 >= 45 then
			self:学会技能(5, "神迷") --被动
		end
		if jn.等级 >= 20 then
			self:学会技能(5, "盘丝阵")
		end
		if jn.等级 >= 20 then
			self:学会技能(5, "复苏")
		end
		if self.历劫.化圣 == true then
			if jn.等级 >= 180 then--测试模式1
				self:学会技能(5, "媚眼如丝")
			end
		end
		self.技能属性.伤害 = qz(self:门派技能算法(2.5002,0.0089,jn.等级))
	elseif jn.名称 == "盘丝步" then
		if jn.等级 >= 15 then
			self:学会技能(6, "天罗地网")
		end
		if jn.等级 >= 1 then
			self:学会技能(6, "天蚕丝")
		end
		if self.历劫.飞升 == true then
			if jn.等级 >= 120 then--测试模式1
				self:学会技能(6, "幻镜术")
			end
		end
		self.技能属性.躲避 = qz(jn.等级*2)
	elseif jn.名称 == "姊妹相随" then
		if jn.等级 >= 15 then
			self:学会技能(7, "姐妹同心")
		end

		-- 凌波城

	elseif jn.名称 == "天地无极" then
		if jn.等级 >= 1 then
			if lp=="九天武圣" then
				self:学会技能(1, "吞山")--被动
				self:学会技能(1, "饮海")--被动
			elseif lp=="灵霄斗士" then
				self:学会技能(1, "超级战意")--被动
			end
		end

		if lp=="风云战将" and jn.等级 >= 30 then
			self:学会技能(1, "天眼神通")--被动
		end

		self:学会技能(1, "战意")--被动
		if self.历劫.化圣 == true then
			if jn.等级 >= 180 then--测试模式1
				self:学会技能(1, "无双战魂")
			end
		end
	elseif jn.名称 == "九转玄功" then
		if jn.等级 >= 25 then
			self:学会技能(2, "不动如山")
		end
	elseif jn.名称 == "武神显圣" then
		if jn.等级 >= 30 then
			self:学会技能(3, "碎星诀")
		end
		if self.历劫.飞升 == true then
			if jn.等级 >= 120 then--测试模式1
				self:学会技能(3, "镇魂诀")
			end
		end
	elseif jn.名称 == "气吞山河" then
		if jn.等级 >= 25 then
			self:学会技能(5, "裂石")
		end
		if jn.等级 >= 25 then
			self:学会技能(5, "浪涌")
		end
		if jn.等级 >= 35 then
			self:学会技能(5, "断岳势")
		end
		if jn.等级 >= 45 then
			self:学会技能(5, "天崩地裂")
		end
		if jn.等级 >= 45 then
			self:学会技能(5, "翻江搅海")
		end
		if jn.等级 >= 35 then
			self:学会技能(5, "惊涛怒")
		end
		self.技能属性.伤害 = qz(self:门派技能算法(1.99,0.02,jn.等级))
	elseif jn.名称 == "啸傲" then
		if jn.等级 >= 35 then
			self:学会技能(4, "穿云破空")
		end
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "诛魔" then
		if jn.等级 >= 25 then
			self:学会技能(6, "指地成钢")
		end
		if self.历劫.飞升 == true then
			if jn.等级 >= 120 then--测试模式1
				self:学会技能(6, "腾雷")
			end
		end
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "法天象地" then
		if jn.等级 >= 1 then
			self:学会技能(7, "纵地金光")
		end
		if jn.等级 >= 30 then
			self:学会技能(7, "无穷妙道")
		end
		self.技能属性.命中 = qz(self:门派技能算法(1,0.0099,jn.等级))


		-- 神木林
	elseif jn.名称 == "瞬息万变" then
		if jn.等级 >= 1 then
			self:学会技能(1, "风灵")--被动
		end
		if lp=="通天法王" then
			if jn.等级 >= 35 then
				self:学会技能(1, "落叶萧萧")
				self:学会技能(1, "鞭挞")--被动
			end
		elseif lp=="巫影祭司" then
			if jn.等级 >= 1 then
				self:学会技能(1, "蛊木迷瘴")
				self:学会技能(1, "鞭挞")--被动
			end
		elseif lp=="灵木神侍" then
			if jn.等级 >= 1 then
				self:学会技能(1, "风萦")
			end
			if jn.等级 >= 35 then
				self:学会技能(1, "落叶萧萧")
			end
		end
	elseif jn.名称 == "万灵诸念" then
		if jn.等级 >= 20 then
			self:学会技能(2, "荆棘舞")
		end
		if jn.等级 >= 20 then
			self:学会技能(2, "尘土刃")
		end
		if jn.等级 >= 20 then
			self:学会技能(2, "冰川怒")
		end
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "巫咒" then
		if jn.等级 >= 40 then
			self:学会技能(3, "雾杀")
		end
		if jn.等级 >= 40 then
			self:学会技能(3, "血雨")
		end
		self.技能属性.伤害 = qz(self:门派技能算法(2,0.01985,jn.等级))
	elseif jn.名称 == "万物轮转" then
		if jn.等级 >= 35 then
			self:学会技能(4, "星月之惠")
		end
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "天人庇护" then
		if jn.等级 >= 50 then
			self:学会技能(5, "炎护")
		end
		if jn.等级 >= 1 then
			self:学会技能(5, "叶隐")
		end
		self.技能属性.躲避 = qz(jn.等级*2)
	elseif jn.名称 == "神木恩泽" then
		if jn.等级 >= 35 then
			self:学会技能(6, "神木呓语")
		end
		if self.历劫.化圣 == true then
			if jn.等级 >= 180 then--测试模式
				self:学会技能(6, "花语歌谣")
			end
		end
		if lp=="灵木神侍" then
			if jn.等级 >= 35 then
				 self:学会技能(6, "疾风秋叶")
				 self:学会技能(6, "古藤秘咒")
				 self:学会技能(6, "木精")
			end
		end
	elseif jn.名称 == "驭灵咒" then
		if jn.等级 >= 20 then
			self:学会技能(7, "蜜润")
			self:学会技能(7, "蝼蚁蚀天")
		end
		self.技能属性.魔法 = qz(self:门派技能算法(1.9588999,0.0138,jn.等级))


		-- 无底洞
	elseif jn.名称 == "枯骨心法" then
		if jn.等级 >= 1 and lp=="妙谛金莲" then
			self:学会技能(1, "金莲")--被动
		end
		if lp=="摄魂迷影" then
			 self:学会技能(1, "缚魂")--被动
		end
		if jn.等级 >= 20 then
			self:学会技能(1, "移魂化骨")
		end
	elseif jn.名称 == "阴风绝章" then
		if jn.等级 >= 25 then
			self:学会技能(2, "夺魄令")
		end
		if jn.等级 >= 30 then
			self:学会技能(2, "煞气诀")
		end
		if jn.等级 >= 50 then
			self:学会技能(2, "惊魂掌")
		end
		if jn.等级 >= 20 then
			self:学会技能(2, "摧心术")
		end
		if lp=="幽冥巫煞" then
			 self:学会技能(2, "裂魂")--被动
		end
	elseif jn.名称 == "鬼蛊灵蕴" then
		if jn.等级 >= 35 then
			self:学会技能(3, "夺命咒")
		end
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "燃灯灵宝" then
		if jn.等级 >= 35 then
			self:学会技能(4, "明光宝烛")
		end
		if self.历劫.飞升 == true then
			if jn.等级 >= 120 then--测试模式1
				self:学会技能(4, "金身舍利")
			end
		end
		if self.历劫.化圣 == true and lp=="妙谛金莲" then
			if jn.等级 >= 180 then--测试模式1
				self:学会技能(4, "净土灵华")
			end
		end
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "地冥妙法" then
		if jn.等级 >= 20 then
			self:学会技能(5, "地涌金莲")
			self:学会技能(5,"万木凋枯")
		end
		if jn.等级 >= 20 then
			self:学会技能(5, "追魂刺")--新增
		end
		if jn.等级 >= 20 and lp=="妙谛金莲" then
			self:学会技能(5, "由己渡人") --新增
		end
	elseif jn.名称 == "混元神功" then
		if jn.等级 >= 25 then
			self:学会技能(6, "元阳护体")
		end
		if jn.等级 >= 25 then
			self:学会技能(6, "燃血术") --新增
		end
		-- if self.历劫.化圣 == true and lp~="妙谛金莲" then
		--     if jn.等级 >= 180 then
				self:学会技能(6, "化羽为血")
		-- 	end
		-- end

		self.技能属性.伤害 = qz(self:门派技能算法(1.96139,0.02039,jn.等级))
	elseif jn.名称 == "秘影迷踪" then
		if jn.等级 >= 1 then
			self:学会技能(7, "遁地术")
		end
		self.技能属性.速度 = qz(jn.等级*0.3)



		-- 女儿
	elseif jn.名称 == "毒经" then
		self.技能属性.伤害 = qz(self:门派技能算法(2.015,0.01,jn.等级))
	elseif jn.名称 == "倾国倾城" then
		if jn.等级 >= 20 then
			self:学会技能(2, "红袖添香")
		end
		if jn.等级 >= 10 then
			self:学会技能(2, "楚楚可怜")
		end
		if jn.等级 >= 120 then--测试模式1
			self:学会技能(2, "一笑倾城")
		end
	elseif jn.名称 == "沉鱼落雁" then
		if jn.等级 >= 25 then
			self:学会技能(3, "满天花雨")
			self:学会技能(3, "情天恨海")
		end
		if jn.等级 >= 20 then
			self:学会技能(3, "雨落寒沙")
		end
		if jn.等级 >= 20 then
			self:学会技能(3, "子母神针") --新增
		end
	elseif jn.名称 == "闭月羞花" then
		if lp~="花雨伊人" then
			 if jn.等级 >= 1 then
				self:学会技能(4, "自矜") --被动
			end
		end
		if jn.等级 >= 30 then
			self:学会技能(4, "莲步轻舞")
			self:学会技能(4, "如花解语")
		end
		if jn.等级 >= 40 then
			self:学会技能(4, "似玉生香")
			self:学会技能(4, "娉婷袅娜")
		end
		if self.历劫.化圣 == true then
			if jn.等级 >= 180 then--测试模式1
				if lp=="花间美人" then
					 self:学会技能(4, "花飞柳舞")
				else
					self:学会技能(4, "月下霓裳")
				end
			end
		end
	elseif jn.名称 == "香飘兰麝" then
		if jn.等级 >= 35 then
			self:学会技能(5, "轻如鸿毛")
		end

		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "玉质冰肌" then
		if jn.等级 >= 10 then
			self:学会技能(6, "百毒不侵")
		end
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "清歌妙舞" then
		if jn.等级 >= 1 then
			self:学会技能(7, "移形换影")
		end
		if lp=="花间美人" and jn.等级 >= 20 then
			self:学会技能(7, "葬玉焚花")
		end
		if jn.等级 >= 120 then--测试模式1
			self:学会技能(7, "飞花摘叶")
		end
		self.技能属性.速度 = floor(jn.等级 * 0.8)

		--花果山
	elseif jn.名称 == "神通广大" then
		if jn.等级 >= 1 then
			self:学会技能(1, "如意神通") --被动
		end
		if jn.等级 >= 120 and self.历劫.飞升 == true then
			if lp=="通天行者" then
				self:学会技能(1, "灵彻太虚")
			else
				self:学会技能(1, "威震凌霄")
			end
			self:学会技能(1, "气慑天军")
		end
	elseif jn.名称 == "如意金箍" then
		if jn.等级 >= 1 then
			if lp=="通天行者" then
				 self:学会技能(2, "棒掀北斗")
				self:学会技能(2, "兴风作浪")
				self:学会技能(2, "棍打诸神")
			else
				self:学会技能(2, "当头一棒")
				self:学会技能(2, "神针撼海")
				self:学会技能(2, "杀威铁棒")
				self:学会技能(2, "泼天乱棒")
			end
		end
		self.技能属性.伤害 = qz(self:门派技能算法(1.99,0.02,jn.等级))
	elseif jn.名称 == "齐天逞胜" then
		if jn.等级 >= 15 then
			self:学会技能(3, "移星换斗")
		end
		if jn.等级 >= 1 then
			self:学会技能(3, "九幽除名")
			self:学会技能(3, "云暗天昏")
		end
	elseif jn.名称 == "金刚之躯" then
		if jn.等级 >= 35 then
			self:学会技能(4, "担山赶月")
		end
		if jn.等级 >= 1 then
			self:学会技能(4, "铜头铁臂")
		end
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "灵猴九窍" then
		if jn.等级 >= 10 then
			self:学会技能(5, "无所遁形")
			self:学会技能(5, "除光息焰")
			if lp=="通天行者" then
				 self:学会技能(5, "意马心猿")
			end
		end
		if self.历劫.化圣 ==true then
			if jn.等级 >= 180 then
				self:学会技能(5,"天地洞明")
			end
		end
		self.技能属性.命中 = qz(self:门派技能算法(1,0.0099,jn.等级))
	elseif jn.名称 == "七十二变" then
		if jn.等级 >= 10 then
			self:学会技能(6, "呼子唤孙")
		end
		if jn.等级 >= 45 then
			self:学会技能(6, "八戒上身")
		end
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "腾云驾霧" then
		if jn.等级 >= 1 then
			self:学会技能(7, "筋斗云")
		end
	elseif jn.名称 == "九黎战歌" then
		if jn.等级 >= 1 then
			self:学会技能(1, "黎魂")
			self:学会技能(1, "战鼓")
			self:学会技能(1, "怒哮")
			self:学会技能(1, "炎魂")
		end
	elseif jn.名称 == "魂枫战舞" then
		if jn.等级 >= 1 then
			self:学会技能(2, "枫影二刃")
		end

		self.技能属性.伤害 = floor(jn.等级 * 2.5)
	elseif jn.名称 == "兵铸乾坤" then
		if jn.等级 >= 30 then
			self:学会技能(3, "一斧开天")
		end

		self.技能属性.灵力 = floor(jn.等级 * 1)
	elseif jn.名称 == "燃铁飞花" then
		if jn.等级 >= 30 then
			self:学会技能(4, "三荒尽灭")
		end

		self.技能属性.命中 = floor(jn.等级 * 2.5)
	elseif jn.名称 == "战火雄魂" then
		if jn.等级 >= 30 then
			self:学会技能(5, "铁血生风")
		end

		self.技能属性.防御 = floor(jn.等级 * 1.5)
	elseif jn.名称 == "魔神降世" then
		if jn.等级 >= 30 then
			self:学会技能(6, "力辟苍穹")
		end
	elseif jn.名称 == "风行九黎" then
		if jn.等级 >= 1 then
			self:学会技能(7, "故壤归心")
		end

		self.技能属性.躲避 = floor(jn.等级 * 2.5)
	end
	self:刷新信息()
end


function 角色处理类:门派技能算法(基础,成长,等级)
	local num=0
	for i=1,等级 do
		num=num+基础+成长*i
	end
	return  num
end

function 角色处理类:升级技能2(jn) -- 升级获得技能
	-- 化生
	if jn.名称 == "小乘佛法" then
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "金刚伏魔" then
		self.技能属性.伤害 = qz(self:门派技能算法(2,0.02,jn.等级))
	elseif jn.名称 == "大慈大悲" then
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "渡世步" then
		self.技能属性.躲避 = qz(jn.等级*2)
		-- 大唐
	elseif jn.名称 == "无双一击" then
		self.技能属性.命中 = qz(self:门派技能算法(0.97,0.0203,jn.等级))
	elseif jn.名称 == "疾风步" then
		self.技能属性.躲避 = qz(jn.等级*2)
	elseif jn.名称 == "十方无敌" then
		self.技能属性.伤害 = qz(self:门派技能算法(2.46,0.0143,jn.等级))
	elseif jn.名称 == "紫薇之术" then
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "文韬武略" then
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
		-- 龙宫
	elseif jn.名称 == "九龙诀" then
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "破浪诀" then
		self.技能属性.伤害 = qz(self:门派技能算法(2.0973,0.01899,jn.等级))
	elseif jn.名称 == "逆鳞术" then
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "游龙术" then
		self.技能属性.躲避 = qz(jn.等级*2)
	elseif jn.名称 == "龙附术" then
		-- 方寸
	elseif jn.名称 == "磐龙灭法" then
		self.技能属性.伤害 = qz(self:门派技能算法(1.9799,0.02019,jn.等级))
	elseif jn.名称 == "归元心法" then
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "神道无念" then
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "斜月步" then
		self.技能属性.躲避 = qz(jn.等级*2)
		-- 地府=====================
	elseif jn.名称 == "六道轮回" then
		-- self.技能属性.伤害 = qz(self:门派技能算法(2,0.02,jn.等级))
		-- if 时辰信息.昼夜 == 1 then
	 --    	self.技能属性.伤害 = qz(self:门派技能算法(2.3766,0.021073,jn.等级))
		-- else
			self.技能属性.伤害 = qz(self:门派技能算法(1.46569,0.0092,jn.等级))
		-- end
	elseif jn.名称 == "九幽阴魂" then
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "尸腐恶" then
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "无常步" then
		self.技能属性.躲避 = qz(jn.等级*2)
		-- 天宫======================
	elseif jn.名称 == "天罡气" then
		self.技能属性.伤害 = qz(self:门派技能算法(2.4612,0.02039,jn.等级))
	-- elseif jn.名称 == "傲世诀" then --气血
	elseif jn.名称 == "宁气诀" then
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "清明自在" then
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "云霄步" then
		self.技能属性.躲避 = qz(jn.等级*2)
		-- 魔王
	elseif jn.名称 == "裂石步" then
		self.技能属性.躲避 = qz(jn.等级*2)
	elseif jn.名称 == "震天诀" then
		self.技能属性.伤害 = qz(self:门派技能算法(1.98309,0.02019,jn.等级))
	elseif jn.名称 == "火牛阵" then
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "回身击" then
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "裂石步" then
		self.技能属性.躲避 = floor(jn.等级 * 2) --不加速度
		--普陀
	elseif jn.名称 == "灵性" then
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "护法金刚" then
		self.技能属性.伤害 = qz(self:门派技能算法(1.99,0.02,jn.等级))
	elseif jn.名称 == "五行扭转" then
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "莲花宝座" then
		self.技能属性.躲避 = qz(jn.等级*2)
		-- 五庄观================
	elseif jn.名称 == "潇湘仙雨" then
		self.技能属性.伤害 = qz(self:门派技能算法(1.48049,0.02009,jn.等级))--好像确实是
	elseif jn.名称 == "混元道果" then
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "明性修身" then
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "七星遁" then
		self.技能属性.躲避 = qz(jn.等级*2)
		-- 狮驼岭===============
	elseif jn.名称 == "生死搏" then
		self.技能属性.伤害 = qz(self:门派技能算法(1.976,0.0091,jn.等级))
	elseif jn.名称 == "训兽诀" then
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "大鹏展翅" then
		self.技能属性.躲避 = qz(jn.等级*2)
	elseif jn.名称 == "魔兽反噬" then
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
		-- 盘丝洞
	elseif jn.名称 == "秋波暗送" then
		self.技能属性.命中 = floor(jn.等级 * 3)
	elseif jn.名称 == "蛛丝阵法" then
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "天外魔音" then
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0141,jn.等级))
	elseif jn.名称 == "盘丝大法" then
		self.技能属性.伤害 = qz(self:门派技能算法(2.5002,0.0089,jn.等级))
	elseif jn.名称 == "盘丝步" then
		self.技能属性.躲避 = qz(jn.等级*2)
		-- 凌波城
	elseif jn.名称 == "气吞山河" then
		self.技能属性.伤害 = qz(self:门派技能算法(1.99,0.02,jn.等级))
	elseif jn.名称 == "啸傲" then
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "诛魔" then
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "法天象地" then
		self.技能属性.命中 = qz(self:门派技能算法(1,0.0099,jn.等级))
		-- 神木林
	elseif jn.名称 == "万灵诸念" then
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "巫咒" then
		self.技能属性.伤害 = qz(self:门派技能算法(2,0.01985,jn.等级))
	elseif jn.名称 == "万物轮转" then
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "天人庇护" then
		self.技能属性.躲避 = qz(jn.等级*2)
	elseif jn.名称 == "驭灵咒" then
		self.技能属性.魔法 = qz(self:门派技能算法(1.9588999,0.0138,jn.等级))
		-- 无底洞
	elseif jn.名称 == "鬼蛊灵蕴" then
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "燃灯灵宝" then
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "混元神功" then
		self.技能属性.伤害 = qz(self:门派技能算法(1.96139,0.02039,jn.等级))
	elseif jn.名称 == "秘影迷踪" then
		self.技能属性.速度 = qz(jn.等级*0.3)
		-- 女儿
	elseif jn.名称 == "毒经" then
		self.技能属性.伤害 = qz(self:门派技能算法(2.015,0.01,jn.等级))
	elseif jn.名称 == "香飘兰麝" then
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	elseif jn.名称 == "玉质冰肌" then
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "清歌妙舞" then
		self.技能属性.速度 = floor(jn.等级 * 0.8)
		--花果山
	elseif jn.名称 == "如意金箍" then
		self.技能属性.伤害 = qz(self:门派技能算法(1.99,0.02,jn.等级))
	elseif jn.名称 == "金刚之躯" then
		self.技能属性.防御 = qz(self:门派技能算法(1,0.0138,jn.等级))
	elseif jn.名称 == "灵猴九窍" then
		self.技能属性.命中 = qz(self:门派技能算法(1,0.0099,jn.等级))
	elseif jn.名称 == "七十二变" then
		self.技能属性.灵力 = qz(self:门派技能算法(0.46639,0.0092,jn.等级))
	end
	self:刷新信息()
end

function 角色处理类:删除称谓(sj)
	local fhz = 0
	for i = 1, #self.称谓 do
		if self.称谓[i] == sj then
			fhz = i
		end
	end

	if fhz ~= 0 then
		table.remove(self.称谓, fhz)
		if self.当前称谓 == sj then
			self.当前称谓 = "无称谓"
		end
	end
end

function 角色处理类:添加称谓(sj)
	local fhz = false
	for i = 1, #self.称谓 do
		if self.称谓[i] == sj then
			fhz = true
		end
	end
	if fhz == false then
		table.insert(self.称谓, sj)
		常规提示(self.数字id,"你获得了#Y"..sj.."#Y称谓")
	end
end

function 角色处理类:检查称谓(sj)
	local fhz = false
	for i = 1, #self.称谓 do
		if self.称谓[i] == sj then
			fhz = true
		end
	end
	return fhz
end

function 角色处理类:取门派基础技能(id,门派)
	local 门派基础技能 = ""
	if 门派 == "大唐官府" then
	 门派基础技能 = "为官之道"
	elseif 门派 == "方寸山" then
	 门派基础技能 = "黄庭经"
	elseif 门派 == "化生寺" then
	 门派基础技能 = "小乘佛法"
	elseif 门派 == "女儿村" then
	 门派基础技能 = "毒经"
	elseif 门派 == "阴曹地府" then
	 门派基础技能 = "灵通术"
	elseif 门派 == "魔王寨" then
	 门派基础技能 = "牛逼神功"
	elseif 门派 == "狮驼岭" then
	 门派基础技能 = "魔兽神功"
	elseif 门派 == "盘丝洞" then
	 门派基础技能 = "蛛丝阵法"
	elseif 门派 == "天宫" then
	 门派基础技能 = "天罡气"
	elseif 门派 == "五庄观" then
	 门派基础技能 = "周易学"
	elseif 门派 == "龙宫" then
	 门派基础技能 = "九龙诀"
	elseif 门派 == "普陀山" then
	 门派基础技能 = "金刚经"
	elseif 门派 == "神木林" then
	 门派基础技能 = "瞬息万变"
	elseif 门派 == "凌波城" then
	 门派基础技能 = "天地无极"
	elseif 门派 == "无底洞" then
	 门派基础技能 = "枯骨心法"
	elseif 门派 == "花果山" then
	 门派基础技能 = "神通广大"
	 elseif 门派 == "九黎城" then
	 门派基础技能 = "九黎战歌"
	end
	for i=1,#self.师门技能 do
		if self.师门技能[i].名称 == 门派基础技能 then
			return {编号=i,基础技能=self.师门技能[i].名称}
		end
	end
end

function 角色处理类:取符石技能等级(data)
	local jnlevel = 0
	local 额外技能={[1]=0,[2]=2,[3]=4,[4]=6}
	for i=1,#data do
	 jnlevel=jnlevel+额外技能[data[i]]
	end
	return jnlevel
end

function 角色处理类:符石组合效果刷新(符石组合)
	for k,v in pairs(符石组合) do
	 if k=="为官之道符石" then
		self.额外技能等级["为官之道"] = self:取符石技能等级(v)
	 elseif k=="黄庭经符石" then
		self.额外技能等级["黄庭经"] = self:取符石技能等级(v)
	 elseif k=="神通广大符石" then
		self.额外技能等级["神通广大"] = self:取符石技能等级(v)
	 elseif k=="齐天逞胜符石" then
		self.额外技能等级["齐天逞胜"] = self:取符石技能等级(v)
	 elseif k=="小乘佛法符石" then
		self.额外技能等级["小乘佛法"] = self:取符石技能等级(v)
		self.额外技能属性.灵力 = self.额外技能属性.灵力 + floor(self.额外技能等级["小乘佛法"])
	 elseif k=="毒经符石" then
		self.额外技能等级["毒经"] = self:取符石技能等级(v)
		self.额外技能属性.伤害 = self.额外技能属性.伤害 + floor(self.额外技能等级["毒经"] * 2)
	 elseif k=="天罡气符石" then
		self.额外技能等级["天罡气"] = self:取符石技能等级(v)
		self.额外技能属性.伤害 = self.额外技能属性.伤害 + floor(self.额外技能等级["天罡气"] * 2)
	 elseif k=="九龙诀符石" then
		self.额外技能等级["九龙诀"] = self:取符石技能等级(v)
		self.额外技能属性.灵力 = self.额外技能属性.灵力 +  floor( self.额外技能等级["九龙诀"])
	 elseif k=="周易学符石" then
		self.额外技能等级["周易学"] = self:取符石技能等级(v)
		self.额外技能属性.魔法 = self.额外技能属性.魔法 + floor(self.额外技能等级["周易学"] * 2)
	 elseif k=="灵性符石" then
		self.额外技能等级["灵性"] = self:取符石技能等级(v)
		self.额外技能属性.灵力 = self.额外技能属性.灵力 +  floor(self.额外技能等级["灵性"])
	 elseif k=="灵通术符石" then
		self.额外技能等级["灵通术"] = self:取符石技能等级(v)
	 elseif k=="牛逼神功符石" then
		self.额外技能等级["牛逼神功"] = self:取符石技能等级(v)
	 elseif k=="魔兽神功符石" then
		self.额外技能等级["魔兽神功"] = self:取符石技能等级(v)
	 elseif k=="蛛丝阵法符石" then
		self.额外技能等级["蛛丝阵法"] = self:取符石技能等级(v)
		self.额外技能属性.防御 = self.额外技能属性.防御 + floor(self.额外技能等级["蛛丝阵法"] * 2)
	 -- elseif k=="天火献誓符石" then
	 --   self.额外技能等级["天火献誓"] = self:取符石技能等级(v)
	 elseif k=="燃灯灵宝符石" then
		self.额外技能等级["燃灯灵宝"] = self:取符石技能等级(v)
		self.额外技能属性.防御 = self.额外技能属性.防御 + floor( self.额外技能等级["燃灯灵宝"] * 2)
	 -- elseif k=="神工无形符石" then
	 --   self.额外技能等级["神工无形"] = self:取符石技能等级(v)
	 elseif k=="巫咒符石" then
		self.额外技能等级["巫咒"] = self:取符石技能等级(v)
		self.额外技能属性.伤害 = self.额外技能属性.伤害 + floor( self.额外技能等级["巫咒"] * 2)
	 elseif k=="文韬武略符石" then
		self.额外技能等级["文韬武略"] = self:取符石技能等级(v)
		self.额外技能属性.防御 = self.额外技能属性.防御 + floor(self.额外技能等级["文韬武略"] * 2)
	 elseif k=="归元心法符石" then
		self.额外技能等级["归元心法"] = self:取符石技能等级(v)
		self.额外技能属性.防御 = self.额外技能属性.防御 + floor(self.额外技能等级["归元心法"] * 2)
	 elseif k=="佛光普照符石" then
		self.额外技能等级["佛光普照"] = self:取符石技能等级(v)
	 elseif k=="倾国倾城符石" then
		self.额外技能等级["倾国倾城"] = self:取符石技能等级(v)
	 elseif k=="傲世诀符石" then
		self.额外技能等级["傲世诀"] = self:取符石技能等级(v)
		self.额外技能属性.气血 = self.额外技能属性.气血 + floor(self.额外技能等级["傲世诀"] * 1.4)
	 elseif k=="逆鳞符石" then
		self.额外技能等级["逆鳞术"] = self:取符石技能等级(v)
		self.额外技能属性.防御 = self.额外技能属性.防御 + floor( self.额外技能等级["逆鳞术"] * 2)
	elseif k=="明性修身符石" then
		self.额外技能等级["明性修身"] = self:取符石技能等级(v)
		self.额外技能属性.防御 = self.额外技能属性.防御 + floor( self.额外技能等级["明性修身"] * 2)
	 elseif k=="五行扭转符石" then
		self.额外技能等级["五行扭转"] = self:取符石技能等级(v)
		self.额外技能属性.防御 = self.额外技能属性.防御 + floor( self.额外技能等级["五行扭转"] * 2)
	 elseif k=="拘魂诀符石" then
		self.额外技能等级["拘魂诀"] = self:取符石技能等级(v)
	 elseif k=="回身击符石" then
		self.额外技能等级["回身击"] = self:取符石技能等级(v)
		self.额外技能属性.防御 = self.额外技能属性.防御 + floor( self.额外技能等级["回身击"] * 2)
	 elseif k=="魔兽反噬符石" then
		self.额外技能等级["魔兽反噬"] = self:取符石技能等级(v)
		self.额外技能属性.防御 = self.额外技能属性.防御 + floor( self.额外技能等级["魔兽反噬"] * 2)
	 elseif k=="盘丝大法符石" then
		self.额外技能等级["盘丝大法"] = self:取符石技能等级(v)
		self.额外技能属性.伤害 = self.额外技能属性.伤害 + floor( self.额外技能等级["盘丝大法"] * 2)
	 -- elseif k=="藻光灵狱符石" then
	 --   self.额外技能等级["藻光灵狱"] = self:取符石技能等级(v)
	 elseif k=="地冥妙法符石" then
		self.额外技能等级["地冥妙法"] = self:取符石技能等级(v)
		-- elseif k=="千机奇巧符石" then
	 --   self.额外技能等级["千机奇巧"] = self:取符石技能等级(v)
	 elseif k=="万物轮转符石" then
		self.额外技能等级["万物轮转"] = self:取符石技能等级(v)
		self.额外技能属性.防御 = self.额外技能属性.防御 +  floor( self.额外技能等级["万物轮转"] * 2)
	 elseif k=="十方无敌符石" then
		self.额外技能等级["十方无敌"] = self:取符石技能等级(v)
		self.额外技能属性.伤害 = self.额外技能属性.伤害 + floor( self.额外技能等级["十方无敌"] * 2)
	 elseif k=="符之术符石" then
		self.额外技能等级["符之术"] = self:取符石技能等级(v)
	 elseif k=="歧黄之术符石" then
		self.额外技能等级["歧黄之术"] = self:取符石技能等级(v)
	 elseif k=="闭月羞花符石" then
		self.额外技能等级["闭月羞花"] = self:取符石技能等级(v)
	 elseif k=="乾坤塔符石" then
		self.额外技能等级["乾坤塔"] = self:取符石技能等级(v)
		self.额外技能属性.防御 = self.额外技能属性.防御 +  floor( self.额外技能等级["乾坤塔"] * 2)
	 elseif k=="呼风唤雨符石" then
		self.额外技能等级["呼风唤雨"] = self:取符石技能等级(v)
	 elseif k=="乾坤袖符石" then
		self.额外技能等级["乾坤袖"] = self:取符石技能等级(v)
	 elseif k=="金刚经符石" then
		self.额外技能等级["金刚经"] = self:取符石技能等级(v)
	 elseif k=="幽冥术符石" then
		self.额外技能等级["幽冥术"] = self:取符石技能等级(v)
	 elseif k=="火牛阵符石" then
		self.额外技能等级["火牛阵"] = self:取符石技能等级(v)
		self.额外技能属性.灵力 = self.额外技能属性.灵力 +  floor(self.额外技能等级["火牛阵"])
	 elseif k=="生死搏符石" then
		self.额外技能等级["生死搏"] = self:取符石技能等级(v)
		self.额外技能属性.伤害 = self.额外技能属性.伤害 + floor( self.额外技能等级["生死搏"] * 2)
	 elseif k=="迷情大法符石" then
		self.额外技能等级["迷情大法"] = self:取符石技能等级(v)
	 -- elseif k=="煌火无明符石" then
	 --   self.额外技能等级["煌火无明"] = self:取符石技能等级(v)
	 elseif k=="阴风绝章符石" then
		self.额外技能等级["阴风绝章"] = self:取符石技能等级(v)
	 elseif k=="瞬息万变符石" then
		self.额外技能等级["瞬息万变"] = self:取符石技能等级(v)
	 -- elseif k=="匠心不移符石" then
	 --   self.额外技能等级["匠心不移"] = self:取符石技能等级(v)
	 elseif k=="神兵鉴赏符石" then
		self.额外技能等级["神兵鉴赏"] = self:取符石技能等级(v)
	 elseif k=="霹雳咒符石" then
		self.额外技能等级["霹雳咒"] = self:取符石技能等级(v)
	 elseif k=="诵经符石" then
		self.额外技能等级["诵经"] = self:取符石技能等级(v)
	 elseif k=="沉鱼落雁符石" then
		self.额外技能等级["沉鱼落雁"] = self:取符石技能等级(v)
	 elseif k=="宁气诀符石" then
		self.额外技能等级["宁气诀"] = self:取符石技能等级(v)
		self.额外技能属性.灵力 = self.额外技能属性.灵力 +  floor(self.额外技能等级["宁气诀"])
	 elseif k=="破浪诀符石" then
		self.额外技能等级["破浪诀"] = self:取符石技能等级(v)
		self.额外技能属性.伤害 = self.额外技能属性.伤害 + floor( self.额外技能等级["破浪诀"] * 2)
	 elseif k=="潇湘仙雨符石" then
		self.额外技能等级["潇湘仙雨"] = self:取符石技能等级(v)
		self.额外技能属性.伤害 = self.额外技能属性.伤害 + floor( self.额外技能等级["潇湘仙雨"] * 2)
	 elseif k=="五行学说符石" then
		self.额外技能等级["五行学说"] = self:取符石技能等级(v)
	 elseif k=="尸腐恶符石" then
		self.额外技能等级["尸腐恶"] = self:取符石技能等级(v)
		self.额外技能属性.防御 = self.额外技能属性.防御 +  floor( self.额外技能等级["尸腐恶"] * 2)
	 elseif k=="牛虱阵符石" then
		self.额外技能等级["牛虱阵"] = self:取符石技能等级(v)
	 elseif k=="阴阳二气诀符石" then
		self.额外技能等级["阴阳二气诀"] = self:取符石技能等级(v)
	 elseif k=="姊妹相随符石" then
		self.额外技能等级["姊妹相随"] = self:取符石技能等级(v)
	 elseif k=="无双一击符石" then
		self.额外技能等级["无双一击"] = self:取符石技能等级(v)
		self.额外技能属性.命中 = self.额外技能属性.命中 +  floor( self.额外技能等级["无双一击"] * 2.5)
	 elseif k=="磐龙灭法符石" then
		self.额外技能等级["磐龙灭法"] = self:取符石技能等级(v)
		self.额外技能属性.伤害 = self.额外技能属性.伤害 + floor( self.额外技能等级["磐龙灭法"] * 2)
	 elseif k=="金刚伏魔符石" then
		self.额外技能等级["金刚伏魔"] = self:取符石技能等级(v)
		self.额外技能属性.伤害 = self.额外技能属性.伤害 + floor( self.额外技能等级["金刚伏魔"] * 2)
	 elseif k=="玉质冰肌符石" then
		self.额外技能等级["玉质冰肌"] = self:取符石技能等级(v)
		self.额外技能属性.防御 = self.额外技能属性.防御 +  floor( self.额外技能等级["玉质冰肌"] * 2)
	 elseif k=="混天术符石" then
		self.额外技能等级["混天术"] = self:取符石技能等级(v)
	 elseif k=="龙附符石" then
		self.额外技能等级["龙附术"] = self:取符石技能等级(v)
	 elseif k=="修仙术符石" then
		self.额外技能等级["修仙术"] = self:取符石技能等级(v)
	 elseif k=="护法金刚符石" then
		self.额外技能等级["护法金刚"] = self:取符石技能等级(v)
		self.额外技能属性.伤害 = self.额外技能属性.伤害 + floor( self.额外技能等级["护法金刚"] * 2)
	 elseif k=="六道轮回符石" then
		self.额外技能等级["六道轮回"] = self:取符石技能等级(v)
		self.额外技能属性.伤害 = self.额外技能属性.伤害 + floor( self.额外技能等级["六道轮回"] * 2)
	 elseif k=="震天诀符石" then
		self.额外技能等级["震天诀"] = self:取符石技能等级(v)
		self.额外技能属性.伤害 = self.额外技能属性.伤害 + floor( self.额外技能等级["震天诀"] * 2)
	 elseif k=="狂兽诀符石" then
		self.额外技能等级["狂兽诀"] = self:取符石技能等级(v)
	 elseif k=="秋波暗送符石" then
		self.额外技能等级["秋波暗送"] = self:取符石技能等级(v)
		self.额外技能属性.命中 = floor(self.额外技能等级["秋波暗送"] * 2.5)
	 -- elseif k=="化神以灵符石" then
	 --   self.额外技能等级["化神以灵"] = self:取符石技能等级(v)
	 -- elseif k=="弹指成烬符石" then
	 --   self.额外技能等级["弹指成烬"] = self:取符石技能等级(v)
	 -- elseif k=="攻玉以石符石" then
	 --   self.额外技能等级["攻玉以石"] = self:取符石技能等级(v)
	 -- elseif k=="擎天之械符石" then
	 --   self.额外技能等级["擎天之械"] = self:取符石技能等级(v)
	 elseif k=="混元神功符石" then
		self.额外技能等级["混元神功"] = self:取符石技能等级(v)
		self.额外技能属性.伤害 = self.额外技能属性.伤害 + floor( self.额外技能等级["混元神功"] * 2)
	 elseif k=="秘影迷踪符石" then
		self.额外技能等级["秘影迷踪"] = self:取符石技能等级(v)
		self.额外技能属性.速度 = self.额外技能属性.速度 + floor( self.额外技能等级["秘影迷踪"] * 2.5)
	 elseif k=="神木恩泽符石" then
		self.额外技能等级["神木恩泽"] = self:取符石技能等级(v)
		self.额外技能属性.魔法 = self.额外技能属性.魔法 + floor( self.额外技能等级["神木恩泽"] * 2)
	 elseif k=="紫薇之术符石" then
		self.额外技能等级["紫薇之术"] = self:取符石技能等级(v)
		self.额外技能属性.灵力 = self.额外技能属性.灵力 + floor(self.额外技能等级["紫薇之术"])
	 elseif k=="神道无念符石" then
		self.额外技能等级["神道无念"] = self:取符石技能等级(v)
		self.额外技能属性.灵力 = self.额外技能属性.灵力 + floor(self.额外技能等级["神道无念"])
	 elseif k=="大慈大悲符石" then
		self.额外技能等级["大慈大悲"] = self:取符石技能等级(v)
		self.额外技能属性.防御 = self.额外技能属性.防御 + floor(self.额外技能等级["大慈大悲"] * 2)
	 elseif k=="香飘兰麝符石" then
		self.额外技能等级["香飘兰麝"] = self:取符石技能等级(v)
		self.额外技能属性.灵力 = self.额外技能属性.灵力 + floor(self.额外技能等级["香飘兰麝"])
	 elseif k=="清明自在符石" then
		self.额外技能等级["清明自在"] = self:取符石技能等级(v)
		self.额外技能属性.灵力 = self.额外技能属性.灵力 + floor(self.额外技能等级["清明自在"])
	 elseif k=="龙腾符石" then
		self.额外技能等级["龙腾术"] = self:取符石技能等级(v)
	 elseif k=="混元道果符石" then
		self.额外技能等级["混元道果"] = self:取符石技能等级(v)
		self.额外技能属性.灵力 = self.额外技能属性.灵力 + floor(self.额外技能等级["混元道果"])
	 elseif k=="观音咒符石" then
		self.额外技能等级["观音咒"] = self:取符石技能等级(v)
	 elseif k=="九幽阴魂符石" then
		self.额外技能等级["九幽阴魂"] = self:取符石技能等级(v)
		self.额外技能属性.灵力 = self.额外技能属性.灵力 + floor(self.额外技能等级["九幽阴魂"])
	 elseif k=="火云术符石" then
		self.额外技能等级["火云术"] = self:取符石技能等级(v)
	 elseif k=="训兽诀符石" then
		self.额外技能等级["训兽诀"] = self:取符石技能等级(v)
		self.额外技能属性.灵力 = self.额外技能属性.灵力 + floor(self.额外技能等级["训兽诀"])
	 elseif k=="天外魔音符石" then
		self.额外技能等级["天外魔音"] = self:取符石技能等级(v)
	 -- elseif k=="天罚之焰符石" then
	 --   self.额外技能等级["天罚之焰"] = self:取符石技能等级(v)
	 elseif k=="万灵诸念符石" then
		self.额外技能等级["万灵诸念"] = self:取符石技能等级(v)
		self.额外技能属性.灵力 = self.额外技能属性.灵力 + floor(self.额外技能等级["万灵诸念"])
	 -- elseif k=="探奥索隐符石" then
	 --   self.额外技能等级["探奥索隐"] = self:取符石技能等级(v)
	 elseif k=="枯骨心法符石" then
		self.额外技能等级["枯骨心法"] = self:取符石技能等级(v)
	 elseif k=="疾风步符石" then
		self.额外技能等级["疾风步"] = self:取符石技能等级(v)
		self.额外技能属性.躲避 = self.额外技能属性.躲避 + floor(self.额外技能等级["疾风步"] * 2.5)
	 elseif k=="腾云驾雾符石" then
		self.额外技能等级["腾云驾雾"] = self:取符石技能等级(v)
		self.额外技能属性.躲避 = self.额外技能属性.躲避 + floor(self.额外技能等级["腾云驾雾"] * 2.5)
	 elseif k=="斜月步符石" then
		self.额外技能等级["斜月步"] = self:取符石技能等级(v)
		self.额外技能属性.躲避 = self.额外技能属性.躲避 + floor(self.额外技能等级["斜月步"] * 2.5)
	 elseif k=="渡世步符石" then
		self.额外技能等级["渡世步"] = self:取符石技能等级(v)
		self.额外技能属性.躲避 = self.额外技能属性.躲避 + floor(self.额外技能等级["渡世步"] * 2.5)
	 elseif k=="清歌妙舞符石" then
		self.额外技能等级["清歌妙舞"] = self:取符石技能等级(v)
		self.额外技能属性.速度 = self.额外技能属性.速度 + floor(self.额外技能等级["清歌妙舞"] * 2.5)
	 elseif k=="云霄步符石" then
		self.额外技能等级["云霄步"] = self:取符石技能等级(v)
		self.额外技能属性.躲避 = self.额外技能属性.躲避 + floor(self.额外技能等级["云霄步"] * 2.5)
	 elseif k=="游龙术符石" then
		self.额外技能等级["游龙术"] = self:取符石技能等级(v)
		self.额外技能属性.躲避 = self.额外技能属性.躲避 + floor(self.额外技能等级["游龙术"] * 2.5)
	 elseif k=="七星遁符石" then
		self.额外技能等级["七星遁"] = self:取符石技能等级(v)
		self.额外技能属性.躲避 = self.额外技能属性.躲避 + floor(self.额外技能等级["七星遁"] * 2.5)
	 elseif k=="莲花宝座符石" then
		self.额外技能等级["莲花宝座"] = self:取符石技能等级(v)
		self.额外技能属性.躲避 = self.额外技能属性.躲避 + floor(self.额外技能等级["莲花宝座"] * 2.5)
	 elseif k=="无常步符石" then
		self.额外技能等级["无常步"] = self:取符石技能等级(v)
		self.额外技能属性.速度 = self.额外技能属性.速度 + floor(self.额外技能等级["无常步"] * 2.5)
	 elseif k=="裂石步符石" then
		self.额外技能等级["裂石步"] = self:取符石技能等级(v)
		self.额外技能属性.躲避 = self.额外技能属性.躲避 + floor(self.额外技能等级["裂石步"] * 2.5)
	 elseif k=="大鹏展翅符石" then
		self.额外技能等级["大鹏展翅"] = self:取符石技能等级(v)
		self.额外技能属性.躲避 = self.额外技能属性.躲避 + floor(self.额外技能等级["大鹏展翅"] * 2.5)
		elseif k=="盘丝步符石" then
		self.额外技能等级["盘丝步"] = self:取符石技能等级(v)
		self.额外技能属性.躲避 = self.额外技能属性.躲避 + floor(self.额外技能等级["盘丝步"] * 2.5)
	 -- elseif k=="离魂符石" then
		--   self.额外技能等级["离魂"] = self:取符石技能等级(v)
		--   self.额外技能属性.躲避 = self.额外技能属性.躲避 + floor(self.额外技能等级["疾风步"] * 2.5)
		elseif k=="驭灵咒符石" then
		self.额外技能等级["驭灵咒"] = self:取符石技能等级(v)
		self.额外技能属性.魔法 = self.额外技能属性.魔法 + floor(self.额外技能等级["驭灵咒"] * 2)
		-- elseif k=="运思如电符石" then
		 --    self.额外技能等级["运思如电"] = self:取符石技能等级(v)
		 --    self.额外技能属性.躲避 = self.额外技能属性.躲避 + floor(self.额外技能等级["疾风步"] * 2.5)
		elseif k=="鬼蛊灵蕴符石" then
			self.额外技能等级["鬼蛊灵蕴"] = self:取符石技能等级(v)
			self.额外技能属性.灵力 = self.额外技能属性.灵力 + floor(self.额外技能等级["鬼蛊灵蕴"])
		elseif k=="天地无极符石" then
			self.额外技能等级["天地无极"] = self:取符石技能等级(v)
		elseif k=="啸傲符石" then
			self.额外技能等级["啸傲"] = self:取符石技能等级(v)
			self.额外技能属性.灵力 = self.额外技能属性.灵力 + floor(self.额外技能等级["啸傲"])
		elseif k=="七十二变符石" then
			self.额外技能等级["七十二变"] = self:取符石技能等级(v)
			self.额外技能属性.灵力 = self.额外技能属性.灵力 + floor(self.额外技能等级["七十二变"])
		elseif k=="法天象地符石" then
			self.额外技能等级["法天象地"] = self:取符石技能等级(v)
			self.额外技能属性.命中 = self.额外技能属性.命中 + floor(self.额外技能等级["法天象地"] * 2.5)
		elseif k=="灵猴九窍符石" then
			self.额外技能等级["灵猴九窍"] = self:取符石技能等级(v)
			self.额外技能属性.命中 = self.额外技能属性.命中 + floor(self.额外技能等级["灵猴九窍"] * 2.5)

		elseif k=="武神显圣符石" then
			self.额外技能等级["武神显圣"] = self:取符石技能等级(v)
		elseif k=="金刚之躯符石" then
			self.额外技能等级["金刚之躯"] = self:取符石技能等级(v)
			self.额外技能属性.防御 = self.额外技能属性.防御 + floor(self.额外技能等级["金刚之躯"] * 2)
		elseif k=="诛魔符石" then
			self.额外技能等级["诛魔"] = self:取符石技能等级(v)
			self.额外技能属性.防御 = self.额外技能属性.防御 + floor(self.额外技能等级["诛魔"] * 2)
		elseif k=="九转玄功符石" then
			self.额外技能等级["九转玄功"] = self:取符石技能等级(v)
			self.额外技能属性.躲避 = self.额外技能属性.躲避 + floor(self.额外技能等级["九转玄功"] * 2.5)
		elseif k=="气吞山河符石" then
			self.额外技能等级["气吞山河"] = self:取符石技能等级(v)
			self.额外技能属性.伤害 = self.额外技能属性.伤害 + floor(self.额外技能等级["气吞山河"] * 2)
		elseif k=="如意金箍符石" then
			self.额外技能等级["如意金箍"] = self:取符石技能等级(v)
			self.额外技能属性.伤害 = self.额外技能属性.伤害 + floor(self.额外技能等级["如意金箍"] * 2)
		elseif k=="无懈可击" then
			 self.额外技能属性.防御 = self.额外技能属性.防御 + (#v*6)
		elseif k=="望穿秋水" then
			 self.额外技能属性.灵力 = self.额外技能属性.灵力 + (#v*3)
		elseif k=="万里横行" then
			 self.额外技能属性.伤害 = self.额外技能属性.伤害 + (#v*4)
		elseif k=="日落西山" then
			 self.额外技能属性.速度 = self.额外技能属性.速度 + (#v*4)
		elseif k=="万丈霞光" then
		local 属性值 = 0
		local 参数表 = {[1]=3,[2]=5,[3]=8,[4]=10}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.额外技能属性.治疗能力 = self.额外技能属性.治疗能力 + 属性值
		elseif k == "真元护体" then
		local 属性值 = 0
		local 参数表 = {[1]=50,[2]=60,[3]=70}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.额外技能属性.暗器防御 = self.额外技能属性.暗器防御 + 属性值
		elseif k == "风卷残云" then
		local 属性值 = 0
		local 参数表 = {[1]=5,[2]=10,[3]=15,[4]=20}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["风卷残云"] = 属性值
	 elseif k == "无所畏惧" then
		-- local 属性值 = 0
		-- local 参数表 = {[1]=1,[2]=2,[3]=3,[4]=4}
		-- for i=1,#v do
		--  属性值 = 属性值 + data[i]
		-- end
		-- self.符石技能效果["无所畏惧"] = 属性值
		elseif k == "柳暗花明" then
		local 属性值 = 0
		local 参数表 = {[1]=10,[2]=15,[3]=20,[4]=25}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["柳暗花明"] = 属性值
		elseif k == "飞檐走壁" then
		local 属性值 = 0
		local 参数表 = {[1]=0,[2]=8,[3]=12,[4]=16}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["飞檐走壁"] = 属性值
		elseif k == "点石成金" then
		local 属性值 = 0
		local 参数表 = {[1]=10,[2]=15,[3]=20,[4]=25}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["点石成金"] = 属性值
		elseif k == "百步穿杨" then
		local 属性值 = 0
		local 参数表 = {[1]=25,[2]=45,[3]=75,[4]=100}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["百步穿杨"] = 属性值
		elseif k == "雪照云光" then
			local 属性值 = 0
		local 参数表 = {[1]=2,[2]=4,[3]=6}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["雪照云光"] = 属性值
		elseif k == "心灵手巧" then
		local 属性值 = 0
		local 参数表 = {[1]=5,[2]=8,[3]=10}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["心灵手巧"] = 属性值
		elseif k == "隔山打牛" then
		local 属性值 = 0
		local 参数表 = {[1]=20,[2]=30,[3]=50,[4]=70}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["隔山打牛"] = 属性值
		elseif k == "心随我动" then
		local 属性值 = 0
		local 参数表 = {[1]=25,[2]=40,[3]=70,[4]=90}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["心随我动"] = 属性值
		elseif k == "云随风舞" then
		local 属性值 = 0
		local 参数表 = {[1]=20,[2]=40,[3]=70,[4]=80}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["云随风舞"] = 属性值
		elseif k == "天降大任" then
		local 属性值 = 0
		local 参数表 = {[2]=5,[3]=10,[4]=15}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["天降大任"] = 属性值
		elseif k == "高山流水" then
		local 属性值 = 0
		local 参数表 = {[2]=self.等级/3+30,[3]=self.等级/2+30,[4]=self.等级+30}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["高山流水"] = qz(属性值)
		elseif k == "百无禁忌" then
		local 属性值 = 0
		local 参数表 = {[2]=4,[3]=8,[4]=12}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["百无禁忌"] = qz(属性值)
		elseif k == "暗渡陈仓" then
			local 属性值 = 0
		for i=1,#v do
			属性值 = 属性值 + (#v*3)
		end
		self.符石技能效果["暗渡陈仓"] = 属性值
		elseif k == "化敌为友" then
			local 属性值 = 0
		for i=1,#v do
			属性值 = 属性值 + (#v*3)
		end
		self.符石技能效果["化敌为友"] = 属性值
		elseif k == "网罗乾坤" then
		local 属性值 = 0
		local 参数表 = {[1]=self.等级/2,[2]=self.等级/1.5,[3]=self.等级}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["网罗乾坤"] = qz(属性值)
		self.符石技能效果["扣除防御"] = (self.符石技能效果["扣除防御"] or 0) + #v
		elseif k == "石破天惊" then
		local 属性值 = 0
		local 参数表 = {[1]=self.等级/2,[2]=self.等级/1.5,[3]=self.等级}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["石破天惊"] = qz(属性值)
		self.符石技能效果["扣除防御"] = (self.符石技能效果["扣除防御"] or 0) + #v
		elseif k == "天雷地火" then
		local 属性值 = 0
		local 参数表 = {[1]=self.等级/2,[2]=self.等级/1.5,[3]=self.等级}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["天雷地火"] = qz(属性值)
		self.符石技能效果["扣除防御"] = (self.符石技能效果["扣除防御"] or 0) + #v
		elseif k == "凤舞九天" then
			local 属性值 = 0
			local 参数表 = {[1]=self.等级/2,[2]=self.等级/1.5,[3]=self.等级}
			for i=1,#v do
			 属性值 = 属性值 + 参数表[v[i]]
			end
			self.符石技能效果["凤舞九天"] = qz(属性值)
			self.符石技能效果["扣除防御"] = (self.符石技能效果["扣除防御"] or 0) + #v
		elseif k == "烟雨飘摇" then
		local 属性值 = 0
		local 参数表 = {[1]=self.等级/2,[2]=self.等级/1.5,[3]=self.等级}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["烟雨飘摇"] = qz(属性值)
		self.符石技能效果["扣除防御"] = (self.符石技能效果["扣除防御"] or 0) + #v
		elseif k == "索命无常" then
		local 属性值 = 0
		local 参数表 = {[1]=self.等级/2,[2]=self.等级/1.5,[3]=self.等级}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["索命无常"] = qz(属性值)
		self.符石技能效果["扣除防御"] = (self.符石技能效果["扣除防御"] or 0) + #v
		elseif k == "行云流水" then
		local 属性值 = 0
		local 参数表 = {[1]=self.等级/2,[2]=self.等级/1.5,[3]=self.等级}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["行云流水"] = qz(属性值)
		self.符石技能效果["扣除防御"] = (self.符石技能效果["扣除防御"] or 0) + #v
		elseif k == "福泽天下" then
		local 属性值 = 0
		local 参数表 = {[1]=self.等级/2,[2]=self.等级/1.5,[3]=self.等级}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["福泽天下"] = qz(属性值)
		self.符石技能效果["扣除防御"] = (self.符石技能效果["扣除防御"] or 0) + #v
		elseif k == "势如破竹" then
		local 属性值 = 0
		local 参数表 = {[1]=self.等级/2,[2]=self.等级/1.5,[3]=self.等级}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["势如破竹"] = qz(属性值)
		self.符石技能效果["扣除防御"] = (self.符石技能效果["扣除防御"] or 0) + #v
		elseif k == "销魂噬骨" then
			local 属性值 = 0
			local 参数表 = {[1]=self.等级*0.25,[2]=self.等级*0.33,[3]=self.等级*0.5}
			for i=1,#v do
				属性值 = 属性值 + 参数表[v[i]]
			 end
			 self.符石技能效果["销魂噬骨"] = qz(属性值)
			 -- self.符石技能效果["扣除防御"] = (self.符石技能效果["扣除防御"] or 0) + #v
		elseif k == "无心插柳" then
		local 属性值 = 0
		local 参数表 = {[1]=15,[2]=20,[3]=25}
		for i=1,#v do
			属性值 = 属性值 + 参数表[v[i]]
		end
		self.符石技能效果["无心插柳"] = 属性值
		elseif k == "降妖伏魔" then
		local 属性值 = 0
		local 参数表 = {[2]=8,[3]=15}
		for i=1,#v do
		属性数值 = 属性值 + 参数表[v[i]]
		end
			self.符石技能效果["降妖伏魔"] = 属性值
		end
	end
end


---助战
function 角色处理类:助战增加奇经八脉(主号id, 位置)
	if self.门派 ~= nil and self.门派 ~= "无门派" then
		local x读取 = self:提取奇经八脉(self.门派)
		x读取=x读取[self.奇经八脉["当前流派"]]
		if x读取 ~= nil and x读取[位置] ~= nil and x读取[位置] ~= 1 then --and self:技能树(位置)  还要根据技能树位置来判断 前面是否学习了这个经脉，不然就不给切换
			if self.QYD.可用乾元丹 ~= nil and self.QYD.可用乾元丹 > 0 then
				self.QYD.可用乾元丹 = self.QYD.可用乾元丹 - 1
				self.QYD.已用乾元丹 = self.QYD.已用乾元丹 + 1
				self.奇经八脉[x读取[位置]] = 1
				self.奇经八脉.开启奇经八脉 = true
				self.奇经八脉.技能树 = self:技能树(位置) or 1
				local sj = {已用乾元丹 = self.QYD.已用乾元丹, 可用乾元丹 = self.QYD.可用乾元丹, 可换乾元丹 = self.QYD.可换乾元丹}
				发送数据(玩家数据[主号id].连接id, 2008, sj)
			else
				常规提示(主号id, "#Y/奇经八脉学习失败！因为可用乾元丹不够本次学习")
			end
			return
		end
	end
	常规提示(主号id, "#Y/可用乾元丹不足！奇经八脉学习失败")
	return
end

function 角色处理类:助战添加属性点(数据,主号id)
	if self.潜力<1 then
		 return
	end
	local 属性总和 = 0
	local 监控开关 = false
	for n = 1, #属性类型 do
		if 数据[属性类型[n]] < 0 or 数据[属性类型[n]] > self.潜力 then
			监控开关 = true
		end
		属性总和 = 属性总和 + 数据[属性类型[n]]
	end
	if 属性总和~=qz(属性总和) then
		 监控开关=true
	end
	if 监控开关 then
		__S服务:输出("玩家"..self.数字id.." 助战非法修改数据警告!属性修改")
		常规提示(主号id, "属性异常！")
		return 0
	end
	if 属性总和 <1 then
		常规提示(主号id, "您到底是要添加哪种属性点呢？")
		return 0
	elseif self.潜力 < 属性总和 then
		常规提示(主号id, "你没有那么多可分配的属性点！")
		return 0
	else
		for n = 1, #属性类型 do
			self[属性类型[n]] = self[属性类型[n]] + 数据[属性类型[n]]
		end
		self.潜力 = self.潜力 - 属性总和
		self:刷新信息("0")
	end
end

function 角色处理类:助战升级处理(id)
	if self.等级>=QJDJSX then
		常规提示(id, "#Y/您当前等级已达到服务器上限，等待GM开放更高等级")
		return 0
	end

	if self:助战等级上限(id) then
		if self.当前经验 < self.最大经验 then
			常规提示(id, "你没有那么多的经验")
			return 0
		end
		self.等级 = self.等级 + 1
		self.体质 = self.体质 + 1
		self.魔力 = self.魔力 + 1
		self.力量 = self.力量 + 1
		self.耐力 = self.耐力 + 1
		self.敏捷 = self.敏捷 + 1
		self:增加潜力(5)
		self.最大体力 = self.最大体力 + 10
		self.最大活力 = self.最大活力 + 10
		self.当前经验 = self.当前经验 - self.最大经验
		if not self.历劫.飞升 then
			local 数值 = qz((self.等级-20)/5)
			if 数值 > 20 then 数值 =20 end
			if 数值<0 then 数值 =0 end
			local as = {"攻击修炼", "防御修炼", "法术修炼", "抗法修炼", "猎术修炼"}
			local as1 = {"攻击控制力", "防御控制力", "法术控制力", "抗法控制力"}
			for i = 1, #as do
				self.修炼[as[i]][3] = 数值
			end
			for i = 1, #as1 do
				self.bb修炼[as1[i]][3] = 数值
			end
		end
		self.QYD.可换乾元丹 = self:取可兑换乾元丹()
		--self:刷新信息("0")
		-- self:加点方案刷新()
		--发送数据(id, 10, self:取总数据1())
		地图处理类:加入动画(self.数字id, self.地图数据.编号, self.地图数据.x, self.地图数据.y, "升级")
		常规提示(id, "#Y/升级成功！")
	end
end

function 角色处理类:助战等级上限(id)
	self.初始上限 = 144
	if self.历劫.飞升 == true then
		self.初始上限 = 155
	end
	if self.历劫.渡劫 == true then
		self.初始上限 = 175
	end
	if self.门派 == "无门派" then
		self.初始上限 = 10
	else
		local mz=0
		local jndj = qz(self.等级-self.等级/5-10)
		for i=1,#self.师门技能 do
			if self.师门技能[i].等级>=jndj then
				mz=mz+1
			end
		end
		if mz<5 then
			常规提示(id,"继续升级需要5项师门等级≥"..jndj)
			return false
		end
	end

	if self.初始上限 <= self.等级 then
		常规提示(id, "您的等级已经到达了上限！")
		return false
	else
		return true
	end
end

-- function 角色处理类:助战修炼快捷学习(连接id,id,是否主角)
-- 	local 消耗银子 = 30000
-- 	local 当前储备 = self.储备
-- 	local 助战名称="#W助战：#G"..self.名称.."#W"
-- 	if self.银子 < 消耗银子 and 当前储备 < 消耗银子*2 then
-- 		常规提示(id,助战名称.."当前的银子不够修炼哦")
-- 		return
-- 	end
-- 	local 修炼项目="攻击修炼"

-- 	if 是否主角 then
-- 		修炼项目=self.修炼.当前
-- 		 if self.修炼[修炼项目][1] >= self.修炼[修炼项目][3] then 常规提示(id, 助战名称.."的此项修炼已经达上限") return end
-- 		 if 当前储备 >= 消耗银子*2 then
-- 			self.储备=self.储备-消耗银子*2
-- 			self:日志记录("提升修炼消耗"..(消耗银子*2).."点储备")
-- 			消息提示(id, 助战名称.."失去了"..(消耗银子*2).."两储备")
-- 		else
-- 			self:扣除银子(消耗银子,0,0,"助战点修",1)
-- 		end
-- 		self.修炼[修炼项目][2] = self.修炼[修炼项目][2] + 10
-- 		消息提示(id, format(助战名称.."%s经验增加了%s点", 修炼项目, 10))
-- 		if (self.修炼[修炼项目][2] >= 计算修炼等级经验(self.修炼[修炼项目][1], self.修炼[修炼项目][3])) then
-- 			self.修炼[修炼项目][2] = self.修炼[修炼项目][2] - 计算修炼等级经验(self.修炼[修炼项目][1], self.修炼[修炼项目][3])
-- 			self.修炼[修炼项目][1] = self.修炼[修炼项目][1] + 1
-- 			常规提示(id, format(助战名称.."%s等级提升至%s级", 修炼项目, self.修炼[修炼项目][1]))
-- 		end
-- 	else
-- 		修炼项目=self.bb修炼.当前
-- 		 if self.bb修炼[修炼项目][1] >= self.bb修炼[修炼项目][3] then 常规提示(id, 助战名称.."的此项修炼已经达上限") return end
-- 		 if 当前储备 >= 消耗银子*2 then
-- 			self.储备=self.储备-消耗银子*2
-- 			self:日志记录(助战名称.."提升修炼消耗"..(消耗银子*2).."点储备")
-- 			消息提示(id, 助战名称.."失去了"..(消耗银子*2).."两储备")
-- 		else
-- 			self:扣除银子(消耗银子,0,0,"助战点修",1)
-- 		end
-- 		self.bb修炼[修炼项目][2] = self.bb修炼[修炼项目][2] + 10
-- 		消息提示(id, format(助战名称.."召唤兽%s经验增加了%s点", 修炼项目, 10))
-- 		if (self.bb修炼[修炼项目][2] >= 计算修炼等级经验(self.bb修炼[修炼项目][1], self.bb修炼[修炼项目][3])) then
-- 			self.bb修炼[修炼项目][2] = self.bb修炼[修炼项目][2] - 计算修炼等级经验(self.bb修炼[修炼项目][1], self.bb修炼[修炼项目][3])
-- 			self.bb修炼[修炼项目][1] = self.bb修炼[修炼项目][1] + 1
-- 			常规提示(id, format(助战名称.."召唤兽%s等级提升至%s级", 修炼项目, self.bb修炼[修炼项目][1]))
-- 		end
-- 	end
-- end

function 角色处理类:助战学习门派技能(连接id, id, 编号,主人id,十次)
	local cis=1
	if 十次 then
	    cis=10
	end
	for i=1,cis do
		if self.师门技能[编号] == nil then
			常规提示(主人id, "这个助战没有这样的技能")
			break
		elseif self.师门技能[编号].等级 >= self.等级 + 10 or self.师门技能[编号].等级 >= 180 then
			if self.师门技能[编号].等级 >= self.等级 + 10 then
				常规提示(主人id, "门派技能不能超过角色等级+10")
			elseif self.师门技能[编号].等级 >= 180 then
				常规提示(主人id, "门派技能不能超180级")
			end
			break
		elseif self.师门技能[编号].等级>=self.师门技能[self:取门派基础技能(id,self.门派).编号].等级 and 编号 ~= self:取门派基础技能(id,self.门派).编号 then
			常规提示(主人id,"请先提升门派基础技能"..self:取门派基础技能(id,self.门派).基础技能)
			break
		else
			--计算消耗的经验 金钱
			local 临时消耗 = self:师门技能消耗(self.师门技能[编号].等级 + 1)
			if self.当前经验 < 临时消耗.经验 then
				常规提示(主人id, "这个助战没有那么多的经验")
				break
			end
			local 提示 = ""
			if self.储备 >= 临时消耗.金钱 then
				self.储备 = self.储备 - 临时消耗.金钱
			elseif self.银子 >= 临时消耗.金钱 then
				self.银子 = self.银子 - 临时消耗.金钱
			elseif self.储备 + self.银子 >= 临时消耗.金钱 then
				local x临时消耗 = 临时消耗.金钱 - self.储备
				self.银子 = self.银子 - x临时消耗
				self.储备 = 0
			elseif self.储备 + self.银子 + self.存银 >= 临时消耗.金钱 then
				local x临时消耗 = 临时消耗.金钱 - (self.储备 + self.银子)
				self.银子 = 0
				self.储备 = 0
				self.存银 = self.存银 - x临时消耗
			else
				常规提示(主人id, "这个助战没有那么多的银子")
				break
			end
			self.当前经验 = self.当前经验 - 临时消耗.经验
			发送数据(连接id, 38, {内容 = "助战消耗"..临时消耗.金钱.."点银两" .. "\n助战消耗了"..临时消耗.经验.."点经验"})
			self:日志记录("学习师门技能["..self.师门技能[编号].名称.."]消耗"..临时消耗.金钱.."点金钱和 "..临时消耗.经验.."点经验")
			self:银子记录()
			self.师门技能[编号].等级 = self.师门技能[编号].等级 + 1
			self:升级技能(self.师门技能[编号],self.奇经八脉["当前流派"])
		end
	end
end

function 角色处理类:加载助战属性()
	local fhsj = {}
	for n, v in pairs(self) do
		if type(n) ~= "function" and n ~= "运行父函数" and n ~= "存档数据" and n ~= "日志内容" and n ~= "五宝数据" and n ~= "在线时间" and n ~= "技能属性" then
			if type(n) == "table" then
				fhsj[n] = table.copy((v))
			else
				fhsj[n] = v
			end
		end
	end
	return {角色 = fhsj , bb基础属性 =玩家数据[self.数字id].召唤兽:索取助战bb基础信息() , 装备 = self:取装备数据(), 灵饰 = self:取灵饰数据() }--
end
-------------------------------------------------------------------------
-- function 角色处理类:取上古灵符属性(装备)
--   local zb = {伤害=0,灵力=0,防御=0,气血=0,魔法=0,命中=0,躲避=0,速度=0,愤怒=0,法术暴击等级=0,物理暴击等级=0,治疗能力=0,封印命中等级=0,体质=0,力量=0,耐力=0,魔力=0,敏捷=0,物伤结果=0,固定伤害=0,法伤结果=0,气血回复效果=0,法术伤害结果=0,法术防御=0,法术伤害=0}
--   if 装备.上古残符 ~= nil then
--     local 额外数值=0
--     if 装备.五行==装备.上古残符.五行 then
--       额外数值=math.floor(装备.上古残符.数值*0.5)
--     end
--     if 装备.分类==1 then
--     zb.法术防御=zb.法术防御+装备.上古残符.数值+额外数值
--     elseif 装备.分类==2 then
--     zb.灵力=zb.灵力+装备.上古残符.数值+额外数值
--     elseif 装备.分类==3 or 装备.分类==30  then
--     zb.伤害=zb.伤害+装备.上古残符.数值+额外数值
--     elseif 装备.分类==4 then
--     zb.防御=zb.防御+装备.上古残符.数值+额外数值
--     elseif 装备.分类==5 then
--     zb.气血=zb.气血+装备.上古残符.数值+额外数值
--     elseif 装备.分类==6 then
--     zb.速度=zb.速度+装备.上古残符.数值+额外数值
--     end
--   end
--   return zb
-- end

------------------------------------------------------------------------------------------------
function 角色处理类:助战切换经脉流派(id,主号id,新流派,旧流派)
	local go = false
	for i=1,3 do
		if self.奇经八脉[i]==新流派 then
			go=true
		end
	end
	if go then
		 self.奇经八脉 = {}
		 self.奇经八脉 = 取经脉流派(self.门派)
		self.奇经八脉.开启奇经八脉 = true
		self.奇经八脉.技能树 = {1, 2, 3}
		self.奇经八脉["当前流派"]=新流派
		self.QYD.可用乾元丹 = self.QYD.已换乾元丹 + self.QYD.额外乾元丹
		self.QYD.已用乾元丹 = 0
		--新增师门技能
		self:切换师门技能(id,新流派,旧流派)
		常规提示(主号id, "切换经脉流派成功！")
	else
		常规提示(主号id, "助战数据异常！")
	end
end

function 角色处理类:取主界面基础信息(主号id)
	local 取在线状态="在  线"
	if 玩家数据[主号id].队伍~=0 and 玩家数据[主号id].队伍==主号id and 玩家数据[self.数字id].队伍==主号id then
		取在线状态="队伍中"
	elseif 玩家数据[self.数字id].摊位数据 then
		取在线状态="摆摊中"
	elseif 玩家数据[self.数字id].zhandou~=0 then
		取在线状态="战斗中"
	elseif  玩家数据[self.数字id].guanzhan~=0 then
		取在线状态="观战中"
	end
	local 发送数据 = {
		名称=self.名称,
		等级=self.等级,
		炫彩=self.炫彩,
		炫彩组=self.炫彩组,
		染色方案=self.染色方案,
		染色组=self.染色组,
		模型=self.模型,
		门派=self.门派,
		id=self.数字id,
		在线=取在线状态,
		变身数据 = self.变身数据,
		锦衣={},
	}
	if self.锦衣 then
		for k, v in pairs(self.锦衣) do
			if 玩家数据[self.数字id].道具.数据[self.锦衣[k]] ~= nil then
				发送数据.锦衣[k] = 玩家数据[self.数字id].道具.数据[self.锦衣[k]].名称
			end
		end
	end
	if self.装备[3] then
		local wq=玩家数据[self.数字id].道具.数据[self.装备[3]]
		发送数据.装备 = {子类=wq.子类,级别限制=wq.级别限制,名称=wq.名称}--table.copy((玩家数据[self.数字id].道具.数据[self.装备[3]]))
	end
	return 发送数据
end

return 角色处理类
