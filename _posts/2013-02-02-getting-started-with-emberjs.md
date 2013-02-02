---
layout: post
title: Getting Started with Ember.js
---
{% raw %}
I've been looking at Ember on and off for the past couple months and took a serious dive into it this past week. I stumbled through a few fo the basics so my goal with these next few posts is to help others get up to speed and solidify my own understanding.

## New App

There are a couple dependencies for Ember. You'll need `jQuery` _and_ `handlebars.js`. For this example we'll just reference these online:

~~~html
<script src="http://code.jquery.com/jquery.min.js"></script>
<script src="https://github.com/downloads/wycats/handlebars.js/handlebars-1.0.rc.1.js"></script>
<script src="https://raw.github.com/emberjs/ember.js/release-builds/ember-1.0.0-pre.4.js"></script>
~~~

Now that they are included we can create our application. When working with Ember you can either write out `Ember` or use `Em` for a shorthand. Your application is going to act as a namespace for everything in your Ember application. We'll create it by doing:

~~~js
App = Em.Application.create({});
~~~

Ember will automatically add an `ApplicationView` and `ApplicationController`. And by default it will look for a template without a name or with the name "application". So let's define that now:

~~~html
<script type="text/x-handlebars">
  This is the application template
</script>
~~~

This is all that we need to get our application to run. You can check this out on [jsbin](http://jsbin.com/idijen/1/edit).

## Template

Obviously some of the power of Ember comes through its ability to manage templates. You can render a template two ways. Either with the handlebar's `{{ outlet }}` control (which is similar to Ruby's `yield`) or with the `{{ view }}` command. We'll look at the outlet next time with Routes. This time let's create our first view:

~~~html
<script type="text/x-handlebars" data-template-name="hello">
  Hello World
</script>
~~~

Now we need to tell Ember about this view:

~~~js
App.HelloView = Em.View.extend({
  templateName: "hello"
});
~~~

We could also have added this as part of the inital setup of our App:

~~~js
App = Em.Application.create({
  HelloView: Em.View.extend({
    templateName: "hello"
  })
});
~~~

The last thing we need to do is use the `view` method in order to add this to our application layout:

~~~html
<script type="text/x-handlebars">
  This is the application template<br/>
  {{view App.HelloView}}
</script>
~~~

And that's it. You can check out the [jsbin](http://jsbin.com/idijen/3/edit).

## Views

One last thing with views. You can define attributes about the view and even define properties on the view. For example if we updated our view:

~~~js
App.HelloView = Em.View.extend({
  templateName: "hello",
  message: "Hello World",
  classNames: ["bold"]
});
~~~

We can use this `message` variable in order to display something within our view:

~~~html
<script type="text/x-handlebars" data-template-name="hello">
  {{view.message}}
</script>
~~~

Additionally, the div that the Ember view uses, will have the class `bold`. If we need to change what kind of element the View is rendered with we do that with `tagName`. Here is the [jsbin](http://jsbin.com/idijen/4/edit).

In the next post I'll go through the router, controllers, and more about the templates.
{% endraw %}
