_final: _prev:
_prev.bun.overrideAttrs (oldAttrs: {
  nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ _final.makeBinaryWrapper ];
  postFixup = (oldAttrs.postFixup or "") + ''
    wrapProgram $out/bin/bun \
      --prefix PATH : ${_final.lib.makeBinPath [ _final.nodejs ]}
  '';
})
