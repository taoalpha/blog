date: 2016-01-10 7:00:00
title: Scalable and Modular Architecture for CSS 
category: readings
description: Scalable and Modular Architecture for CSS
tags: [css,scalable,modular]
series: The way I learn CSS3
author: taoalpha
---

## Modularity of Web Dev
As your project becomes more complex, its more difficult to maintain the code, no matter what kind of language you are using. That’s why we use OOP for most of the projects, by doing that, it saves you a lot of time and energy. Since web development becomes more popular, more and more people start focusing on this area and come up with some fantastic ideas about how to apply modularity or OOP on web development.

We all know that a basic website would contains three basic parts: HTML/CSS/JS. HTML is in charge of the struture, the CSS will focus on the appearance, and JS will give your website more animation(now css can do that too) and interaction. Among all these three parts, HTML is the easiest one, there is not so many things to talk about except the semantic tag, H5..etc, if you want to improve the modularity, most times HTML is not what you care most. Instead, CSS and JS are your primary concern.

[Scalable and Modular Architecture for CSS](https://smacss.com/) is a nice book focus on applying modularity to CSS, and here is the notes I wrote down after I read it. About JS, we will talk about it later :) You can start with a nice and good coding style.

## Reading Notes
### Categories of Rules
Jonathan Snook groups CSS rules into five types of categories:

- Base: Base rules are the defaults. They are almost exclusively single ele- ment selectors but it could include attribute selectors, pseudo-class selectors, child selectors or sibling selectors. Essentially, a base style says that wherever this element is on the page, it should look like this;
  - You can use some reset frameworks out there, just be sure you know everything it does before you actually put it in your project;
- Layout: Layout rules divide the page into sections. Layouts hold one or more modules together;
  - Generally, a Layout style only has a single selector: a single ID or class name;
  - Sometimes, you may have different layouts base on different settings like user preference, then you can use more than one selectors;
- Modules: Modules are the reusable, modular parts of our design. They are the callouts, the sidebar sections, the product lists and so on;
  - Each Module should be designed to exist as a standalone component;
  - Avoid using IDs and ele- ment selectors, sticking only to class names;
  - Only include a selector that includes semantics. A span or div holds none. A heading has some. A class defined on an element has plenty;
  - If you do wish to use an element selector, it should be within one level of a class selector;
- State rules: State rules are ways to describe how our modules or layouts will look when in a particular state. Is it hidden or expanded? Is it ac- tive or inactive? They are about describing how a module or layout looks on screens that are smaller or bigger. They are also about de- scribing how a module might look in different views like the home page or the inside page;
  - A state is something that augments and overrides all other styles;
  - States should be made to stand alone and are usually built of a single class selector, sometimes you can use !important to address the state;
  - In a case where a state rule is made for a specific module, the state class name should include the module name in it;
- Theme rules: Theme rules are similar to state rules in that they describe how modules or layouts might look. Most sites don’t require a layer of theming but it is good to be aware of it;
  - Focus on general appearance of your website like colors, borders etc;

And also using proper name for different categories can be beneficial for immediately understanding which category a particular style belongs to and its role within the overall scope of the page. Here is a simple example:

``` css
/* Example Module */
.example { }
/* Callout Module */
.callout { }
/* Callout Module with State */
.callout.is-collapsed { }
/* Form field module */
.field { }
/* jsExample is a subclass or variation of example */
.example-jsExample { }
/* Inline layout  */
.l-inline { }
```

## Tips
- Minimizing the Depth: The depth of applicability is the number of generations that are affected by a given rule;
- Two Goals of SMACSS: Increase semantics and decrease reliance on specific HTML;
- How to separate the files in your project:
  - Place all Base rules into their own file;
  - Depending on the type of layouts you have, either place all of them into a single file or major layouts into separate files;
  - Put each module into its own file;
  - Depending on size of project, place sub-modules into their own file;
  - Place global states into their own file;
  - Place layout and module states, including media queries that affect those layouts and modules, into the module files;
- Organize styles in the following order:
  - Box: display, float, position, left, top, height, width…
  - Border: border;
  - Background: background;
  - Text: font-family, font-size, text-transform, letter-spacing…
  - Others: others;
- Be Consistent;

## Summary
This book is pretty short with all valueable content. Strongly recommend after you get familiar with all basic css concepts.

