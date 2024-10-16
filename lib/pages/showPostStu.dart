import 'package:flutter/material.dart';
import 'package:project_se_app/controllers/prof_post_Controller.dart';
import 'package:project_se_app/controllers/std_post_controller.dart';
import 'package:project_se_app/models/std_post.dart';
import 'package:project_se_app/pages/updatePostStu.dart';
import 'package:project_se_app/providers/stdProvider.dart';
import 'package:provider/provider.dart';

import '../providers/profProvider.dart';

class HistoryPostStu extends StatefulWidget {
  const HistoryPostStu({super.key});

  @override
  State<HistoryPostStu> createState() => _HistoryPostStuState();
}

class _HistoryPostStuState extends State<HistoryPostStu> {
  List<PostModel> poststu = [];
  final _postStuSurvice = PostService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPoststu();
  }

  Future<void> fetchPoststu() async {
    final stuProvider = Provider.of<StuProvider>(context, listen: false);

    try {
      final postStuList = await _postStuSurvice.fetchPostStu(stuProvider);
      setState(() {
        poststu = postStuList;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error fetching post: $e')));
    }
  }

  void _toUpdateProduct(PostModel postModel) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UpdatePostStu(postStu: postModel),
      ),
    );
    if (result == true) {
      fetchPoststu();
    }
  }

  Future<void> _deleteProduct(PostModel postModel) async {
    final stuProvider = Provider.of<StuProvider>(context, listen: false);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm deletion'),
          content: Text('Are you sure you want to delete ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await _postStuSurvice.deletePost(postModel.id, stuProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product deleted successfully!')),
        );
        fetchPoststu(); // อัปเดตข้อมูล
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting product: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final stuProvider = Provider.of<StuProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo.shade600,
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back button and icon colors to white
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.indigo.shade600,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (stuProvider.isAuthentication())
              if (poststu.isEmpty)
                Center(
                  child: CircularProgressIndicator(),
                )
              else
                Expanded(
                    child: ListView.builder(
                        itemCount: poststu.length,
                        itemBuilder: (context, index) {
                          final post = poststu[index];
                          return Card(
                            elevation: 4,
                            margin: EdgeInsets.all(16.0),
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(post.stskill),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(post.stability),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(post.stworktime),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () => _toUpdateProduct(post),
                                        icon: Icon(Icons.edit_note_rounded),
                                        tooltip: 'Edit',
                                      ),
                                      IconButton(
                                        onPressed: () => _deleteProduct(post),
                                        icon: Icon(Icons.delete_outline),
                                        tooltip: 'Delete',
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }))
          ],
        ),
      ),
    );
  }
}
