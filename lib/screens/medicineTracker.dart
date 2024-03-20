import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Medicine {
  final String name;
  final String imageUrl;
  final int dosage; // Now stores the number of pills
  final int dosageCount; // New field to store selected dropdown value
  final TimeOfDay timeOfDay;
  bool taken = false;

  Medicine({
    required this.name,
    required this.imageUrl,
    required this.dosage,
    required this.dosageCount, // New field
    required this.timeOfDay,
  });

  void markTaken() {
    taken = true;
  }
}

class MedicineTrackerPage extends StatefulWidget {
  @override
  _MedicineTrackerPageState createState() => _MedicineTrackerPageState();
}

class _MedicineTrackerPageState extends State<MedicineTrackerPage> {
  List<Medicine> medications = [];
  List<int> dosageOptions = [1, 2, 3, 4, 5]; // List of dosage options

  void addMedication(String name, String imageUrl, int dosage, int dosageCount, TimeOfDay timeOfDay) {
    setState(() {
      medications.add(Medicine(
          name: name, imageUrl: imageUrl, dosage: dosage, dosageCount: dosageCount, timeOfDay: timeOfDay));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Tracker'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AddMedicationDialog(onAdd: addMedication, dosageOptions: dosageOptions),
            ),
            child: Text('Add Medication'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: medications.length,
              itemBuilder: (context, index) {
                final medication = medications[index];
                return MedicationCard(medication: medication);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MedicationCard extends StatelessWidget {
  final Medicine medication;

  const MedicationCard({required this.medication});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: medication.imageUrl.isEmpty
            ? Icon(Icons.medication)
            : Image.network(medication.imageUrl),
        title: Text(medication.name),
        subtitle: Text(
          '${medication.dosageCount} pill(s) at ${medication.timeOfDay.format(context)}',
        ),
        trailing: IconButton(
          icon: Icon(medication.taken ? Icons.check_circle : Icons.check_circle_outline),
          onPressed: () => medication.markTaken(),
        ),
      ),
    );
  }
}

class AddMedicationDialog extends StatefulWidget {
  final Function(String name, String imageUrl, int dosage, int dosageCount, TimeOfDay timeOfDay)
      onAdd;
  final List<int> dosageOptions;

  const AddMedicationDialog({required this.onAdd, required this.dosageOptions});

  @override
  _AddMedicationDialogState createState() => _AddMedicationDialogState();
}

class _AddMedicationDialogState extends State<AddMedicationDialog> {
  String name = '';
  String imageUrl = '';
  int dosage = 0; // Now stores user-entered dosage value
  int dosageCount = 1; // Default selected dosage count
  TimeOfDay timeOfDay = TimeOfDay.now();

  void handleAdd() {
    widget.onAdd(name, imageUrl, dosage, dosageCount, timeOfDay);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Medication'),
      content: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Name'), // Use InputDecoration for label
            onChanged: (value) => setState(() => name = value),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Dosage'), // Use InputDecoration
            keyboardType: TextInputType.number,

          onChanged: (value) {
          try {
            setState(() => dosage = int.parse(value));
          } catch (error) {
            // Handle the error (e.g., show a snackbar message)
            print('Invalid dosage entered: $error');
          }
},
          ),
          DropdownButtonFormField<int>(
            value: dosageCount, // Initial selected value
            items: widget.dosageOptions.map((value) => DropdownMenuItem<int>(
              value: value,
              child: Text('$value pill(s)'),
            )).toList(),
            onChanged: (value) => setState(() => dosageCount = value!),
          ),
          TextButton(
            onPressed: () => showTimePicker(
              context: context,
              initialTime: timeOfDay,
            ).then((value) => setState(() => timeOfDay = value as TimeOfDay)),
            child: Text('Time of Day: ${timeOfDay.format(context)}'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: handleAdd,
          child: Text('Add'),
        ),
      ],
    );
  }
}

