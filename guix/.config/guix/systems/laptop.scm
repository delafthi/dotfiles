(use-module (delafthi system base))
(use-service-modules pm)

(operating-system
 (inherit %base-system)
 (host-name "")
 (mapped-devices '((mapped-device
                    (source (uuid "d5e76bab-c757-47a1-bfdf-6f2fddf04139"))
                    (target "cryptroot")
                    (type luks-device-mapping))))
 (file-systems (cons (file-system
                       (device (uuid "C591-D425" 'fat))
                       (mount-point "/boot/efi")
                       (type "vfat")))
                     %file-systems)
 (services (cons (service tlp-service-type (tlp-configuration
                                             (cpu-boost-on-ac? #t)
                                             (wifi-pwr-on-bat? #t))))))
