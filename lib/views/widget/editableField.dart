import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../utils/appTheme.dart';

Widget buildLabeledRow({
  required String label,
  required String value,
  required String fieldKey,
  required void Function(String fieldKey, String currentValue) onEdit,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
        ),
      ),
      SizedBox(height: 10),
      Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 3),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.textSecondary, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                value,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
              ),
            ),
            IconButton(
              onPressed: () => onEdit(fieldKey, value),
              icon: Icon(
                Icons.lock_open_outlined,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
