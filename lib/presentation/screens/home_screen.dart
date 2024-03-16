import 'package:ayurveda/core/constants.dart';
import 'package:ayurveda/core/utils/app_colors.dart';
import 'package:ayurveda/presentation/provider/patient_provider.dart';
import 'package:ayurveda/presentation/widgets/app_space_widget.dart';
import 'package:ayurveda/presentation/widgets/input_decoration_widget.dart';
import 'package:ayurveda/presentation/widgets/notification_icon_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          await context.read<PatientProvider>().fetchPatients();
        },
        child: Consumer<PatientProvider>(
          builder: (context,snapshot,_) {
            if(snapshot.isLoading){
              return  Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64),
                  child: Lottie.asset('assets/lotties/loading.json'),
                ),
              );
            }
            
            return Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        floating: true,
                        surfaceTintColor: AppColors.white,
                        actions: const [
                          NotificationIconWidget(),
                        ],
                        bottom:snapshot.patients.isEmpty?null: PreferredSize(
                          preferredSize: const Size.fromHeight(130),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: TextField(
                                            decoration: inputDecoration(
                                              context,
                                              hintText: 'Search for treatments',
                                              filled: false,
                                              prefixIcon: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                ),
                                                child: SvgPicture.asset(
                                                  'assets/icons/search.svg',
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        setWidth(16),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: const Text('Search'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    setHeight(16),
                                    Row(
                                      children: [
                                        const Expanded(child: Text("Sort By : ")),
                                        setWidth(16),
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: () {},
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "Date",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Icon(
                                                      CupertinoIcons.chevron_down,
                                                      color: AppColors.primaryColor,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: AppColors.borderColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      snapshot.patients.isEmpty
                          ? SliverFillRemaining(
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Lottie.asset('assets/lotties/calender.json'),
                                    setHeight(16),
                                    Text(
                                      "No Registered Patients",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          :
                      SliverPadding(
                        padding: const EdgeInsets.all(16),
                        sliver: SliverList.separated(
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.cardColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      top: 16,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${index + 1}.",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            setWidth(8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${snapshot.patients[index].name}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                    ),
                                                    child: Text(
                                                      snapshot.patients[index].patientdetailsSet?.first.treatmentName??"N/A",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w100,
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SvgPicture.asset(
                                                            'assets/icons/uil--calender.svg',
                                                            height: 20,
                                                            width: 20,
                                                          ),
                                                          setWidth(4),
                                                          Text(
                                                            DateFormat("dd MMM yyyy").format(snapshot.patients[index].dateNdTime ?? DateTime.now()),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyLarge
                                                                ?.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      setWidth(16),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons
                                                                  .person_2,
                                                              color: AppColors
                                                                  .iconColor,
                                                            ),
                                                            setWidth(4),
                                                            Expanded(
                                                              child: Text(
                                                                "${snapshot.patients[index].user}",
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                                style:
                                                                    Theme.of(context)
                                                                        .textTheme
                                                                        .bodyLarge
                                                                        ?.copyWith(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w100,
                                                                        ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 16,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      bottom: 16,
                                    ),
                                    child: Row(
                                      children: [
                                        Visibility(
                                          visible: false,
                                          maintainSize: true,
                                          maintainAnimation: true,
                                          maintainState: true,
                                          child: Text(
                                            "${index + 1}.",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                        setWidth(8),
                                        Expanded(
                                          child: Text(
                                            "View Booking details",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w100,
                                                ),
                                          ),
                                        ),
                                        Icon(
                                          CupertinoIcons.chevron_right,
                                          color: AppColors.primaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: Colors.transparent,
                            );
                          },
                          itemCount: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      kNavigationKey.currentState?.pushNamed('/registration');
                    },
                    child: const Text("Register"),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
