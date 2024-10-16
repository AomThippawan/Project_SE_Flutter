import 'package:flutter/material.dart';
import 'package:project_se_app/controllers/prof_post_Controller.dart';
import 'package:project_se_app/models/prof_post.dart';
import 'package:project_se_app/pages/updatePostProf.dart';
import 'package:project_se_app/providers/profProvider.dart';
import 'package:provider/provider.dart';

class HistoryPostPorf extends StatefulWidget {
  const HistoryPostPorf({super.key});

  @override
  State<HistoryPostPorf> createState() => _HistoryPostPorfState();
}

class _HistoryPostPorfState extends State<HistoryPostPorf> {
  List<PostProfModel> postprof = [];
  final _postProfSurvice = PostProfSurvice();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPostprof();
  }

  Future<void> fetchPostprof() async {
    final profProvider = Provider.of<ProfProvider>(context, listen: false);

    try {
      final postProfList = await _postProfSurvice.fetchPostprof(profProvider);
      setState(() {
        postprof = postProfList;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error fetching products: $e')));
    }
  }

  void _toUpdateProduct(PostProfModel postProfModel) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UpdatePostProf(postProf: postProfModel),
      ),
    );
    if (result == true) {
      fetchPostprof();
    }
  }

  Future<void> _deleteProduct(PostProfModel postProfModel) async {
    final profProvider = Provider.of<ProfProvider>(context, listen: false);

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
        await _postProfSurvice.deleteProduct(postProfModel.id, profProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product deleted successfully!')),
        );
        fetchPostprof(); // อัปเดตข้อมูล
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting product: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profProvider = Provider.of<ProfProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(color: Colors.white),
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
            if (profProvider.isAuthentication())
              if (postprof.isEmpty)
                Center(
                  child: CircularProgressIndicator(),
                )
              else
                Expanded(
                    child: ListView.builder(
                        itemCount: postprof.length,
                        itemBuilder: (context, index) {
                          final post = postprof[index];
                          return Card(
                            elevation: 4,
                            margin: EdgeInsets.all(16.0),
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(post.jobtitle),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(post.jobdescription),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(post.joblocation),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(post.jobbuilding),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(post.jobroom),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(post.travelingType),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(post.foodSup),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(post.jobtimeStart),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(post.jobtimeEnd),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(post.count.toString()),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(post.reserveCount.toString()),
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
