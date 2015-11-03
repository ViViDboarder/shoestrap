function notify-result --description "Notify success or failure depending on the result of the previous command"
    if [ $status -eq 0 ]
        notify-success
    else
        notify-fail
    end
end
