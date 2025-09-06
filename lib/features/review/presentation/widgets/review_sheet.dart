import 'package:flutter/material.dart';

class ReviewBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        double rating = 0;
        TextEditingController feedbackController = TextEditingController();
        bool hideName = false;

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 20,
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Basic UI/UX Designer",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Azamat Baimatov",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 20),
                  Text("Rate the Course"),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 32,
                        ),
                        onPressed: () {
                          setState(() {
                            rating = index + 1.0;
                          });
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: feedbackController,
                    maxLength: 600,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Leave Feedback (optional)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: hideName,
                        onChanged: (val) {
                          setState(() {
                            hideName = val ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          "Hide name, this review will display H******",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        // Handle submit logic
                        print("Rating: $rating");
                        print("Feedback: ${feedbackController.text}");
                        print("Hide Name: $hideName");


                        Navigator.pop(context);
                      },
                      child: Text("Send"),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
