import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddOffer extends StatefulWidget {
  const AddOffer({Key? key}) : super(key: key);

  @override
  State<AddOffer> createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  final  offerServices = ['Informatique','marketing','commercial','comptabilité','Adminstration'];
  String ? SelectedServices;
  final CollectionReference offer = FirebaseFirestore.instance.collection('offers');
  TextEditingController offerName =TextEditingController();
  TextEditingController offerSalary =TextEditingController();
  TextEditingController offerContrat =TextEditingController();

  void addOffer(){
final data ={
  'offer name':offerName.text,
      'salary':offerSalary.text,
    'contrat':offerContrat.text,
  'services':SelectedServices
};
    offer.add(data);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add offers"),
        backgroundColor: Colors.deepOrange,
      ),
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
        children:[
          Padding(padding: const EdgeInsets.all(8.0),
          child:  TextField(
            controller: offerName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),label: Text("Offer Name")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:  TextField(
              controller:offerSalary ,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),label: Text("salary")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:  TextField(
              controller: offerContrat,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),label: Text("contrat")),
            ),
          ),
      Padding(
        padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              label: Text("Select Service")
            ),
              items: offerServices
                  .map((e) =>DropdownMenuItem(
              child:Text(e),
                value:e ,
              ))
                  .toList(),
              onChanged: (val){
            SelectedServices = val as String?;

          })
      ),
          ElevatedButton(onPressed: (){
            addOffer();
            Navigator.pop(context);
            },
              style: ButtonStyle(
                minimumSize:
                  MaterialStateProperty.all(Size(double.infinity, 50)),
                backgroundColor: MaterialStateProperty.all(Colors.deepOrange)
              ),
              child: Text("Submit" ,
                style: TextStyle(fontSize: 20),
          ))
           ],
          ),
      ) ,

    );
  }
}
