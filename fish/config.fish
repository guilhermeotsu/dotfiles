if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias g "git"
alias n "nvim"

set --export ANDROID_HOME $HOME/Android/Sdk
set -gx PATH $ANDROID_HOME/emulator $PATH;
set -gx PATH $ANDROID_HOME/tools $PATH;
set -gx PATH $ANDROID_HOME/tools/bin $PATH;
set -gx PATH $ANDROID_HOME/platform-tools $PATH;

set --export JAVA_HOME /usr/lib/jvm/java-17-openjdk
set -gx PATH $JAVA_HOME/bin $PATH;
# starship init fish | source
