# Email

where to do it ? sys-core/mailer
- everything needs to be able to access it
- /sys route can have a basic flutter GUI then to check settings etc.

## Spec

Will need for Verification when user signs up

Will need for a few other things that i know are part of mod-main also.

Async
- Normally you need an async job sender. Not sure we need one as we wont have much load at all

Proper HTML display in Email
- ensure golang templater can do that.

Config
- Can use a config kv for each email template type.

Tracking Single Pixel
- Will need this to ping our internal tracking system so we knwo the got the email. NOT using external ones !

Lang
- We need the emails to be in the users language
- For Signup the user does not exist in the DB, and so we need to detect it in Flutter and for flutter to tell golang over GRPC
- For Others, the user exist and so we need a User.DefaultLang to be stored in the DB at the time the User is Created during signUp. 
- We have runtime access to be able to translate emails and for now lets just use that
- Each email template MUST have a Lang field so we knwo what lang it was written in !
- Data format and currency will be needed !


Editing email templates
- Because we are whitelabel, we Must allow Orgs to have the standard sys level email templates use their Logo.
- Make sure Org data model has "Logo" field 

- Orgs will also need to be able to create email templates BUT that is later !!
- So for now the email templates can live in the sys code. We dont need any template files to be embedded

## libs

https://github.com/matcornic/hermes


https://github.com/LoginRadius/engineering-blog-samples/tree/master/GoLang/DifferentWaysToSendEmail


https://github.com/jiharal/libmail
- can use sendgrid or others.

https://github.com/KancioDevelopment/lib-angindai/blob/master/validator/init.go
- same as above but with Data and a few other bits


