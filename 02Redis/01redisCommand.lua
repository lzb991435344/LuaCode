
redis structure 

--启动服务器
redis-server

--客户端连接
redis-cli


ps:
	1.线上禁用 keys*   可使用较长的前缀 如  keys  lore:lenv:uid...* 减少输出
	2.连接命令   redis-cli -h 127.0.0.1 -p + 端口号
	3.设置对key的超时时间  expire(24*3600) 避免因为key一直存在内存导致内存报警
	4.基本的命名规则
		lore:lenv:svid:uid.....
		项目名:模块名:区服:uid.....
	5.
	 
	











