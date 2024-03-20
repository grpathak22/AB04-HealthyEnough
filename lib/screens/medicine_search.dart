import 'package:flutter/material.dart';
import 'package:healthy_enough/artificial_intelligence/connection.dart';

class MedSearch extends StatefulWidget {
  const MedSearch({Key? key}) : super(key: key);

  @override
  State<MedSearch> createState() => _MedSearchState();
}

class _MedSearchState extends State<MedSearch> {
  late TextEditingController controller; // Initialize the controller

  String? result = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(); // Initialize the controller
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Searcher'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.local_pharmacy,
                    color: Theme.of(context).primaryColor),
                SizedBox(width: 10),
                Text(
                  'MediScan',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Enter Medicine',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              maxLines: 3,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isLoading) CircularProgressIndicator(),
                ElevatedButton(
                  onPressed: getMedicineInfo,
                  child: Text('Search Medicine'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (result?.isNotEmpty ?? false)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Medicine Information:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  Text(
                    result.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<void> getMedicineInfo() async {
    setState(() {
      isLoading = true;
    });

    final model = EnoughAi();
    final prompt =
        '''Please provide information about the medicine "${controller.text}": 
       including its uses, side effects, and potential drug interactions.''';

    await model.connectKey();

    final resultText = await model.promptGen(prompt);

    setState(() {
      isLoading = false;
      result = resultText;
    });
  }
}
