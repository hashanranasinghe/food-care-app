import 'package:flutter/material.dart';
import 'package:food_care/utils/constraints.dart';
import 'package:food_care/view%20models/comment%20view%20model/comment_add_view_model.dart';
import 'package:food_care/view%20models/user%20view/userViewModel.dart';
import 'package:provider/provider.dart';

import '../../view models/comment view model/comment_list_view_model.dart';
import '../../view models/forum view/forum_list-view_model.dart';

class CommentScreen extends StatefulWidget {
  final String forumId;

  const CommentScreen({super.key, required this.forumId});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late CommentAddViewModel _commentAddViewModel;
  String comment = '';
  TextEditingController commentController = TextEditingController();
  final _form = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentAddViewModel =
        Provider.of<CommentAddViewModel>(context, listen: false);
    _populateAllComments();
  }

  void _populateAllComments() {
    Provider.of<CommentListViewModel>(context, listen: false)
        .getAllComments(widget.forumId);
  }

  void _populateForums() {
    Provider.of<ForumListViewModel>(context, listen: false).getAllForums();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CommentListViewModel>(context);
    final addVm = Provider.of<CommentAddViewModel>(context);
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      if (userViewModel.user == null) {
        userViewModel.getCurrentUser();
        return const Center(child: CircularProgressIndicator());
      } else {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColordark,
            title: Text('Comments'),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: vm.comments
                      .length, // replace with actual number of comments
                  itemBuilder: (context, index) {
                    final comment = vm.comments[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: kPrimaryColordark,
                        child: Icon(Icons.person),
                      ),
                      title: Text(comment.commenter),
                      subtitle: Text(comment.text),
                    );
                  },
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Form(
                        key: _form,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Add a comment...',
                            border: OutlineInputBorder(),
                          ),
                          controller: commentController,
                          onChanged: (value) {
                            addVm.text = value;
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () async {
                        if (_form.currentState!.validate()) {
                          setState(() {
                            addVm.commenter = userViewModel.user!.name;
                          });
                          await _commentAddViewModel
                              .saveComment(widget.forumId);
                          _populateAllComments();
                          commentController.clear();
                          _populateForums();
                        }
                      },
                      child: Text('Post'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
