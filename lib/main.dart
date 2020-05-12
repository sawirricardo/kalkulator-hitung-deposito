import 'package:flutter/material.dart';
//import 'package:indonesia/indonesia.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hitung-Hitung',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hitung Jumlah Depositomu'),
        ),
        body:
            Center(child: MyStatefulWidget()),

      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<MyStatefulWidget> {



  List<double> arrBunga = [4.25, 5.25, 5.5, 5.75, 6, 6.25];
  List<int> arrTenor = [1,3,6,9,12,24];

  var inputAngka;

  double getBungaDeposito(jumlahUangSimpanan, bungaPerTahun, tenor)
  {
    if (jumlahUangSimpanan == null) {
      jumlahUangSimpanan = 0;
    }
    double hasil=0;
    if (jumlahUangSimpanan <= 7500000) {
      hasil = jumlahUangSimpanan * (bungaPerTahun / 100) * (tenor / 12);
    } else {
      hasil = jumlahUangSimpanan * ((bungaPerTahun * (80 / 100)) / 100) * (tenor / 12);
    }
    return hasil;
  }
  List<TableRow>listArray = [];

  final _formKey = GlobalKey<FormState>();
  final angka = TextEditingController();

  void renderHasil() {
    if (listArray.length>0) {
      listArray=[];
    }
    listArray.add(

        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCell(child: Center(child: Text('Total Deposito'))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCell(child: Center(child: Text('Bunga bersih'))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCell(child: Center(child: Text('Bunga'))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCell(child: Center(child: Text('Tenor'))),
            ),
          ],
        ),

    );
    for(var i =0; i < arrBunga.length; i++) {
      double bungaBersih = getBungaDeposito(inputAngka, arrBunga[i], arrTenor[i]);
      double total = bungaBersih + inputAngka;

      listArray.add(
           TableRow(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCell(child: Center(child: Text(total.toStringAsFixed(2)))),
            ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: TableCell(child: Center(child: Text(bungaBersih.toStringAsFixed(2)))),
             ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCell(child: Center(child: Text(arrBunga[i].toString() + '%'))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCell(child: Center(child: Text(arrTenor[i].toString() + ' Tahun'))),
            )
        ]
      )
      );
    }

  }
  @override
  Widget build(BuildContext context) {

    return  Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    keyboardType:TextInputType.number,
                    controller: angka,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Angka',
                    ),
                    onChanged: (value) {
                    if(_formKey.currentState.validate()) {
                      setState(() {
                         inputAngka = double.parse(value);
                         renderHasil();
                      });
                    }
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some number';
                      }
                      return null;
                    },
                  ),

                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
                border: TableBorder.all(),
                children:listArray
              ),
          ),
        ],
      );

  }
}
