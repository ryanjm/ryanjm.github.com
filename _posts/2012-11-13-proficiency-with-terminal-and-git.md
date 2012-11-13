---
layout: post
category: git
tags: [git, terminal, github]
source: ["Git and Github Secrets","http://confreaks.com/videos/1229-aloharuby2012-git-and-github-secrets"]
---

## Terminal

I've recently picked up an amazing Terminal shortcut: `^ + R`. Gone are the days of hitting up arrow a bunch of times to get to a previous command. This little shortcut will let you search through your recent commands. Just start typing what you want and it *pop* it shows up.

## Random Git commands

I recently watched Zach Holman's [Git and GitHub Secrets](http://confreaks.com/videos/1229-aloharuby2012-git-and-github-secrets) and it had a bunch of great nuggets. It helps to be able to go back through his [slides](https://speakerdeck.com/holman/git-and-github-secrets). Here are some of my favorites.

### Github

> Add `?w=1` to any url to ignore whitespace

> Git.io is github's url shortner. Check it out [git.io/nxVVig](git.io/nxVVig)

> Gists are repos

> Using hub you can push to multiple remotes: `hub push origin,staging`

> `?` in github to see all shortcuts

> Search commits by author: `?author=holman`

> I always forget this URL: [Emoji](http://www.emoji-cheat-sheet.com)

## Git

> Commitless Commits: `git commit -m "..." --allow-empty`

> Staging parts: `git add -p`

> Search commits: `git show :/query`

> Go back to previous selection: `cd -`, `git checkout -` 

> See which branches have been merged into current: `git branch --merged`

> See which branches have not been merged: `git branch --no-merged`

> See which branches contain a commit: `git branch --contains 838ad46`

> Copy file without switching: `git checkout branch -- path/to/file.rb`

> `git commit --amend -C HEAD` - alias this!

> `git reset --soft HEAD^` undoes the last commit and puts it on staging

There are a _bunch_ more, so watch the video.
