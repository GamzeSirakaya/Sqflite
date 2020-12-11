import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';
import 'package:sqflite_demo/screens/product_add.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State {
  DbHelper dbHelper = DbHelper();
  List<Product> products;
  int productCount = 0;

  @override
  void initState() {
    //bu sayfadaki state başlat

    getProducts();
    super.initState(); //ürünler geldiğinde ne yapması gerektiğini yazariz.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün listesi"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToProductAdd();
        },
        child: Icon(Icons.add),
        tooltip: "Yeni Ürün Ekle",
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.blueGrey,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.black12, child: Text("p")),
              title: Text(this.products[position].name),
              subtitle: Text(this.products[position].description),
              onTap: () {},
            ),
          );
        });
  }

  void goToProductAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));
    if (result != null) {
      if (result) {
        getProducts();
      }
    }
  }

  void getProducts() async {
    //bu sayfadaki state başlat
    var productsFuture = dbHelper
        .getProducts(); //bu sayfa açıldığında ürünler gelene kadar asenkron yapının çalıştığını görüyoruz.
    productsFuture.then((data) {
      this.products = data;
      productCount = data.length;
    });
  }
}
