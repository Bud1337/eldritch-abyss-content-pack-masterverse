; The GIMP -- an image manipulation program
; Copyright (C) 1995 Spencer Kimball and Peter Mattis
;
; --------------------------------------------------------------------
;
; --------------------------------------------------------------------

(define
    (script-fu-export-all-layers-to-dds
      image     ; IMAGE
      drawable  ; DRAWABLE (no need)
      directory ; base file name with directory
    )
    
    (define (floor x) (- x (fmod x 1)))

    (define (div x y) (floor (/ x y)))
  
    ; routine definitions
    (define (save-to-dds image layer)
        (file-dds-save 1 image layer (gen-name layer ".dds") "" 0 0))

    (define (gen-name layer ext)
        (let* ((string-append directory (gimp-layer-get-name layer) ext))))
(print 1)
    ; variable definitions
    (let* 
        (
            (increment 0)
            (layers (gimp-image-get-layers image))
            (numberOfLayers (car layers))
            (imageType (car (gimp-image-base-type image)))
        )
    )
    (print increment)
    ; end variable definition
   
    (while (< increment numberOfLayers)
        (let* 
            (
                (tmp-image-type (imageType))
                (layer (aref (cadr layers) (if (= reverse 1) increment (- numberOfLayers 1 increment))))
                (tmp-img (car (gimp-image-new (car (gimp-drawable-width layer)) (car (gimp-drawable-height layer)) tmp-image-type)))
                (tmp-layer (car (gimp-layer-new tmp-img (car (gimp-drawable-width layer)) (car (gimp-drawable-height layer)) (+ 1 (* 2 tmp-image-type)) "Temp Layer" 100 NORMAL)))
            )
        )
        ; save a resulting image by specified image type
        (save-to-dds tmp-img tmp-layer)
        (gimp-image-delete tmp-img)
        ;(gimp-display-delete tmp-display)
        (set! increment (+ increment 1))
    )
)

; --------------------------------------------------------------------

(script-fu-register
   "script-fu-export-all-layers-to-dds"
   "Export all Layers (DDS)"
   "Exports all Layers to an image named by layer"
   "Manuel Lieb"
   "copyright 2021, Manuel Lieb"
   "December 27, 2021"
   "RGB* INDEXED* GRAY*"
   SF-IMAGE      "Image"            0
   SF-DRAWABLE   "Drawable"         0
   SF-DIRNAME    "Saving Directory"  ""
)
(script-fu-menu-register "script-fu-export-all-layers-to-dds" "<Image>/Script-Fu/Export")