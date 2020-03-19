// Define a custom Form widget.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todone/blocs/task/task_index.dart';
import 'package:todone/models/index.dart';

class CreateTaskForm extends StatefulWidget {
  @override
  CreateTaskFormState createState() => CreateTaskFormState();
}

// Define a corresponding State class.
// This class holds data related to the form.
class CreateTaskFormState extends State<CreateTaskForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<CreateTaskFormState>.
  final _formKey = GlobalKey<FormState>();
  final today = new DateTime.now();

  final _todoCtl = TextEditingController();
  final _projectCtl = TextEditingController();
  final _dateCtl = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  final _noteCtl = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _dateCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TaskBloc _taskBloc = BlocProvider.of<TaskBloc>(context);
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _todoCtl,
            decoration: InputDecoration(
              // icon: Icon(Icons.person),
              hintText: 'What do do you need to do?',
              labelText: 'Todo',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _projectCtl,
            decoration: InputDecoration(
              // icon: Icon(Icons.person),
              hintText: 'Which project is it for?',
              labelText: 'Project',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value.isEmpty) {
                return 'Please select a project';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _dateCtl,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_today),
              hintText: 'When is it due?',
              labelText: 'Due date',
            ),
            onTap: () async {
              // Below line stops keyboard from appearing
              FocusScope.of(context).requestFocus(new FocusNode());

              print(DateFormat('dd-MM-yyyy').parse(_dateCtl.text));

              var date = await showDatePicker(
                  context: context,
                  initialDate: today,
                  firstDate: today,
                  lastDate: today.add(Duration(days: 365 * 5)));

              print('date');
              print(date);

              if (date != null) {
                final String formattedDate =
                    DateFormat('dd-MM-yyyy').format(date);
                print('format');
                print(formattedDate);

                _dateCtl.value = TextEditingValue(
                  text: formattedDate,
                  selection: TextSelection.fromPosition(
                    TextPosition(offset: formattedDate.length),
                  ),
                );
              }
            },
            // The validator receives the text that the user has entered.
            validator: (value) {
              // DateTime.now().year + 1;
              if (value.isEmpty) {
                return 'Please select a date';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _noteCtl,
            decoration: InputDecoration(
              // icon: Icon(Icons.person),
              hintText: 'What do do you need to do?',
              labelText: 'Note',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              return null;
            },
          ),
          RaisedButton(
            onPressed: () {
              // Validate returns true if the form is valid, otherwise false.
              if (_formKey.currentState.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                final todo = _todoCtl.text;
                final project = _projectCtl.text;
                final dueDate = DateFormat('dd-MM-yyyy').parse(_dateCtl.text);
                final note = _noteCtl.text;

                _taskBloc.add(
                  AddTaskEvent(
                    task: new Task(todo, project, dueDate, note),
                  ),
                );

                Navigator.of(context).pop();

                // Scaffold.of(context).showSnackBar(
                //     SnackBar(content: Text('Processing Data')));
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
