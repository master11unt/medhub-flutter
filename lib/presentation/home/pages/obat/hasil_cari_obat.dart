import 'package:flutter/material.dart';

class HasilCariObat extends StatelessWidget {
  final List<Map<String, String>> medicines = [
    {
      "name": "Lameson 4 mg Tablet",
      "price": "Rp 6.238,-",
      "unit": "Tablet",
      "image": "assets/images/lameson.png",
      "symbol": "red",
    },
  ];

  Color getSymbolColor(String symbol) {
    switch (symbol) {
      case "blue":
        return Colors.blue;
      case "red":
        return Colors.red;
      case "yellow":
        return Colors.yellow;
      case "green":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Cari Obat", style: TextStyle(color: Colors.teal)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5), // Abu muda
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari Obat",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: medicines.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 230,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final item = medicines[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFFE0E0E0), // Warna abu muda
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Align(
                          //   alignment: Alignment.topRight,
                          //   child: CircleAvatar(
                          //     backgroundColor: getSymbolColor(item['symbol']!),
                          //     radius: 12,
                          //     child:
                          //         item['symbol'] == "red"
                          //             ? Text(
                          //               "K",
                          //               style: TextStyle(
                          //                 fontWeight: FontWeight.bold,
                          //                 color: Colors.white,
                          //                 fontSize: 12,
                          //               ),
                          //             )
                          //             : null,
                          //   ),
                          // ),
                          SizedBox(height: 4),
                          Expanded(
                            child: Center(
                              child: Image.asset(
                                item['image']!,
                                height: 60,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            item['name']!,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text("per ${item['unit']}"),
                          Text(
                            "${item['price']} / ${item['unit']}",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
