(define-module (channels)
  #:use-module (guix channels))

(cons* (channel
        (name 'addguix)
        (url "https://git.sr.ht/~delafthi/addguix")
        (introduction
         (make-channel-introduction
          "ceb0f537a4aaee7de0b67d330d0cc0849f55eba1"
          (openpgp-fingerprint
           "525E BCF5 B866 B3FB 9EA6  CDA7 6365 80A5 946D 693E"))))
       (channel
        (name 'rde)
        (url "https://git.sr.ht/~abcdw/rde")
        (introduction
         (make-channel-introduction
          "257cebd587b66e4d865b3537a9a88cccd7107c95"
          (openpgp-fingerprint
           "2841 9AC6 5038 7440 C7E9  2FFA 2208 D209 58C1 DEB0"))))
       (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix.git")
        (introduction
         (make-channel-introduction
          "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
          (openpgp-fingerprint
           "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
       (channel
        (name 'guix-gaming-games)
        (url "https://gitlab.com/guix-gaming-channels/games.git")
        (introduction
         (make-channel-introduction
          "c23d64f1b8cc086659f8781b27ab6c7314c5cca5"
          (openpgp-fingerprint
           "50F3 3E2E 5B0C 3D90 0424  ABE8 9BDC F497 A4BB CC7F"))))
       %default-channels)
