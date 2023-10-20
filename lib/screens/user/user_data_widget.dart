import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../extension/screen_util.dart';
import '../../models/user_model.dart';
import '../../providers/user_provider.dart';
import '../../widgets/button_default.dart';
import '../../widgets/checkbox_default.dart';
import '../../widgets/dialog_default.dart';
import 'user_form_widget.dart';

class UserDataWidget extends StatefulWidget {
  const UserDataWidget(this.data, {super.key});

  final List<UserData>? data;

  @override
  State<UserDataWidget> createState() => _UserDataWidgetState();
}

class _UserDataWidgetState extends State<UserDataWidget> {
  bool sortAscending = true;
  int? sortColumnIndex;
  late int dataLength;
  late List<bool> selected;

  void _sort<T>(Comparable<T> Function(UserData d) getField, int columnIndex,
      bool ascending) {
    context.read<UserProvider>().sort<T>(getField, ascending);
    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    dataLength = widget.data?.length ?? 0;
    selected = List.generate(dataLength, (int _) => false);
    return StatefulBuilder(builder: (context, update) {
      return Expanded(
        child: Stack(children: [
          DataTable2(
            dataTextStyle: const TextStyle(fontSize: 13),
            sortColumnIndex: sortColumnIndex,
            sortAscending: sortAscending,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey, width: .5),
            ),
            empty: Visibility(
              visible: context.read<UserProvider>().isLoading != true,
              child: const Center(
                child: Text(
                  'No Data',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            columns: [
              DataColumn2(
                fixedWidth: 15.w,
                label: Row(
                  children: [
                    CheckBoxDefault(
                      selected:
                          context.read<UserProvider>().isLoading != true &&
                              !selected.contains(false),
                      onChanged: (value) {
                        update(() => selected =
                            List.generate(dataLength, (int _) => value!));
                      },
                    ),
                    const SizedBox(width: 8),
                    const _ColumnTitle('Influencer Name'),
                  ],
                ),
                onSort: (columnIndex, ascending) => _sort<String>(
                    (d) => '${d.firstName}', columnIndex, ascending),
              ),
              DataColumn2(
                fixedWidth: 10.w,
                label: const _ColumnTitle('Grade'),
                onSort: (columnIndex, ascending) =>
                    _sort<String>((d) => '${d.grade}', columnIndex, ascending),
              ),
              DataColumn2(
                fixedWidth: 10.w,
                label: const _ColumnTitle('Followers'),
                onSort: (columnIndex, ascending) => _sort<String>(
                    (d) => '${d.followers}', columnIndex, ascending),
              ),
              DataColumn2(
                label: const _ColumnTitle('Engagement Rate'),
                onSort: (columnIndex, ascending) => _sort<String>(
                    (d) => '${d.engagement}', columnIndex, ascending),
              ),
              DataColumn2(
                label: const _ColumnTitle('Tags'),
                onSort: (columnIndex, ascending) =>
                    _sort<String>((d) => '${d.tags}', columnIndex, ascending),
              ),
              DataColumn2(
                fixedWidth: 11.w,
                label: const _ColumnTitle('Hashtags'),
                onSort: (columnIndex, ascending) => _sort<String>(
                    (d) => '${d.hashtags}', columnIndex, ascending),
              ),
              DataColumn2(
                fixedWidth: 20.w,
                label: const _ColumnTitle('Action'),
              ),
            ],
            rows: List<DataRow>.generate(dataLength, (int index) {
              final item = widget.data![index];
              return DataRow(cells: [
                DataCell(Row(
                  children: [
                    CheckBoxDefault(
                      selected: selected[index],
                      onChanged: (value) {
                        update(() => selected[index] = value!);
                      },
                    ),
                    const SizedBox(width: 8),
                    Stack(alignment: Alignment.bottomRight, children: [
                      if (item.tempImage == null)
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                            item.avatar ?? 'https://picsum.photos/100',
                          ),
                        )
                      else
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: MemoryImage(item.tempImage!),
                        ),
                      const CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.facebook,
                          size: 10,
                          color: Colors.blue,
                        ),
                      ),
                    ]),
                    const SizedBox(width: 8),
                    Text('${item.firstName} ${item.lastName}'),
                  ],
                )),
                DataCell(
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('${item.grade}', style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 8),
                    const CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.check, size: 10, color: Colors.white),
                    ),
                  ]),
                ),
                DataCell(Center(child: Text('${item.followers}'))),
                DataCell(Center(child: Text('${item.engagement}'))),
                DataCell(Center(child: Text(item.tags ?? 'No Tags'))),
                DataCell(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(item.hashtags ?? 'No Hashtgas'),
                    if (item.hashtags != null) ...[
                      const SizedBox(height: 4),
                      const Text(
                        'More',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    const Spacer(),
                  ],
                )),
                DataCell(Center(
                  child: Wrap(
                    spacing: 15,
                    children: [
                      (
                        icon: Icons.remove_red_eye,
                        onTap: () => dialogDefault(context,
                            child: UserFormWidget(data: item, readOnly: true))
                      ),
                      (
                        icon: Icons.edit,
                        onTap: () => dialogDefault(context,
                            child: UserFormWidget(data: item))
                      ),
                      (
                        icon: Icons.delete_outline,
                        onTap: () {
                          dialogDefault(
                            context,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Are you sure want to delete this data?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  ButtonDefault(
                                    'Cancel',
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                  const SizedBox(width: 10),
                                  ButtonDefault(
                                    'Delete',
                                    fillColor: AppColors.primary,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      context
                                          .read<UserProvider>()
                                          .deleteUserData(item.id);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ]),
                              ],
                            ),
                          );
                        }
                      ),
                    ].map((e) {
                      return InkWell(
                        onTap: e.onTap,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Icon(
                          e.icon,
                          size: 18,
                          color: Colors.grey,
                        ),
                      );
                    }).toList(),
                  ),
                )),
              ]);
            }).toList(),
          ),
          if (context.read<UserProvider>().isLoading == true)
            const Center(child: CircularProgressIndicator())
        ]),
      );
    });
  }
}

class _ColumnTitle extends StatelessWidget {
  const _ColumnTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
