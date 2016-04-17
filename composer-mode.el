;;; composer-mode.el -- A composer.json major mode

(defvar composer-mode-hook nil)

(defvar composer-mode-map
  (let ((map (make-keymap)))
    (define-key map (kbd "C-c u") 'composer-update)
    (define-key map (kbd "C-c s") 'composer-self-update)
    (define-key map (kbd "C-c i") 'composer-install)
    (define-key map (kbd "C-c c") 'composer-init)
    (define-key map (kbd "C-c q") 'composer-search)
    map)
  "Keymap for composer.json major mode")

;;;###autoload
(add-to-list 'auto-mode-alist '("composer\\.json\\'" . composer-mode))

;;;###autoload
(define-minor-mode composer-mode
  "composer.json mode"
  :lighter " composer"
  :keymap composer-mode-map)

(defun run-composer-cmd (cmd)
  "Runs composer command and return the output"
  (shell-command-to-string (format "composer %s" cmd)))

(defun composer-search (query)
  (interactive "sPackage(s): ")
  (message (run-composer-cmd (format "search %s" (query)))))

(defun composer-init ()
  "Create a basic composer.json file in current directory"
  (interactive)
  (message (run-composer-cmd "init")))
  
(defun composer-update ()
  "Update composer.lock and any packages where necessary"
  (interactive)
  (message "Updating composer package not yet available."))

(defun composer-install (pkg ver)
  (interactive "sPackage: \nsVersion: ")
  (message "Installing package %s:%s" pkg ver))

(defun composer-self-update ()
  "Self-update composer itself"
  (interactive)
  (message (run-composer-cmd "self-update")))

(provide 'composer-mode)
