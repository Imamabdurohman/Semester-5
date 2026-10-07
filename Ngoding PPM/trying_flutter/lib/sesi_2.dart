import 'package:flutter/material.dart';

// Data Diri Mahasiswa
const String namaMahasiswa = 'Imam Abdurohman Ramdani';
const String nimMahasiswa = '20240040112';
const String prodiKelasMahasiswa = 'Teknik Informatika / TI24G';
const String kodePromoResmi = 'PROMOSESI2';

// Model Data
class Product {
  final String id;
  final String nama;
  final int harga;
  final String kategori;
  final String imagePath;
  final String deskripsi;
  int likeCount;
  bool isFavorite;
  double rating;

  Product({
    required this.id,
    required this.nama,
    required this.harga,
    required this.kategori,
    required this.imagePath,
    required this.deskripsi,
    required this.likeCount,
    this.isFavorite = false,
    required this.rating,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}

class ReviewItem {
  final String id;
  final String productId;
  final String name;
  final double rating;
  final String comment;
  final String date;

  ReviewItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.rating,
    required this.comment,
    required this.date,
  });
}

class OrderItem {
  final String id;
  final List<CartItem> items;
  final int totalHarga;
  String status;
  final String tanggal;
  String? metodePembayaran;
  String? alasanPengembalian;
  String? nomorResi;

  OrderItem({
    required this.id,
    required this.items,
    required this.totalHarga,
    required this.status,
    required this.tanggal,
    this.metodePembayaran,
    this.alasanPengembalian,
    this.nomorResi,
  });
}

class TugasSesi2Page extends StatefulWidget {
  const TugasSesi2Page({super.key});

  @override
  State<TugasSesi2Page> createState() => _TugasSesi2PageState();
}

class _TugasSesi2PageState extends State<TugasSesi2Page> {
  final List<Product> _products = [
    Product(
      id: 'p1',
      nama: 'Wireless Headphone Pro',
      harga: 150000,
      kategori: 'Aksesoris',
      imagePath: 'assets/headphone.jpg',
      deskripsi: 'Headphone Bluetooth suara super jernih dan bass mantap.',
      likeCount: 120,
      rating: 4.8,
    ),
    Product(
      id: 'p2',
      nama: 'Smartwatch Sport V2',
      harga: 350000,
      kategori: 'Gadget',
      imagePath: 'assets/smartwatch.jpg',
      deskripsi: 'Jam tangan pintar pendeteksi detak jantung & aktivitas olahraga.',
      likeCount: 85,
      rating: 4.7,
    ),
    Product(
      id: 'p3',
      nama: 'Keyboard Mechanical RGB',
      harga: 450000,
      kategori: 'Elektronik',
      imagePath: 'assets/keyboard.jpg',
      deskripsi: 'Keyboard gaming mechanical dengan backlight RGB keren.',
      likeCount: 210,
      rating: 4.9,
    ),
    Product(
      id: 'p4',
      nama: 'Mouse Wireless Gaming',
      harga: 120000,
      kategori: 'Aksesoris',
      imagePath: 'assets/mouse.jpg',
      deskripsi: 'Mouse tanpa kabel sensitivitas tinggi DPI responsif.',
      likeCount: 64,
      rating: 4.6,
    ),
    Product(
      id: 'p5',
      nama: 'Ransel Laptop Anti Air',
      harga: 220000,
      kategori: 'Fashion',
      imagePath: 'assets/tas.jpg',
      deskripsi: 'Tas ransel muat laptop 15 inch dengan bahan tahan air.',
      likeCount: 95,
      rating: 4.8,
    ),
    Product(
      id: 'p6',
      nama: 'TWS Bluetooth Earbuds',
      harga: 180000,
      kategori: 'Aksesoris',
      imagePath: 'assets/tws.jpg',
      deskripsi: 'Earphone wireless bentuk ringkas dengan case charger.',
      likeCount: 142,
      rating: 4.7,
    ),
    Product(
      id: 'p7',
      nama: 'Speaker Bluetooth Portable',
      harga: 250000,
      kategori: 'Elektronik',
      imagePath: 'assets/speaker.jpg',
      deskripsi: 'Speaker mini suara kencang cocok untuk aktivitas luar ruangan.',
      likeCount: 78,
      rating: 4.5,
    ),
    Product(
      id: 'p8',
      nama: 'Powerbank Fast Charge 20k',
      harga: 190000,
      kategori: 'Gadget',
      imagePath: 'assets/powerbank.jpg',
      deskripsi: 'Powerbank daya besar 20.000 mAh pendukung pengisian cepat.',
      likeCount: 180,
      rating: 4.9,
    ),
    Product(
      id: 'p9',
      nama: 'Stand Laptop Aluminium',
      harga: 85000,
      kategori: 'Aksesoris',
      imagePath: 'assets/stand.jpg',
      deskripsi: 'Dudukan laptop aluminium ergonomis dan bisa dilipat.',
      likeCount: 53,
      rating: 4.6,
    ),
    Product(
      id: 'p10',
      nama: 'Kaos Polos Cotton Combed',
      harga: 65000,
      kategori: 'Fashion',
      imagePath: 'assets/kaos.jpg',
      deskripsi: 'Bahan adem dan nyaman digunakan sehari-hari.',
      likeCount: 310,
      rating: 4.8,
    ),
  ];

  final List<CartItem> _cart = [];
  String _selectedCategory = 'Semua';
  String _selectedOrderStatus = 'Belum Dibayar';
  String _inputPromoCode = '';
  bool _isPromoApplied = false;

  final List<ReviewItem> _reviews = [
    ReviewItem(
      id: 'r1',
      productId: 'p1',
      name: 'Andi Pratama',
      rating: 5.0,
      comment: 'Suaranya mantap bass-nya terasa banget!',
      date: '2 hari lalu',
    ),
    ReviewItem(
      id: 'r2',
      productId: 'p1',
      name: 'Budi Santoso',
      rating: 4.5,
      comment: 'Baterai awet dipake seharian.',
      date: '1 minggu lalu',
    ),
    ReviewItem(
      id: 'r3',
      productId: 'p3',
      name: 'Siti Rahma',
      rating: 5.0,
      comment: 'Keyboardnya empuk banget pas dipake ngetik tugas.',
      date: '3 hari lalu',
    ),
  ];

  final List<OrderItem> _orders = [];

  @override
  void initState() {
    super.initState();
    _orders.addAll([
      OrderItem(
        id: 'INV-101',
        items: [CartItem(product: _products[0], quantity: 1)],
        totalHarga: 160000,
        status: 'Belum Dibayar',
        tanggal: '24/10/2026',
      ),
      OrderItem(
        id: 'INV-102',
        items: [CartItem(product: _products[1], quantity: 1)],
        totalHarga: 360000,
        status: 'Sudah Dibayar',
        tanggal: '23/10/2026',
        metodePembayaran: 'Transfer Bank (BCA)',
      ),
      OrderItem(
        id: 'INV-103',
        items: [CartItem(product: _products[4], quantity: 2)],
        totalHarga: 450000,
        status: 'Sudah Sampai',
        tanggal: '20/10/2026',
        metodePembayaran: 'QRIS / GoPay',
        nomorResi: 'JNT-8820938192',
      ),
      OrderItem(
        id: 'INV-104',
        items: [CartItem(product: _products[3], quantity: 1)],
        totalHarga: 130000,
        status: 'Pengembalian',
        tanggal: '18/10/2026',
        alasanPengembalian:
            'Barang mengalami cacat fisik (layar tergores) saat kemasan dibuka.',
      ),
    ]);
  }

  String _formatRupiah(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }

  void _tambahKeKeranjang(Product product, {int qty = 1}) {
    setState(() {
      int index = _cart.indexWhere((item) => item.product.id == product.id);
      if (index != -1) {
        _cart[index].quantity += qty;
      } else {
        _cart.add(CartItem(product: product, quantity: qty));
      }
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
ScaffoldMessenger.of(context).clearSnackBars();

ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('✅ $qty x ${product.nama} masuk ke keranjang!'),
    duration: const Duration(milliseconds: 800), // Hilang cepat 0.8 detik
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.indigo,
    dismissDirection: DismissDirection.horizontal, // Bisa di-swipe samping
  ),
);
  }

  void _bukaHalamanFavorit() {
    List<Product> favoritedProducts =
        _products.where((p) => p.isFavorite).toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.favorite, color: Colors.red),
                          const SizedBox(width: 8),
                          Text(
                            'Produk Favorit (${favoritedProducts.length})',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const Divider(),
                  if (favoritedProducts.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Center(
                        child: Text(
                          'Belum ada produk favorit ❤️\nKlik ikon hati pada produk untuk menambahkan!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 350),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: favoritedProducts.length,
                        itemBuilder: (context, index) {
                          final item = favoritedProducts[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                _bukaDetailProduk(item);
                              },
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: _buildProductImage(item.imagePath,
                                    width: 48, height: 48),
                              ),
                              title: Text(
                                item.nama,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              subtitle: Text('Rp ${_formatRupiah(item.harga)}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    color: Colors.red),
                                onPressed: () {
                                  setModalState(() {
                                    setState(() {
                                      item.isFavorite = false;
                                      item.likeCount--;
                                      favoritedProducts.removeAt(index);
                                    });
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _bukaDetailProduk(Product product) {
    int jumlahBeli = 1;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            List<ReviewItem> productReviews =
                _reviews.where((r) => r.productId == product.id).toList();

            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.85,
              maxChildSize: 0.95,
              minChildSize: 0.5,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: _buildProductImage(
                          product.imagePath,
                          width: double.infinity,
                          height: 220,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              product.nama,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              product.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color:
                                  product.isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              setModalState(() {
                                setState(() {
                                  product.isFavorite = !product.isFavorite;
                                  if (product.isFavorite) {
                                    product.likeCount++;
                                  } else {
                                    product.likeCount--;
                                  }
                                });
                              });
                            },
                          ),
                        ],
                      ),
                      Text(
                        'Rp ${_formatRupiah(product.harga)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.deskripsi,
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),
                      const Divider(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Jumlah Pembelian:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Row(
                            children: [
                              IconButton(
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.indigo.shade50,
                                ),
                                icon: const Icon(Icons.remove,
                                    color: Colors.indigo),
                                onPressed: () {
                                  if (jumlahBeli > 1) {
                                    setModalState(() {
                                      jumlahBeli--;
                                    });
                                  }
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  '$jumlahBeli',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.indigo.shade50,
                                ),
                                icon:
                                    const Icon(Icons.add, color: Colors.indigo),
                                onPressed: () {
                                  setModalState(() {
                                    jumlahBeli++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            _tambahKeKeranjang(product, qty: jumlahBeli);
                          },
                          icon: const Icon(Icons.add_shopping_cart),
                          label: Text(
                            'Tambah ke Keranjang (Rp ${_formatRupiah(product.harga * jumlahBeli)})',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                      ),
                      const Divider(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ulasan Produk (${productReviews.length})',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () {
                              _tambahUlasanDialog(product, () {
                                setModalState(() {});
                              });
                            },
                            icon: const Icon(Icons.rate_review, size: 16),
                            label: const Text('Tulis Ulasan',
                                style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (productReviews.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Belum ada ulasan untuk produk ini. Jadi yang pertama memberi ulasan!',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: productReviews.length,
                          itemBuilder: (context, idx) {
                            final rev = productReviews[idx];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(rev.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                        Text(rev.date,
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10)),
                                      ],
                                    ),
                                    Row(
                                      children: List.generate(
                                        5,
                                        (i) => Icon(
                                          i < rev.rating
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: Colors.amber,
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(rev.comment,
                                        style: const TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _tambahUlasanDialog(Product product, VoidCallback onUpdate) {
    double tempRating = 5.0;
    final commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text('Ulasan untuk ${product.nama}',
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Rating Kamu:'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < tempRating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 28,
                      ),
                      onPressed: () {
                        setDialogState(() {
                          tempRating = index + 1.0;
                        });
                      },
                    );
                  }),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: commentController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Tuliskan ulasan jujur kamu...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if (commentController.text.trim().isNotEmpty) {
                    setState(() {
                      _reviews.insert(
                        0,
                        ReviewItem(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          productId: product.id,
                          name: namaMahasiswa,
                          rating: tempRating,
                          comment: commentController.text.trim(),
                          date: 'Baru saja',
                        ),
                      );
                    });
                    onUpdate();
                    Navigator.pop(ctx);

                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ulasan berhasil dikirim!'),
                        duration: Duration(milliseconds: 1000),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                child: const Text('Kirim Ulasan'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _bukaKeranjang() {
    TextEditingController promoController =
        TextEditingController(text: _inputPromoCode);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            int subtotal = _cart.fold(
                0, (sum, item) => sum + (item.product.harga * item.quantity));
            int diskon = _isPromoApplied ? (subtotal * 0.50).round() : 0;
            int ongkir = _cart.isNotEmpty ? 10000 : 0;
            int totalBayar = (subtotal - diskon) + ongkir;

            return Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '🛒 Keranjang Belanja (${_cart.length})',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const Divider(),
                  if (_cart.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Center(
                        child: Text(
                          'Keranjang masih kosong 😅',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  else ...[
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 220),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _cart.length,
                        itemBuilder: (context, index) {
                          final item = _cart[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                _bukaDetailProduk(item.product);
                              },
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: _buildProductImage(item.product.imagePath,
                                    width: 48, height: 48),
                              ),
                              title: Text(
                                item.product.nama,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              subtitle: Text(
                                  'Rp ${_formatRupiah(item.product.harga)} x ${item.quantity}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    icon: const Icon(Icons.remove_circle,
                                        color: Colors.indigo, size: 20),
                                    onPressed: () {
                                      setModalState(() {
                                        setState(() {
                                          if (item.quantity > 1) {
                                            item.quantity--;
                                          } else {
                                            _cart.removeAt(index);
                                          }
                                        });
                                      });
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: Text('${item.quantity}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    icon: const Icon(Icons.add_circle,
                                        color: Colors.indigo, size: 20),
                                    onPressed: () {
                                      setModalState(() {
                                        setState(() {
                                          item.quantity++;
                                        });
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    icon: const Icon(Icons.delete_outline,
                                        color: Colors.red, size: 22),
                                    onPressed: () {
                                      setModalState(() {
                                        setState(() {
                                          _cart.removeAt(index);
                                        });
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: promoController,
                            textCapitalization: TextCapitalization.characters,
                            decoration: InputDecoration(
                              hintText: 'Masukkan Kode Promo ($kodePromoResmi)',
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            setModalState(() {
                              setState(() {
                                _inputPromoCode =
                                    promoController.text.trim().toUpperCase();
                                ScaffoldMessenger.of(context).clearSnackBars();
                                if (_inputPromoCode == kodePromoResmi) {
                                  _isPromoApplied = true;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          '🎉 Promo Berhasil! Diskon 50% aktif.'),
                                      duration: Duration(milliseconds: 1000),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                } else {
                                  _isPromoApplied = false;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          '❌ Kode Promo Salah! Gunakan PROMOSESI2'),
                                      duration: Duration(milliseconds: 1000),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                }
                              });
                            });
                          },
                          child: const Text('Pakai'),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal:'),
                        Text('Rp ${_formatRupiah(subtotal)}'),
                      ],
                    ),
                    if (_isPromoApplied)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Diskon Promo (50%):',
                              style: TextStyle(color: Colors.green)),
                          Text('-Rp ${_formatRupiah(diskon)}',
                              style: const TextStyle(color: Colors.green)),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Bayar:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('Rp ${_formatRupiah(totalBayar)}',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _cart.isEmpty
                            ? null
                            : () {
                                Navigator.pop(context);
                                _prosesCheckout(totalBayar, List.from(_cart));
                              },
                        child: const Text('Checkout Sekarang 🚀',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _prosesCheckout(int total, List<CartItem> purchasedItems) {
    setState(() {
      _orders.insert(
        0,
        OrderItem(
          id: 'INV-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
          items: purchasedItems,
          totalHarga: total,
          status: 'Belum Dibayar',
          tanggal: 'Hari ini',
        ),
      );
      _cart.clear();
      _isPromoApplied = false;
      _inputPromoCode = '';
    });

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Column(
          children: [
            Icon(Icons.shopping_bag_outlined, color: Colors.indigo, size: 60),
            SizedBox(height: 10),
            Text('Pesanan Dibuat!',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(
          'Pesanan telah dibuat dan masuk ke daftar "Belum Dibayar".\nTotal Tagihan: Rp ${_formatRupiah(total)}.\nSilakan klik item pesanan untuk melakukan pembayaran.',
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Lihat Pesanan'),
            ),
          ),
        ],
      ),
    );
  }

  // --- MODAL & DIALOG Aksi Status Pesanan ---
  void _tanganiKlikStatusPesanan(OrderItem ord) {
    if (ord.status == 'Belum Dibayar') {
      _tampilkanPilihanPembayaran(ord);
    } else if (ord.status == 'Sudah Dibayar') {
      _tampilkanBuktiPembayaran(ord);
    } else if (ord.status == 'Sudah Sampai') {
      _tampilkanBuktiPesananTiba(ord);
    } else if (ord.status == 'Pengembalian') {
      _tampilkanAlasanPengembalian(ord);
    }
  }

  void _tampilkanPilihanPembayaran(OrderItem ord) {
    String selectedMethod = 'Transfer Bank (BCA)';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            title: const Row(
              children: [
                Icon(Icons.payment, color: Colors.indigo),
                SizedBox(width: 8),
                Text('Pilih Metode Pembayaran',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Tagihan: Rp ${_formatRupiah(ord.totalHarga)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.indigo)),
                const SizedBox(height: 12),
                const Text('Silakan pilih cara pembayaran:',
                    style: TextStyle(fontSize: 13)),
                const SizedBox(height: 8),
                ...[
                  'Transfer Bank (BCA)',
                  'Transfer Bank (Mandiri)',
                  'QRIS / GoPay / OVO',
                  'Indomaret / Alfamart'
                ].map((method) => RadioListTile<String>(
                      title:
                          Text(method, style: const TextStyle(fontSize: 13)),
                      value: method,
                      groupValue: selectedMethod,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (val) {
                        if (val != null) {
                          setDialogState(() {
                            selectedMethod = val;
                          });
                        }
                      },
                    )),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    ord.status = 'Sudah Dibayar';
                    ord.metodePembayaran = selectedMethod;
                    _selectedOrderStatus = 'Sudah Dibayar';
                  });
                  Navigator.pop(ctx);

                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('🎉 Pembayaran berhasil via $selectedMethod!'),
                      duration: const Duration(milliseconds: 1000),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text('Bayar Sekarang'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _tampilkanBuktiPembayaran(OrderItem ord) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.receipt_long, color: Colors.green),
            SizedBox(width: 8),
            Text('Bukti Pembayaran',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 20),
                  SizedBox(width: 8),
                  Text('LUNAS / PEMBAYARAN BERHASIL',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text('No. Invoice: ${ord.id}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 13)),
            Text('Tanggal: ${ord.tanggal}',
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text('Metode Pembayaran: ${ord.metodePembayaran ?? "Transfer Bank (BCA)"}',
                style: const TextStyle(fontSize: 12)),
            const Divider(),
            const Text('Rincian Produk:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 4),
            ...ord.items.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('${item.product.nama} x${item.quantity}',
                            style: const TextStyle(fontSize: 12)),
                      ),
                      Text(
                          'Rp ${_formatRupiah(item.product.harga * item.quantity)}',
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                )),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Ditingkatkan/Dibayar:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text('Rp ${_formatRupiah(ord.totalHarga)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                        fontSize: 14)),
              ],
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo, foregroundColor: Colors.white),
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _tampilkanBuktiPesananTiba(OrderItem ord) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.local_shipping, color: Colors.blue),
            SizedBox(width: 8),
            Text('Bukti Pesanan Tiba',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.verified, color: Colors.blue, size: 20),
                  SizedBox(width: 8),
                  Text('PESANAN TELAH DITERIMA',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text('No. Invoice: ${ord.id}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 13)),
            Text('No. Resi Kurir: ${ord.nomorResi ?? "JNT-8820938192"}',
                style: const TextStyle(fontSize: 12)),
            Text('Waktu Diterima: ${ord.tanggal}',
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text('Penerima: $namaMahasiswa (Yang Bersangkutan)',
                style: const TextStyle(fontSize: 12)),
            const Divider(),
            const Text('Foto Dokumentasi Serah Terima:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 8),
            Container(
              height: 110,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.indigo.shade100),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2_outlined,
                      size: 38, color: Colors.indigo),
                  SizedBox(height: 4),
                  Text('Foto Paket Diterima dari Kurir Expedisi',
                      style: TextStyle(fontSize: 11, color: Colors.indigo)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo, foregroundColor: Colors.white),
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Selesai'),
          ),
        ],
      ),
    );
  }

  void _tampilkanAlasanPengembalian(OrderItem ord) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.assignment_return, color: Colors.red),
            SizedBox(width: 8),
            Text('Alasan Pengembalian',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.red, size: 20),
                  SizedBox(width: 8),
                  Text('STATUS: PENGEMBALIAN DISETUJUI',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 11)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text('No. Invoice: ${ord.id}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 13)),
            Text('Tanggal Pengajuan: ${ord.tanggal}',
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const Divider(),
            const Text('Alasan Kendala:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 4),
            Text(
              ord.alasanPengembalian ??
                  'Barang mengalami cacat fisik saat kemasan dibuka.',
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            const Text('Status Saldo / Refund:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const Text(
              'Pengembalian dana (Refund 100%) sebesar biaya produk telah dikreditkan kembali.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo, foregroundColor: Colors.white),
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(String imagePath,
      {double? width, double? height, BoxFit fit = BoxFit.cover}) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.indigo.shade50,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_bag_outlined, color: Colors.indigo, size: 28),
              SizedBox(height: 2),
              Text('Assets', style: TextStyle(fontSize: 9, color: Colors.indigo)),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalItemsCart = _cart.fold(0, (sum, item) => sum + item.quantity);
    int totalFavorites = _products.where((p) => p.isFavorite).length;

    List<Product> filteredProducts = _selectedCategory == 'Semua'
        ? _products
        : _products
            .where((p) => p.kategori == _selectedCategory)
            .toList();

    List<OrderItem> filteredOrders =
        _orders.where((o) => o.status == _selectedOrderStatus).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text(
    'PPM Sesi 2 - $namaMahasiswa ($nimMahasiswa)',
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14, // Ukuran teks disesuaikan agar muat rapi di layar HP
    ),
    overflow: TextOverflow.ellipsis, // Menghindari teks terpotong kasar jika layar HP kecil
  ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.favorite_border, size: 26),
                onPressed: _bukaHalamanFavorit,
              ),
              if (totalFavorites > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints:
                        const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '$totalFavorites',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, size: 26),
                onPressed: _bukaKeranjang,
              ),
              if (totalItemsCart > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    constraints:
                        const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '$totalItemsCart',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileCardWidget(
              nama: namaMahasiswa,
              nim: nimMahasiswa,
              prodiKelas: prodiKelasMahasiswa,
            ),
            const SizedBox(height: 16),
            const PromoBannerWidget(),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📦 Status Pesanan Saya',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          'Belum Dibayar',
                          'Sudah Dibayar',
                          'Sudah Sampai',
                          'Pengembalian'
                        ].map((status) {
                          bool isSel = _selectedOrderStatus == status;
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: ChoiceChip(
                              label: Text(status,
                                  style: const TextStyle(fontSize: 11)),
                              selected: isSel,
                              selectedColor: Colors.indigo,
                              labelStyle: TextStyle(
                                  color: isSel ? Colors.white : Colors.black87),
                              onSelected: (val) {
                                setState(() {
                                  _selectedOrderStatus = status;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const Divider(),
                    if (filteredOrders.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: Text('Tidak ada pesanan di kategori ini.',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12)),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredOrders.length,
                        itemBuilder: (ctx, i) {
                          final ord = filteredOrders[i];
                          return InkWell(
                            onTap: () => _tanganiKlikStatusPesanan(ord),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.indigo.shade50.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.indigo.shade100),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${ord.id} • ${ord.tanggal}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11)),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${ord.items.length} Barang - Rp ${_formatRupiah(ord.totalHarga)}',
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 11),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Tekan untuk lihat detail / aksi ➔',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.indigo,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: ord.status == 'Sudah Sampai'
                                          ? Colors.green.shade100
                                          : ord.status == 'Belum Dibayar'
                                              ? Colors.orange.shade100
                                              : ord.status == 'Pengembalian'
                                                  ? Colors.red.shade100
                                                  : Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      ord.status,
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Kategori Produk',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  'Semua',
                  'Aksesoris',
                  'Gadget',
                  'Elektronik',
                  'Fashion'
                ].map((category) {
                  bool isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      selectedColor: Colors.indigo,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Daftar Produk (${filteredProducts.length})',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final prod = filteredProducts[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => _bukaDetailProduk(prod),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: _buildProductImage(prod.imagePath,
                                width: 90, height: 90),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.indigo.shade50,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    prod.kategori,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  prod.nama,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Text(
                                  prod.deskripsi,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 11),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Rp ${_formatRupiah(prod.harga)}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: Icon(
                                            prod.isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: prod.isFavorite
                                                ? Colors.red
                                                : Colors.grey,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              prod.isFavorite =
                                                  !prod.isFavorite;
                                              if (prod.isFavorite) {
                                                prod.likeCount++;
                                              } else {
                                                prod.likeCount--;
                                              }
                                            });
                                          },
                                        ),
                                        const SizedBox(width: 4),
                                        Text('${prod.likeCount}',
                                            style:
                                                const TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.indigo,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: () => _bukaDetailProduk(prod),
                                        icon: const Icon(Icons.tune, size: 16),
                                        label: const Text('Detail & Beli',
                                            style: TextStyle(fontSize: 11)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCardWidget extends StatelessWidget {
  final String nama;
  final String nim;
  final String prodiKelas;

  const ProfileCardWidget({
    super.key,
    required this.nama,
    required this.nim,
    required this.prodiKelas,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 34,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 31,
                backgroundImage: AssetImage('assets/Pp.jpeg'),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          nama,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.verified,
                          color: Colors.blueAccent, size: 16),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text('NIM: $nim',
                      style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                  Text(prodiKelas,
                      style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(
                      5,
                      (_) => const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PromoBannerWidget extends StatelessWidget {
  const PromoBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.indigo, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Positioned(
            right: -10,
            bottom: -15,
            child: Icon(
              Icons.local_offer_rounded,
              size: 100,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          const Positioned(
            left: 16,
            top: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PROMO SPESIAL SESI 2 🏷️',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Gunakan Kode Promo:',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
                SizedBox(height: 2),
                Text(
                  kodePromoResmi,
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 12,
            top: 12,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '-50%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}