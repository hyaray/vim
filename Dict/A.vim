"本脚本用途：使脚本B内的关键字大小写与文件C的关键字一样
"要求：规范文件一行必须只有一个关键字
"使用方法：脚本B文件内:so d:/Soft/Vim/Dict/a.vim
"创建日期：2015年04月29日 14:29:13
let s:text=readfile("d:/Soft/Vim/Dict/ahk")
for s:n in s:text
    execute '%s/\c\<' . s:n . '\>/' . s:n . '/ge'
endfor
