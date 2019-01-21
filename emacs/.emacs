(setq emacs-user-directory "~/.emacs.d/")

;; (load (concat emacs-user-directory "init.el"))



(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("elpy" . "http://jorgenschaefer.github.io/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-initialize)
(elpy-enable)
(elpy-use-ipython)
