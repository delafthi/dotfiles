(module plugins.conjure
  {autoload {: conjure}})

(defn init []
  "Initialize nvim for conjure"
  ;; Enable tree-sitter
  (set vim.g.conjure#extract#tree_sitter#enabled true)
  ;Mappings
  (set vim.g.conjure#mapping#doc_word "lw"))
