#!/usr/bin/env fish

if test (count $argv) -eq 0
    git diff --function-context | mods --format --role code-reviewer | glow
else
    mods --format --role code-reviewer $argv | glow
end
