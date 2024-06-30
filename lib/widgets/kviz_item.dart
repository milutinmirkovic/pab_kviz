import 'package:flutter/material.dart';
import 'package:pab_kviz/models/kviz.dart';

class KvizItem extends StatelessWidget {
  final Kviz kviz;
  final bool isAdmin;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;
  final VoidCallback onRegister;

  KvizItem({
    required this.kviz,
    required this.isAdmin,
    required this.onDelete,
    required this.onUpdate,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              kviz.naziv,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Datum: ${kviz.datum}'),
            Text('Vreme: ${kviz.vreme}'),
            Text('Cena po igraču: ${kviz.cenaPoIgracu} RSD'),
            SizedBox(height: 10),
            if (isAdmin) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onUpdate,
                    child: Text('Update'),
                  ),
                  TextButton(
                    onPressed: onDelete,
                    child: Text('Delete'),
                  ),
                ],
              ),
            ] else ...[
              Center(
                child: ElevatedButton(
                  onPressed: onRegister,
                  child: Text('Prijavi ekipu'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
