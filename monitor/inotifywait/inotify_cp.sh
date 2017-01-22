#!/bin/bash
#监视目录和目标目录
FROM_DIR="."
TO_DIR=$HOME/mount/server/MyProject

inotifywait -m -r --format "%e %w %f" $FROM_DIR | while read eventName dirName fileName; do
#显示事件
echo "-- Event:$eventName Dir:$dirName File:$fileName"
#忽略“.”开头和“_”结束的文件
if [[ $fileName == .* ]] || [[ $fileName == *_ ]]; then
continue
fi
#复制改动的文件（有些IDE会在临时文件编辑，保存时同够移动覆盖原文件）
case $eventName in
MOVED_TO|MODIFY)
cp -v ${dirName}${fileName} $TO_DIR/$dirName
echo
;;
esac
done
