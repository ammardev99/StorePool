import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

class HoldCart extends StatelessWidget {
  const HoldCart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          /// Header
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFEFEEEE),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Carts",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),

                Icon(Icons.add, size: 18, color: Colors.pink),
              ],
            ),
          ),

          // SizedBox(height: 14),
          ziGap(7),

          /// List
          Expanded(
            child: ListView(
              children: [
                cartItem(),
                cartItem(),
                cartItem(),
                cartItem(),
                cartItem(),
                cartItem(),
                cartItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cartItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Color(0xFFF8E1E7)),
      ),
      child: Row(
        children: [
          /// Left Icon
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              // color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 18,
              color: Colors.pink,
            ),
          ),

          ziGap(12),

          /// Divider (Like Image)
          Container(height: 50, width: 1, color: Colors.grey.shade300),

          ziGap(12),

          /// Center Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "# 4115623",
                  style: ZiTypoStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                ziGap(4),

                Text(
                  "Info here",
                  style: ZiTypoStyles.bodyMedium.copyWith(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),

                ziGap(6),

                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 14),

                    // ziGap(width: 4),
                    ziGap(4),
                    Text(
                      "9 Oct",
                      style: ZiTypoStyles.bodyMedium.copyWith(
                        color: Colors.grey,
                      ),
                    ),

                    // SizedBox(width: 10),
                    ziGap(10),

                    Icon(Icons.access_time, size: 14),

                    // SizedBox(width: 4),
                    ziGap(4),

                    Text(
                      "9:00 AM",
                      style: ZiTypoStyles.bodyMedium.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: 10),

          /// Right Side
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.delete, color: Colors.red, size: 18),

              SizedBox(height: 6),

              Text(
                "12 Items",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),

              SizedBox(height: 4),

              Text(
                "Rs. 25,000",
                style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
