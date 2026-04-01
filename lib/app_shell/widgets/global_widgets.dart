import 'package:flutter/material.dart';
import 'package:zi_core/zi_core_io.dart';

// ignore: must_be_immutable
class GlobalWidgets extends StatelessWidget {
  GlobalWidgets({super.key});
  List<SectionDivider> widgetsList = [
    SectionDivider(label: "Category Tile", isComplete: true),
    SectionDivider(label: "Service Tile", isComplete: true),
    SectionDivider(label: "Sale Tile", isComplete: true),
    SectionDivider(label: "Staff Tile", isComplete: true),
    SectionDivider(label: "Customer Tile", isComplete: true),
    SectionDivider(label: "Appointment", isComplete: true),
  ];
  @override
  Widget build(BuildContext context) {
    return ZiScaffoldB(
      body: ListView(
        children: [
          getWidgetName(0),
          InkWell(
            splashColor: ZiColors.accent,
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: ZiColors.border)),
              ),
              child: Row(
                children: [
                  Icon(Icons.category, size: 22, color: ZiColors.primary),
                  ziGap(12),
                  Expanded(
                    child: Text("Category Tile", style: ZiTypoStyles.titleMd),
                  ),
                  // ZiChip(label: "1,000"),
                  IconButton(
                    icon: Icon(
                      Icons.more_vert_rounded,
                      color: ZiColors.grayLight,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          getWidgetName(1),
          InkWell(
            splashColor: ZiColors.accent,
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: ZiColors.border)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Service Tile",
                                style: ZiTypoStyles.titleMd,
                              ),
                            ),
                          ],
                        ),
                        ziGap(4),
                        Row(
                          children: [
                            Icon(
                              Icons.category,
                              size: 16,
                              color: ZiColors.grayLight,
                            ),
                            ziGap(8),
                            Text("Category", style: ZiTypoStyles.caption),
                            Spacer(),
                            Text("10,000", style: ZiTypoStyles.titleSm),
                            ziGap(10),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_vert_rounded,
                      color: ZiColors.grayLight,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          getWidgetName(2),
          InkWell(
            splashColor: ZiColors.accent,
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: ZiColors.border)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Sales Tile",
                                style: ZiTypoStyles.titleMd,
                              ),
                            ),
                            Text("12 Items", style: ZiTypoStyles.caption),
                          ],
                        ),
                        // ziGap(4),
                        // Text(
                        //   "Comment or Text here, Comment or Text here, Comment or Text here",
                        //   style: ZiTypoStyles.bodyMedium.copyWith(
                        //     color: ZiColors.text,
                        //   ),
                        // ),
                        ziGap(4),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: ZiColors.grayLight,
                            ),
                            ziGap(6),
                            Text("9 Oct - 9:30am", style: ZiTypoStyles.caption),
                            Spacer(),
                            Text(
                              "10,000",
                              style: ZiTypoStyles.titleSm.copyWith(
                                color: ZiColors.gainG,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // ziGap(10),
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.more_vert_rounded,
                  //     color: ZiColors.grayLight,
                  //   ),
                  //   onPressed: () {},
                  // ),
                ],
              ),
            ),
          ),

          getWidgetName(3),
          InkWell(
            splashColor: ZiColors.accent,
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: ZiColors.border)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Staff Tile", style: ZiTypoStyles.titleMd),
                        Text("0342 4264494", style: ZiTypoStyles.bodyMedium),
                        ziGap(6),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: ZiColors.grayLight,
                            ),
                            ziGap(4),
                            Text("Address", style: ZiTypoStyles.caption),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.call, color: ZiColors.gray),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.message, color: ZiColors.gainG),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          getWidgetName(4),
          InkWell(
            splashColor: ZiColors.accent,
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: ZiColors.border)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Customer Tile", style: ZiTypoStyles.titleMd),
                        Text("0342 4264494", style: ZiTypoStyles.bodyMedium),
                        ziGap(6),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: ZiColors.grayLight,
                            ),
                            ziGap(4),
                            Text("Address", style: ZiTypoStyles.caption),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.call, color: ZiColors.gray),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.message, color: ZiColors.gainG),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          getWidgetName(5),
          InkWell(
            splashColor: ZiColors.accent,
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: ZiColors.border)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Appointment Tile",
                              style: ZiTypoStyles.titleMd,
                            ),
                            Text(
                              "Service info",
                              style: ZiTypoStyles.bodyMedium,
                            ),
                            ziGap(6),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: ZiColors.grayLight,
                                ),
                                ziGap(6),
                                Text(
                                  "9 Oct - 9:30am",
                                  style: ZiTypoStyles.caption,
                                ),
                                Spacer(),
                                Text(
                                  "10,000",
                                  style: ZiTypoStyles.titleSm.copyWith(
                                    color: ZiColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ziGap(8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(Icons.call, color: ZiColors.gray),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.message, color: ZiColors.gainG),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Refer Name",
                        style: ZiTypoStyles.titleMd.copyWith(
                          color: ZiColors.text,
                        ),
                      ),
                      ZiChip(
                        label: "pending",
                        themeTone: ZiColors.debugRed,
                        isActive: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          SectionDivider(label: "InApp"),
          ziGap(180),
        ],
      ),
    );
  }

  Widget getWidgetName(int index) {
    return SectionDivider(
      label: widgetsList[index].label,
      isComplete: widgetsList[index].isComplete,
    );
  }
}
