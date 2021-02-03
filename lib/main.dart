import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            print('hide keyboard');

            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: MyHomePage(title: 'Form test'),
      ),
    );
  }
}

class Panel extends StatelessWidget {
  final Widget child;

  Panel({this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.only(bottom: 20, top: 10),
        child: child,
      ),
    );
  }
}

class Form extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Panel(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Login",
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 24),
          Container(
              width: double.infinity,
              color: Colors.grey.shade50,
              child: Text(
                'Login to receive the latest updates, \nproducts and feature offers.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
          SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: Theme.of(context).textTheme.bodyText2,
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyText2,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: Theme.of(context).textTheme.bodyText2,
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyText2,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                SizedBox(height: 16),
                Text(
                  "Forgot password?",
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(decoration: TextDecoration.underline),
                ),
                SizedBox(height: 16),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an account?",
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Signup",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(decoration: TextDecoration.underline),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Center(
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 56, vertical: 16),
                    child: Text(
                      "Login >",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

enum HeaderSize { H0, H100, P50 }

class Page extends StatefulWidget {
  final double height;

  Page({
    this.height,
  });

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        AnimatedSize(
          duration: Duration(milliseconds: 250),
          curve: Curves.easeOut,
          vsync: this,
          child: SizedBox(
            height: widget.height,
            width: 30,
            child: Container(color: Colors.green),
          ),
        ),
        Form(),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String username;
  String password;
  HeaderSize _size = HeaderSize.H100;

  @override
  Widget build(BuildContext context) {
    var height;

    print("size ${MediaQuery.of(context).size}");
    print("padding ${MediaQuery.of(context).padding}");
    print("viewPadding ${MediaQuery.of(context).viewPadding}");
    print("viewInsets ${MediaQuery.of(context).viewInsets}");
    final double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.vertical;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.vertical;

    height = MediaQuery.of(context).padding.top;

    switch (_size) {
      case HeaderSize.H0:
        height += 0.0;
        break;
      case HeaderSize.H100:
        height = 100.0;
        break;
      case HeaderSize.P50:
        height = screenHeight * 0.5;
        break;
    }

    height = height - keyboardHeight;

    return Scaffold(
      backgroundColor: Colors.red.shade200,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Page(
            height: height,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text('Header size:'),
                  Radio<HeaderSize>(
                    value: HeaderSize.H0,
                    groupValue: _size,
                    onChanged: (HeaderSize newSize) {
                      setState(() {
                        _size = newSize;
                      });
                    },
                  ),
                  const Text('0px'),
                  Radio<HeaderSize>(
                    value: HeaderSize.H100,
                    groupValue: _size,
                    onChanged: (HeaderSize newSize) {
                      setState(() {
                        _size = newSize;
                      });
                    },
                  ),
                  const Text('100px'),
                  Radio<HeaderSize>(
                    value: HeaderSize.P50,
                    groupValue: _size,
                    onChanged: (HeaderSize newSize) {
                      setState(() {
                        _size = newSize;
                      });
                    },
                  ),
                  const Text('50%'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
