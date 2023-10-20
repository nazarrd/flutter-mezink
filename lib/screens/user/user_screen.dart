import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../extension/screen_util.dart';
import '../../providers/user_provider.dart';
import '../../widgets/button_default.dart';
import '../../widgets/dialog_default.dart';
import '../../widgets/dropdown_default.dart';
import '../../widgets/textfield_default.dart';
import 'user_data_widget.dart';
import 'user_form_widget.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    context.read<UserProvider>().initialized(this);
    super.initState();
  }

  void _updatePage(int newPage) {
    if (newPage >= 1 && newPage <= context.read<UserProvider>().totalPages) {
      context.read<UserProvider>().currentPage = newPage;
      if (context.read<UserProvider>().isLast) {
        context.read<UserProvider>().getUserData();
      } else {
        context.read<UserProvider>().paginateData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F3),
      body: LayoutBuilder(builder: (context, constraints) {
        // listen to screen change
        globalWidth = constraints.maxWidth;
        globalHeight = constraints.maxHeight;

        return Container(
          width: 100.w,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                offset: Offset(0, 3),
                color: Colors.grey,
              ),
            ],
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Center(
              child: Text(
                'Influencer Directory',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                (
                  key: provider.engagement,
                  title: 'Engagement',
                  items: ['<25%', '25-50%', '50-75%', '>75%']
                ),
                (
                  key: provider.hashtags,
                  title: 'Hashtags',
                  items:
                      provider.allListUser!.map((e) => (e.hashtags!)).toList(),
                ),
                (
                  key: provider.followers,
                  title: 'Followers',
                  items: ['<50k', '50k-100k', '100k-500k', '>500k']
                ),
                (
                  key: provider.platform,
                  title: 'Platform',
                  items: ['Facebook', 'Instagram', 'Tiktok', 'Twitter']
                ),
                (
                  key: provider.gender,
                  title: 'Gender',
                  items: ['Male', 'Female']
                ),
                (
                  key: provider.country,
                  title: 'Country',
                  items: ['Indonesia', 'Singapore']
                ),
              ].map((e) {
                return DropdownDefault(
                  hintText: e.title,
                  data: e.items,
                  selected: e.key,
                  onChanged: (value) => provider.filterData(e.title, value),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: () => provider.clearValue(),
              child: const Text(
                'Clear All',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(children: [
              SizedBox(
                width: 20.w,
                child: TextFieldDefault(
                  hintText: 'Search',
                  controller: provider.searchController,
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (value) => provider.filterData(null, value),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.search),
                  ),
                  suffixIcon: Visibility(
                    visible: provider.searchController.text.isNotEmpty,
                    child: InkWell(
                      onTap: () => provider.clearValue(clearAll: false),
                      child: const Icon(Icons.clear),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              ButtonDefault(
                'Refresh Data',
                onPressed: () => provider.getUserData(reset: true),
              ),
              const SizedBox(width: 10),
              ButtonDefault(
                'Add Influencer',
                onPressed: () =>
                    dialogDefault(context, child: const UserFormWidget()),
              ),
            ]),
            const SizedBox(height: 16),
            UserDataWidget(provider.searchMode
                ? provider.filteredUser
                : provider.listUser),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _PaginationIcon(
                  icon: Icons.keyboard_arrow_left,
                  active: provider.currentPage > 1,
                  onTap: () => _updatePage(provider.currentPage - 1),
                ),
                const SizedBox(width: 10),
                Text('Page ${provider.currentPage} of ${provider.totalPages}'),
                const SizedBox(width: 10),
                _PaginationIcon(
                  icon: Icons.keyboard_arrow_right,
                  active: provider.currentPage < provider.totalPages,
                  onTap: () => _updatePage(provider.currentPage + 1),
                ),
              ],
            ),
          ]),
        );
      }),
    );
  }
}

class _PaginationIcon extends StatelessWidget {
  const _PaginationIcon({
    required this.icon,
    required this.onTap,
    this.active = true,
  });

  final IconData icon;
  final Function() onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: active ? onTap : null,
      child: Icon(icon, size: 20, color: active ? Colors.black : Colors.grey),
    );
  }
}
