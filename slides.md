---
title: Ply
subtitle: A Visual Web Inspector for Learning from Professional Webpages
author:
  - Sarah Lim, Josh Hibschman, Haoqi Zhang, Nell O'Rourke
  - Northwestern University
date: UIST 2018, Berlin

bibliography:
  - /Users/sarah/Dropbox/Study/uist2018/talk/citations.bib
  - /Users/sarah/Dropbox/Study/uist2018/talk/rale.bib
suppress-bibliography: true

theme: slim
slideNumber: true
height: 850
transition: none
---

## Modern web design is complex

![Airbnb homepage](img/airbnb.png){.captioned}


:::notes
Modern webpages are complex, full-featured applications with really impressive designs, and there are a lot of people interested in learning to style these rich interfaces.

The nice thing about the Web is that even if I'm an inexperienced developer, it's really easy to stumble upon tons of interesting designs during my regular browsing sessions.
:::


## "How do I make a form like this?"

![Airbnb booking bar component](img/airbnb-bar.png)


:::notes
And so let's say I come across this example from the Airbnb homepage, and I'd like to replicate this booking bar here.
:::


## Tutorials may be hard to find

![Codrops tutorial search](img/codrops-search.png){.captioned.captioned-light}


:::notes
So one thing you can do is to search for tutorials on Google, or browse a website like CSSTricks.

But this is actually not trivial, because it's difficult to articulate exactly what you're looking for.
:::

## Jargon-heavy keywords

![Codrops tutorial search](img/codrops-tutorials.png){.captioned.captioned-light}


::: notes
On top of that, many tutorials use domain-specific keywords like "Material design" or "jump loader animation" that might not be familiar to novices.
:::

## Tutorials can be too simple

![Airbnb booking bar component](img/airbnb-bar.png)

vs.

![A similar Codepen](img/codepen.png)


:::notes
But the biggest problem is that tutorials are often _too simplistic_, and don't offer the same richness of professional designs.

This is an example of a Codepen that came up when I searched for "booking form CSS tutorial". You can see that it's definitely a booking form, but not quite what we want from the Airbnb example.
:::


## Any webpage can be inspected...

![Inspecting the Airbnb homepage in CDT](img/airbnb-cdt.png)


:::notes
Now if you're an expert, you can just use the "Inspect Element" feature built into modern browser devtools to inspect the actual DOM and CSS used to construct the page.

And experts perform this sort of debugging and inspection quite frequently, to understand how other webpages implement effects using modern development best practices that tutorials don't always convey.
:::

## Tools are overwhelming to novices


:::::: annotated
![Not](img/airbnb-cdt-only.png)


::: {.annotation .right .top style="width: 30%; height: 78%;"}
:::
::::::


:::notes
Unfortunately, if you're relatively new to web design and you only know basic HTML and CSS syntax but not development practices, the output of the inspector is pretty overwhelming for any nontrivial webpage.

In this talk, I'm going to show you

- what exactly novices find challenging about inspecting production webpage CSS
- what that implies for the design of inspection tools
- how we implemented that tool
- and how it actually worked


:::


## Needfinding

- **Surveyed** undergraduate web developers ($n = 20$)

  - Experiences with tutorials, inspecting examples

- In-person **follow-up study** ($n = 10$)

  - Replicating features from professional webpages using Chrome DevTools (CDT)

<!-- TODO: Include images of Uber, etc. -->


:::notes
We conducted two stages of needfinding.

1. Surveyed 20 undergrad web devs about their experiences learning web development, using tutorials, and inspecting professional examples

2. Followed up with 10 of them for an in-person study, during which they replicated web features on professional webpages using CDT

More details in paper
:::


## Novices rely on visual intuition, but existing inspection tools do not support reasoning visually about unfamiliar code.

<!-- [@Gross:2010:TTF:1937117.1937123; @JoelBrandt:2010ula; @Ko:2004td] -->

---

<h2 class="h1">Obstacles to inspection</h2>


## Problem 1: Visually ineffective properties


::: annotated
![Visually ineffective properties](img/airbnb-cdt-css.png)


::: {.annotation .filled style="width: 50%; height: 26%; top: 23%; left: 21%;"}
:::
::: {.annotation .filled style="width: 50%; height: 4%; top: 60%; left: 21%;"}
:::
::: {.annotation style="width: 50%; height: 2%; top: 63%; left: 21%; border-color: blue;"}
:::
:::


:::notes
TODO: Elaborate on why
:::


## Problem 2: Missing conceptual knowledge


:::::: annotated
![Indiegogo website footer](img/indiegogo.png)


::: {.annotation style="width: 55%; height: 40%; top: 20%; left: 5%;"}
:::
::::::


:::notes
Visual intuition does not match behaviour of the language
:::



## Properties have relationships

```css
.quickLinksSection {
  display: flex;
  flex-basis: 67%;
  justify-content: space-between;
}
```

![Indiegogo website footer](img/indiegogo-footer-cropped.png)


:::notes
But recall that our goal is to help novices _learn_ CSS by example, not just reproduce designs.

For this situation, a minimal slice is necessary but not sufficient. A lot of the users in our studies had heard of Flexbox but didn't know anything else about it, so looking at these four properties wouldn't tell them anything about how it works.

So if you're a novice CSS user who relies heavily on visual guess-and-check to reason about stylesheets, what conceptual knowledge are you missing?
:::


## Dependencies between properties

### Wrong

```css
.quickLinksSection {
  display: flex;
  flex-basis: 67%;
  /* ------------------------------------- */
  justify-content: space-between;
}
```

### Correct

<!-- TODO: Animations -->

```css
.quickLinksSection {
  display: flex;
  justify-content: space-between;
  /* ------------------------------------- */
  flex-basis: 67%;
}
```

:::notes
Tragically, while grouping based on substring match is a decent heuristic, it's also misleading in this case.

- `flex-basis` actually behaves totally independently of `display: flex;`
- `justify-content`, however, _does_ depend on `display: flex;`
:::


## Designing a learner-friendly web inspector

1. **Hide visually-irrelevant code** from inspector output to minimize information overload and support novices' visual approach to sense-making

2. **Embed contextual guidance** into inspector output to explain how CSS properties coordinate to produce visual effects.

[@Quintana:2004bg]


:::notes
We developed a set of design guidelines based on our observations, by adapting prior work done by Chris Quintana et al. on software-supported sense-making.

Their guidelines are:

1. Use representations and language that bridge learners' understanding (which in our case is visual intuition)

2. Embed expert guidance into the sense-making process to provide missing domain knowledge
:::

---

<h2 class="h1">Ply</h2>

![Ply teaser screenshot](img/ply-overview.png)

<http://localhost:7999/indiegogo>


## Pruning ineffective properties

TODO: GIF

> **Hide visually-irrelevant code** from inspector output to minimize information overload and support novices' visual approach to sense-making


## Computing dependencies

TODO: GIF

> **Embed contextual guidance** into inspector output to explain how CSS properties coordinate to produce visual effects.


::: notes
Context of sense-making
:::


---

<h1 class="h2">Visual Relevance Testing</h1>

## Inspiration: Visual regression testing

![TODO: Screenshot of visual regression testing diff]()


:::notes
Our approach is inspired by a technique called visual regression testing, which is unrelated to statistical regression.

- Start with a UI codebase and take screenshots of key routes
- These screenshots are groundtruth
- Check in a change
- Re-render application and take screenshots of the same routes
- Compare to previous screenshots
- If there is a visual difference -- a potential _regression_
:::

## Key idea

A property is **visually effective** if and only if its deletion causes a regression

---

![Original](img/vrt-before.png){.captioned}

. . .

![Disable `width: 100%;`](img/vrt-after.png){.captioned}

. . .

![Visual regression](img/vrt-diff.png){.captioned}


::: framed
$\implies \quad$ `width: 100%;` is **effective**
:::

---

![Original](img/vrt-before.png){.captioned}

. . .

![Disable `display: block;`](img/vrt-before.png){.captioned}

. . .

![No regression](img/vrt-diff-none.png){.captioned}


::: framed
$\implies \quad$ `display: block;` is **ineffective**
:::


## Implicit dependencies

```css
.quickLinksSection {
  display: flex;
  justify-content: space-between;
}
```

. . . 


### `display: flex;`

TODO: GIF of toggling `justify-content`


. . .


### <strike>`display: flex;`</strike>

TODO: GIF of toggling `justify-content`


## Implicit dependencies

A property `justify-content`{style="color: red;"} _depends on_ a property `display: flex;`{style="color: blue;"} if

::: framed
`justify-content`{style="color: red;"} is **visually effective** if and only if `display: flex;`{style="color: blue;"} is active.
:::

---

<h2 class="h1">Evaluation</h2>

## Study 1: Replication speed


::: framed
Does pruning ineffective properties help developers replicate features more quickly?
:::

## Setup

![IDEO grid](img/ideo.png)

- $n = 12$, between-subjects, CDT as control
- 40 minutes, three milestones


## Cumulative completion times

![Milestones](img/milestones.png){width=100%}


::: notes
- Ply users 3.5 times faster to first milestone
  - $t(10) = -3.5, p = .01$
  - Ply: $\mu = 2.5, \sigma = 1.64$
  - CDT: $\mu = 8.83, \sigma = 4.167$

- Overall 50\% faster (not statistically significant, likely due to small $n$)
  - $t(10) = -2.4, p = .06$
  - Ply: $\mu = 16.67, \sigma = 1.63$
  - CDT: $\mu = 24.83, \sigma = 8.08$
:::


## Study 2: Conceptual learning


::: framed
How does embedded guidance help novice developers learn new CSS concepts?
:::


## Setup

- $n = 5$ inexperienced users
- Pre- and post-tests
- Implicit dependencies and visual subtypes (see paper)

## Inspecting implicit dependencies

![Oscar](img/study2-oscar.png)

```css
.header {
  position: fixed;
  z-index: 30;
  left: 0;
  top: 0;
  width: 100%;
}
```

## Novices made sense of dependencies

- Before: 0 out of 5 identified dependency between `z-index` and `position`
- After: 5 out of 5

. . .

> Something about `z-index` would change as a result of `position` not being fixed. `position: fixed;` is doing something beyond pinning in place while you scroll


## Discussion

- Production webpages as authentic learning materials
- Inspection tools should use visual organizational principles


## More in the paper

- Background: sense-making, authentic learning
- System implementation
- Technique descriptions
- Visual subtypes
- Many more examples

