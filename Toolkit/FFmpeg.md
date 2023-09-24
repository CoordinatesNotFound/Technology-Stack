# FFmpeg



## 1 Intro to FFmpeg

ffmpeg是一款常用的开源多媒体处理工具，支持音频、视频等多种格式的编解码、转换和处理。


## 2 Command

`ffmpeg [option]`

- 输入参数
  - `-i`：指定输入文件或输入URL地址，例如：ffmpeg -i input.mp4 或 ffmpeg -i [http://example.com/live/stream.flv。](http://example.com/live/stream.flv%E3%80%82)
-  输出参数
    - `-f`：指定输出格式，例如：ffmpeg -i input.mp4 -f flv output.flv
    - `-y`：覆盖输出文件，例如：ffmpeg -i input.mp4 -y output.mp4
    - `-ss`：指定起始时间，例如：ffmpeg -ss 00:01:30 -i input.mp4 -t 00:00:10 output.mp4
    - `-t`：指定输出时长，例如：ffmpeg -i input.mp4 -t 00:00:10 output.mp4
- 视频参数
  - `-vcodec`：指定视频编解码器，例如：ffmpeg -i input.mp4 -vcodec libx264 output.mp4
  - `-b:v`：指定视频比特率，例如：ffmpeg -i input.mp4 -b:v 1024k output.mp4
  - `-s`：指定视频分辨率，例如：ffmpeg -i input.mp4 -s 640x480 output.mp4
  - `-r`：指定视频帧率，例如：ffmpeg -i input.mp4 -r 30 output.mp4
- 音频参数
  - `-acodec`：指定音频编解码器，例如：ffmpeg -i input.mp4 -acodec aac output.mp4
  - `-b:a`：指定音频比特率，例如：ffmpeg -i input.mp4 -b:a 128k output.mp4
  - -`ar`：指定音频采样率，例如：ffmpeg -i input.mp4 -ar 44100 output.mp4
