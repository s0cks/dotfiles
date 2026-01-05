{
  NewWidget(name, func = null):
    [
      "zle -N " + name + (if func != null then " " + func else ""),
    ],
}
