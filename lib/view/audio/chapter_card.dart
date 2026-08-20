import 'package:flutter/material.dart';

class ChapterCard extends StatelessWidget {
  final String number;
  final String title;
  final String verses;
  final VoidCallback? onTap;

  const ChapterCard({
    super.key,
    required this.number,
    required this.title,
    required this.verses,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: const Color(0xff1A2E4F),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xffD4AF37).withOpacity(0.3),
            )
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xff223A61),
                borderRadius: BorderRadius.circular(12),
                border:  Border.all(
                  color:  const Color(0xffD4AF37).withOpacity(0.3),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                number,
                style:TextStyle(
                  color: Color(0xffD4AF37),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 15),

            Expanded(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 6),

                    Row(
                      children: [
                        Icon(Icons.menu_book,
                          size: 14,
                          color: Color(0xffD4AF37),
                        ),

                        SizedBox(width: 4),

                        Text(
                          verses,
                          style:TextStyle(
                            color: Color(0xffD4AF37),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            ),

            Icon(
              Icons.arrow_forward_ios_sharp,
              color: Color(0xffD4AF37),
              size: 24,)
          ],
        ),
      ),
    );
  }
}