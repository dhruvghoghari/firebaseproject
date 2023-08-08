import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'EditProduct.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({Key? key}) : super(key: key);

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Product").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
          {
            if(snapshot.hasData)
              {
                if(snapshot.data!.size <=0)
                  {
                    return Center(
                      child: Text("No data!"),
                    );
                  }
                else
                  {
                    return ListView(
                      children: snapshot.data!.docs.map((document){
                        return ListTile(
                          leading: Image.network(document["fileurl"].toString()),
                          title: Text(document["name"].toString()),
                          subtitle: Text(document["qty"].toString()),
                          trailing: Text("Rs." + document["price"].toString()),
                          onTap: () async{
                            var id = document.id.toString();

                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>EditProduct(
                                updateid: id,
                              ))
                            );


                            // await FirebaseFirestore.instance.collection("Product").doc(id).delete().then((value){
                            //   var snackbar = SnackBar(
                            //     content: Text("Delete Data Successfully"),
                            //     duration: Duration(seconds: 2),
                            //   );
                            //   ScaffoldMessenger.of(context).showSnackBar(snackbar);
                            // });
                          },
                        );
                      }).toList(),
                    );
                  }
              }
            else
              {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          },
        ),
      ),
    );
  }
}
