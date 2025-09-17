#!/usr/bin/env fish

if test (count $argv) -eq 0
    git diff --context 5 | mods --format --quiet --raw --role review-code | glow
else
    mods --format --quiet --raw --role review-code $argv | glow
end
