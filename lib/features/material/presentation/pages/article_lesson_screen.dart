import 'package:flutter/material.dart' hide Material;

import '../../../../core/helpers/md_helper.dart';
import '../../domain/entities/material.dart';

/// Full Article Screen
class ArticleLessonScreen extends StatelessWidget {
  final Material material;

  const ArticleLessonScreen({
    super.key,
    required this.material,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          material.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MdHelper(markdownData: /* material.article ??*/
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
"""),
      ),
    );
  }
}
