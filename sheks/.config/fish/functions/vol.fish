function vol
  amixer set Master "$argv[1]"% | tail -n 2
end
