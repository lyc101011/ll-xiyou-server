-- @Author: baidwwy
-- @Date:   2024-11-14 12:45:49
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-03-07 20:00:02
-- @Author: baidwwy
-- @Date:   2024-11-01 04:09:49
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-20 16:10:21
-- @Author: baidwwy
-- @Date:   2024-08-21 11:47:39
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-09 22:32:33
-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:43
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-08-30 18:29:49

local 地图处理类 = class()
function 地图处理类:初始化()
	self.地图编号={6228,1580,2007,6018,6033,6034,6037,1001,1002,1003,1004,1005,1006,1007,1008,1009,1012,1013,1014,1015,1016,1017,1018,1019,1020,1021,1022,1023,1024,1025,1026,1028,1029,1030,1031,1032,1033,1034,1035,1036,1037,1038,1040,1041,1042,1043,1044,1046,1049,1050,1051,1052,1054,1056,1057,1070,1072,1075,1077,1078,1079,1080,1081,1082,1083,1085,1087,1090,1091,1092,1093,1094,1095,1098,1099,1100,1101,1103,1104,1105,1106,1107,1110,1111,1112,1113,1114,1115,1116,1117,1118,1119,1120,1121,1122,1123,1124,1125,1126,1127,1128,1129,1130,1131,1132,1133,1134,1135,1137,1138,1139,1140,1141,1142,1143,1144,1145,1146,1147,1149,1150,1152,1153,1154,1155,1156,1165,1167,1168,1170,1171,1173,1174,1175,1177,1178,1179,1180,1181,1182,1183,1186,1187,1188,1189,1190,1191,1192,1193,1197,1198,1201,1202,1203,1204,1205,1206,1207,1208,1209,1210,1211,1212,1213,1214,1215,1216,1217,1218,1219,1220,1221,1222,1223,1224,1225,1226,1227,1228,1229,1230,1231,1232,1233,1234,1235,1236,1237,1238,1239,1241,1242,1243,1245,1246,1248,1249,1250,1251,1252,1253,1256,1257,1258,1259,1272,1273,1306,1310,1311,1312,1313,1314,1315,1316,1317,1318,1319,1320,1321,1322,1323,1324,1325,1326,1327,1328,1329,1330,1331,1332,1333,1334,1335,1336,1337,1338,1339,1340,1341,1342,1343,1380,1382,1400,1401,1402,1403,1404,1405,1406,1407,1408,1409,1410,1411,1412,1413,1414,1415,1416,1417,1418,1420,1421,1422,1424,1425,1426,1427,1428,1429,1430,1446,1447,1501,1502,1503,1504,1505,1506,1507,1508,1509,1511,1512,1513,1514,1523,1524,1525,1526,1527,1528,1529,1531,1532,1533,1534,1535,1536,1537,1605,1606,1607,1608,1810,1811,1812,1813,1814,1815,1820,1821,1822,1823,1824,1825,1830,1831,1832,1833,1834,1835,1840,1841,1842,1843,1844,1845,1850,1851,1852,1853,1854,1855,1860,1861,1862,1863,1864,1865,1870,1871,1872,1873,1874,1875,1876,1885,1886,1887,1888,1890,1891,1892,1910,1911,1912,1913,1914,1915,1916,1920,1930,1931,1932,1933,1934,1935,1936,1937,1938,1939,1940,1941,1942,1943,1944,1945,1946,1947,1948,1949,1950,1951,1952,1953,1954,1955,1958,1959,1960,1961,1962,1963,1964,1965,1966,1967,1968,1969,1970,1971,2000,5136,5137,5138,5139,6227,6135,6136} --武神坛加6227
	self.地图数据={}
	self.地图玩家={}
	self.地图单位={}
	self.队伍距离=50
	self.地图坐标={}
	self.单位编号={}
	self.遇怪地图={}
	for n=1,#self.地图编号 do
		self.地图数据[self.地图编号[n]]={npc={},单位={},传送圈={}}
		self.地图玩家[self.地图编号[n]]={}
		self.地图坐标[self.地图编号[n]]=地图坐标类(self.地图编号[n])
		self.地图单位[self.地图编号[n]]={}
		self.单位编号[self.地图编号[n]]=1000
		if 取场景等级(self.地图编号[n])~=nil then
			self.遇怪地图[self.地图编号[n]]=true
		end
	end
	-----------------------------剑会天下
	for n=6135,6136 do
		self.地图数据[n]={npc={},单位={},传送圈={}}
		self.地图玩家[n]={}
		if n==6135 then
			self.地图坐标[n]=地图坐标类(1001)
		elseif n==6136 then
			self.地图坐标[n]=地图坐标类(1526)
		end
		self.地图单位[n]={}
		self.单位编号[n]=1000
	end
	-----------------------------
	--------------------
	local 地图=6227 --武神坛
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(2000)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	--------------------
	for n=5136,5139 do
		self.地图数据[n]={npc={},单位={},传送圈={}}
		self.地图玩家[n]={}
		self.地图坐标[n]=地图坐标类(1197)
		self.地图单位[n]={}
		self.单位编号[n]=1000
	end
	    self.地图数据[1339]={npc={},单位={},传送圈={}}
		self.地图玩家[1339]={}
		self.地图坐标[1339]=地图坐标类(1339)
		self.地图单位[1339]={}
		self.单位编号[1339]=1000
	--加载迷宫地图
	for n=1600,1620 do
		self.地图数据[n]={npc={},单位={},传送圈={}}
		self.地图玩家[n]={}
		self.地图坐标[n]=地图坐标类(1514)
		self.地图单位[n]={}
		self.单位编号[n]=1000
	end
	local 地图=6005   -- 车迟斗法 三清道观
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1204)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	 local 地图=6006   -- 车迟斗法 道观大殿
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1137)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=6007   -- 车迟斗法 九霄云外
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1111)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=7035   -- 龙王
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1116)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000


	local 地图=7036   -- 龙王
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1118)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=7026   -- 红孩儿 六百里钻头号山
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1211)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=7027   -- 红孩儿 六百里钻头号山
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1210)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=6008   -- 七绝山 驼罗庄
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1142)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=6009   -- 七绝山 北斗七星阵
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1213)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=6010   -- 七绝山 七绝山山洞
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1126)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=6011   -- 七绝山 七绝山路
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1211)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=6012   -- 四季 春意盎然
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1207)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=6013   -- 四季 盛夏炎炎
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1070)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=6014   -- 四季 秋高气爽
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1210)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=6015   -- 四季 冬日浓情
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1174)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=6016   -- 胡姬琵琶行 润芳厅
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1197)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=6017   -- 泾河龙王2 幽森洞
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(2007)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=6018   -- 泾河龙王2 太宗寝宫
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1046)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=6019   -- 泾河龙王2 阎罗书房
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1124)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=6020   -- 泾河龙王2 回忆长安城
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1001)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=6021   -- 五庄观 万寿山福地
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1146)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=6022   -- 五庄观 民宅
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1044)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=6023   -- 五庄观 五行法阵
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1914)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=6024   -- 五庄观 紫竹林
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1140)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000

	local 地图=2000   -- 自在天魔 无名城
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(2000)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000

	local 地图=5001--宝藏山
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1042)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=5002--神兽乐园
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1231)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	-- local 地图=5004--雪趣
	-- self.地图数据[地图]={npc={},单位={},传送圈={}}
	-- self.地图玩家[地图]={}
	-- self.地图坐标[地图]=地图坐标类(1174)
	-- self.地图单位[地图]={}
	-- self.单位编号[地图]=1000
	local 地图=5005--昆仑仙境
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1212)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=5006--蟠桃盛会
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1231)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
	local 地图=5958--地府幻境
	self.地图数据[地图]={npc={},单位={},传送圈={}}
	self.地图玩家[地图]={}
	self.地图坐标[地图]=地图坐标类(1122)
	self.地图单位[地图]={}
	self.单位编号[地图]=1000
end

function 地图处理类:补充地图(n)--地图处理类:补充地图(1231)
	self.地图数据[n]={npc={},单位={},传送圈={}}
	self.地图玩家[n]={}
	self.地图坐标[n]=地图坐标类(n)
	self.地图单位[n]={}
	self.单位编号[n]=1000
	if 取场景等级(n)~=nil then
		self.遇怪地图[n]=true
	end
end

function 地图处理类:更换假人模型数据(任务id)
	if 任务数据[任务id]==nil then return end
	local 地图=任务数据[任务id].地图编号
	local 编号=任务数据[任务id].单位编号
	self.地图单位[地图][编号].名称=任务数据[任务id].名称
	self.地图单位[地图][编号].模型=任务数据[任务id].模型
	if 任务数据[任务id].称谓 then
		self.地图单位[地图][编号].称谓=任务数据[任务id].称谓
	end
	if 任务数据[任务id].武器 then
		self.地图单位[地图][编号].武器=任务数据[任务id].武器
	end
	if 任务数据[任务id].锦衣 then
		self.地图单位[地图][编号].锦衣=任务数据[任务id].锦衣
	end
	for n, v in pairs(self.地图玩家[地图]) do
		if self:取同一地图(地图,v,self.地图单位[地图][编号],2) then
			发送数据(玩家数据[v].连接id,1038,self.地图单位[地图][编号])
		end
	end
end

function 地图处理类:npc传送(id,m,x,y)
	if 玩家数据[id].队伍~=0 and 玩家数据[id].队长==false then
		常规提示(id,"只有队长才可使用此项功能！")
		return
	end
	self:跳转地图(id,m,x,y)
end

function 地图处理类:门派传送(id,m)
	if 玩家数据[id].队伍~=0 and 玩家数据[id].队长==false then
		常规提示(id,"只有队长才可使用此项功能！")
		return
	end
	local cs --检查门派传送条件
	if m == "方寸山" then
		cs = {1135,72,63}
	elseif m == "女儿村" then
		cs = {1142,37,37}
	elseif m == "神木林" then
		cs = {1138,46,121}
	elseif m == "大唐官府" then
		cs = {1198,131,82}
	elseif m == "化生寺" then
		cs = {1002,7,88}
	elseif m == "阴曹地府" then
		cs = {1122,101,102}
	elseif m == "盘丝洞" then
		cs = {1513,174,31}
	elseif m == "无底洞" then
		cs = {1139,61,125}
	elseif m == "狮驼岭" then
		cs = {1131,109,77}
	elseif m == "魔王寨" then
		cs = {1512,76,29}
	elseif m == "普陀山" then
		cs = {1140,20,18}
	elseif m == "天宫" then
		cs = {1111,175,122}
	elseif m == "凌波城" then
		cs = {1150,33,67}
	elseif m == "五庄观" then
		cs = {1146,26,55}
	elseif m == "龙宫" then
		cs = {1116,71,77}
	elseif m == "花果山" then
		cs = {1251,66,33}
	elseif m == "九黎城" then
	 	cs = {1580,66,60}
	end
	if cs==nil then
		return
	else
		self:跳转地图(id,cs[1],cs[2],cs[3])
	end
end

function 地图处理类:明雷遇怪处理(连接id,id,内容)
	local 标识=内容.标识
	local 序列=内容.序列
	if 取队长权限(id)==false then
		return
	elseif 任务数据[标识]==nil then
		return
	elseif 玩家数据[id].zhandou~=0 or 任务数据[标识].zhandou~=nil then
		return
	else
		if 任务数据[标识].类型==103 or 任务数据[标识].类型==6677 then --大雁塔
			战斗准备类:创建战斗(id,100007,标识)
			任务数据[标识].zhandou=true
		elseif 任务数据[标识].类型==202 then
			战斗准备类:创建战斗(id,100019,标识)
			任务数据[标识].zhandou=true
		-----------------------------------------
		elseif 任务数据[标识].类型==6667 then --女儿村
			if 任务数据[标识].名称=="普通山猴" then
				战斗准备类:创建战斗(id,130002,标识)
			else
				战斗准备类:创建战斗(id,130003,标识)
			end
			任务数据[标识].zhandou=true
		elseif 任务数据[标识].类型==6668 then
			if 任务数据[标识].名称=="普通护卫者" then
				战斗准备类:创建战斗(id,130004,标识)
			else
				战斗准备类:创建战斗(id,130005,标识)
			end
			任务数据[标识].zhandou=true
		elseif 任务数据[标识].类型==6669 then
			if 任务数据[标识].名称=="普通守卫者" then
				战斗准备类:创建战斗(id,130006,标识)
			else
				战斗准备类:创建战斗(id,130007,标识)
			end
			任务数据[标识].zhandou=true
		elseif 任务数据[标识].类型==6670 then
			if 任务数据[标识].名称=="普通机器人" or 任务数据[标识].名称=="普通战车" then
				战斗准备类:创建战斗(id,130008,标识)
			else
				战斗准备类:创建战斗(id,130009,标识)
			end
			任务数据[标识].zhandou=true
		elseif 任务数据[标识].类型==6671 then
			if 任务数据[标识].名称=="普通小野猪" then
				战斗准备类:创建战斗(id,130010,标识)
			else
				战斗准备类:创建战斗(id,130011,标识)
			end
			任务数据[标识].zhandou=true
		elseif 任务数据[标识].类型==6672 then
			if 任务数据[标识].名称=="普通守护伞" then
				战斗准备类:创建战斗(id,130012,标识)
			else
				战斗准备类:创建战斗(id,130013,标识)
			end
			任务数据[标识].zhandou=true
		elseif 任务数据[标识].类型==6673 then
			if 任务数据[标识].名称=="普通月宫兔" then
				战斗准备类:创建战斗(id,130014,标识)
			else
				战斗准备类:创建战斗(id,130015,标识)
			end
			任务数据[标识].zhandou=true
		elseif 任务数据[标识].类型==1209 then
			if 帮派PK.正式开始 and 帮派PK.活动结束==false then
				if 任务数据[标识].归属方=="红方" then
				    if 帮派PK.玩家表["蓝方"].成员[id] then
				    	战斗准备类:创建战斗(id,130085,标识)
				    	任务数据[标识].zhandou=true
				    end
				elseif 任务数据[标识].归属方=="蓝方" then
				    if 帮派PK.玩家表["红方"].成员[id] then
				    	战斗准备类:创建战斗(id,130085,标识)
				    	任务数据[标识].zhandou=true
				    end
				end
			end
		end
	end
end

function 地图处理类:取传送数据(数字id)
		return  取传送点(玩家数据[数字id].角色.地图数据.编号)
end

function 地图处理类:数据处理(id,序号,数字id,内容)
	内容.ip=nil
	if 序号==1001 then
		self:移动请求(id,内容,数字id)
	elseif 序号==1002 then
		self:移动坐标刷新(id,数字id,内容)
	elseif 序号==1003 then --
		local 现在地图 = self:取传送数据(数字id)
		if 现在地图==nil or (现在地图~=nil and 现在地图[内容.id]==nil ) or (现在地图~=nil and 现在地图[内容.id]~=nil and 现在地图[内容.id].x==nil or 现在地图[内容.id].y==nil ) then
			return
		end
		local 目标=切换场景(现在地图[内容.id].切换,玩家数据[数字id].角色.地图数据.编号)
		local 角色xy={x=x,y=y}
		local 对方xy={x=0,y=0}
		对方xy.x,对方xy.y=现在地图[内容.id].x,现在地图[内容.id].y
		角色xy.x,角色xy.y=玩家数据[数字id].角色.地图数据.x/20,玩家数据[数字id].角色.地图数据.y/20
		if 取两点距离(对方xy,角色xy)>=15 then
			常规提示(数字id,"#Y/传送阵和你的距离太远了吧")
			return
		else
			self:跳转地图(数字id,目标[1],目标[2].x,目标[2].y)
		end
	elseif 序号==1004 then
		local 现在地图 = 玩家数据[数字id].角色.地图数据.编号
		local 目标=内容.地图
		if 目标==nil or 现在地图==nil or (self.地图单位[内容.地图]~=nil and self.地图单位[内容.地图][内容.编号]==nil) then
			常规提示(数字id,"#Y/你们距离太远了吧")
			return
		elseif 目标~=现在地图 then
			常规提示(数字id,"#Y/你们距离太远了吧")
			return
		end
		local 角色xy={x=x,y=y}
		local 对方xy={x=0,y=0}
		对方xy.x,对方xy.y=self.地图单位[内容.地图][内容.编号].x,self.地图单位[内容.地图][内容.编号].y
		角色xy.x,角色xy.y=玩家数据[数字id].角色.地图数据.x/20,玩家数据[数字id].角色.地图数据.y/20
		if 取两点距离(对方xy,角色xy)<=15 then

			self:明雷遇怪处理(id,数字id,内容)
		end
	elseif 序号==1009 then
		self:跳转地图(数字id,内容.地图,内容.x,内容.y)
	 elseif 序号==1008 then
	 	self:重置坐标(数字id,内容.x,内容.y,内容.方向)
	end
end

function 地图处理类:跳转地图(数字id,地图编号,x,y) ---找到了  over
	--10051 1131 109 77  我们现在知道上面4个值怎么来的了  也知道是多少了  那看它怎么处理的

	local 数字id = 数字id + 0 ---重新定义了个局部变量叫 数字id  等于上面的数字id 就是 虽然都叫数字id 但新的数字id 意义不同.当然 这个其实可以不写 也生效的
	--数字id=10051
	if 玩家数据[数字id].摊位数据~=nil then return  end
	if 玩家数据[数字id].队伍~=0 and 玩家数据[数字id].队长==false then return 0 end
	if 玩家数据[数字id].zhandou~=0 then
		print("战斗不为0禁止跳转")
		return
	elseif self.地图数据[地图编号]==nil then
	    print("无地图" ..地图编号 .."禁止跳转")
		return
	end
	---这几个判断 不用解释

	local x1,y1=x*20,y*20
	玩家数据[数字id].角色.地图数据.x,玩家数据[数字id].角色.地图数据.y=x1,y1
	---这里是调取这个id的校色在地图上的x和 y的值
	--self:离开地图(数字id,玩家数据[数字id].角色.地图数据.编号)
	self:移除玩家(数字id)---又是个个函数,先不理会他
	玩家数据[数字id].角色.地图数据.编号=地图编号---这里等于几? 1131
	发送数据(玩家数据[数字id].连接id,1005,{地图编号,x,y}) ---向客户端更新...怎么跟你叙述呢  你校色从A地图到B地图这个操作是服务端完成的,客户端还吧知道,需要向客户端更新下数据.
	self:加入玩家(数字id,地图编号,x1,y1) ---这个是在地图上加入这个校色的显示.
	if 玩家数据[数字id].队伍~=0 and 玩家数据[数字id].队长 then --又细致的判断  如果是队长怎么处理 等等.
		local 队伍id=玩家数据[数字id].队伍
		for n=2,#队伍数据[队伍id].成员数据 do
			local 队员id=队伍数据[队伍id].成员数据[n]
			玩家数据[队员id].角色.地图数据.x,玩家数据[队员id].角色.地图数据.y=x1,y1
			self:移除玩家(队员id)
			玩家数据[队员id].角色.地图数据.编号=地图编号
			发送数据(玩家数据[队员id].连接id,1005,{地图编号,x,y})
			self:加入玩家(队员id,地图编号,x1,y1)
		end
	end
	------------------武神坛
	if 玩家数据[数字id].账号 and 武神坛数据[玩家数据[数字id].账号]~=nil then
		if 玩家数据[数字id].队伍~=0 then
			local 队伍id=玩家数据[数字id].队伍
			for n=1,#队伍数据[队伍id].成员数据 do
				local 队员id=队伍数据[队伍id].成员数据[n]
				if 玩家数据[队员id]~=nil then
					武神坛数据[玩家数据[队员id].账号]:是否武神坛地图(队员id)
				end
			end
		else
			武神坛数据[玩家数据[数字id].账号]:是否武神坛地图(数字id)
		end
	end ---这里不用看
	return true
end

function 地图处理类:更改模型(id,模型,类型)
	local 地图编号=玩家数据[id].角色.地图数据.编号
	if 地图编号 then
		for n, v in pairs(self.地图玩家[地图编号]) do
			if n~=id and self:取同一地图(地图编号,id,n,1) then
				发送数据(玩家数据[n].连接id,1030,{id=id,变身数据=模型})
			end
		end
	end
end

function 地图处理类:重置坐标(id,x,y,方向)
	玩家数据[id].角色.地图数据.x,玩家数据[id].角色.地图数据.y,玩家数据[id].角色.地图数据.方向=x,y,方向
	发送数据(玩家数据[id].连接id,1011,{x=x,y=y})
	local 地图编号=玩家数据[id].角色.地图数据.编号
	for i, v in pairs(self.地图玩家[地图编号]) do
		if i~=id and 玩家数据[i] then
			发送数据(玩家数据[i].连接id,1012,{id=id,x=x,y=y,方向=方向})
		end
	end
end


function 地图处理类:助战重置坐标(id,x,y,方向,地图编号) --(队员id,内容.x,内容.y,内容.方向)
	玩家数据[id].角色.地图数据.x,玩家数据[id].角色.地图数据.y,玩家数据[id].角色.地图数据.方向=x,y,方向
	for i, v in pairs(self.地图玩家[地图编号]) do
		if i~=id and 玩家数据[i] then
			发送数据(玩家数据[i].连接id,1012,{id=id,x=x,y=y,方向=方向})
		end
	end
end

function 地图处理类:移动坐标刷新(id,数字id,内容)
	if not 玩家数据[数字id] then
	    return
	end
	玩家数据[数字id].角色.地图数据.x,玩家数据[数字id].角色.地图数据.y,玩家数据[数字id].角色.地图数据.方向=内容.x,内容.y,内容.方向
	if 内容.类型 == "行走" then

		-- 玩家数据[数字id].角色.行走监测.行走 = true
		-- 玩家数据[数字id].角色.行走监测.时间 = os.time()
		local 地图=玩家数据[数字id].角色.地图数据.编号
		if 玩家数据[数字id].队伍~=0 and 玩家数据[数字id].队长 then
			local 角色xy={x=内容.x,y=内容.y}
			local 对方xy={x=0,y=0}
			for n=2,#队伍数据[玩家数据[数字id].队伍].成员数据 do
				local 队员id=队伍数据[玩家数据[数字id].队伍].成员数据[n]
				if 玩家数据[队员id]~=nil then --麻瓜剑会7.4修
			    	对方xy.x,对方xy.y=玩家数据[队员id].角色.地图数据.x,玩家数据[队员id].角色.地图数据.y
				if 取两点距离(角色xy,对方xy)>=self.队伍距离*n+300 then --超出五倍距离重置坐标
					玩家数据[数字id].移动数据[n]=false
					self:重置坐标(队员id,内容.x,内容.y,内容.方向)
					return
				end
				if 取两点距离(角色xy,对方xy)>=self.队伍距离*n-self.队伍距离 and  玩家数据[数字id].移动数据.移动目标  then
					--玩家数据[数字id].移动数据[n]==false or
					玩家数据[数字id].移动数据[n]=true
					local 临时数据={x=玩家数据[数字id].移动数据.移动目标.x,y=玩家数据[数字id].移动数据.移动目标.y,距离=self.队伍距离*n-self.队伍距离,数字id=队员id}
					发送数据(玩家数据[队员id].连接id,1001,临时数据)
					local 地图编号=玩家数据[数字id].角色.地图数据.编号
					for i, v in pairs(self.地图玩家[地图]) do
						if i~=队员id and 玩家数据[i] and self:取同一地图(地图,队员id,i,1) then
							发送数据(玩家数据[i].连接id,1008,{数字id=队员id,路径=临时数据})
						end
					end
				end
			    end
			end
		end
		if 玩家数据[数字id].角色.战斗开关==false and 取队长权限(数字id) then
		    self:暗雷遇怪检测(数字id,地图)
		end
	else
		-- 玩家数据[数字id].角色.行走监测.行走 = false
		-- if 队伍数据[玩家数据[数字id].队伍] then
		-- 	for n=2,#队伍数据[玩家数据[数字id].队伍].成员数据 do
		-- 		local 队员id=队伍数据[玩家数据[数字id].队伍].成员数据[n]
		-- 		if 玩家数据[队员id].连接id == "招募" then
		-- 			玩家数据[队员id].角色.地图数据.x,玩家数据[队员id].角色.地图数据.y,玩家数据[队员id].角色.地图数据.方向=内容.x,内容.y,内容.方向
		-- 		end
		-- 	end
		-- end
	end
end



-- function 地图处理类:假人移动坐标刷新(id,数字id,内容) ----假人带队 暂时封存----假人带队 暂时封存

-- 		local xy=self.地图坐标[玩家数据[数字id].角色.地图数据.编号]:取随机点()
-- 		玩家数据[数字id].角色.地图数据.x,玩家数据[数字id].角色.地图数据.y,玩家数据[数字id].角色.地图数据.方向 = xy.x*20,xy.y*20,取随机数(0,7)
-- 		-- 玩家数据[数字id].角色.行走监测.行走 = true
-- 		-- 玩家数据[数字id].角色.行走监测.时间 = os.time()
-- 		local 地图=玩家数据[数字id].角色.地图数据.编号
-- 		if 玩家数据[数字id].队伍~=0 and 玩家数据[数字id].队长 then
-- 			local 角色xy={x=xy.x,y=xy.y}
-- 			local 对方xy={x=0,y=0}
-- 			for n=2,#队伍数据[玩家数据[数字id].队伍].成员数据 do
-- 				local 队员id=队伍数据[玩家数据[数字id].队伍].成员数据[n]
-- 				if 玩家数据[队员id]~=nil then --麻瓜剑会7.4修
-- 			    	对方xy.x,对方xy.y=玩家数据[队员id].角色.地图数据.x,玩家数据[队员id].角色.地图数据.y
-- 				-- if 取两点距离(角色xy,对方xy)>=self.队伍距离*n+300 then --超出五倍距离重置坐标
-- 				-- 	玩家数据[数字id].移动数据[n]=false
-- 				-- 	self:重置坐标(队员id,xy.x,xy.y,xy.方向)
-- 				-- 	return
-- 				-- end
-- 				if 取两点距离(角色xy,对方xy)>=self.队伍距离*n-self.队伍距离 and  玩家数据[数字id].移动数据.移动目标  then
-- 					--玩家数据[数字id].移动数据[n]==false or
-- 					玩家数据[数字id].移动数据[n]=true
-- 					local 临时数据={x=玩家数据[数字id].移动数据.移动目标.x,y=玩家数据[数字id].移动数据.移动目标.y,距离=self.队伍距离*n-self.队伍距离,数字id=队员id}
-- 					发送数据(玩家数据[队员id].连接id,1001,临时数据)
-- 					local 地图编号=玩家数据[数字id].角色.地图数据.编号
-- 					for i, v in pairs(self.地图玩家[地图]) do
-- 						if i~=队员id and 玩家数据[i] and self:取同一地图(地图,队员id,i,1) then
-- 							发送数据(玩家数据[i].连接id,1008,{数字id=队员id,路径=临时数据})
-- 						end
-- 					end
-- 				end
-- 			    end
-- 			end
-- 		end
-- end




function 地图处理类:暗雷遇怪检测(数字id,地图)
    if self.遇怪地图[地图]~=nil then
		if os.time()>=玩家数据[数字id].遇怪时间 and self:遇怪条件检测(地图,数字id) then
			战斗准备类:创建战斗(数字id,100001,0)
		else
			self:官职情报收集检测(地图,数字id)
		end
	end
	if 玩家数据[数字id].角色:取任务(111)~=0 and 任务数据[玩家数据[数字id].角色:取任务(111)].分类==2 and 取门派巡逻地图(玩家数据[数字id].角色.门派,地图) and 取随机数()<=10 then --门派巡逻
		战斗准备类:创建战斗(数字id,100015,玩家数据[数字id].角色:取任务(111))
		return
		--黑风山遇怪
	elseif 玩家数据[数字id].角色:取任务(82)~=0 and os.time()>=玩家数据[数字id].遇怪时间 and 取随机数()<=25 and 玩家数据[数字id].角色.地图数据.编号==6018  then
	    	战斗准备类:创建战斗(数字id,155566,玩家数据[数字id].角色:取任务(82))
	elseif 玩家数据[数字id].角色:取任务(72)~=0 and os.time()>=玩家数据[数字id].遇怪时间 and 取随机数()<=25 and 玩家数据[数字id].角色.地图数据.编号==6033  then
	    	战斗准备类:创建战斗(数字id,155584,玩家数据[数字id].角色:取任务(72))
	elseif 地图~=1001 and 玩家数据[数字id].角色:取任务(1163)~=0 and 取随机数()<=10 then
		local 任务id=玩家数据[数字id].角色:取任务(1163)
		if 任务数据[任务id].分类==2 then
			if 地图==1050 and 任务数据[任务id].巡逻地点=="长安衙门" then
				战斗准备类:创建战斗(数字id,130036,任务id)
			elseif 地图==1537 and 任务数据[任务id].巡逻地点=="建邺衙门" then
				战斗准备类:创建战斗(数字id,130036,任务id)
			elseif 地图==1026 and 任务数据[任务id].巡逻地点=="国子监书库" then
				战斗准备类:创建战斗(数字id,130036,任务id)
			end
		elseif 任务数据[任务id].分类==3 then
			if 任务数据[任务id].子类==2 then --护送西域使者
			    战斗准备类:创建战斗(数字id,130037,任务id)
			end
		elseif 任务数据[任务id].分类==6 and 任务数据[任务id].已跳转==nil and 地图~=任务数据[任务id].SX.跳转[1] then
			任务数据[任务id].已跳转=true
			self:跳转地图(数字id,任务数据[任务id].SX.跳转[1],任务数据[任务id].SX.跳转[2],任务数据[任务id].SX.跳转[3])
			常规提示(数字id,"刚打了一个瞌睡，居然就到了"..取地图名称(任务数据[任务id].SX.跳转[1]).."。")
		end
		return
	end
end

function 地图处理类:取野外等级差(地图等级,玩家等级)
	local 等级=math.abs(地图等级-玩家等级)
	if 等级<=5 then
		return 1
	elseif 等级<=10 then
		return 0.8
	elseif 等级<=20 then
		return 0.5
	else
		return 0.2
	end
end

function 地图处理类:官职情报收集检测(地图,id)
	if 地图==1110 or 地图==1514 or 地图==1174 or 地图==1091 or 地图==1173 then
		local 随机值=取随机数()
		if   玩家数据[id].角色:取任务(110)~=0 and 任务数据[玩家数据[id].角色:取任务(110)].分类==3 and 任务数据[玩家数据[id].角色:取任务(110)].情报==false and 随机值<=20 then
			战斗准备类:创建战斗(id,100014,玩家数据[id].角色:取任务(110))
		end
	end
end

function 地图处理类:遇怪条件检测(地图,id)
	if 地图>=1004 and 地图<=1009 then
		return false
	elseif 地图==1090 then
		return false
	elseif 玩家数据[id].角色:取任务(17)~=0 and 任务数据[玩家数据[id].角色:取任务(17)].分类==3 then
		return false
	elseif 玩家数据[id].角色:取任务(110)~=0 and 任务数据[玩家数据[id].角色:取任务(110)].分类==3 then
		return false
	elseif 玩家数据[id].角色:取任务(111)~=0 and 任务数据[玩家数据[id].角色:取任务(111)].分类==2 then
		return false
	end
	local 场景等级=取场景等级(地图)
	if 场景等级==nil then
		return false
	elseif 辅助内挂类:是否挂机中(id) then --挂机
	    return false
	elseif 玩家数据[id].角色:取任务(9)~=0 and 玩家数据[id].角色.等级+10>=场景等级 then
		return false
	end
	return true
end

function 地图处理类:比较距离(id,对方id,距离)
	if 玩家数据[id].角色.地图数据.编号~=玩家数据[对方id].角色.地图数据.编号 then
		return false
	elseif 取两点距离(玩家数据[id].角色.地图数据,玩家数据[对方id].角色.地图数据)>距离 then
		return false
	end
	return true
end

function 地图处理类:取移动限制(id)
	if id==nil or 玩家数据[id]==nil then
		return true
	end
	if 玩家数据[id].队伍~=0 and 玩家数据[id].队长==false then
		return true
	elseif 玩家数据[id].摊位数据~=nil then
		return  true
	-- elseif 玩家数据[id].勾魂索中 then
	-- 	return  true
	end
	return false
end

function 地图处理类:移动请求(id,内容,数字id)
	if self:取移动限制(数字id) then --移动限制
		return
	else
		内容.距离=0
	end
	if 玩家数据[数字id].队伍~=0 then
		玩家数据[数字id].移动数据={}
		for n=1,#队伍数据[玩家数据[数字id].队伍].成员数据 do
			玩家数据[数字id].移动数据[n]=false
		end
		玩家数据[数字id].移动数据.移动目标=内容
	end
	local 地图编号=玩家数据[数字id].角色.地图数据.编号
	for n, v in pairs(self.地图玩家[地图编号]) do
		if 自己和助战除外(数字id,n) and self:取同一地图(地图编号,数字id,n,1)  then
			发送数据(玩家数据[n].连接id,1008,{数字id=数字id,路径=内容})
		end
	end
end

function 自己和助战除外(id,n)
	return n~=id and 玩家数据[n] and not 玩家数据[n].zhuzhan
end

function 地图处理类:更新(dt) end

function 地图处理类:取可移除同一地图(地图,id,id1,类型)
	if 地图>=6000 and 地图<=7500 then--地图<=6050 then
		if 类型==1 then --玩家
			if id and (not 玩家数据[id] or not 玩家数据[id].角色 or not 玩家数据[id].连接id) then
				return false
			elseif  id1 and (not 玩家数据[id1] or not 玩家数据[id1].角色 or not 玩家数据[id1].连接id ) then
				return false
			end
			if (地图==6001 or 地图==6002) and 玩家数据[id].角色:取任务(120)== 玩家数据[id1].角色:取任务(120) then --乌鸡
				return true
			elseif 地图==6227 then --武神坛
			    return true
			elseif (地图>=7001 and 地图<=7005) and 玩家数据[id].角色:取任务(670)== 玩家数据[id1].角色:取任务(670) then --五更寒
				return true
			elseif (地图==6003 or 地图==6004) and 玩家数据[id].角色:取任务(600)== 玩家数据[id1].角色:取任务(600) then
				return true
			elseif (地图==6005 or 地图==6006 or 地图==6007 ) and 玩家数据[id].角色:取任务(610)== 玩家数据[id1].角色:取任务(610) then
				return true
			elseif (地图==6008 or 地图==6009 or 地图==6010 or 地图==6011) and 玩家数据[id].角色:取任务(640)== 玩家数据[id1].角色:取任务(640) then
				return true
			elseif (地图==7006 or 地图==7007 or 地图==7008 ) and 玩家数据[id].角色:取任务(690)== 玩家数据[id1].角色:取任务(690) then
				return true
			elseif (地图==7017 or 地图==7018 or 地图==7019 or 地图==7020) and 玩家数据[id].角色:取任务(710)== 玩家数据[id1].角色:取任务(710) then --通天河
				return true
			else
				return false
			end
		else --怪物
			if (地图==6001 or 地图==6002) then
				-- local 副本id=任务数据[玩家数据[id].角色:取任务(120)].副本id
				if 任务数据[玩家数据[id].角色:取任务(120)] ~= nil and 任务数据[玩家数据[id].角色:取任务(120)].副本id ==任务数据[id1.id].副本id then
					return true
				else
					return false
				end
			elseif (地图>=7001 and 地图<=7005) then
				if 任务数据[玩家数据[id].角色:取任务(670)] ~= nil and  任务数据[玩家数据[id].角色:取任务(670)].副本id ==任务数据[id1.id].副本id then
					return true
				else
					return false
				end
			elseif (地图==7006 or 地图==7007 or 地图==7008 ) then
				if 任务数据[玩家数据[id].角色:取任务(690)] ~= nil and  任务数据[玩家数据[id].角色:取任务(690)].副本id ==任务数据[id1.id].副本id then
					return true
				else
					return false
				end
			elseif (地图==7017 or 地图==7018 or 地图==7019 or 地图==7020) then
				if 任务数据[玩家数据[id].角色:取任务(710)] ~= nil and 任务数据[玩家数据[id].角色:取任务(710)].副本id== 任务数据[id1.id].副本id then --通天河
					return true
				else
					return false
				end
			elseif (地图==7021 or 地图==7022 or 地图==7023 or 地图==7024 or 地图==7025) then
				if 任务数据[玩家数据[id].角色:取任务(800)] ~= nil and 任务数据[玩家数据[id].角色:取任务(800)].副本id== 任务数据[id1.id].副本id then --通天河
					return true
				else
					return false
				end
			elseif (地图==6003 or 地图==6004) then
				if 任务数据[玩家数据[id].角色:取任务(600)] ~= nil and  任务数据[玩家数据[id].角色:取任务(600)].副本id ==任务数据[id1.id].副本id then
					return true
				else
					return false
				end
			elseif (地图==6005 or 地图==6006 or 地图==6007 )  then
				if 任务数据[玩家数据[id].角色:取任务(610)] ~= nil and  任务数据[玩家数据[id].角色:取任务(610)].副本id ==任务数据[id1.id].副本id then
					return true
				else
					return false
				end
			elseif (地图==6008 or 地图==6009 or 地图==6010 or 地图==6011 )  then
				if 任务数据[玩家数据[id].角色:取任务(640)] ~= nil and  任务数据[玩家数据[id].角色:取任务(640)].副本id ==任务数据[id1.id].副本id then
					return true
				else
					return false
				end
			elseif 地图==2000 then
				if 任务数据[玩家数据[id].角色:取任务(630)] ~= nil and  任务数据[玩家数据[id].角色:取任务(630)].副本id ==任务数据[id1.id].副本id then
					return true
				else
					return false
				end
			else
				return false
			end
		end
	elseif (地图==1217 or 地图==1815 or 地图==1825 or 地图==1874 or 地图==1844 or 地图==1854 or 地图==1835 or 地图==1865) then
			if id and (not 玩家数据[id] or not 玩家数据[id].角色 or not 玩家数据[id].连接id ) then
				return false
			elseif  id1 and (not 玩家数据[id1] or not 玩家数据[id1].角色 or not 玩家数据[id1].连接id ) then
				return false
			end
			if (地图==1217 or 地图==1815 or 地图==1825 or 地图==1874 or 地图==1844 or 地图==1854 or 地图==1835 or 地图==1865) and 玩家数据[id].角色.BPBH== 玩家数据[id1].角色.BPBH then
				return true
			else
				return false
			end
	else
		if 类型==1 then --玩家与玩家
			if id and (not 玩家数据[id] or not 玩家数据[id].角色 or not 玩家数据[id].连接id) then
				return false
			elseif  id1 and (not 玩家数据[id1] or not 玩家数据[id1].角色 or not 玩家数据[id1].连接id) then
				return false
			end
		end
		return true
	end
end

function 地图处理类:移除玩家(id)
	local 地图编号=玩家数据[id].角色.地图数据.编号
	if 地图编号 then
		for n, v in pairs(self.地图玩家[地图编号]) do
			if 自己和助战除外(id,n) and self:取可移除同一地图(地图编号,id,n,1)  then
				发送数据(玩家数据[n].连接id,1007,{id=id})
			end
		end
		self.地图玩家[地图编号][id]=nil
	end
end
function 地图处理类:更改染色(id,染色组,方案)
	local 地图编号=玩家数据[id].角色.地图数据.编号
	for n, v in pairs(self.地图玩家[地图编号]) do
		if n~=id and 玩家数据[n]~=nil and self:取同一地图(地图编号,id,n,1)  then
			发送数据(玩家数据[n].连接id,1013,{id=id,染色组=染色组,染色方案=方案})
		end
	end
end

function 地图处理类:更改炫彩(id,xc,xcz)
	local 地图编号=玩家数据[id].角色.地图数据.编号
	for n, v in pairs(self.地图玩家[地图编号]) do
		if n~=id and 玩家数据[n]~=nil and self:取同一地图(地图编号,id,n,1)  then
			发送数据(玩家数据[n].连接id,1031,{id=id,炫彩=xc,炫彩组=xcz})
		end
	end
end

-- function 地图处理类:更新武器(id,武器)
-- 	local 地图编号=玩家数据[id].角色.地图数据.编号
-- 	for n, v in pairs(self.地图玩家[地图编号]) do
-- 		if n~=id and 玩家数据[n]~=nil and self:取同一地图(地图编号,id,n,1) then
-- 			发送数据(玩家数据[n].连接id,1009,{id=id,武器=武器})
-- 		end
-- 	end
-- end
function 地图处理类:更新武器(id,武器)
	local 地图编号=玩家数据[id].角色.地图数据.编号
	local 副武器 = nil
	if 玩家数据[id].角色.模型 == "影精灵" and 玩家数据[id].角色.装备 ~= nil and 玩家数据[id].角色.装备[4] ~= nil and 玩家数据[id].道具.数据[玩家数据[id].角色.装备[4]].子类 == 911 then
		副武器 = 玩家数据[id].道具.数据[玩家数据[id].角色.装备[4]]
	end
	if 玩家数据[id].连接id=="zhuzhan" then
	    if 玩家数据[id].角色.模型 == "影精灵" and 玩家数据[id].角色.装备 ~= nil and 玩家数据[id].角色.装备[4] ~= nil and 玩家数据[玩家数据[id].角色.主人id].道具.数据[玩家数据[id].角色.装备[4]].子类 == 911  then
	        副武器 = 玩家数据[玩家数据[id].角色.主人id].道具.数据[玩家数据[id].角色.装备[4]]
	    end
	end
	for n, v in pairs(self.地图玩家[地图编号]) do
		if n~=id and 玩家数据[n]~=nil and self:取同一地图(地图编号,id,n,1) then
			--发送数据(玩家数据[n].连接id,1009,{id=id,武器=武器})
			发送数据(玩家数据[n].连接id,1009,{id=id,武器=武器,副武器 = 副武器})
		end
	end
end

function 地图处理类:更新锦衣(id,名称,序号)
	local 地图编号=玩家数据[id].角色.地图数据.编号
	for n, v in pairs(self.地图玩家[地图编号]) do
		if n~=id and 玩家数据[n]~=nil and self:取同一地图(地图编号,id,n,1) then
			发送数据(玩家数据[n].连接id,1032,{id=id,锦衣=名称,序号=序号})
		end
	end
end

function 地图处理类:更新坐骑(id,坐骑)
	local 地图编号=玩家数据[id].角色.地图数据.编号
	for n, v in pairs(self.地图玩家[地图编号]) do
		if n~=id and 玩家数据[n]~=nil and self:取同一地图(地图编号,id,n,1)  then
			发送数据(玩家数据[n].连接id,1019,{id=id,坐骑=坐骑})
		end
	end
end

function 地图处理类:系统更新称谓(id,称谓)
	local 地图编号=玩家数据[id].角色.地图数据.编号
	玩家数据[id].角色.当前称谓=称谓
	发送数据(玩家数据[id].连接id,1029,{当前称谓=玩家数据[id].角色.当前称谓})
	for n, v in pairs(self.地图玩家[地图编号]) do
		if n~=id and 玩家数据[n]~=nil and self:取同一地图(地图编号,id,n,1) then
			发送数据(玩家数据[n].连接id,1020,{id=id,当前称谓=玩家数据[id].角色.当前称谓})
		end
	end
end

function 地图处理类:更新称谓(id,称谓ID)
	local 地图编号=玩家数据[id].角色.地图数据.编号
	if 玩家数据[id].角色.称谓~=nil and 玩家数据[id].角色.称谓[math.ceil(称谓ID)]~=nil then
		玩家数据[id].角色.当前称谓=玩家数据[id].角色.称谓[math.ceil(称谓ID)]
	else
		玩家数据[id].角色.当前称谓=""
	end
	for n, v in pairs(self.地图玩家[地图编号]) do
		if n~=id and 玩家数据[n]~=nil and self:取同一地图(地图编号,id,n,1)  then
			发送数据(玩家数据[n].连接id,1020,{id=id,当前称谓=玩家数据[id].角色.当前称谓})
		end
	end
end

function 地图处理类:设置战斗开关(id,逻辑)
	local 地图编号=玩家数据[id].角色.地图数据.编号
	for n, v in pairs(self.地图玩家[地图编号]) do
		if n~=id and 玩家数据[n]~=nil and self:取同一地图(地图编号,id,n,1)  then
			发送数据(玩家数据[n].连接id,4014,{id=id,逻辑=逻辑})
		end
	end
end

function 地图处理类:更改队伍图标(id,逻辑)
	local 地图编号=玩家数据[id].角色.地图数据.编号
	for n, v in pairs(self.地图玩家[地图编号]) do
		if n~=id and 玩家数据[n]~=nil and self:取同一地图(地图编号,id,n,1)   then
			发送数据(玩家数据[n].连接id,4007,{id=id,逻辑=逻辑})
		end
	end
end

function 地图处理类:更改队伍图标1(id,逻辑,老队长)
	local 地图编号=玩家数据[id].角色.地图数据.编号
	if not 地图编号 then
		地图编号 = 玩家数据[老队长].角色.地图数据.编号
	end
	for n, v in pairs(self.地图玩家[地图编号]) do
		if n~=id and 玩家数据[n]~=nil and self:取同一地图(地图编号,id,n,1)   then
			发送数据(玩家数据[n].连接id,4007,{id=id,逻辑=逻辑})
		end
	end
end

function 地图处理类:更改队伍样式(id,逻辑)
	local 地图编号=玩家数据[id].角色.地图数据.编号
	发送数据(玩家数据[id].连接id,4019,{逻辑=逻辑})
	for n, v in pairs(self.地图玩家[地图编号]) do
		if n~=id and 玩家数据[n]~=nil and self:取同一地图(地图编号,id,n,1)   then
			发送数据(玩家数据[n].连接id,4016,{id=id,逻辑=逻辑})
		end
	end
end

function 地图处理类:更改帮战旗帜(id,逻辑)
	local 地图编号=玩家数据[id].角色.地图数据.编号
	发送数据(玩家数据[id].连接id,6573,{逻辑=逻辑})
	for n, v in pairs(self.地图玩家[地图编号]) do
		if n~=id and 玩家数据[n]~=nil and self:取同一地图(地图编号,id,n,1)   then
			发送数据(玩家数据[n].连接id,6574,{id=id,逻辑=逻辑})
		end
	end
end

function 地图处理类:玩家是否飞行(id,逻辑)
    local 地图编号=玩家数据[id].角色.地图数据.编号
    发送数据(玩家数据[id].连接id,4020,{逻辑=逻辑})
	for n, v in pairs(self.地图玩家[地图编号]) do
		if n~=id and 玩家数据[n]~=nil and self:取同一地图(地图编号,id,n,1) then
			发送数据(玩家数据[n].连接id,4009,{id=id,逻辑=逻辑})
		end
	end
end

-- function 地图处理类:刷新玩家队伍(id,逻辑)
--     local 地图编号=玩家数据[id].角色.地图数据.编号
-- 	for n, v in pairs(self.地图玩家[地图编号]) do
-- 		if self:取同一地图(地图编号,id,n,1)  then
-- 			发送数据(玩家数据[n].连接id,4017,{id=id,逻辑=逻辑})
-- 		end
-- 	end
-- end
function 地图处理类:加入动画(id,地图编号,x,y,类型)
	--local 地图编号=玩家数据[id].角色.地图数据.编号
	local 角色xy={x=x,y=y}
	local 对方xy={x=0,y=0}
	for n, v in pairs(self.地图玩家[地图编号]) do
		if n~=id and self:取同一地图(地图编号,id,n,1)  then
			对方xy.x,对方xy.y=玩家数据[n].角色.地图数据.x,玩家数据[n].角色.地图数据.y
			if 取两点距离(角色xy,对方xy)<=800 then
				发送数据(玩家数据[n].连接id,1010,{id=id,类型=类型,坐标=角色xy角色xy})
			end
		end
	end
end
function 地图处理类:删除单位(地图,编号)
	if self.地图单位[地图]==nil then
		if 地图==nil then
			地图="异常地图"
		end
		错误日志[#错误日志]={时间=os.time(),记录="地图异常数据:"..地图}
		return
	end
	self.地图单位[地图][编号]=nil
	if 编号==nil then
		return
	end
	for n, v in pairs(self.地图玩家[地图]) do
		if 玩家数据[v] and 玩家数据[v].连接id then
		    发送数据(玩家数据[v].连接id,1016,{编号=编号})
		end
	end
end

function 地图处理类:npc炫彩(地图,编号,炫彩,炫彩组)
	if self.地图单位[地图][编号] then
		self.地图单位[地图][编号].炫彩=取染色id(炫彩)
		self.地图单位[地图][编号].炫彩组=取炫彩染色(炫彩组)
		for n, v in pairs(self.地图玩家[地图]) do
			if 玩家数据[v] and self:取同一地图(地图,v,self.地图单位[地图][编号],2) then
				发送数据(玩家数据[v].连接id,1034,{编号=编号,炫彩=self.地图单位[地图][编号].炫彩,炫彩组=self.地图单位[地图][编号].炫彩组})
			end
		end
	end
end

function 地图处理类:npc行走(地图,编号,x,y,喊话)
	if 编号==nil then
	    return
	end
	if self.地图单位[地图]==nil then
		if 地图==nil then
			地图="异常地图"
		end
		错误日志[#错误日志]={时间=os.time(),记录="地图异常数据:"..地图}
		return
	end
	self.地图单位[地图][编号].行走间隔 = os.time() + 20
	self.地图单位[地图][编号].x = x
	self.地图单位[地图][编号].y = y
	for n, v in pairs(self.地图玩家[地图]) do
		if 玩家数据[v] and self:取同一地图(地图,v,self.地图单位[地图][编号],2) then
			发送数据(玩家数据[v].连接id,1033,{编号=编号,坐标x=x,坐标y=y,喊话=喊话})
		end
	end
end

function 地图处理类:更换单位模型名称(地图,编号,id,模型,名称)
	if 编号==nil then
	    return
	end
	if self.地图单位[地图]==nil then
		if 地图==nil then
			地图="异常地图"
		end
		错误日志[#错误日志]={时间=os.time(),记录="地图异常数据:"..地图}
		return
	end
	任务数据[id].名称=名称
	任务数据[id].模型=模型
	self.地图单位[地图][编号].名称=名称
	self.地图单位[地图][编号].模型=模型
	for n, v in pairs(self.地图玩家[地图]) do
		if self:取同一地图(地图,v,self.地图单位[地图][编号],2) then
			发送数据(玩家数据[v].连接id,1035,self.地图单位[地图][编号])
		end
	end
end

function 地图处理类:取地图怪物数量(地图,mc)
	local num=0
	for k,v in pairs(self.地图单位[地图]) do
		if v.名称 and v.名称==mc then
		    num=num+1
		end
	end
	return num
end

function 地图处理类:添加单位(id,刷新)
	local 地图=任务数据[id].地图编号
	local 编号=0
	for n, v in pairs(self.地图单位[地图]) do
		if self.地图单位[地图][n]==nil  then 编号=n end
	end
	for n=1000,self.单位编号[地图] do
		if 编号==0 and self.地图单位[地图][n]==nil then
			编号=n
		end
	end
	if 编号==0 then
		self.单位编号[地图]=self.单位编号[地图]+1
		编号=self.单位编号[地图]
	end
	local 染色组=nil
	local 染色方案=nil
	local 炫彩=nil
	local 炫彩组=nil
	if 任务数据[id].变异 and 染色信息[任务数据[id].模型]~=nil then
		染色方案 = 染色信息[任务数据[id].模型].id
		染色组 = 染色信息[任务数据[id].模型].方案
	else
		任务数据[id].变异=false
	end
	if 任务数据[id].炫彩 and 任务数据[id].炫彩组 ~= nil then
		炫彩=任务数据[id].炫彩
		炫彩组=任务数据[id].炫彩组
	elseif 任务数据[id].染色方案 and 任务数据[id].染色组 then
    	染色组=任务数据[id].染色组
		染色方案=任务数据[id].染色方案
	end
	-- if 任务数据[id].类型 >= 507 and 任务数据[id].类型 <= 522 then
	-- 	染色组=任务数据[id].染色组
	-- 	染色方案=任务数据[id].染色方案
	-- elseif 任务数据[id].类型 ==6674 or 任务数据[id].类型 ==6676 then
	-- 	染色组=任务数据[id].染色组
	-- 	染色方案=任务数据[id].染色方案
	-- end
	local 领取人的ID = 0
	if 任务数据[id]~=nil and 任务数据[id].领取人id~=nil and #任务数据[id].领取人id>0 then
		领取人的ID=任务数据[id].领取人id
	end
	local x显示饰品 = false
	if 任务数据[id].显示饰品~=nil and 任务数据[id].显示饰品 then
		x显示饰品 = true
	end
	if not 任务数据[id].方向 then
		任务数据[id].方向 = 取随机数(0,3)
	end
	self.地图单位[地图][编号]={
		名称=任务数据[id].名称,
		模型=任务数据[id].模型,
		编号=编号,
		x=任务数据[id].x,
		y=任务数据[id].y,
		地图=地图,
		变异=任务数据[id].变异,
		称谓=任务数据[id].称谓,
		染色组=染色组,
		染色方案=染色方案,
		炫彩=炫彩,
		炫彩组=炫彩组,
		事件=任务数据[id].事件,
		武器=任务数据[id].武器,
		方向=任务数据[id].方向,
		小地图名称颜色=任务数据[id].小地图名称颜色,
		行走开关=任务数据[id].行走开关,
		显示饰品=x显示饰品,
		沉默分身=任务数据[id].沉默分身,
		id=id,
		领取人id=领取人的ID,
		置顶层=任务数据[id].置顶层,
		任务显示=任务数据[id].任务显示,
		战斗显示=任务数据[id].战斗显示,
		队伍组=任务数据[id].队伍组 or {},
		武器子类=任务数据[id].武器子类, --新增
		锦衣=任务数据[id].锦衣  --新增
	}
	if self.地图单位[地图][编号].事件==nil then
		self.地图单位[地图][编号].事件="单位"
	end
	任务数据[id].单位编号=编号
	for n, v in pairs(self.地图玩家[地图]) do
		if 玩家数据[v] and self:取同一地图(地图,v,self.地图单位[地图][编号],2) then
			发送数据(玩家数据[v].连接id,1015,self.地图单位[地图][编号])
		end
	end
end

function 地图处理类:更改怪物模型(任务id)
	local 编号 = 0
	local 地图 = 任务数据[任务id].地图编号
	for n, v in pairs(self.地图单位[地图]) do
		if 任务数据[任务id].单位编号 == n then
			self.地图单位[地图][n].名称 = 任务数据[任务id].名称
			self.地图单位[地图][n].模型 = 任务数据[任务id].模型
			for i, v in pairs(self.地图玩家[地图]) do
				if self:取同一地图(地图,v,self.地图单位[地图][编号],2) then
					发送数据(玩家数据[v].连接id,1014,self.地图单位[地图][n])
				end
			end
			return
		end
	end
end

-- function 地图处理类:批量添加单位(id)--修改
-- 	local 地图=任务数据[id].地图编号
-- 	local 编号=0
-- 	for n, v in pairs(self.地图单位[地图]) do
-- 		if  self.地图单位[地图][n]==nil  then 编号=n end
-- 	end
-- 	for n=1000,self.单位编号[地图] do
-- 		if 编号==0 and self.地图单位[地图][n]==nil then
-- 			编号=n
-- 		end
-- 	end
-- 	if 编号==0 then
-- 		self.单位编号[地图]=self.单位编号[地图]+1
-- 		编号=self.单位编号[地图]
-- 	end
-- 	local 染色组=nil
-- 	local 染色方案=nil
-- 	if 任务数据[id].炫彩 and 任务数据[id].炫彩组 ~= nil then
-- 		炫彩=任务数据[id].炫彩
-- 		炫彩组=任务数据[id].炫彩组
-- 	end
-- 	if 任务数据[id].变异 and 染色信息[任务数据[id].模型]~=nil then
-- 		染色方案 = 染色信息[任务数据[id].模型].id
-- 		染色组 = 染色信息[任务数据[id].模型].方案
-- 	else
-- 		任务数据[id].变异=false
-- 	end
-- 	local 领取人的ID = 0
-- 	if 任务数据[id]~=nil and 任务数据[id].领取人id~=nil and #任务数据[id].领取人id>0 then
-- 		领取人的ID=任务数据[id].领取人id
-- 	end
-- 	local x显示饰品 = false
-- 	if 任务数据[id].显示饰品~=nil and 任务数据[id].显示饰品 then
-- 		x显示饰品 = true
-- 	end
-- 	self.地图单位[地图][编号]={
-- 		名称=任务数据[id].名称,
-- 		模型=任务数据[id].模型,
-- 		编号=编号,
-- 		x=任务数据[id].x,
-- 		y=任务数据[id].y,
-- 		地图=地图,
-- 		变异=任务数据[id].变异,
-- 		称谓=任务数据[id].称谓,
-- 		染色组=染色组,
-- 		染色方案=染色方案,
-- 		炫彩=炫彩,
-- 		炫彩组=炫彩组,
-- 		事件=任务数据[id].事件,
-- 		武器=任务数据[id].武器,
-- 		方向=任务数据[id].方向,
-- 		显示饰品=x显示饰品,
-- 		id=id,
-- 		领取人id=领取人的ID,
-- 	}
-- 	if self.地图单位[地图][编号].事件==nil then
-- 		self.地图单位[地图][编号].事件="单位"
-- 	end
-- 	任务数据[id].单位编号=编号
-- 	return self.地图单位[地图][编号]
-- end
function 地图处理类:批量添加单位(id)
	local 地图=任务数据[id].地图编号
	local 编号=0
	for n, v in pairs(self.地图单位[地图]) do
		if  self.地图单位[地图][n]==nil  then 编号=n end
	end
	for n=1000,self.单位编号[地图] do
		if 编号==0 and self.地图单位[地图][n]==nil then
			编号=n
		end
	end
	if 编号==0 then
		self.单位编号[地图]=self.单位编号[地图]+1
		编号=self.单位编号[地图]
	end
	local 染色组=nil
	local 染色方案=nil
	local 炫彩=nil
	local 炫彩组=nil
	if 任务数据[id].变异 and 染色信息[任务数据[id].模型]~=nil then
		染色方案 = 染色信息[任务数据[id].模型].id
		染色组 = 染色信息[任务数据[id].模型].方案
	else
		任务数据[id].变异=false
	end
	if 任务数据[id].炫彩 and 任务数据[id].炫彩组 ~= nil then
		炫彩=任务数据[id].炫彩
		炫彩组=任务数据[id].炫彩组
	end
	if 任务数据[id].类型 >= 507 and 任务数据[id].类型 <= 522 then
		染色组=任务数据[id].染色组
		染色方案=任务数据[id].染色方案
	end
	local 领取人的ID = 0
	if 任务数据[id]~=nil and 任务数据[id].领取人id~=nil and #任务数据[id].领取人id>0 then
		领取人的ID=任务数据[id].领取人id
	end
	local x显示饰品 = false
	if 任务数据[id].显示饰品~=nil and 任务数据[id].显示饰品 then
		x显示饰品 = true
	end
	if not 任务数据[id].方向 then
		任务数据[id].方向 = 取随机数(0,3)
	end
	self.地图单位[地图][编号]={
		名称=任务数据[id].名称,
		模型=任务数据[id].模型,
		编号=编号,
		x=任务数据[id].x,
		y=任务数据[id].y,
		地图=地图,
		变异=任务数据[id].变异,
		称谓=任务数据[id].称谓,
		染色组=染色组,
		染色方案=染色方案,
		炫彩=炫彩,
		炫彩组=炫彩组,
		事件=任务数据[id].事件,
		武器=任务数据[id].武器,
		方向=任务数据[id].方向,
		行走开关=任务数据[id].行走开关,
		显示饰品=x显示饰品,
		沉默分身=任务数据[id].沉默分身,
		id=id,
		领取人id=领取人的ID,
		置顶层=任务数据[id].置顶层,
		任务显示=任务数据[id].任务显示,
		战斗显示=任务数据[id].战斗显示,
		队伍组=任务数据[id].队伍组 or {},
		武器子类=任务数据[id].武器子类, --新增
		锦衣=任务数据[id].锦衣  --新增
	}
	if self.地图单位[地图][编号].事件==nil then
		self.地图单位[地图][编号].事件="单位"
	end
	任务数据[id].单位编号=编号
	return self.地图单位[地图][编号]
end

function 地图处理类:设置玩家摊位(id,名称)
	local 地图编号=玩家数据[id].角色.地图数据.编号
	for n, v in pairs(self.地图玩家[地图编号]) do
		if n~=id and self:取同一地图(地图编号,id,n,1)  then
			发送数据(玩家数据[n].连接id,3519,{id=id,名称=名称})
		end
	end
end

function 地图处理类:取消玩家摊位(id)
	local 地图编号=玩家数据[id].角色.地图数据.编号
	for n, v in pairs(self.地图玩家[地图编号]) do
		if n~=id and self:取同一地图(地图编号,id,n,1) then
			发送数据(玩家数据[n].连接id,3519,{id=id})
		end
	end
end

function 地图处理类:当前消息广播(数据,名称,内容,id,tx)
	内容=添加ID特效(id,内容)
	for n, v in pairs(self.地图玩家[数据.编号]) do
		if self:取同一地图(数据.编号,id,n,1) then
			if 取两点距离(数据,玩家数据[n].角色.地图数据)<=1500 then
				发送数据(玩家数据[n].连接id,38,{内容="qqq|"..玩家数据[id].角色.名称.."*"..玩家数据[id].角色.造型.."*玩家信息*"..id.."/["..名称.."]"..内容,频道="dq"})
			end
			if n~=id then
				if 取两点距离(数据,玩家数据[n].角色.地图数据)<=1000 then
					发送数据(玩家数据[n].连接id,1018,{id=id,文本=内容,特效=tx})
				end
			end
		end
	end
end

function 地图处理类:清除地图玩家(编号,目标,x,y)
	for n, v in pairs(self.地图玩家[编号]) do
		if 玩家数据[n] and (玩家数据[n].zhandou==nil or 玩家数据[n].zhandou==0) then
			self:跳转地图(n,目标,x,y)
		end
	end
end

function 地图处理类:当前消息广播1(编号,内容)
	for n, v in pairs(self.地图玩家[编号]) do
		发送数据(玩家数据[n].连接id,38,{内容=内容,频道="dq"})
	end
end

function 地图处理类:取地图人数(地图编号)
	local 数量=0
	for n, v in pairs(self.地图玩家[地图编号]) do
		数量=数量+1
	end
	return 数量
end

function 地图处理类:取同一地图(地图,id,id1,类型)
	if 地图>=6000 and 地图<=7500 then--地图<=6050 then
		if 类型==1 then --玩家
			if (地图==6001 or 地图==6002) and 玩家数据[id].角色:取任务(120)== 玩家数据[id1].角色:取任务(120) then --乌鸡
				return true
			--====================麻瓜剑会
		    elseif 地图==6135 then
		    	return true
			--====================
			elseif 地图==6227 then --羔羊武神坛
				return true
			elseif (地图>=6043 and 地图<=6046) and 玩家数据[id].角色:取任务(191)== 玩家数据[id1].角色:取任务(191) then --齐天大圣
				return true
			elseif 地图 > 6021 and 地图<=6032 and 玩家数据[id].角色:取任务(90)== 玩家数据[id1].角色:取任务(90) then --秘境降妖
       			 return true
			elseif 地图 > 6032 and 地图<=6037 and 玩家数据[id].角色:取任务(70)== 玩家数据[id1].角色:取任务(70) then --大闹天宫
       			 return true
       		 elseif 地图 > 6017 and 地图<=6021 and 玩家数据[id].角色:取任务(80)== 玩家数据[id1].角色:取任务(80) then --黑风山
			        return true
			elseif (地图>=7001 and 地图<=7005) and 玩家数据[id].角色:取任务(670)== 玩家数据[id1].角色:取任务(670) then --五更寒
				return true
			elseif (地图>=6054 and 地图<=6057) and 玩家数据[id].角色:取任务(950)== 玩家数据[id1].角色:取任务(950) then --天火之殇上
				return true
			elseif (地图>=6047 and 地图<=6053) and 玩家数据[id].角色:取任务(906)== 玩家数据[id1].角色:取任务(906) then --无底洞
				return true
			elseif (地图==6003 or 地图==6004) and 玩家数据[id].角色:取任务(600)== 玩家数据[id1].角色:取任务(600) then
				return true
			elseif (地图==6005 or 地图==6006 or 地图==6007 ) and 玩家数据[id].角色:取任务(610)== 玩家数据[id1].角色:取任务(610) then
				return true
			elseif (地图==6008 or 地图==6009 or 地图==6010 or 地图==6011) and 玩家数据[id].角色:取任务(640)== 玩家数据[id1].角色:取任务(640) then
				return true
			elseif (地图==7026 or 地图==7027)   and 玩家数据[id].角色:取任务(740)== 玩家数据[id1].角色:取任务(740) then
				return true
			elseif (地图==7035 or 地图==7036)   and 玩家数据[id].角色:取任务(900)== 玩家数据[id1].角色:取任务(900) then
				return true
			elseif 地图==2000  and 玩家数据[id].角色:取任务(630)== 玩家数据[id1].角色:取任务(630) then --轮回境
				return true
			elseif (地图==7006 or 地图==7007 or 地图==7008 ) and 玩家数据[id].角色:取任务(690)== 玩家数据[id1].角色:取任务(690) then
				return true
			elseif (地图==7017 or 地图==7018 or 地图==7019 or 地图==7020) and 玩家数据[id].角色:取任务(710)== 玩家数据[id1].角色:取任务(710) then --通天河
				return true
			else
				return false
			end
		else --怪物
			if (地图==6001 or 地图==6002) then
				-- local 副本id=任务数据[玩家数据[id].角色:取任务(120)].副本id
				if 任务数据[玩家数据[id].角色:取任务(120)] ~= nil and 任务数据[玩家数据[id].角色:取任务(120)].副本id ==任务数据[id1.id].副本id then
					return true
				else
					return false
				end
			elseif (地图>=7001 and 地图<=7005) then
				if 任务数据[玩家数据[id].角色:取任务(670)] ~= nil and  任务数据[玩家数据[id].角色:取任务(670)].副本id ==任务数据[id1.id].副本id then
					return true
				else
					return false
				end
			elseif (地图==7006 or 地图==7007 or 地图==7008 ) then
				if 任务数据[玩家数据[id].角色:取任务(690)] ~= nil and  任务数据[玩家数据[id].角色:取任务(690)].副本id ==任务数据[id1.id].副本id then
					return true
				else
					return false
				end
			elseif (地图==7017 or 地图==7018 or 地图==7019 or 地图==7020) then
				if 任务数据[玩家数据[id].角色:取任务(710)] ~= nil and 任务数据[玩家数据[id].角色:取任务(710)].副本id== 任务数据[id1.id].副本id then --通天河
					return true
				else
				    return false
				end
			elseif (地图==7021 or 地图==7022 or 地图==7023 or 地图==7024 or 地图==7025) then
				if 任务数据[玩家数据[id].角色:取任务(800)] ~= nil and 任务数据[玩家数据[id].角色:取任务(800)].副本id== 任务数据[id1.id].副本id then --通天河
					return true
				else
				    return false
				end
      elseif 地图 > 6046 and 地图<=6053 and (任务数据[玩家数据[id].角色:取任务(906)] or {}).副本id ==(任务数据[id1.id] or {}).副本id then--无底洞
        return true
      elseif 地图 > 6053 and 地图<=6057 and (任务数据[玩家数据[id].角色:取任务(950)] or {}).副本id ==(任务数据[id1.id] or {}).副本id then--
        return true
      elseif 地图 > 6042 and 地图<=6046 and (任务数据[玩家数据[id].角色:取任务(191)] or {}).副本id ==(任务数据[id1.id] or {}).副本id then
        return true


			elseif 地图 > 6032 and 地图<=6037 and (任务数据[玩家数据[id].角色:取任务(70)] or {}).副本id ==(任务数据[id1.id] or {}).副本id then
       			 return true
			elseif 地图 > 6021 and 地图<=6032 and (任务数据[玩家数据[id].角色:取任务(90)] or {}).副本id ==(任务数据[id1.id] or {}).副本id then
       			 return true
     		elseif 地图 > 6017 and 地图<=6021 and (任务数据[玩家数据[id].角色:取任务(80)] or {}).副本id ==(任务数据[id1.id] or {}).副本id then
        		return true
			elseif (地图==6003 or 地图==6004) then
				if 任务数据[玩家数据[id].角色:取任务(600)] ~= nil and  任务数据[玩家数据[id].角色:取任务(600)].副本id ==任务数据[id1.id].副本id then
					return true
				else
					return false
				end
			elseif (地图==6005 or 地图==6006 or 地图==6007 )  then
				if 任务数据[玩家数据[id].角色:取任务(610)] ~= nil and  任务数据[玩家数据[id].角色:取任务(610)].副本id ==任务数据[id1.id].副本id then
					return true
				else
					return false
				end
			elseif (地图==6008 or 地图==6009 or 地图==6010 or 地图==6011 )  then
				if 任务数据[玩家数据[id].角色:取任务(640)] ~= nil and  任务数据[玩家数据[id].角色:取任务(640)].副本id ==任务数据[id1.id].副本id then
					return true
				else
					return false
				end
			elseif (地图==7026 or 地图==7027  )  then
				if 任务数据[玩家数据[id].角色:取任务(740)] ~= nil and  任务数据[玩家数据[id].角色:取任务(740)].副本id ==任务数据[id1.id].副本id then
					return true
				else
					return false
				end
			elseif (地图==7035 or 地图==7036  )  then
				if 任务数据[玩家数据[id].角色:取任务(900)] ~= nil and  任务数据[玩家数据[id].角色:取任务(900)].副本id ==任务数据[id1.id].副本id then
					return true
				else
					return false
				end
			elseif 地图==2000 then
				if 任务数据[玩家数据[id].角色:取任务(630)] ~= nil and  任务数据[玩家数据[id].角色:取任务(630)].副本id ==任务数据[id1.id].副本id then
					return true
				else
					return false
				end
			else
				return false
			end
		end
	elseif (地图==1217 or 地图==1815 or 地图==1825 or 地图==1874 or 地图==1844 or 地图==1854 or 地图==1835 or 地图==1865) then
			if (地图==1217 or 地图==1815 or 地图==1825 or 地图==1874 or 地图==1844 or 地图==1854 or 地图==1835 or 地图==1865) and 玩家数据[id].角色.BPBH== 玩家数据[id1].角色.BPBH then
				return true
			else
				return false
			end
	else

		if 类型==1 then --玩家与玩家
			if not 玩家数据[id] or not 玩家数据[id1] or not 玩家数据[id].连接id or not 玩家数据[id1].连接id then
			    return false
			end
		end
		return true
	end
end

function 地图处理类:加入玩家(id,地图编号,x,y)
	id=id+0
	玩家数据[id].遇怪时间=os.time()+取随机数(10,20)
	if not self.地图玩家[地图编号] then
	    地图编号=1001

	end
	self.地图玩家[地图编号][id]=id
	发送数据(玩家数据[id].连接id,1003,{})--取假人表(玩家数据[id].角色.地图数据.编号)
	for n, v in pairs(self.地图单位[地图编号]) do--场景活动怪物
		if self:取同一地图(地图编号,id,self.地图单位[地图编号][n],2) then
			发送数据(玩家数据[id].连接id,1015,self.地图单位[地图编号][n])
		end
	end

	local dfs = {}
	dfs["主角"] = {}
	for n, v in pairs(self.地图玩家[地图编号]) do--向地图内玩家发送新玩家数据
		if n~=id and  self:取同一地图(地图编号,id,n,1) then
				发送数据(玩家数据[n].连接id,1006,玩家数据[id].角色:取地图数据()) --向地图其他玩家发送主角信息
				table.insert(dfs["主角"], 玩家数据[n].角色:取地图数据())
				if #dfs["主角"] == 20 then --100  发送数量
					发送数据(玩家数据[id].连接id,1022,dfs["主角"]) --向主角发送地图内其他玩家的信息
					dfs["主角"] = {}
				end
		end
	end
	if #dfs["主角"] >= 1 then
		发送数据(玩家数据[id].连接id,1022,dfs["主角"])
	end
	dfs = {}
end

function 地图处理类:重连加入(id,地图编号,x,y)
	id=id+0
	local dfs = {}
	self.地图玩家[地图编号][id]=id
	发送数据(玩家数据[id].连接id,1003,{})--取假人表(玩家数据[id].角色.地图数据.编号)
	for n, v in pairs(self.地图单位[地图编号]) do--场景活动怪物
		if self:取同一地图(地图编号,id,self.地图单位[地图编号][n],2) then
			发送数据(玩家数据[id].连接id,1015,self.地图单位[地图编号][n])
		end
	end

	dfs["主角"] = {}
	for n, v in pairs(self.地图玩家[地图编号]) do--向地图内玩家发送新玩家数据
		if n~=id and  self:取同一地图(地图编号,id,n,1) then
			table.insert(dfs["主角"], 玩家数据[n].角色:取地图数据())--修改
			if #dfs["主角"] == 20 then --100
				发送数据(玩家数据[id].连接id,1022,dfs["主角"])
				dfs["主角"] = {}
			end
		end
	end
	if #dfs["主角"] >= 1 then
		发送数据(玩家数据[id].连接id,1022,dfs["主角"])
	end
	dfs = {}
end

function 地图处理类:更新()
	for k,v in pairs(self.地图单位) do
		for i,s in pairs(self.地图单位[k]) do
			if self.地图单位[k][i].事件 == "明雷" or (self.地图单位[k][i] and self.地图单位[k][i].行走开关 and not self.地图单位[k][i].zhandou) then--and  取随机数() < 5 then
				if self.地图单位[k][i].行走间隔 == nil then
					local xy=self.地图坐标[k]:取附近点(self.地图单位[k][i].x,self.地图单位[k][i].y)
					self:npc行走(k,i,xy.x,xy.y)
					self.地图单位[k][i].行走间隔 = os.time() + 取随机数(10,20)
				else
					if self.地图单位[k][i].行走间隔 < os.time() then
						self.地图单位[k][i].行走间隔 = nil
					end
				end
			end
		end
		if k == 5005 then
			for i,s in pairs(self.地图玩家[k]) do
				if 初始活动.昆仑仙境[i] and 初始活动.昆仑仙境[i].次数 and 初始活动.昆仑仙境[i].次数 < 初始活动.昆仑仙境[i].最大次数 and os.time() > 初始活动.昆仑仙境[i].时间 then
					初始活动.昆仑仙境[i].次数 = 初始活动.昆仑仙境[i].次数 +1
					初始活动.昆仑仙境[i].时间 = os.time() + 180
					if 玩家数据[i] and 玩家数据[i].角色 then
						local jy = qz(395*玩家数据[i].角色.等级)
						玩家数据[i].角色:添加经验(jy,"昆仑仙境")
					end
				end
			end
		end
	end
end

function 地图处理类:加载房屋()

end
function 地图处理类:添加房屋(编号)

end

function 地图处理类:显示(x,y) end
return 地图处理类