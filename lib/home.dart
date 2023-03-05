import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference offer = FirebaseFirestore.instance.collection('offers');
  void deleteOffer(docId) {
    offer.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Recrutment App"),
        backgroundColor: Colors.deepOrange,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context,'/add');
          } ,
      backgroundColor: Colors.deepOrange,
        child: Icon(
          Icons.add,
          size:30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    body: Center(
      child: StreamBuilder(
        stream: offer.orderBy('offer name').snapshots(),
        builder:(context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
                itemBuilder:(context,index){
                final DocumentSnapshot offerSnap =snapshot.data.docs[index];
                return Padding(
                    padding: const EdgeInsets.all(10.0),

                  child: Container(
                  height:100 ,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow:[
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        spreadRadius: 15,

                    ),]
                  ),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: CircleAvatar(
                          backgroundColor:  Colors.deepOrange,
                          radius: 30,
                   // child: Text(
                       // offerSnap['services'],
                     // style: TextStyle(fontSize: 25),
                    //),
                        ),
                      ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(offerSnap['offer name'],
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                          Text(offerSnap['salary'],
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          Text(offerSnap['contrat'],
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          Text(offerSnap['services'],
                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        ],

                      ),
                      Row(
                        children: [
                          IconButton(
                             onPressed: (){
                            Navigator.pushNamed(context, '/update',
                            arguments:{
                              'offer name': offerSnap['offer name'],
                              'salary': offerSnap['salary'],
                                  'contrat': offerSnap['contrat'],
                                'services': offerSnap['services'],
                            'id':offerSnap.id,
                            }
                            );
                             },
                              icon: Icon(Icons.edit),
                              iconSize: 30,
                              color: Colors.blue,
                          ),
                          IconButton(onPressed: (){
                            deleteOffer(offerSnap.id);
                          },
                              icon: Icon(Icons.delete),
                              iconSize: 30,
                               color: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ) ,
                ),
                    );
                },);
          }
          return Container();
        },
      ),
    ),
    );
  }


}

