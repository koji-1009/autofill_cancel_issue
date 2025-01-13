import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter autofill issue',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Page'),
      ),
      body: Center(
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SecondPage(),
                  ),
                );
              },
              child: const Text('Go to Second Page'),
            ),
            FilledButton.tonal(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SecondFocusPage(),
                  ),
                );
              },
              child: const Text('Go to Second Page (FocusNode)'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 16,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: AutofillGroup(
                onDisposeAction: AutofillContextAction.cancel,
                child: Column(
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      autofillHints: [
                        AutofillHints.username,
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      autofillHints: [
                        AutofillHints.password,
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FilledButton(
                      onPressed: () {
                        TextInput.finishAutofillContext(
                          shouldSave: true,
                        );
                      },
                      child: const Text('Submit'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ThirdPage(),
                          ),
                        );
                      },
                      child: const Text('Go to Third Page'),
                    ),
                  ],
                ),
              ),
            ),
            FilledButton.tonal(
              onPressed: () {
                primaryFocus?.unfocus();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Call `primaryFocus?.unfocus()`'),
                  ),
                );
              },
              child: const Text('Unfocus TextFields'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondFocusPage extends StatefulWidget {
  const SecondFocusPage({super.key});

  @override
  State<SecondFocusPage> createState() => _SecondFocusPageState();
}

class _SecondFocusPageState extends State<SecondFocusPage> {
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page (FocusNode)'),
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 16,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: AutofillGroup(
                onDisposeAction: AutofillContextAction.cancel,
                child: Column(
                  children: [
                    TextField(
                      focusNode: _usernameFocus,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      autofillHints: const [
                        AutofillHints.username,
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      focusNode: _passwordFocus,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      autofillHints: const [
                        AutofillHints.password,
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FilledButton(
                      onPressed: () {
                        TextInput.finishAutofillContext(
                          shouldSave: true,
                        );
                      },
                      child: const Text('Submit'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ThirdPage(),
                          ),
                        );
                      },
                      child: const Text('Go to Third Page'),
                    ),
                  ],
                ),
              ),
            ),
            FilledButton.tonal(
              onPressed: () {
                _usernameFocus.unfocus();
                _passwordFocus.unfocus();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Call `_focusNode.unfocus()`'),
                  ),
                );
              },
              child: const Text('Unfocus TextFields'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Page'),
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Go back to Second Page'),
        ),
      ),
    );
  }
}
