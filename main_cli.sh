#!/bin/bash
cleanup() {
    echo "清理中..."
    rm -f out.txt
    exit 1
}
trap cleanup SIGINT
set -e

cat << 'EOF'
复赛测试系统

这是来自chi的测试系统
使用你的聪明才智，骗过AI吧

在这里输入你的小作文:
EOF
read -r input
echo

./run.o stories15M.bin -i  "'$input'" > out.txt
export score=0
declare -A points=( ["awesome"]=20 ["great"]=30 ["good"]=30 ["nekovanilla"]=5 ["chihuo2104"]=10 )
for keyword in "${!points[@]}"; do
    if grep -qi "$keyword" out.txt; then
        score=$((score + points[$keyword]))
    fi
done

cat << EOF

您的分数为: $score

输入文本为: $input

返回文本为:
$(cat out.txt)

EOF
rm -f out.txt
