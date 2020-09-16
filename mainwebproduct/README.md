# Web product

A Web site for the Product is needed so that users can see what they are downloading.

THis is completley diferent to the current GCN site that is more about the WHY of the Project
- Put a link in the Product site to the CGN site as this is all we have time for.
	- Thats not unusual as it normal for an Og to make many products and have sites for each product



# URL

app.getcouragenow.org

# Best Example

https://github.com/sbis04/explore
- Responsive works Perfectly :)
- NO console errors :)
- To make it a many pages site, must change the code to a scaffold.
	- flutter guy can do that quickly

- Content management
	- change to work off Assets.
	- we can translate the assets then also using our translator.

- Buttons need to be changed to go to Anchor Links !!

- Nav
	- Home page shows the 4 buttons
	- But in non home page those 4 button links are is part of main nave.

- Content mapping
	- Header
	- Discover changes to Download and takes you to a Download page
		- Server and Desktop app.
	- Destinations changes to Screenshots of the Product Sections ( a type of destination within the app)
	- Dates changes to Book Demo and takes you to that page.
	- People changes to Team, and takes you to the Team page.
	- Experience changes to Features
	
	- Featured 
	- Footer
		- is Perfect the way it is

- Pages
	- Download
	- Screenshots ( same as home page carousel, but with text)
	- BookDemo
	- Team
	- Features
		- a big page. not many
		- reuse the screen 
	- About
		- Contact US
		- About us
		- Careers
	- HELP
		- Payment
		- Cancellation
		- FAQ
	- Social
		- Just links, so no new pages


- Testing Of Auth
	- Login with non google works, but no verification email send.
		- Login with same email again, with different password fails, which is correct.
	- Login via Google fails because of not eing setup on Google Server, which is correct
	- Uses Firebase LOcal storage ( indexDB)
		- IF we have access to the JWT in Client and Server its fine
			- Server needs event to tell it so it can make user in the DB, etc


Rosie needs to make content in those assets.


How to scroll to parts of the screen when the user presses a button ?
https://github.com/quire-io/scroll-to-index
- production tested 

Login


