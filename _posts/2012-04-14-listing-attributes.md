---
layout: post
tags: [programming, ruby, rails]
---

This past week I was working on a Ruby on Rails project where I needed to list out a lot of attributes of an object. The difficult part came in the fact that I didn't want to display the attribute if it wasn't set or was 0.

Originally I had:

```erb
<% if @object.my_attribute && !@object.my_attribute.blank? %>  
  <li>  
    <strong>Attribute Label</strong>  
    <span><%= @object.my_attribute %></span>
  </li>  
<% end %>
```

When you start talking about 25 or 30 attributes you are printing out, some of which are nested, this gets to be a really ugly view. 

The next step was to move this to a helper method.

```erb
<%# in the view %>
<%= print_attribute("Attribute Label",@object.my_attribute) %>
```
```ruby
# view helper
def print_attribute(text,attribute)
  name = content_tag :strong, text
  prop = content_tag :span, attribute
  content_tag :li, name + prop
end
```

This is better, but gets messy when I needed to change the formatting on some attributes and other attributes needed to be printed in a different format (percentages, dollar values, etc).

I wanted the solution to be as easy as defining hash of attributes and titles. They way I could just grab my attributes:

```ruby
# view helper
def all_attributes(object)
  {
    'my_attribute' => 'Attribute Label',
    'nested_object.another_attribute_string' => 'Another Attribute'
  }
end
```

In order to define the additional information I created some `_string` methods which would return the right format or nil (which would get ignored later). For example:

```ruby
def another_attribute_string
  return nil if another_attribute.blank?
  "#{another_attribute} ft."
end
```

I wanted to be able to control the way they got printed in the view since it changed depending on which view I was in. My goal was to be able to write the following.

```erb
<% a = all_attributes_for(@listing) %>
<% attributes_for_view(@listing,a).each do |key,value| %>
  <li>
    <%= content_tag :span, key %>
    <%= content_tag :strong, value %>
  </li>
<% end %>
```

Thus the method needed to return a hash which had the correct label (key) and value (value).

```ruby
def attributes_for_view(obj,attributes)
  # This first inject will return the hash we want, with the value
  # of the label as the key and the attribute as the value
  attributes.to_a.inject({}) do |r,attribute_pair|
    # In order to do this, we first need to get the attribute.
    # We do the split in order to get nested objects. But we are
    # always starting with our root object, `obj`.
    value = attribute_pair[0].split(".").inject(obj) do |obj, attribute|
      obj.send(attribute)
    end

    # Skip this value if it is nil
    unless value.nil? 
      # Strings we want to keep as is
      if value.is_a?(String) && !value.blank?
        r[attribute_pair[1]] = value
  
      # For us, most of our numbers where dollar values. 
      # So rather than creating a custom `_string` method for each, 
      # it was easier to handle the case where the number 
      # shouldnt' be a dollar value.
      elsif value.is_a?(Integer) && value > 0
        r[attribute_pair[1]] = number_to_currency(value)
      end
    end

    # return the hash to continue building
    r
  end
end
```

A couple injects later I have a clean function that does exactly what I wanted.
