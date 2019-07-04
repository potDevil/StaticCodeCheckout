#!/bin/bash
#开始
# 复制 pre-commit commit-msg脚本到/.git/hooks/目录下
# r d
action='r'
#获取输入命令的第一个参数
cmd=$1
if [ $cmd ]
 then
  action=$1
fi
echo "action=$action"
# 获取hook下的commit-msg和pre-commit
precommitName="pre-commit"
commitName="commit-msg"
#获取当前目录
sourcePath=$(pwd)
sourcePrecommit=$sourcePath"/"$precommitName
sourceCommitmsg=$sourcePath"/"$commitName
echo "sourcePrecommit=$sourcePrecommit"
echo "sourceCommitmsg=$sourceCommitmsg"
cd ..
rootPath=$(pwd)
echo "rootPath=$rootPath"
gitDir=$rootPath"/.git"
echo "gitDir=$gitDir"
hooksDir=$gitDir"/hooks"
echo "hooksDir=$hooksDir"
pre_hooks=$hooksDir"/"$precommitName
commit_hooks=$hooksDir"/"$commitName

# 创建一个.git目录
if [ -d $gitDir ]
then
 echo "$gitDir exsit"
 if [ -d $hooksDir ]
  then
   echo "$hooksDir exsit"
  else
   echo "$hooksDir not exsit"
   # mkdir 创建一个新目录
   mkdir $hooksDir
   echo "$hooksDir mkdir ok"
 fi
else
 echo "$gitDir not exsit"
 git init
 echo "git init ok"
fi
#复制 pre_commit 文件
if [ -e $pre_hooks ]
then
 echo "$pre_hooks exsit"
 if [ $action = "d" ]
 then
    rm -r $pre_hooks
    echo "$pre_hooks remove ok"
 else
    cp $sourcePrecommit $hooksDir
    chmod 777 $pre_hooks
    echo "$pre_hooks replace ok"
 fi
else
 echo "$pre_hooks not exsit"
 cp $sourcePrecommit $hooksDir
 chmod 777 $pre_hooks
 echo "$pre_hooks copy ok"
fi

#复制 commit-msg 文件  -e 判断文件是否存在
if [ -e $commit_hooks ]
then
  echo "$commit_hooks exsit"
  if [ $action = "d" ]
  then
    # rm -r 递归删除
    rm -r $commit_hooks
    echo "$commit_hooks remove ok"
  else
    # cp复制
    cp $sourceCommitmsg $hooksDir
    chmod 777 $commit_hooks
    echo "$commit_hooks replace ok"
  fi
else
 echo "$commit_hooks not exsit"
 cp $sourceCommitmsg $hooksDir
 chmod 777 $commit_hooks
 echo "$commit_hooks copy ok"
fi
#结束
