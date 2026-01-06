import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/blog_model.dart';
import '../../../../services/blog_repository.dart';
import '../../widgets/blog_card.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_text.dart';
import '../blog/bloc/blog_bloc.dart';
import '../blog/bloc/blog_event.dart';
import '../blog/bloc/blog_state.dart';

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  int _getCrossAxisCount(double width) {
    if (width >= 1200) return 3;
    if (width >= 800) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return BlocProvider(
      create: (_) => BlogBloc(BlogRepository())..add(const FetchBlogs(page: 1)),
      child: Container(
        width: double.infinity,
        color: Colors.black,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 120,
          vertical: 90,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(
              text: "Our Blogs",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            CustomText(
              text: "Stay updated with the latest trends and insights.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.grey.shade400),
            ),
            const SizedBox(height: 60),

            // ───────────────── BLOG CONTENT ─────────────────
            BlocBuilder<BlogBloc, BlogState>(
              builder: (context, state) {
                // 🔹 Loading
                if (state.listStatus == BlogStatus.loading) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                // 🔹 Error
                if (state.listStatus == BlogStatus.failure) {
                  return _EmptyState(
                    title: "Unable to load blogs",
                    subtitle: "Please try again later.",
                  );
                }

                // 🔹 Empty
                if (state.blogs.isEmpty) {
                  return const _EmptyState(
                    title: "No blogs yet",
                    subtitle:
                        "We’re working on fresh content. Check back soon.",
                  );
                }

                // 🔹 Success → show only latest 3 blogs
                final List<BlogModel> latestBlogs =
                    state.blogs.take(3).toList();

                return Column(
                  children: [
                    GridView.builder(
                      addRepaintBoundaries: true,
                      addSemanticIndexes: true,
                      addAutomaticKeepAlives: true,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: latestBlogs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _getCrossAxisCount(width),
                        crossAxisSpacing: 28,
                        mainAxisSpacing: 28,
                        childAspectRatio: 0.78,
                      ),
                      itemBuilder: (context, index) {
                        final blog = latestBlogs[index];
                        return RepaintBoundary(
                          child: BlogCard(
                            blog: blog,
                            onTap:
                                () =>
                                    context.go('/blog/${blog.id}', extra: blog),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 60),

                    AppButton(
                      text: "Explore More",
                      onPressed: () => context.go('/blog'),
                      type: AppButtonType.solid,
                      color: Theme.of(context).colorScheme.primary,
                      textColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 18,
                      ),
                      enableGlow: true,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;

  const _EmptyState({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          Icon(Icons.article_outlined, size: 72, color: Colors.grey.shade600),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
