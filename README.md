# JEANS Playground

**(J)ade, (E)xpress, (A)ngular, (N)ode, (S)[a,c]ss**
- - - - - - - - - - - - - - - - - - - - - - - - -

## About

This is a very lightweight configuration of a Node.js server with an Angular.js
frontend. It is designed mainly with quick and dirty experimintation in mind.
There is just enough boilerplate code for hacking right away, but not a line
more.

A lot of the structure is shamefully borrowed from the Angular-Fullstack
generator. That thing is amazing, but it was too bulky for my taste.

## A Bit about the structure

There are two folders one for server other one for client.
The client is meant to be a one page application, and the server provides the json API
for it. 

* There is one folder per every view in the client `app` folder.
* There is one folder per API endpoint in the server `api` folder.
* There is a coffeescript base class for quickly creating controllers in the `app.coffee` file.
* You set up server api routes in the routes file and handle them in `api` folder.

Simple hack friendly set up.

## A lot of tedious work is automated already

I set up a Gruntfile with most of the task you will need for happy hacking.

Need a frontend library/css framework?

```bash
bower install <library_name> --save && grunt wiredep
```

And you are good to go. It will be already included in the `index.jade` file.

## Installation

Lets get to installation!

**Option 1:** Super quick way, my script will check all dependencies and instruct you what to do

```
$ \curl -sSL http://goo.gl/Blphg1 > inst.sh && chmod u+x inst.sh && ./inst.sh
```

**Option 2:** Manual

There are two main requirenments:

* Node.js
* Ruby

You need also need `Bower`, `Grunt` Node packages and a `Sass/Scss` gems. The commands to install them below:

```bash
$ npm install -g grunt-cli
$ npm install -g bower
$ gem install sass
```

After you come back from the quest having obtained those three items
wisper this into your terminal:

```bash
$ git clone git://github.com/NonLogicalDev/jeans-nodejs-playground
$ cd jeans-nodejs-playground
$ npm install
$ bower install
```

And there you have it! Just type:

```bash
$ grunt livedev
```

Your browser should pop open with live reload on. Happy hacking!

## TODO:
* Add minimal MongoDB configuration

