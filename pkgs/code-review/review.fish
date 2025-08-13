#!/usr/bin/env fish

if test (count $argv) -eq 0
    git diff -W | mods -f -R code-reviewer | glow
else
    mods -f -R code-reviewer $argv | glow
end
