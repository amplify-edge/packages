# about contacts protobuffers IDL


## 0. Purpose


end-user / members management , also call UMS ( user management sub-system) . in platform, end-user call account.


### 0.1 account register and active


- [ ] user register via email / phone number. After register success, generate a user ID and PIN ( personal identify number ) for registered user,
and set user status as UNVERIFIED
- [ ] server side send verified email to account's email box with a active URI , end user should click the URI to verify email box is avail.
After user's email box is verified, user status set to ACTIVE.
- [ ] ( optional ) server side send active code to user's phone, and user active account via active code in GUI
- [ ] when user's account activating in URI ( web page ) / GUI ( in IOS/android app ) , server side generated default password for account , and user may choose to change the default password.
After this step, account active success.
End-user may log in into platform via email + password or phone-number + password.


### 0.2 user login ( account authentication ) and authorization


TBD


### 0.3 address book edit and sync


TBD


### 0.4 some for discussion


address book store in local cache only, unless user signed the agreement to sync and store in server side


## 1. GUI


### 1.1 register UI


Register form
1. tid, int64, hidden field, generate a radon int64 as transaction id, use snowflake id as well
2. auth,hidden field , activeType as 0 ( register )
3. valid email address , string , need verify email format
4. password, 6 charser at less
5. phone number , need verify phone number format.


Register success, server side return:
1. id , int64, it's pre-generated account id
2. PIN, string
3. secretTokens, string


that 3 field please storage in apk local cache


### 1.2. Login UI


Login form
1. ( hidden field ) tid, int64
2. email or phone number
3. password
4. ( hidden field ) secretTokens


login success, server side return:
account
profile


Then user should be able to edit profile , and edit address book.


### 1.3 account and profile UI


Acount info and user profile in one UI or in two tab
user should be able to edit any field inline.


### 1.4 address book UI


add new contact UI


1. id , contact id , generated in local
2. name
3. email
4. note
5. address
6. one or more phone number.


When address book edit is done , user should be able sync address book to server side.


affterAddress book sync success , server side return a server side address book , then merge to local cache.


in server side:
1. When email / phone number is same as existed account, accountID file will fill in server side. ( then user should be able chat / send message to existed account's inbox )
2. server side store last 2 version's address book with lastSyncActivity ( timestamp ) as mark.
3. ( optional ) server side will store all members relationship as graph /mapping
