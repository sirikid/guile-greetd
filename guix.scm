(use-modules
 (gnu packages autotools)
 (gnu packages guile)
 (gnu packages pkg-config)
 (guix build-system gnu)
 (guix gexp)
 (guix git-download)
 (guix licenses)
 (guix packages))

(package
  (name "guile-greetd")
  (version "git")
  (source
   (let ((dir (dirname (current-filename))))
     (local-file dir #:recursive? #t #:select? (git-predicate dir))))
  (build-system gnu-build-system)
  (arguments
   (list
    #:make-flags #~'("GUILE_AUTO_COMPILE=0") ;to prevent guild warnings
    #:modules `(((guix build guile-build-system)
                 #:select (target-guile-effective-version))
                ,@%gnu-build-system-modules)
    #:imported-modules `((guix build guile-build-system)
                         ,@%gnu-build-system-modules)
    #:phases
    #~(modify-phases %standard-phases
        (delete 'strip)
        (add-after 'install 'wrap-program
          (lambda* (#:key inputs outputs #:allow-other-keys)
            (let* ((out     (assoc-ref outputs "out"))
                   (bin     (string-append out "/bin"))
                   (version (target-guile-effective-version))
                   (scm     (string-append "/share/guile/site/" version))
                   (go      (string-append  "/lib/guile/" version "/site-ccache")))
              (wrap-program (string-append bin "/agreety")
                `("GUILE_LOAD_PATH" prefix (,(string-append out scm)))
                `("GUILE_LOAD_COMPILED_PATH" prefix (,(string-append out go))))))))))
  (native-inputs
   (list autoconf automake pkg-config))
  (inputs
   (list guile-3.0 guile-json-4))
  (home-page #f)
  (synopsis #f)
  (description #f)
  (license gpl3))
