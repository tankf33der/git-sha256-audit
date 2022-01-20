(load "sha256.l")
(de L2hex (Lst)
   (lowc
      (pack
         (mapcar '((B) (pad 2 (hex B))) Lst) ) ) )
(de hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(de createL (Lst)
   (let Lst (split Lst "\*" "\,")
      (conc
         (need (setq @ (format (car Lst))) 0)
         (cons (hex (caddr Lst)))
         (need (abs (- @ 63)) 0) ) ) )
(de sha256 (M)
   (let (L (length M)  R)
      (native
         "libshagit.so.0"
         "blk_SHA256"
         NIL
         '(R (32 B . 32))
         (cons NIL (cons L) M)
         L )
      R ) )
(test
   (186 120 22 191 143 1 207 234 65 65 64 222 93 174 34 35 176 3 97 163 150 23 122 156 180 16 255 97 242 0 21 173)
   (sha256 (97 98 99)) )  # "abc"
            #(println K C)
(use (K C)
   (for F '("SHA256ShortMsg.rsp" "SHA256LongMsg.rsp")
      (in F
         (until (eof)
            (and
               (from "Msg = ")
               (setq K (hex2L (line T)))
               (from "MD = ")
               (setq C (hex2L (line T)))
               (test C (sha256 K)) ) ) ) )
      (in "Sha-2-256.unverified.test-vectors"
         (until (eof)
            (and
               (from "string: ")
               (setq K (createL (clip (line))))
               (from "hash=")
               (setq C
                  (conc
                     (hex2L (line T))
                     (hex2L (pack (clip (line)))) ) )
               (test C (sha256 K)) ) ) ) )
(test
   (sha256 (97 98 99))
   (sha256-lisp (97 98 99)) )
(for N (range 0 1024)
   (let L (need N 255)
      (test (sha256 L) (sha256-lisp L)) ) )
(msg 'ok)
(bye)
