import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:proo/features/home/presentation/cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

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
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var homeCubit = context.read<HomeCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Home Screen')),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            homeCubit.fetchHomeData();
            return const Center(child: Text('Loading...'));
          } else if (state is HomeLoading) {
            return Center(
              child: SizedBox(
                width: 120,
                height: 120,
                child: Lottie.asset(
                  'lib/assets/refresh.json', // ضع ملف اللوتي هناeas
                  fit: BoxFit.contain,
                ),
              ),
            );
          } else if (state is HomeLoaded) {
            if (_connectionStatus.isEmpty ||
                _connectionStatus.contains(ConnectivityResult.none)) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('No Internet'),
                    content: const Text(
                      'Please check your connection and try again.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              });
              return const SizedBox(); // أو رسالة بسيطة
            }
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                if (_connectionStatus.isEmpty ||
                    _connectionStatus.contains(ConnectivityResult.none)) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('No Internet'),
                      content: const Text(
                        'Please check your connection and try again.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            await homeCubit.fetchHomeData();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                  return Future.value();
                }
                await homeCubit.fetchHomeData();
              },
              child:
                  (state.homeData.products == null ||
                      state.homeData.products!.isEmpty)
                  ? const Center(child: Text('No products available'))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                      itemCount: state.homeData.products!.length,
                      itemBuilder: (context, index) {
                        final product = state.homeData.products![index];
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(product.title ?? ''),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            // title: Text(product.title ?? ''),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.network(
                                                  product.thumbnail ?? '',
                                                  scale: 0.8,
                                                ),
                                                // Text('\$${product.price}'),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Close'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Image.network(
                                        product.thumbnail ?? '',
                                      ),
                                    ),
                                    Text('\$${product.price}'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Card(
                            shadowColor: Color.fromARGB(255, 58, 36, 255),
                            color: const Color.fromARGB(255, 255, 255, 255),
                            elevation: 14,
                            child: Column(
                              children: [
                                Image.network(product.thumbnail ?? ''),
                                Text(
                                  product.title ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text('\$${product.price}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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
