---
title: Ply
subtitle: A Visual Web Inspector for Learning from Professional Webpages
author:
  - Sarah Lim, Josh Hibschman, Haoqi Zhang, Nell O'Rourke
  - Northwestern University
date: UIST 2018, Berlin

bibliography:
  - /Users/slim/Dropbox/Study/uist2018/talk/citations.bib
  - /Users/slim/Dropbox/Study/uist2018/talk/rale.bib
suppress-bibliography: true

theme: slim
slideNumber: true
height: 850
transition: none
---

## Modern web design is complex and hard to learn

![Source: Airbnb homepage](img/airbnb.png){.captioned}


:::notes
Modern webpages are complex, full-featured applications with really impressive designs, and there are a lot of people interested in learning to style these rich interfaces.

The nice thing about the Web is that even if I'm an inexperienced developer, it's really easy to stumble upon tons of interesting designs during my regular browsing sessions.
:::


## "How do I make a form like this?"

![Airbnb booking bar component](img/airbnb-bar.png)


:::notes
And so let's say I come across this example from the Airbnb homepage, and I'd like to replicate this booking form here.

Specifically, I want to create a form with each field in its own column.
:::


## Tutorials may be hard to find

![Source: Codrops.com](img/codrops-search.png){.captioned .shadowed}


:::notes
So one thing you can do is to search for tutorials on a websites like CSSTricks or Codrops.

But it's often difficult to specify exactly what aspect of the design you'd like a tutorial for.
:::


<!-- ## Jargon-heavy keywords -->

<!-- ![Codrops tutorial search](img/codrops-tutorials.png){.captioned.captioned-light} -->


<!-- ::: notes -->
<!-- On top of that, many tutorials use domain-specific keywords like "Material design" or "jump loader animation" that might not be familiar to novices. -->
<!-- ::: -->


## Tutorials aren't quite right

![Airbnb booking bar component](img/airbnb-bar.png)

vs.

![Source: [Codepen](https://codepen.io/andiio/pen/tFECp?editors=1100)](img/codepen.png){.shadowed .captioned}


:::notes
But the biggest problem is that tutorials are often _too simplistic_ and not exactly what we're looking for.

Here's a toy example that I found when searching for tutorials. You can see right away that it doesn't quite match the aesthetics of the original, which is dissatisfying.
:::


## Production webpages embed best practices


:::::: columns
::: {.column width=50% style="position: relative; top: 50%; left: 0; transform: translateY(25%);"}
![Tabular display](img/airbnb-bar.png){.captioned}


:::
::: {.column width=50%}

```css
.container {
  display: table;
}
```

:::
::::::


vs.


:::::: columns
::: {.column width=50% style="position: relative; top: 50%; left: 0;"}
![Floats](img/codepen-zoom.png){.captioned}


:::
::: {.column width=50%}

```css
.container {
  float: left;
}
```

:::
::::::


:::notes
But another problem is that tutorials often don't reflect up-to-date best practices.

The Airbnb example uses `display: table;` to achieve a tabular layout without using a semantically-incorrect `<table>` element.

The toy example uses floats and clearfix, which is a pretty outdated approach to layout.
:::


## Any webpage can be inspected...

![Inspecting the Airbnb homepage in CDT](img/airbnb-cdt.png)


:::notes
Now experts know this, so they often use the "Inspect Element" feature built into modern browser devtools to inspect the underlying implementation.

how other webpages implement effects using modern development best practices that tutorials don't always convey.
:::

## But tools are overwhelming for novices


:::::: annotated
![Focusing on Airbnb CSS](img/airbnb-cdt-only.png){.shadowed}


::: {.annotation .right .top style="width: 30%; height: 78%;"}
:::
::::::


:::notes
But lots of information, hard to understand what's going on
:::


## Contributions

- Needfinding: inspection pain points
- Ply: a visually-aware web inspector
- Two user studies
    - Users replicate CSS 50\% more quickly
    - Learn new concepts


:::notes
So to address these challenges, we make the following contributions:

- what exactly novices find challenging about inspecting production webpage CSS, and what that implies for the design of inspection tools
- I'll walk you through Ply, the tool we built to address these challenges
- and demonstrate how it helped novices replicate a complex design 50\% more quickly and learn new concepts
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


## Novices rely on [visual intuition]{style="color: #0079ff;"}, but existing inspection tools do not support reasoning visually about unfamiliar code.

. . .

In line with @Gross:2010:TTF:1937117.1937123, @JoelBrandt:2010ula, @Ko:2004td


::: notes
Our high-level finding was that novices rely heavily on their visual intuition to comprehend unfamiliar CSS, and struggle to relate visual outcomes to responsible lines of code.

This is consistent with prior work that end user programmers struggle to identify the lines of code responsible for graphical outputs of interest.

In particular, I want to talk about two core obstacles we identified in the context of CSS inspection.
:::


## Problem 1: Visually ineffective properties


## Effective properties

![Toggling properties with effects](img/effective-one.gif)


::: notes
So first, if you've used Chrome DevTools you probably know that you can click a property to toggle it on and off, live on the page.
:::


## Ineffective properties

![Toggling is a no-op](img/ineffective-all.gif){.captioned}


::: notes
The problem is that even though Chrome crosses off properties that it knows are inactive, there are _still_ properties left that can be toggled without changing the page's appearance.
:::


## Ineffective properties are common


:::::: columns
::: {.column .middle width=50%}
::: annotated
![✗ = ineffective](img/airbnb-cdt-css.png){.captioned}


::: {.annotation .filled style="width: 80%; height: 13%; top: 22%; left: 5%;"}
[✗]{style="position: absolute; top: 50%; right: 100%; transform: translate(-50%, -50%); color: red;"}
:::
::: {.annotation .filled style="width: 80%; height: 8%; top: 38%; left: 5%;"}
[✗]{style="position: absolute; top: 50%; right: 100%; transform: translate(-50%, -50%); color: red;"}
:::
::: {.annotation .filled style="width: 80%; height: 2%; top: 56%; left: 5%;"}
:::
::: {.annotation .filled style="width: 80%; height: 8%; top: 58.5%; left: 5%; background: rgba(0, 200, 100, 0.3);"}
[✓]{style="position: absolute; top: 50%; right: 100%; transform: translate(-50%, -50%); color: green;"}
:::
:::
:::


::: {.column .middle width=50%}
- Style guides, component libraries
- Responsive breakpoints (`@media` queries)
- Interaction states
:::
::::::


:::notes
This would be fine if it were only one or two, but tragically, there are a lot -- the red highlights are properties that are visually ineffective but appear relevant in Chrome -- and you can see that it's pushed the relevant properties in green to the bottom of the fold.

As we observed in needfinding, when relevant code was pushed below the fold, it was hard for novices to find

These properties exist for a few reasons. Production webpages often use styleguides

But even if you were to remove all the ineffective properties...
:::


## Problem 2: Missing conceptual knowledge

:::notes
But even if you removed these it's not enough -- we also found in needfinding that novices lacked conceptual knowledge that prevented them from making sense of unfamiliar example code.

In particular, novices struggled to understand how multiple properties work together to produce visual outcomes.

An example of this is implicit dependencies.
:::


## Implicit dependencies


:::::: columns

::: {.column style="width: 30%; transform: translateY(50%);"}
::: example-1
<h4 class="blue">Hello</h4>
<div class="red"></div>
<style type="text/css">
  .example-1 {
    position: relative;
  }

  .example-1 .blue {
    color: #0079ff;
    font-size: 2em;
    display: table;
  }
  
  .example-1 .red {
    width: 75px;
    height: 150px;
    background: #ff3d38;
  }
  
  .example-1 .red {
    position: absolute;
    left: 0;
    top: 0;
  }

  .example-1 .blue {
    z-index: 300;
  }
</style>
:::
:::

::: {.column width=50%}

```css
.blue {
  z-index: 300;
}
```

:::
::::::


. . .


:::::: columns

::: {.column style="width: 30%; transform: translateY(50%);"}
::: {.example-2 style="transform: translateZ(0);"}
<h4 class="blue">Hello</h4>
<div class="red"></div>
<style type="text/css">
  .example-2 {
    position: relative;
  }

  .example-2 .blue {
    color: #0079ff;
    font-size: 2em;
    display: table;
  }
  
  .example-2 .red {
    width: 75px;
    height: 150px;
    background: #ff3d38;
  }
  
  .example-2 .red {
    position: absolute;
    left: 0;
    top: 0;
  }

  .example-2 .blue {
    z-index: 300;
    position: relative;
  }
</style>
:::
:::

::: {.column width=50%}

```css
.blue {
  z-index: 300;
  position: relative;
}
```


:::

::::::


. . . 


::: framed
`z-index` depends upon `position`
:::






::: notes
one thing that people struggled with is understanding when multiple properties worked together to produce a visual effect

e.g. here a user

It might seem like these are independent properties, but alas
:::




## Designing a learner-friendly web inspector

1. [Hide visually-irrelevant code]{style="color: #0079ff;"} to minimize information overload and support novices' visual intuition

2. [Embed contextual guidance]{style="color: #0079ff;"} into inspector output to explain how properties coordinate

Building from @Quintana:2004bg


:::notes
So what we're seeing is that there's a gap between novices' approach to sense-making and how developer tools are currently designed.

Learning sciences

software can scaffold learners past these gaps.

So we build on their guidelines to propose new design guidelines for learner-friendly web inspectors.

---

1. **Hide visually-irrelevant code** from inspector output to minimize information overload and support novices' visual approach to sense-making

2. **Embed contextual guidance** into inspector output to explain how CSS properties coordinate to produce visual effects.

---

Their guidelines are:

1. Use representations and language that bridge learners' understanding (which in our case is visual intuition)

2. Embed expert guidance into the sense-making process to provide missing domain knowledge
:::


## Ply: a DOM and CSS inspector

![Ply teaser screenshot](img/ply/overview.png)


## 1. Pruning ineffective properties


:::::: columns
::: {.column width=50%}
![Before](img/ply/pruning-before.png){.captioned}


:::
::: {.column width=50%}
:::
::::::


## 1. Pruning ineffective properties


:::::: columns
::: {.column .annotated width=50%}
![Before](img/ply/pruning-before.png){.captioned}


::: {.annotation style="top: 50px; right: 3%; height: 35px; width: 20%;"}
:::
:::
::: {.column width=50%}
:::
::::::


## 1. Pruning ineffective properties


:::::: columns
::: {.column width=50%}
![Before](img/ply/pruning-before.png){.captioned style="opacity: 0.4;"}


:::
::: {.column width=50%}
![After](img/ply/pruning-after.png){.captioned}


:::
::::::



::: notes
When you click this Prune button, it greys out all the visually-ineffective properties.
:::


## 2. Computing dependencies

![Show dependencies](img/ply/deps-show.png){.shadowed}


## 2. Computing dependencies

![Hide dependencies](img/ply/deps-hide.png){.shadowed}


## 2. Computing dependencies

![Hover dependencies](img/ply/deps-hover.png){.shadowed}



## Visual subtypes


![Indiegogo](img/study2-indiegogo.png)
![Visual subtypes](img/ply/subtypes.png){.shadowed}

Using annotations to surface design patterns (see paper)


---



<video id="demo" controls muted src="img/ply/demo.mp4"></video>
<script type="text/javascript">
const demo = document.getElementById('demo');
demo.playbackRate = 1.5;
</script>


::: notes
Here's how it actually works in practice
:::

---

<h1 class="h2">Visual Relevance Testing</h1>

## Inspiration: Visual regression testing

1. Capture original screenshots
2. Make changes to codebase
3. Test for differences ([visual regressions]{style="color: #ff3d38;"}) in output 


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

A property is **visually effective** if and only if its deletion causes a [regression]{style="color: #ff3d38;"}


::: notes
Building on the concept of regressions
:::

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


::: framed
$\implies \quad$ `display: block;` is **ineffective**
:::


## Dependency satisfied

![Dependency satisfied](img/deps-satisfied.gif)


## Dependency missing

![Dependency missing](img/deps-missing.gif)



::: notes
This seems like simple visual comparisons, but it allows us to help a novice understand the example by surfacing the conceptual knowledge about relationships between properties that they didn't know beforehand.
:::

---

<h2 class="h1">Evaluation</h2>


::: notes
So now I will share how well this works.
:::

---

## Study 1: Replication speed


::: framed
Does pruning ineffective properties help developers replicate features more quickly?
:::

## Setup

- $n = 12$, between-subjects, CDT as control
- 40 minutes, three milestones

![Ideo](img/ideo-browser.png)

## Learners were faster with Ply

- 50\% faster overall (n.s., $p = .06$)
- 3.5 times faster to first milestone ($p = .01$)
    - 2.5 vs. 8.9 minutes

![Milestones](img/milestones.png)


::: notes
Meaningful differences for novices

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


![Oscar](img/study2-oscar.png)


::: notes
Following standard measures of learning gain, we asked participants to perform a similar task before and after performing the intervention so we could track the change in their understanding.
:::


## Novices could identify dependencies

```css
.header {
  position: fixed;
  z-index: 300;
}
```

- Before: **0 out of 5** identified dependency between `z-index` and `position`
- After: **5 out of 5**


---

> "Something about `z-index` would change as a result of `position` not being fixed. `position: fixed;` is **doing something beyond pinning in place** while you scroll."


::: notes
TODO: What's more exciting is that they could explain why this was happening
:::


## Takeaways

- Production webpages can support **authentic learning**

- CSS is nontrivial to understand -- need **semantic tools** that support **visual intuition**


::: {.framed}
Learner-centered developer tools
:::


## Ply: Visual Web Inspection


- <slim@sarahlim.com>
- [\@sliminality](http://twitter.com/sliminality)
- <http://github.com/sliminality/ply>


![](img/ply/end.png){style="width: 70%; margin-bottom: 30px;"}


![NSF](img/nsf.png){style="width: 150px; position: absolute; bottom: 0; left: 0; transform: translate(25%, 25%);"}
![Delta](img/delta_logo.png){style="width: 250px;position: absolute; bottom: 0; left: 50%; transform: translate(-50%, -25%);"}
![Northwestern](img/nu-eecs.png){style="width: 250px; position: absolute; bottom: 0; right: 0;"}

