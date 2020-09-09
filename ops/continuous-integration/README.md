# CI / CD

Artifacts we need to allow for are:

1. Servers

- Web Client code is embedded.

3. Mobile

4. Desktop

# Flow

alpha, beta, stable.

- alpha maps to master git branch.
- beta maps to beta git tag.
- stable maps to stable git tag.

Every build uses the next version.

When a build works we update the alpha tag by:
- checkout the githash of the version.
- tag it as alpha

We have a simple json file that holds this mapping also, so that standard scripts can work on top of it.

We use a makefile to do all this.

When we are happy with alpha of beta, we promote it using the same tagging approach.

## CI

Currently using Github actions.

Need to transition to using a Mac Mini and a local CI that runs the make files.
This will make things much easier as we have a single makefile approach, secrets local, easy to fix and extend.

## CD

Currently using Github releases. It works fine enough.

The Servers simply poll the Github releases to look for an upgrade.



