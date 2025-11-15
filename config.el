;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Menlo" :size 14))
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'tsdh-light)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(setq-default frame-title-format "%b (%f)")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Spacemacs like leader key
(setq doom-localleader-key ",")

;; Saving settings
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq auto-save-visited-interval 5)
(auto-save-visited-mode 1)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
(after! evil
  ;; 1. Unbind C-e from all evil state maps
  (dolist (map (list evil-normal-state-map
                     evil-visual-state-map
                     evil-motion-state-map
                     evil-insert-state-map))
    (define-key map (kbd "C-e") nil))
  ;; 2. Rebind with high precedence via Doom's map!
  (map! "C-e" #'doom/forward-to-last-non-comment-or-eol))

;; Don't ask like a modern editor
(setq confirm-kill-emacs nil)
(setq confirm-kill-processes nil)
;; This is rather radical, but saves from a lot of pain in the ass.
;; When split is automatic, always split windows vertically
(setq split-height-threshold 0)
(setq split-width-threshold nil)
;; Mac related keybindings
(map! "s-1" #'delete-other-windows)
(map! "s-3" #'split-window-right)
(map! "s-B" #'treemacs)
(map! "s-[" #'windmove-left)
(map! "s-]" #'windmove-right)

(map! "s-'" #'er/expand-region)
(map! "s-\"" #'er/contract-region)

;; Rebind SPC SPC to M-x
(map! :leader
      :desc "M-x" "SPC" #'execute-extended-command)

;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(defun altaria/eval-and-refresh ()
  "eval functino in cider and also refresh images"
  (interactive)
  (call-interactively 'cider-eval-last-sexp)
  (sit-for 0.3)
  (call-interactively 'altaria/refresh-iimages))

(defun altaria/refresh-iimages ()
  "Only way I've found to refresh iimages (without also recentering)"
  (interactive)
  (clear-image-cache nil)
  (iimage-mode nil)
  (iimage-mode t)
  (message "Refreshed images")
  )
(map! :map clojure-mode-map :localleader :desc "Eval then refresh image" "e '" #'altaria/eval-and-refresh)
;; (fset 'rainbow-delimiters-mode #'prism-mode)
;;
;; tab to select
(with-eval-after-load 'company
  (define-key company-active-map (kbd "<return>") nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection))

(after! lisp-mode
  (remove-hook 'lisp-mode-hook #'rainbow-delimiters-mode))

(setq mouse-wheel-tilt-scroll t)
(setq mouse-wheel-flip-direction t)
