--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2024-07-03 12:49:28
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
function 取随机怪(a,b)
	local 临时信息=取等级怪(取随机数(a,b))
	local 临时模型=取敌人信息(临时信息[取随机数(1,#临时信息)])
	return 临时模型
end

function 取等级怪(lv)
	local em = {}
	if lv <= 5 then
		em = {-472,-476,-480,-484,-488,-488,-496,-500,-504,-508,-512}
	elseif lv > 5 and lv <= 15 then
		em = {-516,-520,-524,-528,-532,-536,-540,-544,-548}
	elseif lv > 15 and lv <= 25 then
		em = {-552,-556,-560,-564,-568,-572,-576,-580,-584}
	elseif lv > 25 and lv <= 35 then
		em = {-588,-592,-596,-600}
	elseif lv > 35 and lv <= 45 then
		em = {-684,-688,-692,-696,-700,-576,-596,-584,-580}
	elseif lv > 45 and lv <= 55 then
		em = {-1484,-1488,-1492,-1496,}
	elseif lv > 55 and lv <= 65 then
		em = {-1500,-2955,-2959,-2980,-2984,-2988}
	elseif lv > 65 and lv <= 75 then
		em = {-2963,-2967,-2971,-2975,-2992,-2996,-3000}
	elseif lv > 75 and lv <= 85 then
		em = {-6984,-6988,-6992,-6996,-7000}
	elseif lv > 85 and lv <= 95 then
		em = {-7958,-7962,-7966,-7970,-7974}
	elseif lv > 95 and lv <= 105 then
		em = {-7978,-7982,-8000,-7986}
	elseif lv > 105 and lv <= 125 then
		em = {-9899,-9903,-9907}
	elseif lv > 125 and lv <= 135 then
		em = {-9911,-9915,-9919,-9923,-9927,-9931,-9935,-9939,-9895,-9891}
	elseif lv > 135 and lv <= 145 then
		em = {-9943,-9947,-9951,-9955}
	elseif lv > 145 and lv <= 155 then
		em = {-9959,-9963,-9967,-9971,-9975,-9979,-9983,-9987}
	elseif lv > 155 then
		em = {-9991,-9995,-9999}
	end
	return em
end
Changjinglv={}
Changjinglv[1506]={1,7}
Changjinglv[1507]={5,9}--东海海底
Changjinglv[1508]={9,13}--沉船
Changjinglv[1126]={5,12}--东海岩洞
Changjinglv[1193]={6,16}--江南野外
Changjinglv[1004]={8,18}--大雁塔一层
Changjinglv[1005]={12,22}--大雁塔二层
Changjinglv[1006]={16,26}--大雁塔三层
Changjinglv[1007]={20,30}--大雁塔四层
Changjinglv[1008]={24,34}--大雁塔五层
Changjinglv[1090]={28,38}--大雁塔六层
-------------
Changjinglv[2004]={20,30}--地宫一层
Changjinglv[2005]={30,35}--地宫二层
Changjinglv[2006]={35,45}--地宫三层
Changjinglv[2007]={45,50}--地宫四层
Changjinglv[2008]={45,50}--地宫五层
Changjinglv[2090]={45,50}--地宫六层
-------------
Changjinglv[1110]={11,21}--大唐国境
Changjinglv[1173]={20,30}--大唐境外
Changjinglv[1091]={26,36}--长寿郊外
Changjinglv[1512]={32,42}--魔王寨
Changjinglv[1140]={36,46}--普陀山
Changjinglv[1513]={38,48}--盘丝岭
Changjinglv[1131]={40,50}--狮驼岭
Changjinglv[1514]={29,39}--花果山
Changjinglv[1118]={33,43}--海底迷宫一层
Changjinglv[1119]={35,45}--海底迷宫二层
Changjinglv[1120]={37,47}--海底迷宫三层
Changjinglv[1121]={40,55}--海底迷宫四层
Changjinglv[1532]={55,65}--海底迷宫五层
Changjinglv[1127]={33,43}--地狱迷宫一层
Changjinglv[1128]={35,45}--地狱迷宫二层
Changjinglv[1129]={37,47}--地狱迷宫三层
Changjinglv[1130]={40,55}--地狱迷宫四层
Changjinglv[1202]={100,110}--无名鬼城
Changjinglv[1174]={40,55}--北俱芦洲
Changjinglv[1177]={42,52}--龙窟一层
Changjinglv[1178]={44,54}--龙窟二层
Changjinglv[1179]={46,56}--龙窟三层
Changjinglv[1180]={48,58}--龙窟四层
Changjinglv[1181]={50,60}--龙窟五层
Changjinglv[1182]={60,70}--龙窟六层
Changjinglv[1183]={80,90}--龙窟七层
Changjinglv[1186]={42,52}--凤巢一层
Changjinglv[1187]={44,54}--凤巢二层
Changjinglv[1188]={46,56}--凤巢三层
Changjinglv[1189]={48,58}--凤巢四层
Changjinglv[1190]={50,60}--凤巢五层
Changjinglv[1191]={70,80}--凤巢六层
Changjinglv[1192]={80,90}--凤巢七层
Changjinglv[1201]={100,110}--女娲神迹
Changjinglv[1207]={130,145}--蓬莱仙岛
Changjinglv[1203]={115,125}--小西天
Changjinglv[1204]={125,135}--小雷音寺
Changjinglv[1114]={40,50}--月宫
Changjinglv[1231]={150,160}--蟠桃园
Changjinglv[1221]={140,150}--墨家禁地
Changjinglv[1042]={80,90}--解阳山
Changjinglv[1041]={70,80}--子母河底
Changjinglv[1210]={90,100}--麒麟山
Changjinglv[1228]={130,140}--碗子山
Changjinglv[1229]={150,160}--波月洞
Changjinglv[1233]={150,155}--柳林坡
Changjinglv[1232]={155,160}--比丘国
Changjinglv[1242]={170,180}--须弥东界
Changjinglv[1605]={50,55}--天鸣洞天
Changjinglv[1223]={50,55}--观星台
Changjinglv[1876]={30,45}--南岭山
Changjinglv[1920]={170,180}--凌云渡
Changjinglv[1235]={33,63}--丝绸之路

function 取场景等级(map)
	if Changjinglv[map] then
	    return Changjinglv[map][1],Changjinglv[map][2]
	end
end
