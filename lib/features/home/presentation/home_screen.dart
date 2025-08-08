import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:proo/features/home/presentation/cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  final void Function(Locale)? onChangeLocale;
  const HomeScreen({super.key, this.onChangeLocale});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      status,
    ) {
      setState(() {
        _connectionStatus = status;
      });
    });
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!mounted) return;
      final state = context.read<HomeCubit>().state;
      if (state is HomeLoaded) {
        final productsLength = state.homeData.products?.length ?? 0;
        if (productsLength == 0) return;
        _currentPage = (_currentPage + 1) % productsLength;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var homeCubit = context.read<HomeCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.deepPurple,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
        ),
        title: Text(
          Localizations.localeOf(context).languageCode == 'ar'
              ? 'منتجاتنا'
              : 'Our Products',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language, color: Colors.white),
            onPressed: () {
              final newLocale =
                  Localizations.localeOf(context).languageCode == 'en'
                  ? const Locale('ar')
                  : const Locale('en');
              widget.onChangeLocale?.call(newLocale);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: Localizations.localeOf(context).languageCode == 'ar'
                ? 'تسجيل الخروج'
                : 'Logout',
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            homeCubit.fetchHomeData();
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoading) {
            return Center(
              child: SizedBox(
                width: 120,
                height: 120,
                child: Lottie.asset('assets/refresh.json', fit: BoxFit.contain),
              ),
            );
          } else if (state is HomeLoaded) {
            return Column(
              children: [
                SizedBox(
                  height: 140,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: state.homeData.products?.length ?? 0,
                        itemBuilder: (context, index) {
                          final product = state.homeData.products![index];
                          return Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.deepPurple.shade200,
                                  Colors.deepPurple.shade50,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      product.thumbnail ?? '',
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (
                                            context,
                                            error,
                                            stackTrace,
                                          ) => Image.network(
                                            'https://upload.wikimedia.org/wikipedia/commons/a/a9/Amazon_logo.svg',
                                            height: 60,
                                            width: 60,
                                            fit: BoxFit.contain,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(
                                                      Icons.image_not_supported,
                                                      size: 40,
                                                    ),
                                          ),
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: Text(
                                      product.title ?? '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemCount: state.homeData.products?.length ?? 0,
                    itemBuilder: (context, index) {
                      final product = state.homeData.products![index];
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  product.thumbnail ?? '',
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.network(
                                        'https://upload.wikimedia.org/wikipedia/commons/a/a9/Amazon_logo.svg',
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                                  Icons.image_not_supported,
                                                  size: 40,
                                                ),
                                      ),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                product.title ?? '',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                '${product.price} EGP',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minimumSize: const Size.fromHeight(32),
                                ),
                                icon: const Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                label: Text(
                                  Localizations.localeOf(
                                            context,
                                          ).languageCode ==
                                          'ar'
                                      ? 'أضف للسلة'
                                      : 'Add to Cart',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        Localizations.localeOf(
                                                  context,
                                                ).languageCode ==
                                                'ar'
                                            ? 'تمت الإضافة للسلة'
                                            : 'Added to cart',
                                      ),
                                      backgroundColor: Colors.deepPurple,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: state.homeData.products?.length ?? 0,
                    itemBuilder: (context, index) {
                      final product = state.homeData.products![index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade50,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.08),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                product.thumbnail ?? '',
                                height: 32,
                                width: 32,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.network(
                                      'https://upload.wikimedia.org/wikipedia/commons/a/a9/Amazon_logo.svg',
                                      height: 32,
                                      width: 32,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                                Icons.image_not_supported,
                                                size: 20,
                                              ),
                                    ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              product.title ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.deepPurple,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                Localizations.localeOf(context).languageCode ==
                                        'ar'
                                    ? 'عرض!'
                                    : 'Offer!',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is HomeError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 24, color: Colors.red),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
