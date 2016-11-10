(when (>= emacs-major-version 24)
  (setq mode-require-final-newline 0)

  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0.0)

  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (package-initialize))

  (require 'evil)
  (evil-mode 1)

  (require 'virtualenvwrapper)
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell)

  (setq venv-location "~/.config/virtualenvs")

  (defun my/python-mode-hook () (add-to-list 'company-backends 'company-jedi))
  (add-hook 'python-mode-hook 'mk/python-mode-hook)
