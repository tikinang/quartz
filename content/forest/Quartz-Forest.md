---
created: 2022-12-05T10:51:50+01:00
lastmod: 2022-12-15T17:20:39+01:00
title: Quartz-Forest
tags: []
aliases: []
---
# Proposal
It would be so cool, to be able to navigate through Obsidian or Quartz not on 2D plane graph, but in 3D generated space with paths. You would really feel like on a visit in someones magical forest - ready to be explored. [[forest/New Approach To Composing Obsidian Knowledge Base#A walk in the forest 🌱🌳🌲|Like on a walk.]]

# Implementation
Well, it would be nice, if you could experience this in browser, because of universal compatibility and publicity (as a show case, as a hyped up quartz).
On the other hand, it would be nice, if you could enter your own forest and just re-explore by your self on your local machine. Now that i think about it, you could the both in the browser. The latter with localy spawned server serving Quartz-Forest files on `localhost`.
Well then, **browser it is**. The bad thing is javascript though :/

## The Javascript way
It looks like this library [Three.js](https://threejs.org/) is fitting the purpose... There is a lot of mega-punk projects created with this library.

So I will basically procedurally render immediate surroundings (dark forest or whatever theme - make theme as a plugin) of a single note. There will be choices to go further (navigating either with mouse or wasd or up-left-down-right keys) in the notes graph. It will show rendered html text as in Quartz on a 2D plane in front. Use will be able to zoom in. There will also be a map in your hand (look down) with the graph already rendered with Quartz. There will be other navigation and search features hovering around you in space, such as search, go to Index, and so on...

## Notes
Please, draw inspiration from the projects on [Three.js](https://threejs.org/) website.  

Advice of ChatGTP.
![[forest/OpenAI ChatGPT Dialogue n.1#^ede578]]

I want to create this defacto https://logartis.info/ !!!

## Tasks
- [ ] create procedurally renderered graph space and ability to move in it, test on arbitrary graphs
	- [ ] move with `up-left-right` for starters, `up` for visit selected note, `left-right` for selecting the notes
- [ ] render only immediate surroundings, else will be blurred or in the dark (make it customizable)
- [ ] add 2D HTML note content in front of the visiting entity
- [ ] implement other features
	- [ ] hovering search
	- [ ] get out of the forest, back to Quartz
- [ ] add sounds and music
	- [ ] implement on/off switch
	- [ ] background music and sounds
	- [ ] interaction sounds
- [ ] integrate it to the Quartz (start with default Quartz page, with ability to enter the forest)
	- [ ] change design of my own Quartz so it fits the dark forest theme (to make wow effect)
- [ ] create public repository and share it with Quartz community

### To be continued?
- [ ] make forest theme as a plugin, so others can give life to their ideas of visualization of linked web of md files
- [ ] prerender visitable pages in the distance
- [ ] implement random note / spawn in the forest on random note [[forest/New Approach To Composing Obsidian Knowledge Base#Obsidian 'Random Note' plugin|as in Obsidian]]
