#
#   This ist the customized zsh init file
#   for Mario Kleinboelting
#
zshrc_version_info="Version 14, 18.01.2026"
#   
# Changelog
#
# V11, 9.1.2026
# setopt interactive_comments hinzu
#
# V12, 15.1.2026
#  Reorga und Inline Doku
#  OS Auswahl
#
# V13, 17.1.2026
#  neovim wird EDITOR
#  zshrc_version Optimierung
#  zshrc_fetch_it aktiv geschaltet
#
# V14, 18.ß1.2026
#  e und p alias
#  eza Anpassungen
#

alias zshrc_version='echo "zshrc $zshrc_version_info, Original auf hera:/usr/local/etc/zshrc"'

# Pruefen wo die zshrc Datei auf diesem System liegt
# Wird beim Holen benutzt
# Linux und Freebsd in /usr/local/etc
# Debian in /etc/zsh
# Openbsd in /etc
zshrc_where_is_it () {
  if [[ -f "/usr/local/etc/zshrc" ]] ; then 
	zshrc_dest="/usr/local/etc/" 
  elif [[ -f "/etc/zsh/zshrc" ]] ; then 
	zshrc_dest="/etc/" 
  elif [[ -f "/etc/zshrc" ]] ; then 
	zshrc_dest="/etc/" 
  fi
  echo "zshrc liegt auf diesem System in $zshrc_dest"
}

zshrc_fetch_it () {
   zshrc_where_is_it
   echo "scp hera:/usr/local/etc/zshrc $zshrc_dest"
   scp hera:/usr/local/etc/zshrc $zshrc_dest
}


alias vi='nvim'

export EDITOR=nvim
export PAGER=most

alias e="$EDITOR"
alias se="sudo $EDITOR"  # sudo vi startet den "echten" vi da aliase nicht in sudo gelten

# Alternative Pager
#export PAGER="vim -u /usr/local/share/vim/vim73/macros/less.vim"
#export PAGER="nvim -c 'runtime! scripts/less.vim'"
#
#export MANPAGER="col -b | nvim -R -c 'set ft=man ts=8 nomod nolist nonu' -"
#
# nnorema  Gilt nur im Standard-Modus (Navigieren/Befehle).
# noremap  Gilt gleichzeitig für Normal, Visual und Operator-pending.
#export MANPAGER="col -b | vim -c 'set ft=man ts=8 nomod nolist nonu' -c 'nnoremap i <nop>' -"



zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit

# PATH
# Wenn ~/bin existiert und nicht im PATH ist vorne einbauen
# Noch nicht ganz korrekt
#if [[ -d "~/bin" && "$PATH" != "\~/bin" ]] ; then 
#	export PATH="~/bin:$PATH"
#fi
#if [[ -d "\~/bin" && "$PATH" != "\~/bin" ]] ; then export PATH="~/bin:$PATH"; fi

# Wenn ~/bin existiert im PATH vorne einbauen
#if [[ -d "~/bin" ]] ; then 
#	export PATH="~/bin:$PATH"
#fi

# Wenn ~/bin existiert und nicht im PATH enthalten
# ist im PATH vorne einbauen.
# Beide Schreibweisen beachten.
HOME_BIN="~/bin"
HOME_BIN_LONG=~/bin
if [[ -r "$HOME_BIN_LONG" ]] ; then
	# 17.01.2026 MKL
	# Wenn das "neue" if sauber funktioniert koennen die 
	# auskommentierten Zeilen mal weg.
	#
	# Probleme mit der doppelten Negierung. Daher der "doofe" else Teil
	#if [[ "$PATH" =~ "(^|:)$HOME_BIN(:|$)" || "$PATH" =~ "(^|:)$HOME_BIN_LONG(:|$)" ]] ; then 
	#if [[ "$PATH" =~ "$HOME_BIN" || "$PATH" =~ "$HOME_BIN_LONG" ]] ; then 
	#	export PATH
	#else
	#	export PATH="~/bin:$PATH"
	#fi
	if ! [[ "$PATH" =~ "$HOME_BIN" || "$PATH" =~ "$HOME_BIN_LONG" ]] ; then 
		export PATH="~/bin:$PATH"
	fi
fi


HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt histignorespace
setopt hist_ignore_all_dups
setopt append_history
setopt share_history


#  Emacs mode
bindkey -e


# Prompt and Prompt samples
setopt PROMPT_SUBST

#PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}%f$ '
#PROMPT='%F{white}%n@%m %F{blue}%~%(?.%F{green}.%F{red})#%f '
PROMPT='%n@%m %F{blue}%~%(?.%F{green}.%F{red})#%f '

# prompt -l zeigt die vorhandenen Prompt-Themes an, eine 
# Vorschau per prompt p erleichtert die Auswahl.
# Damit die prompt-Befehle funktionieren, initiieren 
# und laden Sie zunächst promptinit und setzen 
# anschließend das Prompt-Thema
#
# autoload -Uz promptinit
# promptinit
# prompt adam2


# Title der Fenster einstellen/reseten
alias title_reset='precmd() {}; print -Pn "\e]0;\a"'
# %n = User, %m = Hostname (kurz), 
# %~ = Pfad, %2~ = Pfad, lange eingekürzt auf 2 Verz.
alias title_uhd='precmd() {print -Pn "\e]0;%n@%m:%2~\a"}'



# eza config
#  Disable the “current user” and date highlighting
export EZA_COLORS="uu=0:gu=0:da=0"


# Aliases
alias els='eza -g -o -F --group-directories-first --no-permissions'
alias ell="els -la -F -a"
alias eltr="els -la -F -a --sort newest"

alias ls='ls -F'
alias ll="ls -lahF"
alias ltr="ls -ltrahF"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."


alias muttares='ssh -t -A ares mutt'
alias muttstrato='ssh -t -A ares "mutt -F ~/.muttrc_strato"'


# cd -CTRL-D  -> Auswahl der letzten Verzeichnisse
# cd [-][2] wechselt in das mit der Nummer 2 ausgewiesene Verzeichnis. 
setopt auto_pushd pushd_ignore_dups

setopt auto_cd correct

# Kein Piepen
setopt no_beep

# CLI Befehle mit "#" am Anfang werden als 
# Kommentar behandelt und nicht ausgefuehrt
setopt interactive_comments

# Entfernt '/' aus Wortzeichen
# Alt-d und Ctrl-d stoppen beimVerzeichnistrennen
WORDCHARS=${WORDCHARS:s:/:}

# uname und alles in kleinbuchstaben wandeln
RUNNING_OS=`uname -s  | tr '[:upper:]' '[:lower:]'`
case "$RUNNING_OS" in
	freebsd)
		# echo "zsh laeuft auf Freebsd"

		# Buntes grep
		export GREP_OPTIONS='--color=auto'

		# Fuer andere Farben wie hier z.B. grün
		#export GREP_COLOR='1;32'

		# Freebsd ls kann auch Farben mit -G
		alias ls='ls -F -G'
		alias ll="ls -lahF -G"
		alias ltr="ls -ltrahF -G"

		;;
	openbsd)
		# echo "zsh laeuft auf Openbsd"
		;;
	linux)
		# echo "zsh laeuft auf Linux"

		# Linux Version (Gnu ls)
		alias grep='grep --color=auto'

		alias ls='ls -F --color=auto'
		alias ll="ls -lahF --color=auto"
		alias ltr="ls -ltrahF --color=auto"

		;;
	*)
		echo "RUNNING_OS konnte nicht bestimmt werden"
		echo "Inhalt von RUNNING_OS ist $RUNNING_OS"
		;;
esac


#  Syntax soll immer ans Ende und dort geladen weden. 

# Debian Linux
SYNDATEI="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [[ -f "$SYNDATEI" ]]; then
    source "$SYNDATEI"
fi

# Freebsd
SYNDATEI="/usr/local/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
if [[ -f "$SYNDATEI" ]]; then
    source "$SYNDATEI"
fi

# Openbsd
SYNDATEI="/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [[ -f "$SYNDATEI" ]]; then
    source "$SYNDATEI"
fi

#
#   EOF
#
