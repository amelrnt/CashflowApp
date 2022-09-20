import 'package:cashflow_sertifikasi/data.dart';
import 'package:cashflow_sertifikasi/sqlite_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({ Key? key }) : super(key: key);

  @override
  _IncomePageState createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nominalController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2022, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cash Flow App'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal:15, vertical:30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Tambah Pemasukan',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
              const Text(
                'Tanggal :'
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("${selectedDate.toLocal()}".split(' ')[0]),
                const SizedBox(width: 20.0,),
                IconButton(
                  onPressed: () => _selectDate(context),
                  icon: const Icon(Icons.calendar_month_outlined),
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Nominal :'
                  ),
                  TextFormField(
                    controller: nominalController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter nominal';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const Text(
                    'Keterangan : '
                  ),
                  TextFormField(
                    controller: keteranganController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter keterangan';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ]
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed : () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      var dana = Dana(
                      tanggal: "${selectedDate.toLocal()}".split(' ')[0],
                      jumlah: int.parse(nominalController.text), 
                      status: 1, 
                      keterangan: keteranganController.text);
                      SqliteService.createItem(dana);
                    });

                    const snackBar = SnackBar(
                      content: Text('New cash flow Saved!'),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Simpan'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed : (){
                  Navigator.pop(context);
                },
                style:  ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('<< Kembali'),
              ),
            ),
            ]
          ),
        ),
      ),
    );
  }
}