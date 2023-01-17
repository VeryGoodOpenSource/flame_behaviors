# Flame Behaviors

[![ci][ci_badge]][ci_link]
[![coverage][coverage_badge]][ci_link]
[![pub package][pub_badge]][pub_link]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]
[![Powered by Flame][flame_badge_link]]([flame_link])

Flame Behaviors applies separation of concerns to game logic in the form of Entities and Behaviors.

Developed with 💙 and 🔥 by [Very Good Ventures][very_good_ventures_link] 🦄

---

Flame Behaviors was created to make it easier to create scalable, testable games with a 
well-defined structure. It applies the
[separation of concerns][separation_of_concerns] to the game logic, in the form of 
[Entities](#entity) and [Behaviors](#behavior).

Imagine you want to build an old school [Pong game](https://en.wikipedia.org/wiki/Pong). At its 
very core there are two objects: a paddle and a ball. If you have a look at the paddle, you could say 
its game logic is: move up and move down. The ball has the simple game logic of: on collision with 
a paddle reverse the movement direction.

These objects, paddles and balls, are what we call entities and the game logics we just described 
are their behaviors. By applying these behaviors to each individual entity we get the core 
gameplay loop of Pong: hitting balls with our paddles until we win.

By defining what kind of entities our game has and describing what type of behaviors they may hold, 
we can easily turn a gameplay idea into a structured game that is both testable and scalable.

---

## Documentation 📝

View the full documentation [here](https://github.com/VeryGoodOpenSource/flame_behaviors/tree/main/docs).

## Packages 📦

| Package                                                                                           | Pub                                                                                                      |
| ------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| [flame_behaviors](https://github.com/verygoodopensource/flame_behaviors/tree/main/packages/flame_behaviors)         | [![pub package](https://img.shields.io/pub/v/flame_behaviors.svg)](https://pub.dev/packages/flame_behaviors)         |


## Quick Start 🚀

### Installing 🧑‍💻

In order to use Flame Behaviors you must have the [Flame package][flame_package_link] added to your project.

### Adding the package

```shell
# 📦 Add the flame_behaviors package from pub.dev to your project
flutter pub add flame_behaviors
```

## Creating Entities and Behaviors

Use Flame Behaviors to define your game entities and how they behave. Or follow 
the [Introduction to Flame Behaviors][flame_behaviors_article] article to learn how to use
the package!

[ci_badge]: https://github.com/VeryGoodOpenSource/flame_behaviors/workflows/flame_behaviors/badge.svg
[ci_link]: https://github.com/VeryGoodOpenSource/flame_behaviors/actions
[coverage_badge]: https://raw.githubusercontent.com/VeryGoodOpenSource/flame_behaviors/main/packages/flame_behaviors/coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[pub_badge]: https://img.shields.io/pub/v/flame_behaviors.svg
[pub_link]: https://pub.dartlang.org/packages/flame_behaviors
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_ventures_link]: https://verygood.ventures/?utm_source=github&utm_medium=banner&utm_campaign=CLI
[flame_link]: https://flame-engine.org
[flame_package_link]: https://pub.dev/packages/flame
[flame_badge_link]: https://img.shields.io/badge/Powered%20by-%F0%9F%94%A5-orange.svg
[separation_of_concerns]: https://en.wikipedia.org/wiki/Separation_of_concerns
[flame_behaviors_article]: https://verygood.ventures/blog/build-games-with-flame-behaviors