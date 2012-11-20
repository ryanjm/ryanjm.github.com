---
layout: post
category: vim
tags: [vim]
---

One of the big time savers I loved in TextMate was the ability to copy and paste multiple things at a time. In TextMate, if you will &#8984;+C multiple items of text, you can paste them out doing &#8984;+V, &#8984;+&#x21E7;+V, and then repeating &#8984;+&#x21E7;+V till you are done.

In Vim, it isn't that easy. Vim has registeres which are places you can place text to use later. To see your current list of registers use `:reg`. 

The docs say there are 9 types of registers:

~~~
1. The unnamed register ""
2. 10 numbered registers "0 to "9
3. The small delete register "-
4. 26 named registers "a to "z or "A to "Z
5. four read-only registers ":, "., "% and "#
6. the expression register "=
7. The selection and drop registers "*, "+ and "~ 
8. The black hole register "_
9. Last search pattern register "/
~~~

If you want to delete a line and not lose the last thing you copied / deleted, you have to delete it into the black hole register `"_dd`. One convient thing is that for every delete or change, vim automatically puts those into the 1-9 register, shifting them up one register each time.

For example, if you had the following lines:

~~~
Line 1
Line 2
Line 3
~~~

And you go down each line and delete it with `dd`, then you could paste them all out with the following commands:

~~~
"1p
.
.
~~~

That is, you paste from the first register, and then you repeat with `.`, which normally repeats the last command, in thise can it will automatically walk up the other registers for you. Unfortinetly, yank doesn't work this way.

For yank you can put the text into a register by doing `"xy` where `x` is the register you want to use. This is the only way to yank multiple lines or sections of code and be able to reuse them later.

