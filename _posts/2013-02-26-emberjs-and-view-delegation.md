---
layout: post
title: Ember.js and View Delegation
category: js
tags: js, ember
---

{% raw %}

Ember makes it easy to add an action to a button or an anchor tag with the `{{action}}` helper, but sometimes you need more control. Delegation works out really well. You create a view, specify the delegate, and the function(s) you want called. The nice thing is you can add as many actions as you want the view to have and you can reuse it for different controllers.

In your view you can add:

~~~
{{#view App.HoverView delegateBinding='this' action='showBoldAction'}}
  ...
{{/view}}
~~~

Then just define the view:

~~~
App.HoverView = Em.View.extend({
  tagName: 'span',
  mouseEnter: function(){
    this.get('delegate').send(this.get('action'));
  },
  mouseLeave: function(){
    this.get('delegate').send(this.get('action'));
  }
});
~~~

I've used this to give better control around TextFields and hovering actions such as the one above. Check out a [jsbin](http://jsbin.com/ihiyis/1/edit) of this in action.

{% endraw %}

