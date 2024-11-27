import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proker/gen/assets.gen.dart';
import 'package:proker/src/core/config/injection/injectable.dart';
import 'package:proker/src/core/config/router/app_router.dart';
import 'package:proker/src/core/config/themes/app_colors.dart';
import 'package:proker/src/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:proker/src/features/home/presentation/bloc/home_cubit.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const CustomSliverAppBar(),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state is HomeInitial) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is HomeLoaded) {
                          return BannerWidget(banners: state.banners);
                        } else if (state is HomeError) {
                          return const Center(
                              child: Text('Error loading banners'));
                        }
                        return Container();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.w(25)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.h(20)),
                          const SearchBarWidget(),
                          SizedBox(height: context.h(20)),
                          const CategoriesWidget(),
                          SizedBox(height: context.h(20)),
                        ],
                      ),
                    ),
                    _buildSectionTitle(context, "Event Terpopuler"),
                    const EventListWidget(),
                    _buildSectionTitle(context, "Upcoming Event"),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.w(25)),
                      child: const UpcomingEventListWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build section titles
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.w(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: context.sp(18), fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {},
            child: Text("View All",
                style: TextStyle(
                    color: const Color(0xFF04339B), fontSize: context.sp(14))),
          ),
        ],
      ),
    );
  }
}

class BannerWidget extends StatelessWidget {
  final List<String> banners;

  const BannerWidget({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.h(150),
      width: double.infinity,
      margin: EdgeInsets.only(top: context.h(25)),
      child: CarouselSlider.builder(
        itemCount: banners.length,
        itemBuilder: (context, index, realIndex) {
          return _buildBannerItem(context, banners[index]);
        },
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          onPageChanged: (index, reason) {},
        ),
      ),
    );
  }

  // Helper method to build individual banner items
  Widget _buildBannerItem(BuildContext context, String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(context.r(10)),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) =>
            const Center(child: Icon(Icons.error)),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              width: context.w(250),
              height: context.h(50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(context.r(12)),
                border: Border.all(width: 1.5, color: const Color(0xFFD6D2D2)),
              ),
              padding: EdgeInsets.symmetric(horizontal: context.w(12)),
              child: Row(
                children: [
                  Assets.icons.icSearch.svg(
                    width: context.w(20),
                    height: context.h(20),
                    colorFilter:
                        ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                  ),
                  SizedBox(width: context.w(8)),
                  Text(
                    "Cari Event",
                    style: TextStyle(
                      color: const Color(0xFFD6D2D2),
                      fontWeight: FontWeight.w400,
                      fontSize: context.sp(16),
                      letterSpacing: .8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: context.w(8)),
        InkWell(
          onTap: () {},
          child: Container(
            height: context.h(50),
            padding: EdgeInsets.all(context.i(12)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(context.r(12)),
              border: Border.all(width: 1.5, color: const Color(0xFFD6D2D2)),
            ),
            child: Assets.icons.icFilter.svg(
              width: context.w(22),
              height: context.h(16),
              colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }
}

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {"title": "Wirus", "icon": Icons.monetization_on},
      {"title": "Luhim", "icon": Icons.group},
      {"title": "Senor", "icon": Icons.headphones},
      {"title": "Rohis", "icon": Icons.mosque},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((category) {
        return _buildCategoryItem(
            context, category['title'] as String, category['icon'] as IconData);
      }).toList(),
    );
  }

  // Helper method to build individual category items
  Widget _buildCategoryItem(BuildContext context, String title, IconData icon) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(context.r(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: context.r(4),
                offset: Offset(0, context.h(4)),
              ),
            ],
          ),
          padding: EdgeInsets.all(context.i(14)),
          child: Icon(icon, color: AppColors.primary, size: context.sp(38)),
        ),
        SizedBox(height: context.h(8)),
        Text(title,
            style: TextStyle(
                fontSize: context.sp(14), fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class EventListWidget extends StatelessWidget {
  const EventListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(4, (index) {
          return Padding(
            padding: EdgeInsets.only(
                left: index == 0 ? context.w(25) : 0, right: context.w(20)),
            child: const EventCardWidget(),
          );
        }),
      ),
    );
  }
}

class EventCardWidget extends StatelessWidget {
  const EventCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.h(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.r(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: context.r(4),
            offset: Offset(0, context.h(4)),
          ),
        ],
      ),
      width: context.w(220),
      child: InkWell(
        onTap: () async {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(context.r(10)),
                topRight: Radius.circular(context.r(10)),
              ),
              child: Image.network(
                'https://picsum.photos/200/300',
                height: context.h(120),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.w(8),
                vertical: context.h(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: context.h(8)),
                    child: Wrap(
                      spacing: context.w(4),
                      children: _buildTags(
                          context, ["Kompetisi", "Peminatan", "Game"]),
                    ),
                  ),
                  SizedBox(height: context.h(8)),
                  Text(
                    "Himakom E-sport Championship",
                    style: TextStyle(
                        fontSize: context.sp(16), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: context.h(4)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.w(8),
                      vertical: context.h(4),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffffc333),
                      borderRadius: BorderRadius.circular(context.r(4)),
                    ),
                    child: Text(
                      "Proses Pengajuan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: context.sp(12),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: context.h(8)),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        children: [
                          Icon(Icons.group, size: context.sp(23)),
                          SizedBox(width: context.w(6)),
                          Flexible(
                            child: Text("Menyalurkan bakat di bidang e-Sport",
                                overflow: TextOverflow.ellipsis,
                                maxLines: constraints.maxWidth < 200 ? 1 : 2,
                                style: TextStyle(fontSize: context.sp(12))),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: context.h(8)),
                  Row(
                    children: [
                      Icon(Icons.thumb_up_alt_outlined, size: context.sp(23)),
                      SizedBox(width: context.w(6)),
                      const Text("457 Upvote"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UpcomingEventListWidget extends StatelessWidget {
  const UpcomingEventListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(4, (index) {
          return const UpcomingEventCard();
        }),
      ),
    );
  }
}

class UpcomingEventCard extends StatelessWidget {
  const UpcomingEventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.h(150),
      margin: EdgeInsets.only(right: context.w(10), bottom: context.h(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.r(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: context.r(4),
            offset: Offset(0, context.h(4)),
          ),
        ],
      ),
      child: InkWell(
        onTap: () async {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(context.r(10)),
                bottomLeft: Radius.circular(context.r(10)),
              ),
              child: Image.network(
                'https://picsum.photos/200/300?random=1',
                fit: BoxFit.cover,
                width: context.w(140),
                height: context.h(150),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(context.i(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      spacing: context.w(4),
                      runSpacing: context.h(4),
                      children: _buildTags(
                          context, ["Kompetisi", "Peminatan", "Game"]),
                    ),
                    Text(
                      "Himakom E-sport Championship",
                      style: TextStyle(
                        fontSize: context.sp(14),
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: context.sp(16)),
                        SizedBox(width: context.w(4)),
                        Expanded(
                          child: Text(
                            "Jum'at",
                            style: TextStyle(fontSize: context.sp(11)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.person, size: context.sp(16)),
                        SizedBox(width: context.w(4)),
                        Expanded(
                          child: Text(
                            "Pengembangan SDM",
                            style: TextStyle(fontSize: context.sp(11)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.thumb_up_alt_outlined, size: context.sp(16)),
                        SizedBox(width: context.w(4)),
                        Text(
                          "457 Upvote",
                          style: TextStyle(fontSize: context.sp(11)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: AppColors.primary,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: EdgeInsets.only(left: context.w(25), top: context.h(60)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "HIMAKOM EVENTS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: context.sp(24),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(context.h(85)),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticatedState) {
              final user = state.data;
              return Container(
                padding: EdgeInsets.only(
                  left: context.w(25),
                  right: context.w(25),
                  bottom: context.h(20),
                ),
                color: AppColors.primary,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.imageUrl ?? ''),
                      radius: context.r(24),
                    ),
                    SizedBox(width: context.w(16)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo ${user.name ?? "User"}!',
                          style: TextStyle(
                              color: Colors.white, fontSize: context.sp(18)),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.white70,
                              size: context.sp(16),
                            ),
                            SizedBox(width: context.w(4)),
                            const Text(
                              "Jum'at",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context.pushRoute(const EventListRoute());
                          },
                          child: Container(
                            padding: EdgeInsets.all(context.i(8)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(context.r(8)),
                            ),
                            child: Assets.icons.icNotif.svg(
                              width: context.w(20),
                              height: context.h(20),
                              colorFilter: ColorFilter.mode(
                                  AppColors.primary, BlendMode.srcIn),
                            ),
                          ),
                        ),
                        SizedBox(width: context.w(12)),
                        InkWell(
                          onTap: () {
                            context.pushRoute(const RoomRoute());
                          },
                          child: Container(
                            padding: EdgeInsets.all(context.i(8)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(context.r(8)),
                            ),
                            child: Assets.icons.icChat.svg(
                              width: context.w(20),
                              height: context.h(20),
                              colorFilter: ColorFilter.mode(
                                  AppColors.primary, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                padding: EdgeInsets.only(
                  left: context.w(25),
                  right: context.w(25),
                  bottom: context.h(20),
                ),
                color: AppColors.primary,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          const AssetImage('assets/images/app_logo.png'),
                      radius: context.r(24),
                    ),
                    SizedBox(width: context.w(16)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo User!',
                          style: TextStyle(
                              color: Colors.white, fontSize: context.sp(18)),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.white70,
                              size: context.sp(16),
                            ),
                            SizedBox(width: context.w(4)),
                            const Text(
                              "Jum'at, 25 Oktober 2024",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(context.i(8)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(context.r(8)),
                          ),
                          child: Assets.icons.icNotif.svg(
                            width: context.w(20),
                            height: context.h(20),
                            colorFilter: const ColorFilter.mode(
                                Color(0xFF3785FC), BlendMode.srcIn),
                          ),
                        ),
                        SizedBox(width: context.w(12)),
                        Container(
                          padding: EdgeInsets.all(context.i(8)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(context.r(8)),
                          ),
                          child: Assets.icons.icChat.svg(
                            width: context.w(20),
                            height: context.h(20),
                            colorFilter: const ColorFilter.mode(
                                Color(0xFF3785FC), BlendMode.srcIn),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

// Helper method to build tags
List<Widget> _buildTags(BuildContext context, List<String> tags) {
  return tags.map((tag) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.w(8), vertical: context.h(4)),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(context.r(4)),
      ),
      child: Text(
        tag,
        style: TextStyle(color: Colors.white, fontSize: context.sp(10)),
      ),
    );
  }).toList();
}
