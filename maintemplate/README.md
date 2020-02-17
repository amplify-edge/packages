# maintemplate

The Best Practice Architecture of Flutter and Golang and Boostrapping( tools and deployment) 

- Shows the architectural aspects working and how to do things.

- Other main projects then can follow how it does things.

- Allows UAT testing on the fundamental constructs across devices and find problems early and fix them here before doing lots of refactoring in main projects.



## Router
MUST be inheritable so that the routes in one package can be inherited by a main project.

- For example Cal or Doc or other mod level pahes will have their own internal routing.
