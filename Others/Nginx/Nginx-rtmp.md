
## 1 Intro

基于Nginx，FFmpeg搭建流媒体服务器，实现HLS不同码率推流，利用VLC客户端验证


## 2 Procedure

### 2.1 获取Nginx包

安装依赖
```shell
sudo apt-get install build-essential zlib1g-dev openssl pcre gcc automake autoconf libtool make 
```

获取Nginx包
```shell
wget http://nginx.org/download/nginx-1.21.2.tar.gz
```

解压Nginx包
```shell
tar -zxvf nginx-1.21.2.tar.gz
```



### 2.2 获取RTMP模块

获取rtmp包
```shell
wget https://github.com/arut/nginx-rtmp-module/archive/master.zip
```

解压rtmp包
```shell
unzip nginx-rtmp-module-master.zip
```


### 2.3 编译安装Nginx-rtmp

配置（进入nginx包目录下）
```shell
./configure --prefix=/usr/local/nginx \ #设置路径
--add-module=/path/to/nginx-rtmp-module-master #添加rtmp模块
```

编译安装
```shell
sudo make
sudo make install
```


### 2.4 安装FFmpeg

安装FFmpeg
```shell
sudo apt-get install ffmpeg
```

### 2.5 生成不同码率的视频流

新建文件夹chunk，用于存放ts文件和m3u8文件

使用FFmpeg生成不同码率（1000k，500k，250k）视频流
```shell
# 建议保存为shell脚本
ffmpeg -i example.mp4 \
-c:v libx264 -b:v 1000k -c:a aac -b:a 128k \
-f hls \
-hls_time 10 \ # 每个ts文件时长
-hls_list_size 0 \ # 视频列表大小，0为全部
-hls_segment_filename ./chunk/example_1000k_%05d.ts \ #指定ts文件名
./chunk/example_1000k.m3u8

ffmpeg -i example.mp4 -c:v libx264 -b:v 500k -c:a aac -b:a 64k -f hls -hls_time 10 -hls_list_size 0 -hls_segment_filename ./chunk/example_500k_%05d.ts ./chunk/example_500k.m3u8

ffmpeg -i example.mp4 -c:v libx264 -b:v 250k -c:a aac -b:a 64k -f hls -hls_time 10 -hls_list_size 0 -hls_segment_filename ./chunk/example_250k_%05d.ts ./chunk/example_250k.m3u8
```

编写主播放列表m3u8文件
```shell
#EXTM3U 
#EXT-X-STREAM-INF:BANDWIDTH=1000000
output_1000k.m3u8 
#EXT-X-STREAM-INF:BANDWIDTH=500000
output_500k.m3u8 
#EXT-X-STREAM-INF:BANDWIDTH=250000
output_250k.m3u8
```

将上述文件放置于/usr/local/nginx/hls中

### 2.5 配置Nginx

进入/usr/local/nginx/conf/nginx.conf

在server块中添加配置
```shell
location /hls {

                add_header Access-Control-Allow-Origin *;

                types {

                        application/vnd.apple.mpegurl m3u8;

                        video/mp2t ts;

                }

                root /usr/local/nginx;

                location ~\.ts$ {

                        add_header Cache-Control no-cache;

                }

  

                add_header Cache-Control no-cache;

}
```

添加rtmp块
```shell
rtmp {

        server {

                listen 1935;

                application hls {

                        live on;

                        hls on;

                        hls_path /usr/local/nginx/hls;

                        hls_fragment 5s;

                        hls_cleanup off;

                }

        }

}
```

### 2.5 运行验证

进入sbin，重启Nginx
```shell
./nginx -s reload
```

打开vlc客户端，输入地址`http://127.0.0.1:8080/hls/test.m3u8`


## 3 Problems

### 3.1 Debugging

在Nginx配置文件中，添加：
```shell
error_log logs/error.log
```
然后便可在logs/error.log中查看错误日志

### 3.2 m3u8和ts丢失问题

hls_cleanup字段默认为on，也就是每次运行后，都会清除所有ts和m3u8文件

在rtmp块中配置`hls_cleanup off;`即可解决


## 4 Reference

- [(265条消息) 使用FFmpeg、HLS和Nginx搭建在线视频流媒体播放系统_hls nginx_dvlinker的博客-CSDN博客](https://blog.csdn.net/chenlycly/article/details/121388340)
- [(265条消息) HLS-搭建Nginx流媒体服务器_hls服务器_一切归于平静的博客-CSDN博客](https://blog.csdn.net/chenxijie1985/article/details/118081899?ops_request_misc=&request_id=&biz_id=102&utm_term=HLS%20nginx%E8%A7%86%E9%A2%91%E6%8E%A8%E6%B5%81&utm_medium=distribute.pc_search_result.none-task-blog-2~all~sobaiduweb~default-2-118081899.142^v80^insert_down38,201^v4^add_ask,239^v2^insert_chatgpt&spm=1018.2226.3001.4187)
- [(265条消息) 使用nginx-rtmp-module模块+ffmpeg推送http+flv和hls直播流_ffmpeg 推送http_u014589884的博客-CSDN博客](https://blog.csdn.net/u014589884/article/details/108043681?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522168043919716800227454389%2522%252C%2522scm%2522%253A%252220140713.130102334.pc%255Fall.%2522%257D&request_id=168043919716800227454389&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~first_rank_ecpm_v1~rank_v31_ecpm-21-108043681-null-null.142^v80^insert_down38,201^v4^add_ask,239^v2^insert_chatgpt&utm_term=Linux%20HLS%20nginx%E8%A7%86%E9%A2%91%E6%8E%A8%E6%B5%81&spm=1018.2226.3001.4187)
- [(265条消息) 使用nginx的rtmp模块搭建RTMP和HLS流媒体服务器_rtmp转hls_^一二三^的博客-CSDN博客](https://blog.csdn.net/water1209/article/details/128708370?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522168049847716800222899703%2522%252C%2522scm%2522%253A%252220140713.130102334.pc%255Fall.%2522%257D&request_id=168049847716800222899703&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~first_rank_ecpm_v1~rank_v31_ecpm-3-128708370-null-null.142^v80^insert_down38,201^v4^add_ask,239^v2^insert_chatgpt&utm_term=nginx%20rtmp%20hls%E6%9C%AC%E5%9C%B0%E6%8E%A8%E6%B5%81&spm=1018.2226.3001.4187)
- [Directives · arut/nginx-rtmp-module Wiki](https://github.com/arut/nginx-rtmp-module/wiki/Directives)