if test (tty) = "/dev/tty1"
    # Use CapsLock as Ctrl.
    set -x XKB_DEFAULT_OPTIONS caps:ctrl_modifier

    # cargo
    set -x PATH $HOME/.cargo/bin $PATH

    # fcitx5
    set -x GTK_IM_MODULE fcitx
    set -x QT_IM_MODULE fcitx

    # Load nodenv.
    status --is-interactive; and source (nodenv init -|psub)

    # Start river window manager.
    river
end

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
