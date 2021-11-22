import 'package:flutter/material.dart';
import 'package:siapjulka/constant/pallete_color.dart';
import 'package:siapjulka/models/seksi.dart';

class SeksiWidget extends StatelessWidget {
  const SeksiWidget(this.seksi, {Key? key}) : super(key: key);
  final Seksi seksi;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              seksi.kodeSeksi!,
              maxLines: 1,
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: Pallete.primaryColor),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Text(
              seksi.namaMk!,
              maxLines: 3,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black54),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.account_box_sharp,
                  color: Pallete.primaryColor,
                  size: 16,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    seksi.namaDosen!,
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_sharp,
                  color: Pallete.primaryColor,
                  size: 16,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    seksi.hari! +
                        ' (' +
                        seksi.jadwalMulai! +
                        '-' +
                        seksi.jadwalSelesai! +
                        ')',
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Pallete.primaryColor,
                  size: 16,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    seksi.kodeRuang!,
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
