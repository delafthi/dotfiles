args:
let
  mergeAttrSets = sets: builtins.foldl' (acc: set: acc // set) { } sets;
in
mergeAttrSets [
  (import ./vm args)
]
