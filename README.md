# Quartz

My personal [Quartz](https://quartz.jzhao.xyz/) repository. Quartz is publishing mechanism for linked `.md` files (Obsidian style), that runs on Hugo.

**I'm not the creator of this tool...** check-out the creator of Quartz!
> [github.com/jackyzha0/quartz](https://github.com/jackyzha0/quartz)

## Implementation details
- I use slightly altered version of original Quartz (see git diff).
- I push into `content` folder from my private Obsidian repository.
- But first I make some changes to frontmatter (add title and lastmod parameters) with [Obsifix](https://github.com/tikinang/obsifix) before pushing.
- I use `Obsidian Git` community plugin for back-up and synchronization of my Obsidian vault.
