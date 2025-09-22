#!/usr/bin/env fish

if test (count $argv) -eq 0
    jj diff --git --context 5 --no-pager | mods --format --quiet --raw --role review-code | glow
else
    mods --format --quiet --raw --role review-code $argv | glow
end
