-- @Author: 此套源码仅供学习研究使用,严禁其他非法用途,否则后果自负!
-- @Date:   2022-07-09 17:14:47
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-11-12 00:01:30
-- @Author: 作者QQ381990860
-- @Date:   2022-07-07 13:10:08
-- @Last Modified by:    ★〓光唏蜀黍〓★ QQ:29582348      ★〓光唏蜀黍〓★ Q群:902038863
-- @Last Modified time: 2022-07-09 18:14:45

local 神兵异兽榜 = class()
local 类目={
           "武器排行","项链排行","衣服排行","头盔排行","腰带排行","鞋子排行",
           "手镯排行","佩饰排行","戒指排行","耳饰排行",
           "宝宝排行"
           }
function 神兵异兽榜:装备穿戴处理(id,类型,编号)
   if 玩家数据[id].角色.武神坛角色 then
      return
   end

   local 装备=玩家数据[id].道具.数据[编号]
   local 分数=0
   local 装备分类=装备.分类

   if 装备.级别限制 then
      分数=分数+装备.级别限制*10*装备.级别限制
   end

   if 装备.体质==nil then 装备.体质=0 end
   if 装备.魔力==nil then 装备.魔力=0 end
   if 装备.力量==nil then 装备.力量=0 end
   if 装备.耐力==nil then 装备.耐力=0 end
   if 装备.敏捷==nil then 装备.敏捷=0 end

   if 装备.角色限制~=nil then
      if 装备分类==4 and 装备.角色限制[1]=="影精灵" or 装备.角色限制[1]=="影精灵(九黎城)" or 装备.角色限制[1]=="影精灵（九黎城）" then 装备分类=3 end ---副武器
   end

   if 装备分类==1 and 装备.防御 and 装备.魔法 then
      分数=分数+装备.防御+装备.魔法
   elseif 装备分类==2 and 装备.灵力 then
      分数=分数+装备.灵力
   elseif 装备分类==3 and 装备.命中 and 装备.伤害 then
      分数=分数+装备.命中+装备.伤害                      +装备.体质+装备.魔力+装备.力量+装备.耐力+装备.敏捷
   elseif 装备分类==4 and 装备.防御  then
      分数=分数+装备.防御                               +装备.体质+装备.魔力+装备.力量+装备.耐力+装备.敏捷
   elseif 装备分类==5 and 装备.防御 and 装备.气血 then
      分数=分数+装备.防御+装备.气血
   elseif 装备分类==6 and 装备.防御 and 装备.敏捷 then
      分数=分数+装备.防御+装备.敏捷
   end

   if 装备.锻炼等级 then
      分数=分数 + 装备.锻炼等级*10*装备.锻炼等级
   end

   if 装备.特技 then
      分数=分数+200
   end

   if 装备.特效 then
      分数=分数+200
   end


   装备.分数=分数
   self:删除处理(id,类型)
   local 装备类型x=类型
   if 装备.角色限制~=nil then
      if 装备分类==4 and 装备.角色限制[1]=="影精灵" or 装备.角色限制[1]=="影精灵(九黎城)" or 装备.角色限制[1]=="影精灵（九黎城）" then 装备类型x ="武器" end
   end

   local lx = "临时"..装备类型x.."排行"
   local lspx = 0
   if  self[lx] ~= nil then
      if #self[lx] >= 20 then
         if  分数 > self[lx][20].分数 then
              for n=#self[lx],1,-1 do
                  if 分数 < self[lx][n].分数 then
                        lspx = n + 1
                     break
                  end
              end
          end
      else
         self[lx][#self[lx]+1] = {id=id,物品=table.copy(装备),分数=分数,名称=玩家数据[id].角色.名称}
      end
   else
   self[lx] = {}
   self[lx][1] = {id=id,物品=table.copy(装备),分数=分数,名称=玩家数据[id].角色.名称}
   end
      if lspx ~= 0 then
         for n=lspx,#self[lx] do
            if  n == 20 then
            elseif n==lspx then
                  self[lx][n+1] = table.copy(self[lx][n])
                  self[lx][n] =  {id=id,物品=table.copy(装备),分数=分数,名称=玩家数据[id].角色.名称}
            else
                  self[lx][n+1] = table.copy(self[lx][n])
            end
         end
      end

   --table.insert(self["临时"..类型.."排行"],{id=id,物品=table.copy(装备),分数=分数,名称=玩家数据[id].角色.名称})
end


function 神兵异兽榜:灵饰穿戴处理(id,类型,编号)
   if 玩家数据[id].角色.武神坛角色 then
      return
   end

   if 类型~="耳饰" and 类型~="佩饰" and 类型~="戒指" and 类型~="手镯" then
      return
   end
   local 装备=玩家数据[id].道具.数据[编号]
   local 分数=0
   if 装备.级别限制 then
      分数=分数+装备.级别限制*10*装备.级别限制
   end

   if 装备.特效 then
      分数=分数+500
   end

   if 装备.幻化等级 then
      分数=分数+装备.幻化等级*10*装备.幻化等级
   end

   if 装备.特性 then
      分数=分数+装备.特性.等级*10*装备.特性.等级
   end

   装备.分数=分数
   self:删除处理(id,类型)
        local lx = "临时"..类型.."排行"
        local lspx = 0
   if  self[lx] ~= nil then
      if #self[lx] >= 20 then
         if  分数 > self[lx][20].分数 then
              for n=#self[lx],1,-1 do
                  if 分数 < self[lx][n].分数 then
                        lspx = n + 1
                     break
                  end
              end
          end
      else
    self[lx][#self[lx]+1] = {id=id,物品=table.copy(装备),分数=分数,名称=玩家数据[id].角色.名称}
        end
      else
   self[lx] = {}
   self[lx][1] = {id=id,物品=table.copy(装备),分数=分数,名称=玩家数据[id].角色.名称}
   end
      if lspx ~= 0 then
         for n=lspx,#self[lx] do
            if  n == 20 then
              elseif n==lspx then
                self[lx][n+1] = table.copy(self[lx][n])
                 self[lx][n] =  {id=id,物品=table.copy(装备),分数=分数,名称=玩家数据[id].角色.名称}
            else
    self[lx][n+1] = table.copy(self[lx][n])
             end
          end
      end

   --table.insert(self["临时"..类型.."排行"],{id=id,物品=table.copy(装备),分数=分数,名称=玩家数据[id].角色.名称})
end


function 神兵异兽榜:宝宝参战处理(id,编号)
   if 玩家数据[id].角色.武神坛角色 then
      return
   end

   local 宝宝=玩家数据[id].召唤兽.数据[编号]
   local 分数=0
   分数=分数+宝宝.等级*10
   分数=分数+math.floor(宝宝.成长*5000)

   分数=分数+宝宝.攻击资质
   分数=分数+宝宝.防御资质
   分数=分数+宝宝.体力资质
   分数=分数+宝宝.法力资质
   分数=分数+宝宝.速度资质
   分数=分数+宝宝.躲闪资质
   if 宝宝.技能 then
      for i = 1,#宝宝.技能 do
         分数=分数+i*200
      end

      if type(宝宝.技能[#宝宝.技能])=="string" and string.find(宝宝.技能[#宝宝.技能],"超级") ~=nil and 宝宝.技能[#宝宝.技能]~="超级神柚复生" and 宝宝.技能[#宝宝.技能]~="超级三昧真火" then
         分数=分数+5000
      end
   end

   if 宝宝.丸子技能 then
      for i=1,#宝宝.丸子技能 do
         if 宝宝.丸子技能[i].有此技能 then
               分数=分数+2000
         end
      end
   end

   宝宝.分数=分数
   self:删除处理(id,"宝宝")
     local lspx = 0
   if  self.临时宝宝排行 ~= nil then
      if #self.临时宝宝排行 >= 20 then
         if  分数 > self.临时宝宝排行[20].分数 then
              for n=#self.临时宝宝排行,1,-1 do
                  if 分数 < self.临时宝宝排行[n].分数 then
                        lspx = n + 1
                     break
                  end
              end
          end
      else
    self.临时宝宝排行[#self.临时宝宝排行+1] = {id=id,宝宝=table.copy(宝宝),分数=分数,名称=玩家数据[id].角色.名称}
        end
      else
   self.临时宝宝排行 = {}
   self.临时宝宝排行[1] = {id=id,宝宝=table.copy(宝宝),分数=分数,名称=玩家数据[id].角色.名称}
   end
      if lspx ~= 0 then
         for n=lspx,#self.临时宝宝排行 do
            if  n == 20 then
              elseif n==lspx then
                self.临时宝宝排行[n+1] = table.copy(self.临时宝宝排行[n])
                 self.临时宝宝排行[n] =  {id=id,宝宝=table.copy(宝宝),分数=分数,名称=玩家数据[id].角色.名称}
            else
    self.临时宝宝排行[n+1] = table.copy(self.临时宝宝排行[n])
             end
          end
      end

end

function 神兵异兽榜:删除处理(id,类型)
   for k,v in pairs(self["临时"..类型.."排行"]) do
       if v.id==id  then
          table.remove(self["临时"..类型.."排行"],k)
          break
       end
   end
end

function 神兵异兽榜:初始化计算()
   -- self.装备榜单={}
   -- local 总类=配置读表(f函数.读配置(程序目录 .. "/sql/神兵异兽榜/配置信息/装备榜单.txt", "类目","总类"))
   -- for k,v in pairs(总类) do
   --     self.装备榜单[v]={}
   --     local 临时分类=配置读表(f函数.读配置(程序目录 .. "/sql/神兵异兽榜/配置信息/装备榜单.txt",v,"分类"))
   --     for n,k in pairs(临时分类) do
   --         self.装备榜单[v][k]=tonumber(f函数.读配置(程序目录 .. "/sql/神兵异兽榜/配置信息/装备榜单.txt",v,k) or 0)
   --     end
   -- end
   -- self.灵饰榜单={}
   -- 总类=配置读表(f函数.读配置(程序目录 .. "/sql/神兵异兽榜/配置信息/灵饰榜单.txt", "类目","总类"))
   -- for k,v in pairs(总类) do
   --     self.灵饰榜单[v]={}
   --     local 临时分类=配置读表(f函数.读配置(程序目录 .. "/sql/神兵异兽榜/配置信息/灵饰榜单.txt",v,"分类"))
   --     for n,k in pairs(临时分类) do
   --         self.灵饰榜单[v][k]=tonumber(f函数.读配置(程序目录 .. "/sql/神兵异兽榜/配置信息/灵饰榜单.txt",v,k) or 0)
   --     end
   -- end
   -- self.宝宝榜单={}
   -- 总类=配置读表(f函数.读配置(程序目录 .. "/sql/神兵异兽榜/配置信息/宝宝榜单.txt", "类目","总类"))
   -- for k,v in pairs(总类) do
   --     self.宝宝榜单[v]={}
   --     local 临时分类=配置读表(f函数.读配置(程序目录 .. "/sql/神兵异兽榜/配置信息/宝宝榜单.txt",v,"分类"))
   --     for n,k in pairs(临时分类) do
   --         self.宝宝榜单[v][k]=tonumber(f函数.读配置(程序目录 .. "/sql/神兵异兽榜/配置信息/宝宝榜单.txt",v,k) or 0)
   --     end
   -- end
end

function 神兵异兽榜:初始化数据()
   for k,v in pairs(类目) do
       self[v]=table.loadstring(ReadFile("sql/神兵异兽榜/"..v..".txt"))
       self["临时"..v]=table.copy(self[v])
   end
end

function 神兵异兽榜:排行排序(tab)
   local 临时长度=table.maxn(tab)
   if 临时长度==0 then
      return {}
   end
   for k,v in pairs(tab) do
       if not v.分数 then
          table.remove(tab,k)
       end
   end
   for n=1,临时长度 do
       for k=2,临时长度 do
           if tab[k].分数>=tab[k-1].分数 then
              local 临时信息=table.copy(tab[k-1])
              tab[k-1]=table.copy(tab[k])
              tab[k]=table.copy(临时信息)
           end
       end
   end
   return tab
end

function 神兵异兽榜:初始化统计()--每10分钟刷新一次   ----卡界面修复改这里
   self.发送数据={}
   for k,v in pairs(类目) do
       self[v]={}
       self["临时"..v]=self:排行排序(self["临时"..v])    --------这两个地方导致的问题
        self[v]=table.copy((self["临时"..v]) or {})     --------这两个地方导致的问题
       self.发送数据[v]={}
       for n=1,20 do
           if self[v][n] and type(self[v][n])=="table" then
              self.发送数据[v][n]=table.copy(self[v][n])
           end
      end
   end
end
function 神兵异兽榜:存档()
   self:初始化统计()
   for k,v in pairs(类目) do
       写出文件("sql/神兵异兽榜/"..v..".txt",table.tostring(self[v]))
   end
end



function 神兵异兽榜:数据处理(id,序号,内容)
   if 序号<=1002 then
      self:获取排行数据(id,序号,内容)
   end
end

function 神兵异兽榜:获取排行数据(id,序号,类型)
   local 临时数据=table.copy(self.发送数据[类型])
   临时数据.类型=类型
   if 序号==1001 then
      return 发送数据(玩家数据[id].连接id,440003,临时数据)
   elseif 序号==1002 then
      return 发送数据(玩家数据[id].连接id,440004,临时数据)
   end
end



return 神兵异兽榜