import 'package:cashflow_sertifikasi/sqlite_service.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({ Key? key }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<Map<String, dynamic>> _listDana = [];
  bool _isLoading = true;

  // This function is used to fetch all data from the database
  void _refreshData() async {
    final data = await SqliteService.getAll();
    setState(() {
      _listDana = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cash Flow App'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal:5, vertical:20),
        child: Column(
          children: <Widget>[
            const Text(
              'Detail Cash Flow',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                itemCount: _listDana.length,
                itemBuilder: (item, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const SizedBox(height:5),
                                _listDana[index]['status'] == 0 ? 
                                  Text('[-] Rp.${_listDana[index]['jumlah']}',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  )
                                  : Text('[+] Rp.${_listDana[index]['jumlah']}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                const SizedBox(height:5),
                                //Text('[+] Rp.${_listDana[index]['jumlah']}'), // change to row
                                Text("${_listDana[index]['keterangan']}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height:5),
                                Text('${_listDana[index]['tanggal']}',
                                style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height:5),
                              ],
                            ),
                            _listDana[index]['status'] == 0 ? 
                            Image.asset(
                              width: 50,
                              height : 50,
                              'images/left-arrow.png')
                            : Image.asset(
                              width: 50,
                              height : 50,
                              'images/right-arrow.png'),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed : ()async {
                  Navigator.pop(context);
                },
                style:  ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                child: const Text('<< Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}