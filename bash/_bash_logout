# ~/.bash_logout: executed by bash(1) when login shell exits.
# | shortcut | Description                                                    |
# |---------:|:---------------------------------------------------------------|
# | ctrl + e | go to the end of the line                                      |
# | ctrl + a | go to the beginning of the line                                |
# | ctrl + o | execute command, then go to the next command based on history  |
# | ctrl + k | Cut to the end of the line, from the cursor                    | 
# | ctrl + u | Cut to the beginning of the line, from the cursor              |
# | ctrl + r | Reverse search through history (begin typing!) also useful C-o |
# | ctrl + _ | Undo                                                           |
# | ctrl + g | Escape out of search mode                                      |
# | ctrl + y | Paste                                                          |
# | ctrl + w | Cut/Delete one word back, deletes one word to the next space   |
# | ctrl + l | Clear's current screen                                         |
# | ctrl + s | Stop current screen (processes are still running)              |
# | ctrl + q | Resume stopped screen                                          |
# | ctrl + t | swap character under cusor with previous                       |
# | ctrl +   |                                                                |
# | alt + .  | Yank and Paste last argument of previous command               |
# | alt + b  | move cursor back one word, use ctrl to move one Character      |
# | alt + f  | move cursor forward one word, use ctrl to move one Character   |
# | alt + b  | move cursor back one word, use ctrl to move one Character      |
# | !*       | expand to all arguments used in last command                   |
# | !64:p    | replay the 64th command in history, prompt before executing :p |

# when leaving the console clear the screen to increase privacy

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
