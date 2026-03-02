import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/dummy_constants.dart';
import 'package:fennac_app/app/theme/app_colors.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/models/dummy/faq_item_model.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/widgets/custom_search_field.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';

import '../../../../app/constants/media_query_constants.dart';

@RoutePage()
class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<FaqItem> _filteredItems;

  @override
  void initState() {
    super.initState();
    _filteredItems = DummyConstants.faqItems;
    _searchController.addListener(_filterFaq);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterFaq() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredItems = DummyConstants.faqItems;
      } else {
        _filteredItems = DummyConstants.faqItems
            .where(
              (item) =>
                  item.question.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ) ||
                  item.answer.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovableBackground(
        backgroundType: MovableBackgroundType.dark,
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(title: 'Frequently Asked Questions'),
              const SizedBox(height: 16),

              CustomSearchField(
                controller: _searchController,
                hintText: 'Search FAQs',
              ),

              const SizedBox(height: 16),
              Expanded(
                child: _filteredItems.isEmpty
                    ? Center(
                        child: Text(
                          'No FAQs found',
                          style: AppTextStyles.description(context),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          return FaqTile(item: _filteredItems[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FaqTile extends StatefulWidget {
  final FaqItem item;

  const FaqTile({required this.item, super.key});

  @override
  State<FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<FaqTile> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heightAnimation = Tween<double>(begin: 72, end: 162).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.item.isExpanded = !widget.item.isExpanded;
            if (widget.item.isExpanded) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
          });
        },
        child: AnimatedBuilder(
          animation: _heightAnimation,
          builder: (context, child) {
            return Container(
              height: _heightAnimation.value,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: widget.item.isExpanded
                    ? null
                    : Border(
                        top: BorderSide(color: ColorPalette.grey, width: 1),
                        bottom: BorderSide(color: ColorPalette.grey, width: 1),
                      ),
                color: widget.item.isExpanded && isDarkTheme(context)
                    ? ColorPalette.secondary.withValues(alpha: 0.75)
                    : widget.item.isExpanded
                    ? ColorPalette.textGrey
                    : Colors.transparent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.item.question,
                          style: AppTextStyles.description(context).copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isLightTheme(context)
                                ? ColorPalette.black
                                : ColorPalette.textSecondary,
                          ),
                          maxLines: widget.item.isExpanded ? 3 : 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      AnimatedRotation(
                        turns: widget.item.isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: Icon(
                          Icons.expand_more,
                          color: ColorPalette.textSecondary,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  if (widget.item.isExpanded) ...[
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          widget.item.answer,
                          style: AppTextStyles.description(context).copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: isLightTheme(context)
                                ? ColorPalette.black
                                : ColorPalette.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
