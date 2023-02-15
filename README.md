<div align="center">

# Navigation Menu in `Flutter` Demo

A simple showcase of
building a navigation menu in `Flutter`.

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/dwyl/flutter-navigation-menu-demo/ci.yml?label=build&style=flat-square&branch=main)
[![HitCount](https://hits.dwyl.com/dwyl/flutter-navigation-menu-demo.svg?style=flat-square&show=unique)](http://hits.dwyl.com/dwyl/flutter-navigation-menu-demo)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/flutter-navigation-menu-demo/issues)


</div>

- [Navigation Menu in `Flutter` Demo](#navigation-menu-in-flutter-demo)
- [Why? 🤷‍](#why-)
- [What? 💭](#what-)
- [Who? 👤](#who-)
- [_How_? 👩‍💻](#how-)
  - [Prerequisites? 📝](#prerequisites-)
  - [What we are building 🧱](#what-we-are-building-)
  - [1. Customizing the `AppBar`](#1-customizing-the-appbar)
  - [2. Changing the `HomePage` page](#2-changing-the-homepage-page)


<br />

# Why? 🤷‍

This small demo is meant for *anyone*
who wants to see a quick implementation
of [**progressive UX/UI**](https://github.com/dwyl/product-roadmap/issues/43).

# What? 💭

We want to add an easy onboarding experience
for users when they start using our 
[`app`](https://github.com/dwyl/app).

As we are using `Flutter` to develop our app,
this demo will focus on a `Dart` implementation of this,
focussing on the navigation menu component.


# Who? 👤

This quick demo is aimed at people in the @dwyl team
who need to understand how to create 
a basic app navigation that is *progressive*.

# _How_? 👩‍💻

## Prerequisites? 📝

This `demo` assumes you have foundational knowledge
of `Flutter`.

If this is your first time using `Flutter`,
we highly suggest you check out
[`dwyl/learn-flutter`](https://github.com/dwyl/learn-flutter)
for a *primer* on how to get up-and-running with `Flutter`.

This demo assumes you have already 
have created a new project
(we've called our application `"app"`)
and are ready to roll!

If you're not sure how to setup 
a new `Flutter` project, 
please visit:
https://github.com/dwyl/learn-flutter#0-setting-up-a-new-project.

To run on a real device, check
https://github.com/dwyl/flutter-stopwatch-tutorial#running-on-a-real-device.

To run on a simulator, check
https://github.com/dwyl/learn-flutter#0-setting-up-a-new-project.

##  What we are building 🧱

The purpose of this demo stems
from the discussion for developing
a basic app navigation 
held in https://github.com/dwyl/app/issues/305.

Long story short, 
we want to make a simple navigation menu
that is opened whenever an action occurs - 
in our specific case, 
checking a `Todo` item as *complete*.

The design we're doing should 
look like the following. 

<p float="center">
  <img src="https://user-images.githubusercontent.com/17494745/219090790-e725f425-b159-4d1a-bdee-9d71c642f3b4.png" width="300" />
  <img src="https://user-images.githubusercontent.com/17494745/219090919-d5789cf0-f189-4dce-9e29-12bc1d46b67f.png" width="300" /> 
</p>

We will focus on implementing the
**navigation bar**, 
so our main page won't look quite similar.

Regardless, the following constraints ought to be considered:
- we will adopt a 
[**Progressive UI**](https://github.com/dwyl/product-roadmap/issues/43)
approach,
where the user will only
be shown the option to open the menu
*after doing a specific action*
(in this case, completing a simple
`todo` task).
- the menu ought to be
**full-screen**, 
making it *distraction-free*.
- the text within the menu
should [constrast](https://codelabs.developers.google.com/color-contrast-accessibility)
the background properly.

Now that we know what we want,
let's roll 🍣!

## 1. Customizing the `AppBar`

Let's start by customizing the `AppBar`
with an **avatar** and the 
**DWYL logo**.

Assuming you've already setup the project,
go to `lib/main.dart` 
and rename the following classes.
- `MyHomePage` to `HomePage`.
- `MyApp` to `App`.

This is to be consistent with other
classes that we will create further on.

By looking at the wireframes,
we know we need to add the avatar and logo
to the `AppBar`.
We are going to be opting 
by adding the images **locally**.

Let's create a folder in the root directory
called `assets`.
Inside `assets`, 
create *another* folder called `images`.
Create two images:
- `avatar.jpeg`, with any avatar you want.
- `dwyl_logo.png`,
the `dwyl` logo 
that can be found in 
[`assets/images/dwyl_logo.png`](./assets/images/dwyl_logo.png)
of this repo.

Next, in `pubspec.yaml`,
locate the `flutter` section
and *add the path to the folder of images*
under a new section called `assets`, 
like so:

```yaml
flutter:

  uses-material-design: true

  # Add these two lines
  assets:
    - assets/images/
```

We are now ready to use local images! 🍱

In the `build()` function
of the `_HomePageStateClass`,
locate the `appbar` attribute
of the `Scaffold`
and use the code:

```dart
appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/dwyl_logo.png", fit: BoxFit.fitHeight, height: 30),
          ],
        ),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/avatar.jpeg"),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ],
      )
```

The 
[`AppBar`](https://api.flutter.dev/flutter/material/AppBar-class.html)
consists of several components.
The one's we're going to be using
are `leading`, `title` and `actions`.

![appbar_components](https://user-images.githubusercontent.com/17494745/219113336-4a18fb4d-00f9-47e5-a1ad-4aa356cdc59d.png)

In the `title` component
(which is in the middle),
we added the *dwyl logo*,
by calling the function
[`Image.asset()`](https://api.flutter.dev/flutter/widgets/Image/Image.asset.html)
and passing the path to the `dwyl_logo.png` file
we defined earlier.
**Do notice we are *containing* the image using `BoxFit`**.
The image is inside a `Row`
that spans the whole space,
centering the `Image` in the middle.

In the `leading` component,
we are using 
[`CircleAvatar`](https://api.flutter.dev/flutter/material/CircleAvatar-class.html)
to add a circular image.
We've used `AssetImage`
to import the image, 
just to showcase another way of importing images locally.
`AssetImage` doesn't allow you to scale
the image like `Image.asset()` does,
but for this scenario *is enough*
because we don't need to.

In the `actions` component,
we can pass 
[**an array of actions**](https://api.flutter.dev/flutter/material/AppBar/actions.html),
which is a list of widgets to display in a row
*after* the title widget - typically `IconButtons`,
which is the case here. 
We've added a simple white one
with an `Icon.menu`.

> **Note**
> You may use [`NetworkImage`](https://api.flutter.dev/flutter/painting/NetworkImage-class.html)
> if you prefer to load images from the internet, instead of locally.

If you run your application,
you should be able to see the following screen.

<img width="427" alt="customized_appbar" src="https://user-images.githubusercontent.com/17494745/219115697-7b3b5c1c-480d-4767-b48a-e993d2a6e780.png">

Your `main.dart` file should look like this.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/dwyl_logo.png", fit: BoxFit.fitHeight, height: 30),
          ],
        ),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/avatar.jpeg"),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

## 2. Changing the `HomePage` page 

According to the wireframes we saw earlier,
we don't want a counter app,
nor will we implement a full `todo` app in this demo 
(it's out of its scope).
*However*,
we can make it *simpler*
and have a simple `todo item` 
to **enable menu navigation**, 
as per our `Progressive UI` requirement.

Let's delete the `_incrementCounter()` function
and `_counter` variable
inside `_HomePageState`
and the `floatingActionButton` attribute
in the `Scaffold` of the `build()` function.

After this,
we are going to be adding
a `showMenu` variable in `_HomePageState`,
a flag that will let us know if we should show 
the option for the user to open the menu.

```dart
class _HomePageState extends State<HomePage> {
  bool showMenu = false;
```

Next up,
we are going to be wrapping
the `IconButton` of the menu
with a 
[`Visibility`](https://api.flutter.dev/flutter/widgets/Visibility-class.html)
widget.

This will allow us to dynamically hide the icon
*while maintaining the width*,
so the `AppBar` stays consistent.
If we had removed the `IconButton` instead,
the `title` component would fill the remaining space,
**which is not what we want** ❌.

![visibility](https://user-images.githubusercontent.com/17494745/219121893-8648f7b8-cecb-4ffc-85fb-3927a3d0dd0d.png)

The `actions` component
of the `appbar` attribute
in the `Scaffold` of the `build()` function
inside `_HomePageState` should look like this:

```dart
    actions: [
        Visibility(
        maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: showMenu,
        child: IconButton(
            onPressed: () {},
            icon: const Icon(
            Icons.menu,
            color: Colors.white,
            ),
        ),
        ),
    ],
```

Now we can change our `_HomePageState` `body`
with a simple `todo` item
that will *toggle* this `menu` button.

In the `Scaffold`
and `body` attribute,
change it to the following.

```dart
    body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const Text(
                "This is the main page",
                style: TextStyle(fontSize: 30),
            ),
            const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                "Check the todo item below to open the menu above to check more pages.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
            ),
            ListTile(
                title: Text(
                'check this todo item',
                style: TextStyle(decoration: showMenu ? TextDecoration.lineThrough : TextDecoration.none),
                ),
                minVerticalPadding: 25.0,
                tileColor: Colors.black12,
                onTap: () {
                setState(() {
                    showMenu = true;
                });
                },
            )
            ],
        ),
    ),
```

We've added some `Text`,
and a `ListTile` that,
when pressed,
**toggles** the `IconButton` to be shown.

If you run the application
and *click the `todo` item*,
the menu icon should be toggled on.

![toggle](https://user-images.githubusercontent.com/17494745/219124646-93c6dfff-c62f-44e3-9441-d7b3e4bb824f.gif)

Your `_HomePageState` class 
now looks like this.

```dart
class _HomePageState extends State<HomePage> {
  bool showMenu = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/dwyl_logo.png", fit: BoxFit.fitHeight, height: 30),
          ],
        ),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/avatar.jpeg"),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0.0,
        actions: [
          Visibility(
            maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: showMenu,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "This is the main page",
                  style: TextStyle(fontSize: 30),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Check the todo item below to open the menu above to check more pages.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                ),
                ListTile(
                  title: Text(
                    'check this todo item',
                    style: TextStyle(decoration: showMenu ? TextDecoration.lineThrough : TextDecoration.none),
                  ),
                  minVerticalPadding: 25.0,
                  tileColor: Colors.black12,
                  onTap: () {
                    setState(() {
                      showMenu = true;
                    });
                  },
                )
              ],
            ),
          ),
    );
  }
}
```

We've now got the home page sorted
and the *progressive UI* requirement
knocked out of the park!

However, we're not done!
In fact, we need to get into 
the bread and butter of this demo:
**implementing the navigation menu**.

Let's do it!



- colocar duas  hipoteses
- o que esta atualmente está sem persistir a appbar. Para persistir, teria-se de usar named routes 