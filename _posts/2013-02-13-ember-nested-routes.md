---
layout: post
title: Ember.js Nested Routes
category: js
tags: js, ember
---
{% raw %}
I had a hard time with nested routes the first time, so I hope to clear it up for others. Let's start with the following router:

~~~js
App.Router.map(function(){
  this.resource('posts', function(){
    this.route('hello');
  });
});
~~~

In order to get to the root path we need to go to `#/posts`. The Router gives us some named routes which we can use with the Handlebars `linkTo` method or Ember's `transitionTo` method. Ember has done a great job of removing boiler plate code for us. It automatically creates `PostsView` and `PostsController` which will look for a `posts` template. Let's link to it from the application template:

~~~html
{{#linkTo 'posts'}}Posts{{/linkTo}}
~~~

What tripped me up is that when you define a resource, Ember will automatically use two templates (if given). The first you can think of as the "root" view. In this case it would be named `posts`. Additionally, following CRUD, it will also use an "index" view: `posts/index`. If you aren't going to have subviews then you could just use one template called `posts`, but if you want multiple subviews (show and edit for example) then you'll want to put an `{{outlet}}` inside the `posts` template in order for the subviews to be rendered there (or leave the `posts` template out all together). By going to `posts` (as in the `linkTo` above) it will, by default, attempt to render the `index` view. 

If instead we want to go to the hello route, we could link to it with:

~~~html
{{#linkTo 'posts.hello'}}Go to hello{{/linkTo}}
~~~

This idea of nested views also applies to nested resources, except that the name of the route will not be nested. If you want to see what routes you have (and their names) then in the JS console of your app type:

~~~js
App.Router.router.recognizer.names
~~~

Additionally if we want to have the default route (`/`) go to our posts we can do that with:

~~~js
App.IndexRoute = Em.Route.extend({
  redirect: function() {
    this.transitionTo('posts');
  }
});
~~~

Check out this [JS bin](http://jsbin.com/idebox/3/edit) to play around with this example code.

{% endraw %}

