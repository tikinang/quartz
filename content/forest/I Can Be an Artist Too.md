---
created: 2022-08-02T14:27:06+02:00
lastmod: 2022-12-04T22:18:14+01:00
title: I Can Be an Artist Too
tags: []
aliases: []
---
# Idea

```
-> customer -> our service -> print-on-demand -> customer -> 
```

An internet shop with printed paintings, where customers can create (generate) their own art based on their text description. [[forest/I Can Be an Artist Too#Creating|creating]]
Art will be generated with DALL-E 2 by OpenAI. We will outsource framing, printing and shipping of paintings with Print-On-Demand (POD) service.
Customer would be able to see, if he uploads a photo of his/her room, how different paintings fit into his room and would be able to pick the most matching. [[forest/I Can Be an Artist Too#Visioning|visioning]]
Customers would be also able to go through and buy the paintings other creators and customers had generated on the site. [[forest/I Can Be an Artist Too#Sightseeing|sightseeing]]

See what DALL-E 2 is capable of generating:
[2 Minute Papers Video Review](https://www.youtube.com/watch?v=X3_LD3R_Ygs)
[Official Website](https://www.youtube.com/watch?v=X3_LD3R_Ygs)

Available POD services:
- [Printful](https://www.printful.com/custom/wall-art/framed-posters)
- [Shopify](https://www.shopify.com/blog/print-on-demand)

## Creating
## Visioning
## Sightseeing

---
# Engineering
## api
- [SQLite](https://www.sqlite.org/index.html) + [Litestream](https://litestream.io/)
- go binary API
- [Stripe](https://stripe.com/en-ee) payments

### entities
- creator
- painting
- order

### flows
- flow **WHOLE**: create / lookup art -> select framing options -> proceed to billing and shipping options -> buy -> profit  
- flow **CREATE**: see tutorial -> write your description -> see variants -> (repeat) -> proceed to order and buy  
- flow **PUBLISH**: write your description -> see variants -> (repeat) -> publish it to marketplace

## gui
- angular
- [ ] who's gonna do it?

---
# Marketing
>Just click buy and we will print it, frame it, ship it. Done in 3 minutes.
- easy embedded tutorial video - done in 3 minutes- show user reviews with photos of their art hanging on walls in their home  
- give them a hundred of ideas and examples
- [ ] whom and where to sell it?

## Instagram
Because it is visual (and square).

## PPC?

---
# Notes
- future idea: customer's photos AI enhancement / montages
- not only on wall art but t-shirts, mugs, pillows and all sorts of other shit
