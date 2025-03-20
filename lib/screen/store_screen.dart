import 'package:flutter/material.dart';
import 'package:vetmobile/data/source/vettomy.dart/api_products.dart';
import 'package:vetmobile/domain/auth/models/product_model.dart';
import 'custom_drawer.dart'; // Asegúrate de importar el CustomDrawer

class TiendaScreen extends StatefulWidget {
  @override
  _TiendaScreenState createState() => _TiendaScreenState();
}

class _TiendaScreenState extends State<TiendaScreen> {
  late Future<List<ProductService>> futureProductsServices;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // GlobalKey para el Scaffold

  @override
  void initState() {
    super.initState();
    futureProductsServices = fetchProductsServices(
      type: 'Producto', // Prueba con 'products', 'services', 'all', etc.
      searchData: '', // Prueba con términos de búsqueda específicos
      pageNumber: 1,
      pageSize: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Asigna la GlobalKey al Scaffold
      backgroundColor: Colors.white,
      drawer: CustomDrawer(scaffoldKey: _scaffoldKey), // Usamos el CustomDrawer
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.black, size: 30),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer(); // Abrir el Drawer
                    },
                  ),
                  Spacer(),
                  Text(
                    "Tienda",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.blue, size: 30),
                    onPressed: () {
                      Navigator.pop(context); // Retroceder a la pantalla anterior
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              FutureBuilder<List<ProductService>>(
                future: futureProductsServices,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data found'));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true, // Esto es para que el ListView no ocupe todo el espacio disponible
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var product = snapshot.data![index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Imagen del producto
                                product.image.isNotEmpty
                                    ? Image.network(
                                        product.image[0].url,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.asset(
                                            'assets/images/logo_company.jpg',
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      )
                                    : Image.asset(
                                        'assets/images/logo_company.jpg',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        product.description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 14, color: Colors.grey),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '\$${product.price.toString()}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.green,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Stock: ${product.stock}',
                                        style: TextStyle(fontSize: 14, color: Colors.orange),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            'Marca: ${product.brandName}',
                                            style: TextStyle(fontSize: 14, color: Colors.blue),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Categoría: ${product.categoryName}',
                                            style: TextStyle(fontSize: 14, color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
