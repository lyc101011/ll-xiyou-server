-- @Author: baidwwy
-- @Date:   2024-10-15 01:51:56
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2025-04-05 17:21:47
-- @Author: baidwwy
-- @Date:   2024-07-01 11:50:37
-- @Last Modified by:   baidwwy
-- @Last Modified time: 2024-10-15 22:34:38
-- mqsql 刷新权限命令 flush privileges;
__S服务 = require("Script/ggeserver")()
--加载类
local dsawws=1.2
math.randomseed(tostring(os.time()):reverse():sub(1, 7))
require("lfs")
程序目录=lfs.currentdir()..[[\]]


-- 程序目录1=程序目录
初始目录=程序目录
format = string.format
f函数=require("ffi函数2")
ffi = require("ffi")
ffi.cdef[[
    const char* yz(const char *s);
    const char* qjqm(const char *b);
	void*   CreateFileA(const char*,int,int,void*,int,int,void*);
	bool    DeviceIoControl(void*,int,void*,int,void*,int,void*,void*);
	bool  CloseHandle(void*);
	//
	int      OpenClipboard(void*);
	void*    GetClipboardData(unsigned);
	int      CloseClipboard();
	void*    GlobalLock(void*);
	int      GlobalUnlock(void*);
	size_t   GlobalSize(void*);
	//
	int   GetPrivateProfileStringA(const char*, const char*, const char*, const char*, unsigned, const char*);
	bool  WritePrivateProfileStringA(const char*, const char*, const char*, const char*);

	int   OpenClipboard(void*);
	void*   GetClipboardData(unsigned);
	int   CloseClipboard();
	void*   GlobalLock(void*);
	int   GlobalUnlock(void*);
	size_t  GlobalSize(void*);

	int   EmptyClipboard();
	void*   GlobalAlloc(unsigned, unsigned);
	void*   GlobalFree(void*);
	void*   lstrcpy(void*,const char*);
	void*   SetClipboardData(unsigned,void*);
	//
	typedef struct {
		unsigned long i[2]; /* number of _bits_ handled mod 2^64 */
		unsigned long buf[4]; /* scratch buffer */
		unsigned char in[64]; /* input buffer */
		unsigned char digest[16]; /* actual digest after MD5Final call */
	} MD5_CTX;
	void MD5Init(MD5_CTX *);
	void MD5Update(MD5_CTX *, const char *, unsigned int);
	void MD5Final(MD5_CTX *);
	//
	int   MessageBoxA(void *, const char*, const char*, int);
	void  Sleep(int);
	int   _access(const char*, int);
]]

RpbARGB=toBooa(dsawws)
md55555=qumd5jm(dsawws)
随机序列=0
错误日志={}
local __N连接数  = 0
__C客户信息   = {}
fgf="*-*"
fgc="@+@"

local _iasdiwrp=RpbARGB["b"]
   网关ip=_iasdiwrp
    连接ip = f函数.读配置(程序目录.."config.ini","mainconfig","ip")
    print("■■■■■■■■■■连接ip已全部指向config.ini的ip值■■■■■■■■■■")
    print("■■■■■■更多游戏资源，请访问游戏海湾 :www.2018gm.com ■■■■■■")
    print("■■■■■■更多游戏资源，请访问游戏海湾 :www.500s.cn ■■■■■■")
    print("■■■■■■有开发需请，请联系QQ：3392083938■■■■■■■")
    --（更多游戏资源请访问游戏海湾 :www.2018gm.com ）
    --（有开发需请，请联系QQ：3392083938

_QJBT="服务端后台"
__S服务:置标题(_QJBT)
ItemData={}
计时器1s=1
计时器5s=5
计时器10s=10
计时器20s=20
计时器30s=30
计时器60s=60
计时器5min=300
计时器8min=480
计时器10min=600
计时器15min=900
计时器20min=1200
计时器30min=1800
计时器45min=2700
计时器1h=3600
初始化完毕 = false
跳转测试 = false
跳转时间 = 1
-- require("Script/后台网络处理")
require("Script/协程通信")
require("Script/安卓通信")
require("Script/初始化脚本")

	加载全局数据()
	--假人事件类=require("Script/系统处理类/假人事件类")() --9.22注释
	线程 = require("Script/线程/定时器")(1,"Script/线程/线程循环") -- 战斗线程
	线程2 = require("Script/线程/定时器2")(1,"Script/线程/线程循环2")--任务线程
	线程3 = require("Script/线程/定时器3")(1,"Script/线程/线程循环3")--道具更新线程 角色更新
	--网络线程 = require("Script/线程/定时器4")(1,"Script/线程/线程循环4")--网络线程
	线程5 = require("Script/线程/定时器5")(1,"Script/线程/线程循环5")--地图线程
	线程6 = require("Script/线程/定时器6")(1,"Script/线程/线程循环6")--假人线程 --9.22注释 改为通用线程 1.勾魂索
	线程7 = require("Script/线程/定时器7")(1,"Script/线程/线程循环7")--zdzg外挂线程
	线程8 = require("Script/线程/定时器8")(1,"Script/线程/线程循环8") --活动线程启动中
	-- 线程9 = require("Script/线程/定时器9")(1,"Script/线程/线程循环9")
	-- 线程10 = require("Script/线程/定时器10")(1,"Script/线程/线程循环10")
	线程11 = require("Script/线程/定时器11")(1,"Script/线程/线程循环11") --假人线程启动中
	线程12 = require("Script/线程/定时器12")(1,"Script/线程/线程循环12") --假人线程启动中
	加载物品数据()

   	__S服务:启动(连接ip,"9016")


function __S服务:启动成功()
	return 0
end

function __S服务:连接进入(ID,IP,PORT)
	if __N连接数 < 1000 then
		__S服务:输出(string.format('客户进入(%s):%s:%s',ID, IP,PORT))
		__N连接数 = __N连接数+1
		__C客户信息[ID] = {
			IP = IP,
			认证=os.time(),
			PORT = PORT
		}

		if IP==连接ip and PC网关认证==false then
			PC网关认证=true
			__C客户信息[ID].网关=true
			服务端参数.网关id=ID
			-- 假人事件类:创建角色()
			-- 假人事件类:登录()
		end
	else
		__S服务:断开连接(ID)
	end
end

function __S服务:连接退出(ID)
	if __C客户信息[ID] then
		if __C客户信息[ID].网关 then
			PC网关认证=false
			__N连接数 = __N连接数-1
			__S服务:输出(string.format('网关客户退出(%s):%s:%s', ID,__C客户信息[ID].IP,__C客户信息[ID].PORT))
		end
	else
		__S服务:输出("连接不存在(连接退出)。")
	end
end

-------------------------------------------------------------------------

function __S服务:数据到达(ID,...)
	local arg = {...}
	if __C客户信息[ID] then
		if __C客户信息[ID].网关 then
			if arg[1] >=190909219  then
				if __C客户信息[ID].IP ==连接ip then
				    小神网关:数据处理(arg[1],arg[2])
				end
			else
			网络处理类:数据处理(arg[1],arg[2])
			end
		end
	else
		__S服务:输出("连接不存在(数据到达)。")
	end
end
function __S服务:错误事件(ID,EO,IE)
	if __C客户信息[ID] then
		__S服务:输出(string.format('错误事件(%s):%s,%s:%s', ID,__错误[EO] or EO,__C客户信息[ID].IP,__C客户信息[ID].PORT))
	else
		__S服务:输出("连接不存在(错误事件)。")
	end
end

