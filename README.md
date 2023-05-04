<div align="center">

# Navigation Menu in `Flutter` Demo

A simple showcase of
building a navigation menu in `Flutter`.

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/dwyl/flutter-navigation-menu-demo/ci.yml?label=build&style=flat-square)
[![HitCount](https://hits.dwyl.com/dwyl/flutter-navigation-menu-demo.svg?style=flat-square&show=unique)](http://hits.dwyl.com/dwyl/flutter-navigation-menu-demo)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/flutter-navigation-menu-demo/issues)


</div>

- [Navigation Menu in `Flutter` Demo](#navigation-menu-in-flutter-demo)
- [Why? 🤷‍](#why-)
- [What? 💭](#what-)
- [Who? 👤](#who-)
- [_How_? 👩‍💻](#how-)
  - [Prerequisites? 📝](#prerequisites-)
  - [Run it! 🏃‍♂️](#run-it-️)
  - [What we are building 🧱](#what-we-are-building-)
  - [1. Customizing the `AppBar`](#1-customizing-the-appbar)
  - [2. Changing the `HomePage` page](#2-changing-the-homepage-page)
  - [3. Creating pages to navigate to](#3-creating-pages-to-navigate-to)
  - [4. Adding the navigation menu](#4-adding-the-navigation-menu)
  - [4.1 Using the `drawer` attribute in `Scaffold`](#41-using-the-drawer-attribute-in-scaffold)
    - [4.1.1 Creating menu](#411-creating-menu)
    - [4.1.2 Run it!](#412-run-it)
  - [4.2 Slider menu with animation](#42-slider-menu-with-animation)
    - [4.2.1 Simplify `HomePage` and `App` class](#421-simplify-homepage-and-app-class)
    - [4.2.2 Creating `AnimationController`](#422-creating-animationcontroller)
    - [4.2.3 Making our animations *work* with `AnimatedBuilder`](#423-making-our-animations-work-with-animatedbuilder)
    - [4.2.4 Creating `SlidingMenu`](#424-creating-slidingmenu)
    - [4.2.5 Run the app!](#425-run-the-app)
  - [5. Adding a dynamic section to the menu](#5-adding-a-dynamic-section-to-the-menu)
    - [5.1 How the `JSON` will look like](#51-how-the-json-will-look-like)
    - [5.2 Dealing with information from the `JSON` file](#52-dealing-with-information-from-the-json-file)
    - [5.2.1 `MenuItemInfo` class](#521-menuiteminfo-class)
    - [5.2.2 Loading menu items from `JSON` file/local storage](#522-loading-menu-items-from-json-filelocal-storage)
    - [5.2.3 Updating menu items](#523-updating-menu-items)
    - [5.2.4 Updating menu items](#524-updating-menu-items)
- [Star the repo! ⭐️](#star-the-repo-️)


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


## Run it! 🏃‍♂️

We assume you've cloned this project,
since you seem to want to run it 😉.

To run on a real device, check
https://github.com/dwyl/flutter-stopwatch-tutorial#running-on-a-real-device.

To run on a simulator, check
https://github.com/dwyl/learn-flutter#0-setting-up-a-new-project.

You can run this app 
and check *two different approaches*
to implementing a navigation menu.
To check both of them,
all you have to do is
head over to `main.dart`
and change the following line.

```dart 
void main() {
  runApp(const App());
}
```

By default, the app will run with the 
**Drawer Menu**.
If you want to check the **Sliding Menu**,
you simply change this line to.


```dart 
import 'package:app/sliding_main.dart';

void main() {
  runApp(const SlidingApp());
}
```

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
we've added the *dwyl logo*,
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
*to the right* the title widget - typically `IconButtons`,
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

## 3. Creating pages to navigate to 

In the wireframe, 
the menu currently has three items
that the user can click
to navigate into the referring page:
- the **Todo List**
- the **Feature Tour** page
- the **Settings** page

Let's create two simple pages
that will represent the last two.

Create a new file
in `lib/` called `pages.dart`
add the following two classes
at the end of the file.
Each class will represent each page.

```dart
import 'package:flutter/material.dart';

class TourPage extends StatelessWidget {
  const TourPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "This is the Tour page 🚩",
              style: TextStyle(fontSize: 30),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "As you can say, this is just a sample page. You can go back by pressing the button below.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "This is the Settings page ⚙️",
              style: TextStyle(fontSize: 30),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "As you can say, this is just a sample page. You can go back by pressing the button below.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back'),
            ),
          ],
        ),
      ),
    );
  }
}
```

Both pages are very similar.
They have some text
and a button that will allow the user
to **navigate back**. 

These pages will be later used
to implement 
*the navigation menu*.

Both pages are similar and should look like this.

<img width="300" alt="image" src="https://user-images.githubusercontent.com/17494745/219383553-8d7e5a75-3c13-43b6-9221-9b932a5528d8.png">

Speaking of which,
it's time to go over that! ✍️


## 4. Adding the navigation menu

For this demo, 
we are going to be over
**two different ways** of 
doing a navigation menu.
Both of these options will start 
from the code we left earlier.

Let's go! 🏃‍♂️

## 4.1 Using the `drawer` attribute in `Scaffold`

Creating a 
[**navigation drawer**](https://m3.material.io/components/navigation-drawer/overview)
in `Flutter` is remarkably simple.

Head over to `lib/main.dart`,
locate the `_HomePageState` class.
We are going to be adding a 
[`GlobalKey`](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html),
which will be used to identify the `Scaffold` in the entire app,
but most specifically to be used
to close the drawer we're implementing *programatically*.

In `_HomePageState`,
add the following line.

```dart
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
```

In the `build()` function, 
add this key to the 
`key` attribute of `Scaffold`.

```dart
    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: false,
```

We've also disabled `drawerEnableOpenDragGesture`,
so the `Drawer` isn't opened with the right-to-left gesture,
so the user *has* to click the button to open the menu.

In the `IconButton`, 
in the `actions` attribute of the `Scaffold`,
we can change the `onPressed` function
to the following.

```dart
child: IconButton(
    onPressed: () {
    _scaffoldKey.currentState!.openEndDrawer();
    },
    icon: const Icon(
    Icons.menu,
    color: Colors.white,
    ),
),
```

We are calling the `openEndDrawer()`,
which will make the drawer appear on screen.

Speaking of which, let's add it!
In the `Scaffold` widget,
add the following line:

```dart
endDrawer: SizedBox(width: MediaQuery.of(context).size.width * 1.0, child: const Drawer(child: DrawerMenu())),
```

We are using the `endDrawer`
attribute instead of `drawer`
because we want the drawer to 
go from **right-to-left**, 
not the other way around,
which is what `drawer` does.

### 4.1.1 Creating menu

In the previous section
we've used `DrawerMenu()`, 
which is not implemented.

Let's do it right now!
Inside `lib`,
create a file called `menu.dart`
and use the code shown below:

```dart
import 'package:flutter/material.dart';

import 'main.dart';
import 'pages.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/dwyl_logo.png", fit: BoxFit.fitHeight, height: 30),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.menu_open,
                color: Colors.white,
              ),
            ),
          ]),
      body: Container(
          color: Colors.black,
          child: ListView(padding: const EdgeInsets.only(top: 32), children: [
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white), top: BorderSide(color: Colors.white))),
              child: const ListTile(
                leading: Icon(
                  Icons.check_outlined,
                  color: Colors.white,
                  size: 50,
                ),
                title: Text('Todo List (Personal)',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100),
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
              child: ListTile(
                leading: const Icon(
                  Icons.flag_outlined,
                  color: Colors.white,
                  size: 40,
                ),
                title: const Text('Feature Tour',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TourPage()),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
              child: ListTile(
                leading: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 40,
                ),
                title: const Text('Settings',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsPage()),
                  );
                },
              ),
            ),
          ])),
    );
  }
}
```

The menu is essentially consisted of an 
`AppBar` and `ListView`,
with many `ListTile` children,
each one pertaining to the different page
the user can navigate into.

The `AppBar` is similar to the one
found in the `_HomePageState` class.

Each `ListTile` is wrapped in a `Container` class
with proper spacing to better resemble
the wireframes detailed in the beginning of this document.

Each item uses a `Navigator.push()` function
to navigate to the pages
defined in `lib/pages.dart`.

### 4.1.2 Run it!

And that's it!
Wasn't it easy?

If you run the app in an emulator or device,
you will see something similar
to what's shown in the gif below.

![drawer_final](https://user-images.githubusercontent.com/17494745/219406889-33e7704e-a9e4-44d0-86e3-c1c8cd624a88.gif)


## 4.2 Slider menu with animation

Let's, for a minute,
assume that you prefer
having the `Drawer`
show up **below the `AppBar`.

There are a couple of ways 
you could do this.
- you could add a `Padding` to the drawer.
This *works* but it's "*hacky*" and dirty. 
Additionally, 
this value would have to be updated
if the `AppBar` height changed, becoming
[coupled](https://www.geeksforgeeks.org/software-engineering-coupling-and-cohesion/).

```dart
drawer: Padding(
    padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
    child: Drawer(),
```

- you could wrap your main `Scaffold`
in *another* `Scaffold`,
and use the `Drawer` of 
the *child `Scaffold`.
This, however
is **not recommended**,
[as it can cause unnecessary behaviour](https://github.com/flutter/flutter/issues/20289).

```dart
return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text("Parent Scaffold"),
        automaticallyImplyLeading: false,
      ),
      body: Scaffold(
        drawer: Drawer(),
      ),
    );
```

Since both of these scenarios are not *ideal*,
we ought to implement this another way.
We are going to build our own drawer menu
that is animated,
with all the links that are defined in the wireframe.

Let's go over each step to get this working!

### 4.2.1 Simplify `HomePage` and `App` class

Let's start by simplifying the `HomePage`
and `App` class.
We don't really need the `title` variable
that was boilerplated when we first created the application.

Change these two classes 
so they look like this.

```dart
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Navigation Flutter Menu App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
```

### 4.2.2 Creating `AnimationController`

We are going to be creating an 
[`AnimationController`](https://api.flutter.dev/flutter/animation/AnimationController-class.html)
to play the animation in forward,
reverse and know its progress systematically.
 
With this in mind, let's create our `AnimationController`!
In `_HomePageState`, 
add the following code:

```dart
  late AnimationController _menuSlideController;

  @override
  void initState() {
    super.initState();

    _menuSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _menuSlideController.dispose();
    super.dispose();
  }

  /* ------- Animation builder functions ------- */
  bool _isMenuOpen() {
    return _menuSlideController.value == 1.0;
  }

  bool _isMenuOpening() {
    return _menuSlideController.status == AnimationStatus.forward;
  }

  bool _isMenuClosed() {
    return _menuSlideController.value == 0.0;
  }

  void _toggleMenu() {
    if (_isMenuOpen() || _isMenuOpening()) {
      _menuSlideController.reverse();
    } else {
      _menuSlideController.forward();
    }
  }
```

When `HomePageState` is instanciated,
`initState()` is called,
and sets up `_menuSliderController` - 
our `AnimationController`! 🎉

The [`dispose()`](https://api.flutter.dev/flutter/widgets/State/dispose.html)
method is called when the object 
is removed from the tree permanently.
We are disposing our `_menuSliderController` here
to avoid any unexpected behaviour.

In addition to this, 
we are create functions
to toggle open the menu
and knowing the status of the animation in real-time.
We are accessing the 
[`status`](https://api.flutter.dev/flutter/animation/AnimationController/status.html)
and [`value`](https://api.flutter.dev/flutter/animation/AnimationController/value.html)
properties for this.

> **Warning** 
> You might notice an error pop up in your IDE stating
> `The argument type '_HomePageState' can't be assigned to the parameter type 'TickerProvider'`.
> This is because we need to pass a `vsync` argument
> when creating an `AnimatedController` object.
> The presence of `vsync` prevents offscreen animations
> from consuming unnecessary resources.
>
> To fix this, 
> we need to *extend* the class by adding the `SingleTickerProviderStateMixin` mixin.
> Change the class definition so it looks like the following:
> `class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin`.
>
> For more information,
> check https://docs.flutter.dev/development/ui/animations/tutorial#animationcontroller.


### 4.2.3 Making our animations *work* with `AnimatedBuilder`

Now that we have our own `AnimatedController`,
we are ready to *use it*!
For this,
we are going to be using the
[`AnimatedBuilder`](https://api.flutter.dev/flutter/widgets/AnimatedBuilder-class.html) class.

We are going to be using 
`AnimatedBuilder` in two distinct places
inside `_HomePageState`:
- on the `IconButton` in the `AppBar`,
to toggle the animation on and off.
- on the `body` of the `Scaffold`,
to create a sliding animation from right to left. 

Let's start with `AppBar`.
Locate it, check for the `actions` attribute
and change it to the following piece of code:

```dart
    actions: [
        AnimatedBuilder(
        animation: _menuSlideController,
        builder: (context, child) {
            return Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: showMenu,
            child: IconButton(
                onPressed: _toggleMenu,
                icon: _isMenuOpen() || _isMenuOpening()
                    ? const Icon(
                        Icons.menu_open,
                        color: Colors.white,
                    )
                    : const Icon(
                        Icons.menu,
                        color: Colors.white,
                    ),
            ),
            );
        },
        ),
    ],
```

We have *wrapped* the `IconButton`
(which was previously wrapped with the `Visibility` class)
with `AnimatedBuilder`, using the `_menuSliderController` we created earlier.
When the `IconButton` is pressed, 
we call `_toggleMenu`.
We also change the icon according
to the status of the menu,
whether it is opened or not!

Pretty simple, right?

Now let's go over the second change we ought to make.
Inside the `Scaffold`,
lcoate the `body` attribute
and change it to the following:

```dart
body: Stack(
        children: [
          Center(
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
          AnimatedBuilder(
            animation: _menuSlideController,
            builder: (context, child) {
              return FractionalTranslation(
                translation: Offset(1.0 - _menuSlideController.value, 0.0),
                child: _isMenuClosed() ? const SizedBox() : const SlidingMenu(),
              );
            },
          ),
        ],
      ),
```

We have *wrapped* `Center`
with a 
[`Stack`](https://api.flutter.dev/flutter/widgets/Stack-class.html),
which is extremely useful to overlap children
in a simple way.
Which is exactly what we want!

We've added an `AnimatedBuilder`
as the *second child*
which uses 
[`FractionalTranslation`](https://api.flutter.dev/flutter/widgets/FractionalTranslation-class.html)
to create a translation from right to left.

In here, 
we are translating a `SlidingMenu()`,
which we have not created.
Let's do that!

### 4.2.4 Creating `SlidingMenu`

Let's create a new file
in `lib`
and name it `sliding_menu.dart`.

```dart
import 'package:flutter/material.dart';

import 'pages.dart';

class SlidingMenu extends StatelessWidget {
  const SlidingMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: ListView(padding: const EdgeInsets.only(top: 32), children: [
          Container(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white), top: BorderSide(color: Colors.white))),
            child: ListTile(
              leading: const Icon(
                Icons.check_outlined,
                color: Colors.white,
                size: 50,
              ),
              title: const Text('Todo List (Personal)',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  )),
              onTap: () {
                // Do nothing
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 100),
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
            child: ListTile(
              leading: const Icon(
                Icons.flag_outlined,
                color: Colors.white,
                size: 40,
              ),
              title: const Text('Feature Tour',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  )),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TourPage()),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
            child: ListTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 40,
              ),
              title: const Text('Settings',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  )),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ),
        ]));
  }
}
```

We are creating a `StatelessWidget`
that will be our menu.
Our menu is a `ListView`
with `ListTile`s as children.
Each `ListTile` is wrapped with a `Container`
to provide the proper spacing 
in-between the items 
so they resemble the wireframe design more closely.

Now you can simply import this new menu
in the `lib/main.dart` file.

```dart
import 'sliding_menu.dart';
```

And we're done!

### 4.2.5 Run the app!

Now that we've created everything we need,
let's test it out and see if it in action!
Run the application 
and you should see the following result!

![final_sliding](https://user-images.githubusercontent.com/17494745/219359834-a4f7962b-9300-4b91-9f62-60d9d51952ab.gif)


## 5. Adding a dynamic section to the menu

You now have working menu!
But what if we want to make it **dynamic**
by reading contents from a `JSON` file
and persisting it on local storage?

This is what we are going to be focusing on 
for the next sections.

Before this,
let's make some preparations:

- let's move the `sliding_main.dart` and `sliding_menu.dart`
files to a folder called `alt`. 
This folder is localed in `lib`, making it `lib/alt`.
We're doing this because we are going to be using
the `Drawer` menu, so we'll just tidy up our workspace.

- make sure that in your `main.dart`,
you're calling the app like so.

```dart
void main() {
  runApp(const App());
}
```

- install the 
[`shared_preferences`](https://pub.dev/packages/shared_preferences) package.
This will make it easy for us to save
stuff in the device's local storage!

- open `pubspec.yaml` 
and add `- assets/` to the `assets:` section.

```yml
  assets:
    - assets/images/
    - assets/
```

And now you're ready!

### 5.1 How the `JSON` will look like

Let's start with an initial view 
of how the `JSON` file will look like.
We are assuming we are going to have 
**nested menus up to 3 levels deep**.
For each `Menu Item` we will need:
- a `title`.
- an `id`.
- a field `index_in_level` 
referring to the index of the menu item within the level.
- a `tiles` field,
pertaining to the child `menu items`/`tiles` of it.

If you want to see how the file should look like,
do check [`assets/menu_items.json`](https://github.com/dwyl/flutter-navigation-menu-demo/blob/3cb94b701377889cc7243a0aba9b4facf67314ab/assets/menu_items.json).


### 5.2 Dealing with information from the `JSON` file

Let's create a file called `settings.dart` inside `lib`.
In this file we will create functions
that will load the information from the `JSON` file,
save it in the device's local storage 
and update it accordingly.

### 5.2.1 `MenuItemInfo` class

In this file we will create a class called `MenuItemInfo`.
This is the class that will represent
each menu item that is loaded from the `JSON` file.

Open `lib/settings.dart`
and add the following code to it.

```dart
/// Class holding the information of the tile
class MenuItemInfo {
  late int id;
  late int indexInLevel;
  late String title;
  late List<MenuItemInfo> tiles;

  MenuItemInfo({required this.id, required this.title, this.tiles = const []});

  /// Converts `json` text to BasicTile
  MenuItemInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    indexInLevel = json['index_in_level'];
    title = json['title'];
    if (json['tiles'] != null) {
      tiles = [];
      json['tiles'].forEach((v) {
        tiles.add(MenuItemInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['index_in_level'] = indexInLevel;
    data['title'] = title;
    if (tiles.isNotEmpty) {
      data['tiles'] = tiles.map((v) => v.toJson()).toList();
    } else {
      data['tiles'] = [];
    }
    return data;
  }
}
```

We are creating a class field
for each key of the object within the `JSON` file.
The functions `fromJson` and `toJson`
convert the information from the `JSON` file
into a `MenuItemInfo` and decode into a `json` string,
respectively. 

Awesome! 🎉


### 5.2.2 Loading menu items from `JSON` file/local storage

Now that we have our own class,
let's create a function to load these menu items
from the file!

In the same `settings.dart` file,
create the following function.

```dart
const jsonFilePath = 'assets/menu_items.json';
const storageKey = 'menuItems';

Future<List<MenuItemInfo>> loadMenuItems() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final String? jsonStringFromLocalStorage = prefs.getString(storageKey);

  String jsonString;
  // If local storage has content, return it.
  if (jsonStringFromLocalStorage != null) {
    jsonString = jsonStringFromLocalStorage;
  }

  // If not, we initialize it
  else {
    // Setting local storage key with json string from file
    final String jsonStringFromFile = await rootBundle.loadString(jsonFilePath);
    prefs.setString(storageKey, jsonStringFromFile);

    jsonString = jsonStringFromFile;
  }

  // Converting json to list of MenuItemInfo objects
  List<dynamic> data = await json.decode(jsonString);
  final List<MenuItemInfo> menuItems = data.map((obj) => MenuItemInfo.fromJson(obj)).toList();

  // Return the MenuItemInfo list
  return menuItems;
}
```

In our application,
we will persist the `JSON` file string
into the device's local storage 
and update it accordingly.
With this in mind,
in the beginning of this function
we check if there is any 
`json` string in the device's local storage.

If **the `json` string is saved into our local storage**,
we simply use it to later decode it
into a list of `MenuItemInfo` (class we've created previously).
If **the `json` string is not saved into our local storage**,
we fetch it from the `assets/menu_items.json` file
and then later decode it in a similar fashion.

This function returns 
a list of `MenuItemInfo`.


### 5.2.3 Updating menu items

If the user wants to reorder the menu items,
we need to update these changes into our local storage
so it's always up-to-date and reflects the true state
of the list of menu items.

When a user reorders a menu item in any level except the root,
we update the `tiles` list field (which pertains to the children menu items)
of the parent.

> **Note**
>
> Reordering *root menu items* is much easier
> because we don't need to traverse the tree of menu items.
> We just need to update the indexes of each men item on root level.

![update_example](https://user-images.githubusercontent.com/17494745/236282208-2160b55f-947f-4e03-80b4-3cbba4c02a14.png)

Since we are importing information from the `JSON` file,
we don't know upfront how many levels the nested menu has.
Therefore,
we need a way to **traverse it**.

According to the image,
we traverse the tree of menu items 
until we find the menu item with the given `id`.
After the menu item is found, 
we update its children with the reordered list.

Let's create a 
[recursive](https://en.wikipedia.org/wiki/Recursion_(computer_science)) 
function that will traverse the tree
of menu items and update 
a menu item with a given `id`.

Inside the same file `settings.dart`,
add the following function.

```dart
MenuItemInfo? _findAndUpdateMenuItem(MenuItemInfo item, int id, List<MenuItemInfo> updatedChildren) {
  // Breaking case
  if (item.id == id) {
    item.tiles = updatedChildren;
    return item;
  }

  // Continue searching
  else {
    final children = item.tiles;
    MenuItemInfo? ret;
    for (MenuItemInfo child in children) {
      ret = _findAndUpdateMenuItem(child, id, updatedChildren);
      if (ret != null) {
        break;
      }
    }
    return ret;
  }
}
```

This function `_findAndUpdateMenuItem` receives
the `id` of the menu item we want to update the children of
and the `updatedChildren` list of menu items.
The function recursively traverses the tree 
until it finds the menu item with the `id`.
When it does,
it updates it and stops traversing.

After execution,
this function returns the updated menu item.

This function will be *extremely* useful
to update menu item list at any level.

Let's use it!


### 5.2.4 Updating menu items

We are going to have widgets
that will render each menu item.

We are going to have two "types" of menu items:
- **root menu items**, self-explanatory.
- **_n-th_ level menu item**,
which is nested from the second level upwards.

*Because* we can have multiple root menu items,
we need to create two functions to update menu items:

- for *root items*,
we simply receive the reordered root menu item list
and update our local storage.
- for *nested menu items*,
we iterate over each root menu item
and recursively try to find the `id` of the menu item
to update its children.
We then save the updated list to local storage.

Let's implement these functions!

In `settings.dart`,
add the next two functions:

```dart
/// Updates the root menu item list [menuItems] in shared preferences.
updateRootObjectsInPreferences(List<MenuItemInfo> menuItems) async {
  final jsonString = json.encode(menuItems);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(storageKey, jsonString);
}

/// Update deeply nested menu item [item] with a new [updatedChildren] in shared preferences.
updateDeeplyNestedObjectInPreferences(MenuItemInfo itemToUpdate, List<MenuItemInfo> updatedChildren) async {
  // Fetch the menu items from `.json` file
  List<MenuItemInfo> menuItems = await loadMenuItems();

  // Go over the root items list and find & update the object with new children
  MenuItemInfo? updatedItem;
  for (var item in menuItems) {
    updatedItem = _findAndUpdateMenuItem(item, itemToUpdate.id, updatedChildren);
    if (updatedItem != null) {
      break;
    }
  }

  // Saving updated menu items encoded to json string.
  final jsonString = json.encode(menuItems);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(storageKey, jsonString);
}
```

`updateRootObjectsInPreferences` receives the reordered menu item list.
It simply saves the updated list to the local storage.
On the other hand, `updateDeeplyNestedObjectInPreferences` 
receives the item to update and the reordered children list.
Inside this latter function, 
we go over each root menu item and traverse down the tree
to update the menu item's children. 
After this, similarly to the previous function,
the updated menu list item is saved to local storage.

We are going to be using these handful functions *later*
when we are rendering these menu items!


# Star the repo! ⭐️

If you find this package/repo _useful_,
please star on GitHub, 
so that we know! ⭐ 

Thank you! 🙏 