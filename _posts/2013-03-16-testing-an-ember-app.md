---
layout: post
title: Testing an Ember.js App
category: js
tags: [js, ember]
---

When developing in Rails I prefer to do TDD. So when I start my Ember app I wanted to do the same. Unfortunately there isn't much out there. Ember.js uses [QUnit](http://qunitjs.com/), but after fiddling around for a day trying to get it set up with my Rails project I wasn't having any luck.

Then I saw Jo Liss's [Testing Ember Apps](http://www.slideshare.net/jo_liss/testing-ember-apps) presentation and saw that she used [Konacha](https://github.com/jfirebaugh/konacha). Konacha is built for Rails and puts together Mocha and Chai (see the github page for more information). 

It uses Rails's asset pipeline which means it is really easy to get started, but after the initial setup there were a couple bumps in the road for me.

## Load the whole thing or parts in isolation?

Some people say you should run your tests in isolation. Others say to just load the entire Ember.js app. So I [asked](https://twitter.com/ryanjm33/status/310155183327948800) and Jo said she loaded the entire thing.

To do this, I added a `spec_helper.js` that loads the same files `application.js` does. Since the asset pipeline is supported it is just copy and paste. The main thing I changed in my `spec_helper.js` is to put my app into testing.

~~~js
Ember.testing = true;

App = Ember.Application.create();
~~~

Then inside my tests I do three things: require the `spec_helper`; add a `before` callback in which I create an instance of the app; and add an `afterEach` in order to reset the app after each test.

~~~js
//= require spec_helper

describe("MyModel", function() {
  before(function() {
    Ember.run(function() {
      App.initialize();     
    });    
  });

  afterEach(function() {
    Ember.run(function() {
      App.reset();
    });
  });
  
  ...
});
~~~

Remember that when you have `Ember.testing = true` you have to wrap most things in `Ember.run`. I'm still figuring out when I do and don't need it.

## Fixtures

In trying to keep things DRY, I wanted the ability to create the same object multiple times. I'm not sure if there are best practices out there for js testing, but I ended up creating a `fixtures` dir under `spec/javascripts` to hold my fixtures.

Since you need to be able to identify _when_ to create a given object wrap it inside a function.

~~~js
function myModelFixture() {

  App.adapter.load(App.store, App.MyModel, {
    id: 1,
    name: "Hello World"
  });
};
~~~

This lets us call it in a `beforeEach` method.

~~~js
describe("MyModel", function() {
  beforeEach(function() {
    Ember.run(function() {
      budgetFixture();
    });
  });
  ...
});
~~~

## Loading Data

Konacha runs everything in the browser. Therefore to test Ember Data models you have to create them (thus the fixutres above). My problem came with figuring out the proper way to do so.

I first tried `App.MyModel.createRecord();` which worked for simple models, but when I started trying to do embedded objects it wasn't working. 

I looked through Ember's source and saw they did `App.store.load(App.MyModel, {...});` and that worked for awhile until I figured out the models weren't actually being created. I could test of the length of the embedded objects, but not actually grab any of them. 

I then found I had to do `App.adapter.load(App.store, App.MyModel, {...});`. This means you need to create an instance of your store and your adapter. Because I'm using `FixtureAdapter` for when I do my views, I ended up extending the adapter. This means in my `spec_helper` I do:

~~~js
App.Adapter = DS.RESTAdapter.extend();
~~~

Since this is loaded before my `store.js` I can make it the default for `App.Adapter`. In `store.js` I have:

~~~js
App.Adapter = App.Adapter || DS.FixtureAdapter.extend();

App.Store = DS.Store.extend({
  revision: 11,
  adapter: App.Adapter
});

App.store = App.Store.create();
~~~

Because I have my embed rules next to my models, my adapter has to be created after the models:

~~~js
App.MyModel = DS.Model.extend(...)

App.Adapter.map(App.MyModel, {
  otherModel: { embedded: 'always' }
});

...

App.adapter = App.Adapter.create();
~~~

Now that all of this is in place I've been able to start testing my models with confidence.
