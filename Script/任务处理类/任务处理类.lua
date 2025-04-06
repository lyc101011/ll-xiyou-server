
local lsbiao = {}
local 任务处理类 = class()
function 任务处理类:初始化()end

function 任务处理类:取任务说明(玩家id,任务id)
	local 说明={}
	if 任务数据[任务id]==nil then
		return {}
	else
		if 任务数据[任务id].类型>=1132 and 任务数据[任务id].类型<=1142 then --铃铛怪
			说明=降妖伏魔:任务说明(玩家id,任务id)
		elseif 任务数据[任务id].类型==2002 then
			说明=墨魂笔之踪:任务说明(玩家id,任务id)
		elseif 任务数据[任务id].类型==2003 then
			说明=神归昆仑镜:任务说明(玩家id,任务id)
		elseif 任务数据[任务id].类型==6666 then
			说明=彩虹争霸:任务说明(玩家id,任务id)
		elseif 任务数据[任务id].类型==1163 then
			说明=文韵墨香:任务说明(玩家id,任务id)
		elseif 任务数据[任务id].类型==1166 then
			说明=天降辰星:任务说明(玩家id,任务id)
		elseif 任务数据[任务id].类型==1180 then
			说明=帮派迷宫:任务说明(玩家id,任务id)
		elseif 任务数据[任务id].类型==109 then
			说明=游泳活动:任务说明(玩家id,任务id)
		elseif 任务数据[任务id].类型==690 then
			说明=副本_一斛珠:任务说明(玩家id,任务id)
		elseif 任务数据[任务id].类型==710 then
			说明=副本_通天河:任务说明(玩家id,任务id)
		-- elseif 任务数据[任务id].类型==749 then
		-- 	说明=天罡星:三BOSS任务说明(玩家id,任务id)
		-- elseif 任务数据[任务id].类型==750 then
		-- 	说明=天罡星:头领任务说明(玩家id,任务id)
		elseif 任务数据[任务id].类型==800 then
			说明=副本_双城记:任务说明(玩家id,任务id)
		elseif 任务数据[任务id].类型==208 then
			说明=镖王任务:任务说明(玩家id,任务id)
    elseif 任务数据[任务id].类型==950 then
      说明=副本_天火之殇上:任务说明(玩家id,任务id)
    elseif 任务数据[任务id].类型==906 then
      说明=副本_无底洞:任务说明(玩家id,任务id)
		elseif 任务数据[任务id].类型==19 then --牵魂香
			说明={"鬼王支线",format("将驱邪扇芝转交%s，令他摆脱邪灵。请勿与队员分开，否贼法术将会失效（剩余"..取分(任务数据[任务id].结束-(os.time()-任务数据[任务id].起始)).."分钟）",任务数据[任务id].任务NPC)}
		elseif 任务数据[任务id].类型==302 then
			if 任务数据[任务id].分类 == 1 then
				说明={"玄武任务",format("请帮我将这封书信送给#Y%s#W的#R%s#W，事出紧急，切勿在路上耽搁。",取地图名称(任务数据[任务id].人物地图),任务数据[任务id].人物)}
			elseif 任务数据[任务id].分类 == 2 then
				说明={"玄武任务",format("近日物资紧缺，请你前寻找#R%s#W，事出紧急，切勿在路上耽搁。",任务数据[任务id].药品)}
			elseif 任务数据[任务id].分类 == 3 then
				说明={"玄武任务",format("近日物资紧缺，请你前寻找#R%s#W，事出紧急，切勿在路上耽搁。",任务数据[任务id].烹饪)}
			end
		elseif 任务数据[任务id].类型==90 then
			local 副本id=任务数据[任务id].副本id
			if 副本数据.秘境降妖.进行[副本id]==nil then
			说明={"秘境降妖","#L您的副本已经结束"}
			else
        local 进程=副本数据.秘境降妖.进行[副本id].进程
        if 进程==1 then
          说明={"秘境降妖",format("#W/请在20分钟内消灭该场景内的#R/特处士兵#W/(当前剩余：#Y/%s#W/尚未消灭)，否则副本会失败！距离副本结束剩余:#R/%s#W分钟",副本数据.秘境降妖.进行[副本id].数量,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==2 then
          说明={"秘境降妖",format("#W/请在20分钟内消灭该场景内的#R/偏将军#W/(当前剩余：#Y/%s#W/尚未消灭)，否则副本会失败！距离副本结束剩余:#R/%s#W分钟",副本数据.秘境降妖.进行[副本id].数量,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==3 then
          说明={"秘境降妖",format("#W/请在20分钟内寻找该场景内的#R/战败者#W/，并对其进行救治(当前剩余：#Y/%s#W/尚未找到)，否则副本会失败！距离副本结束剩余:#R/%s#W分钟",副本数据.秘境降妖.进行[副本id].数量,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==4 then
          说明={"秘境降妖",format("#W/请在20分钟内消灭该场景内的#R/秘境魔头#W/(当前剩余：#Y/%s#W/尚未消灭)，否则副本会失败！距离副本结束剩余:#R/%s#W分钟",副本数据.秘境降妖.进行[副本id].数量,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==5 then
          说明={"秘境降妖",format("#W/请在20分钟内消灭该场景内的#R/白衣秀士#W/(当前剩余：#Y/%s#W/尚未消灭)，否则副本会失败！距离副本结束剩余:#R/%s#W分钟",副本数据.秘境降妖.进行[副本id].数量,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==6 then
          说明={"秘境降妖",format("#W/请在20分钟内寻找该场景内的#R/熊山君的武器箱#W/(当前剩余：#Y/%s#W/尚未找到)，否则副本会失败！距离副本结束剩余:#R/%s#W分钟",副本数据.秘境降妖.进行[副本id].数量,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==7 then
          说明={"秘境降妖",format("#W/请在20分钟内消灭该场景内的#R/秘境老妖#W/(当前剩余：#Y/%s#W/尚未消灭)，否则副本会失败！距离副本结束剩余:#R/%s#W分钟",副本数据.秘境降妖.进行[副本id].数量,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==8 then
          说明={"秘境降妖",format("#W/请在20分钟内找到秘境内的#G/唐王#W/通过他的指点进行后续任务！否则副本会失败！距离副本结束剩余:#R/%s#W分钟",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==9 then
          说明={"秘境降妖",format("#W/请在20分钟内消灭该场景内的#R/秘境牛魔#W/(当前剩余：#Y/%s#W/尚未消灭)，否则副本会失败！距离副本结束剩余:#R/%s#W分钟",副本数据.秘境降妖.进行[副本id].数量,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==10 then
          说明={"秘境降妖",format("#W/请在20分钟内消灭该场景内的#R/秘境圣子#W/(当前剩余：#Y/%s#W/尚未消灭)，否则副本会失败！距离副本结束剩余:#R/%s#W分钟",副本数据.秘境降妖.进行[副本id].数量,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==11 then
          说明={"秘境降妖",format("#W/请在20分钟内找到秘境内的#R/秘境妖王#W/并将其消灭，否则副本会失败！距离副本结束剩余:#R/%s#W分钟",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        end
      end
      elseif 任务数据[任务id].类型==70 then
            local 副本id=任务数据[任务id].副本id
            if 副本数据.大闹天宫.进行[副本id]==nil then
              说明={"大闹天宫","#L您的副本已经结束"}
                  else
            local 进程=副本数据.大闹天宫.进行[副本id].进程
            if 进程==1 then
              说明={"大闹天宫",format("#W/分别帮助蟠桃园中的#R/锄树力士、云水力士、修桃力士#W/完成任务！请在#R/20分钟#W/内完成该轮任务,否则副本将会失败！距离副本结束剩余:#R/%s#W分钟",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==2 then
              说明={"大闹天宫",format("#W/蟠桃园整修一新,竟唤来一阵清风,吹落些许#G/蟠桃#W/,各位请速速前往拾取(当前剩余：#Y/%s#W/)！距离副本结束剩余:#R/%s#W分钟)",(副本数据.大闹天宫.进行[副本id].数量),取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==3 then
              说明={"大闹天宫",format("#W/恰巧#R/七仙女#W/奉王母之命前来蟠桃园取仙桃,竟然发现大圣你竟然在偷食蟠桃！#R(需战斗))")}
        elseif 进程==4 then
            local 完成数据 = {"造酒仙官","运水道人","烧火童子","盘槽力士"}
            local 介绍 = ""
            for i=1,#完成数据 do
            if 副本数据.大闹天宫.进行[副本id].战诸神[完成数据[i]] == false then
                介绍=介绍.."、"..完成数据[i]
        end
          end
              说明={"大闹天宫",format("#W/蟠桃会已经开始了,你变化为赤脚大仙前往蟠桃会欲要搅闹一番分别与#R%s#W/对话#R(部分需战斗)#W/，距离副本结束剩余:#R/%s#W分钟",介绍,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==5 then
              说明={"大闹天宫",format("#W/回到花果山的你将蟠桃宴中的美食一一分给#G/饥饿的小猴#W/(当前剩余：#Y/%s#W/未找到)，距离副本结束剩余:#R/%s#W分钟",副本数据.大闹天宫.进行[副本id].数量,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==6 then
              说明={"大闹天宫",format("#W/玉帝派遣十万天兵天将下界捉你，正与#R/崩芭二将#W/打的难分难舍,见状你急忙前去帮忙，距离副本结束剩余:#R/%s#W分钟",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==7 then
              说明={"大闹天宫",format("#W/诸神虽然神通勇猛，但也拿你毫无办法，被一一击退。正在此时，来自普陀山的#G/观音姐姐#W/出现，并带来了两员救兵，手下弟子#R/惠岸行者#W/以及#R/二郎真君#W/，距离副本结束剩余:#R/%s#W分钟",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==8 then
              说明={"大闹天宫",format("#W/艰难的打败了二郎真君，你来到了天宫外欲找#R/xx/玉皇大帝#W/理论一二。#R(需战斗)")}
          end
      end


     elseif 任务数据[任务id].类型==191 then
      local 副本id=任务数据[任务id].副本id
      if 副本数据.齐天大圣.进行[副本id]==nil then
        说明={"齐天大圣","#L您的副本已经完成"}
      else
        local 进程=副本数据.齐天大圣.进行[副本id].进程
        if 进程==1 then
          说明={"齐天大圣",format("#L通过傲来国#R/xx/金毛猴#W/前往花果山前山，四处安抚下猴群吧！\n#R伤心的小猴#L当前剩余: %s\n#R临死的老猴#L当前剩余: %s\n距离副本结束剩余:#R/%s#W分钟(如未刷新,重新进入副本)",副本数据.齐天大圣.进行[副本id].小猴老猴.伤心的小猴,副本数据.齐天大圣.进行[副本id].小猴老猴.临死的老猴,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==2 then
          说明={"齐天大圣",format("#R黑白无常#L前来拘魂濒死的老猴,前往(110,103),(31,20)附近与其交涉。\n白无常(#G/%s#W//1)\n黑无常(#G/%s#W//1)\n距离副本结束剩余:#R/%s#W分钟",副本数据.齐天大圣.进行[副本id].无常.白无常,副本数据.齐天大圣.进行[副本id].无常.黑无常,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==3 then
          说明={"齐天大圣",format("#L得悉生死簿之秘,前往地府寻找崔判官。")}
        elseif 进程==4 then
          说明={"齐天大圣",format("#L获知生死簿保存在阎王手中，向阎王索取生死簿！")}
        elseif 进程==5 then
          说明={"齐天大圣",format("#L拿来生死簿,我改改改！天庭获悉后,派遣太白金星(110,103)前来招安！")}
        elseif 进程==6 then
          说明={"齐天大圣",format("#L向玉皇大帝展示本领，在继续挑战四大天王之一！\n玉皇大帝(#G/%s#W//1)\n四大天王(#G/%s#W//1)\n距离副本结束剩余:#R/%s#W分钟",副本数据.齐天大圣.进行[副本id].展示实力.玉皇大帝,副本数据.齐天大圣.进行[副本id].展示实力.四大天王,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==7 then
          说明={"齐天大圣",format("#L实力展示完毕,找玉帝授封吧！")}
        elseif 进程==8 then
          说明={"齐天大圣",format("#L发现盗马贼,前往驱逐盗马贼吧！剩余盗马贼:#R%s",副本数据.齐天大圣.进行[副本id].盗马贼)}
        elseif 进程==9 then
          说明={"齐天大圣",format("#L一匹调皮的小马跑了出去,抓紧快去巡回吧。")}
        elseif 进程==10 then
          说明={"齐天大圣",format("#L近日闲来无事,初来天庭四处逛逛吧!(对话#R/天蓬元帅#W/)(243.105)。")}
        elseif 进程==11 then
          说明={"齐天大圣",format("#L玉帝大怒，命托塔天王率巨灵神下界降服你，百万天兵闯入花果山,喝退百万天兵,打退巨灵神后对话李靖。\n百万天兵(#G/%s#W//1)\n巨灵神(#G/%s#W//1)\n距离副本结束剩余:#R/%s#W分钟",副本数据.齐天大圣.进行[副本id].百万天兵.百万天兵,副本数据.齐天大圣.进行[副本id].百万天兵.巨灵神,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==12 then
          说明={"齐天大圣",format("#L托塔天王使出七宝玲珑塔，进入塔中挑战镇塔神灵。")}
        end
      end

    elseif 任务数据[任务id].类型==71 then
      说明={"大闹天宫",format("#W/帮助蟠桃园中的#R锄树力士#W/前往#R(%s,%s)#K处附近进行锄树清草吧！请在#R/20分钟#W/内完成该轮任务,否则副本将会失败！",任务数据[任务id].x,任务数据[任务id].y)}
    elseif 任务数据[任务id].类型==72 then
      说明={"大闹天宫",format("#W/帮助蟠桃园中的#R浇水力士#W/前往#R/xx/%s#W/处为其浇水吧！请在#R/20分钟#W/内完成该轮任务,否则副本将会失败！",任务数据[任务id].目标)}
    elseif 任务数据[任务id].类型==73 then
      说明={"大闹天宫",format("#W/帮助蟠桃园中的#R修桃力士#W/前往#R/xx/%s#W/处修整蟠桃树吧！请在#R/20分钟#W/内完成该轮任务,否则副本将会失败！",任务数据[任务id].目标)}

    elseif 任务数据[任务id].类型==956 then
      说明={"天火之殇上部",format("#W/前往#R(%s,%s)#W/处使用拘魂镜！请在#R/20分钟#W/内完成该轮任务,否则副本将会失败！",任务数据[任务id].x,任务数据[任务id].y)}


    elseif 任务数据[任务id].类型==80 then
      local 副本id=任务数据[任务id].副本id
      if 副本数据.黑风山.进行[副本id]==nil then
        说明={"黑风山","#L您的副本已经结束"}
      else
        local 进程=副本数据.黑风山.进行[副本id].进程
        if 进程==1 then
          说明={"黑风山",format("#W/分别帮助的#R/镇山太保、婆婆、唐玄奘#W/完成他们安排的任务！距离副本结束剩余:#R/%s#W分钟",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==2 then
          说明={"黑风山",format("#W/超度大会开始了，要保护#G/玄奘#W/不受#R/鬼魂#W/的干扰！(当前剩余：#Y/%s#W/未超度)，请在#R/20分钟#W/内完成该轮任务,否则副本将会失败！距离副本结束剩余:#R/%s#W分钟)",(副本数据.黑风山.进行[副本id].数量),取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==3 then
          说明={"黑风山",format("#W/山下突然出现一只#R/xx/恶虎#W/抓紧前往收服，避免伤及无辜！请在#R/20分钟#W/内完成该轮任务,否则副本将会失败！距离副本结束剩余:#R/%s#W分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==4 then
          说明={"黑风山",format("#W/你发现了一只#R/xx/鬼鬼祟祟的黑熊精#W/,你偷偷的跟了上去在背后打他了个措手不及！距离副本结束剩余:#R/%s#W分钟",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==5 then
          说明={"黑风山",format("#W/来到了#G/观音寺#W/却发现观音寺内已经燃起了熊熊大火，抓紧去将火势扑灭(当前剩余：#Y/%s#W/未找到)，距离副本结束剩余:#R/%s#W分钟",副本数据.黑风山.进行[副本id].数量,取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==6 then
          说明={"黑风山",format("#W/终于将火势铺面，混乱中#G/唐僧#W的袈裟精竟然丢失了，想起了那鬼鬼祟祟的黑熊精，你来到了#R/黑风山#W/寻找妖怪的痕迹，终于在右边山顶发现了3个形迹可疑的人，与之战斗！请在#R/20分钟#W/内完成该轮任务,否则副本将会失败！距离副本结束剩余:#R/%s#W分钟",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==7 then
          说明={"黑风山",format("#W/沿着山路一路收拾小妖，请在#R/20分钟#W/内完成该轮任务,否则副本将会失败！距离副本结束剩余:#R/%s#W分钟",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        elseif 进程==8 then
          说明={"黑风山",format("#W/你来到了黑风洞内，#R/xx/黑熊精#W/正观赏#G/袈裟#W/你上前便与他理论！距离副本结束剩余:#R/%s#W分钟",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
        end
      end
    elseif 任务数据[任务id].类型==81 then
        说明={"黑风山",format("#W/帮助#R婆婆#W/前往#R(%s,%s)#K处附近打扫一下吧！请在#R/20分钟#W/内完成该轮任务,否则副本将会失败！",任务数据[任务id].x,任务数据[任务id].y)}
    elseif 任务数据[任务id].类型==82 then
        说明={"黑风山",format("#W/协助#R镇山太保#W/在附近巡逻一番吧！请在#R/20分钟#W/内完成该轮任务,否则副本将会失败！")}
        elseif 任务数据[任务id].类型==900 then
        local 副本id=任务数据[任务id].副本id
        if 副本数据.泾河龙王.进行[副本id]==nil then
          说明={"泾河龙王","#L您的副本已经完成"}
        else
          local 进程=副本数据.泾河龙王.进行[副本id].进程
          local 数量=副本数据.泾河龙王.进行[副本id].数量
          local 序列=副本数据.泾河龙王.进行[副本id].序列
          if 进程==1 then
            说明={"泾河龙王",format("龙太子在#R72.78#W好像遇到些麻烦 快向他问问#R(剩余%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
          elseif 进程==2 then
            说明={"泾河龙王",format("路途中龙太子跟你讲起了近日发生在龙宫怪事,特别是万圣公主和九头虫似乎在密谋些什么,不妨去#R91.10#W问问她吧#R(剩余%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
          elseif 进程==3 then
            说明={"泾河龙王",format("危急关头九头虫出现在万圣公主身边将她救下,还一脸嘲讽的看着你们,该怎么做不用多说了吧!#R(剩余%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
          elseif 进程==4 then
            说明={"泾河龙王",format("在你打的兴起的时候,九头虫见势不妙竟然带着万圣公主跑了,就当你准备追赶的时候,却被龙太子拦下,去问问他为什么吧#R(剩余%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
          elseif 进程==5 then
            说明={"泾河龙王",format("客随主便,还是听龙太子的去找#R102.53#W处的蟹将问问龙王何在#R(剩余%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
          elseif 进程==6 then
            说明={"泾河龙王",format("跟随龙太子来到东海秘境中,龙太子先行一步回来告诉你在#R41.33#W有个假冒的幽颜将军,看来事态比想象中要严重的多!#R(剩余%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
          elseif 进程==7 then
            说明={"泾河龙王",format("根据假冒幽颜的妖魔交代,龙王此刻正在前方#R48.15#W组织龙军抵御妖魔,速速前往援助!#R(剩余%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
          elseif 进程==8 then
            说明={"泾河龙王",format("遵从龙王的命令,前往#R41.9#W加固蛟魔的封印!#R(剩余%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
          elseif 进程==9 then
            说明={"泾河龙王",format("想不到一不小心犯了大错,打败天将后竟然让相柳冲破了封印#R(剩余%s分钟)",取分((任务数据[任务id].结束-(os.time()-任务数据[任务id].起始))))}
          end
          说明[3]="完成后可获得经验、银子、物品奖励"
        end

		else
			local fun = _G["任务说明"..tostring(任务数据[任务id].类型)]
			if fun ~= nil  then
				说明=fun(玩家id,任务id)
			end
		end
	end
	return 说明
end

function 任务处理类:更新(dt)
	for n, v in pairs(任务数据) do
		if 任务数据[n]~=nil then
			if 任务数据[n].类型>=600 and 任务数据[n].类型<=607  then
				rwgx600(n)
			elseif 任务数据[n].类型>=610 and 任务数据[n].类型<=621  then
				rwgx610(n)
			elseif 任务数据[n].类型>=630 and 任务数据[n].类型<=637  then
				rwgx630(n)
			elseif 任务数据[n].类型>=640 and 任务数据[n].类型<=649  then
				rwgx640(n)
			elseif 任务数据[n].类型 >= 70 and 任务数据[n].类型 <= 79 then
        大闹天宫副本失败(n)
      elseif 任务数据[n].类型 >= 80 and 任务数据[n].类型 <= 89 then
        黑风山副本失败(n)
       elseif 任务数据[n].类型 >= 90 and 任务数据[n].类型 <= 100 or 任务数据[n].类型 == 105 then
        秘境降妖副本失败(n)
			elseif 任务数据[n].类型>=740 and 任务数据[n].类型<=745  then
				rwgx740(n)
      elseif 任务数据[n].类型 >= 950 and 任务数据[n].类型 <= 968 then
            天火之殇上副本失败(n)
      elseif 任务数据[n].类型 >= 191 and 任务数据[n].类型 <= 197 then
            齐天大圣副本失败(n)

			-----------------------------沉默分身
		  elseif 任务数据[n].销毁 and 任务数据[n].类型 == 3487 and 沉默分身[n] ~= nil and (os.time()-任务数据[n].起始>=任务数据[n].结束) then
				for k,v in pairs(玩家数据) do
					if 战斗准备类.战斗盒子[玩家数据[v.角色.数字id].zhandou] and 战斗准备类.战斗盒子[玩家数据[v.角色.数字id].zhandou].任务id == n and 玩家数据[v.角色.数字id].队长 then
						战斗准备类.战斗盒子[玩家数据[v.角色.数字id].zhandou]:强制结束战斗()
					end
				end
				沉默分身类:沉默分身活动结束处理(n)
				if 任务数据[n] and 任务数据[n].地图编号 and 任务数据[n].单位编号 then
					地图处理类:删除单位(任务数据[n].地图编号,任务数据[n].单位编号)
				end
				if 沉默分身[n] ~= nil then
					沉默分身[n] = nil
				end
				return

			else
				if 任务数据[n].销毁 and not 任务数据[n].zhandou and 任务数据[n].结束 ~= 99999999 and (os.time()-任务数据[n].起始>=任务数据[n].结束) then -- 任务时间到期
					if 任务数据[n].DWZ then
						for a,b in pairs(任务数据[n].DWZ) do
							if 玩家数据[b] and 玩家数据[b].角色 then
								玩家数据[b].角色:任务到期(n)
							end
						end
					end
					if 任务数据[n].地图编号 and 任务数据[n].单位编号 then
						地图处理类:删除单位(任务数据[n].地图编号,任务数据[n].单位编号)
					end
					任务数据[n]=nil
					return
				end
				local fun = _G["rwgx"..tostring(任务数据[n].类型)]
				if fun ~= nil  then
					fun(n)
				end
			end
		end
	end
end

function 任务处理类:取编号()
	for n, v in pairs(任务数据) do
		if n==nil and n>=1000 then
			return n
		end
	end
	local 临时id=#任务数据+1
	if 任务数据[临时id]==nil then
		return 临时id
	else
		for n=1000,100000 do
		if 任务数据[n]==nil then return n end
		end
	end
end

function 任务处理类:副本传送(id,类型)
	if 玩家数据[id].队伍==0 or 玩家数据[id].队长==false  then
		常规提示(id,"#Y/该任务必须组队完成且由队长领取")
		return
	elseif 取队伍人数(id)<0 and 调试模式==false then
		常规提示(id,"#Y此副本要求队伍人数不低于5人")
		return
	end
	if 类型==1 then --乌鸡国
		if 玩家数据[id].角色:取任务(120)==0 then
			常规提示(id,"#Y/你尚未开启此副本")
			return
		end
		local 副本id=任务数据[玩家数据[id].角色:取任务(120)].副本id
		local 进程=副本数据.乌鸡国.进行[副本id].进程
		local 地图=6001
		local x=0
		local y=0
		if 进程<3 then
			x,y=112,14
		else
			地图=6002
			x,y=29,56
		end
		地图处理类:跳转地图(id,地图,x,y)
	elseif 类型==2 then --水陆大会
		if 玩家数据[id].角色:取任务(600)==0 then
			常规提示(id,"#Y/你尚未开启此副本")
			return
		end
		local 副本id=任务数据[玩家数据[id].角色:取任务(600)].副本id
		local 进程=副本数据.水陆大会.进行[副本id].进程
		local 地图=6003
		local x=0
		local y=0
		if 进程<5 then
			x,y=319,198
		else
			地图=6004
			x,y=35,72
		end
		地图处理类:跳转地图(id,地图,x,y)
	elseif 类型==3 then --车迟斗法
		if 玩家数据[id].角色:取任务(610)==0 then
			常规提示(id,"#Y/你尚未开启此副本")
			return
		end
		local 副本id=任务数据[玩家数据[id].角色:取任务(610)].副本id
		local 进程=副本数据.车迟斗法.进行[副本id].进程
		local 地图=6005
		local x=98
		local y=136
		if 进程>3 then
			地图=6006
			x,y=24,23
		end
		if  进程>4 then
			地图=6007
			x,y=35,151
		end
		地图处理类:跳转地图(id,地图,x,y)
	elseif 类型==4 then --轮回境
		if 玩家数据[id].角色:取任务(630)==0 then
			常规提示(id,"#Y/你尚未开启此副本")
			return
		end
		local 副本id=任务数据[玩家数据[id].角色:取任务(630)].副本id
		local 进程=副本数据.轮回境.进行[副本id].进程
		local 地图=2000
		local x=122
		local y=75
		地图处理类:跳转地图(id,地图,x,y)
	elseif 类型==5 then --七绝山
		if 玩家数据[id].角色:取任务(640)==0 then
			常规提示(id,"#Y/你尚未开启此副本")
			return
		end
		local 副本id=任务数据[玩家数据[id].角色:取任务(640)].副本id
		local 进程=副本数据.七绝山.进行[副本id].进程
		local 地图=6008
		local x=41
		local y=81
		if 进程==6 or 进程==8 then
		 	地图=6010
			x,y=11,78
		elseif 进程==7 then
		 	地图=6011
			x,y=21,81
		elseif 进程==1  or 进程==2  or  进程==9 then
		 	地图=6008
			x,y=67,89
		elseif 进程==3  or 进程==4  or 进程==5  then
			地图=6009
			x,y=21,51
		end
		地图处理类:跳转地图(id,地图,x,y)
	elseif 类型==6 then --四季
	elseif 类型==7 then --红孩儿
		if 玩家数据[id].角色:取任务(740)==0 then
			常规提示(id,"#Y/你尚未开启此副本")
			return
		end
		local 副本id=任务数据[玩家数据[id].角色:取任务(740)].副本id
		local 进程=副本数据.红孩儿.进行[副本id].进程
		local 地图=7026
		local x=48
		local y=87
		if 进程==6 or 进程==8 then
		 	地图=6010
			x,y=11,78
		elseif 进程==7 then
		 	地图=6011
			x,y=21,81
		elseif 进程==1  or 进程==2  or  进程==9 then
		 	地图=7026
			x,y=48,87
		elseif 进程==3  or 进程==4  or 进程==5  then
			地图=7027
			x,y=21,51
		end
		地图处理类:跳转地图(id,地图,x,y)
	elseif 类型==11 then --泾河龙王  SB玩意谁家的
	if 玩家数据[id].角色:取任务(900)==0 then
			常规提示(id,"#Y/你尚未开启此副本")
			return
		end
    local 副本id=任务数据[玩家数据[id].角色:取任务(900)].副本id
    local 进程=副本数据.泾河龙王.进行[副本id].进程
    local 地图=7035
    local x=20
    local y=104
    地图处理类:跳转地图(id,地图,x,y)
	elseif 类型==8 then --如梦奇谭 五更寒
		if 玩家数据[id].角色:取任务(670)==0 then
			常规提示(id,"#Y/你尚未开启此副本")
			return
		end
	 	local 副本id=任务数据[玩家数据[id].角色:取任务(670)].副本id
	 	local 进程=副本数据.如梦奇谭之五更寒.进行[副本id].进程
	 	if 进程==0 or 进程==1 or 进程==2 then
			地图=7001
			x,y=36,31
		elseif 进程==3 then
			地图=7002
			x,y=17,25
		elseif 进程>=4 then
			地图=7005
			x,y=135,64
		end
		地图处理类:跳转地图(id,地图,x,y)
	elseif 类型==9 then --如梦奇谭 一斛珠
		if 玩家数据[id].角色:取任务(690)==0 then
			常规提示(id,"#Y/你尚未开启此副本")
			return
		end
	 	local 副本id=任务数据[玩家数据[id].角色:取任务(690)].副本id
	 	local 进程=副本数据.如梦奇谭之一斛珠.进行[副本id].进程
	 	if 进程==0 or 进程==1 or 进程==2 or 进程==3 then
			地图=7006
			x,y=142,60
		elseif 进程==4 or 进程==5 or 进程==6  then
			地图=7007
			x,y=31,22
		elseif 进程==7 or 进程==8  then
			地图=7006
			x,y=140,90
		elseif 进程>=9 then
			地图=7008
			x,y=35,72
		end
		地图处理类:跳转地图(id,地图,x,y)
	elseif 类型==10 then --如梦奇谭 双城记
		if 玩家数据[id].角色:取任务(800)==0 then
			常规提示(id,"#Y/你尚未开启此副本")
			return
		end
	 	local 副本id=任务数据[玩家数据[id].角色:取任务(800)].副本id
	 	local 进程=副本数据.如梦奇谭之双城记.进行[副本id].进程
	 	if 进程==0 or 进程==1 or 进程==2 or 进程==3 or 进程==4 or 进程==5 or 进程==6 then
			地图=7021
			x,y=56,48
		elseif 进程==7 or 进程==8 or 进程==9  or 进程==10 then
			地图=7022
			x,y=10,92
		elseif 进程==11 or 进程==12  or 进程==13 then
			地图=7023
			x,y=139,51
		elseif 进程==14 or 进程==15 or 进程==16 then
			地图=7024
			x,y=389,74
		elseif 进程>=17 then
			地图=7025
			x,y=168,99
		end
		地图处理类:跳转地图(id,地图,x,y)
		--新增
		elseif 类型==12 then --通天河
		if 玩家数据[id].角色:取任务(710)==0 then --710
			常规提示(id,"#Y/你尚未开启此副本1")
			return
		end
		local 副本id=任务数据[玩家数据[id].角色:取任务(710)].副本id
	 	local 进程=副本数据.通天河.进行[副本id].进程
	 	local 地图=7017
	 	local x=0
		local y=0
		if 进程==1 then
			x,y=94,192
		elseif 进程==2 then
			x,y=94,192
		elseif 进程==3 then
			x,y=94,192
		elseif 进程 ==4 then
			地图=7018
			x,y=94,192
		elseif 进程 ==5 then
			地图=7018
			x,y=19,24
		elseif 进程 ==6 then
			地图=7019
			x,y=99,58
		else
			地图=7020
			x,y=41,37
		end
		地图处理类:跳转地图(id,地图,x,y)
		elseif 类型==70 then --大闹天宫
                local 副本id=任务数据[玩家数据[id].角色:取任务(70)].副本id
                local 进程=副本数据.大闹天宫.进行[副本id].进程
                local 地图=6033
                local x=97
                local y=43
                if 进程<4 then
                  x,y=97,43
                elseif 进程<5 then
                  地图=6034
                  x,y=27,22
                elseif 进程<8 then
                  地图=6035
                  x,y=103,59
                else
                  地图=6037
                  x,y=180,121
                end
                地图处理类:跳转地图(id,地图,x,y)
    elseif 类型==80 then --黑风山
                local 副本id=任务数据[玩家数据[id].角色:取任务(80)].副本id
                local 进程=副本数据.黑风山.进行[副本id].进程
                local 地图=6018
                local x=39
                local y=24
                if 进程<5 then
                  x,y=39,24
                elseif 进程<6 then
                  地图=6019
                  x,y=33,75
                elseif 进程<8 then
                  地图=6020
                  x,y=163,136
                else
                  地图=6021
                  x,y=47,88
                end
                地图处理类:跳转地图(id,地图,x,y)
    elseif 类型==90 then --秘境降妖
                local 副本id=任务数据[玩家数据[id].角色:取任务(90)].副本id
                local 进程=副本数据.秘境降妖.进行[副本id].进程
                local 地图=6021+副本数据.秘境降妖.进行[副本id].进程
                local xy=地图处理类.地图坐标[地图]:取随机点()
                地图处理类:跳转地图(id,地图,xy.x,xy.y)
	   elseif 类型==950 then --天火之殇上
    local 副本id=任务数据[玩家数据[id].角色:取任务(950)].副本id
    local 进程=副本数据.天火之殇上.进行[副本id].进程
    local 地图=6054
    local x=0
    local y=0
    if 进程<8 then
      x,y=124,61
    elseif 进程<13 then
      地图=6055
      x,y=94,75
    elseif 进程==13 then
      地图=6056
      x,y=98,72
    else
      地图=6054
      x,y=124,61
    end
    地图处理类:跳转地图(id,地图,x,y)
   elseif 类型==191 then --齐天大圣
    if 玩家数据[id].角色:取任务(191)==0 then
      常规提示(id,"#Y/你尚未开启此副本")
      return
    elseif 玩家数据[id].队伍 ~= 0 then
      for i=1,#队伍数据[玩家数据[id].队伍 ].成员数据 do
        if i~=1 and (玩家数据[队伍数据[玩家数据[id].队伍].成员数据[i]].角色:取任务(191)==0 or 玩家数据[队伍数据[玩家数据[id].队伍].成员数据[i]].角色:取任务(191) ~= 玩家数据[id].角色:取任务(191) ) then
          常规提示(id,玩家数据[队伍数据[玩家数据[id].队伍].成员数据[i]].角色.数据.名称.."#Y/尚未开启此副本或者与您并不是同一个副本")
          return
        end
      end
    end
    local 副本id=任务数据[玩家数据[id].角色:取任务(191)].副本id
    local 进程=副本数据.齐天大圣.进行[副本id].进程
    local 地图=6043
    local x=12
    local y=108
    if 进程 ==1 then
      x,y=12,108
   elseif  进程 ==2 then
      x,y=12,108
    elseif 进程 <= 4 then
      地图=6044
      x,y=100,101
    elseif 进程 == 5 then
      地图=6043
      x,y=12,108
    elseif 进程 <=10 then
      地图=6045
      x,y=203,133
    elseif 进程 == 11 then
      地图=6043
      x,y=12,108
    elseif 进程 == 12 then
      地图=6046
      x,y=30,27
    else
      地图=6048
      x,y=30,38
    end
    地图处理类:跳转地图(id,地图,x,y)
  elseif 类型==906 then --无底洞
    local 副本id=任务数据[玩家数据[id].角色:取任务(906)].副本id
    local 进程=副本数据.无底洞.进行[副本id].进程
    local 地图=6047
    local x=12
    local y=88
    if 进程 <= 3 then
      x,y=12,88
    elseif 进程 == 4 then
      地图=6047
      x,y=12,88
    elseif 进程 <= 8 then
      地图=6048
      x,y=33,73
    elseif 进程 == 9 then
      地图=6049
      x,y=7,28
    elseif 进程 == 10 then
      地图=6050
      x,y=79,70
    elseif 进程 == 12 then
      地图=6051
      x,y=79,70
    elseif 进程 == 14 then
      地图=6052
      x,y=59,62
    elseif 进程 == 17 then
      地图=6053
      x,y=10,17
    else
      地图=6047
      x,y=12,88
    end
     地图处理类:跳转地图(id,地图,x,y)
	  elseif 类型==350 then --泾河龙王
                local 副本id=任务数据[玩家数据[id].角色:取任务(350)].副本id
                local 进程=副本数据.泾河龙王.进行[副本id].进程
	            	local 地图=6038
	            	local x=0
	            	local y=0
	            	if 进程<3 then
	            		x,y=14,79
	            	elseif 进程==6 then
	            		地图=6040
                  x,y=38,29
                elseif 进程==8 then
	            		地图=6041
                  x,y=425,169
                elseif 进程==9 then--测试
	            		地图=6041
                  x,y=395,206
	            	else
	            		地图=6039
	            		x,y=18,38
	            	end
	            	地图处理类:跳转地图(id,地图,x,y)
	end
end

function 任务处理类:判定队伍组(数字id,编号)
	local lssj = 玩家数据[数字id].角色:取任务(编号)
	if 玩家数据[数字id].队伍==0 then
		return 常规提示(数字id,"#Y/该任务必须组队完成")
	end
	local 队员组 = 队伍处理类:取队伍成员(数字id)
	if lssj ~= 0 then
		for i=1,#任务数据[lssj].队伍组 do
			if 队员组[任务数据[lssj].队伍组[i]] == nil then
				return false
			end
		end
	end
	return true
end

function 任务处理类:删除单位(任务id)
	if 任务数据[任务id] and 任务数据[任务id].地图编号 and 任务数据[任务id].单位编号 then
		地图处理类:删除单位(任务数据[任务id].地图编号,任务数据[任务id].单位编号)
		任务数据[任务id]=nil
	end
end

function 任务处理类:删除副本单位(数字id,编号,分类)
	local 副本id = self:取副本id(数字id,编号)
	if 副本id == 0 then
		return
	end
	for n, v in pairs(任务数据) do
		if 任务数据[n]~=nil then
			if 任务数据[n].zhandou~=true then
				if 任务数据[n].类型 == 分类 and 任务数据[n].副本id == 数字id then
					self:删除单位(n)
				end
			end
		end
	end
end

function 任务处理类:删除活动单位(编号)
	for n, v in pairs(任务数据) do
		if 任务数据[n]~=nil then
			if 任务数据[n].类型 == 编号 and 任务数据[n].zhandou ~= true then
				self:删除单位(n)
			end
		end
	end
end

function 任务处理类:删除任务单位检测(地图编号,单位编号,任务id)
	for n, v in pairs(任务数据) do
		if 任务数据[n]~=nil then
			if 任务数据[n].地图编号 == 地图编号 and 任务数据[n].单位编号 == 单位编号 then
				if n ~= 任务id then
					table.insert(lsbiao,任务数据[n].类型)
					写出文件("任务数据打印.txt",table.tostring({lsbiao}))
					任务数据[n] = nil
					return  false
				end
			end
		end
	end
	return true
end

function 任务处理类:取任务队伍组(数字id,编号)
	local lssj = 玩家数据[数字id].角色:取任务(编号)
	if lssj ==0 then
		return false
	else
		return 任务数据[lssj].队伍组
	end
end

function 刷新队伍任务追踪(数字id)
	local 队伍id = 玩家数据[数字id].队伍
	if 队伍id~=0 then
	    for n=1,#队伍数据[队伍id].成员数据 do
			玩家数据[队伍数据[队伍id].成员数据[n]].角色:刷新任务跟踪()
		end
	else
		玩家数据[数字id].角色:刷新任务跟踪()
	end
end

function 删除地图单位(rwid)
	if 任务数据[rwid] then
	    地图处理类:删除单位(任务数据[rwid].地图编号,任务数据[rwid].单位编号)
		任务数据[rwid]=nil
	end
end

function 任务处理类:添加队伍任务(数字id,编号,提示)
	if 编号 ~= 0 then
		for i=1,#任务数据[编号].队伍组 do
			if 玩家数据[任务数据[编号].队伍组[i]] ~= nil then
				玩家数据[任务数据[编号].队伍组[i]].角色:添加任务(编号)
				if 提示 then
					常规提示(任务数据[编号].队伍组[i],提示)
				end
			end
		end
	end
end

function 任务处理类:删除队伍任务(任务id,提示)
	if 任务id ~= 0 then
		for i=1,#任务数据[任务id].队伍组 do
			if 玩家数据[任务数据[任务id].队伍组[i]] ~= nil then
				玩家数据[任务数据[任务id].队伍组[i]].角色:取消任务(任务id)
				if 提示 then
					常规提示(任务数据[任务id].队伍组[i],提示)
				end
			end
		end
	end
end

function 任务处理类:取副本id(数字id,编号)
	local lssj = 玩家数据[数字id].角色:取任务(编号)
	if lssj ~= 0 then
		return  任务数据[lssj].副本id
	end
	return  0
end

function 任务处理类:显示(x,y)end
return 任务处理类