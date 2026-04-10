{ pkgs }:
{
  caveman = pkgs.callPackage ./caveman { };
}
// (import ./anthropics-claude-code { inherit pkgs; })
