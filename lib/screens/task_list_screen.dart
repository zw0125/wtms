import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wtms/model/Work.dart';
import 'dart:convert';
import 'package:wtms/model/workers.dart';
import 'package:wtms/myconfig.dart';
import 'package:wtms/screens/submit_work_screen.dart';

class TaskListScreen extends StatefulWidget {
  final Worker worker;

  const TaskListScreen({Key? key, required this.worker}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Work> _works = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWorks();
  }

  Future<void> _loadWorks() async {
    try {
      print('Loading works for worker ID: ${widget.worker.id}'); // Debug print

      final response = await http.post(
        Uri.parse('${MyConfig.MYURL}get_works.php'),
        body: {'worker_id': widget.worker.id.toString()},
      );

      print('Response status: ${response.statusCode}'); // Debug print
      print('Response body: ${response.body}'); // Debug print

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            _works =
                (data['works'] as List)
                    .map((work) => Work.fromJson(work))
                    .toList();
            _isLoading = false;
          });
          print('Loaded ${_works.length} works'); // Debug print
        } else {
          print('API error: ${data['message']}'); // Debug print
        }
      }
    } catch (e) {
      print('Error loading works: $e'); // Debug print
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _works.isEmpty
              ? const Center(child: Text('No tasks assigned'))
              : ListView.builder(
                itemCount: _works.length,
                itemBuilder: (context, index) {
                  final work = _works[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            work.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(work.description),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Due: ${work.dueDate.toString().split(' ')[0]}',
                                style: const TextStyle(color: Colors.red),
                              ),
                              Chip(
                                label: Text(work.status),
                                backgroundColor:
                                    work.status == 'completed'
                                        ? Colors.green[100]
                                        : Colors.orange[100],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (work.status != 'completed')
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => SubmitWorkScreen(
                                            work: work,
                                            worker: widget.worker,
                                          ),
                                    ),
                                  ).then(
                                    (_) => _loadWorks(),
                                  ); // Refresh after submission
                                },
                                child: const Text('Submit Work'),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
