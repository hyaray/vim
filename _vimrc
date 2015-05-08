"F12生成cscope.files，F11生成tags，F10管理Tlist，<C-h>注释，多行用cm和cu。F2编译，F3和<C-F3>为make命令。
"if(has("win32") || has("win95") || has("win64") || has("win16"))
    let g:iswindows=1
    let g:vimrc_iswindows=1
"else
"    let g:iswindows=0
"endif
"autocmd! bufwritepost _vimrc source $vim\_vimrc
set nocompatible
filetype off
set rtp+=$VIM/vimfiles/bundle/Vundle.vim
call vundle#begin('$VIM/vimfiles/bundle')
    Plugin 'gmarik/Vundle.vim'
    Plugin 'vim-scripts/genutils'
    "Plugin 'tpope/vim-commentary' "增加\\为操作符
    Plugin 'kana/vim-textobj-entire' "增加ae和ie为全文对象
    Plugin 'kana/vim-textobj-user' "便捷地创建自定义本文对象
    Plugin 'bling/vim-airline' "美化状态栏
    Plugin 'tpope/vim-surround'  "快捷修改两边的符号
    Plugin 'tpope/vim-unimpaired' "文件切换[]相关热键
    Plugin 'bronson/vim-visual-star-search' "增强*和#搜索选中文本功能
    "Plugin 'Lokaltog/vim-powerline' "状态栏美化
    "Plugin 'kana/vim-textobj-entire'
    "Plugin 'spf13/spf13-vim'
    "Plugin 'vim-scripts/gui2term.py'
    Plugin 'vim-scripts/lookupfile'
    "Plugin 'Plugin 'vim-scripts/CmdlineComplete'
    "Plugin 'Shougo/neocomplete.vim'
    Plugin 'Shougo/neosnippet.vim'
    Plugin 'Shougo/neosnippet-snippets'
    "Plugin 'vim-scripts/UltiSnips' "提供超强的快速生成代码段的功能(超越snipmate)
    "Plugin 'vim-scripts/checksyntax'
    "Plugin 'vim-scripts/cscope.vim'
    "Plugin 'vim-scripts/autoload_cscope.vim'
    "Plugin 'ameyp/CscopeSublime'
    Plugin 'vim-scripts/taglist.vim'
    "Plugin 'vim-scripts/txt.vim'
    Plugin 'vim-scripts/TxtBrowser'
    Plugin 'vim-scripts/AutoComplPop' "自动出现补全窗口
    Plugin 'vim-scripts/OmniCppComplete'  " C/C++自动补全
    Plugin 'scrooloose/nerdcommenter' "快速生成注释
    "Plugin 'vim-scripts/sessionman.vim'
    "Plugin 'vim-scripts/cmake.vim'
call vundle#end()

filetype plugin indent on
"au GUIEnter * simalt ~x "窗口最大化
autocmd BufEnter *.txt setf txt
autocmd BufEnter,BufRead *.ahk set dictionary+=$VIM\dict\ahk, bomb
autocmd BufEnter,BufRead *.ahk set indentexpr=GetAutoHotkeyIndent()
autocmd BufLeave,BufDelete  *.ahk set dictionary-=$VIM\dict\ahk
"au BufNewFile,BufRead *.ahk inoremap <Tab> <C-R>=CleverTab()<CR>
function! CleverTab()
	   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
	      return "\<Tab>"
	   else
	      return "\<C-x>\<C-k>"
	   endif
endfunction
autocmd BufWinEnter *.ahk,_vimrc silent loadview 
autocmd BufWinEnter *.c set tags+=./tags, tags+=d:\Soft\Study\hy\C\tags "添加个人路径
"autocmd BufNewFile *.[ch],*.sh,*.java exec ":call SetTitle()"
"autocmd BufNewFile * normal G
autocmd BufWinEnter * set path=./** 
color evening "esolarize 
"syntax enable "语法高亮显示
syntax on "语法高亮显示
"Pmenu为所有项配色，PmenuSel为选中项配色。guibg 和 guifg 分别对应背景色和前景色
highlight Pmenu    guibg=darkgreen  guifg=lightgrey
highlight PmenuSel guibg=Magenta    guifg=white
set autochdir  "自动改变当前工作目录
"set autoindent "自动缩进
"set smartindent "智能缩进
"set copyindent "自动缩进时复制上面行的缩进
"set cindent "设置c语言自动缩进
"set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s     "设置C/C++语言的具体缩进方式
set autoread "VIM外改变文件内容会自动读取
set guicursor=a:blinkon0 "光标不闪烁
set cursorline hlsearch incsearch infercase linebreak ruler number showmatch nobackup wildmenu
set encoding=utf-8
set langmenu=zh_CN.UTF-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-kr,latin1
"set foldcolumn=4 "指定宽度的列在窗口的一侧显示
"set foldlevel=3 "显示3层shiftwide缩进文本
set foldmethod=syntax "Manual手动,indent按缩进折叠,expr(foldexpr给出的折叠级别),语法高亮项目指定折叠,diff没有改变的文本构成折叠
set guioptions=e "设置界面
set ignorecase smartcase "忽略大小写，搜索时输入大写会区别
set linebreak "设置换行时单词保持连续
set lines=38 columns=120 "设置行数和列数
set nrformats-=octal "0开头的数字不会当成八进制
set backspace=indent,eol,start
set shiftwidth=4 "shift符宽度
set softtabstop=4 " <Tab>和 <BS>算作4空格
set whichwrap=b,s,<,>,[,] "左右箭头遇到行首/尾时还能继续移动
set whichwrap+=l,h "h,l也能绕到当前行之外
set wrap "设置不折行
set history=200
set guifont=Microsoft_YaHei_Mono:h11:cGB2312:b

"双字符符号正常显示，比如→
if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
    set ambiwidth=double
endif

"防止菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages zh_CN.utf-8

"标签只显示文件名
function ShortTabLabel ()
    let bufnrlist = tabpagebuflist (v:lnum)
    let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
    let filename = fnamemodify (label, ':t')
    return filename
endfunction
set guitablabel=%{ShortTabLabel()}   

"键映射
let mapleader = ","
nnoremap <F8> a<C-r>=strftime("20%y-%m-%d %H:%M:%S")<CR>
inoremap <F8> <C-r>=strftime("20%y-%m-%d %H:%M:%S")<CR>
noremap <up> gk
inoremap <up> <C-o>gk
noremap <down> gj
inoremap <down> <C-o>gj
noremap <M-q> ZZ<CR>
noremap! <M-q> <ESC>ZZ<CR>
noremap <M-s> :w<CR>
noremap! <M-s> <ESC>:w<CR>
noremap <C-c> "*y
noremap <C-v> "*p
nnoremap <silent><C-l> :<C-u>nohlsearch<CR><C-l>
noremap! <C-a> <ESC>ggVG"*y
noremap <M-v> <C-v>
cnoremap <C-p> <up>
cnoremap <C-n> <down>
nnoremap <leader>qq :q!<CR>
nnoremap & :&&<CR>
xnoremap & :&&<CR>
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>
cnoremap <expr> %% getcmdtype()==':'?expand('%:h').'/' : '%%'
inoremap <C-k> <C-x><C-k>
noremap <M-1> 1gt 
noremap <M-2> 2gt 
noremap <M-3> 3gt 
noremap <M-4> 4gt 
noremap <M-5> 5gt 
noremap <M-6> 6gt 
noremap <M-7> 7gt 
noremap <M-8> 8gt 
noremap <M-9> 9gt 
noremap <M-0> 10gt 
inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { {}<ESC>i
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap < <><ESC>i
inoremap > <c-r>=ClosePair('>')<CR>
function ClosePair(char)  "输入右半符号时，如存在则按right键
    if getline('.')[col('.') - 1] == a:char  
	return "\<Right>"  
    else  
	return a:char  
    endif
endfunction

nmap ,hh :call InsertIncludeFileN()<CR>
imap <c-b><c-h> <ESC>:call InsertIncludeFileN()<CR>
function InsertIncludeFileN()
    "let sourcefilename=expand("%:t")
    let outfilename=substitute(expand("%:t"),'\(\.[^.]*\)$','.h','g')
    call setline('.','#include "'.outfilename.'"')
endfunction

" airline设置
set laststatus=2
let g:airline_powerline_fonts = 0 " 使用powerline打过补丁的字体
let g:airline#extensions#tabline#enabled = 0 " 开启tabline
let g:airline#extensions#tabline#left_sep = ' ' " tabline中当前buffer两端的分隔字符
let g:airline#extensions#tabline#left_alt_sep = '|' " tabline中未激活buffer两端的分隔字符
let g:airline#extensions#tabline#buffer_nr_show = 1 " tabline中buffer显示编号

"Ctags配置
map <F11> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
imap <F11> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>

"cscope配置
"0 或 s 查找本 C 符号(可以跳过注释)
"1 或 g 查找本定义
"2 或 d 查找本函数调用的函数
"3 或 c 查找调用本函数的函数
"4 或 t 查找本字符串
"6 或 e 查找本 egrep 模式
"7 或 f 查找本文件
"8 或 i 查找包含本文件的文件
"nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
"nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
"nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
"nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
"nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
"nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
"nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
"map <F12> :call Do_CsTag()<CR>
"function Do_CsTag()
"    let dir = getcwd()
"    if filereadable("tags")
"        if(g:iswindows==1)
"            let tagsdeleted=delete(dir."\\"."tags")
"        else
"            let tagsdeleted=delete("./"."tags")
"        endif
"        if(tagsdeleted!=0)
"            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
"            return
"        endif
"    endif
"    if has("cscope")
"        silent! execute "cs kill -1"
"    endif
"    if filereadable("cscope.files")
"        if(g:iswindows==1)
"            let csfilesdeleted=delete(dir."\\"."cscope.files")
"        else
"            let csfilesdeleted=delete("./"."cscope.files")
"        endif
"        if(csfilesdeleted!=0)
"            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
"            return
"        endif
"    endif
"    if filereadable("cscope.out")
"        if(g:iswindows==1)
"            let csoutdeleted=delete(dir."\\"."cscope.out")
"        else
"            let csoutdeleted=delete("./"."cscope.out")
"        endif
"        if(csoutdeleted!=0)
"            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
"            return
"        endif
"    endif
"    if(executable('ctags'))
"        "silent! execute "!ctags -R --c-types=+p --fields=+S *"
"        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
"    endif
"    if(executable('cscope') && has("cscope") )
"        if(g:iswindows!=1)
"            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
"        else
"            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
"        endif
"        silent! execute "!cscope -b"
"        execute "normal :"
"        if filereadable("cscope.out")
"            execute "cs add cscope.out"
"        endif
"    endif
"endfunction
"if(g:iswindows==1)
"    silent! execute "!dir /b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
"else
"    silent! execute "!find . -name "*.h" -o -name "*.c" -o -name "*.cpp" -o -name "*.m" -o -name "*.mm" -o -name "*.java" -o -name "*.py" > cscope.files"
"endif
""cscope优先于ctags
"if has("cscope")
"    set cscopequickfix=s-,c-,d-,i-,t-,e-
"    set csto=0
"    set cst
"    set csverb
"endif

"进行Tlist的设置
"TlistUpdate可以更新tags
map <F10> :silent! Tlist<CR>
let Tlist_Show_One_File=1 "让taglist可以同时展示多个文件的函数列表，如果想只有1个，设置为1
let Tlist_Auto_Update=1 "自动更新编辑文件的tag
let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个窗口时，自动退出vim
let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
let Tlist_Use_Right_Window=1 "让窗口显示在右边，缺省在左侧，0的话就是显示在左边
"let Tlist_Show_Menu=1 "显示taglist菜单
"let Tlist_Auto_Open=1 "启动vim时自动打开taglist
let Tlist_Process_File_Always=0 "是否一直处理tags.1:处理;0:不处理。不是一直实时更新tags，因为没有必要
let Tlist_Inc_Winwidth=0

"OmniCppComplete配置
"ctags 索引文件 (根据已经生成的索引文件添加即可, 这里我额外添加了 hge 和 curl 的索引文件)
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
let OmniCpp_MayCompleteDot = 1   " 输入 .  后自动补全
let OmniCpp_MayCompleteArrow = 1 " 输入 -> 后自动补全
let OmniCpp_MayCompleteScope = 1 " 输入 :: 后自动补全
let OmniCpp_SelectFirstItem = 2  "自动弹出时自动跳至第一个
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest

"对NERD_commenter的设置,开启和关闭热键为Ctrl+h，cm是多行注释，类似C++的/**/，,cu是取消注释
let NERDShutUp=1

"单个文件编译
map <F2> :call Do_OneFileMake()<CR>
function Do_OneFileMake()
    if expand("%:p:h")!=getcwd()
        echohl WarningMsg | echo "Fail to make! This file is not in the current dir! Press <F7> to redirect to the dir of this file." | echohl None
        return
    endif
    let sourcefileename=expand("%:t")
    if (sourcefileename=="" || (&filetype!="cpp" && &filetype!="c"))
        echohl WarningMsg | echo "Fail to make! Please select the right file!" | echohl None
        return
    endif
    let deletedspacefilename=substitute(sourcefileename,' ','','g')
    if strlen(deletedspacefilename)!=strlen(sourcefileename)
        echohl WarningMsg | echo "Fail to make! Please delete the spaces in the filename!" | echohl None
        return
    endif
    if &filetype=="c"
        if g:iswindows==1
            set makeprg=gcc\ -o\ %<.exe\ %
        else
            set makeprg=gcc\ -o\ %<\ %
        endif
    elseif &filetype=="cpp"
        if g:iswindows==1
            set makeprg=g++\ -o\ %<.exe\ %
        else
            set makeprg=g++\ -o\ %<\ %
        endif
        "elseif &filetype=="cs"
        "set makeprg=csc\ \/nologo\ \/out:%<.exe\ %
    endif
    if(g:iswindows==1)
        let outfilename=substitute(sourcefileename,'\(\.[^.]*\)' ,'.exe','g')
        let toexename=outfilename
    else
        let outfilename=substitute(sourcefileename,'\(\.[^.]*\)' ,'','g')
        let toexename=outfilename
    endif
    if filereadable(outfilename)
        if(g:iswindows==1)
            let outdeletedsuccess=delete(getcwd()."\\".outfilename)
        else
            let outdeletedsuccess=delete("./".outfilename)
        endif
        if(outdeletedsuccess!=0)
            set makeprg=make
            echohl WarningMsg | echo "Fail to make! I cannot delete the ".outfilename | echohl None
            return
        endif
    endif
    execute "silent make"
    set makeprg=make
    execute "normal :"
    if filereadable(outfilename)
        if(g:iswindows==1)
            execute "!".toexename
        else
            execute "!./".toexename
        endif
    endif
    execute "copen"
endfunction

"进行make的设置
map <F3> :call Do_make()<CR>
map <C-F3> :silent make clean<CR>
function Do_make()
    set makeprg=make
    execute "silent make"
    execute "copen"
endfunction
