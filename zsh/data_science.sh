
SN="data science"
CODEDIR="$HOME/code/effective_pandas/"
BOOK="$HOME/code/books/pdf/effective-pandas.pdf"


# cd $CODEDIR

if tmux has-session "$SN"
then

    # open pdf in preview
    open "$BOOK"
    # attach to session
    tmux attach -t "$SN"

else
    # create session in background
    tmux new-session -s "$SN" -d

    # create and name windows
    tmux rename-window -t "$SN:0" "$EDITOR"
    tmux new-window -t "$SN:1" -n "iPython REPL"

    # start ipython shell
    tmux select-window -t "$SN:1"
    tmux send-keys ipython Enter

    # select editor window
    tmux select-window -t "$SN:0"


    open "$BOOK"
    tmux attach -t "$SN"
fi
