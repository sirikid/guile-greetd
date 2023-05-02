(define-module (greetd protocol)
  #:use-module (ice-9 match)
  #:use-module (json record)
  #:export
  (request->scm
   <create-session>
   <post-auth-message-response>
   <start-session>
   <cancel-session>

   scm->response
   <success>
   <error>
   <auth-message>))

;; Requests

(define-json-type <create-session>
  (username))

(define-json-type <post-auth-message-response>
  (response))

(define-json-type <start-session>
  (command "cmd")
  (environment "env"))

(define-json-type <cancel-session>)

(define (request->scm req)
  (define (go type encoder)
    (acons "type" type (encoder req)))
  (match req
    (($ <create-session>)
     (go "create_session"
         create-session->scm))
    (($ <post-auth-message-response>)
     (go "post_auth_message_response"
         post-auth-message-response->scm))
    (($ <start-session>)
     (go "start_session"
         start-session->scm))
    (($ <cancel-session>)
     (go "cancel_session"
         cancel-session->scm))))

(define-public create-session make-create-session)
(define-public post-auth-message-response make-post-auth-message-response)
(define-public start-session make-start-session)
(define-public cancel-session make-cancel-session)

;; Responses

(define-json-type <success>)

(define-json-type <error>
  (type "error_type")
  (description))

(define-json-type <auth-message>
  (type "auth_message_type")
  (prompt "auth_message"))

(define (scm->response scm)
  (define (->response type)
    ((cond
      ((string=? type "success") scm->success)
      ((string=? type "error") scm->error)
      ((string=? type "auth_message") scm->auth-message))
     scm))
  (and=> (assoc-ref scm "type") ->response))
