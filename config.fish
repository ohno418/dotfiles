# Start the window manager if on tty1.
if test (tty) = "/dev/tty1"
    # Use CapsLock as Ctrl.
    set -gx XKB_DEFAULT_OPTIONS caps:ctrl_modifier

    # fcitx5
    # Do this before starting the wm. Otherwise, run into some glitches.
    set -gx GTK_IM_MODULE fcitx
    set -gx QT_IM_MODULE fcitx

    river
end

# -- Enironment variables --
# cargo
fish_add_path --global --prepend $HOME/.cargo/bin

# -- Aliases --
function vi; nvim $argv; end
function t; tmux $argv; end
# git
function gs;  git status $argv;        end
function gd;  git diff $argv;          end
function gdc; git diff --cached $argv; end
function ga;  git add $argv;           end
function gc;  git commit $argv;        end
function gg;  git grep $argv;          end
function gl;  git log $argv;           end
function gb;  git branch $argv;        end
function gch; git checkout $argv;      end
function gsw; git switch $argv;        end
function gf;  git fetch $argv;         end

# -- Misc --
# Suppress welcome message on startup.
set fish_greeting

# Load nodenv.
status --is-interactive; and source (nodenv init -|psub)
