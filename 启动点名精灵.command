#!/bin/bash

# 班级随机点名精灵 - Mac启动脚本
# 双击此文件即可启动应用

echo ""
echo "======================================"
echo "🎯 班级随机点名精灵 - Mac启动器"
echo "======================================"
echo ""

# 检查是否有Python
if command -v python3 &> /dev/null; then
    echo "✅ 检测到Python3环境"
    PYTHON_CMD="python3"
elif command -v python &> /dev/null; then
    echo "✅ 检测到Python环境"
    PYTHON_CMD="python"
else
    echo "❌ 未检测到Python环境"
    echo ""
    echo "💡 建议使用Mac专用版本："
    echo "   双击 index-mac.html 即可直接启动"
    echo ""
    echo "📖 详细说明请查看：Mac使用说明.txt"
    echo ""
    read -p "按回车键退出..."
    exit 1
fi

# 获取脚本所在目录
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$DIR"

# 查找可用端口
PORT=8000
while lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; do
    PORT=$((PORT + 1))
done

echo "🚀 正在启动服务器..."
echo "   端口: $PORT"
echo "   目录: $DIR"
echo ""

# 启动Python HTTP服务器
$PYTHON_CMD -m http.server $PORT &

# 保存进程ID
SERVER_PID=$!

echo "✅ 服务器启动成功！"
echo ""
echo "🌐 请在浏览器中访问："
echo "   http://localhost:$PORT"
echo ""
echo "📖 使用说明："
echo "   1. 推荐使用Mac专用版本（双击index-mac.html）"
echo "   2. 完整功能请访问：http://localhost:$PORT/index.html"
echo ""
echo "⏹️  按 Ctrl+C 停止服务器"
echo ""

# 等待用户中断
wait $SERVER_PID

echo ""
echo "🛑 服务器已停止"
echo "👋 感谢使用！"
