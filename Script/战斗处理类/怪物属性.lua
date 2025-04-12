-- @Author: baidwwy
-- @Date:   2024-11-14 12:45:49
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-04-12 00:48:19
-- @Author: baidwwy
-- @Date:   2024-08-21 11:47:39
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-20 16:49:51
local 怪物属性 = class()
local jhf = string.format
local random = math.random
local qz=math.floor
local sj = 取随机数
local sjlx={"物理","法系","物法"}
local 战斗单位={}
local sx
local 整体加强A = 1.2  --所有怪物增加60%气血
local 整体加强B = 1   --所有怪物增加10%伤害
local 整体加强C = 1  --所有怪物增加10%法伤
local 整体加强D = 1   --所有怪物增加10%速度
local 血量削弱1 = 0.7
local 法伤削弱 = 0.7
local 速度削弱 = 0.7

function 取150角色武器(js)
	 local WQ={}
	 WQ["剑侠客"]={武器="霜冷九州",级别=150,子类=3}
	 WQ["逍遥生"]={武器="浩气长舒",级别=150,子类=7}
	 WQ["飞燕女"]={武器="无关风月",级别=150,子类=11}
	 WQ["英女侠"]={武器="紫电青霜",级别=150,子类=4}
	 WQ["巫蛮儿"]={武器="云雷万里",级别=150,子类=15}
	 WQ["狐美人"]={武器="牧云清歌",级别=150,子类=10}
	 WQ["巨魔王"]={武器="业火三灾",级别=150,子类=12}
	 WQ["虎头怪"]={武器="碧血干戚",级别=150,子类=2}
	 WQ["骨精灵"]={武器="忘川三途",级别=150,子类=6}
	 WQ["杀破狼"]={武器="九霄风雷",级别=150,子类=14}
	 WQ["舞天姬"]={武器="揽月摘星",级别=150,子类=5}
	 WQ["玄彩娥"]={武器="丝萝乔木",级别=150,子类=8}
	 WQ["羽灵神"]={武器="碧海潮生",级别=150,子类=13}
	 WQ["神天兵"]={武器="狂澜碎岳",级别=150,子类=9}
	 WQ["龙太子"]={武器="天龙破城",级别=150,子类=1}
	 WQ["鬼潇潇"]={武器="忘川三途",级别=150,子类=6}
	 WQ["桃夭夭"]={武器="夭桃秾李",级别=150,子类=18}
	 WQ["偃无师"]={武器="百辟镇魂",级别=150,子类=16}
	 return WQ[js]
end

function 取招式特效(mp)
	 local lssj = {
		  大唐官府 = {"横扫千军"},
		  化生寺 = {"唧唧歪歪","金刚护法","推气过宫","金刚护体"},
		  女儿村 = {"似玉生香"},
		  方寸山 = {"失心符","五雷咒"},
		  天宫 = {"天雷斩","雷霆万钧"},
		  普陀山 = {"普渡众生"},
		  龙宫 = {"龙卷雨击"},
		  五庄观 = {"日月乾坤"},
		  狮驼岭 = {"鹰击"},
		  魔王寨 = {"飞砂走石","三昧真火","牛劲","风云变色"},
		  阴曹地府 = {"阎罗令"},
		  盘丝洞 = {"含情脉脉"},
		  神木林 = {"落叶萧萧"},
		  凌波城 = {"翻江搅海"},
		  无底洞 = {"地涌金莲"},
		  花果山 = {nil},
	 }
	 local fhsj = {}
	 if lssj[mp] ~= nil then
		  for i=1,#lssj[mp] do
				fhsj[lssj[mp][i]] = true
		  end
	 end
	 return fhsj
end

Qu角色属性={
	 飞燕女 = {染色方案=3,门派={"大唐官府","方寸山","女儿村","神木林"}},
	 英女侠 = {染色方案=4,门派={"大唐官府","方寸山","女儿村","神木林"}},
	 巫蛮儿 = {染色方案=201,门派={"大唐官府","方寸山","女儿村","神木林"}},
	 逍遥生 = {染色方案=1,门派={"大唐官府","化生寺","方寸山","神木林"}},
	 剑侠客 = {染色方案=2,门派={"大唐官府","化生寺","方寸山","神木林"}},
	 偃无师 = {染色方案=205,门派={"大唐官府","化生寺","方寸山","神木林"}},
	 鬼潇潇 = {染色方案=206,门派={"盘丝洞","魔王寨","阴曹地府","无底洞"}},
	 狐美人 = {染色方案=7,门派={"盘丝洞","魔王寨","阴曹地府","无底洞"}},
	 骨精灵 = {染色方案=8,门派={"盘丝洞","魔王寨","阴曹地府","无底洞"}},
	 杀破狼 = {染色方案=202,门派={"魔王寨","狮驼岭"}},
	 巨魔王 = {染色方案=5,门派={"魔王寨","狮驼岭"}},
	 虎头怪 = {染色方案=6,门派={"魔王寨","狮驼岭"}},
	 舞天姬 = {染色方案=11,门派={"天宫","普陀山","凌波城","龙宫"}},
	 玄彩娥 = {染色方案=12,门派={"天宫","普陀山","凌波城","龙宫"}},
	 桃夭夭 = {染色方案=204,门派={"天宫","普陀山","凌波城","龙宫"}},
	 羽灵神 = {染色方案=203,门派={"凌波城","龙宫"}},
	 神天兵 = {染色方案=9,门派={"凌波城","龙宫"}},
	 龙太子 = {染色方案=10,门派={"凌波城","龙宫"}},
}

Qu随机角色={"剑侠客","逍遥生","飞燕女","英女侠","巫蛮儿","神天兵","龙太子","舞天姬","玄彩娥","虎头怪","巨魔王","狐美人","骨精灵","偃无师","鬼潇潇","桃夭夭"}
Qunandu={}
function 怪物属性:初始化()
	 self.数据={
		  门派={"大唐官府","化生寺","方寸山","女儿村","神木林","盘丝洞","魔王寨","狮驼岭","阴曹地府","无底洞","天宫","普陀山","凌波城","五庄观","龙宫"}, --,"花果山"
		  化生寺={"法系","辅助","辅助"},
		  方寸山={"法系","封系","封系"},
		  女儿村={"固伤","物理","封系","封系"},
		  盘丝洞={"物理","封系","封系"},
		  阴曹地府={"固伤","辅助","物理","物理"},
		  无底洞={"辅助","固伤"},
		  天宫={"封系","物理","法系","法系"},
		  普陀山={"固伤","辅助"},
		  五庄观={"辅助","物理"},
		  神木林={"法系"},
		  魔王寨={"法系"},
		  龙宫={"法系"},
		  大唐官府={"物理"},
		  狮驼岭={"物理"},
		  凌波城={"物理"},
	 }
	 self.GUAIWU = {}
	 self.GUAIWU["111111"]=function(任务id,玩家id,序号)
		  return self:伤害测试(任务id,玩家id,序号)
	 end
	 self.GUAIWU["121111"]=function(任务id,玩家id,序号)
		  return self:安卓伤害测试(任务id,玩家id,序号)
	 end
	 self.GUAIWU["111112"]=function(任务id,玩家id,序号)
		  return self:执法天兵(任务id,玩家id,序号)
	 end
	 self.GUAIWU["111113"]=function(任务id,玩家id,序号)
		  return self:巧智魔1(任务id,玩家id,序号)
	 end
	  Qunandu[134871]="沉默分身"
	 self.GUAIWU["134871"]=function(任务id,玩家id,序号)
		  return self:沉默分身信息(任务id,玩家id,序号)
	 end
	 Qunandu[111113]="铃铛：小怪"
	 self.GUAIWU["111114"]=function(任务id,玩家id,序号)
		  return self:巧智魔2(任务id,玩家id,序号)
	 end
	  Qunandu[111114]="铃铛：小怪"
	 self.GUAIWU["111115"]=function(任务id,玩家id,序号)
		  return self:梦魇魔(任务id,玩家id,序号)
	 end
	 Qunandu[111115]="铃铛：小怪"
	 self.GUAIWU["111116"]=function(任务id,玩家id,序号)
		  return self:招魂帖梦魇魔(任务id,玩家id,序号)
	 end
	 Qunandu[111116]="铃铛：小怪"
	 self.GUAIWU["111117"]=function(任务id,玩家id,序号)
		  return self:怯弱妖(任务id,玩家id,序号)
	 end
	 Qunandu[111117]="铃铛：小怪"
	 self.GUAIWU["111118"]=function(任务id,玩家id,序号)
		  return self:迷幻妖(任务id,玩家id,序号)
	 end
	 Qunandu[111118]="铃铛：小怪"
	 self.GUAIWU["111119"]=function(任务id,玩家id,序号)
		  return self:冥想幽鬼(任务id,玩家id,序号)
	 end
	 Qunandu[111119]="铃铛：小怪"
	 self.GUAIWU["111120"]=function(任务id,玩家id,序号)
		  return self:勾魂幽灵(任务id,玩家id,序号)
	 end
	 Qunandu[111120]="铃铛：小怪"
	 self.GUAIWU["111121"]=function(任务id,玩家id,序号)
		  return self:机械游魂(任务id,玩家id,序号)
	 end
	 Qunandu[111121]="铃铛：小怪"
	 self.GUAIWU["111122"]=function(任务id,玩家id,序号)
		  return self:夜叉(任务id,玩家id,序号)
	 end
	 Qunandu[111122]="铃铛：小怪"
	 self.GUAIWU["111123"]=function(任务id,玩家id,序号)
		  return self:千年魔灵(任务id,玩家id,序号)
	 end
	 Qunandu[111123]="铃铛：千年魔灵"
	 self.GUAIWU["111124"]=function(任务id,玩家id,序号)
		  return self:万年魔灵(任务id,玩家id,序号)
	 end
	  Qunandu[111124]="铃铛：万年魔灵"
	 self.GUAIWU["111125"]=function(任务id,玩家id,序号)
		  return self:地煞星(任务id,玩家id,序号)
	 end

	 self.GUAIWU["111126"]=function(任务id,玩家id,序号)
		  return self:六星地煞(任务id,玩家id,序号)
	 end
	  self.GUAIWU["111127"]=function(任务id,玩家id,序号)
		  return self:天罡星1到5星(任务id,玩家id,序号)
	 end
	   self.GUAIWU["155558"]=function(任务id,玩家id,序号)
		   return self:六星天罡(任务id,玩家id,序号)
	  end
	 --  self.GUAIWU["111129"]=function(任务id,玩家id,序号)
		--   return self:天罡星黄真心魔(任务id,玩家id,序号)
	 -- end
	 self.GUAIWU["110000"]=function(任务id,玩家id,序号)
		  return self:桃源村一别野猪(任务id,玩家id,序号)
	 end
	 self.GUAIWU["110001"]=function(任务id,玩家id,序号)
		  return self:桃源村一别狸(任务id,玩家id,序号)
	 end
	 ---------------彩虹争霸
	 self.GUAIWU["130002"]=function(任务id,玩家id,序号)
		  return self:女儿村一(任务id,玩家id,序号)
	 end
	 Qunandu[130002]="彩虹：场景小怪"

	 self.GUAIWU["130003"]=function(任务id,玩家id,序号)
		  return self:女儿村二(任务id,玩家id,序号)
	 end
	 Qunandu[130003]="彩虹：场景小怪"

	 self.GUAIWU["130004"]=function(任务id,玩家id,序号)
		  return self:狮驼岭一(任务id,玩家id,序号)
	 end
	 Qunandu[130004]="彩虹：场景小怪"

	 self.GUAIWU["130005"]=function(任务id,玩家id,序号)
		  return self:狮驼岭二(任务id,玩家id,序号)
	 end
	 Qunandu[130005]="彩虹：场景小怪"

	 self.GUAIWU["130006"]=function(任务id,玩家id,序号)
		  return self:墨家村一(任务id,玩家id,序号)
	 end
	 Qunandu[130006]="彩虹：场景小怪"

	 self.GUAIWU["130007"]=function(任务id,玩家id,序号)
		  return self:墨家村二(任务id,玩家id,序号)
	 end
	 Qunandu[130007]="彩虹：场景小怪"

	 self.GUAIWU["130008"]=function(任务id,玩家id,序号)
		  return self:花果山一(任务id,玩家id,序号)
	 end
	 Qunandu[130008]="彩虹：场景小怪"
	 self.GUAIWU["130009"]=function(任务id,玩家id,序号)
		  return self:花果山二(任务id,玩家id,序号)
	 end
	 Qunandu[130009]="彩虹：场景小怪"

	 self.GUAIWU["130010"]=function(任务id,玩家id,序号)
		  return self:龙宫一(任务id,玩家id,序号)
	 end
	 Qunandu[130010]="彩虹：场景小怪"

	 self.GUAIWU["130011"]=function(任务id,玩家id,序号)
		  return self:龙宫二(任务id,玩家id,序号)
	 end
	 Qunandu[130011]="彩虹：场景小怪"

	 self.GUAIWU["130012"]=function(任务id,玩家id,序号)
		  return self:太岁山一(任务id,玩家id,序号)
	 end
	 Qunandu[130012]="彩虹：场景小怪"

	 self.GUAIWU["130013"]=function(任务id,玩家id,序号)
		  return self:太岁山二(任务id,玩家id,序号)
	 end
	 Qunandu[130013]="彩虹：场景小怪"

	 self.GUAIWU["130014"]=function(任务id,玩家id,序号)
		  return self:月宫一(任务id,玩家id,序号)
	 end
	 Qunandu[130014]="彩虹：场景小怪"

	 self.GUAIWU["130015"]=function(任务id,玩家id,序号)
		  return self:月宫二(任务id,玩家id,序号)
	 end
	 Qunandu[130015]="彩虹：场景小怪"

	 self.GUAIWU["130016"]=function(任务id,玩家id,序号)
		  return self:泡泡一(任务id,玩家id,序号)
	 end
	 Qunandu[130016]="彩虹：仙境泡泡"

	 self.GUAIWU["130017"]=function(任务id,玩家id,序号)
		  return self:泡泡二(任务id,玩家id,序号)
	 end
	 Qunandu[130017]="彩虹：仙境泡泡"

	 self.GUAIWU["130018"]=function(任务id,玩家id,序号)
		  return self:泡泡三(任务id,玩家id,序号)
	 end
	 Qunandu[130018]="彩虹：仙境泡泡"

	 self.GUAIWU["130019"]=function(任务id,玩家id,序号)
		  return self:泡泡四(任务id,玩家id,序号)
	 end
	 Qunandu[130019]="彩虹：仙境泡泡"

	 self.GUAIWU["130020"]=function(任务id,玩家id,序号)
		  return self:泡泡五(任务id,玩家id,序号)
	 end
	 Qunandu[130020]="彩虹：仙境泡泡"

	 self.GUAIWU["130021"]=function(任务id,玩家id,序号)
		  return self:泡泡六(任务id,玩家id,序号)
	 end
	 Qunandu[130021]="彩虹：仙境泡泡"

	 self.GUAIWU["130022"]=function(任务id,玩家id,序号)
		  return self:泡泡七(任务id,玩家id,序号)
	 end
	 Qunandu[130022]="彩虹：仙境泡泡"

	 self.GUAIWU["130023"]=function(任务id,玩家id,序号)
		  return self:红境传送大使(任务id,玩家id,序号)
	 end
	 Qunandu[130023]="彩虹：传送大使"

	 self.GUAIWU["130024"]=function(任务id,玩家id,序号)
		  return self:橙境传送大使(任务id,玩家id,序号)
	 end
	 Qunandu[130024]="彩虹：传送大使"

	 self.GUAIWU["130025"]=function(任务id,玩家id,序号)
		  return self:黄境传送大使(任务id,玩家id,序号)
	 end
	 Qunandu[130025]="彩虹：传送大使"

	 self.GUAIWU["130026"]=function(任务id,玩家id,序号)
		  return self:绿境传送大使(任务id,玩家id,序号)
	 end
	 Qunandu[130026]="彩虹：传送大使"

	 self.GUAIWU["130027"]=function(任务id,玩家id,序号)
		  return self:蓝境传送大使(任务id,玩家id,序号)
	 end
	 Qunandu[130027]="彩虹：传送大使"

	 self.GUAIWU["130028"]=function(任务id,玩家id,序号)
		  return self:靛境传送大使(任务id,玩家id,序号)
	 end
	 Qunandu[130028]="彩虹：传送大使"

	 self.GUAIWU["130029"]=function(任务id,玩家id,序号)
		  return self:紫境传送大使(任务id,玩家id,序号)
	 end
	 Qunandu[130029]="彩虹：传送大使"

	 -----------地宫
	 self.GUAIWU["130030"]=function(任务id,玩家id,序号)
		  return self:地宫一层boss(任务id,玩家id,序号)
	 end
	 self.GUAIWU["130031"]=function(任务id,玩家id,序号)
		  return self:地宫二层boss(任务id,玩家id,序号)
	 end
	 self.GUAIWU["130032"]=function(任务id,玩家id,序号)
		  return self:地宫三层boss(任务id,玩家id,序号)
	 end
	 self.GUAIWU["130033"]=function(任务id,玩家id,序号)
		  return self:地宫四层boss(任务id,玩家id,序号)
	 end
	 self.GUAIWU["130034"]=function(任务id,玩家id,序号)
		  return self:地宫五层boss(任务id,玩家id,序号)
	 end
	 self.GUAIWU["130035"]=function(任务id,玩家id,序号)
		  return self:地宫六层boss(任务id,玩家id,序号)
	 end
	 ---------文墨
	 self.GUAIWU["130036"]=function(任务id,玩家id,序号)
		  return self:文墨场景巡逻(任务id,玩家id,序号)
	 end
	 Qunandu[130036]="文韵墨香"
	 self.GUAIWU["130037"]=function(任务id,玩家id,序号)
		  return self:文墨护送使者(任务id,玩家id,序号)
	 end
	 Qunandu[130037]="文韵墨香"
	 self.GUAIWU["130038"]=function(任务id,玩家id,序号)
		  return self:文墨取木材(任务id,玩家id,序号)
	 end
	 Qunandu[130038]="文韵墨香"
	 self.GUAIWU["130039"]=function(任务id,玩家id,序号)
		  return self:文墨写字(任务id,玩家id,序号)
	 end
	 Qunandu[130039]="文韵墨香"
	 self.GUAIWU["130040"]=function(任务id,玩家id,序号)
		  return self:文墨门派送信(任务id,玩家id,序号)
	 end
	 Qunandu[130040]="文韵墨香"
	 ----------天降辰星
	 self.GUAIWU["130041"]=function(任务id,玩家id,序号)
		  return self:天降辰星子鼠(任务id,玩家id,序号)
	 end
	 Qunandu[130041]="天降辰星"

	 self.GUAIWU["130042"]=function(任务id,玩家id,序号)
		  return self:天降辰星丑牛(任务id,玩家id,序号)
	 end
	 Qunandu[130042]="天降辰星"

	 self.GUAIWU["130043"]=function(任务id,玩家id,序号)
		  return self:天降辰星寅虎(任务id,玩家id,序号)
	 end
	 Qunandu[130043]="天降辰星"

	 self.GUAIWU["130044"]=function(任务id,玩家id,序号)
		  return self:天降辰星卯兔(任务id,玩家id,序号)
	 end
	 Qunandu[130044]="天降辰星"

	 self.GUAIWU["130045"]=function(任务id,玩家id,序号)
		  return self:天降辰星辰龙(任务id,玩家id,序号)
	 end
	 Qunandu[130045]="天降辰星"

	 self.GUAIWU["130046"]=function(任务id,玩家id,序号)
		  return self:天降辰星巳蛇(任务id,玩家id,序号)
	 end
	 Qunandu[130046]="天降辰星"

	 self.GUAIWU["130047"]=function(任务id,玩家id,序号)
		  return self:天降辰星午马(任务id,玩家id,序号)
	 end
	 Qunandu[130047]="天降辰星"

	 self.GUAIWU["130048"]=function(任务id,玩家id,序号)
		  return self:天降辰星未羊(任务id,玩家id,序号)
	 end
	 Qunandu[130048]="天降辰星"

	 self.GUAIWU["130049"]=function(任务id,玩家id,序号)
		  return self:天降辰星申猴(任务id,玩家id,序号)
	 end
	 Qunandu[130049]="天降辰星"

	 self.GUAIWU["130050"]=function(任务id,玩家id,序号)
		  return self:天降辰星酉鸡(任务id,玩家id,序号)
	 end
	 Qunandu[130050]="天降辰星"

	 self.GUAIWU["130051"]=function(任务id,玩家id,序号)
		  return self:天降辰星戌犬(任务id,玩家id,序号)
	 end
	 Qunandu[130051]="天降辰星"

	 self.GUAIWU["130052"]=function(任务id,玩家id,序号)
		  return self:天降辰星亥猪(任务id,玩家id,序号)
	 end
	 Qunandu[130052]="天降辰星"

	 --------帮派迷宫
	 self.GUAIWU["130053"]=function(任务id,玩家id,序号)
		  return self:入侵者(任务id,玩家id,序号)
	 end
	 self.GUAIWU["130054"]=function(任务id,玩家id,序号)
		  return self:秽气妖(任务id,玩家id,序号)
	 end
	 self.GUAIWU["130055"]=function(任务id,玩家id,序号)
		  return self:天才阵眼(任务id,玩家id,序号)
	 end
	 self.GUAIWU["130056"]=function(任务id,玩家id,序号)
		  return self:地才阵眼(任务id,玩家id,序号)
	 end
	 self.GUAIWU["130057"]=function(任务id,玩家id,序号)
		  return self:人才阵眼(任务id,玩家id,序号)
	 end
	 self.GUAIWU["130058"]=function(任务id,玩家id,序号)
		  return self:天才(任务id,玩家id,序号)
	 end
	 self.GUAIWU["130059"]=function(任务id,玩家id,序号)
		  return self:地才(任务id,玩家id,序号)
	 end
	 self.GUAIWU["130060"]=function(任务id,玩家id,序号)
		  return self:人才(任务id,玩家id,序号)
	 end
	 self.GUAIWU["130061"]=function(任务id,玩家id,序号)
		  return self:劳释道人(任务id,玩家id,序号)
	 end
	 self.GUAIWU["130062"]=function(任务id,玩家id,序号)
		  return self:秽气源头(任务id,玩家id,序号)
	 end
	 self.GUAIWU["130063"]=function(任务id,玩家id,序号)
		  return self:金龙(任务id,玩家id,序号)
	 end
	 -----------投放怪
	 self.GUAIWU["130066"]=function(任务id,玩家id,序号)
		  return self:投放怪_小钻风(任务id,玩家id,序号)
	 end
	 Qunandu[130066]="投放怪：巡山小妖"

	 self.GUAIWU["130067"]=function(任务id,玩家id,序号)
		  return self:投放怪_奔波儿灞(任务id,玩家id,序号)
	 end
	 Qunandu[130067]="投放怪：巡山小妖"

	 self.GUAIWU["130068"]=function(任务id,玩家id,序号)
		  return self:投放怪_其它小怪(任务id,玩家id,序号)
	 end
	 Qunandu[130068]="投放怪：巡山小妖"

	 self.GUAIWU["130072"]=function(任务id,玩家id,序号)
		  return self:投放怪_白骨精(任务id,玩家id,序号)
	 end
	 Qunandu[130072]="投放怪：白骨精"

	 self.GUAIWU["130073"]=function(任务id,玩家id,序号)
		  return self:投放怪_大大王(任务id,玩家id,序号)
	 end
	 Qunandu[130073]="投放怪：狮驼国"

	 self.GUAIWU["130074"]=function(任务id,玩家id,序号)
		  return self:投放怪_二大王(任务id,玩家id,序号)
	 end
	 Qunandu[130074]="投放怪：狮驼国"

	 self.GUAIWU["130075"]=function(任务id,玩家id,序号)
		  return self:投放怪_三大王(任务id,玩家id,序号)
	 end
	 Qunandu[130075]="投放怪：狮驼国"

	 self.GUAIWU["130076"]=function(任务id,玩家id,序号)
		  return self:投放怪_冒牌小白龙(任务id,玩家id,序号)
	 end
	 Qunandu[130076]="冒牌小白龙"

	 self.GUAIWU["130077"]=function(任务id,玩家id,序号)
		  return self:投放怪_冒牌沙僧(任务id,玩家id,序号)
	 end
	 Qunandu[130077]="冒牌沙僧"

	 self.GUAIWU["130078"]=function(任务id,玩家id,序号)
		  return self:投放怪_冒牌猪八戒(任务id,玩家id,序号)
	 end
	 Qunandu[130078]="冒牌猪八戒"

	 self.GUAIWU["130079"]=function(任务id,玩家id,序号)
		  return self:投放怪_冒牌大圣(任务id,玩家id,序号)
	 end
	 Qunandu[130079]="冒牌大圣"

	 self.GUAIWU["130080"]=function(任务id,玩家id,序号)
		  return self:投放怪_冒牌唐僧(任务id,玩家id,序号)
	 end
	 Qunandu[130080]="冒牌唐僧"

	self.GUAIWU["130081"]=function(任务id,玩家id,序号)
		  return self:投放怪_六耳猕猴(任务id,玩家id,序号)
	 end
	 Qunandu[130081]="六耳猕猴"

	self.GUAIWU["130082"]=function(任务id,玩家id,序号)
		  return self:投放怪_是俺老孙(任务id,玩家id,序号)
	 end
	 Qunandu[130082]="是俺老孙"
	 --------
	self.GUAIWU["100135"]=function(任务id,玩家id,序号)
		  return self:梦魇夜叉(任务id,玩家id,序号)
	 end
	 self.GUAIWU["100136"]=function(任务id,玩家id,序号)
		  return self:新手活动怪(任务id,玩家id,序号)
	 end
	self.GUAIWU["140101"]=function(任务id,玩家id,序号) --龙族
	 	  return self:龙族(任务id,玩家id,序号)
	 end
	self.GUAIWU["140102"]=function(任务id,玩家id,序号) --知了先锋
		  return self:知了先锋(任务id,玩家id,序号)
	 end
	 ------五更寒
	 self.GUAIWU["190001"]=function(任务id,玩家id,序号)
		  return self:五更寒慧明长老(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190002"]=function(任务id,玩家id,序号)
		  return self:五更寒小鱼儿(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190003"]=function(任务id,玩家id,序号)
		  return self:五更寒魔化村民赌徒(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190004"]=function(任务id,玩家id,序号)
		  return self:五更寒魔化村民山贼(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190005"]=function(任务id,玩家id,序号)
		  return self:五更寒魔化村民夜叉(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190006"]=function(任务id,玩家id,序号)
		  return self:五更寒魔化村长(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190007"]=function(任务id,玩家id,序号)
		  return self:五更寒八足海妖(任务id,玩家id,序号)
	 end
	 ------一斛珠
	 self.GUAIWU["190101"]=function(任务id,玩家id,序号)
		  return self:一斛珠鸾儿(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190102"]=function(任务id,玩家id,序号)
		  return self:一斛珠叶夫人(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190103"]=function(任务id,玩家id,序号)
		  return self:一斛珠官兵(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190104"]=function(任务id,玩家id,序号)
		  return self:一斛珠新郎沈唐(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190105"]=function(任务id,玩家id,序号)
		  return self:一斛珠夜影迷踪(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190106"]=function(任务id,玩家id,序号)
		  return self:一斛珠沈唐(任务id,玩家id,序号)
	 end
	 ---双城记
	 self.GUAIWU["190301"]=function(任务id,玩家id,序号)
		  return self:双城记黑衣人(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190302"]=function(任务id,玩家id,序号)
		  return self:双城记木头人(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190303"]=function(任务id,玩家id,序号)
		  return self:双城记武教头(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190304"]=function(任务id,玩家id,序号)
		  return self:双城记凌云瀚(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190305"]=function(任务id,玩家id,序号)
		  return self:双城记算筹子(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190306"]=function(任务id,玩家id,序号)
		  return self:双城记玄机之数(任务id,玩家id,序号)
	 end
    self.GUAIWU["190307"]=function(任务id,玩家id,序号)
		  return self:双城记嗜血恶兽(任务id,玩家id,序号)
	 end
    self.GUAIWU["190308"]=function(任务id,玩家id,序号)
		  return self:双城记邪影僵尸(任务id,玩家id,序号)
	 end
    self.GUAIWU["190309"]=function(任务id,玩家id,序号)
		  return self:双城记宝库之门(任务id,玩家id,序号)
	 end
	self.GUAIWU["100011"]=function(任务id,玩家id,序号)
		  return self:取门派闯关信息(任务id,玩家id,序号)
	 end
	Qunandu[100011]="门派闯关"
	 self.GUAIWU["100012"]=function(任务id,玩家id,序号)
		  return self:取游泳信息(任务id,玩家id,序号)
	 end
	Qunandu[101012]="游泳比赛"
	 self.GUAIWU["101012"]=function(任务id,玩家id,序号)
		  return self:取镖王信息(任务id,玩家id,序号)
	 end
	Qunandu[101012]="镖王活动"
	 self.GUAIWU["100028"]=function(任务id,玩家id,序号)
		  return self:乌鸡芭蕉木妖(任务id,玩家id,序号)
	 end
	 self.GUAIWU["100029"]=function(任务id,玩家id,序号)
		  return self:乌鸡三妖(任务id,玩家id,序号)
	 end
	 self.GUAIWU["100030"]=function(任务id,玩家id,序号)
		  return self:乌鸡鬼祟小怪(任务id,玩家id,序号)
	 end
	 self.GUAIWU["100031"]=function(任务id,玩家id,序号)
		  return self:乌鸡国王(任务id,玩家id,序号)
	 end
	 self.GUAIWU["100400"]=function(任务id,玩家id,序号)
		  return self:取副本万圣公主信息(任务id,玩家id,序号)
	 end
	 self.GUAIWU["100401"]=function(任务id,玩家id,序号)
		  return self:取副本九头虫信息(任务id,玩家id,序号)
	 end
	 self.GUAIWU["100402"]=function(任务id,玩家id,序号)
		  return self:取副本幽颜信息(任务id,玩家id,序号)
	 end
	 self.GUAIWU["100403"]=function(任务id,玩家id,序号)
		  return self:取副本天将信息(任务id,玩家id,序号)
	 end
	 self.GUAIWU["100404"]=function(任务id,玩家id,序号)
		  return self:取副本相柳信息(任务id,玩家id,序号)
	 end
	 self.GUAIWU["110005"]=function(任务id,玩家id,序号)
		  return self:白鹿精(任务id,玩家id,序号)
	 end
	 self.GUAIWU["110006"]=function(任务id,玩家id,序号)
		  return self:玉面狐狸(任务id,玩家id,序号)
	 end
	 self.GUAIWU["110007"]=function(任务id,玩家id,序号)
		  return self:酒肉和尚1(任务id,玩家id,序号)
	 end
	 self.GUAIWU["110008"]=function(任务id,玩家id,序号)
		  return self:白琉璃(任务id,玩家id,序号)
	 end
	 self.GUAIWU["110009"]=function(任务id,玩家id,序号)
		  return self:酒肉和尚2(任务id,玩家id,序号)
	 end
	 self.GUAIWU["110010"]=function(任务id,玩家id,序号)
		  return self:幽冥鬼(任务id,玩家id,序号)
	 end
	 self.GUAIWU["110011"]=function(任务id,玩家id,序号)
		  return self:衙门守卫(任务id,玩家id,序号)
	 end
	 self.GUAIWU["110012"]=function(任务id,玩家id,序号)
		  return self:虾兵(任务id,玩家id,序号)
	 end
	 self.GUAIWU["110013"]=function(任务id,玩家id,序号)
		  return self:山神(任务id,玩家id,序号)
	 end
	 self.GUAIWU["110014"]=function(任务id,玩家id,序号)
		  return self:蟹将军(任务id,玩家id,序号)
	 end
	 self.GUAIWU["110015"]=function(任务id,玩家id,序号)
		  return self:刘洪1(任务id,玩家id,序号)
	 end
	 self.GUAIWU["110016"]=function(任务id,玩家id,序号)
		  return self:李彪(任务id,玩家id,序号)
	 end
	 self.GUAIWU["110017"]=function(任务id,玩家id,序号)
		  return self:刘洪2(任务id,玩家id,序号)
	 end
	 self.GUAIWU["130064"]=function(任务id,玩家id,序号)
		  return self:初出江湖(任务id,玩家id,序号)
	 end
	 self.GUAIWU["130065"]=function(任务id,玩家id,序号)
		  return self:门派巡逻(任务id,玩家id,序号)
	 end
	 self.GUAIWU["100020"]=function(任务id,玩家id,序号)
		  return self:挖宝妖王(任务id,玩家id,序号)
	 end
	Qunandu[100020]="妖王"
	 self.GUAIWU["100004"]=function(任务id,玩家id,序号)
		  return self:封妖(任务id,玩家id,序号)
	 end
	Qunandu[100004]="封妖"
	 self.GUAIWU["100008"]=function(任务id,玩家id,序号)
		  return self:抓鬼任务(任务id,玩家id,序号)
	 end
	Qunandu[100008]="抓鬼"
	  self.GUAIWU["110077"]=function(任务id,玩家id,序号)
		  return self:自动抓鬼(任务id,玩家id,序号)
	 end
	 self.GUAIWU["101000"]=function(任务id,玩家id,序号)
		  return self:鬼王任务(任务id,玩家id,序号)
	 end
	Qunandu[101000]="鬼王"
	 self.GUAIWU["130083"]=function(任务id,玩家id,序号)
		  return self:伐木工(任务id,玩家id,序号)
	 end
	Qunandu[130083]="帮战伐木：伐木工"
	 self.GUAIWU["130084"]=function(任务id,玩家id,序号)
		  return self:伐木兔子(任务id,玩家id,序号)
	 end
	Qunandu[130084]="帮战伐木：伐木兔子"
	 self.GUAIWU["130085"]=function(任务id,玩家id,序号)
		  return self:夺旗守卫(任务id,玩家id,序号)
	 end
	Qunandu[130085]="帮战夺旗：夺旗守卫"
	 self.GUAIWU["130086"]=function(任务id,玩家id,序号)
		  return self:帮战夺旗棋子(任务id,玩家id,序号)
	 end
	Qunandu[130086]="帮战夺旗：抢夺旗帜"
	 self.GUAIWU["100009"]=function(任务id,玩家id,序号)
		  return self:取28星宿属性(任务id,玩家id,序号)
	 end
	Qunandu[100009]="二十八星宿"
	 ------通天河
	 self.GUAIWU["190201"]=function(任务id,玩家id,序号)
		  return self:通天河灵灯(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190202"]=function(任务id,玩家id,序号)
		  return self:通天河善财童子(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190203"]=function(任务id,玩家id,序号)
		  return self:通天河木材(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190204"]=function(任务id,玩家id,序号)
		  return self:通天河金鱼1(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190205"]=function(任务id,玩家id,序号)
		  return self:通天河金鱼2(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190206"]=function(任务id,玩家id,序号)
		  return self:通天河金鱼3(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190207"]=function(任务id,玩家id,序号)
		  return self:通天河金鱼4(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190208"]=function(任务id,玩家id,序号)
		  return self:通天河金鱼5(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190209"]=function(任务id,玩家id,序号)
		  return self:通天河婴灵(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190210"]=function(任务id,玩家id,序号)
		  return self:通天河冤魂(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190211"]=function(任务id,玩家id,序号)
		  return self:通天河心(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190212"]=function(任务id,玩家id,序号)
		  return self:通天河肝(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190213"]=function(任务id,玩家id,序号)
		  return self:通天河脾(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190214"]=function(任务id,玩家id,序号)
		  return self:通天河肾(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190215"]=function(任务id,玩家id,序号)
		  return self:通天河肺(任务id,玩家id,序号)
	 end
	 self.GUAIWU["190216"]=function(任务id,玩家id,序号)
		  return self:通天河灵感元神(任务id,玩家id,序号)
	 end
	 self.GUAIWU["130087"]=function(任务id,玩家id,序号)
		  return self:保卫长安_先锋(任务id,玩家id,序号)
	 end
	 Qunandu[130087]="保卫长安：小怪先锋"
	 self.GUAIWU["130088"]=function(任务id,玩家id,序号)
		  return self:保卫长安_头目(任务id,玩家id,序号)
	 end
	 Qunandu[130088]="保卫长安：小怪头目"
	 self.GUAIWU["130089"]=function(任务id,玩家id,序号)
		  return self:保卫长安_大王(任务id,玩家id,序号)
	 end
	 Qunandu[130089]="保卫长安：小怪大王"
	 self.GUAIWU["130090"]=function(任务id,玩家id,序号)
		  return self:保卫长安_魑(任务id,玩家id,序号)
	 end
	 Qunandu[130090]="保卫长安：魑魅魍魉"
	 self.GUAIWU["130091"]=function(任务id,玩家id,序号)
		  return self:保卫长安_魅(任务id,玩家id,序号)
	 end
	 Qunandu[130091]="保卫长安：魑魅魍魉"
	 self.GUAIWU["130092"]=function(任务id,玩家id,序号)
		  return self:保卫长安_魍(任务id,玩家id,序号)
	 end
	 Qunandu[130092]="保卫长安：魑魅魍魉"
	 self.GUAIWU["130093"]=function(任务id,玩家id,序号)
		  return self:保卫长安_魉(任务id,玩家id,序号)
	 end
	 Qunandu[130093]="保卫长安：魑魅魍魉"
	 self.GUAIWU["130094"]=function(任务id,玩家id,序号)
		  return self:保卫长安_鼍龙(任务id,玩家id,序号)
	 end
	 Qunandu[130094]="保卫长安：鼍龙兕怪"
	 self.GUAIWU["130095"]=function(任务id,玩家id,序号)
		  return self:保卫长安_兕怪(任务id,玩家id,序号)
	 end
	 Qunandu[130095]="保卫长安：鼍龙兕怪"
	 self.GUAIWU["130096"]=function(任务id,玩家id,序号)
		  return self:保卫长安_振威大王(任务id,玩家id,序号)
	 end
	 Qunandu[130096]="保卫长安：振威大王"
	 self.GUAIWU["140000"]=function(任务id,玩家id,序号)
		  return self:雁塔地宫信息(任务id,玩家id,序号)
	 end
	 Qunandu[134872]="比武假人"
	 self.GUAIWU["134872"]=function(任务id,玩家id,序号)
		  return self:取比武假人信息(任务id,玩家id,序号)
	 end
	 self.GUAIWU["111108"]=function(任务id,玩家id,序号)
		  return self:取通天塔信息(任务id,玩家id,序号)
	 end
	 self.GUAIWU["155555"]=function(任务id,玩家id,序号)
		  return self:取飞升阵法5战斗信息(任务id,玩家id,序号)
	 end
	 --新增#11
	 self.GUAIWU["145554"]=function(任务id,玩家id,序号)
		  return self:秘境降妖一层(任务id,玩家id,序号)
	 end
	self.GUAIWU["145555"]=function(任务id,玩家id,序号)
		  return self:秘境降妖二层(任务id,玩家id,序号)
	 end
	self.GUAIWU["145556"]=function(任务id,玩家id,序号)
		  return self:秘境降妖三层(任务id,玩家id,序号)
	 end
	self.GUAIWU["145557"]=function(任务id,玩家id,序号)
		  return self:秘境降妖四层(任务id,玩家id,序号)
	 end
	self.GUAIWU["145558"]=function(任务id,玩家id,序号)
		  return self:秘境降妖五层(任务id,玩家id,序号)
	 end
	self.GUAIWU["145559"]=function(任务id,玩家id,序号)
		  return self:秘境降妖六层(任务id,玩家id,序号)
	 end
	self.GUAIWU["145560"]=function(任务id,玩家id,序号)
		  return self:秘境降妖七层(任务id,玩家id,序号)
	 end
	self.GUAIWU["145561"]=function(任务id,玩家id,序号)
		  return self:秘境降妖八层(任务id,玩家id,序号)
	 end
	self.GUAIWU["145562"]=function(任务id,玩家id,序号)
		  return self:秘境降妖九层(任务id,玩家id,序号)
	 end
	self.GUAIWU["145563"]=function(任务id,玩家id,序号)
		  return self:秘境降妖十层(任务id,玩家id,序号)
	 end
	self.GUAIWU["145564"]=function(任务id,玩家id,序号)
		  return self:秘境降妖特殊一(任务id,玩家id,序号)
	 end
	self.GUAIWU["145565"]=function(任务id,玩家id,序号)
		  return self:秘境降妖特殊二(任务id,玩家id,序号)
	 end
	 --黑山#11
	self.GUAIWU["155566"]=function(任务id,玩家id,序号)
		  return self:黑风山巡逻(任务id,玩家id,序号)
	 end
	self.GUAIWU["155567"]=function(任务id,玩家id,序号)
	     if 任务数据[任务id].名称=="绝望的牛头" then
         return self:黑风山绝望的牛头(任务id,玩家id,序号)
    elseif 任务数据[任务id].名称=="懵懂的僵尸"then
         return self:黑风山懵懂的僵尸(任务id,玩家id,序号)
    elseif 任务数据[任务id].名称=="吊死的鬼魂"then
         return self:黑风山吊死的鬼魂(任务id,玩家id,序号)
    elseif 任务数据[任务id].名称=="奇怪的马面"then
          return self:黑风山奇怪的马面(任务id,玩家id,序号)
     end
	 end
	self.GUAIWU["155568"]=function(任务id,玩家id,序号)
		  return self:黑风山恶虎(任务id,玩家id,序号)
	 end
	self.GUAIWU["155569"]=function(任务id,玩家id,序号)
		  return self:黑风山熊精(任务id,玩家id,序号)
	 end
	self.GUAIWU["155571"]=function(任务id,玩家id,序号)
	if 任务数据[任务id].名称=="熊熊烈火" then
		  return self:黑风山熊熊烈火(任务id,玩家id,序号)
	elseif 任务数据[任务id].名称=="星星火光"then
		  return self:黑风山星星火光(任务id,玩家id,序号)
	end
	end
	self.GUAIWU["155572"]=function(任务id,玩家id,序号)
		  return self:黑风山三妖(任务id,玩家id,序号)
	 end
	self.GUAIWU["155573"]=function(任务id,玩家id,序号)
		  return self:黑风山巡山精怪(任务id,玩家id,序号)
	 end
	self.GUAIWU["155574"]=function(任务id,玩家id,序号)
		  return self:黑风山黑熊精(任务id,玩家id,序号)
	 end
	 --大闹#11
	self.GUAIWU["155584"]=function(任务id,玩家id,序号)
		  return self:大闹抢水(任务id,玩家id,序号)
	 end
	self.GUAIWU["155585"]=function(任务id,玩家id,序号)
		  return self:大闹除虫(任务id,玩家id,序号)
	 end
	self.GUAIWU["155576"]=function(任务id,玩家id,序号)
		  return self:大闹七仙女(任务id,玩家id,序号)
	 end
	self.GUAIWU["155577"]=function(任务id,玩家id,序号)
		  return self:大闹造酒仙官(任务id,玩家id,序号)
	 end
	self.GUAIWU["155578"]=function(任务id,玩家id,序号)
		  return self:大闹运水道人(任务id,玩家id,序号)
	 end
	self.GUAIWU["155579"]=function(任务id,玩家id,序号)
		  return self:大闹烧火童子(任务id,玩家id,序号)
	 end
	self.GUAIWU["155580"]=function(任务id,玩家id,序号)
		  return self:大闹盘槽力士(任务id,玩家id,序号)
	 end
	self.GUAIWU["155581"]=function(任务id,玩家id,序号)
	       if 任务数据[任务id].名称 == "天兵统领" then
		return self:大闹天兵(任务id,玩家id,序号)
	elseif 任务数据[任务id].名称=="天将统领"then
	      return self:大闹天将(任务id,玩家id,序号)
	  end
      end
  	 self.GUAIWU["155582"]=function(任务id,玩家id,序号)
		  return self:大闹二郎神(任务id,玩家id,序号)
	  end
  	 self.GUAIWU["155583"]=function(任务id,玩家id,序号)
		  return self:大闹雷神(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155559"]=function(任务id,玩家id,序号)
		  return self:取知了大王信息(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155560"]=function(任务id,玩家id,序号)
		  return self:取知了统领信息(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155561"]=function(任务id,玩家id,序号)
		  return self:取知了小王信息(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155565"]=function(任务id,玩家id,序号)
		  return self:取千年知了王信息(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155557"]=function(任务id,玩家id,序号)
		  return self:取裂风兽信息(任务id,玩家id,序号)
	 end
	 self.GUAIWU["155562"]=function(任务id,玩家id,序号)--50世界BOSS  远古妖魔头目
		  return self:取低级BOSS信息(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155563"]=function(任务id,玩家id,序号)--100BOSS
		  return self:取中级BOSS信息(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155564"]=function(任务id,玩家id,序号)--150BOSS
		  return self:取高级BOSS信息(任务id,玩家id,序号)
	  end




	  self.GUAIWU["155564.11"]=function(任务id,玩家id,序号)
		  return self:取圣兽青龙信息(任务id,玩家id,序号)---下面加圣兽青龙信息函数式
	 end
	 Qunandu[155564.11]="圣兽青龙"

	 self.GUAIWU["155564.21"]=function(任务id,玩家id,序号)
		  return self:取圣兽白虎信息(任务id,玩家id,序号)---下面加圣兽青龙信息函数式
	 end
	 Qunandu[155564.21]="圣兽白虎"

	 self.GUAIWU["155564.31"]=function(任务id,玩家id,序号)
		  return self:取圣兽朱雀信息(任务id,玩家id,序号)---下面加圣兽青龙信息函数式
	 end
	 Qunandu[155564.31]="圣兽朱雀"

	 self.GUAIWU["155564.41"]=function(任务id,玩家id,序号)
		  return self:取圣兽玄武信息(任务id,玩家id,序号)---下面加圣兽青龙信息函数式
	 end
	 Qunandu[155564.41]="圣兽玄武"




	 self.GUAIWU["155564.1"]=function(任务id,玩家id,序号)
		  return self:取沸涌炎海的信标信息(任务id,玩家id,序号)---沸涌炎海的信标
	 end
	 self.GUAIWU["155564.2"]=function(任务id,玩家id,序号)
		  return self:取钢铁炼境的信标信息(任务id,玩家id,序号)---钢铁炼境的信标
	 end
	 self.GUAIWU["155564.3"]=function(任务id,玩家id,序号)
		  return self:取雷鸣废土的信标信息(任务id,玩家id,序号)---雷鸣废土的信标
	 end
	 self.GUAIWU["155564.4"]=function(任务id,玩家id,序号)
		  return self:取幽夜暗域的信标信息(任务id,玩家id,序号)---幽夜暗域的信标
	 end
	 self.GUAIWU["155564.5"]=function(任务id,玩家id,序号)
		  return self:取混乱终末的信标信息(任务id,玩家id,序号)---混乱终末的信标
	 end
	 self.GUAIWU["155564.6"]=function(任务id,玩家id,序号)
		  return self:取伟大虚空的信标信息(任务id,玩家id,序号)---伟大虚空的信标
	 end
	 self.GUAIWU["155564.7"]=function(任务id,玩家id,序号)
		  return self:取巅峰领域的信标信息(任务id,玩家id,序号)---巅峰领域的信标
	 end

	 self.GUAIWU["155632"]=function(任务id,玩家id,序号)
		  return self:天火之殇上鬼魂(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155633"]=function(任务id,玩家id,序号)
		  return self:天火之殇上魑魅(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155634"]=function(任务id,玩家id,序号)
		  return self:天火之殇上鬼魂士兵(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155635"]=function(任务id,玩家id,序号)
		  return self:天火之殇上巡逻鬼(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155636"]=function(任务id,玩家id,序号)
		  return self:天火之殇上鬼魂头目(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155637"]=function(任务id,玩家id,序号)
		  return self:天火之殇上韩擒虎鬼魂(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155638"]=function(任务id,玩家id,序号)
		  return self:天火之殇上刘武周幻影(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155639"]=function(任务id,玩家id,序号)
		  return self:天火之殇上鬼魂护卫(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155640"]=function(任务id,玩家id,序号)
		  return self:天火之殇上隋炀帝鬼魂(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155600"]=function(任务id,玩家id,序号)
		  return self:齐天大圣白无常(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155601"]=function(任务id,玩家id,序号)
		  return self:齐天大圣黑无常(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155602"]=function(任务id,玩家id,序号)
		  return self:齐天大圣阎王(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155603"]=function(任务id,玩家id,序号)
		  return self:齐天大圣天王(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155604"]=function(任务id,玩家id,序号)
		  return self:齐天大圣盗马贼(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155605"]=function(任务id,玩家id,序号)
		  return self:齐天大圣百万天兵(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155606"]=function(任务id,玩家id,序号)
		  return self:齐天大圣巨灵神(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155607"]=function(任务id,玩家id,序号)
		  return self:齐天大圣镇塔之神(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155608"]=function(任务id,玩家id,序号)
		  return self:齐天大圣展示实力(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155609"]=function(任务id,玩家id,序号)
		  return self:无底洞强盗喽啰(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155610"]=function(任务id,玩家id,序号)
		  return self:无底洞强盗大头领(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155611"]=function(任务id,玩家id,序号)
		  return self:无底洞强盗二头领(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155612"]=function(任务id,玩家id,序号)
		  return self:无底洞可疑少女(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155613"]=function(任务id,玩家id,序号)
		  return self:无底洞猪八戒(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155614"]=function(任务id,玩家id,序号)
		  return self:无底洞镇守的妖精(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155618"]=function(任务id,玩家id,序号)
		  return self:无底洞守门妖将(任务id,玩家id,序号)
	  end
 	 self.GUAIWU["155616"]=function(任务id,玩家id,序号)
		  return self:无底洞鱼肚怪(任务id,玩家id,序号)
	  end
	 self.GUAIWU["155617"]=function(任务id,玩家id,序号)
		  return self:无底洞宝箱怪(任务id,玩家id,序号)
	  end
	 	 ------十八路妖王
	 self.GUAIWU["100224"]=function(任务id,玩家id,序号)
	  if 任务数据[任务id].名称 == "黄风怪" then
		  return self:妖王之黄风怪(任务id,玩家id,序号)
		elseif 任务数据[任务id].名称 == "白骨精" then
          return self:妖王之白骨精(任务id,玩家id,序号)
		elseif 任务数据[任务id].名称 == "狮猁怪" then
          return self:妖王之狮猁怪(任务id,玩家id,序号)
		elseif 任务数据[任务id].名称 == "眼魔君" then
          return self:妖王之眼魔君(任务id,玩家id,序号)
		elseif 任务数据[任务id].名称 == "蝎子精" then
          return self:妖王之蝎子精(任务id,玩家id,序号)
		elseif 任务数据[任务id].名称 == "红孩儿" then
          return self:妖王之红孩儿(任务id,玩家id,序号)
		elseif 任务数据[任务id].名称 == "六耳猕猴" then
          return self:妖王之六耳猕猴(任务id,玩家id,序号)
		elseif 任务数据[任务id].名称 == "玉兔精" then
          return self:妖王之玉兔精(任务id,玩家id,序号)
		elseif 任务数据[任务id].名称 == "独角兕大王" then
          return self:妖王之独角兕大王(任务id,玩家id,序号)
		elseif 任务数据[任务id].名称 == "混世魔王" then
          return self:妖王之混世魔王(任务id,玩家id,序号)
		elseif 任务数据[任务id].名称 == "黑风怪" then
          return self:妖王之黑风怪(任务id,玩家id,序号)
		elseif 任务数据[任务id].名称 == "九尾狐狸" then
          return self:妖王之九尾狐狸(任务id,玩家id,序号)
		elseif 任务数据[任务id].名称 == "妖王之主" then
          return self:妖王之主(任务id,玩家id,序号)
     end

    end
    self.GUAIWU["130101"]=function(任务id,玩家id,序号)
		  return self:武神坛蚩尤信息(任务id,玩家id,序号)
	 end
	-------------------麻瓜剑会
	 self.GUAIWU["160001"]=function(任务id,玩家id,序号)
		  return self:取剑会假人信息(任务id,玩家id,序号)
	 end
	self.GUAIWU["160002"]=function(任务id,玩家id,序号)
		return self:取黑神话信息(任务id,玩家id,序号)
	end
end

function 怪物属性:取圣兽青龙信息(任务id,玩家id,序号)
	local 战斗单位={}
	local 等级=取队伍平均等级(玩家数据[玩家id].队伍,玩家id)
	local 难度=HDPZ["圣兽青龙"].难度
			等级=等级*0.8
	local 伤害1=等级 * 难度 * 35
	local 气血1=等级 * 难度 * 400
	local 法伤1=等级 * 难度 * 35
	local 速度1=等级 * 难度 * 6
	local 防御1=等级 * 难度 * 10
	local 法防1=等级 * 难度 * 2
	local 躲闪1=等级 * 10
	local 魔法1=20000
	local 等级1=等级+10
	local 固定伤害1 =等级*20
	local 治疗能力1 = 等级*8
	local 封印命中等级1=等级+10
	local 抵抗封印等级1=等级+10
	local 技能1={"高级感知","超级法术连击","高级必杀","高级法术暴击","超级偷袭","高级神迹"}

	战斗单位[1]={
	名称="圣兽青龙"
	,模型="进阶虬龙"
	,附加阵法=Q_阵法名[取随机数(1,#Q_阵法名)]
	,伤害=伤害1
	,气血=气血1
	,法伤=法伤1
	,速度=速度1
	,防御=防御1
	,法防=法防1
	,躲闪=躲闪1
	,魔法=魔法1
	,等级=等级1
	,固定伤害=固定伤害1
	,治疗能力= 治疗能力1
	,封印命中等级=封印命中等级1
	,抵抗封印等级=抵抗封印等级1
	,技能=技能1
	,主动技能=取随机法术(8)
	,饰品显示=true
	}

	for n=2,5 do
	战斗单位[n]={
    名称="青龙"
    ,模型="进阶蛟龙"
	,伤害=伤害1 * 0.8
	,气血=气血1 * 0.8
	,法伤=法伤1 * 0.8
	,速度=速度1 * 0.8
	,防御=防御1 * 0.8
	,法防=法防1 * 0.8
	,躲闪=躲闪1 * 0.8
	,魔法=魔法1 * 0.8
	,等级=等级1 * 0.8
	,固定伤害=固定伤害1 * 0.8
	,治疗能力= 治疗能力1 * 0.8
	,封印命中等级=封印命中等级1 * 0.8
	,抵抗封印等级=抵抗封印等级1 * 0.8
	,技能={}
	,主动技能=取随机法术(8)
	,饰品显示=true
	}
	end
	for n=6,10 do
    战斗单位[n]={
    名称="龙孙"
    ,模型="蛟龙"
	,伤害=伤害1 * 0.6
	,气血=气血1 * 0.6
	,法伤=法伤1 * 0.6
	,速度=速度1 * 0.6
	,防御=防御1 * 0.6
	,法防=法防1 * 0.6
	,躲闪=躲闪1 * 0.6
	,魔法=魔法1 * 0.6
	,等级=等级1 * 0.6
	,固定伤害=固定伤害1 * 0.6
	,治疗能力= 治疗能力1 * 0.6
	,封印命中等级=封印命中等级1 * 0.6
	,抵抗封印等级=抵抗封印等级1 * 0.6
	,技能={}
	,主动技能=取随机法术(8)
	,饰品显示=false
	}
	end
	return 战斗单位
end

function 怪物属性:取圣兽白虎信息(任务id,玩家id,序号)
	local 战斗单位={}
	local 等级=取队伍平均等级(玩家数据[玩家id].队伍,玩家id)
	local 难度=HDPZ["圣兽白虎"].难度
			等级=等级*0.8
	local 伤害1=等级 * 难度 * 32
	local 气血1=等级 * 难度 * 500
	local 法伤1=等级 * 难度 * 32
	local 速度1=等级 * 难度 * 6
	local 防御1=等级 * 难度 * 10
	local 法防1=等级 * 难度 * 2
	local 躲闪1=等级 * 10
	local 魔法1=20000
	local 等级1=等级+10
	local 固定伤害1 =等级*20
	local 治疗能力1 = 等级*8
	local 封印命中等级1=等级+10
	local 抵抗封印等级1=等级+10
	local 技能1={"高级感知","超级法术连击","高级必杀","高级法术暴击","超级偷袭","高级神迹"}

	战斗单位[1]={
	名称="圣兽白虎"
	,模型="进阶噬天虎"
	,附加阵法=Q_阵法名[取随机数(1,#Q_阵法名)]
	,伤害=伤害1
	,气血=气血1
	,法伤=法伤1
	,速度=速度1
	,防御=防御1
	,法防=法防1
	,躲闪=躲闪1
	,魔法=魔法1
	,等级=等级1
	,固定伤害=固定伤害1
	,治疗能力= 治疗能力1
	,封印命中等级=封印命中等级1
	,抵抗封印等级=抵抗封印等级1
	,技能=技能1
	,主动技能=取随机法术(8)
	,饰品显示=true
	}

	for n=2,5 do
	战斗单位[n]={
    名称="白虎"
    ,模型="噬天虎"
	,伤害=伤害1 * 0.8
	,气血=气血1 * 0.8
	,法伤=法伤1 * 0.8
	,速度=速度1 * 0.8
	,防御=防御1 * 0.8
	,法防=法防1 * 0.8
	,躲闪=躲闪1 * 0.8
	,魔法=魔法1 * 0.8
	,等级=等级1 * 0.8
	,固定伤害=固定伤害1 * 0.8
	,治疗能力= 治疗能力1 * 0.8
	,封印命中等级=封印命中等级1 * 0.8
	,抵抗封印等级=抵抗封印等级1 * 0.8
	,技能={}
	,主动技能=取随机法术(8)
	,饰品显示=true
	}
	end
	for n=6,10 do
    战斗单位[n]={
    名称="虎孙"
    ,模型="老虎"
	,伤害=伤害1 * 0.6
	,气血=气血1 * 0.6
	,法伤=法伤1 * 0.6
	,速度=速度1 * 0.6
	,防御=防御1 * 0.6
	,法防=法防1 * 0.6
	,躲闪=躲闪1 * 0.6
	,魔法=魔法1 * 0.6
	,等级=等级1 * 0.6
	,固定伤害=固定伤害1 * 0.6
	,治疗能力= 治疗能力1 * 0.6
	,封印命中等级=封印命中等级1 * 0.6
	,抵抗封印等级=抵抗封印等级1 * 0.6
	,技能={}
	,主动技能=取随机法术(8)
	,饰品显示=false
	}
	end
	return 战斗单位
end

function 怪物属性:取圣兽朱雀信息(任务id,玩家id,序号)
	local 战斗单位={}
	local 等级=取队伍平均等级(玩家数据[玩家id].队伍,玩家id)
	local 难度=HDPZ["圣兽朱雀"].难度
			等级=等级*0.8
	local 伤害1=等级 * 难度 * 25
	local 气血1=等级 * 难度 * 400
	local 法伤1=等级 * 难度 * 45
	local 速度1=等级 * 难度 * 6
	local 防御1=等级 * 难度 * 10
	local 法防1=等级 * 难度 * 2
	local 躲闪1=等级 * 10
	local 魔法1=20000
	local 等级1=等级+10
	local 固定伤害1 =等级*20
	local 治疗能力1 = 等级*8
	local 封印命中等级1=等级+10
	local 抵抗封印等级1=等级+10
	local 技能1={"高级感知","超级法术连击","高级必杀","超级法术暴击","高级神迹"}

	战斗单位[1]={
	名称="圣兽朱雀"
	,模型="执音"
	,附加阵法=Q_阵法名[取随机数(1,#Q_阵法名)]
	,伤害=伤害1
	,气血=气血1
	,法伤=法伤1
	,速度=速度1
	,防御=防御1
	,法防=法防1
	,躲闪=躲闪1
	,魔法=魔法1
	,等级=等级1
	,固定伤害=固定伤害1
	,治疗能力= 治疗能力1
	,封印命中等级=封印命中等级1
	,抵抗封印等级=抵抗封印等级1
	,技能=技能1
	,主动技能=取随机法术(8)
	,饰品显示=true
	}

	for n=2,5 do
	战斗单位[n]={
    名称="朱雀"
    ,模型="灵鹤"
	,伤害=伤害1 * 0.8
	,气血=气血1 * 0.8
	,法伤=法伤1 * 0.8
	,速度=速度1 * 0.8
	,防御=防御1 * 0.8
	,法防=法防1 * 0.8
	,躲闪=躲闪1 * 0.8
	,魔法=魔法1 * 0.8
	,等级=等级1 * 0.8
	,固定伤害=固定伤害1 * 0.8
	,治疗能力= 治疗能力1 * 0.8
	,封印命中等级=封印命中等级1 * 0.8
	,抵抗封印等级=抵抗封印等级1 * 0.8
	,技能={}
	,主动技能=取随机法术(8)
	,饰品显示=true
	}
	end
	for n=6,10 do
    战斗单位[n]={
    名称="麻雀"
    ,模型="凤凰"
	,伤害=伤害1 * 0.6
	,气血=气血1 * 0.6
	,法伤=法伤1 * 0.6
	,速度=速度1 * 0.6
	,防御=防御1 * 0.6
	,法防=法防1 * 0.6
	,躲闪=躲闪1 * 0.6
	,魔法=魔法1 * 0.6
	,等级=等级1 * 0.6
	,固定伤害=固定伤害1 * 0.6
	,治疗能力= 治疗能力1 * 0.6
	,封印命中等级=封印命中等级1 * 0.6
	,抵抗封印等级=抵抗封印等级1 * 0.6
	,技能={}
	,主动技能=取随机法术(8)
	,饰品显示=false
	}
	end
	return 战斗单位
end

function 怪物属性:取圣兽玄武信息(任务id,玩家id,序号)
	local 战斗单位={}
	local 等级=取队伍平均等级(玩家数据[玩家id].队伍,玩家id)
	local 难度=HDPZ["圣兽玄武"].难度
			等级=等级*0.8
	local 伤害1=等级 * 难度 * 25
	local 气血1=等级 * 难度 * 800
	local 法伤1=等级 * 难度 * 25
	local 速度1=等级 * 难度 * 6
	local 防御1=等级 * 难度 * 15
	local 法防1=等级 * 难度 * 4
	local 躲闪1=等级 * 10
	local 魔法1=20000
	local 等级1=等级+10
	local 固定伤害1 =等级*20
	local 治疗能力1 = 等级*8*2
	local 封印命中等级1=等级+10
	local 抵抗封印等级1=等级+10
	local 技能1={"高级感知","超级法术连击","高级必杀","高级法术暴击","超级再生","高级神迹"}

	战斗单位[1]={
	名称="圣兽玄武"
	,模型="进阶龙龟"
	,附加阵法=Q_阵法名[取随机数(1,#Q_阵法名)]
	,伤害=伤害1
	,气血=气血1
	,法伤=法伤1
	,速度=速度1
	,防御=防御1
	,法防=法防1
	,躲闪=躲闪1
	,魔法=魔法1
	,等级=等级1
	,固定伤害=固定伤害1
	,治疗能力= 治疗能力1
	,封印命中等级=封印命中等级1
	,抵抗封印等级=抵抗封印等级1
	,技能=技能1
	,主动技能=取随机法术(8)
	,饰品显示=true
	}

	for n=2,5 do
	战斗单位[n]={
    名称="玄武"
    ,模型="龙龟"
	,伤害=伤害1 * 0.8
	,气血=气血1 * 0.8
	,法伤=法伤1 * 0.8
	,速度=速度1 * 0.8
	,防御=防御1 * 0.8
	,法防=法防1 * 0.8
	,躲闪=躲闪1 * 0.8
	,魔法=魔法1 * 0.8
	,等级=等级1 * 0.8
	,固定伤害=固定伤害1 * 0.8
	,治疗能力= 治疗能力1 * 0.8
	,封印命中等级=封印命中等级1 * 0.8
	,抵抗封印等级=抵抗封印等级1 * 0.8
	,技能={}
	,主动技能=取随机法术(8)
	,饰品显示=true
	}
	end
	for n=6,10 do
    战斗单位[n]={
    名称="龟孙"
    ,模型="龟丞相"
	,伤害=伤害1 * 0.6
	,气血=气血1 * 0.6
	,法伤=法伤1 * 0.6
	,速度=速度1 * 0.6
	,防御=防御1 * 0.6
	,法防=法防1 * 0.6
	,躲闪=躲闪1 * 0.6
	,魔法=魔法1 * 0.6
	,等级=等级1 * 0.6
	,固定伤害=固定伤害1 * 0.6
	,治疗能力= 治疗能力1 * 0.6
	,封印命中等级=封印命中等级1 * 0.6
	,抵抗封印等级=抵抗封印等级1 * 0.6
	,技能={}
	,主动技能=取随机法术(8)
	,饰品显示=true
	}
	end
	return 战斗单位
end



----------------------------信标-----------------------------
function 怪物属性:取沸涌炎海的信标信息(任务id,玩家id,序号)---沸涌炎海的信标
	local 战斗单位={}
	local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	local xlz = qz(1+等级/50)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"}
	local 随机阵法 = {"天覆阵","地载阵","风扬阵","云垂阵","龙飞阵","虎翼阵","鸟翔阵","蛇蟠阵","鹰啸阵","雷绝阵"}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机输出门派())
	战斗单位[1]={
	名称="八极∷姑苏城"
	,模型="自在天魔"
	,附加阵法=随机阵法[取随机数(1,#随机阵法)]
		    ,等级=等级+10
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*10000+200000
		    ,伤害 = qz(1+等级/50)*400+2500
		    ,法伤 = qz(1+等级/500)*350+1500
		    ,防御 = qz(1+等级/100)*300+1500
		    ,法防 = qz(1+等级/100)*200+800
		    ,速度 = qz(1+等级/100)*200+500
		    ,固定伤害 = qz(1+等级/100)*350
		    ,治疗能力 = 等级*10+3500
		    ,封印命中等级=等级+100
		    ,抵抗封印等级=等级+100
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战","高级偷袭","高级独行","高级驱鬼","高级法术暴击","高级法术连击","高级魔之心"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
    }
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[2]={
    名称="℃喜の★狼"
	,模型="进阶炼丹童子"
		    ,等级=等级+15
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*12000+200000
		    ,伤害 = qz(1+等级/50)*400+2500
		    ,法伤 = qz(1+等级/500)*350+1500
		    ,防御 = qz(1+等级/100)*300+1500
		    ,法防 = qz(1+等级/100)*200+800
		    ,速度 = qz(1+等级/100)*200+500
		    ,固定伤害 = qz(1+等级/100)*350
		    ,治疗能力 = 等级*10+3500
		    ,封印命中等级=等级+100
		    ,抵抗封印等级=等级+100
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级精神集中","高级神迹","高级反震"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机物理门派())
战斗单位[3]={
    名称="K·北极海"
	,模型="进阶司雪"
		    ,等级=等级+15
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*12000+200000
		    ,伤害 = qz(1+等级/50)*400+2500
		    ,法伤 = qz(1+等级/500)*350+1500
		    ,防御 = qz(1+等级/100)*300+1500
		    ,法防 = qz(1+等级/100)*200+800
		    ,速度 = qz(1+等级/100)*200+500
		    ,固定伤害 = qz(1+等级/100)*350
		    ,治疗能力 = 等级*10+3500
		    ,封印命中等级=等级+100
		    ,抵抗封印等级=等级+100
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","超级敏捷","高级毒","高级独行","高级驱鬼","高级必杀","高级吸血"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机输出门派())
战斗单位[4]={
    名称="咕噜`闺闺"
	,模型="风祖飞廉"
		    ,等级=等级+15
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*12000+200000
		    ,伤害 = qz(1+等级/50)*400+2500
		    ,法伤 = qz(1+等级/500)*350+1500
		    ,防御 = qz(1+等级/100)*300+1500
		    ,法防 = qz(1+等级/100)*200+800
		    ,速度 = qz(1+等级/100)*200+500
		    ,固定伤害 = qz(1+等级/100)*350
		    ,治疗能力 = 等级*10+3500
		    ,封印命中等级=等级+100
		    ,抵抗封印等级=等级+100
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战","高级法术连击","高级法术暴击","高级法术波动"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机法系门派())
for n=5,7 do
    战斗单位[n]={
    名称="姑苏城服战选手"
	,模型="进阶谛听"
		    ,等级=等级+15
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*12000+200000
		    ,伤害 = qz(1+等级/50)*400+2500
		    ,法伤 = qz(1+等级/500)*350+1500
		    ,防御 = qz(1+等级/100)*300+1500
		    ,法防 = qz(1+等级/100)*200+800
		    ,速度 = qz(1+等级/100)*200+500
		    ,固定伤害 = qz(1+等级/100)*350
		    ,治疗能力 = 等级*10+3500
		    ,封印命中等级=等级+100
		    ,抵抗封印等级=等级+100
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机固伤门派())
战斗单位[8]={
    名称="姑苏城服战指挥"
	,模型="般若天女"
		    ,等级=等级+15
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*12000+200000
		    ,伤害 = qz(1+等级/50)*400+2500
		    ,法伤 = qz(1+等级/500)*350+1500
		    ,防御 = qz(1+等级/100)*300+1500
		    ,法防 = qz(1+等级/100)*200+800
		    ,速度 = qz(1+等级/100)*200+500
		    ,固定伤害 = qz(1+等级/100)*350
		    ,治疗能力 = 等级*10+3500
		    ,封印命中等级=等级+100
		    ,抵抗封印等级=等级+100
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[9]={
    名称="秋べ水"
	,模型="执音"
		    ,等级=等级+15
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*12000+200000
		    ,伤害 = qz(1+等级/50)*400+2500
		    ,法伤 = qz(1+等级/500)*350+1500
		    ,防御 = qz(1+等级/100)*300+1500
		    ,法防 = qz(1+等级/100)*200+800
		    ,速度 = qz(1+等级/100)*200+500
		    ,固定伤害 = qz(1+等级/100)*350
		    ,治疗能力 = 等级*10+3500
		    ,封印命中等级=等级+100
		    ,抵抗封印等级=等级+100
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级敏捷","高级幸运","高级招架","高级反震","高级神迹","高级鬼魂术"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[10]={
    名称="☆、、泡沫oo"
	,模型="毗舍童子"
		    ,等级=等级+15
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*12000+200000
		    ,伤害 = qz(1+等级/50)*400+2500
		    ,法伤 = qz(1+等级/500)*350+1500
		    ,防御 = qz(1+等级/100)*300+1500
		    ,法防 = qz(1+等级/100)*200+800
		    ,速度 = qz(1+等级/100)*200+500
		    ,固定伤害 = qz(1+等级/100)*350
		    ,治疗能力 = 等级*10+3500
		    ,封印命中等级=等级+100
		    ,抵抗封印等级=等级+100
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级敏捷","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
end
    return 战斗单位
end
------------------------------------------------------------------------
function 怪物属性:取钢铁炼境的信标信息(任务id,玩家id,序号)---钢铁炼境的信标
	local 战斗单位={}
	local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	local xlz = qz(1+等级/50)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"}
	local 随机阵法 = {"天覆阵","地载阵","风扬阵","云垂阵","龙飞阵","虎翼阵","鸟翔阵","蛇蟠阵","鹰啸阵","雷绝阵"}
	local q门派 = qmenpai[i]--Q_门派编号[取随机数(1,#Q_门派编号)]
	local sx = self:取属性(等级,self:取随机输出门派())
战斗单位[1]={
    名称="七元∷西栅老街"
	,模型="自在天魔"
	,附加阵法=随机阵法[取随机数(1,#随机阵法)]
		    ,等级=等级+15
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*15000+300000
		    ,伤害 = qz(1+等级/50)*450+4500
		    ,法伤 = qz(1+等级/500)*380+2000
		    ,防御 = qz(1+等级/100)*320+2000
		    ,法防 = qz(1+等级/100)*220+1000
		    ,速度 = qz(1+等级/100)*220+700
		    ,固定伤害 = qz(1+等级/100)*500
		    ,治疗能力 = 等级*10+4500
		    ,封印命中等级=等级+120
		    ,抵抗封印等级=等级+120
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战","高级偷袭","高级独行","高级驱鬼","高级法术暴击","高级法术连击","高级魔之心"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
    }
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[2]={
    名称="云东有若木o"
	,模型="进阶黑山老妖"
		    ,等级=等级+15
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*15000+300000
		    ,伤害 = qz(1+等级/50)*450+4500
		    ,法伤 = qz(1+等级/500)*380+2000
		    ,防御 = qz(1+等级/100)*320+2000
		    ,法防 = qz(1+等级/100)*220+1000
		    ,速度 = qz(1+等级/100)*220+700
		    ,固定伤害 = qz(1+等级/100)*500
		    ,治疗能力 = 等级*10+4500
		    ,封印命中等级=等级+120
		    ,抵抗封印等级=等级+120
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机物理门派())
战斗单位[3]={
    名称="哥一发入魂"
	,模型="进阶蝴蝶仙子"
		    ,等级=等级+15
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*15000+300000
		    ,伤害 = qz(1+等级/50)*450+4500
		    ,法伤 = qz(1+等级/500)*380+2000
		    ,防御 = qz(1+等级/100)*320+2000
		    ,法防 = qz(1+等级/100)*220+1000
		    ,速度 = qz(1+等级/100)*220+700
		    ,固定伤害 = qz(1+等级/100)*500
		    ,治疗能力 = 等级*10+4500
		    ,封印命中等级=等级+120
		    ,抵抗封印等级=等级+120
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机输出门派())
战斗单位[4]={
    名称="白刃入梦极"
	,模型="天兵"
		    ,等级=等级+15
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*15000+300000
		    ,伤害 = qz(1+等级/50)*450+4500
		    ,法伤 = qz(1+等级/500)*380+2000
		    ,防御 = qz(1+等级/100)*320+2000
		    ,法防 = qz(1+等级/100)*220+1000
		    ,速度 = qz(1+等级/100)*220+700
		    ,固定伤害 = qz(1+等级/100)*500
		    ,治疗能力 = 等级*10+4500
		    ,封印命中等级=等级+120
		    ,抵抗封印等级=等级+120
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机法系门派())
for n=5,7 do
    战斗单位[n]={
    名称="西栅老街服战选手"
	,模型="自在天魔斧钺"
		    ,等级=等级+15
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*15000+300000
		    ,伤害 = qz(1+等级/50)*450+4500
		    ,法伤 = qz(1+等级/500)*380+2000
		    ,防御 = qz(1+等级/100)*320+2000
		    ,法防 = qz(1+等级/100)*220+1000
		    ,速度 = qz(1+等级/100)*220+700
		    ,固定伤害 = qz(1+等级/100)*500
		    ,治疗能力 = 等级*10+4500
		    ,封印命中等级=等级+120
		    ,抵抗封印等级=等级+120
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机固伤门派())
战斗单位[8]={
    名称="西栅老街服战指挥"
	,模型="进阶花铃"
		    ,等级=等级+15
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*15000+300000
		    ,伤害 = qz(1+等级/50)*450+4500
		    ,法伤 = qz(1+等级/500)*380+2000
		    ,防御 = qz(1+等级/100)*320+2000
		    ,法防 = qz(1+等级/100)*220+1000
		    ,速度 = qz(1+等级/100)*220+700
		    ,固定伤害 = qz(1+等级/100)*500
		    ,治疗能力 = 等级*10+4500
		    ,封印命中等级=等级+120
		    ,抵抗封印等级=等级+120
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[9]={
    名称="雨下一整晚"
	,模型="进阶星灵仙子"
		    ,等级=等级+15
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*15000+300000
		    ,伤害 = qz(1+等级/50)*450+4500
		    ,法伤 = qz(1+等级/500)*380+2000
		    ,防御 = qz(1+等级/100)*320+2000
		    ,法防 = qz(1+等级/100)*220+1000
		    ,速度 = qz(1+等级/100)*220+700
		    ,固定伤害 = qz(1+等级/100)*500
		    ,治疗能力 = 等级*10+4500
		    ,封印命中等级=等级+120
		    ,抵抗封印等级=等级+120
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[10]={
    名称="平阳小和尚"
	,模型="进阶鬼将"
		    ,等级=等级+15
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*15000+300000
		    ,伤害 = qz(1+等级/50)*450+4500
		    ,法伤 = qz(1+等级/500)*380+2000
		    ,防御 = qz(1+等级/100)*320+2000
		    ,法防 = qz(1+等级/100)*220+1000
		    ,速度 = qz(1+等级/100)*220+700
		    ,固定伤害 = qz(1+等级/100)*500
		    ,治疗能力 = 等级*10+4500
		    ,封印命中等级=等级+120
		    ,抵抗封印等级=等级+120
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
end
    return 战斗单位
end
--------------------------------------------------------------------
function 怪物属性:取雷鸣废土的信标信息(任务id,玩家id,序号)---雷鸣废土的信标
	local 战斗单位={}
	local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	local xlz = qz(1+等级/50)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"}
	local 随机阵法 = {"天覆阵","地载阵","风扬阵","云垂阵","龙飞阵","虎翼阵","鸟翔阵","蛇蟠阵","鹰啸阵","雷绝阵"}
	local q门派 = qmenpai[i]--Q_门派编号[取随机数(1,#Q_门派编号)]
	local sx = self:取属性(等级,self:取随机输出门派())
战斗单位[1]={
    名称="六司∷蝴蝶泉"
	,模型="自在天魔"
	,附加阵法=随机阵法[取随机数(1,#随机阵法)]
		    ,等级=等级+20
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*16000+400000
		    ,伤害 = qz(1+等级/50)*480+4800
		    ,法伤 = qz(1+等级/500)*400+2200
		    ,防御 = qz(1+等级/100)*350+2200
		    ,法防 = qz(1+等级/100)*250+1200
		    ,速度 = qz(1+等级/100)*250+800
		    ,固定伤害 = qz(1+等级/100)*550
		    ,治疗能力 = 等级*10+4500
		    ,封印命中等级=等级+130
		    ,抵抗封印等级=等级+130
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战","高级偷袭","高级独行","高级驱鬼","高级法术暴击","高级法术连击","高级魔之心"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[2]={
    名称="弑メ爱吃菠萝"
	,模型="进阶吸血鬼"
		    ,等级=等级+20
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*16000+400000
		    ,伤害 = qz(1+等级/50)*480+4800
		    ,法伤 = qz(1+等级/500)*400+2200
		    ,防御 = qz(1+等级/100)*350+2200
		    ,法防 = qz(1+等级/100)*250+1200
		    ,速度 = qz(1+等级/100)*250+800
		    ,固定伤害 = qz(1+等级/100)*550
		    ,治疗能力 = 等级*10+4500
		    ,封印命中等级=等级+130
		    ,抵抗封印等级=等级+130
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机物理门派())
战斗单位[3]={
    名称="弑メ人生几何"
	,模型="净瓶女娲"
		    ,等级=等级+20
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*16000+400000
		    ,伤害 = qz(1+等级/50)*480+4800
		    ,法伤 = qz(1+等级/500)*400+2200
		    ,防御 = qz(1+等级/100)*350+2200
		    ,法防 = qz(1+等级/100)*250+1200
		    ,速度 = qz(1+等级/100)*250+800
		    ,固定伤害 = qz(1+等级/100)*550
		    ,治疗能力 = 等级*10+4500
		    ,封印命中等级=等级+130
		    ,抵抗封印等级=等级+130
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机输出门派())
战斗单位[4]={
    名称="弑メ只手遮天"
	,模型="进阶律法女娲"
		    ,等级=等级+20
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*16000+400000
		    ,伤害 = qz(1+等级/50)*480+4800
		    ,法伤 = qz(1+等级/500)*400+2200
		    ,防御 = qz(1+等级/100)*350+2200
		    ,法防 = qz(1+等级/100)*250+1200
		    ,速度 = qz(1+等级/100)*250+800
		    ,固定伤害 = qz(1+等级/100)*550
		    ,治疗能力 = 等级*10+4500
		    ,封印命中等级=等级+130
		    ,抵抗封印等级=等级+130
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机法系门派())
for n=5,7 do
    战斗单位[n]={
    名称="蝴蝶泉服战选手"
	,模型="自在天魔刀"
		    ,等级=等级+20
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*16000+400000
		    ,伤害 = qz(1+等级/50)*480+4800
		    ,法伤 = qz(1+等级/500)*400+2200
		    ,防御 = qz(1+等级/100)*350+2200
		    ,法防 = qz(1+等级/100)*250+1200
		    ,速度 = qz(1+等级/100)*250+800
		    ,固定伤害 = qz(1+等级/100)*550
		    ,治疗能力 = 等级*10+4500
		    ,封印命中等级=等级+130
		    ,抵抗封印等级=等级+130
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机固伤门派())
战斗单位[8]={
    名称="蝴蝶泉服战指挥"
	,模型="灵符女娲"
		    ,等级=等级+20
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*16000+400000
		    ,伤害 = qz(1+等级/50)*480+4800
		    ,法伤 = qz(1+等级/500)*400+2200
		    ,防御 = qz(1+等级/100)*350+2200
		    ,法防 = qz(1+等级/100)*250+1200
		    ,速度 = qz(1+等级/100)*250+800
		    ,固定伤害 = qz(1+等级/100)*550
		    ,治疗能力 = 等级*10+4500
		    ,封印命中等级=等级+130
		    ,抵抗封印等级=等级+130
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[9]={
    名称="弑メ夜不能寐"
	,模型="进阶狐不归"
		    ,等级=等级+20
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*16000+400000
		    ,伤害 = qz(1+等级/50)*480+4800
		    ,法伤 = qz(1+等级/500)*400+2200
		    ,防御 = qz(1+等级/100)*350+2200
		    ,法防 = qz(1+等级/100)*250+1200
		    ,速度 = qz(1+等级/100)*250+800
		    ,固定伤害 = qz(1+等级/100)*550
		    ,治疗能力 = 等级*10+4500
		    ,封印命中等级=等级+130
		    ,抵抗封印等级=等级+130
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[10]={
    名称="弑メ夜幸青楼"
	,模型="月魅"
		    ,等级=等级+20
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*16000+400000
		    ,伤害 = qz(1+等级/50)*480+4800
		    ,法伤 = qz(1+等级/500)*400+2200
		    ,防御 = qz(1+等级/100)*350+2200
		    ,法防 = qz(1+等级/100)*250+1200
		    ,速度 = qz(1+等级/100)*250+800
		    ,固定伤害 = qz(1+等级/100)*550
		    ,治疗能力 = 等级*10+4500
		    ,封印命中等级=等级+130
		    ,抵抗封印等级=等级+130
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
end
    return 战斗单位
end
------------------------------------------------------------------------
function 怪物属性:取幽夜暗域的信标信息(任务id,玩家id,序号)---幽夜暗域的信标
	local 战斗单位={}
	local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	local xlz = qz(1+等级/50)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"}
	local 随机阵法 = {"天覆阵","地载阵","风扬阵","云垂阵","龙飞阵","虎翼阵","鸟翔阵","蛇蟠阵","鹰啸阵","雷绝阵"}
	local q门派 = qmenpai[i]--Q_门派编号[取随机数(1,#Q_门派编号)]
	local sx = self:取属性(等级,self:取随机输出门派())
战斗单位[1]={
    名称="五老∷百花村"
	,模型="自在天魔"
	,附加阵法=随机阵法[取随机数(1,#随机阵法)]
		    ,等级=等级+21
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*17000+420000
		    ,伤害 = qz(1+等级/50)*500+5000
		    ,法伤 = qz(1+等级/500)*410+2300
		    ,防御 = qz(1+等级/100)*360+2300
		    ,法防 = qz(1+等级/100)*260+1300
		    ,速度 = qz(1+等级/100)*260+1000
		    ,固定伤害 = qz(1+等级/100)*560
		    ,治疗能力 = 等级*10+5000
		    ,封印命中等级=等级+150
		    ,抵抗封印等级=等级+150
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战","高级偷袭","高级独行","高级驱鬼","高级法术暴击","高级法术连击","高级魔之心"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
    }
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[2]={
    名称="。玛格利特`"
	,模型="进阶镜妖"
		    ,等级=等级+21
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*17000+420000
		    ,伤害 = qz(1+等级/50)*500+5000
		    ,法伤 = qz(1+等级/500)*410+2300
		    ,防御 = qz(1+等级/100)*360+2300
		    ,法防 = qz(1+等级/100)*260+1300
		    ,速度 = qz(1+等级/100)*260+1000
		    ,固定伤害 = qz(1+等级/100)*560
		    ,治疗能力 = 等级*10+5000
		    ,封印命中等级=等级+150
		    ,抵抗封印等级=等级+150
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机物理门派())
战斗单位[3]={
    名称="。齐国孟尝`"
	,模型="进阶云游火"
		    ,等级=等级+21
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*17000+420000
		    ,伤害 = qz(1+等级/50)*500+5000
		    ,法伤 = qz(1+等级/500)*410+2300
		    ,防御 = qz(1+等级/100)*360+2300
		    ,法防 = qz(1+等级/100)*260+1300
		    ,速度 = qz(1+等级/100)*260+1000
		    ,固定伤害 = qz(1+等级/100)*560
		    ,治疗能力 = 等级*10+5000
		    ,封印命中等级=等级+150
		    ,抵抗封印等级=等级+150
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机输出门派())
战斗单位[4]={
    名称="。武安李牧`"
	,模型="进阶月影仙"
		    ,等级=等级+21
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*17000+420000
		    ,伤害 = qz(1+等级/50)*500+5000
		    ,法伤 = qz(1+等级/500)*410+2300
		    ,防御 = qz(1+等级/100)*360+2300
		    ,法防 = qz(1+等级/100)*260+1300
		    ,速度 = qz(1+等级/100)*260+1000
		    ,固定伤害 = qz(1+等级/100)*560
		    ,治疗能力 = 等级*10+5000
		    ,封印命中等级=等级+150
		    ,抵抗封印等级=等级+150
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机法系门派())
for n=5,7 do
    战斗单位[n]={
    名称="百花村服战选手"
	,模型="自在天魔宝剑"
		    ,等级=等级+21
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*17000+420000
		    ,伤害 = qz(1+等级/50)*500+5000
		    ,法伤 = qz(1+等级/500)*410+2300
		    ,防御 = qz(1+等级/100)*360+2300
		    ,法防 = qz(1+等级/100)*260+1300
		    ,速度 = qz(1+等级/100)*260+1000
		    ,固定伤害 = qz(1+等级/100)*560
		    ,治疗能力 = 等级*10+5000
		    ,封印命中等级=等级+150
		    ,抵抗封印等级=等级+150
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机固伤门派())
战斗单位[8]={
    名称="百花村服战指挥"
	,模型="大力金刚"
		    ,等级=等级+21
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*17000+420000
		    ,伤害 = qz(1+等级/50)*500+5000
		    ,法伤 = qz(1+等级/500)*410+2300
		    ,防御 = qz(1+等级/100)*360+2300
		    ,法防 = qz(1+等级/100)*260+1300
		    ,速度 = qz(1+等级/100)*260+1000
		    ,固定伤害 = qz(1+等级/100)*560
		    ,治疗能力 = 等级*10+5000
		    ,封印命中等级=等级+150
		    ,抵抗封印等级=等级+150
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[9]={
    名称="。西府李元霸`"
	,模型="进阶金饶僧"
		    ,等级=等级+21
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*17000+420000
		    ,伤害 = qz(1+等级/50)*500+5000
		    ,法伤 = qz(1+等级/500)*410+2300
		    ,防御 = qz(1+等级/100)*360+2300
		    ,法防 = qz(1+等级/100)*260+1300
		    ,速度 = qz(1+等级/100)*260+1000
		    ,固定伤害 = qz(1+等级/100)*560
		    ,治疗能力 = 等级*10+5000
		    ,封印命中等级=等级+150
		    ,抵抗封印等级=等级+150
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[10]={
    名称="。杨府穆桂英`"
	,模型="炎魔神"
		    ,等级=等级+21
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*17000+420000
		    ,伤害 = qz(1+等级/50)*500+5000
		    ,法伤 = qz(1+等级/500)*410+2300
		    ,防御 = qz(1+等级/100)*360+2300
		    ,法防 = qz(1+等级/100)*260+1300
		    ,速度 = qz(1+等级/100)*260+1000
		    ,固定伤害 = qz(1+等级/100)*560
		    ,治疗能力 = 等级*10+5000
		    ,封印命中等级=等级+150
		    ,抵抗封印等级=等级+150
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
end
    return 战斗单位
end
-----------------------------------------------------------------------
function 怪物属性:取混乱终末的信标信息(任务id,玩家id,序号)--混乱终末的信标
	local 战斗单位={}
	local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	local xlz = qz(1+等级/50)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"}
	local 随机阵法 = {"天覆阵","地载阵","风扬阵","云垂阵","龙飞阵","虎翼阵","鸟翔阵","蛇蟠阵","鹰啸阵","雷绝阵"}
	local q门派 = qmenpai[i]--Q_门派编号[取随机数(1,#Q_门派编号)]
	local sx = self:取属性(等级,self:取随机输出门派())
战斗单位[1]={
    名称="四御∷紫禁城"
	,模型="自在天魔"
	,附加阵法=随机阵法[取随机数(1,#随机阵法)]
		    ,等级=等级+23
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*18000+450000
		    ,伤害 = qz(1+等级/50)*550+6000
		    ,法伤 = qz(1+等级/500)*430+2500
		    ,防御 = qz(1+等级/100)*380+2500
		    ,法防 = qz(1+等级/100)*280+1500
		    ,速度 = qz(1+等级/100)*280+1500
		    ,固定伤害 = qz(1+等级/100)*580
		    ,治疗能力 = 等级*10+6000
		    ,封印命中等级=等级+160
		    ,抵抗封印等级=等级+160
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战","高级偷袭","高级独行","高级驱鬼","高级法术暴击","高级法术连击","高级魔之心"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[2]={
    名称="神ぴ封徉。ミ"
	,模型="噬天虎"
		    ,等级=等级+23
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*18000+450000
		    ,伤害 = qz(1+等级/50)*550+6000
		    ,法伤 = qz(1+等级/500)*430+2500
		    ,防御 = qz(1+等级/100)*380+2500
		    ,法防 = qz(1+等级/100)*280+1500
		    ,速度 = qz(1+等级/100)*280+1500
		    ,固定伤害 = qz(1+等级/100)*580
		    ,治疗能力 = 等级*10+6000
		    ,封印命中等级=等级+160
		    ,抵抗封印等级=等级+160
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机物理门派())
战斗单位[3]={
    名称="造物主∷爆神"
	,模型="野猪精"
		    ,等级=等级+23
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*18000+450000
		    ,伤害 = qz(1+等级/50)*550+6000
		    ,法伤 = qz(1+等级/500)*430+2500
		    ,防御 = qz(1+等级/100)*380+2500
		    ,法防 = qz(1+等级/100)*280+1500
		    ,速度 = qz(1+等级/100)*280+1500
		    ,固定伤害 = qz(1+等级/100)*580
		    ,治疗能力 = 等级*10+6000
		    ,封印命中等级=等级+160
		    ,抵抗封印等级=等级+160
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机输出门派())
战斗单位[4]={
    名称="不负韶华、周"
	,模型="进阶炎魔神"
		    ,等级=等级+23
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*18000+450000
		    ,伤害 = qz(1+等级/50)*550+6000
		    ,法伤 = qz(1+等级/500)*430+2500
		    ,防御 = qz(1+等级/100)*380+2500
		    ,法防 = qz(1+等级/100)*280+1500
		    ,速度 = qz(1+等级/100)*280+1500
		    ,固定伤害 = qz(1+等级/100)*580
		    ,治疗能力 = 等级*10+6000
		    ,封印命中等级=等级+160
		    ,抵抗封印等级=等级+160
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机法系门派())
for n=5,7 do
    战斗单位[n]={
    名称="紫禁城服战选手"
	,模型="自在天魔经筒"
		    ,等级=等级+23
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*18000+450000
		    ,伤害 = qz(1+等级/50)*550+6000
		    ,法伤 = qz(1+等级/500)*430+2500
		    ,防御 = qz(1+等级/100)*380+2500
		    ,法防 = qz(1+等级/100)*280+1500
		    ,速度 = qz(1+等级/100)*280+1500
		    ,固定伤害 = qz(1+等级/100)*580
		    ,治疗能力 = 等级*10+6000
		    ,封印命中等级=等级+160
		    ,抵抗封印等级=等级+160
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机固伤门派())
战斗单位[8]={
    名称="紫禁城服战指挥"
	,模型="进阶百足将军"
		    ,等级=等级+23
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*18000+450000
		    ,伤害 = qz(1+等级/50)*550+6000
		    ,法伤 = qz(1+等级/500)*430+2500
		    ,防御 = qz(1+等级/100)*380+2500
		    ,法防 = qz(1+等级/100)*280+1500
		    ,速度 = qz(1+等级/100)*280+1500
		    ,固定伤害 = qz(1+等级/100)*580
		    ,治疗能力 = 等级*10+6000
		    ,封印命中等级=等级+160
		    ,抵抗封印等级=等级+160
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[9]={
    名称="BooM√胡椒"
	,模型="进阶踏云兽"
		    ,等级=等级+23
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*18000+450000
		    ,伤害 = qz(1+等级/50)*550+6000
		    ,法伤 = qz(1+等级/500)*430+2500
		    ,防御 = qz(1+等级/100)*380+2500
		    ,法防 = qz(1+等级/100)*280+1500
		    ,速度 = qz(1+等级/100)*280+1500
		    ,固定伤害 = qz(1+等级/100)*580
		    ,治疗能力 = 等级*10+6000
		    ,封印命中等级=等级+160
		    ,抵抗封印等级=等级+160
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[10]={
    名称="BooM√丝叔`"
	,模型="机关兽"
		    ,等级=等级+23
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*18000+450000
		    ,伤害 = qz(1+等级/50)*550+6000
		    ,法伤 = qz(1+等级/500)*430+2500
		    ,防御 = qz(1+等级/100)*380+2500
		    ,法防 = qz(1+等级/100)*280+1500
		    ,速度 = qz(1+等级/100)*280+1500
		    ,固定伤害 = qz(1+等级/100)*580
		    ,治疗能力 = 等级*10+6000
		    ,封印命中等级=等级+160
		    ,抵抗封印等级=等级+160
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
end
    return 战斗单位
end
-----------------------------------------------------------------------
function 怪物属性:取伟大虚空的信标信息(任务id,玩家id,序号)--伟大虚空的信标
	local 战斗单位={}
	local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	local xlz = qz(1+等级/50)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"}
	local 随机阵法 = {"天覆阵","地载阵","风扬阵","云垂阵","龙飞阵","虎翼阵","鸟翔阵","蛇蟠阵","鹰啸阵","雷绝阵"}
	local q门派 = qmenpai[i]--Q_门派编号[取随机数(1,#Q_门派编号)]
	local sx = self:取属性(等级,self:取随机输出门派())
    战斗单位[1]={
    名称="三清∷钓鱼岛"
	,模型="自在天魔"
	,附加阵法=随机阵法[取随机数(1,#随机阵法)]
		    ,等级=等级+25
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*20000+500000
		    ,伤害 = qz(1+等级/50)*580+7000
		    ,法伤 = qz(1+等级/500)*450+3000
		    ,防御 = qz(1+等级/100)*400+3000
		    ,法防 = qz(1+等级/100)*300+2000
		    ,速度 = qz(1+等级/100)*300+2000
		    ,固定伤害 = qz(1+等级/100)*600
		    ,治疗能力 = 等级*10+7000
		    ,封印命中等级=等级+180
		    ,抵抗封印等级=等级+180
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战","高级偷袭","高级独行","高级驱鬼","高级法术暴击","高级法术连击","高级魔之心"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[2]={
    名称="惊心一套.げ"
	,模型="进阶机关人人形"
		    ,等级=等级+25
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*20000+500000
		    ,伤害 = qz(1+等级/50)*580+7000
		    ,法伤 = qz(1+等级/500)*450+3000
		    ,防御 = qz(1+等级/100)*400+3000
		    ,法防 = qz(1+等级/100)*300+2000
		    ,速度 = qz(1+等级/100)*300+2000
		    ,固定伤害 = qz(1+等级/100)*600
		    ,治疗能力 = 等级*10+7000
		    ,封印命中等级=等级+180
		    ,抵抗封印等级=等级+180
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机物理门派())
战斗单位[3]={
    名称="小打小闹`"
	,模型="进阶连弩车"
		    ,等级=等级+25
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*20000+500000
		    ,伤害 = qz(1+等级/50)*580+7000
		    ,法伤 = qz(1+等级/500)*450+3000
		    ,防御 = qz(1+等级/100)*400+3000
		    ,法防 = qz(1+等级/100)*300+2000
		    ,速度 = qz(1+等级/100)*300+2000
		    ,固定伤害 = qz(1+等级/100)*600
		    ,治疗能力 = 等级*10+7000
		    ,封印命中等级=等级+180
		    ,抵抗封印等级=等级+180
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机输出门派())
战斗单位[4]={
    名称="匿名玩家み"
	,模型="进阶巴蛇"
		    ,等级=等级+25
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*20000+500000
		    ,伤害 = qz(1+等级/50)*580+7000
		    ,法伤 = qz(1+等级/500)*450+3000
		    ,防御 = qz(1+等级/100)*400+3000
		    ,法防 = qz(1+等级/100)*300+2000
		    ,速度 = qz(1+等级/100)*300+2000
		    ,固定伤害 = qz(1+等级/100)*600
		    ,治疗能力 = 等级*10+7000
		    ,封印命中等级=等级+180
		    ,抵抗封印等级=等级+180
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机法系门派())
for n=5,7 do
    战斗单位[n]={
    名称="钓鱼岛服战选手"
	,模型="自在天魔法杖"
		    ,等级=等级+25
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*20000+500000
		    ,伤害 = qz(1+等级/50)*580+7000
		    ,法伤 = qz(1+等级/500)*450+3000
		    ,防御 = qz(1+等级/100)*400+3000
		    ,法防 = qz(1+等级/100)*300+2000
		    ,速度 = qz(1+等级/100)*300+2000
		    ,固定伤害 = qz(1+等级/100)*600
		    ,治疗能力 = 等级*10+7000
		    ,封印命中等级=等级+180
		    ,抵抗封印等级=等级+180
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机固伤门派())
战斗单位[8]={
    名称="钓鱼岛服战指挥"
	,模型="进阶犀牛将军人形"
		    ,等级=等级+25
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*20000+500000
		    ,伤害 = qz(1+等级/50)*580+7000
		    ,法伤 = qz(1+等级/500)*450+3000
		    ,防御 = qz(1+等级/100)*400+3000
		    ,法防 = qz(1+等级/100)*300+2000
		    ,速度 = qz(1+等级/100)*300+2000
		    ,固定伤害 = qz(1+等级/100)*600
		    ,治疗能力 = 等级*10+7000
		    ,封印命中等级=等级+180
		    ,抵抗封印等级=等级+180
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[9]={
    名称="小熊桐桐`い"
	,模型="狂豹兽形"
		    ,等级=等级+25
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*20000+500000
		    ,伤害 = qz(1+等级/50)*580+7000
		    ,法伤 = qz(1+等级/500)*450+3000
		    ,防御 = qz(1+等级/100)*400+3000
		    ,法防 = qz(1+等级/100)*300+2000
		    ,速度 = qz(1+等级/100)*300+2000
		    ,固定伤害 = qz(1+等级/100)*600
		    ,治疗能力 = 等级*10+7000
		    ,封印命中等级=等级+180
		    ,抵抗封印等级=等级+180
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[10]={
    名称="叁伍柒`キ`"
	,模型="进阶白豹"
		    ,等级=等级+25
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*20000+500000
		    ,伤害 = qz(1+等级/50)*580+7000
		    ,法伤 = qz(1+等级/500)*450+3000
		    ,防御 = qz(1+等级/100)*400+3000
		    ,法防 = qz(1+等级/100)*300+2000
		    ,速度 = qz(1+等级/100)*300+2000
		    ,固定伤害 = qz(1+等级/100)*600
		    ,治疗能力 = 等级*10+7000
		    ,封印命中等级=等级+180
		    ,抵抗封印等级=等级+180
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
end
    return 战斗单位
end
-----------------------------------------------------------------------
function 怪物属性:取巅峰领域的信标信息(任务id,玩家id,序号)---巅峰领域的信标
	local 战斗单位={}
	local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	local xlz = qz(1+等级/50)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"}
	local 随机阵法 = {"天覆阵","地载阵","风扬阵","云垂阵","龙飞阵","虎翼阵","鸟翔阵","蛇蟠阵","鹰啸阵","雷绝阵"}
	local q门派 = qmenpai[i]--Q_门派编号[取随机数(1,#Q_门派编号)]
	local sx = self:取属性(等级,self:取随机输出门派())
          战斗单位[1]={
          名称="二神∷珍宝阁"
	      ,模型="自在天魔"
	      ,附加阵法=随机阵法[取随机数(1,#随机阵法)]
		    ,等级=等级+28
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*22000+600000
		    ,伤害 = qz(1+等级/50)*600+9000
		    ,法伤 = qz(1+等级/500)*480+3500
		    ,防御 = qz(1+等级/100)*420+3500
		    ,法防 = qz(1+等级/100)*320+2500
		    ,速度 = qz(1+等级/100)*320+2500
		    ,固定伤害 = qz(1+等级/100)*800
		    ,治疗能力 = 等级*10+8000
		    ,封印命中等级=等级+200
		    ,抵抗封印等级=等级+200
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战","高级偷袭","高级独行","高级驱鬼","高级法术暴击","高级法术连击","高级魔之心"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,q门派)
战斗单位[2]={
    名称="念慈悲度众生"
	,模型="进阶修罗傀儡鬼"
		    ,等级=等级+28
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*22000+600000
		    ,伤害 = qz(1+等级/50)*600+9000
		    ,法伤 = qz(1+等级/500)*480+3500
		    ,防御 = qz(1+等级/100)*420+3500
		    ,法防 = qz(1+等级/100)*320+2500
		    ,速度 = qz(1+等级/100)*320+2500
		    ,固定伤害 = qz(1+等级/100)*800
		    ,治疗能力 = 等级*10+8000
		    ,封印命中等级=等级+200
		    ,抵抗封印等级=等级+200
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机物理门派())
战斗单位[3]={
    名称="春已至万物始"
	,模型="巨力神猿"
		    ,等级=等级+28
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*22000+600000
		    ,伤害 = qz(1+等级/50)*600+9000
		    ,法伤 = qz(1+等级/500)*480+3500
		    ,防御 = qz(1+等级/100)*420+3500
		    ,法防 = qz(1+等级/100)*320+2500
		    ,速度 = qz(1+等级/100)*320+2500
		    ,固定伤害 = qz(1+等级/100)*800
		    ,治疗能力 = 等级*10+8000
		    ,封印命中等级=等级+200
		    ,抵抗封印等级=等级+200
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机输出门派())
战斗单位[4]={
    名称="朝碧海暮苍梧"
	,模型="进阶巨力神猿"
		    ,等级=等级+28
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*22000+600000
		    ,伤害 = qz(1+等级/50)*600+9000
		    ,法伤 = qz(1+等级/500)*480+3500
		    ,防御 = qz(1+等级/100)*420+3500
		    ,法防 = qz(1+等级/100)*320+2500
		    ,速度 = qz(1+等级/100)*320+2500
		    ,固定伤害 = qz(1+等级/100)*800
		    ,治疗能力 = 等级*10+8000
		    ,封印命中等级=等级+200
		    ,抵抗封印等级=等级+200
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机法系门派())
for n=5,7 do
    战斗单位[n]={
    名称="珍宝阁服战选手"
	,模型="进阶雷龙"
		    ,等级=等级+28
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*22000+600000
		    ,伤害 = qz(1+等级/50)*600+9000
		    ,法伤 = qz(1+等级/500)*480+3500
		    ,防御 = qz(1+等级/100)*420+3500
		    ,法防 = qz(1+等级/100)*320+2500
		    ,速度 = qz(1+等级/100)*320+2500
		    ,固定伤害 = qz(1+等级/100)*800
		    ,治疗能力 = 等级*10+8000
		    ,封印命中等级=等级+200
		    ,抵抗封印等级=等级+200
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机固伤门派())
战斗单位[8]={
    名称="珍宝阁服战指挥"
	,模型="进阶金身罗汉"
		    ,等级=等级+28
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*22000+600000
		    ,伤害 = qz(1+等级/50)*600+9000
		    ,法伤 = qz(1+等级/500)*480+3500
		    ,防御 = qz(1+等级/100)*420+3500
		    ,法防 = qz(1+等级/100)*320+2500
		    ,速度 = qz(1+等级/100)*320+2500
		    ,固定伤害 = qz(1+等级/100)*800
		    ,治疗能力 = 等级*10+8000
		    ,封印命中等级=等级+200
		    ,抵抗封印等级=等级+200
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[9]={
    名称="雪一更山一程"
	,模型="蜃气妖"
		    ,等级=等级+28
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*22000+600000
		    ,伤害 = qz(1+等级/50)*600+9000
		    ,法伤 = qz(1+等级/500)*480+3500
		    ,防御 = qz(1+等级/100)*420+3500
		    ,法防 = qz(1+等级/100)*320+2500
		    ,速度 = qz(1+等级/100)*320+2500
		    ,固定伤害 = qz(1+等级/100)*800
		    ,治疗能力 = 等级*10+8000
		    ,封印命中等级=等级+200
		    ,抵抗封印等级=等级+200
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
	local q门派 = qmenpai[i]
	local sx = self:取属性(等级,self:取随机封系门派())
战斗单位[10]={
    名称="雁在云鱼在水`"
	,模型="进阶有苏鸩"
		    ,等级=等级+28
		    ,递增伤害=true
		    ,气血 = qz(1+等级/50)*22000+600000
		    ,伤害 = qz(1+等级/50)*600+9000
		    ,法伤 = qz(1+等级/500)*480+3500
		    ,防御 = qz(1+等级/100)*420+3500
		    ,法防 = qz(1+等级/100)*320+2500
		    ,速度 = qz(1+等级/100)*320+2500
		    ,固定伤害 = qz(1+等级/100)*800
		    ,治疗能力 = 等级*10+8000
		    ,封印命中等级=等级+200
		    ,抵抗封印等级=等级+200
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
}
end
    return 战斗单位
end
---------------------------------------------↑↑↑↑↑↑↑-------------------------------------------
function 怪物属性:取黑神话信息(任务id,玩家id,序号)
	local 战斗单位={}
	local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	local 难度=任务数据[任务id].难度
	local 小怪名称={"清心羽客"}
	local xlz = qz(1+难度/10+等级/100)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"}
	for i=1,1 do
		local q门派 = qmenpai[i]--Q_门派编号[取随机数(1,#Q_门派编号)]
		local sx = self:取属性(等级,q门派)
	    战斗单位[1]={
			名称=任务数据[任务id].名称
			,模型=任务数据[任务id].模型
		    ,等级=等级+15+11
		    ,递增伤害=true
		    ,气血 = qz(1+难度/10+等级/50)*20000+250000
		    ,伤害 = qz(1+难度/10+等级/50)*1000+2500
		    ,法伤 = qz(1+难度/10+等级/500)*500+1500
		    ,防御 = qz(1+难度/10+等级/100)*500+1500
		    ,法防 = qz(1+难度/10+等级/100)*500+800
		    ,速度 = qz(1+难度/10+等级/100)*300+500
		    ,固定伤害 = qz(1+难度/10+等级/100)*500
		    ,治疗能力 = 等级*15+3500
		    ,封印命中等级=等级+100
		    ,抵抗封印等级=等级+100
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
		    ,技能={"高级感知","高级幸运","高级吸血","高级必杀","高级神迹","高级夜战"}
		    ,门派=sx.门派
		    ,AI战斗 = {AI=sx.智能}
		}
	end
	 for i=2,2 do
	 	local q门派 = qmenpai[i]
	 	local sx = self:取属性(等级,q门派)
	 	战斗单位[i]={
	 		名称=小怪名称[取随机数(1,#小怪名称)]
	 		,模型="白豹"
	 	    ,等级=等级+15+10
	 	    ,气血 = qz(1+难度/10+等级/50)*18000+200000
		    ,伤害 = qz(1+难度/10+等级/50)*1000+2200
		    ,法伤 = qz(1+难度/10+等级/500)*500+1200
		    ,防御 = qz(1+难度/10+等级/100)*500+1000
		    ,法防 = qz(1+难度/10+等级/100)*500+300
		    ,速度 = qz(1+难度/10+等级/100)*200+100
		    ,固定伤害 = qz(1+难度/10+等级/100)*500
		    ,治疗能力 = 等级*15+3500
		    ,封印命中等级=等级+100
		    ,抵抗封印等级=等级+100
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
	 	    ,技能={"高级感知","高级必杀","高级吸血","高级幸运"}
	 	    ,门派=sx.门派
	 	    ,AI战斗 = {AI=sx.智能}
	 	}
	 end
	 	for i=3,3 do
	 	local q门派 = qmenpai[i]
	 	local sx = self:取属性(等级,q门派)
	 	战斗单位[i]={
	 		名称=小怪名称[取随机数(1,#小怪名称)]
	 		,模型="白豹"
	 	    ,等级=等级+15+10
	 	    ,气血 = qz(1+难度/10+等级/50)*18000+200000
		    ,伤害 = qz(1+难度/10+等级/50)*1000+2200
		    ,法伤 = qz(1+难度/10+等级/500)*500+1200
		    ,防御 = qz(1+难度/10+等级/100)*500+1000
		    ,法防 = qz(1+难度/10+等级/100)*500+300
		    ,速度 = qz(1+难度/10+等级/100)*200+100
		    ,固定伤害 = qz(1+难度/10+等级/100)*500
		    ,治疗能力 = 等级*15+3500
		    ,封印命中等级=等级+100
		    ,抵抗封印等级=等级+100
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
    	    ,技能={"高级感知","高级偷袭","高级强力"}
	 	    ,门派=sx.门派
	 	    ,AI战斗 = {AI=sx.智能}
	 	}
	 end
	 	for i=4,4 do
	 	local q门派 = qmenpai[i]
	 	local sx = self:取属性(等级,q门派)
	 	战斗单位[i]={
	 		名称=小怪名称[取随机数(1,#小怪名称)]
	 		,模型="白豹"
	 	    ,等级=等级+15+10
	 	    ,气血 = qz(1+难度/10+等级/50)*18000+200000
		    ,伤害 = qz(1+难度/10+等级/50)*1000+2200
		    ,法伤 = qz(1+难度/10+等级/500)*500+1200
		    ,防御 = qz(1+难度/10+等级/100)*500+1000
		    ,法防 = qz(1+难度/10+等级/100)*500+300
		    ,速度 = qz(1+难度/10+等级/100)*200+100
		    ,固定伤害 = qz(1+难度/10+等级/100)*500
		    ,治疗能力 = 等级*15+3500
		    ,封印命中等级=等级+100
		    ,抵抗封印等级=等级+100
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
    	    ,技能={"高级感知","高级必杀","高级夜战"}
	 	    ,门派=sx.门派
	 	    ,AI战斗 = {AI=sx.智能}
	 	}
	 	end
	 	for i=5,5 do
	 	local q门派 = qmenpai[i]
	 	local sx = self:取属性(等级,q门派)
	 	战斗单位[i]={
	 		名称=小怪名称[取随机数(1,#小怪名称)]
	 		,模型="白豹"
	 	    ,等级=等级+15+10
	 	    ,气血 = qz(1+难度/10+等级/50)*18000+200000
		    ,伤害 = qz(1+难度/10+等级/50)*1000
		    ,法伤 = qz(1+难度/10+等级/500)*500+1200
		    ,防御 = qz(1+难度/10+等级/100)*500+1000
		    ,法防 = qz(1+难度/10+等级/100)*500+300
		    ,速度 = qz(1+难度/10+等级/100)*200+100
		    ,固定伤害 = qz(1+难度/10+等级/100)*500
		    ,治疗能力 = 等级*15
		    ,封印命中等级=等级+100
		    ,抵抗封印等级=等级+100
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
    	    ,技能={"高级感知","高级魔之心","高级法术连击"}
	 	    ,门派=sx.门派
	 	    ,AI战斗 = {AI=sx.智能}
	 	}
	 end
	 	for i=6,6 do
	 	local q门派 = qmenpai[i]
	 	local sx = self:取属性(等级,q门派)
	 	战斗单位[i]={
	 		名称=小怪名称[取随机数(1,#小怪名称)]
	 		,模型="白豹"
	 	    ,等级=等级+15+10
	 	    ,气血 = qz(1+难度/10+等级/50)*18000+200000
		    ,伤害 = qz(1+难度/10+等级/50)*1000
		    ,法伤 = qz(1+难度/10+等级/500)*500+1200
		    ,防御 = qz(1+难度/10+等级/100)*500+1200
		    ,法防 = qz(1+难度/10+等级/100)*500+300
		    ,速度 = qz(1+难度/10+等级/100)*200+100
		    ,固定伤害 = qz(1+难度/10+等级/100)*500
		    ,治疗能力 = 等级*15
		    ,封印命中等级=等级+100
		    ,抵抗封印等级=等级+100
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
    	    ,技能={"高级感知","高级法术暴击"}
	 	    ,门派=sx.门派
	 	    ,AI战斗 = {AI=sx.智能}
	 	}
	 end
	 	for i=7,7 do
	 	local q门派 = qmenpai[i]
	 	local sx = self:取属性(等级,q门派)
	 	战斗单位[i]={
	 		名称=小怪名称[取随机数(1,#小怪名称)]
	 		,模型="白豹"
	 	    ,等级=等级+15+10
	 	    ,气血 = qz(1+难度/10+等级/50)*18000+200000
		    ,伤害 = qz(1+难度/10+等级/50)*1000
		    ,法伤 = qz(1+难度/10+等级/500)*500+1200
		    ,防御 = qz(1+难度/10+等级/100)*500+1000
		    ,法防 = qz(1+难度/10+等级/100)*500+300
		    ,速度 = qz(1+难度/10+等级/100)*200+100
		    ,固定伤害 = qz(1+难度/10+等级/100)*500
		    ,治疗能力 = 等级*15
		    ,封印命中等级=等级+100
		    ,抵抗封印等级=等级+100
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
    	    ,技能={"高级感知","高级法术连击"}
	 	    ,门派=sx.门派
	 	    ,AI战斗 = {AI=sx.智能}
	 	}
	 end
	 	for i=8,8 do
	 	local q门派 = qmenpai[i]
	 	local sx = self:取属性(等级,q门派)
	 	战斗单位[i]={
	 		名称=小怪名称[取随机数(1,#小怪名称)]
	 		,模型="白豹"
	 	    ,等级=等级+15+10
	 	    ,气血 = qz(1+难度/10+等级/50)*18000+220000
		    ,伤害 = qz(1+难度/10+等级/50)*1000
		    ,法伤 = qz(1+难度/10+等级/500)*500
		    ,防御 = qz(1+难度/10+等级/100)*500+1300
		    ,法防 = qz(1+难度/10+等级/100)*500+500
		    ,速度 = qz(1+难度/10+等级/100)*200+200
		    ,固定伤害 = qz(1+难度/10+等级/100)*500
		    ,治疗能力 = 等级*15+3500
		    ,封印命中等级=等级+100
		    ,抵抗封印等级=等级+100
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
    	    ,技能={"高级感知","高级敏捷","高级幸运"}
	 	    ,门派=sx.门派
	 	    ,AI战斗 = {AI=sx.智能}
	 	}
	 end
	 	for i=9,9 do
	 	local q门派 = qmenpai[i]
	 	local sx = self:取属性(等级,q门派)
	 	战斗单位[i]={
	 		名称=小怪名称[取随机数(1,#小怪名称)]
	 		,模型="白豹"
	 	    ,等级=等级+15+10
	 	    ,气血 = qz(1+难度/10+等级/50)*18000+220000
		    ,伤害 = qz(1+难度/10+等级/50)*1000+2200
		    ,法伤 = qz(1+难度/10+等级/500)*500
		    ,防御 = qz(1+难度/10+等级/100)*500+1300
		    ,法防 = qz(1+难度/10+等级/100)*500+500
		    ,速度 = qz(1+难度/10+等级/100)*200+300
		    ,固定伤害 = qz(1+难度/10+等级/100)*800
		    ,治疗能力 = 等级*15+3500
		    ,封印命中等级=等级+300
		    ,抵抗封印等级=等级+100
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
    	    ,技能={"高级感知","高级敏捷","高级幸运"}
	 	    ,门派=sx.门派
	 	    ,AI战斗 = {AI=sx.智能}
	 	}
	 end
	 	for i=10,10 do
	 	local q门派 = qmenpai[i]
	 	local sx = self:取属性(等级,q门派)
	 	战斗单位[i]={
	 		名称=小怪名称[取随机数(1,#小怪名称)]
	 		,模型="白豹"
	 	    ,等级=等级+15+10
	 	    ,气血 = qz(1+难度/10+等级/50)*18000+220000
		    ,伤害 = qz(1+难度/10+等级/50)*1000
		    ,法伤 = qz(1+难度/10+等级/500)*500
		    ,防御 = qz(1+难度/10+等级/100)*500+1300
		    ,法防 = qz(1+难度/10+等级/100)*500+500
		    ,速度 = qz(1+难度/10+等级/100)*200+200
		    ,固定伤害 = qz(1+难度/10+等级/100)*500
		    ,治疗能力 = 等级*15+3500
		    ,封印命中等级=等级+100
		    ,抵抗封印等级=等级+100
            ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
    	    ,技能={"高级感知","高级敏捷","高级鬼魂术"}
	 	    ,门派=sx.门派
	 	    ,AI战斗 = {AI=sx.智能}
	 	}
	 	end
	return 战斗单位
end
---------------------------------------------麻瓜剑会
function 怪物属性:取剑会假人信息(任务id,玩家id,序号)
	local 战斗单位={}
	local 假人 = 剑会天下:战斗取假人信息(玩家id)
	local 等级 = 175
	if 玩家数据[玩家id] ~= nil and 玩家数据[玩家id].角色.等级 then
		等级=玩家数据[玩家id].角色.等级+0
	end
	if 假人 then
		local xx = 等级/50
		for n=1,5 do
			local 武器属性=取150角色武器(假人[n].模型)
			战斗单位[n]={
			名称=假人[n].名称
			,角色=true
			,武器={名称=武器属性.武器,级别限制=武器属性.级别,子类=武器属性.子类}
			,门派=假人[n].门派
			,模型=假人[n].模型
			,伤害= math.floor(Q_武神坛角色属性[假人[n].门派].伤害*xx)
			,气血= math.floor(Q_武神坛角色属性[假人[n].门派].气血*xx)*2
			,法伤= math.floor(Q_武神坛角色属性[假人[n].门派].法伤*xx)
			,速度= math.floor(Q_武神坛角色属性[假人[n].门派].速度*xx)
			,防御= math.floor(Q_武神坛角色属性[假人[n].门派].防御*xx)
			,法防= math.floor(Q_武神坛角色属性[假人[n].门派].法防*xx)
			,躲闪= math.floor(Q_武神坛角色属性[假人[n].门派].躲闪*xx)
			,魔法= 50000
			,等级=等级
			,技能={}
			,主动技能=Q_武神坛门派法术[假人[n].门派]
			}
		end
		for n=6,10 do
			local qxg=Q_小怪模型[取随机数(1,#Q_小怪模型)]
	    	战斗单位[n]={
	        名称=qxg
	        ,模型=qxg
			,伤害=math.floor(Q_武神坛角色属性[假人[n-5].门派].伤害*xx)
			,气血=math.floor(Q_武神坛角色属性[假人[n-5].门派].气血*xx)*2
			,法伤=math.floor(Q_武神坛角色属性[假人[n-5].门派].法伤*xx)
			,速度=500
			,防御=math.floor(Q_武神坛角色属性[假人[n-5].门派].防御*xx)
			,法防=math.floor(Q_武神坛角色属性[假人[n-5].门派].法防*xx)
			,躲闪=100
			,魔法=20000
			,等级=等级
			,技能={}
			,主动技能=取随机法术(3)
			}
	    end
	else
	    for n=1,10 do
	    	战斗单位[n]={
	        名称="剑会假人"
	        ,模型="进阶画魂"
			,伤害=等级 * 25
			,气血=等级 * 200
			,法伤=1500
			,速度=500
			,防御=2000
			,法防=2500
			,躲闪=1000
			,魔法=20000
			,等级=等级
			,技能={}
			,主动技能=取随机法术(3)
			}
	    end
	end
	return 战斗单位
end
---------------------------------------------

function 怪物属性:武神坛蚩尤信息(任务id,玩家id,序号) --武神坛BOSS
	--这里任务id我用来做成难度
	local 名称组={"武神坛BOSS","龠兹","后土","强良","奢比尸","祝融","共工","玄冥","蓐收","天吴"}
	local 模型组={"蚩尤","进阶蝎子精","进阶净瓶女娲","进阶巨力神猿","进阶吸血鬼","进阶黑山老妖","进阶蚌精","进阶雨师","进阶雾中仙","进阶蛟龙"}
	local 战斗单位={}
	local zgmp = {"大唐官府","神木林","魔王寨", "狮驼岭","天宫","凌波城","龙宫"}
	local xgmp={
		物 = {"大唐官府","狮驼岭","天宫","凌波城"},
		法 = {"神木林","魔王寨","龙宫"},
		封 = {"方寸山", "女儿村","盘丝洞"},
		辅 = {"化生寺","普陀山","五庄观"}
	}
	local qxg={"","法","法","物","物","法","法","辅","封","物"}
	local sx = {}
	sx[1] = self:取属性(180,zgmp[取随机数(1,#zgmp)],"物法")
	for an=2,10 do
		local qmpz = xgmp[qxg[an]]
		local jdmp = qmpz[取随机数(1,#qmpz)]
		sx[an] = self:取属性(180,jdmp,"物法")
	end
	战斗单位[1]={
		名称="武神坛BOSS"
		,模型="自在天魔"
		,等级=180
		,气血 = qz(sx[1].属性.气血*100*(1+任务id*0.1))
		,伤害 = 4500*(1+任务id*0.1)
		,法伤 = 3500*(1+任务id*0.1)
		,速度 = 1000*(1+任务id*0.1)
		-- ,饰品显示=true
		 ,不可封印=true
		,防御 = 600*(1+任务id*0.1)
		,法防 = 600*(1+任务id*0.1)
		,治疗能力 =2500*(1+任务id*0.1)
		,固定伤害 =1500*(1+任务id*0.1)
		,愤怒 = 9999
		,技能={"高级感知","高级神迹","高级必杀","高级法术连击"}
		,门派=sx[1].门派
		,AI战斗 = {AI=sx[1].智能}
		,附加阵法="天覆阵"
		,难度 = 任务id
	}
	for an=2,10 do
		战斗单位[an]={
		名称=名称组[an]
		,模型=模型组[an]
		,等级=180
		,气血 = qz(sx[an].属性.气血*100*(1+任务id*0.1))
		,伤害 = 4000*(1+任务id*0.1)
		,法伤 = 3500*(1+任务id*0.1)
		,速度 = 600*(1+任务id*0.1)
		,防御 = 600*(1+任务id*0.1)
		,法防 = 600*(1+任务id*0.1)
		,治疗能力 =2500*(1+任务id*0.1)
		,固定伤害 =1000*(1+任务id*0.1)
		,愤怒 = 9999
		,饰品显示=true
		,技能={"高级感知","高级幸运","高级反震"}
		,门派=sx[an].门派
		,AI战斗 = {AI=sx[an].智能}
		,难度 = 任务id
	    }
	end
	战斗单位[6].开场发言= "本场难度:#Y/" ..任务id .."\n本场难度:#R/" ..任务id .."\n本场难度:#G/" ..任务id
	return 战斗单位
end
--新增 #11
function 怪物属性:取比武假人信息(任务id,玩家id,序号) --比武
-- 	 local 战斗单位={}
-- 	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
-- 	 local menpai=Q_门派编号[任务数据[任务id].序列]
-- 	 local AI流派
-- 	 if menpai=="化生寺" then
-- 		  AI流派={"法系","法系","辅助"}
-- 	 elseif menpai=="普陀山" then
-- 		  AI流派={"固伤","固伤","辅助"}
-- 	 elseif menpai=="无底洞" then
-- 		  AI流派={"固伤","固伤","辅助"}
-- 	 elseif menpai=="方寸山" then
-- 		  AI流派={"法系","法系","封系"}
-- 	 elseif menpai=="女儿村" then
-- 		  AI流派={"物理","封系","固伤","固伤"}
-- 	 elseif menpai=="盘丝洞" then
-- 		  AI流派={"物理","封系","固伤"}
-- 	 elseif menpai=="天宫" then
-- 		  AI流派={"法系","法系","物理","封系"}
-- 	 elseif menpai=="五庄观" then
-- 		  AI流派={"物理","封系","物理"}
-- 	 elseif menpai=="龙宫" or menpai=="魔王寨" or menpai=="神木林" then
-- 		  AI流派={"法系"}
-- 	 elseif menpai=="阴曹地府" then
-- 		  AI流派={"物理","物理","固伤"}
-- 	 else
-- 		  AI流派={"物理"}
-- 	 end
-- 	 local lp = AI流派[取随机数(1,#AI流派)]
-- 	 local sx = self:取属性(等级,menpai,lp)
-- 	 local 小怪名称={"术精岐黄","铜墙铁壁","力大无穷","飞檐走壁","外强中干","救死扶伤","固若金汤","身强体壮","铜墙铁壁","杏林高手","生龙活虎","拔山扛鼎","萌萌"}
-- 	 local 小怪模型={"龙马","巨蛙","大海龟","护卫","树怪","赌徒","强盗","海毛虫","大蝙蝠","山贼","野猪","骷髅怪",
--      "羊头怪","老虎","黑熊","花妖","狐狸精","牛妖","小龙女","野鬼","狼","虾兵","蟹将","龟丞相","兔子怪"}

-- 	 战斗单位[1]={
-- 		  名称=任务数据[任务id].名称
-- 		  ,模型=任务数据[任务id].模型
-- 		  ,等级=等级
-- 		  ,武器 = 取武器数据(任务数据[任务id].武器,120)
-- 		  ,角色=true
-- 		  ,气血 = qz(sx.属性.气血 )*2
-- 		  ,伤害 = qz(sx.属性.伤害 )
-- 		  ,法伤 = qz(sx.属性.法伤 )
-- 		  ,速度 = qz(sx.属性.速度 )
-- 		  ,固定伤害 = qz(等级 )
-- 		  ,治疗能力 = qz(等级 )
-- 		  ,技能={"感知"}
-- 		  ,门派=sx.门派
-- 		  ,AI战斗 = {AI=lp}
-- 	 }
-- 	 for i=2,5 do
-- 	 	-------------------------随机取名
-- 		local xms=取随机数(2,5)
-- 		local xm=""
-- 		for nv=1,xms do
-- 			xm=xm ..Q_取单字[取随机数(1,#Q_取单字)]
-- 		end
-- 		local qmx=取随机数(1,15)
-- 		-------------------------
-- 		  lp = AI流派[取随机数(1,#AI流派)]
-- 		  sx = self:取属性(等级,menpai,lp)
-- 		  战斗单位[i]={
-- 				名称=xm
-- 				,角色=true
-- 				,模型=Q_随机模型[qmx]
-- 				,武器 = 取武器数据(Q_随机武器[Q_随机模型[qmx]][7],120)
-- 				,等级=等级
-- 				,气血 = qz(sx.属性.气血 )
-- 				,伤害 = qz(sx.属性.伤害 )
-- 				,法伤 = qz(sx.属性.法伤 )
-- 				,速度 = qz(sx.属性.速度 )
-- 				,技能={"感知"}
-- 				,门派=sx.门派
-- 				,AI战斗 = {AI=lp}
-- 		  }
-- 	 end
-- 	 for i=6,10 do
-- 		  sx = self:取属性(等级)
-- 		  战斗单位[i]={
-- 				名称=小怪名称[取随机数(1,#小怪名称)]
-- 				,模型=小怪模型[取随机数(1,#小怪模型)]
-- 				,等级=等级
-- 				,气血 = qz(sx.属性.气血 )
-- 				,伤害 = qz(sx.属性.伤害 )
-- 				,法伤 = qz(sx.属性.法伤 )
-- 				,速度 = qz(sx.属性.速度 )
-- 				,技能={"感知"}
-- 				,主动技能=sx.技能组
-- 		  }
-- 	 end
-- 	 return 战斗单位
  end

function 怪物属性:沉默分身信息(任务id,玩家id,序号) --这要取难度设置不同强度
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 local 难度=任务数据[任务id].难度
	 local xlz = qz(1+难度/10+等级/100)*10 + 6 --怪修炼
	 for i=1,1 do
		  战斗单位[i]={
				名称=任务数据[任务id].名称
			   ,模型=任务数据[任务id].模型
			   ,等级=等级+10
			   -- ,变异=true
			   -- ,炫彩=取染色id(任务数据[任务id].模型)
			   -- ,炫彩组=取炫彩染色(任务数据[任务id].炫彩颜色)
			   ,气血 = 999000000000
			   ,伤害 = qz(1+难度/10+等级/50)*250+500
			   ,法伤 = qz(1+难度/10+等级/500)*250+500
			   ,防御 = qz(1+难度/10+等级/100)*400+300
			   ,法防 = qz(1+难度/10+等级/100)*400+300
			   ,速度 = qz(1+难度/10+等级/100)*200 + 100
			   ,固定伤害 = qz(1+难度/10+等级/100)*500
			   ,治疗能力 = 等级+10
			   ,封印命中等级=等级+10
			   ,抵抗封印等级=等级+10
               ,修炼 = {物抗=xlz,法抗=xlz,攻修=xlz}
			   ,饰品显示=true
			   ,技能={"高级感知","高级招架","高级法术连击","高级冥思","高级慧根"}
			   ,主动技能={"八凶法阵","力劈华山","龙卷雨击","善恶有报","飞砂走石","雷霆万钧","天雷斩","泰山压顶","龙吟"}
			   ,招式特效={龙卷雨击=true}
		  }
	 end
	 战斗单位[1].开场发言="需战斗10回合以上才能算入排名"
	 return 战斗单位
end

function 怪物属性:大闹雷神(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 模型范围={"鬼将","吸血鬼"}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级,"天宫","法系")
	 战斗单位[1]={
		  名称="上古雷神"
		  ,模型="进阶谛听"
		  ,等级=等级
		  ,饰品=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 18)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.8)
		  ,技能={"高级神迹"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="雷神分身"
				,模型="谛听"
				,等级=等级
				,变异=true
				,气血 = qz(sx.属性.气血 * 整体加强A * 18)
				,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.6)
				,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.6)
				,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.8)
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	  for i=4,6 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天雷滚滚"
				,模型="风伯"
				,变异=true
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 18)
				,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.6)
				,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.6)
				,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.8)
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=7,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="冥府援军"
				,模型=模型范围[取随机数(1,#模型范围)]
				,变异=true
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 18)
				,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.6)
				,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.6)
				,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.8)
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:大闹二郎神(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级,"大唐官府","物理")
	 战斗单位[1]={
		  名称="二郎真君"
		  ,模型="二郎神"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 17)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.8)
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
				名称="惠岸行者"
				,模型="净瓶女娲"
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 16)
				,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.7)
				,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.7)
				,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.7)
				,技能={"感知"}
				,主动技能=sx.技能组
	 }
	 for i=3,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天将"
				,模型="天将"
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 16)
				,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.7)
				,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.7)
				,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.7)
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:大闹天将(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 战斗单位[1]={
	    名称="天将统领"
		,模型="天将"
		,伤害=等级*10
		,变异=true
		,气血=等级*等级*0.5+5000
		,法伤=等级*9
		,速度=等级*2
		,防御=等级*8
		,法防=等级
		,躲闪=等级*2
		,魔法=200
		,等级=等级
		,技能={}
		,主动技能=取随机法术(8)
	 }
	 for i=2,8 do
		战斗单位[i]={
		名称="天将"
		,模型="天将"
		,伤害=等级*7
		,气血=等级*等级*0.5+1000
		,法伤=等级*6
		,速度=等级*2
		,防御=等级*8
		,法防=等级
		,躲闪=等级*2
		,魔法=200
		,等级=等级
		,技能={}
		,主动技能=取随机法术(8)
		  }
	 end
	 return 战斗单位
end
function 怪物属性:大闹天兵(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 战斗单位[1]={
	    名称="天兵统领"
		,模型="天兵"
		,伤害=等级*10
		,变异=true
		,气血=等级*等级*0.5+5000
		,法伤=等级*9
		,速度=等级*2
		,防御=等级*8
		,法防=等级
		,躲闪=等级*2
		,魔法=200
		,等级=等级
		,技能={}
		,主动技能=取随机法术(8)
	 }
	 for i=2,8 do
		战斗单位[i]={
		名称="天兵"
		,模型="天兵"
		,伤害=等级*7
		,气血=等级*等级*0.5+1000
		,法伤=等级*6
		,速度=等级*2
		,防御=等级*8
		,法防=等级
		,躲闪=等级*2
		,魔法=200
		,等级=等级
		,技能={}
		,主动技能=取随机法术(8)
		  }
	 end
	 return 战斗单位
end
function 怪物属性:大闹盘槽力士(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级,"狮驼岭","物理")
	 战斗单位[1]={
		  名称="盘槽力士"
		  ,模型="风伯"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 15)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.5)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.5)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.5)
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="力士"
				,模型="风伯"
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 14)
				,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
				,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
				,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:大闹烧火童子(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级,"魔王寨","法系")
	 战斗单位[1]={
		  名称="烧火童子"
		  ,模型="小魔头"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="烧火童子"
				,模型="小魔头"
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 13)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.3)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.3)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.3)
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:大闹运水道人(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级,"龙宫","法系")
	 战斗单位[1]={
		  名称="运水道人"
		  ,模型="雨师"
		  ,等级=等级
		  ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="坐下童子"
				,模型="小精灵"
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:大闹造酒仙官(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级,"凌波城","物理")
	 战斗单位[1]={
		  名称="造酒仙官"
		  ,模型="护卫"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="造酒童子"
				,模型="小仙女"
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:大闹七仙女(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"大唐官府","物理")
	 战斗单位[1]={
		  名称="大仙女"
		  ,模型="芙蓉仙子"
		  ,等级=等级
		--  ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,固定伤害 = qz(等级*5)
		  ,治疗能力 = qz(等级*5)
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="二仙女"
		  ,模型="芙蓉仙子"
		  --,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,固定伤害 = qz(等级*5)
		  ,治疗能力 = qz(等级*5)
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="三仙女"
		  ,模型="芙蓉仙子"
		 -- ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,固定伤害 = qz(等级*5)
		  ,治疗能力 = qz(等级*5)
		  --,开场发言="别打我们，否则主人会很可怕！"
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="四仙女"
		  ,模型="芙蓉仙子"
		  --,变异=true
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,固定伤害 = qz(等级*5)
		  ,治疗能力 = qz(等级*5)
		  --,开场发言="别打我们，否则主人会很可怕！"
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="五仙女"
		  ,模型="芙蓉仙子"
		  ,等级=等级
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,固定伤害 = qz(等级*5)
		  ,治疗能力 = qz(等级*5)
		  --,开场发言="别打我们，否则主人会很可怕！"
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="六仙女"
		  ,模型="芙蓉仙子"
		  ,等级=等级
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,固定伤害 = qz(等级*5)
		  ,治疗能力 = qz(等级*5)
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="七仙女"
		  ,模型="芙蓉仙子"
		  ,等级=等级
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,固定伤害 = qz(等级*5)
		  ,治疗能力 = qz(等级*5)
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end
function 怪物属性:大闹抢水(任务id,玩家id,序号)
	 local 模型 ={"赌徒","强盗","山贼"}
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx
	 local 数量=取随机数(2,2)
	 for i=1,数量 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="抢水蠢贼"
				,模型="黑熊精"
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 12)
				,伤害 = qz(sx.属性.伤害 * 整体加强B * 1)
				,法伤 = qz(sx.属性.法伤 * 整体加强C * 1)
				,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1)
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:大闹除虫(任务id,玩家id,序号)
	 local 模型 ={"赌徒","强盗","山贼"}
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx
	 local 数量=取随机数(2,2)
	 for i=1,数量 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="虫蚁精怪"
				,模型="海毛虫"
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 10)
				,伤害 = qz(sx.属性.伤害 * 整体加强B * 1)
				,法伤 = qz(sx.属性.法伤 * 整体加强C * 1)
				,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1)
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:天火之殇上隋炀帝鬼魂(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级)
	 战斗单位[1]={
		  名称="隋炀帝鬼魂"
		  ,模型="鬼将"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])*2
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])*2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="铁骑队"
			,模型="炎魔神"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])*2
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])*2
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="破甲队"
			,模型="夜罗刹"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])*2
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])*2
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 for i=6,7 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="古神行者"
			,模型="护卫"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])*2
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])*2
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 for i=8,9 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="御前侍卫"
			,模型="吸血鬼"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])*2
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])*2
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 for i=10,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="祭酒者"
			,模型="雾中仙"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])*2
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])*2
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:无底洞宝箱怪(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级)
	 战斗单位[1]={
		  名称="白毛老鼠精"
		  ,模型="锦毛貂精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级,"魔王寨")
		  战斗单位[i]={
				名称="妙法妖"
				,模型="炎魔神"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
		        ,门派=sx.门派
		        ,AI战斗 = {AI=sx.智能}
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级,"狮驼岭")
		  战斗单位[i]={
				名称="利刃妖"
				,模型="夜罗刹"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
		        ,门派=sx.门派
		        ,AI战斗 = {AI=sx.智能}
		  }
	 end

	 for i=6,6 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="抵抗妖"
				,模型="吸血鬼"
				,等级=等级
				,变异=true
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=7,8 do
		  sx = self:取属性(等级,"普陀山","辅助")
		  战斗单位[i]={
			名称="疗伤妖"
		  ,模型="葫芦宝贝"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 end
	 for i=9,9 do
		  sx = self:取属性(等级,"魔王寨")
		  战斗单位[i]={
				名称="妙法妖"
				,模型="炎魔神"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
		        ,门派=sx.门派
		        ,AI战斗 = {AI=sx.智能}
		  }
	 end
	 for i=10,10 do
		  sx = self:取属性(等级,"狮驼岭")
		  战斗单位[i]={
				名称="利刃妖"
				,模型="夜罗刹"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
		        ,门派=sx.门派
		        ,AI战斗 = {AI=sx.智能}
		  }
	 end
	 return 战斗单位
end
function 怪物属性:无底洞鱼肚怪(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级)
	 战斗单位[1]={
		  名称="药叉雄帅"
		  ,模型="碧水夜叉"
		  ,变异=true
		  ,等级=等级
		  ,开场发言="#Y/给我拿命来！"
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级,"魔王寨")
		  战斗单位[i]={
				名称="妙法妖"
				,模型="炎魔神"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
		        ,门派=sx.门派
		        ,AI战斗 = {AI=sx.智能}
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级,"狮驼岭")
		  战斗单位[i]={
				名称="利刃妖"
				,模型="夜罗刹"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
		        ,门派=sx.门派
		        ,AI战斗 = {AI=sx.智能}
		  }
	 end

	 for i=6,6 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="抵抗妖"
				,模型="吸血鬼"
				,等级=等级
				,变异=true
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=7,8 do
		  sx = self:取属性(等级,"普陀山","辅助")
		  战斗单位[i]={
			名称="疗伤妖"
		  ,模型="葫芦宝贝"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 end
	 return 战斗单位
end
function 怪物属性:无底洞守门妖将(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级)
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,变异=true
		  ,等级=等级
		  ,开场发言="#Y/给我拿命来！"
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级,"魔王寨")
		  战斗单位[i]={
				名称="妙法妖"
				,模型="炎魔神"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
		        ,门派=sx.门派
		        ,AI战斗 = {AI=sx.智能}
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级,"狮驼岭")
		  战斗单位[i]={
				名称="利刃妖"
				,模型="夜罗刹"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
		        ,门派=sx.门派
		        ,AI战斗 = {AI=sx.智能}
		  }
	 end

	 for i=6,6 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="抵抗妖"
				,模型="吸血鬼"
				,等级=等级
				,变异=true
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=7,8 do
		  sx = self:取属性(等级,"普陀山","辅助")
		  战斗单位[i]={
			名称="疗伤妖"
		  ,模型="葫芦宝贝"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 end
	 return 战斗单位
end
function 怪物属性:无底洞镇守的妖精(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级)
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  --,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="纵火小妖"
				,模型="大蝙蝠"
				,变异=true
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,4 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="助火妖风"
				,模型="风伯"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end

	 for i=5,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="添火妖柴"
				,模型="树怪"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=6,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="纵火小妖"
				,模型="大蝙蝠"
				,变异=true
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:无底洞猪八戒(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"狮驼岭")
	 战斗单位[1]={
		  名称="逃跑的猪八戒"
		  ,模型="新猪八戒"
		  ,等级=等级
		  ,开场发言="倒霉有人，小的们保护我，我试下斤两"
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,门派={"狮驼岭"}
		  ,AI战斗 = {AI="物理"}
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="猪毛"
				,模型="野猪精"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				-- ,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,5 do
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[i]={
		  名称="猪虱"
		  ,模型="野猪"
		  ,等级=等级
		  ,开场发言="得令"
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		  -- ,技能={"感知"}
		  ,主动技能={"失心符"}
	 }
	 	 end
	 for i=6,6 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="猪皮"
				,模型="野猪"
				,等级=等级
				,变异=true
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				-- ,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=7,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="猪毛"
				,模型="野猪精"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				-- ,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=9,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
		        名称="猪虱"
		        ,模型="野猪"
		        ,等级=等级+15
		        ,开场发言="得令"
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				-- ,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:无底洞可疑少女(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级)
	 战斗单位[1]={
		  名称="可疑少女"
		  ,模型="千年蛇魅"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 local 萌萌={"赌徒","强盗","山贼"}
	 for i=2,2 do
		  sx = self:取属性(等级,"狮驼岭")
		  战斗单位[i]={
				名称="利刃随从"
				,模型="百足将军"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		        ,门派={"狮驼岭"}
		        ,AI战斗 = {AI="物理"}
		  }
	 end
	 for i=3,3 do
		  sx = self:取属性(等级,"魔王寨")
		  战斗单位[i]={
				名称="妙法随从"
				,模型="犀牛将军兽形"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		        ,门派={"魔王寨"}
		        ,AI战斗 = {AI="法系"}
		  }
	 end
	 for i=4,4 do
	  sx = self:取属性(等级,"狮驼岭")
		  战斗单位[i]={
				名称="利刃随从"
				,模型="百足将军"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		        ,门派={"狮驼岭"}
		        ,AI战斗 = {AI="物理"}
		  }
	 end
	 for i=5,5 do
		  sx = self:取属性(等级,"魔王寨")
		  战斗单位[i]={
				名称="妙法随从"
				,模型="犀牛将军兽形"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		        ,门派={"魔王寨"}
		        ,AI战斗 = {AI="法系"}
		  }
	 end
	 for i=6,6 do
		  sx = self:取属性(等级,nil,"封系")
		  战斗单位[i]={
				名称="抵抗妖"
				,模型="吸血鬼"
				,变异=true
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能={"含情脉脉"}
		  }
	 end
	 for i=7,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="喽罗"
				,模型="赌徒"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:无底洞强盗二头领(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级)
	 战斗单位[1]={
		  名称="山贼大头领"
		  ,模型="山贼"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 local 萌萌={"赌徒","强盗","山贼"}
	 for i=2,2 do
		  sx = self:取属性(等级,"狮驼岭")
		  战斗单位[i]={
				名称="利刃山贼"
				,模型="山贼"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		        ,门派={"狮驼岭"}
		        ,AI战斗 = {AI="物理"}
		  }
	 end
	 for i=3,3 do
		  sx = self:取属性(等级,"魔王寨")
		  战斗单位[i]={
				名称="妙法山贼"
				,模型="强盗"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		        ,门派={"魔王寨"}
		        ,AI战斗 = {AI="法系"}
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="喽啰"
				,模型="赌徒"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=6,10 do
		  sx = self:取属性(等级,nil,"封系")
		  战斗单位[i]={
				名称="抵抗妖"
				,模型="吸血鬼"
				,变异=true
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能={"含情脉脉"}
		  }
	 end
	 return 战斗单位
end
function 怪物属性:无底洞强盗大头领(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级)
	 战斗单位[1]={
		  名称="山贼大头领"
		  ,模型="强盗"
		  ,变异=true
		  ,等级=等级
		  ,开场发言="#Y/竟敢打扰我，给我拿命来！"
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 local 萌萌={"赌徒","强盗","山贼"}
	 for i=2,2 do
		  sx = self:取属性(等级,"狮驼岭")
		  战斗单位[i]={
				名称="利刃山贼"
				,模型="山贼"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		        ,门派={"狮驼岭"}
		        ,AI战斗 = {AI="物理"}
		  }
	 end
	 for i=3,3 do
		  sx = self:取属性(等级,"魔王寨")
		  战斗单位[i]={
				名称="妙法山贼"
				,模型="强盗"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		        ,门派={"魔王寨"}
		        ,AI战斗 = {AI="法系"}
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="喽啰"
				,模型="赌徒"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=6,10 do
		  sx = self:取属性(等级,nil,"封系")
		  战斗单位[i]={
				名称="抵抗妖"
				,模型="吸血鬼"
				,变异=true
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能={"含情脉脉"}
		  }
	 end
	 return 战斗单位
end
function 怪物属性:无底洞强盗喽啰(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级)
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  --,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 local 萌萌={"赌徒","强盗","山贼"}
	 for i=2,2 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="喽啰"
				,模型=萌萌[取随机数(1,#萌萌)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:齐天大圣百万天兵(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级,"狮驼岭","物理")
	 战斗单位[1]={
		  名称="巨灵神"
		  ,模型="曼珠沙华"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,2 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="斩妖"
				,模型="巡游天神"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
     for i=3,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="镇妖"
				,模型="地狱战神"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=4,4 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天灾"
				,模型="夜罗刹"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=5,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天恩"
				,模型="葫芦宝贝"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=6,6 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天罚"
				,模型="混沌兽"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=7,7 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天弄"
				,模型="阴阳伞"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=8,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天兵"
				,模型="天兵"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:齐天大圣展示实力(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[1]={
		  名称="天王"
		  ,模型="大力金刚"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,2 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="斩妖"
				,模型="巡游天神"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
     for i=3,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="镇妖"
				,模型="地狱战神"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=4,4 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天灾"
				,模型="夜罗刹"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=5,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天灾"
				,模型="噬天虎"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=6,6 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天罚"
				,模型="混沌兽"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=7,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天兵"
				,模型="天兵"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:齐天大圣镇塔之神(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级,"天宫","法系")
	 战斗单位[1]={
		  名称="塔灵"
		  ,模型="龙龟"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,2 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="斩妖"
				,模型="巡游天神"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
     for i=3,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="镇妖"
				,模型="地狱战神"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=4,4 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天灾"
				,模型="夜罗刹"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=5,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天恩"
				,模型="葫芦宝贝"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=6,6 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天罚"
				,模型="混沌兽"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=7,7 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天弄"
				,模型="阴阳伞"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=8,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="降兽"
				,模型="踏云兽"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=9,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天兵"
				,模型="天兵"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:齐天大圣巨灵神(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级,"凌波城","物理")
	 战斗单位[1]={
		  名称="巨灵神"
		  ,模型="野猪精"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,2 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="斩妖"
				,模型="巡游天神"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
     for i=3,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="镇妖"
				,模型="地狱战神"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=4,4 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天灾"
				,模型="夜罗刹"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=5,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天恩"
				,模型="葫芦宝贝"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=6,6 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天罚"
				,模型="混沌兽"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=7,7 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天弄"
				,模型="阴阳伞"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=8,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天兵"
				,模型="天兵"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:齐天大圣盗马贼(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"无底洞","固伤")
	 战斗单位[1]={
           名称=任务数据[任务id].名称
          ,模型=任务数据[任务id].模型
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="强盗"
				,模型="强盗"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:齐天大圣天王(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[1]={
		  名称="天王"
		  ,模型="大力金刚"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,2 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="斩妖"
				,模型="巡游天神"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
     for i=3,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="镇妖"
				,模型="地狱战神"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=4,4 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天灾"
				,模型="夜罗刹"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=5,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天灾"
				,模型="噬天虎"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=6,6 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天罚"
				,模型="混沌兽"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=7,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="天兵"
				,模型="天兵"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:齐天大圣阎王(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[1]={
		  名称="阎王"
		  ,模型="阎罗王"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="小鬼"
				,模型="骷髅怪"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
     for i=6,6 do
		  sx = self:取属性(等级,"大唐官府","物理")
		  战斗单位[i]={
				名称="天罚"
				,模型="混沌兽"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=7,8 do
		  sx = self:取属性(等级,"魔王寨","法系")
		  战斗单位[i]={
				名称="小鬼"
				,模型="骷髅怪"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:齐天大圣黑无常(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[1]={
		  名称="黑无常"
		  ,模型="野鬼"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级,"狮驼岭","物理")
		  战斗单位[i]={
				名称="斩妖"
				,模型="巡游天神"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
     for i=4,5 do
		  sx = self:取属性(等级,"大唐官府","物理")
		  战斗单位[i]={
				名称="灾"
				,模型="夜罗刹"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=6,6 do
		  sx = self:取属性(等级,"魔王寨","法系")
		  战斗单位[i]={
				名称="天罚"
				,模型="混沌兽"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=7,8 do
		  sx = self:取属性(等级,"神木林","法系")
		  战斗单位[i]={
				名称="鬼兵"
				,模型="吸血鬼"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:齐天大圣白无常(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[1]={
		  名称="白无常"
		  ,模型="僵尸"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级,"狮驼岭","物理")
		  战斗单位[i]={
				名称="斩妖"
				,模型="巡游天神"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
     for i=4,5 do
		  sx = self:取属性(等级,"大唐官府","物理")
		  战斗单位[i]={
				名称="灾"
				,模型="夜罗刹"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=6,6 do
		  sx = self:取属性(等级,"魔王寨","法系")
		  战斗单位[i]={
				名称="天罚"
				,模型="混沌兽"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
    for i=7,8 do
		  sx = self:取属性(等级,"神木林","法系")
		  战斗单位[i]={
				名称="鬼兵"
				,模型="吸血鬼"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:天火之殇上鬼魂护卫(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级)
	 战斗单位[1]={
		  名称="鬼魂护卫"
		  ,模型="吸血鬼"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])*2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="妖灵"
			,模型="龙龟"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 for i=4,9 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="小兵"
			,模型="机关人人形"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:天火之殇上韩擒虎鬼魂(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级)
	 战斗单位[1]={
		  名称="韩擒虎"
		  ,模型="鬼将"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,2 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="游魂"
			,模型="赌徒"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 for i=3,4 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="死士"
			,模型="山贼"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 for i=5,6 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="鬼灵"
			,模型="蛤蟆精"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 for i=7,7 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="死灵"
			,模型="巨蛙"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:天火之殇上刘武周幻影(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级)
	 战斗单位[1]={
		  名称="刘武周"
		  ,模型="巡游天神"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])*2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="妖灵"
			,模型="如意仙子"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 for i=4,6 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="鬼灵"
			,模型="芙蓉仙子"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 for i=7,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="古神行者"
			,模型="护卫"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 for i=9,9 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="鬼物"
			,模型="地狱战神"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 for i=10,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="妖物"
			,模型="黑山老妖"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:天火之殇上鬼魂头目(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级,"龙宫")
	 战斗单位[1]={
		  名称="鬼魂头目"
		  ,模型="鬼将"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])*2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知","高级反击"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,2 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="接肢妖"
			,模型="地狱战神"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 for i=3,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="蓬蓬妖"
			,模型="炎魔神"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:天火之殇上巡逻鬼(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级)
	 for i=1,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="巡逻鬼"
			,模型="虎头怪"
			,角色=true
			,锦衣={{名称="渡劫"}}
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])*2
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 for i=6,6 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="巡逻鬼"
			,模型="虎头怪"
			,角色=true
			,锦衣={{名称="明光宝甲"}}
			,开场发言="大胆，何人在此捣乱#4"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 for i=7,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="巡逻鬼"
			,模型="虎头怪"
			,角色=true
			,锦衣={{名称="渡劫"}}
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:天火之殇上鬼魂士兵(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级)
	 战斗单位[1]={
		  名称="鬼魂士兵"
		  ,模型="鬼将"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])*2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,2 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="懒皮鬼"
			,模型="野鬼"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 for i=3,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="缠身鬼"
			,模型="吸血鬼"
			,变异=true
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 for i=4,4 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称="小鬼"
			,模型="骷髅怪"
			,等级=等级
			,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
			,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
			,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
			,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:天火之殇上魑魅(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"魔王寨")
	 战斗单位[1]={
		  名称="魑魅"
		  ,模型="地狱战神"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])*2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,3 do
	 	sx = self:取属性(等级)
	 	战斗单位[i]={
		  名称="鬼兵"
		  ,模型="僵尸"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
		  ,主动技能=sx.技能组
	 }
	 end
	 for i=4,5 do
	 	sx = self:取属性(等级)
	 	战斗单位[i]={
		  名称="鬼士"
		  ,模型="野鬼"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
		  ,主动技能=sx.技能组
	 }
	 end
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="鬼灵"
		  ,模型="野猪"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"化生寺")
	 战斗单位[7]={
		  名称="鬼卫士"
		  ,模型="马面"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,主动技能=sx.技能组
	 }
	 for i=8,8 do
	 	sx = self:取属性(等级)
	 	战斗单位[i]={
		  名称="被掳走的民男"
		  ,模型="风伯"
		  ,开场发言="救命呀#52人家不小心被捉住啦..."
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
	      ,AI战斗={回合=2,指令="逃跑"}
		  ,主动技能=sx.技能组
	 }
	 end
  return 战斗单位
end
function 怪物属性:天火之殇上鬼魂(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[1]={
		  名称="阴魂首领"
		  ,模型="风伯"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])*2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"高级法术暴击"}
		  ,修炼 = {物抗=3,法抗=3,攻修=3}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","辅助")
	 战斗单位[2]={
		  名称="怨气"
		  ,模型="雷鸟人"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","辅助")
	 战斗单位[3]={
		  名称="怨念"
		  ,模型="兔子怪"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[4]={
		  名称="怨念"
		  ,模型="兔子怪"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[5]={
		  名称="怨灵"
		  ,模型="黑熊精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[6]={
		  名称="怨灵"
		  ,模型="黑熊精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[7]={
		  名称="冤魂"
		  ,模型="大海龟"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[8]={
		  名称="被掳走的姑娘"
		  ,模型="花妖"
		  ,等级=等级
		  ,变异=true
		  ,开场发言="刚刚逃走又不小心被抓住了#17大侠救命呀#52"
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,门派=sx.门派
		  ,AI战斗={回合=2,指令="逃跑"}
	 }
  return 战斗单位
end

function 怪物属性:黑风山黑熊精(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级,"大唐官府")
	 战斗单位[1]={
		  名称="熊精"
		  ,模型="黑熊"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 18)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.8)
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="熊精妖卫"
				,模型="黑熊精"
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 17)
				,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.7)
				,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.7)
				,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.7)
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:黑风山巡山精怪(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx =  self:取属性(等级,"五庄观")
	 战斗单位[1]={
		  名称="黑熊精队长"
		  ,模型="黑熊精"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 17)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.7)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.7)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.7)
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="熊精"
				,模型="黑熊"
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 16)
				,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.6)
				,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.6)
				,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.6)
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:黑风山三妖(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx
		  sx = self:取属性(等级,"阴曹地府","固伤")
		  战斗单位[1]={
				名称="黑汉"
				,模型="黑熊精"
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 16)
				,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.6)
				,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.6)
				,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.6)
				,固定伤害 = qz(等级*5)
				,治疗能力 = qz(等级*5)
		        ,门派=sx.门派
		        ,AI战斗 = {AI=sx.智能}
		  }
		  		  sx = self:取属性(等级,"神木林")
		  		  战斗单位[2]={
				名称="道人"
				,模型="雨师"
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 16)
				,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.6)
				,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.6)
				,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.6)
				,固定伤害 = qz(等级*5)
				,治疗能力 = qz(等级*5)
		        ,门派=sx.门派
		        ,AI战斗 = {AI=sx.智能}
		  }
		  		sx =self:取属性(等级,"女儿村","固伤")
		  		  战斗单位[3]={
				名称="白衣秀士"
				,模型="净瓶女娲"
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 16)
				,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.6)
				,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.6)
				,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.6)
				,固定伤害 = qz(等级*5)
				,治疗能力 = qz(等级*5)
		        ,门派=sx.门派
		        ,AI战斗 = {AI=sx.智能}
		  }
	 return 战斗单位
end
function 怪物属性:黑风山星星火光(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"化生寺","法系")
	 战斗单位[1]={
	    名称="星星火光"
		,模型="凤凰"
		,伤害=等级*10
		,变异=true
		,气血=等级*等级*0.5+5000
		,法伤=等级*10
		,速度=等级*2
		,防御=等级*8
		,法防=等级
		,躲闪=等级*2
		,魔法=200
		,等级=等级
		,技能={}
		,主动技能=取随机法术(8)
	 }
	  战斗单位[2]={
	    名称="助火凤"
		,模型="风伯"
		,伤害=等级*9
		,气血=等级*等级*0.5+2000
		,法伤=等级*8
		,速度=等级*2
		,防御=等级*8
		,法防=等级
		,躲闪=等级*2
		,魔法=200
		,等级=等级
		,技能={}
		,主动技能=取随机法术(8)
	 }
	  战斗单位[3]={
	    名称="柴火"
		,模型="树怪"
		,伤害=等级*7
		,气血=等级*等级*0.5+1000
		,法伤=等级*5
		,速度=等级*2
		,防御=等级*8
		,法防=等级
		,躲闪=等级*2
		,魔法=200
		,等级=等级
		,技能={}
		,主动技能=取随机法术(8)
	 }
	 for i=4,10 do
		战斗单位[i]={
		名称="火苗"
		,模型="凤凰"
		,伤害=等级*7
		,气血=等级*等级*0.5+1000
		,法伤=等级*6
		,速度=等级*2
		,防御=等级*8
		,法防=等级
		,躲闪=等级*2
		,魔法=200
		,等级=等级
		,技能={}
		,主动技能=取随机法术(8)
		  }
	 end
	 return 战斗单位
end
function 怪物属性:黑风山熊熊烈火(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"阴曹地府","法系")
	 战斗单位[1]={
	    名称="熊熊烈火"
		,模型="炎魔神"
		,变异=true
		,伤害=等级*10
		,气血=等级*等级*0.5+5000
		,法伤=等级*10
		,速度=等级*2
		,防御=等级*8
		,法防=等级
		,躲闪=等级*2
		,魔法=200
		,等级=等级
		,技能={}
		,主动技能=取随机法术(8)
	 }
	  战斗单位[2]={
	    名称="助火凤"
		,模型="风伯"
		,伤害=等级*9
		,气血=等级*等级*0.5+2000
		,法伤=等级*8
		,速度=等级*2
		,防御=等级*8
		,法防=等级
		,躲闪=等级*2
		,魔法=200
		,等级=等级
		,技能={}
		,主动技能=取随机法术(8)
	 }
	  战斗单位[3]={
	    名称="柴火"
		,模型="树怪"
		,伤害=等级*7
		,气血=等级*等级*0.5+1000
		,法伤=等级*5
		,速度=等级*2
		,防御=等级*8
		,法防=等级
		,躲闪=等级*2
		,魔法=200
		,等级=等级
		,技能={}
		,主动技能=取随机法术(8)
	 }
	 for i=4,10 do
		战斗单位[i]={
		名称="火苗"
		,模型="凤凰"
		,伤害=等级*7
		,气血=等级*等级*0.5+1000
		,法伤=等级*6
		,速度=等级*2
		,防御=等级*8
		,法防=等级
		,躲闪=等级*2
		,魔法=200
		,等级=等级
		,技能={}
		,主动技能=取随机法术(8)
		  }
	 end
	 return 战斗单位
end
function 怪物属性:黑风山熊精(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"凌波城","物理")
	 战斗单位[1]={
		  名称="熊精"
		  ,模型="黑熊精"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 15)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.5)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.5)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.5)
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="黑熊"
				,模型="黑熊精"
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 14)
				,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
				,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
				,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:黑风山恶虎(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[1]={
		  名称="恶虎"
		  ,模型="噬天虎"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="老虎"
				,模型="老虎"
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 13)
				,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.3)
				,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.3)
				,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.3)
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:黑风山巡逻(任务id,玩家id,序号)
	 local 模型 ={"赌徒","强盗","山贼"}
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx
	 local 数量=取随机数(2,2)
	 for i=1,数量 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="强盗"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 13)
				,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.3)
				,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.3)
				,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.3)
				,固定伤害 = qz(等级*5)
				,治疗能力 = qz(等级*5)
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:黑风山奇怪的马面(任务id,玩家id,序号)

	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 数量=取随机数(2,3)
	 for i=1,数量 do
		  战斗单位[i]={
		名称="奇怪的马面"
		,模型="马面"
		,伤害=等级*7
		,气血=等级*等级*0.5
		,法伤=等级*4
		,速度=等级*2
		,防御=等级*8
		,法防=等级
		,躲闪=等级*2
		,魔法=200
		,等级=等级
		,技能={}
		,主动技能=取随机法术(3)
		  }
	 end
	 return 战斗单位
end
function 怪物属性:黑风山吊死的鬼魂(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 数量=取随机数(2,2)
	 for i=1,数量 do
		  战斗单位[i]={
		名称="吊死的鬼魂"
		,模型="野鬼"
		,伤害=等级*7
		,气血=等级*等级*0.5
		,法伤=等级*4
		,速度=等级*2
		,防御=等级*8
		,法防=等级
		,躲闪=等级*2
		,魔法=200
		,等级=等级
		,技能={}
		,主动技能=取随机法术(3)
		  }
	 end
	 return 战斗单位
end
function 怪物属性:黑风山懵懂的僵尸(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 数量=取随机数(2,2)
	 for i=1,数量 do
		  战斗单位[i]={
		名称="懵懂的僵尸"
		,模型="僵尸"
		,伤害=等级*7
		,气血=等级*等级*0.5
		,法伤=等级*4
		,速度=等级*2
		,防御=等级*8
		,法防=等级
		,躲闪=等级*2
		,魔法=200
		,等级=等级
		,技能={}
		,主动技能=取随机法术(3)
		  }
	 end
	 return 战斗单位
end
function 怪物属性:黑风山绝望的牛头(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 数量=取随机数(2,2)
	 for i=1,数量 do
		  战斗单位[i]={
	    名称="绝望的牛头"
		,模型="牛头"
		,伤害=等级*7
		,气血=等级*等级*0.5
		,法伤=等级*4
		,速度=等级*2
		,防御=等级*8
		,法防=等级
		,躲闪=等级*2
		,魔法=200
		,等级=等级
		,技能={}
		,主动技能=取随机法术(3)
		  }
	 end
	 return 战斗单位
end
function 怪物属性:秘境降妖特殊一(任务id,玩家id,序号)
 local 模型 ={"赌徒","强盗","山贼"}
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx
	 local 数量=取随机数(5,7)
	 for i=1,数量 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="福利泡泡"
				,模型="泡泡"
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 8)
				,伤害 = qz(sx.属性.伤害 * 整体加强B * 1)
				,法伤 = qz(sx.属性.法伤 * 整体加强C * 1)
				,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1)
				,固定伤害 = qz(等级*3)
				,治疗能力 = qz(等级*3)
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:秘境降妖特殊二(任务id,玩家id,序号)
 local 模型 ={"赌徒","强盗","山贼"}
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx
	 local 数量=取随机数(7,8)
	 for i=1,数量 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="妖王分身"
				,模型="黑熊精"
				,等级=等级
				,气血 = qz(sx.属性.气血 * 整体加强A * 8)
				,伤害 = qz(sx.属性.伤害 * 整体加强B * 1)
				,法伤 = qz(sx.属性.法伤 * 整体加强C * 1)
				,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1)
				,固定伤害 = qz(等级*3)
				,治疗能力 = qz(等级*3)
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:秘境降妖十层(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[1]={
		  名称="妖王"
		  ,模型="黑熊精"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 18)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 2)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 2)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 2)
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="子将军"
		  ,模型="黑山老妖"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 16)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.8)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="丑将军"
		  ,模型="风伯"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 16)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.8)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="寅将军"
		  ,模型="护卫"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 16)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.8)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="卯将军"
		  ,模型="古代瑞兽"
		  ,等级=等级
		  ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 16)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.8)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="秘境鬼将"
		  ,模型="鬼将"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 16)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.8)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="秘境鬼将"
		  ,模型="鬼将"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 16)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.8)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="秘境鬼将"
		  ,模型="鬼将"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 16)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.8)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[9]={
		  名称="秘境鬼将"
		  ,模型="鬼将"
		  ,等级=等级
		  --,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 16)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.8)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[10]={
		  名称="秘境鬼将"
		  ,模型="鬼将"
		  ,等级=等级
		  --,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 16)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.8)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end
function 怪物属性:秘境降妖九层(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"大唐官府","物理")
	 战斗单位[1]={
		  名称="圣子"
		  ,模型="黑山老妖"
		  ,等级=等级
		  ,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 16)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.8)
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="侍女妖精"
		  ,模型="灵符女娲"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 15)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.7)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.7)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.7)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="侍女妖精"
		  ,模型="灵符女娲"
		  ,等级=等级
		  ,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 15)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.7)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.7)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.7)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="侍女妖精"
		  ,模型="灵符女娲"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 15)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.7)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.7)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.7)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="侍女妖精"
		  ,模型="灵符女娲"
		  ,等级=等级
		  ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 15)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.7)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.7)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.7)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="空虚妖灵"
		  ,模型="幽灵"
		  ,等级=等级
		  -- ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 15)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.7)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.7)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.7)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="空虚妖灵"
		  ,模型="幽灵"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 15)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.7)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.7)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.7)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="空虚妖灵"
		  ,模型="幽灵"
		  ,等级=等级
		  -- ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 15)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.7)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.7)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.7)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[9]={
		  名称="空虚妖灵"
		  ,模型="幽灵"
		  ,等级=等级
		  --,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 15)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.7)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.7)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.7)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[10]={
		  名称="空虚妖灵"
		  ,模型="幽灵"
		  ,等级=等级
		  --,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 15)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.7)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.7)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.7)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end
function 怪物属性:秘境降妖八层(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"凌波城","物理")
	 战斗单位[1]={
		  名称="秘境牛魔"
		  ,模型="牛妖"
		  ,等级=等级
		  ,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 15)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.7)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.7)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.7)
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="青牛精"
		  ,模型="牛妖"
		  ,等级=等级
		  -- ,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.6)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.6)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.6)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="黄牛精"
		  ,模型="踏云兽"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.6)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.6)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.6)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="黄牛精"
		  ,模型="踏云兽"
		  ,等级=等级
		  -- ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.6)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.6)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.6)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="青牛精"
		  ,模型="牛妖"
		  ,等级=等级
		  -- ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.6)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.6)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.6)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="百兽喽啰"
		  ,模型="蜘蛛精"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.6)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.6)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.6)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="百兽喽啰"
		  ,模型="狐狸精"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.6)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.6)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.6)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="百兽喽啰"
		  ,模型="蜘蛛精"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.6)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.6)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.6)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[9]={
		  名称="百兽喽啰"
		  ,模型="狐狸精"
		  ,等级=等级
		  --,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.6)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.6)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.6)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[10]={
		  名称="百兽喽啰"
		  ,模型="大蝙蝠"
		  ,等级=等级
		  --,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.6)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.6)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.6)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end
function 怪物属性:秘境降妖七层(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[1]={
		  名称="秘境老妖"
		  ,模型="黑山老妖"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 14)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.6)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.6)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.6)
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="千年瑞兽"
		  ,模型="古代瑞兽"
		  ,等级=等级
		  -- ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 13)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.5)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.5)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.5)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="千年龟"
		  ,模型="龙龟"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 13)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.5)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.5)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.5)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="千年鬼"
		  ,模型="鬼将"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 13)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.5)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.5)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.5)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="千年龟"
		  ,模型="龙龟"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 13)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.5)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.5)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.5)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="秘境野鬼"
		  ,模型="野鬼"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 13)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.5)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.5)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.5)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="秘境野鬼"
		  ,模型="野鬼"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 13)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.5)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.5)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.5)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="秘境野鬼"
		  ,模型="野鬼"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 13)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.5)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.5)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.5)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[9]={
		  名称="秘境野鬼"
		  ,模型="野鬼"
		  ,等级=等级
		  --,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 13)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.5)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.5)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.5)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[10]={
		  名称="秘境野鬼"
		  ,模型="野鬼"
		  ,等级=等级
		  --,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 13)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.5)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.5)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.5)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end
function 怪物属性:秘境降妖六层(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"龙宫","法系")
	 战斗单位[1]={
		  名称="熊山君"  --这里应该是盒子
		  ,模型="黑熊精"
		  ,等级=等级
		  --,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 13)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.5)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.5)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.5)
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="狂翅"
		  ,模型="雷鸟人"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 12)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="魔龙"
		  ,模型="蛟龙"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 12)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="狂翅"
		  ,模型="雷鸟人"
		  ,等级=等级
		  -- ,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 12)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="魔龙"
		  ,模型="蛟龙"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 12)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="骷髅魔兵"
		  ,模型="骷髅怪"
		  ,等级=等级
		  -- ,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 12)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="骷髅魔兵"
		  ,模型="骷髅怪"
		  ,等级=等级
		  -- ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 12)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="骷髅魔兵"
		  ,模型="骷髅怪"
		  ,等级=等级
		  -- ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 12)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[9]={
		  名称="骷髅魔兵"
		  ,模型="骷髅怪"
		  ,等级=等级
		  --,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 12)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[10]={
		  名称="骷髅魔兵"
		  ,模型="骷髅怪"
		  ,等级=等级
		  --,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 12)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end
function 怪物属性:秘境降妖五层(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"神木林","法系")
	 战斗单位[1]={
		  名称="白衣秀士"
		  ,模型="风伯"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 12)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.4)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.4)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.4)
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="喷火怪"
		  ,模型="炎魔神"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 11)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.3)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.3)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.3)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="护卫女妖"
		  ,模型="灵符女娲"
		  ,等级=等级
		  -- ,变异=true
		    ,气血 = qz(sx.属性.气血 * 整体加强A * 11)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.3)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.3)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.3)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="纵法女妖"
		  ,模型="律法女娲"
		  ,等级=等级
		  -- ,变异=true
		    ,气血 = qz(sx.属性.气血 * 整体加强A * 11)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.3)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.3)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.3)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="纵法女妖"
		  ,模型="律法女娲"
		  ,等级=等级
		  -- ,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 11)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.3)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.3)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.3)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="护卫女妖"
		  ,模型="灵符女娲"
		  ,等级=等级
		  -- ,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 11)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.3)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.3)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.3)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="行凶女妖"
		  ,模型="净瓶女娲"
		  ,等级=等级
		  -- ,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 11)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.3)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.3)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.3)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="行凶女妖"
		  ,模型="净瓶女娲"
		  ,等级=等级
		  -- ,变异=true
		    ,气血 = qz(sx.属性.气血 * 整体加强A * 11)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.3)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.3)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.3)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[9]={
		  名称="行凶女妖"
		  ,模型="净瓶女娲"
		  ,等级=等级
		  --,变异=true
		    ,气血 = qz(sx.属性.气血 * 整体加强A * 11)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.3)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.3)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.3)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[10]={
		  名称="护卫女妖"
		  ,模型="灵符女娲"
		  ,等级=等级
		  --,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 11)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.3)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.3)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.3)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end
function 怪物属性:秘境降妖四层(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"花果山","物理")
	 战斗单位[1]={
		  名称="秘境魔头"
		  ,模型="古代瑞兽"
		  ,等级=等级
		  ,变异=true
		    ,气血 = qz(sx.属性.气血 * 整体加强A * 11)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.3)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.3)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.3)
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="迷幻妖精"
		  ,模型="幽灵"
		  ,等级=等级
		  -- ,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 10)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.2)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.2)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.2)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="熊怪"
		  ,模型="白熊"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 10)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.2)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.2)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.2)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="熊怪"
		  ,模型="白熊"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 10)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.2)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.2)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.2)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="狐妖"
		  ,模型="狐狸精"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 10)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.2)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.2)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.2)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="鼠疫怪"
		  ,模型="鼠先锋"
		  ,等级=等级
		  -- ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 10)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.2)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.2)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.2)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="蜘蛛妖"
		  ,模型="蜘蛛精"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 10)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.2)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.2)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.2)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="狐妖"
		  ,模型="狐狸精"
		  ,等级=等级
		  -- ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 10)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.2)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.2)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.2)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[9]={
		  名称="蜘蛛妖"
		  ,模型="蜘蛛精"
		  ,等级=等级
		  --,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 10)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.2)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.2)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.2)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[10]={
		  名称="鼠疫怪"
		  ,模型="鼠先锋"
		  ,等级=等级
		  --,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 10)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.2)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.2)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.2)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end
function 怪物属性:秘境降妖三层(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"方寸山","物理法系")
	 战斗单位[1]={
		  名称="蟹居士"
		  ,模型="蟹将"
		  ,等级=等级
		  ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 10)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.2)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.2)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.2)
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="横行"
		  ,模型="蟹将"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 9)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.1)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="横行"
		  ,模型="蟹将"
		  ,等级=等级
		  -- ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 9)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.1)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="霸道"
		  ,模型="蟹将"
		  ,等级=等级
		  -- ,变异=true
		,气血 = qz(sx.属性.气血 * 整体加强A * 9)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.1)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="霸道"
		  ,模型="蟹将"
		  ,等级=等级
		  -- ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 9)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.1)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="寒冰怪"
		  ,模型="白熊"
		  ,等级=等级
		  -- ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 9)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.1)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="沼泽妖"
		  ,模型="巨蛙"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 9)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.1)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="嗜血妖"
		  ,模型="大蝙蝠"
		  ,等级=等级
		  -- ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 9)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.1)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[9]={
		  名称="沼泽妖"
		  ,模型="巨蛙"
		  ,等级=等级
		  --,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 9)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.1)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[10]={
		  名称="寒冰怪"
		  ,模型="白熊"
		  ,等级=等级
		  --,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 9)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.1)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end
function 怪物属性:秘境降妖二层(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"无底洞","辅助")
	 战斗单位[1]={
		  名称="偏将军"
		  ,模型="护卫"
		  ,等级=等级
		  ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 9)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1.1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1.1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1.1)
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="虎副将"
		  ,模型="噬天虎"
		  ,等级=等级
		  -- ,变异=true
		,气血 = qz(sx.属性.气血 * 整体加强A * 8)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="狼军师"
		  ,模型="狼"
		  ,等级=等级
		  -- ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 8)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="后军小妖"
		  ,模型="树怪"
		  ,等级=等级
		  -- ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 8)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="后军小妖"
		  ,模型="树怪"
		  ,等级=等级
		  -- ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 8)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="中军小妖"
		  ,模型="蛤蟆精"
		  ,等级=等级
		  -- ,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 8)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="中军小妖"
		  ,模型="蛤蟆精"
		  ,等级=等级
		  -- ,变异=true
		,气血 = qz(sx.属性.气血 * 整体加强A * 8)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="中军小妖"
		  ,模型="蛤蟆精"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 8)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[9]={
		  名称="左军小妖"
		  ,模型="雷鸟人"
		  ,等级=等级
		  --,变异=true
		 ,气血 = qz(sx.属性.气血 * 整体加强A * 8)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[10]={
		  名称="右军小妖"
		  ,模型="羊头怪"
		  ,等级=等级
		  --,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 8)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end
function 怪物属性:秘境降妖一层(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"普陀山","辅助")
	 战斗单位[1]={
		  名称="特处士兵"
		  ,模型="牛妖"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 7)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 1)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 1)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 1)
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="左角"
		  ,模型="牛妖"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 5)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 0.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 0.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 0.8)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="左角"
		  ,模型="牛妖"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 5)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 0.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 0.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 0.8)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="后勤小妖"
		  ,模型="兔子怪"
		  ,等级=等级
		  -- ,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 5)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 0.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 0.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 0.8)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="后勤小妖"
		  ,模型="兔子怪"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 5)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 0.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 0.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 0.8)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="先锋小妖"
		  ,模型="野猪"
		  ,等级=等级
		  -- ,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 5)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 0.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 0.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 0.8)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="先锋小妖"
		  ,模型="野猪"
		  ,等级=等级
		  -- ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 5)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 0.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 0.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 0.8)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="先锋小妖"
		  ,模型="野猪"
		  ,等级=等级
		  -- ,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 5)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 0.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 0.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 0.8)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[9]={
		  名称="防卫小妖"
		  ,模型="羊头怪"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * 整体加强A * 5)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 0.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 0.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 0.8)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 战斗单位[10]={
		  名称="防卫小妖"
		  ,模型="羊头怪"
		  ,等级=等级
		  ,变异=true
		   ,气血 = qz(sx.属性.气血 * 整体加强A * 5)
		  ,伤害 = qz(sx.属性.伤害 * 整体加强B * 0.8)
		  ,法伤 = qz(sx.属性.法伤 * 整体加强C * 0.8)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *整体加强D * 0.8)
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end

function 怪物属性:取低级BOSS信息(任务id,玩家id,序号)  --世界boss  远古妖魔头目
	local 战斗单位={}
		local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
		local 难度=任务数据[任务id].难度 or 0
	local xlz = qz(1+难度/10+等级/100)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"} + 6
	战斗单位[1]={
	名称="低级BOSS"
	,模型="小蚩尤"
	,附加阵法="天覆阵"
	,伤害=等级 *10 + 1200
	,气血=等级 *66 + 18000
	,法伤=800
	,速度=550
	,防御=500
	,法防=100
	,躲闪=100
	,魔法=20000
	,等级=等级
	,技能={}
	,主动技能={"龙卷雨击","二龙戏珠","龙吟","龙腾"}
	}

	战斗单位[2]={
    名称="千年老妖"
    ,模型="进阶黑山老妖"
	,伤害=等级 * 20
	,气血=等级 *66 + 13000
	,法伤=500
	,速度=600
	,防御=600
	,法防=200
	,躲闪=100
	,魔法=20000
	,等级=等级
	,技能={}
	,主动技能={"莲步轻舞","如花解语","似玉生香"}
	}

	战斗单位[3]={
    名称="千年老妖"
    ,模型="进阶黑山老妖"
	,伤害=等级 *10 + 700
	,气血=等级 *66 + 13000
	,法伤=500
	,速度=400
	,防御=600
	,法防=250
	,躲闪=100
	,魔法=20000
	,等级=等级
	,技能={"高级连击","高级必杀","嗜血追击"}
	,主动技能={"力劈华山"}
	}

	战斗单位[4]={
    名称="老妖亲卫"
    ,模型="黑山老妖"
	,伤害=等级 *10 + 700
	,气血=等级 *66 + 13000
	,法伤=500
	,速度=400
	,防御=600
	,法防=300
	,躲闪=100
	,魔法=20000
	,等级=等级
	,技能={}
	,主动技能={"壁垒击破","善恶有报","剑荡四方"}
	}

	战斗单位[5]={
    名称="老妖亲卫"
    ,模型="黑山老妖"
	,伤害=等级 *10 + 700
	,气血=等级 *66 + 13000
	,法伤=500
	,速度=400
	,防御=600
	,法防=250
	,躲闪=100
	,魔法=20000
	,等级=等级
	,技能={}
	,主动技能={"壁垒击破","善恶有报","剑荡四方"}
	}

	for n=6,10 do
	战斗单位[n]={
    名称="老妖亲兵"
    ,模型="进阶锦毛貂精"
	,伤害=等级 * 15
	,气血=等级 *66 + 13000
	,法伤=800
	,速度=300
	,防御=700
	,法防=100
	,躲闪=100
	,魔法=20000
	,等级=等级
	,技能={}
	,主动技能={"超级三昧真火","泰山压顶"}
	}
	end
	return 战斗单位
end
function 怪物属性:取中级BOSS信息(任务id,玩家id,序号)
	local 战斗单位={}
		local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
		local 难度=任务数据[任务id].难度 or 0
	local xlz = qz(1+难度/10+等级/100)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"} + 5
	战斗单位[1]={
	名称="中级BOSS"
	,模型="小蚩尤"
	,附加阵法="虎翼阵"
	,伤害=等级 *15 + 1200
	,气血=等级 *88 + 18000
	,法伤=1000
	,速度=400
	,防御=800
	,法防=500
	,躲闪=100
	,魔法=200000
	,等级=等级
	,技能={}
	,主动技能={"龙卷雨击","二龙戏珠","龙吟","龙腾"}
	}

	战斗单位[2]={
    名称="千年妖王"
    ,模型="鬼将"
	,伤害=等级 * 25
	,气血=等级 *88 + 13000
	,法伤=1000
	,速度=800
	,防御=800
	,法防=450
	,躲闪=1000
	,魔法=20000
	,等级=等级
	,技能={}
	,主动技能={"莲步轻舞","如花解语","似玉生香"}
	}

	战斗单位[3]={
    名称="千年妖王"
    ,模型="鬼将"
	,伤害=等级 *15 + 1000
    ,气血=等级 *88 + 13000
	,法伤=1000
	,速度=400
	,防御=800
	,法防=450
	,躲闪=1000
	,魔法=20000
	,等级=等级
	,技能={"高级吸血","高级必杀","高级偷袭"}
	,主动技能={"力劈华山"}
	}

	战斗单位[4]={
    名称="鬼王侍女"
    ,模型="进阶幽萤娃娃"
	,伤害=等级 *15 + 1000
    ,气血=等级 *88 + 13000
	,法伤=1000
	,速度=400
	,防御=600
	,法防=450
	,躲闪=1000
	,魔法=20000
	,等级=等级
	,技能={}
	,主动技能={"壁垒击破","善恶有报","剑荡四方"}
	}

	战斗单位[5]={
    名称="鬼王侍女"
    ,模型="进阶幽萤娃娃"
	,伤害=等级 *15 + 1000
	,气血=等级 *88 + 13000
	,法伤=1000
	,速度=400
	,防御=600
	,法防=450
	,躲闪=1000
	,魔法=20000
	,等级=等级
	,技能={}
	,主动技能={"壁垒击破","善恶有报","剑荡四方"}
	}

	for n=6,10 do
		战斗单位[n]={
    名称="鬼族先锋"
    ,模型="进阶画魂"
		,伤害=等级 * 20
		,气血=等级 *88 + 13000
		,法伤=1000
		,速度=300
		,防御=700
		,法防=400
		,躲闪=100
		,魔法=20000
		,等级=等级
		,技能={}
		,主动技能=取随机法术(3)
		}
	end
	return 战斗单位
end
function 怪物属性:取高级BOSS信息(任务id,玩家id,序号)
	local 战斗单位={}
		local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
		local 难度=任务数据[任务id].难度 or 0
	local xlz = qz(1+难度/10+等级/100)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"} + 6
	战斗单位[1]={
	名称="高级BOSS"
	,模型="小蚩尤"
	,附加阵法="虎翼阵"
	,伤害=等级 *18 + 1500
	,气血=等级 *100 + 20000
	,法伤=1500
	,速度=800
	,防御=1000
	,法防=1000
	,躲闪=100
	,魔法=20000
	,等级=等级
	,技能={}
	,主动技能={"龙卷雨击","二龙戏珠","龙腾"}
	}

	战斗单位[2]={
    名称="大力神王"
    ,模型="进阶大力金刚"
	,伤害=等级 *15 + 1200
	,气血=等级 *88 + 18000
	,法伤=1500
	,速度=800
	,防御=800
	,法防=800
	,躲闪=100
	,魔法=20000
	,等级=等级
	,技能={}
	,主动技能={"莲步轻舞","如花解语","似玉生香"}
	}

	战斗单位[3]={
    名称="大力神王"
    ,模型="进阶大力金刚"
	,伤害=等级 *15 + 1200
	,气血=等级 *88 + 18000
	,法伤=1500
	,速度=800
	,防御=800
	,法防=800
	,躲闪=100
	,魔法=20000
	,等级=等级
	,技能={"高级夜战","高级必杀","高级吸血"}
	,主动技能={"力劈华山"}
	}

	战斗单位[4]={
    名称="狂暴法神"
    ,模型="进阶炎魔神"
	,伤害=等级 *15 + 1200
	,气血=等级 *88 + 18000
	,法伤=1500
	,速度=500
	,防御=800
	,法防=800
	,躲闪=100
	,魔法=20000
	,等级=等级
    ,技能={"高级感知","高级魔之心","高级法术连击","高级法术暴击"}
    ,主动技能={"落叶萧萧","八凶法阵","上古灵符","龙卷雨击"}
	}

	战斗单位[5]={
    名称="狂暴法神"
    ,模型="进阶炎魔神"
	,伤害=等级 *15 + 1200
	,气血=等级 *88 + 18000
	,法伤=1500
	,速度=500
	,防御=800
	,法防=800
	,躲闪=100
	,魔法=20000
	,等级=等级
    ,技能={"高级感知","高级魔之心","高级法术连击","高级法术暴击"}
    ,主动技能={"落叶萧萧","八凶法阵","上古灵符","龙卷雨击","龙吟"}
	}

	for n=6,10 do
    战斗单位[n]={
    名称="力破乾坤"
    ,模型="进阶蜃气妖"
	,伤害=等级 *15 + 1200
	,气血=等级 *88 + 18000
	,法伤=1500
	,速度=500
	,防御=800
	,法防=800
	,躲闪=100
	,魔法=20000
	,等级=等级
	,技能={}
	,主动技能=取随机法术(3)
	}
end
	return 战斗单位
end

function 怪物属性:妖王之主(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+21
	 local sx =  self:取属性(等级)
	 local 小怪名称={"妖王随从"}
	 local 小怪模型={"进阶毗舍童子"}
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,附加阵法="天覆阵"
		--  ,攻击修炼=math.floor(取队伍平均等级(玩家数据[玩家id].队伍,玩家id)/7)
        --  ,防御修炼=math.floor(取队伍平均等级(玩家数据[玩家id].队伍,玩家id)/7)
         -- ,法术修炼=math.floor(取队伍平均等级(玩家数据[玩家id].队伍,玩家id)/7)
		  ,伤害=等级 * 40+500
		  ,气血=等级 * 580+100000
		  ,法伤=等级 * 30
		  ,速度=1000
		  ,防御=等级 * 10+500
		  ,法防=等级 * 5+500
		  ,躲闪=1000
		  ,魔法=20000
		  ,等级=等级
		  ,技能={"高级偷袭","高级魔之心","高级神迹"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称=小怪名称[取随机数(1,#小怪名称)]
			,模型=小怪模型[取随机数(1,#小怪模型)]
			,等级=等级
			,伤害=等级 * 40+100
			,气血=等级 * 480+50000
			,法伤=等级 * 28
		    ,速度=等级 * 6
		    ,防御=等级 * 10+500
		    ,法防=等级 * 5+500
		    ,躲闪=1000
		    ,魔法=20000
		    ,技能={"高级感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:妖王之九尾狐狸(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+21
	 local sx =  self:取属性(等级)
	 local 小怪名称={"沉默美如画"}
	 local 小怪模型={"觉醒涂山雪"}
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,附加阵法="天覆阵"
		  ,伤害=等级 * 40+300
		  ,气血=等级 * 580+80000
		  ,法伤=等级 * 28
		  ,速度=等级 * 10
		  ,防御=等级 * 10+300
		  ,法防=等级 * 5+300
		  ,治疗能力=2000
          ,愤怒=9999
		  ,躲闪=1000
		  ,魔法=20000
		  ,等级=等级
		  ,技能={"高级偷袭","高级魔之心","高级吸血","高级神迹"}
		  ,主动技能={"超级三昧真火","生命之泉","扶摇万里"}
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称=小怪名称[取随机数(1,#小怪名称)]
			,模型=小怪模型[取随机数(1,#小怪模型)]
			,等级=等级
			,伤害=等级 * 40+100
			,气血=等级 * 480+80000
			,法伤=等级 * 28
		    ,速度=等级 * 5
		    ,防御=等级 * 10+300
		    ,法防=等级 * 5+300
		    ,躲闪=1000
		    ,魔法=20000
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:妖王之黑风怪(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+21
	 local sx =  self:取属性(等级)
	 local 小怪名称={"力大无穷"}
	 local 小怪模型={"进阶黑山老妖"}
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,附加阵法="鹰啸阵"
		  ,伤害=等级 * 40+100
		  ,气血=等级 * 500+50000
		  ,法伤=等级 * 30
		  ,速度=等级 * 12
		  ,防御=等级 * 10+200
		  ,法防=等级 * 5+200
		  ,躲闪=1000
		  ,魔法=20000
		  ,等级=等级
		  ,技能={"高级偷袭","高级魔之心"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称=小怪名称[取随机数(1,#小怪名称)]
			,模型=小怪模型[取随机数(1,#小怪模型)]
			,等级=等级
			,伤害=等级 * 30+200
			,气血=等级 * 380+10000
			,法伤=等级 * 28
		    ,速度=等级 * 8
		    ,防御=等级 * 10+200
		    ,法防=等级 * 5+200
		    ,躲闪=1000
		    ,魔法=20000
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:妖王之混世魔王(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+21
	 local sx =  self:取属性(等级)
	 local 小怪名称={"飞檐走壁"}
	 local 小怪模型={"进阶炎魔神"}
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,附加阵法="云垂阵"
		  ,伤害=等级 * 37+300
		  ,气血=等级 * 450+20000
		  ,法伤=等级 * 28
		  ,速度=等级 * 10
		  ,防御=等级 * 12
		  ,法防=等级 * 5
		  ,躲闪=1000
		  ,魔法=20000
		  ,等级=等级
		  ,技能={"高级偷袭","高级魔之心"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称=小怪名称[取随机数(1,#小怪名称)]
			,模型=小怪模型[取随机数(1,#小怪模型)]
			,等级=等级
			,伤害=等级 * 30+200
			,气血=等级 * 350+20000
			,法伤=等级 * 26
		    ,速度=等级 * 8
		    ,防御=等级 * 10
		    ,法防=等级 * 5+200
		    ,躲闪=1000
		    ,魔法=20000
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:妖王之独角兕大王(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+21
	 local sx =  self:取属性(等级)
	 local 小怪名称={"铜墙铁壁"}
	 local 小怪模型={"进阶巡游天神"}
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,附加阵法="虎翼阵"
		  ,伤害=等级 * 38+290
		  ,气血=等级 * 460+20000
		  ,法伤=等级 * 28
		  ,速度=等级 * 11
		  ,防御=等级 * 12
		  ,法防=等级 * 5+200
		  ,躲闪=1000
		  ,魔法=20000
		  ,等级=等级
		  ,技能={"高级偷袭","高级魔之心"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称=小怪名称[取随机数(1,#小怪名称)]
			,模型=小怪模型[取随机数(1,#小怪模型)]
			,等级=等级
			,伤害=等级 * 30+190
			,气血=等级 * 360+10000
			,法伤=等级 * 26
		    ,速度=等级 * 8
		    ,防御=等级 * 10
		    ,法防=等级 * 5+200
		    ,躲闪=1000
		    ,魔法=20000
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:妖王之玉兔精(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+21
	 local sx =  self:取属性(等级)
	 local 小怪名称={"生龙活虎"}
	 local 小怪模型={"进阶风伯"}
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,附加阵法="云垂阵"
		  ,伤害=等级 * 35+280
		  ,气血=等级 * 420+20000
		  ,法伤=等级 * 27
		  ,速度=等级 * 10
		  ,防御=等级 * 12
		  ,法防=等级 * 5+200
		  ,躲闪=1000
		  ,魔法=20000
		  ,等级=等级
		  ,技能={"高级偷袭","高级魔之心"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称=小怪名称[取随机数(1,#小怪名称)]
			,模型=小怪模型[取随机数(1,#小怪模型)]
			,等级=等级
			,伤害=等级 * 29+180
			,气血=等级 * 320+10000
			,法伤=等级 * 26
		    ,速度=等级 * 8
		    ,防御=等级 * 10
		    ,法防=等级 * 5+200
		    ,躲闪=1000
		    ,魔法=20000
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:妖王之六耳猕猴(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+21
	 local sx =  self:取属性(等级)
	 local 小怪名称={"术精岐黄"}
	 local 小怪模型={"进阶蝴蝶仙子"}
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,附加阵法="龙飞阵"
		  ,伤害=等级 * 36+270
		  ,气血=等级 * 440+20000
		  ,法伤=等级 * 28
		  ,速度=等级 * 10
		  ,防御=等级 * 12
		  ,法防=等级 * 5+200
		  ,躲闪=1000
		  ,魔法=20000
		  ,等级=等级
		  ,技能={"高级偷袭","高级魔之心","高级神迹"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称=小怪名称[取随机数(1,#小怪名称)]
			,模型=小怪模型[取随机数(1,#小怪模型)]
			,等级=等级
			,伤害=等级 * 30+170
			,气血=等级 * 340+10000
			,法伤=等级 * 26
		    ,速度=等级 * 8
		    ,防御=等级 * 10
		    ,法防=等级 * 5
		    ,躲闪=1000
		    ,魔法=20000
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:妖王之红孩儿(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+21
	 local sx =  self:取属性(等级)
	 local 小怪名称={"杏林高手"}
	 local 小怪模型={"超级红孩儿"}
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,附加阵法="云垂阵"
		  ,伤害=等级 * 33+260
		  ,气血=等级 * 380+20000
		  ,法伤=等级 * 25
		  ,速度=等级 * 8
		  ,防御=等级 * 11
		  ,法防=等级 * 5+200
		  ,躲闪=1000
		  ,魔法=20000
		  ,等级=等级
		  ,技能={"高级偷袭","高级魔之心","高级神迹"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称=小怪名称[取随机数(1,#小怪名称)]
			,模型=小怪模型[取随机数(1,#小怪模型)]
			,等级=等级
			,伤害=等级 * 28+160
			,气血=等级 * 280+10000
			,法伤=等级 * 10 + 800
		    ,速度=等级 * 7
		    ,防御=等级 * 10
		    ,法防=等级 * 6+200
		    ,躲闪=1000
		    ,魔法=20000
		    ,技能={"高级感知","高级魔之心"}
		    ,主动技能={"超级三昧真火"}
		  }
	 end
	 return 战斗单位
end
function 怪物属性:妖王之蝎子精(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+21
	 local sx =  self:取属性(等级)
	 local 小怪名称={"孔雀开屏"}
	 local 小怪模型={"进阶蝎子精"}
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,附加阵法="天阵"
		  ,伤害=等级 * 34+250
		  ,气血=等级 * 400+20000
		  ,法伤=等级 * 26
		  ,速度=等级 * 9
		  ,防御=等级 * 12
		  ,法防=等级 * 5
		  ,躲闪=1000
		  ,魔法=20000
		  ,等级=等级
		  ,技能={"高级偷袭","高级魔之心","高级神迹"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称=小怪名称[取随机数(1,#小怪名称)]
			,模型=小怪模型[取随机数(1,#小怪模型)]
			,等级=等级
			,伤害=等级 * 29+150
			,气血=等级 * 300+10000
			,法伤=等级 * 26
		    ,速度=等级 * 8
		    ,防御=等级 * 10
		    ,法防=等级 * 5
		    ,躲闪=1000
		    ,魔法=20000
		    ,技能={"感知"}
		    ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:妖王之眼魔君(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+21
	 local sx =  self:取属性(等级)
	 local 小怪名称={"术精岐黄","铜墙铁壁","力大无穷","飞檐走壁","外强中干","救死扶伤","固若金汤","身强体壮","铜墙铁壁","杏林高手","生龙活虎","拔山扛鼎","金石为开","劳释虚象","人心莫测","天网恢恢","炎炎浊气","死气沉沉"}
	 local 小怪模型={"进阶夜罗刹"}
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,饰品=true
		  ,附加阵法="云垂阵"
		  ,伤害=等级 * 32+230
		  ,气血=等级 * 360+20000
		  ,法伤=等级 * 22
		  ,速度=等级 * 7
		  ,防御=等级 * 11
		  ,法防=等级 * 5
		  ,躲闪=1000
		  ,魔法=20000
		  ,等级=等级
		  ,技能={"高级偷袭","高级魔之心","高级神迹"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称=小怪名称[取随机数(1,#小怪名称)]
			,模型=小怪模型[取随机数(1,#小怪模型)]
			,等级=等级
			,伤害=等级 * 27+130
		    ,气血=等级 * 260+10000
		    ,法伤=等级 * 20
		    ,速度=等级 * 6
		    ,防御=等级 * 10
		    ,法防=等级 * 5
			,躲闪=500
			,魔法=20000
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:妖王之狮猁怪(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+21
	 local sx =  self:取属性(等级)
	 local 小怪名称={"术精岐黄","铜墙铁壁","力大无穷","飞檐走壁","外强中干","救死扶伤","固若金汤","身强体壮","铜墙铁壁","杏林高手","生龙活虎","拔山扛鼎","金石为开","劳释虚象","人心莫测","天网恢恢","炎炎浊气","死气沉沉"}
	 local 小怪模型={"进阶古代瑞兽"}
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,附加阵法="云垂阵"
		  ,伤害=等级 * 31+220
		  ,气血=等级 * 340+20000
		  ,法伤=等级 * 21
		  ,速度=等级 * 6
		  ,防御=等级 * 11
		  ,法防=等级 * 5
		  ,躲闪=1000
		  ,魔法=20000
		  ,等级=等级
		  ,技能={"高级偷袭","高级魔之心","高级神迹"}
		  ,主动技能=sx.技能组
	 }
	    for i=2,10 do
		    sx = self:取属性(等级)
		    战斗单位[i]={
			名称=小怪名称[取随机数(1,#小怪名称)]
			,模型=小怪模型[取随机数(1,#小怪模型)]
			,等级=等级
			,伤害=等级 * 27+120
		    ,气血=等级 * 240+10000
		    ,法伤=等级 * 20
		    ,速度=等级 * 6
		    ,防御=等级 * 10
		    ,法防=等级 * 5
			,躲闪=100
			,魔法=20000
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:妖王之白骨精(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+21
	 local sx =  self:取属性(等级)
	 local 小怪名称={"术精岐黄","铜墙铁壁","力大无穷","飞檐走壁","外强中干","救死扶伤","固若金汤","身强体壮","铜墙铁壁","杏林高手","生龙活虎","拔山扛鼎","金石为开","劳释虚象","人心莫测","天网恢恢","炎炎浊气","死气沉沉"}
	 local 小怪模型={"进阶猫灵人形"}
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,附加阵法="云垂阵"
		  ,伤害=等级 * 31+210
		  ,气血=等级 * 320+25000
		  ,法伤=等级 * 21
		  ,速度=等级 * 6
		  ,防御=等级 * 11
		  ,法防=等级 * 5
		  ,躲闪=1000
		  ,魔法=20000
		  ,等级=等级
		  ,技能={"高级偷袭","高级魔之心","高级神迹"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
		  名称=小怪名称[取随机数(1,#小怪名称)]
		  ,模型=小怪模型[取随机数(1,#小怪模型)]
		  ,等级=等级
		  ,伤害=等级 * 26+100
		  ,气血=等级 * 220+15000
		  ,法伤=等级 * 19
		  ,速度=等级 * 5
		  ,防御=等级 * 10
		  ,法防=等级 * 5
		  ,躲闪=1000
		  ,魔法=20000
		  ,等级=等级
		  ,技能={"高级感知"}
		  ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:妖王之黄风怪(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+21
	 local sx =  self:取属性(等级)
	 local 小怪名称={"术精岐黄","铜墙铁壁","力大无穷","飞檐走壁","外强中干","救死扶伤","固若金汤","身强体壮","铜墙铁壁","杏林高手","生龙活虎","拔山扛鼎","金石为开","劳释虚象","人心莫测","天网恢恢","炎炎浊气","死气沉沉"}
	 local 小怪模型={"进阶月魅"}
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,饰品=true
		  ,附加阵法="云垂阵"
		  ,伤害=等级 * 30+200
		  ,气血=等级 * 300+20000
		  ,法伤=等级 * 20
		  ,速度=等级 * 5
		  ,防御=等级 * 10
		  ,法防=等级 * 5
		  ,躲闪=1000
		  ,魔法=20000
		  ,等级=等级
		  ,技能={"高级偷袭","高级魔之心","高级神迹"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
			名称=小怪名称[取随机数(1,#小怪名称)]
			,模型=小怪模型[取随机数(1,#小怪模型)]
			,等级=等级
			,伤害=等级 * 25+100
			,气血=等级 * 200+10000
			,法伤=等级 * 18
		    ,速度=等级 * 4
		    ,防御=等级 * 10
		    ,法防=等级 * 2
			,躲闪=500
			,魔法=20000
		  ,技能={"高级感知"}
		  ,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:知了先锋(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 门派 = "狮驼岭"
	 local sx = self:取属性(等级,"狮驼岭","天宫","法系")
	 战斗单位[1]={
		  名称="知了先锋"
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,防御 = qz(等级*10)+200
		  ,法防 = qz(等级*7)
		  ,气血 = qz(sx.属性.气血 * 11)
		  ,伤害 = qz(sx.属性.伤害 *1.4)
		  ,法伤 = qz(sx.属性.法伤 * 1.2)
		  ,速度 = qz(sx.属性.速度 *3 * 速度削弱)
		  ,固定伤害 = qz(等级*7)
		  ,治疗能力 = qz(等级)
		  ,技能={"高级吸血","高级法术连击"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,9 do
	 	  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="甜蜜姑娘"
				,模型="芙蓉仙子"
				,等级=等级
				,防御 = qz(等级*8)+200
				,法防 = qz(等级*6)
				,气血 = qz(sx.属性.气血 *10)
				,伤害 = qz(sx.属性.伤害 *1.3)
				,法伤 = qz(sx.属性.法伤 *1)
				,速度 = qz(sx.属性.速度 *2)
				,固定伤害 = qz(等级*5)
				,治疗能力 = qz(等级)
				,技能={"高级感知"}
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[10]={
		  名称="狸"
		  ,模型="狸"
		  ,等级=等级
		  ,变异=true
		  ,防御 = qz(等级*12)
		  ,法防 = qz(等级*5)
		  ,气血 = qz(sx.属性.气血 *10)
		  ,伤害 = qz(sx.属性.伤害 )
		  ,法伤 = qz(sx.属性.法伤 )
		  ,速度 = qz(sx.属性.速度 *8)
		  ,固定伤害 = qz(等级)
		  ,治疗能力 = qz(等级)
		  ,技能={}
		  ,门派="方寸山"
		  ,AI战斗 = {AI="封系"}
	 }
	 return 战斗单位
end
function 怪物属性:取知了统领信息(任务id,玩家id,序号)
	local 战斗单位={}
		local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
		local 难度=任务数据[任务id].难度 or 0
	local xlz = qz(1+难度/10+等级/100)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"}
	local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="知了统领"
		  ,模型="知了王"
		  ,等级=等级
		  ,气血 = qz(等级*50)+10000
		  ,伤害 = qz(等级*14)+500
		  ,法伤 = qz(等级*12)+200
		  ,速度 = qz(等级*5)
		  ,固定伤害 = qz(等级*10)
		  ,治疗能力 = qz(等级*10)
		  ,主动技能=sx.技能组
	 }
	 for i=2,9 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="神韵"
				,模型="雪月蛙"
				,等级=等级
				,气血 = qz(等级*55)+8000
		        ,伤害 = qz(等级*10)+400
		        ,法伤 = qz(等级*10)+200
		        ,速度 = qz(等级*4)
		        ,固定伤害 = qz(等级*10)
		        ,治疗能力 = qz(等级*10)
				,主动技能=sx.技能组
		  }
		  end
	 sx = self:取属性(等级,nil,"封系")
	     战斗单位[10]={
		  名称="狐狸精"
		  ,模型="狐狸精"
		  ,等级=等级
		  ,变异=true
		  ,防御 = qz(等级*12)
		  ,法防 = qz(等级*5)
		  ,气血 = qz(等级*50)+8000
		  ,伤害 = qz(等级*10)+400
		  ,法伤 = qz(等级*10)+200
		  ,速度 = qz(等级*4)
		  ,固定伤害 = qz(等级*10)
		  ,治疗能力 = qz(等级*10)
		  ,技能={}
		  ,门派="方寸山"
		  ,AI战斗 = {AI="封系"}
	 }
	 return 战斗单位
end
function 怪物属性:取知了小王信息(任务id,玩家id,序号)
	local 战斗单位={}
		local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
		local 难度=任务数据[任务id].难度 or 0
	local xlz = qz(1+难度/10+等级/100)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"}
	local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="知了小王"
		  ,模型="知了王"
		  ,等级=等级
		  ,气血 = qz(等级*55)+11000
		  ,伤害 = qz(等级*15)+500
		  ,法伤 = qz(等级*12)+200
		  ,速度 = qz(等级*6)
		  ,固定伤害 = qz(等级*10)
		  ,治疗能力 = qz(等级*10)
		  ,主动技能=sx.技能组
	 }
	 for i=2,9 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="神气"
				,模型="火月蛙"
				,等级=等级
				,气血 = qz(等级*55)+9000
		        ,伤害 = qz(等级*12)+400
		        ,法伤 = qz(等级*10)+200
		        ,速度 = qz(等级*5)
		        ,固定伤害 = qz(等级*10)
		        ,治疗能力 = qz(等级*10)
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"封系")
	     战斗单位[10]={
		  名称="花妖"
		  ,模型="花妖"
		  ,等级=等级
		  ,变异=true
		  ,防御 = qz(等级*12)
		  ,法防 = qz(等级*5)
		  ,气血 = qz(等级*55)+8000
		  ,伤害 = qz(等级*10)+400
		  ,法伤 = qz(等级*10)+200
		  ,速度 = qz(等级*4)
		  ,固定伤害 = qz(等级*10)
		  ,治疗能力 = qz(等级*10)
		  ,技能={}
		  ,门派="方寸山"
		  ,AI战斗 = {AI="封系"}
	 }
	 return 战斗单位
end
function 怪物属性:取知了大王信息(任务id,玩家id,序号)
	local 战斗单位={}
		local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
		local 难度=任务数据[任务id].难度 or 0
	local xlz = qz(1+难度/10+等级/100)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"}
	local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="知了大王"
		  ,模型="知了王"
		  ,等级=等级
		  ,气血 = qz(等级*60)+13000
		  ,伤害 = qz(等级*16)+500
		  ,法伤 = qz(等级*12)+200
		  ,速度 = qz(等级*7) * 速度削弱
		  ,固定伤害 = qz(等级*10)
		  ,治疗能力 = qz(等级*10)
		  ,主动技能=sx.技能组
	 }
	 for i=2,9 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="机智"
				,模型="花妖"
				,等级=等级
				,气血 = qz(等级*50)+10000
		        ,伤害 = qz(等级*10)+400
		        ,法伤 = qz(等级*10)+200
		        ,速度 = qz(等级*6) * 速度削弱
		        ,固定伤害 = qz(等级*10)
		        ,治疗能力 = qz(等级*10)
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"封系")
	     战斗单位[10]={
		  名称="狸"
		  ,模型="狸"
		  ,等级=等级
		  ,变异=true
		  ,防御 = qz(等级*12)
		  ,法防 = qz(等级*5)
		  ,气血 = qz(等级*50)+8000
		  ,伤害 = qz(等级*10)+400
		  ,法伤 = qz(等级*10)+200
		  ,速度 = qz(等级*4) * 速度削弱
		  ,固定伤害 = qz(等级*10)
		  ,治疗能力 = qz(等级*10)
		  ,技能={}
		  ,门派="方寸山"
		  ,AI战斗 = {AI="封系"}
	 }
	 return 战斗单位
end

function 怪物属性:取千年知了王信息(任务id,玩家id,序号)
	local 战斗单位={}
		local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
		local 难度=任务数据[任务id].难度 or 0
	local xlz = qz(1+难度/10+等级/100)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"}
	local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="千年知了王"
		  ,模型="知了王"
		  ,等级=等级
		  ,气血 = qz(等级*60)+15000
		  ,伤害 = qz(等级*16)+600
		  ,法伤 = qz(等级*12)+200
		  ,速度 = qz(等级*8) * 速度削弱
		  ,固定伤害 = qz(等级*10)
		  ,治疗能力 = qz(等级*10)
		  ,主动技能=sx.技能组
	 }
	 for i=2,9 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="千年野猪精"
				,模型="野猪精"
				,等级=等级
				,气血 = qz(等级*50)+11000
		        ,伤害 = qz(等级*10)+400
		        ,法伤 = qz(等级*10)+200
		        ,速度 = qz(等级*7) * 速度削弱
		        ,固定伤害 = qz(等级*10)
		        ,治疗能力 = qz(等级*10)
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"封系")
	     战斗单位[10]={
		  名称="花妖"
		  ,模型="花妖"
		  ,等级=等级
		  ,变异=true
		  ,防御 = qz(等级*12)
		  ,法防 = qz(等级*5)
		  ,气血 = qz(等级*60)+8000
		  ,伤害 = qz(等级*10)+400
		  ,法伤 = qz(等级*10)+200
		  ,速度 = qz(等级*4) * 速度削弱
		  ,固定伤害 = qz(等级*10)
		  ,治疗能力 = qz(等级*10)
		  ,技能={}
		  ,门派="方寸山"
		  ,AI战斗 = {AI="封系"}
	 }
	 return 战斗单位
end

function 怪物属性:龙族(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 门派 = "龙宫"
	 local sx = self:取属性(等级,"龙宫","魔王","狮驼岭")
	 战斗单位[1]={
		  名称="龙族"
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		--  ,饰品=true
		  ,防御 = qz(等级*10)+300
		  ,法防 = qz(等级*7)
		  ,气血 = qz(sx.属性.气血 * 25)
		  ,伤害 = qz(sx.属性.伤害 *2)
		  ,法伤 = qz(sx.属性.法伤 * 1.8)
		  ,速度 = qz(sx.属性.速度 *6)
		  ,固定伤害 = qz(等级*10)
		  ,治疗能力 = qz(等级)
		  ,技能={"高级吸血","高级法术连击"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,9 do
	 	  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="龙卫"
				,模型="进阶执音"
				,等级=等级
				,防御 = qz(等级*8)+200
				,法防 = qz(等级*6)
				,气血 = qz(sx.属性.气血 *20)
				,伤害 = qz(sx.属性.伤害 *1.6)
				,法伤 = qz(sx.属性.法伤 *1.5)
				,速度 = qz(sx.属性.速度 *5)
				,固定伤害 = qz(等级*8)
				,治疗能力 = qz(等级)
				,技能={"高级感知"}
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[10]={
		  名称="斥候"
		  ,模型="进阶雾中仙"
		  ,等级=等级
		  ,防御 = qz(等级*20)
		  ,法防 = qz(等级*8)
		  ,气血 = qz(sx.属性.气血 *20)
		  ,伤害 = qz(sx.属性.伤害 *2)
		  ,法伤 = qz(sx.属性.法伤 )
		  ,速度 = qz(sx.属性.速度 *10)
		  ,固定伤害 = qz(等级)
		  ,治疗能力 = qz(等级*20)
		  ,技能={}
		  ,门派="五庄观"
		  ,AI战斗 = {AI="封系"}
	 }
	 return 战斗单位
end
function 怪物属性:取裂风兽信息(任务id,玩家id,序号)
local 战斗单位={}
  local 等级=玩家数据[玩家id].角色.等级+16
  	 local 沉默物理 = {"大唐官府","狮驼岭","凌波城"}
	 local 沉默法系 = {"神木林","魔王寨","龙宫"}
	 local 沉默封系 = {"女儿村","五庄观"}
	 local 沉默辅助 = {"化生寺","普陀山"}
	 local sx = self:取属性(等级,门派)
	 local 主怪是否为输出 = false
	 if sx.智能=="物理" or sx.智能=="法系" or sx.智能=="固伤" or sx.智能=="辅助" then
	 end
				 门派 = 沉默物理[sj(1,#沉默物理)]
				 sx = self:取属性(等级,门派,"物理")
			战斗单位[1]={
				 名称="风希"
				,模型="进阶执音"
				,角色=true
				,伤害=等级*20+4200
				,气血=等级*600+350000
				,法伤=3000
				,速度=等级*8+600
				,防御=等级*12+1500
				,法防=等级*8+800
				,躲闪=等级*25
		        ,抵抗封印等级=10000
				,魔法=50000
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

				门派 = 沉默物理[sj(1,#沉默物理)]
				sx = self:取属性(等级,门派,"物理")
			战斗单位[2]={
				 名称="风兽物理"
				,模型="泡泡灵仙·羽灵神"
				,角色=true
				,伤害=等级*20+3800
				,气血=等级*500+180000
				,法伤=2500
				,速度=等级*5+300
				,防御=等级*12+1000
				,法防=等级*6+800
				,抵抗封印等级=200
				,躲闪=等级*20
				,魔法=50000
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

				门派 =沉默物理[sj(1,#沉默物理)]
				sx = self:取属性(等级,门派,"物理")
		    战斗单位[3]={
				 名称="风兽物理"
				,模型="泡泡灵仙·羽灵神"
				,角色=true
				,伤害=等级*20+3800
				,气血=等级*500+180000
				,法伤=等级*10
				,速度=等级*5+300
				,防御=等级*12+1000
				,法防=等级*5+800
				,抵抗封印等级=200
				,躲闪=等级*20
				,魔法=50000
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

				门派 = 沉默物理[sj(1,#沉默物理)]
				sx = self:取属性(等级,门派,"物理")
			战斗单位[4]={
				 名称="风兽物理"
				,模型="泡泡灵仙·羽灵神"
				,角色=true
				,伤害=等级*20+3800
				,气血=等级*500+180000
				,法伤=等级*20
				,速度=等级*5+300
				,防御=等级*12+1000
				,法防=等级*6+800
				,抵抗封印等级=200
				,躲闪=等级*20
				,魔法=50000
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

				门派 = 沉默法系[sj(1,#沉默法系)]
				sx = self:取属性(等级,门派,"法系")
			战斗单位[5]={
				名称="风兽法系"
				,模型="泡泡灵仙·飞燕女"
				,角色=true
				,伤害=2000
				,气血=等级*500+180000
				,法伤=等级*20+2600
				,速度=等级*5+300
				,防御=等级*12+1000
				,法防=等级*8+800
				,抵抗封印等级=200
				,躲闪=等级*20
				,魔法=50000
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

				门派 = 沉默法系[sj(1,#沉默法系)]
				sx = self:取属性(等级,门派,"法系")
			战斗单位[6]={
				 名称="风兽法系"
				,模型="泡泡灵仙·飞燕女"
				,角色=true
				,伤害=2000
				,气血=等级*500+180000
				,法伤=等级*20+2600
				,速度=等级*5+300
				,防御=等级*12+1000
				,法防=等级*8+800
				,抵抗封印等级=200
			--	,饰品=true
				,躲闪=等级*20
				,魔法=50000
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

				门派 = 沉默法系[sj(1,#沉默法系)]
				sx = self:取属性(等级,门派,"法系")
			战斗单位[7]={
				 名称="风兽法系"
				,模型="泡泡灵仙·飞燕女"
				,角色=true
				,伤害=2000
				,气血=等级*500+180000
				,法伤=等级*20+2600
				,速度=等级*5+500
				,防御=等级*12+1000
				,法防=等级*6+800
				,抵抗封印等级=500
				,躲闪=等级*20
				,魔法=50000
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

				门派 = 沉默封系[sj(1,#沉默封系)]
				sx = self:取属性(等级,门派,"封系")
			战斗单位[8]={
				 名称="风兽封系"
				,模型="泡泡灵仙·巫蛮儿"
				,角色=true
				,伤害=5000
				,气血=等级*800+250000
				,法伤=2000
				,速度=等级*6+800
				,防御=等级*12+1500
				,法防=等级*8+1000
				,抵抗封印等级=300
				,封印命中等级=300
				,躲闪=等级*20
				,魔法=50000
				,愤怒=9999
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

				门派 = 沉默物理[sj(1,#沉默物理)]
				sx = self:取属性(等级,门派,"物理")
			战斗单位[9]={
				名称="风兽物理"
				,模型="泡泡灵仙·羽灵神"
				,角色=true
				,伤害=等级*20+3800
				,气血=等级*500+200000
				,法伤=等级*15
				,速度=等级*5+300
				,防御=等级*12+1000
				,法防=等级*6+800
				,抵抗封印等级=200
				,躲闪=等级*20
				,魔法=50000
				,愤怒=9999
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

				门派 = 沉默辅助[sj(1,#沉默辅助)]
				sx = self:取属性(等级,门派,"辅助")
			战斗单位[10]={
				名称="风兽辅助"
				,模型="泡泡灵仙·杀破狼"
				,角色=true
				,伤害=2000
				,气血=等级*800+250000
				,法伤=2000
				,速度=等级*6+600
				,防御=等级*12+1500
				,法防=等级*8+1000
				,治疗能力=等级*15+3000
				,抵抗封印等级=500
				,愤怒=9999
				,躲闪=等级*20
				,魔法=80000
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}
  return 战斗单位
end
function 怪物属性:取副本相柳信息(任务id,玩家id,序号)
  local 战斗单位={}
  	local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
  	local 难度=任务数据[任务id].难度 or 0
	local xlz = qz(1+难度/10+等级/100)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"}
  战斗单位[1]={
  名称="相柳"
  ,模型="进阶鬼将"
  ,伤害=等级*20
  ,气血=等级*400
  ,灵力=等级*20
  ,速度=等级*5
  ,防御=等级*4
  ,法防=等级*5
  ,躲闪=500
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["龙宫"] }

  等级=等级
  战斗单位[2]={
  名称="不死妖凰"
  ,模型="凤凰"
  ,变异=true
  ,伤害=等级*18
  ,气血=等级*200
  ,灵力=等级*18
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["魔王寨"] }

  战斗单位[3]={
  名称="万圣公主"
  ,模型="进阶如意仙子"
  ,变异=true
  ,伤害=等级*18
  ,气血=等级*200
  ,灵力=等级*18
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["普陀山"] }

  战斗单位[4]={
  名称="无面"
  ,模型="进阶大力金刚"
  ,变异=true
  ,伤害=等级*18
  ,气血=等级*200
  ,灵力=等级*18
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=取随机法术(4) }

  战斗单位[5]={
  名称="无情"
  ,模型="炎魔神"
  ,伤害=等级*18
  ,气血=等级*200
  ,灵力=等级*18
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["大唐官府"] }

  战斗单位[6]={
  名称="魅"
  ,模型="进阶月影仙"
  ,伤害=等级*18
  ,气血=等级*200
  ,灵力=等级*18
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["盘丝洞"] }

  战斗单位[7]={
  名称="女妖"
  ,模型="幻姬"
  ,伤害=等级*18
  ,气血=等级*200
  ,灵力=等级*18
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=取随机法术(4) }

  战斗单位[8]={
  名称="火焰"
  ,模型="超级红孩儿"
  ,伤害=等级*18
  ,气血=等级*200
  ,灵力=等级*18
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=取随机法术(4) }

  战斗单位[9]={
  名称="火神"
  ,模型="超级红孩儿"
  ,伤害=等级*18
  ,气血=等级*200
  ,灵力=等级*18
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=取随机法术(4) }

  战斗单位[10]={
  名称="火妖"
  ,模型="超级红孩儿"
  ,伤害=等级*18
  ,气血=等级*200
  ,灵力=等级*18
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=取随机法术(4) }
  return 战斗单位
end

function 怪物属性:取副本天将信息(任务id,玩家id,序号)
  local 战斗单位={}
  	local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
  	local 难度=任务数据[任务id].难度 or 0
	local xlz = qz(1+难度/10+等级/100)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"}
  战斗单位[1]={
  名称="天将"
  ,模型="进阶天将"
  ,伤害=等级*18
  ,气血=等级*300
  ,灵力=等级*18
  ,速度=等级*4
  ,防御=等级*4
  ,法防=等级*5
  ,躲闪=100
  ,魔法=2000
  ,等级=等级
  ,技能={"高级必杀","高级连击","高级吸血"}
  ,主动技能=Q_门派法术["天宫"] }

  等级=等级
  战斗单位[2]={
  名称="镇狱天兵"
  ,模型="天兵"
  ,变异=true
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["天宫"] }

  战斗单位[3]={
  名称="镇狱天兵"
  ,模型="天兵"
  ,变异=true
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["天宫"] }

  战斗单位[4]={
  名称="虚空骑士"
  ,模型="进阶修罗傀儡鬼"
  ,变异=true
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["大唐官府"] }

  战斗单位[5]={
  名称="铁面无常"
  ,模型="进阶黑山老妖"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["化生寺"] }

  战斗单位[6]={
  名称="刑海"
  ,模型="进阶天兵"
  ,变异=true
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["天宫"] }

  战斗单位[7]={
  名称="火魅"
  ,模型="超级红孩儿"
 ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["盘丝洞"] }

  战斗单位[8]={
  名称="火焰"
  ,模型="超级红孩儿"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=取随机法术(4) }

  战斗单位[9]={
  名称="火神"
  ,模型="超级红孩儿"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=取随机法术(4) }

  战斗单位[10]={
  名称="火妖"
  ,模型="超级红孩儿"
 ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=取随机法术(4) }
  return 战斗单位
end

function 怪物属性:取副本幽颜信息(任务id,玩家id,序号)
  local 战斗单位={}
  	local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
  	local 难度=任务数据[任务id].难度 or 0
	local xlz = qz(1+难度/10+等级/100)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"}
  战斗单位[1]={
  名称="幽颜"
  ,模型="进阶蛟龙"
  ,伤害=等级*20
  ,气血=等级*300
  ,灵力=等级*18
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=500
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["魔王寨"] }

  等级=等级
  战斗单位[2]={
  名称="幻影龙军"
  ,模型="进阶龙龟"
  ,变异=true
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={"高级必杀","高级连击","高级吸血"}
  ,主动技能={} }

  战斗单位[3]={
  名称="幻影龙军"
  ,模型="进阶龙龟"
  ,变异=true
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={"高级必杀","高级连击","高级吸血"}
  ,主动技能={} }

  战斗单位[4]={
  名称="幻影龙军"
  ,模型="进阶龙龟"
  ,变异=true
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={"高级必杀","高级连击","高级吸血"}
  ,主动技能={} }

  战斗单位[5]={
  名称="阎魔"
  ,模型="进阶踏云兽"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["化生寺"] }

  战斗单位[6]={
  名称="怒水恶龙"
  ,模型="蛟龙"
  ,变异=true
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["龙宫"] }

  战斗单位[7]={
  名称="火苗"
  ,模型="超级红孩儿"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["盘丝洞"] }

  战斗单位[8]={
  名称="火焰"
  ,模型="超级红孩儿"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=取随机法术(4) }

  战斗单位[9]={
  名称="火神"
  ,模型="超级红孩儿"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=取随机法术(4) }

  战斗单位[10]={
  名称="火妖"
  ,模型="超级红孩儿"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=取随机法术(4) }
  return 战斗单位
end

function 怪物属性:取副本九头虫信息(任务id,玩家id,序号)
  local 战斗单位={}
  	local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
  	local 难度=任务数据[任务id].难度 or 0
	local xlz = qz(1+难度/10+等级/100)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"}
  战斗单位[1]={
  名称="九头虫"
  ,模型="进阶鲛人"
  ,伤害=等级*18
  ,气血=等级*300
  ,灵力=等级*18
  ,速度=等级*3
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=100
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["女儿村"] }

  等级=等级
  战斗单位[2]={
  名称="秘魔"
  ,模型="进阶碧水夜叉"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*2
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=100
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["大唐官府"] }

  战斗单位[3]={
  名称="秘魔"
  ,模型="进阶碧水夜叉"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*2
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=100
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["魔王寨"] }

  战斗单位[4]={
  名称="秘魔"
  ,模型="进阶碧水夜叉"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*2
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=100
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=取随机法术(3) }

  战斗单位[5]={
  名称="秘魔"
  ,模型="进阶碧水夜叉"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*2
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=100
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=取随机物理法术(3) }

  战斗单位[6]={
  名称="影"
  ,模型="进阶月影仙"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*2
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=100
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=取随机法术(3) }

  战斗单位[7]={
  名称="魅"
  ,模型="进阶月影仙"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*2
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=100
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["盘丝洞"] }

  战斗单位[8]={
  名称="魔"
  ,模型="进阶月影仙"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*2
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=100
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=取随机法术(3) }

  战斗单位[9]={
  名称="妖"
  ,模型="进阶月影仙"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*2
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=100
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["女儿村"] }

战斗单位[10]={
  名称="兽"
  ,模型="进阶月影仙"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*2
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=100
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["女儿村"] }
  return 战斗单位
end

function 怪物属性:取副本万圣公主信息(任务id,玩家id,序号)
  local 战斗单位={}
  	local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
  	local 难度=任务数据[任务id].难度 or 0
	local xlz = qz(1+难度/10+等级/100)*10 --怪修炼
	local qmenpai = {"狮驼岭","大唐官府","大唐官府","狮驼岭","龙宫","神木林","魔王寨","普陀山","五庄观","化生寺"}
  战斗单位[1]={
  名称="万圣公主"
  ,模型="进阶月魅"
  ,伤害=等级*18
  ,气血=等级*300
  ,灵力=等级*18
  ,速度=等级*2
  ,防御=等级*3
  ,法防=等级*5
  ,躲闪=500
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["龙宫"] }

  等级=等级
  战斗单位[2]={
  名称="公主侍卫"
  ,模型="云游火"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*2
  ,防御=等级*2
  ,法防=等级*5
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["女儿村"] }

  战斗单位[3]={
  名称="公主侍卫"
  ,模型="云游火"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*2
  ,防御=等级*2
  ,法防=等级*5
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["普陀山"] }

  战斗单位[4]={
  名称="龙宫护卫"
  ,模型="云游火"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*2
  ,防御=等级*2
  ,法防=等级*5
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=取随机物理法术(3) }

  战斗单位[5]={
  名称="龙宫护卫"
  ,模型="云游火"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*2
  ,防御=等级*2
  ,法防=等级*5
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=取随机物理法术(3) }

  战斗单位[6]={
  名称="风"
  ,模型="长乐灵仙"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*2
  ,防御=等级*2
  ,法防=等级*5
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["盘丝洞"] }

  战斗单位[7]={
  名称="雪"
  ,模型="长乐灵仙"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*2
  ,防御=等级*2
  ,法防=等级*5
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["女儿村"] }

  战斗单位[8]={
  名称="雨"
  ,模型="长乐灵仙"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*2
  ,防御=等级*2
  ,法防=等级*5
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["女儿村"] }

  战斗单位[9]={
  名称="电"
  ,模型="长乐灵仙"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*2
  ,防御=等级*2
  ,法防=等级*5
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["阴曹地府"] }

  战斗单位[10]={
  名称="雷"
  ,模型="长乐灵仙"
  ,伤害=等级*16
  ,气血=等级*200
  ,灵力=等级*16
  ,速度=等级*2
  ,防御=等级*2
  ,法防=等级*5
  ,躲闪=等级*4
  ,魔法=2000
  ,等级=等级
  ,技能={}
  ,主动技能=Q_门派法术["无底洞"] }
  return 战斗单位
end

function 怪物属性:取飞升阵法5战斗信息(任务id,玩家id,序号)
     local 战斗单位={}
     local 等级=玩家数据[玩家id].角色.等级
  	 local 蚩尤物理 = {"大唐官府","狮驼岭","凌波城"}
	 local 蚩尤法系 = {"神木林","魔王寨","龙宫"}
	 local 蚩尤封系 = {"女儿村","盘丝洞","五庄观"}
	 local 蚩尤辅助 = {"化生寺","普陀山"}
--	 local 蚩尤输出 = {"大唐官府","狮驼岭","凌波城","魔王寨","龙宫","神木林"}
	 local sx = self:取属性(等级,门派)
	 local 主怪是否为输出 = false
	 if sx.智能=="物理" or sx.智能=="法系" or sx.智能=="固伤" or sx.智能=="辅助" then
		--  主怪是否为输出 = true
	 end
				 门派 = 蚩尤物理[sj(1,#蚩尤物理)]
				 sx = self:取属性(等级,门派,"物理")
			战斗单位[1]={
				 名称="魔神蚩尤"
				,模型="蚩尤"
				,角色=true
				,伤害=等级*30+3000
				,气血=等级*600+200000
				,法伤=5000
				,速度=等级*6+500
				,防御=等级*12+1000
				,法防=等级*8+800
				,躲闪=等级*15
				,魔法=50000
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

				门派 = 蚩尤物理[sj(1,#蚩尤物理)]
				sx = self:取属性(等级,门派,"物理")
			战斗单位[2]={
				 名称="奢比尸"
				,模型="金乌月光虫"
				,角色=true
				,伤害=等级*20+3000
				,气血=等级*400+100000
				,法伤=2500
				,速度=等级*5+200
				,防御=等级*10+1000
				,法防=等级*5+1000
				,躲闪=等级*10
				,魔法=50000
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

				门派 =蚩尤物理[sj(1,#蚩尤物理)]
				sx = self:取属性(等级,门派,"物理")
		    战斗单位[3]={
				 名称="后土"
				,模型="火月蛙"
				,角色=true
				,伤害=等级*20+2500
				,气血=等级*400+100000
				,法伤=等级*10
				,速度=等级*5+200
				,防御=等级*10+1000
				,法防=等级*5+1000
				,躲闪=等级*10
				,魔法=50000
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

				门派 = 蚩尤法系[sj(1,#蚩尤法系)]
				sx = self:取属性(等级,门派,"法系")
			战斗单位[4]={
				 名称="翕兹"
				,模型="金乌火虫"
				,角色=true
				,伤害=等级*12
				,气血=等级*400+100000
				,法伤=等级*20+1500
				,速度=等级*5+200
				,防御=等级*10+1000
				,法防=等级*5+1000
				,躲闪=等级*10
				,魔法=50000
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

				门派 = 蚩尤法系[sj(1,#蚩尤法系)]
				sx = self:取属性(等级,门派,"法系")
			战斗单位[5]={
				名称="强良"
				,模型="进阶觉醒涂山雪"
				,伤害=等级*12
				,角色=true
				,气血=等级*400+100000
				,法伤=等级*20+1500
				,速度=等级*3+200
				,防御=等级*10+1000
				,法防=等级*5+1000
				,饰品=true
				,躲闪=等级*10
				,魔法=50000
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

				门派 = 蚩尤法系[sj(1,#蚩尤法系)]
				sx = self:取属性(等级,门派,"法系")
			战斗单位[6]={
				 名称="蓐收"
				,模型="进阶雾中仙"
				,角色=true
				,伤害=等级*15
				,气血=等级*400+100000
				,法伤=等级*20+1500
				,速度=等级*3+200
				,防御=等级*10+1000
				,法防=等级*5+1000
				,饰品=true
				,躲闪=等级*10
				,魔法=50000
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

				门派 = 蚩尤法系[sj(1,#蚩尤法系)]
				sx = self:取属性(等级,门派,"法系")
			战斗单位[7]={
				 名称="共工"
				,模型="进阶泪妖"
				,角色=true
				,伤害=等级*12
				,气血=等级*400+100000
				,法伤=2500
				,速度=等级*6+400
				,防御=3500
				,法防=等级*5+1000
				,躲闪=等级*10
				,魔法=50000
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

				门派 = 蚩尤封系[sj(1,#蚩尤封系)]
				sx = self:取属性(等级,门派,"封系")
			战斗单位[8]={
				 名称="帝江"
				,模型="进阶狂豹人形"
				,角色=true
				,伤害=等级*20+2500
				,气血=等级*400+100000
				,法伤=等级*10
				,速度=等级*6+400
				,防御=等级*8+1200
				,法防=等级*5+1000
				,躲闪=等级*10
				,魔法=50000
				,愤怒=9999
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

				门派 = 蚩尤物理[sj(1,#蚩尤物理)]
				sx = self:取属性(等级,门派,"物理")
			战斗单位[9]={
				名称="天昊"
				,模型="进阶蛟龙"
				,角色=true
				,伤害=等级*20+2500
				,气血=等级*400+100000
				,法伤=等级*15
				,速度=等级*3+400
				,防御=等级*10+1000
				,法防=等级*8+1000
				,躲闪=等级*20
				,魔法=50000
				,愤怒=9999
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

				门派 = 蚩尤辅助[sj(1,#蚩尤辅助)]
				sx = self:取属性(等级,门派,"辅助")
			战斗单位[10]={
				名称="玄冥"
				,模型="进阶雨师"
				,角色=true
				,伤害=等级*12
				,气血=等级*450+100000
				,法伤=等级*10
				,速度=等级*6+300
				,防御=等级*12+1200
				,法防=等级*6+1200
				,治疗能力=3500
				,愤怒=9999
				,躲闪=等级*20
				,魔法=50000
				,等级=等级
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				}

                门派 = 蚩尤辅助[sj(1,#蚩尤辅助)]
				sx = self:取属性(等级,门派,"辅助")
			战斗单位[11]={
				名称="暗影"
				,模型="进阶毗舍童子"
				,饰品显示=true
				,炫彩=取染色id("毗舍童子")
				,炫彩组=取炫彩染色("黑色")
				,不可操作=true
				,角色=true
				,伤害=等级*5
				,气血=等级*350+50000
				,法伤=等级*10
				,速度=5000
				,防御=等级*4
				,法防=等级*4
				,治疗能力=200
				,愤怒=9999
				,躲闪=等级*20
				,魔法=20000
				,等级=等级
				}
  return 战斗单位
end

function 怪物属性:取通天塔信息(任务id,玩家id,序号)
  local 假人随机阵法 = {"普通","天覆阵","地载阵","风扬阵","云垂阵","龙飞阵","虎翼阵","鸟翔阵","蛇蟠阵","鹰啸阵","雷绝阵"}
  local 通天塔层数 = 通天塔数据[玩家id].层数
  local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
  if 通天塔层数==nil then
    通天塔层数=0
  end
  if 通天塔层数 >= 0 and 通天塔层数<999 then
    self.难度系数 = 1+((通天塔层数/10)/5)
  end
  local 战斗单位={}
  战斗单位.附加阵法=假人随机阵法[取随机数(1,#假人随机阵法)]
   local 造型组=取地宫挑战模型1(通天塔数据[玩家id].层数)
   local 造型 = 造型组[取随机数(1,#造型组)]
    战斗单位[1] = {
    模型=造型,
    名称 = "通天"..(通天塔层数+1).."层队长",
    等级 = 等级,
    气血 = 10000+等级 * 220*self.难度系数,
    伤害 = 等级 * 22*self.难度系数,
    法伤 = 等级 * 11*self.难度系数,
    法防 = 等级 * 8*self.难度系数,
    防御 = 等级 * 8*self.难度系数,
    速度 = 等级 * 6*self.难度系数,
    躲闪 = 等级 * 3,
    魔法 = 50000,
    变异=true,
    主动技能 = {"龙卷雨击","飞砂走石","八凶法阵","雷霆万钧","流沙轻音"},
    技能 = {"高级魔之心","高级法术暴击","高级法术连击","高级精神集中","高级感知"}
  }
    local 造型组=取地宫挑战模型1(通天塔数据[玩家id].层数)
    local 造型 = 造型组[取随机数(1,#造型组)]
    战斗单位[2] = {
    模型=造型,
    名称 = "通天"..(通天塔层数+1).."层队长",
    等级 = 等级,
    气血 = 5000+等级 * 200*self.难度系数,
    伤害 = 等级 * 20*self.难度系数,
    法伤 = 等级 * 11*self.难度系数,
    法防 = 等级 * 6*self.难度系数,
    防御 = 等级 * 6*self.难度系数,
    速度 = 等级 * 5*self.难度系数,
    躲闪 = 等级 * 2,
    魔法 = 20000,
    变异=true,
    主动技能 = 取随机法术(5),
    技能 = {"高级必杀","高级魔之心","高级法术暴击","高级法术连击","高级吸血","高级感知"}
  }
    local 造型组=取地宫挑战模型1(通天塔数据[玩家id].层数)
    local 造型 = 造型组[取随机数(1,#造型组)]
   战斗单位[3] = {
    模型=造型,
    名称 = "通天"..(通天塔层数+1).."层队长",
    等级 = 等级,
    气血 = 5000+等级 * 200*self.难度系数,
    伤害 = 等级 * 20*self.难度系数,
    法伤 = 等级 * 11*self.难度系数,
    法防 = 等级 * 6*self.难度系数,
    防御 = 等级 * 6*self.难度系数,
    速度 = 等级 * 5*self.难度系数,
    躲闪 = 等级 * 2,
    魔法 = 20000,
    变异=true,
    主动技能 = 取随机法术(5),
    技能 = {"高级魔之心","高级法术暴击","高级法术连击","高级感知"}
  }
   local 造型组=取地宫挑战模型1(通天塔数据[玩家id].层数)
   local 造型 = 造型组[取随机数(1,#造型组)]
   local sx = self:取属性(等级,"龙宫")
   战斗单位[4] = {
    模型=造型,
    名称 = "通天"..(通天塔层数+1).."层队长",
    等级 = 等级,
    气血 = 5000+等级 * 200*self.难度系数,
    伤害 = 等级 * 20*self.难度系数,
    法伤 = 等级 *11*self.难度系数,
    法防 = 等级 * 10*self.难度系数,
    防御 = 等级 * 10*self.难度系数,
    速度 = 等级 * 10*self.难度系数,
    躲闪 = 等级 * 1 ,
    魔法 = 20000,
    变异=true,
    主动技能 = {"日月乾坤","失心符","似玉生香"},
    技能 = {"高级防御","高级幸运","高级敏捷"}
  }
   local 造型组=取地宫挑战模型1(通天塔数据[玩家id].层数)
   local 造型 = 造型组[取随机数(1,#造型组)]
  战斗单位[5] = {
    模型=造型,
    名称 = "通天"..(通天塔层数+1).."层队长",
    等级 = 等级,
    气血 = 5000+等级 * 200*self.难度系数,
    伤害 = 等级 * 20*self.难度系数,
    法伤 = 等级 * 11*self.难度系数,
    法防 = 等级 * 6*self.难度系数,
    防御 = 等级 * 6*self.难度系数,
    速度 = 等级 * 5*self.难度系数,
    躲闪 = 等级 * 1 ,
    魔法 = 20000,
    变异=true,
    主动技能 = {"狮搏","鹰击"},
    技能 = {"高级必杀","高级吸血","高级感知"}
  }
  for n = 6, 10 do
   local 造型组=取地宫挑战模型1(通天塔数据[玩家id].层数)
   local 造型 = 造型组[取随机数(1,#造型组)]
    战斗单位[n] = {
    模型=造型,
    名称 = "通天"..(通天塔层数+1).."层兵",
    等级 = 等级,
    气血 = 5000+等级 * 200*self.难度系数,
    伤害 = 等级 * 20*self.难度系数,
    法伤 = 等级 * 11*self.难度系数,
    法防 = 等级 * 6*self.难度系数,
    防御 = 等级 * 6*self.难度系数,
    速度 = 等级 * 5*self.难度系数,
    躲闪 = 等级 * 1 ,
    魔法 = 20000,
    变异=true,
    主动技能 = {"龙卷雨击","浪涌","横扫千军","飞砂走石","奔雷咒","八凶法阵"},
    技能 = {"高级必杀","高级魔之心","高级法术暴击","高级法术连击","高级吸血","高级感知"}
    }
  end
  return 战斗单位
end

function 怪物属性:雁塔地宫信息(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 层数=雁塔地宫:取地宫最低层数(队伍数据[玩家数据[玩家id].队伍].成员数据)
	 local 属性递增={气血=层数*150,伤害=层数*8,法伤=qz(层数*5),速度=层数*3,封印=qz(层数*1.2),固伤=qz(层数),治疗=qz(层数)}
	 local gw=雁塔地宫.取怪物[层数]
	 local 门派=gw[1].QT.门派
	 local AI=gw[1].QT.AI
	 local sx
	 if 门派 then
	     sx = self:取属性(等级,门派,AI)
	 else
	 	sx = self:取属性(等级,nil,AI)
	 end

	 战斗单位[1]={
		名称=gw[1].名称
		,模型=gw[1].模型
		,不可封印=gw[1].不可封印
		,等级=等级
		,气血 = qz( (sx.属性.气血 * 50+属性递增.气血) *gw[1].额外面板百分比.气血)
		,伤害 = qz( (sx.属性.伤害 * 1.2+属性递增.伤害) *gw[1].额外面板百分比.伤害)
		,法伤 = qz( (sx.属性.法伤 * 1.1+属性递增.法伤) *gw[1].额外面板百分比.法伤)
		,速度 = qz( (sx.属性.速度 * 速度削弱 *1.2+属性递增.速度) *gw[1].额外面板百分比.速度)
		,固定伤害 = qz( (等级*7+属性递增.固伤) *gw[1].额外面板百分比.固定伤害)
		,治疗能力 = qz( (等级*6+属性递增.治疗) *gw[1].额外面板百分比.治疗能力)
		,封印命中等级= qz( (100+属性递增.封印) *gw[1].额外面板百分比.封印命中等级)
		,抵抗封印等级= qz( (-50) *gw[1].额外面板百分比.抵抗封印等级)
		,受伤百分比=gw[1].额外面板百分比.受伤百分比
		,增伤百分比= gw[1].额外面板百分比.增伤百分比
		,递增伤害= gw[1].额外面板百分比.递增伤害
		,防御 = qz((等级*11))
		,法防 = qz((等级*3))
		,变异=gw[1].QT.变异
		,饰品显示=gw[1].QT.饰品
		,染色方案=gw[1].QT.染色方案
		,染色组=gw[1].QT.染色组
		,前缀=gw[1].前缀
		,后缀=gw[1].后缀
		,主怪=true
		,层数=层数
		,技能=gw[1].QT.被动技能
		,主动技能=gw[1].QT.主动技能
		,门派=gw[1].QT.门派
		,AI战斗 = {AI=gw[1].QT.AI}
	 }
	for n=2,#gw do
		门派=gw[n].QT.门派
		AI=gw[n].QT.AI
		if 门派 then
			sx = self:取属性(等级,门派,AI)
		else
			sx = self:取属性(等级,nil,AI)
		end
		战斗单位[n]={
			名称=gw[n].名称
			,模型=gw[n].模型
			,不可封印=gw[n].不可封印
			,防御 = qz((等级*9))
			,法防 = qz((等级*3))
			,等级=等级
			,气血 = qz( (sx.属性.气血 * 25+属性递增.气血) *gw[n].额外面板百分比.气血)
			,伤害 = qz( (sx.属性.伤害 +属性递增.伤害) *gw[n].额外面板百分比.伤害)
			,法伤 = qz( (sx.属性.法伤 +属性递增.法伤) *gw[n].额外面板百分比.法伤)
			,速度 = qz( (sx.属性.速度 * 速度削弱 *1.1+属性递增.速度) *gw[n].额外面板百分比.速度)
			,固定伤害 = qz( (等级*2.5+属性递增.固伤) *gw[n].额外面板百分比.固定伤害)
			,治疗能力 = qz( (等级*3+属性递增.治疗) *gw[n].额外面板百分比.治疗能力)
			,封印命中等级= qz( (80+属性递增.封印) *gw[n].额外面板百分比.封印命中等级)
			,抵抗封印等级= qz( (-100) *gw[n].额外面板百分比.抵抗封印等级)
			,受伤百分比=gw[n].额外面板百分比.受伤百分比
			,增伤百分比= gw[n].额外面板百分比.增伤百分比
			,递增伤害= gw[n].额外面板百分比.递增伤害
			,变异=gw[n].QT.变异
			,饰品显示=gw[n].QT.饰品
			,染色方案=gw[n].QT.染色方案
			,染色组=gw[n].QT.染色组
			,前缀=gw[n].前缀
			,后缀=gw[n].后缀
			,层数=层数
			,技能=gw[n].QT.被动技能
			,主动技能=gw[n].QT.主动技能
			,门派=gw[n].QT.门派
			,AI战斗 = {AI=gw[n].QT.AI}
		}
	end
	return 战斗单位
end

function 怪物属性:保卫长安_振威大王(任务id,玩家id,序号) --6
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,饰品显示=true
		  ,不可封印=true
		  ,防御 = qz(等级*8)
		  ,法防 = qz(等级*2)
		  ,染色方案=64 --粉
		  ,染色组={[1]=1,[2]=0}
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[2]={
		  名称="混世魔童"
		  ,模型="进阶毗舍童子"
		  ,等级=等级
		  ,饰品显示=true
		  ,防御 = qz(等级*8)
		  ,法防 = qz(等级*2)
		  ,染色方案=64 --粉
		  ,染色组={[1]=1,[2]=0}
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"盘丝洞","封系")
	 战斗单位[3]={
		  名称="莲台妖花"
		  ,模型="进阶曼珠沙华"
		  ,等级=等级
		  ,防御 = qz(等级*8)
		  ,法防 = qz(等级*2)
		  ,染色方案=64 --粉
		  ,染色组={[1]=1,[2]=0}
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,封印命中等级=QAQ[序号].封印等级[1]
		  ,抵抗封印等级=QAQ[序号].抗封等级[1]
		  ,饰品显示=true
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府","物理")
	 战斗单位[4]={
		  名称="鬼影迷踪"
		  ,模型="进阶蜃气妖"
		  ,等级=等级
		  ,防御 = qz(等级*8)
		  ,法防 = qz(等级*2)
		  ,染色方案=64 --粉
		  ,染色组={[1]=1,[2]=0}
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"化生寺","辅助")
	 战斗单位[5]={
		  名称="持杖邪魅"
		  ,模型="进阶修罗傀儡妖"
		  ,等级=等级
		  ,防御 = qz(等级*8)
		  ,法防 = qz(等级*2)
		  ,染色方案=64 --粉
		  ,染色组={[1]=1,[2]=0}
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,封印命中等级=QAQ[序号].封印等级[1]
		  ,抵抗封印等级=QAQ[序号].抗封等级[1]
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=6,10 do
		  local mx=长安保卫战.dawang[取随机数(1,#长安保卫战.dawang)]
		  sx = self:取属性(等级,self:取随机输出门派())
		  战斗单位[i]={
				名称="妖魔鬼怪"
				,模型=mx
				,防御 = qz(等级*8)
				,法防 = qz(等级*2)
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:保卫长安_兕怪(任务id,玩家id,序号) --6
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,防御 = qz(等级*5)
		  ,法防 = qz(等级*3)
		  ,染色方案=77
		  ,染色组={[1]=1,[2]=0}
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,封印命中等级=QAQ[序号].封印等级[1]
		  ,抵抗封印等级=QAQ[序号].抗封等级[1]
		  ,饰品显示=true
		  ,不可封印=true
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","辅助")
	 战斗单位[2]={
		  名称="致命毒蝎"
		  ,模型="进阶蝎子精"
		  ,等级=等级
		  ,防御 = qz(等级*4)
		  ,法防 = qz(等级*2)
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,封印命中等级=QAQ[序号].封印等级[1]
		  ,抵抗封印等级=QAQ[序号].抗封等级[1]
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"化生寺","辅助")
	 战斗单位[3]={
		  名称="响尾灵蛇"
		  ,模型="进阶巴蛇"
		  ,防御 = qz(等级*4)
		  ,法防 = qz(等级*2)
		  ,染色方案=52
		  ,染色组={[1]=1,[2]=0}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,封印命中等级=QAQ[序号].封印等级[1]
		  ,抵抗封印等级=QAQ[序号].抗封等级[1]
		  ,饰品显示=true
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府","物理")
	 战斗单位[4]={
		  名称="勾魂修罗"
		  ,模型="修罗傀儡鬼"
		  ,防御 = qz(等级*4)
		  ,法防 = qz(等级*2)
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府","物理")
	 战斗单位[5]={
		  名称="掌灯幽灵"
		  ,模型="幽萤娃娃"
		  ,防御 = qz(等级*4)
		  ,法防 = qz(等级*2)
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=6,10 do
		  local mx=长安保卫战.toumu[取随机数(1,#长安保卫战.toumu)]
		  sx = self:取属性(等级,self:取随机法系门派())
		  战斗单位[i]={
				名称="妖魔鬼怪"
				,防御 = qz(等级*4)
				,法防 = qz(等级*2)
				,模型=mx
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:保卫长安_鼍龙(任务id,玩家id,序号) --5
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"龙宫","法系")
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,防御 = qz(等级*5)
		  ,法防 = qz(等级*3)
		  ,染色方案=76
		  ,染色组={[1]=1,[2]=0}
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,饰品显示=true
		  ,技能={"感知"}
		  ,不可封印=true
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城","物理")
	 战斗单位[2]={
		  名称="双刃魔君"
		  ,模型="进阶修罗傀儡鬼"
		  ,等级=等级
		  ,防御 = qz(等级*4)
		  ,法防 = qz(等级*2)
		  ,染色方案=76
		  ,染色组={[1]=1,[2]=0}
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府","物理")
	 战斗单位[3]={
		  名称="凶牙猛虎"
		  ,模型="噬天虎"
		  ,等级=等级
		  ,防御 = qz(等级*4)
		  ,法防 = qz(等级*2)
		  ,染色方案=76
		  ,染色组={[1]=1,[2]=0}
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"五庄观","封系")
	 战斗单位[4]={
		  名称="遁地奇兽"
		  ,模型="蜃气妖"
		  ,防御 = qz(等级*4)
		  ,法防 = qz(等级*2)
		  ,染色方案=76
		  ,染色组={[1]=1,[2]=0}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,封印命中等级=QAQ[序号].封印等级[1]
		  ,抵抗封印等级=QAQ[序号].抗封等级[1]
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"天宫","法系")
	 战斗单位[5]={
		  名称="蒙面罗刹"
		  ,模型="夜罗刹"
		  ,防御 = qz(等级*4)
		  ,法防 = qz(等级*2)
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=6,10 do
		  local mx=长安保卫战.toumu[取随机数(1,#长安保卫战.toumu)]
		  sx = self:取属性(等级,self:取随机物理门派())
		  战斗单位[i]={
				名称="妖魔鬼怪"
				,模型=mx
				,防御 = qz(等级*4)
				,法防 = qz(等级*2)
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:保卫长安_魉(任务id,玩家id,序号) --4
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"天宫","物理")
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,防御 = qz(等级*4)
		  ,法防 = qz(等级*2)
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,饰品显示=true
		  ,不可封印=true
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"化生寺","法系")
	 战斗单位[2]={
		  名称="玉面妖精"
		  ,模型="雾中仙"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"化生寺","法系")
	 战斗单位[3]={
		  名称="魔音琵琶"
		  ,模型="蝎子精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府","物理")
	 战斗单位[4]={
		  名称="伞夜魔仙"
		  ,模型="蜘蛛精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府","物理")
	 战斗单位[5]={
		  名称="百爪魔灵"
		  ,模型="百足将军"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=6,8 do
		  -- local 门派,物法=self:取随机输出门派()
		  local mx=长安保卫战.xianfeng[取随机数(1,#长安保卫战.xianfeng)]
		  sx = self:取属性(等级,"狮驼岭","物理")
		  战斗单位[i]={
				名称="妖魔鬼怪"
				,模型=mx
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:保卫长安_魍(任务id,玩家id,序号) --3
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"化生寺","辅助")
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,防御 = qz(等级*4)
		  ,法防 = qz(等级*2)
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,封印命中等级=QAQ[序号].封印等级[1]
		  ,抵抗封印等级=QAQ[序号].抗封等级[1]
		  ,饰品显示=true
		  ,不可封印=true
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫","法系")
	 战斗单位[2]={
		  名称="暗箭伤人"
		  ,模型="机关兽"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[3]={
		  名称="惑人机关"
		  ,模型="机关鸟"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"天宫","物理")
	 战斗单位[4]={
		  名称="夺命蛛丝"
		  ,模型="蜘蛛精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"盘丝洞","物理")
	 战斗单位[5]={
		  名称="牛气冲天"
		  ,模型="牛妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=6,8 do
		  local 门派,物法=self:取随机输出门派()
		  local mx=长安保卫战.xianfeng[取随机数(1,#长安保卫战.xianfeng)]
		  sx = self:取属性(等级,门派,物法)
		  战斗单位[i]={
				名称="妖魔鬼怪"
				,模型=mx
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:保卫长安_魅(任务id,玩家id,序号) --2
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"神木林","法系")
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,防御 = qz(等级*4)
		  ,法防 = qz(等级*2)
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,不可封印=true
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[2]={
		  名称="白衣秀士"
		  ,模型="千年蛇魅"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城","物理")
	 战斗单位[3]={
		  名称="凶神恶煞"
		  ,模型="律法女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"化生寺","辅助")
	 战斗单位[4]={
		  名称="行尸走肉"
		  ,模型="野鬼"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,封印命中等级=QAQ[序号].封印等级[1]
		  ,抵抗封印等级=QAQ[序号].抗封等级[1]
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[5]={
		  名称="碧玉精灵"
		  ,模型="如意仙子"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,封印命中等级=QAQ[序号].封印等级[1]
		  ,抵抗封印等级=QAQ[序号].抗封等级[1]
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=6,8 do
		  local 门派,物法=self:取随机输出门派()
		  local mx=长安保卫战.xianfeng[取随机数(1,#长安保卫战.xianfeng)]
		  sx = self:取属性(等级,门派,物法)
		  战斗单位[i]={
				名称="妖魔鬼怪"
				,模型=mx
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:保卫长安_魑(任务id,玩家id,序号) --1
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,变异=true
		  ,防御 = qz(等级*4)
		  ,法防 = qz(等级*2)
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,饰品显示=true
		  ,不可封印=true
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[2]={
		  名称="魑魅蛇妖"
		  ,模型="千年蛇魅"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[3]={
		  名称="索命海鲛"
		  ,模型="鲛人"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"化生寺","辅助")
	 战斗单位[4]={
		  名称="百面伶鬼"
		  ,模型="地狱战神"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,封印命中等级=QAQ[序号].封印等级[1]
		  ,抵抗封印等级=QAQ[序号].抗封等级[1]
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"方寸山","封系")
	 战斗单位[5]={
		  名称="浴血火凤"
		  ,模型="凤凰"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,封印命中等级=QAQ[序号].封印等级[1]
		  ,抵抗封印等级=QAQ[序号].抗封等级[1]
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=6,8 do
		  local 门派,物法=self:取随机输出门派()
		  local mx=长安保卫战.xianfeng[取随机数(1,#长安保卫战.xianfeng)]
		  sx = self:取属性(等级,门派,物法)
		  战斗单位[i]={
				名称="妖魔鬼怪"
				,模型=mx
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:保卫长安_先锋(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 数量=取随机数(7,8)
	 local 门派,物法=self:取随机输出门派()
	 local sx = self:取属性(等级,门派,物法)
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 local 小怪名称={"术精岐黄","铜墙铁壁","力大无穷","飞檐走壁","外强中干","救死扶伤","固若金汤","身强体壮","铜墙铁壁","杏林高手","生龙活虎","拔山扛鼎","萌萌"}
	 local 萌萌={"海星","章鱼"}
	 local 狸={"花妖","狸"}
	 for i=2,数量 do
		  local 门派,物法=self:取随机输出门派()
		  local 模型=取随机怪(5,55)
		  模型=模型[2]
		  local mc=小怪名称[取随机数(1,#小怪名称)]
		  if mc=="萌萌" then
				模型=萌萌[取随机数(1,#萌萌)]
		  end
		  sx = self:取属性(等级,门派,物法)
		  战斗单位[i]={
				名称=mc
				,模型=模型
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 if 取随机数()<=50 then
		  sx = self:取属性(等级,nil,"封系")
		  战斗单位[数量+1]={
				名称="狸"
				,模型=狸[取随机数(1,#狸)]
				,变异=true
				,被封必中=true
				,额外目标数=2
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[数量+1])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[数量+1])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[数量+1])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[数量+1])
				,主动技能={"失心符","似玉生香","含情脉脉"}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:保卫长安_头目(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 数量=取随机数(8,9)
	 local 门派,物法=self:取随机输出门派()
	 local sx = self:取属性(等级,门派,物法)
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 local 小怪名称={"术精岐黄","铜墙铁壁","力大无穷","飞檐走壁","外强中干","救死扶伤","固若金汤","身强体壮","铜墙铁壁","杏林高手","生龙活虎","拔山扛鼎","萌萌"}
	 local 萌萌={"海星","章鱼"}
	 local 狸={"花妖","狸"}
	 for i=2,数量 do
		  local 门派,物法=self:取随机输出门派()
		  local 模型=取随机怪(75,95)
		  模型=模型[2]
		  local mc=小怪名称[取随机数(1,#小怪名称)]
		  if mc=="萌萌" then
				模型=萌萌[取随机数(1,#萌萌)]
		  end
		  sx = self:取属性(等级,门派,物法)
		  战斗单位[i]={
				名称=mc
				,模型=模型
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 if 取随机数()<=70 then
		  sx = self:取属性(等级,nil,"封系")
		  战斗单位[数量+1]={
				名称="狸"
				,模型=狸[取随机数(1,#狸)]
				,变异=true
				,被封必中=true
				,额外目标数=2
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[数量+1])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[数量+1])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[数量+1])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[数量+1])
				,主动技能={"失心符","似玉生香","含情脉脉"}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:保卫长安_大王(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 数量=9
	 local 门派,物法=self:取随机输出门派()
	 local sx = self:取属性(等级,门派,物法)
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,防御 = qz(等级*4)
		  ,法防 = qz(等级*2)
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 local 小怪名称={"术精岐黄","铜墙铁壁","力大无穷","飞檐走壁","外强中干","救死扶伤","固若金汤","身强体壮","铜墙铁壁","杏林高手","生龙活虎","拔山扛鼎","萌萌"}
	 local 萌萌={"海星","章鱼"}
	 local 狸={"花妖","狸"}
	 for i=2,数量 do
		  local 门派,物法=self:取随机输出门派()
		  local 模型=取随机怪(115,155)
		  模型=模型[2]
		  local mc=小怪名称[取随机数(1,#小怪名称)]
		  if mc=="萌萌" then
				模型=萌萌[取随机数(1,#萌萌)]
		  end
		  sx = self:取属性(等级,门派,物法)
		  战斗单位[i]={
				名称=mc
				,模型=模型
				,等级=等级
				,防御 = qz(等级*2)
				,法防 = qz(等级*1)
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 -- if 取随机数()<=100 then
		  sx = self:取属性(等级,nil,"封系")
		  战斗单位[数量+1]={
				名称="狸"
				,模型=狸[取随机数(1,#狸)]
				,变异=true
				,被封必中=true
				,额外目标数=2
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[数量+1])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[数量+1])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[数量+1])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[数量+1])
				,主动技能={"失心符","似玉生香","含情脉脉"}
		  }
	 return 战斗单位
end

function 怪物属性:通天河灵灯(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"魔王寨")
	 local 武器属性=取150角色武器("神天兵")
	 战斗单位[1]={
		  名称="灵感分身"
		  ,模型="神天兵"
		  ,主怪=true
		  ,不可封印=true
		  ,角色=true
		  ,开场发言="你们以为我只有一个人吗#24"
		  ,武器={名称=武器属性.武器,级别限制=武器属性.级别,子类=武器属性.子类}
		  ,染色方案=Qu角色属性["神天兵"].染色方案
		  ,染色组={[1]=取随机数(1,6),[2]=取随机数(1,6),[3]=取随机数(1,6)}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1] * 血量削弱1)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = 9999
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"高级必杀"}
		  ,修炼 = {物抗=3,法抗=3,攻修=3}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end

function 怪物属性:通天河善财童子(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[1]={
		  名称="善财童子"
		  ,模型="葫芦宝贝"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1] * 血量削弱1)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"高级法术暴击"}
		  ,修炼 = {物抗=3,法抗=3,攻修=3}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","辅助")
	 战斗单位[2]={
		  名称="润下"
		  ,模型="净瓶女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2] * 血量削弱1)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","辅助")
	 战斗单位[3]={
		  名称="润下"
		  ,模型="净瓶女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3] * 血量削弱1)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","辅助")
	 战斗单位[4]={
		  名称="炎上"
		  ,模型="净瓶女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4] * 血量削弱1)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[5]={
		  名称="炎上"
		  ,模型="净瓶女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5] * 血量削弱1)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[6]={
		  名称="稼穑"
		  ,模型="净瓶女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6] * 血量削弱1)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[7]={
		  名称="稼穑"
		  ,模型="净瓶女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7] * 血量削弱1)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[8]={
		  名称="女娲"
		  ,模型="净瓶女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6] * 血量削弱1)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[9]={
		  名称="女娲"
		  ,模型="净瓶女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6] * 血量削弱1)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[10]={
		  名称="女娲"
		  ,模型="净瓶女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6] * 血量削弱1)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end

function 怪物属性:通天河木材(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[1]={
		  名称="红色竹精"
		  ,模型="泡泡"
		  ,等级=等级
		  ,炫彩=取染色id("泡泡")
		  ,炫彩组=取炫彩染色("番茄红")
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1] * 血量削弱1)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="黄色竹精"
		  ,模型="泡泡"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2] * 血量削弱1)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="蓝色竹精"
		  ,模型="泡泡"
		  ,炫彩=取染色id("泡泡")
		  ,炫彩组=取炫彩染色("蓝色")
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3] * 血量削弱1)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="白色竹精"
		  ,模型="泡泡"
		  ,炫彩=取染色id("泡泡")
		  ,炫彩组=取炫彩染色("白色")
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4] * 血量削弱1)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="黑色竹精"
		  ,模型="泡泡"
		  ,炫彩=取染色id("泡泡")
		  ,炫彩组=取炫彩染色("黑色")
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5] * 血量削弱1)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end

function 怪物属性:通天河金鱼1(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"魔王寨")
	 战斗单位[1]={
		  名称="红色鱼精"
		  ,模型="野鬼"
		  ,等级=等级
		  ,炫彩=取染色id("野鬼")
		  ,炫彩组=取炫彩染色("番茄红")
		  ,开场发言="在我的三昧真火下，化为灰烬吧！"
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="通天妖将"
		  ,模型="蚌精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="通天妖将"
		  ,模型="蚌精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="通天师爷"
		  ,模型="龟丞相"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"化生寺")
	 战斗单位[5]={
		  名称="食人医"
		  ,模型="龟丞相"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能=sx.技能组
	 }
	 	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="通天妖将"
		  ,模型="蚌精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,主动技能=sx.技能组
	 }
	 	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="通天妖将"
		  ,模型="蚌精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,主动技能=sx.技能组
	 }
	 	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="通天妖将"
		  ,模型="蚌精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,主动技能=sx.技能组
	 }
	 	 sx = self:取属性(等级)
	 战斗单位[9]={
		  名称="通天妖将"
		  ,模型="蚌精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,主动技能=sx.技能组
	 }
	 	 sx = self:取属性(等级)
	 战斗单位[10]={
		  名称="通天妖将"
		  ,模型="蚌精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end

function 怪物属性:通天河金鱼2(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"大唐官府")
	 战斗单位[1]={
		  名称="黄色鱼精"
		  ,模型="进阶地狱战神"
		  ,等级=等级
		  ,炫彩=取染色id("进阶地狱战神")
		  ,炫彩组=取炫彩染色("金黄")
		  ,开场发言="这群人竟然能封住真火，大哥你先撤，我砍死他们！"
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="通天妖将"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="通天妖将"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="通天师爷"
		  ,模型="龟丞相"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"化生寺")
	 战斗单位[5]={
		  名称="食人医"
		  ,模型="龟丞相"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="通天师爷"
		  ,模型="龟丞相"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="通天师爷"
		  ,模型="龟丞相"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="通天师爷"
		  ,模型="龟丞相"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级)
	 战斗单位[9]={
		  名称="通天师爷"
		  ,模型="龟丞相"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级)
	 战斗单位[10]={
		  名称="通天师爷"
		  ,模型="龟丞相"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end

function 怪物属性:通天河金鱼3(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"神木林")
	 战斗单位[1]={
		  名称="白色鱼精"
		  ,模型="曼珠沙华"
		  ,等级=等级
		  ,炫彩=取染色id("曼珠沙华")
		  ,炫彩组=取炫彩染色("白色")
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="通天妖将"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="通天妖将"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="通天师爷"
		  ,模型="龟丞相"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"化生寺")
	 战斗单位[5]={
		  名称="食人医"
		  ,模型="龟丞相"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="通天妖将"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="通天妖将"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="通天妖将"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[9]={
		  名称="通天妖将"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[10]={
		  名称="通天妖将"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end

function 怪物属性:通天河金鱼4(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"地府","固伤")
	 战斗单位[1]={
		  名称="蓝色鱼精"
		  ,模型="幽灵"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1]) * 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="通天妖将"
		  ,模型="蚌精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="通天妖将"
		  ,模型="蚌精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="通天师爷"
		  ,模型="龟丞相"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"化生寺")
	 战斗单位[5]={
		  名称="食人医"
		  ,模型="龟丞相"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="通天妖将"
		  ,模型="蚌精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="通天妖将"
		  ,模型="蚌精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="通天妖将"
		  ,模型="蚌精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[9]={
		  名称="通天妖将"
		  ,模型="蚌精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[10]={
		  名称="通天妖将"
		  ,模型="蚌精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end

function 怪物属性:通天河金鱼5(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"狮驼岭")
	 战斗单位[1]={
		  名称="黑色鱼精"
		  ,模型="鬼将"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="通天妖将"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="通天妖将"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="通天师爷"
		  ,模型="龟丞相"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"化生寺")
	 战斗单位[5]={
		  名称="食人医"
		  ,模型="龟丞相"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="通天妖将"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="通天妖将"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="通天妖将"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[9]={
		  名称="通天妖将"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[10]={
		  名称="通天妖将"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])* 1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end

function 怪物属性:通天河冤魂(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"地府","固伤")
	 战斗单位[1]={
		  名称="冤魂"
		  ,模型="野鬼"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"高级法术暴击"}
		  ,修炼 = {物抗=3,法抗=3,攻修=3}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"地府","固伤")
	 战斗单位[2]={
		  名称="见欲"
		  ,模型="蜃气妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"地府","固伤")
	 战斗单位[3]={
		  名称="听欲"
		  ,模型="蜃气妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"神木林")
	 战斗单位[4]={
		  名称="香欲"
		  ,模型="藤蔓妖花"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫")
	 战斗单位[5]={
		  名称="味欲"
		  ,模型="藤蔓妖花"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府")
	 战斗单位[6]={
		  名称="触欲"
		  ,模型="夜罗刹"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"魔王寨")
	 战斗单位[7]={
		  名称="意欲"
		  ,模型="野鬼"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"地府","固伤")
	 战斗单位[8]={
		  名称="听欲"
		  ,模型="蜃气妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"地府","固伤")
	 战斗单位[9]={
		  名称="听欲"
		  ,模型="蜃气妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"地府","固伤")
	 战斗单位[10]={
		  名称="听欲"
		  ,模型="蜃气妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end

function 怪物属性:通天河婴灵(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[1]={
		  名称="婴灵"
		  ,模型="幽灵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"高级法术暴击"}
		  ,修炼 = {物抗=3,法抗=3,攻修=3}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"五庄观")
	 战斗单位[2]={
		  名称="喜"
		  ,模型="葫芦宝贝"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"五庄观")
	 战斗单位[3]={
		  名称="乐"
		  ,模型="葫芦宝贝"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"五庄观")
	 战斗单位[4]={
		  名称="爱"
		  ,模型="葫芦宝贝"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府")
	 战斗单位[5]={
		  名称="怒"
		  ,模型="炎魔神"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府")
	 战斗单位[6]={
		  名称="恶"
		  ,模型="炎魔神"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"化生寺")
	 战斗单位[7]={
		  名称="哀"
		  ,模型="野鬼"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府")
	 战斗单位[8]={
		  名称="欲"
		  ,模型="野鬼"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"阴曹地府")
	 战斗单位[9]={
		  名称="欲"
		  ,模型="野鬼"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"阴曹地府")
	 战斗单位[10]={
		  名称="欲"
		  ,模型="野鬼"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end

function 怪物属性:通天河肺(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"狮驼岭")
	 战斗单位[1]={
		  名称="肺之守卫"
		  ,模型="金身罗汉"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="肺液"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="肺液"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="肺液"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府")
	 战斗单位[5]={
		  名称="肺液"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级,"阴曹地府")
	 战斗单位[6]={
		  名称="肺液"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级,"阴曹地府")
	 战斗单位[7]={
		  名称="肺液"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级,"阴曹地府")
	 战斗单位[8]={
		  名称="肺液"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级,"阴曹地府")
	 战斗单位[9]={
		  名称="肺液"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级,"阴曹地府")
	 战斗单位[10]={
		  名称="肺液"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end

function 怪物属性:通天河肝(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"魔王寨")
	 战斗单位[1]={
		  名称="肝之守卫"
		  ,模型="野鬼"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="肝火"
		  ,模型="凤凰"
		  ,炫彩=取染色id("凤凰")
		  ,炫彩组=取炫彩染色("番茄红")
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="肝火"
		  ,模型="凤凰"
		  ,炫彩=取染色id("凤凰")
		  ,炫彩组=取炫彩染色("番茄红")
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="肝火"
		  ,模型="凤凰"
		  ,炫彩=取染色id("凤凰")
		  ,炫彩组=取炫彩染色("番茄红")
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"狮驼岭")
	 战斗单位[5]={
		  名称="肝火"
		  ,模型="凤凰"
		  ,炫彩=取染色id("凤凰")
		  ,炫彩组=取炫彩染色("番茄红")
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级,"狮驼岭")
	 战斗单位[6]={
		  名称="肝火"
		  ,模型="凤凰"
		  ,炫彩=取染色id("凤凰")
		  ,炫彩组=取炫彩染色("番茄红")
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级,"狮驼岭")
	 战斗单位[7]={
		  名称="肝火"
		  ,模型="凤凰"
		  ,炫彩=取染色id("凤凰")
		  ,炫彩组=取炫彩染色("番茄红")
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级,"普陀山")
	 战斗单位[8]={
		  名称="肝火"
		  ,模型="凤凰"
		  ,炫彩=取染色id("凤凰")
		  ,炫彩组=取炫彩染色("番茄红")
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级,"女儿村")
	 战斗单位[9]={
		  名称="肝火"
		  ,模型="凤凰"
		  ,炫彩=取染色id("凤凰")
		  ,炫彩组=取炫彩染色("番茄红")
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级,"阴曹地府")
	 战斗单位[10]={
		  名称="肝火"
		  ,模型="凤凰"
		  ,炫彩=取染色id("凤凰")
		  ,炫彩组=取炫彩染色("番茄红")
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end

function 怪物属性:通天河肾(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"龙宫")
	 战斗单位[1]={
		  名称="肾之守卫"
		  ,模型="幽灵"
		  ,等级=等级
			,炫彩=取染色id("幽灵")
			,炫彩组=取炫彩染色("冷灰")
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="肾水"
		  ,模型="蛟龙"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="肾水"
		  ,模型="蛟龙"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="肾水"
		  ,模型="蛟龙"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫")
	 战斗单位[5]={
		  名称="肾水"
		  ,模型="蛟龙"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end

function 怪物属性:通天河脾(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"大唐官府")
	 战斗单位[1]={
		  名称="脾之守卫"
		  ,模型="鬼将"
		  ,等级=等级
		 -- ,开场发言="这群人竟然能封住真火，大哥你先撤，我砍死他们！"
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="脾气"
		  ,模型="夜罗刹"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="脾气"
		  ,模型="夜罗刹"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="脾气"
		  ,模型="夜罗刹"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"神木林")
	 战斗单位[5]={
		  名称="脾气"
		  ,模型="夜罗刹"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end

function 怪物属性:通天河心(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"五庄观")
	 战斗单位[1]={
		  名称="心之守卫"
		  ,模型="曼珠沙华"
		  ,等级=等级
		 -- ,开场发言="这群人竟然能封住真火，大哥你先撤，我砍死他们！"
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="心血"
		  ,模型="龙龟"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="心血"
		  ,模型="龙龟"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="心血"
		  ,模型="龙龟"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"方寸山")
	 战斗单位[5]={
		  名称="心血"
		  ,模型="龙龟"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end
function 怪物属性:通天河灵感元神(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"龙宫")
	 战斗单位[1]={
		  名称="灵感元神"
		  ,模型="帮派妖兽"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级,"魔王寨")
	 战斗单位[2]={
		  名称="护命符咒-肝"
		  ,模型="野鬼"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"化生寺")
	 战斗单位[3]={
		  名称="护命符咒-肺"
		  ,模型="金身罗汉"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城")
	 战斗单位[4]={
		  名称="护命符咒-肾"
		  ,模型="幽灵"
		  ,炫彩=取染色id("幽灵")
		  ,炫彩组=取炫彩染色("冷灰")
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府")
	 战斗单位[5]={
		  名称="护命符咒-脾"
		  ,模型="鬼将"
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"五庄观")
	 战斗单位[6]={
		  名称="护命符咒-心"
		  ,模型="曼珠沙华"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[7]={
		  名称="游魂"
		  ,模型="蜃气妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[8]={
		  名称="游魂"
		  ,模型="蜃气妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"狮驼岭")
	 战斗单位[9]={
		  名称="游魂"
		  ,模型="蜃气妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"狮驼岭")
	 战斗单位[10]={
		  名称="游魂"
		  ,模型="蜃气妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end

function 怪物属性:颜色ces(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[1]={
		  名称="黄色"
		  ,模型="泡泡"
		  ,等级=等级
		  ,炫彩=取染色id("泡泡")
		  ,炫彩组=取炫彩染色("黄色")
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="正常"
		  ,模型="泡泡"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
	--     ,门派=sx.门派
	--     ,AI战斗 = {AI=sx.智能}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="蓝色"
		  ,模型="泡泡"
		  ,炫彩=取染色id("泡泡")
		  ,炫彩组=取炫彩染色("蓝色")
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="白色"
		  ,模型="泡泡"
		  ,炫彩=取染色id("泡泡")
		  ,炫彩组=取炫彩染色("白色")
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="黑色"
		  ,模型="泡泡"
		  ,炫彩=取染色id("泡泡")
		  ,炫彩组=取炫彩染色("黑色")
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end

function 怪物属性:取28星宿属性(任务id,玩家id,序号)
	 local 模型 ={"天兵","天兵","星灵仙子"}
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"龙宫")
	 local 数量=取随机数(2,3)
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型="天兵"
		  ,变异=true
		  ,主怪=true
		  ,不可封印=true
		  ,等级=等级
		  ,防御 = qz(等级*6)
		  ,法防 = qz(等级*4)
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知","高级反击"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 for i=2,数量 do
		  local mx=模型[取随机数(1,#模型)]
		  local mc="护卫兵"
		  sx = self:取属性(等级,nil,"物理")
		  local 技能组=取随机物攻(2)
		  if mx~="天兵" then
				mc="守护星"
				sx = self:取属性(等级,nil,"法系")
				技能组=取大法(2)
		  end
		  战斗单位[i]={
				名称=mc
				,模型=mx
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1]/2)
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1]*0.9)
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1]*0.9)
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1]*0.85)
				,主动技能=技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:夺旗守卫(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 数量=取队伍人数(玩家id)+取随机数(1,3)
	 local 模型=任务数据[任务id].模型
	 local sx
	 for i=1,数量 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="帮派精英守卫"
				,模型=模型
				,变异=true
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"物理")
	 战斗单位[数量+1]={
		  名称="帮派精英守卫"
		  ,模型=模型
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[数量+1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[数量+1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[数量+1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[数量+1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[数量+1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[数量+1])
		  ,技能={"高级反震"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end

function 怪物属性:帮战夺旗棋子(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local xiaodi={"凤凰","巡游天神","古代瑞兽","炎魔神","净瓶女娲","幽灵","灵鹤","风伯","大力金刚","夜罗刹","地狱战神","律法女娲"}
	 xiaodi=xiaodi[取随机数(1,#xiaodi)]
	 local sx
	 for i=1,5 do
		  local 人物=Qu随机角色[取随机数(1,#Qu随机角色)]
		  local 门派=Qu角色属性[人物].门派[取随机数(1,#Qu角色属性[人物].门派)]
		  sx = self:取属性(等级,门派)
		  local 武器属性=取150角色武器(人物)
		  战斗单位[i]={
				名称="帮派精英护法"
				,模型=人物
				,角色=true
				,武器={名称=武器属性.武器,级别限制=武器属性.级别,子类=武器属性.子类}
				,染色方案=Qu角色属性[人物].染色方案
				,染色组={[1]=取随机数(1,6),[2]=取随机数(1,6),[3]=取随机数(1,6)}
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 for i=6,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="帮派精英守卫"
				,模型=xiaodi
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:伐木工(任务id,玩家id,序号)
	 local 模型 ={"赌徒","强盗","山贼"}
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,nil,"物理") --类型：固伤 辅助 物理 法系
	 local 数量=取随机数(7,9)
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  -- ,技能={"高级吸血","高级连击"}
		  -- ,主动技能={}
	 }
	 for i=2,数量 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="村民"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:伐木兔子(任务id,玩家id,序号)
	 local 模型 ={"赌徒","强盗","山贼"}
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx
	 local 数量=取随机数(5,7)
	 for i=1,数量 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="鬼鬼祟祟的兔子"
				,模型="兔子怪"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:封妖(任务id,玩家id,序号)
	 local mc=任务数据[任务id].名称
	 local mx=任务数据[任务id].模型
	 local 变异=任务数据[任务id].变异
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级) --类型：固伤 辅助 物理 法系
	 local mp,法小弟,攻小弟
	 if 变异 then
		  if mx=="修罗傀儡鬼" then
				法小弟="灵符女娲"
				攻小弟="律法女娲"
				sx = self:取属性(等级,"凌波城")
		  elseif mx=="混沌兽" then
				法小弟="炎魔神"
				攻小弟="大力金刚"
				sx = self:取属性(等级,"龙宫")
		  else
				法小弟="灵鹤"
				攻小弟="幽灵"
				sx = self:取属性(等级,"狮驼岭")
		  end
		  战斗单位[1]={
				名称=mc
				,模型=mx
				,等级=等级
				,变异=true
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1]+等级*60)
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1]+等级*3)
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1]+等级*1.5)
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
				,技能={"感知"}
				,修炼 = {物抗=2,法抗=2,攻修=5}
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
		  for i=2,3 do
				mp={"化生寺","普陀山"}
				sx = self:取属性(等级,mp[取随机数(1,2)],"辅助")
				战斗单位[i]={
					 名称="连体"
					 ,模型="曼珠沙华"
					 ,等级=等级
					 ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i]+等级*150)
					 ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
					 ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
					 ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
					 ,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
					 ,技能={"感知"}
					 -- ,共生=true
					 ,门派=sx.门派
					 ,AI战斗 = {AI=sx.智能}
				}
		  end
		  for i=4,5 do
				mp={"龙宫","神木林","魔王寨","天宫"}
				sx = self:取属性(等级,mp[取随机数(1,#mp)],"法系")
				战斗单位[i]={
					 名称="灵法"
					 ,模型=法小弟
					 ,等级=等级
					 ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
					 ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
					 ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
					 ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
					 ,技能={"感知"}
					 ,门派=sx.门派
					 ,AI战斗 = {AI=sx.智能}
				}
		  end
		  for i=6,7 do
				mp={"凌波城","狮驼岭","大唐官府","天宫"}
				sx = self:取属性(等级,mp[取随机数(1,#mp)],"物理")
				战斗单位[i]={
					 名称="战将"
					 ,模型=攻小弟
					 ,等级=等级
					 ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
					 ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
					 ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
					 ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
					 ,技能={"感知"}
					 ,门派=sx.门派
					 ,AI战斗 = {AI=sx.智能}
				}
		  end
		  local 封怪={"千年蛇魅","猫灵人形","红萼仙子"}
		  sx = self:取属性(等级,nil,"封系")
		  战斗单位[8]={
				名称="控师"
				,模型=封怪[取随机数(1,#封怪)]
				,等级=等级
				,变异=true
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
				,额外目标数=1
				,主动技能=取随机封印(1)
		  }
	 else
		  -------------------非变异
		  法小弟={"灵符女娲","蝴蝶仙子","葫芦宝贝","猫灵兽形","机关鸟","凤凰","混沌兽","雷鸟人","黑山老妖","牛妖","地狱战神","机关鸟","净瓶女娲","芙蓉仙子"}
		  mp={"龙宫","神木林","魔王寨","凌波城","狮驼岭","大唐官府"}
		  sx = self:取属性(等级,mp[取随机数(1,#mp)])
		  战斗单位[1]={
				名称=mc
				,模型=mx
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
				,技能={"感知"}
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
		  mx=法小弟[取随机数(1,#法小弟)]
		  for i=2,3 do
				mp={"龙宫","神木林","魔王寨","天宫"}
				sx = self:取属性(等级,mp[取随机数(1,#mp)],"法系")
				战斗单位[i]={
					 名称=mx.."喽啰"
					 ,模型=mx
					 ,等级=等级
					 ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
					 ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
					 ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
					 ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
					 -- ,技能={"感知"}
					 ,门派=sx.门派
					 ,AI战斗 = {AI=sx.智能}
				}
		  end
		  mx=法小弟[取随机数(1,#法小弟)]
		  for i=4,5 do
				mp={"凌波城","狮驼岭","大唐官府","天宫"}
				sx = self:取属性(等级,mp[取随机数(1,#mp)],"物理")
				战斗单位[i]={
					 名称=mx.."喽啰"
					 ,模型=mx
					 ,等级=等级
					 ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
					 ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
					 ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
					 ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
					 ,门派=sx.门派
					 ,AI战斗 = {AI=sx.智能}
				}
		  end
		  for i=6,8 do
				sx = self:取属性(等级)
				mx=法小弟[取随机数(1,#法小弟)]
				战斗单位[i]={
					 名称=mx.."喽啰"
					 ,模型=mx
					 ,等级=等级
					 ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
					 ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
					 ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
					 ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
					 ,主动技能=sx.技能组
				}
		  end
	 end
	 return 战斗单位
end

function 怪物属性:挖宝妖王(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local mc=任务数据[任务id].名称
	 local mx=任务数据[任务id].模型
	 local sx
	 local 小弟
	 if mx=="炎魔神" then
		  sx = self:取属性(等级,"魔王寨")
		  战斗单位[1]={
				名称=mc
				,模型=mx
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
				,技能={"感知"}
				,修炼 = {物抗=2,法抗=2,攻修=0}
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
		  小弟={"黑山老妖","巡游天神","地狱战神"}
		  for i=2,7 do
				sx = self:取属性(等级)
				战斗单位[i]={
					 名称="上古魔灵"
					 ,模型=小弟[取随机数(1,#小弟)]
					 ,等级=等级
					 ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
					 ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
					 ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
					 ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
					 ,技能={"感知"}
					 ,主动技能=sx.技能组
				}
		  end
		  战斗单位[8]={
				名称="狐"
				,模型="狐狸精"
				,等级=等级
				,变异=true
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
				-- ,技能={"感知"}
				,额外目标数=1
				,主动技能=取随机封印(1)
		  }
	 elseif mx=="鬼将" then
		  sx = self:取属性(等级,"凌波城")
		  战斗单位[1]={
				名称=mc
				,模型=mx
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
				,技能={"感知","高级必杀"}
				,修炼 = {物抗=2,法抗=2,攻修=2}
				,主动技能={}
		  }
		  小弟={"幽灵","吸血鬼"}
		  for i=2,7 do
				sx = self:取属性(等级)
				战斗单位[i]={
					 名称="幽冥鬼卒"
					 ,模型=小弟[取随机数(1,#小弟)]
					 ,等级=等级
					 ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
					 ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
					 ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
					 ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
					 ,技能={"感知"}
					 ,主动技能=sx.技能组
				}
		  end
		  战斗单位[8]={
				名称="狸"
				,模型="花妖"
				,等级=等级
				,变异=true
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
				-- ,技能={"感知"}
				,主动技能=取随机封印(1)
		  }
	 else
		  sx = self:取属性(等级,"神木林")
		  战斗单位[1]={
				名称=mc
				,模型=mx
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
				,技能={"感知"}
				,修炼 = {物抗=2,法抗=2,攻修=0}
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
		  小弟={"灵符女娲","灵符女娲","噬天虎"}
		  for i=2,7 do
				sx = self:取属性(等级)
				战斗单位[i]={
					 名称="九天妖兵"
					 ,模型=小弟[取随机数(1,#小弟)]
					 ,等级=等级
					 ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
					 ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
					 ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
					 ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
					 ,技能={"感知"}
					 ,主动技能=sx.技能组
				}
		  end
		  战斗单位[8]={
				名称="狐"
				,模型="狐狸精"
				,等级=等级
				,变异=true
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
				-- ,技能={"感知"}
				,主动技能=取随机封印(1)
		  }
	 end
	 return 战斗单位
end

function 怪物属性:执法天兵(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,nil,"物理") --类型：固伤 辅助 物理 法系
	 for n=1,5 do
		  战斗单位[n]={
		  名称="执法天兵"
		  ,模型="进阶天兵"
		  ,等级=等级
		  ,伤害 = 20*等级+1100
		  ,防御 = 0
		  ,速度 = 7*等级+50
		  ,法防 = 0
		  ,气血 =450*等级+10000
		  -- ,法宝技能={}
		  ,技能={"高级感知","高级精神集中"}
		  ,主动技能={"横扫千军","后发制人"}--取随机功法组合(5)
	 }
	 end
	 return 战斗单位
end
function 怪物属性:巧智魔1(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级) --类型：固伤 辅助 物理 法系
	 战斗单位[1]={
		  名称="巧智魔"
		  ,模型="蜃气妖"
		  ,开场发言="你再抓，我再跑，你再抓，我再跑呀……嘻嘻。"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称=" 巧智魔 "
		  ,模型="蜃气妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }

	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称=" 巧智魔 "
		  ,模型="蜃气妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end

function 怪物属性:巧智魔召唤(等级)
	 等级=等级-5
	 if 等级<20 then 等级=20 end
	 local sx = self:取属性(等级) --类型：固伤 辅助 物理 法系
	 local 召唤单位={
		  名称=" 巧智魔 "
		  ,模型="蜃气妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * 0.8)
		  ,伤害 = qz(sx.属性.伤害 * 0.6)
		  ,法伤 = qz(sx.属性.法伤 * 0.6)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *0.6)
		  ,主动技能=sx.技能组
	 }
	 return 召唤单位
end


function 怪物属性:巧智魔2(任务id,玩家id,序号)
	 local 模型 ={"僵尸","地狱战神","野鬼","黑山老妖","芙蓉仙子","骷髅怪","吸血鬼"}
	 local 变异 =false
	 if 取随机数(1,10)<=5 then
		 变异=true
	 end
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"狮驼岭")
	 战斗单位[1]={
		  名称="巧智魔"
		  ,模型="蜃气妖"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=6,法抗=0,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}

	 }

	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="鬼怪"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="鬼怪"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称=" 鬼怪 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,变异=变异
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }

  return 战斗单位
end

function 怪物属性:梦魇魔(任务id,玩家id,序号)
	 local 模型 ={"僵尸","地狱战神","野鬼","黑山老妖","芙蓉仙子","骷髅怪","吸血鬼"}
	 local 变异 =false
	 if 取随机数(1,10)<=5 then
		 变异=true
	 end
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"魔王寨")
	 战斗单位[1]={
		  名称="梦魇魔"
		  ,模型="炎魔神"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
		  ,修炼 = {物抗=0,法抗=5,攻修=0}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,主动技能={"日月乾坤"}
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="鬼怪"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="鬼怪"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称=" 鬼怪 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,变异 = 变异
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8]*0.5)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,修炼 = {物抗=9,法抗=9,攻修=0}
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end
function 怪物属性:招魂帖梦魇魔(任务id,玩家id,序号)
	 local 模型 ={"僵尸","地狱战神","野鬼","黑山老妖","芙蓉仙子","骷髅怪","吸血鬼"}
	 local 变异 =false
	 if 取随机数(1,10)<=5 then
		 变异=true
	 end
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 门派 = "魔王寨"
	 local sx = self:取属性(等级,"魔王寨")
	 战斗单位[1]={
		  名称="梦魇魔"
		  ,模型="炎魔神"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
		  ,修炼 = {物抗=0,法抗=5,攻修=0}
	 }

	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[5]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,主动技能={"日月乾坤"}
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="鬼怪"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="鬼怪"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称=" 鬼怪 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,变异 = 变异
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,修炼 = {物抗=9,法抗=9,攻修=0}
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end

function 怪物属性:怯弱妖(任务id,玩家id,序号)
	 local 模型 ={"僵尸","地狱战神","野鬼","黑山老妖","芙蓉仙子","骷髅怪","吸血鬼"}
	 local 变异 =false
	 if 取随机数(1,10)<=5 then
		 变异=true
	 end
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,nil,"物理") --类型：固伤 辅助 物理 法系
	 战斗单位[1]={
		  名称="怯弱妖"
		  ,模型="雾中仙"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  -- ,技能={"高级吸血","高级连击"}
		  -- ,主动技能={}
	 }
	 sx = self:取属性(等级,nil,"物理")
	 战斗单位[2]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,变异 = 变异
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,主动技能={"横扫千军"}
	 }
	 sx = self:取属性(等级,nil,"物理")
	 战斗单位[3]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,变异 = 变异
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,技能={"感知"}
		  ,主动技能={"横扫千军"}
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级,nil,"物理")
	 战斗单位[5]={
		  名称="影子鬼"
		  ,模型="地狱战神"
		  ,等级=等级
		  ,变异 = 变异
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"高级吸血","高级连击"}
		  ,主动技能={}
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="鬼怪"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,变异 = 变异
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="鬼怪"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,变异 = 变异
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="鬼怪"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,变异 = 变异
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }

	 return 战斗单位
end

function 怪物属性:迷幻妖(任务id,玩家id,序号)
	 local 模型 ={"僵尸","地狱战神","野鬼","黑山老妖","芙蓉仙子","骷髅怪","吸血鬼"}
	 local 变异 =false
	 if 取随机数(1,10)<=5 then
		 变异=true
	 end
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,nil,"物理") --类型：固伤 辅助 物理 法系
	 战斗单位[1]={
		  名称="迷幻妖"
		  ,模型="曼珠沙华"
		  ,开场发言="居然看破了幻灭，就面对现实吧。"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  -- ,技能={"高级吸血","高级连击"}
		  ,主动技能={"百爪狂杀"}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,变异 = 变异
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,变异 = 变异
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="鬼怪"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,变异 = 变异
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="鬼怪"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,变异 = 变异
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="鬼怪"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,变异 = 变异
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end

function 怪物属性:冥想幽鬼(任务id,玩家id,序号)
	 local 模型 ={"僵尸","地狱战神","野鬼","黑山老妖","芙蓉仙子","骷髅怪","吸血鬼"}
	 local 变异 =false
	 if 取随机数(1,10)<=5 then
		 变异=true
	 end
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+5
	 local 门派 = "狮驼岭"
	 local sx = self:取属性(等级,"龙宫")
	 战斗单位[1]={
		  名称="冥想幽鬼"
		  ,模型="雾中仙"
		  ,开场发言="给你们的机会没有珍惜，那就只有打一场了。#14"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=6,法抗=0,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称=" 妖魔 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="鬼怪"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="鬼怪"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="鬼怪"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }

  return 战斗单位
end

function 怪物属性:勾魂幽灵(任务id,玩家id,序号)
	 local 模型 ={"僵尸","地狱战神","野鬼","黑山老妖","芙蓉仙子","骷髅怪","吸血鬼"}
	 local 变异 =false
	 if 取随机数(1,10)<=5 then
		 变异=true
	 end
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+5
	 local 门派 = "凌波城"
	 local sx = self:取属性(等级,"龙宫")
	 战斗单位[1]={
		  名称="勾魂幽灵"
		  ,模型="进阶夜罗刹"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  -- ,技能={"高级吸血","高级连击"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}

	 }
	 for i=2,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称=" 妖魔 "
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="鬼怪"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="捣蛋鬼"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="鬼怪"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end

function 怪物属性:机械游魂(任务id,玩家id,序号)
	 local 模型 ={"僵尸","地狱战神","野鬼","黑山老妖","芙蓉仙子","骷髅怪","吸血鬼"}
	 local 变异 =false
	 if 取随机数(1,10)<=5 then
		 变异=true
	 end
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+5
	 local sx = self:取属性(等级,nil,"物理")
	 战斗单位[1]={
		  名称="机械游魂"
		  ,模型="机关兽"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  -- ,技能={"高级吸血","高级连击"}
		  ,主动技能={"破血狂攻"}
	 }
	 for i=2,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称=" 妖魔 "
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=6,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="鬼怪"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,变异=变异
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])*1.2
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:夜叉(任务id,玩家id,序号)
	 local 模型 ={"僵尸","地狱战神","野鬼","黑山老妖","芙蓉仙子","骷髅怪","吸血鬼"}
	 local 变异 =false
	 if 取随机数(1,10)<=5 then
		 变异=true
	 end
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"凌波城")
	 战斗单位[1]={
		  名称="夜叉"
		  ,模型="幽灵"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  -- ,技能={"高级吸血","高级连击"}
		  -- ,主动技能={"破血狂攻"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}

	 }
	 for i=2,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称=" 妖魔 "
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=6,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="鬼怪"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,变异=变异
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:千年魔灵(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"龙宫")
	 战斗单位[1]={
		  名称="千年魔灵"
		  ,模型="帮派妖兽"
		  ,等级=等级
		  ,防御 = qz(等级*10)+500
		  ,法防 = qz(等级*6)+400
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"夜战"}
		  -- ,主动技能={"破血狂攻"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,5 do
		  sx = self:取属性(等级,nil,"物理")
		  战斗单位[i]={
				名称="魔灵护法"
				,模型="大力金刚"
				,等级=等级
				,防御 = qz(等级*4)
				,法防 = qz(等级*2)
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])*1.2
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"偷袭"}
				,主动技能={"百爪狂杀"}
		  }
	 end
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="无魂"
		  ,模型="僵尸"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])*1.2
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])*1.2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={"反震"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="小妖"
		  ,模型="骷髅怪"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])*1.2
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])*1.2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,技能={"反震"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="小妖"
		  ,模型="骷髅怪"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])*1.2
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])*1.2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,技能={"反震"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[9]={
		  名称="小妖"
		  ,模型="野鬼"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])*1.2
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])*1.2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[10]={
		  名称="小妖"
		  ,模型="野鬼"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])*1.2
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])*1.2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end

function 怪物属性:万年魔灵(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 门派 = "狮驼岭"
	 local sx = self:取属性(等级,"狮驼岭")
	 战斗单位[1]={
		  名称="万年魔灵"
		  ,模型="九头精怪"
		  ,等级=等级
		  ,防御 = qz(等级*12)+500
		  ,法防 = qz(等级*7)+500
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])*2
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"高级吸血","高级必杀"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,4 do
		  战斗单位[i]={
				名称="魔灵护法"
				,模型="大力金刚"
				,等级=等级
				,防御 = qz(等级*8)+500
				,法防 = qz(等级*5)+500
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])*1.2
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])*1.2
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"高级反震"}
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="魔灵"
		  ,模型="大力金刚"
		  ,等级=等级
		  ,防御 = qz(等级*3)+1000
		  ,法防 = qz(等级*2)+800
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])*1.2
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])*1.2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={}
		  ,主动技能=sx.技能组
	 }

	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[6]={
		  名称="不死魔灵"
		  ,模型="芙蓉仙子"
		  ,等级=等级
		  ,防御 = qz(等级*5)+600
		  ,法防 = qz(等级*5)+300
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])*2
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={}
		  ,门派="方寸山"
		  ,AI战斗 = {AI="封系"}
	 }

	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="小妖"
		  ,模型="芙蓉仙子"
		  ,等级=等级
		  ,防御 = qz(等级*5)+600
		  ,法防 = qz(等级*5)+300
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])*1.2
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])*1.2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,技能={"高级感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="小妖"
		  ,模型="黑山老妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])*1.2
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])*1.2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[9]={
		  名称="小妖"
		  ,模型="黑山老妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])*1.2
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])*1.2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[10]={
		  名称="小妖"
		  ,模型="黑山老妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])*1.2
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])*1.2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end

function 怪物属性:地煞星(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+10
	 local 任务属性 = 任务数据[任务id]
	 local 铁血无双 = {"律法女娲","幽灵","夜罗刹","大力金刚"} --2-3
	 local 玄法无边 = {"灵符女娲","炎魔神","灵鹤","混沌兽"} --4-5 6 也有可能
	 local 神封无量 = {"雾中仙","风伯","鼠先锋","兔子怪"}
	 local 长生无界 = {"古代瑞兽","雨师","龟丞相"}
	 local 地煞物理 = {"大唐官府","狮驼岭","凌波城"}
	 local 地煞法系 = {"神木林","魔王寨","龙宫"}
	 local 地煞封系 = {"方寸山","女儿村","盘丝洞"}
	 local 门派 = 任务属性.门派
	 local nandu = 任务属性.难度
	 local 难度系数=HDPZ["地煞：星级"..nandu].难度
	 local sx = self:取属性(等级,门派)
	 local 主怪是否为输出 = false
	 if sx.智能=="物理" or sx.智能=="法系" or sx.智能=="固伤" then
		  主怪是否为输出 = true
	 end
	 local xiulian = qz((等级-10)/8)
	 local fashangjianshao=1
	 local 气血=50000
	 if nandu==1 then
		  气血=20000+等级*120
		  xiulian=xiulian-4
	 elseif nandu==2 then
		  气血=30000+等级*140
		  xiulian=xiulian-3
	 elseif nandu==3 then
		  气血=40000+等级*160
		  xiulian=xiulian-2
		  fashangjianshao=0.95
	 elseif nandu==4 then
		  气血=50000+等级*180
		  xiulian=xiulian-1
		  fashangjianshao=0.95
	 end

	 战斗单位[1]={
		  名称=任务属性.战斗名称
		  ,模型=任务属性.模型
		  ,角色=true
		  ,炫彩 = 任务属性.炫彩
		  ,炫彩组 = 任务属性.炫彩组
		  ,等级=等级
		  ,武器 = 取武器数据(任务属性.武器,任务属性.武器等级)
		  ,气血 = qz(气血*难度系数+50000)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1]*难度系数)*1.1
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1]*难度系数)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1]*难度系数)
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,修炼 = {物抗=xiulian,法抗=xiulian-3,攻修=xiulian}
		  ,物伤减少=0.92
		  ,法伤减少=0.92
		  ,不可封印=true
		  ,技能={"高级偷袭","高级魔之心","高级感知"}
		  ,抵抗封印等级=QAQ[序号].抗封等级[1]*5
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,3 do
		  门派 = 地煞物理[sj(1,#地煞物理)]
		  sx = self:取属性(等级,门派,"物理")
		  战斗单位[i]={
				名称="铁血无双"
				,模型=铁血无双[sj(1,#铁血无双)]
				,等级=等级
				,气血 = qz(气血*难度系数)
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i]*难度系数)*1.2
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i]*难度系数)
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,修炼 = {物抗=xiulian-5,法抗=0,攻修=xiulian}
				 ,物伤减少=0.95
				 ,法伤减少=0.95
				,技能={"高级偷袭","高级必杀"}
				,抵抗封印等级=QAQ[序号].抗封等级[i]
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 for i=4,5 do
		  门派 = 地煞法系[sj(1,#地煞法系)]
		  sx = self:取属性(等级,门派,"法系")
		  战斗单位[i]={
				名称="玄法无边"
				,模型=玄法无边[sj(1,#玄法无边)]
				,等级=等级
				,气血 = qz(气血*难度系数)
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i]*难度系数)
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i]*难度系数)*1.2
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,修炼 = {物抗=xiulian-5,法抗=0,攻修=xiulian}
				,技能={"高级魔之心"}
				,抵抗封印等级=QAQ[序号].抗封等级[i]
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 if 主怪是否为输出 then
		  门派 = 地煞法系[sj(1,#地煞法系)]
		  sx = self:取属性(等级,门派,"法系")
		  战斗单位[6]={
				名称="玄法无边"
				,模型=玄法无边[sj(1,#玄法无边)]
				,等级=等级
				,气血 = qz(气血*难度系数)
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6]*难度系数)
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6]*难度系数)*1.2
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
				,修炼 = {物抗=xiulian-5,法抗=0,攻修=xiulian}
				,技能={"高级法术连击","高级法术暴击"}
				,抵抗封印等级=QAQ[序号].抗封等级[6]
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 else
		  门派 = 地煞封系[sj(1,#地煞封系)]
		  sx = self:取属性(等级,门派,"封系")
		  战斗单位[6]={
				名称="神封无量"
				,模型=神封无量[sj(1,#神封无量)]
				,等级=等级
				,气血 = qz(气血*难度系数)
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6]*难度系数)
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
				,法伤减少=fashangjianshao
				,抵抗封印等级=QAQ[序号].抗封等级[6]
				,修炼 = {物抗=xiulian,法抗=0,攻修=xiulian}
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 for i=7,8 do
		  门派 = 地煞封系[sj(1,#地煞封系)]
		  sx = self:取属性(等级,门派,"封系")
		  战斗单位[i]={
				名称="神封无量"
				,模型=神封无量[sj(1,#神封无量)]
				,等级=等级
				,气血 = qz(气血*难度系数)
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i]*难度系数)
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,修炼 = {物抗=xiulian,法抗=0,攻修=xiulian}
				,法伤减少=fashangjianshao
				,技能={"高级幸运","高级感知"}
				,门派=sx.门派
				,封印命中等级=QAQ[序号].封印等级[i]
				,抵抗封印等级=QAQ[序号].抗封等级[i]
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 门派 = "化生寺"
	 sx = self:取属性(等级,门派,"辅助")
	 战斗单位[9]={
		  名称="长生无界"
		  ,模型=长生无界[sj(1,#长生无界)]
		  ,等级=等级
		  ,气血 = qz(气血*难度系数)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9]*难度系数)*2
		  ,修炼 = {物抗=xiulian,法抗=xiulian,攻修=xiulian}
		  ,法伤减少=fashangjianshao
		  ,技能={"高级防御","高级感知"}
		  ,抵抗封印等级=QAQ[序号].抗封等级[9]*1.2
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 门派 = "五庄观"
	 sx = self:取属性(等级,门派,"辅助")
	 战斗单位[10]={
		  名称="乾坤无行"
		  ,模型="吸血鬼"
		  ,等级=等级
		  ,气血 = qz(气血*难度系数)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10]*难度系数)
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10]*难度系数)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,修炼 = {物抗=xiulian,法抗=xiulian,攻修=xiulian}
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])*3
		  ,技能={"高级幸运"}
		  ,封印命中等级=QAQ[序号].封印等级[10]*1.2
		  ,抵抗封印等级=QAQ[序号].抗封等级[10]*1.2
		  ,主动技能={"日月乾坤","生命之泉"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 return 战斗单位
end

function 怪物属性:六星地煞(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 任务属性 = 任务数据[任务id]
	 local 铁血无双 = {"律法女娲","幽灵","夜罗刹","大力金刚"} --2-3
	 local 玄法无边 = {"灵符女娲","炎魔神","灵鹤","混沌兽"} --4-5 6 也有可能
	 local 神封无量 = {"雾中仙","风伯","鼠先锋","兔子怪"}
	 local 长生无界 = {"古代瑞兽","雨师","龟丞相"}
	 local 地煞物理 = {"大唐官府","狮驼岭","凌波城"}
	 local 地煞法系 = {"神木林","魔王寨","龙宫"}
	 local 地煞封系 = {"方寸山","女儿村","盘丝洞"}
	 local 门派 = 任务属性.门派
	 local nandu = 任务属性.难度
	 local 难度系数=HDPZ["地煞：星级"..nandu].难度
	 local sx = self:取属性(等级,门派)
	 local 主怪是否为输出 = false
	 if sx.智能=="物理" or sx.智能=="法系" or sx.智能=="固伤" then
		  主怪是否为输出 = true
	 end
	 local xiulian = qz((等级-10)/5)
	 local 气血=50000
	 if nandu==6 then
		  xiulian=xiulian+2
		  气血=气血+15000+等级*250
	 else
		  气血=气血+15000+等级*200
	 end

	 战斗单位[1]={
		  名称=任务属性.战斗名称
		  ,模型=任务属性.模型
		  ,角色=true
		  ,锦衣={{名称=任务属性.锦衣}}
		  ,法宝={[1]={名称="金甲仙衣",境界=9}}
		  ,等级=等级
		  ,武器 = 取武器数据(任务属性.武器,任务属性.武器等级)
		  ,气血 = qz(气血*难度系数)*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1]*难度系数)*1.2
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1]*难度系数)*1.2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1]*难度系数)
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,防御 = qz(等级*10)+600
		  ,法防 = qz(等级*15)
		  ,招式特效=取招式特效(门派)
		  ,修炼 = {物抗=xiulian,法抗=xiulian,攻修=xiulian}
		  ,不可封印=true
		  ,技能={"高级魔之心","高级感知"}
		  ,封印命中等级=QAQ[序号].封印等级[1]
		  ,抵抗封印等级=QAQ[序号].抗封等级[1]
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,3 do
		  门派 = 地煞物理[sj(1,#地煞物理)]
		  sx = self:取属性(等级,门派,"物理")
		  战斗单位[i]={
				名称="铁血无双"
				,模型=铁血无双[sj(1,#铁血无双)]
				,角色=true
				,等级=等级
				,气血 = qz(气血)
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i]*难度系数)*1.2
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i]*难度系数)
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,防御 = qz(等级*10)+500
				,法防 = qz(等级*15)
				,招式特效=取招式特效(门派)
				,修炼 = {物抗=xiulian-5,法抗=xiulian-6,攻修=xiulian}
				,技能={"高级偷袭","高级感知"}
				,抵抗封印等级=QAQ[序号].抗封等级[i]
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 for i=4,5 do
		  门派 = 地煞法系[sj(1,#地煞法系)]
		  sx = self:取属性(等级,门派,"法系")
		  战斗单位[i]={
				名称="玄法无边"
				,模型=玄法无边[sj(1,#玄法无边)]
				,角色=true
				,等级=等级
				,气血 = qz(气血)
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i]*难度系数)
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i]*难度系数)*1.2
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,防御 = qz(等级*15)+400
				,法防 = qz(等级*12)
				,招式特效=取招式特效(门派)
				,修炼 = {物抗=xiulian-5,法抗=xiulian-6,攻修=xiulian}
				,技能={"高级魔之心","高级感知"}
				,抵抗封印等级=QAQ[序号].抗封等级[i]
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 if 主怪是否为输出 then
		  门派 = 地煞法系[sj(1,#地煞法系)]
		  sx = self:取属性(等级,门派,"法系")
		  战斗单位[6]={
				名称="玄法无边"
				,模型=玄法无边[sj(1,#玄法无边)]
				,角色=true
				,等级=等级
				,气血 = qz(气血)
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6]*难度系数)
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6]*难度系数)*1.2
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
				,防御 = qz(等级*12)+400
				,法防 = qz(等级*5)+800
				,招式特效=取招式特效(门派)
				,修炼 = {物抗=xiulian-5,法抗=xiulian-6,攻修=xiulian}
				,技能={"高级魔之心","高级感知"}
				,抵抗封印等级=QAQ[序号].抗封等级[6]
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 else
		  门派 = 地煞封系[sj(1,#地煞封系)]
		  sx = self:取属性(等级,门派,"封系")
		  战斗单位[6]={
				名称="神封无量"
				,模型=神封无量[sj(1,#神封无量)]
				,角色=true
				,等级=等级
				,气血 = qz(气血*难度系数)
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6]*难度系数)*1.2
				,防御 = qz(等级*12)+500
				,法防 = qz(等级*5)+800
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
				,抵抗封印等级=QAQ[序号].抗封等级[6]*1.2
				,修炼 = {物抗=xiulian,法抗=xiulian-5,攻修=xiulian}
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 for i=7,8 do
		  门派 = 地煞封系[sj(1,#地煞封系)]
		  sx = self:取属性(等级,门派,"封系")
		  战斗单位[i]={
				名称="神封无量"
				,模型=神封无量[sj(1,#神封无量)]
				,角色=true
				,等级=等级
				,气血 = qz(气血)*难度系数
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i]*难度系数)*1.2
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,防御 = qz(等级*12)+800
				,法防 = qz(等级*5)+1000
				,修炼 = {物抗=xiulian,法抗=xiulian-5,攻修=xiulian}
				,技能={"高级幸运","高级感知"}
				,门派=sx.门派
				,封印命中等级=QAQ[序号].封印等级[i]*1.2
				,抵抗封印等级=QAQ[序号].抗封等级[i]*1.2
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 门派 = "化生寺"
	 sx = self:取属性(等级,门派,"辅助")
	 战斗单位[9]={
		  名称="长生无界"
		  ,模型=长生无界[sj(1,#长生无界)]
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(气血*难度系数)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9]*难度系数)*3
		  ,防御 = qz(等级*15)+1500
		  ,法防 = qz(等级*5)+1000
		  ,招式特效=取招式特效(门派)
		  ,修炼 = {物抗=xiulian,法抗=xiulian-5,攻修=xiulian}
		  ,技能={"高级防御","高级感知"}
		  ,抵抗封印等级=QAQ[序号].抗封等级[9]*1.2
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 门派 = "五庄观"
	 sx = self:取属性(等级,门派,"辅助")
	 战斗单位[10]={
		  名称="乾坤无行"
		  ,模型="吸血鬼"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(气血*难度系数)*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10]*难度系数)
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10]*难度系数)*3
		  ,修炼 = {物抗=xiulian,法抗=xiulian-5,攻修=xiulian}
		  ,技能={"高级幸运","高级感知"}
		  ,封印命中等级=QAQ[序号].封印等级[10]*1.5
		  ,抵抗封印等级=QAQ[序号].抗封等级[10]*1.5
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 if 难度==6 then
		  战斗单位[11]={
				名称="泽被星魂"
				,模型="蜃气妖"
				,等级=等级
				,不可操作=true
				,气血 = 99999
				,伤害 = 1
				,法伤 = 1
				,速度 = 1
		  }
	 end
	 return 战斗单位
end
--------天罡1-5
function 怪物属性:天罡星1到5星(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+6
	 local 任务属性 = 任务数据[任务id]
	 local 狂攻 = {"进阶魔化毗舍童子","进阶毗舍童子"}
	 local 诡法 = {"进阶混沌兽","进阶灵符女娲"}
	 local 神封 = {"猫灵人形","雾中仙"}
	 local 长生 = {"吸血鬼","金身罗汉"}
	 local 天罡物理 = {"大唐官府","狮驼岭","凌波城"}
	 local 天罡法系 = {"神木林","魔王寨","龙宫"}
	 local 天罡封系 = {"方寸山","女儿村","盘丝洞"}
	 local 门派 = 任务属性.门派
	 local 难度 = 任务属性.难度
	 local sx = self:取属性(等级,门派)
	 local 主怪是否为输出 = false
	 if sx.智能=="物理" or sx.智能=="法系" or sx.智能=="固伤" then
		  主怪是否为输出 = true
	 end
	 local xiulian = qz(等级/8)
	 local 气血=80000
	 if 难度==1 then
		  xiulian=xiulian
		  气血=气血+20000+等级*300
		  牛逼=1
		  牛逼A=1
		  牛逼B=1
		  牛逼C=1
		  名称1="狂攻"
		  名称2="诡法"
		  名称3="神封"
		  名称4="长生"
		  名称5="铁手"
	 elseif 难度==2 then
		  xiulian=xiulian
		  气血=气血+30000+等级*350
		  牛逼=1
		  牛逼A=1
		  牛逼B=1
		  牛逼C=1
		  名称1="诡异狂攻"
		  名称2="诡异诡法"
		  名称3="诡异神封"
		  名称4="诡异长生"
		  名称5="诡异铁手"
	 elseif 难度==3 then
		  xiulian=xiulian+1
		  气血=气血+40000+等级*400
		  牛逼=1
		  牛逼A=1
		  牛逼B=1.5
		  牛逼C=1
		  名称1="绝命狂攻"
		  名称2="绝命诡法"
		  名称3="绝命神封"
		  名称4="绝命长生"
		  名称5="绝命铁手"
	 elseif 难度==4 then
		  xiulian=xiulian+2
		  气血=气血+50000+等级*450
		  牛逼=1
		  牛逼A=2
		  牛逼B=1
		  牛逼C=1
		  名称1="狂攻"
		  名称2="诡法"
		  名称3="神封"
		  名称4="长生"
		  名称5="铁手"
	 elseif 难度==5 then
		  xiulian=xiulian+3
		  气血=气血+60000+等级*500
		  牛逼=1000   --气血
		  牛逼A=2      --法伤
		  牛逼B=2      --伤害
		  牛逼C=10
		  名称1="狂攻"
		  名称2="诡法"
		  名称3="神封"
		  名称4="长生"
		  名称5="铁手"
	 end

	 战斗单位[1]={
		  名称=任务属性.战斗名称
		  ,模型=任务属性.模型
		  ,角色=true
		  ,锦衣={{名称=任务属性.锦衣}}
		  ,法宝={[1]={名称="金甲仙衣",境界=9}}
		  ,等级=等级
		  ,武器 = 取武器数据(任务属性.武器,任务属性.武器等级)
		  ,气血 = qz(气血)*牛逼*1.5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])*1.3*牛逼B
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])*1.3*牛逼A
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])*牛逼C
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])*5
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])*5
		  ,防御 = qz(等级*10)+1500
		  ,法防 = qz(等级*5)+1000
		  ,招式特效=取招式特效(门派)
		  ,修炼 = {物抗=xiulian,法抗=xiulian,攻修=xiulian}
		  ,技能={"高级偷袭","高级魔之心","高级神迹"}
		  ,封印命中等级=QAQ[序号].封印等级[1]
		  ,抵抗封印等级=QAQ[序号].抗封等级[1]
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 if 战斗单位[1]["锦衣"] == nil or 战斗单位[1]["锦衣"] == "" then
		  战斗单位[1].角色 = false
	 end
	 for i=2,3 do
		  门派 = 天罡物理[sj(1,#天罡物理)]
		  sx = self:取属性(等级,门派,"物理")
		  战斗单位[i]={
				名称=名称1
				,模型=狂攻[sj(1,#狂攻)]
				,角色=true
				,等级=等级
				,气血 = qz(气血)
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])*1.2
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,防御 = qz(等级*10)+800
				,法防 = qz(等级*5)+800
				,招式特效=取招式特效(门派)
				,修炼 = {物抗=xiulian,法抗=xiulian,攻修=xiulian}
				,技能={"高级偷袭"}
				,抵抗封印等级=QAQ[序号].抗封等级[i]*1.5
				,门派=sx.门派
				,饰品=true
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 for i=4,5 do
		  门派 = 天罡法系[sj(1,#天罡法系)]
		  sx = self:取属性(等级,门派,"法系")
		  战斗单位[i]={
				名称=名称2
				,模型=诡法[sj(1,#诡法)]
				,角色=true
				,等级=等级
				,气血 = qz(气血)
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])*1.2
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,防御 = qz(等级*10)+800
				,法防 = qz(等级*5)+800
				,招式特效=取招式特效(门派)
				,修炼 = {物抗=xiulian,法抗=xiulian,攻修=xiulian}
				,技能={"高级魔之心"}
				,抵抗封印等级=QAQ[序号].抗封等级[i]*1.5
				,门派=sx.门派
				,饰品=true
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 if 主怪是否为输出 then
		  门派 = 天罡法系[sj(1,#天罡法系)]
		  sx = self:取属性(等级,门派,"法系")
		  战斗单位[6]={
				名称=名称2
				,模型=诡法[sj(1,#诡法)]
				,角色=true
				,等级=等级
				,气血 = qz(气血)
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])*1.2
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
				,防御 = qz(等级*10)+800
				,法防 = qz(等级*5)+800
				,招式特效=取招式特效(门派)
				,修炼 = {物抗=xiulian,法抗=xiulian,攻修=xiulian}
				,技能={"高级魔之心"}
				,抵抗封印等级=QAQ[序号].抗封等级[6]*1.5
				,门派=sx.门派
				,饰品=true
				,AI战斗 = {AI=sx.智能}
		  }
	 else
		  门派 = 天罡封系[sj(1,#天罡封系)]
		  sx = self:取属性(等级,门派,"封系")
		  战斗单位[6]={
				名称=名称3
				,模型=神封[sj(1,#神封)]
				,角色=true
				,等级=等级
				,气血 = qz(气血)
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
				,防御 = qz(等级*10)+800
				,法防 = qz(等级*5)+800
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])*5
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
				,抵抗封印等级=QAQ[序号].抗封等级[6]*2
				,修炼 = {物抗=xiulian,法抗=xiulian,攻修=xiulian}
				,门派=sx.门派
				,饰品=true
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 for i=7,8 do
		  门派 = 天罡封系[sj(1,#天罡封系)]
		  sx = self:取属性(等级,门派,"封系")
		  战斗单位[i]={
				名称=名称3
				,模型=神封[sj(1,#神封)]
				,角色=true
				,等级=等级
				,气血 = qz(气血)
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,防御 = qz(等级*10)+800
				,法防 = qz(等级*5)+800
				,修炼 = {物抗=xiulian,法抗=xiulian,攻修=xiulian}
				,技能={"高级幸运","高级敏捷"}
				,门派=sx.门派
				,饰品=true
				,封印命中等级=QAQ[序号].封印等级[i]*2
				,抵抗封印等级=QAQ[序号].抗封等级[i]*2
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 门派 = "化生寺"
	 sx = self:取属性(等级,门派,"辅助")
	 战斗单位[9]={
		  名称=名称4
		  ,模型=长生[sj(1,#长生)]
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(气血)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])*5
		  ,防御 = qz(等级*20)+800
		  ,法防 = qz(等级*5)+800
		  ,愤怒=99999
		  ,招式特效=取招式特效(门派)
		  ,修炼 = {物抗=xiulian,法抗=xiulian,攻修=xiulian}
		  ,技能={"高级幸运"}
		  ,抵抗封印等级=QAQ[序号].抗封等级[9]*2
		  ,门派=sx.门派
		  ,饰品=true
		  ,AI战斗 = {AI=sx.智能}
	 }
	 门派 = "大唐官府"
	 sx = self:取属性(等级,门派,"物理")
	 战斗单位[10]={
		  名称=名称5
		  ,模型="进阶蜃气妖"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(气血)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])*1.2
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,防御 = qz(等级*10)+800
		  ,法防 = qz(等级*5)+800
		  ,修炼 = {物抗=xiulian,法抗=xiulian,攻修=xiulian}
		  ,技能={"高级偷袭"}
		  ,封印命中等级=QAQ[序号].封印等级[10]
		  ,抵抗封印等级=QAQ[序号].抗封等级[10]
		  ,门派=sx.门派
		  ,饰品=true
		  ,AI战斗 = {AI=sx.智能}
	 }
	 return 战斗单位
end

function 怪物属性:六星天罡(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)+6
	 local wq1={武器="醍醐",级别=160}
	 local 任务属性 = 任务数据[任务id]
	 local 狂攻 = {"进阶魔化毗舍童子","进阶毗舍童子"}
	 local 诡法 = {"进阶混沌兽","进阶灵符女娲"}
	 local 神封 = {"猫灵人形","雾中仙"}
	 local 长生 = {"吸血鬼","金身罗汉"}
	 local 天罡物理 = {"大唐官府","狮驼岭","凌波城","花果山"}
	 local 天罡法系 = {"神木林","魔王寨","龙宫"}
	 local 天罡封系 = {"方寸山","女儿村","盘丝洞","五庄观"}
	 local 门派 = 任务属性.门派
	 local sx = self:取属性(等级,门派)
	 local 主怪是否为输出 = false
	 if sx.智能=="物理" or sx.智能=="法系" or sx.智能=="固伤" then
		  主怪是否为输出 = true
	 end
	 local xiulian = qz(等级/10)+5
	 local 气血=250000+等级*600
	 门派 = 天罡法系[sj(1,#天罡法系)]
	sx = self:取属性(等级,门派,"法系")
	 战斗单位[1]={
		  名称="天女星·沉默"
		  ,模型=任务属性.模型
		  ,角色=true
		  ,主怪=true
		  ,锦衣={{名称="渡劫"}}
		  ,武器=取武器数据(wq1.武器,wq1.级别)
		  ,法宝={[1]={名称="金甲仙衣",境界=9}}
		  ,等级=等级
		  ,气血 = 气血
		  ,伤害 = 等级*20+4000
		  ,法伤 = 等级*18+2500
		  ,速度 = 等级*12+1200
		  ,固定伤害 = qz(等级*20)
		  ,治疗能力 = 3500
		  ,防御 = qz(等级*15)+1200
		  ,法防 = qz(等级*8)+1200
		  ,招式特效=取招式特效(门派)
		  ,修炼 = {物抗=xiulian,法抗=xiulian,攻修=xiulian}
		  ,技能={"高级偷袭","高级魔之心","高级神迹"}
		  ,封印命中等级=1000
		  ,抵抗封印等级=50000
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 return 战斗单位
end

-------------------彩虹争霸
function 怪物属性:女儿村一(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级) --类型：固伤 辅助 物理 法系
	 战斗单位[1]={
		  名称="普通山猴"
		  ,模型="巨力神猿"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="小猴子"
		  ,模型="巨力神猿"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="小猴子"
		  ,模型="巨力神猿"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="喽罗"
		  ,模型="白熊"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="喽罗"
		  ,模型="白熊"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="帮手"
		  ,模型="古代瑞兽"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[7]={
		  名称="拦路虎"
		  ,额外目标数=1
		  ,模型="老虎"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,技能={"感知"}
		  ,主动技能={"失心符"}
	 }
  return 战斗单位
end
function 怪物属性:女儿村二(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级) --类型：固伤 辅助 物理 法系
	 战斗单位[1]={
		  名称="红境山猴"
		  ,模型="长眉灵猴"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="小猴子"
				,模型="长眉灵猴"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="喽罗"
				,模型="黑熊"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=6,9 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="帮手"
				,模型="古代瑞兽"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[10]={
		  名称="拦路虎"
		  ,额外目标数=1
		  ,模型="老虎"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,技能={"感知"}
		  ,主动技能={"失心符"}
	 }
  return 战斗单位
end
function 怪物属性:狮驼岭一(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级) --类型：固伤 辅助 物理 法系
	 local 模型={"夜罗刹","灵鹤","雾中仙"}
	 战斗单位[1]={
		  名称="普通护卫者"
		  ,模型="鲛人"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="协助者"
				,模型="鲛人"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,9 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="帮手"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[10]={
		  名称="拦路虎"
		  ,额外目标数=1
		  ,模型="老虎"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,技能={"感知"}
		  ,主动技能={"失心符"}
	 }
  return 战斗单位
end
function 怪物属性:狮驼岭二(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级) --类型：固伤 辅助 物理 法系
	 local 模型={"夜罗刹","灵鹤","雾中仙"}
	 战斗单位[1]={
		  名称="橙境护卫者"
		  ,模型="鲛人"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="协助者"
				,模型="鲛人"
				,变异=true
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,9 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="帮手"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[10]={
		  名称="拦路虎"
		  ,额外目标数=1
		  ,模型="老虎"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,技能={"感知"}
		  ,主动技能={"失心符"}
	 }
  return 战斗单位
end
function 怪物属性:墨家村一(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级) --类型：固伤 辅助 物理 法系
	 战斗单位[1]={
		  名称="普通守卫者"
		  ,模型="古代瑞兽"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="小泡泡"
				,模型="泡泡"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,9 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="小帮手"
				,模型="海毛虫"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[10]={
		  名称="拦路虎"
		  ,额外目标数=1
		  ,模型="老虎"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,技能={"感知"}
		  ,主动技能={"失心符"}
	 }
  return 战斗单位
end

function 怪物属性:墨家村二(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级) --类型：固伤 辅助 物理 法系
	 战斗单位[1]={
		  名称="黄境守卫者"
		  ,模型="巡游天神"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="小泡泡"
				,模型="泡泡"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end

	 for i=6,9 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="小帮手"
				,模型="海毛虫"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end

	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[10]={
		  名称="拦路虎"
		  ,额外目标数=1
		  ,模型="老虎"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,技能={"感知"}
		  ,主动技能={"失心符"}
	 }
  return 战斗单位
end

function 怪物属性:花果山一(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级) --类型：固伤 辅助 物理 法系
	 战斗单位[1]={
		  名称="普通机器人"
		  ,模型="机关人人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="机器人协助者"
				,模型="机关人人形"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,9 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="助手"
				,模型="机关鸟"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end

	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[10]={
		  名称="拦路虎"
		  ,额外目标数=1
		  ,模型="老虎"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,技能={"感知"}
		  ,主动技能={"失心符"}
	 }
  return 战斗单位
end

function 怪物属性:花果山二(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级) --类型：固伤 辅助 物理 法系
	 local 模型={"锦毛貂精","巴蛇","机关兽"}
	 战斗单位[1]={
		  名称="绿境战车"
		  ,模型="机关鸟"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="战车助手"
				,模型="机关鸟"
				,变异=true
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,9 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="喽罗"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end

	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[10]={
		  名称="拦路虎"
		  ,额外目标数=1
		  ,模型="老虎"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,技能={"感知"}
		  ,主动技能={"失心符"}
	 }
  return 战斗单位
end

function 怪物属性:龙宫一(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级) --类型：固伤 辅助 物理 法系
	 战斗单位[1]={
		  名称="普通小野猪"
		  ,模型="野猪"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="小猪"
				,模型="野猪"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,7 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="喽罗"
				,模型="蚌精"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end

	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[8]={
		  名称="拦路虎"
		  ,额外目标数=1
		  ,模型="老虎"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,技能={"感知"}
		  ,主动技能={"失心符"}
	 }
  return 战斗单位
end
function 怪物属性:龙宫二(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,nil,"物理") --类型：固伤 辅助 物理 法系
	 local 模型={"鼠先锋","凤凰","大海龟"}

	 战斗单位[1]={
		  名称="蓝境小野猪"
		  ,模型="野猪"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"高级反震"}
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="小猪"
				,模型="野猪"
				,变异=true
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,7 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="喽罗"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end

	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[8]={
		  名称="拦路虎"
		  ,额外目标数=1
		  ,模型="老虎"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,技能={"感知"}
		  ,主动技能={"失心符"}
	 }
  return 战斗单位
end
function 怪物属性:太岁山一(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级) --类型：固伤 辅助 物理 法系

	 战斗单位[1]={
		  名称="普通守护伞"
		  ,模型="阴阳伞"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="帮手"
				,模型="阴阳伞"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,9 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="喽罗"
				,模型="龙龟"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end

	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[10]={
		  名称="拦路虎"
		  ,额外目标数=1
		  ,模型="老虎"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,技能={"感知"}
		  ,主动技能={"失心符"}
	 }
  return 战斗单位
end
function 怪物属性:太岁山二(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级) --类型：固伤 辅助 物理 法系
	 local 模型={"律法女娲","龙龟","噬天虎"}
	 战斗单位[1]={
		  名称="靛境守护伞"
		  ,模型="阴阳伞"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="帮手"
				,模型="阴阳伞"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,9 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="助手"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end

	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[10]={
		  名称="拦路虎"
		  ,额外目标数=1
		  ,模型="老虎"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,技能={"感知"}
		  ,主动技能={"失心符"}
	 }
  return 战斗单位
end
function 怪物属性:月宫一(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级) --类型：固伤 辅助 物理 法系
	 战斗单位[1]={
		  名称="普通月宫兔"
		  ,模型="兔子怪"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="帮手"
				,模型="阴阳伞"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="助手"
				,模型="龙龟"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:月宫二(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,nil,"法系") --类型：固伤 辅助 物理 法系
	 战斗单位[1]={
		  名称="紫境守护兽"
		  ,模型="炎魔神"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="帮手"
				,模型="阴阳伞"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="助手"
				,模型="龙龟"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"物理")
	 战斗单位[6]={
		  名称="喽罗"
		  ,模型="律法女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={"高级反震"}
		  -- ,主动技能=sx.技能组
	 }
	 return 战斗单位
end

function 怪物属性:泡泡一(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,nil,"法系")
	 local 模型={"混沌兽","狂豹人形"}
	 战斗单位[1]={
		  名称="速度快"
		  ,模型="龙龟"
		  ,附加阵法="鸟翔阵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能={"水漫金山","泰山压顶"}
	 }
	 sx = self:取属性(等级,nil,"物法")
	 战斗单位[2]={
		  名称="速度很快"
		  ,模型="龙龟"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级,nil,"物理")
	 战斗单位[3]={
		  名称="速度好快"
		  ,模型="龙龟"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,技能={"感知"}
	 }

	 sx = self:取属性(等级,nil,"物理")
	 战斗单位[4]={
		  名称="速度特快"
		  ,模型="龙龟"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}

	 }
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[5]={
		  名称="打酱油的"
		  ,模型="花妖"
		  ,被封发言="我还要去打酱油呢#52"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,主动技能={"含情脉脉"}
	 }
	 for i=6,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="喽罗"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*3
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:泡泡二(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 门派 = "狮驼岭"
	 local sx = self:取属性(等级,"狮驼岭")
	 local 模型={"混沌兽","狂豹人形","吸血鬼","龙龟"}
	 战斗单位[1]={
		  名称="想吃天鹅肉"
		  ,模型="蛤蟆精"
		  ,附加阵法="虎翼阵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,门派 = sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级,nil,"物法")
	 战斗单位[2]={
		  名称="爬得很快"
		  ,模型="大海龟"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }

	 sx = self:取属性(等级,nil,"法系")
	 战斗单位[3]={
		  名称="爬得很快"
		  ,模型="大海龟"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能={"水攻"}
	 }
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[4]={
		  名称="跳得很高"  --被封就跑
		  ,模型="巨蛙"
		  ,被封发言="#24你们是怎么看出来我不一样的！"
		  ,额外目标数=1
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,主动技能={"错乱"}
	 }

	 sx = self:取属性(等级,nil,"物法")
	 战斗单位[5]={
		  名称="跳得很高"
		  ,模型="巨蛙"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=6,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="喽罗"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*3
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:泡泡三(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 门派 = "化生寺"

	 local sx = self:取属性(等级,"化生寺","辅助")
	 local 模型={"混沌兽","狂豹人形","吸血鬼","龙龟"}
	 战斗单位[1]={
		  名称="铜墙铁壁"
		  ,模型="龙龟"
		  ,附加阵法="龙飞阵"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级,nil,"物理")
	 战斗单位[2]={
		  名称="铁爪无情"
		  ,模型="老虎"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,主动技能={"天雷斩"}
	 }

	 sx = self:取属性(等级,"龙宫",类型)
	 战斗单位[3]={
		  名称="混世魔王"
		  ,模型="灵符女娲"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派 = sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[4]={
		  名称="金枝玉叶"  --被封就跑
		  ,模型="树怪"
		  ,开场发言="刚偷学了一个#R秘传失心符#W，不知道好用不好用#87"
		  ,被封发言="不和你们玩了#82"
		  ,额外目标数=2
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,主动技能={"失心符"}
	 }
	 sx = self:取属性(等级,"狮驼岭",nil)
	 战斗单位[5]={
		  名称="神行小龟"
		  ,模型="大海龟"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,门派 = sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=6,10 do
		  sx = self:取属性(等级,nil,"物法")
		  战斗单位[i]={
				名称="喽罗"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*3
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:泡泡四(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 门派 = "魔王寨"
	 local sx = self:取属性(等级,"魔王寨")
	 local 模型={"混沌兽","狂豹人形","吸血鬼","龙龟"}
	 战斗单位[1]={
		  名称="超级机关鸟"
		  ,模型="机关鸟"
		  ,附加阵法="地载阵"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,门派 = sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,nil,"法系")
	 战斗单位[2]={
		  名称="五雷正宗"
		  ,模型="雷鸟人"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,主动技能={"五雷咒"}
	 }

	 sx = self:取属性(等级,nil,"物法")
	 战斗单位[3]={
		  名称="大力金刚"
		  ,模型="大力金刚"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }

	 sx = self:取属性(等级,"化生寺","辅助")
	 战斗单位[4]={
		  名称="苹果小车"  --被封就跑
		  ,模型="机关兽"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,门派 = sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[5]={
		  名称="卖萌小狸"
		  ,模型="狸"
		  ,开场发言="认识我的造型吗？该怎么做你们懂的#119"
		  ,被封发言="#119"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能={"一笑倾城"}
	 }
	 for i=6,10 do
		  sx = self:取属性(等级,nil,"物法")
		  战斗单位[i]={
				名称="喽罗"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*3
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:泡泡五(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 门派 = "天宫"

	 local sx = self:取属性(等级,nil,"物理")
	 local 模型={"混沌兽","狂豹人形","吸血鬼","龙龟"}
	 战斗单位[1]={
		  名称="横行天下"
		  ,模型="蟹将"
		  ,开场发言="我行走江湖都是横着走的，会怕你们吗#28"
		  ,附加阵法="风扬阵"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能={"天雷斩"}
	 }

	 sx = self:取属性(等级,"大唐官府",类型)
	 战斗单位[2]={
		  名称="右护法"
		  ,模型="大力金刚"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,门派 = sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级,"大唐官府",类型)
	 战斗单位[3]={
		  名称="左护法"
		  ,模型="大力金刚"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派 = sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级,nil,"物理")
	 战斗单位[4]={
		  名称="六道魍魉"  --被封就跑
		  ,模型="吸血鬼"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,主动技能={"百爪狂杀"}
	 }

	 sx = self:取属性(等级,nil,"固伤")
	 战斗单位[5]={
		  名称="勾魂阎罗"
		  ,模型="吸血鬼"
		  ,开场发言="我似乎好像走错地方了#55"
		  ,被封发言="我似乎真的走错地方了#52"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能={"阎罗令"}
	 }
	 for i=6,10 do
		  sx = self:取属性(等级,nil,"物理")
		  战斗单位[i]={
				名称="喽罗"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*3
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:泡泡六(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 门派 = "天宫"
	 local sx = self:取属性(等级,nil,"固伤")
	 local 模型={"混沌兽","狂豹人形","吸血鬼","龙龟"}
	 战斗单位[1]={
		  名称="红灵仙子"
		  ,模型="曼珠沙华"
		  ,开场发言="#2开天阵干他们！"
		  ,附加阵法="天覆阵"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能={"苍茫树","靛沧海","日光华"}
	 }

	 sx = self:取属性(等级,"阴曹地府","物理")
	 战斗单位[2]={
		  名称="迷糊小仙"
		  ,模型="猫灵人形"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,门派 = sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[3]={
		  名称="五魔小龙"
		  ,模型="幽萤娃娃"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派 = sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级,"化生寺","辅助")
	 战斗单位[4]={
		  名称="龙宫的心"  --被封就跑
		  ,模型="阴阳伞"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,门派 = sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[5]={
		  名称="神封无量"
		  ,模型="画魂"
		  ,被封发言="不要迷恋姐，姐只是个传说#98"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能={"如花解语"}
	 }
	 for i=6,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="喽罗"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*3
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:泡泡七(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 门派 = "龙宫"
	 local sx = self:取属性(等级,"龙宫")
	 local 模型={"混沌兽","狂豹人形","吸血鬼","龙龟"}
	 战斗单位[1]={
		  名称="云龙真身"
		  ,模型="进阶画魂"
		  ,附加阵法="云垂阵"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,门派 = sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[2]={
		  名称="杏林妙手"
		  ,模型="幽萤娃娃"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,门派 = sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 门派 = "大唐官府"
	 sx = self:取属性(等级,门派)
	 战斗单位[3]={
		  名称="无双战神"
		  ,模型="夜罗刹"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派 = sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级,nil,"物理")
	 战斗单位[4]={
		  名称="勾魂阎罗"  --被封就跑
		  ,模型="吸血鬼"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={""}
		  ,主动技能={"百爪狂杀"}
	 }

	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[5]={
		  名称="拘灵散修"
		  ,模型="红萼仙子"
		  ,被封发言="糟糕，被识破了#24"
		  ,变异 = true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能={"日月乾坤"}
	 }
	 for i=6,10 do
		  sx = self:取属性(等级,nil,"物理")
		  战斗单位[i]={
				名称="喽罗"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*3
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:红境传送大使(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"化生寺","辅助")
	 战斗单位[1]={
		  名称="红境传送大使"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,门派 = sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="红境山猴"
				,模型="长眉灵猴"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="普通山猴"
				,模型="巨力神猿"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=6,10 do
		  sx = self:取属性(等级,nil,"物理")
		  战斗单位[i]={
				名称="帮手"
				,模型="古代瑞兽"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
		  }
	 end
  return 战斗单位
end

function 怪物属性:橙境传送大使(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="橙境传送大使"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="橙境护卫者"
				,模型="鲛人"
				,变异=true
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="普通护卫者"
				,模型="鲛人"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=6,10 do
		  sx = self:取属性(等级,nil,"物理")
		  战斗单位[i]={
				名称="喽罗"
				,模型="蚌精"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
		  }
	 end
  return 战斗单位
end

function 怪物属性:黄境传送大使(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 local 模型={"锦毛貂精","巴蛇"}
	 战斗单位[1]={
		  名称="黄境传送大使"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="黄境守卫者"
				,模型="巡游天神"
				,变异=true
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="普通守卫者"
				,模型="古代瑞兽"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=6,10 do
		  sx = self:取属性(等级,nil,"物理")
		  战斗单位[i]={
				名称="喽罗"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
		  }
	 end
  return 战斗单位
end

function 怪物属性:绿境传送大使(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 local 模型={"锦毛貂精","巴蛇"}
	 战斗单位[1]={
		  名称="绿境传送大使"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="绿境战车"
				,模型="连弩车"
				,变异=true
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="普通战车"
				,模型="连弩车"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=6,10 do
		  sx = self:取属性(等级,nil,"物理")
		  战斗单位[i]={
				名称="喽罗"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
		  }
	 end
  return 战斗单位
end

function 怪物属性:蓝境传送大使(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 local 模型={"鼠先锋","凤凰"}
	 战斗单位[1]={
		  名称="蓝境传送大使"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="强化机器人"
				,模型="机关人人形"
				,变异=true
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="普通机器人"
				,模型="机关人人形"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=6,10 do
		  sx = self:取属性(等级,nil,"物理")
		  战斗单位[i]={
				名称="喽罗"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
		  }
	 end
  return 战斗单位
end

function 怪物属性:靛境传送大使(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,nil,"物理")
	 local 模型={"噬天虎","律法女娲"}
	 战斗单位[1]={
		  名称="靛境传送大使"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能={"横扫千军"}
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="靛境守护伞"
				,模型="阴阳伞"
				,变异=true
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,9 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="普通守护伞"
				,模型="阴阳伞"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"物理")
	 战斗单位[10]={
		  名称="喽罗"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,技能={"高级反震"}
	 }

  return 战斗单位
end

function 怪物属性:紫境传送大使(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="紫境传送大使"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="靛境守护兽"
				,模型="炎魔神"
				,变异=true
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="普通月宫兔"
				,模型="兔子怪"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=6,10 do
		  sx = self:取属性(等级,nil,"物理")
		  战斗单位[i]={
				名称="喽罗"
				,模型="净瓶女娲"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
		  }
	 end
  return 战斗单位
end

function 怪物属性:文墨场景巡逻(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="蒙面飞贼"
		  ,模型="吸血鬼"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="贴身灵妖"
				,模型="蝎子精"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="机关兽"
				,模型="机关兽"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:文墨护送使者(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 模型={"山贼","强盗","赌徒"}
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="劫财匪徒"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="乌合小贼"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="江湖小盗"
				,模型=模型[取随机数(1,#模型)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[6]={
		  名称="压寨"
		  ,模型="猫灵人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={"感知"}
		  ,主动技能={"失心符","错乱","似玉生香"}
	 }
	 return 战斗单位
end

function 怪物属性:文墨取木材(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="梁木"
		  ,模型="树怪"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])+1
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="灵鸟"
				,模型="凤凰"
				,等级=等级
				,变异=true
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])+9999
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,门派="普陀山"
				,AI战斗 = {AI="文墨取木材"}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:文墨写字(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="猎犬"
		  ,模型="狼"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])+1
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="绿林犬"
				,模型="狼"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:文墨门派送信(任务id,玩家id,序号)
	 local 模型
	 local 名称
	 local 门派
	 local 小怪模型
	 local 小怪名称
	 local AI类型="法系"
	 if 任务数据[任务id].SX.人物=="孙婆婆" then
		  模型="飞燕女"
		  名称="国色天香"
		  门派="女儿村"
		  AI类型="封系"
		  local 小怪1 = {"雾中仙","芙蓉仙子","如意仙子"}
		  local 小怪名1 = {"啊娜","嫣然","傲娇"}
		  小怪模型=小怪1[取随机数(1,#小怪1)]
		  小怪名称=小怪名1[取随机数(1,#小怪名1)]
	 elseif 任务数据[任务id].SX.人物=="菩提老祖" then
		  模型="英女侠"
		  名称="五雷正宗"
		  门派="方寸山"
		  AI类型="法系"
		  local 小怪2 = {"灵符女娲","律法女娲"}
		  local 小怪名2 = {"灵台符仙","镇魂"}
		  小怪模型=小怪2[取随机数(1,#小怪2)]
		  小怪名称=小怪名2[取随机数(1,#小怪名2)]
	 elseif 任务数据[任务id].SX.人物=="程咬金" then
		  模型="剑侠客"
		  名称="浴血豪侠"
		  门派="大唐官府"
		  AI类型="物理"
		  local 小怪3 = {"狂豹人形","护卫"}
		  local 小怪名3 = {"大唐校尉","沙场护卫"}
		  小怪模型=小怪3[取随机数(1,#小怪3)]
		  小怪名称=小怪名3[取随机数(1,#小怪名3)]
	 elseif 任务数据[任务id].SX.人物=="东海龙王" then
		  模型="龙太子"
		  名称="翻江猛龙"
		  门派="龙宫"
		  AI类型="法系"
		  local 小怪5 = {"龙龟","虾兵"}
		  local 小怪名5 = {"东海神龟","海中鳌虾"}
		  小怪模型=小怪5[取随机数(1,#小怪5)]
		  小怪名称=小怪名5[取随机数(1,#小怪名5)]
	 elseif 任务数据[任务id].SX.人物=="巫奎虎" then
		  模型="巫蛮儿"
		  名称="天人庇护"
		  门派="神木林"
		  AI类型="法系"
		  local 小怪8 = {"树怪","长眉灵猴"}
		  local 小怪名8 = {"万物轮转","瞬息万变"}
		  小怪模型=小怪8[取随机数(1,#小怪8)]
		  小怪名称=小怪名8[取随机数(1,#小怪名8)]
	 elseif 任务数据[任务id].SX.人物=="空度禅师" then
		  模型="逍遥生"
		  名称="杏林妙手"
		  门派="化生寺"
		  AI类型="法系"
		  local 小怪6 = {"雨师","噬天虎"}
		  local 小怪名6 = {"佛门护法","回春"}
		  小怪模型=小怪6[取随机数(1,#小怪6)]
		  小怪名称=小怪名6[取随机数(1,#小怪名6)]
	 elseif 任务数据[任务id].SX.人物=="李靖" then
		  模型="舞天姬"
		  名称="雷霆神使"
		  门派="天宫"
		  AI类型="法系"
		  local 小怪7 = {"天兵","长眉灵猴"}
		  local 小怪名7 = {"蟠桃令","护法天兵"}
		  小怪模型=小怪7[取随机数(1,#小怪7)]
		  小怪名称=小怪名7[取随机数(1,#小怪名7)]
	 else
		  模型="神天兵"
		  名称="雷霆神使"
		  门派="天宫"
		  AI类型="法系"
		  local 小怪7 = {"天兵","长眉灵猴"}
		  local 小怪名7 = {"蟠桃令","护法天兵"}
		  小怪模型=小怪7[取随机数(1,#小怪7)]
		  小怪名称=小怪名7[取随机数(1,#小怪名7)]
	 end
	 local 武器造型=取140武器造型(模型)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,门派,AI类型)
	 战斗单位[1]={
		  名称=名称
		  ,模型=模型
		  ,等级=等级
		  ,角色=true
		  ,武器=取武器数据(武器造型.武器,武器造型.级别)
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,门派=门派
		  ,AI战斗={AI=AI类型}
	 }
	 for i=2,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称=小怪名称
				,模型=小怪模型
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[6]={
		  名称="狸"
		  ,模型="花妖"
		  ,等级=等级
		  ,变异 = true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,主动技能={"日月乾坤","失心符","似玉生香"}
	 }
	 return 战斗单位
end

function 怪物属性:天降辰星子鼠(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,nil,"物理")
	 战斗单位[1]={
		  名称="子鼠"
		  ,模型="鼠先锋"
		  ,开场发言="好多人，我要打个洞躲起来#24"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])*2
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={}
	 }
	 return 战斗单位
end

function 怪物属性:天降辰星丑牛(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="丑牛"
		  ,模型="踏云兽"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="哞哞牛"
				,模型="踏云兽"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])*2
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:天降辰星寅虎(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="寅虎"
		  ,模型="噬天虎"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*3
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="虎跃"
				,模型="噬天虎"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="机关兽"
		  ,模型="噬天虎"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,主动技能=sx.技能组
	 }
	 for i=5,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="虎跃"
				,模型="噬天虎"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:天降辰星卯兔(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="卯兔"
		  ,模型="兔子怪"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="蹦蹦"
		  ,模型="兔子怪"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="跳跳"
		  ,模型="兔子怪"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="蹦蹦"
		  ,模型="兔子怪"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="跳跳"
		  ,模型="兔子怪"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[6]={
		  名称="狸"
		  ,模型="花妖"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,封印命中等级=QAQ[序号].封印等级[6]
		  ,主动技能={"失心符","含情脉脉"}
	 }
	 return 战斗单位
end

function 怪物属性:天降辰星辰龙(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="辰龙"
		  ,模型="蛟龙"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="龙跃"
				,模型="蛟龙"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="龙飞"
				,模型="蛟龙"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:天降辰星巳蛇(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="巳蛇"
		  ,模型="千年蛇魅"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="蛇形魅影"
				,模型="千年蛇魅"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[9]={
		  名称="狸"
		  ,模型="花妖"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,封印命中等级=QAQ[序号].封印等级[9]
		  ,主动技能={"失心符","含情脉脉"}
	 }
	 return 战斗单位
end

function 怪物属性:天降辰星午马(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="午马"
		  ,模型="马面"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="逐日"
				,模型="马面"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="追风"
				,模型="马面"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:天降辰星未羊(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="未羊"
		  ,模型="羊头怪"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="咩咩"
				,模型="羊头怪"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:天降辰星申猴(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,nil,"物理")
	 战斗单位[1]={
		  名称="申猴"
		  ,模型="长眉灵猴"
		  ,等级=等级
		  ,开场发言="#17我就喜欢挑战防御高的人……"
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 战斗单位
end

function 怪物属性:天降辰星未羊(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="未羊"
		  ,模型="羊头怪"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="咩咩"
				,模型="羊头怪"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:天降辰星酉鸡(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="酉鸡"
		  ,模型="超级神鸡"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="鸡鸣"
				,模型="进阶雷鸟人"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="鸡鸣"
				,模型="雷鸟人"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[6]={
		  名称="狸"
		  ,模型="花妖"
		  ,等级=等级
		  ,变异 = true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])*5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,主动技能={"日月乾坤","失心符","似玉生香"}
	 }
	 return 战斗单位
end

function 怪物属性:天降辰星戌犬(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="戌犬"
		  ,模型="狼"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="犬吠"
				,模型="狼"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:天降辰星亥猪(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="亥猪"
		  ,模型="野猪"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])*2
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])*2
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="猪小哼"
				,模型="野猪"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="哼哼猪"
				,模型="野猪"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 for i=6,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="猪哼哼"
				,模型="野猪"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:入侵者(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="入侵者"
		  ,模型="山贼"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="打手"
				,模型="强盗"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:秽气妖(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="秽气妖"
		  ,模型="蜃气妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="秽气师"
				,模型="蜃气妖"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 for i=4,6 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="秽气"
				,模型="吸血鬼"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,"神木林","法系")
	 for i=7,10 do
		  战斗单位[i]={
				名称="秽气"
				,模型="吸血鬼"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,门派="神木林"
				,AI战斗={AI=AI类型}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:人才阵眼(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="阵眼"
		  ,模型="进阶机关人人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级,"神木林","法系")
		  战斗单位[i]={
				名称="阵型"
				,模型="巴蛇"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,门派="神木林"
				,AI战斗={AI=AI类型}
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="阵型"
				,模型="巴蛇"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 for i=6,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="阵石"
				,模型="进阶机关兽"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:地才阵眼(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="阵眼"
		  ,模型="进阶机关人人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级,"神木林","法系")
		  战斗单位[i]={
				名称="阵型"
				,模型="巴蛇"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,门派="神木林"
				,AI战斗={AI=AI类型}
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="阵型"
				,模型="巴蛇"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 for i=6,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="阵石"
				,模型="进阶机关兽"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:天才阵眼(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="阵眼"
		  ,模型="进阶机关人人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级,"神木林","法系")
		  战斗单位[i]={
				名称="阵型"
				,模型="巴蛇"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,门派="神木林"
				,AI战斗={AI=AI类型}
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="阵型"
				,模型="巴蛇"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end

	 for i=6,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="阵石"
				,模型="进阶机关兽"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:人才(任务id,玩家id,序号)
	 local wq1={武器="浩气长舒",级别=150} --牧云清歌 150
	 local wq2={武器="霜冷九州",级别=150}
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"凌波城","物理")
	 战斗单位[1]={
		  名称="人才"
		  ,模型="修罗傀儡鬼"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,门派="凌波城"
		  ,AI战斗={AI=AI类型}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="人心莫测"
		  ,模型="逍遥生"
		  ,角色=true
		  ,染色方案=1
		  ,染色组={[1]=9,[2]=0,[3]=2,序号=3710}
		  ,武器=取武器数据(wq1.武器,wq1.级别)
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="人情义士"
		  ,模型="剑侠客"
		  ,角色=true
		  ,染色方案=2
		  ,染色组={[1]=3,[2]=0,[3]=2,序号=3710}
		  ,武器=取武器数据(wq2.武器,wq2.级别)
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能=sx.技能组
	 }
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="阵石"
				,模型="曼珠沙华"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="劳释虚象"
		  ,模型="进阶雨师"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,主动技能=sx.技能组
	 }
	 for i=7,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="金石为开"
				,模型="狂豹人形"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:地才(任务id,玩家id,序号)
	 local wq1={武器="牧云清歌",级别=150} --牧云清歌 150
	 local wq2={武器="狂澜碎岳",级别=150}
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="地才"
		  ,模型="机关人人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[2]={
		  名称="地裂"
		  ,模型="狐美人"
		  ,角色=true
		  ,染色方案=7
		  ,染色组={[1]=2,[2]=0,[3]=2,序号=3710}
		  ,武器=取武器数据(wq1.武器,wq1.级别)
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,门派="魔王寨"
		  ,AI战斗={AI=AI类型}
	 }
	 sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[3]={
		  名称="山崩"
		  ,模型="虎头怪"
		  ,角色=true
		  ,染色方案=6
		  ,染色组={[1]=2,[2]=0,[3]=2,序号=3710}
		  ,武器=取武器数据(wq2.武器,wq2.级别)
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派="狮驼岭"
		  ,AI战斗={AI=AI类型}
	 }
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="阵石"
				,模型="猫灵兽形"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="劳释虚象"
		  ,模型="进阶雨师"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,主动技能=sx.技能组
	 }
	 for i=7,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="生死轮回"
				,模型="鬼将"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:天才(任务id,玩家id,序号)
	 local wq1={武器="丝萝乔木",级别=150} --牧云清歌 150
	 local wq2={武器="天龙破城",级别=150}
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"凌波城","物理")
	 战斗单位[1]={
		  名称="天才"
		  ,模型="阴阳伞"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,门派="凌波城"
		  ,AI战斗={AI=AI类型}
	 }
	 sx = self:取属性(等级,"龙宫","法系")
	 战斗单位[2]={
		  名称="天佑我成"
		  ,模型="玄彩娥"
		  ,角色=true
		  ,染色方案=1
		  ,染色组={[1]=9,[2]=0,[3]=2,序号=3710}
		  ,武器=取武器数据(wq1.武器,wq1.级别)
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,门派="龙宫"
		  ,AI战斗={AI=AI类型}
	 }
	 sx = self:取属性(等级,"天宫","法系")
	 战斗单位[3]={
		  名称="天网恢恢"
		  ,模型="龙太子"
		  ,角色=true
		  ,染色方案=6
		  ,染色组={[1]=2,[2]=0,[3]=2,序号=3710}
		  ,武器=取武器数据(wq2.武器,wq2.级别)
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派="天宫"
		  ,AI战斗={AI=AI类型}
	 }
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="阵石"
				,模型="混沌兽"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="劳释虚象"
		  ,模型="进阶雨师"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,主动技能=sx.技能组
	 }
	 for i=7,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="善恶有报"
				,模型="律法女娲"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:劳释道人(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="劳释道人"
		  ,模型="进阶雨师"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,3 do
		  sx = self:取属性(等级,"龙宫","法系")
		  战斗单位[i]={
				名称="至阴"
				,模型="进阶灵符女娲"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,门派="龙宫"
				,AI战斗={AI=AI类型}
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级,"神木林","法系")
		  战斗单位[i]={
				名称="至阴"
				,模型="进阶灵符女娲"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,门派="神木林"
				,AI战斗={AI=AI类型}
		  }
	 end
	 sx = self:取属性(等级,"化生寺","辅助")
	 战斗单位[6]={
		  名称="阵石"
		  ,模型="机关人人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,门派="化生寺"
		  ,AI战斗={AI=AI类型}
	 }
	 for i=7,10 do
		  sx = self:取属性(等级,"凌波城","物理")
		  战斗单位[i]={
				名称="纯阳"
				,模型="进阶天兵"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,门派="凌波城"
				,AI战斗={AI=AI类型}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:秽气源头(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="秽气源头"
		  ,模型="进阶蜃气妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,主动技能=sx.技能组
	 }
	 for i=2,4 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="炎炎浊气"
				,模型="蜃气妖"
				,等级=等级
				,变异=true
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,"凌波城","物理")
	 战斗单位[5]={
		  名称="炎炎浊气"
		  ,模型="蜃气妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,门派="凌波城"
		  ,AI战斗={AI=AI类型}
	 }
	 for i=6,10 do
		  战斗单位[i]={
				名称="死气沉沉"
				,模型="幽灵"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,门派="凌波城"
				,AI战斗={AI=AI类型}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:金龙(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"凌波城","物理")
	 战斗单位[1]={
		  名称="金龙"
		  ,模型="蛟龙"
		  ,等级=等级
		  ,变异 = true
		  ,附加阵法="虎翼阵"
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,抵抗封印等级=QAQ[序号].抗封等级[1]
		  ,门派="凌波城"
		  ,AI战斗={AI=AI类型}
	 }
	 sx = self:取属性(等级,"神木林","法系")
	 战斗单位[2]={
		  名称="玉龙"
		  ,模型="蛟龙"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,抵抗封印等级=QAQ[序号].抗封等级[2]
		  ,门派="神木林"
		  ,AI战斗={AI=AI类型}
	 }
	 sx = self:取属性(等级,"神木林","法系")
	 战斗单位[3]={
		  名称="银龙"
		  ,模型="蛟龙"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,技能={"感知"}
		  ,抵抗封印等级=QAQ[序号].抗封等级[3]
		  ,门派="神木林"
		  ,AI战斗={AI=AI类型}
	 }
	 for i=4,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="龙女"
				,模型="小龙女"
				,变异 = true
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="蝶"
		  ,模型="进阶蝴蝶仙子"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=7,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="芙"
				,模型="芙蓉仙子"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,"方寸山","封系")
	 战斗单位[9]={
		  名称="凤"
		  ,模型="凤凰"
		  ,变异 =true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])+1
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,封印命中等级=QAQ[序号].封印等级[9]
		  ,抵抗封印等级=QAQ[序号].抗封等级[9]
		  ,技能={"感知"}
		  ,门派="方寸山"
		  ,AI战斗={AI=AI类型}
	 }
	 sx = self:取属性(等级,"化生寺","辅助")
	 战斗单位[10]={
		  名称="生"
		  ,模型="凤凰"
		  ,变异 =true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])+1
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,封印命中等级=QAQ[序号].封印等级[10]
		  ,抵抗封印等级=QAQ[序号].抗封等级[10]
		  ,技能={"感知"}
		  ,门派="化生寺"
		  ,AI战斗={AI=AI类型}
	 }
	 return 战斗单位
end

function 怪物属性:五更寒慧明长老(任务id,玩家id,序号)
	 local 模型 ={"灵符女娲"}
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 门派 = "大唐官府"
	 local sx = self:取属性(等级,"大唐官府")
	 战斗单位[1]={
		  名称="慧明长老"
		  ,模型="雨师"
		  ,开场发言="给你们的机会没有珍惜，那就只有打一场了。#14"
		  ,等级=等级
		  ,变异=false
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"化生寺","法系")
	 战斗单位[2]={
		  名称=" 竹木签 "
		  ,模型="灵符女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城")
	 战斗单位[3]={
		  名称=" 竹木签 "
		  ,模型="灵符女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[4]={
		  名称=" 竹木签 "
		  ,模型="灵符女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"魔王寨")
	 战斗单位[5]={
		  名称=" 竹木签 "
		  ,模型="灵符女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="竹木签"
		  ,模型="灵符女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="竹木签"
		  ,模型="灵符女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="竹木签"
		  ,模型="灵符女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[9]={
		  名称="竹木签"
		  ,模型="灵符女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,技能={"感知"}
			,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[10]={
		  名称="竹木签"
		  ,模型="灵符女娲"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,技能={"感知"}
			,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end

function 怪物属性:五更寒小鱼儿(任务id,玩家id,序号)
	 local 模型 ={"野鬼"}
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 门派 = "龙宫"
	 local sx = self:取属性(等级,"龙宫")
	 战斗单位[1]={
		  名称="邪影妖灵"
		  ,模型="幽灵"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[2]={
		  名称=" 幽风魅影 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[3]={
		  名称=" 幽风魅影 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称=" 幽风魅影"
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称=" 幽风魅影 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[6]={
		  名称=" 幽风魅影 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[7]={
		  名称=" 幽风魅影 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[8]={
		  名称=" 幽风魅影 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[9]={
		  名称=" 幽风魅影 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[10]={
		  名称=" 幽风魅影 "
		  ,模型=模型[取随机数(1,#模型)]
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end

function 怪物属性:五更寒魔化村民赌徒(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"普陀山","辅助")
	 战斗单位[1]={
		  名称="魔化村民"
		  ,模型="赌徒"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=2,法抗=2,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[2]={
		  名称="毒语灵蛇"
		  ,模型="千年蛇魅"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"天宫","物理")
	 战斗单位[3]={
		  名称="毒语灵蛇"
		  ,模型="千年蛇魅"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[4]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,等级=等级
		  ,招式特效={飞砂走石=true}
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[5]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,等级=等级
		  ,招式特效={飞砂走石=true}
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  -- ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[6]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  -- ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[7]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[8]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  -- ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[9]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[8]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end

function 怪物属性:五更寒魔化村民山贼(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 门派 = "狮驼岭"
	 local sx = self:取属性(等级,"狮驼岭")
	 战斗单位[1]={
		  名称="魔化村民"
		  ,模型="山贼"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=2,法抗=2,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫")
	 战斗单位[2]={
		  名称="血影狂刀"
		  ,模型="鲛人"
		  ,等级=等级
		  ,招式特效={龙卷雨击=true}
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫")
	 战斗单位[3]={
		  名称="血影狂刀"
		  ,模型="鲛人"
		  ,等级=等级
		  ,招式特效={龙卷雨击=true}
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[4]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[5]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[6]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[7]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[8]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[9]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[10]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end

function 怪物属性:五更寒魔化村民夜叉(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 门派 = "狮驼岭"
	 local sx = self:取属性(等级,"化生寺","法系")
	 战斗单位[1]={
		  名称="魔化村民"
		  ,模型="碧水夜叉"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=2,法抗=2,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[2]={
		  名称="寒光杀手"
		  ,模型="吸血鬼"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"普陀山","固伤")
	 战斗单位[3]={
		  名称="寒光杀手"
		  ,模型="吸血鬼"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[4]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[5]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[6]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[7]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[8]={
		  名称="嗜血邪影"
		  ,模型="幽灵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end

function 怪物属性:五更寒魔化村长(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"方寸山")
	 战斗单位[1]={
		  名称="魔化村长"
		  ,模型="长眉灵猴"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,封印命中等级=QAQ[序号].封印等级[1]
		  ,技能={"感知"}
		  ,修炼 = {物抗=2,法抗=2,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx =self:取属性(等级,"大唐官府")
	 战斗单位[2]={
		  名称="寒光杀手 "
		  ,模型="吸血鬼"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	sx = self:取属性(等级,"大唐官府")
	 战斗单位[3]={
		  名称="寒光杀手 "
		  ,模型="吸血鬼"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	sx = self:取属性(等级,"神木林")
	 战斗单位[4]={
		  名称="血影狂刀"
		  ,模型="鲛人"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx =self:取属性(等级,"魔王寨")
	 战斗单位[5]={
		  名称="血影狂刀"
		  ,模型="鲛人"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx =self:取属性(等级,"女儿村","固伤")
	 战斗单位[6]={
		  名称="毒语灵蛇"
		  ,模型="千年蛇魅"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx =self:取属性(等级,"女儿村","固伤")
	 战斗单位[7]={
		  名称="毒语灵蛇"
		  ,模型="千年蛇魅"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	sx = self:取属性(等级,"女儿村","固伤")
	 战斗单位[8]={
		  名称="毒语灵蛇"
		  ,模型="千年蛇魅"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx =self:取属性(等级,"女儿村","固伤")
	 战斗单位[9]={
		  名称="毒语灵蛇"
		  ,模型="千年蛇魅"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx =self:取属性(等级,"女儿村","固伤")
	 战斗单位[10]={
		  名称="毒语灵蛇"
		  ,模型="千年蛇魅"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end

function 怪物属性:五更寒八足海妖(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[1]={
		  名称="八足海妖"
		  ,模型="进阶百足将军"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城")
	 战斗单位[2]={
		  名称="波云诡谲"
		  ,模型="噬天虎"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城")
	 战斗单位[3]={
		  名称="波云诡谲"
		  ,模型="噬天虎"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城")
	 战斗单位[4]={
		  名称="波云诡谲"
		  ,模型="夜罗刹"
		  ,变异=true
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城")
	 战斗单位[5]={
		  名称="波云诡谲"
		  ,模型="夜罗刹"
		  ,变异=true
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"神木林")
	 战斗单位[6]={
		  名称="乱石穿空"
		  ,模型="踏云兽"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"神木林")
	 战斗单位[7]={
		  名称="乱石穿空"
		  ,模型="踏云兽"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"神木林")
	 战斗单位[8]={
		  名称="乱石穿空"
		  ,模型="踏云兽"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"神木林")
	 战斗单位[9]={
		  名称="乱石穿空"
		  ,模型="踏云兽"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"神木林")
	 战斗单位[10]={
		  名称="乱石穿空"
		  ,模型="踏云兽"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end

function 怪物属性:一斛珠鸾儿(任务id,玩家id,序号)
	 local 战斗单位={}
	 local wq1={武器="牧云清歌",级别=150}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[1]={
		  名称="鸾儿姑娘"
		  ,模型="狐美人"
		  ,角色=true
		  ,锦衣={{名称="花间梦"}}
		  ,武器=取武器数据(wq1.武器,wq1.级别)
		  ,开场发言="敢阻拦我！你们都得死！#14"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="清醒意识"
		  ,模型="画魂"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,开场发言="别打我们，否则主人会很可怕！"
	--     ,门派=sx.门派
	--     ,AI战斗 = {AI=sx.智能}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="清醒意识"
		  ,模型="画魂"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,开场发言="别打我们，否则主人会很可怕！"
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="清醒意识"
		  ,模型="雾中仙"
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,开场发言="别打我们，否则主人会很可怕！"
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="清醒意识"
		  ,模型="雾中仙"
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,开场发言="别打我们，否则主人会很可怕！"
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="泪光盈盈"
		  ,模型="进阶蝴蝶仙子"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="泪光盈盈"
		  ,模型="进阶蝴蝶仙子"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="泪光盈盈"
		  ,模型="进阶蝴蝶仙子"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[9]={
		  名称="缠绵幽怨"
		  ,模型="芙蓉仙子"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[10]={
		  名称="缠绵幽怨"
		  ,模型="芙蓉仙子"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end

function 怪物属性:一斛珠叶夫人(任务id,玩家id,序号)
	 local 战斗单位={}
	 local wq1={武器="紫电青霜",级别=150}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[1]={
		  名称="叶夫人"
		  ,模型="英女侠"
		  ,角色=true
		  ,锦衣={{名称="从军行"}}
		  ,武器=取武器数据(wq1.武器,wq1.级别)
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城")
	 战斗单位[2]={
		  名称="疯狂意识"
		  ,模型="画魂"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,开场发言="哈哈，有我们在，主人更疯狂！"
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城")
	 战斗单位[3]={
		  名称="疯狂意识"
		  ,模型="画魂"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,开场发言="哈哈，有我们在，主人更疯狂！"
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"五庄观")
	 战斗单位[4]={
		  名称="疯狂意识"
		  ,模型="阴阳伞"
		--  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,开场发言="哈哈，有我们在，主人更疯狂！"
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"五庄观")
	 战斗单位[5]={
		  名称="疯狂意识"
		  ,模型="阴阳伞"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,开场发言="哈哈，有我们在，主人更疯狂！"
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"神木林")
	 战斗单位[6]={
		  名称="切肤之痛"
		  ,模型="藤蔓妖花"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"神木林")
	 战斗单位[7]={
		  名称="切肤之痛"
		  ,模型="藤蔓妖花"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"神木林")
	 战斗单位[8]={
		  名称="切肤之痛"
		  ,模型="藤蔓妖花"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府")
	 战斗单位[9]={
		  名称="黯然神伤"
		  ,模型="夜罗刹"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府")
	 战斗单位[10]={
		  名称="黯然神伤"
		  ,模型="夜罗刹"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end

function 怪物属性:一斛珠官兵(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"大唐官府","物理")
	 战斗单位[1]={
		  名称="官兵"
		  ,模型="天兵"
		  ,开场发言="你小子找死#4"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1]) * 5
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"高级必杀"}
		  ,修炼 = {物抗=9,法抗=9,攻修=9}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end

function 怪物属性:一斛珠新郎沈唐(任务id,玩家id,序号)
	 local 战斗单位={}
	 local wq1={武器="星瀚",级别=160}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"大唐官府","物理")
	 战斗单位[1]={
		  名称="沈唐"
		  ,模型="逍遥生"
		  ,角色=true
		  ,武器=取武器数据(wq1.武器,wq1.级别)
		  -- ,开场发言="给你们的机会没有珍惜，那就只有打一场了。#14"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])* 1.5
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])* 1.5
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫")
	 战斗单位[2]={
		  名称="玉鳞蛟"
		  ,模型="蛟龙"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫")
	 战斗单位[3]={
		  名称="玉鳞蛟"
		  ,模型="蛟龙"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫")
	 战斗单位[4]={
		  名称="锦云蛟"
		  ,模型="蛟龙"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫")
	 战斗单位[5]={
		  名称="锦云蛟"
		  ,模型="蛟龙"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="珊瑚灵妖"
		  ,模型="曼珠沙华"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="珊瑚灵妖"
		  ,模型="曼珠沙华"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="珊瑚灵妖"
		  ,模型="曼珠沙华"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[9]={
		  名称="金藻傀儡"
		  ,模型="修罗傀儡鬼"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[10]={
		  名称="金藻傀儡"
		  ,模型="修罗傀儡鬼"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end

function 怪物属性:一斛珠夜影迷踪(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"龙宫")
	 战斗单位[1]={
		  名称="夜影迷踪"
		  ,模型="蛟龙"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 sx = self:取属性(等级,"凌波城")
	 战斗单位[2]={
		  名称="孤苦蚌精"
		  ,模型="蚌精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城")
	 战斗单位[3]={
		  名称="孤苦蚌精"
		  ,模型="蚌精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城")
	 战斗单位[4]={
		  名称="潦倒鲛人"
		  ,模型="鲛人"
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城")
	 战斗单位[5]={
		  名称="潦倒鲛人"
		  ,模型="鲛人"
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"凌波城")
	 战斗单位[6]={
		  名称="潦倒鲛人"
		  ,模型="鲛人"
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"凌波城")
	 战斗单位[7]={
		  名称="潦倒鲛人"
		  ,模型="鲛人"
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"凌波城")
	 战斗单位[8]={
		  名称="潦倒鲛人"
		  ,模型="鲛人"
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"凌波城")
	 战斗单位[9]={
		  名称="潦倒鲛人"
		  ,模型="鲛人"
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	  sx = self:取属性(等级,"凌波城")
	 战斗单位[10]={
		  名称="潦倒鲛人"
		  ,模型="鲛人"
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end

function 怪物属性:一斛珠沈唐(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"魔王寨")
	 战斗单位[1]={
		  名称="沈唐"
		  ,模型="鲛人"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城")
	 战斗单位[2]={
		  名称="悲歌"
		  ,模型="噬天虎"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城")
	 战斗单位[3]={
		  名称="悲歌"
		  ,模型="噬天虎"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城")
	 战斗单位[4]={
		  名称="欢喜"
		  ,模型="蚌精"
		  ,变异=true
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城")
	 战斗单位[5]={
		  名称="欢喜"
		  ,模型="蚌精"
		  ,变异=true
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[6]={
		  名称="沧浪之涛"
		  ,模型="混沌兽"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[7]={
		  名称="沧浪之涛"
		  ,模型="混沌兽"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[8]={
		  名称="沧浪之涛"
		  ,模型="混沌兽"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[9]={
		  名称="荒虚之悲"
		  ,模型="碧水夜叉"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[10]={
		  名称="荒虚之悲"
		  ,模型="碧水夜叉"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end
-----------------------------双城记
function 怪物属性:双城记黑衣人(任务id,玩家id,序号)
	 local 战斗单位={}
	 local wq1={武器="斩妖泣血",级别=120}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"大唐官府","物理")
	 战斗单位[1]={
		  名称="黑衣人"
		  ,模型="剑侠客"
		  ,角色=true
		  ,锦衣={{名称="夜影"}}
		  ,武器=取武器数据(wq1.武器,wq1.级别)
		  ,开场发言="你们几个后生真有够大胆，敢和我动手#24"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1]) * 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="宁府杂役"
		  ,模型="混沌兽"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
	--     ,门派=sx.门派
	--     ,AI战斗 = {AI=sx.智能}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="宁府杂役"
		  ,模型="混沌兽"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="宁府高手"
		  ,模型="葫芦宝贝"
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="宁府丫鬟"
		  ,模型="猫灵人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  --,开场发言="别打我们，否则主人会很可怕！"
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="高手喽罗"
		  ,模型="吸血鬼"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="高手喽罗"
		  ,模型="吸血鬼"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="高手喽罗"
		  ,模型="吸血鬼"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[9]={
		  名称="高手喽罗"
		  ,模型="吸血鬼"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[10]={
		  名称="高手喽罗"
		  ,模型="吸血鬼"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end

function 怪物属性:双城记木头人(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"大唐官府","物理")
	 战斗单位[1]={
		  名称="木头人甲"
		  ,模型="机关人人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="木头人乙"
		  ,模型="机关人人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
	--     ,门派=sx.门派
	--     ,AI战斗 = {AI=sx.智能}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="木头人丙"
		  ,模型="机关人人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="木头人丁"
		  ,模型="进阶连弩车"
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="木头人戊"
		  ,模型="进阶连弩车"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="训练假人"
		  ,模型="进阶机关兽"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="训练假人"
		  ,模型="进阶机关兽"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="训练假人"
		  ,模型="进阶机关兽"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[9]={
		  名称="训练假人"
		  ,模型="进阶机关兽"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[10]={
		  名称="训练假人"
		  ,模型="进阶机关兽"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end
function 怪物属性:双城记武教头(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"大唐官府","物理")
	 战斗单位[1]={
		  名称="武教头"
		  ,模型="犀牛将军人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="士兵"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
	--     ,门派=sx.门派
	--     ,AI战斗 = {AI=sx.智能}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="士兵"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="士兵"
		  ,模型="护卫"
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="士兵"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="士兵"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="士兵"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="士兵"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[9]={
		  名称="士兵"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,主动技能=sx.技能组
	 }
	  sx = self:取属性(等级)
	 战斗单位[10]={
		  名称="士兵"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end

function 怪物属性:双城记凌云瀚(任务id,玩家id,序号)
	 local 战斗单位={}
	 local wq1={武器="飞龙在天",级别=120}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"龙宫")
	 战斗单位[1]={
		  名称="凌云瀚"
		  ,模型="神天兵"
		  ,角色=true
		  ,锦衣={{名称="明光宝甲"}}
		  ,武器=取武器数据(wq1.武器,wq1.级别)
		  ,开场发言="不听话就打的你们听话#24"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="邪僻天师"
		  ,模型="猫灵人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
	--     ,门派=sx.门派
	--     ,AI战斗 = {AI=sx.智能}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="诡谲术士"
		  ,模型="葫芦宝贝"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="幽风杀手"
		  ,模型="混沌兽"
		  ,招式特效={翻江搅海=true}
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="骁勇兵丁"
		  ,模型="夜罗刹"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="蛮力护卫"
		  ,模型="狂豹人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="蛮力护卫"
		  ,模型="狂豹人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="蛮力护卫"
		  ,模型="狂豹人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[9]={
		  名称="蛮力护卫"
		  ,模型="狂豹人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[10]={
		  名称="蛮力护卫"
		  ,模型="狂豹人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end
function 怪物属性:双城记算筹子(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"女儿村","固伤")
	 战斗单位[1]={
		  名称="算筹子一"
		  ,模型="进阶连弩车"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="算筹子二"
		  ,模型="进阶连弩车"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="算筹子三"
		  ,模型="进阶连弩车"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[4]={
		  名称="算筹子四"
		  ,模型="进阶连弩车"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[5]={
		  名称="算筹子五"
		  ,模型="进阶连弩车"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="算筹子六"
		  ,模型="进阶连弩车"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="算筹子七"
		  ,模型="进阶连弩车"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="算筹子八"
		  ,模型="进阶连弩车"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[9]={
		  名称="算筹子九"
		  ,模型="进阶连弩车"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[10]={
		  名称="算筹子十"
		  ,模型="进阶连弩车"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,主动技能=sx.技能组
	 }
  return 战斗单位
end

function 怪物属性:双城记玄机之数(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"魔王寨")
	 战斗单位[1]={
		  名称="玄机之数"
		  ,模型="夜罗刹"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城")
	 战斗单位[2]={
		  名称="天元之秘"
		  ,模型="混沌兽"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城")
	 战斗单位[3]={
		  名称="天元之秘"
		  ,模型="混沌兽"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"五庄观")
	 战斗单位[4]={
		  名称="地元之厚"
		  ,模型="葫芦宝贝"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"方寸山")
	 战斗单位[5]={
		  名称="人元之灵"
		  ,模型="猫灵人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[6]={
		  名称="物元之烈"
		  ,模型="长眉灵猴"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[7]={
		  名称="物元之烈"
		  ,模型="长眉灵猴"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[8]={
		  名称="物元之烈"
		  ,模型="长眉灵猴"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[9]={
		  名称="物元之烈"
		  ,模型="长眉灵猴"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[10]={
		  名称="物元之烈"
		  ,模型="长眉灵猴"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

  return 战斗单位
end

function 怪物属性:双城记嗜血恶兽(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"凌波城")
	 战斗单位[1]={
		  名称="嗜血恶兽"
		  ,模型="百足将军"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫")
	 战斗单位[2]={
		  名称="食腐小虫"
		  ,模型="海毛虫"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫")
	 战斗单位[3]={
		  名称="食腐小虫"
		  ,模型="海毛虫"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫")
	 战斗单位[4]={
		  名称="食腐小虫"
		  ,模型="海毛虫"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫")
	 战斗单位[5]={
		  名称="食腐小虫"
		  ,模型="海毛虫"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫")
	 战斗单位[6]={
		  名称="食腐小虫"
		  ,模型="海毛虫"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫")
	 战斗单位[7]={
		  名称="食腐小虫"
		  ,模型="海毛虫"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫")
	 战斗单位[8]={
		  名称="食腐小虫"
		  ,模型="海毛虫"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫")
	 战斗单位[9]={
		  名称="食腐小虫"
		  ,模型="海毛虫"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫")
	 战斗单位[10]={
		  名称="食腐小虫"
		  ,模型="海毛虫"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end
function 怪物属性:双城记邪影僵尸(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[1]={
		  名称="邪影僵尸"
		  ,模型="僵尸"
		  ,变异=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府")
	 战斗单位[2]={
		  名称="冷血骷髅"
		  ,模型="骷髅怪"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府")
	 战斗单位[3]={
		  名称="冷血骷髅"
		  ,模型="骷髅怪"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府")
	 战斗单位[4]={
		  名称="冷血骷髅"
		  ,模型="骷髅怪"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府")
	 战斗单位[5]={
		  名称="冷血骷髅"
		  ,模型="骷髅怪"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府")
	 战斗单位[6]={
		  名称="冷血骷髅"
		  ,模型="骷髅怪"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府")
	 战斗单位[7]={
		  名称="冷血骷髅"
		  ,模型="骷髅怪"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府")
	 战斗单位[8]={
		  名称="冷血骷髅"
		  ,模型="骷髅怪"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府")
	 战斗单位[9]={
		  名称="冷血骷髅"
		  ,模型="骷髅怪"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"大唐官府")
	 战斗单位[10]={
		  名称="冷血骷髅"
		  ,模型="骷髅怪"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end

function 怪物属性:双城记宝库之门(任务id,玩家id,序号)
	 local 战斗单位={}
	 local wq1={武器="天龙破城",级别=150}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"龙宫")
	 战斗单位[1]={
		  名称="迷城祭祀"
		  ,模型="龙太子"
		  ,角色=true
		  ,锦衣={{名称="夜影"}}
		  ,武器=取武器数据(wq1.武器,wq1.级别)
		  ,开场发言="好久没有人踏足这片土地了"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }

	 local wq1={武器="秋水人家",级别=120}
	 sx = self:取属性(等级,"大唐官府")
	 战斗单位[2]={
		  名称="白骨之魅"
		  ,模型="逍遥生"
		  ,角色=true
		  ,锦衣={{名称="官服"}}
		  ,武器=取武器数据(wq1.武器,wq1.级别)
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 local wq1={武器="无关风月",级别=150}
	 sx = self:取属性(等级,"普陀山","辅助")
	 战斗单位[3]={
		  名称="阴风之影"
		  ,模型="舞天姬"
		  ,角色=true
		  ,武器=取武器数据(wq1.武器,wq1.级别)
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 local wq1={武器="碧血干戚",级别=150}
	 sx = self:取属性(等级,"魔王寨")
	 战斗单位[4]={
		  名称="狂怒之火"
		  ,模型="虎头怪"
		  ,角色=true
		  ,锦衣={{名称="明光宝甲"}}
		  ,武器=取武器数据(wq1.武器,wq1.级别)
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,修炼 = {物抗=3,法抗=3,攻修=0}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 local wq1={武器="业火三灾",级别=150}
	 sx = self:取属性(等级,"方寸山","法系")
	 战斗单位[5]={
		  名称="诅咒之器"
		  ,模型="剑侠客"
		  ,角色=true
		  ,等级=等级
		  ,武器=取武器数据(wq1.武器,wq1.级别)
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[5])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","物理")
	 战斗单位[6]={
		  名称="怪诞之力"
		  ,模型="狂豹人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[6])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[6])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","物理")
	 战斗单位[7]={
		  名称="怪诞之力"
		  ,模型="狂豹人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[7])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[7])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"阴曹地府","物理")
	 战斗单位[8]={
		  名称="怪诞之力"
		  ,模型="狂豹人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[8])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[8])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"天宫","法系")
	 战斗单位[9]={
		  名称="迷灵之影"
		  ,模型="混沌兽"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[9])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[9])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[9])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[9])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[9])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[9])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"天宫","法系")
	 战斗单位[10]={
		  名称="迷灵之影"
		  ,模型="混沌兽"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[10])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[10])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[10])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[10])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[10])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[10])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
  return 战斗单位
end

function 怪物属性:初出江湖(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 模型范围={"蟹将","虾兵","大海龟","海毛虫","巨蛙","海星","章鱼","小龙女","蛟龙","龟丞相"}
	 local 名称范围 = {"恍然","蛊惑","色诱","难辨"}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称="江湖骗子"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])* 2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称=名称范围[取随机数(1,#名称范围)]
				,模型=模型范围[取随机数(1,#模型范围)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])* 2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
  return 战斗单位
end

function 怪物属性:门派巡逻(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 for i=1,2 do
		  sx = self:取属性(等级)
		  local 模型=取随机怪(1,等级)
		  战斗单位[i]={
				名称="捣乱的"..模型[2]
				,模型=模型[2]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])* 2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:画魂夜叉召唤(等级,序号)
	 local sx = self:取属性(等级) --类型：固伤 辅助 物理 法系
	 local i=2
	 local 怪物类型={
	 {"画魂","画魂夜叉"},
	 {"幽萤娃娃","幽萤夜叉"}
	 }
	 local 随机结果 = 怪物类型[math.random(#怪物类型)]
	 local 召唤单位={
		  名称=随机结果[2]
		  ,模型=随机结果[1]
		  ,等级=等级
		  ,气血 = 10000--qz(sx.属性.气血 * QAQ[序号].气血系数[i])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 召唤单位
end


function 怪物属性:万年厉鬼夜叉召唤(等级,序号,变异)
	 local sx = self:取属性(等级) --类型：固伤 辅助 物理 法系
	 local i=2
	 if 变异 then
		  if 变异=="鬼将" then
				sx = self:取属性(等级,"狮驼岭","物理")
		  elseif 变异=="吸血鬼" then
				sx = self:取属性(等级,"阴曹地府","物理")
		  elseif 变异=="幽灵" then
				sx = self:取属性(等级,"凌波城","物理")
		  elseif 变异=="夜罗刹" then
				sx = self:取属性(等级,"狮驼岭")
		  elseif 变异=="炎魔神" then
				sx = self:取属性(等级,"龙宫")
		  end
		  local  召唤单位={
				名称="万年厉鬼"
				,模型=变异
				,等级=等级
				,变异=变异
				,气血 =10000--qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
		  return 召唤单位
	 else
		  local 怪物类型={"花妖","黑熊精","小龙女","小龙女","牛妖","蜘蛛精"}
		  local 随机结果 = 怪物类型[math.random(#怪物类型)]
		  local  召唤单位={
				名称="万年厉鬼"
				,模型=随机结果
				,等级=等级
				,气血 =10000--qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
		  return 召唤单位
	 end
end

function 怪物属性:携宝龙龟召唤(等级,序号,变异)
	 local sx = self:取属性(等级) --类型：固伤 辅助 物理 法系
	 local i=2
	 local mc="神气灵龟"
	 if 变异 then
		  mc="携宝灵龟"
	 end
	 local 召唤单位={
		  名称=mc
		  ,模型="龙龟"
		  ,等级=等级
		  ,变异=变异
		  ,气血 = 10000--qz(sx.属性.气血 * QAQ[序号].气血系数[i])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 return 召唤单位
end

function 怪物属性:新手活动怪(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,self:取随机物理门派())
	 local 临时类型 = 任务数据[任务id].夜叉小怪
	 if 临时类型 == "泡泡" then
		  local 怪物类型={
		  {"泡泡","泡泡"},
		  {"泡泡","泡泡"}
		  }
		  战斗单位[1]={
				名称="超级泡泡"
				,模型="超级泡泡"
				,开场发言="交个朋友吧"
				,等级=等级
				,主怪=true
				,不可封印=true
				,气血 = qz(sx.属性.气血) *3
				,伤害 = qz(sx.属性.伤害 )
				,法伤 = qz(sx.属性.法伤 )
				,速度 = qz(sx.属性.速度 )
				,固定伤害 = qz(等级)
				,治疗能力 = qz(等级)
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				,类型=临时类型
		  }
		  for i=2,10 do
				local 随机结果 = 怪物类型[math.random(#怪物类型)]
				sx = self:取属性(等级)
				 战斗单位[i]={
				 名称=随机结果[2]
				,模型=随机结果[1]
				,等级=等级
				,气血 = qz(sx.属性.气血)*3
				,伤害 = qz(sx.属性.伤害 )
				,法伤 = qz(sx.属性.法伤 )
				,速度 = qz(sx.属性.速度 )
				,固定伤害 = qz(等级)
				,治疗能力 = qz(等级)
				,技能={"感知"}
			    ,主动技能=sx.技能组
				}
		  end
	 end
	 return 战斗单位
end

function 怪物属性:梦魇夜叉(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,self:取随机物理门派())
	 local 临时类型 = 任务数据[任务id].夜叉小怪
	 if 临时类型 == "画魂" then
		  local 怪物类型={
		  {"画魂","画魂夜叉"},
		  {"幽萤娃娃","幽萤夜叉"}
		  }
		  战斗单位[1]={
				名称="梦魇夜叉"
				,模型="夜罗刹"
				,开场发言="有本事就吧喽啰换成同一种类型#28"
				,等级=等级
				,变异=true
				,主怪=true
				,不可封印=true
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
				,类型=临时类型
		  }
		  for i=2,10 do
				local 随机结果 = 怪物类型[math.random(#怪物类型)]
				sx = self:取属性(等级)
				战斗单位[i]={
					 名称=随机结果[2]
					 ,模型=随机结果[1]
					 ,等级=等级
					 ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
					 ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
					 ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
					 ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
					 ,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
					 ,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
					 ,技能={"感知"}
					 ,主动技能=sx.技能组
				}
		  end
	 elseif 临时类型 =="厉鬼" then
				local 怪物类型={"花妖","黑熊精","小龙女","牛妖"}
				战斗单位[1]={
					 名称="梦魇夜叉"
					 ,模型="夜罗刹"
					 ,开场发言="厉害#35今天真是遇到克星了#52"
					 ,等级=等级
					 ,变异=true
					 ,主怪=true
					 ,不可封印=true
					 ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
					 ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
					 ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
					 ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
					 ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
					 ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
					 ,门派=sx.门派
					 ,AI战斗 = {AI=sx.智能}
					 ,类型=临时类型
				}
				for i=2,10 do
					 sx = self:取属性(等级)
					 战斗单位[i]={
					 名称="万年厉鬼"
					 ,模型=怪物类型[math.random(#怪物类型)]
					 ,等级=等级
					 ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
					 ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
					 ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
					 ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
					 ,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
					 ,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
					 ,技能={"感知"}
					 ,主动技能=sx.技能组
					 }
				end
	 elseif 临时类型 =="龙龟" then
				战斗单位[1]={
					 名称="梦魇夜叉"
					 ,模型="夜罗刹"
					 ,开场发言="带有宝贝的不要露脸了，小心宝贝被他们抢走！#47"
					 ,等级=等级
					 ,变异=true
					 ,主怪=true
					 ,不可封印=true
					 ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
					 ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
					 ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
					 ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
					 ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
					 ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
					 ,门派=sx.门派
					 ,AI战斗 = {AI=sx.智能}
					 ,类型=临时类型
				}
				for i=2,6 do
					 sx = self:取属性(等级)
					 战斗单位[i]={
						  名称="神气灵龟"
						  ,模型="龙龟"
						  ,等级=等级
						  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
						  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
						  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
						  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
						  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
						  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
						  ,技能={"感知"}
						  ,主动技能=sx.技能组	}
			end
	 end
	 return 战斗单位
end

function 怪物属性:抓鬼任务(任务id,玩家id,序号)
	 local 血量加成=1.2
	 local 法伤减少=1
	 local 物伤减少=1
	 local 躲避减少=0
	 if 任务数据[任务id].模型=="马面" then
		  物伤减少=1.5
		  法伤减少=0.4
	 elseif 任务数据[任务id].模型=="牛头" then
		  物伤减少=0.4
	 elseif 任务数据[任务id].模型=="野鬼" then
		  物伤减少=0.2
		  法伤减少=0.2
		  血量加成=0.2
	 elseif 任务数据[任务id].模型=="骷髅怪" then
		  物伤减少=1.2
		  法伤减少=1.2
		  血量加成=1.8
		  躲避减少=30
	 elseif 任务数据[任务id].模型=="僵尸" then
		  血量加成=3
	 end
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 数量=取随机数(5,8)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1] * 血量加成)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,躲避减少=躲避减少
		  ,物伤减少=物伤减少
		  ,法伤减少=法伤减少
		  ,技能={"感知","高级鬼魂术"}
		  ,主动技能=sx.技能组
	 }
	 for i=2,数量 do
		  sx = self:取属性(等级)
		  local 模型=取随机怪(等级-10,等级)
		  战斗单位[i]={
				名称=模型[2].."恶鬼"
				,模型=模型[2]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 if 取随机数()<=2 then
		  战斗单位[#战斗单位]={
				名称="善良的"..任务数据[任务id].模型
				,模型=任务数据[任务id].模型
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
				,技能={"感知","高级鬼魂术"}
				-- ,主动技能={"破血狂攻"}
				-- ,门派=sx.门派
				,变异=true
				,特殊变异=true
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:自动抓鬼(任务id,玩家id,序号)
	local 血量加成=1.2
	local 法伤减少=1
	local 物伤减少=1
	local 躲避减少=0
	local 随机数据 = 取随机数(1,100)
	local mx
	if 随机数据 <= 20 then
		mx = "马面"
		物伤减少=1.5
		法伤减少=0.4
	elseif 随机数据 <= 40 then
		mx = "牛头"
		物伤减少=0.4
	elseif 随机数据 <= 60 then
		mx = "野鬼"
		物伤减少=0.2
		法伤减少=0.2
		血量加成=0.2
	elseif 随机数据 <= 80 then
		mx = "骷髅怪"
		物伤减少=1.2
		法伤减少=1.2
		血量加成=1.8
		躲避减少=30
	else
		mx = "僵尸"
		血量加成=3
	end

	local 战斗单位={}
	local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	local 数量=取随机数(6,10)
	local sx = self:取属性(等级)
	战斗单位[1]={
		名称="轮回鬼王"
		,模型=mx
		,等级=等级
		,气血 = qz(sx.属性.气血 * QAQ[100008].气血系数[1] * 血量加成)*1.2
		,伤害 = qz(sx.属性.伤害 * QAQ[100008].伤害系数[1])
		,法伤 = qz(sx.属性.法伤 * QAQ[100008].法伤系数[1])
		,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[100008].速度系数[1])
		,固定伤害 = qz(等级*QAQ[100008].固伤系数[1])
		,治疗能力 = qz(等级*QAQ[100008].治疗系数[1])
		,躲避减少=躲避减少
		,物伤减少=物伤减少
		,法伤减少=法伤减少
		,技能={"感知","高级飞行"}
		,主动技能=sx.技能组
	}
	for i=2,数量 do
		sx = self:取属性(等级)
		local 模型=取随机怪(等级-10,等级)
		战斗单位[i]={
		名称=模型[2].."恶鬼"
		,模型=模型[2]
		,等级=等级
		,气血 = qz(sx.属性.气血 * QAQ[100008].气血系数[i])*1.2
		,伤害 = qz(sx.属性.伤害 * QAQ[100008].伤害系数[i])
		,法伤 = qz(sx.属性.法伤 * QAQ[100008].法伤系数[i])
		,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[100008].速度系数[i])
		,固定伤害 = qz(等级*QAQ[100008].固伤系数[i])
		,治疗能力 = qz(等级*QAQ[100008].治疗系数[i])
		,技能={"感知"}
		,主动技能=sx.技能组
	}
	end
	 return 战斗单位
end

function 怪物属性:鬼王任务(任务id,玩家id,序号)
	 local 血量加成=1.5
	 local 法伤减少=1
	 local 物伤减少=1
	 local 躲避减少=0
	 local 小鬼加成= 0.7
	 local 鬼王名称 = 任务数据[任务id].名称
	 local 小鬼名称 = "厉鬼帮凶"
	 local 万年厉鬼 = 任务数据[任务id].万年厉鬼
	 local mp
	 if 任务数据[任务id].模型=="幽灵" or 任务数据[任务id].模型=="进阶幽灵" then
		  mp=self:取随机物理门派()
		  血量加成=1.5
		  躲避减少=30
	 elseif 任务数据[任务id].模型=="夜罗刹" or 任务数据[任务id].模型=="进阶夜罗刹" then
		  mp=self:取随机法系门派()
		  法伤减少=0.5
	 elseif 任务数据[任务id].模型=="进阶炎魔神" or 任务数据[任务id].模型=="炎魔神" then
		  mp=self:取随机法系门派()
		  物伤减少=0.7
		  法伤减少=0.8 --大于1就是挨打伤害增加，小于则减少
		  血量加成=0.7
	 elseif 任务数据[任务id].模型=="进阶鬼将" or 任务数据[任务id].模型=="鬼将" then
		  mp=self:取随机物理门派()
		  物伤减少=0.8
		  血量加成=1.2
	 elseif 任务数据[任务id].模型=="进阶吸血鬼" or 任务数据[任务id].模型=="吸血鬼" then
		  mp=self:取随机物理门派()
		  血量加成=2
	 end
	 if 万年厉鬼 then
		  鬼王名称 ="万年"..任务数据[任务id].模型
		  血量加成=血量加成+1
		  小鬼名称 = "万年厉鬼"
		  小鬼加成=1.5
	 end
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 数量=取随机数(6,8)
	 local sx = self:取属性(等级,mp)
	 战斗单位[1]={
		  名称=鬼王名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1] * 血量加成)
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1] * 法伤削弱)
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,躲避减少=躲避减少
		  ,物伤减少=物伤减少
		  ,法伤减少=法伤减少
		  ,技能={"感知","高级鬼魂术"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,数量 do
		  sx = self:取属性(等级)
		  local 模型=取随机怪(等级,等级+10)
		  战斗单位[i]={
				名称=小鬼名称
				,模型=模型[2]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i]*小鬼加成)
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i] * 法伤削弱)
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:取门派闯关信息(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local menpai=Q_门派编号[任务数据[任务id].序列]
	 local AI流派
	 if menpai=="化生寺" then
		  AI流派={"法系","法系","辅助"}
	 elseif menpai=="普陀山" then
		  AI流派={"固伤","固伤","辅助"}
	 elseif menpai=="无底洞" then
		  AI流派={"固伤","固伤","辅助"}
	 elseif menpai=="方寸山" then
		  AI流派={"法系","法系","封系"}
	 elseif menpai=="女儿村" then
		  AI流派={"物理","封系","固伤","固伤"}
	 elseif menpai=="盘丝洞" then
		  AI流派={"物理","封系","固伤"}
	 elseif menpai=="天宫" then
		  AI流派={"法系","法系","物理","封系"}
	 elseif menpai=="五庄观" then
		  AI流派={"物理","封系","物理"}
	 elseif menpai=="龙宫" or menpai=="魔王寨" or menpai=="神木林" then
		  AI流派={"法系"}
	 elseif menpai=="阴曹地府" then
		  AI流派={"物理","物理","固伤"}
	 else
		  AI流派={"物理"}
	 end

	 local lp = AI流派[取随机数(1,#AI流派)]
	 local sx = self:取属性(等级,menpai,lp)

	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,武器 = 取武器数据(任务数据[任务id].武器,120)
		  ,角色=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=lp}
	 }
	 for i=2,5 do
		  lp = AI流派[取随机数(1,#AI流派)]
		  sx = self:取属性(等级,menpai,lp)
		  战斗单位[i]={
				名称=menpai.."护卫"
				,模型=Q_闯关数据[menpai].弟子[取随机数(1,#Q_闯关数据[menpai].弟子)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,门派=sx.门派
				,AI战斗 = {AI=lp}
		  }
	 end
	 for i=6,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称=menpai.."护卫"
				,模型=Q_闯关数据[menpai].弟子[取随机数(1,#Q_闯关数据[menpai].弟子)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:取游泳信息(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 模型范围={"雪月蛙","天机虫","金乌火虫","食魂虫(日)","食魂虫(夜)","金乌月光虫"}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 数量=5+取队伍人数(玩家id)
	 if 数量>=10 then
		  数量=10
	 end
	 for i=1,数量 do
		  local sx = self:取属性(等级)
		  战斗单位[i]={
				名称="捣乱的水妖"
				,模型=模型范围[取随机数(1,#模型范围)]
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:取镖王信息(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 模型范围={"强盗","山贼"}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 数量=5+取队伍人数(玩家id)
	 if 数量>=10 then
		  数量=10
	 end
	 for i=1,数量 do
		  local sx = self:取属性(等级)
		  战斗单位[i]={
				名称="拦路的强盗"
				,模型=模型范围[取随机数(1,#模型范围)]
				,等级=等级
				,气血 = 5000
				,伤害 = 1200
				,法伤 = 999
				,速度 = 200
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end
function 怪物属性:乌鸡芭蕉木妖(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx
	 for i=1,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="芭蕉木妖"
				,模型="树怪"
				,等级=等级
				,变异=true
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 for i=6,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="伙伴木妖"
				,模型="树怪"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:乌鸡三妖(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型="地狱战神"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[2]={
		  名称="魔族勇将"
		  ,模型="牛妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[3]={
		  名称="人族勇将"
		  ,模型="强盗"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=4,8 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="喽啰"
				,模型="山贼"
				,等级=等级
				,变异=true
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:乌鸡鬼祟小怪(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local mc={"鬼祟小怪","鬼祟小妖"}
	 local sx
	 for i=1,6 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称=mc[取随机数(1,#mc)]
				,模型="兔子怪"
				,等级=等级
				,躲避减少=100
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:乌鸡国王(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"化生寺","辅助")
	 战斗单位[1]={
		  名称="乌鸡国王"
		  ,模型="逍遥生"
		  ,等级=等级
		  ,角色=true
		  ,锦衣={{名称="化圣"}}
		  ,武器={名称="神火扇",级别限制=60,子类=7}
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,门派={"化生寺"}
		  ,AI战斗 = {AI="法系"}
	 }
	 for i=2,5 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="护卫"
				,模型="天兵"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级)
	 战斗单位[6]={
		  名称="缚仙妖怪"
		  ,模型="地狱战神"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[6])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[6])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[6])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[6])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[7]={
		  名称="拘灵妖怪"
		  ,模型="地狱战神"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[7])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[7])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[7])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[7])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 sx = self:取属性(等级)
	 战斗单位[8]={
		  名称="囚神妖怪"
		  ,模型="地狱战神"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[8])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[8])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[8])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[8])
		  ,技能={"感知"}
		  ,主动技能=sx.技能组
	 }
	 for i=9,10 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="兔子怪"
				,模型="兔子怪"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,技能={"感知"}
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:投放怪_小钻风(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 模型范围={"蛤蟆精","蜘蛛精","老虎","雷鸟人","大蝙蝠","野猪","雷鸟人","骷髅怪","黑熊","黑熊精"}
	 local sx = self:取属性(等级,"狮驼岭")
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,气血 = qz(等级*55)+8000
		  ,伤害 = qz(等级*10)+400
		  ,法伤 = qz(等级*10)+200
		  ,速度 = qz(等级*4)
		  ,门派={"狮驼岭"}
		  ,AI战斗 = {AI="物理"}
	 }
	 for i=2,4 do
		  sx = self:取属性(等级)
		  local 模型=模型范围[取随机数(1,#模型范围)]
		  战斗单位[i]={
				名称=模型.."喽罗"
				,模型=模型
				,等级=等级
                ,气血 = qz(等级*45)+5000
		        ,伤害 = qz(等级*10)+400
		        ,法伤 = qz(等级*10)+200
		        ,速度 = qz(等级*4)
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[5]={
		  名称="狐狸精"
		  ,模型="狐狸精"
		  ,变异=true
		  ,等级=等级
          ,气血 = qz(等级*45)+5000
	      ,伤害 = qz(等级*10)+400
		  ,法伤 = qz(等级*10)+200
		  ,速度 = qz(等级*4)
		  ,主动技能={"失心符"}
	 }
	 for i=6,10 do
		  sx = self:取属性(等级)
		  local 模型=模型范围[取随机数(1,#模型范围)]
		  战斗单位[i]={
				名称=模型.."喽罗"
				,模型=模型
				,等级=等级
                ,气血 = qz(等级*45)+5000
		        ,伤害 = qz(等级*10)+400
		        ,法伤 = qz(等级*10)+200
		        ,速度 = qz(等级*4)
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:投放怪_奔波儿灞(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 模型范围={"小龙女","虾兵","蟹将","巨蛙","大海龟","海毛虫"}
	 local sx = self:取属性(等级,"龙宫")
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,气血 = qz(等级*55)+8000
		  ,伤害 = qz(等级*10)+400
		  ,法伤 = qz(等级*10)+200
		  ,速度 = qz(等级*4)
		  ,门派={"龙宫"}
		  ,AI战斗 = {AI="法系"}
	 }
	 for i=2,4 do
		  sx = self:取属性(等级)
		  local 模型=模型范围[取随机数(1,#模型范围)]
		  战斗单位[i]={
				名称=模型.."喽罗"
				,模型=模型
				,等级=等级
                ,气血 = qz(等级*45)+5000
		        ,伤害 = qz(等级*10)+400
		        ,法伤 = qz(等级*10)+200
		        ,速度 = qz(等级*4)
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[5]={
		  名称="狐狸精"
		  ,模型="狐狸精"
		  ,变异=true
		  ,等级=等级
                ,气血 = qz(等级*45)+5000
		        ,伤害 = qz(等级*10)+400
		        ,法伤 = qz(等级*10)+200
		        ,速度 = qz(等级*4)
		  ,主动技能={"失心符"}
	 }
	 for i=6,10 do
		  sx = self:取属性(等级)
		  local 模型=模型范围[取随机数(1,#模型范围)]
		  战斗单位[i]={
				名称=模型.."喽罗"
				,模型=模型
				,等级=等级
                ,气血 = qz(等级*45)+5000
		        ,伤害 = qz(等级*10)+400
		        ,法伤 = qz(等级*10)+200
		        ,速度 = qz(等级*4)
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:投放怪_其它小怪(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local 模型范围={"蛤蟆精","蜘蛛精","老虎","巨蛙","大海龟","大蝙蝠","野猪","海毛虫","骷髅怪","黑熊","黑熊精"}
	 local sx = self:取属性(等级)
	 战斗单位[1]={
		  名称=任务数据[任务id].名称
		  ,模型=任务数据[任务id].模型
		  ,等级=等级
		  ,气血 = qz(等级*55)+8000
		  ,伤害 = qz(等级*10)+400
		  ,法伤 = qz(等级*10)+200
		  ,速度 = qz(等级*4)
		  ,主动技能=sx.技能组
	 }
	 for i=2,4 do
		  sx = self:取属性(等级)
		  local 模型=模型范围[取随机数(1,#模型范围)]
		  战斗单位[i]={
				名称=模型.."喽罗"
				,模型=模型
				,等级=等级
                ,气血 = qz(等级*45)+5000
		        ,伤害 = qz(等级*10)+400
		        ,法伤 = qz(等级*10)+200
		        ,速度 = qz(等级*4)
				,主动技能=sx.技能组
		  }
	 end
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[5]={
		  名称="狐狸精"
		  ,模型="狐狸精"
		  ,变异=true
		  ,等级=等级
          ,气血 = qz(等级*45)+5000
          ,伤害 = qz(等级*10)+400
		  ,法伤 = qz(等级*10)+200
		  ,速度 = qz(等级*4)
		  ,主动技能={"失心符"}
	 }
	 for i=6,10 do
		  sx = self:取属性(等级)
		  local 模型=模型范围[取随机数(1,#模型范围)]
		  战斗单位[i]={
				名称=模型.."喽罗"
				,模型=模型
				,等级=等级
                ,气血 = qz(等级*45)+5000
		        ,伤害 = qz(等级*10)+400
		        ,法伤 = qz(等级*10)+200
		        ,速度 = qz(等级*4)
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:投放怪_白骨精(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,nil,"物理")
	 战斗单位[1]={
		  名称="白骨精"
		  ,模型="进阶蝎子精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能={"百爪狂杀"}
	 }
	 sx = self:取属性(等级,nil,"固伤")
	 战斗单位[2]={
		  名称="锦毛貂精"
		  ,模型="进阶锦毛貂精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,主动技能={"天罗地网"}
	 }
	 sx = self:取属性(等级,nil,"固伤")
	 战斗单位[3]={
		  名称="锦毛貂精"
		  ,模型="进阶锦毛貂精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[3])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[3])
		  ,技能={"感知"}
		  ,主动技能={"天罗地网"}
	 }
	 sx = self:取属性(等级,nil,"固伤")
	 战斗单位[4]={
		  名称="蚌精"
		  ,模型="进阶蚌精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[4])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[4])
		  ,技能={"感知"}
		  ,主动技能={"天罗地网"}
	 }
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[5]={
		  名称="狐狸精"
		  ,模型="狐狸精"
		  ,等级=等级
		  ,变异=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,技能={"感知"}
		  ,主动技能={"含情脉脉"}
	 }
	 local 模型范围={"进阶地狱战神","百足将军","踏云兽","千年蛇魅","吸血鬼"}
	 for i=6,10 do
		  sx = self:取属性(等级)
		  local 模型=模型范围[取随机数(1,#模型范围)]
		  战斗单位[i]={
				名称=模型.."喽罗"
				,模型=模型
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:投放怪_大大王(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[1]={
		  名称="青毛狮子分身"
		  ,模型="大大王"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[2]={
		  名称="左护法"
		  ,模型="进阶古代瑞兽"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[3]={
		  名称="右护法"
		  ,模型="进阶古代瑞兽"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[4]={
		  名称="云游火"
		  ,模型="进阶云游火"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[5]={
		  名称="修罗"
		  ,模型="进阶修罗傀儡妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,技能={"感知"}
		  ,主动技能={"含情脉脉"}
	 }
	 local 模型范围={"进阶地狱战神","进阶黑山老妖","进阶修罗傀儡鬼","进阶修罗傀儡鬼"}
	 for i=6,10 do
		  sx = self:取属性(等级)
		  local 模型=模型范围[取随机数(1,#模型范围)]
		  战斗单位[i]={
				名称="深山老妖"
				,模型=模型
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:投放怪_二大王(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[1]={
		  名称="白象精分身"
		  ,模型="新二大王"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[2]={
		  名称="左护法"
		  ,模型="超级大象"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[3]={
		  名称="右护法"
		  ,模型="超级大象"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[4]={
		  名称="犀牛将军"
		  ,模型="犀牛将军人形"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[5]={
		  名称="修罗"
		  ,模型="进阶修罗傀儡妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,技能={"感知"}
		  ,主动技能={"含情脉脉"}
	 }
	 local 模型范围={"进阶地狱战神","进阶黑山老妖","进阶修罗傀儡鬼","进阶修罗傀儡鬼"}
	 for i=6,10 do
		  sx = self:取属性(等级)
		  local 模型=模型范围[取随机数(1,#模型范围)]
		  战斗单位[i]={
				名称="深山老妖"
				,模型=模型
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:投放怪_三大王(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[1]={
		  名称="金翅大鹏雕分身"
		  ,模型="进阶超级大鹏"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[2]={
		  名称="左护法"
		  ,模型="进阶雷鸟人"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[3]={
		  名称="右护法"
		  ,模型="进阶雷鸟人"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"狮驼岭","物理")
	 战斗单位[4]={
		  名称="真陀护法"
		  ,模型="真陀护法"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[5]={
		  名称="修罗"
		  ,模型="进阶修罗傀儡妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,技能={"感知"}
		  ,主动技能={"含情脉脉"}
	 }
	 local 模型范围={"进阶地狱战神","进阶黑山老妖","进阶修罗傀儡鬼","进阶修罗傀儡鬼"}
	 for i=6,10 do
		  sx = self:取属性(等级)
		  local 模型=模型范围[取随机数(1,#模型范围)]
		  战斗单位[i]={
				名称="深山老妖"
				,模型=模型
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:投放怪_冒牌小白龙(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"龙宫","法系")
	 战斗单位[1]={
		  名称="冒牌小白龙"
		  ,模型="龙马"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])*0.8
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"化生寺","辅助")
	 战斗单位[2]={
		  名称="冒牌唐僧"
		  ,模型="雨师"
		  ,等级=等级
		  ,角色=true
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])*0.8
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫","法系")
	 战斗单位[3]={
		  名称="蛟龙喽罗"
		  ,模型="蛟龙"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])*0.8
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫","法系")
	 战斗单位[4]={
		  名称="蛟龙喽罗"
		  ,模型="蛟龙"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])*0.8
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[5]={
		  名称="蝴蝶仙子喽罗"
		  ,模型="蝴蝶仙子"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])*0.8
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,技能={"感知"}
		  ,主动技能={"含情脉脉","失心符","错乱"}
	 }
	 local 模型范围={"蛟龙","进阶地狱战神","蛟龙","龟丞相","碧水夜叉"}
	 for i=6,10 do
		  sx = self:取属性(等级)
		  local 模型=模型范围[取随机数(1,#模型范围)]
		  战斗单位[i]={
				名称=模型.."喽罗"
				,模型=模型
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])*0.8
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:投放怪_冒牌沙僧(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[1]={
		  名称="冒牌沙僧"
		  ,模型="沙和尚"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"化生寺","辅助")
	 战斗单位[2]={
		  名称="冒牌唐僧"
		  ,模型="雨师"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫","法系")
	 战斗单位[3]={
		  名称="冒牌小白龙"
		  ,模型="龙马"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	sx = self:取属性(等级,"龙宫","法系")
	 战斗单位[4]={
		  名称="蛟龙喽罗"
		  ,模型="蛟龙"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[5]={
		  名称="蝴蝶仙子喽罗"
		  ,模型="蝴蝶仙子"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,技能={"感知"}
		  ,主动技能={"含情脉脉","失心符","错乱"}
	 }
	 local 模型范围={"蛟龙","进阶地狱战神","蛟龙","龟丞相","碧水夜叉"}
	 for i=6,10 do
		  sx = self:取属性(等级)
		  local 模型=模型范围[取随机数(1,#模型范围)]
		  战斗单位[i]={
				名称=模型.."喽罗"
				,模型=模型
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:投放怪_冒牌猪八戒(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"凌波城","物理")
	 战斗单位[1]={
		  名称="冒牌猪八戒"
		  ,模型="新猪八戒"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"化生寺","辅助")
	 战斗单位[2]={
		  名称="冒牌唐僧"
		  ,模型="雨师"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫","法系")
	 战斗单位[3]={
		  名称="冒牌小白龙"
		  ,模型="龙马"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[4]={
		  名称="冒牌沙僧"
		  ,模型="沙和尚"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[5]={
		  名称="蝴蝶仙子喽罗"
		  ,模型="蝴蝶仙子"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,技能={"感知"}
		  ,主动技能={"含情脉脉","失心符","错乱"}
	 }
	 local 模型范围={"进阶黑山老妖","进阶地狱战神","百足将军","进阶百足将军","进阶野猪精"}
	 for i=6,10 do
		  sx = self:取属性(等级)
		  local 模型=模型范围[取随机数(1,#模型范围)]
		  战斗单位[i]={
				名称=模型.."喽罗"
				,模型=模型
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:投放怪_冒牌大圣(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,nil,"物理")
	 战斗单位[1]={
		  名称="冒牌大圣"
		  ,模型="孙悟空"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能={"当头一棒","神针撼海","杀威铁棒","泼天乱棒","破血狂攻","破碎无双"}
	 }
	 sx = self:取属性(等级,"化生寺","辅助")
	 战斗单位[2]={
		  名称="冒牌唐僧"
		  ,模型="雨师"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫","法系")
	 战斗单位[3]={
		  名称="冒牌小白龙"
		  ,模型="龙马"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[4]={
		  名称="冒牌沙僧"
		  ,模型="沙和尚"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	sx = self:取属性(等级,"凌波城","物理")
	 战斗单位[5]={
		  名称="冒牌猪八戒"
		  ,模型="新猪八戒"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 local 模型范围={"进阶黑山老妖","进阶地狱战神","长眉灵猴","进阶百足将军","长眉灵猴"}
	 for i=6,10 do
		  sx = self:取属性(等级)
		  local 模型=模型范围[取随机数(1,#模型范围)]
		  战斗单位[i]={
				名称=模型.."喽罗"
				,模型=模型
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:投放怪_冒牌唐僧(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,"化生寺","辅助")
	 战斗单位[1]={
		  名称="冒牌唐僧"
		  ,模型="进阶雨师"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,nil,"物理")
	 战斗单位[2]={
		  名称="冒牌大圣"
		  ,模型="孙悟空"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,主动技能={"当头一棒","神针撼海","杀威铁棒","泼天乱棒","破血狂攻","破碎无双"}
	 }
	 sx = self:取属性(等级,"龙宫","法系")
	 战斗单位[3]={
		  名称="冒牌小白龙"
		  ,模型="龙马"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[4]={
		  名称="冒牌沙僧"
		  ,模型="沙和尚"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx =self:取属性(等级,"凌波城","物理")
	 战斗单位[5]={
		  名称="冒牌猪八戒"
		  ,模型="新猪八戒"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 local 模型范围={"进阶黑山老妖","进阶地狱战神","雨师","进阶百足将军","雨师"}
	 for i=6,10 do
		  sx = self:取属性(等级)
		  local 模型=模型范围[取随机数(1,#模型范围)]
		  战斗单位[i]={
				名称=模型.."喽罗"
				,模型=模型
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:投放怪_六耳猕猴(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,nil,"物理")
	 战斗单位[1]={
		  名称="冒牌大圣"
		  ,模型="超级六耳猕猴"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能={"当头一棒","神针撼海","杀威铁棒","泼天乱棒","破血狂攻","破碎无双"}
	 }
	 sx = self:取属性(等级,"化生寺","辅助")
	 战斗单位[2]={
		  名称="冒牌唐僧"
		  ,模型="雨师"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫","法系")
	 战斗单位[3]={
		  名称="冒牌小白龙"
		  ,模型="龙马"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[4]={
		  名称="冒牌沙僧"
		  ,模型="沙和尚"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx =self:取属性(等级,"凌波城","物理")
	 战斗单位[5]={
		  名称="冒牌猪八戒"
		  ,模型="新猪八戒"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 local 模型范围={"超级六耳猕猴","超级金猴","超级神猴","长眉灵猴"}
	 for i=6,10 do
		  sx = self:取属性(等级)
		  local 模型=模型范围[取随机数(1,#模型范围)]
		  战斗单位[i]={
				名称="猴子猴孙喽罗"
				,模型=模型
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:投放怪_是俺老孙(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=取队伍最高等级数(玩家数据[玩家id].队伍,玩家id)
	 local sx = self:取属性(等级,nil,"物理")
	 战斗单位[1]={
		  名称="是俺老孙"
		  ,模型="新孙悟空"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,技能={"感知"}
		  ,主动技能={"当头一棒","神针撼海","杀威铁棒","泼天乱棒","破血狂攻","破碎无双"}
	 }
	 sx = self:取属性(等级,"化生寺","辅助")
	 战斗单位[2]={
		  名称="唐僧"
		  ,模型="进阶雨师"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"龙宫","法系")
	 战斗单位[3]={
		  名称="小白龙"
		  ,模型="龙马"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[3])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[3])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[3])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[3])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"魔王寨","法系")
	 战斗单位[4]={
		  名称="沙悟净"
		  ,模型="沙和尚"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[4])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[4])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[4])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[4])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 sx = self:取属性(等级,"凌波城","物理")
	 战斗单位[5]={
		  名称="猪八戒"
		  ,模型="新猪八戒"
		  ,角色=true
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[5])*2
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[5])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[5])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[5])
		  ,技能={"感知"}
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 local 模型范围={"超级六耳猕猴","超级金猴","超级六耳猕猴","长眉灵猴"}
	 for i=6,10 do
		  sx = self:取属性(等级)
		  local 模型=模型范围[取随机数(1,#模型范围)]
		  战斗单位[i]={
				名称="猴毛"
				,模型=模型
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])*2
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:桃源村一别野猪(任务id,玩家id,序号)
  local 战斗单位={}
  local 等级=10
  战斗单位[1]={名称="野猪",模型="野猪",伤害=40,法伤=20,法防=0,气血=300,速度=等级,防御=0,等级=等级,AI战斗={回合=3,指令="逃跑"},技能={},主动技能={"泰山压顶"}}
  return 战斗单位
end

function 怪物属性:桃源村一别狸(任务id,玩家id,序号)
  local 战斗单位={}
  local 等级=10
  战斗单位[1]={名称="狸",模型="狸",开场发言="点击捕捉按钮，将我带回家吧#119",伤害=40,法伤=20,法防=0,气血=400,速度=等级,防御=0,可捕捉=true,等级=等级,技能={},主动技能={}}
  return 战斗单位
end

function 怪物属性:白鹿精(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=25
	 local sx = self:取属性(等级,nil,"物理")
	 战斗单位[1]={
		  名称="白鹿精"
		  ,模型="赌徒"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={}
		  ,主动技能={}
	 }
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[2]={
		  名称="花妖喽罗"
		  ,模型="花妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,主动技能=取随机封印(1)
	 }
	 for i=3,4 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="花妖喽罗"
				,模型="花妖"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:玉面狐狸(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=25
	 local sx = self:取属性(等级,nil,"物理")
	 战斗单位[1]={
		  名称="玉面狐狸"
		  ,模型="狐狸精"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={}
		  ,主动技能={}
	 }
	 sx = self:取属性(等级,nil,"封系")
	 战斗单位[2]={
		  名称="花妖喽罗"
		  ,模型="花妖"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[2])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[2])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[2])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[2])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[2])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[2])
		  ,主动技能=取随机封印(1)
	 }
	 for i=3,4 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="花妖喽罗"
				,模型="花妖"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:酒肉和尚1(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=25
	 local sx = self:取属性(等级,nil,"法系")
	 战斗单位[1]={
		  名称="酒肉和尚"
		  ,模型="雨师"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={}
		  ,主动技能={"唧唧歪歪"}
	 }
	 for i=2,4 do
		  sx = self:取属性(等级,nil,"物理")
		  战斗单位[i]={
				名称="赌徒喽罗"
				,模型="赌徒"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:白琉璃(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=25
	 local sx = self:取属性(等级,nil,"法系")
	 战斗单位[1]={
		  名称="白琉璃"
		  ,模型="星灵仙子"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={}
		  ,主动技能=sx.技能组
	 }
	 for i=2,4 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="狐狸精喽罗"
				,模型="狐狸精"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:酒肉和尚2(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=30
	 local sx = self:取属性(等级,nil,"法系")
	 战斗单位[1]={
		  名称="酒肉和尚"
		  ,模型="雨师"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,技能={}
		  ,主动技能={"唧唧歪歪"}
	 }
	 for i=2,3 do
		  sx = self:取属性(等级,nil,"物理")
		  战斗单位[i]={
				名称="雨师喽罗"
				,模型="雨师"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,技能={"感知"}
				,主动技能={"横扫千军"}
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级,"化生寺","辅助")
		  战斗单位[i]={
				名称="雨师喽罗"
				,模型="雨师"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:幽冥鬼(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=30
	 local sx = self:取属性(等级,"阴曹地府","物理")
	 战斗单位[1]={
		  名称="幽冥鬼"
		  ,模型="巡游天神"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,3 do
		  sx = self:取属性(等级,"阴曹地府","物理")
		  战斗单位[i]={
				名称="僵尸喽罗"
				,模型="僵尸"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 for i=4,5 do
		  sx = self:取属性(等级,"阴曹地府","固伤")
		  战斗单位[i]={
				名称="僵尸喽罗"
				,模型="僵尸"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:衙门守卫(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=30
	 local sx = self:取属性(等级,"大唐官府","物理")
	 战斗单位[1]={
		  名称="衙门守卫"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,3 do
		  sx = self:取属性(等级,"大唐官府","物理")
		  战斗单位[i]={
				名称="护卫喽罗"
				,模型="护卫"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:虾兵(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=30
	 local sx = self:取属性(等级,"龙宫","法系")
	 战斗单位[1]={
		  名称="虾兵"
		  ,模型="虾兵"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,3 do
		  sx = self:取属性(等级,"龙宫","法系")
		  战斗单位[i]={
				名称="蛤蟆精喽罗"
				,模型="蛤蟆精"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:山神(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=30
	 local sx = self:取属性(等级,"神木林","法系")
	 战斗单位[1]={
		  名称="山神"
		  ,模型="雨师"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,3 do
		  sx = self:取属性(等级)
		  战斗单位[i]={
				名称="骷髅怪喽罗"
				,模型="骷髅怪"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,主动技能=sx.技能组
		  }
	 end
	 return 战斗单位
end

function 怪物属性:蟹将军(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=30
	 local sx = self:取属性(等级,"龙宫","法系")
	 战斗单位[1]={
		  名称="蟹将军"
		  ,模型="蟹将"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,3 do
		  sx = self:取属性(等级,"龙宫","法系")
		  战斗单位[i]={
				名称="蛤蟆精喽罗"
				,模型="蛤蟆精"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:刘洪1(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=30
	 local sx = self:取属性(等级,"大唐官府","物理")
	 战斗单位[1]={
		  名称="刘洪"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,5 do
		  战斗单位[i]={
				名称="护卫喽罗"
				,模型="护卫"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:李彪(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=40
	 local sx = self:取属性(等级,"阴曹地府","固伤")
	 战斗单位[1]={
		  名称="李彪"
		  ,模型="骷髅怪"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,6 do
		  sx = self:取属性(等级,"阴曹地府","固伤")
		  战斗单位[i]={
				名称="野鬼喽罗"
				,模型="野鬼"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 return 战斗单位
end

function 怪物属性:刘洪2(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=50
	 local sx = self:取属性(等级,"大唐官府","物理")
	 战斗单位[1]={
		  名称="刘洪"
		  ,模型="护卫"
		  ,等级=等级
		  ,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[1])
		  ,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[1])
		  ,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[1])
		  ,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[1])
		  ,固定伤害 = qz(等级*QAQ[序号].固伤系数[1])
		  ,治疗能力 = qz(等级*QAQ[序号].治疗系数[1])
		  ,门派=sx.门派
		  ,AI战斗 = {AI=sx.智能}
	 }
	 for i=2,8 do
		  sx = self:取属性(等级,"大唐官府","物理")
		  战斗单位[i]={
				名称="护卫喽罗"
				,模型="护卫"
				,等级=等级
				,气血 = qz(sx.属性.气血 * QAQ[序号].气血系数[i])
				,伤害 = qz(sx.属性.伤害 * QAQ[序号].伤害系数[i])
				,法伤 = qz(sx.属性.法伤 * QAQ[序号].法伤系数[i])
				,速度 = qz(sx.属性.速度 * 速度削弱 *QAQ[序号].速度系数[i])
				,固定伤害 = qz(等级*QAQ[序号].固伤系数[i])
				,治疗能力 = qz(等级*QAQ[序号].治疗系数[i])
				,门派=sx.门派
				,AI战斗 = {AI=sx.智能}
		  }
	 end
	 return 战斗单位
end


function 怪物属性:伤害测试(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=1
	 for n=1,10 do
		  战斗单位[n]={
		  名称=""
		  ,模型="木桩"
		  ,等级=等级
		  ,伤害 = 100
		  ,防御 = 1
		  ,速度 = 1
		  ,法防 = 1
		  ,气血 =100000000
		  ,技能={""}
		  ,主动技能={""}
	 }
	 end
	 return 战斗单位
end
function 怪物属性:安卓伤害测试(任务id,玩家id,序号)
	 local 战斗单位={}
	 local 等级=1
	 for n=1,10 do
		  战斗单位[n]={
		  名称=""
		  ,模型="剑侠客"
		  ,等级=等级
		  ,角色 = 0
		  ,伤害 = 1000
		  ,防御 = 0
		  ,速度 = 1
		  ,法防 = 0
		  ,气血 =1
		  ,技能={""}
		  ,主动技能={""}
	 }
	 end
	 return 战斗单位
end

function 怪物属性:取属性(lv,门派,类型) --固伤 辅助 物理 法系
	 --如果没写 门派 返回的是随机技能  没类型返回随机类型
	 local 技能={}
	 if 门派==nil then
		  if 类型==nil then
				类型=sjlx[取随机数(1,#sjlx)]
		  end
		  if 类型=="物理" then
				技能=取随机物攻(3)
		  elseif 类型=="法系" then
				技能=取随机法攻(3)
		  elseif 类型=="物法" then
				技能=取随机功法组合(3)
		  end
		  return {属性=self:属性表(lv,类型),技能组=技能}
	 else
		  if 类型==nil then
				类型=self.数据[门派][取随机数(1,#self.数据[门派])]
		  end
		  return {属性=self:属性表(lv,类型),智能=类型,门派=门派}
	 end
end

function 怪物属性:取类型(门派)
	 if self.数据[门派] then
		  return {类型=self.数据[门派][取随机数(1,#self.数据[门派])]}
	 end
	 if 门派=="神木林" or 门派=="魔王寨" or 门派=="龙宫" then
		  return {类型="法系"}
	 end
	 return {类型="物理"}
end

function 取随机功法组合(num)
	 local fs={"天雷斩","烟雨剑法","满天花雨","当头一棒","杀威铁棒","泼天乱棒","八凶法阵","神针撼海","力劈华山","死亡召唤","百爪狂杀","翩鸿一击","长驱直入","善恶有报","壁垒击破","荆棘舞","奔雷咒","水漫金山","泰山压顶","落叶萧萧","唧唧歪歪","五雷咒","龙卷雨击","落叶萧萧","飞砂走石","三昧真火","二龙戏珠"}
	 local fh={}
	 for n=1,num do
		  fh[n]=fs[取随机数(1,#fs)]
	 end
	 return fh
end

function 取随机法攻(num)
	 local fs={"荆棘舞","冰川怒","八凶法阵","地狱烈火","奔雷咒","水漫金山","泰山压顶","落叶萧萧",
	 "唧唧歪歪","五雷咒","龙卷雨击","龙腾","飞砂走石","三昧真火","二龙戏珠"}
	 local fh={}
	 for n=1,num do
		  fh[n]=fs[取随机数(1,#fs)]
	 end
	 return fh
end

function 取随机物攻(num)
	 local fs={"天雷斩","烟雨剑法","满天花雨","当头一棒","杀威铁棒","泼天乱棒","力劈华山","死亡召唤",
	 "百爪狂杀","翩鸿一击","长驱直入","善恶有报","深圳瀚海","壁垒击破"}
	 local fh={}
	 for n=1,num do
		  fh[n]=fs[取随机数(1,#fs)]
	 end
	 return fh
end

function 取随机封印(num)
	 local fs={"失心符","含情脉脉","日月乾坤","似玉生香","定身符","莲步轻舞"}
	 local fh={}
	 for n=1,num do
		  fh[n]=fs[取随机数(1,#fs)]
	 end
	 return fh
end

function 取小法(num)
	 local fs={"水攻","雷击","烈火","落岩"}
	 local fh={}
	 for n=1,num do
		  fh[n]=fs[取随机数(1,#fs)]
	 end
	 return fh
end

function 取大法(num)
	 local fs={"地狱烈火","奔雷咒","水漫金山","泰山压顶"}
	 local fh={}
	 for n=1,num do
		  fh[n]=fs[取随机数(1,#fs)]
	 end
	 return fh
end

function 怪物属性:取随机输出门派()
	 local fs={"大唐官府","狮驼岭","凌波城","阴曹地府","天宫","五庄观"}
	 local AI="物理"
	 local gl=取随机数()
	 if gl<=40 then
		  fs={"化生寺","方寸山","神木林","魔王寨","龙宫"}
		  AI="法系"
	 elseif gl<=60 then
		  fs={"女儿村","阴曹地府","无底洞","普陀山"}
		  AI="固伤"
	 end
	 return fs[取随机数(1,#fs)],AI
end

function 怪物属性:取随机物理门派()
	 local fs={"大唐官府","狮驼岭","凌波城","阴曹地府","天宫","五庄观"}
	 return fs[取随机数(1,#fs)]
end

function 怪物属性:取随机法系门派()
	 local fs={"化生寺","方寸山","神木林","魔王寨","龙宫"}
	 return fs[取随机数(1,#fs)]
end

function 怪物属性:取随机固伤门派()
	 local fs={"女儿村","阴曹地府","无底洞","普陀山"}
	 return fs[取随机数(1,#fs)]
end

function 怪物属性:取随机封系门派()
	 local fs={"方寸山","女儿村","盘丝洞","无底洞","五庄观"}
	 return fs[取随机数(1,#fs)]
end

function 怪物属性:属性表(lv,类型)
	 if 类型=="物理" then
		  if lv<10 then
				return {伤害 = 87 , 法伤= 38 , 速度= 23 ,气血=100}
		  elseif lv<20 then
				return {伤害 = 156 + lv*2, 法伤= 64 , 速度= 26,气血=150}
		  elseif lv<30 then
				return {伤害 = 216 + lv*2, 法伤= 100 , 速度= 38,气血=220}
		  elseif lv<40 then
				return {伤害 = 430 + lv*2, 法伤= 212 , 速度= 66,气血=300}
		  elseif lv<50 then
				return {伤害 = 554 + lv*3, 法伤= 275 , 速度= 83,气血=350}
		  elseif lv<60 then
				return {伤害 = 675 + lv*3, 法伤= 341 , 速度= 100,气血=400}
		  elseif lv<70 then
				return {伤害 = 797 + lv*3, 法伤= 407 , 速度= 117,气血=450}
		  elseif lv<80 then
				return {伤害 = 922 + lv*3, 法伤= 474 , 速度= 134,气血=500}
		  elseif lv<90 then
				return {伤害 = 1050 + lv*3 , 法伤= 542 , 速度= 151,气血=550}
		  elseif lv<100 then
				return {伤害 = 1178 + lv*3 , 法伤= 609 , 速度= 168,气血=600}
		  elseif lv<110 then
				return {伤害 = 1311 + lv*3 , 法伤= 680 , 速度= 186,气血=650}
		  elseif lv<120 then
				return {伤害 = 1536 + lv*3 , 法伤= 802 , 速度= 218,气血=700}
		  elseif lv<130 then
				return {伤害 = 1718 + lv*3 , 法伤= 895 , 速度= 239,气血=750}
		  elseif lv<140 then
				return {伤害 = 1858 + lv*3 , 法伤= 968 , 速度= 255,气血=800}
		  elseif lv<150 then
				return {伤害 = 1957 + lv*3 , 法伤= 1022 , 速度= 270,气血=850}
		  elseif lv<160 then
				return {伤害 = 2100 + lv*3 , 法伤= 1098 , 速度= 287,气血=900}
		  else
				return {伤害 = 2500 + lv*3 , 法伤= 1300 , 速度= 300,气血=1000}
		  end
	 elseif 类型=="法系" then
		  if lv<10 then
				return {伤害 = 87, 法伤= 59 +lv, 速度= 23,气血=100}--210}
		  elseif lv<20 then
				return {伤害 = 166, 法伤= 64+lv, 速度= 26,气血=150}--237}
		  elseif lv<30 then
				return {伤害 = 216, 法伤= 100+lv, 速度= 38,气血=220}--311}
		  elseif lv<40 then
				return {伤害 = 330, 法伤= 259+lv-20, 速度= 50,气血=300}--405}
		  elseif lv<50 then
				return {伤害 = 354, 法伤= 337+lv-20, 速度= 62,气血=350}--496}
		  elseif lv<60 then
				return {伤害 = 475, 法伤= 418+lv-20, 速度= 74,气血=400}--591}
		  elseif lv<70 then
				return {伤害 = 597, 法伤= 499+lv-20, 速度= 87,气血=450}--690}
		  elseif lv<80 then
				return {伤害 = 622, 法伤= 581+lv-20, 速度= 99,气血=500}--793}
		  elseif lv<90 then
				return {伤害 = 750, 法伤= 664+lv-20, 速度= 111,气血=550}--900}
		  elseif lv<100 then
				return {伤害 = 878, 法伤= 727+lv-20, 速度= 121,气血=600}--1012}
		  elseif lv<110 then
				return {伤害 = 911, 法伤= 832+lv-20, 速度= 136 ,气血=650}--1128}
		  elseif lv<120 then
				return {伤害 = 1036 , 法伤= 918+lv-20, 速度= 148 ,气血=700}--1248}
		  elseif lv<130 then
				return {伤害 = 1118 , 法伤= 1004+lv-20, 速度= 160 ,气血=750}--1345}
		  elseif lv<140 then
				return {伤害 = 1258, 法伤= 1092+lv-20, 速度= 173 ,气血=800}--1501}
		  elseif lv<150 then
				return {伤害 = 1357, 法伤= 1180+lv-20, 速度= 184 ,气血=850}--1634}
		  elseif lv<160 then
				return {伤害 = 1500, 法伤= 1270+lv-20, 速度= 197 ,气血=900}--1741}
		  else
				return {伤害 = 1700, 法伤= 1340+lv-20, 速度= 207 ,气血=1000}--1882}
		  end
	 elseif 类型=="固伤" then --类型 女儿村
		  if lv<10 then
				return {伤害 = 87 , 法伤= 59 , 速度= 23 ,气血=210*1.2}
		  elseif lv<20 then
				return {伤害 = 166 , 法伤= 64 , 速度= 26 ,气血=237*1.2}
		  elseif lv<30 then
				return {伤害 = 216 , 法伤= 100 , 速度= 38 ,气血=311*1.2}
		  elseif lv<40 then --玩家秒 187
				return {伤害 = 330 , 法伤= 259 , 速度= 133 ,气血=405*1.2}
		  elseif lv<50 then --玩家秒 248
				return {伤害 = 354 , 法伤= 337 , 速度= 208 ,气血=496*1.2}
		  elseif lv<60 then--玩家秒 285
				return {伤害 = 475 , 法伤= 418 , 速度= 233 ,气血=591*1.2}
		  elseif lv<70 then--玩家秒 339
				return {伤害 = 597 , 法伤= 499 , 速度= 268 ,气血=690*1.2}
		  elseif lv<80 then--玩家秒 394
				return {伤害 = 622 , 法伤= 581 , 速度= 303 ,气血=793*1.2}
		  elseif lv<90 then--玩家秒 415
				return {伤害 = 750 , 法伤= 664 , 速度= 338 ,气血=900*1.2}
		  elseif lv<100 then--玩家秒 465
				return {伤害 = 878 , 法伤= 727 , 速度= 363 ,气血=1012*1.2}
		  elseif lv<110 then--玩家秒 516
				return {伤害 = 911 , 法伤= 832 , 速度= 409 ,气血=1128*1.2}
		  elseif lv<120 then--玩家秒 568
				return {伤害 = 1036 , 法伤= 918 , 速度= 424 ,气血=1248*1.2}
		  elseif lv<130 then--玩家秒 615
				return {伤害 = 1118 , 法伤= 1004 , 速度= 479 ,气血=1345*1.2}
		  elseif lv<140 then--玩家秒 668
				return {伤害 = 1258 , 法伤= 1092 , 速度= 506 ,气血=1501*1.2}
		  elseif lv<150 then--玩家秒 718
				return {伤害 = 1357 , 法伤= 1180 , 速度= 520 ,气血=1634*1.2}
		  elseif lv<160 then--玩家秒 769
				return {伤害 = 1500 , 法伤= 1270 , 速度= 545 ,气血=1741*1.2}
		  else
				return {伤害 = 1700 , 法伤= 1340 , 速度= 590 ,气血=1882*1.2}
		  end
	 elseif 类型=="封系" then
		  if lv<10 then
				return {伤害 = 87 , 法伤= 59 , 速度= 23 ,气血=210*1.2}
		  elseif lv<20 then
				return {伤害 = 166 , 法伤= 64 , 速度= 26 ,气血=237*1.2}
		  elseif lv<30 then
				return {伤害 = 216 , 法伤= 100 , 速度= 38 ,气血=311*1.2}
		  elseif lv<40 then --玩家秒 187
				return {伤害 = 330 , 法伤= 259 , 速度= 183 ,气血=405*1.2}
		  elseif lv<50 then --玩家秒 248
				return {伤害 = 354 , 法伤= 337 , 速度= 238 ,气血=496*1.2}
		  elseif lv<60 then--玩家秒 285
				return {伤害 = 475 , 法伤= 418 , 速度= 293 ,气血=591*1.2}
		  elseif lv<70 then--玩家秒 339
				return {伤害 = 597 , 法伤= 499 , 速度= 348 ,气血=690*1.2}
		  elseif lv<80 then--玩家秒 394
				return {伤害 = 622 , 法伤= 581 , 速度= 403 ,气血=793*1.2}
		  elseif lv<90 then--玩家秒 415
				return {伤害 = 750 , 法伤= 664 , 速度= 458 ,气血=900*1.2}
		  elseif lv<100 then--玩家秒 465
				return {伤害 = 878 , 法伤= 727 , 速度= 513 ,气血=1012*1.2}
		  elseif lv<110 then--玩家秒 516
				return {伤害 = 911 , 法伤= 832 , 速度= 569 ,气血=1128*1.2}
		  elseif lv<120 then--玩家秒 568
				return {伤害 = 1036 , 法伤= 918 , 速度= 624 ,气血=1248*1.2}
		  elseif lv<130 then--玩家秒 615
				return {伤害 = 1118 , 法伤= 1004 , 速度= 679 ,气血=1345*1.2}
		  elseif lv<140 then--玩家秒 668
				return {伤害 = 1258 , 法伤= 1092 , 速度= 736 ,气血=1501*1.2}
		  elseif lv<150 then--玩家秒 718
				return {伤害 = 1357 , 法伤= 1180 , 速度= 790 ,气血=1634*1.2}
		  elseif lv<160 then--玩家秒 769
				return {伤害 = 1500 , 法伤= 1270 , 速度= 845 ,气血=1741*1.2}
		  else
				return {伤害 = 1700 , 法伤= 1340 , 速度= 930 ,气血=1882*1.2}
		  end
	 elseif 类型=="辅助" then
		  if lv<10 then
				return {伤害 = 87 , 法伤= 59 , 速度= 23 ,气血=210*1.2}
		  elseif lv<20 then
				return {伤害 = 156 , 法伤= 64 , 速度= 26 ,气血=237*1.2}
		  elseif lv<30 then
				return {伤害 = 216 , 法伤= 100 , 速度= 38 ,气血=311*1.2}
		  elseif lv<40 then
				return {伤害 = 430 , 法伤= 259 , 速度= 66 ,气血=405*1.2}
		  elseif lv<50 then
				return {伤害 = 554+ lv*2 , 法伤= 337 , 速度= 83 ,气血=496*1.2}
		  elseif lv<60 then
				return {伤害 = 675+ lv*2 , 法伤= 418 , 速度= 100 ,气血=591*1.2}
		  elseif lv<70 then
				return {伤害 = 797+ lv*2 , 法伤= 499 , 速度= 117 ,气血=690*1.2}
		  elseif lv<80 then
				return {伤害 = 922+ lv*2 , 法伤= 581 , 速度= 134 ,气血=793*1.2}
		  elseif lv<90 then
				return {伤害 = 1050+ lv*2 , 法伤= 664 , 速度= 151 ,气血=900*1.2}
		  elseif lv<100 then
				return {伤害 = 1178+ lv*2 , 法伤= 727 , 速度= 168 ,气血=1012*1.2}
		  elseif lv<110 then
				return {伤害 = 1311+ lv*2 , 法伤= 832 , 速度= 186 ,气血=1128*1.2}
		  elseif lv<120 then
				return {伤害 = 1536+ lv*2 , 法伤= 918 , 速度= 218 ,气血=1248*1.2}
		  elseif lv<130 then
				return {伤害 = 1718+ lv*2 , 法伤= 1004 , 速度= 239 ,气血=1345*1.2}
		  elseif lv<140 then
				return {伤害 = 1858+ lv*2 , 法伤= 1092 , 速度= 255 ,气血=1501*1.2}
		  elseif lv<150 then
				return {伤害 = 1957+ lv*2 , 法伤= 1180 , 速度= 270 ,气血=1634*1.2}
		  elseif lv<160 then
				return {伤害 = 2100+ lv*2 , 法伤= 1270 , 速度= 287 ,气血=1741*1.2}
		  else
				return {伤害 = 2500+ lv*2 , 法伤= 1340 , 速度= 300 ,气血=1882*1.2}
		  end
	 else --物法
		  if lv<10 then
				return {伤害 = 87 , 法伤= 59 , 速度= 23 ,气血=210}
		  elseif lv<20 then
				return {伤害 = 156 + lv*2, 法伤= 64 , 速度= 26,气血=237}
		  elseif lv<30 then
				return {伤害 = 216 + lv*2, 法伤= 100 , 速度= 38,气血=311}
		  elseif lv<40 then
				return {伤害 = 430 + lv*2, 法伤= 259 , 速度= 66,气血=405}
		  elseif lv<50 then
				return {伤害 = 554 + lv*2, 法伤= 337 , 速度= 83,气血=496}
		  elseif lv<60 then
				return {伤害 = 675 + lv*2, 法伤= 418 , 速度= 100,气血=591}
		  elseif lv<70 then
				return {伤害 = 797 + lv*2, 法伤= 499 , 速度= 117,气血=690}
		  elseif lv<80 then
				return {伤害 = 922 + lv*2, 法伤= 581 , 速度= 134,气血=793}
		  elseif lv<90 then
				return {伤害 = 1050 + lv*2 , 法伤= 664 , 速度= 151,气血=900}
		  elseif lv<100 then
				return {伤害 = 1178 + lv*2 , 法伤= 727 , 速度= 168,气血=1012}
		  elseif lv<110 then
				return {伤害 = 1311 + lv*2 , 法伤= 832 , 速度= 186,气血=1128}
		  elseif lv<120 then
				return {伤害 = 1536 + lv*2 , 法伤= 918 , 速度= 218,气血=1248}
		  elseif lv<130 then
				return {伤害 = 1718 + lv*2 , 法伤= 1004 , 速度= 239,气血=1345}
		  elseif lv<140 then
				return {伤害 = 1858 + lv*2 , 法伤= 1092 , 速度= 255,气血=1501}
		  elseif lv<150 then
				return {伤害 = 1957 + lv*2 , 法伤= 1180 , 速度= 270,气血=1634}
		  elseif lv<160 then
				return {伤害 = 2100 + lv*2 , 法伤= 1270 , 速度= 287,气血=1741}
		  else
				return {伤害 = 2500 + lv*2 , 法伤= 1340 , 速度= 300,气血=1882}
		  end
	 end
end

function 怪物属性:显示(x,y)end
return 怪物属性
