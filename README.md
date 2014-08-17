# JEANS Playground

**(J)ade, (E)xpress, (A)ngular, (N)ode, (S)ass**
- - - - - - - - - - - - - - - - - - - - - - - - -

## About

This is a very lightweight configuration of a Node.js server with an Angular.js
frontend. It is designed mainly with quick and dirty experimintation in mind.
There is just enough boilerplate code for hacking right away, but not a line
more.

A lot of the structure is shamefully borrowed from the Angular-Fullstack
generator. That thing is amazing, but it was too bulky for my taste.

## Installation

There are four requirenments:

* Node.js
* Bower
* Sass gem (Which means ruby... =( You gotta pay for convenience.)
* Grunt-cli

After you come back frome the quest having obtained those three items
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

