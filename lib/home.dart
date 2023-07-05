import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login.dart';
import 'model/product.dart';
import 'model/products_repository.dart';
import 'more.dart';

final Uri _url = Uri.parse('https://www.handong.edu/');
final isSelected = <bool>[false, true];


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products.isEmpty) {
      return const <Card>[];
    }

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        // TODO: Adjust card heights (103)
        child: Column(
          // TODO: Center items on the card (103)
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 10 / 4,
              child: Hero(
                tag: "hero",
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Image.asset(
                      'assets/images/${product.id}-0.jfif',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  // TODO: Align labels to the bottom and center (103)
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // TODO: Change innermost Column (103)
                  children: <Widget>[
                    // TODO: Handle overflowing labels (103)
                    Expanded(
                        child: GridView.count(
                            crossAxisCount: 10,
                            children: List<Widget>.generate(product.star, (idx) {
                              return const Icon(Icons.star, color: Colors.yellow, size: 15);
                            }).toList()
                        )
                    ),
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.pin_drop, color: Colors.blue,),
                          Expanded(
                            child: Text(
                              product.address,
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 30,
                      alignment: Alignment.bottomRight,
                      child : TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 10),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MorePage(product.id, product.name, product.address, product.star, product.phone, product.des)
                              )
                          );
                        },
                        child: const Text('more'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }


  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
              icon: const Icon(
                Icons.language,
                semanticLabel: 'language',
              ),
              onPressed: _launchUrl
              //_launchUrl,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
              alignment: Alignment.bottomRight,
              child: ToggleButtons(
                color: Colors.black.withOpacity(0.60),
                selectedColor: Colors.blueAccent,
                selectedBorderColor: Colors.blueAccent,
                fillColor: Colors.blueAccent.withOpacity(0.08),
                splashColor: Colors.blueAccent.withOpacity(0.12),
                hoverColor: Colors.blueAccent,
                borderRadius: BorderRadius.circular(4.0),
                isSelected: isSelected,
                onPressed: (index) {
                  // Respond to button selection
                  setState(() {
                    if(index == 0 && isSelected[1] == true){
                      isSelected[index] = !isSelected[index];
                      isSelected[1] = !isSelected[1];
                    }
                    else if(index == 1 && isSelected[0] == true){
                      isSelected[index] = !isSelected[index];
                      isSelected[0] = !isSelected[0];
                    }
                  });
                },
                children: const [
                  Icon(Icons.list),
                  Icon(Icons.grid_view),
                ],
              )
          ),
          Expanded(
            child: isSelected[1]
                ? OrientationBuilder(
                builder: (context, orientation) {
                  return GridView.count(
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                    padding: const EdgeInsets.all(16.0),
                    childAspectRatio: 8.0 / 9.0,
                    children: _buildGridCards(context),
                  );
                }
            )
                : ListView.builder(
              itemCount: ProductsRepository.loadProducts(Category.all).length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.fromLTRB(6, 6, 0, 2),
                  child: SizedBox(
                    height: 100,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/${ProductsRepository.loadProducts(Category.all)[index].id}-0.jfif',
                          fit: BoxFit.fitHeight,
                          height: 95,
                          width: 100,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                for( int i=0 ; i< ProductsRepository.loadProducts(Category.all)[index].star; i++ )
                                  Icon(Icons.star, color: Colors.yellow, size: 15)
                              ],
                            ),
                            Text(
                              ProductsRepository.loadProducts(Category.all)[index].name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.pin_drop, color: Colors.blue,size: 13,),
                                Text(
                                    ProductsRepository.loadProducts(Category.all)[index].address,
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ))
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 90,
                        ),
                        Container(
                          height: 30,
                          alignment: Alignment.bottomRight,
                          child : TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 15),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MorePage(ProductsRepository.loadProducts(Category.all)[index].id, ProductsRepository.loadProducts(Category.all)[index].name, ProductsRepository.loadProducts(Category.all)[index].address, ProductsRepository.loadProducts(Category.all)[index].star,
                                        ProductsRepository.loadProducts(Category.all)[index].phone, ProductsRepository.loadProducts(Category.all)[index].des)
                                )
                            );
                            },
                            child: const Text('more'),
                          ),
                        )

                      ],
                    )
                  )
                );
              },
            )
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: 165,
              child: const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  'Pages',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    height: 5.5,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.lightBlueAccent,
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.search,
                color: Colors.lightBlueAccent,
              ),
              title: const Text('Search'),
              onTap: () {
                Navigator.pushNamed(context, '/search');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.location_city,
                color: Colors.lightBlueAccent,
              ),
              title: const Text('Favorite Hotel'),
              onTap: () {
                Navigator.pushNamed(context, '/favorite');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.lightBlueAccent,
              ),
              title: const Text('My Page'),
              onTap: () {
                Navigator.pushNamed(context, '/mypage');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.lightBlueAccent,
              ),
              title: const Text('Log Out'),
              onTap: () {
                // Navigator.pop(context);
                Navigator.pushNamed(context, '/login');
              },
            ),

          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
