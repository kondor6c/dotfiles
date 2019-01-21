" Vimrc
" | Action                          | Emacs          | Vim                     |
" |--------------------------------:|:--------------:|:------------------------|
" |undo                 (nano: M-U) | C-_            |   u                     |
" |redo                 (nano: M-E) | C-_ (note)     |  C-r                    |
" |save                 (nano: C-x) | C-x C-s        |  :w                     |
" |quit (abort)         (nano: C-x) | C-x C-c        |  :q!                    |
" |search               (nano: C-/) | C-s            |   /                     |
" |replace              (nano: C-/) | Esc % (dialog) | :%s/paittern/pattern/g  |
" |insert                                  | i (or) I          |               |
" |append                                  | a (or) A          |               |
" |insert newline                          |                   | o (or) O      |
" |open                                    | C-x C-f           | :e ~/file.txt |
" |Set mark visual       (nano: M-A-M)     | C-@               | V (or) v      |
" |Cut                   (nano: C-k)       | C-k               | D             |
" |Yank (copy)           (nano: M-6)       | M-w               | y             |
" |Paste                 (nano: C-u)       | C-y               | p (or) P      |
" |delete (full line)    (nano: C-k)       | C-M-Backspace     | dd            |
" |move forard one word  (nano: C-arrow)   | M-f               | w             |
" |end of line           (nano: C-e)       | C-e               | $             |
" |beginning of line     (nano: C-a)       | C-a               | 0             |
" |end of file           (nano: C-_ C-Y)   | Esc->             | gg            |
" |beginning of file     (nano: C-_ C-V)   | Esc-<             | G             |
" |Record new                              | C-x-(             | qc            |
" #Advanced:
" |Stop recording                          | C-x-)             | q             |
" |Replay                                  | C-u-2-C-x-e (2x)  | 2@c           |
" |ex: add # in the beginning of the line  | C-x-(,C-a,#,C-x-) | qc0i#C-[0jq   |
" |ex: Delete \n, making one big string    | C-x-(,C-e,DEL (key),C-x-) | qd$x$q|
" |New buffer                              | C-x b Named       |:new 0 or :vnew|
" |Split screen horizontal                 | C-x 3             | :split        |
" |Split screen vertical                   | C-x 2             | :vsplit       |
" |Change buffer focus                     | C-x o             | C-w C-w       |
" |Close buffer                            | C-x k (or) C-x 0  | :q (on focus) |
" |regular expression search               | C-M-s             | /.*char\&other|
" |run a command and edit output           | C-u M-!           |:r !dig or :.!x| 

syntax enable
colorscheme desert
set ruler
set nocompatible
set ts=4
inoremap jj <Esc>

"custom macros:
let @c='qc0i#^[0jq'
