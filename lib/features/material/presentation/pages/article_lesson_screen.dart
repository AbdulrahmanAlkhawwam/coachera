import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/features/course/domain/entities/progress.dart';
import 'package:coachera/features/course/presentation/bloc/bloc/course_bloc.dart';
import 'package:coachera/features/material/domain/param/complete_lesson.dart';
import 'package:flutter/material.dart' hide Material, MaterialState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/helpers/md_helper.dart';
import '../../domain/entities/material.dart';
import '../bloc/bloc/material_bloc.dart';

/// Full Article Screen
class ArticleLessonScreen extends StatefulWidget {
  final Material material;
  final int enrollmentId;
  final bool isComplete;

  const ArticleLessonScreen({
    super.key,
    required this.material,
    required this.enrollmentId,
    required this.isComplete,
  });

  @override
  State<ArticleLessonScreen> createState() => _ArticleLessonScreenState();
}

class _ArticleLessonScreenState extends State<ArticleLessonScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isAtBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final position = _scrollController.position;
        if (position.maxScrollExtent <= 0) {
          // No scroll, show button immediately
          setState(() => _isAtBottom = true);
        }
      }
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 20) {
      if (!_isAtBottom) setState(() => _isAtBottom = true);
    } else {
      if (_isAtBottom) setState(() => _isAtBottom = false);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MaterialBloc, MaterialState>(
      listener: (context, state) {
        if (state.status == MaterialStatus.error) {
          context.showErrorSnackBar(massage: state.message);
        } else if (state.status == MaterialStatus.success) {
          context.read<CourseBloc>().add(GetUserCourses());
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            widget.material.title.split(" -").first,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: !widget.isComplete && _isAtBottom
            ? FilledButton(
                onPressed: () =>
                    context.read<MaterialBloc>().add(CompleteLesson(
                            param: CompleteLessonParam(
                          enrollmentId: widget.enrollmentId,
                          materialId: widget.material.id,
                        ))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Complete Lesson"),
                    const SizedBox(width: 8),
                    const Icon(TablerIcons.arrow_right)
                  ],
                ),
              )
            : const SizedBox(),
        body: MdHelper(
          scrollController: _scrollController,
          markdownData: widget.material.article ??
              """
      # Article Title (H1)
      
      Welcome to **Coachera Article Viewer** demo.
      This is a *Markdown* example with different elements.
      
      ---
      
      ## Subheading (H2)
      
      Here is a paragraph with a [link to Flutter](https://flutter.dev)
      and some inline code like `print("Hello World")`.
      
      ### Sub-subheading (H3)
      
      You can also show lists:
      
      - Item 1
      - Item 2
        - Subitem 2.1
        - Subitem 2.2
      - Item 3
      
      1. Ordered item A
      2. Ordered item B
      3. Ordered item C
      
      ---
      
      ## Blockquote Example
      
      > This is a blockquote.
      > It can span multiple lines.
      
      ---
      
      ## Code Block Example
      
      ```dart
      void main() {
        print("Hello Coachera!");
      }
      """,
        ),
      ),
    );
  }
}
